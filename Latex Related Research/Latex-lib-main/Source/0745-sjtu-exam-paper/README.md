# SJTU Exam Paper

An unofficial Shanghai Jiao Tong University exam-paper layout: a title
table with class/student-ID/name/course/score fields, an auto-updating
academic-year and semester header (computed from the compile date),
numbered Chinese-style sections, and a conditional answer key compiled
from the same source file.

## Files

- `main.tex` — the exam. Start here (this is a genuine, complete
  Shanghai Jiao Tong University Operating Systems final exam, used as the
  upstream repository's own example).
- `img/simt.png` — a CUDA SIMT diagram referenced by one of the exam
  questions.
- `LICENSE` — upstream MIT licence.

## Building

    xelatex main

This template requires **XeLaTeX** (ctex + real CJK typesetting) — it
will not compile under pdflatex.

## Fonts — patched from upstream

The upstream file hardcodes OS-installed font families (Times New Roman,
Consolas, SimSun, SimHei, KaiTi) loaded via `fontset=none`, which
disables ctex's own font auto-detection. None of those families are
installed here, so this copy is patched to load TeX Gyre Termes, DejaVu
Sans Mono, and the Fandol CJK family (Song/Hei/Kai) by filename instead —
all of which ship with any standard TeX Live install. The patch is
commented in place in `main.tex`.

## Answer key

Set `\showanstrue` (currently `\showansfalse`) near the top of the file
to typeset the answer key into the output, from the same source.

## Licence

MIT, © 2025 Thysrael.
Source: https://github.com/Thysrael/SJTUExamLaTeX
