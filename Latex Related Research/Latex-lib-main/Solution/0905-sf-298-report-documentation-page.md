yes

# 0905-sf-298-report-documentation-page: SF 298 Report Documentation Page

- Unverified: read from the source, not compiled.
- Source: Source/0905-sf-298-report-documentation-page/ (origin: https://latextemplates.com/downloads/sf298.zip; licence: LPPL-1.2)
- Kind: report
- Lib: v6
- Engine: pdfLaTeX-compatible (the sample needs no `fontspec`, `unicode-math`, `luacode` or `polyglossia`; the CTAN page for `sf298` states no engine and the package source is not in the zip, so it was not read)
- Look carried by: preamble (the published CTAN package `sf298`, loaded by one `\usepackage` at main.tex:2, prints the whole page; the zip adds only field strings and five page-size lengths)
- Class origin: tex-distribution-unbundled (`article`, not in the zip; `sf298` itself is a published CTAN and TeX Live package that the zip does not bundle, README.md:7)
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
The zip is a 37-line sample plus a README. It holds no zip-local `.cls`, `.sty` or macro definition. The page is produced entirely by the published package `sf298` (CTAN, v1.3 of 2016-07-07, LPPL 1.2, Standard Form 298 Rev. 8-98), which the sample drives with string-valued field commands and one body call `\MakeRptDocPage`. Package options, the field commands and the call are declarative and printable as preamble lines plus one body line, so one new doc-kind way `NEW:form.sf298` covers it. No bespoke code, no artwork, no external tool is visible. Caveat: `sf298.sty` is not in the zip and was not read (the CTAN page lists no commands or options), so what the package does internally (fonts, page style, drawn rules) is taken on trust as a published package, as the rubric treats an unbundled published class.

## Blockers
none

## Class setting
- Class: `class.article` options: `twoside` (main.tex:1)
- Class-native vocabulary used: none (the sample uses no `\maketitle`, `abstract` environment, `\section` or other article command; the body is the one `sf298` call)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.article` | option `twoside` (a parameter of the class) |
| page size and margins | main.tex:5-9 | `page.setlength` | `\paperwidth`=8.5in, `\paperheight`=11in, `\textwidth`=6.5in, `\oddsidemargin`=0in, `\evensidemargin`=0in |
| paragraph shape | main.tex:4 | `sp.lengths` | `\parindent`=0pt |
| the form page itself (all fixed boxes, labels, rules and layout of the SF 298) | main.tex:2, 36 | `NEW:form.sf298` | `\usepackage{sf298}` with no options; one body call `\MakeRptDocPage` in an otherwise empty document body |
| report identification fields | main.tex:11-14 | `NEW:form.sf298` | `\ReportDate{15--08--2026}`, `\ReportType{Technical Report}`, `\DatesCovered{...}`, `\Title{...}` (strings) |
| contract, program and task numbers | main.tex:15-19 | `NEW:form.sf298` | `\ContractNumber`, `\ProgramElementNumber`, `\ProjectNumber`, `\TaskNumber`, `\WorkUnitNumber` (strings) |
| author, performing organisation, sponsor fields | main.tex:20-25 | `NEW:form.sf298` | `\Author`, `\PerformingOrg`, `\POReportNumber`, `\SponsoringAgency`, `\Acronyms`, `\SMReportNumber` (strings) |
| abstract box | main.tex:26-31 | `NEW:form.sf298` | `\Abstract{...}` (one text argument; the abstract text is content) |
| security marking boxes | main.tex:32-33 | `NEW:form.sf298` | `\AbstractClassification{U}`, `\AbstractLimitation{UU}` (short strings) |
| line breaks inside multi-line address fields | main.tex:21, 23 | `sp.manual-space` | kernel `\\` between the lines of `\PerformingOrg` and `\SponsoringAgency` |

Not set by the zip, so no row: fonts, header and footer, colour, language, hyperlinks, headings, lists, floats, bibliography. They are the `article` defaults plus whatever `sf298` sets internally (not read).

## Bespoke code
none. The zip defines no `\newcommand`, `\def`, environment, counter, conditional, class or style (main.tex has 37 lines, all read; README.md has 9 lines). The commands `\ReportDate` ... `\MakeRptDocPage` are the package's own published interface, not zip-local, per README.md:7-9 and the CTAN page https://ctan.org/pkg/sf298 (Steven Douglas Cochran, maintainer Peter A. Rochford, v1.3, LPPL 1.2, in TeX Live and MiKTeX).

## Content-opaque
none (the field values, the abstract text and the dates are content; there is no figure, table, drawing or equation in the zip)

## Lib changes
- New ways proposed: `NEW:form.sf298` `sf298` (CTAN, TeX Live, MiKTeX, LPPL 1.2, v1.3, read at ctan.org/pkg/sf298; engine pdf, not stated on the CTAN page and the source was not read): a whole Standard Form 298 Rev. 8-98 report documentation page (ANSI Z39.18, a US government contract report form); `\usepackage{sf298}`, field setters `\ReportDate` `\ReportType` `\DatesCovered` `\Title` `\ContractNumber` `\ProgramElementNumber` `\ProjectNumber` `\TaskNumber` `\WorkUnitNumber` `\Author` `\PerformingOrg` `\POReportNumber` `\SponsoringAgency` `\Acronyms` `\SMReportNumber` `\Abstract` `\AbstractClassification` `\AbstractLimitation`, body `\MakeRptDocPage` (the CTAN page lists none; these come from the sample). W1: published on CTAN and in TeX Live. W2: every field is a string argument and the sample edits no code. W3: it serves a kind of document, the report documentation page of any report or contract, not one report. W4: one `\usepackage`, preamble setters and one body call. Considered and not chosen: `form.formular` (static fill-in fields built from declarations, not this fixed form), `form.eforms` (interactive fields), `report.practicalreports` (a science lab report); the doc-kind ways `inv.simpleinvoice` and `cal.kalender` are the pattern (a whole fixed page from strings).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
