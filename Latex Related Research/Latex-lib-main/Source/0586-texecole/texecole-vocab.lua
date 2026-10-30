local V = {}

V.TAGS = {
  ["cadre"]                 = { name = "box" },
  ["tableau"]               = { name = "table" },
  ["grille"]                = { name = "grid" },
  ["image"]                 = { name = "img" },
  ["section"]               = { name = "section" },
  ["sous-section"]          = { name = "subsection" },
  ["sous-sous-section"]     = { name = "subsubsection" },
  ["table des matières"]    = { name = "tableofcontents" },
  ["matrice"]               = { name = "matrix" },
  ["matrice entre crochets"] = { name = "bmatrix" },
  ["système"]               = { name = "system" },
  ["tableau de variations"] = { name = "vartab" },
  ["tableau de signes"]     = { name = "signtab" },
  ["statistique"]           = { name = "stats" },
  ["arbre"]                 = { name = "tree" },
  ["liste"]                 = { name = "list" },
  ["rangée"]                = { name = "row" },
  ["opération"]             = { name = "posedop" },
  ["second degré"]          = { name = "quadratic" },
  ["loi de probabilité"]    = { name = "problaw", libre = true },
  ["suite"]                 = { name = "sequence", libre = true },
  ["vecteur"]               = { name = "vec", libre = true },
  ["table de Cayley"]       = { name = "cayley", libre = true },
  ["combinaisons"]          = { name = "combi", libre = true },
  ["arrangements"]          = { name = "arrang", libre = true },
  ["permutations"]          = { name = "permut", libre = true },
  ["triangle de Pascal"]    = { name = "pascal", libre = true },
  ["décomposition en facteurs premiers"] = { name = "primefac", libre = true },
  ["algorithme d'Euclide"]  = { name = "euclide", libre = true },
  ["complexe"]              = { name = "complexe", libre = true },
  ["congruence"]            = { name = "congru", libre = true },
  ["suite arithmétique"]    = { name = "suitearith", libre = true },
  ["suite géométrique"]     = { name = "suitegeo", libre = true },
}

V.VERBES_OBJET = { "Affiche", "Dresse", "Construis", "Insère", "Pose", "Étudie", "Écris", "Définis", "Dénombre", "Applique" }

V.LIST_STYLES = {
  ["sans puce"]                          = "none",
  ["à puces vides"]                      = "circle",
  ["à puces carrées"]                    = "square",
  ["à puces"]                            = "disc",
  ["numérotée"]                          = "decimal",
  ["alphabétique majuscule"]             = "ALPHA",
  ["alphabétique"]                       = "alpha",
  ["en chiffres romains majuscules"]     = "ROMAN",
  ["en chiffres romains"]                = "roman",
  ["à cocher"]                           = "check",
}

V.STYLE_WORDS = {
  ["gras"]  = "b",  ["g"] = "b",
  ["italique"] = "i",
  ["souligné"] = "u", ["s"] = "u",
  ["barré"] = "st",
  ["sans empattements"] = "sf", ["sans"] = "sf",
  ["petites capitales"] = "sc", ["capitales"] = "sc",
  ["note"] = "footnote",
  ["sous-section"] = "subsection",
  ["sous-sous-section"] = "subsubsection",
  ["table des matières"] = "tableofcontents",
  ["gauche"] = "l", ["centre"] = "c", ["droite"] = "r", ["justifie"] = "j",
  ["justifié"] = "j",
  ["à gauche"] = "l", ["au centre"] = "c", ["à droite"] = "r",
  ["ligne"] = "line",
  ["tabulation"] = "tab",
  ["page suivante"] = "nextpage",
  ["nouvelle ligne"] = "nextline",
  ["num"] = "num", ["roman"] = "roman", ["ROMAN"] = "ROMAN",
  ["alpha"] = "alpha", ["ALPHA"] = "ALPHA",
  ["romain"] = "roman", ["ROMAIN"] = "ROMAN", ["décimal"] = "num",
}

V.COUNTED_WORDS = {
  ["lignes"]      = "lines",
  ["ligne"]       = "lines",
  ["tabulations"] = "tab",
  ["tabulation"]  = "tab",
}

