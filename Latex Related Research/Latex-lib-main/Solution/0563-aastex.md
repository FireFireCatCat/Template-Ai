yes

# 0563-aastex: AASTeX v7.0.1 (American Astronomical Society journal manuscript class)

- Unverified: read from the source, not compiled.
- Source: Source/0563-aastex/ (origin: https://mirrors.ctan.org/macros/latex/contrib/aastex.zip; licence: LPPL 1.3c)
- Kind: journal
- Lib: v4
- Engine: pdfLaTeX-compatible (the sample's own build note is pdflatex + bibtex, aastex701-sample.tex:680-683; PNG figures; no fontspec or unicode-math anywhere)
- Look carried by: class (aastex701.cls, the AAS's own published class; the sample's preamble adds only three `\newcommand` aliases, aastex701-sample.tex:77-79)
- Class origin: ctan (ctan.org/pkg/aastex: author American Astronomical Society, LPPL 1.3c, v7.0.1 dated 2025-05-09, "provides a document class"; the zip is also the AAS's own kit, README:1-30)
- Main file: aastex701-sample.tex (other samples: none)
- Read: main yes, zip-local classes and styles partly (aastex701.cls is 13759 lines; read: lines 1-420, 5380-5560, 5585-5625, 6415-6430, 6860-7060, 7120-7260, 7322-7380, 7380-7700, 7700-8010, 8130-8215, 8405-8545, 8660-8740, 11255-11330, 11700-11790, 11960-11975, 12196-12300, 12380-12534, 12535-12700, 13336-13420, 13620-13759; NOT read: the revtex-derived grid and output-routine code (about 420-5380), the deluxetable column-preamble parser and table engine (about 8740-11250 and 11330-11700, 11790-11960), the author-list truncation machinery (about 12700-13336), `\bibitem` and cite glue; aasjournalv7.bst: header and structure only)

## Verdict
yes. The look is carried by one published class, `class.aastex701` (AAS authorship, on CTAN, LPPL). The sample adds class options (`linenumbers,trackchanges`) and the class's own vocabulary (author block, `deluxetable`, `\plotone`, `\added`...), plus three preamble aliases that reduce by inline expansion. Everything the class loads is a published package with no outside tool (no shell escape, no minted, no preprocessor: grep of the class found no `write18` and no external call). No artwork defines the template. This is evidence about the class dimension: the class's 13.7k lines are the way's own code and were read only in part.

## Blockers
none

## Class setting
- Class: `class.aastex701` options used: `linenumbers,trackchanges` (aastex701-sample.tex:12). Style by absence of a style option: one column, 10pt (aastex701.cls:6883-6888 `\ExecuteOptions{superscriptaddress,10pt,onecolumn,onecolappendix,letteredappendix}`), `letterpaper` (aastex701.cls:5478).
- Options the class offers but the sample does not select (aastex701-sample.tex:20-57; aastex701.cls:106-163, 5407-5426, 5445-5500): `twocolumn`, `manuscript`, `preprint`, `preprint2`, `modern`, `astrosymb`, `tighten`, `times` (aastex701.cls:154 declares it, 168-170 load `times`), `longauthor`, `twocolappendix`, `anonymous`, `resetfootnote`, `longbib`, paper sizes, `12pt`.
- Class-native vocabulary used by the sample: front matter `\title` (given after `\begin{document}`, with a `\footnote`), `\author[orcid=,gname=,sname=]{}`, `\altaffiliation`, `\affiliation`, `\email[show]{}`, `\collaboration{all}{}`, `abstract`, `\keywords`, `\uat{label}{id}`; back matter `acknowledgments`, `contribution`, `\facilities`, `\software`, `\appendix`; figures `figure*`, `\plotone`; tables `deluxetable*`, `splitdeluxetable*` (column letter `B` marks a break), `\tabletypesize`, `\tablewidth`, `\tablecaption`, `\tablehead`, `\colhead`, `\colnumbers`, `\startdata`...`\enddata`, `\nodata`, `\tablecomments`, `\digitalasset`; marks `\added`, `\doi`.
- Defined by the class, named in sample text or comments, not instantiated: `\shorttitle`, `\shortauthors`, `\received`, `\revised`, `\accepted`, `\submitjournal`, `\watermark`, `\setwatermarkfontsize`, `\startlongtable`, `rotatetable`, `longrotatetable`, `\movetabledown`, `\figurenum`, `\plottwo`, `\allauthors`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | aastex701-sample.tex:12; aastex701.cls:30 | `class.aastex701` | `linenumbers,trackchanges`; default style onecolumn 10pt letterpaper (aastex701.cls:6883-6888, 5478) |
| page geometry | aastex701.cls:7168-7189; sample sets none | `page.class-options` | fixed inside the class: `\textwidth` 7.1in, `\columnsep` 0.3125in, `\topmargin` 0in, `\headsep` 0.5in, `\voffset` -20mm, `\hoffset` -7.5mm, `\textheight` 64 baselines capped at 25cm less 54pt; paper size by option (`letterpaper` default) |
| running heads | aastex701.cls:7201-7214, 12385-12390; aastex701-sample.tex:88-89 (commented) | `hf.class-native` | page style `apjheads`: even page = number + small-caps `\shortauthors`, odd page = small-caps `\shorttitle` + number, `\lower9mm`; first page style `titlepage` (empty head, optional watermark); strings come from `\shorttitle` and `\shortauthors` |
| line numbers | aastex701-sample.tex:12; aastex701.cls:13715-13721 | `sp.draft-lineno` | `\usepackage[mathlines,left]{lineno}`; with option `linenumbers` `\linenumbers*[1]`, else `\thelinenumber` emptied |
| font sizes | aastex701.cls:7022-7060; aastex701-sample.tex:421 | `font.size-commands` | class redefines `\normalsize` 10/12.5pt (`tighten` 11.5), `\small` 9/11, `\footnotesize` 8/9.5; sample calls `\tabletypesize{\scriptsize}`; default text face is Computer Modern (no font package loaded unless `times`) |
| colour | aastex701.cls:8688-8689, 12464, 13609 | `color.xcolor` | `\usepackage{xcolor}`; `\definecolor{xlinkcolor}{cmyk}{1,1,0,0}`; `\providecolor{trackchange}{cmyk}{0,0,0,1}`; `\definecolor{ltblue}{cmyk}{.5,.1,.1,0}` |
| hyperref | aastex701.cls:8695-8705 | `meta.hyperref` | `bookmarks=true, pdfnewwindow=true, colorlinks=true, linkcolor=citecolor=filecolor=urlcolor=xlinkcolor, final=true`; sample's `\href` (aastex701-sample.tex:290) |
| URLs | aastex701.cls:8672, 13489; aastex701-sample.tex:251, 331 | `meta.url` | `\usepackage[hyphens]{url}`; `\url{}`; class `\doi{}` = `\href{https://doi.org/#1}` |
| title block | aastex701-sample.tex:116, 168-200; aastex701.cls:7232, 7328, 12822, 13310, 13341, 13377 | `front.class-native` | `\title` bold centred `\normalsize` (aastex701.cls:7232); authors `\small\scshape` centred (aastex701.cls:7341-7352); affiliation font `\normalfont\footnotesize\it` (aastex701.cls:7355-7362) in the default compressed footnote style (`superscriptaddress`, aastex701.cls:6887; `longauthor` is the alternative, aastex701-sample.tex:45-49; the author-list code itself was not read); `\author` optional key list `orcid` `gname` `sname`, ORCID icon `orcid-ID.png` 9pt via `\IfFileExists` (aastex701.cls:12694-12700); each author needs `\affiliation` and `\email` or the class stops (aastex701.cls:7370-7372); `\email[show]` prints at the foot of the first page (aastex701-sample.tex:155-162); `\collaboration{all}{name}`; the title block is produced at the first `\section` (aastex701.cls:7583-7600) |
| abstract | aastex701-sample.tex:209-227; aastex701.cls:7417-7433 | `abs.class-native` | `abstract` environment, heading `ABSTRACT` (aastex701.cls:7422), width 478pt (aastex701.cls:7420), `\normalsize`, `\parindent` 9pt |
| keywords | aastex701-sample.tex:237; aastex701.cls:2308, 7472-7482, 13751 | `abs.keywords` | `\keywords{}` prints `\textit{Keywords:}` with `\hangindent`, `\leftskip` 34pt, `\rightskip` 0.5in; items from `\uat{label}{id}` (link to astrothesaurus.org) |
| acknowledgments | aastex701-sample.tex:570-579; aastex701.cls:7700-7762 | `front.dedication` | `acknowledgments` environment opens `\section*{#1}` with default label `acknowledgments` (aastex701.cls:7710-7712, 7751), upper-cased by `\@ssect` (aastex701.cls:7688-7692); boxed away and replaced by a notice under `anonymous` |
| contribution, facilities, software | aastex701-sample.tex:581-618; aastex701.cls:7834-7851, 8143-8165 | `front.class-native` | `contribution` environment (opens `\section*{Author contributions}`, aastex701.cls:7839, the class errors at end of document if absent, aastex701.cls:7846-7851); `\facilities{}` and `\software{}` print an italic `\large` label then the text |
| lists | aastex701-sample.tex:399-405 | `list.kernel` | `enumerate` with five items |
| headings | aastex701-sample.tex:249, 333, 389, 409; aastex701.cls:7583-7627, 7640-7665 (`\@sect` at 7648) | `head.class-native` | `\section` centred, title upper-cased by `\sec@upcase`, number `N.` in `\small`; `\subsection` `\normalsize\itshape` centred; `\subsubsection` `\small\itshape` centred; spacing `9pt plus 1pt minus 1pt` / `4pt` (aastex701.cls:7616-7618) |
| heading depth | aastex701.cls:7576 | `num.secnumdepth` | `secnumdepth` 3 |
| appendix | aastex701-sample.tex:629-641; aastex701.cls:7867-7905 | `num.appendix`, `num.counters` | `\appendix` prints centred `APPENDIX`, resets `section`, `subsection`, `equation` to 0, sections `\Alph{section}`, `\theequation` = `\Alph{section}\arabic{equation}` (aastex701.cls:7878-7888); float counters not reset |
| footnotes | aastex701-sample.tex:116, 251, 274, 295, 510; aastex701.cls:7557-7570 | `fn.kernel` | `\footnote`; class sets `\footnotesep` 12pt, `\skip\footins` 24pt, `\footnoterule` removed, `\@makefntext` hangs the mark in 3mm |
| figure float | aastex701-sample.tex:288-292; aastex701.cls:3594-3640, 6190-6200, 8178-8184 | `fig.graphicx`, `fig.class-native` | `figure*[ht!]` (placement default `tbp`), `\plotone{file}` = `\centering` + `\includegraphics[width=0.85\linewidth*\eps@scaling]`; `\label` inside the caption argument |
| captions | aastex701-sample.tex:290-291; aastex701.cls:6224, 8450-8473, 12625-12632 | `cap.kernel` | `\caption{}` redefined over hyperref's: label `{\bf Figure~N}` (`\fnum@figure`) then `.`, `\small`, centred when it fits one line, `\digitalasset` boxes it with `\fcolorbox{ltblue}{white}` (aastex701.cls:13622-13630), label in table captions `Table` + Roman number (aastex701.cls:6234-6241) |
| tables | aastex701-sample.tex:420-454, 458-484; aastex701.cls:8269, 8411, 8527, 11296, 11385, 11703, 11785, 11964, 12035, 13638 | `class.aastex701`, `tbl.tabular`, `tbl.longtable` | native `deluxetable*` and `splitdeluxetable*{lccccBcccccBcccc}` (column spec of `array` plus the class's `B` break letter), `\tabletypesize{\scriptsize}`, `\tablewidth{0pt}`, `\tablecaption`, `\tablehead{\colhead..}` (strut `\vrule depth 6pt height 12pt`), `\colnumbers`, `\startdata`/`\enddata`, `\nodata` = `~$\cdots$~`, `\tablecomments` (`\small`, small-caps `Note`); class loads `array` and `longtable` unconditionally (aastex701.cls:8685, 8716); `\startlongtable` selects the longtable path (aastex701.cls:11279) |
| rotated tables | aastex701-sample.tex:660-662 (text only); aastex701.cls:11416, 12212-12280 | `fig.rotating` | class loads `rotating[figuresright]`; `rotatetable` and `longrotatetable` rotate 90 degrees; not instantiated in the sample |
| display equation | aastex701-sample.tex:637-639; aastex701.cls:6911-6912, 5602-5610 | `math.kernel`, `math.amssymb` | kernel `equation`; class requires `latexsym` and `amssymb`; `amsmath` only under the class option `amsmath` |
| cross-references | aastex701-sample.tex:249, 295-296, 321 | `xref.kernel` | `\label`, `\ref`; link colour from `meta.hyperref` above |
| revision marks | aastex701-sample.tex:537-539; aastex701.cls:12464, 12470-12492, 12519-12527 | `class.aastex701`, `mark.kernel` | `\added{}` (option `trackchanges`): `{\color{trackchange}\bf #1}` plus a hypertarget; without the option it prints the text plain; `\deleted` and `\replaced` stop with an error |
| citations | aastex701-sample.tex:253, 257, 559, 615; aastex701.cls:6421, 6914-6915 | `bib.natbib` | `\RequirePackage[sort&compress]{natbib}`, `\bibpunct{(}{)}{;}{a}{}{,}`, `\@citestyle{aas}` (author-year, round brackets); `\citep`, `\citet` |
| bibliography | aastex701-sample.tex:685-686; aastex701.cls:7955-7990; aasjournalv7.bst:1-60, 1548-1912 | `bib.bibtex-bst` | `\bibliographystyle{aasjournalv7}`, `\bibliography{aastex701-sample}{}`; class `thebibliography` prints `REFERENCES` centred, `\small`, two columns, hanging 1em, `\hyphenpenalty=10000`; `.bst` is the AAS style, `longbib` selects titles |
| case and underline | aastex701.cls:5591, 12545; aastex701-sample.tex:383 | `mark.case`, `mark.ulem` | `\RequirePackage[overload]{textcase}`; `\usepackage[normalem]{ulem}`; the sample's `\underline` is the kernel command |

Class-loaded helpers with no printed effect and no lib line: `ifthen` (aastex701.cls:7828), `epsf` (aastex701.cls:6927), `latexsym` (aastex701.cls:6911). Load-only, as the rejected `sys.compat-load` of v4; no proposal.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\vdag` | aastex701-sample.tex:77 | yes | alias for `(v)^\dagger`, never called in the body; inline expansion (`math.kernel`) |
| `\aastex` | aastex701-sample.tex:78 | yes | alias for `AAS\TeX`; inline expansion with the kernel `\TeX` |
| `\latex` | aastex701-sample.tex:79 | yes | alias for `La\TeX`; inline expansion |
| `aastex701.cls` internals (`\@sect`, `\@makecaption`, `\@makefntext`, deluxetable parser, `\added`, author machinery) | aastex701.cls:7583-7660, 8450, 7567, 11296ff, 12470ff | not bespoke | the file is the published class (W1: AAS kit, on CTAN); its code is the way's own, and the emitter writes `\documentclass[...]{aastex701}` plus the class's commands, copying none of it |
| `aasjournalv7.bst` | aasjournalv7.bst:1-1915 | not bespoke | the AAS's own BibTeX style, listed in the kit manifest (README:8-9); the `.bst` is the parameter of `bib.bibtex-bst` |

## Content-opaque
- Figure artwork `AuthorChargeInfographic.png` (aastex701-sample.tex:289) and the ORCID icon `orcid-ID.png` (aastex701.cls:12698): image assets, both shipped in the zip. `CoFirstAuthor.png` is optional (`\IfFileExists`, aastex701.cls:12687) and not shipped.
- Table data rows with `$\pm$` and `\nodata` cells (aastex701-sample.tex:440-447, 466-479); the `.bib` entries (aastex701-sample.bib).

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes for the emitter (class rules read, not compiled)
- The class stops with an error for an author without `\affiliation` or `\email` (aastex701.cls:7370-7372), and at end of document when no `contribution` environment exists (aastex701.cls:7846-7851); `\listofchanges`, `\deleted` and `\replaced` also stop (aastex701.cls:12519-12527 and aastex701.cls:12540-12542). The emitter has to follow these rules.
- Scoped blockers if the verdict were re-read under a stricter definition (class internals counted as bespoke): `BESPOKE/class` aastex701.cls (13759 lines, output routine and table engine), partly read.
- No text addressed to an AI was found in the files read.
