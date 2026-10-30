yes

# 0917-hagenberg-thesis: Hagenberg Thesis (hgbthesis class starter)

- Unverified: read from the source, not compiled.
- Source: Source/0917-hagenberg-thesis/ (origin: https://latextemplates.com/downloads/hagenberg-thesis.zip; licence: CC-BY-4.0)
- Kind: thesis
- Lib: v6
- Engine: pdfLaTeX-compatible (README.md:8 says pdflatex; main.tex:22 loads `inputenc`; nothing compiled here)
- Look carried by: class (the whole look is the published `hgbthesis` class; main.tex adds class options, class-native front-matter fields, chapters, one citation and the bibliography call)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
`yes`. The zip holds one 84-line `main.tex`, one `.bib`, one logo PDF and two text files; no zip-local `.cls`, `.sty`, `.def` or `.cfg` exists. The look is set by the published class `hgbthesis` of the CTAN package `hagenberg-thesis` (in TeX Live and MiKTeX), which the zip does not bundle (README.md:13-14, main.tex:14). It is one `class.hgbthesis` way with the options at main.tex:23, and its source was not read. Everything else in the sample is class-native front-matter fields, `\chapter`/`\section`, `\tableofcontents`, one `\autocite` and `\MakeBibliography`. The sample's only own code is a three-line kernel shim (main.tex:36-38) that has no printed effect and no macro logic; it reduces to one raw kernel preamble line, and it is the one judgement call in this verdict (if a reviewer holds that patching a class's internal call is irreducible, the verdict flips to `no` with `BESPOKE/preamble`). Limit: what the class loads inside (page, fonts, headers, headings, floats, maths, listings, language packages) is not visible in the zip, so those components are carried by the class way and not decomposed; a hidden unconditional tool-dependent package inside the class (the `minted` kind) cannot be excluded by reading. The one tool the zip names is biber, loaded through biblatex (README.md:48-49), which is the tool of the lib way `bib.biblatex-biber` and not an `EXTERNAL` blocker.

## Blockers
none

## Class setting
- Class: `class.hgbthesis` options: `type=master`, `theme=default`, `language=english`, `titlelanguage=english`, `smartquotes=true`, `updatecheck=false` (main.tex:23)
- Class origin evidence: ctan.org/pkg/hagenberg-thesis (read once): "Collection of LaTeX classes, style files and example documents for academic manuscripts", maintainers Wilhelm Burger and Wolfgang Hochleitner, licences CC BY 4.0 and CC BY-SA 4.0, version 2026-10-22, listed in TeX Live and MiKTeX. The page names no individual class and states no engine or dependencies, so the name `hgbthesis` rests on main.tex:23 and the manifest. The zip's own notes say the package ships with TeX Live and is not bundled (README.md:13-14). The zip is not the publisher's kit (latextemplates.com origin), so the origin is `tex-distribution-unbundled`.
- Class-native vocabulary used (all in main.tex, class source unread, names only): `\subtitle` (45), `\programtype` (48), `\programname` (49), `\institution` (50), `\placeofstudy` (52), `\dateofsubmission{Y}{M}{D}` (53), `\advisor` (55), `\license{cc}` (57), `\frontmatter` (59), `\mainmatter` (63), `\backmatter` (81), `\MakeBibliography` (82), preamble `\bibliography{references}` (40); kernel-named `\title` `\author` `\maketitle` (44, 46, 60); biblatex `\autocite` (70).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:23 | `class.hgbthesis` | type=master, theme=default, language=english, titlelanguage=english, smartquotes=true, updatecheck=false |
| input encoding | main.tex:22 | `font.fontenc-t1` | `\RequirePackage[utf8]{inputenc}` placed before `\documentclass` |
| language, title language, smart quotes | main.tex:23 | `class.hgbthesis` | class options `language=english` `titlelanguage=english` `smartquotes=true`; the language and quotation packages behind them are in the unread class, so no separate way is claimed |
| page, fonts, headers/footers, colour, spacing, captions, floats, maths | not in the zip | `class.hgbthesis` | set inside the class; the sample uses none of these constructs |
| title, author, title block call | main.tex:44, 46, 60 | `front.maketitle` | `\title{..}` `\author{..}` `\maketitle`; the class sets the layout |
| title-page fields and theme logo | main.tex:45, 48-55; README.md:35-44 | `front.class-native` | `\subtitle` `\programtype` `\programname` `\institution` `\placeofstudy` `\dateofsubmission{2026}{06}{01}` `\advisor`; `theme=default` includes the crest `hgbtheme-default-logo.pdf` (a shipped PDF image, no TikZ in the zip) |
| licence notice | main.tex:57 | `front.class-native` | `\license{cc}`; considered `doclicense`, not claimed because the class source is unread |
| front, main, back matter | main.tex:59, 63, 81 | `front.class-native` | `\frontmatter` `\mainmatter` `\backmatter` (class vocabulary) |
| contents | main.tex:61 | `toc.kernel` | `\tableofcontents`; entry look set by the class |
| chapters and sections | main.tex:65, 69, 72, 75, 78 | `head.class-native` | `\chapter` `\section`; look set by the class and its options |
| citation | main.tex:70; references.bib:1-6 | `bib.biblatex-biber` | `\autocite{knuth1984texbook}`; the `date` field (references.bib:5) is a biblatex field |
| bibliography | main.tex:40, 82; README.md:46-54 | `bib.biblatex-biber` | `\bibliography{references}` and `\MakeBibliography`; the class loads biblatex with `backend=biber` (README.md:48-49) |
| compile shim for the class's internal `\DocumentMetadata` call | main.tex:36-38; README.md:24-34 | `class.hgbthesis` | raw kernel preamble line `\makeatletter\let\DocumentMetadata\@gobble\makeatother`, emitted with this class; no printed effect; see Bespoke code |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\makeatletter \let\DocumentMetadata\@gobble \makeatother` | main.tex:36-38 (reason: main.tex:25-35, README.md:24-34) | yes | Kernel commands only (`\makeatletter`, `\let`, kernel `\@gobble`, `\makeatother`). No macro, counter, conditional or environment is defined. Its whole effect is to make the class's own `\DocumentMetadata` call a no-op (the README says no PDF metadata or PDF/A support is wanted, README.md:30-32), so the text of the page is unchanged. An emitter prints it as one raw preamble line next to `class.hgbthesis`. No lib way is stretched to cover it: `meta.documentmetadata` calls the command, this line disables it. |

No `\newcommand`, `\def`, `\newenvironment`, counter, conditional or other definition exists in main.tex, and no zip-local class or style exists.

## Content-opaque
none (the logo `hgbtheme-default-logo.pdf` is a shipped asset included by the class theme, README.md:35-44; it is not drawn in TeX and was not opened, being a binary PDF)

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
