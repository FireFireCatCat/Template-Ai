no

# 0293-avinal-resume: Avinal Resume (comcv, "Compact CV")

- Unverified: read from the source, not compiled.
- Source: Source/0293-avinal-resume/ (origin: https://latextemplates.com/downloads/avinal-resume.zip; licence: LPPL-1.3c (comcv.cls:4-7, README.md:45); the bundled Roboto fonts are Apache 2.0 (README.md:48, fonts/LICENSE.txt))
- Kind: cv
- Lib: v4
- Engine: needs XeLaTeX (`fontspec` is loaded unconditionally at comcv.cls:36 and `\setmainfont` takes `.ttf` files by path; README.md:39-41 says LuaLaTeX also works and pdfLaTeX does not)
- Look carried by: zip-local (the whole look is in comcv.cls; main.tex has no preamble look settings, only `\documentclass`, `babel` and data commands)
- Class origin: zip-local (ctan.org/pkg/comcv returned 404; README.md:14 says "vendored (not on CTAN)"; comcv.cls:27-34 is a latextemplates.com patch of the upstream class, so the zip is not an official release)
- Main file: main.tex (other samples: none)
- Read: main yes (all 93 lines), zip-local classes and styles all (comcv.cls, all 252 lines; README.md read; the Roboto `.ttf` files and fonts/LICENSE.txt are assets and were not read)

## Verdict
Almost everything is a composition of published packages: `article`, `geometry`, `fontspec`, `fontawesome5`, `xcolor`, `fancyhdr`, `titlesec`, `totpages`, `hyperref`. The zip-local macros (`\combosection`, the header block, `tightlist`, `\horbar`, the data commands) reduce by inline expansion. The answer is `no` because of one line, comcv.cls:122, which overrides a package-internal macro, `\HyColor@@@@UseColor`, so that link colour is applied as a `fontspec` `Color=` feature. That is copied macro logic aimed at hyperref's internals, and no declarative way expresses it. I cannot show that dropping it leaves the links coral, because nothing was compiled and the hyperref/hycolor source was not read. If a reviewer rules that one-liner reducible, every other item here reduces and the file would flip to `yes`.

## Blockers
- `BESPOKE/class` redefinition of the hyperref colour-switch internal `\HyColor@@@@UseColor#1\@nil` as `\addfontfeatures{Color=linktext}` (comcv.cls:122). It sits beside `hypersetup{colorlinks=true, allcolors=linktext}` (comcv.cls:60-63), so it is the mechanism for link colour, not a colour value. The reason it is needed (a `Color=` set on the font probably wins over `\color` under XeTeX; the class sets `Color=` on every text face, comcv.cls:66-102) is inferred, not read from hyperref.

## Class setting
- Class: `class.article` (comcv.cls:23 `\LoadClass{article}`) options: `a4paper` (main.tex:2, forwarded to article by comcv.cls:19-21); `extended` is consumed by comcv itself (comcv.cls:13-17), not by article. `comcv` is zip-local, so it gets no `class.comcv` way; its behaviour is the preamble and body expansion below.
- Class-native vocabulary used: `\fullname{first}{last}{degree}`, `\cvtitle`, `\website{url}{text}`, `\email`, `\github{url}{text}`, `\linkedin{url}{text}`, `\currentdate` (main.tex:7-13; comcv.cls:105-117, 231); `\combosection{title}{subtitle}{dates}{body}` (comcv.cls:136-146); `tightlist` (comcv.cls:244-252); `\ifextended` (comcv.cls:13; main.tex:73-76). `\phonenumber` is defined (comcv.cls:117) but the sample does not call it.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:2; comcv.cls:23 | `class.article` | a4paper; zip-local layer on top (see Bespoke code) |
| paper size | main.tex:2; comcv.cls:19-21 | `page.class-options` | a4paper |
| page geometry | comcv.cls:26 | `page.geometry` | top=0.5cm, left=1cm, right=1cm, bottom=1.2cm |
| footer distance | comcv.cls:241 | `page.setlength` | `\footskip`=`\baselineskip` |
| main font | comcv.cls:66-72 | `font.fontspec` | `\setmainfont` Roboto-Light.ttf, Path=fonts/, BoldFont=Roboto-Bold.ttf, ItalicFont=Roboto-Italic.ttf, BoldItalicFont=Roboto-BoldItalic.ttf, Color=regulartext |
| named font switches | comcv.cls:74-102 | `font.fontspec` | `\newfontfamily` with Path=fonts/: `\regular` Roboto-Regular (regulartext), `\light` Roboto-Light (regulartext), `\thin` Roboto-Thin (defaulttext), `\regularheader` Roboto-Regular, `\thinheader` Roboto-Thin, `\mediumheader` Roboto-Medium (all headertext) |
| contact icons | comcv.cls:34, 156, 162, 172, 182, 192 | `font.icons` | fontawesome5 `[fixed]`; `\faEnvelope` `\faLinkedin` `\faGithub` `\faGlobe` `\faPhone` |
| colours | comcv.cls:35, 46-57 | `color.xcolor` | `usenames,dvipsnames`; `\definecolor` (HTML) white FFFFFF, gray 555555, lightgray 999999, black 000000, coralpink FF706C; `\colorlet` defaulttext=black, regulartext=gray, headertext=gray, linktext=coralpink, lighttext=lightgray |
| links and PDF metadata | comcv.cls:41-43, 60-63, 151-154; main.tex:20, 31, 37, 52, 59, 65 | `meta.hyperref` | colorlinks=true, allcolors=linktext; `\hypersetup{pdfauthor, pdftitle}`; `\href` in the body and for `mailto:`/`tel:` links; `unicode` and `naturalnames` are passed after the load at line 41 (comcv.cls:42-43) |
| language | main.tex:4 | `lang.babel` | english |
| header name block | comcv.cls:198-204 | `sp.ragged` | `center` environment |
| header name block | comcv.cls:200-203 | `font.size-commands` | `\fontsize{35pt}{45pt}`; first name `\thinheader`, last name `\regularheader`, optional `,~degree` in `\thinheader` |
| header name block | comcv.cls:200-203 | `font.fontspec` | uses `\thinheader` / `\regularheader` from above |
| header title line | comcv.cls:213 | `font.size-commands` | `\large\light` over `\cvtitle` (also uses `font.fontspec`) |
| header rule | comcv.cls:119, 215 | `sp.rule` | `\rule{\paperwidth}{0.4pt}` coloured gray via `\color` (`color.xcolor`) |
| header rule box | comcv.cls:119 | `sp.manual-space` | `\noindent\makebox[\linewidth]{...}` (kernel box command of the `\raisebox` family; a full-bleed rule by overfilling the box; filed here because no `box.*` line names `\makebox`) |
| header contact line | comcv.cls:217; main.tex:9-12 | `font.icons` | `<icon>~\href{...}{text}` for email, website, GitHub, LinkedIn, separated by `~~` (links: `meta.hyperref`) |
| header vertical tuning | comcv.cls:214, 218 | `sp.manual-space` | `\vspace{-\topsep}` |
| title (inert) | main.tex:6 | `front.maketitle` | `\title{Naomi's CV}` is set but `\maketitle` is never called, so nothing is printed from it |
| section headings | comcv.cls:125-128; main.tex:16, 51, 70, 81 | `head.titlesec` | `\titlespacing{\section}{0pt}{0pt}{0pt}`; `\titleformat{\section}{\fontsize{14pt}{16pt}\thinheader\bfseries\uppercase}{}{0pt}{}` (no label) |
| section heading case and weight | comcv.cls:127 | `mark.case` | `\uppercase` as the last command of the titlesec format (takes the title) |
| section heading weight | comcv.cls:127, 132 | `mark.kernel` | `\bfseries` |
| entry heading (runin) | comcv.cls:130-133, 137 | `head.titlesec` | `\titlespacing{\subsection}{0pt}{0pt}{0pt}`; `\titleformat{\subsection}[runin]{\fontsize{12pt}{12pt}\mediumheader\bfseries}{}{0pt}{}`; called as `\subsection{\textbf{#1}}` |
| entry line (subtitle, dates, body) | comcv.cls:138-145 | `font.size-commands` | `\Large` for the bar, `\large` for the subtitle, `\normalsize` before the body |
| entry line | comcv.cls:140-141 | `font.fontspec` | `\addfontfeatures{Color=linktext}` on `~\|`; `\light` for the subtitle |
| entry line | comcv.cls:143-144 | `sp.manual-space` | `\hfill{#3}` (right-aligned dates), then `\linebreak` |
| tight itemize | comcv.cls:244-252; main.tex:18-21, 25-28, 87-90 | `list.kernel` | `itemize` inside a `\newenvironment` |
| tight itemize | comcv.cls:245, 247-249 | `sp.lengths` | `\itemsep1pt`, `\parskip0pt`, `\parsep0pt` |
| tight itemize | comcv.cls:245 | `sp.manual-space` | `\vspace{-6mm}` before the list |
| gaps between blocks | main.tex:68, 79, 85 | `sp.manual-space` | `\vspace{\topsep}` |
| running footer | comcv.cls:235-242 | `hf.fancyhdr` | `\pagestyle{fancy}`, `\fancyhead{}`, `\fancyfoot[C]{\footnotesize\light first's Résumé, date, email}`, `\fancyfoot[R]{\raggedleft\footnotesize page}`, `\headrulewidth`=0em |
| footer ragged | comcv.cls:239 | `sp.ragged` | `\raggedleft` |
| footer size | comcv.cls:238-239 | `font.size-commands` | `\footnotesize` |
| page X / total | comcv.cls:38, 232-233 | `pgnum.lastpage` | `totpages`; `\thepage~/~\ref{TotPages}`, two passes |
| page X / total | comcv.cls:232 | `xref.kernel` | `\ref{TotPages}` |
| loaded, unused | comcv.cls:37 | `tbl.tabular` | `array` is required; no table in the sample |

Not present in the sample or class: abstract, contents, theorems, floats, figures, captions, tables, code, boxes, bibliography, index, footnotes, marginal notes, equations.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\def\HyColor@@@@UseColor` override | comcv.cls:122 | no | A hyperref-internal macro replaced by a font-feature switch; no lib way takes it as parameters (`meta.hyperref` only sets `allcolors`). The only escape is a different construction (colour set by `\color` instead of a font-level `Color=`), which is not a reduction of this code and cannot be shown equivalent without compiling. |
| `\newif\ifextended` and `extended` option | comcv.cls:13-17 | yes | Option is consumed by the class; the emitter picks the branch statically (sample is `extended`, so the course list is shown). The one-source, two-outputs toggle is not kept; that is content selection, not typesetting. |
| `\DeclareOption*` pass-through | comcv.cls:19-21 | yes | `class.article` options (`a4paper`). |
| data commands `\fullname` ... `\currentdate` | comcv.cls:105-117, 231 | yes | `\newcommand` + `\def` storage only; inline expansion into the header and footer with the sample's values. |
| `\horbar` | comcv.cls:119 | yes | `\noindent\makebox[\linewidth]{\color{gray}\rule{\paperwidth}{0.4pt}}` = `sp.rule` + `color.xcolor` + `sp.manual-space`. |
| `\combosection` | comcv.cls:136-146; main.tex:17, 24, 31, 37, 45, 52, 59, 65, 71, 82, 86 | yes | Alias of the sequence in the component map. The `\ifx&#2&` test only skips the subtitle when it is empty; the emitter knows that per use and writes the branch. The switches are not grouped (no braces around `\Large`, `\light`, `\addfontfeatures`), so font state carries into the next entry; the expansion keeps the same order. |
| header block at `\AtBeginDocument` | comcv.cls:149-228 | yes | `\ifdefined` / `\ifx\...\empty` chains only decide whether a contact field prints; the emitter writes the present fields in order right after `\begin{document}`. Title non-empty branch (sample): title, rule, contacts (comcv.cls:212-218). |
| footer macros `\comcv@totpages`, `\comcv@page` | comcv.cls:232-233, 235-242 | yes | Expands to the `hf.fancyhdr` fields and `pgnum.lastpage` above. |
| `tightlist` | comcv.cls:244-252 | yes | `\newenvironment` over `itemize` with three lengths and one `\vspace`; no counters, no conditionals. |
| `\ifextended ... \else \fi` in the body | main.tex:73-76 | yes | One branch is emitted (the course list paragraph). |

## Content-opaque
none (the URLs and text are content).

## Lib changes
- New ways proposed: none.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this).

## Notes
- Missing assets: none. The Roboto `.ttf` files ship in fonts/ and are loaded by the relative path `Path=fonts/` (comcv.cls:68, 75, 80, 85, 90, 95, 100), so the emitter must place them beside the `.tex`.
- comcv.cls:42-43 pass `unicode` and `naturalnames` to hyperref after `\RequirePackage{hyperref}` at line 41; read as having no effect on the load, not verified.
- comcv.cls:27-33 and README.md:25-33 describe a latextemplates.com patch (fontawesome to fontawesome5); these are build notes, not instructions to an AI, and no text addressed to an AI was found in the zip.
