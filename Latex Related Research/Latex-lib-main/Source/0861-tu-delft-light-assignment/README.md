# tudelft-assignment

TU Delft's own lightweight XeLaTeX report/assignment class
(`skilkis/tudelft-light`): a TikZ cover page, an inner title page with
course/author/supervisor/student-number fields, a `questions`
environment for research questions, nomenclature support, and TU
Delft's house colours and branding throughout.

## Files

- `main.tex` — a real structural-engineering assignment (cantilevered
  sensor-bracket static and fatigue analysis). Start here.
- `tudelft-light/` — the vendored class (`tud-report.cls` and its
  `tud-*.sty` subpackages), **modified** — see below.
- `examples/` — the starter content: abstract, the main chapter
  (tables, TikZ figures, the `questions` environment, nomenclature),
  and a code-listing appendix with a bundled `fatigue.py`.
- `references.bib` — a real bibliography entry, cited with `natbib`.
- `LICENSE.md` — upstream's MPL-2.0 licence, covering the class code.

## Building

    xelatex main
    bibtex   main
    xelatex main
    xelatex main

`\RequireXeTeX` is hard-coded in `tud-report.cls` — this class refuses
to load under `pdflatex` or `lualatex`.

## Font substitution — why, and with what

Upstream bundles proprietary Microsoft fonts (Arial, Georgia, plus
several more that ship but are never actually loaded: Cambria Math,
Courier New, Tahoma, Bookman Old Style) directly in the repository,
labelled with an Apache-2.0 licence file. **That licence does not
apply to the fonts.** Microsoft's own EULA governs its typefaces
per-Windows/Office-installation and prohibits redistribution outright
— a downstream repository placing an Apache-2.0 file next to the
`.ttf`s cannot re-license fonts it does not own. None of those font
binaries ship in this download.

A **third** proprietary font was found beyond the Microsoft set:
`TUDelft-UltraLight.ttf`, the cover-page title face. Its own embedded
name-table metadata reads:

> This font has been exclusively developed for TU Delft. It may ONLY
> be used on communication items of TU Delft. All other use is
> prohibited.

Restricted, not free — so it does not ship either, regardless of not
being a Microsoft font.

The class only actually *loads* two of the bundled Microsoft fonts
(`tud-style.sty`): Arial for the sans family and Georgia for the body
serif. Substituted with their free, metric-compatible equivalents —
same line breaks, same spacing:

| Role | Upstream (not shipped) | Substitute (shipped) |
|---|---|---|
| Cover title (`\tudtitlefamily`) | TU Delft-UltraLight (restricted) | Carlito |
| Body serif (`\tudrmfamily`) | Georgia | Gelasio |
| Sans (`\tudsffamily`) | Arial | TeX Gyre Heros |

Carlito has no metric-compatibility claim to make here — UltraLight
was never mimicking a third-party commercial face, so it is simply a
clean, sufficiently-light free sans for a large display title. Gelasio
and TeX Gyre Heros are both Google/TeX-Gyre-commissioned drop-in
metric equivalents for Georgia and Arial respectively.

All three are loaded by exact TeX Live **filename** via `fontspec`'s
`Path=`, not by fontconfig family name — this catalogue's compiler
image resolves only a handful of fontconfig families, so a name-based
`\setmainfont{Carlito}` would silently render a blank page. Loading by
filename via kpathsea reaches every font TeX Live ships.

TU Delft's own seal and cover-background artwork (`tudelft-light/images/`)
are institutional branding and ship as-is, unmodified — the same
treatment already applied to this catalogue's `tu-delft-poster`.

## Other changes from upstream

This catalogue's compiler runs a fixed
`<engine> → bibtex → <engine> → <engine>` cycle with no `biber` pass
and no `-shell-escape`. Two upstream defaults do not survive that:

- **Bibliography**: `biblatex`+`biber` replaced with `natbib`+`bibtex`
  (`\printbibliography` → `\bibliography{...}`, `\cite`/`\citet`/`\citep`
  unchanged).
- **Code listings**: `minted` (needs `-shell-escape` and Pygments at
  compile time) replaced with `listings`, wrapped in a `listing` float
  that reproduces upstream's per-chapter numbering (`Listing 1.1`) and
  List of Listings.

`\printnomenclature` is not called in `main.tex`: it needs a
`makeindex -s nomencl.ist` pass this pipeline doesn't run. The
`\nomenclature{...}` entries in the example chapter are still there
and still valid LaTeX — add `\printnomenclature` back locally if you
run `makeindex` yourself.

All placeholder personal data (author name, student number,
supervisor) is generic — upstream's own examples already used
`John Doe`/`Jane Doe`/`Dr. Jan Jansen` throughout, so nothing needed
stripping there; this starter's own placeholders follow the same
pattern.

## Licence

`tudelft-light` (both the outer template repo and the `tudelft-light`
class submodule) is **MPL-2.0**, © San Kilkis. Source:
https://github.com/skilkis/tudelft-light — `LICENSE.md` is included in
this download per the licence's terms.

The substituted fonts (Carlito, Gelasio, TeX Gyre Heros) ship with TeX
Live under their own free licences and are not bundled in this
download — they're loaded from the compiler's TeX Live installation.
