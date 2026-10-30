yes

# 0582-biblatex-juradiss: biblatex-juradiss (German law thesis citation style, with its documentation sample)

- Unverified: read from the source, not compiled.
- Source: Source/0582-biblatex-juradiss/ (origin: https://mirrors.ctan.org/macros/latex/contrib/biblatex-contrib/biblatex-juradiss.zip; licence: LPPL)
- Kind: misc (a biblatex citation and bibliography style for German law theses; the manifest hint said thesis, the only sample is the package manual)
- Lib: v5
- Engine: needs XeLaTeX or LuaLaTeX (`libertinus-otf` and `\setmonofont` through fontspec, doc/biblatex-juradiss.tex:164-165); the bibliography backend is biber (doc/biblatex-juradiss.tex:751)
- Look carried by: mixed (the citation and bibliography look is in the zip's published biblatex style files `latex/biblatex-juradiss.bbx` and `.cbx`; the page, fonts and headings are scrartcl options plus the sample preamble)
- Class origin: tex-distribution-unbundled
- Main file: doc/biblatex-juradiss.tex (other samples: none; doc/biblatex-juradiss.pdf is the compiled form of the same file and was not read)
- Read: main yes, zip-local classes and styles all (`.bbx`, `.cbx`, `.dbx` read in full; no `.cls` or `.sty` present)

## Verdict
The zip is the CTAN release of the biblatex style `biblatex-juradiss` (ctan.org/pkg/biblatex-juradiss: LPPL, v0.23, "Contained in TeX Live"). The sample loads it by name, `style=biblatex-juradiss` in the `biblatex` options (doc/biblatex-juradiss.tex:185), so the style is a parameter of `bib.biblatex-biber`, as a `.bst` is of `bib.bibtex-bst`; its driver code is published code, not bespoke. Everything else in the sample is `scrartcl` with options and published packages. The three zip-local helper macros in the preamble and the one `\qverweis` alias reduce to lib ways. No artwork, nothing outside TeX except biber, which the lib already carries as `bib.biblatex-biber`. Two judgment calls are named under "Bespoke code" so a reviewer can overturn them: the published style counted as one way, and `\addsubsec` counted as reducible.

## Blockers
none

## Class setting
- Class: `class.scrartcl` options: `toc=graduated,parskip=half-,DIV=13,fontsize=11pt,paper=a4` (doc/biblatex-juradiss.tex:161). Source of `scrartcl` not read (KOMA-Script, ships with the TeX distribution).
- Class-native vocabulary used: `\subtitle` (doc/biblatex-juradiss.tex:274), `\addsec` (doc/biblatex-juradiss.tex:934), `\SecDef` and `\sectionnumdepth` and `\addsubsecmark` inside the preamble macro (doc/biblatex-juradiss.tex:248-262), class options `toc=graduated`, `parskip=half-`, `DIV=13`, `paper=a4`, `fontsize=11pt`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | doc/biblatex-juradiss.tex:161 | `class.scrartcl` | toc=graduated, parskip=half- (paragraph spacing is a class option here), DIV=13, fontsize=11pt, paper=a4 |
| paper and base size | doc/biblatex-juradiss.tex:161 | `page.class-options` | paper=a4, fontsize=11pt |
| type area | doc/biblatex-juradiss.tex:161 | `page.typearea` | DIV=13 |
| contents style | doc/biblatex-juradiss.tex:161 | `toc.koma` | toc=graduated |
| contents list | doc/biblatex-juradiss.tex:284 | `toc.kernel` | `\tableofcontents` after `\newpage` |
| main text face | doc/biblatex-juradiss.tex:164 | `font.libertine` | `libertinus-otf` (OpenType, XeLaTeX or LuaLaTeX) |
| monospace face | doc/biblatex-juradiss.tex:165 | `font.fontspec` | `\setmonofont[Scale=MatchLowercase,FakeStretch=0.9]{AnonymousPro}` (font not shipped) |
| euro glyph package | doc/biblatex-juradiss.tex:163 | `font.icons` | `eurosym`, loaded, `\euro` not called in the sample |
| TeX logos | doc/biblatex-juradiss.tex:169; used at :306, :343, :351 | `font.icons` | `dtk-logos`, `\MiKTeX` `\TeXLive` (logo-by-name package, as `hologo`; ctan.org/pkg/dtk-logos is a 404, so W1 for this one package rests on it loading from the distribution, not on a CTAN page) |
| language | doc/biblatex-juradiss.tex:166 | `lang.babel` | ngerman; `"=` shorthand used at :343, :350 |
| quotation marks | doc/biblatex-juradiss.tex:174 | `lang.csquotes` | babel, german=guillemets |
| source listings | doc/biblatex-juradiss.tex:167-168, :410 | `code.listings` | `\lstset{basicstyle=\ttfamily}`; env options frame=single, xleftmargin=\fboxsep, xrightmargin=\fboxsep |
| inline verbatim | doc/biblatex-juradiss.tex:938 | `code.verbatim` | `\verb\|...\|` |
| lists | doc/biblatex-juradiss.tex:311-318, :728-747 | `list.kernel` | `itemize` |
| list spacing | doc/biblatex-juradiss.tex:170-171 | `list.enumitem` | `\setlist{nosep}` |
| URL breaking | doc/biblatex-juradiss.tex:191 | `meta.url` | `xurl` |
| links | doc/biblatex-juradiss.tex:245 | `meta.hyperref` | colorlinks, linktocpage |
| framed bibliography output | doc/biblatex-juradiss.tex:234-243, :802-809 | `box.mdframed` | leftmargin=0pt, rightmargin=0pt, linecolor=black, backgroundcolor=black!10 |
| frame colours | doc/biblatex-juradiss.tex:234, :240 | `color.xcolor` | `black!10` |
| pull-up inside frame | doc/biblatex-juradiss.tex:241, :807 | `sp.manual-space` | `\vspace{-\normalbaselineskip}` |
| title block | doc/biblatex-juradiss.tex:273-277 | `front.maketitle` | `\title`, `\author{.. \and ..}`, `\maketitle` |
| subtitle | doc/biblatex-juradiss.tex:274 | `front.koma-title` | `\subtitle{Ver. 0.23}` |
| title-page filler | doc/biblatex-juradiss.tex:279-282 | `sp.manual-space` | `\vfill` then text, then `\newpage` |
| page breaks | doc/biblatex-juradiss.tex:282, :286 | `pg.break` | `\newpage` |
| sectioning | doc/biblatex-juradiss.tex:287, :302, :404 | `head.kernel` | `\section`, `\subsection`; look set by the class |
| unnumbered section in contents | doc/biblatex-juradiss.tex:934 | `head.class-native` | KOMA `\addsec{Quellen -- Beispielverzeichnisse}` |
| unnumbered subsection in contents | doc/biblatex-juradiss.tex:196, :247-263 | `head.kernel` + `toc.kernel` + `num.secnumdepth` | `\subsection*{T}` and `\addcontentsline{toc}{subsection}{T}`; see Bespoke code |
| footnotes | doc/biblatex-juradiss.tex:559-561, :591, :842 | `fn.kernel` | `\footnote{..}` |
| cross references | doc/biblatex-juradiss.tex:792, :924; latex/biblatex-juradiss.cbx:17 | `xref.kernel` | `\label`, `\ref`, `\pageref` |
| inline marks | doc/biblatex-juradiss.tex:230-232, :559 | `mark.kernel` | `\texttt`, `\emph`, `\textbackslash` |
| bibliography package | doc/biblatex-juradiss.tex:178-189 | `bib.biblatex-biber` | uniquename=true, singletitle=true, sorting=nyvt, sortcites=true, maxnames=3, idemtracker=constrict, style=biblatex-juradiss, ibidtracker=false, datezeros=false, date=short |
| bibliography data and heading | doc/biblatex-juradiss.tex:194, :196 | `bib.biblatex-biber` | `\addbibresource{\jobname.bib}`; `\defbibheading{subbib}{..}` |
| categories and print calls | doc/biblatex-juradiss.tex:200-228, :242, :808, :964-981 | `bib.biblatex-biber` | `\DeclareBibliographyCategory`, `\addtocategory`, `\printbibliography[category=,type=,nottype=,heading=,title=]`, `\nocite{*}` |
| citations in the body | doc/biblatex-juradiss.tex:407-408, :529-530, :617-618, :908-909 | `bib.biblatex-biber` | `\footcite`, `\cite`, `\parencite`, `\footcites`, `\cites`, `\parencites` with prenote and postnote |
| citation and bibliography look | latex/biblatex-juradiss.bbx:6; latex/biblatex-juradiss.cbx:7 | `bib.biblatex-biber` | published style loaded by name: `style=biblatex-juradiss` builds on the published `authortitle-dw` of `biblatex-dw` (ctan.org/pkg/biblatex-dw read: in TeX Live; the page does not name `authortitle-dw`, its source was not read) |
| style options set by the style | latex/biblatex-juradiss.bbx:8, :13; latex/biblatex-juradiss.cbx:9-14 | `bib.biblatex-biber` | editorstring=parens, singletitle=true for online and book, namefont=italic, firstnamefont=italic, edstringincitations=false |
| style entry drivers | latex/biblatex-juradiss.bbx:34-581; latex/biblatex-juradiss.cbx:160-333 | `bib.biblatex-biber` | `\DeclareBibliographyDriver` for article, commentary, jurisdiction, legal, book, periodical, incollection, inbook, online and the `cite:*` drivers; part of the published style, not decomposed |
| style bibliography spacing | latex/biblatex-juradiss.bbx:16 | `sp.lengths` | `\setlength{\bibitemsep}{3pt}` (inside the published style) |
| style datamodel | latex/biblatex-juradiss.dbx:5-12 | `bib.biblatex-biber` | fields decision, decisionname, sign, officialvolume, officialpages, journalyear for entry type jurisdiction (biber only; nothing in the sample or the `.bbx`/`.cbx` sets `datamodel=`, so whether biblatex loads this file by itself was not established here) |

No header or footer, abstract, theorem, figure, table, caption, index, glossary or appendix is defined or used.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `biblatex-juradiss.bbx`, `.cbx`, `.dbx` (about 980 lines of biblatex driver code, booleans `zitiertals` at latex/biblatex-juradiss.bbx:444-460, renewed delimiters, `\newbibmacro`) | latex/biblatex-juradiss.bbx:1-589; latex/biblatex-juradiss.cbx:1-351; latex/biblatex-juradiss.dbx:1-41 | Not bespoke: published (CTAN, LPPL, TeX Live) | `\usepackage[style=biblatex-juradiss,...]{biblatex}` with biber; the emitter never copies the driver code. Judgment call 1: a reviewer who counts the driver code as zip-local would have to call it irreducible (BESPOKE/package) and flip the verdict. The style has no options of its own (README:7-16; ctan.org page lists none) and the sample does not copy or edit its code, so W2 holds for the use in the sample. |
| `\addsubsec`, `\@addsubsec`, `\@saddsubsec` | doc/biblatex-juradiss.tex:247-263 | Yes (judgment call 2) | The only call is the unstarred one, from `\defbibheading{subbib}{\addsubsec{#1}}` (doc/biblatex-juradiss.tex:196). Its whole effect is a subsection with no number that still gets a contents entry, got by lowering `secnumdepth` for one `\subsection`. Reduction: `\defbibheading{subbib}{\subsection*{#1}\addcontentsline{toc}{subsection}{#1}}` (`head.kernel` + `toc.kernel`; `num.secnumdepth` is the counter it toggles). No layout is computed; the starred branch `\addsubsecmark{}` is never reached. The body is TeX-level (`\edef`, `\numexpr`, KOMA `\SecDef`), which is why a strict reader may disagree. |
| `\showbib#1` | doc/biblatex-juradiss.tex:235-243 | Yes | Inline expansion at each of its ten uses: `mdframed` (`box.mdframed`) with the four options at :237-240, then `\vspace{-\normalbaselineskip}`, then `\printbibliography[category=N]`. The same frame is written out by hand at :802-809. |
| `\bibj`, `\bib`, `\cs#1` | doc/biblatex-juradiss.tex:230-232 | Yes | Aliases: `\texttt{biblatex-juradiss}`, `\texttt{biblatex}`, `\texttt{\textbackslash#1}` (`mark.kernel`); the `\xspace` tail is resolved when the text is emitted. |
| `\qverweis#1` | latex/biblatex-juradiss.cbx:17 | Yes | `\ref{#1}, S.\ppspace\pageref{#1}` (`xref.kernel`; `\ppspace` is a biblatex macro), expanded where used (doc/biblatex-juradiss.tex:842, :931). |
| `\usepackage{xspace}` | doc/biblatex-juradiss.tex:193 | Yes | Only serves the tail of `\bibj` and `\bib` above; the lib rejected `sp.xspace` in v4 for the same reason, so nothing is added. |
| `.bib` written from the document | doc/biblatex-juradiss.tex:5-158 | Yes | `filecontents[force,noheader]{\jobname.bib}` is a kernel environment that only delivers data; the emitter ships the `.bib` as an asset and keeps `\addbibresource`. The entries are content (see below). |
| dead code after `\endinput` | latex/biblatex-juradiss.dbx:14-28; latex/biblatex-juradiss.cbx:336-351 | Not applicable | Old `\DeclareStyleSourcemap` code (maps of `decision` and others to `usera` to `userf`) that sits after `\endinput` and is never read; no effect on output (Changes:2-3 says v0.23 replaced the user fields with a `.dbx`). |

## Content-opaque
- The `.bib` entries, including the non-standard entry types and fields (`@COMMENTARY`, `@JURISDICTION`, `@LEGAL`, `gender`, `entrysubtype`, `decision`, `sign`, `officialvolume`; doc/biblatex-juradiss.tex:6-157): bibliographic data.
- The bodies of the `lstlisting` blocks (BibTeX and LaTeX source shown as text; doc/biblatex-juradiss.tex:410-414, :454-465, :499-508, :532-537, :602-615, :798-800, :824-830, :862-886, :911-916, :943-959, :963-971).
- The bibliography text that `\printbibliography` produces inside the frames.
- Missing asset: the Anonymous Pro font named at doc/biblatex-juradiss.tex:165 is not shipped.

## Lib changes
- New ways proposed: none. Considered and not proposed: a separate way for a third-party biblatex style (it has a home, `bib.biblatex-biber`, with the style name as the parameter, as `bib.bibtex-bst` takes a `.bst`); `filecontents` (data delivery, the entries are content); `xspace` (rejected in v4).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
- Not established, for the consolidator: `dtk-logos` mapped to `font.icons` by type (logo commands printed by name); ctan.org/pkg/dtk-logos is a 404 and the package could be part of another bundle.
