yes

# 0924-scrlttr2copy: scrlttr2copy (copy.lco, KOMA-Script letter copies)

- Unverified: read from the source, not compiled.
- Source: Source/0924-scrlttr2copy/ (origin: https://mirrors.ctan.org/macros/latex/contrib/scrlttr2copy.zip; licence: lppl1.3)
- Kind: letter
- Lib: v6
- Engine: pdfLaTeX-compatible (the file loads only `xcolor` and `graphicx` and uses kernel hooks, no `fontspec`; its own check wants a LaTeX format of 2020/10/01 or newer, copy.lco:16-24; the CTAN page names no engine)
- Look carried by: mixed (the class `scrlttr2` sets the whole letter look; `copy.lco`, a CTAN-published letter-class-option file shipped in the zip, adds the page copies; the sample preamble only sets class options and KOMA variables)
- Class origin: tex-distribution-unbundled
- Main file: letter-copy-test.tex (other samples: none; letter-copy-test.pdf is the author's shipped output, not read)
- Read: main yes, zip-local classes and styles all (the only local file is copy.lco, 89 lines, read in full; the class `scrlttr2` is not in the zip and its source was not read)

## Verdict
The sample is a two-letter KOMA-Script `scrlttr2` document with class options, three `\setkomavar` fields and `\blindtext` filler; it defines no macro of its own (letter-copy-test.tex:1-58). The one non-kernel construct is the class option `copy`, supplied by `copy.lco`, which is the CTAN package `scrlttr2copy` itself (Rolf Niepraschk, LPPL 1.3, v0.3a, in TeX Live and MiKTeX, per ctan.org/pkg/scrlttr2copy). It passes W1 to W4 as a letter add-on way, proposed as `NEW:ltr.copy-lco`, so its shipout-hook code is published code and not bespoke. Answer `yes`, with the caveat in Notes below.

## Blockers
none

## Class setting
- Class: `class.scrlttr2` options: `copy`, `ngerman`, `fontsize=11pt`, `twoside=true`, `enlargefirstpage` (letter-copy-test.tex:2-9; `english` is commented out at :5). Source of `scrlttr2` not read (ships with KOMA-Script).
- Class-native vocabulary used: `\setkomavar{fromname}` `{fromaddress}` `{date}` `{subject}` (letter-copy-test.tex:14-17, :26, :42); `letter` environment with the address as argument (:28-32, :44-48); `\opening` (:34, :50); `\closing` (:38, :54); `\setkomavar*{copy}{...}` is present only as a comment (:19). Inside the lco: `\newkomavar[..]{copy}`, `\usekomavar*{copy}`, `\defcaptionname`, `\AtEndLetter` (copy.lco:28, :45, :77, :80-87).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | letter-copy-test.tex:2-9 | `class.scrlttr2` | options `copy`, `ngerman`, `fontsize=11pt`, `twoside=true`, `enlargefirstpage` |
| font size and two-sided layout | letter-copy-test.tex:6-7 | `page.class-options` | `fontsize=11pt`, `twoside=true`; paper size not set (class default) |
| first-page height | letter-copy-test.tex:8 | `page.class-options` | KOMA class option `enlargefirstpage` (a class option, not the kernel `\enlargethispage`) |
| language | letter-copy-test.tex:4, :11 | `lang.babel` | `\usepackage{babel}` with no options; the language `ngerman` arrives as a class option |
| input encoding | letter-copy-test.tex:10 | `font.fontenc-t1` | `\usepackage[utf8]{inputenc}` |
| sender letterhead | letter-copy-test.tex:14-16 | `ltr.opening` | `\setkomavar{fromname}{Peter Silie}`, `\setkomavar{fromaddress}{...\\...}` |
| letter date | letter-copy-test.tex:17 | `ltr.opening` | `\setkomavar{date}{26.\,5.\,2015}` |
| subject line | letter-copy-test.tex:26, :42 | `ltr.opening` | `\setkomavar{subject}{...}` set before each `letter` |
| recipient, salutation, closing | letter-copy-test.tex:28-40, :44-56 | `ltr.opening` | `\begin{letter}{address}`, `\opening{..}`, `\closing{..}`, two letters in one document |
| body filler text | letter-copy-test.tex:12, :36, :52 | `draft.todo` | package `blindtext`, `\blindtext[4]` and `\blindtext[22]` (filler content; same type as `lipsum`) |
| page copies of every letter | letter-copy-test.tex:3; copy.lco:28-40, :49-75 | `NEW:ltr.copy-lco` | class option `copy` (a boolean); after the document each letter's saved pages are shipped out a second time |
| copy marker text | copy.lco:42-47, :77-87; letter-copy-test.tex:19 | `NEW:ltr.copy-lco` | label string of the komavar `copy`: default `\copyname` = "Kopie" for `ngerman` (copy.lco:82-83); override `\setkomavar*{copy}{Zweitschrift}` only in a comment (:19) |
| packages loaded by the lco | copy.lco:26 | `color.xcolor`, `fig.graphicx` | `\RequirePackage{xcolor,graphicx}` for `lightgray`, `\resizebox`, `\rotatebox`; loaded by the way itself, no emitter line |

Not components: `\listfiles` (letter-copy-test.tex:1) only writes a file list to the log. Marker look (45 degree rotation, `lightgray`, bold sans, scaled to `\textwidth`, page centre) is fixed in copy.lco:43-46. The empty page added when the page count is odd under `twoside` is fixed in copy.lco:51-54; the sample sets `twoside=true` (:7), so that branch is live.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| sample macros, environments, counters | letter-copy-test.tex:1-58 | none defined | the sample has no `\newcommand`, `\def`, `\newenvironment` or counter |
| `copy.lco` (shipout hooks, saved page boxes, `\LetterCopyMarker`) | copy.lco:28-75 | not bespoke: published | the file is the CTAN package `scrlttr2copy` (origin url in the manifest; ctan.org/pkg/scrlttr2copy read: LPPL 1.3, v0.3a, TeX Live and MiKTeX), so W1 holds; its code is internal to `NEW:ltr.copy-lco`; I do not claim it reduces to other lib ways (page duplication has no other lib way) |
| `\LetterCopyMarker` marker drawn with `\put` and `\makebox(0,0)` | copy.lco:42-47 | not ART | a watermark by function, inside the published way; not drawn by the sample |
| `\LetterCopyMarker` redefinition | letter-copy-test.tex:21-22 | not used | comment only; if a document did redefine it, that extends the way's code and would be a `BESPOKE/preamble` item |

## Content-opaque
none

## Lib changes
- New ways proposed: `NEW:ltr.copy-lco`: package `scrlttr2copy`, file `copy.lco` (CTAN, LPPL 1.3, Rolf Niepraschk, v0.3a, TeX Live and MiKTeX), pdf engine. A letter-class-option way for KOMA `scrlttr2`: the class option `copy` makes every letter's pages print again after the document, with a gray diagonal marker taken from `\usekomavar*{copy}`; no body wrapper, the marker label is set with `\setkomavar*{copy}{text}` or comes from the language. W1: released on CTAN, with public documentation (README.md:1-8, CTAN page). W2: chosen by one boolean class option and one string, the look being fixed, and redefining `\LetterCopyMarker` (a code extension, letter-copy-test.tex:21-22) is outside the way. W3: serves any `scrlttr2` letter, not one document. W4: printed as an option in the `\documentclass` line plus an optional `\setkomavar*` line. Not `ltr.opening` (letter fields and commands), not `bg.watermark` (a watermark on pages, it cannot duplicate pages), not `ltr.envelope-letter` (adds an envelope page). Considered folding it into `class.scrlttr2` as a class option; kept apart because it ships its own code and CTAN package.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- Caveat for readers using a stricter reading: the `yes` rests on treating a CTAN-published letter-class-option file as a published way (W1). If a reviewer holds that a third-party `.lco` is class-internal code, then the result changes to `UNMAPPED/class` for the page-copy component; nothing in the sample itself blocks.
- README.md (1-16) holds only a description and the licence; no text addressed to an AI.
- copy.lco depends on kernel hooks and macros `\AddToHook`, `\ShipoutBox`, `\ReadonlyShipoutCounter` (copy.lco:40, :37, :51); I did not check them against a kernel release beyond the file's own 2020/10/01 test (:16-24).
- Missing assets: none; `babel`, `blindtext`, `scrlttr2` and `scrlttr2copy` are distribution packages.
