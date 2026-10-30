yes

# 0156-evan715823-cheatsheet-generator-skill: Claude Cheatsheet Generator (dense multi-column exam cheat sheet)

- Unverified: read from the source, not compiled.
- Source: Source/0156-evan715823-cheatsheet-generator-skill/ (origin: https://codeload.github.com/Evan715823/cheatsheet-generator-skill/zip/refs/heads/main; licence: MIT)
- Kind: misc
- Lib: v3
- Engine: needs XeLaTeX (`fontspec` `\setmainfont{Verdana}`, skills/cheatsheet-generator/examples/sample_output.tex:8,13; the zip says XeLaTeX is required, skills/cheatsheet-generator/SKILL.md:276)
- Look carried by: preamble (a plain `article` plus a 47-line preamble in the sample, and the same preamble with `%%slots%%` in the base template; no zip-local class or style)
- Class origin: tex-distribution-unbundled
- Main file: skills/cheatsheet-generator/examples/sample_output.tex (other samples: skills/cheatsheet-generator/templates/cheatsheet_base.tex, the same preamble with `%%PLACEHOLDER%%` slots; no other .tex)
- Read: main yes, zip-local classes and styles none present (the zip holds no .cls, .sty, .def, .cfg, .clo; the kernel `article` source was not read)

## Verdict
The look is one published class (`article`) plus a preamble made only of published packages (`geometry`, `multicol`, `amsmath`, `enumitem`, `xcolor`, `titlesec`, `fontspec`, `booktabs`, `graphicx`) and kernel commands; the body is `\section`/`\subsection`, `itemize`, `tabular` and inline maths in a six-column `multicols`. The only bespoke code is four `\newcommand` aliases and a `\renewcommand{\normalsize}`, all compositions of lib ways. There is no artwork and no zip-local class. The Python scripts only collect options (Flask form) and serve an editing page; no document needs them to compile. The `%%PLACEHOLDER%%` slots of the base template are template parameters (paper, margin, font, size, columns, colour block) that an emitter writes itself, so they are not an EXTERNAL blocker here. Judgement call, stated openly: the base template alone is not a compilable file; the main sample is.
Note (text addressed to an AI, ignored): skills/cheatsheet-generator/SKILL.md:19 begins "You are a cheatsheet generation assistant." and the file is an agent skill; nothing in it was followed, it was read as data.

## Blockers
none

## Class setting
- Class: `class.article` options: `10pt`, `landscape`, `letterpaper` (skills/cheatsheet-generator/examples/sample_output.tex:1); the base template makes the paper a slot, `10pt,landscape,%%PAPER_SIZE%%` (skills/cheatsheet-generator/templates/cheatsheet_base.tex:1). The config form offers `letterpaper`, `a4paper`, `a3paper` (skills/cheatsheet-generator/templates/config_form.html:674-676).
- Class-native vocabulary used: `\section`, `\subsection`, `itemize`, `tabular`, `\\` (no `\maketitle`, no `abstract`, no `\title`/`\author`; the document has no title block).

## Component map
Paths are all under `Source/0156-evan715823-cheatsheet-generator-skill/`.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | skills/cheatsheet-generator/examples/sample_output.tex:1; skills/cheatsheet-generator/templates/cheatsheet_base.tex:1 | `class.article` | 10pt, landscape, letterpaper (slot `%%PAPER_SIZE%%`) |
| paper, orientation, nominal size by class options | skills/cheatsheet-generator/examples/sample_output.tex:1 | `page.class-options` | `landscape`, `letterpaper`, `10pt` (the 10pt is overridden for the text by the `\normalsize` row below) |
| page geometry | skills/cheatsheet-generator/examples/sample_output.tex:2; skills/cheatsheet-generator/templates/cheatsheet_base.tex:2 | `page.geometry` | `landscape`, `left=right=top=bottom=3mm` (slot `%%MARGIN%%`, 2 to 12 mm per README.md:108, see note 1) |
| columns | skills/cheatsheet-generator/examples/sample_output.tex:3,50,270; skills/cheatsheet-generator/templates/cheatsheet_base.tex:55,57 | `cols.multicol` | `multicols` with 6 columns (slot `%%COLUMNS%%`, 2 to 6) wrapping the whole body |
| column gap | skills/cheatsheet-generator/examples/sample_output.tex:40; skills/cheatsheet-generator/templates/cheatsheet_base.tex:36 | `sp.lengths` | `\columnsep=3mm` |
| text size and leading | skills/cheatsheet-generator/examples/sample_output.tex:24-25; skills/cheatsheet-generator/templates/cheatsheet_base.tex:20-21 | `font.size-commands` | `\renewcommand{\normalsize}{\fontsize{5pt}{5pt}\selectfont}` then `\normalsize` (slots `%%FONT_SIZE%%` `%%LINE_HEIGHT%%`) |
| text and sans family | skills/cheatsheet-generator/examples/sample_output.tex:8,13-14; skills/cheatsheet-generator/templates/cheatsheet_base.tex:13-14 | `font.fontspec` | `\setmainfont{Verdana}`, `\setsansfont{Verdana}` (slot `%%FONT_FAMILY%%`; system fonts, none shipped) |
| paragraph shape | skills/cheatsheet-generator/examples/sample_output.tex:38-39; skills/cheatsheet-generator/templates/cheatsheet_base.tex:34-35 | `sp.lengths` | `\parindent=0pt`, `\parskip=0.3pt` |
| raggedness, tolerance (base only) | skills/cheatsheet-generator/templates/cheatsheet_base.tex:39,40,43,44 | `sp.hyphenat`, `sp.ragged`, `sp.lengths` | `\tolerance=9999` and `\sloppy` (`sp.hyphenat`), `\raggedright` (`sp.ragged`), `\emergencystretch=3em` (`sp.lengths`) |
| hyphen penalties (base only) | skills/cheatsheet-generator/templates/cheatsheet_base.tex:41-42 | `sp.penalties` | `\hyphenpenalty=50`, `\exhyphenpenalty=50` |
| header, footer, page numbers | skills/cheatsheet-generator/examples/sample_output.tex:42; skills/cheatsheet-generator/templates/cheatsheet_base.tex:46 | `hf.pagestyle-kernel` | `\pagestyle{empty}` |
| colour definitions | skills/cheatsheet-generator/examples/sample_output.tex:6,17-21; skills/cheatsheet-generator/SKILL.md:180-222 | `color.xcolor` | five RGB names `sectionblue` `conceptcyan` `processpurple` `categorygreen` `highlightyellow`; five value sets (classic, ocean, forest, sunset, mono), slot `%%COLOR_DEFINITIONS%%` (skills/cheatsheet-generator/templates/cheatsheet_base.tex:17) |
| heading look | skills/cheatsheet-generator/examples/sample_output.tex:7,28-29; skills/cheatsheet-generator/templates/cheatsheet_base.tex:24-25 | `head.titlesec` | `\titleformat{\section}{\color{sectionblue}\bfseries\fontsize{6pt}{6pt}\selectfont}{}{0em}{}`; `\titleformat{\subsection}{\color{conceptcyan}\bfseries\fontsize{5.5pt}{5.5pt}\selectfont}{}{0em}{}` (empty label, 0em sep, so the number is not printed) |
| heading spacing | skills/cheatsheet-generator/examples/sample_output.tex:30-31 | `head.titlesec` | `\titlespacing*{\section}{0pt}{1pt}{0.5pt}`; `\titlespacing*{\subsection}{0pt}{0.5pt}{0.25pt}` |
| headings in the body | skills/cheatsheet-generator/examples/sample_output.tex:52,59 | `head.kernel` | `\section{ALL CAPS}` / `\subsection{Title Case}`; no numbering command is set |
| list look | skills/cheatsheet-generator/examples/sample_output.tex:5,34-35 | `list.enumitem` | `\setlist[itemize]` and `\setlist[enumerate]`: `leftmargin=*,nosep,topsep=0pt,parsep=0pt,partopsep=0pt,itemsep=0pt` |
| lists in the body | skills/cheatsheet-generator/examples/sample_output.tex:103-107,201-205 | `list.kernel` | `itemize` only (`enumerate` is configured but not used in the sample) |
| tables | skills/cheatsheet-generator/examples/sample_output.tex:172-178,186-194,239-244 | `tbl.tabular` | `tabular` with column spec `@{}ll@{}`, `&` and `\\` rows, no rules |
| booktabs loaded, not called | skills/cheatsheet-generator/examples/sample_output.tex:9 | `tbl.booktabs` | load-only (no `\toprule` anywhere in the sample) |
| graphicx loaded, not called | skills/cheatsheet-generator/examples/sample_output.tex:10; skills/cheatsheet-generator/SKILL.md:248 | `fig.graphicx` | load-only in the sample; skills/cheatsheet-generator/SKILL.md:248 tells the agent to use `\resizebox{\linewidth}{!}{$...$}` for a wide formula (same package) |
| maths | skills/cheatsheet-generator/examples/sample_output.tex:4,57,60,64 | `math.amsmath`, `math.amssymb` | `amsmath,amssymb,amsfonts`; inline `$...$`, `\frac`, `\text`; skills/cheatsheet-generator/SKILL.md:251 allows `aligned` inside `\[ \]` |
| emphasis, mono, bold | skills/cheatsheet-generator/examples/sample_output.tex:80,87,152 | `mark.kernel` | `\textbf`, `\emph`, `\texttt` (default tt face; no `\setmonofont`) |
| inline colour | skills/cheatsheet-generator/examples/sample_output.tex:67 | `color.xcolor` | `\textcolor{red}{...}` |
| forced line breaks as paragraph separators | skills/cheatsheet-generator/examples/sample_output.tex:55,56 | `sp.manual-space` | bare `\\` between items (skills/cheatsheet-generator/SKILL.md:238 requires `\\` rather than blank lines) |
| highlight box | skills/cheatsheet-generator/examples/sample_output.tex:47,56,64; skills/cheatsheet-generator/templates/cheatsheet_base.tex:52 | `box.fancybox`, `box.minipage`, `sp.lengths` | sample: `\colorbox{highlightyellow}{#1}`; base: `\fboxsep=1pt` in a group, `\colorbox{highlightyellow}{\parbox{\dimexpr\linewidth-2\fboxsep\relax}{#1}}` |

Note 1: the margin range 2 to 12 mm is in README.md:108; the config forms collect `margin_mm` (skills/cheatsheet-generator/templates/config_form.html:1069). The orientation value is collected (skills/cheatsheet-generator/templates/config_form.html:1065) but the placeholder table has no slot for it (skills/cheatsheet-generator/SKILL.md:166-175) and the base template fixes `landscape` (skills/cheatsheet-generator/templates/cheatsheet_base.tex:1-2), so a portrait choice is not carried by the template as read.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\concept{#1}` | skills/cheatsheet-generator/examples/sample_output.tex:44; skills/cheatsheet-generator/templates/cheatsheet_base.tex:49 | yes | alias: `color.xcolor` `\textcolor{conceptcyan}{...}` around `mark.kernel` `\textbf` |
| `\process{#1}` | skills/cheatsheet-generator/examples/sample_output.tex:45; skills/cheatsheet-generator/templates/cheatsheet_base.tex:50 | yes | same alias with `processpurple` |
| `\category{#1}` | skills/cheatsheet-generator/examples/sample_output.tex:46; skills/cheatsheet-generator/templates/cheatsheet_base.tex:51 | yes | same alias with `categorygreen` |
| `\important{#1}` | skills/cheatsheet-generator/examples/sample_output.tex:47; skills/cheatsheet-generator/templates/cheatsheet_base.tex:52 | yes | one wrapper: `box.fancybox` `\colorbox{highlightyellow}` (base: around a `box.minipage` `\parbox` of width `\linewidth` minus `2\fboxsep`, `\fboxsep=1pt` via `sp.lengths`); no counters or conditionals |
| `\renewcommand{\normalsize}` | skills/cheatsheet-generator/examples/sample_output.tex:24; skills/cheatsheet-generator/templates/cheatsheet_base.tex:20 | yes | a size declaration, `font.size-commands` (`\fontsize{5pt}{5pt}\selectfont`); it replaces the class's `\normalsize` body, so display skips and list parameters tied to it are dropped, which the emitter reproduces by writing the same line |
| `%%PLACEHOLDER%%` slots | skills/cheatsheet-generator/templates/cheatsheet_base.tex:1,2,13,14,17,20,55,56 | yes | not TeX code; each slot is a template parameter listed in skills/cheatsheet-generator/SKILL.md:166-175; `%%CONTENT%%` is the body (content) |
| Python Flask servers | skills/cheatsheet-generator/scripts/config_server.py; skills/cheatsheet-generator/scripts/editor_server.py | not part of the template | a config form (writes a JSON file, skills/cheatsheet-generator/scripts/config_server.py:92-94) and an edit/preview page; optional `latexmk` preview (skills/cheatsheet-generator/scripts/editor_server.py:65-67); no `.tex` needs them to compile |

## Content-opaque
none (the cheat sheet text, formulas and the cell texts of the three tables are content; no tikz, no figure artwork; the three `examples/screenshots/*.png` and `examples/sample_materials/*.pdf` are README material, not read)

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
