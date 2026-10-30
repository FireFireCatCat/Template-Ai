yes

# 0375-two-column-recipes: Two-Column Recipes

- Unverified: read from the source, not compiled.
- Source: Source/0375-two-column-recipes/ (origin: https://latextemplates.com/downloads/cooking-two-column-recipes.zip; licence: GPL-2.0-or-later per the manifest; LICENSE:1-2 is the GNU GPL v2 text; cooking.sty:11 says "Copyright (C) 1999 Axel Reichert"; https://ctan.org/pkg/cooking read once: GNU General Public License)
- Kind: misc (a recipe collection; no kind in the rubric list fits)
- Lib: v4
- Engine: pdfLaTeX-compatible (main.tex:9-11 load only `babel`, `fontenc`, `textcomp`; cooking.sty uses kernel commands only, no fontspec, no tool outside TeX)
- Look carried by: mixed (the recipe look is defined by the vendored style file cooking.sty, which is the published CTAN package `cooking`, loaded at main.tex:12; the preamble adds five label strings at main.tex:14-18 and selects its page style at main.tex:20)
- Class origin: tex-distribution-unbundled (kernel `article`, main.tex:7, not in the zip; its source was not read). `cooking` is a package, not a class; it is published on CTAN (ctan.org/pkg/cooking read once: "Typeset recipes", v0.9b, Axel Reichert, listed as included in TeX Live and MiKTeX), so cooking.sty is not zip-local.
- Main file: main.tex (other samples: none)
- Read: main yes (all 68 lines), zip-local classes and styles all (cooking.sty, all 107 lines; the zip has no .cls; LICENSE is GPL text, only its first 20 lines were opened)

## Verdict
yes. The sample is `article` with `a4paper,11pt`, `geometry`, `babel`, `fontenc`, `textcomp`, and one recipe package, `cooking`, which is published on CTAN (cooking.sty:30-32 says v0.9b, the version on the CTAN page). The package is chosen by package options (`it` or `bf`, `newpage` or `nopage`), one length (`\recipemargin`) and label strings, serves any recipe collection, and prints as one preamble line plus a `recipe` environment per recipe, so it passes W1 to W4 as the new way `recipe.xcookybooky`. The only code the sample itself defines is five one-line `\renewcommand*` label macros (main.tex:14-18), each of the form `\item[label] text`, which reduce to label strings of that way. There is no artwork, no `.cls`, no counter or conditional, and no external tool. Risks: cooking.sty was not diffed against the CTAN copy (no download), and the "two columns" of the title are the list's label column and text column, not a two-column page.

## Blockers
none

## Class setting
- Class: `class.article` options: `a4paper`, `11pt` (main.tex:7)
- Class-native vocabulary used: none of the class's front matter or sectioning (no `\maketitle`, `abstract`, `\section`, `\tableofcontents`); the whole body is the package's `recipe` environment (main.tex:24-46, 48-66) inside `document` (main.tex:22, 68)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:7 | `class.article` | `a4paper`, `11pt` |
| paper size and base font size | main.tex:7 | `page.class-options` | `a4paper`, `11pt` |
| margins | main.tex:8 | `page.geometry` | `margin=1in` |
| language | main.tex:9 | `lang.babel` | option `english` |
| encoding and symbols | main.tex:10-11 | `font.fontenc-t1` | `fontenc` option `T1`; `textcomp` |
| recipe package load and defaults | main.tex:12; cooking.sty:37-50 | `recipe.xcookybooky` | `\usepackage{cooking}` with no option, so the defaults `it,newpage` apply (cooking.sty:49); `bf`/`it` set `\ingredientfont` to `\bfseries`/`\itshape` (cooking.sty:37-42) |
| recipe title | main.tex:24, 48; cooking.sty:51-58 | `recipe.xcookybooky` | `\begin{recipe}{Title}`; unnumbered level-1 heading indented by `\recipemargin`, space before `3.5ex plus 1ex minus 0.2ex`, after `2.3ex plus 0.2ex`, font `\raggedright\large` plus `\ingredientfont` (italic by default) |
| ingredient and step list ("two columns") | main.tex:24-46; cooking.sty:33-34, 70-76, 77-95 | `recipe.xcookybooky` | `recipe` environment over a `list`: `\recipemargin` = `0.35\columnwidth`; `\leftmargin` = `\recipemargin`; `\labelwidth` = `\recipemargin` minus `\labelsep`; `\labelsep` 1em; `\topsep` `\partopsep` `\itemsep` 0ex; label is a bottom-aligned right-aligned `minipage` in `\ingredientfont` |
| ingredient items | main.tex:25-32, 49-53; cooking.sty:70 | `recipe.xcookybooky` | `\ingredient{amount}` (`\item[{amount}]`) followed by the ingredient name as item text |
| step paragraphs | main.tex:34-39, 55-62 | content | plain paragraphs that follow the last `\ingredient` line and sit in that item's body |
| meta lines (energy, side dish, hint, preparation time, modification) | main.tex:41-45, 64-65; defaults cooking.sty:59-69 | `recipe.xcookybooky` | `\energy{n}`, `\sidedish{}`, `\hint{}`, `\preparationtime{}`, `\modification{}`; labels replaced by English strings at main.tex:14-18 (`Side dish`, `Hint`, `Preparation time`, `Modification`; energy has no label and the text `#1\,kJ per helping`) |
| thin space before a unit | main.tex:14 | `sp.manual-space` | kernel `\,` inside the energy string |
| page style | main.tex:20; cooking.sty:96-104 | `hf.pagestyle-kernel` | `\pagestyle{recipe}`; the style `recipe` is defined by the package: empty head, foot `\normalfont\hspace{\recipemargin}\thepage\hfill` (page number aligned with the text column) |
| page break between recipes | cooking.sty:36, 43-48 | `recipe.xcookybooky` | options `newpage`/`nopage` set `\recipeendhook`; in this copy the macro is declared and set but the `recipe` environment never calls it (cooking.sty:77-95), so no effect is read from it |
| title block, abstract, contents, headings, floats, tables, code, bibliography, maths, notes | none | none | not used in the sample (main.tex has no `\maketitle`, `\section`, `figure`, `tabular`, `\bibliography`, `\footnote`) |

## Bespoke code
The only definitions in the sample are the five `\renewcommand*` lines. cooking.sty is the published package, so its internals (the list, the `\@startsection` title, the `\ps@recipe` page style) belong to the way; they are listed only to show what the way contains.

| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\renewcommand*{\energy}[1]{\item #1\,kJ per helping}` | main.tex:14 | yes | a label-less item whose text template is a string; emitter prints the same line as a parameter of `recipe.xcookybooky` |
| `\renewcommand*{\sidedish}`, `\hint`, `\preparationtime`, `\modification` | main.tex:15-18 | yes | each body is `\item[Label] #1`, so each is one label string (`Side dish`, `Hint`, `Preparation time`, `Modification`); main.tex:4-6 says the package documentation supplies these English strings, which was not checked (cooking.dtx is not in the zip) |
| `\newlength{\recipemargin}` and the `recipe` list, `\recipetitle`, `\ps@recipe` | cooking.sty:33-34, 51-58, 77-104 | yes (published) | one length and a title, list and page style of the published `cooking` package; if W1 for the package were refused, they would reduce to `head.kernel` (starred `\@startsection` look), `sp.lengths` (list lengths), `box.minipage`, `sp.ragged`, `font.size-commands`, `mark.kernel` and `hf.fancyhdr` (foot field), but this is not relied on |
| `\ingredientfont`, `\recipeendhook`, `\DeclareOption{bf,it,nopage,newpage}`, `\ExecuteOptions{it,newpage}` | cooking.sty:35-50 | yes (published) | the package's own option machinery; its values are `bf`/`it` and `newpage`/`nopage`, set as package options |

## Content-opaque
none (no figure, table, picture or drawing in the sample)

## Lib changes
- New ways proposed: `recipe.xcookybooky` `cooking` (CTAN, listed in TeX Live and MiKTeX, v0.9b, GPL, Axel Reichert; pdfLaTeX): a recipe collection in a two-column list (ingredient amount on the left, step text on the right); `\usepackage[it|bf,newpage|nopage]{cooking}`, length `\recipemargin`, page style `\pagestyle{recipe}`, body `recipe{title}` environment with `\ingredient{amount}` items, step paragraphs after them, and label-string macros `\energy` `\sidedish` `\hint` `\preparationtime` `\modification` (default German strings, replaced in the sample). W1: published on CTAN (ctan.org/pkg/cooking read once). W2: behaviour is chosen by the options `bf`/`it` and `newpage`/`nopage`, one length and label strings, not by editing its code. W3: it serves a kind of document, a recipe or recipe collection, not this sample. W4: one preamble line plus one body wrapper per recipe around the content, so an emitter can print it. Not the same way as `recipe.xcookybooky`: a different package with a different vocabulary (`recipe[keys]{title}` with `\ingredients` and `\preparation`), kept apart as the lib keeps `inv.simpleinvoice`, `inv.facture-belge` and `inv.invoice2` apart. Considered: `cuisine` (named under "See also" on the CTAN page; not used by this zip).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- main.tex:1-6 is an author comment ("Vendored: not in TeX Live"); the CTAN page read once lists the package as included in TeX Live and MiKTeX. W1 rests on the CTAN listing either way. No text in the zip is addressed to an AI.
- Not checked: that cooking.sty is byte-identical to the CTAN copy, and the package's README and documentation (not in the zip).
