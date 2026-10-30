local CALC = {}

local function gcd(a, b)
  a, b = math.abs(a), math.abs(b)
  while b ~= 0 do a, b = b, a % b end
  return a
end

local function frac(n, d)
  d = d or 1
  if d == 0 then error("texecole : division par zéro dans le calcul exact") end
  if d < 0 then n, d = -n, -d end
  local g = gcd(n, d)
  if g > 1 then n, d = n // g, d // g end
  return { n = n, d = d }
end

local function fadd(a, b) return frac(a.n * b.d + b.n * a.d, a.d * b.d) end
local function fsub(a, b) return frac(a.n * b.d - b.n * a.d, a.d * b.d) end
local function fmul(a, b) return frac(a.n * b.n, a.d * b.d) end
local function fdiv(a, b)
  if b.n == 0 then error("texecole : division par zéro dans le calcul exact") end
  return frac(a.n * b.d, a.d * b.n)
end
local function fzero(a) return a.n == 0 end

local function fparse(tok)
  local n, d = tok:match("^([+-]?%d+)%s*/%s*(%d+)$")
  if n then return frac(tonumber(n), tonumber(d)) end
  local int, dec = tok:match("^([+-]?%d+)%.(%d+)$")
  if int then
    local scale = 10 ^ #dec
    local whole = tonumber(int)
    local sign = (tok:sub(1, 1) == "-") and -1 or 1
    return frac(whole * scale + sign * tonumber(dec), scale)
  end
  local i = tok:match("^([+-]?%d+)$")
  if i then return frac(tonumber(i)) end
  return nil
end

local function fshow(a)
  if a.d == 1 then return tostring(a.n) end
  return string.format("\\tfrac{%d}{%d}", a.n, a.d)
end

CALC.frac, CALC.fadd, CALC.fsub, CALC.fmul, CALC.fdiv = frac, fadd, fsub, fmul, fdiv
CALC.fparse, CALC.fshow = fparse, fshow

