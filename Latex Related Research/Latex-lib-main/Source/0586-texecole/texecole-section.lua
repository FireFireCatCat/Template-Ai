local U = require("texecole-util")

local LEVEL = {
  section       = "\\section",
  subsection    = "\\subsection",
  subsubsection = "\\subsubsection",
}

local function split_title(s)
  local title, rest = nil, {}
  local i, n = 1, #s
  while i <= n do
    while i <= n and s:sub(i, i):match("%s") do i = i + 1 end
    if i > n then break end
    local key = s:match("^title:", i)
    if key and s:sub(i + 6, i + 6) == "{" then
      local value, after = U.read_group(s, i + 6)
      title = value
      i = after
    else
      local word = s:match("^(%S+)", i)
      rest[#rest + 1] = word
      i = i + #word
    end
  end
  return title, rest
end

local function register(sl)
  for name, cmd in pairs(LEVEL) do
    sl.register_block(name, function(api, words_str, inner)
      local title, words = split_title(words_str or "")
      if not title then
        error("texecole: <" .. name .. "> block needs a title:{...} option")
      end

      local counter_cmd = nil

      local style_open, style_close = {}, {}
      local before = {}
      for _, w in ipairs(words) do
        local r = sl.style.resolve(w)
        if r and r.kind == "counter" then
          counter_cmd = r.cmd
        elseif r and (r.kind == "style" or r.kind == "color") then
          style_open[#style_open + 1] = r.open
          style_close[#style_close + 1] = r.close
        elseif r and r.kind == "size" then
          local lead = string.format("%.1f", tonumber(r.pt) * 1.2)
          style_open[#style_open + 1] =
            "{\\fontsize{" .. r.pt .. "}{" .. lead .. "}\\selectfont "
          style_close[#style_close + 1] = "}"
        elseif r and r.kind == "lines" then
          before[#before + 1] = "\\vspace*{" .. r.n .. "\\texecoleline}"
        else
          error("texecole: <" .. name .. "> only accepts colour/style words, a "
              .. "line skip, or a counter style (num/roman/ROMAN/alpha/ALPHA) "
              .. "on the title (got '" .. w .. "'); put layout like tab on the "
              .. "body paragraphs instead")
        end
      end

      if counter_cmd then
        local the = "\\the" .. name
        api.raw('emit(' .. string.format("%q",
          "\\renewcommand{" .. the .. "}{" .. counter_cmd .. "{" .. name .. "}}")
          .. ")\n")
      end

      for _, b in ipairs(before) do
        api.raw('emit(' .. string.format("%q", b) .. ")\n")
      end

      api.raw('emit("' .. cmd:gsub("\\", "\\\\") .. '{")\n')
      for _, o in ipairs(style_open) do
        api.raw('emit(' .. string.format("%q", o) .. ")\n")
      end
      api.forward_text(title)
      for j = #style_close, 1, -1 do
        api.raw('emit(' .. string.format("%q", style_close[j]) .. ")\n")
      end
      api.raw('emit("}")\n')

      api.process_block(inner)
    end)
  end
end

return register
