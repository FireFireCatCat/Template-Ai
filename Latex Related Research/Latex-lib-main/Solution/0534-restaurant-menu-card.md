yes

# 0534-restaurant-menu-card: Restaurant Menu Card (menucard package, three-course bistro menu)

- Unverified: read from the source, not compiled.
- Source: Source/0534-restaurant-menu-card/ (origin: https://latextemplates.com/downloads/restaurant-menu-card.zip; licence: LPPL-1.3)
- Kind: misc (the manifest hint says misc; the sample is a one-page priced restaurant menu, which no other kind in the list fits)
- Lib: v4
- Engine: pdfLaTeX-compatible (the sample loads no engine-specific package, main.tex:17-20; main.tex:5-6 states "No fontspec -- pdflatex-safe", a claim in the zip; `menucard.sty` is not in the zip and was not read, so its own dependencies are not established)
- Look carried by: preamble (kernel `article` carries nothing; the published `menucard` package defines the menu groups, entries and colours; the sample's own preamble loads it and sets the margins and an empty page style, main.tex:17-20)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
`yes`. The zip holds one 69-line `main.tex` and nothing else. It loads kernel `article`, `geometry` and the published `menucard` package (CTAN, TeX Live, LPPL 1.3), and defines no macro, environment or counter of its own (grep for `newcommand`, `def`, `newenvironment`, `newcounter` over main.tex finds none). The menu look sits in `menucard`, which is one doc-kind way (`menu.menucard`) like `recipe.xcookybooky` or `card.gcard`. The `menucard` source was not read, so what it loads and which options it takes are not established; the sample uses no option and passes only strings.

## Blockers
none

## Class setting
- Class: `class.article` options: `11pt` (main.tex:17). Kernel class, in the TeX distribution and not in the zip; its source was not read.
- Class-native vocabulary used: none (no `\maketitle`, no `abstract`, no `\section`; the title and the course headings are not made by the class).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class | main.tex:17 | `class.article` | 11pt |
| page size and base font size | main.tex:17 | `page.class-options` | `11pt`; no paper option, so the class default |
| page geometry | main.tex:18 | `page.geometry` | margin=2.5cm |
| header/footer | main.tex:20 | `hf.pagestyle-kernel` | `\pagestyle{empty}` (no running head, foot or page number) |
| menu package load | main.tex:19 | `menu.menucard` | `\usepackage{menucard}`, no options |
| course block (heading plus its dishes), starred form | main.tex:31-38, 55-62 | `menu.menucard` | environment `Group*` with one argument (the course title: Starters, Desserts); body is `\Entry`/`\Expl` pairs separated by `\\` |
| course block, unstarred form with numbered rows | main.tex:42-51 | `menu.menucard` | environment `Group` with one argument (Mains); body rows use `\Entrycount` and carry `&` cells on the description line (main.tex:44, 46, 48, 50), so this form is inferred to be a multi-column row environment; inferred from the sample only |
| dish name and price | main.tex:32, 34, 36, 56, 58, 60 | `menu.menucard` | `\Entry{name}{price}` |
| numbered dish name and price | main.tex:43, 45, 47, 49 | `menu.menucard` | `\Entrycount{name}{price}` (the number is printed by the package; how is not read) |
| dish description | main.tex:33, 35, 37, 44, 46, 48, 50, 57, 59, 61 | `menu.menucard` | `\Expl{text}` |
| restaurant title (hand-laid, no `\maketitle`) | main.tex:24-27 | `sp.ragged` | `center` environment |
| restaurant title size | main.tex:25, 26 | `font.size-commands` | `\fontsize{36}{40}\selectfont` for the name, `\normalsize` for the subtitle |
| restaurant title face and colour | main.tex:25, 26 | `menu.menucard` | `\zapf` (package font switch, said at main.tex:6-8 to select Zapf Chancery, family pzc from psnfss), `\ColText{..}` and `\ColSubText{..}` (package colour wrappers; the colours are not read) |
| gap between title lines and dishes | main.tex:25, 33, 35, 44, 46, 48, 57, 59 | `sp.manual-space` | `\\[0.3em]` after the name; `\\[0.8em]` after each description |
| gap between title and courses | main.tex:29, 40, 53, 64 | `sp.manual-space` | `\vspace{2em}` |
| closing service-charge note | main.tex:65-67 | `sp.ragged` | `center` environment |
| closing note size | main.tex:66 | `font.size-commands` | `\footnotesize` |
| closing note colour | main.tex:66 | `menu.menucard` | `\ColSubText{..}` |
| no sectioning, lists, tables, floats, maths, notes, bibliography | main.tex:22-69 | none used | the sample uses none of these |

## Bespoke code
none. No `\newcommand`, `\renewcommand`, `\def`, `\newenvironment`, `\newcounter`, `\newif` or `\input` in main.tex (grep over the file; the file is 69 lines and was read in full). The zip holds no `.cls`, `.sty`, `.def` or `.cfg`. The `menucard` package is published, so it is a way, not bespoke code.

## Content-opaque
none. The prices, dish names and descriptions are text content (main.tex:32-61). The price symbol `\textsterling` (main.tex:32, 34, 36, 43, 45, 47, 49, 56, 58, 60), the accents (`\`e` main.tex:33 and 56, `\^u` and `\'e` main.tex:56) and `12.5\%` (main.tex:66) are text-symbol and accent commands inside that content; no symbol package is loaded (main.tex:17-20).

## Lib changes
- New ways proposed: `menu.menucard`: `menucard` (CTAN, TeX Live and MiKTeX; Sascha Frank; LPPL 1.3; v0.1 of 2020-06-17 on ctan.org/pkg/menucard, read once; the CTAN page lists no dependencies and no commands); pdfLaTeX-compatible as far as read; a restaurant menu: `\usepackage{menucard}`, environments `Group` and `Group*` per course with the course title as the argument, row commands `\Entry{name}{price}`, `\Entrycount{name}{price}`, `\Expl{text}`, and the title helpers `\zapf`, `\ColText{}`, `\ColSubText{}`. W1: on CTAN and in TeX Live, not shipped in this zip (main.tex:4-5 says the starter does not bundle it, and the folder holds only main.tex). W2: the sample passes only strings (course title, dish name, price, description, title text) and uses no package option; the package source was not read, so its options and colour keys are not established. W3: it serves any restaurant menu, not one document; the bistro in this sample is invented. W4: one preamble line plus body environment wrappers around entry rows and span wrappers. Not `recipe.xcookybooky` (a recipe with ingredients and method, a different package), not `tbl.tabular` or `list.kernel` (the package builds its own rows), not `card.gcard`.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- main.tex:5, 6 and 15 call menucard "the class" ("the class's \zapf numbering command", main.tex:6), but main.tex:19 loads it with `\usepackage` and main.tex:17 loads `article`, so the class is `article` and `menucard` is a package.
- main.tex:1-4 quotes a licence text "verified in the shipped menucard.sty header", yet the zip ships no `menucard.sty`; the licence given here (LPPL 1.3) matches the CTAN page. Treated as a comment (data), not followed.
- No text addressed to an AI was found in the zip.
- What was not read: `menucard.sty` (not in the zip, no local TeX tree found, the CTAN page documents no commands). The inferred points are the structure of the unstarred `Group` row, the number printed by `\Entrycount`, the colours of `\ColText` and `\ColSubText`, and the package's own dependencies.
