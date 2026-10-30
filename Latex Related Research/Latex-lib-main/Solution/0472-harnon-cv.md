yes

# 0472-harnon-cv: Harnon CV (CV class with a vertical experience timeline)

- Unverified: read from the source, not compiled.
- Source: Source/0472-harnon-cv/ (origin: https://latextemplates.com/downloads/harnon-cv.zip; licence: Public-domain per the manifest, and ctan.org/pkg/harnon-cv lists "Public Domain Software")
- Kind: cv
- Lib: v4
- Engine: pdfLaTeX-compatible (not confirmed from the class: its source was not read; the sample loads no `fontspec`, `polyglossia` or other engine-specific package, and its only non-ASCII characters are two em dashes inside the comment at main.tex:1-2)
- Look carried by: class (the zip is one 63-line `main.tex` that loads the published class `harnon-cv` and uses only that class's commands plus kernel `\author`, `\maketitle`, `itemize`; it defines nothing of its own)
- Class origin: tex-distribution-unbundled (ctan.org/pkg/harnon-cv read twice: on CTAN, version 1.0, maintainer William Hart, "Public Domain Software", topics Class and CV, "Contained in" TeX Live and MiKTeX as `harnon-cv`, description "another modern, neat, design, and provides a simple means of adding an experience timeline"; the zip ships no `.cls`)
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present (the zip has no `.cls`, `.sty`, `.def`, `.cfg`, `.clo`; the source of the published class `harnon-cv` was NOT read, so everything below about its internals is inferred from how the sample calls it)

## Verdict
`yes`. The only file is `main.tex`. It loads the published class `harnon-cv` with no option (main.tex:4), sets six class-native fields (main.tex:6-14), and then calls that class's own commands for the timeline, the section headers and the callout (main.tex:20-54), with kernel `itemize` for two sections (main.tex:50-56, 59-61). It has no `\usepackage`, `\newcommand`, `\def`, environment, counter, `\input` or artwork (grep of main.tex found none), and needs no tool outside TeX. The look is one way, `class.harnon-cv`, plus the class's parameters. Caveat: this is evidence about the class dimension, not about the component ways, because the class internals were not read. The comment at main.tex:1-3 says the timeline is "built from a custom framed leftbar"; that is the author's description of the class, not checked here, and a drawn timeline inside a published class would not change the rubric's published-class ruling.

## Blockers
none

## Class setting
- Class: `class.harnon-cv` options: none (main.tex:4)
- Class-native vocabulary used: contact and summary slots `\yournumber{}` (main.tex:7), `\youraddress{}` with a `\\` line break inside (main.tex:8), `\yourwebsite{}` (main.tex:9), `\recenthistory{}` (main.tex:11-14); section header `\addheadertext{}` (main.tex:20, 49, 58); timeline wrapper pair `\starttimeline` ... `\stoptimeline` (main.tex:21, 47); entry `\timelineitem{<date range>}{<body>}` (main.tex:22, 32, 42); entry sub-header `\addsubheader{}` (main.tex:23, 33, 43); entry bullet `\addtimelinebullet{}` (main.tex:24, 27, 34, 37, 44); gap between entries `\timelinespacer` (main.tex:30, 40); inline callout `\addcallout{}` (main.tex:54). Kernel commands used with it: `\author{}` (main.tex:6) and `\maketitle` (main.tex:18). The sample sets no `\title` and no `\date`, so the class must supply its own `\maketitle` (inferred, not read).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:4 | `class.harnon-cv` | no options |
| page geometry, fonts, colours, spacing, running heads | main.tex:4 (the sample sets none of them: it has no `\usepackage` or length or colour command) | `class.harnon-cv` | all set inside the class; source not read, so not decomposed |
| name and title block commands | main.tex:6, 18 | `front.maketitle` | kernel `\author{Denise Okafor}` and `\maketitle`; no `\title`, no `\date`; how the class lays the name out is unread |
| contact slots and profile summary | main.tex:7-9, 11-14 | `front.class-native` | `\yournumber{+1 415 555 0132}`, `\youraddress{88 Mission Street\\San Francisco, CA 94105}`, `\yourwebsite{https://denise-okafor.example.com}`, `\recenthistory{<one paragraph>}`; printed by the class's `\maketitle` (where the summary lands is unread) |
| section headers | main.tex:20, 49, 58 | `head.class-native` | `\addheadertext{Experience}`, `{Skills}`, `{Education}`; three calls, no level argument, so one header level |
| experience timeline | main.tex:21-47 | `cv.entries` | `\starttimeline` ... `\stoptimeline` around three `\timelineitem{2021--Present}`, `{2018--2021}`, `{2016--2018}`, each with a braced body; `\timelinespacer` after the first two (main.tex:30, 40) |
| entry sub-header | main.tex:23, 33, 43 | `cv.entries` | `\addsubheader{Staff Product Designer, Ledgerly}`, `{Senior Product Designer, Fintech co. Brightloop}`, `{Product Designer, Northbeam Software}`; one per entry, first thing in the body |
| entry bullets | main.tex:24-28, 34-38, 44-45 | `cv.entries` | `\addtimelinebullet{<sentence>}`: five calls (2, 2 and 1 per entry); a class command, not `itemize` |
| skills and education lists | main.tex:50-56, 59-61 | `list.kernel` | two `itemize` environments (three items, one item); no `enumitem` option; the class may restyle them (unread) |
| inline callout | main.tex:54 | `class.harnon-cv` | `\addcallout{same}` inside an `\item`; one text argument; the class's own command, its effect is in the unread source (if it is a font or colour switch it reduces to `mark.kernel` or `color.xcolor`, not shown) |
| manual breaks and spaces | main.tex:8, 60 | `sp.manual-space` | `\\` inside `\youraddress`; control space `\ ` in `B.F.A.\ Graphic Design` |

## Bespoke code
none. main.tex holds no `\newcommand`, `\renewcommand`, `\providecommand`, `\def`, `\newenvironment`, `\newcounter`, `\makeatletter`, `\usepackage`, `\input` or `\include`, and no `tikz` (grep of main.tex returned no match). The class `harnon-cv` is published (class origin above), not bespoke.

## Content-opaque
none. The three timeline entries, the dates, the percentages written `22\%` and `47\%` (main.tex:28, 36) and the summary text are content. The sample has no figure, table, picture, equation, bibliography or code.

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

Notes: nothing in the zip is addressed to an AI. The comment at main.tex:1-3 only describes the class ("CTAN class (public domain, William Hart 2012)"; the 2012 date is not on the CTAN page, which gives no version date). Two of three allowed CTAN reads used (`harnon-cv`, twice). No local TeX installation was available, so the class source could not be read. Missing assets: none (the sample includes no image or font). The class is not in the zip, so a compile needs it from TeX Live or MiKTeX, where CTAN lists it.
