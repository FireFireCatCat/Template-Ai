local U = require("texecole-util")

local M = {}

local function gcd(a, b)
  a, b = math.abs(a), math.abs(b)
  while b ~= 0 do a, b = b, a % b end
  return a
end

local function rat(n, d)
  d = d or 1
  if d == 0 then error("texecole: division by zero in a coefficient") end
  if d < 0 then n, d = -n, -d end
  local g = gcd(n, d)
  if g > 1 then n, d = n // g, d // g end
  return { n = n, d = d }
end

local function radd(a, b) return rat(a.n * b.d + b.n * a.d, a.d * b.d) end
local function rsub(a, b) return rat(a.n * b.d - b.n * a.d, a.d * b.d) end
local function rmul(a, b) return rat(a.n * b.n, a.d * b.d) end
local function rdiv(a, b) return rat(a.n * b.d, a.d * b.n) end
local function rneg(a)    return rat(-a.n, a.d) end
local function rcmp(a, b) return a.n * b.d - b.n * a.d end
local function rsign(a)   return a.n > 0 and 1 or (a.n < 0 and -1 or 0) end
local function rnum(a)    return a.n / a.d end

local function rstr(a)
  if a.d == 1 then return tostring(a.n) end
  return tostring(a.n) .. "/" .. tostring(a.d)
end

M.rat, M.radd, M.rsub, M.rmul, M.rdiv = rat, radd, rsub, rmul, rdiv
M.rneg, M.rcmp, M.rsign, M.rnum, M.rstr = rneg, rcmp, rsign, rnum, rstr

local function num_rat(tok)
  local w, f = tok:match("^(%d*)%.(%d+)$")
  if f then
    local scale = 1
    for _ = 1, #f do scale = scale * 10 end
    return rat(tonumber((w == "" and "0" or w) .. f), scale)
  end
  local i = tok:match("^(%d+)$")
  if i then return rat(tonumber(i)) end
  return nil
end

