no

# 0098-minimal-cv: Minimal CV

- Unverified: read from the source, not compiled.
- Source: Source/0098-minimal-cv/ (origin: https://latextemplates.com/downloads/minimal-cv.zip; licence: MIT, README.md:46; upstream author Fabio Matti, README.md:9)
- Kind: cv
- Lib: v1
- Engine: pdfLaTeX-compatible (`[T1]{fontenc}` main.tex:104, `raleway` with no fontspec main.tex:107, README.md:40 says `pdflatex main`; no XeLaTeX or Lua code)
- Look carried by: mixed (the layout, colours, fonts and tables are all in the sample's own preamble and body, main.tex:1-347; the nine contact icons, fifteen flags and the portrait are zip-local TikZ files loaded with `\input`)
- Class origin: tex-distribution-unbundled (kernel `article`, main.tex:1; no `.cls` or `.sty` in the zip, source not read)
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present (all 25 asset files in `icons/`, `flags/`, `images/` read in full; README.md read)

## Verdict
no. Everything the sample does in its preamble and tables reduces to lib ways, and the one-page poster-box layout has a published home (tcolorbox's `poster` library, proposed as `poster.tcbposter`). What blocks it is the contact-icon set: seven hand-drawn TikZ glyphs (address, phone, e-mail, birthday, nationality, GitHub, LinkedIn; two more ship unused) that are fixed per field type, are coloured by the template's own colour scheme and are the template's identity, so they are `ART`, not figure content. `font.icons` would give different glyph shapes, not these. This is the one borderline call: if the icon set were treated as shipped image assets, every other item here reduces and the answer would be `yes`; I did not widen the ART test to make it fit.

## Blockers
- `ART/body` seven zip-local TikZ icon pictures are `\input` into the sidebar rows and scaled with `\scalebox{0.075}`: address (main.tex:187; icons/address.tex:1-18), phone (main.tex:193; icons/phone.tex:1-14), e-mail (main.tex:198; icons/email.tex:1-15), birthday (main.tex:206; icons/birthday.tex:1-30), nationality (main.tex:211; icons/nationality.tex:1-16), GitHub (main.tex:219; icons/github.tex:1-27, bezier `to[out=..,in=..]` outline), LinkedIn (main.tex:224; icons/linkedin.tex:1-17). Each is a `\fill` of coordinate polygons on a `minimal-main` disc in `minimal-contrast` (e.g. icons/address.tex:4,7-15), so the icon colours follow the colour scheme (main.tex:12-14). Two more ship unused: icons/scholar.tex, icons/website.tex.

## Class setting
- Class: `class.article` options: `11pt` (main.tex:1)
- Class-native vocabulary used: none. The sample calls no `\maketitle`, `\section`, `abstract` or list environment; only `\begin{document}` (main.tex:131) and the sample's own boxes and tables.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.article` | 11pt |
| type size | main.tex:1 | `page.class-options` | 11pt; no paper option (paper is set by geometry) |
| page geometry | main.tex:47-48 | `page.geometry` | paperheight=842pt, paperwidth=595pt, margin=0pt (A4 with no margin, so the boxes run to the paper edge) |
| paragraph indent | main.tex:51 | `sp.lengths` | `\parindent`=0pt |
| colour definitions | main.tex:7, 12-14, 32-39 | `color.xcolor` | `\definecolor{..}{HTML}{..}`: minimal-main 131313, minimal-light F2F2F2, minimal-contrast F3F2F5, minimal-black 131313, minimal-white F3F2F5, minimal-red C43C2D, minimal-blue 343454, minimal-yellow F1C40F, minimal-green 2D6514, minimal-beige D7B6A5, minimal-orange F28D49; three alternative main/light/contrast triples are commented out (main.tex:17-29, README.md:23-27) |
| one-page poster layout | main.tex:42, 133-136, 141-146, 165-175, 252-262, 338-343 | `poster.tcbposter` | `\usepackage[most]{tcolorbox}`; `tcbposter[poster={columns=1, rows=1, spacing=0pt}, boxes={sharp corners, halign=center, valign=center, boxrule=0pt}]`; four `\posterbox` nodes: headbox (`span=1`, `rowspan=0.080`), sidebar (`below=headbox`, `column=1`, `span=0.35`, `rowspan=0.910`), mainbox (`column*=1`, `span=0.65`, `below=headbox`, `rowspan=0.910`), blankbox2 (`below=sidebar`, `column=1`, `span=1`, `rowspan=0.010`, empty) |
| full-bleed colour bands | main.tex:142, 166, 253, 338 | `poster.tcbposter` | per-box `colback`: minimal-main (header and the thin footer band), minimal-light (sidebar), white (main column) |
| in-box padding | main.tex:59, 168, 170, 255, 257 | `poster.tcbposter` | `top`, `right` (sidebar) and `top`, `left` (main) = 0.015 of `\paperheight`, about 12.63pt; `valign=top`, `halign=right` (sidebar) or `left` (main) |
| name in the header band | main.tex:111, 149-151 | `mark.kernel`, `font.size-commands`, `sp.microtype`, `sp.manual-space`, `color.xcolor` | `\uppercase{\textbf{\fontsize{30}{100}{\lsstyle{First \hspace{3pt} Initial \hspace{3pt} Last}}}}`; text colour white via `\color{white}` |
| letterspacing | main.tex:103, 111 | `sp.microtype` | `[letterspace=20]`, applied by `\lsstyle` |
| rule under the name | main.tex:153-157 | `sp.rule`, `sp.manual-space` | white rule 10cm wide by about 0.02cm: reducible from the TikZ rectangle (-5.0,-0.01) to (5.0,0.01), `fill=white` (stroke width not set, so the real height is a little larger); `\vspace{-7px}` before, `\vspace{5px}` after |
| job-title line | main.tex:112, 159 | `mark.kernel`, `font.size-commands` | `\uppercase{\textbf{\Large{Structural engineer}}}` |
| font encoding | main.tex:104 | `font.fontenc-t1` | `[T1]` |
| text face | main.tex:107 | `font.helvet` | package `raleway` with option `semibold` (a sans text-face package is the parameter, as the v1 change log says for `font.helvet`) |
| default family | main.tex:108 | `font.family-default` | `\familydefault` = `\sfdefault` |
| column headings (Contact, Education...) | main.tex:112, 184, 203, 216, 229, 267, 282, 297, 307, 316, 326 | `mark.kernel`, `font.size-commands`, `tbl.tabular` | no sectioning commands; each heading is `\titlefont{..}` in the second cell of a table row with an empty first cell |
| heading divider | main.tex:185, 204, 217, 230, 268 (and the same pattern after each heading) | `tbl.tabular`, `sp.manual-space` | `\hline` followed by `\mediumspace`, an empty row `\\[-3pt]` |
| sidebar table | main.tex:178-246 | `tbl.tabular` | `{rl}`; rows of icon cell and bold label (`\textbf`, `mark.kernel`) over value cell |
| icon and flag cells | main.tex:187-245; 118 | `tbl.multirow`, `fig.graphicx` | `\multirow{4}{*}{..}` (address) and `\multirow{2}{*}{..}` (the rest); picture scaled with `\scalebox{0.075}` (graphics/graphicx; the sample does not load it, assumed pulled in by tikz, not verified); the picture itself is ART (icons) or content-opaque (flags) |
| portrait | main.tex:180-181 | `tbl.tabular`, `fig.graphicx` | `\multicolumn{2}{@{}c@{}}{\scalebox{0.25}{\input{images/image.tex}}}`; a commented `\includegraphics[scale=0.25]{images/image.jpg}` is the photo alternative (README.md:19-21); picture is content-opaque |
| main-column table | main.tex:121, 265-332 | `tbl.tabular`, `font.size-commands` | `array` column spec `{>{\footnotesize}rl}`: dates in the right-aligned first column, details in the second; plain `r`/`l`, no `p{}` wrapping (README.md:29-36) |
| interline spacing aliases | main.tex:54-56 (used throughout 182-330) | `sp.manual-space` | `\largespace`=`\\[2pt]`, `\mediumspace`=`\\[-3pt]`, `\smallspace`=`\\[-5pt]` |
| contact links | main.tex:127-128, 195, 200, 221, 226 | `meta.hyperref`, `meta.url` | `\usepackage{hyperref}` with no options and no `\hypersetup`; `\href{tel:..}`, `\href{mailto:..}`, `\href{https://..}`; `\urlstyle{same}` |
| header and footer | none | none | no `\pagestyle` or `\thispagestyle` call in the sample; the document default applies; with `margin=0pt` the running foot is not placed inside the printed area (not verified, not compiled) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\largespace`, `\mediumspace`, `\smallspace` | main.tex:54-56 | yes | aliases of `\\[len]`: `sp.manual-space` with 2pt, -3pt, -5pt |
| `\inboxspacing` | main.tex:59 | yes | the length `.015\paperheight`: inline the value (about 12.63pt) into the `top`, `left`, `right` keys of `poster.tcbposter` |
| `\sideboxwidth`, `\mainboxwidth`, `\headboxheight`, `\mainboxheight`, `\footboxheight` | main.tex:62-68 | yes | five numeric constants (0.35, 0.65, 0.080, 0.910, 0.010; each group sums to 1, main.tex:61, 65) used as `span` and `rowspan` values: inline them |
| `\header` | main.tex:111 | yes | alias of `\uppercase`, `\textbf`, `\fontsize{30}{100}`, microtype `\lsstyle`, `\hspace{3pt}`: `mark.kernel`, `font.size-commands`, `sp.microtype`, `sp.manual-space` |
| `\titlefont` | main.tex:112 | yes | alias of `\uppercase{\textbf{\Large{..}}}`: `mark.kernel`, `font.size-commands` |
| header rule `tikzpicture` | main.tex:154-156 | yes, approximately | a straight filled rectangle with no free drawing: `sp.rule` (white, 10cm by about 0.02cm); written down as an approximation of the height, not an identical rule |
| icons/*.tex (nine pictures) | icons/address.tex:1-18 ... icons/website.tex:1-12 | no | coordinate drawings with no lib way (`ART/body`); `font.icons` gives other glyph shapes |
| flags/*.tex (fifteen pictures, three used) | flags/britain.tex:1-25, flags/france.tex:1-14, flags/germany.tex:1-15 (used); the others unused | not needed | chosen per language, so content-opaque (below) |
| images/image.tex | images/image.tex:1-31 | not needed | the placeholder portrait, replaced by a photo per README.md:19-21: content-opaque |

No `\newenvironment`, `\newcounter`, `\newif` or `\def` appears in main.tex, and no macro is defined in `icons/`, `flags/` or `images/` (grep over those folders for `newcommand`, `def`, `usepackage`, `documentclass` found none).

## Content-opaque
- Portrait silhouette: TikZ picture images/image.tex:1-31, loaded at main.tex:180 (swap for a photo, README.md:19-21)
- Language flags: flags/britain.tex, flags/france.tex, flags/germany.tex, loaded at main.tex:232, 237, 242 (twelve more flags in `flags/` are unused)
- All CV text, dates, names, links and the fictional personal data (main.tex:151-330)

## Lib changes
- New ways proposed: `poster.tcbposter`: tcolorbox `poster` library, the `tcbposter` environment with `\posterbox` (pdfLaTeX; the sample gets it through `\usepackage[most]{tcolorbox}`, main.tex:42, and does not load it separately, which I did not verify). W1: tcolorbox is on CTAN and documented, with the poster library in its manual. W2: the grid and every box are set by key=value options (`poster={columns, rows, spacing}`, `boxes={..}`, per box `name`, `column`, `column*`, `span`, `rowspan`, `below`, `colback`, `halign`, `valign`, `top`, `left`, `right`). W3: it lays out any poster or page-filling box grid, not this CV. W4: an emitter writes the package line and wraps each node's content in `\posterbox[..]{..}{..}` inside `tcbposter`. Not `box.tcolorbox` (one box, not a grid with spanning rules), not `poster.tikzposter` or `poster.baposter` (other packages and vocabularies); it follows the lib's own split of tcolorbox libraries into `thm.tcolorbox` and `code.tcblisting`.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
