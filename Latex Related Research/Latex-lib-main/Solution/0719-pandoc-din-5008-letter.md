yes

# 0719-pandoc-din-5008-letter: Pandoc DIN 5008 Letter

- Unverified: read from the source, not compiled.
- Source: Source/0719-pandoc-din-5008-letter/ (origin: https://latextemplates.com/downloads/pandoc-din5008-letter.zip; licence: CC-BY-SA-4.0)
- Kind: letter
- Lib: v5
- Engine: pdfLaTeX-compatible (T1 + utf8 inputenc, lmodern; README.md:20 builds with `pdflatex main`)
- Look carried by: mixed (the published class scrlttr2 supplies the letter layout; main.tex:15-40 sets its fonts, colour, letterhead, reference block and foot through `\setkomafont` and `\setkomavar`)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
A 68-line `main.tex` on the published KOMA-Script class `scrlttr2`. The zip holds no `.cls`, `.sty` or other local file besides `README.md` and `ATTRIBUTION.txt`, and the sample defines no macro of its own (grep for `\newcommand`, `\def`, `\let`, `\newenvironment`, `\newcounter`, `\newif`, `\LoadLetterOption`, `\RequirePackage`, `\input` over `main.tex` found nothing). Every construct is a class option, a `\setkomavar` or `\setkomafont` call, or a kernel or published package command, so each maps to a lib way and nothing is bespoke. The Pandoc name does not make it EXTERNAL: `README.md:8-9` says this catalogue version is a directly compilable `main.tex` that does not require Pandoc, and the upstream Pandoc `letter.latex` is not in the zip. There is no drawing and no artwork.

## Blockers
none

## Class setting
- Class: `class.scrlttr2` options: `paper=a4`, `fontsize=11pt`, `parskip=half`, `foldmarks=off`, `enlargefirstpage=true` (main.tex:3-4). The class is KOMA-Script, shipped with the TeX distribution and not bundled; its source was not read. The sample makes no `\LoadLetterOption` or `\KOMAoptions` call (grep), so the letter page layout is whatever the class gives for these options; the "DIN 5008" in the title is not backed by a letter-option file in the sample.
- Class-native vocabulary used: environment `letter` with the recipient block as its argument (main.tex:43-47, 67), `\opening` (48), `\closing` (64), `\encl` (65), `\cc` (66), `\setkomavar` of the variables `fromname` `fromaddress` `fromphone` `fromemail` `fromurl` `place` `date` `yourref` `myref` `customer` `subject` `signature` `firsthead` `location` `firstfoot` (17-40), `\usekomavar` (36-38), `\setkomafont` of the elements `fromname` and `subject` (15-16).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:3-4 | `class.scrlttr2` | options paper=a4, fontsize=11pt, parskip=half, foldmarks=off, enlargefirstpage=true |
| paper and base font size | main.tex:3 | `page.class-options` | paper=a4, fontsize=11pt (class options) |
| paragraph spacing, fold marks, first-page height | main.tex:3-4 | `class.scrlttr2` | parskip=half, foldmarks=off, enlargefirstpage=true are options of the class (a KOMA option, not the `parskip` package) |
| encodings | main.tex:6-7 | `font.fontenc-t1` | fontenc T1; inputenc utf8 |
| language | main.tex:8 | `lang.babel` | ngerman |
| text font | main.tex:9 | `font.lmodern` | `\usepackage{lmodern}`, no options |
| micro-typography | main.tex:10 | `sp.microtype` | default options |
| colour | main.tex:11, 14 | `color.xcolor` | `\definecolor{blueink}{HTML}{164E63}` |
| link look and mail link | main.tex:12, 20 | `meta.hyperref` | option hidelinks; `\href{mailto:..}{..}` inside the fromemail variable |
| letter font elements | main.tex:15-16 | `head.koma-fonts`, `mark.kernel` | `\setkomafont{fromname}{\sffamily\bfseries}`, `\setkomafont{subject}{\sffamily\bfseries}` (the element names are the parameter; the switches are kernel font commands) |
| sender fields | main.tex:17-21 | `ltr.opening`, `sp.manual-space` | `\setkomavar` fromname, fromaddress (one `\\` break at :18), fromphone, fromemail, fromurl |
| place, date, subject, signature | main.tex:22-23, 27-28 | `ltr.opening`, `sp.manual-space` | `\setkomavar` place, date, subject, signature (`\\` break at :28) |
| reference fields | main.tex:24-26 | `ltr.opening` | `\setkomavar` yourref, myref, customer |
| letterhead (first-page head) | main.tex:29-33 | `ltr.opening`, `sp.ragged`, `font.size-commands`, `mark.kernel`, `color.xcolor` | `\setkomavar{firsthead}`: `flushright` environment, `\color{blueink}\sffamily\bfseries\Large`, `\par`, `\small\color{blueink}` |
| reference block (location field) | main.tex:34-38 | `ltr.opening`, `sp.ragged`, `font.size-commands`, `color.xcolor`, `sp.manual-space` | `\setkomavar{location}`: `\raggedleft\small`, `\textcolor{blueink}{..}` labels, `\usekomavar{yourref|myref|customer}`, `\\` breaks |
| first-page foot | main.tex:39-40 | `hf.class-native`, `sp.ragged`, `font.size-commands`, `color.xcolor`, `sp.manual-space` | `\setkomavar{firstfoot}`: `\centering\footnotesize\color{blueink}`, text, `\enskip|\enskip` |
| recipient block and letter wrapper | main.tex:43-47, 67 | `ltr.opening`, `sp.manual-space` | `\begin{letter}{name\\ organisation\\ street\\ town}` ... `\end{letter}` |
| salutation and closing | main.tex:48, 64 | `ltr.opening` | `\opening{Dear Alex Morgan,}`, `\closing{Yours sincerely,}` (the signature text is the signature variable at :28) |
| enclosure and copy lines | main.tex:65-66 | `ltr.opening` | `\encl{..}`, `\cc{..}` |

Not present in the sample: headings, lists, quotes, notes, maths, theorems, floats, tables, captions, code, boxes, bibliography, index, cross-references, header or footer on later pages, background. The body (main.tex:50-62) is three plain paragraphs, content.

## Bespoke code
none (no `\newcommand`, `\def`, `\let`, environment, counter or conditional in main.tex; no zip-local class or style).

## Content-opaque
none

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
