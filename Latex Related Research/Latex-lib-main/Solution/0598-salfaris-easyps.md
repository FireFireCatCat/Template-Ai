yes

# 0598-salfaris-easyps: EasyPS (personal statement framework)

- Unverified: read from the source, not compiled.
- Source: Source/0598-salfaris-easyps/ (origin: https://codeload.github.com/salfaris/EasyPS/zip/refs/heads/main, repo https://github.com/salfaris/EasyPS as named at main/easyps.cls:3; licence: BSD-3-Clause, main/easyps.cls:1 and LICENSE.md:1)
- Kind: misc (a university-application personal statement; the manifest hint is also misc)
- Lib: v5
- Engine: pdfLaTeX-compatible (article, mathptmx, geometry, lipsum; nothing needs XeLaTeX or LuaLaTeX)
- Look carried by: zip-local (main/easyps.cls:8-18 and 39-46 define the whole look; the sample's preamble sets only strings and one true/false flag, main/example.tex:7-12)
- Class origin: zip-local (a one-author GitHub class; ctan.org/pkg/easyps returned 404; no publisher kit)
- Main file: main/example.tex (other samples: main/main.tex; body files main/content/cambridge.tex, main/content/imperial.tex, main/content/oxford.tex)
- Read: main yes, zip-local classes and styles all (main/main.pdf, a built PDF, was not opened; docs/example.png, a README screenshot, was viewed as an image and not used as verification)

## Verdict
The zip is a 64-line zip-local class, `main/easyps.cls`, that is `\LoadClass[12pt]{article}` plus `mathptmx`, `geometry`, `\parskip`, `\linespread` and a one-paragraph centred bold title; the samples only set a name, a course name, a file name and a true/false flag, then `\input` a file holding `\lipsum[1-6]`. Every zip-local macro (the three field setters, the `\@maketitle` redefinition, the `\generateTitle` switch) reduces to lib ways or to inline expansion of values the emitter already knows, so no copied macro logic is needed. There is no artwork, no external tool and no unmapped component, so the answer is `yes`; the look is carried by a zip-local class and nothing was compiled. Judgment call: a stricter reading of "conditionals that drive what is printed" could count the `\showTitle` switch as bespoke, but its value is a literal in the preamble, so the emitter resolves it and no conditional survives in the output.

## Blockers
none

## Class setting
- Class: `class.article` options: `12pt` (passed by the zip-local wrapper, main/easyps.cls:8; the sample calls `\documentclass{easyps}`, main/example.tex:5). The wrapper declares no options of its own (no `\DeclareOption` or `\ProcessOptions` in main/easyps.cls).
- Class-native vocabulary used: `\title` and `\maketitle` only (main/easyps.cls:35-37, 54). The sample uses no `abstract`, no sectioning commands, no bibliography. easyps's own commands are the bespoke field setters listed under Bespoke code.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main/easyps.cls:8; main/example.tex:5 | `class.article` | 12pt |
| paper and base size | main/easyps.cls:8, 16 | `page.class-options` | 12pt (the paper size `a4paper` goes to geometry, next row) |
| page geometry | main/easyps.cls:13, 16 | `page.geometry` | a4paper, margin=1in |
| text and math font | main/easyps.cls:12 | `font.mathptmx` | `mathptmx`, no options (Times-like text and maths) |
| paragraph skip | main/easyps.cls:17 | `sp.lengths` | `\parskip` = 0.5em; `\parindent` left at the article default (not set anywhere in the zip) |
| line spacing | main/easyps.cls:18 | `sp.linespread` | `\linespread{1.}` |
| header and footer | no call in the zip; inherited from main/easyps.cls:8 | `hf.pagestyle-kernel` | article default page style `plain` (page number at the foot); stock `\maketitle` adds `\thispagestyle{plain}` |
| title text | main/easyps.cls:35-37 | `front.maketitle` | `\title{<student> --- Personal Statement for <course>}`; no `\author` or `\date` is set or printed |
| title block look | main/easyps.cls:39-46 | `front.titling` | `\@maketitle` prints only the title: `center` environment (main/easyps.cls:40, 45), `\parskip\baselineskip` and `\parindent=0pt` (lines 41-43), `\bf\@title\par` (line 44); reduction under Bespoke code |
| title block centring | main/easyps.cls:40, 45 | `sp.ragged` | kernel `center` environment (same family as `\centering`) |
| title block lengths | main/easyps.cls:41-43 | `sp.lengths` | `\parskip` = `\baselineskip`, `\parindent` = 0pt, local to the title group |
| title font | main/easyps.cls:44 | `mark.kernel` | `\bf` (legacy kernel bold switch; same family as `\bfseries`) |
| title shown or hidden | main/easyps.cls:48-61; main/example.tex:12, 29 | `front.maketitle` | boolean `showTitle`: true calls `\maketitle` (line 54), false prints nothing; decided at emit time |
| body file inclusion | main/easyps.cls:64; main/example.tex:30; main/main.tex:19 | `struct.input` | `\input{content/cambridge.tex}`: directory string `content`, file name from `\psForUniversity` (main/example.tex:10) |
| filler body text | main/content/cambridge.tex:2; main/content/imperial.tex:2; main/content/oxford.tex:2; package at main/easyps.cls:11 | `draft.todo` | `lipsum` loaded unconditionally; `\lipsum[1-6]` (filler content) |
| sectioning, lists, floats, tables, captions, maths, theorems, code, boxes, bibliography, index, cross-references, notes, abstract, contents | not used by any sample file | none | the zip defines nothing for these; article defaults apply and the sample does not exercise them |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\courseName`, `\@courseName` | main/easyps.cls:21-24 | yes | `\def` plus `\newcommand*` that store one string; inline the string into the title text (`front.maketitle`) |
| `\studentName`, `\@studentName` | main/easyps.cls:26-29 | yes | same: a stored string, inlined into the title text |
| `\psForUniversity`, `\@psForUniversity`, `\uniName` | main/easyps.cls:31-33 | yes | a stored file name; inlined into `\input{content/<file>}` (`struct.input`) |
| `\title{...}` built from the stored strings | main/easyps.cls:35-37 | yes | `\title{Sal Faris --- Personal Statement for MPhil in Advanced Computer Science}`; the stored strings expand when `\@title` is typeset, so inline expansion gives the same text (`front.maketitle`); line 36 ends in a control space, a trailing blank with no visible effect |
| `\renewcommand{\@maketitle}` | main/easyps.cls:39-46 | yes | `front.titling` with `\pretitle{\begin{center}\parskip\baselineskip\parindent=0pt\bf}`, `\posttitle{\par\end{center}}`, `\author{}`, `\date{}` and empty `\preauthor` `\postauthor` `\predate` `\postdate`. Exact fallback with kernel commands only: emit the body wrapper `\begin{center}\parskip\baselineskip\parindent=0pt\bf <title>\par\end{center}` in place of `\maketitle` (`sp.ragged`, `sp.lengths`, `mark.kernel`). The zip's version has no leading `\newpage\null\vskip` and no trailing skip as in stock article; the `titling` route would match that through `\droptitle` and the post-hooks, which was not checked. The redefinition is not an irreducible kernel rewrite: its whole effect is one centred bold paragraph. |
| `\showTitle`, `\@showTitle`, `\generateTitle` (`\ifx` against `\@trueText`, `\@falseText`, `\ClassError` on any other value) | main/easyps.cls:48-61 | yes | a document-level boolean with two branches, `\maketitle` or nothing; the emitter picks the branch when it writes the body (sample value `true`, main/example.tex:12). The `\ClassError` branch (line 58) is input validation with no typeset effect. It is not a layout algorithm and drives no counter. |
| `\contentdir` | main/easyps.cls:64 | yes | the string `content`; inlined into the `\input` path |
| the class as a whole | main/easyps.cls:5-64 | yes | `\documentclass[12pt]{article}`, `\usepackage{lipsum}`, `\usepackage{mathptmx}`, `\usepackage[a4paper,margin=1in]{geometry}`, `\setlength{\parskip}{0.5em}`, `\linespread{1.}`, the title reduction above; no `\def` or conditional is copied into the output |

## Content-opaque
none (the only body text is `\lipsum[1-6]` filler, held by `draft.todo`; the zip has no figure, table or picture)

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
