local S = {}

S.STYLE = {
  b    = {"\\textbf{", "}"},  i  = {"\\textit{", "}"}, u  = {"\\underline{", "}"},
  emph = {"\\emph{", "}"},    sf = {"\\textsf{", "}"},
  sc   = {"\\textsc{", "}"},

  st       = {"\\sout{", "}"},
  footnote = {"\\footnote{", "}"},
}

S.CSS = {AliceBlue=true, AntiqueWhite=true, Aqua=true, Aquamarine=true, Azure=true, Beige=true, Bisque=true, Black=true, BlanchedAlmond=true, Blue=true, BlueViolet=true, Brown=true, BurlyWood=true, CadetBlue=true, Chartreuse=true, Chocolate=true, Coral=true, CornflowerBlue=true, Cornsilk=true, Crimson=true, Cyan=true, DarkBlue=true, DarkCyan=true, DarkGoldenrod=true, DarkGray=true, DarkGreen=true, DarkGrey=true, DarkKhaki=true, DarkMagenta=true, DarkOliveGreen=true, DarkOrange=true, DarkOrchid=true, DarkRed=true, DarkSalmon=true, DarkSeaGreen=true, DarkSlateBlue=true, DarkSlateGray=true, DarkSlateGrey=true, DarkTurquoise=true, DarkViolet=true, DeepPink=true, DeepSkyBlue=true, DimGray=true, DimGrey=true, DodgerBlue=true, FireBrick=true, FloralWhite=true, ForestGreen=true, Fuchsia=true, Gainsboro=true, GhostWhite=true, Gold=true, Goldenrod=true, Gray=true, Green=true, GreenYellow=true, Grey=true, Honeydew=true, HotPink=true, IndianRed=true, Indigo=true, Ivory=true, Khaki=true, Lavender=true, LavenderBlush=true, LawnGreen=true, LemonChiffon=true, LightBlue=true, LightCoral=true, LightCyan=true, LightGoldenrod=true, LightGoldenrodYellow=true, LightGray=true, LightGreen=true, LightGrey=true, LightPink=true, LightSalmon=true, LightSeaGreen=true, LightSkyBlue=true, LightSlateBlue=true, LightSlateGray=true, LightSlateGrey=true, LightSteelBlue=true, LightYellow=true, Lime=true, LimeGreen=true, Linen=true, Magenta=true, Maroon=true, MediumAquamarine=true, MediumBlue=true, MediumOrchid=true, MediumPurple=true, MediumSeaGreen=true, MediumSlateBlue=true, MediumSpringGreen=true, MediumTurquoise=true, MediumVioletRed=true, MidnightBlue=true, MintCream=true, MistyRose=true, Moccasin=true, NavajoWhite=true, Navy=true, NavyBlue=true, OldLace=true, Olive=true, OliveDrab=true, Orange=true, OrangeRed=true, Orchid=true, PaleGoldenrod=true, PaleGreen=true, PaleTurquoise=true, PaleVioletRed=true, PapayaWhip=true, PeachPuff=true, Peru=true, Pink=true, Plum=true, PowderBlue=true, Purple=true, Red=true, RosyBrown=true, RoyalBlue=true, SaddleBrown=true, Salmon=true, SandyBrown=true, SeaGreen=true, Seashell=true, Sienna=true, Silver=true, SkyBlue=true, SlateBlue=true, SlateGray=true, SlateGrey=true, Snow=true, SpringGreen=true, SteelBlue=true, Tan=true, Teal=true, Thistle=true, Tomato=true, Turquoise=true, Violet=true, VioletRed=true, Wheat=true, White=true, WhiteSmoke=true, Yellow=true, YellowGreen=true}

S.ALIGN   = {l="\\raggedright", c="\\centering", r="\\raggedleft", j="\\justifying"}
S.SECTION = {section="\\section", subsection="\\subsection", subsubsection="\\subsubsection"}

local function count_prefix(word, name)
  if word == name then return "1" end
  local n = word:match("^(%d+)" .. name .. "$")
  return n
end

local MATCHERS = {

  function(w)
    local C = { num = "\\arabic", roman = "\\roman", ROMAN = "\\Roman",
                alpha = "\\alph", ALPHA = "\\Alph" }
    if C[w] then return {kind = "counter", cmd = C[w]} end
  end,

  function(w)
    if w:match("^%u") and w == w:upper() and not w:match("%l") then
      return {kind = "font"}
    end
  end,

  function(w)
    if S.CSS[w] then
      return {kind = "color", open = "\\textcolor{" .. w .. "}{", close = "}"}
    end
  end,

  function(w)
    if S.STYLE[w] then
      return {kind = "style", open = S.STYLE[w][1], close = S.STYLE[w][2]}
    end
  end,

  function(w)
    if S.ALIGN[w] then return {kind = "align", cmd = S.ALIGN[w]} end
  end,

  function(w)
    if S.SECTION[w] then return {kind = "section", cmd = S.SECTION[w]} end
  end,

  function(w)
    local pt = w:match("^(%d+%.?%d*)p[tx]$")
    if pt then return {kind = "size", pt = pt} end
  end,

  function(w)
    if w == "nextpage" then return {kind = "page"} end
  end,

  function(w)
    if w == "nextline" then return {kind = "break"} end
  end,

  function(w)
    if w == "line" or w == "1line" then return {kind = "lines", n = "1"} end
    local n = w:match("^(%d+)lines$")
    if n then
      if tonumber(n) < 2 then
        error("texecole: write '" .. n .. "line' (singular), not '" .. w .. "'")
      end
      return {kind = "lines", n = n}
    end
    local bad = w:match("^(%d+)line$")
    if bad and tonumber(bad) >= 2 then
      error("texecole: write '" .. bad .. "lines' (plural), not '" .. w .. "'")
    end
  end,

  function(w)
    local n = count_prefix(w, "tab")
    if n then return {kind = "tab", n = n} end
  end,

  function(w)
    local mm = w:match("^up(%d+%.?%d*)$")
    if mm then return {kind = "up", mm = mm} end
  end,

  function(w)
    local mm = w:match("^down(%d+%.?%d*)$")
    if mm then return {kind = "down", mm = mm} end
  end,
}

