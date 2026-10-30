yes

# 0419-letgut-newsletter: letgut Newsletter

- Unverified: read from the source, not compiled.
- Source: Source/0419-letgut-newsletter/ (origin: https://latextemplates.com/downloads/letgut.zip; licence: LPPL-1.3c-or-later, README.md:17; the CTAN page of `letgut` states LPPL 1.3c too)
- Kind: newsletter (the manifest hint `letter` is wrong: the sample is an issue of the GUTenberg newsletter, with masthead, editorial and articles)
- Lib: v4
- Engine: needs LuaLaTeX (README.md:3 calls it a LuaLaTeX starter; the CTAN page of `letgut` files the class under `luatex/latex` and tags it LuaLaTeX; the class source was not read, so the fonts and packages it loads are not known)
- Look carried by: class (the published class `letgut` defines masthead, contents, headings, announcement box and bibliography headings; the zip adds option values, French content, two one-line biblatex shims and one compile guard)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none; `editorial.tex` is an article file that `main.tex` pulls in)
- Read: main yes, zip-local classes and styles all (the only zip-local style files are `letgut.bbx` and `letgut.cbx`, both read in full; no `.cls` or `.sty` is present; the source of the published class `letgut.cls` is not in the zip and was not read)

## Verdict
`yes`, with one real caveat. Every part of the sample is either a class option or class command of the published, unbundled CTAN class `letgut`, or kernel, `listings` or `biblatex` vocabulary, and the zip-local items are two one-line biblatex style shims, an empty acronym file and a one-line `\author` re-provide, all of which reduce to published commands (see Bespoke code). The class carries the look and its source is not in the zip, so the check of what the class implements internally is not made: the rubric counts a published class as one way. The `\author` guard (main.tex:21) compensates, according to its own comment (main.tex:18-19), for a mismatch between the class's end-of-document hook and the kernel title page, which I could not check without the class source; I judged it reducible because it has no typesetting effect of its own.

## Blockers
none

