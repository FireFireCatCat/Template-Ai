no

# 0491-ekspek-ist-thesis: ist-thesis (unofficial Instituto Superior Tecnico master's thesis class and example)

- Unverified: read from the source, not compiled.
- Source: Source/0491-ekspek-ist-thesis/ (origin: https://codeload.github.com/ekspek/ist-thesis/zip/refs/heads/master; licence: LPPL-1.3c, ist-thesis.cls:4-16, README_EN.md:50; the IST logos in graphics/ are IST property, README_EN.md:52)
- Kind: thesis
- Lib: v4
- Engine: pdfLaTeX-compatible (the class branches on the engine: pdfTeX path ist-thesis.cls:116-121, XeLaTeX/LuaLaTeX path with `fontspec` ist-thesis.cls:104-114; the sample header says `arara: pdflatex`, thesis.tex:1)
- Look carried by: zip-local (ist-thesis.cls defines page, fonts, colours, links, cover, front matter, spine; thesis.tex only adds content packages: csquotes, biblatex, glossaries-extra, tikz/pgfplots, lipsum)
- Class origin: zip-local (ctan.org/pkg/ist-thesis is a 404; the class calls itself "Unofficial IST thesis class", ist-thesis.cls:23, README_EN.md:1; it is one student's GitHub class, not an IST release)
- Main file: thesis.tex (other samples: doc/doc.tex, doc/doc_en.tex)
- Read: main yes, zip-local classes and styles all (ist-thesis.cls, 389 lines, read in full; also glossary.tex, main.bib, README_EN.md, doc/doc_en.tex in full; doc/doc.tex only its preamble and minted lines, it is the Portuguese twin)

## Verdict
No. Almost everything the class does reduces to `class.report` plus published packages (geometry, setspace, caption, hyperref, babel, tgheros, inconsolata, newtxsf, tocbibind, totpages, microtype) and hand-laid cover and front-matter environments made of kernel spacing, font and page-break commands. The one thing that does not reduce is `\makespine`, a TikZ overlay in page coordinates (dashed spine outline, rotated logo, rotated title block) that the class defines as part of the template and the sample calls at the end of the document. No lib way holds it, so it is an `ART` blocker. Nothing else blocks: all other bespoke macros are reducible, and no external tool is needed by the class or by thesis.tex.

## Blockers
- `ART/class` `\makespine` draws the spine page with `tikzpicture[remember picture, overlay]`: dashed rectangle between `current page.north` and `current page.south`, rotated logo node, rotated centred title/subtitle/author node (ist-thesis.cls:294-308); called in the sample at thesis.tex:239. Nearest lib line is `bg.tikzpagenodes`, which is ART when it draws the template's identity; a dashed full-height frame plus rotated nodes has no declarative way.
- Not counted toward the verdict (secondary sample only, not the main sample and not loaded by the class): `EXTERNAL/preamble` doc/doc.tex:11 and doc/doc_en.tex:11 load `minted` (`code.minted`, pygments, shell escape; doc_en.tex:1 compiles with lualatex). The class itself never loads minted (checked by reading ist-thesis.cls in full).

## Class setting
- Class: `class.report` (zip-local `ist-thesis` is `\LoadClass{report}` with `twoside` passed to it, ist-thesis.cls:75,79; `portuguese`/`english` are also passed to report, cls:68-69, with no effect on report). Class options of the zip-local class: `portuguese` (default, cls:76), `english`, `origmath`, `bw` (cls:68-71). Sample: `\documentclass[portuguese]{ist-thesis}` (thesis.tex:9). `ist-thesis` itself is not a way (W1 fails: zip-local); its reduction is below.
- Class-native vocabulary used: `\setcoverimage[0.5]{example-image-a}` (thesis.tex:49), `\makecover` (thesis.tex:57), environments `dedication`, `acknowledgements` (thesis.tex:61-69), `tabstract{keywords}` and `fabstract{keywords}` (thesis.tex:74-82), `\mainstart` (thesis.tex:102), `\makespine` (thesis.tex:239). Defined but not used by the sample: `\settitle` `\setsubtitle` `\setauthor` `\setdegree` `\setinstitution` `\setdate` `\setsupervisor` `\setcsupervisor` `\setchairperson` `\setcommittee` `\setcoverbacktext`, `\tand` (cls:195-234). Colours `ist-cyan`, `ist-gray` (cls:149-155).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | ist-thesis.cls:75,79; thesis.tex:9 | `class.report` | twoside |
| paper and class-level options | cls:75,139 | `page.class-options` | twoside (passed to report), a4paper through geometry |
| page geometry | cls:98,139 | `page.geometry` | a4paper, margin=2.5cm (IST regulation) |
| flush bottom | cls:142 | `pg.flush` | `\raggedbottom` |
| line spacing | cls:134,140; cls:285,314 | `sp.setspace` | `\setstretch{1.5}` for the body; `\setstretch{1}` on the cover back page; `\setstretch{1.1}` inside `dedication` |
| page breaks | cls:282,289,295,312,319,331,351,389 | `pg.break` | `\newpage`, `\cleardoublepage` |
| page style | report default (no `\pagestyle` call); cls:283,296 | `hf.pagestyle-kernel` | default `plain`; `\thispagestyle{empty}` on the cover back page and the spine |
| page numbers | cls:238-239,389 | `pgnum.pagenumbering` | roman with `\setcounter{page}{0}` for front matter; `\pagenumbering{arabic}` in `\mainstart` |
| total pages (for a log warning only) | cls:136,175-183 | `pgnum.lastpage` | `totpages` loaded; `\theTotPages` compared with 100, output is a class warning, not printed |
| input encoding, font encoding (pdfTeX path) | cls:117-118 | `font.fontenc-t1` | inputenc utf8, fontenc T1 |
| sans text face (pdfTeX path) | cls:119 | `font.helvet` | tgheros (TeX Gyre Heros, Arial stand-in) |
| default family sans | cls:113,120 | `font.family-default` | `\familydefault` = `\sfdefault` |
| mono face (pdfTeX path) | cls:121 | `font.mono` | inconsolata, scaled=1.14, narrow |
| font setup (XeLaTeX/LuaLaTeX path) | cls:104-114 | `font.fontspec` | fontspec no-math; `\setsansfont` texgyreheros OTF files (guarded by `\IfFontExistsTF`); `\setmonofont[Scale=1.14]{InconsolataN}` |
| math font | cls:130 | `font.helvet` | newtxsf (sans-serif math package, same type as the `sfmath` named on that lib line; nearest alternative `font.newtx`); skipped by option `origmath` |
| font sizes and shapes | cls:246-280,315 | `font.size-commands`, `mark.kernel` | `\LARGE` `\Large` `\large` `\small`; `\bfseries` `\itshape` `\textbf` |
| language | cls:125-127; cls:362,368,378,382 | `lang.babel` | `main=portuguese, british` (or `main=british, portuguese` with `english`); `\selectlanguage` in `fabstract` |
| quotation marks | thesis.tex:19 | `lang.csquotes` | csquotes, default |
| microtypography | cls:132 | `sp.microtype` | defaults |
| colours | cls:96,149-155 | `color.xcolor` | `ist-cyan` cmyk 1,0,0,0; `ist-gray` cmyk 0.2,0,0,0.8 (both cmyk 1,1,1,1 with `bw`); `\textcolor{gray}` on cover back page (cls:287) |
| hyperlinks and PDF metadata | cls:97,158-162,186-192,220-222 | `meta.hyperref` | hidelinks then colorlinks, linkcolor/citecolor/urlcolor=ist-cyan; unicode, pdfcreator, pdflang; pdftitle/pdfsubject/pdfauthor set by the `\set...` commands |
| contents links in black | cls:165-172; thesis.tex:85,88,91 | `meta.hyperref`, `toc.kernel` | body wrapper `{\hypersetup{linkcolor=black} \tableofcontents}` (and `\listoffigures`, `\listoftables`), written at the call site |
| cover page | cls:237-291; thesis.tex:57 | `front.titlepage-env`, `front.class-native` | `titlepage` with logo `\includegraphics[viewport=9.5cm 11cm 0cm 0cm,scale=0.29]{IST_A_CMYK_POS}` (cls:241), `center`, cover image `\includegraphics[width=0.5\linewidth]` (cls:244, from `\setcoverimage`), `\vspace*{17mm}` and `\vspace{10mm}` `\vspace{7mm}` `\vspace{3mm}` `\vspace{\fill}`, title `\LARGE\bfseries`, tabulars `{c c}` and `{r l}` with `\arraystretch` 0.9, language-dependent strings |
| cover back page | cls:282-289 | `front.titlepage-env` | `\newpage`, `\thispagestyle{empty}`, `\vspace*{\fill}`, `\small\setstretch{1}`, `flushleft` with grey text, `\cleardoublepage` |
| cover metadata holders | cls:195-234 | `front.class-native` | `\newrobustcmd` strings with `\renewcommand` setters, expand inline |
| dedication | cls:311-320; thesis.tex:61-63 | `front.dedication`, `sp.ragged`, `sp.manual-space` | `\newpage`, `\vspace*{40mm}`, `\setstretch{1.1}`, `\itshape`, `flushright`, `\cleardoublepage` |
| acknowledgements | cls:323-332; thesis.tex:67-69 | `front.dedication`, `head.kernel` | `\newpage`, `\vspace*{30mm}`, `\section*{Agradecimentos}` or `{Acknowledgements}`, `\noindent`, `\cleardoublepage` |
| abstract in the main language | cls:336-352; thesis.tex:74-76 | `abs.class-native`, `abs.keywords` | `\newpage`, `\vspace*{60mm}`, centred `\section*{Resumo}`, body, `\par\vspace{\fill}`, `\noindent\large\textbf{Palavras-Chave:}` + the environment argument |
| abstract in the other language | cls:356-385; thesis.tex:80-82 | `abs.class-native`, `abs.keywords`, `lang.babel` | same layout inside `\begingroup\selectlanguage{english}` ... `\endgroup`, keyword label in that language |
| contents, lists | thesis.tex:85,88,91; cls:133 | `toc.kernel`, `toc.etoc` | `\tableofcontents` `\listoffigures` `\listoftables`; `tocbibind` loaded (adds bibliography/lists to the contents) |
| glossaries | thesis.tex:32-34,94-96; glossary.tex:1-11 | `idx.glossaries` | `glossaries-extra` options abbreviations, symbols; `\setabbreviationstyle{long-short}`; `\loadglsentries{glossary}`; three `\printunsrtglossary` calls (style=long, nogroupskip, type, title); entries are content |
| main-matter switch | cls:389; thesis.tex:102 | `pgnum.pagenumbering` | `\cleardoublepage\pagenumbering{arabic}` |
| headings | thesis.tex:104-112,230-234 | `head.kernel` | report `\part` `\chapter` `\section` unchanged; sans family inherited |
| appendix | thesis.tex:228 | `num.appendix` | `\appendix` then `\chapter` |
| display maths and references | cls:94; thesis.tex:114-118 | `math.mathtools`, `math.amsmath`, `xref.kernel` | mathtools (loads amsmath); `gather` with `\label`, `\eqref` |
| figures | cls:95; thesis.tex:43,122-127 | `fig.graphicx` | `figure[ht]`, `\centering`, `\includegraphics[width=0.5\linewidth]`, `\graphicspath{{graphics/}}` |
| tables | thesis.tex:29,131-143 | `tbl.tabular`, `tbl.booktabs` | `table[ht]`, `tabular{c c c}`, `\toprule` `\midrule` `\bottomrule`, caption above |
| captions | cls:135,145-146; thesis.tex:125,133,163,210 | `cap.kernel`, `cap.caption` | `\captionsetup{labelfont=bf, margin=15pt}`; `\captionsetup[table]{position=top, skip=3pt}`; optional short caption (thesis.tex:210) |
| bibliography | thesis.tex:22-23,218,224 | `bib.biblatex-biber` | `biblatex` default backend, `\addbibresource{main.bib}`, `\nocite`, `\printbibliography[heading=bibintoc]` |
| filler text | thesis.tex:26 | `draft.todo` | `lipsum` (the text is content) |
| spine page | cls:294-308; thesis.tex:239 | `art.tikz` (ART) | see Blockers; not recoverable |
| figure artwork | thesis.tex:37-39,44,147-212 | `art.tikz` (content) | see Content-opaque |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| language booleans `@portuguese` `@english`, option handling, `\ifbool` strings | cls:62-71,92,125-127,207-217,256-276,326-383 | yes | the language is one emit-time parameter; the emitter writes the Portuguese or English string and the `lang.babel` option directly |
| engine detection `unicode` boolean, `ifpdf` `ifxetex` `ifluatex` | cls:56-59,82-122 | yes | the emitter fixes one engine and prints one font branch (pdfTeX: cls:117-121; Xe/Lua: cls:104-114); engine probes have no printed effect |
| `\IfFontExistsTF` fallback | cls:105-112 | yes | font availability is an environment fact; emit the `\setsansfont` line for the XeLaTeX path |
| `bw` and `origmath` switches | cls:65,70-71,130,149-155,165 | yes | each is an option selecting colour values or skipping `newtxsf`; emit the chosen values |
| metadata macros `\ttitle` ... `\tcoverbacktext`, `\settitle` ... `\setcoverimage` | cls:195-234 | yes | `\newrobustcmd` aliases; expand inline into the cover (`front.class-native`), and into `\hypersetup{pdftitle=,pdfsubject=,pdfauthor=}` |
| `\tand` | cls:203 | yes | `\\ &` inside the cover tabular author, supervisor and committee cells |
| `\makecover` | cls:237-291 | yes | `front.titlepage-env` body of kernel spacing, `tbl.tabular`, `fig.graphicx`; no counters or conditionals beyond the language choice |
| dedication, acknowledgements environments | cls:311-332 | yes | kernel `\newpage`, `\vspace*`, `\section*`, `flushright`, `\cleardoublepage` written as wrapper pairs around the node; the `\setstretch{1.1}` and `\itshape` end with the environment group |
| `tabstract`, `fabstract`, `\abskey` | cls:336-385 | yes | `\abskey` only holds the environment argument (keywords) for the closing line; print the keywords where `\abskey{}` stands; `\begingroup`/`\endgroup` and `\selectlanguage` wrap the node |
| `\mainstart` | cls:389 | yes | `\cleardoublepage\pagenumbering{arabic}` (`pgnum.pagenumbering`) |
| link-colour wrappers via `\preto`/`\appto` on `\tableofcontents` `\listoffigures` `\listoftables` | cls:165-172 | yes | a group with `\hypersetup{linkcolor=black}` around each call (body wrapper) |
| page-limit warning with `\AfterEndDocument`, `\maxPages` | cls:175-183 | yes | writes only a log warning from `\theTotPages`; no printed output, drop it and keep `totpages` if wanted |
| `\makespine` (with `\newlength{\spinewidth}` declared inside the macro) | cls:294-308 | no | TikZ overlay in page coordinates (`remember picture`, `current page.north/south`), dashed outline, rotated nodes; no lib way. `BESPOKE`-like drawing counted as `ART/class` |
| `ist-thesis.cls` as a whole | ist-thesis.cls | no (because of the spine) | otherwise `\LoadClass{report}` with twoside, the packages above, and the macros above |
| glossary entry file | glossary.tex:1-11 | yes | `\newglossaryentry` `\newabbreviation` `\glsxtrnewsymbol` are `idx.glossaries` declarations (content) |

## Content-opaque
- TikZ block diagram inside a figure float (thesis.tex:147-165) and its preamble library line `\usetikzlibrary{positioning,arrows.meta}` (thesis.tex:39).
- pgfplots axes inside figure floats (thesis.tex:169-189, 195-212), data read from data/data_example.csv (thesis.tex:206, search path thesis.tex:44), packages loaded at thesis.tex:37-38.
- Example images `example-image`, `example-image-a` (thesis.tex:49,124) come from the TeX Live `mwe` files, not from the zip; the logos `graphics/IST_A_CMYK_POS.pdf` and `graphics/IST_C_CMYK_POS.pdf` ship in the zip and are used by the cover (cls:241) and the spine (cls:305); `InconsolataN` (cls:114) is a font the zip does not ship (XeLaTeX path only).
- `\lipsum` paragraphs, the equation (thesis.tex:116-118), table cell data (thesis.tex:135-139), bibliography entries (main.bib:1-35).

## Lib changes
- New ways proposed: none. (Considered, not proposed: `font.newtx` for `newtxsf`; `font.helvet` already names `sfmath`, a sans math package of the same type.)
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
