# Awesome CV Timeline

A two-column CV forked from Awesome-CV that adds a genuine graphical
timeline drawn down the middle of the page between the sidebar and the
body, from `github:Slyces/awesome-cv-timeline` (LPPL-1.3c). The timeline
is a real layout feature (positions saved to the aux file on one pass and
drawn on the next), not just a recoloured Awesome-CV.

## Files

- `main.tex` — start here.
- `resume.cls` — vendored class (not on CTAN). Patched: see below.
- `fonts/` — Roboto (Apache-2.0), loaded by explicit path.

## Engine

Requires **xelatex** — the class loads `fontspec` unconditionally.

## What was patched, and why

- **Font resolution.** `resume.cls`'s `\newfontfamily` for the header font
  ("Roboto") resolved that name via **fontconfig**, which does not have
  it registered in this pipeline's image even though the upstream repo
  bundles the actual `.ttf` files. Patched to add `Path=fonts/` so
  fontspec loads the bundled files directly.
- **Dropped the Nerd Font dependency.** Upstream also loaded a second,
  ~1.9MB Nerd Fonts symbol set purely so `\icon{}` could switch to it
  before rendering a contact icon — but every icon this class's contact
  macros actually use (`\caddressicon`, `\cmobileicon`, `\cgiticon`, ...)
  is a `\fa*` command from `fontawesome5` (loaded separately), which sets
  its own glyph font regardless of what font is active at the call site.
  Removed the Nerd Font `\newfontfamily` and re-verified every contact
  icon still renders correctly — cutting the download from ~1.8MB to
  ~750KB with no visible change.
- **`\headersmargin`/`\columnsmargin` undefined.** The upstream
  multi-page example sets these two lengths but neither is ever
  `\newlength`'d in `resume.cls` (only `\sidemargin`, `\leftcolumnwidth`
  and `\timelinemargin` are) — declared in `main.tex` instead of patching
  the class, since these are document-level layout lengths.
- **`luacolor` unconditionally required, but LuaTeX-only.** The class
  loaded the `luacolor` package regardless of engine, which hard-errors
  under any engine but LuaTeX — while the class's own doc comment says it
  "must be compiled with XeLaTeX". Nothing else in the class calls
  anything `luacolor` provides, so it was simply dropped.
- **Compounding negative `\vspace` between CV entries.** The `cvitems`
  environment applies `\vspace{-4mm}` on *both* sides; two adjacent short
  `\cventry` blocks (as in this starter's Experience/Education) can
  collide as a result — confirmed visually, not caught by a clean
  compile. Added an explicit `\vspace{4mm}` between entries.
- **`\timeline{<letter>}` argument.** The letter is a *global* section
  counter incremented by every `\cvsection` call in document order, not
  tied to which textblock a section physically sits in — Contact=A,
  Skills=B, Experience=C, Education=D here, so the timeline (which should
  start at the first section on the right) is `\timeline{C}`.
- **Two relative-width `tabular*` formulas** (Contact block, spoken
  Languages table) rendered far wider than the 5cm sidebar column and
  visibly overflowed into the body text — replaced with simple
  fixed-width tables/minipages.

## Licence

LPPL-1.3c, forked from Awesome-CV. Verified in the class header comment.
The bundled Roboto font is Apache-2.0; the upstream repo ships it without
a separate licence file, so none is included here either.
