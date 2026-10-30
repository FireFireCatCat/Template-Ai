yes

# 0528-achemso: achemso (American Chemical Society submission class, model paper)

- Unverified: read from the source, not compiled.
- Source: Source/0528-achemso/ (origin: https://mirrors.ctan.org/macros/latex/contrib/achemso.zip; licence: LPPL 1.3c, with the `cite.sty`-derived code under Arseneau's notice (LICENSE.md:1-11; README.md:19-22))
- Kind: journal
- Lib: v4
- Engine: pdfLaTeX-compatible (class loads only pdfLaTeX packages: `xkeyval`, `geometry`, `caption`, `float`, `graphicx`, `setspace`, `url`, `natbib`, `natmove`, optional `mciteplus`; BibTeX is run for the references)
- Look carried by: class (the published `achemso` class and its journal `.cfg` for `jacsat` define the whole look; the sample adds an option string, `chemformula`, `fontenc` and one alias macro)
- Class origin: ctan (ctan.org/pkg/achemso read: on CTAN and in TeX Live, LPPL 1.3c, maintainer Joseph Wright; the zip is its CTAN bundle, not a publisher kit)
- Main file: achemso-demo.tex (other samples: none; `achemso.dtx` also holds an `ltxdoc` driver for the package manual, achemso.dtx:27-41, which is documentation and not analysed as a template)
- Read: main yes, zip-local classes and styles partly (no `.cls`, `.sty`, `.cfg` or `.bst` file is in the zip: they are generated from `achemso.dtx` by `achemso.ins` (achemso.ins:69-73, 75-166). Read in full: the class and shared code achemso.dtx:205-2533, `natmove` 2556-2752, the `jacsat` configuration 3370-3572, and a filtered pass over every other journal configuration 2762-3365. Not read: the `.bst` function bodies, achemso.dtx:3760-5352 (read only the ENTRY fields at 3629-3662, `begin.bib`/`end.bib` at 4282-4351, and the outline); the package manual text of the `.dtx`, which is only an abstract at 180-190)

## Verdict
Yes. The look is carried by the published class `achemso` (CTAN, TeX Live; the sample is `\documentclass[journal=jacsat,manuscript=article]{achemso}`, achemso-demo.tex:7). The preamble adds `chemformula` (inline chemistry, content), `fontenc` and one `\newcommand` alias that reduces by inline expansion. Every body construct is either class-native vocabulary or kernel LaTeX, and inside the class the layout reduces to published ways (`geometry`, `setspace`, `float`, `natbib`, BibTeX with the bundled `achemso.bst`). There is no artwork and no tool outside TeX and BibTeX. This is evidence about the class dimension, not about the component ways.

## Blockers
none

## Class setting
- Class: `class.achemso` options: `journal=jacsat`, `manuscript=article` (achemso-demo.tex:7). The class loads `article` as `\LoadClass[12pt,letter]{article}` (achemso.dtx:213). Other keys it accepts (xkeyval family `acs`, achemso.dtx:304-375): `layout`, `biblabel`, `super`, `articletitle`, `etalmode`, `maxauthors`, `doi`, `biochem`, `email`, `hyperref`, `keywords`, `abbreviations`, `chaptertitle`. After options are read the class resets `abbreviations=false`, `articletitle=true`, `biblabel=brackets`, `biochem=false`, `doi=false`, `etalmode=firstonly`, `keywords=false`, `maxauthors=15`, `super=true` (achemso.dtx:741-750), then loads `achemso-<journal>.cfg` (achemso.dtx:2397-2403).
- Class-native vocabulary used: `\title[short]{}` (achemso-demo.tex:79-81), `\author` (50-72), `\affiliation[short]{}` (60, 66, 69), `\alsoaffiliation[short]{}` (62, 71), `\altaffiliation` (51, 53, 56), `\email` `\phone` `\fax` (57-59, 65), `\abbreviations` (88), `\keywords` (89), automatic `\maketitle` (comment at 92-93; achemso.dtx:1823), `tocentry` (103-121), `abstract` (127-139), `scheme` float (205-214, with `chart` and `graph` named at 219), `\latin` (178), `\citenum` `\citeauthor` `\citeyear` (170-172), starred cite keys and `\mciteSubRef` (183, 189), `\bibnote` (192), `acknowledgement` (337-348), `suppinfo` (354-367), `\bibliography` with the style fixed by the class (374).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | achemso-demo.tex:7; achemso.dtx:213 | `class.achemso` | `journal=jacsat,manuscript=article`; base `article` at `12pt,letter` |
| paper and base size | achemso.dtx:213 | `page.class-options` | `letter`, `12pt` (set by the class, not by the sample) |
| page geometry | achemso.dtx:757 | `page.geometry` | `margin=2.54cm`. The two-column press layout branch (`layout=twocolumn`, achemso.dtx:2316-2343, 2440-2449) is not taken by this sample (default `traditional`, achemso.dtx:361) |
| line spacing | achemso.dtx:758-764, 771 | `sp.setspace` | `setspace` loaded; `\doublespacing` at begin document |
| header/footer | achemso.dtx:1209-1210, 1220 | `hf.class-native` | page style `acs` is `\let` to `plain` and is set by `\maketitle`; equivalent to `hf.pagestyle-kernel` plain. The `jacsat` communication footers (achemso.dtx:3464-3492) apply only to `manuscript=communication` |
| font encoding | achemso-demo.tex:14 | `font.fontenc-t1` | `[T1]` |
| font choice | achemso.dtx:1182-1200 | `font.size-commands`, `mark.kernel` | class hooks, not set by the sample: `\titlesize` `\LARGE`, `\authorsize` `\large`, `\titlefont` `\bfseries\sffamily`, `\authorfont` `\sffamily`, `\affilfont` `\itshape` |
| title block | achemso-demo.tex:50-81; achemso.dtx:1219-1268, 1157-1168 | `front.class-native` | title, authors, affiliations and contact lines centred in a `minipage` of `\textwidth`; gaps `2em`/`1.5em`/`1em`/`1em`/`1.5em` (the `jacsat` cfg changes them only for communications, achemso.dtx:3503-3508); markers from `\acs@author@fnsymbol` (achemso.dtx:1513-1554) |
| title footnote | achemso-demo.tex:81; achemso.dtx:1234, 1288-1291 | `fn.kernel` | `\footnote` inside `\title` remapped by the class to `\footnotemark` plus `\footnotetext`; `\thanks` and `\and` only warn (achemso.dtx:839-850) |
| abstract | achemso-demo.tex:127-139; achemso.dtx:1790-1802, 2089-2098 | `abs.kernel`, `abs.class-native` | `article` abstract environment; class hook after `\endabstract`; `\AbstractOff`/`\AbstractOn` switch it per journal |
| keywords and abbreviations | achemso-demo.tex:88-89; achemso.dtx:1104-1113, 1125-1138, 742, 748 | `abs.keywords`, `front.class-native` | given in the sample but not printed: `keywords` and `abbreviations` are reset to `false` (achemso.dtx:742, 748) and the `jacsat` cfg ends before enabling them for non-communications (achemso.dtx:3373-3376) |
| graphical TOC entry | achemso-demo.tex:103-121; achemso.dtx:2245, 2200-2237, 2257-2259 | `front.class-native` | environment collected into a token list and printed at `\AtEndDocument` on its own page, `\fbox` of a `minipage` `3.25in` x `1.75in`, `\sffamily`, 8/9 pt, `\singlespacing` (`jacsat` keeps these defaults) |
| headings | achemso-demo.tex:144-160; achemso.dtx:1907-1917, 1923-1932, 1961-1967, 3373 | `head.class-native` | `\SectionNumbersOff` is called by the `jacsat` cfg: `\@startsection` is swapped for a variant using `\@ssect`, so headings are unnumbered with the `article` heading format and are not entered in the TOC (the default numbered variant, not active here, adds unnumbered sections to the TOC, achemso.dtx:1904-1917) |
| lists | achemso-demo.tex:362-365 | `list.kernel` | `itemize` |
| acknowledgement | achemso-demo.tex:337-348; achemso.dtx:2009-2011, 2023 | `front.class-native` | `acknowledgement` environment prints `\section*{Acknowledgement}` |
| supporting information | achemso-demo.tex:354-367; achemso.dtx:2012-2014, 2029 | `front.class-native` | `suppinfo` environment prints `\section*{Supporting Information Available}`; the `manuscript=suppinfo` variant (S- prefixes, achemso.dtx:2423-2434) is not used |
| floats | achemso-demo.tex:205-222, 267-300; achemso.dtx:1833-1838, 1857-1860, 1865-1869 | `fig.float`, `fig.graphicx` | `\newfloat{scheme}{htbp}{los}`, `chart` `{htbp}{loc}`, `graph` `{htbp}{loh}`; `\floatname`; `\floatplacement{table|figure}{htbp}`; `\floatstyle{plaintop}` with `\restylefloat{table}`; floats `\centering` via `\@floatboxreset`; `graphicx` loaded (achemso.dtx:761), the `\includegraphics` lines are commented out (achemso-demo.tex:211, 257) |
| captions | achemso-demo.tex:212, 220, 268; achemso.dtx:759 | `cap.kernel`, `cap.caption` | `\caption`; `caption` is loaded and gets no settings for `jacsat` article (the `\captionsetup` block is communication-only, achemso.dtx:3536-3542) |
| tables | achemso-demo.tex:270-279, 289-299 | `tbl.tabular` | `tabular{ll}` with `\hline` rules; table notes are `\textsuperscript{\emph{a}}` (`mark.kernel`) |
| table notes | achemso-demo.tex:293-299 | `mark.kernel` | `\textsuperscript`, `\emph` |
| math | achemso-demo.tex:241-260 | `math.kernel`, `box.minipage` | `\( \)`, `$ $`, `\[ \]`, `equation`; `minipage[c]{0.80\linewidth}` inside `equation`; no `amsmath` (achemso-demo.tex:237-239) |
| cross-references | achemso-demo.tex:203, 213, 244, 265 | `xref.kernel` | `\label`, `\ref`; `\plainref` is a legacy alias of `\ref` (achemso.dtx:1876-1877) |
| citations | achemso-demo.tex:168-175; achemso.dtx:2463, 2466-2478 | `bib.natbib` | `natbib` options `sort&compress,numbers,super` (`super=true` default); `\setcitestyle{super,open={},close={}}` |
| citation moving and groups | achemso-demo.tex:183, 189; achemso.dtx:2479, 2491-2503, 2556-2752 | `bib.cite-pkg` | `natmove` (moves `.,;:` after a superscript citation; `\natmovechars`) and `mciteplus` (starred keys, `\mciteSubRef`; loaded only if `mciteplus.sty` exists; ctan.org/pkg/mciteplus read: CTAN, TeX Live, LPPL 1.3). Considered: a separate way for `mciteplus`; kept here as a load-only citation-run package (package is the parameter) |
| bibliography notes | achemso-demo.tex:192-198; achemso.dtx:494-522, 603-639 | `class.achemso` | class-native `\bibnote` (notes2bib emulation): writes a `@Misc` entry to `acs-<jobname>.bib`, which BibTeX reads; `\cite[p.~1]{}` with a note becomes a note too. Recorded under Class setting |
| bibliography | achemso-demo.tex:374; achemso.dtx:2512-2532, 714-719, 2024-2028, 4305-4311 | `bib.bibtex-bst` | bundled style `achemso` forced by the class (a user `\bibliographystyle` is ignored with a warning); `\bibliography` prepends `acs-\jobname`; `\bibsection` is `\section*{\refname}`; bst writes `mcitethebibliography` and `\providecommand{\latin}` |
| Latin phrases | achemso-demo.tex:178; achemso.dtx:728-730, 3968 | `class.achemso` | `\latin{et~al.}` emitted by the bst; identity by default (`\providecommand`), `\emph` in some journal cfgs (achemso.dtx:2987). Class-native, recorded under Class setting |
| URLs | achemso.dtx:763, 1689-1719 | `meta.url` | `url` loaded; used for the e-mail list with `\UrlFont` set to `\sf` |
| hyperref | achemso.dtx:310, 765-770 | `meta.hyperref` | not active: loaded only with the class option `hyperref=true` |
| inline chemistry | achemso-demo.tex:13, 304; achemso-demo.bib:52 | `art.content-package` | `chemformula`, `\ch{H2SO4}` in running text; content, see Content-opaque |
| user macro | achemso-demo.tex:28, 310 | `mark.kernel` | `\mycommand{...}` is `\texttt{\emph{...}}`, see Bespoke code |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\mycommand` | achemso-demo.tex:28 | yes | alias of `\texttt{\emph{#1}}`; expand inline with `mark.kernel` |

Not bespoke, because the class is published (W1 met by the CTAN release, which this zip carries): the author, affiliation and footnote-marker bookkeeping (achemso.dtx:799-1554, 1562-1781), the `\@startsection` swap (1907-1967), the abstract suppression trick (2044-2098), the `acs@collect` token collector behind `tocentry` (2110-2164), and the `\bibnote` writer (494-639). They belong to `class.achemso` and are reached only through its native vocabulary. The `LaTeXdemo` listings environment in the `ltxdoc` manual driver (achemso.dtx:78-155) is zip-local and irreducible-looking, but it belongs to the package manual, not to the template sample or to the class, so it is out of scope here.

## Content-opaque
- `\ch{H2SO4}` (`chemformula`) in running text at achemso-demo.tex:304; `\ch{IrH5(PPh3)2}` in a reference title at achemso-demo.bib:52.
- Figure artwork slots: `\includegraphics{graphic}` is commented out in the scheme and the equation (achemso-demo.tex:211, 257); the scheme and figure hold text only.

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- Not in the sample's path but in the class (in scope as class content): other journal configurations (achemso.dtx:2762-3365) only call `\SectionNumbersOff`, `\SectionsOff`, `\AbstractOff`, `\setkeys{acs}{...}`, `\captionsetup`, `\floatstyle`/`\restylefloat`, `\setlength` and `\def` of names and sizes, and the `jacsat` communication branch (achemso.dtx:3378-3571) uses `\twocolumn`, `\geometry`, `\setlength`, `\captionsetup` and class-hook redefinitions. All are published ways (`cols.twocolumn-cmd`, `page.geometry`, `sp.lengths`, `cap.caption`, `fig.float`) or class-native hooks.
- The sample's comment says `mhchem` is loaded (achemso-demo.tex:302); the preamble loads `chemformula` (achemso-demo.tex:13).
- Two passes with BibTeX are needed (`\bibnote` and the control entry go through `acs-<jobname>.bib`, achemso.dtx:648-704); that is the `bib.bibtex-bst` way, not an outside tool.
- No text addressed to an AI was found in the zip.
