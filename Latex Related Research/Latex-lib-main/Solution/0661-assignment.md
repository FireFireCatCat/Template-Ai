yes

# 0661-assignment: assignment (homework and lab assignment class)

- Unverified: read from the source, not compiled.
- Source: Source/0661-assignment/ (origin: https://mirrors.ctan.org/macros/latex/contrib/assignment.zip; licence: LPPL 1.3 per the manifest, and LICENSE/README in the zip)
- Kind: assignment
- Lib: v5
- Engine: pdfLaTeX-compatible (no fontspec, no Lua, no external tool; the class loads only `article` and `ifthen`)
- Look carried by: class (the whole look is in `assignment.cls`, the published CTAN class; the sample adds only strings and content)
- Class origin: ctan
- Main file: assignment.tex (other samples: none; `assignment.pdf` is the shipped manual output and was not read, no PDF renderer here)
- Read: main yes, zip-local classes and styles all (`assignment.cls`, 141 lines, read in full; `assignment.dtx` named in the header at assignment.cls:7 is not in the zip)

## Verdict
yes. The zip is the CTAN release of the `assignment` class itself (ctan.org/pkg/assignment: class, LPPL 1.3, TeX Live and MiKTeX, 2004-07-14), so the class is one published way, `class.assignment`, and the sample adds no macro of its own: it sets seven strings and then uses the class's own environments and kernel constructs. An emitter writes `\documentclass{assignment}`, the string commands (`\coursetitle` `\courselabel` `\exercisesheet` `\student` `\semester` `\date`) and the body wrappers `problemlist` / `\pbitem` / `problem` / `answer`, with no copied macro logic. The verdict depends on the class counting as published (W1, confirmed on CTAN); this is the "look carried entirely by a published class" case, so it is evidence about the class dimension.

## Blockers
none

## Class setting
- Class: `class.assignment` options: none in the sample (assignment.tex:1). The class declares `twoside` and forwards it to a *package* named `article` (assignment.cls:19, so it probably never reaches the class; not verified), and forwards every other option to the `article` class with a console message (assignment.cls:20); `\ProcessOptions` at assignment.cls:22; then `\LoadClass[10pt,a4paper]{article}` (assignment.cls:24).
- Class-native vocabulary used: preamble strings `\coursetitle` (assignment.tex:2), `\courselabel` (:3), `\exercisesheet{title}{subject}` (:4), `\student` (:5), `\semester` (:6), kernel `\date` (:7); body `problemlist` (assignment.tex:13), `\pbitem` (:14), `problem` (:16), `answer` (:20).
- Class-native vocabulary defined but not used by the sample: `\university` `\school` (defaults University of Michigan, Department of Electrical Engineering and Computer Science, so the sample prints those; assignment.cls:36-37, 48-49), `\department` (swallows its argument; :50), `\solutionstext` (:38), `\ifshowanswers` (a `\let` to `\iffalse`, :115, so the solutions tag never prints unless a document redefines it), `\e` `\asgimplies` `\boxit` (:54-56).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | assignment.tex:1 | `class.assignment` | no options |
| base class loaded by it | assignment.cls:24 | `class.article` | 10pt, a4paper (fixed in the class) |
| paper and size | assignment.cls:24 | `page.class-options` | `a4paper`, `10pt` |
| text width | assignment.cls:27 | `page.setlength` | `\textwidth` = 6.0in (side margins left as article computed them) |
| page style | assignment.cls:28 | `hf.pagestyle-kernel` | `\pagestyle{empty}` |
| running foot | assignment.cls:130-136 | `hf.class-native` | `\@oddfoot` set at begin-document: left `\courselabel` + `\exercisesheet` in italic, right `\semester`, centred `\thepage`; two overlaid `\parbox{0.99\textwidth}`; `\@evenfoot` untouched (empty) |
| foot boxes | assignment.cls:132-135 | `box.minipage` | `\parbox` width 0.99\textwidth, `\hspace{-0.99\textwidth}` overlay, `\centering` |
| header block (student, school, university, date) | assignment.cls:118-123 | `front.class-native` | right-aligned block printed by `\AtBeginDocument`: `\sf` student, italic school, italic university, `\\[0.5\baselineskip]`, `\bf` date |
| header alignment | assignment.cls:118,123 | `sp.ragged` | `flushright` environment, `\hfill\\` after it |
| sheet title line | assignment.cls:124-128 | `front.class-native` | `\bfseries` upper-cased `\exercisesheet` title, ` --- ` subject if non-empty, `\solutionstext` only if `\ifshowanswers` |
| upper-casing of the sheet title | assignment.cls:43 | `mark.case` | `\uppercase` over the first argument of `\exercisesheet` |
| submitted-by line | assignment.cls:138 | `front.class-native` | `\AtEndDocument{\vfill\noindent \sl{Submitted by <student> on <date>.}}` |
| date value | assignment.tex:7 | `front.maketitle` | kernel `\date{July 14, 2004}` (`\maketitle` is not called; the class prints it) |
| course title string | assignment.tex:2, assignment.cls:29,39 | `front.class-native` | stored in `\@coursetitle`; nothing in the class prints it (grep: only its definition and setter) |
| font switches | assignment.cls:51,125,119-122,132 | `mark.kernel` | `\bfseries` `\bf` `\sf` `\sl` `\em` `\emph` |
| manual spacing | assignment.cls:101,121,123,138 | `sp.manual-space` | `\vspace{0.1 in}` (before the answer), `\\[0.5\baselineskip]`, `\hfill`, `\vfill` |
| problem label "Problem n." | assignment.cls:51,58-64 | `class.assignment` | `\pbitem` gives `\item[\PB\ n]` by nesting depth, `\PB` = bold "Problem"; depth tests with `ifthen` on `\@enumdepth` (class-native vocabulary, no component way, as in the v3 precedent for a published class's own vocabulary) |
| problem list | assignment.cls:66-86 | `class.assignment` | `problemlist` = kernel `list` with the enumeration counters of its depth reset |
| problem body | assignment.cls:88-97 | `class.assignment` | `problem`: steps counter `problem`, zeroes `equation`, prints `\phantom{\PB}\ ` as an indent |
| answer block | assignment.cls:99-113 | `class.assignment` | `answer`: `\vspace{0.1 in}`, `\boldmath`, then at the end a right-aligned bold "arrow A-nswer" tag in `flushright` |
| answer maths and emphasis | assignment.cls:102-103,111 | `math.kernel` | `\boldmath` and `\mathcal{A}`, `\longrightarrow` (inside the answer wrapper); `\begin{emph}` uses the command `\emph` as an environment name, its effect is not established by reading |
| counters | assignment.cls:52,90-91 | `num.counters` | `\newcounter{problem}`; `equation` zeroed by `\addtocounter{equation}{-\arabic{equation}}` |
| equation numbers | assignment.cls:53 | `num.counters` | `\theequation` = `\arabic{problem}-\arabic{equation}` |
| displayed equations | assignment.tex:77-81,106-108,165-167 | `math.kernel` | `eqnarray`, `\nonumber`, `\textrm`, `\ldots` |
| cross-references | assignment.tex:78-79 | `xref.kernel` | `\label{eqn:emc2}`, `\label{eqn:numbered}` (never `\ref`ed in the sample) |
| enumerated parts | assignment.tex:121-134 | `list.kernel` | `enumerate` with `\item` and an `answer` after each item |
| verbatim listings | assignment.tex:31-41,55-57,69-75,95-102,136-152 | `code.verbatim` | `verbatim` environment (the shown markup is text, not template) |
| footnote | assignment.tex:29 | `fn.kernel` | one `\footnote` |
| framed formula (unused here) | assignment.cls:56 | `box.fancybox` | `\boxit` = `$$\fbox{$#1$}$$`, defined in the class, not called by the sample |

No sectioning, abstract, contents list, floats, tables, captions, bibliography, index, colour, background, language or font package appears in the sample or the class (grep of `\usepackage` and `\RequirePackage`: only `ifthen`, assignment.cls:26). Fonts stay the article default.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| zip-local macros in the sample | assignment.tex | none | the sample defines no macro, counter or environment; only commented-out `\usepackage` lines (assignment.tex:8-9, repeated as verbatim text at :39-40) |
| `assignment.cls` internals (`\pbitem`, `problemlist`, `problem`, `answer`, header and foot hooks, `\theequation`) | assignment.cls:52-138 | n/a, published | the class is on CTAN and in TeX Live, so these are the published way `class.assignment`, not zip-local bespoke code; the emitter calls them and does not copy them |
| `\ifshowanswers` switch | assignment.cls:115 | n/a, published | class-internal conditional; the sample never changes it |
| `ifthen` | assignment.cls:26 | n/a, published | tools-bundle package loaded by the class for its depth tests, no printed effect of its own |

Note on the dependence on W1: if the class had been a zip-local copy, the `\@enumdepth` dispatch of `\pbitem` and `problemlist` (assignment.cls:58-86), the `\AtBeginDocument` header and the `\@oddfoot` redefinition (assignment.cls:117-136) would be hand-rolled conditionals and counters that drive printed labels, and would have been judged `BESPOKE/class`. Two reading notes, neither compiled: `problemlist` sets its list label to `\phantom{\CW}...` and `\CW` is defined nowhere in the zip (assignment.cls:74), so a bare `\item` inside `problemlist` would likely fail, but the sample uses `\pbitem`, which always gives an explicit label (assignment.cls:60); `\pbitem` is only defined for depths 0 to 4.

## Content-opaque
none

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
