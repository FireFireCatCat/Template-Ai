local U    = require("texecole-util")
local Math = require("texecole-math")

local function split_cells(line)
  local cells, buf, i, n, inmath = {}, {}, 1, #line, false
  local function flush()
    local w = U.trim(table.concat(buf)); buf = {}
    if w ~= "" then cells[#cells+1] = w end
  end
  while i <= n do
    local c = line:sub(i, i)
    if c == "$" then inmath = not inmath; buf[#buf+1] = c; i = i + 1
    elseif c == "|" and not inmath then
      if line:sub(i+1, i+1) == "|" then
        flush(); cells[#cells+1] = "||"; i = i + 2
      else
        flush(); i = i + 1
      end
    else
      buf[#buf+1] = c; i = i + 1
    end
  end
  flush()
  return cells
end

local function mathwrap(s)
  if s:find("%$") then return s end
  return "$" .. Math.mathlite(s) .. "$"
end

local function build_row(label, cells, nx, rowno)
  local signs, bound = {}, {}

  for _, c in ipairs(cells) do
    if c == "0" then
      if #signs == 0 then
        error("texecole: <signtab> row " .. rowno .. " starts with a 0; "
            .. "a zero sits at a boundary BETWEEN two signs")
      end
      bound[#signs] = "z"
    elseif c == "||" then
      bound[#signs] = "d"
    elseif c == "+" or c == "-" then
      signs[#signs+1] = c
    else
      error("texecole: <signtab> row " .. rowno .. " cell '" .. c
          .. "' is not a sign (+, -), a 0, or a double bar ||")
    end
  end
  if #signs ~= nx - 1 then
    error("texecole: <signtab> row " .. rowno .. " ('" .. label .. "') has "
        .. #signs .. " sign cells, " .. (nx - 1) .. " expected (one per interval)")
  end

  for k = 1, #signs - 1 do
    if signs[k] ~= signs[k+1] and not bound[k] then
      error("texecole: <signtab> row " .. rowno .. " ('" .. label .. "') "
          .. "changes sign between intervals " .. k .. " and " .. (k+1)
          .. " without a 0 or a || at the boundary; an expression cannot "
          .. "change sign without vanishing or ceasing to exist there")
    end
  end

  local tokens = { "" }
  for k = 1, #signs do
    tokens[#tokens+1] = signs[k]
    if k < #signs then tokens[#tokens+1] = bound[k] or "" end
  end
  tokens[#tokens+1] = ""
  return table.concat(tokens, ", ")
end

local function generate(xattr, rows)
  if not xattr then
    error("texecole: <signtab> needs an x:{...} list of abscissas")
  end
  local xcells = split_cells(xattr)
  local xs = {}
  for _, c in ipairs(xcells) do
    if c ~= "||" then xs[#xs+1] = mathwrap(c) end
  end
  if #xs < 2 then
    error("texecole: <signtab> x:{...} needs at least two abscissas")
  end
  if #rows == 0 then
    error("texecole: <signtab> needs at least one sign row (LABEL : cells)")
  end

  local rowdefs, rowbodies = {}, {}
  for rno, r in ipairs(rows) do
    rowdefs[#rowdefs+1] = mathwrap(r.label) .. " / 1"
    rowbodies[#rowbodies+1] = build_row(r.label, r.cells, #xs, rno)
  end

  local init = "$x$ / 1 , " .. table.concat(rowdefs, " , ")
  local out = {}
  out[#out+1] = "\\begin{center}\\begin{tikzpicture}"
  out[#out+1] = "\\tkzTabInit[espcl=2.2]{" .. init .. "}{"
              .. table.concat(xs, " , ") .. "}"
  for _, body in ipairs(rowbodies) do
    out[#out+1] = "\\tkzTabLine{" .. body .. "}"
  end
  out[#out+1] = "\\end{tikzpicture}\\end{center}"
  return table.concat(out)
end

return function(sl)

  local function auto_generate_sympy(expr, fname, var, raison)
    local slc = require("texecole")
    if not (slc.sympy and slc.sympy.signes) then
      error("texecole : <signtab> ne sait pas décomposer « " .. expr
          .. " » en facteurs affines (" .. tostring(raison) .. ") et le "
          .. "calcul automatique SymPy est indisponible — écrivez le "
          .. "tableau à la main avec la forme en bloc "
          .. "<signtab x:{...}>{ rangées }, ou installez python3 et SymPy "
          .. "(python3 -m pip install sympy) et compilez avec --shell-escape.")
    end
    local rows, err = slc.sympy.signes(expr, var)
    if not rows then error(err, 0) end
    local xs = {}
    for _, c in ipairs(split_cells(rows.x)) do
      if c == "-inf" then xs[#xs+1] = "$-\\infty$"
      elseif c == "+inf" or c == "inf" then xs[#xs+1] = "$+\\infty$"
      else xs[#xs+1] = mathwrap(c) end
    end
    local cells = split_cells(rows.cells)
    local body = build_row(fname, cells, #xs, 1)
    local init = "$" .. Math.mathlite(var) .. "$ / 1 , "
              .. mathwrap(fname) .. " / 1"
    local out = {}
    out[#out+1] = "\\begin{center}\\begin{tikzpicture}"
    out[#out+1] = "\\tkzTabInit[espcl=2.2]{" .. init .. "}{"
                .. table.concat(xs, " , ") .. "}"
    out[#out+1] = "\\tkzTabLine{" .. body .. "}"
    out[#out+1] = "\\end{tikzpicture}\\end{center}"
    return table.concat(out)
  end

  local function auto_generate(expr, fname, var)
    local A = require("texecole-affine")
    local prod, err = A.parse_product(expr, var)
    if not prod then
      return auto_generate_sympy(expr, fname, var, err)
    end
    if #prod.factors == 0 then
      error("texecole: <signtab> '" .. expr .. "' is constant; there is "
          .. "nothing to tabulate")
    end
    local zeros, isigns = A.analyse(prod)

    local xs = { "$-\\infty$" }
    for _, z in ipairs(zeros) do xs[#xs+1] = mathwrap(A.rstr(z.x)) end
    xs[#xs+1] = "$+\\infty$"

    local rowdefs, rowbodies = {}, {}
    local function add_row(label, cells)
      rowdefs[#rowdefs+1] = mathwrap(label) .. " / 1"
      rowbodies[#rowbodies+1] = build_row(label, cells, #xs, #rowdefs)
    end

    local single = (#prod.factors == 1 and prod.factors[1].mult == 1
                    and A.rcmp(prod.c, A.rat(1)) == 0)

    if not single then

      if A.rcmp(prod.c, A.rat(1)) ~= 0 then
        local cs = A.rsign(prod.c) > 0 and "+" or "-"
        local cells = {}
        for _ = 1, #zeros + 1 do cells[#cells+1] = cs end
        add_row(A.rstr(prod.c), cells)
      end
      for _, f in ipairs(prod.factors) do
        local fzero = A.rdiv(A.rneg(f.b), f.a)
        local cells = {}
        for k = 1, #zeros + 1 do

          local m
          if #zeros == 0 then m = A.rat(0)
          elseif k == 1 then m = A.rsub(zeros[1].x, A.rat(1))
          elseif k == #zeros + 1 then m = A.radd(zeros[#zeros].x, A.rat(1))
          else m = A.rdiv(A.radd(zeros[k-1].x, zeros[k].x), A.rat(2)) end
          local s = A.rsign(A.radd(A.rmul(f.a, m), f.b))
          if f.mult % 2 == 0 then s = 1 end
          cells[#cells+1] = (s > 0) and "+" or "-"
          if k <= #zeros and A.rcmp(zeros[k].x, fzero) == 0 then
            cells[#cells+1] = "0"
          end
        end
        add_row(f.label, cells)
      end
    end

    local cells = {}
    for k = 1, #isigns do
      cells[#cells+1] = (isigns[k] > 0) and "+" or "-"
      if k <= #zeros then
        cells[#cells+1] = zeros[k].den and "||"
          or (zeros[k].nummult > 0 and "0" or "||")
      end
    end
    add_row(fname, cells)

    local init = "$x$ / 1 , " .. table.concat(rowdefs, " , ")
    local out = {}
    out[#out+1] = "\\begin{center}\\begin{tikzpicture}"
    out[#out+1] = "\\tkzTabInit[espcl=2.2]{" .. init .. "}{"
                .. table.concat(xs, " , ") .. "}"
    for _, body in ipairs(rowbodies) do
      out[#out+1] = "\\tkzTabLine{" .. body .. "}"
    end
    out[#out+1] = "\\end{tikzpicture}\\end{center}"
    return table.concat(out)
  end

  sl.register_tag("signtab", function(api, words, content)
    local parts = {}
    for k = 2, #words do parts[#parts+1] = words[k] end
    local attrs = U.parse_attrs(U.trim(table.concat(parts, " ")), {
      tag = "signtab",
      hint = "expects a <fn> object name, or expr:{...} (and name:{f(x)})",
      on_bare = function(word, a)
        if not a._ref then a._ref = word; return true end
        return false
      end,
    })
    local expr, name = attrs.expr, attrs.name
    if attrs._ref then
      local obj = sl._objects and sl._objects[attrs._ref]
      if not (obj and obj.expr) then
        error("texecole: <signtab " .. attrs._ref .. "> needs  let "
            .. attrs._ref .. " = <fn expr:{...}>  defined first")
      end
      expr = obj.expr
      name = name or obj.name
    end
    if not expr then
      error("texecole: <signtab> tag form needs a <fn> object or expr:{...}; "
          .. "the block form <signtab x:{...}>{ rows } writes the rows by hand")
    end

    local fname, var = "f(x)", "x"
    if name then
      local f, v = name:match("^%s*([%a]%w*)%s*%(%s*([%a]%w*)%s*%)%s*$")
      if f then fname, var = f .. "(" .. v .. ")", v
      else
        local f2 = name:match("^%s*([%a]%w*)%s*$")
        if f2 then fname = f2 .. "(x)" end
      end
    end
    api.raw('emit(' .. string.format("%q",
      auto_generate(U.trim(expr), fname, var)) .. ")\n")
  end)

  sl.register_block("signtab", function(api, words_str, inner)
    local attrs = U.parse_attrs(U.trim(words_str or ""), {
      tag = "signtab", require_group = true,
      hint = "expects x:{...} then the sign rows in the block body",
    })
    local rows = {}
    for _, l in ipairs(inner) do
      if type(l) == "string" and l:match("%S") and not l:match("^%s*}%s*$") then
        local label, body = l:match("^%s*(.-)%s*:%s*(.-)%s*$")
        if not label or label == "" then
          error("texecole: <signtab> each row reads  LABEL : signs, got '"
              .. U.trim(l) .. "'")
        end
        rows[#rows+1] = { label = label, cells = split_cells(body) }
      end
    end
    api.raw('emit(' .. string.format("%q", generate(attrs.x, rows)) .. ")\n")
  end)
end
