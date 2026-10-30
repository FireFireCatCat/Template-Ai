<!--
uvaletter 1.1.3 2026-04-26
Michele Piazzai <hello@piazzai.addy.io>
https://piazzai.github.io/
https://mit-license.org/
-->

# uvaletter

This is an unofficial LaTeX package that provides a letterhead template for the University of Amsterdam. The design mimics the [official Word template](https://www.uva.nl/over-de-uva/over-de-universiteit/huisstijl/downloadstools/brief/brief.html) of the University and complies with the University's [house style](https://www.uva.nl/over-de-uva/over-de-universiteit/huisstijl/huisstijl.html).

![](https://github.com/piazzai/uvaletter/blob/master/screenshot.jpg)

## Installation

This package is hosted on CTAN and distributed as part of MikTex and TeXLive. It can also be installed manually by cloning this repository in your `$HOME/texmf/tex/latex` folder, which is searched by LaTeX. If you do not have such a folder, you can [create it](https://www.ias.edu/math/computing/faq/local-latex-style-files).

## Usage

The package can be loaded with a `pageno` option that enables page numbering. Be aware that, in order for the layout to display, your letter body should be wrapped in a `letterhead` environment.

Here is a minimal working example:

```tex
\documentclass{letter}
\usepackage{uvaletter}

\logo{logo.jpg}
\recipient{foo}
\department{bar}
\visiting{}
\postal{}
\website{}
\date{}
\yourreference{}
\ourreference{}
\contactperson{}
\phone{}
\email{}
\subject{}
\enclosed{}

\begin{document}
\begin{letterhead}

 Hello world!

\end{letterhead}
\end{document}
```

The `\recipient{}` and `\department{}` commands are mandatory and their arguments must be non-empty. All other commands are optional and can be removed, commented out, or left empty.

In order for a logo to be displayed, you must indicate a path to the image in `\logo{}`. All official logos of the University of Amsterdam, including faculties, departments, and institutes, can be found [here](https://www.uva.nl/over-de-uva/over-de-universiteit/huisstijl/huisstijlelementen/logo/logo.html). If a path is not provided or the file is not found, the logo space is left blank.

## Bugs

In case of problems, please [open an issue](https://github.com/piazzai/uvaletter/issues).
