yes

# 0771-smf-mathematics-article: SMF Mathematics Article (smfart starter)

- Unverified: read from the source, not compiled.
- Source: Source/0771-smf-mathematics-article/ (origin: https://latextemplates.com/downloads/smf-mathematics-article.zip; licence: LPPL-1.3c per the manifest, main.tex:9-14)
- Kind: journal
- Lib: v6
- Engine: pdfLaTeX-compatible (README.md:7 names pdflatex; the smfart source is not in the zip and was not read)
- Look carried by: class (the sample adds one `\newtheorem` and field values; page, fonts, headings, running heads and title block all come from the published smfart class)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
The zip is a 67-line sample, a one-entry `.bib` and a README; it holds no `.cls`, `.sty`, `.bst` or macro of its own. The look is carried entirely by the published class `smfart` (SMF's own kit, CTAN package `smflatex`, LPPL 1.3c, in TeX Live and MiKTeX; ctan.org/pkg/smflatex read once), loaded with one option, so it is one way, `class.smfart`. The only declaration in the sample is the kernel `\newtheorem` (main.tex:23), and the bibliography is BibTeX with the published `smfplain.bst`. `yes` is therefore easy, and is evidence about the class dimension rather than the component ways. Limit: `smfart.cls` and `smfplain.bst` were not read, so what the class does with page, fonts and heads is recorded as class-native, not decomposed.

## Blockers
none

## Class setting
- Class: `class.smfart` options: `english` (main.tex:19). It is required: the class sets no default language, so `\smf@language` stays undefined without it (main.tex:16-18, README.md:18-21); `french` and `francais` are the alternatives named there. Whether `english` loads babel was not read, so no separate `lang.*` way is claimed.
- Class-native vocabulary used: `\title` `\author` `\address` `\email` (main.tex:25-28); `\subjclass{...}` with one mandatory group and no `[year]` argument (main.tex:30-34, README.md:22-24); `\keywords{...}` (main.tex:35); the `abstract` environment placed before `\maketitle` (main.tex:39-44); `proof` environment (main.tex:57-59); bibliography style name `smfplain` (main.tex:64).
- Named on the CTAN page and not used here: `altabstract` `alttitle` `altkeywords` (second-language title, abstract, keywords), option `frenchb` (babel integration), the sibling class `smfbook`, the style `smfalpha.bst`.
- Not in the zip: `smfart.cls` and `smfplain.bst`. main.tex:1-8 says the class is deliberately not bundled; README.md:31 calls the `.bst` "bundled", but the zip holds only `main.tex`, `README.md` and `references.bib`, so the `.bst` comes from `smflatex` in the TeX distribution.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class | main.tex:19 | `class.smfart` | option `english` (language switch, required) |
| title, author, address, email | main.tex:25-28 | `front.class-native` | `\title{Your Title Here}`, `\author{Ada Lovelace}`, `\address{...}`, `\email{...}`; all four are strings (content); the class lays them out |
| title block output | main.tex:44 | `front.class-native` | `\maketitle` called after the abstract; the class's own title block, its layout not read |
| abstract | main.tex:39-42 | `abs.class-native` | `abstract` environment before `\maketitle` (the class stores it and prints it with the title block); text is content |
| keyword line | main.tex:35 | `abs.keywords` | class command `\keywords{comma-separated list}` |
| subject classification | main.tex:34 | `abs.classification` | class command `\subjclass{Primary 11A41; Secondary 11N05}`, one group, no optional argument (main.tex:30-33) |
| section headings | main.tex:46, 49, 61 | `head.class-native` | three `\section{...}`; no `\renewcommand`, `titlesec` or heading option in the sample, so size, numbering and spacing are the class's |
| theorem declaration | main.tex:23 | `thm.kernel` | `\newtheorem{theorem}{Theorem}`: environment name and printed name, own counter; no `\theoremstyle` or `\newtheoremstyle` in the sample (README.md:25-26: the class predeclares none) |
| theorem use | main.tex:52-55 | `thm.kernel` | `\begin{theorem}\label{thm:main} ... \end{theorem}` |
| proof | main.tex:57-59 | `thm.class-native` | `proof` environment, not declared in the sample so it comes from the class (if the class loads `amsthm` it is `thm.amsthm`; source not read) |
| labels | main.tex:50, 53 | `xref.kernel` | `\label{sec:results}`, `\label{thm:main}`; no `\ref` or `\autoref` call in the body |
| citation | main.tex:47 | `bib.bibtex-bst` | `\cite{knuth1984texbook}` (kernel `\cite`, label set by the `.bst`) |
| bibliography | main.tex:64-65; references.bib:1-6 | `bib.bibtex-bst` | `\bibliographystyle{smfplain}` (the style is the parameter), `\bibliography{references}`; one `@book` entry, title in double braces (references.bib:3, README.md:27-30) is content |

Not set by the sample, so no row: page geometry, fonts, spacing, colour, running heads, contents, lists, floats, tables, captions, notes, code, boxes, index, appendices. Whatever `smfart` does for these by default belongs to `class.smfart` (source not read).

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\newtheorem{theorem}{Theorem}` | main.tex:23 | yes | `thm.kernel`, name `theorem`, printed name `Theorem`; kernel command, not bespoke code (listed because it is the only declaration in the sample) |

No `\newcommand`, `\def`, counter, conditional, environment, `.cls`, `.sty` or `.bst` is defined in the zip.

## Content-opaque
none

## Lib changes
- New ways proposed: none (`class.smfart` needs no proposal; the class vocabulary is under "Class setting")
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
