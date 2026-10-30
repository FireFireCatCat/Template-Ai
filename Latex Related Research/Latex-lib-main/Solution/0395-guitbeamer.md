no

# 0395-guitbeamer: GuITbeamer (beamer class for LaTeX lessons, with its Italian manual)

- Unverified: read from the source, not compiled.
- Source: Source/0395-guitbeamer/ (origin: https://mirrors.ctan.org/macros/latex/contrib/GuIT/guitbeamer.zip; licence: CC BY-NC-SA 2.5 per README:19-23, "nocommercial" in the manifest, "No Commercial Use" on ctan.org/pkg/guitbeamer)
- Kind: presentation
- Lib: v4
- Engine: pdfLaTeX-compatible (beamer, `inputenc` utf8x; nothing needs XeLaTeX or LuaLaTeX; the `guit` package was not read)
- Look carried by: mixed (guitbeamer.cls carries the slide look, as published beamer themes and templates; the manual's article look is its own preamble, guitbeamer.tex:2-25)
- Class origin: ctan
- Main file: guitbeamer.tex (other samples: none; the five img/*.pdf are page images of slides, not sources)
- Read: main yes, zip-local classes and styles all (guitbeamer.cls, 146 lines; it is the only class or style in the zip)

## Verdict
No, on one blocker. `guitbeamer.cls` is a CTAN class (ctan.org/pkg/guitbeamer, v0.4, read once) and everything it and the manual define reduces to lib ways: the class is `\LoadClassWithOptions{beamer}` plus theme, colour and template calls, and every zip-local macro is an alias, an overlay-aware wrapper or a beamer block with a colour. What stops a yes is `guit`: the class loads it unconditionally (guitbeamer.cls:10) and the manual loads it (guitbeamer.tex:5), it is not in the zip, I could not establish that it is published (ctan.org/pkg/guit and ctan.org/pkg/GuIT both answered 410 Gone), and I could not read its source. Its commands `\GuIT` (logo), `\GuITtext`, `\GuITurl` and `\GuITcolor` print the organisation's logo and name on every slide and on the manual's title, so no way can be named and justified against W1 to W4. If a reviewer shows `guit` is published and declarative, the verdict flips to yes: nothing else here is a blocker.

## Blockers
- `UNMAPPED/class` package `guit` loaded unconditionally by the class, source absent from the zip and unread, CTAN page 410 Gone; `\GuITcolor{1,.66,1,0}` (guitbeamer.cls:10-11), `\GuIT[color=no]` (guitbeamer.cls:142), `\institute{\scalebox{2}{\GuIT} --- \large\GuITtext\\\GuITurl}` and `\logo{\scalebox{2}{\GuIT}}` (guitbeamer.cls:143-144)
- `UNMAPPED/preamble` the same package loaded by the manual: `\usepackage[color]{guit}` (guitbeamer.tex:5), used at guitbeamer.tex:28, 118, 157, 501; the manual itself lists it as needed from version 0.9, 24/05/2006 (guitbeamer.tex:148)

## Class setting
- Class (slides, the template): `class.guitbeamer`, no options of its own; options pass to beamer through `\LoadClassWithOptions{beamer}[2005/06/12]` (guitbeamer.cls:6). It builds on `class.beamer`.
- Class (manual, the sample): `class.article` options: `a4paper,10pt` (guitbeamer.tex:2). The sample does not load guitbeamer; it describes it.
- Class-native vocabulary used by the sample: `\title` `\author` `\date` `\thanks` `\maketitle`, `abstract`, `\tableofcontents`. Class-native vocabulary of `class.guitbeamer` (defined, documented at guitbeamer.tex:176-329, shown only as Verbatim source): `\aalert<>`, `\Lsty` `\Lcls` `\Lopt` `\Lenv`, `LaTeXcode[title]<overlay>`, `LaTeXoutput[title]<overlay>`, `\LCmd[escape]{}`, `\LCmdArg{}{}`, `\tbs` `\tlb` `\trb` `\tls` `\trs`, `\n` `\nn` `\fakeind` (inside the two environments), plus beamer's `\institute` `\logo`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| slide class | guitbeamer.cls:3,6 | `class.guitbeamer` | v0.4.1 2006/10/26; loads beamer >= 2005/06/12 with the caller's options |
| base slide class | guitbeamer.cls:6 | `class.beamer` | `\LoadClassWithOptions` |
| manual class and paper | guitbeamer.tex:2 | `page.class-options` | a4paper, 10pt (class `class.article`) |
| input encoding | guitbeamer.tex:3 | `font.fontenc-t1` | `inputenc` option utf8x |
| language | guitbeamer.tex:4 | `lang.babel` | italian |
| beamer theme | guitbeamer.cls:18,20,21 | `slide.beamer-theme` | `\usetheme{Warsaw}`; `\usecolortheme[rgb={0,.5,0}]{structure}`; `\useoutertheme{split}` |
| beamer font theme | guitbeamer.cls:22,25 | `slide.beamer-theme` | `\usefonttheme{default}`; `\usefonttheme[onlymath]{serif}` (serif only in maths) |
| table-of-contents ball template | guitbeamer.cls:19 | `slide.beamer-template` | `\beamertemplatenumberedballsectiontoc` (beamer's legacy toc template switch) |
| structure and alert colours | guitbeamer.cls:32-35 | `slide.beamer-template` | `\setbeamercolor`: `alerted text` fg=blue; `aalerted text` fg=red; `LaTeX code` fg=LC foreground, bg=LC background; `alerted LaTeX code` fg=LC alerted fg, bg=LC background |
| named colours | guitbeamer.cls:5,28-30,132 | `color.xcolor` | option svgnames; `LC background` rgb 1,.97,.86; `LC foreground` = DarkBlue; `LC alerted fg` = DarkRed; `\color{LaTeX code.fg}` |
| slide footline | guitbeamer.cls:38-49 | `slide.beamer-template` | `\setbeamertemplate{footline}`: three `beamercolorbox` of .33, .33, .34 `\paperwidth`, ht=2.25ex dp=1ex, colours `subsection in head/foot` and `section in head/foot`; fields `\insertshortauthor`, `\insertshortinstitute`, `\insertshorttitle`, `\insertshortdate`, `\insertframenumber/\inserttotalframenumber` |
| overlay-aware commands and environments | guitbeamer.cls:57,74,91,107 | `slide.beamer-mode` | `\newcommand<>`, `\newenvironment<>` with `actionenv` and the overlay spec `#2` |
| code block (`LaTeXcode`) | guitbeamer.cls:91-102 | `slide.beamer-template` | `\usebeamertemplate{block begin}`/`{block end}`, `\setbeamercolor{block body}{fg=LC foreground,bg=LC background}`, `\insertblocktitle` from the optional argument |
| code block body | guitbeamer.cls:99-100 | `code.verbatim` | beamer `semiverbatim` (backslash and braces escaped as in `alltt`) |
| output block (`LaTeXoutput`) | guitbeamer.cls:107-113 | `slide.beamer-template` | `\usebeamertemplate{block begin}`/`{block end}` with the default block colours |
| output block paragraph shape | guitbeamer.cls:111 | `sp.lengths` | `\setlength{\parindent}{1.5em}` |
| output block font | guitbeamer.cls:111 | `mark.kernel` | `\rmfamily` |
| false indent, line breaks | guitbeamer.cls:95-96,110 | `sp.manual-space` | `\fakeind` = `\hspace*{1.5em}`; `\n` = `\newline`; `\nn` = `\newline\null\newline` |
| inline name and command fonts | guitbeamer.cls:74,121,123,132 | `mark.kernel` | `\ttfamily`; colour from `\usebeamercolor[fg]{structure}` or `{LaTeX code}` (`slide.beamer-template`) |
| institute and logo | guitbeamer.cls:143-144 | `front.class-native` | beamer `\institute[short]{..}`, `\logo{..}`; contents come from `guit` (blocker) |
| logo scaling, graphics | guitbeamer.cls:7,143-144 | `fig.graphicx` | `\RequirePackageWithOptions{graphicx}`, `\scalebox{2}`; manual at guitbeamer.tex:7 `\graphicspath{{img/}}` |
| institute size | guitbeamer.cls:143 | `font.size-commands` | `\large`; manual title `\LARGE` at guitbeamer.tex:28 |
| link colours | guitbeamer.cls:8; guitbeamer.tex:6,8 | `meta.hyperref` | class `colorlinks=false`; manual `colorlinks=true,urlcolor=blue`; `\href{mailto:..}` at guitbeamer.tex:10,491 |
| URL breaking | guitbeamer.tex:6,50 | `meta.url` | `breakurl` (considered: sibling of `url`), `\url` |
| first-line indent | guitbeamer.tex:6 | `sp.indentfirst` | load-only |
| title block | guitbeamer.tex:27-32,35 | `front.maketitle` | `\title` `\author` `\date` `\maketitle` |
| author note | guitbeamer.tex:28-31 | `front.thanks` | `\thanks` |
| abstract | guitbeamer.tex:37-42 | `abs.kernel` | `abstract` |
| contents | guitbeamer.tex:44 | `toc.kernel` | `\tableofcontents` |
| page breaks | guitbeamer.tex:45,332,363,388,420,447,473 | `pg.break` | `\newpage` |
| headings | guitbeamer.tex:46,81,120,126,176,237,338,474 | `head.kernel` | `\section`, `\section*`, `\subsection`, `\subsection*`, `\subsubsection`, defaults |
| lists | guitbeamer.tex:60-70,107-115,179-187 | `list.kernel` | `description`, `itemize` |
| dingbat lists, licence icons | guitbeamer.tex:6,48,53-57,61,64,66,72-79 | `font.icons` | `pifont` `dinglist{227}`/`{52}`; `cclicenses` `\cc` `\ccby` `\ccnc` `\ccsa` (considered: `front.doclicense`) |
| footnote | guitbeamer.tex:48-50 | `fn.kernel` | `\footnote` |
| inline marks | guitbeamer.tex:21-25,46,52 | `mark.kernel` | `\textsf`, `\texttt`, `\emph`, `\textit` |
| code listings in the manual | guitbeamer.tex:6,264-270,289-295,340-356 | `code.verbatim` | `fancyvrb` `Verbatim[gobble=0]`, `[gobble=2]`; `\verb` (guitbeamer.tex:199) |
| guillemets | guitbeamer.tex:11-13 | `font.nfss` | `\fontencoding{T1}\selectfont` around `\guillemotleft`/`\guillemotright` |
| spacing | guitbeamer.tex:139,324,358,496 | `sp.manual-space` | `\medskip`, `\bigskip`, `\vfill`, `\\[.5em]` |
| centring, no indent | guitbeamer.tex:52,136,359 | `sp.ragged`, `sp.lengths` | `\centering`, `center`; `\noindent` |
| table of loaded packages | guitbeamer.tex:136-151 | `tbl.tabular`, `tbl.booktabs`, `cap.kernel` | `table[b]`, `tabular{l c l}`, `\toprule` `\midrule` `\bottomrule`, `\caption`, `\label` |
| screenshot frames | guitbeamer.tex:360,385,417,444,470 | `box.fancybox`, `fig.graphicx` | `\fbox{\includegraphics[width=.9\textwidth]{..}}` inside `center` |
| cross-references | guitbeamer.tex:31,338,364 | `xref.kernel` | `\label`, `\ref` |
| bibliography | guitbeamer.tex:497-504 | `bib.thebibliography` | `thebibliography{99}`, `\bibitem`, `\newblock`, `\cite`; `\bibliographystyle{plain}` has no `\bibliography` call, so it prints nothing |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\bs \lb \rb \ls \rs` (`\char'134`...) | guitbeamer.cls:62-66; guitbeamer.tex:15-19 | yes | glyph aliases of node text: inline expansion to `\textbackslash`, `\{`, `\}`, `[`, `]` |
| `\aalert<>` | guitbeamer.cls:57 | yes | `alertenv` plus `\usebeamercolor[fg]{aalerted text}` (colour set at :33): `slide.beamer-mode` + `slide.beamer-template` |
| `\Lsty` `\Lcls` `\Lopt` `\Lenv` | guitbeamer.cls:74-80 | yes | aliases: `actionenv` + structure colour + `\ttfamily`; `\Lopt` = `\LCmd[]`; `\Lcls` and `\Lenv` are `\let` copies |
| frame-title flag `\@inframetitle` | guitbeamer.cls:83-84, read at :120-124 | yes, by position | a two-valued context test: an emitter knows whether a node sits in a frame title, so it writes `\ttfamily` only there and colour plus `\ttfamily` elsewhere. Note: line 84 gives `\addtobeamertemplate` two arguments where beamer documents three; not checked against beamer's source |
| `LaTeXcode` | guitbeamer.cls:91-102 | yes | `block` template + local `\setbeamercolor{block body}` + `semiverbatim`; the local `\n` `\nn` `\alert` are text aliases (`\newline`, `\newline\null\newline`, a colour switch), expanded inline |
| `LaTeXoutput` | guitbeamer.cls:107-113 | yes | `block` template + `\setlength{\parindent}{1.5em}` + `\rmfamily`; `\fakeind` is `\hspace*{1.5em}` |
| `\LCmd`, `\LCmdArg`, `\tbs` `\tlb` `\trb` `\tls` `\trs` | guitbeamer.cls:118-139 | yes | a group, `\let` of `\\` `\{` `\}` to the glyph aliases above (inline expansion of the node text), `\ttfamily`, `\color{LaTeX code.fg}`; `\char'134` default escape |
| `\ncGuIT`, `\institute`, `\logo` | guitbeamer.cls:142-144 | structure yes, contents no | the calls are beamer vocabulary; the `\GuIT` logo and `\GuITtext` come from `guit` |
| `\hbadness=10000` | guitbeamer.cls:98 | yes | no typeset effect (silences box warnings); not a component |
| manual aliases `\email` `\lcap` `\rcap` `\Cap` `\pkg` `\cls` `\env` `\cmd` `\cmdarg` | guitbeamer.tex:10-13,21-25 | yes | `\href{mailto:..}{\ttfamily ..}`, `font.nfss` guillemets, `\textsf`, `\texttt`: inline expansion |
| package `guit` | guitbeamer.cls:10; guitbeamer.tex:5 | not established | not in the zip, not read, publication not confirmed (CTAN 410 Gone twice); a guessed home (`font.icons`, as `hologo`) is rejected: W1 is not shown, and a one-organisation logo fails W3 |

## Content-opaque
- Slide page images shipped with the zip, included as images inside `\fbox`: img/latexsymb.pdf, img/docexem.pdf, img/cmdexpl.pdf, img/pkgexem.pdf, img/clsexpl.pdf (guitbeamer.tex:360,385,417,444,470). Assets, not read.
- The slide sources shown as Verbatim text (guitbeamer.tex:264-270,289-295,340-466) are code text, content.
- The licence wording, Italian text and bibliography entries are content.
- Nothing in the zip is addressed to an AI.

## Lib changes
- New ways proposed: none. Considered and not proposed: `hologo`-type mapping for `guit` (see Bespoke code).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
