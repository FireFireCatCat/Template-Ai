local U = require("texecole-util")

return function(sl)
  sl.register_tag("img", function(api, words, content, words_str)
    local rest = U.trim((words_str or ""):gsub("^%S+%s*", ""))
    local attrs = U.parse_attrs(rest, {
      tag  = "image",
      hint = "les dimensions se disent en prose : avec une largeur de "
          .. "30 mm, une hauteur de 20 mm, un côté de 30 mm ou une "
          .. "largeur de 50 %",
      on_bare = function() return false end,
    })

    local kvw, kvh = attrs.width, attrs.height
    if attrs.side then kvw, kvh = attrs.side, attrs.side end

    local opt = "width=\\linewidth"
    if attrs.widthpct then
      local pct = tonumber((tostring(attrs.widthpct):gsub(",", ".")))
      if not pct or pct <= 0 or pct > 100 then
        error("texecole: la largeur en pourcentage va de 1 à 100 (reçu '"
            .. tostring(attrs.widthpct) .. "')")
      end
      opt = "width=" .. string.format("%.4f", pct / 100)
                     :gsub("0+$", ""):gsub("%.$", "") .. "\\linewidth"
    elseif kvw and kvh then
      opt = "width=" .. kvw .. "mm,height=" .. kvh .. "mm,keepaspectratio"
    elseif kvw then
      opt = "width=" .. kvw .. "mm"
    elseif kvh then
      opt = "height=" .. kvh .. "mm"
    end

    local fname = U.trim(content)
    if not attrs.dir or attrs.dir == "" then
      error("texecole : <Insère une image> exige « dans le dossier {...} » "
        .. "— aucun dossier par défaut n'est cherché. Écrivez par exemple "
        .. "« <Insère une image, dans le dossier {IMAGES}>{" .. fname
        .. "} ».", 0)
    end
    fname = attrs.dir:gsub("/+$", "") .. "/" .. fname

    if attrs.caption then api.lit("\\begin{center}") end
    api.lit("\\raisebox{-0.5\\height}{\\includegraphics[" .. opt .. "]{")
    local p = 1
    while true do
      local h = fname:find("#", p, true)
      if not h then api.lit(fname:sub(p)); break end
      api.lit(fname:sub(p, h - 1))
      local expr, after
      if fname:sub(h + 1, h + 1) == "{" then
        expr, after = U.read_group(fname, h + 1)
      else
        expr = fname:match("^#([%a_][%w_]*)", h)
        after = h + 1 + #expr
      end
      api.raw("emit(tostring(" .. expr .. "))\n")
      p = after
    end
    api.lit("}}")
    if attrs.caption then
      api.lit("\\\\[2pt]{\\small ")
      api.forward_text(attrs.caption)
      api.lit("}\\end{center}")
    end
  end)
end
