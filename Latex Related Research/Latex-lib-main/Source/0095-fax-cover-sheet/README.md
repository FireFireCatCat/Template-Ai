# Fax Cover Sheet (facsimile.cls)

A fax transmission cover sheet: boxed to/from/date/page-count header plus
an optional note box, then the usual `\opening`/`\closing` letter body
below it.

## Patched: version-skew in the page-count logic

`facsimile.cls` is from 2003 and reads the `lastpage` package's
`\r@LastPage` label via a kernel helper (`\@cdr`) that no longer exists
in the TeX Live 2025 LaTeX2e kernel, and that helper itself assumed the
OLD 2-field `\newlabel{name}{{page}{page}}` format. The current kernel
writes `\newlabel{LastPage}{{}{2}{}{}{}}` (5 fields), so a literal port
of the old code would grab an empty first field instead of the page
number regardless. Left unpatched, `\ifcase\@lstpgno` (used only to pick
the singular/plural "page"/"pages" word) hard-errors with "Missing
number, treated as zero" and the compile fails outright.

`main.tex` redefines `\@lstpgno` with a plain delimited-argument macro
that pulls the second brace group out of `\r@LastPage` — the field that
actually holds the page number in the current format. Verified against
this pipeline's real `lastpage` output, not guessed.
