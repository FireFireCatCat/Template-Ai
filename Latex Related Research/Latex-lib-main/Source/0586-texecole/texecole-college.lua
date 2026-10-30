local U = require("texecole-util")

local function pgcd(a, b)
  a, b = math.abs(a), math.abs(b)
  while b ~= 0 do a, b = b, a % b end
  return a
end

local function rat(n, d)
  d = d or 1
  if d == 0 then error("texecole : division par zéro.", 0) end
  if d < 0 then n, d = -n, -d end
  local g = pgcd(n, d)
  if g > 1 then n, d = n // g, d // g end
  return { n = n, d = d }
end

local function radd(a, b) return rat(a.n * b.d + b.n * a.d, a.d * b.d) end
local function rsub(a, b) return rat(a.n * b.d - b.n * a.d, a.d * b.d) end
local function rmul(a, b) return rat(a.n * b.n, a.d * b.d) end
local function rdiv(a, b)
  if b.n == 0 then error("texecole : division par zéro.", 0) end
  return rat(a.n * b.d, a.d * b.n)
end
local function rnum(a) return a.n / a.d end
local function rcmp(a, b) return a.n * b.d - b.n * a.d end

local function lire_nombre(s, quoi)
  s = U.trim(tostring(s)):gsub(",", ".")
  local n, d = s:match("^(-?%d+)%s*/%s*(%d+)$")
  if n then return rat(tonumber(n), tonumber(d)) end
  local e, f = s:match("^(-?%d*)%.(%d+)$")
  if e then
    local den = 1
    for _ = 1, #f do den = den * 10 end
    local ent = (e == "" or e == "-") and 0 or math.abs(tonumber(e))
    local num = ent * den + tonumber(f)
    if s:sub(1, 1) == "-" then num = -num end
    return rat(num, den)
  end
  local i = s:match("^(-?%d+)$")
  if i then return rat(tonumber(i)) end
  error("texecole : « " .. U.trim(tostring(s)) .. " » ne se lit pas comme "
    .. "un nombre" .. (quoi and (" (" .. quoi .. ")") or "") .. ".", 0)
end

