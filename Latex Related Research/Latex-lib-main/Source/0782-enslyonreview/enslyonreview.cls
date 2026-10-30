%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  enslyonreview.cls  —  Bibliographic review class for ENS de Lyon Biosciences
%  Version 1.1  (2026-09-10)
%
%  Copyright (C) 2026  Adama Mbaye
%  SPDX-License-Identifier: LPPL-1.3c
%
%  This work may be distributed and/or modified under the conditions of
%  the LaTeX Project Public License, either version 1.3c of this license
%  or (at your option) any later version.
%  The latest version of this license is in:
%    https://www.latex-project.org/lppl/lppl-1-3c/
%  and version 1.3c or later is part of all distributions of LaTeX
%  version 2008 or later.
%
%  This work has the LPPL maintenance status `maintained'.
%  The Current Maintainer of this work is Adama Mbaye.
%
%  Reproduces, in LaTeX, the "Analyse bibliographique" M2 Biosciences review
%  format (Current Opinion style) whose reference implementation is the
%  LibreOffice template review_M2.ott supplied by F. Roudier. Companion
%  sibling package to enslyonstage (M1/M2 internship reports) — see that
%  class's README for the CTAN-package layout this one follows too:
%  <name>.cls + <name>-gabarit.tex (blank) + <name>-exemple.tex (worked
%  example) + <name>.tex/.pdf (user guide) + README + LICENSE.
%
%  Usage:
%    \documentclass{enslyonreview}                % official theme (default)
%    \documentclass[blue]{enslyonreview}           % named theme
%    \documentclass[palatino]{enslyonreview}       % Palatino instead of newtx
%    \documentclass[xcharter]{enslyonreview}       % Charter instead of newtx
%    \documentclass[stix]{enslyonreview}           % STIX Two instead of newtx
%
%  Available themes (23): see README.md — same palette as enslyonstage,
%  plus "orangeens" for the ENS de Lyon institutional orange.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{enslyonreview}[2026/09/10 v1.1 ENS de Lyon Biosciences Bibliographic Review]


%===============================================================================
%  1. THEME OPTIONS
%===============================================================================
%  Same 22-palette mechanism as enslyonstage.cls (plus one extra palette,
%  "orangeens", not in enslyonstage), so students who already used that
%  class for their internship report feel at home immediately: pass a
%  colour name as a class option and every rule/heading/background in the
%  document switches to match. Default is "orange", matching the peach/rust
%  official colours of review_M2.ott — the actual palette definitions
%  (\ENS@pal@<name>) live further down, once xcolor is loaded.
%-------------------------------------------------------------------------------

% \@theme holds the *name* chosen at \documentclass time (a plain string);
% the corresponding \ENS@pal@<name> macro is looked up and executed later,
% inside \AtBeginDocument, once xcolor's \definecolor is available.
\newcommand{\@theme}{orange}

\DeclareOption{orange}  {\renewcommand{\@theme}{orange}}
% "orange" (default) is review_M2.ott's own rust/peach branding, chosen by
% F. Roudier for this specific template — NOT the ENS de Lyon institutional
% orange. "orangeens" gives that official ENS orange instead (same hex as
% enslyonstage's default theme), for anyone who wants the school's brand
% colour rather than the template's own one.
\DeclareOption{orangeens}{\renewcommand{\@theme}{orangeens}}
\DeclareOption{violet}  {\renewcommand{\@theme}{violet}}
\DeclareOption{blue}    {\renewcommand{\@theme}{blue}}
\DeclareOption{red}     {\renewcommand{\@theme}{red}}
\DeclareOption{green}   {\renewcommand{\@theme}{green}}
\DeclareOption{teal}    {\renewcommand{\@theme}{teal}}
\DeclareOption{gray}    {\renewcommand{\@theme}{gray}}
\DeclareOption{navy}    {\renewcommand{\@theme}{navy}}
\DeclareOption{indigo}  {\renewcommand{\@theme}{indigo}}
\DeclareOption{purple}  {\renewcommand{\@theme}{purple}}
\DeclareOption{pink}    {\renewcommand{\@theme}{pink}}
\DeclareOption{crimson} {\renewcommand{\@theme}{crimson}}
\DeclareOption{amber}   {\renewcommand{\@theme}{amber}}
\DeclareOption{gold}    {\renewcommand{\@theme}{gold}}
\DeclareOption{lime}    {\renewcommand{\@theme}{lime}}
\DeclareOption{forest}  {\renewcommand{\@theme}{forest}}
\DeclareOption{cyan}    {\renewcommand{\@theme}{cyan}}
\DeclareOption{azure}   {\renewcommand{\@theme}{azure}}
\DeclareOption{slate}   {\renewcommand{\@theme}{slate}}
\DeclareOption{brown}   {\renewcommand{\@theme}{brown}}
\DeclareOption{wine}    {\renewcommand{\@theme}{wine}}
\DeclareOption{midnight}{\renewcommand{\@theme}{midnight}}

% --- Font option --------------------------------------------------------
% Default body font is newtx (Times New Roman metrics, matching the .ott).
% Three alternatives switch the whole document (text + math, including
% small caps for author surnames, section 6) to a different, still
% properly math-equipped academic serif — an escape hatch in case newtx
% ever renders badly on a given TeX installation, or simply a matter of
% taste, without anyone having to touch the class itself. All three were
% verified (text + \textsc{} small caps + real math: integrals, greek,
% \mathbb, \mathcal) before being added here; a fourth candidate
% (Libertinus) was tried and dropped — its \mathcal glyph came up blank
% with the T1/pdfLaTeX math companion available at the time of writing.
%   palatino  — mathpazo (Palatino)
%   xcharter  — xcharter (Charter, a clean, very legible book serif)
%   stix      — stix2 (STIX Two, designed by/for the STIX Fonts
%               consortium of AMS/APS/Elsevier/IEEE/etc. specifically for
%               scientific publishing — its math italic looks noticeably
%               different from the other options, by design)
\newif\if@ENSpazofont
\newif\if@ENSxcharterfont
\newif\if@ENSstixfont
\DeclareOption{palatino}{\@ENSpazofonttrue}
\DeclareOption{xcharter}{\@ENSxcharterfonttrue}
\DeclareOption{stix}    {\@ENSstixfonttrue}

% Anything that isn't a theme/font name (10pt, twoside, ...) is simply
% forwarded to the base article class instead of raising an "unused
% option" error.
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax


%===============================================================================
%  2. BASE CLASS
%===============================================================================
%  Loaded twocolumn from the very start. The title block defined further down
%  (\maketitle) then uses the classic \twocolumn[...] trick — LaTeX flushes
%  the current page and typesets the bracketed material across the *full*
%  page width before resuming normal two-column flow — so the title, authors,
%  affiliation/date band, keywords and abstract span both columns on page 1
%  without needing a separate "cover page" mechanism.
%-------------------------------------------------------------------------------

\LoadClass[12pt,twocolumn,a4paper]{article}


%===============================================================================
%  3. REQUIRED PACKAGES
%===============================================================================
%  Grouped by purpose and loaded in an order that matters in a few places
%  (noted inline): fonts before geometry, hyperref quite late, cleveref
%  strictly after hyperref, biblatex strictly after cleveref.
%-------------------------------------------------------------------------------

% Conditional logic and calculations, used by a couple of the box-width
% helpers further down (\dimexpr alone would do, \calc reads more clearly).
\RequirePackage{ifthen}
\RequirePackage{calc}

% Mathematics support (the review format itself is text-heavy, but students
% inevitably need the odd inline formula, e.g. rate constants or p-values).
\RequirePackage{amsmath,amsfonts,amssymb}

% Graphics handling. Default search path covers a project-local figures/
% folder first, then the current directory, so \includegraphics{myplot}
% just works without a full path.
\RequirePackage{graphicx}
\graphicspath{{figures/}{./}}

% Colour support. The [table] option pulls in colortbl, which is what makes
% \rowcolor{...} available for the shaded table header row in Table 1-style
% summaries — plain xcolor alone doesn't provide it.
\RequirePackage[table]{xcolor}

% Character encoding and fonts.
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
% newtx reproduces real Times New Roman metrics far more closely than the
% older mathptmx (URW Nimbus Roman): matches the .ott's declared font and
% keeps line/page breaks closer to the reference PDF at the same point
% size. The three class options from section 1 swap it for a different
% academic serif instead — same T1/small-caps support in all four, nothing
% else in the class depends on which one is active.
\if@ENSpazofont
  \RequirePackage{mathpazo}
\else\if@ENSxcharterfont
  \RequirePackage{xcharter}
\else\if@ENSstixfont
  \RequirePackage{stix2}
\else
  \RequirePackage{newtxtext}
  \RequirePackage{newtxmath}
\fi\fi\fi
% Helvetica — the standard PostScript stand-in for Arial under pdfLaTeX
% (no Arial itself without fontspec+XeLaTeX/LuaLaTeX). \sffamily switches
% to it; only the header/footer bars use it, body text stays newtx Times.
\RequirePackage{helvet}
\RequirePackage[english]{babel}
\RequirePackage{csquotes}

% Page geometry — A4, narrow-ish margins for a dense two-column scientific
% layout. headheight/headsep/footskip are tuned to fit the coloured
% header/footer bars defined later without LaTeX complaining about
% "\headheight too small" or clipping the bar against the body text.
\RequirePackage[
  left=1.6cm, right=1.6cm, top=2.2cm, bottom=2.2cm,
  headheight=28pt, headsep=10pt, footskip=22pt,
  columnsep=0.7cm,
  a4paper
]{geometry}

% Caption formatting: bold, theme-coloured "Figure N." / "Table N." / "Box N."
% label, small font, period after the label instead of a colon — matches the
% look of Figure/Table/Box captions in the source review.
\RequirePackage[
  font=small,
  labelfont={bf,color=colorMain},
  labelsep=period,
  justification=justified
]{caption}

% Running header/footer (fancyhdr) and the "N / total" page count it needs
% (lastpage, via \pageref{LastPage}).
\RequirePackage{fancyhdr}
\RequirePackage{lastpage}

% Section heading styling (titlesec, [explicit] so #1 in \titleformat can be
% placed and coloured freely) and list styling (enumitem).
\RequirePackage[explicit]{titlesec}
% LaTeX suppresses the paragraph indent right after a sectioning command by
% default (\@afterindentfalse) — indentfirst is the standard one-line fix,
% so the first paragraph of every section/subsection indents exactly like
% every other paragraph in the source review. Must load AFTER titlesec:
% titlesec's own \@startsection replacement re-asserts \@afterindentfalse,
% so indentfirst's patch has no effect if loaded before it.
\RequirePackage{indentfirst}
\RequirePackage{enumitem}

% etoolbox: \csdef/\csuse/\ifcsundef/\ifdefstring power the
% \refspecialinterest / \refoutstandinginterest bibliography-annotation
% mechanism further down.
\RequirePackage{etoolbox}

% Table support: booktabs for clean horizontal rules where a student wants
% that look, tabularx for width-flexible columns, multirow for a category
% label spanning several rows (as in the disease-driver summary table).
\RequirePackage{booktabs}
\RequirePackage{tabularx}
\RequirePackage{multirow}

% ragged2e's \justifying: used in table cells (p{}/X columns) to get
% properly justified, hyphenated text instead of the ragged look plain
% array/tabularx columns fall back to at narrow widths.
\RequirePackage{ragged2e}

% float powers the custom "reviewbox" float type registered below (Box N.
% callouts); stfloats lets its starred, two-column-wide variant — and
% figure*/table* — settle at the bottom of a column, not just the top,
% which plain LaTeX twocolumn floats can't do on their own.
\RequirePackage{float}
\RequirePackage{stfloats}

% \balance — call it right before \end{document} (after the bibliography)
% to even out the two columns on the last page, instead of leaving one
% column noticeably shorter than the other. Optional: nothing breaks if a
% review never calls it, the class just makes the command available.
\RequirePackage{balance}

% Chemical formulas and physical units/quantities — occasionally useful in
% a biology review (\ce{}, \SI{}), cheap to load even if a given review
% never touches them.
\RequirePackage[version=4]{mhchem}
\RequirePackage{siunitx}

% Hyperlinks. hidelinks avoids ugly coloured boxes around every link by
% default; the real colours are switched on in \AtBeginDocument below, once
% the chosen theme's colours actually exist.
\RequirePackage[hidelinks,unicode,breaklinks]{hyperref}

% cleveref — smart, clickable cross-references (\cref{fig:x} instead of
% "Fig.~\ref{fig:x}" typed by hand). Must load strictly after hyperref;
% biblatex, loaded next, wants to load after cleveref too, so this is the
% only valid position for it.
\RequirePackage[capitalise,noabbrev]{cleveref}
\crefname{figure}{Fig.}{Figs.}
\crefname{table}{Table}{Tables}
\crefname{reviewbox}{Box}{Boxes}
\Crefname{figure}{Figure}{Figures}
\Crefname{table}{Table}{Tables}
\Crefname{reviewbox}{Box}{Boxes}

% Bold, theme-coloured cross-references — \crefcolor{fig:x} instead of
% \cref{fig:x} when you want "Fig. 1" to stand out the same way the
% citation brackets do (matching \mkbibbrackets further down). Plain
% \cref/\Cref remain available too, in the ordinary link colour, for
% anywhere a quieter reference reads better.
\newcommand{\crefcolor}[1]{\textbf{\textcolor{colorMain}{\cref{#1}}}}
\newcommand{\Crefcolor}[1]{\textbf{\textcolor{colorMain}{\Cref{#1}}}}

% BIBLATEX — real, clickable, auto-numbered citations from a .bib file,
% formatted to match the Current Opinion w/ DOI/PMID/PMCID Zotero style:
%   N. Surname II, Surname II, ..., Surname II: Title. Journal Year, Vol:pages.
%   [doi: ...] [PMID: ...] [PMCID: ...]
%   • or •• annotation, if that reference was flagged with \refspecialinterest
%     or \refoutstandinginterest (see further down).
% numeric-comp + sorting=none: citations are numbered by first appearance in
% the text, and consecutive runs compress to "[8-10]" — exactly the
% behaviour of the source .csl style. maxbibnames/minbibnames=10 matches the
% "et al." truncation point observed in the reference material.
\RequirePackage[
  style=numeric-comp,
  sorting=none,
  backend=biber,
  datamodel=enslyonreview,   % pulls in enslyonreview.dbx — see below
  maxbibnames=10,
  minbibnames=10,
  maxcitenames=2,
  mincitenames=1,
  giveninits=true,
  uniquename=false,
  uniquelist=false,
  doi=false, isbn=false, url=false, eprint=false
]{biblatex}

\flushbottom  % keep both columns the same height on every page, as in the source


%===============================================================================
%  4. BIBLIOGRAPHY FORMATTING
%===============================================================================
%  Everything below customises how biblatex renders names, fields and the
%  bibliography heading — the actual per-entry driver is the last piece.
%-------------------------------------------------------------------------------

% \bibfont is biblatex's dedicated hook for the font of the ENTIRE printed
% list (applied by \printbibliography itself, wrapping every entry) — a
% 50-reference list at full body-text size runs noticeably longer than the
% source review, \small brings it back in line, matching the legacy
% \references environment (section 12), which is already \small too.
\renewcommand*{\bibfont}{\footnotesize}

% --- Initials: no periods, no separating space -------------------------------
% Target look: "Blanco-Melo D, Venkatesh S, Bieniasz PD" — i.e. "PD" as one
% tight unit, not "P.\,D.". Two independent things make this work:
%   1. Real full given names ("Daniel", "Paul D.") get reduced to initials
%      automatically by biblatex's own algorithm once giveninits=true above
%      is set — nothing to do for those.
%   2. Names that arrive from Zotero/PubMed *already* abbreviated (just the
%      bare letters, e.g. author = {Bieniasz, P D}) need the two letters
%      written SPACE-separated in the .bib for biber to see them as two
%      initials to begin with — {PD} or {P.D.} both collapse to just "P".
% \bibinitperiod/\bibinitdelim strip the period and the inter-letter space
% that biblatex would otherwise insert once the initials are known.
\renewcommand*{\bibinitperiod}{}
\renewcommand*{\bibinitdelim}{}
\renewcommand*{\bibinithyphendelim}{\mbox{-}}  % "J-L" not "J.-L" for hyphenated initials

% Custom fields (pmid, pmcid, interest, interestnote) are declared in the
% companion enslyonreview.dbx file, loaded above via datamodel=enslyonreview.
% They CANNOT be declared here with \DeclareDatamodelFields: biblatex only
% accepts that macro while it is still loading itself (an \AtEndOfPackage
% hook locks it immediately afterwards, with a "cannot be used in preamble"
% warning if you try) — hence the separate .dbx file, which biblatex loads
% at exactly the right moment via the datamodel= option above.

% --- Name order: "Surname Initials", every author, no "and" ------------------
% \DeclareNameAlias reuses biblatex's own well-tested "family-given" name
% format rather than hand-rolling one from scratch — that keeps the
% surrounding et-al/delimiter machinery (maxbibnames, "and others", ...)
% working exactly as documented. The only thing patched away is
% \revsdnamepunct, the single macro responsible for inserting a comma
% between family and given name in that format (we want "Bieniasz PD", not
% "Bieniasz, PD"). \multinamedelim/\finalnamedelim then control the
% delimiter BETWEEN different authors — comma + space, with no "and"/"&"
% even before the very last name in the list, matching the source style.
\DeclareNameAlias{default}{family-given}
\renewcommand*{\revsdnamepunct}{}
\renewcommand*{\multinamedelim}{\addcomma\space}
\renewcommand*{\finalnamedelim}{\addcomma\space}

% --- "Of special/outstanding interest" annotations, keyed by citekey --------
% A plain Zotero "Export → BibTeX" won't carry custom interest/interestnote
% fields, and re-exporting later would silently wipe them again if they had
% been hand-added to the .bib in the meantime. So the annotation is instead
% declared from the .tex itself — anywhere before \printbibliography, e.g.
% right under \addbibresource — and looked up by citation key at print time:
%
%   \refspecialinterest{citekey}{Why this paper matters.}      %  • of special interest
%   \refoutstandinginterest{citekey}{Why this paper matters.}  % •• of outstanding interest
%
% (A .bib entry with interest={special|outstanding} + interestnote={...}
% still works too, as a fallback, for anyone who prefers editing the .bib
% directly and doesn't mind re-adding it after every Zotero re-export.)

% Store: two macros per citekey, \ENS@interest@<key> and
% \ENS@interestnote@<key>, created on demand by \csdef.
\newcommand{\refspecialinterest}[2]{%
  \csdef{ENS@interest@#1}{special}%
  \csdef{ENS@interestnote@#1}{#2}%
}
\newcommand{\refoutstandinginterest}[2]{%
  \csdef{ENS@interest@#1}{outstanding}%
  \csdef{ENS@interestnote@#1}{#2}%
}

% Lookup: called from inside the bibliography driver, where \thefield{entrykey}
% gives the citekey of the entry currently being printed. Falls back to the
% .bib's own interest/interestnote fields if no \refspecialinterest/
% \refoutstandinginterest call registered anything for this key.
\newcommand{\ENS@interestlevel}{%
  \ifcsundef{ENS@interest@\thefield{entrykey}}%
    {\thefield{interest}}%
    {\csuse{ENS@interest@\thefield{entrykey}}}%
}
\newcommand{\ENS@interestnotetext}{%
  \ifcsundef{ENS@interestnote@\thefield{entrykey}}%
    {\thefield{interestnote}}%
    {\csuse{ENS@interestnote@\thefield{entrykey}}}%
}

% --- Citation numbers: bold, theme-coloured -----------------------------
% \mkbibbrackets wraps every "[N]" / "[8-10]" in-text citation and the
% numeric label in front of each entry in the printed bibliography — both
% pick up the theme colour and bold weight from this one override.
\renewcommand*{\mkbibbrackets}[1]{\textbf{\textcolor{colorMain}{[#1]}}}

% --- The bibliography entry driver -------------------------------------------
% Reproduces, field by field, the exact "N. Author, Author: Title. Journal
% Year, Vol:pages. [doi: ...] [PMID: ...] [PMCID: ...]" format above, plus
% the optional •/•• annotation paragraph.
%
% \thefield (raw field value) is used throughout instead of \printfield,
% because \printfield also runs numeric-comp's own default formatting hooks
% for each field — hooks we don't want here: they'd wrap the title in curly
% quotes, prefix pages with "pp.", and prefix the DOI with "DOI:" in a
% monospace font. \thefield sidesteps all of that and gives the plain value.
\DeclareBibliographyDriver{article}{%
  \usebibmacro{bibindex}%
  \printnames{author}%
  \addcolon\space
  \textbf{\thefield{title}}%
  \addperiod\space
  \textit{\thefield{journaltitle}}\space
  \thefield{year}\addcomma\space
  \textbf{\thefield{volume}}%
  \iffieldundef{pages}{}{\addcolon\thefield{pages}}%
  \addperiod%
  % Each identifier is a clickable link to its canonical resolver — doi.org,
  % PubMed, PubMed Central — not just plain text, using hyperref's \href
  % (already loaded). The visible text is still the plain identifier; only
  % the link target carries the full URL.
  \iffieldundef{doi}{}{\space[doi:\space\href{https://doi.org/\thefield{doi}}{\thefield{doi}}]}%
  \iffieldundef{pmid}{}{\space[PMID:\space\href{https://pubmed.ncbi.nlm.nih.gov/\thefield{pmid}/}{\thefield{pmid}}]}%
  \iffieldundef{pmcid}{}{\space[PMCID:\space\href{https://www.ncbi.nlm.nih.gov/pmc/articles/\thefield{pmcid}/}{\thefield{pmcid}}]}%
  % \ifdefstring compares a macro's *stored definition* (via \meaning), not
  % its expanded runtime value — so \ENS@interestlevel (itself a small
  % \ifcsundef{...}{...}{...} conditional) needs a full \edef first, to
  % actually resolve down to the plain string "special"/"outstanding"/empty
  % before the comparison can see it. Skipping this step is a classic silent
  % failure: the lookup works, the \ifdefstring test just never fires.
  \edef\ENS@currentlevel{\ENS@interestlevel}%
  \ifdefstring{\ENS@currentlevel}{special}%
    {\par\noindent\textbullet\space\textit{\ENS@interestnotetext}}{}%
  \ifdefstring{\ENS@currentlevel}{outstanding}%
    {\par\noindent\textbullet\textbullet\space\textit{\ENS@interestnotetext}}{}%
  \finentry%
}

% --- Bibliography heading and the "highlighted as" legend --------------------
% Toggle shared by the biblatex heading below and the legacy manual
% \references environment further down (\noreflegend turns the legend off
% in either case).
\newif\if@ENSreviewlegend
\@ENSreviewlegendtrue
\newcommand{\noreflegend}{\@ENSreviewlegendfalse}

% Default title text — override per call with, e.g.,
% \printbibliography[title=References] for a shorter house style.
\DefineBibliographyStrings{english}{bibliography={References and recommended reading}}
\defbibheading{bibliography}{%
  \section*{#1}%
  \if@ENSreviewlegend
    \noindent Papers of particular interest have been highlighted as:\\
    \textbullet\ of special interest\\
    \textbullet\textbullet\ of outstanding interest
    \vspace{4pt}\par
  \fi
}


%===============================================================================
%  5. COLOUR THEMES
%===============================================================================
%  22 palettes, ported verbatim from enslyonstage.cls so both classes always
%  look like they belong to the same family. "orange" is retuned to match
%  review_M2.ott's actual rust/peach branding rather than enslyonstage's own
%  orange — which is instead kept available here as its own separate
%  palette, "orangeens" (23rd), for anyone who wants the ENS de Lyon
%  institutional colour specifically. Each palette defines exactly three
%  colours:
%    colorMain   — titles, section headings, header/footer bars, rules
%    colorAccent — links, secondary decoration (currently under-used, kept
%                  for parity with enslyonstage and for future extensions)
%    colorBg     — the affiliation/date metadata band background
%  The selected palette is only *applied* later, inside \AtBeginDocument
%  (search for \ENS@pal@\@theme below) — defining all 23 unconditionally
%  here is cheap and keeps the option-handling logic in section 1 simple.
%-------------------------------------------------------------------------------

\def\ENS@pal@orange  {\definecolor{colorMain}  {HTML}{B74600}%  review_M2.ott rust/orange
                       \definecolor{colorAccent}{HTML}{E07820}%
                       \definecolor{colorBg}    {HTML}{FFCC99}}%  review_M2.ott peach

\def\ENS@pal@orangeens{\definecolor{colorMain}  {HTML}{E14D17}%  official ENS de Lyon orange (enslyonstage default)
                       \definecolor{colorAccent}{HTML}{ED7C50}%
                       \definecolor{colorBg}    {HTML}{FBD5C0}}

\def\ENS@pal@violet  {\definecolor{colorMain}  {HTML}{652080}%
                       \definecolor{colorAccent}{HTML}{9B4DB8}%
                       \definecolor{colorBg}    {HTML}{E3D3EE}}

\def\ENS@pal@blue    {\definecolor{colorMain}  {HTML}{1A5C9E}%
                       \definecolor{colorAccent}{HTML}{3A82C4}%
                       \definecolor{colorBg}    {HTML}{CFE3F5}}

\def\ENS@pal@red     {\definecolor{colorMain}  {HTML}{A62020}%
                       \definecolor{colorAccent}{HTML}{CC3333}%
                       \definecolor{colorBg}    {HTML}{F3CFCF}}

\def\ENS@pal@green   {\definecolor{colorMain}  {HTML}{1E6B3A}%
                       \definecolor{colorAccent}{HTML}{2E9955}%
                       \definecolor{colorBg}    {HTML}{D2EBDA}}

\def\ENS@pal@teal    {\definecolor{colorMain}  {HTML}{0E6B6B}%
                       \definecolor{colorAccent}{HTML}{1A9999}%
                       \definecolor{colorBg}    {HTML}{CDEBEB}}

\def\ENS@pal@gray    {\definecolor{colorMain}  {HTML}{3A3A3A}%
                       \definecolor{colorAccent}{HTML}{666666}%
                       \definecolor{colorBg}    {HTML}{DCDCDC}}

\def\ENS@pal@navy    {\definecolor{colorMain}  {HTML}{0D3B6E}%
                       \definecolor{colorAccent}{HTML}{1E5A9C}%
                       \definecolor{colorBg}    {HTML}{CFE0F5}}

\def\ENS@pal@azure   {\definecolor{colorMain}  {HTML}{1D4ED8}%
                       \definecolor{colorAccent}{HTML}{2563EB}%
                       \definecolor{colorBg}    {HTML}{D4E3FE}}

\def\ENS@pal@indigo  {\definecolor{colorMain}  {HTML}{3730A3}%
                       \definecolor{colorAccent}{HTML}{4F46E5}%
                       \definecolor{colorBg}    {HTML}{DAD9FB}}

\def\ENS@pal@midnight{\definecolor{colorMain}  {HTML}{1E2D5C}%
                       \definecolor{colorAccent}{HTML}{2A3D80}%
                       \definecolor{colorBg}    {HTML}{D2DAF0}}

\def\ENS@pal@slate   {\definecolor{colorMain}  {HTML}{334155}%
                       \definecolor{colorAccent}{HTML}{475569}%
                       \definecolor{colorBg}    {HTML}{DCE3EB}}

\def\ENS@pal@purple  {\definecolor{colorMain}  {HTML}{5B21B6}%
                       \definecolor{colorAccent}{HTML}{7C3AED}%
                       \definecolor{colorBg}    {HTML}{E1D3FB}}

\def\ENS@pal@pink    {\definecolor{colorMain}  {HTML}{9D174D}%
                       \definecolor{colorAccent}{HTML}{BE185D}%
                       \definecolor{colorBg}    {HTML}{F6D2E4}}

\def\ENS@pal@crimson {\definecolor{colorMain}  {HTML}{881337}%
                       \definecolor{colorAccent}{HTML}{A62153}%
                       \definecolor{colorBg}    {HTML}{F2D0DC}}

\def\ENS@pal@wine    {\definecolor{colorMain}  {HTML}{63152D}%
                       \definecolor{colorAccent}{HTML}{881F3D}%
                       \definecolor{colorBg}    {HTML}{F0D2DD}}

\def\ENS@pal@amber   {\definecolor{colorMain}  {HTML}{92400E}%
                       \definecolor{colorAccent}{HTML}{B45309}%
                       \definecolor{colorBg}    {HTML}{FBE3BE}}

\def\ENS@pal@gold    {\definecolor{colorMain}  {HTML}{7A5300}%
                       \definecolor{colorAccent}{HTML}{9A6C00}%
                       \definecolor{colorBg}    {HTML}{F7E7A6}}

\def\ENS@pal@brown   {\definecolor{colorMain}  {HTML}{5C2D0E}%
                       \definecolor{colorAccent}{HTML}{7C4015}%
                       \definecolor{colorBg}    {HTML}{E9D2BE}}

\def\ENS@pal@lime    {\definecolor{colorMain}  {HTML}{365314}%
                       \definecolor{colorAccent}{HTML}{4D7A1B}%
                       \definecolor{colorBg}    {HTML}{DDEBBE}}

\def\ENS@pal@forest  {\definecolor{colorMain}  {HTML}{14532D}%
                       \definecolor{colorAccent}{HTML}{166534}%
                       \definecolor{colorBg}    {HTML}{CBE6D5}}

\def\ENS@pal@cyan    {\definecolor{colorMain}  {HTML}{0E6B8E}%
                       \definecolor{colorAccent}{HTML}{0891B2}%
                       \definecolor{colorBg}    {HTML}{C7EAF3}}

% Neutral (theme-independent) grey used for the keywords line and abstract
% box, matching the .ott's fixed #e6e6e6 — deliberately NOT theme-tinted,
% same as in the source template.
\definecolor{colorAbstractBg}{HTML}{E6E6E6}

% Apply the chosen theme right away — \@theme is already fixed by now (set
% during \ProcessOptions, back in section 1), and xcolor's \definecolor has
% been available since section 3, so nothing actually requires waiting for
% \begin{document} here. This matters: biblatex's own numeric-comp style
% measures the widest citation label (\mkbibbrackets{99}) during ITS
% \AtBeginDocument hook, which — since it's registered earlier than
% anything of ours — would run before a deferred colour selection and hit
% "Undefined color `colorMain'" the moment \mkbibbrackets (redefined above
% to use colorMain) got probed.
\ifcsname ENS@pal@\@theme\endcsname
  \csname ENS@pal@\@theme\endcsname
