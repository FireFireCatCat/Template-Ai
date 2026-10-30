yes

# 0385-scrjrnl: scrjrnl (diary and journal class on scrbook)

- Unverified: read from the source, not compiled.
- Source: Source/0385-scrjrnl/ (origin: https://mirrors.ctan.org/macros/latex/contrib/scrjrnl.zip; licence: LPPL 1.3, scrjrnl.dtx:5-11, manifest lppl1.3)
- Kind: misc (a personal diary or devotional journal book of dated entries, not an academic journal; manifest category journ-personal)
- Lib: v4
- Engine: pdfLaTeX-compatible (the class loads no fontspec and no Lua code, scrjrnl.dtx:210-224, 268; only the manual's driver needs XeLaTeX or LuaLaTeX because of fontspec, scrjrnl.dtx:35-36; both PDFs in the zip have Producer LuaTeX-1.21.0)
- Look carried by: class (scrjrnl itself defines the month and day heading looks, the side tabs and the date labels; the zip holds no sample preamble)
- Class origin: ctan
- Main file: scrjrnl.dtx (there is no .tex sample; its DocStrip driver at 32-47 is the only `\documentclass` and `\begin{document}`, and it is the manual's driver on `ltxdoc`, not a use of the class) (other samples: example.pdf, compiled output only, its .tex source is not shipped)
- Read: main yes (no .tex sample exists; the .dtx that stands in for it was read whole, 461 lines, and the .ins, 59 lines; example.pdf and scrjrnl.pdf were read as data by decoding their text, positions and fonts), zip-local classes and styles all (none is shipped as a .cls or .sty: scrjrnl.cls is generated from the .dtx by scrjrnl.ins:40-42, and the .dtx source was read in full)

## Verdict
yes. The zip is the CTAN release of the class `scrjrnl` (ctan.org/pkg/scrjrnl read: a CTAN package, v0.2, LPPL 1.3, in TeX Live and MiKTeX), so it passes W1 and is one way, `class.scrjrnl`. Its behaviour is chosen by class options, `journal` environment keys, `\jrnlmonth` and `\jrnlday` keys, two lengths and two font hooks (W2); it serves any diary, journal or devotional book (W3); an emitter prints it as `\documentclass[...]{scrjrnl}`, a `journal` wrapper and one `\jrnlmonth` or `\jrnlday{title}` call per node (W4). Every dependency it loads (`scrbook`, `titlesec`, `fancytabs` on TikZ, `datetime`) is published. The verdict rests on that class-as-way ruling: if the class were read as zip-local, its counter logic (scrjrnl.dtx:282-286, 299-348) and in-environment heading formats (382-453) would have to be reduced instead.

## Blockers
none

## Class setting
- Class: `class.scrjrnl` options: `monthpages`, `fancytabs`, `cleardaypages`; base-class switch `scrbook` (default), `scrartcl`, `scrreprt`; every other option goes to the base class (scrjrnl.dtx:211-223). Compiled evidence for the options the example used: month pages and rotated side tabs on odd pages (example.pdf p3, p5), 11pt body (10.909 pt text, example.pdf p1).
- Class-native vocabulary used: environment `journal[startmonth, startday, bleed]` (dtx:377-382); `\jrnlmonth[month, startday]` (300-303); `\jrnlday[day, ante, post]{title}` (329-333); hooks `\dayheadfont` `\monthheadfont` (355-356) and `\jrnlformatdate` `\jrnlformatindexdate` (231-232); lengths `\jrnldaysepskip` `\jrnldayafterskip` (258-261); counters `jrnlday` `jrnlmonth` `jrnlyear` `jrnltotalday` (283-286); per-day macros `jrnldaydate<n>` (344-346).
- Not defined by the zip (the example's .tex is not shipped): text-block margins, fonts (example.pdf embeds Latin Modern faces only), page style, babel language (French month names in example.pdf p3, p9). The class defines no title page, abstract, lists, theorems, floats, tables, code, bibliography or index of its own.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | scrjrnl.dtx:210-223 | `class.scrjrnl` | options `monthpages` (216-217), `fancytabs` (218-219), `cleardaypages` (220-221); base switch `scrbook` default (213, 215), `scrartcl` (211), `scrreprt` (212); rest forwarded (214) |
| base class | scrjrnl.dtx:213, 215, 223; README:1 | `class.scrbook` | `\LoadClass{\jrnl@class}`; KOMA vocabulary inherited, manual says so (dtx:84-88) |
| paper size, font size | example.pdf MediaBox 450x666 bp on every page, p1 printout; dtx:405, 420 | `page.class-options` | paper 6.25in x 9.25in including bleed, inferred from the MediaBox and from p1 (paperheight 668.4975pt, bleed 9.03374pt = 0.125in); body 11pt; the class only reads `\paperheight` and `\paperwidth`, the command in the example source is not known (could also be `page.geometry`) |
| journal environment | scrjrnl.dtx:382-453 | `head.class-native` | keys `startmonth` (377), `startday` (378), `bleed` length (379-380); begin code sets the chapter and section formats below for the rest of the body (390-394, 442-450) |
| month heading | scrjrnl.dtx:303-319, 368, 390-394 | `head.class-native` | `\jrnlmonth[month=1..12, startday=n]` (300-301); with `monthpages`: `\chapter{month name}` then `\cleardoublepage` (311-312), else only `\refstepcounter{chapter}` and a contents entry through `\addchaptertocentry` (314-316); format `[block]`, before `\vfill`, text `\filcenter\monthheadfont\Huge\textsc`, after `\vfill\vfill` (390-394, 368); month name `\monthname[n]` (275-276); example.pdf p3: month in 24.79 pt small caps, centred |
| day heading | scrjrnl.dtx:333-348, 363-366, 442-450 | `head.class-native` | `\jrnlday[day=n, ante=text, post=text]{title}` (329-331, 333); `\newpage\section{title}` (342); titlesec `[display]`: format `\filcenter\dayheadfont\huge` (364), label `\raggedright\normalfont\scshape\Large` + ante + date + post + `\\` (365-366), sep `\jrnldaysepskip` (445), before `\jrnl@fancytab\jrnl@titlestrut\filcenter` (446-447), after `\vspace{\jrnldayafterskip}` (448); `\titlespacing{\section}{0pt}{*}{-3pt}` (450); example.pdf p5, p7: date label 14.35 pt small caps top left, title 20.66 pt below it, ante "Journée du" and post ", soir" visible on p7 |
| heading lengths | scrjrnl.dtx:258-261 | `sp.lengths` | `\setlength{\jrnldaysepskip}{0pt}` (default), `\setlength{\jrnldayafterskip}{2\baselineskip}` (default); the user resets them with `\setlength` |
| heading font hooks | scrjrnl.dtx:355-356, 364-368 | `mark.kernel` | `\dayheadfont` and `\monthheadfont` are empty `\newcommand`s the user fills with kernel font switches (`\scshape`, `\normalfont`, `\textsc` are the class's own, 365, 368) |
| heading sizes | scrjrnl.dtx:364-368 | `font.size-commands` | `\huge` day title, `\Large` date label, `\Huge` month name (example.pdf sizes 20.66, 14.35, 24.79 pt match an 11pt base) |
| title strut | scrjrnl.dtx:363 | `sp.rule` | `\vrule height 25pt width0pt` inside the day heading's before-code |
| entry page breaks | scrjrnl.dtx:312, 339-342 | `pg.break` | `\newpage` before every entry (342); option `cleardaypages`: `\cleardoublepage` if `openright` else `\clearpage` (339-341); month page `\cleardoublepage` (312) |
| side tabs | scrjrnl.dtx:105-108, 268, 396-450 | `hf.class-native` | option `fancytabs`, key `bleed`; the class loads CTAN `fancytabs` (268) and sets its lengths from `\paperheight`, `\paperwidth`, bleed: gap = (paperheight - 2 bleed)/75, height = 10 gap, top = 5 gap + 2 bleed, width = paperwidth/12 + bleed, `\fancytabsTextVPos{0.5}` (403-431); `\fancytab{month name}{month number}` on odd pages only (433-437), called in the day heading (446); example.pdf p1 prints gap 8.6724pt for paperheight 668.4975pt and bleed 9.03374pt, equal to that formula; p5 shows month text rotated at the right edge. Considered: `fancytabs` as its own way, not proposed because the emitter never writes its commands, the class does |
| running head, page number | example.pdf p5-p8 (slanted 10.91 pt head: section "1.1 First day" on odd pages p5, p7, chapter "1 janvier" on even pages p6, p8; page number at the foot outer edge, y=34.8) | `hf.class-native` | inherited scrbook page style; the exact page-style setting of the example is not determinable (source not shipped) |
| page style off | scrjrnl.dtx:163-165 | `hf.pagestyle-kernel` | manual advice only: `\pagestyle{empty}` to drop page numbers when days identify pages |
| entry dates | scrjrnl.dtx:230-232, 239-252, 275-276, 326-328 | `front.datetime` | `datetime` loaded by `\AfterPackage{babel}{\RequirePackage{datetime}}` (230); `\jrnlformatdate` and `\jrnlformatindexdate` default to `\formatdateny` (231-232), a year-less `\formatdate`; user may redefine them |
| date language | scrjrnl.dtx:230, 239-252; example.pdf p3, p9 | `lang.babel` | babel is a required companion (datetime is only loaded after it); year-strip macros exist for english, american, british, french, german, austrian, swedish, breton, russian, spanish, catalan, basque (241-252); example shows French |
| day and month numbering | scrjrnl.dtx:282-286, 299-301, 329, 375-378, 387-388 | `head.class-native` | counters moved by keys `startmonth`, `startday`, `month`, `day` (each `\setcounter` then `\addtocounter -1`); chapter counter = month, section counter = entry (example.pdf p5, p11: "1.1", "2.1") |
| index of days | scrjrnl.dtx:161-199 (manual recipe, verbatim text) | `idx.makeidx` | manual only: index entries printed as dates from `jrnldaydate<n>`, via `imakeidx` patched in `\@index` (190-198); verbatim text is content, see Bespoke code |
| manual driver class | scrjrnl.dtx:33 | `class.ltxdoc` | no options |
| manual language | scrjrnl.dtx:34 | `lang.babel` | `english` |
| manual font | scrjrnl.dtx:35-36 | `font.fontspec` | `\setmainfont{Linux Libertine O}` (system font, not shipped; XeLaTeX or LuaLaTeX) |
| manual logos | scrjrnl.dtx:37 | `font.icons` | `metalogo` loaded, no logo command used in the file |
| manual widows | scrjrnl.dtx:38 | `sp.penalties` | `\usepackage[all]{nowidow}` |
| manual doc machinery | scrjrnl.dtx:39-45, 50-72, 75, 201, 460 | `dtx.doc` | `\EnableCrossrefs` `\CodelineIndex` `\RecordChanges` `\DocInput` `\PrintChanges` `\PrintIndex`, `\CheckSum`, `\CharacterTable`, `\changes`, `\DoNotIndex`, `\GetFileInfo`, `\StopEventually`, `\Finale`, `\DescribeMacro`, `macrocode` |
| manual title block | scrjrnl.dtx:76-80 | `front.maketitle` | `\title` `\author` (with `\url`) `\date` `\maketitle` |
| manual headings | scrjrnl.dtx:82, 90, 96, 203 | `head.kernel` | `\section`, `\subsection` of the ltxdoc class |
| manual code text | scrjrnl.dtx:92-94, 174-199 | `code.verbatim` | `verbatim` environment |
| manual side notes | scrjrnl.dtx:227, 235, 255, 264, 272 | `note.marginpar` | `\marginpar{...}` captions before each macrocode block |
| manual font marks | scrjrnl.dtx:84, 107 | `mark.kernel` | `\textsf`, `\texttt` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| class internals: counters, `\define@key` keys, `\jrnlmonth`, `\jrnlday`, `journal`, `\noyear<lang>` macros, TeX4HT hooks | scrjrnl.dtx:211-453 | not counted: published class (CTAN, TeX Live, MiKTeX) | `class.scrjrnl` is the way; the emitter never copies this code. For the record, the `\noyear...` year strippers (239-252) would reduce to one year-less `\newdateformat` per language (`front.datetime`), and `\HTMLchapHook` and `\HTMLsecHook` are empty macros with no printed effect (292-293, 309, 347) |
| `\providecommand*{\url}{\texttt}` | scrjrnl.dtx:74 | yes | alias of `\texttt`: `mark.kernel` |
| `\newlength` and `\newcommand` inside the `journal` begin code | scrjrnl.dtx:404-439 | not counted: class internal | read only: a second `\begin{journal}` with option `fancytabs` would redeclare `\calcfancytabsGap` and the others (not compiled) |
| index recipe: `\getdaydate`, `\transform`, `\decodesec`, `\patchcmd` of `\@index`, `\@wrindex`, `\protected@write` | scrjrnl.dtx:176-197 | not in scope | text inside a `verbatim` block of the manual, so content held by `code.verbatim`; the class does not load it and example.pdf shows no index. If a template used it, it would be `BESPOKE/body`, irreducible (it patches package internals) |

## Content-opaque
none (example.pdf contains Latin filler text, which is content)

## Lib changes
- New ways proposed: none (considered: `fancytabs`, carried by `hf.class-native` through the class option; `class.scrjrnl` is written plainly as a class way)
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
