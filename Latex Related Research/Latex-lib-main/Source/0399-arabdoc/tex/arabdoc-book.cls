%%
%% arabdoc-book.cls — Arabic book class for XeLaTeX
%%
%% Author: Dr Nibras Abo Alzahab <nibras.abo.alzahab@gmail.com>
%% Version: 1.0.0
%% Date: 2025/01/15
%% License: LPPL 1.3c
%%
%% Usage:
%%   \documentclass{arabdoc-book}
%%   \documentclass[12pt,a4paper,twoside]{arabdoc-book}
%%   \documentclass[amiri,captions]{arabdoc-book}
%%

\def\arabdocbookversion{1.0.0}
\def\arabdocbookdate{2025/01/15}
\ProvidesClass{arabdoc-book}[\arabdocbookdate\space v\arabdocbookversion\space Arabic book class]

%% ============================================
%% Pass options
%% ============================================

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

%% ============================================
%% Load base class
%% ============================================

\LoadClass{book}

%% ============================================
%% Load arabdoc-setup with captions
%% ============================================

\RequirePackage[captions]{arabdoc-setup}

%% ============================================
%% Geometry
%% ============================================

\RequirePackage[a4paper,margin=2.5cm,top=2.5cm,bottom=2.5cm,headheight=15pt]{geometry}

%% ============================================
%% Headers / footers (book style)
%% ============================================

\pagestyle{fancy}
\fancyhf{}
\fancyhead[RE]{\small\nouppercase{\leftmark}}
\fancyhead[LO]{\small\nouppercase{\rightmark}}
\fancyfoot[C]{\small\thepage}
\renewcommand{\headrulewidth}{0.3pt}
\renewcommand{\footrulewidth}{0pt}

%% ============================================
%% End of class
%% ============================================
\endinput
