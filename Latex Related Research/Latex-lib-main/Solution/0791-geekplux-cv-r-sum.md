yes

# 0791-geekplux-cv-r-sum: GeekPlux CV/Résumé (bilingual Chinese/English, moderncv classic)

- Unverified: read from the source, not compiled.
- Source: Source/0791-geekplux-cv-r-sum/ (origin: https://latextemplates.com/downloads/geekplux-cv.zip; licence: MIT, README.md:50; main.tex:2-7 also carries the moderncv template's LPPL 1.3c notice)
- Kind: cv
- Lib: v6
- Engine: needs XeLaTeX (`fontspec` and `xunicode` at main.tex:11, `xeCJK` at main.tex:12; the build line is `xelatex main`, README.md:44; the Emacs footer says `TeX-engine: xetex`, main.tex:97)
- Look carried by: mixed (the published `moderncv` class carries the title block, headings, entries and colour; the preamble adds the Latin and CJK fonts at main.tex:24-30 and the geometry scale at main.tex:36)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none; README.md is documentation only)
- Read: main yes (96 lines, whole file), zip-local classes and styles none present (the zip holds only main.tex and README.md; the `moderncv` source is not in the zip and was not read)

## Verdict
Every component of the sample maps to a lib way: the `moderncv` class (published, in TeX Live, not bundled: README.md:33; ctan.org/pkg/moderncv read: LPPL 1.3c, v2.6.1, TeX Live and MiKTeX), `fontspec` for the Latin face, `xeCJK` for the Chinese faces, `geometry` for the margins, `xcolor` and `xunicode` as load-only packages, and the class's own title, heading and entry commands. The zip defines no macro, environment, counter or conditional of its own (a grep of main.tex for `\newcommand` `\renewcommand` `\def` `\let` `\newenvironment` `\newcounter` `\newif` `\makeatletter` `\input` found none), there is no artwork and no tool outside TeX. Verdict `yes`, with the caveat that the class source was not read, so class-native commands are taken from the sample and the lib's `class.moderncv` line.

## Blockers
none

## Class setting
- Class: `class.moderncv` options: `11pt`, `a4paper` (main.tex:9); theme set after loading by `\moderncvtheme[blue]{classic}` (main.tex:33): colour `blue`, style `classic`
- Class-native vocabulary used: `\moderncvtheme` (main.tex:33), `\recomputelengths` (main.tex:37), `\firstname` `\familyname` `\title` `\address{street}{city}` `\mobile` `\email` `\homepage` `\social[github]{name}` `\extrainfo` (main.tex:40-50), `\photo[64pt]{file}` (commented out, main.tex:52), `\maketitle` (main.tex:58), `\cventry` (main.tex:62,64,66,70), `\cvlistitem` (main.tex:71-72), `\cvline` (main.tex:76,78,81-83,86); sectioning `\section` and `\subsection` (main.tex:61,75) take the theme's look

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:9 | `class.moderncv` | 11pt, a4paper |
| paper and base size | main.tex:9 | `page.class-options` | a4paper, 11pt (class options, not set again elsewhere) |
| theme and accent colour | main.tex:33 | `class.moderncv` | `\moderncvtheme[blue]{classic}`: colour blue, style classic (the comment at main.tex:33 lists the other colours and `roman`) |
| page geometry | main.tex:36-37 | `page.geometry` | `scale=0.9`; the following `\AtBeginDocument{\recomputelengths}` is a kernel hook around moderncv's own command (class-native, nothing defined in the zip) |
| Latin text font | main.tex:11, 24-27 | `font.fontspec` | `\setmainfont{texgyretermes-regular.otf}[BoldFont=texgyretermes-bold.otf, ItalicFont=texgyretermes-italic.otf]`, fonts loaded by file name (README.md:23-27) |
| CJK fonts | main.tex:12, 28-30 | `lang.cjk` | `xeCJK` with `slantfont,boldfont`; `\setCJKmainfont[ItalicFont=FandolKai-Regular.otf, BoldFont=FandolHei-Bold.otf]{FandolSong-Regular.otf}`, `\setCJKsansfont{FandolHei-Regular.otf}`, `\setCJKmonofont{FandolSong-Regular.otf}` |
| text-symbol encoding | main.tex:11 | `font.fontenc-t1` | `xunicode`, load-only, no options; ctan.org/pkg/xunicode read: LPPL 1.3, XeTeX, "similar to what fontenc does for 8-bit fonts"; the sample uses no accent or symbol command, so the verdict does not rest on this row (a load-only compat package, as `fixltx2e` was judged in lib v4) |
| colour package | main.tex:13 | `color.xcolor` | load-only, no options; no `\definecolor` in the sample |
| title block | main.tex:40-50, 58 | `front.class-native` | `\firstname{Wei}` `\familyname{Chen}` `\title{Software Engineer / 软件工程师}` `\address{Hangzhou, China}{}` `\mobile{+86 ...}` `\email` `\homepage` `\social[github]{weichen-dev}` `\extrainfo{LinkedIn: ...}` then `\maketitle`; photo slot unused (main.tex:52) |
| gap after title | main.tex:59 | `sp.manual-space` | `\vspace*{-14mm}` |
| section headings | main.tex:61,69,74,80,85 (`\section`), main.tex:75 (`\subsection`) | `head.class-native` | look set by the `classic` theme with blue accent; bilingual heading text is content |
| CV entries and lines | main.tex:62-67,70 (`\cventry`), main.tex:71-72 (`\cvlistitem`), main.tex:76,78,81-83,86 (`\cvline`) | `cv.entries` | `\cventry{years}{title}{employer}{place}{grade, empty}{description}`; `\cvlistitem{text}`; `\cvline{label}{text}` |
| inline emphasis | main.tex:77, 81-83, 86-87 | `mark.kernel` | `\emph`, `\textbf` |

Not set by the sample, so no row: header, footer, page numbers, bibliography, floats, tables, theorems, hyperlinks (all class defaults of `moderncv`, whose source was not read).

## Bespoke code
none

The only construct that looks like code is `\AtBeginDocument{\recomputelengths}` (main.tex:37): a kernel hook that calls a command of the published class, so it is a preamble line of `class.moderncv` vocabulary, not zip-local. The Emacs footer (main.tex:93-98), including `TeX-command-extra-options: "-shell-escape"` at main.tex:95, is an editor hint; no package in the zip needs shell escape (no `minted`, no `\write18`).

## Content-opaque
none

Missing assets, not blockers: the fonts TeX Gyre Termes and Fandol are TeX Live fonts and are not shipped in the zip (README.md:23-27); the photo file named in the commented line main.tex:52 is not shipped either (README.md:35-40).

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
