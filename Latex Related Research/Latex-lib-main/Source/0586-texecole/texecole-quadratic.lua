local U = require("texecole-util")

local function pgcd(a, b)
  a, b = math.abs(a), math.abs(b)
  while b ~= 0 do a, b = b, a % b end
  return a
end

local function rat(n, d)
  d = d or 1
  if d == 0 then error("texecole : division par zéro dans un coefficient.", 0) end
  if d < 0 then n, d = -n, -d end
  local g = pgcd(n, d)
  if g > 1 then n, d = n // g, d // g end
  return { n = n, d = d }
end

local function radd(a, b) return rat(a.n * b.d + b.n * a.d, a.d * b.d) end
local function rsub(a, b) return rat(a.n * b.d - b.n * a.d, a.d * b.d) end
local function rmul(a, b) return rat(a.n * b.n, a.d * b.d) end
local function rdiv(a, b)
  if b.n == 0 then error("texecole : division par zéro dans un coefficient.", 0) end
  return rat(a.n * b.d, a.d * b.n)
end
local function rnum(a) return a.n / a.d end

local function carre_parfait(x)
  if x < 0 then return nil end
  local r = math.floor(math.sqrt(x) + 0.5)
  if r * r == x then return r end
  return nil
end

local function rsqrt(a)
  local rn = carre_parfait(a.n)
  local rd = carre_parfait(a.d)
  if rn and rd then return rat(rn, rd) end
  return nil
end

local function tex_rat(a)
  if a.d == 1 then return tostring(a.n) end
  if a.n < 0 then return "-\\frac{" .. (-a.n) .. "}{" .. a.d .. "}" end
  return "\\frac{" .. a.n .. "}{" .. a.d .. "}"
end

local function tex_rat_par(a)
  local s = tex_rat(a)
  if a.n < 0 then return "\\left(" .. s .. "\\right)" end
  return s
end

local function lire_rat(s)
  s = s:gsub("%s", ""):gsub(",", ".")
  if s == "" or s == "+" then return rat(1) end
  if s == "-" then return rat(-1) end
  local signe = 1
  if s:sub(1, 1) == "-" then signe = -1; s = s:sub(2)
  elseif s:sub(1, 1) == "+" then s = s:sub(2) end
  local e, f = s:match("^(%d*)%.(%d+)$")
  if e then
    local n = tonumber((e == "" and "0" or e) .. f)
    local d = 1
    for _ = 1, #f do d = d * 10 end
    return rat(signe * n, d)
  end
  local n = tonumber(s)
  if not n or n ~= math.floor(n) then return nil end
  return rat(signe * math.tointeger(n))
end

local function lire_trinome(src, var)
  local s = U.trim(src):gsub("%s+", "")
  s = s:gsub("%*", ""):gsub("²", "^2")
  local a, b, c = rat(0), rat(0), rat(0)
  local i, n = 1, #s
  local vu = false
  while i <= n do
    local j = i + 1
    while j <= n and not (s:sub(j, j) == "+" or s:sub(j, j) == "-") do j = j + 1 end
    local terme = s:sub(i, j - 1)
    if terme ~= "" then
      local coef, deg
      local t2 = terme:match("^(.-)" .. var .. "%^2$")
      if t2 then coef, deg = t2, 2 end
      if not coef then
        local t1 = terme:match("^(.-)" .. var .. "$")
        if t1 then coef, deg = t1, 1 end
      end
      if not coef then coef, deg = terme, 0 end
      local v = lire_rat(coef)
      if not v then return nil, terme end
      if deg == 2 then a = radd(a, v)
      elseif deg == 1 then b = radd(b, v)
      else c = radd(c, v) end
      vu = true
    end
    i = j
  end
  if not vu then return nil, s end
  return a, b, c
end

local function tex_coef(v, var, deg, premier)
  if v.n == 0 then return "" end
  local signe = (v.n < 0) and "-" or (premier and "" or "+")
  local abs = rat(math.abs(v.n), v.d)
  local corps
  if deg == 0 then
    corps = tex_rat(abs)
  elseif abs.n == 1 and abs.d == 1 then
    corps = var .. (deg == 2 and "^2" or "")
  else
    corps = tex_rat(abs) .. var .. (deg == 2 and "^2" or "")
  end
  return signe .. corps
end

local function tex_trinome(a, b, c, var)
  local out = tex_coef(a, var, 2, true)
  out = out .. tex_coef(b, var, 1, out == "")
  out = out .. tex_coef(c, var, 0, out == "")
  if out == "" then out = "0" end
  return out
end

local function facteur(var, r)
  if r.n == 0 then return var end
  local s = tex_rat(rat(-r.n, r.d))
  if r.n > 0 then return "\\left(" .. var .. " - " .. tex_rat(r) .. "\\right)" end
  return "\\left(" .. var .. " + " .. tex_rat(rat(-r.n, r.d)) .. "\\right)"
end

local function coefficient_devant(a, expr)
  if a.d == 1 and a.n == 1 then return expr end
  if a.d == 1 and a.n == -1 then return "-" .. expr end
  return tex_rat(a) .. expr
end

