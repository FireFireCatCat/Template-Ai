%%
%% arabdoc-thesis.cls — Arabic thesis class for XeLaTeX
%%
%% Author: Dr Nibras Abo Alzahab <nibras.abo.alzahab@gmail.com>
%% Version: 1.0.0
%% Date: 2025/01/15
%% License: LPPL 1.3c
%%
%% Features:
%%   - Title page with university, supervisor, degree
%%   - Front matter (abstract, acknowledgments, TOC)
%%   - Main matter with chapters
%%   - Back matter (bibliography, appendices)
%%   - 1.5 line spacing (standard for Arabic theses)
%%

\def\arabdocthesisversion{1.0.0}
\def\arabdocthesisdate{2025/01/15}
\ProvidesClass{arabdoc-thesis}[\arabdocthesisdate\space v\arabdocthesisversion\space Arabic thesis class]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}

\DeclareOption{amiri}{\PassOptionsToPackage{\CurrentOption}{arabdoc-setup}}
\DeclareOption{scheherazade}{\PassOptionsToPackage{\CurrentOption}{arabdoc-setup}}
\DeclareOption{lateef}{\PassOptionsToPackage{\CurrentOption}{arabdoc-setup}}
\DeclareOption{custom}{\PassOptionsToPackage{\CurrentOption}{arabdoc-setup}}
\DeclareOption{maghrib}{\PassOptionsToPackage{\CurrentOption}{arabdoc-setup}}
\DeclareOption{arabicdigits}{\PassOptionsToPackage{\CurrentOption}{arabdoc-setup}}
\DeclareOption{gregorian}{\PassOptionsToPackage{\CurrentOption}{arabdoc-setup}}
\DeclareOption{islamic}{\PassOptionsToPackage{\CurrentOption}{arabdoc-setup}}
\DeclareOption{captions}{\PassOptionsToPackage{\CurrentOption}{arabdoc-setup}}
\DeclareOption{colorlinks}{\PassOptionsToPackage{\CurrentOption}{arabdoc-setup}}
\DeclareOption{legal-sections}{\PassOptionsToPackage{\CurrentOption}{arabdoc-setup}}
\DeclareOption{default-sections}{\PassOptionsToPackage{\CurrentOption}{arabdoc-setup}}

\ProcessOptions

\LoadClass[12pt,a4paper,openright]{book}

\RequirePackage[captions]{arabdoc-setup}

\RequirePackage[a4paper,margin=3cm,top=3cm,bottom=3cm,headheight=15pt]{geometry}

%% ============================================
%% Thesis-specific metadata
%% ============================================

\def\@university{اسم الجامعة}
\def\@college{اسم الكلية}
\def\@department{اسم القسم}
\def\@supervisor{اسم المشرف}
\def\@degree{درجة الماجستير}
\def\@subject{التخصص}

\newcommand{\university}[1]{\def\@university{#1}}
\newcommand{\college}[1]{\def\@college{#1}}
\newcommand{\department}[1]{\def\@department{#1}}
\newcommand{\supervisor}[1]{\def\@supervisor{#1}}
\newcommand{\degree}[1]{\def\@degree{#1}}
\newcommand{\subject}[1]{\def\@subject{#1}}

%% ============================================
%% Title page
%% ============================================

\renewcommand{\maketitle}{%
  \begin{titlepage}
  \centering
  \vspace*{2cm}
  
  {\Large \@university}\\[0.5em]
  {\large \@college}\\[0.3em]
  {\large \@department}\\[2cm]
  
  {\LARGE\bfseries \@title}\\[2cm]
  
  {\large رسالة مقدمة استكمالاً لمتطلبات نيل درجة}\\[0.5em]
  {\large\bfseries \@degree}\\[0.3em]
  {\large في \@subject}\\[2cm]
  
  \begin{minipage}{0.45\textwidth}
  \begin{flushleft}
  \large إعداد الطالب:\\[0.3em]
  \large\bfseries \@author
  \end{flushleft}
  \end{minipage}
  \hfill
  \begin{minipage}{0.45\textwidth}
  \begin{flushright}
  \large إشراف:\\[0.3em]
  \large\bfseries \@supervisor
  \end{flushright}
  \end{minipage}\\[2cm]
  
  {\large \@date}\\[1cm]
  
  \end{titlepage}
}

%% ============================================
%% Headers / footers
%% ============================================

\pagestyle{fancy}
\fancyhf{}
\fancyhead[RE]{\small\nouppercase{\leftmark}}
\fancyhead[LO]{\small\nouppercase{\rightmark}}
\fancyfoot[C]{\small\thepage}
\renewcommand{\headrulewidth}{0.3pt}
\renewcommand{\footrulewidth}{0pt}

%% ============================================
%% Front matter environment
%% ============================================

\renewcommand{\frontmatter}{%
  \cleardoublepage
  \@mainmatterfalse
  \pagenumbering{roman}
}

\renewcommand{\mainmatter}{%
  \cleardoublepage
  \@mainmattertrue
  \pagenumbering{arabic}
}

%% ============================================
%% Abstract environment (book class doesn't have one)
%% ============================================

\newenvironment{abstract}{%
  \cleardoublepage
  \thispagestyle{plain}
  \begin{center}
  {\Large\bfseries الملخص}
  \end{center}
  \vspace{1em}
}{%
  \par\vspace{1em}
  \noindent\textbf{الكلمات المفتاحية:} 
  \cleardoublepage
}

\endinput
