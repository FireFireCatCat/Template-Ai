local U = require("texecole-util")
local N = require("texecole-numeval")

local SUITES = {}

local function pgcd(a, b)
  a, b = math.abs(a), math.abs(b)
  while b ~= 0 do a, b = b, a % b end
  return a
end

local function lire_fraction(s)
  s = U.trim(s):gsub("%s", "")
  local n, d = s:match("^(-?%d+)/(%d+)$")
  if n then return math.tointeger(tonumber(n)), math.tointeger(tonumber(d)) end
  local e, f = s:match("^(-?%d*)[%.,](%d+)$")
  if e then
    local den = 1
    for _ = 1, #f do den = den * 10 end
    local ent = (e == "" or e == "-") and 0 or math.tointeger(tonumber(e))
    local num = ent * den + math.tointeger(tonumber(f))
    if e:sub(1, 1) == "-" then num = -num end
    return num, den
  end
  local i = s:match("^(-?%d+)$")
  if i then return math.tointeger(tonumber(i)), 1 end
  return nil
end

local function tex_fraction(s)
  local n, d = lire_fraction(s)
  if not n then return s end
  if d == 1 then return tostring(n) end
  if n < 0 then return "-\\frac{" .. (-n) .. "}{" .. d .. "}" end
  return "\\frac{" .. n .. "}{" .. d .. "}"
end

