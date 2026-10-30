yes

# 0692-folded-postcard: Multi-Recipient Postcard Mailing (manifest name "Folded Postcard")

- Unverified: read from the source, not compiled.
- Source: Source/0692-folded-postcard/ (origin: https://latextemplates.com/downloads/folded-postcard.zip; licence: LPPL per manifest)
- Kind: letter
- Lib: v5
- Engine: pdfLaTeX-compatible (the zip says it was rendered through a PDF pipeline, README.md:14-19; no engine is named and envlab's pdfTeX support is unverified in the lib)
- Look carried by: class (`postcards`, a published class that is not in the zip; main.tex adds only sender fields, a mail-merge file name, a message and one geometry override)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none; addresses.txt is the data file it reads, README.md is a note)
- Read: main yes, zip-local classes and styles none present

## Verdict
The zip holds no `.cls`, `.sty` or macro of its own. Its whole look is the published `postcards` class (CTAN `postcards`, in TeX Live and MiKTeX, LPPL, read at ctan.org/pkg/postcards), which loads `envlab`, `mailing` and `geometry` (README.md:5-7, 11; main.tex:14). The sample sets only `fontenc`/`inputenc`, three letter sender fields, `\addressfile`, `\mailingtext` and one `\geometry` call, and all of these map to published ways. One new way is proposed for the mail merge (`mailing`, published on CTAN). The `postcards`, `envlab` and `mailing` source files were not available in the zip and were not read, so what the class does inside (page size, barcode, the two pages per record) rests on README.md and the CTAN pages.

## Blockers
none

## Class setting
- Class: `class.postcards` options: none (main.tex:10). Published class, "a modification of the standard LaTeX letter class which prints multiple, pre-stamped, 5.5in by 3.5in postcards via the envlab and mailing packages" (ctan.org/pkg/postcards). Source not in the zip, not read.
- Class-native vocabulary used: `\name{}` (main.tex:26), `\address{}` (main.tex:27), `\signature{}` (main.tex:28), all letter-class sender fields; `\addressfile{}` (main.tex:30) and `\mailingtext{}` (main.tex:31-33), which ctan.org/pkg/mailing names as the `mailing` package's commands, loaded by the class; the class geometry set with `\RequirePackage[...]{geometry}` (main.tex:14-15; README.md:11) and overridden by `\geometry` (main.tex:24). No `\opening`, `\closing`, `letter` environment or other body command is used.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:10 | `class.postcards` | no options; the class carries page size, address side and message side |
| font encoding | main.tex:11 | `font.fontenc-t1` | `fontenc` with option `T1` |
| input encoding | main.tex:12 | `font.fontenc-t1` | `inputenc` with option `utf8` |
| page size and margins (class default) | README.md:3, README.md:9-12, main.tex:14-16 | `page.geometry` | class loads `geometry`; postcard 5.5in x 3.5in; `voffset=5in` in the class; other keys not read |
| page offset override | main.tex:24 | `page.geometry` | `\geometry{voffset=0in}` after the class has loaded `geometry` |
| sender name, address, signature | main.tex:26-28 | `ltr.opening` | `\name{Marisol Chen}`, `\address{221 Birchgate Lane\\Burlington, VT 05401}`, `\signature{Marisol}` |
| mail-merge recipient file | main.tex:30; addresses.txt:1-8 | `ltr.formlett` | `\addressfile{addresses.txt}`; file holds blank-line-separated records of name, address with `\\`, salutation (README.md:4-5) |
| mail-merge message text | main.tex:31-33 | `ltr.formlett` | `\mailingtext{...}` one body for every record (the text is content) |
| address side: flush-right recipient block and barcode | README.md:5-7 (class and `envlab` source not read) | `ltr.envlab` | class defaults; the sample calls no `envlab` command |
| document body | main.tex:35-36 | `ltr.formlett` | empty body; the per-recipient pages (message side and address side) come from the class and the loaded packages, not from body commands (README.md:5-7) |

No other component is defined or used: no headings, lists, floats, tables, theorems, code, bibliography, colour, running heads, page numbering or title block appear in the sample.

## Bespoke code
none. The zip defines no `\newcommand`, `\def`, environment, counter or conditional. Its one patch is a published command, `\geometry{voffset=0in}` (main.tex:24), which is `page.geometry` with a length. The reason is in main.tex:14-23 and README.md:9-23: the class's own `voffset=5in` moves content off the postcard-sized page under a PDF pipeline.

## Content-opaque
none in the sample. The barcode on the address side is produced by `envlab` through the class (README.md:6-7), not drawn by the zip, so it is not `ART`. The message and address data are content (main.tex:31-33; addresses.txt:1-8).

## Lib changes
- New ways proposed: `ltr.formlett` | `mailing` (CTAN `mailing`, v1.0d 2026-01-02, Johannes Braams, LPPL 1.3c, in TeX Live and MiKTeX; read at ctan.org/pkg/mailing), engine pdf (no engine need stated on the CTAN page; the class that loads it was reported rendered through a PDF pipeline, README.md:14-19); `\addressfile{file}` names a plain-text recipient file and `\mailingtext{text}` is the one letter body, repeated for each record. W1: on CTAN and in TeX Live. W2: the choices are a file name and a text argument, and the recipient data is data in a file. W3: serves any one-body-many-recipients mailing, not one document. W4: two preamble lines, with the data file shipped beside the `.tex`. A sibling of `ltr.formlett` (formlett's own `\beginletter` `\moreletter` records) and not `struct.datatool` (a general database loop); the consolidator may fold it into `ltr.formlett` as another mail-merge package.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- Provenance: the manifest names this "Folded Postcard", but main.tex:1-9 and README.md:1 describe a "Multi-Recipient Postcard Mailing", main.tex:3 and main.tex:8-9 refer to "this batch", and README.md:9 says the sample was "Patched". The zip is read as it stands; nothing in it addresses an AI reader.
- Not established here: whether `envlab` (dvips-oriented, see `ltr.envlab` in the lib) and the class work in pdfLaTeX without a patch; the zip's own statement is README.md:14-19 and main.tex:19-23, taken as a claim, not a check.
