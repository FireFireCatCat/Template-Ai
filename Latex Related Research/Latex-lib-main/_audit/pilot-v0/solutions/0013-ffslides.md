yes

# 0013-ffslides: ffslides (freeform slides on top of article)

- Unverified: read from the source, not compiled.
- Source: Source/0013-ffslides/ (origin: https://latextemplates.com/downloads/ffslides.zip; licence: LPPL-1.3)
- Kind: presentation
- Lib: v0 (the snapshot read)
- Engine: pdfLaTeX-compatible (the sample loads `inputenc` and `fontenc`, main.tex:3-4; the class source was not read, so this rests on the sample alone)
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
yes. The unpacked folder holds one file, `main.tex` (46 lines, all read), and it defines nothing: no `\newcommand`, `\def`, environment, counter or zip-local `.cls`/`.sty` (grep for `newcommand|def|RequirePackage|newenvironment|newcounter` finds nothing; the only `\usepackage` lines are main.tex:3-4). The whole look comes from the published class `ffslides` (CTAN, Mark A. Wolters, LPPL 1.3, version 2015-11-19, described as "essentially a small set of macros added to the article class"), which is one `class.ffslides` way loaded with no options. Every body construct is either that class's own vocabulary or kernel (itemize, enumerate, tabular, `\textbf`). Caveat: `ffslides.cls` is not in the zip and was not read, so what `\normalpage` and `\ctext` draw internally is taken on trust from its publication (W1), and the meaning of the `\ctext` numeric arguments is inferred from the sample, not from documentation.

## Blockers
none

## Class setting
- Class: `class.ffslides` options: none (main.tex:1 `\documentclass{ffslides}`). Source not read: the class is published on CTAN (https://ctan.org/pkg/ffslides, read once; the page lists no commands) and is not bundled in this copy of the zip.
- Class-native vocabulary used (for the lib's class section): `\blankpage` (main.tex:8, 43; no argument, starts a page with no title), `\ctext{a}{b}{c}{content}` (main.tex:9, 10, 44; three numbers 0.1 / 0.35 / 0.8, 0.1 / 0.45 / 0.8, 0.1 / 0.4 / 0.8 and a content argument; the numbers look like a left offset, a vertical offset and a width as fractions of the page, which is an inference), `\normalpage{title}{body}` (main.tex:12, 20, 25, 35; a titled slide page whose second argument holds ordinary body material).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.ffslides` | no options |
| input encoding and font encoding | main.tex:3-4 | `font.fontenc-t1` | `inputenc` utf8, `fontenc` T1 |
| title slide (blank page plus positioned title and subtitle) | main.tex:8-10 | `front.class-native` | `\blankpage`, then two `\ctext` calls: (0.1, 0.35, 0.8) and (0.1, 0.45, 0.8) |
| closing slide ("Thank you") | main.tex:43-44 | `front.class-native` | `\blankpage`, then `\ctext` (0.1, 0.4, 0.8) |
| free positioning of text on the page | main.tex:9, 10, 44 | `class.ffslides` | `\ctext` three numeric arguments as above |
| slide heading and slide frame | main.tex:12, 20, 25, 35 | `head.class-native` | `\normalpage{title}{body}`, titles "Why Redesign", "Two Flows Compared", "Checkout Time, Before and After", "What We Recommend"; no options |
| centred text inside `\ctext` | main.tex:9, 10, 44 | `sp.ragged` | `\centering` |
| title and subtitle sizes | main.tex:9, 10, 44 | `font.size-commands` | `\Large` (title, closing), `\normalsize` (subtitle) |
| bold title | main.tex:9 | `mark.kernel` | `\bfseries` |
| bold run-in labels | main.tex:21-22 | `mark.kernel` | `\textbf{Old flow}`, `\textbf{New flow}`; paragraphs split with kernel `\par` |
| bulleted list | main.tex:13-17 | `list.kernel` | `itemize`, three items, no options |
| numbered list | main.tex:36-40 | `list.kernel` | `enumerate`, three items, no options |
| table | main.tex:26-32 | `tbl.tabular` | `tabular{lcc}`, one kernel `\hline` under the header row, no float, no caption, no booktabs |

Components the sample does not use (no evidence either way, so not claimed): headers and footers, page geometry, fonts beyond the T1 encoding, colour, theorems, floats and captions, code, bibliography. The class may set some of these internally; that is the class way's own business.

## Bespoke code
none. main.tex defines no macro, environment, counter or conditional (main.tex:1-46). `\blankpage`, `\ctext` and `\normalpage` are macros of the published class, not zip-local, so they are not bespoke here.

## Content-opaque
none. The tabular at main.tex:26-32 is plain kernel text and numbers; no TikZ, image or diagram.

## Lib changes
- New ways proposed: none. (`class.ffslides` needs no proposal under the rubric; vocabulary recorded above for the lib's class section.)
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
