yes

# 0568-koma-script-sfs: SFS letter option file for KOMA-Script scrlttr2 (Finnish standard letter)

- Unverified: read from the source, not compiled.
- Source: Source/0568-koma-script-sfs/ (origin: https://mirrors.ctan.org/macros/latex/contrib/koma-script-SFS.zip; licence: LPPL 1.3, stated at SFS.lco:6-8)
- Kind: letter
- Lib: v4
- Engine: pdfLaTeX-compatible (`inputenc` latin9, `fontenc` T1, `lmodern`, `babel`; no fontspec, no Lua; SFSesim.tex:20-23)
- Look carried by: mixed (KOMA `scrlttr2` letter layout, a zip-local letter-class-option file `SFS.lco` that sets margins, address window and Finnish terms, and a short sample preamble for fonts, language, sender data and the first-page footer)
- Class origin: tex-distribution-unbundled (`scrlttr2` is KOMA-Script, not in the zip; the one zip-local file is an `.lco` settings file, not a class; the zip itself is a CTAN contrib add-on to KOMA, README:1-3)
- Main file: SFSesim.tex (other samples: none; `SFSesim.pdf` is the shipped one-page output and was not analysed)
- Read: main yes, zip-local classes and styles all (the only zip-local code file, `SFS.lco`, 213 lines, read in full; there is no `.cls`, `.sty`, `.def`, `.cfg` or `.clo`; the KOMA `scrlttr2`, `scrbase`, `geometry` and `babel` sources are not in the zip and were not read)

## Verdict
Yes. The whole look is `scrlttr2` plus `SFS.lco`, and `SFS.lco` is a fixed bundle of calls into published packages and class commands: one `geometry` line, seven KOMA pseudo-length assignments, one KOMA option (`backaddress=false`), thirteen language-term definitions, one `\let` to `\raggedright`, and one macro `\C{n}`. That macro is a nine-branch `\ifnum` table that does nothing except set `\leftskip` to n times 23 mm, so it reduces by expansion to a raw TeX length parameter (`sp.lengths`). There is no output routine, box algorithm, counter, drawing or external tool. One call (`\g@addnumerical@date`) is an internal, undocumented hook of the published class; it is a language name plus a date pattern, and it only matters when `numericaldate=true`, which neither file sets. Its source is not in the zip and was not read, so that one line is the least certain part of the reduction.

## Blockers
none

## Class setting
- Class: `class.scrlttr2` options: none on `\documentclass` (SFSesim.tex:19); KOMA options are set later with `\KOMAoptions{foldmarks=false}` (SFSesim.tex:42) and `\KOMAoptions{backaddress=false}` (SFS.lco:148); the paper size a4 is only checked by `\LetterOptionNeedsPapersize{SFS}{a4}` (SFS.lco:42)
- Class-native vocabulary used: `\LoadLetterOption` (SFSesim.tex:31); `\setkomavar{fromname,fromaddress,fromphone,fromfax,fromemail,fromurl}` and `\usekomavar{fromphone,fromfax,fromemail}` (SFSesim.tex:36-41, 51-53); `\firstfoot` (SFSesim.tex:47); `letter` environment with the recipient address as its argument (SFSesim.tex:61-63); `\opening` (SFSesim.tex:66); `\closing` (SFSesim.tex:100); `\KOMAScript` logo in running text (SFSesim.tex:78); in the `.lco`: `\LetterOptionNeedsPapersize` (SFS.lco:42), `\@setplength` on `toaddrvpos` `toaddrhpos` `toaddrwidth` `toaddrheight` `toaddrindent` `backaddrheight` `firstfootvpos` (SFS.lco:126-152), `\raggedsignature` (SFS.lco:154), `\providecaptionname` for the letter terms `\yourrefname` `\yourmailname` `\myrefname` `\customername` `\invoicename` `\subjectname` `\headfromname` `\datename` `\phonename` `\faxname` `\emailname` `\wwwname` `\bankname` (SFS.lco:159-171), `\g@addnumerical@date` (SFS.lco:181-182). Commented out and inactive: `\cc` `\encl` (SFSesim.tex:97-98), `\KOMAoptions{fromphone,fromemail,fromurl}` (SFSesim.tex:43), the E-series window size (SFS.lco:137-138), `toaddrvpos` 40mm (SFS.lco:127)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class | SFSesim.tex:19 | `class.scrlttr2` | no options |
| letter option file | SFSesim.tex:31 | `ltr.opening` | `\LoadLetterOption{SFS}`; an emitter inlines the rows below instead of shipping the file (or ships `SFS.lco` and keeps the call) |
| input encoding | SFSesim.tex:20 | `font.fontenc-t1` | inputenc option `latin9` |
| font encoding | SFSesim.tex:21 | `font.fontenc-t1` | fontenc option `T1` |
| text font | SFSesim.tex:22 | `font.lmodern` | `lmodern` |
| language | SFSesim.tex:23 | `lang.babel` | option `finnish` |
| paragraph shape | SFSesim.tex:27-28 | `sp.lengths` | `\parindent`=0pt, `\parskip`=1ex plus 0.5ex minus 0.2ex |
| paper size | SFS.lco:42 | `page.class-options` | a4 (the scrlttr2 default; the lco only checks it and warns otherwise) |
| page margins | SFS.lco:120 | `page.geometry` | left=20mm, top=10mm, right=6mm, bottom=9.156mm |
| address window position and size | SFS.lco:126, 128, 132, 133 | `ltr.opening` | `toaddrvpos`=36mm, `toaddrhpos`=18mm, `toaddrwidth`=95mm, `toaddrheight`=35mm |
| address indent | SFS.lco:142 | `ltr.opening` | `toaddrindent`=5mm |
| return-address line | SFS.lco:147-148 | `ltr.opening` | `backaddrheight`=0mm, `backaddress=false` |
| first-page foot position | SFS.lco:152 | `ltr.opening` | `firstfootvpos`=266.679mm |
| fold marks | SFSesim.tex:42 | `ltr.opening` | `foldmarks=false` |
| signature alignment | SFS.lco:154 | `sp.ragged` | `\raggedsignature` set to `\raggedright` |
| Finnish letter terms | SFS.lco:159-171 | `lang.babel` | `\providecaptionname{finnish}` for 13 terms, strings such as Viitteenne, Kirjeenne, Viitteemme, Asia, Puhelin, Faksi, Sähköposti (written with `\"` escapes, SFS.lco:165-169) |
| numerical date pattern | SFS.lco:181-182 | `ltr.opening` | language `finnish`, pattern `\number\day.\number\month.\number\year` (internal KOMA hook; see Bespoke code) |
| sender data | SFSesim.tex:36-41 | `ltr.opening` | `\setkomavar` fromname, fromaddress (with `\\`), fromphone, fromfax, fromemail, fromurl (values are content) |
| first-page footer | SFSesim.tex:47-57 | `hf.class-native` | `\firstfoot{...}`; its content is a `\parbox` holding a table |
| footer box | SFSesim.tex:48 | `box.minipage` | `\parbox[t]{\textwidth}{...}` |
| footer table | SFSesim.tex:49-55 | `tbl.tabular` | `tabular[t]{llll}`, 3 rows, `\usekomavar` in cells (SFSesim.tex:51-53) |
| recipient block | SFSesim.tex:61-63 | `ltr.opening` | `letter` environment, address as argument, lines split with `\\` |
| salutation and closing | SFSesim.tex:66, 100 | `ltr.opening` | `\opening{...}`, `\closing{...}` |
| column offset of a paragraph | SFS.lco:189-208; used at SFSesim.tex:68, 72, 82, 86, 94 | `sp.lengths` | `\C{n}` is `\leftskip`= n x 23mm, n=0..8 (0, 23, 46, 69, 92, 115, 138, 161, 184 mm) |
| verbatim command names in text | SFSesim.tex:88, 91, 92 | `code.verbatim` | `\verb=...=` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| whole file `SFS.lco` | SFS.lco:27-208 | yes | no options, no state; its printed effect is the rows above: `page.geometry`, `ltr.opening` pseudo-lengths and options, `lang.babel` terms, `sp.ragged`, `sp.lengths`. W1 holds (it is released on CTAN with this zip) but W2 fails (nothing to choose), so it is not a way, only a reducible bundle |
| `\newcommand{\C}[1]` | SFS.lco:189-208 | yes | nine `\ifnum` branches, each only `\leftskip n*23mm`; replace `\C{n}` by the assignment `\leftskip=<n*23>mm` (a lookup, no state, no output routine). Values outside 0..8 do nothing |
| `\let\raggedsignature=\raggedright` | SFS.lco:154 | yes | `sp.ragged`, the documented KOMA hook `\raggedsignature` set to a kernel command |
| `\@setplength{...}{...}` x7 | SFS.lco:126, 128, 132, 133, 142, 147, 152 | yes | KOMA pseudo-length setter taking a name and a length (documented; `\setplength` is the document-level form in newer KOMA, `\@setplength` the older form for lco files); `ltr.opening` parameters |
| `\g@addnumerical@date{finnish}{...}` | SFS.lco:181-182 | yes, with a caveat | a call into the class's internal date hook with two arguments (a language name and a pattern built from kernel `\number\day`, `\month`, `\year`); an emitter prints the same line between `\makeatletter` and `\makeatother`. The caveat: it is `@`-named and I found it in no KOMA manual page I could check; its source is not in the zip; and the printed date changes only under `numericaldate=true`, not set anywhere here (SFSesim.tex has no `\setkomavar{date}`) |
| `\@ifundefined{scr@fromname@var}{\GenericWarning...}{}` | SFS.lco:29-41 | yes | a guard that warns when the file is used without scrlttr2; no printed effect; omit |
| `\LetterOptionNeedsPapersize{SFS}{a4}` | SFS.lco:42 | yes | a documented KOMA check that warns when the paper is not a4; no printed effect; record paper=a4 under `page.class-options` |
| `\ProvidesFile{SFS.lco}[...]` | SFS.lco:27-28 | yes | file metadata, no printed effect |

## Content-opaque
none (the sample has no figure, float or drawing; the footer table cells, sender data and body text are plain content)

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
