%% jb-thesis.cls -- document class for PhD theses at ETH Zurich
%%
%% Written by Jonathan Binas <jbinas@ini.ethz.ch>
%%
%% (based on the ut-thesis latex class
%%  by Francois Pitt <fpitt@cs.utoronto.ca>)
%%
%%
%% USAGE:  \documentclass{jb-thesis}
%%         \documentclass[...options...]{jb-thesis}
%%
%% OPTIONS:
%%
%%  - Any standard option for the LaTeX2e `report' class, including
%%    `10pt', `11pt', `12pt', `oneside', `twoside', etc.
%%
%%  - `narrowmargins', `normalmargins', `widemargins', or
%%    `extrawidemargins':  Set the size of the margins, as follows:
%%     . `narrow': 1 1/4" on the left, 3/4" on all other sides,
%%       headers & footers 3/8" from body
%%     . `normal': 1 1/4" on the left, 1" on all other sides,
%%       headers & footers 1/2" from body;
%%     . `wide': 1 1/8 on inner sides and top, 1 1/4" on outer sides,
%%       headers & footers 5/8" from body;
%%     . `extrawide': 1 1/2" on all sides,
%%       headers & footers 3/4" from body.
%%
%%    If you have more than just a few marginal notes, it is recommended
%%    that you use at least `wide' margins.  For other settings, use the
%%    \geometry command (see the template for details).
%%
%%  - `singlespaced', `oneandahalfspaced', or `doublespaced':  Set the
%%    entire document's default line spacing (except for notes, which
%%    are single-spaced by default).  For other settings, use the
%%    \setstretch command (see the template for details).
%%
%%  - `singlespacednotes' or `standardspacednotes':  Set line spacing
%%    for footnotes and marginal notes: either single-spaced or the same
%%    as the rest of the document.
%%
%%  - `cleardoublepagestyleempty', `cleardoublepagestyleplain', or
%%    `cleardoublepagestylestandard':  Set the page style for all
%%    "cleared" pages (empty pages inserted in two-sided documents to
%%    put the next page on the right-hand side) to either `empty',
%%    `plain', or whatever style is in effect when the page is cleared
%%    (the default).
%%
%%  - `draft':  Produce a draft copy (double-sided, double-spaced,
%%    normal margins, with the word "DRAFT" printed at all four corners
%%    of every page).
%%
%% Note that these options can be used to override the default or draft
%% document settings, so that it is possible, for example, to create a
%% double-sided final copy, or a 1 1/2-spaced draft copy with wide
%% margins, etc.  You may use standard LaTeX packages to tailor the
%% layout and formatting in other ways.
%% Also note that when producing double-sided documents while _not_ in
%% draft mode, new chapters and preliminary sections will always start
%% on a right-hand page under the default settings (inserting a blank
%% page if needed).  This can be overridden by using the `openany' or
%% `openright' options.  To achieve this effect for individual sections
%% or chapters, use \cleardoublepage -- or one of the more specific
%% \clearemptydoublepage, \clearplaindoublepage, \clearthesisdoublepage,
%% or \clearstandarddoublepage (see below for details).
%%
%% NEW ENVIRONMENTS and COMMANDS:
%%
%%  * \degree{...}:  (preamble only; REQUIRED)
%%    Specify the name of the degree (e.g., "Doctor of Philosophy").
%%
%%  * \department{...}:  (preamble only; REQUIRED)
%%    Specify the name of the graduate department.
%%
%%  * \gradyear{...}:  (preamble only; REQUIRED)
%%    Specify the year of graduation (defaults to current year).
%%
%%  * \author{...}:  (preamble only; REQUIRED)
%%    Specify the name of the author.
%%
%%  * \title{...}:  (preamble only; REQUIRED)
%%    Specify the title of the thesis.
%%
%%  - \begin{preliminary}...\end{preliminary}:
%%    Delimit head matter (title page, abstract, table of contents,
%%    lists of tables and figures, etc.): set the page style and
%%    numbering for the preliminary sections and reset them for the main
%%    document.
%%
%%     - \maketitle:
%%       Generate the title page from the information supplied in the
%%       preamble.
%%
%%     - \begin{acknowledgements}...\end{acknowledgements}:
%%       Generate an acknowledgements section, if needed.
%%
%%  - \begin{longquote}...\end{longquote}:
%%    Single-spaced version of the `quote' environment.
%%
%%  - \begin{longquotation}...\end{longquotation}:
%%    Single-spaced version of the `quotation' environment.
%%
%%  - \clearemptydoublepage, \clearplaindoublepage,
%%    \clearthesisdoublepage:
%%    Same as \cleardoublepage except that cleared pages have style
%%    `empty', `plain', or `thesis' respectively.
%%
%%  - \clearstandarddoublepage:
%%    Same as the original \cleardoublepage (cleared pages use the style
%%    currently in effect) -- used to override the effects of options
%%    `cleardoublepagestyleempty' or `cleardoublepagestyleplain'.
%%


