# Skeptic audit: 0094-nostarch (analyst said yes)

Result: not refuted. No real blocker found. Read-only; nothing compiled or run. Paths are in `Source/0094-nostarch/`.

## What the yes rests on
The zip is three files (`main.tex` 106 lines, `references.bib`, `README.md`). The yes depends on one rubric ruling: `nostarch` is a published class that is not bundled, so it is one `class.nostarch` way and its internals are not bespoke (`_Rubric.md` lines 61-63, 150-154). I checked that ruling against the source.
- ctan.org/pkg/nostarch (read 1 of 3) exists: "the official LaTeX style for No Starch Press", v2.4 (2023-07-19), LPPL 1.3, Boris Veytsman, in TeX Live and MiKTeX, ships a class, a hyperref-interface package and an index style. This matches the analyst's header (file lines 11, 16). W1 holds.
- ctan.org/pkg/nshyper (read 2 of 3) is a 404, so `nshyper` is not a standalone CTAN package. It lives inside the nostarch bundle (`README.md:33-34`).

## Searched, nothing found
- `main.tex` and `README.md`: grepped for `\newcommand`, `\def`, `\let`, `\RequirePackage`, `\newenvironment`, `\newcounter`, `xpatch`, `patchcmd`, `tikz`, `shell-escape`, `minted`. No hit in any of the three files. There is no `\@startsection`, `\@maketitle` or `\@makecaption`, and no output routine, TikZ, picture or overlay code. So no BESPOKE and no ART in the zip.
- `main.tex:18-21` loads only `natbib`, `nshyper`, `amsmath` and `\makeindex`. The map covers all of them.
- Nothing outside TeX is called from the zip. The only external steps are `bibtex` and `makeindex -s nostarch.ist` (`README.md:26-29, 44-46`). The `postbibtex.sh` hook (`README.md:27`) is a host recipe and is not in the zip. The analyst's reading is consistent with `Solution/0008-envlab.md:57` and `Solution/0034-moderntimeline.md:36, 63` (makeindex has the status of bibtex), and I checked those two cross-references.
- No text addressed to an AI in any file. `main.tex:9-12` says "not present in this image", which is the starter author's comment about the build host, not an instruction.

## Soft spots (none is a blocker; they are overclaims or unverified)
1. **`nshyper` mapped to `meta.hyperref` (main.tex:19).** `meta.hyperref` in the lib is `hyperref` options and `\hypersetup`. `nshyper` is a different package (the bundle's interface to hyperref, no options in the sample). An emitter that writes `\usepackage{hyperref}` in its place is a substitution and would not reproduce it. It is published (in the nostarch bundle) and one load line, so it stays reducible. The honest way is a class-bundle package of `class.nostarch`, or a `NEW:` line, not `meta.hyperref`. The file does say the source was not read.
2. **Class internals unread, so two rubric checks cannot be made.** `nostarch.cls`, `nshyper.sty` and `nostarch.ist` are not in the zip, so the "unconditional EXTERNAL/package" ruling (`_Rubric.md` 148-150) and the engine cannot be checked from the source. "pdfLaTeX-compatible" rests only on the sample author's comment (`main.tex:9-12`), not on the class. The rubric accepts an unbundled published class, so this does not change the verdict. The "Engine" line should read "not established from the class".
3. **`idx.makeidx` for the class index style (main.tex:104; README.md:26).** The lib line names `makeidx`/`imakeidx`/`index`, not a class `.ist`. The analyst widened it ("the style is a parameter") and says the `\printindex` source is not verified. Honest, but it is a stretch of the lib line.
4. **Input encoding not in the map.** `main.tex:63` has a UTF-8 em dash. Under pdfLaTeX this needs the default utf8 input (kernel) and a font that has the glyph; the class may load `fontenc`. No `font.fontenc-t1` row. It is content, not a blocker.
5. **"Lib: v1".** `_Lib.md` is v2 now, but the solution file (mtime 18:20) predates `_Lib.md` (18:37), so v1 was the snapshot read. Not wrong.

## Citations
50 `file:line` items compared with the source (main.tex lines for class, front matter, chapters, index entries, citations, bibliography; README lines 17-18, 25-29, 31-34, 44-46; `references.bib:1-15`; the "106 lines" count). 0 wrong. Two ranges are loose but right in substance: the quote "under plain pdflatex" spans `main.tex:11-12` (cited 9-13), and `README.md:17-18` carries the "San Francisco" default on line 17 and "overrides it to blank" on line 18.
