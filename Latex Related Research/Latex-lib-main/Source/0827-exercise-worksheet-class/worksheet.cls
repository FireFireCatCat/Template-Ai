\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{worksheet}[2025/09/02 worksheet]
\LoadClass[11pt]{article}
\RequirePackage{amsthm}
\RequirePackage{enumitem}
\RequirePackage{environ}
\RequirePackage{fancyhdr}
\RequirePackage{geometry}
\RequirePackage{lastpage}
\RequirePackage{lmodern}
\RequirePackage{xcolor}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SOLUTIONS OR NO SOLUTIONS %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


\newif\ifshowsolutions
\showsolutionsfalse
\DeclareOption{solutions}{\showsolutionstrue}
\DeclareOption{nosolutions}{\showsolutionsfalse}
\ProcessOptions\relax

%%%%%%%%%%
% HEADER %
%%%%%%%%%%


\pagestyle{fancy}

% Get variables:
\newcommand{\coursename}[1]{\def\@coursename{#1}}
\newcommand{\semester}[1]{\def\@semester{#1}}
\newcommand{\weeknumber}[1]{\def\@weeknumber{#1}}
\newcommand{\worksheetnumbertotal}[1]{\def\@worksheetnumbertotal{#1}}
\newcommand{\worksheetnumber}[1]{\def\@worksheetnumber{#1}}

% Put them in the footer and header
\fancyhf{}
\lhead{\textcolor{gray}{\@semester}}
\chead{\textcolor{gray}{\@coursename.
                        Week \@weeknumber.
                        Worksheet \@worksheetnumber/\@worksheetnumbertotal.}}
\rhead{\ifshowsolutions \textcolor{gray}{Solutions} \else \textcolor{gray}{Exercises} \fi}
\cfoot{\textcolor{gray}{\thepage/\pageref{LastPage}}}
\renewcommand{\headrulewidth}{0pt}

%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EXERCISES AND SOLUTIONS %
%%%%%%%%%%%%%%%%%%%%%%%%%%%

% The exercises and solutions have almost the same definition, so we
% create a function that generates those definitions.

\newcommand{\CreateWorksheetEnvironment}[3]{
  % #1: name for theorem environment
  % #2: display name for theorem environment
  % #3: singular of the enumerate name
  
  % Create the theorem environment:

  \theoremstyle{definition}
  \newtheorem{#1}{#2}
  
  % Create counter for items based on the theorem:

  \newcounter{#3}[#1]
  \expandafter\renewcommand\expandafter{\csname the#3\endcsname}{
    \csname the#1\endcsname.\arabic{#3}
  }
  
  % Create the enumerate environment (plural is inferred):

  \newenvironment{#3s}{
    \begin{enumerate}[
        leftmargin=0pt,
        label=\textbf{\csname the#3\endcsname}
    ]
    \setcounter{enumi}{\value{#3}}
  }{
    \end{enumerate}
  }

  % Create the individual item command:
  \expandafter\newcommand\csname #3\endcsname{
    \stepcounter{#3}
    \item
  }
}

% For exercises, we want:
%   \begin{exercise}
%     Some blabla here.
%     \begin{questions}
%       \item First question.
%       \item Second question.
%     \end{questions}
%   \end{exercise}
% And same for solutions, with `solutions`, `answers` and `answer`.

\CreateWorksheetEnvironment{exercise}{Exercise}{question}
\CreateWorksheetEnvironment{solutionthm}{Solution}{answer}

% Control solution display with the class option

\definecolor{solutioncolor}{rgb}{0.0, 0.18, 0.65}
% That's why we need `solutionthm`!
\NewEnviron{solution}{
  \ifshowsolutions
  \color{solutioncolor}
  \begin{solutionthm}
    \BODY
  \end{solutionthm}
  \color{black}
  \fi
}

\newcommand{\showsolutions}{\showsolutionstrue}
\newcommand{\hidesolutions}{\showsolutionsfalse}
