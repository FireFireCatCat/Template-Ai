# KorigamiK assignment

A university assignment/homework starter with a designed cover page —
boxed title with a corner label, an optional logo, and a
name/roll-no/semester/course table.

- **Engine:** pdflatex
- **Class:** `korigamik` (ships with TeX Live — not bundled here)
- **Licence:** GPL-3.0-or-later, verified directly in the shipped
  `korigamik.cls` header.

Despite reading as a generic "article" class, `korigamik` is actually an
assignment cover-page class: `\maketitle` builds the designed title page,
then the document continues as plain `article` body text and sectioning.

## Notes

- `<your logo here>` is the class's own placeholder, shown whenever
  `\logoimage{path}{scale}{label}` is not called — add a real image with
  that command to replace it.
- Other title-block commands beyond `\title`/`\author`: `\rollno`,
  `\subject`, `\course`, `\semester`, `\titlelabel` (the corner box text,
  e.g. "Assignment"), `\header` (running head on later pages),
  `\bottomnote` (institute/department line under the date).
- Bibliography uses classic `bibtex` with the standard `plain` style.
