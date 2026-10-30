no

# 0039-vertical-line-title-page: Vertical Line Title Page

- Unverified: read from the source, not compiled.
- Source: Source/0039-vertical-line-title-page/ (origin: https://latextemplates.com/downloads/vertical-line-title-page.zip; licence: Public-Domain)
- Kind: misc (a title-page starter: a one-page article sample with title, abstract and two sections)
- Lib: v1
- Engine: pdfLaTeX-compatible (`titlepic` and `tikz` need no Unicode engine)
- Look carried by: preamble (kernel `article` with the `titlepage` option; `titlepic` plus one TikZ picture in the preamble, main.tex:1-20, are the whole look; the zip ships no .cls, .sty or other style file)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
no. The zip is one 54-line `main.tex` on kernel `article`, and every ordinary component (title block, abstract, headings) is a lib way. The one thing that makes this a template is a hand-drawn TikZ device, a vertical rule with a short tick at each end, hung on the title page through `\titlepic` (main.tex:14-20). The file's own comment calls it the title page's distinct look (main.tex:10-13), so under the rubric it is template-defining artwork, `ART`, and no declarative lib way holds it. Rebuilding it from `sp.rule` would mean hand-placing three rules in one box, which is box-and-glue positioning, not parameters of a way.

## Blockers
- `ART/preamble` TikZ drawing of a 3.2 cm vertical line (line width 0.6pt) with 0.3 cm horizontal ticks at both ends, passed to `\titlepic` as the title page's device (main.tex:14-20; stated purpose main.tex:10-13)

## Class setting
- Class: `class.article` options: `titlepage` (main.tex:1)
- Class-native vocabulary used: `\title`, `\author` (with `\\` inside), `\date{\today}`, `\maketitle` (main.tex:6-8, 24); `abstract` environment (main.tex:26-34); `\section` (main.tex:36, 45). The `titlepage` option makes `\maketitle` a page of its own. Kernel `article` source not read (not in the zip).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.article` | `titlepage` |
| page geometry | none set; class defaults | n/a | no `geometry`, no `\setlength` |
| header/footer | none set; class defaults | n/a | no `\pagestyle`, no `fancyhdr` |
| fonts, colour, spacing | none set; class defaults | n/a | no font, `xcolor` or `setspace` package loaded |
| title block | main.tex:6-8, 24 | `front.maketitle` | `\title{Groundwater Recharge in Semi-Arid Basins}`, `\author{N. Farouk \\ Department of Hydrology}`, `\date{\today}`, `\maketitle`; own page from the `titlepage` option |
| title-page picture slot | main.tex:3, 14-20 | `front.titlepic` | `\usepackage{titlepic}`, `\titlepic{...}` with one content argument (here the TikZ picture below), set in the preamble before `\maketitle` |
| title-page device (vertical line with end ticks) | main.tex:4, 14-20 | `art.tikz` (ART) | `tikzpicture` with three `\draw[line width=0.6pt]`: (0,0)--(0,3.2), (-0.15,0)--(0.15,0), (-0.15,3.2)--(0.15,3.2) |
| abstract | main.tex:26-34 | `abs.kernel` | `abstract` environment, no options |
| headings | main.tex:36, 45 | `head.kernel` | `\section` at default numbering and format |
| lists, theorems, floats, code, bibliography, index | none in the sample | n/a | not used |

## Bespoke code
none. The zip has no `\newcommand`, `\def`, counter, environment or zip-local file; the only non-text construct is the TikZ picture, recorded as `ART` above, not as bespoke code.

## Content-opaque
none. The TikZ picture is not inside a figure or table float: it fills the title page's picture slot and is described in the file as the title page's identity (main.tex:10-13), so it is a blocker, not content.

## Lib changes
- New ways proposed: `front.titlepic` `titlepic` package (CTAN, Public Domain, in TeX Live; ctan.org/pkg/titlepic read; package source not read), engine pdf. It adds a `\titlepic{...}` picture slot to the kernel `\maketitle`. W1: published on CTAN. W2: the way is one command whose single argument is content (normally `\includegraphics`), and it needs no code editing. W3: serves any title page. W4: the emitter writes `\usepackage{titlepic}` and `\titlepic{...}` in the preamble. It is a thin way and could instead be folded into `front.maketitle`; where the picture sits relative to the title is package-defined and was not read.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
