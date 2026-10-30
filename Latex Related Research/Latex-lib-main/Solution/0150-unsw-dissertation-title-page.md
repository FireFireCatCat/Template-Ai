yes

# 0150-unsw-dissertation-title-page: UNSW Dissertation Title Page

- Unverified: read from the source, not compiled.
- Source: Source/0150-unsw-dissertation-title-page/ (origin: https://latextemplates.com/downloads/unswcover-dissertation-title-page.zip; licence: LPPL-1.3, which is the licence of `unswcover` per main.tex:9 and README.md:71; the starter file itself "carries no additional restrictions", README.md:76-77)
- Kind: thesis
- Lib: v3
- Engine: pdfLaTeX-compatible (README.md:21 builds with `pdflatex`; `fontenc` T1 at main.tex:24; the `unswcover` source was not read, so this rests on the README)
- Look carried by: class (kernel `report` plus the published `unswcover` package, class-like per the lib v3 change log; the zip adds only option strings, `\title`/`\author`/`\date`, and a stand-in for a missing logo image)
- Class origin: tex-distribution-unbundled (`report` is LaTeX base; `unswcover` is on CTAN and in TeX Live, and is deliberately not bundled, main.tex:3-6, README.md:11-17)
- Main file: main.tex (other samples: none; README.md is documentation only)
- Read: main yes, zip-local classes and styles none present (the zip has only `main.tex` and `README.md`; `unswcover.sty` is not in it)

## Verdict
Yes. The whole look is the kernel `report` class plus the published `unswcover` package, which prints the title page and the three UNSW statement pages from `\unswschool`, `\unswdegree`, `\title`, `\author` and `\date`. The only bespoke code is a `\crestplaceholder` macro and a scoped `\renewcommand{\includegraphics}` that stand in for a missing trademarked logo image. Both are compositions of kernel boxes and font switches (reducible), and the better reduction is to ship the crest as an asset. There is no artwork drawn in TeX and no external tool. Caveat: `unswcover.sty` was not available to read, so what it sets inside the four front-matter pages is known only from the sample's comments and the README.

## Blockers
none

## Class setting
- Class: `class.report` options: `11pt`, `a4paper`, `oneside` (main.tex:22)
- Class-native vocabulary used: `\chapter` (main.tex:80, 85), `\tableofcontents` (main.tex:78), standard `\title` `\author` `\date` (main.tex:44-46)
- Package treated as a class-like way: `class.unswcover` (the lib v3 change log files a one-institution cover or front-matter package under a class way), loaded with no options (main.tex:30). Source not read: not in the zip, published on CTAN (https://ctan.org/pkg/unswcover, read once: version 1.0, Olivier Mehani, LPPL-1.3, in TeX Live and MiKTeX, follows the 2011 UNSW Graduate Research School guidelines).
- `class.unswcover` native vocabulary: preamble `\unswschool{...}` (main.tex:36), `\unswdegree{...}` (main.tex:37), `\unswcotutelle{...}` (commented out, main.tex:38), `\unswdissertationsheet{file.pdf}` (commented out, main.tex:74); body `\makeunswfrontmatter` (main.tex:69), which the comments say emits four pages: title page, then Originality, Copyright and Authenticity statements, each with a signature and date block (main.tex:57-59). `\makeunswphdtitlepage` is named in a comment (main.tex:40) and not called.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:22 | `class.report` | `11pt,a4paper,oneside` |
| page size and base font size | main.tex:22 | `page.class-options` | `a4paper`, `11pt`, `oneside`; no margin change in the sample (any geometry the package sets is unread) |
| font encoding | main.tex:24 | `font.fontenc-t1` | `fontenc` option `T1`; no text-face package, so the class default face |
| graphics loading | main.tex:25-28 | `fig.graphicx` | `\usepackage{graphicx}`, no options; loaded for the placeholder, and the comment says `unswcover` requires it too |
| title page and statement pages | main.tex:30, 57-59, 67-70 | `class.unswcover` | `\usepackage{unswcover}`, then body `\makeunswfrontmatter`; four pages per the comment; statement wording fixed in the package and dated 2013 (README.md:64-67) |
| school, degree, cotutelle strings | main.tex:36-38; README.md:53-56 | `class.unswcover` | `\unswschool{School of Computer Science and Engineering\\}` (string ends with `\\`), `\unswdegree{Doctor of Philosophy}`, `\unswcotutelle` off |
| title, author, date inputs | main.tex:40-46; README.md:56-58 | `front.maketitle` | `\title`, `\author`, `\date{March 2026}`; `\maketitle` is not called, the package reads them; `\date` prints on the title page and under each signature block |
| dissertation sheet binding | main.tex:72-76; README.md:60-62 | `class.unswcover` | optional `\unswdissertationsheet{dissertation-sheet.pdf}`, off in the sample; the comment says the package `\includepdf`s it (inside the package, not an emitter-written way) |
| table of contents | main.tex:78 | `toc.kernel` | `\tableofcontents`, `report` defaults; README.md:24-25 says two passes |
| chapter headings | main.tex:80, 85 | `head.kernel` | `\chapter{Introduction}`, `\chapter{Background}` with `report` defaults, no restyling |
| placeholder frame | main.tex:51 | `box.fancybox` | `\framebox[3cm]{...}` |
| placeholder inner box | main.tex:51 | `box.minipage` | `\parbox[c][3cm][c]{2.6cm}{...}` |
| placeholder text alignment | main.tex:51 | `sp.ragged` | `\centering` |
| placeholder face | main.tex:51 | `mark.kernel` | `\sffamily` (kernel font-switch) |
| placeholder size | main.tex:51 | `font.size-commands` | `\scriptsize` |
| placeholder line breaks | main.tex:51-52 | `sp.manual-space` | `YOUR\\INSTITUTION\\CREST` |

Not defined by the sample, so no row: header and footer, spacing, colour, background, language, PDF metadata, lists, quotes, notes, maths, theorems, floats, tables, captions, code, bibliography, index. Whatever `unswcover` sets for these on its own pages (page style, numbering, margins) is unread.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\crestplaceholder` macro | main.tex:50-53 (scope: preamble) | yes | A `\newcommand` alias for one boxed string: `box.fancybox` (`\framebox[3cm]`) around `box.minipage` (`\parbox[c][3cm][c]{2.6cm}`) holding `sp.ragged` (`\centering`), `mark.kernel` (`\sffamily`), `font.size-commands` (`\scriptsize`) and `sp.manual-space` (`\\`). No counters, conditionals or output code. |
| scoped `\renewcommand{\includegraphics}[2][]{\crestplaceholder}` inside `\begingroup ... \endgroup` around `\makeunswfrontmatter` | main.tex:67-70 (scope: body) | yes | One macro redefinition in a group, whose whole effect is to print the box above instead of the crest image the package requests (main.tex:12-17, 61-66). An emitter can write it as a body wrapper. The cleaner reduction is to omit it and ship `logo_unsw_short.pdf` beside the main file (`fig.graphicx`), which is what main.tex:61-63 and README.md:34-38 describe for the real crest. Without either, the package fails on the missing file (README.md:29-32). |

## Content-opaque
- UNSW crest image `logo_unsw_short`, included by the package at the end of the title page (main.tex:11-13, README.md:29-32). It is a missing asset: a university trademark that the zip does not ship and says it cannot (README.md:27-38, 72-74). The sample draws a 3 cm placeholder frame instead. This is an included image, not TeX-drawn artwork, so it is not `ART`.
- Chapter placeholder text (main.tex:81-83, 86).

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
