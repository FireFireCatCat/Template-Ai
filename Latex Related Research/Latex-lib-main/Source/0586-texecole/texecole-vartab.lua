local U    = require("texecole-util")
local Math = require("texecole-math")

local function parse_attrs(s)
  return U.parse_attrs(s, {
    tag           = "vartab",
    require_group = true,
    hint          = "expects key:{...} options (x, deriv, var)",
  })
end

local function split_bar(line, keep_bars)
  local cells, buf, i, n, inmath = {}, {}, 1, #line, false
  local function flush() cells[#cells+1] = U.trim(table.concat(buf)); buf = {} end
  while i <= n do
    local c = line:sub(i, i)
    if c == "$" then
      inmath = not inmath; buf[#buf+1] = c; i = i + 1
    elseif c == "|" and not inmath then
      if line:sub(i+1, i+1) == "|" then
        if keep_bars then
          flush(); cells[#cells+1] = "||"; i = i + 2
        else
          buf[#buf+1] = "||"; i = i + 2
        end
      else
        flush(); i = i + 1
      end
    else
      buf[#buf+1] = c; i = i + 1
    end
  end
  flush()

  local out = {}
  for _, c in ipairs(cells) do
    if c ~= "" or not keep_bars then out[#out+1] = c end
  end
  return keep_bars and out or cells
end

local function render(cell)
  if cell == "" then return "{}" end
  if cell:match("^%$.*%$$") then return cell:sub(2, -2) end
  return Math.mathlite(cell)
end

local function mathwrap(cell)
  return "$" .. render(cell) .. "$"
end

local function build_deriv(cells, nx)

  local signs, barat = {}, {}
  for _, c in ipairs(cells) do
    if c == "||" then
      barat[#signs] = true
    elseif c == "+" or c == "-" or c == "0" or c == "" then
      signs[#signs+1] = c
    else
      error("texecole: <vartab> deriv cell '" .. c .. "' is not a sign "
          .. "(+, -, 0 or empty) nor a double bar ||")
    end
  end
  if #signs ~= nx - 1 then
    error("texecole: <vartab> deriv has " .. #signs .. " sign cells, "
        .. (nx-1) .. " expected (one per interval)")
  end

  local tokens = { "" }
  for k = 1, #signs do
    local cur = signs[k]
    tokens[#tokens+1] = (cur == "0") and "" or cur
    if k < #signs then
      if barat[k] then
        tokens[#tokens+1] = "d"
      else
        local nxt = signs[k+1]
        local changes = (cur == "+" and nxt == "-")
                     or (cur == "-" and nxt == "+")
                     or (cur == "0") or (nxt == "0")
        tokens[#tokens+1] = changes and "z" or ""
      end
    end
  end
  tokens[#tokens+1] = ""
  return table.concat(tokens, ", ")
end

local function lex_var(tokens, rowno)

  local segs = { { values = {}, arrows = {} } }
  local expect_value = true
  for _, t in ipairs(tokens) do
    if t == "/" or t == "\\" then
      if expect_value then
        error("texecole: <vartab> var row " .. rowno .. " has an arrow '" .. t
            .. "' where a value was expected")
      end
      segs[#segs].arrows[#segs[#segs].arrows+1] = t
      expect_value = true
    elseif t == "||" then

      segs[#segs+1] = { values = {}, arrows = {} }
      expect_value = true
    else

      segs[#segs].values[#segs[#segs].values+1] = t
      expect_value = false
    end
  end
  return segs
end

local function seg_heights(seg, rowno)
  local v, a = seg.values, seg.arrows
  local h = {}
  if #v == 0 then return h end
  if #a ~= #v - 1 then
    error("texecole: <vartab> var row " .. rowno .. " segment must alternate "
        .. "value, arrow, value (got " .. #v .. " values, " .. #a .. " arrows)")
  end
  if #v == 1 then
    h[1] = "?"
    return h
  end

  h[1] = (a[1] == "/") and "-" or "+"
  for i = 2, #v - 1 do
    local ain, aout = a[i-1], a[i]
    if ain == aout then
      error("texecole: <vartab> has a value between two '"
          .. (ain == "/" and "/" or "\\") .. "' arrows (same direction); a "
          .. "variation table lists only bounds and extrema, not intermediate "
          .. "points. Remove that value (and its abscissa); a point like "
          .. "f(0)=1 belongs on the plot, not the table.")
    elseif ain == "/" and aout == "\\" then
      h[i] = "+"
    else
      h[i] = "-"
    end
  end
  h[#v] = (a[#a] == "/") and "+" or "-"
  return h
end

local function build_var(line, rowno)

  local tokens = {}
  local i, n, buf, inmath = 1, #line, {}, false
  local function flush()
    local w = U.trim(table.concat(buf)); buf = {}
    if w ~= "" then tokens[#tokens+1] = w end
  end
  while i <= n do
    local c = line:sub(i, i)
    if c == "$" then inmath = not inmath; buf[#buf+1] = c; i = i + 1
    elseif not inmath and c == "|" and line:sub(i+1, i+1) == "|" then
      flush(); tokens[#tokens+1] = "||"; i = i + 2
    elseif not inmath and (c == "/" or c == "\\")
           and (i == 1 or line:sub(i-1, i-1):match("%s"))
           and (i == n or line:sub(i+1, i+1):match("%s")) then

      flush(); tokens[#tokens+1] = c; i = i + 1
    elseif not inmath and c:match("%s") then
      flush(); i = i + 1
    else
      buf[#buf+1] = c; i = i + 1
    end
  end
  flush()

  local segs = lex_var(tokens, rowno)

  for _, seg in ipairs(segs) do
    seg.heights = seg_heights(seg, rowno)
  end

  for _, seg in ipairs(segs) do
    for k, hh in ipairs(seg.heights) do
      if hh == "?" then seg.heights[k] = "+" end
    end
  end

  local out = {}
  for si, seg in ipairs(segs) do
    local v, h = seg.values, seg.heights
    for k = 1, #v do
      local isLast  = (k == #v)
      local isFirst = (k == 1)
      local height  = h[k]
      local valtex  = mathwrap(v[k])

      if isLast and si < #segs then

        local nxt = segs[si+1]
        if #nxt.values > 0 then
          local lh = height
          local rh = nxt.heights[1]
          local rtex = mathwrap(nxt.values[1])
          local code = lh .. "D" .. rh
          out[#out+1] = code .. "/" .. valtex .. "/" .. rtex
          nxt._consumed_first = true
        else

          out[#out+1] = (height .. "D") .. "/" .. valtex
        end
      elseif isFirst and si > 1 and segs[si]._consumed_first then

      else
        out[#out+1] = height .. "/" .. valtex
      end
    end
  end

  return table.concat(out, ", ")
end

local function labels(name)
  local fn, var = "f", "x"
  if name and name ~= "" then
    local f, v = name:match("^%s*([%a]%w*)%s*%(%s*([%a]%w*)%s*%)%s*$")
    if f then
      fn, var = f, v
    else
      local f2 = name:match("^%s*([%a]%w*)%s*$")
      if f2 then fn = f2
      else
        error("texecole: <vartab> name:{...} must be a function name like "
            .. "g or g(t), got '" .. name .. "'")
      end
    end
  end
  return Math.mathlite(var),
         Math.mathlite(fn) .. "'(" .. Math.mathlite(var) .. ")",
         Math.mathlite(fn) .. "(" .. Math.mathlite(var) .. ")",
         Math.mathlite(fn) .. "''(" .. Math.mathlite(var) .. ")"
end

local function generate(attrs)
  if not attrs.x then
    do

      local slc = require("texecole")
      local varname = "x"
      if attrs.name then
        varname = attrs.name:match("%((%a[%w_]*)%)") or "x"
      end
      if slc.sympy and attrs.expr then
        local rows, err = slc.sympy.variations(attrs.expr, varname)
        if not rows then error(err, 0) end
        attrs.x, attrs.deriv, attrs.var = rows.x, rows.deriv, rows.var
      else
        error("texecole: <vartab> needs an x:{...} list of abscissas"
          .. " — ou laissez texecole le calculer tout seul : il faut"
          .. " python3, SymPy (python3 -m pip install sympy) et la"
          .. " compilation avec --shell-escape")
      end
    end
  end
  if not attrs.var then
    error("texecole: <vartab> needs a var:{...} variation list")
  end

  local xlabel, dlabel, flabel, ddlabel = labels(attrs.name)

  local xcells = split_bar(attrs.x, false)
  local xs = {}
  for _, c in ipairs(xcells) do xs[#xs+1] = mathwrap(c) end
  if #xs < 2 then
    error("texecole: <vartab> x:{...} needs at least two abscissas")
  end

  local rowdefs, rowbodies = {}, {}

  if attrs.second then
    local scells = split_bar(attrs.second, true)
    rowdefs[#rowdefs+1] = "$" .. ddlabel .. "$ / 1"
    rowbodies[#rowbodies+1] = { kind = "line", body = build_deriv(scells, #xs) }
  end
  if attrs.deriv then
    local dcells = split_bar(attrs.deriv, true)
    rowdefs[#rowdefs+1] = "$" .. dlabel .. "$ / 1"
    rowbodies[#rowbodies+1] = { kind = "line", body = build_deriv(dcells, #xs) }
  end
  rowdefs[#rowdefs+1] = "$" .. flabel .. "$ / 2.6"
  rowbodies[#rowbodies+1] = { kind = "var", body = build_var(attrs.var, 1) }

  local init  = "$" .. xlabel .. "$ / 1 , " .. table.concat(rowdefs, " , ")
  local xlist = table.concat(xs, " , ")

  local out = {}
  out[#out+1] = "\\begin{center}\\begin{tikzpicture}"
  out[#out+1] = "\\tkzTabInit[espcl=2.2]{" .. init .. "}{" .. xlist .. "}"
  for _, rb in ipairs(rowbodies) do
    if rb.kind == "line" then
      out[#out+1] = "\\tkzTabLine{" .. rb.body .. "}"
    else
      out[#out+1] = "\\tkzTabVar{" .. rb.body .. "}"
    end
  end
  out[#out+1] = "\\end{tikzpicture}\\end{center}"
  return table.concat(out)
end

return function(sl)

  sl.fn_parse = function(inner)
    inner = U.trim(inner or "")
    inner = inner:gsub("|([^|]+)|", "abs(%1)")
    inner = inner:gsub("racine%s*%[%s*(%d+)%s*%]%s*%(", "nthroot(%1, ")
    inner = inner:gsub("sqrt%s*%[%s*(%d+)%s*%]%s*%(", "nthroot(%1, ")
    local fname, fvar, tail =
      inner:match("^([%a_][%w_]*)%s*%(%s*([%a_][%w_]*[%w_%s,]-)%s*%)%s*(.*)$")
    if not fname then
      return parse_attrs(inner)
    end

    if not tail:match("^=") then
      if tail ~= "" and not tail:match("^[%a_][%w_]*:") then
        error("texecole: <fn " .. fname .. "(" .. fvar .. ") ...> expects "
            .. "either  = expression  or table attributes (x:, deriv:, var:)")
      end
      local attrs = parse_attrs(U.trim(tail))
      if attrs.name or attrs.expr then
        error("texecole: <fn> takes either the head form  " .. fname .. "("
            .. fvar .. ")  or name:/expr: attributes, not both")
      end
      attrs.name = fname .. "(" .. fvar .. ")"
      return attrs
    end
    local tail2 = U.trim(tail:sub(2))

    local p = tail2:find("%f[%S][%a_][%w_]*:")
    local expr, attrstr
    if p then
      expr, attrstr = U.trim(tail2:sub(1, p - 1)), tail2:sub(p)
    else
      expr, attrstr = tail2, ""
    end
    if expr == "" then
      error("texecole: <fn " .. fname .. "(" .. fvar .. ") = ...> has an "
          .. "empty right-hand side")
    end
    local attrs = parse_attrs(U.trim(attrstr))
    if attrs.name or attrs.expr then
      error("texecole: <fn> takes either the equation form  " .. fname .. "("
          .. fvar .. ") = ...  or name:/expr: attributes, not both")
    end
    attrs.name = fname .. "(" .. fvar .. ")"
    attrs.expr = expr
    return attrs
  end

  sl.register_tag("vartab", function(api, words, content)

    local parts = {}
    for k = 2, #words do parts[#parts+1] = words[k] end

    local attrs
    if #parts == 1 and not parts[1]:find(":", 1, true)
       and sl._objects and sl._objects[parts[1]] then
      attrs = sl._objects[parts[1]]
    elseif #parts == 1 and not parts[1]:find(":", 1, true) then
      error("texecole: <vartab " .. parts[1] .. "> refers to an object that "
          .. "is not defined; write  let " .. parts[1]
          .. " = <fn ...>  first, or give x:{...} var:{...} inline")
    else
      attrs = parse_attrs(U.trim(table.concat(parts, " ")))
    end

    api.raw('emit(' .. string.format("%q", generate(attrs)) .. ")\n")
  end)
end
