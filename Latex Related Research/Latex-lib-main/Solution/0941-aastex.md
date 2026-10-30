yes

# 0941-aastex: AASTeX v7.0.2 (American Astronomical Society journal class)

- Unverified: read from the source, not compiled.
- Source: Source/0941-aastex/ (origin: https://journals.aas.org/wp-content/uploads/2026/06/aastex702.zip; licence: not established in the manifest, the class header states LPPL 1.3c, aastex702.cls:14-16)
- Kind: journal
- Lib: v6
- Engine: pdfLaTeX-compatible (the class only touches pdfTeX primitives behind its own `pdftex` option guard, aastex702.cls:12340-12342, 12355-12358; the sample's own header says the pdflatex + bibtex route, sample702.tex:681-684)
- Look carried by: class (the whole look is the publisher's `aastex702.cls`; the sample adds three `\newcommand` aliases and option values only)
- Class origin: publisher-official (the AAS's own author kit from journals.aas.org; copyright "American Astronomical Society", aastex702.cls:5)
- Main file: sample702.tex (other samples: none; sample702.bib, sample702.bbl, aasjournalv7.1.bst, orcid-ID.png, AuthorChargeInfographic.png and a compiled sample702.pdf are the support files)
- Read: main yes, zip-local classes and styles partly (aastex702.cls is 13853 lines; lines read: 1-260, 5395-5734, 6025-6094, 6150-6279, 6400-6439, 6590-6669, 6860-7130, 7170-7269, 7380-7519, 7585-7754, 7855-8044, 8160-8339, 8460-8619, 8725-8794, 11335-11464, 11472-11481, 11760-11779, 12015-12044, 12268-12367, 12425-12634, 12680-12790, 13355-13504, 13700-13852; not read: the ltxgrid-style column and output machinery (about 2000-4800), the journal-name and figure-set macros (8340-8724), the table-tool internals (8795-11334 and 11482-12014, 12045-12267), front-matter code 7270-7379 and 7520-7584; the .bst read in its first 60 lines plus an outline grep; the .bib and .bbl are data, .bbl read at the head only)

## Verdict
yes. The look is carried entirely by one publisher-official class, `aastex702`, loaded with three option names; the sample adds no `\usepackage`, no zip-local `.sty` and no drawing. The class is the AAS's own kit (W1 by the rubric's ruling on official kits), so its 13.8k lines of internals (own column output, `\@sect`, `deluxetable`) are the published way and not bespoke code. The only code defined in the zip's sample is three aliases that reduce by inline expansion. Caveat for reviewers: if a later definition stops treating a publisher class as published, this flips to `no`, because the class redefines kernel internals that no lib way expresses.

## Blockers
none

## Class setting
- Class: `class.aastex702` options: `linenumbers,amsmath,trackchanges` (sample702.tex:13). Other options the class declares and the sample only lists in comments (sample702.tex:21-58): `twocolumn` `manuscript` `preprint` `preprint2` `modern` `astrosymb` `tighten` `times` `longauthor` `twocolappendix` `anonymous` `resetfootnote` `longbib` (aastex702.cls:105-162, 5404-5424, 5496-5497); default is one column, 10 pt, letter paper (aastex702.cls:5475, 6881-6887).
- Class-native vocabulary used by the sample:
  - front matter: `\title`, `\author[orcid=,gname=,sname=]{}`, `\altaffiliation`, `\affiliation`, `\email[show]{}`, `\collaboration{all}{}`, `abstract`, `\keywords`, `\uat{}{}` (sample702.tex:117-238); implicit `\maketitle` from the first `\section` (aastex702.cls:7617).
  - back matter: `acknowledgments` and `contribution` environments, `\facilities{}`, `\software{}` (sample702.tex:571-619).
  - floats: `\plotone{}` (sample702.tex:290); table family `deluxetable*`, `splitdeluxetable*`, `\tabletypesize`, `\tablewidth`, `\tablecaption`, `\tablehead`, `\colhead`, `\colnumbers`, `\startdata`...`\enddata`, `\tablecomments`, `\digitalasset`, `\nodata`, and the `B` break marker in the column spec (sample702.tex:421-485).
  - review aid: `\added{}` (sample702.tex:540), live only because of option `trackchanges`.
  - named in text only, not invoked: `\startlongtable`, `rotatetable`, `longrotatetable`, `\movetabledown`, `\figurenum`, `\plottwo`, `\watermark` (sample702.tex:103, 388, 506-510, 661-663).
- The lib has no class-native line for tables; as the v4 change log did for footnotes (a class's own vocabulary folded into its class way), the table vocabulary is recorded here under the class way and not proposed as a new way (considered: a table class-native line, rejected).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | sample702.tex:13; aastex702.cls:30 | `class.aastex702` | options `linenumbers,amsmath,trackchanges`; version 7.0.2 of 2025/05/09 |
| paper and size | aastex702.cls:5446-5470, 5475, 6881-6887 | `page.class-options` | default letterpaper, 10pt; a4paper/a5paper/b5paper/12pt are options |
| page geometry (class-fixed) | aastex702.cls:7192-7213; modern 13356-13369 | `page.class-options` | textwidth 7.1in, columnsep 0.3125in, parindent 0.125in, voffset -20mm, hoffset -7.5mm, headsep 0.5in, textheight 64 baselines less 54pt; `modern` sets 6in x 9.2in |
| columns | aastex702.cls:5496-5497, 6621-6628 | `cols.twocolumn-option` | class option `twocolumn`/`preprint2`; not set by this sample, default one column |
| running head / first page | aastex702.cls:7225-7238, 12449-12454, 12473; sample702.tex:89-90 (commented) | `hf.class-native` | `\pagestyle{apjheads}`, `\shorttitle` `\shortauthors` (unused), first page style `titlepage`, page number in the head |
| title | sample702.tex:117; aastex702.cls:7256-7257 | `front.class-native` | title format `\normalsize\bf\centering`, below-skip 8pt; `\footnote` inside the title |
| authors, affiliations, emails, collaboration | sample702.tex:169-201; aastex702.cls:7419-7437, 12740-12764, 13375-13419, 13443-13492 | `front.class-native` | metadata key list (orcid, gname, sname), ORCID icon via `orcid-ID.png` (aastex702.cls:12757-12763), superscript-address mode (aastex702.cls:6879, 6885), `\email[show]`, `\collaboration{all}` |
| front-matter footnotes | aastex702.cls:7589-7593 | `fn.kernel` | `\footnoterule` removed, `\@makefntext` hangs the mark in 3mm |
| abstract | sample702.tex:210-228; aastex702.cls:7441-7455, 7459-7487 | `abs.class-native` | heading text `ABSTRACT`, centred; font `\normalsize`, parindent 9pt, width 478pt |
| keywords | sample702.tex:238; aastex702.cls:2304-2307, 7496-7516, 13820 | `abs.keywords` | `\keywords{...}` with `\uat{label}{id}` linking to astrothesaurus.org; hanging indent, 34pt/0.5in side skips |
| submission note, dates | aastex702.cls:12459-12460, 12481-12492; sample702.tex:93-98 (commented) | `front.class-native` | `\received` `\revised` `\accepted` `\submitjournal`, unused |
| sectioning | sample702.tex:250, 334, 390, 410, 487; aastex702.cls:7607-7651, 7674-7701 | `head.class-native` | `\section` centred, level 1 upper-cased (7665), 9pt plus 1pt minus 1pt above, 4pt below; `\subsection` italic centred; `\subsubsection` small italic |
| heading depth | aastex702.cls:7600 | `num.secnumdepth` | secnumdepth 3 |
| appendix | sample702.tex:630-644; aastex702.cls:7892-7935 | `num.appendix` | `\appendix` prints a centred "APPENDIX" rule line, resets section/equation, `\thesection`=`\Alph{section}`, equations `A1` |
| list | sample702.tex:400-406; aastex702.cls:6036-6041, 6070-6084 | `list.kernel` | `enumerate`; leftmargini 25pt, labels `1.` `(a)` `i.` `A.`; bullet `\textbullet` |
| line numbers | sample702.tex:13; aastex702.cls:156, 13784-13791, 13795-13816 | `sp.draft-lineno` | `lineno[mathlines,left]`, `\linenumbers*[1]` when option `linenumbers`, maths patched for `amsmath` |
| inline marks | sample702.tex:368, 384, 538 | `mark.kernel` | `\textbf`, `\underline`, `\tt`; `\bf \it \rm \sc` are redefined as old-font commands (aastex702.cls:6641-6647) |
| tracked changes | sample702.tex:540; aastex702.cls:12527, 12533-12554, 12608 | `color.xcolor` | `\added{}` prints bold in colour `trackchange` (cmyk 0,0,0,1) only with option `trackchanges`; `ulem[normalem]` is loaded for `\sout` |
| heading-case helper | aastex702.cls:5588 | `mark.case` | `textcase[overload]` loaded by the class |
| figure float | sample702.tex:289-293; aastex702.cls:6187-6192, 6216-6221 | `fig.graphicx` | `figure*[ht!]`, `\plotone{file}` = `\includegraphics` at 0.85\linewidth times `\epsscale` (aastex702.cls:8201-8209); `graphicx`+`epsfig` loaded (6925) |
| caption | sample702.tex:291; aastex702.cls:8509-8532, 12688-12712 | `cap.kernel` | class-redefined `\@makecaption`: bold "Figure N." label, `\small`, centred when it fits one line, `\abovecaptionskip` 5pt, `\belowcaptionskip` 4pt; `\digitalasset` highlights the title (13707) |
| table (deluxetable family) | sample702.tex:421-485; aastex702.cls:11357-11441, 11446-11452, 8470-8477, 8586, 8595, 12028-12029 | `tbl.tabular` | built on `tabular`+`array` (`\begin{tabular}{#1}`, 11449; `array` 8777); `\tabletypesize{\scriptsize}`, `\tablewidth{0pt}`, `\colnumbers`, `\hline`, `\cline`, `\multicolumn`; table numbers `\@Roman` (6234) |
| long and split tables | aastex702.cls:8744, 11340, 11767-11773 | `tbl.longtable` | `longtable` loaded unconditionally; `\startlongtable`, `splitdeluxetable*`; neither environment is run long in the sample |
| rotated tables | aastex702.cls:11478-11479, 12276-12287, 12310-12351 | `fig.rotating` | `rotating[figuresright]`, `rotatetable`, `longrotatetable`; named in text only (sample702.tex:661-663) |
| table note | sample702.tex:450, 482; aastex702.cls:12028-12029 | `tbl.tabular` | `\tablecomments{}` prints "Note---" in small caps below the table; same way as the table row |
| equation | sample702.tex:638-640; aastex702.cls:5599-5601, 6167-6170, 7913 | `math.amsmath` | option `amsmath` loads `amsmath`; `\theequation` = `\Alph{section}\arabic{equation}` after `\appendix` |
| maths symbols | aastex702.cls:6909-6910 | `math.amssymb` | `latexsym`, `amssymb` loaded |
| links and PDF metadata | aastex702.cls:8747-8765; sample702.tex:60-72 (comment) | `meta.hyperref` | `bookmarks=true,pdfnewwindow=true,colorlinks=true,linkcolor=citecolor=filecolor=urlcolor=xlinkcolor,final=true` |
| link colour | aastex702.cls:8749 | `color.xcolor` | `\definecolor{xlinkcolor}{cmyk}{1,1,0,0}` |
| URLs | sample702.tex:252, 332; aastex702.cls:8731 | `meta.url` | `url[hyphens]`; `\href` and `\doi` (13555) from hyperref |
| cross references | sample702.tex:296, 322, 334, 424 | `xref.kernel` | `\label`, `\ref`; class writes `LastPage` itself (6054) |
| acknowledgments | sample702.tex:571-580; aastex702.cls:7735-7754 | `front.class-native` | `acknowledgments` environment (hidden under `anonymous`) |
| author contributions | sample702.tex:582-599; aastex702.cls:7859-7877 | `front.class-native` | `contribution` environment starts `\section*{Author contributions}`; end-of-document check that it was used |
| facilities, software | sample702.tex:610-619; aastex702.cls:8166-8191 | `front.class-native` | `\facilities{}`, `\software{}` print an italic `\large` run-in label after the text |
| citations | sample702.tex:254, 258, 560, 616-618; aastex702.cls:6418, 6912-6913 | `bib.natbib` | `natbib[sort&compress]`, `\bibpunct{(}{)}{;}{a}{}{,}`, `\citep` `\citet` |
| bibliography | sample702.tex:686-687; aastex702.cls:7972-8034 | `bib.bibtex-bst` | `\bibliographystyle{aasjournalv7.1}` (AAS's own `.bst`, aasjournalv7.1.bst:1-60), `\bibliography{sample702}`; heading "REFERENCES", `\small`, hanging 1em, no numbers |
| default font | aastex702.cls:13836-13840 | `font.newtx` | option `times` loads `newtx`; not used by this sample, Computer Modern is the default |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\newcommand{\vdag}{(v)^\dagger}` | sample702.tex:78 | yes | inline expansion of `(v)^\dagger`; never called in the body |
| `\newcommand\aastex{AAS\TeX}`, `\newcommand\latex{La\TeX}` | sample702.tex:79-80 | yes | inline expansion to `AAS\TeX` and `La\TeX` (the body calls them as `\aastex\ ` and `\latex\ `) |
| `aastex702.cls` as a whole (own column output 3070-4192, `\begin`/`\end` hooks 7171-7178, `\@sect` 7674, `\caption` 12688, `deluxetable` 11357) | aastex702.cls | not bespoke | published by the AAS (official kit), so one `class.aastex702` way; its internals are not an emitter job |
| `aasjournalv7.1.bst` | aasjournalv7.1.bst | not bespoke | AAS's published BibTeX style, a parameter of `bib.bibtex-bst` |

## Content-opaque
none (the figure artwork `AuthorChargeInfographic.png` at sample702.tex:290 and the icon `orcid-ID.png` are shipped image assets; the table data rows at sample702.tex:441-448 and 467-480 are content)

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
