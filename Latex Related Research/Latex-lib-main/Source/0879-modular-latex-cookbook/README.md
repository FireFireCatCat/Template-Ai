# Modular LaTeX Cookbook

Adapted from [itakurah/latex-cookbook](https://github.com/itakurah/latex-cookbook) (MIT
licence). One recipe per file under `recipes/`, `\input` into `main.tex`; each recipe
gets a full-bleed photo, a servings/prep-time/cook-time header, and ingredient + numbered
step lists. Compile with XeLaTeX.

## Two changes from the upstream repo

- **Display font substituted.** Upstream uses a bundled font called "TheSeasons" for
  headings, with no licence statement anywhere in the repo (not in the outer MIT
  `LICENSE`, no separate font licence file). That is a real, commercial display font —
  shipping it without a verifiable grant would be a licence risk. Replaced with
  **EB Garamond** (SIL OFL-1.1), already available in this pipeline's TeX Live — loaded by
  its exact TeX Live filename (`EBGaramond-Regular.otf` etc, resolved via kpathsea's file
  search) rather than by bare family name, since this pipeline's fontconfig registers only
  a handful of core families and a family-name lookup for anything else can silently
  resolve to nothing. The body font, Public Sans (SIL OFL-1.1, confirmed), is unchanged
  and still vendored locally in `fonts/` with an explicit `Path=`.
- **Recipe photos are placeholders.** The class hard-requires a real image file per
  recipe (`\includegraphics` inside `\setRecipeMeta`), and upstream's own food photos are
  not ours to redistribute. `images/carbonara.jpg` and `images/ragu.jpg` are original
  abstract graphics (concentric circles) generated for this starter — swap them for your
  own photos.

## Renamed files

To avoid colliding with the CTAN `RecipeBook` class (Brad Granger, a different author and
licence) also on this site, the class and its support files are renamed:
`recipebook.cls` → `latex-cookbook.cls`, `recipebook.cfg` → `latex-cookbook.cfg`,
`recipebook-lang.sty` → `latex-cookbook-lang.sty`.

## Adding a recipe

Copy `recipes/carbonara.tex` as a template: set `\setRecipeMeta{Title}{Servings}{Prep
Time}{Cook Time}{Image Path}`, then list `\ingredient{...}` and `\step{...}` entries
inside the `ingredients`/`steps` environments. Add the new `\input{recipes/...}` line to
`main.tex`.
