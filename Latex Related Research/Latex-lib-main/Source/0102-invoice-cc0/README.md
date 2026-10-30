# Yet Another Invoice Template (latex-yait)

A distinctively styled single-page invoice: a large display-font
company name, a dark accent-color recipient block, an item table, and
a footer with bank details and payment terms.

## Two things patched from upstream

**Item totals are typed, not computed.** Unlike every other invoice
template in this batch, this class has no arithmetic engine — the
upstream example literally types `150€`, `250€`, etc. directly into
the table cells. There is nothing to catch a mistake here. The line
totals and grand total in `main.tex` (12.00x25=300.00, 9.50x40=380.00,
4.25x60=255.00, sum=935.00) were computed and checked by hand before
being typed in.

**Version-skew: tabu is broken on this TeX Live.** The upstream
template builds its item table with the `tabu` package's `longtabu`
environment (auto-fitting `X[]` columns, per-row `\taburowcolors`).
On this install, any document using `longtabu` hard-errors with a
cascade of "Dimension too large" from `\end{longtabu}` — confirmed by
bisecting the package list: a bare `longtabu` table compiles fine
until `longtable` is loaded, which `longtabu` itself *requires* and
refuses to run without, regardless of load order. This is the
well-documented `tabu`/modern-LaTeX-kernel incompatibility (`tabu` has
been effectively unmaintained for years), not something a one-line
option fixes. Replaced the item table with plain `longtable` +
`\rowcolor` (from `xcolor[table]`), which reproduces the same
striped-row look with no auto-fit column math, and compiles cleanly.
