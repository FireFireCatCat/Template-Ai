# TIET Question Paper

An exam-paper layout: a roll-number line, course code/name, time and
maximum-marks header, an instructions block, and hard-ruled dividers
between numbered questions.

## Files

- `main.tex` — the exam. Start here.
- `tiet-question-paper.cls` — the vendored, patched document class (see
  below; not on a default TeX Live install).
- `LICENSE` — upstream MIT licence.

## Building

    pdflatex main

## A real upstream bug, patched here

`\instlogo{}` (for an institution's crest) initialises its internal
variable to `\relax`, but `\maketitle`'s own fallback check compares it
against `\@empty` — so the check never matches, and `\maketitle`
unconditionally tries to include a logo image even when `\instlogo{}` is
never called. Any institution shipping this template without its own
logo file gets a hard `File ... not found` error, not a graceful
no-logo layout (confirmed: this is also why the upstream's own sample
document references a logo file, `images/tiet-logo.pdf`, that isn't even
included in the CTAN or GitHub distribution). This copy of
`tiet-question-paper.cls` is patched so the fallback check actually
works, and this starter deliberately omits `\instlogo{}`. Call
`\instlogo{path/to/logo.pdf}` in your own copy to add a crest.

## Licence

MIT, © 2024 B.V. Raghav.
Source: https://github.com/bvraghav/qptiet_latex-class
