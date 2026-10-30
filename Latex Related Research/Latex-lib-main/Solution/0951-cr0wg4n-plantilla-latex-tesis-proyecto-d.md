no

# 0951-cr0wg4n-plantilla-latex-tesis-proyecto-d: Plantilla LaTeX para Tesis o Proyecto de Grado (Spanish thesis, APA)

- Unverified: read from the source, not compiled.
- Source: Source/0951-cr0wg4n-plantilla-latex-tesis-proyecto-d/ (origin: https://codeload.github.com/cr0wg4n/plantilla-latex-tesis-proyecto-de-grado/zip/refs/heads/master; licence: GPL-3.0)
- Kind: thesis
- Lib: v6
- Engine: pdfLaTeX-compatible (README.md:48 names pdflatex; it needs `--shell-escape` and Pygments, see Blockers)
- Look carried by: mixed (main.tex preamble loads the packages; configs/conf.tex sets their parameters; zip-local configs/docstyle.sty sets sans default, header/footer, indent; caratula.tex is the hand-laid cover)
- Class origin: tex-distribution-unbundled (kernel `book`, not in the zip; its source was not read)
- Main file: main.tex (other samples: none; the body lives in capitulos/cap_1_ejemplos_de_uso.tex, caratula.tex, anexos/anexo_A.tex, anexos/anexo_B.tex)
- Read: main yes, zip-local classes and styles all (no .cls; configs/docstyle.sty and configs/conf.tex read in full)

## Verdict
no. The look itself is a book class plus ordinary published packages (fncychap, titlesec, fancyhdr, apacite, caption, enumitem, geometry), and nearly all zip-local code reduces to them. Two things block it. `minted2` is loaded unconditionally and the body uses `minted`, `listing` and `\inputminted`, which need shell escape and Pygments, so this is `EXTERNAL/package`. The preamble also has a hand-written machinery that adds extra PDF-bookmark lists for figures and tables by patching `\endfigure` and `\endtable`; it is irreducible bespoke code.

## Blockers
- `EXTERNAL/package` `minted2` loaded unconditionally with `outputdir=build, chapter`; it calls Pygments through shell escape. README says Pygments must be installed and `.latexmkrc` adds `--shell-escape`; the body uses `minted`, `listing` and `\inputminted` (main.tex:77; .latexmkrc:1; README.md:30, README.md:46; capitulos/cap_1_ejemplos_de_uso.tex:272, :292, :496)
- `BESPOKE/preamble` float-bookmark machinery: new toc files `lofb` and `lotb` filled by `\pretocmd` patches of `\endfigure` and `\endtable` (using `\@currentHref`, `\@currentlabelname`, `\addtocontents`), then emitted with `\@starttoc` from `\AtEndDocument`; this is hand-written kernel-internal code that no lib way expresses (configs/conf.tex:58-96)

## Class setting
- Class: `class.book` options: `12pt`, `letterpaper` (main.tex:4)
- Class-native vocabulary used: `\frontmatter` `\mainmatter` `\backmatter` (main.tex:92, 100, 105), `\chapter` and `\chapter*` (capitulos/cap_0_dedicatoria.tex:1; capitulos/cap_1_ejemplos_de_uso.tex:1), `titlepage` environment (caratula.tex:2), `\appendix` (main.tex:110), `\bibname` (configs/conf.tex:16)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:4 | `class.book` | 12pt, letterpaper |
| paper and size | main.tex:4 | `page.class-options` | letterpaper, 12pt |
| page geometry | main.tex:19; caratula.tex:1, caratula.tex:43 | `page.geometry` | top=2cm, bottom=2cm, left=3cm, right=2cm; `\newgeometry` with the same values on the cover, `\restoregeometry` after it |
| language | main.tex:7 | `lang.babel` | spanish, es-tabla (the table caption name "Tabla") |
| caption and list names | configs/conf.tex:7-9, :12-13, :16 | `lang.babel` | `\appendixname`=Anexo, `\appendixtocname` and `\appendixpagename`=Anexos, `\listfigurename`=Índice de Figuras, `\listtablename`=Índice de Tablas, `\bibname`=Bibliografía (raw `\renewcommand` of the name strings, a caption-name override) |
| hyperref and bookmarks | main.tex:13, main.tex:15 | `meta.hyperref`, `meta.bookmark` | bookmarksnumbered, bookmarksopen=false; `bookmark` loaded |
| url | capitulos/cap_1_ejemplos_de_uso.tex:218 | `meta.url` | `\url{...}` (provided through hyperref) |
| empty pages | main.tex:26 | `pg.emptypage` | load-only |
| page breaks between included files | main.tex:89-90, :93-94, :101, :112-113 | `pg.break` | `\include` implies `\clearpage` before and after each file |
| front/main/back matter numbering | main.tex:92, :100, :105 | `pgnum.pagenumbering` | class `book` switches (`\frontmatter` roman, `\mainmatter` arabic) |
| header and footer | main.tex:22; configs/docstyle.sty:20-26 | `hf.fancyhdr` | `\pagestyle{fancy}`, `\fancyhf{}`, `\lhead{\scriptsize\textbf{project name}\\ author}`, `\cfoot{\thepage}` |
| default family | configs/docstyle.sty:16 | `font.family-default` | `\familydefault`=`\sfdefault` (no font package; Computer Modern sans) |
| paragraph spacing | main.tex:51; configs/conf.tex:31-32; configs/docstyle.sty:18 | `sp.parskip-pkg`, `sp.lengths` | `parskip` loaded; `\parindent`=0cm, `\parskip`=5mm |
| bibliography item spacing | configs/docstyle.sty:17 | `sp.lengths` | `\bibitemsep`=`3\itemsep` (an apacite length) |
| title page | caratula.tex:2-42 | `front.titlepage-env` | `titlepage` with hand-laid centred blocks (cover macros are the data in `docstyle.sty`) |
| cover header row | caratula.tex:3-21 | `box.minipage` | three minipages 2.16cm, 10cm, 2.55cm joined by `\hfill` |
| cover logos | caratula.tex:5, caratula.tex:19 | `fig.graphicx` | `\includegraphics` width=2.16cm height=3.2cm; width=2.55cm height=2.55cm |
| cover upper-casing | caratula.tex:11-13, :25, :39 | `mark.case` | `\MakeUppercase` on university, faculty, career, title, city |
| cover vertical spacing | caratula.tex:22, :28, :33, :37 | `sp.manual-space` | `\vspace{5cm}`, `4cm`, `2cm`, `2cm` |
| cover type sizes and bold | caratula.tex:11-13, :25, :30, :34-35, :39 | `font.size-commands`, `mark.kernel` | `\large` `\normalsize` `\small` `\Large`; `\textbf` `\textnormal` |
| dedication and acknowledgements | capitulos/cap_0_dedicatoria.tex:1; capitulos/cap_0_agradecimientos.tex:1 | `front.dedication`, `head.kernel` | `\chapter*` pages (unnumbered, not in the toc) |
| contents lists | main.tex:95-97 | `toc.kernel` | `\tableofcontents`, `\listoffigures`, `\listoftables` |
| list of listings | main.tex:98; configs/conf.tex:18-19 | `code.minted` | `\listoflistings`, `\listoflistingscaption`=Índice de Códigos, `\listingscaption`=`\sffamily{Código}` (minted names; EXTERNAL) |
| chapter headings | main.tex:63; configs/conf.tex:38 | `head.fncychap` | style `Lenny`; `\ChTitleVar{\huge\bfseries\sffamily\raggedleft}` |
| section headings | main.tex:58; configs/conf.tex:45-47 | `head.titlesec` | `compact` option; `\titleformat*` section `\Large\bfseries`, subsection and subsubsection `\large\bfseries` |
| paragraph heading | configs/conf.tex:48-50 | `head.titlesec` | `\titleformat{\paragraph}{\normalsize\bfseries}{\theparagraph}{1em}{}`, `\titlespacing*{\paragraph}{0pt}{3.25ex plus 1ex minus .2ex}{1.5ex plus .2ex}` |
| unnumbered subheads | capitulos/cap_1_ejemplos_de_uso.tex:64, :185 | `head.kernel` | `\subsection*`, `\section*` |
| appendix | main.tex:43, main.tex:110-114 | `num.appendix` | `appendix` package, `\appendix` then `appendices` environment of two `\chapter` files |
| lists | capitulos/cap_1_ejemplos_de_uso.tex:46-57; main.tex:72; configs/conf.tex:41-42 | `list.kernel`, `list.enumitem` | `\setlist[itemize]` and `[enumerate]`: `noitemsep, topsep=3mm` |
| captions | main.tex:54; configs/conf.tex:35; capitulos/cap_1_ejemplos_de_uso.tex:111, :126 | `cap.caption`, `cap.kernel` | `\captionsetup[table]{skip=4mm}`; kernel `\caption` (above the tabular, below the image) |
| figure | capitulos/cap_1_ejemplos_de_uso.tex:108-115; main.tex:10, main.tex:29 | `fig.graphicx`, `fig.float`, `sp.ragged`, `xref.kernel` | `figure[!h]`, `\centering`, `\includegraphics[width=8cm]`, source note after the caption inside the float, `\label` and `\ref` |
| table | capitulos/cap_1_ejemplos_de_uso.tex:124-139 | `tbl.tabular`, `sp.manual-space` | `table[!h]`, `center`, `tabular{c\|c\|c\|c\|}`, `\cline{2-4}`, `\hline`, `\multicolumn`; `\vspace{4mm}` then a note |
| long table | capitulos/cap_1_ejemplos_de_uso.tex:150-181; main.tex:33 | `tbl.longtable` | `p{2cm}\|p{3cm}...` columns, `\endfirsthead` `\endhead` `\endfoot` `\endlastfoot` |
| equations | capitulos/cap_1_ejemplos_de_uso.tex:188-213; main.tex:40 | `math.amsmath`, `math.amssymb` | `equation`, `matrix`, `\lim`, `\label` |
| theorems | main.tex:40 | `thm.amsthm` | package loaded; no `\newtheorem` or theorem environment anywhere in the zip (Grep) |
| units | capitulos/cap_1_ejemplos_de_uso.tex:253-257; main.tex:69 | `mark.siunitx` | `\si{69 \kilogram}`, `\ang{10;8;2}` |
| font family, shape, size switches | capitulos/cap_1_ejemplos_de_uso.tex:20-29, :32-41 | `mark.kernel`, `font.size-commands` | `\ttfamily` `\sffamily` `\rmfamily` `\textbf` `\textit` `\textsl` `\texttt` `\textsc`; `\tiny` to `\Huge` |
| centred text | capitulos/cap_1_ejemplos_de_uso.tex:3-5 | `sp.ragged` | `center` environment |
| code blocks | main.tex:77; capitulos/cap_1_ejemplos_de_uso.tex:269-286, :291-485, :496 | `code.minted` | `minted2[outputdir=build,chapter]`; `minted` options `bgcolor=gray_background, xleftmargin=10pt, linenos=true, breaklines, breakanywhere, fontsize=\footnotesize`; `listing[H]`; `\inputminted` (**EXTERNAL**) |
| minted style and colour | configs/conf.tex:54-55; main.tex:83 | `code.minted`, `color.xcolor` | `\usemintedstyle{tango}`; `\definecolor{gray_background}{gray}{0.92}` |
| listings package | main.tex:80 | `code.listings` | load-only; no `lstlisting` or `\lstset` in the zip (Grep) |
| citations and bibliography | main.tex:37, :106-107; configs/conf.tex:1-4; capitulos/cap_1_ejemplos_de_uso.tex:66, :81, :92, :99 | `bib.apacite` | `apacite` with `\bibliographystyle{apacite}`; `\cite` `\citeA` with page note; hooks `\BOthers`=`et al.\hbox{}`, `\BAvailFrom` and `\BRetrievedFrom`=Recuperado de, `\BRetrieved` emptied |
| bibliography list spacing | configs/conf.tex:108-113 | `sp.lengths` | after the old `thebibliography` start: `\parskip`=3mm, `\itemsep`=3mm plus 0.3ex (see Bespoke code) |
| flowchart pictures | main.tex:46-47; capitulos/cap_1_ejemplos_de_uso.tex:222-249; configs/conf.tex:22-28 | `art.tikz` | content-opaque demo, see below |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `docstyle.sty` (zip-local package) | main.tex:86; configs/docstyle.sty:1-26 | yes | `\ProvidesPackage` plus `\renewcommand\familydefault`, `\setlength`, fancyhdr calls: `font.family-default` (`\sfdefault`), `sp.lengths` (`\bibitemsep`, `\parindent`=0cm), `hf.fancyhdr` as in the map; no code beyond declarations |
| data macros `\nombreAutor` `\nombreProyecto` `\nombreTutor` `\nombreCiudadPais` `\fecha` `\nombreUniversidad` `\nombreFacultad` `\nombreCarrera` `\descripcion` | configs/docstyle.sty:3-12 | yes | `\newcommand` constants holding strings; they print only inside `caratula.tex` and the header, so the emitter writes the strings in place |
| apacite string hooks | configs/conf.tex:1-4 | yes | `\renewcommand` of apacite's documented hooks: `bib.apacite` parameters |
| name strings | configs/conf.tex:7-9, :12-13, :16, :18-19 | yes | `\renewcommand` of caption and name strings: `lang.babel` name overrides (the two listing names belong to minted, `code.minted`) |
| `\tikzstyle` styles `decision` `block` `line` `cloud` | configs/conf.tex:22-28 | yes | declarative TikZ key lists, only used by the body demo picture (`art.tikz` parameters) |
| `code` environment | configs/conf.tex:100-103 | yes | `\newenvironment` whose begin is `\captionsetup{type=listing}` (`cap.caption`) and a `\BeforeBeginEnvironment` hook that is `\vspace{2mm}` (`sp.manual-space`); the `listing` float type is minted's, so it stays EXTERNAL |
| `thebibliography` wrapper | configs/conf.tex:108-113 | yes, with a caveat | `\let\OLDthebibliography` plus `\renewcommand\thebibliography` that calls the old start and then sets two lengths: `sp.lengths` (`\parskip`=3mm, `\itemsep`=3mm plus 0.3ex); the lengths must fall right after the environment start, which a `.bbl`-generated environment gives no body wrapper for, so the placement is a hook (borderline, not decisive) |
| list-of-figures and list-of-tables bookmark machinery | configs/conf.tex:58-69, :71-91, :93-96 | no | custom toc files `lofb` and `lotb` read with `\@starttoc`, filled by `\pretocmd\endfigure` and `\pretocmd\endtable` patches that write `\bookmark[rellevel=1,keeplevel,dest=\@currentHref]{Figura \thefigure: \@currentlabelname}` through `\addtocontents`, started in `\AtEndDocument`; patches float internals and writes new aux lists, so no lib way (`meta.bookmark` takes `\bookmarksetup` and `\bookmark` options, not this float hook) |
| `.latexmkrc` | .latexmkrc:1 | no | `$pdflatex='pdflatex --shell-escape'`: a build setting for `minted2`, covered by the EXTERNAL blocker |
| `import` package | main.tex:66 | not needed | loaded, never called (no `\import` or `\subimport`, Grep), so it prints nothing and needs no way; considered: `import` |

## Content-opaque
- TikZ flowchart in a `center` environment (outside a float), example content that shows how to draw with the declared node styles: capitulos/cap_1_ejemplos_de_uso.tex:222-249. Judged as sample content, not page-level artwork (the text at :216-220 itself suggests other tools), so not `ART`.
- Bibliography entries bibliografia.bib:1-40 (five entries), logo and example images (img/caratula/logo_universidad.png, img/caratula/logo_facultad.png, img/capitulo_1/figura_ejemplo.png), the C++ and Python code text in the minted blocks (capitulos/cap_1_ejemplos_de_uso.tex:273-284, :293-481, codigo/capitulo_1/demo.py).

## Lib changes
- New ways proposed: none (considered: `import`, load-only and never called, so no way is needed)
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
