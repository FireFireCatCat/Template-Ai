yes

# 0536-screenplay-latex: Screenplay LaTeX

- Unverified: read from the source, not compiled.
- Source: Source/0536-screenplay-latex/ (origin: https://latextemplates.com/downloads/screenplay-latex.zip; licence: MIT per the manifest; the published `screenplay` class itself is GPL per ctan.org/pkg/screenplay)
- Kind: misc (a film screenplay; no listed kind fits, and the manifest hint is also misc)
- Lib: v4 (the snapshot read)
- Engine: pdfLaTeX-compatible (the sample loads no `fontspec` or other xe/lua package, main.tex:4-9; the CTAN page does not state an engine and the class source was not read, see Verdict)
- Look carried by: class (the whole look is the published `screenplay` class; the zip holds only a 28-line `main.tex` that sets title data and a few scenes, main.tex:4-28)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
yes. The zip holds exactly one file, `main.tex` (28 lines); there is no `.cls`, `.sty`, `.def`, README or asset, so there is no zip-local code. The sample says it uses "the TeX Live screenplay class" (main.tex:1-3) and loads it with `\documentclass{screenplay}` (main.tex:4). That class is published: ctan.org/pkg/screenplay (one read) shows `screenplay` v1.6, John Pate, GNU GPL, in TeX Live and MiKTeX, "the format recommended by the Academy of Motion Picture Arts and Sciences". It is not bundled in the zip, so its source was not read. The sample adds no preamble code at all, only strings and class commands, so no bespoke macro, no `ART` and no `EXTERNAL` blocker exists in what was read. Caveats: (1) the command names and argument shapes below come from the sample's use of them, not from the class source, which I did not open; the CTAN page lists no commands; (2) the page, font, spacing and running-head look is set inside the unread class and so is not itemised; (3) main.tex:1-3 says an upstream GitHub project provides a different "modern screenplay class" that is not in the zip; this analysis covers only the TeX Live class the sample loads.

## Blockers
none

## Class setting
- Class: `class.screenplay` options: none (main.tex:4).
- Class-native vocabulary used: `\title` (main.tex:5), `\author` (main.tex:6), `\realauthor` (main.tex:7), `\address` (main.tex:8), `\coverpage` (main.tex:10), `\slug{INT.|EXT.}{place and time}` with two string arguments (main.tex:11, 18, 21), `dialogue` environment with the speaker name as a required argument (main.tex:12, 22, 25) and an optional parenthetical (`[quietly]`, main.tex:15), and action text as plain paragraphs (main.tex:19-20).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class | main.tex:4 | `class.screenplay` | no options |
| page size, margins, font, line spacing, running head and page numbers | main.tex:4 (set inside the class; not read, not itemised) | `class.screenplay` | none passed by the sample; class defaults |
| title data | main.tex:5-8 | `front.class-native` | `\title{The Last Signal}`, `\author{Writer Name}`, `\realauthor{Writer Name}`, `\address{writer@example.org}` (strings, content) |
| cover page | main.tex:10 | `front.class-native` | `\coverpage`, no arguments, placed first in the body |
| scene heading (slug line) | main.tex:11, 18, 21 | `class.screenplay` | `\slug{INT.}{COMMUNITY RADIO STATION -- NIGHT}` and the `EXT.` form: scene type and location text as two strings |
| dialogue block | main.tex:12-14, 15-17, 22-24, 25-27 | `class.screenplay` | `dialogue` environment, `{MARA}` or `{JON}` as speaker, optional `[quietly]` parenthetical; the speech is content |
| action paragraph | main.tex:19-20 | `class.screenplay` | plain paragraph text between slug lines and dialogue |

No component line fits the slug, dialogue and action constructs by name: they are the class's own vocabulary, which the rubric records under "Class setting" and which the lib's class way carries, as in the other class-carried zips. The `dialogue` package (`quote.dialogue`, `\speak{name}`) is a different package and is not what the sample loads.

## Bespoke code
none. The sample has no `\newcommand`, `\def`, environment, counter, conditional or `\usepackage` (main.tex:1-28 read in full).

## Content-opaque
none

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
