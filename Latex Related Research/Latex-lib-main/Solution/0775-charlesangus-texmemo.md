yes

# 0775-charlesangus-texmemo: texMemo (a business memo class over scrartcl)

- Unverified: read from the source, not compiled.
- Source: Source/0775-charlesangus-texmemo/ (origin: https://codeload.github.com/charlesangus/texMemo/zip/refs/heads/master; licence: LGPL-3.0 per the manifest; `LICENSE:1-2` is the GNU LGPL version 3 text and `texMemo.cls:5` says LGPL version 3)
- Kind: letter
- Lib: v6
- Engine: pdfLaTeX-compatible
- Look carried by: zip-local (`texMemo.cls` sets margins, paragraph spacing, fonts and the whole memo title block over `scrartcl`; `header.tex` only supplies field values and `secnumdepth`; `main.tex` adds an optional draft branch)
- Class origin: zip-local
- Main file: main.tex (other samples: none; it `\input`s `header.tex` and `body.tex`, `main.tex:3,15`)
- Read: main yes, zip-local classes and styles all (`texMemo.cls` 88 lines, `header.tex`, `body.tex`, `README.md` read in full; `texMemo_example.pdf` not read, the viewer is not installed)

## Verdict
Yes. The only bespoke code is `texMemo.cls` (88 lines). It is `\LoadClassWithOptions{scrartcl}` plus `geometry`, `\KOMAoptions`, `\addtokomafont`, `fontenc`, one list-label `\renewcommand`, and a hand-built title block made of two minipages, a `description` list, an `\includegraphics` and a `\rule`. The block, the `\def`/`\newcommand` field setters and the `\ifthenelse` presence tests reduce by inline expansion to lib ways, because an emitter knows which fields are set. No kernel internals (`\@maketitle`, `\@startsection`) are touched, there is no output routine, no expl3 or Lua, no hand-rolled counter, no tool outside TeX and no artwork (the logo is an included `logo.png`, a shipped asset). The closest call is the `\ifthenelse` tests (`texMemo.cls:56-59,65`, `main.tex:5`): they test only whether a field or flag is set, not a computed layout, so they resolve at emission time. `ctan.org/pkg/texmemo` is a 404 (read once), so `texMemo` is zip-local; the base class `scrartcl` ships with KOMA-Script.

Two oddities in the source; neither changes the answer, because every reading uses only lib ways:
- `main.tex:5` writes `\@memodraft` in the main file, and Grep finds no `\makeatletter` in the zip. In a `.tex` body `\@` is the kernel command `\@` followed by the letters `memodraft`, so the test probably never sees the class macro, and the `\ifthenelse` else branch (Palatino plus DRAFT watermark, `main.tex:6-9`) may run whatever `header.tex:8` says. The intent is flag off (`header.tex:8` is commented out). Not compiled, so unconfirmed; both branches are recorded below.
- `\includegraphics` (`header.tex:5`) is called, but no file in the zip loads `graphicx` (Grep: only `ifthen`, `geometry`, `fontenc`, `palatino`, `draftwatermark` are loaded, `texMemo.cls:16,20,77`, `main.tex:6-7`). `draftwatermark` may load it (its source was not read). The emitter loads `graphicx` explicitly.

## Blockers
none

## Class setting
- Class: `class.scrartcl` options: `paper=letter` (given at `main.tex:1`, forwarded to the base class by `\LoadClassWithOptions{scrartcl}` at `texMemo.cls:13`), then `parskip=half` through `\KOMAoptions` (`texMemo.cls:75`). The zip-local wrapper `texMemo` is not a way: it reduces to `\documentclass[paper=letter]{scrartcl}` plus the rows below.
- Class-native vocabulary used: `\KOMAoptions{parskip=half}` (`texMemo.cls:75`); `\addtokomafont{disposition}` and `\addtokomafont{descriptionlabel}` (`texMemo.cls:80-81`); `\section` `\subsection` `\subsubsection` `\paragraph` (`body.tex:3,9,13,17`). No `\title` `\author` `\date` `\maketitle` data and no abstract: the sample uses the zip's own `\memo*` fields instead, and `\maketitle` is renewed (`texMemo.cls:50`).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1; texMemo.cls:13 | `class.scrartcl` | paper=letter; `\LoadClassWithOptions` forwards the options |
| paper size | main.tex:1 | `page.class-options` | `paper=letter` (KOMA key form of the paper option) |
| page margins | texMemo.cls:20-21 | `page.geometry` | `\geometry{margin=1.0in}` (the `TODO` at :19 about A4 is a comment only) |
| paragraph spacing | texMemo.cls:74-75 | `class.scrartcl` | `\KOMAoptions{parskip=half}`: no indent, half-line gap (a class option set after load; not the `parskip` package) |
| font encoding and face | texMemo.cls:77, 79 | `font.fontenc-t1` | `\usepackage[T1]{fontenc}`; no text-face package (comment :79 says all Computer Roman) |
| heading font family | texMemo.cls:80 | `head.koma-fonts` | `\addtokomafont{disposition}{\rmfamily}` (headings turn from KOMA sans to roman) |
| description label font | texMemo.cls:81 | `head.koma-fonts` | same command, element `descriptionlabel`, `\rmfamily` (the way's command, a non-heading element) |
| heading levels | body.tex:3,9,13,17 | `head.class-native` | `\section` to `\paragraph` at scrartcl defaults, font from the two rows above |
| heading numbering | header.tex:11 | `num.secnumdepth` | `\setcounter{secnumdepth}{0}` (no numbers) |
| title block, left box | texMemo.cls:53, 61 | `cols.minipage` | `minipage[b][][b]{0.7\textwidth}`; `%` at :61 stops the gap before the right box |
| title block, To/From/Subject/Date list | texMemo.cls:54-60 | `list.kernel` | `description`; labels `To:` `From:` `Subject:` `Date:` are fixed strings; an item exists only if its field is set |
| item spacing in the block | texMemo.cls:55 | `sp.lengths` | `\itemsep=0pt` |
| title block, right box | texMemo.cls:62-70 | `cols.minipage` | `minipage[b][][b]{0.3\textwidth}` |
| logo alignment | texMemo.cls:64-68 | `sp.ragged` | `flushright` environment |
| logo image | header.tex:5; texMemo.cls:65-67 | `fig.graphicx` | `\includegraphics[height=8\baselineskip]{logo.png}` (needs `\usepackage{graphicx}`, see Verdict) |
| rule under the block | texMemo.cls:44-47, 71 | `sp.rule` | `\par\noindent\rule[0.5ex]{\linewidth}{1pt}\par` (`\decorativeline` default 1pt) |
| space after the block | texMemo.cls:71 | `sp.manual-space` | `\bigskip` |
| title block call | main.tex:13; texMemo.cls:50 | (rows above) | `\maketitle` is renewed to `\makememotitle`; the emitter writes the block rows directly in the body |
| field values | header.tex:1-4 | content | To, From, Subject strings; Date is kernel `\today` (no `datetime` package) |
| second-level bullet | texMemo.cls:84 | `list.kernel` | `\renewcommand\labelitemii{$\circ$}` (the sample body has no list) |
| tight lists (Pandoc helper) | texMemo.cls:87-88 | `sp.lengths` | `\itemsep` 0pt, `\parskip` 0pt, only when `\tightlist` is called (the sample never calls it) |
| file inclusion | main.tex:3, 15 | `struct.input` | `\input{header.tex}`, `\input{body.tex}` |
| draft text face (optional branch) | main.tex:6 | `font.palatino` | `\RequirePackage{palatino}`; guarded by the draft test (:5), see Verdict |
| draft watermark (optional branch) | main.tex:7-9 | `bg.watermark` | `draftwatermark`, `\SetWatermarkText{DRAFT}`, `\SetWatermarkLightness{.95}`; same branch |
| body text | body.tex:1-19 | content | lorem ipsum under the four heading levels; no lists, floats, tables, maths, notes or bibliography |
| header/footer | none set | (class default) | no `\pagestyle` or running head in the zip; scrartcl default |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| zip-local class `texMemo` | texMemo.cls:1-88 | yes | `\documentclass[paper=letter]{scrartcl}` + `geometry` margin=1.0in + `\KOMAoptions{parskip=half}` + `fontenc` T1 + two `\addtokomafont` + `\labelitemii` + the title block |
| field setters `\memoto` `\memofrom` `\memosubject` `\memodate` `\memologo` `\memodraft`, with `\def\@memo..{\relax}` defaults | texMemo.cls:25-41 | yes | stored strings only; the emitter writes each value straight into the block (`\memologo` stores `\protect #1`, i.e. the `\includegraphics` call) |
| `\decorativeline[1pt]` | texMemo.cls:44-47 | yes | inline `\par\noindent\rule[0.5ex]{\linewidth}{1pt}\par` (`sp.rule`) |
| `\renewcommand{\maketitle}{\makememotitle}` and `\makememotitle` | texMemo.cls:50-72 | yes | body wrapper: two `cols.minipage` boxes, a `description` list, `\includegraphics`, `\rule`, `\bigskip`; no kernel internals touched |
| `\ifthenelse{\equal{..}{\relax}}` presence tests (`ifthen` loaded at :16) | texMemo.cls:56-59, 65; main.tex:5 | yes | evaluated at emission: an item is written only for a set field, the two draft lines only when the flag is on; no computed layout depends on them (`ifthen` is a macro helper with no component, as the v4 ruling on `sp.xspace`) |
| `\providecommand{\tightlist}` | texMemo.cls:87-88 | yes | `sp.lengths` itemsep=0pt, parskip=0pt, only if used; the comment (:86) names Pandoc but the zip runs none (not EXTERNAL) |

## Content-opaque
none (`logo.png` is a shipped raster image included with `\includegraphics`; missing-asset note: ship it)

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
