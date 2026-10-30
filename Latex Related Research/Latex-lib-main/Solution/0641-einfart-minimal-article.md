yes

# 0641-einfart-minimal-article: einfart Minimal Article

- Unverified: read from the source, not compiled.
- Source: Source/0641-einfart-minimal-article/ (origin: https://latextemplates.com/downloads/einfart-minimal-article.zip; licence: LPPL-1.3c)
- Kind: misc (a bare article starter; the manifest hint is `article`)
- Lib: v5
- Engine: needs XeLaTeX or LuaLaTeX (the class `einfart` is fontspec-based and loads `ctex`: main.tex:20-23, README.md:6, CTAN page ctan.org/pkg/einfart)
- Look carried by: class (the sample sets no package, length or font; the single line `\documentclass{einfart}` at main.tex:24 defines the look)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
The zip is three files (main.tex, README.md, references.bib) and holds no `.cls`, `.sty` or other class file; the class is left out on purpose (main.tex:4-7, README.md:7). The whole look comes from one published class, `einfart` (CTAN and TeX Live, LPPL 1.3c, Jinwen XU, version 2026-02-20; the CTAN page says it loads `minimalist.sty` and compiles with XeLaTeX or LuaLaTeX), loaded with no options (main.tex:24) and followed by kernel commands only: title block, abstract, `\section`, `equation`, BibTeX with `plain`. There is no zip-local macro, no artwork and no tool outside TeX (BibTeX ships with TeX), so every component is a lib way and nothing is bespoke. This is evidence about the class dimension (`Look carried by: class`), not about the component ways. Residual risk: the `einfart` source and `minimalist.sty` were not read (the class is not in the zip), so what the class loads internally rests on README.md:19-27, the sample comments and the CTAN pages of `einfart` and `minimalist` (neither names a shell-escape or other external-tool package). No text addressed to an AI was found in the zip.

## Blockers
none

## Class setting
- Class: `class.einfart` options: none (main.tex:24). README.md:19-21 calls it a typography and font layer over plain `article` with no title-page or theorem machinery of its own; the CTAN page documents no class options and says it depends on `minimalist.sty` of the same series. Its source was not read.
- Class-native vocabulary used: none beyond `article`'s own: `\title` `\author` `\date` `\maketitle` (main.tex:26-28, 32), `abstract` environment (main.tex:34-37), `\section` (main.tex:39, 45, 51, 60). The sample calls no keyword, subject, affiliation or bibliography-style command that belongs to the class.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:24 | `class.einfart` | no options; XeLaTeX or LuaLaTeX |
| page geometry, spacing, running heads, heading look | not set by the sample; class defaults (main.tex:24, README.md:19-21) | `class.einfart` | defaults only; the class source was not read, so no value is recorded |
| text font | main.tex:41-43, README.md:26-27 | `font.fontspec` | TeX Gyre Pagella as the default body face, chosen inside the class through `fontspec` (stated by README.md and a sample comment, not read from `einfart.cls`); the sample sets nothing, so an emitter adds no line |
| CJK support | main.tex:47-49, README.md:22-25 | `lang.cjk` | `ctex` loaded unconditionally by the class (main.tex:47, README.md:22), no options in the sample; the Chinese sentence at main.tex:49 is content |
| title block | main.tex:26-28, 32 | `front.maketitle` | `\title{Your Title Here}`, `\author{Ada Lovelace}`, `\date{\today}`, `\maketitle` |
| abstract | main.tex:34-37 | `abs.kernel` | kernel `abstract` environment, plain text, no keywords line |
| sectioning | main.tex:39, 45, 51, 60 | `head.kernel` | `\section` only, numbered, no `\renewcommand` and no `\titleformat` |
| inline mark | main.tex:47 | `mark.kernel` | `\texttt{ctex}` |
| display equation | main.tex:54-57 | `math.kernel` | `equation` environment with `\label{eq:main}` |
| equation reference | main.tex:58 | `math.amsmath` | `\eqref` is an amsmath command and the sample loads no package, so the class or the emitter supplies amsmath (inferred, class source not read) |
| labels and references | main.tex:46, 52, 55 | `xref.kernel` | `\label{sec:cjk}` `\label{sec:math}` `\label{eq:main}`; the two section labels are never referenced |
| citation | main.tex:40 | `bib.bibtex-bst` | kernel `\cite{knuth1984texbook}`, no natbib |
| bibliography | main.tex:63-64, references.bib:1-6 | `bib.bibtex-bst` | `\bibliographystyle{plain}`, `\bibliography{references}`; one `@book` entry (content) |

Not used by the sample: lists, floats, tables, captions, theorems, code, boxes, footnotes, contents, index, appendix, colour, hand-set headers and footers.

## Bespoke code
none. The sample defines no macro, environment, counter or conditional (main.tex:24-66), and the zip holds no class or style file.

## Content-opaque
none (the Chinese sentence at main.tex:49 and the equation at main.tex:56 are content, held by `lang.cjk` and `math.kernel`)

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
