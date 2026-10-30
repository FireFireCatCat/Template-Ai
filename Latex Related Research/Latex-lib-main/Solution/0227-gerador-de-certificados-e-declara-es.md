no

# 0227-gerador-de-certificados-e-declara-es: Gerador de Certificados e Declarações

- Unverified: read from the source, not compiled.
- Source: Source/0227-gerador-de-certificados-e-declara-es/ (origin: https://latextemplates.com/downloads/gerador-certificados-declaracoes.zip; licence: not established, the manifest says UNKNOWN and README.md:9-10 says the upstream licence and asset provenance were not stated)
- Kind: misc (a one-page Portuguese certificate / declaration of participation)
- Lib: v2
- Engine: pdfLaTeX-compatible (`inputenc`, `fontenc`, `tikz`; the `remember picture,overlay` frame needs the usual second run, main.tex:12)
- Look carried by: preamble (class `article` unchanged and nothing zip-local; the page setup and colour are in the sample preamble, main.tex:1-10, and the certificate layout and the page frame are in the sample body, main.tex:12-40)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present (the zip holds only main.tex and README.md)

## Verdict
no. Everything except the page frame maps onto lib ways: kernel `article`, `geometry`, `xcolor`, kernel spacing and font switches, and an `array` tabular for the signature lines. The double border around the page is a TikZ overlay of two rectangles anchored to the page corners with `current page` (main.tex:12-19). It is the template's identity, not figure content, and I could not show that a declarative lib way reproduces it, so it is `ART` and the answer is `no`. No `babel` or `polyglossia` is loaded although the text is Portuguese (main.tex:2-3, 21-33); that is recorded, not a blocker.

## Blockers
- `ART/body` the page frame: a `tikzpicture[remember picture,overlay]` draws two nested rectangles, 2pt and .5pt, in `certificateblue`, offset 1.1cm and 1.35cm from the corners of `current page` (main.tex:12-19). `bg.tikzpagenodes` is the lib way for such an overlay and the lib marks it ART when it draws the template's identity; its drawing commands are a TikZ program, not option values. Considered: `fancybox` `\fancypage` with `\doublebox` (frames the text block, not offsets from the page edge, and I did not read its source to show the two independent rule widths can be set) and `tcolorbox` `enhanced` with `borderline` (a page-anchored border still needs a TikZ `overlay`). Neither is established, so the frame stays ART.

## Class setting
- Class: `class.article` options: `12pt`, `a4paper` (main.tex:1)
- Class-native vocabulary used: none of article's front matter (no `\title`, `\maketitle` or `abstract`); the sample uses only `center` and `tabular`, and sets the title-like lines by hand (main.tex:21-33)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.article` | 12pt, a4paper |
| paper and base size | main.tex:1 | `page.class-options` | a4paper, 12pt |
| page geometry | main.tex:4 | `page.geometry` | margin=2.2cm |
| input and font encoding | main.tex:2, main.tex:3 | `font.fontenc-t1` | inputenc utf8, fontenc T1 |
| header/footer | main.tex:8 | `hf.pagestyle-kernel` | `\pagestyle{empty}` (no running head, no page number) |
| colour | main.tex:5, main.tex:9, main.tex:25 | `color.xcolor` | `\definecolor{certificateblue}{HTML}{1B4965}`; `\color{certificateblue}` on the word CERTIFICADO |
| page frame (double border) | main.tex:6, main.tex:12-19 | `art.tikz` | `tikz` overlay, `remember picture`, two `\draw ... rectangle` from `current page.north west` to `current page.south east`, `line width` 2pt and .5pt, offsets 1.1cm and 1.35cm. ART/body, see Blockers |
| centring of the whole body | main.tex:21, main.tex:40 | `sp.ragged` | `center` environment around the certificate text |
| vertical rhythm | main.tex:22, main.tex:24, main.tex:26, main.tex:28, main.tex:29, main.tex:31, main.tex:34, main.tex:39 | `sp.manual-space` | `\vspace*{1.2cm}`, `\vspace{1.8cm}`, `.35cm`, `1.7cm`, `.35cm`, `.35cm`, `\vfill`, `\vspace{1.2cm}` |
| type sizes | main.tex:23, main.tex:25, main.tex:27, main.tex:30 | `font.size-commands` | `\Large` (organisation, name), `\Huge` (CERTIFICADO), `\large` (subtitle) |
| font switches | main.tex:23, main.tex:25, main.tex:27, main.tex:30, main.tex:32 | `mark.kernel` | `\sffamily`, `\bfseries`, `\emph` |
| signature block | main.tex:7, main.tex:35-38 | `tbl.tabular` | `tabular` with `array` column specs `>{\centering\arraybackslash}p{5cm}` twice; one row of rules, one row of labels (Coordenação, Participante) |
| signature rules | main.tex:10, main.tex:36 | `sp.rule` | `\rule{4.6cm}{0.4pt}` through the alias `\field`; `\\[-.1cm]` row gap is `sp.manual-space` |
| cell centring | main.tex:35 | `sp.ragged` | `\centering\arraybackslash` in the column preamble |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\field{len}` | main.tex:10 | yes | alias of kernel `\rule{len}{0.4pt}`, `sp.rule` with width as parameter and height 0.4pt |
| TikZ page-frame picture | main.tex:12-19 | no (ART) | no declarative lib way; blocker `ART/body` above |

No zip-local `.cls`, `.sty`, `.def`, counters, conditionals or environments exist. `\field` is the only definition.

## Content-opaque
none (the frame is not in a float; it is template artwork, so it is a blocker, not content)

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
