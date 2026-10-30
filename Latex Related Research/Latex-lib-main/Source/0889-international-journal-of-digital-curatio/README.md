# International Journal of Digital Curation (IJDC)

Article template for the *International Journal of Digital Curation* (and
the co-located International Digital Curation Conference, IDCC), using the
official `ijdc-v14` class from the `dccpaper` bundle. This is the class
current from IJDC volume 14 onward — check the journal's own current
submission requirements before you send a manuscript, since a bundled
starter can go stale.

- **Bundled, not in TeX Live:** `ijdc-v14.cls` and `dccpaper-base.sty` are
  vendored here (extracted from the upstream `.dtx` via docstrip in the
  pinned compiler, so they are byte-identical to a full TeX Live install).
- **`dccpaper-by.pdf` is also bundled and required**: the class's own
  `\maketitle` unconditionally stamps a Creative Commons Attribution 4.0
  badge onto every article's title page. That licenses the *output article*,
  not this class — the class text itself is LPPL-1.3c.
- **Bibliography:** the class supports both `biblatex` and `apacite`. This
  starter uses `apacite` (classic BibTeX) rather than `biblatex`, because the
  compiler behind this site runs BibTeX, not biber.
- For a conference submission use `\documentclass[<year>,paper]{idcc}`
  instead — a sibling class in the same bundle, not included here.

Licence: LPPL-1.3c, (c) Digital Curation Centre, University of Edinburgh. See
<https://ctan.org/pkg/dccpaper>.