local function parse_side(side, row, vars, sign)
  side = side:gsub("%s+", " "):gsub("^%s*", "")
  if side:sub(1, 1) ~= "+" and side:sub(1, 1) ~= "-" then
    side = "+" .. side
  end
  side = side:gsub("%s*([+-])%s*", "\0%1")
  for term in side:gmatch("%z([^%z]+)") do
    local s = (term:sub(1, 1) == "-") and -1 or 1
    local body = term:sub(2):gsub("%s+", "")
    local coef, var = body:match("^([%d%./]*)%*?([%a][%w_]*)$")
    if var then
      local c = (coef == "" ) and frac(1) or fparse(coef)
      if not c then
        error("texecole : coefficient illisible « " .. body
          .. " » dans le système (entiers, fractions p/q ou décimaux).")
      end
      c = frac(c.n * s * sign, c.d)
      if not vars[var] then
        vars[#vars + 1] = var
        vars[var] = #vars
      end
      row[vars[var]] = fadd(row[vars[var]] or frac(0), c)
    else
      local c = fparse(body)
      if not c then
        error("texecole : terme illisible « " .. body
          .. " » dans le système (le calcul exact ne connaît que les "
          .. "termes linéaires : 3a, -b, 1/2 c, constantes).")
      end
      row.rhs = fadd(row.rhs or frac(0), frac(c.n * -s * sign, c.d))
    end
  end
end

local function parse_system(content)
  local rows, vars = {}, {}
  for line in (content .. "\n"):gmatch("(.-)\n") do
    line = line:gsub("^%s+", ""):gsub("%s+$", "")
    if line ~= "" then
      local lhs, rhs = line:match("^(.-)=(.+)$")
      if not lhs then
        error("texecole : « " .. line .. " » n'est pas une équation "
          .. "(il manque le signe =).")
      end
      local row = {}
      parse_side(lhs, row, vars, 1)
      parse_side(rhs, row, vars, -1)
      row.rhs = row.rhs or frac(0)
      rows[#rows + 1] = row
    end
  end
  return rows, vars
end

local function show_system(A, vars, m, n)
  local out = { "\\(\\left\\{\\begin{aligned}" }
  for i = 1, m do
    local terms = {}
    for j = 1, n do
      local c = A[i][j]
      if c.n ~= 0 then
        local coef = ""
        if c.n == -1 and c.d == 1 then coef = "-"
        elseif not (c.n == 1 and c.d == 1) then coef = fshow(c) end
        local sign = (#terms > 0 and c.n > 0) and "+" or ""
        terms[#terms + 1] = sign .. coef .. vars[j]
      end
    end
    if #terms == 0 then terms[1] = "0" end
    out[#out + 1] = table.concat(terms, " ")
      .. " &= " .. fshow(A[i][n + 1])
      .. " && (L_{" .. i .. "})"
      .. (i < m and " \\\\" or "")
  end
  out[#out + 1] = "\\end{aligned}\\right.\\)"
  return table.concat(out, " ")
end

local function solve_linear(rows, vars, journal)
  local m, n = #rows, #vars
  local A = {}
  for i = 1, m do
    A[i] = {}
    for j = 1, n do A[i][j] = rows[i][j] or frac(0) end
    A[i][n + 1] = rows[i].rhs or frac(0)
  end

  local pivot_col_of_row = {}
  local r = 1
  for c = 1, n do
    local piv = nil
    for i = r, m do
      if not fzero(A[i][c]) then piv = i break end
    end
    if piv then
      A[r], A[piv] = A[piv], A[r]
      local p = A[r][c]
      for j = c, n + 1 do A[r][j] = fdiv(A[r][j], p) end
      local ops = {}
      for i = 1, m do
        if i ~= r and not fzero(A[i][c]) then
          local f = A[i][c]
          for j = c, n + 1 do
            A[i][j] = fsub(A[i][j], fmul(f, A[r][j]))
          end
          local fx = fshow(f)
          ops[#ops + 1] = "L_{" .. i .. "} \\gets L_{" .. i .. "} - "
            .. (fx == "1" and "" or (fx == "-1" and "-" or fx .. "\\,"))
            .. "L_{" .. r .. "}"
        end
      end
      pivot_col_of_row[r] = c
      if journal then
        local optxt = "Pivot sur \\(" .. vars[c] .. "\\) : \\(L_{" .. r
          .. "}\\) normalisée"
        if #ops > 0 then
          optxt = optxt .. ", puis \\(" .. table.concat(ops, ",\\; ")
            .. "\\)."
        else
          optxt = optxt .. "."
        end
        journal[#journal + 1] = { op = optxt,
          snap = show_system(A, vars, m, n) }
      end
      r = r + 1
      if r > m then break end
    end
  end

  for i = r, m do
    if fzero(A[i][n + 1]) == false then
      local allzero = true
      for j = 1, n do if not fzero(A[i][j]) then allzero = false break end end
      if allzero then return { kind = "none" } end
    end
  end

  local rank = r - 1
  if rank < n then
    return { kind = "many", rank = rank, nvars = n }
  end

  local sol = {}
  for i = 1, n do
    sol[vars[pivot_col_of_row[i]]] = A[i][n + 1]
  end
  return { kind = "one", sol = sol }
end

CALC.parse_system, CALC.solve_linear = parse_system, solve_linear

return function(sl)
  if not sl then return CALC end

  sl.register_block("solve", function(api, words, content)
    if type(content) == "table" then
      content = table.concat(content, "\n")
    end
    local rows, vars = parse_system(content)
    if #rows == 0 then
      error("texecole : <Résous> a reçu un système vide.")
    end
    local journal = tostring(words or ""):find("steps:on") and {} or nil
    local res = solve_linear(rows, vars, journal)
    if res.kind == "none" then
      api.lit("Le système n'admet \\emph{aucune} solution.")
      return
    end
    if res.kind == "many" then
      api.lit("Le système admet une \\emph{infinité} de solutions ("
        .. res.rank .. " équation" .. (res.rank > 1 and "s" or "")
        .. " indépendante" .. (res.rank > 1 and "s" or "")
        .. " pour " .. res.nvars .. " inconnues).")
      return
    end
    local parts = {}
    for _, v in ipairs(vars) do
      parts[#parts + 1] = v .. " = " .. fshow(res.sol[v])
    end
    local head = ""
    if journal then
      local st = {}
      for i, e in ipairs(journal) do
        st[#st + 1] = "\\par\\noindent\\textbf{Étape " .. i .. ".} "
          .. e.op .. "\\par " .. e.snap
      end
      head = table.concat(st, " ") .. "\\par\\noindent "
    end
    api.lit(head .. "La solution du système est \\(\\left("
      .. table.concat(parts, ",\\; ") .. "\\right)\\).")
  end)

  return CALC
end
