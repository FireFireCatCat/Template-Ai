% ===========================================
%  CLASS FILE FOR THE ASTROPAH NEWSLETTER
% ===========================================
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{astropah}[2016/05/15 AstroPAH LaTeX class; Developed by Isabel, based on 'article']
\LoadClass[a4paper]{article} %A4

%to include special characteres
%\RequirePackage[T1,T2A]{fontenc} 
%\RequirePackage[utf8]{inputenc}
%\RequirePackage[icelandic,english,brazilian]{babel}

% to make it easy to include diferent letters
\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}
\RequirePackage[english,brazilian]{babel}

% to include the icelandic characters to spell Helgi's name
\RequirePackage{wasysym}

\RequirePackage{graphicx}
\RequirePackage{upgreek} 
\RequirePackage[usenames,dvipsnames]{color}
\RequirePackage{wrapfig}
\RequirePackage[margin=2.0cm]{geometry}
\RequirePackage{float}
\RequirePackage{tocloft}
\RequirePackage{caption}
\RequirePackage{amssymb}
\RequirePackage{textcomp}
\RequirePackage{enumitem}
\RequirePackage{textpos}
\RequirePackage[version=4]{mhchem}
\RequirePackage{titlesec}
\RequirePackage{xcolor}
\RequirePackage{indentfirst}
\RequirePackage{lipsum}

% =======================================================
% Headers & Footers (part 1)
\RequirePackage{fancyhdr}
\setlength{\headheight}{13.8pt} 
\pagestyle{fancy}
% =======================================================

\RequirePackage{multicol}
\RequirePackage{vwcol}
\RequirePackage[linkcolor=blue,colorlinks=true,linkcolor=Purple,urlcolor=Purple]{hyperref}
\urlstyle{same}
\RequirePackage{wallpaper}
\RequirePackage{framed,color}
\definecolor{astrocolor}{rgb}{0.15,0.05,0.92}
\definecolor{shadecolor}{rgb}{0.58,0.20,0.58}

