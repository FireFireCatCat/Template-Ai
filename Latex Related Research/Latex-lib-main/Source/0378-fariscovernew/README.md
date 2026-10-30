Package Name: fariscovernew
Author: Faris Hameed
Email: classsec81@gmail.com
License: LaTeX Project Public License (LPPL) version 1.3c
Version: 1.1
Date: 2026-03-21
============================================================
fariscovernew - Modern Title Page Generator for Arabic and English
============================================================
Description:
fariscovernew is a LaTeX package for generating modern and highly
customizable title pages (cover pages) for Arabic and English documents.
The package supports multiple visual styles, dynamic color schemes,
font customization, and advanced geometric layouts including layered
diamond compositions. It is designed for use with XeLaTeX or LuaLaTeX.
Main Features:
- Arabic and English language support
- Multiple cover styles:
  triple, diagonal, wave, badge, diamond, minimal, ribbon, sidebar,
  diamondx (advanced layered geometry)
- Customizable:
  - Title and subtitle font sizes with automatic safety guards
  - Independent text colors for title and subtitle (NEW in v1.1)
  - Main and accent colors
  - Font families
  - Subtitle ratio
  - Advanced geometric parameters (diamondx mode)
Compilation:
Requires XeLaTeX or LuaLaTeX with packages: fontspec, bidi, xcolor, tikz, xparse
Basic Usage:
\usepackage{fariscovernew}
\FarisTitlePage[Lang][TitlePt][SubtitlePt][Color][MainFont][SubFont][SubRatio]{Title}{Subtitle}
Environment alternative:
\begin{FarisTitlePageEnv}[...]{Title}{Subtitle}
\end{FarisTitlePageEnv}
Text Color Customization (NEW in v1.1):
\FarisSetTitleTextColor{color}
\FarisSetSubtitleTextColor{color}
\FarisResetTitleTextColor
\FarisResetSubtitleTextColor
\FarisResetTextColors
Advanced Style (diamondx):
\FarisDiamondBackComplementOn
\FarisDiamondBackComplementOff
\FarisSetDiamondTints{<front>}{<back>}
\FarisSetDiamondBackTintII{<value>}
\FarisSetDiamondAnglePair{<angle>}
\FarisSetDiamondAngles{<A>}{<B>}
\FarisSetDiamondBackDelta{<delta>}
\FarisSetDiamondTriadOffset{<offset>}
Changelog:
v1.1 (2026-03-21)
+ Added \FarisSetTitleTextColor and \FarisSetSubtitleTextColor
+ Added \FarisResetTextColors, \FarisResetTitleTextColor, \FarisResetSubtitleTextColor
* Fixed subtitle size when TitlePt=0 now derives from SubtitlePt x 5/4
* Fixed subtitle can no longer exceed title size
* Fixed \IfNoValueF replaced by correct \IfNoValueTF for SubtitlePt
* Fixed duplicate \Faris@splitRGB definition removed
* Fixed shared size macros moved outside environment
* Fixed negative or zero values in TitlePt and SubtitlePt now treated as '-'
Documentation:
See included guide file: fariscovernew-doc.tex / fariscovernew-doc.pdf
Installation:
Place fariscovernew.sty in your local texmf tree or install it via TeX distribution package manager after CTAN approval.
License:
This work may be distributed and/or modified under the conditions of the
LaTeX Project Public License (LPPL), either version 1.3c of this license or any later version.
https://www.latex-project.org/lppl.txt
Maintainer:
Faris Hameed
classsec81@gmail.com