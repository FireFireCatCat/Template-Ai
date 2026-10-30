# SciPoster

An A0 portrait scientific poster with a real 3-column layout: abstract,
introduction, related work, method, discussion, a TikZ system-architecture
diagram, evaluation setup, a results figure, a results table, an ablations
table, conclusions, references, acknowledgements. Built on Michael
Wilkinson and Alle Meije Wink's `sciposter` class (ships with TeX Live).

`sciposter` has no automatic multi-column layout (unlike `baposter` /
`tikzposter`) — the starter wraps the body in `multicol` itself. Edit
`\title`/`\author`/`\theinstitute`/`\conference` at the top of `main.tex`,
then edit each `\Section{...}` block.

## Licence

**UNKNOWN.** CTAN's catalogue tags this package LPPL, but no licence grant
of any kind was found in the vendored `sciposter.cls` (checked directly —
only a bare authorship comment) or in its bundled README. Per this batch's
licence policy, an unfound grant ships as UNKNOWN rather than trusting the
catalogue tag. Author per the class header: Michael H.F. Wilkinson and
Alle Meije Wink. Source: https://ctan.org/pkg/sciposter

## Patches

Two real failures found and fixed while building this starter:

1. **An earlier draft filled only the top third of the A0 sheet** — the
   exact failure this batch was warned about, via `multicol`'s default
   column-balancing (which shrinks to fit short content, it does not
   stretch to fill the page) rather than a stretch bug, compounded by a
   stray `\vfill\null\columnbreak` forcing an early column break. Fixed by
   removing the forced break and writing substantially more genuine
   content (Related Work, an extended Method, Discussion, a system
   architecture diagram, a second evaluation figure, an ablations table)
   so the three columns fill most of the page height on their own.
2. **A TikZ architecture diagram sized for the full poster width
   overlapped itself and ran its caption off the column edge** once placed
   inside a `multicol` column (~15cm wide on an A0 sheet, not the ~80cm
   the original wide layout assumed). Rebuilt as a single vertical flow
   (each pipeline stage stacked top-to-bottom) sized to fit one column.
