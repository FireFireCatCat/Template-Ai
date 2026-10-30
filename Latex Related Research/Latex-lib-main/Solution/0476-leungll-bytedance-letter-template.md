yes

# 0476-leungll-bytedance-letter-template: ByteDance Letter Template (recommendation letter)

- Unverified: read from the source, not compiled.
- Source: Source/0476-leungll-bytedance-letter-template/ (origin: https://codeload.github.com/leungll/ByteDance-Letter-Template/zip/refs/heads/master; licence: Apache-2.0)
- Kind: letter
- Lib: v4
- Engine: pdfLaTeX-compatible (README.md:105 says `pdflatex main`; no `fontspec`, no Lua code, PNG images only)
- Look carried by: preamble (main.tex only: the preamble sets geometry and a page-background picture, and the body hand-lays the letterhead and signature block; no zip-local `.cls`/`.sty`; the kernel `letter` class is loaded unchanged and none of its letter commands is called)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none; `letterContent.tex` is its `\input` body text, `main.pdf` is a prebuilt output and was not used as evidence)
- Read: main yes, zip-local classes and styles none present

## Verdict
Every construct in `main.tex` and `letterContent.tex` is a kernel command or a published package (`geometry`, `eso-pic`, `adjustbox`, `hyperref`, `graphicx`, `xcolor`) with declarative parameters. The only zip-local macro is `\BackgroundPicture`, a zero-argument alias for the content of one `\AddToShipoutPicture`; it reduces by inline expansion. The page background is one included raster image centred in a full-page `\parbox`, with no TikZ, PGF or PSTricks drawing, so I do not count it as `ART`. There is no external tool. Verdict yes.

## Blockers
none

## Class setting
- Class: `class.letter` options: `12pt`, `a4paper` (main.tex:1). The class is the kernel `letter` class, not bundled in the zip; its source was not read.
- Class-native vocabulary used: none of the letter-specific commands. The sample never uses the `letter` environment, `\opening`, `\closing`, `\signature`, `\address`, `\name`, `\ps` or `\encl` (main.tex:24-59). Only `\today` and `\footnote` appear, and both are kernel commands. The class contributes its defaults only (page style, paragraph shape, `\today`), which are the class's own parameters and are set nowhere in the zip.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.letter` | `12pt`, `a4paper`; no letter environment used |
| paper and text size | main.tex:1 | `page.class-options` | `a4paper`, `12pt` |
| page geometry | main.tex:4, main.tex:10 | `page.geometry` | `top=1in, bottom=1in, left=1in, right=1in` |
| hyperlink setup | main.tex:3, main.tex:9 | `meta.hyperref` | package loaded with no options; `\hypersetup{hidelinks}` |
| figure and image package | main.tex:2 | `fig.graphicx` | package loaded with no options |
| image option extension | main.tex:6 | `fig.adjustbox` | `[export]`; no adjustbox-specific key is used in the body (the `\includegraphics` keys at main.tex:17, 26, 51 are graphicx keys) |
| colour package | main.tex:7 | `color.xcolor` | load-only: no `\definecolor`, `\colorlet` or colour command anywhere in the zip's `.tex` files |
| page background overlay | main.tex:5, main.tex:22 | `bg.eso-pic` | `\usepackage{eso-pic}`; `\AddToShipoutPicture{\BackgroundPicture}` puts the overlay on every page |
| background overlay: positioning box | main.tex:15 | `box.minipage` | `\put(0,0){\parbox[b][\paperheight]{\paperwidth}{...}}`: bottom-aligned box of full paper height and width, placed at the page origin |
| background overlay: vertical centring | main.tex:16, main.tex:18 | `sp.manual-space` | `\vfill` above and below the image |
| background overlay: horizontal centring | main.tex:17 | `sp.ragged` | `\centering` |
| background overlay: image | main.tex:17 | `fig.graphicx` | `\includegraphics[width=0.3\paperwidth,height=0.3\paperheight,keepaspectratio]{pic/ByteDance_Logo_Bg.png}`; any transparency is in the PNG (README.md:85), no `transparent` package |
| letterhead layout | main.tex:25-37 | `cols.minipage` | two `minipage`s on one line: `{0.5\textwidth}` and `{0.6\textwidth}`, separated by `\hfill` (main.tex:28); the widths sum to 1.1 of the text width, copied as written |
| letterhead boxes | main.tex:25, main.tex:29 | `box.minipage` | `\begin{minipage}{<width>}` wrappers |
| letterhead logo | main.tex:26 | `fig.graphicx` | `\includegraphics[width=3in]{pic/ByteDance_Logo.png}` outside any float, then `\\` |
| letterhead address block alignment | main.tex:29 | `sp.ragged` | `\raggedright` |
| letterhead address block size | main.tex:30-36 | `font.size-commands` | `\small{...}` as a braced group |
| letterhead address indent and line breaks | main.tex:31-35 | `sp.manual-space` | `\hphantom{AA}` at the start of each line (a kernel horizontal-space command of the same family as `\hspace`) and `\\` at the end of each line |
| gap below letterhead | main.tex:39 | `sp.manual-space` | `\vspace{0.4in}` |
| date line | main.tex:41 | `front.datetime` | kernel `\today` in its default format, no `datetime` package and no `\newdateformat` (the lib line names `\today` as the printing command; the package is the parameter and here there is none) |
| subject line in bold | main.tex:43 | `mark.kernel` | `\textbf{Recommendation Letter for Ms. Lili Liang...}` |
| footnote on the subject line | main.tex:43 | `fn.kernel` | `\footnote{\textbf{Lili Liang}. ``ByteDance Letter Template'' ...}`; `\textbf` inside is `mark.kernel`; hyperref turns the marker into a link, hidden by `hidelinks` |
| salutation | main.tex:45 | `sp.manual-space` | plain text `To Whom It May Concern:` ended with `\\`; the class's `\opening` is not used |
| letter body input | main.tex:47 | `struct.input` | `\input{letterContent}` |
| body paragraphs | letterContent.tex:1-15 | `sp.manual-space` | plain text; blank lines between paragraphs and `\\` at the end of lines 1, 8 and 13 (README.md:92 says to use `\\` for line breaks) |
| complimentary close | main.tex:49 | `sp.manual-space` | plain text `Sincerely yours,` (no `\closing`); paragraph breaks only |
| signature image | main.tex:51 | `fig.graphicx` | `\includegraphics[width=2in]{pic/signature.png}` outside any float |
| sender block lines | main.tex:53-58 | `sp.manual-space` | plain text lines ended with `\\` |
| email and web links | main.tex:57, main.tex:58 | `meta.hyperref` | `\href{mailto:...}{...}` and `\url{...}`; both commands are supplied by the loaded hyperref (`meta.url` names the `url` package, which the sample does not load itself) |

