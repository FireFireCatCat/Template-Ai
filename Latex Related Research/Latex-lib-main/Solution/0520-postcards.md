yes

# 0520-postcards: postcards (letter-based class for mass-mailing 5.5 x 3.5 in postcards)

- Unverified: read from the source, not compiled.
- Source: Source/0520-postcards/ (origin: https://mirrors.ctan.org/macros/latex/contrib/postcards.zip; licence: LPPL, README:6 and postcards.cls:7)
- Kind: letter (a mail-merge of postcards through the letter class)
- Lib: v5
- Engine: pdfLaTeX-compatible (nothing needs XeLaTeX or LuaLaTeX; the documented route is latex then dvips, pcardsmp.tex:10-22, and pdfTeX output was not checked)
- Look carried by: class (postcards.cls sets page, closing, envelope face and mail merge; the sample adds only the class's native commands, pcardsmp.tex:24-44)
- Class origin: ctan (ctan.org/pkg/postcards: maintainer Bil Kleb, LPPL, in TeX Live and MiKTeX; the zip is the CTAN package itself)
- Main file: pcardsmp.tex (other samples: none; data file datasmp.txt)
- Read: main yes, zip-local classes and styles all (postcards.cls, 97 lines; the zip has no .sty); published `letter`, `envlab`, `mailing` and `geometry` sources not read (not in the zip)

## Verdict
Yes, and the verdict rests on W1. The look is carried entirely by `postcards`, a class published on CTAN and in TeX Live, so it is one way, `class.postcards`. The sample is a short preamble of the class's own commands (pcardsmp.tex:24-44) with an empty body (pcardsmp.tex:46-47). Everything the class does is a call into published packages: `letter`, `geometry`, `envlab`, `mailing`. Every one maps to a lib way, except mail merge with `mailing`, proposed as `ltr.formlett`.

The class's `\closing` redefinition (postcards.cls:27-37) uses letter-class internals (`\stopbreaks`, `\fromsig`, `\longindentation`) and an `\ifx` on `\fromaddress`. If the class were counted as zip-local code, that block would be judged irreducible. It is not counted: the class is published, and an emitter only writes `\documentclass[11pt]{postcards}` and the native commands, copying none of it.

Not blockers, recorded: (1) the sample documents a dvips print route with page ranges and copies (pcardsmp.tex:13-22). That is a print recipe, and dvips is a TeX-distribution tool, not an outside program. (2) `voffset=5in` (postcards.cls:45) is a printer-feed offset for a postcard fed through a printer ("moves page to upper left corner", cls:45), so pdfTeX output is unverified. (3) The `envlab` and `mailing` sources were not read.

## Blockers
none

## Class setting
- Class: `class.postcards` options: `11pt` (pcardsmp.tex:24); every option is passed on to `letter` (postcards.cls:18-19); the class itself loads `letter` with `landscape` (postcards.cls:20).
- Class-native vocabulary used: `\addressfile{file}` (pcardsmp.tex:33, from `mailing`), `\mailingtext{body}` (pcardsmp.tex:36-38, from `mailing`), `\address{..\\..}` (pcardsmp.tex:41-43) and `\signature{..}` (pcardsmp.tex:44) from `letter`, `\closing{..}` inside the mailing text (pcardsmp.tex:38; redefined at postcards.cls:27-37). The opening is the third field of each address record (pcardsmp.tex:36; datasmp.txt:3,7); `\opening` is redefined to print only that field (postcards.cls:24). `\makemailing` is run by the class at begin document (postcards.cls:97), and the body is empty (pcardsmp.tex:46-47).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | pcardsmp.tex:24; postcards.cls:13,18-20 | `class.postcards` | option `11pt`; other options go to `letter`; loads `letter` with `landscape` |
| paper size, orientation, base font size | pcardsmp.tex:24; postcards.cls:20 | `page.class-options` | `11pt`; `landscape` |
| page geometry | postcards.cls:42-47 | `page.geometry` | papersize={3.5in,5.5in}, margin=0.375in, landscape, voffset=5in, noheadfoot; version date [1998/04/08] |
| header and footer | postcards.cls:46; postcards.cls:24 | `page.geometry` (noheadfoot); `hf.pagestyle-kernel` | `noheadfoot` drops head and foot from the text block; `\thispagestyle{firstpage}` (page style defined by `letter`, source not read) |
| letter opening | postcards.cls:24; datasmp.txt:3,7 | `ltr.opening` | `\opening#1` prints only the opening string from the address record, with no return address, date or to-address |
| closing, signature, return address | pcardsmp.tex:38,41-44; postcards.cls:27-37 | `ltr.opening` | `\closing{Respectfully,}`; `\address` of three lines; `\signature{Marvin the Robot}`; space for signature `\\[3\medskipamount]` (postcards.cls:33, 3 instead of 6) |
| closing internals (spacing) | postcards.cls:27,31,33 | `sp.manual-space` | `\vspace{\parskip}`, `\hspace*{\longindentation}`, `\\[3\medskipamount]` |
| closing internals (block) | postcards.cls:32 | `box.minipage` | `\parbox{\indentedwidth}{..}` |
| closing internals (alignment) | postcards.cls:32 | `sp.ragged` | `\raggedright` |
| postcard address face | postcards.cls:52-58,61,64,77 | `ltr.envlab` | options `norotateenvelopes`, `alwaysbarcodes`; `\SetEnvelope{5.5in}{3.5in}`; `\setlength{\ToAddressTopMargin}{0.25in}` (default 0.5in); `\makelabels`; version date [1997/07/16] |
| to-address flush right (box) | postcards.cls:67-69,76 | `box.minipage` | `minipage[t][\EnvelopeHeight]{\EnvelopeWidth}` |
| to-address flush right (lengths) | postcards.cls:69-71 | `sp.lengths` | `\baselineskip=0pt`, `\lineskip=0pt`, `\parindent=0pt` |
| to-address flush right (alignment) | postcards.cls:73-75 | `sp.ragged` | `flushright` environment around `\PrintAddress{#2}` |
| return address then to-address | postcards.cls:72 | `sp.manual-space` | `\\` after `\PrintReturnAddress{#1}` |
| mail merge of the message over the address records | postcards.cls:82,97; pcardsmp.tex:33,36-38; datasmp.txt:1-8 | `ltr.formlett` | `\RequirePackage{mailing}[1999/03/03]`; `\addressfile{datasmp.txt}`; `\mailingtext{..}`; `\makemailing` once at begin document; record = name, address with `\\`, opening, blank line |
| document body | pcardsmp.tex:46-47 | `ltr.formlett` | empty body; the whole message lives in `\mailingtext` |
| fonts, colour, language, metadata, headings, lists, math, theorems, floats, tables, code, bibliography, index | pcardsmp.tex:24-47; postcards.cls:12-97 | none | none defined or used (no package in the sample's preamble; default Computer Modern at 11pt) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| the class `postcards` | postcards.cls:1-97 | not bespoke (published) | `class.postcards`; the emitter writes `\documentclass[11pt]{postcards}` and no class code |
| `\DeclareOption*` pass-through to `letter` | postcards.cls:18-19 | yes | kernel option passing; the class option `11pt` is a parameter of `class.postcards` and `page.class-options` |
| `\opening` redefinition | postcards.cls:24 | yes | `hf.pagestyle-kernel` (`\thispagestyle{firstpage}`) plus the argument and kernel `\par\nobreak`; no lib way beyond the class is needed |
| `\closing` redefinition | postcards.cls:27-37 | yes for the record, only as part of the class way | the kernel letter closing with the gap changed from `6\medskipamount` to `3\medskipamount` (comment at postcards.cls:33); composition of `sp.manual-space`, `box.minipage` and `sp.ragged`, driven by `letter` variables (`\fromaddress`, `\fromsig`, `\fromname`, `\longindentation`, `\indentedwidth`); not copied by an emitter |
| `\PrintEnvelope` redefinition | postcards.cls:67-76 | yes | `box.minipage` + `sp.lengths` + `sp.ragged` + `sp.manual-space`, calling the `envlab` commands `\PrintReturnAddress` and `\PrintAddress` (`ltr.envlab`) |
| `\AtBeginDocument{\makemailing}` | postcards.cls:97 | yes | one `\makemailing` call at the start of the body, part of `ltr.formlett` |
| address database format | datasmp.txt:1-8 | yes (data) | records of name, address line with `\\`, opening and a blank line, held by `ltr.formlett`; hand-written data, no generator |

## Content-opaque
none (the address records in datasmp.txt:1-8 and the message text at pcardsmp.tex:37 are data and content held by the mailing way; no drawing, no `picture`, no `\special`)

## Lib changes
- New ways proposed: `ltr.formlett` `mailing` (CTAN, TeX Live, MiKTeX, LPPL 1.3c; Johannes L. Braams; v1.0d of 2026-01-02; read at ctan.org/pkg/mailing): macros for mail merging, one body text for many letters; `\usepackage{mailing}`, `\addressfile{file}`, `\mailingtext{body}` and `\makemailing`; engine pdf (the CTAN page states none, source not read). W1: on CTAN and in TeX Live. W2: behaviour is chosen by a file name and a body string, and the address records are data. W3: it serves any many-letters mailing. W4: preamble `\usepackage`, `\addressfile` and `\mailingtext`, and one `\makemailing` in the body. It is the same type as `ltr.formlett` (one letter body printed once per data record, a different package and record format), so the consolidator may fold it there with the package as the parameter.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