function S.resolve(word)
  for _, matcher in ipairs(MATCHERS) do
    local d = matcher(word)
    if d then return d end
  end
  return nil
end

local function classify_into(words, alias, buckets)
  local i, n = 1, #words
  while i <= n do
    local w = words[i]
    local r = S.resolve(w)
    if r and r.kind == "section" then
      buckets.section[#buckets.section + 1] = {r.cmd .. "{", "}"}
    elseif r and r.kind == "counter" then

      buckets.counter = r.cmd
    elseif r and r.kind == "page" then
      buckets.page[1] = {"\\newpage ", ""}
    elseif r and r.kind == "break" then
      buckets.page[#buckets.page + 1] = {"\\newline ", ""}
    elseif r and r.kind == "lines" then
      buckets.lines[#buckets.lines + 1] = {"\\vspace*{" .. r.n .. "\\texecoleline}", ""}
    elseif r and r.kind == "align" then
      buckets.align[#buckets.align + 1] = {"{" .. r.cmd .. " ", "\\par}"}
    elseif r and r.kind == "tab" then
      buckets.wrap[#buckets.wrap + 1] = {"\\hspace*{" .. r.n .. "\\texecoletab}", ""}
    elseif r and r.kind == "up" then
      buckets.wrap[#buckets.wrap + 1] = {"\\texecolescript{" .. r.mm .. "mm}{", "}"}
    elseif r and r.kind == "down" then
      buckets.wrap[#buckets.wrap + 1] = {"\\texecolescript{-" .. r.mm .. "mm}{", "}"}
    elseif r and r.kind == "size" then
      local lead = string.format("%.1f", tonumber(r.pt) * 1.2)
      buckets.wrap[#buckets.wrap + 1] =
        {"{\\fontsize{" .. r.pt .. "}{" .. lead .. "}\\selectfont ", "}"}
    elseif r and (r.kind == "style" or r.kind == "color") then
      buckets.wrap[#buckets.wrap + 1] = {r.open, r.close}
    elseif r and r.kind == "font" then
      local parts = {w}; i = i + 1
      while i <= n and words[i]:match("^%u") and words[i] == words[i]:upper()
            and not words[i]:match("%l") do
        parts[#parts + 1] = words[i]; i = i + 1
      end
      buckets.wrap[#buckets.wrap + 1] =
        {"{\\fontspec{" .. table.concat(parts, " ") .. "}", "}"}
      i = i - 1
    elseif alias[w] then
      classify_into(alias[w], alias, buckets)
    else

      local cap = w:gsub("^%l", string.upper)
      if S.CSS[cap] then
        error("texecole: '" .. w .. "' is not a colour; colours are written "
            .. "in CamelCase now -- use '" .. cap .. "'")
      end
      error("texecole: unknown tag attribute: '" .. w .. "'")
    end
    i = i + 1
  end
end

function S.classify_split(words, alias)
  local buckets = {page = {}, section = {}, lines = {}, align = {}, wrap = {}}
  classify_into(words, alias, buckets)

  if buckets.counter then
    if not buckets.section[1] then
      error("texecole: a counter style (num/roman/ROMAN/alpha/ALPHA) is "
          .. "only meaningful next to a heading keyword (section, "
          .. "subsection, subsubsection)")
    end
    local open = buckets.section[1][1]
    local name = open:match("(%a+)%*?{$") or open:match("(%a+)")
    buckets.section[1][1] = "\\renewcommand{\\the" .. name .. "}{"
      .. buckets.counter .. "{" .. name .. "}}" .. open
  end
  local outer = {}
  for _, cat in ipairs({"page", "lines", "section", "align"}) do
    for _, e in ipairs(buckets[cat]) do outer[#outer + 1] = e end
  end
  return outer, buckets.wrap
end

function S.classify_words(words, alias)
  local outer, inner = S.classify_split(words, alias)
  local all = {}
  for _, e in ipairs(outer) do all[#all + 1] = e end
  for _, e in ipairs(inner) do all[#all + 1] = e end
  return all
end

function S.resolve_styles(words, alias)
  local out = {}
  for _, w in ipairs(words) do
    if S.resolve(w) then out[#out + 1] = w
    elseif alias[w] then for _, sub in ipairs(alias[w]) do out[#out + 1] = sub end
    else error("texecole: unknown style in alias: '" .. w .. "'") end
  end
  return out
end

return S