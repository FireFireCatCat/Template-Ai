yes

# 0196-moderncv: moderncv (CV and cover-letter class), `template.tex` with the `contemporary` style

- Unverified: read from the source, not compiled.
- Source: Source/0196-moderncv/ (origin: https://mirrors.ctan.org/macros/latex/contrib/moderncv.zip; licence: lppl1.3c, LPPL 1.3c per README.md and every file header)
- Kind: cv (the same sample also holds a cover letter)
- Lib: v3
- Engine: pdfLaTeX-compatible (the sample branches on `\ifxetexorluatex`: pdfTeX path inputenc, fontenc, lmodern, template.tex:46-50; XeLaTeX/LuaLaTeX path fontspec, unicode-math, template.tex:32-45; the class picks `fontawesome6` icons under pdfTeX, moderncviconssymbols.sty:19-23)
- Look carried by: class (the zip is the official CTAN release of the `moderncv` class itself; the sample adds only option settings, personal data and content)
- Class origin: ctan
- Main file: template.tex (other samples: manual/moderncv_userguide.tex, the class's own manual under `article`, not analysed as a template)
- Read: main yes, zip-local classes and styles partly (read in full: moderncv.cls, moderncvstylecontemporary.sty, moderncvheadvii.sty, moderncvbodyvi.sty, moderncvcolors.sty, moderncvcolorcerulean.sty, moderncviconssymbols.sty, moderncviconsawesome.sty, moderncviconstikz.sty, moderncvverticaltimeline.sty, moderncvcollection.sty, moderncvcompatibility.sty, tweaklist.sty; moderncvskillmatrix.sty lines 1-340, 400-730, 900-1057 only, the unread 340-400 and 730-900 are the body-style variants i/ii/iii/iv/v branches the contemporary style does not select; not read: the other five styles, heads i-vi, bodies i-v, moderncvfooti.sty beyond line 60, the other colour files, academicons and marvosym icon files, moderncviconsletters.sty, moderncvdebugtools.sty beyond a skim, none of which the sample loads)

## Verdict
`yes`. The look is carried entirely by one published class, `moderncv` (CTAN, official release; README.md:46-52), driven by its own options and commands: `\moderncvcolor{cerulean}`, `\moderncvstyle[]{contemporary}`, `\cventry` and friends. The sample defines no macro, no environment and no drawing of its own, so there is no bespoke code and no `ART` in the sample or in a zip-local file. The class's own internals (a TikZ head band and circular photo, a TikZ vertical timeline, TikZ skill-rating glyphs, a locally shipped `tweaklist.sty`) are published code reached through the class way, not zip-local code; the pilot ruling "look carried entirely by a published class reaches yes easily" is applied, and this is evidence about the class dimension, not about the component ways. If the project ever counts a published class's own TikZ identity as `ART/class`, this zip flips to `no` on moderncvheadvii.sty:116-123,148-160, moderncvverticaltimeline.sty:41-56 and moderncvskillmatrix.sty:243-249; that reading is not the rubric as written.

## Blockers
none

## Class setting
- Class: `class.moderncv` options: `11pt`, `a4paper`, `sans` (template.tex:9). The class's own option set is paper sizes `a4paper` `a5paper` `b5paper` `letterpaper` `legalpaper` `executivepaper` `landscape`, sizes `10pt` `11pt` `12pt`, family `sans` `roman`, `draft` `final` (moderncv.cls:24-62). It does not load `article`; it reads `size11.clo` and defines `\section`, `\title`, `\date`, lists and the bibliography itself (moderncv.cls:66, 225, 560, 811, 761). Version in the zip: v2.6.1 (moderncv.cls:13).
- Class-native vocabulary used: `\moderncvcolor` `\moderncvstyle[options]{style}` (the `contemporary` style takes `left|right`, `qr|noqr`, `details|nodetails`, `separator|noseparator`: moderncvstylecontemporary.sty:18-31); personal data `\name` `\title` `\born` `\address` `\phone[mobile|fixed|fax]` `\email` `\homepage` `\social[kind]` `\extrainfo` `\photo[height][frame]` `\quote` (template.tex:56-116); `\makecvtitle`; `\section[icon]` `\subsection`; entries `\cventry` `\cvitem` `\cvitemwithcomment` `\cvdoubleitem` `\cvtripleitem` `\cvlistitem` `\cvlistdoubleitem` `cvcolumns` + `\cvcolumn[width]`; skill matrix `\cvskilllegend*` `\cvskillhead` `\cvskillentry*` (`\cvskill` is the rating glyph row); letter `\recipient` `\date` `\subject` `\opening` `\closing` `\signature{scale}{file}` `\postscript` `\enclosure[name]` `\makelettertitle` `\makeletterclosing`; hooks `\bibliographyitemlabel` `\refname` `\nopagenumbers` `\ifxetexorluatex`; length knobs `\hintscolumnwidth` `\makecvheadnamewidth` `\listitemsymbolspace` (all commented out in the sample, template.tex:21-23).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | template.tex:9; moderncv.cls:24-66 | `class.moderncv` | options 11pt, a4paper, sans |
| paper and base size | template.tex:9; moderncv.cls:24-26,49-51,66 | `page.class-options` | a4paper (210mm x 297mm), 11pt via size11.clo |
| page geometry | template.tex:19 (alternative commented :20) | `page.geometry` | hmargin=0.5in, vmargin=10pt |
| default font family | template.tex:9 (`sans`); moderncv.cls:54; commented override template.tex:15 | `font.family-default` | `\familydefault` = `\sfdefault` set by class option `sans` |
| fonts, pdfTeX path | template.tex:47-49; moderncvstylecontemporary.sty:43-44; moderncv.cls:124-126 | `font.fontenc-t1`, `font.lmodern` | inputenc utf8, fontenc T1, lmodern |
| fonts, XeTeX/LuaTeX path | template.tex:33-39 | `font.fontspec`, `font.unicode-math` | `\defaultfontfeatures{Ligatures=TeX}`, main Latin Modern Roman, sans Latin Modern Sans, mono Latin Modern Mono, math Latin Modern Math (engine tag xe/lua; Flouest takes the pdfTeX path) |
| language | template.tex:53 | `lang.babel` | english (comment: Spanish breaks moderncv; KNOWN_BUGS:3) |
| colour scheme | template.tex:11; moderncvcolorcerulean.sty:22-28; moderncvcolors.sty:19-38; moderncv.cls:84,341-344 | `class.moderncv` (vocabulary `\moderncvcolor`) over `color.xcolor` | cerulean: color0 black, color1 cerulean 0081a7, color2 darkcyan 4d908e, headTL verdigris, headBR color1, headtext white, headhr color2; `xcolor` loaded with option `table` |
| style (head + body bundle) | template.tex:13; moderncvstylecontemporary.sty:78-79 | `class.moderncv` (vocabulary `\moderncvstyle`) | `contemporary` = head 7 + body 6, options left, qr, details, separator (defaults, moderncvheadvii.sty:38) |
| title block (name, title, address, phones, email, homepage, socials, photo, quote) | template.tex:56-116,134; moderncv.cls:221-337,551-555; moderncvheadvii.sty:81-179 | `front.class-native` | `\makecvtitle`; name font 30/32pt, title `\LARGE\slshape`, address `\small\slshape`, quote `\large\slshape` (moderncvheadvii.sty:59-62); quote width 0.65\textwidth (:78); photo 64pt with 2pt frame (template.tex:115) |
| contact and social icons | moderncviconssymbols.sty:16-29; moderncviconsawesome.sty:19,64-108; moderncvstylecontemporary.sty:49-50 | `font.icons` | `fontawesome6` `\faIcon{...}` under pdfTeX (plus `academicons` under XeTeX/LuaTeX, moderncviconssymbols.sty:17-18); icon colour `default-socialicon-color` = headtext (moderncvstylecontemporary.sty:49) |
| photo and signature image | template.tex:115,280; moderncvheadvii.sty:121; moderncv.cls:815 | `fig.graphicx` | `\includegraphics[width=\@photowidth]{picture}`; `\includegraphics[scale=0.9]{signature.png}` (assets picture.jpg, picture.eps, signature.png shipped) |
| section headings | template.tex:136,140,145,169,175,181,234,239,244,249; moderncvbodyvi.sty:82-96 | `head.class-native` | `\section[icon]{}` set `\Large\upshape\bfseries` in color1!55!white with a rule, `\subsection` `\large\mdseries`; sections also go to `toc` via `\addcontentsline` (moderncvbodyvi.sty:31-32,86-89,94) |
| CV entry rows | template.tex:137-138,141-143,147,165,167,170-179,240-247; moderncvbodyvi.sty:98-154 | `cv.entries` | `\cventry` (7 args, spacing .25em), `\cvitem`, `\cvitemwithcomment`, `\cvdoubleitem`, `\cvtripleitem`, `\cvlistitem`, `\cvlistdoubleitem`; hints column 0.175\textwidth, separator 0.025\textwidth (moderncvbodyvi.sty:46-47) |
| multi-column block | template.tex:250-254; moderncv.cls:660-742 | `cv.entries` | `cvcolumns` env with `\cvcolumn[fraction]{head}{content}`, third column width 0.5 (template.tex:253) |
| skill matrix | template.tex:206,220,226-230; moderncvskillmatrix.sty:602-644,930-943,994-1021; moderncvbodyvi.sty:24 | `cv.entries` | `\cvskilllegend*[1em]{}`, `\cvskillhead[-0.1em]`, `\cvskillentry` (starred, spacing arg), body variant 1 with option `circle` |
| lists inside entries | template.tex:149-164,251-253; moderncv.cls:159-169,349-352,770-791; moderncviconsawesome.sty:64 | `list.kernel` | `itemize` nested three deep; item symbols and hooks set by the class (labelitemi = tiny faIcon circle in color1, zero `\topsep` `\parsep` `\itemsep`) |
| forced line breaks in entries | template.tex:147,165 | `sp.manual-space` | kernel `\newline{}` |
| inline emphasis | template.tex:137,141,253 | `mark.kernel` | `\textit`, `\emph`, `\textbf` |
| footer and page numbers | moderncv.cls:105,132-153; template.tex:16 (commented `\nopagenumbers`) | `hf.class-native`, `pgnum.pagenumbering` | empty plain page style; page n/m in the right foot only when the document is longer than one page (class-written `lastpage` label, moderncv.cls:152); `\pagenumbering{arabic}` |
| ragged bottom, base lengths | moderncv.cls:193-203,210 | `pg.flush`, `sp.lengths` | `\raggedbottom`; lineskip 1pt, `\parindent` 0, `\parskip` 0 (letter body `\parskip` 6pt, moderncvbodyvi.sty:187) |
| microtype | moderncv.cls:179 | `sp.microtype` | loaded unconditionally, no options |
| PDF metadata and links | moderncv.cls:102-121,597-651 | `meta.hyperref`, `meta.url` | hyperref at end of preamble with option `unicode`; breaklinks, pdfborder 0 0 0, pdfpagemode UseNone, bookmarksopen, bookmarksdepth 2, author, title, subject, keywords from `\name` and `\title`; `url` with `\urlstyle{tt}` |
| bibliography | template.tex:121,246,259-261; moderncv.cls:752-767; moderncvbodyvi.sty:156-178; publications.bib | `bib.bibtex-bst` | `\nocite{*}`, `\bibliographystyle{plain}`, `\bibliography{publications}`, labels `[\arabic{enumiv}]`, heading `\refname` = Publications (moderncv.cls:412); the `multibib` variant is commented out (template.tex:126-127,263-270) |
| page break | template.tex:272 | `pg.break` | `\clearpage` between CV and letter |
| cover letter | template.tex:275-283,295; moderncv.cls:810-841; moderncvheadvii.sty:189-246; moderncvbodyvi.sty:185-198 | `ltr.opening` | class letter commands: recipient, date, subject, opening, closing, signature scale 0.9, postscript, enclosure with name `Attached`; letter head uses the same head 7 band |
| display and inline maths in the letter | template.tex:291,293 | `math.kernel` | inline `$e=mc^2$`, `\[ ... \]` with `\lim`, `\left(`, `\frac` (no amsmath) |

## Bespoke code
none: every `.cls` and `.sty` in the zip is the official CTAN release of `moderncv` (README.md:46-52, `\ProvidesClass`/`\ProvidesPackage` v2.6.1 in each file), so nothing is zip-local, and the sample defines no macro. Two sample-level items and the class internals the sample reaches are listed for transparency:

| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\renewcommand*{\bibliographyitemlabel}{[\arabic{enumiv}]}` | template.tex:121 | yes | a string value for the class's own bibliography-label hook (`class.moderncv` parameter) |
| `\ifxetexorluatex ... \else ... \fi` font loading | template.tex:32-50 (conditional defined moderncv.cls:88-97) | yes | an emitter writes only the branch for its engine; Flouest's engine is pdfTeX, so `font.fontenc-t1` + `font.lmodern` |
| head band, circular photo frame, QR code of the homepage (TikZ, `tikzmark`, `qrcode`) | moderncvheadvii.sty:45-47,116-131,148-160 | published (W1: class on CTAN), not bespoke | carried by `class.moderncv` with `\moderncvstyle[...]{contemporary}`; options qr/noqr, separator/noseparator, left/right; colours headTL, headBR, headhr; considered: `qrcode` (class-internal, not a lib way of its own) |
| vertical timeline marks next to each entry date | moderncvverticaltimeline.sty:25-28,41-70; moderncvbodyvi.sty:20,135 | published (the class's own, not the `moderntimeline` package of `cv.timeline`) | carried by `class.moderncv` (body style 6); no parameter in the sample |
| TikZ rating squares or circles, dashed row rules | moderncvskillmatrix.sty:243-267,1005 | published | carried by `class.moderncv` `\cvskill*` commands; `circle` option set by body 6 (moderncvbodyvi.sty:24) |
| `tweaklist.sty` (itemize/enumerate/description redefined with hooks) | tweaklist.sty:1-56; moderncv.cls:159-169 | published (ships inside the official release; header says not on CTAN under that name, modified for moderncv, tweaklist.sty:2-3) | carried by `class.moderncv`; the emitter never calls it |
| key-value collections via counters and `\csname` (`\collectionadd`, `\collectionloop`) | moderncvcollection.sty:30-87 | published | class-internal storage for `\phone` and `\social`; the emitter only writes those commands |
| `\onlynumberslink` expl3 regex for `tel:` links | moderncv.cls:644-651 | published | class-internal; emitter writes `\phone{...}` |

## Content-opaque
none beyond shipped image assets used by class commands: picture.jpg and picture.eps (photo, template.tex:115) and signature.png (template.tex:280); the lorem ipsum text and the placeholder entries are content (template.tex:285-289).

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
- Notes for the consolidator: moderncv's own vocabulary is recorded under `class.moderncv` above (the lib line already exists). Not stated as verified: the manifest hint `tagged-pdf-incompatible` was not checked here; KNOWN_BUGS:1-3 lists incompatibility with biber, biblatex and Spanish babel (not blockers: the sample uses `bib.bibtex-bst` and `english`).
