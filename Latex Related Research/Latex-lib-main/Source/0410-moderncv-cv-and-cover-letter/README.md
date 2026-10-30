# moderncv — CV and cover letter

The upstream `moderncv` document class (CTAN, LPPL-1.3c), styled `classic`.
This is the class most "how to write your CV in LaTeX" tutorials point at.

## Files

- `main.tex` — the CV. Start here.
- `cover_letter.tex` — a matching cover letter, same class, same personal
  details. Compiles to its own, separate PDF.

## The class is deliberately NOT included

`moderncv.cls` ships with every modern TeX distribution, so this download
does not bundle a copy. If your distribution does not have it:
https://ctan.org/pkg/moderncv

## Building

    pdflatex main
    pdflatex cover_letter

Two passes each are enough here (no bibliography, no cross-references).

## Choosing your style

moderncv ships six built-in styles. Switching is a one-word change to
`\moderncvstyle{...}` in both files:

| Style          | Look                                              |
|----------------|----------------------------------------------------|
| `classic`      | this starter — plain section rules, left-aligned  |
| `casual`       | more relaxed spacing, softer rules                |
| `banking`      | conservative, right-aligned dates                 |
| `oldstyle`     | serif body text, old-style figures                |
| `fancy`        | thin horizontal rule under each section heading   |
| `contemporary` | two-tone header band                              |

`\moderncvcolor{...}` takes `black`, `blue`, `burgundy`, `cerulean`, `green`,
`grey`, `orange`, `purple`, `red` independently of the style.

## Licence

`moderncv` is licensed **LPPL-1.3c**, © Xavier Danaux and the moderncv
maintainers. The class is not redistributed here; see
https://ctan.org/pkg/moderncv.

This starter document is a minimal example written for latextemplates.com
and carries no additional restrictions.
