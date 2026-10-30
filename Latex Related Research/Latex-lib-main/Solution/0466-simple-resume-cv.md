yes

# 0466-simple-resume-cv: Simple Resume/CV

- Unverified: read from the source, not compiled.
- Source: Source/0466-simple-resume-cv/ (origin: https://latextemplates.com/downloads/simple-resume-cv.zip; licence: Public-Domain, Unlicense per main.tex:1 and simpleresumecv.cls:9-10)
- Kind: cv
- Lib: v4
- Engine: needs XeLaTeX (`fontspec`, `xunicode`, `xltxtra` loaded unconditionally: simpleresumecv.cls:133-136; stated at main.tex:3-4)
- Look carried by: class (the whole look is the CTAN class `simpleresumecv`; main.tex adds option settings, string aliases and `\hypersetup`)
- Class origin: ctan
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles all

## Verdict
The look is carried by `simpleresumecv`, a published class: https://ctan.org/pkg/simple-resume-cv (Zach Scrivena, Public Domain, in TeX Live and MiKTeX, version 2016-12-25, the same date as `\ProvidesClass` at simpleresumecv.cls:15), so W1 holds. The sample adds only class options (main.tex:9), four string `\newcommand`s (main.tex:11-14), a `\hypersetup` (main.tex:16-28) and calls to the class's own vocabulary, so no bespoke construct needs to be emitted and there is no `ART`, `EXTERNAL` or `UNMAPPED` item. Two caveats. (1) The zip's `.cls` is a latextemplates.com copy that replaces the upstream Tinos/FreeFont fonts with DejaVu (simpleresumecv.cls:138-163); that is a `fontspec` parameter change, but the copy was not diffed against the CTAN release. (2) If a reviewer treats the copy as zip-local, the `\parshape`/`\savebox` indent macros (simpleresumecv.cls:281-362) are irreducible and the verdict flips to `no` (see Bespoke code).

## Blockers
none

## Class setting
- Class: `class.simpleresumecv` options: `letterpaper`, `MMMyyyy`, `nonstopmode` (main.tex:9). Declared options (simpleresumecv.cls:17-67): `a4paper`, `letterpaper` (passed to article), `nonstopmode`, `draftmode` (red DRAFT stamp in the footer), date formats `MMMyyyy` (default), `ddMMMyyyy`, `MMMMyyyy`, `ddMMMMyyyy`, `yyyyMMdd`, `yyyyMM`, `yyyy`. Base class: article, 10pt, oneside (simpleresumecv.cls:72).
- Class-native vocabulary used by the sample: `\Title{name}` (main.tex:32), `SubTitle` environment (main.tex:34-42), `\SubBulletSymbol` (main.tex:37, 39), `Body` environment (main.tex:44-128), `\Section{heading}{bookmark title}{bookmark label}` (main.tex:46-49), `\Entry` (main.tex:51), `\Gap` (main.tex:56), `\BulletItem` (main.tex:57), `\SubBulletItem` (main.tex:63), `Detail` environment (main.tex:62-65), `\DatestampYMD{y}{m}{d}` (main.tex:60), `\Timestamp` (main.tex:93).
- Class vocabulary declared but not used by the sample: `\DatestampYM`, `\DatestampY`, `\BigGap`, `\SubSection`, `\Item`, `\SubItem`, `\NumberedItem`, `\Hide`, `\BulletSymbol`, `\TildeSymbol`, `\UseSecondaryFont`, `\PageKOfN`, `\DraftStamp` (simpleresumecv.cls:28-30, 151, 176-178, 182-183, 258-261, 270-273, 318-365).

## Component map
Rows marked "(in class)" are realised inside the published class; an emitter writes the class call, and the way names record how the class composes it. Rows marked "(sample)" are in main.tex.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:9; simpleresumecv.cls:15 | `class.simpleresumecv` | options letterpaper, MMMyyyy, nonstopmode |
| base class (in class) | simpleresumecv.cls:72 | `class.article` | 10pt, oneside |
| paper and size (in class) | main.tex:9; simpleresumecv.cls:18, 72 | `page.class-options` | letterpaper, 10pt, oneside |
| page geometry (in class) | simpleresumecv.cls:75-81 | `page.geometry` | left=0.70in, right=0.70in, top=0.60in, bottom=0.45in, nohead, includefoot |
| header/footer: blank header, centred "Page K of N" (in class) | simpleresumecv.cls:182, 186-187, 195-201 | `hf.class-native` | footer `\hfill\PageKOfN\hfill`, header empty, font 8.2pt/9.5pt (`\UseHeaderFooterFont`, simpleresumecv.cls:167) |
| page style (in class) | simpleresumecv.cls:195-201 | `hf.pagestyle-kernel` | `\def\ps@plain` sets `\@oddhead` `\@evenhead` `\@oddfoot` `\@evenfoot`; `\pagestyle{plain}` |
| last-page label for "of N" (in class) | simpleresumecv.cls:181-182 | `xref.kernel` | `\AtEndDocument{\null\label{LastPage}}`, `\pageref{LastPage}` (same effect as `pgnum.lastpage`, done with kernel commands) |
| draft stamp (option, not used by sample) (in class) | simpleresumecv.cls:24-25, 183-192 | `hf.class-native` | `draftmode` adds red `DRAFT <timestamp>` to the footer |
| current date and time (sample, in class) | main.tex:93; simpleresumecv.cls:95, 98 | `front.datetime` | `datetime2` `\DTMnow` printed by `\Timestamp` |
| main text face (in class) | simpleresumecv.cls:133-136, 147-149 | `font.fontspec` | `\defaultfontfeatures{Ligatures=TeX}`; `\setmainfont[BoldFont=DejaVu Serif Bold]{DejaVu Serif}`; upstream Tinos replaced (simpleresumecv.cls:138-146) |
| secondary face (not used by sample) (in class) | simpleresumecv.cls:151-153 | `font.fontspec` | `\UseSecondaryFont` = `\fontspec[BoldFont=DejaVu Sans Bold]{DejaVu Sans}` |
| sans, mono, small-caps collapse to roman (in class) | simpleresumecv.cls:156-162 | `font.family-default` | `\sffamily` `\ttfamily` `\scshape` redefined as `\rmfamily` (an alias set, closest published type) |
| font sizes per element (in class) | simpleresumecv.cls:166-173 | `font.size-commands` | title 28pt/33.6pt bold; sub-title 8.6pt/10.3pt; section 9pt/11pt bold; detail 8.6pt/10.3pt; note 8pt/9.6pt |
| colour (in class) | simpleresumecv.cls:90, 183 | `color.color` | `\RequirePackage[usenames]{color}`; `\color{red}` only in the draft stamp |
| hyphenation off (in class) | simpleresumecv.cls:87, 213 | `sp.hyphenat` | `hyphenat` option `none`; `\sloppy` |
| paragraph lengths (in class) | simpleresumecv.cls:204-205 | `sp.lengths` | `\parindent`=0in, `\parskip`=0in |
| widow and club control (in class) | simpleresumecv.cls:208-209 | `sp.penalties` | `\widowpenalties 1 10000`, `\clubpenalties 1 10000` |
| ragged bottom (in class) | simpleresumecv.cls:210 | `pg.flush` | `\raggedbottom` |
| footnote marks (in class; no footnote in sample) | simpleresumecv.cls:216 | `num.counters` | `\renewcommand{\thefootnote}{\fnsymbol{footnote}}` |
| PDF metadata and link style (sample) | main.tex:16-28; simpleresumecv.cls:84 | `meta.hyperref` | pdftitle, pdfauthor, pdfsubject, pdfcreator=XeLaTeX, unicode=true, bookmarks=true, bookmarksopen=true, pdfstartview=FitH, pdfpagelayout=OneColumn, pdfpagemode=UseOutlines, hidelinks, breaklinks |
| PDF bookmarks per title and section (in class) | simpleresumecv.cls:220, 265, 271 | `meta.hyperref` | `\pdfbookmark[1]` for the name, `[2]` for sections, `[3]` for sub-sections |
| language | none set in main.tex or the class | none | default English; no `babel` or `polyglossia` |
| title block: name | main.tex:32; simpleresumecv.cls:219-223 | `front.class-native` | `\Title{...}`: centred, 28pt/33.6pt bold |
| title block: contact line | main.tex:34-42; simpleresumecv.cls:226-230 | `front.class-native` | `SubTitle` env: `\vspace{0.25\baselineskip}`, centred, 8.6pt/10.3pt |
| e-mail and web links (sample) | main.tex:35-36, 40-41 | `meta.hyperref`, `meta.url` | `\href{mailto:...}{...}`, `\href{\CVWebpage}{\url{\CVWebpage}}` |
| contact separator glyph | main.tex:37, 39; simpleresumecv.cls:177 | `cv.entries` | `\SubBulletSymbol`: U+25CF at 6pt/7.2pt, raised 0.17em |
| body column: list with 1.2in label column (in class) | main.tex:44, 128; simpleresumecv.cls:233-255 | `list.kernel` | `Body` = generic `list`: leftmargin=1.2in, labelwidth=1.2in, labelsep=0, itemsep=0.90`\baselineskip`, topsep/parsep/partopsep/parskip/rightmargin/itemindent/listparindent=0 |
| list lengths (in class) | simpleresumecv.cls:238-248 | `sp.lengths` | the values in the row above, set with `\setlength` |
| section heading in the left label column | main.tex:46-49, 78-81, 112-115; simpleresumecv.cls:264-267 | `head.class-native` | `\Section{text}{bookmark title}{label}`: `\item[\smash{\parbox[t]{1.2in}{9pt bold \raggedright \MakeUppercase{text}}}]`; unnumbered |
| heading box and case (in class) | simpleresumecv.cls:266, 272 | `box.minipage`, `sp.ragged`, `mark.case` | `\parbox[t]{1.2in}`, `\raggedright`, `\MakeUppercase` |
| sub-section heading (not used by sample) (in class) | simpleresumecv.cls:270-273 | `head.class-native` | `\SubSection`: 8.6pt bold, upper case |
| CV entry line (employer or school) | main.tex:51-54, 83-86; simpleresumecv.cls:311-316 | `cv.entries` | `\Entry`: `\parshape 1 \labelwidth \linewidth` |
| bulleted CV item with right-aligned dates | main.tex:57-61, 68-72, 89-93, 102-106; simpleresumecv.cls:281-293 | `cv.entries` | `\BulletItem`: square bullet (U+25A0, 6.5pt) then hanging indent measured from the bullet box; `\hfill` then `\DatestampYMD` |
| sub-bullet item | main.tex:63, 74, 95, 97, 108; simpleresumecv.cls:299-308 | `cv.entries` | `\SubBulletItem`: round bullet (U+25CF, 6pt), indent 5.6mm + 1.5mm |
| detail text under an item | main.tex:62-65, 73-76, 94-99, 107-110; simpleresumecv.cls:276-278 | `cv.entries` | `Detail` env: group with `\UseDetailFont` (8.6pt/10.3pt) |
| date stamps | main.tex:60-61, 71-72, 92, 105-106; simpleresumecv.cls:28, 31 | `cv.entries` | `\DatestampYMD{y}{m}{d}` prints "Mon yyyy" under the `MMMyyyy` option |
| gap between items | main.tex:56, 67, 88, 101, 122; simpleresumecv.cls:258 | `sp.manual-space` | `\Gap` = `\par\vspace{0.45mm}\par` |
| right-aligned field in an entry | main.tex:59, 70, 91, 104, 119, 125 | `sp.manual-space` | `\hfill` |
| skills rows (label, `\hfill`, list) | main.tex:117-126 | `cv.entries` | `\Entry` then text, `\hfill`, text |
| bold organisation names (sample) | main.tex:53, 85 | `mark.kernel` | `\textbf{...}` |
| string aliases (sample) | main.tex:11-14 | none (reducible aliases) | `\CVAuthor`, `\CVTitle`, `\CVNote` (defined, never used), `\CVWebpage` expand inline; see Bespoke code |
| headings numbering, abstract, contents, theorems, floats, tables, captions, code, boxes, bibliography, index, maths | not present in main.tex or the class | none | no component defined or used |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| zip copy of the CTAN class `simpleresumecv` | simpleresumecv.cls:15 | not bespoke (published, W1 via ctan.org/pkg/simple-resume-cv) | the emitter writes `\documentclass[letterpaper,MMMyyyy,nonstopmode]{simpleresumecv}` and class calls; not diffed against the CTAN source |
| font substitution (latextemplates.com change: DejaVu in place of Tinos and FreeFont) | simpleresumecv.cls:138-153 | yes | `font.fontspec` parameters (`\setmainfont` with `BoldFont`); fonts are system-installed, no italic face (simpleresumecv.cls:141-144), so `\textit` is a fake slant; the upstream Tinos files (main.tex:4-8) are not in the zip (missing asset, ship it) |
| sample string macros `\CVAuthor` `\CVTitle` `\CVNote` `\CVWebpage` | main.tex:11-14 | yes | inline expansion of the strings; they hold no logic (`\CVNote` is unused) |
| `\BulletItem` `\SubBulletItem` `\Item` `\SubItem` `\NumberedItem` (measured indent) | simpleresumecv.cls:281-362 | not counted (inside the published class; the emitter emits the call only) | contingent: if the class were judged zip-local, `\savebox` + `\settowidth` + `\parshape 2` + `\dimexpr` is a hand-rolled box-measurement layout, not an `sp.lengths` hanging indent, so it would be BESPOKE/class and irreducible (the verdict would be `no`) |
| `\ps@plain` redefinition, `\pageref{LastPage}` footer | simpleresumecv.cls:181-201 | not counted (published class); reducible if it were counted | `hf.pagestyle-kernel` + `xref.kernel` (or `hf.fancyhdr` + `pgnum.lastpage`) |
| `\Section`, `Body`, `\Entry`, `Detail`, `\Gap` | simpleresumecv.cls:233-278, 311-316 | not counted (published class); reducible if it were counted | kernel `list` with `\setlength`, `\parbox`, `\MakeUppercase`, `\vspace` as in the component map |
| month-name tables with `\ifcase`, date-format options | simpleresumecv.cls:28-67, 101-130 | not counted (published class); reducible if it were counted | a date is content: the emitter prints the final "Aug 2016" text |
| `\DeclareOption{nonstopmode}{\nonstopmode}` | simpleresumecv.cls:21 | not counted (class option) | an error-mode switch with no printed effect |

## Content-opaque
none

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
- Considered, not proposed: `class.simpleresumecv` is a class way and is written plainly (its vocabulary is recorded under "Class setting"); `xunicode` and `xltxtra` (cls:135-136) are load-only XeLaTeX support packages with no printed effect in the sample (not a component, as `sys.compat-load` was rejected in v4).