V.PLACE = {
  ["hg"] = "tl", ["hc"] = "tc", ["hd"] = "tr",
  ["mg"] = "ml", ["mc"] = "mc", ["md"] = "mr",
  ["bg"] = "bl", ["bc"] = "bc", ["bd"] = "br",
  ["haut gauche"]   = "tl", ["haut centre"]   = "tc", ["haut droite"]   = "tr",
  ["milieu gauche"] = "ml", ["milieu centre"] = "mc", ["milieu droite"] = "mr",
  ["bas gauche"]    = "bl", ["bas centre"]    = "bc", ["bas droite"]    = "br",
}

V.PROSE_ATTRS = {
  { pat = "titre en «C» sur fond «C»",    key = { "titletext", "titlefill" } },
  { pat = "entête en «C» sur fond «C»",   key = { "headertext", "headerfill" } },
  { pat = "un entête en «C» sur un fond «C»", key = { "headertext", "headerfill" } },
  { pat = "entête en «C»",                key = "headertext" },
  { pat = "titre en «C»",                 key = "titletext" },
  { pat = "une bordure «C»",              key = "line" },
  { pat = "un bord «C»",                  key = "line" },
  { pat = "un fond «C»",                  key = "fill" },
  { pat = "un texte «C»",                 key = "text" },
  { pat = "un titre «B»",                 key = "title" },
  { pat = "des coins arrondis de «N» mm", key = "radius" },
  { pat = "des coins arrondis de «N»mm",  key = "radius" },
  { pat = "un écart de «N» mm",           key = "gap" },
  { pat = "un écart de «N»mm",            key = "gap" },
  { pat = "une largeur de «N» mm",        key = "width",  unit = "mm" },
  { pat = "une hauteur de «N» mm",       key = "height", unit = "mm" },
  { pat = "un côté de «N» mm",            key = "side",   unit = "mm" },
  { pat = "une largeur de «N» %",         key = "widthpct" },
  { pat = "une largeur de «N»%",          key = "widthpct" },
  { pat = "fond «C»",                     key = "fill" },
  { pat = "texte «C»",                    key = "text" },
  { pat = "coins arrondis de «N» mm",     key = "radius" },
  { pat = "coins arrondis de «N»mm",      key = "radius" },
  { pat = "large de «N» mm",              key = "width",  unit = "mm" },
  { pat = "large de «N»mm",               key = "width",  unit = "mm" },
  { pat = "large de «N»«PCT»",            key = "width",  unit = "%"  },
  { pat = "bordure épaisse de «N» mm",    key = "rule" },
  { pat = "bordure épaisse de «N»mm",     key = "rule" },
  { pat = "marge de «N» mm",              key = "sep" },
  { pat = "marge de «N»mm",               key = "sep" },
  { pat = "titre «B»",                    key = "title" },
  { pat = "avec coupure de page",         key = "break", value = "yes" },
  { pat = "sans coupure de page",         key = "break", value = "no"  },
  { pat = "écart de «N» mm",              key = "gap" },
  { pat = "écart de «N»mm",               key = "gap" },
  { pat = "haut de «N» cm",               key = "height", unit = "cm" },
  { pat = "haut de «N»cm",                key = "height", unit = "cm" },
  { pat = "le résultat",                  key = "result", value = "on" },
  { pat = "résultat",                     key = "result", value = "on" },
  { pat = "bordures",                     key = "borders", bare = true },
  { pat = "entête",                       key = "header",  bare = true },
  { pat = "légendée «B»",                 key = "caption" },
  { pat = "légende «B»",                  key = "caption" },
  { pat = "dans le dossier «B»",           key = "dir" },
  { pat = "avec ajustement",              key = "fit",      value = "on" },
  { pat = "ajustement",                   key = "fit",      value = "on" },
  { pat = "avec les produits",            key = "products", value = "on" },
  { pat = "les produits",                 key = "products", value = "on" },
  { pat = "en disposition horizontale",   key = "horizontal", value = "on" },
  { pat = "les zones «BR»",               key = "template" },
  { pat = "les données «W»",              key = "data" },
  { pat = "données «W»",                  key = "data" },
  { pat = "«N» colonnes",                 key = "cols" },
  { pat = "«N» lignes",                   key = "rows" },
  { pat = "avec «N» échantillons",        key = "samples" },
  { pat = "les bornes «B»",               key = "bounds" },
  { pat = "de bornes «B»",                key = "bounds" },
  { pat = "les effectifs «B»",            key = "counts" },
  { pat = "d'effectifs «B»",              key = "counts" },
  { pat = "en «C»",                       key = "color" },
  { pat = "de trait «N»",                 key = "thickness" },
}

