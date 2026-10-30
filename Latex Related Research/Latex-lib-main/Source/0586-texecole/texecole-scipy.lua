local CALC_SCIPY = {}

local LOIS_PY = {
  norm    = { ctor = "stats.norm(%s, %s)",            discrete = false, np = 2 },
  binom   = { ctor = "stats.binom(int(%s), %s)",      discrete = true,  np = 2 },
  poisson = { ctor = "stats.poisson(%s)",             discrete = true,  np = 1 },
  uniform = { ctor = "stats.uniform(%s, (%s) - (%s))", discrete = false, np = 2, spread = true },
  expon   = { ctor = "stats.expon(scale=1.0/(%s))",   discrete = false, np = 1 },
  t       = { ctor = "stats.t(%s)",                   discrete = false, np = 1 },
  chi2    = { ctor = "stats.chi2(%s)",                discrete = false, np = 1 },
}

local OP_LATEX = {
  le = "\\leqslant", ge = "\\geqslant", eq = "=", lt = "<", gt = ">",
}

local function ctor_de(code, params)
  local def = LOIS_PY[code]
  if not def then
    return nil, "texecole : loi inconnue côté moteur : " .. tostring(code)
  end
  local p = {}
  for tok in params:gmatch("%S+") do p[#p + 1] = tok end
  if #p ~= def.np then
    return nil, "texecole : la loi « " .. code .. " » attend " .. def.np
      .. " paramètre" .. (def.np > 1 and "s" or "") .. ", " .. #p
      .. " donné" .. (#p > 1 and "s" or "") .. "."
  end
  if def.spread then
    return def.ctor:format(p[1], p[2], p[1]), def.discrete
  end
  return def.ctor:format(table.unpack(p)), def.discrete
end

return function(sl)
  if not sl then return CALC_SCIPY end

  local function run(script)
    return sl.sympy.run(script)
  end

  local PRE_SCIPY = [==[
try:
    from scipy import stats
    from scipy.optimize import brentq, curve_fit
    import numpy as np
except ImportError:
    print("TEXECOLE_SCIPY_ABSENT")
    raise SystemExit
]==]

  local function scipy_absent_ou(out, err)
    if not out then return nil, err end
    if out:find("TEXECOLE_SCIPY_ABSENT") then
      return nil, "texecole : SciPy n'est pas installé. Installez-le : "
        .. ((sl.sympy and sl.sympy.python_cmd) and sl.sympy.python_cmd() or "python3")
        .. " -m pip install scipy numpy."
    end
    return out
  end

  local function precision()
    local p = tonumber(sl.config and sl.config.precision)
    if p and p >= 0 then return p end
    return 3
  end

  local function montrer(val)
    local num = tonumber(val)
    local shown = num and string.format("%." .. precision() .. "f", num) or val
    if shown:find("%.") then
      shown = shown:gsub("0+$", ""):gsub("%.$", "")
    end
    return (shown:gsub("%.", "{,}"))
  end

  function CALC_SCIPY.prob(op, val, code, params)
    local ctor, discrete = ctor_de(code, params)
    if not ctor then return nil, discrete end
    local expr
    if discrete then
      local k = "int(" .. val .. ")"
      if     op == "le" then expr = "L.cdf(" .. k .. ")"
      elseif op == "ge" then expr = "L.sf(" .. k .. " - 1)"
      elseif op == "eq" then expr = "L.pmf(" .. k .. ")"
      elseif op == "lt" then expr = "L.cdf(" .. k .. " - 1)"
      elseif op == "gt" then expr = "L.sf(" .. k .. ")"
      end
    else
      if     op == "le" or op == "lt" then expr = "L.cdf(" .. val .. ")"
      elseif op == "ge" or op == "gt" then expr = "L.sf(" .. val .. ")"
      elseif op == "eq" then expr = "0.0"
      end
    end
    local out, err = run(PRE_SCIPY
      .. "L = " .. ctor .. "\n"
      .. "print(float(" .. expr .. "))\n")
    return scipy_absent_ou(out, err)
  end

  function CALC_SCIPY.quantile(p, code, params)
    local ctor, err0 = ctor_de(code, params)
    if not ctor then return nil, err0 end
    local out, err = run(PRE_SCIPY
      .. "L = " .. ctor .. "\n"
      .. "print(float(L.ppf(" .. p .. ")))\n")
    return scipy_absent_ou(out, err)
  end

  function CALC_SCIPY.moment(quoi, code, params)
    local ctor, err0 = ctor_de(code, params)
    if not ctor then return nil, err0 end
    local out, err = run(PRE_SCIPY
      .. "L = " .. ctor .. "\n"
      .. "print(float(L." .. (quoi == "mean" and "mean" or "std") .. "()))\n")
    return scipy_absent_ou(out, err)
  end

  function CALC_SCIPY.root(eq, a, b)
    local lhs, rhs = eq:match("^(.-)=(.+)$")
    if not lhs then
      return nil, "texecole : <Résous numériquement l'équation ...> attend "
        .. "une équation avec un signe =."
    end
    local script = PRE_SCIPY .. sl.sympy.PRE .. ([==[
x = symbols('x')
f = lambdify(x, lire("%s", x) - (lire("%s", x)), "numpy")
fa, fb = float(f(%s)), float(f(%s))
if fa == 0.0:
    print(%s)
elif fb == 0.0:
    print(%s)
elif fa * fb > 0:
    print("TEXECOLE_MEME_SIGNE")
else:
    print(float(brentq(f, %s, %s)))
]==]):format(lhs:gsub("%s+$", ""), rhs:gsub("^%s+", ""), a, b, a, b, a, b)
    local out, err = scipy_absent_ou(run(script))
    if not out then return nil, err end
    if out:find("TEXECOLE_MEME_SIGNE") then
      return nil, "texecole : sur [" .. a .. " ; " .. b .. "], l'expression "
        .. "garde le même signe aux deux bornes — la recherche numérique "
        .. "demande un intervalle où la fonction change de signe. "
        .. "Resserrez ou déplacez l'intervalle."
    end
    return out
  end

  function CALC_SCIPY.fit(model, fvar, data)
    local script = PRE_SCIPY .. sl.sympy.PRE .. ([==[
import re
%s = symbols('%s')
a, b, c, d = symbols('a b c d')
e = lire("%s", %s)
libres = sorted([s for s in e.free_symbols if str(s) in ('a','b','c','d')],
                key=lambda s: str(s))
if not libres:
    print("TEXECOLE_SANS_PARAMETRE")
    raise SystemExit
paires = re.findall(r"\(([^)]*)\)", "%s")
xs, ys = [], []
for p in paires:
    u, v = p.split(",")
    xs.append(float(u)); ys.append(float(v))
if len(xs) < len(libres) + 1:
    print("TEXECOLE_TROP_PEU_DE_POINTS")
    raise SystemExit
f = lambdify((%s, *libres), e, "numpy")
popt, _ = curve_fit(lambda X, *p: f(X, *p), np.array(xs), np.array(ys),
                    p0=[1.0] * len(libres), maxfev=20000)
print("M|" + latex(e))
print("P|" + " ".join("%%s=%%r" %% (str(s), float(v))
                      for s, v in zip(libres, popt)))
]==]):format(fvar, fvar, model, fvar, data, fvar)
    local out, err = scipy_absent_ou(run(script))
    if not out then return nil, err end
    if out:find("TEXECOLE_SANS_PARAMETRE") then
      return nil, "texecole : le modèle d'ajustement ne contient aucun "
        .. "paramètre libre — les paramètres reconnus sont a, b, c, d."
    end
    if out:find("TEXECOLE_TROP_PEU_DE_POINTS") then
      return nil, "texecole : l'ajustement demande au moins un point de "
        .. "plus que de paramètres."
    end
    local M = out:match("M|([^\n]*)")
    local Pp = out:match("P|([^\n]*)")
    if not (M and Pp) then
      return nil, "texecole : réponse SciPy inattendue :\n" .. out
    end
    return M, Pp
  end

  sl.register_block("scipyprob", function(api, words, content)
    local op, val, code, params = words:match("^(%S+)%s+(%S+)%s+(%S+)%s*(.*)$")
    local out, err = CALC_SCIPY.prob(op, val, code, params or "")
    if not out then error(err, 0) end
    api.lit("\\(P(X " .. (OP_LATEX[op] or "=") .. " "
      .. val:gsub("%.", "{,}") .. ") \\approx " .. montrer(out) .. "\\)")
  end)

  sl.register_block("scipyquantile", function(api, words, content)
    local p, code, params = words:match("^(%S+)%s+(%S+)%s*(.*)$")
    local out, err = CALC_SCIPY.quantile(p, code, params or "")
    if not out then error(err, 0) end
    api.lit("\\(x_{" .. p:gsub("%.", "{,}") .. "} \\approx "
      .. montrer(out) .. "\\)")
  end)

  sl.register_block("scipymoment", function(api, words, content)
    local quoi, code, params = words:match("^(%S+)%s+(%S+)%s*(.*)$")
    local out, err = CALC_SCIPY.moment(quoi, code, params or "")
    if not out then error(err, 0) end
    local tete = (quoi == "mean") and "E(X)" or "\\sigma(X)"
    api.lit("\\(" .. tete .. " \\approx " .. montrer(out) .. "\\)")
  end)

  sl.register_block("scipyroot", function(api, words, content)
    if type(content) == "table" then content = table.concat(content, "\n") end
    content = content:gsub("^%s+", ""):gsub("%s+$", "")
    local a, b = words:match("^(%S+)%s+(%S+)$")
    local out, err = CALC_SCIPY.root(content, a, b)
    if not out then error(err, 0) end
    api.lit("\\(x \\approx " .. montrer(out) .. "\\) (recherche sur \\(["
      .. a:gsub("%.", "{,}") .. "\\,;\\, " .. b:gsub("%.", "{,}")
      .. "]\\))")
  end)

  sl.register_block("scipyfit", function(api, words, content)
    if type(content) == "table" then content = table.concat(content, "\n") end
    local lines = {}
    for l in (content .. "\n"):gmatch("(.-)\n") do
      l = l:gsub("^%s+", ""):gsub("%s+$", "")
      if l ~= "" then lines[#lines + 1] = l end
    end
    local fname, fvar = words:match("^(%S+)%s+(%S+)$")
    if #lines < 2 then
      error("texecole : <Ajuste ...> attend le modèle puis les données.", 0)
    end
    local M, Pp = CALC_SCIPY.fit(lines[1], fvar or "x",
                                 table.concat(lines, " ", 2))
    if not M then error(Pp, 0) end
    local parts = {}
    for nom, val in Pp:gmatch("(%a)=(%S+)") do
      parts[#parts + 1] = nom .. " \\approx " .. montrer(val)
    end
    api.lit("\\(" .. (fname or "f") .. "(" .. (fvar or "x") .. ") = "
      .. M .. "\\) avec \\(" .. table.concat(parts, ",\\; ") .. "\\)")
  end)

  sl.scipy = CALC_SCIPY
  return CALC_SCIPY
end
