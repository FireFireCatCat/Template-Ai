yes

# 0697-die-texnische-kom-die-dtk: Die TeXnische Komödie (dtk) article starter

- Unverified: read from the source, not compiled.
- Source: Source/0697-die-texnische-kom-die-dtk/ (origin: https://latextemplates.com/downloads/dtk.zip; licence: LPPL-1.3c per the manifest and README.md:20)
- Kind: journal
- Lib: v5
- Engine: needs LuaLaTeX (the zip's own notes say the class refuses to load under pdfLaTeX and XeLaTeX: main.tex:7, README.md:8-9; the class source was not read, so this is the zip's claim)
- Look carried by: class (the published `dtk` class; the zip holds only an 86-line sample, a one-entry .bib and a README, no .cls, .sty, .def or .cfg)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
The look is carried entirely by the published class `dtk`, which the zip does not bundle (main.tex:3-5, README.md:16-18). One read of ctan.org/pkg/dtk shows it is a class and style bundle for DANTE e.V.'s journal, by Rolf Niepraschk and Herbert Voss, LPPL 1.3c, in TeX Live and MiKTeX (v2.10g), so it passes W1 and is one way, `class.dtk`; its source was not read. The sample only adds `booktabs` and a biblatex resource file and defines no macro, environment, counter or conditional of its own, and it draws nothing. Every body construct it uses (class front matter, sections, itemize, listings, a captioned table, a citation, the bibliography) has a lib way, so this is `yes`. It is evidence about the class dimension, not about the component ways. Kept visible as a risk: the class internals (listing styles `number` and `noNumber`, heading looks, running heads, page geometry, fonts, biblatex style) were not read, so they are recorded as carried by the class and not decomposed. No text in the zip is addressed to an AI.

## Blockers
none

## Class setting
- Class: `class.dtk` options: `ngerman` (main.tex:15; the zip says the class passes it to babel: README.md:10-11)
- Class-native vocabulary used: `\Author{Lastname}{Firstname}{affiliation}` (main.tex:21-26) with `\Email{..}` inside the affiliation argument (main.tex:23, main.tex:26); `\journalname{}` (main.tex:30); `\title` before `\maketitle` (main.tex:20, main.tex:27); `lstlisting` with the class-defined styles `number` and `noNumber` (main.tex:48, main.tex:57; the zip says the class loads `listings`: main.tex:45); `\addbibresource`, `\autocite`, `\printbibliography` through the class's hardcoded biblatex load (main.tex:17, main.tex:81, main.tex:84; main.tex:9-10, README.md:12-13)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:15 | `class.dtk` | option `ngerman`; LuaLaTeX only (main.tex:7); published, not bundled (main.tex:3-5), source not read |
| page geometry, fonts, colour, running heads, paragraph spacing | none set in the sample; paragraphs "ohne Einzug und mit vertikalem Abstand" in the KOMA-Script tradition (main.tex:35-37) | `class.dtk` | set inside the class (source not read); the sample passes no option or command for them |
| language | main.tex:15; README.md:10-11 | `lang.babel` | `ngerman`, loaded by the class (the zip's claim; class not read) |
| title block | main.tex:20, main.tex:27 | `front.maketitle` | `\title{..}` then `\maketitle`; look set by the class |
| authors and affiliations | main.tex:21-26 | `front.class-native` | `\Author{Lovelace}{Ada}{institute \\ \Email{..}}`, two authors |
| journal name macro | main.tex:30 | `front.class-native` | `\journalname{}`, no argument; printed text comes from the class |
| headings | main.tex:29, main.tex:34, main.tex:44, main.tex:63, main.tex:79 | `head.class-native` | `\section{..}` only, five numbered sections; look set by the class |
| bulleted list | main.tex:39-42 | `list.kernel` | `itemize`, two items; the text says nesting to four levels is possible (main.tex:41) |
| code listing, numbered | main.tex:48-53 | `code.listings` | `lstlisting[style=number]`; style defined in the class (unread) |
| code listing, unnumbered | main.tex:57-61 | `code.listings` | `lstlisting[style=noNumber]`; style defined in the class (unread) |
| table | main.tex:64-75 | `tbl.tabular` | `table[htbp]` holding `tabular{lrr}` |
| table rules | main.tex:16, main.tex:68, main.tex:70, main.tex:73 | `tbl.booktabs` | `\usepackage{booktabs}`, `\toprule` `\midrule` `\bottomrule`, no options |
| table caption | main.tex:65 | `cap.kernel` | `\caption{..}` above the tabular; caption look set by the class (unread) |
| cross-reference | main.tex:66, main.tex:77 | `xref.kernel` | `\label{tab:beispiel}`, `Tabelle~\ref{..}` |
| citation | main.tex:81 | `bib.biblatex-biber` | `\autocite{knuth1984texbook}` |
| bibliography | main.tex:17, main.tex:84; main.bib:1-7 | `bib.biblatex-biber` | `\addbibresource{main.bib}`, `\printbibliography`; `backend=biber` fixed in the class (the zip's claim: main.tex:9-10, README.md:12-13); one `@book` entry |

Not present in the sample, so not mapped: abstract, keywords, figures, theorems, equations, footnotes, appendix, index, headers set by the author.

## Bespoke code
none (main.tex defines no `\newcommand`, `\def`, environment, counter or conditional; there is no .cls, .sty, .def or .cfg in the zip)

## Content-opaque
none

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
