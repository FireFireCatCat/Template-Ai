local N = {}

local D = "(math.pi/180)"

N.FUNCS = {

  sin = "math.sin", cos = "math.cos", tan = "math.tan",
  cot = "(function(t) return math.cos(t)/math.sin(t) end)",
  sec = "(function(t) return 1/math.cos(t) end)",
  csc = "(function(t) return 1/math.sin(t) end)",

  sind = "(function(t) return math.sin(t*" .. D .. ") end)",
  cosd = "(function(t) return math.cos(t*" .. D .. ") end)",
  tand = "(function(t) return math.tan(t*" .. D .. ") end)",

  arcsin = "math.asin", arccos = "math.acos", arctan = "math.atan",
  asin = "math.asin", acos = "math.acos", atan = "math.atan",
  arcsind = "(function(t) return math.asin(t)/" .. D .. " end)",
  arccosd = "(function(t) return math.acos(t)/" .. D .. " end)",
  arctand = "(function(t) return math.atan(t)/" .. D .. " end)",

  sinh = "math.sinh", cosh = "math.cosh", tanh = "math.tanh",
  coth = "(function(t) return math.cosh(t)/math.sinh(t) end)",
  sech = "(function(t) return 1/math.cosh(t) end)",
  csch = "(function(t) return 1/math.sinh(t) end)",

  arcsinh = "(function(t) return math.log(t+math.sqrt(t*t+1)) end)",
  arccosh = "(function(t) return math.log(t+math.sqrt(t*t-1)) end)",
  arctanh = "(function(t) return 0.5*math.log((1+t)/(1-t)) end)",
  asinh = "(function(t) return math.log(t+math.sqrt(t*t+1)) end)",
  acosh = "(function(t) return math.log(t+math.sqrt(t*t-1)) end)",
  atanh = "(function(t) return 0.5*math.log((1+t)/(1-t)) end)",

  exp = "math.exp",
  ln  = "math.log",
  log = "(function(v) return math.log(v)/math.log(10) end)",
  log2 = "(function(v) return math.log(v)/math.log(2) end)",
  logb = "(function(v, b) return math.log(v)/math.log(b) end)",

  sqrt = "math.sqrt", cbrt = "(function(v) return (v<0 and -1 or 1)*math.abs(v)^(1/3) end)",
  abs = "math.abs", sign = "(function(v) return v>0 and 1 or v<0 and -1 or 0 end)",
  floor = "math.floor", ceil = "math.ceil", ent = "math.floor", E = "math.floor",
  nthroot = "(function(n, v) if v >= 0 then return v^(1/n) end if n % 2 == 1 then return -((-v)^(1/n)) end return 0/0 end)",
  round = "__round",
  min = "math.min", max = "math.max",
}

N.PREAMBLE = table.concat({
  "local __mabs, __mexp, __mlog = math.abs, math.exp, math.log",
  "if not math.sinh then",
  "  math.sinh = function(x) return (__mexp(x)-__mexp(-x))/2 end",
  "  math.cosh = function(x) return (__mexp(x)+__mexp(-x))/2 end",
  "  math.tanh = function(x) local a,b=__mexp(x),__mexp(-x) return (a-b)/(a+b) end",
  "end",

  "local __roundmt",
  "local function __round(x, d)",
  "  d = d or 0",
  "  local m = 10 ^ d",
  "  local r = (x >= 0) and math.floor(x*m + 0.5)/m or -math.floor(-x*m + 0.5)/m",
  "  return setmetatable({v = r, d = d}, __roundmt)",
  "end",

  "local function __u(a) return type(a)=='table' and a.v or a end",
  "__roundmt = {",
  "  __add=function(a,b) return __u(a)+__u(b) end,",
  "  __sub=function(a,b) return __u(a)-__u(b) end,",
  "  __mul=function(a,b) return __u(a)*__u(b) end,",
  "  __div=function(a,b) return __u(a)/__u(b) end,",
  "  __pow=function(a,b) return __u(a)^__u(b) end,",
  "  __unm=function(a) return -__u(a) end,",
  "  __eq=function(a,b) return __u(a)==__u(b) end,",
  "  __lt=function(a,b) return __u(a)<__u(b) end,",
  "  __le=function(a,b) return __u(a)<=__u(b) end,",
  "  __tostring=function(a) return tostring(a.v) end,",
  "}",
  "local pi = math.pi; local e = math.exp(1)",
}, "\n") .. "\n"

N.CONSTS = { pi = "math.pi", e = "math.exp(1)" }

function N.inject_locals()
  local out = {}

  local names = {}
  for k in pairs(N.FUNCS) do names[#names+1] = k end
  table.sort(names)
  for _, k in ipairs(names) do
    out[#out+1] = "local " .. k .. " = " .. N.FUNCS[k]
  end
  return N.PREAMBLE .. table.concat(out, "\n") .. "\n"
end

N.doc_precision = -1

function N.set_precision(p)
  N.doc_precision = (type(p) == "number") and p or -1
end

function N.display(v, sep, fallback_dec)
  sep = sep or "."
  if type(v) ~= "number" then
    if v == nil then return "" end
    return tostring(v)
  end
  local p = N.doc_precision
  if not p or p < 0 then p = fallback_dec end
  local s
  if p and p >= 0 then
    s = string.format("%." .. p .. "f", v)
    if s:find("%.") then s = s:gsub("0+$", ""):gsub("%.$", "") end
  else
    s = tostring(v)
  end
  return (s:gsub("%.", sep, 1))
end

return N
