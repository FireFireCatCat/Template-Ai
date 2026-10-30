yes

# 0779-elpres: elpres (electronic presentation class, sample deck)

- Unverified: read from the source, not compiled.
- Source: Source/0779-elpres/ (origin: https://latextemplates.com/downloads/elpres.zip; licence: LPPL per the manifest, and LPPL on ctan.org/pkg/elpres)
- Kind: presentation
- Lib: v6
- Engine: pdfLaTeX-compatible (the sample loads `inputenc` and `fontenc` T1, main.tex:3-4; ctan.org/pkg/elpres names LaTeX, pdfLaTeX and LuaLaTeX; the class source was not read)
- Look carried by: class (the zip holds one 57-line main.tex that sets a class option and loads two encoding packages; every slide look is the published class `elpres`)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present (the published `elpres.cls` is not in the zip and was not read, so the slide and list environment names below are taken from the sample only)

## Verdict
Yes. The zip carries no class, style, macro, environment, counter or length of its own: main.tex is 57 lines and a search of it for `\newcommand`, `\def`, `\newenvironment`, `\newcounter`, `\setlength`, `\input`, `\usepackage`, `\makeatletter` and `tikz` finds only the two `\usepackage` lines at main.tex:3-4. The look is the published `elpres` class (CTAN, TeX Live and MiKTeX, LPPL, v1.1 of 2024-05-29, Volker Kiefel, per ctan.org/pkg/elpres, read once), written by an emitter as `\documentclass[16x9]{elpres}`; the body uses the class's own slide and list environments plus kernel `center`, `tabular` and font switches. This is a class-carried yes: it is evidence about the class dimension, not about the component ways. Caveat: `elpres.cls` was not read and the CTAN page does not list `rsli`, `psli`, `citemize`, `cenumerate` or `cdescription`; they are not defined in the zip, so they are treated as the class's native vocabulary, and whether the class loads any package that needs a tool outside TeX was not checked (the CTAN page names none).

## Blockers
none

## Class setting
- Class: `class.elpres` options: `16x9` (main.tex:1). The CTAN page says the class is derived from `article`, has a 4:3 virtual page by default and offers 16:9 and 16:10; it does not name the option spellings, so `16x9` is read from the sample.
- Class-native vocabulary used: unheaded slide environment `rsli` (main.tex:8-13 title slide, main.tex:51-55 closing slide); headed slide environment `psli[title]` with the slide title as optional argument (main.tex:15, 23, 31, 43); list environments `citemize` (main.tex:16), `cenumerate` (main.tex:24), `cdescription` with `\item[label]` (main.tex:44-47). Roles are inferred from use only; the `c` prefix suggests compact lists, but that is a guess.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.elpres` | option `16x9` |
| slide page size | main.tex:1 | `page.class-options` | `16x9` (aspect ratio of the virtual page, set by the class option; no `geometry`, no length) |
| input encoding | main.tex:3 | `font.fontenc-t1` | `inputenc` option `utf8` |
| font encoding | main.tex:4 | `font.fontenc-t1` | `fontenc` option `T1` |
| unheaded slide (title and closing) | main.tex:8-13, 51-55 | `class.elpres` | `rsli` environment, no argument |
| headed slide | main.tex:15-21, 23-29, 31-41, 43-49 | `class.elpres` | `psli[Why Migrate]`, `psli[Migration Plan]`, `psli[Packet Loss, Before and After]`, `psli[What's Left]` |
| slide heading | main.tex:15, 23, 31, 43 | `head.class-native` | the heading is the optional argument of `psli` (a string); its font, rule and position are the class's own and were not read |
| title block, hand laid | main.tex:9-12 | `sp.ragged` | kernel `center` environment inside `rsli` (no `\maketitle`, no `\title`) |
| title and subtitle fonts | main.tex:10-11 | `font.size-commands`, `mark.kernel` | `\Large` and `\bfseries` for the title, `\normalsize` and `\mdseries` for the subtitle |
| title to subtitle gap | main.tex:10 | `sp.manual-space` | `\\[1em]` |
| closing slide text | main.tex:52-54 | `sp.ragged`, `font.size-commands` | `center` with `\Large` (main.tex:53) |
| bulleted list | main.tex:16-20 | `class.elpres` | `citemize`, three `\item` |
| numbered list | main.tex:24-28 | `class.elpres` | `cenumerate`, three `\item` |
| description list | main.tex:44-48 | `class.elpres` | `cdescription`, three `\item[label]` |
| list items | main.tex:17-19, 25-27, 45-47 | `list.kernel` | kernel `\item`, and `\item[label]` in the description list (main.tex:45-47) |
| table | main.tex:33-39 | `tbl.tabular` | `tabular{lcc}`, header row (main.tex:34), one `\hline` under it (main.tex:35), three data rows; no float, no caption, no `booktabs` |
| table centring | main.tex:32, 40 | `sp.ragged` | `center` environment around the `tabular` |

Components the sample does not define or use: page geometry, columns, header and footer, colours, backgrounds, language, metadata, hyperlinks, abstract, contents, section headings and numbering, quotes, notes, footnotes, math, theorems, figures, captions, code, boxes, bibliography, index, cross-references. Whatever the slides show for these comes from the class's defaults, which were not read.

## Bespoke code
none (main.tex defines no macro, environment, counter, length or conditional; the search is described under Verdict; the class is published, not zip-local)

## Content-opaque
none (the one table at main.tex:33-39 holds plain text cells; `40{,}000` at main.tex:11 and the `\%` numbers at main.tex:27, 36-38, 47 are content)

## Lib changes
- New ways proposed: none. Considered and not proposed: a `list.class-native` line for `citemize` `cenumerate` `cdescription` and a `slide.class-native` line for `rsli` and `psli` (the lib folds a published class's own vocabulary into its class way, change log v3 and v4), and `slide.beamer-theme` (beamer only; `elpres` is derived from `article`, not beamer).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
- Notes for the consolidator: `class.elpres` is a published class (ctan.org/pkg/elpres: LPPL, v1.1, 2024-05-29, in TeX Live and MiKTeX); its vocabulary as seen in this sample is recorded under Class setting; the zip does not bundle the class, so its source was not read here.