local function etudier(src, var)
  local a, b, c = lire_trinome(src, var)
  if not a then
    error("texecole : « " .. U.trim(src) .. " » ne se lit pas comme un "
        .. "trinôme du second degré en " .. var .. " ; écrivez par exemple "
        .. "2" .. var .. "^2 - 3" .. var .. " + 1.", 0)
  end
  if a.n == 0 then
    error("texecole : « " .. U.trim(src) .. " » n'a pas de terme en "
        .. var .. "^2 : ce n'est pas un trinôme du second degré.", 0)
  end

  local p = tex_trinome(a, b, c, var)
  local delta = rsub(rmul(b, b), rmul(rat(4), rmul(a, c)))
  local alpha = rdiv(rat(-b.n, b.d), rmul(rat(2), a))
  local beta = rdiv(rat(-delta.n, delta.d), rmul(rat(4), a))

  local L = {}
  L[#L+1] = "Soit $P(" .. var .. ") = " .. p .. "$."
  L[#L+1] = "\\par Le discriminant vaut $\\Delta = b^2 - 4ac$."
  L[#L+1] = "\\par Ici, $\\Delta = "
          .. tex_rat_par(b) .. "^2 - 4 \\times " .. tex_rat_par(a)
          .. " \\times " .. tex_rat_par(c) .. " = " .. tex_rat(delta) .. "$."

  if delta.n > 0 then
    local r = rsqrt(delta)
    if r then
      local x1 = rdiv(rsub(rat(-b.n, b.d), r), rmul(rat(2), a))
      local x2 = rdiv(radd(rat(-b.n, b.d), r), rmul(rat(2), a))
      if rnum(x1) > rnum(x2) then x1, x2 = x2, x1 end
      L[#L+1] = "\\par Comme $\\Delta > 0$, le trinôme admet deux racines : $"
              .. var .. "_1 = " .. tex_rat(x1) .. "$ et $"
              .. var .. "_2 = " .. tex_rat(x2) .. "$."
      L[#L+1] = "\\par Il se factorise en $P(" .. var .. ") = "
              .. coefficient_devant(a, facteur(var, x1) .. facteur(var, x2)) .. "$."
    else
      local d = rnum(delta)
      local x1 = (-rnum(b) - math.sqrt(d)) / (2 * rnum(a))
      local x2 = (-rnum(b) + math.sqrt(d)) / (2 * rnum(a))
      if x1 > x2 then x1, x2 = x2, x1 end
      L[#L+1] = "\\par Comme $\\Delta > 0$, le trinôme admet deux racines : $"
              .. var .. "_{1,2} = \\dfrac{" .. tex_rat(rat(-b.n, b.d))
              .. " \\pm \\sqrt{" .. tex_rat(delta) .. "}}{"
              .. tex_rat(rmul(rat(2), a)) .. "}$, soit environ $"
              .. string.format("%.3f", x1):gsub("%.", "{,}") .. "$ et $"
              .. string.format("%.3f", x2):gsub("%.", "{,}") .. "$."
    end
  elseif delta.n == 0 then
    local x0 = alpha
    L[#L+1] = "\\par Comme $\\Delta = 0$, le trinôme admet une racine double $"
            .. var .. "_0 = " .. tex_rat(x0) .. "$."
    L[#L+1] = "\\par Il se factorise en $P(" .. var .. ") = "
            .. coefficient_devant(a, facteur(var, x0) .. "^2") .. "$."
  else
    L[#L+1] = "\\par Comme $\\Delta < 0$, le trinôme n'admet aucune racine "
            .. "réelle : il garde partout le signe de $a = " .. tex_rat(a) .. "$."
  end

  local reste = ""
  if beta.n ~= 0 then
    reste = (beta.n > 0 and " + " or " - ") .. tex_rat(rat(math.abs(beta.n), beta.d))
  end
  L[#L+1] = "\\par Sa forme canonique est $P(" .. var .. ") = "
          .. coefficient_devant(a, facteur(var, alpha) .. "^2") .. reste .. "$."

  return table.concat(L, "\n")
end

return function(sl)
  local corps_quadratic = function(api, words_str, inner)
    local var = "x"
    for w in (words_str or ""):gmatch("%S+") do
      local cle, val = w:match("^([%a_]+):(.+)$")
      if cle == "var" then
        var = val
      else
        error("texecole : « second degré » ne connaît pas l'attribut « "
            .. w .. " » ; seule la variable se précise, "
            .. "« en t » par exemple.", 0)
      end
    end
    local lignes = {}
    for _, l in ipairs(inner) do
      if type(l) == "string" and l:match("%S") and not l:match("^%s*}%s*$") then
        lignes[#lignes+1] = U.trim(l)
      end
    end
    if #lignes == 0 then
      error("texecole : « second degré » attend un trinôme dans son corps, "
          .. "par exemple 2x^2 - 3x + 1.", 0)
    end
    local sorties = {}
    for _, l in ipairs(lignes) do sorties[#sorties+1] = etudier(l, var) end
    api.raw("emit(" .. string.format("%q", table.concat(sorties, "\n\\par\\medskip\n")) .. ")\n")
  end
  sl.register_block("quadratic", corps_quadratic)
  sl.register_tag("quadratic", function(api, w, content, words_str)
    local ws = (words_str or ""):gsub("^%s*%S+%s*", "", 1)
    corps_quadratic(api, ws, { content or "" })
  end)
end
