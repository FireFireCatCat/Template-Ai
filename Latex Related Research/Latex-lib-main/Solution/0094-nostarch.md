yes

# 0094-nostarch: nostarch (technical-book starter on Boris Veytsman's No Starch Press class)

- Unverified: read from the source, not compiled.
- Source: Source/0094-nostarch/ (origin: https://latextemplates.com/downloads/nostarch.zip; licence: LPPL-1.3)
- Kind: book
- Lib: v1
- Engine: pdfLaTeX-compatible (main.tex:9-13 says the `nocfonts` option makes it compile "under plain pdflatex"; README.md:45 builds with `pdflatex`, `bibtex`, `makeindex`; the class source was not available to confirm)
- Look carried by: class (the zip holds no .cls or .sty; main.tex:16 loads `nostarch`, which defines page, fonts, headings, running heads, half-title, title page, copyright page, dedication page, contents and index look; the sample adds only one class option, three packages, content and the class's own front-matter commands)
- Class origin: tex-distribution-unbundled (`nostarch` is on CTAN, author Boris Veytsman, LPPL 1.3, in TeX Live, ships `nostarch.cls`, `nostarch.ist` and a hyperref-interface package; read once at https://ctan.org/pkg/nostarch; README.md:31-34 confirms the class is NOT in the zip)
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
The zip is three files: `main.tex` (106 lines), `references.bib` and a README. It defines no macro, environment, counter, class or style of its own (no `\newcommand`, `\def`, `\let`, `\newenvironment`, `\newcounter`, `\RequirePackage` in `main.tex`; the only code lines are the class, three `\usepackage` lines and `\makeindex`). Everything that decides the look sits inside the published CTAN class `nostarch`, one way, `class.nostarch`, with the option `nocfonts`. The class source was not read, so what it loads inside (geometry, fonts, fancyhdr-like heads, makeidx, hyperref) is recorded as inherited, not analysed. The answer is `yes` because an emitter can write `\documentclass[nocfonts]{nostarch}`, natbib, `nshyper`, amsmath, `\makeindex`, the class's own front-matter commands and the standard front/main/back-matter body using only published ways. This is evidence about the class dimension, not about the component ways.

## Blockers
none

## Class setting
- Class: `class.nostarch` options: `nocfonts` (use free substitute fonts instead of No Starch's commercial ones; main.tex:9-13, 16)
- Class-native vocabulary used: `\subtitle{}` (main.tex:32), `\nostarchlocation{}` (main.tex:28; README.md:17-18 says the class default is "San Francisco" and the sample sets it empty), `\makehalftitle` (main.tex:34), `\maketitle` after `\author`/`\title` (main.tex:27, 30, 36), environments `copyrightpage` (main.tex:38-43) and `dedicationpage` (main.tex:45-47), `\frontmatter` `\mainmatter` `\backmatter` (main.tex:25, 56, 99), `\chapter`, `\chapter*`, `\section` (main.tex:51, 58, 66, 78, 90), `\tableofcontents` (main.tex:49), `\index{...}` with `!` subentries and `\printindex` (main.tex:62-92, 104); companion files of the bundle: package `nshyper` (main.tex:19) and index style `nostarch.ist` (README.md:26, 45).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:16 | `class.nostarch` | option nocfonts |
| page geometry, paper, margins | not set in the sample | `class.nostarch` | inherited from the class (not read); no explicit setting to emit |
| fonts and spacing | main.tex:9-13, 16 | `class.nostarch` | inherited; `nocfonts` selects free substitutes for the commercial faces (the substitute packages are not read); no `\usepackage` of a font in the sample |
| running heads / page style | not set in the sample | `hf.class-native` | inherited from the class (not read) |
| half-title page | main.tex:34 | `front.class-native` | `\makehalftitle` (prints the title alone) |
| title page | main.tex:27-32, 36 | `front.class-native` | `\author`=Marcus Webb, `\title`=`\emph{Practical Compiler Construction}`, `\subtitle`=Building a Language, One Pass at a Time, `\nostarchlocation`=empty; `\maketitle` |
| copyright page | main.tex:38-43 | `front.class-native` | environment `copyrightpage` with a bold sans upper-case emphasised title line and one plain paragraph (generic hand-written equivalent would be `front.dedication`; here it is the class's own environment) |
| dedication page | main.tex:45-47 | `front.class-native` | environment `dedicationpage` with one sentence |
| front/main/back matter split | main.tex:25, 56, 99 | `front.class-native` | `\frontmatter`, `\mainmatter`, `\backmatter` (book vocabulary) |
| page numbering | main.tex:25, 56 | `pgnum.pagenumbering` | set implicitly by `\frontmatter`/`\mainmatter` (no explicit `\pagenumbering` call; the class may redefine them, not read) |
| table of contents | main.tex:49 | `toc.kernel` | `\tableofcontents`; look set by the class (not read) |
| foreword | main.tex:51-54 | `head.class-native` | unnumbered `\chapter*{Foreword}` in front matter; whether it enters the contents is class behaviour (not read) |
| chapter headings | main.tex:58, 78 | `head.class-native` | `\chapter{...}`; look set by the class (not read) |
| section headings | main.tex:66, 90 | `head.class-native` | `\section{...}`; look set by the class (not read) |
| cross-reference labels | main.tex:59, 79 | `xref.kernel` | `\label{ch:lexer}`, `\label{ch:parser}` after each chapter; no `\ref` in the sample |
| hyperlinks | main.tex:19 | `meta.hyperref` | `\usepackage{nshyper}`, the nostarch bundle's own interface to hyperref (CTAN page: "a package for interfacing with hyperref"); no options in the sample; its source was not read |
| inline marks | main.tex:30, 39, 61, 74, 86, 93 | `mark.kernel` | `\emph`, `\textbf{Note.}`, `\textbf{Tip.}` (plain bold run-in labels, not a box), `\texttt`, `\sffamily`, `\MakeUppercase` (copyright title line, main.tex:39) |
| math package | main.tex:20 | `math.amsmath` | `\usepackage{amsmath}`; no equation in the sample body |
| citations | main.tex:18, 95, 97 | `bib.natbib` | `\usepackage{natbib}` with no options; `\citet{aho2006compilers}`, `\citet{grune2008parsing}` |
| bibliography | main.tex:101-102; references.bib:1-15 | `bib.bibtex-bst` | `\bibliographystyle{plainnat}`, `\bibliography{references}`; two `@book` entries; run `bibtex` |
| index | main.tex:21, 62-92, 104; README.md:25-29, 45 | `idx.makeidx` | `\makeindex`, `\index{tokens}` style entries and `\index{finite automaton!nondeterministic}` subentries (main.tex:69, 71, 84, 88), `\printindex`; makeindex style `nostarch.ist` from the class bundle (the style is a parameter, as a `.bst` is for `bib.bibtex-bst`); the sample loads no makeidx package, so the class must provide `\printindex` (not verified) |

## Bespoke code
none. No `\newcommand`, `\renewcommand`, `\def`, `\let`, environment, counter or `\RequirePackage` in any zip file. The only non-kernel commands and environments (`\subtitle`, `\nostarchlocation`, `\makehalftitle`, `copyrightpage`, `dedicationpage`) belong to the published class.

## Content-opaque
none (no figure, table, equation, code listing or TikZ in the sample; the body is prose, two bold run-in labels, citations and index entries).

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- The class source (`nostarch.cls`, LPPL 1.3, CTAN, TeX Live), `nshyper.sty` and `nostarch.ist` were not in the zip and were not read (the rubric needs no reading of a published class). Page geometry, fonts, the `nocfonts` substitutes, headings, running heads, contents look, index look and the packages the class loads are inherited and not analysed; the rows marked "inherited" record that, not a measured setting.
- README.md:27-28 names a `postbibtex.sh` hook that runs `makeindex -s nostarch.ist`; it is not in the zip (ls shows only `README.md`, `main.tex`, `references.bib`). It is the host's compile recipe. `makeindex` is a TeX Live program with the same status as `bibtex` in the lib (as ruled in 0008-envlab and 0034-moderntimeline), so it is not `EXTERNAL`. README.md:44-46 lists the full build: pdflatex, bibtex, makeindex, pdflatex twice.
- Without `nocfonts` the class loads commercial fonts (New Baskerville and others, main.tex:9-11), which the zip does not ship. The sample avoids them with the option; an emitter must keep `nocfonts` or ship those fonts.
- main.tex:1-15 and README.md:3-21 are prose about licence and trademark (the sample is "NOT an official No Starch Press product"); they contain no instruction addressed to an AI. The zip is a third-party starter from latextemplates.com, not the publisher's own kit, so the class origin is the CTAN release, not `publisher-official`.
