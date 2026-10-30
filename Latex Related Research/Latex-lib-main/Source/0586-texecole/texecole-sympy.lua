local CALC_SYMPY = {}
local M = require("texecole-math")

local _sleep
do
  local ok, socket = pcall(require, "socket")
  if ok and type(socket) == "table" and socket.sleep then
    _sleep = function(s) socket.sleep(s) end
  else
    _sleep = function(s) os.execute("sleep " .. s) end
  end
end

local memcache = {}
local CACHE_DIR = "_texecole-cache"
local cache_dir_ready = nil

local PRE = [==[
from sympy import *
from sympy.parsing.sympy_parser import (parse_expr,
    standard_transformations, implicit_multiplication_application,
    convert_xor)
_T = standard_transformations + (implicit_multiplication_application,
    convert_xor)
import re as _re
def _nth(s):
    while True:
        i = s.find('nthroot(')
        if i < 0:
            return s
        j = i + 8
        k = s.find(',', j)
        n = s[j:k].strip()
        depth = 1
        p = k + 1
        while p < len(s) and depth > 0:
            if s[p] == '(':
                depth += 1
            elif s[p] == ')':
                depth -= 1
            p += 1
        inner = s[k+1:p-1]
        s = s[:i] + '(real_root(' + inner + ', ' + n + '))' + s[p:]
def lire(s, v):
    s = _re.sub(r'(?<![A-Za-z_])racine\s*\[\s*(\d+)\s*\]\s*\(', r'nthroot(\1, ', s)
    s = _re.sub(r'(?<![A-Za-z_])sqrt\s*\[\s*(\d+)\s*\]\s*\(', r'nthroot(\1, ', s)
    s = _re.sub(r'(?<![A-Za-z_])racine\s*\(', 'sqrt(', s)
    s = _nth(s)
    s = _re.sub(r'\|([^|]+)\|', r'Abs(\1)', s)
    s = _re.sub(r'(?<![A-Za-z_])ent\(', 'floor(', s)
    s = _re.sub(r'(?<![A-Za-z_])E\(', 'floor(', s)
    return parse_expr(s, transformations=_T, local_dict={str(v): v})
]==]

CALC_SYMPY.PRE = PRE

local function to_sympy(expr)
  return (expr:gsub("%^", "**"))
end

local function to_moteur(expr)
  return (expr:gsub("%*%*", "^"):gsub("%f[%w]oo%f[%W]", "inf"))
end

CALC_SYMPY.to_sympy, CALC_SYMPY.to_moteur = to_sympy, to_moteur

