# Skeptic audit: 0059-ftc-notebook (analyst said yes)

Result: NOT refuted. No missed blocker found. Unverified: read from the source, nothing compiled or run.

## What I read and searched
- Rubric, lib (v2), Solution/0059-ftc-notebook.md, then the whole zip text: ftc-notebook.sty (1017 lines, all), example-notebook.tex, src/aug19.tex, src/story.tex, src/bio.tex, ftc-notebook.tex (974 lines, all), README.md, newmeeting.sh. Images were only checked with `file`; the PDFs were not read.
- Grepped the sty for kernel/low-level patterns (`\def \gdef \edef \let \catcode \patchcmd \xpatchcmd \AtBeginDocument \@startsection \@maketitle \@makecaption \@seccntformat \write \immediate \shipout \halign \directlua`): none. Only conditionals are `\ifFTC@Grid` (sty:473) and `\ifFTC@Blue`/`\ifFTC@Orange` (sty:953, 964), all driven by package options fixed per document, plus `\ifnum` count checks (sty:283, 299). expl3 appears once (sty:330-337).
- Grepped everything for `write18 shell-escape minted pygmentize makeindex bibtex biber`: no hits in the sty, the main sample or src/*.tex. The manual only has `\PrintChanges \PrintIndex` (ftc-notebook.tex:968-971).
- Body/example files define no macros (`\newcommand \def \let \newenvironment \newcounter`: none). The only `\usepackage` is example-notebook.tex:3. No tikz, picture or pstricks in the sample files; the only drawn thing is the `\Callout` argument at src/aug19.tex:104, inside a figure float (content).
- No text addressed to an AI anywhere in the zip.

## W1 check (the one ruling the yes depends on)
- _Manifest.tsv:60 gives source `ctan`, url https://mirrors.ctan.org/macros/latex/contrib/ftc-notebook.zip, licence lppl1.3, 20 files (matches the 20 files here).
- One read of https://ctan.org/pkg/ftc-notebook: on CTAN, version 1.1, 2019-02-16, LPPL 1.3, in TeX Live. The sty header says 2019/02/16 (ftc-notebook.sty:5, 11) and LPPL 1.3 (sty:996-1004). So the sty is the published package, and the rubric's W1 text ("zip is an official release" / same package on CTAN) is met.
- Under that ruling the emitter writes `\usepackage[Num=..,Name=..]{ftc-notebook}` plus the package's own body environments; no zip-local macro logic is copied. This matches the rubric's own pilot ruling that a look carried entirely by a published class/package, with the zip adding only options and content, reaches yes.

## Items that would be blockers only if the sty were NOT accepted as published
These are the analyst's "latent" items and are real, I confirmed them, but they are not blockers under the W1 ruling:
- BESPOKE/class, latent: arrayjobx title/label hand-off from `\TaskInfo` to `\Task` (sty:185-186, 232-234, 311-312, 351-353, 372-373), `\@TaskDate` footer array (sty:240, 927), `\@TypeColor` ifthen (sty:317-327), expl3 `\IfNoValueOrEmptyTF` (sty:330-337), `\PackageError` count check (sty:283-285).
- ART-like, latent: the cover is a page-long colour band made from a `tabular` with a `\columncolor` column and 31 hard-coded empty `& \\` rows (sty:839-873) under absolutely placed `textblock`s at fixed coordinates (sty:828-837, 877-881). It uses no drawing primitive, but it is template-identity decoration with no declarative parameter. Fine inside a published package; would be ART if the package were not a way.
- Soft spot, same as the analyst's own caveat: W3. `notebook.ftc` realises every component at once (cover, lists, header/footer, tables, figures, headings), so the component map's real content is "one package". The lib already carries the precedent of whole-document doc-kind ways (`inv.simpleinvoice`, `cal.kalender`, `label.flabels`) and v2 accepted `notebook.ftc`, so I do not count this as a missed blocker.

## EXTERNAL?
- newmeeting.sh (bash, writes a pre-filled src/<name>.tex skeleton with a hard-coded member list, newmeeting.sh:13-78) is an authoring aid: the sample .tex files ship ready and example-notebook.tex does not call it. I agree with the analyst that it is not `EXTERNAL`; it is the closest thing to a borderline item.
- No package the sty loads needs a tool outside TeX (checked all `\RequirePackage` lines, sty:18-123, 176).

## Packages and ways
- All 36 packages the sty loads (sty:18-123, 176) are in the component map or the "no lib component" row; none missing. Loose fits, not wrong enough to matter: `hypdoc` mapped to `meta.hyperref` (manual only; hypdoc is the doc-package layer of hyperref, nearer `dtx.doc`); `inputenx` under `font.fontenc-t1`; `anyfontsize` under `font.size-commands`.
- Manual-only omissions (secondary sample, not decisive): `\lstnewenvironment{dtxverblisting}` (ftc-notebook.tex:14-21) is a zip-local environment missing from the Bespoke table (reducible to `code.listings` keys); `\PrintChanges`/`\PrintIndex` (968-971) imply a makeindex run (`idx.makeidx`/`dtx.doc`), not recorded.

## Citation check
Compared 38 file:line citations (or groups) with the source; 35 match, 3 do not:
1. Solution "caption command" row cites sty:495, 534, **584**, 606: the third `\caption{#2.}` is at sty:583; sty:584 is `\label{#3}`.
2. Solution `sp.manual-space` row cites sty:209, 216, 249, **349**, **380**: 216 and 249 are `\vspace`; 209 and 349 are `\begin{flushleft}`, 380 is `\Needspace{4cm}`. `\bigskip` is sty:348 and the `\vspace{-2mm}\\` lines are sty:408 and 431 (not cited).
3. Solution "manual: front matter" row cites ftc-notebook.tex:31-62 for `tocloft` `\cftloftitlefont{\Large}`: that is ftc-notebook.tex:11-13, outside the cited range.
All other citations I compared (example-notebook.tex 1, 3, 7, 9-11, 13, 17; sty 11, 18-38, 45-46, 47, 51, 52-54, 56, 59, 64-77, 80-84, 96, 185-196, 211/243/256/271/356/809, 283-285, 330-337, 350/391/417, 591, 821-885, 899-947, 910/928, 925-927, 996-1004; src/aug19.tex 31, 92, 104, 143, 152, 207; story.tex 1-54; bio.tex 1-18; newmeeting.sh 1-83; README.md 64-70; ftc-notebook.tex 2-5, 14-22, 55, 110, 212-234, 713-730, 968-971) match.

## Claims the source contradicts or overstates (non-blocking)
- "33 empty rows to fill the page" (Solution cover-background row): sty:842-872 is 31 empty rows; with the logo row (840) and year row (841) the tabular has 33 rows.
- Task-sections row lists `\Subsection` among not-numbered commands: sty:417-419 numbers it `n.m.k:` unless starred (`\Subsection*`).
- `\RawPict` is used in the body at src/story.tex:8 and is public (ftc-notebook.tex:833-848, sty:465-480) but is not in the story row or the `notebook.ftc` body vocabulary; the same holds for `\PictSubfigure`/`\ExplainedPictSubfigure` (sty:541-570) and `RawDecisionTable`/`RawDescriptionTable` (sty:624-649).
- Header fields: `Class origin: ctan` describes the package; the document class is kernel `article` (tex-distribution-unbundled). `Look carried by: class` is used for a package that is also proposed as a new component way, which blurs the summary's class-dimension count.
