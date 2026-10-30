local V = require("texecole-vocab")

local P = {}

local function trim(s) return (s:gsub("^%s+", ""):gsub("%s+$", "")) end

local function num_fr(s) return (s:gsub("(%d),(%d)", "%1.%2")) end

local function coords_fr(s)
  s = num_fr(s)
  return (s:gsub("%s*;%s*", ","))
end

local function split_fragments(s)
  local frags, buf, depth = {}, {}, 0
  local i, n = 1, #s
  while i <= n do
    local c = s:sub(i, i)
    if c == "{" or c == "(" or c == "[" then depth = depth + 1
    elseif c == "}" or c == ")" or c == "]" then depth = depth - 1
    end
    if depth == 0 and c == "," and s:sub(i + 1, i + 1) == " " then
      frags[#frags + 1] = trim(table.concat(buf)); buf = {}
      i = i + 2
    else
      buf[#buf + 1] = c
      i = i + 1
    end
  end
  if #buf > 0 then frags[#frags + 1] = trim(table.concat(buf)) end
  return frags
end

local function split_et(frag)
  local parts, buf, depth = {}, {}, 0
  for word in frag:gmatch("%S+") do
    if word:find("[{(]") then depth = depth + 1 end
    if word:find("[})]") then depth = depth - 1 end
    if depth == 0 and word == "et" then
      parts[#parts + 1] = trim(table.concat(buf, " ")); buf = {}
    else
      buf[#buf + 1] = word
    end
  end
  if #buf > 0 then parts[#parts + 1] = trim(table.concat(buf, " ")) end
  return parts
end

local function err(msg)
  error("texecole : " .. msg, 0)
end

local SPECIES = {
  ["triangle"]        = "triangle",
  ["carré"]           = "square",
  ["rectangle"]       = "rectangle",
  ["losange"]         = "rhombus",
  ["trapèze"]         = "trapezoid",
  ["parallélogramme"] = "parallelogram",
  ["pentagone"]       = "pentagon",
  ["hexagone"]        = "hexagon",
  ["octogone"]        = "octagon",
  ["polygone"]        = "polygon",
  ["cerf-volant"]     = "kite",
  ["cercle"]          = "circle",
  ["disque"]          = "circle",
  ["point"]           = "point",
  ["vecteur"]         = "vector",
  ["région"]          = "region",
  ["tangente"]        = "tangent",
}

local POLYGON_BY_N = {
  [5] = "pentagon", [6] = "hexagon", [7] = "heptagon", [8] = "octagon",
}

local SOLIDS = {
  ["cube"] = "cube", ["pavé"] = "cuboid", ["pyramide"] = "pyramid",
  ["cylindre"] = "cylinder", ["cône"] = "cone", ["sphère"] = "sphere",
}

local function key_fr(key)
  local FR = { side = "côté", radius = "rayon", diameter = "diamètre",
               base = "base", height = "hauteur", edge = "arête",
               scale = "coefficient" }
  return FR[key] or key
end

local function len_attr(key)
  return function(rest, out, ctx)
    local seg, val, unit = rest:match("^(%u%u)%s+([%d,%.]+)%s*(c?m?m?)$")
    if seg and key == "side" then
      if unit == "" and not (ctx and ctx.frame) then
        err("longueur sans unité : « " .. rest .. " ». Écrivez par exemple "
          .. "« " .. seg .. " " .. val .. " cm » — l'unité (cm ou mm) est "
          .. "obligatoire hors d'un repère.")
      end
      out[#out + 1] = seg .. ":" .. num_fr(val)
      if unit ~= "" then out.measures = unit end
      return true
    end
    local segonly = rest:match("^(%u%u)$")
    if segonly then out[#out + 1] = key .. ":" .. segonly; return true end
    local v, u = rest:match("^([%d,%.]+)%s*(c?m?m?)$")
    if v then
      if u == "" and not (ctx and ctx.frame) then
        err("longueur sans unité : « de " .. key_fr(key) .. " " .. v
          .. " ». Écrivez « de " .. key_fr(key) .. " " .. v .. " cm » ou « "
          .. v .. " mm » — l'unité est obligatoire hors d'un repère, où "
          .. "seules les graduations dispensent d'unité.")
      end
      out[#out + 1] = key .. ":" .. num_fr(v)
      if u ~= "" then out.measures = u end
      return true
    end
    return false
  end
end

local DE_ATTRS = {
  { pref = "de côté",     f = len_attr("side")     },
  { pref = "de rayon",    f = len_attr("radius")   },
  { pref = "de diamètre", f = len_attr("diameter") },
  { pref = "de base",     f = len_attr("base")     },
  { pref = "de hauteur",  f = len_attr("height")   },
  { pref = "d'arête",     f = len_attr("edge")     },
  { pref = "d'angle",     f = function(rest, out)
      local v = rest:match("^([%d,%.]+)$")
      if v then out[#out + 1] = "angle:" .. num_fr(v); return true end
      return false
    end },
  { pref = "de coefficient", f = len_attr("scale") },
  { pref = "de centre",   f = function(rest, out)
      local co = rest:match("^(%b())$")
      if co then out[#out + 1] = "center:" .. coords_fr(co); return true end
      local nm = rest:match("^(%u[%w]*)$")
      if nm then out[#out + 1] = "center:" .. nm; return true end
      return false
    end },
  { pref = "d'intervalle", f = function(rest, out)
      local b = rest:match("^(%b{})$")
      if b then out[#out + 1] = "set:" .. num_fr(b); return true end
      return false
    end },
  { pref = "de points",   f = function(rest, out)
      local b = rest:match("^(%b{})$")
      if b then out[#out + 1] = "points:" .. num_fr(b:gsub("%s*;%s*", ", ")); return true end
      return false
    end },
  { pref = "de trait",    f = function(rest, out)
      local v = rest:match("^([%d,%.]+)%s*mm$")
      if v then out[#out + 1] = "thickness:" .. num_fr(v); return true end
      if rest:match("^[%d,%.]+$") then
        err("l'épaisseur du trait s'écrit avec son unité, en millimètres : "
          .. "« de trait " .. rest .. " mm » — l'unité est obligatoire, "
          .. "comme pour toute mesure (règle des unités).")
      end
      return false
    end },
}

local AVEC_SANS = {
  ["marques"]      = "marks",
  ["valeurs"]      = "values",
  ["labels"]       = "labels",
  ["mesures"]      = "measures",
  ["ajustement"]   = "fit",
  ["produits"]     = "products",
}

local function sans_article(w)
  return w:match("^les%s+(.+)$") or w:match("^le%s+(.+)$")
      or w:match("^la%s+(.+)$")  or w:match("^l'%s*(.+)$") or w
end

function P.parse_bounds(frag)
  local function intervalle(s)
    return s:match("%[%s*([%-%d,%.]+)%s*;%s*([%-%d,%.]+)%s*%]")
  end

  local xzone = frag:match("^pour%s+x%s+appartient%s+à%s*(%b[])")
             or frag:match("^pour%s+x%s+dans%s*(%b[])")
             or frag:match("^pour%s+x%s+à%s*(%b[])")
  if xzone then
    local ax, bx = intervalle(xzone)
    local reste = frag:match("et%s+y%s+appartient%s+à%s*(%b[])")
               or frag:match("et%s+y%s+dans%s*(%b[])")
               or frag:match("et%s+y%s+à%s*(%b[])")
    local ay, by
    if reste then ay, by = intervalle(reste) end
    return num_fr(ax), num_fr(bx), ay and num_fr(ay), by and num_fr(by)
  end

  local sa, sb = frag:match("^sur%s*%[%s*([%-%d,%.]+)%s*;%s*([%-%d,%.]+)%s*%]$")
  if sa then return num_fr(sa), num_fr(sb), nil, nil end
  local oa, ob = frag:match("^en%s+ordonnée%s*%[%s*([%-%d,%.]+)%s*;%s*([%-%d,%.]+)%s*%]$")
  if oa then return nil, nil, num_fr(oa), num_fr(ob) end
  return nil
end

local function unite_en_cm(val, unit)
  local n = tonumber(num_fr(val))
  if not n then return nil end
  if unit == "mm" then n = n / 10 end
  return (string.format("%.4f", n):gsub("0+$", ""):gsub("%.$", ""))
end

local function translate_fragment(frag, out, ctx)
  local x1, x2, y1, y2 = P.parse_bounds(frag)
  if x1 or y1 then
    if x1 then out.x = "{" .. x1 .. ", " .. x2 .. "}" end
    if y1 then out.y = "{" .. y1 .. ", " .. y2 .. "}" end
    return true
  end

  do
    local uv, uu = frag:match("^avec%s+une%s+unité%s+de%s+([%d,%.]+)%s*([cm]m)$")
    if uv then
      local u = unite_en_cm(uv, uu)
      out.unitx, out.unity = u, u
      out[#out + 1] = "unitx:" .. u
      out[#out + 1] = "unity:" .. u
      return true
    end
    local xv, xu, yv, yu = frag:match(
      "^avec%s+des%s+unités%s+respectives%s+de%s+([%d,%.]+)%s*([cm]m)%s+et%s+([%d,%.]+)%s*([cm]m)$")
    if not xv then
      xv, xu, yv, yu = frag:match(
        "^avec%s+des%s+unités%s+respectives%s+de%s+([%d,%.]+)%s*([cm]m)%s+et%s+de%s+([%d,%.]+)%s*([cm]m)$")
    end
    if not xv then

      xv, xu, yv, yu = frag:match(
        "^avec%s+des%s+unités%s+graphiques%s+de%s+([%d,%.]+)%s*([cm]m)%s+"
        .. "pour%s+l'axe%s+des%s+abscisses%s+et%s+de%s+([%d,%.]+)%s*([cm]m)%s+"
        .. "pour%s+l'axe%s+des%s+ordonnées$")
    end
    if not xv then

      local ya, yau, xa2, xau = frag:match(
        "^avec%s+des%s+unités%s+graphiques%s+de%s+([%d,%.]+)%s*([cm]m)%s+"
        .. "pour%s+l'axe%s+des%s+ordonnées%s+et%s+de%s+([%d,%.]+)%s*([cm]m)%s+"
        .. "pour%s+l'axe%s+des%s+abscisses$")
      if ya then xv, xu, yv, yu = xa2, xau, ya, yau end
    end
    if xv then
      out.unitx = unite_en_cm(xv, xu)
      out.unity = unite_en_cm(yv, yu)
      out[#out + 1] = "unitx:" .. out.unitx
      out[#out + 1] = "unity:" .. out.unity
      return true
    end
    if frag:match("^avec%s+une%s+unité")
       or frag:match("^avec%s+des%s+unités") then
      err("unité du repère illisible : « " .. frag .. " ». Trois formes : "
        .. "« avec une unité de 1,5 cm » (la même sur les deux axes), "
        .. "« avec des unités respectives de 2 cm et 0,5 cm », ou la "
        .. "forme académique « avec des unités graphiques de 2 cm pour "
        .. "l'axe des abscisses et de 0,5 cm pour l'axe des ordonnées ». "
        .. "L'unité (cm ou mm) est obligatoire sur chaque valeur.")
    end
  end

  local fa, fb = frag:match("^avec%s+l'aire%s+entre%s+([%-%d,%.]+)%s+et%s+([%-%d,%.]+)$")
  if fa then
    out[#out + 1] = "area:{" .. num_fr(fa) .. ", " .. num_fr(fb) .. "}"
    return true
  end

  for _, atom0 in ipairs(split_et(frag)) do
    local kvtail = {}
    local atom = atom0
    while true do
      local pre, kv = atom:match("^(.-)%s+([%wéèê_]+:%S+)%s*$")
      if not kv then break end
      table.insert(kvtail, 1, kv)
      atom = trim(pre)
    end
    if atom == "" and #kvtail > 0 then
      atom = table.remove(kvtail, 1)
    end
    for _, kv in ipairs(kvtail) do
      local k, v = kv:match("^([%wéèê_]+):(.+)$")
      if k == "unité" or k == "unite" then
        err("le réglage « unité: » n'existe plus : l'unité du repère se "
          .. "dit en prose — « avec une unité de 1 cm », ou « avec des "
          .. "unités respectives de 2 cm et 0,5 cm » (abscisses puis "
          .. "ordonnées).")
      end
      v = v:gsub("^%$(.-)%$$", "{%1}")
      out[#out + 1] = (V.KV_KEYS[k] or k) .. ":" .. num_fr(v)
    end

    local done = false

    local a = atom:match("^avec%s+(.+)$")
    local s = atom:match("^sans%s+(.+)$")
    if a and AVEC_SANS[sans_article(a)] then
      out[#out + 1] = AVEC_SANS[sans_article(a)] .. ":on";  done = true
    elseif s and AVEC_SANS[sans_article(s)] then
      out[#out + 1] = AVEC_SANS[sans_article(s)] .. ":off"; done = true
    end

    if not done then
      local ech = atom:match("^avec%s+(%d+)%s+échantillons?$")
      if ech then
        out[#out + 1] = "samples:" .. ech
        done = true
      end
    end

    if not done then
      local aa, ab = atom:match("^avec%s+l'aire%s+entre%s+([%-%d,%.]+)%s+et%s+([%-%d,%.]+)$")
      if aa then
        out[#out + 1] = "area:{" .. num_fr(aa) .. ", " .. num_fr(ab) .. "}"
        done = true
      end
    end

    if not done then
      local g = atom:match("^avec%s+l'aire%s+jusqu'à%s+([%a_][%w_]*)$")
      if g then
        out[#out + 1] = "between:" .. g
        done = true
      end
    end

    if not done then

      local u0, n = atom:match(
        "^avec%s+le%s+diagramme%s+en%s+escalier%s+depuis%s+([%-%d,%.]+)"
        .. "%s+sur%s+(%d+)%s+termes?$")
      if not u0 then
        u0 = atom:match(
          "^avec%s+le%s+diagramme%s+en%s+escalier%s+depuis%s+([%-%d,%.]+)$")
      end
      if u0 then
        out[#out + 1] = "cobweb:{" .. num_fr(u0)
          .. (n and (", " .. n) or "") .. "}"
        done = true
      end
    end

    if not done then
      local c = atom:match("^en%s+(.+)$")
      if c then
        local svg = V.color(c)
        if not svg then
          err("couleur inconnue : « " .. c .. " ». Les 147 noms français "
            .. "sont listés dans la référence des couleurs du manuel.")
        end
        out[#out + 1] = "color:" .. svg
        done = true
      end
    end

    if not done and atom == "rempli" then
      out[#out + 1] = "fill:on"; done = true
    end

    if not done then
      for _, rule in ipairs(DE_ATTRS) do
        local rest = atom:match("^" .. rule.pref:gsub("[%-']", "%%%0")
                                       .. "%s+(.+)$")
        if rest and rule.f(trim(rest), out, ctx) then done = true; break end
      end
    end

    if not done then
      local pasde = atom:match("^un%s+pas%s+de%s+(.+)$")
                 or atom:match("^pas%s+de%s+(.+)$")
      if pasde then
        pasde = trim(pasde)
        local m = pasde:match("^%$(.-)%$$")
        if m then
          out[#out + 1] = "step:{" .. m .. "}"
        else
          out[#out + 1] = "step:" .. num_fr(pasde)
        end
        done = true
      end

      local mesure = atom:match("^de%s+mesure%s+(.+)$")
      if mesure then
        out[#out + 1] = "label:{" .. num_fr(trim(mesure)) .. "}"
        done = true
      end

      local k, v = atom:match("^([%wéè_]+):(.+)$")
      if k == "unité" or k == "unite" then
        err("le réglage « unité: » n'existe plus : l'unité du repère se "
          .. "dit en prose — « avec une unité de 1 cm », ou « avec des "
          .. "unités respectives de 2 cm et 0,5 cm » (abscisses puis "
          .. "ordonnées).")
      end
      if k then
        local ek = V.KV_KEYS[k] or k
        v = v:gsub("^%$(.-)%$$", "{%1}")
        out[#out + 1] = ek .. ":" .. num_fr(v)
        done = true
      end
    end

    if not done and atom ~= "" then
      err("attribut non reconnu dans la phrase : « " .. atom .. " ». "
        .. "Attendu : « de côté N », « de rayon N », « en <couleur> », "
        .. "« avec/sans ... », « avec N échantillons », « avec l'aire "
        .. "entre a et b », « avec le diagramme en escalier depuis U0 "
        .. "sur N termes », ou un réglage clé:valeur.")
    end
  end
  return true
end

local function parse_head(head)

  head = head:match("^dans%s+(.+)$") or head
  local rest = head:match("^le%s+(.+)$")  or head:match("^la%s+(.+)$")
            or head:match("^l'%s*(.+)$")  or head:match("^un%s+(.+)$")
            or head:match("^une%s+(.+)$") or head
  rest = trim(rest)

  local seg1, seg2 = rest:match("^médiatrice%s+d.-%[%s*(%u)%s*,?%s*(%u)%s*%]")
  if seg1 then return "__prim perpbisector " .. seg1 .. " " .. seg2, "", "" end
  local b1, b2, b3 = rest:match("^bissectrice%s+de%s+l'angle%s+(%u)(%u)(%u)%s*$")
  if b1 then return "__prim anglebisector " .. b1 .. " " .. b2 .. " " .. b3, "", "" end
  local g1, g2, g3 = rest:match("^angle%s+(%u)(%u)(%u)%s*$")
  if g1 then return "__prim anglemark " .. g1 .. " " .. g2 .. " " .. g3, "", "" end
  local o1, e1, o2, e2 = rest:match("^angle%s+orienté%s+%((%u)(%u)%s*;%s*(%u)(%u)%)%s*$")
  if o1 then
    if o1 ~= o2 then
      err("l'angle orienté (" .. o1 .. e1 .. ";" .. o2 .. e2
        .. ") demande deux demi-droites de même origine ("
        .. o1 .. " et " .. o2 .. " diffèrent).")
    end
    return "__prim anglemark " .. e1 .. " " .. o1 .. " " .. e2
        .. " oriented:on", "", ""
  end
  local p1, q1, p2, q2 = rest:match("^angle%s+entre%s+(%u)(%u)%s+et%s+(%u)(%u)%s*$")
  if p1 then
    if p1 ~= p2 then
      err("l'angle entre " .. p1 .. q1 .. " et " .. p2 .. q2
        .. " demande deux demi-droites de même origine ("
        .. p1 .. " et " .. p2 .. " diffèrent).")
    end
    return "__prim anglemark " .. q1 .. " " .. p1 .. " " .. q2, "", ""
  end
  local vn1, vn2 = rest:match("^angle%s+entre%s+le%s+vecteur%s+([%a_][%w_]*)%s+et%s+le%s+vecteur%s+([%a_][%w_]*)%s*$")
  if vn1 then
    return "__prim vecangle " .. vn1 .. " " .. vn2, "", ""
  end

  local vnm, vco = rest:match("^vecteur%s+([%a_][%w_]*)%s*(%b())%s*$")
  if vnm then
    return "__prim vector " .. vnm .. " " .. coords_fr(vco), "", ""
  end

  local vrn, vrdep = rest:match("^vecteur%s+([%a_][%w_]*)%s+depuis%s+(.+)$")
  if vrn then
    local ptname = trim(vrdep):match("^(%u[%w]*)$")
    local coordexpr = trim(vrdep):match("^(%b())$")
    local tipname = trim(vrdep):match("^[Ll]a%s+pointe%s+de%s+([%a_][%w_]*)$")
      or trim(vrdep):match("^[Ll]e%s+bout%s+de%s+([%a_][%w_]*)$")
    local fromtok
    if ptname then fromtok = ptname
    elseif coordexpr then fromtok = coords_fr(coordexpr)
    elseif tipname then fromtok = "~" .. tipname
    else
      err("« depuis » attend un point déjà placé (depuis A), des "
        .. "coordonnées (depuis (1 ; 3)), ou la pointe d'un vecteur "
        .. "(depuis la pointe de v) — illisible : « " .. vrdep .. " ».")
    end
    return "__prim vector " .. vrn .. " from:" .. fromtok, "", ""
  end

  local vsn, va1, vop, va2, vtail = rest:match(
    "^vecteur%s+([%a_][%w_]*)%s*=%s*([%a_][%w_]*)%s*([%+%-])%s*([%a_][%w_]*)%s*(.-)$")
  if vsn then
    local dep = trim(vtail):match("^depuis%s+(.+)$")
    local fromtok
    if dep then
      local ptname = dep:match("^(%u[%w]*)$")
      local coordexpr = dep:match("^(%b())$")
      local tipname = dep:match("^[Ll]a%s+pointe%s+de%s+([%a_][%w_]*)$")
        or dep:match("^[Ll]e%s+bout%s+de%s+([%a_][%w_]*)$")
      if ptname then fromtok = ptname
      elseif coordexpr then fromtok = coords_fr(coordexpr)
      elseif tipname then fromtok = "~" .. tipname
      else
        err("« depuis » attend un point déjà placé (depuis A), des "
          .. "coordonnées (depuis (1 ; 3)), ou la pointe d'un vecteur "
          .. "(depuis la pointe de v) — illisible : « " .. dep .. " ».")
      end
    elseif trim(vtail) ~= "" then
      err("la somme ou la différence de deux vecteurs se dit « le vecteur w "
        .. "= u + v » ou « le vecteur w = u - v », suivi au besoin de "
        .. "« depuis ... » pour choisir son point de départ — illisible "
        .. "ici : « " .. vtail .. " ».")
    end
    local extra = fromtok and (" from:" .. fromtok) or ""
    return "__prim vector " .. vsn .. " = " .. va1 .. vop .. va2 .. extra, "", ""
  end

  local trig = rest:match("^cercle trigonométrique%s*(.*)$")
  if trig then return "trigcircle", "", trim(trig) end
  local repnat = rest:match("^repère%s+(.*)$")
  if repnat then
    local ortho
    if repnat:match("^orthonormé%s") or repnat == "orthonormé" then
      ortho = "orthonormé"
    elseif repnat:match("^orthogonal%s") or repnat == "orthogonal" then
      ortho = "orthogonal"
    end
    if ortho then
      repnat = trim(repnat:sub(#ortho + 1))
      P._frame_adj = ortho
    end

    local nomrep, apresnom = repnat:match("^(%([^%)]*%))%s*(.*)$")
    if nomrep then repnat = trim(apresnom) end
    if repnat == "" then return "__frame", "", "" end
    local xa, xb, reste = repnat:match(
      "^où%s+l'abscisse%s+x?%s*appartient%s+à%s*%[%s*(.-)%s*;%s*(.-)%s*%]%s*(.*)$")
    if not xa then
      xa, xb, reste = repnat:match(
        "^où%s+l'abscisse%s+appartient%s+à%s*%[%s*(.-)%s*;%s*(.-)%s*%]%s*(.*)$")
    end
    if not xa then

      xa, xb, reste = repnat:match(
        "^pour%s+x%s+appartient%s+à%s*%[%s*(.-)%s*;%s*(.-)%s*%]%s*(.*)$")
    end
    if xa then
      local ya, yb, apresy = reste:match(
        "^et%s+l'ordonnée%s+y?%s*appartient%s+à%s*%[%s*(.-)%s*;%s*(.-)%s*%]%s*(.*)$")
      if not ya then
        ya, yb, apresy = reste:match(
          "^et%s+l'ordonnée%s+y?%s*à%s*%[%s*(.-)%s*;%s*(.-)%s*%]%s*(.*)$")
      end
      if not ya then
        ya, yb, apresy = reste:match(
          "^et%s+y%s+appartient%s+à%s*%[%s*(.-)%s*;%s*(.-)%s*%]%s*(.*)$")
      end
      if not ya then
        ya, yb, apresy = reste:match(
          "^et%s+y%s+à%s*%[%s*(.-)%s*;%s*(.-)%s*%]%s*(.*)$")
      end
      if not ya then
        err("le repère se décrit : « un repère où l'abscisse appartient à "
          .. "[-5 ; 5] et l'ordonnée à [-5 ; 5] » ou « un repère pour x "
          .. "appartient à [-5 ; 5] et y à [-5 ; 5] » — l'ordonnée est "
          .. "illisible dans : « " .. reste .. " ».")
      end
      local head = "__framenat " .. num_fr(trim(xa)) .. " " .. num_fr(trim(xb))
          .. " " .. num_fr(trim(ya)) .. " " .. num_fr(trim(yb))
      return head, "", trim(apresy or "")
    end
    err("le repère se décrit en langage naturel : « un repère où "
      .. "l'abscisse appartient à [-5 ; 5] et l'ordonnée à [-5 ; 5] » "
      .. "ou « un repère (O, i, j) pour x appartient à [-5 ; 5] et y à "
      .. "[-5 ; 5] » (l'ancienne forme « de x -5 à 5 » n'existe plus).")
  end
  local rep = rest:match("^repère%s*$")
  if rep then return "__frame", "", "" end
  local ngrad = rest:match("^droite graduée%s*(.*)$")
  if ngrad then return "__numberline", "", trim(ngrad) end
  local fn = rest:match("^fonction%s+(.+)$")
  if fn then return "__function", "", trim(fn) end
  local solide = rest:match("^solide%s+(.+)$")
  if solide then
    local kind, srest = solide:match("^(%S+)%s*(.*)$")
    local ekind = SOLIDS[kind]
    if not ekind then
      err("solide inconnu : « " .. kind .. " » (attendu : cube, pavé, "
        .. "pyramide, cylindre, cône, sphère).")
    end
    return "__solid " .. ekind, srest:match("^(%u+)") or "",
           trim(srest:gsub("^%u+%s*", ""))
  end
  local dr = rest:match("^demi%-droite%s+(.+)$")
  if dr then return "__ray", "", trim(dr) end
  local seg = rest:match("^segment%s+de%s+droite%s+(.+)$")
             or rest:match("^segment%s+(.+)$")
  if seg then return "__segment", "", trim(seg) end
  local droite = rest:match("^droite%s+(.+)$")
  if droite then return "__line", "", trim(droite) end

  local kind, tail = rest:match("^(%S+)%s*(.*)$")
  local ekind = SPECIES[kind]
  if not ekind then return nil end
  local pts, quals = tail:match("^(%u[%u%d]*)%s*(.*)$")
  if not pts then pts, quals = "", tail end

  if kind == "polygone" then
    ekind = POLYGON_BY_N[#pts] or "polygon"
  end
  return ekind, pts, trim(quals or ""), (kind == "disque")
end

local function translate_quals(quals, out)
  if quals == "" then return end
  local at = quals:match("^rectangle%s+en%s+(%u)$")
  if at then out[#out + 1] = "right:" .. at; return end
  local Q = { ["équilatéral"] = "equilateral", ["isocèle"] = "isosceles",
              ["rectangle"] = "right" }
  for _, w in ipairs(split_et(quals)) do
    local q = Q[w]
    if q then out[#out + 1] = q .. ((q == "right") and "" or ":on")
    elseif w:match("^%b()$") then out.coords = coords_fr(w)
    else err("qualificatif inconnu : « " .. w .. " ».")
    end
  end
end

function P.translate_trace_phrase(phrase, ctx)
  phrase = trim(phrase)
  P._frame_adj = nil

  do
    local nb, suite = phrase:match("^(%d+)%s+fonctions%s+(.+)$")
    if not suite then suite = phrase:match("^[ld]es%s+fonctions%s+(.+)$") end
    if not suite then

      suite = phrase:match("^[ld]es%s+courbes%s+des%s+fonctions%s+(.+)$")
      if not suite then
        nb, suite = phrase:match("^(%d+)%s+courbes%s+des%s+fonctions%s+(.+)$")
      end
    end
    if suite then
      local RESERVES = { pour = true, sur = true, en = true, avec = true,
                         sans = true, et = true, dans = true, de = true }
      local noms, pos = {}, 1
      while true do
        local _, b, nom = suite:find("^%s*([%a][%w_]*)", pos)
        if not nom or RESERVES[nom] then break end
        noms[#noms + 1] = nom
        pos = b + 1
        local _, b2 = suite:find("^%s*,%s*", pos)
        if b2 then pos = b2 + 1
        else
          local _, b3 = suite:find("^%s+et%s+", pos)
          if b3 then pos = b3 + 1 else break end
        end
      end
      if #noms < 2 then
        err("le pluriel factorise : « les fonctions f, g et h pour x "
          .. "dans [-2 ; 2] et y dans [-3 ; 3] » — il faut au moins "
          .. "deux noms de fonctions, séparés par des virgules, « et » "
          .. "avant le dernier.")
      end
      if nb and tonumber(nb) ~= #noms then
        err("le compte n'y est pas : la phrase annonce " .. nb
          .. " fonctions mais en nomme " .. #noms .. ". Le nombre, "
          .. "comme l'article pluriel, factorise la déclaration : il "
          .. "doit correspondre au nombre de fonctions nommées.")
      end
      local out = {}
      local reste = trim(suite:sub(pos):gsub("^,%s*", ""))
      if reste ~= "" then
        for _, frag in ipairs(split_fragments(reste)) do
          frag = trim(frag)
          if frag ~= "" then translate_fragment(frag, out, ctx) end
        end
      end
      local words = { table.concat(noms, " ") }
      if out.x then words[#words + 1] = "x:" .. out.x end
      if out.y then words[#words + 1] = "y:" .. out.y end
      for _, w in ipairs(out) do words[#words + 1] = w end
      if ctx and ctx.block then
        local flines = {}
        for _, n in ipairs(noms) do flines[#flines + 1] = "function " .. n end
        return { kind = "draw_multi", lines = flines }
      end
      return { kind = "plot", line = table.concat(words, " ") }
    end
  end

  local sansart = phrase:match("^le%s+(.*)$") or phrase:match("^la%s+(.*)$")
               or phrase:match("^l'(.*)$")   or phrase:match("^un%s+(.*)$")
               or phrase:match("^une%s+(.*)$") or phrase
  local pn, pc = sansart:match("^point%s+(%u[%w]*)%s*(%b())")
  if pn then
    return { kind = "draw",
             line = "point " .. pn .. " " .. coords_fr(pc) }
  end
  local pn2 = sansart:match("^point%s+(%u[%w]*)%s*$")
  if pn2 then
    return { kind = "draw", line = "point " .. pn2, needs = pn2 }
  end

  local br = sansart:match("^droite%s+%((%u+)%)")
  if br then
    return { kind = "draw",
             line = "line through " .. br:sub(1,1) .. " " .. br:sub(2,2) }
  end

  local ffn = sansart:match("^fonction%s+([%a_][%w_]*)%s*$")
    or sansart:match("^courbe%s+de%s+la%s+fonction%s+([%a_][%w_]*)%s*$")
  if ffn then
    return { kind = "draw", line = "function " .. ffn }
  end

  local deq = sansart:match("^droite%s+d['’]équation%s+y%s*=%s*(.+)$")
  if deq then
    return { kind = "draw", line = "curve " .. num_fr(trim(deq)) }
  end

  local frags = split_fragments(phrase)
  local ekind, pts, quals, filled = parse_head(frags[1])
  if not ekind then
    err("figure non reconnue : « " .. frags[1] .. " ». Espèces connues : "
      .. "triangle, carré, rectangle, losange, cercle, disque, polygone, "
      .. "repère, fonction, point, droite, segment, solide, "
      .. "cercle trigonométrique, droite graduée.")
  end

  local out = {}
  if not ekind:match("^__") and ekind ~= "trigcircle" then
    translate_quals(quals, out)
  end
  if filled then out[#out + 1] = "fill:on" end
  for i = 2, #frags do translate_fragment(frags[i], out, ctx) end

  if ekind == "__function" then
    local fname = pts ~= "" and pts or quals:match("^(%S+)") or ""
    if fname == "" then fname = frags[1]:match("fonction%s+(%S+)") end
    local reste = quals:gsub("^%S+%s*", "")
    if reste ~= "" then translate_fragment(reste, out, ctx) end
    local words = { fname }
    if out.x then words[#words + 1] = "x:" .. out.x end
    if out.y then words[#words + 1] = "y:" .. out.y end
    for _, w in ipairs(out) do words[#words + 1] = w end
    return { kind = "plot", line = table.concat(words, " ") }
  end

  local fa, fb, fc, fd = ekind:match("^__framenat%s+(%S+)%s+(%S+)%s+(%S+)%s+(%S+)$")
  if fa or ekind == "__frame" then

    if quals and trim(quals) ~= "" then
      translate_fragment(trim(quals), out, ctx)
    end
    if P._frame_adj == "orthonormé" and out.unitx and out.unity
       and out.unitx ~= out.unity then
      err("un repère orthonormé porte la même unité sur les deux axes : "
        .. "« avec une unité de N cm ». Pour des unités distinctes, "
        .. "dites « un repère orthogonal, avec des unités respectives "
        .. "de ... et ... ».")
    end
  end
  if fa then
    return { kind = "frame", x = "{" .. fa .. ", " .. fb .. "}",
                             y = "{" .. fc .. ", " .. fd .. "}", opts = out }
  end

  if ekind == "__frame" then
    return { kind = "frame", x = out.x, y = out.y, opts = out }
  end

  if ekind == "__numberline" then
    if quals ~= "" then translate_fragment(quals, out, ctx) end
    local words = {}
    if out.x then words[#words + 1] = "x:" .. out.x end
    for _, w in ipairs(out) do
      w = w:gsub("^color:([%w]+)$", "color:{%1}")
      words[#words + 1] = w
    end
    return { kind = "numberline", line = table.concat(words, " ") }
  end

  if ekind == "__segment" or ekind == "__ray" or ekind == "__line" then
    local brut = trim((pts ~= "" and (pts .. " ") or "") .. (quals or ""))
    for _, w in ipairs(out) do brut = brut .. " " .. w end
    brut = trim(brut)
    local sep_o, A, B, sep_c = brut:match("^([%[%(])(%u)(%u)([%]%)])")
    if not A then
      err("la " .. (ekind == "__ray" and "demi-droite"
          or ekind == "__line" and "droite" or "segment")
        .. " se nomme par ses deux points, par exemple « [AB] » "
        .. "(segment), « (AB] » (demi-droite) ou « (AB) » (droite).")
    end
    if ekind == "__ray" then

      if sep_o == "(" then A, B = B, A end
    end
    local reste = brut:sub(5)
    local la, lval, lunit = reste:match(
      "tel%a*%s+que%s+(%u%u)%s*=%s*([%d,%.]+)%s*(c?m?m?)")
    local mode = (ekind == "__ray") and "ray"
              or (ekind == "__line") and "line" or "segment"
    local mots = { mode, A, B }
    if lval then
      if lunit == "" then
        err("la longueur d'une construction s'écrit avec son unité : "
          .. "« tel que " .. la .. " = " .. lval .. " cm » ou « "
          .. lval .. " mm » — l'unité (cm ou mm) est obligatoire.")
      end
      mots[#mots + 1] = "length:" .. num_fr(lval)
      mots[#mots + 1] = "measures:" .. lunit
    end
    for _, w in ipairs(out) do
      if w ~= A .. B then mots[#mots + 1] = w end
    end
    return { kind = "draw", line = table.concat(mots, " ") }
  end

  local head = ekind
  if ekind:match("^__solid%s") then head = ekind:gsub("^__", "") end
  if ekind:match("^__prim%s") and not ekind:match("^__framenat") then
    if not (ctx and (ctx.frame or ctx.block)) then
      err("la médiatrice, la bissectrice et la marque d'angle se tracent "
        .. "dans une figure : placez cette phrase à l'intérieur d'un bloc "
        .. "<Trace ...>{...} où les points concernés sont définis (sommets "
        .. "d'une figure tracée, ou points posés dans un repère).")
    end
    head = ekind:gsub("^__prim%s+", "")
  end
  local words = { head }
  if pts ~= "" then words[#words + 1] = pts end
  if out.coords then words[#words + 1] = out.coords end
  for _, w in ipairs(out) do words[#words + 1] = w end
  if out.measures then words[#words + 1] = "measures:" .. out.measures end
  return { kind = "draw", line = table.concat(words, " ") }
end

function P.translate_soit_decl(decl)
  decl = trim(decl)

  if decl:match("^une?%s+point.-%s+et%s+une?%s+point")
     or decl:match("^un%s+point%s+.-%s+et%s+un%s+point") then
    err("la règle de factorisation de texecole regroupe les points sous "
      .. "un seul article pluriel : écrivez « <Soit>les points A(2;3) et "
      .. "B(-1;4) » plutôt que « un point... et un point... ».")
  end

  if decl:match("^une%s+fonction%s+.-%s+et%s+une%s+fonction") then
    err("la règle de factorisation de texecole regroupe les fonctions "
      .. "sous un seul article pluriel : écrivez « <Soit>les fonctions "
      .. "f(x) = ... et g(x) = ... » plutôt que « une fonction... et "
      .. "une fonction... ».")
  end

  local cn, cd, cc, cdef = decl:match(
    "^un%s+champ%s+de%s+vecteurs%s+(%u[%w_]*)%s+de%s+(%S+)%s+dans%s+(%S+)%s+défini%s+par%s*:?%s*(.+)$")
  if cn then
    return { display = "un champ de vecteurs $" .. cn .. " : " .. cd
             .. " -> " .. cc .. "$ défini par $" .. num_fr(cdef) .. "$" }
  end

  local fdef = decl:match("^une%s+fonction%s+(.+)$")
  if fdef then
    return { display = "une fonction $" .. fdef .. "$",
             fn = num_fr(fdef) }
  end

  local fliste = decl:match("^les%s+fonctions%s+(.+)$")
    or decl:match("^des%s+fonctions%s+(.+)$")
  if fliste then
    local morceaux, buf, depth = {}, {}, 0
    local src = fliste:gsub("%s+et%s+", ", ")
    for i = 1, #src do
      local ch = src:sub(i, i)
      if ch == "(" then depth = depth + 1 end
      if ch == ")" then depth = depth - 1 end
      local decimale = ch == "," and src:sub(i - 1, i - 1):match("%d")
        and src:sub(i + 1, i + 1):match("%d")
      if ch == "," and depth == 0 and not decimale then
        morceaux[#morceaux + 1] = table.concat(buf); buf = {}
      else
        buf[#buf + 1] = ch
      end
    end
    if #buf > 0 then morceaux[#morceaux + 1] = table.concat(buf) end

    local fns, displays = {}, {}
    for _, morceau in ipairs(morceaux) do
      morceau = trim(morceau)
      if morceau ~= "" then
        if not morceau:match("^[%a_][%w_]*%s*%([%a_][%w_]*%)%s*=%s*%S") then
          err("fonction illisible dans la liste : « " .. morceau
            .. " » — attendu NOM(var) = expression, par exemple f(x) = x^2.")
        end
        fns[#fns + 1] = num_fr(morceau)
        displays[#displays + 1] = "$" .. morceau .. "$"
      end
    end
    if #fns == 0 then err("aucune fonction dans « " .. decl .. " ».") end
    local aff = table.concat(displays, ", ")
    if #displays > 1 then
      aff = table.concat(displays, ", ", 1, #displays - 1)
        .. " et " .. displays[#displays]
    end
    return { display = "les fonctions " .. aff, fns = fns }
  end

  local nm, co = decl:match("^un%s+point%s+(%u[%w]*)%s*(%b())$")
  if nm then
    return { display = decl,
             points = { { nom = nm, co = coords_fr(co) } } }
  end

  local nb, liste = decl:match("^(%d+)%s+points%s+(.+)$")
  if not liste then liste = decl:match("^[ld]es%s+points%s+(.+)$") end
  if liste then
    local pts = {}

    local noms_txt, coords_txt = liste:match(
      "^(.-)%s+de%s+coordonnées%s+respectives%s+(.+)$")
    if noms_txt then
      local noms = {}
      for nom in noms_txt:gsub("%s+et%s+", ", "):gmatch("[^,]+") do
        nom = trim(nom)
        if nom ~= "" then
          if not nom:match("^%u[%w]*$") then
            err("nom de point illisible dans la liste : « " .. nom
              .. " » — attendu une majuscule, par exemple A, B ou C1.")
          end
          noms[#noms + 1] = nom
        end
      end
      local coords = {}
      local reste = coords_txt:gsub("%s+et%s+", ", ")
      for co in reste:gmatch("%b()") do
        coords[#coords + 1] = coords_fr(co)
      end
      local hors = reste:gsub("%b()", ""):gsub("[,%s]", "")
      if hors ~= "" then
        err("coordonnées illisibles dans « " .. coords_txt .. " » — "
          .. "attendu des couples (x ; y) séparés par des virgules, "
          .. "« et » avant le dernier.")
      end
      if #noms == 0 or #coords == 0 then
        err("la forme distributive demande des noms puis des couples : "
          .. "« les points A, B et C de coordonnées respectives "
          .. "(1 ; 2), (-1 ; 2) et (-1 ; -2) ».")
      end
      if #noms ~= #coords then
        err("distribution respective boiteuse : " .. #noms .. " nom"
          .. (#noms > 1 and "s" or "") .. " de points pour " .. #coords
          .. " couple" .. (#coords > 1 and "s" or "") .. " de "
          .. "coordonnées — « respectives » exige autant de couples "
          .. "que de noms, dans le même ordre.")
      end
      for i = 1, #noms do
        pts[#pts + 1] = { nom = noms[i], co = coords[i] }
      end
    else
      local morceaux, buf, depth = {}, {}, 0
      local src = liste:gsub("%s+et%s+", ", ")
      for i = 1, #src do
        local ch = src:sub(i, i)
        if ch == "(" then depth = depth + 1 end
        if ch == ")" then depth = depth - 1 end
        if ch == "," and depth == 0 then
          morceaux[#morceaux + 1] = table.concat(buf); buf = {}
        else
          buf[#buf + 1] = ch
        end
      end
      if #buf > 0 then morceaux[#morceaux + 1] = table.concat(buf) end
      for _, morceau in ipairs(morceaux) do
        morceau = trim(morceau)
        if morceau ~= "" then
          local n2, c2 = morceau:match("^(%u[%w]*)%s*(%b())$")
          if not n2 then
            err("point illisible dans la liste : « " .. morceau
              .. " » — attendu NOM(x;y), par exemple A(-1,5;3).")
          end
          pts[#pts + 1] = { nom = n2, co = coords_fr(c2) }
        end
      end
    end

    if #pts == 0 then err("aucun point dans « " .. decl .. " ».") end
    if nb and tonumber(nb) ~= #pts then
      err("le compte n'y est pas : la phrase annonce " .. nb .. " points "
        .. "mais en décrit " .. #pts .. ". Le nombre, comme l'article "
        .. "pluriel, factorise la déclaration : il doit correspondre au "
        .. "nombre de points décrits.")
    end
    return { display = decl, points = pts }
  end

  do
    local vnm, vco = decl:match(
      "^le%s+vecteur%s+([%a][%w_]*)%s+de%s+coordonnées%s*(%b())%s*$")
    if vnm then
      local co = num_fr(vco)
      return { display = "le vecteur <vec " .. vnm .. " de coordonnées "
                 .. co .. ">",
               vecteurs = { { nom = vnm, co = co } } }
    end
    local liste = decl:match("^[ld]es%s+vecteurs%s+(.+)$")
    if liste then
      local noms_txt, coords_txt = liste:match(
        "^(.-)%s+de%s+coordonnées%s+respectives%s+(.+)$")
      if not noms_txt then
        err("déclaration de vecteurs illisible : « " .. decl .. " ». "
          .. "Attendu : « les vecteurs u et v de coordonnées respectives "
          .. "(1 ; 2) et (3 ; 4) » (article, règle n°10).")
      end
      local noms = {}
      for nom in noms_txt:gsub("%s+et%s+", ", "):gmatch("[^,]+") do
        nom = trim(nom)
        if nom ~= "" then noms[#noms + 1] = nom end
      end
      local coords = {}
      for co in coords_txt:gsub("%s+et%s+", ", "):gmatch("%b()") do
        coords[#coords + 1] = num_fr(co)
      end
      if #noms ~= #coords or #noms == 0 then
        err("distribution respective boiteuse : " .. #noms .. " nom"
          .. (#noms > 1 and "s" or "") .. " de vecteurs pour " .. #coords
          .. " jeu" .. (#coords > 1 and "x" or "") .. " de coordonnées.")
      end
      local vecteurs, aff = {}, {}
      for i = 1, #noms do
        vecteurs[#vecteurs + 1] = { nom = noms[i], co = coords[i] }
        aff[#aff + 1] = "<vec " .. noms[i] .. " de coordonnées "
          .. coords[i] .. ">"
      end
      local texte = table.concat(aff, ", ", 1, math.max(1, #aff - 1))
      if #aff > 1 then texte = texte .. " et " .. aff[#aff] end
      return { display = "les vecteurs " .. texte, vecteurs = vecteurs }
    end
    local pnm, peq = decl:match(
      "^le%s+plan%s+(%u[%w]*)%s+d'équation%s+(.+)$")
    if pnm then
      peq = num_fr(trim(peq):gsub("%.%s*$", ""))
      return { display = "le plan $" .. pnm .. "$ d'équation $" .. peq
                 .. "$", plan = { nom = pnm, eq = peq } }
    end
  end

  if decl:match("^la%s+suite%f[%s]") then
    local nom, reste = decl:match(
      "^la%s+suite%s+(%a[%w]*)%s*,%s*définie%s+par%s+(.+)$")
    if not nom then
      err("déclaration de suite illisible : « " .. decl .. " ». Attendu : "
        .. "« la suite u, définie par u(0) = ... et u(n+1) = ... » "
        .. "(article, règle n°10).")
    end
    reste = reste:gsub("%.%s*$", "")
    local u0 = reste:match("^" .. nom .. "%(0%)%s*=%s*(.-)%s+et%s+")
            or reste:match("^" .. nom .. "_0%s*=%s*(.-)%s+et%s+")
    local rec_clause = reste:match("%s+et%s+(.+)$")
    local rec
    if rec_clause then
      rec = rec_clause:match("^" .. nom .. "%(n%+1%)%s*=%s*(.+)$")
         or rec_clause:match("^" .. nom .. "_%(n%+1%)%s*=%s*(.+)$")
         or rec_clause:match("^" .. nom .. "_{n%+1}%s*=%s*(.+)$")
    end
    if not u0 or not rec then
      err("la suite « " .. nom .. " » doit donner un premier terme "
        .. nom .. "(0) = ... et une relation " .. nom
        .. "(n+1) = ... (article, règle n°10).")
    end
    u0 = num_fr(trim(u0))
    rec = num_fr(trim(rec)):gsub(nom .. "_n", nom .. "(n)")
    return {
      display = "la suite $(" .. nom .. "_n)$ définie par récurrence, "
        .. "avec $" .. nom .. "_0 = " .. u0 .. "$ et $" .. nom
        .. "_{n+1} = " .. rec:gsub(nom .. "%(n%)", nom .. "_n") .. "$",
      suite = { nom = nom, u0 = u0, rec = rec },
    }
  end

  err("déclaration non reconnue après <Soit> : « " .. decl .. " ». "
    .. "Attendu : « un point A(x;y) », « les points A(x;y), B(x;y)... », "
    .. "« 3 points A(x;y), B(x;y) et C(x;y) », « les points A, B et C "
    .. "de coordonnées respectives (x;y), (x;y) et (x;y) », "
    .. "« une fonction f(x) = ... », « les fonctions f(x) = ..., "
    .. "g(x) = ... et h(x) = ... » ou « la suite u, définie par "
    .. "u(0) = ... et u(n+1) = ... » (article, règle n°10).")
end

return P
