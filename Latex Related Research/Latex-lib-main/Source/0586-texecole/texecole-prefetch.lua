

local M = {}

local function trim(s) return (s:gsub("^%s+", ""):gsub("%s+$", "")) end

local function extraire_fonctions(texte)
  local fns = {}
  for nom, var, def in texte:gmatch(
      "<fn%s+([%a_][%w_]*)%s*%(%s*([%a_][%w_]*)%s*%)%s*=%s*([^>]*)>") do
    local expr = def
    local p = expr:find("%f[%S][%a_][%w_]*:")
    if p then expr = expr:sub(1, p - 1) end
    fns[nom] = { var = var, expr = trim(expr) }
  end
  return fns
end

local function soumettre_calculs(texte, S)
  local fns = extraire_fonctions(texte)

  for nom in texte:gmatch("<vartab%s+([%a_][%w_]*)%s*>") do
    local d = fns[nom]
    if d then pcall(S.variations, d.expr, d.var) end
  end

  for nom in texte:gmatch("<signtab%s+([%a_][%w_]*)%s*>") do
    local d = fns[nom]
    if d then
      local okA, A = pcall(require, "texecole-affine")
      local affine = okA and A and A.parse_product
                     and (A.parse_product(d.expr, d.var)) or nil
      if not affine then pcall(S.signes, d.expr, d.var) end
    end
  end

  local function lignes(c)
    local rows = {}
    for l in (c .. "\n"):gmatch("(.-)\n") do
      l = trim(l)
      if l ~= "" then rows[#rows + 1] = l end
    end
    return rows
  end

  local blocs = {
    sympyderiv = function(m, c)
      local name, order, var = m:match("^(%S+)%s+(%d+)%s+(%S+)$")
      if not name then name, var = m:match("^(%S+)%s+(%S+)$"); order = "1" end
      S.derivative(c, var or "x", tonumber(order) or 1)
    end,
    sympyzeros = function(m, c)
      S.zeros(c, m:match("^%S+%s+(%S+)$") or "x")
    end,
    sympyprim = function(m, c)
      S.primitive(c, m:match("^%S+%s+(%S+)$") or "x")
    end,
    sympyexpand = function(m, c) S.expand(c) end,
    sympyapart = function(m, c) S.apart(c, "x") end,
    sympycanon = function(m, c) S.canonical(c, "x") end,
    sympyfactor = function(m, c) S.factor(c) end,
    sympysimplify = function(m, c) S.simplify_expr(c) end,
    sympylimit = function(m, c)
      local _, var, pt, dir = m:match("^(%S+)%s+(%S+)%s+(%S+)%s*(%S*)$")
      if var then S.limite(c, var, pt, dir ~= "" and dir or nil) end
    end,
    sympydl = function(m, c)
      local _, var, a, n = m:match("^(%S+)%s+(%S+)%s+(%S+)%s+(%d+)$")
      if var then S.dl(c, var, a, tonumber(n)) end
    end,
    sympynint = function(m, c)
      local _, var, a, b = m:match("^(%S+)%s+(%S+)%s+(%S+)%s+(%S+)$")
      if var then S.nintegrate(c, var, a, b) end
    end,
    sympysolveeq = function(m, c)
      local lhs, rhs = c:match("^(.-)=(.+)$")
      if lhs then S.solve_eq(lhs, rhs, "x", m:match("^(%S+)")) end
    end,
    sympysum = function(m, c)
      local var, a, b = m:match("^(%S+)%s+(%S+)%s+(%S+)$")
      if var then S.closed_sum("sum", c, var, a, b) end
    end,
    sympyprod = function(m, c)
      local var, a, b = m:match("^(%S+)%s+(%S+)%s+(%S+)$")
      if var then S.closed_sum("prod", c, var, a, b) end
    end,
    sympyconvex = function(m, c)
      local _, var = m:match("^(%S+)%s+(%S+)$")
      S.convexite(c, var or "x")
    end,
    sympyasymp = function(m, c) S.asymptotes(c, "x") end,
    sympydefint = function(m, c)
      local _, var, a, b = m:match("^(%S+)%s+(%S+)%s+(%S+)%s+(%S+)$")
      if var then S.defint(c, var, a, b) end
    end,
    sympyequiv = function(m, c)
      local _, var, pt = m:match("^(%S+)%s+(%S+)%s+(%S+)$")
      if var then S.equivalent(c, var, pt) end
    end,
    sympyserie = function(m, c)
      S.serie_nature(c, m:match("^(%S+)") or "n")
    end,
    sympyimpint = function(m, c)
      local _, var, a, b = m:match("^(%S+)%s+(%S+)%s+(%S+)%s+(%S+)$")
      if var then S.impint_nature(c, var, a, b) end
    end,
    sympypow = function(m, c)
      local _, n = m:match("^(%S+)%s+(%d+)$")
      if n then S.matrix_pow(lignes(c), tonumber(n)) end
    end,
    sympystable = function(m, c) S.markov_stable(lignes(c)) end,
    sympyrank = function(m, c) S.matrix_struct(lignes(c), "rank") end,
    sympyker = function(m, c) S.matrix_struct(lignes(c), "ker") end,
    sympyim = function(m, c) S.matrix_struct(lignes(c), "im") end,
    sympycharpoly = function(m, c) S.charpoly(lignes(c)) end,
    sympyminpoly = function(m, c) S.minpoly(lignes(c)) end,
    sympytrigmat = function(m, c) S.trigonalise(lignes(c)) end,
    sympygram = function(m, c)
      local coords = {}
      for co in c:gmatch("%b{}") do coords[#coords + 1] = co:sub(2, -2) end
      if #coords > 0 then S.gram_schmidt(coords) end
    end,
    sympypolydiv = function(m, c)
      local P, Q = c:match("^(.-)\n(.*)$")
      if P then S.polydiv(S.to_sympy(trim(P)), S.to_sympy(trim(Q))) end
    end,
    sympypolygcd = function(m, c)
      local P, Q = c:match("^(.-)\n(.*)$")
      if P then S.polygcd(S.to_sympy(trim(P)), S.to_sympy(trim(Q))) end
    end,
    sympyfactordom = function(m, c)
      S.factor_dans(S.to_sympy(c), m:match("^(%S+)") or "R")
    end,
    sympygrad = function(m, c)
      local _, vars = m:match("^(%S+)%s+(%S+)$")
      if vars then S.multi(c, vars, "grad") end
    end,
    sympyhess = function(m, c)
      local _, vars = m:match("^(%S+)%s+(%S+)$")
      if vars then S.multi(c, vars, "hess") end
    end,
    sympypartial = function(m, c)
      local _, vars, wrt = m:match("^(%S+)%s+(%S+)%s+(%S+)$")
      if vars then S.multi(c, vars, "partial", wrt) end
    end,
    sympycrit = function(m, c)
      local _, vars = m:match("^(%S+)%s+(%S+)$")
      if vars then S.multi(c, vars, "crit") end
    end,
    sympyfourier = function(m, c)
      local _, var, a, b, n = m:match("^(%S+)%s+(%S+)%s+(%S+)%s+(%S+)%s+(%d+)$")
      if var then S.fourier(c, var, a, b, tonumber(n)) end
    end,
    sympylaplace = function(m, c)
      local _, var = m:match("^(%S+)%s+(%S+)$")
      if var then S.laplace(c, var, "direct") end
    end,
    sympyinvlaplace = function(m, c)
      local _, var = m:match("^(%S+)%s+(%S+)$")
      if var then S.laplace(c, var, "inverse") end
    end,
    sympywronsk = function(m, c)
      local var = m:match("^(%S+)")
      if var then S.wronskien(lignes(c), var) end
    end,
  }

  for tag, mots, contenu in texte:gmatch("<(sympy%a+)%s*([^>]*)>%s*{(.-)}") do
    local h = blocs[tag]
    if h then pcall(h, trim(mots), trim(contenu)) end
  end
end

local function detecter_besoins(source, texte)
  local besoins = { plots = "1", tab = "1", poster = "1", tableau = "1" }
  if not texte then return besoins end
  besoins.plots = (texte:find("<plot", 1, true) or texte:find("<stats", 1, true)
    or source:find("pgfplots", 1, true) or source:find("begin{axis}", 1, true))
    and "1" or "0"
  besoins.tab = (texte:find("<vartab", 1, true) or texte:find("<signtab", 1, true)
    or source:find("tkzTab", 1, true)) and "1" or "0"
  besoins.poster = (texte:find("<grid", 1, true)
    or source:find("tcbposter", 1, true)) and "1" or "0"

  besoins.tableau = (texte:find("<table[%s>]")
    or texte:find("<posedop[%s>]")
    or texte:find("<problaw[%s>]")
    or texte:find("<cayley[%s>]")
    or texte:find("<pascal[%s>]")
    or source:find("begin{tblr}", 1, true)) and "1" or "0"
  return besoins
end

local function machine_multicoeur()
  local f = io.open("/proc/cpuinfo", "r")
  if not f then return true end
  local n = 0
  for ligne in f:lines() do
    if ligne:match("^processor%s*:") then n = n + 1 end
  end
  f:close()
  return n ~= 1
end

function M.lancer()
  local source, texte
  pcall(function()
    local f = io.open(tex.jobname .. ".tex", "r")
    if not f then return end
    source = f:read("*a")
    f:close()
    local corps = source:match("\\begin%s*{document}(.*)\\end%s*{document}")
    if not corps then source = nil; return end
    local L = require("texecole-lecteur")
    texte = L.traduire(corps)
  end)

  if source then
    local besoins = detecter_besoins(source, texte)
    pcall(token.set_macro, "texecole@besoinplots", besoins.plots)
    pcall(token.set_macro, "texecole@besointab", besoins.tab)
    pcall(token.set_macro, "texecole@besoinposter", besoins.poster)
    pcall(token.set_macro, "texecole@besointableau", besoins.tableau)
  end

  if texte and machine_multicoeur()
     and (texte:find("<sympy", 1, true) or texte:find("<vartab", 1, true)
          or texte:find("<signtab", 1, true)) then
    pcall(function()
      local fabrique = require("texecole-sympy")
      local bidon = { register_tag = function() end,
                      register_block = function() end }
      local S = fabrique(bidon)
      if S.prefetch_debut then
        S.prefetch_debut()
        pcall(soumettre_calculs, texte, S)
        S.prefetch_fin()
      end
    end)
  end
end

return M
