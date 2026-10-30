local U     = require("texecole-util")
local STYLE = require("texecole-style")
local MATH  = require("texecole-math")
local NUMEVAL = require("texecole-numeval")

local sl = {}
sl.util   = U
sl.style  = STYLE
sl.math   = MATH
sl._tags   = {}
sl._BUILD = "2026-07-30"
sl._blocks = {}

local ALIAS, MACRO, BLOCKALIAS

local function warn(msg)
  if texio and texio.write_nl then
    texio.write_nl("term and log", msg)
  else
    io.stderr:write(msg .. "\n")
  end
end

function sl.register_tag(name, fn)
  if sl._tags[name] then
    error("texecole: tag '" .. name .. "' is already registered (name clash)")
  end
  sl._tags[name] = fn
end

function sl.register_block(name, fn)
  if sl._blocks[name] then
    error("texecole: block '" .. name .. "' is already registered (name clash)")
  end
  sl._blocks[name] = fn
end

function sl.use(modname)
  local m = require(modname)
  if type(m) == "function" then m(sl) end
  return m
end

local forward_text

local function lit(code, text)
  if text ~= "" then
    code[#code + 1] = "emit(" .. string.format("%q", text) .. ")\n"
  end
end

local function warn_if_shadows(name, lineno)
  local native = false
  local ok, r = pcall(STYLE.resolve, name)
  if ok and r then native = true end
  if sl._blocks[name] or sl._tags[name] then native = true end
  if native then
    local where = lineno and (" (line " .. lineno .. ")") or ""
    warn("texecole: warning: 'let " .. name .. "'" .. where
      .. " shadows a built-in name and will be ignored; "
      .. "the built-in '" .. name .. "' always takes precedence. "
      .. "Use a different alias name.")
  end
end

local function ends_struct_open(line)
  local t = line:gsub("%s+$", "")
  if t:sub(-1) ~= "{" then return false end
  if t:sub(-2) == "{{" then return false end
  return true
end

local function is_control_open(line)
  if line:match("^%s*for%s+[%a_][%w_]*%s+in%s+%b[]%s*{%s*$") then return true end
  if line:match("^%s*for%s+[%a_][%w_]*%s+in%s+%S+%.%.%S+%s+step%s+%S+%s*{%s*$") then return true end
  if line:match("^%s*for%s+[%a_][%w_]*%s+in%s+%S+%.%.%S+%s*{%s*$") then return true end
  if line:match("^%s*}%s*else%s*{%s*$") then return true end
  if line:match("^%s*}%s*elseif%s+.+{%s*$") then return true end
  if line:match("^%s*repeat%s*{%s*$") then return true end
  if line:match("^%s*if%s+.+{%s*$") and ends_struct_open(line) then return true end
  if line:match("^%s*while%s+.+{%s*$") and ends_struct_open(line) then return true end
  return false
end

local function lua_control(line)
  local lv, llist = line:match("^%s*for%s+([%a_][%w_]*)%s+in%s+%[(.-)%]%s*{%s*$")
  if lv then
    local items = U.split_commas(llist)
    local quoted = {}
    for _, it in ipairs(items) do

      if tonumber(it) then
        quoted[#quoted + 1] = it
      else
        quoted[#quoted + 1] = string.format("%q", it)
      end
    end
    return ("for _, %s in ipairs({%s}) do"):format(lv, table.concat(quoted, ", "))
  end
  local v3, a3, b3, p3 = line:match("^%s*for%s+([%a_][%w_]*)%s+in%s+(.-)%.%.(.-)%s+step%s+(.-)%s*{%s*$")
  if v3 then return ("for %s = %s, %s, %s do"):format(v3, a3, b3, p3) end
  local v, a, b = line:match("^%s*for%s+([%a_][%w_]*)%s+in%s+(.-)%.%.(.-)%s*{%s*$")
  if v then return ("for %s = %s, %s do"):format(v, a, b) end
  local cond = line:match("^%s*if%s+(.-)%s*{%s*$")
  if cond then return "if " .. cond .. " then" end
  if line:match("^%s*}%s*else%s*{%s*$") then return "else" end
  local ec = line:match("^%s*}%s*elseif%s+(.-)%s*{%s*$")
  if ec then return "elseif " .. ec .. " then" end
  if line:match("^%s*repeat%s*{%s*$") then return "repeat" end
  local wc = line:match("^%s*while%s+(.-)%s*{%s*$")
  if wc then return "while " .. wc .. " do" end
  return nil
end

local process_lines

local function mkapi(code)
  return {
    lit             = function(t) lit(code, t) end,
    raw             = function(t) code[#code + 1] = t end,
    forward_text    = function(t) forward_text(code, t) end,
    is_control_open = is_control_open,
    lua_control     = lua_control,
    process_block   = function(lines)
      local norm = {}
      for _, l in ipairs(lines) do
        if type(l) == "string" then norm[#norm+1] = {text = l}
        else norm[#norm+1] = l end
      end
      process_lines(code, norm)
    end,
  }
end

local function emit_tag(code, words_str, content)
  local words = {}
  for w in words_str:gmatch("%S+") do words[#words + 1] = w end
  local head = words[1]

  local handler = sl._tags[head]
  if handler then
    handler(mkapi(code), words, content, words_str)
    return
  end

  if MACRO[head] then
    local m = MACRO[head]
    local args = {}
    local depth, start, k, idx, n = 0, 1, 0, 1, #content
    while idx <= n do
      local c = content:sub(idx, idx)
      if c == "\\" then idx = idx + 2
      else
        if c == "{" then depth = depth + 1
        elseif c == "}" then depth = depth - 1
        elseif c == "," and depth == 0 then
          k = k + 1
          args[k] = U.trim(content:sub(start, idx - 1))
          start = idx + 1
        end
        idx = idx + 1
      end
    end
    k = k + 1
    args[k] = U.trim(content:sub(start))

    local body = m.body
    for pi, pname in ipairs(m.params) do
      local repl = (args[pi] or ""):gsub("%%", "%%%%")
      body = body:gsub("#" .. pname .. "%f[%W]", repl)
    end
    forward_text(code, body)
    return
  end

  local outer, inner = STYLE.classify_split(words, ALIAS)

  for _, e in ipairs(outer) do lit(code, e[1]) end

  local raw = U.split_top_newlines(content)
  local paras = {}
  for _, para in ipairs(raw) do
    local clean = para:gsub("^[ \t]+", ""):gsub("[ \t]+$", "")
    if clean ~= "" then paras[#paras + 1] = clean end
  end
  for pi, para in ipairs(paras) do
    if pi > 1 then lit(code, " \\par ") end
    for _, e in ipairs(inner) do lit(code, e[1]) end
    forward_text(code, para)
    for j = #inner, 1, -1 do lit(code, inner[j][2]) end
  end

  for j = #outer, 1, -1 do lit(code, outer[j][2]) end
end

forward_text = function(code, s)
  local i, n = 1, #s
  local buf = {}
  local function flush() lit(code, table.concat(buf)); buf = {} end

  while i <= n do
    local c = s:sub(i, i)

    if c == "$" then

      if i > 1 and s:sub(i - 1, i - 1) == "\\" then
        buf[#buf + 1] = "$"; i = i + 1
        goto continue
      end
      if s:sub(i + 1, i + 1) == "$" then
        buf[#buf + 1] = "\\$"; i = i + 2
        goto continue
      end
      local close = s:find("$", i + 1, true)
      if not close then

        buf[#buf + 1] = "\\$"; i = i + 1
        goto continue
      end
      local inner = s:sub(i + 1, close - 1)
      flush()

      local exprs = {}
      local rebuilt, k = {}, 1
      while k <= #inner do
        local hash = inner:find("#", k, true)
        if not hash then rebuilt[#rebuilt+1] = inner:sub(k); break end
        rebuilt[#rebuilt+1] = inner:sub(k, hash - 1)
        local expr, after
        if inner:sub(hash+1, hash+1) == "{" then
          expr, after = U.read_group(inner, hash + 1)
        else
          local name = inner:match("^#([%a_][%w_]*)", hash)
          if name then
            expr, after = name, hash + 1 + #name
          else
            rebuilt[#rebuilt+1] = "\\#"
            k = hash + 1
            goto cont_hash
          end
        end
        exprs[#exprs+1] = expr
        rebuilt[#rebuilt+1] = "\\texecoleI{" .. #exprs .. "}"
        k = after
        ::cont_hash::
      end

      local transformed = MATH.mathlite(table.concat(rebuilt))

      lit(code, "$")
      local p = 1
      while p <= #transformed do
        local a, b, num = transformed:find("\\texecoleI{(%d+)}", p)
        if not a then lit(code, transformed:sub(p)); break end
        if a > p then lit(code, transformed:sub(p, a - 1)) end
        code[#code+1] = "emit(_fmtm(" .. exprs[tonumber(num)] .. "))\n"
        p = b + 1
      end
      lit(code, "$")
      i = close + 1

    elseif c == "\\" then
      buf[#buf + 1] = "\\textbackslash{}"; i = i + 1

    elseif c == "<" then
      if s:sub(i + 1, i + 1) == "<" then
        buf[#buf + 1] = "\\textless{}"; i = i + 2
        goto continue
      end
      local close = s:find(">", i + 1, true)
      if not close then
        local where = sl._line and (" (line " .. sl._line .. ")") or ""
        warn("texecole: warning: unterminated '<'" .. where
          .. "; treating it as a literal '<'. To print a literal '<', double it as <<.")
        buf[#buf + 1] = "\\textless{}"; i = i + 1
        goto continue
      end
      local words_str = s:sub(i + 1, close - 1)
      local after_gt = close + 1
      local probe = after_gt
      while s:sub(probe, probe):match("[ \t]") do probe = probe + 1 end
      flush()
      if s:sub(probe, probe) == "{" then
        local content, after = U.read_group(s, probe)
        emit_tag(code, words_str, content)
        i = after
      else
        local nl = s:find("\n", after_gt, true)
        local stop = nl and (nl - 1) or #s
        local content = s:sub(after_gt, stop)
        emit_tag(code, words_str, content)
        i = stop + 1
      end

    elseif c == "#" then
      local nxt = s:sub(i + 1, i + 1)
      if nxt == "#" then
        buf[#buf + 1] = "\\#"; i = i + 2
      elseif nxt == "{" then
        local expr, after = U.read_group(s, i + 1)
        flush()
        code[#code + 1] = "emit(_fmt(" .. expr .. "))\n"
        i = after
      else
        local name = s:match("^#([%a_][%w_]*)", i)
        if name then
          flush()
          code[#code + 1] = "emit(_fmt(" .. name .. "))\n"
          i = i + 1 + #name
        else
          buf[#buf + 1] = "\\#"; i = i + 1
        end
      end

    else
      if c == "\n" then
        flush()
        lit(code, " \\par ")
      elseif c == ">" then
        if s:sub(i + 1, i + 1) == ">" then i = i + 1 end
        buf[#buf + 1] = "\\textgreater{}"
      elseif c == "{" then
        if s:sub(i + 1, i + 1) == "{" then i = i + 1 end
        buf[#buf + 1] = "\\{"
      elseif c == "}" then
        if s:sub(i + 1, i + 1) == "}" then i = i + 1 end
        buf[#buf + 1] = "\\}"
      elseif c == "_" then buf[#buf + 1] = "\\_"
      elseif c == "&" then buf[#buf + 1] = "\\&"
      elseif c == "%" then buf[#buf + 1] = "\\%"
      elseif c == "^" then buf[#buf + 1] = "\\textasciicircum{}"
      elseif c == "~" then buf[#buf + 1] = "\\textasciitilde{}"
      elseif c == "\194" and s:sub(i + 1, i + 1) == "\176" then
        buf[#buf + 1] = "\\ensuremath{^\\circ}"; i = i + 1
      else buf[#buf + 1] = c end
      i = i + 1
    end
    ::continue::
  end
  flush()
end

local function tag_brace_delta(line)
  local delta, i, n = 0, 1, #line
  while i <= n do
    local c = line:sub(i, i)
    if c == "<" then
      local close = line:find(">", i + 1, true)
      if close then
        local b = close + 1
        while line:sub(b, b):match("%s") do b = b + 1 end
        if line:sub(b, b) == "{" then
          local depth, j = 0, b
          while j <= n do
            local d = line:sub(j, j)
            if d == "{" then depth = depth + 1
            elseif d == "}" then depth = depth - 1 end
            if depth == 0 then break end
            j = j + 1
          end
          delta = delta + depth
          i = (depth == 0) and (j + 1) or (n + 1)
        else
          i = close + 1
        end
      else
        i = i + 1
      end
    elseif c == "#" and line:sub(i + 1, i + 1) == "{" then
      local depth, j = 0, i + 1
      while j <= n do
        local d = line:sub(j, j)
        if d == "{" then depth = depth + 1
        elseif d == "}" then depth = depth - 1 end
        if depth == 0 then break end
        j = j + 1
      end
      delta = delta + depth
      i = (depth == 0) and (j + 1) or (n + 1)
    else
      i = i + 1
    end
  end
  return delta
end

local function opener_unclosed(line)
  if not line:match("^%s*<%a[%w_]*") then return false end
  local i, n, depth, bdepth = 1, #line, 0, 0
  while i <= n do
    local c = line:sub(i, i)
    if c == "[" then
      bdepth = bdepth + 1; i = i + 1
    elseif c == "]" then
      if bdepth > 0 then bdepth = bdepth - 1 end
      i = i + 1
    elseif c == ">" and depth == 0 and bdepth == 0 then
      return false
    else
      local kind, j = U.brace_scan(line, i)
      if kind == "open" then depth = depth + 1
      elseif kind == "close" then if depth > 0 then depth = depth - 1 end end
      i = j
    end
  end
  return true
end

local VAR_SCOPES = { {} }

local function scopes_reset() VAR_SCOPES = { {} } end
local function scope_push() VAR_SCOPES[#VAR_SCOPES + 1] = {} end
local function scope_pop()
  if #VAR_SCOPES > 1 then VAR_SCOPES[#VAR_SCOPES] = nil end
end
local function var_visible(name)
  for i = #VAR_SCOPES, 1, -1 do
    if VAR_SCOPES[i][name] then return true end
  end
  return false
end
local function var_declare(name) VAR_SCOPES[#VAR_SCOPES][name] = true end

process_lines = function(code, body_lines)
  local idx, total = 1, #body_lines
  while idx <= total do
    local entry = body_lines[idx]
    if entry.lineno then sl._line = entry.lineno end
    if entry.fninner then
      local attrs = sl.fn_parse(entry.fninner)
      local key = entry.fnreg
      if not key or key == false then
        key = attrs.name and attrs.name:match("^([%a_][%w_]*)")
        if not key then
          error("texecole: line " .. (entry.lineno or "?")
              .. ": a standalone <fn> registers itself and so needs the "
              .. "equation form  <fn f(x) = ...>  (or bind it with let)", 0)
        end
        warn_if_shadows(key, entry.lineno or 0)
      end
      sl._objects = sl._objects or {}
      sl._objects[key] = attrs
      idx = idx + 1
    elseif entry.var then
      if var_visible(entry.var) then
        code[#code + 1] = entry.var .. " = " .. entry.expr .. "\n"
      else
        var_declare(entry.var)
        code[#code + 1] = "local " .. entry.var .. " = " .. entry.expr .. "\n"
      end
      idx = idx + 1
    else
      local line = entry.text
      if opener_unclosed(line) then
        local j = idx
        local joined = line
        while j < total and opener_unclosed(joined) do
          j = j + 1
          joined = joined .. "\n" .. (body_lines[j].text or "")
        end
        if not opener_unclosed(joined) then
          line = joined
          idx = j
        end
      end
      local bname, bwords = line:match("^%s*<(%a[%w_]*)%s*(.-)>%s*{%s*$")
      if bname and BLOCKALIAS[bname] then
        local def = BLOCKALIAS[bname]
        local opts = def.opts
        if #def.params > 0 then
          local args = U.split_commas(bwords or "")
          for pi, pname in ipairs(def.params) do
            local repl = (args[pi] or ""):gsub("%%", "%%%%")
            opts = opts:gsub("#" .. pname .. "%f[%W]", repl)
          end
          bwords = ""
        end
        bwords = opts .. " " .. (bwords or "")
        bname = def.block
      end
      if bname and sl._blocks[bname] then
        idx = idx + 1
        local inner
        inner, idx = U.collect_block(body_lines, idx)
        local inner_str = {}
        for _, e in ipairs(inner) do
          inner_str[#inner_str+1] = (type(e) == "table") and e.text or e
        end
        sl._blocks[bname](mkapi(code), bwords or "", inner_str)
        code[#code + 1] = 'emit(" \\\\par ")\n'
      elseif line:match("^%s*}%s*until%s+") then
        local c = line:match("^%s*}%s*until%s+(.-)%s*$")
        code[#code + 1] = "until not (" .. c .. ")\n"
        scope_pop()
        idx = idx + 1
      elseif line:match("^%s*}%s*$") then
        code[#code + 1] = "end\n"
        scope_pop()
        idx = idx + 1
      elseif is_control_open(line) then
        local lc = lua_control(line)
        if line:match("^%s*}%s*else") then
          scope_pop()
        end
        scope_push()
        local lv = lc:match("^for%s+([%a_][%w_]*)%s*=")
                or lc:match("^for%s+_%s*,%s*([%a_][%w_]*)%s+in")
        if lv then var_declare(lv) end
        code[#code + 1] = lc .. "\n"
        idx = idx + 1
      else
        local chunk, delta = line, tag_brace_delta(line)
        while delta > 0 and idx < total do
          idx = idx + 1
          local nxt = body_lines[idx].text or ""
          chunk = chunk .. "\n" .. nxt
          delta = delta + U.raw_brace_delta(nxt)
        end
        forward_text(code, chunk)
        code[#code + 1] = 'emit(" \\\\par ")\n'
        idx = idx + 1
      end
    end
  end
end

local function build_lua(src)
  local lang = (sl.config and sl.config.lang) or "fr"
  local prec = (sl.config and sl.config.precision) or -1
  local sep_txt  = (lang == "en") and "." or ","
  local sep_math = (lang == "en") and "." or "{,}"
  local function q(s) return string.format("%q", s) end
  local code = {
    "local _parts = {}\n",
    "local function emit(s) _parts[#_parts+1] = s end\n",
    NUMEVAL.PREAMBLE,
    NUMEVAL.inject_locals(),
    "local abs=math.abs; local max=math.max; local min=math.min\n",
    "local _SEPT=" .. q(sep_txt) .. "; local _SEPM=" .. q(sep_math) .. "\n",
    "local _PREC=" .. tostring(prec) .. "\n",

    "local function _show(v, sep)\n"

    .. "  local fixed\n"
    .. "  if type(v)=='table' and v.v~=nil and v.d~=nil then fixed=v.d; v=v.v end\n"
    .. "  if type(v)~='number' then if v==nil then return '' end return tostring(v) end\n"
    .. "  local s\n"
    .. "  local p = fixed or _PREC\n"
    .. "  if p and p >= 0 then\n"
    .. "    s = string.format('%.'..p..'f', v)\n"
    .. "    if s:find('%.') then s = s:gsub('0+$',''):gsub('%.$','') end\n"
    .. "  else s = tostring(v) end\n"
    .. "  return (s:gsub('%.', sep, 1))\n"
    .. "end\n",
    "local function _fmt(v) return _show(v, _SEPT) end\n",
    "local function _fmtm(v) return _show(v, _SEPM) end\n",
  }

  local body_lines = {}
  local lineno = 0
  local pending_obj = nil
  local pending_let = nil

  for srcline in (src .. "\n"):gmatch("(.-)\n") do
    lineno = lineno + 1
    local line = srcline

    if pending_obj then
      pending_obj.buf[#pending_obj.buf + 1] = line
      if line:match(">%s*$") then
        local whole = table.concat(pending_obj.buf, "\n")
        local inner = whole:match("^%s*<%s*fn%s*(.-)>%s*$")
        if not inner then
          error("texecole: line " .. pending_obj.startline
              .. ": malformed <fn ...> object", 0)
        end

        body_lines[#body_lines + 1] = {fnreg = pending_obj.name,
          fninner = inner, lineno = pending_obj.startline}
        pending_obj = nil
      end
      goto continue
    end

    if pending_let then
      pending_let.buf[#pending_let.buf + 1] = line
      pending_let.depth = pending_let.depth + U.raw_brace_delta(line)
      if pending_let.depth <= 0 then
        body_lines[#body_lines + 1] = {var = pending_let.name,
          expr = table.concat(pending_let.buf, " "),
          lineno = pending_let.startline}
        pending_let = nil
      end
      goto continue
    end
    do
      local vn, vexpr = line:match("^%s*let%s+([%a_][%w_]*)%s*=%s*({.*)$")
      if vn then
        local d = U.raw_brace_delta(vexpr)
        if d > 0 then
          warn_if_shadows(vn, lineno)
          pending_let = {name = vn, buf = {vexpr}, depth = d, startline = lineno}
          goto continue
        end
      end
    end

    do
      local oname, orest = line:match("^%s*let%s+([%a_][%w_]*)%s*=%s*<%s*fn%f[%s>](.*)$")
      if oname then
        warn_if_shadows(oname, lineno)
        if orest:match(">%s*$") then

          local inner = orest:gsub(">%s*$", "")
          body_lines[#body_lines + 1] = {fnreg = oname, fninner = inner,
                                         lineno = lineno}
        else
          pending_obj = {name = oname, buf = { "<fn " .. orest },
                         startline = lineno}
        end
        goto continue
      end
    end

    do
      local orest = line:match("^%s*<%s*fn%f[%s>](.*)$")
      if orest then
        if orest:match(">%s*$") then
          local inner = orest:gsub(">%s*$", "")
          body_lines[#body_lines + 1] = {fnreg = false, fninner = inner,
                                         lineno = lineno}
        else
          pending_obj = {name = nil, buf = { "<fn " .. orest },
                         startline = lineno}
        end
        goto continue
      end
    end

    do
      local lead, rest = line:match("^(%s*)\\(%%.*)$")
      if lead then
        line = lead .. rest
      elseif line:match("^%s*%%") then
        goto continue
      end
    end
    local name, params, rhs = line:match("^%s*let%s+([%a_][%w_]*)%s*{(.-)}%s*=%s*(.+)$")
    if name then
      warn_if_shadows(name, lineno)
      local plist = {}
      for p in params:gmatch("[%a_][%w_]*") do plist[#plist + 1] = p end
      local barhs = rhs:match("^%s*<(.-)>%s*$")
      local bblock, bopts = nil, {}
      if barhs then
        for w in barhs:gmatch("%S+") do
          if not bblock and sl._blocks[w] then
            bblock = w
          else
            bopts[#bopts + 1] = w
          end
        end
      end
      if bblock then
        BLOCKALIAS[name] = {block = bblock,
                            opts = table.concat(bopts, " "),
                            params = plist}
      else
        MACRO[name] = {params = plist, body = rhs}
      end
    else
      local an, arhs = line:match("^%s*let%s+([%a_][%w_]*)%s*=%s*<(.-)>%s*$")
      if an then
        warn_if_shadows(an, lineno)
        local blockname, opts = nil, {}
        for w in arhs:gmatch("%S+") do
          if not blockname and sl._blocks[w] then
            blockname = w
          else
            opts[#opts + 1] = w
          end
        end
        if blockname then
          BLOCKALIAS[an] = {block = blockname,
                            opts = table.concat(opts, " "),
                            params = {}}
          local words = {}
          for w in arhs:gmatch("%S+") do words[#words + 1] = w end
          ALIAS[an] = STYLE.resolve_styles(words, ALIAS)
        else
          local words = {}
          for w in arhs:gmatch("%S+") do words[#words + 1] = w end
          ALIAS[an] = STYLE.resolve_styles(words, ALIAS)
        end
      else
        local vn, vexpr = line:match("^%s*let%s+([%a_][%w_]*)%s*=%s*(.+)$")
        if vn then
          body_lines[#body_lines + 1] = {var = vn, expr = vexpr, lineno = lineno}
        else
          body_lines[#body_lines + 1] = {text = line, lineno = lineno}
        end
      end
    end
    ::continue::
  end

  do
    local depth, first_open = 0, nil
    for _, e in ipairs(body_lines) do
      local l = e.text
      if l then
        local d = U.raw_brace_delta(l)
        if d > 0 and not first_open then first_open = e.lineno end
        depth = depth + d
        if depth < 0 then
          error("texecole: line " .. (e.lineno or "?")
              .. ": unbalanced '}' (a closing brace with no matching opener; "
              .. "to print a literal brace, double it as {{ }})", 0)
        end
      end
    end
    if depth > 0 then
      error("texecole: line " .. (first_open or "?")
          .. ": unbalanced '{' (an opening brace is never closed; to print a "
          .. "literal brace, double it as {{ }})", 0)
    end
  end

  process_lines(code, body_lines)

  code[#code + 1] = "return table.concat(_parts)\n"
  return table.concat(code)
end

local function collapse_par(s)
  local prev
  repeat
    prev = s
    s = s:gsub("(\\par[%s}]*)\\par", "%1")
  until s == prev
  return s
end

MATH.decsep = "{,}"

function sl.padding_spec(override)
  local p = tostring(override or (sl.config and sl.config.padding) or "2")
  local t, r, b, l = p:match(
    "^%s*([%d%.]+)%s*;%s*([%d%.]+)%s*;%s*([%d%.]+)%s*;%s*([%d%.]+)%s*$")
  if t then
    return "boxsep=0mm, top=" .. t .. "mm, right=" .. r
        .. "mm, bottom=" .. b .. "mm, left=" .. l .. "mm"
  end
  return "boxsep=" .. p .. "mm, left=0mm, right=0mm, top=0mm, bottom=0mm"
end

function sl.transpile(src)
  ALIAS, MACRO, BLOCKALIAS = {}, {}, {}
  sl._objects = {}
  sl._line = nil
  scopes_reset()

  src = src:gsub("\r\n?", "\n")
  local lang = (sl.config and sl.config.lang) or "fr"
  MATH.decsep = (lang == "en") and "." or "{,}"
  NUMEVAL.set_precision((sl.config and sl.config.precision) or -1)
  local okb, lua_code = pcall(build_lua, src)
  if not okb then
    local msg = tostring(lua_code):gsub("^.-:%d+: ", "")
    msg = msg:gsub("^sl: ", ""):gsub("^texecole: ", "")
    if sl._line then
      error("texecole: line " .. sl._line .. ": " .. msg, 0)
    end
    error("texecole: " .. msg, 0)
  end
  _G.vector = _G.vector or function(...)
    local c = {...}
    if #c < 2 then
      error("texecole: vector(x, y) needs at least two components, got "
          .. #c)
    end
    return c
  end
  _G.__drawbuild = sl.build_figure_block
  _G.__statsbuild = sl.build_stats_runtime
  local chunk, err = load(lua_code, "=sl-body")
  if not chunk then
    if os.getenv("TEXECOLE_DEBUG") then
      local f = io.open("sl-body-dump.lua", "w")
      if f then f:write(lua_code); f:close() end
    end
    error("texecole: transpilation error\n" .. err)
  end
  local ok, result = pcall(chunk)
  if not ok then
    error("texecole: execution error\n" .. tostring(result), 0)
  end
  return collapse_par(result)
end

local function print_par_lines(out)
  out = out:gsub("\n", " ")
  local lines = {}
  for seg in (out .. "\\par "):gmatch("(.-)\\par%f[%A]") do
    lines[#lines + 1] = seg
    lines[#lines + 1] = "\\par"
  end
  tex.print(lines)
end

function sl.inject(body)
  local LECTEUR = require("texecole-lecteur")
  print_par_lines(sl.transpile(LECTEUR.traduire(body)))
end

function sl.respace(macro)
  local v = token.get_macro(macro)
  if not v then return end
  v = v:gsub("(%l)(%u)", "%1 %2"):gsub("(%u)(%u%l)", "%1 %2")
  token.set_macro(macro, v)
end

sl._mathlite = MATH.mathlite

sl.use("texecole-box")
sl.use("texecole-table")
sl.use("texecole-img")
sl.use("texecole-section")
sl.use("texecole-grid")
sl.use("texecole-list")
sl.use("texecole-matrix")
sl.use("texecole-vartab")
sl.use("texecole-signtab")
sl.use("texecole-numberline")
sl.use("texecole-posedop")
sl.use("texecole-quadratic")
sl.use("texecole-lycee")
sl.use("texecole-nombres")
sl.use("texecole-espace")
sl.use("texecole-graphe")
sl.use("texecole-college")
sl.use("texecole-tree")
sl.use("texecole-stats")
sl.use("texecole-plot")
sl.use("texecole-figure")
sl.use("texecole-toc")
texio.write_nl("texecole 1.1 (build " .. sl._BUILD .. ")")
sl.use("texecole-calc")
sl.use("texecole-sympy")
sl.use("texecole-scipy")

return sl
