%%
%% arabdoc-report.cls — Arabic report class for XeLaTeX
%%
%% Author: Dr Nibras Abo Alzahab <nibras.abo.alzahab@gmail.com>
%% Version: 1.0.0
%% Date: 2025/01/15
%% License: LPPL 1.3c
%%

\def\arabdocreportversion{1.0.0}
\def\arabdocreportdate{2025/01/15}
\ProvidesClass{arabdoc-report}[\arabdocreportdate\space v\arabdocreportversion\space Arabic report class]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}

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

\LoadClass{report}

\RequirePackage[captions]{arabdoc-setup}

\RequirePackage[a4paper,margin=2.5cm,top=2.5cm,bottom=2.5cm,headheight=15pt]{geometry}

\pagestyle{fancy}
\fancyhf{}
\fancyhead[R]{\small\itshape \@title}
\fancyhead[L]{\small \@author}
\fancyfoot[C]{\small\thepage}
\renewcommand{\headrulewidth}{0.3pt}
\renewcommand{\footrulewidth}{0pt}

\endinput
