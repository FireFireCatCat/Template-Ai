# Durham Beamer Theme

**Version:** 1.1.0\
**Author & Maintainer:** Suhail Rizwan\
**License:** LPPL 1.3c

------------------------------------------------------------------------

## Overview

The Durham Beamer Theme is a content-first LaTeX Beamer theme designed
for teaching, research, and structured academic presentations.

It prioritizes:

-   Structural clarity\
-   Cognitive restraint\
-   Predictable layout behavior\
-   Accessibility support\
-   Minimal visual distraction

------------------------------------------------------------------------

## Installation

### Automatic (TeX Live / MiKTeX)

Install via your package manager, then use:

``` latex
\usetheme{durham}
```

### Manual (CTAN zip)

Download the package archive and place:

    beamerthemedurham.sty

in your project directory or local texmf tree.

### Overleaf

Upload `beamerthemedurham.sty` into your project.

------------------------------------------------------------------------

## Compilation Engine (LuaLaTeX Required)

The Durham Beamer Theme is designed to be compiled using:

-   **LuaLaTeX** (recommended and expected)
-   XeLaTeX (generally compatible)

The theme uses professional font settings and modern font packages. For
consistent typography and correct font rendering, compile your
presentation with **LuaLaTeX**.

Compilation with pdfLaTeX is not officially supported and may lead to
font substitution or rendering inconsistencies.

------------------------------------------------------------------------

## Basic Usage

``` latex
\documentclass{beamer}
\usetheme{durham}

\title{My Presentation}
\author{Author Name}
\date{\today}

\begin{document}

\maketitle
\makeoutline

\section{Introduction}
\subsection{Motivation}

\begin{frame}{Slide Title}
Content here
\end{frame}

\makereferences
\makethankyou

\end{document}
```

------------------------------------------------------------------------

## Core Commands

-   `\maketitle`
-   `\makeoutline[Optional Title]`
-   `\makereferences`
-   `\makethankyou`
-   `\makethankyou[Line1]`
-   `\makethankyou[Line1][Line2]`

------------------------------------------------------------------------

## Theme Options

Supported:

-   `accessibility`
-   `plain`
-   `invert` (only valid together with `plain`)

Examples:

``` latex
\usetheme{durham}
\usetheme[accessibility]{durham}
\usetheme[plain]{durham}
\usetheme[plain,invert]{durham}
\usetheme[accessibility,plain]{durham}
\usetheme[accessibility,plain,invert]{durham}
```

Unsupported:

-   `invert` (i.e., `invert` without `plain`)
-   `accessibility + invert` (when used without `plain`)

------------------------------------------------------------------------

## Design Notes

-   Outline uses bullet-based hierarchy (no numbering).
-   Section titles support math.
-   Accessibility mode enforces strict black/white palette.
-   Plain mode removes headline and footline.
-   Invert mode requires plain.
-   Thank You page supports defaults and user overrides.

------------------------------------------------------------------------

## Institutional Disclaimer

The color palette is inspired by publicly visible Durham University
branding. This package is an independent academic contribution and is
not an official or endorsed Durham University template.

------------------------------------------------------------------------

## Maintainer

Suhail Rizwan
