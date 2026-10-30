no

# 0009-event-ticket-cards: Event Ticket Cards (imposed sheet of numbered admission tickets)

- Unverified: read from the source, not compiled.
- Source: Source/0009-event-ticket-cards/ (origin: https://latextemplates.com/downloads/event-ticket-cards.zip; licence: LPPL-1.3)
- Kind: misc
- Lib: v1
- Engine: pdfLaTeX-compatible (main.tex:5-6 says no fontspec; the sample loads no xe/lua package; `ticket.sty` is not in the zip and was not read)
- Look carried by: preamble (kernel `article` carries nothing; the published `ticket` package imposes the sheet, frames and cut marks; the sample's own preamble sets the package options, the grid and the whole ticket face, main.tex:11-33)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
no. The zip is one 45-line `main.tex` with no `.cls`, `.sty` or other local file. Almost everything maps to an existing lib way: `class.article`, `page.class-options`, `ticket.sheet` (for the published `ticket` package: options, grid, size, gap, `\ticket{}`), kernel font sizes, `\parbox`, a line break and a kernel counter. The exception is the ticket face: five text blocks placed at absolute coordinates with `picture` commands (`\put(x,y){\makebox(0,0)[lt]{...}}`) inside a redefined `\ticketdefault` hook (main.tex:26-33). That layout is the template's whole visible identity. The lib's `ticket.sheet` line puts the face outside the way ("content, or ART when it draws the template's identity"), and `picture` is listed under the restricted `art.pstricks`. I record it as `ART/preamble`. It is a close call because the face draws no rule or shape, only positions text; Notes says how the answer would flip.

## Blockers
- `ART/preamble` ticket face laid out by absolute `\put` coordinates in the redefined `\ticketdefault`: `\put(4,47)`, `(4,37)`, `(4,22)`, `(4,14)`, `(60,6)`, each holding a `\makebox(0,0)[lt]{...}` (main.tex:26-33); no lib way holds positioned text inside a `picture`, and the one candidate home, `art.pstricks`, is restricted

## Class setting
- Class: `class.article` options: `a4paper` (main.tex:11). The class is the kernel LaTeX base class, loaded unchanged and not bundled in the zip; its source was not read.
- Class-native vocabulary used: none (no `\maketitle`, abstract, sectioning, list, float or bibliography; the body is `\noindent` plus eight `\ticket{}` calls, main.tex:36-44). The vocabulary in use belongs to the `ticket` package, not the class: `\ticketNumbers`, `\ticketSize`, `\ticketDistance`, `\ticket`, and the hook `\ticketdefault`. `ticket` is a package, not a class: CTAN `ticket` 0.4d, maintainer Thomas Emmel, LPPL 1.3, in TeX Live (one read of https://ctan.org/pkg/ticket; it names only `\ticketdefault` and `\ticket`), so it passes W1.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:11 | `class.article` | option `a4paper` |
| paper size | main.tex:11 | `page.class-options` | `a4paper`; no `geometry`, no `\setlength` on the page anywhere |
| sheet imposition, ticket frames, cut marks | main.tex:12 | `ticket.sheet` | package options `boxed`, `cutmark` |
| grid of tickets per page | main.tex:14; comment main.tex:8 | `ticket.sheet` | `\ticketNumbers{2}{4}` (the comment says 2x4 = 8 per page; which argument is columns comes from the comment, not from `ticket.sty`) |
| ticket size | main.tex:15 | `ticket.sheet` | `\ticketSize{85}{60}` (unit not stated in the sample; mm is likely given the 77mm parbox at main.tex:27, not verified) |
| gap between tickets | main.tex:16 | `ticket.sheet` | `\ticketDistance{6}{6}` |
| tickets in the body | main.tex:37-44 | `ticket.sheet` | eight `\ticket{}` calls with an empty argument; the face comes from the hook |
| no indent before the first ticket | main.tex:36 | `sp.lengths` | `\noindent` (closest home, the paragraph-indent family; no other lib way names it) |
| ticket face: positioned text blocks | main.tex:27-31 | `art.pstricks` | `picture` commands `\put(x,y){\makebox(0,0)[lt]{...}}` at (4,47), (4,37), (4,22), (4,14), (60,6); this is the `ART/preamble` blocker |
| text block width and wrapping | main.tex:27-28 | `box.minipage` | `\parbox{77mm}`, twice |
| line break inside the date and venue block | main.tex:28 | `sp.manual-space` | `\\` |
| title in bold and larger | main.tex:27 | `mark.kernel` + `font.size-commands` | `\bfseries` (series switch, filed with the kernel emphasis commands) with `\large` |
| other size steps | main.tex:28-31 | `font.size-commands` | `\small` (date and venue, ticket number), `\normalsize` (admission type), `\tiny` (Non-transferable) |
| running ticket number | main.tex:18-19, 30, 32 | `num.counters` | `\newcounter{ticketnum}`, `\setcounter{ticketnum}{101}`, `\theticketnum` printed, `\stepcounter{ticketnum}` as the last action of the hook |

Not defined by the sample, so no row: fonts and encoding (Computer Modern default, no font package), colour, header and footer, page numbering, spacing beyond `\noindent`, headings, lists, maths, theorems, floats, tables, captions, code, bibliography, index, cross-references, language, hyperref, front matter.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\newcounter{ticketnum}`, `\setcounter{ticketnum}{101}` | main.tex:18-19 | yes | kernel counter, `num.counters`; two preamble lines |
| `\renewcommand{\ticketdefault}{...}` (the face) | main.tex:26-33 | no, in part | it redefines a hook of the published `ticket` package (CTAN names `\ticketdefault` as one of its two commands). Its parts reduce (fonts to `font.size-commands` and `mark.kernel`, `\parbox` to `box.minipage`, `\\` to `sp.manual-space`, counter to `num.counters`), but the positioned `picture` layout has no lib way: the `ART/preamble` blocker |
| `\stepcounter{ticketnum}` as a side effect inside the hook | main.tex:32 | yes, with a caveat | `num.counters`; the numbering is right only if the package runs the hook once per `\ticket`, which the sample's comment states (main.tex:21-25); `ticket.sty` was not read to confirm |

No `\def`, environment, conditional or other macro is defined in the zip.

## Content-opaque
none (the event name, dates, venue and admission type, main.tex:27-31, are plain content strings)

## Lib changes
- New ways proposed: none. I considered a way for text placed at coordinates in a ticket and did not propose it: the lib's `ticket.sheet` line says the face is outside the way, `picture` already sits in restricted `art.pstricks`, and a new way would only relabel that restricted one.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- Judgment call, so it can be re-read: the verdict is `no` only because of the one `ART/preamble` item. Every other row reduces to a lib way and nothing else is bespoke. If the project rules that text-only `\put` placement (no rule, curve or shape drawn) is declarative layout and not artwork, this zip becomes `yes` with no new way. The `boxed` frame and the cut marks are drawn by the published package options, not by the sample, so they are not part of the blocker.
- Unread: `ticket.sty` and its manual are not in the zip. The meaning of the `\ticketNumbers`, `\ticketSize` and `\ticketDistance` arguments comes from the sample's comments and the lib's `ticket.sheet` line; the CTAN page names only `\ticketdefault` and `\ticket`.
- No text addressed to an AI was found in `main.tex`.
