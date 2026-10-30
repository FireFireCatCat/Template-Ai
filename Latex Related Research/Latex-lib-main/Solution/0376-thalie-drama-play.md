yes

# 0376-thalie-drama-play: Thalie Drama Play

- Unverified: read from the source, not compiled.
- Source: Source/0376-thalie-drama-play/ (origin: https://latextemplates.com/downloads/thalie.zip; licence: LPPL-1.3 per the manifest; README.md:9 says LPPL 1.3, Louis Paternault, and ctan.org/pkg/thalie read once says LPPL 1.3)
- Kind: misc (a stage play: dramatis personae, act, scene, character lines, stage directions; no listed kind fits, and the manifest hint is also misc)
- Lib: v4 (the snapshot read)
- Engine: pdfLaTeX-compatible (the sample loads only `fontenc`, `inputenc`, `babel`, `geometry` and `thalie`, main.tex:2-6, none of them xe/lua; the `thalie` source was not read and the CTAN page states no engine)
- Look carried by: preamble (the published CTAN and TeX Live package `thalie`, loaded at main.tex:6 over kernel `article`, carries the play look; the zip holds only `main.tex` and `README.md`, with no `.cls`, `.sty` or other local file, and the sample defines no macro of its own)
- Class origin: tex-distribution-unbundled (kernel `article`, main.tex:1, not in the zip; its source was not read. `thalie` is a package, not a class, and is not in the zip either: README.md:9-10 says it is supplied by TeX Live and not copied into the archive)
- Main file: main.tex (other samples: none)
- Read: main yes (all 43 lines), zip-local classes and styles none present (the zip holds no class or style; the source of `thalie` was not read: it is not in the zip and no TeX tree is installed here)

## Verdict
yes. The zip is a 43-line `main.tex` plus a README. The class is kernel `article` (main.tex:1), the preamble loads four published packages with options (main.tex:2-5), and the whole play vocabulary comes from one published package, `thalie` (main.tex:6), which README.md:3-7 names as the CTAN package and ctan.org/pkg/thalie describes as "Typeset drama plays" (CTAN, TeX Live and MiKTeX, LPPL 1.3, v0.13a). The sample defines no macro, environment, counter or conditional, so there is no bespoke code and no artwork. The lib has no way for `thalie`, so one is proposed (`play.thalie`) and passes W1 to W4 (see Lib changes). The one limit on this analysis is that the `thalie` source was not available, so its option list and internal layout (fonts, spacing, running heads, act and scene numbering) are not itemised; they belong to the published package.

## Blockers
none

## Class setting
- Class: `class.article` options: `11pt`, `a4paper` (main.tex:1).
- Class-native vocabulary used: `\title` (main.tex:8), `\author` (main.tex:9), `\date{}` with an empty argument (main.tex:10), `\maketitle` (main.tex:13). The sample uses no `abstract`, sectioning command or list from `article`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.article` | options `11pt,a4paper` |
| paper size and base font size | main.tex:1 | `page.class-options` | `a4paper`, `11pt` |
| font encoding and input encoding | main.tex:2-3 | `font.fontenc-t1` | `\usepackage[T1]{fontenc}`, `\usepackage[utf8]{inputenc}` |
| language | main.tex:4 | `lang.babel` | option `english` |
| page geometry | main.tex:5 | `page.geometry` | `margin=24mm` |
| title block | main.tex:8-10, 13 | `front.maketitle` | `\title{The Lantern Room}`, `\author{Your Name}`, `\date{}` (empty, so no date prints), `\maketitle`; the strings are content |
| play package load | main.tex:6 | `play.thalie` | `\usepackage{thalie}`, no options |
| dramatis personae | main.tex:15-19 | `play.thalie` | `dramatis` environment around three `\character[cmd=<name>,desc={<text>}]{<display name>}` entries (`cmd=aria`, `cmd=jon`, `cmd=voice`, main.tex:16-18); names and descriptions are content |
| play title, act and scene headings | main.tex:21-23 | `play.thalie` | `\play{The Lantern Room}`, `\act{The First Signal}`, `\scene{A workroom at dusk}`: one string each |
| scene stage direction | main.tex:25 | `play.thalie` | `\onstage{...}`: one string argument |
| character lines | main.tex:27-28, 30-31, 33-34, 36-37, 39-40 | `play.thalie` | a speaker command (`\aria`, `\jon`, `\voice`) on its own line, named by the `cmd=` keys at main.tex:16-18, followed by the speech text; the sample has no `\newcommand` that defines them |
| inline stage direction | main.tex:37, 40 | `play.thalie` | `\did{From the corridor.}`, `\did{He opens the notebook.}`: a wrapper at the start of a speech |
| end of play | main.tex:42 | `play.thalie` | `\curtain`, no arguments |
| running heads, fonts, spacing and act/scene numbering of the play | not set by the sample (no `\pagestyle`, `\setlength`, font or counter command in main.tex:1-43) | `play.thalie` over `class.article` defaults | package and class defaults; not read, not itemised |

The sample uses no list, quote, note, math, theorem, float, table, caption, code, box, bibliography or index construct.

## Bespoke code
none. Searched `main.tex:1-43`: no `\newcommand`, `\renewcommand`, `\def`, `\newenvironment`, `\newcounter`, `\newif` or conditional. The commands `\aria`, `\jon` and `\voice` (main.tex:27, 30, 33, 36, 39) are not defined in the sample; they follow from the `cmd=` keys of `\character` (main.tex:16-18), which is the `thalie` interface, not zip-local code.

## Content-opaque
none

## Lib changes
- New ways proposed: `play.thalie` `thalie` (CTAN, in TeX Live and MiKTeX, v0.13a 2022-12-11, LPPL 1.3, Louis Paternault; ctan.org/pkg/thalie read once; pdfLaTeX support is not stated on the CTAN page; the look of a drama play: `\usepackage{thalie}` and body `dramatis` environment with `\character[cmd=,desc=]{name}`, `\play{}`, `\act{}`, `\scene{}`, `\onstage{}`, one speaker command per character named by `cmd=`, `\did{}` and `\curtain`). W1: published on CTAN and in TeX Live, with a documentation file `thalie.pdf` listed on the CTAN page. W2: behaviour is chosen by key values and string arguments (`cmd`, `desc`, titles, direction text), not by editing the package code. W3: it serves a kind of document part, a stage play of any length, not this sample (a doc-kind sibling of `songbook.songs`, `recipe.xcookybooky` and `notebook.ftc`: one package whose commands are the whole document part). W4: one preamble line and body wrappers around each node's content, so an emitter can print it. Considered and not used: `quote.dialogue` (the `dialogue` package, environment with `\speak{name}`; a different package with a different command set, and this sample loads `thalie`, not `dialogue`); a `class.*` or `front.class-native` entry (`thalie` is a package loaded over `article`, not a class).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
