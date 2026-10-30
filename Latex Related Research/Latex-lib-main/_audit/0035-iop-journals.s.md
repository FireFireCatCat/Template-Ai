refuted=false

# 0035-iop-journals: skeptic audit (read-only, nothing compiled)

Analyst verdict under review: `yes`. Result: could not refute it. The `yes` rests entirely on the rubric's W1 ruling that a publisher's official kit is published; I checked that ruling's premise and it holds. Three small errors in the file (below), none changes the verdict.

## What I searched

- Whole zip: `ls` and `file` show five files: `iopjournal.cls` (185 lines, CRLF), `iopjournal-template.tex` (91 lines, CRLF), `figure1.pdf`, `orcid.pdf`, `iopjournal-guidelines.pdf` (4 pages). No `.sty`, `.def`, `.cfg`, `.clo`, `.bst`, `.bib`, script or Makefile.
- grep of both TeX files for `shell write18 minted \input \include \immediate \openout tikz pgf pstricks picture overlay output \newcounter \xpatch \patchcmd \pretocmd \apptocmd \AtBeginDocument \@maketitle \@seccntformat \def \gdef \edef`: the only hits are `\includegraphics` (cls:183, template:43) and one comment (template:6). No expl3, no Lua, no output routine, no custom counter, no `\patchcmd` on package internals, no TikZ/picture/PSTricks, no tool outside TeX.
- Packages the class loads: `fancyhdr` (cls:33), `xcolor` (35), `graphicx` (37), `hyperref [colorlinks=true, allcolors=blue]` (57), base `article` with `a4paper` (55). The sample loads none (template:3-8). All are in the analyst's map. Nothing is missing.
- Kernel-internal redefinitions present: `\section` family via `\@startsection` (cls:129-140), `\@makecaption` (167-175), `\tabular` wrapper (178-179), `\headrule`/`\footrule` (84-89), `abstract` (120-124). Each is a published-lib expression (`\titleformat`/`\titlespacing`, `caption` package keys, a font-size wrapper, the documented fancyhdr rule hook), and none is an output routine, `\halign` algorithm or counter that drives printing. `\@maketitle`, `\@seccntformat`, `\newcounter` do not occur.
- The only conditional is `\if@anonymous` (cls:42-44), set once by a class option, so it depends on a per-document field. The sample does not pass the option (template:3).
- Artwork: the only drawn things are two `{\color{gray}\hrule}` in the `\marginpar` (cls:96) and two in `abstract` (cls:122,124). These are plain rules (`sp.rule`) and `note.marginpar`, not TikZ or picture code. No `ART`.
- W1 premise: `_Manifest.tsv:36` gives `source=pub`, url `https://publishingsupport.iopscience.iop.org/wp-content/uploads/2025/07/ioplatextemplate.zip` (IOP's own domain), name `IOP_Journals`. cls:8-24 names IOP Publishing Ltd as copyright holder and maintainer. The zip ships `iopjournal-guidelines.pdf` as public documentation (its outline lists Introduction, Avoiding problems in the submission system, Special features available in iopjournal.cls with the anonymous option, ORCID iDs and back matter sections, Figures and tables, Reference styles). One CTAN read: `https://ctan.org/pkg/iopjournal` returns "Not Found", so the class is not on CTAN; the official-kit clause is the only route to W1, and the Origin satisfies it.
- Ways named in the file checked against `_Lib.md`: `page.class-options` (:64), `page.setlength` (:68), `sp.ragged` (:112), `sp.lengths` (:110), `sp.rule` (:116), `sp.manual-space` (:117), `sp.penalties` (:118), `font.size-commands` (:141), `mark.kernel` (:245), `hf.fancyhdr` (:94), `color.xcolor` (:150), `meta.hyperref` (:177), `front.class-native` (:199), `abs.class-native` (:203), `abs.keywords` (:204), `head.kernel` (:221), `head.titlesec` (:222), `num.secnumdepth` (:228), `note.marginpar` (:256), `fig.graphicx` (:289), `fig.placement` (:297), `tbl.tabular` (:299), `cap.kernel` (:308), `cap.caption` (:309), `xref.kernel` (:184). All exist.

## Citations compared with the source (30 checked, 3 wrong)

Matched: cls:12-20 (copyright, LPPL 1.3c), :29 (version 2024/01/31), :33/:35/:37/:57 (packages), :42-44 (`anonymous`), :49 (pass-through), :55 (`\LoadClass[a4paper]{article}`), :60-68 (lengths; 61-62 are the commented `\hoffset` and `\topmargin`), :71-72, :75-89, :93-96, :98-100, :103-106, :108-110, :112-114, :116-118, :120-124, :129-140, :145-163, :167-175, :178-179, :183, the `\if@anonymous` list :105/109/113/147/151/155/159; template:3-8, :10-28 (each class command at the line given), :41-46, :43, :45, :49-62, :61, :71-82, :85.

Wrong:
1. Component map row "table [sample] template:49-62" says "`\hline` x4". The table has three `\hline`s (template:53, 55, 59). Cosmetic.
2. "Content-opaque: ... the `\LaTeX` and `\href` examples in running text (31,36,44)". Line 36 holds only `\ref{fig1}` and `\ref{tab1}`. `\LaTeX` and `\href` are at 31 and 44. Cosmetic.
3. Header "Read: ... iopjournal.cls lines 1-184". The file has 185 lines (`wc -l` says 184 because the last line, `\endinput`, has no newline). Harmless.

## Overclaims (none is a blocker)

- `sp.penalties` (`_Lib.md:118`) names `\widowpenalty \clubpenalty \brokenpenalty \widowpenalties`. The file maps `\hyphenpenalty`/`\exhyphenpenalty` = 10000 (cls:98) to it with "as `sp.penalties` admits". The wording is generic ("integer penalty parameters") but the named list does not include them. `sp.hyphenat` is the other near home.
- `\suppressfloats[t]` (cls:100) is mapped to `fig.placement`, whose lib line is `placeins` and placement parameters. The command is kernel and takes no package. Weak fit, no better home.
- `mark.kernel` (`_Lib.md:245`) lists `\textbf \emph \textsc \textsf`. The file also uses it for the old switches `\sf \it \bf \rm` and `\bfseries \itshape`. Same family, not literally listed.
- The Verdict's "every other class macro reduces to lib ways" holds as a statement about parts, but the title block is not a plain wrapper. `\affil`, `\email`, `\keywords` (cls:108-118) set `\fontsize{8}{10}\selectfont\raggedright` in a group that closes before the paragraph ends (the `\par` is the blank line in the sample), so line-breaking uses the outer `\baselineskip`. `\author` (cls:104) has `\fontsize{10}{12}` with no `\selectfont` (the analyst noted this). The analyst's "reduction" of these macros to group wrappers is therefore a description, not an equivalent. It matters only if the class were zip-local; as `class.iopjournal` the emitter writes the class commands and gets the class's own behaviour.
- The analyst calls `\if@anonymous` irreducible if the class were zip-local. It depends only on a class option fixed per document, so the rubric's "conditionals that depend on more than fields fixed per document" test would not catch it. The analyst's reading is stricter than needed, which is the safe side.

## Not read / limits

- `iopjournal-guidelines.pdf` could not be rendered here (no PDF text tool; Read needs `pdftoppm`). I read only its outline titles from the file. The "Reference styles" section is unread, as in the analyst's file. The sample has no bibliography (template:85, empty `\section*{References}`) and the zip holds no `.bst`, so no component of the sample is affected.
- `figure1.pdf` and `orcid.pdf` are assets (`file` reports both as PDF, so pdfLaTeX can include them).

## Conclusion

No zip-local code outside the official class, no artwork, no external tool, no unmapped component. The class is IOP's own release (Manifest `pub`, IOP domain, IOP copyright and maintainer in the header), so under the rubric's W1 ruling it is one `class.iopjournal` way and the sample adds only content. Three cosmetic citation or count errors and four wording overclaims; `yes` stands.
