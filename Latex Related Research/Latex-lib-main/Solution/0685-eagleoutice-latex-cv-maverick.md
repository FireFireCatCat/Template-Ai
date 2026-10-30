no

# 0685-eagleoutice-latex-cv-maverick: Application Maverick (banner-sidebar application letter / CV)

- Unverified: read from the source, not compiled.
- Source: Source/0685-eagleoutice-latex-cv-maverick/ (origin: https://codeload.github.com/EagleoutIce/latex-cv-maverick/zip/refs/heads/master; licence: GPL-3.0 per the manifest)
- Kind: cv
- Lib: v5
- Engine: pdfLaTeX-compatible (T1 + utf8 inputenc, tikz, attachfile2, fontawesome v4, overlock; nothing in the class needs fontspec or Lua)
- Look carried by: zip-local (the whole look is in application-maverick.cls; the sample's preamble only sets one colour and the data fields through the class's own commands)
- Class origin: zip-local (application-maverick is a GitHub-only class: ctan.org/pkg/application-maverick returns 404; the zip is the author's repository, not a publisher kit)
- Main file: example.tex (other samples: none)
- Read: main yes, zip-local classes and styles all (application-maverick.cls read in full, 707 lines)

## Verdict
No. The class carries the whole look and it is built on TikZ artwork that is the template's identity: a page-height banner on the left of every page with a four-corner shading, a photo clipped to a hexagon, hand-drawn progress bars and a hand-drawn pie chart. None of these reduces to a declarative lib way. The sidebar is also driven by zip-local registers, a `key: value` parser, a name-to-macro dispatch table and counters that decide how many contact and skill lines print, which is irreducible bespoke code under the rubric. The small wrapper pieces (blocks, timeline events, bullet lists, signature, attachment links, date) do reduce to lib ways and are mapped below.

## Blockers
- `ART/class` shaded or flat colour banner drawn on every page as a TikZ overlay at `current page.north west`, width 8cm, four-corner `lower left`/`upper right` shading in the default `normal` layout (application-maverick.cls:123-142, started per page at :149; the `simple` variant at :123-126 is one flat rectangle but the default is shaded, :48 and :54)
- `ART/class` title photo clipped to a hexagon, circle or square with a TikZ `path picture` and `\includegraphics` (application-maverick.cls:169-188, :198-205; selected by `image style: hexagon`, example.tex:15)
- `ART/class` progress bars drawn with TikZ clip, fill and `rounded corners` (application-maverick.cls:211-236; used at example.tex:80-84)
- `ART/class` pie chart `\Cake` with `\foreach` slices, arcs and `decorations.text` text along path (application-maverick.cls:627-664; used at example.tex:40 and :44)
- `BESPOKE/class` sidebar engine: a buffer of element names built with `\protected@xdef`, dispatched by `\foreach` and `\@nameuse{apma@sidebar@element@...}` inside a `\parbox[t][\textheight]` in a TikZ node, with per-block counter `apma@counter@bannermax` that caps how many contact, skill and social lines print (application-maverick.cls:242-264, :369-387, :310-361, :494-539)
- `BESPOKE/class` data registers and parser: `\setAll` splits `key: value` lines, `\getData` and `\setData` check names, `\addSkill` appends to a comma list kept in a macro (application-maverick.cls:410-467, :472-491)
- `BESPOKE/class` name-to-icon table and element extension commands that add entries to the dispatch table at run time (`\foreach` icon table application-maverick.cls:390-404; `\CreateElement`, `\CreateBlockElement` :676-685; used at example.tex:23-44)

## Class setting
- Class: `class.article` (zip-local `application-maverick` calls `\LoadClass{article}` at application-maverick.cls:62; a zip-local class is not a published class, so it gets no `class.*` way of its own). Options of the zip-local class: `draft`/`final`, `nopar`/`dopar`, `normal`/`simple`, `german`/`english`, defaults `final,nopar,normal,german` (application-maverick.cls:42-55). The sample passes none (example.tex:1).
- Class-native vocabulary used (all zip-local): `\setAll{key: value,...}` (example.tex:6-21), `\setColorProfile` (example.tex:58), `ap-page` and `ap-page*` (example.tex:60, :118), `\setSideBarElements{...}` (example.tex:61, :113, :123), `\CreateBlockElement` (example.tex:23, :31, :42), `\MakeCake` and `\PlaceCake` (example.tex:40, :44), `\addSkill` (example.tex:46-47), `block[icon]{title}` (example.tex:63), `timeline` and `event{title}{dates}{place}` (example.tex:64-65), `bulletpoints[cols]` (example.tex:79), `\progressbar` (example.tex:80), `text` (example.tex:105), `\sign[name]` (example.tex:109), `\AttachFile[label]{file}` (example.tex:115), `sbitemize` (example.tex:24).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | example.tex:1; application-maverick.cls:62 | `class.article` | no options; under the zip-local wrapper class |
| page geometry | application-maverick.cls:84-85 | `page.geometry` | left = banner width 8cm + .5cm (computed with `\pgfmathsetmacro`, a constant 8.5cm), top=.5cm, right=.5cm, bottom=.25cm, a4paper |
| page geometry, full-width page | application-maverick.cls:164-165; example.tex:118 | `page.geometry` | `\newgeometry{left=1cm,right=1cm,top=1cm,bottom=1cm}` then `\restoregeometry` (`ap-page*`) |
| page background colour | application-maverick.cls:137, :161 | `color.pagecolor` | `\pagecolor{apma@color@page}` per page |
| colour profile | application-maverick.cls:68, :108-116; example.tex:5, :58 | `color.xcolor` | option `x11names`; `\colorlet` chain primary, secondary = primary!42!black, page = primary!7!white, flavour = page; default LavenderBlush4; `\definecolor{CustomBlue}{HTML}{335d7e}` |
| banner on every page | application-maverick.cls:123-142, :145-155 | `bg.tikzpagenodes`, `art.tikz` | ART: `\fill[lower left=primary!2!secondary, lower right=same, upper left=primary!50!secondary, upper right=primary]` rectangle from `current page.north west`, `xshift` 8cm, `remember picture,overlay`; libraries `calc`, `shadings` (:70-71) |
| title photo shape | application-maverick.cls:169-205; example.tex:14-15, :61 | `art.tikz` | ART: hexagon path with `path picture`, width 6cm (:32), padding top .75cm (:31) |
| progress bars | application-maverick.cls:211-236, :243, :608; example.tex:80-84 | `art.tikz` | ART: width 5.5em or 6.5em, height .65em, `rounded corners=.25em/2`, border and fill colours from the profile |
| pie chart | application-maverick.cls:627-664; example.tex:40, :44 | `art.tikz` | ART: `\Cake[6cm]{40/Super Hot,...}`, `scale=1.85`, slice colours from the page colour, `decorations.text` (:101) |
| encoding | application-maverick.cls:74-75 | `font.fontenc-t1` | `fontenc[T1]`, `inputenc[utf8]` |
| language | application-maverick.cls:78-80 | `lang.babel` | `main=ngerman` (default) or `main=english` through `\PassOptionsToPackage` |
| base text font | application-maverick.cls:91 | `font.lmodern` | load only |
| default sans face | application-maverick.cls:105 | `font.helvet` | package `overlock`, option `sfdefault` (the package source was not read) |
| signature script face | application-maverick.cls:91, :575 | `font.display` | package `calligra`, `\huge\calligra{}` |
| icons | application-maverick.cls:92, :302, :314, :333, :390-404; example.tex:23, :63, :78 | `font.icons` | package `fontawesome` (v4): `\faUser`, `\faDiamond`, `\faGraduationCap`, `\faTasks`, `\faSuitcase`, `\faThumbsOUp`, ... |
| font sizes | application-maverick.cls:297, :466, :551, :593 | `font.size-commands` | `\Huge` name font, `\large` text font (:466), `\Large` block titles, `\footnotesize` for event place (:551) |
| microtype | application-maverick.cls:91 | `sp.microtype` | load only |
| widow and club penalties | application-maverick.cls:97 | `sp.penalties` | `nowidow[all]` |
| justification | application-maverick.cls:92, :304 | `sp.ragged` | `ragged2e`, `\justify` in the brief block |
| paragraph indent | application-maverick.cls:64-65 | `sp.lengths` | `\parindent=\z@` by default (`nopar`), restored with `dopar` |
| rules and leaders | application-maverick.cls:293, :583 | `sp.rule` | `\leaders\hbox{\rule[raise]{.01pt}{thickness}}\hfill` after block titles; `\rule{5cm}{1pt}` signature line |
| manual spacing | application-maverick.cls:270, :578-586, :596 | `sp.manual-space` | `\vskip`, `\hskip`, `\vfill`, `\smallskip`, `\medskip` |
| multicolumn bullets | application-maverick.cls:562, :566; example.tex:79 | `cols.multicol` | `multicols{n}` inside `bulletpoints[n]` |
| list formats | application-maverick.cls:541-544, :563 | `list.enumitem` | `label={...}`, `leftmargin=*`, `topsep=4pt`, `itemsep=2pt`, `labelsep=.75em` |
| bare lists | application-maverick.cls:620-622 | `list.kernel` | `itemize` holding the timeline events |
| graphics and scaling | application-maverick.cls:92, :171, :298, :576 | `fig.graphicx` | `\includegraphics[width=...]`, `\resizebox{1.25em}{!}` |
| maths | application-maverick.cls:88 | `math.amsmath` | load only (sample has no maths; `\(\;\)` spacer at :298, :596) |
| PDF links | application-maverick.cls:94, :98, :541 | `meta.hyperref` | `hidelinks`; `\hypersetup{urlcolor=...}` inside sidebar lists |
| URL style | application-maverick.cls:99 | `meta.url` | `\urlstyle{same}` |
| file attachments | application-maverick.cls:95, :691-703; example.tex:115 | `meta.attachfile` | `attachfilesetup{author=first and last name, color=primary!90!white, icon=Tag, mimetype=text/plain}`; `\textattachfile{file}{label}` through `\AttachFile` |
| page numbers off | application-maverick.cls:689 | `pgnum.pagenumbering` | `\pagenumbering{gobble}` |
| minipage footnote marker | application-maverick.cls:706 | `num.counters` | `\renewcommand\thempfootnote{$\langle$\textbf{\arabic{mpfootnote}}$\rangle$}` |
| section-like blocks | application-maverick.cls:593-614; example.tex:63, :78, :88, :104 | `box.minipage`, `mark.case`, `font.icons`, `font.size-commands`, `sp.rule`, `color.xcolor` | `block[icon]{title}`: `\Large`, primary!75!black, icon in a `\parbox{1.5em}`, `\MakeUppercase` title, raised rule leader 1.25pt, body in a `minipage` of `\linewidth`, `\medskip` after |
| timeline entries | application-maverick.cls:551-554, :616-623; example.tex:64-73 | `list.kernel`, `box.minipage`, `mark.kernel` | `\item[bullet]` coloured primary!75!black, `\textbf` title, `/` and place in `\footnotesize`, dates `\hfill`, body in a `\parbox` of `\linewidth - .25cm` |
| bullet lists with columns | application-maverick.cls:558-568; example.tex:79-86 | `list.enumitem`, `cols.multicol`, `box.minipage` | per depth label (`\ifnum\@listdepth=\@ne`, bullet size) = enumitem per-level labels |
| body text block | application-maverick.cls:569-572; example.tex:105-107 | `box.minipage` | `\hskip.3cm` and `\parbox` of `\linewidth - \apma@length@rightpad - .3cm` |
| signature | application-maverick.cls:574-587; example.tex:109 | `sp.manual-space`, `sp.ragged`, `box.minipage`, `font.display`, `sp.rule` | `\vfill`, `\signtext` = "Mit freundlichen Grüßen:", `flushright` `\parbox[t]{6cm}`, rule 5cm, name and date |
| date text | application-maverick.cls:669-674 | `lang.babel` | `\heute` is `\today` in the two languages (`\ifcase\month`) |
| filler text | example.tex:3, :106, :119 | `draft.todo` | package `blindtext`: `\blindtext`, `\blinddocument` (filler content) |
| multi-page flow | application-maverick.cls:145-165; example.tex:60, :112, :118, :122 | `pg.break` | `\clearpage` at the start of each `ap-page` and `ap-page*` |
| sidebar content system | application-maverick.cls:242-264, :269-361, :369-467 | none | BESPOKE, see blockers (no lib way) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| Sidebar buffer, dispatch and node placement (`\setSideBarElements`, `\apma@sidebar@init`) | application-maverick.cls:242-264, :369-387 | no | `\foreach` over a name list, `\@nameuse` dispatch, TikZ node with `\parbox[t][\textheight]` run at the end of each page environment: output-driving control code. |
| Capped element lists (`bannermax`, `elemc` counters, `\@apma@SetNElementsFromCmdListIfTheyExist`, `\@applications@SetNElementsFromList`) | application-maverick.cls:310-361, :494-539 | no | Hand-rolled counters and conditionals decide how many lines print. |
| Data registers, `key: value` parser, checkers, skill accumulator | application-maverick.cls:410-467, :472-491 | no | Parser and `\protected@xdef` list build feed the printed text. |
| Icon table by `\foreach` and `\csname` | application-maverick.cls:390-404 | no | Defines `\@apma@l<name>` item macros from pairs; part of the sidebar engine. |
| `\CreateElement`, `\CreateBlockElement`, `\ChangeSymbol` | application-maverick.cls:676-687 | no | Extend the run-time dispatch table. |
| Banner, image shape, progress bar, pie chart drawers | application-maverick.cls:123-142, :169-205, :211-236, :627-664 | no | TikZ artwork (see `ART` blockers). |
| `\apma@raisedrule`, `\apma@util@block` | application-maverick.cls:293, :297-299 | yes | `sp.rule` leader plus `font.icons`, `mark.case`, `font.size-commands`, `box.minipage`. |
| `block`, `timeline`, `event`, `bulletpoints`, `text`, `apma@sidebar@itemize` (made with `environ` `\NewEnviron`, which captures `\BODY`; considered: environ, a macro-definition helper, not a component) | application-maverick.cls:541-572, :599-623 | yes | Wrapper nodes mapped in the table above; `\pgfmathsetmacro` widths are constants given the geometry. |
| `\sign`, `\signimg`, `\@@sign` | application-maverick.cls:574-587 | yes | `sp.manual-space`, `sp.ragged`, `box.minipage`, `font.display`, `sp.rule`. |
| `\heute` month tables | application-maverick.cls:669-674 | yes | `lang.babel` `\today` for `ngerman` or `english`. |
| `\AttachFile`, `\attachfilesetup`, `\setLinkShade`, `\mail` | application-maverick.cls:691-705, :667 | yes | `meta.attachfile` parameters; colour `primary!90!white` from `\@linkshade` and `\@linkmix` (:695-696); `\mail` is `\href{mailto:..}`. |
| Class options and `\newif` switches (`draft`, `simple`, `english`, `dopar`) | application-maverick.cls:17-20, :42-58 | partly | `english` maps to `lang.babel`, `dopar` to `sp.lengths`, `simple` selects between the flat and shaded banner, which is `ART`. |
| `\setColorProfile` | application-maverick.cls:108-116 | yes | `color.xcolor` `\colorlet` chain. |
| `\MakeCake`, `\PlaceCake` | application-maverick.cls:656-664 | no | `\AtBeginDocument`, `\csname` save boxes around the TikZ chart (see `ART`). |

## Content-opaque
- Photo `Images/me.jpg` (example.tex:14) is an included image; the hexagon clip is the `ART` blocker above, the picture itself is content.
- `\blindtext` and `\blinddocument` filler text (example.tex:106, :119); German sample text in the events and blocks (example.tex:65-100) is content.
- Skill labels and percentages (example.tex:46-47, :80-84), the pie data (example.tex:40) and the contact and social values (example.tex:6-21) are data.
- `Images/showcase-title.jpg` is only the README screenshot (README.md:9).
- `.github/workflows/compile.yaml:24` builds with the third-party `sltx` tool in CI; the class itself needs only pdfLaTeX, so this is not an `EXTERNAL` blocker.

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
