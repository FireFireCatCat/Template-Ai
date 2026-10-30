yes

# 0570-scientific-thesis-cover: Cover page and affirmation for scientific works

- Unverified: read from the source, not compiled.
- Source: Source/0570-scientific-thesis-cover/ (origin: https://mirrors.ctan.org/macros/latex/contrib/scientific-thesis-cover.zip; licence: LPPL 1.3c, README.md:152-156)
- Kind: thesis
- Lib: v4
- Engine: pdfLaTeX-compatible (the package asks for UTF-8 `inputenc` under pdfLaTeX and has a LuaLaTeX branch, scientific-thesis-cover.sty:17-37; no `fontspec`)
- Look carried by: class (the published CTAN package `scientific-thesis-cover`, treated as a class-like one-institution cover package per the lib v3 ruling; demo.tex adds only option values and two calls)
- Class origin: ctan
- Main file: demo.tex (other samples: none)
- Read: main yes, zip-local classes and styles all (scientific-thesis-cover.sty, 433 lines, read in full; it is the CTAN release, not zip-local code)

## Verdict
The whole look comes from one published package, `scientific-thesis-cover` (CTAN, v4.1.0 of 2026-06-12, sty:3-4, confirmed on ctan.org/pkg/scientific-thesis-cover), loaded under `class.article`. The sample only passes option values (demo.tex:4-17) and calls `\Coverpage` and `\Affirmation` (demo.tex:19-20), so an emitter writes one `\usepackage[keys]{...}` line and two body calls. The package loads only published packages (`kvoptions`, `ifthen`, `iftex`, `ifluatex`, `csquotes`, conditionally `graphicx`), needs no outside tool, and the zip has no zip-local macro, no artwork and no content that no way can hold. The judgement call is the way id: a one-institution cover package is filed as a class-like way (lib v3 merged `front.unswcover` into `class.unswcover`); see Notes.

## Blockers
none

## Class setting
- Class: `class.article` options: `oneside` (demo.tex:1)
- Class-like package: `class.scientific-thesis-cover` options (demo.tex:4-17, declared sty:48-63): `title` `author` `type` (`bachelor` `master` `diplom` `study` `fachstudie` `projectinf` `prozessanalyse` or free text, sty:198-209) `institute` (`ipvs` `iaas` `fmi` `ims` `iste` `iti` `iris` `vis` `visus` `sec` `fac` or free text, sty:218-235) `number` `course` (`cs` `se` `mcl` `msv` `bis` `simtech` `medinf` or free text, sty:240-254) `examiner` `supervisor` `startdate` `enddate` `logo` `covertype` (declared, never read in the code) `language` (`german` default, `english`) `setPageNumberToOne` `setCoverPageNumberToMinusOne` (booleans). The sample sets `type=bachelor, institute=iaas, number=12345, course=se, language=english, logo={example-image-16x9.pdf}`.
- Class-native vocabulary used: `\Coverpage` (alias of `\Titelblatt`, sty:293 and 407) and `\Affirmation` (alias of `\Versicherung`, sty:409 and 433). Not used by the sample: `\Titelblatt`, `\Versicherung`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | demo.tex:1 | `class.article` | oneside; no paper size given (the cover assumes A4 widths, sty:315) |
| page layout by class option | demo.tex:1 | `page.class-options` | `oneside` |
| input encoding | demo.tex:2 | `font.fontenc-t1` | `\usepackage[utf8]{inputenc}` (the package warns without it, sty:17-37) |
| scaffolding package for the demo | demo.tex:3 | `draft.todo` | `mwe` (dummy-content package; supplies `example-image-16x9.pdf`); the package is the parameter |
| cover and declaration package | demo.tex:4-17 | `class.scientific-thesis-cover` | option keys above |
| cover page (title block) | demo.tex:19; sty:293-406 | `front.class-native` | `\Coverpage`; strings from `title` `author` `type` `number` `institute` `course` `examiner` `supervisor` `startdate` `enddate` |
| declaration page | demo.tex:20; sty:409-433 | `front.class-native` | `\Affirmation`; heading and text fixed per `language` (sty:118-130, 172-183) |
| label language | demo.tex:15; sty:76-195 | `front.class-native` | `language=english`; labels hand-set by `\gdef` in the package, no `babel` loaded |
| logo on the cover | demo.tex:16; sty:282-285, 335-344 | `fig.graphicx` | `\includegraphics[height=14mm]{<logo>}`, package loaded only when `logo` is set; image is an asset |
| cover page style | sty:300-301, 399 | `hf.pagestyle-kernel` | `\pagestyle{empty}`, `\thispagestyle{empty}` |
| cover font | sty:299 | `mark.kernel` | `\sffamily` |
| cover font sizes | sty:304, 361, 369, 373 | `font.size-commands` | 11pt on 13.6pt leading (normal), 12pt on 14pt (large), 17pt on 22pt (LARGE), set with `\@setsize` (a LaTeX 2.09 style call) |
| cover paragraph shape | sty:307 | `sp.lengths` | `\parskip=0pt`, `\parindent=0pt` |
| cover spacing of abbreviations | sty:306 | `sp.frenchspacing` | `\frenchspacing` |
| cover vertical layout | sty:330, 337-395 | `sp.manual-space` | `\vskip` with stretch and shrink, `\vfill`, `\vbox to Nmm` (20mm, 15mm, 55 or 70mm, 60mm, 45mm, 70mm); the box anchored at the sheet corner by `\hbox to 0pt{\kern..}` (sty:322) has no separate lib way and is part of the package |
| centred lines | sty:338, 347, 357, 361-375 | `sp.ragged` | `center` environment, `\centerline` |
| label and value rows | sty:276-279, 380-395 | `list.kernel` | kernel `\list{}` with `\labelwidth 45mm`, `\leftmargin 70mm`, `\rightmargin 20mm`, bold label (sty:274) |
| optional frame round the title box | sty:271-272, 357-358 | `box.fancybox` | `\fbox` with `\fboxsep=0pt`; inactive, `\@USCCover@umrandet` stays `\relax` and nothing in the package calls `\USCCover@umrandet` |
| two-column guard | sty:297-298, 404, 411-413, 431 | `cols.twocolumn-cmd` | `\onecolumn` before and `\twocolumn` after, only when the document was two-column; not exercised by the sample |
| page breaks around cover and declaration | sty:294, 400, 410, 429 | `pg.break` | `\cleardoublepage`, `\clearpage` |
| page number reset | sty:62-63, 295, 402 | `pgnum.pagenumbering` | `\setcounter{page}{-1}` and `{1}` under booleans (default false; not set by the sample) |
| declaration layout | sty:415-428 | `box.minipage` | `minipage[t]{10cm}` in `center`, `\vskip 5cm`, `\vskip 1cm`, `\vskip 4cm` |
| declaration heading | sty:418 | `mark.kernel` | `\textbf` (and `\textit` in the text, sty:126, 179) |
| declaration quotes | sty:14, 124, 177 | `lang.csquotes` | `csquotes` loaded unconditionally, `\enquote{...}` |
| declaration paragraph gaps | sty:123, 126, 176, 179 | `sp.manual-space` | `\par\vspace{0.5em}` |
| signature line | sty:424-426 | `sp.rule` | `\hrulefill`, then the place/date/signature label |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\Coverpage`, `\Affirmation`, label tables, `\USCCover@*` helpers | sty:188-433 | not bespoke here | published CTAN code of a published way; the sample would be rebuilt by calling them, not by copying them |
| `kvoptions` key processing, `\ifthenelse` matching of `type`, `institute`, `course` | sty:42-68, 198-254 | not bespoke here | package-internal; the emitter only sets option values |
| demo.tex macros | demo.tex:1-20 | none present | the sample defines no macro, environment or counter |

Release scripts `release.sh` and `release.bat` (pandoc, ctanify, pdflatex) build the CTAN archive, not the document: they are not a blocker (release.sh:9-26, release.bat:1-11).

## Content-opaque
none (the logo `example-image-16x9.pdf`, demo.tex:16, is an image asset that `mwe` supplies; ship it)

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
- Notes (not proposals): considered `front.uni-titlepage` (a different package, Markus Kohm's, not this one). Considered a component-level way for this cover package; filed as `class.scientific-thesis-cover` instead because the labels, institute addresses and the declaration text name the University of Stuttgart (sty:84, 124-126, 140, 216-234), the lib v3 rule for one-institution cover packages. If a reviewer rejects that filing, the verdict would turn on whether the cover's corner-anchored primitive box code (sty:322-397) reduces to lib ways; that code is not read as zip-local here because the package is published. Nothing in the zip addresses an AI reader.
