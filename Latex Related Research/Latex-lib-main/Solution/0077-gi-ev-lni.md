yes

# 0077-gi-ev-lni: lni, official class for the "Lecture Notes in Informatics" (GI)

- Unverified: read from the source, not compiled.
- Source: Source/0077-gi-ev-lni/ (origin: https://codeload.github.com/gi-ev/LNI/zip/refs/heads/main; licence: LPPL-1.3c)
- Kind: conference
- Lib: v1
- Engine: pdfLaTeX-compatible
- Look carried by: class (the zip is the class's own source; the sample adds only `\addbibresource`, `booktabs`, `blindtext` and content)
- Class origin: ctan
- Main file: lni-paper-example-de.tex (other samples: lni-author-template.tex; lni.dtx driver is the class manual on `ltxdoc`, not scored)
- Read: main yes, zip-local classes and styles all

## Verdict
The look is carried entirely by one published class. `lni.cls` v2.0 (2025/02/05) is GI's own class, the same version that one read of ctan.org/pkg/lni shows as the current CTAN release (lni.cls:16-18; README.md:4-13), so W1 holds and its internals are not bespoke. The sample's preamble is `\documentclass{lni}`, `\addbibresource`, two published packages, and its body uses only class-native vocabulary plus kernel/published constructs. There is no zip-local macro logic, no `ART`, no `EXTERNAL` blocker. Biber is the ordinary biblatex run step and is the lib's own way `bib.biblatex-biber`, not counted as `EXTERNAL`. This is class-dimension evidence (`Look carried by: class`); see "Bespoke code" for the class-scoped internals that would block under a stricter reading.

## Blockers
none

## Class setting
- Class: `class.lni` options: none in the sample (`\documentclass{lni}`, lni-paper-example-de.tex:5). Available: `english` (lni.cls:44), `anonymous` (75), `crop` (54), `nocleveref` (51), `runningheads` (72), `norunningheads` (default, 82), `nofonts` (57), `oldfonts` (62), deprecated `latin1`/`utf8`/`ansinew` (33-41), `nohyperref` (47, deactivated); every other option goes to `article` (83). Internally `\LoadClass[10pt,twoside,a4paper]{article}` (86), so `class.article` underlies it.
- Class-native vocabulary used: `\title[short]{long}`, `\subtitle`, `\author[affil-nos]{name}{email}{orcid}`, `\affil[n]{lines with \\}`, `\maketitle`, `abstract` env, `keywords` env with `\and`, `\anon[..]{..}`, `\powerset`, `\Cref`/`\Citet`/`\citet` (via `natbib=true`), `lstlisting` with `caption`/`label`/`language`, `\addbibresource`, `\printbibliography`. Defined by the class but not used by the sample: `\lnidoi`, `\authorrunning`, `\booktitle`, `\booksubtitle`, `\editor`, `\yearofpublication`, `\startpage`, `\ie` `\eg` `\cf` `\etal`, `\OMG` `\BPM` `\BPMN` `\BPEL` `\UML`, `\lniabbrv`, `\lniinitialism` (lni.cls:465-474, 632-640, 712-724).
- Engine detail: pdfTeX branch loads `cmap`, `inputenc`, `T1`, `textcomp[full]`, `newtx*` (lni.cls:87-92, 107-122). XeTeX/LuaTeX branch loads `fontspec[no-math]` and `\setmainfont{texgyretermes}` (123-143), `selnolig` for LuaTeX (168-174). README.md:41 recommends pdflatex; lni-author-template.tex:2 says `% !TeX program = pdflatex`. The manifest hint `xelualatex` is only a hint.

## Component map
Rows marked (in class) are what `lni.cls` loads or sets itself; they are the decomposition of `class.lni`, listed so the lib can be compared with it. An emitter only needs `\documentclass[...]{lni}`.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | lni-paper-example-de.tex:5; lni.cls:86 | `class.lni` (over `class.article`) | no options in sample; underlying 10pt, twoside, a4paper |
| paper, size (in class) | lni.cls:86 | `page.class-options` | 10pt, twoside, a4paper |
| page geometry (in class) | lni.cls:236-242 | `page.geometry` | total={12.6cm,19.2cm}, includehead, headheight=20.39pt, headsep=.31cm, centering; `crop` option: paper 15.5cm x 23.5cm, driver=none (193-201) |
| running heads (in class) | lni.cls:82, 665-674 | `hf.fancyhdr` | default `\pagestyle{empty}`; with `runningheads`: RO short title+page, LE page+authors, `\headrulewidth` 0.4pt |
| running-head text (in class) | lni.cls:465-466, 641-664 | `hf.class-native` | `\authorrunning`, `\editor`, `\booktitle`, `\yearofpublication` fill the `plain` style |
| start page number (in class) | lni.cls:632 | `pgnum.pagenumbering` | `\startpage` = `\setcounter{page}` |
| DOI at page foot (in class) | lni.cls:544-553, 243-244 | `bg.eso-pic` | `\AddToShipoutPictureBG*` puts one `\href` text line at 4.2cm/4.3cm; text only, not a drawing; unused in sample |
| title block | lni-paper-example-de.tex:18-26; lni.cls:358-361, 475-555 | `front.class-native` | left-aligned; `\Large\bfseries` title, 9pt, subtitle `\normalsize\bfseries`, 15pt, authors `\normalsize` lineskip .5em, 21pt before abstract |
| authors and affiliations (in class) | lni.cls:362-464 | `front.authblk` | `authblk` underneath; `\Authsep` ", ", `\Authand` und; affiliations as footnotes with email and ORCID |
| author notes (in class) | lni.cls:444-464 | `front.thanks` | `\footnotetext[n]` per `\affil`, footnote counter set to the last affiliation |
| abstract | lni-paper-example-de.tex:28-33; lni.cls:556-559 | `abs.class-native` | `\small`, run-in bold "Abstract:" |
| keywords | lni-paper-example-de.tex:35-37; lni.cls:560-573 | `abs.keywords` | `\small`, bold "Keywords:", `\and` = comma+space, `\vskip -2pt` |
| anonymised review (in class) | lni.cls:73-81, 532-537 | `front.class-native` | `anonymous` option swaps authors for a placeholder; `\anon` colours with `\color{orange}` |
| headings | lni-paper-example-de.tex:39,50,65; lni.cls:574-579 | `head.class-native` | section `\large\bfseries`, before -16pt plus -4pt minus -4pt, after 5pt plus 4pt minus 4pt; subsection `\normalsize\bfseries`, after 8pt plus 4pt minus 4pt; both flush left, `\@startsection` redefinition; `\subsubsection` stays `article`'s |
| section numbering | lni.cls:86 | `num.secnumdepth` | article default, unchanged by the class |
| paragraph spacing (in class) | lni.cls:609-610 | `sp.lengths` | `\parindent` 0pt, `\parskip` 8pt |
| size commands (in class) | lni.cls:246-258 | `font.size-commands` | `\small` = 9pt/10pt with display skips and `\@listi` reset; `\Large` 14/17 |
| line breaking (in class) | lni.cls:745-755 | `sp.hyphenat` | `\tolerance` 1414, `\hbadness` 1414, `\emergencystretch` 1.5em, `\hfuzz` 0.3pt, `\vfuzz`; same family as `\sloppy`; `\frenchspacing` rides in the class with no separate way |
| penalties (in class) | lni.cls:750-754 | `sp.penalties` | widow 10000, displaywidow 10000, club 9999, interfootnoteline 9999, broken 2000 |
| bottom of page (in class) | lni.cls:756 | `pg.flush` | `\raggedbottom` |
| microtype (in class) | lni.cls:158-167, 176 | `sp.microtype` | final, tracking=smallcaps, expansion=alltext, protrusion=alltext-nott; `\SetTracking{encoding=*,shape=sc}{50}` |
| text fonts, pdfTeX (in class) | lni.cls:107-122 | `font.newtx` | `newtxtext[defaultsups]`, `newtxmath`; fallback `mathptmx` (`font.mathptmx`, 145-146) |
| monospace (in class) | lni.cls:112 | `font.mono` | `newtxtt[zerostyle=b,scaled=.9]` |
| encodings (in class) | lni.cls:87-92 | `font.fontenc-t1` | `cmap`, `inputenc`, `fontenc[T1]`, `textcomp[full]` |
| text fonts, Xe/Lua (in class) | lni.cls:123-143 | `font.fontspec` | `no-math`; `\setmainfont{texgyretermes}` with `.otf` file names, `Ligatures=TeX` |
| language (in class) | lni.cls:93-101, 618-631 | `lang.babel` | `english,ngerman` (reversed for `english` option), `ngerman-x-latest` hyphenation, `"` shorthands; caption names Abb., Tab., List., Literaturverzeichnis |
| quotes (in class) | lni.cls:259 | `lang.csquotes` | `autostyle` |
| maths (in class) | lni.cls:85, 278, 601 | `math.amsmath` | `fleqn` passed to amsmath |
| equation indent (in class) | lni.cls:601 | `math.eqnumber` | `\mathindent` 0.5cm (fleqn) |
| equations in sample | lni-paper-example-de.tex:140-147 | `math.amsmath` | `equation`, `align` |
| power-set symbol | lni-paper-example-de.tex:52; lni.cls:177-188 | `class.lni` | class-native `\powerset`: kernel `\DeclareMathSymbol` on the MnSymbol font files (TeX Live `mnsymbol`, not shipped) |
| lists (in class) | lni.cls:285, 611-616 | `list.enumitem` | `\setlist` topsep=0pt, itemsep=7pt, parsep=-2pt, leftmargin=*; itemize labelsep=0.70cm, level 1 `$\bullet$`; enumerate labelsep=0.60cm, level 2 `\alph*)`; level 2 topsep=9pt; unused in sample |
| footnotes (in class) | lni.cls:286-328, 604-608 | `fn.footmisc` | `hang`, `\footnotemargin` 1em, `\footnotesize`; rule 5cm wide (`\footnoterule`) |
| footnote rule (in class) | lni.cls:605-608 | `sp.rule` | `\hrule\@width 5cm`, kerns -3pt and 2.6pt |
| figure | lni-paper-example-de.tex:80-85 | `fig.graphicx` | `\centering`, `\includegraphics[width=.8\textwidth]`, `\label` |
| float placement (in class) | lni.cls:585-598 | `fig.placement` | `htbp` default for figure and table, `topnumber` 10, `bottomnumber` 10, `topfraction` 1.0, `bottomfraction` 1.0, `\intextsep` 6pt |
| float contents size (in class) | lni.cls:588-593 | `font.size-commands` | `\@floatboxreset` adds `\small` inside floats |
| captions | lni-paper-example-de.tex:83,101; lni.cls:580-587, 599 | `cap.caption` | `style=base`; figure skip=4pt, table skip=6pt, font=`\oldsmall`; lstlisting skip=6pt, font=`\small`; label "Abb. 1"; caption below in the sample (`\caption` is `cap.kernel`) |
| table | lni-paper-example-de.tex:90-103; lni.cls:600 | `tbl.tabular` | `lll`, `\arraystretch` 1.1 (class) |
| table rules | lni-paper-example-de.tex:9,93-99 | `tbl.booktabs` | `\toprule`, `\midrule`, `\bottomrule` |
| verbatim | lni-paper-example-de.tex:109-115; lni.cls:602-603 | `code.verbatim` | class indents every line by 0.5cm (`\verbatim@processline` redefinition, see Bespoke code) |
| listings | lni-paper-example-de.tex:121-133; lni.cls:284, 329-335 | `code.listings` | `\lstset` basicstyle=`\ttfamily`, columns=fixed, basewidth=.5em, xleftmargin=0.5cm, captionpos=b, upquote; language=Java and Python, caption, label per listing |
| cross-references | lni-paper-example-de.tex:47,48,78,119; lni.cls:694-710 | `xref.cleveref` | loaded at end of preamble; `ngerman,nameinlink` (English: `capitalise,nameinlink`); `\crefname`/`\Crefname` for section (English "Sect."), figure, table, listing from the caption names |
| labels | lni-paper-example-de.tex:51,63,84 | `xref.kernel` | `\label` |
| hyperlinks and metadata (in class) | lni.cls:679-692 | `meta.hyperref` | `AddToHook{env/document/begin}`: `bookmarks=false`, `pdfdisplaydoctitle`, `colorlinks`, `allcolors=black`, `pdfstartview=Fit`; `hypcap[all]` rides with it, plus `orcidlink` |
| urls | lni-paper-example-de.tex:40; lni.cls:675-677, 467-469 | `meta.url` | `url`, `\urlstyle{same}`, `\UrlBreaks`+`\UrlOrds`; `\email` is `\href{mailto:}` |
| bibliography | lni-paper-example-de.tex:6,66-70,150; lni.cls:260-277 | `bib.biblatex-biber` | `backend=biber`, `date=year`, `style=LNI` (CTAN `biblatex-lni`), `natbib=true`; `\citeauthor` redeclared with `bibhyperref` |
| old bibliography list (in class) | lni.cls:725-744 | `bib.thebibliography` | `thebibliography` re-defined with `\small`, club/widow penalty 4000; not reached by `\printbibliography` |
| contents lines (in class) | lni.cls:338-357 | `toc.kernel` | `\@dottedtocline` redefined, `\@pnumwidth` 3em, `\@tocrmarg` 3.5em; the sample prints no contents |
| colour of `\anon` (in class) | lni.cls:78 | `color.color` | `\color{orange}` |
| inline marks | lni-paper-example-de.tex:29,41 | `mark.kernel` | `\texttt`, `\LaTeX` |

## Bespoke code
No zip-local construct is counted: `lni.cls` is the published class (CTAN v2.0, 2025/02/05; the code in `lni.dtx:667-1594` matches `lni.cls:16-756` line for line, checked by a text diff after dropping comments). The sample defines no macro of its own. Class-scoped internals below are listed only so the result can be re-read if the class were treated as zip-local.

| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\@maketitle`, `\maketitle` | lni.cls:475-555 | n/a (published class); would be irreducible, kernel internals | `class.lni` carries it |
| `\author`, `\affil`, `\multiaffil` over `authblk` internals | lni.cls:362-464 | n/a; would be irreducible (token-list code on `\AB@*`) | `class.lni` carries it |
| `\@makefntext` copy of `footmisc` | lni.cls:288-328 | n/a; would be irreducible | `fn.footmisc` with `hang` plus `\footnotemargin` covers the effect only approximately |
| `\@dottedtocline` | lni.cls:340-357 | n/a; unused in sample | `toc.tocloft` would cover the look |
| `\verbatim@processline` | lni.cls:602-603 | n/a; reducible | `fancyvrb` indent `xleftmargin=0.5cm` (`code.verbatim`) |
| `\CROP@@info` | lni.cls:203-232 | n/a; only under option `crop`, unused | none needed |
| `\@clearglobaloption`, font and hyphenation probes with `\IfFileExists` | lni.cls:20-32, 102-144 | n/a | option handling, not typesetting |
| `\newcommand` aliases `\ie \eg \cf \etal \OMG ...`, `\lniabbrv`, `\lniinitialism` | lni.cls:712-724 | reducible | `\textsc`/`\xspace` text macros; unused in sample |
| `\powerset` | lni.cls:177-188 | reducible | kernel `\DeclareMathSymbol` on MnSymbol fonts |

## Content-opaque
- `blindtext` filler text (`\blindtext`, lni-paper-example-de.tex:12,60): published placeholder text, content only.
- `example-image` (lni-paper-example-de.tex:82): image from TeX Live `mwe`, not shipped; artwork inside a figure.
- German body text, the `lstlisting` and `verbatim` code text, equation text, bib entries (lni-paper-example-de.bib): content.

## Lib changes
- New ways proposed: none. Notes for the lib owner: class-loaded helpers with no lib way and no need for one while `class.lni` carries them: `orcidlink` (ORCID icon link in `\author`, lni.cls:690), `hypcap` (lni.cls:691), `grffile`, `cmap`, `xspace`, `iftex`, `etoolbox`, `selnolig`, `crop`. `orcidlink` would matter for a template that is not class-carried. Mapping choices a reviewer may want to revisit: line-breaking tolerances put under `sp.hyphenat` (same family as `\sloppy`); `\powerset` put under `class.lni`.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
