yes

# 0277-fancyslides-presentation: FancySlides Presentation

- Unverified: read from the source, not compiled.
- Source: Source/0277-fancyslides-presentation/ (origin: https://latextemplates.com/downloads/fancyslides-presentation.zip; licence: LPPL-1.3a)
- Kind: presentation
- Lib: v3
- Engine: pdfLaTeX-compatible (README.md:27-28 says the class's own README asks for pdflatex; the sample loads only `inputenc` and `times`, main.tex:2-3)
- Look carried by: class (the published `fancyslides` class draws every slide type; `main.tex` adds a few beamer settings, three colour/opacity hooks and title data)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present (the zip holds only `main.tex` and `README.md`; `fancyslides.cls` is not bundled, README.md:19-21)

## Verdict
Yes. The whole look is carried by the published class `fancyslides` (CTAN, LPPL, built on beamer), which is not bundled in the zip, so its source was not read; it counts as one `class.fancyslides` way. The sample adds only published beamer preamble calls (`\usetheme`, `\setbeamertemplate`, `\setbeamercolor`), two PSNFSS/kernel package loads, `\newcommand` lines that hand values to the class's documented hooks, and body commands from the class's own vocabulary. No zip-local class, style, TikZ or drawing code exists in the zip, and nothing needs a tool outside TeX in anything that was read. Caveat: what `fancyslides.cls` itself loads or draws was not examined; the CTAN page (ctan.org/pkg/fancyslides, v1.0, 2015-02-12, LPPL 1.3) names no other packages and says all beamer commands should work.

## Blockers
none

## Class setting
- Class: `class.fancyslides` options: none (main.tex:1). Per README.md:32-33 the class is `\LoadClassWithOptions{beamer}`, so beamer's `frame` and `block` and the beamer theme commands work beside it (class source not read).
- Class-native vocabulary used: `\startingslide` (main.tex:32), `\pointedsl{}` (35), `\framedsl{}` with `\pitem{}` and `\fitem{}` (39, 51), `\itemized{}` (43-47), `\misc{}` (55-64), `\thankyou` (68), `\sources{}` (72-76); hook macros `\strcolor` (17), `\structureopacity` (16), `\yourowntexcol` (20, used at 8-9), and title data `\titlephrase` `\name` `\affil` `\email` (25-28). Inherited from beamer: `frame` (34, 38, 42, 50, 54, 67, 71), `block` (56), `\usetheme` (6), `\setbeamertemplate` (7), `\setbeamercolor` (8-9). The class's `\fbckg{<image>}` background command exists (README.md:50-52) but the sample does not use it.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class | main.tex:1; README.md:32 | `class.fancyslides` | no options |
| page size / frame shape | main.tex:1 | `page.class-options` | no option given; the page is whatever the class and beamer set (nothing set in the sample) |
| input encoding | main.tex:2 | `font.fontenc-t1` | `inputenc` option `utf8`; no `fontenc` |
| text face | main.tex:3 | `font.mathptmx` | package `times`, no options |
| beamer theme | main.tex:6 | `slide.beamer-theme` | `\usetheme{default}` |
| navigation symbols off | main.tex:7 | `slide.beamer-template` | `\setbeamertemplate{navigation symbols}{}` |
| structure and body text colour | main.tex:8-9 | `slide.beamer-template` | `\setbeamercolor{structure}{fg=\yourowntexcol}`, `\setbeamercolor{normal text}{fg=\yourowntexcol}` (the macro is defined later, at line 20) |
| class hooks: box opacity, box colour, text colour | main.tex:16, 17, 20; README.md:47-49 | `class.fancyslides` | `\structureopacity`=0.75, `\strcolor`=blue (class offers blue, orange, green: main.tex:17), `\yourowntexcol`=white |
| title slide data | main.tex:25-28 | `class.fancyslides` | `\titlephrase`, `\name`, `\affil`, `\email` set to plain strings |
| title slide | main.tex:30-32; README.md:35-37 | `front.class-native` | `\startingslide` builds the slide from the four data macros |
| slide frames | main.tex:34, 38, 42, 50, 54, 67, 71 | `class.fancyslides` | beamer `frame`, no title argument, no options |
| pointed slogan slide | main.tex:35; README.md:38 | `class.fancyslides` | `\pointedsl{scope it small}` (circular slogan) |
| framed slogan slide | main.tex:39; README.md:39 | `class.fancyslides` | `\framedsl{...}` (rectangular box) |
| framed build-up list | main.tex:51; README.md:39-41 | `class.fancyslides` | `\framedsl{\pitem{scope} \pitem{build} \fitem{demo}}`; `\pitem` pauses, `\fitem` does not |
| boxed list | main.tex:43-47; README.md:42 | `class.fancyslides`, `list.kernel` | `\itemized{...}` with three `\item` (kernel item command; whether the class opens `itemize` itself is not verified) |
| boxed free-content slide | main.tex:55-64; README.md:43-44 | `class.fancyslides` | `\misc{...}` around a beamer `block` |
| block title and body sizes | main.tex:56, 58 | `font.size-commands` | `\Huge` on the block title, `\Large` around the body |
| bold title | main.tex:56 | `mark.kernel` | `\bf` (kernel font switch) |
| manual breaks | main.tex:57, 59-60 | `sp.manual-space` | `~\\` and `\\` line breaks |
| thank-you slide | main.tex:68; README.md:45 | `class.fancyslides` | `\thankyou` |
| sources slide | main.tex:72-76; README.md:46 | `class.fancyslides` | `\sources{...}` |
| inline monospace | main.tex:73 | `mark.kernel` | `\texttt{fancyslides}` |

Not in this sample (nothing to map): headings, abstract, contents, theorems, tables, figures, captions, code, bibliography, index, cross-references, headers and footers beyond the class's own.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\newcommand{\structureopacity}`, `{\strcolor}`, `{\yourowntexcol}` | main.tex:16, 17, 20 | yes | values for the class's documented hooks (README.md:47-49): a number, a colour name, a colour name; an emitter prints three `\newcommand` lines before `\begin{document}` under `class.fancyslides` |
| `\newcommand{\titlephrase}`, `{\name}`, `{\affil}`, `{\email}` | main.tex:25-28 | yes | string data read by `\startingslide` (README.md:35-37); the strings are content |
| `fancyslides.cls` (slide shapes, boxes, hooks) | not in the zip | n/a | published class (CTAN, LPPL, README.md:9, 56-57), one way `class.fancyslides`; source not read |

Order note for an emitter: `\setbeamercolor` (main.tex:8-9) uses `\yourowntexcol` before it is defined (main.tex:20). Keeping the source order is the safe choice; whether beamer expands the name at line 8 or later was not checked.

## Content-opaque
none (the slide texts at main.tex:35, 39, 44-46, 51, 56-61, 73-75 are content)

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
