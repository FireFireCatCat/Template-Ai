yes

# 0060-resumecls: resumecls (bilingual English/Chinese CV class)

- Unverified: read from the source, not compiled.
- Source: Source/0060-resumecls/ (origin: https://latextemplates.com/downloads/resumecls.zip; licence: LPPL-1.3 per the manifest, and ctan.org/pkg/resumecls lists LPPL 1.3 for the class)
- Kind: cv
- Lib: v1
- Engine: needs XeLaTeX (the class lives under CTAN `macros/xetex/latex/resumecls` per ctan.org/pkg/resumecls; the sample's own comment says "XeLaTeX + CJK", main.tex:1-2; the class source is not in the zip and was not read, so this is not confirmed from code). CJK fonts are not shipped (missing assets, not a blocker).
- Look carried by: class (the zip is one 68-line `main.tex` that loads the published class `resumecls` and uses only its commands; it defines nothing of its own)
- Class origin: tex-distribution-unbundled (ctan.org/pkg/resumecls read once: on CTAN, v0.4.1, author huxuan, LPPL 1.3, "Included in" TeX Live and MiKTeX; the zip ships no `.cls`)
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present (the zip has no `.cls`, `.sty`, `.def`, `.cfg`, `.clo`; the class source of `resumecls` was NOT read, so everything below about its internals is inferred from how the sample calls it)

## Verdict
`yes`. The only file is `main.tex`, which loads the published class `resumecls` with the option `color` and then calls that class's own commands (`\name` ... `\homepage`, `\leftfooter`, `\rightfooter`, `\maketitle`, `\heading`, `\entry`). It has no `\newcommand`, `\def`, environment, counter, `\usepackage` or artwork (grep of main.tex found none), and needs no tool outside TeX. The whole look is therefore the one way `class.resumecls` plus its parameters. Caveat: the class internals were not read, so this is evidence about the class dimension, not about the component ways, and whether the class hides irreducible code is unknown (that does not count against the zip under the rubric's published-class ruling).

## Blockers
none

## Class setting
- Class: `class.resumecls` options: `color` (main.tex:4); no other option.
- Class-native vocabulary used: info slots `\name`, `\organization`, `\address`, `\mobile`, `\mail`, `\homepage` (main.tex:6-11); footer slots `\leftfooter`, `\rightfooter` (main.tex:12-13); `\maketitle` (main.tex:19); section command `\heading{...}` (main.tex:21,31,46,54,61); row command `\entry{<indent>}{<column spec>}{<cells separated by & and \\>}` (main.tex:22-65). The indent argument takes `0em`, `2em`, `4em`; the column-spec argument takes the letters `X`, `l`, `r` (`Xrr`, `lXX`, `Xr`, `X`, `lX`), which are `tabularx` column letters; that the class builds `\entry` on `tabularx` is inferred, not read.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:4 | `class.resumecls` | option `color` |
| title block | main.tex:6-11,19 | `front.class-native` | `\name{Wei Zhang \quad 张伟}`, `\organization{Tsinghua University}`, `\address{Beijing, China}`, `\mobile{+86 138 0013 8000}`, `\mail{...}`, `\homepage{https://weizhang.example.com}`, printed by `\maketitle` |
| footer fields | main.tex:12-13 | `hf.class-native` | `\leftfooter{Last Modified: \today}` (kernel `\today`), `\rightfooter{\url{...}}` |
| CJK and date language | main.tex:15,6 | `lang.cjk` | `\ctexset{today=old}`: a `ctex` key (ctan.org/pkg/ctex read once: on CTAN and in TeX Live, works with pdfLaTeX, XeLaTeX, LuaLaTeX; that page does not mention `\ctexset` or `today`, so the key's meaning, "keep the original LaTeX `\today`", is from memory of the ctex manual, not read here). The Chinese run `张伟` at main.tex:6 needs this support. |
| section headings | main.tex:21,31,46,54,61 | `head.class-native` | `\heading{Education}`, `{Working Experience}`, `{Research Experience}`, `{Professional Skill}`, `{Publications}`; look set by the class (option `color` presumably tints it: not read) |
| CV rows | main.tex:22-65 | `cv.entries` | 15 calls of `\entry`; indent levels `0em` (a row's headline), `2em` (sub-line), `4em` (description); column specs `Xrr` (institution, place, years), `lXX` (degree, department, field), `Xr` (employer, years), `X` (one wide cell), `lX` (skill label, list); cells joined with `&`, row ends `\\` |
| table float wrapper | main.tex:18,67 | `tbl.tabular` | kernel `table` environment with no caption and no placement option, wrapping `\maketitle` and every `\heading`/`\entry` to the end; no lib way names a bare kernel float (0015 mapped it to `tbl.tabular` too). Whether `resumecls` changes `table` is unknown (class unread). |
| URL display | main.tex:13 | `meta.url` | `\url{https://weizhang.example.com/resume.pdf}`; the sample loads no package, so the class (unread) must load `url` or `hyperref` |
| text shapes | main.tex:22,26,32,39,47,63 | `mark.kernel` | `{\bfseries ...}` on institution and employer names, `\textit{...}` on the publication title |
| manual spacing and breaks | main.tex:6,33,40,51 | `sp.manual-space` | `\quad` in the name and in position lines, `\\` row ends, `\ ` after `Prof.` |

## Bespoke code
none. main.tex holds no `\newcommand`, `\renewcommand`, `\def`, `\newenvironment`, `\newcounter`, `\makeatletter`, `\usepackage`, `\input` or `\include` (grep). The class itself is published (class origin above), not bespoke.

## Content-opaque
none. The Chinese string at main.tex:6 is text content (it needs the `lang.cjk` way and a CJK font, noted above). No figure, picture, image or equation is in the sample. The Publications entry (main.tex:62-65) is a hand-typed line inside `\entry`, not a `thebibliography`, so no `bib.*` way is used.

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

Notes: nothing in the zip is addressed to an AI (the comment at main.tex:1-3 only describes the class; its claim "built on ctexart" is not confirmed by the CTAN page, which names no base class). Two of three allowed CTAN reads used (resumecls, ctex). Missing assets: CJK fonts (not shipped; XeLaTeX with ctex needs a Chinese font on the machine).
