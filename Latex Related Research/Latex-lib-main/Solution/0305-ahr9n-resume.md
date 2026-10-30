no

# 0305-ahr9n-resume: Deedy one-page two-column resume (ahr9n fork)

- Unverified: read from the source, not compiled.
- Source: Source/0305-ahr9n-resume/ (origin: https://codeload.github.com/ahr9n/resume/zip/refs/heads/deedy-resume; licence: Apache-2.0, LICENSE:1-3)
- Kind: cv
- Lib: v4
- Engine: needs XeLaTeX (the sample's own header says so, resume.tex:12; the class that would load the fonts is absent, so the engine is stated by the comment, not by a `fontspec` line I could read)
- Look carried by: zip-local (the look sits in the class `deedy-resume-openfont` named at resume.tex:48; that file is NOT in the zip, so none of it could be read)
- Class origin: zip-local (named by the manifest `local_class`; absent from the zip; ctan.org/pkg/deedy-resume and ctan.org/pkg/deedy-resume-openfont both returned 404, so it is not a CTAN class)
- Main file: resume.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
The zip is a 302-line sample `resume.tex` plus README, LICENSE and `.gitignore`; it contains no `.cls`, `.sty` or font file. Everything that gives the page its look (geometry, fonts, colours, heading style, name block, "last updated" stamp, entry macros, bullet environment) is defined in `deedy-resume-openfont`, which `\documentclass` loads at resume.tex:48 but which is not shipped and is not on CTAN. With the class missing I cannot show that its macros reduce to lib ways, and the sample's body uses seven of its macros or environments by name. By the rubric's "if you cannot show it, the answer is no", the verdict is `no`. The body constructs the sample writes itself (two minipage columns, a tabular, `fancyhdr`, kernel markup) do map to lib ways, but they are a small part of the look.

## Blockers
- `BESPOKE/class` the class `deedy-resume-openfont` is zip-local (not on CTAN, not an official release), is referenced but not shipped, and so cannot be shown reducible (resume.tex:48; file listing has no .cls or .sty; resume.tex:35-36 says the title styling and a commented `.sty` existed upstream, resume.tex:33 says the open-font variant was added there)
- `BESPOKE/class` class-defined body macros whose definitions are absent: `\lastupdated` (resume.tex:61), `\namesection{First}{Last}{contact}` (resume.tex:68), `\descript` (resume.tex:87), `\location` (resume.tex:88), `\runsubsection` (resume.tex:181), `\sectionsep` (resume.tex:92), environment `tightemize` (resume.tex:129)
- `UNMAPPED/class` page geometry, fonts, colours, the look of `\section` and `\subsection`, and the name block are set by the absent class (resume.tex:12-17, 84-86, 68); no way can be named for them without reading it. A `font.fontspec` way is plausible (XeLaTeX is required, resume.tex:12) but is a guess and is not asserted

## Class setting
- Class: none in the lib. `deedy-resume-openfont` is not published, so it is not a `class.<name>` way. Options: none (`\documentclass[]`, resume.tex:48; the empty option list is a parameter-free call).
- Class-native vocabulary used: `\lastupdated`, `\namesection`, `\descript`, `\location`, `\runsubsection`, `\sectionsep`, `tightemize`, and restyled `\section` and `\subsection` (resume.tex:61, 68, 84-92, 129, 181). Their meaning is not recoverable from this zip.
- Stray line: resume.tex:302 has a second `\documentclass[]{article}` after `\end{document}`; LaTeX never reads it, so it is not part of the template.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | resume.tex:48 | none: zip-local class, file absent (BESPOKE/class) | options empty |
| engine / fonts | resume.tex:12-17, 33 | unmapped (UNMAPPED/class); `font.fontspec` is only a candidate, not asserted | the header says the template uses fonts not shipped with Windows/Linux and that the open-font variant avoids them; font names are in the absent class |
| page geometry | none in sample | unmapped (set by absent class) | not visible |
| colour | none in sample | unmapped (set by absent class) | not visible |
| two columns | resume.tex:78, 172-174, 301 | `cols.minipage` | `minipage[t]{0.33\textwidth}` then `\hfill` then `minipage[t]{0.66\textwidth}` |
| column gap and fill | resume.tex:173 | `sp.manual-space` | `\hfill` between the two minipages |
| header and footer | resume.tex:49-52 | `hf.fancyhdr` | `\usepackage{fancyhdr}`, `\pagestyle{fancy}`, `\fancyhf{}` (all head and foot fields cleared) |
| "last updated" stamp | resume.tex:61 | none: class macro, definition absent (BESPOKE/class) | no arguments |
| name and contact block | resume.tex:68-70 | none: `\namesection` is class-defined (BESPOKE/class); its third argument holds links | args: first name, last name, contact lines with `\\` |
| link style | resume.tex:68 | `meta.url` | `\urlstyle{same}` |
| hyperlinks | resume.tex:68-69, 181, 225-228 | `xref.hyperref` (`\href{url}{text}` is a hyperref link command) | external URLs and `mailto:` targets |
| hyperref load | no `\usepackage` in the sample | `meta.hyperref` (inferred: `\href` needs it, so the absent class must load it) | options unknown |
| section headings | resume.tex:84, 111, 125, 150, 180, 224, 280 | unmapped for the look (class restyles `\section`); the commands are kernel names | not visible |
| subsection headings | resume.tex:86, 112, 126, 151 | unmapped for the look (class restyles `\subsection`) | not visible |
| run-in subsection | resume.tex:181, 225, 233 | none: `\runsubsection` class macro (BESPOKE/class) | one text argument |
| role line and date/place line | resume.tex:87-88, 182-183 | none: `\descript` and `\location` class macros (BESPOKE/class) | one text argument each |
| block separator | resume.tex:92, 119, 134 | none: `\sectionsep` class macro (BESPOKE/class) | none |
| bullet lists | resume.tex:129-133 (and 139, 153, 185, ...) | none: `tightemize` environment, definition absent (BESPOKE/class); `\item` is the kernel item command | none |
| manual spacing | resume.tex:89, 113-115, 128, 184 | `sp.manual-space` | `\\` line breaks, `\hspace{}` (empty length), `\vspace{\topsep}` (the sample's own comment calls it a hacky fix, resume.tex:128) |
| skill separators | resume.tex:113-118 | content: `\textbullet{}` between words | text content |
| awards table | resume.tex:281-288 | `tbl.tabular` | `tabular{rll}`, no rules, six rows |
| inline emphasis | resume.tex:186, 227, 272, 282, 283 | `mark.kernel` | `\textbf{}`; `\textsuperscript{th}` (resume.tex:283-286) is a kernel inline wrapper, put here as the nearest home, not a font switch |
| bibliography | resume.tex:295-299 | inactive (commented out); no way needed | commented `\bibliographystyle{abbrv}`, `\bibliography{publications}`; resume.tex:296 says the refname fix "couldn't get this working from the .cls file" |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| class `deedy-resume-openfont` | named at resume.tex:48; file absent from the zip | no (cannot be shown; unread) | none possible without the file |
| `\lastupdated` | used at resume.tex:61 | no (unread) | none |
| `\namesection` | used at resume.tex:68 | no (unread) | none |
| `\descript`, `\location` | used at resume.tex:87-88 | no (unread) | none |
| `\runsubsection` | used at resume.tex:181 | no (unread) | none |
| `\sectionsep` | used at resume.tex:92 | no (unread) | none |
| `tightemize` | used at resume.tex:129 | no (unread) | none |
| restyled `\section` and `\subsection` | used at resume.tex:84, 86 | no (unread) | none |
| sample's own macros and counters | none: the sample defines no `\newcommand`, `\def`, environment or counter | n/a | n/a |

## Content-opaque
none (the sample has no figure, picture or code; the awards table is plain text).

## Lib changes
- New ways proposed: none. Considered and not proposed: none.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
- Note on research value: this zip is evidence that a repository can ship a sample without its class file; it says nothing about the component ways. The upstream project named at resume.tex:10 and README.md:3 ("built on top of" a modern-deedy repository) is a different repository and was not read.
