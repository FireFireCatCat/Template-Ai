yes

# 0410-moderncv-cv-and-cover-letter: ModernCV CV and Cover Letter

- Unverified: read from the source, not compiled.
- Source: Source/0410-moderncv-cv-and-cover-letter/ (origin: https://latextemplates.com/downloads/moderncv-cv-and-cover-letter.zip; licence: LPPL-1.3c)
- Kind: cv (two samples: a CV and a matching cover letter, each its own PDF; README.md:10, main.tex:5-7)
- Lib: v4
- Engine: pdfLaTeX-compatible (README.md:20-21 builds both with `pdflatex`; the class source was not read, and the CTAN page for `moderncv` lists no engine or external-tool requirement)
- Look carried by: class (the zip adds only option settings and content: `\moderncvstyle`, `\moderncvcolor`, one `geometry` option, one `\renewcommand` of a class symbol; main.tex:16-21, main.tex:70)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: cover_letter.tex)
- Read: main yes, zip-local classes and styles none present

## Verdict
The look is carried by the published CTAN/TeX Live class `moderncv`, which the zip deliberately does not bundle (README.md:12-16; main.tex:1-3). The zip holds no `.cls`, `.sty` or other local code: two short samples that set class options, a style name, a colour name, one `geometry` option and one class-symbol string. Every component maps to an existing lib way and there is no artwork and no external tool, so the answer is `yes`. Caveat: the class source was not available to read, so what `moderncv` loads internally is taken from the CTAN page (no requirements listed) and not checked in code.

## Blockers
none

## Class setting
- Class: `class.moderncv` options: `11pt`, `a4paper`, `sans` (main.tex:16; cover_letter.tex:5). Source of the class not read (not in the zip; CTAN: moderncv, LPPL 1.3c, in TeX Live and MiKTeX; the CTAN page shows v2.6.1, while main.tex:1 says v2.5.1).
- Class-native vocabulary used:
  - style and colour: `\moderncvstyle{classic}` (main.tex:18; cover_letter.tex:7), `\moderncvcolor{blue}` (main.tex:19; cover_letter.tex:8). Both take one name from a closed list (README.md:27-40, main.tex:9-15).
  - personal block: `\firstname` `\familyname` `\title` `\address{street}{city}{country}` `\phone[mobile]` `\email` `\social[linkedin|github]` `\extrainfo` (main.tex:23-31; cover_letter.tex:12-16).
  - CV: `\makecvtitle` (main.tex:34), `\section` (main.tex:36), `\cventry{years}{title}{employer}{city}{grade}{text}` (main.tex:37), `\cvitem{label}{text}` (main.tex:57), `\cvitemwithcomment{a}{b}{c}` (main.tex:67), the class macro `\listitemsymbol` (main.tex:70).
  - letter: `\recipient{name}{address}` `\date` `\subject` `\opening` `\closing` `\enclosure[label]{text}` (cover_letter.tex:19-24), `\makelettertitle` (cover_letter.tex:28), `\makeletterclosing` (cover_letter.tex:45).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:16; cover_letter.tex:5 | `class.moderncv` | options 11pt, a4paper, sans (the `sans` option picks the class's sans-serif text face) |
| paper and base size | main.tex:16; cover_letter.tex:5 | `page.class-options` | a4paper, 11pt |
| page margins | main.tex:21; cover_letter.tex:10 | `page.geometry` | scale=0.85 |
| colour scheme | main.tex:19; cover_letter.tex:8 | `class.moderncv` | `\moderncvcolor{blue}`, one name from a closed list (README.md:39); realised by the class, not read; no separate colour way needed |
| overall look: header, heading and entry layout | main.tex:18; cover_letter.tex:7 | `head.class-native` | `\moderncvstyle{classic}`, one name from a closed list (README.md:27-37) |
| CV personal block (name, title, address, phone, mail, social icons, extra line) | main.tex:23-31 | `front.class-native` | `\firstname{Elena}` `\familyname{Kowalczyk}` `\title{..}` `\address{..}{..}{..}` `\phone[mobile]{..}` `\email{..}` `\social[linkedin]{..}` `\social[github]{..}` `\extrainfo{..}` |
| CV title block | main.tex:34 | `front.class-native` | `\makecvtitle` |
| section headings | main.tex:36, 51, 56, 61, 66, 71 | `head.class-native` | `\section{..}`, look from `\moderncvstyle` |
| dated CV entries | main.tex:37, 42, 46, 52, 54 | `cv.entries` | `\cventry` with six arguments (years, title, employer, city, grade left empty, description) |
| label and text rows | main.tex:57-59, 63, 72 | `cv.entries` | `\cvitem{label}{text}`; empty label at main.tex:72 |
| row with comment | main.tex:67-68 | `cv.entries` | `\cvitemwithcomment{Polish}{Native}{}` |
| list bullet symbol | main.tex:70 | `cv.entries` | `\renewcommand{\listitemsymbol}{-~}`: a class-native symbol parameter of `\cvlistitem`, which the sample never calls |
| no break after a heading | main.tex:62 | `pg.break` | kernel `\nopagebreak`, the no-break counterpart of `\pagebreak` (same kernel family) |
| emphasis in an entry | main.tex:63 | `mark.kernel` | `\emph` |
| hyperlink in the extra line | main.tex:31 | `xref.hyperref` | `\href{https://elenak.dev}{elenak.dev}` (hyperref link command; the URL and text are content) |
| letter personal block | cover_letter.tex:12-16 | `front.class-native` | same commands as the CV block, without `\title` and `\social` |
| letter fields | cover_letter.tex:19-24 | `ltr.opening` | `\recipient{name}{address}`, `\date{\today}`, `\subject{..}`, `\opening{..}`, `\closing{..}`, `\enclosure[Enclosure]{..}` |
| address line breaks | cover_letter.tex:19 | `sp.manual-space` | `\\` inside the `\recipient` address argument |
| letter title and closing blocks | cover_letter.tex:28, 45 | `ltr.opening` | `\makelettertitle` before the body, `\makeletterclosing` after it |
| letter body paragraphs | cover_letter.tex:30-43 | content | running text only |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\renewcommand{\listitemsymbol}{-~}` | main.tex:70 | yes | assigns a string to a published class's own symbol macro; a parameter of `cv.entries` (`\cvlistitem` bullet), not new typesetting logic; unused by this sample's body |

No zip-local `.cls`, `.sty`, `.def`, `.cfg`, `.clo`, `.bst`, `\newcommand`, `\def`, environment, counter or conditional exists (only `main.tex`, `cover_letter.tex`, `README.md` in the zip).

## Content-opaque
none

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- Considered and not used: a separate colour way for `\moderncvcolor` (a class parameter, kept under `class.moderncv`; the lib has no `color.class-native` and none is proposed), `meta.hyperref` (the sample sets no hyperref option; whatever the class loads was not read).
- Nothing in the zip addresses an AI reader; no embedded instructions were found.
- Two samples share one preamble pattern; each is a complete document (main.tex:16-33, cover_letter.tex:5-26), so the emitter writes two documents of the same class.
