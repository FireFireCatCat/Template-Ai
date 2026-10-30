yes

# 0678-tj-csccg-tongji-recommendation-template: Tongji University recommendation letter (class Tongjiletter)

- Unverified: read from the source, not compiled.
- Source: Source/0678-tj-csccg-tongji-recommendation-template/ (origin: https://codeload.github.com/TJ-CSCCG/tongji-recommendation-template/zip/refs/heads/master; licence: LPPL-1.3c, README.md:35-54)
- Kind: letter
- Lib: v5
- Engine: needs XeLaTeX or LuaLaTeX (`fontspec` and `\setmainfont{Source Serif Pro}`, main.tex:8,22; the repo builds with LuaLaTeX, Makefile:2, README.md:21)
- Look carried by: mixed (zip-local class: page lengths, first-page letterhead, `\opening`, `\closing`; sample preamble: font, colour, running head and foot, logo watermark, right-hand address block, signature)
- Class origin: zip-local (`Tongjiletter.cls` is a GitHub class derived from `brownletter.cls`, Tongjiletter.cls:3; ctan.org/pkg/tongjiletter is a 404; not a publisher kit; it loads the published kernel class `letter`)
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles all (`Tongjiletter.cls`, 126 lines; no other .sty .def .cfg .clo present)

## Verdict
The zip is one 12pt letter on the kernel `letter` class plus a small zip-local class. The class has no output routine, no `\halign`, no expl3 or Lua and no layout computation: it sets page lengths, defines one first-page head, and redefines `\opening` and `\closing` with spacing, `\raggedright` and `varwidth`. All of it reduces by inlining to lib ways with parameters (reductions below). The sample's two TikZ pieces draw nothing: one is an image centred on the page at 10 percent opacity (a watermark), the other is a text block at a fixed fraction of the page; both reduce to published ways, so there is no `ART`. One new way is proposed (`varwidth`). Residual risk: the `\opening` reduction relies on `letter` internals (`\toname`, `\toaddress`, `\@date`), which an emitter would print as plain text.

## Blockers
none

## Class setting
- Class: `class.letter` options: `12pt` (main.tex:7, forwarded by `\DeclareOption*{\PassOptionsToClass{\CurrentOption}{letter}}`, Tongjiletter.cls:29-30), `letterpaper` (fixed, Tongjiletter.cls:31). The zip-local `Tongjiletter` is bespoke code on top of it (reducible, see Bespoke code).
- Class-native vocabulary used: `letter` environment with recipient argument (main.tex:124-128, 150), `\opening` (main.tex:134), `\closing` (main.tex:141), `\signature` (main.tex:99-102), `\address{}` set empty (main.tex:105), `\date` and `\today` (main.tex:117). Not used (commented): `\encl`, `\ps`, `\cc` (main.tex:144-148), zip-local `\subject` (main.tex:120).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:7; Tongjiletter.cls:29-31 | `class.letter` | 12pt, letterpaper |
| paper and size | main.tex:7; Tongjiletter.cls:31 | `page.class-options` | letterpaper, 12pt |
| page geometry | Tongjiletter.cls:42-48 | `page.setlength` | textwidth=6.875in, textheight=7.0in, topskip=0in (vertical glue, filed with the page lengths), footskip=1.0in, oddsidemargin=evensidemargin=-0.25in, topmargin=-0.875in |
| first-page page style | Tongjiletter.cls:74-81, 94 | `hf.pagestyle-kernel` (as written: `\renewcommand{\ps@firstpage}`, `\thispagestyle{firstpage}`); reduction `hf.fancyhdr` | headheight=1.375in, headsep=1.0in, odd head = the head box, odd foot = `\departmentfoot` (never filled, so empty), even head and foot empty; reduction: `\fancypagestyle{firstpage}{\fancyhf{}, headrulewidth=0pt, footrulewidth=0pt, \fancyhead[L]{<head box>}}` |
| first-page head box (logo) | Tongjiletter.cls:58-68 | `tbl.tabular`, `box.minipage`, `fig.graphicx`, `sp.manual-space`, `sp.ragged` | `tabular*` of width `\textwidth`, columns `@{}l@{\extracolsep{0.0in}}\|@{\extracolsep{0.125in}}l@{}` (a vertical rule between the cells); cell 1 `\parbox{4.0in}{\raggedright \vspace{0.3in}\includegraphics[height=1.1in]{Tongji.pdf}}`; cell 2 `\parbox[t][1in][t]{2in}{{~}\\}` |
| later-page running head | main.tex:14,25-29 | `hf.fancyhdr` | `\pagestyle{fancy}`, `\fancyhf{}`, headrulewidth=0pt, footrulewidth=0pt, `\rhead{Page \thepage \hspace{1pt} of \pageref{LastPage}}` |
| page X of Y | main.tex:15,29 | `pgnum.lastpage`, `xref.kernel` | `lastpage`, `\pageref{LastPage}`; `\hspace{1pt}` is `sp.manual-space` |
| running foot | main.tex:87-94 | `hf.fancyhdr`, `font.size-commands` | `\cfoot{\school}`, `\school` = `\small` plus a text line with `$\cdot$` separators (content) |
| class `empty` style (overridden by `fancy`, main.tex:25) | Tongjiletter.cls:56,70-72,83-92 | `hf.pagestyle-kernel`, `font.nfss`, `sp.manual-space` | headheight=1.375in, headsep=0.5in, odd and even foot = a `\textwidth` box of `\hspace*{\textwidth}` in the 9pt fixed font; `\pagestyle{empty}` default |
| text font | main.tex:8,22 | `font.fontspec` | `\setmainfont{Source Serif Pro}` (font not shipped) |
| fixed fonts | Tongjiletter.cls:50-52 | `font.nfss` | `\DeclareFixedFont` OT1 cmr: `\xcmrbn` b n 10, `\xcmrmn` m n 10, `\ixcmrmn` m n 9 (only `\ixcmrmn` is used, line 70) |
| colour | main.tex:10-11; Tongjiletter.cls:24-25 | `color.xcolor` | `tongjiblue` rgb 0,0.372,0.643; class `slcolor` HTML 882B21 (defined, never used) |
| coloured labels | main.tex:69,80,82,84 | `mark.kernel`, `color.xcolor` | `\textbf{\color{tongjiblue}...}` |
| language | main.tex:12 | `lang.babel` | option `english` |
| logo watermark | main.tex:17,31-40,137 | `bg.eso-pic`, `fig.graphicx`, `color.transparent` (reduction; as written a TikZ node, see Bespoke code) | `\AddToShipoutPictureBG`, content `\includegraphics[width=0.55\textwidth]{logo.pdf}` centred on the page, opacity 0.1 |
| right-hand address block | main.tex:43-58,107-114,130-132 | `pg.textpos` (reduction; as written a TikZ node), `font.size-commands`, `sp.manual-space`, `mark.kernel` | `textblock*` width 7cm, reference point [0.5,0.5] at (0.75`\paperwidth`, 0.135`\paperheight` from the top), derived from `page cs:0.5,0.73` and the formula at main.tex:53-56; `\small`; lines separated by `\\` |
| date | main.tex:117 | `ltr.opening`, `sp.manual-space` | `\date{\vspace{10mm} \today}` |
| recipient and letter body | main.tex:124-128,139 | `ltr.opening`, `draft.todo` | `\begin{letter}{<3 address lines>}`; `\lipsum[1-6]` filler (main.tex:13) |
| opening | Tongjiletter.cls:94-112; main.tex:134 | `ltr.opening`, `hf.pagestyle-kernel`, `sp.manual-space`, `sp.ragged`, `pg.break` | `\thispagestyle{firstpage}`; `\vspace{-6\parskip}`, date, `\vspace{2\parskip}`; `{\raggedright \toname \\ \toaddress \par}`; `\vspace{1\parskip}`; subject line if set; `\vspace{1\parskip}`; salutation then `\par\nobreak` |
| signature | main.tex:99-102 | `ltr.opening`, `fig.graphicx`, `sp.manual-space` | `\signature{\vspace{-12mm}\includegraphics[scale=0.40]{signature_block.pdf}\\\vspace{-2mm}\name}` |
| closing | Tongjiletter.cls:114-126; main.tex:141 | `ltr.opening`, `box.minipage`, `sp.ragged`, `sp.manual-space`, `pg.break` | `\par\nobreak\vspace{\parskip}`, `\stopbreaks`, `\noindent\hfill\begin{varwidth}{\textwidth}\raggedright`, closing phrase, `\\[4\medskipamount]`, signature (`\fromsig`) or `\fromname`, `\strut` |
| image defaults | Tongjiletter.cls:21,27 | `fig.graphicx` | `\DeclareGraphicsExtensions{.png}` (the sample names `.pdf` files with the extension) |
| EPS conversion | Tongjiletter.cls:22 | `fig.epstopdf` | load-only; no EPS file is included in the sample, so not EXTERNAL here (the lib line makes it EXTERNAL only when an EPS is included) |
| headings, lists, theorems, floats, tables, captions, code, bibliography, index, contents | none | none | not used by the sample |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| class `Tongjiletter` | Tongjiletter.cls:18-31 | yes | `\documentclass[12pt,letterpaper]{letter}` plus the rows below as preamble |
| `\subject`, `\subjectname`, `\@subject` | Tongjiletter.cls:33-35,109 | yes | unused in the sample (main.tex:120 is a comment); a literal paragraph "Subject: text" in the body |
| `logofound` boolean with `\IfFileExists` and `\ifthenelse` | Tongjiletter.cls:37-40,61-64 | yes | a guard for a missing asset; constant-fold to the `\includegraphics` branch because `Tongji.pdf` ships in the zip |
| `\departmenthead` savebox | Tongjiletter.cls:54,58-68 | yes | inline the tabular into `\fancyhead[L]` (row "first-page head box") |
| `\departmentfoot` savebox | Tongjiletter.cls:55,78 | yes | declared and used but never filled, so a void box: empty foot (read-only inference: `\opening` selects `firstpage`, line 94, so the `\cfoot{\school}` of main.tex:94 shows on later pages only) |
| build files `Makefile`, `.latexmkrc`, `.vscode/settings.json` | Makefile:2; .vscode/settings.json:24 | yes | build wrappers (`latexmk -lualatex -shell-escape`); they generate no `.tex` and no loaded package needs the shell (no `minted`), so no EXTERNAL |
| `\emptyfoot` savebox | Tongjiletter.cls:56,70-72 | yes | a `\textwidth` wide `\hspace*` in a 9pt fixed font; empty foot |
| `\ps@firstpage` redefinition | Tongjiletter.cls:74-81 | yes | `\fancypagestyle{firstpage}` (row "first-page page style") |
| `\ps@empty` redefinition and `\pagestyle{empty}` | Tongjiletter.cls:83-92 | yes | an empty foot style; replaced by `fancy` in the sample (main.tex:25) |
| `\opening` redefinition | Tongjiletter.cls:94-112 | yes | straight-line spacing, `\raggedright`, `\thispagestyle`; its two conditionals test whether a string is empty (the `\fromaddress` branch is not taken because `\address{}` is empty, main.tex:105; `\\ *[1\parskip]` at line 100 is in that dead branch), so each folds to one branch per document; the emitter prints recipient, date and salutation as text |
| `\closing` redefinition | Tongjiletter.cls:116-126 | yes | right-aligned `varwidth` block (`box.minipage`) with the kernel's own `\stopbreaks` and `\strut`; the `\fromsig` test folds because `\signature` is set |
| fixed fonts `\xcmrbn` `\xcmrmn` `\ixcmrmn` | Tongjiletter.cls:50-52 | yes | `\DeclareFixedFont` is kernel NFSS (`font.nfss`); the first two are never used |
| colour `slcolor` | Tongjiletter.cls:25 | yes | unused; drop or keep as `\definecolor` |
| `\watermark[3]` | main.tex:31-40, called at 137 | yes | the three arguments are never used; as written a `\parbox` the size of the page holding a `tikzpicture` with `\node[opacity=.1]` at `current page.center` that holds the logo (no shapes are drawn); reduces to `\AddToShipoutPictureBG{\AtPageCenter{\transparent{0.1}\includegraphics[width=0.55\textwidth]{logo.pdf}}}` (`bg.eso-pic`, `color.transparent`, `fig.graphicx`) |
| TikZ `page` coordinate system, `\parsecomma` | main.tex:43-58 | yes | used once (main.tex:131); evaluates to x = 0.75 page width, y = 0.865 page height from the bottom; replaced by constants in `pg.textpos` |
| address node | main.tex:130-132 | yes | `\node[text width=7cm]` holding text only: `\begin{textblock*}{7cm}[0.5,0.5](0.75\paperwidth,0.135\paperheight)` (`pg.textpos`; the starred `\AddToShipoutPicture*` of `bg.eso-pic` is the alternative) |
| text macros `\name` `\Where` `\Address` `\CityZip` `\TEL` `\Email` `\URL` `\school` `\newaddress` | main.tex:61-92,107-114 | yes | `\def` aliases of text and `\textbf{\color{tongjiblue}..}`; inline expansion. `\name` (main.tex:61) replaces the `letter` command `\name`, so the closing uses `\fromsig` |

## Content-opaque
none (the logo, watermark and signature are PDF image assets held by `fig.graphicx`; `Tongji.pdf`, `logo.pdf` and `signature_block.pdf` ship in the zip, the font Source Serif Pro does not)

## Lib changes
- New ways proposed: `box.minipage` `varwidth` (CTAN, LPPL 1.3, Donald Arseneau; read at ctan.org/pkg/varwidth), pdf: `\begin{varwidth}{maxwidth}` (optional position, height and inner-position arguments) is a minipage whose width is an upper limit and shrinks to its content. W1 published on CTAN; W2 chosen by one length and the usual box arguments; W3 serves any block that must hug its content (a closing block, a signature, an address); W4 an environment wrapper around node content. Not `box.minipage` (fixed width, `minipage`/`\parbox`); the consolidator may widen that line instead, as the package would be the parameter.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
