no

# 0095-fax-cover-sheet: Fax Cover Sheet

- Unverified: read from the source, not compiled.
- Source: Source/0095-fax-cover-sheet/ (origin: https://latextemplates.com/downloads/fax-cover-sheet.zip; licence: LPPL-1.2 per manifest)
- Kind: letter
- Lib: v1
- Engine: pdfLaTeX-compatible (T1 `fontenc` and `lastpage` only, main.tex:10-11; no `fontspec`)
- Look carried by: class (the boxed to/from header, running head and page-count wording all live in `facsimile.cls`, which is not in the zip; the preamble adds only one compatibility patch, main.tex:26-32)
- Class origin: tex-distribution-unbundled (`facsimile` by Torsten Bronger, v1.0, 2003, LPPL 1.2, on CTAN and in TeX Live; one read of https://ctan.org/pkg/facsimile; the zip ships no `.cls`, `ls -la` shows only `README.md` and `main.tex`)
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present (the class source was not available and not read; its vocabulary below is taken from the sample's calls and comments only)

## Verdict
no. The look is a published class (`facsimile`), and every body construct the sample uses is class vocabulary or a kernel command, so the template itself would map cleanly. The sample's preamble, however, carries a hand-written macro that overrides a private internal of the class (`\@lstpgno`), built from a delimited-argument parser (`\f@x@secondgroup`) that reads the fields of the `\r@LastPage` label (main.tex:26-32). No lib way expresses it, and by the README and comment the class does not produce its page count without it, so it is irreducible `BESPOKE/preamble`. If a re-reading treats this as a build-pipeline workaround rather than template content, the zip would otherwise be a class-only `yes`; that cannot be shown from the unread class source, so it stays `no`.

## Blockers
- `BESPOKE/preamble` redefinition of the class internal `\@lstpgno` through a delimited-argument extractor over `\r@LastPage` (main.tex:26-32; rationale in README.md:7-22)

## Class setting
- Class: `class.facsimile` options: `english`, `12pt` (main.tex:9). `english` is a language option the class takes (its handling is in the unread class source; the CTAN page says the class has language support); `12pt` is the kernel size option.
- Class-native vocabulary used: `\makefaxtitle` (boxed header page start, main.tex:42); `\faxto{...}`, `\faxfrom{...}` (multi-line strings with `\\`, main.tex:35-36); `\faxsubject[short]{long}` (main.tex:37); `\faxnotetext` (renewed to set the note-box text, main.tex:38-39); `\author` (printed as the "from" name in the running header, main.tex:34); `\opening{...}` and `\closing{...}` (letter primitives, main.tex:44, 51; main.tex:7-8); the `fancy` page style (main.tex:54); the page-count line resolved with `\pageref{LastPage}` and the singular/plural word picked by `\ifcase\@lstpgno` (main.tex:5-6, 15-16; README.md:14-17).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class | main.tex:9 | `class.facsimile` | options english, 12pt |
| page size / font size | main.tex:9 | `page.class-options` | 12pt; paper size is the class default (unread) |
| language | main.tex:9 | `class.facsimile` | option `english`; handling inside the class, unread |
| font encoding | main.tex:10 | `font.fontenc-t1` | `fontenc` with option T1 |
| page X of Y / last page | main.tex:11; main.tex:5-6 | `pgnum.lastpage` | `lastpage` loaded; label `LastPage` read through `\pageref{LastPage}` by the class |
| fax header block (to, from, subject, date, page count, note box) | main.tex:34-39, 42 | `front.class-native` | `\faxto`, `\faxfrom`, `\faxsubject[short]{long}`, `\faxnotetext`, `\makefaxtitle`; strings with `\\` line breaks |
| running head on every page (from name, page count) | main.tex:34, 54 | `hf.class-native` | `\author` string feeds the head; `fancy` page style named at main.tex:54 (the class presumably loads `fancyhdr`; unread) |
| page style switch | main.tex:54 | `hf.pagestyle-kernel` | `\thispagestyle{fancy}` on the second page |
| letter opening and closing | main.tex:44, 51 | `ltr.opening` | `\opening{Chris,}`, `\closing{Thanks,}` |
| body paragraphs | main.tex:46-49, 57-59 | none (content) | plain text |
| page break | main.tex:53 | `pg.break` | `\newpage` |
| bold run-in line | main.tex:55 | `mark.kernel` | `\textbf` |
| page-count wording (page / pages) | main.tex:15-16, 28-31 | `front.class-native` | class picks the word with `\ifcase\@lstpgno`; the zip overrides `\@lstpgno` (see Bespoke code) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\f@x@secondgroup#1#2#3\@nil` (takes the second brace group) and `\renewcommand*{\@lstpgno}` with `\@ifundefined{r@LastPage}{0}{...}` | main.tex:26-32 | No | Overrides a private internal of the class with hand-rolled macro logic that parses the `\newlabel` field layout and drives the printed page number and the singular/plural word. It is not a composition of lib ways: `pgnum.lastpage` only writes the label, and the broken part is the class's own reader. Irreducible, scope preamble. |
| `\renewcommand{\faxnotetext}{...}` | main.tex:38-39 | Yes | Sets a string in class vocabulary: `front.class-native` with the note text as the parameter (assuming, as the sample does, that the class defines `\faxnotetext` as a text hook; class unread). |
| `\makeatletter` / `\makeatother` | main.tex:26, 32 | Yes | Scoping for the patch above; no effect of its own. |
| `\author`, `\faxto`, `\faxfrom`, `\faxsubject` calls | main.tex:34-37 | Yes | Class commands with string arguments; not definitions. |

## Content-opaque
none

## Lib changes
- New ways proposed: none (`class.facsimile` is written plainly as a class way; the lib's class section is filled by script)
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- The class source (`facsimile.cls`) was not in the zip and not read. Everything under Class-native vocabulary is inferred from the sample's calls and its own comments (main.tex:1-8). Whether the class loads `fancyhdr`, `babel` or other packages is not established here.
- The patch comment and README claim the 2003 class fails on the current LaTeX kernel without the patch (main.tex:13-25; README.md:7-22). That is the zip author's statement, read as data, not checked.
- Nothing in the zip is addressed to an AI.
