yes

# 0660-bewerbung-application-set: Bewerbung Application Set (German cover letter and CV)

- Unverified: read from the source, not compiled.
- Source: Source/0660-bewerbung-application-set/ (origin: https://latextemplates.com/downloads/bewerbung-application-set.zip; licence: LPPL-1.3 per the manifest, and README.md:20-23 gives LPPL-1.3, (c) Andre Hilbig; CTAN lists the package under LPPL 1.3)
- Kind: letter (a German job-application set: cover letter `anschreiben`, then CV `lebenslauf`)
- Lib: v5
- Engine: pdfLaTeX-compatible (the sample loads `inputenc` utf8 and `fontenc` T1, main.tex:14-15; the class source was not read and the CTAN page names no engine requirement)
- Look carried by: class (the zip holds no class or style file; the look of letter and CV is the published class `bewerbung`, which the zip does not bundle; the zip adds two class options, three colour definitions and data files)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
`yes`. The zip is four files: `main.tex`, `config.inc`, `anschrift.csv` and a README. It holds no `.cls`, `.sty` or macro definition. The whole look is the published class `bewerbung` (CTAN package page read: André Hilbig, LPPL 1.3, v1.3 of 2022-01-17, in TeX Live and MiKTeX), so it is one class way, and the zip adds options, `\definecolor` lines, a preamble of three published packages, and data for the class's own commands. Caveat: the class source is not in the zip and was not read, so which page geometry, fonts, running heads and letter layout it sets inside is not itemised; the rubric counts an unbundled published class as one way.

## Blockers
none

## Class setting
- Class: `class.bewerbung` options: `lebenslaufColor=light-gray`, `idPlain` (main.tex:10-13). Source not read (not bundled; ships with the TeX distribution, README.md:15-18; CTAN page https://ctan.org/pkg/bewerbung read).
- Class-native vocabulary used:
  - environment `anschreiben` (cover-letter body, main.tex:26-39) and environment `lebenslauf[none][]` (CV, main.tex:41-63; two optional arguments, the values `none` and empty);
  - `\ID{1}` (main.tex:23, selects a row of `anschrift.csv`);
  - `\maketitle` and `\makePerson` inside `lebenslauf` (main.tex:42-43);
  - `\cventry` with six arguments (main.tex:46-47, 50-51), `\cvlistitem` with one (main.tex:54-55, 58), `\cvlanguage` with three (main.tex:61-62);
  - personal-data macros `\Vorname` `\Name` `\Street` `\Plz` `\Stadt` `\Tel` `\Sta` `\GebDatum` `\MeinBeruf` (config.inc:3-11);
  - colour names `light-gray`, `titlecolor`, `addresscolor` that the preamble defines (main.tex:18-20); that the class reads them is inferred from the sample, not read in the class.
- The meaning of each `\cventry` argument, and the role of `idPlain`, come from the comment at main.tex:22 and the argument counts only; the class was not read, so they are not confirmed.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:10-13 | `class.bewerbung` | options `lebenslaufColor=light-gray`, `idPlain` |
| input and font encoding | main.tex:14-15 | `font.fontenc-t1` | `\usepackage[utf8]{inputenc}`, `\usepackage[T1]{fontenc}` |
| language | main.tex:16 | `lang.babel` | `\usepackage[ngerman]{babel}` |
| colours | main.tex:18-20 | `color.xcolor` | `\definecolor{light-gray}{gray}{0.6}`, `\definecolor{titlecolor}{gray}{0.62}`, `\definecolor{addresscolor}{gray}{0.45}` (the same `\definecolor` call exists in `color`; which package the class loads is in the unread class) |
| cover letter (letter body, recipient block and letterhead from data) | main.tex:23, main.tex:26-39, anschrift.csv:1-2 | `ltr.opening` | class-native: `anschreiben` environment holding three paragraphs of text, recipient fields from `anschrift.csv` selected by `\ID{1}`; the letterhead and recipient layout are set inside the class (unread) |
| sender data (name, address, phone, nationality, birth date, profession) | config.inc:3-11, main.tex:5-9 | `front.class-native` | nine data macros, strings only; the comment at main.tex:5-9 says the class reads `config.inc` and `anschrift.csv` itself, which cannot be checked without the class source |
| CV title block | main.tex:42-43 | `front.class-native` | `\maketitle` and `\makePerson` with no arguments, inside `lebenslauf[none][]` |
| CV section headings | main.tex:45, 49, 53, 57, 60 | `head.class-native` | `\section{...}` x5 inside `lebenslauf`; the look follows the option `lebenslaufColor=light-gray` and the colour names above |
| CV entries (work, study) | main.tex:46-47, 50-51 | `cv.entries` | `\cventry` x4, six brace arguments each (dates, title, employer, place, end date, description) |
| CV list items (skills, licence) | main.tex:54-55, 58 | `cv.entries` | `\cvlistitem` x3, one argument each |
| CV language rows | main.tex:61-62 | `cv.entries` | `\cvlanguage` x2, three arguments each (language, level, empty comment) |

## Bespoke code
none. The zip defines no macro, environment, counter or class. Every control sequence the body uses (`anschreiben`, `lebenslauf`, `\cventry`, `\cvlistitem`, `\cvlanguage`, `\makePerson`, `\ID`, the nine data macros) belongs to the published class and is not defined in the zip.

## Content-opaque
none. `config.inc` (config.inc:3-11) and `anschrift.csv` (anschrift.csv:1-2) are placeholder personal and recipient data for the class's own commands, read by TeX, so an emitter writes them as ordinary data files. Observation, not a blocker: main.tex:22 says `idPlain` matches on the KW column while `anschrift.csv:2` has ID=1 and KW=9; the class is not read, so this is not confirmed and the data is content.

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
