yes

# 0835-designcon: DesignCon conference paper class (designcon, v1.0)

- Unverified: read from the source, not compiled.
- Source: Source/0835-designcon/ (origin: https://mirrors.ctan.org/macros/latex/contrib/designcon.zip; licence: lppl1.3)
- Kind: conference
- Lib: v6
- Engine: needs XeLaTeX (`fontspec` with system fonts, `xunicode`, `xltxtra`, `polyglossia`, `\newfontinstance`: designcon.cls:26-28,36-37,49,54; stated at DesignCon.tex:19 and README:27-28)
- Look carried by: mixed (the class defines page, fonts, headings, title page and language; the sample preamble repeats the font and language lines and adds the `refstyle` reference formats at DesignCon.tex:26-40)
- Class origin: ctan
- Main file: DesignCon.tex (other samples: DesignCon.lyx, the same skeleton in LyX format, not LaTeX)
- Read: main yes, zip-local classes and styles all (designcon.cls in full; designcon.layout in full, it is a LyX file; DesignCon.lyx only its header, layout names and insets, not the whole 702 lines)

## Verdict
The look is a published CTAN class (`designcon`, a thin class on `article`) plus a small `refstyle` preamble. The class is `\LoadClass{article}`, a `geometry` call, `fontspec` fonts, `titlesec[sf]`, `polyglossia`, and one hand-laid `titlepage` driven by four short commands. Every macro in it is an alias, a `\def` string store or a composition of lib ways (see Bespoke code), there is no drawing, no output routine and no external tool. So `yes`. The class is published, so the title-page macros are class vocabulary; the reductions are written down anyway so a stricter reading of "class internals" gives the same verdict. Fonts (Times New Roman, Arial Black) are system fonts that the zip does not ship.

## Blockers
none

## Class setting
- Class: `class.designcon` options: the sample passes `12pt,twoside,english,american` (DesignCon.tex:22), but the class does not process options (`\DeclareOption*` and `\ProcessOptions` are commented out, designcon.cls:23-24). The effective base is `\LoadClass[12pt,twoside,american,nolist]{article}` (designcon.cls:25), so the sample's options only act as global options for packages.
- Class-native vocabulary used: `\setHeading{text}` (DesignCon.tex:54), `\title{}` with the class's own `\maketitle` (DesignCon.tex:56,66; designcon.cls:101-103), `\setSkip{text}` (DesignCon.tex:58), `\setAuthorInfo{line}` five times (DesignCon.tex:60-64), `\designConPaperStart` (DesignCon.tex:76), the `acronym` environment with `\acro{}{}` (DesignCon.tex:49-52, from the `acronym` package the class loads). Headings are unnumbered `\section*` and `\subsection*` (DesignCon.tex:68,72,117,131); there is no `abstract` environment.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | DesignCon.tex:22; designcon.cls:21-22 | `class.designcon` | options not processed (designcon.cls:23-24 commented) |
| base class | designcon.cls:25 | `class.article` | `12pt,twoside,american,nolist` |
| paper size, point size, two-sided | designcon.cls:25 | `page.class-options` | `12pt`, `twoside` |
| page geometry | designcon.cls:29-30 | `page.geometry` | `letterpaper`; `verbose,tmargin=1in,bmargin=1in,lmargin=0.75in,rmargin=0.75in` |
| header/footer | designcon.cls:25,76 | `hf.pagestyle-kernel` | no `\pagestyle` call (`\pagestyle{title}` is commented, designcon.cls:76), so article's default `plain`; the `titlepage` environment is empty-styled by the kernel |
| page numbering | designcon.cls:77,107 | `pgnum.pagenumbering` | `gobble` while the front pages run, `arabic` from `\designConPaperStart` |
| page breaks | designcon.cls:97,106 | `pg.break` | `\cleardoublepage` after the title page and at paper start |
| main and sans fonts | designcon.cls:26-28; DesignCon.tex:23-25 | `font.fontspec` | `\setmainfont[Mapping=tex-text]{Times New Roman}`, `\setsansfont[Mapping=tex-text]{Arial Black}` (given twice, class and sample) |
| heading-banner font | designcon.cls:49,79 | `font.fontspec` | `\newfontinstance\bigkanafont[Color=000000,Scale=3]{Arial Black}`, used on the heading |
| XeTeX extras | designcon.cls:37 | `font.fontspec` | `xltxtra`, load-only (loads fontspec; source not read) |
| Unicode text-symbol mapping | designcon.cls:36,53; DesignCon.tex:42 | `font.fontenc-t1` | `xunicode`, load-only (the XeTeX counterpart of the `textcomp` layer; source not read) |
| scalable CM sizes | designcon.cls:42 | `font.exscale` | `fix-cm`, load-only |
| font sizes | designcon.cls:48,69,83 | `font.size-commands` | `\fontsize{36}{43}\selectfont` (title), `\Large` (author lines), `\HUGE` = `\@setfontsize\Huge{36}{47}` (defined, never used) |
| language | designcon.cls:54-55; DesignCon.tex:43-45 | `lang.polyglossia` | `\setdefaultlanguage[variant=american]{english}`, sample adds `\setotherlanguage{english}` |
| hyphenation and sloppy | designcon.cls:38,82 | `sp.hyphenat` | `hyphenat` load-only; `sloppypar` around the title |
| title string, date | DesignCon.tex:56; designcon.cls:33 | `front.maketitle` | `\title{Title}`; `\@ifundefined{date}{}{\date{}}` is `\date{}` (the date is never printed) |
| title page | designcon.cls:75-103; DesignCon.tex:54-66 | `front.class-native` | `\setHeading`, `\setSkip`, `\setAuthorInfo`, `\maketitle`; 8 author slots printed |
| title page body (the class's own realisation) | designcon.cls:78-96 | `front.titlepage-env` | `titlepage` env: heading in `\bigkanafont`, title at 36/43pt, `\designconSkip`, then 8 lines `\noindent{\Large <line>}\\` |
| title alignment | designcon.cls:81; DesignCon.tex:79 | `sp.ragged` | `flushleft` for the title; `centering` environment around the figure |
| manual vertical space | DesignCon.tex:54,58; designcon.cls:88-95 | `sp.manual-space` | `\vspace{2.5in}` (inside the heading), `\vspace{3in}`, `\\` between author lines |
| abstract and biography | DesignCon.tex:68,72 | `head.kernel` | plain `\section*{Abstract}`, `\section*{Biography}` |
| headings | designcon.cls:43; DesignCon.tex:117,131 | `head.titlesec` | `\usepackage[sf]{titlesec}` (option only, no `\titleformat` call anywhere); `\section*`, `\subsection*` are `head.kernel` |
| paper start | designcon.cls:105-108; DesignCon.tex:76 | `pg.break`, `pgnum.pagenumbering` | `\cleardoublepage` then `\pagenumbering{arabic}` |
| figure float | DesignCon.tex:78-115 | `fig.graphicx` | `figure` env, `centering` env, no `\includegraphics` (the picture is a tikz drawing, content) |
| caption | DesignCon.tex:113 | `cap.kernel` | `\caption{Signal Flow Diagram}` |
| display equation | DesignCon.tex:125-127 | `math.kernel` | `equation` with `\label{eq:euler}`; no `amsmath` is loaded anywhere |
| labels and references | DesignCon.tex:114,121,129 | `xref.kernel` | `\label{fig:...}`, `\label{eq:...}`; `\eqref` becomes `\ref{eq:#1}` through `\providecommand` (DesignCon.tex:30) |
| reference wording | DesignCon.tex:26-40,121 | `xref.prettyref` | `refstyle`: `\newref{sub}{name=section~}`, `\newref{thm}{name=theorem~}`, `\newref{lem}{name=lemma~}`; the sample calls `\figref` only |
| acronyms | designcon.cls:41; DesignCon.tex:49-52 | `idx.glossaries` | `acronym` package, option `nolist`; `acronym` env with two `\acro{}{}` entries |
| file inclusion | designcon.cls:39 | `struct.input` | `import` package, load-only, never called |
| citations and bibliography | DesignCon.tex:135,141-142 | `bib.bibtex-bst` | `\bibliographystyle{ieeetr}`, `\bibliography{DesignCon}`, `\cite{article,conference,phdthesis,unpublished}`; the `.bib` is placeholder data (DesignCon.bib:1-156) |
| figure artwork | designcon.cls:40; DesignCon.tex:83-110 | `art.tikz` | `tikz` loaded by the class, used only inside the figure (Content-opaque) |

Not present in the sample or class: lists, tables, theorems, code, boxes, footnotes, margin notes, index, hyperref, colour definitions outside the figure, `amsmath`.

## Bespoke code
The class is on CTAN, so these are class vocabulary and not zip-local code; each is reducible anyway.

| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\@authorinfonumber`, `\setAuthorInfo`, `\AuthorInfoList` | designcon.cls:58-69 | yes | an indexed string store: call n stores line n, the title page prints slots 1 to 8 in order. Inline the final lines: `front.titlepage-env` holding `\noindent{\Large <line>}\\` for each slot (`font.size-commands`, `sp.manual-space`). Slots 6 to 8 are empty here; later calls beyond 8 are never printed. No `\if` or counter decides what is printed. |
| `\setHeading`, `\setSkip` | designcon.cls:71-72 | yes | `\def` aliases that store a string; inline the text (the heading text with its `\vspace{2.5in}`, then `\vspace{3in}`) |
| `\designconTitlePage` | designcon.cls:75-99 | yes | `\pagenumbering{gobble}` (`pgnum.pagenumbering`), `titlepage` env (`front.titlepage-env`), `\bigkanafont` heading (`font.fontspec`), `flushleft` + `sloppypar` + `\fontsize{36}{43}\selectfont` title (`sp.ragged`, `sp.hyphenat`, `font.size-commands`), `\cleardoublepage` (`pg.break`) |
| `\maketitle` redefinition | designcon.cls:101-103 | yes | alias of `\designconTitlePage`; an emitter writes the expanded page in place of `\maketitle` |
| `\designConPaperStart` | designcon.cls:105-108 | yes | `\cleardoublepage` + `\pagenumbering{arabic}` (`pg.break`, `pgnum.pagenumbering`) |
| `\HUGE` | designcon.cls:48 | yes | `\fontsize{36}{47}\selectfont` (`font.size-commands`); unused |
| `\@ifundefined{date}{}{\date{}}` | designcon.cls:33 | yes | `\date{}`; `\date` always exists in article, so the test is constant |
| refstyle guards `\RS@ifundefined{subref}{...}{}` (also `thmref`, `lemref`), `\def\RSsubtxt{section~}` | DesignCon.tex:28-40 | yes | unconditional `\newref{sub}{name=section~}`, `\newref{thm}{name=theorem~}`, `\newref{lem}{name=lemma~}` (`xref.prettyref`); the three prefixes are not used by the body; `refstyle` source is not in the zip and was not read, so which of them it predefines is not checked |
| `\providecommand\figref`, `\providecommand\eqref` in `\AtBeginDocument` | DesignCon.tex:29-30 | yes | either `refstyle`'s own `\figref` (`xref.prettyref`) or the alias `\ref{fig:#1}` and `\ref{eq:#1}` (`xref.kernel`); both are lib ways, so the outcome does not change the verdict |

## Content-opaque
- tikz picture (signal flow diagram, `art.tikz`) inside the figure, with its own `\definecolor` calls: DesignCon.tex:83-110. It is figure artwork, not template identity.
- Placeholder text, the Euler equation (DesignCon.tex:126) and the placeholder `.bib` entries (DesignCon.bib).
- Not LaTeX and not loaded by `DesignCon.tex`: `designcon.layout` is a LyX layout (it mirrors the class commands as LyX styles, for example designcon.layout:105,125,139,168) and `DesignCon.lyx` is the same skeleton in LyX; its preamble loads `lettrine` and sets `\LettrineTextFont` to `\scshape` (DesignCon.lyx:7-9) but never calls `\lettrine`. LyX is an authoring tool the `.tex` route does not need, so it is not a blocker. `DesignCon.pdf` is output.

## Lib changes
- New ways proposed: none. Considered and not proposed: a way for `xunicode` and `xltxtra` (published XeTeX support packages, load-only). They are filed under `font.fontenc-t1` (text-symbol layer) and `font.fontspec` (fontspec's companion) so no line is added; the `sys.compat-load` rejection in the v4 change log is the precedent for packages with no commands in the sample. A maintainer who disagrees can fold them into one XeLaTeX-support line.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
