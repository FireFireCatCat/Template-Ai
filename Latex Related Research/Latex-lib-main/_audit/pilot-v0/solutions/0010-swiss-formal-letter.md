yes

# 0010-swiss-formal-letter: Swiss Formal Letter (chletter)

- Unverified: read from the source, not compiled.
- Source: Source/0010-swiss-formal-letter/ (origin: https://latextemplates.com/downloads/swiss-formal-letter.zip; licence: LPPL-1.3c)
- Kind: letter
- Lib: v0
- Engine: pdfLaTeX-compatible (`inputenc` utf8 + `fontenc` T1 + `babel`, main.tex:11-13; nothing needs fontspec or Lua)
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
The zip is one 48-line file, `main.tex`, and nothing else. It loads the published CTAN class `chletter` (Boris Oriet, v2.0, LPPL 1.3c, shipped with TeX Live and MiKTeX) with four options, loads three published packages, and then uses only letter-class commands. It defines no macro, environment, counter or class of its own, and it draws no artwork. Every component maps to a lib way and an emitter could print the same preamble and body wrappers, so `yes`. The chletter source is not in the zip and was not read (see "Class setting"). The sample's own comment text about `foldmark`, `leftwin`, `\addresswidth` and `\titlehead` is unchecked (see "Caveats").

## Blockers
none

## Class setting
- Class: `class.chletter` options: `a4paper`, `10pt`, `foldmark`, `leftwin` (main.tex:10). This is a published class not bundled in the zip, so it is one way with its source not read. The CTAN page (https://ctan.org/pkg/chletter) describes it as a class for Swiss-rule letters that fit C5 and C6/5 window envelopes, based on the standard LaTeX classes and compatible with the kernel `letter` class, usable as a generic class, and used with the `chextras` package. `chextras` is not loaded here. The CTAN page lists no options or commands.
- Class-native vocabulary used: `\name`, `\signature`, `\location`, `\address`, `\telephone` (main.tex:15-22); `letter` environment with recipient argument (main.tex:25-47); `\opening` (main.tex:30); `\closing` (main.tex:41); `\ps` (main.tex:44). These are the kernel-letter names, which the CTAN page says chletter is compatible with. The class's own option names `foldmark` (crop mark at the window-envelope fold height) and `leftwin` (address window on the left) are known only from the sample comment (main.tex:5-9).
- Not used by the sample (so not recorded as vocabulary): `\addresswidth` and `\titlehead`, which the comment at main.tex:4-5 mentions. `\titlehead` is a KOMA command name; whether chletter has it is unknown.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:10 | `class.chletter` | options a4paper, 10pt, foldmark, leftwin |
| paper and base size | main.tex:10 | `page.class-options` | a4paper, 10pt (class options; no geometry package, no `\setlength`) |
| fold mark and address-window side | main.tex:5-10 | `class.chletter` | class options `foldmark`, `leftwin`; no further parameters; behaviour is the class's own |
| input encoding | main.tex:11 | `font.fontenc-t1` | `\usepackage[utf8]{inputenc}` |
| font encoding | main.tex:12 | `font.fontenc-t1` | `\usepackage[T1]{fontenc}`; no font family package is loaded, so the class's default fonts apply |
| language | main.tex:13 | `lang.babel` | main language `french` |
| sender block | main.tex:15-22 | `ltr.opening` | `\name`, `\signature`, `\address` (3 lines with `\\`), `\telephone`; strings only |
| place and date line | main.tex:17 | `ltr.opening` | `\location{Lausanne, le \today}`; `\today` is the kernel date command, printed in French by babel |
| letter environment and recipient address | main.tex:25-28, 47 | `ltr.opening` | `\begin{letter}{<4-line address with \\>}` ... `\end{letter}` |
| salutation | main.tex:30 | `ltr.opening` | `\opening{Madame, Monsieur,}` |
| body paragraphs | main.tex:32-39 | (content) | two plain paragraphs; no lists, floats, maths or notes |
| complimentary close | main.tex:41-42 | `ltr.opening` | `\closing{...}` after the body, as the letter class expects |
| postscript | main.tex:44-45 | `ltr.opening` | `\ps{P.S. ...}` |
| running header and footer, page numbers | not set in the sample | `class.chletter` | whatever the class does by default; nothing in the sample changes it |
| sectioning, lists, theorems, floats, tables, code, boxes, bibliography, index | not present | none | the sample uses none of them |

## Bespoke code
none. The zip holds no `.cls`, `.sty`, `.def`, `.cfg`, `.clo`, `\newcommand`, `\def`, environment or counter. Every command in main.tex belongs to the published class or to a published package.

## Content-opaque
none

## Caveats
- The chletter class source and documentation were not read: the class is not in this zip and ships with the TeX distribution. Per the rubric it is one way (`class.chletter`). Its vocabulary above is taken from the sample's usage and the CTAN page.
- The sample comment (main.tex:1-9) claims that `foldmark` prints a tick in the left margin about a third of the way down the page and that `leftwin` moves the address window to the left. These are claims in the zip's own text, treated as data and not checked against the class. If chletter 2.0 does not define either option, the emitted `\documentclass[...]` line is the same text and the recovery argument does not change, but the look would differ.
- The manifest records the zip as 1065 bytes with one file (_Manifest.tsv:11). It is a minimal stub sample, so this verdict covers the class-plus-options setting that the sample shows and not any wider chletter feature.
- No text addressed to an AI was found in the zip.

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
