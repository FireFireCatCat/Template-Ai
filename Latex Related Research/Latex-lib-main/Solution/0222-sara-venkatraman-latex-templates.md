yes

# 0222-sara-venkatraman-latex-templates: S. Venkatraman LaTeX templates (CV x2, resume, lecture notes, homework, research paper, essay, presentation)

- Unverified: read from the source, not compiled.
- Source: Source/0222-sara-venkatraman-latex-templates/ (origin: https://codeload.github.com/sara-venkatraman/LaTeX-Templates/zip/refs/heads/master; licence: MIT, LICENSE:1)
- Kind: misc (a collection of seven separate templates; the manifest main sample is a cv)
- Lib: v2
- Engine: pdfLaTeX-compatible (no fontspec, unicode-math or luacode in any sample)
- Look carried by: preamble (no zip-local class or style exists; each sample is `article` or `beamer` plus published packages and `\newcommand` aliases in its own preamble)
- Class origin: tex-distribution-unbundled (`article` and `beamer`; neither is in the zip, their source was not read)
- Main file: CV - Version 2/CVTemplate2.tex (other samples: CV - Version 1/CVTemplate1.tex, Resume/ResumeTemplate.tex, Lecture Notes/Main.tex with Lecture Notes/Lectures/Lecture1.tex, Homework/HomeworkTemplate.tex, Research Paper/Main.tex with Research Paper/TeX/Abstract.tex, Introduction.tex, References.bib, Essay/EssayTemplate.tex, Presentation/PresentationTemplate.tex)
- Read: main yes (all seven samples and the three sub-files read in full, 1609 lines), zip-local classes and styles none present (the zip has no .cls, .sty, .def, .cfg or .clo)
- Packages not in the zip but needed: `pythonhighlight` (CTAN and TeX Live, Olivier Verdier; a listings-based Python style, ctan.org/pkg/pythonhighlight) and the BibTeX style `apalike2` (CTAN `biblio/bibtex/contrib/apalike2`, TeX Live, ctan.org/pkg/apalike2). Both are published, so W1 holds.

## Verdict
Yes. Seven independent documents, each a kernel `article` or `beamer` class with a preamble of published packages (geometry, fancyhdr, titlesec, sectsty, tocloft, enumitem, amsthm, listings, caption, marginnote, scrextend, longtable, beamer templates) set by option values. All bespoke code is `\newcommand`/`\let`/`\DeclareMathOperator`/`\renewenvironment` aliases over kernel, amsmath and published hooks, each reducible below. There is no TikZ, no picture environment, no zip-local class or style, and no tool outside TeX beyond BibTeX (which is `bib.bibtex-bst`). The least declarative item is the tocloft number-swallow hack (Lecture Notes/Main.tex:73-76), judged reducible as published hook values over a kernel box. Two heading packages are loaded together in Resume (titlesec and sectsty, ResumeTemplate.tex:10), a compatibility question that was not tested here.

## Blockers
none

## Class setting
- Class: `class.article` options: `letterpaper` plus `10pt` (CVTemplate1.tex:5), `11pt` (CVTemplate2.tex:5, HomeworkTemplate.tex:5, EssayTemplate.tex:5, Research Paper/Main.tex:5) or `12pt` (Lecture Notes/Main.tex:5, ResumeTemplate.tex:5)
- Class: `class.beamer` options: `dvipsnames`, `handout` (PresentationTemplate.tex:6)
- Class-native vocabulary used: article: `\title` `\author` `\date` `\maketitle` `\tableofcontents` `\section[short]{long}` `\subsection*` `abstract` `quote` `center` `thebibliography`/`\bibitem` `\bibliography`/`\bibliographystyle` `\refname` `\abstractname` `\today`. beamer: `\usetheme` `\setbeamercovered` `\setbeamersize` `\setbeamertemplate` `\setbeamercolor` `\setbeamerfont` `\subtitle` `\institute` `frame` `\titlepage` `\framesubtitle` `\pause` `\beamertemplatearticlebibitems` (PresentationTemplate.tex:6-34, 61-66, 153-160, 173-174, 199)

## Component map
Short names: CV1 = CV - Version 1/CVTemplate1.tex, CV2 = CV - Version 2/CVTemplate2.tex, HW = Homework/HomeworkTemplate.tex, ES = Essay/EssayTemplate.tex, RS = Resume/ResumeTemplate.tex, PR = Presentation/PresentationTemplate.tex, LN = Lecture Notes/Main.tex, RP = Research Paper/Main.tex.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class (six samples) | CV1:5, CV2:5, HW:5, ES:5, RS:5, LN:5, RP:5 | `class.article` | see Class setting |
| document class (slides) | PR:6 | `class.beamer` | dvipsnames, handout |
| paper and point size | same lines | `page.class-options` | letterpaper; 10pt, 11pt, 12pt |
| page geometry | CV2:14 | `page.geometry` | left=1in, right=1in, bottom=0.7in, top=0.7in |
| page geometry (dates in left margin) | CV1:14 | `page.geometry` | top=0.8in, bottom=0.8in, outer=1in, inner=2.1in, marginparwidth=1in, marginparsep=0.8cm |
| page geometry | HW:18 | `page.geometry` | left=1.35in, right=1.35in, bottom=1in, top=1.1in, headsep=0.2in |
| page geometry | ES:20 | `page.geometry` | left=1.2in, right=1.2in, top=.9in, bottom=.9in |
| page geometry | LN:28 | `page.geometry` | left=1.35in, right=1.35in, top=1.0in, bottom=.9in, headsep=.2in, footskip=0.35in |
| page geometry | RP:21 | `page.geometry` | left=1.15in, right=1.15in, top=1.2in, bottom=1in, headsep=.25in |
| page geometry | RS:15 | `page.geometry` | left=0.8in, right=0.8in, bottom=0.5in, top=0.6in |
| slide text margins | PR:21 | `slide.beamer-template` | `\setbeamersize{text margin left=12mm, text margin right=12mm}` (a `\setbeamer...` declaration, filed with the template family; no separate line exists for sizes) |
| line spacing | CV2:17, CV1:17, HW:24, ES:26, LN:34, RP:27, RS:18, PR:18 | `sp.linespread` | `\baselinestretch` 1.15, 1.4, 1.2, 1.2, 1.2, 1.12, 1.1, 1.15 |
| paragraph spacing and indent, table column sep | HW:27, ES:29, LN:37, RP:30, RS:21, RS:24, CV1:33, CV2:60 | `sp.lengths` | `\parskip` 1.5mm, 2mm, 1.3mm, 1.5mm, 1.5mm; `\parindent` 0pt (RS, CV1); `\tabcolsep` 8pt (CV2) |
| local spacing | PR:30, PR:164-166, RS:10, RS:65-71, CV2:9 | `sp.setspace` | `spacing{1.2}`, `singlespace` (CV2 loads it, never calls it) |
| hyphenation off for section labels | CV2:9, CV2:67, CV2:109, CV2:127, CV2:214 | `sp.hyphenat` | `\nohyphens{...}` around the label cell |
| manual spacing | CV1:55, CV1:36, CV2:42, CV2:47-48, CV2:74, RS:61, RP:186, LN:204, LN:210, PR:161 | `sp.manual-space` | `\bigskip\bigskip`, `\medskip`, `\vspace{0.5cm}`, `\hspace{0.55in}`, `\hfill`, `\vspace{-1cm}`, `\\[1em]`, `\vspace{-1ex}`, `\vspace{-1.2cm}` |
| centred blocks | CV2:43-55, ES:42-45, PR:162-167 | `sp.ragged` | `center` environment (the kernel `\centering` family) |
| text font Libertine | CV2:26, RS:36 | `font.libertine` | `libertine` |
| math font | CV2:27 | `font.newtx` | `newtxmath` with option `libertine` (math only) |
| text font Palatino | CV1:30; LN:23 | `font.palatino` | `palatino`; `newpxtext`, `newpxmath` (the package is the parameter) |
| mono font | HW:12, LN:15, LN:23, RP:12 | `font.mono` | `inconsolata` |
| font sizes | CV2:37-38, CV1:36, CV1:47, RS:51, PR:65-66, LN:52, RP:38 | `font.size-commands` | `\Huge`, `\footnotesize`, `\large`, `\huge`, `\fontsize{15}{16}`, `\fontsize{19}{19}\selectfont`, `\fontsize{13}{15}\selectfont` |
| section-sign glyph | LN:52 | `font.fontenc-t1` | textcomp `\textreferencemark` as the section label |
| colour sets | CV2:22, CV1:26, LN:10, PR:38, RS:32 | `color.xcolor` | `dvipsnames`; names RoyalBlue, OliveGreen (CV2:67 and later), Mahogany (CV1:36), Blue (PR:154), MidnightBlue (RS:33) |
| colour definitions | PR:41, PR:44 | `color.xcolor` | `\definecolor{background}{HTML}{edebe4}`, `\definecolor{titleText}{HTML}{B40404}`; alternatives are comments (PR:48-58) |
| legacy colour | HW:12, HW:48-50, LN:15, RP:12, RP:56-58 | `color.color` | `color` plus `\definecolor{greenText}{rgb}{0.5,0.7,0.5}`, greyText, codeFrame |
| link colours and metadata | CV2:23, CV1:27, HW:39, ES:34, LN:48, RP:45, RS:33 | `meta.hyperref` | `colorlinks=true`; linkcolor, citecolor, urlcolor values per file |
| link text | CV1:49, CV2:130, RS:53, RS:67 | `meta.hyperref` | `\href{url}{text}` |
| link from header to toc | LN:196, LN:215 | `xref.hyperref`, `xref.kernel` | `\hyperref[sec:contents]{...}`, `\label{sec:contents}` after `\tableofcontents` |
| running head and foot | HW:167-175 | `hf.fancyhdr` | `\pagestyle{fancy}`, footrulewidth 0pt, headrulewidth 0.4pt, `\lhead`, `\rhead` |
| running head | LN:187-196 | `hf.fancyhdr` | headrulewidth 0pt, footrulewidth 0pt, `\fancyhead[R]{\small\textit{\nouppercase{\rightmark}}}`, `\fancyhead[L]{...}`; `\sectionmark` redefined to `\markright` (LN:192) |
| running head | RP:164-172 | `hf.fancyhdr` | rules 0pt, `\chead{\MakeUppercase{\scriptsize ...}}`, `\lhead{}\rhead{}` |
| page numbers off | CV2:30, CV1:39, RS:43 | `pgnum.pagenumbering` | `\pagenumbering{gobble}` |
| slide footer and nav symbols | PR:24, PR:27 | `slide.beamer-template` | `footline` `[frame number]`, `navigation symbols` empty |
| title block | LN:204-215 | `front.maketitle` | `\title` with `\\[1em]` and `\normalsize` subtitle, `\author{\normalsize}`, `\date{\normalsize\vspace{-1ex} Last updated: \today}` |
| title block | RP:180-186 | `front.maketitle` | `\title{\normalsize\MakeUppercase{\bfseries}}`, `\author{\small\MakeUppercase}`, `\date{\footnotesize\MakeUppercase\today}`, `\vspace{-1cm}` |
| hand-laid name and contact lines | CV2:37-38, CV2:44-54, CV1:47-53, RS:51-53, ES:42-45 | `font.size-commands`, `mark.kernel`, `sp.manual-space`, `tbl.tabular` | name in `\Huge`/`\huge`; `\hfill{\it\footnotesize Updated \today}`; contact grid `tabular{lll}` with `\hspace` pads; essay title in `center` with `\textbf` |
| slide title page | PR:153-168 | `class.beamer` (native vocabulary) | `\title{\color{titleText}...}`, `\subtitle{\color{Blue}...}`, `\author`, `\institute{\small}`, `\date{}`, `\titlepage`; logo `\includegraphics[width=2.3cm]{Cornell}` |
| abstract | RP:48-50, Research Paper/TeX/Abstract.tex:3-5 | `abs.kernel`, `quote.kernel`, `font.size-commands`, `mark.kernel` | `\renewenvironment{abstract}` = `\small` + `quote` + `\noindent{\sc \abstractname.}` (reduction in Bespoke code) |
| table of contents | LN:215 | `toc.kernel` | `\tableofcontents` |
| toc styling | LN:61-70 | `toc.tocloft` | option `subfigure`; `\cftbeforesecskip`=.9ex; `\cftsetindents{section}{0em}{0em}`; `\cfttoctitlefont`=`\large\bfseries` |
| toc without section numbers | LN:73-76 | `toc.tocloft` | `\cftsecpresnum`=`\begin{lrbox}{\@tempboxa}`, `\cftsecaftersnum`=`\end{lrbox}` (reduction in Bespoke code) |
| sectioning, kernel | HW:180, Lecture Notes/Lectures/Lecture1.tex:4, :6, :10, Research Paper/TeX/Introduction.tex:3 | `head.kernel` | `\subsection*`, `\section[toc and running-head title]{printed title}`, `\subsection`, `\section` |
| heading formats | LN:52-53 | `head.titlesec` | `\titleformat{\section}{\large\bfseries}{{\fontsize{19}{19}\selectfont\textreferencemark}\;\; }{0em}{}`; `\titleformat{\subsection}{\normalsize\bfseries\selectfont}{\thesubsection\;\;\;}{0em}{}` |
| heading spacing | RS:39 | `head.titlesec` | `\titlespacing*{\section}{0pt}{0.8em}{0.1em}` |
| heading fonts | RP:38-39, RS:40 | `head.sectsty` | `\sectionfont{\fontsize{13}{15}\selectfont}`, `\subsectionfont{\fontsize{11}{15}\selectfont}`; `\sectionfont{\large\normalfont\scshape\selectfont}` |
| unnumbered styled section line | CV1:36, CV1:59 and later `\heading{...}` | `font.size-commands`, `color.xcolor`, `sp.manual-space` | alias `{\large\color{Mahogany} #1}\medskip` (no sectioning command, no toc entry) |
| CV entries, two-column table | CV2:60-63, CV2:67-214 | `tbl.longtable`, `color.xcolor`, `sp.manual-space` | `longtable{p{1.3in}p{4.8in}}`; section label `\color{OliveGreen}` in column 1; entry lines separated by `\\`, blank `& \\` rows as spacing, `\hfill` for right-aligned dates |
| CV dates in left margin | CV1:20-21, CV1:69 and later | `note.marginnote`, `note.marginpar` | `marginnote` package, `\reversemarginpar`, `\marginnote{2019 -- Present}` |
| indented CV block | RS:27, RS:59, RS:61-63 | `list.scrextend` | `\begin{addmargin}[1em]{0em}` |
| lists, flush-left labels | HW:33-34, LN:57 | `list.enumitem` | `\setlist[enumerate]{wide=0pt, leftmargin=21pt, labelwidth=0pt, align=left}`, `\setenumerate[1]{label={(\arabic*)}}`; `\setlist[itemize]{wide=0pt, leftmargin=16pt, labelwidth=10pt, align=left}` |
| lists, packages loaded | HW:13, LN:16, RP:13, CV2:9 | `list.enumerate-pkg`, `list.enumitem` | `enumerate`, `enumitem` loaded, not exercised in RP or CV2 |
| bulleted list | PR:177-180, CV2:91-95 (commented) | `list.kernel` | `itemize`; beamer bullets `$\bullet$`, `$\circ$` set at PR:33-34 |
| slide bullets | PR:33-34 | `slide.beamer-template` | `itemize item`, `itemize subitem` |
| footnotes at page bottom | HW:21, ES:23, LN:31, RP:24 | `fn.footmisc` | option `bottom` |
| underline | RS:10, RS:67, RS:69 | `mark.ulem` | `soul` `\ul{...}` |
| bold, italic, small caps | CV2:46, CV2:112, RP:49 | `mark.kernel` | `\textbf`, `\textit`, `\it`, `\sc` |
| math packages | HW:10, LN:13, RP:10 | `math.amsmath`, `math.mathtools`, `math.amssymb`, `math.bm` | `amsmath`, `mathtools`, `amssymb`; `dsfont` (`\mathds`), `euscript[mathscr]` (HW:87, LN:98, RP:95, PR:84) |
| split display math | HW:30, LN:40, RP:33 | `math.amsmath` | `\allowdisplaybreaks` |
| display math | HW:198-200, PR:183-185 | `math.kernel`, `math.amsmath` | `$$...$$`; `align*` |
| units package | LN:13, RP:10 | `mark.siunitx` | `units` loaded, never called (the same kind of component: unit typesetting; `siunitx` is the lib's example) |
| theorem-like statements | HW:144-162, LN:164-182, RP:152-159 | `thm.amsthm` | `\theoremstyle{definition}`; numbered `theorem` within `section`; proposition, lemma, corollary, definition, example, remark share the theorem counter; starred versions plus `claim` (HW:162, LN:182) |
| theorem statement used | HW:196-201 | `thm.amsthm` | `theorem*` with optional name `[Leibniz integral rule]` |
| equation tag | HW:75, LN:86, PR:72, RP:83 | `num.counters`, `math.amsmath` | `\numberthis` = `\addtocounter{equation}{1}\tag{\theequation}` |
| figures, images | PR:163, PR:189-193, LN:80 | `fig.graphicx` | `\includegraphics[width=2.3cm]{Cornell}`, `[width=7cm]{ExampleImage}`, `\graphicspath{{Images/}{../Images/}}` |
| float, wrapfig, subfig loaded | HW:11, LN:14, RP:11 | `fig.float`, `fig.wrapfig`, `fig.subcaption` | loaded, not exercised; `[H]` only inside a beamer frame (PR:190) |
| caption style | LN:45 | `cap.caption` | `font={it,footnotesize}` |
| code listing style | HW:53-69, RP:61-77 | `code.listings` | `\lstdefinestyle{code}`: frame=single, rulecolor, numbers=left, numbersep=8pt, numberstyle=\tiny\color{greyText}, commentstyle, basicstyle=\linespread{1.1}\ttfamily\footnotesize, showstringspaces=false, xleftmargin=1.95em, framexleftmargin=1.6em, breaklines=true, postbreak; `\lstset{style=code}` |
| code listing used | HW:183-194 | `code.listings` | `lstlisting[language=R, caption={...}, label={...}]` |
| Python style package | HW:12, LN:15, RP:12 | `code.listings` | `pythonhighlight` (listings-based, loaded, not called) |
| framed boxes | LN:16 | `box.mdframed` | `framed` loaded, not called |
| bibliography, hand-written | HW:208-222, LN:226-241, PR:197-213 | `bib.thebibliography` | `thebibliography{2}`, `{1}`, `{10}`; `\bibitem`; PR adds `\beamertemplatearticlebibitems` |
| bibliography heading | HW:42, RP:42 | `bib.thebibliography` | `\renewcommand{\refname}{\large\bf{References}}`, `{\fontsize{13}{15}\selectfont\bf{References}}` |
| bibliography, BibTeX | RP:195-196, Research Paper/TeX/References.bib:1-6, Research Paper/TeX/Introduction.tex:5 | `bib.bibtex-bst` | `\bibliography{TeX/References}`, `\bibliographystyle{apalike2}`, `\cite{wasserman2006all}` |
| slide theme | PR:7 | `slide.beamer-theme` | `\usetheme{default}` |
| slide colours and fonts | PR:61-62, PR:65-66 | `slide.beamer-template` | `\setbeamercolor{frametitle}{bg=background, fg=titleText}`, `{subtitle}{fg=titleText}`; `\setbeamerfont{frametitle}{size=\fontsize{15}{16}}`, `{framesubtitle}{size=\small}` |
| slide overlays | PR:10, PR:6, PR:176, PR:181 | `slide.beamer-mode` | `\setbeamercovered{transparent}`, class option `handout`, `\pause` |

## Bespoke code
All items are zip-local macros in a sample preamble or body; none is a class or style file.

| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\b`, `\bg`, `\mc` aliases | HW:78-84, LN:89-95, PR:75-81, RP:86-92 | yes | `\let` aliases of kernel `\mathbf`, amsmath `\boldsymbol`, kernel `\mathcal` (`math.amsmath`, `math.kernel`); the emitter writes `\mathbf` directly |
| `\numberthis` | HW:75, LN:86, PR:72, RP:83 | yes | `\addtocounter{equation}{1}\tag{\theequation}`: `num.counters` plus amsmath `\tag` |
| `\converge`, `\wconverge`, `\equals`, `\normal`, `\unif`, `\iid`, `\bk` | HW:91-107, LN:102-126, PR:88-112, RP:99-115 | yes | `\newcommand` wrappers of amsmath `\xrightarrow`, kernel `\stackrel`, `\smash`, `\text`, `\mathcal`, `\rightharpoonup`; each is substituted by its expansion |
| set and probability symbols `\R \C \Q \Z \N \F \El \pr \E \var \cov \corr \B \tth \Oh` | HW:110-128, LN:129-148, PR:115-133, RP:118-136 | yes | `\newcommand` of `\mathbb` (amssymb), `\mathcal`, `\text`; `math.amssymb`, `math.kernel` |
| `\1` | HW:129, LN:148, PR:134, RP:137 | yes | `\mathds{1}` from `dsfont` (`math.bm`) |
| `\argmax \argmin \spann \bias \ran \dv \diag \trace \supp` | HW:132-139, LN:151-159, PR:137-145, RP:140-147 | yes | amsmath `\DeclareMathOperator*` calls (`math.amsmath`) |
| `\heading` | CV1:36 | yes | `{\large\color{Mahogany} #1}\medskip` = `font.size-commands` + `color.xcolor` + `sp.manual-space` as a body wrapper around a heading node |
| `abstract` environment redefinition | RP:48-50 | yes | `\small`, kernel `quote`, `\noindent`, `\par`, `{\sc \abstractname.}`, `\noindent`: composition of `font.size-commands`, `quote.kernel`, `mark.kernel`; no conditional, counter or box logic |
| tocloft number swallow | LN:73-76 | yes | `\cftsecpresnum` and `\cftsecaftersnum` are tocloft's documented hook macros (`toc.tocloft`); their values open and close a kernel `lrbox` on the kernel scratch box `\@tempboxa` so the number is typeset into an unused box. No loop, counter or conditional. It needs `\makeatletter`; the emitter prints the two assignments as preamble lines. Least declarative item, not irreducible. |
| `\sectionmark` redefinition | LN:192 | yes | `\renewcommand{\sectionmark}[1]{\markright{#1} }`: the fancyhdr-documented mark hook (`hf.fancyhdr`, `head.kernel`) |
| `\refname` redefinitions | HW:42, RP:42 | yes | string/format assignment of a kernel name macro (`bib.thebibliography`) |
| `\newtheorem` and starred forms | HW:145-162, LN:165-182, RP:153-159 | yes | `thm.amsthm` declarations |
| `\lstdefinestyle{code}`, `\lstset` | HW:53-69, RP:61-77 | yes | `code.listings` key=value style |
| `\setlist`, `\setenumerate` | HW:33-34, LN:57 | yes | `list.enumitem` key=value |
| `\pagenumbering{gobble}` | CV2:30, CV1:39, RS:43 | yes | kernel `\pagenumbering` with the style name `gobble` (kernel `\@gobble`), `pgnum.pagenumbering`; printed as is |
| `\input{...}` file splitting | LN:219, RP:190-191 | yes | not a template component: the emitter inlines the sub-files (Lecture1.tex, Abstract.tex, Introduction.tex) |

## Content-opaque
- Placeholder text from `lipsum` (ES:10, ES:49, LN:19, Lecture Notes/Lectures/Lecture1.tex:8, RP:16, Research Paper/TeX/Introduction.tex:7, Research Paper/TeX/Abstract.tex:4): content, not a way.
- Included pictures: `Presentation/Cornell.pdf` logo (PR:163), `Presentation/ExampleImage.png` (PR:191); `Lecture Notes/Images/*.jpeg` exist but no sample includes them. Assets are shipped in the zip.
- R code text in the listing (HW:184-193), equations, bibliography entries, CV placeholder entries: content.
- Packages loaded and never called, with no effect on output: `everypage` and `ifthen` (CV2:9, no `\AddEverypageHook` or `\ifthenelse` anywhere), `fancyhdr` in CV2 (no `\pagestyle{fancy}` in CV2), and `sectsty` in HW (HW:13) and LN (LN:16) (no `\sectionfont` there). They need no component row.

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