## Class setting
- Class: `class.letgut` options: `final`, `screen`, `editorial=false`, `informations=false`, `membership-reminder=false`, `detailedtoc=2`, `number=42`, `date=2026-08` (main.tex:1-10)
- Class-native vocabulary used: `\title` `\author` `\maketitle` over the class's own masthead (main.tex:13-14,17); `\inputarticle*{file}` (main.tex:24); `announcement[color=,colback=]{title}` environment (main.tex:34-37); `\printbibliography[heading=subtitle,title={Références}]` with the class-defined heading name `subtitle` (main.tex:47); the input hook file `letgut-acronyms.tex` with `\letgutacro` entries (letgut-acronyms.tex:1); the named biblatex style `letgut` that the class asks for (letgut.bbx:1-2, letgut.cbx:1-2, README.md:11-13)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1-10 | `class.letgut` | options `final`, `screen`, `editorial=false`, `informations=false`, `membership-reminder=false`, `detailedtoc=2`, `number=42`, `date=2026-08` |
| page format | main.tex:3 | `page.class-options` | `screen` (the class's screen-versus-print switch; what size and margins it gives is inside the class, not read) |
| title and masthead | main.tex:13,14,17 | `front.maketitle` | `\title{La lettre des outils ouverts}`, `\author{Association GUTenberg}`, `\maketitle` (kernel commands, the class replaces the printed result) |
| masthead, issue number, date | main.tex:8-9,18 | `front.class-native` | `number=42`, `date=2026-08` (class keys; the class prints its own title page, per the comment) |
| front-matter blocks switched off | main.tex:4-6 | `front.class-native` | `editorial=false`, `informations=false`, `membership-reminder=false` |
| contents list | main.tex:7 | `front.class-native` | `detailedtoc=2` (class key; the contents list is the class's own, no `\tableofcontents` in the sample; this is the lib's `toc.*` family folded into `front.class-native`, per the v3 note) |
| editorial article input | main.tex:24, editorial.tex:1-12 | `front.class-native` | `\inputarticle*{editorial}` (class command; the starred form is the class's own variant, effect not read) |
| sectioning | main.tex:26,39, editorial.tex:1 | `head.class-native` | `\section`, `\subsection`; their look is set inside the class, no `titlesec` or `\renewcommand` in the zip |
| itemize list | editorial.tex:8-12 | `list.kernel` | `itemize` with three items |
| inline code font | main.tex:29 | `mark.kernel` | `\texttt{letgut}` |
| announcement box | main.tex:34-37 | `class.letgut` | class-native environment `announcement[color=orange!65!black,colback=yellow!10]{À retenir}`; `colback` is the name of a `tcolorbox` key, so the class probably builds it on `tcolorbox` (considered: `box.tcolorbox`, not established without the class source, so recorded as class vocabulary) |
| code listing | main.tex:41-45 | `code.listings` | `lstlisting` with `language={[LaTeX]TeX}`, `caption={Une section minimale}`; that the class loads `listings` is implied by this call and not read |
| bibliography data and citation | main.tex:12,32 | `bib.biblatex-biber` | `\addbibresource{references.bib}`, `\cite{knuth1984}`; the backend is not set in the zip, so the biblatex default (biber) applies unless the class sets another |
| bibliography list | main.tex:47 | `bib.biblatex-biber` | `\printbibliography[heading=subtitle,title={Références}]`; `heading=subtitle` is a class-defined heading |
| bibliography and citation style | letgut.bbx:5, letgut.cbx:5 | `bib.biblatex-biber` | style `numeric` (the shims forward the class's `letgut` style name to numeric) |
| PDF bookmark metadata | main.tex:18-19 | `meta.class-native` | inferred from the comment only: the class's end-of-document hook builds a bookmark from the author; no command of its own in the sample |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\ProvideDocumentCommand{\author}{m}{\gdef\@author{#1}}` between `\makeatletter` and `\makeatother` | main.tex:20-22 | yes, with the caveat above | the body of the definition is the kernel definition of `\author` (`\gdef\@author{#1}`), so it restores the kernel command that, per the comment at main.tex:18-19, is no longer defined once the class's custom title page has run; no typesetting effect and no new look; the value is the `\author` string already given at main.tex:14 (`front.maketitle`); it is a compile guard for the pinned class and was not checked against the class source |
| `letgut.bbx`: `\RequireBibliographyStyle{numeric}` | letgut.bbx:5 | yes | biblatex bibliography style `numeric` (`bib.biblatex-biber`, style is a parameter); the file only supplies the style name the class requests |
| `letgut.cbx`: `\RequireCitationStyle{numeric}` | letgut.cbx:5 | yes | biblatex citation style `numeric` (`bib.biblatex-biber`) |
| `letgut-acronyms.tex` | letgut-acronyms.tex:1 | yes | a comment line only, no entries and no code; it satisfies the class's input hook |
| `references.bib`, `editorial.tex` | references.bib:1-14, editorial.tex:1-12 | yes | content: two `@book` entries, one editorial article of a heading, a paragraph and a list |

## Content-opaque
none

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- The class `letgut` (CTAN `letgut`, v0.9.15 dated 2026-02-28 on the CTAN page, LPPL 1.3c, Association GUTenberg and Denis Bitouzé) ships with TeX Live and is not in the zip (README.md:18). Its source was not read. Because of that, which packages it loads (hyperref, biblatex backend, listings, fontspec, language support), what `screen` does, and what `announcement` and `\inputarticle*` implement are all unknown here. A hidden unconditional load of an external-tool package (minted, shell escape) would be `EXTERNAL/package`; the sample compiles a `lstlisting`, which points to `listings`, but that is not shown.
- The zip's bibliography is the shim, not the upstream style (README.md:11-13): the upstream `letgut.bbx`/`letgut.cbx` of the CTAN distribution are not in the zip, so the printed bibliography here is biblatex `numeric`.
- Language: the text is French (main.tex:28-32) but no `babel`, `polyglossia` or language option appears in the sample, so any language setup is inside the class and no `lang.*` row is written.
- No text addressed to an AI was found in the zip.
