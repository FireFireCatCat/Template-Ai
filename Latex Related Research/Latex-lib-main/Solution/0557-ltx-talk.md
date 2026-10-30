yes

# 0557-ltx-talk: ltx-talk (a four-frame sample deck for the CTAN class `ltx-talk`)

- Unverified: read from the source, not compiled.
- Source: Source/0557-ltx-talk/ (origin: https://latextemplates.com/downloads/ltx-talk.zip; licence: LPPL-1.3c per the manifest; the zip holds no licence file)
- Kind: presentation
- Lib: v4
- Engine: pdfLaTeX-compatible (the sample itself says "the class does not require a specific engine", main.tex:34-35; the CTAN page names no engine; the class source was not read; CTAN says the class requires LaTeX 2025-11-01 or later)
- Look carried by: class (main.tex sets no package, option, theme, template, colour, font or length; the whole look is the default of the published class `ltx-talk`)
- Class origin: tex-distribution-unbundled (ltx-talk is on CTAN, v0.6.10, maintainer Joseph Wright, LPPL 1.3c, included in TeX Live and MiKTeX, read at ctan.org/pkg/ltx-talk; the zip contains no `.cls`)
- Main file: main.tex (other samples: none; the zip is the single 38-line file)
- Read: main yes, zip-local classes and styles none present

## Verdict
Yes. The zip is one 38-line sample that loads the published class `ltx-talk` (main.tex:3) with no options and adds only content: a title, an author, four frames, two bulleted lists (one with the overlay argument `[<+->]`) and one text paragraph. There is no zip-local class, style, macro, environment, counter or artwork (the zip holds only main.tex; a grep of it finds no `\newcommand`, `\def`, `\newenvironment`, `\newif`, `\newcounter`, `\usepackage`, `\RequirePackage`, `\input`, TikZ, theme or template call), and no external tool. Two judgement calls for a stricter re-reading: (1) the class source is not in the zip and was not read, so what its default title slide, footer, colours and fonts look like is unverified, and the verdict follows the rubric's ruling that a look carried entirely by a published class is `yes`; (2) the CTAN page calls the class experimental ("changes may occur to interfaces") and lists no class options, so the options a future template would pass are not known from this zip.

## Blockers
none

## Class setting
- Class: `class.ltx-talk` options: none (main.tex:3). The source of ltx-talk was not read (it ships with the TeX distribution and is not in the zip). `\DocumentMetadata{}` precedes `\documentclass` (main.tex:1).
- Class-native vocabulary used: `frame` environment (main.tex:10, 14, 23, 32), `\frametitle{}` (main.tex:15, 24, 33), `\title{}` and `\author{}` (main.tex:5-6), `\maketitle` inside a `frame` (main.tex:11), the overlay specification `[<+->]` on `itemize` (main.tex:16). Not used: `\date`, `\institute`, short-form `\title[..]{..}`, `\section`, theme packages, hooks, template or instance commands, handout or notes mode.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document metadata | main.tex:1 | `meta.documentmetadata` | `\DocumentMetadata{}` with an empty key list: no `pdfstandard`, `tagging`, `lang` or `pdfversion` set by the sample (whether the class enables tagging by default was not read; main.tex:19 only says the class can produce tagged output) |
| document class | main.tex:3 | `class.ltx-talk` | no options |
| title data | main.tex:5-6 | `front.maketitle` | `\title{Accessible Presentations by Default}`, `\author{Noor Fatima}`; no `\date`, no `\institute` |
| title slide | main.tex:10-12 | `front.class-native` | `\maketitle` as the only content of a `frame`; the title-slide look is the class's own default (not read) |
| frames | main.tex:10, 14, 23, 32 | `class.ltx-talk` (native) | four `frame` environments, no options; page size and geometry are the class default (the sample sets no `page.*` way) |
| frame titles | main.tex:15, 24, 33 | `class.ltx-talk` (native) | `\frametitle{text}` on frames 2 to 4 |
| bulleted lists | main.tex:16-20, 25-29 | `list.kernel` | two `itemize` environments, three `\item` each, default labels and spacing of the class |
| overlays | main.tex:16 | `class.ltx-talk` (native) | optional argument `[<+->]` on `itemize` (reveal one item per step); considered: `slide.beamer-mode` (an existing beamer-named way), not used because the overlay notation is ltx-talk's own class vocabulary, recorded under the class way |
| running footer | main.tex:28 (the slide text describes it; the sample sets nothing) | `hf.class-native` | the class default footer, said by the slide to track title, author and frame number; its template was not read |
| body text | main.tex:34-35 | none (content) | one paragraph in a frame, `---` typed as a dash; text is content |
| fonts, colour, spacing, theme | whole sample | `class.ltx-talk` (defaults) | nothing set: no `font.*`, `color.*`, `sp.*` or theme line in main.tex |
| not used | whole sample | none | no sectioning, math, theorem, float, table, caption, code, box, bibliography or index construct in the sample |

## Bespoke code
none (main.tex defines no macro, environment, counter or conditional, and the zip holds no `.cls`, `.sty`, `.def`, `.cfg` or `.clo`)

## Content-opaque
none

## Lib changes
- New ways proposed: none. Considered: `slide.beamer-mode` for the overlay argument at main.tex:16 (decided against, see the map row).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