V.KV_KEYS = {
  ["dérivée"]    = "deriv",
  ["derivee"]    = "deriv",
  ["variations"] = "var",
  ["seconde"]    = "second",
  ["données"]      = "data",
  ["bornes"]       = "bounds",
  ["effectifs"]    = "counts",
  ["zones"]        = "template",
  ["colonnes"]     = "cols",
  ["lignes"]       = "rows",
  ["echantillons"] = "samples",
  ["échantillons"] = "samples",
  ["pas"]          = "step",
  ["aire"]         = "area",
  ["entre"]        = "between",
  ["intervalle"]   = "set",
  ["points"]       = "points",
  ["x"]            = "x",
}

V.STATS_KINDS = {
  ["barres"]              = "bars",
  ["histogramme"]         = "histogram",
  ["camembert"]           = "pie",
  ["boite a moustaches"]  = "boxplot",
  ["boîte à moustaches"]  = "boxplot",
  ["nuage"]               = "scatter",
}

V.LOIS = {
  ["normale"]   = "norm",
  ["binomiale"] = "binom",
  ["poisson"]   = "poisson",
  ["uniforme"]  = "uniform",
  ["exponentielle"] = "expon",
  ["student"]   = "t",
  ["khi-deux"]  = "chi2",
  ["khi deux"]  = "chi2",
}

V.DOMAINES = {
  ["RR"] = "Reals",   ["les réels"] = "Reals",     ["réels"] = "Reals",
  ["CC"] = "Complexes", ["les complexes"] = "Complexes", ["complexes"] = "Complexes",
  ["ZZ"] = "Integers", ["les entiers"] = "Integers", ["entiers"] = "Integers",
  ["NN"] = "Naturals", ["les naturels"] = "Naturals", ["naturels"] = "Naturals",
  ["QQ"] = "Rationals", ["les rationnels"] = "Rationals", ["rationnels"] = "Rationals",
}