\else
  \ENS@pal@orange
\fi

% The hyperref setup below, in contrast, genuinely does need to wait: it
% only overrides colours hyperref already initialised from [hidelinks],
% and \theHreviewbox specifically needs to run after hyperref's own
% \AtBeginDocument counter registration (see the comment on it below) — so
% only this part stays deferred.
\AtBeginDocument{%
  \hypersetup{colorlinks=true, linkcolor=colorMain, citecolor=colorMain, urlcolor=colorAccent}%
  % hyperref auto-assigns \theH<counter> for every *known* counter at
  % \begin{document}; this line runs right after that (still inside the
  % same \AtBeginDocument queue, just registered later — see section 3's
  % note on load order), so it wins and gives our custom "reviewbox" float
  % type a stable hyperlink anchor name (fixes a "dest ... does not exist"
  % pdfTeX warning that would otherwise show up for \cref'd boxes).
  \def\theHreviewbox{\thereviewbox}%
}


%===============================================================================
%  6. TITLE BLOCK METADATA
%===============================================================================
%  \reviewtitle, \reviewshorttitle, \reviewauthor, \reviewaffiliation,
%  \reviewdate, \reviewkeywords, \reviewabstract just store the content the
%  student provides in the preamble; \maketitle (defined right after) and
%  the running header/footer (section 7) read it back out when the document
%  is actually typeset.
%-------------------------------------------------------------------------------

\newcommand{\@reviewtitle}{}
\newcommand{\@reviewshorttitle}{}
\newcommand{\@reviewauthor}{}
\newcommand{\@reviewauthorshort}{}
\newcommand{\@reviewaffiliation}{}
\newcommand{\@reviewdate}{\today}
\newcommand{\@reviewkeywords}{}
\newcommand{\@reviewabstract}{}

\newcommand{\reviewtitle}[1]{\renewcommand{\@reviewtitle}{#1}}

% Short form shown in the running header (article title compressed to a few
% words — the full title rarely fits on one line of a coloured header bar).
\newcommand{\reviewshorttitle}[1]{\renewcommand{\@reviewshorttitle}{#1}}

\newcommand{\reviewauthor}[1]{\renewcommand{\@reviewauthor}{#1}}

% Short form shown in the running header, e.g. "Larrahondo Rodríguez"
% (surname only) rather than the full "Erika Larrahondo Rodríguez".
\newcommand{\reviewauthorshort}[1]{\renewcommand{\@reviewauthorshort}{#1}}

\newcommand{\reviewaffiliation}[1]{\renewcommand{\@reviewaffiliation}{#1}}
\newcommand{\reviewdate}[1]{\renewcommand{\@reviewdate}{#1}}
\newcommand{\reviewkeywords}[1]{\renewcommand{\@reviewkeywords}{#1}}
\newcommand{\reviewabstract}[1]{\renewcommand{\@reviewabstract}{#1}}

% Full-width coloured band helper: a \colorbox stretched to exactly the text
% width (accounting for \fboxsep padding on both sides) rather than just
% wrapping tightly around its content. Reused for the affiliation/date band,
% the keywords line, the abstract box, and both header/footer bars.
\newcommand{\@ENSfullbox}[2]{%
  \noindent\colorbox{#1}{\parbox{\dimexpr\textwidth-2\fboxsep\relax}{#2}}%
}

% \maketitle assembles the whole page-1 header block — title, then a single
% coloured band holding author + affiliation/date, then keywords, abstract —
% inside a \twocolumn[...] argument (see section 2's note on why that spans
% the full page width), then lets normal twocolumn flow take over for
% \section{Introduction} and everything after it.
\renewcommand{\maketitle}{%
  \twocolumn[{%
    \begin{minipage}{\textwidth}
      \raggedright
      {\Large\bfseries\color{colorMain} \@reviewtitle \par}
      \vspace{4pt}
      \@ENSfullbox{colorBg}{%
        {\large\bfseries\@reviewauthor}\\[2pt]
        \small\textit{\@reviewaffiliation}\\[2pt]
        \@reviewdate
      }
      \vspace{10pt}
      \@ENSfullbox{colorAbstractBg}{\textbf{Keywords:} \@reviewkeywords}
      \vspace{6pt}
      \@ENSfullbox{colorAbstractBg}{\bfseries \@reviewabstract}
      \vspace{10pt}
    \end{minipage}
  }]%
}


%===============================================================================
%  7. RUNNING HEADER / FOOTER
%===============================================================================
%  Matches the .ott master page: "page/total <tab> Short title. Author" on a
%  coloured bar (header), and "École Normale Supérieure de Lyon <tab>
%  Master 2 Reviews, <date>" on a coloured bar (footer). The bar
%  spans the text width via \@ENSfullbox (section 6) rather than bleeding
%  all the way to the physical paper edge — a deliberate trade-off to avoid
%  pulling in tikz/eso-pic just for a decorative flourish; see the README's
%  "Known limitations" for the visual difference this makes.
%-------------------------------------------------------------------------------

\pagestyle{fancy}
\fancyhf{}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}

% Header text: italic throughout (page/total, short title, author surname)
% — the short title is additionally bold, so it still stands out from the
% rest of the bar — set in Helvetica/Arial-look sans, contrasting with the
% Times body text.
\newcommand{\@ENSheadtext}{%
  \sffamily\small\itshape\color{white}%
  \thepage\,/\,\pageref{LastPage}\hfill
  \textbf{\@reviewshorttitle.}\ \@reviewauthorshort%
}
% Footer text: smaller than the header, italic, same sans family.
\newcommand{\@ENSfoottext}{%
  \sffamily\footnotesize\itshape\color{white}%
  \'Ecole Normale Sup\'erieure de Lyon\hfill
  Master 2 Reviews, \@reviewdate
}

\fancyhead[C]{\@ENSfullbox{colorMain}{\@ENSheadtext}}
\fancyfoot[C]{\@ENSfullbox{colorMain}{\@ENSfoottext}}

% LaTeX silently switches to the "plain" pagestyle on any page that starts
% with \maketitle, \chapter, etc. — redefine it here too, identically, or
% page 1 would otherwise fall back to plain page numbers with no bar at all.
\fancypagestyle{plain}{%
  \fancyhf{}
  \fancyhead[C]{\@ENSfullbox{colorMain}{\@ENSheadtext}}
  \fancyfoot[C]{\@ENSfullbox{colorMain}{\@ENSfoottext}}
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0pt}
}


%===============================================================================
%  8. SECTION / SUBSECTION STYLING  (Art_titre1 / Art_titre2)
%===============================================================================

% Current Opinion style has no section numbers ("Introduction", not
% "1 Introduction"). secnumdepth=0 disables numbering depth-wide (rather
% than, say, hiding the number only in \titleformat) so that \section,
% \subsection AND their starred forms all behave identically without extra
% bookkeeping — LaTeX's own \@startsection machinery handles the rest.
\setcounter{secnumdepth}{0}

\titleformat{\section}
  {\normalfont\large\bfseries\color{colorMain}}
  {}{0pt}{#1}
\titlespacing*{\section}{0pt}{10pt}{4pt}

\titleformat{\subsection}
  {\normalfont\normalsize\bfseries\color{colorMain}}
  {}{0pt}{#1}
\titlespacing*{\subsection}{0pt}{8pt}{2pt}


%===============================================================================
%  9. LISTS  (Art_puce / Art_numérotation)
%===============================================================================
%  Tighter default spacing than plain LaTeX itemize/enumerate — the source
%  format's bullet/numbered lists sit close together, without the generous
%  paragraph-like spacing article.cls uses by default.
%-------------------------------------------------------------------------------

\setlist[itemize]{leftmargin=1.4em, itemsep=0.15em, topsep=0.15em}
\setlist[enumerate]{leftmargin=1.6em, itemsep=0.15em, topsep=0.15em}


%===============================================================================
%  10. FIGURES AND TABLES  (Art_cadre_1colonne / Art_cadre_2col_*)
%===============================================================================
%  No custom environment needed here: plain \figure / \table already give a
%  single-column illustration, and their starred \figure* / \table* forms
%  already span both columns — that's standard LaTeX twocolumn behaviour,
%  just enabled by loading `float`/`stfloats` above so it also works at the
%  bottom of a column, not only the top.
%-------------------------------------------------------------------------------

% Table note: a lettered footnote below a table or box, e.g.
% \reviewnote{a}{Not done.} → a small raised "a" then the note text.
\newcommand{\reviewnote}[2]{\par\noindent\footnotesize\textsuperscript{#1}\,#2\par}


%===============================================================================
%  11. BOX  (Art_box_1colonne / Art_box_2col_*)
%===============================================================================
%  A custom float type "reviewbox", registered with the `float` package so it
%  gets its own numbering, its own placement defaults, and — this is the
%  useful part — a starred, two-column-wide variant for free, exactly like
%  table/table*.
%-------------------------------------------------------------------------------

% float's stock "boxed" style hardcodes 3pt of padding on every side and
% draws the border in whatever text colour is active (effectively black)
% — neither is parametrised via a length/colour a class could just set, so
% \fs@boxed itself is redefined below: wider left/right padding (6pt
% instead of 3pt; top/bottom kept at 3pt) and a colorMain-tinted border
% instead of black. \floatstyle{boxed}/\newfloat only ever *reference* the
% \fs@boxed control sequence by name (float.sty's \float@restyle stores
% \noexpand\fs@boxed, not its current expansion) — so redefining it here,
% right after selecting the style, is enough; no need to touch \newfloat
% itself, and nothing else in the class uses the "boxed" style.
\floatstyle{boxed}
\renewcommand\fs@boxed{%
  \def\@fs@cfont{\bfseries}%
  \let\@fs@capt\floatc@plain
  \def\@fs@pre{%
    \setbox\@currbox\vbox{\hbadness10000
      \moveleft6.4pt\vbox{\advance\hsize by12.8pt
        {\color{colorMain}\hrule}%
        \hbox to\hsize{{\color{colorMain}\vrule}\kern6pt
          \vbox{\kern3pt\box\@currbox\kern3pt}\kern6pt{\color{colorMain}\vrule}}%
        {\color{colorMain}\hrule}}}%
  }%
  \def\@fs@mid{\kern2pt}%
  \def\@fs@post{}%
  % Caption goes ABOVE the bordered box, outside it — matching the
  % \caption-above convention already used for table/table* in this class,
  % rather than float's own boxed-style default (caption below).
  \let\@fs@iftopcapt\iftrue
}
\newfloat{reviewbox}{tbp}{lob}
\floatname{reviewbox}{Box}
% \newfloat's internal \restylefloat call already defines BOTH \reviewbox
% (single-column, via \@float) and \reviewbox* (two-column-wide, via
% \@dblfloat) as a side effect of registering the float type — no separate
% \newenvironment{reviewbox*}{...}{...} needed, and adding one would in
% fact collide with the one \newfloat already created.

% hyperref needs to be told how to name this custom float type for \autoref
% (and, by extension, for \cref, which delegates to it in a few code paths).
\providecommand{\reviewboxautorefname}{Box}
% Known cosmetic quirk: pdfTeX may warn "dest ... has been referenced but
% does not exist" for \cref'd/\autoref'd reviewbox labels — a float +
% caption + hyperref interaction specific to custom float types that
% doesn't affect standard figure/table. The printed number and link text
% are always correct; only the internal PDF jump-to-target can misfire in
% some viewers.


%===============================================================================
%  12. LEGACY MANUAL REFERENCES  (fallback for students without biber access)
%===============================================================================
%  The recommended path is \cite{} + a .bib file, set up in section 4 above.
%  This environment is kept only as a fallback for the rare case where biber
%  genuinely isn't available — it produces the same visual result, but
%  citations are typed-in plain text: not clickable, not auto-numbered, and
%  not automatically kept in sync if you reorder or delete a reference.
%-------------------------------------------------------------------------------

% \bibref{Authors}{Title}{Journal}{Year}{Volume}{Pages} formats one entry;
% \bibdoi/\bibpmid/\bibpmcid each append one bracketed identifier after it.
\newcommand{\bibref}[6]{#1: \textbf{#2}. \textit{#3} #4, \textbf{#5}:#6.}
\newcommand{\bibdoi}[1]{\ [doi: #1]}
\newcommand{\bibpmid}[1]{\ [PMID: #1]}
\newcommand{\bibpmcid}[1]{\ [PMCID: #1]}

% Called right after the \item for a reference, inside \begin{references},
% to attach the •/•• annotation paragraph — the manual-mode equivalent of
% \refspecialinterest/\refoutstandinginterest from section 4.
\newcommand{\ofspecialinterest}[1]{\par\noindent\textbullet\ \textit{#1}\par}
\newcommand{\ofoutstandinginterest}[1]{\par\noindent\textbullet\textbullet\ \textit{#1}\par}

% Heading text for this legacy environment specifically — override with
% \renewcommand{\referencesname}{References} for a shorter house style.
% (\printbibliography's own heading, section 4, is configured separately
% via \printbibliography[title=...].)
\newcommand{\referencesname}{References and recommended reading}

\newenvironment{references}{%
  \section*{\referencesname}
  \small
  \if@ENSreviewlegend
    \noindent Papers of particular interest have been highlighted as:\\
    \textbullet\ of special interest\\
    \textbullet\textbullet\ of outstanding interest
    \vspace{4pt}\par
  \fi
  \begin{enumerate}[leftmargin=1.8em, itemsep=0.5em, topsep=0.3em, label=\arabic*.]
}{%
  \end{enumerate}
}

\endinput
