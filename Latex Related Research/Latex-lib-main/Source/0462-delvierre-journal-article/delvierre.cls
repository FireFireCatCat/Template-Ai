%
% delvierre.cls
% Copyright 2026 Szoke Mark-Andor
%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either version 1.3c
% of this license or (at your option) any later version.
% The latest version of this license is in
%   https://www.latex-project.org/lppl.txt
% and version 1.3c or later is part of all distributions of LaTeX
% version 2008 or later.
%
% This work has the LPPL maintenance status `maintained'.
%
% The Current Maintainer of this work is Szoke Mark-Andor <editorial@delvierre.com>.
%
% This work consists of the files delvierre.cls, delvierre-template.tex,
% delvierre-doc.tex, delvierre-doc.pdf, README.md, LICENSE,
% and graphical-abstract.png.
%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{delvierre}[2026/03/28 v1.0 Delvierre journal article class]

% -------------------------
% Options
% -------------------------
\newif\ifDelvierre@mono
\Delvierre@monofalse
\DeclareOption{mono}{\Delvierre@monotrue}
\DeclareOption{color}{\Delvierre@monofalse}
\ExecuteOptions{color}
\ProcessOptions\relax

% --- Base class ---
\LoadClass[a4paper,10pt,twocolumn]{article}
\raggedbottom

% --- Encoding & typography ---
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage{newtxtext}
\RequirePackage{newtxmath}
\RequirePackage{newtxtt}
\RequirePackage[tracking=true]{microtype}
\RequirePackage{amsmath}
\RequirePackage{ragged2e}
\RequirePackage{indentfirst}

% --- Layout ---
\RequirePackage{geometry}

% Store geometry values so \setfootskip and \setdelvierremargins can reliably re-apply.
\def\Delvierre@geomtop{1.00cm} % moved header slightly up
\def\Delvierre@geombottom{1.20cm} % moved footer slightly down
\def\Delvierre@geomleft{1.20cm}
\def\Delvierre@geomright{1.20cm}
\def\Delvierre@geomfootskip{1.20cm}
\def\Delvierre@geomheadheight{18pt}
\def\Delvierre@geomheadsep{8pt}

\newcommand{\Delvierre@ApplyGeometry}{%
  \geometry{%
    top=\Delvierre@geomtop,
    bottom=\Delvierre@geombottom,
    left=\Delvierre@geomleft,
    right=\Delvierre@geomright,
    includehead,
    includefoot,
    heightrounded,
    headheight=\Delvierre@geomheadheight,
    headsep=\Delvierre@geomheadsep,
    columnsep=0.8cm,
    footskip=\Delvierre@geomfootskip
  }%
}
\Delvierre@ApplyGeometry

% Helper: allow authors to tune margins in the preamble
\newcommand{\setdelvierremargins}[4]{%
  \def\Delvierre@geomtop{#1}%
  \def\Delvierre@geombottom{#2}%
  \def\Delvierre@geomleft{#3}%
  \def\Delvierre@geomright{#4}%
  \Delvierre@ApplyGeometry
}

% Helper: tune how low the footer baseline sits (MUST be used in the preamble)
\@ifundefined{setfootskip}{%
\newcommand{\setfootskip}[1]{%
  \def\Delvierre@geomfootskip{#1}%
  \setlength{\footskip}{#1}%
  \Delvierre@ApplyGeometry
}%
}{%
\renewcommand{\setfootskip}[1]{%
  \def\Delvierre@geomfootskip{#1}%
  \setlength{\footskip}{#1}%
  \Delvierre@ApplyGeometry
}%
}

% -------------------------
% First-page footer spacing knobs
% -------------------------
% To squeeze a bit more text (e.g., more Highlights bullets) onto page 1 without
% changing page 2+, set a smaller first-page footskip in the preamble:
%   \setfirstpagefootskip{2.4cm}
% A value of 0pt disables the special first-page geometry.
\newlength{\DelvierreFirstPageFootskip}
\setlength{\DelvierreFirstPageFootskip}{0pt}
\newcommand{\setfirstpagefootskip}[1]{\setlength{\DelvierreFirstPageFootskip}{#1}}

% Fine-tune whitespace inside the first-page footer note
\newlength{\DelvierreFirstPageFooterEmailGap}
\setlength{\DelvierreFirstPageFooterEmailGap}{\baselineskip}
\newcommand{\setfirstpagefooteremailgap}[1]{\setlength{\DelvierreFirstPageFooterEmailGap}{#1}}

% Raise/lower the *first-page* footer note without changing page geometry.
% Positive values move the footer note UP.
% Raise/lower the *first-page* footer note without changing page geometry.
% Positive values move the footer note UP, but it will be CLAMPED so it can't overlap body text.
\newlength{\DelvierreFirstPageFooterRaiseRequested}
\newlength{\DelvierreFirstPageFooterRaise}

\setlength{\DelvierreFirstPageFooterRaiseRequested}{0pt}
\setlength{\DelvierreFirstPageFooterRaise}{0pt}
\newcommand{\setfirstpagefooterraise}[1]{\setlength{\DelvierreFirstPageFooterRaiseRequested}{#1}}

% Reserve vertical space on page 1 so content doesn't overlap a raised first-page footer.
% Useful if you use a large \setfirstpagefooterraise{...}.
\newlength{\DelvierreFirstPageFooterReserve}
\setlength{\DelvierreFirstPageFooterReserve}{0pt}
\newcommand{\setfirstpagefooterreserve}[1]{\setlength{\DelvierreFirstPageFooterReserve}{#1}}

% Minimum vertical clearance between the *top* of the first-page footer note (its rule line)
% and the last line of body/Highlights above it.
\newlength{\DelvierreFirstPageFooterClearGap}
\setlength{\DelvierreFirstPageFooterClearGap}{0.2cm}
\newcommand{\setfirstpagefootercleargap}[1]{\setlength{\DelvierreFirstPageFooterClearGap}{#1}}

% -------------------------
% Automatic first-page footer clearance (prevents overlap when footer is raised or made taller)
% -------------------------
\newsavebox{\Delvierre@FirstPageFooterBox}
\newlength{\DelvierreFirstPageFooterHeight}
\newlength{\DelvierreFirstPageAutoReserve}
\setlength{\DelvierreFirstPageAutoReserve}{0pt}

\newif\ifDelvierreAutoReserveFirstFooter
\DelvierreAutoReserveFirstFootertrue
\newcommand{\autoreservefirstpagefooter}{\DelvierreAutoReserveFirstFootertrue}
\newcommand{\noautoreservefirstpagefooter}{\DelvierreAutoReserveFirstFooterfalse}

\newcommand{\Delvierre@ComputeFirstPageAutoReserve}{%
  % Measure the actual first-page footer box total height (height + depth).
  % Includes the footer rule + all lines + email gap.
  \sbox{\Delvierre@FirstPageFooterBox}{\Delvierre@FirstPageFooter}%
  \setlength{\DelvierreFirstPageFooterHeight}{\dimexpr\ht\Delvierre@FirstPageFooterBox+\dp\Delvierre@FirstPageFooterBox\relax}%
  % If you raise the footer by \DelvierreFirstPageFooterRaise, its TOP moves up too.
  % To prevent any text crossing the footer rule, enforce:
  %   footskip + reserve >= footerHeight + raise + clearGap
  \setlength{\@tempdima}{\DelvierreFirstPageFooterHeight}%
  \addtolength{\@tempdima}{\DelvierreFirstPageFooterRaise}%
  \addtolength{\@tempdima}{\DelvierreFirstPageFooterClearGap}%
  \addtolength{\@tempdima}{-\footskip}%
  % Small safety cushion:
  \addtolength{\@tempdima}{2pt}%
  \ifdim\@tempdima<0pt\relax \setlength{\@tempdima}{0pt}\fi
  \global\setlength{\DelvierreFirstPageAutoReserve}{\@tempdima}%
}

\newlength{\DelvierreFirstPageFooterRuleSep}
\setlength{\DelvierreFirstPageFooterRuleSep}{0.35em}
\newcommand{\setfirstpagefooterrulesep}[1]{\setlength{\DelvierreFirstPageFooterRuleSep}{#1}}
% First-page footer note: font size and paragraph skip (tunable)
\newcommand{\DelvierreFirstPageNoteSize}{\footnotesize}
\newcommand{\setfirstpagefootnotesize}[1]{\def\DelvierreFirstPageNoteSize{#1}}
\newlength{\DelvierreFirstPageFooterParskip}
\setlength{\DelvierreFirstPageFooterParskip}{2pt}
\newcommand{\setfirstpagefooterparskip}[1]{\setlength{\DelvierreFirstPageFooterParskip}{#1}}

\newif\ifDelvierreDidNewGeometry
\DelvierreDidNewGeometryfalse

\newcommand{\DelvierreNewGeometryWithFootskip}[1]{%
  \newgeometry{%
    top=\Delvierre@geomtop,
    bottom=\Delvierre@geombottom,
    left=\Delvierre@geomleft,
    right=\Delvierre@geomright,
    includehead,
    includefoot,
    headheight=\Delvierre@geomheadheight,
    headsep=\Delvierre@geomheadsep,
    columnsep=0.8cm,
    footskip=#1%
  }%
}

% Helper: tune header layout (MUST be used in the preamble)
\newcommand{\setheadheight}[1]{%
  % Keep headheight sane: negative/too small values break fancyhdr and spacing.
  \begingroup\setlength{\@tempdima}{#1}\relax
    \ifdim\@tempdima<12pt\relax
      \ClassWarning{delvierre}{Requested \string\headheight=\the\@tempdima\space is too small/negative; using 12pt.}%
      \setlength{\@tempdima}{12pt}%
    \fi
    \ifdim\@tempdima>80pt\relax
      \ClassWarning{delvierre}{Requested \string\headheight=\the\@tempdima\space is very large; clamping to 80pt.}%
      \setlength{\@tempdima}{80pt}%
    \fi
    \xdef\Delvierre@geomheadheight{\the\@tempdima}%
  \endgroup
  \setlength{\headheight}{\Delvierre@geomheadheight}%
  \Delvierre@ApplyGeometry
}
\newcommand{\setheadsep}[1]{%
  \begingroup\setlength{\@tempdima}{#1}\relax
    \ifdim\@tempdima<0pt\relax
      \ClassWarning{delvierre}{Requested \string\headsep=\the\@tempdima\space is negative; using 0pt.}%
      \setlength{\@tempdima}{0pt}%
    \fi
    \ifdim\@tempdima>60pt\relax
      \ClassWarning{delvierre}{Requested \string\headsep=\the\@tempdima\space is very large; clamping to 60pt.}%
      \setlength{\@tempdima}{60pt}%
    \fi
    \xdef\Delvierre@geomheadsep{\the\@tempdima}%
  \endgroup
  \setlength{\headsep}{\Delvierre@geomheadsep}%
  \Delvierre@ApplyGeometry
}

% -------------------------
% Title block alignment tweak
% -------------------------
\newlength{\DelvierreTitleXShift}
\setlength{\DelvierreTitleXShift}{-12pt}
\newcommand{\settitlexshift}[1]{\setlength{\DelvierreTitleXShift}{#1}}

% --- Core packages ---
\RequirePackage{xcolor}
\RequirePackage{graphicx}
\RequirePackage{eso-pic}

% --- Graphics search paths ---
\graphicspath{{./}{./images/}{./figures/}{./graphics/}{../}{../images/}{../figures/}{../graphics/}}

\RequirePackage{array}
\RequirePackage{tabularx}
\RequirePackage{booktabs}
\RequirePackage{caption}
\RequirePackage{titlesec}
\RequirePackage{enumitem}
\RequirePackage{etoolbox}
\RequirePackage{environ}
\RequirePackage{authblk}
\RequirePackage{tikz}

% --- Citations ---
\RequirePackage[square,numbers,sort&compress]{natbib}
\setcitestyle{square,numbers,comma,sort&compress}

% --- Link colors (used in 'color' mode) ---
\definecolor{delvierreBlue}{RGB}{0, 51, 102}
\definecolor{delvierreAccent}{RGB}{0, 102, 204}

% --- Hyperref ---
\RequirePackage{hyperref}
\hypersetup{
  pdfborder={0 0 0},
  breaklinks=true
}
\ifDelvierre@mono
  % Strict monochrome: no colors, no borders.
  \hypersetup{hidelinks}
\else
  % Color mode: blue links.
  \hypersetup{
    colorlinks=true,
    linkcolor=delvierreBlue,
    urlcolor=delvierreAccent,
    citecolor=delvierreBlue
  }
\fi
\urlstyle{same}
\Urlmuskip=0mu plus 1mu

% --- Captions ---
\captionsetup{font=small, labelfont=bf}

% --- Lists ---
\setlist[itemize]{leftmargin=*, topsep=2pt, itemsep=1.5pt, parsep=0pt, label=\textbullet}
\setlist[enumerate]{leftmargin=*, topsep=2pt, itemsep=1.5pt, parsep=0pt}
% Highlights list spacing (tunable, without affecting other itemize lists)
\newlist{delvierrehighlights}{itemize}{1}
\setlist[delvierrehighlights]{label=\textbullet,leftmargin=1.2em,topsep=2pt,itemsep=1.5pt,parsep=0pt,partopsep=0pt}
\newcommand{\sethighlightslistopts}[1]{\setlist[delvierrehighlights]{#1}}

% =========================
% Contents (mini-TOC, optional)
% =========================
% Use in the preamble:
%   \begin{contents}
%     \begin{delvierrecontents}
%       \contentslinkentry{1.\quad Introduction}{sec:intro}
%       \contentslinkentry[1.6em]{1.1.\quad Subsection}{sec:sub}
%     \end{delvierrecontents}
%   \end{contents}
%

% Headings for Contents / References: title case (not uppercase)
\newlength{\DelvierrePlainTitleToRuleSep}
\setlength{\DelvierrePlainTitleToRuleSep}{0em}
\newlength{\DelvierrePlainRuleToTextSep}
\setlength{\DelvierrePlainRuleToTextSep}{0.18em}
\newcommand{\setplaintitletorulesep}[1]{\setlength{\DelvierrePlainTitleToRuleSep}{#1}}
\newcommand{\setplainruletotextsep}[1]{\setlength{\DelvierrePlainRuleToTextSep}{#1}}

\newcommand{\Delvierre@PlainHeading}[1]{%
  {\sffamily\bfseries\DelvierreFMTitleSize #1}\par
  \vspace{\DelvierrePlainTitleToRuleSep}%
  \noindent\rule{\linewidth}{0.30pt}\par
  \vspace{\DelvierrePlainRuleToTextSep}%
}
\newcommand{\Delvierre@BlockTitle}[1]{%
  {\sffamily\bfseries\DelvierreFMTitleSize #1}\par
}


% Spacing + font inside the contents list
\newlength{\DelvierreContentsVSpace}
\setlength{\DelvierreContentsVSpace}{0.25em}
\newcommand{\setcontentsvspace}[1]{\setlength{\DelvierreContentsVSpace}{#1}}

% Space between the "Contents" heading and the first entry
\newlength{\DelvierreContentsHeadingGap}
\setlength{\DelvierreContentsHeadingGap}{0.6em}
\newcommand{\setcontentsheadinggap}[1]{\setlength{\DelvierreContentsHeadingGap}{#1}}

% Default indent applied to each contents line
\newlength{\DelvierreContentsEntryIndent}
\setlength{\DelvierreContentsEntryIndent}{0.2cm}
\newcommand{\setcontentsindent}[1]{\setlength{\DelvierreContentsEntryIndent}{#1}}

\newlength{\DelvierreContentsRowSep}
\setlength{\DelvierreContentsRowSep}{0.15em}
\newcommand{\setcontentsrowsep}[1]{\setlength{\DelvierreContentsRowSep}{#1}}

\newcommand{\DelvierreContentsFont}{\sffamily\small}
\newcommand{\setcontentsfont}[1]{\def\DelvierreContentsFont{#1}}

\newcommand{\Delvierre@ContentsDots}{\leaders\hbox{.\kern0.55pt}\hfill}

% Legacy (no link; manual page number):
\newcommand{\contentsentry}[2]{\noindent #1\hfill #2\par\vspace{\DelvierreContentsRowSep}}

% Linked entry (recommended): optional indent, text, and a label to link to
\newcommand{\contentslinkentry}[3][\DelvierreContentsEntryIndent]{%
  \par\noindent\hspace*{#1}%
  \begingroup\leavevmode
    \hyperref[#3]{#2\ \Delvierre@ContentsDots\ \pageref*{#3}}%
  \endgroup
  \par\vspace{\DelvierreContentsRowSep}%
}

\newenvironment{delvierrecontents}{%
  \DelvierreContentsFont
  \setlength{\parindent}{0pt}%
  \setlength{\parskip}{0pt}%
}{%
}


% Paragraph indentation
\setlength{\parindent}{1.2em}

% =========================
% Metadata hooks
% =========================
\makeatletter

% ==========================
% Extra header-to-text gap (page 2+ only)
% ==========================
\newlength{\DelvierreBodyHeadsepExtra}
\setlength{\DelvierreBodyHeadsepExtra}{10pt} % extra gap under running header on pages 2+
\newlength{\DelvierreAppliedBodyHeadsepExtra}
\setlength{\DelvierreAppliedBodyHeadsepExtra}{0pt}

\newcommand{\setbodyheadsepextra}[1]{%
  \setlength{\DelvierreBodyHeadsepExtra}{#1}%
}

\newcommand{\Delvierre@ApplyBodyHeadsepExtra}{%
  % NOTE: this may run inside a shipout-hook group -> assignments must be GLOBAL.
  \begingroup
    \setlength{\@tempdima}{\DelvierreBodyHeadsepExtra}%
    % Safety clamp (still big enough to be obvious in the PDF for debugging):
    \ifdim\@tempdima>200pt\relax
      \ClassWarning{delvierre}{\string\setbodyheadsepextra\space too large (\the\@tempdima); clamping to 200pt to avoid negative \string\textheight.}%
      \setlength{\@tempdima}{200pt}%
    \fi
    \global\DelvierreAppliedBodyHeadsepExtra=\@tempdima\relax
    % Increase gap under header and keep body height consistent (includehead -> headsep counts):
    \global\advance\headsep by \@tempdima
    \global\advance\textheight by -\@tempdima
    % Sync column/page builder with new textheight:
    \global\@colht=\textheight
    \global\@colroom=\textheight
    \global\vsize=\textheight
  \endgroup
}

% ==========================
% Extra text-to-footer gap (page 2+ only)
% ==========================
\newlength{\DelvierreBodyFootskipExtra}
\setlength{\DelvierreBodyFootskipExtra}{0pt}

\newcommand{\setbodyfootskipextra}[1]{%
  \setlength{\DelvierreBodyFootskipExtra}{#1}%
}

\newcommand{\Delvierre@ApplyBodyFootskipExtra}{%
  \begingroup
    \setlength{\@tempdima}{\DelvierreBodyFootskipExtra}%
    % Safety clamp:
    \ifdim\@tempdima>200pt\relax
      \ClassWarning{delvierre}{\string\setbodyfootskipextra\space too large (\the\@tempdima); clamping to 200pt.}%
      \setlength{\@tempdima}{200pt}%
    \fi
    \ifdim\@tempdima<0pt\relax
      \ClassWarning{delvierre}{\string\setbodyfootskipextra\space is negative (\the\@tempdima); using 0pt.}%
      \setlength{\@tempdima}{0pt}%
    \fi
    % Increase gap before footer, keep page builder consistent:
    \global\advance\footskip by \@tempdima
    \global\advance\textheight by -\@tempdima
    \global\@colht=\textheight
    \global\@colroom=\textheight
    \global\vsize=\textheight
  \endgroup
}

% Things that must happen AFTER page 1 ships out (so they affect page 2+)
\newcommand{\DelvierreAfterFirstShipout}{%
  % Restore standard geometry if we temporarily changed it for the first page.
  \ifDelvierreDidNewGeometry
    \restoregeometry
    % geometry restores lengths, but LaTeX's page builder also needs syncing
    \global\@colht=\textheight
    \global\@colroom=\textheight
    \global\vsize=\textheight
    \DelvierreDidNewGeometryfalse
  \fi
  % Apply extra header-to-text gap for page 2+ (if requested).
  \ifdim\DelvierreBodyHeadsepExtra>0pt\relax
    \Delvierre@ApplyBodyHeadsepExtra
  \fi
  % Apply extra text-to-footer gap for page 2+ (if requested).
  \ifdim\DelvierreBodyFootskipExtra>0pt\relax
    \Delvierre@ApplyBodyFootskipExtra
  \fi
}

% Compatibility: some older LaTeX kernels don't define \@setmarks (needed by cuted)
\providecommand\@setmarks{\relax}

% -------------------------
% LaTeX 2025-06-01 output routine compatibility
% Some older packages (and older sttools/cuted versions) still call the pre-2025 helper
% names \@makespecialcolbox / \@makenormalcolbox. The 2025-06-01 kernel renamed these
% to \@make@specialcolbox / \@make@normalcolbox. Provide aliases when needed.
\@ifundefined{@make@specialcolbox}{}{%
  \@ifundefined{@makespecialcolbox}{\let\@makespecialcolbox\@make@specialcolbox}{}%
}%
\@ifundefined{@make@normalcolbox}{}{%
  \@ifundefined{@makenormalcolbox}{\let\@makenormalcolbox\@make@normalcolbox}{}%
}%


% -------------------------
% Graphic resolver
% -------------------------
\newcommand{\Delvierre@TryGraphic}[2]{%
  \IfFileExists{#1}{\def#2{#1}}{%
    \IfFileExists{#1.pdf}{\def#2{#1.pdf}}{%
      \IfFileExists{#1.png}{\def#2{#1.png}}{%
        \IfFileExists{#1.jpg}{\def#2{#1.jpg}}{%
          \IfFileExists{#1.jpeg}{\def#2{#1.jpeg}}{}%
        }%
      }%
    }%
  }%
}
\newcommand{\Delvierre@FindGraphic}[2]{%
  \def#2{}%
  \Delvierre@TryGraphic{#1}{#2}%
  \ifx#2\@empty \Delvierre@TryGraphic{./#1}{#2}\fi
  \ifx#2\@empty \Delvierre@TryGraphic{./images/#1}{#2}\fi
  \ifx#2\@empty \Delvierre@TryGraphic{./figures/#1}{#2}\fi
  \ifx#2\@empty \Delvierre@TryGraphic{./graphics/#1}{#2}\fi
  \ifx#2\@empty \Delvierre@TryGraphic{../#1}{#2}\fi
  \ifx#2\@empty \Delvierre@TryGraphic{../images/#1}{#2}\fi
  \ifx#2\@empty \Delvierre@TryGraphic{../figures/#1}{#2}\fi
  \ifx#2\@empty \Delvierre@TryGraphic{../graphics/#1}{#2}\fi
}

\newcommand{\journalname}[1]{\def\@journalname{#1}}
\newcommand{\journalissn}[1]{\def\@journalissn{#1}}
\newcommand{\publishername}[1]{\def\@publishername{#1}}

\newcommand{\journalhomepage}[1]{\def\@journalhomepage{#1}}
\def\@journalhomepage{}

\newcommand{\journaltagline}[1]{\def\@journaltagline{#1}}
\def\@journaltagline{}

\newcommand{\articledoi}[1]{\def\@articledoi{#1}}
\newcommand{\repositorylink}[1]{\def\@repositorylink{#1}}
\newcommand{\recommendedby}[1]{\def\@recommendedby{#1}}

\newcommand{\received}[1]{\def\@received{#1}}
\newcommand{\revised}[1]{\def\@revised{#1}}
\newcommand{\accepted}[1]{\def\@accepted{#1}}
\newcommand{\published}[1]{\def\@published{#1}}

\newcommand{\availableonline}[1]{\def\@availableonline{#1}}
\def\@availableonline{}

\newcommand{\keywords}[1]{\def\@keywords{#1}}
\def\@keywords{}

\newcommand{\correspondingauthor}[1]{\def\@corrauthor{#1}}
\newcommand{\correspondingemail}[1]{\def\@corremail{#1}}
\def\@corrauthor{}
\def\@corremail{}

\newcommand{\emailaddress}[1]{\def\@emailaddress{#1}}
\def\@emailaddress{}

\newcommand{\shorttitle}[1]{\def\@shorttitle{#1}}
\def\@shorttitle{}

\newcommand{\setrunningauthor}[1]{\def\@runningauthor{#1}}
\def\@runningauthor{}
\newcommand{\setjournalinfo}[1]{\def\@journalinfo{#1}}
\def\@journalinfo{}

\providecommand{\runningauthor}[1]{\setrunningauthor{#1}}
\providecommand{\journalinfo}[1]{\setjournalinfo{#1}}

\newcommand{\journallogo}[1]{\def\@journallogofile{#1}}
\newcommand{\publisherlogo}[1]{\def\@publisherlogofile{#1}}

% Crossmark
\newcommand{\crossmarklogo}[1]{\def\@crossmarklogofile{#1}}
\newcommand{\crossmarkdomain}[1]{\def\@crossmarkdomain{#1}}
\newcommand{\crossmarkdatestamp}[1]{\def\@crossmarkdatestamp{#1}}

% License
\newcommand{\license}[2]{\def\@licenselabel{#1}\def\@licenseurl{#2}}
\def\@licenselabel{CC BY 4.0}
\def\@licenseurl{https://creativecommons.org/licenses/by/4.0/}

% Defaults
\journalname{Delvierre Journal}
\journalissn{0000-0000}
\publishername{DELVIERRE}
\journallogo{logo_journal.png}
\publisherlogo{logo_delvierre.png}
\def\@repositorylink{}
\def\@recommendedby{}
\def\@articledoi{}
\received{}\revised{}\accepted{}\published{}
\crossmarklogo{crossmark.pdf}
\crossmarkdomain{pdf}
\crossmarkdatestamp{}

% Diagnostics (logo presence)
\AtBeginDocument{%
  \def\Delvierre@tmp{}%
  \Delvierre@FindGraphic{\@publisherlogofile}{\Delvierre@tmp}%
  \ifx\Delvierre@tmp\@empty
    \ClassWarning{delvierre}{Publisher logo '\@publisherlogofile' not found. Put it next to your .tex (or in ./images, ./figures, ./graphics) or set \string\publisherlogo{path/to/file}.}%
  \fi
  \def\Delvierre@tmp{}%
  \Delvierre@FindGraphic{\@journallogofile}{\Delvierre@tmp}%
  \ifx\Delvierre@tmp\@empty
    \ClassWarning{delvierre}{Journal logo '\@journallogofile' not found. Put it next to your .tex (or in ./images, ./figures, ./graphics) or set \string\journallogo{path/to/file}.}%
  \fi
  \ifdefempty{\@articledoi}{}{% 
    \def\Delvierre@tmp{}%
    \Delvierre@FindGraphic{\@crossmarklogofile}{\Delvierre@tmp}%
    \ifx\Delvierre@tmp\@empty
      \ClassWarning{delvierre}{Crossmark artwork '\@crossmarklogofile' not found. Using a built-in fallback mark.}%
    \fi
  }%
}%

% Tunable sizes
\newlength{\DelvierreCrossmarkHeight}
\newlength{\DelvierreCrossmarkTitleHeight}
\newlength{\DelvierreCrossmarkTitleYOffset}
\newlength{\DelvierreGraphAbsMaxHeight}
\setlength{\DelvierreCrossmarkHeight}{9pt}       % running header
\setlength{\DelvierreCrossmarkTitleHeight}{14pt} % near title
% Default vertical placement: centered between title and author by shifting
% down by half the icon height (negative moves down).
% Lower Crossmark icon a bit more than half its height
\setlength{\DelvierreCrossmarkTitleYOffset}{\dimexpr-\DelvierreCrossmarkTitleHeight*11/4\relax}
\setlength{\DelvierreGraphAbsMaxHeight}{4.8cm}

\newcommand{\setcrossmarkheight}[1]{\setlength{\DelvierreCrossmarkHeight}{#1}}
\newcommand{\setcrossmarktitleheight}[1]{\setlength{\DelvierreCrossmarkTitleHeight}{#1}}
\newcommand{\setcrossmarktitleoffset}[1]{\setlength{\DelvierreCrossmarkTitleYOffset}{#1}}
\newcommand{\setgraphabsmaxheight}[1]{\setlength{\DelvierreGraphAbsMaxHeight}{#1}}

% (Compatibility) Per-logo size setters (kept for v16.29 compatibility; masthead uses \DelvierreHeaderLogoHeight)
\newlength{\DelvierreJournalLogoHeight}
\newlength{\DelvierrePublisherLogoHeight}
\setlength{\DelvierreJournalLogoHeight}{10pt}
\setlength{\DelvierrePublisherLogoHeight}{10pt}
\newcommand{\setjournallogoheight}[1]{\setlength{\DelvierreJournalLogoHeight}{#1}}
\newcommand{\setpublisherlogoheight}[1]{\setlength{\DelvierrePublisherLogoHeight}{#1}}

% Header logo size (FIRST PAGE masthead logos)
\newlength{\DelvierreHeaderLogoHeight}
\setlength{\DelvierreHeaderLogoHeight}{26pt}

% Per-logo masthead heights (useful when one image has extra whitespace)
\newlength{\DelvierreHeaderPublisherLogoHeight}
\newlength{\DelvierreHeaderJournalLogoHeight}
\setlength{\DelvierreHeaderPublisherLogoHeight}{\DelvierreHeaderLogoHeight}
\setlength{\DelvierreHeaderJournalLogoHeight}{\DelvierreHeaderLogoHeight}

% Set BOTH masthead logos at once
\newcommand{\setheaderlogoheight}[1]{%
  \setlength{\DelvierreHeaderLogoHeight}{#1}%
  \setlength{\DelvierreHeaderPublisherLogoHeight}{#1}%
  \setlength{\DelvierreHeaderJournalLogoHeight}{#1}%
}
% Or tune each side independently
\newcommand{\setpublisherheaderlogoheight}[1]{\setlength{\DelvierreHeaderPublisherLogoHeight}{#1}}
\newcommand{\setjournalheaderlogoheight}[1]{\setlength{\DelvierreHeaderJournalLogoHeight}{#1}}

\newlength{\DelvierreHeaderJournalLogoWidth}
\setlength{\DelvierreHeaderJournalLogoWidth}{0pt}
\newcommand{\setjournalheaderlogowidth}[1]{\setlength{\DelvierreHeaderJournalLogoWidth}{#1}}
\newif\ifDelvierreJournalLogoKeepAspect
\DelvierreJournalLogoKeepAspecttrue
\newcommand{\setjournalheaderlogokeepaspect}{\DelvierreJournalLogoKeepAspecttrue}
\newcommand{\setjournalheaderlogofreeaspect}{\DelvierreJournalLogoKeepAspectfalse}

% Masthead bar height + drop (FIRST PAGE)
\newlength{\DelvierreMastheadDrop}
\setlength{\DelvierreMastheadDrop}{4pt} % less drop (masthead higher)
\newcommand{\setmastheaddrop}[1]{\setlength{\DelvierreMastheadDrop}{#1}}

% -------------------------
% Masthead logo fine-tuning (FIRST PAGE)
% -------------------------
% The left/right masthead logos may need cropping (trim) if the image file contains extra whitespace.
% Values are "left bottom right top" with units (e.g., 12pt 0pt 12pt 0pt).
\def\Delvierre@publisherheadtrim{0pt 0pt 0pt 0pt}
\def\Delvierre@journalheadtrim{0pt 0pt 0pt 0pt}
\newlength{\DelvierrePublisherHeadRaise}
\newlength{\DelvierreJournalHeadRaise}
\newlength{\DelvierreMastheadLogosDrop}
\setlength{\DelvierrePublisherHeadRaise}{0pt}
\setlength{\DelvierreJournalHeadRaise}{0pt}
\setlength{\DelvierreMastheadLogosDrop}{0pt}

\newcommand{\setpublisherheadtrim}[1]{\def\Delvierre@publisherheadtrim{#1}}
\newcommand{\setjournalheadtrim}[1]{\def\Delvierre@journalheadtrim{#1}}
\newcommand{\setpublisherheadraise}[1]{\setlength{\DelvierrePublisherHeadRaise}{#1}}
\newcommand{\setjournalheadraise}[1]{\setlength{\DelvierreJournalHeadRaise}{#1}}
% Positive values move BOTH masthead logos DOWN (useful to align with the center bar)
\newcommand{\setmastheadlogosdrop}[1]{\setlength{\DelvierreMastheadLogosDrop}{#1}}

\newcommand{\Delvierre@MastheadLogoWithHeight}[5]{%
  % #1 = file, #2 = fallback text, #3 = trim, #4 = raise, #5 = height length register
  \begingroup
    \def\Delvierre@lg{}%
    \Delvierre@FindGraphic{#1}{\Delvierre@lg}%
    \ifx\Delvierre@lg\@empty
      #2%
    \else
      \raisebox{\dimexpr #4-\DelvierreMastheadLogosDrop\relax}{%
        \begingroup
          \edef\Delvierre@opts{height=\the#5,keepaspectratio,trim=#3,clip}%
          \expandafter\includegraphics\expandafter[\Delvierre@opts]{\Delvierre@lg}%
        \endgroup
      }%
    \fi
  \endgroup
}

% Backwards-compatible wrapper (uses \DelvierreHeaderLogoHeight)
\newcommand{\Delvierre@MastheadLogo}[4]{%
  \Delvierre@MastheadLogoWithHeight{#1}{#2}{#3}{#4}{\DelvierreHeaderLogoHeight}%
}

% -------------------------
% REMOVE frames/contours around logos (requested)
% -------------------------
\newcommand{\Delvierre@LogoBox}[1]{#1}

\newcommand{\Delvierre@HeaderLogo}[1]{%
  \begingroup
    \def\Delvierre@lg{}%
    \Delvierre@FindGraphic{#1}{\Delvierre@lg}%
    \ifx\Delvierre@lg\@empty\else
      \Delvierre@LogoBox{\includegraphics[height=\DelvierreHeaderLogoHeight]{\Delvierre@lg}}%
    \fi
  \endgroup
}
\newcommand{\Delvierre@HeaderLogoOrText}[2]{%
  \begingroup
    \def\Delvierre@lg{}%
    \Delvierre@FindGraphic{#1}{\Delvierre@lg}%
    \ifx\Delvierre@lg\@empty
      \Delvierre@LogoBox{#2}%
    \else
      \Delvierre@LogoBox{\includegraphics[height=\DelvierreHeaderLogoHeight]{\Delvierre@lg}}%
    \fi
  \endgroup
}

% ==========================
% ORCID
% ==========================
\definecolor{orcidGreen}{HTML}{A6CE39}
\def\DelvierreOrcidHeight{2.05ex}
\def\DelvierreOrcidRaise{0.90ex}
\def\DelvierreOrcidTrim{0pt 0pt 0pt 0pt}

\newcommand{\setorcidheight}[1]{\def\DelvierreOrcidHeight{#1}}
\newcommand{\setorcidraise}[1]{\def\DelvierreOrcidRaise{#1}}
\newcommand{\setorcidtrim}[1]{\def\DelvierreOrcidTrim{#1}}

\newcommand{\orcidiconfile}[1]{\def\@orcidiconfile{#1}}
\def\@orcidiconfile{orcid-id.pdf}

\newcommand{\Delvierre@OrcidInclude}[1]{%
  \raisebox{\DelvierreOrcidRaise}[0pt][0pt]{%
    \begingroup
      % Safer trim handling: graphicx does NOT expand trim values.
      \edef\Delvierre@trimval{\DelvierreOrcidTrim}%
      \ifdefstrequal{\Delvierre@trimval}{0pt 0pt 0pt 0pt}{%
        \includegraphics[height=\DelvierreOrcidHeight,keepaspectratio]{#1}%
      }{%
        \edef\Delvierre@orcid@opts{height=\DelvierreOrcidHeight,keepaspectratio,trim={\Delvierre@trimval},clip}%
        \expandafter\includegraphics\expandafter[\Delvierre@orcid@opts]{#1}%
      }%
    \endgroup
  }%
}

\newcommand{\Delvierre@OrcidFallback}{%
  \raisebox{\DelvierreOrcidRaise}[0pt][0pt]{%
    \tikz[baseline] \node[
      circle,
      inner sep=0.95pt,
      outer sep=0pt,
      fill=orcidGreen
    ]{%
      \color{white}%
      \sffamily\bfseries\fontsize{8.2}{8.2}\selectfont iD%
    };%
  }%
}
\newcommand{\Delvierre@OrcidIcon}{%
  \IfFileExists{\@orcidiconfile}{%
    \Delvierre@OrcidInclude{\@orcidiconfile}\nobreak\hspace{0.10em}%
  }{%
    \IfFileExists{orcid-id.pdf}{\Delvierre@OrcidInclude{orcid-id.pdf}\nobreak\hspace{0.10em}}{%
      \IfFileExists{orcid-id.png}{\Delvierre@OrcidInclude{orcid-id.png}\nobreak\hspace{0.10em}}{%
        \Delvierre@OrcidFallback\nobreak\hspace{0.10em}%
      }%
    }%
  }%
}
\DeclareRobustCommand{\orcid}[1]{%
  \texorpdfstring{\href{https://orcid.org/#1}{\Delvierre@OrcidIcon}}{}%
}
\AtBeginDocument{%
  \pdfstringdefDisableCommands{%
    \def\orcid#1{}%
    \def\Delvierre@OrcidIcon{}%
  }%
}

% ==========================
% Keywords rendering
% ==========================
\newcommand{\Delvierre@PrintKeywords}[1]{%
  \begingroup
    \protected@edef\Delvierre@kwlist{#1}%
    \expandafter\Delvierre@kw@split\Delvierre@kwlist;\@nil
  \endgroup
}
\def\Delvierre@kw@split#1;#2\@nil{%
  \Delvierre@kw@printone{#1}%
  \def\Delvierre@rest{#2}%
  \ifx\Delvierre@rest\@empty\else
    \expandafter\Delvierre@kw@split\Delvierre@rest\@nil
  \fi
}
\def\Delvierre@kw@printone#1{%
  \def\Delvierre@tmp{#1}%
  \ifx\Delvierre@tmp\@empty\else
    \noindent\ignorespaces#1\unskip\par
  \fi
}

% ==========================
% Front matter capture
% ==========================
\newif\ifDelvierre@hasabstract
\newif\ifDelvierre@hasgraphabs
\newif\ifDelvierre@hashighlights
\Delvierre@hasabstractfalse
\Delvierre@hasgraphabsfalse
\Delvierre@hashighlightsfalse

\newif\ifDelvierre@hascontents
\Delvierre@hascontentsfalse

\newcommand\Delvierre@abstract{\textit{No abstract provided.}}
\newcommand\Delvierre@graphabs{}
\newcommand\Delvierre@highlights{}

\newcommand\Delvierre@contents{}
\RenewEnviron{abstract}{%
  \global\Delvierre@hasabstracttrue
  \global\expandafter\def\expandafter\Delvierre@abstract\expandafter{\BODY}%
}
\NewEnviron{graphicalabstract}{%
  \global\Delvierre@hasgraphabstrue
  \global\expandafter\def\expandafter\Delvierre@graphabs\expandafter{\BODY}%
}
\NewEnviron{highlights}{%
  \global\Delvierre@hashighlightstrue
  \global\expandafter\def\expandafter\Delvierre@highlights\expandafter{\BODY}%
}

\NewEnviron{contents}{%
  \global\Delvierre@hascontentstrue
  \global\expandafter\def\expandafter\Delvierre@contents\expandafter{\BODY}%
}

% ==========================
% Crossmark
% ==========================
\newcommand{\Delvierre@CrossmarkURL}{%
  https://crossmark.crossref.org/dialog?doi=\@articledoi\detokenize{&}domain=\@crossmarkdomain%
  \ifdefempty{\@crossmarkdatestamp}{}{%
    \detokenize{&}date_stamp=\@crossmarkdatestamp%
  }%
}

\newcommand{\Delvierre@CrossmarkMark}[1]{%
  \begingroup
    \def\Delvierre@cmfile{}%
    \Delvierre@FindGraphic{\@crossmarklogofile}{\Delvierre@cmfile}%
    \ifx\Delvierre@cmfile\@empty
      \tikz[baseline=-0.6ex]{%
        \draw[line width=0.45pt] (0,0) circle (3.2pt);
        \draw[line width=0.45pt,->,>=stealth] (3.2pt,0) arc (0:225:3.2pt);
        \draw[line width=0.45pt,->,>=stealth] (-3.2pt,0) arc (180:-45:3.2pt);
      }%
    \else
      \includegraphics[height=#1]{\Delvierre@cmfile}%
    \fi
  \endgroup
}

\newcommand{\Delvierre@CrossmarkButton}{%
  \ifdefempty{\@articledoi}{}{%
    \href{\Delvierre@CrossmarkURL}{\Delvierre@CrossmarkMark{\DelvierreCrossmarkTitleHeight}}%
  }%
}

\newcommand{\Delvierre@CrossmarkHeader}{%
  \ifdefempty{\@articledoi}{}{%
    \href{\Delvierre@CrossmarkURL}{\Delvierre@CrossmarkMark{\DelvierreCrossmarkHeight}}%
  }%
}

% ==========================
% Brand bar / masthead (FIRST PAGE)
% ==========================
\newlength{\DelvierreMastheadGap}
\setlength{\DelvierreMastheadGap}{2pt}
\newcommand{\setmastheadgap}[1]{\setlength{\DelvierreMastheadGap}{#1}}

\newlength{\DelvierreMastheadBarPad}
\setlength{\DelvierreMastheadBarPad}{3pt}
\newcommand{\setmastheadbarpad}[1]{\setlength{\DelvierreMastheadBarPad}{#1}}

% Masthead center-bar width control (percentage of the available middle column width).
% Example: \setmastheadbarwidthpercent{85} -> make the gray bar ~15% narrower.
\def\DelvierreMastheadBarWidthPercent{100}
\newcommand{\setmastheadbarwidthpercent}[1]{\def\DelvierreMastheadBarWidthPercent{#1}}

\newlength{\DelvierreMastheadCenterShift}
\setlength{\DelvierreMastheadCenterShift}{0pt}
\newcommand{\setmastheadcentershift}[1]{\setlength{\DelvierreMastheadCenterShift}{#1}}

\newcommand{\Delvierre@HeaderJournalIcon}{%
  \begingroup
    \def\Delvierre@lg{}%
    \Delvierre@FindGraphic{\@journallogofile}{\Delvierre@lg}%
    \ifx\Delvierre@lg\@empty
      {\scriptsize\sffamily\bfseries \@journalname}%
    \else
      \raisebox{\dimexpr\DelvierreJournalHeadRaise-\DelvierreMastheadLogosDrop\relax}{%
        \begingroup
          \ifdim\DelvierreHeaderJournalLogoWidth>0pt\relax
            \ifDelvierreJournalLogoKeepAspect
              \edef\Delvierre@opts{width=\the\DelvierreHeaderJournalLogoWidth,height=\the\DelvierreHeaderJournalLogoHeight,keepaspectratio,trim=\Delvierre@journalheadtrim,clip}%
            \else
              \edef\Delvierre@opts{width=\the\DelvierreHeaderJournalLogoWidth,height=\the\DelvierreHeaderJournalLogoHeight,trim=\Delvierre@journalheadtrim,clip}%
            \fi
          \else
            \edef\Delvierre@opts{height=\the\DelvierreHeaderJournalLogoHeight,keepaspectratio,trim=\Delvierre@journalheadtrim,clip}%
          \fi
          \expandafter\includegraphics\expandafter[\Delvierre@opts]{\Delvierre@lg}%
        \endgroup
      }%
    \fi
  \endgroup
}
\newcommand{\Delvierre@HeaderPublisherIcon}{%
  \Delvierre@MastheadLogoWithHeight{\@publisherlogofile}{{\scriptsize\sffamily\bfseries \@publishername}}{\Delvierre@publisherheadtrim}{\DelvierrePublisherHeadRaise}{\DelvierreHeaderPublisherLogoHeight}%
}

\definecolor{DelvierreMastheadFill}{gray}{0.93}
\newlength{\DelvierreMastheadBarHeight}
\setlength{\DelvierreMastheadBarHeight}{34pt}
\newcommand{\setmastheadbarheight}[1]{\setlength{\DelvierreMastheadBarHeight}{#1}}

\newcommand{\Delvierre@MastheadCenter}{%
  \begingroup
    \setlength{\fboxsep}{\DelvierreMastheadBarPad}%
    \makebox[\linewidth][c]{%
      \hspace*{\DelvierreMastheadCenterShift}%
      \colorbox{DelvierreMastheadFill}{%
        \parbox[c][\DelvierreMastheadBarHeight][c]{\dimexpr\linewidth*\DelvierreMastheadBarWidthPercent/100-2\fboxsep\relax}{%
          \centering
          \setlength{\parskip}{0pt}%
          \vspace*{0pt}%
          \ifdefempty{\@journaltagline}{}{%
            {\sffamily\scriptsize \@journaltagline\par}%
          }%
          \vfill
          {\sffamily\bfseries\large \@journalname\par}%
          \vfill
          \ifdefempty{\@journalhomepage}{}{%
            {\sffamily\footnotesize Journal homepage:\ \url{\@journalhomepage}\par}%
          }%
        }%
      }%
    }%
  \endgroup
}

\newcommand{\Delvierre@Masthead}{%
  \vspace*{\DelvierreMastheadDrop}%
  \noindent
  \begin{tabularx}{\textwidth}{@{}l@{\hspace{\DelvierreMastheadGap}}X@{\hspace{\DelvierreMastheadGap}}r@{}}%
    \Delvierre@HeaderPublisherIcon & \Delvierre@MastheadCenter & \Delvierre@HeaderJournalIcon%
  \end{tabularx}\par
  \vspace{0.45em}\noindent\rule{\linewidth}{1.1pt}%
}

% ==========================
% Front-matter layout widths
% ==========================
\newlength{\DelvierreFMLeftWidth}
\newlength{\DelvierreFMGap}
\newlength{\DelvierreFMRightWidth}

\setlength{\DelvierreFMLeftWidth}{0.32\textwidth}
\setlength{\DelvierreFMGap}{1.0em}

\newcommand{\Delvierre@RecalcFMWidths}{%
  \setlength{\DelvierreFMRightWidth}{%
    \dimexpr\textwidth-\DelvierreFMLeftWidth-\DelvierreFMGap\relax
  }%
}
\Delvierre@RecalcFMWidths
\AtBeginDocument{\Delvierre@RecalcFMWidths}

\newcommand{\setfrontmatterwidths}[2]{%
  \setlength{\DelvierreFMLeftWidth}{#1}%
  \setlength{\DelvierreFMGap}{#2}%
  \Delvierre@RecalcFMWidths
}

% ==========================
% First-page note
% ==========================
\newcommand{\Delvierre@ISSNURL}{%
  \ifdefempty{\@journalissn}{}{http://issn.org/resource/ISSN/\@journalissn/}%
}
\newcommand{\Delvierre@DOIURL}{%
  \ifdefempty{\@articledoi}{}{https://doi.org/\@articledoi}%
}
\newcommand{\Delvierre@FirstPageNoteText}{%
  \begingroup
  \DelvierreFirstPageNoteSize
  \setlength{\parindent}{0pt}%
  \setlength{\parskip}{\DelvierreFirstPageFooterParskip}%
  \raggedright

  \ifdefempty{\@emailaddress}{%
    \ifdefempty{\@corremail}{}{%
      \hspace*{2em}\textit{E-mail address:}~\href{mailto:\@corremail}{\nolinkurl{\@corremail}}.\par
      \vspace{\DelvierreFirstPageFooterEmailGap}%
    }%
  }{%
    \hspace*{2em}\textit{E-mail address:}~\href{mailto:\@emailaddress}{\nolinkurl{\@emailaddress}}.\par
    \vspace{\DelvierreFirstPageFooterEmailGap}%
  }%

  \ifdefempty{\@articledoi}{}{%
    \href{\Delvierre@DOIURL}{\nolinkurl{\Delvierre@DOIURL}}\par
  }%

  \ifboolexpr{
    test {\ifdefempty{\@received}}
    and test {\ifdefempty{\@revised}}
    and test {\ifdefempty{\@accepted}}
    and test {\ifdefempty{\@published}}
  }{}{%
    Received~\@received%
    \ifdefempty{\@revised}{}{; Received in revised form~\@revised}%
    \ifdefempty{\@accepted}{}{; Accepted~\@accepted}%
    \ifdefempty{\@published}{}{; Published~\@published}%
    \par \vspace{-6pt}
  }%

  \ifdefempty{\@availableonline}{}{Available online~\@availableonline\par}%

  \ifdefempty{\@journalissn}{}{%
    \href{\Delvierre@ISSNURL}{\nolinkurl{\@journalissn}}.\space
  }%
  This is an open access article under the \href{\@licenseurl}{\@licenselabel} license
  (\nolinkurl{\@licenseurl}).%
  \endgroup
}

% Compute a safe effective raise for page 1 footer, so it can NEVER overlap the body text.
% We clamp the requested raise to:
%   raise <= \footskip - (footer total height) - clearGap
% Using total height (ht+dp) is conservative and prevents any part of the footer box (including the rule)
% from intruding into the text block.
\newcommand{\Delvierre@ComputeFirstPageFooterRaiseEffective}{%
  \sbox{\Delvierre@FirstPageFooterBox}{\Delvierre@FirstPageFooter}%
  \setlength{\DelvierreFirstPageFooterHeight}{\dimexpr\ht\Delvierre@FirstPageFooterBox+\dp\Delvierre@FirstPageFooterBox\relax}%
  \setlength{\@tempdima}{\dimexpr\footskip-\DelvierreFirstPageFooterHeight-\DelvierreFirstPageFooterClearGap\relax}%
  % If \@tempdima < 0, footskip is too small for the footer; we clamp raise to 0.
  \ifdim\@tempdima<0pt\relax
    \setlength{\@tempdima}{0pt}%
  \fi
  \setlength{\DelvierreFirstPageFooterRaise}{\DelvierreFirstPageFooterRaiseRequested}%
  \ifdim\DelvierreFirstPageFooterRaise>\@tempdima\relax
    \setlength{\DelvierreFirstPageFooterRaise}{\@tempdima}%
  \fi
}%
\newcommand{\Delvierre@FirstPageFooter}{%
  \parbox[b]{\textwidth}{%
    \rule{4.2cm}{0.35pt}\par\vspace{\DelvierreFirstPageFooterRuleSep}%
    \Delvierre@FirstPageNoteText
  }%
}


% Place the first-page footer note as an absolute overlay.
% This is robust even if a special output routine (e.g., cuted/strip) suppresses fancyhdr footers.
\newcommand{\Delvierre@PlaceFirstPageFooterOverlay}{%
  \Delvierre@ComputeFirstPageFooterRaiseEffective
  \AddToShipoutPictureFG*{%
    % Place relative to the text block, then shift DOWN by \footskip so the footer lands
    % in the normal footer area. Use the CLAMPED effective raise.
    \AtTextLowerLeft{%
      \raisebox{\dimexpr-\footskip+\DelvierreFirstPageFooterRaise\relax}[0pt][0pt]{%
        \Delvierre@FirstPageFooter%
      }%
    }%
  }%
}
% ==========================
% Front matter sizing / vertical shift (user tunables)
% ==========================
\providecommand{\textls}[2][]{#2}
\newcommand{\DelvierreFMTitleSize}{\small}
\newcommand{\DelvierreFMTextSize}{\normalsize}
\newcommand{\setfrontmattertitlesize}[1]{\def\DelvierreFMTitleSize{#1}}
\newcommand{\setfrontmattertextsize}[1]{\def\DelvierreFMTextSize{#1}}
\newcommand{\setfrontmattertitlefontsize}[2]{\setfrontmattertitlesize{\fontsize{#1}{#2}\selectfont}}
\newcommand{\setfrontmattertextfontsize}[2]{\setfrontmattertextsize{\fontsize{#1}{#2}\selectfont}}

\newlength{\DelvierreFrontMatterVShift}
\setlength{\DelvierreFrontMatterVShift}{-5pt}
\newcommand{\setfrontmattervshift}[1]{\setlength{\DelvierreFrontMatterVShift}{#1}}

\newlength{\DelvierreAfterTitleWideVShift}
\setlength{\DelvierreAfterTitleWideVShift}{-5pt}
\newcommand{\setaftertitlewidevshift}[1]{\setlength{\DelvierreAfterTitleWideVShift}{#1}}

% ==========================
% Front matter blocks
% ==========================
\newcommand{\Delvierre@FMTitle}[1]{%
  {\sffamily\bfseries\DelvierreFMTitleSize\textls[120]{\MakeUppercase{#1}}}\par
  \vspace{0.15em}\noindent\rule{\linewidth}{0.30pt}\par\vspace{\DelvierreFirstPageFooterRuleSep}%
}
\newcommand{\Delvierre@FMTitleCompact}[1]{%
  {\sffamily\bfseries\DelvierreFMTitleSize\textls[120]{\MakeUppercase{#1}}}\par
  \vspace{0.10em}\noindent\rule{\linewidth}{0.30pt}\par\vspace{0.22em}%
}
\newcommand{\Delvierre@Label}[1]{{\sffamily\bfseries #1}}
\newcommand{\Delvierre@SmallURL}[1]{{\scriptsize\nolinkurl{#1}}}

\newcommand{\Delvierre@ArticleInfo}{%
  \Delvierre@FMTitle{Article details}%
  \DelvierreFMTextSize\normalfont
  \ifdefempty{\@recommendedby}{}{%
    \Delvierre@Label{Recommended by editor:}\par
    \@recommendedby\par
    \vspace{0.45em}%
  }%
  \ifdefempty{\@keywords}{}{%
    \Delvierre@Label{Keywords:}\par
    \Delvierre@PrintKeywords{\@keywords}%
    \vspace{0.45em}%
  }%
  \ifdefempty{\@repositorylink}{}{%
    \Delvierre@Label{Repository:}\par
    \href{\@repositorylink}{\Delvierre@SmallURL{\@repositorylink}}\par
  }%
}
\newcommand{\Delvierre@AbstractBlock}{%
  \Delvierre@FMTitle{Abstract}%
  \begingroup
    \DelvierreFMTextSize\normalfont\justifying
    \tolerance=1200\relax
    \emergencystretch=1.2em\relax
    \setlength{\parindent}{0pt}%
    \setlength{\parskip}{2pt}%
    \noindent
    \ifDelvierre@hasabstract
      \ignorespaces\Delvierre@abstract\unskip
    \else
      \textit{No abstract provided.}%
    \fi
  \endgroup
}
\newcommand{\Delvierre@GraphicalAbstractBlock}{%
  \Delvierre@FMTitle{Graphical abstract}%
  \ifDelvierre@hasgraphabs
    \begingroup\centering
      \setkeys{Gin}{width=\linewidth,height=\DelvierreGraphAbsMaxHeight,keepaspectratio}%
      \Delvierre@graphabs
      \par
    \endgroup
  \else
    \vspace*{4.5cm}%
  \fi
}
\newcommand{\Delvierre@HighlightsBlock}{%
  \Delvierre@FMTitle{Research highlights}%
  \DelvierreFMTextSize\normalfont
  \ifDelvierre@hashighlights
    \begin{delvierrehighlights}
      \Delvierre@highlights
    \end{delvierrehighlights}
  \else
    \textit{No highlights provided.}\par
  \fi
}

% Optional Contents block retained for compatibility, but not printed in the redesigned first page.
\newcommand{\Delvierre@ContentsBlock}{%
  \ifDelvierre@hascontents
    \par\vspace{0.6em}%
    \Delvierre@RuleLine
    \vspace{0.45em}%
    \Delvierre@BlockTitle{Contents}%
    \vspace{0.35em}%
    {\DelvierreFMTextSize\normalfont
    \begin{delvierrecontents}
      \Delvierre@contents
    \end{delvierrecontents}}%
    \par\vspace{0.15em}%
    \Delvierre@RuleLine
    \par\vspace{0.40em}%
  \fi
}

\newcommand{\Delvierre@FrontMatter}{%
  \noindent
  \begin{minipage}[t]{0.34\textwidth}
    \Delvierre@HighlightsBlock
  \end{minipage}%
  \hfill
  \begin{minipage}[t]{0.62\textwidth}
    \Delvierre@GraphicalAbstractBlock
  \end{minipage}%
  \par\vspace{0.35cm}%
  \noindent
  \begin{minipage}[t]{0.34\textwidth}
    \Delvierre@ArticleInfo
  \end{minipage}%
  \hfill
  \begin{minipage}[t]{0.62\textwidth}
    \Delvierre@AbstractBlock
  \end{minipage}%
  \Delvierre@ContentsBlock
}
% Manuscript rule spacing (tunable)
\newlength{\DelvierreManuscriptRuleSkip}
\setlength{\DelvierreManuscriptRuleSkip}{0.65em}
\newcommand{\setmanuscriptruleskip}[1]{\setlength{\DelvierreManuscriptRuleSkip}{#1}}


\newcommand{\Delvierre@RuleLine}{\noindent\rule{\linewidth}{0.4pt}\relax\par}

\newcommand{\Delvierre@ManuscriptRule}{%
  \par\vspace{\DelvierreManuscriptRuleSkip}%
  \Delvierre@RuleLine
  \vspace{\DelvierreManuscriptRuleSkip}%
}

% Variants when you want a rule BETWEEN two blocks without doubling the vertical skip.
\newcommand{\Delvierre@ManuscriptRuleTop}{%
  \par\vspace{\DelvierreManuscriptRuleSkip}%
  \Delvierre@RuleLine
}
\newcommand{\Delvierre@ManuscriptRuleBottom}{%
  \Delvierre@RuleLine
  \vspace{\DelvierreManuscriptRuleSkip}%
  \par
}

% ==========================
% Wide blocks in two-column mode (Graphical abstract + Highlights + rule)
% ==========================
\newif\ifDelvierre@hascuted
\IfFileExists{cuted.sty}{%
  \RequirePackage{cuted}%
  \Delvierre@hascutedtrue
}{%
  \Delvierre@hascutedfalse
}

\ifDelvierre@hascuted
  \preCutedStrip{\ifnum\c@page>1\relax\vspace*{\DelvierreAppliedBodyHeadsepExtra}\fi}
\fi

\newcommand{\Delvierre@WideBlock}[1]{%
  \ifDelvierre@hascuted
    \begin{strip}\noindent #1\end{strip}%
  \else
    \par\noindent\begin{minipage}{\textwidth}#1\end{minipage}\par
  \fi
}

\newcommand{\Delvierre@AfterTitleWide}{}%

% ==========================
% Running header helpers
% ==========================
\newcommand{\Delvierre@HeaderRightText}{%
  \ifdefempty{\@journalinfo}{%
    \ifdefempty{\@shorttitle}{\@title}{\@shorttitle}%
  }{%
    \@journalinfo%
  }%
}
\newif\ifDelvierre@runningcrossmark
\Delvierre@runningcrossmarkfalse
\newcommand{\showrunningcrossmark}{\Delvierre@runningcrossmarktrue}
\newcommand{\hiderunningcrossmark}{\Delvierre@runningcrossmarkfalse}

\newcommand{\Delvierre@HeaderRightCrossmark}{%
  \ifDelvierre@runningcrossmark
    \ifdefempty{\@articledoi}{}{%
      \hspace{0.6em}\Delvierre@CrossmarkHeader%
    }%
  \fi
}
\newcommand{\Delvierre@RunHeader}{%
  \begin{tabular*}{\textwidth}{@{}l@{\extracolsep{\fill}}r@{}}%
    {\scriptsize\sffamily
      \ifdefempty{\@runningauthor}{%
        \ifdefempty{\@shorttitle}{\@title}{\@shorttitle}%
      }{\@runningauthor}%
    }%
    &
    {\scriptsize\sffamily
      \Delvierre@HeaderRightText\Delvierre@HeaderRightCrossmark%
    }%
  \end{tabular*}%
}

% ==========================
% Headers / footer
% ==========================
\newlength{\DelvierrePageNumberVShift}
\setlength{\DelvierrePageNumberVShift}{0pt}
\newcommand{\setpagenumbervshift}[1]{\setlength{\DelvierrePageNumberVShift}{#1}}

\RequirePackage{fancyhdr}
\pagestyle{fancy}
\fancyhf{}

\renewcommand{\headrulewidth}{0.4pt}
\renewcommand{\footrulewidth}{0pt}
\fancyhead[C]{\Delvierre@RunHeader}
\fancyfoot[C]{\raisebox{\DelvierrePageNumberVShift}[0pt][0pt]{\sffamily\scriptsize\thepage}}

\fancypagestyle{delvierreFirst}{%
  \fancyhf{}%
  \renewcommand{\headrulewidth}{0pt}%
  \renewcommand{\footrulewidth}{0pt}%
  \fancyhead[C]{}%
  \fancyfoot[C]{}%
}

% ==========================
% Authblk styling
% ==========================
\newcommand{\DelvierreAuthorFontStyle}{\sffamily\normalsize}
\newcommand{\DelvierreAffilFontStyle}{\sffamily\small}
\newcommand{\setauthorfontstyle}[1]{\def\DelvierreAuthorFontStyle{#1}}
\newcommand{\setaffilfontstyle}[1]{\def\DelvierreAffilFontStyle{#1}}
\renewcommand\Authfont{\DelvierreAuthorFontStyle}
\renewcommand\Affilfont{\DelvierreAffilFontStyle}
\setlength{\affilsep}{4pt}
\renewcommand\Authands{ and }

% ==========================
% Title block Crossmark placement
% ==========================
\newcommand{\Delvierre@TitleRightCrossmark}{%
  \ifdefempty{\@articledoi}{}{%
    \nointerlineskip
    \hbox to \textwidth{%
      \hfill
      \raisebox{\DelvierreCrossmarkTitleYOffset}[0pt][0pt]{%
        \Delvierre@CrossmarkButton%
      }%
    }%
    \nointerlineskip
  }%
}
\newcommand{\Delvierre@UpdatesRow}{\Delvierre@TitleRightCrossmark}
\newcommand{\DelvierreArticleTitleStyle}{\fontsize{15}{18}\selectfont\bfseries}
\newcommand{\setarticletitlestyle}[1]{\def\DelvierreArticleTitleStyle{#1}}
\newcommand{\setarticletitlefontsize}[2]{\def\DelvierreArticleTitleStyle{\fontsize{#1}{#2}\selectfont\bfseries}}
\newsavebox{\Delvierre@TitleBox}
\newcommand{\Delvierre@BuildTitleBox}{%
  \ifdefempty{\@shorttitle}{\gdef\@shorttitle{\@title}}{}%
  \setbox\Delvierre@TitleBox=\vbox{%
    \begin{minipage}{\textwidth}
      \Delvierre@Masthead
      \vspace{0.75em}
      {\raggedright
        \DelvierreArticleTitleStyle
        \@title\par
      }
      \Delvierre@TitleRightCrossmark
      \vspace{0.55em}
      {\raggedright \@author\par}
      \vspace{0.85em}
      \vspace*{\DelvierreFrontMatterVShift}%
      \Delvierre@FrontMatter
    \end{minipage}%
  }%
}

\renewcommand{\maketitle}{%
  \begingroup
  \hfuzz=300pt\relax
  \ifdim\DelvierreFirstPageFootskip>0pt\relax
    \DelvierreDidNewGeometrytrue
    \DelvierreNewGeometryWithFootskip{\DelvierreFirstPageFootskip}%
  \fi

  \ifdim\DelvierreBodyHeadsepExtra>0pt\relax
    \AddToHookNext{shipout/after}{\DelvierreAfterFirstShipout}%
  \else
    \ifDelvierreDidNewGeometry
      \AddToHookNext{shipout/after}{\DelvierreAfterFirstShipout}%
    \fi
  \fi
  % Always draw the first-page footer note as an overlay (robust with strip/cuted).
  \Delvierre@PlaceFirstPageFooterOverlay



  \Delvierre@BuildTitleBox
  \twocolumn[%
    \thispagestyle{delvierreFirst}%
    \noindent\hspace*{\DelvierreTitleXShift}\usebox{\Delvierre@TitleBox}%
  ]%
  \endgroup
% (page style set in \twocolumn optional arg)
\Delvierre@AfterTitleWide
}

% --- Section styling ---
\newcommand{\DelvierreSectionTitleStyle}{\large\sffamily\bfseries}
\newcommand{\DelvierreSubsectionTitleStyle}{\normalsize\sffamily\bfseries}
\newcommand{\DelvierreSubsubsectionTitleStyle}{\small\sffamily\bfseries}
\newcommand{\setsectiontitlestyle}[1]{\def\DelvierreSectionTitleStyle{#1}}
\newcommand{\setsubsectiontitlestyle}[1]{\def\DelvierreSubsectionTitleStyle{#1}}
\newcommand{\setsubsubsectiontitlestyle}[1]{\def\DelvierreSubsubsectionTitleStyle{#1}}

\titleformat{\section}{\DelvierreSectionTitleStyle}{\thesection.}{0.55em}{\vspace*{0.6ex}}
\titleformat{\subsection}{\DelvierreSubsectionTitleStyle}{\thesubsection.}{0.55em}{\vspace*{0.6ex}}
\titleformat{\subsubsection}{\DelvierreSubsubsectionTitleStyle}{\thesubsubsection.}{0.55em}{\vspace*{0.6ex}}

\titlespacing*{\section}{0pt}{1.8ex}{1.1ex}
\titlespacing*{\subsection}{0pt}{1.8ex}{1.1ex}
\titlespacing*{\subsubsection}{0pt}{1.8ex}{1.1ex}



% ==========================
% References / bibliography (Delvierre)
% ==========================
% Start references on a fresh page (still two-column), and match the Delvierre underline style.
% If you want your first-page "Contents" block to include a page number for the bibliography, set:
%   \setreferencesanchor{sec:references}
% then use \pageref{sec:references} in \contentsentry.
\def\Delvierre@ReferencesAnchor{}
\newcommand{\setreferencesanchor}[1]{\def\Delvierre@ReferencesAnchor{#1}}

\newcommand{\Delvierre@BibHeading}{%
  \Delvierre@PlainHeading{\MakeUppercase{\refname}}%
}

% Helpers for "whole-entry" clickable references (manual thebibliography):
%   \bibitem{key}\DelvierreBibDOI{10.xxxx/xxxxx}{Author, "Title", \textit{Journal} ...}
\newcommand{\DelvierreBibDOI}[2]{\href{https://doi.org/#1}{#2}}
\newcommand{\DelvierreBibHref}[2]{\href{#1}{#2}}


\renewcommand{\bibsection}{%
  \par\addvspace{1.8ex}%
  \ifdefempty{\Delvierre@ReferencesAnchor}{}{%
    \phantomsection
    \begingroup
      \edef\DelvierreTmpAnchor{\Delvierre@ReferencesAnchor}%
      \expandafter\label\expandafter{\DelvierreTmpAnchor}%
    \endgroup
  }%
  \section*{\refname}%
  \vspace{1.1ex}%
}
\renewcommand{\bibfont}{\small}
\setlength{\bibsep}{1.2pt}
\setlength{\bibhang}{1.2em}
\AtBeginEnvironment{thebibliography}{\sloppy}
\makeatother
\endinput


% ==========================
% Author-template overrides for submission package
% ==========================
\AtBeginDocument{%
  \renewcommand{\Delvierre@Masthead}{}%
  \renewcommand{\Delvierre@TitleRightCrossmark}{}%
  \renewcommand{\Delvierre@PlaceFirstPageFooterOverlay}{}%
  \renewcommand{\Delvierre@ArticleInfo}{}%
  \renewcommand{\Delvierre@ContentsBlock}{}%
  \renewcommand{\Delvierre@RunHeader}{}%
  \fancyhf{}%
  \renewcommand{\headrulewidth}{0pt}%
  \renewcommand{\footrulewidth}{0pt}%
  \fancyhead[C]{}%
  \fancyfoot[C]{\sffamily\scriptsize\thepage}%
  \fancypagestyle{delvierreFirst}{%
    \fancyhf{}%
    \renewcommand{\headrulewidth}{0pt}%
    \renewcommand{\footrulewidth}{0pt}%
    \fancyhead[C]{}%
    \fancyfoot[C]{\sffamily\scriptsize\thepage}%
  }%
  \renewcommand{\Delvierre@FrontMatter}{%
    \noindent
    \begin{minipage}[t]{0.34\textwidth}
      \Delvierre@HighlightsBlock
    \end{minipage}%
    \hfill
    \begin{minipage}[t]{0.62\textwidth}
      \Delvierre@GraphicalAbstractBlock
    \end{minipage}%
    \par\vspace{0.35cm}%
    \Delvierre@AbstractBlock
  }%
}

\AtBeginDocument{%
  \publisherlogo{}\journallogo{}\articledoi{}\crossmarklogo{}\publishername{}\journalname{}\journalhomepage{}\journalissn{}\journaltagline{}\setrunningauthor{}\setjournalinfo{}%
}
