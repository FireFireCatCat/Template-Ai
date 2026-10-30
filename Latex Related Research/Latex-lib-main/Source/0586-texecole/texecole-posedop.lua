local U = require("texecole-util")

local SIGNES = {
  ["+"] = "+", ["-"] = "-", ["\u{2212}"] = "-",
  ["\u{00D7}"] = "\u{00D7}", ["*"] = "\u{00D7}", ["x"] = "\u{00D7}", ["X"] = "\u{00D7}",
}

local function lire_nombre(s)
  s = s:gsub("%s", ""):gsub("%.", ",")
  local e, d = s:match("^(%d+),(%d+)$")
  if not e then
    e = s:match("^(%d+)$")
    d = ""
  end
  if not e then return nil end
  return e, d
end

local function decouper(src)
  local corps = U.trim(src)
  for i = 2, #corps do
    local c1 = corps:sub(i, i)
    local c2 = corps:sub(i, i + 1)
    local signe = SIGNES[c2] or SIGNES[c1]
    if signe then
      local n = SIGNES[c2] and 2 or 1
      local ga, gd = corps:sub(1, i - 1), corps:sub(i + n)
      local e1, d1 = lire_nombre(ga)
      local e2, d2 = lire_nombre(gd)
      if e1 and e2 then return signe, e1, d1, e2, d2 end
    end
  end
  return nil
end

local function entier(e, d) return math.tointeger(tonumber(e .. d)) end

local function puissance(n)
  local p = 1
  for _ = 1, n do p = p * 10 end
  return p
end

local function formater(v, dec)
  local s = string.format("%d", math.floor(v))
  if dec == 0 then return s, "" end
  while #s <= dec do s = "0" .. s end
  return s:sub(1, #s - dec), s:sub(#s - dec + 1)
end

local function cases(e, d, ne, nd)
  local out = {}
  for _ = 1, ne - #e do out[#out + 1] = "" end
  for i = 1, #e do out[#out + 1] = e:sub(i, i) end
  if nd > 0 then
    out[#out + 1] = ","
    local dd = d
    while #dd < nd do dd = dd .. "0" end
    for i = 1, nd do out[#out + 1] = dd:sub(i, i) end
  end
  return out
end

local function vides(n)
  local out = {}
  for _ = 1, n do out[#out + 1] = "" end
  return out
end

local function decale(chiffres, rang, largeur)
  local out = vides(largeur)
  local fin = largeur - rang
  for i = #chiffres, 1, -1 do
    if fin < 1 then break end
    out[fin] = chiffres:sub(i, i)
    fin = fin - 1
  end
  return out
end

local function rendre(rangees, largeur, traits)
  local spec = "Q[r]"
  for _ = 1, largeur do spec = spec .. "Q[c]" end
  local reglages = { "colspec={" .. spec .. "}", "colsep=1.4pt", "rowsep=1.2pt" }
  for _, r in ipairs(traits) do
    reglages[#reglages + 1] = "hline{" .. r .. "}={2-" .. (largeur + 1) .. "}{solid}"
  end
  local out = { "\\begin{center}\\begin{tblr}{" .. table.concat(reglages, ", ") .. "}" }
  for _, rg in ipairs(rangees) do
    local morceaux = { rg.signe or "" }
    for _, c in ipairs(rg.cases) do
      morceaux[#morceaux + 1] = (c == ",") and "{,}" or c
    end
    out[#out + 1] = table.concat(morceaux, " & ") .. " \\\\"
  end
  out[#out + 1] = "\\end{tblr}\\end{center}"
  return table.concat(out, "\n")
end

local function poser(src, montre)
  local signe, e1, d1, e2, d2 = decouper(src)
  if not signe then
    error("texecole : « " .. U.trim(src) .. " » ne se lit pas comme une "
        .. "opération à poser ; écrivez deux nombres séparés par +, - ou "
        .. "\u{00D7}, par exemple 347 + 58.", 0)
  end

  local nd = math.max(#d1, #d2)
  local v1, v2 = entier(e1, d1), entier(e2, d2)
  local p1, p2 = puissance(nd - #d1), puissance(nd - #d2)
  v1, v2 = v1 * p1, v2 * p2

  local res, ndres
  if signe == "+" then
    res, ndres = v1 + v2, nd
  elseif signe == "-" then
    if v2 > v1 then
      error("texecole : une soustraction posée ne descend pas sous zéro ; "
          .. "écrivez le plus grand nombre en premier.", 0)
    end
    res, ndres = v1 - v2, nd
  else
    if nd > 0 then
      error("texecole : la multiplication posée se pose sur des entiers ; "
          .. "la virgule se place au résultat, après le calcul.", 0)
    end
    res, ndres = v1 * v2, 0
  end

  local re, rd = formater(res, ndres)
  local ne = math.max(#e1, #e2, #re)
  local largeur = ne + (nd > 0 and (1 + nd) or 0)

  local rangees = {
    { cases = cases(e1, d1, ne, nd) },
    { signe = signe, cases = cases(e2, d2, ne, nd) },
  }
  local traits = { 3 }

  if signe == "\u{00D7}" and montre and #e2 > 1 then
    for i = #e2, 1, -1 do
      local c = tonumber(e2:sub(i, i))
      local partiel = string.format("%d", v1 * c)
      rangees[#rangees + 1] = { cases = decale(partiel, #e2 - i, largeur) }
    end
    traits[#traits + 1] = #rangees + 1
  end

  if montre then
    rangees[#rangees + 1] = { cases = cases(re, rd, ne, nd) }
  else
    rangees[#rangees + 1] = { cases = vides(largeur) }
  end

  return rendre(rangees, largeur, traits)
end

return function(sl)
  local corps_posedop = function(api, words_str, inner)
    local montre = false
    for w in (words_str or ""):gmatch("%S+") do
      local cle, val = w:match("^([%a_]+):(.+)$")
      if w == "result" or (cle == "result" and val == "on") then
        montre = true
      else
        error("texecole : « opération posée » ne connaît pas l'attribut « "
            .. w .. " » ; le seul prévu est « avec le résultat ».", 0)
      end
    end
    local lignes = {}
    for _, l in ipairs(inner) do
      if type(l) == "string" and l:match("%S") and not l:match("^%s*}%s*$") then
        lignes[#lignes + 1] = U.trim(l)
      end
    end
    if #lignes == 0 then
      error("texecole : « opération posée » attend une opération dans son "
          .. "corps, par exemple 347 + 58.", 0)
    end
    local sorties = {}
    for _, l in ipairs(lignes) do sorties[#sorties + 1] = poser(l, montre) end
    api.raw("emit(" .. string.format("%q", table.concat(sorties, "\n")) .. ")\n")
  end
  sl.register_block("posedop", corps_posedop)
  sl.register_tag("posedop", function(api, w, content, words_str)
    local ws = (words_str or ""):gsub("^%s*%S+%s*", "", 1)
    corps_posedop(api, ws, { content or "" })
  end)
end
