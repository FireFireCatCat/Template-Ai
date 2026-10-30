yes

# 0526-a0poster: a0poster (large-format poster class, CTAN)

- Unverified: read from the source, not compiled.
- Source: Source/0526-a0poster/ (origin: https://mirrors.ctan.org/macros/latex/contrib/a0poster.zip; licence: lppl1.2, LPPL 1.2 in a0poster.cls:6-8)
- Kind: poster
- Lib: v4
- Engine: pdfLaTeX-compatible (all look settings are plain LaTeX lengths, NFSS and font-size commands; the dvips-only `\special` hints at a0poster.cls:154,185-206 and the PostScript header at :141-152 are a driver aid, not part of the look; the CTAN page names only dvips; pdfTeX behaviour of the specials was not read from any source here)
- Look carried by: class (a0poster.cls + a0size.sty, the published CTAN package, define the template; the sample manual a0.tex is plain `article` plus three preamble lines)
- Class origin: ctan
- Main file: a0.tex (other samples: a0_eng.tex, the same manual in English; a0.dvi, a0.pdf, a0_eng.dvi, a0_eng.pdf are build outputs, not read)
- Read: main yes, zip-local classes and styles all (a0poster.cls 210 lines, a0size.sty 252 lines, a0.tex 231, a0_eng.tex 222)

## Verdict
The zip is the CTAN `a0poster` package: a class (`a0poster.cls`, built on `article`) and one style (`a0size.sty`), both published (CTAN, LPPL 1.2), plus a German and an English manual. Neither manual loads `a0poster`: each is a plain `article` document with `german`, `a4` and a `\familydefault` change (a0.tex:15-17), whose parts all map to existing ways. An emitter writes `\documentclass[portrait,a0b,posterdraft]{a0poster}` (the manual's own example, a0.tex:124) and no zip-local macro logic is copied, so every bespoke-looking construct sits inside a published class. The manual says the package needs `dvips` (a0.tex:65, a0_eng.tex:63); I do not count that as `EXTERNAL`, because dvips only converts the DVI to PostScript at the right size and no tool feeds values into or runs during the compile. If a reviewer reads the dvips line as `EXTERNAL/class`, the verdict flips to `no`; that is the one judgement call.

## Blockers
none

## Class setting
- Class: `class.a0poster` options: paper `a0b` (default) `a0` `a1` `a2` `a3` (a0poster.cls:35-70), orientation `landscape` (default) `portrait` (:71-76), output `final` (default) `posterdraft` and obsolete `draft` (:77-85), default list `landscape,a0b,final` (:87), unknown options only warn (:86); loads `article` (:20). The sample manual itself uses `class.article` options `12pt` (a0.tex:15, a0_eng.tex:14).
- Class-native vocabulary used: the manual's sample uses none (it loads `article`). The class's own vocabulary, documented at a0.tex:124-145: the option list above and the thirteen size commands `\tiny` ... `\Huge` (redefined, a0poster.cls:158-167) and the new `\veryHuge` `\VeryHuge` `\VERYHuge` (:168-170), 12pt to 107pt. The class supports neither colour nor graphics (a0.tex:169); `pstricks` and `epsf` appear only as verbatim text (a0.tex:125, 177-180).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class (template) | a0poster.cls:18-20; a0.tex:124 | `class.a0poster` | options a0b/a0/a1/a2/a3, portrait/landscape, posterdraft/final |
| class (sample manual) | a0.tex:15; a0_eng.tex:14 | `class.article` | 12pt |
| sample type size | a0.tex:15 | `page.class-options` | 12pt |
| paper size and text block | a0poster.cls:90-120 | `page.a0poster` | per option, paperwidth x paperheight and textwidth x textheight, e.g. a0b 119cm x 87cm, text 114cm x 87cm (:91-94); a0 118.82cm x 83.96cm (:96-99); a3 41.98cm x 29.7cm (:111-114) |
| orientation | a0poster.cls:123-132 | `page.a0poster` | portrait swaps paper and text width/height |
| PostScript header and driver hints | a0poster.cls:141-154,185-206 | `page.a0poster` | writes `a0header.ps` (PageSize per option, scale 0.2 or 0.3 or 0.4 or 0.6 for `posterdraft`), `\special{header=}` and `\special{papersize=}`; class-internal, driven by the size options |
| head and margin lengths | a0poster.cls:136-139 | `page.setlength` | headheight 0cm, headsep 0cm, topmargin 0cm, oddsidemargin 0cm |
| sample page size and margins | a0.tex:16; a0_eng.tex:15 | `page.vmargin` | `a4` (legacy A4 package, in CTAN `ntgclass`), no options |
| font sizes | a0poster.cls:158-170 | `font.size-commands` | `\fontsize{12}{14}` (tiny) to `\fontsize{107}{134}` (VERYHuge), 13 steps |
| font shapes at large sizes | a0size.sty:20-223 | `font.nfss` | `\DeclareFontShape` for OT1 cmr/cmss/cmtt, OML cmm, OMS cmsy, OMX cmex, U cmr; sizes up to 107pt map to cmr17, cmss17, cmtt12, cmbx12 and similar files (e.g. :24-25, :88, :115) |
| cmex scaling, `\big` family | a0size.sty:225-240 | `font.exscale` | a copy of exscale (stated :225-226): symbol font `largesymbols`, `\big` `\Big` `\bigg` `\Bigg` |
| math sizes | a0size.sty:242-250 | `font.size-commands` | `\DeclareMathSizes` from 24.88 to 107pt |
| sample typeface | a0.tex:17; a0_eng.tex:16 | `font.family-default` | `\familydefault` = `\sfdefault` |
| skip and display lengths | a0poster.cls:172-181 | `sp.lengths` | smallskip 6pt, medskip 12pt, bigskip 24pt, abovecaptionskip 25pt, belowcaptionskip 0pt, display skips (25pt plus 6pt minus 15pt, ...) |
| page style | a0poster.cls:206; a0.tex:20 | `hf.pagestyle-kernel` | `\pagestyle{empty}` in the class; `\thispagestyle{empty}` in the sample |
| paragraph indent | a0.tex:19; a0_eng.tex:18 | `sp.lengths` | `\parindent=0pt` |
| language support | a0.tex:16,101 | `lang.babel` | the `german` package (CTAN, 2.5e, LPPL 1), commands `\glqq` `\grqq`; `german` stands in for babel here |
| title block | a0.tex:21-29; a0_eng.tex:20-28 | `sp.ragged` | `center` environment with hand-set lines, no `\maketitle` |
| title block spacing | a0.tex:22,24,31 | `sp.manual-space` | `\\[0.5cm]`, `\vspace{1cm}`, `\vspace*{1cm}` |
| title and heading type | a0.tex:22,35,52 | `mark.kernel` | `\Large`, `{\bfseries\large ...}` as hand-set run-in headings (no `\section`), `\ttfamily`, `\slshape` |
| heading and block spacing | a0.tex:36,50 | `sp.manual-space` | `\bigskip` between hand-set blocks |
| size switches in body | a0.tex:24,33 | `font.size-commands` | `\small`, `\normalsize`, `\large` |
| footnotes | a0.tex:27-28,154-161; a0_eng.tex:26-27,143-150 | `fn.kernel` | `\footnote` in a title block and in body text |
| tables | a0.tex:72-77,98-117; a0_eng.tex:70-75,94-109 | `tbl.tabular` | `tabular` with `{lp{0.75\textwidth}}` and `{lp{0.8\textwidth}}` |
| verbatim code | a0.tex:123-127,131-145,177-180 | `code.verbatim` | `verbatim` environment (option lists, size table, colour example) |
| lists | a0.tex:206-209,215-219,225-229 | `list.kernel` | `itemize` |
| page break | a0.tex:212 | `pg.break` | `\newpage` |
| inline maths | a0.tex:41-43 | `math.kernel` | `$\backslash$` only |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `a0poster.cls` and `a0size.sty` as a whole | a0poster.cls:18-208; a0size.sty:18-252 | not bespoke | published on CTAN and in TeX Live (ctan.org/pkg/a0poster, LPPL 1.2); one way, `class.a0poster` with `page.a0poster` options; the emitter writes one `\documentclass` line |
| size flags `\ifanullb` ... `\ifposterdraft`, counters `\xkoord` `\yscale` | a0poster.cls:22-33 | n/a (inside a published class) | would reduce, if the class were zip-local, to the option choosing the lengths and header numbers once at emit time |
| `a0header.ps` writer (`\catcode`, `\newwrite`, `\write`) | a0poster.cls:141-152 | n/a (inside a published class) | a dvips page-size aid; no typesetting effect on the page; `page.a0poster` |
| zip-local macros in the samples | a0.tex, a0_eng.tex | none present | the two manuals define no `\newcommand`, `\def`, environment or counter |

## Content-opaque
none

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
