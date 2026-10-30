# beamertheme-csh

A Beamer presentation theme for the Complexity Science Hub.

## Version History

### v1.1 (2025-11-27)
- Fixed logo paths for CTAN/TeX Live compatibility
- Logos now installed alongside style files (flat structure)

### v1.0 (2025-11-24)
- Initial release

## Description

This package provides a Beamer theme following the corporate design of the Complexity Science Hub (CSH). It includes a title page, automatic section slides, source citation commands, and a closing slide with QR code. The theme uses TeX Gyre Heros as the default font.

## Usage

```latex
\documentclass[aspectratio=169]{beamer}
\usetheme{csh}

\title{My Presentation}
\author{Your Name}

\begin{document}

\begin{frame}
    \titlepage
\end{frame}

\section{Introduction}

\begin{frame}{Hello}
    Hello, World!
\end{frame}

\cshclosingslide{Your Name}{your.email@csh.ac.at}{https://csh.ac.at}

\end{document}
```

## Features

- Title page with CSH branding
- Automatic section slides
- Source citations: `\source{Your citation}`
- Closing slide with QR code: `\cshclosingslide{Name}{Email}{URL}`

## Installation

Copy all `.sty` files and logo PDFs (`csh-logo-web.pdf`, `csh-logo-star-crop.pdf`) to your project directory, or install to your TEXMF tree.

## License

LPPL 1.3c

## Repository

https://github.com/complexity-science-hub/beamertheme-csh

## Contact

Bernhard Haslhofer - haslhofer@csh.ac.at
