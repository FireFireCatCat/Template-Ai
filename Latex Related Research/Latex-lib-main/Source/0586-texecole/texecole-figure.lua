local U = require("texecole-util")
local NE = require("texecole-numeval")

local SL

local sin = function(d) return math.sin(math.rad(d)) end
local cos = function(d) return math.cos(math.rad(d)) end

local function num(v, what)
  local stripped = (v or ""):gsub("^%((.*)%)$", "%1")
  local x = tonumber(stripped)
  if not x then error("texecole: <draw> "..what.." must be a number, got '"..tostring(v).."'") end
  return x
end
local function numlist(v, what)
  v = (v or ""):gsub("^%((.*)%)$", "%1")
  local t = {}
  for piece in v:gmatch("[^,]+") do
    local x = tonumber(U.trim(piece))
    if not x then error("texecole: <draw> "..what.." must be numbers, got '"..piece.."'") end
    t[#t+1] = x
  end
  return t
end

local Tri = {}
function Tri.equilateral(P,s) return {{P[1],0,0},{P[2],s,0},{P[3],s*cos(60),s*sin(60)}}, {sides="all"} end
function Tri.isosceles(P,e,b)
  local d=e*e-(b/2)*(b/2)
  if d<=0 then return nil,"equal side too short for the given base" end
  local h=math.sqrt(d)
  return {{P[1],b/2,h},{P[2],0,0},{P[3],b,0}}, {sides={{1,2},{1,3}}}
end
function Tri.right(P,p,q,at)
  at=at or 1
  local v={}; v[at]={P[at],0,0}
  local i2=(at%3)+1; local i3=(i2%3)+1
  v[i2]={P[i2],p,0}; v[i3]={P[i3],0,q}
  return v,{right=at}
end
function Tri.sss(P,a,b,c)
  local cosA=(a*a+c*c-b*b)/(2*a*c)
  if cosA<-1 or cosA>1 then return nil,"sides violate the triangle inequality" end
  local A=math.deg(math.acos(cosA))
  return {{P[1],0,0},{P[2],a,0},{P[3],c*cos(A),c*sin(A)}}, {}
end
function Tri.sas(P,a,b,t) return {{P[1],0,0},{P[2],a,0},{P[3],b*cos(t),b*sin(t)}}, {} end
function Tri.asa(P,angA,angB,c)
  if angA+angB>=180 then return nil,"the two given angles sum to 180 degrees or more" end
  local angC=180-angA-angB
  local AC=c*sin(angB)/sin(angC)
  return {{P[1],0,0},{P[2],c,0},{P[3],AC*cos(angA),AC*sin(angA)}}, {}
end

local Quad = {}
function Quad.square(P,s) return {{P[1],0,0},{P[2],s,0},{P[3],s,s},{P[4],0,s}}, {sides="all",right="all"} end
function Quad.rectangle(P,w,h) return {{P[1],0,0},{P[2],w,0},{P[3],w,h},{P[4],0,h}},
  {right="all", sides={{1,2,1},{3,4,1},{2,3,2},{4,1,2}}} end
function Quad.rhombus(P,s,t) return {{P[1],0,0},{P[2],s,0},{P[3],s+s*cos(t),s*sin(t)},{P[4],s*cos(t),s*sin(t)}}, {sides="all"} end
function Quad.parallelogram(P,a,b,t) return {{P[1],0,0},{P[2],a,0},{P[3],a+b*cos(t),b*sin(t)},{P[4],b*cos(t),b*sin(t)}},
  {sides={{1,2,1},{3,4,1},{2,3,2},{4,1,2}}} end
function Quad.trapezoid(P,b1,b2,h,offset)
  local o=offset or (b1-b2)/2
  return {{P[1],0,0},{P[2],b1,0},{P[3],o+b2,h},{P[4],o,h}}, {}
end

function Quad.kite(P,a,b,t)
  local half=math.rad(t/2)
  local hx=a*math.sin(half)
  local ay=a*math.cos(half)

  local inside=b*b-hx*hx
  if inside<=0 then
    return nil, string.format(
      "lower side b=%g too short for upper side a=%g at apex %g° "
      .. "(need b > a·sin(%g°) = %.3f) — the kite would flatten to a triangle",
      b, a, t, t/2, hx)
  end
  local cy=ay+math.sqrt(inside)

  return {{P[1],0,0},{P[2],hx,-ay},{P[3],0,-cy},{P[4],-hx,-ay}},
         {sides={{1,2,1},{1,4,1},{2,3,2},{3,4,2}}}
end

local Circle = {}

function Circle.circumscribed(ax,ay,bx,by,cx,cy)
  local d=2*(ax*(by-cy)+bx*(cy-ay)+cx*(ay-by))
  if math.abs(d)<1e-9 then return nil end
  local a2,b2,c2=ax*ax+ay*ay, bx*bx+by*by, cx*cx+cy*cy
  local ux=(a2*(by-cy)+b2*(cy-ay)+c2*(ay-by))/d
  local uy=(a2*(cx-bx)+b2*(ax-cx)+c2*(bx-ax))/d
  local r=math.sqrt((ux-ax)^2+(uy-ay)^2)
  return ux,uy,r
end

function Circle.inscribed(ax,ay,bx,by,cx,cy)
  local a=math.sqrt((bx-cx)^2+(by-cy)^2)
  local b=math.sqrt((ax-cx)^2+(ay-cy)^2)
  local c=math.sqrt((ax-bx)^2+(ay-by)^2)
  local p=a+b+c
  if p<1e-9 then return nil end
  local ix=(a*ax+b*bx+c*cx)/p
  local iy=(a*ay+b*by+c*cy)/p
  local s=p/2
  local area=math.abs((bx-ax)*(cy-ay)-(cx-ax)*(by-ay))/2
  return ix,iy,area/s
end

local function regular_polygon(P,s)
  local n=#P; s=s or 1
  local R=s/(2*math.sin(math.pi/n))
  local verts={}
  local a0=-90-180/n
  for k=1,n do
    local ang=a0+(k-1)*360/n
    verts[#verts+1]={P[k],R*cos(ang),R*sin(ang)}
  end
  return verts,{sides="all"}
end

local function compute(line, dict)
  local tag, rest = line:match("^%s*(%S+)%s*(.*)$")
  rest = U.trim(rest or "")

  local P, optstr = {}, {}
  if rest:sub(1,1) == "(" then
    local inside, after = rest:match("^(%b())%s*(.*)$")
    if not inside then error("texecole: <draw> "..tag.." has an unclosed '(' in its point list") end
    for nm in inside:sub(2,-2):gmatch("[^,]+") do
      local t = U.trim(nm)
      if t ~= "" then P[#P+1] = t end
    end
    for w in after:gmatch("%S+") do optstr[#optstr+1] = w end
  else
    local words={}
    for w in rest:gmatch("%S+") do words[#words+1]=w end
    local points=nil
    for _,w in ipairs(words) do
      if not points and w:match("^%a+$") and not w:match(":") then points=w
      else optstr[#optstr+1]=w end
    end
    if not points then error("texecole: <draw> "..tag.." needs point names, e.g. "..tag.." ABC ...") end
    for ch in points:gmatch("%a") do P[#P+1]=ch end
  end

  local attrs=U.parse_attrs(table.concat(optstr," "),{
    tag="figure",
    on_bare=function(word,a)
      if word:match("^right:%a$") then a.right=word:sub(7); return true end
      a[word]=true; return true
    end,
  })

  local pointset = {}
  local all_single = true
  for _, ch in ipairs(P) do
    pointset[ch] = true
    if #ch ~= 1 then all_single = false end
  end

  if tag=="segment" or tag=="ray" or tag=="line" then
    local A = P[1] or "A"
    local B = P[2] or "B"
    local lstr = (attrs.length or ""):gsub(",", ".")
    local len = tonumber(lstr)
    if not len then
      len = (attrs.measures == "mm") and 3 or 4
    elseif attrs.measures == "mm" then
      len = len / 10
    end
    return nil, nil, nil, nil,
      { construct = tag, a = A, b = B, x1 = 0, y1 = 0, x2 = len, y2 = 0,
        measures = attrs.measures, color = attrs.color }
  end

  local named_sides = {}
  if all_single then
    for k, v in pairs(attrs) do
      if type(k) == "string" and #k == 2
         and pointset[k:sub(1,1)] and pointset[k:sub(2,2)] then
        local x = tonumber(v)
        if not x then error("texecole: <draw> side " .. k .. " must be a number, got '" .. tostring(v) .. "'") end
        named_sides[k] = x
        named_sides[k:sub(2,2)..k:sub(1,1)] = x
      end
    end
  end

  if dict then
    local function dist(n1,n2)
      local p,q=dict[n1],dict[n2]
      if p and q then return math.sqrt((q[1]-p[1])^2+(q[2]-p[2])^2) end
    end
    local known_edge
    for k=1,#P do
      local d=dist(P[k], P[(k % #P)+1])
      if d then known_edge=d; break end
    end
    if known_edge then
      local function fmt(x)
        return (("%.6f"):format(x)):gsub("%.?0+$","")
      end

      if not attrs.side and (attrs.equilateral or tag=="square" or tag=="rhombus") then
        attrs.side = fmt(known_edge)
      end
    end
  end

  if tag=="circle" then
    if attrs.radius or attrs.diameter then
      if #P~=1 then
        error("texecole: circle by radius needs exactly one point, the centre, "
            .. "e.g. circle O radius:3")
      end

      local function length_value(v, what)
        local n = tonumber(v)
        if n then return n end
        if type(v)=="string" and #v==2 then
          local p,q = dict and dict[v:sub(1,1)], dict and dict[v:sub(2,2)]
          if p and q then
            return math.sqrt((q[1]-p[1])^2+(q[2]-p[2])^2)
          end
        end
        error("texecole: circle "..what..":"..tostring(v).." must be a number "
            .. "or two already-placed points naming a segment, e.g. "..what..":AB")
      end
      local r = attrs.radius and length_value(attrs.radius,"radius")
             or length_value(attrs.diameter,"diameter")/2
      local C = dict and dict[P[1]]
      local cx,cy = C and C[1] or 0, C and C[2] or 0
      return nil, {}, attrs, {name=P[1], cx=cx, cy=cy, r=r}
    end
    if #P~=3 then
      error("texecole: circle through points needs three points "
          .. "(circle ABC), or a centre with radius:/diameter:")
    end
    local function pt(ch)
      local q = dict and dict[ch]
      if not q then
        error("texecole: circle "..table.concat(P).." needs A, B, C already "
            .. "placed by an earlier figure; or give a centre with radius:")
      end
      return q[1], q[2]
    end
    local ax,ay=pt(P[1]); local bx,by=pt(P[2]); local cxp,cyp=pt(P[3])
    local ux,uy,r
    if attrs.inscribed then
      ux,uy,r=Circle.inscribed(ax,ay,bx,by,cxp,cyp)
    else
      ux,uy,r=Circle.circumscribed(ax,ay,bx,by,cxp,cyp)
    end
    if not ux then
      error("texecole: circle "..table.concat(P).." — the three points are "
          .. "collinear, no circle through them")
    end
    return nil, {}, attrs, {cx=ux, cy=uy, r=r}
  end

  local verts,marks
  if tag=="triangle" then
    if #P~=3 then error("texecole: triangle needs 3 points, got "..#P) end
    if attrs.equilateral then verts,marks=Tri.equilateral(P,num(attrs.side,"side"))
    elseif attrs.isosceles then verts,marks=Tri.isosceles(P,num(attrs.side,"side"),num(attrs.base,"base"))
    elseif attrs.right~=nil then
      local at=1
      if type(attrs.right)=="string" then for k,ch in ipairs(P) do if ch==attrs.right then at=k end end end

      local i2=(at%3)+1
      local i3=(i2%3)+1

      local function leg_len(other_idx)
        local key = P[at]..P[other_idx]
        if named_sides[key] then return named_sides[key] end
        if dict and dict[P[at]] and dict[P[other_idx]] then
          local p,q=dict[P[at]],dict[P[other_idx]]
          return math.sqrt((q[1]-p[1])^2+(q[2]-p[2])^2)
        end
        return nil
      end
      local p = leg_len(i2)
      local q = leg_len(i3)

      if (not p or not q) and attrs.sides then
        local s=numlist(attrs.sides,"sides")
        if #s==2 then p = p or s[1]; q = q or s[2] end
      end
      if not p or not q then
        error("texecole: triangle right needs the two legs — give sides:(p,q), "
            .. "or name a side like " .. P[at]..P[i2] .. ":6, or share an edge")
      end
      verts,marks=Tri.right(P,p,q,at)
    elseif attrs.sides and attrs.angle then
      local s=numlist(attrs.sides,"sides")
      if #s~=2 then error("texecole: triangle sides:(a,b) angle:t needs two sides") end
      verts,marks=Tri.sas(P,s[1],s[2],num(attrs.angle,"angle"))
    elseif attrs.sides then
      local s=numlist(attrs.sides,"sides")
      if #s~=3 then error("texecole: triangle sides:(a,b,c) needs three sides, or add angle: for two sides") end
      verts,marks=Tri.sss(P,s[1],s[2],s[3])
    elseif attrs.angles and attrs.side then
      local a=numlist(attrs.angles,"angles")
      if #a~=2 then error("texecole: triangle angles:(A,B) needs two angles") end
      verts,marks=Tri.asa(P,a[1],a[2],num(attrs.side,"side"))
    elseif named_sides[P[1]..P[2]] and named_sides[P[2]..P[3]] and named_sides[P[3]..P[1]] then

      verts,marks=Tri.sss(P, named_sides[P[1]..P[2]],
                            named_sides[P[2]..P[3]],
                            named_sides[P[3]..P[1]])
    else error("texecole: triangle needs a definition: equilateral side:s, isosceles side:e base:b, right sides:(p,q), sides:(a,b,c), named sides AB:.. BC:.. CA:.., sides:(a,b) angle:t, or angles:(A,B) side:c") end
  elseif tag=="square" then
    if #P~=4 then error("texecole: square needs 4 points") end
    if not attrs.side then error("texecole: square needs side:s (or a shared edge to deduce it from)") end
    verts,marks=Quad.square(P,num(attrs.side,"side"))
  elseif tag=="rectangle" then
    if #P~=4 then error("texecole: rectangle needs 4 points") end
    local s=numlist(attrs.sides,"sides")
    if #s~=2 then error("texecole: rectangle needs sides:(w,h)") end
    verts,marks=Quad.rectangle(P,s[1],s[2])
  elseif tag=="rhombus" then
    if #P~=4 then error("texecole: rhombus needs 4 points") end
    if not attrs.side then error("texecole: rhombus needs side:s (or a shared edge to deduce it from)") end
    verts,marks=Quad.rhombus(P,num(attrs.side,"side"),num(attrs.angle,"angle"))
  elseif tag=="parallelogram" then
    if #P~=4 then error("texecole: parallelogram needs 4 points") end
    local s=numlist(attrs.sides,"sides")
    if #s~=2 then error("texecole: parallelogram needs sides:(a,b) angle:t") end
    verts,marks=Quad.parallelogram(P,s[1],s[2],num(attrs.angle,"angle"))
  elseif tag=="trapezoid" then
    if #P~=4 then error("texecole: trapezoid needs 4 points") end
    local b=numlist(attrs.bases,"bases")
    if #b~=2 then error("texecole: trapezoid needs bases:(b1,b2) height:h") end
    local off=attrs.offset and num(attrs.offset,"offset") or nil
    verts,marks=Quad.trapezoid(P,b[1],b[2],num(attrs.height,"height"),off)
  elseif tag=="kite" then
    if #P~=4 then error("texecole: kite needs 4 points") end
    local s=numlist(attrs.sides,"sides")
    if #s~=2 then error("texecole: kite needs sides:(a,b) angle:t — a the two "
                      .. "upper sides, b the two lower, t the apex angle") end
    verts,marks=Quad.kite(P,s[1],s[2],num(attrs.angle,"angle"))
  elseif tag=="polygon" or tag=="pentagon" or tag=="hexagon" or tag=="octagon" then
    local need = ({pentagon=5, hexagon=6, octagon=8})[tag]
    if need and #P~=need then
      error("texecole: "..tag.." needs "..need.." points, got "..#P)
    end
    if #P<3 then error("texecole: polygon needs at least 3 points") end
    verts,marks=regular_polygon(P,attrs.side and num(attrs.side,"side") or 1)
  else error("texecole: <draw> unknown figure '"..tag.."'") end

  if not verts then
    local why = (type(marks) == "string") and marks or "impossible figure"
    error("texecole: "..tag.." — "..why)
  end

  if attrs.rotate then
    local th = tonumber(attrs.rotate)
    if not th then
      error("texecole: rotate: must be a number of degrees, got '"..tostring(attrs.rotate).."'")
    end
    local a = math.rad(th)
    local ca, sa = math.cos(a), math.sin(a)
    local ox, oy = verts[1][2], verts[1][3]
    for _, v in ipairs(verts) do
      local dx, dy = v[2]-ox, v[3]-oy
      v[2] = ox + dx*ca - dy*sa
      v[3] = oy + dx*sa + dy*ca
    end
  end

  return verts,marks or {},attrs
end

local function graft(verts,dict)
  local known={}
  for i,v in ipairs(verts) do if dict[v[1]] then known[#known+1]={i,v[1]} end end
  if #known==0 then return verts end
  if #known==1 then
    local i,name=known[1][1],known[1][2]
    local dx=dict[name][1]-verts[i][2]
    local dy=dict[name][2]-verts[i][3]
    local out={}
    for _,v in ipairs(verts) do out[#out+1]={v[1],v[2]+dx,v[3]+dy} end
    return out
  end
  local a,b=known[1],known[2]
  local la={verts[a[1]][2],verts[a[1]][3]}
  local lb={verts[b[1]][2],verts[b[1]][3]}
  local ga=dict[a[2]]; local gb=dict[b[2]]
  local llen=math.sqrt((lb[1]-la[1])^2+(lb[2]-la[2])^2)
  local glen=math.sqrt((gb[1]-ga[1])^2+(gb[2]-ga[2])^2)
  if math.abs(llen-glen)>1e-3*math.max(glen,1) then
    error("texecole: <draw> cannot graft '"..a[2]..b[2].."': shared side length "
      ..string.format("%.2f",llen).." differs from the existing "
      ..string.format("%.2f",glen).." — make the measurements match")
  end
  local ang_l=math.atan(lb[2]-la[2],lb[1]-la[1])
  local ang_g=math.atan(gb[2]-ga[2],gb[1]-ga[1])
  local r=ang_g-ang_l
  local cr,sr=math.cos(r),math.sin(r)
  local out={}
  for _,v in ipairs(verts) do
    local x,y=v[2]-la[1],v[3]-la[2]
    out[#out+1]={v[1], x*cr-y*sr+ga[1], x*sr+y*cr+ga[2]}
  end

  local ex, ey = gb[1]-ga[1], gb[2]-ga[2]
  local function side_of(px, py)
    return (px-ga[1])*ey - (py-ga[2])*ex
  end
  local shared = { [a[2]]=true, [b[2]]=true }

  local exsum, eysum, ecnt = 0, 0, 0
  for name, p in pairs(dict) do
    if not shared[name] then exsum=exsum+p[1]; eysum=eysum+p[2]; ecnt=ecnt+1 end
  end

  local nxsum, nysum, ncnt = 0, 0, 0
  for _, v in ipairs(out) do
    if not shared[v[1]] then nxsum=nxsum+v[2]; nysum=nysum+v[3]; ncnt=ncnt+1 end
  end
  if ecnt > 0 and ncnt > 0 then
    local se = side_of(exsum/ecnt, eysum/ecnt)
    local sn = side_of(nxsum/ncnt, nysum/ncnt)
    if se ~= 0 and sn ~= 0 and (se > 0) == (sn > 0) then

      local elen2 = ex*ex + ey*ey
      local ref = {}
      for _, v in ipairs(out) do
        local wx, wy = v[2]-ga[1], v[3]-ga[2]
        local dot = (wx*ex + wy*ey) / elen2
        local projx, projy = dot*ex, dot*ey
        ref[#ref+1] = {v[1], ga[1]+2*projx-wx, ga[2]+2*projy-wy}
      end
      out = ref
    end
  end
  return out
end

local function emit_figure_inner(f,opts,measured,ticked)

  measured = measured or {}
  ticked   = ticked   or {}

  if f.construct then
    local c = f.construct
    local x1, y1, x2, y2 = c.x1, c.y1, c.x2, c.y2
    local col = c.color and ("[" .. c.color .. "]") or ""
    local t = {}
    local dx, dy = x2 - x1, y2 - y1
    local L = math.sqrt(dx*dx + dy*dy); L = math.max(L, 1e-6)
    local ux, uy = dx / L, dy / L
    if c.construct == "line" then
      local e = 0.6
      t[#t+1] = string.format("\\draw%s (%.4f,%.4f) -- (%.4f,%.4f);",
        col, x1 - ux*e, y1 - uy*e, x2 + ux*e, y2 + uy*e)
    elseif c.construct == "ray" then
      local e = 0.9
      t[#t+1] = string.format("\\draw%s (%.4f,%.4f) -- (%.4f,%.4f);",
        col, x1, y1, x2 + ux*e, y2 + uy*e)
    else
      t[#t+1] = string.format("\\draw%s (%.4f,%.4f) -- (%.4f,%.4f);",
        col, x1, y1, x2, y2)
    end
    t[#t+1] = string.format("\\fill (%.4f,%.4f) circle [radius=0.04];", x1, y1)
    t[#t+1] = string.format("\\fill (%.4f,%.4f) circle [radius=0.04];", x2, y2)
    t[#t+1] = string.format("\\node[below=2pt] at (%.4f,%.4f) {$%s$};",
      x1, y1, c.a)
    t[#t+1] = string.format("\\node[below=2pt] at (%.4f,%.4f) {$%s$};",
      x2, y2, c.b)
    local munit = c.measures
    if munit == "cm" or munit == "mm" then
      local px, py = -uy, ux
      local mx, my = (x1 + x2) / 2, (y1 + y2) / 2
      local value = (munit == "mm") and L*10 or L
      local label = NE.display(value, ",", 2) .. "\\," .. munit
      t[#t+1] = string.format(
        "\\node[above=1pt] at (%.4f,%.4f) {\\footnotesize $%s$};",
        mx + px*0.25, my + py*0.25,
        NE.display(value, "{,}", 2) .. "\\," .. munit)
    end
    return table.concat(t, "\n")
  end

  if f.point then
    local p=f.point
    return string.format("\\fill (%.4f,%.4f) circle [radius=0.05];",p.x,p.y)
  end

  if f.segment then
    local s=f.segment
    local t={string.format("\\draw (%.4f,%.4f) -- (%.4f,%.4f);",s.x1,s.y1,s.x2,s.y2)}
    local munit=opts.measures
    if munit=="cm" or munit=="mm" then
      local dx,dy=s.x2-s.x1,s.y2-s.y1
      local lcm=math.sqrt(dx*dx+dy*dy); local l=math.max(lcm,1e-6)
      local mx,my=(s.x1+s.x2)/2,(s.y1+s.y2)/2
      local px,py=-dy/l,dx/l
      local ang=math.deg(math.atan(dy,dx))
      if ang>90 then ang=ang-180 elseif ang<=-90 then ang=ang+180 end
      local value=(munit=="mm") and lcm*10 or lcm
      local label=NE.display(value, ".", 2).." "..munit
      t[#t+1]=string.format("\\node[rotate=%.2f] at (%.4f,%.4f) {\\footnotesize %s};",
        ang,mx+px*0.28,my+py*0.28,label)
    end
    return table.concat(t,"\n")
  end

  if f.circle then
    local c=f.circle
    local t={}
    t[#t+1]=string.format("\\draw (%.4f,%.4f) circle [radius=%.4f];",c.cx,c.cy,c.r)
    t[#t+1]=string.format("\\fill (%.4f,%.4f) circle [radius=0.04];",c.cx,c.cy)
    local munit=opts.measures
    if munit=="cm" or munit=="mm" then
      t[#t+1]=string.format("\\draw (%.4f,%.4f) -- (%.4f,%.4f);",
        c.cx,c.cy, c.cx+c.r,c.cy)
      local value=(munit=="mm") and c.r*10 or c.r
      local label=NE.display(value, ".", 2).." "..munit
      t[#t+1]=string.format("\\node at (%.4f,%.4f) {\\footnotesize %s};",
        c.cx+c.r/2, c.cy+0.28, label)
    end
    return table.concat(t,"\n")
  end

  local verts,marks=f.verts,f.marks
  local t={}
  for _,v in ipairs(verts) do t[#t+1]=string.format("\\coordinate (%s) at (%.4f,%.4f);",v[1],v[2],v[3]) end
  local names={}
  for _,v in ipairs(verts) do names[#names+1]="("..v[1]..")" end
  t[#t+1]="\\draw "..table.concat(names," -- ").." -- cycle;"

  if opts.marks=="on" then
    local function unit(ax,ay,bx,by)
      local dx,dy=bx-ax,by-ay; local l=math.max(math.sqrt(dx*dx+dy*dy),1e-6)
      return dx/l,dy/l
    end
    local function rightsquare(idx)
      local nx,ny=verts[idx][2],verts[idx][3]
      local i2=(idx%#verts)+1; local i3=((idx-2)%#verts)+1
      local u1x,u1y=unit(nx,ny,verts[i2][2],verts[i2][3])
      local u2x,u2y=unit(nx,ny,verts[i3][2],verts[i3][3])
      local d=0.3
      t[#t+1]=string.format("\\draw (%.4f,%.4f) -- (%.4f,%.4f) -- (%.4f,%.4f);",
        nx+u1x*d,ny+u1y*d, nx+u1x*d+u2x*d,ny+u1y*d+u2y*d, nx+u2x*d,ny+u2y*d)
    end
    if marks.right and marks.right~="all" then rightsquare(marks.right)
    elseif marks.right=="all" then

      for k=1,#verts do
        local i2=(k%#verts)+1; local i3=((k-2)%#verts)+1
        local u1x,u1y=unit(verts[k][2],verts[k][3],verts[i2][2],verts[i2][3])
        local u2x,u2y=unit(verts[k][2],verts[k][3],verts[i3][2],verts[i3][3])
        if math.abs(u1x*u2x+u1y*u2y) < 1e-6 then rightsquare(k) end
      end
    end
    local edges={}
    if marks.sides=="all" then for k=1,#verts do edges[#edges+1]={k,(k%#verts)+1} end
    elseif type(marks.sides)=="table" then for _,pr in ipairs(marks.sides) do edges[#edges+1]=pr end end
    for _,e in ipairs(edges) do

      local na,nb=verts[e[1]][1],verts[e[2]][1]
      local key=(na<nb) and (na.."\1"..nb) or (nb.."\1"..na)
      if not ticked[key] then
        ticked[key]=true
        local ax,ay=verts[e[1]][2],verts[e[1]][3]
        local bx,by=verts[e[2]][2],verts[e[2]][3]
        local mx,my=(ax+bx)/2,(ay+by)/2
        local dx,dy=bx-ax,by-ay; local l=math.max(math.sqrt(dx*dx+dy*dy),1e-6)
        local px,py=-dy/l,dx/l; local s=0.12

        local mult=e[3] or 1
        local ux,uy=dx/l,dy/l; local gap=0.08
        for m=1,mult do
          local off=((m-1)-(mult-1)/2)*gap
          local ox,oy=mx+ux*off,my+uy*off
          t[#t+1]=string.format("\\draw (%.4f,%.4f) -- (%.4f,%.4f);",
            ox-px*s,oy-py*s,ox+px*s,oy+py*s)
        end
      end
    end
  end

  local munit=opts.measures
  if munit=="cm" or munit=="mm" then
    local cx,cy,n=0,0,#verts
    for _,v in ipairs(verts) do cx=cx+v[2]; cy=cy+v[3] end
    cx,cy=cx/math.max(n,1),cy/math.max(n,1)
    for k=1,#verts do
      local a,b=verts[k],verts[(k%#verts)+1]

      local na,nb=a[1],b[1]
      local key=(na<nb) and (na.."\1"..nb) or (nb.."\1"..na)
      if not measured[key] then
        measured[key]=true
        local ax,ay,bx,by=a[2],a[3],b[2],b[3]
        local mx,my=(ax+bx)/2,(ay+by)/2
        local dx,dy=bx-ax,by-ay
        local lcm=math.sqrt(dx*dx+dy*dy)
        local l=math.max(lcm,1e-6)
        local px,py=-dy/l,dx/l

        if px*(mx-cx)+py*(my-cy) < 0 then px,py=-px,-py end
        local off=0.28
        local ang=math.deg(math.atan(dy,dx))
        if ang>90 then ang=ang-180 elseif ang<=-90 then ang=ang+180 end
        local value=(munit=="mm") and lcm*10 or lcm
        local label=NE.display(value, ".", 2).." "..munit
        t[#t+1]=string.format("\\node[rotate=%.2f] at (%.4f,%.4f) {\\footnotesize %s};",
          ang,mx+px*off,my+py*off,label)
      end
    end
  end

  return table.concat(t,"\n")
end

local function emit_labels(figs)
  local cx,cy,n=0,0,0
  local seen={}
  for _,f in ipairs(figs) do
    if f.verts then
      for _,v in ipairs(f.verts) do
        if not seen[v[1]] then seen[v[1]]=true; cx=cx+v[2]; cy=cy+v[3]; n=n+1 end
      end
    end
  end
  cx,cy=cx/math.max(n,1),cy/math.max(n,1)
  local t,placed={},{}
  for _,f in ipairs(figs) do
    if f.verts then
      for _,v in ipairs(f.verts) do
        if not placed[v[1]] then
          placed[v[1]]=true
          local dx,dy=v[2]-cx,v[3]-cy
          local l=math.max(math.sqrt(dx*dx+dy*dy),1e-6)
          t[#t+1]=string.format("\\node at (%.4f,%.4f) {$%s$};",v[2]+dx/l*0.35,v[3]+dy/l*0.35,v[1])
        end
      end
    elseif f.circle and f.circle.name and not placed[f.circle.name] then
      placed[f.circle.name]=true
      local c=f.circle
      t[#t+1]=string.format("\\node[below left] at (%.4f,%.4f) {$%s$};",c.cx,c.cy,c.name)
    end
  end

  for _,f in ipairs(figs) do
    if f.point and f.point.name and not placed[f.point.name] then
      placed[f.point.name]=true
      local px,py=f.point.x,f.point.y
      local sx,sy,m=0,0,0
      for _,g in ipairs(figs) do
        if g.segment then
          local s=g.segment
          local function near(ax,ay) return math.abs(ax-px)<1e-6 and math.abs(ay-py)<1e-6 end
          if near(s.x1,s.y1) then
            local dx,dy=s.x2-px,s.y2-py; local l=math.max(math.sqrt(dx*dx+dy*dy),1e-6)
            sx=sx+dx/l; sy=sy+dy/l; m=m+1
          elseif near(s.x2,s.y2) then
            local dx,dy=s.x1-px,s.y1-py; local l=math.max(math.sqrt(dx*dx+dy*dy),1e-6)
            sx=sx+dx/l; sy=sy+dy/l; m=m+1
          end
        end
      end
      local ox,oy
      if m>0 and (sx*sx+sy*sy)>1e-9 then
        local l=math.sqrt(sx*sx+sy*sy); ox,oy=-sx/l,-sy/l
      else
        ox,oy=0.7071,0.7071
      end
      t[#t+1]=string.format("\\node at (%.4f,%.4f) {$%s$};",px+ox*0.35,py+oy*0.35,f.point.name)
    end
  end
  return table.concat(t,"\n")
end

local circle_general
local build_block_synthetic

local function coord_pair(s, what)
  local inner = s:match("^%s*%((.*)%)%s*$")
  if not inner then
    error("texecole: <draw axes> "..what.." needs a coordinate pair (x, y), got '"..s.."'")
  end
  local a, b = inner:match("^%s*(.-)%s*,%s*(.-)%s*$")
  local x, y = tonumber(a), tonumber(b)
  if not x or not y then
    error("texecole: <draw axes> "..what.." pair must be two numbers, got '"..inner.."'")
  end
  return x, y
end

local function linear_terms(s)
  local a, b, c = 0, 0, 0
  local e = s:gsub("%s+", ""):gsub("%-", "+-")
  if e == "" then return 0,0,0 end
  if e:sub(1,1) == "+" then e = e:sub(2) end
  for term in (e.."+"):gmatch("(.-)%+") do
    if term ~= "" then
      if term:find("x", 1, true) then
        local co = term:gsub("x", "")
        if co=="" or co=="+" then co="1" elseif co=="-" then co="-1" end
        local n = tonumber(co)
        if not n then error("texecole: <draw axes> bad x-coefficient '"..term.."'") end
        a = a + n
      elseif term:find("y", 1, true) then
        local co = term:gsub("y", "")
        if co=="" or co=="+" then co="1" elseif co=="-" then co="-1" end
        local n = tonumber(co)
        if not n then error("texecole: <draw axes> bad y-coefficient '"..term.."'") end
        b = b + n
      else
        local n = tonumber(term)
        if not n then error("texecole: <draw axes> bad constant '"..term.."'") end
        c = c + n
      end
    end
  end
  return a, b, c
end

local function line_equation(eq)
  local lhs, rhs = eq:match("^(.-)=(.*)$")
  if not lhs then return nil, "a line equation needs an '=' (y=2x-1, x=3, 2x+3y=6)" end
  lhs, rhs = U.trim(lhs), U.trim(rhs)

  local la, lb, lc = linear_terms(lhs)
  local ra, rb, rc = linear_terms(rhs)
  local a, b, c0 = la-ra, lb-rb, lc-rc
  if a == 0 and b == 0 then
    return nil, "a line cannot have both x and y coefficients zero"
  end

  return {a, b, -c0}
end

local function clip_line(a, b, c, xmin, xmax, ymin, ymax)
  local pts = {}
  local function add(x, y)
    if x >= xmin-1e-9 and x <= xmax+1e-9 and y >= ymin-1e-9 and y <= ymax+1e-9 then
      pts[#pts+1] = {x, y}
    end
  end
  if math.abs(b) > 1e-12 then
    add(xmin, (c - a*xmin)/b)
    add(xmax, (c - a*xmax)/b)
  end
  if math.abs(a) > 1e-12 then
    add((c - b*ymin)/a, ymin)
    add((c - b*ymax)/a, ymax)
  end

  local uniq = {}
  for _, p in ipairs(pts) do
    local dup = false
    for _, q in ipairs(uniq) do
      if math.abs(p[1]-q[1])<1e-6 and math.abs(p[2]-q[2])<1e-6 then dup=true; break end
    end
    if not dup then uniq[#uniq+1] = p end
  end
  if #uniq < 2 then return nil end
  return uniq[1][1], uniq[1][2], uniq[2][1], uniq[2][2]
end

local function emit_axes(xmin, xmax, ymin, ymax)
  local t = {}
  local lbl = "font=\\footnotesize"
  t[#t+1] = string.format("\\draw[->] (%.4f,0) -- (%.4f,0) node[right]{$x$};", xmin-0.3, xmax+0.4)
  t[#t+1] = string.format("\\draw[->] (0,%.4f) -- (0,%.4f) node[above]{$y$};", ymin-0.3, ymax+0.4)
  for k = math.ceil(xmin), math.floor(xmax) do
    if k ~= 0 then
      t[#t+1] = string.format("\\draw (%d,-0.08) -- (%d,0.08) node[below=3pt,%s]{$%d$};", k, k, lbl, k)
    end
  end
  for k = math.ceil(ymin), math.floor(ymax) do
    if k ~= 0 then
      t[#t+1] = string.format("\\draw (-0.08,%d) -- (0.08,%d) node[left=3pt,%s]{$%d$};", k, k, lbl, k)
    end
  end
  t[#t+1] = "\\node[below left=1pt,font=\\footnotesize] at (0,0) {$O$};"
  return table.concat(t, "\n")
end

local function vector_label_pos(x1,y1,x2,y2,t)
  t = t or 0.5
  local dx,dy = x2-x1, y2-y1
  local len = math.sqrt(dx*dx+dy*dy)
  local mx,my = x1+t*dx, y1+t*dy
  if len < 1e-9 then return mx, my end
  local px,py = -dy/len, dx/len
  local off = 0.28
  return mx + px*off, my + py*off
end

local function vector_style_opts(s)
  if not s or s == "" then return "" end
  local parts = {}
  for w in s:gmatch("[^%-]+") do parts[#parts+1] = w end
  if #parts == 0 then return "" end
  return ","..table.concat(parts, ",")
end

local function angle_radius(ctx, bx, by, base)
  ctx.amarks = ctx.amarks or {}
  local key = string.format("%.3f:%.3f", bx, by)
  local n = (ctx.amarks[key] or 0)
  ctx.amarks[key] = n + 1
  return base + 0.22 * n
end

local function emit_primitive(tag, rest, dict, xmin, xmax, ymin, ymax, ctx)
  local out = {}
  if tag == "perpbisector" or tag == "anglebisector" or tag == "anglemark" then
    local names, tail = {}, rest
    while true do
      local nm, t = tail:match("^(%u[%w_]*)%s*(.*)$")
      if not nm then break end
      names[#names+1] = nm; tail = t
    end
    local need = (tag == "perpbisector") and 2 or 3
    if #names < need then
      error("texecole: <draw axes> " .. tag .. " attend " .. need
          .. " points nommés, reçu " .. #names)
    end
    local pts = {}
    for i = 1, need do
      local p = dict[names[i]]
      if not p then
        error("texecole: <draw axes> " .. tag .. " — le point '" .. names[i]
            .. "' n'a pas été placé (placez-le d'abord : point "
            .. names[i] .. " (x,y))")
      end
      pts[i] = p
    end
    local at = U.parse_attrs(tail, { tag = tag,
      hint = "attend color:, thickness:, marks:" })
    local pen = {}
    if at.color then pen[#pen+1] = "color=" .. at.color end
    pen[#pen+1] = at.thickness and ("line width=" .. at.thickness .. "pt")
                                or "thick"
    local popt = table.concat(pen, ", ")

    if tag == "perpbisector" then
      local A, B = pts[1], pts[2]
      local dx, dy = B[1]-A[1], B[2]-A[2]
      local mx, my = (A[1]+B[1])/2, (A[2]+B[2])/2

      local x1,y1,x2,y2 = clip_line(dx, dy, dx*mx + dy*my,
                                    xmin,xmax,ymin,ymax)
      if not x1 then return "" end
      ctx.segs[#ctx.segs+1] = {x1,y1,x2,y2}
      out[#out+1] = string.format("\\draw[%s] (%.4f,%.4f) -- (%.4f,%.4f);",
        popt, x1,y1,x2,y2)
      if at.marks == "on" then
        local l = math.sqrt(dx*dx + dy*dy); if l < 1e-9 then l = 1 end
        local ux, uy = dx/l, dy/l
        local nx, ny = -uy, ux

        for _, t in ipairs({0.25, 0.75}) do
          local cx, cy = A[1]+dx*t, A[2]+dy*t
          out[#out+1] = string.format(
            "\\draw (%.4f,%.4f) -- (%.4f,%.4f);",
            cx - nx*0.12, cy - ny*0.12, cx + nx*0.12, cy + ny*0.12)
        end

        local s = 0.22
        out[#out+1] = string.format(
          "\\draw (%.4f,%.4f) -- (%.4f,%.4f) -- (%.4f,%.4f);",
          mx + ux*s, my + uy*s,
          mx + ux*s + nx*s, my + uy*s + ny*s,
          mx + nx*s, my + ny*s)
      end
      return table.concat(out, "\n")
    end

    local A, B, C = pts[1], pts[2], pts[3]
    local ax, ay = A[1]-B[1], A[2]-B[2]
    local cx, cy = C[1]-B[1], C[2]-B[2]
    local la = math.sqrt(ax*ax+ay*ay); local lc = math.sqrt(cx*cx+cy*cy)
    if la < 1e-9 or lc < 1e-9 then
      error("texecole: <draw axes> " .. tag .. " — angle dégénéré (points confondus)")
    end
    local uax, uay, ucx, ucy = ax/la, ay/la, cx/lc, cy/lc
    local aA = math.deg(math.atan(uay, uax))
    local aC = math.deg(math.atan(ucy, ucx))
    local delta = (aC - aA) % 360; if delta > 180 then delta = delta - 360 end

    if tag == "anglemark" then
      local r = angle_radius(ctx, B[1], B[2], 0.45)
      local popt2 = popt .. (at.oriented == "on" and ", ->" or "")
      out[#out+1] = string.format(
        "\\draw[%s] ([shift=(%.2f:%.2f)]%.4f,%.4f) arc[start angle=%.2f, end angle=%.2f, radius=%.2f];",
        popt2, aA, r, B[1], B[2], aA, aA + delta, r)
      if at.label then

        local mid = aA + delta / 2
        local lbl = at.label:gsub("^{", ""):gsub("}$", "")
        out[#out+1] = string.format(
          "\\node at ([shift=(%.2f:%.2f)]%.4f,%.4f) {\\footnotesize %s};",
          mid, r + 0.42, B[1], B[2], lbl)
      end
      return table.concat(out, "\n")
    end

    local wx, wy = uax + ucx, uay + ucy
    local lw = math.sqrt(wx*wx + wy*wy)
    if lw < 1e-9 then wx, wy, lw = -uay, uax, 1 end
    wx, wy = wx/lw, wy/lw

    local tmax = math.huge
    if wx > 1e-9  then tmax = math.min(tmax, (xmax - B[1]) / wx) end
    if wx < -1e-9 then tmax = math.min(tmax, (xmin - B[1]) / wx) end
    if wy > 1e-9  then tmax = math.min(tmax, (ymax - B[2]) / wy) end
    if wy < -1e-9 then tmax = math.min(tmax, (ymin - B[2]) / wy) end
    if tmax == math.huge or tmax < 0 then tmax = math.max(la, lc) * 1.1 end
    local ex, ey = B[1] + wx*tmax, B[2] + wy*tmax
    ctx.segs[#ctx.segs+1] = {B[1],B[2],ex,ey}
    out[#out+1] = string.format("\\draw[%s] (%.4f,%.4f) -- (%.4f,%.4f);",
      popt, B[1],B[2], ex,ey)
    if at.marks == "on" then

      local aW = math.deg(math.atan(wy, wx))
      for _, pair in ipairs({{aA, aW}, {aW, aC}}) do
        local d = (pair[2] - pair[1]) % 360; if d > 180 then d = d - 360 end
        out[#out+1] = string.format(
          "\\draw ([shift=(%.2f:%.2f)]%.4f,%.4f) arc[start angle=%.2f, end angle=%.2f, radius=%.2f];",
          pair[1], 0.5, B[1], B[2], pair[1], pair[1] + d, 0.5)
      end
    end
    return table.concat(out, "\n")
  end

  return table.concat(out, "\n")
end

local function emit_analytic(line, frame, dict, circles, vectors, ctx)
  local xmin,xmax,ymin,ymax = frame[1],frame[2],frame[3],frame[4]
  local tag, rest = line:match("^%s*(%S+)%s*(.*)$")
  rest = U.trim(rest or "")
  local out = {}

  if tag == "point" then

    local nm, pr = rest:match("^([%a_][%w_]*)%s*(%(.*%))%s*$")
    if not nm then pr = rest end
    local x, y = coord_pair(pr, "point")
    if nm then dict[nm] = {x, y} end
    out[#out+1] = string.format("\\fill (%.4f,%.4f) circle [radius=0.05];", x, y)
    if nm then

      ctx.plabels[#ctx.plabels+1] = {x = x, y = y, name = nm}
    end
    return table.concat(out, "\n")
  end

  if tag == "vector" then

    local function resolve_point(tok, what)
      tok = U.trim(tok or "")
      local vn = tok:match("^~([%a_][%w_]*)$")
      if vn then
        local vv = vectors[vn]
        if not vv then
          error("texecole: <draw axes> vector "..what.." — '~"..vn.."' needs vector "..vn.." drawn first")
        end
        return vv.x2, vv.y2
      end
      if tok:match("^%(.*%)$") then
        return coord_pair(tok, "vector "..what)
      end
      local p = dict[tok]
      if not p then
        error("texecole: <draw axes> vector "..what.." — point '"..tok.."' is not placed")
      end
      return p[1], p[2]
    end

    local function draw_vector(name, x1,y1,x2,y2, styleopts, rawlabel, labelt)
      local sopts = vector_style_opts(styleopts)
      ctx.segs[#ctx.segs+1] = {x1,y1,x2,y2}
      out[#out+1] = string.format("\\draw[->,>=stealth,thick%s] (%.4f,%.4f) -- (%.4f,%.4f);",
        sopts, x1,y1,x2,y2)
      local lbl = rawlabel or (name and ("\\vec{"..name.."}"))
      if lbl then
        local lx,ly = vector_label_pos(x1,y1,x2,y2,labelt)

        local deg = math.deg(math.atan(y2-y1, x2-x1))
        if deg > 90 then deg = deg - 180 elseif deg < -90 then deg = deg + 180 end
        out[#out+1] = string.format("\\node[font=\\footnotesize,rotate=%.2f%s] at (%.4f,%.4f) {$%s$};",
          deg, sopts, lx,ly,lbl)
      end
    end

    local nm, pr = rest:match("^([%a_][%w_]*)%s*(%(.*%))%s*$")
    if nm then
      local x2,y2 = coord_pair(pr, "vector")
      vectors[nm] = {dx=x2, dy=y2, x1=0, y1=0, x2=x2, y2=y2}
      draw_vector(nm, 0,0,x2,y2)
      return table.concat(out, "\n")
    end

    local name, A, B = rest:match("^([%a_][%w_]*)%s+(%u)(%u)$")
    if not name then A, B = rest:match("^(%u)(%u)$") end
    if A and B then
      local pA, pB = dict[A], dict[B]
      if not pA or not pB then
        error("texecole: <draw axes> vector "..A..B.." needs both points placed first")
      end
      local x1,y1,x2,y2 = pA[1],pA[2],pB[1],pB[2]
      if name then vectors[name] = {dx=x2-x1, dy=y2-y1, x1=x1,y1=y1,x2=x2,y2=y2} end
      draw_vector(name, x1,y1,x2,y2)
      return table.concat(out, "\n")
    end

    local cname, a1, op, a2, tail =
      rest:match("^([%a_][%w_]*)%s*=%s*([%a_][%w_]*)%s*([%+%-])%s*([%a_][%w_]*)%s*(.-)$")
    if cname then
      local va, vb = vectors[a1], vectors[a2]
      if not va then
        error("texecole: <draw axes> vector "..cname.." = "..a1..op..a2.." needs vector "..a1.." drawn first")
      end
      if not vb then
        error("texecole: <draw axes> vector "..cname.." = "..a1..op..a2.." needs vector "..a2.." drawn first")
      end
      local dx,dy
      if op == "+" then dx,dy = va.dx+vb.dx, va.dy+vb.dy
      else dx,dy = va.dx-vb.dx, va.dy-vb.dy end
      local attrs = U.parse_attrs(tail, {tag="vector "..cname, on_bare=function() return false end})
      local x1,y1 = 0,0
      if attrs.from then x1,y1 = resolve_point(attrs.from, cname) end
      local x2,y2 = x1+dx, y1+dy
      vectors[cname] = {dx=dx, dy=dy, x1=x1,y1=y1,x2=x2,y2=y2}
      local expr = "\\vec{"..a1.."}"..(op=="+" and "+" or "-").."\\vec{"..a2.."}"

      draw_vector(nil, x1,y1,x2,y2, attrs.style, expr, 0.72)
      return table.concat(out, "\n")
    end

    local rname, tail2 = rest:match("^([%a_][%w_]*)%s+(%S.*)$")
    if rname then
      local attrs = U.parse_attrs(tail2, {tag="vector "..rname, on_bare=function() return false end})
      local vv = vectors[rname]
      if not vv then
        error("texecole: <draw axes> vector "..rname.." from:... needs vector "..rname.." drawn first")
      end
      local x1,y1 = vv.x1, vv.y1
      if attrs.from then x1,y1 = resolve_point(attrs.from, rname) end
      local x2,y2 = x1+vv.dx, y1+vv.dy
      draw_vector(rname, x1,y1,x2,y2, attrs.style)
      return table.concat(out, "\n")
    end

    error("texecole: <draw axes> vector — give  vector u (x,y),  vector u AB,  vector AB, "
        .."vector s = u+v [from:P] [style:S],  or  vector v from:P [style:S]")
  end

  if tag == "vecangle" then

    local n1, n2, tail = rest:match("^([%a_][%w_]*)%s+([%a_][%w_]*)%s*(.*)$")
    if not n1 then
      error("texecole: <draw axes> vecangle attend deux noms de vecteurs")
    end
    local v1, v2 = vectors[n1], vectors[n2]
    if not v1 then
      error("texecole: <draw axes> vecangle — le vecteur '" .. n1
          .. "' n'a pas été tracé dans ce bloc")
    end
    if not v2 then
      error("texecole: <draw axes> vecangle — le vecteur '" .. n2
          .. "' n'a pas été tracé dans ce bloc")
    end
    local at = U.parse_attrs(tail, { tag = "vecangle",
      hint = "attend color:, thickness:, label:, oriented:" })
    local pen = {}
    if at.color then pen[#pen+1] = "color=" .. at.color end
    pen[#pen+1] = at.thickness and ("line width=" .. at.thickness .. "pt")
                                or "thick"
    local popt = table.concat(pen, ", ")
             .. (at.oriented == "on" and ", ->" or "")
    local bx, by = v1.x1, v1.y1
    local a1 = math.deg(math.atan(v1.dy, v1.dx))
    local a2 = math.deg(math.atan(v2.dy, v2.dx))
    local delta = (a2 - a1) % 360; if delta > 180 then delta = delta - 360 end
    local r = angle_radius(ctx, bx, by, 0.55)
    out[#out+1] = string.format(
      "\\draw[%s] ([shift=(%.2f:%.2f)]%.4f,%.4f) arc[start angle=%.2f, end angle=%.2f, radius=%.2f];",
      popt, a1, r, bx, by, a1, a1 + delta, r)
    if at.label then
      local mid = a1 + delta / 2
      local lbl = at.label:gsub("^{", ""):gsub("}$", "")
      out[#out+1] = string.format(
        "\\node at ([shift=(%.2f:%.2f)]%.4f,%.4f) {\\footnotesize %s};",
        mid, r + 0.42, bx, by, lbl)
    end
    return table.concat(out, "\n")
  end

  if tag == "perpbisector" or tag == "anglebisector" or tag == "anglemark" then
    return emit_primitive(tag, rest, dict, xmin, xmax, ymin, ymax, ctx)
  end
  if tag == "segment" then

    local A, B = rest:match("^(%u)%s+(%u)$")
    if not A then
      error("texecole: <draw axes> segment attend deux points déjà placés, "
        .. "par exemple segment A F")
    end
    local pA, pB = dict[A], dict[B]
    if not pA or not pB then
      error("texecole: <draw axes> segment " .. A .. B
        .. " — les deux points doivent être placés")
    end
    out[#out+1] = string.format("\\draw[thick] (%.4f,%.4f) -- (%.4f,%.4f);",
      pA[1], pA[2], pB[1], pB[2])
    return table.concat(out, "\n")
  end

  if tag == "ray" then

    local A, B = rest:match("^(%u)%s+(%u)$")
    if not A then
      error("texecole: <draw axes> demi-droite attend deux points déjà "
        .. "placés, par exemple ray A B")
    end
    local pA, pB = dict[A], dict[B]
    if not pA or not pB then
      error("texecole: <draw axes> demi-droite " .. A .. B
        .. " — les deux points doivent être placés")
    end

    local a = pB[2] - pA[2]
    local b = -(pB[1] - pA[1])
    local c = a*pA[1] + b*pA[2]
    local x1, y1, x2, y2 = clip_line(a, b, c, xmin, xmax, ymin, ymax)
    if not x1 then return "" end
    local dirx, diry = pB[1]-pA[1], pB[2]-pA[2]
    if (x1-pA[1])*dirx + (y1-pA[2])*diry < (x2-pA[1])*dirx + (y2-pA[2])*diry then
      x1, y1, x2, y2 = x2, y2, x1, y1
    end
    ctx.segs[#ctx.segs+1] = {pA[1], pA[2], x1, y1}
    out[#out+1] = string.format("\\draw[thick] (%.4f,%.4f) -- (%.4f,%.4f);",
      pA[1], pA[2], x1, y1)
    return table.concat(out, "\n")
  end

  if tag == "line" then

    local A, B = rest:match("^through%s+(%u)%s+(%u)$")
    if A then
      local pA, pB = dict[A], dict[B]
      if not pA or not pB then
        error("texecole: <draw axes> line through "..A.." "..B.." needs both points placed")
      end
      local a = pB[2]-pA[2]
      local b = -(pB[1]-pA[1])
      local c = a*pA[1] + b*pA[2]
      local x1,y1,x2,y2 = clip_line(a,b,c, xmin,xmax,ymin,ymax)
      if not x1 then return "" end
      ctx.segs[#ctx.segs+1] = {x1,y1,x2,y2}
      out[#out+1] = string.format("\\draw[thick] (%.4f,%.4f) -- (%.4f,%.4f);", x1,y1,x2,y2)
      return table.concat(out, "\n")
    end
    local eq, reason = line_equation(rest)
    if not eq then error("texecole: <draw axes> line — "..reason) end
    local x1,y1,x2,y2 = clip_line(eq[1],eq[2],eq[3], xmin,xmax,ymin,ymax)
    if not x1 then return "" end
    ctx.segs[#ctx.segs+1] = {x1,y1,x2,y2}
    out[#out+1] = string.format("\\draw[thick] (%.4f,%.4f) -- (%.4f,%.4f);", x1,y1,x2,y2)
    return table.concat(out, "\n")
  end

  if tag == "circle" then

    local nm = rest:match("^([%a_][%w_]*)%s+center:")
    local body = rest
    if nm then body = rest:gsub("^[%a_][%w_]*%s+", "", 1) end
    if not nm then

      local cand, tail = rest:match("^([%a_][%w_]*)%s+(.-=.*)$")
      if cand and tail:find("%^2") then nm, body = cand, tail end
    end
    local attrs = U.parse_attrs(body, {tag="circle (axes)",
      on_bare=function() return true end})
    if attrs.center and attrs.radius then
      local cx, cy
      local cdef = attrs.center
      if cdef:sub(1,1) == "(" then cx, cy = coord_pair(cdef, "center")
      else
        local p = dict[cdef]
        if not p then error("texecole: <draw axes> circle center:"..cdef.." — point not placed") end
        cx, cy = p[1], p[2]
      end
      local r = tonumber(attrs.radius)
      if not r then error("texecole: <draw axes> circle radius must be a number") end
      if nm then circles[nm] = {cx,cy,r} end
      out[#out+1] = string.format("\\draw[thick] (%.4f,%.4f) circle [radius=%.4f];", cx, cy, r)
      return table.concat(out, "\n")
    end

    local cx, cy, r = circle_general(body)
    if not cx then
      error("texecole: <draw axes> circle — give center:A radius:r, or an equation x^2+y^2+... = ...")
    end
    if nm then circles[nm] = {cx,cy,r} end
    out[#out+1] = string.format("\\draw[thick] (%.4f,%.4f) circle [radius=%.4f];", cx, cy, r)
    return table.concat(out, "\n")
  end

  if tag == "tangent" then

    local attrs = U.parse_attrs(rest, {tag="tangent",
      on_bare=function() return true end})
    if not attrs.to or not attrs.at then
      error("texecole: <draw axes> tangent needs  to:circleName at:pointName")
    end
    local c = circles[attrs.to]
    if not c then error("texecole: <draw axes> tangent to:"..attrs.to.." — no such circle") end
    local p = dict[attrs.at]
    if not p then error("texecole: <draw axes> tangent at:"..attrs.at.." — point not placed") end

    local rx, ry = p[1]-c[1], p[2]-c[2]

    local a, b = rx, ry
    local cc = rx*p[1] + ry*p[2]
    local x1,y1,x2,y2 = clip_line(a,b,cc, xmin,xmax,ymin,ymax)
    if not x1 then return "" end
    ctx.segs[#ctx.segs+1] = {x1,y1,x2,y2}
    out[#out+1] = string.format("\\draw[Blue,thick] (%.4f,%.4f) -- (%.4f,%.4f);", x1,y1,x2,y2)
    return table.concat(out, "\n")
  end

  if tag == "region" then

    local lhs, op, rhs = rest:match("^(.-)([<>]=?)(.*)$")
    if not lhs then
      error("texecole: <draw axes> region needs an inequality, e.g. region y < 2x-1")
    end
    lhs, rhs = U.trim(lhs), U.trim(rhs)

    local eq, reason = line_equation(lhs.."="..rhs)
    if not eq then error("texecole: <draw axes> region — "..reason) end
    local x1,y1,x2,y2 = clip_line(eq[1],eq[2],eq[3], xmin,xmax,ymin,ymax)
    if not x1 then return "" end

    local la, lb, lc = linear_terms(lhs)
    local ra, rb, rc = linear_terms(rhs)
    local ga, gb, gc = la-ra, lb-rb, lc-rc
    local function sat(x,y)
      local v = ga*x + gb*y + gc
      if op:sub(1,1) == "<" then return v < 0 else return v > 0 end
    end

    local corners = {{xmin,ymin},{xmax,ymin},{xmax,ymax},{xmin,ymax}}
    local poly = {{x1,y1}}
    for _, cc in ipairs(corners) do if sat(cc[1],cc[2]) then poly[#poly+1]=cc end end
    poly[#poly+1] = {x2,y2}

    local gx,gy = 0,0
    for _,p in ipairs(poly) do gx=gx+p[1]; gy=gy+p[2] end
    gx,gy = gx/#poly, gy/#poly
    table.sort(poly, function(p,q)
      return math.atan(p[2]-gy,p[1]-gx) < math.atan(q[2]-gy,q[1]-gx)
    end)
    local pts = {}
    for _,p in ipairs(poly) do pts[#pts+1] = string.format("(%.4f,%.4f)", p[1],p[2]) end
    out[#out+1] = "\\fill[Blue, fill opacity=0.12] "..table.concat(pts," -- ").." -- cycle;"
    ctx.segs[#ctx.segs+1] = {x1,y1,x2,y2}
    out[#out+1] = string.format("\\draw[Blue,thick,dashed] (%.4f,%.4f) -- (%.4f,%.4f);", x1,y1,x2,y2)
    return table.concat(out, "\n")
  end

  if tag == "function" or tag == "curve" then
    local body, label, brut, bvar
    if tag == "function" then
      local fname = rest:match("^([%a_][%w_]*)%s*$")
      if not fname then
        error("texecole: <draw axes> function attend un seul nom de "
            .. "fonction, ex. « function p »")
      end
      local obj = SL and SL._objects and SL._objects[fname]
      if not (obj and obj.expr) then
        error("texecole: <draw axes> la fonction '" .. fname .. "' n'a pas "
            .. "été posée ; écrivez d'abord <Soit>une fonction "
            .. fname .. "(x) = ...")
      end
      local var = "x"
      local _, v = (obj.name or ""):match(
        "^%s*([%a][%w_]*)%s*%(%s*([%a][%w_]*)%s*%)%s*$")
      if v then var = v end
      body = SL.translate_plot_expr(U.trim(obj.expr), var)
      brut = U.trim(obj.expr)
      bvar = var
      label = fname
    else
      body = SL.translate_plot_expr(U.trim(rest), "x")
      brut = U.trim(rest)
      bvar = "x"
    end

    ctx.curvecount = (ctx.curvecount or 0) + 1
    local palette = {"Blue", "Red", "Green!60!black", "Orange!90!black",
                     "Violet", "Teal"}
    local coul = palette[(ctx.curvecount - 1) % #palette + 1]

    if bvar ~= "x" then
      brut = brut:gsub("%f[%w_]" .. bvar .. "%f[^%w_]", "x")
    end
    local okf, f
    if SL.compile_plot_fn then
      okf, f = pcall(SL.compile_plot_fn, brut, "x")
    end

    if okf and type(f) == "function" and SL.analyse_courbe then
      local D = SL.analyse_courbe(f, xmin, xmax, ymin, ymax)
      local segs, vertic, droites = D.segs, D.vertic, D.droites
      local extremums, marques, tanv = D.extremums, D.marques, D.tanv
      local W, H = xmax - xmin, ymax - ymin

      -- Émission : asymptotes, tangentes, courbe, point et étiquette
      for _, v in ipairs(vertic) do
        out[#out + 1] = string.format(
          "\\draw[gray, dashed] (%.4f,%.4f) -- (%.4f,%.4f);",
          v, ymin, v, ymax)
      end
      for _, d in ipairs(droites) do
        local a, b = d[1], d[2]
        if math.abs(a) < 1e-6 then
          if b > ymin and b < ymax then
            out[#out + 1] = string.format(
              "\\draw[gray, dashed] (%.4f,%.4f) -- (%.4f,%.4f);",
              xmin, b, xmax, b)
          end
        else
          local x1, y1, x2, y2 =
            clip_line(a, -1, -b, xmin, xmax, ymin, ymax)
          if x1 then
            out[#out + 1] = string.format(
              "\\draw[gray, dashed] (%.4f,%.4f) -- (%.4f,%.4f);",
              x1, y1, x2, y2)
          end
        end
      end
      for _, e in ipairs(extremums) do
        local x0, y0 = e[1], e[2]
        local l = 0.1 * W
        out[#out + 1] = string.format(
          "\\draw[gray, dashed, <->, >=stealth] (%.4f,%.4f) -- (%.4f,%.4f);",
          math.max(xmin, x0 - l), y0, math.min(xmax, x0 + l), y0)
        out[#out + 1] = string.format(
          "\\fill[%s] (%.4f,%.4f) circle (1.4pt);", coul, x0, y0)
      end
      for _, e in ipairs(tanv) do
        local x0, y0 = e[1], e[2]
        local l = 0.1 * H
        out[#out + 1] = string.format(
          "\\draw[gray, dashed, <->, >=stealth] (%.4f,%.4f) -- (%.4f,%.4f);",
          x0, math.max(ymin, y0 - l), x0, math.min(ymax, y0 + l))
        out[#out + 1] = string.format(
          "\\fill[%s] (%.4f,%.4f) circle (1.4pt);", coul, x0, y0)
      end
      for si, seg in ipairs(segs) do
        local pts = {}
        for _, p in ipairs(seg) do
          pts[#pts + 1] = string.format("(%.4f,%.4f)", p[1], p[2])
        end
        local fin = ";"
        if label and si == #segs then
          fin = string.format(
            " node[right, font=\\footnotesize] {$%s$};", label)
        end
        out[#out + 1] = "\\draw[" .. coul .. ", thick] plot coordinates {"
          .. table.concat(pts, " ") .. "}" .. fin
      end
      for _, m in ipairs(marques) do
        if m[3] == "plein" then
          out[#out + 1] = string.format(
            "\\fill[%s] (%.4f,%.4f) circle (1.6pt);", coul, m[1], m[2])
        else
          out[#out + 1] = string.format(
            "\\draw[%s, fill=white] (%.4f,%.4f) circle (1.6pt);",
            coul, m[1], m[2])
        end
      end
      return table.concat(out, "\n")
    end

    body = body:gsub("%f[%a]x%f[%A]", "(\\x)")

    local xcoupe = xmax - 0.06 * (xmax - xmin)
    out[#out+1] = string.format(
      "\\draw[%s, thick, domain=%.4f:%.4f, samples=150, smooth] plot ({\\x},{%s})",
      coul, xmin, xcoupe, body)
    if label then
      out[#out] = out[#out]
        .. string.format(" node[right, font=\\footnotesize] {$%s$};", label)
    else
      out[#out] = out[#out] .. ";"
    end
    out[#out+1] = string.format(
      "\\draw[%s, thick, domain=%.4f:%.4f, samples=20, smooth] plot ({\\x},{%s});",
      coul, xcoupe, xmax, body)
    return table.concat(out, "\n")
  end

  error("texecole: <draw axes> unknown directive '"..tag.."' "
      .. "(use point, vector, line, segment, ray, circle, tangent, region, "
      .. "function, curve)")
end

function circle_general(eq)
  local lhs, rhs = eq:match("^(.-)=(.*)$")
  if not lhs then return nil end
  local F = tonumber(U.trim(rhs)) or 0

  local A2x, A2y, D, E, c0 = 0, 0, 0, 0, -F
  local function coeff(term, tail)
    local co = term:sub(1, #term - #tail)
    if co == "" or co == "+" then return 1 end
    if co == "-" then return -1 end
    return tonumber(co)
  end
  local e = lhs:gsub("%s+", ""):gsub("%-", "+-")
  if e:sub(1,1)=="+" then e=e:sub(2) end
  for term in (e.."+"):gmatch("(.-)%+") do
    if term ~= "" then
      local co
      if term:match("x%^2$") then
        co = coeff(term, "x^2"); A2x = A2x + (co or 0)
      elseif term:match("y%^2$") then
        co = coeff(term, "y^2"); A2y = A2y + (co or 0)
      elseif term:match("x$") then
        co = coeff(term, "x"); D = D + (co or 0)
      elseif term:match("y$") then
        co = coeff(term, "y"); E = E + (co or 0)
      else
        co = tonumber(term); c0 = c0 + (co or 0)
      end
      if not co then
        error("texecole: <draw axes> circle equation — cannot read the term '"
            .. term .. "' (expected numbers, x, y, x^2, y^2)")
      end
    end
  end
  if A2x == 0 or A2y == 0 then return nil end
  if math.abs(A2x - A2y) > 1e-12 then
    error("texecole: <draw axes> circle equation — the coefficients of x^2 and "
        .. "y^2 differ (" .. A2x .. " vs " .. A2y .. "); that curve is not a circle")
  end
  D, E, c0 = D / A2x, E / A2x, c0 / A2x
  local cx, cy = -D/2, -E/2
  local r2 = cx*cx + cy*cy - c0
  if r2 <= 0 then return nil end
  return cx, cy, math.sqrt(r2)
end

local function seg_dist(px, py, sg)
  local x1,y1,x2,y2 = sg[1],sg[2],sg[3],sg[4]
  local dx, dy = x2-x1, y2-y1
  local L2 = dx*dx + dy*dy
  if L2 == 0 then local ex,ey = px-x1, py-y1; return math.sqrt(ex*ex+ey*ey) end
  local t = ((px-x1)*dx + (py-y1)*dy) / L2
  if t < 0 then t = 0 elseif t > 1 then t = 1 end
  local ex, ey = px - (x1 + t*dx), py - (y1 + t*dy)
  return math.sqrt(ex*ex + ey*ey)
end

local ANCHORS = {
  {  45, "above right=1pt" },
  { 135, "above left=1pt"  },
  { 315, "below right=1pt" },
  { 225, "below left=1pt"  },
}

local function place_point_labels(out, ctx, frame)
  for _, pl in ipairs(ctx.plabels) do
    local dirs = {}
    for _, sg in ipairs(ctx.segs) do
      if seg_dist(pl.x, pl.y, sg) < 0.12 then
        local a = math.deg(math.atan(sg[4]-sg[2], sg[3]-sg[1])) % 180
        dirs[#dirs+1] = a
        dirs[#dirs+1] = a + 180
      end
    end
    local best, bestscore = ANCHORS[1][2], -1
    if #dirs > 0 then
      for _, cand in ipairs(ANCHORS) do

        local rad = math.rad(cand[1])
        local lx, ly = pl.x + 0.45*math.cos(rad), pl.y + 0.45*math.sin(rad)
        if lx > frame[1] and lx < frame[2] and ly > frame[3] and ly < frame[4] then
          local score = 360
          for _, d in ipairs(dirs) do
            local diff = math.abs(cand[1] - d) % 360
            if diff > 180 then diff = 360 - diff end
            if diff < score then score = diff end
          end
          if score > bestscore then best, bestscore = cand[2], score end
        end
      end
    end
    out[#out+1] = string.format("\\node[%s] at (%.4f,%.4f) {$%s$};",
      best, pl.x, pl.y, pl.name)
  end
end

local function build_analytic(lines, frame, unitx, unity)
  local dict, circles, vectors = {}, {}, {}
  local ctx = { segs = {}, plabels = {} }
  local picopts = "line width=0.5pt"
  local ux = tonumber(unitx)
  local uy = tonumber(unity)
  if ux and ux > 0 and ux ~= 1 then
    picopts = string.format("x=%scm, ", tostring(ux)) .. picopts
  end
  if uy and uy > 0 and uy ~= 1 then
    picopts = string.format("y=%scm, ", tostring(uy)) .. picopts
  end
  local out = {"\\begin{center}\\begin{tikzpicture}[" .. picopts .. "]"}

  local bx0, by0 = frame[1]-0.8, frame[3]-0.8
  local bx1, by1 = frame[2]+1.0, frame[4]+1.0
  out[#out+1] = string.format(
    "\\useasboundingbox (%.4f,%.4f) rectangle (%.4f,%.4f);", bx0, by0, bx1, by1)
  out[#out+1] = emit_axes(frame[1], frame[2], frame[3], frame[4])
  out[#out+1] = string.format(
    "\\begin{scope}\\clip (%.4f,%.4f) rectangle (%.4f,%.4f);",
    frame[1]-0.05, frame[3]-0.05, frame[2]+0.05, frame[4]+0.05)
  for _, line in ipairs(lines) do
    if type(line) == "string" and line:match("%S") then
      out[#out+1] = emit_analytic(U.trim(line), frame, dict, circles, vectors, ctx)
    end
  end
  out[#out+1] = "\\end{scope}"
  place_point_labels(out, ctx, frame)
  out[#out+1] = "\\end{tikzpicture}\\end{center}"
  return table.concat(out, "\n")
end

local function apply_scale(tex, scale)
  if not scale or scale == 1 then return tex end
  return (tex:gsub("\\begin{tikzpicture}%[",
    "\\begin{tikzpicture}[scale=" .. scale .. ", ", 1))
end

local function build_block(lines, header, scale)

  if header and header ~= "" then
    local hattrs = U.parse_attrs(header, {tag="draw header",
      on_bare=function(w,a) a[w]=true; return true end})
    if hattrs.axes then
      local frame
      if hattrs.axes == true then
        error("texecole: <draw axes:{xmin,xmax,ymin,ymax}> needs a window, "
            .. "e.g. axes:{-5,5,-5,5}")
      else
        local v = {}
        for n in hattrs.axes:gmatch("[^,]+") do v[#v+1] = tonumber(U.trim(n)) end
        if #v ~= 4 then
          error("texecole: <draw axes:{...}> needs four numbers xmin,xmax,ymin,ymax")
        end
        frame = v
      end
      return apply_scale(
        build_analytic(lines, frame, hattrs.unitx, hattrs.unity), scale)
    end
  end
  return apply_scale(build_block_synthetic(lines), scale)
end

local function pi_frac(tok)
  tok = U.trim(tok)
  if tok == "0" then return 0, 1 end
  local sgn, numstr, den = tok:match("^([+-]?)(%d*)%s*pi%s*/%s*(%d+)$")
  if not sgn then
    sgn, numstr = tok:match("^([+-]?)(%d*)%s*pi$")
    den = "1"
  end
  if not sgn then return nil end
  local p = tonumber(numstr ~= "" and numstr or "1") * (sgn == "-" and -1 or 1)
  return p, tonumber(den)
end

local function gcd2(a, b)
  a, b = math.abs(a), math.abs(b)
  while b ~= 0 do a, b = b, a % b end
  return a
end

local function trig_label(p, den)
  if p == 0 then return "0" end
  local sgn = p < 0 and "-" or ""
  p = math.abs(p)
  if den == 1 then return sgn .. (p == 1 and "\\pi" or (p .. "\\pi")) end
  if p == 1 then return sgn .. "\\frac{\\pi}{" .. den .. "}" end
  return sgn .. "\\frac{" .. p .. "\\pi}{" .. den .. "}"
end

local TRIG_EXACT = {
  ["1/6"] = { "\\frac{\\sqrt{3}}{2}", "\\frac{1}{2}" },
  ["1/4"] = { "\\frac{\\sqrt{2}}{2}", "\\frac{\\sqrt{2}}{2}" },
  ["1/3"] = { "\\frac{1}{2}",           "\\frac{\\sqrt{3}}{2}" },
}

local function trigcircle_tex(rest)
  local attrs = U.parse_attrs(U.trim(rest or ""), { tag = "trigcircle" })
  local r = tonumber(attrs.radius or "") or 4
  if r <= 0 then error("texecole: <draw> trigcircle radius:{...} must be positive") end
  local values = (attrs.values == "on")

  local ra, rb = -1, 1
  local rap, raq, rbp, rbq
  local fullcircle = true
  if attrs.range then
    local a, b = attrs.range:match("^%s*(.-)%s*,%s*(.-)%s*$")
    if not a then
      error("texecole: <draw> trigcircle range:{a, b} takes two bounds, "
          .. "fractions of pi (e.g. range:{0, pi/2})")
    end
    rap, raq = pi_frac(a)
    rbp, rbq = pi_frac(b)
    if not rap or not rbp then
      error("texecole: <draw> trigcircle range bounds must be fractions of "
          .. "pi (0, pi/2, -pi, 2pi/3, ...), got '" .. attrs.range .. "'")
    end
    ra, rb = rap / raq, rbp / rbq
    if ra >= rb then
      error("texecole: <draw> trigcircle range:{a, b} needs a < b")
    end
    if rb - ra > 2 then
      error("texecole: <draw> trigcircle range wider than a full turn")
    end
    fullcircle = false
  end

  local angles = {}
  local function push(p, q)
    local g = gcd2(p, q); if g > 1 then p, q = p // g, q // g end
    angles[#angles+1] = { p, q }
  end
  if attrs.step then
    local sp, sq = pi_frac(attrs.step)
    if not sp or sp <= 0 then
      error("texecole: <draw> trigcircle step:{...} takes a positive "
          .. "fraction of pi (pi/6, pi/12, ...), got '" .. attrs.step .. "'")
    end

    local lo = math.ceil((fullcircle and (-1 + 1e-12) or ra) * sq / sp - 1e-9)
    local hi = math.floor((fullcircle and 1 or rb) * sq / sp + 1e-9)
    if fullcircle and lo * sp / sq <= -1 + 1e-12 then lo = lo + 1 end
    for m = lo, hi do push(m * sp, sq) end
  else
    local base = {
      {0,1}, {1,6}, {1,4}, {1,3}, {1,2}, {2,3}, {3,4}, {5,6}, {1,1},
      {-1,6}, {-1,4}, {-1,3}, {-1,2}, {-2,3}, {-3,4}, {-5,6},
    }
    for _, a in ipairs(base) do
      local v = a[1] / a[2]
      if fullcircle or (v >= ra - 1e-9 and v <= rb + 1e-9) then
        push(a[1], a[2])
      end
    end
  end
  if #angles > 24 then
    error("texecole: <draw> trigcircle would draw " .. #angles .. " angles; "
        .. "the labels would collide -- take a larger step: or a narrower range:")
  end
  if #angles == 0 then
    error("texecole: <draw> trigcircle has no angle in the given range")
  end

  local out = {}
  local a = r + 0.9
  out[#out+1] = ("\\draw[->,>=stealth] (%.4f,0) -- (%.4f,0);"):format(-a, a)
  out[#out+1] = ("\\draw[->,>=stealth] (0,%.4f) -- (0,%.4f);"):format(-a, a)
  if fullcircle then
    out[#out+1] = ("\\draw[line width=0.7pt] (0,0) circle [radius=%.4f];"):format(r)
  else
    out[#out+1] = ("\\draw[line width=0.7pt] (%.4f,%.4f) arc (%.4f:%.4f:%.4f);")
      :format(r * math.cos(ra * math.pi), r * math.sin(ra * math.pi),
              math.deg(ra * math.pi), math.deg(rb * math.pi), r)
  end

  for _, ang in ipairs(angles) do
    local th = ang[1] / ang[2] * math.pi
    local x, y = r * math.cos(th), r * math.sin(th)
    out[#out+1] = ("\\draw[Gray!60, very thin] (0,0) -- (%.4f,%.4f);"):format(x, y)
    out[#out+1] = ("\\fill (%.4f,%.4f) circle [radius=0.055];"):format(x, y)
    local lx, ly = (r + 0.55) * math.cos(th), (r + 0.55) * math.sin(th)

    if math.abs(math.cos(th)) < 1e-9 then lx = lx + 0.45
    elseif math.abs(math.sin(th)) < 1e-9 then ly = ly + 0.32 end
    out[#out+1] = ("\\node[font=\\footnotesize] at (%.4f,%.4f) {$%s$};")
      :format(lx, ly, trig_label(ang[1], ang[2]))
  end

  if values then

    for _, ang in ipairs(angles) do
      local v = ang[1] / ang[2]
      if v > 1e-9 and v < 0.5 - 1e-9 then
        local th = v * math.pi
        local x, y = r * math.cos(th), r * math.sin(th)
        local ex = TRIG_EXACT[ang[1] .. "/" .. ang[2]]
        local cx = ex and ex[1] or NE.display(math.cos(th), ".", 2)
        local sy = ex and ex[2] or NE.display(math.sin(th), ".", 2)
        out[#out+1] = ("\\draw[Blue, dashed, thin] (%.4f,%.4f) -- (%.4f,0);"):format(x, y, x)
        out[#out+1] = ("\\draw[Blue, dashed, thin] (%.4f,%.4f) -- (0,%.4f);"):format(x, y, y)
        out[#out+1] = ("\\node[below, Blue, font=\\scriptsize, fill=white, inner sep=1pt] at (%.4f,-0.05) {$%s$};")
          :format(x, cx)
        out[#out+1] = ("\\node[left, Blue, font=\\scriptsize, fill=white, inner sep=1pt] at (-0.05,%.4f) {$%s$};")
          :format(y, sy)
      end
    end
  end
  return table.concat(out, "\n")
end

local function emit_figure(f,opts,measured,ticked)
  local body = emit_figure_inner(f,opts,measured,ticked)
  local o = opts or {}
  if (o.color or o.thickness) and body and body ~= "" then
    local so = {}
    if o.color     then so[#so+1] = "color=" .. o.color end
    if o.thickness then so[#so+1] = "line width=" .. o.thickness .. "pt" end
    return "\\begin{scope}[" .. table.concat(so, ", ") .. "]\n"
        .. body .. "\n\\end{scope}"
  end
  return body
end

local function build_block_synthetic_impl(lines)
  local figs,dict={},{}
  local gopt={}
  local solidstate={cursor=0}
  for _,line in ipairs(lines) do
    if type(line)=="table" and line.kind then

      if line.measures then gopt.measures=line.measures end
      if line.kind=="point" then
        if line.name then dict[line.name]={line.x,line.y} end
        figs[#figs+1]={point=line}
      elseif line.kind=="line" then
        figs[#figs+1]={segment=line}
      end
    elseif type(line)=="string" and line:match("^%s*solid%s") then
      local SOLID = require("texecole-solid")
      figs[#figs+1]={raw=SOLID.render(line:match("^%s*solid%s+(.*)$"), solidstate)}
    elseif type(line)=="string" and line:match("^%s*trigcircle%f[%A]") then
      figs[#figs+1]={raw=trigcircle_tex(line:match("^%s*trigcircle%s*(.*)$"))}
    elseif type(line)=="string" and (line:match("^%s*perpbisector%f[%A]")
        or line:match("^%s*anglebisector%f[%A]")
        or line:match("^%s*anglemark%f[%A]")) then
      local tag,rest=line:match("^%s*(%S+)%s*(.*)$")
      figs[#figs+1]={prim={tag=tag, rest=U.trim(rest or "")}}
    else
      local verts,marks,attrs,circle,construct=compute(line,dict)
      if construct then
        if not dict[construct.a] then dict[construct.a]={construct.x1,construct.y1} end
        if not dict[construct.b] then dict[construct.b]={construct.x2,construct.y2} end
        figs[#figs+1]={construct=construct}
      elseif circle then

        if circle.name and not dict[circle.name] then
          dict[circle.name]={circle.cx,circle.cy}
        end
        figs[#figs+1]={circle=circle}
      else
        verts=graft(verts,dict)
        for _,v in ipairs(verts) do if not dict[v[1]] then dict[v[1]]={v[2],v[3]} end end
        figs[#figs+1]={verts=verts,marks=marks}
      end
      if attrs and attrs.marks then gopt.marks=attrs.marks end
      if attrs and attrs.measures then gopt.measures=attrs.measures end
      if attrs and attrs.labels then gopt.labels=attrs.labels end
    end
  end

  gopt.marks    = gopt.marks    or "off"
  gopt.measures = gopt.measures or "off"

  local bminx,bminy,bmaxx,bmaxy
  for _,p in pairs(dict) do
    bminx = bminx and math.min(bminx,p[1]) or p[1]
    bmaxx = bmaxx and math.max(bmaxx,p[1]) or p[1]
    bminy = bminy and math.min(bminy,p[2]) or p[2]
    bmaxy = bmaxy and math.max(bmaxy,p[2]) or p[2]
  end
  local fxmin,fxmax = (bminx or -5)-1.2, (bmaxx or 5)+1.2
  local fymin,fymax = (bminy or -5)-1.2, (bmaxy or 5)+1.2
  local pctx = { segs = {} }
  if gopt.marks~="on" and gopt.marks~="off" then
    error("texecole: <draw> marks: takes 'on' or 'off' (got '"..tostring(gopt.marks).."')")
  end
  if gopt.measures~="off" and gopt.measures~="cm" and gopt.measures~="mm" then
    error("texecole: <draw> measures: takes 'off', 'cm' or 'mm' (got '"..tostring(gopt.measures).."')")
  end
  local out={"\\begin{center}\\begin{tikzpicture}[line width=0.5pt]"}
  local measured={}
  local ticked={}
  for _,f in ipairs(figs) do
    if f.raw then out[#out+1]=f.raw
    elseif f.prim then
      out[#out+1]=emit_primitive(f.prim.tag, f.prim.rest, dict,
        fxmin, fxmax, fymin, fymax, pctx)
    else out[#out+1]=emit_figure(f,gopt,measured,ticked) end
  end
  if gopt.labels~="off" then out[#out+1]=emit_labels(figs) end
  out[#out+1]="\\end{tikzpicture}\\end{center}"
  return table.concat(out,"\n")
end
build_block_synthetic = build_block_synthetic_impl

local function line_to_luaexpr(line)
  if not line:find("#", 1, true) then
    return string.format("%q", line)
  end
  local parts, p = {}, 1
  while true do
    local h = line:find("#", p, true)
    if not h then parts[#parts+1] = string.format("%q", line:sub(p)); break end
    if h > p then parts[#parts+1] = string.format("%q", line:sub(p, h-1)) end
    local expr, after
    if line:sub(h+1, h+1) == "{" then
      expr, after = U.read_group(line, h+1)
    else
      expr = line:match("^#([%a_][%w_]*)", h)
      after = h + 1 + #expr
    end
    parts[#parts+1] = "tostring(" .. expr .. ")"
    p = after
  end
  return table.concat(parts, "..")
end

local function primitive_opts(rest)
  rest = U.trim(rest or "")
  if rest == "" then return "" end
  local m = rest:match("^measures:(%a+)$")
  if m == "cm" or m == "mm" then return (", measures=%q"):format(m) end
  error("texecole: <draw> primitive option not understood: '" .. rest .. "'")
end

local function primitive_to_lua(line)
  line = U.trim(line)

  local parg, prest = line:match("^point%s*(%b())%s*(.-)$")
  if parg then
    parg = U.trim(parg:sub(2, -2))
    local nm = parg:match("^([%a_][%w_]*)$")
    local namefld = nm and ("name=%q, "):format(nm) or ""
    return ("__dadd({kind=\"point\", %sx=(%s)[1], y=(%s)[2]%s})")
           :format(namefld, parg, parg, primitive_opts(prest))
  end

  local largs, lrest = line:match("^line%s*(%b())%s*(.-)$")
  if largs then
    largs = largs:sub(2, -2)

    local depth, cut = 0, nil
    for k = 1, #largs do
      local c = largs:sub(k, k)
      if c == "{" or c == "(" then depth = depth + 1
      elseif c == "}" or c == ")" then depth = depth - 1
      elseif c == "," and depth == 0 then cut = k; break end
    end
    if not cut then
      error("texecole: <draw> line(...) needs two points, e.g. line(A, B)")
    end
    local a = U.trim(largs:sub(1, cut - 1))
    local b = U.trim(largs:sub(cut + 1))
    return ("__dadd({kind=\"line\", x1=(%s)[1], y1=(%s)[2], x2=(%s)[1], y2=(%s)[2]%s})")
           :format(a, a, b, b, primitive_opts(lrest))
  end

  return nil
end

local function extract_scale(s)
  local scale

  s = s:gsub("%f[%a]scale:(%S+)", function(v)
    scale = tonumber(v)
    if not scale or scale <= 0 then
      error("texecole: <draw> scale: needs a positive number, got '" .. v .. "'")
    end
    return ""
  end, 1)
  return U.trim(s), scale
end

return function(sl)
  SL = sl
  sl.build_figure_block = build_block

  local function register(name)

    sl.register_tag(name, function(api, words, content)
      local parts = {}
      for k = 2, #words do parts[#parts+1] = words[k] end
      local line = U.trim((table.concat(parts, " ") .. " " .. (content or "")))
      local scale
      line, scale = extract_scale(line)
      local sarg = scale and (", nil, " .. scale) or ""
      local prim = primitive_to_lua(line)
      if prim then
        api.raw("do local __dfig = {}\n")
        api.raw("local function __dadd(s) __dfig[#__dfig+1] = s end\n")
        api.raw(prim .. "\n")
        api.raw('emit(__drawbuild(__dfig' .. sarg .. ')) end\n')
      else
        api.raw('emit(__drawbuild({' .. line_to_luaexpr(line) .. '}' .. sarg .. '))\n')
      end
    end)

    sl.register_block(name, function(api, words_str, inner)
      local single, blockscale = extract_scale(U.trim(words_str or ""))

      local analytic = single:find("axes:", 1, true) ~= nil

      api.raw("do local __dfig = {}\n")
      api.raw("local function __dadd(s) __dfig[#__dfig+1] = s end\n")

      local function emit_line(line)
        line = U.trim(line)
        if line == "" then return end
        if analytic then
          api.raw("__dadd(" .. line_to_luaexpr(line) .. ")\n")
          return
        end
        local prim = primitive_to_lua(line)
        if prim then api.raw(prim .. "\n")
        else api.raw("__dadd(" .. line_to_luaexpr(line) .. ")\n") end
      end

      if single ~= "" and not analytic then emit_line(single) end

      local i, total = 1, #inner
      while i <= total do
        local l = inner[i]
        if type(l) == "string" and l:match("^%s*}%s*$") then
          api.raw("end\n"); i = i + 1
        elseif type(l) == "string" and api.is_control_open(l) then
          api.raw(api.lua_control(l) .. "\n"); i = i + 1
        elseif type(l) == "string" and l:match("%S") then
          emit_line(l); i = i + 1
        else
          i = i + 1
        end
      end

      local sarg = blockscale and (", " .. blockscale) or ", nil"
      if analytic then
        api.raw('emit(__drawbuild(__dfig, ' .. string.format("%q", single)
              .. sarg .. ')) end\n')
      else
        api.raw('emit(__drawbuild(__dfig, nil' .. sarg .. ')) end\n')
      end
    end)
  end

  register("draw")
  register("figure")
end
