yes

# 0353-curriculum-vitae: Curriculum Vitae (Sumukh Prasad's `curriculum-vitae` class)

- Unverified: read from the source, not compiled.
- Source: Source/0353-curriculum-vitae/ (origin: https://latextemplates.com/downloads/curriculum-vitae-class.zip; licence: Apache-2.0)
- Kind: cv
- Lib: v3
- Engine: needs XeLaTeX (per README.md:20-24 the class `\RequirePackage`s `fontspec` and loads Fira Sans; the class source is not in the zip and was not read, so this is the README's claim, not checked)
- Look carried by: class (the published `curriculum-vitae` class draws the whole look; `main.tex` adds only a `geometry` call, a class option and content)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present (the zip holds only `main.tex`, `README.md`, `LICENSE`; README.md:14-16 says no class file is bundled)

## Verdict
Yes. The zip holds one 69-line sample and no zip-local class, style or macro (grep of `main.tex` finds no `\newcommand`, `\def`, `\newenvironment`; the only `\usepackage` is `geometry` at main.tex:2). The look is carried by the class `curriculum-vitae`, which is published: ctan.org/pkg/curriculum-vitae shows version 2.0 (2025-06-06), author Sumukh Prasad, Apache-2.0, "Included in: TeX Live and MiKTeX", and it is not bundled here, so it is one way and its source was not read. The sample uses the class's own vocabulary plus `geometry`, a class option and `itemize`. Caveat: everything about what the class does inside (small-caps header, two-column label layout, Fira Sans, the `detail` date column) comes from README.md:3-6 and 20-32, which is the zip author's description and not checked against class code.

## Blockers
none

## Class setting
- Class: `class.curriculum-vitae` options: `12pt` (main.tex:1)
- Class-native vocabulary used: header fields `\name{}` `\mailingaddr{}` `\desc{}` `\email{}` `\webpage{}` `\phone{}` `\qualification{}` (main.tex:4-10), `\maketitle` (main.tex:16), `\cvsection[Label]{body}` (main.tex:18, 32, 49, 58, 64), `detail` environment with `[Title]{start}{end}` (main.tex:19, 25, 33, 38, 43, 50, 53, 59). Per README.md:3-6 the header is a small-caps name with contact details flushed right and each `\cvsection` label sits in a narrow left column beside a wider content column.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class | main.tex:1 | `class.curriculum-vitae` | `12pt`; published (ctan.org/pkg/curriculum-vitae), source not read |
| type size | main.tex:1 | `page.class-options` | `12pt` |
| page geometry | main.tex:2 | `page.geometry` | `a4paper`, `total={7.3in, 9.7in}` |
| CV header data | main.tex:4-10 | `front.class-native` | `\name` Hannah Ostrowski, `\mailingaddr`, `\desc` Product Designer, `\email`, `\webpage`, `\phone`, `\qualification` MA: all plain strings |
| header block | main.tex:16 | `front.class-native` | `\maketitle` renders the header from those fields (look per README.md:3-5; class source not read) |
| section blocks | main.tex:18-30, 32-47, 49-56, 58-62, 64-67 | `cv.entries` | `\cvsection[Education]`, `[Experience]`, `[Skills]`, `[Publications]`, `[Interests]`; the optional argument is the left-column label, the mandatory argument is the content; the Interests body is plain text (main.tex:65-66) |
| entries | main.tex:19, 25, 33, 38, 43, 50, 53, 59 | `cv.entries` | `\begin{detail}[Title]{start}{end}`; dates `Sept 2016`..`Present`, empty dates at main.tex:50 and 53, one date only at main.tex:59 |
| bulleted points | main.tex:20-23, 26-28 | `list.kernel` | `itemize` inside `detail` |
| fonts | README.md:20-24 | `class.curriculum-vitae` | Fira Sans through `fontspec`, set inside the class; no `font.*` call in the sample, so no separate way is claimed (not verified) |

Body wording (main.tex:34-36, 39-41, 44-45, 51, 54, 60, 65-66) is content; `\%` at main.tex:35 and `--` in titles (main.tex:33, 38, 43, 59) are plain text.

No headers/footers, colours, backgrounds, language or hyperref calls, headings, numbering, theorems, floats, tables, captions, code, boxes, bibliography or index appear in the sample (main.tex:1-69) or in any zip file; the class may set some of these internally, which was not read.

## Bespoke code
none. No zip-local class, style, macro, environment, counter or conditional exists (main.tex:1-69). Whatever the class defines inside itself is published code under the class way, not zip-local.

## Content-opaque
none

## Lib changes
- New ways proposed: none. (Considered and not needed: a `font.*` way for the class's internal Fira Sans, because the sample never calls it; the lib's class section is filled from this file by script with the vocabulary recorded above.)
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- README.md:36-38 gives `xelatex main` and says one pass is enough; read as the author's claim only. README.md:26-32 notes a cosmetic quirk (a bare "--" in the date column when both dates are empty); a class behaviour, not a template component.
- No text in the zip was addressed to an AI.