local function hash(s)
  local h1, h2 = 5381, 52711
  for i = 1, #s do
    local b = s:byte(i)
    h1 = (h1 * 33 + b) % 4294967296
    h2 = (h2 * 31 + b) % 4294967296
  end
  return string.format("%08x%08x-%d", h1, h2, #s)
end

local function cache_path(script)
  if cache_dir_ready == nil then
    local ok, lfs = pcall(require, "lfs")
    if ok and lfs then
      local attr = lfs.attributes(CACHE_DIR)
      if attr and attr.mode == "directory" then
        cache_dir_ready = true
      else
        cache_dir_ready = lfs.mkdir(CACHE_DIR) and true or false
      end
    else
      cache_dir_ready = false
    end
  end
  if not cache_dir_ready then return nil end
  return CACHE_DIR .. "/" .. hash(script) .. ".txt"
end

local function cache_read(script)
  if memcache[script] then return memcache[script] end
  local p = cache_path(script)
  if not p then return nil end
  local f = io.open(p, "r")
  if not f then return nil end
  local out = f:read("*a")
  f:close()
  memcache[script] = out
  return out
end

local function cache_write(script, out)
  memcache[script] = out
  local p = cache_path(script)
  if not p then return end
  local f = io.open(p, "w")
  if f then f:write(out); f:close() end
end

local SERVEUR = [==[
import sys, os, time, io, contextlib, traceback, shutil
D = sys.argv[1]
dernier = time.time()
bat = 0.0
while True:
    t = time.time()
    if t - bat >= 0.5:
        with open(os.path.join(D, "vie.tmp"), "w") as f:
            f.write(str(t))
        os.replace(os.path.join(D, "vie.tmp"), os.path.join(D, "vie"))
        bat = t
    reqs = sorted(int(f[:-4]) for f in os.listdir(D) if f.endswith(".req"))
    if not reqs:
        if t - dernier > 120:
            break
        time.sleep(0.02)
        continue
    for k in reqs:
        base = os.path.join(D, str(k))
        try:
            os.remove(base + ".req")
        except OSError:
            continue
        buf = io.StringIO()
        try:
            src = open(base + ".py").read()
            with contextlib.redirect_stdout(buf):
                exec(src, {})
            out = buf.getvalue()
        except SystemExit:
            out = buf.getvalue()
        except Exception:
            out = buf.getvalue() + "\nTraceback\n" + traceback.format_exc()
        with open(base + ".tmp", "w") as f:
            f.write(out)
        os.replace(base + ".tmp", base + ".out")
        with open(base + ".done", "w") as f:
            f.write("1")
        dernier = time.time()
shutil.rmtree(D, ignore_errors=True)
]==]

local WORKER
local POINTEUR = CACHE_DIR .. "/worker-actif"
local LFS
do
  local ok, lfs = pcall(require, "lfs")
  if ok then LFS = lfs end
end

return function(sl)
  if not sl then return CALC_SYMPY end

  local function worker_vivant(dir)
    local attr = LFS.attributes(dir .. "/vie")
    return attr and (os.time() - attr.modification) <= 3
  end

  local function demarrer_worker(python)
    if WORKER ~= nil then return WORKER end
    WORKER = false
    if not cache_path("sonde") then return false end
    if not LFS then return false end

    local pf = io.open(POINTEUR, "r")
    if pf then
      local ancien = pf:read("*l")
      pf:close()
      if ancien and LFS.attributes(ancien) and worker_vivant(ancien) then
        WORKER = { dir = ancien, n = 0, reprise = true }
        return WORKER
      end
    end
    local dir = CACHE_DIR .. "/worker-" .. tostring(os.time() % 100000)
      .. "-" .. tostring(math.floor((os.clock() * 1e6) % 100000))
    if not LFS.mkdir(dir) then return false end
    local f = io.open(dir .. "/serveur.py", "w")
    if not f then return false end
    f:write(SERVEUR)
    f:close()
    local lance = os.execute(python .. " " .. dir .. "/serveur.py " .. dir
      .. " > " .. dir .. "/serveur.log 2>&1 &")
    if not lance then return false end
    local pf2 = io.open(POINTEUR, "w")
    if pf2 then pf2:write(dir); pf2:close() end
    WORKER = { dir = dir, n = 0 }
    return WORKER
  end

  local function worker_soumettre(python, script)
    local w = demarrer_worker(python)
    if not w then return nil end
    local base
    for _ = 1, 100000 do
      w.n = w.n + 1
      if LFS.mkdir(w.dir .. "/" .. w.n .. ".pris") then
        base = w.dir .. "/" .. w.n
        break
      end
    end
    if not base then WORKER = false; return nil end
    local f = io.open(base .. ".py", "w")
    if not f then WORKER = false; return nil end
    f:write(script)
    f:close()
    local g = io.open(base .. ".req", "w")
    if not g then WORKER = false; return nil end
    g:write("1")
    g:close()
    return base, w.n
  end

  local function worker_attendre(base, premiere)
    local attente = 0
    local pas = 0.02
    local limite = premiere and 30 or 90
    while attente < limite do
      local d = io.open(base .. ".done", "r")
      if d then
        d:close()
        local h = io.open(base .. ".out", "r")
        if not h then break end
        local out = h:read("*a")
        h:close()
        os.remove(base .. ".py"); os.remove(base .. ".out")
        os.remove(base .. ".done")
        if LFS then pcall(LFS.rmdir, base .. ".pris") end
        return out
      end
      _sleep(pas)
      attente = attente + pas
      if pas < 0.1 then pas = pas + 0.02 end
    end

    local reessayer = WORKER and WORKER.reprise
    os.remove(POINTEUR)
    WORKER = reessayer and nil or false
    return nil
  end

  local function worker_run(python, script)
    local base, n = worker_soumettre(python, script)
    if not base then return nil end
    return worker_attendre(base, n == 1)
  end

  local PENDING = {}
  local PREFETCH = false

  local PYTHON_TROUVE
  local function python_cmd()
    if PYTHON_TROUVE then return PYTHON_TROUVE end
    for _, cand in ipairs { "python3", "python", "py" } do
      local h = io.popen(cand .. " --version 2>&1")
      if h then
        local sortie = h:read("*a") or ""
        h:close()
        if sortie:find("Python%s+3") then
          PYTHON_TROUVE = cand
          return cand
        end
      end
    end
    PYTHON_TROUVE = "python3"
    return PYTHON_TROUVE
  end
  CALC_SYMPY.python_cmd = python_cmd

  local function run(script)
    local cached = cache_read(script)
    if cached then return cached end
    local python = python_cmd()

    if PREFETCH then
      if not PENDING[script] then
        PENDING[script] = worker_soumettre(python, script)
      end
      return nil, "texecole : préchargement en cours"
    end

    local via
    local attendu = PENDING[script]
    if attendu then
      PENDING[script] = nil
      via = worker_attendre(attendu, false)
    end
    if via == nil then
      via = worker_run(python, script)
    end
    if via ~= nil then
      local out = via:gsub("%s+$", "")
      if out:find("Traceback") or out:find("No module named") then
        if out:find("No module named") then
          return nil, "texecole : SymPy n'est pas installé pour « " .. python
            .. " ». Installez-le : " .. python .. " -m pip install sympy — "
            .. "sans SymPy, seuls les calculs automatiques manquent, le "
            .. "reste de texecole fonctionne intégralement."
        end
        return nil, "texecole : le calcul SymPy a échoué.\n"
          .. "Sortie de Python :\n" .. out
      end
      cache_write(script, out)
      return out
    end
    local base = os.tmpname()
    local inpath, outpath = base .. ".py", base .. ".out"
    local f = io.open(inpath, "w")
    if not f then
      return nil, "texecole : impossible d'écrire le fichier temporaire "
        .. "du calcul (droits du dossier ?)."
    end
    f:write(script)
    f:close()
    local cmd = python .. " " .. inpath .. " > " .. outpath .. " 2>&1"
    local ok = os.execute(cmd)
    local g = io.open(outpath, "r")
    local out = g and g:read("*a") or ""
    if g then g:close() end
    os.remove(inpath); os.remove(outpath); os.remove(base)
    out = out:gsub("%s+$", "")
    if (not ok) or out:find("Traceback") or out:find("command not found")
       or out:find("No module named") then
      if out:find("No module named") then
        return nil, "texecole : SymPy n'est pas installé pour « " .. python
          .. " ». Installez-le : " .. python .. " -m pip install sympy — "
          .. "sans SymPy, seuls les calculs automatiques manquent, le "
          .. "reste de texecole fonctionne intégralement."
      end
      return nil, "texecole : le calcul SymPy a échoué.\n"
        .. "Vérifiez : (1) python3 et sympy installés ; (2) la compilation "
        .. "avec --shell-escape (TeXstudio : Options > Configurer > "
        .. "Production, ajoutez --shell-escape à la commande LuaLaTeX).\n"
        .. "Sortie de Python :\n" .. out
    end
    cache_write(script, out)
    return out
  end

  CALC_SYMPY.run = run

  function CALC_SYMPY.prefetch_debut() PREFETCH = true end
  function CALC_SYMPY.prefetch_fin() PREFETCH = false end

  function CALC_SYMPY.eval(expr)
    return run(PRE
      .. "x, y, z, t, a, b, c, n = symbols('x y z t a b c n')\n"
      .. "print(" .. expr .. ")\n")
  end

  function CALC_SYMPY.variations(expr, var)
    var = var or "x"
    local script = (PRE .. [==[
%s = symbols('%s')
f = lire("%s", %s)
fp = simplify(diff(f, %s))
if fp == 0:
    print("TEXECOLE_ERREUR: fonction constante")
    raise SystemExit
sing = singularities(f, %s, domain=S.Reals)
if sing is S.EmptySet:
    poles = []
elif isinstance(sing, FiniteSet):
    poles = sorted([p for p in sing if p.is_real])
else:
    print("TEXECOLE_ERREUR: singularites non denombrables")
    raise SystemExit
zs = solveset(fp, %s, domain=S.Reals)
if zs is S.EmptySet:
    zeros = []
elif isinstance(zs, FiniteSet):
    zeros = sorted([z for z in zs if z.is_real and z not in poles])
else:
    print("TEXECOLE_ERREUR: zeros de la derivee non denombrables")
    raise SystemExit
pts = sorted(set(zeros) | set(poles))
bounds = [S.NegativeInfinity] + pts + [S.Infinity]
signs = []
for i in range(len(bounds) - 1):
    a_, b_ = bounds[i], bounds[i + 1]
    if a_ is S.NegativeInfinity and b_ is S.Infinity: m = 0
    elif a_ is S.NegativeInfinity: m = b_ - 1
    elif b_ is S.Infinity: m = a_ + 1
    else: m = (a_ + b_) / 2
    v = fp.subs(%s, m)
    if not v.is_comparable:
        v = v.evalf()
    signs.append("+" if v > 0 else "-")
def fmt(v):
    try:
        v = nsimplify(v)
    except Exception:
        pass
    return str(v)
row = [fmt(limit(f, %s, S.NegativeInfinity))]
dcells = []
for i, p in enumerate(pts):
    row.append("/" if signs[i] == "+" else "\\")
    dcells.append(signs[i])
    if p in poles:
        row.append(fmt(limit(f, %s, p, dir='-')))
        row.append("||")
        row.append(fmt(limit(f, %s, p, dir='+')))
        dcells.append("||")
    else:
        row.append(fmt(f.subs(%s, p)))
row.append("/" if signs[-1] == "+" else "\\")
row.append(fmt(limit(f, %s, S.Infinity)))
dcells.append(signs[-1])
pts_txt = ["-inf"] + [str(p) for p in pts] + ["+inf"]
print("X|" + " | ".join(pts_txt))
print("D|" + " | ".join(dcells))
print("V|" + " ".join(row))
]==]):format(var, var, expr, var, var, var, var, var, var, var, var, var, var)
    local out, err = run(script)
    if not out then return nil, err end
    if out:find("TEXECOLE_ERREUR") then
      if out:find("fonction constante") then
        return nil, "texecole : la fonction « " .. expr .. " » est constante ; "
          .. "il n'y a pas de variations à dresser."
      end
      return nil, "texecole : le calcul automatique n'a pas trouvé un "
        .. "nombre fini de points remarquables (zéros de la dérivée, "
        .. "valeurs interdites) pour « " .. expr .. " » — donnez les "
        .. "rangées à la main (x:, dérivée:, variations:)."
    end
    local rows = {}
    for line in (out .. "\n"):gmatch("(.-)\n") do
      local k, v = line:match("^(%u)|(.*)$")
      if k then rows[k] = to_moteur(v) end
    end
    if not (rows.X and rows.D and rows.V) then
      return nil, "texecole : réponse SymPy inattendue :\n" .. out
    end
    return { x = rows.X, deriv = rows.D, var = rows.V }
  end

  function CALC_SYMPY.signes(expr, var)
    var = var or "x"
    local script = (PRE .. [==[
%s = symbols('%s')
f = lire("%s", %s)
num, den = fraction(together(f))
zs = solveset(num, %s, domain=S.Reals)
ps = solveset(den, %s, domain=S.Reals)
def denombre(ens, quoi):
    if ens is S.EmptySet:
        return []
    if isinstance(ens, FiniteSet):
        return sorted([p for p in ens if p.is_real])
    print("TEXECOLE_ERREUR: " + quoi + " non denombrables")
    raise SystemExit
poles = denombre(ps, "valeurs interdites")
zeros = [z for z in denombre(zs, "zeros") if z not in poles]
pts = sorted(set(zeros) | set(poles))
bounds = [S.NegativeInfinity] + pts + [S.Infinity]
cells = []
for i in range(len(bounds) - 1):
    a_, b_ = bounds[i], bounds[i + 1]
    if a_ is S.NegativeInfinity and b_ is S.Infinity: m = 0
    elif a_ is S.NegativeInfinity: m = b_ - 1
    elif b_ is S.Infinity: m = a_ + 1
    else: m = (a_ + b_) / 2
    v = f.subs(%s, m)
    if not v.is_comparable:
        v = v.evalf()
    cells.append("+" if v > 0 else "-")
    if i < len(pts):
        cells.append("||" if pts[i] in poles else "0")
pts_txt = ["-inf"] + [str(p) for p in pts] + ["+inf"]
print("X|" + " | ".join(pts_txt))
print("S|" + " | ".join(cells))
]==]):format(var, var, expr, var, var, var, var)
    local out, err = run(script)
    if not out then return nil, err end
    if out:find("TEXECOLE_ERREUR") then
      return nil, "texecole : le calcul automatique n'a pas trouvé un "
        .. "nombre fini de zéros et de valeurs interdites pour « " .. expr
        .. " » — écrivez le tableau à la main avec la forme en bloc "
        .. "<signtab x:{...}>{ rangées }."
    end
    local rows = {}
    for line in (out .. "\n"):gmatch("(.-)\n") do
      local k, v = line:match("^(%u)|(.*)$")
      if k then rows[k] = to_moteur(v) end
    end
    if not (rows.X and rows.S) then
      return nil, "texecole : réponse SymPy inattendue :\n" .. out
    end
    return { x = rows.X, cells = rows.S }
  end

  function CALC_SYMPY.zeros(expr, var)
    var = var or "x"
    local out, err = run((PRE .. "%s = symbols('%s')\n"
      .. "zs = solveset(lire(\"%s\", %s), %s, domain=S.Reals)\n"
      .. "print(latex(zs))\n"):format(var, var, expr, var, var))
    if not out then return nil, err end
    return out
  end

  function CALC_SYMPY.nroots(n, expr)
    local out, err = run((PRE .. "z = symbols('z')\n"
      .. "w = lire(\"%s\", z)\n"
      .. "r0 = Pow(w, Rational(1, %d))\n"
      .. "rs = FiniteSet(*[simplify(r0 * exp(2*I*pi*k/%d)) for k in range(%d)])\n"
      .. "print(latex(rs))\n"):format(expr, n, n, n))
    if not out then return nil, err end
    return out
  end

  function CALC_SYMPY.primitive(expr, var)
    var = var or "x"
    local out, err = run((PRE .. "%s = symbols('%s')\n"
      .. "print(latex(integrate(lire(\"%s\", %s), %s)))\n")
      :format(var, var, expr, var, var))
    if not out then return nil, err end
    return out
  end

  function CALC_SYMPY.expand(expr)
    local out, err = run((PRE .. "x, y, z, t, a, b, c = symbols('x y z t a b c')\n"
      .. "print(latex(expand(lire(\"%s\", x))))\n"):format(expr))
    if not out then return nil, err end
    return out
  end

  function CALC_SYMPY.apart(expr, var)
    var = var or "x"
    local out, err = run((PRE .. "%s = symbols('%s')\n"
      .. "print(latex(apart(lire(\"%s\", %s), %s)))\n")
      :format(var, var, expr, var, var))
    if not out then return nil, err end
    return out
  end

  function CALC_SYMPY.pde(eq, f)
    f = f or "u"
    local lhs, rhs = eq:match("^(.-)=(.+)$")
    if not lhs then
      return nil, "texecole : l'équation aux dérivées partielles demande un signe =."
    end
    local script = PRE .. ([==[
x, y = symbols('x y')
%s = Function('%s')
_d = {'x': x, 'y': y, '%s': %s, 'Derivative': Derivative}
l = parse_expr("%s", transformations=_T, local_dict=_d)
r = parse_expr("%s", transformations=_T, local_dict=_d)
try:
    print(latex(pdsolve(Eq(l, r), %s(x, y))))
except NotImplementedError:
    print("TEXECOLE_EDP_NON_RESOLUBLE")
]==]):format(f, f, f, f, lhs:gsub("%s+$", ""), rhs:gsub("^%s+", ""), f)
    local out, err = run(script)
    if not out then return nil, err end
    if out:find("TEXECOLE_EDP_NON_RESOLUBLE") then
      return nil, "texecole : cette équation aux dérivées partielles dépasse "
        .. "le résoluble symboliquement (SymPy traite le premier ordre "
        .. "linéaire) — les EDP d'ordre supérieur relèvent du numérique."
    end
    return out
  end

  function CALC_SYMPY.ode(eq, f, var)
    f = f or "y"
    var = var or "x"
    local lhs, rhs = eq:match("^(.-)=(.+)$")
    if not lhs then
      return nil, "texecole : l'équation différentielle demande un signe =."
    end
    local script = PRE .. ([==[
%s = symbols('%s')
%s = Function('%s')
_d = {'%s': %s, '%s': %s, 'Derivative': Derivative}
l = parse_expr("%s", transformations=_T, local_dict=_d)
r = parse_expr("%s", transformations=_T, local_dict=_d)
print(latex(dsolve(Eq(l, r), %s(%s))))
]==]):format(var, var, f, f, var, var, f, f,
             lhs:gsub("%s+$", ""), rhs:gsub("^%s+", ""), f, var)
    local out, err = run(script)
    if not out then return nil, err end
    return out
  end

  function CALC_SYMPY.eigen(rows_py)
    local script = PRE .. [==[
x, y, z, t, a, b, c, n = symbols('x y z t a b c n')
M = Matrix(]==] .. rows_py .. [==[)
if not M.is_square:
    print("TEXECOLE_NON_CARREE")
    raise SystemExit
ev = M.eigenvals()
parts = []
for v in sorted(ev.keys(), key=default_sort_key):
    s = latex(nsimplify(v))
    if ev[v] > 1: s += r"\;(\times %d)" % ev[v]
    parts.append(s)
print(r"\left\{" + r",\ ".join(parts) + r"\right\}")
]==]
    local out, err = run(script)
    if not out then return nil, err end
    if out:find("TEXECOLE_NON_CARREE") then
      return nil, "texecole : les valeurs propres demandent une matrice carrée."
    end
    return out
  end

  function CALC_SYMPY.diagonalize(rows_py)
    local script = PRE .. [==[
x, y, z, t, a, b, c, n = symbols('x y z t a b c n')
M = Matrix(]==] .. rows_py .. [==[)
if not M.is_square:
    print("TEXECOLE_NON_CARREE")
    raise SystemExit
if not M.is_diagonalizable():
    print("TEXECOLE_NON_DIAGONALISABLE")
    raise SystemExit
P_, D_ = M.diagonalize()
print("P|" + latex(P_))
print("D|" + latex(D_))
]==]
    local out, err = run(script)
    if not out then return nil, err end
    if out:find("TEXECOLE_NON_CARREE") then
      return nil, "texecole : la diagonalisation demande une matrice carrée."
    end
    if out:find("TEXECOLE_NON_DIAGONALISABLE") then
      return nil, "texecole : la matrice n'est pas diagonalisable (sur CC)."
    end
    local P_ = out:match("P|([^\n]*)")
    local D_ = out:match("D|([^\n]*)")
    if not (P_ and D_) then
      return nil, "texecole : réponse SymPy inattendue :\n" .. out
    end
    return P_, D_
  end

  function CALC_SYMPY.closed_sum(kind, expr, var, a, b)
    local op = (kind == "prod") and "product" or "summation"
    local head = (kind == "prod") and "Product" or "Sum"
    local script = PRE .. ([==[
%s = symbols('%s', integer=True)
x, y, z, t, n, p, q = symbols('x y z t n p q')
e = lire("%s", %s)
res = simplify(factor(%s(e, (%s, %s, %s))))
print("S|" + latex(%s(e, (%s, %s, %s))))
print("R|" + latex(res))
]==]):format(var, var, expr, var, op, var, a, b, head, var, a, b)
    local out, err = run(script)
    if not out then return nil, err end
    local S = out:match("S|([^\n]*)")
    local R = out:match("R|([^\n]*)")
    if not (S and R) then
      return nil, "texecole : réponse SymPy inattendue :\n" .. out
    end
    return S, R
  end

  function CALC_SYMPY.canonical(expr, var)
    var = var or "x"
    local script = PRE .. ([==[
%s = symbols('%s')
e = lire("%s", %s)
p = Poly(e, %s)
if p.degree() != 2:
    print("TEXECOLE_PAS_DEGRE_2")
    raise SystemExit
a_, b_, c_ = p.all_coeffs()
h = nsimplify(-b_ / (2*a_))
k_ = nsimplify(c_ - b_**2 / (4*a_))
print(latex(a_ * (%s - h)**2 + k_))
]==]):format(var, var, expr, var, var, var)
    local out, err = run(script)
    if not out then return nil, err end
    if out:find("TEXECOLE_PAS_DEGRE_2") then
      return nil, "texecole : la forme canonique est celle du trinôme du "
        .. "second degré — l'expression donnée n'est pas de degré 2."
    end
    return out
  end

  function CALC_SYMPY.nintegrate(expr, var, a, b)
    var = var or "x"
    local script = PRE .. ([==[
try:
    from scipy.integrate import quad
except ImportError:
    print("TEXECOLE_SCIPY_ABSENT")
    raise SystemExit
%s = symbols('%s')
f = lambdify(%s, lire("%s", %s), "math")
val, err = quad(f, %s, %s)
print(val)
]==]):format(var, var, var, expr, var, a, b)
    local out, e = run(script)
    if not out then return nil, e end
    if out:find("TEXECOLE_SCIPY_ABSENT") then
      return nil, "texecole : SciPy n'est pas installé. Installez-le : "
        .. python_cmd()
        .. " -m pip install scipy — l'intégrale numérique en a besoin."
    end
    return out
  end

  function CALC_SYMPY.limite(expr, var, point, dir)
    var = var or "x"
    local pt = point:gsub("infini", "oo")
    local d = dir == "droite" and ", dir='+'" or dir == "gauche" and ", dir='-'" or ""
    local out, err = run((PRE .. "%s = symbols('%s')\n"
      .. "print(latex(limit(lire(\"%s\", %s), %s, %s%s)))\n")
      :format(var, var, expr, var, var, pt, d))
    if not out then return nil, err end
    return out
  end

  function CALC_SYMPY.dl(expr, var, a, n)
    var = var or "x"
    local out, err = run((PRE .. "%s = symbols('%s')\n"
      .. "print(latex(series(lire(\"%s\", %s), %s, %s, %d).removeO()))\n")
      :format(var, var, expr, var, var, a, n + 1))
    if not out then return nil, err end
    local h = (a == "0") and var or ("(" .. var .. " - " .. a .. ")")
    return out .. " + o\\left(" .. h .. "^{" .. n .. "}\\right)"
  end

  function CALC_SYMPY.factor(expr)
    return run(PRE .. "x, y, z, t, a, b, c, n = symbols('x y z t a b c n')\n"
      .. "print(latex(factor(lire(\"" .. expr .. "\", x))))\n")
  end

  function CALC_SYMPY.simplify_expr(expr)
    return run(PRE .. "x, y, z, t, a, b, c, n = symbols('x y z t a b c n')\n"
      .. "print(latex(simplify(lire(\"" .. expr .. "\", x))))\n")
  end

  function CALC_SYMPY.solve_eq(lhs, rhs, var, domain)
    var = var or "x"
    domain = domain or "Reals"
    return run((PRE .. "%s = symbols('%s')\n"
      .. "print(latex(solveset(lire(\"%s\", %s) - (lire(\"%s\", %s)), %s, domain=S.%s)))\n")
      :format(var, var, lhs, var, rhs, var, var, domain))
  end

  local function rows_to_py(rows)
    local pyrows = {}
    for _, r in ipairs(rows) do
      local cells = {}
      for c in (r .. ";"):gmatch("(.-);") do
        c = c:gsub("^%s+", ""):gsub("%s+$", "")
        if c ~= "" then cells[#cells + 1] = "lire(\"" .. c .. "\", x)" end
      end
      pyrows[#pyrows + 1] = "[" .. table.concat(cells, ", ") .. "]"
    end
    return "[" .. table.concat(pyrows, ", ") .. "]"
  end

  CALC_SYMPY.rows_to_py = rows_to_py

  function CALC_SYMPY.matrix_op(rows, op)
    local body
    if op == "det" then
      body = "print(latex(nsimplify(M.det())))"
    elseif op == "inv" then
      body = ("if M.det() == 0:\n    print('TEXECOLE_NON_INVERSIBLE')\n"
        .. "else:\n    print(latex(M.inv()))")
    else
      body = "print(latex(M))"
    end
    local out, err = run(PRE
      .. "x, y, z, t, a, b, c, n = symbols('x y z t a b c n')\n"
      .. "M = Matrix(" .. rows_to_py(rows) .. ")\n" .. body .. "\n")
    if not out then return nil, err end
    if out:find("TEXECOLE_NON_INVERSIBLE") then
      return nil, "texecole : la matrice n'est pas inversible (déterminant nul)."
    end
    return out
  end

  function CALC_SYMPY.derivative(expr, var, order)
    var = var or "x"; order = order or 1
    local out, err = run((PRE .. "%s = symbols('%s')\n"
      .. "print(latex(simplify(diff(lire(\"%s\", %s), %s, %d))))\n")
      :format(var, var, expr, var, var, order))
    if not out then return nil, err end
    return out
  end

  local function frdec(s)
    if type(s) ~= "string" then return s end
    return (s:gsub("(%d)%.(%d)", "%1{,}%2"))
  end

  local function arrondir_nombres(s, prec)
    return (s:gsub("%-?%d+%.%d+", function(num)
      local n = tonumber(num)
      if not n then return num end
      local shown = string.format("%." .. prec .. "f", n)
      shown = shown:gsub("0+$", ""):gsub("%.$", "")
      return shown
    end))
  end

  local function content_str(content)
    if type(content) == "table" then content = table.concat(content, "\n") end
    return content:gsub("^%s+", ""):gsub("%s+$", "")
  end

  local function content_rows(content)
    if type(content) == "table" then content = table.concat(content, "\n") end
    local rows = {}
    for l in (content .. "\n"):gmatch("(.-)\n") do
      l = l:gsub("^%s+", ""):gsub("%s+$", "")
      if l ~= "" then rows[#rows + 1] = l end
    end
    return rows
  end

  sl.register_block("sympyderiv", function(api, words, content)
    content = content_str(content)
    local name, order, var = words:match("^(%S+)%s+(%d+)%s+(%S+)$")
    if not name then
      name, var = words:match("^(%S+)%s+(%S+)$"); order = "1"
    end
    local latex, err = CALC_SYMPY.derivative(content, var or "x",
                                             tonumber(order) or 1)
    if not latex then error(err, 0) end
    local primes = string.rep("'", tonumber(order) or 1)
    api.lit("\\(" .. (name or "f") .. primes .. "(" .. (var or "x")
        .. ") = " .. frdec(latex) .. "\\)")
  end)

  sl.register_block("sympyzeros", function(api, words, content)
    content = content_str(content)
    local nom, var = words:match("^(%S+)%s+(%S+)$")
    var = var or "x"
    local latex, err = CALC_SYMPY.zeros(content, var)
    if not latex then error(err, 0) end
    local prec = tonumber(sl.config and sl.config.precision) or 3
    if prec < 0 then prec = 3 end
    latex = arrondir_nombres(latex, prec)
    local indice = nom and ("_{" .. nom .. "}") or ""
    api.lit("\\(\\mathcal{S}" .. indice .. " = " .. frdec(latex) .. "\\)")
  end)

  sl.register_block("sympynroots", function(api, words, content)
    content = content_str(content)
    local n = tonumber(words:match("^(%d+)")) or 2
    local latex, err = CALC_SYMPY.nroots(n, content)
    if not latex then error(err, 0) end
    api.lit("\\(\\mathcal{S} = " .. frdec(latex) .. "\\)")
  end)

  sl.register_block("sympyprim", function(api, words, content)
    content = content_str(content)
    local var = words:match("^%S+%s+(%S+)$") or "x"
    local latex, err = CALC_SYMPY.primitive(content, var)
    if not latex then error(err, 0) end
    api.lit("\\(\\displaystyle\\int " .. (words:match("^(%S+)") or "f")
      .. "(" .. var .. ")\\,\\mathrm{d}" .. var .. " = "
      .. frdec(latex) .. " + C\\)")
  end)

  sl.register_block("sympyexpand", function(api, words, content)
    content = content_str(content)
    local latex, err = CALC_SYMPY.expand(content)
    if not latex then error(err, 0) end
    api.lit("\\(" .. frdec(M.mathlite(content)) .. " = " .. frdec(latex) .. "\\)")
  end)

  sl.register_block("sympyapart", function(api, words, content)
    content = content_str(content)
    local latex, err = CALC_SYMPY.apart(content, "x")
    if not latex then error(err, 0) end
    api.lit("\\(" .. frdec(latex) .. "\\)")
  end)

  sl.register_block("sympyode", function(api, words, content)
    content = content_str(content)
    local f, var = words:match("^(%S+)%s+(%S+)$")
    if not f then f = words:match("^(%S+)") or "y" end
    local latex, err = CALC_SYMPY.ode(content, f, var)
    if not latex then error(err, 0) end
    api.lit("\\(" .. frdec(latex) .. "\\)")
  end)

  sl.register_block("sympypde", function(api, words, content)
    content = content_str(content)
    local f = words:match("^(%S+)") or "u"
    local latex, err = CALC_SYMPY.pde(content, f)
    if not latex then error(err, 0) end
    api.lit("\\(" .. frdec(latex) .. "\\)")
  end)

  sl.register_block("sympyeigen", function(api, words, content)
    local rows = content_rows(content)
    local latex, err = CALC_SYMPY.eigen(rows_to_py(rows))
    if not latex then error(err, 0) end
    api.lit("\\(\\operatorname{Sp}(" .. (words:match("^(%S+)") or "M")
      .. ") = " .. frdec(latex) .. "\\)")
  end)

  sl.register_block("sympydiag", function(api, words, content)
    local rows = content_rows(content)
    local P_, D_ = CALC_SYMPY.diagonalize(rows_to_py(rows))
    if not P_ then error(D_, 0) end
    local nom = words:match("^(%S+)") or "M"
    api.lit("\\(" .. nom .. " = P D P^{-1}\\) avec \\(P = " .. frdec(P_)
      .. "\\) et \\(D = " .. frdec(D_) .. "\\)")
  end)

  sl.register_block("sympysum", function(api, words, content)
    content = content_str(content)
    local var, a, b = words:match("^(%S+)%s+(%S+)%s+(%S+)$")
    local S, R = CALC_SYMPY.closed_sum("sum", content, var, a, b)
    if not S then error(R, 0) end
    api.lit("\\(\\displaystyle " .. frdec(S) .. " = " .. frdec(R) .. "\\)")
  end)

  sl.register_block("sympyprod", function(api, words, content)
    content = content_str(content)
    local var, a, b = words:match("^(%S+)%s+(%S+)%s+(%S+)$")
    local S, R = CALC_SYMPY.closed_sum("prod", content, var, a, b)
    if not S then error(R, 0) end
    api.lit("\\(\\displaystyle " .. frdec(S) .. " = " .. frdec(R) .. "\\)")
  end)

  sl.register_block("sympycanon", function(api, words, content)
    content = content_str(content)
    local latex, err = CALC_SYMPY.canonical(content, "x")
    if not latex then error(err, 0) end
    api.lit("\\(" .. frdec(M.mathlite(content)) .. " = " .. frdec(latex) .. "\\)")
  end)

  sl.register_block("sympynint", function(api, words, content)
    content = content_str(content)
    local name, var, a, b = words:match("^(%S+)%s+(%S+)%s+(%S+)%s+(%S+)$")
    local val, err = CALC_SYMPY.nintegrate(content, var, a, b)
    if not val then error(err, 0) end
    local prec = tonumber(sl.config and sl.config.precision) or 3
    if prec < 0 then prec = 3 end
    local num = tonumber(val)
    local shown = num and string.format("%." .. prec .. "f", num) or val
    shown = shown:gsub("0+$", ""):gsub("%.$", "")
    shown = shown:gsub("%.", "{,}")
    api.lit("\\(\\displaystyle\\int_{" .. a .. "}^{" .. b .. "} "
      .. (name or "f") .. "(" .. var .. ")\\,\\mathrm{d}" .. var
      .. " \\approx " .. shown .. "\\)")
  end)

  local function bloc_expr(nom, calc, prefixe)
    sl.register_block(nom, function(api, words, content)
      content = content_str(content)
      local latex, err = calc(content, words)
      if not latex then error(err, 0) end
      api.lit("\\(" .. prefixe(content, words) .. frdec(latex) .. "\\)")
    end)
  end

  bloc_expr("sympyfactor", function(c) return CALC_SYMPY.factor(c) end,
    function(c) return frdec(M.mathlite(c)) .. " = " end)
  bloc_expr("sympysimplify", function(c) return CALC_SYMPY.simplify_expr(c) end,
    function(c) return frdec(M.mathlite(c)) .. " = " end)

  sl.register_block("sympylimit", function(api, words, content)
    content = content_str(content)
    local name, var, pt, dir = words:match("^(%S+)%s+(%S+)%s+(%S+)%s*(%S*)$")
    local latex, err = CALC_SYMPY.limite(content, var, pt, dir ~= "" and dir or nil)
    if not latex then error(err, 0) end
    local ptx = pt:gsub("infini", "\\infty"):gsub("%+\\infty", "+\\infty")
    local sub = var .. " \\to " .. ptx
      .. (dir == "droite" and "^{+}" or dir == "gauche" and "^{-}" or "")
    api.lit("\\(\\displaystyle\\lim_{" .. sub .. "} " .. (name or "f")
      .. "(" .. var .. ") = " .. frdec(latex) .. "\\)")
  end)

  sl.register_block("sympydl", function(api, words, content)
    content = content_str(content)
    local name, var, a, n = words:match("^(%S+)%s+(%S+)%s+(%S+)%s+(%d+)$")
    local latex, err = CALC_SYMPY.dl(content, var, a, tonumber(n))
    if not latex then error(err, 0) end
    api.lit("\\(" .. (name or "f") .. "(" .. var .. ") = " .. frdec(latex) .. "\\)")
  end)

  sl.register_block("sympysolveeq", function(api, words, content)
    content = content_str(content)
    local lhs, rhs = content:match("^(.-)=(.+)$")
    if not lhs then error("texecole : <Résous l'équation ...> attend une équation avec un signe =.", 0) end
    local domain = words:match("^(%S+)")
    local latex, err = CALC_SYMPY.solve_eq(lhs, rhs, "x", domain)
    if not latex then error(err, 0) end
    api.lit("\\(\\mathcal{S} = " .. frdec(latex) .. "\\)")
  end)

  function CALC_SYMPY.convexite(expr, var)
    var = var or "x"
    local script = (PRE .. [==[
%s = symbols('%s')
f = lire("%s", %s)
f2 = simplify(diff(f, %s, 2))
num, den = fraction(together(f2))
zs = solveset(num, %s, domain=S.Reals)
ps = solveset(den, %s, domain=S.Reals)
def denombre(ens, quoi):
    if ens is S.EmptySet:
        return []
    if isinstance(ens, FiniteSet):
        return sorted([p for p in ens if p.is_real])
    print("TEXECOLE_ERREUR: " + quoi + " non denombrables")
    raise SystemExit
poles = denombre(ps, "valeurs interdites")
zeros = [z for z in denombre(zs, "zeros") if z not in poles]
pts = sorted(set(zeros) | set(poles))
bounds = [S.NegativeInfinity] + pts + [S.Infinity]
cells = []
signs = []
for i in range(len(bounds) - 1):
    a_, b_ = bounds[i], bounds[i + 1]
    if a_ is S.NegativeInfinity and b_ is S.Infinity: m = 0
    elif a_ is S.NegativeInfinity: m = b_ - 1
    elif b_ is S.Infinity: m = a_ + 1
    else: m = (a_ + b_) / 2
    v = f2.subs(%s, m)
    if not v.is_comparable:
        v = v.evalf()
    signs.append(1 if v > 0 else -1)
    cells.append("+" if v > 0 else "-")
    if i < len(pts):
        cells.append("||" if pts[i] in poles else "0")
infl = []
for i, p in enumerate(pts):
    if p not in poles and signs[i] * signs[i + 1] < 0:
        infl.append(p)
print("F2|" + latex(f2))
print("X|" + " | ".join(["-inf"] + [str(p) for p in pts] + ["+inf"]))
print("S|" + " | ".join(cells))
print("I|" + " ; ".join(latex(p) for p in infl))
]==]):format(var, var, expr, var, var, var, var, var)
    local out, err = run(script)
    if not out then return nil, err end
    if out:find("TEXECOLE_ERREUR") then
      return nil, "texecole : le calcul de convexité n'a pas trouvé un "
        .. "nombre fini de zéros et de valeurs interdites pour la dérivée "
        .. "seconde de « " .. expr .. " »."
    end
    local rows = {}
    for line in (out .. "\n"):gmatch("(.-)\n") do
      local k, v = line:match("^(%u%d?)|(.*)$")
      if k then rows[k] = v end
    end
    if not (rows.F2 and rows.X and rows.S) then
      return nil, "texecole : réponse SymPy inattendue :\n" .. out
    end
    return { f2 = rows.F2, x = to_moteur(rows.X),
             cells = to_moteur(rows.S), infl = rows.I or "" }
  end

  function CALC_SYMPY.asymptotes(expr, var)
    var = var or "x"
    local script = (PRE .. [==[
%s = symbols('%s')
f = lire("%s", %s)
def au_bord(signe, tag):
    L = limit(f, %s, signe * S.Infinity)
    if L.is_finite:
        print("H" + tag + "|" + latex(L))
        return
    a = limit(f / %s, %s, signe * S.Infinity)
    if a.is_finite and a != 0:
        b = limit(f - a * %s, %s, signe * S.Infinity)
        if b.is_finite:
            print("O" + tag + "|" + latex(a) + "|" + latex(b))
au_bord(1, "P")
au_bord(-1, "M")
num, den = fraction(together(f))
ps = solveset(den, %s, domain=S.Reals)
if isinstance(ps, FiniteSet):
    for p in sorted([q for q in ps if q.is_real]):
        Lg = limit(f, %s, p, dir='-')
        Ld = limit(f, %s, p, dir='+')
        if Lg.is_infinite or Ld.is_infinite:
            print("V|" + latex(p))
]==]):format(var, var, expr, var, var, var, var, var, var, var, var, var)
    local out, err = run(script)
    if not out then return nil, err end
    local res = { v = {} }
    for line in (out .. "\n"):gmatch("(.-)\n") do
      local hp = line:match("^HP|(.*)$")
      local hm = line:match("^HM|(.*)$")
      local oa, ob = line:match("^OP|(.-)|(.*)$")
      local ma, mb = line:match("^OM|(.-)|(.*)$")
      local v = line:match("^V|(.*)$")
      if hp then res.hp = hp end
      if hm then res.hm = hm end
      if oa then res.op = { a = oa, b = ob } end
      if ma then res.om = { a = ma, b = mb } end
      if v then res.v[#res.v + 1] = v end
    end
    return res
  end

  function CALC_SYMPY.matrix_pow(rows, n)
    local out, err = run(PRE
      .. "x, y, z, t, a, b, c = symbols('x y z t a b c')\n"
      .. "M = Matrix(" .. rows_to_py(rows) .. ")\n"
      .. "if not M.is_square:\n    print('TEXECOLE_NON_CARREE')\n"
      .. "else:\n    print(latex(M**" .. n .. "))\n")
    if not out then return nil, err end
    if out:find("TEXECOLE_NON_CARREE") then
      return nil, "texecole : la puissance demande une matrice carrée."
    end
    return out
  end

  function CALC_SYMPY.markov_stable(rows)
    local out, err = run(PRE .. [==[
x, y, z, t, a, b, c = symbols('x y z t a b c')
M = Matrix(]==] .. rows_to_py(rows) .. [==[)
if not M.is_square:
    print("TEXECOLE_NON_CARREE")
    raise SystemExit
k = M.rows
for i in range(k):
    if simplify(sum(M.row(i)) - 1) != 0:
        print("TEXECOLE_NON_STOCHASTIQUE")
        raise SystemExit
ns = (M.T - eye(k)).nullspace()
if len(ns) != 1:
    print("TEXECOLE_PAS_UNIQUE")
    raise SystemExit
v = ns[0]
s = sum(v)
if s == 0:
    print("TEXECOLE_PAS_UNIQUE")
    raise SystemExit
pi = (v / s).T
print(latex(simplify(pi)))
]==])
    if not out then return nil, err end
    if out:find("TEXECOLE_NON_CARREE") then
      return nil, "texecole : l'état stable demande une matrice carrée."
    end
    if out:find("TEXECOLE_NON_STOCHASTIQUE") then
      return nil, "texecole : la matrice n'est pas une matrice de "
        .. "transition — chaque ligne doit sommer à 1."
    end
    if out:find("TEXECOLE_PAS_UNIQUE") then
      return nil, "texecole : la matrice n'admet pas un unique état stable."
    end
    return out
  end

  local function intervalles_convexite(xs, cells)
    local pts = {}
    for p in (xs .. " | "):gmatch("(.-)%s*|%s*") do
      p = p:gsub("^%s+", "")
      if p ~= "" then pts[#pts + 1] = p end
    end
    local signs, seps = {}, {}
    for c in (cells .. " | "):gmatch("(.-)%s*|%s*") do
      c = c:gsub("^%s+", "")
      if c == "+" or c == "-" then signs[#signs + 1] = c
      elseif c ~= "" then seps[#signs] = c end
    end
    local function borne(p)
      if p == "-inf" then return "-\\infty" end
      if p == "+inf" or p == "inf" then return "+\\infty" end
      return M.mathlite(p)
    end
    local conv, conc = {}, {}
    for k, s in ipairs(signs) do
      local a, b = pts[k], pts[k + 1]
      local ga = (a == "-inf" or seps[k - 1] == "||") and "]" or "["
      local gb = (b == "+inf" or b == "inf" or seps[k] == "||") and "[" or "]"
      local iv = "\\left" .. ga .. " " .. borne(a) .. "\\,;\\, "
               .. borne(b) .. " \\right" .. gb
      if s == "+" then conv[#conv + 1] = iv else conc[#conc + 1] = iv end
    end
    return conv, conc
  end

  sl.register_block("sympyconvex", function(api, words, content)
    content = content_str(content)
    local nom, var = words:match("^(%S+)%s+(%S+)$")
    nom, var = nom or "f", var or "x"
    local r, err = CALC_SYMPY.convexite(content, var)
    if not r then error(err, 0) end
    local conv, conc = intervalles_convexite(r.x, r.cells)
    local L = { "\\(" .. nom .. "''(" .. var .. ") = " .. frdec(r.f2) .. "\\)." }
    if #conv > 0 then
      L[#L + 1] = "\\par La fonction est convexe sur \\("
        .. table.concat(conv, " \\cup ") .. "\\)"
        .. (#conc > 0 and "" or ".")
    end
    if #conc > 0 then
      L[#L + 1] = (#conv > 0 and " et concave sur \\(" or
        "\\par La fonction est concave sur \\(")
        .. table.concat(conc, " \\cup ") .. "\\)."
    end
    if r.infl ~= "" then
      local n = select(2, r.infl:gsub(";", "")) + 1
      L[#L + 1] = "\\par " .. (n > 1 and "Points" or "Point")
        .. " d'inflexion en \\(" .. var .. " = "
        .. frdec(r.infl:gsub("%s*;%s*", "\\), \\(" .. var .. " = ")) .. "\\)."
    else
      L[#L + 1] = "\\par La courbe n'a pas de point d'inflexion."
    end
    api.lit(table.concat(L, "\n"))
  end)

  sl.register_block("sympyasymp", function(api, words, content)
    content = content_str(content)
    local nom = words:match("^(%S+)") or "f"
    local r, err = CALC_SYMPY.asymptotes(content, "x")
    if not r then error(err, 0) end
    local L = {}
    if r.hp and r.hm and r.hp == r.hm then
      L[#L + 1] = "La droite d'équation \\(y = " .. frdec(r.hp)
        .. "\\) est asymptote horizontale à la courbe en \\(-\\infty\\) "
        .. "et en \\(+\\infty\\)."
    else
      if r.hm then
        L[#L + 1] = "La droite d'équation \\(y = " .. frdec(r.hm)
          .. "\\) est asymptote horizontale à la courbe en \\(-\\infty\\)."
      end
      if r.hp then
        L[#L + 1] = "La droite d'équation \\(y = " .. frdec(r.hp)
          .. "\\) est asymptote horizontale à la courbe en \\(+\\infty\\)."
      end
    end
    local function oblique(o, ou)
      local b = o.b
      local signe = b:match("^%s*-") and " - " or " + "
      b = b:gsub("^%s*%-%s*", "")
      local droite = frdec(o.a) .. "x" .. (b == "0" and "" or (signe .. frdec(b)))
      L[#L + 1] = "La droite d'équation \\(y = " .. droite
        .. "\\) est asymptote oblique à la courbe en \\(" .. ou .. "\\)."
    end
    if r.om and r.op and r.om.a == r.op.a and r.om.b == r.op.b then
      local o = r.op
      local b = o.b:gsub("^%s*%-%s*", "")
      local signe = o.b:match("^%s*-") and " - " or " + "
      L[#L + 1] = "La droite d'équation \\(y = " .. frdec(o.a) .. "x"
        .. (b == "0" and "" or (signe .. frdec(b)))
        .. "\\) est asymptote oblique à la courbe en \\(-\\infty\\) "
        .. "et en \\(+\\infty\\)."
    else
      if r.om then oblique(r.om, "-\\infty") end
      if r.op then oblique(r.op, "+\\infty") end
    end
    for _, v in ipairs(r.v) do
      L[#L + 1] = "La droite d'équation \\(x = " .. frdec(v)
        .. "\\) est asymptote verticale à la courbe."
    end
    if #L == 0 then
      L[1] = "La courbe de \\(" .. nom .. "\\) n'admet aucune asymptote."
    end
    api.lit(table.concat(L, "\\par\n"))
  end)

  sl.register_block("sympypow", function(api, words, content)
    local rows = content_rows(content)
    local nom, n = words:match("^(%S+)%s+(%d+)$")
    if not nom then error("texecole : puissance de matrice mal formée.", 0) end
    local latex, err = CALC_SYMPY.matrix_pow(rows, tonumber(n))
    if not latex then error(err, 0) end
    api.lit("\\(" .. nom .. "^{" .. n .. "} = " .. frdec(latex) .. "\\)")
  end)

  sl.register_block("sympystable", function(api, words, content)
    local rows = content_rows(content)
    local nom = words:match("^(%S+)") or "M"
    local latex, err = CALC_SYMPY.markov_stable(rows)
    if not latex then error(err, 0) end
    api.lit("L'état stable de la chaîne de matrice de transition \\("
      .. nom .. "\\) est \\(\\pi = " .. frdec(latex)
      .. "\\), l'unique distribution vérifiant \\(\\pi = \\pi " .. nom .. "\\).")
  end)

  local BORNE_PY = [==[
def borne(s):
    s = s.strip()
    if s in ("+inf", "inf", "+oo", "oo"): return S.Infinity
    if s in ("-inf", "-oo"): return S.NegativeInfinity
    return lire(s, x)
]==]

  function CALC_SYMPY.defint(expr, var, a, b)
    local script = (PRE .. BORNE_PY .. [==[
%s = symbols('%s')
x = %s
f = lire("%s", %s)
I = integrate(f, (%s, borne("%s"), borne("%s")))
if I.has(Integral):
    print("TEXECOLE_PAS_DE_FORME_CLOSE")
else:
    print(latex(simplify(I)))
]==]):format(var, var, var, expr, var, var, a, b)
    local out, err = run(script)
    if not out then return nil, err end
    if out:find("TEXECOLE_PAS_DE_FORME_CLOSE") then
      return nil, "texecole : SymPy ne trouve pas de forme close pour "
        .. "cette intégrale — l'intégrale numérique reste disponible : "
        .. "<Calcule l'intégrale numérique de f entre a et b>."
    end
    return out
  end

  function CALC_SYMPY.equivalent(expr, var, point)
    local script = (PRE .. BORNE_PY .. [==[
%s = symbols('%s')
x = %s
f = lire("%s", %s)
a = borne("%s")
def equiv0(g, t):
    for k in range(1, 15):
        s = simplify(g.series(t, 0, k).removeO())
        if s != 0:
            return s.as_leading_term(t)
    return None
t = Dummy('t', positive=True)
if a is S.Infinity:
    e = equiv0(f.subs(%s, 1/t), t)
    e = e.subs(t, 1/%s) if e is not None else None
elif a is S.NegativeInfinity:
    e = equiv0(f.subs(%s, -1/t), t)
    e = e.subs(t, -1/%s) if e is not None else None
else:
    e = equiv0(f.subs(%s, a + t), t)
    e = e.subs(t, %s - a) if e is not None else None
if e is None:
    print("TEXECOLE_PAS_D_EQUIVALENT")
else:
    print(latex(simplify(e)))
]==]):format(var, var, var, expr, var, point,
             var, var, var, var, var, var)
    local out, err = run(script)
    if not out then return nil, err end
    if out:find("TEXECOLE_PAS_D_EQUIVALENT") then
      return nil, "texecole : aucun équivalent trouvé par développement "
        .. "en série à l'ordre 14 — la fonction est peut-être plate en "
        .. "ce point."
    end
    return out
  end

  function CALC_SYMPY.serie_nature(expr, var)
    var = var or "n"
    local script = (PRE .. [==[
%s = symbols('%s', integer=True, positive=True)
u = lire("%s", %s)
S_ = Sum(u, (%s, 1, S.Infinity))
try:
    c = S_.is_convergent()
except Exception:
    c = None
if c is None:
    print("N|inconnue")
elif c:
    print("N|converge")
    try:
        v = S_.doit()
        if not v.has(Sum):
            print("V|" + latex(simplify(v)))
    except Exception:
        pass
else:
    print("N|diverge")
]==]):format(var, var, expr, var, var)
    local out, err = run(script)
    if not out then return nil, err end
    local nature = out:match("N|(%S+)")
    local valeur = out:match("V|([^\n]*)")
    return { nature = nature, valeur = valeur }
  end

  function CALC_SYMPY.impint_nature(expr, var, a, b)
    local script = (PRE .. BORNE_PY .. [==[
%s = symbols('%s')
x = %s
f = lire("%s", %s)
try:
    I = integrate(f, (%s, borne("%s"), borne("%s")))
except Exception:
    I = None
if I is None or I.has(Integral):
    print("N|inconnue")
elif I.is_infinite:
    print("N|diverge")
elif I.is_finite is False:
    print("N|diverge")
else:
    print("N|converge")
    print("V|" + latex(simplify(I)))
]==]):format(var, var, var, expr, var, var, a, b)
    local out, err = run(script)
    if not out then return nil, err end
    return { nature = out:match("N|(%S+)"), valeur = out:match("V|([^\n]*)") }
  end

  local MAT_SYMS = "x, y, z, t, a, b, c = symbols('x y z t a b c')\n"

  function CALC_SYMPY.matrix_struct(rows, quoi)
    local body
    if quoi == "rank" then
      body = "print(M.rank())"
    elseif quoi == "ker" then
      body = [==[
ns = M.nullspace()
if not ns:
    print("TRIVIAL")
else:
    print(" ; ".join(latex(v) for v in ns))
]==]
    else
      body = [==[
cs = M.columnspace()
if not cs:
    print("TRIVIAL")
else:
    print(" ; ".join(latex(v) for v in cs))
]==]
    end
    local out, err = run(PRE .. MAT_SYMS
      .. "M = Matrix(" .. rows_to_py(rows) .. ")\n" .. body .. "\n")
    if not out then return nil, err end
    return out
  end

  function CALC_SYMPY.charpoly(rows)
    local out, err = run(PRE .. MAT_SYMS .. "X = symbols('X')\n"
      .. "M = Matrix(" .. rows_to_py(rows) .. ")\n"
      .. "if not M.is_square:\n    print('TEXECOLE_NON_CARREE')\n"
      .. "else:\n    print(latex(factor(M.charpoly(X).as_expr())))\n")
    if not out then return nil, err end
    if out:find("TEXECOLE_NON_CARREE") then
      return nil, "texecole : le polynôme caractéristique demande une "
        .. "matrice carrée."
    end
    return out
  end

  function CALC_SYMPY.minpoly(rows)
    local out, err = run(PRE .. MAT_SYMS .. [==[
import itertools
X = symbols('X')
M = Matrix(]==] .. rows_to_py(rows) .. [==[)
if not M.is_square:
    print("TEXECOLE_NON_CARREE")
    raise SystemExit
k = M.rows
p = M.charpoly(X).as_expr()
c0, fl = factor_list(p, X)
best = None
for ks in itertools.product(*[range(1, m + 1) for _, m in fl]):
    cand = prod(f**e for (f, _), e in zip(fl, ks))
    deg = Poly(cand, X).degree()
    if best is not None and deg >= best[0]:
        continue
    R = zeros(k)
    for cf in Poly(cand, X).all_coeffs():
        R = R * M + cf * eye(k)
    if R == zeros(k):
        best = (deg, cand)
print(latex(best[1]))
]==])
    if not out then return nil, err end
    if out:find("TEXECOLE_NON_CARREE") then
      return nil, "texecole : le polynôme minimal demande une matrice carrée."
    end
    return out
  end

  function CALC_SYMPY.trigonalise(rows)
    local out, err = run(PRE .. MAT_SYMS .. [==[
M = Matrix(]==] .. rows_to_py(rows) .. [==[)
if not M.is_square:
    print("TEXECOLE_NON_CARREE")
    raise SystemExit
try:
    P_, J_ = M.jordan_form()
except Exception:
    print("TEXECOLE_ECHEC")
    raise SystemExit
print("P|" + latex(simplify(P_)))
print("T|" + latex(simplify(J_)))
print("D|" + ("oui" if J_.is_diagonal() else "non"))
]==])
    if not out then return nil, err end
    if out:find("TEXECOLE_NON_CARREE") then
      return nil, "texecole : la trigonalisation demande une matrice carrée."
    end
    if out:find("TEXECOLE_ECHEC") then
      return nil, "texecole : SymPy n'a pas pu trigonaliser cette matrice "
        .. "(valeurs propres non exprimables en forme close)."
    end
    return { P = out:match("P|([^\n]*)"), T = out:match("T|([^\n]*)"),
             diag = out:match("D|(%S+)") == "oui" }
  end

  function CALC_SYMPY.gram_schmidt(coords_list)
    local vs = {}
    for _, co in ipairs(coords_list) do
      co = co:match("^%s*%((.*)%)%s*$") or co
      local cells = {}
      for part in (co .. ";"):gmatch("(.-);") do
        part = part:gsub("^%s+", ""):gsub("%s+$", "")
        if part ~= "" then
          cells[#cells + 1] = "lire(\"" .. part .. "\", x)"
        end
      end
      vs[#vs + 1] = "Matrix([" .. table.concat(cells, ", ") .. "])"
    end
    local out, err = run(PRE .. MAT_SYMS .. [==[
from sympy.matrices import GramSchmidt
vs = ]==] .. "[" .. table.concat(vs, ", ") .. "]" .. [==[

dims = {v.rows for v in vs}
if len(dims) != 1:
    print("TEXECOLE_DIMENSIONS")
    raise SystemExit
try:
    es = GramSchmidt(vs, True)
except ValueError:
    print("TEXECOLE_LIEE")
    raise SystemExit
print(" ; ".join(latex(simplify(e)) for e in es))
]==])
    if not out then return nil, err end
    if out:find("TEXECOLE_DIMENSIONS") then
      return nil, "texecole : les vecteurs de la famille n'ont pas tous "
        .. "la même dimension."
    end
    if out:find("TEXECOLE_LIEE") then
      return nil, "texecole : la famille est liée — le procédé de "
        .. "Gram-Schmidt demande une famille libre."
    end
    return out
  end

  local POLY_VAR = [==[
def varde(*es):
    for e in es:
        if Symbol('X') in e.free_symbols: return Symbol('X')
    for e in es:
        if Symbol('x') in e.free_symbols: return Symbol('x')
    return Symbol('X')
]==]

  function CALC_SYMPY.polydiv(P, Q)
    local out, err = run(PRE .. [==[
x, X = symbols('x X')
]==] .. POLY_VAR .. [==[
p = lire("]==] .. P .. [==[", X)
q = lire("]==] .. Q .. [==[", X)
v = varde(p, q)
if q == 0:
    print("TEXECOLE_DIVISEUR_NUL")
    raise SystemExit
quo, rem = div(p, q, v)
print("Q|" + latex(quo))
print("R|" + latex(rem))
]==])
    if not out then return nil, err end
    if out:find("TEXECOLE_DIVISEUR_NUL") then
      return nil, "texecole : la division euclidienne par le polynôme nul "
        .. "n'est pas définie."
    end
    return { q = out:match("Q|([^\n]*)"), r = out:match("R|([^\n]*)") }
  end

  function CALC_SYMPY.polygcd(P, Q)
    local out, err = run(PRE .. [==[
x, X = symbols('x X')
]==] .. POLY_VAR .. [==[
p = lire("]==] .. P .. [==[", X)
q = lire("]==] .. Q .. [==[", X)
v = varde(p, q)
print(latex(gcd(Poly(p, v), Poly(q, v)).as_expr()))
]==])
    if not out then return nil, err end
    return out
  end

  function CALC_SYMPY.factor_dans(P, corps)
    local out, err = run(PRE .. [==[
x, X = symbols('x X')
]==] .. POLY_VAR .. [==[
p = lire("]==] .. P .. [==[", X)
v = varde(p)
pol = Poly(p, v)
lc = pol.LC()
rs = roots(pol)
if sum(rs.values()) != pol.degree():
    print("TEXECOLE_RACINES")
    raise SystemExit
corps = "]==] .. corps .. [==["
if corps == "C":
    f = lc
    for r, m in rs.items():
        f = f * (v - r)**m
    print(latex(f))
else:
    f = lc
    vus = set()
    for r, m in rs.items():
        if r.is_real:
            f = f * (v - r)**m
        elif r in vus:
            continue
        else:
            vus.add(r); vus.add(conjugate(r))
            f = f * (v**2 - 2*re(r)*v + Abs(r)**2)**m
    print(latex(f))
]==])
    if not out then return nil, err end
    if out:find("TEXECOLE_RACINES") then
      return nil, "texecole : les racines de ce polynôme ne s'expriment "
        .. "pas en forme close — la factorisation exacte est hors de "
        .. "portée du calcul automatique."
    end
    return out
  end

  local MULTI_PY = [==[
def lirevars(vs):
    return [Symbol(s.strip()) for s in vs.split(",") if s.strip()]
def liremulti(s, syms):
    return parse_expr(s, transformations=_T,
                      local_dict={str(v): v for v in syms})
]==]

  function CALC_SYMPY.multi(fexpr, vars_str, quoi, extra)
    local body
    if quoi == "grad" then
      body = "print(latex(Matrix([diff(f, v) for v in syms])))"
    elseif quoi == "hess" then
      body = "print(latex(hessian(f, syms)))"
    elseif quoi == "partial" then
      body = "w = Symbol('" .. extra .. "')\n"
        .. "print(latex(simplify(diff(f, w))))"
    else
      body = [==[
grads = [diff(f, v) for v in syms]
sols = solve(grads, syms, dict=True)
H = hessian(f, syms)
reels = []
for s in sols:
    vals = [s.get(v) for v in syms]
    if all(val is not None and val.is_real for val in vals):
        reels.append(s)
if not reels:
    print("AUCUN")
for s in reels:
    Hs = H.subs(s)
    evs = list(Hs.eigenvals().keys())
    if all(e.is_positive for e in evs):
        nat = "minimum"
    elif all(e.is_negative for e in evs):
        nat = "maximum"
    elif any(e.is_positive for e in evs) and any(e.is_negative for e in evs):
        nat = "col"
    else:
        nat = "indeterminee"
    pt = " ; ".join(latex(s[v]) for v in syms)
    print("C|" + pt + "|" + nat)
]==]
    end
    local out, err = run(PRE .. MULTI_PY
      .. "syms = lirevars(\"" .. vars_str .. "\")\n"
      .. "f = liremulti(\"" .. fexpr .. "\", syms)\n" .. body .. "\n")
    if not out then return nil, err end
    return out
  end

  sl.register_block("sympydefint", function(api, words, content)
    content = content_str(content)
    local nom, var, a, b = words:match("^(%S+)%s+(%S+)%s+(%S+)%s+(%S+)$")
    local latex, err = CALC_SYMPY.defint(content, var, a, b)
    if not latex then error(err, 0) end
    local A = a:gsub("inf", "\\infty"):gsub("^%+", "")
    local B = b:gsub("inf", "\\infty"):gsub("^%+", "+"):gsub("^%+%-", "-")
    if b:match("^%+inf") then B = "+\\infty" end
    api.lit("\\(\\displaystyle\\int_{" .. frdec(M.mathlite(A)) .. "}^{"
      .. frdec(M.mathlite(B)) .. "} " .. nom .. "(" .. var
      .. ")\\,\\mathrm{d}" .. var .. " = " .. frdec(latex) .. "\\)")
  end)

  sl.register_block("sympyequiv", function(api, words, content)
    content = content_str(content)
    local nom, var, point = words:match("^(%S+)%s+(%S+)%s+(%S+)$")
    local latex, err = CALC_SYMPY.equivalent(content, var, point)
    if not latex then error(err, 0) end
    local P = point:gsub("%+inf", "+\\infty"):gsub("%-inf", "-\\infty")
    api.lit("\\(" .. nom .. "(" .. var .. ") \\underset{" .. var
      .. " \\to " .. frdec(M.mathlite(P)) .. "}{\\sim} "
      .. frdec(latex) .. "\\)")
  end)

  sl.register_block("sympyserie", function(api, words, content)
    content = content_str(content)
    local var = words:match("^(%S+)") or "n"
    local r, err = CALC_SYMPY.serie_nature(content, var)
    if not r then error(err, 0) end
    local u = frdec(M.mathlite(content))
    if r.nature == "converge" then
      local L = "La série \\(\\displaystyle\\sum u_" .. var
        .. "\\) de terme général \\(u_" .. var .. " = " .. u
        .. "\\) converge"
      if r.valeur then
        L = L .. ", et \\(\\displaystyle\\sum_{" .. var .. " = 1}^{+\\infty} "
          .. u .. " = " .. frdec(r.valeur) .. "\\)."
      else
        L = L .. "."
      end
      api.lit(L)
    elseif r.nature == "diverge" then
      api.lit("La série \\(\\displaystyle\\sum u_" .. var
        .. "\\) de terme général \\(u_" .. var .. " = " .. u
        .. "\\) diverge.")
    else
      error("texecole : SymPy ne détermine pas la nature de cette série — "
        .. "elle relève d'un raisonnement à rédiger.", 0)
    end
  end)

  sl.register_block("sympyimpint", function(api, words, content)
    content = content_str(content)
    local nom, var, a, b = words:match("^(%S+)%s+(%S+)%s+(%S+)%s+(%S+)$")
    local r, err = CALC_SYMPY.impint_nature(content, var, a, b)
    if not r then error(err, 0) end
    local A = a:gsub("%+inf", "+\\infty"):gsub("%-inf", "-\\infty")
    local B = b:gsub("%+inf", "+\\infty"):gsub("%-inf", "-\\infty")
    local tete = "L'intégrale \\(\\displaystyle\\int_{"
      .. frdec(M.mathlite(A)) .. "}^{" .. frdec(M.mathlite(B)) .. "} "
      .. nom .. "(" .. var .. ")\\,\\mathrm{d}" .. var .. "\\)"
    if r.nature == "converge" then
      api.lit(tete .. " converge, et vaut \\(" .. frdec(r.valeur) .. "\\).")
    elseif r.nature == "diverge" then
      api.lit(tete .. " diverge.")
    else
      error("texecole : SymPy ne détermine pas la nature de cette "
        .. "intégrale — elle relève d'un raisonnement à rédiger.", 0)
    end
  end)

  sl.register_block("sympyrank", function(api, words, content)
    local rows = content_rows(content)
    local nom = words:match("^(%S+)") or "M"
    local r, err = CALC_SYMPY.matrix_struct(rows, "rank")
    if not r then error(err, 0) end
    api.lit("\\(\\operatorname{rg}(" .. nom .. ") = " .. r .. "\\)")
  end)

  local function bloc_sous_espace(tag, quoi, texte)
    sl.register_block(tag, function(api, words, content)
      local rows = content_rows(content)
      local nom = words:match("^(%S+)") or "M"
      local r, err = CALC_SYMPY.matrix_struct(rows, quoi)
      if not r then error(err, 0) end
      if r:find("TRIVIAL") then
        api.lit("\\(" .. texte .. " " .. nom
          .. " = \\left\\{ 0 \\right\\}\\)")
      else
        local vs = {}
        for v in (r .. " ; "):gmatch("(.-)%s*;%s*") do
          if v:match("%S") then vs[#vs + 1] = frdec(v) end
        end
        api.lit("\\(" .. texte .. " " .. nom
          .. " = \\operatorname{Vect}\\left(" .. table.concat(vs, ",\\; ")
          .. "\\right)\\)")
      end
    end)
  end
  bloc_sous_espace("sympyker", "ker", "\\operatorname{Ker}")
  bloc_sous_espace("sympyim", "im", "\\operatorname{Im}")

  sl.register_block("sympycharpoly", function(api, words, content)
    local rows = content_rows(content)
    local nom = words:match("^(%S+)") or "M"
    local latex, err = CALC_SYMPY.charpoly(rows)
    if not latex then error(err, 0) end
    api.lit("\\(\\chi_{" .. nom .. "}(X) = " .. frdec(latex) .. "\\)")
  end)

  sl.register_block("sympyminpoly", function(api, words, content)
    local rows = content_rows(content)
    local nom = words:match("^(%S+)") or "M"
    local latex, err = CALC_SYMPY.minpoly(rows)
    if not latex then error(err, 0) end
    api.lit("\\(\\pi_{" .. nom .. "}(X) = " .. frdec(latex) .. "\\)")
  end)

  sl.register_block("sympytrigmat", function(api, words, content)
    local rows = content_rows(content)
    local nom = words:match("^(%S+)") or "M"
    local r, err = CALC_SYMPY.trigonalise(rows)
    if not r then error(err, 0) end
    local L = "\\(" .. nom .. " = P T P^{-1}\\) avec \\(P = " .. frdec(r.P)
      .. "\\) et \\(T = " .. frdec(r.T) .. "\\)"
    if r.diag then
      L = L .. " — la matrice \\(T\\) est diagonale : \\(" .. nom
        .. "\\) est en fait diagonalisable."
    else
      L = L .. ", triangulaire supérieure."
    end
    api.lit(L .. "")
  end)

  sl.register_block("sympygram", function(api, words, content)
    local coords = {}
    for _, l in ipairs(type(content) == "table" and content or { content }) do
      if type(l) == "string" then
        for co in l:gmatch("%b{}") do
          coords[#coords + 1] = co:sub(2, -2)
        end
      end
    end
    local noms = {}
    for w in (words or ""):gmatch("%S+") do noms[#noms + 1] = w end
    local r, err = CALC_SYMPY.gram_schmidt(coords)
    if not r then error(err, 0) end
    local es, i = {}, 0
    for v in (r .. " ; "):gmatch("(.-)%s*;%s*") do
      if v:match("%S") then
        i = i + 1
        es[#es + 1] = "\\(e_{" .. i .. "} = " .. frdec(v) .. "\\)"
      end
    end
    api.lit("Le procédé de Gram-Schmidt appliqué à la famille \\(("
      .. table.concat(noms, ", ")
      .. ")\\) donne la famille orthonormale " .. table.concat(es, ", ")
      .. ".")
  end)

  sl.register_block("sympypolydiv", function(api, words, content)
    content = content_str(content)
    local P, Q = content:match("^(.-)\n(.*)$")
    if not P then error("texecole : division euclidienne mal formée.", 0) end
    local r, err = CALC_SYMPY.polydiv(to_sympy(P), to_sympy(Q))
    if not r then error(err, 0) end
    api.lit("La division euclidienne donne \\(" .. frdec(M.mathlite(P))
      .. " = \\left(" .. frdec(M.mathlite(Q)) .. "\\right)\\left("
      .. frdec(r.q) .. "\\right) + " .. frdec(r.r) .. "\\).")
  end)

  sl.register_block("sympypolygcd", function(api, words, content)
    content = content_str(content)
    local P, Q = content:match("^(.-)\n(.*)$")
    if not P then error("texecole : PGCD polynomial mal formé.", 0) end
    local latex, err = CALC_SYMPY.polygcd(to_sympy(P), to_sympy(Q))
    if not latex then error(err, 0) end
    api.lit("\\(\\left(" .. frdec(M.mathlite(P)) .. "\\right) \\wedge "
      .. "\\left(" .. frdec(M.mathlite(Q)) .. "\\right) = "
      .. frdec(latex) .. "\\) (PGCD unitaire).")
  end)

  sl.register_block("sympyfactordom", function(api, words, content)
    content = content_str(content)
    local corps = words:match("^(%S+)") or "R"
    local latex, err = CALC_SYMPY.factor_dans(to_sympy(content), corps)
    if not latex then error(err, 0) end
    local dom = (corps == "C") and "\\mathbb{C}[X]" or "\\mathbb{R}[X]"
    api.lit("Dans \\(" .. dom .. "\\) : \\(" .. frdec(M.mathlite(content))
      .. " = " .. frdec(latex) .. "\\).")
  end)

  sl.register_block("sympygrad", function(api, words, content)
    content = content_str(content)
    local nom, vars = words:match("^(%S+)%s+(%S+)$")
    local latex, err = CALC_SYMPY.multi(content, vars, "grad")
    if not latex then error(err, 0) end
    api.lit("\\(\\nabla " .. M.mathlite(nom) .. " = " .. frdec(latex) .. "\\)")
  end)

  sl.register_block("sympyhess", function(api, words, content)
    content = content_str(content)
    local nom, vars = words:match("^(%S+)%s+(%S+)$")
    local latex, err = CALC_SYMPY.multi(content, vars, "hess")
    if not latex then error(err, 0) end
    api.lit("\\(\\operatorname{H}_{" .. M.mathlite(nom) .. "} = " .. frdec(latex) .. "\\)")
  end)

  sl.register_block("sympypartial", function(api, words, content)
    content = content_str(content)
    local nom, vars, wrt = words:match("^(%S+)%s+(%S+)%s+(%S+)$")
    local latex, err = CALC_SYMPY.multi(content, vars, "partial", wrt)
    if not latex then error(err, 0) end
    api.lit("\\(\\dfrac{\\partial " .. M.mathlite(nom) .. "}{\\partial " .. wrt
      .. "} = " .. frdec(latex) .. "\\)")
  end)

  sl.register_block("sympycrit", function(api, words, content)
    content = content_str(content)
    local nom, vars = words:match("^(%S+)%s+(%S+)$")
    local out, err = CALC_SYMPY.multi(content, vars, "crit")
    if not out then error(err, 0) end
    if out:find("AUCUN") then
      api.lit("La fonction \\(" .. M.mathlite(nom)
        .. "\\) n'a aucun point critique réel.")
      return
    end
    local NATURES = { minimum = "minimum local", maximum = "maximum local",
      col = "point col", indeterminee = "nature non déterminée par la "
      .. "hessienne (valeur propre nulle)" }
    local L = {}
    for pt, nat in out:gmatch("C|([^|\n]*)|(%S+)") do
      L[#L + 1] = "\\(\\left(" .. frdec(pt:gsub("%s*;%s*", "\\,;\\, "))
        .. "\\right)\\) : " .. (NATURES[nat] or nat)
    end
    api.lit("Points critiques de \\(" .. M.mathlite(nom) .. "\\) (gradient nul) — "
      .. table.concat(L, " ; ") .. ".")
  end)

  function CALC_SYMPY.fourier(expr, var, a, b, n)
    local script = (PRE .. [==[
%s = symbols('%s')
x = %s
f = lire("%s", %s)
try:
    s = fourier_series(f, (%s, lire("%s", %s), lire("%s", %s)))
    print(latex(s.truncate(%d)))
except Exception:
    print("TEXECOLE_ECHEC")
]==]):format(var, var, var, expr, var, var, a, var, b, var, n)
    local out, err = run(script)
    if not out then return nil, err end
    if out:find("TEXECOLE_ECHEC") then
      return nil, "texecole : SymPy n'a pas pu développer cette fonction "
        .. "en série de Fourier sur l'intervalle donné."
    end
    return out
  end

  function CALC_SYMPY.laplace(expr, var, sens)
    local body
    if sens == "direct" then
      body = ([==[
p = Symbol('p', positive=True)
try:
    F = laplace_transform(f, %s, p, noconds=True)
    print(latex(simplify(F)))
except Exception:
    print("TEXECOLE_ECHEC")
]==]):format(var)
    else
      body = ([==[
t = Symbol('t', positive=True)
try:
    g = inverse_laplace_transform(f, %s, t, noconds=True)
    g = g.replace(Heaviside, lambda *args: 1)
    print(latex(simplify(g)))
except Exception:
    print("TEXECOLE_ECHEC")
]==]):format(var)
    end
    local script = (PRE .. [==[
%s = symbols('%s')
f = lire("%s", %s)
]==]):format(var, var, expr, var) .. body
    local out, err = run(script)
    if not out then return nil, err end
    if out:find("TEXECOLE_ECHEC") then
      return nil, "texecole : SymPy n'a pas trouvé de forme close pour "
        .. "cette transformée de Laplace" .. (sens == "direct" and "."
        or " inverse.")
    end
    return out
  end

  function CALC_SYMPY.wronskien(exprs, var)
    local fs = {}
    for _, e in ipairs(exprs) do
      fs[#fs + 1] = "lire(\"" .. e .. "\", " .. var .. ")"
    end
    local script = (PRE .. [==[
%s = symbols('%s')
from sympy.matrices import wronskian
W = simplify(wronskian([%s], %s))
print("Z|" + ("oui" if W == 0 else "non"))
print("W|" + latex(W))
]==]):format(var, var, table.concat(fs, ", "), var)
    local out, err = run(script)
    if not out then return nil, err end
    return { nul = out:match("Z|(%S+)") == "oui", w = out:match("W|([^\n]*)") }
  end

  sl.register_block("sympyeval", function(api, words, content)
    content = content_str(content)
    local nom, var, val = words:match("^(%S+)%s+(%S+)%s+(%S+)$")
    local out, err = run(PRE .. ([==[
%s = symbols('%s')
f = lire("%s", %s)
v = lire("%s", %s)
print(latex(simplify(f.subs(%s, v))))
]==]):format(var, var, content, var, val, var, var))
    if not out then error(err, 0) end
    local prot = val:match("^%d+[%.,]?%d*$") and val
      or ("(" .. val .. ")")
    local sub = content:gsub("%f[%w]" .. var .. "%f[%W]", prot)
    api.lit("\\(" .. nom .. "(" .. frdec(M.mathlite(val)) .. ") = "
      .. frdec(M.mathlite(sub)) .. " = " .. frdec(out) .. "\\)")
  end)

  sl.register_block("sympyfourier", function(api, words, content)
    content = content_str(content)
    local nom, var, a, b, n = words:match("^(%S+)%s+(%S+)%s+(%S+)%s+(%S+)%s+(%d+)$")
    local latex, err = CALC_SYMPY.fourier(content, var, a, b, tonumber(n))
    if not latex then error(err, 0) end
    api.lit("Sur \\(\\left[" .. frdec(M.mathlite(a)) .. "\\,;\\, "
      .. frdec(M.mathlite(b)) .. "\\right]\\), la série de Fourier de \\("
      .. M.mathlite(nom) .. "\\), tronquée à l'ordre " .. n
      .. ", s'écrit \\(" .. frdec(latex) .. " + \\dotsb\\)")
  end)

  sl.register_block("sympylaplace", function(api, words, content)
    content = content_str(content)
    local nom, var = words:match("^(%S+)%s+(%S+)$")
    local latex, err = CALC_SYMPY.laplace(content, var, "direct")
    if not latex then error(err, 0) end
    api.lit("\\(\\mathcal{L}\\left[" .. M.mathlite(nom) .. "\\right](p) = "
      .. "\\displaystyle\\int_0^{+\\infty} " .. M.mathlite(nom) .. "("
      .. var .. ")\\, e^{-p" .. var .. "}\\,\\mathrm{d}" .. var .. " = "
      .. frdec(latex) .. "\\)")
  end)

  sl.register_block("sympyinvlaplace", function(api, words, content)
    content = content_str(content)
    local nom, var = words:match("^(%S+)%s+(%S+)$")
    local latex, err = CALC_SYMPY.laplace(content, var, "inverse")
    if not latex then error(err, 0) end
    api.lit("L'originale de \\(" .. M.mathlite(nom)
      .. "\\) est \\(\\mathcal{L}^{-1}\\left[" .. M.mathlite(nom)
      .. "\\right](t) = " .. frdec(latex)
      .. "\\) pour \\(t \\geqslant 0\\).")
  end)

  sl.register_block("sympywronsk", function(api, words, content)
    local mots = {}
    for w in (words or ""):gmatch("%S+") do mots[#mots + 1] = w end
    local var = table.remove(mots, 1)
    local exprs = {}
    for _, l in ipairs(type(content) == "table" and content or { content }) do
      if type(l) == "string" and l:match("%S") and not l:match("^%s*}%s*$") then
        exprs[#exprs + 1] = l:gsub("^%s+", ""):gsub("%s+$", "")
      end
    end
    local r, err = CALC_SYMPY.wronskien(exprs, var)
    if not r then error(err, 0) end
    local fam = "(" .. table.concat(mots, ", ") .. ")"
    local L = "\\(W" .. fam .. "(" .. var .. ") = " .. frdec(r.w) .. "\\)"
    if r.nul then
      L = L .. " : le wronskien est identiquement nul (ce qui, en "
        .. "général, ne suffit pas à conclure que la famille est liée)."
    else
      L = L .. " : le wronskien n'est pas identiquement nul, la famille \\("
        .. fam .. "\\) est libre."
    end
    api.lit(L)
  end)

  local function bloc_matrice(nom, op, texte)
    sl.register_block(nom, function(api, words, content)
      local rows = content_rows(content)
      local latex, err = CALC_SYMPY.matrix_op(rows, op)
      if not latex then error(err, 0) end
      api.lit("\\(" .. texte:gsub("NOM", words:match("^(%S+)") or "M")
        .. " " .. frdec(latex) .. "\\)")
    end)
  end
  bloc_matrice("sympydet", "det", "\\det(NOM) =")
  bloc_matrice("sympyinv", "inv", "NOM^{-1} =")

  sl.sympy = CALC_SYMPY
  return CALC_SYMPY
end
