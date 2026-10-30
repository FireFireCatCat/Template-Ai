# FancySlides presentation

A minimal-chrome Beamer subclass for short, punchy talks: one big idea per
slide, colored pointed/framed "slogan" boxes instead of bullet-heavy frames,
and simplified title/thank-you slide commands. By Pawel Lupkowski.

## The deck is original

The `fancyslides` **class** is the free, LPPL-licensed CTAN package. The
well-known example deck built on top of it (by "Vel", widely shared online)
is licensed CC-BY-NC-SA and is **not used here in any form** — this
starter's slide content, titles and structure were written from scratch for
latextemplates.com, following only the class's own documented command
usage (`\startingslide`, `\pointedsl`, `\framedsl`, `\itemized`, `\misc`,
`\thankyou`), not that deck's wording or ordering.

## The class is not bundled

`fancyslides.cls` ships with this TeX Live install, so this download does
not bundle a copy. If your distribution does not have it:
https://ctan.org/pkg/fancyslides

## Building

    pdflatex main

One pass is enough (no bibliography, no cross-references). The class's own
README states it should be compiled with pdflatex specifically.

## Usage

Fancyslides is built on Beamer (`\LoadClassWithOptions{beamer}`), so any
plain Beamer command works alongside its own:

- `\startingslide` — builds the title slide from `\titlephrase`, `\name`,
  `\affil` and `\email`, which you define with `\newcommand` before
  `\begin{document}`.
- `\pointedsl{...}` — a big circular "pointed slogan" for a single idea.
- `\framedsl{...}` — the same idea in a rectangular box; also accepts
  `\pitem{...}` (pause between items) and `\fitem{...}` (no pause) for a
  build-up list inside the box.
- `\itemized{...}` — a boxed plain itemize list.
- `\misc{...}` — a boxed frame for arbitrary content, used here for a plain
  Beamer `block`.
- `\thankyou` — a closing "thank you" slogan slide.
- `\sources{...}` — a boxed slide for citing sources/credits.
- `\strcolor` (`blue`, `orange` or `green`), `\structureopacity` and
  `\yourowntexcol` control the box colour, its opacity, and the body text
  colour respectively — redefine them before `\begin{document}`.
- `\fbckg{<image>}` sets a full-bleed background image for the frames that
  follow, if you want one; this starter does not use it, to avoid bundling
  or crediting any particular photo.

## Licence

`fancyslides.cls` is licensed **LPPL-1.3a**, © Pawel Lupkowski. See
https://ctan.org/pkg/fancyslides for the full package and documentation.

This starter document is original content written for
latextemplates.com and carries no additional restrictions.
