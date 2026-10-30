no

# 0288-awesome-resume-cv: Awesome Resume/CV

- Unverified: read from the source, not compiled.
- Source: Source/0288-awesome-resume-cv/ (origin: https://latextemplates.com/downloads/awesome-resume-cv.zip; licence: LPPL-1.3c)
- Kind: cv
- Lib: v3
- Engine: needs XeLaTeX (`fontspec`, `unicode-math`, `fontawesome6`: awesome-cv.cls:73,77,79; main.tex:1 names xelatex; `Renderer=HarfBuzz` at awesome-cv.cls:82 is a LuaTeX-side renderer name, not checked here against XeTeX)
- Look carried by: zip-local (awesome-cv.cls defines every style macro and structure command; main.tex only fills data slots and overrides `\geometry`)
- Class origin: zip-local
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles all (awesome-cv.cls lines 1-882)

## Verdict
no. The look sits in an 882-line zip-local class: `awesome-cv` is not on CTAN (ctan.org/pkg/awesome-cv is a 404), the zip comes from latextemplates.com and the class is an edited vendored copy (fonts swapped, awesome-cv.cls:84-107), so W1 fails for its macros. Most of it reduces to lib ways (colours, fonts, geometry, `tabular*` entries, itemize, skills table), but three things do not: the `\makecvheader` conditional chain with its `isstart` state (cls:508-696), the typeset-time `\StrSplit` colouring of every section title (cls:206-212, 709-714), and the TikZ photo frame (cls:509-522). The lib line `cv.entries` names the "awesome-cv family"; I did not use it because the class here is not a published one (W1). If a reviewer rules the class published, the same facts give `yes` with Look carried by class.

## Blockers
- `BESPOKE/class` `\makecvheader`: about 25 optional-field `\ifthenelse{\isundefined{...}}` branches threaded by an `isstart` boolean to place `\quad\textbar\quad` between the fields that exist; links built from strings, the tel URI cleaned with `\StrDel`; `\newcommand`, `\newlength` and `\newbool` are executed inside the macro on each call (awesome-cv.cls:304-307, 473, 508-531, 541-688)
- `BESPOKE/class` section heading: `\sectionstyle` splits the title after 3 characters with xstring `\StrSplit` at typeset time and colours the two halves differently, switched by the `acvSectionColorHighlight` boolean; `\cvsection` is a hand-built heading (no `\section`, no counter, no toc entry) (awesome-cv.cls:181-182, 206-212, 709-714)
- `ART/class` photo frame: a `tikzpicture` node (`circle` or `rectangle`, border, `fill overzoom image`) is the template's portrait slot; not exercised by main.tex (awesome-cv.cls:263-276, 509-522, 533, 694)

## Class setting
- Class: zip-local `awesome-cv`, no `class.awesome-cv` claimed; its base is `class.article` (awesome-cv.cls:43); options `11pt, a4paper` passed on to article by `\DeclareOption*` (awesome-cv.cls:39-41; main.tex:12); `draft`/`final` set `\overfullrule` 5pt/0pt (awesome-cv.cls:36-37)
- Class-native vocabulary used: `\name{}{}` `\position{}` `\address{}` `\mobile{}` `\email{}` `\homepage{}` `\linkedin{}` `\github{}` (main.tex:16-24), `\makecvheader` (main.tex:28), `\cvsection{}` (main.tex:30,58,69), `cventries` + `\cventry{position}{title}{location}{date}{description}` (main.tex:32-67), `cvitems` (main.tex:39-43), `cvskills` + `\cvskill{type}{set}` (main.tex:71-74). Defined but not used: `\photo`, `\whatsapp`, `\dateofbirth`, `\gitlab`, `\bitbucket`, `\stackoverflow`, `\orcid`, `\twitter`, `\x`, `\mastodon`, `\skype`, `\reddit`, `\researchgate`, `\xing`, `\medium`, `\kaggle`, `\hackerrank`, `\telegram`, `\googlescholar`, `\extrainfo`, `\quote`, `\makecvfooter`, `\cvsubsection`, `cvparagraph`, `cvsubentries`/`\cvsubentry`, `cvhonors`/`\cvhonor`, cover-letter set (`\recipient`, `\lettertitle`, `\letterdate`, `\letteropening`, `\letterclosing`, `\letterenclosure`, `cvletter`, `\lettersection`, `\makelettertitle`, `\makeletterclosing`) (awesome-cv.cls:283-460, 700-882)

## Component map
cls = awesome-cv.cls. A row whose Way is "none" is realised only by bespoke code (see Blockers).

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | cls:43; main.tex:12 | `class.article` | base class of the zip-local class; options `11pt`, `a4paper` |
| paper and size | main.tex:12; cls:39-41 | `page.class-options` | `11pt`, `a4paper` (other options forwarded to article) |
| page geometry | main.tex:14; cls:57,135 | `page.geometry` | main: left=1.4cm, top=.8cm, right=1.4cm, bottom=1.8cm, footskip=.5cm; class default: left=2.0cm, top=1.5cm, right=2.0cm, bottom=2.0cm, footskip=.5cm |
| header and footer | cls:59,139-145 | `hf.fancyhdr` | `\fancyhfoffset{0em}`, `\headrulewidth` 0pt, `\fancyhf{}`, `\pagestyle{fancy}`; no header or footer text in the sample |
| footer macro (not called) | cls:700-705 | `hf.fancyhdr` | `\fancyfoot[L,C,R]` with `\footerstyle` (8pt, `\scshape`, `lighttext`) |
| colour palette | cls:61,152-178 | `color.xcolor` | `\definecolor{..}{HTML}{..}`: text=darkgray 333333, graytext=gray 5D5D5D, lighttext=lightgray 999999, darktext 414141, sectiondivider=gray, awesome=awesome-red DC3522 (plus 7 other awesome-* colours) |
| text fonts | cls:73,75,81-83,90-107 | `font.fontspec` | `[quiet]`; `\defaultfontfeatures{Ligatures=TeX}` then `{Renderer=HarfBuzz}`; `\setmainfont`, `\setsansfont`, `\newfontfamily\roboto` all Nimbus Sans with `UprightFont=*`, `ItalicFont=* Italic`, `BoldFont=* Bold`, `BoldItalicFont=* Bold Italic` (a system font, not in the zip) |
| math font | cls:77 | `font.unicode-math` | load only; the sample has no maths |
| icon glyphs | cls:79,547,560,572,578,602 | `font.icons` | `fontawesome6`: `\faMobile`, `\faEnvelope`, `\faHouseChimney`, `\faSquareGithub`, `\faLinkedin` printed before each header link (fields set at main.tex:20-24) |
| PDF text replacement | cls:80,473,497-501 | `meta.accsupp` | `accsupp`: `\BeginAccSupp{ActualText={<text>}}` ... `\EndAccSupp{}` around each icon+text link; `ActualText={}` hides the separator bars |
| font switches | cls:187-191 | `font.nfss` | `\headerfontlight` = `\roboto\fontseries{l}\selectfont`; `\bodyfontlight` = `\sffamily\fontseries{l}\selectfont` |
| font sizes | cls:198-255 | `font.size-commands` | `\fontsize{<pt>}{1em}\selectfont`: name 32pt, position 7.6pt, address 8pt, social 6.8pt, section 16pt, entry title 10pt, position/date 8pt, location/description 9pt, skill type 10pt, skill set 9pt |
| emphasis and shape | cls:187-255 | `mark.kernel` | `\sffamily`, `\bfseries`, `\scshape`, `\itshape`, `\slshape`, `\upshape`, `\mdseries` per element style |
| paragraph spacing | cls:111 | `sp.parskip-pkg` | load only; `\parskip` set to 0pt inside `cvitems` (cls:823) |
| line spacing | cls:71,861 | `sp.setspace` | `singlespace` env in the cover-letter title only (not used by the sample) |
| manual spacing | cls:468-479,710,719-720,745,820,828 | `sp.manual-space` | `\vspace`: section top 3mm (`\acvSectionTopSkip`), content top 2.5mm, -2.0mm before each entry, -4.0mm/+1.0mm around `cvitems`; `\\[len]` header gaps .4mm, .4mm, -.5mm, 6mm, 5mm |
| lengths | cls:746-747,768-769,788-789,805-806,823 | `sp.lengths` | `\tabcolsep` 0pt (1ex in skills), `\extrarowheight` 0pt, `\parskip` 0pt |
| alignment | cls:55,487-489,536,807,821 | `sp.ragged` | `ragged2e`; `\raggedright`/`\centering`/`\raggedleft` by `\makecvheader[C\|L\|R]` (default C); `justify` env inside `cvitems` |
| section divider rule | cls:492,713 | `sp.rule` | `\vhrulefill{0.9pt}` = `\leavevmode\leaders\hrule\@height#1\hfill\kern\z@`, coloured `sectiondivider` |
| links and metadata | cls:113-119,547 | `meta.hyperref` | `hidelinks`, `unicode`, `pdfpagelabels=false`; `\hypersetup` with empty `pdftitle`, `pdfauthor`, `pdfsubject`, `pdfkeywords`; `\href` on each contact field; `\phantomsection` after each section title (cls:712) |
| bookmarks | cls:121 | `meta.bookmark` | load only (comment: avoids the `.out` changed warning) |
| CV header block | cls:508-696; main.tex:16-28 | none (BESPOKE/class) | unrolled form would be 3 `minipage[c]` of 0.24/0.76/0.24 `\textwidth` (0.76 text width only when `\photo` is set, else full width) holding name (first name 32pt light `graytext`, last name 32pt bold `text`), position, address, social line, quote; the field-by-field conditionals are the blocker |
| header columns | cls:532,535,693 | `box.minipage` | `[c]` minipages `\headerphotowidth`, `\headertextwidth`, `\headerphotowidth` |
| photo frame | cls:263-276,509-522 | `art.tikz` | `tikzpicture` node `circle\|rectangle`, `draw=darkgray\|none`, `line width=0.3mm`, `inner sep` 1.3cm/1.8cm, `fill overzoom image` (ART/class) |
| photo support | cls:109 | `box.tcolorbox` | `\RequirePackage[skins]{tcolorbox}`, loaded for the photo; no tcolorbox environment in the sample |
| section heading | cls:206-212,709-714; main.tex:30,58,69 | none (BESPOKE/class) | `\vspace{3mm}`, title 16pt bold `\sffamily`, first 3 characters `awesome`, rest `text`, `\phantomsection`, rule 0.9pt; unnumbered, no counter, not in a toc |
| entries container | cls:736-741 | `box.minipage` is not needed; `list.kernel` is not used | `\vspace{2.5mm}` + kernel `center` environment (`sp.ragged`, `sp.manual-space` above) |
| entry rows | cls:486-489,744-757; main.tex:33-67 | `tbl.tabular` | `tabular*{\textwidth}{@{\extracolsep{\fill}} L{\textwidth - 4.5cm} R{4.5cm}}` with `\newcolumntype` L/C/R = `>{\raggedright\let\newline\\\arraybackslash\hspace{0pt}}m{#1}` (array); rows `title & location`, `position & date`, then `\multicolumn{2}{L{\textwidth}}` description; branches on empty fields (`\ifempty`, `\ifstrempty`) |
| bullet lists | cls:53,819-829; main.tex:39-43 | `list.enumitem` | `itemize[leftmargin=2ex, nosep, noitemsep]`, `\labelitemi` = `\bullet`, wrapped in `justify` (`sp.ragged`) |
| bullet list kind | cls:822-824 | `list.kernel` | `itemize` |
| skills table | cls:51,486,802-816; main.tex:71-74 | `tbl.tabularx` | `tabularx{\textwidth}{r>{\raggedright\let\newline\\\arraybackslash\hspace{0pt}}X}`, `\tabcolsep` 1ex, `\tabularxcolumn` redefined to `p` |
| subentries and honours (not used) | cls:760-799 | `tbl.tabular` | `tabular*` with `L/R` columns; `cvhonors` three columns `C{1.5cm} L{\textwidth - 4.0cm} R{2.5cm}` |
| cover letter (not used) | cls:429-460,836-882 | `tbl.tabular` | `\makelettertitle` is a `tabular*` plus `singlespace` (`sp.setspace`); `\lettersection` is `\addvspace{2.5ex}` + coloured title + `\vhrulefill` (`sp.manual-space`, `sp.rule`); data slots `\recipient`, `\lettertitle`, `\letterdate` |
| theorems, figures, captions, maths, bibliography, index, cross-references, notes | not defined, not used (main.tex:26-76) | none needed | the sample has none of these |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| style macros `\headerfirstnamestyle` ... `\letterenclosurestyle` | cls:187-255 | yes | aliases over `font.size-commands`, `font.nfss`, `mark.kernel`, `color.xcolor`; one `\newcommand` per element, parameters listed in the map |
| helper skips `\acvHeader*Skip`, `\acvSection*Skip` | cls:468-479 | yes | lengths for `sp.manual-space` |
| `\newcolumntype` L/C/R | cls:487-489 | yes | `tbl.tabular` (array) column types |
| `\vhrulefill` | cls:492 | yes | `sp.rule` (`\leaders\hrule` with a fixed height, no box) |
| `\ifempty` | cls:495 | yes, at emit time | the emitter omits the empty row; a typeset-time test is not needed |
| `cventries`, `\cventry`, `cvsubentries`, `\cvsubentry`, `cvhonors`, `\cvhonor`, `cvskills`, `\cvskill`, `cvitems` | cls:736-829 | yes | `center` + `tabular*`/`tabularx` and `itemize` with the parameters in the map |
| `\makecvfooter` | cls:700-705 | yes | `hf.fancyhdr` fields |
| `cvletter`, `\lettersection`, `\makelettertitle`, `\makeletterclosing` | cls:836-882 | yes (not exercised) | `tbl.tabular`, `sp.setspace`, `sp.rule`, `sp.manual-space`; the `\\\\` blank-line hacks become `sp.manual-space` |
| `\renewcommand*{\quote}[1]` | cls:427 | yes | turns the kernel `\quote` into a header data slot (printed by `\headerquotestyle`, cls:203,689-691); the kernel `quote` environment is unavailable in this class, so nothing to emit |
| `\fontdir` | cls:128 | yes | dead configuration (left for backward compatibility per its comment), emits nothing |
| `\makecvheader` | cls:508-696 | no | about 25 field branches plus the `isstart` separator state machine (cls:542-688), string cleaning with `\StrDel` (cls:304-307, 317-321), `\newcommand`/`\newlength`/`\newbool` run inside the macro (cls:509,511,523-524,542); a static unrolling by an emitter would be a re-implementation of this logic, not a composition of lib ways |
| `\sectionstyle` / `\lettersectionstyle` | cls:206-212, 242-248 | no | typeset-time `\StrSplit{title}{3}` plus a boolean-switched two-colour title (xstring, xifthen); no lib way computes a split of the heading text |
| `\cvsection` | cls:709-714 | no | heading built from `\vspace`, the section style above and a rule; not a sectioning command, so no `head.*` way fits and the colour split is the blocker above |
| `\photo` / `\drawphoto` | cls:263-276, 509-522 | no (ART) | TikZ node with `fill overzoom image`; no declarative lib way draws a cropped portrait frame |
| programming packages `xifthen`, `xstring`, `etoolbox`, `ifxetex` | cls:63-69 | n/a | no lib way; they serve only the bespoke logic above |
| zip-local class `awesome-cv` as a whole | cls:1-882 | no | not published (W1); the irreducible parts are the three blockers, the rest composes from the map |

## Content-opaque
none (the sample has no figure or table float; the photo frame is template artwork, listed as `ART/class`)

## Lib changes
- New ways proposed: `meta.accsupp`: `accsupp` (CTAN, "Better accessibility support for PDF files", LPPL 1.3c; read at ctan.org/pkg/accsupp), pdf. W1: on CTAN. W2: keys `ActualText`, `Alt`, `E`, `Lang` take strings. W3: serves any text span in any document. W4: `\usepackage{accsupp}` plus the wrapper pair `\BeginAccSupp{ActualText={..}}...\EndAccSupp{}` around content. Not `meta.glyphtounicode` (a per-glyph ToUnicode map) and not `meta.hyperxmp` (XMP metadata): this replaces the extracted text of a chosen span.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
- Note for the consolidator: `cv.entries` was not used because the class is zip-local; the ruling on whether the awesome-cv family counts as published is left to the reviewers (see Verdict).
