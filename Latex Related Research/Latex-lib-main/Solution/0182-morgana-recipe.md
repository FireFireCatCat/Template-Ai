yes

# 0182-morgana-recipe: Morgana Recipe

- Unverified: read from the source, not compiled.
- Source: Source/0182-morgana-recipe/ (origin: https://latextemplates.com/downloads/morgana-recipe.zip; licence: not established (manifest says "N/A — original starter, no upstream package"))
- Kind: misc (a one-page recipe card; the manifest hint `misc` agrees)
- Lib: v3
- Engine: pdfLaTeX-compatible (T1 + inputenc, no fontspec; every package loaded is pdfTeX-safe)
- Look carried by: preamble (kernel `article` unmodified; page, colour and columns are set in the preamble, the title block, section labels and rule are hand-laid in the body with kernel commands; no `.cls`/`.sty` in the zip)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
The zip is a single 95-line `main.tex` on the kernel `article` class. It defines nothing: no `\newcommand`, `\def`, environment, counter or zip-local class or style. Every part of the look is a published package option or a kernel command (geometry, xcolor, multicol, enumitem, `\pagestyle`, font-size and font-switch commands, `\vspace`). The one risky item is the TikZ line under the title (main.tex:28-30). It is a single straight segment with a width and a colour, so it reduces to the kernel `\rule` (`sp.rule`) with declarative parameters, and is not template-defining artwork under the rubric. The case change `\uppercase` has no home in the lib and passes W1 to W4, so `mark.case` is proposed. Verdict `yes`; a stricter reader who files the TikZ line as `ART` would turn it into `no` (see Bespoke code).

## Blockers
none

## Class setting
- Class: `class.article` options: `a4paper`, `10pt` (main.tex:1). Source of `article` not read: it ships with the LaTeX base, not in the zip.
- Class-native vocabulary used: none. The sample uses no `\maketitle`, `abstract`, `\section` or `\appendix`; the title block and section labels are hand-laid (main.tex:22-25, 36, 53, 65, 87).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.article` | a4paper, 10pt |
| paper size and base size | main.tex:1 | `page.class-options` | `a4paper`, `10pt` |
| page geometry | main.tex:3 | `page.geometry` | margin=2cm |
| font encoding | main.tex:4-5 | `font.fontenc-t1` | fontenc `T1`; inputenc `utf8`; no text-face package, so the default Computer Modern family stays |
| colour | main.tex:6, 11 | `color.xcolor` | `\definecolor{tagline}{HTML}{B23A48}`; used by `\color{tagline}` at main.tex:22, 36, 39, 53, 56, 65, 69, 87 and by the rule at 29 |
| columns | main.tex:7, 14, 15, 34, 63, 93 | `cols.multicol` | `multicols{2}`; `\columnsep`=2em, `\columnseprule`=0.3pt (multicol's own lengths, set with `\setlength`); `\columnbreak` before METHOD |
| header/footer | main.tex:13 | `hf.pagestyle-kernel` | `\pagestyle{empty}` (no header, footer or page number) |
| tagline above the title | main.tex:22 | `color.xcolor`, `font.size-commands`, `mark.kernel`, `mark.case` | `\color{tagline}`, `\small`, `\bfseries`, `\uppercase{...}`; text is content, the `\textbullet` glyphs are content separators |
| title | main.tex:25 | `font.size-commands`, `mark.kernel` | `\Large`, `\bfseries`; no `\title`/`\maketitle` |
| paragraph indent off | main.tex:22, 25, 28 | `sp.lengths` | `\noindent` (the one-paragraph form of `\parindent=0`) |
| vertical gaps | main.tex:24, 27, 32, 37, 52, 54, 66, 86, 88 | `sp.manual-space` | `\vspace` 0.2em, 0.3em, 0.8em, 0.3em, 0.6em, 0.3em, 0.3em, 0.8em, 0.3em |
| title rule | main.tex:9, 28-30 | `sp.rule` | reduction of the TikZ segment: `{\color{tagline}\rule[-0.6pt]{\linewidth}{1.2pt}}` in a `\noindent` paragraph (width `\linewidth`, height 1.2pt, raise -0.6pt because the TikZ line is centred on the baseline, colour `tagline`). `tikz` need not be loaded |
| section labels (INGREDIENTS, NUTRITION, METHOD, SWAP IT) | main.tex:36, 53, 65, 87 | `color.xcolor`, `mark.kernel`, `font.size-commands`, `sp.manual-space` | `{\color{tagline}\bfseries\small TEXT}` then `\vspace{0.3em}`; capitals are typed in the text; plain paragraphs, no heading command, no numbering |
| bullet list (ingredients, nutrition) | main.tex:39-50, 56-61 | `list.kernel`, `list.enumitem` | `itemize[leftmargin=1em, itemsep=2pt, label={\color{tagline}\tiny\textbullet}]`; second list `itemsep=1pt` |
| numbered list (method) | main.tex:68-84 | `list.kernel`, `list.enumitem` | `enumerate[leftmargin=1.3em, itemsep=5pt, label={\color{tagline}\bfseries\arabic*}]` |
| body paragraph | main.tex:90-91 | none (content) | plain text; `---` dash is content |

Not present in the sample (no row): title command, abstract, contents, headings, numbering, footnotes, quotes, math, theorems, floats, tables, captions, code, bibliography, index, cross-references, language, metadata, fonts beyond T1.

## Bespoke code
none. The sample defines one colour (`\definecolor`, main.tex:11, which is `color.xcolor`) and two length assignments (main.tex:14-15, `\setlength` on multicol's `\columnsep` and `\columnseprule`); there is no `\newcommand`, `\def`, `\newenvironment`, counter or conditional.

| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| TikZ line under the title | main.tex:28-30 (`\usepackage{tikz}` at 9) | yes (judgement call) | one `\draw[tagline, line width=1.2pt] (0,0) -- (\linewidth,0);` is a straight rule. `sp.rule` names `\rule` with width, height, raise and an `xcolor` colour, so the whole effect is a composition of lib ways: `\color{tagline}\rule[-0.6pt]{\linewidth}{1.2pt}`. It has no loop, node, path logic or computed geometry. Were it a shape, frame or ornament it would be `ART`; kept as `art.tikz` it would be `ART/body`. |

## Content-opaque
none (the TikZ line is not inside a float; it is treated above as template, and reduces to `sp.rule`)

## Lib changes
- New ways proposed: `mark.case` kernel `\uppercase` / `\MakeUppercase` (and `\lowercase` / `\MakeLowercase`), pdfLaTeX, inline wrapper that changes the case of its text argument (main.tex:22). W1: kernel commands. W2: no code is edited; the behaviour is picked by the command (upper or lower) and the text, as `\textbf` in `mark.kernel` has no option either. W3: serves any all-caps label, running head or tagline in any document. W4: printed as a body wrapper `\uppercase{...}` around a node's text. Reason it is not `mark.kernel`: the rubric ties that way to kernel font-switch commands, and case change is not a font switch; the consolidator may instead merge it into `mark.kernel` as a widening, which changes no verdict here.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
