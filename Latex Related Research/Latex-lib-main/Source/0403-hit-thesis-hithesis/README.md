# HIT Thesis starter (hithesis)

A starter for a Harbin Institute of Technology degree thesis, using the
official `hithesis` document class: bilingual covers, Chinese and English
abstracts with keywords, numbered chapters, and the university's required
conclusions and acknowledgements sections.

## Files

- `main.tex` — the thesis. Start here.

## The class is deliberately NOT included

`hithesis.cls` ships with TeX Live, so this download does not bundle a copy.
Shipping one would pin you to whatever version we packaged rather than the
version your own system already has.

If your distribution does not have it: https://ctan.org/pkg/hithesis

## Building

    xelatex main
    xelatex main
    xelatex main

Three passes: this starter has no bibliography, but the table of contents and
the cross-references still need the extra runs to settle. Add a `bibtex main`
between the first and second pass once you add a `.bib` file.

**XeLaTeX is required, not preferred.** `hithesis` loads `ctexbook`, which
loads `xeCJK`; none of that works under pdflatex, so a pdflatex run fails at
the class rather than producing a worse-looking PDF.

## Two options you will want to check first

`type=` selects your degree: `bachelor`, `master` (used here) or `doctor`.
It changes the cover sheets, the page-numbering rules, and whether the thesis
is set single- or double-sided — so it is not cosmetic.

`fontset=fandol` is set explicitly. Left unset, `ctex` probes the system for
CJK fonts and prefers Windows faces (SimSun/SimHei) that exist on almost no
Linux machine, and the run then aborts with a font-not-found error even though
the class itself is installed correctly. Fandol ships with TeX Live, so naming
it makes this starter compile identically everywhere. On a machine that has
the official Chinese fonts, drop the option to get the exact submission
typefaces.

## Two traps worth knowing

**The cover macro is `\makecover`, not `\maketitle`.** The class does
`\let\title\@gobble` and never redefines `\maketitle`, so calling `\maketitle`
reaches LaTeX's stock version, which has no title and stops the run with
`! LaTeX Error: No \title given.`

**`newtxmath=false` is set to work around a clash inside the class itself.**
`hithesis` loads `newtxmath` and then, some eighty lines later, `amssymb`;
both define `\Bbbk`, so the default options abort with
`! LaTeX Error: Command \Bbbk already defined.` before typesetting anything.
The class ships this boolean as its own escape hatch.

## Before you submit

Replace every `\hitsetup` field with your own details, and check the current
HIT thesis regulations — the required front matter changes between years and
between degree levels.

## Licence

`hithesis.cls` is licensed **LPPL-1.3a**, © 2017–2022 Chu Yanshuo. The
upstream README additionally offers the work under CC-BY-NC-4.0, but that is
an *additional* grant: the `.dtx`/`.ins` sources that generate the class, and
the generated `hithesis.cls` itself, carry the LPPL notice only. This starter
is built on the LPPL basis. The class is not redistributed here; see
https://ctan.org/pkg/hithesis.

This starter document is a minimal example written for latextemplates.com and
carries no additional restrictions.
