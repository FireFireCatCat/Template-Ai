yes

# 0253-tikz-wall-calendar: TikZ Wall Calendar

- Unverified: read from the source, not compiled.
- Source: Source/0253-tikz-wall-calendar/ (origin: https://latextemplates.com/downloads/tikz-kalender.zip; licence: CC-BY-SA per the manifest and ATTRIBUTION.txt:3; the CTAN page lists CC BY-SA 4.0, main.tex:2-4 says "CC-BY-SA" generic)
- Kind: calendar
- Lib: v3
- Engine: pdfLaTeX-compatible (assumed, not read: CTAN lists only TikZ with the `calc` and `calendar` libraries as requirements; the class source is not in the zip)
- Look carried by: class (the whole calendar, its grid, colours, fonts and page are drawn inside the published class `tikz-kalender`; the zip adds a `\setup{...}` key list and one `.events` data file)
- Class origin: tex-distribution-unbundled (published on CTAN as `tikz-kalender`, Rolf Niepraschk, ATTRIBUTION.txt:1-4; main.tex:8 "Ships with TeX Live -- starter does not bundle the class")
- Main file: main.tex (other samples: none; data file holidays.events)
- Read: main yes, zip-local classes and styles none present (the zip has no .cls, .sty or other class file; the published class source was not read)

## Verdict
The zip is one `\documentclass{tikz-kalender}` line (main.tex:22), a `\setup{...}` option block (main.tex:23-30), a single `\makeKalender` call (main.tex:32) and an events data file (holidays.events:6-14). The class is published (CTAN, TeX Live) and not bundled, so it is one way, `class.tikz-kalender`, and its source was not read. The zip defines no macro, environment, counter or drawing of its own, so there is no bespoke code and no ART in the zip: the TikZ drawing lives inside the published class, not in the sample. Following the rubric's ruling for a look carried entirely by a published class, the answer is `yes`; this is evidence about the class dimension, not about the component ways.

## Blockers
none

## Class setting
- Class: `class.tikz-kalender` options: none on `\documentclass` (main.tex:22). The sample's own comment says options passed there are silently dropped and every setting must go through `\setup{...}` (main.tex:10-16). `\setup` keys used: `year=2026`, `title={2026}`, `events={holidays}`, `showweeknumbers` (a flag), `saturdayColor=bright`, `sundayColor=medium` (main.tex:24-29). The key vocabulary is read from the sample only; the CTAN page documents no keys, and the class source is not in the zip.
- Class-native vocabulary used: preamble `\setup{key=value,...}` (main.tex:23); body `\makeKalender` (main.tex:32), which emits the full-year wall calendar (main.tex:1); in the events file (the class reads it, main.tex:18-21, holidays.events:1-5) `\period{start}{end}[name=...]` (holidays.events:6), `\event{date}{text}` (holidays.events:7,8,10,12-14) and the starred `\event*{date}{text}` (holidays.events:9,11); dates are `YYYY-MM-DD`. Per main.tex:19-21 and holidays.events:3-5, `\period` and `\event` are valid only inside the `.events` file (the class raises an error elsewhere).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:22 | `class.tikz-kalender` | no class options |
| class settings block | main.tex:23-30 | `class.tikz-kalender` | `\setup` keys as above; all values are strings, flags or a class colour name |
| calendar year and title | main.tex:24-25 | `class.tikz-kalender` | `year=2026`, `title={2026}` (strings, content) |
| week-number column | main.tex:27 | `class.tikz-kalender` | `showweeknumbers` (boolean flag) |
| weekend colours | main.tex:28-29 | `class.tikz-kalender` | `saturdayColor=bright`, `sundayColor=medium` (the values are shade names of the class, not `xcolor` definitions) |
| events source | main.tex:26, holidays.events:6-14 | `class.tikz-kalender` | `events={holidays}` (file name without `.events`); entries are data: one `\period` with `name=Summer break`, six `\event` and two `\event*` lines |
| calendar body (the whole page grid) | main.tex:32 | `class.tikz-kalender` | `\makeKalender`, no arguments |
| page size and margins, fonts, header/footer, colours, grid drawing | not set in the sample (main.tex has no geometry, font, colour or pagestyle lines) | `class.tikz-kalender` | fixed by the class defaults (class source not read, so the values are not recorded here) |
| language, hyperlinks, bibliography, floats, tables, lists, headings | not used (main.tex:31-33 holds only `\makeKalender`) | none needed | none |

Considered and not used: the `kalender` package (`cal.kalender`) is a different package (`\Kalender{year}`, German grid); this zip loads the class `tikz-kalender`, so `cal.kalender` is not its way.

## Bespoke code
none. The zip defines no `\newcommand`, `\def`, environment, counter or conditional: main.tex has only `\documentclass`, `\setup`, `\begin{document}`, `\makeKalender` and `\end{document}` (main.tex:22-33), and holidays.events uses only the class's `\period` and `\event` (holidays.events:6-14). The `\setup` key list and the events file are options and data for a published class (W2: declarative values, strings, flags and dates).

## Content-opaque
The calendar drawing is produced by the class's TikZ code, not by the sample; the sample has no TikZ picture of its own. The events list (holidays.events:6-14) is content data. Nothing else is opaque.

Notes: no text addressed to an AI was found in the zip. ATTRIBUTION.txt:6-8 is a licence credit request to people who redistribute the template (name Rolf Niepraschk), recorded here as a licence note, not acted on. main.tex:2-7 states the class header says CC-BY-SA and class version v0.6b; the CTAN page read for this analysis shows version 0.7b and CC BY-SA 4.0, so the class version in the author's TeX Live may differ from the one the sample's author tested. main.tex:10-16 and 18-21 claim to have confirmed behaviour; nothing was compiled or run here.

## Lib changes
- New ways proposed: none. `class.tikz-kalender` is a class way and needs no proposal; its vocabulary (`\setup{year,title,events,showweeknumbers,saturdayColor,sundayColor}`, `\makeKalender`, and in `.events` files `\period` `\event` `\event*`) is recorded above under "Class setting".
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
