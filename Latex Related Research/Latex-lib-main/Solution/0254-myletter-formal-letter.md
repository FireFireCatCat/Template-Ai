yes

# 0254-myletter-formal-letter: Myletter Formal Letter

- Unverified: read from the source, not compiled.
- Source: Source/0254-myletter-formal-letter/ (origin: https://latextemplates.com/downloads/myletter-formal-letter.zip; licence: LPPL-1.0-or-later per manifest; README.md:10 says CTAN lists LPPL 1 or later)
- Kind: letter
- Lib: v3
- Engine: pdfLaTeX-compatible (README.md:11 says compile with PDFLaTeX; main.tex:3-4 use T1 and utf8 only)
- Look carried by: mixed (the published `myletter` class lays the letter out; the zip-local `myletter.cfg` fills the class's letterhead boxes; main.tex sets the sender fields)
- Class origin: tex-distribution-unbundled (README.md:8 says the class is supplied by TeX Live and not bundled; ctan.org/pkg/myletter is its own CTAN entry, superseded by `akletter`, same sources)
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles all (the only zip-local file is `myletter.cfg`, 19 lines, read in full; the class itself is not in the zip)

## Verdict
Yes. The look is one published letter class (`myletter`, a wrapper that loads `akletter`) plus a 19-line configuration file that only assigns text, fonts and boxes to the class's letterhead save-boxes and its `\rightbox` hook. Every construct in that file is a kernel command (`\sbox`, `\parbox`, `\fontsize`, `\raisebox`, `\underline`, `\raggedright`), so it reduces to existing ways. There is no artwork, no zip-local class, no macro logic and no external tool.

## Blockers
none

## Class setting
- Class: `class.myletter` options: `a4paper`, `11pt` (main.tex:2). It is an alias: the TeX Live `myletter.cls` is `\LoadClass{akletter}` (local TinyTeX copy of myletter.cls:20, outside the zip, consulted for context, not zip evidence). Its native vocabulary is akletter's. No `class.akletter` is written, because the sample names `myletter`.
- Class-native vocabulary used: preamble `\name` (main.tex:6), `\signature` (7), `\telephone` (8), `\email` (9), `\subject` (10), `\usename{myletter}` (13, selects `myletter.cfg` as the class's configuration file); body `letter` environment with the recipient block as its argument (16), `\opening` (17), `\closing` (32), `\cc` (33), `\encl` (34). Inside the cfg: class boxes `\FIRM` `\firm` `\firmaddress` `\FIRMHEAD` `\firmreturn` (myletter.cfg:3-11), lengths `\leftfield` `\rightfield`, hook `\rightbox` (14), and registers `\fromname` `\telephonenum` `\@email` (16-18).
- Class options the sample does not use (from the TeX Live akletter.cls, outside the zip): `a4offset`, `letterpaper`, `refdate`, `subjectdate`, `rightdate`, `foldmarks`, `nofoldmarks`, `bankhigh`, `banklow`, `reverseaddr`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:2 | `class.myletter` | options a4paper, 11pt |
| paper and base size | main.tex:2 | `page.class-options` | a4paper, 11pt |
| encodings | main.tex:3, main.tex:4 | `font.fontenc-t1` | fontenc T1; inputenc utf8 |
| sender and letter fields | main.tex:6-10 | `ltr.opening` | `\name`, `\signature` (two lines split by `\\`), `\telephone`, `\email`, `\subject`: strings (content) |
| configuration file selection | main.tex:13 | `ltr.opening` | `\usename{myletter}`: the class then reads `myletter.cfg` (the emitter must write that file beside main.tex) |
| letter body wrappers | main.tex:16, 17, 32-35 | `ltr.opening` | `letter{recipient block}`, `\opening{...}`, `\closing{...}`, `\cc{...}`, `\encl{...}` |
| letterhead, left block (firm name) | myletter.cfg:3-4 | `ltr.opening` | `\sbox{\FIRM}` holding a `\parbox[t]{\leftfield}` of the firm name |
| letterhead, firm name in a box of the left field | myletter.cfg:3 | `box.minipage` | `\parbox[t]{\leftfield}` (also myletter.cfg:6, 14: `\parbox[t]{\rightfield}`) |
| letterhead, right block (address) | myletter.cfg:6-7 | `ltr.opening` | `\sbox{\firmaddress}`: three address lines |
| letterhead, assembled head | myletter.cfg:8 | `ltr.opening` | `\sbox{\FIRMHEAD}`: `\FIRM` plus `\firmaddress` raised 3mm |
| return-address line | myletter.cfg:9-11 | `ltr.opening` | `\sbox{\firmreturn}` of an underlined 7/8pt line, parts separated by `\,\textperiodcentered\,` |
| contact panel under the head | myletter.cfg:14-18 | `ltr.opening` | `\def\rightbox`: parbox of `\rightfield` width with sender name, "Telephone:" and "e-mail:" lines |
| running head text on later pages | myletter.cfg:5 | `hf.class-native` | `\sbox{\firm}`: 10/12pt firm name; the class places `\FIRMHEAD` on page one and `\firm` on later pages (placement read in the TeX Live akletter.cls, outside the zip) |
| font sizes inside the head | myletter.cfg:3, 5, 6, 9, 14 | `font.size-commands` | `\fontsize{15}{19pt}`, `{10}{12pt}`, `{9}{10pt}`, `{7}{8pt}`, `{9}{11pt}`, each with `\selectfont` |
| bold firm name, underlined return line | myletter.cfg:3, 9 | `mark.kernel` | `\bfseries`; kernel `\underline` (kernel inline marking, same family as `\emph`) |
| raise, thin space, line breaks | myletter.cfg:8, 10-11, 7, 16-17 | `sp.manual-space` | `\raisebox{3mm}`, `\,`, `\\`, `\\[1.5ex]` |
| ragged contact panel | myletter.cfg:15 | `sp.ragged` | `\raggedright` |
| body text | main.tex:19-30 | none | three paragraphs of plain text (content) |

Components the sample does not use and the zip does not define: headings, lists, quotes, notes, math, theorems, floats, tables, captions, code, boxes beyond the letterhead, bibliography, index, cross-references, language packages, colour, geometry changes. No `\usepackage` other than fontenc and inputenc (main.tex:3-4).

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `myletter.cfg` as a file | myletter.cfg:1-19 | yes | a class configuration file that only assigns `\sbox` boxes and one hook, no conditionals, no counters; emit it as a file beside main.tex (class option via `\usename{myletter}`, main.tex:13) or as the same lines in the preamble |
| `\sbox{\FIRM}`, `\sbox{\firm}`, `\sbox{\firmaddress}` | myletter.cfg:3-7 | yes | `ltr.opening` + `box.minipage` (parbox) + `font.size-commands` + `mark.kernel` + `sp.manual-space` |
| `\sbox{\FIRMHEAD}` | myletter.cfg:8 | yes | `\usebox` of two class boxes, `\raisebox{3mm}` (`sp.manual-space`) |
| `\sbox{\firmreturn}` | myletter.cfg:9-11 | yes | `\underline` over a 7/8pt line (`mark.kernel`, `font.size-commands`) |
| `\def\rightbox` | myletter.cfg:14-18 | yes | an alias of a fixed parbox: `box.minipage` + `font.size-commands` + `sp.ragged` + `sp.manual-space`, printing the class registers `\fromname`, `\telephonenum`, `\@email` that main.tex:6, 8, 9 fill; it replaces a hook the class's own example cfg defines (TeX Live akletter.cfg, outside the zip), and holds no logic of its own |
| `\makeatletter` ... `\makeatother` | myletter.cfg:2, 19 | yes | kernel catcode switch, only needed to read `\@email` |
| macros, counters, environments in main.tex | main.tex | none defined | main.tex has no `\newcommand`, `\def` or `\newenvironment` |

## Content-opaque
none (no figures, tables or pictures; the recipient block at main.tex:16 and the signature at main.tex:7 are text with `\\` breaks)

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes for reviewers
- The class is not in the zip, so the class source is not zip evidence. I consulted the TeX Live copy installed locally (TinyTeX `akletter` package: akletter.cls, akletter.cfg, myletter.cls) only to learn the class vocabulary and to check that `myletter.cls` exists as a TeX Live file; claims marked "outside the zip" rest on it. Two ctan.org pages were read (akletter, myletter): both are LPPL 1, in TeX Live, by Axel Kielhorn; myletter is listed as an old class superseded by akletter with the same sources.
- One thing to watch for a stricter reading: the cfg writes to the class's internal registers and the hook `\rightbox` by name. These names are the class's documented configuration interface (akletter.cls header says to put anything configurable in the cfg file), not hand-rolled layout code, so I rate the cfg reducible. If a reviewer decides that "reading a class register through `\makeatletter`" is bespoke, the verdict would be `no`; I judged it a plain composition of kernel commands.
- README.md carries no text addressed to an AI.
