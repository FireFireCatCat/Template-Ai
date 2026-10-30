# Rover Resume (Star)

A no-custom-class ATS resume: plain `article` plus `titlesec`/`enumitem`,
with rule-decorated section headers (`\midrule`), a `\rside{}` command for
right-aligned dates, and `\linkicon` for external project links. Upstream
ships eight variants (base/star/fancy/milky/obsolete/office/week/academic
rover) sharing this same "no custom commands to learn" philosophy — this
download is the **Star** variant, the one upstream's own README highlights
alongside Base as the flagship example, and visually the more distinctive
of the two.

## Files

- `main.tex` — the resume.

## Building

    pdflatex main
    pdflatex main

Two passes resolve the page-count footer (`lastpage`); there is no
bibliography.

## Licence

**CC-BY-4.0**. Attribution is required — `ATTRIBUTION.txt` is included in
this download; keep it with the template. Full licence text:
https://github.com/subidit/rover-resume/blob/main/LICENSE. Upstream's
repository does not name an individual copyright holder.

Upstream's own example content was an elaborate joke resume (a fictional
Amazon "Prime Member" role, a Google "Data Source" position "managing
submissions of monetizable personal data") mixed with literal fill-in-
the-blank instructions ("List computer software and programming
languages") — replaced entirely with a plausible original CV for a
backend engineer, exercising the same `\aux{}`/`\rside{}`/`\linkicon`
formatting commands the class provides.