V.COLORS = {
  ["noir"] = "Black", ["blanc"] = "White", ["gris"] = "Gray",
  ["gris clair"] = "LightGray", ["gris foncé"] = "DarkGray",
  ["gris perle"] = "Gainsboro", ["gris anthracite"] = "DarkSlateGray",
  ["gris souris"] = "SlateGray", ["gris souris clair"] = "LightSlateGray",
  ["gris souris foncé"] = "DimGray",
  ["blanc fumé"] = "WhiteSmoke", ["blanc antique"] = "AntiqueWhite",
  ["blanc ivoire"] = "Ivory", ["blanc navajo"] = "NavajoWhite",
  ["blanc fantôme"] = "GhostWhite", ["blanc neige"] = "Snow",
  ["blanc lin"] = "Linen", ["blanc coquillage"] = "Seashell",
  ["blanc vieille dentelle"] = "OldLace",
  ["rouge"] = "Red", ["rouge clair"] = "LightCoral",
  ["rouge foncé"] = "DarkRed", ["rouge sang"] = "Maroon",
  ["rouge brique"] = "Brown",
  ["rouge tomate"] = "Tomato", ["rouge corail"] = "Coral",
  ["rouge indien"] = "IndianRed", ["rouge cramoisi"] = "Crimson",
  ["rouge saumon"] = "Salmon", ["rouge saumon foncé"] = "DarkSalmon",
  ["rouge orange"] = "OrangeRed", ["rouge rosé"] = "PaleVioletRed",
  ["brique de feu"] = "FireBrick",
  ["bleu"] = "Blue", ["bleu ciel"] = "SkyBlue", ["bleu clair"] = "LightBlue",
  ["bleu azur"] = "Azure", ["bleu canard"] = "Teal",
  ["bleu turquoise"] = "CadetBlue",
  ["bleu marine"] = "Navy", ["bleu nuit"] = "MidnightBlue",
  ["bleu foncé"] = "DarkBlue", ["bleu acier"] = "SteelBlue",
  ["bleu acier clair"] = "LightSteelBlue", ["bleu royal"] = "RoyalBlue",
  ["bleu cornflower"] = "CornflowerBlue", ["bleu dodger"] = "DodgerBlue",
  ["bleu poudre"] = "PowderBlue", ["bleu Alice"] = "AliceBlue",
  ["bleu aigue-marine"] = "Aqua",
  ["bleu aigue-marine moyen"] = "MediumAquamarine",
  ["bleu slate"] = "SlateBlue", ["bleu slate clair"] = "LightSlateBlue",
  ["bleu slate foncé"] = "DarkSlateBlue",
  ["bleu slate moyen"] = "MediumSlateBlue",
  ["bleu violet"] = "BlueViolet", ["bleu indigo"] = "Indigo",
  ["bleu lavande"] = "Lavender",
  ["bleu lavande rosé"] = "LavenderBlush",
  ["bleu ciel profond"] = "DeepSkyBlue",
  ["vert"] = "Green", ["vert clair"] = "LightGreen",
  ["vert foncé"] = "DarkGreen", ["vert forêt"] = "ForestGreen",
  ["vert sapin"] = "DarkGreen",
  ["vert pomme"] = "GreenYellow",
  ["vert olive"] = "Olive", ["vert olive foncé"] = "DarkOliveGreen",
  ["vert menthe"] = "MintCream",
  ["vert printanier"] = "SpringGreen",
  ["vert printanier moyen"] = "MediumSpringGreen",
  ["vert de mer"] = "SeaGreen", ["vert de mer clair"] = "LightSeaGreen",
  ["vert de mer foncé"] = "DarkSeaGreen",
  ["vert de mer moyen"] = "MediumSeaGreen",
  ["vert honeydew"] = "Honeydew", ["vert pale"] = "PaleGreen",
  ["vert pâle"] = "PaleGreen",
  ["vert lawn"] = "LawnGreen", ["vert citron"] = "LimeGreen",
  ["vert lime"] = "Lime", ["vert lime clair"] = "LimeGreen",
  ["vert chartreuse"] = "Chartreuse", ["vert jaunâtre"] = "YellowGreen",
  ["jaune"] = "Yellow", ["jaune clair"] = "LightYellow",
  ["jaune paille"] = "LightGoldenrodYellow",
  ["jaune citron"] = "LemonChiffon",
  ["jaune moutarde"] = "DarkGoldenrod",
  ["jaune doré"] = "Gold", ["jaune khaki"] = "Khaki",
  ["jaune khaki foncé"] = "DarkKhaki",
  ["orange"] = "Orange", ["orange clair"] = "LightSalmon",
  ["orange corail"] = "Coral", ["orange foncé"] = "DarkOrange",
  ["orange brique"] = "Chocolate",
  ["orange rouge"] = "OrangeRed", ["orange sable"] = "SandyBrown",
  ["verge d'or"] = "Goldenrod", ["verge d'or pâle"] = "PaleGoldenrod",
  ["verge d'or clair"] = "LightGoldenrod",
  ["mousseline de citron"] = "LemonChiffon",
  ["violet"] = "Violet", ["violet clair"] = "Plum",
  ["violet foncé"] = "DarkViolet", ["violet moyen"] = "MediumPurple",
  ["violet rouge"] = "VioletRed",
  ["violet rouge moyen"] = "MediumVioletRed",
  ["violet rouge pâle"] = "PaleVioletRed",
  ["violet orchidée"] = "Orchid", ["violet orchidée foncé"] = "DarkOrchid",
  ["magenta"] = "Magenta", ["fuchsia"] = "Fuchsia", ["chardon"] = "Thistle",
  ["marron"] = "Maroon", ["brun"] = "Brown",
  ["brun clair"] = "BurlyWood",
  ["brun foncé"] = "SaddleBrown",
  ["brun chocolat"] = "Chocolate", ["brun rosé"] = "RosyBrown",
  ["brun peru"] = "Peru", ["tan"] = "Tan",
  ["marron selle"] = "SaddleBrown", ["marron sable"] = "SandyBrown",
  ["terre de Sienne"] = "Sienna", ["olive"] = "Olive",
  ["olive terne"] = "OliveDrab",
  ["cyan"] = "Cyan", ["cyan clair"] = "LightCyan",
  ["cyan foncé"] = "DarkCyan",
  ["aigue-marine"] = "Aquamarine",
  ["aigue-marine moyen"] = "MediumAquamarine",
  ["turquoise"] = "Turquoise",
  ["turquoise clair"] = "PaleTurquoise",
  ["turquoise foncé"] = "DarkTurquoise",
  ["turquoise moyen"] = "MediumTurquoise",
  ["turquoise pâle"] = "PaleTurquoise",
  ["corail"] = "Coral", ["corail clair"] = "LightCoral",
  ["saumon"] = "Salmon", ["saumon clair"] = "LightSalmon",
  ["saumon foncé"] = "DarkSalmon",
  ["or"] = "Gold", ["argent"] = "Silver",
  ["rose"] = "Pink", ["rose clair"] = "LightPink",
  ["rose profond"] = "DeepPink", ["rose vif"] = "HotPink",
  ["rose brumeux"] = "MistyRose",
  ["pêche duveteuse"] = "PeachPuff", ["prune"] = "Plum",
  ["pourpre"] = "Purple", ["fouet de papaye"] = "PapayaWhip",
  ["coquillage"] = "Seashell", ["soie de maïs"] = "Cornsilk",
  ["biscuit"] = "Bisque", ["cramoisi"] = "Crimson",
  ["lavande"] = "Lavender", ["vieille dentelle"] = "OldLace",
  ["lin"] = "Linen", ["mocassin"] = "Moccasin",
  ["neige"] = "Snow", ["blé"] = "Wheat",
}

