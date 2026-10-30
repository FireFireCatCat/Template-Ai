# bewerbung — German job-application set

A cover letter (`Anschreiben`) and CV (`Lebenslauf`) driven by one shared
set of personal-data macros, from `ctan:bewerbung` (LPPL-1.3). Compiles to
one PDF: letter first, CV second.

## Files

- `main.tex` — start here.
- `config.inc` — your personal details (name, address, phone, ...), read
  automatically at the start of the document.
- `anschrift.csv` — the target company for this application. Each row is one
  application; `\ID{n}` in `main.tex` selects which row (here, row 1).

## The class is not included

`bewerbung.cls` ships with every modern TeX distribution — this download does
not bundle a copy. If yours lacks it: https://ctan.org/pkg/bewerbung

## Licence

LPPL-1.3, (c) Andr\'e Hilbig. Verified in the CTAN package header
(`bewerbung.dtx`) and the installed `.cls`/`.sty` file headers.