local function parse_affine(s, var)
  var = var or "x"
  local a, b = rat(0), rat(0)
  local i, n = 1, #s
  local sign, expect_term = 1, true
  while i <= n do
    local c = s:sub(i, i)
    if c:match("%s") then i = i + 1
    elseif c == "+" then sign = sign; i = i + 1; expect_term = true
    elseif c == "-" then sign = -sign; i = i + 1; expect_term = true
    else
      if not expect_term then
        return nil, "expected + or - before '" .. s:sub(i) .. "'"
      end

      local coef = rat(1)
      local numtok = s:match("^(%d+%.?%d*)", i)
      if numtok then
        coef = num_rat(numtok)
        i = i + #numtok
        local den = s:match("^%s*/%s*(%d+)", i)
        if den then
          coef = rdiv(coef, rat(tonumber(den)))
          i = i + #s:match("^(%s*/%s*%d+)", i)
        end
      end

      local j = i
      while j <= n and s:sub(j, j):match("%s") do j = j + 1 end
      if s:sub(j, j + #var - 1) == var
         and not s:sub(j + #var, j + #var):match("[%w_]") then
        a = radd(a, rat(sign * coef.n, coef.d))
        i = j + #var
      elseif numtok then
        b = radd(b, rat(sign * coef.n, coef.d))
      else
        return nil, "unexpected '" .. s:sub(i, i) .. "'"
      end
      sign, expect_term = 1, false
    end
  end
  if expect_term then return nil, "dangling sign" end
  return { a = a, b = b }
end

M.parse_affine = parse_affine

local function parse_product(s, var)
  var = var or "x"
  s = U.trim(s)

  do
    local af = parse_affine(s, var)
    if af then
      if rsign(af.a) == 0 then
        return { c = af.b, factors = {} }
      end
      return { c = rat(1), factors = {
        { a = af.a, b = af.b, mult = 1, den = false, label = s } } }
    end
  end

  local out = { c = rat(1), factors = {} }
  local i, n = 1, #s
  local den = false
  local sign = 1
  while i <= n do
    local c = s:sub(i, i)
    if c:match("%s") then i = i + 1
    elseif c == "*" then i = i + 1
    elseif c == "/" then den = true; i = i + 1
    elseif c == "-" and #out.factors == 0 and rcmp(out.c, rat(1)) == 0 and sign == 1 then
      sign = -1; i = i + 1
    elseif c == "(" then
      local grp = s:match("^(%b())", i)
      if not grp then return nil, "unclosed '(' " end
      local inner = grp:sub(2, -2)
      local af, err = parse_affine(inner, var)
      if not af then
        return nil, "the factor '(" .. inner .. ")' is not affine (" .. err .. ")"
      end
      i = i + #grp

      local mult = 1
      local p = s:match("^%s*%^%s*(%d+)", i)
      if p then
        mult = tonumber(p)
        i = i + #s:match("^(%s*%^%s*%d+)", i)
      end
      if rsign(af.a) == 0 then

        local k = af.b
        for _ = 2, mult do k = rmul(k, af.b) end
        if den then out.c = rdiv(out.c, k) else out.c = rmul(out.c, k) end
      else
        local label = "(" .. U.trim(inner) .. ")"
        if mult > 1 then label = label .. "^" .. mult end
        if mult == 1 then label = U.trim(inner) end
        out.factors[#out.factors + 1] =
          { a = af.a, b = af.b, mult = mult, den = den, label = label }
      end
      den = false
    else

      local numtok = s:match("^(%d+%.?%d*)", i)
      if numtok then
        local k = num_rat(numtok)
        i = i + #numtok
        if den then out.c = rdiv(out.c, k) else out.c = rmul(out.c, k) end
        den = false
      elseif s:sub(i, i + #var - 1) == var
             and not s:sub(i + #var, i + #var):match("[%w_]") then
        i = i + #var
        local mult = 1
        local p = s:match("^%s*%^%s*(%d+)", i)
        if p then
          mult = tonumber(p)
          i = i + #s:match("^(%s*%^%s*%d+)", i)
        end
        out.factors[#out.factors + 1] =
          { a = rat(1), b = rat(0), mult = mult, den = den,
            label = mult > 1 and (var .. "^" .. mult) or var }
        den = false
      else
        return nil, "unexpected '" .. s:sub(i, i) .. "'"
      end
    end
  end
  if sign == -1 then out.c = rneg(out.c) end
  if den then return nil, "a '/' with no denominator after it" end
  return out
end

M.parse_product = parse_product

function M.analyse(prod)
  local zeros = {}
  for _, f in ipairs(prod.factors) do
    local z = rdiv(rneg(f.b), f.a)
    local found
    for _, e in ipairs(zeros) do
      if rcmp(e.x, z) == 0 then found = e; break end
    end
    if not found then
      found = { x = z, den = false, nummult = 0 }
      zeros[#zeros + 1] = found
    end
    if f.den then found.den = true else found.nummult = found.nummult + f.mult end
  end
  table.sort(zeros, function(p, q) return rcmp(p.x, q.x) < 0 end)

  local function sign_at(x)
    local s = rsign(prod.c)
    for _, f in ipairs(prod.factors) do
      local v = radd(rmul(f.a, x), f.b)
      local sv = rsign(v)
      if sv == 0 then
        if f.den then
          error("texecole: the expression is not defined at x = " .. rstr(x))
        end
        return 0
      end
      if f.mult % 2 == 1 then s = s * sv end
    end
    return s
  end

  local pts = {}
  if #zeros == 0 then
    pts[1] = rat(0)
  else
    pts[1] = rsub(zeros[1].x, rat(1))
    for k = 1, #zeros - 1 do
      pts[#pts + 1] = rdiv(radd(zeros[k].x, zeros[k + 1].x), rat(2))
    end
    pts[#pts + 1] = radd(zeros[#zeros].x, rat(1))
  end
  local interval_signs = {}
  for _, p in ipairs(pts) do interval_signs[#interval_signs + 1] = sign_at(p) end

  return zeros, interval_signs, sign_at
end

return M
