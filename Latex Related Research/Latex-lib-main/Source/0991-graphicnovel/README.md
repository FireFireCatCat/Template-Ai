# GraphicNovel

**A semantic LaTeX class for graphic-novel and comic scripts.**

Version 0.5, released 22 September 2026  
Author and current maintainer: **Tom Bronte**  
Contact: [craftsyntax@craftsyntax.uk](mailto:craftsyntax@craftsyntax.uk)  
Project: **CraftSyntax.uk**  
Repository: [craftsyntax-uk/GraphicNovel](https://github.com/craftsyntax-uk/GraphicNovel)

GraphicNovel uses the working language of comics: stories, eras, pages,
panels, locations, shots, action, dialogue, captions, and sound effects.
Consistency matters as much to the artist as to the writer.

The reference bible is authoritative. Characters, places, persistent objects,
expressions, tells, and continuity notes are defined once, then referenced
throughout the script. Era-specific appearances describe how people, places,
and objects change over time. The class checks script references against those
definitions during compilation.

## What it provides

- A reference bible for characters, places, objects, and continuity notes.
- Era-specific appearances, named expressions, and behavioural tells.
- Stories, vignettes, comic pages, panels, and double-page spreads.
- Page layouts expressed as panel counts by row, such as `\pageLayout{2,1,2}`.
- Separate directions for background (`\location`), composition (`\shot`),
  and foreground activity (`\action`).
- Dialogue, balloon-position notes, captions, sound effects, and production notes.
- A `compact` option for proofreading without forced page breaks.

GraphicNovel produces a script and reference material for collaborators. It
does not draw panels or generate finished comic artwork.

## Requirements

Use a current LaTeX installation with pdfLaTeX and the following packages:

`geometry`, `fontenc`, `lmodern`, `microtype`, `xparse`, `expl3`, `enumitem`,
`parskip`, `fancyhdr`, `longtable`, and `array`.

The class is based on the standard `article` class. Unrecognised class options
are passed to `article`.

Building the manual also requires `booktabs`, `pdflscape`, `listings`, and
`hyperref`.

## Installation

For a local project, put `graphicnovel.cls` in the same directory as your
script's `.tex` file. Begin the script with:

~~~tex
\documentclass{graphicnovel}
~~~

For denser proofreading output, use:

~~~tex
\documentclass[compact]{graphicnovel}
~~~

For installation across several projects, place the class in your TeX
distribution's local or user TeX tree, following that distribution's
installation instructions.

## A complete example

Save the following as `example.tex` beside `graphicnovel.cls`.

~~~tex
\documentclass{graphicnovel}

\DeclareEra{Present Day}

\begin{character}{Lena}
  \appearance{Present Day}{Short dark hair; a long blue coat.}
  \expression{worried}{A tightened mouth and a glance over her shoulder.}
\end{character}

\begin{locationentry}{City walls}
  \appearance{Present Day}{Old stone walls above a crowded modern city.}
  \continuityRule{The gate stands to the left of the watchtower.}
\end{locationentry}

\begin{document}

\printReferenceBible

\newStory{The city at dusk}
\era{Present Day}

\newComicPage
\pageLayout{1,1}

\newPanel
\location{City walls}
\shot{Wide shot towards the distant spires.}
\action{Lena pauses at the gate.}
\caption{The city at dusk.}

\newPanel
\sameLocation
\shot{Close-up of Lena.}
\expression{Lena}{worried}
\dialogue{Lena}{We should be home by now.}
\sfx{CLANG}

\end{document}
~~~

Compile it with:

~~~sh
pdflatex example.tex
~~~

Declare eras before defining their appearances. Start a story, then set its
current era before referring to characters, places, or objects. A new story
resets the current era.

## Consistency checking

The class reports errors for unknown bible references, undeclared or missing
eras, missing appearances for the current era, and duplicate named states.
Every registered character, place, and object must have at least one
era-specific appearance.

Page and panel warnings include missing locations or visual direction, missing
layouts, panel counts that disagree with a layout, dialogue or captions on
pages declared silent or caption-free, and inconsistent page-turn instructions.

Validation runs automatically at the end of the document. Use
`\validateGraphicNovel` to close and check the current page and validate the
bible earlier.

These checks validate declarations and references. Prose written with
`\continuityRule` provides guidance for collaborators; the class does not
interpret that prose or inspect artwork for compliance.

## Documentation

Read `graphicnovel-manual.pdf` for the user manual and full command reference.
Its source is `graphicnovel-manual.tex`.

To rebuild the manual, run pdfLaTeX twice so its contents and references settle:

~~~sh
pdflatex graphicnovel-manual.tex
pdflatex graphicnovel-manual.tex
~~~

The class reserves `\caption` for comic-script captions. It replaces the
standard LaTeX float-caption command.

## Support, development, and news

Send questions and bug reports to
[craftsyntax@craftsyntax.uk](mailto:craftsyntax@craftsyntax.uk). For a bug
report, include the class version, TeX engine and version, relevant log output,
and the smallest source file that reproduces the problem.

Source and development: [GraphicNovel on GitHub](https://github.com/craftsyntax-uk/GraphicNovel).

A GraphicNovel publication on Substack is planned. Its link will be added
when available. Articles are intended
to be free to read, with a free subscription required to leave comments.

## Licence and maintenance

Copyright (c) 2026 Tom Bronte.

Permission to distribute and modify this work is granted under the
**LaTeX Project Public License (LPPL), version 1.3c**, with the option to use
any later version of that licence.

- LPPL maintenance status: **maintained**.
- Current maintainer: **Tom Bronte**.
- Maintainer contact: **craftsyntax@craftsyntax.uk**.

The licensed work consists of `README.md`, `graphicnovel.cls`, and
`graphicnovel-manual.tex`, together with the documentation PDF
`graphicnovel-manual.pdf` generated from the manual source.

The complete licence governs copying, modification, redistribution, and
maintenance:

- [LPPL version 1.3c](https://www.latex-project.org/lppl/lppl-1-3c/)
- [Latest LPPL text](https://www.latex-project.org/lppl.txt)

The work is supplied without warranty as specified in the LPPL. Naming a
maintainer provides a contact for reports; it does not promise support or fixes.

Using GraphicNovel to write a bible or script does not, by itself, place that bible or script or
the resulting graphic novel under the package's licence.

CraftSyntax would love an acknowledgement, though.
