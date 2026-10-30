yes

# 0137-uhh-assignment-essay: UHH Assignment Essay

- Unverified: read from the source, not compiled.
- Source: Source/0137-uhh-assignment-essay/ (origin: https://latextemplates.com/downloads/uhhassignment-essay.zip; licence: LPPL-1.3c)
- Kind: assignment
- Lib: v3 (the snapshot you read)
- Engine: pdfLaTeX-compatible (README.md:17 says `pdflatex main`; sample uses `fontenc` T1 and `inputenc` utf8, main.tex:5-6; the class's own source was not read)
- Look carried by: class (the zip holds only `main.tex` and `README.md`; the title block, task headings and page layout all come from the published class `uhhassignment`, with six generic `\usepackage` lines added in the preamble)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
yes. The zip is one 81-line `main.tex` that loads the published class `uhhassignment` (on CTAN, in TeX Live; README.md:12-13 says it is supplied by TeX Live and not bundled) and adds only published packages and kernel commands. It defines no macro, environment, counter or conditional of its own, draws nothing, and needs no tool outside TeX. The class source was not available and not read, so the layout it produces is taken on trust from the sample's calls and the README; a class that loaded an external-tool package unconditionally would change this, but nothing in the sample or README points that way.

## Blockers
none

## Class setting
- Class: `class.uhhassignment` options: `shorttitle`, `repeatauthor` (main.tex:3). Their exact effect is not known (class source not read); only the names are cited.
- Class-native vocabulary used: `\university[short]{long}` (main.tex:12), `\course[short]{long}` (main.tex:13), `\teacher{}` (main.tex:14), `\group{}` (main.tex:15), `\sheetno{}` (main.tex:16), `\author[short]{name \id{email}}` (main.tex:17), `\task{}` (main.tex:24, 40, 72), `\subtask{}` (main.tex:32, 64). Standard commands whose layout the class sets: `\title`, `\date`, `\maketitle` (main.tex:18, 19, 22). Named in README.md:9-10 but not used by the sample: the purple `\todo` marker.
- Source: ctan.org/pkg/uhhassignment (read once): by Kim Wittenburg, version 1.0, LPPL-1.3c, in TeX Live and MiKTeX, "solutions to homework assignments at the Universität Hamburg". The page lists no options or commands, so the vocabulary above comes from the sample and README only.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:3 | `class.uhhassignment` | options `shorttitle`, `repeatauthor`; no paper or size option given |
| page geometry, spacing, running heads | main.tex:3 (nothing set in the sample); README.md:5 ("compact hand-in layout") | `class.uhhassignment` | fixed inside the class, source not read; the sample sets no `geometry`, `fancyhdr` or length. Not given a separate way because no sample line selects a value |
| font encoding and input | main.tex:5-6 | `font.fontenc-t1` | `fontenc` option `T1`; `inputenc` option `utf8` |
| body font family | main.tex (no font package loaded) | none | the class default applies; `microtype` is the only typography package (below) |
| microtypography | main.tex:10 | `sp.microtype` | `microtype` with no options |
| math packages | main.tex:7 | `math.amsmath`, `math.amssymb` | `amsmath`, `amssymb`, no options |
| display math | main.tex:44-46, 53-58 | `math.amsmath` | unnumbered `\[ ... \]` displays; `\mathbb` comes from `amssymb`; the formula text is content |
| inline math | main.tex:41 | `math.amsmath` | `$...$`; content |
| title block metadata | main.tex:12-17 | `front.class-native` | university, course, teacher, group and sheet number each with a short form in `[...]` where given; author with `\id{}` e-mail |
| title, date, title page | main.tex:18-19, 22 | `front.maketitle` | `\title{\textsc{...}}`, `\date{18 September 2026}`, `\maketitle`; the printed layout is the class's (`front.class-native`) |
| title face | main.tex:18 | `mark.kernel` | `\textsc` inside `\title` |
| section headings | main.tex:24, 40, 72 | `head.class-native` | `\task{title}` numbered by the class; numbering and heading style are class-defined, source not read |
| sub-headings | main.tex:32, 64 | `head.class-native` | `\subtask{title}`; same note |
| lettered list | main.tex:65-70 | `list.enumitem`, `list.kernel` | `enumerate` with `label=\alph*)`, `leftmargin=2em`; `enumitem` loaded at main.tex:9 |
| table package | main.tex:8 | `tbl.booktabs` | `booktabs` loaded with no options; no table appears in the body (load-only) |
| paragraph text | main.tex:25-30 and following | content | prose |

Not present in the sample: figures, tables, captions, footnotes, cross-references, bibliography, index, code, boxes, theorems, abstract, contents list, language or hyperref setup. None of these is defined or called in `main.tex`, so none is mapped.

## Bespoke code
none. `grep` over `main.tex` for `newcommand`, `renewcommand`, `def`, `newenvironment`, `newcounter`, `newif`, `RequirePackage`, `input`, `include`, `directlua` and `tikz` returns nothing but the six `\usepackage` lines at main.tex:5-10. No zip-local `.cls`, `.sty`, `.def`, `.cfg` or `.clo` exists (the folder holds `main.tex` and `README.md`).

## Content-opaque
none

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