Components the sample does not define or use: headers and footers (no `\pagestyle`, no `fancyhdr`), fonts, language, abstract, contents, headings, numbering, lists, quotes, math, theorems, tables, captions, code, bibliography, index, cross-references. The page style and paragraph shape are the `letter` class defaults.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\newcommand\BackgroundPicture` | main.tex:13-21 | yes | A zero-argument alias, called once (main.tex:22). Inline it into `\AddToShipoutPicture{\put(0,0){\parbox[b][\paperheight]{\paperwidth}{\vfill\centering\includegraphics[width=0.3\paperwidth,height=0.3\paperheight,keepaspectratio]{pic/ByteDance_Logo_Bg.png}\vfill}}}`: `bg.eso-pic` + `box.minipage` + `sp.manual-space` + `sp.ragged` + `fig.graphicx`. No counter, conditional or output-routine code. |

No other `\newcommand`, `\def`, environment, counter or conditional exists in `main.tex` or `letterContent.tex`. The zip holds no `.cls`, `.sty`, `.def`, `.cfg`, `.clo`, `.bst` or `.dtx`.

## Content-opaque
none. The three images the template uses (`pic/ByteDance_Logo.png`, `pic/ByteDance_Logo_Bg.png`, `pic/signature.png`) are shipped in the zip, so no asset is missing. Four more logos in `pic/` (Alibaba, Meituan, Pinduoduo, Tencent) and the three screenshots in `sample/` are not referenced by the `.tex` files.

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- Judgement call on `ART`: the page background is `\put(0,0){\parbox...}` inside `\AddToShipoutPicture`. `\put` only places a box at a point here; nothing is drawn (no line, shape or path), and the picture is one raster logo. The lib treats `bg.eso-pic` as a declarative overlay way and carries the `ART` caveat only on `bg.tikzpagenodes`. If a reviewer reads a page-wide logo as template-defining artwork, the same sample would flip to `no` on this one point; I read it as the overlay way used as intended.
- Judgement call on `\today`: no lib line names the kernel date command without a package. I filed it under `front.datetime` because that line already names `\today` as the printing command and says the package is the parameter. It could also be read as a text token (content), which gives the same verdict.
- Judgement call on `\hphantom`: filed under `sp.manual-space` as a kernel spacing command; the lib line names `\hspace`, `\hfill` and others as examples, not a complete list.
- The letter class is used as a plain article-like shell here: the sample bypasses `\opening` and `\closing` and builds the letterhead and the close by hand, so `ltr.opening` is not a way this zip uses.
- No instruction addressed to an AI was found in the zip's text files (README.md, README_zh.md, main.tex, letterContent.tex, .gitignore).
