% SPDX-FileCopyrightText: Copyright © 2026-present Sedimentologika
% SPDX-FileContributor: Jarred C. Lloyd
%
% SPDX-License-Identifier: LPPL-1.3c

% ----------------------------------------------------------------------------------------
% Document class for Sedimentologika, a community-driven Diamond Open Access journal publishing research in sedimentology and stratigraphy.
% https://oap.unige.ch/journals/sdk/
% Current version with inputs from:
% Jarred C Lloyd
% Last updated: 2026-08-07
% Derived from seismica.cls, and WeAreAGC submission template.

% ----------------------------------------------------------------------------------------
% Class declaration and switches
% ----------------------------------------------------------------------------------------
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{sedimentologika}[2026-08-07 Sedimentologika LaTeX class]

\newif\if@onecolumn
\@onecolumnfalse
\DeclareOption{onecolumn}{\@onecolumntrue}

\newif\if@preprint
\@preprintfalse
\DeclareOption{preprint}{\@preprinttrue}

\newif\if@submission
\@submissionfalse
\DeclareOption{submission}{\@submissiontrue}

\newif\if@proof
\@prooffalse
\DeclareOption{proof}{\@prooftrue}

\newif\if@publication
\@publicationfalse
\DeclareOption{publication}{\@publicationtrue}

\newif\if@anonymous
\@anonymousfalse
\DeclareOption{anonymous}{\@anonymoustrue}

\newif\if@longauthor
\@longauthorfalse
\DeclareOption{longauthor}{\@longauthortrue}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

\if@submission
\@onecolumntrue
\LoadClass[10pt, a4paper, onecolumn]{article}
\else
\LoadClass[10pt, a4paper, twocolumn]{article}
\setlength{\columnsep}{8mm}
\fi

% ----------------------------------------------------------------------------------------
% General Packages
% ----------------------------------------------------------------------------------------
\RequirePackage[mode=match,%
  unit-mode=match,%
  range-units=single,%
  group-minimum-digits = 3,%
  separate-uncertainty = true,%
  multi-part-units=single,%
  list-units=single%
]{siunitx}
\RequirePackage{xcolor}
\RequirePackage[most]{tcolorbox}
\RequirePackage{multicol}
\RequirePackage[scale=2]{ccicons}
\RequirePackage{simpleicons}
\RequirePackage{amsmath}
\RequirePackage{commath}
\RequirePackage{amssymb}
\RequirePackage{booktabs}
\RequirePackage{nicematrix}
\RequirePackage{longtable}
\RequirePackage{multirow}[longtable]
\RequirePackage{ragged2e}
\RequirePackage{graphics}
\RequirePackage[version=4]{mhchem}
\RequirePackage{caption}
\RequirePackage{textgreek}
\RequirePackage{titling}
\RequirePackage[noblocks]{authblk}
\RequirePackage{titlesec}
\RequirePackage{titleps}
\RequirePackage[stamp=false, color={[gray]{0.9}}, fontsize=72pt]{draftwatermark}
\RequirePackage[english, bidi=basic, provide*=*]{babel}
\RequirePackage[babel=true, nopatch=footnote]{microtype}
\RequirePackage[style=iso]{datetime2}
\RequirePackage{citation-style-language}
\RequirePackage{orcidlink}
\RequirePackage{url}
\RequirePackage{doi}
\RequirePackage{pdflscape}
\RequirePackage{hyperref}
\RequirePackage{setspace}
\RequirePackage{datatool}
\RequirePackage[absolute, quiet]{textpos}
\RequirePackage{changepage}
\RequirePackage[thepage, savepos]{zref}
\RequirePackage{hyperxmp}
\RequirePackage[
  hmargin=15mm,
  vmargin=20mm,
  headsep=2mm,
  footskip=5mm,
  marginparsep=1mm,
  marginparwidth=10mm,
  % showframe
]{geometry}
\RequirePackage[parfill, skip={\baselinestretch}]{parskip}
\RequirePackage{afterpage}
\RequirePackage{fixme}
\RequirePackage{xstring}

\if@submission
\cslsetup{style=apa, bib-item-sep = 8 pt plus 4 pt minus 2 pt}
\else
\cslsetup{style=apa,
  bib-font=\linespread{1}\footnotesize,
bib-item-sep = 8 pt plus 4 pt minus 2 pt}
\fi

\DeclareSIUnit{\year}{yr}
\DeclareSIUnit{\annum}{a}

\definecolor{SedK1}{HTML}{06595a} % #06595a
\definecolor{SedK2}{HTML}{086162} % #086162
\definecolor{SedK3}{HTML}{0a696a} % #0a696a
\definecolor{SedK4}{HTML}{0c7172} % #0c7172
\definecolor{SedkGrey}{HTML}{5E5E5E} % #5E5E5E

