yes

# 0294-amnestyreport-human-rights-report: Amnestyreport Human Rights Report

- Unverified: read from the source, not compiled.
- Source: Source/0294-amnestyreport-human-rights-report/ (origin: https://latextemplates.com/downloads/amnestyreport.zip; licence: LPPL-1.3)
- Kind: report
- Lib: v3 (the snapshot read)
- Engine: needs XeLaTeX or LuaLaTeX (not established: the class source is not in the zip and was not read; inferred only from the `freefonts` option, which swaps the brand font files, README.md:11)
- Look carried by: class (the zip adds only content and two class options; main.tex:1 and main.tex:8-14)
- Class origin: tex-distribution-unbundled (README.md:7 says the class is supplied by TeX Live; ctan.org/pkg/amnestyreport read once: class `amnestyreport` v1.2, Boris Veytsman, LPPL 1.3, in TeX Live and MiKTeX)
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present (the zip holds only README.md and main.tex; the class `amnestyreport.cls` is not bundled and was not read)

## Verdict
The zip is one 115-line sample on the published CTAN/TeX Live class `amnestyreport`. It defines no macro, environment, counter, class or style of its own, and draws nothing (the `nologo` option removes the class's logo, README.md:11). The preamble loads four published packages (booktabs, tabularx, enumitem, xcolor) and the body uses only kernel quote, list, table and caption constructs plus the class's own title-page commands, so every component has a lib way and nothing is bespoke or ART. The class's own look (cover, running heads, heading style, fonts, page layout) is not visible in this zip and is recorded as class-supplied, not read.

## Blockers
none

## Class setting
- Class: `class.amnestyreport` options: `freefonts` (use free fonts instead of Amnesty's brand fonts), `nologo` (omit the logo) (main.tex:1; README.md:11)
- Class-native vocabulary used: `\subtitle` (main.tex:9), `\reportyear` (main.tex:11), `\reportmonth` (main.tex:12), `\reportindex` (main.tex:13), `\blurb` (main.tex:14), `\frontmatter` (main.tex:17), `\mainmatter` (main.tex:21), plus `\title` `\author` `\maketitle` (main.tex:8, 10, 18) and `\tableofcontents` (main.tex:19) with the class's own look; numbered `\section` and starred `\section*` carry the report headings (main.tex:22, 35). No class-specific environment is used.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.amnestyreport` | freefonts, nologo |
| fonts (brand fonts swapped for free ones) | main.tex:1; README.md:11 | `class.amnestyreport` | the `freefonts` class option is the parameter; no separate font way is loaded by the sample |
| page geometry, running heads, page numbers | none in the sample; supplied inside the class (source not read) | `class.amnestyreport` | class defaults; no `\geometry`, `\pagestyle` or `\pagenumbering` call in main.tex (grep found none) |
| title block (title, subtitle, author, year, month, index, blurb) | main.tex:8-14, 18 | `front.maketitle` | `\title{}` `\author{}` `\maketitle` (kernel names) |
| title block, class-only fields | main.tex:9, 11-14 | `front.class-native` | `\subtitle`, `\reportyear`, `\reportmonth`, `\reportindex`, `\blurb`: one string each |
| front and main matter switches | main.tex:17, 21 | `front.class-native` | `\frontmatter` `\mainmatter` (class provides them; numbering effect not read) |
| contents | main.tex:19 | `toc.kernel` | `\tableofcontents`; look set by the class (not read) |
| headings | main.tex:22, 35, 45, 67-68, 75, 81, 87, 98, 110 | `head.kernel` | `\section{...}` and `\section*{...}` |
| heading look and numbering | inside the class (source not read) | `head.class-native` | class defaults, no option set in main.tex |
| quote | main.tex:29-33 | `quote.kernel` | `quote` environment |
| enumerated list | main.tex:36-43 | `list.kernel` | `enumerate` |
| enumerated list options | main.tex:5, 36 | `list.enumitem` | `leftmargin=*,itemsep=4pt` |
| description list | main.tex:89-96 | `list.kernel` | `description` |
| description list options | main.tex:89 | `list.enumitem` | `leftmargin=2.8cm,style=nextline` |
| table float and caption | main.tex:52-54 | `cap.kernel` | `table[ht]`, `\caption{...}` (above the table); caption look set by the class (not read) |
| table centring | main.tex:53 | `sp.ragged` | `\centering` |
| table body | main.tex:4, 55-64, 100-108 | `tbl.tabularx` | `tabularx` with `{0.9\textwidth}{@{}l r X@{}}` and `{\textwidth}{@{}l X X@{}}` |
| table rules | main.tex:3, 56-58, 63, 101-103, 107 | `tbl.booktabs` | `\toprule` `\midrule` `\bottomrule` |
| colour package | main.tex:6 | `color.xcolor` | loaded with no options; no `\color` or `\definecolor` call in main.tex (grep found none) |
| inline code font | main.tex:112 | `mark.kernel` | `\texttt{...}` |

## Bespoke code
none (main.tex has no `\newcommand`, `\def`, `\newenvironment` or counter; the zip holds no `.cls` or `.sty`)

## Content-opaque
none

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- The class source (`amnestyreport.cls`) is a TeX Live class, not in the zip. Its own packages, fonts and engine requirement are therefore not read. If it loads `fontspec` it is XeLaTeX or LuaLaTeX only; that does not make the answer `no` (rubric: engine is recorded, not a blocker). Nothing was found that suggests an unconditional external tool (minted, shell escape), but that too is unread.
- The brand fonts and logo are excluded by the two class options, so the sample needs no fonts or images the zip does not ship (README.md:11-12).
