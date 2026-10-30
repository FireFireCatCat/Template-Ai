yes

# 0870-sdaps: SDAPS (LaTeX support files for machine-readable questionnaires)

- Unverified: read from the source, not compiled.
- Source: Source/0870-sdaps/ (origin: https://mirrors.ctan.org/macros/latex/contrib/sdaps.zip; licence: LPPL 1.3c)
- Kind: misc (a questionnaire / optical-mark survey form; the manifest hint `exam` does not describe the sample)
- Lib: v6
- Engine: pdfLaTeX-compatible (uses the pdfTeX primitives `\pdfsavepos` and `\pdflastxpos`, sdapsbase.dtx:871; LuaLaTeX and XeLaTeX support is not established, the CTAN page names no engine)
- Look carried by: class (the whole look lives in the published class `sdapsclassic` and its support packages; the zip has no sample preamble)
- Class origin: ctan
- Main file: none (no file holds `\documentclass` and `\begin{document}`; the zip is the DocStrip sources `sdaps*.dtx` of the CTAN bundle `sdaps`, plus Sphinx example sources in `html/_sources/*.rst.txt`; no other samples)
- Read: main partly (no main sample exists; all Sphinx example sources read, `html/_sources/sdapsbase.rst.txt` only lines 196-385), zip-local classes and styles all (`sdapsclassic.dtx`, `sdapsbase.dtx`, `sdapsarray.dtx`, `sdapslayout.dtx`, `sdapspdf.dtx`, `sdapscode128.tex`, one `.dict`, one `.ins`)

## Verdict
yes, carried by the class. The zip is the CTAN release of SDAPS (ctan.org/pkg/sdaps: "LaTeX support files for SDAPS", Benjamin Berg, LPPL 1.3c, v1.9.10), so the class `sdapsclassic`, the packages `sdapsbase`, `sdapsarray`, `sdapslayout`, `sdapspdf` and `sdapscode128.tex` are all published (W1), and an emitter writes only `\documentclass[options]{sdapsclassic}`, the `questionnaire` environment and the class-native question environments, with no zip-local macro logic copied. The class draws its own TikZ corner marks, checkboxes and barcodes, but these are fixed by class options and context keys, not by drawing code the emitter would write, so there is no `ART` blocker. Caveats that are recorded and do not block: there is no sample (the Sphinx examples stand in), the `.cls` exists only after DocStrip (`sdapsclassic.ins:34`), and the red "draft" watermark can be switched off only through an optional `sdaps.opt` file written by the SDAPS program or by expl3 code (see Bespoke code).

## Blockers
none

## Class setting
- Class: `class.sdapsclassic` options: `sdaps_style` (code128, custom, qr; the class sets qr at sdapsclassic.dtx:121), `checkmode` (checkcorrect, check, fill), `twoside_barcode` (both, front, back), `disable_recognition`, `globalid`, `globalidlabel`, `print_questionnaire_id`, `no_print_questionnaire_id`, `final`; every other option goes to `scrartcl` (sdapsclassic.dtx:108-183).
- Class-native vocabulary used: environments `questionnaire[noinfo]`, `info`, `choicequestion`, `optionquestion`, `choicegroup`, `optiongroup`, `markgroup`; commands `\singlemark`, `\singlemarkother`, `\textbox`, `\choiceitem`, `\choicemulticolitem`, `\choiceitemtext`, `\choice`, `\question`, `\groupaddchoice`, `\choiceline`, `\markline`, `\addinfo`, `\sdapsinfo`, `\checkbox` `\checkedbox` `\filledbox` `\correctedbox`, counter `markcheckboxcount`; key=value options `var`, `text`, `cols`, `colsep`, `rowsep`, `type`, `singlechoice`, `multichoice`, `align`, `layouter`, `angle`, `vertical`, `count`, `other`; KOMA font elements `questionfont`, `choicefont` and seven derived ones (sdapsclassic.dtx:313-325); the support packages add `sdapsarray` (keys `flip` `layouter` `align` `keepenv` `no_header` `angle` `colsep` `rowsep`), `choicearray`, `optionarray`, `rangearray` (`other`, `count`), the context and override API (`\sdaps_context_set:n`, `\sdaps_context_append:nn`, `\sdaps_overrides_init:n`) and the add-on `sdapspdf` (keys `pdf_form`, `default`, `checkboxsymbol`).

## Component map
Rows below the first block record what the published class loads and sets inside itself, so the decomposition is visible; the emitter does not write them, the class way carries them.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | sdapsclassic.dtx:22, sdapsclassic.dtx:195-200 | `class.sdapsclassic` | options as under Class setting; `\FamilyProcessOptions{SDAPS}` then `\LoadClass{scrartcl}` |
| base class | sdapsclassic.dtx:115, sdapsclassic.dtx:186-187, sdapsclassic.dtx:200 | `class.scrartcl` | `\PassOptionsToClass{headings=small}`, `\PassOptionsToClass{twoside}`; unknown options passed on |
| page geometry | sdapsclassic.dtx:207-216; user override html/_sources/FAQ.rst.txt:96-98 | `page.geometry` | top=12mm, bottom=14mm, hmargin=12mm, includeheadfoot, headheight=\baselineskip, headsep=\baselineskip, footskip=12mm |
| header and footer | sdapsclassic.dtx:240-243, sdapsclassic.dtx:302 | `hf.scrlayer-scrpage` | `\clearpairofpagestyles`, `\chead*{\@title}`, `\cfoot*{\sdapspagemark}`, `\pagestyle{scrheadings}` |
| page numbering | sdapsclassic.dtx:303 | `pgnum.pagenumbering` | arabic |
| last-page label | sdapsclassic.dtx:231-234 | `pgnum.lastpage` | `lastpage` and `refcount` loaded, no printed use in the class |
| paragraph and line lengths | sdapsclassic.dtx:283-290 | `sp.lengths` | \lineskip=1pt, \normallineskip=1pt, \parindent=0pt, \parskip=1.0ex plus 1.5ex minus -0.25ex, \columnsep=10pt, \columnseprule=0pt |
| line stretch | sdapsclassic.dtx:285 | `sp.linespread` | `\renewcommand\baselinestretch{}` |
| skip commands | sdapsclassic.dtx:407-412 | `sp.manual-space` | `\smallskip` `\medskip` `\bigskip` redefined as `\vspace` of 3pt plus 1pt minus 1pt, 6pt plus 2pt minus 2pt, 12pt plus 4pt minus 4pt |
| page flow | sdapsclassic.dtx:304, sdapsclassic.dtx:306 | `pg.flush` | `\raggedbottom` |
| one column | sdapsclassic.dtx:306 | `cols.twocolumn-cmd` | `\onecolumn` |
| encoding | sdapsclassic.dtx:222 | `font.fontenc-t1` | `[T1]fontenc` |
| colours | sdapsclassic.dtx:225, sdapsclassic.dtx:382-383 | `color.color` | sectionbgcolor gray 0.8, sectionfgcolor gray 0.0 |
| math symbols | sdapsclassic.dtx:228 | `math.amssymb` | `amssymb`, load only |
| heading commands | sdapsclassic.dtx:292-301 | `head.kernel` | `\section` re-set by `\@startsection` (level 1, beforeskip -\parskip, afterskip \parskip, `\normalfont\Large\bfseries\SS@sectfont`); `\subsection` skips 0.5\parskip and 0.25\parskip |
| section heading look | sdapsclassic.dtx:261, sdapsclassic.dtx:385-397 | `head.sectsty` | `\sectionfont{\sectbox}` |
| section heading font | sdapsclassic.dtx:399-400 | `head.koma-fonts` | `\setkomafont{disposition}{\normalfont}`, `\addtokomafont{section}{\bfseries\sffamily}` |
| section heading box | sdapsclassic.dtx:385-395 | `box.fancybox` | `\colorbox{sectionbgcolor}` (the `color` package's sibling of `\fcolorbox`), filled to `\hsize` minus 2\fboxsep |
| section heading text block | sdapsclassic.dtx:389-393 | `box.minipage` | `\parbox` with `\raggedright`, `\smallskip` before and after |
| class font elements | sdapsclassic.dtx:313-325 | `class.sdapsclassic` | `\newkomafont` for questionfont, choicefont, singlemarkquestionfont, singlemarkchoicefont, marklinequestionfont, marklinechoicefont, choiceitemfont, choicegroupchoicefont, choicegrouplinefont |
| title and author | sdapsclassic.dtx:242, sdapsclassic.dtx:969-974, sdapsclassic.dtx:989-990 | `front.maketitle` | `\title` and `\author` feed the header and the PDF and SDAPS metadata; the class never calls `\maketitle` |
| hyperlinks and PDF metadata | sdapsclassic.dtx:247-255, sdapsclassic.dtx:969-974 | `meta.hyperref` | breaklinks, baseurl=http://, pdfborder=0 0 0, pdfpagemode=UseNone, pdfcreator, pdfproducer; pdfauthor, pdftitle, pdfsubject, pdfkeywords set in `questionnaire` |
| urls | sdapsclassic.dtx:246 | `meta.url` | `url`, load only |
| language | sdapsclassic.dtx:267 | `lang.babel` | `babel`, load only (needed by the translator) |
| translated strings | sdapsclassic.dtx:270-271; translator-sdaps-dictionary-English.dict:15-28 | `lang.translator` | `\usedictionary{translator-sdaps-dictionary}`; 15 `.dict` files, keys answers, draft, info-corrected, info-cross, info-fill, info-multi, info-single, infotext, mean, questionnaireid, standard-deviation, surveyid |
| graphics | sdapsclassic.dtx:258; example html/_sources/FAQ.rst.txt:64-68 | `fig.graphicx` | `graphicx` loaded; example `\graphicspath{{images/}}` and `\raisebox{-0.8cm}{\includegraphics[width=2cm]{sdaps.png}}` (the raisebox is `sp.manual-space`) |
| info block | sdapsclassic.dtx:357-379, sdapsclassic.dtx:955-963 | `class.sdapsclassic` | `info` environment, `\sdapsinfo`, option `noinfo` |
| info block rules | sdapsclassic.dtx:363, sdapsclassic.dtx:377 | `sp.rule` | `\hrule height 1pt` above and below |
| info block and mark rows | sdapsclassic.dtx:264, sdapsclassic.dtx:585, sdapsclassic.dtx:932-950 | `tbl.tabularx` | `\begin{tabularx}{\textwidth}{lXllll}`; mark row `X*{n}{c}X` |
| questionnaire wrapper | sdapsclassic.dtx:965-1061 | `class.sdapsclassic` | `questionnaire[noinfo]`; with several IDs the body is written to `\jobname.questionnaire` and input once per ID (sdapsclassic.dtx:1007-1013, sdapsclassic.dtx:1048) |
| choice and option questions | sdapsclassic.dtx:651-669, sdapsclassic.dtx:684-759, sdapsclassic.dtx:795-898 | `class.sdapsclassic` | keys cols=3, colsep=6pt, rowsep=0pt, var, text, type, singlechoice, multichoice; `\choiceitem`, `\choicemulticolitem{n}`, `\choiceitemtext{height}{n}` |
| question groups | sdapsclassic.dtx:1089-1196; sdapslayout.dtx:128-147, sdapslayout.dtx:369-380, sdapslayout.dtx:650-736 | `class.sdapsclassic` | `choicegroup`, `optiongroup`, `markgroup`; keys align, noalign, layouter (default or rotated), angle=70, vertical, horizontal, other, count=5, var, val, text, range |
| mark and text questions | sdapsclassic.dtx:462-487, sdapsclassic.dtx:561-630 | `class.sdapsclassic` | `\singlemark[count=,var=]{q}{lower}{upper}`, `\singlemarkother`, `\textbox*[var=,text=]{height}{q}`, counter markcheckboxcount=5 |
| array layout | sdapsarray.dtx:781-806, sdapsarray.dtx:1065 | `class.sdapsclassic` | `sdapsarray[flip, layouter, align, keepenv, no_header, angle=70, colsep=6pt, rowsep=0pt]` with `&` and `\\`, `\sdapsnested` |
| checkbox look | sdapsbase.dtx:824-859, sdapsbase.dtx:903-909; html/_sources/sdapsbase.rst.txt:301-318 | `class.sdapsclassic` | linewidth=1bp, width=3.5mm, height=3.5mm, form=box or ellipse, fill=white, draw=., draw_check, centered_text, text, text_align=c, text_padding=2bp; set through `\sdaps_context_set:n` (html/_sources/sdapsbase.rst.txt:341-371) and `\sdaps_overrides_init:n` (html/_sources/sdapsbase.rst.txt:257-273) |
| textbox look | sdapsbase.dtx:1027-1049, sdapsbase.dtx:1084-1228 | `class.sdapsclassic` | linewidth=1bp, fill=white, draw=., overlays; `\sdaps_textbox_vhstretch:nnn`, `_hstretch:nnnnn`, `_hbox:nnn`, `_vbox:nnnn` |
| page markers, codes, watermark | sdapsbase.dtx:1448-1456, sdapsbase.dtx:1502-1598, sdapsbase.dtx:1604-1755 | `class.sdapsclassic` | corner marks (margins 10, 10, 12, 12 mm; marker length 20mm; line width 1bp); QR or Code 128 by `sdaps_style`; barcode height 6.5mm, bar width 0.33mm; red rotated "draft" node (rotate=60, scale=10, text opacity=0.2); drawn by the class's own TikZ, not `art.tikz`, because the emitter writes no drawing code |
| QR code | sdapsbase.dtx:93, sdapsbase.dtx:107-110, sdapsbase.dtx:1510 | `fig.qrcode` | `\qrcode[nolink,version=2,level=H,padding,height=10mm]{string}` called inside the class |
| Code 128 barcode | sdapsbase.dtx:91, sdapsbase.dtx:1479-1486; sdapscode128.tex:157, sdapscode128.tex:1-13 | `class.sdapsclassic` | Olsak's `\code{string}` with `\X`, `\bcorr`, `\barheight`; shipped inside the CTAN bundle with the author's permission |
| metadata file | sdapsbase.dtx:765-786, sdapsclassic.dtx:336-338 | `class.sdapsclassic` | `\jobname.sdaps` written by TeX `\iow_shipout`; `\addinfo{key}{value}` |
| PDF form add-on | sdapspdf.dtx:92-93, sdapspdf.dtx:115-125; html/_sources/sdapspdf.rst.txt:7-10, html/_sources/sdapspdf.rst.txt:35-69 | `class.sdapsclassic` | `\usepackage{sdapspdf}`, keys pdf_form=false, default=false, checkboxsymbol=8 |
| PDF form fields | sdapspdf.dtx:133, sdapspdf.dtx:149; html/_sources/sdapspdf.rst.txt:46-69 | `NEW:form.hyperref` | body wrapper `\begin{Form}...\end{Form}`; `\CheckBox[name,width,height,checkboxsymbol,checked,borderwidth,bordercolor,backgroundcolor]{}` and `\TextField[name,width,height,multiline]{}` |
| example: lists | html/_sources/customlayout.rst.txt:132-140 | `list.kernel` | `itemize` with `\item[\mycheckbox{}{}]` |
| example: tables inside questions | html/_sources/sdapsclassic.rst.txt:217-221, html/_sources/sdapsclassic.rst.txt:545 | `tbl.tabularx` | `tabularx{\linewidth}{l\|l\|X}` and `tabularx{0.5\linewidth}{llX}` inside question text |
| example: verbatim | html/_sources/sdapsclassic.rst.txt:543, html/_sources/sdapsclassic.rst.txt:550-553 | `code.verbatim` | `\verb^..^` and a `verbatim` environment inside a `\choiceline` |
| example: columns | html/_sources/sdapsarray.rst.txt:53-63 | `cols.multicol` | `\begin{multicols}{2}` around `sdapsarray` |
| example: rules and fonts | html/_sources/sdapsarray.rst.txt:31-34, html/_sources/sdapsarray.rst.txt:42 | `sp.rule` | `\hrule`; `\texttt` is `mark.kernel` |
| example: array in math | html/_sources/sdapsclassic.rst.txt:541 | `tbl.tabular` | `array` environment in `$..$` |
| example: manual spacing | html/_sources/customlayout.rst.txt:286, html/_sources/sdapsbase.rst.txt:340 | `sp.manual-space` | `\hspace{8cm}`, `\hspace{1em}` (the bare `\vrule width 0pt height 3cm depth 2cm` at customlayout.rst.txt:286 is `sp.rule`) |

## Bespoke code
Nothing in the zip is zip-local: it is the CTAN release of the bundle (W1 holds for every file). Only three definitions written in the documentation examples are bespoke in form, and all reduce.

| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\let\myquestionbegin\sdaps_qobject_begin:nnn` and the other `\let` aliases under `\ExplSyntaxOn` | html/_sources/customlayout.rst.txt:35-40, html/_sources/customlayout.rst.txt:100-104 | yes | alias of documented class commands (html/_sources/sdapsbase.rst.txt:121-148); print the published command inline in an `\ExplSyntaxOn ... \ExplSyntaxOff` wrapper, `class.sdapsclassic` |
| `\let\mycontextappend\sdaps_context_append:nn` and three more aliases | html/_sources/sdapspdf.rst.txt:39-44 | yes | alias of published context and checkbox commands; inline expansion |
| `\def\sdapsalignment{\sdaps_array_alignment:}`, `\def\sdapsnewline{\sdaps_array_newline:}` | html/_sources/sdapsarray.rst.txt:148-153 | yes | alias of published array commands (the page says `\def`, not `\let`, because they are redefined inside); inline expansion |
| class internals: context stack, question numbering, checkbox and textbox boxes, `sdapsarray` row layouter with two-pass `.sdapsarraytic` and `.sdapsarraytoc` width files, corner marks, Code 128 macros | sdapsbase.dtx:186-611, sdapsbase.dtx:1084-1228, sdapsarray.dtx:129-151, sdapsarray.dtx:592-736, sdapsbase.dtx:1604-1755, sdapscode128.tex:157-253 | not bespoke (published) | box and glue algorithms that would be irreducible if they were zip-local; here they are the published package, one way `class.sdapsclassic`, and the emitter prints only options and environments |
| optional `sdaps.opt` hook | sdapsclassic.dtx:117-119, sdapsclassic.dtx:274-275, sdapsbase.dtx:1426, sdapsbase.dtx:1745 | not a blocker | `\InputIfFileExists{sdaps.opt}` is read if present; the SDAPS program writes it (final mode, survey id, questionnaire ids); the option `final` only sets an unused switch (sdapsclassic.dtx:119) and the draft watermark stays on by default; the TeX source compiles without the program, and the same variables are set by documented expl3 lines (html/_sources/FAQ.rst.txt:87-93 sets margins this way) |
| user layouter registration (not used by any sample) | html/_sources/sdapsarray.rst.txt:186-204 | n/a | would be irreducible box code if a sample wrote it; the page only shows copies of the two built-in layouters (sdapsarray.dtx:739-758) |

## Content-opaque
TikZ QR-code icon inside a codebox overlay (html/_sources/customlayout.rst.txt:263-274); `array` and `verbatim` in question text (html/_sources/sdapsclassic.rst.txt:541, html/_sources/sdapsclassic.rst.txt:550-553); nested `array` in `sdapsarray` cells (html/_sources/sdapsarray.rst.txt:158); `tabularx` inside a `\sdapsvbox` (html/_sources/sdapsclassic.rst.txt:217-221).

## Lib changes
- New ways proposed: `NEW:form.hyperref` `hyperref` (CTAN, LPPL, core package): interactive PDF form fields, `\begin{Form}...\end{Form}`, `\TextField[keys]{label}`, `\CheckBox[keys]{label}` (sdapspdf.dtx:133, sdapspdf.dtx:149), pdf engine tag (form fields work with pdfTeX; other drivers not read). W1: hyperref is on CTAN and its manual documents the field commands. W2: key=value options (name, width, height, checkboxsymbol, checked, borderwidth, colours). W3: serves any fillable form. W4: one wrapper environment plus field commands. Considered: `form.eforms` (acrotex), the same type with another package; kept as its own proposal because its lib line names acrotex only, and the consolidator may merge them as it did other sibling packages.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