V.KEYWORDS = {
  ["soit"]     = "let",
  ["pour"]     = "for",
  ["dans"]     = "in",
  ["si"]       = "if",
  ["sinon"]    = "else",
  ["tant que"] = "while",
}

V.OPERATORS = {
  ["au moins"]     = ">=",
  ["au plus"]      = "<=",
  ["égal à"]       = "==",
  ["différent de"] = "!=",
}

V.MATH_WORDS = {
  ["infini"]       = "inf",
  ["pour tout"]    = "forall",
  ["il n'existe pas"] = "!exists",
  ["il existe"]    = "exists",
  ["déterminant"]  = "det",
  ["norme"]        = "norm",
  ["gradient"]     = "grad",
  ["divergence"]   = "div",
  ["rotationnel"]  = "curl",
  ["laplacien"]    = "lap",
  ["partielle"]    = "partial",
  ["partiel"]      = "partial",
  ["somme"]        = "sum",
  ["produit"]      = "prod",
  ["intégrale"]    = "int",
  ["integrale"]    = "int",
  ["racine"]       = "sqrt",
  ["arrondi"]      = "round",
  ["defaut"]       = "floor",
  ["défaut"]       = "floor",
  ["exces"]        = "ceil",
  ["excès"]        = "ceil",
  ["signe"]        = "sign",
  ["factorielle"]  = "factorial",
  ["naturels"]     = "NN", ["entiers"] = "ZZ", ["décimaux"] = "DD",
  ["rationnels"]   = "QQ", ["réels"]   = "RR", ["complexes"] = "CC",
  ["probabilité"] = "PP", ["corps"]   = "KK", ["quaternions"] = "HH",
  ["dans"]         = "in", ["non"] = "not",
  ["sachant"]      = "mid",
  ["et"]           = "and",
  ["ou"]           = "or",
  ["négation de"]  = "lnot",
  ["n'appartient pas à"] = "!in",
  ["appartient à"] = "in",
  ["inclus dans ou égal à"] = "subseteq",
  ["contient ou est égal à"] = "supseteq",
  ["inclus dans"]  = "subset",
  ["contient"]     = "supset",
  ["union"]        = "cup",
  ["inter"]        = "cap",
  ["intersection"] = "cap",
  ["réunion de"]   = "bigcup",
  ["intersection de"] = "bigcap",
  ["privé de"]     = "setminus",
  ["vide"]         = "emptyset",
  ["parties de"]   = "powerset",
  ["intervalle entier"] = "range",
  ["cardinal"]     = "card",
  ["congru à"]     = "equiv",
  ["modulo"]       = "mod",
  ["conjugué"]     = "conj",
  ["moyenne"]      = "bar",
  ["adhérence"]    = "bar",
  ["espérance"]    = "EE",
  ["variance"]     = "var",
  ["écart type"]  = "std",
  ["covariance"]   = "cov",
  ["normal"]       = "normal", ["binomiale"] = "binomial",
  ["poisson"]      = "poisson",
  ["vecteur"]      = "vec",
  ["répartition de"] = "repart",
  ["densité de"]  = "densite",
  ["engendré par"] = "span",
  ["engendre"]    = "span",
  ["trace"]        = "tr",
  ["rang"]         = "rank",
  ["noyau"]        = "ker",
  ["image"]        = "im",
  ["comatrice"]    = "com",
  ["spectre"]      = "eigen",
  ["transposée"]  = "transpose",
  ["comatrice de"] = "com",
  ["dérivée directionnelle"] = "dirderiv",
  ["parallèle"]       = "parallel",
  ["perpendiculaire"] = "perp",
  ["orthogonal à"]    = "perp",
  ["semblable"]       = "sim",
  ["semblables"]      = "sim",
  ["isométrique"]     = "cong",
  ["isométriques"]    = "cong",
  ["parallélogramme"] = "parallelogram",
  ["angle droit"]     = "rightangle",
  ["milieu"]              = "midpoint",
  ["distance"]           = "distance",
  ["cercle"]             = "circle",
  ["repère orthonormé"]  = "orthoframe",
  ["repère"]             = "frame",
  ["colinéaires"]        = "collinear",
  ["colinéaire"]         = "collinear",
  ["produit scalaire"]   = "inner",
  ["orthogonal"]         = "ortho",
  ["projeté orthogonal"] = "orthogonalprojection",
  ["produit mixte"]      = "triple",
  ["valeur absolue"]     = "abs",
}

