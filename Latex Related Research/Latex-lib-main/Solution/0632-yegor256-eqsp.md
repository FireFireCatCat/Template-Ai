yes

# 0632-yegor256-eqsp: "Ensuring Quality in Software Projects" course syllabus (huawei class)

- Unverified: read from the source, not compiled.
- Source: Source/0632-yegor256-eqsp/ (origin: https://codeload.github.com/yegor256/eqsp/zip/refs/heads/master; licence: MIT, LICENSE.txt and syllabus/syllabus.tex:2)
- Kind: misc (a course syllabus handout; the manifest hint `book` is wrong)
- Lib: v5
- Engine: pdfLaTeX-compatible (as read: `syllabus/.latexmkrc:1` runs `pdflatex`; nothing in the sample needs XeLaTeX or LuaLaTeX; the `huawei` class source was not read)
- Look carried by: class (the sample's preamble only loads the published class `huawei` and three published packages; there is no zip-local class or style; the body adds only ordinary font switches and one `multicols` block)
- Class origin: tex-distribution-unbundled (`huawei` and `ffcode` are on CTAN and in TeX Live per ctan.org/pkg/huawei and ctan.org/pkg/ffcode, both read for this analysis; `href-ul` is on CTAN per the lib's `meta.hyperref` line, not re-read; `.github/workflows/latexmk.yml:18` installs `huawei ffcode href-ul` as packages; none of their files is in the zip)
- Main file: syllabus/syllabus.tex (other samples: none; the other 24 files are build, CI and licence files)
- Read: main yes, zip-local classes and styles none present (the source of `huawei`, `ffcode` and `href-ul` was not read: they are not in the zip)

## Verdict
The whole document is one `.tex` file (332 lines) that loads the published class `huawei` and the published packages `multicol`, `href-ul` and `ffcode` (syllabus/syllabus.tex:4-7), then uses kernel constructs only: starred `\section*`, `abstract`, `itemize`, `enumerate`, `\newpage`, font switches, `\href` and one `multicols{2}` block. The zip holds no `.cls`, `.sty` or `.def`, and its only own macro is the alias `\github` (:170), which reduces by inline expansion. Every component maps to a lib way; the one gap, `ffcode`'s inline `\ff{}`, is proposed as `code.listings` (W2 is shown only as far as a load line and a text argument, see Lib changes). The risk is the unread class: the look inside `huawei` (page, running heads, heading style) is carried by `class.huawei` and its source was not read; if it loaded a shell-escape package unconditionally the pilot ruling would make that `EXTERNAL/package`, but nothing in the zip or on the CTAN pages says so, and the CI package list (`.github/workflows/latexmk.yml:18`) names no `minted` (see Bespoke code, build rows).

## Blockers
none

## Class setting
- Class: `class.huawei` options: `nobrand`, `anonymous`, `nodate`, `nosecurity` (syllabus/syllabus.tex:4). Class source not read (published, not bundled); CTAN describes it as an unofficial class for documents of people working with Huawei, MIT licence, by Yegor Bugayenko, in TeX Live and MiKTeX.
- Class-native vocabulary used: the four options above; the `abstract` environment (syllabus/syllabus.tex:17-26); starred `\section*` (:70); `\nospell{...}` (:319, :328, :329), whose definition is not in the zip, so it comes from `huawei` or `ffcode` (origin not established; `syllabus/.texsc:3` lists `ff` and `nospell` together as commands whose text the spell checker skips, so it is a content wrapper with no look). The sample calls no `\title`, `\author`, `\maketitle`, `\bibliography` or caption command.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | syllabus/syllabus.tex:4 | `class.huawei` | options nobrand, anonymous, nodate, nosecurity |
| page geometry, base fonts, spacing | not set in the sample (no `geometry`, `fontenc` or `setspace` call, syllabus/syllabus.tex:4-8) | `class.huawei` | decided by the class; source not read |
| header, footer, brand, date, security mark | syllabus/syllabus.tex:4 | `hf.class-native` | inferred from the option names `nobrand` `nodate` `nosecurity` `anonymous`, which switch such marks off; not read in the class |
| title block | syllabus/syllabus.tex:10-11 | `mark.kernel` | `\sffamily` and `\bfseries` on the title line; no `\maketitle` (hand-set in the body) |
| title block size | syllabus/syllabus.tex:10 | `font.size-commands` | `\Large` |
| title block line break | syllabus/syllabus.tex:10 | `sp.manual-space` | `\\` after the title (also `\\` at :30, :34, :46, :61 after run-in bold questions) |
| subtitle link | syllabus/syllabus.tex:11 | `meta.hyperref` | `\href{https://www.yegor256.com}{Yegor Bugayenko}` |
| abstract | syllabus/syllabus.tex:17-26 | `abs.kernel` | `abstract` environment, no options; if `huawei` re-skins it the way is `abs.class-native` (not read) |
| headings | syllabus/syllabus.tex:70, 168, 231, 263, 314 | `head.kernel` | five starred `\section*{...}`, no numbered levels, no `\subsection` |
| heading look | syllabus/syllabus.tex:70 (class-set) | `head.class-native` | decided by the class; not read |
| lists | syllabus/syllabus.tex:74-80, 84-92, 96-165, 271-278, 297-303 | `list.kernel` | `itemize`, no optional arguments, no nesting |
| lists (numbered) | syllabus/syllabus.tex:174-226, 236-258 | `list.kernel` | `enumerate`, no optional arguments |
| emphasis | syllabus/syllabus.tex:30, 82, 319 | `mark.kernel` | `\textbf` (:30), `\emph` (:82, :319); `\texttt` at :248 |
| page breaks | syllabus/syllabus.tex:69, 167, 230, 262, 313 | `pg.break` | `\newpage` directly before each of the five starred sections (:70, :168, :231, :263, :314) |
| manual spacing | syllabus/syllabus.tex:178, 183, 188, 192, 198, 204, 212, 220; 319-329 | `sp.manual-space` | `\vspace{3pt}` between enumerate items; `\\[3pt]` between book entries |
| two-column block | syllabus/syllabus.tex:5, 318-330 | `cols.multicol` | `\usepackage{multicol}` (:5), `multicols{2}` (:318) |
| block font size | syllabus/syllabus.tex:318 | `font.size-commands` | `\small` |
| block alignment | syllabus/syllabus.tex:318 | `sp.ragged` | `\raggedright` |
| hyperlinks | syllabus/syllabus.tex:6, 11, 36, 41-43, 98-164 | `meta.hyperref` | `\usepackage{href-ul}` (:6, load-only, underlines `\href` text); `\href{url}{text}` throughout (hyperref is loaded at least through `href-ul`) |
| link alias | syllabus/syllabus.tex:170 | `meta.hyperref` | `\github{x}` is `\href{https://github.com/x}{x}` (see Bespoke code) |
| inline code | syllabus/syllabus.tex:7, 187, 190, 225 | `code.listings` | `\usepackage{ffcode}` (no options), inline `\ff{pom.xml}` `\ff{Makefile}` `\ff{README.md}` |
| inline monospace | syllabus/syllabus.tex:248 | `mark.kernel` | `\texttt{README.md}` |
| spell-check wrapper | syllabus/syllabus.tex:319, 328, 329 | `class.huawei` | `\nospell{text}`, one text argument, no visual effect as read; origin `huawei` or `ffcode` |
| quotes and dashes | syllabus/syllabus.tex:281, 292 | `mark.kernel` | TeX ligatures ` ``A'' ` and `---` in text; no `csquotes`; content |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\newcommand\github[1]` | syllabus/syllabus.tex:170 | yes | inline expansion to `\href{https://github.com/#1}{#1}` (`meta.hyperref`); used on about 35 lines, :175-225 |
| open group `{` at the title line | syllabus/syllabus.tex:10; the closing `}` stands inside the comment at :13 | yes | not a macro. As read, `\sffamily` stays active from :10 to `\end{document}`; the emitter writes it as `mark.kernel` (`\sffamily`) around the title block, or document-wide if that is the intent |
| `$success_cmd = 'texsc'` (spell check after a build) | syllabus/.latexmkrc:4 (root `.latexmkrc:4` is `texqc && texsc`) | not part of the look | a post-build Ruby spell and quality check (`texsc`, `texqc`, `aspell`; word list `--pws=../aspell.en.pws`, syllabus/.texsc:1, not in the zip); it produces no output file, so not EXTERNAL |
| `-shell-escape` in the latexmk command | syllabus/.latexmkrc:1; root `.latexmkrc:1` | not part of the look | a build flag shared by every directory of the repository (root `Makefile:31-36` copies it into each); `Makefile:40` and `.gitignore:1-2` mention `_minted*`, which are leftovers of decks outside this zip. No file in the zip loads `minted`, and the CI package list (`.github/workflows/latexmk.yml:18`) has no `minted`; whether `huawei` loads it was not read (class source) |
| Makefile build and CI | Makefile:11-29; .github/workflows/latexmk.yml:15-18 | not part of the look | `latexmk` over `syllabus` (the numbered lecture directories that `DIRS` at Makefile:11 expects are not in this zip), then copies PDFs; it does not generate any `.tex` |
| zip-local `.cls`, `.sty`, `.def`, `.cfg` | none in the zip | n/a | `huawei`, `ffcode`, `href-ul` are published and unbundled, so they are not bespoke code |

## Content-opaque
none (the sample has no figure, table, TikZ picture or equation)

## Lib changes
- New ways proposed: `code.listings` `ffcode` (CTAN, TeX Live, MiKTeX, MIT; Yegor Bugayenko; the CTAN page, read for this analysis, gives v0.13.1 and says it configures `listings` and `tcolorbox` for code blocks and inline code), pdfLaTeX (the CTAN page states no engine; its two bases are pdfTeX packages). Preamble `\usepackage{ffcode}`, body inline wrapper `\ff{text}` (a block form exists in the package but the sample does not use it and the source was not read). W1: on CTAN and installed from CTAN in `.github/workflows/latexmk.yml:18`. W2: the sample sets no option and the options were not read, so declarative parameters are shown only as far as a load line and a text argument. W3: serves any code span or block of any document. W4: one preamble line and one inline wrapper. Not `code.verbatim` (no `\verb`), not `mark.kernel` (a kernel font switch). The consolidator may instead widen `code.listings` (a package built on `listings`) with the package as the parameter.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
