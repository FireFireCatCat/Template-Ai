no

# 0009-event-ticket-cards: Event Ticket Cards (sheet of numbered admission tickets)

- Unverified: read from the source, not compiled.
- Source: Source/0009-event-ticket-cards/ (origin: https://latextemplates.com/downloads/event-ticket-cards.zip; licence: LPPL-1.3)
- Kind: misc (manifest hint: misc; the sample is an imposed sheet of 8 tickets)
- Lib: v0
- Engine: pdfLaTeX-compatible (main.tex:6 says "No fontspec -- pdflatex-safe"; the sample loads no font package and uses only `picture` commands, `\parbox` and kernel counters)
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present (the zip is one file, main.tex, 45 lines; the published `ticket.sty` is not bundled and no TeX install exists here, so its source was not read)

## Verdict
No. The sheet-level setup is one published package, `ticket` (Thomas Emmel, LPPL 1.3, CTAN), with two options and three size and spacing commands, on `class.article`; that part is a clean way (proposed below as `NEW:ticket.sheet`). What blocks `yes` is the ticket face: the whole look of a ticket is five text boxes placed by `\put` at fixed picture coordinates inside a redefined `\ticketdefault` hook (main.tex:26-33). That is the `picture` environment (`art.pstricks`) used to lay out the template's own identity, and no lib way expresses "put this text at (x,y) inside the ticket frame" with declarative parameters, so it is `ART` under the rubric. No stroke is drawn by the sample itself (the frame and cut marks come from the package options), but the rubric restricts `picture` for template identity, not only for lines. Limit on the evidence: `ticket.sty` was not read, so what the options, `\ticketNumbers`, `\ticketSize`, `\ticketDistance` and the hook do inside the package is taken from the zip's own comments (main.tex:8, 21-25), which are unverified.

## Blockers
- `ART` the ticket face is five text boxes at fixed `\put` coordinates in a `picture`-based hook, template-defining and with no declarative lib way (main.tex:26-33; coordinates at main.tex:27, 28, 29, 30, 31)

## Class setting
- Class: `class.article` options: `a4paper` (main.tex:11)
- Class-native vocabulary used: none. The sample uses no `\maketitle`, no sectioning and no `abstract`; the only body commands are `\noindent` and eight `\ticket{}` calls from the `ticket` package (main.tex:36-44).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:11 | `class.article` | `a4paper` |
| paper size | main.tex:11 | `page.class-options` | `a4paper` |
| ticket sheet package | main.tex:12 | `NEW:ticket.sheet` | options `boxed` (a frame per ticket, from the option name; effect not read) and `cutmark` (cut marks, from the option name; effect not read) |
| grid of tickets per page | main.tex:14, comment main.tex:8 | `NEW:ticket.sheet` | `\ticketNumbers{2}{4}`, read as 2 by 4 = 8 per page (from the zip comment at main.tex:8; order of the two arguments not verified) |
| ticket size | main.tex:15 | `NEW:ticket.sheet` | `\ticketSize{85}{60}` (unit not stated in the sample; mm is implied by `\parbox{77mm}` at main.tex:27 and the 85 mm width, not verified) |
| gap between tickets | main.tex:16 | `NEW:ticket.sheet` | `\ticketDistance{6}{6}` |
| ticket-number counter | main.tex:18, 19, 30, 32 | `num.counters` | `\newcounter{ticketnum}`, `\setcounter{ticketnum}{101}`, `\stepcounter{ticketnum}` once per ticket, printed with `\theticketnum` (default arabic) |
| ticket face: placement of text | main.tex:26-33 | `art.pstricks` (restricted, ART) | five `\put(x,y){\makebox(0,0)[lt]{...}}` at (4,47), (4,37), (4,22), (4,14), (60,6); reference point `[lt]` (left, top) |
| ticket face: event title | main.tex:27 | `box.minipage` + `font.size-commands` + `mark.kernel` | `\parbox{77mm}{\bfseries\large Riverside Data Summit 2026}` |
| ticket face: date and venue block | main.tex:28 | `box.minipage` + `font.size-commands` | `\parbox{77mm}{\small ... \\ ...}` (two lines, one forced break) |
| ticket face: admission class | main.tex:29 | `font.size-commands` | `\normalsize General Admission` |
| ticket face: number line | main.tex:30 | `font.size-commands` + `num.counters` | `\small Ticket no.\ \#\theticketnum` |
| ticket face: small print | main.tex:31 | `font.size-commands` | `\tiny Non-transferable` |
| ticket repeat, body | main.tex:36-44 | `NEW:ticket.sheet` | `\noindent`, then `\ticket{}` eight times with an empty argument; the content comes from the hook |
| header, footer, page number | none set | none | the sample sets no page style; what the package does to the page style (the only page holds eight tickets) was not read |
| fonts, colour, background, headings, lists, math, floats, tables, code, bibliography, index, language, metadata | none | none | not present in the sample; default Computer Modern, no colour (main.tex:11-45) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\renewcommand{\ticketdefault}{...}` hook body | main.tex:26-33 | no | The hook name is the package's own (the CTAN page for `ticket` names `\ticketdefault` and `\ticket` as the two commands a ticket definition needs), so redefining it is a setting of a published hook. But the body is a `picture` program (five `\put` calls) plus a side effect (`\stepcounter`) run once per ticket. The program part is the `ART` blocker; the counter part alone would reduce to `num.counters`. An emitter could write the same text lines with `\parbox` and no coordinates, but that would change the look (position is the template), so it is not recovery. |
| `\newcounter{ticketnum}` and `\setcounter{ticketnum}{101}` | main.tex:18-19 | yes | Kernel counter declaration and start value: `num.counters`, start = 101. |
| `\stepcounter{ticketnum}` inside the hook | main.tex:32 | yes, as a counter | Kernel counter step. Printing it is `\theticketnum` (main.tex:30). The side effect is only reducible if the hook that carries it can be written, which the `ART` blocker prevents. |

No `.cls`, `.sty`, `\def`, conditional, environment or expl3 code exists in the zip.

## Content-opaque
The ticket text itself (event name, dates, venue, "General Admission", "Non-transferable", main.tex:27-31) is content. The `picture` placement of that text is not counted as opaque content, because the placement is the template (see `ART`).

## Lib changes
- New ways proposed: `NEW:ticket.sheet` for the published package `ticket` (Thomas Emmel, CTAN, LPPL 1.3, version 0.4d, in TeX Live; page https://ctan.org/pkg/ticket: "an easy to handle interface to produce visiting cards, labels for your files, stickers, pins and other stuff for your office, conferences etc."). Engine: pdf (main.tex:6). Emit: preamble `\usepackage[boxed,cutmark]{ticket}`, `\ticketNumbers{c}{r}`, `\ticketSize{w}{h}`, `\ticketDistance{x}{y}`; body is one `\ticket{...}` per ticket.
  - W1: published on CTAN under LPPL 1.3 (the CTAN page also names `\ticketdefault` and `\ticket`; it does not list `\ticketNumbers`, `\ticketSize`, `\ticketDistance` or the two options, which are taken from main.tex:12-16 only).
  - W2: sheet layout is chosen by two options and three commands that take counts and lengths. The ticket face is not declarative (it is a `picture` program), so the face is outside this way and is the `ART` blocker.
  - W3: it serves a kind of document (imposed sheets of tickets, labels, visiting cards, name tags), not one document.
  - W4: an emitter prints it as one package line, three preamble commands and a body wrapper per ticket.
  - Grep of `_Lib.md` for `ticket`, `label`, `card`, `sticker`, `impos`, `cutmark`, `visiting`, `badge` found no home (the only `label` hit is `\label` in `xref.kernel`).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- Nothing addressed to an AI was found in main.tex.
- The decision to say `no` rests on one judgement: `\put` text placement counts as `art.pstricks` ("`picture` environment") when it lays out the template's identity. If the lib later gains a declarative absolute-position way that works inside a ticket frame, this zip would reduce to `class.article`, `page.class-options`, `NEW:ticket.sheet`, `num.counters`, `box.minipage` and `font.size-commands`, and the verdict would change. It would still depend on the unread `ticket.sty`.
- A rebuild with `box.tcolorbox` in a `tbl.tabular` grid was considered and rejected: it would replace the package's imposition and cut marks rather than recover them, and `pg.textpos` anchors to the page, not to a ticket's own frame.
- Note for the consolidator on the document model: the zip has no headings, paragraphs or lists; the only unit is a ticket face, so Flouest's usual model does not map onto it. That is a template-shape question, not a blocker under the rubric.
