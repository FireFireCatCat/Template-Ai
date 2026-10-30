yes

# 0266-letter-of-notice: Letter of Notice

- Unverified: read from the source, not compiled.
- Source: Source/0266-letter-of-notice/ (origin: https://latextemplates.com/downloads/letter-of-notice.zip; licence: MIT)
- Kind: letter
- Lib: v3
- Engine: needs XeLaTeX (`fontspec` and `polyglossia` loaded unconditionally, main.tex:15 and main.tex:18; the author says so at main.tex:9-11)
- Look carried by: mixed (published KOMA `scrartcl` + `scrletter` default letter layout, a zip-local `.lco` that sets the letterhead, and a short preamble for fonts, language and one page-length change)
- Class origin: tex-distribution-unbundled (`scrartcl` and `scrletter` are KOMA-Script, not in the zip; the one zip-local file is a `.lco` settings file, not a class)
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles all (the only zip-local file, `letter-of-notice-sender.lco`, 34 lines, read in full; no `.cls` or `.sty` in the zip; KOMA and `changepage` sources are not in the zip and were not read)

## Verdict
Yes. The body uses only the KOMA `letter` environment with `\opening` and `\closing`. The look is KOMA's default letter layout plus a preamble of published packages (`fontspec`, `libertine`, `microtype`, `polyglossia`, `csquotes`, `changepage`) and a `.lco` file. The `.lco` holds only `\KOMAoptions`, `\setkomavar`, `\setkomafont`, one `\definecolor`, one `\renewcommand` of a documented KOMA hook and one pseudo-length setter, so it reduces to lib ways with parameters. There is no `\newcommand`, `\def`, environment, counter, drawing or external tool anywhere. Engine is XeLaTeX-only, which is recorded and not a blocker.

## Blockers
none

## Class setting
- Class: `class.scrartcl` options: `paper=a4`, `fontsize=11pt` (main.tex:14); KOMA `typearea` runs at its defaults (no `DIV` or `BCOR` given). The letter machinery comes from the package `scrletter` (main.tex:24), not from `scrlttr2` as a class.
- Class-native vocabulary used: `\usepackage{scrletter}` and `\LoadLetterOption{...}` (main.tex:24-25); `\setkomavar{subject|place|date}` (main.tex:30-32); `letter` environment with the recipient address as its argument, rows split by `\\` (main.tex:37-42); `\opening{}` (main.tex:44); `\closing{}` (main.tex:67). In the `.lco`: `\KOMAoptions{foldmarks, fromurl, fromemail, fromphone, fromfax, fromalign, fromrule, footsepline}` (letter-of-notice-sender.lco:9-18); `\setkomavar{fromname|fromaddress|fromphone|fromemail|backaddress|signature}` (lines 22, 24, 26-28, 30); `\setkomafont{fromname|fromaddress}` (lines 23, 25); `\raggedsignature` (line 31); pseudo-length `sigbeforevskip` through `\@setplength` (line 32).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:14 | `class.scrartcl` | options `paper=a4`, `fontsize=11pt` |
| paper and base size | main.tex:14 | `page.class-options` | `paper=a4`, `fontsize=11pt`; typearea defaults, nothing set |
| page text block changed by hand | main.tex:21, main.tex:27 | `page.adjustwidth` | package `changepage`, its command `\changepage` (same package as the lib line): `{+2cm}{}{}{}{}{}{}{}{-3cm}`; by `changepage`'s nine-argument order as I recall it (source not in the zip, not read) these are text height +2cm and footskip -3cm, although the comment at main.tex:3-5 says "widen the margins". If a reviewer rules `\changepage` is not the same type as `adjustwidth`, the fallback is `page.setlength` (`\addtolength` of `\textheight` and `\footskip`); both ways exist, so no proposal either way |
| engine font loader | main.tex:15 | `font.fontspec` | `\usepackage{fontspec}`, no `\setmainfont` call |
| text typeface | main.tex:16 | `font.libertine` | `\usepackage{libertine}`, no options |
| default family is sans | main.tex:28 | `font.family-default` | `\renewcommand{\familydefault}{\sfdefault}` |
| microtypography | main.tex:17 | `sp.microtype` | defaults |
| language | main.tex:18-19 | `lang.polyglossia` | `\setdefaultlanguage{english}` |
| quotes package | main.tex:22 | `lang.csquotes` | loaded, no `\enquote` or quote macro used in the body |
| letter machinery | main.tex:24-25 | `ltr.opening` | `scrletter` package; `\LoadLetterOption{letter-of-notice-sender}` |
| letter variables | main.tex:30-32 | `ltr.opening` | `subject` = "Notice to Vacate --- 14 Kirkland Terrace, Flat 3", `place` = Edinburgh, `date` = `\today` |
| letter body frame | main.tex:37-44, main.tex:67-69 | `ltr.opening` | `letter` env with 4-line recipient address, `\opening{Dear Property Management Team,}`, `\closing{Yours sincerely,}` |
| letterhead options | letter-of-notice-sender.lco:9-18 | `ltr.opening` | `foldmarks=true`, `fromurl=false`, `fromemail=true`, `fromphone=true`, `fromfax=false`, `fromalign=right`, `fromrule=off` |
| letterhead content | letter-of-notice-sender.lco:22, 24, 26-28 | `ltr.opening` | `fromname`, `fromaddress` (two rows), `fromphone[]`, `fromemail[]` (empty labels), `backaddress` |
| letterhead fonts | letter-of-notice-sender.lco:23, 25 | `ltr.opening`, `mark.kernel`, `font.size-commands`, `color.xcolor` | `\setkomafont{fromname}{\bfseries\Large}`; `\setkomafont{fromaddress}{\small\slshape\color{noticegray}}` (KOMA font element of a letter field, so filed under the letter way, not `head.koma-fonts`) |
| signature block | letter-of-notice-sender.lco:30-32 | `ltr.opening`, `sp.ragged` | `signature` = Tobias Lindqvist; `\raggedsignature` = `\raggedright`; pseudo-length `sigbeforevskip` = 1.6cm |
| footer rule | letter-of-notice-sender.lco:17 | `hf.class-native` | `footsepline=off` (a letter-class option; the footer itself is the class default) |
| custom colour | letter-of-notice-sender.lco:7, 20 | `color.xcolor` | `\definecolor{noticegray}{gray}{.45}` |
| symbol package | letter-of-notice-sender.lco:6 | `font.icons` | `\RequirePackage{marvosym}`; loaded, no marvosym command is used anywhere in the zip |
| paragraph indent | main.tex:34, main.tex:52 | `sp.lengths` | `\parindent` 0pt in the preamble, then 20pt before the second body paragraph |
| body paragraphs | main.tex:46-65 | content | plain paragraphs |

No headings, lists, tables, floats, maths, theorems, code, boxes, footnotes, bibliography, index, table of contents or abstract are used in the sample, so no way is needed for them.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `letter-of-notice-sender.lco` (whole file, a letter-class-option file) | letter-of-notice-sender.lco:4-34 | yes | its whole content is `\KOMAoptions`, `\setkomavar`, `\setkomafont`, `\definecolor`, one `\renewcommand` and one pseudo-length setter plus two `\RequirePackage`s; an emitter writes the same calls as preamble lines after `\usepackage{scrletter}`, or ships the file and keeps `\LoadLetterOption`. Ways: `ltr.opening`, `color.xcolor`, `font.icons`, `hf.class-native`, `sp.ragged` |
| `\@setplength{sigbeforevskip}{1.6cm}` | letter-of-notice-sender.lco:32 | yes | a documented KOMA pseudo-length setter taking a name and a length; a declarative parameter of `ltr.opening`. It uses `@`, so printed in a main preamble it sits between `\makeatletter` and `\makeatother` (KOMA also has a document-level `\setplength`; not verified here, no local TeX) |
| `\renewcommand*{\raggedsignature}{\raggedright}` | letter-of-notice-sender.lco:31 | yes | redefines a documented KOMA hook with a kernel alignment switch: `ltr.opening` with `sp.ragged` |
| `\definecolor{noticegray}{gray}{.45}` | letter-of-notice-sender.lco:20 | yes | `color.xcolor`, one named grey |

main.tex defines no `\newcommand`, `\def`, environment, counter or conditional.

## Content-opaque
none

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- The comment block at main.tex:1-13 describes the template's origin (derived from jgehrcke/latex-briefvorlage) and its XeLaTeX-only design; it holds nothing addressed to an AI. main.tex:11 mentions an `engine.txt`, which is not in the zip (the manifest lists two files).
- `marvosym` (lco:6) and `csquotes` (main.tex:22) are loaded but never used by the sample, so they carry no visible look; they are listed so nothing is hidden.
- No fonts or images are shipped; `libertine`, `marvosym` and the OTF files that `libertine` finds through `fontspec` come from the TeX distribution (main.tex:11-13). Missing assets are not a blocker.
