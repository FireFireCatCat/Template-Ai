yes

# 0022-lucid-cv: Lucid CV (ATS-friendly resume class, `lucidcv`)

- Unverified: read from the source, not compiled.
- Source: Source/0022-lucid-cv/ (origin: https://mirrors.ctan.org/macros/luatex/latex/lucidcv.zip; licence: mit, lppl1.3c, ofl (LPPL 1.3c for class/sample, OFL for the bundled fonts: LICENSE:1-20, fonts/*/OFL.txt))
- Kind: cv
- Lib: v1
- Engine: needs LuaLaTeX (`\ifLuaTeX\else \ClassError` lucidcv.cls:79-86; `\directlua` callback lucidcv.cls:109-118; `fontspec` .ttf fonts lucidcv.cls:125,228-270; tagging needs LaTeX format 2026-06-01, lucidcv.cls:44; `latexmkrc:4` sets `$pdf_mode = 4`, lualatex)
- Look carried by: class (everything visual is in `lucidcv.cls`; `main.tex` only sets class options and the accent colour, `contents.tex` only calls the class's body macros)
- Class origin: ctan (zip origin is the CTAN mirror `macros/luatex/latex/lucidcv`; one read of https://ctan.org/pkg/lucidcv confirmed: package `lucidcv` 1.0.0, in TeX Live and MiKTeX, licences OFL, LPPL 1.3c, MIT; class date lucidcv.cls:45 is 2026/10/07)
- Main file: main.tex (other samples: contents.tex is the body, loaded by `\input{contents}` at main.tex:115; no other sample)
- Read: main yes (main.tex 122 lines and contents.tex 209 lines, both in full), zip-local classes and styles all (lucidcv.cls 1781 lines, in full; it is the published CTAN class itself, not a zip-local copy)

## Verdict
yes. The look is carried entirely by the published CTAN class `lucidcv`. The sample adds only class options, an accent colour, header fields and the class's own body macros: it defines no macro, environment, counter or package of its own (grep of main.tex and contents.tex finds no `\newcommand`, `\def`, `\newif`, `\usepackage`; the only `\renewcommand` lines are comments, main.tex:38-56) and draws no artwork. An emitter writes `\DocumentMetadata`, `\documentclass[...]{lucidcv}` and the class's own commands. Caveat for whoever re-reads this under a stricter definition: the class source itself is heavy (Lua callback, expl3 property store, glue arithmetic, TikZ chips and photo); see "Bespoke code, shadow list". Under the rubric those are inside a published class, not bespoke code defined in the zip.

## Blockers
none

## Class setting
- Class: `class.lucidcv` options: `10pt,a4paper,hyper,photo,onecolumn` (main.tex:21). Own keys (`\DeclareKeys`, lucidcv.cls:58-67): `hyper`, `photo`, `compressed`, `noicons`, `headingrule`/`noheadingrule`, `onecolumn`/`twocolumn`; every other option is passed to `extarticle` (lucidcv.cls:70, base class `\LoadClass{extarticle}` lucidcv.cls:73, which is a published class too).
- Class-native vocabulary used: `\cvaccent` (main.tex:30), `\cvkeywords` (main.tex:64), `\name`, `\tagline` (main.tex:70-71), `\cvphoto[4cm]{photo.jpg}` (main.tex:79), `\CvInfoField{citizenship}{\faGlobeEurope}` (main.tex:98), `\cvpersonalinfo{...}` with `\email \phone \location \citizenship \homepage \linkedin \github` (main.tex:99-109), `\makecvheader` (main.tex:111), `cvbody` env (main.tex:113-117), `\cvsection`, `\cvsubsection`, `\cventry[oneline|noscale|askip=|bskip=]`, `cvgroup[rule]`, `\cvsubentry[oneline=|flushdate=|bskip]`, `\cvdivider`, `\cvtag`, `\cvtaglist`, `\cvref`, `\cvcolumnbreak`, `justify` env (contents.tex:31-209). Class commands in the zip but not used by the sample: `\lastupdated` (main.tex:120 commented), `\columnratio`, `\geometry` override, size and gap `\renewcommand`s (main.tex:34-56 commented), `\fullname`, `\cvfieldicon`, `\cvtitle` `\cvauthor` `\cvsubject`, `\mailaddress` `\orcid` (commented).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:21; lucidcv.cls:73 | `class.lucidcv` | options 10pt, a4paper, hyper, photo, onecolumn; loads extarticle underneath |
| paper and base size | main.tex:21; lucidcv.cls:70 | `page.class-options` | a4paper, 10pt forwarded to extarticle |
| page geometry | lucidcv.cls:136; override commented main.tex:34 | `page.geometry` | left=1.2cm, right=1.2cm, top=1.2cm, bottom=1.2cm, columnsep=1.1cm (class default, sample keeps it) |
| body columns | main.tex:21; lucidcv.cls:132,141-142,1035,1039-1047,1059-1066; contents.tex:133 | `cols.paracol` | `onecolumn` is the default: `cvbody` opens nothing and `\cvcolumnbreak` is `\par`; `twocolumn` would open `paracol{2}` with column ratio 0.65 (inactive in this sample) |
| header and footer | lucidcv.cls:309 | `hf.pagestyle-kernel` | `\pagestyle{empty}` set at `begindocument/before`; no page numbers |
| fonts: body | lucidcv.cls:225-236 | `font.fontspec` | `\setmainfont{Inter}`, Path to fonts/inter, Extension=.ttf, Upright=Light, Bold=SemiBold, Italic=LightItalic, WordSpace=1.0, `\defaultfontfeatures{Ligatures=TeX}` |
| fonts: sans default | lucidcv.cls:238 | `font.family-default` | `\renewcommand{\sfdefault}{\rmdefault}` |
| fonts: mono | lucidcv.cls:241-248 | `font.fontspec` | `\setmonofont{SourceCodePro}`, Light / Semibold, .ttf (used by `\texttt` at contents.tex:108,117) |
| fonts: name, headings, entry titles | lucidcv.cls:252-270 | `font.fontspec` | `\newfontfamily\lcv@titlefont` (SourceSans3 Semibold/Bold, WordSpace=1.15) and `\lcv@lightfont` (Light/Semibold, WordSpace=1.15) |
| font sizes | lucidcv.cls:819-845,1075-1090,1224-1236,1595-1603 | `font.size-commands` | name 38pt x 1.105, tagline 15pt x 1.2, contact line 0.9 x font, x 1.4; section 16pt x 1.25, subsection 11pt x 1.25; entry scale 1.111; chip 0.9 x font (all `\fontsize{}{}\selectfont`, sample keeps defaults) |
| icons | lucidcv.cls:120; main.tex:98 | `font.icons` | `\RequirePackage[fixed]{fontawesome5}`; sample uses `\faGlobeEurope`; class icons faAt, faPhone, faEnvelope, faMapMarker, faGlobe, faLinkedin, faGithub, faOrcid (lucidcv.cls:658-666) |
| colour | lucidcv.cls:124,161-195; main.tex:30; lucidcv.cls:310 | `color.xcolor` | `xcolor[dvipsnames]`; `\cvaccent{1D76E2}` (HTML model) drives name, heading, rules (accent!30, accent!45), chip fill (accent!6); body 2B2B2B, subheading 333333, meta 6A6A6A |
| PDF metadata and tagging | main.tex:10-11; lucidcv.cls:93-104,800-806 | `meta.documentmetadata` | `\DocumentMetadata{pdfstandard=A-2b,tagging=on,lang=en-US}` and `\tagpdfsetup{math/mathml/luamml/load=false}` (luamml key is LuaLaTeX-only); H1/H2/H3 structure tags set by the class |
| hyperlinks and PDF info | lucidcv.cls:145,155,800-806; main.tex:64; contents.tex:100 | `meta.hyperref` | `\hypersetup{hidelinks}`; pdftitle/pdfauthor/pdfsubject/pdfkeywords filled from `\name`, `\tagline`, `\cvkeywords` at `enddocument`; `\href` in the body; links active only with option `hyper` |
| url style | lucidcv.cls:156 | `meta.url` | `\urlstyle{same}` |
| title block (name, tagline, contact, photo) | main.tex:70-111; lucidcv.cls:947-1028 | `front.class-native` | `\name{Adrian}{Castellanos}` (first name SemiBold, last name Light), `\tagline`, `\cvpersonalinfo` fields with icon and `\|` delimiter, `\cvphoto[4cm]{photo.jpg}` circular photo (diameter 4cm, inset automatic), `\CvInfoField` declares an extra field, `\makecvheader` draws it once |
| abstract / contents / numbering | contents.tex:31-35 | none | no abstract, no table of contents, headings are unnumbered; the "About" paragraph is a `\cvsection` plus `justify` |
| section headings | contents.tex:31,39,97,139,153,173,183,198,206; lucidcv.cls:1131-1165 | `head.class-native` | `\cvsection`: 16pt Source Sans 3 Semibold in accent, 0.4pt rule in accent!30 (class option `noheadingrule` drops it), gap above ratio 1.0, gap below 0.7em, tagged H2 |
| subsection headings | contents.tex:185,189; lucidcv.cls:1177-1183 | `head.class-native` | `\cvsubsection`: 11pt, colour 333333, tagged H3 |
| CV entries | contents.tex:45,63,86,99,107,116,155,175-177,186-187,200-201; lucidcv.cls:1315-1402 | `cv.entries` | `\cventry[keys]{title}{side text}{date}`; keys `oneline`, `noscale`, `askip=0.5em`, `bskip=0pt`; date flushed right on a dotted leader; empty side text drops its `\|` |
| entry groups and sub-entries | contents.tex:64-82,156-168; lucidcv.cls:1474-1565 | `cv.entries` | `cvgroup[rule]` (indent 1.2em, 1.25pt rule in accent!45) and plain `cvgroup`; `\cvsubentry[flushdate=false,bskip]`, `[oneline=false]` |
| divider | contents.tex:105,113; lucidcv.cls:337-345 | `cv.entries` | `\cvdivider`: dashed hairline, 0.6pt, dash 0.35em, colour grey 30%, gap 0.7em both sides |
| skill chips | contents.tex:56,73,81,91,103,111,120,161,167; lucidcv.cls:1620-1680 | `cv.entries` | `\cvtag{...}`, `\cvtaglist{a, b, {c, d}}`; chip border accent!30, fill accent!6, en-dash separator; sample passes only strings |
| references | contents.tex:208-209; lucidcv.cls:1711-1723 | `cv.entries` | `\cvref{name}{email}{address}`; hanging indent 1.9em, icons from `email` and `mailaddress` fields |
| bullet lists | contents.tex:46-51,66-70,87-89,190-193; lucidcv.cls:362-364,386-388 | `list.kernel` | `itemize` with items |
| list spacing | lucidcv.cls:362-364 | `list.enumitem` | `\setlist{leftmargin=1.4em,labelsep=0.5em,itemsep=\cvitemsep(0.15em),topsep=\cvitemtopsep(0.2em),parsep=0pt,partopsep=0pt}`, `\setlist[itemize]{label=\cvitemmarker}` (small bullet) |
| text marks | contents.tex:34,108,141-147,158 | `mark.kernel` | `\textbf`, `\texttt`, `\emph` |
| justified block | contents.tex:33-35; lucidcv.cls:311,402-409 | `sp.ragged` | body `\raggedright` by default; `justify` env (ragged2e `\justifying`, redefined by the class) used for the About paragraph |
| hyphenation off | lucidcv.cls:312-313 | `sp.penalties` | `\hyphenpenalty=10000`, `\exhyphenpenalty=10000` |
| emergency stretch | lucidcv.cls:314 | `sp.lengths` | `\emergencystretch=3em` |
| manual spacing | contents.tex:55,57,72,80,110,119 | `sp.manual-space` | `\vspace{2pt}`, `\smallskip`; `\:` thin spaces in numbers (contents.tex:69; class makes them unbreakable glue, lucidcv.cls:295-300) |
| page break | contents.tex:127 | `pg.break` | `\newpage` before Technical Skills |
| file inclusion | main.tex:115 | none needed | `\input{contents}` is kernel; an emitter writes the body inline |

## Bespoke code
none in the sample. `main.tex` and `contents.tex` define nothing; every macro they call is documented class vocabulary of the published CTAN class.

Shadow list, not counted (inside the published class `lucidcv`, which an emitter calls by name; recorded so the result can be re-read if the class were treated as zip-local, in which case this zip would be `no`):
| Item | Where | Reducible? | Note |
|---|---|---|---|
| Lua `luaotfload.patch_font` callback, `tounicode` of icon glyphs | lucidcv.cls:109-118 | no | BESPOKE/class under a stricter reading |
| Lua font-directory resolver | lucidcv.cls:203-224 | no | BESPOKE/class under a stricter reading |
| expl3 property-list store for contact fields, `\CvInfoField` | lucidcv.cls:555-651 | no | BESPOKE/class under a stricter reading |
| heading gaps from `\prevdepth`, `\settodepth`, `\lastskip` arithmetic | lucidcv.cls:1131-1165,378-384 | no | BESPOKE/class under a stricter reading |
| date on a dotted `\leaders` fill with penalties, discretionary separators | lucidcv.cls:1372-1376,493-500,1240-1242,1639-1643 | no | BESPOKE/class under a stricter reading |
| `cvgroup` rule via `framed` `\MakeFramed` with `\FrameCommand` | lucidcv.cls:1474-1507 | no | BESPOKE/class under a stricter reading |
| TikZ chips (`\cvtag`) and circular photo / placeholder avatar | lucidcv.cls:699-720,1620-1631 | no | ART/class under a stricter reading (template identity) |
| zero-width U+00A0 glyph hacks in the header | lucidcv.cls:888-894,999-1002 | no | BESPOKE/class under a stricter reading |
| `\lastupdated` stamp via `.aux` write and `shipout/lastpage` hook (not used by the sample) | lucidcv.cls:1741-1779 | no | BESPOKE/class under a stricter reading |
Published packages the class loads and the sample never names: `iftex`, `fontawesome5[fixed]`, `etoolbox`, `keyval`, `xcolor[dvipsnames]`, `fontspec`, `tikz` (library `fill.image`), `enumitem`, `graphicx`, `dashrule`, `paracol`, `ragged2e`, `framed`, `geometry`, `hyperref`, `accsupp` (lucidcv.cls:79,120-146). None needs a tool outside TeX, so no `EXTERNAL/package`.

## Content-opaque
- Header photo `photo.jpg` (image asset passed to `\cvphoto`, main.tex:79); shipped in the zip.
- Fonts `fonts/inter`, `fonts/sourcesans3`, `fonts/sourcecodepro` (.ttf, OFL) are shipped assets; the class finds them beside `lucidcv.cls` or through kpathsea (lucidcv.cls:203-224). Note: assets, not content.
- Everything else (resume text, dates, tag strings, contact values) is content.

## Lib changes
- New ways proposed: none. Considered `sp.rule` (`dashrule`, CTAN) and `meta.accsupp` (`accsupp`, CTAN), but both are used only inside the published class, which the emitter calls by name, so no way is needed for this zip.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this).
- Class-native vocabulary for the lib's class section (`class.lucidcv`, xe/lua: LuaLaTeX): front matter `\name{first}{last}`, `\fullname`, `\tagline`, `\cvphoto[diam][inset]{file}`, `\cvpersonalinfo{...}`, `\CvInfoField[*][scheme][shown]{name}{icon}`, `\cvfieldicon`, `\makecvheader`; meta `\cvaccent[model]{value}`, `\cvkeywords`, `\cvtitle` `\cvauthor` `\cvsubject`; body `cvbody`, `\cvsection`, `\cvsubsection`, `\cventry[oneline,flushdate,askip,bskip,noscale]`, `cvgroup[rule]`, `\cvsubentry`, `\cvdivider`, `\cvtag`, `\cvtaglist`, `\cvref`, `\cvcolumnbreak`, `justify`, `\lastupdated`; options `hyper photo compressed noicons noheadingrule onecolumn twocolumn`; `\columnratio`, `\cvnamesize` family of size and gap macros.
