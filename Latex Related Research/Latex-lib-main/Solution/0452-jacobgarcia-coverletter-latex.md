yes

# 0452-jacobgarcia-coverletter-latex: Awesome-CV style cover letter (jacobgarcia copy)

- Unverified: read from the source, not compiled.
- Source: Source/0452-jacobgarcia-coverletter-latex/ (origin: https://codeload.github.com/jacobgarcia/coverletter-latex/zip/refs/heads/master; licence: not established by the manifest; the class header says LPPL v1.3c at awesome-cv.cls:17, the sample header says CC BY-SA 4.0 at coverletter.tex:12-13)
- Kind: letter (a cover letter under a CV-style name header)
- Lib: v4
- Engine: needs XeLaTeX (`fontspec` `\newfontfamily` with `Path=` OTF/TTF files at awesome-cv.cls:177-216, `unicode-math` loaded unconditionally at awesome-cv.cls:80, zip-local fontawesome.sty loads `fontspec` at fontawesome.sty:9; the `\ifxetex` fallback at awesome-cv.cls:70-78 is dead because those three are not inside it; the sample's first line is `%!TEX TS-program = xelatex`, coverletter.tex:1)
- Look carried by: zip-local (awesome-cv.cls defines every style and every body command the sample calls; fontawesome.sty only binds icon names to glyph codes; the sample preamble adds one `\colorlet` and the font directory)
- Class origin: zip-local (ctan.org/pkg/awesome-cv returned 404; the zip is a user copy of the Awesome-CV project, not an official release; the class loads `article` underneath)
- Main file: coverletter.tex (other samples: none)
- Read: main yes, zip-local classes and styles all (coverletter.tex 105 of 105 lines, awesome-cv.cls 665 of 665, fontawesome.sty 682 of 682); fonts/ ships FontAwesome.otf, Roboto and SourceSansPro files, none missing; coverletter-0.png shows the upstream Awesome-CV example (another name and text), so it is not evidence for this sample, and coverletter.pdf was not opened; no text addressed to an AI was found

## Verdict
Yes. The look is carried by a zip-local class, but its whole effect is `\LoadClass{article}` plus published packages with declarative options, font and size switches, colours, `tabular*` rows and a `\leaders\hrule` fill, so an emitter can write the preamble and inline each body macro as kernel and published commands, with no copied macro logic; the `\isundefined` and `\ifbool` tests only decide whether an optional field is printed, and the one counter (`colorCounter`) is inert. The weak point is `\@sectioncolor`, which colours the first three characters of each heading: an emitter reproduces it as `\textcolor{awesome}{<first three characters>}<rest>`, a split of content at emit time like the letter and rest arguments of the drop-cap way (sp.lettrine). If a reviewer holds that split to be macro logic, it becomes `BESPOKE/class` and the answer flips to no.

## Blockers
none

## Class setting
- Class: `class.article` options: `11pt`, `a4paper` (coverletter.tex:21); the zip-local class passes every option except `draft` and `final` on to `article` (awesome-cv.cls:36-43). awesome-cv itself is not a published class here, so no class way is claimed for it.
- Class-native vocabulary used (awesome-cv.cls, zip-local): `\fontdir[..]` (coverletter.tex:24); data setters `\name{}{}` `\address` `\mobile` `\email` `\homepage` `\github` `\linkedin` `\position` `\quote` (coverletter.tex:50-61); `\letterdate` `\lettertitle` `\letteropening` `\letterclosing` (coverletter.tex:67-70); `\makecvfooter{l}{c}{r}` (coverletter.tex:77); `\makecvheader` (coverletter.tex:84); `\makelettertitle` (coverletter.tex:87); `cvletter` environment and `\cvparagraph{title}` (coverletter.tex:90-100); `\makeletterclosing` (coverletter.tex:103); colour name `awesome` set by `\colorlet` (coverletter.tex:34).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | coverletter.tex:21; awesome-cv.cls:43 | `class.article` | `11pt`, `a4paper`; loaded by `\LoadClass{article}` inside the zip-local class |
| paper and point size | coverletter.tex:21; awesome-cv.cls:39-41 | `page.class-options` | `a4paper`, `11pt` passed to article |
| page geometry | awesome-cv.cls:56, 111 | `page.geometry` | left=2.0cm, top=1.5cm, right=2.0cm, bottom=2.0cm, footskip=.5cm |
| footer | awesome-cv.cls:58, 115-121, 494-505; coverletter.tex:77-80 | `hf.fancyhdr` | `\fancyhfoffset{0em}`, `\headrulewidth` 0pt, `\fancyhf{}`, `\pagestyle{fancy}`; `\fancyfoot[L]` `[C]` `[R]` each hold `\footerstyle{..}`; values `\today`, `Jacob Garcia~~~·~~~Cover Letter`, `Keela` |
| date (footer and letter) | coverletter.tex:67, 78 | `front.maketitle` | kernel `\today` only (kernel date family; no `datetime` package) |
| paragraph spacing | awesome-cv.cls:85 | `sp.parskip-pkg` | no options |
| line spacing of address | awesome-cv.cls:68, 644-646 | `sp.setspace` | `singlespace` environment around the recipient address |
| manual spacing and breaks | awesome-cv.cls:401, 403, 405, 488, 628, 632, 638, 656; coverletter.tex:59 | `sp.manual-space` | `\vspace` 0.4mm, 0.4mm, -0.5mm, 6.0mm and 5.0mm, 8.4mm, 3.4mm; `\addvspace` 2.5ex before and 0.4ex after a paragraph heading, 1.5ex and 1ex around a section; `\\` and `\\\\`; `\enskip` |
| heading rule | awesome-cv.cls:382, 513, 631 | `sp.rule` | `\leaders\hrule\@height{0.9pt}\hfill\kern\z@` (kernel rule and leaders, rule only); colour `gray` |
| alignment | awesome-cv.cls:54, 377-379, 394, 605 | `sp.ragged` | `ragged2e`; `\raggedright` `\centering` `\raggedleft` inside the L, C, R column types; `center` environment for the header; `justify` environment in `cvitems` |
| raw lengths | awesome-cv.cls:36-37, 533-534, 556, 571-572, 588-589, 607 | `sp.lengths` | `\overfullrule` 5pt or 0pt (draft/final), `\tabcolsep` 0pt or 1ex, `\extrarowheight` 0pt, `\leftskip` 0.2cm, `\parskip` 0pt |
| text and display fonts | awesome-cv.cls:71-73, 177-216; coverletter.tex:24 | `font.fontspec` | `[quiet]`, `Ligatures=TeX`; five `\newfontfamily` with `Path=\@fontdir` (fonts/): `\headerfont` Roboto Regular/Italic/Bold/BoldItalic, `\headerfontlight` Roboto Thin/ThinItalic with Medium/MediumItalic as bold, `\footerfont` SourceSansPro Regular/It/Bold, `\bodyfont` SourceSansPro Regular/It/Bold/BoldIt, `\bodyfontlight` Light/LightIt with Semibold/SemiboldIt as bold |
| math font | awesome-cv.cls:80 | `font.unicode-math` | no options |
| icons | awesome-cv.cls:83, 412, 423, 433, 443, 463; fontawesome.sty:6-14, 20-682 | `font.icons` | package `fontawesome` (CTAN has the same package; the zip copy only binds names to glyph codes in `fonts/FontAwesome.otf`); icons `\faMobile` `\faEnvelope` `\faHome` `\faGithubSquare` `\faLinkedinSquare`, unused here `\faStackOverflow` `\faTwitter` `\faSkype` |
| sizes | awesome-cv.cls:224-266 | `font.size-commands` | `\fontsize{pt}{lead}` pairs: 32pt/1em (name), 7.6pt (position), 8pt (address, footer), 6.8pt (contact line), 9pt (quote, letter date), 14pt (paragraph heading), 16pt (section), 11pt (recipient), 10pt/1.4em (letter text) and others as listed |
| weights and shapes | awesome-cv.cls:224-266 | `mark.kernel` | `\bfseries` `\scshape` `\itshape` `\slshape` `\upshape` `\mdseries` |
| underlined letter title | awesome-cv.cls:262 | `mark.ulem` | underline type; this is the kernel `\underline` (`ulem` is not loaded) |
| colours | awesome-cv.cls:60, 128-153; coverletter.tex:34 | `color.xcolor` | `\definecolor{..}{HTML}{..}`: white FFFFFF, black 000000, darkgray 333333, gray 5D5D5D, lightgray 999999, darktext 414141, eight `awesome-*` colours; `text`=darkgray, `graytext`=gray, `lighttext`=lightgray; `awesome`=`awesome-emerald` (coverletter.tex:34 overrides awesome-cv.cls:153) |
| links and metadata | awesome-cv.cls:87-95, 423, 433, 443, 511, 629 | `meta.hyperref` | `pdftitle` `pdfauthor` `pdfsubject` `pdfkeywords` empty, `colorlinks=false`, `allbordercolors=white`; `\href` to `mailto:`, `http://`, `https://github.com/`; `\phantomsection` anchors |
| front matter: name header | awesome-cv.cls:393-490; coverletter.tex:50-61, 84 | composed of `sp.ragged`, `font.size-commands`, `mark.kernel`, `color.xcolor`, `font.icons`, `meta.hyperref`, `sp.manual-space` | no single way names a hand-laid header; `center` environment; first name `\headerfontlight` graytext, last name `\headerfont\bfseries` text, position `\bodyfont\scshape` awesome, address `\headerfont\itshape` lighttext, contact line `\headerfont` text with separator `\quad\textbar\quad` (awesome-cv.cls:369), quote `\bodyfont\itshape` darktext |
| letter structure | awesome-cv.cls:637-665; coverletter.tex:67-70, 87, 103 | composed of `tbl.tabular`, `sp.setspace`, `mark.ulem`, `font.size-commands`, `mark.kernel`, `color.xcolor`, `sp.manual-space` | recipient and date in a `tabular*` row, address, underlined title, opening, closing, name, optional enclosure line; hand-laid, kernel `\opening` and `\closing` are not used, so the letter-commands way (ltr.opening) is not claimed |
| tables (letter row and CV entries) | awesome-cv.cls:50, 377-379, 535, 555, 573, 590, 641 | `tbl.tabular` | `tabular*` of `\textwidth` with `@{\extracolsep{\fill}}`; `\newcolumntype` L, C, R as `m{w}` with `\raggedright`/`\centering`/`\raggedleft` and `\arraybackslash`; widths 12.5cm and 4.5cm (letter row, `\cventry`, `\cvsubentry`), 1.5cm 13.0cm 2.5cm (`cvhonors`), r and 15.2cm (`cvskills`) |
| paragraph headings | awesome-cv.cls:157-170, 259, 627-633; coverletter.tex:91, 94, 97 | `head.titlesec` | emission form for a heading node, since `\cvparagraph` is not a sectioning command; format `\fontsize{14pt}{1em}\bodyfont\bfseries\color{text}`, first three characters in `awesome`, space before 2.5ex and after 0.4ex with `\nobreak`, trailing 0.9pt gray rule to the margin; `\cvsection` (awesome-cv.cls:509-515, 16pt, 1.5ex, 1ex) and `\cvsubsection` (awesome-cv.cls:519-522, 12pt `\scshape`) are not used by the sample |
| letter body text | awesome-cv.cls:264, 620-623; coverletter.tex:90-100 | `font.size-commands` | switch `\fontsize{10pt}{1.4em}\bodyfont`-light `\upshape\color{graytext}` as `\lettertextstyle`, opened by `cvletter`; combined with `font.fontspec`, `mark.kernel`, `color.xcolor` |
| itemize lists (class, not used) | awesome-cv.cls:52, 603-613 | `list.enumitem` | `itemize[leftmargin=2ex, nosep, noitemsep]`, `\labelitemi` as `\bullet` (kernel label, `list.kernel`) |
| not defined or used | whole zip | none | abstract, contents, theorems, maths, floats, captions, code, bibliography, index, notes, languages, backgrounds |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| whole class `awesome-cv` | awesome-cv.cls:24-665 | yes | `\LoadClass{article}` (`class.article`) plus the preamble ways in the map above, in the class's loading order; every body macro inlined as below |
| `fontawesome.sty` copy | fontawesome.sty:6-682 | yes | 663 `\def` lines of one pattern (name to glyph code in `FontAwesome.otf`) and no logic; replace by CTAN `fontawesome` (`font.icons`), ship `fonts/FontAwesome.otf` |
| `\@sectioncolor` and `colorCounter` | awesome-cv.cls:156-170, 231, 259 | yes (weak point) | the `\ifcase` gives `awesome` in every branch, so the counter drives nothing; the macro takes three undelimited arguments, so it is `\textcolor{awesome}{first three characters}` then the rest; the emitter splits the plain-text title |
| `\vhrulefill` | awesome-cv.cls:382 | yes | `sp.rule`: `\leaders\hrule\@height{0.9pt}\hfill\kern\z@` written inline |
| `\ifempty`, `\ifthenelse` and `\isundefined` tests | awesome-cv.cls:385, 402-404, 409-484, 486, 536, 557-564, 647, 659 | yes | field-presence tests; the emitter prints only fields that exist (inline expansion, as the v4 log does for its rejected xspace line); `etoolbox`, `xifthen`, `ifxetex` are only helpers for this and vanish (considered, not proposed) |
| `isstart` boolean and separator logic | awesome-cv.cls:407-484 | yes | `\newbool` runs once inside a group; with `\@mobile` set the first test is false, so the emitter writes the separator `\quad\textbar\quad` between the printed items; the `istart` spelling at awesome-cv.cls:420 etc. is never reached in this sample (by reading) |
| data setters `\name` `\address` ... `\letterenclosure` | awesome-cv.cls:277-360 | yes | `\def` holders for strings; the strings are content and are written where printed |
| `\renewcommand*{\quote}` | awesome-cv.cls:327 | yes | holds the header quote string; inlined into the header (`\headerquotestyle`, awesome-cv.cls:229, 488); consequence: the kernel `quote` environment is unusable under this class, so the kernel quote way (quote.kernel) is not available to this template |
| `\fontdir`, `\@fontdir` | awesome-cv.cls:102-103; coverletter.tex:24 | yes | the `Path=fonts/` value of `font.fontspec` |
| style macros `\headerfirstnamestyle` ... `\letterenclosurestyle` | awesome-cv.cls:224-266 | yes | `\newcommand` aliases of font family, `\fontsize`, shape and `\color` switches; parameters listed in the map |
| `\makecvfooter` | awesome-cv.cls:494-505 | yes | three `\fancyfoot` calls (`hf.fancyhdr`) |
| `\makecvheader`, `\makelettertitle`, `\makeletterclosing`, `cvletter`, `\cvparagraph` | awesome-cv.cls:393-490, 620-665 | yes | inlined as `center` or `tabular*` blocks of styled text; `\lettertextstyle{..}` at awesome-cv.cls:650 and 657 is a switch written before a braced group, so by reading it stays in force to the end of the document; the emitter writes the same switch inside an explicit group around the letter text |
| CV entry commands (not used) | awesome-cv.cls:525-613 | yes | `\cventry`, `\cvhonor`, `\cvskill`, `\cvitems` reduce to `tabular*` rows and `itemize`; `\cvsubentry` as written (awesome-cv.cls:557-561) puts three cells into a two-column row when its first argument is non-empty (by reading); it is not used and not relied on |
| `\sectiondir` | coverletter.tex:27 | yes | defined and never referenced (a search of the zip finds only the definition); inert |
| unset recipient and enclosure fields | awesome-cv.cls:642, 645, 659-664; coverletter.tex:50-103 | yes | by reading, coverletter.tex calls no `\recipient` and no `\letterenclosure`, so `\@recipientname` and `\@recipientaddress` are never set; the emitter omits those rows and the enclosure line (a defect of the sample, not template code) |
| local edit of the LinkedIn link | awesome-cv.cls:463 | yes | the target is `https://github.com/jacobgarcia/\@linkedin`, a string parameter of `meta.hyperref` |
| `Makefile` | Makefile:3 | n/a | not template code; loops `xelatex` over `examples/*.tex` (no such folder); it generates no `.tex`, so there is no EXTERNAL blocker |

## Content-opaque
none

## Lib changes
- New ways proposed: none. Considered: `etoolbox`, `xifthen`, `ifxetex` (macro-programming helpers used only inside the zip-local macros above; they vanish on inline expansion, so no printed component).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
