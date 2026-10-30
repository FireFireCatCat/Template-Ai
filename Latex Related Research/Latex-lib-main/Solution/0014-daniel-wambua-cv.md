no

# 0014-daniel-wambua-cv: Daniel Wambua CV (resume-format class, Awesome-CV-style fork)

- Unverified: read from the source, not compiled.
- Source: Source/0014-daniel-wambua-cv/ (origin: https://codeload.github.com/Daniel-wambua/cv/zip/refs/heads/main; licence: MIT, LICENSE:1)
- Kind: cv
- Lib: v1
- Engine: needs XeLaTeX; fonts shipped in tex/fonts/ (Roboto-*.ttf and FontAwesome.otf are referenced; SourceSansPro-*.otf is shipped but referenced nowhere, resume-format.cls:220,228 are comments only) (`\newfontfamily` is called outside the `\ifxetex` guard, tex/resume-format.cls:204-243; `unicode-math` at :93; local fontawesome.sty:9 loads `fontspec`; `%!TEX TS-program = xelatex` at tex/resume.tex:1; tex/README.txt:68). The class comment at :21 claims pdfLaTeX compatibility, but as read the pdfTeX branch (:87-90) cannot be reached without the `fontspec` calls above failing.
- Look carried by: zip-local (tex/resume-format.cls defines nearly the whole look; the sample adds one `tcolorbox` banner, one `\colorlet`, one `\hypersetup` group)
- Class origin: zip-local (`resume-format` is a renamed fork of Awesome-CV, tex/resume-format.cls:9-10, 25; CTAN pages for `resume-format` and `awesome-cv` both returned 404)
- Main file: tex/resume.tex (other samples: none; template.jinja is the same document with Jinja placeholders)
- Read: main yes, zip-local classes and styles partly (resume-format.cls all 797 lines; fontawesome.sty: its 20 non-table lines read, the 663 icon-table lines checked only by an exact pattern match, not read one by one; not read: web/ SvelteKit site, lib/*.py beyond compile.py and the generate.py filters)

## Verdict
The sample document is a thin body over a 797-line zip-local class, and most of that class reduces to lib ways (`tabular*`, `enumitem`, `ragged2e`, `geometry`, `fancyhdr`, `fontspec`, `xcolor`, `tcolorbox`). It is `no` because every section heading goes through a hand-written token-grabbing macro with a counter and `\ifcase` (`\@sectioncolor`) that colours the first three characters of the title, and no published way holds that. The class also carries a bool-driven header builder and an expl3 URL-trimming command. Neither is called by the sample, but both are in the class's scope. Not counted as a blocker: the Python/Jinja/Makefile pipeline, which only feeds content, because the shipped tex/resume.tex stands alone (tex/README.txt:57-60).

## Blockers
- `BESPOKE/class` `\@sectioncolor` + `colorCounter` + `\ifcase`: takes three tokens of the heading text as `#1#2#3`, colours them `awesome`, leaves the rest in `text`, then steps a counter whose six `\ifcase` branches are all `awesome` (tex/resume-format.cls:183-197); called from `\sectionstyle` (:276) and so from every `\cvsection` (:617-626; used at tex/resume.tex:86,127,148,164,178,192). No lib way colours a title prefix; a new way would fail W1 (macro exists only here).
- `BESPOKE/class` `\makecvheader`: declares `\newbool{isstart}` inside the macro body and chains `\ifthenelse{\isundefined{...}}` and `\ifbool` to decide where separators go between eight optional contact fields (tex/resume-format.cls:491-598). Hand-rolled conditional state that drives what is printed. Not called by the sample (the sample hand-lays its banner, tex/resume.tex:51-63).
- `BESPOKE/class` `\shorturl`: expl3 (`\tl_set:Nx`, `\str_if_eq:eeTF`, `\tl_item:Nn`, `\tl_range:nn`) that strips `https://` or `http://` before `\url` (tex/resume-format.cls:318-333). Text-processing code; not called by the sample.
- `BESPOKE/class` `\processMarkdownLinks` and `\markdownlink`: a delimited-argument parser for `[text](url)` and a wrapper that tests `\boolean{shownotes}`, which is never defined (tex/resume-format.cls:774-784). Dead code, never called; recorded because the whole class is in scope.

## Class setting
- Class: `class.article` (reached through zip-local `resume-format`; `\LoadClass{article}` at tex/resume-format.cls:55, `\documentclass[]{resume-format}` at tex/resume.tex:9). Options: none given; `draft` and `final` are declared and set `\overfullrule` to 5pt or 0pt (:48-49); every other option is passed to article (:51-53). The zip-local class itself is not a lib way (not published).
- Class-native vocabulary used: article's own vocabulary is not used (no `\maketitle`, `\section`, `abstract`). Zip-local vocabulary used by the sample: `\fontdir`, `\headerfirstnamestyle`, `\headerlastnamestyle`, `cvpersonalstatement`, `\cvsection`, `cventries` + `\cventry` (five arguments: position, title, location, date, description), `cvitems`, `cvskills` + `\cvskill`, `cvachievements`, colour names `awesome`, `headerbg`, `lightgray`, `white`, FontAwesome commands `\faEnvelope \faMapMarker \faLink \faStar \faExternalLink \faGithub`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | resume.tex:9; resume-format.cls:36,48-55 | `class.article` | base class of the zip-local class; default 10pt, no options |
| page geometry | resume-format.cls:132 | `page.geometry` | a4paper, left=1.5cm, right=1.5cm, top=0.5cm, bottom=0.5cm, footskip=.5cm |
| header/footer | resume-format.cls:141-147 | `hf.fancyhdr` | `\fancyhfoffset{0em}`, `\headrulewidth`=0pt, `\fancyhf{}` (all fields empty), `\pagestyle{fancy}` |
| footer fields (unused) | resume-format.cls:602-613 | `hf.fancyhdr` | `\makecvfooter`: `\fancyfoot[L]`, `[C]`, `[R]` each `\footerstyle{...}` (9pt, small caps, `lighttext`) |
| line breaking | resume-format.cls:135-137 | `sp.hyphenat` | `\sloppy`; `\tolerance=1000` (the integer parameter `\sloppy` itself sets); `\emergencystretch=3em` is a raw length, `sp.lengths` |
| paragraph spacing | resume-format.cls:105 | `sp.parskip-pkg` | package defaults |
| line spacing | resume-format.cls:81 | `sp.setspace` | loaded only; no `\setstretch` or spacing command anywhere in the class or sample (grep) |
| body and header fonts | resume-format.cls:83-91,204-261 | `font.fontspec` | `\newfontfamily` x5 (`\headerfont`, `\headerfontlight`, `\footerfont`, `\bodyfont`, `\bodyfontlight`), `Path=\@fontdir` (default `fonts/`), Roboto files `*-Regular/-Italic/-Bold/-BoldItalic`, Thin/Medium for the header-light, Light for body-light; `\setmainfont` Roboto (:250-256); `\defaultfontfeatures{Ligatures=TeX}` |
| math fonts | resume-format.cls:93 | `font.unicode-math` | loaded only |
| pdfTeX encodings | resume-format.cls:88-90,258-260 | `font.fontenc-t1` | `[T1]fontenc`, `[utf8]inputenc`; only the non-XeTeX branch |
| icons | resume-format.cls:96; fontawesome.sty:6-18 | `font.icons` | `fontawesome` icon commands; the zip-local fontawesome.sty is a name-to-codepoint table of 663 `\def` lines over `\newfontfamily{\FA}[Path=fonts/]{FontAwesome}` (:12-14), reducible to the CTAN `fontawesome` package (page read: on CTAN, v4.6.3.2) with FontAwesome.otf shipped in tex/fonts/ |
| emoji to icon | resume-format.cls:99-103 | `font.newunicodechar` | four characters mapped to `{\color{awesome}\faTrophy}` or `\faFlag`: calls into `color.xcolor` and `font.icons` only; used in sample at resume.tex:168-170 |
| font sizes and shapes | resume-format.cls:269-311; resume.tex:197,198,237 | `font.size-commands` | `\fontsize{32pt}{38pt}` (name), 16/18 (section), 12/14 (entry title), 11/13 (position, description), 9/11 (date), 10/12 (location), 9/1em (skills, achievements), 10/14 (personal statement); `\scriptsize`, `\tiny` in sample |
| text shapes | resume-format.cls:269-311 | `mark.kernel` | `\bfseries`, `\scshape`, `\itshape`, `\slshape`, `\mdseries`, `\upshape`; `\textbf` in sample content |
| colours | resume-format.cls:154-180; resume.tex:23,53 | `color.xcolor` | `\definecolor{...}{HTML}{...}`: white FFFFFF, black 000000, darkgray 333333, gray 5D5D5D, lightgray 999999, headerbg F04C8A, awesome-red 000000 (:173), others unused; `\colorlet{text}{darkgray}`, `\colorlet{awesome}{awesome-red}` (set again in sample, :23) |
| hyperlinks | resume-format.cls:107-115; resume.tex:42-49 | `meta.hyperref` | class: empty pdftitle/pdfauthor/pdfsubject/pdfkeywords, `colorlinks=false`, `allbordercolors=white`; sample banner group: `colorlinks=true`, link/url/citecolor=white, `pdfborder={0 0 0}`; `\href` throughout; `\phantomsection` at :622,631 |
| URL display (unused) | resume-format.cls:314-315 | `meta.url` | `\displayurl` = `\href{u}{\nolinkurl{u}}`; `\shortdisplayurl` = `\urlstyle{same}\url{\detokenize{u}}` |
| name and contact banner | resume.tex:40-65 | `box.tcolorbox` | `[most]`; colback=headerbg, colframe=headerbg, arc=4mm, boxrule=0pt, left=0pt, right=0pt, top=6mm, bottom=6mm, width=\textwidth, enlarge left/right by=0mm; contents `center`, `\\[2mm]`, `\quad|\quad`, icons plus `\href` |
| banner support | resume.tex:40,51,65 | `sp.lengths` | `\setlength\fboxsep{10pt}`; `sp.manual-space`: `\vspace{0mm}`; `sp.ragged`: `center` |
| personal statement | resume.tex:72-79; resume-format.cls:713-730 | `list.enumitem` | `itemize[leftmargin=0ex, label={}, nosep, noitemsep, before=\cvparagraphstyle]` inside `justify` (`sp.ragged`); `\setlength{\parskip}{2mm}` (`sp.lengths`); `\fontsize{10pt}{14pt}`; `\vspace{2mm}`/`{1mm}` (`sp.manual-space`) |
| section heading frame | resume-format.cls:617-626; resume.tex:86 etc. | `pg.needspace` | `\needspace{5\baselineskip}`; `sp.manual-space`: `\par\addvspace{1.2ex}` before, `\par\nobreak\addvspace{0.7ex}` after; `sp.rule`: `\color{gray}\vhrulefill{0.10pt}` = `\leaders\hrule\@height0.10pt\hfill\kern\z@` (:480); `meta.hyperref`: `\phantomsection`; look 16pt/18pt `\bfseries` `text`. The three-letter highlight is BESPOKE (see Blockers). An emitter would hold the frame in `head.titlesec`; not claimed, the source uses a hand-written `\newcommand` |
| entry list | resume.tex:87-141; resume-format.cls:636-654 | `tbl.tabular` | `cventries` = `center`; `\cventry`: `tabular*{\textwidth}{@{\extracolsep{\fill}} p{0.72\textwidth} >{\raggedleft\arraybackslash}p{0.24\textwidth}}`, `\multicolumn{2}{p{\textwidth}}` for the description, `\tabcolsep`=3pt, `\extrarowheight`=1.5pt, `\vspace{1.4mm}`; two-row branch taken in all five sample calls (`\ifempty{#2#3}`) |
| entry bullets | resume.tex:93-97 etc.; resume-format.cls:338-348 | `list.enumitem` | `cvitems`: `justify` + `itemize[leftmargin=2ex, nosep, itemsep=0.8pt]`, `\renewcommand{\labelitemi}{\bullet}` (`list.kernel`), `\parskip`=0pt, `\vspace{-1.5mm}`, `\vspace{0.4mm}` |
| skills table | resume.tex:150-156; resume-format.cls:733-747 | `tbl.tabular` | `tabular*{\textwidth}{@{\extracolsep{\fill}} l L{20.2cm}}` (`\newcolumntype{L}` at :475 is an `array` `m{}` column with `\raggedright\arraybackslash`); `\tabcolsep`=1ex, `\extrarowheight`=0pt. As read, 20.2cm exceeds the 18cm text width given by :132 |
| achievements, awards, projects | resume.tex:166-228; resume-format.cls:699-710 | `list.enumitem` | `itemize[leftmargin=0ex, label={}, nosep, noitemsep, before=\achievementstyle]` in `justify`, `\bodyfontlight`, `\fontsize{9pt}{1em}`, `\parskip`=0.8mm; sample `\setlength{\itemsep}{0mm}` (`sp.lengths`); item content: `\hspace{-5pt}`, `\hfill`, `\\`, `\raisebox{0.5pt}`, `\vspace{0.2mm}` (`sp.manual-space`), `\color{lightgray}` (`color.xcolor`) |
| closing note | resume.tex:235-243 | `sp.manual-space` | `\vspace{1.5mm}`, `center`, `\tiny\color{lightgray}`, `\href`; trailing `\ ` |
| other class envs (unused) | resume-format.cls:657-696,750-770,787-796 | `tbl.tabular` | `cvsubentry` (`p{0.65\textwidth} p{0.3\textwidth}`), `cvhonors` (`C{1.5cm} L{13.0cm} R{2.5cm}`), `cvlinks`/`cvfooterlink` (`flushright`, `list.enumitem` for `cvparagraph(s)`): same ways as above |
| info slots (unused) | resume-format.cls:371-458,467-468 | `sp.lengths` | not a lib component: `\def` string slots (`\name`, `\email`, `\github`, cover-letter fields); consumed only by `\makecvheader`, and the letter fields by nothing in the class |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| style aliases `\headerfirstnamestyle` ... `\personalstatementstyle`, `\skill` | resume-format.cls:269-311 | yes | `\newcommand` aliases of `font.fontspec` family + `font.size-commands` + `mark.kernel` + `color.xcolor` |
| `\fontdir` / `\@fontdir` | resume-format.cls:122-123; resume.tex:13 | yes | the `Path=` value of `font.fontspec`; the sample's later `\fontdir[fonts/]` cannot change families already declared at class load (:204-261), so as read it has no effect |
| `\vhrulefill` | resume-format.cls:480 | yes | `sp.rule` (`\leaders\hrule` over a rule only), height 0.10pt |
| `\ifempty` | resume-format.cls:483 | yes | xifthen test; the emitter chooses which `\cventry` rows to write |
| `\cvsection`, `\cvsubsection` | resume-format.cls:617-633 | partly | frame reduces as in the component map; the title highlight does not |
| `\@sectioncolor`, `colorCounter` | resume-format.cls:183-197 | no | irreducible token-grabbing macro with a counter and `\ifcase` (BESPOKE/class) |
| `\makecvheader` | resume-format.cls:491-598 | no | field-presence logic with in-macro `\newbool` (BESPOKE/class); for a fixed field set the output is a centred block of icon + `\href` items |
| `\shorturl` | resume-format.cls:318-333 | no | expl3 string trimming (BESPOKE/class) |
| `\markdownlink`, `\processMarkdownLinks` | resume-format.cls:774-784 | no | delimited-argument parser, dead; effect would be `\href` (BESPOKE/class) |
| `\renewenvironment{cvpersonalstatement}` | resume-format.cls:713 | yes | no earlier `\newenvironment` of that name in the class (grep), so it reads as a renew of an undefined environment, a latent error (not tested); content is `list.enumitem` + `sp.ragged` as in the component map |
| `before=\cvparagraphstyle` / `\achievementstyle` / `\descriptionstyle` | resume-format.cls:354,704,723,790 | yes, intent only | one-argument style macros passed as enumitem `before=` code, so they take the next token as their argument; the exact effect is not established without compiling; reduced to the intended font and colour switch |
| `\makecvfooter`, `\displayurl`, `\shortdisplayurl`, env wrappers `cvitems` `cvparagraphs` `cvparagraph` `cvlinks` `cvfooterlink` `cvsubentries` `cvhonors` | resume-format.cls:314-315,338-361,602-613,657-696,750-770,787-796 | yes | compositions of the ways in the component map |
| zip-local fontawesome.sty | fontawesome.sty:1-683 | yes | `font.icons` (CTAN `fontawesome`); a shadow copy with the same package name |
| support packages `ifxetex`, `xifthen`, `etoolbox` | resume-format.cls:74-78 | yes | helpers for the macros above; they have no look of their own and disappear when those macros reduce |
| Makefile + `template.jinja` + `lib/generate.py` + `lib/compile.py` | Makefile:21,38-43; template.jinja; lib/generate.py:34-106; lib/compile.py:38 | not counted | content feeder (YAML to `.tex` through Jinja with `latex_escape`, `markdown_to_latex` and `format_date` filters, then `xelatex -interaction=nonstopmode`); the emitter does this job in Flouest. tex/resume.tex is the Makefile's `OUTPUT_TEX` (Makefile:21, deleted by `clean` at :51), but it is checked in and tex/README.txt:57-60 gives a pure-`xelatex` route |

## Content-opaque
none (no figure or table float; the emoji and FontAwesome glyphs are mapped by `font.newunicodechar` and `font.icons`). Not analysed as a template: web/ (an unrelated SvelteKit site) and web/static/downloads/Daniel-Wambua-CV.pdf (a built PDF). No text addressed to an AI was found in the zip.

## Lib changes
- New ways proposed: none. The candidate "heading with a coloured prefix" fails W1 (the macro exists only in this class) and W2 (it grabs tokens, not a declared value), so it is rejected, not proposed.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