\usepackage{tikz}
\newcommand*{\Line}[3][]{\tikz \draw[#1] #2 -- #3;}%
\renewcommand{\contentsname}{ } 

% =======================================================
\RequirePackage{tcolorbox}
\tcbuselibrary{skins}
% =======================================================

% Text Shadow

\RequirePackage{shadowtext}


% =======================================================
% NORMAL FONT
\renewcommand{\normalsize}{\usefont{OT1}{phv}{m}{n} \fontsize{12}{15} \selectfont}

% Purple text
\newcommand{\purple}[1]{{\textcolor{Purple}{#1}}}
% =======================================================

% =======================================================
% LIKE US ON FACEBOOK SYMBOL AND LINK
\newcommand{\ourface}{\centerline{\href{https://www.facebook.com/astropah}{\includegraphics[width=0.4\textwidth]{images/facebook2.png}}}}
% =======================================================

% paragraph
\setlength{\parskip}{0.2cm}
\renewcommand{\baselinestretch}{1.0}

% improve hyphenation
\pretolerance=5000
\tolerance=2000 
\emergencystretch=10pt



% Necessary to change the title for each language if using babel

\addto\captionsenglish{% Replace "english" with the language you use
  \renewcommand{\contentsname}%
    {}%
}

\addto\captionsbrazilian{
  \renewcommand{\contentsname}%
    {}%
}

\rfoot[\fontsize{12}{12} \usefont{OT1}{phv}{m}{n} AstroPAH - \monthyear\ $\bullet$  Issue \issuenum]{\fontsize{12}{12} \usefont{OT1}{phv}{m}{n} AstroPAH - \monthyear\ $\bullet$  Issue \issuenum}

\cfoot[\fontsize{12}{12} \usefont{OT1}{phv}{m}{n} \thepage]{\fontsize{12}{12} \usefont{OT1}{phv}{m}{n} \thepage}

\rhead{}
\lhead{}

\renewcommand{\headrulewidth}{0.0pt}
\renewcommand{\footrulewidth}{0.0pt}

% by Isabel Aleman

% Various commands that are repeated

\newcommand{\editorsignature}{
  \usefont {OT1} {phv}{b}{n} 
  \Large
  \selectfont
  \vspace{0.3cm}

  \noindent \hfill The Editorial Team
}

\newcommand{\headerspacing}{\vspace*{1.6cm}}

\newcommand{\headergraphic}[1]{
  {\ThisULCornerWallPaper{1.00}{#1}}
  \headerspacing
}

% plop the AstroPAH email whereever
\newcommand{\astropahemail}[1]{\href{mailto:astropah@strw.leidenuniv.nl}{#1}}

% =======================================================
% Section declarations
% =======================================================

% =======================================================
% IN FOCUS section declarations

% This defines the overraching InFocus environment
\newenvironment{infocus}{
  \headergraphic{images/Header_InFocus.png}
  \section*{~}
  \addcontentsline{toc}{section}{In Focus}
}{}

% This defines an environment for interviews
\newenvironment{interview}[1]{
    \begin{center}
        {\infocustitlesmall \noindent \purple{Interview with}}

        {\infocustitle \noindent \purple{#1}}

        \vspace{0.8cm}
    \end{center}
    % revert back to normal stuffs
    \normalsize
}{}

% This defines an interview question
\newcommand{\question}[1]{
  {\vspace{1cm} \noindent\color{Purple}\usefont{OT1}{phv}{b}{n}
  \fontsize{15}{16}\selectfont #1}\\
  }

% =======================================================
% IN FOCUS FONTS
% Main title
\newcommand{\infocustitle}{\usefont{OT1}{phv}{b}{n} \fontsize{30}{34} \selectfont}
% Small title
\newcommand{\infocustitlesmall}{\usefont{OT1}{phv}{b}{n} \fontsize{22}{24} \selectfont}
% Authors
\newcommand{\infocusauthors}{\usefont{OT1}{phv}{b}{n} \fontsize{14}{17} \selectfont}
% Subtitles
\newcommand{\infocussubtitles}{\usefont{OT1}{phv}{b}{n} \fontsize{15}{16} \selectfont}
% =======================================================

% =======================================================
% EDITORIAL section declarations

% This defines an environment for editorials
\newenvironment{editorial}[1]{
    % Do not edit the following commands
    \headergraphic{images/Header_Editorial.png}
    \section*{~}
    \addcontentsline{toc}{section}{Editorial}
    % revert back to normal stuffs
    \normalsize

    {\Large{\textbf{Dear colleagues,}}} \\\\
}{
  \editorsignature
}

% =======================================================
% ABSTRACTS section declarations

% this makes formatting affiliations and authors a lot easier
\RequirePackage{authblk}

% This defines an environment for the abstract part of the newsletter;
% keep in mind this is different from an individual abstract!
\newenvironment{abstracts}{
    % Do not edit the following commands
    \headergraphic{images/Header_Abstracts.png}
    \section*{~}
    \addcontentsline{toc}{section}{Recent Papers }
    % revert back to normal stuffs
    \normalsize
}

% =======================================================
% ABSTRACTS FONTS
\newcommand{\Titlefont}{\usefont{OT1}{phv}{b}{n} \fontsize{18}{19} \selectfont}
\renewcommand\Authfont{\usefont{OT1}{phv}{b}{n} \fontsize{14}{15} \selectfont}
\renewcommand\Affilfont{\usefont{OT1}{phv}{m}{n} \fontsize{10}{15} \itshape \selectfont}
% =======================================================
% Upstream reads "{{\Titlefont \@title}\\ \@author \\ \@affiliation \\}":
% two bugs surface as soon as \begin{abstract} is used with real content
% (rather than left as the empty example in the upstream repo). \@affiliation
% is referenced but never defined anywhere in this class or in authblk (which
% this class loads for \author[n]/\affil[n]) -- authblk's own \@author
% already renders the author AND affiliation list via \AB@affillist, so the
% second field was always redundant. Appending it back-to-back with the
% trailing "\\" after \@author's own line break is also an empty "\\ \\",
% which LaTeX refuses ("There's no line here to end"). Fixed by dropping the
% redundant \@affiliation field rather than patching around it.
% authblk's \@author is stateful across its four internal accumulators
% (\AB@author, \AB@authors, \AB@authlist, \AB@affillist -- which one
% \@author reads from depends on how many affiliations were declared and on
% counter state left over from the PREVIOUS call), and none of the obvious
% resets (\renewcommand, even \global\let on all four plus the counters)
% reliably return it to a clean state for a SECOND \begin{abstract} in the
% same document -- confirmed by tracing every accumulator through two
% abstracts in isolation: the second one's byline kept prepending the
% first's authors no matter which combination of resets ran. The upstream
% repo's own example.tex only ever exercises one \begin{abstract}, so this
% never had to work more than once. Sidestepping authblk here for the byline
% (plain \parbox'd name/affiliation lines, still using \Authfont/\Affilfont
% for matching type) avoids the accumulator entirely rather than fighting it.
\renewenvironment{abstract}[2][]{
  \begin{center}
    {\Titlefont \@title}\\[0.3em]
    {\Authfont #2}\\[0.2em]
    {\Affilfont \begin{tabular}{c}#1\end{tabular}}
  \end{center}
  \vspace{0.5em}
}{
  \vspace{1cm}
}

