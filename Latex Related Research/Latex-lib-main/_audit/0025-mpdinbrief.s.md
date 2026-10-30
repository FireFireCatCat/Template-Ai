# Skeptic audit: 0025-mpdinbrief (analyst said yes)

Result: not refuted. No real blocker found. Read-only; nothing compiled or run.
Paths below are in `Source/0025-mpdinbrief/mpdinbrief.dtx` unless stated.

## What the yes rests on
The yes depends on one rubric ruling: `mpdinbrief` is a published class, so it is one `class.mpdinbrief` way and its box-and-glue code is not bespoke. I checked that ruling.
- ctan.org/pkg/mpdinbrief (read 1 of 3) exists: "mpdinbrief, an enhanced version of dinbrief", v1.66, Markus Pilzecker, licence "Do Not Sell Except by Arrangement". The manifest origin is the CTAN zip (`_Manifest.tsv` row 0025). So W1 holds, and the analyst's CTAN claims match.
- ctan.org/pkg/german (read 2 of 3) exists: v2.5e, Bernd Raichle, LPPL 1. The analyst's claim about `german.sty` is right.
- Without that ruling the answer would be no, as the analyst says. The class is hand-written 1990s box-and-glue code. It has a state counter (4178), a replaced `\document`/`\enddocument` (4633-4756), a `\ifka@db@lastpage` flag (4217, 4242, 5020) and fold marks and window rules drawn from `\hrule` (3107-3132, 3188-3274). I found no blocker outside the class.

## Searched, nothing found
- Class region 1644-5988: grepped for `\write18`, `\special`, `\output`, `shipout`, `\halign`, `\leaders`, `\RequirePackage`, `\LoadClass`, `\input`. Only the class's own `.lbl`/`.aux` files are written (4670-4675, 4747-4752), and that is TeX-only. No shell escape, no preprocessor, no packages loaded (2284). `.ins` needs only `tex mpdinbrief.ins` (docstrip), so not EXTERNAL.
- Sample preamble (mpbrfkopf 6013-6061, mpexample 6066-6157, isotoday 6673-6681): only `german` (6075) and `epsfig` (6017) are loaded. No TikZ, PSTricks, `picture` or overlay. The letterhead is `\vbox`/`\hbox`/`\raise` plus an included image, so no ART.
- `lego.eps` is a bitmap inside EPS (71x61 bp, scanline data). I judge it content. Under pdfLaTeX it needs conversion, which the analyst noted as an asset issue.
- `\ISOtoday` (6674-6680) is a `\loop` that prints the date from `\year`, `\month`, `\day`. It is reducible to `front.datetime` and the date is content.
- The test body (6163-6314) uses only lists, verse, quotation, quote, equation and `\verb`. All are covered. "Testing tabular/tabbing" print only headings (6299-6301).

## Soft spots (none is a blocker; the analyst file should be corrected)
1. **Wrong reduction, receiver address glue (6113, 6118; map row "receiver vertical placement").** The file says 3/5 above and 2/5 below and reduces to `\vspace*{\stretch{3}}`/`{2}`.
   - That repeats the source comments. The actual glue is 4 `\vss` above (6113) and 2 below (6118).
   - The class sets the address list in a natural-height `\vbox` (3223-3235), where `\vss` and `\stretch` are 0pt. Only the `\null` blank lines take space, so the proposed reduction would drop the offset.
   - A fixed-length `\vspace` is the safe reduction; the class allows `\vspace` in the address (4198-4201, 4224). The row stays reducible.
2. **`ltr.opening` is over-assigned.** About a dozen rows give class-native commands to `ltr.opening`: fold marks (3107-3132), window (3188-3274), reference line (5672-5747), `\bottomtext` (4580-4604), `\enabledraftstandard` and `\backaddress`. The lib line limits that way to kernel/KOMA/`newlfm` letter commands. These rows are carried by `class.mpdinbrief` alone, which the Verdict says honestly. The table makes the lib look like it covers more than it does.
3. **`font.family-default` for `\fontfamily{cmss}\selectfont` (6090-6091).** Lib v2 has `font.nfss`, which names `\fontfamily`. Also, `\normalfont` in the running head (5018) would stay Roman, which a changed `\familydefault` would not reproduce. The file's header says "Lib: v1" but the lib is v2.
4. **`lang.babel` for `german.sty` (6075, 6692).** `german` is itself a CTAN package, and the zip loads it. Emitting babel `ngerman` is a substitution by the emitter, not the same package. That is acceptable but should be said.
5. **Samples not covered.**
   - The `driver` guard 6690-6732 (`ltxdoc`, `german`, `\DocInput`, `\PrintChanges`, `\PrintIndex`) is not listed under "Other samples". It maps to `class.ltxdoc` and `dtx.doc`.
   - The user-guide preamble macros at 460-498 (`decl`, `\cmd`, `\cs`, `\m`, redefined `\arg`, `\germanTeX`) are outside the range the analyst read (511-955) and are not in the Bespoke table. `decl` matches `class.ltxguide`.
   - `dbold` (6475-6665) loads class `dinbrief`, which is not bundled and was only skimmed.
6. **Engine claim.** "pdfLaTeX-compatible" rests on 1995-97 dual-mode code that rebuilds the kernel's `\document` and `\enddocument` (4633-4756) and uses LaTeX 2.09 `\@setsize` size tables (2433-2549). The analyst says it is untested, so this is honest. It is not established.

## Citations
About 90 `file:line` items compared with the source: the sample lines, the class vocabulary lines, option and page-geometry lines, page styles, the `.ins` lines, and the guard ranges. 0 wrong. Two ranges end loosely (4160 is a blank comment line; `mpdinbrief.ins:125-141` stops one line before the end of the notice at 142). Neither is wrong in substance.

No text addressed to an AI found.
