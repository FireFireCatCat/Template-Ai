yes

# 0328-long-form-recipe-cards: Long-Form Recipe Cards

- Unverified: read from the source, not compiled.
- Source: Source/0328-long-form-recipe-cards/ (origin: https://latextemplates.com/downloads/long-form-recipe-cards.zip; licence: LPPL-1.3; main.tex:1-4 says the package xcookybooky is LPPL 1.3, https://ctan.org/pkg/xcookybooky read once: LPPL 1.3)
- Kind: misc (recipe cards; no kind in the rubric list fits)
- Lib: v3
- Engine: pdfLaTeX-compatible (main.tex:5-6 says "No fontspec -- pdflatex-safe"; the author's claim, not tested here; the package depends on the CTAN `emerald` font package, no tool outside TeX is named on its CTAN page)
- Look carried by: preamble (the one published CTAN/TeX Live package `xcookybooky` loaded at main.tex:27 carries the whole look; the zip has no `.cls`, `.sty` or other local file, and the sample defines no macro of its own)
- Class origin: tex-distribution-unbundled (kernel `article`, main.tex:26, not in the zip; its source was not read. `xcookybooky` is a package, not a class, and is not in the zip: main.tex:4-5 "Ships with TeX Live ... starter does not bundle the class"; CTAN page: v1.5, 2015-03-03, included in TeX Live and MiKTeX)
- Main file: main.tex (other samples: none)
- Read: main yes (all 138 lines), zip-local classes and styles none present (the zip holds only main.tex; the source of `xcookybooky` was not read, it is not in the zip and no TeX Live tree is installed here)

## Verdict
yes. The sample is `article` with `a4paper`, one `\usepackage{xcookybooky}`, and two `recipe` environments built only from that package's own interface (`\graph`, `\ingredients`, `\preparation`, `\suggestion`, `\hint`) plus kernel markup. Nothing is defined in the zip (no `\newcommand`, `\def`, counter or conditional), so there is no bespoke code and no artwork. The package is published (CTAN and TeX Live, LPPL 1.3), is chosen by key=value options and body arguments, serves any recipe document and prints as one preamble line plus a body wrapper, so it passes W1 to W4 as the new way `recipe.xcookybooky`. Risk: the package's own source was not read, so the internals of its layout are taken on trust as published code. The package's `\step` macro is broken with current `lettrine` according to the author's comment (main.tex:8-16, not tested here); the sample avoids it and an emitter would do the same.

## Blockers
none

## Class setting
- Class: `class.article` options: `a4paper` (main.tex:26)
- Class-native vocabulary used: none of the class's front matter or sectioning (no `\maketitle`, `abstract` or `\section`); the whole body is the package's `recipe` environment (main.tex:31-92, 94-136) inside `document` (main.tex:29, 138)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:26 | `class.article` | `a4paper` |
| page size | main.tex:26 | `page.class-options` | `a4paper`; no margin, geometry or column command in the sample, so page layout is the class default plus whatever the package sets inside itself |
| recipe look as a whole (title, meta line, ingredients column, preparation column, aside, hint box) | main.tex:27 | `recipe.xcookybooky` | `\usepackage{xcookybooky}` with no package option |
| recipe wrapper and meta line | main.tex:31-32, 94-95; end at 92, 136 | `recipe.xcookybooky` | environment `recipe`, title in the mandatory argument (`Braised Short-Rib Rag\`u`, `Brown Beef Stock`), keys `portion` (`6 people`, `about 1.5 litres`), `preparationtime` (`45 minutes`, `20 minutes`), `bakingtime` (`3 hours`, `4 hours`), `source` (`House recipe`, first recipe only) |
| picture slot | main.tex:34, 97 | `recipe.xcookybooky` | `\graph{}` with an empty value (the comment at main.tex:22-25 says the key accepts an empty value and omits the image area) |
| intro paragraph | main.tex:36-39, 99-100 | content | plain text between `\graph` and `\ingredients` |
| ingredients table | main.tex:41-56, 102-112 | `recipe.xcookybooky` | `\ingredients{...}` body of rows `quantity & item \\`; one row has an empty quantity cell (main.tex:54) |
| preparation column | main.tex:58-83, 114-131 | `recipe.xcookybooky` | `\preparation{...}` body of paragraphs separated by blank lines |
| step numbers | main.tex:60, 65, 70, 73, 77, 81 (second recipe 116, 120, 124, 128) | `mark.kernel` | `\textbf{N.}` typed by hand at the start of each paragraph; the package's `\step` is not used (main.tex:8-16) |
| suggestion aside | main.tex:85-86 | `recipe.xcookybooky` | `\suggestion[Make ahead]{text}` with an optional title |
| hint callout | main.tex:88-90, 133-134 | `recipe.xcookybooky` | `\hint{text}` |
| number-unit spacing | main.tex:43, 48-49, 53, 55, 104, 108 | `sp.manual-space` | kernel thin space `\,` between a quantity and its unit (`2.5\,kg`, `200\,ml`, `3\,tbsp`) |
| degree sign | main.tex:75, 116 | `font.fontenc-t1` | `\textcelsius` (a `textcomp` symbol, in the LaTeX kernel since 2020) |
| fonts | none set in the sample | none | the package brings its own icon fonts (CTAN `emerald`), inside the way |
| header/footer, headings, toc, lists, tables outside the package, floats, bibliography, language, metadata | none in the sample | none | not used (main.tex has no `\pagestyle`, `\section`, `\tableofcontents`, `\bibliography`, `babel` or `hyperref`) |

## Bespoke code
none. A grep of main.tex for `newcommand`, `renewcommand`, `\def`, `newenvironment`, `newcounter`, `newif`, `RequirePackage`, `setlength`, `\input` and `\include` finds none; the only `\usepackage` is main.tex:27. The only mention of a package-internal macro is the unused `\step` (main.tex:8-16), which is part of the published package and is not called.

| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| (none zip-local) | n/a | n/a | n/a |

## Content-opaque
none (no figure, no table float, no picture; `\graph{}` is empty at main.tex:34 and 97)

## Lib changes
- New ways proposed: `recipe.xcookybooky` `xcookybooky` (CTAN, in TeX Live and MiKTeX, v1.5 2015-03-03, LPPL 1.3; pdfLaTeX, needs the CTAN `emerald` fonts; the look of a recipe card: `\usepackage{xcookybooky}` and body `recipe[portion, preparationtime, bakingtime, source]{title}` with `\graph{}`, `\ingredients{qty & item \\ ...}`, `\preparation{...}`, `\suggestion[title]{...}`, `\hint{...}`; the package also has `\step`, not used here). W1: published on CTAN and in TeX Live (ctan.org/pkg/xcookybooky read once). W2: behaviour is chosen by key values (strings for portion, times and source, and the `\graph` picture value) and body arguments, not by editing its code. W3: it serves a kind of document, a recipe or recipe collection, not this one sample (a sibling of `notebook.ftc`, `inv.simpleinvoice`, `cal.kalender`: one package whose environment is the whole document part). W4: one preamble line and one body wrapper environment per recipe around the content, so an emitter can print it. Considered: `lettrine` for the package's `\step` macro; no separate way, because per main.tex:8-14 `\step` only calls `\lettrine` (`sp.lettrine` already exists) and the sample does not use it.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
