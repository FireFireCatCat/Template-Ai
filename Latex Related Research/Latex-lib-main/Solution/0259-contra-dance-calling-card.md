yes

# 0259-contra-dance-calling-card: Contra Dance Calling Card

- Unverified: read from the source, not compiled.
- Source: Source/0259-contra-dance-calling-card/ (origin: https://latextemplates.com/downloads/contracard.zip; licence: LPPL-1.3c per the manifest and the CTAN page for contracard)
- Kind: misc (a printed calling card for a contra dance; the manifest hint is `misc`)
- Lib: v3
- Engine: pdfLaTeX-compatible (README.md:9-11 builds with `pdflatex main`; the sample loads only `fontenc` and `inputenc`, main.tex:2-3)
- Look carried by: class (the whole card is the published class `contracard`; the zip adds only one class option, two parameter settings and the dance content)
- Class origin: tex-distribution-unbundled (README.md:6 says the class is supplied by TeX Live and not bundled; ctan.org/pkg/contracard lists it as a CTAN package and class, in TeX Live, LPPL 1.3c)
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
The look of the card is carried entirely by the published class `contracard`, which the zip does not bundle (README.md:6). The zip contributes `\documentclass[medium]{contracard}`, two settings of class-provided names (`\phrasevspace`, `\partdelimiter`), and body content written in the class's own vocabulary (main.tex:1, 6-14). It defines no macro, environment, counter, drawing or package of its own, and uses no tool outside TeX, so there is no bespoke code, no ART and no EXTERNAL blocker. The class source (`contracard.cls`) was not available and was not read; the verdict rests on the class being published and on the sample defining nothing itself.

## Blockers
none

## Class setting
- Class: `class.contracard` options: `medium` (main.tex:1). The meaning of the option is the class's own and was not read; no other option is given.
- Class-native vocabulary used: environment `contra{title}{author}{form}` (main.tex:5, 20; the three arguments are read as title, author and form from the sample's own hint at main.tex:18); length `\phrasevspace` (main.tex:6); macro `\partdelimiter` (main.tex:7); move commands `\walkaround*[who]{n}` (main.tex:8-9), `\balanceand*[who]` followed by `\swing{n}` (main.tex:11), `\ladieschain` (main.tex:13), `\starleft{n}` (main.tex:14); phrase boundary `\newdancephrase` (main.tex:10, 12). The starred forms, optional arguments and counts are the class's own arguments.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class and card size | main.tex:1 | `class.contracard` | option `medium` |
| input and font encoding | main.tex:2-3 | `font.fontenc-t1` | `fontenc` T1; `inputenc` utf8 |
| card heading (dance title, author, form) | main.tex:5 | `front.class-native` | `contra` environment arguments: `River Lantern`, `Your Name`, `Duple minor` (content strings) |
| vertical space between dance phrases | main.tex:6 | `class.contracard` | class length `\phrasevspace` set with `\setlength` to `0em` |
| separator between move parts | main.tex:7 | `class.contracard` | class macro `\partdelimiter` overridden with the string `:` |
| move lines | main.tex:8-9, 11, 13-14 | `class.contracard` | `\walkaround*[Neighbor]{8}`, `\walkaround*[Ladies]{8}`, `\balanceand*[Partner]\swing{12}`, `\ladieschain`, `\starleft{8}` (class-native commands; names and counts are content) |
| phrase boundary | main.tex:10, 12 | `class.contracard` | `\newdancephrase`, no arguments |
| push the note to the card foot | main.tex:15 | `sp.manual-space` | `\vspace*{\fill}` |
| right-aligned note | main.tex:16-19 | `sp.ragged` | kernel `flushright` environment around two text lines |
| line break inside the note | main.tex:17 | `sp.manual-space` | `\\` |
| page size, margins, fonts, colours, rules, card layout | not set in the zip | `class.contracard` | fixed by the class and its option (class source not read) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\renewcommand*{\partdelimiter}{:}` | main.tex:7 | yes | Overrides a name the class provides with a one-character string; it defines nothing new (it is `\renewcommand`, not `\newcommand`, so the name must already exist in the class). An emitter prints it as a parameter of `class.contracard`. |
| `\setlength{\phrasevspace}{0em}` | main.tex:6 | yes | Kernel `\setlength` on a length register the class provides (it would fail otherwise); a parameter of `class.contracard`. |

No zip-local `.cls`, `.sty`, `\newcommand`, `\def`, environment, counter or conditional exists (main.tex has 21 lines; the zip holds only README.md and main.tex).

## Content-opaque
none

## Lib changes
- New ways proposed: none. The class way `class.contracard` is written plainly, as the rubric asks; its native vocabulary is recorded above under "Class setting". The move commands have no lib line of their own because a published class's own vocabulary is recorded under its class way (the lib change log, v3).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- The README (README.md:6-8) says the dance title and instructions are original starter content. Nothing in README.md or main.tex is addressed to an AI.
- Considered: whether `\phrasevspace` should be filed under `sp.lengths`. It is the same kernel command but a class-defined length, so it is recorded as a class parameter and not as a second way.
- Not read: `contracard.cls` and its documentation (not in the zip; one ctan.org/pkg read gave only the summary, licence and TeX Live status). Which packages the class loads is therefore unknown; README.md:9-11 asks for a plain `pdflatex main` run, with no shell-escape flag or other tool, which gives no sign of an external step.
