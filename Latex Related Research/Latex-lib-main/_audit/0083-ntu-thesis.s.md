# Skeptic audit: 0083-ntu-thesis (analyst said yes)

Result: refuted = true, on one judgement call, not on a hard error. Unverified: read only, nothing compiled.

## What I searched
Read every file in Source/0083-ntu-thesis/ (Thesis.cls 556 lines, main.tex, Styles/mydefs.sty, Styles/lstpatch.sty, chapters, appendix, bib, LICENSE) and viewed ntu-watermark.png. Greps for `@startsection`, `@maketitle`, `@makecaption`, `@seccntformat`, `patchcmd`, `xpatch`, `\output`, `\halign`, `\newif`, `\write`, `write18`, `shell-escape`, `minted`, `lua`, `pgf`, `picture`, `overlay`, `eso-pic` use, and text addressed to an AI (none found). No network use.

## Not found (the analyst is right on these)
- No kernel-internal redefinitions of the rubric's named four. Redefined are `\maketitle`, `\tableofcontents`, `\listoffigures`, `\listoftables`, `\backmatter`, `\cleardoublepage` (Thesis.cls:99-103), `\today`, `\chaptermark`. All use only book's flags (`\if@twoside`, `\if@twocolumn`, `\if@restonecol`, `\if@openright`), which are fixed per document.
- The only counter is `dummy` (Thesis.cls:348); it prints nothing (hyperref anchor).
- No `\patchcmd`/`\xpatchcmd`, no output routine, no external tool. No `.eps` in the zip, so `epstopdf` (Thesis.cls:152) never calls a converter.
- Every `\usepackage` in Thesis.cls and main.tex has a row in the map. `tikz` (:449) has no row of its own, only the stamp row.

## Candidate blocker (borderline): ART/class
Thesis.cls:461-462, 483-484, 508-509 (loaded by `\usepackage{tikz}` at :449, whose only users are these three nodes): `\tikz[remember picture,overlay]\node[opacity=0.9,inner sep=0pt] at (2.13, 0.5){\includegraphics[width=4cm,height=1.527cm]{Styles/ntu-watermark.png}};`
- It is the template's own page decoration: an NTU "NTU NTU" tile stamped over the signature on all three declaration pages ("NTU Style 3 statements", :451). It is positioned by absolute offsets from a text-flow anchor.
- The task brief's pattern, "TikZ/overlay code for the template's own identity that the file counted as a way", fits it. Lib line `bg.tikzpagenodes` and the Restricted section both say a positioned overlay that draws identity is ART.
- The analyst's counter (the node holds one raster image, nothing is drawn) is true (checked by grep). Whether that exempts it is a judgement call. The file admits it flips to `ART/class` on a stricter reading (Bespoke row 14).
- The reduction offered (row 14) is asserted, not shown, and is wrong as written:
  - `\makebox[0pt][l]{...\raisebox{-0.2635cm}{\includegraphics[...,height=1.527cm]}}` keeps the image's height and depth, so the box is about 1.26cm high and 0.26cm deep. The overlay picture box has no extent. The line, and everything after it up to the `\vspace{-1.8cm}`, would move. It needs `\raisebox{..}[0pt][0pt]`, which the file does not say.
  - Line 462 ends `};` plus a newline, so a space token sits between the picture and `\makebox[4cm]`. "Immediately before" is not exact (about 3pt).
  - Neither flaw is fatal, but "same effect" is an overclaim.

## Weaker candidate (not listed as a blocker): BESPOKE/package
Styles/lstpatch.sty:79-388 is about 300 lines of `\def` redefinitions of listings internals (`\lst@Init`, `\lst@DeInit`, `\lst@GLI@`, `\lst@ScanChars`, `\lst@MSkipToFirst`...), loaded unconditionally at Thesis.cls:157. The analyst "reduces" it by dropping the file. That holds only because :64-73 `\lst@CheckVersion{1.3}{...\endinput}` ends the file on any listings other than 1.3. That is true of every current TeX Live, but the inertness depends on the distribution, not on the zip. I did not verify `\lst@CheckVersion`'s definition (no network). The analyst disclosed this as a judgement call.

## Citation check
Checked 55 file:line citations (most map rows, Bespoke rows 1-19, Class-setting lines, main.tex lines). 3 are wrong:
1. "page breaks" row cites Thesis.cls:58. That line is `%\cleardoublepage`, a comment inside the uncalled `\Declaration`. It is not a break, and the row's "after every front-matter page" is not true of `\Declaration`. The row also leaves out :342, 384, 414, 425, 436, 471, 493, 518, 533, 543.
2. "toc entries for unnumbered pages" row cites `Thesis.cls:348-351,67,551`. Thesis.cls:67 is `\onehalfspacing`. `\addtotoc{Abstract}` is main.tex:67.
3. "tables" row maps `tbl.booktabs` to Thesis.cls:154,406,417,428. Only :154 is booktabs. The other three are `\usepackage{longtable}`, which that row's way does not cover.

## Smaller overclaims
- `sp.penalties` row: `\doublehyphendemerits` (:85) and `\interfootnotelinepenalty` (:89) are not named by the lib line, which lists widow/club/broken. "Same family" stretches it; demerits is not a penalty.
- Bespoke row 3 maps the global `\def\today` redefinition (:62-65) to `front.datetime`. A named date format is not a redefinition of `\today`. Harmless only because the sample never calls `\today`.
- "Lib: v1" in the file; `_Lib.md` now reads v2.
