yes

# 0795-philosophy-and-the-mind-sciences: Philosophy and the Mind Sciences (phimisci article starter)

- Unverified: read from the source, not compiled.
- Source: Source/0795-philosophy-and-the-mind-sciences/ (origin: https://latextemplates.com/downloads/phimisci.zip; licence: LPPL-1.3c (manifest); the README says the class is LPPL-1.3c or later, (c) Ruhr-Universitaet Bochum, README.md:95)
- Kind: journal
- Lib: v6
- Engine: needs XeLaTeX (the class loads fontspec and raises ClassError "wrong-tex-engine" under pdflatex; lualatex also works: main.tex:15-17, README.md:17-20)
- Look carried by: class (the zip is one `main.tex` plus a README; the only preamble addition is `booktabs`, main.tex:47; every other look is the published `phimisci` class)
- Class origin: tex-distribution-unbundled (the class is not in the zip: main.tex:1-9, README.md:10-15; ctan.org/pkg/phimisci read: class for the journal Philosophy and the Mind Sciences, maintainer Felix Kopecky, LPPL 1.3c, v1.0.4, in TeX Live and MiKTeX)
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present (there is no .cls, .sty or other class file in the zip; the `phimisci` source was not read)

## Verdict
yes. The whole look is carried by the published `phimisci` class, which the zip does not bundle (it ships with TeX Live and sits on CTAN, so it is one way, `class.phimisci`). The sample adds only `booktabs`, class-native front-matter commands (`\affiliation`, `\orcid`, `\abstract`, `\keywords`, `\contact`), kernel sectioning, one table float and a `\ref`. There is no zip-local macro, no `\newcommand`, no `\def`, no artwork, and no tool outside TeX is needed for the sample (it has no bibliography). The class's internals (page, fonts, running head, heading looks, apa citations) are unread, so this `yes` rests on the class being published and on the sample using only its documented interface.

## Blockers
none

## Class setting
- Class: `class.phimisci` options: `stage=preparation` (main.tex:45). The README lists four values of `stage`: `preparation`, `submission`, `draft`, `final` (README.md:45-50); the key must be given explicitly or authors are suppressed and the head prints "Anonymized" (README.md:31-42, main.tex:32-44). Source not read; the option list is from the README only.
- Class-native vocabulary used: `\title` (main.tex:49), `\author{... \and ...}` with inline `\affiliation{}` and `\orcid{}` (main.tex:53-59), `\abstract{...}` as a preamble command (main.tex:61), `\keywords{...}` as a preamble command (main.tex:69), `\contact{Name}{email}` (main.tex:76), `\maketitle` (main.tex:80). Not used by the sample: `\citep`/`\citet` (natbib-compatible, README.md:71-72), `\addbibresource` and `\printbibliography` (README.md:67-69).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:45 | `class.phimisci` | `stage=preparation`; authors and contact shown, DOI/rights footer suppressed (main.tex:41-42) |
| engine and fonts | main.tex:15-17; README.md:19-20 | `font.fontspec` | loaded by the class (README: "it requires fontspec"); which faces it sets was not read |
| page, spacing, colour | not in the sample | `class.phimisci` | set inside the class, source not read; the sample sets none (no geometry, setlength, colour or font command in main.tex) |
| title block | main.tex:49, main.tex:80 | `front.maketitle` | `\title{...}`, `\maketitle`; no `\date` |
| authors, affiliations, ORCID | main.tex:53-59 | `front.class-native` | one `\author{}` of two `\and`-separated authors, `\affiliation{...}` per author, `\orcid{0000-0002-1825-0097}` for the first (main.tex:55) |
| primary-contact line | main.tex:76 | `front.class-native` | `\contact{Ada Lovelace}{ada@example.edu}`; prints "Primary contact:" at the foot of the title page (main.tex:72-73, README.md:80-81) |
| abstract | main.tex:61-67 | `abs.class-native` | `\abstract{...}` called in the preamble, not an environment (README.md:84-85) |
| keywords | main.tex:69-70 | `abs.keywords` | class command `\keywords{a; b; c; d}`, semicolon-separated string |
| running header and footer | main.tex:41-42; README.md:40 | `hf.class-native` | set by `stage`: the head prints the authors or "Anonymized" (README.md:39-41), and `stage=preparation` suppresses the DOI/rights footer (main.tex:41-42); not read in the class |
| headings | main.tex:82, 90, 97, 121 | `head.class-native` | `\section{...}` four times, numbered; the heading look is the class's, not read |
| inline emphasis | main.tex:91, 92 | `mark.kernel` | `\emph{functional}`, `\emph{mechanistic}` |
| table float | main.tex:101-114 | `tbl.tabular` | kernel `table[htb]` with `tabular{lll}` (main.tex:101, 106) |
| table centring | main.tex:102 | `sp.ragged` | `\centering` |
| table rules | main.tex:47, 107, 109, 112 | `tbl.booktabs` | `\usepackage{booktabs}`; `\toprule`, `\midrule`, `\bottomrule` |
| table caption | main.tex:103-104 | `cap.kernel` | `\caption{...}` above the tabular; the class may restyle it (not read) |
| cross-reference | main.tex:98-99, 105 | `xref.kernel` | `\label{tab:boundaries}`, `Table~\ref{tab:boundaries}` |
| bibliography (class-loaded, unused by the sample) | main.tex:18-31; README.md:52-72 | `bib.biblatex-biber` | the class loads `biblatex` with `style=apa,natbib=true` and no `backend=`, so biber applies (main.tex:20-21); the sample cites nothing and has no `\printbibliography`; recorded because the class loads it unconditionally |

## Bespoke code
none. The zip holds no zip-local class, style, macro, environment, counter or conditional. The names in the comments (`\l__phimisci_output_authors_bool`, `\__phimisci_stage_*`, main.tex:32-36) belong to the published class's expl3 code and are not called by the sample.

## Content-opaque
none

## Lib changes
- New ways proposed: none. Considered and not proposed: a separate way for the apa `biblatex` style (it is the parameter of `bib.biblatex-biber`).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- Text addressed to an AI: none found. The comments in main.tex:1-44 and the README are instructions to a human author (for example "delete this comment block", main.tex:27-28), and were not acted on.
- Biber: the README says the starter ships without a bibliography because its original build pipeline ran bibtex only (README.md:52-62). Biber is the backend of the lib's `bib.biblatex-biber` way and is not counted as `EXTERNAL`; this sample does not need it.
- Missing assets: none (no images, no fonts shipped; the fonts the class picks via fontspec were not read).
