%% ----------------------------------------------------
%% Latex class ‘tiet-question-paper’
%%
%% Author: Raghav B. Venkataramaiyer
%% Email: bv.raghav -at- thapar -dot- edu
%% Email: bvraghav -at- gmail -dot- com
%% License: [MIT License](./LICENSE)
%% Version: 2024-06-22
%% ----------------------------------------------------

\NeedsTeXFormat{LaTeX2e}

\ProvidesClass%
{tiet-question-paper}%
[2024-06-22 TIET Question Paper class]

%% -----------------------------------
%% Parent Class
%% -----------------------------------
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass[11pt,a4paper,onecolumn]{article}
%% -----------------------------------

%% -----------------------------------
%% Page Margins
%% -----------------------------------
\RequirePackage[%
  a4paper,%
  left=1in,%
  top=0.5in,%
  right=0.75in,%
  bottom=0.75in%
]{geometry}
%% -----------------------------------

%% -----------------------------------
%% Math package(s)
%% -----------------------------------
\RequirePackage{amsmath}
%% -----------------------------------

%% -----------------------------------
%% Lipsum for debugging
%% -----------------------------------
\RequirePackage{blindtext}
%% -----------------------------------

%% -----------------------------------
%% Check for empty argument
%% -----------------------------------
\RequirePackage{ifmtarg}
%% -----------------------------------

%% -----------------------------------
%% No paragraph indents
%% -----------------------------------
\RequirePackage{parskip}
%% -----------------------------------

%% -----------------------------------
%% Line spacing
%% -----------------------------------
% \RequirePackage{setspace}
% \doublespacing
%% -----------------------------------

%% -----------------------------------
%% Graphics
%% -----------------------------------
\RequirePackage{graphicx}
% \graphicspath{ {./images/} }
%% -----------------------------------

%% -----------------------------------
%% Compact Enumeration
%% -----------------------------------
\RequirePackage[inline,sizes]{enumitem}
% \setlist[enumerate]{itemsep=0in}
\setlist{nosep,leftmargin=*}
\setlist[enumerate,2]{label=\alph*)}
%% -----------------------------------

%% -----------------------------------
%% Extra font sizes
%% -----------------------------------
\RequirePackage{anyfontsize}
%% -----------------------------------

%% -----------------------------------
%% Automatic width computation
%% -----------------------------------
\RequirePackage{linegoal}
%% -----------------------------------

%% -----------------------------------
%% Tabularx
%% -----------------------------------
\RequirePackage{tabularx}
%% -----------------------------------

%% -----------------------------------
%% Box alignment within tables.
%%
%% valign keyword in includegraphics
%% -----------------------------------
\RequirePackage[export]{adjustbox}
%% -----------------------------------

%% -----------------------------------
%% {align} like columnar env.
%%
%% Remembers end of paragraph and starts there.
%% -----------------------------------
% \RequirePackage{paracol}
%% -----------------------------------

%% -----------------------------------
%% Customizing section font
%% -----------------------------------
\RequirePackage{sectsty}
\allsectionsfont{\sffamily}
\paragraphfont{\sffamily}
%% -----------------------------------

%% -----------------------------------
%% Class variable definitions
%% -----------------------------------

% Variable: institute
\def\tiet@institute{Thapar Institute of Engineering \&
  Technology}
\def\institute#1{\gdef\tiet@institute{#1}}

% Variable: abbrevinst
\def\tiet@abbrevinst{\textsc{tiet}}
\def\abbrevinst#1{\gdef\tiet@abbrevinst{#1}}

% Variable: instaddress
\def\tiet@instaddress{Patiala 147004}
\def\instaddress#1{\gdef\tiet@instaddress{#1}}

% Variable: instlogo
\let\tiet@instlogo\relax
\def\instlogo#1{\gdef\tiet@instlogo{#1}}

% Variable: schoolordepartment
\let\tiet@schoolordepartment\relax
\def\schoolordepartment#1{\def\tiet@schoolordepartment{#1}}

% Variable: examname
\let\tiet@examname\relax
\def\examname#1{\def\tiet@examname{#1}}

% Variable: cohort
\let\tiet@cohort\relax
\def\cohort#1{\def\tiet@cohort{#1}}

% Variable: coursecode
\let\tiet@coursecode\relax
\def\coursecode#1{\def\tiet@coursecode{#1}}

% Variable: coursename
\let\tiet@coursename\relax
\def\coursename#1{\def\tiet@coursename{#1}}

% Variable: timeduration
\let\tiet@timeduration\relax
\def\timeduration#1{\def\tiet@timeduration{#1}}

% Variable: maxmarks
\let\tiet@maxmarks\relax
\def\maxmarks#1{\def\tiet@maxmarks{#1}}

% Variable: faculty
\let\tiet@faculty\relax
\def\faculty#1{\gdef\tiet@faculty{#1}}

%% -----------------------------------

