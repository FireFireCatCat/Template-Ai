\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{texecole}[2026-07-30 v1.1 Un langage de composition documentaire en francais]
\RequirePackage{iftex}
\ifluatex\else
  \ClassError{texecole}
    {texecole exige LuaLaTeX}
    {Compilez avec « lualatex » (ou latexmk -lualatex), pas pdflatex ni xelatex.%
     Dans TeXstudio : Options > Configurer > Production > Compilateur par defaut : LuaLaTeX.}
\fi
\RequirePackage{kvoptions}
\SetupKeyvalOptions{family=texecole, prefix=texecole@}
\DeclareStringOption[20]{marges}
\DeclareStringOption[2]{espacements}
\DeclareStringOption[Latin Modern Roman]{police}
\DeclareStringOption[Latin Modern Math]{math}
\DeclareStringOption[11]{taille}
\DeclareStringOption[1.0]{interligne}
\DeclareStringOption[8]{tabulation}
\DeclareStringOption[8]{hauteur}
\DeclareStringOption[100]{decalage}
\DeclareStringOption[-1]{precision}
\DeclareVoidOption{dummy}{}%
\define@key{texecole}{décalage}{\def\texecole@decalage{#1}}
\define@key{texecole}{précision}{\def\texecole@precision{#1}}
\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}{extarticle}}
\ProcessKeyvalOptions*
\begingroup\lccode`\~=`\,\lowercase{\endgroup
  \def\texecole@commatodot#1{\def\texecole@do##1~##2\relax{%
    \ifx\relax##2\relax\edef#1{##1}\else\edef#1{##1.\texecole@strip##2}\fi}%
    \expandafter\texecole@do#1~\relax\relax}%
  \def\texecole@strip#1~\relax{#1}}
\texecole@commatodot\texecole@interligne
\LoadClass[\texecole@taille pt, a4paper]{extarticle}
% --- Balayage précoce (chantiers B et C de l'audit de performances) ------
% Avant de charger les gros paquets, la classe lit le source du document :
% elle soumet d'un seul geste tous les calculs SymPy au serveur Python —
% qui calcule pendant que TeX charge fontspec, tcolorbox et pgfplots —
% et note quelles bibliothèques le document emploie réellement. En cas de
% doute ou d'échec du balayage (par exemple avec -jobname), tout se charge
% comme avant : le balayage est une optimisation, jamais une condition.
\def\texecole@besoinplots{1}
\def\texecole@besointab{1}
\def\texecole@besoinposter{1}
\def\texecole@besointableau{1}
\directlua{pcall(function() require("texecole-prefetch").lancer() end)}
\RequirePackage{amsmath}
\RequirePackage{array}
\RequirePackage{graphicx}
\RequirePackage{xstring}
% Aucun graphicspath par défaut : texecole n'ajoute ni « ./ » ni un dossier
% « IMG » implicite — <Insère une image> exige systématiquement « dans le
% dossier {...} », pour que le chemin d'une image ne dépende jamais d'un
% réglage caché.
\RequirePackage[svgnames]{xcolor}
\RequirePackage{enumitem}
\RequirePackage{amssymb}
\RequirePackage{ragged2e}
\RequirePackage[normalem]{ulem}%
\RequirePackage[bottom]{footmisc}%
\RequirePackage{needspace}
% --- Chargement systematique des dependances ------------------------------
% Toutes les bibliotheques employees par texecole sont chargees a chaque
% compilation : le comportement est ainsi identique pour tous les documents.
% Le programme minimal « precharge.tex », fourni avec la classe, se compile
% une seule fois apres l'installation : il precharge l'ensemble de ces
% bibliotheques (construction des caches, notamment celui des polices) et
% verifie que la distribution est complete.
\RequirePackage[skins,breakable,raster]{tcolorbox}
\ifnum\texecole@besoinposter=1
  \tcbuselibrary{poster}
\fi
\ifnum\texecole@besointab=1
  \RequirePackage{tkz-tab}
\fi
\ifnum\texecole@besointableau=1
  \RequirePackage{tabularray}
\fi
\ifnum\texecole@besoinplots=1
  \RequirePackage{pgfplots}
  \pgfplotsset{compat=1.18}
  \usepgfplotslibrary{fillbetween}
\fi
\setlength{\JustifyingParindent}{0pt}
\newlength{\texecoletab}
\setlength{\texecoletab}{\texecole@tabulation mm}
\newlength{\texecoleline}
\setlength{\texecoleline}{\texecole@hauteur mm}
\RequirePackage{titlesec}
\titlespacing*{\section}      {0pt}{0pt}{0pt}
\titlespacing*{\subsection}   {0pt}{0pt}{0pt}
\titlespacing*{\subsubsection}{0pt}{0pt}{0pt}
\edef\texecole@scriptfactor{\strip@pt\dimexpr\texecole@decalage pt/100\relax}
\newcommand{\texecolescript}[2]{\raisebox{#1}{\scalebox{\texecole@scriptfactor}{#2}}}
\RequirePackage{fontspec}
\RequirePackage{unicode-math}
\RequirePackage{geometry}
% --- Marges externes (le « margin » anglais) -------------------------------
% Une valeur pour les quatre côtés (marges=20), ou quatre valeurs
% haut;droite;bas;gauche (marges={25;20;25;20}). Les accolades sont
% retirées par l'analyseur d'options : la valeur reçue est « 25;20;25;20 ».
\StrCount{\texecole@marges}{;}[\texecole@nsemis]
\ifnum\texecole@nsemis=3\relax
  \StrCut{\texecole@marges}{;}\texecole@mt\texecole@mrest
  \StrCut{\texecole@mrest}{;}\texecole@mr\texecole@mrest
  \StrCut{\texecole@mrest}{;}\texecole@mb\texecole@ml
  \geometry{top=\texecole@mt mm, right=\texecole@mr mm,
            bottom=\texecole@mb mm, left=\texecole@ml mm}%
\else
  \ifnum\texecole@nsemis=0\relax
    \geometry{margin=\texecole@marges mm}%
  \else
    \ClassError{texecole}{l'option marges prend une valeur (marges=20)
      ou quatre (marges={25;20;25;20}, dans l'ordre
      haut;droite;bas;gauche), en millimetres. L'espacement interieur
      des cadres se regle desormais par l'option espacements=...}{}%
  \fi
\fi
% --- Espacements internes (le « padding » anglais) -------------------------
% Une valeur pour les quatre côtés (espacements=2), ou quatre valeurs
% haut;droite;bas;gauche (espacements={4;2;4;2}), en millimètres. Cette
% épaisseur sépare le contenu des cadres, tableaux et zones de leur bord.
\StrCount{\texecole@espacements}{;}[\texecole@nsemisesp]
\ifnum\texecole@nsemisesp=3\relax\else
  \ifnum\texecole@nsemisesp=0\relax\else
    \ClassError{texecole}{l'option espacements prend une valeur
      (espacements=2) ou quatre (espacements={4;2;4;2}, dans l'ordre
      haut;droite;bas;gauche), en millimetres}{}%
  \fi
\fi
\directlua{texecole = require("texecole")}
\directlua{texecole.config = texecole.config or {};
  texecole.config.padding   = "\texecole@espacements";
  texecole.config.lang      = "fr";
  texecole.config.precision = tonumber("\texecole@precision")}
\IfFontExistsTF{\texecole@police}{%
	\setmainfont{\texecole@police}%
}{%
	\directlua{texecole.respace("texecole@police")}%
	\IfFontExistsTF{\texecole@police}{%
		\setmainfont{\texecole@police}%
	}{%
		\ClassWarningNoLine{texecole}{Police '\texecole@police' introuvable,
      repli sur Latin Modern Roman}%
		\setmainfont{Latin Modern Roman}%
	}%
}
\IfFontExistsTF{\texecole@math}{%
	\setmathfont{\texecole@math}%
}{%
	\directlua{texecole.respace("texecole@math")}%
	\IfFontExistsTF{\texecole@math}{%
		\setmathfont{\texecole@math}%
	}{%
		\ClassWarningNoLine{texecole}{Police mathematique '\texecole@math'
      introuvable, repli sur Latin Modern Math}%
		\setmathfont{Latin Modern Math}%
	}%
}
\AtBeginDocument{%
	\providecommand\fint{}%
	\renewcommand\fint{\mathchoice
		{\rlap{\,\,\raisebox{0.32em}{\scalebox{0.7}{$-$}}}\!\int}%
		{\rlap{\,\,\raisebox{0.30em}{\scalebox{0.6}{$-$}}}\!\int}%
		{\rlap{\,\raisebox{0.28em}{\scalebox{0.5}{$-$}}}\!\int}%
		{\rlap{\,\raisebox{0.28em}{\scalebox{0.5}{$-$}}}\!\int}}%
	\providecommand\texecoleparallelogram{\mathord{\tikz[baseline=-0.5ex,%
		line width=0.5pt]{\draw (0,0) -- (0.28,0) -- (0.36,0.22)%
		-- (0.08,0.22) -- cycle;}}}%
}
\setlength{\parindent}{0pt}
\setlength{\parskip}{0.5em}
\linespread{\texecole@interligne}
\setlength{\lineskiplimit}{3pt}
\setlength{\lineskip}{3pt}
\AtBeginDocument{%
	\directlua{
	local path = status and status.filename
	local f = path and io.open(path, "r")
	if not f then
	path = tex.jobname .. ".tex"
	f = io.open(path, "r")
	end
	if not f then
	tex.error("texecole.cls : impossible de rouvrir le fichier source pour"
	.. " lire le corps du document (essaye : '" .. tostring(path) .. "')."
	.. " Si vous avez utilise -jobname, la classe doit tout de meme"
	.. " retrouver le vrai fichier .tex")
	else
	local whole = f:read("*a"); f:close()
	local body, tail = whole:match("\string\\begin{document}(.-)\string\\end{document}(.*)$")
	if not body then
	tex.error("texecole.cls : begin/end document introuvables")
	else
	if tail and tail:find("\string\\end{document}", 1, true) then
	texio.write_nl("term and log", "texecole : attention, un autre"
	.. " \string\\end{document} apparait apres le premier ; le corps a ete"
	.. " coupe a la PREMIERE occurrence.")
	end
	texecole.inject(body)
	end
	end
}%
\end{document}%
}
