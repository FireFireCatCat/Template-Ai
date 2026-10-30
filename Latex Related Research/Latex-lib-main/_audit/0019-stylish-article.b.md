yes

# 0019-stylish-article: Stylish Article (substitute starter on the lebhart class)

- Unverified: read from the source, not compiled.
- Source: Source/0019-stylish-article/ (origin: https://latextemplates.com/downloads/stylish-article.zip; licence: LPPL-1.3c per manifest; README.md:41-47 says the same for `lebhart`, and the starter text carries no extra restriction)
- Kind: journal (a short scientific-style article with abstract, keywords, a theorem; the manifest hint `calendar` is wrong)
- Lib: v2
- Engine: needs XeLaTeX or LuaLaTeX (the class is fontspec-based, README.md:15-24; `\UseLanguage` is the `lang.projlib` way, xe/lua)
- Look carried by: class (the whole look is the published `lebhart` class plus the ProjLib package it builds on; the sample sets no option and no style of its own, main.tex:18-21)
- Class origin: tex-distribution-unbundled (`lebhart` and `projlib` are on CTAN and in TeX Live, checked at ctan.org/pkg/lebhart and ctan.org/pkg/projlib; README.md:35-39 says the class is deliberately not bundled)
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present (the zip holds only main.tex and README.md; `lebhart.cls`, `colorist*.sty` and `ProjLib` source were NOT read, they are not in the zip)

## Verdict
yes. The zip is a 98-line article that loads the published class `lebhart` with no options and uses only its native vocabulary (title block, `abstract`, `keyword`, `theorem`, `\Cref`) plus the published `ProjLib` package. There is no zip-local class, style or artwork, no tool outside TeX, and the one zip-defined macro is a string constant that works around a class defect. This reaches `yes` because the class carries everything, so it is evidence about the class dimension, not about the component ways. Nothing in the class source was read, so how each native look is built is taken from the lib's `class.lebhart` entry, not re-verified.

## Blockers
none

## Class setting
- Class: `class.lebhart` options: none (`\documentclass{lebhart}`, main.tex:18). The lib line lists `a4paper`/`b5paper`, `11pt`/`12pt`, `oneside`/`twoside`, `draft`/`fast`, `print`; the sample uses all defaults.
- Class-native vocabulary used: `\usepackage{ProjLib}` (main.tex:19), `\UseLanguage{English}` (main.tex:21), `\TheDate{2026-01-15}` inside `\date` (main.tex:32), `\title` `\author` `\date` `\maketitle` (main.tex:30-35), `abstract` environment (main.tex:37-42), `keyword` environment from `colorist-fancy.sty` (main.tex:23-24, 43-45), `theorem` environment with an optional title and `\label` (main.tex:62-65), `\Cref` (main.tex:67). The file's own comment calls the theorem environments native (main.tex:5-8).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:18 | `class.lebhart` | no options; class defaults for paper, size, sides, colour theme |
| page geometry | main.tex:18 (no geometry call, no option) | `page.class-options` | none given; geometry is the class default (not read) |
| header/footer, page numbers | none in the sample | `hf.class-native` | none given; whatever the class prints by default (not read, not observable here) |
| fonts | main.tex:10-15; README.md:17-19 (the author's description, not the class source) | `font.fontspec` | no sample setting; class default main face TeX Gyre Pagella X, sans TeX Gyre Heros, selected through fontspec by the class |
| colour theme | main.tex:5-8 (comment: "colourful article class") | `class.lebhart` | no sample setting; the colour scheme is a class default of the colorist series (no separate colour way is asserted) |
| language and keyword names | main.tex:19, 21 | `lang.projlib` | `\UseLanguage{English}` after `\usepackage{ProjLib}` |
| date | main.tex:32 | `lang.projlib` | `\TheDate{2026-01-15}` (ISO date argument formatted by language). Assumption: `\TheDate` is ProjLib's; it is not documented on the ctan page. If it is class-defined instead, the way would be `front.class-native`; the verdict does not change |
| title block | main.tex:30-35 | `front.maketitle` | `\title`, `\author` (one author, no `\affil`), `\date`, `\maketitle`; the class restyles the block (`front.class-native`, not read) |
| abstract | main.tex:37-42 | `abs.class-native` | kernel `abstract` environment, styled by the class |
| keywords | main.tex:43-45 | `abs.keywords` | class `keyword` environment (colorist-fancy), comma-separated words; label string `\keywordname`, see the Bespoke table |
| headings | main.tex:47, 55, 57, 70, 75, 81, 92 | `head.kernel` | `\section` and `\subsection`, numbered; the look is the class's (`head.class-native`) |
| heading look | main.tex:47-92 | `head.class-native` | no sample setting; class default heading style |
| theorem | main.tex:62-65 | `thm.class-native` | `theorem` environment, optional title "Cache-aside invariant", `\label{thm:aside}`; supplied by the class stack through ProjLib (source not read) |
| list | main.tex:83-90 | `list.kernel` | `itemize`, three items, no optional argument |
| cross-reference | main.tex:62, 67 | `xref.kernel` | `\label{thm:aside}` |
| cross-reference | main.tex:67 | `xref.cleveref` | `\Cref{thm:aside}`; the sample never loads `cleveref`, so the class stack loads it (not read) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\providecommand{\keywordname}{Keywords}` | main.tex:28 (reason in main.tex:23-27 and README.md:26-33: the TeX Live 2025 `keyword` environment reads `\keywordname`, while `projlib-author` defines only `\keywordsname`) | yes (BESPOKE/preamble, reducible) | A kernel `\providecommand` that stores one string; no logic, no counter, no conditional. Emit it as a preamble line, string parameter `Keywords`, only when the class build has the defect; it feeds the label of `abs.keywords` (the name is also part of what `lang.projlib` sets by language). |

No zip-local class, style, environment, counter or conditional exists.

## Content-opaque
none

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- This zip is a substitute, not the Stylish Article template: the original `SelfArx.cls` is CC-BY-NC-SA and was replaced by a `lebhart` starter (README.md:3-9, main.tex:1-8). The analysis covers what the zip holds.
- `main.tex:11` points to an `engine.txt` that is not in the zip (`ls -R` shows only `main.tex` and `README.md`). Not a blocker.
- Not read, so not checked: the `lebhart`, `colorist`, `colorist-fancy`, `ProjLib` sources. In particular I could not check whether any package they load unconditionally needs a tool outside TeX (the `minted` ruling); `class.lebhart` is already a lib way, and the sample uses nothing that suggests an external tool. If that matters, read the class source from CTAN.
- Text addressed to an AI inside the zip: none found.
- The sample has no figures, tables, code, math, footnotes or bibliography, so those components are not exercised.
