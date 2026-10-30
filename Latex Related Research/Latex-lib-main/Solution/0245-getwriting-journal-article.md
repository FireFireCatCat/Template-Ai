yes

# 0245-getwriting-journal-article: getwriting Journal Article

- Unverified: read from the source, not compiled.
- Source: Source/0245-getwriting-journal-article/ (origin: https://latextemplates.com/downloads/getwriting.zip; licence: Unlicense for the class, OFL-1.1 for the bundled Atkinson Hyperlegible fonts: LICENSE:1, README.md:10-12)
- Kind: journal
- Lib: v3
- Engine: needs XeLaTeX (`fontspec` `\setmainfont` loads shipped .ttf files by path, getwriting.cls:5,41-47; manifest hint xelualatex,bibtex; LuaLaTeX not checked)
- Look carried by: zip-local (everything is in `getwriting.cls`, a thin wrapper over `article`; main.tex adds only `amsmath`, main.tex:2)
- Class origin: zip-local (`getwriting` is not a CTAN package: ctan.org/pkg/getwriting is a 404; README.md:12-13 names a GitHub upstream, and the zip is a latextemplates.com redistribution, not an official release)
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles all (getwriting.cls, 54 lines; no .sty, .def, .cfg, .clo, .bst in the zip). Not read: the sources of the published packages the class loads, notably `achemso` (not in the zip).

## Verdict
`yes`. The zip-local class is `\LoadClass[11pt, a4paper]{article}` (getwriting.cls:4) followed by `\RequirePackage` lines, `\setlist`, `\hypersetup`, `\setmainfont` and `\lstset` calls, and every one of them is a published package or kernel command with declarative parameters. The only hand-written macro, `\namedlabel` (getwriting.cls:35-39), is never called in the sample and is an alias of kernel `\label` plus hyperref `\phantomsection`. No artwork, no external tool. Two soft spots are stated below: the `achemso` package source was not read, and `\namedlabel` is judged reducible (it is the one item that would flip the verdict if a reviewer rules `\@currentlabel` surgery irreducible).

## Blockers
none

## Class setting
- Class: `class.article` options: `11pt`, `a4paper` (set inside the zip-local class, getwriting.cls:4; main.tex:1 loads `getwriting` with no options). The zip-local `getwriting` class itself is reducible bespoke (see Bespoke code).
- Class-native vocabulary used: kernel article only (`\title`, `\author`, `\date`, `\maketitle`, `abstract`, `\section`, `table`, `equation`, `enumerate`, `\bibliography`); `\author[1]{}` and `\affil[1]{}` come from `authblk`, not from the class (main.tex:5-8).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | getwriting.cls:4; main.tex:1 | `class.article` | 11pt, a4paper |
| paper and size | getwriting.cls:4 | `page.class-options` | a4paper, 11pt |
| page geometry | getwriting.cls:28 | `page.geometry` | margin=1in |
| line spacing | getwriting.cls:16-17 | `sp.setspace` | `\doublespacing` |
| paragraph spacing | getwriting.cls:15 | `sp.parskip-pkg` | option parfill |
| line numbers | getwriting.cls:10-11 | `sp.draft-lineno` | `\linenumbers`, no options (every line numbered) |
| main text font | getwriting.cls:5, 41-47 | `font.fontspec` | `\setmainfont` AtkinsonHyperlegible; Path=fonts/, Extension=.ttf, UprightFont=*-Regular, BoldFont=*-Bold, ItalicFont=*-Italic, BoldItalicFont=*-BoldItalic; the four .ttf files ship in fonts/ |
| icon font package | getwriting.cls:6 | `font.icons` | `fontawesome`, load-only (no icon command in the sample) |
| ORCID icon in author line | getwriting.cls:18; main.tex:5 | `font.icons` | `orcidlink`, `\orcidlink{0000-0002-1825-0097}` (a logo-by-id package, the package is the parameter) |
| colour | getwriting.cls:21, 33 | `color.xcolor` | `xcolor` no options; named colour `blue` used by `allcolors` |
| hyperlinks and metadata | getwriting.cls:24, 33 | `meta.hyperref` | colorlinks=true, allcolors=blue |
| cross-references | main.tex:39, 65 | `xref.kernel` | `\label{tab:register}`, `Table~\ref{}` |
| equation reference | main.tex:56, 66 | `math.amsmath` | `\label`, `\eqref{eq:weighted-mean}` |
| title block | main.tex:4, 11; getwriting.cls:3 | `front.maketitle` | `\title`, `\maketitle`, `\date{}` (empty date set by the class) |
| authors and affiliations | getwriting.cls:27; main.tex:5-8 | `front.authblk` | `\author[1]{...}`, `\author[2]{...}`, `\affil[1]{...}`, `\affil[2]{...}` |
| author notes | main.tex:5-6 | `front.thanks` | `\thanks{email}` inside `\author` |
| abstract | main.tex:13-18 | `abs.kernel` | `abstract` environment, article default |
| keyword line | main.tex:20-21 | `abs.keywords` | `\noindent\textbf{Keywords:}` + comma list (`mark.kernel` for `\textbf`) |
| headings | main.tex:23, 30, 51, 70, 80 | `head.kernel` | `\section`, article defaults, no restyle (no titlesec in the zip) |
| ordered list | main.tex:63-68 | `list.kernel` | `enumerate`, four items, first level |
| list label overrides | getwriting.cls:23, 29-31 | `list.enumitem` | `\setlist[enumerate,2]{label=\alph*)}`, `\setlist[enumerate,3]{label=\roman*)}` (levels 2 and 3 are not used in the sample) |
| outline lists package | getwriting.cls:12 | `list.paralist` | `outlines` (CTAN), load-only, no `outline` environment in the sample (considered: `outlines` as its own way; a list-extension package is the parameter of `list.paralist`, as `tasks` and `mdwlist` already are) |
| underline/highlight package | getwriting.cls:22 | `mark.ulem` | `soul`, load-only |
| inline marks | main.tex:20, 81 | `mark.kernel` | `\textbf`, `\texttt` |
| display and inline maths | main.tex:2, 52, 54-57 | `math.amsmath` | `amsmath` no options; `equation`, `\frac`, `\sum`, `\bar` |
| table float | main.tex:36-39; getwriting.cls:19 | `fig.float` | `table[H]` (float package) |
| table centring | main.tex:37 | `sp.ragged` | `\centering` |
| table caption | main.tex:38 | `cap.kernel` | `\caption`, no caption package |
| table body | main.tex:40-48 | `tbl.tabular` | `tabular{llll}` |
| table rules | getwriting.cls:8; main.tex:41, 43, 47 | `tbl.booktabs` | `\toprule`, `\midrule`, `\bottomrule` |
| long table, cell breaks | getwriting.cls:7, 9 | `tbl.longtable`, `tbl.multirow` | `longtable`, `makecell`, both load-only |
| images | getwriting.cls:20 | `fig.graphicx` | `graphicx`, load-only (no figure in the sample) |
| verbatim code block | getwriting.cls:13; main.tex:74-76 | `code.verbatim` | `verbatim` environment (the sample's "code listing" is verbatim, not `lstlisting`) |
| listings defaults | getwriting.cls:26, 49-53 | `code.listings` | `\lstset{basicstyle=\ttfamily, columns=flexible, breaklines=true}`, load-only |
| citation | main.tex:34 | `bib.bibtex-bst` | `\cite{wilkinson2016}` |
| bibliography | main.tex:85; getwriting.cls:14; references.bib:1-9 | `bib.bibtex-bst` | `\bibliography{references}` with no `\bibliographystyle` anywhere in the zip (grep), so the style can only come from the loaded `achemso` package (inferred: its source is not in the zip and was not read); one `@article` entry is content |
| file import package | getwriting.cls:25 | `struct.input` | `import`, load-only (no `\import` or `\subimport` call in either file) |
| header and footer | (nothing set; grep finds no `\pagestyle`, `\fancyhdr`) | `hf.pagestyle-kernel` | article default page style, nothing declared |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| zip-local class `getwriting` | getwriting.cls:1-54 | yes | `class.article` [11pt, a4paper] + preamble ways: `font.fontspec`, `sp.setspace`, `sp.parskip-pkg`, `sp.draft-lineno`, `page.geometry`, `front.authblk`, `meta.hyperref`, `list.enumitem`, `code.listings`, `bib.bibtex-bst`, and the load-only packages above; no `\renewcommand` of kernel internals |
| `\namedlabel#1#2` | getwriting.cls:35-39 | yes | Never called in the sample (grep finds only the definition). Inline form: `\begingroup #2\def\@currentlabel{#2}\phantomsection\label{#1}\endgroup` = `xref.kernel` (`\label`, kernel `\@currentlabel`) + `xref.hyperref` (`\phantomsection`); an alias of published commands, no counter, no conditional, no output routine. Risk: if `\@currentlabel` surgery is ruled irreducible, this one item makes the verdict `no`. |
| `\date{}` | getwriting.cls:3 | yes | `front.maketitle` with an empty date |
| trailing `\makeatletter` | getwriting.cls:54 | yes | kernel catcode switch with no matching `\makeatother`; no typesetting effect |
| second `\RequirePackage{enumitem}` | getwriting.cls:29 | yes | duplicate of getwriting.cls:23; load once |

## Content-opaque
none (the ORCID icon is drawn inside the published `orcidlink` package, not by a picture in the zip)

## Lib changes
- New ways proposed: `struct.input` file inclusion by path: kernel `\input`, `\include`, `\includeonly` and the `import` package (CTAN: `\import{dir}{file}`, `\subimport`, `\includefrom`, `\inputfrom`), pdf. W1: kernel commands plus a CTAN package. W2: behaviour is chosen by two string arguments (directory, file name) and no code is edited. W3: serves any multi-directory document, not one. W4: a preamble line plus a body wrapper `\import{dir}{file}`. No lib line holds it (`pg.standalone-pkg` includes `standalone` sub-files with their own preamble, `struct.simplesystemtex` is one multi-file engine). Used here only as a load line (getwriting.cls:25).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
- Considered, not proposed: `outlines` as `list.outlines` (kept inside `list.paralist`); `achemso` as its own way (kept as the style provider of `bib.bibtex-bst`).
