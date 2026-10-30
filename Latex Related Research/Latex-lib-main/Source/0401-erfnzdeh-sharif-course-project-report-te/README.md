# Course Project Report Template (Sharif / TexReady)

![language](https://img.shields.io/badge/language-LaTeX-008080?logo=latex&logoColor=white) ![engine](https://img.shields.io/badge/engine-XePersian-008080) ![TeX Live](https://img.shields.io/badge/TeX_Live-2025+-blue)

The generic LaTeX template for a **course project report**, taken from
[latex.sharif.edu](https://latex.sharif.edu/). It was created by the
**TexReady Group** for Computer Science students and was originally published
on TexReady. It is built on **XeLaTeX + XePersian**.

I couldn't compile it locally on a current TeX Live, so this repository keeps
the original template (first commit) and the fixes that make it build and
render correctly again. The problems and their fixes are documented below.

> **Compile with XeLaTeX, not pdfLaTeX** (it is a XePersian template).
>
> ```bash
> latexmk -xelatex Seminar.tex
> # or manually:
> xelatex Seminar.tex && bibtex Seminar && xelatex Seminar.tex && xelatex Seminar.tex
> ```

The template ships with everything it needs (fonts under `styles/fonts/`,
figures under `figs/`), so it builds out of the box on a current TeX Live
(2025/2026) installation.

---

## Why it didn't compile, and how it was fixed

The template was written for an older TeX Live and accumulated a few latent
bugs. On a current distribution it failed to produce any output, and once it did
compile, the Persian text was shaped incorrectly. Problems 1–5 are build
failures; problems 6–8 report nothing at all — two bugs in the bundled font
files that give a wrong-looking PDF and an unsearchable one, and a localization
rule that turns the decimal point in math into something that reads as a slash.

### 1. Fatal — obsolete `xepersian` option (the main blocker)

`styles/common.tex` loaded:

```latex
\usepackage[localise=on,extrafootnotefeatures]{xepersian}
```

In **xepersian v26 (2026)** the option was renamed from the British spelling
`localise` to the American `localize`. The unknown option was forwarded to the
`bidi` package, producing a hard stop:

```
! LaTeX Error: Unknown option 'localise' for package bidi.
No pages of output.
```

**Fix:** `localise=on` → `localize=on`.

### 2. Fatal — fonts referenced by system name instead of the bundled files

The active font commands were:

```latex
\settextfont[Scale=1.166666666666666]{XBNiloofar}
\setdigitfont{Yas}
```

These look up fonts **installed on the machine**. Anyone without `XB Niloofar`
/ `Yas` installed got:

```
! I can't find file `XBNiloofar'.
! Emergency stop.
```

The fonts were actually shipped in `styles/fonts/` but never wired up.

**Fix:** load the bundled fonts via `Path`/`Extension` so no system install is
required:

```latex
\settextfont[
  Scale=1.166666666666666,
  Extension=.ttf,
  Path=styles/fonts/,
  BoldFont=XB NiloofarBd,
  ItalicFont=XB NiloofarIt,
  BoldItalicFont=XB NiloofarBdIt
]{XB Niloofar}
```

(and the same for `\setdigitfont`).

### 3. Document-class mismatch (`article` vs. chapter-based styles)

`Seminar.tex` uses `\documentclass{article}` and the body uses `\section`, but
the styles assumed a chapter-based class. This caused errors such as:

```
! LaTeX Error: No counter 'chapter' defined.
! LaTeX Error: Command \bibname undefined.
! Undefined control sequence.   % \فصل (=\chapter) in the appendix
```

**Fix (kept the `article` class, aligned everything to sections):**

- `styles/common.tex`: theorem counters `[chapter]` → `[section]`
- `styles/common.tex`: `\renewcommand{\bibname}` → `\renewcommand{\refname}`
- `chapters/appendix.tex`: `\فصل` (`\chapter`) → `\قسمت` (`\section`)
- `bibs/bibs.tex`: `\addcontentsline{toc}{chapter}` → `{section}`

### 4. Stray right-to-left control characters

Every line of `chapters/context.tex` (and `chapters/appendix.tex`) began with
an invisible **`U+202B` RIGHT-TO-LEFT EMBEDDING** character. XeTeX tried to
typeset it (`Missing character: There is no ‫ ...`), which injected text before
the first `\item` and inside tables, breaking list and table environments:

```
! LaTeX Error: Something's wrong--perhaps a missing \item.
! Misplaced \noalign.
```

XePersian already manages bidirectional text, so these marks were pure noise.

**Fix:** stripped all `U+202B` characters from the content files.

### 5. Undefined macro `\EnglishCourseTitle`

`front/template/title.tex` uses `\EnglishCourseTitle`, but `front/info.tex`
never defined it (`! Undefined control sequence`).

**Fix:** added a definition in `front/info.tex` (edit it with your own title):

```latex
\newcommand{\EnglishCourseTitle}
{Course Project Report Title}
```

### 6. Silent — Persian text typeset as disconnected letters

Once the document compiled, it still produced garbage: every Persian letter came
out in its **isolated** form, so `دانشگاه صنعتی شریف` rendered roughly as
`دائٹوگاه صئٹوعتی شریف`. A handful of letters were also swapped for unrelated
glyphs — `ن` became `ۈ`. Nothing was reported in the log; the PDF just looked
wrong.

The cause was the bundled font file, not the document. The XB fonts ship **two**
layout systems:

- OpenType `GSUB`/`GPOS`, with full `isol`/`init`/`medi`/`fina`/`rlig` joining
  under the `arab` script
- Apple's AAT `morx`/`feat`/`prop`/`just`

HarfBuzz, which XeTeX has used for shaping since 2017, applies `morx` *instead
of* `GSUB` whenever a font provides it, so the AAT tables decide how the text is
shaped. And in the copy this template shipped they were **stale**. That copy
(internal name `XB Niloofar Sharif`) is a repackaging of the original
`XB Niloofar` with a rebuilt glyph inventory — 903 glyphs instead of 923, in a
different order — but its AAT tables were carried over byte for byte:

| | original `XB Niloofar` | repackaged `XB Niloofar Sharif` |
|---|---|---|
| glyphs | 923 | 903 |
| glyph 437 | `uniFEDC` | `u0646` |
| `morx` table | 74772 B | 74772 B, *identical bytes* |

`morx` addresses glyphs by numeric glyph ID, so every rule in that copied table
pointed at the wrong glyph. Joining collapsed and a few letters were swapped
outright. The OpenType tables were regenerated alongside the new glyph set and
are perfectly fine — they just never got a chance to run. This is also why the
template rendered correctly on an older TeX Live, whose ICU layout engine used
`GSUB` and ignored `morx`.

It is reproducible outside TeX, which is the quickest way to see it:

```bash
hb-shape "styles/fonts/XB Niloofar.ttf" "دانشگاه"
# broken copy: [...|u0634=3+1951|u06C8.liga=2+1375|...]  isolated, noon mangled
# good copy:   [...|uniFEB8=3+1260|uniFEE7=2+560|...]    medial sheen, initial noon
```

**Fix:** replace the repackaged font with the intact original. The four
`XB Niloofar` files bundled here now come from
[zarrabi/thesis-template](https://github.com/zarrabi/thesis-template), the
thesis template this one descends from, whose copies never had the problem.
`XB Kayhan Pook` was unaffected and is unchanged.

(If you would rather keep the repackaged variant — it is what latex.sharif.edu
distributes — deleting its `morx`, `feat`, `prop` and `just` tables works too,
since that leaves the correct OpenType tables as the only option.)

### 7. Silent — letters missing when the PDF is copied or searched

With the text finally rendering correctly, the PDF still had a subtly broken
text layer: copying a paragraph out of it, or searching it, silently dropped
about 3% of the characters — including some of the most common letters in
Persian (`ی`, `ه`, `گ`, `ک`).

The XB fonts name their contextual variants with an underscore, as in
`uniFB95_alt`. Under the Adobe glyph-naming convention an underscore separates
the *components of a ligature*, so a reader parses that as "`uniFB95` followed
by a glyph named `alt`", fails to resolve `alt`, and discards the whole name.
Those glyphs then get no `ToUnicode` entry and the characters they carry cannot
be recovered from the PDF. A *variant* is meant to use a period instead —
`uniFB95.alt` — where everything after the first period is ignored when
deriving the character.

**Fix:** `tools/normalize-glyph-names.py` rewrites the underscore form to the
period form, while leaving real ligature names such as
`afii57415_uniFEDF_uniFED2` alone:

```bash
python3 tools/normalize-glyph-names.py     # needs fontTools
```

Only names change — outlines, metrics, glyph order and glyph IDs are all
preserved, so the layout tables stay valid, and the script is idempotent. It
brings the recoverable text in this document back from 13119 to 13530
characters.

### 8. Silent — the decimal point in math looks like a slash

`$R = 47.6$` came out as `۴۷/۶`. The character typed is a period, but what is
printed reads as a *ممیز*.

Two things combine here. `\setdigitfont` sets the **math** digit font as well as
the text one, and the default `mathdigits=automatic` therefore makes every
`$...$` in a Persian document switch to Persian digits and replace the decimal
point with **U+066B ARABIC DECIMAL SEPARATOR** (`٫`). The substitution is driven
by a lookahead — `.` is made active with `\mathcode`.="8000` and swapped for
`\MathDecimalSeparator` whenever the next token is a digit, `\dot` or
`\overline`. That much is deliberate localization.

The second half is the font. `XB Niloofar` draws U+066B as a full-height slanted
stroke rather than a raised comma, so the localized separator is visually a
slash:

| glyph | advance | bounding box (units/em = 2048) |
|---|---|---|
| `period` | 565 | (100, 82) – (315, 297) |
| `uni066B` | 517 | (−105, −347) – (517, 975) |
| `slash` | 614 | (65, −288) – (553, 1399) |

**Fix:** keep the Persian digits but typeset the separator as an ordinary
period. `\MathDecimalSeparator` is a plain `\def` in `unicode-persianmath.sty`,
so it has to be redefined at the `\def` level (`styles/common.tex`):

```latex
\makeatletter
\def\MathDecimalSeparator{\decimalseparator@point}
\makeatother
```

`\decimalseparator@point` is xepersian's own `\mathchardef` for the default
period, so this restores exactly the stock behaviour. It applies everywhere —
inline and display math, fractions, superscripts and subscripts — survives
`\shariffont` (which calls `\setdigitfont` again), and leaves `\SepMark{-}`
section numbering and cross-references alone.

Two alternatives, if you would rather not patch the styles:

- per number, brace the point so the lookahead does not fire: `$R = 47{.}6$`
- for Latin digits in math throughout (`47.6` rather than `۴۷.۶`), load
  xepersian with `mathdigits=default`; `\persiandecimalseparator` is then never
  defined and the point is left alone as a side effect

**Unrelated but worth knowing:** a decimal written in ordinary text rather than
in math has its two halves swapped, with nothing reported in the log — `47.6`
prints as `۶.۴۷` and `3.14` as `۱۴.۳`. `bidi` puts `.` and `-` in a separator
character class and injects a U+200F RIGHT-TO-LEFT MARK before a following
digit, which is what makes Persian `۲-۳` section numbering come out in the right
order but reverses genuine decimals. Write them as `$47.6$` or `\lr{47.6}`.

---

## Result

After the fixes, the template builds cleanly:

- `latexmk -xelatex Seminar.tex` exits 0 with no errors
- `bibtex` resolves all references, and the final pass reports no undefined
  references or citations
- a complete 19-page PDF is produced, with Persian text correctly joined and
  fully recoverable by copy, search and screen readers

Two smaller things were fixed along the way, both backported from the upstream
thesis template:

- `\labelitemi` was defined as `{$\small\bullet$}`. `\small` is not valid in
  math mode, which produced 66 warnings per build; it is now
  `{{\small\textbullet}}`.
- The `xepersian` option spelling is no longer hardcoded — see below.

---

## Options

Both are set in `Seminar.tex`.

**Older xepersian.** The option was spelled `localise` before xepersian v26 and
`localize` from v26 on. The template defaults to the new spelling; uncomment one
line to build against an older installation:

```latex
\newif\ifnewXePer \newXePertrue
%\newXePerfalse  % برای استفاده از نسخه قدیمی زی‌پرشین این خط را فعال کنید
```

**Sharif typeface.** The official Sharif 1.3 font is bundled as an alternative
to XB Niloofar. Uncomment the line after `\begin{document}`:

```latex
%\shariffont
```

## Project layout

```
Seminar.tex            Main file (\input/\include of the parts below)
front/info.tex         Fill in your names, course, professor, title, etc.
front/template/        Title page, logo, "besmellah"
chapters/context.tex   Body of the report
chapters/appendix.tex  Appendix
bibs/                  Bibliography (.bib) and bibs.tex
figs/                  Figures
styles/                common.tex, custom.tex, fonts, packages, alg-fa.tex
tools/                 Font maintenance script
```

## Getting started

1. Edit `front/info.tex` (Persian fields) and `\EnglishCourseTitle`.
2. Write your content in `chapters/context.tex`.
3. Add references to `bibs/full.bib` / `bibs/refs.bib`.
4. Build with `latexmk -xelatex Seminar.tex`.
