local U = require("texecole-util")
local N = require("texecole-numeval")

local function pgcd(a, b)
  a, b = math.abs(a), math.abs(b)
  while b ~= 0 do a, b = b, a % b end
  return a
end

local function entiers(w, combien)
  local out = {}
  for d in w:gmatch("(-?%d+)") do out[#out + 1] = math.tointeger(tonumber(d)) end
  if combien and #out < combien then return nil end
  return out
end

local function fact(n)
  local r = 1
  for k = 2, n do r = r * k end
  return r
end

local function binom(n, k)
  if k < 0 or k > n then return 0 end
  local r = 1
  for i = 1, k do r = r * (n - i + 1) // i end
  return r
end

local function arrangement(n, k)
  if k < 0 or k > n then return 0 end
  local r = 1
  for i = 0, k - 1 do r = r * (n - i) end
  return r
end

local function facteurs(n)
  local out, d = {}, 2
  while d * d <= n do
    local e = 0
    while n % d == 0 do n = n // d; e = e + 1 end
    if e > 0 then out[#out + 1] = { d, e } end
    d = d + (d == 2 and 1 or 2)
  end
  if n > 1 then out[#out + 1] = { n, 1 } end
  return out
end

local function euclide(a, b)
  local etapes = {}
  local x, y = a, b
  while y ~= 0 do
    local q, r = x // y, x % y
    etapes[#etapes + 1] = { x, y, q, r }
    x, y = y, r
  end
  return x, etapes
end

local function bezout(a, b)
  local r0, r1, u0, u1, v0, v1 = a, b, 1, 0, 0, 1
  while r1 ~= 0 do
    local q = r0 // r1
    r0, r1 = r1, r0 - q * r1
    u0, u1 = u1, u0 - q * u1
    v0, v1 = v1, v0 - q * v1
  end
  return r0, u0, v0
end

local function lire_complexe(s)
  s = s:gsub("%s", ""):gsub(",", ".")
  local a, b
  local re, im = s:match("^([%+%-]?%d*%.?%d*)([%+%-]%d*%.?%d*)i$")
  if re then
    a = tonumber(re) or 0
    if im == "+" then b = 1 elseif im == "-" then b = -1 else b = tonumber(im) end
  else
    local seul = s:match("^([%+%-]?%d*%.?%d*)i$")
    if seul then
      a = 0
      if seul == "" or seul == "+" then b = 1
      elseif seul == "-" then b = -1 else b = tonumber(seul) end
    else
      a, b = tonumber(s), 0
    end
  end
  if not a or not b then return nil end
  return a, b
end

local function nb(v)
  if v == math.floor(v) then return string.format("%d", v) end
  return (N.display(v, "{,}", 4))
end

local ANGLES = {
  [0] = "0", [30] = "\\frac{\\pi}{6}", [45] = "\\frac{\\pi}{4}",
  [60] = "\\frac{\\pi}{3}", [90] = "\\frac{\\pi}{2}", [120] = "\\frac{2\\pi}{3}",
  [135] = "\\frac{3\\pi}{4}", [150] = "\\frac{5\\pi}{6}", [180] = "\\pi",
  [210] = "-\\frac{5\\pi}{6}", [225] = "-\\frac{3\\pi}{4}", [240] = "-\\frac{2\\pi}{3}",
  [270] = "-\\frac{\\pi}{2}", [300] = "-\\frac{\\pi}{3}", [315] = "-\\frac{\\pi}{4}",
  [330] = "-\\frac{\\pi}{6}",
}

return function(sl)
  local function pose(api, s)
    api.raw("emit(" .. string.format("%q", s) .. ")\n")
  end

  sl.register_tag("combi", function(api, w, c, words_str)
    local v = entiers(words_str or "", 2)
    if not v then
      error("texecole : <Dénombre les combinaisons ...> attend deux entiers, "
          .. "par exemple « de 3 parmi 10 ».", 0)
    end
    local k, n = v[1], v[2]
    if k > n then
      error("texecole : on ne choisit pas " .. k .. " éléments parmi " .. n .. ".", 0)
    end
    pose(api, "$\\binom{" .. n .. "}{" .. k .. "} = \\dfrac{" .. n .. "!}{"
        .. k .. "!\\,(" .. n .. "-" .. k .. ")!} = " .. binom(n, k) .. "$")
  end)

  sl.register_tag("arrang", function(api, w, c, words_str)
    local v = entiers(words_str or "", 2)
    if not v then
      error("texecole : <Dénombre les arrangements ...> attend deux entiers, "
          .. "par exemple « de 3 parmi 10 ».", 0)
    end
    local k, n = v[1], v[2]
    pose(api, "$A_{" .. n .. "}^{" .. k .. "} = \\dfrac{" .. n .. "!}{("
        .. n .. "-" .. k .. ")!} = " .. arrangement(n, k) .. "$")
  end)

  sl.register_tag("permut", function(api, w, c, words_str)
    local v = entiers(words_str or "", 1)
    if not v then
      error("texecole : <Dénombre les permutations ...> attend un entier.", 0)
    end
    pose(api, "$" .. v[1] .. "! = " .. fact(v[1]) .. "$")
  end)

  sl.register_tag("pascal", function(api, w, c, words_str)
    local v = entiers(words_str or "", 1)
    local n = v and v[1] or 6
    local spec = ""
    for _ = 0, n do spec = spec .. "Q[c]" end
    local out = { "\\begin{center}\\begin{tblr}{colspec={" .. spec
                .. "}, colsep=4pt, rowsep=2pt}" }
    for i = 0, n do
      local r = {}
      for j = 0, n do
        r[#r + 1] = (j <= i) and ("$" .. binom(i, j) .. "$") or ""
      end
      out[#out + 1] = table.concat(r, " & ") .. " \\\\"
    end
    out[#out + 1] = "\\end{tblr}\\end{center}"
    pose(api, table.concat(out, "\n"))
  end)

  sl.register_tag("primefac", function(api, w, c, words_str)
    local v = entiers(words_str or "", 1)
    if not v or v[1] < 2 then
      error("texecole : <Dresse la décomposition en facteurs premiers de ...> "
          .. "attend un entier supérieur ou égal à 2.", 0)
    end
    local n = v[1]
    local f = facteurs(n)
    local m = {}
    for _, p in ipairs(f) do
      m[#m + 1] = p[2] > 1 and (p[1] .. "^{" .. p[2] .. "}") or tostring(p[1])
    end
    local nd = 1
    for _, p in ipairs(f) do nd = nd * (p[2] + 1) end
    pose(api, "$" .. n .. " = " .. table.concat(m, " \\times ") .. "$"
        .. ", soit " .. nd .. " diviseurs.")
  end)

  sl.register_tag("euclide", function(api, w, c, words_str)
    local v = entiers(words_str or "", 2)
    if not v then
      error("texecole : <Applique l'algorithme d'Euclide ...> attend deux "
          .. "entiers, par exemple « à 84 et 60 ».", 0)
    end
    local a, b = math.max(v[1], v[2]), math.min(v[1], v[2])
    local d, etapes = euclide(a, b)
    local _, u, vv = bezout(a, b)
    local L = {}
    for _, e in ipairs(etapes) do
      L[#L + 1] = "$" .. e[1] .. " = " .. e[2] .. " \\times " .. e[3]
                .. " + " .. e[4] .. "$"
    end
    local ppcm = (a // d) * b
    pose(api, table.concat(L, " \\par\n") .. " \\par\n"
        .. "Le dernier reste non nul donne $\\mathrm{PGCD}(" .. a .. "\\,;\\,"
        .. b .. ") = " .. d .. "$, d'où $\\mathrm{PPCM} = " .. ppcm .. "$."
        .. " \\par\nUne relation de Bézout est $" .. u .. " \\times " .. a
        .. " + " .. vv .. " \\times " .. b .. " = " .. d .. "$.")
  end)

  sl.register_tag("complexe", function(api, w, c, words_str)
    local ws = (words_str or ""):gsub("^%s*%S+%s*", "", 1)
    local nom = ws:match("^%s*([%a][%w_]*)%s*=") or "z"
    local expr = ws:match("=%s*(.-)%s*sous") or ws:match("=%s*(.+)$") or ws
    local a, b = lire_complexe(U.trim(expr))
    if not a then
      error("texecole : « " .. U.trim(expr) .. " » ne se lit pas comme un "
          .. "complexe ; écrivez par exemple 1 + i, -2i ou 3 - 4i.", 0)
    end
    local r = math.sqrt(a * a + b * b)
    if r == 0 then
      error("texecole : le complexe nul n'a pas d'argument.", 0)
    end
    local th = math.deg(math.atan(b, a))
    local arrondi = math.floor(th + 0.5)
    local texth = ANGLES[arrondi % 360] or ANGLES[arrondi]
    if not texth and math.abs(th - arrondi) < 1e-9 then
      texth = ANGLES[(arrondi + 360) % 360]
    end
    local argtex = texth or (nb(math.rad(th)) .. "\\ \\text{rad}")
    local rtex
    local rr = r * r
    if math.abs(rr - math.floor(rr + 0.5)) < 1e-9 then
      local e = math.floor(rr + 0.5)
      local s = math.floor(math.sqrt(e) + 0.5)
      rtex = (s * s == e) and tostring(s) or ("\\sqrt{" .. e .. "}")
    else
      rtex = nb(r)
    end
    local alg = nb(a)
    if b ~= 0 then
      local ib = (math.abs(b) == 1) and "" or nb(math.abs(b))
      alg = ((a ~= 0) and (nb(a) .. (b > 0 and " + " or " - ")) or (b > 0 and "" or "-"))
          .. ib .. "\\mathrm{i}"
    end
    pose(api,
      "Forme algébrique : $" .. nom .. " = " .. alg .. "$."
      .. " \\par\nModule et argument : $|" .. nom .. "| = " .. rtex
      .. "$ et $\\arg(" .. nom .. ") = " .. argtex .. "$."
      .. " \\par\nForme trigonométrique : $" .. nom .. " = " .. rtex
      .. "\\left(\\cos " .. argtex .. " + \\mathrm{i}\\sin " .. argtex .. "\\right)$."
      .. " \\par\nForme exponentielle : $" .. nom .. " = " .. rtex
      .. "\\,\\mathrm{e}^{\\mathrm{i}" .. argtex .. "}$.")
  end)

  sl.register_tag("congru", function(api, w, c, words_str)
    local ws = (words_str or ""):gsub("^%s*%S+%s*", "", 1)
    local a, b, n = ws:match("(-?%d+)%s*%a%s*[^%d%-]*(-?%d+)%s*%[%s*(%d+)%s*%]")
    if not a then
      error("texecole : <Étudie la congruence ...> attend une écriture du type "
          .. "3x ≡ 4 [7].", 0)
    end
    a, b, n = math.tointeger(tonumber(a)), math.tointeger(tonumber(b)),
              math.tointeger(tonumber(n))
    local d = pgcd(a, n)
    local L = {}
    L[#L+1] = "On cherche les entiers $x$ tels que $" .. a .. "x \\equiv "
            .. b .. " \\pmod{" .. n .. "}$."
    if b % d ~= 0 then
      L[#L+1] = "\\par Comme $\\mathrm{PGCD}(" .. a .. "\\,;\\," .. n
              .. ") = " .. d .. "$ ne divise pas " .. b
              .. ", la congruence n'a aucune solution."
    else
      local a2, b2, n2 = a // d, b // d, n // d
      local _, u = bezout(a2, n2)
      local x0 = (u * b2) % n2
      if d > 1 then
        L[#L+1] = "\\par Le PGCD de " .. a .. " et " .. n .. " vaut " .. d
                .. ", qui divise " .. b .. " : on simplifie en $" .. a2
                .. "x \\equiv " .. b2 .. " \\pmod{" .. n2 .. "}$."
      end
      L[#L+1] = "\\par Un inverse de " .. a2 .. " modulo " .. n2 .. " est "
              .. (u % n2) .. ", d'où $x \\equiv " .. x0 .. " \\pmod{"
              .. n2 .. "}$."
      local ex = {}
      for k = 0, 2 do ex[#ex+1] = tostring(x0 + k * n2) end
      L[#L+1] = "\\par Les solutions sont donc les entiers $x = " .. x0
              .. " + " .. n2 .. "k$, soit $" .. table.concat(ex, "$, $")
              .. "$, etc."
    end
    pose(api, table.concat(L, "\n"))
  end)

  sl.register_tag("intdiv", function(api, w, c, words_str)
    local ws = (words_str or ""):gsub("^%s*%S+%s*", "", 1)
    local a, b = ws:match("^%s*(-?%d+)%s+(-?%d+)%s*$")
    a, b = a and math.tointeger(tonumber(a)), b and math.tointeger(tonumber(b))
    if not (a and b) or b == 0 then
      error("texecole : la division euclidienne demande deux entiers, le "
        .. "diviseur non nul.", 0)
    end
    local q = a // b
    local r = a - b * q
    if r < 0 then
      q = q + (b > 0 and -1 or 1)
      r = a - b * q
    end
    pose(api, "La division euclidienne de $" .. a .. "$ par $" .. b
      .. "$ s'écrit $" .. a .. " = " .. b .. " \\times "
      .. (q < 0 and ("(" .. q .. ")") or q) .. " + " .. r
      .. "$, avec $0 \\leqslant " .. r .. " < " .. math.abs(b) .. "$.")
  end)

  sl.register_tag("intpgcd", function(api, w, c, words_str)
    local ws = (words_str or ""):gsub("^%s*%S+%s*", "", 1)
    local a, b = ws:match("^%s*(-?%d+)%s+(-?%d+)%s*$")
    a, b = a and math.tointeger(tonumber(a)), b and math.tointeger(tonumber(b))
    if not (a and b) or (a == 0 and b == 0) then
      error("texecole : le PGCD demande deux entiers non tous deux nuls.", 0)
    end
    pose(api, "$\\mathrm{PGCD}(" .. a .. "\\,;\\," .. b .. ") = "
      .. pgcd(a, b) .. "$.")
  end)

  sl.register_tag("dioph", function(api, w, c, words_str)
    local ws = (words_str or ""):gsub("^%s*%S+%s*", "", 1)
    local a, x, b, y, cc = ws:match(
      "^%s*(-?%d+)%s*(%a)%s*%+%s*(-?%d+)%s*(%a)%s*=%s*(-?%d+)%s*$")
    if not a then
      a, x, b, y, cc = ws:match(
        "^%s*(-?%d+)%s*(%a)%s*%-%s*(%d+)%s*(%a)%s*=%s*(-?%d+)%s*$")
      if a then b = "-" .. b end
    end
    if not a then
      error("texecole : <Résous l'équation diophantienne ...> attend une "
        .. "équation ax + by = c à coefficients entiers, par exemple "
        .. "12x + 20y = 8.", 0)
    end
    a, b, cc = math.tointeger(tonumber(a)), math.tointeger(tonumber(b)),
               math.tointeger(tonumber(cc))
    local d = pgcd(a, b)
    local L = {}
    L[#L+1] = "On cherche les couples d'entiers $(" .. x .. "\\,;\\," .. y
      .. ")$ tels que $" .. a .. x .. (b >= 0 and " + " or " - ")
      .. math.abs(b) .. y .. " = " .. cc .. "$."
    if cc % d ~= 0 then
      L[#L+1] = "\\par Comme $\\mathrm{PGCD}(" .. a .. "\\,;\\," .. b
        .. ") = " .. d .. "$ ne divise pas " .. cc
        .. ", l'équation n'a aucune solution entière."
      pose(api, table.concat(L, "\n"))
      return
    end
    local _, u, v = bezout(a, b)
    local k = cc // d
    local x0, y0 = u * k, v * k
    local px, py = b // d, -(a // d)
    if d > 1 then
      L[#L+1] = "\\par $\\mathrm{PGCD}(" .. a .. "\\,;\\," .. b .. ") = "
        .. d .. "$ divise " .. cc .. " : l'équation a des solutions."
    end
    L[#L+1] = "\\par La relation de Bézout $" .. u .. " \\times " .. a
      .. " + " .. v .. " \\times " .. b .. " = " .. d
      .. "$ donne la solution particulière $(" .. x .. "_0\\,;\\," .. y
      .. "_0) = (" .. x0 .. "\\,;\\," .. y0 .. ")$."
    local function terme(p)
      if p >= 0 then return " + " .. (p == 1 and "" or p) .. "k" end
      return " - " .. (p == -1 and "" or -p) .. "k"
    end
    L[#L+1] = "\\par Les solutions sont les couples $\\left(" .. x0
      .. terme(px) .. "\\,;\\, " .. y0 .. terme(py)
      .. "\\right)$, $k \\in \\mathbb{Z}$."
    pose(api, table.concat(L, "\n"))
  end)

  local TRIG = {
    cos = {
      ["1"] = "0", ["racine(3)/2"] = "\\frac{\\pi}{6}",
      ["racine(2)/2"] = "\\frac{\\pi}{4}", ["1/2"] = "\\frac{\\pi}{3}",
      ["0"] = "\\frac{\\pi}{2}", ["-1/2"] = "\\frac{2\\pi}{3}",
      ["-racine(2)/2"] = "\\frac{3\\pi}{4}",
      ["-racine(3)/2"] = "\\frac{5\\pi}{6}", ["-1"] = "\\pi",
    },
    sin = {
      ["0"] = "0", ["1/2"] = "\\frac{\\pi}{6}",
      ["racine(2)/2"] = "\\frac{\\pi}{4}",
      ["racine(3)/2"] = "\\frac{\\pi}{3}", ["1"] = "\\frac{\\pi}{2}",
      ["-1/2"] = "-\\frac{\\pi}{6}", ["-racine(2)/2"] = "-\\frac{\\pi}{4}",
      ["-racine(3)/2"] = "-\\frac{\\pi}{3}", ["-1"] = "-\\frac{\\pi}{2}",
    },
    tan = {
      ["0"] = "0", ["racine(3)/3"] = "\\frac{\\pi}{6}",
      ["1"] = "\\frac{\\pi}{4}", ["racine(3)"] = "\\frac{\\pi}{3}",
      ["-racine(3)/3"] = "-\\frac{\\pi}{6}", ["-1"] = "-\\frac{\\pi}{4}",
      ["-racine(3)"] = "-\\frac{\\pi}{3}",
    },
  }

  local function tex_val(v)
    return (v:gsub("racine%((%d+)%)", "\\sqrt{%1}"):gsub("/", "}{")
             :gsub("^(.*)}{(.*)$", "\\frac{%1}{%2}")
             :gsub("^%-\\frac", "-\\frac"))
  end

  sl.register_tag("trigsolve", function(api, w, c, words_str)
    local ws = (words_str or ""):gsub("^%s*%S+%s*", "", 1)
    local fn, var, val = ws:match(
      "^%s*(%a+)%s*%(%s*(%a)%s*%)%s*=%s*(.-)%s*$")
    if not (fn and TRIG[fn]) then
      error("texecole : <Résous l'équation trigonométrique ...> attend "
        .. "cos(x) = valeur, sin(x) = valeur ou tan(x) = valeur, avec une "
        .. "valeur remarquable (0, ±1, ±1/2, ±racine(2)/2, ±racine(3)/2, "
        .. "±racine(3), ±racine(3)/3).", 0)
    end
    val = val:gsub("%s", ""):gsub("−", "-")
    local alpha = TRIG[fn][val]
    if not alpha then
      local num = tonumber((val:gsub(",", ".")))
      if fn ~= "tan" and num and (num > 1 or num < -1) then
        error("texecole : l'équation " .. fn .. "(" .. var .. ") = " .. val
          .. " n'a aucune solution, " .. fn .. " prenant ses valeurs dans "
          .. "[-1 ; 1].", 0)
      end
      error("texecole : « " .. val:gsub("(%d)%.(%d)", "%1,%2")
        .. " » n'est pas une valeur remarquable "
        .. "de " .. fn .. " — les valeurs reconnues sont 0, ±1, ±1/2, "
        .. "±racine(2)/2, ±racine(3)/2"
        .. (fn == "tan" and ", ±racine(3), ±racine(3)/3" or "") .. ".", 0)
    end
    local vtex = tex_val(val)
    local L = { "On résout $\\" .. fn .. " " .. var .. " = " .. vtex
      .. "$ sur $\\mathbb{R}$, avec la valeur remarquable $\\" .. fn
      .. " \\left(" .. alpha .. "\\right) = " .. vtex .. "$." }
    if fn == "cos" then
      if alpha == "0" or alpha == "\\pi" then
        L[#L+1] = "\\par Les solutions sont les réels $" .. var .. " = "
          .. alpha .. " + 2k\\pi$, $k \\in \\mathbb{Z}$."
      else
        L[#L+1] = "\\par Les solutions sont les réels $" .. var .. " = "
          .. alpha .. " + 2k\\pi$ et $" .. var .. " = -" .. alpha
          .. " + 2k\\pi$, $k \\in \\mathbb{Z}$."
      end
    elseif fn == "sin" then
      local a2
      if alpha == "0" then a2 = "\\pi"
      elseif alpha == "\\frac{\\pi}{2}" or alpha == "-\\frac{\\pi}{2}" then a2 = nil
      elseif alpha:sub(1, 1) == "-" then a2 = "\\pi + " .. alpha:sub(2)
      else a2 = "\\pi - " .. alpha end
      if a2 then
        L[#L+1] = "\\par Les solutions sont les réels $" .. var .. " = "
          .. alpha .. " + 2k\\pi$ et $" .. var .. " = " .. a2
          .. " + 2k\\pi$, $k \\in \\mathbb{Z}$."
      else
        L[#L+1] = "\\par Les solutions sont les réels $" .. var .. " = "
          .. alpha .. " + 2k\\pi$, $k \\in \\mathbb{Z}$."
      end
    else
      L[#L+1] = "\\par Les solutions sont les réels $" .. var .. " = "
        .. alpha .. " + k\\pi$, $k \\in \\mathbb{Z}$."
    end
    pose(api, table.concat(L, "\n"))
  end)

  sl.register_tag("fluct", function(api, w, c, words_str)
    local ws = (words_str or ""):gsub("^%s*%S+%s*", "", 1)
    local n, p = ws:match("^%s*(%d+)%s+(%S+)%s*$")
    local pv = p and tonumber((p:gsub(",", ".")))
    n = n and math.tointeger(tonumber(n))
    if not (n and pv) or pv <= 0 or pv >= 1 then
      error("texecole : <Calcule l'intervalle de fluctuation pour n = ... "
        .. "et p = ...> attend un effectif entier et une proportion "
        .. "strictement entre 0 et 1.", 0)
    end
    local marge = 1 / math.sqrt(n)
    local lo, hi = pv - marge, pv + marge
    local L = { "Au seuil de 95\\,\\%, l'intervalle de fluctuation d'une "
      .. "fréquence sur un échantillon de taille $n = " .. n
      .. "$, pour une proportion $p = " .. nb(pv) .. "$, est" }
    L[#L+1] = "$\\left[\\, p - \\dfrac{1}{\\sqrt{n}}\\,;\\, "
      .. "p + \\dfrac{1}{\\sqrt{n}} \\,\\right] = \\left[\\, " .. nb(lo)
      .. "\\,;\\, " .. nb(hi) .. " \\,\\right]$."
    if n < 25 or pv < 0.2 or pv > 0.8 then
      L[#L+1] = "\\par (Les conditions usuelles $n \\geqslant 25$ et "
        .. "$0{,}2 \\leqslant p \\leqslant 0{,}8$ ne sont pas toutes "
        .. "réunies : l'approximation est à manier avec prudence.)"
    end
    pose(api, table.concat(L, " "))
  end)

  sl.register_tag("bienayme", function(api, w, c, words_str)
    local ws = (words_str or ""):gsub("^%s*%S+%s*", "", 1)
    local mu, va, ec = ws:match("^%s*(%S+)%s+(%S+)%s+(%S+)%s*$")
    local m = mu and tonumber((mu:gsub(",", ".")))
    local v = va and tonumber((va:gsub(",", ".")))
    local a = ec and tonumber((ec:gsub(",", ".")))
    if not (m and v and a) or v < 0 or a <= 0 then
      error("texecole : <Applique l'inégalité de Bienaymé-Tchebychev ...> "
        .. "attend une espérance, une variance positive et un écart "
        .. "strictement positif.", 0)
    end
    local borne = v / (a * a)
    local L = { "Pour une variable aléatoire $X$ d'espérance $\\mu = "
      .. nb(m) .. "$ et de variance $V = " .. nb(v)
      .. "$, l'inégalité de Bienaymé-Tchebychev donne, pour l'écart $a = "
      .. nb(a) .. "$ :" }
    L[#L+1] = "$P\\left(\\,\\lvert X - \\mu \\rvert \\geqslant a\\,\\right) "
      .. "\\leqslant \\dfrac{V}{a^2} = " .. nb(borne) .. "$"
      .. (borne >= 1 and " (borne sans information, car supérieure à 1)."
                     or ".")
    pose(api, table.concat(L, " "))
  end)
end
