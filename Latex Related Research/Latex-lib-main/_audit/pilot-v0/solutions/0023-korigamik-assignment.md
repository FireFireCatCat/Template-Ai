yes

# 0023-korigamik-assignment: KorigamiK assignment (cover-page class)

- Unverified: read from the source, not compiled.
- Source: Source/0023-korigamik-assignment/ (origin: https://latextemplates.com/downloads/korigamik-assignment.zip; licence: GPL-3.0-or-later)
- Kind: assignment
- Lib: v0
- Engine: pdfLaTeX-compatible (stated at README.md:7; not tested)
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present (the class `korigamik` is NOT bundled: main.tex:2-6, README.md:8)

## Verdict
The zip is a 50-line sample that does no typesetting of its own: `\documentclass{korigamik}` (main.tex:17), the class's own title-block commands, four `\section`s, one `\cite` and a classic BibTeX bibliography. The class is published on CTAN (ctan.org/pkg/korigamik: version 1.0, GPL-3.0-or-later, author Kushagra Lakhwani, "based on the article class, with changes that allow more flexible front matter"), so it is one way, `class.korigamik`, under the rubric's rule for published classes that are not bundled. The zip holds no bespoke macro, no zip-local class or style, and no artwork code, so every construct is a published way with string parameters. The class's own source was not read (not shipped, no local TeX, no network read of the `.cls`), so what it loads internally and how the cover box is drawn are unverified; that does not change the verdict, because the cover page is reached only through the class's published declarative commands.

## Blockers
none

## Class setting
- Class: `class.korigamik` options: none (main.tex:17 has no option list)
- Class-native vocabulary used: `\title`, `\author`, `\rollno`, `\subject` (an assignment-course string here, not KOMA's `\subject`), `\course`, `\semester`, `\titlelabel` (corner-box text), `\header` (running head on later pages), `\bottomnote` (institute line under the date), `\maketitle` (builds the designed cover page) (main.tex:19-27,31; meanings from README.md:12-14,21-24). Documented but not used by the sample: `\logoimage{path}{scale}{label}` with placeholder `<your logo here>` when absent (README.md:18-20).
- Class source status: not read. Facts about the class come from the sample's own comments (main.tex:12-16), the zip README, and the CTAN page (description, version, licence, author only; the page lists no dependencies and does not document the commands).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:17 | `class.korigamik` | no options |
| title block (cover page) | main.tex:19-25,27,31; README.md:3-5 | `front.class-native` | title="Your Title Here", author="Ada Lovelace", rollno="2026-A-001", subject="Analytical Engines", course="Computer Science", semester="Fall 2026", titlelabel="Assignment", bottomnote="Institute of Analytical Engines"; `\maketitle` emits the boxed title with corner label and the name/roll-no/semester/course table |
| logo slot on cover | README.md:18-20 (sample does not call `\logoimage`) | `front.class-native` | `\logoimage` not called, so the class prints its own placeholder; command takes path, scale, label |
| running head (later pages) | main.tex:26; README.md:23 | `hf.class-native` | header="Your Title Here" |
| date line on cover | not set in sample; README.md:24 says the bottom note sits under "the date" | `front.class-native` | `\date` not given, so the class default applies (not read) |
| page geometry | not set in sample | `class.korigamik` | class default (not read) |
| columns, spacing, fonts, colour, background | not set in sample (no package, no length, no colour command anywhere in main.tex) | `class.korigamik` | class defaults (not read) |
| headings | main.tex:33,36,40,44; README.md:12-14 | `head.kernel` | `\section` x4, article look as stated by README; "minor adjustments" in the class (CTAN description) not read |
| numbering / counters | main.tex:33-44 | `head.kernel` | default section numbering (no `\setcounter`, no `secnumdepth`) |
| cross-reference labels | main.tex:37,41 | `xref.kernel` | `\label{sec:method}`, `\label{sec:results}`; no `\ref` in the sample |
| citation | main.tex:34 | `bib.bibtex-bst` | kernel `\cite{knuth1984texbook}` |
| bibliography | main.tex:47-48; references.bib:1-6; README.md:25 | `bib.bibtex-bst` | `.bst` style = `plain`, database = `references` |
| abstract, contents, lists, quotes, notes, math, theorems, floats, tables, captions, code, boxes, index | not used in the sample | none | n/a (nothing to recover from this sample) |

## Bespoke code
none. There is no zip-local `.cls`, `.sty`, `.def`, `\newcommand`, `\def`, environment, counter or conditional: the only macros called are the class's published ones. `korigamik` itself is published on CTAN, so it is not bespoke code.

## Content-opaque
none. The cover box, corner label and table are produced inside the published class (README.md:3-5), not by drawing code in this zip, so they are not recorded as `ART`. If the class draws them with TikZ, that is internal to the published way and is reached only through the string commands above.

## Lib changes
- New ways proposed: none. `class.korigamik` is written plainly per the rubric's class rule (published class, not bundled; source not read). Suggested class-section entry for the consolidator: `class.korigamik` | assignment/lab-report cover-page class on article; vocabulary as listed under "Class-native vocabulary used" | pdf.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- Text addressed to an AI inside the zip: none found.
- Missing asset: `korigamik.cls` is not shipped (main.tex:2-6). An emitter that targets this way needs a TeX installation that provides the class (README.md:8 says TeX Live ships it; not checked here, no TeX is installed on this machine). The zip also ships no logo image, and the sample does not use one.
- Coverage limit: only the subset of the class the sample uses is evidenced (cover page, running head, plain sections, BibTeX). Anything else the class offers (README lists `\logoimage`) is evidenced by the README only.
