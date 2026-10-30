# Monthly Desk Planner (TikZ)

A landscape monthly planner drawn entirely in TikZ's `calendar` library, with
side panels for Focus / People to See / Places to Go / Not-To-Do List, and a
Personal Projects / Work Projects / Notes strip along the bottom. Built on
Juergen Hackl's tex-calendar.

Ships pre-set to **March 2026**. To change the month, edit `\YYMM` near the
top of `main.tex` (format `YYYY-MM`), e.g.:

```
\newcommand{\YYMM}{2026-08}
```

Requires **lualatex** (uses `fontspec`).

## Licence

GPL-3.0, per the upstream repository's `LICENSE` file (included in this
download). Copyright 2017 Juergen Hackl. Source:
https://github.com/hackl/tex-calendar

## Patches

- Upstream's `month.tex` is a fragment meant to be invoked as
  `lualatex "\newcommand{\YYMM}{2026-01} \input{month.tex}"` — `\YYMM` is
  used but never defined in the file, so compiling it directly failed with
  "Undefined control sequence". Defined directly in `main.tex` instead (see
  the PATCHED comment) so the file is a normal, directly-compilable document.
- Upstream hardcodes `\setmainfont{Fira Sans Light}`, a Google font not
  registered in this compiler's fontconfig. Substituted DejaVu Sans, which
  ships with every TeX distribution.
