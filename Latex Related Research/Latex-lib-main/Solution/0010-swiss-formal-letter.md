yes

# 0010-swiss-formal-letter: Swiss Formal Letter (chletter class, French sample)

- Unverified: read from the source, not compiled.
- Source: Source/0010-swiss-formal-letter/ (origin: https://latextemplates.com/downloads/swiss-formal-letter.zip; licence: LPPL-1.3c)
- Kind: letter
- Lib: v1
- Engine: pdfLaTeX-compatible (`inputenc` utf8, `fontenc` T1 and `babel` at main.tex:11-13; no fontspec, no Lua; CTAN describes chletter as based on the standard LaTeX classes; the class source was not read)
- Look carried by: class (the published `chletter` class sets the sheet, the address window and the letter layout; main.tex adds only three standard packages, class options and the letter commands)
- Class origin: tex-distribution-unbundled (`chletter` is on CTAN, https://ctan.org/pkg/chletter, LPPL 1.3c; the zip ships no `.cls` or `.sty`)
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
The zip is a single 48-line `main.tex` and ships no class file. It calls the published CTAN class `chletter` and adds only package loads, class options and the standard letter commands. There is no zip-local macro, environment, counter or artwork, and nothing needs a tool outside TeX. An emitter can write `\documentclass[a4paper,10pt,foldmark,leftwin]{chletter}`, the three package lines and the letter block from published ways, so the answer is `yes`. The class source was not read, so what `foldmark` and `leftwin` do, and the class's full vocabulary, are unchecked (see Class setting).

## Blockers
none

## Class setting
- Class: `class.chletter` options: `a4paper`, `10pt`, `foldmark`, `leftwin` (main.tex:10)
- Class source: on CTAN as "Chletter, a class for typesetting letters to Swiss rules": fits Swiss C5 and C6/5 windowed envelopes, language-neutral, based on the standard LaTeX classes and compatible with the LaTeX `letter` class (one read of ctan.org/pkg/chletter, which names no options or commands). The class source was NOT read; it is not in the zip.
- Class-native vocabulary used: `\name`, `\signature`, `\location`, `\address`, `\telephone` (main.tex:15-22); `letter` environment with the recipient block as its argument (main.tex:25-28, 47); `\opening` (main.tex:30); `\closing` (main.tex:41-42); `\ps` (main.tex:44-45). These are the kernel `letter` class commands that chletter is described as compatible with; chletter's own definitions of them were not read.
- Unchecked option claims: `foldmark` and `leftwin` are described only by the sample's own comment (main.tex:3-9), which also mentions `\addresswidth` and `\titlehead`. The sample's code uses neither command, and the CTAN page names none of the four. They are treated as class options (parameters) whose effect is not verified here. The verdict does not depend on them: an emitter writes them as options either way.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:10 | `class.chletter` | options a4paper, 10pt, foldmark, leftwin |
| paper and base size | main.tex:10 | `page.class-options` | a4paper, 10pt (class options; no `geometry`, no `\setlength` in the sample) |
| address window side and fold mark | main.tex:10 (described main.tex:3-9) | `class.chletter` | class options leftwin, foldmark; effect lives in the class source, not read |
| input encoding and font encoding | main.tex:11-12 | `font.fontenc-t1` | inputenc=utf8, fontenc=T1 |
| language | main.tex:13 | `lang.babel` | main language french (also localises `\today` at main.tex:17) |
| sender block (letterhead) | main.tex:15-22 | `ltr.opening` | `\name`, `\signature`, `\location{Lausanne, le \today}`, `\address{...}`, `\telephone{...}` (kernel letter vocabulary; kernel `\today`, no `datetime` package) |
| line breaks inside address arguments | main.tex:18-21, 25-28 | `sp.manual-space` | `\\` between address lines in the `\address` and `letter` arguments |
| recipient block and letter wrapper | main.tex:25-28, 47 | `ltr.opening` | `\begin{letter}{recipient lines}` ... `\end{letter}` |
| salutation | main.tex:30 | `ltr.opening` | `\opening{Madame, Monsieur,}` |
| complimentary close | main.tex:41-42 | `ltr.opening` | `\closing{...}` placed after the body text |
| postscript | main.tex:44-45 | `ltr.opening` | `\ps{...}` (letter-class command; its argument handling is not verified) |
| body paragraphs | main.tex:32-39 | content | two plain paragraphs, no markup |

Not defined or used by the sample, so no row: headers and footers, spacing, fonts beyond the encoding, colour, headings, lists, quotes, maths, theorems, floats, tables, captions, code, boxes, bibliography, index, cross-references, hyperref. Any running head or fold-mark drawing that the class itself produces lies inside the unread class source.

## Bespoke code
none (main.tex:1-48 has no `\newcommand`, `\def`, environment, counter or conditional, and the zip has no `.cls`, `.sty` or `.def`)

## Content-opaque
none

## Lib changes
- New ways proposed: none. `class.chletter` is written plainly as a class way (rubric: a class way needs no proposal); the vocabulary to record in the lib's class section is under "Class setting" above.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- Nothing in the zip is addressed to an AI. The only prose is the sample's descriptive comment at main.tex:1-9, treated as data, not as evidence of what the published class does.
- Single-file zip: this is evidence about the class dimension (a published class carries the look), not about the component ways.
- The sample compiles only where `chletter` is installed (it is on CTAN); whether a given TeX distribution bundles it was not checked.
