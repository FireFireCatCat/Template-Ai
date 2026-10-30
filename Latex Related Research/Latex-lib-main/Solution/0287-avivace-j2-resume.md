no

# 0287-avivace-j2-resume: J2-resume (Jinja2-fed one-page CV on `res.cls`)

- Unverified: read from the source, not compiled.
- Source: Source/0287-avivace-j2-resume/ (origin: https://codeload.github.com/avivace/j2-resume/zip/refs/heads/master; licence: not established)
- Kind: cv
- Lib: v3
- Engine: needs XeLaTeX (`fontspec` with system fonts Inter and Abel in the main sample, template-redinter.tex:17-25; Makefile:5 runs `xelatex`; the fonts are not shipped, README.md:142 lists only `fonts-roboto`: missing asset, not a blocker). The sibling `template-nonfancy.tex` is pdfLaTeX-compatible (Makefile:9 runs `pdflatex`; it loads no fontspec, template-nonfancy.tex:17-33).
- Look carried by: mixed (page layout, section titles, name/address block come from the published class `res.cls`; fonts, colours, letter-spacing, name line and the hand-laid entry lines come from the sample's preamble and body)
- Class origin: ctan
- Main file: template-redinter.tex (other samples: template-nonfancy.tex, resume.tex = the rendered output of template-redinter.tex with sample.json)
- Read: main yes, zip-local classes and styles all (one file, `res.cls`, 803 lines, read in full; it is published, see Class setting)

## Verdict
`no`. The look itself is small and fully published: class `res` (CTAN) plus `fontspec`, `xcolor`, `hyperref` and kernel spacing and font commands, every component maps to a lib way and nothing in the preamble is irreducible. What blocks it is the build: the main sample is not LaTeX as shipped but a Jinja2 template whose `\jv{...}` and `\jb{...}` tags are expanded by `j2tex.py` (Python 3 with `jinja2`) from a JSON file, driven by a Makefile, before `xelatex` runs. That is the rubric's EXTERNAL case (a preprocessor and a Python script feeding values). If only the rendered `resume.tex` were taken as the sample, no other blocker would remain; that reading was not adopted.

## Blockers
- `EXTERNAL/body` Jinja2 tags in the template bodies need `python3 j2tex.py -i data.json -t template-redinter.tex -o resume.tex` before TeX can run: `\jv{data.name}` (template-redinter.tex:51), `\jv{data.website[8:]}` Python slicing (template-redinter.tex:59-61), the `\jb{ for edu in data.education }` loop with `\jb{ if ... }` (template-redinter.tex:94-109), the `\jb{ for experience in data.work }` loop (template-redinter.tex:124-133), same markers in template-nonfancy.tex:40-57, 83-98, 113-122; the Jinja environment with custom delimiters `\jb{` `\jv{` is built in j2tex.py:50-62 and called from Makefile:3-9.

## Class setting
- Class: `class.res` options: `11pt` (template-redinter.tex:15). The class passes `11pt,12pt` on to `article` and loads it (res.cls:188-189), so it sits on `class.article`; unused options are `line`/`centered` (name and address layout) and `overlapped`/`margin` (section title placement); defaults `overlapped,centered` (res.cls:194-200). Published: CTAN package `res` ("Res - A resume class", maintainer Venkat Krishnamurthy, path macros/latex/contrib/resume/res.cls, licence "Do Not Sell Except by Arrangement", one read of https://ctan.org/pkg/res); the zip copy declares `\ProvidesClass{res}[2000/05/19 v1.4b Resume class]` (res.cls:183). The zip copy was not byte-compared with the CTAN file.
- Class-native vocabulary used: `\newsectionwidth{len}` (template-redinter.tex:41), `\address{...}` twice (template-redinter.tex:58-68), `resume` environment (template-redinter.tex:73, 189), class-redefined `\section{...}` (title printed above the body, res.cls:411-432, 802). Defined by the class but not used by the sample: `\name`, `\opening`, `position`/`format`/`ncolumn` environments, `\employer` `\location` `\dates` `\title`, `\Resume` (res.cls:60-130, 469, 488, 506, 537, 616, 746).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | template-redinter.tex:15 | `class.res` | 11pt |
| page geometry (set inside the class) | res.cls:774-785, 283 | `class.res` | `\textheight 9in`, `\topmargin 0in`, `\oddsidemargin`/`\evensidemargin 0pt`, `\headheight`/`\headsep 0pt`, `\resumewidth=6.5in`; carried by loading the class, not emitted separately (raw-length equivalent: `page.setlength`) |
| section-title indent | template-redinter.tex:41, res.cls:286-292 | `head.class-native` | `\newsectionwidth{0pt}` (sets `\textwidth` to `\resumewidth` minus 0pt, `\hoffset` 0pt) |
| paragraph shape (set inside the class) | res.cls:779, 785 | `sp.lengths` | `\parindent 0pt`, `\parskip \baselineskip`; carried by the class |
| name and two-address block | template-redinter.tex:58-68, res.cls:216-231, 498-499, 522-524 | `front.class-native` | `\address{...}` twice: left box and right box of one line, printed by `\begin{resume}` through `\opening`; `\name` never called, so the class's own name box prints empty (res.cls:218, 490) |
| name line (big, letter-spaced) | template-redinter.tex:50-52 | `font.size-commands` | `\fontsize{40}{50}` |
| name line font and tracking | template-redinter.tex:50 | `font.fontspec` | `\headfont` (Abel), `\addfontfeature{LetterSpace=-4.5}` |
| name line centring | template-redinter.tex:50 | `sp.ragged` | kernel `\centerline` (same kernel centring family as `\centering`) |
| fonts: main and bold | template-redinter.tex:17, 19-22 | `font.fontspec` | `\setmainfont{Inter}`, then `\setmainfont[BoldFont={Inter Semi Bold}]{Inter}` |
| fonts: extra families | template-redinter.tex:24-25 | `font.fontspec` | `\newfontfamily\sbb{Inter Semi Bold}`, `\newfontfamily\headfont{Abel}` |
| colours | template-redinter.tex:18, 27-28 | `color.xcolor` | `darkred` HTML b71c1c, `darkgray` HTML 191919 |
| hyperlinks | template-redinter.tex:18, 30-33, 59-60, 150 | `meta.hyperref` | `colorlinks=true`, `urlcolor=darkred`; `\href{url}{text}` in addresses and text |
| dummy-text package (loaded, never called) | template-redinter.tex:17 | `draft.todo` | `kantlipsum` (a lipsum-family filler-text package; the package is the parameter) |
| page numbering | template-redinter.tex:35 | `pgnum.pagenumbering` | `\pagenumbering{arabic}` |
| page style | template-redinter.tex:36, res.cls:794 | `hf.pagestyle-kernel` | `\pagestyle{plain}` (overrides the class's `\pagestyle{empty}`) |
| section headings | template-redinter.tex:90, 120, 145, 180; res.cls:411-432, 802, 278-284 | `head.class-native` | class `\section` prints the title above the body (overlapped mode), `\sectionfont` = `\bf`, `\sectionskip` 3.5ex plus 1ex minus -.2ex, penalty `\@secpenalty` -500 (res.cls:774) |
| section heading size and tracking | template-redinter.tex:90, 120, 145 | `font.size-commands` + `font.fontspec` | `{\Large \section{\centerline{\addfontfeature{LetterSpace=7.5}EDUCATION}}}`; LetterSpace 7.5 or 8.5; last section has no tracking and no `\Large` (template-redinter.tex:180) |
| section heading centring | template-redinter.tex:90, 180 | `sp.ragged` | kernel `\centerline` inside `\section{}` |
| heading numbering off | res.cls:786 | `num.secnumdepth` | `\setcounter{secnumdepth}{0}`; carried by the class |
| entry lines (school or employer left, date right) | template-redinter.tex:95-96, 127-128, 152-153 | `sp.manual-space` | `\hfill`, `\\`, `\vspace{4pt}` |
| entry lines: slanted and semi-bold face | template-redinter.tex:95-96, 127-128, 152 | `mark.kernel` + `font.fontspec` | `{\sl ...}` kernel shape switch; `{\sbb ...}` the `\newfontfamily` switch above |
| entry body block | template-redinter.tex:126-131 | `font.size-commands` + `color.xcolor` | `\normalsize{...}`, `\small{\textcolor{darkgray}{...}}` |
| inline emphasis in body text | resume.tex:121 (rendered from sample.json:27) | `mark.kernel` | `\textit{...}` |
| bullet list under an education entry | template-redinter.tex:103-107 | `list.kernel` | `itemize`, shown only when the JSON has `subjects`; spacing from class `\@listI` (res.cls:787-792: `\topsep 0pt`, `\parsep`/`\itemsep` 2pt plus 2pt) |
| vertical spacing between blocks | template-redinter.tex:89, 92, 114, 139, 146, 181, 184 | `sp.manual-space` | `\vspace{8pt}`, `\vspace{10pt}`, `\vspace{0.2in}`, `\vspace{6pt}`, `\vspace*{\fill}` |
| closing note at page foot | template-redinter.tex:184-187 | `font.size-commands` | `\vspace*{\fill}` then `{\footnotesize ...}` |
| project entries (title link, stack right-aligned, description) | template-redinter.tex:152-174 | `sp.manual-space` | same `{\sbb \href{..}{..}} \hfill stack \\ text` pattern (the class's `position`/`format` machinery is not used) |
| nonfancy variant: default sans face | template-nonfancy.tex:33 | `font.family-default` | `\renewcommand\familydefault{\sfdefault}` |
| nonfancy variant: bold labels, plain headings | template-nonfancy.tex:85, 117, 141 | `mark.kernel` | `\textbf{...}` instead of `\sbb` |
| nonfancy variant: name line | template-nonfancy.tex:40 | `font.size-commands` | `\Large{...}` |
| front matter besides name and addresses, abstract, contents, floats, tables, maths, theorems, code, bibliography, index | whole sample | none used | not present (a one-page CV) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `res.cls` (box and glue section-title algorithm, token-list `position` builder, `\nofiles`) | res.cls:313-405, 411-432, 616-760, 203 | not bespoke: published on CTAN (W1) | counted as the way `class.res`; its irreducible internals are inside a published class, so they are not zip-local code |
| `\sbb`, `\headfont` | template-redinter.tex:24-25 | yes | two `\newfontfamily` declarations (`font.fontspec`) |
| Jinja2 tags `\jb{...}` `\jv{...}` and loops | template-redinter.tex:51-67, 94-133 | no (not LaTeX; filled by Python) | blocker `EXTERNAL/body` above |
| `j2tex.py` (jinja2 environment, JSON loader) | j2tex.py:49-74 | no | blocker `EXTERNAL/body` above (outside TeX) |
| `Makefile` (python3 then xelatex or pdflatex) | Makefile:3-9 | no | part of the same blocker |
| `json.lua` (lpeg JSON parser for LuaTeX, by Henri Menke) | json.lua:1-65 | not used | no file in the zip loads it (grep of `json.lua`, `luacode`, `directlua`, `dofile` finds nothing); README says the LuaLaTeX route was dropped (README.md:21) |

## Content-opaque
none (sample.json holds the CV data, which is content; no figure, table or picture exists)

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
