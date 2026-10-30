no

# 0014-daniel-wambua-cv: Daniel Wambua CV (Awesome-CV fork, `resume-format` class)

- Unverified: read from the source, not compiled.
- Source: Source/0014-daniel-wambua-cv/ (origin: https://codeload.github.com/Daniel-wambua/cv/zip/refs/heads/main; licence: MIT, LICENSE:1-3, tex/README.txt:47)
- Kind: cv
- Lib: v0
- Engine: needs XeLaTeX (`fontspec` `\newfontfamily` with `Path=`, `unicode-math`, fontawesome.sty loads `fontspec`; tex/resume.tex:1, tex/resume-format.cls:83-93, tex/fontawesome.sty:9)
- Main file: tex/resume.tex (other samples: none; `template.jinja` is the same body with Jinja holes)
- Read: main yes, zip-local classes and styles all (tex/resume-format.cls 797 of 797 lines; tex/fontawesome.sty 683 lines: header, tail and a pattern check of lines 20-682, see Bespoke code)

## Verdict
No. Almost every look the sample uses reduces to lib ways (article, geometry, fancyhdr, fontspec, xcolor, tabular*, enumitem, ragged2e, tcolorbox, hyperref). One construct the sample uses at every section heading does not: `\@sectioncolor`, a hand-rolled counter plus three-token argument grabber that colours only the first three characters of each heading (tex/resume-format.cls:183-197, 276). No lib way or published package does that, and an emitter could only reproduce it by copying the macro or by splitting heading text itself with a magic number 3. The shipped Makefile/Python/Jinja pipeline is a data layer and is not counted (see Blockers).

## Blockers
- `BESPOKE` `\@sectioncolor` + `colorCounter`: `\def\@sectioncolor#1#2#3{{\color{\ifcase\value{colorCounter}...}#1#2#3}\stepcounter{colorCounter}}` is applied as `\color{text}\@sectioncolor #1` inside `\sectionstyle`, so the first three tokens of every `\cvsection` title get `awesome`, the rest `text` (tex/resume-format.cls:183-197, 276, 620-626; used at tex/resume.tex:86, 127, 148, 164, 178, 192). All six `\ifcase` branches and `\else` name `awesome` (cls:187-193), so the counter has no visible effect; the residual behaviour is the three-token split. Not reducible to any lib way.

Considered and NOT counted:
- `EXTERNAL` pipeline: `Makefile:21,37-39,42-43` generates `tex/resume.tex` from `resume.yml` + `template.jinja` with `lib/generate.py` (Jinja2, filters `latex_escape`, `format_date`, `markdown_to_latex`, lib/generate.py:34-90) and compiles with `lib/compile.py` (`xelatex -interaction=nonstopmode`, lib/compile.py:38). The checked-in `tex/resume.tex` is a complete standalone sample and the README says `xelatex resume.tex` alone produces the PDF (tex/README.txt:41), so the TeX template does not need the tool. The pipeline is what Flouest's emitter replaces. Flagged here so the consolidator can count it differently if it wishes. (`make clean` deletes `tex/resume.tex`, Makefile:51, so the .tex is a build product in the author's workflow.)
- `ART`: none. The pink header banner is `tcolorbox` (reduces to `box.tcolorbox`), the heading rule is a `\leaders\hrule` fill, not a drawing.