%%%%%%%%%%%%        IDENTIFICATION        %%%%%%%%%%%%

\newcommand*{\eththesisversion}{v1.0} % current version number
\newcommand*{\eththesisupdated}{2017/06/01} % date of last change(s)

\NeedsTeXFormat{LaTeX2e}[1995/12/01] % robust macros with * form
\ProvidesClass{jb-thesis}[\eththesisupdated\space\eththesisversion\space
   PhD thesis at ETH Zurich]


%%%%%%%%%%%%         INITIAL CODE         %%%%%%%%%%%%

%% Switch for testing draft mode (toggled by `draft' option).
\newif\if@draft
\@draftfalse

\newif\if@rev
\@revfalse

\newif\if@revtitle
\@revtitlefalse

%% Switch for testing current page style.
\newif\if@thesispagestyle
\@thesispagestyletrue

%% Save original definitions of footnote and marginal note macros and
%% lengths, to be able to reset them below as needed (when changing
%% between single-spaced and standard-spaced notes).
\let\@thesis@footnotetext\@footnotetext
\let\@thesis@mpfootnotetext\@mpfootnotetext
\let\@thesis@marginparreset\@marginparreset
\newlength{\@thesisfootnotesep}
\newlength{\@thesismarginparpush}
\AtBeginDocument
  {\setlength\@thesisfootnotesep{\footnotesep}
   \setlength\@thesismarginparpush{\marginparpush}}

%% Save original definition of \cleardoublepage.
\let\clearstandarddoublepage\cleardoublepage

%% The \singlespacing macro from `setspace' includes some vertical space
%% (to make it easier to change line spacing within the document).
%% Unfortunately, this has undesirable side-effects within macros, so we
%% define our own replacement here for use within the class.
\newcommand*{\singlespacingnoskip}{\setstretch{\setspace@singlespace}}


%%%%%%%%%%%%      OPTION DECLARATION      %%%%%%%%%%%%

%% `draft' option: change default document settings.
\DeclareOption{draft}{
    \@drafttrue
    \ExecuteOptions{printrev}
    \ExecuteOptions{printrevtitle}
    \ExecuteOptions{doublespaced}
    \PassOptionsToClass{draft,twoside,openany}{report}
}

\newcommand*{\@draftname}{DRAFT}
\IfFileExists{gitinfo2.sty}{%
    \newcommand*{\@draftrev}{REV \gitAbbrevHash~(\gitCommitterIsoDate)}
}{
    \newcommand*{\@draftrev}{BUILT ON \MakeUppercase\today}
}

\DeclareOption{printrevtitle}{
    \@revtitletrue
    \newcommand*{\@draftrev@c}{%
	\raisebox{-3ex}[0pt][0pt]{\sffamily\scriptsize\color{gray}{\@draftname -- \@draftrev}}%
    }
}

\DeclareOption{printrev}{
    \@revtrue
    \newcommand*{\@draftname@l}%
    {\raisebox{-3ex}[0pt][0pt]{%
	\rlap{\sffamily\scriptsize \@draftname \ \ }}%
    }
    \newcommand*{\@drafname@r}%
    {\raisebox{-3ex}[0pt][0pt]{%
	\llap{\sffamily\scriptsize \ \ \@draftname}}%
    }
    \newcommand*{\@drafname@c}{%
	\raisebox{-3ex}[0pt][0pt]{\sffamily\scriptsize\@draftname}%
    }
    \newcommand*{\@draftrev@l}%
    {\raisebox{-3ex}[0pt][0pt]{%
	\rlap{\sffamily\scriptsize \color{gray}{\@draftname -- \@draftrev} \ \ }}%
    }
    \newcommand*{\@draftrev@r}%
    {\raisebox{-3ex}[0pt][0pt]{%
	\llap{\sffamily\scriptsize \ \ \color{gray}{\@draftname -- \@draftrev}}}%
    }
    \newcommand*{\@draftrev@c}{%
	\raisebox{-3ex}[0pt][0pt]{\sffamily\scriptsize\color{gray}{\@draftname -- \@draftrev}}%
    }
}

%% Margin options.
\DeclareOption{narrowmargins}{\AtEndOfClass % 1 1/4" left, 3/4" others
  {\geometry{margin=.75in,left=1.25in,headsep=.375in-\headheight,
             footskip=.375in,marginparwidth=.5in,marginparsep=.125in}}}
\DeclareOption{normalmargins}{\AtEndOfClass % 1 1/4" left, 1" others
  {\geometry{margin=1in,left=1.25in,headsep=.5in-\headheight,
             footskip=.5in,marginparwidth=.75in,marginparsep=.125in}}}
\DeclareOption{widemargins}{\AtEndOfClass % 1 1/4" all around
  {\geometry{margin=1.25in,inner=1.125in,top=1.125in,bottom=1in,headsep=.615in-\headheight,
             footskip=.375in,marginparwidth=.75in,marginparsep=.25in}}}
\DeclareOption{extrawidemargins}{\AtEndOfClass % 1 1/2" all around
  {\geometry{margin=1.5in,bottom=1.25in,headsep=.75in-\headheight,
             footskip=.75in,marginparwidth=1in,marginparsep=.25in}}}

%% Line Spacing options.
\DeclareOption{singlespaced}{\AtEndOfClass{\singlespacingnoskip}}
\DeclareOption{onehalfspaced}{\AtEndOfClass{\onehalfspacing}}
\DeclareOption{doublespaced}{\AtEndOfClass{\doublespacing}}

%% Line spacing for notes.
\DeclareOption{singlespacednotes}{\AtBeginDocument
  {\setlength\footnotesep{\@thesisfootnotesep}
   \setlength\marginparpush{\@thesismarginparpush}
   \renewcommand{\@footnotetext}[1]%
     {\@thesis@footnotetext{#1\singlespacingnoskip}}
   \renewcommand{\@mpfootnotetext}[1]%
     {\@thesis@mpfootnotetext{#1\singlespacingnoskip}}
   \renewcommand*{\@marginparreset}%
     {\@thesis@marginparreset\singlespacingnoskip}}}
\DeclareOption{standardspacednotes}{\AtBeginDocument
  {\setlength\footnotesep{\baselineskip-\@thesisfootnotesep}
   \setlength\marginparpush{\baselineskip-\@thesismarginparpush}
   \let\@footnotetext\@thesis@footnotetext
   \let\@mpfootnotetext\@thesis@mpfootnotetext
   \let\@marginparreset\@thesis@marginparreset}}

%% Page styles for cleared pages.
\DeclareOption{cleardoublepagestyleempty}
  {\AtEndOfClass{\let\cleardoublepage\clearemptydoublepage}}
\DeclareOption{cleardoublepagestyleplain}
  {\AtEndOfClass{\let\cleardoublepage\clearplaindoublepage}}
\DeclareOption{cleardoublepagestylestandard}
  {\AtEndOfClass{\let\cleardoublepage\clearstandarddoublepage}}

%% All other options are passed to the base class directly.
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}


%%%%%%%%%%%%       OPTION EXECUTION       %%%%%%%%%%%%

%% Default settings: standard options followed by jb-thesis options.
\ExecuteOptions{a4paper,twoside,openright}
\ExecuteOptions{normalmargins,onehalfspaced,singlespacednotes}

%% Process options.
\ProcessOptions


%%%%%%%%%%%%       PACKAGE  LOADING       %%%%%%%%%%%%

%% Load base class using current setting for basic options.
\LoadClass{report}

%% To set/change page layout.
\RequirePackage{calc}
\RequirePackage{geometry}
\RequirePackage{setspace}

%% Version info
\IfFileExists{gitinfo2.sty}{%
  \RequirePackage{gitinfo2}%
}{%
  \PackageWarning{jb-thesis}{%
    Package gitinfo2 not available, \MessageBreak
    revision information will not be printed \MessageBreak
  }%
}%

%% Microtype
\IfFileExists{microtype.sty}{%
  \RequirePackage[activate={true,nocompatibility},tracking=true,kerning=true,spacing=true,stretch=10,shrink=10]{microtype}%
}{%
  \PackageWarning{jb-thesis}{%
    Package microtype not available, \MessageBreak
    micro-typography will not be applied \MessageBreak
  }%
}%



%%%%%%%%%%%%          MAIN  CODE          %%%%%%%%%%%%

%%%%%%    Parameters

%% The following five commands set the respective field values so we can
%% generate the title page and abstract page automatically.
\newcommand*{\degree}[1]%
  {\ifx\empty#1\empty\else\gdef\@degree{#1}\fi}
\newcommand*{\degreeabbr}[1]%
  {\ifx\empty#1\empty\else\gdef\@degreeabbr{#1}\fi}
\newcommand*{\dissno}[1]%
  {\ifx\empty#1\empty\else\gdef\@dissno{#1}\fi}
\newcommand*{\department}[1]%
  {\ifx\empty#1\empty\else\gdef\@department{#1}\fi}
\newcommand*{\gradyear}[1]%
  {\ifx\empty#1\empty\else\gdef\@gradyear{#1}\fi}
\newcommand*{\acadtitle}[1]%
  {\ifx\empty#1\empty\else\gdef\@acadtitle{#1}\fi}
\newcommand*{\born}[1]%
  {\ifx\empty#1\empty\else\gdef\@born{#1}\fi}
\newcommand*{\citizen}[1]%
  {\ifx\empty#1\empty\else\gdef\@citizen{#1}\fi}
\newcommand*{\examiners}[1]%
  {\ifx\empty#1\empty\else\gdef\@examiners{#1}\fi}
\renewcommand*{\author}[1]%
  {\ifx\empty#1\empty\else\gdef\@author{#1}\fi}
\renewcommand*{\title}[1]%
  {\ifx\empty#1\empty\else\gdef\@title{#1}\fi}

%% Default values for the required fields.
\degree{\emph{(degree)}}
\degreeabbr{\emph{(degree abbreviation)}}
\dissno{\emph{(dissertation no.)}}
\department{\emph{(department)}}
\gradyear{\emph{(year of graduation)}}
\author{\emph{(author)}}
\acadtitle{\emph{(acad. title)}}
\born{\emph{(date of birth)}}
\citizen{\emph{(nationality)}}
\examiners{\emph{(examiners)}}
\title{\emph{(title)}}

%%%%%%    New formatting environments and commands.

%% \begin{preliminary} sets the pagestyle and page numbering for the
%% preliminary sections; \end{preliminary} resets the page numbering.
%% The default page style is used outside of the preliminary block.
\newenvironment*{preliminary}%
  {\pagestyle{prelim}\pagenumbering{roman}}%
  {\cleardoublepage\pagenumbering{arabic}}

%% Change \maketitle
\renewcommand*{\maketitle}%
  {\begin{titlepage}
  \singlespacingnoskip
   \begin{center}
      \mbox{}
      \vfill
      {\sc Diss. ETH no. \@dissno}\\
      \vfill \vfill
      {\sc\Large\@title}\\
      \vfill \vfill
      A thesis submitted to attain the degree of \\
      {\@degree}
      \vfill
      {(\@degreeabbr)}
      \vfill \vfill
      presented by \\
      \vfill
      {\@author}\\
      \vfill
      {\@acadtitle}\\
      \vfill
      {born on \@born}\\
      \vfill
      {citizen of \@citizen}\\
      \vfill \vfill
      accepted on the recommendation of
      \vfill
      {\@examiners}
      \vfill
      {\@gradyear}
      \vfill
      \if@revtitle\hfil\@draftrev@c\hfil\fi
      \mbox{}
   \end{center}
   \setcounter{page}{1}
   \end{titlepage}
   \setcounter{page}{2}
   }

%% Change \begin{abstract}...\end{abstract}
\renewenvironment*{abstract}{%
   \section*{Abstract}
   \begingroup
   %% Adjust line spacing: if it was less than 2, increase it to 2;
   %% otherwise, leave it as is.
   \ifdim \baselinestretch pt < 1.6pt \doublespacing\fi}%
  {\par\endgroup\newpage}

%% \begin{dedication}...\end{dedication} formats a dedication section
%% (*not* on a separate page -- just a paragraph formatted flush right).
\newenvironment*{dedication}%
  {\begin{flushright}}%
  {\end{flushright}}

%% \begin{acknowledgements}...\end{acknowledgements} formats an
%% acknowledgements section (*not* on a separate page).
\newenvironment*{acknowledgements}%
  {\begin{center}
      \section*{Acknowledgements}
   \end{center}
   \begingroup\noindent}%
  {\par\endgroup}

%% Redefine `thebibliography' environment so that it generates headers
%% in the same style as the rest of the document.
\let\@thesisthebibliography\thebibliography
\renewcommand*{\thebibliography}[1]{%
   \@thesisthebibliography{#1}
   \if@thesispagestyle%
       \@mkboth{\sffamily\small\bibname}{\sffamily\small\bibname}
   \fi}



%% Variations of \cleardoublepage that explicitly set the pagestyle of
%% any inserted blank page.
\newcommand*{\clearemptydoublepage}%
  {{\pagestyle{empty}\clearstandarddoublepage}}
\newcommand*{\clearplaindoublepage}%
  {{\pagestyle{plain}\clearstandarddoublepage}}
\newcommand*{\clearthesisdoublepage}%
  {{\pagestyle{thesis}\clearstandarddoublepage}}

%% Single-spaced quotes and quotations.
\newenvironment*{longquote}%
  {\begin{quote}\singlespacingnoskip}{\end{quote}}
\newenvironment*{longquotation}%
  {\begin{quotation}\singlespacingnoskip}{\end{quotation}}

%%%%%%    Page Styles

%% Redefine standard page styles empty, plain, and headings,
%% based on the definitions in `report', and include draft
%% information if applicable.  Then, define a new pagestyle `thesis'.

%% Pagestyle `empty'.
\renewcommand*{\ps@empty}%
  {\@thesispagestylefalse
   \let\@mkboth\@gobbletwo
   \def\@oddfoot{\if@rev\hfil\@draftrev@c\hfil\fi}%
   \let\@evenfoot\@oddfoot
   \def\@oddhead{}%
   \let\@evenhead\@oddhead}

%% Pagestyle `plain'.
\renewcommand*{\ps@plain}%
  {\@thesispagestylefalse
   \let\@mkboth\@gobbletwo
   \def\@oddfoot{\if@rev\hfil\@draftrev@c\hfil\fi}%
   \let\@evenfoot\@oddfoot
   \def\@oddhead{}%
   \let\@evenhead\@oddhead}

%% Pagestyle `headings'.
\if@twoside % two-sided printing
\renewcommand*{\ps@headings}%
  {\@thesispagestylefalse
   \let\@mkboth\markboth
   \def\@oddfoot{\if@rev\hfil\@draftrev@c\hfil\fi}%
   \let\@evenfoot\@oddfoot
   \def\@oddhead{\sffamily\small\rightmark\hfil\thepage}%
   \def\@evenhead{\sffamily\small\thepage\hfil\leftmark}%
   \def\chaptermark##1{\markboth
      {\ifnum \c@secnumdepth >\m@ne
	      \textbf{\@chapapp\ \thechapter}\, \ \fi ##1}{}}%
   \def\sectionmark##1{\markright
      {\ifnum \c@secnumdepth >\z@
	      \textbf{\thesection}\, \ \fi ##1}}}
\else % one-sided printing
\renewcommand*{\ps@headings}%
  {\@thesispagestylefalse
   \let\@mkboth\markboth
   \def\@oddfoot{\if@rev\hfil\@draftrev@c\hfil\fi}%
   \def\@oddhead{\sffamily\small\rightmark\hfil\thepage}%
   \def\chaptermark##1{\markright
      {\ifnum \c@secnumdepth >\m@ne
	      \textbf{\@chapapp\ \thechapter}\, \ \fi ##1}}}
\fi%@twoside

%% Pagestyle `thesis' (based on `headings').
\if@twoside % two-sided printing
\newcommand*{\ps@thesis}%
  {\@thesispagestyletrue
   \let\@mkboth\markboth
   \def\@oddfoot{\if@rev\hfil\@draftrev@c\hfil\fi}%
   \let\@evenfoot\@oddfoot
   \def\@oddhead{\sffamily\small\rightmark\hfil\thepage}%
   \def\@evenhead{\sffamily\small\thepage\hfil\leftmark}%
   \def\chaptermark##1{\markboth
      {\ifnum \c@secnumdepth >\m@ne
	      \textbf{\@chapapp\ \thechapter}\, \ \fi ##1}{}}%
   \def\sectionmark##1{\markright
      {\ifnum \c@secnumdepth >\z@
	      \textbf{\thesection}\, \ \fi ##1}}}
\else % one-sided printing
\newcommand*{\ps@thesis}%
  {\@thesispagestyletrue
   \let\@mkboth\markboth
   \def\@oddfoot{\if@rev\hfil\@draftrev@c\hfil\fi}%
   \def\@oddhead{\sffamily\small\rightmark\hfil\thepage}%
   \def\chaptermark##1{\markright
      {\ifnum \c@secnumdepth >\m@ne
	      \textbf{\@chapapp\ \thechapter}\, \ \fi ##1}}}
\fi%@twoside

%% Pagestyle \prelim' (based on \thesis').
\if@twoside % two-sided printing
\newcommand*{\ps@prelim}%
  {\@thesispagestylefalse
   \let\@mkboth\markboth
   \if@rev
       \def\@oddfoot{\sffamily\small\hfil\thepage\hfil\@draftrev@r}%
       \def\@evenfoot{\sffamily\small\@draftrev@l\hfil\thepage\hfil}%
   \else
       \def\@oddfoot{\sffamily\small\hfil\thepage\hfil}%
       \let\@evenfoot\@oddfoot
   \fi%@rev
   \def\@oddhead{}%
   \def\@evenhead{}%
   \def\chaptermark##1{\markboth
      {\ifnum \c@secnumdepth >\m@ne
	      \textbf{\@chapapp\ \thechapter}\, \ \fi ##1}{}}%
   \def\sectionmark##1{\markright
      {\ifnum \c@secnumdepth >\z@
	      \textbf{\thesection}\, \ \fi ##1}}}
\else % one-sided printing
\newcommand*{\ps@prelim}%
  {\@thesispagestylefalse
   \let\@mkboth\markboth
   \if@rev
       \def\@oddfoot{\sffamily\small\hfil\thepage\hfil\@draftrev@r}%
   \else
       \def\@oddfoot{\sffamily\small\hfil\thepage\hfil}%
   \fi%@rev
   \def\@oddhead{}%
   \def\chaptermark##1{\markright
      {\ifnum \c@secnumdepth >\m@ne
	      \textbf{\@chapapp\ \thechapter}\, \ \fi ##1}}}
\fi%@twoside

%% Customize header formating
\renewcommand\section{\@startsection {section}{1}{\z@}%
  {-3.5ex \@plus -1ex \@minus -.2ex}%
  {2.3ex \@plus.2ex}%
  {\normalfont\Large\bf\sffamily}}
\renewcommand\subsection{\@startsection{subsection}{2}{\z@}%
  {-3.25ex\@plus -1ex \@minus -.2ex}%
  {1.5ex \@plus .2ex}%
  {\normalfont\large\bf\sffamily}}
\renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
  {-3.25ex\@plus -1ex \@minus -.2ex}%
  {1.5ex \@plus .2ex}%
  {\normalfont\normalsize\bf\sffamily}}
\renewcommand\paragraph{\@startsection{paragraph}{4}{\z@}%
  {3.25ex \@plus 1ex \@minus .2ex}%
  {-1ex}%
  {\normalfont\normalsize\bf\sffamily}}
\renewcommand\subparagraph{\@startsection{subparagraph}{5}{\parindent}%
  {3.25ex \@plus 1ex \@minus .2ex}%
  {-1em}%
  {\normalfont\normalsize\bf\sffamily}}

%% Chapter heading
\def\@makechapterhead#1{%
        \vspace*{50\p@}%
        {\parindent \z@ \raggedright \normalfont
      	  \ifnum \c@secnumdepth >\m@ne
	  \Large\sffamily\bfseries \@chapapp\space\thechapter\par\nobreak
      	  \vskip 20\p@
      	  \fi
      	  \interlinepenalty\@M
	  \huge #1\par\nobreak
      	  \vskip 40\p@
        }
}

\def\@makeschapterhead#1{%
    \vspace*{50\p@}%
    {\parindent \z@ \raggedright
	\normalfont
	\interlinepenalty\@M
	\huge\sffamily\bfseries #1\par\nobreak
	\vskip 40\p@
    }
}

%% Part heading / ToC entry
\def\partextra{}
\newcommand\setpartextra[1]{\def\partextra{#1}}

\renewcommand\part{%
    \cleardoublepage
    \thispagestyle{plain}%
    \if@twocolumn
	\onecolumn
	\@tempswatrue
    \else
	\@tempswafalse
    \fi
    \null\vfil
\secdef\@part\@spart}

\def\@part[#1]#2{%
    \ifnum \c@secnumdepth >-2\relax
    \refstepcounter{part}%
	\addcontentsline{toc}{part}{%
	    \llap{\makebox[0.9em][l]{\thepart}}\hspace{1.2em}#1}%
    \else
	\addcontentsline{toc}{part}{#1}%
    \fi
    \markboth{\textbf{\partname\ \thepart}\, \ #1}{}
    {\centering
	\interlinepenalty \@M
	\normalfont
	\ifnum \c@secnumdepth >-2\relax
	    {\LARGE\scshape \MakeUppercase{\partname\quad\thepart}}
	    \par\vskip 25\p@
	\fi
	{\huge\sffamily\bfseries#2\par}%
    }%
    \vskip 4in\mbox{}
    \partextra%
    \def\partextra{}%
    \@endpart%
}

\def\@spart#1{%
    \addcontentsline{toc}{part}{#1}%
    \markboth{#1}{}
    \vspace*{50\p@}%
    {\parindent \z@ \raggedright
	\normalfont
	\interlinepenalty\@M
	\huge\sffamily\bfseries #1\par\nobreak
	\vskip 40\p@
    }
    \partextra%
    \def\partextra{}%
}


%% Hanging section numbers
\def\@seccntformat#1{\llap{\normalfont\sffamily\csname the#1\endcsname\quad}}

%% Caption style
\def\@captionwidth{0.9\hsize}
\long\def\@makecaption#1#2{%
  \vskip\abovecaptionskip
  \sbox\@tempboxa{\textbf{\sffamily#1}\hspace{1.5ex}#2}%
  \ifdim \wd\@tempboxa >\@captionwidth
  \hb@xt@\hsize{\hfil\parbox{\@captionwidth}{%
	  \textbf{\sffamily#1}\hspace{1.5ex}#2}\hfil}%
  \else
    \global \@minipagefalse
    \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
  \fi
  \vskip\belowcaptionskip}


%% introduce non-numbered footnotes
\def\blfootnote{\xdef\@thefnmark{}\@footnotetext}

%% in-section acknowledgment
\newcommand\acknowledge[1]{
    \begin{singlespace*}
	\vskip 1em
	\emph{\small\textbf{Acknowledgment.} #1}
	\vskip 1em
    \end{singlespace*}
}


%% Default page style.
\pagestyle{thesis}
