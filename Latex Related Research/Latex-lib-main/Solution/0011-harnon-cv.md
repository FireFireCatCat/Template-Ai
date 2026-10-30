yes

# 0011-harnon-cv: harnon-cv (CV class with a vertical experience timeline)

- Unverified: read from the source, not compiled.
- Source: Source/0011-harnon-cv/ (origin: https://mirrors.ctan.org/macros/latex/contrib/harnon-cv.zip; licence: pd, public domain, harnon-cv.cls:7; CTAN page says "Public Domain Software")
- Kind: cv
- Lib: v1
- Engine: pdfLaTeX-compatible (`graphicx[pdftex]` harnon-cv.cls:59, `cantarell` with T1 harnon-cv.cls:68-69; no fontspec, no Lua)
- Look carried by: class (the whole look is in harnon-cv.cls; sample.tex defines no macro, length or package and only fills the class's fields and calls its commands)
- Class origin: ctan (https://ctan.org/pkg/harnon-cv, read once: "A CV document class with a vertical timeline for experience", author William Hart, version 1.0, path /macros/latex/contrib/harnon-cv; the zip origin is the CTAN mirror)
- Main file: sample.tex (other samples: none; sample.pdf is the compiled output, not read)
- Read: main yes, zip-local classes and styles all (harnon-cv.cls, 178 lines, read in full; it is the CTAN class, so "zip-local" here means "shipped in the zip", not "unpublished")

## Verdict
yes, on the class-carried ruling. `harnon-cv` is a class released on CTAN (W1), so it is one way, `class.harnon-cv`, and the sample adds only content: six field commands, `\maketitle`, and the class's own header/timeline commands, plus kernel `itemize`/`enumerate`/`\emph`/`\textbf` (sample.tex:5-46). The sample has no preamble macro of its own and no artwork of its own. This `yes` is evidence about the class dimension only. Caveat (not a blocker under the rubric, recorded so the result can be re-read): the class internals hand-roll behaviour (an `\@maketitle` rewrite driven by `\ifdefempty` conditionals, harnon-cv.cls:101-129; a `framed` `\FrameCommand` bar, harnon-cv.cls:29-32; a minipage and leaders timeline row, harnon-cv.cls:148-165). Were the class unpublished, I would call those BESPOKE/class and answer `no`; they stay inside the published class and are not copied.

## Blockers
none

## Class setting
- Class: `class.harnon-cv` options: none accepted by the class; it fixes its base itself, `\LoadClass[a4paper, 11pt]{article}` (harnon-cv.cls:13), so `\documentclass{harnon-cv}` is the whole class line (sample.tex:1)
- Class-native vocabulary used: field setters `\author` (redefined to `\yourname`, harnon-cv.cls:55), `\yournumber`, `\youraddress`, `\yourwebsite`, `\recenthistory` (sample.tex:5-8,12); defined but not used by the sample: `\yourname`, `\youremail` (harnon-cv.cls:40,43); `\maketitle` (sample.tex:16; class `\@maketitle`, harnon-cv.cls:101-129); section and block commands `\addheadertext` (sample.tex:19,41), `\addsubheader` (sample.tex:22,29), `\addcallout` (sample.tex:45); timeline `\starttimeline`, `\stoptimeline`, `\timelineitem{date}{body}`, `\timelinespacer`, `\addtimelinebullet` (sample.tex:20-38); defined but not used: `\adddocumentheader` (used inside the title, harnon-cv.cls:104), `\addtimelineheader` (used inside `\timelineitem`, harnon-cv.cls:153), `\listitem` (harnon-cv.cls:96)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | harnon-cv.cls:12-13; sample.tex:1 | `class.harnon-cv` | no options; base `article` fixed inside the class |
| paper and type size | harnon-cv.cls:13 | `page.class-options` | a4paper, 11pt, fixed by the class's `\LoadClass`, not chosen by the document |
| page geometry | harnon-cv.cls:16 | `page.geometry` | top=0.75in, bottom=0.75in, left=0.75in, right=0.75in |
| page style, no page numbers | harnon-cv.cls:19-20 | `hf.pagestyle-kernel` | `\pagestyle{plain}` then `nopageno` (CTAN and TeX Live; an empty page style for every page); an emitter writes `\pagestyle{empty}` for the same effect |
| text face | harnon-cv.cls:68 | `font.helvet` | package `cantarell`, option `default` (a sans text-face package is the parameter, as the v1 `font.helvet` merge ruled) |
| encoding | harnon-cv.cls:69 | `font.fontenc-t1` | `fontenc` T1 |
| font sizes | harnon-cv.cls:77,80,84,88,92,105 | `font.size-commands` | `\huge` (document header), `\LARGE` (section header), `\large` (subheader, callout, timeline date), `\small` (contact lines) |
| colours | harnon-cv.cls:62-65 | `color.xcolor` | `\definecolor` verylightgrey rgb 0.85,0.85,0.85; lightgrey rgb 0.5; darkgrey rgb 0.3; used by `\color{...}` at harnon-cv.cls:30,80,84,88,92,153 |
| paragraph and hanging indents | harnon-cv.cls:72,142 | `sp.lengths` | `\parindent`=18pt; in bullets `\leftskip`=12mm, `\parindent`=-6mm, reset to 18pt after (harnon-cv.cls:142) |
| manual spacing | harnon-cv.cls:80,117,122,128,136,139,151,156,159-161,164,170,172,174 | `sp.manual-space` | `\vspace` 1.2cm, 3mm, 0.5cm, 7mm, -1cm, 0.2cm, 2mm, 4mm, 1.5cm, -5mm; `\hspace` -2mm, 10pt, 2mm; `\hfill` |
| rules | harnon-cv.cls:30,118,126,153 | `sp.rule` | `\rule{\textwidth}{0.2mm}` under the title and under the statement; `\vrule width 1pt` in the bar; date leader `\leaders\vrule height 5pt depth -4pt \hfill` in verylightgrey |
| title block, fields | harnon-cv.cls:40-55,101-129; sample.tex:5-8,16 | `front.class-native` | name in `\huge\textsc`, then `\small` email, url, number on the left; address `\small` flush right; each field omitted when empty (`\ifdefempty`) |
| title block, two columns | harnon-cv.cls:102-114 | `cols.minipage` | two `minipage` of 0.5\textwidth side by side |
| title block, alignment | harnon-cv.cls:103,108,111,114 | `sp.ragged` | `flushleft` left block, `flushright` address block |
| personal statement | harnon-cv.cls:45,52,121-127; sample.tex:12 | `front.class-native` | `\recenthistory{text}`, printed under the first rule and closed by a second rule; absent when empty |
| section header | harnon-cv.cls:80-81; sample.tex:19,41 | `head.class-native` | `\addheadertext{text}`: darkgrey `\LARGE`, 1.2cm above, 3mm below; unnumbered, no counter, no toc entry |
| subheader and callout | harnon-cv.cls:84-85,88-89; sample.tex:22,29,45 | `head.class-native` | `\addsubheader`: darkgrey `\large` on its own paragraph; `\addcallout`: darkgrey `\large`, inline |
| small caps in name | harnon-cv.cls:77 | `mark.kernel` | `\textsc` |
| timeline entry | harnon-cv.cls:136-175; sample.tex:20-38 | `cv.entries` | `\timelineitem{date}{body}` row, `\timelinespacer` gap, `\starttimeline`/`\stoptimeline` margins; date label in lightgrey `\large` (harnon-cv.cls:92) |
| timeline row layout | harnon-cv.cls:150-163 | `box.minipage` | `minipage[t]` 0.2\textwidth (date, centred, with leader rule) next to `minipage[t]` 0.8\textwidth (body); no page break inside an item (sample.tex:36) |
| timeline vertical bar | harnon-cv.cls:26,29-32,158 | `box.mdframed` | `framed` `\MakeFramed` with `\FrameCommand` = verylightgrey `\vrule` 1pt plus 10pt gap (a leftbar), body width reduced by the bar |
| timeline bullet | harnon-cv.cls:142-143; sample.tex:23-24,30,35-36 | `cv.entries` | `\addtimelinebullet{text}`: `$\bullet$` + 2mm gap, hanging indent 12mm/-6mm |
| lists in the body | sample.tex:31-34,42-46 | `list.kernel` | `enumerate` inside a timeline item, `itemize` in Skills; the class sets no list parameter |
| emphasis in the body | sample.tex:12,24,30,35-36,45 | `mark.kernel` | `\emph`, `\textbf` |
| hyperlinks | harnon-cv.cls:179 | `meta.hyperref` | `hyperref` loaded last, default options, no `\hypersetup` |
| website line | harnon-cv.cls:106; sample.tex:8 | `meta.url` | `\url{...}` (from hyperref) in the title; the string is content |
| graphics loader | harnon-cv.cls:59 | `fig.graphicx` | `graphicx[pdftex]`, loaded "for a headshot"; the sample prints no image |
| table loader | harnon-cv.cls:35 | `tbl.tabularx` | `tabularx` loaded, never called by the class or the sample |

No abstract, contents, bibliography, theorem, caption, code, float, footnote or header/footer component occurs: the class defines none and the sample uses none.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| none in the sample (no `\newcommand`, `\def`, environment or counter in sample.tex) | sample.tex:1-47 | n/a | n/a |
| class macros: field setters, `\@maketitle`, `timelinebar`, `sectionheader`, `subheader`, `callout`, `timelineheader`, `timelinebullet`, `\timelineitem`, `\timelinespacer`, `\starttimeline`, `\stoptimeline`, `\listitem` | harnon-cv.cls:29-32,40-55,77-96,101-129,136-175 | n/a: published class vocabulary (CTAN), not bespoke | They are the `class.harnon-cv` way's native commands, listed in "Class setting". Read as a composition, they are `box.minipage`, `cols.minipage`, `box.mdframed`, `sp.rule`, `sp.manual-space`, `sp.lengths`, `font.size-commands`, `color.xcolor`, but the `\ifdefempty` conditionals (harnon-cv.cls:104-112,121) and the `\@maketitle` rewrite are not expressible as lib parameters. That is why the `yes` rests on the class being published and not on a reduction. |
| `etoolbox` | harnon-cv.cls:23 | n/a | Programming package used only for `\ifdefempty` inside the class; it carries no look and has no lib way, none proposed (fails W2: it is code, not parameters). |

## Content-opaque
none

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- Text addressed to an AI in the zip: none found (README, harnon-cv.cls, sample.tex read in full).
- Visible class quirks, recorded, not exercised by the sample: harnon-cv.cls:105 has a literal `l` before `\small\@youremail`, so an email line would print a stray "l"; `\timelineitem` is a `minipage`, so an item cannot break across pages (sample.tex:36 says so); a list inside an item needs a closing `\par` (sample.tex:34-35).
- Checks on published status: `nopageno` is on CTAN and in TeX Live (read once); `cantarell`, `framed`, `etoolbox`, `tabularx`, `geometry`, `xcolor`, `graphicx`, `hyperref` are published packages (not individually read; named from the class's own `\usepackage` lines).
