no

# 0117-themagicalmammal-resume: Russell Group CV (`russell` class, an Awesome-CV derivative)

- Unverified: read from the source, not compiled.
- Source: Source/0117-themagicalmammal-resume/ (origin: https://codeload.github.com/themagicalmammal/Resume/zip/refs/heads/RussellGroupCV; licence: LPPL-1.3c, LICENSE:4)
- Kind: cv
- Lib: v2
- Engine: needs XeLaTeX (`fontspec` and `unicode-math` loaded unconditionally, lib/configs/packages.tex:27,31; README.md:14,131 say build with XeLaTeX); `biber` is also needed for the Publications section (lib/templates/publications.tex:18)
- Look carried by: zip-local (russell.cls is a thin loader, russell.cls:28-50; every look setting lives in the lib/ files it inputs; the sample preamble only sets geometry, one colour, one boolean and three skips, resume.tex:8,16,28,30-31,34)
- Class origin: zip-local (`russell` is not on CTAN: ctan.org/pkg/russell returned 404; it is a renamed copy of Awesome-CV, russell.cls:4 `v1.6.1` and README.md:125 credit posquit0/Awesome-CV, and ctan.org/pkg/awesome-cv also returned 404; not an official release)
- Main file: resume.tex (other samples: none; lib/templates/cover-letter.tex is a letter building block the sample never calls)
- Read: main yes, zip-local classes and styles all (russell.cls, content/*.tex, lib/commands/*.tex, lib/configs/*.tex, lib/templates/*.tex read in full; the TTF files in lib/fonts are not read and nothing loads them, see Bespoke code; published packages roboto, sourcesanspro, fontawesome5, biblatex not read)

## Verdict
No, on two blockers, and one judgement call decides how many there are. The class and lib/ files are almost entirely `\LoadClass{article}` plus published packages and macros that are compositions of lib ways (tabular rows, fontspec faces, colours, a leader rule, a minipage header), so they reduce. Two things do not: the hand-written biblatex bibliography drivers (publications.tex:36-148), which are field-printing programs rather than option values, and the optional photo frame, a tikz node that crops an image to a circle (structure.tex:16-18), which is template artwork with no declarative lib way. The photo is commented out in the sample (content/personal-info.tex:6) but sits in the class, so it is in scope. A reviewer who treats biblatex's driver API as a parameter, and a photo crop as content, could flip this to `yes`; I did not, because a wrong yes costs more.

## Blockers
- `BESPOKE/class` custom biblatex bibliography drivers for article, inproceedings, incollection, misc and report, plus per-type `\DeclareFieldFormat` and a hand-written `\DeclareNameFormat{author}`; field order, `\newunit`/`\setunit` punctuation and a `listcount` conditional decide what is printed, and `\DeclareBibliographyDriver` extends biblatex's code rather than setting an option (lib/templates/publications.tex:30-34,36-133,136-148; loaded at russell.cls:50; used at content/publications.tex:11-33)
- `ART/class` tikz photo frame: `\begin{tikzpicture}\node[circle|rectangle, draw=..., line width=0.3mm, inner sep=..., fill overzoom image=\@photo]` with a bordered, cropped image slot in the header; no lib way crops an image to a shape, `art.tikz` is a restricted way (lib/commands/structure.tex:7-20; options parsed at lib/commands/personal-info.tex:6-19); not exercised by the sample (content/personal-info.tex:6 is commented out)

## Class setting
- Class: `class.article` (russell.cls:22 `\LoadClass{article}`); options `11pt, a4paper` (resume.tex:5) are forwarded to article by `\DeclareOption*` (russell.cls:18-20); `draft`/`final` only set `\overfullrule` (russell.cls:15-16). The zip-local `russell` class is not itself a way: it reduces to `class.article` plus the rows below.
- Class-native vocabulary used (all zip-local, none published): `\name{}{}` `\address{}` `\mobile{}` `\email{}` `\homepage{}` `\github{}` `\linkedin{}` (content/personal-info.tex:7-16), `\makecvheader` (content/header.tex:4), `\makecvfooter{}{}{}` (content/footer.tex:3-6), `\cvsection` and `\cvsubsection` (content/summary.tex:4; content/publications.tex:9), `cvparagraph`, `cventries` with `\cventry{}{}{}{}{}`, `cvitems` with `\cvtechskills` and `\cvsoftskills` (content/experience.tex:10-25), `cvskills`/`\cvskill`, `cvhonors`/`\cvhonor`, `cvinterests`/`\cvinterest`, `cvlanguages`/`\cvlanguage`, settings `\colorlet{russell}{...}`, `\setbool{acvSectionColorHighlight}`, `\renewcommand{\acvSectionTopSkip}`, `\acvSectionContentTopSkip`, `\acvHeaderSocialSep` (resume.tex:16,28,30-31,34), `\fontdir` (resume.tex:11). Biblatex vocabulary: `\addbibresource`, `refsection`, `\nocite`, `\newrefcontext`, `\printbibliography` (resume.tex:45; content/publications.tex:11-19).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | resume.tex:5; russell.cls:22 | `class.article` | 11pt, a4paper |
| paper and point size | resume.tex:5; russell.cls:18-20 | `page.class-options` | a4paper, 11pt |
| margins | resume.tex:8 (overrides the defaults at lib/configs/layout.tex:13) | `page.geometry` | left=1.4cm, top=.8cm, right=1.4cm, bottom=1.8cm, footskip=.5cm |
| header and footer fields | lib/configs/layout.tex:17-23; lib/commands/structure.tex:175-180; content/footer.tex:3-6 | `hf.fancyhdr` | `\fancyhfoffset{0em}`, `\headrulewidth` 0pt, `\fancyhf{}`, `\pagestyle{fancy}`; foot L=`\today`, C empty, R=`\thepage`, each in `\footerstyle` (8pt, Source Sans Pro, small caps, colour lighttext) |
| paragraph spacing | lib/configs/packages.tex:39; lib/commands/structure.tex:262 | `sp.parskip-pkg` | defaults; cvitems resets `\parskip` to 0pt (`sp.lengths`) |
| table and list lengths | lib/commands/structure.tex:221-222,242-245; lib/templates/skills.tex:9-10; lib/templates/achievements.tex:9-10 | `sp.lengths` | `\tabcolsep` 0pt (1ex in cvskills), `\extrarowheight` 0pt, `\leftskip` 0.2cm (cvsubentry), `\overfullrule` 5pt or 0pt (russell.cls:15-16) |
| manual vertical spacing | lib/commands/structure.tex:185,194-195,202-207,220,230,259,267; lib/commands/utilities.tex:7-17; resume.tex:30-31 | `sp.manual-space` | `\vspace` of -4mm..2.5mm around entries; header skips .4mm, -.5mm, 6mm, 5mm; section skips set to 0.0mm in the sample; `\\[len]` after name and social lines |
| alignment | lib/configs/packages.tex:9; lib/commands/structure.tex:34,213,235,260; lib/commands/utilities.tex:24-26; resume.tex:73 | `sp.ragged` | `ragged2e` `justify` environment in cvitems; `center` environment around entries; `\raggedright`/`\centering`/`\raggedleft` in the L, C, R column types and header; closing line `\centering` |
| section rule | lib/commands/utilities.tex:29; lib/commands/structure.tex:188 | `sp.rule` | `\leaders\hrule\@height0.9pt\hfill\kern\z@` after the heading text, colour `sectiondivider` (gray 5D5D5D) |
| engine fonts | lib/configs/packages.tex:27,29 | `font.fontspec` | `[quiet]`, `\defaultfontfeatures{Ligatures=TeX}` |
| math fonts | lib/configs/packages.tex:31 | `font.unicode-math` | defaults (no maths in the sample) |
| text faces | lib/configs/packages.tex:34-35; lib/configs/fonts.tex:4-8 | `font.helvet` | package `roboto` for header (`\roboto`, `\robotolight`); package `sourcesanspro` with `[default,opentype]` for body and footer (`\sourcesanspro`, `\sourcesansprolight`) |
| icons | lib/configs/packages.tex:33; lib/commands/structure.tex:45,52,65,71,95; lib/templates/projects.tex:25 | `font.icons` | `fontawesome5`: `\faMobile` `\faEnvelope` `\faHome` `\faGithubSquare` `\faLinkedin` in the sample header; `\faLink` in `\cvproject` |
| sizes and shapes | lib/configs/styles.tex:6-52 | `font.size-commands` | `\fontsize{Npt}{1em}\selectfont`: name 20pt, position 7.6pt, address 8pt, social 6.8pt, section 16pt, subsection 12pt, entry title 10pt, body and description 9pt, date 8pt, skill type 10pt, footer 8pt |
| font shapes | lib/configs/styles.tex:6-52 | `mark.kernel` | `\bfseries` `\scshape` `\itshape` `\slshape` `\mdseries` `\upshape` `\textbf` |
| colours | lib/configs/packages.tex:15; lib/configs/colors.tex:5-33; resume.tex:16 | `color.xcolor` | `\definecolor` HTML sets (darkgray 333333, gray 5D5D5D, lightgray 999999, darktext 414141, russell-* family); `\colorlet{text}{darkgray}`, `graytext`, `lighttext`, `sectiondivider`; `\colorlet{russell}{russell-black}` |
| section title colour trick | lib/configs/colors.tex:36-42; lib/configs/styles.tex:13; resume.tex:28 | `color.xcolor` | `\@sectioncolor#1#2#3` colours the first three characters of each section title in `russell` when `acvSectionColorHighlight` is true (preview.jpg shows "Per", "Edu"); reducible as an emitter-side span, see Bespoke code |
| CV header block | content/header.tex:4; lib/commands/structure.tex:6-171,30-33,168-170 | `box.minipage` | three `minipage[c]` (photo slots 0cm wide when no photo, centre column `\textwidth`); `\centering`; name, address and one social line of `\href` items with icons, separated by `\quad\textbar\quad` (resume.tex:34) |
| header links | lib/configs/packages.tex:41-47,49; lib/commands/structure.tex:45-161 | `meta.hyperref` | `hidelinks,unicode,pdfpagelabels=false`; `\hypersetup` with empty pdftitle, pdfauthor, pdfsubject, pdfkeywords; `\href{tel:}` `\href{mailto:}`; `\phantomsection` anchors (structure.tex:187,197) |
| bookmarks | lib/configs/packages.tex:49 | `meta.bookmark` | load only |
| section heading | lib/commands/structure.tex:184-189; lib/configs/styles.tex:13 | `head.titlesec` | reduction of `\cvsection` (it does not use `\section`): 16pt bold Source Sans Pro, colour text, title then the `sp.rule` leader on the same line, `\vspace{\acvSectionTopSkip}` before |
| subsection heading | lib/commands/structure.tex:193-198; lib/configs/styles.tex:14; content/publications.tex:9,24 | `head.titlesec` | reduction of `\cvsubsection`: 12pt small caps, colour text, `\vspace{-3mm}` before |
| profile paragraph | lib/commands/structure.tex:201-208; lib/configs/styles.tex:15; content/summary.tex:10-14 | `sp.manual-space` | `\vspace{-3mm}`, 9pt light upshape colour text, `\par\vspace{2mm}` after (font part is `font.size-commands`) |
| entry rows (education, experience, projects) | lib/commands/structure.tex:211-231; lib/commands/utilities.tex:24-26; content/education.tex:13-24 | `tbl.tabular` | `tabular*{\textwidth}` with `@{\extracolsep{\fill}}`, columns `L{\textwidth - 4.5cm}` `R{4.5cm}` (`\newcolumntype` over `m{}` with `\raggedright`/`\raggedleft` and `\arraybackslash`); row 1 title and location, row 2 position and date, `\multicolumn{2}{L{\textwidth}}` description; `calc`-style widths |
| bullet lists in entries | lib/commands/structure.tex:258-268; content/education.tex:19-23 | `list.enumitem` | `itemize[leftmargin=2ex, nosep, noitemsep]`, `\labelitemi` = `\bullet`, inside `justify` (`sp.ragged`) |
| labelled bullets | lib/commands/structure.tex:274-275; content/experience.tex:23-24 | `list.kernel` | `\item{\textbf{Technical Skills:} ...}` and `Soft Skills:` (alias macros, `mark.kernel`) |
| skills, languages, interests | lib/templates/skills.tex:5-20; lib/templates/languages.tex:8,11; lib/templates/interests.tex:8,11 | `tbl.tabular` | `tabular*` with `r` and `L{\textwidth * \real{0.9}}`; `\tabcolsep` 1ex; type 10pt bold darktext, value 9pt light text; languages and interests alias the skills macros |
| achievements | lib/templates/achievements.tex:5-20; content/achievements.tex:11-44 | `tbl.tabular` | `tabular*` columns `C{1.5cm}` `L{\textwidth - 4.0cm}` `R{2.5cm}`; date, "position, title", location |
| bibliography options | lib/templates/publications.tex:6-19; resume.tex:45 | `bib.biblatex-biber` | `sorting=ydnt`, `style=verbose`, `doi=false`, `isbn=true`, `url=false`, `eprint=false`, `backref=false`, `maxcitenames=3`, `maxbibnames=99`, `hyperref=true`, `block=none`, `backend=biber` |
| two bibliography lists | content/publications.tex:11-19,26-33 | `bib.multi` | `refsection` x2, `\nocite`, `\newrefcontext[sorting=ydnt]`, `\printbibliography[heading=none]` |
| bibliography page-break penalties | lib/templates/publications.tex:23-27 | `sp.penalties` | `\clubpenalty` 10000, `\widowpenalty` 10000, `\interlinepenalty` 5000 via `\AtBeginEnvironment{thebibliography}`; whether the hook fires under biblatex's own list environment is not established |
| bibliography drivers | lib/templates/publications.tex:30-34,36-148 | none (blocker) | see Blockers; 9pt then 8pt grey lines, `\par\vspace{0.3\baselineskip}` per entry |
| photo frame | lib/commands/structure.tex:7-20; lib/configs/packages.tex:37 | `art.tikz` (blocker) | `tcolorbox[skins]` loaded only to supply `fill overzoom image` (`box.tcolorbox`, no box used); circle or rectangle, border `darkgray` or none, 0.3mm, inner sep 1.3cm or 1.8cm |
| closing line | resume.tex:72-73 | `sp.manual-space` | `\vspace*{\fill}`, `\centering{\textbf{References available upon request.}}` (`sp.ragged`, `mark.kernel`) |
| cover letter (unused by sample) | lib/templates/cover-letter.tex:5-51; lib/configs/styles.tex:45-52 | `tbl.tabular` | `tabular*` recipient and date row; `singlespace` for the address (`sp.setspace`); `\lettersection` repeats the `sp.rule` leader; sizes 10 to 14pt (`font.size-commands`) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `russell.cls` loader | russell.cls:15-50 | yes | `class.article` + option pass-through + `\input` of lib files; nothing else |
| package list and configs | lib/configs/packages.tex:5-49; lib/configs/layout.tex:6-23 | yes | `\RequirePackage` of published packages with options (rows above); `ifxetex`, `xifthen`, `xstring`, `etoolbox` are plumbing for the macros below and print nothing; `\fontdir` only stores `\@fontdir`, which nothing reads, so the TTFs in lib/fonts are unused |
| style macros `\...style` | lib/configs/styles.tex:6-52; lib/configs/fonts.tex:4-8 | yes | `\newcommand` aliases of font size, shape and colour switches: `font.size-commands`, `mark.kernel`, `color.xcolor`, `font.helvet` |
| `\makecvheader` | lib/commands/structure.tex:6-171 | yes, judgement call | for a given document it is one concrete minipage; the `\ifthenelse{\isundefined{...}}` chains and the `isstart` bool (structure.tex:40-163) only skip absent fields and place separators between present ones, which an emitter does outside TeX; it also defines `\drawphoto` and `\newlength` inside the macro (structure.tex:7-9,21-22), so it can run once only |
| `\@sectioncolor#1#2#3` | lib/configs/colors.tex:40-42 | yes, borderline | an emitter writes `{\color{russell}Per}sonal Profile`, splitting the first three characters of the title; this is content splitting by the emitter, not a lib way, and it breaks for titles under three tokens in the class |
| `\cvsection`, `\cvsubsection`, `cvparagraph` | lib/commands/structure.tex:184-208 | yes | heading text, `\phantomsection`, `\color{sectiondivider}` plus `sp.rule`, `\vspace`; note `\color{sectiondivider}` is not grouped and leaks until the next colour switch (structure.tex:188) |
| `\cventry`, `\cvsubentry`, `\cvrole`, `cventries`, `cvsubentries` | lib/commands/structure.tex:211-255; lib/templates/experience.tex:12-24 | yes | `tabular*` rows as in the table; `\ifempty` drops the title row when title and location are empty (structure.tex:224-227); `\cvsubentry` and `\cvrole` are unused by the sample |
| `\cvproject` | lib/templates/projects.tex:13-29 | yes | emitter writes the display text itself; `\StrBehind{#3}{//}` strips the URL scheme and `\detokenize` makes it literal; `\faLink~\href{url}{text}`; unused by the sample |
| `cvitems`, `\cvtechskills`, `\cvsoftskills` | lib/commands/structure.tex:258-275 | yes | `list.enumitem` environment and `\item{\textbf{...}}` |
| `cvskills`, `cvhonors`, `cvlanguages`, `cvinterests`, `\cvskilltop` | lib/templates/skills.tex:5-27; lib/templates/achievements.tex:5-20; lib/templates/languages.tex:8-11; lib/templates/interests.tex:8-11 | yes | `tabular*` as in the table; the last two are `\newenvironment{..}{\cvskills}{\endcvskills}` aliases; `\cvskilltop` (minipage) is unused |
| `\newcolumntype{L,C,R}`, `\vhrulefill`, `\ifempty` | lib/commands/utilities.tex:24-32 | yes | `array` column types, `sp.rule` leader, an emptiness test resolved by the emitter |
| personal-info setters | lib/commands/personal-info.tex:21-168 | yes | `\def` stores for header fields; no output of their own |
| `\photo` option parser (`\@for` over `circle,edge,left`) | lib/commands/personal-info.tex:6-19 | no (with the frame) | picks one of 2x2x2 photo variants; its output is the tikz frame in Blockers |
| `\renewcommand*{\quote}` | lib/commands/personal-info.tex:135 | yes | turns the kernel `quote` start macro into a one-argument setter for the header quote line (9pt italic, styles.tex:11), so the kernel `quote` environment is unusable in this class; not needed by the sample |
| biblatex drivers and name format | lib/templates/publications.tex:30-148 | no | see Blockers; `\DeclareNameFormat{author}` tests `\value{listcount}` in two identical branches (publications.tex:140-144) |
| cover-letter macros | lib/templates/cover-letter.tex:5-51 | yes | tabular rows, `singlespace`, leader rule; not used by the sample |

## Content-opaque
none

## Lib changes
- New ways proposed: none (considered: biblatex `\DeclareBibliographyDriver`/`\DeclareFieldFormat`/`\DeclareNameFormat` as a way, rejected: published (W1) but the driver body is code, not option values, so it fails W2; considered: a photo-crop way, rejected: tcolorbox `fill overzoom image` is a tikz node key, a drawing, so it stays under restricted `art.tikz`)
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
