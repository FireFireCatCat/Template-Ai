no

# 0769-opencurve-resume: OpenCurVe Resume

- Unverified: read from the source, not compiled.
- Source: Source/0769-opencurve-resume/ (origin: https://latextemplates.com/downloads/opencurve-resume.zip; licence: MIT)
- Kind: cv
- Lib: v6 (the snapshot you read)
- Engine: needs XeLaTeX (XeLaTeX or LuaLaTeX; `fontspec` and `ctex` with font files by name, and open-curve.sty:5-10 stops with an error under pdfLaTeX)
- Look carried by: mixed (zip-local `open-curve.sty` sets fonts, colours, spacing and the section and entry macros; the published class `curve` supplies the header mechanism; `sections/experience.tex` defines the employer banner)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles all (open-curve.sty in full; no zip-local `.cls`). The class `curve` is not in the zip; its source was not read.

## Verdict
The look is a published class (`curve`, only its header commands are used) plus a zip-local style that reduces, macro by macro, to published ways (`geometry`, `fontspec`, `ctex`, `xcolor`, `fontawesome5`, `hyperref`, kernel spacing and rules, `tabular*`). One component does not reduce: the employer banner `\companybanner` draws a rounded-corner-clipped accent stripe and positions a brand icon with a TikZ `overlay` inside a `tcolorbox` (experience.tex:17-26). That is template-defining artwork written as free TikZ, and I cannot show it equals a declarative `tcolorbox` key set without compiling, so the answer is `no`.

## Blockers
- `ART/body` `\companybanner` is a `tcolorbox` whose `overlay` is a TikZ `scope` with `\clip[rounded corners=1.5mm]` and `\fill` of a 3pt left stripe, plus a `\node` at `frame.west`+17.25pt carrying the brand icon (experience.tex:15-26; used experience.tex:47, 58). The README names this the feature of the template: "background tint + accent stripe + icon glyph" (README.md:3-6). A candidate reduction is `box.tcolorbox` with `borderline west` for the stripe and an inline icon box, but the clipping to the rounded corners and the exact icon position are not shown to match, so it is not claimed.

## Class setting
- Class: `class.curve` options: `a4paper`, `skipsamekey`, `10pt`, `english` (main.tex:4)
- Class-native vocabulary used: `\leftheader{}` (main.tex:11), `\rightheader{}` (main.tex:27), `\makeheaders[c]` (main.tex:41), the length `\headerspace` set to 0pt (open-curve.sty:75), `\headerscale{0.74}` (open-curve.sty:76). The class's own rubric and entry commands are not used: the sample replaces them with `\cvsection`, `\cvheading`, `\cvitem` (zip-local). ctan.org/pkg/curve read: CurVe 1.16, Didier Verna, LPPL 1.1, in TeX Live; the page names none of the commands above, so they come from the sample and the class source was not read.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:4 | `class.curve` | a4paper, skipsamekey, 10pt, english |
| paper and size by options | main.tex:4 | `page.class-options` | a4paper, 10pt |
| page geometry | open-curve.sty:16 | `page.geometry` | a4paper, left=1.2cm, right=1.2cm, top=1cm, bottom=1cm |
| header block (left and right halves, placed by the class) | main.tex:11-23, 27-37, 41; open-curve.sty:75-76 | `front.class-native` | `\leftheader`, `\rightheader`, `\makeheaders[c]`, `\headerspace`=0pt, `\headerscale`=0.74 |
| name line | main.tex:12 | `font.size-commands`, `mark.kernel`, `sp.manual-space` | `\LARGE`, `\sffamily\bfseries`, `\par\smallskip`, `\normalsize` (main.tex:13) |
| contact items with icons and links | main.tex:14, 16, 20; open-curve.sty:79-80 | `font.icons`, `meta.hyperref`, `sp.manual-space`, `color.xcolor` | `\faPhone`, `\faEnvelope[regular]`, `\faGithub`; `\href` with tel:, mailto:, https; `\makebox[1.35em][c]{\color{black}#1}\,#2` |
| item divider | main.tex:15, 17; open-curve.sty:81-82 | `sp.manual-space`, `color.xcolor`, `font.fontenc-t1` | `\hspace{0.8em}`, `\textcolor{gray}`, kernel `\textbar` |
| line break inside header | main.tex:19, 21; open-curve.sty:83 | `sp.manual-space` | `\par\vspace{0.2\baselineskip}` |
| role line | main.tex:22 | `mark.kernel` | `\sffamily\bfseries` |
| photo placeholder box (image slot, content is a comment) | main.tex:26-37 | `box.fancybox`, `box.minipage`, `sp.ragged`, `font.icons`, `font.size-commands`, `color.xcolor`, `sp.manual-space` | `\fcolorbox{OpenCurveAccent}{white}`, `\parbox[c][2.5cm][c]{2.5cm}`, `\centering`, `\faUser`, `\Large`, `\small`, `\color{OpenCurveMuted}`, `\vspace{0.25em}` |
| icon packages | open-curve.sty:19; main.tex:6 | `font.icons` | `fontawesome5` option `fixed`; `simpleicons` (ctan.org/pkg/simpleicons read: Inesh Bose, CC0 1.0, load-only here, `\simpleicon{name}` at experience.tex:48, 59) |
| main text face | open-curve.sty:15, 44-48 | `font.fontspec` | `\setmainfont{texgyretermes-regular.otf}` with BoldFont, ItalicFont, BoldItalicFont files |
| sans face | open-curve.sty:49-53 | `font.fontspec` | `\setsansfont{texgyretermes-regular.otf}` (same Termes files as the main face) with Bold, Italic, BoldItalic files |
| mono face | open-curve.sty:57-61 | `font.fontspec` | `\setmonofont{texgyrecursor-regular.otf}` with the four Cursor files |
| CJK support and faces | open-curve.sty:14, 54-56 | `lang.cjk` | `ctex` with fontset=none, scheme=plain; `\setCJKmainfont`, `\setCJKsansfont`, `\setCJKmonofont` = `FandolHei-Regular.otf`, BoldFont=`FandolHei-Bold.otf` |
| line spacing | open-curve.sty:64 | `sp.linespread`, `font.size-commands` | `\linespread{1.3}\selectfont` |
| paragraph shape | open-curve.sty:71, 73-74 | `sp.ragged`, `sp.lengths` | `\raggedright`, `\parindent`=0pt, `\parskip`=0pt |
| colours | open-curve.sty:17, 66-69; experience.tex:5-8 | `color.xcolor` | options dvipsnames, svgnames; Primary 2F6F9F, Accent 4F94C4, Heading 173A86, Muted 4B5563; NovaBlue 3C8CFF, NovaTint EEF5FF, HelixRed CF0A2C, HelixTint FFF1F3 |
| links and URLs | open-curve.sty:20, 72 | `meta.hyperref`, `meta.url` | `colorlinks=true`, `allcolors=black`, `breaklinks=true`; `\urlstyle{same}` |
| graphics loaded (no image is included; main.tex:26 is a comment) | open-curve.sty:18 | `fig.graphicx` | load only |
| section heading `\cvsection[sp]{title}` (used as the section commands) | open-curve.sty:86-102; education.tex:1; experience.tex:1; projects.tex:1; skills.tex:1 | `sp.manual-space`, `sp.rule`, `font.size-commands`, `mark.kernel`, `color.xcolor` | `\vspace{#1\baselineskip}` (default 1; samples 0.8 and 0.45), title `\fontsize{15}{16.8}\sffamily\bfseries` in Primary, `\vskip3.5pt`, `\hrule height 1.5pt` full `\linewidth` in Accent, `\vspace{2pt}` |
| entry heading `\cvheading[sp]{left}{right}` | open-curve.sty:104-114; projects.tex:3, 9 | `sp.manual-space`, `font.size-commands`, `mark.kernel`, `color.xcolor` | `\nointerlineskip`, `\vspace{0.4em}` default, left `\fontsize{10.5}{12.6}\sffamily\bfseries` Heading colour, `\hfil`, right in Muted |
| bullet item `\cvitem[colour]{text}` | open-curve.sty:116-121; projects.tex:5-7, 10-11; skills.tex:3-5 | `sp.lengths`, `font.fontenc-t1`, `color.xcolor` | `\settowidth{\hangindent}{\textbullet\ }`, `\hangafter=1`, `\textcolor{#1}{\textbullet}`, default black |
| tagline `\cvtagline` | open-curve.sty:123-126; experience.tex:51, 62; projects.tex:4 | `font.size-commands`, `mark.kernel`, `color.xcolor`, `sp.manual-space` | `\normalsize\bfseries` in Heading colour, `\vspace{0.1em}` |
| education rows | education.tex:3-10 | `tbl.tabular`, `mark.kernel` | `tabular*{\linewidth}` with `@{\extracolsep{\fill}} l l l r @{}`, `\arraystretch`=1.2 in a group, `\textbf` |
| employer banner box (stripe and icon excluded, see ART) | experience.tex:12-39 | `box.tcolorbox` | `enhanced`, `colback=#2`, `frame hidden`, `boxrule=0pt`, `arc=1.5mm`, `outer arc=1.5mm`, `boxsep=0pt`, left=6pt, right=6pt, top=0pt, bottom=0pt, `height=22pt`, `valign=center`, `width=\linewidth`, before skip=0pt, after skip=0pt; `\tcbuselibrary{skins}` (main.tex:7-8) |
| banner overlay: accent stripe and brand icon | experience.tex:17-26 | `art.tikz` | ART blocker: `scope`, `\clip[rounded corners=1.5mm]`, `\fill` 3pt stripe, `\node` at `frame.west`+17.25pt |
| banner text line | experience.tex:31-37 | `sp.manual-space`, `font.size-commands`, `mark.kernel`, `color.xcolor` | `\makebox[\linewidth]{\hspace{2.8em}{\fontsize{10.5}{12.6}\sffamily\bfseries #5}\hfill{... \color{OpenCurveMuted}\mbox{#6}}}` |
| sub-bullet `\companyitem` | experience.tex:42-45; used 54-55, 65-66 | `sp.lengths`, `sp.manual-space`, `color.xcolor`, `font.fontenc-t1` | `\hangindent=1.6em`, `\hangafter=1`, `\hspace{0.65em}`, `\textcolor{#1}{\textbullet}` |
| bold run-in labels | experience.tex:52-53, 56, 63-64; skills.tex:3-5 | `mark.kernel` | `\textbf`, `\texttt` (projects.tex:6) |
| section files included | main.tex:43-46 | `struct.input` | `\input{sections/education}` and three more |

Components the zip does not use: `\maketitle` title block, abstract, contents, theorems, math, floats and captions, code, footnotes, notes, bibliography, index, cross-references. `\providecommand{\refname}` (open-curve.sty:12-13) exists only because `ctex` looks for a bibliography title; the sample has no bibliography.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| engine guard `\ifXeTeX\else\ifLuaTeX\else\PackageError` | open-curve.sty:5-10 | yes | only raises an error under pdfLaTeX, no printed effect; the emitter records the engine tag |
| `\providecommand{\refname}` | open-curve.sty:13 | yes | a string for `ctex`'s check, not printed here; omit or keep as one line |
| style file `open-curve.sty` as a whole | open-curve.sty:1-126 | yes | emitted as preamble lines: the package loads, font and colour settings and macros in the map (the package is zip-local, not on CTAN; its parts are published ways) |
| `\headeritem`, `\headerdivider`, `\headerlinebreak` | open-curve.sty:79-83 | yes | aliases of `\makebox`, `\hspace`, `\textcolor`, `\par\vspace` as in the map |
| `\cvsection` | open-curve.sty:86-102 | yes (borderline) | `\vbox`/`\hbox to \linewidth{..\hfil}` hold a title, a gap and a rule with no computation; reduce to `sp.manual-space` + `sp.rule` + fonts and colour as in the map; whether the interline glue is identical was not checked (not compiled) |
| `\cvheading` | open-curve.sty:104-114 | yes | spacing, `\hbox to \linewidth` with `\hfil`, fonts, colours |
| `\cvitem` | open-curve.sty:116-121 | yes | hanging paragraph by `\hangindent` from a measured bullet width, `\hangafter`; no counters or conditionals |
| `\cvtagline` | open-curve.sty:123-126 | yes | font switch, colour, `\vspace` |
| `\companyitem` | experience.tex:42-45 | yes | hanging paragraph with raw `\hangindent`/`\hangafter` and a coloured bullet |
| colour definitions NovaBlue and others | experience.tex:5-8 | yes | `color.xcolor` |
| `\companybanner` | experience.tex:12-39 | no | the `tcolorbox` keys reduce, the TikZ `overlay` (experience.tex:17-26) does not (see Blockers) |

## Content-opaque
none (the photo slot is a placeholder box whose image line is a comment at main.tex:26; all text is sample content).

## Lib changes
- New ways proposed: none. `simpleicons` is read as `font.icons` (a symbol-glyph package, the package is the parameter); `class.curve` needs no proposal.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
- Missing assets: the fonts (TeX Gyre Termes and Cursor, Fandol Hei) are not in the zip; they come from the TeX Live tree by file name (open-curve.sty:22-43 explains the patch). Note only, not a blocker.
