# Skeptic audit: 0058-standalone (analyst said yes)

Result: not refuted. The yes holds under the rubric, with several overclaims and mapping slips that do not change the verdict. Read-only; nothing was compiled or run.

## What I searched
- Whole description part of Source/0058-standalone/standalone.dtx (lines 1-1176) and the class/package code at 1180-1737, 2074-2745, 3340-3490, 4795-4896; grep over the rest for shell escape, `\write18`, TikZ/PSTricks/picture, kernel redefinitions, `\patchcmd`.
- README.txt, DEPENDS.txt, standalone.ins, the manifest row (`_Manifest.tsv:59`).
- Two CTAN reads: ctan.org/pkg/metalogo and ctan.org/pkg/ydoc.

## Why the yes survives
- Origin is the CTAN release itself (manifest row: mirrors.ctan.org/macros/latex/contrib/standalone.zip), so W1 holds for `standalone.cls`/`standalone.sty` (official release). The irreducible kernel work is real (`\global\pdfpagewidth=\wd\sa@box` and `\special{ps::...}` at dtx:2564-2625, `\@float` swap at 1672-1682, `\documentclass` rewrite in the package) but it sits in a published class and package. The analyst said so openly (Verdict) and did not hide it.
- No ART: every `tikzpicture` in the document part is inside `lstlisting` (dtx:332-334, 1130-1132, 1152-1154, 1164-1166). I grepped `\draw`, `pspicture`, `\put`, `picture` below line 1176: no drawn picture.
- No EXTERNAL at load: `\ShellEscape` calls sit inside `\ifsa@convert` (dtx:2742-2940) or inside `\includestandalone@` modes (4748-4775). Nothing runs unconditionally.
- Body bespoke code is small and reducible or dead: `\Eurl` (dtx:48) is defined and never used (grep: one hit); `\showbuildvar` (1027-1031) prints the bodies of `sa@build@latexoptions`, `jobname`, `command`, which are constant strings (3352, 3374-3376, 3383-3385), so literal strings do reproduce them.

## Overclaims and mapping slips (none is a blocker)
1. Implementation not typeset. Driver has `\OnlyDescription` (dtx:46) and the file has `\StopEventually{}` at 1174. The analyst's rows "implementation code, 231 macrocode blocks, `code.listings`" and the vocabulary line "macrocode (231 blocks)" claim code the sample's driver does not print. The analyst half admits `code.listings` is an inference from 1177. Counts themselves are right (231 macrocode, 98 macro, 64 key, 8 environment).
2. `metalogo` is mapped to `mark.kernel` ("closest way only"). That package is not a text-mark command. It would need its own way proposal (published, no options). ctan.org/pkg/metalogo says "Written especially for XeLaTeX users" and lists no pdfTeX support. The dtx fallback (49-55) runs only when `metalogo.sty` is absent, and CTAN says TeX Live ships it, so under TeX Live the package is loaded under pdfLaTeX. The Engine line "pdfLaTeX-compatible" therefore rests on dtx:200 (author's statement) only, and "not required" is true only when the file is missing. Engine is not a blocker.
3. `idx.makeidx` for `\CodelineIndex` `\RecordChanges` `\PrintChanges` `\PrintIndex` (dtx:42-44, 58-59) is a stretch; the real mechanism is ydoc's own index and change history plus a makeindex pass. The component "macro documentation" (`macro`/`key`/`environment`, `\DescribeMacro`, `\DescribeKey`, `\Macro`, `\cs`, `\meta`; used 98+64+8 times) has no row of its own, only a vocabulary list. Lib v2 now has `dtx.doc` (doc.sty) which is the nearest way; ydoc itself (ctan.org/pkg/ydoc: "alternative to ltxdoc, doc, and xdoc") is `class.ydoc`. A missing row or proposal, not UNMAPPED.
4. Analyst says "Lib: v1"; `_Lib.md` is now v2 and already lists `pg.standalone-pkg` and `dtx.doc`. The row text writes `pg.standalone-pkg` without `NEW:` yet the Lib changes section proposes it; harmless.
5. Config detail missed: the shipped cfg guards `\PassOptionsToPackage{active,tightpage}{preview}` with `\ifx\@notprerr\PassOptionsToPackage` (dtx:4866-4868). Fixed per document, so reducible; analyst cites the lines correctly but not the guard.
6. Scoping risk: manifest row has `has_sample` False, `main` empty, hints `xelualatex,tikz`. The analyst chose standalone.dtx as the "sample". NOTEMPLATE does not apply (the dtx holds a class and package as DocStrip source and a ydoc manual), but the choice is a judgement.

## Citations checked
About 45 file:line citations compared with the source; 2 definitely wrong:
- `README.txt:3` is cited for the licence; line 3 is blank, the licence line is README.txt:5 (Verdict/Source header).
- `standalone.dtx:250` is cited in the "inline code" row for `|...|` bars; line 250 has none (199 and 347 do; 251 does).
Ambiguous, not counted: in the class-native vocabulary "e.g." list the numbers 254 (blank line) and 546 (no `\MacroArgs`; 548 has it) do not align with the names, but the list is not paired one-to-one.
All other checked lines matched: dtx:35-37, 40-41, 45, 47-55, 118-125, 126-129, 132-137, 140-143, 200, 308-309, 358-361, 704-708, 757-765, 780, 1026-1032, 1041-1045, 1088-1089, 1093/1119/1139/1162 (lstlisting), 1174, 1176, 2160-2163, 2381-2394, 2509-2625, 2561-2679, 2691-2729, 3302-3306, 4020-4023, 4818-4824, 4862, 4874, 4866-4868, 4882-4886, 4895, standalone.ins:6-14; `\changes` count 18; `\autoref` count 24.
