local U = require("texecole-util")
local N = require("texecole-numeval")

local function pgcd(a, b)
  a, b = math.abs(a), math.abs(b)
  while b ~= 0 do a, b = b, a % b end
  return a
end

local function rat(n, d)
  d = d or 1
  if d == 0 then error("texecole : division par zéro dans un calcul vectoriel.", 0) end
  if d < 0 then n, d = -n, -d end
  local g = pgcd(n, d)
  if g > 1 then n, d = n // g, d // g end
  return { n = n, d = d }
end

local function radd(a, b) return rat(a.n * b.d + b.n * a.d, a.d * b.d) end
local function rmul(a, b) return rat(a.n * b.n, a.d * b.d) end
local function rnum(a) return a.n / a.d end

local function lire_rat(s)
  s = U.trim(s):gsub(",", ".")
  local n, d = s:match("^(-?%d+)%s*/%s*(%d+)$")
  if n then return rat(tonumber(n), tonumber(d)) end
  local e, f = s:match("^(-?%d*)%.(%d+)$")
  if e then
    local den = 1
    for _ = 1, #f do den = den * 10 end
    local ent = (e == "" or e == "-") and 0 or tonumber(e)
    local num = math.abs(ent) * den + tonumber(f)
    if s:sub(1, 1) == "-" then num = -num end
    return rat(num, den)
  end
  local i = s:match("^(-?%d+)$")
  if i then return rat(tonumber(i)) end
  return nil
end

local function tex_rat(a)
  if a.d == 1 then return tostring(a.n) end
  if a.n < 0 then return "-\\frac{" .. (-a.n) .. "}{" .. a.d .. "}" end
  return "\\frac{" .. a.n .. "}{" .. a.d .. "}"
end

local function tex_rat_par(a)
  if a.n < 0 or a.d ~= 1 then return "\\left(" .. tex_rat(a) .. "\\right)" end
  return tex_rat(a)
end

