yes

# 0414-skrapport: skrapport (class documentation and literate source, typeset with skdoc)

- Unverified: read from the source, not compiled.
- Source: Source/0414-skrapport/ (origin: https://mirrors.ctan.org/macros/latex/contrib/skrapport.zip; licence: lppl1.3)
- Kind: misc (a package manual; the zip's subject class `skrapport` is a report class)
- Lib: v5
- Engine: pdfLaTeX-compatible (Makefile:25,30 and README:45 say `pdflatex`; the derived class also has XeLaTeX/LuaLaTeX branches, skrapport.tex:1501-1545, not needed by the sample)
- Look carried by: class (the sample loads the published class `skdoc`, skrapport.tex:28, which is not in the zip; the preamble adds package loads and one table-centring construct)
- Class origin: tex-distribution-unbundled (`skdoc` is on CTAN and in TeX Live, read at ctan.org/pkg/skdoc; its source was not read)
- Main file: skrapport.tex (other samples: none; the zip also holds README, Makefile, skrapport.pdf)
- Read: main yes (all 4381 lines), zip-local classes and styles none present (the ten derived files `skrapport.cls`, `skrapport-size-common.sty`, three `.clo`, five colour-theme `.sty` are not in the zip: they are written out of `MacroCode` blocks inside the main file, which was read in full)

## Verdict
The sample is a literate package manual typeset with the published class `skdoc` (`class.skdoc`, loaded, not bundled, source not read), plus ordinary published packages and kernel constructs. Its own preamble code is three small constructs with no printed effect or a trivial one, each reducible. The zip's subject, the expl3 class `skrapport` (about 3700 lines of `MacroCode` and prose that skdoc writes to ten derived files, hidden from print by `\OnlyDescription`), is the CTAN release of that class by its author, so it counts as one published way, `class.skrapport`, and its code text is content for the sample. That code is internally irreducible (it reimplements `\@startsection`, `\@makecaption`, `\maketitle`, see "Bespoke code"); the `yes` rests on W1 for `skrapport` and on skdoc being a published class whose source was not read. Under a stricter reading that treated the derived files as zip-local this would be `BESPOKE/class` and `no`.

## Blockers
none

## Class setting
- Class: `class.skdoc` options: none (skrapport.tex:28). Zip's subject class: `class.skrapport` (published, CTAN 0.12k; defined by the `MacroCode` blocks at skrapport.tex:638-3778; not loaded by the sample).
- Class-native vocabulary used (skdoc): `\OnlyDescription` (46), `\SelfPreambleTo` (81), `\DeclareFile[key=,preamble=]{file}` x10 (82-97), `\version` (102), `\changes{ver}{text}` (103-132), `\package[ctan=,vcs=]{name}` (137), `\email` (140), `\Option{}\WithValues{}\AndDefault{}` (179, 185, 199, ...), `\DescribeMacro` (331), `\DescribeEnv` (378), `\Theme` (549), `\Notice` (258), `\Warning` (259), inline `\opt \opt* \cs \cs* \env \pkg \file \meta \oarg \thm \Macro` (169, 224, 371, 419, 427, 550, 775), `\thepackage` `\theversion` (138, 624), `\Implementation` (634), environments `MacroCode{key}` `macro` `macro*` `environment` `environment*` `option` `theme` (638, 700, 728, 994, 1208, 1608, 3786), `\Finale` (4361), `\PrintChanges` `\PrintIndex` (4378-4379).
- Class-native vocabulary of the subject class (documented, not used by the sample): options `paper=a4|a5` `twocolumn` `leqno` `fleqn` `indent` `titles=rm|it|bf|sf` `hanging-titles` `color=<theme>` `ptsize=10pt|11pt|12pt` `font=none|kpfonts|lmodern|palatino|minion|skdoc|word` `nomath` `lang=en|sv|de` `draft` (179-312); commands `\date` (331), repeatable `\author[email]{name}` (338), `\regarding` (346), `\license` (351), `\maketitle[hide=,nopdfinfo]` (363), environments `abstract` (378), `titlepage` (383), `figcenter` (467), `\appendix` (445), `\comment` `\note` `\com` (482-484), `\eg \ie \etc \cf \viz \dash` (490-503), `\colortheme{default|unscathed|cruelwater|violet|skdoc}` (509, 549-583).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class of the sample | skrapport.tex:28 | `class.skdoc` | no options; unbundled, source not read |
| page geometry, fonts, running heads, colours of the sample | skrapport.tex:28-97 (none set in the preamble) | `class.skdoc` | carried by the class; the preamble sets no geometry, font, page style or colour |
| doc-markup and file extraction | skrapport.tex:46, 81-97, 102-137, 634, 4361, 4378-4379 | `class.skdoc` | `\OnlyDescription`; `\SelfPreambleTo{\mypreamble}`; ten `\DeclareFile[key=class\|size-common\|size-10\|size-11\|size-12\|theme-*,preamble=\mypreamble]{file}`; `\version{0.12k}`; `\Implementation`; `\Finale` |
| entry blocks and callouts | skrapport.tex:179, 258-259, 331, 378, 549 | `class.skdoc` | `\Option{paper}\WithValues{a4, a5}\AndDefault{a4}`; `\DescribeMacro\date{<ISO8601 date>}`; `\DescribeEnv[..]{abstract}`; `\Theme{default}`; `\Notice{..}`; `\Warning{..}` |
| code blocks | skrapport.tex:638, 700, 728, 994, 1608, 3786 | `class.skdoc` | `MacroCode{class}` (also `size-10,size-11,size-12`, `theme-*`), `macro`, `macro*`, `environment`, `option{name}{values}`, `theme{Default}` |
| title block | skrapport.tex:138-143 | `front.maketitle` | `\title{The \textbf{\thepackage} document class}`, `\author{Simon Sigurdhsson}`, `\maketitle` |
| package metadata fields | skrapport.tex:102, 137, 140 | `front.class-native` | `\version`, `\package[ctan=skrapport,vcs=https://github.com/urdh/skrapport]{skrapport}`, `\email` |
| abstract | skrapport.tex:144-149 | `abs.kernel` | `abstract` environment (look from skdoc, not read) |
| contents | skrapport.tex:150 | `toc.kernel` | `\tableofcontents` |
| headings | skrapport.tex:152, 167, 174, 621, 635, 4362 | `head.kernel` | `\section`, `\subsection`, `\subsubsection`; `\label{sec:issues}` at 621 |
| description list | skrapport.tex:625-629 | `list.kernel` | `description` with `\item[--]` |
| footnotes | skrapport.tex:557, 566, 576, 623 | `fn.kernel` | `\footnote{\url{..}}` |
| urls | skrapport.tex:557, 566, 576, 623 | `meta.url` | `\url{..}` (the sample does not load `url` or `hyperref`; skdoc is assumed to) |
| inline colour | skrapport.tex:558-581 | `color.xcolor` | `\textcolor[HTML]{463335}{dark brown}`, hex model, 13 uses (`xcolor` not loaded by the sample) |
| inline verbatim | skrapport.tex:442 | `code.verbatim` | `\verb\|\\\|` |
| inline marks | skrapport.tex:138, 145, 279 | `mark.kernel` | `\textbf`, `\emph`, `\texttt` |
| table float | skrapport.tex:269-272, 291 | `tbl.tabular` | `table[tp]`, `\centering`, `tabular{lllll}` with `\texttt` cells |
| table rules | skrapport.tex:32, 276, 278, 285 | `tbl.booktabs` | `\toprule \midrule \bottomrule` |
| caption and label | skrapport.tex:271-272 | `cap.kernel` | `\caption{Font stacks provided by \thepackage.}` |
| label of the table | skrapport.tex:272 | `xref.kernel` | `\label{tab:font}` |
| centring a table across the margins | skrapport.tex:32, 273-290 | `box.stackengine` | `\NewCoffin\tempcoffin`, `\SetHorizontalCoffin\tempcoffin{..}`, `\CoffinWidth\tempcoffin`, `\TypesetCoffin\tempcoffin` |
| length arithmetic for that centring | skrapport.tex:32, 273, 288 | `sp.lengths` | `calc` loaded; `\newlength\templength`; `\setlength{\templength}{(\textwidth - \CoffinWidth\tempcoffin)/2}` |
| manual horizontal space | skrapport.tex:289 | `sp.manual-space` | `\hspace*{\templength}` |
| units | skrapport.tex:30-31, 1453 | `mark.siunitx` | `\let\SI\relax` first; `\DeclareSIUnit\point{pt}`; `\SI{0}{\point}` |
| TeX logos | skrapport.tex:32, 108, 244, 267 | `font.icons` | `hologo`: `\hologo{XeLaTeX}`, `\Hologo{LuaLaTeX}` |
| quotation marks | skrapport.tex:34, 164, 221 | `lang.csquotes` | `\enquote{..}` |
| bibliography | skrapport.tex:33, 49-78, 335, 505, 4380 | `bib.biblatex-biber` | `style=authoryear` (default backend biber, Makefile:24); `\addbibresource{skrapport.bib}`; `\footcite{ISO8601}`, `\textcite[\pno~8]{Flynn}`; `\printbibliography` |
| cross-references | skrapport.tex:35, 165, 227, 243, 513 | `xref.varioref` | `\vpageref{sec:issues}`, `\vref{tab:font}` |
| cross-references, load only | skrapport.tex:35 | `xref.cleveref` | `cleveref` loaded, no `\cref` or `\Cref` call in the file |
| change history and index | skrapport.tex:4378-4379; Makefile:15, 23, 26 | `idx.glossaries` | `\PrintChanges`, `\PrintIndex`; inferred from `makeglossaries` in the Makefile, skdoc source not read |
| zip's subject class | skrapport.tex:638-642, 3770-3777; README:17-27 | `class.skrapport` | defaults when no option is given: `indent=false`, `nomath=false`, `color=true` (theme default), `font=kpfonts` (`word` under XeLaTeX), `lang=sv`, `titles=bf`, `draft=false`, `ptsize=11pt`, `paper=a4` (skrapport.tex:1969-1999) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\ExplHack` | skrapport.tex:38-43, used at 634 | yes | two kernel expl3 calls `\char_set_catcode_letter:n{58}` and `{95}`: integer parameters, no printed effect; they make `:` and `_` letters so the `MacroCode` and `macro` arguments of the implementation part read as control sequences. Inline as two `\catcode` assignments after `\Implementation`. Not a component (as the rejected `sys.compat-load` in the lib v4 log) |
| `\let\SI\relax` | skrapport.tex:29 | yes | one kernel `\let` before `\usepackage{siunitx}`, no printed effect (the reason, that the class defines `\SI`, is inferred; skdoc not read) |
| coffin centring of the table | skrapport.tex:273-290 | yes | `box.stackengine` plus `sp.lengths` (calc) plus `sp.manual-space`; the kernel `\makebox[\textwidth][c]{..}` gives the same placement |
| `\mypreamble` and `\SelfPreambleTo` | skrapport.tex:81-97 | yes | skdoc vocabulary (`class.skdoc`); the value is the sample's own preamble text |
| derived class `skrapport.cls` and 9 more files (code text of the `MacroCode` blocks) | skrapport.tex:638-3778 (class), 3788-3904 (five themes), 3915-4359 (size files) | n/a: published (CTAN skrapport 0.12k, the author's release, so `class.skrapport`), not loaded by the sample | recorded so the verdict can be re-read. The code is irreducible expl3 if it were zip-local: `\@startsection` replacement `\__skrapport_generic_section:nnnnn` (2548-2716, comment at 2542-2543), `\maketitle` with measured abstract/e-mail widths and an aux-file boolean written with `\iow_shipout:Nx\@mainaux` (2306-2344, 2349-2399, 2408-2416), `\@makecaption` (3329-3350), toc lines with leaders (3382-3418), two-column mode by patching with `multicol` and `grid` and the `onecol` environment trick (812-1033), per-engine font stacks (1242-1353). It would be `BESPOKE/class` |

## Content-opaque
- The `MacroCode` bodies: expl3 source of the ten derived files (skrapport.tex:638-3778, 3788-3904, 3915-4359), written to files by `\DeclareFile` (82-97) and hidden from print by `\OnlyDescription` (46). Code text, held as content only because the files are the published `class.skrapport`.
- The `filecontents` bibliography entries (skrapport.tex:49-77) and the cell texts of the font-stack table (skrapport.tex:277-284).

## Lib changes
- New ways proposed: `box.stackengine` (`xcoffins`, CTAN bundle `l3experimental`, LPPL 1.3c, read at ctan.org/pkg/xcoffins; pdf, loaded by the sample at skrapport.tex:32 and used under pdfLaTeX per Makefile:25): coffins are boxes with named poles; `\usepackage{xcoffins}` plus body wrappers `\NewCoffin`, `\SetHorizontalCoffin\name{content}`, `\CoffinWidth`, `\TypesetCoffin`, `\JoinCoffins`; W1 published, W2 coffin names, pole names and offset lengths are the parameters, W3 serves any box alignment or measuring task, W4 one preamble line and a body wrapper around a node's content. Considered and not used: `box.stackengine` (stacks or overlays one object on another), `fig.adjustbox` (scales or trims one box). A reader who prefers no new way can use the `\makebox` reduction under "Bespoke code" instead.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
