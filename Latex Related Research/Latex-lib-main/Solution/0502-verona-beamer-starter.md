no

# 0502-verona-beamer-starter: Verona Beamer Starter

- Unverified: read from the source, not compiled.
- Source: Source/0502-verona-beamer-starter/ (origin: https://latextemplates.com/downloads/verona-beamer-starter.zip; licence: LPPL-1.3)
- Kind: presentation
- Lib: v4
- Engine: pdfLaTeX-compatible (T1, lmodern, beamer, tikz; several runs are needed for the ToC, `\inserttotalframenumber` and `remember picture`, all plain TeX, no external tool)
- Look carried by: preamble (published `beamer` with its default theme; the palette, frame title and footline are set in the sample's preamble at main.tex:3-6; the cover artwork is drawn in the body at main.tex:9)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
No. Everything except one construct maps to existing ways: `class.beamer`, `slide.beamer-template` for the colours, frame title and footline, and kernel and `amsmath` ways for the body. The blocker is the title slide, whose background is a full-page `tikzpicture` with `remember picture,overlay` that fills the page green and adds a coral diagonal triangle (main.tex:9). That is the template's cover identity, not figure content, and a triangle anchored on `current page` has no declarative lib way (`bg.tikzpagenodes` is ART when it draws identity). Only the green fill alone could be reduced, to a local `background canvas` colour, and that does not recover the shape.

## Blockers
- `ART/body` title-slide background: full-page green `\fill` and coral triangle `\fill` in a `tikzpicture[remember picture,overlay]` on `current page` nodes, inside `\begin{frame}[plain]` (main.tex:9)

## Class setting
- Class: `class.beamer` options: `aspectratio=169`, `10pt` (main.tex:1); no `\usetheme`, `\usecolortheme` or `\usefonttheme` anywhere, so beamer's default theme is kept (main.tex:1-14)
- Class-native vocabulary used: `frame` environment with a title argument (main.tex:10-13) and the `[plain]` frame option (main.tex:9); `\section` feeding the ToC and `\insertsection` (main.tex:6,11-13); `alertblock` with a title argument (main.tex:12); `\title` `\subtitle` `\author` `\institute` `\date` (main.tex:7); insert macros `\inserttitle` `\insertsubtitle` `\insertauthor` `\insertinstitute` `\insertdate` (main.tex:9), `\insertframetitle` (main.tex:5), `\insertsection` `\insertframenumber` `\inserttotalframenumber` (main.tex:6); `\setbeamercolor` and `\setbeamertemplate` (main.tex:4-6)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.beamer` | aspectratio=169, 10pt |
| page size and base size | main.tex:1 | `page.class-options` | aspectratio=169 (16:9 slide), 10pt, set as class options |
| font encoding and text symbols | main.tex:2, 9 | `font.fontenc-t1` | `\usepackage[T1]{fontenc}`; `\textbullet` between author and institute on the title slide |
| text font | main.tex:2 | `font.lmodern` | `\usepackage{lmodern}` |
| font sizes | main.tex:9, 11 | `font.size-commands` | `\Huge` (title), `\Large` (subtitle), `\normalsize` (author line), `\large` (quote) |
| bold title | main.tex:9 | `mark.kernel` | `\bfseries` |
| colour definitions | main.tex:3 | `color.xcolor` | `\definecolor` HTML model: veronagreen 006B5B, veronacoral E76F51, veronacream F7F3E8 |
| text colour on title slide | main.tex:9 | `color.xcolor` | `\color{white}` |
| page background and text colour | main.tex:4 | `slide.beamer-template` | `\setbeamercolor{normal text}{fg=black!80,bg=veronacream}` (cream slide background and 80 percent black text) |
| structure colour | main.tex:4 | `slide.beamer-template` | `\setbeamercolor{structure}{fg=veronagreen}` (list bullets, ToC, section entries) |
| frame title colour | main.tex:4 | `slide.beamer-template` | `\setbeamercolor{frametitle}{fg=veronagreen,bg=veronacream}` |
| navigation symbols off | main.tex:5 | `slide.beamer-template` | `\setbeamertemplate{navigation symbols}{}` |
| frame title template | main.tex:5 | `slide.beamer-template` | `\setbeamertemplate{frametitle}{...}`: `\insertframetitle` between two inset blocks; body also uses `sp.manual-space` and `sp.rule` and `color.xcolor` (below) |
| frame title spacing and indent | main.tex:5 | `sp.manual-space` | `\vspace{0.18cm}`, `\hspace{0.35cm}`, `\vspace{0.08cm}`, `\hspace{0.35cm}` |
| frame title underline | main.tex:5 | `sp.rule` | `\rule{0.18\paperwidth}{1.4pt}` coloured `\textcolor{veronacoral}` (`color.xcolor`) |
| footer | main.tex:6 | `slide.beamer-template` | `\setbeamertemplate{footline}{...}`: section name left, `frame / total` right; body uses `sp.manual-space` (`\hspace{0.35cm}`, `\hfill`, `\,`, `\vskip0.18cm`); the total needs a second run |
| front-matter fields | main.tex:7 | `front.class-native` | `\title{A Small Guide to Reliable Experiments}`, `\subtitle`, `\author`, `\institute`, `\date{\today}` |
| title slide layout (text) | main.tex:9 | `front.class-native` | `frame[plain]` hand-laid with `\inserttitle` `\insertsubtitle` `\insertauthor` `\insertinstitute` `\insertdate`; spacing by `sp.manual-space` (`\vspace*{1.5cm}`, `\vspace{0.3cm}`, `\vfill`, `\quad`); sizes `font.size-commands` |
| title slide background artwork | main.tex:9 | `art.tikz` | `tikzpicture[remember picture,overlay]`: green full-page rectangle, coral triangle (south east, south west, north east); **ART/body**, see Blockers |
| contents slide | main.tex:10 | `toc.kernel` | `\tableofcontents` in `\begin{frame}{Roadmap}`, default options |
| sectioning | main.tex:11, 12, 13 | `head.kernel` | `\section{Question}`, `\section{Method}`, `\section{Decision}`; in beamer they print nothing on the slide, they feed the ToC and `\insertsection` in the footline |
| quote | main.tex:11 | `quote.kernel` | `quote` environment with `\large` |
| bullet list | main.tex:11 | `list.kernel` | `itemize`, three items, beamer default list template |
| numbered list | main.tex:13 | `list.kernel` | `enumerate`, three items |
| display maths | main.tex:2, 12 | `math.amsmath` | `\usepackage{amsmath}`; `align*` with `&` alignment and `\text{}` |
| row gap in maths | main.tex:12 | `sp.manual-space` | `\\[2pt]` |
| alert block | main.tex:12 | `class.beamer` | `alertblock{Design check}` (class-native; default block template, no `\setbeamertemplate{blocks}` call) |
| TikZ package load | main.tex:2 | `art.tikz` | `\usepackage{tikz}`, used only by the title-slide picture (main.tex:9) |

Not present in the sample: header, bibliography, floats, tables, captions, code, footnotes, index, theorems, language or metadata packages, `hyperref` options.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| frame title template body | main.tex:5 | yes | `slide.beamer-template` (frametitle) over `sp.manual-space` (`\vspace`, `\hspace`), `sp.rule` (`\rule` 0.18\paperwidth by 1.4pt) and `color.xcolor` (`\textcolor{veronacoral}`); no counters or conditionals |
| footline template body | main.tex:6 | yes | `slide.beamer-template` (footline) over `sp.manual-space`; beamer insert macros only |
| title-slide frame layout | main.tex:9 | yes (text part) | `frame[plain]` with `front.class-native` insert macros, `font.size-commands`, `mark.kernel`, `color.xcolor`, `sp.manual-space`; the `tikzpicture` inside the same frame is not reducible (ART, Blockers) |
| `\newcommand`, `\def`, environments, counters, zip-local `.cls` or `.sty` | none in the zip | n/a | the zip holds only main.tex (no local class or style files) |

## Content-opaque
none (the `tikzpicture` at main.tex:9 is template artwork, not figure content, so it is a blocker above and not listed here)

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