local function lire_coords(co, quoi)
  local inner = co:match("^%s*%((.*)%)%s*$") or co
  local out = {}
  for part in (inner .. ";"):gmatch("(.-);") do
    local t = U.trim(part)
    if t ~= "" then
      local r = lire_rat(t)
      if not r then
        error("texecole : la coordonnée « " .. t .. " » de " .. quoi
          .. " ne se lit pas comme un nombre.", 0)
      end
      out[#out + 1] = r
    end
  end
  if #out < 2 then
    error("texecole : " .. quoi .. " demande au moins deux coordonnées ; "
      .. #out .. " donnée" .. (#out > 1 and "s" or "") .. ".", 0)
  end
  return out
end

local function tex_sqrt(a)
  local function sq(n)
    local k, m, d = 1, n, 2
    while d * d <= m do
      while m % (d * d) == 0 do m = m // (d * d); k = k * d end
      d = d + 1
    end
    return k, m
  end
  local kn, mn = sq(a.n)
  local kd, md = sq(a.d)
  local head
  if md == 1 then
    head = (kd == 1) and "" or nil
    if kd ~= 1 then
      if mn == 1 then return tex_rat(rat(kn, kd)) end
      local g = pgcd(kn, kd)
      kn, kd = kn // g, kd // g
      local num = (kn == 1) and ("\\sqrt{" .. mn .. "}")
                  or (kn .. "\\sqrt{" .. mn .. "}")
      if kd == 1 then return num end
      return "\\frac{" .. num .. "}{" .. kd .. "}"
    end
    if mn == 1 then return tostring(kn) end
    if kn == 1 then return "\\sqrt{" .. mn .. "}" end
    return kn .. "\\sqrt{" .. mn .. "}"
  end
  return nil
end

local function affiche(v)
  return (N.display(v, "{,}", 4))
end

local function scalaire(u, v)
  local s = rat(0)
  for i = 1, #u do s = radd(s, rmul(u[i], v[i])) end
  return s
end

local function meme_dim(u, v, nu, nv)
  if #u ~= #v then
    error("texecole : les vecteurs " .. nu .. " et " .. nv .. " n'ont pas "
      .. "la même dimension (" .. #u .. " et " .. #v .. " coordonnées).", 0)
  end
end

local ANGLES_COS = {
  ["1|1"] = "0", ["3|4"] = "\\frac{\\pi}{6}", ["1|2"] = "\\frac{\\pi}{4}",
  ["1|4"] = "\\frac{\\pi}{3}", ["0|1"] = "\\frac{\\pi}{2}",
}

return function(sl)
  local function pose(api, s)
    api.raw("emit(" .. string.format("%q", s) .. ")\n")
  end

  local function deux_vecteurs(words_str, quoi)
    local ws = (words_str or ""):gsub("^%s*%S+%s*", "", 1)
    local nu, cu, nv, cv = ws:match(
      "^%s*([%a][%w_]*)%s*(%b{})%s*([%a][%w_]*)%s*(%b{})%s*$")
    if not nu then
      error("texecole : " .. quoi .. " demande deux vecteurs posés "
        .. "auparavant par <Soit>le vecteur u de coordonnées (...).", 0)
    end
    local u = lire_coords(cu:sub(2, -2), "le vecteur " .. nu)
    local v = lire_coords(cv:sub(2, -2), "le vecteur " .. nv)
    meme_dim(u, v, nu, nv)
    return nu, u, nv, v
  end

  sl.register_tag("vecscal", function(api, w, c, words_str)
    local nu, u, nv, v = deux_vecteurs(words_str, "le produit scalaire")
    local termes = {}
    for i = 1, #u do
      termes[#termes + 1] = tex_rat_par(u[i]) .. " \\times " .. tex_rat_par(v[i])
    end
    local s = scalaire(u, v)
    local L = "$\\vec{" .. nu .. "} \\cdot \\vec{" .. nv .. "} = "
      .. table.concat(termes, " + ") .. " = " .. tex_rat(s) .. "$."
    if s.n == 0 then
      L = L .. " Les vecteurs $\\vec{" .. nu .. "}$ et $\\vec{" .. nv
        .. "}$ sont donc orthogonaux."
    end
    pose(api, L)
  end)

  sl.register_tag("vecnorm", function(api, w, c, words_str)
    local ws = (words_str or ""):gsub("^%s*%S+%s*", "", 1)
    local nu, cu = ws:match("^%s*([%a][%w_]*)%s*(%b{})%s*$")
    if not nu then
      error("texecole : la norme demande un vecteur posé auparavant par "
        .. "<Soit>le vecteur u de coordonnées (...).", 0)
    end
    local u = lire_coords(cu:sub(2, -2), "le vecteur " .. nu)
    local carre = scalaire(u, u)
    local termes = {}
    for i = 1, #u do termes[#termes + 1] = tex_rat_par(u[i]) .. "^2" end
    local exact = tex_sqrt(carre)
    local fin = exact
      or ("\\sqrt{" .. tex_rat(carre) .. "} \\approx "
          .. affiche(math.sqrt(rnum(carre))))
    pose(api, "$\\left\\lVert \\vec{" .. nu .. "} \\right\\rVert = \\sqrt{"
      .. table.concat(termes, " + ") .. "} = " .. fin .. "$.")
  end)

  sl.register_tag("vecangle", function(api, w, c, words_str)
    local nu, u, nv, v = deux_vecteurs(words_str, "l'angle")
    local s = scalaire(u, v)
    local cu, cv = scalaire(u, u), scalaire(v, v)
    if cu.n == 0 or cv.n == 0 then
      error("texecole : l'angle avec le vecteur nul n'est pas défini.", 0)
    end
    local c2 = rat(s.n * s.n, s.d * s.d)
    local den = rmul(cu, cv)
    local ratio = rat(c2.n * den.d, c2.d * den.n)
    local cle = ratio.n .. "|" .. ratio.d
    local tete = "$\\cos\\left(\\vec{" .. nu .. "}\\,;\\, \\vec{" .. nv
      .. "}\\right) = \\dfrac{\\vec{" .. nu .. "} \\cdot \\vec{" .. nv
      .. "}}{\\lVert \\vec{" .. nu .. "} \\rVert\\, \\lVert \\vec{" .. nv
      .. "} \\rVert}$"
    if s.n == 0 then
      pose(api, tete .. " $= 0$ : l'angle vaut $\\dfrac{\\pi}{2}$, les "
        .. "vecteurs sont orthogonaux.")
      return
    end
    local SUPPL = { ["\\frac{\\pi}{6}"] = "\\frac{5\\pi}{6}",
                    ["\\frac{\\pi}{4}"] = "\\frac{3\\pi}{4}",
                    ["\\frac{\\pi}{3}"] = "\\frac{2\\pi}{3}" }
    local exact = ANGLES_COS[cle]
    if exact and exact ~= "0" then
      local val = (s.n > 0) and exact or (SUPPL[exact] or ("\\pi - " .. exact))
      pose(api, tete .. " donne un angle de $" .. val .. "$.")
      return
    end
    local cosv = rnum(s) / math.sqrt(rnum(cu) * rnum(cv))
    if exact == "0" then
      pose(api, tete .. " $= " .. (s.n > 0 and "1" or "-1")
        .. "$ : l'angle vaut $" .. (s.n > 0 and "0" or "\\pi")
        .. "$, les vecteurs sont colinéaires.")
      return
    end
    local deg = math.deg(math.acos(math.max(-1, math.min(1, cosv))))
    pose(api, tete .. " $\\approx " .. affiche(cosv)
      .. "$, soit un angle d'environ $" .. affiche(deg) .. "^{\\circ}$.")
  end)

  sl.register_tag("vecproj", function(api, w, c, words_str)
    local nu, u, nv, v = deux_vecteurs(words_str, "le projeté orthogonal")
    local sv = scalaire(v, v)
    if sv.n == 0 then
      error("texecole : le projeté orthogonal sur le vecteur nul n'est "
        .. "pas défini.", 0)
    end
    local su = scalaire(u, v)
    local k = rat(su.n * sv.d, su.d * sv.n)
    local co = {}
    for i = 1, #v do co[#co + 1] = tex_rat(rmul(k, v[i])) end
    pose(api, "$p_{\\vec{" .. nv .. "}}\\left(\\vec{" .. nu
      .. "}\\right) = \\dfrac{\\vec{" .. nu .. "} \\cdot \\vec{"
      .. nv .. "}}{\\lVert \\vec{" .. nv
      .. "} \\rVert^2}\\, \\vec{" .. nv .. "} = " .. tex_rat(k)
      .. "\\, \\vec{" .. nv .. "} = \\begin{pmatrix}"
      .. table.concat(co, " \\\\ ") .. "\\end{pmatrix}$.")
  end)

  sl.register_tag("veccolin", function(api, w, c, words_str)
    local nu, u, nv, v = deux_vecteurs(words_str, "la colinéarité")
    if #u > 3 then
      error("texecole : la colinéarité par déterminant ou produit "
        .. "vectoriel se limite aux dimensions 2 et 3.", 0)
    end
    if #u == 2 then
      local det = radd(rmul(u[1], v[2]), rat(-1 * u[2].n * v[1].n * 1,
                                             u[2].d * v[1].d))
      local L = "$\\det\\left(\\vec{" .. nu .. "}\\,;\\, \\vec{" .. nv
        .. "}\\right) = " .. tex_rat_par(u[1]) .. " \\times "
        .. tex_rat_par(v[2]) .. " - " .. tex_rat_par(u[2]) .. " \\times "
        .. tex_rat_par(v[1]) .. " = " .. tex_rat(det) .. "$ : les vecteurs "
        .. ((det.n == 0) and "sont colinéaires." or "ne sont pas colinéaires.")
      pose(api, L)
    else
      local w1 = radd(rmul(u[2], v[3]), rat(-u[3].n * v[2].n, u[3].d * v[2].d))
      local w2 = radd(rmul(u[3], v[1]), rat(-u[1].n * v[3].n, u[1].d * v[3].d))
      local w3 = radd(rmul(u[1], v[2]), rat(-u[2].n * v[1].n, u[2].d * v[1].d))
      local nul = (w1.n == 0 and w2.n == 0 and w3.n == 0)
      pose(api, "$\\vec{" .. nu .. "} \\wedge \\vec{" .. nv
        .. "} = \\begin{pmatrix}" .. tex_rat(w1) .. " \\\\ " .. tex_rat(w2)
        .. " \\\\ " .. tex_rat(w3) .. "\\end{pmatrix}$ : les vecteurs "
        .. (nul and "sont colinéaires." or "ne sont pas colinéaires."))
    end
  end)

  local function lire_plan(eq, nom)
    local lhs, rhs = eq:match("^(.-)=(.+)$")
    if not lhs then
      error("texecole : l'équation du plan " .. nom .. " demande un "
        .. "signe =, par exemple 2x + y - z = 3.", 0)
    end
    local co = { x = rat(0), y = rat(0), z = rat(0) }
    local s = lhs:gsub("%s", ""):gsub("−", "-")
    if s:sub(1, 1) ~= "+" and s:sub(1, 1) ~= "-" then s = "+" .. s end
    for signe, corps in s:gmatch("([+-])([^+-]+)") do
      local coef, var = corps:match("^(.-)([xyz])$")
      if not var then
        error("texecole : le terme « " .. corps .. " » de l'équation du "
          .. "plan " .. nom .. " ne se lit pas (attendu ax, by ou cz).", 0)
      end
      local r = (coef == "") and rat(1) or lire_rat(coef)
      if not r then
        error("texecole : le coefficient « " .. coef .. " » de l'équation "
          .. "du plan " .. nom .. " ne se lit pas comme un nombre.", 0)
      end
      if signe == "-" then r = rat(-r.n, r.d) end
      co[var] = radd(co[var], r)
    end
    local d = lire_rat(rhs)
    if not d then
      error("texecole : le second membre « " .. U.trim(rhs) .. " » de "
        .. "l'équation du plan " .. nom .. " ne se lit pas comme un "
        .. "nombre.", 0)
    end
    if co.x.n == 0 and co.y.n == 0 and co.z.n == 0 then
      error("texecole : l'équation du plan " .. nom .. " n'a aucun terme "
        .. "en x, y ou z.", 0)
    end
    return co, d
  end

  sl.register_tag("plannormal", function(api, w, content, words_str)
    local nom = (words_str or ""):match("^%s*%S+%s+([%a][%w_]*)") or "P"
    local co = lire_plan(U.trim(content or ""), nom)
    pose(api, "Le vecteur $\\vec{n}\\,\\begin{pmatrix}" .. tex_rat(co.x)
      .. " \\\\ " .. tex_rat(co.y) .. " \\\\ " .. tex_rat(co.z)
      .. "\\end{pmatrix}$, lu sur les coefficients de l'équation, est "
      .. "normal au plan $" .. nom .. "$.")
  end)

  sl.register_tag("plandist", function(api, w, content, words_str)
    local ws = (words_str or ""):gsub("^%s*%S+%s*", "", 1)
    local nom, cp = ws:match("^%s*([%a][%w_]*)%s*(%b())%s*$")
    if not nom then
      error("texecole : la distance au plan demande le plan et le point, "
        .. "par exemple <Calcule la distance du point (1 ; 2 ; 0) au "
        .. "plan P>.", 0)
    end
    local co, d = lire_plan(U.trim(content or ""), nom)
    local A = lire_coords(cp, "le point")
    if #A ~= 3 then
      error("texecole : la distance à un plan demande un point de "
        .. "l'espace (trois coordonnées).", 0)
    end
    local num = radd(radd(rmul(co.x, A[1]), rmul(co.y, A[2])),
                     radd(rmul(co.z, A[3]), rat(-d.n, d.d)))
    local carre = radd(radd(rmul(co.x, co.x), rmul(co.y, co.y)),
                       rmul(co.z, co.z))
    local absnum = rat(math.abs(num.n), num.d)
    local rac = tex_sqrt(carre)
    local val = math.abs(rnum(num)) / math.sqrt(rnum(carre))
    local corps = "\\dfrac{\\lvert a x_A + b y_A + c z_A - d \\rvert}"
      .. "{\\sqrt{a^2 + b^2 + c^2}} = \\dfrac{" .. tex_rat(absnum) .. "}{"
      .. (rac or ("\\sqrt{" .. tex_rat(carre) .. "}")) .. "}"
    pose(api, "$\\mathrm{d}\\left(A\\,;\\, " .. nom .. "\\right) = "
      .. corps .. " \\approx " .. affiche(val) .. "$.")
  end)
end
