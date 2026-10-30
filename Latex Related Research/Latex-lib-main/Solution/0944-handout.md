no

# 0944-handout: handout (CTAN package that appends a talk handout; manual on `ltxdockit` and seven `article` examples)

- Unverified: read from the source, not compiled.
- Source: Source/0944-handout/ (origin: https://mirrors.ctan.org/macros/latex/contrib/handout.zip; licence: LPPL 1.3 (handout.sty:3-9; manifest `lppl1.3`; ctan.org/pkg/handout read: v1.6.0 of 2017-04-21, in TeX Live and MiKTeX))
- Kind: misc (a package manual with demo documents; the manifest category says presentation, but the main sample documents a package and is not a talk)
- Lib: v6
- Engine: needs XeLaTeX (`fontspec` handout.tex:3, `bidi` handout.tex:12, build line `xelatex --shell-escape` latexmkrc:1; the examples need `polyglossia` + `fontspec`, examples/example1-minimal.tex:2). handout.sty alone holds no engine-specific code (handout.sty:16-157) and the CTAN page states no engine.
- Look carried by: mixed (the manual's page, title page, headings, contents, lists and doc markup come from the class `ltxdockit`, handout.tex:1; its fonts, language, quotes and listings come from the preamble, handout.tex:3-12; handout.sty is a published CTAN package used only by the examples)
- Class origin: tex-distribution-unbundled (`ltxdockit` is not in the zip; ctan.org/pkg/ltxdockit read: Philipp Lehman, LPPL 1.3, v1.2d, in TeX Live and MiKTeX, marked unsupported, no base class or engine stated; its source was not read)
- Main file: handout.tex (other samples: examples/example1-minimal.tex to examples/example7-biblatex.tex, all `article`; examples/txt/*.tex are included fragments)
- Read: main yes, zip-local classes and styles all (handout.sty, 157 lines, read in full; the zip has no .cls; ltxdockit.cls and btxdockit.sty are not in the zip and were not read)

## Verdict
`no`. The main sample loads `minted` unconditionally (handout.tex:11) and calls it in ten `minted` environments; `minted` needs shell escape and Pygments, and the zip's own build line passes `--shell-escape` (latexmkrc:1), so by the pilot ruling it is `EXTERNAL/package`. The rest maps: the look is one published class (`ltxdockit`) plus published preamble packages, and handout.sty is a published CTAN package that I propose as `NEW:struct.handout` (no zip-local macro is defined in the main sample). The class source was not read, so what `ltxdockit` loads itself is unverified.

## Blockers
- `EXTERNAL/package` `minted` loaded unconditionally in the main preamble (handout.tex:11) and used at handout.tex:52, 57, 75, 91, 99, 120, 125, 129, 157, 181; it needs `--shell-escape` and Pygments (latexmkrc:1)

## Class setting
- Class: `class.ltxdockit` options: none; the bracket after the class name is a minimum release date `[2011/03/25]` (handout.tex:1). The examples use `class.article` with `a4paper` (examples/example1-minimal.tex:1).
- Class-native vocabulary used: `\titlepage{title,subtitle,email,author,revision,date,url}` (handout.tex:14-21) and `\printtitlepage` (:26); inline markup `\cs{}` (:50), `\cmd{}` and `\env{}` (:74), `\opt{}` (:98); `\see{label}` (:196); a `changelog` environment of `release{version}{date}` environments holding `\item`s (:194-231). Which of these `ltxdockit.cls` or `btxdockit.sty` defines was not checked (neither is in the zip). Examples: article's `\section`, `quotation`, `\footnote`; biblatex's `\footcite`, `\AtNextCitekey`, `\strfield`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class (manual) | handout.tex:1 | `class.ltxdockit` | no options; minimum date `[2011/03/25]` |
| page, header/footer, spacing | handout.tex:1 (nothing set in the sample) | `class.ltxdockit` | class defaults, source not read |
| documentation-kit package | handout.tex:2 | `dtx.doc` | `btxdockit` as the parameter (a package-documentation package, as `hypdoc` and `codedescribe` are); load-only here, no command of it identified in the sample; a judgement call, see Notes |
| font engine, mono face | handout.tex:3, 8 | `font.fontspec` | `\setmonofont[Scale=MatchLowercase]{DejaVu Sans Mono}`; the font is a system font the zip does not ship (missing asset) |
| text face | handout.tex:4 | `font.libertine` | `mono=false` |
| microtypography | handout.tex:5 | `sp.microtype` | defaults |
| language | handout.tex:6 | `lang.babel` | `american` |
| quotation marks | handout.tex:7 | `lang.csquotes` | `strict` |
| short verbatim | handout.tex:9 | `code.verbatim` | `shortvrb` load-only; `\MakeShortVerb` is not called (grep of handout.tex) |
| symbol glyphs | handout.tex:10 | `font.icons` | `pifont` load-only, no `\ding` call seen |
| bidirectional text | handout.tex:12 | `lang.bidi` | load-only, no `\RL`/`\LR` seen; XeLaTeX/LuaLaTeX only |
| code listings | handout.tex:11, 52-54, 181-189 | `code.minted` | `\begin{minted}{tex}` (nine) and `{latex}` (one); EXTERNAL; the listed text is content |
| title block | handout.tex:14-21, 26 | `front.class-native` | `\titlepage{title={Making handout}, subtitle={to support your talk}, email, author, revision={1.6.0}, date={21/04/2017}, url}` then `\printtitlepage` |
| contents | handout.tex:27 | `toc.kernel` | `\tableofcontents`, look from the class |
| headings | handout.tex:29, 30, 148, 190 | `head.class-native` | `\section`, `\subsection`, `\subsubsection`; the sub-subsection title holds inline `\cmd` markup |
| lists | handout.tex:64-67, 83-87, 118-132 | `list.kernel` | `enumerate`, `itemize`; defaults (the `itemize` at :183-187 sits inside a `minted` listing, so it is code content) |
| footnotes | handout.tex:38, 40, 44 | `fn.kernel` | `\footnote` holding `\url{...}` |
| urls | handout.tex:21, 38, 44 | `meta.url` | `\url{...}`; where `url` is loaded (class or `hyperref`) is unread |
| emphasis | handout.tex:38 | `mark.kernel` | `\emph{...}` |
| TeX logos | handout.tex:46 | `font.icons` | `\XeLaTeX` is defined outside the zip (class or a loaded package, unread); the type of `hologo` logos; `\LaTeX` is kernel |
| labels | handout.tex:138, 140, 148, 190 | `xref.kernel` | `\label{enablehandout}`, `{printing}`, `{forhandout}` (the same label twice, :148 and :190) |
| doc markup | handout.tex:50, 74, 98 | `class.ltxdockit` | `\cs{}` `\cmd{}` `\env{}` `\opt{}` |
| change history | handout.tex:194-231, 196, 216, 221 | `class.ltxdockit` | class `changelog`/`release`/`\see`; not the CTAN `changelog` package (`list.changelog`) |
| class (examples) | examples/example1-minimal.tex:1 | `class.article` | `a4paper` |
| paper size (examples) | examples/example1-minimal.tex:1 | `page.class-options` | `a4paper` |
| language (examples) | examples/example1-minimal.tex:2-3 | `lang.polyglossia` | `\setmainlanguage{french}`; `fontspec` load-only (`font.fontspec`) |
| handout package | examples/example1-minimal.tex:4; examples/example3-defined-path.tex:4; examples/example5-numbering.tex:4 | `NEW:struct.handout` | none; `dir=txt`; `dir=txt,sectioning,numbering` |
| handout body wrapper | examples/example1-minimal.tex:9; examples/example6-not-and-only.tex:12 | `NEW:struct.handout` | `\handout{file}`; the file holds a `quotation` (content) |
| handout copy of headings | examples/example4-sectioning.tex:4; handout.sty:88-98 | `NEW:struct.handout` | `sectioning` boolean |
| handout numbering | examples/example5-numbering.tex:4; handout.sty:150-155 | `NEW:struct.handout` | `numbering` boolean; default number is `\fbox{\arabic{handoutnumber}}` in a `\marginpar` |
| handout-only and main-only text | examples/txt/Preau1583-not-and-only.tex:3 | `NEW:struct.handout` | `\nothandout{...}` and `\onlyhandout{...}` inside one `\footnote` (`fn.kernel`) |
| handout hook | examples/example2-cancel-quotation.tex:5-7 | `NEW:struct.handout` | `\beforehandout` set to `\renewenvironment{quotation}{}{}` (`quote.kernel`) |
| quotation | examples/txt/Preau1583.tex:2-4 | `quote.kernel` | `quotation` environment |
| sectioning (examples) | examples/example4-sectioning.tex:10, 15 | `head.kernel` | `\section{...}` |
| citations (examples) | examples/example7-biblatex.tex:3-4, 29 | `bib.biblatex-biber` | `style=verbose-trad2`, `\bibliography{example}`, no `backend` key (default biber), `\footcite[33]{Preau1583}`; data in examples/example.bib |
| handout copy of citations | examples/example7-biblatex.tex:11-25 | `NEW:struct.handout` | `\citehandout` writes `\cite[..]{..}` into the handout with `\forhandout`; see Bespoke code |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| handout.sty (whole package) | handout.sty:16-157 | not bespoke: published | the zip is the CTAN release (manifest source `ctan`; ctan.org/pkg/handout read), so W1 holds; it is the way `NEW:struct.handout`. Its internals are a `\write` file replay (:37-38, 49, 63, 70), a patch of `\@sect` (:90-96), an `\AtEndDocument` replay (:101-113) and counter resets (:116-141). If the zip were judged zip-local instead, they would be irreducible `BESPOKE/package`; the verdict stays `no` either way |
| `kvoptions`, `etoolbox`, `suffix` | handout.sty:17 | not template components | implementation helpers of handout.sty (considered: no way, as `sp.xspace` was rejected in v4) |
| `\beforehandout` with `\renewenvironment{quotation}{}{}` | examples/example2-cancel-quotation.tex:5-7 (same in examples 3-7) | yes | kernel `\renewenvironment` with empty begin and end code, as the `NEW:struct.handout` hook and `quote.kernel`; scope preamble |
| `\citehandout`, `\beforehandoutref`, `\afterhandoutref` | examples/example7-biblatex.tex:11-25 (listing at handout.tex:158-172) | yes, with a judgement | an alias of published commands only: biblatex `\AtNextCitekey` and `\strfield`, `\forhandout` (`NEW:struct.handout`), `\par\noindent\hspace{-2\parindent}` and `\par\vskip0.25\baselineskip` (`sp.manual-space`); no counter, conditional or box logic; scope preamble (an emitter would copy the alias text, which a strict reader could count as zip-local macro logic) |
| macros of the main sample | handout.tex | none defined | the main preamble and body call only published packages and class commands |

## Content-opaque
none (the text inside the `minted` listings is code content; the `minted` way itself is the blocker)

## Lib changes
- New ways proposed: `NEW:struct.handout` `handout` (CTAN, TeX Live, LPPL 1.3; Maïeul Rouquette; v1.6.0 of 2017-04-21), engine `pdf` (no engine-specific code, handout.sty:16-157; the CTAN page states none). `\usepackage[disabled,numbering,sectioning,printing=false,dir=..]{handout}`, body `\handout{file}`, `\forhandout{..}` and `\forhandout*{..}`, `\nothandout{..}` and `\onlyhandout{..}`, `\disablehandout` and `\enablehandout`, hooks `\beforehandout` `\afterhandout` `\AtEveryHandout`, number formats `\thehandoutnumber` `\handoutnumber` `\handoutnumberintxt`. It prints a second copy of marked material after the document, with page, footnote, figure and table counters reset, in one pass and with no external tool. W1: on CTAN under LPPL 1.3 (handout.sty:3-9). W2: four booleans and the string `dir`; hook bodies must be declarative lib calls, as in `slide.beamer-section-hook`, arbitrary hook code is outside the way. W3: any article-like document that wants a handout, not one talk. W4: one preamble line and a body wrapper `\handout{file}` around a node written to its own file, plus `\forhandout`, `\onlyhandout`, `\nothandout` wrappers. Not `struct.input` (plain inclusion, no second copy at the end), not `slide.beamer-mode` (beamer's own handout mode), not `pg.include-pdf`.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- `dtx.doc` for `btxdockit` is a judgement: the line names `hypdoc` and `codedescribe` as package-documentation packages that are the parameter; `btxdockit` is the BibTeX-and-biblatex documentation kit shipped with `ltxdockit`, and the CTAN page for `ltxdockit` names no files, so its content was not confirmed.
- Soft hyphens (U+00AD) sit inside the prose at handout.tex:32 and :34; they are text content.
- A stray `+` opens handout.tex:55; text content. No text in the zip is addressed to an AI.
