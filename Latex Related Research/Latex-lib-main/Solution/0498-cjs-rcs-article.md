yes

# 0498-cjs-rcs-article: cjs-rcs-article (article class of The Canadian Journal of Statistics | La revue canadienne de statistique)

- Unverified: read from the source, not compiled.
- Source: Source/0498-cjs-rcs-article/ (origin: https://mirrors.ctan.org/macros/latex/contrib/cjs-rcs-article.zip; licence: LPPL 1.3c for class and templates, CC BY-SA 4.0 for the documentation)
- Kind: journal
- Lib: v4
- Engine: pdfLaTeX-compatible (LuaLaTeX recommended: the `\iftutex` branch loads `fontspec` and `unicode-math`, cjs-rcs-article.dtx:3242-3267; the pdfTeX branch loads `stix2`, cjs-rcs-article.dtx:3278-3283; README.md:15-16)
- Look carried by: class (the sample sets only class options and class commands; the look is the published CTAN class `cjs-rcs-article` on top of `memoir`, source in cjs-rcs-article.dtx)
- Class origin: ctan
- Main file: cjs-template.tex (other samples: rcs-gabarit.tex, the French twin that the manifest lists as main; both are generated from the `template` modules of cjs-rcs-article.dtx:4796-5253)
- Read: main yes, zip-local classes and styles partly (the class code in cjs-rcs-article.dtx read in full, lines 2960-4772, plus the usage documentation; not read: the body of cjs-rcs-merlin.mbs (8015 lines, a BibTeX style generator), cjs-rcs-english.mbs, cjs-rcs-french.mbs, the bodies of cjs-rcs-bst-en.dbj and cjs-rcs-bst-fr.dbj beyond their option header, the prose of cjs-rcs-authguide.dtx (outline and code lines only))

## Verdict
yes. The template (cjs-template.tex) writes one `\documentclass[french,english,review]{cjs-rcs-article}` line, class commands and ordinary content, and defines no macro of its own (cjs-template.tex:12, :25 `\usepackage{}` is commented out). The class is released on CTAN and is in TeX Live and MiKTeX (README.md:68-72; ctan.org/pkg/cjs-rcs-article read once), so it is one published way `class.cjs-rcs-article` and its internals are that way's behaviour, not zip-local bespoke code. The `.cls` is not a file of the zip: it is generated from the `.dtx` by docstrip, which is TeX only (cjs-rcs-article.ins:3, cjs-rcs-article.dbj:30-35). This is a class-dimension `yes` (look carried by a published class), not evidence about the component ways.

## Blockers
none

## Class setting
- Class: `class.cjs-rcs-article` options: languages `french`, `english` (the last one becomes the main language, cjs-rcs-article.dtx:831-833), `review` (line numbers and 1.5 spacing), `supplement`, `nocjs`, `final`; any other option is passed to `memoir` (cjs-rcs-article.dtx:3057). The class loads `memoir` with `letterpaper,10pt,article,twoside` (cjs-rcs-article.dtx:3059).
- Class-native vocabulary used: `\title[short]{}`, `\author[orcid=,email=,corresponding]{Forename \surname{Surname}}`, `\affil{}`, `\runningauthor{}`, `englishabstract`, `frenchabstract`, `keywords` (with `\item`), `classification[type]` (with `\item[Level]`), `supplement`, `sharing`, `acknowledgements`/`acknowledgments`, `funding[name]`, `\maketitle`, `\makebackmatter`, theorem-like environments `theorem` `lemma` `proposition` `corollary` `definition` `algorithm` `remark` (each with optional title argument), `\Rset` and the math shortcuts `\Pr` `\E` `\Var` `\Cov` `\corr` `\prdist` `\mat` `\matit` `\trsp` `\tr` `\diag` `\Nset` `\Zset` `\Qset` `\Rset` `\Cset`, `\np` (numprint shortcut), `\proglang` `\pkg` `\code`, editor commands `\jvol` `\jissue` `\jyear` `\firstpage` `\received` `\accepted` `\licence` `\specialack` `\ADNIacknowledgement`, layout switches `\suppressfancybreak` `\showfancybreak`, lengths `\titlingskip` `\fancybreaksep`. Constraint for an emitter: the class raises an error if `geometry` is loaded (cjs-rcs-article.dtx:3208-3213) and is documented as incompatible with `amssymb` (cjs-rcs-article.dtx:1817-1818).

## Component map
Rows marked [in class] are realised inside the published class by the named published package; an emitter targeting this class writes only the class-native vocabulary above. Files: T = cjs-template.tex, G = rcs-gabarit.tex, D = cjs-rcs-article.dtx.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | T:12; G:13; D:3057-3059 | `class.cjs-rcs-article` | `french,english,review`; English template lists french first so English is main, French template the reverse (G:13) |
| class option switches | D:3007-3047 | `class.cjs-rcs-article` | `review`, `supplement`, `nocjs`, `final` booleans; `final` overrides `review` |
| paper, type size, sides [in class] | D:3059 | `page.class-options` | `letterpaper,10pt,article,twoside` forced |
| margins [in class] | D:3346-3349 | `page.memoir-layout` | `\setlrmarginsandblock{24mm}{30mm}{*}`, `\setulmarginsandblock{24mm}{26mm}{*}`, `\setheadfoot{13.5pt}{9mm}`, `\checkandfixthelayout[nearest]` |
| title-page footer space [in class] | D:3962 | `page.adjustwidth` | memoir's `\changepage{-\CJS@adjustheight}...{\CJS@adjustheight}` (changepage family) |
| abstracts in two columns [in class] | D:4019-4029 | `cols.paracol` | `paracol{2}`, `\switchcolumn[0 or 1]` by main language, `\RaggedRight` |
| running heads and feet | D:3430-3452 | `hf.class-native`, `hf.memoir-pagestyle` | `\makepagestyle{cjs}`, `\makeevenhead`/`\makeoddhead` with `tabular*`, `\hline`, folio, upper-cased authors and short title, empty feet, Fira lining 9/13 (D:3408-3409) |
| first-page style | D:3458-3508 | `hf.class-native`, `hf.memoir-pagestyle` | `cjsfirstpage`: empty head; foot is the licence block (rule plus `\parbox`) or, with review/supplement/nocjs, a folio footer |
| upper-casing in heads [in class] | D:3437, D:3443, D:3813 | `mark.case` | `\MakeTextUppercase` on authors, short title, surnames |
| first page number | D:3974 | `pgnum.pagenumbering` | `\setcounter{page}{\CJS@firstpage}` |
| line numbers (review) | D:3192-3195, D:3298-3301 | `sp.draft-lineno` | `\linenumbers`, `\linenumberfont` Fira tiny, `\linenumbersep` 5pt |
| line spacing | D:3566-3568, D:3970 | `sp.setspace` | memoir `\OnehalfSpacing` under `review`, `\SingleSpacing` on the title page |
| float suppression on title page | D:3971 | `fig.placement` | kernel `\suppressfloats[t]` |
| text and math font, pdfTeX | D:3278-3283 | `font.serif-pkg`, `font.fontenc-t1`, `sp.microtype` | `stix2`; `inputenc[utf8]`, `fontenc[T1]`; `microtype[babel=true]` |
| text and math font, Lua/Xe | D:3242-3267 | `font.fontspec`, `font.unicode-math`, `sp.microtype` | `\setmainfont{STIXTwoText}[Extension=.otf,UprightFont=*-Regular,BoldFont=*-SemiBold,...,Ligatures=TeX]`, `\setmathfont{STIXTwoMath-Regular}`, `\setmathfont{FiraMath-Regular}[version=titles,Scale=0.92]` |
| sans and mono [in class] | D:3290-3291 | `font.helvet`, `font.mono` | `FiraSans[book,medium,proportional,lining,scale=0.92]`, `FiraMono[medium,lining,scale=0.90]` |
| relative sizes and icons [in class] | D:3169-3170, D:3770, D:3833, D:4291-4358 | `font.size-commands`, `font.icons` | `relsize` `\larger` `\smaller`; `fontawesome5` `\faOrcid`, `\faAt`, Creative Commons icons |
| colours [in class] | D:3314-3332 | `color.xcolor` | CJSpink E3038B, CJSred D10000, CJSyellow FEC70D, CJSorcid A6CE39 (HTML); CJSlink rgb 0,0.4,0.6; CJSurl 0.6,0,0; CJScitation 0,0.5,0 |
| hyperlinks and PDF outline [in class] | D:3105-3115 | `meta.hyperref`, `meta.bookmark` | `colorlinks=true`, `urlcolor`/`linkcolor`/`citecolor`; `\bookmarksetup{open=true,depth=3,numbered=true}`; loaded by `\AtEndPreamble` |
| urls and email | D:3168, D:3763 | `meta.url` | `url` package, `\url`, `\href{mailto:}` |
| languages | T:12; D:3091 | `lang.babel` | `babel` with the class options; `\iflanguage{french}{..}{..}` switches every fixed string |
| French settings [in class] | D:3588-3595, D:4569-4570 | `lang.babel` | `\frenchsetup{SmallCapsFigTabCaptions=false,ThinSpaceInFrenchNumbers=true,og=«,fg=»}`, `\frenchtablename` Tableau, `\setlocalecaption` bib |
| number printing | D:3092; T:245-254; G:255-262 | `mark.siunitx` | `numprint[autolanguage,np]`, inline `\np{109338}` |
| dates (history) | D:3164, D:4679, D:4692-4693 | `front.datetime` | `datetime2[useregional,french,en-GB]`, `\DTMlangsetup[en-GB]{ord=omit}`, `\DTMsavedate` `\DTMusedate` |
| title | T:36; D:3691-3693 | `front.class-native` | `\title[short]{full}`; `\maintitlefont` = `\raggedright\normalfont\huge\bfseries`; title in `minipage` 0.9\textwidth (D:3995) |
| authors, affiliations, ORCID | T:46-48; D:3735-3792 | `front.class-native` | keys `orcid` `email` `corresponding`; `\authfont` sans bold, `\affilfont` sans grey; `\authsep` 1ex; `\surname` upper-cased and collected for the head |
| journal info and ornament [in class] | D:3362-3395, D:3978-3981 | `front.class-native`, `sp.rule`, `color.xcolor` | three coloured `\vrule` bars (width 4pt, height measured from two text lines) beside journal name and "Vol., No., year, pages"; rules only, no drawing package |
| title-page layout | D:3609-3657, D:3958-4066 | `front.class-native` | `\journalinfoskip` -4ex, `\maintitleskip` 6ex, `\supptitleskip` 2ex, `\authorskip` 5ex, `\titlingskip` 2pt plus2pt minus0.8pt, `\fancybreaksep` 6pt plus3pt minus1pt; `\hrulefill` above and below the authors |
| title-page boxes [in class] | D:3995-4006 | `box.minipage` | two `minipage` of 0.9\textwidth for title and authors |
| fancy break | D:3926-3931, D:4063-4065 | `sp.rule` | memoir `\pfbreakdisplay` redefined as three `\rule` lines offset by `\normalrulethickness` |
| English and French abstracts | T:64-78; D:3863-3864, D:4019-4029 | `abs.class-native`, `sp.ragged` | `englishabstract`, `frenchabstract`; heading is `\paragraph{\abstractname}` in each language; `ragged2e` `\RaggedRight`; the kernel `abstract` env has no effect (D:1275-1276) |
| keywords | T:82-86; D:3882-3889 | `abs.keywords`, `list.enumitem` | env `keywords`; inline list `\newlist{CJS@keywordslist}{itemize*}{1}`, `mode=unboxed,label={},afterlabel={},itemjoin={{; }},after={.}` |
| subject classification | T:92-95; D:3905-3913 | `abs.classification` | env `classification[MSC2020]`, `\item[Primary]`; `itemjoin={{; }},after={.}` |
| corresponding author block | D:4058-4062 | `front.class-native` | `\corrauthmark` = `{\small\faAt}`, url of the email |
| back matter | T:102-130, T:270; D:4133-4197 | `front.class-native` | envs `supplement`, `sharing`, `acknowledgements`, `funding[name]` collected by `environ`, printed as `\section*` in this order by `\makebackmatter`, then the ORCID list |
| licence and CC icons | D:4217-4274, D:4291-4358 | `front.class-native`, `font.icons` | `\licence{}`, `\ccby` `\ccbysa` `\ccbync` `\ccbyncsa` `\ccbynd` `\ccbyncnd` (starred adds copyright icon); Fira 8/9pt |
| editor data and history | T:15-21; D:4625-4648, D:4661-4664, D:4719-4735 | `front.class-native`, `front.datetime`, `list.enumitem` | `\jvol` `\jissue` `\jyear` `\firstpage` `\received` `\accepted`; history list `itemjoin={{ --- }}` printed `\AtEndDocument`; commented out in the templates |
| special acknowledgement | D:4100-4104, D:4750-4767 | `front.class-native` | `\specialack{byline}{statement}`, `\ADNIacknowledgement`, `\ADMCacknowledgement` |
| headings | D:3535-3557 | `head.class-native`, `head.memoir-style` | `\setsecheadstyle{\normalfont\Large\sffamily\bfseries\raggedright}`, sub `\large`, subsub normal size, `\mathversion{titles}` under Lua/Xe; before/after skips e.g. `\setbeforesecskip{-1.75ex plus -0.5ex minus -0.1ex}`, `\setaftersecskip{1.2ex plus 0.1ex}` |
| heading numbering | D:3520-3527 | `num.secnumdepth`, `num.counters` | `\setsecnumdepth{subsubsection}`, `\maxsecnumdepth{subsubsection}`, `\let\chapter\relax`, `\counterwithout{section}{chapter}` |
| appendix | T:273; D:4536-4539 | `num.appendix` | `\appendix` redefined: section counter reset, `\@Alph\c@section` |
| supplement numbering | D:4599-4612 | `num.counters` | `\renewcommand*\thesection` ... `\theremark` with prefix `S` under `supplement` |
| bibliography | T:284; D:3076, D:4579 | `bib.natbib`, `bib.bibtex-bst` | `natbib[round,semicolon,authoryear,sectionbib]`; `\bibliographystyle{cjs-rcs-en}` or `cjs-rcs-fr` by language; BibTeX; fields doi, isbn, issn, language, url (D:2330-2383) |
| bibliography heading and spacing [in class] | D:4558-4562, D:4569-4570, D:4587 | `head.class-native`, `sp.lengths` | `\section*{\bibname}` plus `\addcontentsline`, "References"/"Références", `\setlength{\bibsep}{\itemsep}` |
| bibliography style files | cjs-rcs-article.ins:4-5; cjs-rcs-bst-en.dbj:610 | `bib.bibtex-bst` | `cjs-rcs-en.bst`, `cjs-rcs-fr.bst` generated by docstrip from cjs-rcs-merlin.mbs (option `ay`, external language file, cjs-rcs-bst-en.dbj:49-52); style name is the parameter |
| math packages [in class] | D:3185-3186 | `math.amsmath`, `thm.amsthm` | `amsmath`, `amsthm` loaded unconditionally |
| math shortcuts | D:4369-4430 | `math.amsmath`, `font.unicode-math` | `\DeclareMathOperator` for `\Pr` `\E` `\Var` `\Cov` `\corr` `\tr` `\diag`; `\prdist`=`\symcal`, `\mat`=`\symbf`, `\Rset`=`\symbb{R}` under Lua/Xe, `\mathcal` `\mathbf` `\mathbb` under pdfTeX |
| display equation | T:172-175 | `math.amsmath` | `equation` with `\label`, `\eqref` |
| theorem-like statements | T:161-216; D:4437-4460 | `thm.class-native`, `thm.amsthm` | `\theoremstyle{plain}`: theorem lemma proposition corollary; `definition`: definition algorithm; `remark`: remark; shared-less counters; names via `\iflanguage`; `proof` and `\qed` from amsthm (T:183-189, T:209) |
| cross-references | T:139, T:157; D:3116-3141, D:4472 | `xref.hyperref`, `xref.kernel` | `\autoref` with `\<env>autorefname` set in `\extrasenglish`/`\extrasfrench`; `\eqref` redefined as `\hyperref[..]{\textup{(\ref*{..})}}` |
| lists in body | T:204-210; D:3162 | `list.kernel`, `list.enumitem` | `enumerate` (inside `algorithm`); `enumitem[shortlabels]` loaded |
| figure | T:220-225; D:3177 | `fig.graphicx` | `figure`, `\centering`, `\includegraphics[width=0.4\linewidth]{example-grid-100x100pt}` (image from the TeX Live `mwe` package: asset) |
| table | T:234-257 | `tbl.tabular`, `tbl.booktabs` | `tabular{rlrrrrrr}`; `\toprule` `\midrule` `\bottomrule` are memoir's built-in booktabs-compatible rules (the class loads no `booktabs`; `\addlinespace` is used in the documentation tables, D:1870) |
| captions | T:223, T:235-237; D:3576, D:3594-3595 | `cap.memoir` | `\captionnamefont{\bfseries}`; babel names Table/Tableau, Figure |
| inline marks | T:236 | `mark.kernel` | `\textsc{gnp}`, `\emph`, `\textsuperscript` |
| software names and code | D:4488-4521 | `mark.kernel` | `\proglang` = `\mbox`, `\Rlang` `\Cpplang`..., `\pkg` = `\textbf`, `\code` = `\ttfamily` with hyphenation off; the class gives no listing feature and points to `fancyvrb` or `listings` (D:2165-2175); the sample has no code |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| macros of the sample | cjs-template.tex, rcs-gabarit.tex | n/a | none defined: the sample has no `\newcommand`, `\def`, counter or `\usepackage` (T:25 commented) |
| class internals: `\maketitle`, `\author` key parser, `environ` collectors, `\makebackmatter`, `\CJS@measurelicence`, `\@memb@bsec` redefinition, journal ornament boxes | D:3370-3395, D:3691-4066, D:4176-4262, D:4558-4562, D:4719-4735 | inside a published class (W1), not counted as bespoke; marked scope `class` | would be irreducible `BESPOKE/class` (box measuring, key-value author parser, kernel-internal redefinition) if the class were zip-local; it is not, because the zip is the CTAN release |
| documentation drivers: `\makeindex`, `\@wrindex`, `\glossary` restorations, `\TheCJS` and `\CJSclass` aliases, `\nolink`, `\NewDocElement` | D:42-190; cjs-rcs-authguide.dtx:30-175 | out of scope: they build the guide PDFs, not a template; the stubs restore kernel index and glossary commands that `doc.sty` expects | a guide would be `class.cjs-rcs-article[nocjs]` with `dtx.doc`, `code.listings`, `tbl.threeparttable` (authguide.dtx:84), `xref.xr` (D:114); nothing in the template depends on them |
| docstrip drivers | cjs-rcs-article.dbj:30-35; cjs-rcs-bst-en.dbj:610 | reducible: docstrip is TeX, no external tool | produces the published `.cls` and `.bst`; recorded as `class.cjs-rcs-article` and `bib.bibtex-bst` |

## Content-opaque
none (the sample figure is an image from the `mwe` package, an asset; the table cells are data)

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
