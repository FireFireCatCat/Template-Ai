no

# 0493-multilingual-wall-calendar: Multilingual Wall Calendar

- Unverified: read from the source, not compiled.
- Source: Source/0493-multilingual-wall-calendar/ (origin: https://latextemplates.com/downloads/multilingual-wall-calendar.zip, repackaging of github.com/liantze/cdcalendar by LianTze Lim per ATTRIBUTION.txt:1-4; licence: CC-BY-4.0)
- Kind: calendar
- Lib: v4
- Engine: pdfLaTeX-compatible (main.tex loads T1, roboto, stix2, fontawesome; no fontspec; the README's CJK variants need XeLaTeX/LuaLaTeX but are not in this zip). Two runs needed (`remember picture`, per-page `.aux` files written by TeX's own `\write`, cdcalendar.cls:442-443, 598-599).
- Look carried by: zip-local (the whole page look, grid, cover and event marks are drawn by cdcalendar.cls; main.tex only sets styles and event calls)
- Class origin: zip-local (`cdcalendar`: ctan.org/pkg/cdcalendar and www.ctan.org/pkg/cdcalendar both returned 404; the zip is "Packaged by latextemplates.com", ATTRIBUTION.txt:10, not an official release; W1 fails)
- Main file: main.tex (other samples: none)
- Read: main yes (all 128 lines), zip-local classes and styles all (cdcalendar.cls, all 641 lines; the CC-BY LICENSE text and README.md/ATTRIBUTION.txt were read as metadata)

## Verdict
No. The look is carried by `cdcalendar.cls`, a class that is not on CTAN and not an official release, so it is zip-local and cannot be a lib way. It is a hand-written TikZ calendar engine: the `monthCalendar` environment draws the month grid with the `calendar` library through custom `execute before day scope` styles that reach into pgf internals, writes per-page `.aux` files to mark events on prev/next-month thumbnails, and builds a cover from `textpos` + TikZ nodes. That is irreducible typesetting code (BESPOKE) and template-defining artwork (ART) with no declarative lib way (`cal.kalender` and `cal.termcal` are different packages with different outputs). The preamble itself (fonts, colours, geometry, babel/datetime2 loading) would map to lib ways.

## Blockers
- `BESPOKE/class` the class itself is zip-local, not published (cdcalendar.cls:1; not on CTAN, W1 fails)
- `BESPOKE/class` `monthCalendar` environment: calendar grid, rotated month title, thumbnails, event-list minipage, aux-file hand-off between pages (cdcalendar.cls:430-604)
- `ART/class` the month grid and mini prev/next calendars are TikZ drawings that are the template's identity (cdcalendar.cls:445-467, 473-485)
- `BESPOKE/class` custom pgf calendar styles `day letter headings` and `week list sunday` that run code on pgf registers (`\pgf@ya`, `\tikz@lib@cal@yshift`, `\c@pgf@counta`) (cdcalendar.cls:237-264, 271-306), and `\xpatchcmd` patching of `\pgfcalendarweekdayname` with an `\xtranslate` lookup (cdcalendar.cls:214-224)
- `BESPOKE/class` `\event` family and `\markCalendar`: macro-built event list via `\protected@xappto`, `\newcount`, `\DTMsaveddatediff`, `\write` into two aux files (cdcalendar.cls:492-583)
- `ART/class` cover: `\makeCover` places a TikZ node in a `textblock*` over a `\pagecolor` background (cdcalendar.cls:179-207; called at main.tex:122-126)
- `ART/preamble` event-mark TikZ styles `blue icon`, `pink icon`, `holiday`, `smfillbg` are passed as `mark style=` keys to the bespoke `\event` (main.tex:14-17, 56-57, 66)

## Class setting
- Class: the sample's class is zip-local `cdcalendar` (not a lib way); it loads `class.extarticle` (cdcalendar.cls:54-56, `\DeclareOption*` forwards unknown options). Options in the sample: `17pt` (extarticle size), `british` (global language, reaches babel), `giant` (cdcalendar's own: `\@giantcaltrue`, `\@prevnexttrue`, cdcalendar.cls:17-21) (main.tex:4). Unused options: `small`, `giantsolo`, `landscape`, `nobabel`, `sundayweek`, `kuda` (cdcalendar.cls:12-52).
- Class-native vocabulary used: `monthCalendar{year}{month}` (main.tex:55), `\event[mark style=,marker=,smallver=]{date}{days}{name}` (main.tex:56-57), `\otherstuff[caption]{width}{content}` (main.tex:51-53, 86-87), `\dayHeadingStyle`, `\sundayColor`, `\monthTitleStyle`, `\eventStyle`, `\illusSkip` (main.tex:42-46), `\coverBgColor`, `\coverTitle[keys]{text}`, `\makeCover` (main.tex:122-126).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| base class | cdcalendar.cls:56; main.tex:4 | `class.extarticle` | 17pt, british (forwarded by cdcalendar.cls:54). Source of extarticle not read (extsizes, TeX distribution) |
| page geometry | cdcalendar.cls:82-87; main.tex:19 | `page.geometry` | margin=\CalPageMargin (1cm, cdcalendar.cls:85), then a4paper |
| n-up pages | cdcalendar.cls:83 (loaded), 93, 119 | `pg.pgfpages` | loaded unconditionally; the `4 on 1` / `2 on 1` layouts apply only to `small` and the default size, not to `giant` |
| absolute text blocks | cdcalendar.cls:151, 445, 469, 193, 203 | `pg.textpos` | absolute,overlay; `textblock*` with anchor and position. Used only by the bespoke environment and cover |
| header/footer | cdcalendar.cls:639 | `hf.pagestyle-kernel` | `\pagestyle{empty}` |
| paragraph spacing | cdcalendar.cls:640-641, 587 | `sp.lengths` | parindent=0pt, parskip=0pt (0.5ex inside the event list) |
| manual spacing | cdcalendar.cls:619, 633; main.tex:46 | `sp.manual-space` | `\vspace*{\illusSkip}`, illusSkip=1cm |
| alignment | cdcalendar.cls:446 | `sp.ragged` | `\raggedleft` in the month-title block |
| font encoding | main.tex:6 | `font.fontenc-t1` | T1 |
| text face | main.tex:7 | `font.helvet` | package `roboto`, option `rm` (a sans text-face package is the parameter, per the v1 merge of `font.helvet`) |
| math face | main.tex:8 | `font.mathptmx` | package `stix2`, options `notextcomp,notext` (Times-like family; package is the parameter) |
| icons | main.tex:12, 57, 66 | `font.icons` | `fontawesome`; `\faBriefcase`, `\faBirthdayCake` |
| sizes and switches | main.tex:42-45, 124; cdcalendar.cls:446, 586 | `font.size-commands` | `\fontsize{66pt}{66pt}`, `\fontsize{72pt}{76pt}{...}`, `\footnotesize`, `\tiny` |
| font switches | main.tex:42, 44, 45, 124 | `mark.kernel` | `\sffamily`, `\bfseries` (inside TikZ `font=` keys) |
| colours | cdcalendar.cls:58; main.tex:43-44, 122, 124 | `color.xcolor` | dvipsnames,svgnames; gray!90, red!80!black, RoyalBlue!40!white, RoyalBlue!40!black, white |
| page colour | cdcalendar.cls:152, 182, 189, 206; main.tex:122 | `color.pagecolor` | package `pagecolor` with nopagecolor=white, pagecolor=white; `\pagecolor{\@coverBgColor}` for the cover. Package source not read |
| language | cdcalendar.cls:63-68; main.tex:4 | `lang.babel` | british; `shorthands=off` (cdcalendar.cls:65) |
| keyword translations | cdcalendar.cls:67-68, 70-77 | `lang.translator` | `\languagealias{british}{English}`; `\providetranslation` weekday letters only in the `nobabel` branch |
| date printing | cdcalendar.cls:143-144, 329, 544 | `front.datetime` | datetime2 `useregional,showdow`; `\DTMlangsetup{abbr,ord=raise,showyear=false}`; `\DTMdate` prints event dates |
| URL font | cdcalendar.cls:145-147 | `meta.url` | `url`; `\UrlFont` = `\rmfamily`; no URL in the sample |
| page breaks | main.tex:59, 68, 72, ... 113 | `pg.break` | `\clearpage` after each month and in `\makeCover` (cdcalendar.cls:206) |
| TikZ package | cdcalendar.cls:141-142; main.tex:10-11 | `art.tikz` | libraries babel, calendar, positioning, backgrounds, shapes; main adds shapes.geometric. This is the drawing machinery of the bespoke grid, hence ART |
| month page (grid, title, thumbnails) | main.tex:55-58 and 64-112; cdcalendar.cls:430-604 | none (BESPOKE/class, ART/class) | year, month; styles via main.tex:42-45 |
| event marks and list | main.tex:56-57, 66, 89, 106, 111; cdcalendar.cls:492-589 | none (BESPOKE/class) | start date, days, label, `mark style`, `marker`, `smallver` |
| illustration slot | main.tex:51-53, 86-87; cdcalendar.cls:625-637 | none as one way (see Bespoke code: reducible in isolation) | width `\linewidth`, caption text |
| cover | main.tex:122-126; cdcalendar.cls:166-207 | none (BESPOKE/class, ART/class) | background RoyalBlue!40!black, title 72pt white flush right |
| other components | whole zip | not used | no abstract, contents, headings, lists, quotes, notes, math, theorems, floats, tables, captions, code, boxes, bibliography, index, hyperref or cross-references in main.tex or cdcalendar.cls |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `cdcalendar` class (options, defaults, `\LoadClass{extarticle}`) | cdcalendar.cls:1-641 | No | the loads and options reduce (rows above), but the environment and macros below do not |
| `monthCalendar` environment | cdcalendar.cls:430-604 | No | tikz `calendar` grid, rotated title node, mini prev/next matrix, `\write`-fed `.aux` hand-off to the neighbouring page, events minipage; no lib way draws or computes this |
| `day letter headings`, `week list sunday` styles | cdcalendar.cls:237-264, 271-306 | No | code in `execute before/at begin/after day scope` using pgf registers |
| `\xpgfcalendarweekdayname` patch, `\xtranslate`, `\undef` of datetime2 names | cdcalendar.cls:214-232 | No | `\xpatchcmd` rewrites a pgf internal; csname dispatch on `\languagename` (also cdcalendar.cls:337-349, 246-251) |
| `kuda` style, `\kudafiller` | cdcalendar.cls:357-428 | No (not used by the sample: option `kuda` absent, main.tex:4) | `\foreach` day-filler loops on pgf calendar state |
| `\event`, `\oneDayEvent`, `\multiDayEvent*`, `\markCalendar`, `stealth` toggle | cdcalendar.cls:177, 492-583 | No | expandable list building and date arithmetic that drive what is printed |
| `\makeCover`, `\coverTitle`, `\coverBgColor`, `\coverImage` | cdcalendar.cls:166-207 | No | TikZ node inside `textblock*`, with a `\pagecolor` branch on `\pgf@logicalpages` and `\@Gm@driver` |
| `\otherstuff`, `\illustration` | cdcalendar.cls:611-637 | Yes, in isolation | `box.minipage` of the given width holding the content (or `\includegraphics`, `fig.graphicx`), a caption line in `\itshape\tiny`, then `sp.manual-space` `\vspace*{\illusSkip}`; the `landscape` branch adds `pg.textpos`. Not a blocker alone, but it sits beside the irreducible code |
| `\dayHeadingStyle`, `\sundayColor`, `\monthTitleStyle`, `\eventStyle`, `\captionStyle` | cdcalendar.cls:309-314 | Only as parameter setters | they store TikZ style lists and macros that the bespoke grid reads; no standalone reduction |
| `\printeventname`, `\eventSep`, `\printdate` | cdcalendar.cls:163-164, 329 | Yes | `\textbf{#1}`, the string ": ", `\DTMdate{#1}` (`mark.kernel`, `front.datetime`) |
| `\newlength` CalPageMargin, EventLineWidth, illusSkip | cdcalendar.cls:59-60, 608-609 | Yes | plain lengths feeding `page.geometry` and `sp.manual-space` |
| TikZ mark styles `blue icon`, `pink icon`, `holiday`, `smfillbg` | main.tex:14-17 | Values only | `art.tikz` key lists consumed by the bespoke `\event`; reducible only if `\event` were |
| helper packages `regexpatch`, `xstring`, `ifxetex`, `pgfkeys` | cdcalendar.cls:138-139, 148, 150 | n/a | macro-programming support for the code above; no printed effect of their own |

## Content-opaque
- `\monthIllustration` TikZ picture (sun over hills), defined at main.tex:25-35 and placed in the illustration slot at main.tex:53 and 87; README.md:22-26 calls it a stand-in that is replaced by `\includegraphics`. It is slot content, not the template's identity.
- Event labels, dates and the cover text "2026 Calendar" (main.tex:56-111, 125).

## Lib changes
- New ways proposed: none. Considered and not proposed: a `cdcalendar` way (fails W1, because ctan.org/pkg/cdcalendar is a 404 and the zip is a repackaging; fails W2/W3 as well, since the behaviour is chosen by editing macro code in a TikZ calendar engine). The lib's `cal.kalender` and `cal.termcal` are other packages (a fixed German year grid, a term-weeks calendar).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this).
