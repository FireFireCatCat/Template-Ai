yes

# 0635-modernposter: modernposter (A0 poster, metropolis-inspired colours)

- Unverified: read from the source, not compiled.
- Source: Source/0635-modernposter/ (origin: https://latextemplates.com/downloads/modernposter.zip; licence: CC-BY-SA-4.0, as the manifest and `ATTRIBUTION.txt:3` state; `ATTRIBUTION.txt:1` names David Derler and contributors and `ATTRIBUTION.txt:4` points to https://ctan.org/pkg/modernposter)
- Kind: poster
- Lib: v5
- Engine: pdfLaTeX-compatible (the sample loads no engine-specific package; the class source is not in the zip and was not read, so this follows the `pdf` tag of the existing lib line `poster.modernposter`)
- Look carried by: class (the zip holds only `main.tex` and `ATTRIBUTION.txt`; every look decision is inside the published class `modernposter`, `main.tex:2`)
- Class origin: tex-distribution-unbundled (class `modernposter` is on CTAN, v1.03.1 of 2018-04-03, CC BY-SA 4.0, listed in TeX Live and MiKTeX, described there as a class extending `a0poster`; one read of ctan.org/pkg/modernposter; the zip does not contain `modernposter.cls`)
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present (the published class source was not read)

## Verdict
The zip is a 65-line sample plus an attribution note. The only code in it is the document itself (`main.tex:1-65`), which defines no macro, environment, counter or conditional and has no `\usepackage` line. The whole look comes from the published CTAN class `modernposter`: its native vocabulary (`postercolumn`, `\posterbox`, `\email`) is the lib way `poster.modernposter` beside the class way, and the rest of the body is kernel `itemize`, `tabular` and `\centering`. The one `tikzpicture` is a figure placeholder inside a box (`main.tex:27-32`), so it is content, not template artwork. `yes`, with the caveat that the class internals were not read: what the class loads (it must supply TikZ, since the sample loads nothing) is not confirmed, so an unconditional external-tool package inside the class cannot be ruled out from this zip, only judged unlikely for a TeX Live class whose lib line is tagged `pdf` with no EXTERNAL note.

## Blockers
none

## Class setting
- Class: `class.modernposter` options: none (`main.tex:2`, `\documentclass{modernposter}`; the lib line for `poster.modernposter` lists the class options `hlcolor` `logo` `helvet`, none used here)
- Class-native vocabulary used: front matter `\title` `\author` `\email` `\maketitle` (`main.tex:4-6`, `main.tex:9`); environment `postercolumn` (`main.tex:11`, `main.tex:37`); `\posterbox{title}{content}` (`main.tex:12`, `main.tex:18`, `main.tex:25`, `main.tex:38`, `main.tex:47`, `main.tex:52`, `main.tex:56`). Not used: `\doubleposterbox`, `\highlight`, the optional height argument of `\posterbox`. The class is layered on `a0poster` (the sample says so at `main.tex:14`; the CTAN page says the same).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class | main.tex:2 | `class.modernposter` | no options |
| page size (A0 portrait) | main.tex:1, main.tex:14 | `page.a0poster` | inherited through the class (it extends `a0poster`); the sample passes no option; inferred from the comment and the prose, the class source was not read |
| colour scheme | main.tex:1, main.tex:13-14 | `poster.modernposter` | default metropolis-inspired scheme fixed inside the class; the sample defines no colour; option `hlcolor` (from the lib line) not used |
| title block | main.tex:4-6, main.tex:9 | `front.maketitle` | `\title`, `\author`, `\maketitle` as the kernel names them; the class renders them as a poster header (the CTAN page says the class provides a `\maketitle` header) |
| title block, e-mail field | main.tex:6 | `front.class-native` | `\email{...}`, a class command (the kernel has no `\email`) |
| poster columns | main.tex:11-35, main.tex:37-63 | `poster.modernposter` | two `postercolumn` environments one after the other; three boxes in the first, four in the second |
| poster blocks (box title and content) | main.tex:12, 18, 25, 38, 47, 52, 56 | `poster.modernposter` | seven `\posterbox{title}{content}` calls, none with the optional height argument |
| prose boxes (Introduction, Discussion, Conclusion) | main.tex:12-17, main.tex:47-51, main.tex:52-55 | `poster.modernposter` | plain paragraphs in the content argument |
| bullet list | main.tex:19-23 | `list.kernel` | `itemize` with three `\item`, default labels, in the Methods box |
| centred content | main.tex:26, main.tex:33, main.tex:39 | `sp.ragged` | `center` environment (`main.tex:26-33`) and `\centering` (`main.tex:39`) |
| result table | main.tex:40-45 | `tbl.tabular` | `tabular{lcc}`, one `\hline` after the header row (`main.tex:42`), no float, no caption |
| inline monospace | main.tex:14 | `mark.kernel` | `\texttt{a0poster}` |
| references box | main.tex:56-62 | `poster.modernposter` | two hand-typed paragraphs `[1]` and `[2]` in a box; no `thebibliography`, no `\cite`, so no `bib.*` way is used |
| figure placeholder (content) | main.tex:27-32 | `art.tikz` | content inside the Result Figure box: `tikzpicture` with a `rectangle`, two dashed diagonals and one `node`; not template artwork, see Content-opaque |
| size switch inside that placeholder | main.tex:31 | `font.size-commands` | `\Large` on the node text |

No header or footer, sectioning command, theorem, caption, float, index, language or metadata setting appears in the sample (`main.tex:1-65`); the class may set some of these internally (not read).

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| none defined in the zip | main.tex:1-65 (no `\newcommand`, `\def`, `\newenvironment`, counter or conditional) | n/a | n/a |
| class `modernposter` internals (not read) | not in the zip; published CTAN class | n/a, published (W1: ctan.org/pkg/modernposter) | counted as the one way `class.modernposter` plus `poster.modernposter`; the sample calls its commands with arguments only |

## Content-opaque
- `tikzpicture` placeholder (a rectangle, two dashed diagonals, a `\Large` node "figure placeholder") inside the Result Figure box, `main.tex:27-32` (`art.tikz`; content, since it stands in for a result figure and is not part of the poster's own look). The sample loads no TikZ package itself (no `\usepackage` line anywhere in `main.tex`), so `tikz` must come from the class; this was not confirmed against the class source.

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
