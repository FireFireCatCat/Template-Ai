no

# 0065-deepdave98-latex-resume-and-cv-templates: Compact resume template (`resume.cls`, six one-page resume and CV starters)

- Unverified: read from the source, not compiled.
- Source: Source/0065-deepdave98-latex-resume-and-cv-templates/ (origin: https://codeload.github.com/deepdave98/latex-resume-and-cv-templates/zip/refs/heads/main; licence: MIT)
- Kind: cv
- Lib: v1
- Engine: needs XeLaTeX (`fontspec` `\setmainfont` with `.otf` file names, resume.cls:12,24-28; `% !TeX program = xelatex`, templates/ml-engineer-resume.tex:1; `$pdf_mode = 5`, assets/starter/latexmkrc:2)
- Look carried by: zip-local (resume.cls sets every look decision; the six templates and two examples only call its commands and fill in text)
- Class origin: zip-local (one read of https://ctan.org/pkg/resume returned HTTP 404; resume.cls is the repository author's own wrapper around `article`, `\ProvidesClass{resume}[2026/09/06 Compact resume template]`, resume.cls:2; the repo is not a publisher's official kit)
- Main file: templates/ml-engineer-resume.tex (other samples: templates/ai-engineer-resume.tex, experienced-resume.tex, new-grad-resume.tex, no-internship-resume.tex, graduate-admissions-resume.tex; examples/application-versions/resume.tex and backend.tex with setup.tex and content/*.tex)
- Read: main yes, zip-local classes and styles all (resume.cls 324 lines; no `.sty`, `.def`, `.cfg`; templates/ml-engineer-resume.tex and graduate-admissions-resume.tex and the application-versions example files read in full; the four other templates (ai-engineer, experienced, new-grad, no-internship) read by grep outline of their commands, not line by line)

## Verdict
`no`. Almost everything in `resume.cls` reduces to published ways (`geometry`, `fontspec`, `titlesec`, `enumitem`, `needspace`, `ulem`, `hyperref`, kernel spacing and rules). One macro does not: `\resumeentryheading` measures the organisation and date boxes at typeset time and switches between two different tabular layouts with computed column widths, and derives its `\Needspace` amount from the measured box height. That is a box-and-glue measuring algorithm and no lib way expresses it. The closest published stand-in (`tabularx` with one `X` column and one `r` column) is not shown to be equivalent, and nothing was compiled. The TeX sources need no tool outside TeX (`latexmk -xelatex` only); the Makefile and Python scripts are packaging and test tooling.

## Blockers
- `BESPOKE/class` `\resumeentryheading`: `\sbox` of organisation and dates, `\ifdim` on `\wd` sum vs `\linewidth`, two alternative tabulars (`tabular*` with `\extracolsep{\fill}`, or `p`-column tabular with dates width capped at `0.4\linewidth` and a `1em` gap), then `\Needspace` of `max(ht+dp+3\baselineskip, 5\baselineskip)` from the measured box (resume.cls:223-265). Every `\jobentry` goes through it (resume.cls:278).

## Class setting
- Class: `class.article` loaded by the zip-local `resume.cls` (`\LoadClass{article}`, resume.cls:7); options: none in any sample (`\documentclass{resume}`, templates/ml-engineer-resume.tex:2); the class forwards any option to `article` (`\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}`, resume.cls:5).
- Class-native vocabulary used: none from `article` beyond `\section`. The zip-local class adds `\resumename`, `\resumecontact`, `\contactsep`, `\resumephone`, `\resumeemail`, `\resumelink`, `\jobentry[summary]{role}{organisation}{location}{dates}`, `jobduties` and `skillitems` environments, `\resumepagelimit` (templates/ml-engineer-resume.tex:3,10-17,21-27,44-49). These are zip-local, not published vocabulary; they are analysed under "Bespoke code".

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | resume.cls:5-7 | `class.article` | no options; options forwarded to article |
| page geometry | resume.cls:10 | `page.geometry` | left=0.5in, top=0.5in, right=0.5in, bottom=0.5in |
| header/footer | resume.cls:20 | `hf.pagestyle-kernel` | `\pagestyle{empty}` (no page numbers) |
| page flush | resume.cls:21 | `pg.flush` | `\raggedbottom` |
| main font | resume.cls:12,24-28 | `font.fontspec` | `\setmainfont{lmroman10-regular.otf}` with BoldFont=lmroman10-bold.otf, ItalicFont=lmroman10-italic.otf, BoldItalicFont=lmroman10-bolditalic.otf; files not in the zip (Latin Modern, expected in the TeX distribution, not read) |
| font sizes | resume.cls:203,212,217,237,283 | `font.size-commands` | name `\fontsize{30}{36}\selectfont`; contact `\small`; section `\large\bfseries`; dates `\small`; summary `\small\itshape` |
| colours | resume.cls:11,31-32,212,219 | `color.xcolor` | `namecolor` HTML 293E49 (text and headings), `linkblue` HTML 003B73 (links), rule colour `black!60` |
| paragraph lengths | resume.cls:197-198 | `sp.lengths` | `\parindent`=0pt, `\parskip`=0pt |
| links and PDF metadata | resume.cls:18,35-45; graduate-admissions-resume.tex:4 | `meta.hyperref` | colorlinks=true, urlcolor=linkblue, linkcolor=linkblue, pdftitle={Resume}, pdfauthor/pdfsubject/pdfkeywords/pdfproducer empty, pdfcreator={XeLaTeX}; per-document `\hypersetup{pdftitle={Curriculum Vitae}}` |
| url style | resume.cls:46 | `meta.url` | `\urlstyle{same}` |
| link underline | resume.cls:17,49 | `mark.ulem` | `ulem` with `normalem`; `\resumelink` = `\href{#1}{\uline{#2}}` |
| name block | resume.cls:201-205 | `font.size-commands`, `color.xcolor`, `mark.kernel`, `sp.manual-space` | `\noindent{\fontsize{30}{36}\selectfont\color{namecolor}\textbf{name}}\par`, then `\vspace{6pt}` |
| contact line | resume.cls:207,209-213 | `font.size-commands`, `color.xcolor`, `sp.rule`, `sp.manual-space`, `math.kernel` | `{\small\color{namecolor}...}\par\vspace{8pt}` then `{\color{black!60}\hrule height 0.5pt}`; separator `\enspace\ensuremath{\diamond}\enspace` |
| contact links | resume.cls:49,57-109; templates/ml-engineer-resume.tex:13-16 | `meta.hyperref`, `mark.ulem` | `\href{mailto:addr}{\uline{addr}}`, `\href{tel:+15555555555}{\uline{+1 (555) 555-5555}}`, `\href{url}{\uline{label}}`; link target is derived from the label by the emitter |
| section headings | resume.cls:216-221 | `head.titlesec`, `sp.rule`, `sp.manual-space` | `\titleformat{\section}{\large\bfseries\color{namecolor}}{}{0pt}{}[\vspace{6pt}{\color{black!60}\hrule height 0.5pt}]`; `\titlespacing*{\section}{0pt}{9pt}{6pt}`; label empty, so sections print unnumbered |
| entry heading line (organisation, location left; dates right) | resume.cls:235-265 | `tbl.tabular`, `pg.needspace` (selection logic is BESPOKE, see Blockers) | branch A `tabular*{\linewidth}{@{}l@{\extracolsep{\fill}}r@{}}`; branch B `tabular{@{}p{w1}@{\hspace{1em}}p{w2}@{}}` with `\raggedright`/`\raggedleft`, w2 = min(date width, 0.4\linewidth); `\Needspace` measured; bold in `namecolor`; `\vspace{8pt}` before |
| entry role and summary | resume.cls:270-286 | `mark.kernel`, `font.size-commands`, `color.xcolor`, `sp.manual-space` | role `\textit` in `namecolor`; optional summary `\small\itshape` in `namecolor` with `\/`; gaps 1pt, 4pt; gap before bullets 3pt (no summary) or 5pt (summary) |
| page-break control | resume.cls:264,280,283,285 | `pg.break` | `\nopagebreak` after the heading, role and summary |
| keep-with-next | graduate-admissions-resume.tex:89 | `pg.needspace` | `\Needspace{8\baselineskip}` before a section |
| entry bullets | resume.cls:289-305 | `list.enumitem`, `sp.linespread`, `sp.manual-space`, `color.xcolor` | `itemize[leftmargin=*, label=\textbullet, topsep=2pt, itemsep=2pt, parsep=0pt, partopsep=0pt]`, `\linespread{1.06}`, `\color{namecolor}\normalfont`, `\vspace` before (3pt or 5pt) and 4pt after |
| skills bullets | resume.cls:308-324; templates/ml-engineer-resume.tex:45-49 | `list.enumitem`, `sp.linespread`, `sp.manual-space`, `color.xcolor`, `mark.kernel` | same itemize parameters as entry bullets, `\vspace{8pt}` before, 4pt after; items start `\textbf{Label}:` |

No component defines bibliography, floats, captions, theorems, maths, code, footnotes, language or index; none appear in any sample.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `resume.cls` as a class | resume.cls:1-324 | yes | `\LoadClass{article}` plus `geometry`, `xcolor`, `fontspec`, `titlesec`, `enumitem`, `needspace`, `ulem`, `hyperref` and the settings in the map; the logic in the rows below is separate |
| `\resumelink` | resume.cls:49 | yes | alias for `\href{url}{\uline{label}}` (`meta.hyperref` + `mark.ulem`) |
| `\resumeemail`, `\resumephone` (expl3 `\regex_match`, `\tl_set`) | resume.cls:57-109 | yes (judgement call) | the regex checks and string clean-up only validate the label and compute the link target (`mailto:` plus address with `\_` turned into `_`; `tel:` plus the number with spaces, brackets, dots and hyphens removed). They place nothing on the page. An emitter that holds the address and number writes the final `\href{...}{\uline{...}}`. A stricter reading could call this BESPOKE/class; the verdict is `no` either way |
| `\resumecheckfield`, `\__resume_match:n`, counter `resumeentry`, bool `\l__resume_placeholder_bool` | resume.cls:112-159,224,272-276,290,309 | yes (no typeset effect) | placeholder lint that only raises `\ClassWarning`; the counter only labels the warning. No effect on the PDF, so the emitter drops it |
| `\resumepagelimit` and the `enddocument/afterlastpage` hook | resume.cls:165-195; templates/ml-engineer-resume.tex:3 | yes (no typeset effect) | warns when the page count exceeds a stored integer; the source says layout values are not changed (resume.cls:162). Dropped |
| `\resumename` | resume.cls:201-205 | yes | `font.size-commands` + `color.xcolor` + `mark.kernel` + `sp.manual-space` as in the map |
| `\contactsep` | resume.cls:207 | yes | `\enspace\ensuremath{\diamond}\enspace` (`sp.manual-space`, `math.kernel`) |
| `\resumecontact` | resume.cls:209-213 | yes | `\small` coloured line, `\vspace{8pt}`, 0.5pt rule in `black!60` (`sp.rule`) |
| `\resumeentryheading` (boxes `\resumeorganizationbox`, `\resumedatesbox`, `\resumeheadingbox`; lengths `\resumedateswidth`, `\resumeorganizationwidth`, `\resumeentryspace`) | resume.cls:223-265 | **no** | measures widths at typeset time, picks between two tabular layouts with computed `p` column widths and a 40% cap, and sets `\Needspace` from the measured height. Nearest published form: `tbl.tabularx` with `{@{}X r@{}}` and `pg.needspace`; it would not reproduce the 40% cap on dates, the guaranteed 1em gap, or the measured `\Needspace`, so equivalence is not shown. Irreducible, BESPOKE/class |
| `\jobentry` (optional first argument, `\ifblank` from `etoolbox`, `\jobdutiesvspace`) | resume.cls:223,270-286 | yes, apart from the call into `\resumeentryheading` | the `\ifblank` tests choose omit-location, summary line present or absent, and 3pt vs 5pt gap; the emitter knows these when it writes the document and emits the matching fixed spacing |
| `jobduties`, `skillitems` (`+b` environments from `xparse`) | resume.cls:289-324 | yes | the captured body is only passed to the lint and then replayed inside `itemize`; reduces to the enumitem list in the map |
| body helpers `\ResumeBullet`, `\SharedHeader`, `\SharedEducation`, `\SharedToolProject`, `\ToolWorkflow`... | examples/application-versions/setup.tex:7-10; content/*.tex | yes | `\ResumeBullet` is lint plus `\item #1`; the others are `\newcommand` aliases for a header, an entry or a bullet group, so the emitter writes their content directly |

## Content-opaque
none

## Lib changes
- New ways proposed: none. The name block and contact line are hand-composed from existing kernel ways (`font.size-commands`, `color.xcolor`, `sp.rule`, `sp.manual-space`), so no `front.*` way was added.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- Nothing in the zip's TeX is addressed to an AI; none of the text read was an instruction.
- Not a blocker: `etoolbox` is loaded only for `\ifblank` inside the bespoke macros (resume.cls:15,236,246,277,281); it is not a component.
- Not `EXTERNAL`: no `shell-escape`, `minted`, `\write18` or `\directlua` in any `.tex` or `.cls` (grep). Makefile (Makefile:20-26,88-92) only calls `latexmk -xelatex`; the Python files under scripts/ and tests/ package and check the output.
- The nested archives in downloads/ were listed only (`ml-engineer-resume.zip` holds resume.tex, resume.cls, latexmkrc, START_HERE.md, LICENSE); their copies of `resume.cls` were not read separately.
- Missing assets: the Latin Modern OpenType files named at resume.cls:24-28 are not shipped; ship them or rely on the TeX distribution.