local function decouper_pv(s)
  local out = {}
  for p in (s .. ";"):gmatch("(.-);") do
    local t = U.trim(p)
    if t ~= "" then out[#out + 1] = t end
  end
  return out
end

local function ligne_loi(inner, cle)
  local tout = {}
  for _, l in ipairs(inner) do
    if type(l) == "string" then tout[#tout + 1] = l end
  end
  tout = table.concat(tout, " ")
  local corps = tout:match(cle .. "%s*:%s*%[(.-)%]")
  if not corps then
    corps = tout:match(cle .. "%s*:%s*([^%[]-)%s*$")
  end
  if not corps or not corps:match("%S") then return nil end
  return decouper_pv(corps)
end

return function(sl)
  sl.register_tag("vec", function(api, words, content, words_str)
    local w = (words_str or ""):gsub("^%s*%S+%s*", "", 1)
    local nom = w:match("^%s*([%a][%w_]*)%s+de%s+coordonnées")
    local coords = w:match("de%s+coordonnées%s*%((.-)%)")
    if coords then coords = coords:gsub("%s+", "") end
    if not coords then
      error("texecole : <Écris le vecteur ...> attend des coordonnées, "
          .. "par exemple <Écris le vecteur u de coordonnées (3 ; -2)>.", 0)
    end
    local liste = decouper_pv(coords)
    if #liste < 2 or #liste > 3 then
      error("texecole : un vecteur s'écrit avec deux ou trois coordonnées ; "
          .. "celui-ci en compte " .. #liste .. ".", 0)
    end
    local corps = {}
    for _, v in ipairs(liste) do corps[#corps + 1] = tex_fraction(v) end
    local tete = nom and ("\\vec{" .. nom .. "}\\,") or ""
    local s = "$" .. tete .. "\\begin{pmatrix}" .. table.concat(corps, " \\\\ ")
            .. "\\end{pmatrix}$"
    api.raw("emit(" .. string.format("%q", s) .. ")\n")
  end)

  local corps_problaw = function(api, words_str, inner)
    local nom = (words_str or ""):match("de%s+([%a][%w_]*)") or "X"
    local valeurs = ligne_loi(inner, "valeurs")
    local probas = ligne_loi(inner, "probabilités")
    if not valeurs or not probas then
      error("texecole : <Dresse la loi de probabilité de " .. nom .. "> attend "
          .. "une ligne « valeurs : ... » et une ligne « probabilités : ... ».", 0)
    end
    if #valeurs ~= #probas then
      error("texecole : la loi de " .. nom .. " compte " .. #valeurs
          .. " valeurs pour " .. #probas .. " probabilités : il en manque "
          .. "d'un côté.", 0)
    end
    local num, den = 0, 1
    for _, p in ipairs(probas) do
      local n, d = lire_fraction(p)
      if not n then
        error("texecole : « " .. p .. " » ne se lit pas comme une probabilité ; "
            .. "écrivez un entier, un décimal ou une fraction comme 1/6.", 0)
      end
      num, den = num * d + n * den, den * d
      local g = pgcd(num, den)
      if g > 1 then num, den = num // g, den // g end
      if n < 0 or n > d then
        error("texecole : la probabilité « " .. p .. " » sort de l'intervalle "
            .. "[0 ; 1].", 0)
      end
    end
    if num ~= den then
      error("texecole : les probabilités de la loi de " .. nom .. " totalisent "
          .. num .. "/" .. den .. " au lieu de 1 : ce n'est pas une loi de "
          .. "probabilité.", 0)
    end

    local n = #valeurs
    local spec = "Q[c]"
    for _ = 1, n do spec = spec .. "Q[c]" end
    local out = { "\\begin{center}\\begin{tblr}{colspec={" .. spec
                .. "}, hlines, vlines, colsep=5pt}" }
    local r1 = { "$x_i$" }
    local r2 = { "$P(" .. nom .. " = x_i)$" }
    for i = 1, n do
      r1[#r1 + 1] = "$" .. tex_fraction(valeurs[i]) .. "$"
      r2[#r2 + 1] = "$" .. tex_fraction(probas[i]) .. "$"
    end
    out[#out + 1] = table.concat(r1, " & ") .. " \\\\"
    out[#out + 1] = table.concat(r2, " & ") .. " \\\\"
    out[#out + 1] = "\\end{tblr}\\end{center}"
    api.raw("emit(" .. string.format("%q", table.concat(out, "\n")) .. ")\n")
  end

  local corps_sequence = function(api, words_str, inner)
    local nom = (words_str or ""):match("^%s*([%a][%w_]*)") or "u"
    local def = {}
    for _, l in ipairs(inner) do
      if type(l) == "string" and l:match("%S") and not l:match("^%s*}%s*$") then
        for _, p in ipairs(decouper_pv(l)) do def[#def + 1] = p end
      end
    end
    local u0, rec
    for _, p in ipairs(def) do
      local v = p:match("^" .. nom .. "%s*%(%s*0%s*%)%s*=%s*(.+)$")
      if v then u0 = U.trim(v) end
      local r = p:match("^" .. nom .. "%s*%(%s*n%s*%+%s*1%s*%)%s*=%s*(.+)$")
      if r then rec = U.trim(r) end
    end
    if not u0 or not rec then
      error("texecole : <Définis la suite " .. nom .. " par récurrence> attend "
          .. "un premier terme et une relation, par exemple " .. nom
          .. "(0) = 1 ; " .. nom .. "(n+1) = 2" .. nom .. "(n) + 1.", 0)
    end
    SUITES[nom] = { u0 = u0, rec = rec }
    local s = "$" .. nom .. "_0 = " .. u0 .. "$ \\quad et \\quad $"
            .. nom .. "_{n+1} = "
            .. rec:gsub(nom .. "%s*%(%s*n%s*%)", nom .. "_n") .. "$"
    api.raw("emit(" .. string.format("%q", s) .. ")\n")
  end
  local function loi_moments(inner, nom, quoi)
    local valeurs = ligne_loi(inner, "valeurs")
    local probas = ligne_loi(inner, "probabilités")
    if not valeurs or not probas or #valeurs ~= #probas then
      error("texecole : la loi de " .. nom .. " est incomplète — une "
        .. "ligne « valeurs : ... » et une ligne « probabilités : ... » "
        .. "de même longueur.", 0)
    end
    local function frac(sx)
      local n, d = lire_fraction(sx)
      if not n then
        error("texecole : « " .. sx .. " » ne se lit pas comme un nombre "
          .. "dans la loi de " .. nom .. ".", 0)
      end
      return n, d
    end
    local en, ed = 0, 1
    local e2n, e2d = 0, 1
    for i = 1, #valeurs do
      local xn, xd = frac(valeurs[i])
      local pn, pd = frac(probas[i])
      en, ed = en * xd * pd + xn * pn * ed, ed * xd * pd
      local g = pgcd(en, ed); if g > 1 then en, ed = en // g, ed // g end
      e2n, e2d = e2n * xd * xd * pd + xn * xn * pn * e2d, e2d * xd * xd * pd
      g = pgcd(e2n, e2d); if g > 1 then e2n, e2d = e2n // g, e2d // g end
    end
    local vn, vd = e2n * ed * ed - en * en * e2d, e2d * ed * ed
    local g = pgcd(vn, vd); if g > 1 then vn, vd = vn // g, vd // g end
    return { en = en, ed = ed, vn = vn, vd = vd }
  end

  local function tex_ratio(n, d)
    if d == 1 then return tostring(n) end
    if n < 0 then return "-\\dfrac{" .. -n .. "}{" .. d .. "}" end
    return "\\dfrac{" .. n .. "}{" .. d .. "}"
  end

  local function racine_exacte(n, d)
    local function sq(v)
      local k, m, dd = 1, v, 2
      while dd * dd <= m do
        while m % (dd * dd) == 0 do m = m // (dd * dd); k = k * dd end
        dd = dd + 1
      end
      return k, m
    end
    local kn, mn = sq(n * d)
    local g = pgcd(kn, d)
    local num, den = kn // g, d // g
    if mn == 1 then return tex_ratio(num, den) end
    local tete = (num == 1) and ("\\sqrt{" .. mn .. "}")
                 or (num .. "\\sqrt{" .. mn .. "}")
    if den == 1 then return tete end
    return "\\dfrac{" .. tete .. "}{" .. den .. "}"
  end

  local function approche(x)
    local s = ("%.4f"):format(x):gsub("0+$", ""):gsub("%.$", "")
    return (s:gsub("%.", "{,}"))
  end

  sl.register_block("loimean", function(api, words_str, inner)
    local nom = (words_str or ""):match("([%a][%w_]*)") or "X"
    local m = loi_moments(inner, nom, "mean")
    local s = "$E(" .. nom .. ") = \\sum x_i\\, P(" .. nom
      .. " = x_i)$.\n\\par Ici, $E(" .. nom .. ") = " .. tex_ratio(m.en, m.ed)
    if m.ed ~= 1 then s = s .. " \\approx " .. approche(m.en / m.ed) end
    api.raw("emit(" .. string.format("%q", s .. "$.") .. ")\n")
  end)

  sl.register_block("loivar", function(api, words_str, inner)
    local nom = (words_str or ""):match("([%a][%w_]*)") or "X"
    local m = loi_moments(inner, nom, "var")
    local s = "$V(" .. nom .. ") = E(" .. nom .. "^2) - E(" .. nom
      .. ")^2$.\n\\par Ici, $V(" .. nom .. ") = " .. tex_ratio(m.vn, m.vd)
    if m.vd ~= 1 then s = s .. " \\approx " .. approche(m.vn / m.vd) end
    api.raw("emit(" .. string.format("%q", s .. "$.") .. ")\n")
  end)

  sl.register_block("loistd", function(api, words_str, inner)
    local nom = (words_str or ""):match("([%a][%w_]*)") or "X"
    local m = loi_moments(inner, nom, "std")
    if m.vn < 0 then
      error("texecole : variance négative — la loi de " .. nom
        .. " est incohérente.", 0)
    end
    local exact = racine_exacte(m.vn, m.vd)
    local s = "$\\sigma(" .. nom .. ") = \\sqrt{V(" .. nom
      .. ")}$.\n\\par Ici, $\\sigma(" .. nom .. ") = "
    if exact then
      s = s .. exact
      if not exact:match("^%d+$") then
        s = s .. " \\approx " .. approche(math.sqrt(m.vn / m.vd))
      end
    else
      s = s .. "\\sqrt{" .. tex_ratio(m.vn, m.vd) .. "} \\approx "
        .. approche(math.sqrt(m.vn / m.vd))
    end
    api.raw("emit(" .. string.format("%q", s .. "$.") .. ")\n")
  end)

  sl.register_block("problaw", corps_problaw)
  sl.register_tag("problaw", function(api, w, content, words_str)
    local ws = (words_str or ""):gsub("^%s*%S+%s*", "", 1)
    corps_problaw(api, ws, { content or "" })
  end)
  sl.register_block("sequence", corps_sequence)
  sl.register_tag("sequence", function(api, w, content, words_str)
    local ws = (words_str or ""):gsub("^%s*%S+%s*", "", 1)
    corps_sequence(api, ws, { content or "" })
  end)

  sl.register_tag("seqterms", function(api, words, content, words_str)
    local nom = (words_str or ""):match("nom:(%S+)") or "u"
    local combien = tonumber((words_str or ""):match("n:(%d+)")) or 5
    local d = SUITES[nom]
    if not d then
      error("texecole : <Calcule les premiers termes de " .. nom .. "> demande "
          .. "que la suite ait été définie auparavant par <Définis la suite "
          .. nom .. " par récurrence>.", 0)
    end
    local expr = d.rec:gsub("racine%s*%(", "math.sqrt(")
                      :gsub("abs%s*%(", "math.abs(")
                      :gsub(nom .. "%s*%(%s*n%s*%)", "(__u)")
                      :gsub("(%d)%s*%(", "%1*(")
                      :gsub("(%d)%s*(%a)", "%1*%2")
    local f, err = load(N.inject_locals()
        .. "local __u, n = ... ; return " .. expr)
    if not f then
      error("texecole : la relation « " .. d.rec .. " » ne se calcule pas ("
          .. tostring(err) .. ").", 0)
    end
    local v = tonumber(d.u0)
    if not v then
      error("texecole : le premier terme « " .. d.u0 .. " » n'est pas un "
          .. "nombre.", 0)
    end
    local termes = { { 0, v } }
    for i = 1, combien - 1 do
      local ok, res = pcall(f, v, i - 1)
      if not ok or type(res) ~= "number" then
        error("texecole : la relation « " .. d.rec .. " » ne se calcule pas au "
            .. "rang " .. i .. ".", 0)
      end
      v = res
      termes[#termes + 1] = { i, v }
    end
    local morceaux = {}
    for _, t in ipairs(termes) do
      local val = t[2]
      local aff
      if math.type(val) == "integer" or val == math.floor(val) then
        aff = string.format("%d", val)
      else
        aff = (N.display(val, "{,}", 4))
      end
      morceaux[#morceaux + 1] = "$" .. nom .. "_{" .. t[1] .. "} = " .. aff .. "$"
    end
    api.raw("emit(" .. string.format("%q", table.concat(morceaux, ", ")) .. ")\n")
  end)

  sl.register_tag("cayley", function(api, words, content, words_str)
    local w = words_str or ""
    local n = w:match("[ZZ]%s*/%s*(%d+)%s*[ZZ]")
    if not n then
      error("texecole : <Dresse la table de Cayley du groupe ...> reconnaît "
          .. "pour l'instant les groupes Z/nZ et (Z/nZ)*, écrits ainsi.", 0)
    end
    n = math.tointeger(tonumber(n))
    local mult = w:find("%*") ~= nil
    local elems, signe = {}, "+"
    if mult then
      signe = "\\times"
      for k = 1, n - 1 do
        local a, b = k, n
        while b ~= 0 do a, b = b, a % b end
        if a == 1 then elems[#elems + 1] = k end
      end
      if #elems == 0 then
        error("texecole : (Z/" .. n .. "Z)* est vide.", 0)
      end
    else
      for k = 0, n - 1 do elems[#elems + 1] = k end
    end
    local m = #elems
    local spec = "Q[c]"
    for _ = 1, m do spec = spec .. "Q[c]" end
    local out = { "\\begin{center}\\begin{tblr}{colspec={" .. spec
                .. "}, hlines, vlines, colsep=5pt}" }
    local tete = { "$" .. signe .. "$" }
    for _, e in ipairs(elems) do tete[#tete + 1] = "$" .. e .. "$" end
    out[#out + 1] = table.concat(tete, " & ") .. " \\\\"
    for _, a in ipairs(elems) do
      local r = { "$" .. a .. "$" }
      for _, b in ipairs(elems) do
        local v = mult and (a * b) % n or (a + b) % n
        r[#r + 1] = "$" .. v .. "$"
      end
      out[#out + 1] = table.concat(r, " & ") .. " \\\\"
    end
    out[#out + 1] = "\\end{tblr}\\end{center}"
    api.raw("emit(" .. string.format("%q", table.concat(out, "\n")) .. ")\n")
  end)

  local function etudier_suite(api, words, content, words_str)
    local w = (words_str or ""):gsub("^%s*%S+%s*", "", 1)
    local geo = (words_str or ""):match("^%s*(%S+)") == "suitegeo"
    local u0s = w:match("premier%s+terme%s+(-?[%d%.,/]+)")
    local rs = w:match("raison%s+(-?[%d%.,/]+)")
    if not u0s or not rs then
      error("texecole : <Étudie la suite ...> attend « de premier terme ... et "
          .. "de raison ... ».", 0)
    end
    local function val(t)
      local a, b = t:match("^(-?%d+)/(%d+)$")
      if a then return tonumber(a) / tonumber(b) end
      return tonumber((t:gsub(",", ".")))
    end
    local u0, r = val(u0s), val(rs)
    if not u0 or not r then
      error("texecole : le premier terme ou la raison ne se lit pas comme un "
          .. "nombre.", 0)
    end
    local nom = w:match("^%s*([%a][%w_]*)%s+de%s+premier") or "u"
    local function tx(t) return (t:gsub("/", "}{"):gsub("^(.*)}{(.*)$", "\\frac{%1}{%2}")) end
    local rt = rs:find("/") and tx(rs) or rs:gsub(",", "{,}")
    local L = {}
    if geo then
      L[#L+1] = "La suite $" .. nom .. "$ est géométrique de premier terme $"
              .. nom .. "_0 = " .. u0s:gsub(",", "{,}") .. "$ et de raison $q = "
              .. rt .. "$."
      L[#L+1] = "\\par Son terme général est $" .. nom .. "_n = "
              .. u0s:gsub(",", "{,}") .. " \\times " .. rt .. "^{\\,n}$."
      local sens
      if r > 1 then sens = (u0 > 0) and "croissante" or "décroissante"
      elseif r == 1 then sens = "constante"
      elseif r > 0 then sens = (u0 > 0) and "décroissante" or "croissante"
      else sens = "non monotone, la raison étant négative" end
      L[#L+1] = "\\par Elle est " .. sens .. "."
      local lim
      if math.abs(r) < 1 then lim = "elle converge vers $0$"
      elseif r == 1 then lim = "elle est stationnaire"
      elseif r > 1 then lim = "elle diverge vers " .. ((u0 > 0) and "$+\\infty$" or "$-\\infty$")
      else lim = "elle diverge en oscillant" end
      L[#L+1] = " Comme $|q| " .. ((math.abs(r) < 1) and "<" or (r == 1 and "=" or ">"))
              .. " 1$, " .. lim .. "."
      L[#L+1] = "\\par La somme des $n+1$ premiers termes vaut $S_n = "
              .. u0s:gsub(",", "{,}") .. "\\,\\dfrac{1 - " .. rt
              .. "^{\\,n+1}}{1 - " .. rt .. "}$."
    else
      L[#L+1] = "La suite $" .. nom .. "$ est arithmétique de premier terme $"
              .. nom .. "_0 = " .. u0s:gsub(",", "{,}") .. "$ et de raison $r = "
              .. rt .. "$."
      L[#L+1] = "\\par Son terme général est $" .. nom .. "_n = "
              .. u0s:gsub(",", "{,}") .. ((r >= 0) and " + " or " - ")
              .. (rs:gsub("^-", "")):gsub(",", "{,}") .. "n$."
      local sens = (r > 0) and "croissante" or ((r == 0) and "constante" or "décroissante")
      L[#L+1] = "\\par Elle est " .. sens .. ", et "
              .. ((r == 0) and "constante" or ("diverge vers "
              .. ((r > 0) and "$+\\infty$" or "$-\\infty$"))) .. "."
      L[#L+1] = "\\par La somme des $n+1$ premiers termes vaut $S_n = "
              .. "\\dfrac{(n+1)\\left(" .. nom .. "_0 + " .. nom
              .. "_n\\right)}{2}$."
    end
    api.raw("emit(" .. string.format("%q", table.concat(L, "\n")) .. ")\n")
  end
  sl.register_tag("suitearith", etudier_suite)
  sl.register_tag("suitegeo", etudier_suite)
end
