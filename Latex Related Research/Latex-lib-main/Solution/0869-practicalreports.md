yes

# 0869-practicalreports: practicalreports (macros for science practical reports) and its manual

- Unverified: read from the source, not compiled.
- Source: Source/0869-practicalreports/ (origin: https://mirrors.ctan.org/macros/latex/contrib/practicalreports.zip; licence: LPPL 1.3c, practicalreports.sty:2 and README:4-6)
- Kind: report (the sample is the package's own manual, set in `article`; the package serves lab and practical reports)
- Lib: v6
- Engine: pdfLaTeX-compatible (no fontspec, unicode-math or Lua; the package loads `tikzducks`, `pdfpages`, `pgffor` at practicalreports.sty:6, all pdfTeX packages)
- Look carried by: mixed (the CTAN-published package `practicalreports.sty` supplies every macro; `article` 12pt, `geometry` and `parskip` in the sample preamble set the page)
- Class origin: tex-distribution-unbundled (`article` is not in the zip, practicalreports.tex:1; the source of `article` was not read)
- Main file: practicalreports.tex (other samples: none)
- Read: main yes, zip-local classes and styles all (one file, practicalreports.sty, 199 lines; README read; practicalreports.pdf and the six images not read, they are the compiled manual and screenshots)

## Verdict
Yes. The zip is the CTAN release of the package `practicalreports` v2.0.3 (the version at practicalreports.sty:5 matches ctan.org/pkg/practicalreports, read: LPPL 1.3c, in TeX Live and MiKTeX), so W1 holds and the lib already has the way `report.practicalreports`. An emitter writes `\documentclass[12pt]{article}`, `geometry`, `parskip` and `\usepackage{practicalreports}`, then the sample's package calls and kernel body; no zip-local macro logic is copied. As a cross-check, every macro of the `.sty` also reduces to lib ways (Bespoke code table), with one exception: the unused `\duckfoot` (practicalreports.sty:157-189) draws a TikZ footer with `tikzducks` plus raw `\fill` and `\clip` paths. It is a fixed picture produced by the published package, not code of the sample or of a zip-local style, so it is not counted as `ART` (as with `cal.litetable`, whose picture the package produces). This rests on counting a published package as a way; see Blockers for the stricter reading.

## Blockers
none

Considered and not counted: `ART/package` hand-drawn footer `\duckfoot` (practicalreports.sty:157-189, `\duck[...]` of `tikzducks` at 160-161, 164-166, 170-171, 182 and free paths `\fill` at 172-175 and 180, 185, `\clip` at 179, 184). It is never called in practicalreports.tex and not documented there or in README. If a reader refuses to accept `report.practicalreports` as a way and demands every macro be rebuilt from other lib ways, this item flips the verdict to `no`; nothing else would.

## Class setting
- Class: `class.article` options: `12pt` (practicalreports.tex:1)
- Class-native vocabulary used: `titlepage` environment (12-21), `\tableofcontents` (23), `\listoffigures` (343), `\listoftables` (347), `\section` `\subsection` `\subsection*` `\subsubsection` (26, 53, 103, 109), `itemize` (35-45). No `\maketitle`, no `abstract`, no bibliography.

## Component map
Rows marked "package" are commands of the published package; its inner reduction is given after the `=`. Citations are practicalreports.tex (tex) or practicalreports.sty (sty).

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | tex:1 | `class.article` | 12pt |
| paper and size | tex:1 | `page.class-options` | `12pt`; no paper option, the class default stays |
| page geometry | tex:3 | `page.geometry` | right=1in, top=1in, left=1in, bottom=1in |
| paragraph spacing | tex:5 | `sp.parskip-pkg` | parfill |
| report package load | tex:7, sty:4-6 | `report.practicalreports` | no options; it requires mathtools, array, longtable, scrextend, float, fancyhdr, lastpage, tikzducks, pdfpages, pgffor |
| title block | tex:12-21 | `front.titlepage-env` | `titlepage` environment, hand-laid; no `\title` `\maketitle` |
| title spacing | tex:13, 15-17, 20 | `sp.manual-space` | `\vspace*{\fill}` twice; line breaks `\\[0.5cm]` `\\[0.4cm]` `\\[0.2cm]` |
| title alignment | tex:14-19 | `sp.ragged` | `center` environment |
| title fonts | tex:15-18 | `font.size-commands`, `mark.kernel` | `\Huge` `\Large` `\small`; `\textbf` on the package name |
| contents | tex:23 | `toc.kernel` | `\tableofcontents`, no options |
| page break | tex:24 | `pg.break` | `\newpage` |
| headings | tex:26, 53, 103, 109, 114 | `head.kernel` | `\section` to `\subsubsection`, one `\subsection*`; no counter or format changes |
| bullet list | tex:35-45 | `list.kernel` | `itemize`, items start with `\textbf{name}` |
| inline notation | tex:54, 59, sty:127, 130 | `math.kernel` | `\E{n}` expands to `$\times10^{n}$`; `\e{n}` to `\times10^{n}` for use inside maths; inline `$...$` elsewhere (17, 54) |
| figure with bold title | tex:67, 69, 76, 83, 93, 101, sty:35-43 | `report.practicalreports` (= `fig.float`, `fig.graphicx`, `cap.kernel`, `xref.kernel`, `mark.kernel`, `sp.manual-space`, `sp.ragged`) | `\newfigure{title}{caption}{file}{label}`: float `[H]`, `\textbf{title}`, `\medskip`, `\includegraphics[width=\textwidth]`, `\caption`, `\label{fig:label}` |
| scaled figure | tex:112, 117, sty:46-54 | `report.practicalreports` (= same inner ways) | `\newsfigure{...}{label}{factor}`: `\includegraphics[scale=factor]`, factors 0.4 and 1.6 |
| figure reference | tex:65, 72, 79, 90, sty:57 | `report.practicalreports` (= `xref.kernel`) | `\reffigure{label}` prints `Figure~\ref{fig:label}` |
| table | tex:158-165, sty:64-79 | `report.practicalreports` (= `fig.float`, `cap.kernel`, `sp.manual-space`, `tbl.tabular`, `sp.ragged`, `xref.kernel`) | `\newtable{caption}{colspec}{header}{rows}{label}`: float `[H]`, centred, caption above, `\vspace*{5mm}`, `\hline` above and below header and below rows; colspec `lcr` |
| long table | tex:234-277, sty:86-107 | `report.practicalreports` (= `tbl.longtable`, `cap.kernel`, `mark.kernel`, `xref.kernel`, `sp.ragged`) | `\newlongtable{...}`: `\endfirsthead` `\endhead` `\endfoot` `\endlastfoot`, repeated header with `\hline`, continuation caption `\textit{Continued}`; `\label` comes before `\caption` (sty:89-90) |
| table reference | tex:146, 187, 288, 293, sty:110 | `report.practicalreports` (= `xref.kernel`) | `\reftable{label}` prints `Table~\ref{table:label}` |
| boxed answer | tex:298, 305, 315-317, sty:113-121 | `report.practicalreports` (= `math.amsmath`, `math.mathtools`, `sp.lengths`) | `\boxanswer{content}`: `equation*`, `\boxed{gathered}`, `\addtolength{\fboxsep}{5pt}`; sample also uses `\text{}` (305) |
| list of figures and tables | tex:343, 347 | `toc.kernel` | `\listoffigures`, `\listoftables` under hand-typed `\subsection` titles "Appendix A/B" (341, 345); no `\appendix` |
| page style setup (documented, not called) | sty:134-137, tex:64-69 | `report.practicalreports` (= `hf.fancyhdr`) | `\setpagefancy`: `\pagestyle{fancy}`, `\fancyhf{}` |
| header and footer fields (documented, not called) | sty:140-151, tex:72-83 | `report.practicalreports` (= `hf.fancyhdr`) | `\header{l}{c}{r}` sets `\lhead \chead \rhead`; `\footer{l}{c}{r}` sets `\lfoot \cfoot \rfoot` |
| page X of Y footer (documented, not called) | sty:154-155, tex:326-328 | `report.practicalreports` (= `hf.fancyhdr`, `pgnum.lastpage`, `xref.kernel`) | `\goodfoot`: `\cfoot{Page \thepage \ of \pageref{LastPage}}` |
| duck footer (not documented, not called) | sty:157-189 | `report.practicalreports` (inner: `hf.fancyhdr` `\cfoot`, `art.tikz` with `tikzducks`) | `\duckfoot`: no parameters; four `tikzpicture` scale=0.6 with `\duck[...]`; defined inside the body of `\goodfoot` (154-190), so it exists only after `\goodfoot` has run |
| title page macro (documented, not called) | sty:22-32, tex:89 | `report.practicalreports` (= `front.titlepage-env`, `sp.manual-space`, `sp.ragged`, `font.size-commands`) | `\newtitlepage{title}{author}{date}`: `\Huge` `\Large` `\small`, `\\[0.5cm]` `\\[0.4cm]`; same layout as tex:12-21 |
| indented block (documented, not called) | sty:10-16, tex:322 | `report.practicalreports` (= `list.scrextend`, `box.minipage`) | `\shift{n}{text}`: `addmargin[ncm]{0cm}` around `minipage{\textwidth}` |
| merge PDFs (documented, not called) | sty:195-199, tex:330-337 | `report.practicalreports` (= `pg.include-pdf`) | `\joinpdfs{a, b, c}`: pgffor `\foreach` over names, `\includepdfmerge{name, -}` each |

## Bespoke code
By W1 nothing here is bespoke: `practicalreports.sty` is the CTAN release, and the sample defines no macro of its own (no `\newcommand`, `\def`, counter or environment in practicalreports.tex). The table checks each macro of the package anyway, to show the emitter has two routes.

| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\shift` | sty:10-16 | yes | `list.scrextend` `addmargin[ncm]{0cm}` around `box.minipage` width `\textwidth` |
| `\newtitlepage` | sty:22-32 | yes | `front.titlepage-env`, `sp.manual-space`, `font.size-commands` (see tex:12-21) |
| `\newfigure`, `\newsfigure` | sty:35-54 | yes | `fig.float` `[H]`, `\centering`, `\textbf`, `fig.graphicx` (width or scale), `cap.kernel`, `xref.kernel`; the `\center{...}` call at 38 and 49 is `\centering` in effect. `graphicx` is not named in the sty or the sample (it must come in through another package); an emitter loads it explicitly |
| `\reffigure`, `\reftable` | sty:57, 110 | yes | inline `Figure~\ref{fig:..}` and `Table~\ref{table:..}` (`xref.kernel`) |
| `\newtable` | sty:64-79 | yes | `fig.float`, `cap.kernel`, `sp.manual-space`, `tbl.tabular` with `\hline` |
| `\newlongtable` | sty:86-107 | yes | `tbl.longtable` head, foot and last-foot declarations, `cap.kernel`, `mark.kernel` |
| `\boxanswer` | sty:113-121 | yes | `math.amsmath` `equation*` and `\boxed{gathered}`, `sp.lengths` `\fboxsep` |
| `\E`, `\e` | sty:127, 130 | yes | inline expansion to `\times10^{n}` (`math.kernel`) |
| `\setpagefancy`, `\header`, `\footer` | sty:134-151 | yes | `hf.fancyhdr` `\pagestyle{fancy}`, `\fancyhf{}`, `\lhead` to `\rfoot` |
| `\goodfoot` | sty:154-155 | yes | `hf.fancyhdr` `\cfoot` with `pgnum.lastpage` `\pageref{LastPage}`; it holds the `\duckfoot` definition (157-189), so a second call would redefine `\duckfoot` with `\newcommand` |
| `\duckfoot` | sty:157-189 | not by lib ways other than the package way | `art.tikz` with `tikzducks` `\duck[keys]` (CTAN `tikzducks`, LPPL 1.3c, in TeX Live and MiKTeX, read at ctan.org/pkg/tikzducks) plus raw `\fill`/`\clip` paths (172-175, 179-180, 184-185); only the package route (`report.practicalreports`, no copy) covers it |
| `\joinpdfs` | sty:195-199 | yes | `pg.include-pdf` `\includepdfmerge{name, -}` once per name; the `\foreach` loop (pgffor, PGF, CTAN) only repeats the call, so the emitter unrolls it (considered: `pgffor`, not proposed) |

## Content-opaque
none. The six images (tex:67-117) are figure content included by `\includegraphics` and shipped in the zip; the 1-2-3 table cells (160-164, 237-276) are cell content. The sample contains no TikZ or other drawing.

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
- Note for the consolidator: `report.practicalreports` was added in v4 from a zip that used the package unread (the Solution file of 0181 says its source was not read); this zip is the package source. It confirms W1 (ctan.org/pkg/practicalreports read), and shows the commands beyond the lib line's list: `\newfigure` `\newsfigure` `\reffigure` `\newlongtable` `\reftable` `\footer` `\duckfoot` `\joinpdfs` `\E` `\e`, with the `tikzducks` footer drawing as a fixed command of the same way.
