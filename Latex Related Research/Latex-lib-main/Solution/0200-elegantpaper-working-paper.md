yes

# 0200-elegantpaper-working-paper: ElegantPaper Working Paper

- Unverified: read from the source, not compiled.
- Source: Source/0200-elegantpaper-working-paper/ (origin: https://latextemplates.com/downloads/elegantpaper-working-paper.zip; licence: LPPL-1.3c, per the manifest, README.md:8 and main.tex:9-10)
- Kind: journal (a working-paper article: title block with institute and version, abstract with keywords, four sections, bibliography; main.tex:21-56; the manifest hint `article` agrees)
- Lib: v4
- Engine: needs XeLaTeX (the zip's own target: main.tex:12 and README.md:6 name xelatex; main.tex:13 says the class "also supports pdflatex", which was not checked because the class source is not in the zip and was not read)
- Look carried by: class (the zip holds no `.cls`, `.sty` or preamble code; the sample sets only class options, class-native title fields and one bibliography resource, main.tex:21-30)
- Class origin: tex-distribution-unbundled (`elegantpaper` is not bundled, main.tex:3-6 and README.md:7; one read of https://ctan.org/pkg/elegantpaper: "ElegantPaper, An Elegant LaTeX Template for Working Papers", v0.12 dated 2026-02-27, LPPL 1.3c, listed in TeX Live and MiKTeX, "based on the standard LaTeX article class")
- Main file: main.tex (other samples: none)
- Read: main yes (58 lines, all), zip-local classes and styles none present (the zip has only README.md, main.tex and references.bib; the class source is in the TeX distribution, not in the zip, and was not read)

## Verdict
The look is carried entirely by the published class `elegantpaper` (CTAN and TeX Live, so W1 holds), which is one class way chosen by the options `11pt` and `en` (main.tex:21). The zip adds no style file and no macro: `grep` finds no `\usepackage`, `\newcommand`, `\def`, `\newtheorem`, `\geometry`, `\setlength` or environment definition in main.tex. Every body construct the sample uses (title fields, class-native institute and version lines, abstract with keywords, four sections, two labels, one citation, a biblatex bibliography) has a lib way, and `biber` is the accepted way `bib.biblatex-biber`, not an EXTERNAL tool. No `ART`, `UNMAPPED` or irreducible code. This is evidence about the class dimension, not about the component ways. Limit of the `yes`: the class source was not read, so what the class itself loads (any package it requires unconditionally, its page geometry, fonts, heading, abstract and caption looks) is not mapped here and is not checked against the rubric's ruling on unconditionally loaded external-tool packages.

## Blockers
none

## Class setting
- Class: `class.elegantpaper` options: `11pt` (size, main.tex:21) and `en` (language; "selects the caption/abstract-name language", README.md:20; the other value is `cn`, README.md:20-22). The class defaults to the biblatex backend biber, written `\ELEGANT@bibend=biber` in the zip's comment (main.tex:16-20, README.md:13-14), and the sample leaves that default.
- Class-native vocabulary used: `\institute{}` (main.tex:25), `\version{}` (main.tex:27), `\keywords{}` inside the `abstract` environment (main.tex:39). Named by the README but not called by the sample: `\email`, `\figref`, `\tabref` (README.md:23-25). Commands the class takes from published packages and the sample calls: `\addbibresource`, `\cite`, `\printbibliography` (main.tex:30, 43, 56).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:21 | `class.elegantpaper` | options `11pt,en`; class not bundled (main.tex:3-6), source not read |
| point size | main.tex:21 | `page.class-options` | `11pt`; no paper-size option given, so the class default |
| language of caption and abstract names | main.tex:21; README.md:20 | `class.elegantpaper` | option `en` (a class option value, not a `babel` call); under `en` Chinese characters need `ctex` or `xeCJK` loaded by hand (README.md:21-22) |
| title | main.tex:23 | `front.maketitle` | `\title{Your Title Here}` |
| authors | main.tex:24 | `front.maketitle` | `\author{... \and ...}`, two authors joined by `\and` |
| line break inside each author | main.tex:24 | `sp.manual-space` | `\\` between the name and the institution inside `\author` |
| institute line | main.tex:25 | `front.class-native` | `\institute{Working Paper Series}` (class command, README.md:23-25) |
| version line | main.tex:27 | `front.class-native` | `\version{1.0}` (class command, README.md:23-25) |
| date | main.tex:28 | `front.maketitle` | `\date{\today}` |
| title block | main.tex:34 | `front.class-native` | `\maketitle` printing the class's own block with institute and version; its look is inside the class (not read) |
| abstract | main.tex:36-40 | `abs.kernel` | `abstract` environment around one paragraph; the name comes from the `en` option (README.md:20); any restyling is inside the class (not read) |
| keyword line | main.tex:39 | `abs.keywords` | `\keywords{first keyword, second keyword, third keyword}` inside the abstract (class command, README.md:23-24) |
| section headings | main.tex:42, 45, 49, 53 | `head.kernel` | `\section{Introduction}`, `\section{Method}`, `\section{Results}`, `\section{Conclusion}`; no `\subsection`; no heading command redefined in the sample; the heading look is inside the class (not read) |
| labels | main.tex:46, 50 | `xref.kernel` | `\label{sec:method}`, `\label{sec:results}`; the sample never calls `\ref` (grep finds none) |
| citation in text | main.tex:43 | `bib.biblatex-biber` | `\cite{knuth1984texbook}` with the class's default citation style (not read) |
| bibliography source | main.tex:30; references.bib:1-6 | `bib.biblatex-biber` | `\addbibresource[location=local]{references.bib}`; one `@book` entry (content) |
| bibliography printing | main.tex:56 | `bib.biblatex-biber` | `\printbibliography`, no heading options; backend biber is the class default (README.md:13-19) |
| page geometry, fonts, spacing, colours, link colours, captions, lists, theorems, code | not in the sample; defined inside `elegantpaper.cls` | `class.elegantpaper` | nothing set by the zip; the class source was not read, so none of these is mapped to a component way here |

## Bespoke code
none. No zip-local `.cls`, `.sty`, `\newcommand`, `\def`, environment, counter or conditional exists, and main.tex has no `\usepackage` (checked with grep). The class's own internals are published code and stay inside the one class way.

## Content-opaque
none (no figure, table, TikZ picture or image in main.tex).

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
