# Gotham Beamer Theme

<!-- Logo -->
<p align="center">
   <a href="https://gitlab.com/RomainNOEL/beamertheme-gotham">
      <img src="support/gotham-logo.png" width="100" alt="Gotham logo">
   </a>
</p>

<!-- BADGES -->
<p align="center">
   <a href="https://ctan.org/pkg/beamertheme-gotham"><img src="https://img.shields.io/ctan/v/beamertheme-gotham?logo=LaTeX&logoColor=%23008080&color=%23008080"/></a>
   <a href="https://gitlab.com/RomainNOEL/beamertheme-gotham/-/release/"><img src="https://img.shields.io/badge/Latest_Release-v1.2.5.a-FC6D26?logo=Gitlab&logoColor=%#FC6D26"/></a>
   <a href="https://gitlab.com/RomainNOEL/beamertheme-gotham/-/pipelines?page=1&scope=all&ref=main"><img src="https://img.shields.io/gitlab/pipeline-status/RomainNOEL%2Fbeamertheme-gotham?branch=main&logo=githubactions&label=pipeline"/></a>
   <a href="https://gitlab.com/RomainNOEL/beamertheme-gotham/-/blob/main/LICENSE.txt"><img src="https://img.shields.io/badge/License-LPPL_1.3c-blue?logo=opensourceinitiative"/></a>
   <a href="https://gitlab.com/api/v4/projects/52144864/jobs/artifacts/main/raw/gotham.pdf?job=deploy-files"><img src="https://img.shields.io/badge/Documentation-PDF_online-green?logo=readthedocs"/></a>
   <a href="https://www.repostatus.org/lifecycle"><img src="https://img.shields.io/badge/repo_status-active-FC6D26?logo=framework&color=#F10001"/></a>
</p>
<!-- Latest_Release-v1.2.5.a    Date: 2026-04-02 -->


## What is Gotham ?
This `Gotham` package is a modern, minimal-ish, versatile and extendable theme for your `Beamer` presentations using `LaTeX(3)`.


## Table of Contents
[[_TOC_]]


## Why this package ?
ONCE UPON THE TIME, I was adapting `Metropolis` [Beamer](https://ctan.org/pkg/beamer)  theme to get my institutional templates.
Indeed, `Metropolis` Beamer theme is a great work that is very convenient and well appreciated by many.

BUT, [`Metropolis`](https://ctan.org/pkg/beamertheme-metropolis) seems not maintained anymore and is not flexible enough.
Moreover, `Metropolis` (or its successor initiative Moloch) and Beamer in some extends are not very flexible.
For example, it requires cumbersome modifications to apply a different background for your section frames.

SO, `Gotham` tries to bring that kind of flexibility and [`LaTeX3`](https://www.latex-project.org/latex3/) implementation on top of the good-looking `Metropolis` theme.


## Some of the features included
- :gear: `l3build` a build system for LaTeX testing and deployment, etc...
- :hammer_and_wrench: `expl3` compliant
- :first_quarter_moon: dark, light and transparent background
- :movie_camera: can adapt to 16:9 and 4:3 screen format
- :stopwatch: multiple progress bar style
- :shopping_cart: **can mix** themes


## See it in action
Here are some screenshot of what you can obtain:

| Example using a transparent background in 16/9 |  Example using a transparent background in 4/3 |
:-------------------------:|:-------------------------:
| <img src="support/gotham-example169transp-1.png" width="475"> | <img src="support/gotham-example43dark-1.png" width="375"> |

A deeper taste of how `Gotham` can render is available through the **`pdf` example/demo** that can be found [here](https://gitlab.com/api/v4/projects/52144864/jobs/artifacts/main/raw/gotham-example169transp.pdf?job=deploy-files), and the `tex` source file to build it is available [here](https://gitlab.com/RomainNOEL/beamertheme-gotham/-/blob/main/examples/gotham-example169transp.tex?ref_type=heads).

The following code shows a **minimal example** of a Beamer presentation using Gotham.
```latex
\documentclass{beamer}
\usetheme{gotham}
\title{A minimal example}
\date{\today}
\author{Romain NOEL}
\institute{Centre for Modern Beamer Themes}
\begin{document}
  \maketitle
  \section{First Section}
  \begin{frame}{First Frame}
    Hello, world!
  \end{frame}
\end{document}
```
is yielding the following:

<img src="support/gotham-exampleSimple-1.png" width="500">


## Documentation
The complete `pdf` documentation can be found through an [artefact](https://gitlab.com/api/v4/projects/52144864/jobs/artifacts/main/raw/gotham.pdf?job=deploy-files).


## How to install ?
Several possibilities are available and tested:
- download the `.sty` released zip files,
- build from sources using `l3build`,
- download or update from [CTAN](https://ctan.org/pkg/beamertheme-gotham),
- fork a example from [Overleaf](https://www.overleaf.com/read/ybdcnjxjrwgq#3ae7f9) .

### Download from release
The zip file containing the `.sty` files is downloadable through our latest [release link](https://gitlab.com/RomainNOEL/beamertheme-gotham/-/releases/)

### Build from sources
You can also install the theme from sources, in which case you need a working LaTeX installation with `l3build` installed.
Then just follow these steps:
```bash
git clone https://gitlab.com/RomainNOEL/beamertheme-gotham.git
cd beamertheme-gotham
l3build install
```

Additionally you can use the other `l3build` target:
- `l3build unpack` builds the theme style files.
- `l3build doc` builds this documentation manual and the examples.
- `l3build check` builds the theme and manual.
- `l3build install` installs the theme into your local texmf folder.
- **STOP** unless you want remove it.
- `l3build uninstall` removes the theme from your local texmf folder.
- `l3build clean` removes the files generated by `l3build`.

### Download from CTAN
The CTAN repository is available through the Gotham [package](https://ctan.org/pkg/beamertheme-gotham), so you can install it using your favorite LaTeX package manager. For example, with `tlmgr`:
```bash
tlmgr install beamertheme-gotham
```

### Fork from Overleaf example
If you want to play with it before installing, you can fork this Gotham example on [Overleaf](https://www.overleaf.com/read/ybdcnjxjrwgq#3ae7f9) and have fun.

If you want to go further and have examples about how to adapt Gotham  to obtain custom theme for your institution, visit this Overleaf example [adaptation](https://www.overleaf.com/read/vxnjgfmyvccj).


## License
The LaTeX Project Public License, version 1.3c [(LPPL1.3c)](/LICENSE.txt)


## Project status & contribution
The status of the project is "maintained".
The changelog file is tracking the [changes](https://gitlab.com/RomainNOEL/beamertheme-gotham/-/blob/main/CHANGELOG.md?ref_type=heads) made across versions.
However, if you have a bit of free time and good will to help the maintenance, it will be very appreciated and welcomed.
If you intend to contribute to this project, you can read the dedicated [document](https://gitlab.com/RomainNOEL/beamertheme-gotham/-/blob/main/CONTRIBUTING.md?ref_type=heads).