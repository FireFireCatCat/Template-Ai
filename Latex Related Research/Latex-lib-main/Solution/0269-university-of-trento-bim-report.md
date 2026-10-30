yes

# 0269-university-of-trento-bim-report: University of Trento BIM Report (unitn-bimrep bimonthly doctoral report)

- Unverified: read from the source, not compiled.
- Source: Source/0269-university-of-trento-bim-report/ (origin: https://latextemplates.com/downloads/unitn-bimrep.zip; licence: MIT)
- Kind: report
- Lib: v3
- Engine: pdfLaTeX-compatible (README.md:13 says "Compile with pdfLaTeX"; the class source was not read, so this is the README's statement, not checked against the class)
- Look carried by: class (the zip is a 28-line sample that loads the published `unitn-bimrep` class unchanged and adds only content; the whole look is inside that class)
- Class origin: tex-distribution-unbundled (README.md:7-8 says the class "is supplied by TeX Live" and is not bundled; ctan.org/pkg/unitn-bimrep read once: MIT licence, in TeX Live and MiKTeX, maintainer Matteo Ragni, version 2017-10-22, topic "Report like")
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present (the zip holds only main.tex and README.md; the class source is not in the zip and was not read)

## Verdict
The zip adds no code of its own: main.tex is `\documentclass{unitn-bimrep}` (main.tex:1), four class-native metadata commands (main.tex:3-6) and three class-native environments filled with example text (main.tex:10-26). There is no `\newcommand`, `\def`, preamble package, zip-local class or style, no drawing and no external tool, so no bespoke, ART or EXTERNAL blocker can come from the zip. The published class is one way, `class.unitn-bimrep`, and its vocabulary is recorded below. This is evidence about the class dimension (the look is carried by the class), not about the component ways. Caveat: the class source was not read (it is neither in the zip nor reachable within the allowed reads), so what it loads internally (page geometry, running heads, fonts, masthead drawing) is not itemised here.

## Blockers
none

## Class setting
- Class: `class.unitn-bimrep` options: none (main.tex:1 has no optional argument)
- Class-native vocabulary used:
  - metadata commands `\author{}` (main.tex:3), `\title{}` (main.tex:4), `\advisor{}` (main.tex:5), `\cycle{}` (main.tex:6; value `XXX`, the doctoral cycle label)
  - environment `research` (main.tex:10-15): plain `\item` entries, free text
  - environment `school` (main.tex:17-21): each `\item` takes three brace groups, `{activity}{duration}{credits}` (main.tex:18-20)
  - environment `production` (main.tex:23-26): each `\item` takes three brace groups, `{authors}{title}{venue/status}` (main.tex:24-25)
  - the three environments are required and must come in this order (README.md:13); the class prints the University of Trento report masthead from an image supplied by the TeX distribution (README.md:8-10)
  - no `\maketitle` is called in the sample (main.tex:8-28); the masthead and metadata blocks are produced by the class, per README.md:9-10 (how, not read)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.unitn-bimrep` | no options; the class defines page, fonts, headings and masthead (source not read) |
| title block / masthead (title, author, advisor, cycle) | main.tex:3-6; README.md:9 | `front.class-native` | `\author`, `\title`, `\advisor`, `\cycle` strings; the University of Trento masthead image is inserted by the class |
| research activities section | main.tex:10-15 | `class.unitn-bimrep` | `research` environment, three `\item` entries of free text (the section's heading and list look are the class's; not read) |
| school and seminar attendance section | main.tex:17-21 | `class.unitn-bimrep` | `school` environment, `\item{activity}{duration}{credits}` x3 (class-native three-argument items) |
| production (publications and posters) section | main.tex:23-26 | `class.unitn-bimrep` | `production` environment, `\item{authors}{title}{venue/status}` x2 (class-native three-argument items) |
| page geometry, headers/footers, fonts, spacing, colour, headings, numbering, lists | none set in main.tex | `class.unitn-bimrep` | all defaults of the class; nothing in the zip sets them (class source not read) |
| language / meta, abstract, contents, theorems, floats, tables, captions, code, boxes, bibliography, index, cross-references | none present in main.tex | none | the sample uses none of these |

The three environments are mapped to the class way itself and not to `list.kernel` or any other component way, because the class source was not read and it is not established how the class builds them. The lib's rule that a published class's own vocabulary is recorded under its class way applies (change log v3, `class.exam-lite` into `class.exam-lite`).

## Bespoke code
none (main.tex defines no macro, environment, counter or conditional; the zip has no `.cls`, `.sty`, `.def`, `.cfg` or `.clo` file; the only zip files are main.tex and README.md)

## Content-opaque
none. The masthead image that the class inserts is a distribution asset the zip does not ship (README.md:7-10): a missing asset, noted, not a blocker; a TeX Live installation provides it, per the README.

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- Text addressed to an AI: none found in main.tex or README.md.
- Not read: the source of `unitn-bimrep.cls` (published in TeX Live and on CTAN, not bundled). If that class loads a package that needs a tool outside TeX, it would be `EXTERNAL/package` under the pilot ruling; nothing in the README or main.tex points to one, and the README states plain pdfLaTeX.
