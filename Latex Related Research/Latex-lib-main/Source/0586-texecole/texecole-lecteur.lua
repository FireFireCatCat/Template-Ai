local V = require("texecole-vocab")
local P = require("texecole-prose")

local L = {}

local function trim(s) return (s:gsub("^%s+", ""):gsub("%s+$", "")) end

local function err(msg) error("texecole : " .. msg, 0) end

local function num_fr(s) return (s:gsub("(%d),(%d)", "%1.%2")) end

local MATH_KEYS_SORTED
local function math_keys()
  if not MATH_KEYS_SORTED then
    MATH_KEYS_SORTED = {}
    for k in pairs(V.MATH_WORDS) do MATH_KEYS_SORTED[#MATH_KEYS_SORTED+1] = k end
    table.sort(MATH_KEYS_SORTED, function(a, b) return #a > #b end)
  end
  return MATH_KEYS_SORTED
end

local CALC_SKIP = {
  ["et"] = true, ["ou"] = true, ["non"] = true,
  ["union"] = true, ["inter"] = true, ["intersection"] = true,
  ["dans"] = true, ["contient"] = true,
}

local W_SET   = "%w_\128-\255"
local MATH_MULTI, MATH_SINGLE
local function math_build()
  if MATH_SINGLE then return end
  MATH_MULTI, MATH_SINGLE = {}, {}
  for _, k in ipairs(math_keys()) do
    if k:find("[^" .. W_SET .. "]") then
      local esc = k:gsub("[%-%s']", "%%%0")
      MATH_MULTI[#MATH_MULTI + 1] = {
        k    = k,
        pat  = "%f[" .. W_SET .. "]" .. esc .. "%f[^" .. W_SET .. "]",
        repl = (V.MATH_WORDS[k]:gsub("%%", "%%%%")),
      }
    else
      MATH_SINGLE[k] = V.MATH_WORDS[k]
    end
  end
end

local function translate_math(expr, calc)
  math_build()
  expr = num_fr(expr)

  expr = expr:gsub("vecteur%s+colonne%s+([%a_][%w_]*)%s*(%b())",
    function(nom, co) return "vec(" .. nom .. ") colvec" .. co end)
  expr = expr:gsub("vecteur%s+([%a_][%w_]*)%s*(%b())",
    function(nom, co) return "vec(" .. nom .. ") vector" .. co end)
  expr = expr:gsub("%s*;%s*", ", ")

  for _, e in ipairs(MATH_MULTI) do
    if not (calc and CALC_SKIP[e.k]) then
      expr = expr:gsub(e.pat, e.repl)
    end
  end

  expr = expr:gsub("%f[" .. W_SET .. "][" .. W_SET .. "]+%f[^" .. W_SET .. "]",
    function(tok)
      if calc and CALC_SKIP[tok] then return nil end
      return MATH_SINGLE[tok]
    end)
  return expr
end

local function translate_math_zones(line)
  line = line:gsub("%$(.-)%$", function(inner)
    return "$" .. translate_math(inner) .. "$"
  end)
  line = line:gsub("#(%b{})", function(braced)
    return "#{" .. translate_math(braced:sub(2, -2), true) .. "}"
  end)
  return line
end

local function inscrire_fn(out, brut)
  local corps = translate_math(brut)
  out[#out + 1] = "<fn " .. corps .. ">"
  L._fns = L._fns or {}
  local fname = corps:match("^([%a_][%w_]*)%s*%(")
  if fname then L._fns[fname] = corps end
end

local function inscrire_fns(out, t)
  if t.fn then inscrire_fn(out, t.fn) end
  if t.fns then
    for _, brut in ipairs(t.fns) do inscrire_fn(out, brut) end
  end
end

local function translate_operators(cond)
  for fr, op in pairs(V.OPERATORS) do
    cond = cond:gsub("%f[%a]" .. fr:gsub(" ", "%%s+") .. "%f[%A]", op)
  end

  cond = cond:gsub("%f[%a]et%f[%A]", "and")
  cond = cond:gsub("%f[%a]ou%f[%A]", "or")
  return num_fr(cond)
end

local function translate_control(line)
  local indp, vp, ap, bp, pp = line:match(
    "^(%s*)pour%s+([%a_][%w_]*)%s+de%s+(%S+)%s+à%s+(%S+)%s+avec%s+un%s+pas%s+de%s+(%S+)%s*{%s*$")
  if vp then
    return indp .. "for " .. vp .. " in " .. num_fr(ap) .. ".."
        .. num_fr(bp) .. " step " .. num_fr(pp) .. " {"
  end
  if line:match("^%s*pour%s+[%a_][%w_]*%s+de%s+%S+%s+à%s+%S+%s+par%s+pas%s+de%s+%S+%s*{%s*$") then
    err("le pas d'une boucle se dit « avec un pas de » : « pour i de "
      .. "0,5 à 2,5 avec un pas de 0,5 { ... } » — comme tout réglage, "
      .. "il s'introduit par « avec » (l'ancienne forme « par pas de » "
      .. "n'existe plus).")
  end

  local ind, v, a, b = line:match("^(%s*)pour%s+([%a_][%w_]*)%s+de%s+(%S+)%s+à%s+(%S+)%s*{%s*$")
  if v then return ind .. "for " .. v .. " in " .. num_fr(a) .. ".." .. num_fr(b) .. " {" end

  local ind2, v2, lst = line:match("^(%s*)pour%s+([%a_][%w_]*)%s+dans%s+(%b[])%s*{%s*$")
  if v2 then return ind2 .. "for " .. v2 .. " in " .. lst .. " {" end

  local ind3, cond = line:match("^(%s*)si%s+(.-)%s*{%s*$")
  if cond then return ind3 .. "if " .. translate_operators(cond) .. " {" end

  local ind3b, cond2 = line:match("^(%s*)}%s*sinon%s+si%s+(.-)%s*{%s*$")
  if cond2 then
    return ind3b .. "} elseif " .. translate_operators(cond2) .. " {"
  end

  if line:match("^%s*}%s*sinon%s*{%s*$") then
    return (line:gsub("sinon", "else"))
  end

  local ind4, wc = line:match("^(%s*)tant%s+que%s+(.-)%s+faire%s*{%s*$")
  if not wc then
    ind4, wc = line:match("^(%s*)tant%s+que%s+(.-)%s*{%s*$")
  end
  if wc then return ind4 .. "while " .. translate_operators(wc) .. " {" end

  local ind6 = line:match("^(%s*)faire%s*{%s*$")
  if ind6 then return ind6 .. "repeat {" end
  local ind7, dc = line:match("^(%s*)}%s*tant%s+que%s+(.-)%s*$")
  if dc and not dc:match("{%s*$") then
    return ind7 .. "} until " .. translate_operators(dc)
  end

  local ind5, rest = line:match("^(%s*)soit%s+(.+)$")
  if rest then return ind5 .. "let " .. num_fr(rest) end

  return nil
end

local function translate_object_words(words, require_avec)
  words = trim(words or "")
  if words == "" then return "" end

  if require_avec then
    local placement, apres = words:match("^(%b[])%s*(.*)$")
    local prefixe = ""
    if placement then
      prefixe = placement .. " "
    else
      apres = words
    end
    apres = trim(apres)
    if apres ~= "" then
      local corps = apres:match("^avec%s+(.+)$")
      if not corps then
        err("liste d'attributs mal introduite : « " .. apres .. " ». "
          .. "Les attributs d'un objet s'ouvrent par « avec » : écrivez "
          .. "par exemple « " .. trim(prefixe) .. " avec bordures, entête "
          .. "et fond bleu Alice » — virgules entre les attributs, « et » "
          .. "avant le dernier.")
      end
      apres = corps
    end
    return translate_object_words(prefixe .. apres)
  end

  do
    local buf, depth = {}, 0
    local i, n = 1, #words
    while i <= n do
      local c = words:sub(i, i)
      if c == "{" or c == "[" or c == "(" then depth = depth + 1 end
      if c == "}" or c == "]" or c == ")" then depth = depth - 1 end
      if depth == 0 and words:sub(i, i + 3) == " et " then
        buf[#buf + 1] = ", "; i = i + 4
      else
        buf[#buf + 1] = c; i = i + 1
      end
    end
    words = table.concat(buf)
  end
  words = words:gsub("(entête en [%a%s'éèêàâîôûç%-]-),%s*(sur fond)", "%1 %2")
  words = words:gsub("(titre en [%a%s'éèêàâîôûç%-]-),%s*(sur fond)", "%1 %2")

  local out = {}

  words = words:gsub("%b[]", function(br)
    local inner = br:sub(2, -2)
    local nom, pospart = inner:match("^(.-)%s*:%s*(.+)$")
    local src = pospart or inner
    local codes, vert, horiz = {}, nil, nil
    if nom then codes[#codes + 1] = trim(nom) end
    local VNAT = { haut = "t", milieu = "m", bas = "b" }
    local HNAT = { gauche = "l", centre = "c", droite = "r" }
    for piece in src:gmatch("[^,]+") do
      local p = trim(piece)
      local nu = p:gsub("^en%s+", ""):gsub("^au%s+", ""):gsub("^à%s+", "")
      if VNAT[nu] then vert = VNAT[nu]
      elseif HNAT[nu] then horiz = HNAT[nu]
      elseif V.PLACE[nu] then codes[#codes + 1] = V.PLACE[nu]
      elseif V.PLACE[p] then codes[#codes + 1] = V.PLACE[p]
      else codes[#codes + 1] = p
      end
    end
    if vert or horiz then
      codes[#codes + 1] = (vert or "m") .. (horiz or "c")
    end
    return "[" .. table.concat(codes, ", ") .. "]"
  end)

  if words:match("%f[%w_\128-\255]bordée?%s+de%f[%W]") then
    err("« bordé de » n'existe plus : la couleur de bordure se dit avec "
      .. "le nom et son article — « une bordure bleue », « une bordure "
      .. "bleu marine » (règle n°11, l'attribut est un nom, pas un "
      .. "adjectif).")
  end

  for _, rule in ipairs(V.PROSE_ATTRS) do
    local lua_pat = rule._luapat
    if not lua_pat then
      lua_pat = rule.pat
        :gsub("[%%%-%(%)%.%+%*%?%[%]%^%$]", "%%%0")
        :gsub("«C»", "([%%a%%s'éèêàâîôûç%%-]+)")
        :gsub("«W»", "([%%a_][%%w_]*)")
        :gsub("«N»", "([%%d,%%.]+)")
        :gsub("«B»", "(%%b{})")
        :gsub("«BR»", "(%%b[])")
        :gsub("«PCT»", "%%%%")
      rule._luapat = lua_pat
    end
    words = words:gsub(lua_pat, function(c1, c2)
      local keys = type(rule.key) == "table" and rule.key or { rule.key }
      local caps = { c1, c2 }
      local frag = {}
      for i, key in ipairs(keys) do
        if rule.bare then
          frag[#frag + 1] = key
        else
        local v = rule.value or caps[i]
        if not rule.value then
          local raw = trim(v or "")
          local svg = V.color(raw)
          local reste = nil
          if not svg and rule.pat:find("«C»") then
            for _, ck in ipairs(V.color_keys_sorted()) do
              local suite = raw:match("^" .. ck:gsub("[%-']", "%%%0")
                                   .. "%f[^%w_\128-\255]%s*(.*)$")
              if suite then
                svg, reste = V.COLORS[ck], suite
                break
              end
            end
          end
          if svg then v = svg
          elseif raw:match("^[%d,%.]+$") then v = num_fr(raw)
          elseif raw:match("^%b{}$") then
            v = num_fr(raw):gsub("%s*;%s*", ", ")
          elseif raw:match("^%b[]$") then
            v = raw
          elseif rule.pat:find("«W»") and raw:match("^[%a_][%w_]*$") then
            v = raw
          else
            return nil
          end
        end
          frag[#frag + 1] = key .. ":" .. (v or "on")
          if reste and reste ~= "" then frag[#frag + 1] = reste end
        end
      end
      return table.concat(frag, " ")
    end)
  end

  words = words:gsub("données%s*(%b{})", function(b)
    local inner = b:sub(2, -2)
    if inner:find(":") then
      return "data:{" .. num_fr(inner):gsub("%s*;%s*", " | ") .. "}"
    end
    return "data:{" .. num_fr(inner):gsub("%s*;%s*", ", ") .. "}"
  end)
  words = words:gsub("pas%s+de%s+(%$.-%$)", function(m)
    return "step:{" .. m:sub(2, -2) .. "}"
  end)
  words = words:gsub("pas%s+de%s+([%d,%.]+)", function(n)
    return "step:" .. n:gsub(",", ".")
  end)
  words = words:gsub("([%d,%.]+)%s*mm%s+sur%s+([%d,%.]+)%s*mm",
    function(a, b) return a:gsub(",", ".") .. "x" .. b:gsub(",", ".") end)

  words = words:gsub("(%d+)%s+(tabulations?)%f[^%w]", "%1%2")
  words = words:gsub("(%d+)%s+(lignes?)%f[^%w]", "%1%2")

  words = words:gsub("%f[%w_]exposant%s+(%d+)mm", "up%1")
  words = words:gsub("%f[%w_]indice%s+(%d+)mm",   "down%1")
  words = words:gsub("%f[%w_]exposant%f[^%w_]", "up2")
  words = words:gsub("%f[%w_]indice%f[^%w_]",   "down1")

  local mw = {}
  for k in pairs(V.STYLE_WORDS) do
    if k:find(" ") then mw[#mw+1] = k end
  end
  table.sort(mw, function(a, b) return #a > #b end)
  for _, k in ipairs(mw) do
    local w = "%w_\128-\255"
    local pat = "%f[" .. w .. "]" .. k:gsub("[%-%s']", "%%%0")
             .. "%f[^" .. w .. "]"
    words = words:gsub(pat, V.STYLE_WORDS[k])
  end

  do
    local cleaned, d = {}, 0
    for i = 1, #words do
      local ch = words:sub(i, i)
      if ch == "{" or ch == "[" then d = d + 1 end
      if ch == "}" or ch == "]" then d = d - 1 end
      if ch == "," and d == 0 then ch = " " end
      cleaned[#cleaned + 1] = ch
    end
    words = table.concat(cleaned):gsub("%f[%w_]et%f[^%w_]", " ")
    for _, mot in ipairs({ "avec", "les", "des", "un", "une", "le", "la" }) do
      words = words:gsub("%f[%w_]" .. mot .. "%f[^%w_]", " ")
    end
    words = words:gsub("%f[%w_]l'", "")
  end

  local tokens, buf, depth = {}, {}, 0
  for i = 1, #words do
    local ch = words:sub(i, i)
    if ch == "{" then depth = depth + 1 end
    if ch == "}" then depth = depth - 1 end
    if depth == 0 and ch:match("%s") then
      if #buf > 0 then tokens[#tokens+1] = table.concat(buf); buf = {} end
    else
      buf[#buf+1] = ch
    end
  end
  if #buf > 0 then tokens[#tokens+1] = table.concat(buf) end
  for _, word in ipairs(tokens) do
    local done = false

    local k, v = word:match("^([%wéèê_]+):(.+)$")
    if k then
      v = v:gsub("^%$(.-)%$$", "{%1}")
      out[#out + 1] = (V.KV_KEYS[k] or k) .. ":" .. num_fr(v)
      done = true
    end

    if not done then
      local n, radical = word:match("^(%d+)([%aé]+)$")
      if n and V.COUNTED_WORDS[radical] then
        out[#out + 1] = n .. V.COUNTED_WORDS[radical]
        done = true
      end
    end

    if not done and V.STYLE_WORDS[word] then
      out[#out + 1] = V.STYLE_WORDS[word]; done = true
    end

    if not done then
      out[#out + 1] = word
    end
  end

  local joined = table.concat(out, " ")
  local shelters = {}
  joined = joined:gsub("%b{}", function(g)
    shelters[#shelters + 1] = g
    return "\1" .. #shelters .. "\1"
  end)
  for _, k in ipairs(V.color_keys_sorted()) do
    local w = "%w_\128-\255"
    local pat = "%f[" .. w .. "]" .. k:gsub("[%-']", "%%%0")
             .. "%f[^" .. w .. "]"
    joined = joined:gsub(pat, V.COLORS[k])
  end
  joined = joined:gsub("\1(%d+)\1", function(n)
    return shelters[tonumber(n)]
  end)
  return joined
end

local ENGLISH_TAGS = {
  table = "tableau", box = "cadre", list = "liste", img = "image",
  grid = "grille", area = "zone", matrix = "matrice", bmatrix = "matrice entre crochets",
  system = "système", vartab = "tableau de variations",
  signtab = "tableau de signes", numberline = "droite graduée",
  tree = "arbre", stats = "statistique", plot = "Trace la fonction ...",
  draw = "Trace ...", fn = "Soit une fonction ...",
  section = "section", subsection = "sous-section", toc = "sommaire",
}

local TAGS_KEYS_SORTED
local function tags_keys()
  if not TAGS_KEYS_SORTED then
    TAGS_KEYS_SORTED = {}
    for k in pairs(V.TAGS) do TAGS_KEYS_SORTED[#TAGS_KEYS_SORTED+1] = k end
    table.sort(TAGS_KEYS_SORTED, function(a, b) return #a > #b end)
  end
  return TAGS_KEYS_SORTED
end

local function translate_tag_head(head)
  for _, v in ipairs(V.VERBES_OBJET) do
    local rest = head:match("^" .. v .. "%s+(.*)$")
    if rest then head = rest; break end
  end
  head = head:gsub("^[Uu]ne?%s+", ""):gsub("^[Ll]es?%s+", "")
             :gsub("^[Dd]es%s+", ""):gsub("^[Ll]a%s+", "")
             :gsub("^[Ll]'", ""):gsub("^[Ll]\u{2019}", "")
  local first = head:match("^([%a_][%w_]*)")
  if first and ENGLISH_TAGS[first] then
    local francais = false
    for _, k in ipairs(tags_keys()) do
      if head:find("^" .. k:gsub("[%-%s']", "%%%0") .. "%f[^%w_\128-\255]")
         or head == k then
        francais = true; break
      end
    end
    if not francais then
      error("texecole : « <" .. first .. " » est du scholatex. En texecole, "
        .. "on écrit « <" .. ENGLISH_TAGS[first] .. " ... » — une seule "
        .. "façon de dire chaque chose.", 0)
    end
  end
  local lst = head:match("^liste%s*(.*)$")
  if lst ~= nil then
    local style, rest = nil, lst
    local k, v, r = V.longest_match(V.LIST_STYLES, trim(lst))
    if k then style, rest = v, r end
    local words = translate_object_words(rest, true)
    return "list" .. (style and (":" .. style) or "") ..
           (words ~= "" and (" " .. words) or "")
  end

  local st = head:match("^statistique%s+en%s+(.*)$")
           or head:match("^statistique%s+(.*)$")
  if st then
    local k, v, r = V.longest_match(V.STATS_KINDS, trim(st))
    if k then
      return "stats kind:" .. v .. " " .. translate_object_words(r, true)
    end
    return "stats " .. translate_object_words(st, true)
  end

  local vt, vkv = head:match("^tableau de variations%s+de%s+([%a_][%w_]*)%s*,?%s*(.*)$")
  if vt then
    vkv = trim(vkv or "")
    if vkv ~= "" then
      local def = L._fns and L._fns[vt]
      if not def then
        error("texecole : le tableau de variations de « " .. vt
          .. " » avec rangées demande que la fonction ait été posée "
          .. "par <Soit>une fonction " .. vt .. "(x) = ... auparavant.", 0)
      end
      return "fn " .. def .. "\n            "
          .. translate_object_words(translate_math(vkv))
          .. ">\n<vartab " .. vt
    end
    return "vartab " .. vt
  end
  local sg = head:match("^tableau de signes%s+de%s+(%S+)%s*$")
  if sg then return "signtab " .. sg end
  local sgb = head:match("^tableau de signes%s+(.+)$")
  if sgb then return "signtab " .. translate_math(sgb) end

  local snom, srest = head:match(
    "^suite%s+([%a][%w_]*)%s+arithmétique%s+(.+)$")
  if snom then return "suitearith " .. snom .. " " .. srest end
  local gnom, grest = head:match(
    "^suite%s+([%a][%w_]*)%s+géométrique%s+(.+)$")
  if gnom then return "suitegeo " .. gnom .. " " .. grest end

  local k, spec, rest = V.longest_match(V.TAGS, head)
  if k and spec.libre then
    rest = trim(rest or "")
    return spec.name .. (rest ~= "" and (" " .. rest) or "")
  end
  if k then
    local words = translate_object_words(rest, true)
    return spec.name .. (words ~= "" and (" " .. words) or "")
  end

  return translate_object_words(head)
end

local CALC_NOUNS = {
  ["la dérivée seconde de"] = "Dérivée seconde de",
  ["la dérivée de"]         = "Dérivée de",
  ["la primitive de"]       = "Primitive de",
  ["les zéros de"]          = "Zéros de",
  ["les racines carrées de"]    = "Racines carrées de",
  ["les racines cubiques de"]   = "Racines cubiques de",
  ["les racines quatrièmes de"] = "Racines quatrièmes de",
  ["les racines cinquièmes de"] = "Racines cinquièmes de",
  ["les racines sixièmes de"]   = "Racines sixièmes de",
  ["les racines septièmes de"]  = "Racines septièmes de",
  ["les racines huitièmes de"]  = "Racines huitièmes de",
  ["les racines neuvièmes de"]  = "Racines neuvièmes de",
  ["les racines dixièmes de"]   = "Racines dixièmes de",
  ["les racines onzièmes de"]   = "Racines onzièmes de",
  ["les racines douzièmes de"]  = "Racines douzièmes de",
  ["la limite de"]          = "Limite de",
  ["le développement limité de"] = "Développement limité de",
  ["la forme canonique de"] = "Forme canonique de",
  ["l'intégrale numérique de"] = "Intégrale numérique de",
  ["les valeurs propres de"] = "Valeurs propres de",
  ["le déterminant de"]     = "Déterminant de",
  ["l'inverse de"]          = "Inverse de",
  ["la somme de"]           = "Somme de",
  ["le produit de"]         = "Produit de",
  ["l'espérance de"]        = "Espérance de",
  ["l'écart type de"]       = "Écart type de",
  ["le quantile"]           = "Quantile",
  ["la probabilité que"]    = "Probabilité que",
  ["la convexité de"]       = "Convexité de",
  ["les asymptotes de"]     = "Asymptotes de",
  ["la puissance"]          = "Puissance",
  ["l'état stable de"]      = "État stable de",
  ["le produit scalaire de"] = "Produit scalaire de",
  ["la norme de"]           = "Norme de",
  ["la colinéarité de"]     = "Colinéarité de",
  ["un vecteur normal de"]  = "Vecteur normal de",
  ["un vecteur normal au plan"] = "Vecteur normal de",
  ["l'intégrale de"]        = "Intégrale de",
  ["un équivalent de"]      = "Équivalent de",
  ["la nature de la série de terme général"] = "Nature de la série de terme général",
  ["la nature de l'intégrale de"] = "Nature de l'intégrale de",
  ["le rang de"]            = "Rang de",
  ["le noyau de"]           = "Noyau de",
  ["l'image de"]            = "Image de",
  ["le polynôme caractéristique de"] = "Polynôme caractéristique de",
  ["le polynôme minimal de"] = "Polynôme minimal de",
  ["le projeté orthogonal de"] = "Projeté orthogonal de",
  ["le gradient de"]        = "Gradient de",
  ["la matrice hessienne de"] = "Matrice hessienne de",
  ["les points critiques de"] = "Points critiques de",
  ["la dérivée partielle de"] = "Dérivée partielle de",
  ["la variance de"]        = "Variance de",
  ["le PGCD de"]            = "PGCD de",
  ["la série de Fourier de"] = "Série de Fourier de",
  ["la transformée de Laplace de"] = "Transformée de Laplace de",
  ["la transformée de Laplace inverse de"] = "Transformée de Laplace inverse de",
  ["le wronskien de"]       = "Wronskien de",
  ["la moyenne de la série"] = "Moyenne de la série",
  ["la covariance des séries"] = "Covariance des séries",
  ["la médiane de la série"] = "Médiane de la série",
  ["l'étendue de la série"] = "Étendue de la série",
  ["les quartiles de la série"] = "Quartiles de la série",
  ["la quatrième proportionnelle de"] = "Quatrième proportionnelle de",
  ["le taux d'évolution de"] = "Taux d'évolution de",
  ["la vitesse moyenne pour"] = "Vitesse moyenne pour",
  ["la distance parcourue à"] = "Distance parcourue à",
  ["la durée du trajet de"] = "Durée du trajet de",
  ["le périmètre"]          = "Périmètre",
  ["l'aire"]                = "Aire",
  ["le volume"]             = "Volume",
  ["l'échelle d'un plan où"] = "Échelle où",
}

local CALC_VERBS = {
  "Calcule", "Détermine", "Donne", "Cherche", "Trouve", "Établis", "Évalue",
  "Étudie",
}

local function normaliser_action_calcul(line)
  local ind, inner = line:match("^(%s*)<(.+)>%s*$")
  if not inner then return line end
  for _, v in ipairs(CALC_VERBS) do
    local reste = inner:match("^" .. v .. "%s+(.+)$")
    if reste then
      for fr, interne in pairs(CALC_NOUNS) do
        local arg = reste:match("^" .. fr:gsub("[%-']", "%%%0") .. "%s+(.+)$")
        if arg then
          return ind .. "<" .. interne .. " " .. arg .. ">"
        end
      end
      local ordinal = reste:match("^les%s+racines%s+([%a\128-\255]+)%s+de%s+")
      if ordinal then
        err("racines « " .. ordinal .. " » : ordinal non reconnu. Les "
          .. "racines n-ièmes se disent en toutes lettres, de « carrées » "
          .. "à « douzièmes » : <Calcule les racines cinquièmes de "
          .. "l'unité>, <Calcule les racines cubiques de 8i>.")
      end
    end
  end
  return line
end

local CALC_NOUNS_PLURIELS = {
  ["les dérivées secondes de"]  = "la dérivée seconde de",
  ["les dérivées de"]           = "la dérivée de",
  ["les primitives de"]         = "la primitive de",
  ["les formes canoniques de"]  = "la forme canonique de",
  ["les déterminants de"]       = "le déterminant de",
  ["les inverses de"]           = "l'inverse de",
  ["les espérances de"]         = "l'espérance de",
  ["les écarts types de"]       = "l'écart type de",
  ["les zéros de"]              = "les zéros de",
  ["les valeurs propres de"]    = "les valeurs propres de",
}

local CALC_PLURIELS_ORDONNES = {}
for k in pairs(CALC_NOUNS_PLURIELS) do
  CALC_PLURIELS_ORDONNES[#CALC_PLURIELS_ORDONNES + 1] = k
end
table.sort(CALC_PLURIELS_ORDONNES, function(a, b) return #a > #b end)

local function liste_de_noms(arg)
  local noms = {}
  for nom in arg:gsub("%s+et%s+", ", "):gmatch("[^,]+") do
    nom = trim(nom)
    if not nom:match("^[%a][%w_]*$") then return nil end
    noms[#noms + 1] = nom
  end
  if #noms < 2 then return nil end
  return noms
end

local OBJETS_VERBE = {
  ["cadre"] = true, ["tableau"] = true, ["grille"] = true,
  ["image"] = true, ["matrice"] = true,
  ["système"] = true, ["statistique"] = true, ["arbre"] = true,
  ["liste"] = true, ["rangée"] = true,

  ["Dérivée"] = true, ["Limite"] = true, ["Développement"] = true,
  ["Zéros"] = true, ["Primitive"] = true, ["Racines"] = true,
  ["Forme"] = true, ["Intégrale"] = true, ["Valeurs"] = true,
  ["Déterminant"] = true, ["Inverse"] = true, ["Somme"] = true,
  ["Produit"] = true, ["Espérance"] = true, ["Écart"] = true,
  ["Quantile"] = true, ["Probabilité"] = true,
}

local function verifier_verbe_objet(line)
  if line:match("^%s*soit%s+[%w\128-\255_%-]+%s*%b{}%s*=%s*<")
  or line:match("^%s*soit%s+[%w\128-\255_%-]+%s*=%s*<") then
    return
  end
  local l = line:gsub("<<", "  ")
  for tete in l:gmatch("<([%a\128-\255][%w\128-\255_%-]*)") do
    if OBJETS_VERBE[tete] then
      err("une balise commence par un verbe d'action à l'impératif "
        .. "présent — <Dresse un tableau ...>, <Affiche un cadre ...>, "
        .. "<Insère une image ...>, <Construis un arbre ...> — jamais "
        .. "par l'objet nu : « <" .. tete .. " ... ». L'objet porte "
        .. "toujours son article, et l'article suit un verbe "
        .. "(règle n°12).")
    end
  end
end

local function etendre_calcul_pluriel(body)
  local out = {}
  for line in (body .. "\n"):gmatch("(.-)\n") do
    local fait = false
    local ind, inner = line:match("^(%s*)<(.+)>%s*$")

    if inner then
      for _, v in ipairs(V.VERBES_OBJET) do
        local reste = inner:match("^" .. v .. "%s+(.+)$")
        if reste then
          local nb, tail = reste:match("^(%d+)%s+(.+)$")
          local corps = tail or reste:match("^[ld]es%s+(.+)$")
          if corps then
            for _, obj in ipairs { "variations", "signes" } do
              local arg = corps:match("^tableaux%s+de%s+" .. obj .. "%s+de%s+(.+)$")
              if arg then
                local noms = liste_de_noms(arg)
                if noms then
                  if nb and tonumber(nb) ~= #noms then
                    err("le compte n'y est pas : la phrase annonce " .. nb
                      .. " tableaux de " .. obj .. " mais nomme " .. #noms
                      .. " fonctions. Le nombre, comme l'article pluriel, "
                      .. "factorise : il doit correspondre au nombre de "
                      .. "fonctions nommées.")
                  end
                  for _, nom in ipairs(noms) do
                    out[#out + 1] = ind .. "<" .. v .. " le tableau de "
                                  .. obj .. " de " .. nom .. ">"
                  end
                  fait = true
                end
              end
              if fait then break end
            end
          end
        end
        if fait then break end
      end
    end

    if inner and not fait then
      for _, v in ipairs(CALC_VERBS) do
        local reste = inner:match("^" .. v .. "%s+(.+)$")
        if reste then
          for _, fr in ipairs(CALC_PLURIELS_ORDONNES) do
            local arg = reste:match("^" .. fr:gsub("[%-']", "%%%0") .. "%s+(.+)$")
            if arg then
              local noms = liste_de_noms(arg)
              if noms then
                local sing = CALC_NOUNS_PLURIELS[fr]
                for _, nom in ipairs(noms) do
                  out[#out + 1] = ind .. "<" .. v .. " " .. sing .. " " .. nom .. ">"
                end
                fait = true
              end
            end
            if fait then break end
          end
          if not fait then

            local BINAIRES = { ["le produit scalaire de"] = true,
                               ["la colinéarité de"] = true,
                               ["le PGCD de"] = true,
                               ["le wronskien de"] = true }
            for fr in pairs(CALC_NOUNS) do
              if not CALC_NOUNS_PLURIELS[fr] and not BINAIRES[fr] then
                local arg = reste:match("^" .. fr:gsub("[%-']", "%%%0") .. "%s+(.+)$")
                if arg and liste_de_noms(arg) then
                  err("le pluriel factorise, et se marque sur le nom : "
                    .. "« <" .. v .. " " .. fr:gsub("^l[ae]s?%s+", "les ")
                    .. " f, g et h> » se dit avec le nom au pluriel — "
                    .. "par exemple « les dérivées de f, g et h » — "
                    .. "tandis que le singulier ne prend qu'une seule "
                    .. "fonction : « " .. fr .. " f ».")
                end
              end
            end
          end
        end
        if fait then break end
      end
    end
    if not fait then out[#out + 1] = line end
  end
  local res = table.concat(out, "\n")
  return (res:gsub("\n$", ""))
end

local function normaliser_verbe(line)
  for _, v in ipairs(V.VERBES_OBJET) do
    line = line:gsub("<" .. v .. "%s+([^<>]*)", function(rest)
      rest = rest:gsub("^[Uu]ne?%s+", ""):gsub("^[Ll]es?%s+", "")
                 :gsub("^[Ll]a%s+", ""):gsub("^[Ll]'%s*", "")
      return "<" .. rest
    end)
  end
  return line
end

local function remplacer_tetes(line)
  local out, i, n = {}, 1, #line
  while i <= n do
    local c = line:sub(i, i)
    if c == "<" and line:sub(i + 1, i + 1) == "<" then
      out[#out + 1] = "<<"
      i = i + 2
    elseif c == "<" then
      local j, depth, fin = i + 1, 0, nil
      while j <= n do
        local ch = line:sub(j, j)
        if ch == "{" then depth = depth + 1
        elseif ch == "}" then depth = depth - 1
        elseif ch == "<" and depth == 0 then break
        elseif ch == ">" and depth == 0 then fin = j; break
        end
        j = j + 1
      end
      if fin then
        out[#out + 1] = "<" .. translate_tag_head(line:sub(i + 1, fin - 1)) .. ">"
        i = fin + 1
      else
        out[#out + 1] = c
        i = i + 1
      end
    elseif c == ">" and line:sub(i + 1, i + 1) == ">" then
      out[#out + 1] = ">>"
      i = i + 2
    else
      out[#out + 1] = c
      i = i + 1
    end
  end
  return table.concat(out)
end

local function translate_line(line)
  local ctrl = translate_control(line)
  if ctrl then line = ctrl end
  return translate_math_zones(remplacer_tetes(line))
end

local function translate_table_row(row)
  if row == "" then return row end
  local function fusion(span)
    return function(n, attrs, contenu)
      local gras = attrs:find("%f[%a]entête%f[%A]") ~= nil
      attrs = attrs:gsub("%f[%a]entête%f[%A]", "")
      attrs = attrs:gsub("%f[%w]en%s+([tmb][lcr])%f[^%w]", "%1")
      if gras then
        contenu = "{<b>" .. contenu .. "}"
      end
      return "<" .. span .. ":" .. n .. " "
          .. translate_object_words(attrs) .. ">" .. contenu
    end
  end
  row = row:gsub("<dans%s+une%s+cellule%s+qui%s+occupera?%s+(%d+)%s+colonnes?%s*([^<>]-)>(%b{})",
                 fusion("colspan"))
  row = row:gsub("<dans%s+une%s+cellule%s+qui%s+occupera?%s+(%d+)%s+lignes?%s*([^<>]-)>(%b{})",
                 fusion("rowspan"))
  row = row:gsub("<(%d+)%s*colonnes?%s*([^<>]-)>(%b{})", fusion("colspan"))
  row = row:gsub("<(%d+)%s*lignes?%s*([^<>]-)>(%b{})",   fusion("rowspan"))
  local cells = {}
  for cell in (row .. "\t"):gmatch("(.-)\t") do
    cell = trim(cell)
    if cell == "" then cell = "." end
    cells[#cells + 1] = cell
  end
  while #cells > 1 and cells[#cells] == "." and row:match("%\t%s*$") == nil do
    table.remove(cells)
  end
  local joined = {}
  for i, c in ipairs(cells) do joined[i] = translate_line(c) end
  return table.concat(joined, " | ")
end

local function chevron_est_balise(l, p)
  local rest = l:sub(p + 1)
  if rest:match("^[%a\128-\255]") then return true end
  if rest:match("^%d+%s?[%a\128-\255]") then return true end
  return false
end

local function tbl_split(s, sep)
  local out, buf = {}, {}
  local i, n = 1, #s
  local db, dk, dt, dp, inmath = 0, 0, 0, 0, false
  while i <= n do
    local c = s:sub(i, i)
    if c == "\\" then
      buf[#buf + 1] = s:sub(i, i + 1); i = i + 2
    else
      if c == "$" then inmath = not inmath
      elseif not inmath then
        if c == "{" then db = db + 1
        elseif c == "}" then db = db - 1
        elseif c == "[" then dk = dk + 1
        elseif c == "]" then dk = dk - 1
        elseif c == "(" then dp = dp + 1
        elseif c == ")" and dp > 0 then dp = dp - 1
        elseif c == "<" and db == 0 and chevron_est_balise(s, i) then dt = dt + 1
        elseif c == ">" and db == 0 and dt > 0 then dt = dt - 1
        end
      end
      if c == sep and not inmath and db == 0 and dk == 0 and dt == 0 and dp == 0 then
        out[#out + 1] = table.concat(buf); buf = {}
      else
        buf[#buf + 1] = c
      end
      i = i + 1
    end
  end
  out[#out + 1] = table.concat(buf)
  return out
end

local function tbl_groupes(row)
  local i, n = 1, #row
  local db, dt, inmath = 0, 0, false
  local head_end, groups, last_stop = nil, {}, nil
  while i <= n do
    local c = row:sub(i, i)
    if c == "\\" then i = i + 2
    elseif c == "$" then inmath = not inmath; i = i + 1
    elseif inmath then i = i + 1
    elseif c == "{" then db = db + 1; i = i + 1
    elseif c == "}" then db = db - 1; i = i + 1
    elseif c == "<" and db == 0 and chevron_est_balise(row, i) then
      dt = dt + 1; i = i + 1
    elseif c == ">" and db == 0 and dt > 0 then dt = dt - 1; i = i + 1
    elseif c == "[" and db == 0 and dt == 0 then
      local d, j, im = 0, i, false
      while j <= n do
        local e = row:sub(j, j)
        if e == "\\" then j = j + 1
        elseif e == "$" then im = not im
        elseif not im then
          if e == "[" then d = d + 1
          elseif e == "]" then
            d = d - 1
            if d == 0 then break end
          end
        end
        j = j + 1
      end
      if d ~= 0 or j > n then return nil end
      if last_stop and row:sub(last_stop + 1, i - 1):match("%S") then return nil end
      if not head_end then head_end = i - 1 end
      groups[#groups + 1] = row:sub(i + 1, j - 1)
      last_stop = j
      i = j + 1
    else
      i = i + 1
    end
  end
  if #groups == 0 then return nil end
  if row:sub(last_stop + 1):match("%S") then return nil end
  return row:sub(1, head_end), groups
end

local function tbl_entetes(head, colle)
  if head == "" then return {} end
  local cells = {}
  for piece in (head .. "\t"):gmatch("(.-)\t") do cells[#cells + 1] = piece end
  if #cells > 0 and not cells[#cells]:match("%S") then table.remove(cells) end
  for k, v in ipairs(cells) do
    cells[k] = (trim(v):gsub("%s*:%s*$", ""))
  end
  if colle then
    while #cells > 0 and cells[1] == "" do table.remove(cells, 1) end
  end
  return cells
end

local function tbl_forme_crochets(row)
  local head, groups = tbl_groupes(row)
  if not groups then return false end
  if #groups > 1 then return true end
  if not head:match("%S") then return true end
  if head:match(":%s*$") then return true end
  return #tbl_split(groups[1], ";") > 1
end

local function tbl_construire(lignes)
  local recs = {}
  for _, e in ipairs(lignes) do
    if e.ctrl then
      recs[#recs + 1] = { ctrl = e.ctrl }
    elseif not e.row:match("%S") then
      recs[#recs + 1] = { ctrl = e.brut }
    else
      local head, groups = tbl_groupes(e.row)
      local creux = #(e.row:match("^\t*") or "")
      if groups then
        recs[#recs + 1] = { champs = tbl_entetes(head, true), groupes = groups,
                            indent = e.indent }
      elseif trim(e.row):match(":$") then
        recs[#recs + 1] = { champs = tbl_entetes(e.row, true), ouvre = true,
                            creux = creux, indent = e.indent }
      else
        local hs = tbl_entetes(e.row)
        while #hs > 1 and hs[#hs] == "" do table.remove(hs) end
        recs[#recs + 1] = { titre = hs, indent = e.indent }
      end
    end
  end

  local H, pile, tenu = 0, {}, 0
  for _, r in ipairs(recs) do
    if r.ctrl then
      pile, tenu = {}, 0
    elseif r.ouvre then
      while #pile > 0 and pile[#pile] >= r.creux do table.remove(pile) end
      r.base = #pile
      for _ = 1, #r.champs do pile[#pile + 1] = r.creux end
      if #pile > H then H = #pile end
      tenu = #pile
    elseif r.groupes then
      if tenu + #r.champs > H then H = tenu + #r.champs end
      tenu = 0
    else
      pile, tenu = {}, 0
    end
  end

  local rows = {}
  local attente = {}
  for _, r in ipairs(recs) do
    if r.ctrl then
      rows[#rows + 1] = { ctrl = r.ctrl }
      attente = {}
    elseif r.ouvre then
      for i, t in ipairs(r.champs) do attente[r.base + i] = t end
    elseif r.titre then
      local cells = {}
      for _, t in ipairs(r.titre) do
        cells[#cells + 1] = { text = t, head = true, cont = (t == "") }
      end
      rows[#rows + 1] = { cells = cells, indent = r.indent }
      attente = {}
    else
      local hs = {}
      for i, t in pairs(attente) do hs[i] = t end
      local base = H - #r.champs
      for i, t in ipairs(r.champs) do hs[base + i] = t end
      attente = {}
      for gi, g in ipairs(r.groupes) do
        local cells = {}
        for i = 1, H do
          local t = hs[i]
          cells[#cells + 1] = { text = t or "", head = true,
                                cont = (gi > 1) or (t == nil) or (t == "") }
        end
        for _, cc in ipairs(tbl_split(g, ";")) do
          cells[#cells + 1] = { text = trim(cc) }
        end
        rows[#rows + 1] = { cells = cells, indent = r.indent }
      end
    end
  end

  local ouvertes, large = {}, 0
  for _, r in ipairs(rows) do
    if r.ctrl then
      ouvertes = {}
    else
      for ci, c in ipairs(r.cells) do
        if not c.head then
          ouvertes[ci] = nil
        elseif c.cont and ouvertes[ci] then
          ouvertes[ci].span = (ouvertes[ci].span or 1) + 1
          c.absorbed = true
        else
          ouvertes[ci] = c
        end
      end
      for ci = #r.cells + 1, large do ouvertes[ci] = nil end
      if #r.cells > large then large = #r.cells end
    end
  end

  local out = {}
  for _, r in ipairs(rows) do
    if r.ctrl then
      out[#out + 1] = r.ctrl
    else
      local parts = {}
      for _, c in ipairs(r.cells) do
        if c.absorbed then
          parts[#parts + 1] = "."
        else
          local mots = {}
          if c.span and c.span > 1 then mots[#mots + 1] = "rowspan:" .. c.span end
          if c.head then mots[#mots + 1] = "head" end
          local corps = translate_line(c.text)
          if #mots > 0 then
            parts[#parts + 1] = "<" .. table.concat(mots, " ") .. ">{" .. corps .. "}"
          else
            parts[#parts + 1] = corps
          end
        end
      end
      out[#out + 1] = (r.indent or "\t") .. table.concat(parts, " | ")
    end
  end
  return out
end

local function tbl_marge(lignes)
  local pref
  for _, e in ipairs(lignes) do
    if e.brut and e.brut:match("%S") then
      local w = e.brut:match("^([ \t]*)")
      if not pref then
        pref = w
      else
        local k = 0
        while k < #pref and k < #w and pref:sub(k + 1, k + 1) == w:sub(k + 1, k + 1) do
          k = k + 1
        end
        pref = pref:sub(1, k)
      end
    end
  end
  return pref or ""
end

local function tbl_rendre(lignes)
  local pref = tbl_marge(lignes)
  for _, e in ipairs(lignes) do
    if e.brut then
      e.indent = pref
      e.row = e.brut:sub(#pref + 1)
    end
  end
  local nouveau = false
  for _, e in ipairs(lignes) do
    if e.row and tbl_forme_crochets(e.row) then nouveau = true; break end
  end
  if nouveau then return tbl_construire(lignes) end
  local out = {}
  for _, e in ipairs(lignes) do
    out[#out + 1] = e.ctrl or (pref .. translate_table_row(e.row))
  end
  return out
end

local function tete_ouverte(line)
  local l = line:gsub("<<", ""):gsub(">>", "")
  local ouverte, depth, in_math = false, 0, false
  for i = 1, #l do
    local c = l:sub(i, i)
    if c == "$" then
      in_math = not in_math
    elseif in_math then

    elseif c == "{" then depth = depth + 1
    elseif c == "}" then depth = depth - 1
    elseif c == "<" and depth <= 0 then
      if chevron_est_balise(l, i) then ouverte = true end
    elseif c == ">" and depth <= 0 then ouverte = false
    end
  end
  return ouverte
end

local function joindre_notes(body)
  local lines, buf, buf_kind = {}, nil, nil
  for line in (body .. "\n"):gmatch("(.-)\n") do
    if buf then
      buf = buf .. " " .. line:gsub("^%s+", "")
      local fini
      if buf_kind == "note" then
        fini = select(2, buf:gsub("{", "")) <= select(2, buf:gsub("}", ""))
      else
        fini = not tete_ouverte(buf)
      end
      if fini then
        lines[#lines + 1] = buf; buf, buf_kind = nil, nil
      end
    else
      local notepos = line:find("<note>%s*{") or line:find("<footnote>%s*{")
      if notepos then
        local no = select(2, line:gsub("{", ""))
        local nc = select(2, line:gsub("}", ""))
        if no > nc then buf, buf_kind = line, "note"
        else lines[#lines + 1] = line end
      elseif tete_ouverte(line) then
        buf, buf_kind = line, "tete"
      else
        lines[#lines + 1] = line
      end
    end
  end
  if buf then lines[#lines + 1] = buf end
  return table.concat(lines, "\n")
end

local function fn_requise(nom, quoi)
  local def = L._fns and L._fns[nom]
  if not def then
    error("texecole : <" .. quoi .. " de " .. nom .. "> demande que la "
      .. "fonction ait été posée par <Soit>une fonction " .. nom
      .. "(x) = ... auparavant.", 0)
  end
  return def, def:match("%((%a[%w_]*)%)") or "x", def:match("=%s*(.+)$")
end

local function mat_requise(nom, quoi)
  local mat = L._mats and L._mats[nom]
  if not mat then
    error("texecole : <" .. quoi .. " de " .. nom .. "> demande que la "
      .. "matrice ait été posée : <Soit la matrice " .. nom .. ">{ ... }", 0)
  end
  return mat
end

local function vec_requis(nom, quoi)
  local co = L._vecteurs and L._vecteurs[nom]
  if not co then
    error("texecole : <" .. quoi .. "> demande que le vecteur " .. nom
      .. " ait été posé auparavant : <Soit>le vecteur " .. nom
      .. " de coordonnées (...).", 0)
  end
  return co
end

local function plan_requis(nom, quoi)
  local eq = L._plans and L._plans[nom]
  if not eq then
    error("texecole : <" .. quoi .. "> demande que le plan " .. nom
      .. " ait été posé auparavant : <Soit>le plan " .. nom
      .. " d'équation a x + b y + c z = d.", 0)
  end
  return eq
end

local function fn_multi(nom, quoi)
  local def = L._fns and L._fns[nom]
  if not def then
    error("texecole : <" .. quoi .. " de " .. nom .. "> demande que la "
      .. "fonction ait été posée : <Soit>une fonction " .. nom
      .. "(x, y) = ...", 0)
  end
  local fvars = def:match("%((.-)%)")
  local fexpr = def:match("=%s*(.+)$")
  if not fvars or not fexpr then
    error("texecole : la définition de " .. nom .. " ne se lit pas comme "
      .. nom .. "(x, y) = expression.", 0)
  end
  return def, (fvars:gsub("%s", "")), trim(fexpr)
end

local function graphe_requis(nom, quoi)
  local g = L._graphes and L._graphes[nom]
  if not g then
    error("texecole : <" .. quoi .. "> demande que le graphe " .. nom
      .. " ait été construit auparavant : <Construis le graphe " .. nom
      .. ">{ ... }, une arête par ligne.", 0)
  end
  return g
end

local LOI_OPS = {
  ["<="] = "le", [">="] = "ge", ["="] = "eq", ["<"] = "lt", [">"] = "gt",
}

local function loi_ou_erreur(nomloi)
  local code = V.LOIS[nomloi]
  if not code then
    error("texecole : loi inconnue : « " .. nomloi .. " » (attendu : "
      .. "normale, binomiale, poisson, uniforme, exponentielle, student, "
      .. "khi-deux).", 0)
  end
  return code
end

local function params_loi(p)
  return trim(num_fr(p):gsub("%s*;%s*", " "))
end

local function transformer_edo(eq, f, var)
  var = var or "x"
  eq = num_fr(eq)
  eq = eq:gsub(f .. "''", "\1"):gsub(f .. "'", "\2")
  eq = eq:gsub("%f[%a]" .. f .. "%f[%A]", "\3")
  eq = eq:gsub("\1", "Derivative(" .. f .. "(" .. var .. ")," .. var .. ",2)")
  eq = eq:gsub("\2", "Derivative(" .. f .. "(" .. var .. ")," .. var .. ")")
  eq = eq:gsub("\3", f .. "(" .. var .. ")")
  return eq
end

local function transformer_edp(eq, f)
  eq = num_fr(eq)
  eq = eq:gsub(f .. "_xx", "\1"):gsub(f .. "_yy", "\2")
  eq = eq:gsub(f .. "_xy", "\4"):gsub(f .. "_x", "\5"):gsub(f .. "_y", "\6")
  eq = eq:gsub("%f[%a]" .. f .. "%f[%A]", "\3")
  eq = eq:gsub("\1", "Derivative(" .. f .. "(x,y),x,2)")
  eq = eq:gsub("\2", "Derivative(" .. f .. "(x,y),y,2)")
  eq = eq:gsub("\4", "Derivative(" .. f .. "(x,y),x,y)")
  eq = eq:gsub("\5", "Derivative(" .. f .. "(x,y),x)")
  eq = eq:gsub("\6", "Derivative(" .. f .. "(x,y),y)")
  eq = eq:gsub("\3", f .. "(x,y)")
  return eq
end

local function traduire_zone(inner)
  local nom, reste = inner:match("^%s*([%a_][%w_]*)%s*:%s*(.*)$")
  if not nom then
    nom, reste = inner:match("^%s*([%a_][%w_]*)%s*(.*)$")
  end
  if not nom then
    error("texecole : zone de grille illisible : « [" .. inner .. "] » — "
      .. "la forme est [nom en mc avec attributs] : le placement "
      .. "s'introduit par « en », les attributs par « avec ».", 0)
  end
  local VNAT = { haut = "t", milieu = "m", bas = "b" }
  local HNAT = { gauche = "l", centre = "c", droite = "r" }
  local vert, horiz, code
  local attrtxt
  for piece in (reste .. ","):gmatch("(.-),") do
    local p = trim(piece)
    if attrtxt then
      if p ~= "" then attrtxt = attrtxt .. ", " .. p end
    elseif p ~= "" then

      local c2, suite = p:match("^en%s+([tmb][lcrj])%f[%W]%s*(.*)$")
      if not c2 then
        c2, suite = p:match("^en%s+(j)%f[%W]%s*(.*)$")
      end
      if c2 then code = c2; p = trim(suite) end
      if p:match("^avec%f[%W]") then
        attrtxt = p
      elseif p ~= "" then
        local nu = p:gsub("^en%s+", ""):gsub("^au%s+", ""):gsub("^à%s+", "")
        if VNAT[nu] then vert = VNAT[nu]
        elseif HNAT[nu] then horiz = HNAT[nu]
        elseif p:match("^[tmb][lcr]%f[%W]") or p:match("^j%f[%W]") then
          err("le placement d'une zone s'introduit par « en » : "
            .. "[" .. nom .. " en " .. p:match("^%S+") .. " ...] — "
            .. "comme dans « en mc » (milieu, centré) ou « en j » "
            .. "(justifié).")
        else
          err("propriété de zone illisible : « " .. p .. " ». Une zone "
            .. "s'écrit [nom en mc avec une bordure bleue, un fond "
            .. "blanc et des coins arrondis de 2 mm] — le placement "
            .. "d'abord (« en mc », ou « en haut, à gauche »), puis "
            .. "les attributs introduits par « avec », séparés par "
            .. "des virgules, « et » avant le dernier.")
        end
      end
    end
  end
  if vert or horiz then code = (vert or "m") .. (horiz or "c") end
  local morceaux = { nom }
  if code then morceaux[#morceaux + 1] = code end
  if attrtxt then
    local mots = translate_object_words(attrtxt, true)
    if mots ~= "" then morceaux[#morceaux + 1] = mots end
  end
  return table.concat(morceaux, " ")
end

local function delta_braces(line)
  local o = select(2, line:gsub("{", ""))
  local c = select(2, line:gsub("}", ""))
  return o - c
end

local function convertir_matrices_delimiteurs(body)
  body = body:gsub("<([^<>]-)matrice%s*%((.-)\n%s*%)>", function(prefixe, rangs)
    return "<" .. prefixe .. "matrice>{" .. rangs .. "\n}"
  end)
  body = body:gsub("<([^<>]-)matrice%s*%[(.-)\n%s*%]>", function(prefixe, rangs)
    return "<" .. prefixe .. "matrice entre crochets>{" .. rangs .. "\n}"
  end)
  body = body:gsub("<([%a][%w]*)>%s*la%s+matrice%s*%((.-)\n%s*%)", function(verbe, rangs)
    return "<" .. verbe .. " la matrice>{" .. rangs .. "\n}"
  end)
  body = body:gsub("<([%a][%w]*)>%s*la%s+matrice%s*%[(.-)\n%s*%]", function(verbe, rangs)
    return "<" .. verbe .. " la matrice entre crochets>{" .. rangs .. "\n}"
  end)

  body = body:gsub(
    "<([%a][%w]*)>%s*la%s+matrice%s+([%a_][%w_]*)%s+entre%s+crochets%s*{",
    function(verbe, nom)
      return "<" .. verbe .. " la matrice " .. nom .. " entre crochets>{"
    end)
  body = body:gsub("<([%a][%w]*)>%s*la%s+matrice%s+([%a_][%w_]*)%s*{",
    function(verbe, nom) return "<" .. verbe .. " la matrice " .. nom .. ">{" end)
  body = body:gsub("<([%a][%w]*)>%s*le%s+système%s+([%a_][%w_]*)%s*{",
    function(verbe, nom) return "<" .. verbe .. " le système " .. nom .. ">{" end)
  return body
end

local VERBES_CANON = {
  ["Calcule"] = true, ["Détermine"] = true, ["Donne"] = true,
  ["Cherche"] = true, ["Trouve"] = true, ["Établis"] = true,
  ["Évalue"] = true, ["Étudie"] = true, ["Résous"] = true,
  ["Trace"] = true, ["Affiche"] = true, ["Dresse"] = true,
  ["Construis"] = true, ["Insère"] = true, ["Pose"] = true,
  ["Écris"] = true, ["Définis"] = true, ["Dénombre"] = true,
  ["Applique"] = true, ["Vérifie"] = true, ["Convertis"] = true,
  ["Complète"] = true, ["Exprime"] = true, ["Effectue"] = true,
  ["Trigonalise"] = true, ["Orthonormalise"] = true,
  ["Simplifie"] = true, ["Factorise"] = true, ["Développe"] = true,
  ["Représente"] = true, ["Décompose"] = true, ["Compare"] = true,
  ["Soit"] = true,
}

local ARG_FINAL = { ["Insère"] = true }

local function canonique(body)
  return (body:gsub("[^\n]+", function(ligne)
    local indent, dedans, reste = ligne:match(
      "^(%s*)<%s*([^<>%s][^<>]-)%s*>[ \t]*(%S[^\n]*)$")
    if not dedans then return ligne end
    local option
    if dedans:find("%s") then
      local verbe, reste_tag = dedans:match("^(%S+)%s+(.+)$")
      local OPTIONS_ACTION = { ["pas à pas"] = true,
        ["en rédigeant"] = true, ["en détaillant"] = true }
      if VERBES_CANON[verbe] and OPTIONS_ACTION[reste_tag] then
        dedans, option = verbe, reste_tag
      else
        return ligne
      end
    end
    if not VERBES_CANON[dedans] then return ligne end
    if reste:sub(1, 1) == "{" then return ligne end
    if dedans == "Soit" and not reste:match("{%s*$") then return ligne end
    if reste:match("[%(%[]%s*$") then return ligne end
    if ARG_FINAL[dedans] then
      local corps, arg = reste:match("^(.-)%s*(%b{})%s*$")
      if corps and corps ~= "" then
        return indent .. "<" .. dedans .. " " .. corps .. ">" .. arg
      end
    end
    local suffixe = option and (" " .. option) or ""
    local corps = reste:match("^(.-)%s*{%s*$")
    if corps then
      if corps == "" then return ligne end
      return indent .. "<" .. dedans .. " " .. corps .. suffixe .. ">{"
    end
    return indent .. "<" .. dedans .. " " .. reste .. suffixe .. ">"
  end))
end

function L.traduire(body)
  body = canonique(body)

  L._lois = {}
  for lnom, lbloc in body:gmatch(
      "<Dresse%s+la%s+loi%s+de%s+probabilité%s+de%s+([%a][%w_]*)%s*>%s*(%b{})") do
    local rows = {}
    for ligne in (lbloc:sub(2, -2) .. "\n"):gmatch("(.-)\n") do
      if ligne:match("%S") then rows[#rows + 1] = num_fr(trim(ligne)) end
    end
    L._lois[lnom] = rows
  end

  body = body:gsub("<[Rr]eprésente%s+graphiquement>%s*{", "<Trace>{")
  body = body:gsub("<[Rr]eprésente%s+graphiquement%s+dans%s+un%s+repère",
    "<Trace dans un repère")
  body = body:gsub("<[Rr]eprésente%s+graphiquement%s+un%s+repère", "<Trace un repère")
  body = body:gsub("<[Rr]eprésente%s+graphiquement%s+la%s+fonction", "<Trace la fonction")
  body = body:gsub("<[Rr]eprésente%s+graphiquement%s+les%s+fonctions", "<Trace les fonctions")
  body = body:gsub("<[Rr]eprésente%s+graphiquement%s+des%s+fonctions", "<Trace des fonctions")
  body = body:gsub("<[Rr]eprésente%s+graphiquement%s+(%d+%s+fonctions)", "<Trace %1")
  body = body:gsub("<[Rr]eprésente%s+graphiquement%s+la%s+droite%s+graduée",
    "<Trace la droite graduée")
  body = body:gsub("<[Rr]eprésente%s+graphiquement%s+", "<Affiche ")
  body = convertir_matrices_delimiteurs(body)
  body = joindre_notes(body)
  body = etendre_calcul_pluriel(body)
  local out = {}
  local mode, acc, frame = "normal", nil, nil

  for line in (body .. "\n"):gmatch("(.-)\n") do
    verifier_verbe_objet(line)
    if mode == "normal" then
      line = normaliser_action_calcul(line)
      line = normaliser_verbe(line)
      if line:match("^%s*<Soit>%s*{%s*$") then
        mode, acc = "soit", {}
      elseif line:match("^%s*<Soit>") then
        local decl = trim(line:match("^%s*<Soit>%s*(.*)$"))
        local t = P.translate_soit_decl(decl)
        out[#out + 1] = "Soit " .. t.display
        inscrire_fns(out, t)
        if t.points then
          L._points = L._points or {}
          for _, pt in ipairs(t.points) do
            L._points[pt.nom] = pt.co
          end
        end
        if t.suite then
          L._suites = L._suites or {}
          L._suites[t.suite.nom] = t.suite
          out[#out + 1] = "<sequence " .. t.suite.nom .. ">{"
          out[#out + 1] = t.suite.nom .. "(0) = " .. t.suite.u0
          out[#out + 1] = t.suite.nom .. "(n+1) = " .. t.suite.rec
          out[#out + 1] = "}"
        end
        if t.vecteurs then
          L._vecteurs = L._vecteurs or {}
          for _, v in ipairs(t.vecteurs) do L._vecteurs[v.nom] = v.co end
        end
        if t.plan then
          L._plans = L._plans or {}
          L._plans[t.plan.nom] = t.plan.eq
        end
      elseif line:match("^%s*<On%s+[%aè]+>") then
        local verbe, reste = line:match("^%s*<On%s+([%aè]+)>%s*(.*)$")
        if verbe ~= "pose" and verbe ~= "considère" and verbe ~= "note" then
          error("texecole : « <On " .. verbe .. "> » n'est pas une action : "
            .. "les tournures reconnues sont <On pose>, <On considère> et "
            .. "<On note>, synonymes de <Soit>.", 0)
        end
        local t = P.translate_soit_decl(trim(reste))
        out[#out + 1] = "On " .. verbe .. " " .. t.display
        inscrire_fns(out, t)
        if t.points then
          L._points = L._points or {}
          for _, pt in ipairs(t.points) do L._points[pt.nom] = pt.co end
        end
        if t.suite then
          L._suites = L._suites or {}
          L._suites[t.suite.nom] = t.suite
          out[#out + 1] = "<sequence " .. t.suite.nom .. ">{"
          out[#out + 1] = t.suite.nom .. "(0) = " .. t.suite.u0
          out[#out + 1] = t.suite.nom .. "(n+1) = " .. t.suite.rec
          out[#out + 1] = "}"
        end
        if t.vecteurs then
          L._vecteurs = L._vecteurs or {}
          for _, v in ipairs(t.vecteurs) do L._vecteurs[v.nom] = v.co end
        end
        if t.plan then
          L._plans = L._plans or {}
          L._plans[t.plan.nom] = t.plan.eq
        end
      elseif line:match("^%s*<Trace%f[%s>].->%s*{%s*$")
          or line:match("^%s*<Trace>%s*{%s*$") then
        local head = line:match("^%s*<Trace%s*(.-)>%s*{%s*$") or ""
        mode, acc = "trace", {}
        frame = nil
        if trim(head) ~= "" then
          local t = P.translate_trace_phrase(head)
          if t.kind == "frame" then
            frame = t
          else
            acc[#acc + 1] = t.line
          end
        end
      elseif line:match("^%s*<Trace%f[%s>]") then
        local phrase = line:match("^%s*<Trace%s*(.-)>%s*(.*)$")
        local after  = line:match("^%s*<Trace%s*.->%s*(.*)$") or ""
        phrase = trim((phrase or "") .. " " .. after)
        local t = P.translate_trace_phrase(phrase)
        if t.kind == "plot" then
          out[#out + 1] = "<plot " .. t.line .. ">"
        elseif t.kind == "numberline" then
          out[#out + 1] = "<numberline " .. t.line .. ">"
        elseif t.kind == "frame" then
          local ax = "axes:{" .. (t.x or "{-5, 5}"):gsub("[{}]", "") .. ", "
                             .. (t.y or "{-5, 5}"):gsub("[{}]", "") .. "}"
          local extra = {}
          for _, w in ipairs(t.opts or {}) do extra[#extra+1] = w end
          out[#out + 1] = "<draw " .. ax
            .. (#extra > 0 and (" " .. table.concat(extra, " ")) or "")
            .. ">{"
          out[#out + 1] = "}"
        else
          out[#out + 1] = "<draw>" .. t.line
        end
      elseif line:match("^%s*<Convexité%s+de%s+[%a_][%w_]*%s*>%s*$") then
        local nom = line:match("de%s+([%a_][%w_]*)%s*>")
        local _, fvar, fexpr = fn_requise(nom, "Convexité")
        out[#out + 1] = "<sympyconvex " .. nom .. " " .. fvar .. ">{"
        out[#out + 1] = fexpr
        out[#out + 1] = "}"

      elseif line:match("^%s*<Asymptotes%s+de%s+[%a_][%w_]*%s*>%s*$") then
        local nom = line:match("de%s+([%a_][%w_]*)%s*>")
        local _, fvar, fexpr = fn_requise(nom, "Asymptotes")
        out[#out + 1] = "<sympyasymp " .. nom .. " " .. fvar .. ">{"
        out[#out + 1] = fexpr
        out[#out + 1] = "}"

      elseif line:match("^%s*<Puissance%s+%d+%s+de%s+[%a_][%w_]*%s*>%s*$") then
        local n, nom = line:match("^%s*<Puissance%s+(%d+)%s+de%s+([%a_][%w_]*)%s*>%s*$")
        local mat = mat_requise(nom, "Puissance " .. n)
        out[#out + 1] = "<sympypow " .. nom .. " " .. n .. ">{"
        for _, r in ipairs(mat) do out[#out + 1] = r end
        out[#out + 1] = "}"

      elseif line:match("^%s*<État%s+stable%s+de%s+[%a_][%w_]*%s*>%s*$") then
        local nom = line:match("de%s+([%a_][%w_]*)%s*>")
        local mat = mat_requise(nom, "État stable")
        out[#out + 1] = "<sympystable " .. nom .. ">{"
        for _, r in ipairs(mat) do out[#out + 1] = r end
        out[#out + 1] = "}"

      elseif line:match("^%s*<Produit%s+scalaire%s+de%s+[%a_][%w_]*%s+et%s+[%a_][%w_]*%s*>%s*$") then
        local nu, nv = line:match("de%s+([%a_][%w_]*)%s+et%s+([%a_][%w_]*)%s*>")
        local cu = vec_requis(nu, "Produit scalaire de " .. nu .. " et " .. nv)
        local cv = vec_requis(nv, "Produit scalaire de " .. nu .. " et " .. nv)
        out[#out + 1] = "<vecscal " .. nu .. " {" .. cu .. "} "
          .. nv .. " {" .. cv .. "}>"

      elseif line:match("^%s*<Norme%s+de%s+[%a_][%w_]*%s*>%s*$") then
        local nu = line:match("de%s+([%a_][%w_]*)%s*>")
        local cu = vec_requis(nu, "Norme de " .. nu)
        out[#out + 1] = "<vecnorm " .. nu .. " {" .. cu .. "}>"

      elseif line:match("^%s*<Calcule%s+l'angle%s+entre%s+[%a_][%w_]*%s+et%s+[%a_][%w_]*%s*>%s*$") then
        local nu, nv = line:match("entre%s+([%a_][%w_]*)%s+et%s+([%a_][%w_]*)%s*>")
        local cu = vec_requis(nu, "l'angle entre " .. nu .. " et " .. nv)
        local cv = vec_requis(nv, "l'angle entre " .. nu .. " et " .. nv)
        out[#out + 1] = "<vecangle " .. nu .. " {" .. cu .. "} "
          .. nv .. " {" .. cv .. "}>"

      elseif line:match("^%s*<Colinéarité%s+de%s+[%a_][%w_]*%s+et%s+[%a_][%w_]*%s*>%s*$") then
        local nu, nv = line:match("de%s+([%a_][%w_]*)%s+et%s+([%a_][%w_]*)%s*>")
        local cu = vec_requis(nu, "Colinéarité de " .. nu .. " et " .. nv)
        local cv = vec_requis(nv, "Colinéarité de " .. nu .. " et " .. nv)
        out[#out + 1] = "<veccolin " .. nu .. " {" .. cu .. "} "
          .. nv .. " {" .. cv .. "}>"

      elseif line:match("^%s*<Vecteur%s+normal%s+de%s+%u[%w]*%s*>%s*$") then
        local nom = line:match("de%s+(%u[%w]*)%s*>")
        local eq = plan_requis(nom, "Vecteur normal de " .. nom)
        out[#out + 1] = "<plannormal " .. nom .. ">{" .. eq .. "}"

      elseif line:match("^%s*<Calcule%s+la%s+distance%s+du%s+point%s*%b()%s*au%s+plan%s+%u[%w]*%s*>%s*$") then
        local cp, nom = line:match("point%s*(%b())%s*au%s+plan%s+(%u[%w]*)%s*>")
        local eq = plan_requis(nom, "la distance au plan " .. nom)
        out[#out + 1] = "<plandist " .. nom .. " " .. num_fr(cp) .. ">{"
          .. eq .. "}"

      elseif line:match("^%s*<Résous%s+l'équation%s+diophantienne%s+.->%s*$") then
        local eq = line:match("^%s*<Résous%s+l'équation%s+diophantienne%s+(.-)>%s*$")
        out[#out + 1] = "<dioph " .. num_fr(eq) .. ">"

      elseif line:match("^%s*<Résous%s+l'équation%s+trigonométrique%s+.->%s*$") then
        local eq = line:match("^%s*<Résous%s+l'équation%s+trigonométrique%s+(.-)>%s*$")
        out[#out + 1] = "<trigsolve " .. num_fr(eq) .. ">"

      elseif line:match("^%s*<Calcule%s+l'intervalle%s+de%s+fluctuation%s+") then
        local n, pv = line:match(
          "pour%s+n%s*=%s*(%d+)%s+et%s+p%s*=%s*(%S+)%s*>%s*$")
        if not n then
          error("texecole : la forme est <Calcule l'intervalle de "
            .. "fluctuation pour n = 100 et p = 0,3>.", 0)
        end
        out[#out + 1] = "<fluct " .. n .. " " .. num_fr(pv) .. ">"

      elseif line:match("^%s*<inégalité%s+de%s+Bienaymé") then
        local mu, va, ec = line:match(
          "espérance%s+de%s+(%S+),%s+une%s+variance%s+de%s+(%S+)%s+et%s+"
          .. "un%s+écart%s+de%s+(%S-)%s*>%s*$")
        if not mu then
          error("texecole : la forme est <Applique l'inégalité de "
            .. "Bienaymé-Tchebychev pour une espérance de 5, une variance "
            .. "de 2 et un écart de 3>.", 0)
        end
        out[#out + 1] = "<bienayme " .. num_fr(mu) .. " " .. num_fr(va)
          .. " " .. num_fr(ec) .. ">"

      elseif line:match("^%s*<graphe%s+%u[%w]*%s*>%s*{%s*$") then
        acc = { nom = line:match("graphe%s+(%u[%w]*)"), rows = {} }
        out[#out + 1] = "<graph " .. acc.nom .. ">{"
        mode = "graphe"

      elseif line:match("^%s*<matrice%s+d'adjacence%s+de%s+%u[%w]*%s*>%s*$") then
        local nom = line:match("de%s+(%u[%w]*)%s*>")
        local g = graphe_requis(nom, "la matrice d'adjacence de " .. nom)
        out[#out + 1] = "<graphadj " .. nom .. ">{"
        for _, r in ipairs(g) do out[#out + 1] = r end
        out[#out + 1] = "}"

      elseif line:match("^%s*<chemins%s+de%s+longueur%s+%d+%s+de%s+") then
        local p, de, vers, nom = line:match(
          "longueur%s+(%d+)%s+de%s+([%a][%w_]*)%s+à%s+([%a][%w_]*)%s+dans%s+(%u[%w]*)%s*>%s*$")
        if not p then
          error("texecole : la forme est <Dénombre les chemins de longueur "
            .. "3 de A à B dans G>.", 0)
        end
        local g = graphe_requis(nom, "le dénombrement des chemins dans " .. nom)
        out[#out + 1] = "<graphpaths " .. nom .. " " .. p .. " " .. de
          .. " " .. vers .. ">{"
        for _, r in ipairs(g) do out[#out + 1] = r end
        out[#out + 1] = "}"

      elseif line:match("^%s*<Intégrale%s+de%s+[%a_][%w_]*%s+entre%s+") then
        local nom, a, b = line:match(
          "^%s*<Intégrale%s+de%s+([%a_][%w_]*)%s+entre%s+(%S+)%s+et%s+(%S+)%s*>%s*$")
        if not nom then
          error("texecole : la forme est <Calcule l'intégrale de f entre "
            .. "a et b>.", 0)
        end
        local _, fvar, fexpr = fn_requise(nom, "Intégrale")
        out[#out + 1] = "<sympydefint " .. nom .. " " .. fvar .. " "
          .. num_fr(a):gsub("infini", "inf") .. " "
          .. num_fr(b):gsub("infini", "inf") .. ">{"
        out[#out + 1] = fexpr
        out[#out + 1] = "}"

      elseif line:match("^%s*<Équivalent%s+de%s+[%a_][%w_]*%s+en%s+") then
        local nom, pt = line:match(
          "^%s*<Équivalent%s+de%s+([%a_][%w_]*)%s+en%s+(%S+)%s*>%s*$")
        if not nom then
          error("texecole : la forme est <Calcule un équivalent de f en a>, "
            .. "avec a fini, +infini ou -infini.", 0)
        end
        local _, fvar, fexpr = fn_requise(nom, "Équivalent")
        out[#out + 1] = "<sympyequiv " .. nom .. " " .. fvar .. " "
          .. num_fr(pt):gsub("infini", "inf") .. ">{"
        out[#out + 1] = fexpr
        out[#out + 1] = "}"

      elseif line:match("^%s*<Nature%s+de%s+la%s+série%s+de%s+terme%s+général%s+") then
        local expr = line:match(
          "^%s*<Nature%s+de%s+la%s+série%s+de%s+terme%s+général%s+(.-)%s*>%s*$")
        local var = expr:match("%f[%a]([nk])%f[%A]") or "n"
        out[#out + 1] = "<sympyserie " .. var .. ">{"
        out[#out + 1] = num_fr(expr)
        out[#out + 1] = "}"

      elseif line:match("^%s*<Nature%s+de%s+l'intégrale%s+de%s+[%a_][%w_]*%s+entre%s+") then
        local nom, a, b = line:match(
          "^%s*<Nature%s+de%s+l'intégrale%s+de%s+([%a_][%w_]*)%s+entre%s+(%S+)%s+et%s+(%S+)%s*>%s*$")
        if not nom then
          error("texecole : la forme est <Détermine la nature de "
            .. "l'intégrale de f entre a et b>.", 0)
        end
        local _, fvar, fexpr = fn_requise(nom, "Nature de l'intégrale")
        out[#out + 1] = "<sympyimpint " .. nom .. " " .. fvar .. " "
          .. num_fr(a):gsub("infini", "inf") .. " "
          .. num_fr(b):gsub("infini", "inf") .. ">{"
        out[#out + 1] = fexpr
        out[#out + 1] = "}"

      elseif line:match("^%s*<Image%s+de%s+%S+%s+par%s+[%a_][%w_]*%s*>%s*$") then
        local val, nom = line:match(
          "^%s*<Image%s+de%s+(%S+)%s+par%s+([%a_][%w_]*)%s*>%s*$")
        local _, fvar, fexpr = fn_requise(nom, "Image")
        out[#out + 1] = "<sympyeval " .. nom .. " " .. fvar .. " "
          .. num_fr(val) .. ">{"
        out[#out + 1] = fexpr
        out[#out + 1] = "}"

      elseif line:match("^%s*<Rang%s+de%s+[%a_][%w_]*%s*>%s*$")
          or line:match("^%s*<Noyau%s+de%s+[%a_][%w_]*%s*>%s*$")
          or line:match("^%s*<Image%s+de%s+[%a_][%w_]*%s*>%s*$")
          or line:match("^%s*<Polynôme%s+caractéristique%s+de%s+[%a_][%w_]*%s*>%s*$")
          or line:match("^%s*<Polynôme%s+minimal%s+de%s+[%a_][%w_]*%s*>%s*$") then
        local quoi = line:match("^%s*<(.-)%s+de%s+[%a_][%w_]*%s*>%s*$")
        local nom = line:match("de%s+([%a_][%w_]*)%s*>%s*$")
        local TAG = { ["Rang"] = "sympyrank", ["Noyau"] = "sympyker",
          ["Image"] = "sympyim",
          ["Polynôme caractéristique"] = "sympycharpoly",
          ["Polynôme minimal"] = "sympyminpoly" }
        local mat = mat_requise(nom, quoi)
        out[#out + 1] = "<" .. TAG[quoi] .. " " .. nom .. ">{"
        for _, r in ipairs(mat) do out[#out + 1] = r end
        out[#out + 1] = "}"

      elseif line:match("^%s*<Trigonalise%s+[%a_][%w_]*%s*>%s*$") then
        local nom = line:match("^%s*<Trigonalise%s+([%a_][%w_]*)%s*>%s*$")
        local mat = mat_requise(nom, "Trigonalise")
        out[#out + 1] = "<sympytrigmat " .. nom .. ">{"
        for _, r in ipairs(mat) do out[#out + 1] = r end
        out[#out + 1] = "}"

      elseif line:match("^%s*<Orthonormalise%s+la%s+famille%s+") then
        local liste = line:match(
          "^%s*<Orthonormalise%s+la%s+famille%s+(.-)%s*>%s*$")
        if not liste then
          error("texecole : la forme est <Orthonormalise la famille u, v "
            .. "et w>.", 0)
        end
        local noms, cos = {}, {}
        for nom in liste:gsub("%s+et%s+", ", "):gmatch("[^,]+") do
          nom = trim(nom)
          if nom ~= "" then
            noms[#noms + 1] = nom
            cos[#cos + 1] = "{" .. vec_requis(nom,
              "Orthonormalise la famille") .. "}"
          end
        end
        if #noms < 2 then
          error("texecole : le procédé de Gram-Schmidt demande au moins "
            .. "deux vecteurs.", 0)
        end
        out[#out + 1] = "<sympygram " .. table.concat(noms, " ") .. ">{"
        out[#out + 1] = table.concat(cos, " ")
        out[#out + 1] = "}"

      elseif line:match("^%s*<Projeté%s+orthogonal%s+de%s+[%a_][%w_]*%s+sur%s+[%a_][%w_]*%s*>%s*$") then
        local nu, nv = line:match("de%s+([%a_][%w_]*)%s+sur%s+([%a_][%w_]*)%s*>")
        local cu = vec_requis(nu, "Projeté orthogonal de " .. nu)
        local cv = vec_requis(nv, "Projeté orthogonal de " .. nu)
        out[#out + 1] = "<vecproj " .. nu .. " {" .. cu .. "} "
          .. nv .. " {" .. cv .. "}>"

      elseif line:match("^%s*<Effectue%s+la%s+division%s+euclidienne%s+de%s+") then
        local P, Q = line:match(
          "^%s*<Effectue%s+la%s+division%s+euclidienne%s+de%s+(.-)%s+par%s+(.-)%s*>%s*$")
        if not P then
          error("texecole : la forme est <Effectue la division euclidienne "
            .. "de P par Q>.", 0)
        end
        local a, b = P:match("^(-?%d+)$"), Q:match("^(-?%d+)$")
        if a and b then
          out[#out + 1] = "<intdiv " .. a .. " " .. b .. ">"
        else
          out[#out + 1] = "<sympypolydiv>{"
          out[#out + 1] = num_fr(P)
          out[#out + 1] = num_fr(Q)
          out[#out + 1] = "}"
        end

      elseif line:match("^%s*<PGCD%s+de%s+.-%s+et%s+.->%s*$") then
        local P, Q = line:match("^%s*<PGCD%s+de%s+(.-)%s+et%s+(.-)%s*>%s*$")
        local a, b = P:match("^(-?%d+)$"), Q:match("^(-?%d+)$")
        if a and b then
          out[#out + 1] = "<intpgcd " .. a .. " " .. b .. ">"
        else
          out[#out + 1] = "<sympypolygcd>{"
          out[#out + 1] = num_fr(P)
          out[#out + 1] = num_fr(Q)
          out[#out + 1] = "}"
        end

      elseif line:match("^%s*<Factorise%s+.-%s+dans%s+[RC]%s*%[%s*X%s*%]%s*>%s*$") then
        local expr, corps = line:match(
          "^%s*<Factorise%s+(.-)%s+dans%s+([RC])%s*%[%s*X%s*%]%s*>%s*$")
        out[#out + 1] = "<sympyfactordom " .. corps .. ">{"
        out[#out + 1] = num_fr(expr)
        out[#out + 1] = "}"

      elseif line:match("^%s*<Gradient%s+de%s+[%a_][%w_]*%s*>%s*$")
          or line:match("^%s*<Matrice%s+hessienne%s+de%s+[%a_][%w_]*%s*>%s*$")
          or line:match("^%s*<Points%s+critiques%s+de%s+[%a_][%w_]*%s*>%s*$") then
        local quoi = line:match("^%s*<(.-)%s+de%s+[%a_][%w_]*%s*>%s*$")
        local nom = line:match("de%s+([%a_][%w_]*)%s*>%s*$")
        local TAG = { ["Gradient"] = "sympygrad",
          ["Matrice hessienne"] = "sympyhess",
          ["Points critiques"] = "sympycrit" }
        local def, fvars, fexpr = fn_multi(nom, quoi)
        out[#out + 1] = "<" .. TAG[quoi] .. " " .. nom .. " "
          .. fvars .. ">{"
        out[#out + 1] = fexpr
        out[#out + 1] = "}"

      elseif line:match("^%s*<Dérivée%s+partielle%s+de%s+[%a_][%w_]*%s+par%s+rapport%s+à%s+[%a_][%w_]*%s*>%s*$") then
        local nom, wrt = line:match(
          "de%s+([%a_][%w_]*)%s+par%s+rapport%s+à%s+([%a_][%w_]*)%s*>")
        local def, fvars, fexpr = fn_multi(nom, "Dérivée partielle")
        out[#out + 1] = "<sympypartial " .. nom .. " " .. fvars .. " "
          .. wrt .. ">{"
        out[#out + 1] = fexpr
        out[#out + 1] = "}"

      elseif (line:match("^%s*<Espérance%s+de%s+[%a_][%w_]*%s*>%s*$")
          or line:match("^%s*<Variance%s+de%s+[%a_][%w_]*%s*>%s*$")
          or line:match("^%s*<Écart%s+type%s+de%s+[%a_][%w_]*%s*>%s*$"))
          and L._lois[line:match("de%s+([%a_][%w_]*)%s*>%s*$")] then
        local quoi = line:match("^%s*<(.-)%s+de%s+")
        local nom = line:match("de%s+([%a_][%w_]*)%s*>%s*$")
        local TAG = { ["Espérance"] = "loimean", ["Variance"] = "loivar",
          ["Écart type"] = "loistd" }
        out[#out + 1] = "<" .. TAG[quoi] .. " " .. nom .. ">{"
        for _, r in ipairs(L._lois[nom]) do out[#out + 1] = r end
        out[#out + 1] = "}"

      elseif line:match("^%s*<Série%s+de%s+Fourier%s+de%s+[%a_][%w_]*") then
        local corps = line:match("^%s*<Série%s+de%s+Fourier%s+de%s+(.-)%s*>%s*$")
        local nom = corps:match("^([%a_][%w_]*)")
        local reste = corps:sub(#nom + 1)
        local a, b = reste:match("sur%s*%[%s*(.-)%s*;%s*(.-)%s*%]")
        local n = reste:match("à%s+l'ordre%s+(%d+)")
        local propre = reste:gsub("sur%s*%b[]", ""):gsub("à%s+l'ordre%s+%d+", "")
        if propre:match("%S") then
          error("texecole : la forme est <Calcule la série de Fourier de "
            .. "f>, suivie au besoin de « sur [-pi ; pi] » et de « à "
            .. "l'ordre n ».", 0)
        end
        local _, fvar, fexpr = fn_requise(nom, "Série de Fourier")
        out[#out + 1] = "<sympyfourier " .. nom .. " " .. fvar .. " "
          .. num_fr(a or "-pi") .. " " .. num_fr(b or "pi") .. " "
          .. (n or "4") .. ">{"
        out[#out + 1] = fexpr
        out[#out + 1] = "}"

      elseif line:match("^%s*<Transformée%s+de%s+Laplace%s+de%s+[%a_][%w_]*%s*>%s*$") then
        local nom = line:match("de%s+([%a_][%w_]*)%s*>%s*$")
        local _, fvar, fexpr = fn_requise(nom, "Transformée de Laplace")
        if fvar == "p" then
          error("texecole : la transformée de Laplace s'exprime en la "
            .. "variable p — posez la fonction en une autre variable, "
            .. "par exemple " .. nom .. "(t).", 0)
        end
        out[#out + 1] = "<sympylaplace " .. nom .. " " .. fvar .. ">{"
        out[#out + 1] = fexpr
        out[#out + 1] = "}"

      elseif line:match("^%s*<Transformée%s+de%s+Laplace%s+inverse%s+de%s+[%a_][%w_]*%s*>%s*$") then
        local nom = line:match("de%s+([%a_][%w_]*)%s*>%s*$")
        local _, fvar, fexpr = fn_requise(nom, "Transformée de Laplace inverse")
        if fvar == "t" then
          error("texecole : l'originale s'exprime en la variable t — "
            .. "posez la transformée en une autre variable, par exemple "
            .. nom .. "(p).", 0)
        end
        out[#out + 1] = "<sympyinvlaplace " .. nom .. " " .. fvar .. ">{"
        out[#out + 1] = fexpr
        out[#out + 1] = "}"

      elseif line:match("^%s*<Wronskien%s+de%s+") then
        local liste = line:match("^%s*<Wronskien%s+de%s+(.-)%s*>%s*$")
        local noms, exprs, lavar = {}, {}, nil
        for nom in liste:gsub("%s+et%s+", ", "):gmatch("[^,]+") do
          nom = trim(nom)
          if nom ~= "" then
            local _, fvar, fexpr = fn_requise(nom, "Wronskien")
            if lavar and fvar ~= lavar then
              error("texecole : le wronskien demande des fonctions de la "
                .. "même variable — ici " .. lavar .. " et " .. fvar .. ".", 0)
            end
            lavar = fvar
            noms[#noms + 1] = nom
            exprs[#exprs + 1] = fexpr
          end
        end
        if #noms < 2 then
          error("texecole : le wronskien demande au moins deux fonctions "
            .. "— <Calcule le wronskien de f et g>.", 0)
        end
        out[#out + 1] = "<sympywronsk " .. lavar .. " "
          .. table.concat(noms, " ") .. ">{"
        for _, e in ipairs(exprs) do out[#out + 1] = e end
        out[#out + 1] = "}"

      elseif line:match("^%s*<image%s+d[ue']") then
        local fig_txt, tr_txt = line:match(
          "^%s*<image%s+(.-)%s+par%s+(.-)%s*>%s*$")
        if not fig_txt then
          error("texecole : la forme est <Construis l'image du triangle "
            .. "ABC par la symétrie centrale de centre O>.", 0)
        end
        local FKIND = { point = "point", segment = "segment",
          triangle = "triangle", ["quadrilatère"] = "quadrilatère",
          polygone = "polygone" }
        local kind, lettres
        for mot, k in pairs(FKIND) do
          local l = fig_txt:match("^d[ue']%s*" .. mot
            .. "%s+%[?([%u%s]+)%]?%s*$")
          if l then kind, lettres = k, l:gsub("%s", "") end
        end
        if not kind then
          error("texecole : figure non reconnue dans « " .. fig_txt
            .. " » — point A, segment [AB], triangle ABC, quadrilatère "
            .. "ABCD ou polygone ABCDE.", 0)
        end
        local function pt_requis(nom, quoi)
          local co = L._points and L._points[nom]
          if co then return (co:gsub("[%(%)]", "")) end
          if nom == "O" then return "0,0" end
          error("texecole : <" .. quoi .. "> demande que le point " .. nom
            .. " ait été posé : <Soit>un point " .. nom .. "(x;y).", 0)
        end
        local champs = { kind, lettres }
        for nom in lettres:gmatch("%u") do
          champs[#champs + 1] = nom .. ":"
            .. pt_requis(nom, "l'image de la figure")
        end
        local tr = trim(tr_txt)
        if tr:match("^la%s+symétrie%s+axiale%s+d'axe%s+l'axe%s+des%s+abscisses$") then
          champs[#champs + 1] = "symax"
          champs[#champs + 1] = "0,0"
          champs[#champs + 1] = "1,0"
          champs[#champs + 1] = "l'axe des abscisses"
        elseif tr:match("^la%s+symétrie%s+axiale%s+d'axe%s+l'axe%s+des%s+ordonnées$") then
          champs[#champs + 1] = "symax"
          champs[#champs + 1] = "0,0"
          champs[#champs + 1] = "0,1"
          champs[#champs + 1] = "l'axe des ordonnées"
        elseif tr:match("^la%s+symétrie%s+axiale%s+d'axe%s+%(%u%u%)$") then
          local p1, p2 = tr:match("%((%u)(%u)%)")
          champs[#champs + 1] = "symax2"
          champs[#champs + 1] = pt_requis(p1, "l'axe (" .. p1 .. p2 .. ")")
          champs[#champs + 1] = pt_requis(p2, "l'axe (" .. p1 .. p2 .. ")")
          champs[#champs + 1] = "(" .. p1 .. p2 .. ")"
        elseif tr:match("^la%s+symétrie%s+centrale%s+de%s+centre%s+%u$") then
          local ctr = tr:match("centre%s+(%u)$")
          champs[#champs + 1] = "symc"
          champs[#champs + 1] = pt_requis(ctr, "la symétrie centrale")
          champs[#champs + 1] = ctr
        elseif tr:match("^la%s+translation%s+de%s+vecteur%s+[%a_][%w_]*$") then
          local v = tr:match("vecteur%s+([%a_][%w_]*)$")
          local co = vec_requis(v, "la translation de vecteur " .. v)
          co = co:gsub("[%(%)]", ""):gsub("%s*;%s*", ",")
          champs[#champs + 1] = "trans"
          champs[#champs + 1] = co
          champs[#champs + 1] = "de vecteur $\\vec{" .. v .. "}$"
        elseif tr:match("^la%s+translation%s+qui%s+transforme%s+%u%s+en%s+%u$") then
          local p1, p2 = tr:match("transforme%s+(%u)%s+en%s+(%u)$")
          champs[#champs + 1] = "trans2"
          champs[#champs + 1] = pt_requis(p1, "la translation")
          champs[#champs + 1] = pt_requis(p2, "la translation")
          champs[#champs + 1] = "qui transforme $" .. p1 .. "$ en $"
            .. p2 .. "$"
        elseif tr:match("^la%s+rotation%s+de%s+centre%s+%u%s+et%s+d'angle%s+") then
          local ctr, ang, sens = tr:match(
            "centre%s+(%u)%s+et%s+d'angle%s+([%d,%.]+)%s*degrés?(.*)$")
          if not ctr then
            error("texecole : la forme est <Construis l'image du triangle "
              .. "ABC par la rotation de centre O et d'angle 90 degrés>, "
              .. "au besoin suivie de « dans le sens des aiguilles d'une "
              .. "montre ».", 0)
          end
          champs[#champs + 1] = "rot"
          champs[#champs + 1] = pt_requis(ctr, "la rotation")
          champs[#champs + 1] = num_fr(ang)
          champs[#champs + 1] = trim(sens):match("aiguilles")
            and "horaire" or "direct"
          champs[#champs + 1] = ctr
        elseif tr:match("^l'homothétie%s+de%s+centre%s+%u%s+et%s+de%s+rapport%s+") then
          local ctr, k = tr:match(
            "centre%s+(%u)%s+et%s+de%s+rapport%s+(-?[%d,%./]+)%s*$")
          if not ctr then
            error("texecole : la forme est <Construis l'image du triangle "
              .. "ABC par l'homothétie de centre O et de rapport 2>.", 0)
          end
          champs[#champs + 1] = "hom"
          champs[#champs + 1] = pt_requis(ctr, "l'homothétie")
          champs[#champs + 1] = num_fr(k)
          champs[#champs + 1] = ctr
        else
          error("texecole : transformation non reconnue : « " .. tr
            .. " ». Transformations admises : la symétrie axiale d'axe "
            .. "l'axe des abscisses / des ordonnées / (PQ), la symétrie "
            .. "centrale de centre O, la translation de vecteur u ou qui "
            .. "transforme A en B, la rotation de centre O et d'angle N "
            .. "degrés, l'homothétie de centre O et de rapport k.", 0)
        end
        out[#out + 1] = "<transfo " .. table.concat(champs, "|") .. ">"

      elseif line:match("^%s*<Calcule%s+%u%u%s+dans%s+le%s+triangle%s+%u%u%u%s+rectangle%s+en%s+%u%s*,?%s+avec%s+") then
        local cible, tri, droit, reste = line:match(
          "^%s*<Calcule%s+(%u%u)%s+dans%s+le%s+triangle%s+(%u%u%u)%s+"
          .. "rectangle%s+en%s+(%u)%s*,?%s+avec%s+(.-)%s*>%s*$")
        local tag = reste:find("l'angle") and "trigorect" or "pythag"
        out[#out + 1] = "<" .. tag .. " " .. cible .. " " .. tri .. " "
          .. droit .. " avec " .. num_fr(reste) .. ">"

      elseif line:match("^%s*<Calcule%s+l'angle%s+%u%s+dans%s+le%s+triangle%s+") then
        local sommet, tri, droit, reste = line:match(
          "^%s*<Calcule%s+l'angle%s+(%u)%s+dans%s+le%s+triangle%s+(%u%u%u)"
          .. "%s+rectangle%s+en%s+(%u)%s*,?%s+avec%s+(.-)%s*>%s*$")
        if not sommet then
          error("texecole : la forme est <Calcule l'angle A dans le "
            .. "triangle ABC rectangle en B, avec AB = 3 et AC = 6>.", 0)
        end
        out[#out + 1] = "<trigoangle " .. sommet .. " " .. tri .. " "
          .. droit .. " avec " .. num_fr(reste) .. ">"

      elseif line:match("^%s*<Vérifie%s+si%s+le%s+triangle%s+%u%u%u%s+est%s+rectangle") then
        local tri, reste = line:match(
          "^%s*<Vérifie%s+si%s+le%s+triangle%s+(%u%u%u)%s+est%s+rectangle"
          .. "%s*,?%s+avec%s+(.-)%s*>%s*$")
        if not tri then
          error("texecole : la forme est <Vérifie si le triangle ABC est "
            .. "rectangle, avec AB = 3, BC = 4 et AC = 5>.", 0)
        end
        out[#out + 1] = "<pythagrec " .. tri .. " avec " .. num_fr(reste)
          .. ">"

      elseif line:match("^%s*<Calcule%s+%u%u%s+par%s+le%s+théorème%s+de%s+Thalès") then
        local cible, reste = line:match(
          "^%s*<Calcule%s+(%u%u)%s+par%s+le%s+théorème%s+de%s+Thalès"
          .. "%s*,?%s+avec%s+(.-)%s*>%s*$")
        if not cible then
          error("texecole : la forme est <Calcule AC par le théorème de "
            .. "Thalès, avec AM = 3, AB = 6 et AN = 4>.", 0)
        end
        out[#out + 1] = "<thales " .. cible .. " avec " .. num_fr(reste)
          .. ">"

      elseif line:match("^%s*<Vérifie%s+si%s+les%s+droites%s+") then
        local reste = line:match(
          "^%s*<Vérifie%s+si%s+les%s+droites%s+%b()%s+et%s+%b()%s+sont%s+"
          .. "parallèles%s*,?%s+avec%s+(.-)%s*>%s*$")
        if not reste then
          error("texecole : la forme est <Vérifie si les droites (MN) et "
            .. "(BC) sont parallèles, avec AM = 3, AB = 6, AN = 4 et "
            .. "AC = 8>.", 0)
        end
        out[#out + 1] = "<thalesrec avec " .. num_fr(reste) .. ">"

      elseif line:match("^%s*<Moyenne%s+de%s+la%s+série%s+") then
        local corps = line:match(
          "^%s*<Moyenne%s+de%s+la%s+série%s+(.-)%s*>%s*$")
        local vs, es = corps:match(
          "^de%s+valeurs%s+(.-)%s+et%s+d'effectifs%s+(.+)$")
        if vs then
          out[#out + 1] = "<statmoy " .. num_fr(vs) .. " !! "
            .. num_fr(es) .. ">"
        else
          out[#out + 1] = "<statmoy " .. num_fr(corps) .. ">"
        end

      elseif line:match("^%s*<Variance%s+de%s+la%s+série%s+") then
        local corps = line:match(
          "^%s*<Variance%s+de%s+la%s+série%s+(.-)%s*>%s*$")
        local vs, es = corps:match(
          "^de%s+valeurs%s+(.-)%s+et%s+d'effectifs%s+(.+)$")
        if vs then
          out[#out + 1] = "<statvar " .. num_fr(vs) .. " !! "
            .. num_fr(es) .. ">"
        else
          out[#out + 1] = "<statvar " .. num_fr(corps) .. ">"
        end

      elseif line:match("^%s*<Écart%s+type%s+de%s+la%s+série%s+") then
        local corps = line:match(
          "^%s*<Écart%s+type%s+de%s+la%s+série%s+(.-)%s*>%s*$")
        local vs, es = corps:match(
          "^de%s+valeurs%s+(.-)%s+et%s+d'effectifs%s+(.+)$")
        if vs then
          out[#out + 1] = "<statstd " .. num_fr(vs) .. " !! "
            .. num_fr(es) .. ">"
        else
          out[#out + 1] = "<statstd " .. num_fr(corps) .. ">"
        end

      elseif line:match("^%s*<Covariance%s+des%s+séries%s+") then
        local corps = line:match(
          "^%s*<Covariance%s+des%s+séries%s+(.-)%s*>%s*$")
        local xa, ya = corps:match("^(.-)%s+et%s+(.+)$")
        if not xa then
          error("texecole : la forme est <Calcule>la covariance des "
            .. "séries 1 ; 2 ; 3 et 2 ; 4 ; 7.", 0)
        end
        out[#out + 1] = "<statcov " .. num_fr(xa) .. " !! "
          .. num_fr(ya) .. ">"

      elseif line:match("^%s*<Médiane%s+de%s+la%s+série%s+") then
        local corps = line:match(
          "^%s*<Médiane%s+de%s+la%s+série%s+(.-)%s*>%s*$")
        out[#out + 1] = "<statmed " .. num_fr(corps) .. ">"

      elseif line:match("^%s*<Étendue%s+de%s+la%s+série%s+") then
        local corps = line:match(
          "^%s*<Étendue%s+de%s+la%s+série%s+(.-)%s*>%s*$")
        out[#out + 1] = "<statetendue " .. num_fr(corps) .. ">"

      elseif line:match("^%s*<Quartiles%s+de%s+la%s+série%s+") then
        local corps = line:match(
          "^%s*<Quartiles%s+de%s+la%s+série%s+(.-)%s*>%s*$")
        out[#out + 1] = "<statquart " .. num_fr(corps) .. ">"

      elseif line:match("^%s*<Quatrième%s+proportionnelle%s+de%s+") then
        local corps = line:match(
          "^%s*<Quatrième%s+proportionnelle%s+de%s+(.-)%s*>%s*$")
        local nombres = {}
        for tok in (corps:gsub("%s+et%s+", ", ") .. ","):gmatch("(.-),") do
          if tok:match("%S") then
            nombres[#nombres + 1] = num_fr(tok:gsub("%s", ""))
          end
        end
        if #nombres ~= 3 then
          error("texecole : la forme est <Calcule la quatrième "
            .. "proportionnelle de 3, 5 et 12>.", 0)
        end
        out[#out + 1] = "<prop4 " .. table.concat(nombres, " ") .. ">"

      elseif line:match("^%s*<Vérifie%s+si%s+le%s+tableau%s+est%s+de%s+proportionnalité%s*>%s*{%s*$") then
        out[#out + 1] = "<proptab>{"
        mode = "collegetab"

      elseif line:match("^%s*<Complète%s+le%s+tableau%s+de%s+proportionnalité%s*>%s*{%s*$") then
        out[#out + 1] = "<propcomplete>{"
        mode = "collegetab"

      elseif line:match("^%s*<Calcule%s+[%d,%./]+%s*%%%s+de%s+[%d,%./]+%s*>%s*$") then
        local p, v = line:match(
          "^%s*<Calcule%s+([%d,%./]+)%s*%%%s+de%s+([%d,%./]+)%s*>%s*$")
        out[#out + 1] = "<pctde " .. num_fr(p) .. " " .. num_fr(v) .. ">"

      elseif line:match("^%s*<augmentation%s+de%s+")
          or line:match("^%s*<diminution%s+de%s+") then
        local sens, p, v = line:match(
          "^%s*<(%a+)%s+de%s+([%d,%./]+)%s*%%%s+à%s+([%d,%./]+)%s*>%s*$")
        if not sens then
          error("texecole : la forme est <Applique une augmentation de "
            .. "5 % à 240> ou <Applique une diminution de 12 % à 60>.", 0)
        end
        out[#out + 1] = "<pctevo "
          .. (sens == "augmentation" and "hausse" or "baisse") .. " "
          .. num_fr(p) .. " " .. num_fr(v) .. ">"

      elseif line:match("^%s*<Taux%s+d'évolution%s+de%s+") then
        local a, b = line:match(
          "^%s*<Taux%s+d'évolution%s+de%s+([%d,%./]+)%s+à%s+([%d,%./]+)%s*>%s*$")
        if not a then
          error("texecole : la forme est <Calcule le taux d'évolution de "
            .. "250 à 280>.", 0)
        end
        out[#out + 1] = "<pcttaux " .. num_fr(a) .. " " .. num_fr(b) .. ">"

      elseif line:match("^%s*<Échelle%s+où%s+") then
        local vp, up, vr, ur = line:match(
          "^%s*<Échelle%s+où%s+([%d,%./]+)%s*(%a+)%s+représentent?%s+"
          .. "([%d,%./]+)%s*(%a+)%s*>%s*$")
        if not vp then
          error("texecole : la forme est <Calcule l'échelle d'un plan où "
            .. "2 cm représentent 50 m>.", 0)
        end
        out[#out + 1] = "<echelle " .. num_fr(vp) .. " " .. up .. " "
          .. num_fr(vr) .. " " .. ur .. ">"

      elseif line:match("^%s*<Vitesse%s+moyenne%s+pour%s+") then
        local d, t = line:match(
          "^%s*<Vitesse%s+moyenne%s+pour%s+([%d,%./]+)%s*km%s+en%s+(.-)%s*>%s*$")
        if not d then
          error("texecole : la forme est <Calcule la vitesse moyenne pour "
            .. "150 km en 2 h 30 min>.", 0)
        end
        out[#out + 1] = "<vitesse " .. num_fr(d) .. " !! " .. num_fr(t)
          .. ">"

      elseif line:match("^%s*<Distance%s+parcourue%s+à%s+") then
        local v, t = line:match(
          "^%s*<Distance%s+parcourue%s+à%s+([%d,%./]+)%s*km/h%s+pendant%s+(.-)%s*>%s*$")
        if not v then
          error("texecole : la forme est <Calcule la distance parcourue à "
            .. "80 km/h pendant 1 h 45 min>.", 0)
        end
        out[#out + 1] = "<distance " .. num_fr(v) .. " !! " .. num_fr(t)
          .. ">"

      elseif line:match("^%s*<Durée%s+du%s+trajet%s+de%s+") then
        local d, v = line:match(
          "^%s*<Durée%s+du%s+trajet%s+de%s+([%d,%./]+)%s*km%s+à%s+"
          .. "([%d,%./]+)%s*km/h%s*>%s*$")
        if not d then
          error("texecole : la forme est <Calcule la durée du trajet de "
            .. "210 km à 60 km/h>.", 0)
        end
        out[#out + 1] = "<dureetag " .. num_fr(d) .. " " .. num_fr(v)
          .. ">"

      elseif line:match("^%s*<Périmètre%s+d") or line:match("^%s*<Aire%s+d")
          or line:match("^%s*<Volume%s+d") then
        local quoi, reste = line:match(
          "^%s*<([%a\128-\255]+)%s+(d.-)%s*>%s*$")
        local TAG = { ["Périmètre"] = "perimetre", ["Aire"] = "aire",
                      ["Volume"] = "volume" }
        out[#out + 1] = "<mesure " .. TAG[quoi] .. " " .. num_fr(reste)
          .. ">"

      elseif line:match("^%s*<Convertis%s+") then
        local corps = line:match("^%s*<Convertis%s+(.-)%s*>%s*$")
        out[#out + 1] = "<convunit " .. num_fr(corps) .. ">"

      elseif line:match("^%s*<Calcule%s+-?%d+%s*/%s*%d+%s*[%+%-%*:x×÷]%s*-?%d+%s*/%s*%d+%s*>%s*$") then
        local corps = line:match("^%s*<Calcule%s+(.-)%s*>%s*$")
        corps = corps:gsub("[x×]", "*"):gsub("÷", ":")
        out[#out + 1] = "<fracdet " .. corps .. ">"

      elseif line:match("^%s*<Calcule%s+-?%d+%s*/%s*%d+%s*[%+%-%*:x×÷]%s*-?%d+%s*/%s*%d+%s+en%s+détaillant%s*>%s*$") then
        local corps = line:match(
          "^%s*<Calcule%s+(.-)%s+en%s+détaillant%s*>%s*$")
        corps = corps:gsub("[x×]", "*"):gsub("÷", ":")
        out[#out + 1] = "<fracdet " .. corps .. ">"

      elseif line:match("^%s*<Simplifie%s+la%s+fraction%s+") then
        local fr = line:match(
          "^%s*<Simplifie%s+la%s+fraction%s+(-?%d+%s*/%s*%d+)%s*>%s*$")
        if not fr then
          error("texecole : la forme est <Simplifie la fraction 84/60>.", 0)
        end
        out[#out + 1] = "<fracsimp " .. fr .. ">"

      elseif line:match("^%s*<nombre%s+.-%s+en%s+notation%s+scientifique%s*>%s*$") then
        local corps = line:match(
          "^%s*<nombre%s+(.-)%s+en%s+notation%s+scientifique%s*>%s*$")
        out[#out + 1] = "<notasci " .. num_fr(corps) .. ">"

      elseif line:match("^%s*<Vérifie%s+si%s+%d+%s+est%s+divisible%s+par%s+%d+%s*>%s*$") then
        local n, p = line:match(
          "^%s*<Vérifie%s+si%s+(%d+)%s+est%s+divisible%s+par%s+(%d+)%s*>%s*$")
        out[#out + 1] = "<divisible " .. n .. " " .. p .. ">"

      elseif line:match("^%s*<programme%s+de%s+calcul%s+à%s+") then
        local x = line:match(
          "^%s*<programme%s+de%s+calcul%s+à%s+(%S+)%s*>%s*{%s*$")
        if not x then
          error("texecole : la forme est <Applique le programme de calcul "
            .. "à 5>{ ... }, une étape par ligne.", 0)
        end
        out[#out + 1] = "<progcalc " .. num_fr(x) .. ">{"
        mode = "collegetab"

      elseif line:match("^%s*<Exprime%s+le%s+programme%s+de%s+calcul%s+en%s+fonction%s+de%s+") then
        local v = line:match(
          "^%s*<Exprime%s+le%s+programme%s+de%s+calcul%s+en%s+fonction%s+"
          .. "de%s+(%a)%s*>%s*{%s*$")
        if not v then
          error("texecole : la forme est <Exprime le programme de calcul "
            .. "en fonction de x>{ ... }.", 0)
        end
        out[#out + 1] = "<progcalcx " .. v .. ">{"
        mode = "collegetab"

      elseif line:match("^%s*<Soit%s+le%s+système%s+[%a_][%w_]*%s*>%s*{%s*$") then
        acc = { nom = line:match("<Soit%s+le%s+système%s+([%a_][%w_]*)"),
                eqs = {} }
        out[#out + 1] = "<system " .. acc.nom .. ">{"
        mode = "systeme"

      elseif line:match("^%s*<Intégrale%s+numérique%s+de%s+[%a_][%w_]*%s+entre%s+") then
        local nom, a, b = line:match(
          "^%s*<Intégrale%s+numérique%s+de%s+([%a_][%w_]*)%s+entre%s+(%S+)%s+et%s+(%S+)%s*>%s*$")
        if not nom then
          error("texecole : la forme est <Intégrale numérique de f entre a et b>.", 0)
        end
        local _, fvar, fexpr = fn_requise(nom, "Intégrale numérique")
        out[#out + 1] = "<sympynint " .. nom .. " " .. fvar .. " "
          .. a:gsub(",", ".") .. " " .. b:gsub(",", ".") .. ">{"
        out[#out + 1] = fexpr
        out[#out + 1] = "}"

      elseif line:match("^%s*<Limite%s+de%s+[%a_][%w_]*%s+en%s+") then
        local nom, reste = line:match("^%s*<Limite%s+de%s+([%a_][%w_]*)%s+en%s+(.-)%s*>%s*$")
        if not nom then
          error("texecole : la forme est <Limite de f en a>, avec a fini, +infini ou -infini, suivie au besoin de « à droite » ou « à gauche ».", 0)
        end
        local pt, dir = reste:match("^(%S+)%s+à%s+(droite)$")
        if not pt then pt, dir = reste:match("^(%S+)%s+à%s+(gauche)$") end
        if not pt then pt, dir = reste, "" end
        local _, fvar, fexpr = fn_requise(nom, "Limite")
        out[#out + 1] = "<sympylimit " .. nom .. " " .. fvar .. " "
          .. pt:gsub(",", ".") .. (dir ~= "" and (" " .. dir) or "") .. ">{"
        out[#out + 1] = fexpr
        out[#out + 1] = "}"

      elseif line:match("^%s*<Développement%s+limité%s+de%s+") then
        local nom, a, n = line:match(
          "^%s*<Développement%s+limité%s+de%s+([%a_][%w_]*)%s+en%s+(%S+)%s+à%s+l'ordre%s+(%d+)%s*>%s*$")
        if not nom then
          error("texecole : la forme est <Calcule le développement limité de f en a à l'ordre n>.", 0)
        end
        local _, fvar, fexpr = fn_requise(nom, "Développement limité")
        out[#out + 1] = "<sympydl " .. nom .. " " .. fvar .. " "
          .. a:gsub(",", ".") .. " " .. n .. ">{"
        out[#out + 1] = fexpr
        out[#out + 1] = "}"

      elseif line:match("^%s*<Racines%s+") then
        local ORD = { ["carrées"] = 2, ["cubiques"] = 3, ["quatrièmes"] = 4,
          ["cinquièmes"] = 5, ["sixièmes"] = 6, ["septièmes"] = 7,
          ["huitièmes"] = 8, ["neuvièmes"] = 9, ["dixièmes"] = 10,
          ["onzièmes"] = 11, ["douzièmes"] = 12 }
        local ordinal, expr = line:match(
          "^%s*<Racines%s+([%a\128-\255]+)%s+de%s+(.-)%s*>%s*$")
        local n = ordinal and ORD[ordinal]
        if not n then
          error("texecole : la forme est <Calcule les racines n-ièmes de "
            .. "EXPR> avec l'ordinal en toutes lettres — racines carrées, "
            .. "cubiques, quatrièmes... douzièmes. Par exemple : "
            .. "<Calcule les racines cinquièmes de 1> (les racines "
            .. "cinquièmes de l'unité).", 0)
        end
        expr = expr:gsub("^l'unité$", "1")
        out[#out + 1] = "<sympynroots " .. n .. ">{"
        out[#out + 1] = num_fr(expr)
        out[#out + 1] = "}"

      elseif line:match("^%s*<Factorise%s+.->%s*$")
          or line:match("^%s*<Simplifie%s+.->%s*$") then
        local verbe, expr = line:match("^%s*<(%a+)%s+(.-)>%s*$")
        out[#out + 1] = "<" .. (verbe == "Factorise" and "sympyfactor" or "sympysimplify") .. ">{"
        out[#out + 1] = num_fr(expr)
        out[#out + 1] = "}"

      elseif line:match("^%s*<Décompose%s+.->%s*$") then
        local expr = line:match("^%s*<Décompose%s+(.-)>%s*$")
        expr = expr:gsub("^en%s+éléments%s+simples%s+", "")
        out[#out + 1] = "<sympyapart>{"
        out[#out + 1] = num_fr(expr)
        out[#out + 1] = "}"

      elseif line:match("^%s*<Résous%s+numériquement%s+l'équation%s+.->%s*$") then
        local eq, a, b = line:match(
          "^%s*<Résous%s+numériquement%s+l'équation%s+(.-)%s+sur%s*%[%s*(.-)%s*;%s*(.-)%s*%]%s*>%s*$")
        if not eq then
          error("texecole : la forme est <Résous numériquement l'équation "
            .. "EXPR = EXPR sur [a ; b]> — l'intervalle de recherche est "
            .. "obligatoire.", 0)
        end
        out[#out + 1] = "<scipyroot " .. num_fr(trim(a)) .. " "
          .. num_fr(trim(b)) .. ">{"
        out[#out + 1] = num_fr(eq)
        out[#out + 1] = "}"

      elseif line:match("^%s*<Résous%s+l'équation%s+aux%s+dérivées%s+partielles%s+.->%s*$") then
        local eq = line:match(
          "^%s*<Résous%s+l'équation%s+aux%s+dérivées%s+partielles%s+(.-)>%s*$")
        local f = eq:match("([%a])_[xy]") or "u"
        out[#out + 1] = "<sympypde " .. f .. ">{"
        out[#out + 1] = transformer_edp(eq, f)
        out[#out + 1] = "}"

      elseif line:match("^%s*<Résous%s+l'équation%s+différentielle%s+.->%s*$") then
        local eq = line:match("^%s*<Résous%s+l'équation%s+différentielle%s+(.-)>%s*$")
        local fdecl, vdecl = eq:match(",%s*d'inconnue%s+([%a])%(([%a])%)%s*$")
        if fdecl then
          eq = eq:gsub(",%s*d'inconnue%s+[%a]%([%a]%)%s*$", "")
        end
        local f = fdecl or eq:match("([%a])''") or eq:match("([%a])'") or "y"
        local var = vdecl or "x"
        out[#out + 1] = "<sympyode " .. f .. " " .. var .. ">{"
        out[#out + 1] = transformer_edo(eq, f, var)
        out[#out + 1] = "}"

      elseif line:match("^%s*<Résous%s+dans%s+.-%s+l'équation%s+.->%s*$") then
        local dom, eq = line:match(
          "^%s*<Résous%s+dans%s+(.-)%s+l'équation%s+(.-)>%s*$")
        local domaine = V.DOMAINES[dom]
        if not domaine then
          error("texecole : domaine de résolution inconnu : « " .. dom
            .. " » (attendu : RR, CC, ZZ, NN, QQ ou leur nom en toutes "
            .. "lettres : les réels, les complexes...).", 0)
        end
        out[#out + 1] = "<sympysolveeq " .. domaine .. ">{"
        out[#out + 1] = num_fr(eq)
        out[#out + 1] = "}"

      elseif line:match("^%s*<Résous%s+l'équation%s+.->%s*$") then
        local eq = line:match("^%s*<Résous%s+l'équation%s+(.-)>%s*$")
        out[#out + 1] = "<sympysolveeq>{"
        out[#out + 1] = num_fr(eq)
        out[#out + 1] = "}"

      elseif line:match("^%s*<Soit%s+la%s+matrice%s+[%a_][%w_]*%s*>%s*{%s*$")
          or line:match("^%s*<Soit%s+la%s+matrice%s+[%a_][%w_]*%s+entre%s+crochets%s*>%s*{%s*$") then
        local crochets = line:match("entre%s+crochets%s*>%s*{%s*$") ~= nil
        acc = { nom = line:match("<Soit%s+la%s+matrice%s+([%a_][%w_]*)"), rows = {} }
        out[#out + 1] = (crochets and "<bmatrix " or "<matrix ")
          .. acc.nom .. ">{"
        mode = "matrice"

      elseif line:match("^%s*<Déterminant%s+de%s+[%a_][%w_]*%s*>%s*$")
          or line:match("^%s*<Inverse%s+de%s+[%a_][%w_]*%s*>%s*$") then
        local verbe, nom = line:match("^%s*<([%a\128-\255]+)%s+de%s+([%a_][%w_]*)%s*>%s*$")
        local mat = mat_requise(nom, verbe)
        out[#out + 1] = "<" .. (verbe == "Déterminant" and "sympydet" or "sympyinv")
          .. " " .. nom .. ">{"
        for _, r in ipairs(mat) do out[#out + 1] = r end
        out[#out + 1] = "}"

      elseif line:match("^%s*<Valeurs%s+propres%s+de%s+[%a_][%w_]*%s*>%s*$") then
        local nom = line:match("de%s+([%a_][%w_]*)%s*>")
        local mat = mat_requise(nom, "Valeurs propres")
        out[#out + 1] = "<sympyeigen " .. nom .. ">{"
        for _, r in ipairs(mat) do out[#out + 1] = r end
        out[#out + 1] = "}"

      elseif line:match("^%s*<Diagonalise%s+[%a_][%w_]*%s*>%s*$") then
        local nom = line:match("^%s*<Diagonalise%s+([%a_][%w_]*)%s*>%s*$")
        local mat = mat_requise(nom, "Diagonalise")
        out[#out + 1] = "<sympydiag " .. nom .. ">{"
        for _, r in ipairs(mat) do out[#out + 1] = r end
        out[#out + 1] = "}"

      elseif line:match("^%s*<Primitive%s+de%s+[%a_][%w_]*%s*>%s*$") then
        local nom = line:match("de%s+([%a_][%w_]*)%s*>")
        local _, fvar, fexpr = fn_requise(nom, "Primitive")
        out[#out + 1] = "<sympyprim " .. nom .. " " .. fvar .. ">{"
        out[#out + 1] = fexpr
        out[#out + 1] = "}"

      elseif line:match("^%s*<Développe%s+.->%s*$") then
        local expr = line:match("^%s*<Développe%s+(.-)>%s*$")
        expr = expr:gsub("^et%s+réduis%s+", "")
        out[#out + 1] = "<sympyexpand>{"
        out[#out + 1] = num_fr(expr)
        out[#out + 1] = "}"

      elseif line:match("^%s*<Forme%s+canonique%s+de%s+.->%s*$")
          or line:match("^%s*<Mets%s+.-%s+sous%s+forme%s+canonique%s*>%s*$") then
        local expr = line:match("^%s*<Forme%s+canonique%s+de%s+(.-)>%s*$")
                  or line:match("^%s*<Mets%s+(.-)%s+sous%s+forme%s+canonique%s*>%s*$")
        out[#out + 1] = "<sympycanon>{"
        out[#out + 1] = num_fr(expr)
        out[#out + 1] = "}"

      elseif line:match("^%s*<Somme%s+de%s+.-%s+pour%s+")
          or line:match("^%s*<Produit%s+de%s+.-%s+pour%s+") then
        local quoi, expr, var, a, b = line:match(
          "^%s*<(%a+)%s+de%s+(.-)%s+pour%s+([%a_][%w_]*)%s+de%s+(%S+)%s+à%s+(%S+)%s*>%s*$")
        if not quoi then
          error("texecole : la forme est <Calcule la somme de EXPR pour k de a à b> "
            .. "(ou <Produit de ...>).", 0)
        end
        out[#out + 1] = "<" .. (quoi == "Somme" and "sympysum" or "sympyprod")
          .. " " .. var .. " " .. num_fr(a) .. " " .. num_fr(b) .. ">{"
        out[#out + 1] = num_fr(expr)
        out[#out + 1] = "}"

      elseif line:match("^%s*<Probabilité%s+que%s+X%s*") then
        local op, val, nomloi, params = line:match(
          "^%s*<Probabilité%s+que%s+X%s*([<>]=?)%s*([%-%d,%.]+)%s+pour%s+la%s+loi%s+([%a%- ]+)%s*%((.-)%)%s*>%s*$")
        if not op then
          op = "="
          val, nomloi, params = line:match(
            "^%s*<Probabilité%s+que%s+X%s*=%s*([%-%d,%.]+)%s+pour%s+la%s+loi%s+([%a%- ]+)%s*%((.-)%)%s*>%s*$")
        end
        if not val then
          error("texecole : la forme est <Probabilité que X <= a pour la "
            .. "loi normale(m ; s)> — opérateurs <=, >=, =, <, > ; lois : "
            .. "normale(m;s), binomiale(n;p), poisson(l), uniforme(a;b), "
            .. "exponentielle(l), student(k), khi-deux(k).", 0)
        end
        local code = loi_ou_erreur(trim(nomloi))
        out[#out + 1] = "<scipyprob " .. LOI_OPS[op] .. " " .. num_fr(val)
          .. " " .. code .. " " .. params_loi(params) .. ">{"
        out[#out + 1] = "}"

      elseif line:match("^%s*<Quantile%s+d'ordre%s+") then
        local p, nomloi, params = line:match(
          "^%s*<Quantile%s+d'ordre%s+([%d,%.]+)%s+de%s+la%s+loi%s+([%a%- ]+)%s*%((.-)%)%s*>%s*$")
        if not p then
          error("texecole : la forme est <Calcule le quantile d'ordre 0,975 de la loi "
            .. "normale(0 ; 1)>.", 0)
        end
        local code = loi_ou_erreur(trim(nomloi))
        out[#out + 1] = "<scipyquantile " .. num_fr(p) .. " " .. code .. " "
          .. params_loi(params) .. ">{"
        out[#out + 1] = "}"

      elseif line:match("^%s*<Espérance%s+de%s+la%s+loi%s+")
          or line:match("^%s*<Écart%s+type%s+de%s+la%s+loi%s+") then
        local quoi = line:find("Espérance") and "mean" or "std"
        local nomloi, params = line:match(
          "de%s+la%s+loi%s+([%a%- ]+)%s*%((.-)%)%s*>%s*$")
        if not nomloi then
          error("texecole : la forme est <Espérance de la loi binomiale"
            .. "(10 ; 0,5)> ou <Écart type de la loi ...>.", 0)
        end
        local code = loi_ou_erreur(trim(nomloi))
        out[#out + 1] = "<scipymoment " .. quoi .. " " .. code .. " "
          .. params_loi(params) .. ">{"
        out[#out + 1] = "}"

      elseif line:match("^%s*<Ajuste%s+") then
        local fname, fvar, model, data = line:match(
          "^%s*<Ajuste%s+([%a_][%w_]*)%(([%a_][%w_]*)%)%s*=%s*(.-)%s+aux%s+données%s*(%b{})%s*>%s*$")
        if not fname then
          error("texecole : la forme est <Ajuste f(x) = a*exp(b*x) aux "
            .. "données {(0;1) (1;2,7) ...}> — les paramètres libres sont "
            .. "a, b, c, d.", 0)
        end
        out[#out + 1] = "<scipyfit " .. fname .. " " .. fvar .. ">{"
        out[#out + 1] = num_fr(model)
        out[#out + 1] = num_fr(data):gsub("%s*;%s*", ",")
        out[#out + 1] = "}"

      elseif line:match("^%s*<Étudie%s+les%s+variations%s+de%s+[%a_][%w_]*%s*>%s*$") then
        local nom = line:match("de%s+([%a_][%w_]*)%s*>")
        out[#out + 1] = "<vartab " .. nom .. ">"

      elseif line:match("^%s*<Dérivée%f[%s].-de%s+[%a_][%w_]*%s*>%s*$")
          or line:match("^%s*<Zéros%s+de%s+[%a_][%w_]*%s*>%s*$") then
        local ordre = 1
        if line:find("seconde") then ordre = 2
        elseif line:find("troisième") then ordre = 3 end
        local nom = line:match("de%s+([%a_][%w_]*)%s*>")
        local quoi = line:find("Zéros") and "Zéros" or "Dérivée"
        local _, fvar, fexpr = fn_requise(nom, quoi)
        if line:find("Zéros") then
          out[#out + 1] = "<sympyzeros " .. nom .. " " .. fvar .. ">{"
        else
          out[#out + 1] = "<sympyderiv " .. nom .. " " .. ordre .. " "
            .. fvar .. ">{"
        end
        out[#out + 1] = fexpr
        out[#out + 1] = "}"

      elseif line:match("^%s*<Résous%s+[%a_][%w_]*%s*,?%s*.->%s*$")
          or line:match("^%s*<Résous%s+le%s+système%s+[%a_][%w_]*") then
        local nom = line:match("<Résous%s+le%s+système%s+([%a_][%w_]*)")
          or line:match("<Résous%s+([%a_][%w_]*)")
        local sysdef = L._sys and L._sys[nom]
        if not sysdef then
          error("texecole : <Résous " .. nom .. "> demande que le "
            .. "système ait été posé auparavant : <Soit le système "
            .. nom .. ">{ ... }", 0)
        end
        local pas = " steps:on"
        out[#out + 1] = "<solve" .. pas .. ">{"
        for _, eq in ipairs(sysdef) do out[#out + 1] = eq end
        out[#out + 1] = "}"

      elseif line:match("^%s*<Calcule%s+les%s+%d+%s+premiers%s+termes%s+de%f[%s]") then
        local k, nom = line:match("^%s*<Calcule%s+les%s+(%d+)%s+premiers%s+termes%s+de%s+([%a][%w_]*)%s*>%s*$")
        if k then
          out[#out + 1] = "<seqterms nom:" .. nom .. " n:" .. k .. ">"
        else
          out[#out + 1] = translate_line(line)
        end

      elseif line:match("^%s*<second degré%f[%s>].->%s*{%s*$")
          or line:match("^%s*<loi de probabilité%f[%s].->%s*{%s*$")
          or line:match("^%s*<suite%f[%s].->%s*{%s*$")
          or line:match("^%s*<table de Cayley%f[%s].->%s*{%s*$") then
        local head = line:match("^%s*<(.-)>%s*{%s*$")
        out[#out + 1] = "<" .. translate_tag_head(head) .. ">{"
        mode = "operation"
        acc = { depth = 1 }

      elseif line:match("^%s*<opération%f[%s>].->%s*{%s*$") then
        local head = line:match("^%s*<(.-)>%s*{%s*$")
        out[#out + 1] = "<" .. translate_tag_head(head) .. ">{"
        mode = "operation"
        acc = { depth = 1 }

      elseif line:match("^%s*<arbre%f[%s>].->%s*{%s*$") then
        local head = line:match("^%s*<(.-)>%s*{%s*$")
        out[#out + 1] = "<" .. translate_tag_head(head) .. ">{"
        mode = "arbre"
        acc = { depth = 1 }

      elseif line:match("^%s*soit%s+[%a_][%w_]*%s*=%s*{%s*$") then
        out[#out + 1] = translate_control(line)
        mode = "soittable"
        acc = { depth = 1 }

      elseif line:match("^%s*<grille%f[%s>].->%s*{%s*$") then
        local head = line:match("^%s*<(.-)>%s*{%s*$")
        out[#out + 1] = "<" .. translate_tag_head(head) .. ">{"
        mode = "grille"
        acc = { depth = 1 }

      elseif line:match("^%s*<tableau%f[%s>].->%s*{%s*$") then
        local head = line:match("^%s*<(.-)>%s*{%s*$")
        out[#out + 1] = "<" .. translate_tag_head(head) .. ">{"
        mode = "tableau"
        acc = { depth = 1, lignes = {} }
      else
        out[#out + 1] = translate_line(line)
      end

    elseif mode == "matrice" then
      if line:match("^%s*}%s*$") then
        out[#out + 1] = line
        L._mats = L._mats or {}
        L._mats[acc.nom] = acc.rows
        acc = nil
        mode = "normal"
      else
        local r = num_fr(line)
        acc.rows[#acc.rows + 1] = trim(r)
        out[#out + 1] = r
      end

    elseif mode == "collegetab" then
      if line:match("^%s*}%s*$") then
        out[#out + 1] = line
        mode = "normal"
      else
        out[#out + 1] = num_fr(line)
      end

    elseif mode == "graphe" then
      if line:match("^%s*}%s*$") then
        out[#out + 1] = line
        L._graphes = L._graphes or {}
        L._graphes[acc.nom] = acc.rows
        acc = nil
        mode = "normal"
      else
        if line:match("%S") then acc.rows[#acc.rows + 1] = trim(line) end
        out[#out + 1] = line
      end

    elseif mode == "systeme" then
      if line:match("^%s*}%s*$") then
        out[#out + 1] = line
        L._sys = L._sys or {}
        L._sys[acc.nom] = acc.eqs
        acc = nil
        mode = "normal"
      else
        local eq = num_fr(line)
        acc.eqs[#acc.eqs + 1] = eq
        out[#out + 1] = eq
      end

    elseif mode == "soittable" then
      local d = delta_braces(line)
      if acc.depth + d <= 0 and line:match("^%s*}%s*$") then
        out[#out + 1] = line
        mode, acc = "normal", nil
      else
        acc.depth = acc.depth + d
        local ind, cle, val = line:match(
          "^(%s*)([%wÀ-ÿ_]+)%s*[:=]%s*(-?[%d,%.]+)%s*,?%s*$")
        if cle then
          out[#out + 1] = ind .. "[\"" .. cle .. "\"] = "
            .. num_fr(val) .. ","
        else
          out[#out + 1] = num_fr(line)
        end
      end

    elseif mode == "grille" then
      local d = delta_braces(line)
      if acc.depth + d <= 0 and line:match("^%s*}%s*$") then
        out[#out + 1] = line
        mode, acc = "normal", nil
      else
        acc.depth = acc.depth + d
        local zind, zin, zrest = line:match("^(%s*)%[(.-)%](%s*{.*)$")
        if zin then
          out[#out + 1] = zind .. "<area " .. traduire_zone(zin) .. ">"
            .. translate_line(zrest)
        else
          out[#out + 1] = translate_line(line)
        end
      end

    elseif mode == "operation" then
      local d = delta_braces(line)
      if acc.depth + d <= 0 and line:match("^%s*}%s*$") then
        out[#out + 1] = line
        mode, acc = "normal", nil
      else
        acc.depth = acc.depth + d
        out[#out + 1] = line
      end

    elseif mode == "arbre" then
      local d = delta_braces(line)
      if acc.depth + d <= 0 and line:match("^%s*}%s*$") then
        out[#out + 1] = line
        mode, acc = "normal", nil
      else
        acc.depth = acc.depth + d
        out[#out + 1] = num_fr(line)
      end

    elseif mode == "tableau" then
      local d = delta_braces(line)
      if acc.depth + d <= 0 and line:match("^%s*}%s*$") then
        for _, l in ipairs(tbl_rendre(acc.lignes)) do out[#out + 1] = l end
        out[#out + 1] = line
        mode, acc = "normal", nil
      else
        acc.depth = acc.depth + d
        local ctrl = translate_control(line)
        if ctrl then
          acc.lignes[#acc.lignes + 1] = { ctrl = ctrl }
          if line:match("{%s*$") then acc.ctrl = (acc.ctrl or 0) + 1 end
        elseif line:match("^%s*}%s*$") then
          acc.lignes[#acc.lignes + 1] = { ctrl = line }
          if (acc.ctrl or 0) > 0 then acc.ctrl = acc.ctrl - 1 end
        else
          local depouille = line
          for _ = 1, (acc.ctrl or 0) do
            depouille = depouille:gsub("^\t", "", 1)
          end
          acc.lignes[#acc.lignes + 1] = { brut = depouille }
        end
      end

    elseif mode == "soit" then
      if line:match("^%s*}%s*$") then
        mode = "normal"
      else
        local decl = trim(line)
        if decl ~= "" then
          local t = P.translate_soit_decl(decl)
          out[#out + 1] = "<tab>" .. t.display
          inscrire_fns(out, t)
          if t.points then
            L._points = L._points or {}
            for _, pt in ipairs(t.points) do L._points[pt.nom] = pt.co end
          end
          if t.suite then
            L._suites = L._suites or {}
            L._suites[t.suite.nom] = t.suite
            out[#out + 1] = "<sequence " .. t.suite.nom .. ">{"
            out[#out + 1] = t.suite.nom .. "(0) = " .. t.suite.u0
            out[#out + 1] = t.suite.nom .. "(n+1) = " .. t.suite.rec
            out[#out + 1] = "}"
          end
        end
      end

    elseif mode == "trace" then
      local repere_consomme = false
      if not frame and #acc == 0
         and line:match("^%s*un%s+repère%f[%s>]") then
        local t = P.translate_trace_phrase(trim(line))
        if t.kind == "frame" then frame = t; repere_consomme = true end
      end
      if repere_consomme then
      elseif line:match("^%s*}%s*$") then
        local head
        if frame then
          local extra = {}
          for _, w in ipairs(frame.opts or {}) do
            if w:match("^unit[xy]:") then extra[#extra + 1] = w end
          end
          head = "<draw axes:{" .. (frame.x or "{-5, 5}"):gsub("[{}]", "")
               .. ", " .. (frame.y or "{-5, 5}"):gsub("[{}]", "") .. "}"
               .. (#extra > 0 and (" " .. table.concat(extra, " ")) or "")
               .. ">"
        else
          head = "<draw>"
        end
        out[#out + 1] = head .. "{"
        if frame and L._points then
          local corps = table.concat(acc, "\n")
          local noms = {}
          for n in pairs(L._points) do noms[#noms + 1] = n end
          table.sort(noms)
          for _, n in ipairs(noms) do
            if corps:find("%f[%u]" .. n .. "%f[^%w]")
               and not corps:find("point%s+" .. n .. "%f[^%w]") then
              out[#out + 1] = "\tpoint " .. n .. " " .. L._points[n]
            end
          end
        end
        for _, l in ipairs(acc) do out[#out + 1] = "\t" .. l end
        out[#out + 1] = "}"
        mode, acc, frame = "normal", nil, nil
      else
        local phrase = trim(line)
        if phrase ~= "" then
          local t = P.translate_trace_phrase(phrase,
                      { frame = frame ~= nil, block = true })
          if t.kind == "draw_multi" then
            for _, l in ipairs(t.lines) do acc[#acc + 1] = l end
          else
            acc[#acc + 1] = t.line
          end
        end
      end
    end
  end

  return table.concat(out, "\n")
end

return L