## Class setting
- Class: `class.article` options: none given by the sample (`\documentclass[]{resume-format}`, tex/resume.tex:9). The zip-local `resume-format.cls` is `\LoadClass{article}` (cls:55) with `draft`/`final` captured for `\overfullrule` (cls:48-49) and every other option passed on to article (cls:51-53). A4 comes from `\geometry`, not from a class option.
- Class-native vocabulary used (all zip-local, none from article): `\fontdir`, `\headerfirstnamestyle`, `\headerlastnamestyle`, `cvpersonalstatement`, `\cvsection`, `cventries`, `\cventry`, `cvitems`, `cvskills`, `\cvskill`, `cvachievements`. Not published: the class says it is "inspired by" Awesome-CV (cls:9, cls:25) but changes its layout code (fixed `0.72\textwidth` columns, `L{20.2cm}`, `needspace`, own personal-statement and achievements environments), so the lib's `cv.entries` family is not claimed. The original Awesome-CV source was not read here.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | tex/resume.tex:9; tex/resume-format.cls:55 | `class.article` | no options; unknown options forwarded (cls:51-53) |
| page geometry | tex/resume-format.cls:132 | `page.geometry` | a4paper, left=1.5cm, right=1.5cm, top=0.5cm, bottom=0.5cm, footskip=.5cm |
| line breaking | tex/resume-format.cls:135-137 | `sp.hyphenat`, `sp.lengths` | `\sloppy`; `\tolerance=1000`; `\emergencystretch=3em` (the two raw settings go to `sp.lengths`, closest home) |
| header/footer | tex/resume-format.cls:141-147 | `hf.fancyhdr` | `\fancyhfoffset{0em}`, `\headrulewidth=0pt`, `\fancyhf{}` (all empty), `\pagestyle{fancy}` |
| footer fields (macro unused) | tex/resume-format.cls:602-613 | `hf.fancyhdr` | `\fancyfoot[L/C/R]` with `\footerstyle` (9pt, `\footerfont`, `\scshape`, `lighttext`) |
| paragraph spacing | tex/resume-format.cls:105 | `sp.parskip-pkg` | default options |
| spacing package loaded, no commands used | tex/resume-format.cls:81 | `sp.setspace` | none used |
| fonts: main and families | tex/resume-format.cls:83-86, 204-256 | `font.fontspec` | `quiet`; `\defaultfontfeatures{Ligatures=TeX}`; `\setmainfont` and `\newfontfamily` x5 (`\headerfont`, `\headerfontlight`, `\footerfont`, `\bodyfont`, `\bodyfontlight`), family Roboto, `Path=\@fontdir` (=`fonts/`), `UprightFont=*-Regular`, `ItalicFont=*-Italic`, `BoldFont=*-Bold`, `BoldItalicFont=*-BoldItalic`; Light and Thin/Medium variants for the `light` families |
| math font package | tex/resume-format.cls:93 | `font.unicode-math` | loaded, no options, no math in the sample |
| 8-bit encoding branch (pdfTeX path, dead under XeLaTeX) | tex/resume-format.cls:87-91, 257-261; tex/resume.tex:10 | `font.fontenc-t1` | `fontenc[T1]`, `inputenc[utf8]`, `textcomp` |
| icons | tex/fontawesome.sty:6-18; tex/resume-format.cls:96; tex/resume.tex:57,59,61,168-170,197-200 | `font.icons` | icons used: `\faEnvelope`, `\faMapMarker`, `\faLink`, `\faStar`, `\faExternalLink`, `\faGithub`, `\faTrophy`, `\faFlag` |
| emoji to icon fallback | tex/resume-format.cls:99-103; used tex/resume.tex:168-170 | `NEW:font.newunicodechar` | four mappings to `{\color{awesome}\faTrophy}` / `\faFlag` |
| font sizes | tex/resume-format.cls:269-311 | `font.size-commands` | e.g. `\fontsize{32pt}{38pt}` name, `16pt/18pt` section, `12pt/14pt` entry title, `11pt/13pt` description, `9pt/1em` skills and achievements, `10pt/14pt` statement; `\scriptsize`, `\tiny` in the sample (resume.tex:197, 237) |
| colour | tex/resume-format.cls:154-180; tex/resume.tex:23 | `color.xcolor` | `\definecolor{...}{HTML}{...}` set (white FFFFFF, darkgray 333333, gray 5D5D5D, lightgray 999999, headerbg F04C8A, awesome-red 000000 ...), `\colorlet{text}{darkgray}`, `\colorlet{awesome}{awesome-red}` |
| link style | tex/resume-format.cls:107-115; tex/resume.tex:43-49 | `meta.hyperref` | class: empty pdftitle/author/subject/keywords, `colorlinks=false`, `allbordercolors=white`; sample (grouped around the banner): `colorlinks=true`, `linkcolor/urlcolor/citecolor=white`, `pdfborder={0 0 0}`; `\href`, `\phantomsection` |
| header banner | tex/resume.tex:11, 51-63 | `box.tcolorbox` | `[most]` library; `colback=headerbg, colframe=headerbg, arc=4mm, boxrule=0pt, left=0pt, right=0pt, top=6mm, bottom=6mm, width=\textwidth, enlarge left by=0mm, enlarge right by=0mm`; body in `center` with name styles, icon line separated by `\quad\|\quad` |
| name styling (banner) | tex/resume-format.cls:269-270; tex/resume.tex:55-56 | `font.size-commands`, `font.fontspec`, `mark.kernel`, `color.xcolor` | alias: `\fontsize{32pt}{38pt}\headerfont\bfseries\color{white}` |
| personal statement | tex/resume-format.cls:713-730; tex/resume.tex:72-79 | `list.enumitem`, `list.kernel`, `sp.ragged`, `sp.lengths`, `NEW:sp.manual-space` | `itemize[leftmargin=0ex, label={}, nosep, noitemsep, before=\cvparagraphstyle]` inside `justify` (ragged2e); `\fontsize{10pt}{14pt}`; `\parskip=2mm`; `\vspace{2mm}` before, `\vspace{1mm}` after |
| section heading | tex/resume-format.cls:617-626, 276, 480; used tex/resume.tex:86,127,148,164,178,192 | `head.titlesec`, `NEW:pg.needspace`, `meta.hyperref` | reduction: heading format 16pt/18pt `\bodyfont\bfseries` colour `text`, then `\color{gray}` rule `\leaders\hrule height 0.10pt\hfill` to the right margin on the same line (inline kernel primitives in the `\titleformat` code argument), `\addvspace{1.2ex}` above, `0.7ex` below, `\needspace{5\baselineskip}`, `\phantomsection`. BLOCKED only by the three-letter colouring (Blockers) |
| entry (job, degree) | tex/resume-format.cls:636-654; tex/resume.tex:87-141 | `tbl.tabular` | `tabular*{\textwidth}{@{\extracolsep{\fill}} p{0.72\textwidth} >{\raggedleft\arraybackslash}p{0.24\textwidth}}`, `\tabcolsep=3pt`, `\extrarowheight=1.5pt`, `\multicolumn{2}{p{\textwidth}}` description row, `\vspace{1.4mm}` after; every sample entry has non-empty title (#2) and empty location (#3), so the 3-row branch of `\ifempty{#2#3}` (cls:647-650) is the one printed |
| entry bullet list | tex/resume-format.cls:338-348; tex/resume.tex:93-97,103-108,114-118 | `list.enumitem`, `list.kernel`, `sp.ragged`, `sp.lengths` | `itemize[leftmargin=2ex, nosep, itemsep=0.8pt]`, `\labelitemi=\bullet`, `\parskip=0pt`, inside `justify`, `\vspace{-1.5mm}` / `\vspace{0.4mm}` |
| skills table | tex/resume-format.cls:733-747, 475; tex/resume.tex:150-156 | `tbl.tabular` | `tabular*{\textwidth}{@{\extracolsep{\fill}} l L{20.2cm}}`, `L` from `\newcolumntype{L}[1]{>{\raggedright\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}`, `\tabcolsep=1ex`, `\extrarowheight=0pt`; type bold 9pt, set 9pt light. Reading note: text width is 21cm - 2x1.5cm = 18.0cm by the geometry, narrower than the 20.2cm column |
| achievements, awards, projects | tex/resume-format.cls:699-710; tex/resume.tex:166-228 | `list.enumitem`, `list.kernel`, `sp.ragged`, `sp.lengths`, `NEW:sp.manual-space` | `itemize[leftmargin=0ex, label={}, nosep, noitemsep, before=\achievementstyle]`, `\fontsize{9pt}{1em}`, `\parskip=0.8mm`; sample sets `\itemsep=0mm` (resume.tex:167,181,195) |
| inline marks and links | tex/resume.tex:168-170,197-216 | `mark.kernel`, `meta.hyperref`, `NEW:sp.manual-space` | `\textbf`, `\href{url}{text}`, `\hfill`, `\\`, `\hspace{-5pt}`, `\raisebox{0.5pt}{\scriptsize\faStar}`, `\vspace{0.2mm}` |
| closing credit line | tex/resume.tex:235-243 | `font.size-commands`, `color.xcolor`, `meta.hyperref`, `NEW:sp.manual-space` | `center`, `\tiny\color{lightgray}`, two `\href`, `\vspace{1.5mm}` |
| box length | tex/resume.tex:40 | `sp.lengths` | `\setlength\fboxsep{10pt}` (no `\fbox` in the sample; tcolorbox does not read it) |

Not defined or used by the sample or the class: columns, abstract, contents, heading numbering, quotes (the class overwrites `\quote`, cls:425), notes, math, theorems, floats, captions, code, bibliography, index, language packages, cross-references beyond hyperref anchors.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\@sectioncolor`, `colorCounter`, `\sectionstyle` | cls:183-197, 276 | **No** | partial three-token colouring with a counter and `\ifcase` (all branches `awesome`); no lib way, see Blockers |
| `\vhrulefill` | cls:480 | Yes, borderline | `\leaders\hrule\@height#1\hfill\kern\z@` is a single TeX-primitive rule fill; placed in the `head.titlesec` code argument (kernel `\hrulefill` has a fixed thickness, so the primitive is used) |
| `\cvsection`, `\cvsubsection` | cls:617-633 | Yes except the item above | `head.titlesec` + `NEW:pg.needspace` + `meta.hyperref` (`\phantomsection`), parameters in the component map |
| `\cventry`, `\cvsubentry`, `cventries`, `cvsubentries` | cls:636-679 | Yes | `tbl.tabular` with `tabular*`, p-columns and `\multicolumn`; `\ifempty` / `\ifthenelse` only choose whether the title/location row exists, which the emitter resolves per entry |
| `cvhonors` / `\cvhonor` (unused) | cls:682-696 | Yes | `tbl.tabular`, `tabular*` with `C{1.5cm} L{13.0cm} R{2.5cm}` |
| `cvitems`, `cvparagraphs`, `cvparagraph`, `cvachievements`, `cvpersonalstatement`, `cvskills` / `\cvskill`, `cvlinks`, `cvfooterlink` | cls:338-361, 699-770, 786-796 | Yes | `list.enumitem` / `tbl.tabular` + `sp.ragged` (`justify`, `flushright`) + `sp.lengths` + `NEW:sp.manual-space`; options in the component map. Oddity: a one-argument macro (`\achievementstyle`, `\cvparagraphstyle`, `\descriptionstyle`) is passed as enumitem `before=` code (cls:354, 704, 723, 790); the reduction uses the font/size/colour it sets instead |
| `\renewenvironment{cvpersonalstatement}` | cls:713 | Yes | `\renewenvironment` targets an environment with no earlier definition in the zip (one occurrence in cls); the kernel is expected to report it undefined and `compile.py` tolerates a non-zero exit when a PDF appears (lib/compile.py:44-52). Reduces as a plain environment, see component map |
| all `\*style` macros | cls:269-311 | Yes | `\newcommand` aliases of `\fontsize`, font family switch, `\bfseries`/`\scshape`/`\slshape`, `\color` |
| `\fontdir`, `\@fontdir` | cls:122-123; tex/resume.tex:13 | Yes | the `Path=` parameter of `font.fontspec`. In the sample `\fontdir[fonts/]` is called after the class has already loaded the families with the default `fonts/` (same value) |
| `\newfontfamily` x5, `\setmainfont`, `\ifxetex` branch | cls:83-91, 204-261 | Yes | `font.fontspec`; the non-XeTeX branch is dead because `unicode-math` and fontawesome.sty need XeLaTeX or LuaLaTeX |
| colour definitions | cls:154-180 | Yes | `color.xcolor` |
| `\newcolumntype{L,C,R}` | cls:475-477 | Yes | `tbl.tabular` (`array` column types) |
| `fontawesome.sty` (zip-local, v4.4.0 dated 2015/11/04) | tex/fontawesome.sty:6-18, 20-682 | Yes | 663 lines, all of the exact form `\expandafter\def\csname faicon@<name>\endcsname {\symbol{"F...}} \def\fa<Name> {{\FA...}}` (a grep for any line of lines 20-682 not matching it returned 0). Pure icon-name table over `\newfontfamily{\FA}[Path=fonts/]{FontAwesome}`; same macro names come from the published `fontawesome` package: `font.icons` |
| `\newunicodechar` x4 | cls:99-103 | Yes | `NEW:font.newunicodechar` printing `{\color{awesome}\faTrophy}` / `\faFlag` (`color.xcolor`, `font.icons`) |
| `\displayurl`, `\shortdisplayurl` (unused) | cls:314-315 | Yes | `\href` + `\nolinkurl` / `\url` (`meta.hyperref`, `meta.url`) |
| `\shorturl` (expl3, unused) | cls:318-333 | Yes, as emit-time text | trims a leading `https://` or `http://` from the displayed URL with `\tl_range`, then `\href{url}{\url{trimmed}}`; the emitter prints the already-trimmed display string (`meta.hyperref`, `meta.url`). It is string handling, not layout |
| `\markdownlink`, `\processMarkdownLinks` (unused) | cls:774-784 | Yes (dead code) | their effect is `\href{url}{text}`; `\markdownlink` tests a `shownotes` boolean that is never defined in the zip, so it is not callable as written |
| `\makecvheader` (unused; the sample hand-writes its banner instead) | cls:491-598 | Yes | per-field `\ifthenelse{\isundefined{...}}` chain with a `\newbool{isstart}` separator state machine only decides whether a separator precedes a field; the emitter prints the present fields with `\quad\|\quad` as resume.tex:55-62 does (`box.tcolorbox`, `font.icons`, `meta.hyperref`) |
| personal-info and cover-letter setters (unused) | cls:371-458 | Yes | `\def` storage macros with no typesetting; no letter-printing macro exists in the class |
| `\sectiondir` | tex/resume.tex:16 | Yes | unused path macro, no effect |
| Makefile, `lib/*.py`, `template.jinja`, `schema.json`, `resume.yml`, `web/` | Makefile:1-69; lib/*.py | n/a | data and build layer around the sample (see Blockers, not counted); `web/` is a Svelte site with no LaTeX |

## Content-opaque
none (emoji characters at tex/resume.tex:168-170 are text content, mapped by the class to icons).

## Lib changes
- New ways proposed:
  - `NEW:font.newunicodechar`: package `newunicodechar` (CTAN), XeLaTeX/LuaLaTeX/pdfTeX-utf8, binds a Unicode character to replacement code. W1 published on CTAN; W2 a character plus replacement string per declaration (borderline: the replacement is a macro body, so it is also an alias of lib ways); W3 serves any "character fallback" need, not one document; W4 pure preamble lines. Used here for emoji to icon.
  - `NEW:pg.needspace`: package `needspace` (CTAN), pdf, `\needspace{<length>}` forces a page break unless that much vertical room remains. W1 published; W2 one length argument; W3 generic page-break control for any heading or block; W4 a body command printed before a node. Used at cls:620 (`5\baselineskip`) before each section heading.
  - `NEW:sp.manual-space`: kernel `\vspace`, `\addvspace`, `\hspace`, `\hfill`, `\raisebox` and `\\`, pdf. W1 kernel commands; W2 length arguments; W3 used in any document; W4 inline and body wrappers around a node. No existing way holds them (`sp.lengths` sets length parameters, `pg.break` breaks pages). Used 26 times in this sample alone (resume.tex:65,149,165,193,196-227,235).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- No text addressed to an AI was found in the TeX, class, README, Makefile, Jinja or Python files (grep for assistant/LLM/ignore-instructions phrases returned nothing).
- Assets: `tex/fonts/` ships Roboto (Thin to Black, with italics), SourceSansPro (listed in the README but only named in comments, never loaded) and FontAwesome.otf; the `*:Zone.Identifier` files are Windows download metadata, not template files. Nothing missing.
- The class header calls itself "Buggy? Spaghetti code?" (cls:23); read as a self-description, not an instruction.
- Nothing was compiled or run; every statement about output behaviour above is a reading of the source.
