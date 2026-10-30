no

# 0309-dutch-university-letter: Dutch University Letter

- Unverified: read from the source, not compiled.
- Source: Source/0309-dutch-university-letter/ (origin: https://latextemplates.com/downloads/dutch-university-letter.zip; licence: MIT, from the manifest)
- Kind: letter
- Lib: v3
- Engine: pdfLaTeX-compatible as far as main.tex goes (no `fontspec`, no engine-specific line); the engine of `uvaletter.sty` is not established, its source was not read and is not in the zip
- Look carried by: preamble (main.tex loads the package `uvaletter`, which is not in the zip, and supplies only field values; the zip ships no class or style file)
- Class origin: tex-distribution-unbundled (`article`, loaded unchanged; no class is bundled in the zip)
- Main file: main.tex (other samples: none; the zip holds this one file, 50 lines)
- Read: main yes, zip-local classes and styles none present

## Verdict
No. The whole zip is one 50-line `main.tex`. It sets `article` at 11pt and then loads `uvaletter` (main.tex:10), a package the zip does not ship, and every letterhead part (masthead, the 3x2 field grid, subject, enclosure line, the `letterhead` environment) is a command or environment that only that missing file can define. A package named `uvaletter` does exist on CTAN and in TeX Live (ctan.org/pkg/uvaletter: "unofficial LaTeX package ... letterhead template for the University of Amsterdam", v1.1.3, MIT, Michele Piazzai), but its source and command list were not read, and nothing in this zip ties the sample's field commands (`\recipient`, `\visiting`, `\yourreference` ...) to that published package. The sample's own header comment calls the file "uvaletter.sty" and refers to other letters "elsewhere in this batch" (main.tex:1, main.tex:3-4), which reads as a batch-local style that was never shipped. I cannot show the letterhead can be written from published packages, so the answer is `no`. It flips to `yes` only if the CTAN package's own source (the separate manifest row for the CTAN zip) defines exactly these commands and needs no tool outside TeX. The zip holds no template file at all, so it is also close to `NOTEMPLATE`; the consolidator may prefer not to count it as evidence either way.

## Blockers
- `UNMAPPED/package` the look-defining file `uvaletter.sty` is not in the zip and was not read; the masthead, field grid, subject, enclosure line and `letterhead` environment have no way that can be justified against W1 to W4 from this zip (main.tex:10, main.tex:12-24, main.tex:27, main.tex:49)

## Class setting
- Class: `class.article` options: `11pt` (main.tex:9). Published kernel class, loaded unchanged; source not read.
- Class-native vocabulary used: none. The sample uses no `\maketitle`, `abstract`, `\opening`, `\closing` or `\section`; the letter is typed as plain paragraphs inside the package's `letterhead` environment (main.tex:27-49).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:9 | `class.article` | option `11pt` |
| base font size | main.tex:9 | `page.class-options` | `11pt` |
| paper size, margins, page geometry | not set in main.tex | not established | whatever `uvaletter.sty` sets is unread |
| fonts, colour, language, header/footer, page style | not set in main.tex | not established | no `\usepackage` other than `uvaletter`; anything the package loads is unread |
| letterhead package load | main.tex:10 | UNMAPPED (considered: `uvaletter`, CTAN/TeX Live, unread) | no options |
| recipient address block | main.tex:12 | UNMAPPED (package field command `\recipient`) | four lines separated by `\\` |
| sender masthead: department, visiting address, postal address, website | main.tex:13, main.tex:14, main.tex:15, main.tex:16 | UNMAPPED (package field commands `\department` `\visiting` `\postal` `\website`) | strings, `\\` line breaks |
| date field | main.tex:17 | `front.maketitle` (kernel `\date`, `\today` only; where the package prints it is unread) | `\today` |
| reference and contact grid | main.tex:18, main.tex:19, main.tex:20, main.tex:21, main.tex:22 | UNMAPPED (package field commands `\yourreference` `\ourreference` `\contactperson` `\phone` `\email`; the header comment calls this a fixed 3x2 grid, main.tex:5-7) | strings |
| subject line | main.tex:23 | UNMAPPED (`\subject` is a package command here; `class.article` defines none) | string |
| enclosure line | main.tex:24 | UNMAPPED (package command `\enclosed`) | string |
| letter body wrapper | main.tex:27, main.tex:49 | UNMAPPED (package environment `letterhead`) | no arguments |
| spacing in the body | main.tex:28, main.tex:43, main.tex:46 | `sp.manual-space` | `\bigskip` (kernel), plus `\par` `\noindent` at main.tex:28 (no lib line names these two primitives; nearest is `sp.lengths`, indentation) |
| line breaks in the signature | main.tex:47 | `sp.manual-space` | `\\` |
| salutation, closing, signature, paragraphs | main.tex:29, main.tex:31-41, main.tex:44, main.tex:47-48 | content | typed text; no `\opening` or `\closing` is used, so no `ltr.opening` use |

## Bespoke code
none defined in the zip. main.tex has no `\newcommand`, `\def`, environment, counter or conditional (checked by reading all 50 lines). The commands listed as UNMAPPED above are used but not defined here. They are not counted as bespoke code because their definition is absent and unread, not because it was judged reducible.

## Content-opaque
none (no figure, table, TikZ or image in main.tex)

## Lib changes
- New ways proposed: none. Considered: `uvaletter` (CTAN package, a letterhead package that would sit beside `ltr.envelope-letter` and `ltr.envlab` as a doc-kind `ltr.*` way). It is not proposed here because the sample's commands could not be matched to the published package from this zip, and a way built on unread source would be a guess. The CTAN zip has its own manifest row, whose analysis can propose the way from the real source.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- No text addressed to an AI was found in the zip.
- Network use: two reads of https://ctan.org/pkg/uvaletter (existence, version, licence, description; the page lists no commands). Nothing downloaded; no other zip opened.
- Missing file: `uvaletter.sty` is referenced at main.tex:10 and named in the comment at main.tex:1; `find` shows main.tex is the only file in the folder.
