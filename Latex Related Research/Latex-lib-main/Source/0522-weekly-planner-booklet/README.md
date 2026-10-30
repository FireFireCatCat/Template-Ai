# Weekly Planner Booklet

An A5-landscape weekpage-per-spread planner (folds to A6 for binding) with
an optional class timetable, built on Enrico Miccoli's TeXalendar `calendar`
class.

Ships with a class timetable plus 5 real weeks spanning **January-February
2026** (including a week that crosses the month boundary, to demonstrate
the `newmonth`/`newday` keys). To add more weeks or change the year, copy a
`\weekpage{...}` line in `main.tex` and edit the day numbers — see the
comment above the calls for what each key means.

Upstream normally generates a full year of `\weekpage{}` calls from a
`config.ini` via a Python script (`gencal.py`) at build time. This starter
writes the calls directly instead, so it compiles with no external build
step — extend the pattern in `main.tex` for a full year.

Requires **xelatex** (the class loads `polyglossia`+`fontspec`).

## Licence

MIT, per the upstream repository's `LICENSE` file (included in this
download). Copyright 2018 Enrico Miccoli. Source:
https://github.com/EnricoMiccoli/TeXalendar

## Patch

Found and fixed a real upstream bug while writing this starter: the class's
`\weekpage{}` defaults `newday=3` (Wednesday) and `newmonth=default` even
for a week that does NOT cross a month boundary — so a bare `\weekpage{...}`
call prints the literal word "DEFAULT" in the Wednesday margin instead of
the real month. Upstream's Python generator always sets both keys
explicitly per week, which hides this. Every `\weekpage{}` call in
`main.tex` now sets `newday=8` (out of range, so the stray label never
fires) unless the week genuinely crosses two months, in which case
`newday`/`newmonth` are set to the real crossover point.
