%%
%% arabdoc-article.cls — Arabic article class for XeLaTeX
%%
%% Author: Dr Nibras Abo Alzahab <nibras.abo.alzahab@gmail.com>
%% Version: 1.0.0
%% Date: 2025/01/15
%% License: LPPL 1.3c
%%
%% Usage:
%%   \documentclass{arabdoc-article}
%%   \documentclass[12pt,a4paper]{arabdoc-article}
%%   \documentclass[amiri,captions]{arabdoc-article}
%%

\def\arabdocarticleversion{1.0.0}
\def\arabdocarticledate{2025/01/15}
\ProvidesClass{arabdoc-article}[\arabdocarticledate\space v\arabdocarticleversion\space Arabic article class]

%% ============================================
%% Pass options to arabdoc-setup
%% ============================================

% Forward class options to article class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}

% Forward arabdoc-setup options
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

\LoadClass{article}

%% ============================================
%% Load arabdoc-setup with captions enabled by default
%% ============================================

\RequirePackage[captions]{arabdoc-setup}

%% ============================================
%% Geometry (A4 with standard margins)
%% ============================================

\RequirePackage[a4paper,margin=2.5cm,top=2.5cm,bottom=2.5cm,headheight=15pt]{geometry}

%% ============================================
%% Headers / footers
%% ============================================

\pagestyle{fancy}
\fancyhf{}
\fancyhead[R]{\small\itshape \@title}
\fancyhead[L]{\small \@author}
\fancyfoot[C]{\small\thepage}
\renewcommand{\headrulewidth}{0.3pt}
\renewcommand{\footrulewidth}{0pt}

%% ============================================
%% End of class
%% ============================================
\endinput
