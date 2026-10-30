no

# 0947-altacv: AltaCV (one-page two-column CV)

- Unverified: read from the source, not compiled.
- Source: Source/0947-altacv/ (origin: https://latextemplates.com/downloads/altacv.zip; licence: LPPL-1.3, from the manifest and altacv.cls:5-11)
- Kind: cv
- Lib: v6
- Engine: pdfLaTeX-compatible (altacv.cls:76-90 takes `fontspec` only when `\iftutex`, otherwise `cmap`, `inputenc`, `fontenc` and `glyphtounicode`; main.tex:18-19 loads the `roboto` and `lato` packages)
- Look carried by: mixed (altacv.cls defines the commands, spacing, marks and default colour slots; main.tex:13-34 sets geometry, fonts and palette)
- Class origin: zip-local
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles all (altacv.cls, 491 lines, read in full; the zip holds no .cfg or .sty)

## Verdict
No. The class `altacv.cls` is not a published class here: `ctan.org/pkg/altacv` is a 404 and the zip comes from latextemplates.com, which the rubric does not count as an official release, so its macros are zip-local and have to reduce. Most of them do (see the Bespoke code table), but `\cvskill`, which the sample calls (main.tex:95-109), is a `\foreach` loop with dimension conditionals and clipped half markers, and the class also carries a TikZ round-photo crop, a pgfmath `\wheelchart` and a biblatex name-bolding hook. Those are irreducible or `ART` and the rubric counts everything in the loaded class. If the lib owner treats the author's GitHub release (liantze/AltaCV, named in main.tex:1) as official, the class becomes one way and the verdict changes; this file follows the rubric as written.

## Blockers
- `BESPOKE/class` `\cvskill` rating markers: `\foreach \x in {1,...,5}`, `\ifdimequal`/`\ifdimgreater` pick accent or grey per marker, `\clipbox*` draws half markers (altacv.cls:352-361); used at main.tex:95-109
- `ART/class` round photo: `\tikz\path[fill overzoom image={#2}]circle[radius=0.5\linewidth]` (altacv.cls:252) with the `\photoL`/`\photoR` list accumulators (altacv.cls:241-279) placed by `\makecvheader` (altacv.cls:289, 298); the sample calls no `\photo` command
- `BESPOKE/class` `\wheelchart`: TikZ donut chart with pgfmath running totals, angles, label anchors and leader lines (altacv.cls:364-417); also `art.tikz` drawing; not called by the sample
- `BESPOKE/class` author-name bolding for biblatex: `\foreach` over `\mynames` with `\ifboolexpr` and a global toggle, redefining `\mkbibnamefamily` and three aliases (altacv.cls:443-476); inactive unless biblatex is loaded, the sample has no bibliography

## Class setting
- Class: `class.extarticle` (altacv.cls:39 `\LoadClass{extarticle}`; the zip-local `altacv` class sits on top and is reduced below) options: `10pt`, `a4paper` (main.tex:11, forwarded by `\DeclareOption*` at altacv.cls:31); zip-local booleans `ragged2e` (altacv.cls:33), `withhyper` (altacv.cls:36), `normalphoto` (altacv.cls:30), `academicons` obsolete (altacv.cls:27)
- Class-native vocabulary used (zip-local altacv, not published): `\name` `\tagline` `\personalinfo` with info fields `\email` `\phone` `\location` `\homepage` `\linkedin` `\github` (main.tex:37-47), `\makecvheader` (main.tex:49), `\cvsection` (main.tex:54), `\cvevent` (main.tex:56), `\divider` (main.tex:63), `\cvtag` (main.tex:78), `\cvskill` (main.tex:95); colour slots `name` `tagline` `heading` `headingrule` `subheading` `accent` `emphasis` `body` (main.tex:27-34, defaults altacv.cls:104-111)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | altacv.cls:39; main.tex:11 | `class.extarticle` | 10pt, a4paper |
| paper and size | main.tex:11 | `page.class-options` | a4paper, 10pt |
| page geometry | altacv.cls:55; main.tex:13 | `page.geometry` | margin=2cm, then left=1.25cm, right=1.25cm, top=1.5cm, bottom=1.5cm, columnsep=1.2cm |
| two columns | main.tex:15, 51-52, 85, 111 | `cols.paracol` | `paracol{2}`, `\columnratio{0.6}`, `\switchcolumn` |
| header/footer | altacv.cls:481 | `hf.pagestyle-kernel` | `\pagestyle{empty}` |
| paragraph spacing | altacv.cls:134 | `sp.lengths` | `\parindent`=0pt |
| ragged text | altacv.cls:92-94, 483; main.tex:11 | `sp.ragged` | `ragged2e[newcommands]`, `\raggedright` |
| manual spacing and fixed-width boxes | altacv.cls:299, 308, 320, 325, 334 | `sp.manual-space` | `\medskip` `\smallskip` `\bigskip`, `\makebox[0.5\linewidth][l]` (kernel LR box, same family as `\raisebox`) |
| text faces | main.tex:18-19 | `font.helvet` | `roboto` option rm, `lato` option defaultsans (sans text-face packages) |
| default family | main.tex:20 | `font.family-default` | `\familydefault` = `\sfdefault` |
| encodings | altacv.cls:82-83 | `font.fontenc-t1` | inputenc utf8, fontenc T1 (pdfTeX branch) |
| fontspec branch | altacv.cls:76-77 | `font.fontspec` | `\iftutex` only; not taken under pdfLaTeX |
| size switches | altacv.cls:281-285 | `font.size-commands` | `\Huge` `\large` `\footnotesize` `\LARGE`, `\small` |
| bold and italic switches | altacv.cls:281-285, 302, 322 | `mark.kernel` | `\bfseries`, `\itshape`, `\textbf`, `\normalfont` |
| icons | altacv.cls:56, 64, 114-118, 214-238 | `font.icons` | `fontawesome5[fixed]` (`\faAt` `\faPhone` `\faGlobe` `\faLinkedin` `\faGithub` `\faMapMarker` `\faCalendar[regular]` `\faCircle`), `simpleicons` when its files exist |
| colour | altacv.cls:45, 104-111; main.tex:22-34 | `color.xcolor` | `\definecolor` HTML values, `\colorlet` slots, `\color{body}` at begin document (altacv.cls:482) |
| PDF/A | altacv.cls:48 | `meta.pdfx` | `a-1b`; needs a `main.xmpdata` the zip does not ship |
| PDF text mapping | altacv.cls:81, 84-89 | `meta.glyphtounicode` | `cmap`, `\input{glyphtounicode}`, `\pdfglyphtounicode` f_f f_f_i f_f_l f_i, `\pdfgentounicode=1` |
| PDF replacement text | altacv.cls:49, 167, 326, 331, 340 | `meta.accsupp` | `\BeginAccSupp{method=escape or pdfstringdef or plain, ActualText=...}` |
| links | altacv.cls:51-53, 97-102, 175 | `meta.hyperref` | `\hypersetup{hidelinks}`, `\pdfstringdefDisableCommands`, `\href` when `withhyper` |
| URL style | altacv.cls:99, 101 | `meta.url` | `\urlstyle{same}` |
| CV header block (name, tagline, info line) | altacv.cls:287-300; main.tex:37-49 | `box.minipage` | `minipage` of `\linewidth`, `\raggedright`; name via `mark.case` `\MakeUppercase`, `\Huge\bfseries` in `color.xcolor` colour `name`, tagline `\large\bfseries` colour `tagline`, info `\footnotesize\bfseries` |
| info field line | altacv.cls:164-185, 214-238; main.tex:40-47 | `font.icons` | per field: accent-coloured icon (`color.xcolor`) under `meta.accsupp`, then text, `\href{prefix text}` (`meta.hyperref`), `\hspace{2em}` (`sp.manual-space`) |
| section headings | altacv.cls:304-309; main.tex:54, 71, 76, 87, 93, 103 | `head.titlesec` | reduction: `\titleformat` with `\LARGE\bfseries` in colour `heading`, `\MakeUppercase` (`mark.case`), 2pt rule in colour `headingrule` (`sp.rule`); optional sidebar argument is `note.marginpar` + `struct.input` |
| subsection headings | altacv.cls:311-314 | `head.titlesec` | `\large\bfseries` in colour `subheading`; not used by the sample |
| CV event entry | altacv.cls:318-335; main.tex:56, 65, 73, 89, 91 | `font.size-commands` | reduction: `\large` title in colour `emphasis`, `\textbf` accent employer, two `\makebox[0.5\linewidth]` cells with `font.icons` date and location markers under `meta.accsupp`; empty fields omitted |
| bullet lists | altacv.cls:126-127; main.tex:57-61, 66-69 | `list.enumitem` | `\setlist{leftmargin=*,labelsep=0.5em,nosep,itemsep=0.25\baselineskip,after=\vspace{0.25\baselineskip}}`, `\setlist[itemize]{label=\cvItemMarker}`, option `inline`; body env is `list.kernel` `itemize` |
| divider | altacv.cls:135; main.tex:63, 96 | `sp.rule` | `\hdashrule{\linewidth}{0.6pt}{0.5ex}` (dashrule) in `body!30`, then `\medskip` |
| skill tag | altacv.cls:346-348; main.tex:78-83 | `box.tcolorbox` | reduction to inline `\tcbox[on line, interior hidden]` with colframe `body!30`, rounded `arc`, left/right 1ex, top/bottom set to match `text height=1.5ex,text depth=.25ex`; parameters to be tuned, not shown equal; `skins` is loaded (altacv.cls:124) |
| skill rating | altacv.cls:352-361; main.tex:95-109 | none | UNMAPPED to a lib way: blocker `BESPOKE/class` above |
| achievement entry | altacv.cls:338-344 | `tbl.tabularx` | `tabularx` columns `p{2em}`, `X`; `\multirow{2}{*}` (`tbl.multirow`); not used by the sample |
| reference entry | altacv.cls:419-427 | `list.enumitem` | `description[font=\color{accent},style=multiline,leftmargin=1.35em,align=left]`; not used by the sample |
| quote | altacv.cls:302 | `quote.kernel` | `\renewenvironment{quote}`: accent colour, `\itshape\large`; not used by the sample |
| full-width block | altacv.cls:132, 137-139 | `page.adjustwidth` | `adjustwidth{}{-\marginparwidth-\marginparsep}`; not used by the sample |
| column box | altacv.cls:429 | `box.minipage` | `minipage[t]{width}` + `\raggedright`; not used by the sample |
| sidebar notes | altacv.cls:436-441 | `note.marginpar` | `\marginpar{\vspace*{len}\input{file}}` (`struct.input`), `\afterpage` for the next page (`pg.afterpage`); not used by the sample |
| normal photo | altacv.cls:249-250 | `fig.graphicx` | `\includegraphics[width=\linewidth]`, option `normalphoto`; not used by the sample |
| round photo and wheel chart | altacv.cls:252, 364-417 | `art.tikz` | restricted way; blockers `ART/class` and `BESPOKE/class` above |
| bibliography name highlight | altacv.cls:443-476 | `bib.biblatex-biber` | hook only, loaded nowhere in the class or sample; irreducible logic, blocker above |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| zip-local class `altacv` (options, `\LoadClass{extarticle}`, `\RequirePackage` list) | altacv.cls:21-132 | yes | `class.extarticle` plus the package ways in the map; packages with no printed effect of their own (`etoolbox`, `xparse`, `pgffor`, `iftex`, `tcolorbox[skins]`, `tikz` library `arrows`) drop out once the macros using them are expanded |
| engine branch `\iftutex` and format-version shims | altacv.cls:59-60, 66-90, 97-102, 478-491 | yes | the emitter picks the pdfLaTeX branch (`font.fontenc-t1`, `meta.glyphtounicode`) or the `font.fontspec` branch; the hooks hold `\hypersetup{hidelinks}`, `\urlstyle{same}`, `\pagestyle{empty}`, `\color{body}`, `\raggedright`, all in the map |
| colour slots and marker aliases | altacv.cls:104-120, 281-285 | yes | `\colorlet` lines (`color.xcolor`), `\newcommand` aliases of `font.icons`, `font.size-commands`, strings `\locationname` `\datename` |
| `\setlist`, `\divider`, `fullwidth`, `quote`, `cvcolumn` | altacv.cls:126-139, 302, 429 | yes | map rows `list.enumitem`, `sp.rule`, `page.adjustwidth`, `quote.kernel`, `box.minipage` |
| `\utffriendlydetokenize` (`\scantokens` with catcode changes) | altacv.cls:143-156 | yes | its only effect is that `_ & $ # ~` in field text print literally; the emitter escapes those characters in content |
| `\printinfo` (expl3 `\NewDocumentCommand`, `withhyper` toggle) | altacv.cls:42-43, 163-185 | yes | per field one fixed expansion: `meta.accsupp` icon, `color.xcolor`, `meta.hyperref` `\href`, `sp.manual-space`; the toggle is a class option the emitter fixes |
| `\NewInfoField` factory and the ten field commands | altacv.cls:188-238 | yes | unrolled to fixed commands (icon, link prefix: `mailto:` `tel:` `https://` `https://twitter.com/` `https://x.com/` `https://linkedin.com/in/` `https://github.com/` `https://orcid.org/`); the `\xtwitter` and `\orcid` fallbacks are static branch choices |
| `\name` `\tagline` `\personalinfo` | altacv.cls:211-213 | yes | store strings; the emitter writes the strings into the header block |
| `\makecvheader` without photos | altacv.cls:287-300 | yes | `box.minipage` + `mark.case` + `font.size-commands` + `color.xcolor` + `sp.manual-space` |
| `\cvsection`, `\cvsubsection` | altacv.cls:304-314 | yes | `head.titlesec` as in the map; `\ifstrequal` only tests an empty sidebar argument |
| `\cvevent` | altacv.cls:318-335 | yes | `\ifstrequal` tests only omit empty fields; the rest is size, colour, `\makebox` and accsupp wrappers |
| `\cvachievement`, `\cvref` | altacv.cls:338-344, 419-427 | yes | `tbl.tabularx` + `tbl.multirow`; `list.enumitem` description. Note: `\cvref` uses `\emailsymbol` and `\mailaddresssymbol` (altacv.cls:423-424), but `\NewInfoField` defines `\csname email symbol\endcsname` with a space (altacv.cls:194), so both look undefined; not checked by compiling |
| `\cvtag` (TikZ node with `draw`, `rounded corners`) | altacv.cls:346-348 | yes, with a caveat | `box.tcolorbox` `\tcbox` as in the map; a framed inline tag is a declarative box, not template artwork; exact dimensions are not shown equal |
| `\cvskill` | altacv.cls:352-361 | no | loop and conditionals decide each marker's colour from the rating, half markers use `\clipbox*`; no lib way takes a rating, and unrolling it in the emitter would copy the macro's logic |
| photo machinery `\@makeaphoto` `\photoL` `\photoR` | altacv.cls:241-279 | no | circle crop by TikZ `fill overzoom image`, widths and photo lists accumulated with `\appto` and `\forcsvlist`; `normalphoto` branch alone is `fig.graphicx` |
| `\wheelchart` | altacv.cls:364-417 | no | pgfmath totals, cumulative angles, anchors and leader lines computed in a `\foreach` loop; raw TikZ |
| `\mynames` and `\altacv@makeboldnames` | altacv.cls:443-476 | no | `\foreach` over a name list, `\ifboolexpr`, global toggle, redefinition of biblatex name-part formats |
| main.tex preamble and body | main.tex:11-111 | yes | no `\newcommand`, `\def` or environment is defined in the sample; geometry, fonts, colours and paracol are map rows |

## Content-opaque
none (the sample has no figure or table float; the skill, tag and info text is content)

## Lib changes
- New ways proposed: none. Considered and not used: `cv.entries`, whose lib line names altacv; its W1 fails for a class that is not on CTAN (ctan.org/pkg/altacv: 404, the one CTAN page read) and comes from latextemplates.com, so the entry commands were reduced instead. If the owner counts the author's GitHub release as published, `\name` ... `\cvevent` `\cvtag` `\divider` map to `cv.entries` and only the `\cvskill`, round photo, `\wheelchart` and name-bolding items stay open.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- main.tex:1-10 is a packaging comment about engine choice, an image and a "packaging brief"; it is not addressed to an AI and was not acted on. It shows main.tex was edited after the latextemplates download.
- The manifest hints (`xelualatex`, `biblatex`) do not match the sample: it loads no biblatex, and the class has a pdfLaTeX branch.
- `main.xmpdata` is not in the zip; `pdfx[a-1b]` (altacv.cls:48) reads `\jobname.xmpdata`, so the emitter must ship one. Whether pdfx stops or fills defaults without it was not established.
