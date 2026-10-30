no

# 0834-dannyedel-dspdfviewer: dspdfviewer (Dual-Screen PDF Viewer for latex-beamer, a C++/Qt tool)

- Unverified: read from the source, not compiled.
- Source: Source/0834-dannyedel-dspdfviewer/ (origin: https://codeload.github.com/dannyedel/dspdfviewer/zip/refs/heads/master; licence: GPL-2.0)
- Kind: misc (a C++ application; its only LaTeX are three beamer test decks, so the manifest hint "presentation" describes the decks, not the zip)
- Lib: v6
- Engine: pdfLaTeX-compatible (the three fixtures only; nothing else is LaTeX)
- Look carried by: class (nothing in the zip defines a look: the fixtures load beamer and set one class option, one beamer option and two colours)
- Class origin: tex-distribution-unbundled (beamer, loaded by the fixtures, not shipped in the zip; no class or style file exists in the zip)
- Main file: testing/pdfs/many-many-pages.tex (other samples: testing/pdfs/colored-rectangles.tex, testing/pdfs/images.tex)
- Read: main yes, zip-local classes and styles none present

## Verdict
NOTEMPLATE: the zip holds no LaTeX template or class to analyse. It is dspdfviewer, a C++/Qt viewer that splits a beamer PDF made with the "show notes on second screen" option into two screens (README.md:1, README.md:5-6; CMakeLists.txt:2), with 119 files of C++ sources, Qt `.ui` files, cmake, docs and translations. Its only TeX-family files are three test fixtures of 23 to 29 lines in `testing/pdfs/`, listed in `testing/CMakeLists.txt:11-15` and built with `pdflatex` into the PDFs the unit tests open (`testing/CMakeLists.txt:34-39`, `testing/CMakeLists.txt:51-59`; prebuilt copies are shipped, `testing/CMakeLists.txt:24-31`). There is no `.cls`, `.sty`, `.def`, `.cfg`, `.clo`, `.bst` or `.dtx`. Written `no` under the rubric's NOTEMPLATE rule; the project replaces such a zip, so this file is not evidence either way, and no component map or way ids are claimed.

For re-reading under another definition, what the fixtures hold (no way ids on purpose):
- many-many-pages.tex: `\documentclass[aspectratio=169]{beamer}` (:1), `color`, `pgfpages`, `pgffor` (:2-4), `\setbeameroption{show notes on second screen}` (:6), `\title` (:8), two `\definecolor` in HTML model (:14-15), a `\foreach \n in {1,...,100}` loop (:17-27) that opens a group, sets `\setbeamercolor{background canvas}` and `\setbeamercolor{note page}` (:20-21) and prints one frame saying `Page \thepage` (:22-24).
- colored-rectangles.tex: the same class line, packages and beamer option (:1-5), the same two colours (:13-14), one empty frame in a group with the two `\setbeamercolor` calls (:16-21).
- images.tex: the same class line, packages and beamer option (:1-5), two frames each with `center` and `\includegraphics[width=0.5\textwidth]` of `jpeg-image` (:14) and `png-image` (:21); both images are shipped (`testing/pdfs/jpeg-image.jpg`, `testing/pdfs/png-image.png`).
- None of the three defines a `\newcommand`, `\def`, environment, counter or conditional, and none needs a tool outside TeX to read. They are test inputs for a PDF viewer, with no template identity (no cover, no theme choice, no layout beyond beamer defaults).

## Blockers
- `NOTEMPLATE/zip` the zip is a C++/Qt PDF viewer, not a LaTeX template; the only `.tex` files are three beamer test fixtures built by its test suite (README.md:5-6, testing/CMakeLists.txt:11-15, testing/CMakeLists.txt:51-59)

## Class setting
- Class: none analysed (NOTEMPLATE). The fixtures load the published beamer class with option `aspectratio=169` (testing/pdfs/many-many-pages.tex:1, testing/pdfs/colored-rectangles.tex:1, testing/pdfs/images.tex:1).
- Class-native vocabulary used: `\setbeameroption`, `\setbeamercolor`, `frame` (testing/pdfs/many-many-pages.tex:6, :20-24); not mapped to lib ways.

## Component map
Not produced (NOTEMPLATE). See "Verdict" for what the fixtures contain.

## Bespoke code
none (no zip-local macro, environment, counter, class or style in the three `.tex` files; the C++ sources are not LaTeX and are out of scope)

## Content-opaque
none (the two test images are shipped assets, testing/pdfs/images.tex:14, testing/pdfs/images.tex:21)

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
