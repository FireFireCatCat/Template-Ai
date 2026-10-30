yes

# 0076-utlis-llls-depp-thesis-template: LLLS/DEPP thesis template (University of Tokyo, master and graduation thesis, jsbook)

- Unverified: read from the source, not compiled.
- Source: Source/0076-utlis-llls-depp-thesis-template/ (origin: https://codeload.github.com/utlis/llls_depp-thesis_template/zip/refs/heads/master; licence: not established, no LICENSE file; the readmes say the file may be used freely and reposted with the copyright holder and distributor named, LaTeX/readme-master.txt:9,17 and LaTeX/readme-graduation.txt:9,16)
- Kind: thesis (the manifest hint says thesis; both samples are Japanese thesis templates that double as their own writing guide)
- Lib: v1
- Engine: needs the pTeX family (pLaTeX2e or upLaTeX). `jsbook` is a Japanese class made for ASCII pTeX (CTAN `jsclasses` page), the authors worked with ptetex3 (LaTeX/readme-master.txt:13), and all running text is Japanese with no CJK package loaded. Not pdfLaTeX, XeLaTeX or LuaLaTeX as written; the lib's engine column has only `pdf` and `xe/lua`, so this would be a third tag (`ptex`). Recorded, not a blocker (rubric).
- Look carried by: mixed (jsbook's own defaults give headings, ToC, lists, captions and the bibliography heading; the preamble adds `\pagestyle{plain}` and `\textwidth=\fullwidth`; the title page is hand-laid in the sample body with size switches, `\bigskip` and `center`)
- Class origin: tex-distribution-unbundled (`jsbook` is in CTAN package `jsclasses`, contained in TeX Live; the zip ships no .cls or .sty; one ctan.org/pkg/jsclasses read made)
- Main file: LaTeX/master_thesis.tex (other samples: LaTeX/graduation_thesis.tex, same preamble)
- Read: main yes (master_thesis.tex 1-530 in full; graduation_thesis.tex by a full diff against the main plus lines 26-82, 133-137, 159-163 and a grep of its constructs), zip-local classes and styles none present

## Verdict
Yes. The zip holds no class, style, package or macro of its own: the whole preamble is five lines (`jsbook` with four options, `graphicx` and `enumerate`, `\pagestyle`, two `\setlength`), and there is no `\newcommand`, `\def`, environment or counter outside `verbatim` text. The look comes from the published class `jsbook` plus kernel commands: a hand-laid title page, `\tableofcontents`, `\chapter` and below, `quote`, `description`, `enumerate`, one figure, one table, `thebibliography`. There is no artwork and no tool outside TeX. The one unusual fact is the engine: Japanese text under `jsbook` needs a pTeX-family engine, which Flouest's pdfTeX is not. The rubric records the engine and does not count it as a blocker, so the `yes` holds only if the emitter may target pLaTeX or upLaTeX; it also rests on `jsbook`'s source not being read.

## Blockers
none

## Class setting
- Class: `class.jsbook` options: `a4paper`, `11pt`, `oneside`, `openany` (LaTeX/master_thesis.tex:21; LaTeX/graduation_thesis.tex:31). `jsarticle` is named only in prose (master_thesis.tex:149-150 as an example; graduation_thesis.tex:136; readme-graduation.txt:11), never loaded; both samples load `jsbook`, so the graduation readme and its file disagree.
- Class-native vocabulary used: `\chapter` (master_thesis.tex:67,86; graduation_thesis.tex:80,102,524), `\section`, `\subsection`, `\subsubsection`, `\subsubsection*` (master_thesis.tex:299,320,371,381), the length `\fullwidth` (master_thesis.tex:24), `\tableofcontents` (master_thesis.tex:60). The sample says `\subsubsection` gets no number and no ToC entry (master_thesis.tex:282), which points at the class defaults for `secnumdepth` and `tocdepth`; not checked in the class source.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | master_thesis.tex:21 | `class.jsbook` | a4paper, 11pt, oneside, openany |
| paper, size, sidedness, chapter opening | master_thesis.tex:21 | `page.class-options` | a4paper, 11pt, oneside, openany (all class options) |
| text width and side margins | master_thesis.tex:24-25 | `page.setlength` | `\textwidth` = `\fullwidth` (jsbook length); `\evensidemargin` = `\oddsidemargin` |
| default page style | master_thesis.tex:23 | `hf.pagestyle-kernel` | `\pagestyle{plain}` |
| pages without a number | master_thesis.tex:27,52,59,68,87,522 | `hf.pagestyle-kernel` | `\thispagestyle{empty}` on the title page, the blank page, the ToC page, each chapter-opening page in the sample and the bibliography page (graduation_thesis.tex:37,65,72,81) |
| page counter | master_thesis.tex:56-57,64-65 | `pgnum.pagenumbering` | `\pagenumbering{roman}` + `\setcounter{page}{0}` before the ToC; `\pagenumbering{arabic}` + `\setcounter{page}{1}` before the body |
| title page | master_thesis.tex:28-50 | `front.titlepage-env` | no `titlepage` environment in the sample: loose text after `\thispagestyle{empty}`, one page, ended by `\newpage`; an emitter would wrap the same content in `titlepage` (same one-page, empty-style result assumed, not checked). Lines: type and year, title, subtitle, affiliation, student number and name, supervisor (graduation has no supervisor line, graduation_thesis.tex:38-62) |
| title page alignment | master_thesis.tex:33-35,37-39,43-49 | `sp.ragged` | `center` environment, one per block |
| title page type sizes | master_thesis.tex:29,32,36,42,50 | `font.size-commands` | `\large`, `\LARGE`, `\Large`, `\normalsize`; graduation: `\LARGE`, `\Large`, `\LARGE` (graduation_thesis.tex:41,49,55,59) |
| title page vertical spacing | master_thesis.tex:31,40-41 | `sp.manual-space` | runs of `\bigskip`: 7, then 10 and 9; graduation 1, 7, 10 and 9 (graduation_thesis.tex:40,45,53-54) |
| blank second page | master_thesis.tex:51-54 | `pg.break` | `\newpage`, empty page style, one full-width space (U+3000) as the only content, `\newpage` (reduces to `\null`; the space is a content filler) |
| page break after ToC | master_thesis.tex:61 | `pg.break` | `\newpage` (graduation has a second one, graduation_thesis.tex:74) |
| table of contents | master_thesis.tex:59-60 | `toc.kernel` | `\tableofcontents`, after `\thispagestyle{empty}`; no list of figures or tables |
| headings | master_thesis.tex:67-69,86-90,270,296,299 | `head.class-native` | `\chapter`, `\section`, `\subsection`, `\subsubsection`; no `\titleformat`, no `\renewcommand` of any heading; the sample's history says it was set to start each chapter on a new page (master_thesis.tex:9-10) |
| numbered list | master_thesis.tex:103-109,168-178 | `list.kernel` | `enumerate`, nested to two levels |
| list with a label template | master_thesis.tex:272-280 | `list.enumerate-pkg` | `[1.]`, `[1.1]`, `[1.1.1]` as the optional argument of three nested `enumerate` |
| description list | master_thesis.tex:354-359 | `list.kernel` | `description` with four bracketed labels |
| quotation | master_thesis.tex:383,432,450,468,485,506 | `quote.kernel` | `quote` (`quotation` is mentioned in prose only, master_thesis.tex:363-364) |
| footnotes | master_thesis.tex:151-153,282 | `fn.kernel` | `\footnote{...}` twice |
| inline marks and logos | master_thesis.tex:70,80,357,436,453 | `mark.kernel` | `\textit`, `\textregistered{}`, `\LaTeX{}`, `\TeX{}`, `\&`, ``` `` '' ``` quotes, `~` before `\cite` |
| manual spacing in text | master_thesis.tex:152,374,427-428,442,444,462-463 | `sp.manual-space` | `\hspace{-.75em}`, `\\\ `, `\bigskip` and `\noindent{}` inside running text |
| inline maths symbols | master_thesis.tex:152,462,465 | `math.kernel` | `$\backslash$`, `$<$`, `$>$` as text symbols; no equation |
| figure | master_thesis.tex:312-317 | `fig.graphicx` | `figure[ht]` + `center` + `\includegraphics[width=120pt]{test.eps}` (test.eps ships in LaTeX/) |
| table | master_thesis.tex:337-348 | `tbl.tabular` | `table[ht!]` + `center` + `tabular{ccc}` with `\hline` above the header, below the header and below each row (graduation: no rule between the three body rows, graduation_thesis.tex:352-359) |
| captions | master_thesis.tex:316,346 | `cap.kernel` | `\caption` after the image and after the `tabular` (below both) |
| cross-references | master_thesis.tex:248,270; graduation_thesis.tex:359,365 | `xref.kernel` | `\label{sections}` / `\ref{sections}`; `\label{tab:sign}` / `\ref{tab:sign}` |
| code listings (documentation) | master_thesis.tex:96-98,116-118,156-158,303-310,324-335 | `code.verbatim` | 16 `verbatim` environments in all, and `\verb|...|` (140,213,232); no `listings`, no `minted` |
| citations | master_thesis.tex:374,391 | `bib.thebibliography` | `\cite[p. 19]{澤田}` with a page note; the key is non-ASCII (also at 523) |
| bibliography | master_thesis.tex:521-525 | `bib.thebibliography` | `thebibliography{10}`, one `\bibitem`, after `\thispagestyle{empty}`; no BibTeX, no `.bst`, no natbib; the sample says BibTeX is optional (master_thesis.tex:420-422) |
| language | master_thesis.tex:70-72 and all running text | `class.jsbook` | Japanese typesetting comes from the pTeX engine and the class, not from a package; the sample sets nothing language-specific (no `babel`, no CJK package, no kanji-spacing command) |
| fonts | master_thesis.tex:21-25 | `class.jsbook` | no font package loaded; faces are whatever the class and engine choose (not read) |

Not present in the sample, so not mapped: header/footer package, colour, background, hyperref, index, glossary, appendix, theorems, algorithms, boxes, abstract, keywords.

## Bespoke code
none. A grep of both samples for `newcommand`, `renewcommand`, `providecommand`, `\def`, `\let`, `newenvironment`, `newcounter`, `newif` and `makeatletter` found none. No zip-local .cls, .sty, .def, .cfg, .clo, .bst or .dtx exists. The other files are test.eps, two PDFs (not read), two readmes, the Word versions (not LaTeX, not analysed) and a .gitignore.

## Content-opaque
none (test.eps is an included image inside a `figure`, held by `fig.graphicx`; an asset to ship, not an unmapped construct)

## Lib changes
- New ways proposed: none. The look is `class.jsbook` (a class way, written plainly) plus ways already in the lib. Note for the consolidator: `jsbook` needs the pTeX family, a third engine tag beside `pdf` and `xe/lua`. This zip declares no Japanese setting of its own, so it does not need a separate language way; `lang.cjk` (xeCJK or ctex) would only matter for a port to another engine, which would also swap the class (for example `ltjsbook`), not for reading this zip.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Compile-environment notes (not blockers)
- Both samples are UTF-8 (`file` output); older pLaTeX needs a kanji-encoding switch, upLaTeX does not. Not checked.
- `\includegraphics` of an .eps with no driver option (master_thesis.tex:314) relies on the pTeX plus dvipdfmx toolchain to pick a driver and convert; assumed, not checked. The two shipped PDFs were not opened, so the engine rests on the readme and the CTAN page.
