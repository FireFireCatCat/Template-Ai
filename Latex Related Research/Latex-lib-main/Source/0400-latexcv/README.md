# latexcv (classic style)

`jankapunkt/latexcv` (MIT) is a family of several visually distinct CV
templates kept in one repository. This starter ships the **classic** style;
main.tex is a full, self-contained copy of that style's `main.tex`, not a
reference to an external class.

## Other styles

The upstream repo ships each style as its own top-level directory, each with
its own `main.tex`. If you want a different look, the swap is at the
directory level, not a documentclass option:

| Style | Directory | Look |
|---|---|---|
| classic | `classic/` | this starter — centered header, blue accent rules, two-column entries |
| modern | `modern/` | photo header, colour block sidebar |
| minimalistic | `minimalistic/` | plain, no colour, dense single column |
| sidebar | `sidebar/` | left sidebar for contact/skills, main column for experience |
| sidebarleft | `sidebarleft/` | sidebar mirrored to the left |
| infographic / infographic2 | `infographics/`, `infographics2/` | bar charts, pie charts and timeline graphics per entry via TikZ |
| two_column | `two_column/` | full two-column body layout |
| rows | `rows/` | horizontal row-based entries |

Get any of them at https://github.com/jankapunkt/latexcv — each directory's
`main.tex` compiles standalone the same way this one does.

## Building

    pdflatex main

One pass is enough (no bibliography, no cross-references).

## Licence

MIT, © 2015 Jan Kuster. Full licence text is in the header of `main.tex`.
