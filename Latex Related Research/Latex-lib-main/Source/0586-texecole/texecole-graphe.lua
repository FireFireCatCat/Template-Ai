local U = require("texecole-util")

local function lire_aretes(inner, nom)
  local sommets, index, aretes = {}, {}, {}
  local oriente = nil
  local function sommet(s)
    if not index[s] then
      sommets[#sommets + 1] = s
      index[s] = #sommets
    end
    return index[s]
  end
  for _, l in ipairs(inner) do
    if type(l) == "string" and l:match("%S") and not l:match("^%s*}%s*$") then
      local ligne = U.trim(l)
      local a, fl, b = ligne:match("^([%a][%w_]*)%s*(%-[%->])%s*([%a][%w_]*)$")
      if not a then
        error("texecole : chaque ligne du graphe " .. nom .. " est une "
          .. "arête, « A -- B » (non orientée) ou « A -> B » (orientée) ; "
          .. "reçu « " .. ligne .. " ».", 0)
      end
      local o = (fl == "->")
      if oriente == nil then oriente = o
      elseif oriente ~= o then
        error("texecole : le graphe " .. nom .. " mélange arêtes orientées "
          .. "(->) et non orientées (--) ; un graphe est l'un ou l'autre.", 0)
      end
      aretes[#aretes + 1] = { sommet(a), sommet(b) }
    end
  end
  if #aretes == 0 then
    error("texecole : le graphe " .. nom .. " est vide ; donnez une arête "
      .. "par ligne, « A -- B » ou « A -> B ».", 0)
  end
  return sommets, aretes, oriente
end

local function adjacence(sommets, aretes, oriente)
  local n = #sommets
  local A = {}
  for i = 1, n do
    A[i] = {}
    for j = 1, n do A[i][j] = 0 end
  end
  for _, e in ipairs(aretes) do
    A[e[1]][e[2]] = A[e[1]][e[2]] + 1
    if not oriente and e[1] ~= e[2] then
      A[e[2]][e[1]] = A[e[2]][e[1]] + 1
    end
  end
  return A
end

local function matmul(A, B)
  local n = #A
  local C = {}
  for i = 1, n do
    C[i] = {}
    for j = 1, n do
      local s = 0
      for k = 1, n do s = s + A[i][k] * B[k][j] end
      C[i][j] = s
    end
  end
  return C
end

local function matpow(A, p)
  local R = A
  for _ = 2, p do R = matmul(R, A) end
  return R
end

local function fmt(v)
  return (("%.4f"):format(v)):gsub("0+$", ""):gsub("%.$", "")
end

local function tracer(sommets, aretes, oriente)
  local n = #sommets
  local r = math.max(1.6, 0.55 * n)
  local pos = {}
  for i = 1, n do
    local ang = math.pi / 2 - 2 * math.pi * (i - 1) / n
    pos[i] = { r * math.cos(ang), r * math.sin(ang) }
  end
  local out = {}
  out[#out + 1] = "\\begin{center}\\begin{tikzpicture}[line width=0.5pt]"
  for i = 1, n do
    out[#out + 1] = ("\\node[draw, circle, inner sep=2pt, font=\\small] "
      .. "(s%d) at (%s,%s) {$%s$};")
      :format(i, fmt(pos[i][1]), fmt(pos[i][2]), sommets[i])
  end
  local double = {}
  if oriente then
    local vu = {}
    for _, e in ipairs(aretes) do vu[e[1] .. ">" .. e[2]] = true end
    for _, e in ipairs(aretes) do
      if e[1] ~= e[2] and vu[e[2] .. ">" .. e[1]] then
        double[e[1] .. ">" .. e[2]] = true
      end
    end
  end
  local style = oriente and "[->, >=stealth]" or ""
  for _, e in ipairs(aretes) do
    if e[1] == e[2] then
      out[#out + 1] = ("\\draw%s (s%d) to[loop above] (s%d);")
        :format(oriente and "[->, >=stealth]" or "", e[1], e[2])
    elseif double[e[1] .. ">" .. e[2]] then
      out[#out + 1] = ("\\draw[->, >=stealth] (s%d) to[bend left=15] (s%d);")
        :format(e[1], e[2])
    else
      out[#out + 1] = ("\\draw%s (s%d) -- (s%d);"):format(style, e[1], e[2])
    end
  end
  out[#out + 1] = "\\end{tikzpicture}\\end{center}"
  return table.concat(out, "\n")
end

local function liste_sommets(sommets)
  local noms = {}
  for _, s in ipairs(sommets) do noms[#noms + 1] = "$" .. s .. "$" end
  if #noms == 1 then return noms[1] end
  return table.concat(noms, ", ", 1, #noms - 1) .. " et " .. noms[#noms]
end

local function matrice_tex(A)
  local out = { "\\begin{pmatrix}" }
  local lignes = {}
  for i = 1, #A do
    lignes[#lignes + 1] = table.concat(A[i], " & ")
  end
  out[#out + 1] = table.concat(lignes, " \\\\ ")
  out[#out + 1] = "\\end{pmatrix}"
  return table.concat(out)
end

return function(sl)
  local function pose(api, s)
    api.raw("emit(" .. string.format("%q", s) .. ")\n")
  end

  sl.register_block("graph", function(api, words_str, inner)
    local nom = U.trim(words_str or "")
    if nom == "" then nom = "G" end
    local sommets, aretes, oriente = lire_aretes(inner, nom)
    pose(api, tracer(sommets, aretes, oriente))
  end)

  sl.register_block("graphadj", function(api, words_str, inner)
    local nom = U.trim(words_str or "")
    if nom == "" then nom = "G" end
    local sommets, aretes, oriente = lire_aretes(inner, nom)
    local A = adjacence(sommets, aretes, oriente)
    pose(api, "La matrice d'adjacence de $" .. nom
      .. "$, les sommets rangés dans l'ordre " .. liste_sommets(sommets)
      .. ", est $M_{" .. nom .. "} = " .. matrice_tex(A) .. "$.")
  end)

  sl.register_block("graphpaths", function(api, words_str, inner)
    local nom, p, de, vers = U.trim(words_str or ""):match(
      "^([%a][%w_]*)%s+(%d+)%s+([%a][%w_]*)%s+([%a][%w_]*)$")
    if not nom then
      error("texecole : le dénombrement des chemins est mal formé.", 0)
    end
    p = math.tointeger(tonumber(p))
    if p < 1 then
      error("texecole : la longueur d'un chemin est un entier au moins "
        .. "égal à 1.", 0)
    end
    local sommets, aretes, oriente = lire_aretes(inner, nom)
    local idx = {}
    for i, s in ipairs(sommets) do idx[s] = i end
    if not idx[de] or not idx[vers] then
      local absent = (not idx[de]) and de or vers
      error("texecole : le sommet " .. absent .. " n'appartient pas au "
        .. "graphe " .. nom .. ".", 0)
    end
    local A = adjacence(sommets, aretes, oriente)
    local Ap = matpow(A, p)
    local nb = Ap[idx[de]][idx[vers]]
    pose(api, "Le coefficient de la ligne $" .. de .. "$, colonne $"
      .. vers .. "$ de $M_{" .. nom .. "}^{\\,\\," .. p .. "}$ vaut $"
      .. nb .. "$ : il y a $" .. nb .. "$ chemin"
      .. (nb > 1 and "s" or "") .. " de longueur $" .. p .. "$ de $"
      .. de .. "$ à $" .. vers .. "$ dans $" .. nom .. "$.")
  end)
end
