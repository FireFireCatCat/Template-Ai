yes

# 0314-tsinghua-letterhead: Tsinghua Letterhead

- Unverified: read from the source, not compiled.
- Source: Source/0314-tsinghua-letterhead/ (origin: https://latextemplates.com/downloads/tsinghua-letterhead.zip, repackaged from the Overleaf gallery template "A Simple Tsinghua Letterhead Template" by 文豪, ATTRIBUTION.txt:1-4; licence: CC-BY-4.0)
- Kind: letter
- Lib: v3
- Engine: needs XeLaTeX (`fontspec` main.tex:3 and `xeCJK` main.tex:4; README.md:10-11 says "Compile with XeLaTeX")
- Look carried by: preamble (the zip holds no class or style file; the letterhead is a `fancyhdr` page style plus `geometry` and fonts, all in the sample's preamble)
- Class origin: tex-distribution-unbundled (kernel `article`, not in the zip; its source was not read)
- Main file: main.tex (other samples: none)
- Read: main yes (all 53 lines), zip-local classes and styles none present (the zip is main.tex, README.md, ATTRIBUTION.txt)

## Verdict
The whole template is one 53-line `article` document with a published preamble: `geometry` margins, a redefined `plain` page style from `fancyhdr` that carries the letterhead (header left and right, footer address block with a rule), `fontspec`/`xeCJK` fonts, `zhnumber` for the Chinese date, and kernel alignment, spacing and size commands in the body. There is no zip-local class, style, `\newcommand`, `\def`, environment, counter or artwork (grep of main.tex finds `\renewcommand` only at main.tex:17, for the published `\footrulewidth` length). Every component maps to a lib way and nothing needs a new way, so `yes`. The class is plain `article` and the page is hand-laid, so the letter classes and `ltr.opening` are not used.

## Blockers
none

## Class setting
- Class: `class.article` options: `12pt` (main.tex:2); no paper option, so the class default paper size.
- Class-native vocabulary used: none. The sample uses no `\maketitle`, `abstract`, `\section` or other article-native command; it uses only kernel `flushright`, `\vspace`, `\\` and font-size switches.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:2 | `class.article` | `12pt` |
| paper and base size | main.tex:2 | `page.class-options` | `12pt` only |
| page geometry | main.tex:5 | `page.geometry` | left=3cm, right=3cm, top=4.2cm, bottom=3cm, footskip=2cm, headheight=2.2cm, headsep=1cm |
| Latin main font | main.tex:3, main.tex:10 | `font.fontspec` | `\setmainfont{TeX Gyre Termes}` (sans and mono left at defaults) |
| Chinese text support and CJK font | main.tex:4, main.tex:11 | `lang.cjk` | package `xeCJK`, `\setCJKmainfont{FandolSong-Regular.otf}` |
| letterhead header and footer (the page style) | main.tex:6, main.tex:13-21 | `hf.fancyhdr` | `\fancypagestyle{plain}{...}`, `\fancyhf{}`, `\fancyhead[L]` "Tsinghua University", `\fancyhead[R]` "Department of Mathematical Sciences", `\renewcommand{\footrulewidth}{.4pt}`, `\fancyfoot[L]` four-line address block |
| page style selection | main.tex:22 | `hf.pagestyle-kernel` | `\pagestyle{plain}` (activates the redefined `plain`) |
| page numbers off | main.tex:23 | `pgnum.pagenumbering` | `\pagenumbering{gobble}` |
| header font switches | main.tex:15-16 | `mark.kernel` | `\sffamily` |
| header and footer sizes | main.tex:15-16, main.tex:18 | `font.size-commands` | `\small` (header), `\footnotesize` (footer) |
| footer address line breaks | main.tex:19 | `sp.manual-space` | `\\` |
| footer e-mail link and link look | main.tex:8, main.tex:20 | `meta.hyperref` | `\usepackage[hidelinks]{hyperref}`, `\href{mailto:...}{...}` (link command of the same package; `xref.hyperref` not used) |
| date line, right aligned | main.tex:26-28 | `sp.ragged` | `flushright` environment (kernel alignment family of `\raggedleft`) |
| Chinese date | main.tex:9, main.tex:27 | `front.datetime` | package `zhnumber`, `\zhtoday` (a date-printing package is the parameter, lib v3 change log; considered `mark.numspell`, a spelled-numbers package, as the alternative home) |
| vertical gaps | main.tex:30, main.tex:33, main.tex:47 | `sp.manual-space` | `\vspace{1.2cm}`, `\vspace{1em}`, `\vspace{2em}` |
| salutation size | main.tex:31 | `font.size-commands` | `\Large` |
| salutation paragraph start | main.tex:31 | `sp.lengths` | `\noindent` (nearest home: paragraph indentation, the `\parindent` family; the only command here that is not a named example) |
| body size | main.tex:34 | `font.size-commands` | `\large` (stays in force to the end of the document) |
| paragraph indent | main.tex:35 | `sp.lengths` | `\setlength{\parindent}{2em}` |
| signature block, right aligned | main.tex:48-52 | `sp.ragged`, `sp.manual-space` | `flushright` environment, `\\` line breaks |
| tables (loaded, not used) | main.tex:7 | `tbl.tabularx` | `\usepackage{tabularx}`; no `tabularx` environment in the body, so nothing to print beyond the load line |
| letter structure | main.tex:26-52 | none (plain paragraphs) | salutation, body and signature are ordinary paragraphs; `\opening`/`\closing` and `ltr.opening` are not used, the letterhead is the `fancyhdr` page style above |

## Bespoke code
none (no `\newcommand`, `\def`, `\newenvironment`, `\newcounter`, conditional or zip-local `.cls`/`.sty` anywhere; main.tex:17 is a `\renewcommand` of a published `fancyhdr` length)

## Content-opaque
none (the only artwork, the upstream logo, was removed: README.md:8-10; the header is text only, main.tex:15-16). Missing assets: `TeX Gyre Termes` and `FandolSong-Regular.otf` are not in the zip; both are installed fonts under the usual TeX distributions, so an emitter would rely on the font being present or ship it.

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- `\zhtoday` is from `zhnumber`, which is on CTAN (ctan.org/pkg/zhnumber read once: "Typeset Chinese representations of numbers", v3.1). The CTAN page does not mention `\zhtoday`; that it prints today's date in Chinese numerals is from my knowledge of the package, not from reading its source here.
- The `xeCJK` and `fontspec` loads and the Fandol font choice make the engine XeLaTeX; the way ids `lang.cjk` and `font.fontspec` already carry the `xe/lua` tag in the lib.