\pdfstringdefDisableCommands{%
  \let\textsuperscript\@gobble
  \expandafter\let\csname textsuperscript \endcsname\@gobble
  \let\@textsuperscript\@gobble
  \let\rlap\@gobble
  \let\llap\@gobble
  \let\thanks\@gobble
  \let\footnote\@gobble
  \let\Authfont\@empty
  \let\Affilfont\@empty
  \let\affilsep\@empty
  \let\\\space
  \let\texttt\@firstofone
  \let\textcolor\@secondoftwo
  \let\href\@secondoftwo
  \let\orcidlink\@gobble
  \expandafter\let\csname orcidlink \endcsname\@gobble
  \let\simpleicon\@gobble
  \expandafter\let\csname simpleicon \endcsname\@gobble
  \let\mathsurround\@empty
  \let\z@\@empty
  \let\f@family\@empty
  \let\f@series\@empty
  \let\f@shape\@empty
}

% ----------------------------------------------------------------------------------------
%  Custom commands
% ----------------------------------------------------------------------------------------
\newcommand{\englishvariety}[1]{\gdef\@englishvariety{#1}}

\newcommand{\shorttitle}[1]{\gdef\@shorttitle{#1}}
\renewcommand*{\title}[1]{\gdef\@title{#1}}

% Article info
\newcommand{\articletype}[1]{\gdef\@articletype{#1}}
\newcommand{\volumenumber}[1]{%
  \gdef\@volumenumber{#1}%
  \global\edef\metavolume{#1}%
}
\newcommand{\issuenumber}[1]{%
  \gdef\@issuenumber{#1}%
  \global\edef\metaissue{#1}%
}
\newcommand{\receiveddate}[1]{\gdef\@receiveddate{#1}}
\newcommand{\accepteddate}[1]{\gdef\@accepteddate{#1}}
\newcommand{\publisheddate}[1]{\gdef\@publisheddate{#1}}
\newcommand{\theyear}[1]{%
  \gdef\@theyear{#1}%
  \global\edef\metayear{#1}%
}
% \newcommand{\suppmat}[1]{%
%   \gdef\@suppmat{#1}%
%   \global\edef\metasupp{#1}%
% }

\let\@suppmat\@empty
\let\@suppmatinfo\@empty
\let\@suppmattext\@empty
\def\metasupp{}

\newcommand{\suppmat}[1]{%
  \ifx\@suppmat\@empty
		\gdef\@suppmat{#1}
		\gdef\@suppmatinfo{\href{https://doi.org/#1}{\simpleicon{doi}~#1}}
		\gdef\@suppmattext{\href{https://doi.org/#1}{doi:~#1}}
		\global\edef\metasupp{#1}% Plain text for metadata
  \else
		\g@addto@macro\@suppmat{, #1}%
		\g@addto@macro\@suppmatinfo{, \href{https://doi.org/#1}{\simpleicon{doi}~#1}}%
		\g@addto@macro\@suppmattext{, \href{https://doi.org/#1}{doi:~#1}}%
		\g@addto@macro\metasupp{, #1}%
  \fi
}

\newcommand{\articledoi}[1]{%
  \gdef\@articledoi{#1}%
  \global\edef\metadoi{#1}%
}
\newcommand{\keywords}[1]{%
  \gdef\@keywords{#1}%
  % Perform the substitution in a group where we can use standard \edef
  \begingroup
  % Use \StrSubstitute to create the modified string in a temporary macro
  \StrSubstitute{#1}{\\}{, }[\@tempmetakeywords]%
  % Now make the assignment global
  \global\let\metakeywords\@tempmetakeywords
  \endgroup
}

% Volunteer names
\newcommand{\execedname}[1]{\gdef\@execedname{#1}}
\newcommand{\assocedname}[1]{\gdef\@assocedname{#1}}
\newcommand{\prodmanname}[1]{\gdef\@prodmanname{#1}}
\newcommand{\prodassist}[1]{\gdef\@prodassist{#1}}
\newcommand{\copyedname}[1]{\gdef\@copyedname{#1}}
\newcommand{\reviewername}[1]{\gdef\@reviewername{#1}}

\newcommand{\onecolwidth}{\dimexpr 86mm \relax}
\newcommand{\twocolwidth}{\textwidth}

\newcommand{\email}[1]{\texttt{\textcolor{SedK2}{\scriptsize #1}}}

% Author stuff
\renewcommand*{\Authsep}{, }
\renewcommand*{\Authand}{ \& }
\renewcommand*{\Authands}{, and }
\renewcommand*{\Authfont}{\bfseries}
\renewcommand*{\Affilfont}{\mdseries\footnotesize}
\setlength{\affilsep}{2mm}

\gdef\@correspondingauthor{}
\gdef\metacontact{}

\newcommand{\correspondingauthor}[2]{%
  \ifx\@correspondingauthor\@empty
  \gdef\@correspondingauthor{\vskip 0.4em\scriptsize*Corresponding authors: #1, \href{mailto:#2}{#2}}%
  \global\edef\metacontact{#2}%
  \else
  \g@addto@macro\@correspondingauthor{; #1, \href{mailto:#2}{#2}}%
  \g@addto@macro\metacontact{, #2}%
  \fi
}

\NewCommandCopy{\authblkauthor}{\author}

\ExplSyntaxOn
\seq_new:N \g_authors_seq
\RenewDocumentCommand{\author}{om}
{
  \seq_gput_right:Nn \g_authors_seq { #2 }
  \IfNoValueTF { #1 } { \authblkauthor{#2} } { \authblkauthor[#1]{#2} }
}
\NewExpandableDocumentCommand{\ABgetauthor}{m}
{
  \seq_item:Nn \g_authors_seq { #1 }
}
\seq_new:N \g_auth_last
% \NewExpandableDocumentCommand{\ABgetauthorlast}{m}
% {
%   \regex_extract_once:nnN { [\w\-\`\']+$ } { \ABgetauthor{#1} } \g_auth_last
% }LaTex3 regex not working in this context and doesn't support unicode characters
\ExplSyntaxOff

% \newcommand{\authors}{
%   \begingroup
%   \let\footnote\@gobble % ignore \footnote
%   \let\textsuperscript\@gobble % ignore protected \textsuperscript
%   \expandafter\let\csname textsuperscript \endcsname\@gobble
%   \ifnum\value{authors}<3 % one or two authors
%   \AB@authlist % show them all
%   \else % 3 or more authors
%   \ABgetauthorlast{1} et~al.%
%   \fi
%   \endgroup
% } LaTex3 regex not working in this context and doesn't support unicode characters.

\newcommand{\authorshdr}[1]{%
  \gdef\authors{#1}%
  \global\edef\metaauth{#1}%
}
\newcommand{\metaauthlist}[1]{\global\edef\metaauthlist{#1}}

% CRediT
\DTLgnewdb{CRediTs}
\newcommand*{\CRediT}[2]{%
  \DTLnewrow{CRediTs}
  \DTLnewdbentry{CRediTs}{credrole}{#1}
  \DTLnewdbentry{CRediTs}{credauthor}{#2}
}

% Table columns
\newcommand{\PreserveBackslash}[1]{\let\temp=\\#1\let\\=\temp}
\newcolumntype{C}[1]{>{\PreserveBackslash\centering}p{#1}}
\newcolumntype{R}[1]{>{\PreserveBackslash\RaggedLeft}p{#1}}
\newcolumntype{L}[1]{>{\PreserveBackslash\RaggedRight}p{#1}}
\newcolumntype{M}[1]{>{\PreserveBackslash\centering}m{#1}}

\newcommand*{\rot}[1]{\rotatebox[origin=c]{#1}}

% ----------------------------------------------------------------------------------------
%  Custom environments
% ----------------------------------------------------------------------------------------
\renewenvironment{abstract}
{
  \section*{Abstract}%
  \zsavepos{loc:beg_abstract}

}
{
  \par
  \normalsize
}

\newenvironment{translation}[3]{%
  \begin{otherlanguage}{#1}
    \section*{#2\;}
    #3
  \end{otherlanguage}
}{
  \par
  \normalsize
}

\newenvironment{plainlanguagesummary}
{
  \section*{Plain language summary}
  \zsavepos{loc:beg_plainlanguagesummary}

}%
{
  \par
  \normalsize
}

\newenvironment{acknowledgements}
{
  \small
  \section*{Acknowledgements}
}%
{
  \par
  \normalsize
}

\newenvironment{conflictofinterest}
{
  \small
  \section*{Conflict of interest statement}
}%
{
  \par
  \normalsize
}
\newenvironment{artificialintelligence}
{
  \small
  \section*{Artificial intelligence use statement}
}%
{
  \par
  \normalsize
}

\newenvironment{datacode}
{
  \small
  \section*{Data and code availability}
}%
{
  \par
  \normalsize
}

\newenvironment{funding}
{
  \section*{Funding}
  \small
}%
{
  \par
  \normalsize
}

\newenvironment{supplementarymaterial}
{
  \section*{Supplementary materials}
  \small
}%
{
  \par
  \normalsize
}

\newenvironment{specialsection}[1]
{
  \section*{#1}
  \small
}%
{
  \par
  \normalsize
}

\newenvironment{citing}[1]
{
  \section*{Citing this \@articletype}
  \RaggedRight\small
  To cite this paper use the following information:

  \textbf{\textcolor{SedK1}{Authors}}\linebreak
  #1

  \textbf{\textcolor{SedK1}{Title}}\linebreak
  \@title

  \textbf{\textcolor{SedK1}{Short Title}}\linebreak
  \@shorttitle

  \textbf{\textcolor{SedK1}{Publishing Information}}\linebreak
  Publication: Sedimentologika\linebreak
  Volume: \@volumenumber\linebreak
  Issue: \@issuenumber\linebreak
  Year: \@theyear\linebreak
  DOI: \href{https://doi.org/\@articledoi}{\@articledoi}\linebreak
  Language: en\linebreak
  License: \href{https://creativecommons.org/licenses/by/4.0/}{CC-BY 4.0}
}%
{
  \par
  \normalsize
}

\newcommand{\preprintdeclaration}[1]{\gdef\@preprintdeclaration{#1}}
% % -------------------------------------------------------------------------------
% %                information box
% % -------------------------------------------------------------------------------

\newcommand{\promohref}[3][SedK1]{\href{#2}{\color{#1}{#3}}}

\newcommand{\Sedimentologika}{\textcolor{SedK1}{\textit{Sedimentologika}}}

\newcommand{\@insert@preprintdeclaration}{%
  \begin{textblock*}{40mm}[1,0](195mm,\dimexpr\pageheight-3mm-\zposy{loc:beg_abstract}sp\relax)
    \bfseries\raggedleft%
    \setlength{\parskip}{\baselineskip}%
    \setlength{\parindent}{\z@}%
    {This preprint was generated using the}{\\}{\promohref{https://github.com/Sedimentologika/templates}{\textit{Sedimentologika} \\ \LaTeX\ template}}
    \par
  \end{textblock*}
}

\newcommand{\@insert@metadata}{%
  \if@longauthor
  \clearpage
  \begin{textblock*}{0.9\textwidth}[0.5,0.5](%
						\dimexpr\pagewidth/2\relax,%
						\dimexpr\pageheight/2 + \zposy{loc:endauthorblock}sp/2 - 17mm\relax%
    )
    \metadata@boxed
  \end{textblock*}
  \else
  \begin{textblock*}{40mm}[1,0](195mm,\dimexpr\pageheight-3mm-%
      \zposy{loc:beg_abstract}
    sp\relax)
    \footnotesize
    \linespread{1.3}
    \metadata@vertical
  \end{textblock*}
  \fi
}

\newcommand{\printifnotempty}[5]{%
  \protected@edef\@tempa{#3}%
  \ifx\@tempa\@empty \else
		\begin{#5}
				\bfseries\textcolor{SedK1}{#1}#2\mdseries\textcolor{SedK2}{#3}#4
		\end{#5}
  \fi
}

\newcommand{\metadata@vertical}{%
  \printifnotempty{\mdseries\textcolor{lightgray}{\raisebox{-1.2ex}{\LARGE\simpleicon{openaccess}
  }}}{\enspace}{\bfseries\normalsize\@articletype}{\vspace{3mm}}{flushright}
  \printifnotempty{Executive Editor}{\par}{\@execedname}{\vspace{3mm}}{flushright}
  \printifnotempty{Associate Editor}{\par}{\@assocedname}{\vspace{3mm}}{flushright}
  \printifnotempty{Reviewers}{\par}{\@reviewername}{\vspace{3mm}}{flushright}
  \printifnotempty{Production Manager}{\par}{\@prodmanname}{\vspace{3mm}}{flushright}
  \printifnotempty{Production Assistant}{\par}{\@prodassist}{\vspace{3mm}}{flushright}
  \printifnotempty{Copy Editor}{\par}{\@copyedname}{\vspace{3mm}}{flushright}
  \printifnotempty{Received:}{~}{\@receiveddate}{\par}{flushright}
  \printifnotempty{Accepted:}{~}{\@accepteddate}{\par}{flushright}
  \printifnotempty{Published:}{~}{\@publisheddate}{\vspace{3mm}}{flushright}
  \printifnotempty{Supplementary material}{\par}{\@suppmatinfo}{\vspace{4mm}}{flushright}
  \printifnotempty{\textcolor{SedkGrey}{Keywords}}{\par}{\textcolor{SedkGrey}{\@keywords}}{\par}{flushright}
}

% Alternate Metadata box
\newcommand{\metadata@boxed}{%
  \begin{tcolorbox}[center,
      width=0.9\linewidth,
      colframe=SedK1,
      boxrule=0.25pt,
      arc=1.2mm,
      left=3mm,
      right=3mm,
      top=2mm,
      colback=white,
    bottom=2mm]
    \begin{multicols}{3}
      \footnotesize
      \begin{RaggedRight}
        % \vspace*{8mm}
        \printifnotempty{
        \mdseries\textcolor{lightgray}{\raisebox{-1.2ex}{\LARGE\simpleicon{openaccess}}}}{\enspace}{\bfseries\normalsize\@articletype}{\par\vspace{9mm}}{flushleft}\par

        \printifnotempty{Received:}{~}{\@receiveddate}{\par\vspace{2mm}}{flushleft}\par

        \printifnotempty{Accepted:}{~}{\@accepteddate}{\par\vspace{2mm}}{flushleft}\par

        \printifnotempty{Published:}{~}{\@publisheddate}{\par\vspace{2mm}}{flushleft}\par

        \printifnotempty{Supplementary material}{\par}{\@suppmatinfo}{\par\vspace{2mm}}{flushleft}\par

      \end{RaggedRight}
      \columnbreak
      \begin{centering}
        \printifnotempty{Executive Editor}{\par}{\@execedname}{\par\vspace{2mm}}{centering}\par

        \printifnotempty{Associate Editor}{\par}{\@assocedname}{\par\vspace{2mm}}{centering}\par

        \printifnotempty{Production Manager}{\par}{\@prodmanname}{\par\vspace{2mm}}{centering}\par

        \printifnotempty{Production Assistant}{\par}{\@prodassist}{\par\vspace{2mm}}{centering}\par

        \printifnotempty{Copy Editor}{\par}{\@copyedname}{\par}{centering}\par

      \end{centering}
      \columnbreak

      \begin{RaggedLeft}
        % \vspace*{8mm}
        \printifnotempty{Reviewers}{\par}{\@reviewername}{\par\vspace{3mm}}{flushright}\par

        \printifnotempty{\textcolor{SedkGrey}{Keywords}}{\par}{\textcolor{SedkGrey}{\@keywords}}{}{flushright}\par

      \end{RaggedLeft}
    \end{multicols}
    % \metadata@vertical
  \end{tcolorbox}
}

% ----------------------------------------------------------------------------------------
%  basic formatting, declaration of styles
% ----------------------------------------------------------------------------------------

\clubpenalty10000
\widowpenalty10000
\brokenpenalty10000
% \predisplaypenalty10000
% \postdisplaypenalty10000
% \displaywidowpenalty10000
\hyphenpenalty8000

\renewcommand{\topfraction}{0.85}
\renewcommand{\bottomfraction}{0.85}
\setcounter{topnumber}{1}
\setcounter{bottomnumber}{1}

\frenchspacing
\raggedbottom
\linespread{1.2}

% Typefaces
\RequirePackage{fontspec}
\RequirePackage[math-style=ISO,bold-style=ISO]{unicode-math}

\IfFontExistsTF{Noto Sans}{%
  \babelfont{rm}[%
    BoldFont={notosans-variablefont_wdth,wght.ttf},
    ItalicFont={notosans-italic-variablefont_wdth,wght.ttf},
    BoldItalicFont={notosans-italic-variablefont_wdth,wght.ttf},
    Numbers={Proportional,Lining},
    UprightFeatures={Weight=350},
    ItalicFeatures={Weight=350},
    BoldFeatures={Weight=600}
  ]{notosans-variablefont_wdth,wght.ttf}
  \babelfont{sf}[%
    BoldFont={notosans-variablefont_wdth,wght.ttf},
    ItalicFont={notosans-italic-variablefont_wdth,wght.ttf},
    BoldItalicFont={notosans-italic-variablefont_wdth,wght.ttf},
    Numbers={Proportional,Lining},
    UprightFeatures={Weight=350},
    ItalicFeatures={Weight=350},
    BoldFeatures={Weight=600}
  ]{notosans-variablefont_wdth,wght.ttf}
}{\RequirePackage[sfdefault]{noto}}

\IfFontExistsTF{Noto Sans Mono}{%
  \babelfont{tt}[%
    BoldFont={notosansmono-variablefont_wdth,wght.ttf},
    Numbers={Proportional,Lining},
    UprightFeatures={Weight=350},
    BoldFeatures={Weight=600}
  ]{notosansmono-variablefont_wdth,wght.ttf}
}{\RequirePackage{noto-mono}}

\IfFontExistsTF{Noto Sans Math Regular}{
  \setmathfont{notosansmath-regular}
  \setmathrm{notosansmath-regular}
}{
  \RequirePackage{firamath-otf}
}

\captionsetup{font=small, labelfont=bf, justification=justified, labelsep=endash, skip = 5pt, singlelinecheck=off}

\setlength{\textfloatsep}{6mm plus 1mm minus 1mm}
\setlength{\dbltextfloatsep}{6mm plus 1mm minus 1mm}
\setlength{\intextsep}{6mm plus 1mm minus 1mm}

% Section label formatting
\titleformat{name=\section, numberless}{\RaggedRight\fontsize{9pt}{15pt}\bfseries}{}{0em}{}[]
\titleformat{name=\section}{\RaggedRight\fontsize{11pt}{17pt}\bfseries}{\thesection}{0.5em}{}
\titleformat{name=\subsection}{\RaggedRight\fontsize{10pt}{15pt}\bfseries}{\thesubsection}{0.5em}{}
\titleformat{name=\subsubsection}{\RaggedRight\fontsize{10pt}{15pt}\bfseries}{\thesubsubsection}{0.5em}{}

\titlespacing{name=\section, numberless}{0em}{*2}{0.5em}
\titlespacing{name=\section}{0em}{*2}{*1}
\titlespacing{name=\subsection}{0em}{*2}{*1}
\titlespacing{name=\subsubsection}{0em}{*2}{*1}

\setcounter{secnumdepth}{3}

% ----------------------------------------------------------------------------------------
% Hyperlink and CRediT styling
% ----------------------------------------------------------------------------------------

\if@preprint
\hypersetup{
  colorlinks=true,
  linkcolor=blue,
  anchorcolor=black,
  citecolor=blue,
  filecolor=black,
  menucolor=black,
  runcolor=black,
  urlcolor=blue
}

\newcommand{\printCRediTifnotempty}{%
  \ifdim\DTLrowcount{CRediTs}pt=0pt
  \else
  \vglue 0.5\baselineskip
  \footnotesize\RaggedRight\textcolor{black}{\textbf{CRediT statement: }}
  \DTLforeach*{CRediTs}{
  \Credrole=credrole, \Credauthor=credauthor}{\textcolor{black}{ \textit{\Credrole}: \Credauthor. }
  }
  \fi
}

\else
\hypersetup{
  colorlinks=true,
  linkcolor=SedK3,
  anchorcolor=black,
  citecolor=SedK2,
  filecolor=black,
  menucolor=black,
  runcolor=black,
  urlcolor=SedK3
}

\newcommand{\printCRediTifnotempty}{%
  \ifdim\DTLrowcount{CRediTs}pt=0pt
  \else
  \vglue 0.5\baselineskip
  \footnotesize\RaggedRight\textcolor{SedK2}{\textbf{CRediT statement: }}
  \DTLforeach*{CRediTs}{
  \Credrole=credrole, \Credauthor=credauthor}{\textcolor{SedK2}{ \textit{\Credrole}: \Credauthor. }
  }
  \fi
}

\fi

% ----------------------------------------------------------------------------------------
% Page styles
% ----------------------------------------------------------------------------------------
% Preprint styles

\newpagestyle{ps_preprint}[\scriptsize]{
  \headrule
  \sethead[\authors]
  []
  [\itshape\@shorttitle]
  {\authors}
  {}
  {\itshape\@shorttitle}
  \footrule
  \setfoot[PRE-PRINT GENERATED: \today]
  []
  [\thepage]
  {\itshape{\@preprintdeclaration}}
  {}
  {\thepage}
  \renewcommand{\makeheadrule}{\rule[-0.35\baselineskip]{\linewidth}{0.25pt}}
  \renewcommand{\makefootrule}{\rule[0.5\baselineskip]{\linewidth}{0.25pt}}
}

\newpagestyle{ps_preprint_first}[\scriptsize]{
  \headrule
  \sethead[]
  []
  []
  {}
  {\normalsize\@preprintdeclaration}
  {}
  \footrule
  \setfoot[]
  []
  []
  {PRE-PRINT GENERATED: \today}
  {}
  {\thepage}
  \renewcommand{\makeheadrule}{\rule[-0.35\baselineskip]{\linewidth}{0.25pt}}
  \renewcommand{\makefootrule}{\rule[0.5\baselineskip]{\linewidth}{0.25pt}}
}

% ---------------------------------
% Submission styles

\newpagestyle{ps_submission}[\scriptsize]{
  \headrule
  \sethead[\itshape\@shorttitle]
  []
  []
  {\itshape\@shorttitle}
  {}
  {}
  \footrule
  \setfoot[\textcolor{SedK2}{Manuscript submitted to Sedimentologika}]
  []
  [\thepage]
  {\textcolor{SedK2}{Manuscript submitted to Sedimentologika}}
  {}
  {\thepage}
  \renewcommand{\makeheadrule}{\rule[-0.25\baselineskip]{\linewidth}{0.25pt}}
  \renewcommand{\makefootrule}{\rule[0.35\baselineskip]{\linewidth}{0.25pt}}
}

\newpagestyle{ps_submission_first}[\scriptsize]{
  \sethead[\itshape\@shorttitle]
  []
  []
  {\itshape\@shorttitle}
  {}
  {}
  \footrule
  \setfoot[\textcolor{SedK2}{Manuscript submitted to Sedimentologika}]
  []
  [\thepage]
  {\textcolor{SedK2}{Manuscript submitted to Sedimentologika}}
  {}
  {\thepage}
  \renewcommand{\makefootrule}{\rule[0.35\baselineskip]{\linewidth}{0.25pt}}
}

% ---------------------------------
% Proof styles

\newpagestyle{ps_proof}[\scriptsize]{
  \headrule
  \sethead[\textcolor{SedK2}{\authors}]
  []
  [\textcolor{SedK2}{\itshape\@shorttitle}]
  {\textcolor{SedK2}{\authors}}
  {}
  {\textcolor{SedK2}{\itshape\@shorttitle}}
  \footrule
  \setfoot[\textcolor{SedK2}{\textbf{SEDIMENTOLOGIKA}~\textbullet~PROOF}]
  []
  [\textcolor{SedK2}{\thepage}]
  {\textcolor{SedK2}{\textbf{SEDIMENTOLOGIKA}~\textbullet~PROOF}}
  {}
  {\textcolor{SedK2}{\thepage}}
  \renewcommand{\makeheadrule}{\color{SedK1}\rule[-0.25\baselineskip]{\linewidth}{0.25pt}}
  \renewcommand{\makefootrule}{\color{SedK1}\rule[0.5\baselineskip]{\linewidth}{0.25pt}}
}

\newpagestyle{ps_proof_first}[\scriptsize]{
  \sethead[]
  []
  []
  {{\setlength{\tabcolsep}{0pt}
      \begin{tabular}[b]{l}
        \includegraphics[height=12mm]{logos/SedimentologikaLogo.pdf}\\
        \small\textcolor[HTML]{5e5e5e}{\raisebox{-0.4ex}{\normalsize\simpleicon{doi}}}\enspace\small PROOF
      \end{tabular}
  }}
  {}
  {}
  \footrule
  \setfoot[]
  []
  []
  {\textcolor{SedK2}{PROOF~\today}}
  {}
  {\textcolor{SedK2}{\thepage}}
  \renewcommand{\makefootrule}{\color{SedK1}\rule[0.5\baselineskip]{\linewidth}{0.25pt}}
}

% ---------------------------------
% Publication styles

\newpagestyle{ps_publication}[\scriptsize]{
  \headrule
  \sethead[\textcolor{SedK2}{\authors}]
  []
  [\textcolor{SedK2}{\itshape\@shorttitle}]
  {\textcolor{SedK2}{\authors}}
  {}
  {\textcolor{SedK2}{\itshape\@shorttitle}}
  \footrule
  \setfoot[\textbf{SEDIMENTOLOGIKA}~\textbullet~\@theyear~\textbar~Volume~\@volumenumber,~Issue~\@issuenumber]
  []
  [\textcolor{SedK2}{\thepage}]
  {\textbf{SEDIMENTOLOGIKA}~\textbullet~\@theyear~\textbar~Volume~\@volumenumber,~Issue~\@issuenumber}
  {}
  {\textcolor{SedK2}{\thepage}}
  \renewcommand{\makeheadrule}{\color{SedK1}\rule[-0.25\baselineskip]{\linewidth}{0.25pt}}
  \renewcommand{\makefootrule}{\color{SedK1}\rule[0.5\baselineskip]{\linewidth}{0.25pt}}
}

\newpagestyle{ps_publication_first}[\scriptsize]{
  \sethead[]
  []
  []
  {
    {
      \setlength{\tabcolsep}{0pt}
      \begin{tabular}[b]{l}
        \includegraphics[height=12mm]{logos/SedimentologikaLogo.pdf}\\
        \small\textcolor[HTML]{5e5e5e}{\raisebox{-0.4ex}{\normalsize\simpleicon{doi}}}\enspace\small\href{https://doi.org/\@articledoi}{\enspace\small\@articledoi}
      \end{tabular}
    }
  }

  {}
  {}
  \footrule
  \setfoot[]
  []
  []
  {
    \textbf{SEDIMENTOLOGIKA}~\textbullet~\@theyear~\textbar~Volume~\@volumenumber, ~Issue~\@issuenumber~\textbar~eISSN~2813-415X~\textbar~\href{https://www.unige.ch/biblio/en/openaccess/publish-a-journal/open-access-publications/}{Published by Geneva University Library Open Access Publications}
  }
  {}
  {\textcolor{SedK2}{\thepage}}
  \renewcommand{\makefootrule}{\color{SedK1}\rule[0.5\baselineskip]{\linewidth}{0.25pt}}
}

% ----------------------------------------------------------------------------------------
% Class option switches
% ----------------------------------------------------------------------------------------

\if@preprint
\pretitle{
  \begin{RaggedRight}
    \fontsize{18pt}{18pt}\selectfont
    \bfseries
  }
  \else
  \pretitle{
    \begin{RaggedRight}\vspace*{-1\baselineskip}
      \fontsize{18pt}{18pt}\selectfont
      \bfseries
      \textcolor{SedK1}
    }
    \fi

    \posttitle{
      \par
    \end{RaggedRight}
    \vspace{1\baselineskip}
  }

  \preauthor{
    \begin{RaggedRight}
    }

    \postauthor{
      \printCRediTifnotempty
      \@correspondingauthor
      \zsavepos{loc:endauthorblock}
      \if@proof
      \\\textcolor{orange}{\small\fxnote[layout={inline}]{Please review author names and ORCiD links, affilitations, and CRedIT roles.}}
      \fi
    \end{RaggedRight}
    \vspace*{-1mm}
  }

  \predate{}
  \postdate{}
  \date{}

  \if@publication
  \renewcommand\maketitlehooka{\zsavepos{loc:beg_title}}
  \renewcommand\maketitlehookd{%
    \@insert@metadata
    \begin{RaggedRight}
      \begin{textblock*}{0.8\textwidth}[0,1](15mm,277mm)
        \footnotesize\textcolor{SedK1}{This open access article \copyright~\@theyear~\authors~is licensed under the \href{https://creativecommons.org/licenses/by/4.0/}{CC BY 4.0 license.}}
      \end{textblock*}
    \end{RaggedRight}
    \begin{flushright}
      \begin{textblock*}{20mm}[1,1](195mm,277mm)
        \promohref[SedkGrey]{https://creativecommons.org/licenses/by/4.0/}
        {\ccby}
      \end{textblock*}
    \end{flushright}
  }
  \fi

  \if@proof
  \renewcommand\maketitlehooka{\zsavepos{loc:beg_title}}
  \renewcommand\maketitlehookd{%
    \@insert@metadata
    \begin{RaggedRight}
      \begin{textblock*}{0.8\textwidth}[0,1](15mm,277mm)
        \footnotesize\textcolor{SedK1}{This open access article \copyright~\@theyear~\authors~is licensed under the \href{https://creativecommons.org/licenses/by/4.0/}{CC BY 4.0 license.}}
      \end{textblock*}
    \end{RaggedRight}
    \begin{flushright}
      \begin{textblock*}{20mm}[1,1](195mm,277mm)
        \promohref[SedkGrey]{https://creativecommons.org/licenses/by/4.0/}
        {\ccby}
      \end{textblock*}
    \end{flushright}
  }
  \fi

  \if@preprint
  \renewcommand\maketitlehooka{\zsavepos{loc:beg_title}}
  \renewcommand\maketitlehookd{%
    \@insert@preprintdeclaration
    \begin{RaggedRight}
      \begin{textblock*}{0.8\textwidth}[0,1](15mm,276mm)
        \footnotesize\textcolor{SedK1}{This pre-print is provided by the authors}
      \end{textblock*}
    \end{RaggedRight}
  }
  \fi

  \if@submission
  \newcommand{\SedKtitle}[3]{%
    \if@anonymous
    \LARGE\textcolor{SedK1}{\@title}
    \thispagestyle{ps_submission_first}
    \else
    \maketitle
    \thispagestyle{ps_submission_first}
    \fi
    \linenumbers
    \normalsize
    \abstract{#2}
    \plainlanguagesummary{#1}
    #3
    \normalsize
  }
  \else
  \newcommand{\SedKtitle}[3]{%
    \if@preprint
    \else
    \newgeometry{
      hmargin=15mm,
      bmargin=20mm,
      headheight=16mm,
      headsep=2mm,
      tmargin=32mm,
      footskip=5mm,
      marginparsep=1mm,
      marginparwidth=10mm
    }
    \fi
    \twocolumn[
      {
        \maketitle
        \if@preprint
        \thispagestyle{ps_preprint_first}
        \fi
        \if@proof
        \thispagestyle{ps_proof_first}
        \fi
        \if@publication
        \thispagestyle{ps_publication_first}
        \fi
      }
      \if@longauthor
      \else
      \changetext{}{100mm}{}{}{}

      \abstract{#2}
      \fi
      \vspace{\fill}
    ]
    \clearpage
    \restoregeometry
    \ifx#3\@empty
    \twocolumn[
      \if@longauthor
      \abstract{#2}
      \fi
      \plainlanguagesummary{#1}
      \vglue 2\baselineskip
    ]
    \else
    \twocolumn[
      \if@longauthor
      \abstract{#2}
      \fi
      \plainlanguagesummary{#1}
      #3
      \vglue 2\baselineskip
    ]
    \fi
  }
  \fi

  \if@preprint
  \pagestyle{ps_preprint}
  \fi

  \if@submission
  \pagestyle{ps_submission}
  \setkeys{draftwatermark}{text={FOR REVIEW ONLY}, stamp=true}
  \RequirePackage{lineno}
  \renewcommand*\linenumberfont{\scriptsize}
  \linespread{2.0}
  \def\labelitemi{\raisebox{0.35ex}{\tiny$\textbullet$}}
  \fi

  \if@proof
  \pagestyle{ps_proof}
  \setkeys{draftwatermark}{text={PROOF}, stamp=true}
  \AtEndPreamble{
    \hypersetup{%
      pdfauthor={\metaauthlist},
      pdfdate={\metayear},
      pdfcopyright={Copyright © \metayear, \metaauth},
      pdfsubject={Sedimentology},
      pdfkeywords={\metakeywords},
      pdflicenseurl={https://creativecommons.org/licenses/by/4.0/},
      pdfcontactemail={\metacontact},
      pdfpublication={Sedimentologika},
      pdfpublisher={Geneva Library},
      pdfpubtype={journal},
      pdfvolumenum={\metavolume},
      pdfissuenum={\metaissue},
      pdfeissn={2813-415X},
      pdfpubstatus={PROOF},
      pdfdoi={\metadoi}
    }
  }
  \fi

  \if@publication
  \pagestyle{ps_publication}
  \AtEndPreamble{
    \hypersetup{%
      pdfauthor={\metaauthlist},
      pdfdate={\metayear},
      pdfcopyright={Copyright © \metayear, \metaauth},
      pdfsubject={Sedimentology},
      pdfkeywords={\metakeywords},
      pdflicenseurl={https://creativecommons.org/licenses/by/4.0/},
      pdfcontactemail={\metacontact},
      pdfpublication={Sedimentologika},
      pdfpublisher={Geneva Library},
      pdfpubtype={journal},
      pdfvolumenum={\metavolume},
      pdfissuenum={\metaissue},
      pdfeissn={2813-415X},
      pdfpubstatus={VoR},
      pdfdoi={\metadoi}
    }
  }
  \fi

  \if@anonymous
  \pdfvariable suppressoptionalinfo \numexpr2+16+32+64+128 \relax
  \fi
