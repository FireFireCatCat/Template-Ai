# ESIEEcv

A French-format CV built on the `ESIEEcv` package (CTAN path `ESIEEcv`,
catalogue name `esieecv`) — `\begin{rubrique}{...}` sections holding
`sousrubrique` entries (`\Titre`, `\Lieu`, `\Date`, `\Duree`, `\Descr`,
`\Apport`) laid out in a two-column table. It ships with this TeX Live
install (`esieecv/ESIEEcv.sty`), so nothing is vendored here.

## French only, by design

The class is written for the French job market and its structural
chrome — the way `rubrique`/`sousrubrique` compose a CV — assumes
`\usepackage[frenchb]{babel}`; this starter keeps that. It has no
language option and no English labels to switch to, so this ships as
a **French-language CV template** rather than a fabricated English
translation of what the class hardcodes. If you need an English CV,
pick a different template from the catalogue.

## Files

- `main.tex` — the CV. Start here.

## Version skew: `frenchb` to `french`

Upstream's own 1997 example loads `\usepackage[frenchb]{babel}`. Under
this TeX Live 2025's babel, the legacy `frenchb` option name breaks
during `\begin{document}` (`\bbl@main@language` undefined, cascading
into several more errors) — babel's French module has moved on since
1997 even though `frenchb.ldf` still exists on disk. `main.tex` here
uses the current option name, `\usepackage[french]{babel}`, which
compiles clean; no other change to the package or its macros was
needed.

## Licence

No licence statement could be found anywhere in the upstream package
(`ESIEEcv.dtx`, `ESIEEcv.ins`) — grepped the entire `.dtx` for
licence/LPPL/copyright/GPL/CC-BY/public-domain terms and found none.
The file carries only author credit (Benjamin Bayart, with an original
idea by Pierre Le Maguet) and a 1997 French/English abstract. CTAN's
own catalogue tags this `lppl`, but that grant text does not actually
appear in the package. Authors, per the `.dtx`: Benjamin Bayart and
Pierre Le Maguet.

## Building

    pdflatex main
