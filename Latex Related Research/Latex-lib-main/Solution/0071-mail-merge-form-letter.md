yes

# 0071-mail-merge-form-letter: Mail-Merge Form Letter (formlett.sty)

- Unverified: read from the source, not compiled.
- Source: Source/0071-mail-merge-form-letter/ (origin: https://latextemplates.com/downloads/mail-merge-form-letter.zip; licence: GPL per the manifest; CTAN lists `formlett` as GNU GPL; the zip carries no licence file)
- Kind: letter
- Lib: v1
- Engine: pdfLaTeX-compatible (`fontenc` T1 and `inputenc` utf8 at main.tex:9-10; no fontspec, no Lua; `formlett` is on CTAN under macros/generic and its source was not read, so its engine behaviour is taken from the sample and the README only)
- Look carried by: preamble (the page is kernel `article` defaults plus one length at main.tex:12; the letter layout and the merge call sit in the body at main.tex:16-37; the merge machinery comes from the published, unbundled `formlett` package)
- Class origin: tex-distribution-unbundled (`article` is the kernel class, not bundled; the zip ships no `.cls` or `.sty`)
- Main file: main.tex (other samples: none; README.md is a note, not a sample)
- Read: main yes, zip-local classes and styles none present

## Verdict
The zip is a 39-line `main.tex` plus a README. It ships no class, no style and defines no macro, environment, counter or drawing of its own. It loads the kernel `article` class, two standard encoding packages and the published CTAN package `formlett` (also in TeX Live), sets one length, and uses formlett's wrappers and data block. An emitter can write `\usepackage{formlett}`, the `\beginletter ... \endletter` body wrapper with `\paras[n]` placeholders, and one `\moreletter fields!` line per recipient, using only published packages and kernel commands. I propose `ltr.formlett` for it, because no existing letter way merges one body over many records. The answer is `yes`. The formlett source and manual were not read (not in the zip, no local TeX tree), so the exact definition of `\NOPAGENUMBERS` and the field-index semantics are inferred from the sample.

## Blockers
none

## Class setting
- Class: `class.article` options: none (main.tex:8); default paper and 10pt
- Class-native vocabulary used: none of article's own front-matter commands. The sample uses no `\maketitle`, `abstract`, sectioning or `letter` environment. It uses the old font switch `\it` (main.tex:18), which the article class defines.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:8 | `class.article` | no options |
| paper and base size | main.tex:8 | `page.class-options` | defaults only (no `a4paper`, no `11pt`) |
| font and input encoding | main.tex:9-10 | `font.fontenc-t1` | fontenc=T1, inputenc=utf8; no font family package, so the default family stays |
| text width | main.tex:12 | `page.setlength` | `\textwidth=5.5in` (raw length assignment; margins left at article defaults) |
| mail-merge package | main.tex:11 | `ltr.formlett` | `\usepackage{formlett}`, no options |
| letter body wrapper | main.tex:16, 28 | `ltr.formlett` | `\beginletter` ... `\endletter` around the one shared letter body |
| field placeholders | main.tex:18, 19, 21-23 | `ltr.formlett` | `\paras[1]`, `\paras[n][2]` (n = 1, 2, 3), `\blockparas[2]`: index into the per-recipient data, set inline in running text |
| per-recipient data block | main.tex:30-37 (syntax described main.tex:3-6) | `ltr.formlett` | three `\moreletter` records, `;` between fields, `+` between sub-groups, `!` terminator; the values are content |
| page numbers off | main.tex:17 | `ltr.formlett` | `\NOPAGENUMBERS`; not defined in the zip or by article, so taken as formlett's (source not read). If it only sets the empty page style, the same effect is `hf.pagestyle-kernel`. |
| paragraph indent off | main.tex:17 | `sp.lengths` | `\parindent=0pt` |
| one paragraph unindented | main.tex:18 | `sp.lengths` | `\noindent` before the first paragraph (kernel paragraph control) |
| italic recipient name | main.tex:18 | `mark.kernel` | `{\it ...}` old-style shape switch, equal in effect to `\textit`/`\emph` |
| vertical skips between blocks | main.tex:19, 21, 25 | `sp.manual-space` | `\bigskip`, `\medskip` |
| signature pushed right | main.tex:26 | `sp.manual-space` | `\hfill` before "Membership Office" |
| vertical fill at the foot of each letter | main.tex:27 | `sp.manual-space` | `\vfill` |
| forced page end per letter | main.tex:27 | `pg.break` | `\eject` (plain-TeX forced break; one page per recipient, README.md:3-6) |

No headings, lists, floats, tables, maths, code, boxes, bibliography, language or hyperref setup appear in the zip.

## Bespoke code
none. main.tex has no `\newcommand`, `\def`, `\newenvironment`, counter or conditional. Every non-kernel control sequence (`\beginletter`, `\endletter`, `\moreletter`, `\paras`, `\blockparas`, `\NOPAGENUMBERS`) is read as formlett's, since the zip defines none of them.

## Content-opaque
none. The letter text (main.tex:18-26) and the three recipient records (main.tex:31, 34, 37) are content. The README (README.md:9-17) says formlett's own example uses a `\preview` call, a debug mode that boxes every placeholder; the sample omits it, and it would be a switch of the same way if used.

## Lib changes
- New ways proposed: `ltr.formlett` (section: doc-kind specific). Package `formlett` (CTAN macros/generic/formlett, in TeX Live, GNU GPL, v2.3 by Zhuhan Jiang; one read of ctan.org/pkg/formlett, which names no commands). Engine pdf (taken from the sample; source not read). Printed as `\usepackage{formlett}` and a body wrapper `\beginletter ... \endletter` carrying `\paras[n][m]` / `\blockparas[n]` placeholders, followed by one `\moreletter field;field+group;...!` line per recipient, plus `\NOPAGENUMBERS` and the `\preview` debug switch. W1: on CTAN and in TeX Live, with a user manual and a programmer's manual. W2: the result is chosen by index values and strings (fields, sub-groups, a terminator) and a debug switch, no code is edited. W3: serves a kind of component (one letter body repeated once per recipient from a data list), not this one document, and works under any class. W4: one preamble line plus a body wrapper around the letter node and a data block after it. Checked first: `ltr.opening` covers `\opening`/`\closing`/letterhead and has no merge; `ltr.envlab` is envelopes and label sheets; `ticket.sheet` imposes tickets on a sheet; `label.flabels` (proposed in 0024) is a spine label. None multiplies one body over records.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
