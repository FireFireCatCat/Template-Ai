# Audit (skeptic): 0075-questionnaire

Result: refuted = false. The `yes` stands. Nothing here was compiled; read-only.

## What I searched
- Whole zip: 2 files only (main.tex 44 lines, README.md 11 lines; `ls -laR`, no hidden files). Manifest row 76 agrees (2 files, main=main.tex, docclass=article, local_class empty).
- main.tex is pure ASCII (no hidden characters). grep for `\def`, `\let`, `\renewcommand`, `\catcode`, `\input`, `\include`, `write18`, `tikz`, `\pgf`, `\RequirePackage`: only hit is `\newcommand{\boxoption}` (main.tex:15). No `\@startsection`, `\@maketitle`, `\@makecaption`, no `\xpatchcmd`/`\patchcmd`, no counters, no conditionals, no output routine, no picture/TikZ/PSTricks/overlay, no minted/shell escape/preprocessor.
- Preamble packages (main.tex:2-9): inputenc, fontenc, geometry, xcolor, enumitem, amssymb, tabularx, fancyhdr. All eight are in the component map (font.fontenc-t1, page.geometry, color.xcolor, list.enumitem, math.amssymb, tbl.tabularx, hf.fancyhdr). None missing. All are CTAN/TeX Live packages (W1).
- README.md: plain description plus an Overleaf "research lead" link; no text addressed to an AI.

## Citations checked: 22, wrong: 0
main.tex:1, 2-3, 4, 5, 6, 7, 8, 9-14, 14, 15, 17-21, 18, 19, 20, 22-24, 26+40, 27-37, 28-35, 38, 41-43; README.md:9-10 and 1-11; manifest licence string. All match the actual lines.
Only imprecisions (not wrong): the checkbox row cites main.tex:29, 31, 34 but `\boxoption` also appears on lines 32 and 35; the header row cites 9-14 where line 9 is the `\usepackage` and the settings are 10-14.

## Overclaims (do not change the verdict)
1. The `\noindent` row (analyst file line 41) maps to `sp.lengths`, whose lib text is raw `\parindent`/`\parskip`/`\itemsep`/`\topsep` (_Lib.md:110). `\noindent` is a kernel paragraph switch, not a length. The file itself admits "no way of its own in the lib". It is a kernel command with no parameters and no program (W1-W4 would pass), so this is a lib wording gap, not UNMAPPED/BESPOKE.
2. The kernel `center` environment (main.tex:17-21) is mapped to `sp.ragged`, whose lib text lists `\raggedright`/`\centering` (_Lib.md:112), not the `center` environment (which also adds list-style vertical space). The analyst flags this judgement openly (analyst file line 68). Still no program involved.
3. `\bfseries`, `\quad`, `\qquad`, `\ ` are mapped to `mark.kernel` and `sp.manual-space`, whose lib text lists the sibling commands (`\textbf`..., `\hspace`...). Same kind of loose wording; all are kernel commands.
4. Header says `Lib: v1`; _Lib.md now says v2. The v2 additions are irrelevant to this zip, so no effect.

## Missed blockers
none found. No BESPOKE, ART, UNMAPPED, EXTERNAL or NOTEMPLATE under the rubric. `\boxoption` is a zero-argument alias for `\(\square\)` (amssymb), reducible as the analyst says. The `\hrule` and `\rule` lines are explicitly covered by `sp.rule` (_Lib.md:116) and are answer-space, not template artwork.
