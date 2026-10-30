local U    = require("texecole-util")
local Math = require("texecole-math")

local function fmt_label(lbl)
  local bang, core = lbl:match("^(!?)(.*)$")
  local m = Math.mathlite(core)
  if bang == "!" then m = "\\overline{" .. m .. "}" end
  return m
end

local function fmt_num(v)
  return (("%.6f"):format(v)):gsub("0+$", ""):gsub("%.$", "")
end

local complete
local function parse_tree(inner)
  local roots, stack = {}, {}
  local function current()
    return #stack == 0 and roots or stack[#stack].children
  end
  for _, l in ipairs(inner) do
    if type(l) ~= "string" or not l:match("%S") then goto continue end
    local line = U.trim(l)
    if line == "}" then
      if #stack == 0 then
        error("texecole: <tree> has a '}' with no open branch")
      end
      stack[#stack] = nil
      goto continue
    end
    local opens = false
    if line:match("{%s*$") then
      opens = true
      line = U.trim(line:gsub("{%s*$", ""))
    end
    local label, prob = line:match("^(%S+)%s+(%S+)$")
    if not label then
      error("texecole: <tree> each branch reads  LABEL PROBABILITY "
          .. "(then an optional { of children), got '" .. line .. "'")
    end
    local node = { label = label, prob = prob, children = {} }
    local siblings = current()
    siblings[#siblings+1] = node
    if opens then stack[#stack+1] = node end
    ::continue::
  end
  if #stack > 0 then
    error("texecole: <tree> has an unclosed branch '" .. stack[#stack].label .. "'")
  end
  if #roots == 0 then
    error("texecole: <tree> is empty")
  end
  complete(roots)
  return roots
end

local function complement_of(node)
  local label = node.label:sub(1, 1) == "!"
    and node.label:sub(2) or ("!" .. node.label)
  local p = tonumber(node.prob)
  local prob
  if p then
    if p <= 0 or p >= 1 then
      error("texecole: <tree> cannot complete the branch '" .. node.label
          .. "': its probability " .. node.prob .. " is not strictly between "
          .. "0 and 1")
    end
    prob = fmt_num(1 - p)
  elseif node.prob:match("^[%a][%w_]*$") then
    prob = "1-" .. node.prob
  else
    prob = "1-(" .. node.prob .. ")"
  end
  return { label = label, prob = prob, children = {} }
end

complete = function(nodes)
  if #nodes == 1 then
    nodes[#nodes+1] = complement_of(nodes[1])
  elseif #nodes >= 2 then
    local sum, allnum = 0, true
    for _, nd in ipairs(nodes) do
      local p = tonumber(nd.prob)
      if p then sum = sum + p else allnum = false end
    end
    if allnum and math.abs(sum - 1) > 1e-9 then
      error(("texecole: <tree> the probabilities of sibling branches sum to "
          .. "%s, not 1; add the missing branch, fix a value, or leave "
          .. "exactly one branch to auto-complete"):format(fmt_num(sum)))
    end
  end
  for _, nd in ipairs(nodes) do
    if #nd.children > 0 then complete(nd.children) end
  end
end

local DX, DY = 3.4, 1.3

local function layout(nodes, depth, slot)
  local ys = {}
  for _, nd in ipairs(nodes) do
    nd.x = depth * DX
    if #nd.children == 0 then
      nd.y = -slot[1] * DY
      slot[1] = slot[1] + 1
    else
      layout(nd.children, depth + 1, slot)
      local s = 0
      for _, c in ipairs(nd.children) do s = s + c.y end
      nd.y = s / #nd.children
    end
    ys[#ys+1] = nd.y
  end
  return ys
end

local function emit_tree(roots, products)
  local slot = {0}
  layout(roots, 1, slot)
  local rooty
  do
    local s = 0
    for _, r in ipairs(roots) do s = s + r.y end
    rooty = s / #roots
  end

  local maxx = 0
  local function span(nodes)
    for _, nd in ipairs(nodes) do
      if nd.x > maxx then maxx = nd.x end
      span(nd.children)
    end
  end
  span(roots)

  local out = {}
  out[#out+1] = "\\begin{center}\\begin{tikzpicture}[line width=0.5pt]"
  out[#out+1] = string.format("\\fill (0,%.4f) circle [radius=0.05];", rooty)

  local function edge(x1, y1, nd)
    out[#out+1] = string.format("\\draw (%.4f,%.4f) -- (%.4f,%.4f);",
      x1, y1, nd.x - 0.35, nd.y)
    local mx, my = (x1 + nd.x - 0.35) / 2, (y1 + nd.y) / 2
    local pos = (nd.y >= y1) and "above" or "below"
    out[#out+1] = string.format(
      "\\node[%s=1pt, font=\\footnotesize] at (%.4f,%.4f) {$%s$};",
      pos, mx, my, Math.mathlite(nd.prob))
    out[#out+1] = string.format(
      "\\node[right=-2pt] at (%.4f,%.4f) {$%s$};",
      nd.x - 0.35, nd.y, fmt_label(nd.label))
  end

  local function walk(nodes, px, py, path)
    for _, nd in ipairs(nodes) do
      edge(px, py, nd)
      local npath = {}
      for i, e in ipairs(path) do npath[i] = e end
      npath[#npath+1] = nd
      if #nd.children > 0 then
        walk(nd.children, nd.x + 0.35, nd.y, npath)
      elseif products then
        local labels, allnum, prod, chain = {}, true, 1, {}
        for _, e in ipairs(npath) do
          labels[#labels+1] = fmt_label(e.label)
          local v = tonumber(e.prob)
          if v then prod = prod * v else allnum = false end
          chain[#chain+1] = Math.mathlite(e.prob)
        end
        local rhs = allnum and Math.mathlite(fmt_num(prod))
                    or table.concat(chain, " \\times ")
        out[#out+1] = string.format(
          "\\node[right, font=\\footnotesize] at (%.4f,%.4f) {$P(%s) = %s$};",
          maxx + 0.9, nd.y, table.concat(labels, " \\cap "), rhs)
      end
    end
  end
  walk(roots, 0, rooty, {})

  out[#out+1] = "\\end{tikzpicture}\\end{center}"
  return table.concat(out, "\n")
end

return function(sl)
  sl.register_block("tree", function(api, words_str, inner)
    local products = false
    local ws = U.trim(words_str or "")
    if ws ~= "" then
      local attrs = U.parse_attrs(ws, {tag = "tree"})
      products = (attrs.products == "on")
    end
    local roots = parse_tree(inner)
    api.raw('emit(' .. string.format("%q", emit_tree(roots, products)) .. ")\n")
  end)
end
