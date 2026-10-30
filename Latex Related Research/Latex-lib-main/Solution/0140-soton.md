yes

# 0140-soton: University of Southampton beamer colours (soton)

- Unverified: read from the source, not compiled.
- Source: Source/0140-soton/ (origin: https://mirrors.ctan.org/macros/latex/contrib/soton.zip; licence: lppl)
- Kind: presentation
- Lib: v3
- Engine: pdfLaTeX-compatible (only `xcolor` and beamer colour commands; no `fontspec`, no Lua)
- Look carried by: zip-local (the whole look is in the two style files `soton-palette.sty` and `soton-beamer.sty`; they are a CTAN bundle, so published, see Bespoke code)
- Class origin: tex-distribution-unbundled (no `\documentclass` anywhere in the zip; beamer is implied by `\setbeamercolor`, soton-beamer.sty:30-40, and is not bundled; its source was not read)
- Main file: none, the zip holds no `.tex` (other samples: none)
- Read: main none present (no sample exists), zip-local classes and styles all (`soton-beamer.sty` 40 lines, `soton-palette.sty` 53 lines, `README` 6 lines, every line read)

## Verdict
yes. The zip is a colour-only beamer style: a 13-colour palette and ten `\setbeamercolor` assignments, nothing else. Every line reduces to `color.xcolor` (`\definecolor`) and `slide.beamer-template` (`\setbeamercolor`) over `class.beamer`. There is no `\newcommand`, `\def`, environment, counter, artwork or external tool. The look is thin by design: no theme, no font, no layout is set, so the emitter has little to write beyond colours. A caveat is recorded under Bespoke code (the `DarkRed` name). This is a read-only judgement, nothing was compiled.

## Blockers
none

## Class setting
- Class: `class.beamer` options: none stated in the zip (no sample). Inferred, not declared: `\setbeamercolor` is a beamer command and `soton-beamer.sty` never loads beamer itself (grep: no `\RequirePackage{beamer}`, no `\LoadClass`), so it only works after `\documentclass{beamer}`. The zip never says which beamer options or theme the author uses.
- Class-native vocabulary used: beamer colour elements set by `\setbeamercolor{<element>}{fg=,bg=}`: `background canvas`, `button border`, `button`, `frametitle`, `alerted text`, `normal text`, `titlelike`, `author`, `date`, `item` (soton-beamer.sty:30-40).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | soton-beamer.sty:30-40 (beamer-only commands; no `\documentclass` in the zip) | `class.beamer` | options not given; source not read |
| colour package | soton-palette.sty:35 | `color.xcolor` | `\RequirePackage{xcolor}` with no options |
| palette, primary 6 | soton-palette.sty:39-44 | `color.xcolor` | `\definecolor{..}{rgb}{r g b}` with real 0-1 values: sotonblu .00392 .26275 .34902; sotongrn 0 .44706 .45882; sotoncya .03922 .58824 .66275; sotongry .19608 .23922 .26275; sotonbei .59216 .61961 .27059; sotonmet .73333 .73333 .73333 |
| palette, secondary 7 | soton-palette.sty:47-53 | `color.xcolor` | sotonyel .99999 .70196 0; sotonora .99608 .24314 .07843; sotonred .94118 .05882 .17255; sotonrus .67059 .07059 .06275; sotonbrn .54118 .25490 .16863; sotonpnk .88627 .41176 .62353; sotonppl .32549 .12157 .26667 |
| palette loaded into the beamer style | soton-beamer.sty:28 | `color.xcolor` | `\RequirePackage{soton-palette}`: inlined by the emitter as the 13 `\definecolor` lines above |
| named colour from a standard set | soton-beamer.sty:32 | `color.xcolor` | `DarkRed` is not one of the 13 palette names (grep: used only here); it is a name of xcolor's `svgnames` named set (my knowledge of xcolor, not read from source), and soton-palette.sty:35 passes no options, so the set must come from the document (class option or `\PassOptionsToPackage`) |
| slide background | soton-beamer.sty:30 | `slide.beamer-template` | `\setbeamercolor{background canvas}{bg=sotonblu}` |
| button colours | soton-beamer.sty:31-32 | `slide.beamer-template` | `button border` bg=sotonblu fg=sotonblu; `button` bg=sotonblu fg=DarkRed |
| frame title colour | soton-beamer.sty:34 | `slide.beamer-template` | `frametitle` fg=sotonora |
| alerted text | soton-beamer.sty:35 | `slide.beamer-template` | `alerted text` fg=sotonora |
| body text colour | soton-beamer.sty:36 | `slide.beamer-template` | `normal text` fg=sotonbei |
| title-like elements | soton-beamer.sty:37 | `slide.beamer-template` | `titlelike` fg=sotonora |
| author and date on the title slide | soton-beamer.sty:38-39 | `slide.beamer-template` | `author` fg=sotonbei; `date` fg=sotonbei |
| list bullets | soton-beamer.sty:40 | `slide.beamer-template` | `item` fg=sotonmet |

Components the zip does not define (no row, nothing to recover): theme (no `\usetheme`, `\usecolortheme`, `\usefonttheme`, `\useinnertheme`, `\useoutertheme`; grep finds none), fonts, page size, header/footer, headings, lists, theorems, floats, tables, code, bibliography. The comment at soton-beamer.sty:13-14 and soton-palette.sty:20-21 says the brand font Freight is unavailable and Georgia is the substitute for academic slides; no font command follows, so no font way is claimed.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `soton-palette.sty` | soton-palette.sty:30-53 | yes | A CTAN package (ctan.org/pkg/soton, bundle of `soton-palette` and `soton-beamer`, licence LPPL, path macros/latex/contrib/soton), so W1 holds. Its whole effect is `\RequirePackage{xcolor}` plus 13 `\definecolor{name}{rgb}{...}`: `color.xcolor`. No macro, conditional or counter. |
| `soton-beamer.sty` | soton-beamer.sty:23-40 | yes | Same CTAN bundle. Its whole effect is `\RequirePackage{soton-palette}` plus 10 `\setbeamercolor` calls: `slide.beamer-template` over `class.beamer`. No macro, conditional or counter. |
| `DarkRed` dependency | soton-beamer.sty:32 | yes (recorded gap in the zip, not a blocker) | The emitter passes `svgnames` to `xcolor` (a `color.xcolor` parameter), or writes the colour with `\definecolor`. Without it the name has no definition from this zip; whether beamer errors at the `\setbeamercolor` call or at first use of the `button` colour was not checked. |

Everything else in the zip is a comment or header text (soton-beamer.sty:1-21, soton-palette.sty:1-28). README:1-3 is a garbled sentence about the 2008 UoS brand and the package; README:5-6 names the author (Max Blanco) and the licence (lppl). No text addressed to an AI.

## Content-opaque
none

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes for the consolidator
- Evidence about the colour dimension only: no main sample, no body construct, no `.tex` to read. Nothing is said about how a deck built on these colours looks beyond the colour assignments, because the zip sets no theme.
- Ways used: `class.beamer` (inferred), `color.xcolor`, `slide.beamer-template`.
