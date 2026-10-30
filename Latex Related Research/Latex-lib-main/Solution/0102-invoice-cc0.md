no

# 0102-invoice-cc0: Invoice (CC0)

- Unverified: read from the source, not compiled.
- Source: Source/0102-invoice-cc0/ (origin: https://latextemplates.com/downloads/invoice-cc0.zip; licence: CC0-1.0, LICENSE:1 "CC0 1.0 Universal", manifest `CC0-1.0`)
- Kind: invoice
- Lib: v2
- Engine: needs XeLaTeX (the `fontspec` branch main.tex:27-54 is taken under XeLaTeX or LuaLaTeX, tested by `\ifxetex`/`\ifluatex` at main.tex:20-25; under pdfLaTeX the fallback at main.tex:56-66 drops the custom fonts and uses the default serif, so the intended look is the XeLaTeX/LuaLaTeX one)
- Look carried by: preamble (the zip is one `main.tex` plus README and LICENSE; no zip-local class or style; the look is the preamble at main.tex:13-133 plus hand-built boxes in the body at main.tex:137-213)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
No, on one blocker. The page is a kernel `article` with published packages (`geometry`, `fontspec`, `hyperref`, `xcolor[table]`, `longtable`, `multicol`, `footmisc`) and a hand-laid header from `\parbox`, `\colorbox` and `minipage`; all of that maps to lib ways, and there is no TikZ, `picture` or other `ART`. But the preamble redefines the kernel footnote-text hook `\renewcommand\@makefntext` (main.tex:129-132) with internals (`\hb@xt@`, `\@textsuperscript`, `\@thefnmark`) to set a 1.8em right-aligned grey mark. `fn.footmisc` (`hang`, `\footnotemargin`) does not colour or right-align the mark, so no lib way expresses it and the rubric names this kind of kernel-internal redefinition irreducible. The same call was made for `\@makefntext` in 0077-gi-ev-lni and 0088. Everything else reduces; the footnote hook is small, so the answer is close to a `yes`.

## Blockers
- `BESPOKE/preamble` kernel hook `\@makefntext` redefined: `\parindent 1em\noindent`, a `\hb@xt@1.8em{\hss\@textsuperscript{\normalfont\color{footnotegray}\@thefnmark}}` mark box, then the note text (main.tex:128-133; used by the one footnote at main.tex:194)

## Class setting
- Class: `class.article` options: `a4paper` (main.tex:13). Kernel class, not in the zip, source not read.
- Class-native vocabulary used: none of `\maketitle`, `abstract`, `\section`, bibliography. `\title{Invoice}` and `\date{\today }` are set (main.tex:72-73) but `\maketitle` is never called; the title is printed by hand through the alias `\thetitle` (main.tex:87, 178).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:13 | `class.article` | a4paper |
| paper size | main.tex:13 | `page.class-options` | a4paper |
| page geometry | main.tex:15 | `page.geometry` | top=1.5cm, bottom=1.5cm, left=2cm, right=2cm |
| main font | main.tex:28-36 | `font.fontspec` | `\defaultfontfeatures{Ligatures=TeX}`; `\setmainfont` LinuxLibertineO with BoldFont=LinLibertineOZ, BoldItalicFont=LinLibertineOZI, SmallCapsFont=LinLibertineO, SmallCapsFeatures={Letters=SmallCaps}. Font files are not in the zip. |
| display font (company name) | main.tex:40-44, used 137 | `font.fontspec` | `\newfontfamily\displayFont`, LinLibertine_DR, Extension=.otf, bold and italic mapped to the same file ("fake") |
| spaced font (unused) | main.tex:38 | `font.fontspec` | `\newfontfamily\spacedFont[LetterSpace=2.0]{LinuxLibertineO}`; never called in the body (grep) |
| sans font (footnote text) | main.tex:46-52, used 124 | `font.fontspec` | `\setsansfont` LinBiolinum_R, Extension=.otf, bold LinBiolinum_RB, italic LinBiolinum_RI, small caps via Letters=SmallCaps |
| mono font (labels) | main.tex:54, used 149, 159, 178 | `font.fontspec` | `\setmonofont[Extension=.otf]{Inconsolata}`, reached through `\ttfamily` |
| PDF metadata | main.tex:90 | `meta.hyperref` | pdfencoding=auto, unicode, bookmarks=false, colorlinks=false, pdfborder={0 0 0}, pdftitle, pdfauthor, pdfsubject, pdfkeywords |
| header and footer | main.tex:91 | `hf.pagestyle-kernel` | `\pagestyle{empty}` |
| colours | main.tex:92, 114-117 | `color.xcolor` | `xcolor[table]`; `\colorlet` headcolor=gray!21, tablecolor1=gray!4, tablecolor2=gray!11, footnotegray=gray!90 |
| header block: name and tagline, "Invoice" word | main.tex:137-155 | `cols.minipage` | two adjacent `\parbox[b][2cm][t]` (widths `\rightalignment` = 11cm, and 0.35\textwidth), no gap between them (`%` at 147) |
| header block inner layout | main.tex:137-155, 157, 159-160, 162, 175 | `sp.manual-space` | `\vbox to 1cm{\vss ...}` bottom-aligns one line, `\kern -1mm`, `\kern -5mm`, `\leavevmode\kern \rightalignment`, `\vskip 3mm`, `0.7cm`, `2.3cm`: literal glue; see Bespoke code |
| header text sizes and colour | main.tex:137, 144, 150 | `font.size-commands` | `\fontsize{1.5cm}{1.5cm}\selectfont` (twice), `\fontsize{0.44cm}{0.5cm}`; colour `\color{gray!95}` (`color.xcolor`) |
| header emphasis and mono | main.tex:145, 149, 159 | `mark.kernel` | `\emph` on the tagline; `\ttfamily` (family switch) on the word and the number block; `N\textsuperscript{o}` |
| number and date block | main.tex:159-160 | `box.minipage` | `\parbox{0.35\textwidth}{\ttfamily N\textsuperscript{o} \invoicenum\\ \today }` |
| dark recipient block | main.tex:164-173 | `box.fancybox` | `\colorbox{gray!85}{...}` (xcolor's box, sibling of `\fcolorbox`), `\kern -3mm` before it |
| recipient block inner box | main.tex:165-172 | `box.minipage` | `minipage[t]{0.5\textwidth}`, `\color{white}`, `\vskip 2mm`, `\vspace*{-3mm}` at the end |
| centred title and rule | main.tex:177-181 | `sp.ragged` | `center` environment; `{\ttfamily\LARGE \thetitle}` (`mark.kernel`, `font.size-commands`) |
| rule under title | main.tex:180 | `sp.rule` | `\rule{2cm}{0.25pt}` |
| item table | main.tex:184-195 | `tbl.longtable` | `longtable`, column spec `{@{}p{0.55\textwidth}rrr@{}}`; no `\endhead` or `\endfoot` |
| item table column spec and height | main.tex:183-184 | `tbl.tabular` | `array` preamble `@{}` `p{}` `r`; `\renewcommand{\arraystretch}{1.4}` |
| item table stripes | main.tex:185-194 | `tbl.colortbl` | `\rowcolor`: headcolor on header and total rows, tablecolor1/tablecolor2 alternating on the three item rows |
| table cell emphasis | main.tex:186, 194 | `mark.kernel` | `\textbf` on header cells and grand total |
| footnote command | main.tex:194 | `fn.kernel` | one `\footnote` inside a longtable cell, text through `\footnotestyle` |
| footnote rule | main.tex:108 | `fn.footmisc` | `\usepackage[norule]{footmisc}` (removes the rule) |
| footnote text mark | main.tex:128-133 | none (blocker) | `\@makefntext` redefinition, see Blockers and Bespoke code |
| vertical fill | main.tex:197 | `sp.manual-space` | `\vfill` pushes the contact block and terms to the page foot |
| contact block size | main.tex:199 | `font.size-commands` | `\small` (and a nested `{\small (APE 4791B)}` at 204) |
| contact block columns | main.tex:201-211 | `cols.multicol` | `\setlength{\columnsep}{1.5cm}` (`sp.lengths`), `multicols{2}` |
| contact label alignment | main.tex:207-210 | `sp.manual-space` | `\hbox to 1cm{Tél\,:\hss}` (and Mél, IBAN, BIC): fixed-width left-aligned label |
| payment terms line | main.tex:213 | `mark.kernel` | `\footnotestyle{\textbf{Payment terms:} \conditions }`: `\textsf`, `\fontsize{3mm}{0mm}`, grey (see Bespoke code) |
| title and date storage | main.tex:72-73 | `front.maketitle` | `\title{Invoice}`, `\date{\today }`; `\maketitle` is not called, so only the stored title is used |

Not defined or not used: no `babel` or `polyglossia` (the French words Tél, Mél, SIREN, "art. 293 B du CGI" at main.tex:194, 206-209 are typed content), no sectioning, lists, math, theorems, figures or float captions, code, bibliography, index, cross-references, page numbers, header text.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\newif\ifmodernTeX` with `\ifluatex`/`\ifxetex` from the `ifluatex`, `ifxetex` packages | main.tex:16-25 | yes | An engine switch with no document data in it: the emitter targets XeLaTeX and writes the `font.fontspec` branch (27-54); the pdfLaTeX branch is a fallback with the default fonts. The two helper packages are CTAN compatibility wrappers (read from memory, not re-read). |
| `\let\spacedFont\relax`, `\let\displayFont\relax` | main.tex:63-64 | yes | Only used on the pdfLaTeX path to make the fontspec switches no-ops; dropped when the XeLaTeX branch is emitted. |
| `\xdef` data macros `\invoicenum` `\companyname` `\companyaddress` `\companysiren` `\companytel` `\companyemail` `\bankiban` `\bankbic`, `\long\xdef\conditions` | main.tex:74-84 | yes | Plain strings (content), used at 140, 159, 203-210, 213; inline the text or keep as `\newcommand` aliases. |
| `\makeatletter \let\thetitle\@title` | main.tex:86-88 | yes | An alias to the stored title (the word "Invoice"); replace by the literal text at main.tex:178. |
| `\xdef\rightalignment{11cm}` | main.tex:120 | yes | A length held in a macro (`sp.lengths`, `sp.manual-space`); write 11cm at 137, 159, 164. |
| `\def\footnotestyle#1` | main.tex:123-125 | yes | `\textsf` (`mark.kernel`) + `\color{footnotegray}` (`color.xcolor`) + `\fontsize{3mm}{0mm}\selectfont` (`font.size-commands`) around the argument. The 0mm baseline is as written; its effect on a multi-line argument (the payment terms at 213) was not checked. |
| `\renewcommand\@makefntext` | main.tex:128-133 | no | Kernel footnote-text hook rewritten with internals. `fn.footmisc` covers the hanging indent (`hang` with `\footnotemargin`) but not the right-aligned `\hss` mark nor the grey colour. Considered: `scrextend` (`\deffootnote`, a footnote-label font element); not proposed, because its mark alignment and colour hook were not read and no lib way for it exists. BESPOKE/preamble. |
| Box and glue primitives `\vbox to 1cm{\vss ...}`, `\kern`, `\vskip`, `\hbox to 1cm{...\hss}`, `\leavevmode` | main.tex:137-173, 207-210 | yes, with a rewrite | Literal-length positioning of fixed content, no computed layout. Kernel equivalents: `\vbox to h{\vss X}` as `\parbox[b][h][b]{...}{X}`, `\kern` as `\hspace`, `\vskip` as `\vspace`, `\hbox to 1cm{X\hss}` as `\makebox[1cm][l]{X}`. The vertical result of the `\vbox` rewrite was not checked. |

## Content-opaque
none (no figure, tikz picture or image; the company, recipient, item rows, amounts, bank details and terms at main.tex:75-84, 168-170, 188-194, 203-213 are text content). Missing assets: Linux Libertine O, Linux Biolinum and Inconsolata font files are referenced by file name (main.tex:31-54) and not shipped; ship them or name TeX Live's copies.

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
