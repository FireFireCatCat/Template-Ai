# Skeptic audit: 0023-korigamik-assignment

Result: refuted = false (the yes stands under the rubric), with one caveat that cannot be closed from this zip. Read-only; nothing compiled.

## What I searched
- Read `_Rubric.md`, `_Lib.md`, `Solution/0023-korigamik-assignment.md`, then all three zip files in full: `main.tex` (50 lines), `README.md` (25 lines), `references.bib` (6 lines). `ls -la` shows no other or hidden file.
- Grepped the zip for `\usepackage`, `\RequirePackage`, `\newcommand`, `\renewcommand`, `\def`, `\let`, `\if`, `\newenvironment`, counters, `\patchcmd`, `\xpatchcmd`, `\input`, `\include`, `\write18`, `tikz`, `\includegraphics`, `\logoimage`, `\ref`, `\date`: no hit in `main.tex` or `references.bib` apart from the class commands the analyst lists. No preamble package, no macro, no counter, no conditional, no kernel redefinition, no TikZ or picture code, no shell escape or minted, no preprocessor in the zip.
- No text addressed to an AI anywhere in the zip.
- Used 2 of 3 allowed `ctan.org/pkg/korigamik` reads. CTAN confirms: KorigamiK class by Kushagra Lakhwani, v1.0, GPL v3 or newer, "Contained in: TeX Live as korigamik; MiKTeX as korigamik", built on the article class, topics Document template / Article-like / Class, repository github.com/KorigamiK/doc-korigamik, docs README.md and an example PDF, no dependencies listed. So W1 holds and `class.korigamik` is a published class that is not bundled, which the rubric (Class setting paragraph) says is one way with its source unread.
- Looked for a local copy of `korigamik.cls` (no TeX install on this machine, none under the project's `_tools`): none. The class source could not be read by me either.

## Citation check
20 file:line citations compared with the source, 0 wrong. Checked: README.md:7 (pdflatex), README.md:8 (not bundled), README.md:12-14, README.md:18-20 (`\logoimage`, placeholder), README.md:22-24 (`\titlelabel`, `\header`, `\bottomnote`), README.md:25 (plain bibtex), main.tex:3-8, main.tex:17, main.tex:19-20, main.tex:21-27 (each command on the line the file gives), main.tex:31, main.tex:33,36,40,44 (sections), main.tex:37,41 (labels), main.tex:34 (`\cite`), main.tex:47-48, references.bib:1-6, and the stated line counts 50 / 6 / 25. "No `\ref` in the sample" and "no abstract, toc, appendix" are also true.

## Missed blockers
None that I can name with a kind and a location. Nothing in the zip's own files is BESPOKE, ART, UNMAPPED or EXTERNAL.

## Caveat, not a blocker I can prove
The whole look is in `korigamik.cls`, which the analyst did not read and I could not read. Whether it loads a package that needs a tool outside TeX (the rubric's "unconditional load" ruling), or draws the boxed title and corner label with TikZ, is unknown. The rubric still makes the published unbundled class one way, so I do not count it, but the yes is only as good as that rule. If the owner wants class internals read for unbundled classes, this zip is one to re-open (fetch `macros/latex/contrib/korigamik/korigamik.cls`).

## Overclaims in the file (wording, none changes the verdict)
- Verdict line quotes "based on the article class" as if verbatim from CTAN; CTAN's text says the class builds on / is built on the article class. The same CTAN text also says the class makes "other minor adjustments", which weakens "kernel look as the class falls back to article sectioning" (Solution file, `head.kernel` row, citing README.md:14). That row, and "the whole look is the published class", are inferences from README.md:12-14 and main.tex:12-16, not from class source.
- `front.maketitle` row (main.tex:19-20) says title and author are "kernel fields read by the class's `\maketitle`". main.tex:15 and README.md:13 say the class has its own `\maketitle`, so reading `\title` and `\author` is assumed, not seen. The `\maketitle` itself is correctly under `front.class-native`.
- No `\date` row: the class prints a date (README.md:24, "under the date") and the sample sets none, so it is the default date. Cosmetic.
- README.md:9-10 and main.tex:9-10 claim the licence was "verified directly in the shipped korigamik.cls header", but the zip ships no class, so the licence in the file's Source line rests on CTAN, not on those lines.
