no

# 0652-template-latex-professional-cv: Professional-CV (Template-Latex, Pablo Pizarro R.)

- Unverified: read from the source, not compiled.
- Source: Source/0652-template-latex-professional-cv/ (origin: https://codeload.github.com/Template-Latex/Professional-CV/zip/refs/heads/master; licence: MIT)
- Kind: cv
- Lib: v5 (the snapshot read)
- Engine: pdfLaTeX-compatible (the default branch uses `tgpagella` + `microtype`; a `\compilertype` switch also supports XeLaTeX via `fontspec` and LuaLaTeX, template.tex:75-85, 162-178)
- Look carried by: preamble (no zip-local .cls/.sty; the sample `\input{template}` at cv.tex:31, and template.tex is the flattened form of src/*.tex)
- Class origin: tex-distribution-unbundled (kernel `article`, not in the zip)
- Main file: cv.tex (other samples: none; `source_template.tex` is the modular loader of src/*.tex, not a sample)
- Read: main yes, zip-local classes and styles none present (all zip-local `.tex` modules read: template.tex bundle, template_config.tex, src/*.tex)

Citation convention: `cv.tex` loads `template.tex` (cv.tex:31). I checked that `template.tex` equals the concatenation of `src/defs`, `config`, `imports`, `function`, `env`, `initconf`, `pageconf` (only 8 comment lines differ), and `template_config.tex` equals `src/config.tex` (0 differences). Citations are `template.tex:N`; the same line is in `src/` at an offset (imports -16, function -733, env -1382, initconf -1752, pageconf -1916).

## Verdict
No. The look is defined by a zip-local macro layer loaded from the preamble, and its core is irreducible: `\printifspace` measures a box against `\pagegoal-\pagetotal` and, depending on the result, prints, replaces, fills the page with one of ~100 trial `\vspace` values or issues `\newpage` (template.tex:769-917); every `cvblock` rule and every institution entry runs through it. The header is built by writing items to `\jobname.hitems` and `\input`-ing the file back under sticky-separator counters (template.tex:749-766, 1129-1160), and institution entries pick their layout from `\settowidth` comparisons (template.tex:1245-1269). No lib way holds page-position-dependent conditional layout. Most of the rest (fonts, geometry, `fancyhdr` footer, hyperref metadata, lists, tables) maps to existing ways, so the blocker is the bespoke layer, not a missing package.

## Blockers
- `BESPOKE/preamble` page-space probe `\printifspace`, `\printifspacefill`, `\printifnewpage`, `\coreiprintifspacefill`: `\sbox`+`\parbox` height compared with `\measurepage` (`\pagegoal-\pagetotal`), modes `np`/`r`/`s`/`i`, global flag `\GLOBALprintspacefilled`, 100 hard-coded fill sizes (template.tex:748, 769-771, 775-917); called from `cvblock` (template.tex:1406, 1412, 1422, 1428), `institution` (template.tex:1633, 1645) and `\newinstitutionentry` (template.tex:1256, 1287-1289); in mode `i` the block rule is dropped when the block has to start a new page (template.tex:910-913, 1406-1409)
- `BESPOKE/preamble` header buffer: `\newwrite`/`\openout` of `\jobname.hitems`, every `\addheader*` command `\write`s a fragment, sticky-separator counters and global flags decide where separators go, `\writeheader` `\input`s the file (template.tex:746-751, 764-766, 1016-1126, 1156)
- `BESPOKE/preamble` `\newinstitutionentry`: `\settowidth` of title+date compared with `0.95\linewidth` and `0.175\linewidth` selects one-line versus two-minipage layout and the space requested from `\printifspace` (template.tex:1245-1269)
- `BESPOKE/preamble` `\ignorelinebreaks` catcode hack (`\catcode`\^^M=9`, `\endlinechar`) used by `cvsblock` (template.tex:754-757, 1467-1474)

No `ART`, no `EXTERNAL`, no `UNMAPPED` component (the only unhomed item is the pdfTeX output parameters, proposed below).

## Class setting
- Class: `class.article` options: `spanish`, `letterpaper` (cv.tex:13-16). `spanish` is also read by `tracklang` to pick the babel options (template.tex:88-93).
- Class-native vocabulary used: none; the sample uses `\section*` only through the template's `cvblock` (template.tex:1439) and no `\maketitle`, abstract or bibliography.

## Component map
Paths are template.tex unless stated. Default values come from template_config.tex (the shipped config).

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | cv.tex:13-16 | `class.article` | spanish, letterpaper |
| paper size | cv.tex:15 | `page.class-options` | letterpaper |
| page geometry | 133-137, 989-995, 1936; template_config.tex:75-78 | `page.geometry` | `\newgeometry{left=1.9cm, top=1.5cm, right=1.9cm, bottom=1.9cm}` called from `\templatePagecfg`; the LuaLaTeX branch passes the same keys at load (134) |
| base font size | 63-65; template_config.tex:13 | `font.size-commands` | `\changefontsizes{11pt}` from `scrextend` (a size command; no lib line names it, filed by type under sizes) |
| arbitrary sizes | 64 | `font.exscale` | `anyfontsize` load-only (same type as `fix-cm`) |
| main text font | 162-178; template_config.tex:15 | `font.palatino` | `\fontdocument=default`: pdfTeX `tgpagella` (176); XeLaTeX branch is `font.fontspec` `\setmainfont` texgyrepagella OTF, Numbers=OldStyle, Ligatures={Common,Contextual} (163-173) |
| microtyping | 174, 177 | `sp.microtype` | pdfTeX `expansion,protrusion`; XeTeX `protrusion` |
| font selector | 162-731 | `font.palatino`, `font.helvet`, `font.libertine`, `font.serif-pkg`, `font.mathptmx`, `font.lmodern`, `font.family-default` | ~100 string branches of `\ifthenelse{\equal{\fontdocument}{..}}` each load one published font package; inactive under the shipped config, reducible by selecting the branch; I did not check every non-default package on CTAN |
| typewriter font | 677; template_config.tex:16 | `font.family-default` | `\fonttypewriter=cmodern` is an empty branch (no change); other branches set `\ttdefault` or load a mono package |
| encodings, Unicode | 97, 734-735, 738 | `font.fontenc-t1` | `inputenc[utf8]`, `fontenc[T1]`, `textcomp`, `selinput`, `commonunicode` (CTAN page read: published, MIT, pdfTeX intended) |
| language | 88-93 | `lang.babel` | `[es-nosectiondot,es-lcroman,es-noquoting,noconfigs]` when `spanish` is tracked, else `[noconfigs]`; `tracklang` only detects the option |
| quotation marks | 736, 740-743, 1345-1348 | `lang.csquotes` | `\DeclareQuoteStyle[spanish]{spanish}{\textquotedblleft}{\textquotedblright}[0.05em]{\textquoteleft}{\textquoteright}`; `\quotes` is an `\enquote` alias |
| colours | 16-20, 110, 1858; template_config.tex:45-66 | `color.xcolor` | `xcolor[dvipsnames,table]`; dark-blue RGB 38,38,102, gray 127, lgray 180; `\color{black}`; `color` also loaded (110) as `color.color` |
| page colour | 1879-1881 | `color.pagecolor` | only when `\colorpage` is not white; shipped value is white, so unused |
| footer | 1936-2006 (style10 at 1991-1996); template_config.tex:28 | `hf.fancyhdr` | `\pagestyle{fancy}\fancyhf{}`, `\fancyfoot[L]` `\small\name` and `[R]` `\small\thepage` in lgray, `\headrulewidth` 0pt, `\footrulewidth` 0pt; `style1` is `hf.pagestyle-kernel` (`empty`); 11 styles chosen by string |
| line spacing | 1851; template_config.tex:14 | `sp.linespread` | `\baselinestretch`=1.1 |
| other spacing packages | 114, 120, 124 | `sp.indentfirst`, `sp.ragged`, `sp.setspace` | `indentfirst`, `ragged2e`, `setspace` loaded; `setspace` never called; `flushright`/`flushleft` kernel environments used in the template (1538, 1572, 1736) |
| TeX parameters | 1890-1893 | `sp.lengths`, `sp.penalties` | `\hfuzz`=`\vfuzz`=200pt (lengths); `\hbadness`=`\vbadness`=`\maxdimen` (integer parameters, same family) |
| tt hyphenation | 1896 | `sp.hyphenat` | `\ttfamily \hyphenchar\font=`\-` (hyphenation-control primitive; interpretive mapping) |
| section headings | 139-141, 2013; template_config.tex:69-72 | `head.titlesec`, `head.sectsty` | `\titlespacing{\section}{0pt}{1.1em plus 0.25em minus 0.25em}{0.9em plus 0.25em minus 0.25em}`; `\sectionfont{\color{black}\Large\bfseries\selectfont}` |
| block title | 1438-1441 | `head.kernel`, `toc.kernel` | `\section*{title}` then `\addcontentsline{toc}{section}{title}` (no contents list printed) |
| block rule | 1404-1432 | `sp.rule` | `\textcolor{gray!35}{\hrule}`; dotted style `\makebox[1.01\textwidth][l]{\dotfill}`; the gate around each is `\printifspace` (bespoke) |
| title block (name + contact line) | cv.tex:39-46, 1129-1160 | bespoke (see Bespoke code) | `\huge\bfseries` name in black, items joined by `\sbullet`; atoms are `meta.hyperref` (`\href`, `\url`), `font.icons` (`fontawesome5` `\faIcon`, 1019, 1054), `sp.manual-space` |
| summary text | cv.tex:59-62, 1493-1513, 1517-1527 | `cols.multicol` | `multicols{2}`, `\columnsep` 20pt, `\small`; inside `cvblock` (bespoke gate) |
| photo summary / photo | 1531-1561 | `box.minipage`, `box.fancybox`, `fig.graphicx` | minipage 3.5cm, `\fbox` with `\fboxsep` 0pt, `\includegraphics[width=0.99\linewidth]` |
| personal data table | cv.tex:66-73, 1203-1210, 1565-1601 | `tbl.tabular`, `fig.float`, `box.minipage` | `table[H]` holding `tabular{ll}`, `\tabcolsep` 0.5em (1854), `\arraystretch` 1.185 |
| institution header | cv.tex:85-96, 1607-1674 | `box.minipage`, `mark.kernel`, `meta.hyperref`, `font.size-commands`, `list.kernel` | two minipages 0.56/0.44 of `\linewidth`, `\textsc` region, `\textscale{1.1}` (relsize), `\href`; `institutionindent` is a `list` with `\leftmargin` 0.5/1.0 x 15pt, zero `\parsep` `\parskip` `\itemsep` `\topsep` (1677-1694); wrapped by `\printifspace` (bespoke) |
| institution entry | cv.tex:86-87, 1222-1293 | `box.minipage`, `mark.kernel`, `color.xcolor` | `\textbf` title, `\emph` date in gray!90, `\hfill` or right-flushed minipage 0.17/0.3; layout chosen by measured width (bespoke) |
| icon variants | 1701-1731 | `fig.graphicx`, `sp.manual-space` | `\raisebox{-0.15\baselineskip}{\includegraphics[height=1\baselineskip]{..}}` for sizes small/normal/large/huge |
| bullet and enumerate lists | cv.tex:115-118, 1747-1759, 1886-1887, 1921-1923 | `list.enumitem`, `sp.manual-space`, `fig.rotating` | `itemize[font=\bfseries]`, `\setitemize/\setenumerate{itemsep=0pt}`, `\labelitemi` = `\raisebox{0.5\height}{\scalebox{0.5}{$\blacksquare$}}` (graphicx `\scalebox`); `\AfterEndEnvironment{itemize|enumerate}{\vspace{-0.4\baselineskip}}` (etoolbox) |
| skills rows | cv.tex:122-123, 1314-1318 | `list.paralist` | `basedescript` from `mdwlist`, label `\textbf` |
| signature | cv.tex:127-130, 1322-1324, 1734-1743 | `fig.graphicx`, `tbl.tabular`, `sp.ragged`, `mark.case`, `mark.kernel` | `flushright`, `tabular{c}`, `\includegraphics[width=5cm]`, `\texttt{\MakeUppercase{..}}`, `\vfill` |
| PDF links and metadata | 146, 152-155, 1794-1835, 1869-1877; template_config.tex:80-91 | `meta.hyperref`, `meta.bookmark`, `meta.hyperxmp`, `meta.url` | `hyperref[pdfencoding=auto,psdextra]`, `colorlinks=true`, `hidelinks`, `pdfinfo={Author.Email=.. Template.*}`; `xurl`, `\urlstyle{same}` (1899); `bookmark`; `hyperxmp` |
| included PDFs | 147 | `pg.include-pdf` | `pdfpages[final]` loaded, never called |
| PDF output parameters | 1902-1918 | `meta.pdf-params` | `\pdfcompresslevel`=9, `\pdfdecimaldigits`=2, `\pdfinclusionerrorlevel`=0, `\pdfminorversion`=7, `\pdfobjcompresslevel`=2, only under `\compilertype=pdf2latex` |
| graphics path | 1848 | `fig.graphicx` | `\graphicspath{{./img}}` |
| symbol glyphs | 127 | `font.icons` | `wasysym` loaded |
| loaded, little or no call | 107, 109, 111, 116-117, 125, 128, 154, 156 | `math.amssymb`, `tbl.booktabs`, `tbl.colortbl`, `math.bm`, `math.mathtools`, `mark.ulem`, `fig.wrapfig`, `fig.float`, `tbl.multirow` | load-only (`soul`'s `\sethlcolor{yellow}` at 1860 is the only call); `colortbl` is used via `\arrayrulecolor` (1859), `float` via `table[H]` (1591), `amssymb` via `\blacksquare` (1923) |
| filler text | cv.tex:60-61, 86-87, 95, 102 | `draft.todo` | `\lipsum[75]`, `[66]`, `[65]`, `[133]`, `[130]` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\printifspace` family | template.tex:748, 769-917 | no | Page-position-dependent conditional layout (box height vs `\pagegoal-\pagetotal`, global flag, 100 trial `\vspace` sizes). `pg.needspace` takes a fixed length, cannot print or replace content by the outcome, and cannot measure the content's own height; the `r` mode (template.tex:1287-1289: add the bottom gap only if 3 baselines still fit) and the `s` mode (template.tex:1428) have no lib equivalent |
| header buffer (`\addheader*`, `\writeheader`, `hitems` file) | template.tex:746-751, 764-766, 1016-1160 | no | File write-and-reread with counters and global flags choosing separators; an emitter could print a literal contact line, but that is not the template's macro behaviour |
| `\newinstitutionentry` | template.tex:1222-1293 | no | Layout branches on `\settowidth` measurements; needs `\printifspace` |
| `cvblock`, `cvsblock`, `cvblocki`, `cvblocke`, `summary*`, `photosummary`, `personaltabledata`, `institution*`, `signature`, `itemizebf`, `enumeratebf` | template.tex:1404-1759 | partly | Bodies reduce to the ways in the component map (`sp.rule`, `head.kernel`, `cols.multicol`, `box.minipage`, `list.enumitem`...), but `cvblock` and `institution` call `\printifspace`, so they inherit its blocker |
| `\ignorelinebreaks` | template.tex:754-757, 1467-1474 | no | Catcode change of `^^M`; only avoidable by an emitter never writing blank lines (a content workaround, not a lib way) |
| `\corepatchatleast`, `\let\underline\relax` and `\underline`/`\underbar` redefinition, `\RE` `\IM` saves, `\hmmax` `\bmmax`, `\unaccentedoperators` `\decimalpoint` `\bibname` blanking | template.tex:29-60, 101-102 | yes | Compatibility patches with no printed look; the emitter omits them |
| `\throwerror`, `\throwwarning`, `\throwbadconfig*`, `\checkvardefined`, `\emptyvarerr` | template.tex:919-985 | yes | `\errmessage` validation with no printed output on valid input; omit |
| config switches (`\fontdocument`, `\hfstyle`, `\headertitlecentered`, `\institutioniconsize`, `\institutioniconleft`...) | template.tex:162-731, 1937-2006; template_config.tex:13-98 | yes | Each `\ifthenelse{\equal{..}}` chain is a branch selector over a string set in template_config.tex; the emitter writes only the selected branch |
| `\g@addto@macro` of `\xspace` onto `\name` `\birthday`... | template.tex:1773-1779 | yes | `xspace` appended to user data macros; by inline expansion the emitter writes the name as text (cf. rejected `sp.xspace`) |
| aliases `\acr`, `\sbullet`, `\apo`, `\quotes*`, `\hreftext`, `\insertemail`, `\insertphone`, `\breakvspace`, `\nobreakvspace`, `\signatureentry`, `\otherentry`, `\personaltableentry`, `\institutionentry*` | template.tex:1196-1392 | yes | Expand inline to `sp.manual-space`, `mark.kernel`, `mark.case`, `lang.csquotes`, `meta.hyperref`, `list.paralist`; one `\pagebreak[2]`/`\nopagebreak[4]` wrapper (`pg.break`) in `\breakvspace` |

## Content-opaque
none (the three images `img/foto.png`, `img/firma.png`, `img/icono.jpg` are shipped assets used through `\includegraphics`; `\lipsum` text is filler)

## Lib changes
- New ways proposed: `meta.pdf-params`: pdfTeX primitives `\pdfcompresslevel`, `\pdfobjcompresslevel`, `\pdfminorversion`, `\pdfdecimaldigits`, `\pdfinclusionerrorlevel` as preamble assignments; engine pdf (pdfTeX only; the template guards them with `\compilertype`). W1: pdfTeX primitives documented in the pdfTeX manual (kernel of the engine, as `meta.glyphtounicode` admits `\pdfgentounicode`); W2: integer values only; W3: serves PDF output control of any document, not this CV; W4: printable as preamble lines. Not `meta.glyphtounicode` (ToUnicode map), not `meta.hyperref` (link and info options), not `sp.penalties` (typesetting parameters). Considered and not proposed: `font.newunicodechar` for `commonunicode` (it is a fixed table, filed under `font.fontenc-t1`).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
