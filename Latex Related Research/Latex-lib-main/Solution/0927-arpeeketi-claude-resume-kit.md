yes

# 0927-arpeeketi-claude-resume-kit: Academic CV template (cv.cls) with resume and moderncv cover-letter siblings

- Unverified: read from the source, not compiled.
- Source: Source/0927-arpeeketi-claude-resume-kit/ (origin: https://codeload.github.com/ARPeeketi/claude-resume-kit/zip/refs/heads/main; licence: MIT for the repo; cv.cls and resume.cls keep a separate permissive Trey Hunner / LaTeXTemplates notice, cv.cls:9-17)
- Kind: cv
- Lib: v6
- Engine: pdfLaTeX-compatible
- Look carried by: mixed (zip-local cv.cls defines the title block, section, entry and skills environments; the sample preamble sets geometry, footer and link colours)
- Class origin: zip-local
- Main file: resume_builder/templates/cv_template.tex (other samples: resume_builder/templates/resume_template.tex, resume_builder/templates/coverletter_template.tex, resume_builder/examples/output/e2e_whitfield_proteineng_resume.tex, resume_builder/examples/output/e2e_whitfield_proteineng_cover_letter.tex)
- Read: main yes, zip-local classes and styles all

File names are unique in the zip, so citations below use the bare name (`cv.cls` and `resume.cls` are in resume_builder/templates/).

## Verdict
`yes`, with two borderline items stated openly. The main sample loads the zip-local `cv.cls`, which is `\LoadClass[11pt, a4paper]{article}` (cv.cls:23) plus published packages plus `\newenvironment`/`\def` wrappers made only of kernel list, rule, font-switch and spacing commands; each reduces by inline expansion to lib ways with parameters (table below). No TikZ or picture drawing exists in any template (the `tikz` and `mhchem` loads are never called), no tool outside TeX produces the output, and the `[GENERATE:]` and `[CONFIG:]` markers are content slots. The two borderline items are the `\address` slot logic and the `\ifthenelse` emptiness tests; both are decided by the data at emit time, so the emitter writes the result and copies no macro logic.

## Blockers
none

## Class setting
- Class: `class.article` options: `11pt`, `a4paper`, reached through the zip-local class `cv` (cv_template.tex:17, cv.cls:23). Other samples: `class.article` `10pt`, `a4paper` through `resume` (resume_template.tex:14, resume.cls:23); `class.moderncv` options `11pt`, `a4paper`, `roman` (coverletter_template.tex:1).
- Class-native vocabulary used: article's own vocabulary is not used (no `\section`, `\maketitle`, `abstract`). The zip-local vocabulary `\name`, `\address`, `rSection`, `rSection2`, `rSubsection`, `skillgroup`, `\skilldash`, `\subtheme` is bespoke and is reduced below. moderncv (cover letter only): `\moderncvstyle{classic}`, `\moderncvcolor{green}`, `\name{}{}`, `\address`, `\phone[mobile]`, `\email`, `\recipient{To}{...}`, `\date`, `\opening`, `\makelettertitle` (coverletter_template.tex:3-4, 12-15, 20-23).
- Origin check: cv.cls:4-5 says it came from LaTeXTemplates.com; ctan.org/pkg/cv is a different package (Philipp Maier, GPL), ctan.org/pkg/resume is a 404, and the zip is a GitHub repo and not an official release, so both classes are zip-local.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | cv_template.tex:17; cv.cls:23 | `class.article` | 11pt, a4paper (emitter writes `\documentclass[11pt,a4paper]{article}` and no zip-local class) |
| paper and size | cv.cls:23 | `page.class-options` | 11pt, a4paper |
| page geometry | cv_template.tex:33 | `page.geometry` | includefoot, left=0.75in, top=0.76in, right=0.75in, bottom=0.7in, textwidth=7.5in, textheight=10.9in (left + text + right = 9in, wider than A4, so the package resolves an over-determined set) |
| paragraph shape | cv.cls:25 | `sp.parskip-pkg` | option parfill |
| footer | cv_template.tex:34-38 | `hf.fancyhdr` | `\pagestyle{fancy}`, `\fancyhf{}`, `\headrulewidth`=0pt, `\rfoot{\thepage/\pageref{LastPage}}` |
| page X/Y | cv.cls:24; cv_template.tex:38 | `pgnum.lastpage` | `lastpage` loaded by the class, `\pageref{LastPage}` |
| page reference | cv_template.tex:38 | `xref.kernel` | `\pageref` |
| links and PDF metadata | cv_template.tex:18, 23-30, 44-45, 238 | `meta.hyperref` | colorlinks=true, linkcolor=[rgb]{0.1,0.1,0.6}, citecolor=[rgb]{0.4,0.4,0.4}, urlcolor=[rgb]{0.0,0.0,0.7}, pdftitle, pdfauthor strings; `\href` |
| icons in header | cv_template.tex:19, 44, 45 | `font.icons` | `fontawesome`: `\faEnvelope`, `\faMapMarker`, `\faLinkedin` |
| icon images in header | cv_template.tex:22, 45; resume_builder/templates/orcid.png, GS.png | `fig.graphicx` | `\includegraphics[height=1em]{orcid.png}` and `{GS.png}`, inline, not floats; assets shipped in the zip |
| colour | cv_template.tex:31, 173, 187, 200 | `color.xcolor` | `\textcolor{black!60}{...}` on the date field |
| title block (name, address lines) | cv.cls:46-114; cv_template.tex:43-45 | `font.size-commands`, `mark.kernel`, `sp.manual-space` | name `{\huge\bf name}\hfil` then `\medskip\break`; each address line a paragraph; the sample's separators are literal bar glyphs in math mode (cv_template.tex:45). Inline body text, no front-matter way needed |
| section heading, plain (rSection) | cv.cls:121-133; used cv_template.tex:91, 101, 125, 169, 237 | `mark.kernel`, `sp.manual-space`, `sp.rule`, `list.kernel`, `sp.lengths` | `\medskip`, `{\bf Title}`, `\medskip`, `\hrule`, then generic `list` with empty label, `\leftmargin`=0.5em, first `\item[]` |
| section heading, bulleted (rSection2) | cv.cls:135-146; used cv_template.tex:223, 266, 275, 285, 294 | same ways as above | heading as above plus `\medskip` after the rule; list label `$\bullet$`, `\leftmargin`=1.5em, `\itemsep`=-0.3em, `\vspace{-0.5em}` before items, `\vspace{0.5em}` after |
| section heading, enumerated (rSection3, not used by the sample) | cv.cls:148-159 | `list.enumitem`, `sp.lengths`, `sp.manual-space` | `enumerate[]`, `\itemsep`=-0.3em; the `\setlength{\leftmargin}` sits in its own brace group, so it has no effect |
| entry (rSubsection) | cv.cls:164-179; used cv_template.tex:173, 187, 200 | `mark.kernel`, `sp.manual-space`, `list.kernel`, `sp.lengths` | `{\bf #1}\hfill{#2}`, optional italic line for #3 and for #4 (`\\` between), `\smallskip`; list label `$\cdot$`, `\leftmargin`=1.5em, `\itemsep`=-0.2em, `\vspace{-0.2em}`, trailing `\vspace{0.2em}` |
| sub-theme line | cv.cls:207; used cv_template.tex:175, 178, 181 | `mark.ulem`, `list.kernel` | `\item[]` plus `\underline{...}` (kernel underline, no package) |
| skills block | cv.cls:189-200; used cv_template.tex:130-155 | `list.kernel`, `sp.lengths`, `mark.kernel`, `pg.break`, `sp.manual-space` | `\textbf{name}\par\nopagebreak\vspace{-\parskip}`, list label `--`, `\leftmargin`=0.8em, `\labelsep`=0.3em, `\itemsep`=0pt, `\topsep`=0.1em, `\parsep`=0pt, `\partopsep`=0pt, after list `\vspace{-\parskip}\vspace{0.45em}`; `\skilldash` is `\item` |
| education lines | cv_template.tex:101-109 | `mark.kernel`, `sp.manual-space` | `\textbf`, `\textit`, `\hfill`, `\\` |
| numbered publications | cv_template.tex:243-251 | `list.enumitem`, `mark.kernel` | `enumerate[leftmargin=1.5em, labelsep=0.5em, itemsep=0.1em]` with manual `\item[3.]` labels; bold sub-heading `\textbf{Published}` |
| publication stats line | cv_template.tex:238-241 | `mark.kernel`, `sp.manual-space`, `meta.hyperref` | `\textit{...}\hfill\href{...}{...}`, `\vspace{0.07cm}`, `\vspace{0.15cm}` |
| manual spacing in body | cv_template.tex:48, 94, 110, 158, 239, 241; cv.cls:210-214 | `sp.manual-space`, `font.size-commands` | `\vspace{-0.03cm}`, `-0.01cm`, `-0.0cm`, `0.07cm`, `0.15cm`; `\namesize`=`\huge`, skips = `\medskip` and `\smallskip` |
| chemistry package (load only) | cv_template.tex:32 | `art.content-package` | `mhchem` `version=4`, `arrows=pgf-filled`; `\ce` is never called in the template, content only |
| TikZ (load only) | cv_template.tex:21 | `art.tikz` | `\usepackage{tikz}`; no picture or `\draw` exists in any template, so no ART |
| table package (load only) | cv.cls:26 | `tbl.tabular` | `array` loaded by the class; no tabular in the samples |
| list package | cv.cls:28; cv_template.tex:20 | `list.enumitem` | load only except the publications list above |
| fonts | none loaded | none | article default (Computer Modern) |
| resume.cls differences (other sample) | resume.cls:23, 29, 153-164, 174-181; resume_template.tex:31-37 | `class.article`, `hf.pagestyle-kernel`, `hf.fancyhdr`, `pgnum.lastpage` | 10pt; `\pagestyle{empty}` then the template sets `fancy`; footer `\fancyfoot[R]{\hfill\thepage/\pageref{LastPage}}`; entry puts #3 and #4 on one italic line joined by `\quad` (resume.cls:157); geometry resume_template.tex:30 (left=0.5in, top=0.5in, right=0.5in, bottom=0.2in, textwidth=7.5in, textheight=10.8in) |
| cover letter (other sample) | coverletter_template.tex:1-8, 20-25, 37-40 | `class.moderncv`, `ltr.opening`, `lang.babel`, `font.fontenc-t1`, `page.geometry`, `sp.ragged`, `art.content-package` | moderncv classic/green; `babel[english]`; `inputenc[utf8]`; `geometry[scale=0.79]`; `ragged2e` `justify` environment; `mhchem` load only; hand-laid closing block with `\\` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\name`, `\@name` storage | cv.cls:46-47 | yes | alias; the name is written in the title block |
| `\address` four-slot logic (`\let ... \relax`, nested `\@ifundefined`) | cv.cls:51-72; resume.cls:41-61 | yes (borderline) | By my reading the 1st to 3rd calls fill slots two, three, four and the 4th fills slot one, and printing goes one, two, three, four. For the CV's two calls (cv_template.tex:44-45) print order equals source order. For the resume's four calls (resume_template.tex:47, 49, 51, 54) the tagline prints first. The order is a function of the data, so the emitter writes the lines in print order (`sp.manual-space` paragraphs) |
| `\printaddress` with `\\` redefined to a bar separator | cv.cls:75-83 | yes | inline substitution of the separator for each `\\` inside an address (used at resume_template.tex:47; absent from cv_template.tex:44-45) |
| `\printname` | cv.cls:86-93 | yes | `{\huge\bf name}\hfil\medskip\break` (`font.size-commands`, `mark.kernel`, `sp.manual-space`) |
| `\renewcommand{\document}` hook that prints the header | cv.cls:99-114; resume.cls:88-103 | yes | it calls the original `\document` and then prints name and address lines; the emitter writes the same block right after `\begin{document}` and changes no kernel behaviour |
| `rSection`, `rSection2`, `rSection3` | cv.cls:121-159 | yes | inline expansion to the rows above (kernel `list`, `\hrule`, font switch, skips) |
| `rSubsection` with `\ifthenelse{\equal{#3}{}}` and `#4` tests | cv.cls:164-179 | yes (borderline) | the test only decides whether an italic line exists; the emitter knows the argument and emits or omits the line. `ifthen` is a macro-body helper that vanishes under expansion, so it is not a way (considered: `ifthen`) |
| `skillgroup`, `\skilldash`, `\subtheme` | cv.cls:189-207 | yes | inline expansion to kernel `list`, `\item`, `\underline`, `\nopagebreak`, `\vspace` |
| skip macros `\namesize`, `\addressskip`, `\sectionlineskip`, `\nameskip`, `\sectionskip` | cv.cls:210-214 | yes | aliases of `\huge`, `\smallskip`, `\medskip` |
| `\tab`, `\itab` (never called) | resume_template.tex:36-37 | yes | aliases of `\hspace` and `\rlap`; unused, drop or keep |
| `\makeletterclosing` redefinition (never invoked, the letter ends with a hand-laid block) | coverletter_template.tex:9 | yes | would equal `\par\vspace{2ex}\closingname\par`, kernel commands plus the class string; not called |
| `resume.cls` copies of all of the above | resume.cls:35-199 | yes | same reductions; differences listed in the component map |

## Content-opaque
none (the `[GENERATE:]`, `[CONFIG:]` and `[FIXED:]` markers are text slots; the mhchem `\ce` command is not called in any template)

## Lib changes
- New ways proposed: none. Considered and not proposed: `ifthen` (macro-body helper, W4 fails as for `sp.xspace` in v4).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- No tool outside TeX produces the output. `resume_builder/helpers/char_count.py` only counts characters for authors (imports `re`, `sys`, `argparse`, char_count.py:13-15) and is not part of the build. The `.claude/skills` files and `CLAUDE.md` describe the kit's own authoring workflow and are not template code.
- Text addressed to an AI in the zip: CLAUDE.md states "Output .tex files ONLY" and gives generation rules for the kit's own skills. It was read as data and not followed.
- Missing assets: none missing; orcid.png and GS.png ship in resume_builder/templates/.
- Not verified by compiling: the over-determined geometry (cv_template.tex:33), and whether hyperref accepts the `[rgb]{...}` colour form at cv_template.tex:25-27 (the sample is read, not compiled).
