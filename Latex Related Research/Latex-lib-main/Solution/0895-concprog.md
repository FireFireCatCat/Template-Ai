yes

# 0895-concprog: ConcProg (a classical concert programme class)

- Unverified: read from the source, not compiled.
- Source: Source/0895-concprog/ (origin: https://mirrors.ctan.org/macros/latex/contrib/concprog.zip; licence: GPL, per manifest and ConcProg.cls:9)
- Kind: misc (a concert programme; the manifest hint is `misc`/advert)
- Lib: v6
- Engine: pdfLaTeX-compatible (`inputenc` latin2, `fontenc` T1, `times`; nothing needs XeLaTeX or LuaLaTeX)
- Look carried by: class (the whole look is in `ConcProg.cls`; the sample adds three encoding and font packages and content)
- Class origin: ctan (ctan.org/pkg/concprog read: "A class which provides the necessary macros to prepare a (classical) concert programme", Andrej Brodnik, GNU GPL, CTAN directory macros/latex/contrib/concprog)
- Main file: program.tex (other samples: none)
- Read: main yes, zip-local classes and styles all (ConcProg.cls, 303 lines, read in full; the zip holds only these two files)

## Verdict
`yes`, and the evidence is about the class dimension, not about the component ways. The look is carried entirely by one published CTAN class, `ConcProg`, which the sample loads with the options `poets,durations` and then uses only through the class's own vocabulary (`programme`, `part`, `composition`, `\piece`). The sample adds no macro, counter or environment of its own, and its preamble is three packages that map to two lib ways (`inputenc` and `fontenc` in `font.fontenc-t1`, `times` in `font.mathptmx`). There is no artwork, no external tool and no unmapped component. One caution is recorded under "Bespoke code": the class's internal logic (a measured-width author box, a part counter, option-driven conditionals) would be irreducible if it were reimplemented outside the class, so this `yes` rests on W1 for the class (CTAN, read) and on the pilot ruling that a published class carries the look.

## Blockers
none

## Class setting
- Class: `class.concprog` options: `a4paper`, `11pt` (every option the class does not know is passed to `article` by `\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}`, ConcProg.cls:144), `poets`, `durations` (program.tex:1). `noauthors` is declared (ConcProg.cls:143) and not used by the sample. The class does `\LoadClass{article}` (ConcProg.cls:148).
- Class-native vocabulary used: environments `programme{title}` (ConcProg.cls:182, program.tex:9), `part[title]` (ConcProg.cls:194, program.tex:14), `composition{author}{years}{title}{description}` (ConcProg.cls:218, program.tex:15); command `\piece{title}{description}{poet}{duration}` (ConcProg.cls:283, program.tex:16).
- Class-native vocabulary defined but not used by the sample: `\Intermission` and `\IntermissionText` (ConcProg.cls:163-166), `\PartTitle` and `\PartEnd` redefinition hooks and the counter `Part` (ConcProg.cls:157-160), `\SetPieceIndentation{len}` (ConcProg.cls:170-173, default 1.5em), option `noauthors`.
- Quirk to record: `\renewenvironment{part}` (ConcProg.cls:194) turns the kernel sectioning name `part` into the class's own environment, so `\part` is no longer a heading command in this class.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | program.tex:1; ConcProg.cls:2,148 | `class.concprog` | `\documentclass[a4paper,11pt,poets,durations]{ConcProg}`; loads `article` |
| class options (look switches) | program.tex:1; ConcProg.cls:137-142 | `class.concprog` | booleans `poets` (poet printed after the piece title), `durations` (duration printed at the right end); `noauthors` declared, unused (ConcProg.cls:143) |
| paper and base size | program.tex:1; ConcProg.cls:144 | `page.class-options` | `a4paper`, `11pt`, handed on to `article` |
| running head and foot | ConcProg.cls:180 | `hf.pagestyle-kernel` | `\pagestyle{empty}`, set by the class, no page numbers |
| input and output encoding | program.tex:3-4 | `font.fontenc-t1` | `\usepackage[latin2]{inputenc}`, `\usepackage[T1]{fontenc}` |
| text font | program.tex:5 | `font.mathptmx` | `\usepackage{times}` (Times-like roman, Helvetica sans, Courier mono) |
| programme title block | ConcProg.cls:182-188; program.tex:9-12 | `front.class-native` | `programme{<title>}` prints `\begin{center}\Large\textsc{#1}\end{center}` then `\vspace{\bigskipamount}`; no `\maketitle`, `\title` or `\author` is used |
| title second line break | program.tex:11 | `sp.manual-space` | `\\` inside the `programme` argument |
| title second line size | program.tex:11 | `font.size-commands` | `{\normalsize 3.~december 1996}` (the class title is `\Large`) |
| part heading and end marks | ConcProg.cls:157-160,194-208; program.tex:14 | `head.class-native` | `part[<title>]`: default title `\PartTitle` = `Part \Roman{Part}`; between parts a centred `\PartEnd` (`-- End of Part --`) then `\bigskip \pagebreak[3]`; the sample passes an empty `[]`, so no part title prints (ConcProg.cls:204-206) and, with one part, no end mark |
| composition entry (title left, author right) | ConcProg.cls:214-278; program.tex:15-56 | `class.concprog` | native environment, 4 arguments: author, years in parentheses, title (`\textbf{\textsl{}}` then `, description`), description; seven compositions in the sample, two with a title (program.tex:32-33, 49-50) |
| composition boxes (inside class) | ConcProg.cls:253,270,273 | `box.minipage` | `minipage[t]{\@TitleWidth}` for title and pieces, `\hfill`, `\parbox[t]{\@AuthorWidth}` with `\raggedleft` for author and dates |
| box width rule (inside class) | ConcProg.cls:229-245 | `sp.lengths` | `\settowidth` of author and dates, wider one taken, capped at `0.33\textwidth`; title box is `\textwidth` minus author box minus `2em`; the cap is an `\ifthenelse{\lengthtest}` (see Bespoke code) |
| piece line | ConcProg.cls:283-303; program.tex:16-55 | `class.concprog` | native command: `\textsl{title}`, optional `(description)`, with `poets` ` -- \textsc{\small poet}`, with `durations` `\hfill {\tiny (duration)}`, then `\\` |
| piece and composition type faces (inside class) | ConcProg.cls:259,261,290,297,300 | `mark.kernel` | `\textbf`, `\textsl`, `\textsc`; sizes `\small` and `\tiny` are `font.size-commands` |
| piece undent (inside class) | ConcProg.cls:169-173,254 | `sp.lengths` | `\parindent` set to `-\@pieceIndent` (default `1.5em`); with no composition title `\@piece` is `\indent` so every piece is undented (ConcProg.cls:256), otherwise `\relax` (ConcProg.cls:257) |
| centred lines (inside class) | ConcProg.cls:165,184,200,206,273 | `sp.ragged` | `center` environment for title, part heading, end mark, intermission; `\raggedleft` for the author box |
| page-flow hints (inside class) | ConcProg.cls:197,201 | `pg.break` | `\nopagebreak[4]` before the end mark, `\pagebreak[3]` after `\bigskip` |
| intermission mark (not in sample) | ConcProg.cls:163-166 | `class.concprog` | `\Intermission` prints a centred `\IntermissionText` (`-- -- --`), redefinable with `\renewcommand` |

Components the zip does not define or use: geometry (the article defaults stand), columns, headings other than the part environment, abstract, contents, lists, quotes, notes, footnotes, math, theorems, floats, tables, captions, code, boxes beyond the class's own, bibliography, index, cross-references, language and metadata settings (the Slovene, French and Italian titles are plain text, no `babel`), colour.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `ConcProg.cls` (whole class) | ConcProg.cls:1-303 | not bespoke: published on CTAN (W1), so it is the way `class.concprog` | Loaded unchanged by the emitter; no zip-local logic is copied. Its internals (counter `Part`, switches `\if@printPoets`, `\if@printDurations`, `\if@printAuthors` at :137-139, `\settowidth` and `\ifthenelse{\lengthtest}` width cap at :231-238, `\let\@piece` choice at :255-257) are class code, not sample code. If the class were not published they would be irreducible (content-measured widths and hand-rolled conditionals), which is why the verdict is tied to W1 of the class. |
| `\usepackage{ifthen}` | ConcProg.cls:150 | helper | LaTeX-base load that only supports the class's conditionals; no printed effect, no lib way (considered a way for it; rejected as a macro-body helper, as the lib's v4 note rejects `sp.xspace`) |
| sample-level macros | program.tex:1-60 | none exist | the sample has no `\newcommand`, `\def`, environment or counter of its own |

## Content-opaque
none (accented Slovene, French and Italian titles are plain text; `program.tex` is not valid UTF-8 (a legacy 8-bit file, declared `latin2` at program.tex:3), so an emitter must write the text in the declared encoding or switch the `inputenc` option; program.tex:26 is a commented-out line)

## Lib changes
- New ways proposed: none. Considered a list-like component way for `composition` and `\piece`; not proposed, because a class's native vocabulary is carried by `class.concprog` (recorded above), and the lib already has `front.class-native` and `head.class-native` for the title and part heading.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