local function decimal_exact(a)
  local d = a.d
  while d % 2 == 0 do d = d // 2 end
  while d % 5 == 0 do d = d // 5 end
  if d ~= 1 then return nil end
  local neg = a.n < 0
  local n, den = math.abs(a.n), a.d
  local k = 0
  while den > 1 do
    local m = (den % 2 == 0) and 2 or 5
    den = den // m
    n = n * (m == 2 and 5 or 2)
    k = k + 1
  end
  local s = tostring(n)
  if k > 0 then
    while #s <= k do s = "0" .. s end
    s = s:sub(1, #s - k) .. "," .. s:sub(#s - k + 1)
    s = s:gsub("0+$", "")
    if s:sub(-1) == "," then s = s:sub(1, -2) end
  end
  return (neg and "-" or "") .. s:gsub(",", "{,}")
end

local function nb(a)
  local dec = decimal_exact(a)
  if dec then return dec end
  if a.n < 0 then return "-\\dfrac{" .. -a.n .. "}{" .. a.d .. "}" end
  return "\\dfrac{" .. a.n .. "}{" .. a.d .. "}"
end

local function approx(x, prec)
  local s = ("%." .. (prec or 2) .. "f"):format(x)
  s = s:gsub("0+$", ""):gsub("%.$", "")
  return (s:gsub("%.", "{,}"))
end

local function tex_sqrt(a)
  local function sq(v)
    local k, m, dd = 1, v, 2
    while dd * dd <= m do
      while m % (dd * dd) == 0 do m = m // (dd * dd); k = k * dd end
      dd = dd + 1
    end
    return k, m
  end
  local kn, mn = sq(a.n * a.d)
  local g = pgcd(kn, a.d)
  local num, den = kn // g, a.d // g
  if mn == 1 then return nb(rat(num, den)), true end
  local tete = (num == 1) and ("\\sqrt{" .. mn .. "}")
               or (num .. "\\sqrt{" .. mn .. "}")
  if den == 1 then return tete, false end
  return "\\dfrac{" .. tete .. "}{" .. den .. "}", false
end

local function lire_avec(ws)
  local vals, ordre = {}, {}
  local corps = ws:match("avec%s+(.+)$")
  if not corps then return nil end
  corps = corps:gsub("%s+degrés?", "")
  for morceau in (corps:gsub("%s+et%s+", ", ") .. ","):gmatch("(.-),") do
    local nom, val = morceau:match("^%s*(.-)%s*=%s*(.-)%s*$")
    if nom and nom:match("%S") then
      nom = U.trim(nom)
      vals[nom] = lire_nombre(val, nom)
      ordre[#ordre + 1] = nom
    end
  end
  return vals, ordre
end

local ANGLES = {
  cos = { [30] = { "\\dfrac{\\sqrt{3}}{2}", math.sqrt(3) / 2 },
          [45] = { "\\dfrac{\\sqrt{2}}{2}", math.sqrt(2) / 2 },
          [60] = { "\\dfrac{1}{2}", 0.5 } },
  sin = { [30] = { "\\dfrac{1}{2}", 0.5 },
          [45] = { "\\dfrac{\\sqrt{2}}{2}", math.sqrt(2) / 2 },
          [60] = { "\\dfrac{\\sqrt{3}}{2}", math.sqrt(3) / 2 } },
  tan = { [30] = { "\\dfrac{\\sqrt{3}}{3}", math.sqrt(3) / 3 },
          [45] = { "1", 1 },
          [60] = { "\\sqrt{3}", math.sqrt(3) } },
}
local INVERSES = {
  cos = { ["1/2"] = 60, ["1"] = 0 },
  sin = { ["1/2"] = 30, ["1"] = 90 },
  tan = { ["1"] = 45 },
}

return function(sl)
  local function pose(api, s)
    api.raw("emit(" .. string.format("%q", s) .. ")\n")
  end

  local function cotes_triangle(tri, droit)
    local s = { tri:sub(1, 1), tri:sub(2, 2), tri:sub(3, 3) }
    local autres = {}
    for _, v in ipairs(s) do
      if v ~= droit then autres[#autres + 1] = v end
    end
    return autres[1] .. autres[2],
      { autres[1] .. droit, droit .. autres[2] }
  end

  local function meme_segment(a, b)
    return a == b or a == b:sub(2, 2) .. b:sub(1, 1)
  end

  sl.register_tag("pythag", function(api, w, c, words_str)
    local ws = (words_str or ""):gsub("^%s*%S+%s*", "", 1)
    local cible, tri, droit = ws:match("^%s*(%u%u)%s+(%u%u%u)%s+(%u)%s+avec")
    local vals = lire_avec(ws)
    if not (cible and vals) then
      error("texecole : la forme est <Calcule AC dans le triangle ABC "
        .. "rectangle en B, avec AB = 3 et BC = 4>.", 0)
    end
    local hyp, cat = cotes_triangle(tri, droit)
    local function valeur(seg)
      for nom, v in pairs(vals) do
        if meme_segment(nom, seg) then return v, nom end
      end
    end
    local L = { "Dans le triangle $" .. tri .. "$ rectangle en $" .. droit
      .. "$, le théorème de Pythagore donne $" .. hyp .. "^2 = "
      .. cat[1] .. "^2 + " .. cat[2] .. "^2$." }
    local carre
    if meme_segment(cible, hyp) then
      local a = valeur(cat[1])
      local b = valeur(cat[2])
      if not (a and b) then
        error("texecole : pour calculer l'hypoténuse " .. cible
          .. ", donnez les deux côtés de l'angle droit (" .. cat[1]
          .. " et " .. cat[2] .. ").", 0)
      end
      carre = radd(rmul(a, a), rmul(b, b))
      L[#L + 1] = "\\par Donc $" .. cible .. "^2 = " .. nb(a) .. "^2 + "
        .. nb(b) .. "^2 = " .. nb(rmul(a, a)) .. " + " .. nb(rmul(b, b))
        .. " = " .. nb(carre) .. "$."
    else
      local h = valeur(hyp)
      local autre, autre_nom
      for _, seg in ipairs(cat) do
        if not meme_segment(cible, seg) then
          autre, autre_nom = valeur(seg), seg
        end
      end
      if not (h and autre) then
        error("texecole : pour calculer le côté " .. cible .. ", donnez "
          .. "l'hypoténuse " .. hyp .. " et l'autre côté de l'angle "
          .. "droit.", 0)
      end
      carre = rsub(rmul(h, h), rmul(autre, autre))
      if carre.n <= 0 then
        error("texecole : l'hypoténuse " .. hyp .. " doit être le plus "
          .. "grand côté — vérifiez les longueurs données.", 0)
      end
      L[#L + 1] = "\\par Donc $" .. cible .. "^2 = " .. hyp .. "^2 - "
        .. autre_nom .. "^2 = " .. nb(rmul(h, h)) .. " - "
        .. nb(rmul(autre, autre)) .. " = " .. nb(carre) .. "$."
    end
    local rac, exacte = tex_sqrt(carre)
    L[#L + 1] = "\\par D'où $" .. cible .. " = \\sqrt{" .. nb(carre)
      .. "} = " .. rac
      .. (exacte and "" or (" \\approx " .. approx(math.sqrt(rnum(carre)))))
      .. "$."
    pose(api, table.concat(L, "\n"))
  end)

  sl.register_tag("pythagrec", function(api, w, c, words_str)
    local ws = (words_str or ""):gsub("^%s*%S+%s*", "", 1)
    local tri = ws:match("^%s*(%u%u%u)%s+avec")
    local vals, ordre = lire_avec(ws)
    if not (tri and vals and #ordre == 3) then
      error("texecole : la forme est <Vérifie si le triangle ABC est "
        .. "rectangle, avec AB = 3, BC = 4 et AC = 5>.", 0)
    end
    table.sort(ordre, function(x, y) return rcmp(vals[x], vals[y]) < 0 end)
    local p, q, g = ordre[1], ordre[2], ordre[3]
    local cg = rmul(vals[g], vals[g])
    local somme = radd(rmul(vals[p], vals[p]), rmul(vals[q], vals[q]))
    local L = { "Le plus grand côté est $[" .. g .. "]$. D'une part $" .. g
      .. "^2 = " .. nb(cg) .. "$ ; d'autre part $" .. p .. "^2 + " .. q
      .. "^2 = " .. nb(rmul(vals[p], vals[p])) .. " + "
      .. nb(rmul(vals[q], vals[q])) .. " = " .. nb(somme) .. "$." }
    if rcmp(cg, somme) == 0 then
      local sommet
      for ch in tri:gmatch("%a") do
        if not g:find(ch, 1, true) then sommet = ch end
      end
      L[#L + 1] = "\\par Comme $" .. g .. "^2 = " .. p .. "^2 + " .. q
        .. "^2$, la réciproque du théorème de Pythagore assure que le "
        .. "triangle $" .. tri .. "$ est rectangle en $" .. sommet .. "$."
    else
      L[#L + 1] = "\\par Comme $" .. g .. "^2 \\neq " .. p .. "^2 + " .. q
        .. "^2$, le triangle $" .. tri .. "$ n'est pas rectangle "
        .. "(contraposée du théorème de Pythagore)."
    end
    pose(api, table.concat(L, "\n"))
  end)

  local PAIRES = { AM = "AB", AB = "AM", AN = "AC", AC = "AN",
                   MN = "BC", BC = "MN" }

  sl.register_tag("thales", function(api, w, c, words_str)
    local ws = (words_str or ""):gsub("^%s*%S+%s*", "", 1)
    local cible = ws:match("^%s*(%u%u)%s+avec")
    local vals = lire_avec(ws)
    if not (cible and vals and PAIRES[cible]) then
      error("texecole : la forme est <Calcule AC par le théorème de "
        .. "Thalès, avec AM = 3, AB = 6 et AN = 4> — configuration du "
        .. "triangle ABC, M sur [AB], N sur [AC], (MN) parallèle à "
        .. "(BC) ; segments admis : AM, AB, AN, AC, MN, BC.", 0)
    end
    local partenaire = PAIRES[cible]
    local pv = vals[partenaire]
    if not pv then
      error("texecole : pour calculer " .. cible .. ", donnez "
        .. partenaire .. " (l'autre longueur du même rapport) et un "
        .. "rapport complet.", 0)
    end
    local hh
    for _, cand in ipairs({ "AM", "AN", "MN" }) do
      if cand ~= cible and cand ~= partenaire
         and vals[cand] and vals[PAIRES[cand]] then
        hh = cand
      end
    end
    if not hh then
      error("texecole : le théorème de Thalès demande un rapport complet "
        .. "en plus de " .. partenaire .. " — par exemple AM et AB.", 0)
    end
    local bb = PAIRES[hh]
    local haut = (cible == "AM" or cible == "AN" or cible == "MN")
    local L = { "Dans le triangle $ABC$, $M$ appartient à $[AB]$, $N$ "
      .. "appartient à $[AC]$ et $(MN)$ est parallèle à $(BC)$ : le "
      .. "théorème de Thalès donne $\\dfrac{AM}{AB} = \\dfrac{AN}{AC} = "
      .. "\\dfrac{MN}{BC}$." }
    local x
    if haut then
      x = rdiv(rmul(pv, vals[hh]), vals[bb])
      L[#L + 1] = "\\par Donc $\\dfrac{" .. cible .. "}{" .. nb(pv)
        .. "} = \\dfrac{" .. nb(vals[hh]) .. "}{" .. nb(vals[bb])
        .. "}$, d'où $" .. cible .. " = \\dfrac{" .. nb(pv)
        .. " \\times " .. nb(vals[hh]) .. "}{" .. nb(vals[bb]) .. "} = "
        .. nb(x) .. "$."
    else
      x = rdiv(rmul(pv, vals[bb]), vals[hh])
      L[#L + 1] = "\\par Donc $\\dfrac{" .. nb(pv) .. "}{" .. cible
        .. "} = \\dfrac{" .. nb(vals[hh]) .. "}{" .. nb(vals[bb])
        .. "}$, d'où $" .. cible .. " = \\dfrac{" .. nb(pv)
        .. " \\times " .. nb(vals[bb]) .. "}{" .. nb(vals[hh]) .. "} = "
        .. nb(x) .. "$."
    end
    pose(api, table.concat(L, "\n"))
  end)

  sl.register_tag("thalesrec", function(api, w, c, words_str)
    local ws = (words_str or ""):gsub("^%s*%S+%s*", "", 1)
    local vals = lire_avec(ws)
    if not (vals and vals.AM and vals.AB and vals.AN and vals.AC) then
      error("texecole : la forme est <Vérifie si les droites (MN) et "
        .. "(BC) sont parallèles, avec AM = 3, AB = 6, AN = 4 et "
        .. "AC = 8>.", 0)
    end
    local r1 = rdiv(vals.AM, vals.AB)
    local r2 = rdiv(vals.AN, vals.AC)
    local L = { "$\\dfrac{AM}{AB} = \\dfrac{" .. nb(vals.AM) .. "}{"
      .. nb(vals.AB) .. "} = " .. nb(r1) .. "$ \\quad et \\quad "
      .. "$\\dfrac{AN}{AC} = \\dfrac{" .. nb(vals.AN) .. "}{"
      .. nb(vals.AC) .. "} = " .. nb(r2) .. "$." }
    if rcmp(r1, r2) == 0 then
      L[#L + 1] = "\\par Les rapports sont égaux et les points sont "
        .. "placés dans le même ordre : d'après la réciproque du "
        .. "théorème de Thalès, les droites $(MN)$ et $(BC)$ sont "
        .. "parallèles."
    else
      L[#L + 1] = "\\par Les rapports ne sont pas égaux : les droites "
        .. "$(MN)$ et $(BC)$ ne sont pas parallèles."
    end
    pose(api, table.concat(L, "\n"))
  end)

  local function roles(tri, droit, sommet)
    local hyp = cotes_triangle(tri, droit)
    local adj = sommet .. droit
    local opp
    for ch in tri:gmatch("%a") do
      if ch ~= droit and ch ~= sommet then opp = droit .. ch end
    end
    return hyp, adj, opp
  end

  local function seg_role(seg, hyp, adj, opp)
    if meme_segment(seg, hyp) then return "hyp" end
    if meme_segment(seg, adj) then return "adj" end
    if meme_segment(seg, opp) then return "opp" end
  end

  sl.register_tag("trigorect", function(api, w, c, words_str)
    local ws = (words_str or ""):gsub("^%s*%S+%s*", "", 1)
    local cible, tri, droit = ws:match("^%s*(%u%u)%s+(%u%u%u)%s+(%u)%s+avec")
    local vals = lire_avec(ws)
    local sommet, deg = ws:match("l'angle%s+(%u)%s*=%s*([%d,%.]+)")
    if not (cible and vals and sommet) then
      error("texecole : la forme est <Calcule BC dans le triangle ABC "
        .. "rectangle en B, avec l'angle A = 30 degrés et AB = 5>.", 0)
    end
    local angle = tonumber((deg:gsub(",", ".")))
    local hyp, adj, opp = roles(tri, droit, sommet)
    local rc = seg_role(cible, hyp, adj, opp)
    local connu, cv
    for nom, v in pairs(vals) do
      if nom:match("^%u%u$") then
        local r = seg_role(nom, hyp, adj, opp)
        if r and r ~= rc then connu, cv = r, v end
      end
    end
    if not (rc and connu) then
      error("texecole : donnez l'angle et un côté du triangle " .. tri
        .. " différent de " .. cible .. ".", 0)
    end
    local paire = {}
    paire[rc], paire[connu] = true, true
    local fn
    if paire.adj and paire.hyp then fn = "cos"
    elseif paire.opp and paire.hyp then fn = "sin"
    else fn = "tan" end
    local NOMS = { cos = { "adjacent", "hypoténuse" },
                   sin = { "opposé", "hypoténuse" },
                   tan = { "opposé", "adjacent" } }
    local haut = (fn == "cos") and "adj" or "opp"
    local seg_haut = (haut == "adj") and adj or opp
    local seg_bas = (fn == "tan") and adj or hyp
    local rem = ANGLES[fn][angle]
    local vfn = rem and rem[2]
      or (fn == "cos" and math.cos(math.rad(angle))
          or fn == "sin" and math.sin(math.rad(angle))
          or math.tan(math.rad(angle)))
    local dtex = deg:gsub("%.", "{,}"):gsub(",", "{,}")
    local vsym = "\\" .. fn .. "\\left(" .. dtex .. "^{\\circ}\\right)"
    local L = { "Dans le triangle $" .. tri .. "$ rectangle en $" .. droit
      .. "$, relativement à l'angle $\\widehat{" .. sommet .. "}$ : $\\"
      .. fn .. " \\widehat{" .. sommet .. "} = \\dfrac{\\text{"
      .. NOMS[fn][1] .. "}}{\\text{" .. NOMS[fn][2] .. "}} = \\dfrac{"
      .. seg_haut .. "}{" .. seg_bas .. "}$." }
    local res
    if rc == haut then
      res = rnum(cv) * vfn
      L[#L + 1] = "\\par Donc $" .. cible .. " = " .. nb(cv)
        .. " \\times " .. vsym
        .. (rem and (" = " .. nb(cv) .. " \\times " .. rem[1]) or "")
        .. " \\approx " .. approx(res) .. "$."
    else
      res = rnum(cv) / vfn
      L[#L + 1] = "\\par Donc $" .. cible .. " = \\dfrac{" .. nb(cv)
        .. "}{" .. vsym .. "}"
        .. (rem and (" = \\dfrac{" .. nb(cv) .. "}{" .. rem[1] .. "}") or "")
        .. " \\approx " .. approx(res) .. "$."
    end
    pose(api, table.concat(L, "\n"))
  end)

  sl.register_tag("trigoangle", function(api, w, c, words_str)
    local ws = (words_str or ""):gsub("^%s*%S+%s*", "", 1)
    local sommet, tri, droit = ws:match("^%s*(%u)%s+(%u%u%u)%s+(%u)%s+avec")
    local vals = lire_avec(ws)
    if not (sommet and vals) then
      error("texecole : la forme est <Calcule l'angle A dans le triangle "
        .. "ABC rectangle en B, avec AB = 3 et AC = 6>.", 0)
    end
    local hyp, adj, opp = roles(tri, droit, sommet)
    local va, vh, vo
    for nom, v in pairs(vals) do
      local r = seg_role(nom, hyp, adj, opp)
      if r == "adj" then va = v elseif r == "hyp" then vh = v
      elseif r == "opp" then vo = v end
    end
    local fn, num, den, seg_h, seg_b
    if va and vh then fn, num, den, seg_h, seg_b = "cos", va, vh, adj, hyp
    elseif vo and vh then fn, num, den, seg_h, seg_b = "sin", vo, vh, opp, hyp
    elseif vo and va then fn, num, den, seg_h, seg_b = "tan", vo, va, opp, adj
    else
      error("texecole : donnez deux côtés du triangle " .. tri
        .. " pour retrouver l'angle " .. sommet .. ".", 0)
    end
    local r = rdiv(num, den)
    local cle
    if r.n == 1 and r.d == 2 then cle = "1/2"
    elseif r.n == 1 and r.d == 1 then cle = "1" end
    local L = { "Dans le triangle $" .. tri .. "$ rectangle en $" .. droit
      .. "$ : $\\" .. fn .. " \\widehat{" .. sommet .. "} = \\dfrac{"
      .. seg_h .. "}{" .. seg_b .. "} = \\dfrac{" .. nb(num) .. "}{"
      .. nb(den) .. "} = " .. nb(r) .. "$." }
    local exact = cle and INVERSES[fn][cle]
    if exact then
      L[#L + 1] = "\\par D'où $\\widehat{" .. sommet .. "} = " .. exact
        .. "^{\\circ}$."
    else
      local x = rnum(r)
      local a = fn == "cos" and math.deg(math.acos(x))
        or fn == "sin" and math.deg(math.asin(x)) or math.deg(math.atan(x))
      L[#L + 1] = "\\par D'où $\\widehat{" .. sommet .. "} \\approx "
        .. approx(a, 1) .. "^{\\circ}$ (à la calculatrice, touche $\\"
        .. fn .. "^{-1}$)."
    end
    pose(api, table.concat(L, "\n"))
  end)

  local function lire_serie(s)
    local out = {}
    for tok in (s .. ";"):gmatch("(.-);") do
      if U.trim(tok) ~= "" then
        out[#out + 1] = lire_nombre(tok, "la série")
      end
    end
    if #out == 0 then
      error("texecole : la série est vide — écrivez les valeurs séparées "
        .. "par des points-virgules, par exemple 12 ; 15 ; 9.", 0)
    end
    return out
  end

  local function affiche_serie(vs, sep)
    local out = {}
    for _, v in ipairs(vs) do out[#out + 1] = nb(v) end
    return table.concat(out, sep or " \\,;\\, ")
  end

  local function serie_ponderee(ws)
    local vtxt, etxt = ws:match("^%s*(.-)%s*!!%s*(.-)%s*$")
    if vtxt then
      local vs, es = lire_serie(vtxt), lire_serie(etxt)
      if #vs ~= #es then
        error("texecole : " .. #vs .. " valeurs pour " .. #es
          .. " effectifs — les deux listes vont par paires.", 0)
      end
      return vs, es, true
    end
    local vs = lire_serie(ws)
    local es = {}
    for i = 1, #vs do es[i] = rat(1) end
    return vs, es, false
  end

  local function moy_var(vs, es)
    local sx, sx2, n = rat(0), rat(0), rat(0)
    for i = 1, #vs do
      sx = radd(sx, rmul(vs[i], es[i]))
      sx2 = radd(sx2, rmul(rmul(vs[i], vs[i]), es[i]))
      n = radd(n, es[i])
    end
    local m = rdiv(sx, n)
    local v = rsub(rdiv(sx2, n), rmul(m, m))
    return m, v, n
  end

  sl.register_tag("statvar", function(api, w, c, words_str)
    local ws = (words_str or ""):gsub("^%s*%S+%s*", "", 1)
    local vs, es, pond = serie_ponderee(ws)
    local m, v = moy_var(vs, es)
    local formule = pond
      and "V = \\dfrac{1}{N}\\sum n_i\\,(x_i - \\bar{x})^2"
      or "V = \\dfrac{1}{n}\\sum (x_i - \\bar{x})^2"
    pose(api, "La variance vaut $" .. formule .. "$."
      .. "\n\\par Ici, $\\bar{x} = " .. nb(m) .. "$ puis $V = " .. nb(v)
      .. (decimal_exact(v) and "" or (" \\approx " .. approx(rnum(v))))
      .. "$.")
  end)

  sl.register_tag("statstd", function(api, w, c, words_str)
    local ws = (words_str or ""):gsub("^%s*%S+%s*", "", 1)
    local vs, es = serie_ponderee(ws)
    local m, v = moy_var(vs, es)
    local rac = tex_sqrt(v)
    pose(api, "L'écart type vaut $\\sigma = \\sqrt{V}$."
      .. "\n\\par Ici, $\\bar{x} = " .. nb(m) .. "$, $V = " .. nb(v)
      .. "$ puis $\\sigma = \\sqrt{" .. nb(v) .. "} = " .. rac
      .. " \\approx " .. approx(math.sqrt(rnum(v))) .. "$.")
  end)

  sl.register_tag("statcov", function(api, w, c, words_str)
    local ws = (words_str or ""):gsub("^%s*%S+%s*", "", 1)
    local xtxt, ytxt = ws:match("^%s*(.-)%s*!!%s*(.-)%s*$")
    local xs, ys = lire_serie(xtxt or ""), lire_serie(ytxt or "")
    if #xs == 0 or #xs ~= #ys then
      error("texecole : la covariance demande deux séries de même "
        .. "longueur — " .. #xs .. " et " .. #ys .. " valeurs reçues.", 0)
    end
    local sx, sy, sxy, n = rat(0), rat(0), rat(0), rat(#xs)
    for i = 1, #xs do
      sx = radd(sx, xs[i])
      sy = radd(sy, ys[i])
      sxy = radd(sxy, rmul(xs[i], ys[i]))
    end
    local mx, my = rdiv(sx, n), rdiv(sy, n)
    local cov = rsub(rdiv(sxy, n), rmul(mx, my))
    pose(api, "La covariance vaut $\\operatorname{cov}(x, y) = "
      .. "\\dfrac{1}{n}\\sum (x_i - \\bar{x})(y_i - \\bar{y})$."
      .. "\n\\par Ici, $\\bar{x} = " .. nb(mx) .. "$, $\\bar{y} = "
      .. nb(my) .. "$ puis $\\operatorname{cov}(x, y) = " .. nb(cov)
      .. (decimal_exact(cov) and "" or (" \\approx " .. approx(rnum(cov))))
      .. "$.")
  end)

  sl.register_tag("statmoy", function(api, w, c, words_str)
    local ws = (words_str or ""):gsub("^%s*%S+%s*", "", 1)
    local vtxt, etxt = ws:match("^%s*(.-)%s*!!%s*(.-)%s*$")
    if vtxt then
      local vs, es = lire_serie(vtxt), lire_serie(etxt)
      if #vs ~= #es then
        error("texecole : " .. #vs .. " valeurs pour " .. #es
          .. " effectifs — les deux listes vont par paires.", 0)
      end
      local somme, ntot = rat(0), rat(0)
      local termes = {}
      for i = 1, #vs do
        somme = radd(somme, rmul(vs[i], es[i]))
        ntot = radd(ntot, es[i])
        termes[#termes + 1] = nb(vs[i]) .. " \\times " .. nb(es[i])
      end
      local m = rdiv(somme, ntot)
      pose(api, "La moyenne pondérée vaut $\\bar{x} = \\dfrac{"
        .. table.concat(termes, " + ") .. "}{" .. nb(ntot)
        .. "} = \\dfrac{" .. nb(somme) .. "}{" .. nb(ntot) .. "} = "
        .. nb(m)
        .. (decimal_exact(m) and "" or (" \\approx " .. approx(rnum(m))))
        .. "$.")
      return
    end
    local vs = lire_serie(ws)
    local somme = rat(0)
    for _, v in ipairs(vs) do somme = radd(somme, v) end
    local m = rdiv(somme, rat(#vs))
    pose(api, "$\\bar{x} = \\dfrac{" .. affiche_serie(vs, " + ") .. "}{"
      .. #vs .. "} = \\dfrac{" .. nb(somme) .. "}{" .. #vs .. "} = "
      .. nb(m)
      .. (decimal_exact(m) and "" or (" \\approx " .. approx(rnum(m))))
      .. "$.")
  end)

  local function triee(vs)
    local t = { table.unpack(vs) }
    table.sort(t, function(a, b) return rcmp(a, b) < 0 end)
    return t
  end

  sl.register_tag("statmed", function(api, w, c, words_str)
    local ws = (words_str or ""):gsub("^%s*%S+%s*", "", 1)
    local vs = triee(lire_serie(ws))
    local n = #vs
    local L = { "On range la série dans l'ordre croissant : $"
      .. affiche_serie(vs) .. "$ ($" .. n .. "$ valeurs)." }
    if n % 2 == 1 then
      local k = (n + 1) // 2
      L[#L + 1] = "\\par L'effectif est impair : la médiane est la $"
        .. k .. "^{\\text{e}}$ valeur, $m = " .. nb(vs[k]) .. "$."
    else
      local k = n // 2
      local m = rdiv(radd(vs[k], vs[k + 1]), rat(2))
      L[#L + 1] = "\\par L'effectif est pair : la médiane est la "
        .. "demi-somme des $" .. k .. "^{\\text{e}}$ et $" .. (k + 1)
        .. "^{\\text{e}}$ valeurs, $m = \\dfrac{" .. nb(vs[k]) .. " + "
        .. nb(vs[k + 1]) .. "}{2} = " .. nb(m) .. "$."
    end
    pose(api, table.concat(L, "\n"))
  end)

  sl.register_tag("statetendue", function(api, w, c, words_str)
    local ws = (words_str or ""):gsub("^%s*%S+%s*", "", 1)
    local vs = triee(lire_serie(ws))
    local e = rsub(vs[#vs], vs[1])
    pose(api, "L'étendue est l'écart entre la plus grande et la plus "
      .. "petite valeur : $e = " .. nb(vs[#vs]) .. " - " .. nb(vs[1])
      .. " = " .. nb(e) .. "$.")
  end)

  sl.register_tag("statquart", function(api, w, c, words_str)
    local ws = (words_str or ""):gsub("^%s*%S+%s*", "", 1)
    local vs = triee(lire_serie(ws))
    local n = #vs
    local k1 = math.ceil(n / 4)
    local k3 = math.ceil(3 * n / 4)
    pose(api, "Série rangée : $" .. affiche_serie(vs) .. "$ ($" .. n
      .. "$ valeurs).\n\\par Le premier quartile est la $" .. k1
      .. "^{\\text{e}}$ valeur ($\\lceil n/4 \\rceil$) : $Q_1 = "
      .. nb(vs[k1]) .. "$ ; le troisième est la $" .. k3
      .. "^{\\text{e}}$ ($\\lceil 3n/4 \\rceil$) : $Q_3 = " .. nb(vs[k3])
      .. "$.")
  end)

  sl.register_tag("prop4", function(api, w, c, words_str)
    local ws = (words_str or ""):gsub("^%s*%S+%s*", "", 1)
    local a, b, cc = ws:match("^%s*(%S+)%s+(%S+)%s+(%S+)%s*$")
    if not a then
      error("texecole : la forme est <Calcule la quatrième "
        .. "proportionnelle de 3, 5 et 12>.", 0)
    end
    local ra, rb, rc = lire_nombre(a), lire_nombre(b), lire_nombre(cc)
    local x = rdiv(rmul(rb, rc), ra)
    pose(api, "On cherche $x$ tel que $\\dfrac{" .. nb(ra) .. "}{"
      .. nb(rb) .. "} = \\dfrac{" .. nb(rc) .. "}{x}$. Le produit en "
      .. "croix donne $" .. nb(ra) .. " \\times x = " .. nb(rb)
      .. " \\times " .. nb(rc) .. "$, d'où $x = \\dfrac{" .. nb(rb)
      .. " \\times " .. nb(rc) .. "}{" .. nb(ra) .. "} = " .. nb(x)
      .. "$.")
  end)

  local function lire_tableau(inner, quoi)
    local lignes = {}
    for _, l in ipairs(inner) do
      if type(l) == "string" and l:match("%S")
         and not l:match("^%s*}%s*$") then
        local row = {}
        for tok in (l .. ";"):gmatch("(.-);") do
          if U.trim(tok) ~= "" then row[#row + 1] = U.trim(tok) end
        end
        lignes[#lignes + 1] = row
      end
    end
    if #lignes ~= 2 or #lignes[1] ~= #lignes[2] or #lignes[1] < 2 then
      error("texecole : " .. quoi .. " attend deux lignes de même "
        .. "longueur (au moins deux colonnes), les valeurs séparées par "
        .. "des points-virgules.", 0)
    end
    return lignes[1], lignes[2]
  end

  local function tblr(h, b)
    local spec = "|" .. string.rep("c|", #h)
    return "\\begin{center}\\begin{tabular}{" .. spec .. "}\\hline\n"
      .. table.concat(h, " & ") .. " \\\\ \\hline\n"
      .. table.concat(b, " & ") .. " \\\\ \\hline\n"
      .. "\\end{tabular}\\end{center}"
  end

  sl.register_block("proptab", function(api, words_str, inner)
    local h, b = lire_tableau(inner, "le tableau de proportionnalité")
    local coef
    local ok = true
    local rapports = {}
    for i = 1, #h do
      local hv, bv = lire_nombre(h[i]), lire_nombre(b[i])
      if hv.n == 0 then
        error("texecole : une valeur nulle en première ligne empêche le "
          .. "calcul des rapports.", 0)
      end
      local r = rdiv(bv, hv)
      rapports[#rapports + 1] = "$\\dfrac{" .. nb(bv) .. "}{" .. nb(hv)
        .. "} = " .. nb(r) .. "$"
      if not coef then coef = r
      elseif rcmp(coef, r) ~= 0 then ok = false end
    end
    local L = { "On compare les rapports colonne par colonne : "
      .. table.concat(rapports, ", ") .. "." }
    if ok then
      L[#L + 1] = "\\par Tous les rapports sont égaux : le tableau est "
        .. "un tableau de proportionnalité, de coefficient $" .. nb(coef)
        .. "$."
    else
      L[#L + 1] = "\\par Les rapports ne sont pas tous égaux : ce n'est "
        .. "pas un tableau de proportionnalité."
    end
    pose(api, table.concat(L, "\n"))
  end)

  sl.register_block("propcomplete", function(api, words_str, inner)
    local h, b = lire_tableau(inner, "le tableau de proportionnalité")
    local coef
    for i = 1, #h do
      if h[i] ~= "?" and b[i] ~= "?" then
        local hv, bv = lire_nombre(h[i]), lire_nombre(b[i])
        if hv.n ~= 0 then coef = rdiv(bv, hv) end
        if coef then break end
      end
    end
    if not coef then
      error("texecole : il faut au moins une colonne complète (sans ?) "
        .. "pour trouver le coefficient de proportionnalité.", 0)
    end
    local H, B = {}, {}
    for i = 1, #h do
      if h[i] == "?" and b[i] == "?" then
        error("texecole : une colonne entière de ? ne peut pas être "
          .. "complétée.", 0)
      end
      if h[i] == "?" then
        local bv = lire_nombre(b[i])
        H[i] = "$\\mathbf{" .. nb(rdiv(bv, coef)) .. "}$"
        B[i] = "$" .. nb(bv) .. "$"
      elseif b[i] == "?" then
        local hv = lire_nombre(h[i])
        H[i] = "$" .. nb(hv) .. "$"
        B[i] = "$\\mathbf{" .. nb(rmul(hv, coef)) .. "}$"
      else
        H[i] = "$" .. nb(lire_nombre(h[i])) .. "$"
        B[i] = "$" .. nb(lire_nombre(b[i])) .. "$"
      end
    end
    pose(api, "Le coefficient de proportionnalité vaut $" .. nb(coef)
      .. "$ (deuxième ligne $=$ première ligne $\\times " .. nb(coef)
      .. "$) ; les cases complétées sont en gras :\n" .. tblr(H, B))
  end)

  sl.register_tag("pctde", function(api, w, c, words_str)
    local ws = (words_str or ""):gsub("^%s*%S+%s*", "", 1)
    local p, v = ws:match("^%s*(%S+)%s+(%S+)%s*$")
    local rp, rv = lire_nombre(p), lire_nombre(v)
    local res = rmul(rdiv(rp, rat(100)), rv)
    pose(api, "$" .. nb(rp) .. "\\,\\%\\ \\text{de}\\ " .. nb(rv)
      .. " = \\dfrac{" .. nb(rp) .. "}{100} \\times " .. nb(rv) .. " = "
      .. nb(res)
      .. (decimal_exact(res) and ""
          or (" \\approx " .. approx(rnum(res)))) .. "$.")
  end)

  sl.register_tag("pctevo", function(api, w, c, words_str)
    local ws = (words_str or ""):gsub("^%s*%S+%s*", "", 1)
    local sens, p, v = ws:match("^%s*(%S+)%s+(%S+)%s+(%S+)%s*$")
    local rp, rv = lire_nombre(p), lire_nombre(v)
    local aug = (sens == "hausse")
    local cm = aug and radd(rat(1), rdiv(rp, rat(100)))
                   or rsub(rat(1), rdiv(rp, rat(100)))
    local res = rmul(cm, rv)
    pose(api, "Une " .. (aug and "augmentation" or "diminution")
      .. " de $" .. nb(rp) .. "\\,\\%$ revient à multiplier par $1 "
      .. (aug and "+" or "-") .. " \\dfrac{" .. nb(rp) .. "}{100} = "
      .. nb(cm) .. "$. Donc $" .. nb(rv) .. " \\times " .. nb(cm)
      .. " = " .. nb(res)
      .. (decimal_exact(res) and ""
          or (" \\approx " .. approx(rnum(res)))) .. "$.")
  end)

  sl.register_tag("pcttaux", function(api, w, c, words_str)
    local ws = (words_str or ""):gsub("^%s*%S+%s*", "", 1)
    local a, b = ws:match("^%s*(%S+)%s+(%S+)%s*$")
    local ra, rb = lire_nombre(a), lire_nombre(b)
    if ra.n == 0 then
      error("texecole : le taux d'évolution depuis une valeur nulle "
        .. "n'est pas défini.", 0)
    end
    local t = rmul(rdiv(rsub(rb, ra), ra), rat(100))
    local abs_t = rat(math.abs(t.n), t.d)
    pose(api, "$t = \\dfrac{\\text{valeur finale} - \\text{valeur "
      .. "initiale}}{\\text{valeur initiale}} \\times 100 = \\dfrac{"
      .. nb(rb) .. " - " .. nb(ra) .. "}{" .. nb(ra)
      .. "} \\times 100 = " .. nb(t)
      .. (decimal_exact(t) and "" or (" \\approx " .. approx(rnum(t))))
      .. "$ : une " .. (t.n >= 0 and "augmentation" or "diminution")
      .. " de $" .. nb(abs_t) .. "\\,\\%$"
      .. (decimal_exact(t) and "" or " environ") .. ".")
  end)

  local LONG = { km = 5, hm = 4, dam = 3, m = 2, dm = 1, cm = 0, mm = -1 }

  local function en_cm(v, u)
    local e = LONG[u]
    if not e then
      error("texecole : unité de longueur « " .. tostring(u)
        .. " » non reconnue (km, hm, dam, m, dm, cm, mm).", 0)
    end
    local f = rat(1)
    for _ = 1, math.abs(e) do
      f = (e > 0) and rmul(f, rat(10)) or rdiv(f, rat(10))
    end
    return rmul(v, f)
  end

  sl.register_tag("echelle", function(api, w, c, words_str)
    local ws = (words_str or ""):gsub("^%s*%S+%s*", "", 1)
    local vp, up, vr, ur = ws:match(
      "^%s*(%S+)%s+(%S+)%s+(%S+)%s+(%S+)%s*$")
    if not vp then
      error("texecole : la forme est <Calcule l'échelle d'un plan où "
        .. "2 cm représentent 50 m>.", 0)
    end
    local plan = en_cm(lire_nombre(vp), up)
    local reel = en_cm(lire_nombre(vr), ur)
    local e = rdiv(plan, reel)
    pose(api, "L'échelle est le rapport $\\dfrac{\\text{distance sur le "
      .. "plan}}{\\text{distance réelle}}$, les deux dans la même "
      .. "unité : $\\dfrac{" .. nb(plan) .. "\\text{ cm}}{" .. nb(reel)
      .. "\\text{ cm}} = \\dfrac{" .. e.n .. "}{" .. e.d .. "}$"
      .. (e.n == 1 and (" — un centimètre sur le plan représente $"
          .. e.d .. "$ cm dans la réalité.") or "."))
  end)

  local function lire_duree(s)
    s = U.trim(s)
    local h = s:match("([%d,%.]+)%s*h")
    local m = s:match("([%d,%.]+)%s*min")
    local sec = s:match("([%d,%.]+)%s*s%f[%A]")
    if not (h or m or sec) then
      error("texecole : la durée « " .. s .. " » ne se lit pas — écrivez "
        .. "par exemple 2 h 30 min.", 0)
    end
    local t = rat(0)
    if h then t = radd(t, lire_nombre(h)) end
    if m then t = radd(t, rdiv(lire_nombre(m), rat(60))) end
    if sec then t = radd(t, rdiv(lire_nombre(sec), rat(3600))) end
    return t
  end

  local function duree_fr(t)
    local hh = t.n // t.d
    local reste = rsub(t, rat(hh))
    local minutes = rmul(reste, rat(60))
    local mm = minutes.n // minutes.d
    local rsec = rmul(rsub(minutes, rat(mm)), rat(60))
    local out = {}
    if hh > 0 then out[#out + 1] = hh .. "\\text{ h}" end
    if mm > 0 then out[#out + 1] = mm .. "\\text{ min}" end
    if rsec.n > 0 then out[#out + 1] = nb(rsec) .. "\\text{ s}" end
    if #out == 0 then out[1] = "0\\text{ h}" end
    return table.concat(out, "\\,")
  end

  sl.register_tag("vitesse", function(api, w, c, words_str)
    local ws = (words_str or ""):gsub("^%s*%S+%s*", "", 1)
    local d, t = ws:match("^%s*(%S+)%s*!!%s*(.-)%s*$")
    if not d then
      error("texecole : la forme est <Calcule la vitesse moyenne pour "
        .. "150 km en 2 h 30 min>.", 0)
    end
    local rd = lire_nombre(d)
    local rt = lire_duree(t)
    local v = rdiv(rd, rt)
    pose(api, "On convertit la durée : $\\text{" .. U.trim(t) .. "} = "
      .. nb(rt) .. "$ h. La vitesse moyenne vaut $v = \\dfrac{d}{t}$."
      .. "\n\\par Ici, $v = \\dfrac{" .. nb(rd)
      .. "\\text{ km}}{" .. nb(rt) .. "\\text{ h}} = " .. nb(v)
      .. (decimal_exact(v) and "" or (" \\approx " .. approx(rnum(v))))
      .. "\\text{ km/h}$.")
  end)

  sl.register_tag("distance", function(api, w, c, words_str)
    local ws = (words_str or ""):gsub("^%s*%S+%s*", "", 1)
    local v, t = ws:match("^%s*(%S+)%s*!!%s*(.-)%s*$")
    if not v then
      error("texecole : la forme est <Calcule la distance parcourue à "
        .. "80 km/h pendant 1 h 45 min>.", 0)
    end
    local rv = lire_nombre(v)
    local rt = lire_duree(t)
    local d = rmul(rv, rt)
    pose(api, "On convertit la durée : $\\text{" .. U.trim(t) .. "} = "
      .. nb(rt) .. "$ h. La distance vaut $d = v \\times t$."
      .. "\n\\par Ici, $d = " .. nb(rv)
      .. " \\times " .. nb(rt) .. " = " .. nb(d)
      .. (decimal_exact(d) and "" or (" \\approx " .. approx(rnum(d))))
      .. "\\text{ km}$.")
  end)

  sl.register_tag("dureetag", function(api, w, c, words_str)
    local ws = (words_str or ""):gsub("^%s*%S+%s*", "", 1)
    local d, v = ws:match("^%s*(%S+)%s+(%S+)%s*$")
    local rd, rv = lire_nombre(d), lire_nombre(v)
    if rv.n == 0 then
      error("texecole : la vitesse nulle ne permet aucun trajet.", 0)
    end
    local t = rdiv(rd, rv)
    pose(api, "La durée vaut $t = \\dfrac{d}{v}$.\n\\par Ici, $t = "
      .. "\\dfrac{" .. nb(rd) .. "}{" .. nb(rv)
      .. "} = " .. nb(t) .. "\\text{ h} = " .. duree_fr(t) .. "$.")
  end)

  local function avec_pi(coef)
    return nb(coef) .. "\\pi \\approx " .. approx(rnum(coef) * math.pi)
  end

  local MESURES = {
    perimetre = {
      ["carré"] = { np = 1,
        f = function(p) return "P = 4c$ ; ici $P = 4 \\times " .. nb(p[1])
          .. " = " .. nb(rmul(rat(4), p[1])) end },
      ["rectangle"] = { np = 2,
        f = function(p) return "P = 2(L + l)$ ; ici $P = 2 \\times \\left("
          .. nb(p[1]) .. " + " .. nb(p[2]) .. "\\right) = "
          .. nb(rmul(rat(2), radd(p[1], p[2]))) end },
      ["cercle"] = { np = 1,
        f = function(p) return "P = 2\\pi r$ ; ici $P = 2\\pi \\times "
          .. nb(p[1]) .. " = " .. avec_pi(rmul(rat(2), p[1])) end },
      ["triangle"] = { libre = true },
    },
    aire = {
      ["carré"] = { np = 1,
        f = function(p) return "A = c^2$ ; ici $A = " .. nb(p[1])
          .. "^2 = " .. nb(rmul(p[1], p[1])) end },
      ["rectangle"] = { np = 2,
        f = function(p) return "A = L \\times l$ ; ici $A = " .. nb(p[1])
          .. " \\times " .. nb(p[2]) .. " = "
          .. nb(rmul(p[1], p[2])) end },
      ["triangle"] = { np = 2,
        f = function(p) return "A = \\dfrac{b \\times h}{2}$ ; ici $A = "
          .. "\\dfrac{" .. nb(p[1]) .. " \\times " .. nb(p[2]) .. "}{2} = "
          .. nb(rdiv(rmul(p[1], p[2]), rat(2))) end },
      ["disque"] = { np = 1,
        f = function(p) return "A = \\pi r^2$ ; ici $A = \\pi \\times "
          .. nb(p[1]) .. "^2 = " .. avec_pi(rmul(p[1], p[1])) end },
    },
    volume = {
      ["cube"] = { np = 1,
        f = function(p) return "V = a^3$ ; ici $V = " .. nb(p[1])
          .. "^3 = " .. nb(rmul(p[1], rmul(p[1], p[1]))) end },
      ["pavé droit"] = { np = 3,
        f = function(p) return "V = L \\times l \\times h$ ; ici $V = "
          .. nb(p[1]) .. " \\times " .. nb(p[2]) .. " \\times " .. nb(p[3])
          .. " = " .. nb(rmul(p[1], rmul(p[2], p[3]))) end },
      ["cylindre"] = { np = 2,
        f = function(p) return "V = \\pi r^2 h$ ; ici $V = \\pi \\times "
          .. nb(p[1]) .. "^2 \\times " .. nb(p[2]) .. " = "
          .. avec_pi(rmul(rmul(p[1], p[1]), p[2])) end },
      ["pyramide"] = { np = 2,
        f = function(p) return "V = \\dfrac{B \\times h}{3}$ ; ici $V = "
          .. "\\dfrac{" .. nb(p[1]) .. " \\times " .. nb(p[2]) .. "}{3} = "
          .. nb(rdiv(rmul(p[1], p[2]), rat(3))) end },
      ["cône"] = { np = 2,
        f = function(p) return "V = \\dfrac{\\pi r^2 h}{3}$ ; ici $V = "
          .. "\\dfrac{\\pi \\times " .. nb(p[1]) .. "^2 \\times "
          .. nb(p[2]) .. "}{3} = "
          .. avec_pi(rdiv(rmul(rmul(p[1], p[1]), p[2]), rat(3))) end },
      ["boule"] = { np = 1,
        f = function(p) return "V = \\dfrac{4}{3}\\pi r^3$ ; ici $V = "
          .. "\\dfrac{4}{3}\\pi \\times " .. nb(p[1]) .. "^3 = "
          .. avec_pi(rdiv(rmul(rat(4),
              rmul(p[1], rmul(p[1], p[1]))), rat(3))) end },
    },
  }

  sl.register_tag("mesure", function(api, w, c, words_str)
    local ws = (words_str or ""):gsub("^%s*%S+%s*", "", 1)
    local quoi, reste = ws:match("^%s*(%S+)%s+(.+)$")
    reste = (reste or ""):gsub("^%s*de%s+la%s+", ""):gsub("^%s*du%s+", "")
      :gsub("^%s*de%s+l'", ""):gsub("^%s*d'", "")
    local table_q = MESURES[quoi]
    local figure, spec
    for nom, sp in pairs(table_q or {}) do
      local motif = "^" .. nom:gsub("%s+", "%%s+")
      if reste and reste:match(motif) then
        if not figure or #nom > #figure then figure, spec = nom, sp end
      end
    end
    if not spec then
      local noms = {}
      for nom in pairs(table_q or {}) do noms[#noms + 1] = nom end
      table.sort(noms)
      error("texecole : figure non reconnue pour le " .. (quoi or "?")
        .. " — figures connues : " .. table.concat(noms, ", ") .. ".", 0)
    end
    local vals = {}
    for v in reste:gmatch("(%d[%d,%./]*)") do
      vals[#vals + 1] = lire_nombre((v:gsub("[,%.]+$", "")))
    end
    if spec.libre then
      if #vals < 3 then
        error("texecole : le périmètre du triangle demande ses trois "
          .. "côtés — <Calcule le périmètre du triangle de côtés 3, 4 "
          .. "et 5>.", 0)
      end
      local s = rat(0)
      local aff = {}
      for _, v in ipairs(vals) do
        s = radd(s, v); aff[#aff + 1] = nb(v)
      end
      pose(api, "$P = " .. table.concat(aff, " + ") .. " = " .. nb(s)
        .. "$.")
      return
    end
    if #vals ~= spec.np then
      error("texecole : le " .. quoi .. " du " .. figure .. " demande "
        .. spec.np .. " donnée" .. (spec.np > 1 and "s" or "")
        .. " numérique" .. (spec.np > 1 and "s" or "") .. ".", 0)
    end
    pose(api, "$" .. spec.f(vals) .. "$.")
  end)

  local FAMILLES = {
    { dim = 1, unites = { km = 3, hm = 2, dam = 1, m = 0, dm = -1,
                          cm = -2, mm = -3 } },
    { dim = 1, unites = { t = 6, q = 5, kg = 3, hg = 2, dag = 1, g = 0,
                          dg = -1, cg = -2, mg = -3 } },
    { dim = 1, unites = { hL = 2, daL = 1, L = 0, dL = -1, cL = -2,
                          mL = -3 } },
    { dim = 2, unites = { ["km^2"] = 6, ["hm^2"] = 4, ha = 4,
                          ["dam^2"] = 2, a = 2, ["m^2"] = 0,
                          ["dm^2"] = -2, ["cm^2"] = -4, ["mm^2"] = -6 } },
    { dim = 3, unites = { ["km^3"] = 9, ["m^3"] = 0, ["dm^3"] = -3,
                          L = -3, ["cm^3"] = -6, mL = -6,
                          ["mm^3"] = -9 } },
  }

  sl.register_tag("convunit", function(api, w, c, words_str)
    local ws = (words_str or ""):gsub("^%s*%S+%s*", "", 1)
    local val, u1, u2 = ws:match("^%s*([%d,%.]+)%s*(%S+)%s+en%s+(%S+)%s*$")
    if not val then
      error("texecole : la forme est <Convertis 3,5 km en m>.", 0)
    end
    local decal
    for _, f in ipairs(FAMILLES) do
      if f.unites[u1] and f.unites[u2] then
        decal = f.unites[u1] - f.unites[u2]
      end
    end
    if not decal then
      error("texecole : les unités « " .. u1 .. " » et « " .. u2
        .. " » ne sont pas de la même famille connue (longueurs, "
        .. "masses, contenances, aires, volumes — L et mL dialoguent "
        .. "avec dm^3 et cm^3).", 0)
    end
    local mant = val:gsub(",", ".")
    local ent, dec = mant:match("^(%d*)%.?(%d*)$")
    local chiffres = (ent or "") .. (dec or "")
    local virg = #(ent or "") + decal
    while virg > #chiffres do chiffres = chiffres .. "0" end
    while virg < 1 do chiffres = "0" .. chiffres; virg = virg + 1 end
    local res = chiffres:sub(1, virg)
    local frac = chiffres:sub(virg + 1):gsub("0+$", "")
    res = res:gsub("^0+(%d)", "%1")
    if frac ~= "" then res = res .. "{,}" .. frac end
    local function u_tex(u)
      return "\\text{" .. u:gsub("%^(%d)", "}^%1\\text{") .. "}"
    end
    pose(api, "$" .. val:gsub("[%.,]", "{,}") .. "\\," .. u_tex(u1) .. " = "
      .. res .. "\\," .. u_tex(u2) .. "$ (décalage de $"
      .. math.abs(decal) .. "$ rang"
      .. (math.abs(decal) > 1 and "s" or "") .. " vers la "
      .. (decal >= 0 and "droite" or "gauche") .. ").")
  end)

  sl.register_tag("fracdet", function(api, w, c, words_str)
    local ws = (words_str or ""):gsub("^%s*%S+%s*", "", 1)
    local a, b, op, cc, d = ws:match(
      "^%s*(-?%d+)%s*/%s*(%d+)%s*([%+%-%*:])%s*(-?%d+)%s*/%s*(%d+)%s*$")
    if not a then
      error("texecole : la forme est <Calcule 1/2 + 1/3 en détaillant> "
        .. "(opérations : +, -, *, :).", 0)
    end
    a, b, cc, d = tonumber(a), tonumber(b), tonumber(cc), tonumber(d)
    local function tf(n, dd)
      if dd == 1 then return tostring(n) end
      if n < 0 then return "-\\dfrac{" .. -n .. "}{" .. dd .. "}" end
      return "\\dfrac{" .. n .. "}{" .. dd .. "}"
    end
    local L = {}
    if op == "+" or op == "-" then
      local den = (b * d) // pgcd(b, d)
      local n1, n2 = a * (den // b), cc * (den // d)
      L[#L + 1] = "On met les fractions au même dénominateur, $" .. den
        .. "$ : $" .. tf(a, b) .. " = " .. tf(n1, den) .. "$ et $"
        .. tf(cc, d) .. " = " .. tf(n2, den) .. "$."
      local n = (op == "+") and (n1 + n2) or (n1 - n2)
      local res = rat(n, den)
      L[#L + 1] = "\\par Donc $" .. tf(a, b) .. " " .. op .. " "
        .. tf(cc, d) .. " = \\dfrac{" .. n1 .. " " .. op .. " " .. n2
        .. "}{" .. den .. "} = " .. tf(n, den)
        .. ((n ~= res.n or den ~= res.d)
            and (" = " .. tf(res.n, res.d)) or "") .. "$."
    elseif op == "*" then
      local res = rat(a * cc, b * d)
      L[#L + 1] = "On multiplie les numérateurs entre eux et les "
        .. "dénominateurs entre eux : $" .. tf(a, b) .. " \\times "
        .. tf(cc, d) .. " = \\dfrac{" .. a .. " \\times " .. cc .. "}{"
        .. b .. " \\times " .. d .. "} = " .. tf(a * cc, b * d)
        .. ((a * cc ~= res.n or b * d ~= res.d)
            and (" = " .. tf(res.n, res.d)) or "") .. "$."
    else
      if cc == 0 then
        error("texecole : la division par la fraction nulle n'est pas "
          .. "définie.", 0)
      end
      local res = rdiv(rat(a, b), rat(cc, d))
      L[#L + 1] = "Diviser par une fraction, c'est multiplier par son "
        .. "inverse : $" .. tf(a, b) .. " \\div " .. tf(cc, d) .. " = "
        .. tf(a, b) .. " \\times " .. tf(d, cc) .. " = \\dfrac{" .. a
        .. " \\times " .. d .. "}{" .. b .. " \\times " .. cc .. "} = "
        .. tf(res.n, res.d) .. "$."
    end
    pose(api, table.concat(L, "\n"))
  end)

  sl.register_tag("fracsimp", function(api, w, c, words_str)
    local ws = (words_str or ""):gsub("^%s*%S+%s*", "", 1)
    local a, b = ws:match("^%s*(-?%d+)%s*/%s*(%d+)%s*$")
    if not a then
      error("texecole : la forme est <Simplifie la fraction 84/60>.", 0)
    end
    a, b = tonumber(a), tonumber(b)
    local g = pgcd(a, b)
    if g == 1 then
      pose(api, "$\\mathrm{PGCD}(" .. math.abs(a) .. "\\,;\\," .. b
        .. ") = 1$ : la fraction $\\dfrac{" .. a .. "}{" .. b
        .. "}$ est déjà irréductible.")
      return
    end
    pose(api, "$\\mathrm{PGCD}(" .. math.abs(a) .. "\\,;\\," .. b
      .. ") = " .. g .. "$, donc $\\dfrac{" .. a .. "}{" .. b
      .. "} = \\dfrac{" .. (a // g) .. " \\times " .. g .. "}{"
      .. (b // g) .. " \\times " .. g .. "} = \\dfrac{" .. (a // g)
      .. "}{" .. (b // g) .. "}$, irréductible.")
  end)

  sl.register_tag("notasci", function(api, w, c, words_str)
    local ws = (words_str or ""):gsub("^%s*%S+%s*", "", 1)
    local s = U.trim(ws):gsub("%s", ""):gsub(",", ".")
    local neg = s:sub(1, 1) == "-"
    if neg then s = s:sub(2) end
    local ent, dec = s:match("^(%d*)%.?(%d*)$")
    if not ent or (ent == "" and dec == "") then
      error("texecole : la forme est <Écris le nombre 45 600 en "
        .. "notation scientifique>.", 0)
    end
    dec = dec or ""
    local entp = ent:gsub("^0+", "")
    local expn, chiffres
    if entp ~= "" then
      expn = #entp - 1
      chiffres = entp .. dec
    else
      local zeros = #(dec:match("^(0*)"))
      expn = -(zeros + 1)
      chiffres = dec:gsub("^0+", "")
    end
    if chiffres == "" then
      error("texecole : zéro n'a pas de notation scientifique.", 0)
    end
    chiffres = chiffres:gsub("0+$", "")
    if chiffres == "" then chiffres = "1" end
    local mantisse = chiffres:sub(1, 1)
    local reste = chiffres:sub(2)
    if reste ~= "" then mantisse = mantisse .. "{,}" .. reste end
    pose(api, "$" .. (neg and "-" or "")
      .. U.trim(ws):gsub("[%.,]", "{,}"):gsub("%s", "\\,") .. " = "
      .. (neg and "-" or "") .. mantisse .. " \\times 10^{" .. expn
      .. "}$ (un seul chiffre non nul avant la virgule).")
  end)

  sl.register_tag("divisible", function(api, w, c, words_str)
    local ws = (words_str or ""):gsub("^%s*%S+%s*", "", 1)
    local n, p = ws:match("^%s*(%d+)%s+(%d+)%s*$")
    n, p = tonumber(n), tonumber(p)
    if not n or not p or p == 0 then
      error("texecole : la forme est <Vérifie si 456 est divisible "
        .. "par 3>.", 0)
    end
    local nstr = tostring(n)
    local ok = (n % p == 0)
    local L
    if p == 3 or p == 9 then
      local s = 0
      local chiffres = {}
      for ch in nstr:gmatch("%d") do
        s = s + tonumber(ch); chiffres[#chiffres + 1] = ch
      end
      L = "La somme des chiffres de $" .. n .. "$ vaut $"
        .. table.concat(chiffres, " + ") .. " = " .. s .. "$, qui "
        .. (s % p == 0 and "est" or "n'est pas") .. " divisible par $"
        .. p .. "$ : donc $" .. n .. "$ "
        .. (ok and "est" or "n'est pas") .. " divisible par $" .. p
        .. "$."
    elseif p == 2 or p == 5 or p == 10 then
      L = "Le critère de divisibilité par $" .. p .. "$ regarde le "
        .. "chiffre des unités : celui de $" .. n .. "$ est $"
        .. nstr:sub(-1) .. "$, donc $" .. n .. "$ "
        .. (ok and "est" or "n'est pas") .. " divisible par $" .. p
        .. "$."
    else
      local q = n // p
      L = "$" .. n .. " = " .. p .. " \\times " .. q .. " + "
        .. (n - p * q) .. "$ : le reste "
        .. (ok and ("est nul, donc $" .. n .. "$ est divisible par $"
            .. p .. "$.")
            or ("n'est pas nul, donc $" .. n
                .. "$ n'est pas divisible par $" .. p .. "$."))
    end
    pose(api, L)
  end)

  local function pt_rat(s, quoi)
    local x, y = s:match("^%s*(.-)%s*,%s*(.-)%s*$")
    if not x then
      error("texecole : coordonnées illisibles pour " .. (quoi or "?")
        .. " : « " .. tostring(s) .. " ».", 0)
    end
    return { x = lire_nombre(x, quoi), y = lire_nombre(y, quoi) }
  end

  local function pt_flot(p)
    return { fx = rnum(p.x), fy = rnum(p.y) }
  end

  local function co_tex(p)
    if p.x then
      return "(" .. nb(p.x) .. "\\,;\\, " .. nb(p.y) .. ")"
    end
    return "(" .. approx(p.fx) .. "\\,;\\, " .. approx(p.fy) .. ")"
  end

  local function fmt_tikz(v)
    local s = ("%.4f"):format(v):gsub("0+$", ""):gsub("%.$", "")
    return s
  end

  local function xy(p)
    if p.x then return rnum(p.x), rnum(p.y) end
    return p.fx, p.fy
  end

  local TRANSFOS = {
    symax = function(p, spec)

      local ax, ay = spec.p.x, spec.p.y
      local dx, dy = spec.d.x, spec.d.y
      local mx = rsub(p.x, ax)
      local my = rsub(p.y, ay)
      local dd = radd(rmul(dx, dx), rmul(dy, dy))
      local t = rdiv(radd(rmul(mx, dx), rmul(my, dy)), dd)
      local hx = radd(ax, rmul(t, dx))
      local hy = radd(ay, rmul(t, dy))
      return { x = rsub(rmul(rat(2), hx), p.x),
               y = rsub(rmul(rat(2), hy), p.y) }
    end,
    symc = function(p, spec)
      return { x = rsub(rmul(rat(2), spec.c.x), p.x),
               y = rsub(rmul(rat(2), spec.c.y), p.y) }
    end,
    trans = function(p, spec)
      return { x = radd(p.x, spec.v.x), y = radd(p.y, spec.v.y) }
    end,
    hom = function(p, spec)
      return { x = radd(spec.c.x, rmul(spec.k, rsub(p.x, spec.c.x))),
               y = radd(spec.c.y, rmul(spec.k, rsub(p.y, spec.c.y))) }
    end,
    rot = function(p, spec)
      local a = spec.angle % 360
      if spec.sens == "horaire" then a = (360 - a) % 360 end
      local cx, cy = spec.c.x, spec.c.y
      local mx, my = rsub(p.x, cx), rsub(p.y, cy)
      if a % 90 == 0 then
        local q = (a // 90) % 4
        local rxy
        if q == 0 then rxy = { mx, my }
        elseif q == 1 then rxy = { rat(-my.n, my.d), mx }
        elseif q == 2 then rxy = { rat(-mx.n, mx.d), rat(-my.n, my.d) }
        else rxy = { my, rat(-mx.n, mx.d) } end
        return { x = radd(cx, rxy[1]), y = radd(cy, rxy[2]) }
      end
      local th = math.rad(a)
      local fmx, fmy = rnum(mx), rnum(my)
      return { fx = rnum(cx) + fmx * math.cos(th) - fmy * math.sin(th),
               fy = rnum(cy) + fmx * math.sin(th) + fmy * math.cos(th) }
    end,
  }

  local FIGS = { point = 1, segment = 2, triangle = 3,
                 ["quadrilatère"] = 4, polygone = 0 }

  sl.register_tag("transfo", function(api, w, c, words_str)
    local ws = (words_str or ""):gsub("^%s*%S+%s*", "", 1)
    local champs = {}
    for f in (ws .. "|"):gmatch("(.-)|") do
      champs[#champs + 1] = U.trim(f)
    end
    local kind, lettres = champs[1], champs[2]
    local n = FIGS[kind]
    local pts, noms = {}, {}
    local i = 3
    while champs[i] and champs[i]:match("^%u:") do
      local nom, co = champs[i]:match("^(%u):(.*)$")
      noms[#noms + 1] = nom
      pts[#pts + 1] = pt_rat(co, "le point " .. nom)
      i = i + 1
    end
    if n and n > 0 and #pts ~= n then
      error("texecole : le " .. kind .. " demande " .. n .. " point"
        .. (n > 1 and "s" or "") .. " ; " .. #pts .. " reçu"
        .. (#pts > 1 and "s" or "") .. ".", 0)
    end
    local tkind = champs[i]
    local spec = { kind = tkind }
    local phrase, extra
    if tkind == "symax" then
      spec.p = pt_rat(champs[i + 1], "l'axe")
      spec.d = pt_rat(champs[i + 2], "l'axe")
      phrase = "la symétrie axiale d'axe " .. champs[i + 3]
      extra = { axe = true }
    elseif tkind == "symax2" then
      spec.p = pt_rat(champs[i + 1], "l'axe")
      local q = pt_rat(champs[i + 2], "l'axe")
      spec.d = { x = rsub(q.x, spec.p.x), y = rsub(q.y, spec.p.y) }
      if spec.d.x.n == 0 and spec.d.y.n == 0 then
        error("texecole : les deux points de l'axe sont confondus.", 0)
      end
      spec.kind = "symax"
      phrase = "la symétrie axiale d'axe $" .. champs[i + 3] .. "$"
      extra = { axe = true }
    elseif tkind == "symc" then
      spec.c = pt_rat(champs[i + 1], "le centre")
      phrase = "la symétrie centrale de centre $" .. champs[i + 2]
        .. co_tex(spec.c) .. "$"
      extra = { centre = champs[i + 2] }
    elseif tkind == "trans" then
      spec.v = pt_rat(champs[i + 1], "le vecteur")
      phrase = "la translation " .. champs[i + 2]
    elseif tkind == "trans2" then
      local p = pt_rat(champs[i + 1], "la translation")
      local q = pt_rat(champs[i + 2], "la translation")
      spec.v = { x = rsub(q.x, p.x), y = rsub(q.y, p.y) }
      spec.kind = "trans"
      phrase = "la translation " .. champs[i + 3]
    elseif tkind == "rot" then
      spec.c = pt_rat(champs[i + 1], "le centre")
      spec.angle = tonumber((champs[i + 2]:gsub(",", ".")))
      spec.sens = champs[i + 3]
      phrase = "la rotation de centre $" .. champs[i + 4]
        .. co_tex(spec.c) .. "$ et d'angle $"
        .. champs[i + 2]:gsub("%.", "{,}") .. "^{\\circ}$"
        .. (spec.sens == "horaire"
            and " dans le sens des aiguilles d'une montre"
            or " dans le sens direct")
      extra = { centre = champs[i + 4] }
    elseif tkind == "hom" then
      spec.c = pt_rat(champs[i + 1], "le centre")
      spec.k = lire_nombre(champs[i + 2], "le rapport")
      phrase = "l'homothétie de centre $" .. champs[i + 3]
        .. co_tex(spec.c) .. "$ et de rapport $" .. nb(spec.k) .. "$"
      extra = { centre = champs[i + 3] }
    else
      error("texecole : transformation « " .. tostring(tkind)
        .. " » inconnue.", 0)
    end
    local f = TRANSFOS[spec.kind]
    local images = {}
    for _, p in ipairs(pts) do images[#images + 1] = f(p, spec) end

    local xmin, xmax = math.huge, -math.huge
    local ymin, ymax = math.huge, -math.huge
    local function etend(px, py)
      if px < xmin then xmin = px end
      if px > xmax then xmax = px end
      if py < ymin then ymin = py end
      if py > ymax then ymax = py end
    end
    for _, p in ipairs(pts) do etend(xy(p)) end
    for _, p in ipairs(images) do etend(xy(p)) end
    if spec.c then etend(xy(spec.c)) end
    if extra and extra.axe then etend(xy(spec.p)) end
    xmin, xmax = math.floor(xmin) - 1, math.ceil(xmax) + 1
    ymin, ymax = math.floor(ymin) - 1, math.ceil(ymax) + 1
    local etendue = math.max(xmax - xmin, ymax - ymin)
    local ech = (etendue <= 12) and 0.7 or (8.4 / etendue)

    local T = {}
    T[#T + 1] = "\\begin{center}\\begin{tikzpicture}[x="
      .. fmt_tikz(ech) .. "cm, y=" .. fmt_tikz(ech)
      .. "cm, line width=0.5pt]"
    T[#T + 1] = ("\\draw[help lines, color=gray!30] (%d,%d) grid (%d,%d);")
      :format(xmin, ymin, xmax, ymax)

    local function chemin(liste)
      local out = {}
      for _, p in ipairs(liste) do
        local px, py = xy(p)
        out[#out + 1] = "(" .. fmt_tikz(px) .. "," .. fmt_tikz(py) .. ")"
      end
      return out
    end

    if extra and extra.axe then
      local px, py = xy(spec.p)
      local dx, dy = rnum(spec.d.x), rnum(spec.d.y)
      local tmin, tmax = -math.huge, math.huge
      local function borne_t(p0, d0, lo, hi)
        if math.abs(d0) < 1e-12 then return end
        local t1, t2 = (lo - p0) / d0, (hi - p0) / d0
        if t1 > t2 then t1, t2 = t2, t1 end
        if t1 > tmin then tmin = t1 end
        if t2 < tmax then tmax = t2 end
      end
      borne_t(px, dx, xmin, xmax)
      borne_t(py, dy, ymin, ymax)
      if tmin < tmax then
        T[#T + 1] = ("\\draw[dashed, gray] (%s,%s) -- (%s,%s);")
          :format(fmt_tikz(px + tmin * dx), fmt_tikz(py + tmin * dy),
                  fmt_tikz(px + tmax * dx), fmt_tikz(py + tmax * dy))
      end
    end

    if spec.kind ~= "rot" then
      for j = 1, #pts do
        local ax, ay = xy(pts[j])
        local bx, by = xy(images[j])
        T[#T + 1] = ("\\draw[dotted, gray] (%s,%s) -- (%s,%s);")
          :format(fmt_tikz(ax), fmt_tikz(ay), fmt_tikz(bx), fmt_tikz(by))
      end
    end

    local function trace(liste, lnoms, couleur, prime)
      local ch = chemin(liste)
      if #ch >= 2 then
        T[#T + 1] = "\\draw[" .. couleur .. ", thick] "
          .. table.concat(ch, " -- ")
          .. ((#ch >= 3) and " -- cycle;" or ";")
      end
      local cx, cy = 0, 0
      for _, p in ipairs(liste) do
        local px, py = xy(p)
        cx, cy = cx + px, cy + py
      end
      cx, cy = cx / #liste, cy / #liste
      for j, p in ipairs(liste) do
        local px, py = xy(p)
        local ancre
        if #liste == 1 then ancre = "above right"
        else
          ancre = ((py >= cy) and "above" or "below") .. " "
            .. ((px >= cx) and "right" or "left")
        end
        T[#T + 1] = ("\\fill[%s] (%s,%s) circle (1.5pt) "
          .. "node[%s, %s, inner sep=1.5pt, font=\\small] {$%s%s$};")
          :format(couleur, fmt_tikz(px), fmt_tikz(py), ancre, couleur,
                  lnoms[j], prime)
      end
    end
    trace(pts, noms, "blue!70!black", "")
    trace(images, noms, "red!75!black", "'")

    if spec.c then
      local cx, cy = xy(spec.c)
      T[#T + 1] = ("\\draw[gray, thick] (%s,%s) node "
        .. "{$\\boldsymbol{\\times}$} node[below left, inner sep=2pt, "
        .. "font=\\small] {$%s$};")
        :format(fmt_tikz(cx), fmt_tikz(cy), extra.centre)
    end
    if spec.kind == "trans" then
      local ax, ay = xy(pts[1])
      T[#T + 1] = ("\\draw[->, >=stealth, gray, thick] (%s,%s) -- (%s,%s);")
        :format(fmt_tikz(ax), fmt_tikz(ay),
                fmt_tikz(ax + rnum(spec.v.x)),
                fmt_tikz(ay + rnum(spec.v.y)))
    end
    T[#T + 1] = "\\end{tikzpicture}\\end{center}"

    local FIGNOM = { point = "point", segment = "segment",
      triangle = "triangle", ["quadrilatère"] = "quadrilatère",
      polygone = "polygone" }
    local avant, apres = {}, {}
    for j, nom in ipairs(noms) do
      avant[#avant + 1] = nom
      apres[#apres + 1] = "$" .. nom .. "'" .. co_tex(images[j]) .. "$"
    end
    local prose = "Par " .. phrase .. ", l'image du " .. FIGNOM[kind]
      .. " $" .. table.concat(avant, "") .. "$ est le " .. FIGNOM[kind]
      .. " $" .. table.concat(avant, "'") .. "'$, avec "
      .. table.concat(apres, ", ") .. "."
    pose(api, prose .. "\n" .. table.concat(T, "\n"))
  end)

  local function lire_etapes(inner)
    local etapes = {}
    for _, l in ipairs(inner) do
      if type(l) == "string" and l:match("%S")
         and not l:match("^%s*}%s*$") then
        local ligne = U.trim(l)
        if not ligne:match("^[Cc]hoisir") then
          local seul = ligne:match("^élever%s+au%s+carré$")
            or ligne:match("^prendre%s+le%s+carré$")
          local op, v = ligne:match("^(%a+)%s+(.+)$")
          if seul then
            etapes[#etapes + 1] = { op = "carré" }
          elseif op == "ajouter" then
            etapes[#etapes + 1] = { op = "+", v = lire_nombre(v) }
          elseif op == "soustraire" then
            etapes[#etapes + 1] = { op = "-", v = lire_nombre(v) }
          elseif op == "multiplier" then
            etapes[#etapes + 1] = { op = "*",
              v = lire_nombre((v:gsub("^par%s+", ""))) }
          elseif op == "diviser" then
            etapes[#etapes + 1] = { op = "/",
              v = lire_nombre((v:gsub("^par%s+", ""))) }
          else
            error("texecole : étape « " .. ligne .. " » non reconnue — "
              .. "étapes admises : choisir un nombre, ajouter N, "
              .. "soustraire N, multiplier par N, diviser par N, élever "
              .. "au carré.", 0)
          end
        end
      end
    end
    if #etapes == 0 then
      error("texecole : le programme de calcul est vide.", 0)
    end
    return etapes
  end

  local function phrase_etape(e)
    if e.op == "carré" then return "On élève au carré" end
    local verbes = { ["+"] = "On ajoute $%s$", ["-"] = "On soustrait $%s$",
      ["*"] = "On multiplie par $%s$", ["/"] = "On divise par $%s$" }
    return verbes[e.op]:format(nb(e.v))
  end

  sl.register_block("progcalc", function(api, words_str, inner)
    local depart = U.trim(words_str or "")
    local x = lire_nombre(depart, "le nombre de départ")
    local etapes = lire_etapes(inner)
    local L = { "On part de $" .. nb(x) .. "$." }
    local courant = x
    for _, e in ipairs(etapes) do
      local avant = courant
      if e.op == "carré" then courant = rmul(courant, courant)
      elseif e.op == "+" then courant = radd(courant, e.v)
      elseif e.op == "-" then courant = rsub(courant, e.v)
      elseif e.op == "*" then courant = rmul(courant, e.v)
      else courant = rdiv(courant, e.v) end
      L[#L + 1] = "\\par " .. phrase_etape(e) .. " : $" .. nb(avant)
        .. " \\rightarrow " .. nb(courant) .. "$."
    end
    L[#L + 1] = "\\par Le programme renvoie $" .. nb(courant) .. "$."
    pose(api, table.concat(L, "\n"))
  end)

  sl.register_block("progcalcx", function(api, words_str, inner)
    local var = U.trim(words_str or "")
    if var == "" then var = "x" end
    local etapes = lire_etapes(inner)
    local expr = var
    local atome = true
    for _, e in ipairs(etapes) do
      local groupe = atome and expr or ("\\left(" .. expr .. "\\right)")
      if e.op == "carré" then
        expr = groupe .. "^2"
        atome = true
      elseif e.op == "+" or e.op == "-" then
        expr = expr .. " " .. e.op .. " " .. nb(e.v)
        atome = false
      elseif e.op == "*" then
        expr = nb(e.v) .. " \\times " .. groupe
        atome = false
      else
        expr = "\\dfrac{" .. expr .. "}{" .. nb(e.v) .. "}"
        atome = true
      end
    end
    pose(api, "En partant d'un nombre $" .. var .. "$, le programme "
      .. "renvoie $" .. expr .. "$.")
  end)
end
