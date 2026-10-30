# Multilingual Wall Calendar

A full-page A4 ("giant") 12-month wall calendar with a cover page, dated
single- and multi-day events with icons, mini prev/next-month strips in the
corner, and a per-month illustration slot. Built on LianTze Lim's
cdcalendar class.

Ships pre-set for **2026**, with a handful of example events (New Year's
Day, a 5-day conference, a birthday, a deadline, Christmas Day) to show how
`\event{start-date}{num-days}{label}` works — see the calls inside each
`monthCalendar` environment in `main.tex`. Edit the year in each
`\begin{monthCalendar}{2026}{MM}` call to change it.

Localisable via `babel`/`translator`/`datetime2` — pass a language as a
class option (e.g. `\documentclass[17pt,german,giant]{cdcalendar}`) and see
the upstream repo's `more-samples/` directory for Chinese/Japanese variants
(xelatex/lualatex-only, since those use CJK fonts).

The class also supports smaller `small`/default (CD/floppy-disk jewel-case)
sizes and a `sundayweek` option — see the comments at the top of `main.tex`.

The illustration on January and July is a small self-contained TikZ
drawing (`\monthIllustration` in `main.tex`) rather than a raster image, so
this download has zero external asset dependencies — upstream's own
example instead includes third-party raster art. Swap it for your own
`\includegraphics` via `\illustration{width}{filename}`.

## Licence

CC-BY-4.0. No top-level `LICENSE` file — found in `COPYING` (a full CC-BY
4.0 legal-code file, included in this download as `LICENSE`), which is easy
to miss since it isn't named LICENSE. No grant text in `cdcalendar.cls`
itself. Copyright LianTze Lim. Source:
https://github.com/liantze/cdcalendar
