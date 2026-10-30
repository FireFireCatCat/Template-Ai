yes

# 0906-contract: Contract starter (services agreement with numbered clauses)

- Unverified: read from the source, not compiled.
- Source: Source/0906-contract/ (origin: https://latextemplates.com/downloads/contract.zip; licence: LPPL-1.3c per the manifest and README.md:10; the package it demonstrates is Markus Kohm and Alexander Willand's `contract`, LPPL 1.3c, v0.92, on CTAN and in TeX Live)
- Kind: misc (a legal agreement; no kind in the list names a contract)
- Lib: v6
- Engine: pdfLaTeX-compatible (the sample loads `inputenc` and `fontenc`, main.tex:2-3; the CTAN page for `contract` states no engine and its source is not in the zip, so this rests on the sample)
- Look carried by: preamble (the zip holds one 48-line `main.tex` and a README; the look is `article` plus published packages loaded in the preamble, chiefly the unbundled `contract` package, main.tex:6)
- Class origin: tex-distribution-unbundled (kernel `article`; no class or style file is in the zip)
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
yes. The zip is a starter that loads only published things: kernel `article`, `fontenc`, `inputenc`, `babel`, `geometry`, `hyperref` and the CTAN/TeX Live `contract` package (README.md:3, 10-11; ctan.org/pkg/contract read once: Kohm and Willand, LPPL 1.3c, "successor of scrjura", in TeX Live). The numbered clauses come from that package through `\Clause` and `\SubClause`, which the lib already holds as `legal.contract`. The body adds only kernel marks, a rule and `\hfill` for the signature line. There is no `\newcommand`, `\def`, counter, zip-local file or artwork, so nothing is bespoke. Caveat: `contract.sty` is not in the zip and was not read, so how `\Clause` formats its number and title is taken from the sample's calls and the lib line, not from the package source.

## Blockers
none

## Class setting
- Class: `class.article` options: `11pt`, `a4paper` (main.tex:1)
- Class-native vocabulary used: `\title`, `\author`, `\date`, `\maketitle` (main.tex:10-12, 15). The sample uses no `abstract` environment, no `\section`, no list, float or bibliography.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.article` | 11pt, a4paper |
| paper and base size | main.tex:1 | `page.class-options` | `a4paper`, `11pt` as class options |
| page geometry | main.tex:5 | `page.geometry` | `margin=27mm` (all four sides) |
| encoding | main.tex:2-3 | `font.fontenc-t1` | `fontenc` option `T1`; `inputenc` option `utf8`; no text-face package, so Computer Modern default |
| language | main.tex:4 | `lang.babel` | `english` |
| legal clause package load | main.tex:6 | `legal.contract` | `\usepackage{contract}` with no options |
| links and metadata | main.tex:7-8 | `meta.hyperref` | `hyperref` loaded last, `\hypersetup{hidelinks}` (no link boxes or colours) |
| title block | main.tex:10-12, 15 | `front.maketitle` | `\title{Services Agreement}`, `\author{Your Organisation}`, `\date{\today}`, `\maketitle` (kernel article title block, no restyling) |
| lead-in paragraph, inline marks | main.tex:17-20 | `mark.kernel` | `\textbf{Parties:}` and `\emph{...}` twice; text is content |
| paragraph indent off | main.tex:17, 45, 47 | `sp.lengths` | `\noindent` before three paragraphs (closest home, the paragraph-indent family, as in the 0009 solution) |
| clause environment | main.tex:22, 42 | `legal.contract` | `\begin{contract}` ... `\end{contract}` wraps all clauses |
| numbered top-level clauses | main.tex:23, 31, 35, 39 | `legal.contract` | `\Clause[title={Purpose and scope}]`, `title={Fees and payment}`, `title={Confidentiality}`, `title={Term and termination}`; one string key `title`, the number comes from the package counter |
| numbered subclause | main.tex:27 | `legal.contract` | `\SubClause[title={Deliverables}]` (one, under clause 1) |
| clause numbering | main.tex:23-39 | `legal.contract` | automatic clause and subclause numbers printed by the package; no `\setcounter` or `\renewcommand` in the sample |
| vertical gap before signatures | main.tex:44 | `sp.manual-space` | `\bigskip` |
| signature rules | main.tex:45 | `sp.rule` | `\rule{0.42\linewidth}{0.4pt}` twice, each 0.42 of the line wide, 0.4pt thick |
| signature spacing | main.tex:45, 47 | `sp.manual-space` | `\hfill` between the two rules and between the two plain-text labels "Client signature" and "Supplier signature" (content, no font switch) |

Not defined or used by the sample, so no row: fonts beyond encoding, colour, headers and footers, page numbering (kernel `article` default), headings (no `\section`), contents, lists, quotes, notes, maths, theorems, floats, tables, captions, code, boxes, bibliography, index, cross-references.

## Bespoke code
none. main.tex defines no macro, environment, counter or conditional; `\Clause`, `\SubClause` and `contract` come from the published `contract` package (README.md:3, 10-11), not from the zip.

## Content-opaque
none (the text of the clauses, the party names and the dummy terms are content, main.tex:10-12, 17-41)

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
- Note for the consolidator: `legal.contract` in the lib names `contract` and KOMA `scrjura` together; the CTAN page read for this zip calls `contract` the successor of `scrjura`. This sample calls `\Clause[title=...]` with an optional argument and loads only `contract`. The CTAN page lists no commands, so the command names are from the sample. `contract.sty` source was not read. The CTAN page says German legal conventions are supported out of the box and other conventions (for example Anglo-American) are defined as custom environments; this sample defines none and uses the default `contract` environment with English text, so what it prints is whatever the package defaults give (weak point of this analysis: not read, not compiled).
