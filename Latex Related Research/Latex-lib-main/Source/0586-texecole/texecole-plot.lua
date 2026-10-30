local U = require("texecole-util")
local NUMEVAL = require("texecole-numeval")

local function parse_attrs(s)
  return U.parse_attrs(s, {
    tag  = "plot",
    hint = "expects a function object name then key:{...} options",
    on_bare = function(word, attrs)
      if not attrs._ref then
        attrs._ref = word
      else
        attrs._refs = attrs._refs or {}
        attrs._refs[#attrs._refs + 1] = word
      end
      return true
    end,
  })
end

local function num_bound(tok, what)
  tok = U.trim(tok)
  if tok:match("inf") then
    error("texecole: <plot> " .. what .. " bound cannot be infinite ('"
        .. tok .. "'); give a finite display window, e.g. x:{-3, 3}")
  end
  return tok
end

local TRIG = { sin=true, cos=true, tan=true, cot=true, sec=true, csc=true }

local INVTRIG = { arcsin=true, arccos=true, arctan=true,
                  asin=true, acos=true, atan=true }

local PGF = {
  ent = "floor",
  E = "floor",
  sin="sin", cos="cos", tan="tan", cot="cot", sec="sec", csc="cosec",
  arcsin="asin", arccos="acos", arctan="atan",
  asin="asin", acos="acos", atan="atan",
  sinh="sinh", cosh="cosh", tanh="tanh",
  exp="exp", sqrt="sqrt", abs="abs",
}

local PGF_COMPOSED = {
  coth = "(cosh(%s)/sinh(%s))", sech = "(1/cosh(%s))", csch = "(1/sinh(%s))",
  arcsinh = "ln(%s + sqrt((%s)^2 + 1))",
  arccosh = "ln(%s + sqrt((%s)^2 - 1))",
  arctanh = "(0.5*ln((1 + %s)/(1 - %s)))",
  asinh = "ln(%s + sqrt((%s)^2 + 1))",
  acosh = "ln(%s + sqrt((%s)^2 - 1))",
  atanh = "(0.5*ln((1 + %s)/(1 - %s)))",
  log2 = "(ln(%s)/ln(2))", cbrt = "(sign(%s)*abs(%s)^(1/3))",
  sind = "sin(%s)", cosd = "cos(%s)", tand = "tan(%s)",
}

local function translate(expr, var)
  if var ~= "x" then
    expr = expr:gsub("([%a_]?)(" .. var .. ")([%w_]?)", function(a, m, b)
      if a == "" and b == "" then return "x" else return a .. m .. b end
    end)
  end

  local out, i, n = {}, 1, #expr
  while i <= n do
    local word = expr:match("^(%a+)", i)
    if word then
      i = i + #word
      if expr:sub(i, i) == "(" then
        local depth, j = 0, i
        while j <= n do
          local c = expr:sub(j, j)
          if c == "(" then depth = depth + 1
          elseif c == ")" then depth = depth - 1; if depth == 0 then break end end
          j = j + 1
        end
        local arg = expr:sub(i + 1, j - 1)
        local targ = translate(arg, "x")
        if TRIG[word] then

          out[#out+1] = PGF[word] .. "(deg(" .. targ .. "))"
        elseif INVTRIG[word] then

          out[#out+1] = "rad(" .. PGF[word] .. "(" .. targ .. "))"
        elseif word == "arcsind" or word == "arccosd" or word == "arctand" then
          out[#out+1] = PGF[word:sub(1,-2)] .. "(" .. targ .. ")"
        elseif word == "ln" then
          out[#out+1] = "ln(" .. targ .. ")"
        elseif word == "log" then
          out[#out+1] = "log10(" .. targ .. ")"
        elseif word == "logb" then

          local cut
          local d = 0
          for p = 1, #targ do
            local c = targ:sub(p,p)
            if c == "(" then d = d + 1 elseif c == ")" then d = d - 1
            elseif c == "," and d == 0 then cut = p; break end
          end
          if cut then
            out[#out+1] = "(ln(" .. targ:sub(1, cut-1) .. ")/ln("
                       .. targ:sub(cut+1) .. "))"
          else
            out[#out+1] = "ln(" .. targ .. ")"
          end
        elseif PGF_COMPOSED[word] then
          local tmpl = PGF_COMPOSED[word]
          out[#out+1] = tmpl:gsub("%%s", (targ:gsub("%%", "%%%%")))
        elseif PGF[word] then
          out[#out+1] = PGF[word] .. "(" .. targ .. ")"
        else
          out[#out+1] = word .. "(" .. targ .. ")"
        end
        i = j + 1
      else
        out[#out+1] = word
      end
    else
      out[#out+1] = expr:sub(i, i)
      i = i + 1
    end
  end
  local result = table.concat(out)

  result = result:gsub("log10%(", "\1("):gsub("log2%(", "\2(")
  result = result:gsub("(%d)([%a%(])", "%1*%2")
  result = result:gsub("(%))([%w%(])", "%1*%2")
  result = result:gsub("\1%(", "log10("):gsub("\2%(", "log2(")
  return result
end

local function implicit_mult(expr, var)
  if var and var ~= "x" then
    expr = expr:gsub("([%a_]?)(" .. var .. ")([%w_]?)", function(a, m, b)
      if a == "" and b == "" then return "x" else return a .. m .. b end
    end)
  end
  expr = expr:gsub("(%d)([%a%(])", "%1*%2")
  expr = expr:gsub("(%))([%w%(])", "%1*%2")
  return expr
end

local function compile_num(expr, var)
  local e = implicit_mult(U.trim(expr), var or "x")
  local chunk, err = load(
    NUMEVAL.inject_locals()
    .. "return function(x) return " .. e .. " end")
  if not chunk then
    error("texecole: <plot> cannot evaluate expr '" .. expr .. "' ("
        .. tostring(err) .. ")")
  end
  return chunk()
end

local function hwindow(attrs, obj)
  if attrs.x then
    local a, b = attrs.x:match("^%s*(.-)%s*,%s*(.-)%s*$")
    if not a then
      error("texecole: <plot> x:{a, b} needs two bounds separated by a comma")
    end
    return num_bound(a, "x"), num_bound(b, "x")
  end
  if not (obj and obj.x) then
    error("texecole: <plot> needs an x:{a, b} window (or a referenced "
        .. "object carrying abscissas)")
  end
  local cells = {}
  for c in (obj.x .. "|"):gmatch("(.-)|") do
    c = U.trim(c)
    if c ~= "" then cells[#cells+1] = c end
  end
  local lo, hi
  for _, c in ipairs(cells) do
    if not c:match("inf") then lo = lo or c; hi = c end
  end
  if not lo then
    error("texecole: <plot> cannot infer a finite x window from the table; "
        .. "give x:{a, b} explicitly")
  end
  return num_bound(lo, "x"), num_bound(hi, "x")
end

local function param_window(val, what)
  local a, b = val:match("^%s*(.-)%s*,%s*(.-)%s*$")
  if not a then
    error("texecole: <plot> " .. what .. ":{a, b} needs two bounds separated by a comma")
  end
  return translate(U.trim(a), "@none"), translate(U.trim(b), "@none")
end

local function pen(attrs)
  local c = (attrs and attrs.color) or "Blue"
  local w = (attrs and attrs.thickness) and ("line width=" .. attrs.thickness .. "pt")
            or "thick"
  return c .. ", " .. w
end

local function plot_curve(api, attrs, obj, kind, fn)
  local pvar = (kind == "polar") and "theta" or "t"
  local wattr = attrs[pvar] or (kind == "polar" and attrs.t) or attrs.t
  if not wattr then
    error("texecole: <plot kind:" .. kind .. "> needs a parameter window "
        .. pvar .. ":{a, b}  (e.g. " .. pvar .. ":{0, 2pi})")
  end
  local pa, pb = param_window(wattr, pvar)

  local samples = attrs.samples or "200"
  local axisopts = {}
  axisopts[#axisopts+1] = "width=10cm, height=7cm"
  axisopts[#axisopts+1] = "axis lines=middle"
  axisopts[#axisopts+1] = "axis equal=true"
  axisopts[#axisopts+1] = "every tick label/.append style={"
                       .. "fill=white, inner sep=1pt, font=\\footnotesize}"
  axisopts[#axisopts+1] = "axis line style={shorten >=-6pt}"
  axisopts[#axisopts+1] = "xlabel=$x$"
  axisopts[#axisopts+1] = "ylabel=$y$"
  axisopts[#axisopts+1] = "xlabel style={at={(ticklabel* cs:1)}, anchor=west}"
  axisopts[#axisopts+1] = "ylabel style={at={(ticklabel* cs:1)}, anchor=south west}"
  if attrs.x then
    local a, b = attrs.x:match("^%s*(.-)%s*,%s*(.-)%s*$")
    if a then axisopts[#axisopts+1] = "xmin=" .. U.trim(a) .. ", xmax=" .. U.trim(b) end
  end
  if attrs.y then
    local c, d = attrs.y:match("^%s*(.-)%s*,%s*(.-)%s*$")
    if c then axisopts[#axisopts+1] = "ymin=" .. U.trim(c) .. ", ymax=" .. U.trim(d) end
  end
  axisopts[#axisopts+1] = "samples=" .. samples

  local addplot
  if kind == "parametric" then

    local raw = U.trim(obj.expr)
    local depth, cut = 0, nil
    for i = 1, #raw do
      local c = raw:sub(i, i)
      if c == "(" or c == "{" then depth = depth + 1
      elseif c == ")" or c == "}" then depth = depth - 1
      elseif c == "," and depth == 0 then cut = i; break end
    end
    if not cut then
      error("texecole: <plot kind:parametric> needs expr:{x(t), y(t)} — "
          .. "two comma-separated components")
    end

    local xt = translate(U.trim(raw:sub(1, cut - 1)), pvar)
    local yt = translate(U.trim(raw:sub(cut + 1)), pvar)
    axisopts[#axisopts+1] = "variable=\\x"
    addplot = "\\addplot[" .. pen(attrs) .. ", domain=" .. pa .. ":" .. pb
            .. ", samples=" .. samples .. "] ({" .. xt .. "}, {" .. yt .. "});"
  else

    local r = translate(U.trim(obj.expr), pvar)
    axisopts[#axisopts+1] = "variable=\\x"
    addplot = "\\addplot[" .. pen(attrs) .. ", domain=" .. pa .. ":" .. pb
            .. ", samples=" .. samples .. "] "
            .. "({(" .. r .. ")*cos(deg(x))}, {(" .. r .. ")*sin(deg(x))});"
  end

  local out = {}
  out[#out+1] = "\\begin{center}\\begin{tikzpicture}"
  out[#out+1] = "\\begin{axis}[" .. table.concat(axisopts, ", ") .. "]"
  out[#out+1] = addplot
  out[#out+1] = "\\end{axis}"
  out[#out+1] = "\\end{tikzpicture}\\end{center}"
  api.raw('emit(' .. string.format("%q", table.concat(out)) .. ")\n")
end

local function plot_binomial(api, attrs)
  local ns, ps = attrs.binomial:match("^%s*(.-)%s*,%s*(.-)%s*$")
  local n, p = tonumber(ns), tonumber(ps)
  if not n or not p or n < 1 or n ~= math.floor(n) or p < 0 or p > 1 then
    error("texecole: <plot binomial:{n, p}> needs an integer n >= 1 and 0 <= p <= 1")
  end
  local ha, hb
  if attrs.area then
    local a, b = attrs.area:match("^%s*(.-)%s*,%s*(.-)%s*$")
    ha, hb = tonumber(a), tonumber(b)
    if not ha then
      error("texecole: <plot binomial> area:{a, b} needs two integer bounds")
    end
  end

  local masses, m = {}, (1 - p)^n
  masses[0] = m
  for k = 1, n do
    m = m * (n - k + 1) / k * p / (1 - p)
    masses[k] = m
  end

  local base, high, ymax = {}, {}, 0
  for k = 0, n do
    local pt = ("(%d,%.6f)"):format(k, masses[k])
    if ha and k >= ha and k <= hb then high[#high+1] = pt
    else base[#base+1] = pt end
    if masses[k] > ymax then ymax = masses[k] end
  end

  local axisopts = {
    "width=10cm, height=7cm",
    "ybar", "bar width=0.7",
    "axis lines=middle",
    "every tick label/.append style={fill=white, inner sep=1pt, font=\\footnotesize}",
    "xlabel=$k$", "ylabel={$P(X=k)$}",
    ("xmin=-0.8, xmax=%d"):format(n + 1),
    ("ymin=0, ymax=%.6f"):format(ymax * 1.15),
  }

  local out = {}
  out[#out+1] = "\\begin{center}\\begin{tikzpicture}"
  out[#out+1] = "\\begin{axis}[" .. table.concat(axisopts, ", ") .. "]"

  if #base > 0 then
    out[#out+1] = "\\addplot[fill=Blue!25, draw=Blue, bar shift=0pt] coordinates {"
      .. table.concat(base, " ") .. "};"
  end
  if #high > 0 then
    out[#out+1] = "\\addplot[fill=Blue!70, draw=Blue, bar shift=0pt] coordinates {"
      .. table.concat(high, " ") .. "};"
  end
  out[#out+1] = "\\end{axis}"
  out[#out+1] = "\\end{tikzpicture}\\end{center}"
  api.raw('emit(' .. string.format("%q", table.concat(out)) .. ")\n")
end

local function analyse_courbe(f, xmin, xmax, ymin, ymax)
  local W, H = xmax - xmin, ymax - ymin
  local Big = 6 * (math.max(math.abs(ymin), math.abs(ymax)) + H) + 10
  local function ev(x)
    local ok, y = pcall(f, x)
    if not ok or type(y) ~= "number" or y ~= y
       or y == math.huge or y == -math.huge then return nil end
    return y
  end
  local function disco(a, b)
    local ya, yb = ev(a), ev(b)
    if not ya or not yb then return true end
    if math.abs(yb - ya) > 2.5 * H then return true end
    local ym = ev((a + b) / 2)
    if not ym then return true end
    local d = math.abs(yb - ya)
    return d > 1e-9 and math.abs(ym - (ya + yb) / 2) > 0.3 * d + 1e-9
  end
  local function localise(a, b)
    for _ = 1, 45 do
      local m = (a + b) / 2
      if disco(a, m) then b = m else a = m end
    end
    return (a + b) / 2
  end

  local Nn = 480
  local xs, ys = {}, {}
  for i = 0, Nn do
    xs[i] = xmin + W * i / Nn
    ys[i] = ev(xs[i])
  end

  local segs, cur = {}, nil
  local marques = {}
  local function clampy(y) return math.max(ymin, math.min(ymax, y)) end
  local function ferme()
    if cur and #cur >= 2
       and math.abs(cur[#cur][1] - cur[1][1]) > W * 1e-6 then
      segs[#segs + 1] = cur
    end
    cur = nil
  end
  local function ajoute(x, y)
    cur = cur or {}
    cur[#cur + 1] = { x, y }
  end
  local vertic = {}
  local function note_pole(xstar)
    for _, v in ipairs(vertic) do
      if math.abs(v.x / v.n - xstar) < W * 0.012 then
        v.x, v.n = v.x + xstar, v.n + 1
        return
      end
    end
    vertic[#vertic + 1] = { x = xstar, n = 1 }
  end

  local i = 0
  while i < Nn do
    local x1, y1 = xs[i], ys[i]
    local x2, y2 = xs[i + 1], ys[i + 1]
    local saut = (not y1) or (not y2)
      or math.abs(y2 - y1) > 2.5 * H or disco(x1, x2)
    if y1 and math.abs(y1) <= Big and y1 >= ymin and y1 <= ymax then
      ajoute(x1, y1)
    elseif y1 then
      if cur and #cur >= 1 then
        local px, py = cur[#cur][1], cur[#cur][2]
        local t = (clampy(y1) - py) / (y1 - py + 1e-30)
        ajoute(px + (x1 - px) * t, clampy(y1))
      end
      ferme()
      if y2 and y2 >= ymin and y2 <= ymax and not saut then
        local t = (clampy(y1) - y1) / (y2 - y1 + 1e-30)
        ajoute(x1 + (x2 - x1) * t, clampy(y1))
      end
    end
    if saut then
      local xstar = localise(x1, x2)
      local yg = ev(xstar - W * 1e-7)
      local yd = ev(xstar + W * 1e-7)
      local yG = ev(xstar - W * 1e-4)
      local yD = ev(xstar + W * 1e-4)
      local seuil_pole = 2 * H + math.abs(ymax) + math.abs(ymin)
      local pole = (yG and math.abs(yG) > seuil_pole)
        or (yD and math.abs(yD) > seuil_pole)
      if pole then
        note_pole(xstar)
        ferme()
      else
        if yg and yg >= ymin and yg <= ymax then ajoute(xstar, yg) end
        ferme()
        if yd and yd >= ymin and yd <= ymax then ajoute(xstar, yd) end
        if yg and yd and yg >= ymin and yg <= ymax
           and yd >= ymin and yd <= ymax then
          local xc = math.floor(xstar * 1e9 + 0.5) / 1e9
          local yc = ev(xc)
          local plein_droite = true
          if yc then
            plein_droite = math.abs(yc - yd) <= math.abs(yc - yg)
          end
          marques[#marques + 1] =
            { xstar, yg, not plein_droite and "plein" or "ouvert" }
          marques[#marques + 1] =
            { xstar, yd, plein_droite and "plein" or "ouvert" }
        end
      end
    end
    i = i + 1
  end
  if ys[Nn] and ys[Nn] >= ymin and ys[Nn] <= ymax then
    ajoute(xs[Nn], ys[Nn])
  end
  ferme()

  local vlist = {}
  for _, v in ipairs(vertic) do vlist[#vlist + 1] = v.x / v.n end

  local droites = {}
  local function garde_droite(a, b)
    local interne = 0
    for _, t in ipairs({ 0.25, 0.5, 0.75 }) do
      local x = xmin + t * W
      local y = ev(x)
      if y and math.abs(y - (a * x + b)) < 1e-3 * (1 + math.abs(y)) then
        interne = interne + 1
      end
    end
    if interne == 3 then return end
    for _, d in ipairs(droites) do
      if math.abs(d[1] - a) < 1e-4 and math.abs(d[2] - b)
         < 1e-3 * (1 + math.abs(b)) then
        return
      end
    end
    droites[#droites + 1] = { a, b }
  end
  local function extrapole(v1, v2, v3)
    local d1, d2 = v2 - v1, v3 - v2
    if math.abs(d2) < 1e-9 * (1 + math.abs(v3)) then return v3 end
    if math.abs(d1) < 1e-12 then return nil end
    local r = d2 / d1
    if r <= -0.95 or r >= 0.95 then return nil end
    return v3 + d2 * r / (1 - r)
  end
  local function asymp_cote(sgn)
    local bord = (sgn > 0) and xmax or xmin
    local X1 = bord + sgn * 20.37 * W
    local X2 = bord + sgn * 41.71 * W
    local X3 = bord + sgn * 83.13 * W
    local y1, y2, y3 = ev(X1), ev(X2), ev(X3)
    if not (y1 and y2 and y3) then return end
    local a1 = (y2 - y1) / (X2 - X1)
    local a2 = (y3 - y2) / (X3 - X2)
    local echelle = H / W
    if math.abs(a1) < 0.02 * echelle and math.abs(a2) < 0.02 * echelle
       and math.abs(a2) <= math.abs(a1) + 1e-12 then
      local L = extrapole(y1, y2, y3)
      if L and math.abs(y3 - L) < 0.05 * H then
        garde_droite(0, L)
      end
      return
    end
    if math.abs(a2 - a1) < 0.02 * (math.abs(a1) + math.abs(a2)) then
      local b1 = y1 - a2 * X1
      local b2 = y2 - a2 * X2
      local b3 = y3 - a2 * X3
      local b = extrapole(b1, b2, b3) or b3
      local X4 = bord + sgn * 30.53 * W
      local X5 = bord + sgn * 61.29 * W
      local y4, y5 = ev(X4), ev(X5)
      if y4 and y5
         and math.abs(y4 - (a2 * X4 + b)) < 0.01 * H
         and math.abs(y5 - (a2 * X5 + b)) < 0.01 * H then
        garde_droite(a2, b)
      end
    end
  end
  asymp_cote(1)
  asymp_cote(-1)

  local extremums = {}
  for k = 1, Nn - 1 do
    local ya, yb, yc = ys[k - 1], ys[k], ys[k + 1]
    if ya and yb and yc and not disco(xs[k - 1], xs[k])
       and not disco(xs[k], xs[k + 1]) then
      local s1, s2 = yb - ya, yc - yb
      if s1 * s2 < 0 then
        local h = W * 1e-5
        local function der(x)
          local yg, yd = ev(x - h), ev(x + h)
          if not yg or not yd then return nil end
          return (yd - yg) / (2 * h)
        end
        local a, b = xs[k - 1], xs[k + 1]
        local da = der(a)
        if da then
          for _ = 1, 60 do
            local m = (a + b) / 2
            local dm = der(m)
            if not dm then break end
            if da * dm <= 0 then b = m else a = m; da = dm end
          end
          local x0 = (a + b) / 2
          local y0 = ev(x0)
          if y0 and x0 > xmin + 0.02 * W and x0 < xmax - 0.02 * W
             and y0 > ymin + 0.02 * H and y0 < ymax - 0.02 * H then
            local doublon = false
            for _, e in ipairs(extremums) do
              if math.abs(e[1] - x0) < W * 5e-3 then doublon = true end
            end
            if not doublon then extremums[#extremums + 1] = { x0, y0 } end
          end
        end
      end
    end
  end

  -- Tangentes verticales : pente qui explose sans discontinuité
  local tanv = {}
  local seuil = 12 * H / W
  local dx = W / Nn
  local k = 1
  while k < Nn do
    local ya, yb = ys[k], ys[k + 1]
    if ya and yb and math.abs(yb - ya) / dx > seuil
       and not disco(xs[k], xs[k + 1]) then
      local deb = k
      while k < Nn and ys[k] and ys[k + 1]
        and math.abs(ys[k + 1] - ys[k]) / dx > seuil do
        k = k + 1
      end
      local function gmag(x)
        local h = 1e-6 * W
        local yg, yd = ev(x - h), ev(x + h)
        if not yg or not yd then return -1 end
        return math.abs(yd - yg) / (2 * h)
      end
      local gr = (math.sqrt(5) - 1) / 2
      local a, b = xs[deb], xs[math.min(k, Nn)]
      local c1 = b - gr * (b - a)
      local c2 = a + gr * (b - a)
      local g1, g2 = gmag(c1), gmag(c2)
      for _ = 1, 60 do
        if g1 < g2 then
          a, c1, g1 = c1, c2, g2
          c2 = a + gr * (b - a)
          g2 = gmag(c2)
        else
          b, c2, g2 = c2, c1, g1
          c1 = b - gr * (b - a)
          g1 = gmag(c1)
        end
      end
      local x0 = (a + b) / 2
      local y0 = ev(x0)
      local yA, yB = ev(x0 - 0.02 * W), ev(x0 + 0.02 * W)
      local pres_pole = false
      for _, p in ipairs(vlist) do
        if math.abs(p - x0) < 0.03 * W then pres_pole = true end
      end
      local function derh(h)
        local yg, yd = ev(x0 - h), ev(x0 + h)
        if not yg or not yd then return nil end
        return (yd - yg) / (2 * h)
      end
      local d4, d6 = derh(1e-4 * W), derh(1e-6 * W)
      local diverge = d4 and d6
        and math.abs(d6) > 2.5 * math.abs(d4)
      if y0 and yA and yB and not pres_pole and diverge
         and math.abs(yA - y0) < H and math.abs(yB - y0) < H
         and y0 > ymin + 0.02 * H and y0 < ymax - 0.02 * H then
        tanv[#tanv + 1] = { x0, y0 }
      end
    end
    k = k + 1
  end

  return { segs = segs, vertic = vlist, droites = droites,
           extremums = extremums, marques = marques, tanv = tanv }
end

return function(sl)
  sl.analyse_courbe = analyse_courbe

  sl.translate_plot_expr = translate
  sl.compile_plot_fn = compile_num

  sl.register_tag("plot", function(api, words, content)
    local parts = {}
    for k = 2, #words do parts[#parts+1] = words[k] end
    local attrs = parse_attrs(U.trim(table.concat(parts, " ")))

    local ref = attrs._ref

    if attrs.binomial then
      return plot_binomial(api, attrs)
    end
    local obj
    if attrs.normal then
      local mu, sigma = attrs.normal:match("^%s*(.-)%s*,%s*(.-)%s*$")
      local m, s = tonumber(mu), tonumber(sigma)
      if not m or not s or s <= 0 then
        error("texecole: <plot normal:{mu, sigma}> needs two numbers, sigma > 0")
      end
      obj = {
        expr = ("1/(%.6g*sqrt(2pi))*exp(-(x-%.6g)^2/(2*%.6g^2))"):format(s, m, s),
        name = "f(x)",
      }
      if not attrs.x then
        attrs.x = ("%.6g, %.6g"):format(m - 4*s, m + 4*s)
      end
    else
      if not ref then
        error("texecole: <plot> needs a function object, e.g. <plot k ...> "
            .. "after  let k = <fn ...>  (or a law: normal:{mu,sigma}, "
            .. "binomial:{n,p})")
      end
      obj = sl._objects and sl._objects[ref]
      if not obj then
        error("texecole: <plot " .. ref .. "> refers to an object that is not "
            .. "defined; write  let " .. ref .. " = <fn ... expr:{...} ...>  first")
      end
    end
    if not obj.expr then
      error("texecole: <plot " .. ref .. "> needs the object to carry an "
          .. "expr:{...} (the formula to plot)")
    end

    local fn, var = "f", "x"
    if obj.name then
      local f, v = obj.name:match("^%s*([%a]%w*)%s*%(%s*([%a]%w*)%s*%)%s*$")
      if f then fn, var = f, v
      else fn = obj.name:match("^%s*([%a]%w*)%s*$") or "f" end
    end

    local kind = attrs.kind or "function"
    if kind ~= "function" and kind ~= "parametric" and kind ~= "polar" then
      error("texecole: <plot> kind: takes 'function', 'parametric' or 'polar' "
          .. "(got '" .. tostring(kind) .. "')")
    end

    local extras = {}
    if attrs._refs then
      if kind ~= "function" then
        error("texecole: plusieurs fonctions dans un même tracé ne "
            .. "valent que pour des courbes de fonctions (kind:function)")
      end
      if attrs.area or attrs.between or attrs.cobweb then
        error("texecole: l'aire, la comparaison entre deux courbes et la "
            .. "toile d'araignée se tracent avec une seule fonction "
            .. "principale — retirez la liste plurielle")
      end
      for _, r in ipairs(attrs._refs) do
        local o = sl._objects and sl._objects[r]
        if not (o and o.expr) then
          error("texecole: <plot ... " .. r .. "> désigne une fonction "
              .. "qui n'a pas été posée ; écrivez d'abord <Soit>une "
              .. "fonction " .. r .. "(x) = ...")
        end
        local nom = r
        if o.name then
          nom = o.name:match("^%s*([%a]%w*)%s*%(") or o.name or r
        end
        extras[#extras + 1] = { ref = r, obj = o, fn = nom }
      end
    end

    if kind == "parametric" or kind == "polar" then
      return plot_curve(api, attrs, obj, kind, fn)
    end

    local body = translate(U.trim(obj.expr), var)

    local xa, xb = hwindow(attrs, obj)
    local samples = attrs.samples or "100"

    local axisopts = {}
    axisopts[#axisopts+1] = "width=10cm, height=7cm"
    axisopts[#axisopts+1] = "axis lines=middle"
    axisopts[#axisopts+1] = "every tick label/.append style={"
                         .. "fill=white, inner sep=1pt, font=\\footnotesize}"
    axisopts[#axisopts+1] = "axis line style={shorten >=-6pt}"

    axisopts[#axisopts+1] = "xlabel=$" .. var .. "$"
    if #extras > 0 then
      axisopts[#axisopts+1] = "ylabel=$y$"
      axisopts[#axisopts+1] = "legend pos=north east"
      axisopts[#axisopts+1] = "legend style={font=\\footnotesize}"
    else
      axisopts[#axisopts+1] = "ylabel=$" .. fn .. "(" .. var .. ")$"
    end
    axisopts[#axisopts+1] = "xlabel style={at={(ticklabel* cs:1)}, anchor=west}"
    axisopts[#axisopts+1] = "ylabel style={at={(ticklabel* cs:1)}, anchor=south west}"
    axisopts[#axisopts+1] = "xmin=" .. xa .. ", xmax=" .. xb
    if attrs.y then
      local c, d = attrs.y:match("^%s*(.-)%s*,%s*(.-)%s*$")
      if not c then
        error("texecole: <plot> y:{c, d} needs two bounds separated by a comma")
      end
      local ct, dt = U.trim(c), U.trim(d)
      axisopts[#axisopts+1] = "ymin=" .. ct .. ", ymax=" .. dt
      local cn, dn = tonumber(ct), tonumber(dt)
      if cn and dn then
        axisopts[#axisopts+1] = "restrict y to domain=" .. (cn * 3) .. ":" .. (dn * 3)
      end
    end
    local xa_n, xb_n = tonumber(xa), tonumber(xb)
    local okn, fnum = pcall(compile_num, obj.expr, var)
    if not okn then fnum = nil end
    local ya_n, yb_n
    if attrs.y then
      local c, d = attrs.y:match("^%s*(.-)%s*,%s*(.-)%s*$")
      ya_n, yb_n = tonumber(U.trim(c or "")), tonumber(U.trim(d or ""))
    elseif fnum and xa_n and xb_n then
      local vals = {}
      for i = 0, 300 do
        local x = xa_n + (xb_n - xa_n) * i / 300
        local ok, y = pcall(fnum, x)
        if ok and type(y) == "number" and y == y
           and y ~= math.huge and y ~= -math.huge then
          vals[#vals + 1] = y
        end
      end
      if #vals >= 8 then
        table.sort(vals)
        local lo = vals[math.max(1, math.floor(#vals * 0.04))]
        local hi = vals[math.min(#vals, math.ceil(#vals * 0.96))]
        if hi - lo < 1e-9 then lo, hi = lo - 1, hi + 1 end
        local marge = 0.08 * (hi - lo)
        ya_n, yb_n = lo - marge, hi + marge
        axisopts[#axisopts+1] = ("ymin=%.4f, ymax=%.4f"):format(ya_n, yb_n)
        axisopts[#axisopts+1] = ("restrict y to domain=%.4f:%.4f")
          :format(ya_n - (hi - lo), yb_n + (hi - lo))
      end
    end
    axisopts[#axisopts+1] = "samples=" .. samples
    axisopts[#axisopts+1] = "unbounded coords=jump"

    local opt = table.concat(axisopts, ", ")

    local pre, post = {}, {}

    if fnum and xa_n and xb_n and ya_n and yb_n and sl.analyse_courbe then
      local D = sl.analyse_courbe(fnum, xa_n, xb_n, ya_n, yb_n)
      local Wd, Hd = xb_n - xa_n, yb_n - ya_n
      for _, v in ipairs(D.vertic) do
        post[#post+1] = ("\\draw[gray, dashed] (axis cs:%.4f,%.4f)"
          .. " -- (axis cs:%.4f,%.4f);"):format(v, ya_n, v, yb_n)
      end
      for _, d in ipairs(D.droites) do
        local a, b = d[1], d[2]
        if math.abs(a) < 1e-6 then
          if b > ya_n and b < yb_n then
            post[#post+1] = ("\\draw[gray, dashed] (axis cs:%.4f,%.4f)"
              .. " -- (axis cs:%.4f,%.4f);"):format(xa_n, b, xb_n, b)
          end
        else
          local x1, y1 = xa_n, a * xa_n + b
          local x2, y2 = xb_n, a * xb_n + b
          local function borne(x, y)
            if y < ya_n then return (ya_n - b) / a, ya_n end
            if y > yb_n then return (yb_n - b) / a, yb_n end
            return x, y
          end
          x1, y1 = borne(x1, y1)
          x2, y2 = borne(x2, y2)
          if x1 >= xa_n - 1e-9 and x2 <= xb_n + 1e-9 and x1 < x2 then
            post[#post+1] = ("\\draw[gray, dashed] (axis cs:%.4f,%.4f)"
              .. " -- (axis cs:%.4f,%.4f);"):format(x1, y1, x2, y2)
          end
        end
      end
      for _, e in ipairs(D.extremums) do
        post[#post+1] = ("\\draw[gray, dashed, <->, >=stealth] "
          .. "(axis cs:%.4f,%.4f) -- (axis cs:%.4f,%.4f);")
          :format(math.max(xa_n, e[1] - 0.08 * Wd), e[2],
                  math.min(xb_n, e[1] + 0.08 * Wd), e[2])
        post[#post+1] = ("\\fill[Blue] (axis cs:%.4f,%.4f) circle (1.4pt);")
          :format(e[1], e[2])
      end
      for _, e in ipairs(D.tanv) do
        post[#post+1] = ("\\draw[gray, dashed, <->, >=stealth] "
          .. "(axis cs:%.4f,%.4f) -- (axis cs:%.4f,%.4f);")
          :format(e[1], math.max(ya_n, e[2] - 0.08 * Hd),
                  e[1], math.min(yb_n, e[2] + 0.08 * Hd))
        post[#post+1] = ("\\fill[Blue] (axis cs:%.4f,%.4f) circle (1.4pt);")
          :format(e[1], e[2])
      end
      for _, m in ipairs(D.marques) do
        if m[3] == "plein" then
          post[#post+1] = ("\\fill[Blue] (axis cs:%.4f,%.4f) circle (1.6pt);")
            :format(m[1], m[2])
        else
          post[#post+1] = ("\\draw[Blue, fill=white] (axis cs:%.4f,%.4f)"
            .. " circle (1.6pt);"):format(m[1], m[2])
        end
      end
    end


    local area_a, area_b
    if attrs.area then
      area_a, area_b = attrs.area:match("^%s*(.-)%s*,%s*(.-)%s*$")
      if not area_a then
        error("texecole: <plot> area:{a, b} needs two bounds separated by a comma")
      end
    end
    local between_body
    if attrs.between then
      local gobj = sl._objects and sl._objects[attrs.between]
      if not (gobj and gobj.expr) then
        error("texecole: <plot ... between:" .. tostring(attrs.between)
            .. "> needs  let " .. tostring(attrs.between)
            .. " = <fn expr:{...}>  defined first")
      end
      between_body = translate(U.trim(gobj.expr), var)
    end

    if area_a and not between_body then
      pre[#pre+1] = "\\addplot[fill=Blue!15, draw=none, domain=" .. area_a .. ":"
        .. area_b .. ", samples=" .. samples .. "] {" .. body .. "} \\closedcycle;"
      local fnum = compile_num(obj.expr, var)
      local na, nb = tonumber(area_a), tonumber(area_b)
      if na and nb then
        post[#post+1] = ("\\draw[Blue, dashed] (axis cs:%s,0) -- (axis cs:%s,%.4f);")
          :format(area_a, area_a, fnum(na))
        post[#post+1] = ("\\draw[Blue, dashed] (axis cs:%s,0) -- (axis cs:%s,%.4f);")
          :format(area_b, area_b, fnum(nb))
      end
    end

    if attrs.cobweb then
      local u0s, ns = attrs.cobweb:match("^%s*(.-)%s*,%s*(.-)%s*$")
      if not u0s then u0s = U.trim(attrs.cobweb) end
      local u0 = tonumber(u0s)
      local n  = tonumber(ns or "") or 8
      if not u0 then
        error("texecole: <plot> cobweb:{u0} or cobweb:{u0, n} — u0 must be a number")
      end
      local fnum = compile_num(obj.expr, var)
      pre[#pre+1] = "\\addplot[Gray, thin, domain=" .. xa .. ":" .. xb .. "] {x};"
      local pts = { ("(%.4f,0)"):format(u0) }
      local u = u0
      for _ = 1, n do
        local v = fnum(u)
        if not v or v ~= v or math.abs(v) > 1e6 then break end
        pts[#pts+1] = ("(%.4f,%.4f)"):format(u, v)
        pts[#pts+1] = ("(%.4f,%.4f)"):format(v, v)
        u = v
      end
      post[#post+1] = "\\addplot[Red, thick] coordinates {"
        .. table.concat(pts, " ") .. "};"
      local u1 = fnum(u0)
      local u2 = u1 and fnum(u1)
      post[#post+1] = ("\\node[below, font=\\footnotesize, Red] at (axis cs:%.4f,0) {$u_0$};"):format(u0)
      if u1 then post[#post+1] = ("\\node[below, font=\\footnotesize, Red] at (axis cs:%.4f,0) {$u_1$};"):format(u1) end
      if u2 then post[#post+1] = ("\\node[below, font=\\footnotesize, Red] at (axis cs:%.4f,0) {$u_2$};"):format(u2) end
    end

    local out = {}
    out[#out+1] = "\\begin{center}\\begin{tikzpicture}"
    out[#out+1] = "\\begin{axis}[" .. opt .. "]"
    for _, p in ipairs(pre) do out[#out+1] = p end
    if between_body then
      out[#out+1] = "\\addplot[name path=SLA, Blue, thick, domain=" .. xa .. ":" .. xb
                .. "] {" .. body .. "};"
      out[#out+1] = "\\addplot[name path=SLB, Red, thick, domain=" .. xa .. ":" .. xb
                .. "] {" .. between_body .. "};"
      local clip = area_a
        and (", soft clip={domain=" .. area_a .. ":" .. area_b .. "}") or ""
      out[#out+1] = "\\addplot[Blue!15] fill between[of=SLA and SLB" .. clip .. "];"
    else
      out[#out+1] = "\\addplot[" .. pen(attrs) .. ", domain=" .. xa .. ":" .. xb
                .. "] {" .. body .. "};"
      if #extras > 0 then
        out[#out+1] = "\\addlegendentry{$" .. fn .. "$}"
        local PALETTE = { "Red", "Green!55!black", "Orange", "Purple", "Brown" }
        for i, ex in ipairs(extras) do
          local exvar = "x"
          if ex.obj.name then
            local _, v2 = ex.obj.name:match("^%s*([%a]%w*)%s*%(%s*([%a]%w*)%s*%)")
            if v2 then exvar = v2 end
          end
          local exbody = translate(U.trim(ex.obj.expr), exvar)
          if exvar ~= "x" then exbody = exbody:gsub("%f[%w]" .. exvar .. "%f[%W]", "x") end
          local coul = PALETTE[(i - 1) % #PALETTE + 1]
          out[#out+1] = "\\addplot[" .. coul .. ", thick, domain=" .. xa .. ":"
                    .. xb .. "] {" .. exbody .. "};"
          out[#out+1] = "\\addlegendentry{$" .. ex.fn .. "$}"
        end
      end
    end
    for _, p in ipairs(post) do out[#out+1] = p end
    out[#out+1] = "\\end{axis}"
    out[#out+1] = "\\end{tikzpicture}\\end{center}"

    api.raw('emit(' .. string.format("%q", table.concat(out)) .. ")\n")
  end)
end
