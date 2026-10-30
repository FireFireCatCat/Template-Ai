no

# 0344-clubinfoinsat-latex-templates-insa-toulo: INSA Toulouse report class and beamer theme

- Unverified: read from the source, not compiled.
- Source: Source/0344-clubinfoinsat-latex-templates-insa-toulo/ (origin: https://codeload.github.com/ClubInfoInsaT/latex-templates-insa-toulouse/zip/refs/heads/master; licence: GPL-2.0)
- Kind: report (a PFE / end-of-studies report; the zip also holds a beamer defence deck)
- Lib: v3
- Engine: pdfLaTeX-compatible (T1 `fontenc`, `helvet`, `lmodern`, `tikz`, `biblatex`; no `fontspec`, no Lua; templates/report/INSAToulouse.cls:14-32)
- Look carried by: zip-local (the report look is in the zip-local class `INSAToulouse.cls`, the deck look in the zip-local package `beamerINSAToulouse.sty`; both sample preambles add only fonts, a colour and cover strings)
- Class origin: zip-local
- Main file: templates/report/main.tex (other samples: templates/beamer/main.tex)
- Read: main yes (both samples, every line), zip-local classes and styles all (INSAToulouse.cls 242 lines, beamerINSAToulouse.sty 161 lines; the 3 background PDFs and the PNG logos are binary assets and were not read; `.latexmkrc` read)

## Verdict
The look lives in two zip-local files that are not on CTAN (a GitHub club repository; the class even declares itself `insa`, templates/report/INSAToulouse.cls:9). Most of their body reduces to lib ways (`class.report`, `page.geometry`, `hf.fancyhdr`, `head.titlesec`, `bg.eso-pic`, `idx.glossaries`, `bib.biblatex-biber`, beamer templates). But the three report pages (cover, inner title page, back cover) and the beamer title frame and footline are TikZ overlays that place text, images and a coloured square at absolute `current page` coordinates over full-page PDF artwork. That is template-defining artwork with no declarative lib way (the lib's own `bg.tikzpagenodes` line says ART when it draws the template's identity), so the answer is `no`. A runtime `\ifx\insertsection\empty` test in the beamer footline is a second, smaller blocker.

## Blockers
- `ART/class` report cover page: full-page PDF node, filled square, absolutely-placed title / info / image nodes, conditional logos (templates/report/INSAToulouse.cls:120-149, node coordinates at :128-132, logos :136-145)
- `ART/class` report inner title page: the same overlay minus the PDF, repeated (templates/report/INSAToulouse.cls:152-174)
- `ART/class` report back cover: full-page PDF node, address block at (12.3,-14), four linked icon nodes (templates/report/INSAToulouse.cls:189-213)
- `ART/class` beamer title frame: white author/date block and logos anchored on `current page` corners (templates/beamer/beamerINSAToulouse.sty:74-107)
- `ART/class` beamer footline: section text and slide number placed by tikz nodes at `current page.south west/east` (templates/beamer/beamerINSAToulouse.sty:110-130)
- `BESPOKE/class` beamer footline runtime conditional `\ifx\insertsection\empty ... \ifx\insertsubsection\empty` decides whether the separator and subsection print (templates/beamer/beamerINSAToulouse.sty:116-121); a lib parameter cannot hold a test on a value known only at typesetting time

Considered and not counted: `makeglossaries` (run by templates/report/.latexmkrc:1-17) and `biber` are TeX-distribution tools that the lib already accepts under `idx.glossaries` and `bib.biblatex-biber`, so no `EXTERNAL`.

## Class setting
- Class: `class.report` (report sample), options `12pt,a4paper` fixed inside the zip-local class (templates/report/INSAToulouse.cls:11); the sample passes none (templates/report/main.tex:1). Deck: `class.beamer`, option `aspectratio=169` (templates/beamer/main.tex:1). The zip-local `INSAToulouse` is not a lib way; it reduces to `class.report` plus the preamble ways below.
- Class-native vocabulary used (zip-local, not published): preamble `\titre` `\imagecouverture` `\firstcouverture` `\secondcouverture` `\enabletlssec` (templates/report/main.tex:11-47), environment `custombox` (:29), body `\makecover` `\makepagegarde` `\pchapter` `\makebackmatter` `\makeglossaire` `\makesommaire` `\makebackcover` (:61-117); also defined, unused by the sample: `\psection`, `\aremplir`, `\linkedinINSA` (templates/report/INSAToulouse.cls:94,98,187). Deck: `\enabletlssec`, `\maketitleframe`, `\backgroundnormal` `\backgroundfinal` (templates/beamer/main.tex:13,17,21,62); `\backgroundtitle` is called only inside `\maketitleframe` (templates/beamer/beamerINSAToulouse.sty:76).

## Component map
Report (templates/report/):
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| paper and size | templates/report/INSAToulouse.cls:11 | `page.class-options` | a4paper, 12pt (via `\LoadClass`) |
| page geometry | templates/report/INSAToulouse.cls:19,39-44 | `page.geometry` | left=3cm, right=3cm, top=2cm, bottom=3.5cm |
| header / footer | templates/report/INSAToulouse.cls:18,47-51 | `hf.fancyhdr` | `\pagestyle{fancy}`, `\fancyhf{}`, `\headrulewidth`=0pt, `\fancyfoot[R]{\thepage}`, `\fancyfoot[L]{{\itshape\leftmark}}` |
| empty page style on cover pages | templates/report/INSAToulouse.cls:123,192 | `hf.pagestyle-kernel` | `\thispagestyle{empty}` |
| recurring page background | templates/report/INSAToulouse.cls:28,53-57,148,191 | `bg.eso-pic` | `\AddToShipoutPicture{\put(0,0){\includegraphics[width=\paperwidth,height=\paperheight]{assets/template_page.pdf}}}`, `\ClearShipoutPicture` before the back cover; the PDF is a shipped asset |
| image inclusion | templates/report/INSAToulouse.cls:14,55 | `fig.graphicx` | PDF and PNG files, width/height keys |
| chapter heading | templates/report/INSAToulouse.cls:20,61-78 | `head.titlesec` | `\titleformat{\chapter}[block]`, format `\normalfont\sffamily\raggedleft`, label = uppercase `\chaptername` 20pt bold + `\thechapter` 25pt bold in `insaaccent`, sep 0pt, before-code 22/26pt bold, after-code 2pt `\rule{\linewidth}{2pt}` in `insaaccent`; `\titlespacing*{\chapter}{0pt}{-20pt}{20pt}` |
| section, subsection headings | templates/report/INSAToulouse.cls:80-86 | `head.titlesec` | section `\sffamily\LARGE\bfseries\MakeUppercase`, label `\thesection`, sep 1em; subsection `\Large\bfseries\itshape`, label `\thesubsection`, sep 1em |
| colours | templates/report/INSAToulouse.cls:21,60,118; templates/report/main.tex:7 | `color.xcolor` | `insaaccent` HTML E52713, `couleurcarre` HTML F3F0EC, `mainred` HTML FF4C4C (unused in the sample body) |
| text fonts | templates/report/INSAToulouse.cls:25,26,30; templates/report/main.tex:3,5 | `font.helvet`, `font.fontenc-t1`, `font.lmodern`, `font.family-default` | `helvet`, `[T1]{fontenc}`, `lmodern` (loaded after `helvet`, so by lmodern's own defaults the sans face is likely Latin Modern Sans, not Helvetica: order matters, unverified), `\familydefault`=`\sfdefault` |
| language | templates/report/INSAToulouse.cls:27,88-91 | `lang.babel` | `[french]`; `\addto\captionsfrench` sets `\listfigurename`="Liste des figures", `\listtablename`="Liste des tableaux" |
| quotes | templates/report/INSAToulouse.cls:22 | `lang.csquotes` | default options |
| hyperlinks | templates/report/INSAToulouse.cls:17,205,208-211 | `meta.hyperref` | default options; `\href` on address and four icon nodes |
| cover page, inner title page, back cover | templates/report/INSAToulouse.cls:120-149,152-174,189-213 | `art.tikz` (ART, see Blockers), with `bg.eso-pic` and `fig.graphicx` for the PDF layers | `remember picture, overlay` nodes at (3,-4), (6.3,-7), (6.3,-18.7), (14.47,-0.3), (12.3,-14), (5.2..8.54,-16.25); `\fill` square 3.5cm at north-east offset (-4.7cm,-4.5cm); `template_first_page.pdf`, `template_last_page.pdf` full-page |
| cover fields and info box | templates/report/main.tex:11-47; templates/report/INSAToulouse.cls:101-115 | `box.minipage` (content strings) | `\parbox{\textwidth}`, `custombox{9cm}` = `minipage`; `\titre`, `\imagecouverture`, `\firstcouverture`, `\secondcouverture` are stored strings |
| front-matter pages (Résumé, Remerciements, tool-use note) | templates/report/main.tex:64-76; templates/report/INSAToulouse.cls:95 | `head.kernel`, `front.dedication` | `\chapter*` plus `\addcontentsline{toc}{chapter}{...}` and `\phantomsection`; unnumbered chapters used as abstract, acknowledgement and declaration pages |
| page numbering | templates/report/INSAToulouse.cls:121-122,181-182 | `pgnum.pagenumbering` | Roman from the cover, `\setcounter{page}{1}`, then arabic from page 1 after the contents |
| table of contents | templates/report/INSAToulouse.cls:23,177-183; templates/report/main.tex:83 | `toc.kernel`, `toc.tocloft` | `\pchapter{SOMMAIRE}` then `\@starttoc{toc}`; entry formats via `tocloft` `\cftchap...` |
| lists of figures and tables | templates/report/INSAToulouse.cls:216-223; templates/report/main.tex:78 | `toc.kernel`, `sp.manual-space`, `pg.break` | `\listoffigures`, `\listoftables`, `\vspace{-5em}`, `\vspace{-1em}`, `\newpage` |
| glossary | templates/report/INSAToulouse.cls:29,225-230; templates/report/main.tex:55,57,79,90; templates/report/glossary.tex:1 | `idx.glossaries` | `[toc, section=section, numberedsection=false]`, `\makeglossaries`, `\printglossaries` with `\glossarysection` emptied, `\newglossaryentry{pki}`, `\gls` |
| appendix | templates/report/INSAToulouse.cls:233-242; templates/report/main.tex:108-109 | `num.appendix`, `toc.tocloft` | `\appendix`, `\chaptername`=`\appendixname`, `\cftchappresnum`=`\appendixname\ ` and `\cftchapnumwidth` +1.7cm written with `\addtocontents{toc}` |
| bibliography | templates/report/INSAToulouse.cls:32; templates/report/main.tex:50-51,99,115 | `bib.biblatex-biber` | `style=ieee`, `\addbibresource{bibliography.bib}`, `\cite`, `\printbibliography[heading=bibintoc, title={Bibliographie}]` |
| page and line breaks | templates/report/main.tex:67,72,76,81,114 | `pg.break` | `\clearpage` |
| loaded, not used in the sample body | templates/report/main.tex:5-6; templates/report/INSAToulouse.cls:15,24 | `code.listings`, `tbl.tabular`, `tbl.multirow`, `tbl.tabularx`, `tbl.colortbl`, `fig.adjustbox`, `fig.float`, `pg.include-pdf`, `art.tikz` | `listings`, `array`, `multirow`, `tabularx`, `colortbl`, `adjustbox`, `float`, `pdfpages` (no `\includepdf` call anywhere); `pgfgantt` plus tikz libraries `positioning, fit, backgrounds, arrows.meta, decorations.pathreplacing, shapes.multipart, calc` (user diagrams, content) |

Beamer deck (templates/beamer/):
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class | templates/beamer/main.tex:1 | `class.beamer` | `aspectratio=169`; `frame`, `[plain]` frame option, `\frametitle`, `\section` `\subsection` |
| language, encoding, default family | templates/beamer/main.tex:3,4,6 | `lang.babel`, `font.fontenc-t1`, `font.family-default` | `[french]`, `[T1]`, `\familydefault`=`\sfdefault` |
| canvas and navigation | templates/beamer/beamerINSAToulouse.sty:22,25 | `slide.beamer-template` | `\setbeamercolor{background canvas}{bg=}`, `\setbeamertemplate{navigation symbols}{}` |
| page backgrounds | templates/beamer/beamerINSAToulouse.sty:12,19,27-39; templates/beamer/main.tex:21,29,44,62 | `bg.eso-pic`, `fig.graphicx` | `\AddToShipoutPictureBG*{\put(0,0){\parbox[b][\paperheight]{\paperwidth}{\includegraphics[...,page=N]{background.pdf}}}}`, page 1 title, 2 normal, 3 final |
| colours | templates/beamer/beamerINSAToulouse.sty:42-43 | `color.xcolor` | `RedFlash` RGB 227,27,23; `SubTitleColor` HTML F69F1D |
| frame title, toc and list colours and fonts | templates/beamer/beamerINSAToulouse.sty:45-58 | `slide.beamer-template` | `\setbeamercolor` for `frametitle`, `section in toc`, `subsection in toc`, `section number projected`, `itemize item`, `enumerate item` and subitems; `\setbeamerfont{frametitle}{size=\Large,series=\bfseries}` |
| frame title layout | templates/beamer/beamerINSAToulouse.sty:62-72 | `slide.beamer-template`, `sp.manual-space`, `sp.ragged` | `\setbeamertemplate{frametitle}` with `\vspace{0.8em}`, `flushleft`, `\hspace{0.3em}`, `\vspace{0.5em}` |
| title frame | templates/beamer/beamerINSAToulouse.sty:74-107; templates/beamer/main.tex:8-11,17 | `art.tikz` (ART, see Blockers) | `\inserttitle`, `\insertsubtitle`, `\insertauthor`, `\insertdate` placed by nodes on `current page` |
| footline | templates/beamer/beamerINSAToulouse.sty:110-130 | `art.tikz` (ART) inside `slide.beamer-template` | `beamercolorbox[ht=0.6cm,dp=0.3cm]`, two nodes at south west / south east with offsets 0.2cm |
| toc entry templates | templates/beamer/beamerINSAToulouse.sty:133-140 | `slide.beamer-template` | `[sections numbered]` then overridden by a body with `\inserttocsectionnumber`, `\inserttocsection`, `$\blacktriangleright$` |
| section transition frame | templates/beamer/beamerINSAToulouse.sty:143-161 | `slide.beamer-section-hook` | `\AtBeginSection[]` plain frame: `\tableofcontents[currentsection,hideothersubsections]` in a 0.7`\textwidth` `minipage`, hand-set heading with `\rule{4cm}{1.5pt}` |
| contents frame, figure frame, lists | templates/beamer/main.tex:20-24,32-37,47-56 | `toc.kernel`, `fig.graphicx`, `cap.kernel`, `xref.kernel`, `list.kernel` | `\tableofcontents`; `figure` + `\centering` + `\includegraphics[width=0.5\linewidth]{example-image}` + `\caption` + `\label`; `itemize`, `enumerate` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\makecover`, `\makepagegarde`, `\makebackcover` | templates/report/INSAToulouse.cls:120-149,152-174,189-213 | no | ART: absolutely-placed TikZ nodes over PDF artwork; no lib way declares a node at a page coordinate (`pg.textpos` would need re-derived coordinates because the `\node at (x,y)` origin is the text-area anchor of the picture, not the page corner, and the square is a TikZ `\fill`) |
| `\maketitleframe` | templates/beamer/beamerINSAToulouse.sty:74-107 | no | ART, as above |
| footline with `\ifx\insertsection\empty` | templates/beamer/beamerINSAToulouse.sty:110-130 | no | runtime conditional plus page-anchored nodes |
| `\newbool{showtlssec}`, `\enabletlssec`, `\ifbool` | templates/report/INSAToulouse.cls:35-37,136-145,162-171; templates/beamer/beamerINSAToulouse.sty:15-17,93-102 | yes, alone | an emitter prints the chosen branch (logos or none); the branches sit inside the ART nodes, so no gain |
| `\BackgroundPic`, `\AddToShipoutPicture` / `\ClearShipoutPicture` use | templates/report/INSAToulouse.cls:53-57,148,191 | yes | `bg.eso-pic` lines written inline at the page they start and stop |
| `\setbackgroundpage`, `\backgroundtitle/normal/final` | templates/beamer/beamerINSAToulouse.sty:27-39 | yes | one `bg.eso-pic` `\AddToShipoutPictureBG*` per frame with `page=N` |
| `\pchapter`, `\psection` | templates/report/INSAToulouse.cls:94-95 | yes | `\chapter*{t}` + `\addcontentsline{toc}{chapter}{t}` (kernel, `\phantomsection` from hyperref) |
| `\makesommaire` with `\@starttoc{toc}` | templates/report/INSAToulouse.cls:177-183 | yes | `\renewcommand{\contentsname}{SOMMAIRE}`, `\tableofcontents`, the self-entry through `\addcontentsline`, `\pagenumbering{arabic}`, `\setcounter{page}{1}` |
| `\makebackmatter`, `\makeglossaire` | templates/report/INSAToulouse.cls:216-230 | yes | kernel and `glossaries` commands in order; `\glossarysection` is the package's documented user hook |
| `\appto{\appendix}{...}` (etoolbox) | templates/report/INSAToulouse.cls:233-242 | yes | the three redefinitions printed right after `\appendix` in the body |
| `custombox`, `\aremplir`, `\linkedinINSA`, `\titre` family | templates/report/INSAToulouse.cls:98,101-115,187 | yes | aliases of `minipage`, `\textcolor`/`\LARGE`/`\bfseries`, a URL string and `\def` storage for content |
| beamer `\AtBeginSection[]` body and toc templates | templates/beamer/beamerINSAToulouse.sty:133-161 | yes | `slide.beamer-section-hook` and `slide.beamer-template` bodies made only of beamer inserts and `sp.*`, `box.minipage` pieces (borderline: the hook way is described as declarative beamer commands, this body also sets type by hand) |

## Content-opaque
- `pgfgantt` and seven tikz libraries loaded for user diagrams, no picture in the sample (templates/report/main.tex:5-6)
- `example-image` placeholder as cover image and figure (templates/report/main.tex:12; templates/beamer/main.tex:34)
- shipped artwork assets: `templates/report/assets/template_first_page.pdf`, `template_page.pdf`, `template_last_page.pdf`, `templates/beamer/background.pdf` (3 pages), logo PNGs and `carre.png` (placeholder icons, templates/report/INSAToulouse.cls:208-211); included as images, not read
- one `@online` entry in templates/report/bibliography.bib:1-8

## Lib changes
- New ways proposed: none. Considered: `etoolbox` (a programming package, fails W2); `pgfgantt` (filed under `art.tikz` as content).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- Hidden file templates/report/.latexmkrc:1-17 runs `makeglossaries` through latexmk; build configuration, not template code.
- The class declares `\ProvidesClass{insa}` but ships as `INSAToulouse.cls` (templates/report/INSAToulouse.cls:9), a name mismatch that only warns; `biblatex` is loaded in the class with `style=ieee` (:32) and again bare in the sample (templates/report/main.tex:50).
- The sample's `\gls{pki}` depends on templates/report/glossary.tex, which has one `\newglossaryentry` line.
- The deck's own header calls its file a `.cls` but it is a `\ProvidesPackage` (templates/beamer/beamerINSAToulouse.sty:2,8).
