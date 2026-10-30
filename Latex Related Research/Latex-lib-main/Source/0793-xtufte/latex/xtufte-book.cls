% $Id: xtufte-book.cls 6 2025-11-27 09:19:17Z herbert $

\NeedsTeXFormat{LaTeX2e}[1994/06/01]

\ProvidesClass{xtufte-book}[2025/11/27 v0.03 xtufte-book class]
%%
%% This is an extended version of the package tufte-latex
%% https://ctan.org/pkg/tufte-latex
%% The original version is under Apache License, Version 2.0
%% Copyright 2007-2010 by Kevin Godby, Bil Kleb, and Bill Wood.
%%
%% This version is
%% Copyright (C) 2025 Herbert Voss <hvoss@tug.org>
%%
%% It may be distributed and/or modified under the conditions
%% of the LaTeX Project Public License, either version 1.3
%% of this license or (at your option) any later version.
%%
%% See http://www.latex-project.org/lppl.txt for details.
%%
% Declare we're tufte-book
\newcommand\@tufte@class{book}
% the base LaTeX class (defaults to the article/handout style)

\newcommand\@tufte@pkgname{xtufte-book}
% the name of the package (defaults to xtufte-handout)

%%
% Load the common style elements
\input{xtufte-common.def}

%%
% Set up any book-specific stuff now

%%
% The front matter in Tufte's /Beautiful Evidence/ contains everything up
% to the opening page of Chapter 1.  The running heads, when they appear,
% contain only the (arabic) page number in the outside corner.
%\newif\if@mainmatter \@mainmattertrue
\renewcommand\frontmatter{%
  \cleardoublepage%
  \@mainmatterfalse%
  \pagenumbering{arabic}%
  %\pagestyle{plain}%
  \fancyhf{}%
  \ifthenelse{\boolean{@tufte@twoside}}%
    {\fancyhead[LE,RO]{\thepage}}%
    {\fancyhead[RE,RO]{\thepage}}%
}
%%
% The main matter in Tufte's /Beautiful Evidence/ doesn't restart the page
% numbering---it continues where it left off in the front matter.
\renewcommand\mainmatter{%
  \cleardoublepage%
  \@mainmattertrue%
  \fancyhf{}%
  \ifthenelse{\boolean{@tufte@twoside}}%
    {% two-side
      \renewcommand{\chaptermark}[1]{\markboth{##1}{}}%
      \fancyhead[LE]{\thepage\quad\smallcaps{\newlinetospace{\plaintitle}}}% book title
      \fancyhead[RO]{\smallcaps{\newlinetospace{\leftmark}}\quad\thepage}% chapter title
    }%
    {% one-side
      \fancyhead[RE,RO]{\smallcaps{\newlinetospace{\plaintitle}}\quad\thepage}% book title
    }%
}
%%
% The back matter contains appendices, indices, glossaries, endnotes,
% biliographies, list of contributors, illustration credits, etc.
\renewcommand\backmatter{%
  \if@openright%
    \cleardoublepage%
  \else%
    \clearpage%
  \fi%
  \@mainmatterfalse%
}
%%
% Only show the chapter titles in the table of contents
\setcounter{tocdepth}{0}

%%
% If there is a `xtufte-book-local.sty' file, load it.

\IfFileExists{xtufte-book-local.tex}{%
  \@tufte@info@noline{Loading xtufte-book-local.tex}%
  \input{xtufte-book-local}%
}{}

%%
% End of file
\endinput