%% -----------------------------------
%% Questions Enum
%%
%% Ref: https://tex.stackexchange.com/a/164623
%% Update: Doesn’t help enough.
%% [TODO]
%% -----------------------------------
\DeclareRobustCommand%
% Horizontal rule after each question
\bvrhrule[1][0.4pt]{\rule{\linewidth}{#1}}

\DeclareRobustCommand%
% Skip line
\bvrskipline[1][]{\vspace{#1\baselineskip}}

% \newlist{qenum}{enumerate}{3}
% \setlist[qenum]{nosep,label=\arabic*.}
% % -----------------------------------------------------
% % We need a toggle to track whether the item is first
% % in the list or not
% \newif\ifbvrfirstq\bvrfirstqfalse
% \setlist*[qenum,1]{%
%   label=\arabic*.,%
%   % ---------------------------------------------------
%   % This saves the standard definition of \item and
%   % then redefines it to add the fill if the item is
%   % not first on the list; if it is the first item, it
%   % omits the fill but toggles the bvrfirstq switch so
%   % the next item will trigger it
%   first={% 
%     % -------------------------------------------------
%     % Save the standard definition of \item in a macro,
%     % \olditem
%     \let\olditem\item%
%     % -------------------------------------------------
%     % Set the toggle for first item in the list to true
%     \bvrfirstqtrue%
%     % -------------------------------------------------
%     % New, temporary defition of \item 
%     \def\item{\ifbvrfirstq\olditem\bvrfirstqfalse\else
%         \bvrhrule\bvrskipline\olditem\fi}%
%   },%
%   % ---------------------------------------------------
%   % This takes care of adding the fill for the final
%   % item on the list and just makes sure that \item is
%   % reset to its standard definition
%   after={
%     % -------------------------------------------------
%     % Fill for final item in list
%     \bvrhrule%
%     % -------------------------------------------------
%     % Restore standard definition of \item
%     \let\item\olditem%
%   }%
% }
% \setlist[qenum,2]{label=\alph*),before={},after={},first={}}
% %% -----------------------------------


%% -----------------------------------
%% Write Examination Details and Draw Logo
%% -----------------------------------

\DeclareRobustCommand%
% Write Examination Details
\writeexamdetails{
  \parbox[t][][t]{\linewidth}{\centering\large%
    {\bfseries \tiet@institute\par}

    \vspace*{0.2\baselineskip}
    {\tiet@schoolordepartment}

    \vspace*{0.2\baselineskip}
    {\MakeUppercase\tiet@examname}}  
}
\DeclareRobustCommand%
% Draw Logo
\drawinstlogo{
  \parbox[t][][t]{\linewidth}{\raggedright%
    \includegraphics[width=11.5mm,valign=t]
    {\tiet@instlogo}\par}
}



%% -----------------------------------
%% Title Page
%% -----------------------------------

% Make title
\renewcommand\maketitle{
  {\noindent Roll No. \rule{5cm}{0.4pt} \hfill
    \bfseries\@date\par}

  % \vspace*{0.5\baselineskip}
  {\noindent\large \textbf{\tiet@coursecode :
      \tiet@coursename} \hfill Time:
    \textbf{\tiet@timeduration} \hspace{0.3em}
    MM:\textbf{\tiet@maxmarks}}\\
  {\noindent Faculty: \tiet@faculty}


  \vspace*{\baselineskip}
  \ifx\tiet@instlogo\@empty
    \writeexamdetails
  \else
    \begin{tabularx}{\textwidth}{Xp{18mm}}
      \writeexamdetails & \drawinstlogo
    \end{tabularx}
  \fi

  \par\rule{\textwidth}{0.4pt}
  \par\vspace*{0.5\baselineskip}
}
%% -----------------------------------

%% -----------------------------------
%% Counterlessfootnote
%% -----------------------------------
\newcommand{\footnotenoless}[1]{%
  \let\svthefootnote\thefootnote
  \let\thefootnote\relax\footnote{#1}
  \addtocounter{footnote}{-1}\let\thefootnote\svthefootnote
}
%% -----------------------------------

%% -----------------------------------
%% Abbreviations
%% -----------------------------------
\RequirePackage{xspace}

% Add a period to the end of an abbreviation unless
% there's one already, then \xspace.
\makeatletter
\DeclareRobustCommand\onedot{\futurelet\@let@token\@onedot}
\def\@onedot{\ifx\@let@token.\else.\null\fi\xspace}

\def\eg{\emph{e.g}\onedot}
\def\Eg{\emph{E.g}\onedot}

\def\ie{\emph{i.e}\onedot}
\def\Ie{\emph{I.e}\onedot}

\def\cf{\emph{c.f}\onedot}
\def\Cf{\emph{C.f}\onedot}

\def\etc{\emph{etc}\onedot}

\def\vs{\emph{vs}\onedot}

\def\wrt{w.r.t\onedot}
\def\dof{d.o.f\onedot}

\def\etal{\emph{et al}\onedot}
\makeatother
%% -----------------------------------

