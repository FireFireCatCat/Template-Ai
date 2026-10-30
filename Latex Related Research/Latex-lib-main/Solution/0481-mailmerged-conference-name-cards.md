no

# 0481-mailmerged-conference-name-cards: Mailmerged Conference Name Cards

- Unverified: read from the source, not compiled.
- Source: Source/0481-mailmerged-conference-name-cards/ (origin: https://latextemplates.com/downloads/mailmerged-conference-name-cards.zip, repackaging of the Overleaf template https://www.overleaf.com/latex/templates/mailmerged-conference-name-cards/mpwmfvkngdzq per ATTRIBUTION.txt:4; licence: CC-BY-4.0)
- Kind: misc (conference name cards, two per row on A4)
- Lib: v4
- Engine: needs XeLaTeX (`fontspec` `\setmainfont` at main.tex:3-4; README.md:6-7 says "compile with XeLaTeX")
- Look carried by: preamble (the whole card face is the `\namecard` macro drawn with TikZ at main.tex:9-27; the data loop and two-per-row flow are in the body at main.tex:36-41; the class adds nothing)
- Class origin: tex-distribution-unbundled (kernel `article`, not in the zip)
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present (the zip holds only main.tex, README.md, ATTRIBUTION.txt; no .cls, .sty, .def, .cfg)

## Verdict
No. The page setup, font, colours and the data loop each have a published home, but the thing the template exists to print, the name card itself, is a hand-drawn TikZ picture (a rounded frame, a filled band, five positioned text nodes and a QR code) inside a zip-local `\namecard` macro, so it is template-defining artwork with no declarative lib way (`ART/preamble`). Separately, the two-cards-per-row flow is driven by a hand-rolled counter and `\ifodd` test inside the `\DTLforeach` body (`BESPOKE/body`). The `datatool` mail merge is a published way that passes W1 to W4 and is proposed below; it does not rescue the verdict.

## Blockers
- `ART/preamble` the name card face: `\namecard` is a `tikzpicture` with a rounded-corner frame `(0,0) rectangle (8.6,5.4)`, a filled band `(0,0) rectangle (8.6,1.0)`, a fixed title node "OPEN METHODS", four data nodes at hand-set coordinates, a fixed line "openmethods.example", and a QR node (main.tex:9-27); no lib way takes this as parameters (`ticket.sheet` keeps the ticket face outside the way: "ART when it draws the template's identity")
- `BESPOKE/body` hand-rolled counter and conditional that drive layout inside the merge loop: `\newcounter{cardcount}`, `\stepcounter{cardcount}`, `\ifodd\value{cardcount}\hfill\else\par\vspace{.22cm}\fi` (main.tex:37, 39, 40); it alternates `\hfill` and a paragraph break by record parity at loop time, which no lib way expresses (it reduces only by unrolling the records at emit time, which drops the data-driven loop the template is built around)

## Class setting
- Class: `class.article` options: `a4paper` (main.tex:1)
- Class-native vocabulary used: none (no `\maketitle`, no sectioning, no abstract; the body is only the merge loop)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.article` | `a4paper` |
| paper size | main.tex:1 | `page.class-options` | `a4paper` |
| page geometry | main.tex:2 | `page.geometry` | `margin=.55cm` (all four sides) |
| main font | main.tex:3-4 | `font.fontspec` | `\setmainfont{Latin Modern Sans}` |
| card font switches | main.tex:14, 16, 18, 20, 22 | `mark.kernel` | `\sffamily`, `\bfseries` (set as TikZ node `font=` keys) |
| card font sizes | main.tex:14, 16, 18, 20, 22 | `font.size-commands` | `\Large` (title), `\large` (name), `\small` (role), `\scriptsize` (email and URL) |
| colours | main.tex:7-8 | `color.xcolor` | `conferenceblue` HTML `173F5F`; `conferencegold` HTML `F4B942` (defined, never used in the file) |
| colour mixing on card text | main.tex:18 | `color.xcolor` | `conferenceblue!80` for the role line; `white` for the band title (main.tex:14) |
| page style | main.tex:6 | `hf.pagestyle-kernel` | `\pagestyle{empty}` |
| card frame, band, text nodes | main.tex:10-23 | `art.tikz` | `rounded corners=3pt`, `fill=white`, `draw=conferenceblue`, `line width=.8pt`, rectangle 8.6 by 5.4; band rectangle 8.6 by 1.0 filled `conferenceblue`; nodes `anchor=west`/`north west` at (.55,.5), (.58,4.65), (.6,4.18), (.6,3.38), (.6,2.95) (**ART**) |
| QR code on the card | main.tex:5, 24-25 | `art.content-package` | `qrcode` (CTAN, TeX Live; `\qrcode[height=1.35cm]{#4}` in a node `anchor=south east` at (8.0,1.65)); a specialised content package whose argument is the record's site URL, inside the ART picture |
| card macro | main.tex:9 | (bespoke, see below) | `\newcommand{\namecard}[4]` taking name, role, email, site URL |
| mail merge: load data | main.tex:5, 36 | `struct.datatool` | `\usepackage{datatool}`; `\DTLloaddb{participants}{participants.csv}` |
| mail merge: record loop | main.tex:38-41 | `struct.datatool` | `\DTLforeach{participants}{\person=Name,\role=Role,\mail=Email,\site=Site}{body}`; body calls `\namecard` once per record |
| embedded data file | main.tex:28-34 | content (kernel `filecontents*`) | CSV with columns `Name,Role,Email,Site` and four sample rows; data, not template |
| card flow, two per row | main.tex:37, 39-40 | `num.counters` | `\newcounter{cardcount}`, `\stepcounter{cardcount}` (counter used as a loop-time parity switch, see blocker) |
| card spacing | main.tex:40 | `sp.manual-space` | `\hfill` after odd cards; `\par\vspace{.22cm}` after even cards |
| tikz loading | main.tex:5 | `art.tikz` | `\usepackage{tikz}` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\namecard[4]` | main.tex:9-27 | no (ART) | The macro itself is an alias with four parameters (reducible as an alias), but its body is the card face: a TikZ picture with fixed coordinates, a fixed title "OPEN METHODS" and fixed URL line "openmethods.example". No lib way (`ticket.sheet`, `box.tcolorbox`, `bg.tikzpagenodes`) takes these shapes as declarative parameters. |
| `cardcount` counter and `\ifodd` branch | main.tex:37, 39, 40 | no inside the loop | A loop-time conditional that decides `\hfill` or `\par\vspace`. If the emitter knew the record count it could unroll to explicit `\hfill` and `\par\vspace{.22cm}` (`sp.manual-space`), but then the mail merge is no longer data driven; recorded as a blocker. |
| `participants.csv` via `filecontents*` | main.tex:28-34 | yes (content) | The file body is data; the environment is a kernel facility that writes it before `\DTLloaddb` reads it, no tool outside TeX. |

## Content-opaque
- TikZ card picture inside `\namecard` (main.tex:10-26): not figure content here, it is the template's identity, so it is counted as `ART` above, not as opaque content.
- QR code `\qrcode{#4}` (main.tex:25): content of the card (the record's URL), held as `art.content-package`.
- CSV rows (main.tex:29-33): data.

## Lib changes
- New ways proposed: `struct.datatool` `datatool` (CTAN and TeX Live, LPPL 1.3, Nicola Talbot; read at ctan.org/pkg/datatool; pdfLaTeX-compatible, no external tool): loads a database from a file and repeats a body once per record; `\usepackage{datatool}`, `\DTLloaddb[options]{name}{file}`, `\DTLforeach[condition]{name}{\macro=Column,...}{body}`. W1 published on CTAN. W2 the file name, database name, column keys and an optional row condition are values; the body is the wrapped node content, as for any environment. W3 serves any record-driven document (name cards, letters, labels), not one document. W4 printable as a preamble line plus a load call and a body wrapper around a node's content. Not `ltr.formlett` (formlett's own letter format with `\moreletter` records), not `struct.input` (file inclusion, not record iteration).
- Considered, not proposed: `qrcode` as its own way (kept under `art.content-package`, where the lib already files specialised content packages whose argument is a string).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
