local U = require("texecole-util")

return function(sl)
  sl.register_tag("tableofcontents", function(api, words, content)
    local title = U.trim(content or "")
    api.lit("\\renewcommand{\\contentsname}{}")
    if title ~= "" then
      api.lit("{\\centering\\large\\bfseries ")
      api.forward_text(title)
      api.lit("\\par}\\vspace{\\texecoleline}")
    end
    api.lit("\\tableofcontents\\newpage")
  end)
end
