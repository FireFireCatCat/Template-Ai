yes

# 0196-moderncv: moderncv (CV and cover-letter class, CTAN distribution with its sample)

- Unverified: read from the source, not compiled.
- Source: Source/0196-moderncv/ (origin: https://mirrors.ctan.org/macros/latex/contrib/moderncv.zip; licence: lppl1.3c)
- Kind: cv
- Lib: v0
- Engine: pdfLaTeX-compatible (template.tex:32-50 branches on `\ifxetexorluatex`; the pdfTeX branch is `inputenc`+`fontenc`+`lmodern`. The class picks fontawesome6 icons for pdfTeX, moderncviconssymbols.sty:21-22, and adds academicons only under XeLaTeX/LuaLaTeX, :16-18. Needs 2+ passes and a BibTeX pass, all inside TeX.)
- Main file: template.tex (other samples: manual/moderncv_userguide.tex, the class manual in `article`; only its preamble was outlined with grep, it is documentation and not the template)
- Read: main yes, zip-local classes and styles all (moderncv.cls, 6 head, 6 body incl. the byte-identical bodyii, 7 style, 9 colour, 5 icon, skillmatrix in 5 chunks, collection, compatibility, tweaklist, verticaltimeline, debugtools)

## Verdict
`yes`, by the rubric's class rule. The zip is the CTAN release of the published class `moderncv` (README.md:4,14-15,45 and the origin URL), so `moderncv.cls`, its head/body/colour/icon style files and the bundled `tweaklist.sty` are published code (W1), not zip-local bespoke code. `template.tex` loads the class unchanged and defines no macro of its own beyond one documented hook value, so an emitter writes only `\documentclass[11pt,a4paper,sans]{moderncv}`, `\moderncvcolor`, `\moderncvstyle`, geometry, fonts, babel, personal-data commands and `cv.entries` commands. Caveat that decides the answer: the class is a hand-written 847-line class (own `\section`, lists, collections, TikZ head); if `class.moderncv` were not accepted as one way, this would be `no` (`BESPOKE`, `ART`). It is accepted because the lib already lists `class.moderncv` and the rubric says a published class is one way.

## Blockers
none

## Class setting
- Class: `class.moderncv` options: `11pt`, `a4paper`, `sans` (template.tex:9). The class has no `\LoadClass`; it inputs `size11.clo` itself (moderncv.cls:66). Option set: paper (a4paper a5paper b5paper letterpaper legalpaper executivepaper landscape), 10pt 11pt 12pt, sans roman, draft final (moderncv.cls:24-62).
- Class-native vocabulary used: `\moderncvcolor{cerulean}`, `\moderncvstyle[]{contemporary}`, `\name`, `\title`, `\born`, `\address`, `\phone[mobile|fixed|fax]`, `\email`, `\homepage`, `\social[<network>]` (about 40 networks), `\extrainfo`, `\photo[64pt][2pt]`, `\quote`, `\makecvtitle`, `\section[icon]`, `\subsection`, `\cventry`, `\cvitem`, `\cvitemwithcomment`, `\cvdoubleitem`, `\cvtripleitem`, `\cvlistitem`, `\cvlistdoubleitem`, `cvcolumns`+`\cvcolumn`, `\cvskill`, `\cvskilllegend`, `\cvskillhead`, `\cvskillentry`, `\bibliographyitemlabel`, `\nopagenumbers` (commented), letter: `\recipient`, `\date`, `\subject`, `\opening`, `\closing`, `\signature`, `\postscript`, `\enclosure`, `\makelettertitle`, `\makeletterclosing`. Other style values exist but are not used: casual, classic, banking, oldstyle, fancy, empty (below).
- Published packages the class loads itself (not emitted by Flouest): etoolbox, ifthen, xcolor[table], iftex, url, hyperref (at end of preamble), fontenc T1 (pdfTeX), graphicx, fancyhdr, tweaklist (bundled), calc, xparse, expl3, microtype (moderncv.cls:73-187); tikz with libraries tikzmark, fit, babel, and qrcode (moderncvheadvii.sty:45-47); multirow and tikz (moderncvskillmatrix.sty:232-234); fontawesome6 (moderncviconsawesome.sty:19); academicons (xe/lua, moderncviconsacademic.sty:20); changepage (moderncvheadiv.sty:28, style oldstyle only); tgpagella, kurier, ebgaramond (banking, oldstyle, fancy only).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | template.tex:9; moderncv.cls:13,66 | `class.moderncv` | 11pt, a4paper, sans; version v2.6.1 (2026-06-24) |
| paper and point size | template.tex:9; moderncv.cls:24-66 | `page.class-options` | a4paper (297mm x 210mm), 11pt via size11.clo |
| default font family | template.tex:9; moderncv.cls:54 | `font.family-default` | `sans` sets `\familydefault`=`\sfdefault` at begin document |
| page geometry | template.tex:19 | `page.geometry` | hmargin=0.5in, vmargin=10pt (alternative scale=0.75 commented, :20) |
| colour scheme | template.tex:11; moderncvcolorcerulean.sty:20-28; moderncvcolors.sty:19-38; moderncv.cls:84 | `class.moderncv`, `color.xcolor` | cerulean: color0=black, color1=cerulean #0081a7, color2=darkcyan #4d908e, headTL=verdigris #00afb9, headBR=color1, headtext=white, headhr=color2; the other 8 schemes are the same 8 `\colorlet` lines with other values (moderncvcolor*.sty) |
| style selection | template.tex:13; moderncvstylecontemporary.sty:16-32,78-79; moderncv.cls:426-452 | `class.moderncv` | contemporary = head variant 7 + body variant 6, no foot; options left, qr, details, separator (all defaults) |
| style colour map | moderncvstylecontemporary.sty:56-73 | `color.xcolor` | colorlet of name/title/address/section/rule/skillmatrix colours from color1, color2 (name `lastnamecolor`=color2, `firstnamecolor`=color2!50, skill empty=color2!30) |
| title block (name, title, details, quote) | template.tex:56-64,114,116,134; moderncvheadvii.sty:59-68,81-179 | `front.class-native` | `\makecvtitle`; name `\fontsize{30}{32}\rmfamily` with last name `\scshape`; title `\LARGE\mdseries\slshape`; address `\small\mdseries\slshape`; details box right-aligned (option left); quote box 0.65\textwidth |
| head type sizes | moderncvheadvii.sty:59-62 | `font.size-commands` | `\fontsize{30}{32}`, `\LARGE`, `\small`, `\large` |
| personal data | template.tex:56-64,114; moderncv.cls:221-337 | `front.class-native` | name, title, born, address (3 args), 3 phones (mobile, fixed, fax), email, homepage, extrainfo |
| social links and icons | template.tex:66-111; moderncv.cls:295-333; moderncviconssymbols.sty:16-29; moderncviconsawesome.sty:19,64-108 | `front.class-native`, `font.icons` | `\social[linkedin|xing|github|...|threema]{account}`; icon set `symbols` = fontawesome6 (pdfTeX) plus academicons (xe/lua) plus 4 TikZ glyphs (matrix, codeberg, simplex, threema); icon colour `default-socialicon-color`=headtext (stylecontemporary.sty:49) |
| header banner artwork | moderncvheadvii.sty:148-160 | `class.moderncv` | TikZ gradient band from page top to `\tikzmark{head-end}`: top color headTL, bottom color headBR, shading angle 45; separator line width = photo frame (2pt) in headhr!85!black; reduces to style=contemporary, option `separator`/`noseparator` (see Bespoke code) |
| photo | template.tex:115; moderncvheadvii.sty:109-126 | `front.class-native`, `fig.graphicx` | `\photo[64pt][2pt]{picture}` drawn as a circle clip with a gradient ring (TikZ, internal) |
| homepage QR code | moderncvheadvii.sty:22-24,45,129-132 | `class.moderncv` | option `qr` (default) / `noqr`; `\qrcode[height=1.5cm]{\@homepage}` from published `qrcode` |
| sections and subsections | template.tex:136-249; moderncvbodyvi.sty:31-38,82-96 | `head.class-native` | `\section[icon]{title}`: `\Large\upshape\bfseries` colour color1, 1pt vertical bar in color1!55!white; `\subsection` `\large\mdseries`; unnumbered, `\addcontentsline{toc}` only for bookmarks |
| vertical timeline | moderncvverticaltimeline.sty:25-75; moderncvbodyvi.sty:20,87,135 | `class.moderncv` | dotted `color0!20` link and circle milestone beside each `\cventry` year, `\AddToHook{shipout/background}`; internal TikZ, tied to body variant 6 |
| CV entries | template.tex:137-179,240-247; moderncvbodyvi.sty:46-58,98-154 | `cv.entries` | `\cventry` 6 args, `\cvitem`, `\cvitemwithcomment`, `\cvdoubleitem`, `\cvtripleitem`, `\cvlistitem`, `\cvlistdoubleitem`; hintscolumnwidth 0.175\textwidth, separatorcolumnwidth 0.025\textwidth, entry spacing [.25em] |
| columns | template.tex:250-254; moderncv.cls:668-749 | `cv.entries` | `cvcolumns` env, `\cvcolumn[0.5]{head}{content}`; tabular with p columns |
| skill matrix | template.tex:181-232; moderncvbodyvi.sty:24; moderncvskillmatrix.sty:243-267,570-1021 | `cv.entries` | `[moderncvbodyi,circle]`; `\cvskilllegend*[1em]{}`, `\cvskillhead[-0.1em]`, `\cvskillentry*[...]`; shape size .7ex, full=color1, empty=color2!30; `multirow` and TikZ inside the class |
| nested lists in entries | template.tex:149-164; moderncv.cls:159-169,349-358,770-791; tweaklist.sty:41-52 | `list.kernel` | 3 levels `itemize`; labels coloured color1 (bullet, bold dash, centered dot); leftmargin 1em, labelsep .5em; hooks zero topsep, partopsep, parsep, parskip, itemsep |
| list and base lengths | moderncv.cls:160-167,193-211 | `sp.lengths` | lineskip 1pt, parindent 0, parskip 0, columnsep 10pt, fboxsep 3pt, fboxrule .4pt, arrayrulewidth .4pt |
| flush bottom | moderncv.cls:210 | `pg.flush` | `\raggedbottom`, `\onecolumn` |
| inline marks | template.tex:137,141,253 | `mark.kernel` | `\textit`, `\emph`, `\textbf` |
| footer and page numbers | moderncv.cls:131-153; template.tex:16 | `hf.class-native` | fancyhdr `plain` style: head/foot rules 0pt, `\fancyhf{}`, page `X/Y` at right foot in color2 italic only when the document has more than 1 page (hand-rolled `\label{lastpage}`); contemporary has no foot variant, so `\makecvfoot` stays empty (moderncv.cls:555); `\nopagenumbers` is the switch |
| page counter | moderncv.cls:105 | `pgnum.pagenumbering` | `\pagenumbering{arabic}` |
| PDF metadata and links | moderncv.cls:100-121,597-651 | `meta.hyperref` | `\hypersetup`: breaklinks, pdfborder 0 0 0, pdfpagemode UseNone, pdfstartpage 1, bookmarksopen, bookmarksdepth 2, author/title/subject/keywords from `\name`/`\title`; option `unicode`; `\link`, `\httplink`, `\httpslink`, `\emaillink`, `\tellink` |
| url style | moderncv.cls:102-103 | `meta.url` | `\urlstyle{tt}` |
| microtype | moderncv.cls:179 | `sp.microtype` | defaults |
| encodings and fonts (pdfTeX branch) | template.tex:47-49; moderncv.cls:124-126; moderncvstylecontemporary.sty:43-44 | `font.fontenc-t1`, `font.lmodern` | `inputenc` utf8, `fontenc` T1, `lmodern` |
| fonts (XeLaTeX/LuaLaTeX branch) | template.tex:33-39 | `font.fontspec`, `font.unicode-math` | `\defaultfontfeatures{Ligatures=TeX}`, `\setmainfont` Latin Modern Roman, `\setsansfont` Latin Modern Sans, `\setmonofont` Latin Modern Mono, `\setmathfont` Latin Modern Math |
| language | template.tex:53 | `lang.babel` | `english` (Spanish is a known break, template.tex:53, KNOWN_BUGS:3) |
| bibliography | template.tex:121,246,259-261; moderncvbodyvi.sty:156-178; moderncv.cls:752-761 | `bib.bibtex-bst` | `\cite{book2}`, `\nocite{*}`, `\bibliographystyle{plain}`, `\bibliography{publications}`; class-owned `thebibliography` as a list under `\section{\refname}` ("Publications"), labelwidth hintscolumnwidth, labelsep separatorcolumnwidth; `\bibliographyitemlabel`=`[\arabic{enumiv}]`; biblatex/biber unsupported (KNOWN_BUGS:1-2) |
| cover letter | template.tex:273-295; moderncvheadvii.sty:189-246; moderncvbodyvi.sty:185-198; moderncv.cls:810-841 | `ltr.opening` | class-native letter commands; letter head = same gradient banner with sender block; recipient left, date right, subject bold, `\parskip` 6pt; closing, signature, `PS:`, enclosure line in color2 italic |
| signature image | template.tex:280; moderncv.cls:815 | `fig.graphicx` | `\signature{0.9}{signature.png}` = `\includegraphics[scale=0.9]` |
| page break | template.tex:272 | `pg.break` | `\clearpage` |
| alternate style values (unused) | moderncvstylecasual.sty:82-90; ...classic.sty:81-89; ...banking.sty:95-102; ...oldstyle.sty:83-91; ...fancy.sty:80-89; ...empty.sty:68 | `class.moderncv` | casual head2+body1+foot1 (right,symbols,nodetails); classic head1+body1+foot1; banking head3+body3 (fullrules/shortrules/mixedrules/norules, left/center/right) + tgpagella; oldstyle head4+body4 + kurier; fancy head5+body5 + ebgaramond; empty = no layout, user supplies commands |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\renewcommand*{\bibliographyitemlabel}{[\arabic{enumiv}]}` | template.tex:121 | yes | documented class hook (moderncv.cls:755); a label-format string parameter of `class.moderncv` |
| `\ifxetexorluatex` font branch | template.tex:32-50 (macro from moderncv.cls:88-97) | yes | emitter writes one branch by engine tag: `font.fontenc-t1`+`font.lmodern` (pdfTeX) or `font.fontspec`+`font.unicode-math` |
| `moderncv.cls`: redefined `\section`, lists, `\title`, `\date`, collections (moderncvcollection.sty:30-87), expl3 regex tel link (moderncv.cls:644-651), `cvcolumns` loop (668-723) | moderncv.cls:1-844 | not bespoke (published) | zip is the CTAN release; one way `class.moderncv`; nothing copied. Without W1 this would be irreducible |
| head/body/foot/colour/icon variants, `skillmatrix`, `verticaltimeline`, `compatibility`, `debugtools`, bundled `tweaklist` | moderncv*.sty, tweaklist.sty | not bespoke (published, shipped in the CTAN `moderncv` package) | style, colour and icon files are the values of `\moderncvstyle`, `\moderncvcolor`, `\moderncvicons`; `tweaklist.sty` says it is modified from an off-CTAN original (tweaklist.sty:2-3) but ships inside the CTAN package; `moderncvbodyii.sty` is a byte-identical copy of `moderncvbodyi.sty`; `debugtools` is never loaded |
| class-internal TikZ artwork: banner (moderncvheadvii.sty:148-160), circular photo (116-123), timeline (moderncvverticaltimeline.sty:25-75), skill shapes (moderncvskillmatrix.sty:243-248), 4 social glyphs (moderncviconstikz.sty:44-170) | as listed | `ART` not raised | the artwork is chosen by style and option values of the published class, same rationale as the rubric's `tikzposter` example; Flouest never emits the TikZ |

## Content-opaque
none in the sample. The TikZ vector icon paths for matrix, codeberg, simplex and threema (moderncviconstikz.sty:44-170) are glyph content inside the published class and are never emitted by Flouest. Display math `$e=mc^2$` and `\[ ... \]` (template.tex:291-293) is equation content.

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
- Notes for the consolidator (no new way): `font.icons` is used with fontawesome6 and academicons, which the lib text does not name; `ltr.opening` is used for the moderncv class-native letter commands, which the lib text does not name; Kurier and EB Garamond (loaded only by the unused banking/oldstyle/fancy values) have no font way and need none because the class loads them. Missing assets: `picture.jpg` and `signature.png` ship in the zip (`picture.eps` is for dvips); the zip's class is v2.6.1, so ship its files if the TeX distribution's `moderncv` is older (the sample uses `\social[medium]` and `\social[threema]`).
