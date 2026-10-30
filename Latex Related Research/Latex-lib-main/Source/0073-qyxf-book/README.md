# qyxf-book

A minimalist `ctexbook`-based class for Chinese course/study materials
— coloured theorem boxes (via `tcolorbox`), several colour schemes,
and clean chapter/section styling. Originally developed by Qian Yuan
Xue Fu, a student club at Xi'an Jiaotong University's Qian Xuesen
College, for their own course-helper handouts.

## What was changed from upstream

Upstream's own demo document (`demo.tex`, a self-documenting manual)
sets `\cover{}`, `\org{}` and `\license{}` to the club's own
logo/organisation name and a Creative Commons notice. `\cover` is
optional and empty by default, but **`\org` and `\license` are NOT** —
the class's own defaults render "Qian Xuesen College Academic Support
Centre / Xi'an Jiaotong University" and a **CC BY-NC-ND 4.0** licence
statement directly on the title page unless overridden. This starter
clears all three explicitly (`\org{}`, `\footorg{}`, `\license{}`), the
same way upstream's own demo does, so it carries neither the club's
branding nor an inaccurate non-commercial licence claim.

## Class

Not bundled — ships with TeX Live. `colorscheme=basic` is one of
several available schemes; see the class's own `demo.tex` (installed
alongside the class) for others.

## Licence

MIT, verified in the upstream repo's own `LICENSE` file. (c) 2020 Qian
Yuan Xue Fu.

## Build

```
xelatex main && bibtex main && xelatex main && xelatex main
```
