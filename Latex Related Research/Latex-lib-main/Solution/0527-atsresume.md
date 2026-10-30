yes

# 0527-atsresume: atsresume (one-column ATS-readable resume class)

- Unverified: read from the source, not compiled.
- Source: Source/0527-atsresume/ (origin: https://mirrors.ctan.org/macros/latex/contrib/atsresume.zip; licence: LPPL 1.3c)
- Kind: cv
- Lib: v4
- Engine: pdfLaTeX-compatible (atsresume.cls:60-81 branches on `\ifPDFTeX`: Type 1 `tgpagella` under pdfTeX, `fontspec` OpenType under XeLaTeX/LuaLaTeX; the manual atsresume-doc.tex:2 is built with pdflatex)
- Look carried by: class (atsresume.cls defines the page, fonts, header, section heading, entry lines and bullets; atsresume-example.tex adds only the class's own fields, entries and prose)
- Class origin: ctan (atsresume.cls is the CTAN file: manifest origin is mirrors.ctan.org, and ctan.org/pkg/atsresume, read once, lists atsresume 1.0.0, LPPL 1.3c, in TeX Live)
- Main file: atsresume-example.tex (other samples: atsresume-doc.tex, an `article` manual and the manifest's `main`; both read)
- Read: main yes, zip-local classes and styles all (atsresume.cls, 333 lines, read in full; it is the CTAN class, not zip-local in the rubric's sense)

## Verdict
The look is carried by one published CTAN class, `class.atsresume`, so the sample is only `\documentclass{atsresume}`, five class-native fields, four entry commands and an ordinary `itemize` (atsresume-example.tex:6-80). An emitter writes those with published ways; the manual atsresume-doc.tex is a plain `article` with `geometry`, `tgpagella`, `fancyvrb`, `graphicx` and `hyperref`, and its two `\newcommand` aliases reduce by inline expansion. No ART, no EXTERNAL tool, no shell escape. The class's own internals (an expl3 link-address routine, glue-based left/right rows, `\prevdepth` flow control) are inside a published class and are therefore not blockers under the rubric's published-class ruling; see Notes for how this would read if the class were treated as zip-local. This is evidence about the class dimension, not about the component ways.

## Blockers
none

## Class setting
- Class: `class.atsresume` options: none in the sample (atsresume-example.tex:6); the class declares `a4paper` (A4, margin 15mm) and `letterpaper` (default, margin 0.6in) and passes every other option to `article` (atsresume.cls:30-34, 42-46); `10pt`/`11pt`/`12pt` have no effect because `\normalsize` is fixed (atsresume-doc.tex:160-161, atsresume.cls:86). Base class loaded with `\LoadClass{article}` (atsresume.cls:36). The manual uses `class.article` with option `11pt` (atsresume-doc.tex:7).
- Class-native vocabulary used: `\name{}` `\contact{}` (preamble, repeated per item), `\email{}` `\weblink{}` (inside `\contact`), `\makeheader`, `\section{}` (unnumbered, upper-cased), `\education{School}{Place}{Degree}{Dates}`, `\experience{Company}{Place}{Title}{Dates}`, `\activity{Name}{Role}{Dates}`, `\skill{Label}{Text}` (atsresume-example.tex:8-15, 17-78; definitions atsresume.cls:129-303)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class (resume) | atsresume-example.tex:6 | `class.atsresume` | no options |
| document class (manual) | atsresume-doc.tex:7 | `class.article` | 11pt |
| base class under atsresume | atsresume.cls:36 | `class.article` | `\LoadClass{article}` |
| paper size | atsresume.cls:30-34 | `page.class-options` | `a4paper` / `letterpaper` switch, rest passed to article |
| page geometry | atsresume.cls:41-46 | `page.geometry` | `letterpaper, margin=0.6in` or `a4paper, margin=15mm` (set inside the class) |
| page geometry (manual) | atsresume-doc.tex:11 | `page.geometry` | `margin=1in` |
| font encoding (pdfTeX) | atsresume.cls:61 | `font.fontenc-t1` | `T1` |
| text face (pdfTeX) | atsresume.cls:62 | `font.palatino` | `tgpagella` |
| text face (XeTeX/LuaTeX) | atsresume.cls:73-80 | `font.fontspec` | `\setmainfont{texgyrepagella}[Extension=.otf, UprightFont=*-regular, BoldFont=*-bold, ItalicFont=*-italic, BoldItalicFont=*-bolditalic, Ligatures={TeX,NoCommon}]` |
| f-ligatures off, no protrusion | atsresume.cls:63-64 | `sp.microtype` | `protrusion=false, expansion=false`; `\DisableLigatures[f]{encoding = *}` |
| ToUnicode map | atsresume.cls:66-67 | `meta.glyphtounicode` | `\input{glyphtounicode}`, `\pdfgentounicode=1` (pdfTeX branch only) |
| text face (manual) | atsresume-doc.tex:8-10 | `font.fontenc-t1`, `font.palatino`, `font.family-default` | `T1`; `tgpagella`; `\renewcommand\ttdefault{lmtt}` |
| base size and line spacing | atsresume.cls:86-87 | `font.size-commands` | `\renewcommand\normalsize{\@setfontsize\normalsize{10.5}{13.1}}` |
| paragraph and top lengths | atsresume.cls:88-90, 99 | `sp.lengths` | `\topskip=10.5pt`, `\parindent=0pt`, `\parskip=0pt`, `\emergencystretch=2em` |
| paragraph lengths (manual) | atsresume-doc.tex:20-21 | `sp.lengths` | `\parindent=0pt`, `\parskip=0.6\baselineskip` |
| page style | atsresume.cls:91 | `hf.pagestyle-kernel` | `\pagestyle{empty}` (no header, footer or page number) |
| space after period | atsresume.cls:92 | `sp.frenchspacing` | `\frenchspacing` |
| alignment | atsresume.cls:96; atsresume-doc.tex:22 | `sp.ragged` | `\raggedright` |
| hyphenation off | atsresume.cls:97-98 | `sp.penalties` | `\hyphenpenalty=10000`, `\exhyphenpenalty=10000` |
| no break inside rows and bullets | atsresume.cls:250, 327-328 | `sp.penalties` | `\interlinepenalty\@M`, `\@beginparpenalty\@M` |
| hyperlinks and PDF metadata | atsresume.cls:101-102, 131 | `meta.hyperref` | `bookmarks=false, pdfpagelabels=false`; `hidelinks, pdflang={en}`; `\name` sets `pdfauthor` and `pdftitle={<name> - Resume}` |
| hyperlinks (manual) | atsresume-doc.tex:14-15 | `meta.hyperref` | `hidelinks`; `pdftitle`, `pdfauthor` |
| name and contact header | atsresume.cls:129-133, 190-210; atsresume-example.tex:8-15 | `front.class-native` | name centred, 20/24 pt bold (atsresume.cls:114, 198-199); contact items joined by ` \textbar ` with `\nobreakspace`, centred, 2.5pt below the name (atsresume.cls:201-208) |
| email and web links | atsresume.cls:177-188; atsresume-example.tex:11-12 | `front.class-native` | `\email{}` and `\weblink{}` print the address as typed; link is `\href{mailto:...}` or `\href{https://...}` (`\href` is a hyperref link command, filed with the class command) |
| section heading | atsresume.cls:217-233; atsresume-example.tex:17, 27, 58, 74 | `head.class-native` | unnumbered, centred, 11/13.2 pt bold, `\MakeUppercase`, `\hrule` 0.75pt, 3.6pt gap, 9pt above, -1pt after; `\section*` the same |
| heading internals | atsresume.cls:221-226 | `mark.case`, `sp.rule`, `sp.manual-space` | `\MakeUppercase`; `\hrule\@height 0.75pt`; `\addvspace`, `\vskip` |
| entry lines | atsresume.cls:244-303; atsresume-example.tex:19-20, 29-30, 40-41, 49-50, 60, 68 | `cv.entries` | `\education`, `\experience`, `\activity` (bold left part, italic title, right part pushed flush right by `\hfil`), 9pt between entries (atsresume.cls:108, 262) |
| skills lines | atsresume.cls:300-303; atsresume-example.tex:76-78 | `cv.entries` | `\skill{Label}{Text}`: bold label with colon, one line per call |
| bold and italic runs | atsresume.cls:277-296 | `mark.kernel` | `\textbf`, `\textit` |
| bullet list | atsresume.cls:312-329; atsresume-example.tex:21-25 | `list.kernel` | `itemize` redefined: label `\textbullet`, `leftmargin=0.25in`, `labelwidth=0.15in`, `labelsep=0pt`, `itemindent=0pt`, `listparindent=0pt`, `topsep=partopsep=parsep=itemsep=0pt`, `\makelabel{#1\hfil}` |
| title block (manual) | atsresume-doc.tex:24-29 | `front.maketitle` | `\title`, `\author{Super Lede\\\small ...}`, `\date`, `\maketitle` |
| sectioning (manual) | atsresume-doc.tex:31, 55, 90, 92 | `head.kernel` | `\section`, `\subsection*` |
| description and itemize (manual) | atsresume-doc.tex:94-114, 191-214 | `list.kernel` | `description`, `itemize` |
| verbatim blocks (manual) | atsresume-doc.tex:13, 17, 61-85 | `code.verbatim` | `fancyvrb` `Verbatim`, `\fvset{xleftmargin=1em, fontsize=\small}`; `\verb` (atsresume-doc.tex:104) |
| size switch (manual) | atsresume-doc.tex:17, 25 | `font.size-commands` | `\small` |
| figure with framed image (manual) | atsresume-doc.tex:12, 48-53 | `fig.graphicx` | `figure[ht]`, `\centering`, `\fbox{\includegraphics[width=0.62\linewidth]{atsresume-example.pdf}}` |
| frame around image (manual) | atsresume-doc.tex:50 | `box.fancybox` | `\fbox` |
| caption and label (manual) | atsresume-doc.tex:51-52 | `cap.kernel`, `xref.kernel` | `\caption`, `\label{fig:example}`; `\ref` at atsresume-doc.tex:45 |
| web address (manual) | atsresume-doc.tex:42 | `meta.url` | `\url{...}` |
| font switches (manual) | atsresume-doc.tex:18-19, 24, 192 | `mark.kernel` | `\texttt`, `\textrm`, `\textit`, `\textbf` |

## Bespoke code
All rows below sit in atsresume.cls except the first. Rows 2 to 9 are inside the published CTAN class, so under the rubric they are the class's own vocabulary, not zip-local bespoke code; the last column also gives the reading if the class were counted as zip-local.

| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\cs`, `\param` aliases (manual) | atsresume-doc.tex:18-19 | yes (zip-local, preamble) | `\newcommand` aliases over `mark.kernel`: `\texttt{\textbackslash#1}` and `\textrm{\textit{#1}}`; inline expansion |
| `\atsresume@ifempty` | atsresume.cls:119-124 | yes | the emitter knows each argument, so an empty field is simply omitted; no way needed |
| `\name`, `\contact` store and join | atsresume.cls:127-133, 202-208 | published class vocabulary; if zip-local: yes | `\hypersetup{pdfauthor,pdftitle}` (`meta.hyperref`); a centred line of `\mbox{item}` joined by `\nobreakspace\textbar\space` (`sp.ragged`, `sp.manual-space`) |
| `\email`, `\weblink` expl3 address routine | atsresume.cls:140-188 | published class vocabulary; if zip-local: yes in effect, the string-clean-up is class code | `\href{mailto:addr}{addr}` / `\href{https://addr}{addr}` (hyperref) with the address already escaped by the emitter |
| `\makeheader` | atsresume.cls:190-210 | published class vocabulary; if zip-local: yes | centred 20/24 pt bold name over a strut `\vrule` of height 18.3pt, 2.5pt `\vskip`, contact line (`font.size-commands`, `sp.rule`, `sp.manual-space`) |
| `\section` redefinition | atsresume.cls:217-233 | published class vocabulary; if zip-local: close, not exact | `head.titlesec`: `\titleformat{\section}[block]{\centering\fontsize{11}{13.2}\selectfont\bfseries}{}{0pt}{\MakeUppercase}[\titlerule[0.75pt]]` and `\titlespacing*`; the `\prevdepth` and `\@nobreakfalse` baseline and break tuning (atsresume.cls:220, 224, 229) has no declarative home |
| row and entry commands | atsresume.cls:244-303 | published class vocabulary; if zip-local: doubtful | left part, `\hfil\penalty50\hskip1em\hbox{}\nobreak\hfil`, right part, `\parfillskip\z@skip` (atsresume.cls:253-255): a hand-built paragraph shape (`sp.lengths`, `sp.penalties`) |
| `itemize` redefinition | atsresume.cls:313-329 | published class vocabulary; if zip-local: yes | `list.enumitem` `\setlist[itemize]{label=\textbullet, leftmargin=0.25in, labelwidth=0.15in, labelsep=0pt, itemindent=0pt, listparindent=0pt, topsep=0pt, partopsep=0pt, parsep=0pt, itemsep=0pt}` plus the two penalty assignments |
| `\normalsize` redefinition | atsresume.cls:86-88 | published class vocabulary; if zip-local: yes | `\fontsize{10.5}{13.1}\selectfont` (`font.size-commands`) |

## Content-opaque
none. The only picture is `atsresume-example.pdf` included in the manual's figure (atsresume-doc.tex:50), which is figure content; the resume sample has no figure, table, equation, code or TikZ.

## Lib changes
- New ways proposed: none. Considered and not proposed: `iftex` (a load-only engine conditional used at atsresume.cls:38, 60, with no printed effect; the emitter picks one branch, as with the v4 rejection of `sys.compat-load`).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- Sensitivity: the verdict follows the rubric ruling that a published class carries the look. If atsresume.cls were read as zip-local, the `\section` baseline tuning (atsresume.cls:220-231), the glue row (atsresume.cls:244-257) and the expl3 address routine (atsresume.cls:140-176) are the items that would be argued irreducible, and the answer would then be `no` (`BESPOKE/class`). The class is on CTAN and in TeX Live, so that reading does not apply.
- Main file: the manifest names atsresume-doc.tex as `main`; the template's own showcase is atsresume-example.tex, which is analysed as the main sample. Both are in the Component map.
- Fonts (TeX Gyre Pagella, Latin Modern mono) come from TeX Live; no font or image the sample needs is missing from the zip. `atsresume-example.pdf` is shipped for the manual's figure.
- README.md credits an AI assistant for drafting the class (README.md:77); no text in the zip is addressed to an AI reader. Nothing was run or compiled; the README's parser-test claims (README.md:25-31) are not verified here.
