yes

# 0212-sayandedotcom-tweakleaf: TweakLeaf (Deedy cover letter and CV, Jake/Sourabh/Rover/Entry-level/Sid Lacy templates)

- Unverified: read from the source, not compiled.
- Source: Source/0212-sayandedotcom-tweakleaf/ (origin: https://codeload.github.com/sayandedotcom/tweakleaf/zip/refs/heads/main; licence: MIT)
- Kind: letter (cover-letter templates; the same app also ships four resume/CV templates)
- Lib: v2
- Engine: needs XeLaTeX (`fontspec` in both zip-local classes, apps/ai/compiler/src/compiler/cover.cls:17 and apps/ai/compiler/src/compiler/deedy-resume-openfont.cls:27, with `xltxtra` and `xunicode` only in cover.cls:17; `fontspec` in the Entry-level letter, apps/web/constants/cover-letter-templates/entry-level-cover-letter.ts:35). The Jake, Sourabh, Rover and default strings are pdfLaTeX-compatible; Jake's uses the pdfTeX primitive `\pdfgentounicode` (apps/web/constants/resume-templates/jakes-resume.ts:62) and the app compiles it with pdflatex (apps/web/configs/resume-templates.ts:11).
- Look carried by: mixed (zip-local classes `cover` and `deedy-resume-openfont` carry the Deedy letter and Deedy CV; the other five templates carry their look in their own preambles over `article`/`letter`)
- Class origin: zip-local (`cover.cls` and `deedy-resume-openfont.cls` are zip-local; ctan.org/pkg/deedy-resume and ctan.org/pkg/deedy-resume-openfont both returned HTTP 404 when read; the other seven templates use `article`/`letter` from the TeX distribution)
- Main file: apps/web/constants/cover-letter-templates/deedy-cover-letter.ts (LaTeX inside a TypeScript `String.raw` literal; the zip holds no `.tex` file) (other samples: apps/web/constants/resume-templates/deedy-cv.ts, jakes-resume.ts, sourabh-bajaj-resume.ts, base-rover.ts; apps/web/constants/cover-letter-templates/entry-level-cover-letter.ts, sid-lacy-cover-letter.ts; apps/web/configs/default-cover-letter-latex.ts, default-resume-latex.ts (identical text, both are a cover letter))
- Read: main yes, zip-local classes and styles all (2 files, 184 lines; all 9 embedded templates read in full)

## Verdict
Yes. The zip is a Next.js + FastAPI web app; its LaTeX is 9 template strings in `.ts` files plus two zip-local classes. Both classes are `\LoadClass{article}` plus published packages (geometry, hyperref, xcolor, titlesec, textpos, fontspec, cite) plus `\newcommand` font/colour macros, which reduce to lib ways with parameters (inlined at use). Every other template is published packages over `article`/`letter`. One way is proposed (`meta.glyphtounicode` for Jake's `\input{glyphtounicode}` + `\pdfgentounicode=1`). No TikZ or other artwork, nothing needing a tool outside TeX. The Python/TypeScript app (UI, LLM tweak graph, compile wrapper) is not template content and is out of scope; no text addressed to an AI was found in the LaTeX files.

## Blockers
none

## Class setting
- Class: `class.article` (Deedy letter via zip-local `cover`, apps/web/constants/cover-letter-templates/deedy-cover-letter.ts:4 and apps/ai/compiler/src/compiler/cover.cls:9; Deedy CV via `deedy-resume-openfont`, apps/web/constants/resume-templates/deedy-cv.ts:13; Jake, Sourabh, Rover, Entry-level, defaults); options: none (`[]`) for the zip-local ones, `letterpaper,11pt` (jakes-resume.ts:9, sourabh-bajaj-resume.ts:9), `11pt` (base-rover.ts:14), `11pt,a4` (entry-level-cover-letter.ts:17; `a4` is not a standard option name, warning only)
- Class: `class.letter` (apps/web/constants/cover-letter-templates/sid-lacy-cover-letter.ts:6) options: `12pt`
- Class-native vocabulary used: article `\section` `\subsection` `\subsubsection` `\item` `itemize` `enumerate` `description` `center` `\refname` (apps/web/constants/resume-templates/deedy-cv.ts:208); `letter` is used only as a base, with no `\opening` `\closing` or `letter` environment (sid-lacy-cover-letter.ts:40-94)

## Component map
Paths: CLS = apps/ai/compiler/src/compiler/; CT = apps/web/constants/cover-letter-templates/; RT = apps/web/constants/resume-templates/; CF = apps/web/configs/.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class (Deedy letter, CV) | CT deedy-cover-letter.ts:4; RT deedy-cv.ts:13; CLS cover.cls:5-9; CLS deedy-resume-openfont.cls:5-9 | `class.article` | zip-local wrapper: all options forwarded to article, `print` is a dead flag (cover.cls:4) |
| class (Jake, Sourabh, Rover, Entry, defaults) | RT jakes-resume.ts:9; RT base-rover.ts:14; CT entry-level-cover-letter.ts:17; CF default-cover-letter-latex.ts:1 | `class.article` | letterpaper,11pt / 11pt / 11pt,a4 / none |
| class (Sid Lacy) | CT sid-lacy-cover-letter.ts:6 | `class.letter` | 12pt |
| paper/size options | RT jakes-resume.ts:9; CT entry-level-cover-letter.ts:17; CT sid-lacy-cover-letter.ts:6 | `page.class-options` | letterpaper, 11pt, 12pt |
| page geometry | CLS cover.cls:12; CLS deedy-resume-openfont.cls:12; RT base-rover.ts:16; CT entry-level-cover-letter.ts:41; CF default-cover-letter-latex.ts:2 | `page.geometry` | cover hmargin=2.54cm vmargin=2.54cm; CV hmargin=1.25cm vmargin=0.75cm; Rover margin=1in,a4paper; Entry margin=1cm; default margin=1in |
| page (legacy) | RT jakes-resume.ts:12; RT sourabh-bajaj-resume.ts:12; CT entry-level-cover-letter.ts:21; CT sid-lacy-cover-letter.ts:8 | `page.vmargin` | `fullpage` with option `empty` |
| page lengths | RT jakes-resume.ts:44-48; RT sourabh-bajaj-resume.ts:29-33; CT sid-lacy-cover-letter.ts:15-16 | `page.setlength` | oddsidemargin/evensidemargin -0.5in (Sourabh -0.375in), textwidth +1in, topmargin -.5in, textheight +1.0in (Sid: topmargin -0.5in, textheight +1.0in) |
| side-by-side blocks | RT deedy-cv.ts:43,128-129; CT deedy-cover-letter.ts:25,34; RT base-rover.ts:31,37; CT entry-level-cover-letter.ts:86,90,96 | `cols.minipage` | CV 0.33/0.66 `\textwidth` top-aligned; letter 0.5/0.49; Rover 0.5/0.4; Entry 0.24/0.5/0.24 bottom-aligned |
| columns (load-only) | CT entry-level-cover-letter.ts:28 | `cols.multicol` | package loaded, no environment used |
| absolute date block | CLS cover.cls:16,36-43; CLS deedy-resume-openfont.cls:32,34-39 | `pg.textpos` | `absolute`; `\TPHorizModule`=`\TPVertModule`=1mm; `textblock{60}(155,5)` |
| bottom flush | RT jakes-resume.ts:52; RT sourabh-bajaj-resume.ts:37; CT entry-level-cover-letter.ts:60 | `pg.flush` | `\raggedbottom` |
| header/footer | CT deedy-cover-letter.ts:5-12; RT deedy-cv.ts:14-17; RT jakes-resume.ts:19,37-41; RT sourabh-bajaj-resume.ts:19,22-26; CT entry-level-cover-letter.ts:27,50-54,67 | `hf.fancyhdr` | `\fancyhf{}`; letter `\rfoot{Page \thepage \hspace{1pt}}`; head/foot rules 0pt; Entry `\rfoot` in colour HF_color: page "of 1, Updated" `\today` |
| page style switches | CT deedy-cover-letter.ts:11; RT base-rover.ts:25 | `hf.pagestyle-kernel` | `\thispagestyle{empty}`; `\pagestyle{empty}` |
| paragraph lengths | CT entry-level-cover-letter.ts:107-108; CT sid-lacy-cover-letter.ts:73; CLS cover.cls:86 | `sp.lengths` | parindent 0pt/24pt, parskip 12pt, itemsep 1pt, parsep 0pt |
| alignment | CLS cover.cls:47,52,67,78,82,90-101; RT jakes-resume.ts:53; CT entry-level-cover-letter.ts:37,106; RT base-rover.ts:38 | `sp.ragged` | `\raggedright` `\centering` `\raggedleft` `\justify` (`ragged2e`), `center` and `flushright` environments |
| setspace (load-only) | CT entry-level-cover-letter.ts:34 | `sp.setspace` | package loaded, no command used |
| rules | CLS cover.cls:55; CT entry-level-cover-letter.ts:72,103; CT sid-lacy-cover-letter.ts:45 | `sp.rule` | `\rule{\paperwidth}{0.0pt}` (invisible), `\hrulefill`, Sid band `\rule[-1.3in]{\paperwidth}{1.3in}` |
| manual spacing | CLS cover.cls:51,56,63,92; CT deedy-cover-letter.ts:23,64,67; RT base-rover.ts:34 | `sp.manual-space` | `\vspace`, `\hfill`, `\\[5pt]`, `\mbox{}\\`, `\medskip` |
| width box | CLS cover.cls:55 | `box.fancybox` | kernel `\makebox[\linewidth]{...}` (no frame drawn); kernel box family |
| fonts (main, sans, per span) | CLS cover.cls:31-33,49-50; CLS deedy-resume-openfont.cls:27-29; CT entry-level-cover-letter.ts:35,44-47 | `font.fontspec` | `Path=OpenFonts/fonts/lato/`, main Lato-Lig, BoldFont Lato-Reg, ItalicFont Lato-LigIta, BoldItalicFont Lato-RegIta, Color=primary; sans Raleway-ExtraLight Scale=MatchLowercase Mapping=tex-text; `\fontspec[Path=..]{Lato-Hai}` as span switch; Entry: SourceSansPro-Regular.otf with Semibold and RegularIt (not shipped) |
| XeTeX support packages | CLS cover.cls:17 | `font.fontspec` | `xltxtra`, `xunicode` loaded beside fontspec, no options (package is the parameter; load-only) |
| font sizes | CLS cover.cls:41,48,54,67,71,74,78,82,90; CT entry-level-cover-letter.ts:33,38,92,94; CT sid-lacy-cover-letter.ts:50 | `font.size-commands` | `\fontsize{40pt}{60pt}`, 16/24, 12/12, 11/13, 10/12, 8/10, Sid 28/0; `\Huge` `\Large`; `moresize[11pt]` and `anyfontsize` loaded (size-command packages) |
| encoding | CT sid-lacy-cover-letter.ts:7 | `font.fontenc-t1` | `inputenc` utf8 |
| text face | CT sid-lacy-cover-letter.ts:13 | `font.charter` | `charter` |
| text face | CF default-cover-letter-latex.ts:3 | `font.mathptmx` | `times` |
| icons / symbols | CT sid-lacy-cover-letter.ts:11,52-55; RT jakes-resume.ts:14; RT sourabh-bajaj-resume.ts:14; CT entry-level-cover-letter.ts:23 | `font.icons` | fontawesome5 `\faEnvelope` `\faLinkedinIn` `\faPhone` `\faMapMarker`; `marvosym` load-only |
| colours (named) | CLS cover.cls:14,24-28; CLS deedy-resume-openfont.cls:20-24 | `color.xcolor` | `usenames,dvipsnames`; HTML colours date 666666, primary 2b2b2b, headings 6A6A6A, subheadings 333333 |
| colours (legacy) | RT jakes-resume.ts:15; RT sourabh-bajaj-resume.ts:15; CT entry-level-cover-letter.ts:24,65-66; CT sid-lacy-cover-letter.ts:17 | `color.color` | `usenames,dvipsnames`; RGB UI_blue 32,64,151; HF_color 179,179,179; gr 225,225,225 (Sid loads no colour package in the preamble, line 17; an emitter adds one) |
| header band | CT sid-lacy-cover-letter.ts:12,43-46 | `bg.eso-pic` | `\AddToShipoutPictureBG{\color{gr}\AtPageUpperLeft{\rule[-1.3in]{\paperwidth}{1.3in}}}` |
| language | RT jakes-resume.ts:20 | `lang.babel` | english |
| quotes (load-only) | CT entry-level-cover-letter.ts:30 | `lang.csquotes` | package loaded, unused |
| links | CLS cover.cls:13; CLS deedy-resume-openfont.cls:13; RT jakes-resume.ts:18; RT sourabh-bajaj-resume.ts:18; CT entry-level-cover-letter.ts:26,29,32; CT sid-lacy-cover-letter.ts:9; CT deedy-cover-letter.ts:17-19 | `meta.hyperref` | `hidelinks`; Sourabh `pdftex`; Entry `\hypersetup{colorlinks=true,urlcolor=black}`; `\href` in body |
| url style | CT deedy-cover-letter.ts:17; RT jakes-resume.ts:50; RT sourabh-bajaj-resume.ts:35; CT entry-level-cover-letter.ts:57 | `meta.url` | `\urlstyle{same}` |
| text-extraction map | RT jakes-resume.ts:22,62 | `meta.glyphtounicode` | `\input{glyphtounicode}` then `\pdfgentounicode=1` |
| date line | CT deedy-cover-letter.ts:35; CT entry-level-cover-letter.ts:119; CT sid-lacy-cover-letter.ts:61; CLS deedy-resume-openfont.cls:33 | `front.datetime` | kernel `\today`; `isodate[UKenglish]` loaded in the CV class (the `\today` line is commented out at deedy-resume-openfont.cls:38, so load-only) |
| name/contact block | CT deedy-cover-letter.ts:17-19; RT deedy-cv.ts:33-35; RT jakes-resume.ts:115-120; CT entry-level-cover-letter.ts:85-104; CT sid-lacy-cover-letter.ts:49-56 | `font.fontspec` `font.size-commands` `sp.ragged` `color.xcolor` `sp.rule` `box.fancybox` `sp.manual-space` | `\namesection` expands to these (cover.cls:46-57); others are `center` + `\Huge`/`\scshape` text |
| section headings | CLS cover.cls:15,61-62,66-67; RT jakes-resume.ts:57-59; RT sourabh-bajaj-resume.ts:42-44; CT entry-level-cover-letter.ts:70-72; RT base-rover.ts:18-22 | `head.titlesec` | cover `\titleformat{\section}{\color{headings}\scshape ... Lato-Lig 16/24 \raggedright\uppercase}{}{0em}{}` `\titlespacing 0pt 0pt 0pt`; subsection Lato-Bol 12/12 bfseries uppercase (cover.cls:70-71); Jake/Sourabh `\scshape\raggedright\large` + `\titlerule`; Entry colour UI_blue + `\hrulefill`; Rover `\large\bfseries\uppercase` + `\titlerule`, `\titleformat*{\subsubsection}{\large\itshape}`, `\titlespacing{\subsection}{0pt}{*0}{*0}` |
| numbering | RT base-rover.ts:17 | `num.secnumdepth` | `\setcounter{secnumdepth}{0}` |
| lists | CLS cover.cls:85-87; RT jakes-resume.ts:96,100-101; RT sourabh-bajaj-resume.ts:64,68-69; RT base-rover.ts:49,76,84 | `list.kernel` | `itemize` `enumerate` `description`; `\labelitemii` small bullet / `$\circ$`; `tightemize` = itemize with `\itemsep1pt \parskip0pt \parsep0pt` and `\vspace{-\topsep}` |
| list options | RT jakes-resume.ts:17,98,208; RT sourabh-bajaj-resume.ts:17,66; RT base-rover.ts:23-24,76,84; CT entry-level-cover-letter.ts:36 | `list.enumitem` | `[leftmargin=0.15in, label={}]`; `[leftmargin=*]`; `\setlist[itemize]{noitemsep,left=0pt .. \parindent}`; `[label=\null, left=0pt..0pt, itemsep=0pt]`; `[itemsep=0pt]`; `inline` |
| tables | RT deedy-cv.ts:193-200; RT jakes-resume.ts:54,74-77; RT sourabh-bajaj-resume.ts:39,56,78-81; CT deedy-cover-letter.ts:69-72; CT entry-level-cover-letter.ts:62 | `tbl.tabular` | `tabular{rll}`; `tabular*{0.97\textwidth}[t]{l@{\extracolsep{\fill}}r}`; `\tabcolsep` 0in; `tabular{c}` around the signature image |
| tables (load-only) | RT jakes-resume.ts:21; CT entry-level-cover-letter.ts:31 | `tbl.tabularx` | package loaded, no `tabularx` used |
| inline marks | RT deedy-cv.ts:74,103,113-114,195; RT jakes-resume.ts:116-117 | `mark.kernel` | `\textbf` `\textit` `\scshape` `\bf` `\underline` `\textbullet` `\textsuperscript` `\LaTeX` `\footnotesize` |
| image | CT deedy-cover-letter.ts:70; CT sid-lacy-cover-letter.ts:10,88 | `fig.graphicx` | `\includegraphics[width=4cm]{signature}`; Sid `width=1.5in`, `graphicx` loaded; cover.cls loads no graphicx itself (presumably via xltxtra; not verified) |
| bibliography | RT deedy-cv.ts:207-211; CLS cover.cls:21; RT deedy-cv.ts:208 | `bib.bibtex-bst` | `\bibliographystyle{abbrv}`, `\bibliography{publications}`, `\nocite{*}`, `\renewcommand\refname{\vskip -1.5em}` (heading-name override; `publications.bib` not shipped) |
| citation ordering | CLS cover.cls:20; CLS deedy-resume-openfont.cls:16 | `bib.cite-pkg` | `cite` loaded, no options |
| symbols (load-only) | RT jakes-resume.ts:11; RT sourabh-bajaj-resume.ts:11; CT entry-level-cover-letter.ts:20 | `math.amssymb` | `latexsym` loaded, no symbol used (symbol-font package is the parameter) |
| verbatim (load-only) | RT jakes-resume.ts:16; RT sourabh-bajaj-resume.ts:16; CT entry-level-cover-letter.ts:25 | `code.verbatim` | `verbatim` loaded, unused |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `cover` class as a whole | apps/ai/compiler/src/compiler/cover.cls:1-101 | yes | `class.article` + `page.geometry` + `meta.hyperref` + `color.xcolor` + `head.titlesec` + `pg.textpos` + `font.fontspec` + `bib.cite-pkg`; macros inlined (rows below). Also `\ProvidesClass{deedy-resume-openfont}` at line 2 names a different class than the file (warning only) |
| `deedy-resume-openfont` class as a whole | apps/ai/compiler/src/compiler/deedy-resume-openfont.cls:1-84 | yes | same ways with `page.geometry` hmargin=1.25cm vmargin=0.75cm, `front.datetime` (isodate, load-only); `\lastupdated` body empty (line 38 commented); `\namesection` has a 0.4pt rule and `\vspace{-15pt}` (lines 51-52) |
| option plumbing, `\@cv@print` | cover.cls:4-8 | yes | emitter writes `\documentclass[opts]{article}`; the `print` flag is set but never read |
| `\lastupdated` | cover.cls:40-43; deedy-resume-openfont.cls:36-39 | yes | `pg.textpos` textblock{60}(155,5) + `color.xcolor` date + `\fontspec[Path=OpenFonts/fonts/raleway/]{Raleway-ExtraLight}` + `\fontsize{8pt}{10pt}` + text with `\today` |
| `\namesection{first}{last}{line}` | cover.cls:46-57 | yes | `\centering` + `\fontsize{40pt}{60pt}` + Lato-Hai first, Lato-Lig last; `\\[5pt]`; colour headings + Raleway-Medium 11/14 for the line; `\makebox[\linewidth]{\color{headings}\rule{\paperwidth}{0.0pt}}`; `\vspace{0pt}` |
| `\sectionsep` `\runsubsection` `\descript` `\location` | cover.cls:63,73-74,77-78,81-82 | yes | `\vspace{8pt}`; Lato-Bol 12/12 `\bfseries\uppercase` in subheadings colour; Raleway-Medium 11/13 `\scshape` + `\raggedright`; Raleway-Medium 10/12 in headings colour |
| `tightemize` environment | cover.cls:85-87; deedy-resume-openfont.cls:81-83 | yes | `\newenvironment` over `itemize` with `\itemsep1pt \parskip0pt \parsep0pt`, `\vspace{-\topsep}` around (`list.kernel`, `sp.lengths`, `sp.manual-space`) |
| letter macros `\companyname` `\companyaddress` `\currentdate` `\lettercontent` `\closing` `\signature` | cover.cls:90-101 | yes | each is `\raggedright`/`\raggedleft` + `\fontspec[Path=..]{Lato-Bol or Raleway-Medium}` + `\fontsize` (12/14 or 11/13) + `{#1 \\}` + optional `\mbox{}\\` blanks; font and alignment leak to the end of the enclosing group, so inlining at each use gives the same state |
| `\refname` overrides | cover.cls:21; deedy-resume-openfont.cls:17; deedy-cv.ts:208 | yes | kernel `\renewcommand` of the bibliography heading name to `\vskip -1.5cm` / `-1.5em` (`bib.bibtex-bst` parameter, `sp.manual-space`) |
| Jake resume commands | apps/web/constants/resume-templates/jakes-resume.ts:66-101 | yes | `\resumeSubheading` = `\item` holding `tabular*{0.97\textwidth}[t]{l@{\extracolsep{\fill}}r}` with `\textbf`/`\textit\small` rows and `\vspace`; list wrappers = `list.enumitem` `[leftmargin=0.15in, label={}]`; `\labelitemii` = tiny `\bullet` label |
| Sourabh resume commands | apps/web/constants/resume-templates/sourabh-bajaj-resume.ts:48-69 | yes | same pattern: `tabular*{0.97\textwidth}`, `\textbf{#1}{: #2}` items, `[leftmargin=*]`, `\labelitemii` = `$\circ$` |
| Sid Lacy info macros | apps/web/constants/cover-letter-templates/sid-lacy-cover-letter.ts:23-38 | yes | `\newcommand` text constants (name, e-mail, company, address); values substituted into the body |

## Content-opaque
- `\includegraphics{signature}` images (deedy-cover-letter.ts:70, sid-lacy-cover-letter.ts:88; file apps/web/public/signature.png is in the zip) are content.
- `publications.bib` read by `\bibliography{publications}` (apps/web/constants/resume-templates/deedy-cv.ts:210) is not in the zip (missing asset). The compile wrapper runs a single compiler pass (xelatex or pdflatex, no bibtex call; apps/ai/compiler/src/compiler/service.py:130-146), so the list stays empty there.
- Entry-level letter needs `SourceSansPro-Regular.otf`, `-Semibold.otf`, `-RegularIt.otf` (entry-level-cover-letter.ts:44-47), not shipped. The Lato and Raleway files named by both classes are shipped under apps/ai/compiler/src/compiler/OpenFonts/fonts/.
- Text after `\end{document}` (`\documentclass[]{article}`, deedy-cover-letter.ts:77, deedy-cv.ts:214) is ignored by TeX.

## Lib changes
- New ways proposed: `meta.glyphtounicode` `\input{glyphtounicode}` (TeX Live, pdfTeX distribution) + `\pdfgentounicode=1`, pdfTeX/pdfLaTeX (not XeTeX; engine tag `pdf`): fills the PDF text-extraction (ToUnicode) map so text copies and parses cleanly (used for ATS-parsable PDFs). W1: file and primitive are documented in the pdfTeX distribution. W2: an integer switch (plus optional `\pdfglyphtounicode{name}{code}` entries), no code to edit. W3: any document wanting searchable PDF text, not one template. W4: two preamble lines (apps/web/constants/resume-templates/jakes-resume.ts:22,62). No existing `meta.*` line fits (`meta.hyperxmp` is XMP metadata, `meta.pdfx` is PDF/A, `meta.documentmetadata` is the kernel `\DocumentMetadata` keys).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
