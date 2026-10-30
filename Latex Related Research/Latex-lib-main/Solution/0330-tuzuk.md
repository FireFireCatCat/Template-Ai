yes

# 0330-tuzuk: tuzuk, Turkish bylaws and regulations class

- Unverified: read from the source, not compiled.
- Source: Source/0330-tuzuk/ (origin: https://mirrors.ctan.org/macros/latex/contrib/tuzuk.zip; licence: LPPL 1.3c for the class (README.md:21, manifest); the sample's own header says LaTeX code CC BY-SA 4.0 and text CC BY-ND 4.0 (oyd_tuzuk_2023.tex:1-4))
- Kind: misc (an association's bylaws, "tüzük", a numbered-article legal text with a signature block)
- Lib: v3
- Engine: pdfLaTeX-compatible (mathptmx, inputenc utf8, fontenc T1, babel turkish; no fontspec, no Lua: tuzuk.dtx:73-82)
- Look carried by: class (the sample adds only five signature-name strings and a title string, oyd_tuzuk_2023.tex:8-14; every look decision is in the class code of tuzuk.dtx:63-144)
- Class origin: ctan (ctan.org/pkg/tuzuk, path macros/latex/contrib/tuzuk, v1.0.0 2024-03-13, read once; the zip itself is the CTAN contrib zip)
- Main file: oyd_tuzuk_2023.tex (other samples: tuzuk.dtx documentation driver under `ltxdoc`, tuzuk.dtx:3-11; the two PDFs are compiled outputs and were not read)
- Read: main yes, zip-local classes and styles all (no `.cls` or `.sty` is in the zip: the class exists only as the code lines of tuzuk.dtx:63-144, which `tuzuk.ins` turns into `tuzuk.cls`; both files read in full)

## Verdict
yes. The look is carried by one class published on CTAN (`class.tuzuk`, LPPL 1.3c), and the sample is that class plus data strings and content. The class code is about 80 lines (tuzuk.dtx:63-144): `\LoadClass{article}`, nine `\RequirePackage` calls (tuzuk.dtx:68-82), and `\def`/`\newcommand`/`\newenvironment` aliases that are compositions of kernel commands, `enumitem` and `tabular`. Every one reduces to lib ways (Bespoke code table); there is no artwork, no external tool and no unmapped component. The class's own `tuzuk.cls` is not in the zip but is produced by a docstrip run (TeX itself, not an outside tool) or taken from CTAN.

## Blockers
none

## Class setting
- Class: `class.tuzuk` options: none (oyd_tuzuk_2023.tex:6). Inside it: `\LoadClass[12pt, onecolumn]{article}` (tuzuk.dtx:63), so the base is `class.article`; `\ProcessOptions\relax` (tuzuk.dtx:65) passes nothing on.
- Class-native vocabulary used: `\baskan{}` `\baskanyrd{}` `\sekreter{}` `\sayman{}` `\uye{}` (signature-name strings, oyd_tuzuk_2023.tex:8-12; defined tuzuk.dtx:87-91), `\tuzukbasligi{}` (title string, oyd_tuzuk_2023.tex:14; tuzuk.dtx:93-99), redefined `\maketitle` (oyd_tuzuk_2023.tex:17; tuzuk.dtx:114-120), `\bolumadi{}` (section title, tuzuk.dtx:104), `\madde{n}{text}` (numbered article, tuzuk.dtx:109), `fikra` environment (lettered list, tuzuk.dtx:125-130), `\imzalar` (signature table, oyd_tuzuk_2023.tex:451; tuzuk.dtx:135-144). The sample also uses kernel `\textbf` (oyd_tuzuk_2023.tex:76), `\\` and `\newline` (oyd_tuzuk_2023.tex:86-88) and `\%` (oyd_tuzuk_2023.tex:93).

## Component map
Main sample: oyd_tuzuk_2023.tex, a `\documentclass{tuzuk}` file with 29 `fikra` lists. It has no `\usepackage`, no `\newcommand`, no `\def`, no `\pagestyle` (grep). The way column gives the reduction the class code spells out; the class's own command names are in the Evidence or Parameters column.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | oyd_tuzuk_2023.tex:6; tuzuk.dtx:17 | `class.tuzuk` | no options; `\ProvidesClass{tuzuk}` v1.0.0 2024/03/13 |
| base class | tuzuk.dtx:63 | `class.article` | options `12pt`, `onecolumn` (the default column mode) |
| font size, column mode | tuzuk.dtx:63 | `page.class-options` | `12pt`, `onecolumn` |
| page geometry | tuzuk.dtx:68-72 | `page.geometry` | `a4paper`, `top=2.5cm`, `left=2.5cm`, `right=2.5cm`, `bottom=2.5cm` |
| text and math font | tuzuk.dtx:73 | `font.mathptmx` | `mathptmx`, no options |
| input and font encoding | tuzuk.dtx:78, 82 | `font.fontenc-t1` | `inputenc` option `utf8`; `fontenc` option `T1` |
| language | tuzuk.dtx:79 | `lang.babel` | `turkish` |
| line spacing | tuzuk.dtx:74-75 | `sp.setspace` | `\onehalfspacing` |
| hyphenation | tuzuk.dtx:81 | `sp.hyphenat` | `hyphenat` loaded, no options, no `\hyphenation` call |
| underline package | tuzuk.dtx:80 | `mark.ulem` | option `normalem`; load only, the sample calls no `\uline` |
| page style | tuzuk.dtx:115 | `hf.pagestyle-kernel` | `\thispagestyle{plain}` on the title page; no other `\pagestyle` in class or sample, so the article default stays |
| title block | oyd_tuzuk_2023.tex:14, 17; tuzuk.dtx:93-99, 114-120 | `front.class-native` | `\tuzukbasligi{T}` stores `\textbf{\MakeUppercase{T}}`; `\maketitle` is `\thispagestyle{plain}` + `center` environment + `\vspace{12pt}` + that string. No author, date, abstract. Reduction: `hf.pagestyle-kernel`, `sp.ragged`, `sp.manual-space`, `mark.kernel` |
| section title (`\bolumadi`) | oyd_tuzuk_2023.tex:18; tuzuk.dtx:104 | `mark.kernel`, `sp.manual-space`, `sp.lengths` | `\vspace{8pt} \noindent\textbf{#1}\newline`; an unnumbered bold label made of kernel commands, not a `\section` |
| numbered article (`\madde`) | oyd_tuzuk_2023.tex:19; tuzuk.dtx:109 | `mark.kernel`, `sp.manual-space`, `sp.lengths` | `\noindent\textbf{Madde #1:} #2 \\`; the number is typed by hand, there is no counter |
| lettered sub-items (`fikra`) | oyd_tuzuk_2023.tex:25-44, 49-69; tuzuk.dtx:125-130 | `list.enumitem`, `list.kernel` | `enumerate` with `label=\alph*.`; `\item` inside |
| bold run-in item labels | oyd_tuzuk_2023.tex:76-78 | `mark.kernel` | `\textbf{...}` |
| forced line breaks in items | oyd_tuzuk_2023.tex:86-88 | `sp.manual-space` | `\\` followed by `\newline` |
| signature block | oyd_tuzuk_2023.tex:451; tuzuk.dtx:135-144 | `tbl.tabular`, `sp.rule`, `sp.ragged`, `sp.manual-space` | `\arraystretch` 1; `\vspace{1.5cm}`; `tabular` with columns `p{5cm}p{5cm}p{5cm}`; `\hrulefill` cells; `\centering` in each name cell; one `\vspace{1cm}` spacer row; second row of two cells. The names are the cell content, stored by `\baskan` ... `\uye` |
| documentation driver (second sample) | tuzuk.dtx:3-11 | `class.ltxdoc`, `dtx.doc` | `\EnableCrossrefs` `\CodelineIndex` `\RecordChanges`, `\DocInput{tuzuk.dtx}`, `\PrintChanges`, `\PrintIndex` |
| documentation body | tuzuk.dtx:22-25, 27, 33, 35-54, 56, 58, 60, 62-83, 147 | `front.maketitle`, `front.thanks`, `head.kernel`, `code.verbatim`, `mark.kernel`, `sp.manual-space`, `dtx.doc` | `\title` with `\thanks`, `\author` with `\\` and `\texttt`, `\maketitle`, `\section`, `\DescribeMacro`, `verbatim`, `\StopEventually`, `\changes`, `macrocode`, `\Finale`; `\textsf` and `\texttt` |

Components the sample does not use: floats, tables other than the signature table, captions, footnotes, cross-references, bibliography, index, theorems, code listings, colour, hyperref, running headers or footers beyond the kernel's plain page number.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\baskan` `\baskanyrd` `\sekreter` `\sayman` `\uye` | tuzuk.dtx:87-91 | yes | `\def` stores one string each; the strings are the cell text of the signature table (content). No logic. |
| `\tuzukbasligi` | tuzuk.dtx:93-99 | yes | `\def` storing `\textbf{\MakeUppercase{#1}}` for `\maketitle` (`mark.kernel`) |
| `\bolumadi` | tuzuk.dtx:104 | yes | `\newcommand` alias: `sp.manual-space` (`\vspace{8pt}`, `\newline`), `sp.lengths` (`\noindent`), `mark.kernel` (`\textbf`) |
| `\madde` | tuzuk.dtx:109 | yes | `\newcommand` alias: `sp.lengths` (`\noindent`), `mark.kernel` (`\textbf{Madde #1:}`), `sp.manual-space` (`\\`) |
| `\maketitle` (renewed) | tuzuk.dtx:114-120 | yes | `\renewcommand` with a kernel page style, `center`, `\vspace{12pt}` and the stored title; it does not touch `\@maketitle` or other kernel internals |
| `fikra` | tuzuk.dtx:125-130 | yes | `\newenvironment` wrapper of `\begin{enumerate}[label=\alph*.]` (`list.enumitem`) |
| `\imzalar` | tuzuk.dtx:135-144 | yes | `\newcommand` wrapping one `tabular` (`tbl.tabular`) with `\hrulefill` (`sp.rule`), `\centering` (`sp.ragged`), `\vspace` (`sp.manual-space`) |
| `tuzuk.cls` (generated) | tuzuk.ins:30 (`\generate`), README.md:15 | yes | Not in the zip. Docstrip (`\input docstrip.tex`, tuzuk.ins:12) is a TeX run, so it is not EXTERNAL. An emitter writes `\documentclass{tuzuk}` against the CTAN class, or ships the generated `tuzuk.cls`. |
| `tuzuk.ins` install script | tuzuk.ins:12-46 | yes | `\preamble` text, `\generate`, `\Msg` notices; a build step that prints nothing in the document |

## Content-opaque
none

## Lib changes
- New ways proposed: none.
- Filing decisions the reviewer may want to check (no new way is proposed for either): `\noindent` (tuzuk.dtx:104, 109) is filed under `sp.lengths` as the per-paragraph switch of `\parindent`; `\MakeUppercase` (tuzuk.dtx:96) is filed under `mark.kernel` as a kernel inline text command next to `\textsc`. If a reviewer rules either one a stretch, the home is a one-command line and the verdict would still hold, because both are kernel commands with no declarative gap.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- Reading of the macros, not a compile claim: `\bolumadi` ends in `\newline` (tuzuk.dtx:104) and `\madde` ends in `\\` (tuzuk.dtx:109), and neither body contains a `\par`, so the headings and articles are line-broken by hand rather than being separate paragraphs.
- `\fileversion` and `\filedate` are defined at tuzuk.dtx:14-15 inside the `%<*package>` block but are used in the documentation title at tuzuk.dtx:22; whether the documentation run sees them was not checked.
- The sample numbers the articles by hand and repeats "Madde 23" (oyd_tuzuk_2023.tex:338, 347): content, not template.
- No text addressed to an AI was found in any file of the zip.
