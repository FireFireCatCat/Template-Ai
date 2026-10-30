yes

# 0019-stylish-article: substitute starter on the published `lebhart` class (not the original Stylish Article)

- Unverified: read from the source, not compiled.
- Source: Source/0019-stylish-article/ (origin: https://latextemplates.com/downloads/stylish-article.zip; licence: LPPL-1.3c for lebhart, README.md:43-44; the starter text adds no restriction, README.md:46-47)
- Kind: misc (a general colourful article; the manifest hint "calendar" does not match anything in the zip)
- Lib: v1
- Engine: needs XeLaTeX (lebhart loads fontspec; LuaLaTeX also named, README.md:15-24, main.tex:10)
- Look carried by: class (the whole look is lebhart, which sits on `colorist`; the zip adds a 98-line sample, no class or style of its own, and one string alias at main.tex:28)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
The zip is two files, `README.md` and `main.tex`. It ships no `.cls` or `.sty`: `lebhart` and `ProjLib` are deliberately left to the TeX distribution (README.md:35-39), and both are on CTAN under LPPL-1.3c (ctan.org/pkg/lebhart, ctan.org/pkg/projlib; lebhart is also in TeX Live and MiKTeX). The preamble is `\documentclass{lebhart}`, `\usepackage{ProjLib}`, `\UseLanguage{English}` and one `\providecommand` string alias, and the body is only kernel front matter, headings, one theorem, one `\Cref` and an `itemize`. An emitter can write all of that from published packages and kernel commands, so the answer is `yes`. This is evidence about the class dimension (`class.lebhart`), not about component ways: the look lives in a class whose source was not read, and the README says outright that this is a substitute for the original Stylish Article (README.md:3-9), so the original template's look is not analysed here.

## Blockers
none

## Class setting
- Class: `class.lebhart` options: none (main.tex:18). Published, on CTAN and in TeX Live (version 2026-02-20 on the CTAN page); the source is not in the zip and was not read. The lib already holds this way with its options.
- Class-native vocabulary used: `\title`, `\author`, `\date{\TheDate{YYYY-MM-DD}}`, `\maketitle` (main.tex:30-35); `abstract` environment (main.tex:37-42); `keyword` environment (main.tex:43-45); `theorem` environment with an optional title (main.tex:62-65, "native theorem environments" per main.tex:7); `\section` and `\subsection` (main.tex:47-81); `\Cref` (main.tex:67); `\UseLanguage` (main.tex:21).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:18 | `class.lebhart` | no options; every default of the class applies (page size, point size, one side) |
| class-carried look: colour scheme, page layout, running heads, spacing | main.tex:5-8 ("colourful article class"); class source not read | `class.lebhart` | sample sets none of these; they are class defaults, not recorded individually because the source was not read |
| fonts | main.tex:10-15; README.md:17-20 | `font.fontspec` | loaded by the class, not by the sample: TeX Gyre Pagella (main text) and TeX Gyre Heros (sans), found through fontspec's own `.fontspec` configuration files; the sample sets no font |
| language and names | main.tex:19, 21 | `lang.projlib` | `\usepackage{ProjLib}` (loads the theorem-like environments and multilingual set-up, per ctan.org/pkg/projlib); `\UseLanguage{English}` |
| date | main.tex:32 | `lang.projlib` | `\TheDate{2026-01-15}` inside `\date`, a language-aware date command from the ProjLib/colorist stack (provider not read) |
| keyword label | main.tex:28; README.md:26-33 | `lang.projlib` | `\providecommand{\keywordname}{Keywords}`: a plain string alias for the label the class's `keyword` environment prints; see Bespoke code |
| title block | main.tex:30-35 | `front.maketitle` | `\title{Notes on Caching Strategies for Read-Heavy Web Services}`, `\author{Sam Okafor}` (one author, no affiliation), `\date{\TheDate{...}}`; the printed look is set by the class (source not read) |
| abstract | main.tex:37-42 | `abs.kernel` | `abstract` environment with the kernel name; its look is the class's |
| keywords | main.tex:43-45 | `abs.keywords` | class `keyword` environment holding a comma list of five items; label from `\keywordname` |
| headings | main.tex:47, 55, 57, 70, 75, 81, 92 | `head.class-native` | `\section` and `\subsection`, numbered, no override of any format; the look is the class's |
| theorem-like statement | main.tex:62-65 | `thm.class-native` | `theorem` environment, optional argument `[Cache-aside invariant]` as the title, `\label{thm:aside}`; no `\newtheorem` in the sample, so the style and counter come from the class (or from ProjLib's theorem module, which it loads); source not read |
| labels and cross-reference | main.tex:62, 67 | `xref.kernel`, `xref.cleveref` | `\label{thm:aside}`; `\Cref{thm:aside}`. The sample never loads `cleveref` itself, so something in the class stack must (not verified); the emitter should load it explicitly |
| list | main.tex:83-90 | `list.kernel` | `itemize`, three items, no `enumitem` options |

No bibliography, index, float, table, equation, footnote, code, box or appendix appears in the sample (main.tex:34-98). Body paragraphs and the text of the theorem are content.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\providecommand{\keywordname}{Keywords}` | main.tex:28 | yes | One kernel macro holding a label string, no logic. It works around a mismatch the README reports in the TeX Live 2025 build, where the `keyword` environment reads `\keywordname` and the language package defines only `\keywordsname` (README.md:26-33). The emitter writes it as a preamble line next to `lang.projlib`, with the label as the parameter. It may be unnecessary on a later release of the package; that was not checked. |
| `\documentclass{lebhart}` and `\usepackage{ProjLib}` internals | not in the zip | not applicable | Published (CTAN, TeX Live), so they are not bespoke by W1. Source not read; whether the class or ProjLib needs anything outside TeX was not verified from source, but the README gives a plain `xelatex main` with two passes and no shell escape (README.md:20-24). |

## Content-opaque
none

## Lib changes
- New ways proposed: none. Everything maps to ways already in the lib: `class.lebhart`, `font.fontspec`, `lang.projlib`, `front.maketitle`, `abs.kernel`, `abs.keywords`, `head.class-native`, `thm.class-native`, `xref.kernel`, `xref.cleveref`, `list.kernel`.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
- Notes for the consolidator: (1) the manifest's kind hint "calendar" and the id "stylish-article" do not describe this zip; it is a substitute that carries none of the original SelfArx look (README.md:3-9). (2) Weak points, all about unread published source and none a blocker: the provider of `\TheDate` is not established (mapped to `lang.projlib`); which package loads `cleveref` is not established; whether lebhart draws any title or heading artwork inside the class was not checked, and the rubric treats that as part of `class.lebhart`.