local byte, sub, sort = string.byte, string.sub, table.sort

local IS_BOUNDARY = {}
for b = 0, 255 do IS_BOUNDARY[b] = false end
IS_BOUNDARY[9]   = true
IS_BOUNDARY[10]  = true
IS_BOUNDARY[13]  = true
IS_BOUNDARY[32]  = true
IS_BOUNDARY[44]  = true
IS_BOUNDARY[58]  = true
IS_BOUNDARY[62]  = true
IS_BOUNDARY[123] = true
setmetatable(IS_BOUNDARY, { __index = function() return true end })

local function make_index(dict)
  local index = {}
  for k in pairs(dict) do
    local first, len = byte(k, 1), #k
    local lengths = index[first]
    if not lengths then
      lengths = { [len] = true }
      index[first] = lengths
    else
      lengths[len] = true
    end
  end
  for first, set in pairs(index) do
    local lengths, n = {}, 0
    for len in pairs(set) do
      n = n + 1
      lengths[n] = len
    end
    sort(lengths, function(a, b) return a > b end)
    index[first] = lengths
  end
  return index
end

local INDEXES = {}
for _, dict in ipairs {
  V.TAGS, V.LIST_STYLES, V.STYLE_WORDS, V.COUNTED_WORDS, V.PLACE,
  V.KV_KEYS, V.STATS_KINDS, V.LOIS, V.DOMAINES, V.COLORS,
  V.KEYWORDS, V.OPERATORS, V.MATH_WORDS,
} do
  INDEXES[dict] = make_index(dict)
end

function V.longest_match(dict, s)
  local index = INDEXES[dict]
  if not index then

    index = make_index(dict)
    INDEXES[dict] = index
  end
  local lengths = index[byte(s, 1)]
  if not lengths then return nil end
  local n = #s
  for i = 1, #lengths do
    local len = lengths[i]
    if len <= n and IS_BOUNDARY[byte(s, len + 1)] then
      local key = sub(s, 1, len)
      local value = dict[key]
      if value ~= nil then
        return key, value, sub(s, len + 1)
      end
    end
  end
  return nil
end

function V.color(name)
  local c = V.COLORS[name]
  if c then return c end
  local n = #name
  if n <= 1 then return nil end
  local base = name
  if byte(base, n) == 115 then
    base = sub(base, 1, n - 1)
    c = V.COLORS[base]
    if c then return c end
    n = n - 1
  end
  if n > 1 and byte(base, n) == 101 then
    base = sub(base, 1, n - 1)
    c = V.COLORS[base]
    if c then return c end
    local b = byte(base, n - 1)
    if b == 104 or b == 116 then
      c = V.COLORS[sub(base, 1, n - 2)]
      if c then return c end
    end
  end
  local first = byte(name, 1)
  if first and first >= 65 and first <= 90 then
    for i = 2, #name do
      local b = byte(name, i)
      if b >= 97 and b <= 122 then return name end
    end
  end
  return nil
end

local COLOR_KEYS_SORTED = {}
for k in pairs(V.COLORS) do COLOR_KEYS_SORTED[#COLOR_KEYS_SORTED + 1] = k end
sort(COLOR_KEYS_SORTED, function(a, b)
  local la, lb = #a, #b
  return la == lb and a < b or la > lb
end)

function V.color_keys_sorted()
  return COLOR_KEYS_SORTED
end

return V