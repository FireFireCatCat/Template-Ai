% $Id: xtufte-handout.cls 6 2025-11-27 09:19:17Z herbert $
\NeedsTeXFormat{LaTeX2e}[1994/06/01]

\ProvidesClass{xtufte-handout}[2025/11/27 v0.03 xtufte-handout class]
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
%%
% Declare we're xtufte-handout
\newcommand\@tufte@class{article}
% the base LaTeX class (defaults to the article/handout style)

\newcommand\@tufte@pkgname{xtufte-handout}
% the name of the package (defaults to tufte-handout)

%%
% Load the common style elements
\input{xtufte-common.def}
%%
% Set up any handout-specific stuff now

%%
% Abstract

% TODO The abstract should be printed on its own page of the `titlepage'
% option was specified.
\renewenvironment{abstract}
  {\begin{quotation}\if@tufte@sfsidenotes\begin{sffamily}\fi}
  {\if@tufte@sfsidenotes\end{sffamily}\fi\end{quotation}}


%%
% If there is a `tufte-handout-local.tex' file, load it.

\IfFileExists{xtufte-handout-local.tex}{%
  \input{xtufte-handout-local}%
  \@tufte@info@noline{Loading xtufte-handout-local.tex}%
}{}


%%
% End of file
\endinput
