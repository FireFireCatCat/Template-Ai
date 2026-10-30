# paper article

A distinctive academic-article starter — bold sans-serif title/headings
against a serif body, with title, subtitle, italic author name, and
institution all laid out by the class's own `\maketitle` — using Wenzel
Matiaske's `paper` document class.

- **Engine:** pdflatex
- **Class:** `paper` (ships with TeX Live — not bundled here)
- **Licence:** CTAN tags this package GPL. The vendored `paper.cls` file
  itself carries no licence grant text anywhere — only a bare copyright
  line ("Copyright (C) 1993, 1998 by wenzel_matiaske@notes.uni-paderborn.de")
  and a note that the `.cls` may not be redistributed without its `.dtx`
  source. That note concerns the `.dtx`/`.cls` pairing itself and does not
  apply here, since this starter does not bundle the class. Shipped on
  CTAN's attested GPL licence, documented here for transparency.

## Notes

- Beyond plain `article`'s `\title`/`\author`, this class also provides
  `\subtitle{...}` and `\institution{...}`, both rendered as part of the
  title block by `\maketitle`.
- Bibliography uses classic `bibtex` with the standard `plain` style.
