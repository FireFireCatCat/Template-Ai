TOPtesi bundle version 6.x
Copyright 2008-2025 Claudio Beccari
LaTeX Project Public Licence LPPL v.1.3c (or later)

This work may be distributed and/or modified under 
the conditions of the LaTeX Project Public License, 
either version 1.3c of this license or (at your 
option) any later version. The latest version of 
this license is in 
http://www.latex-project.org/lppl.txt 
and version 1.3c or later is part of all distributions of LaTeX version 2003/12/01 or later.

This work itself and every derived work are subject 
to the abovelicence, included the file toptesi.cfg 
that may be copied to a different named file and 
the copy can be modified at will by the user.

This work has the LPPL maintenance status 
"author-maintained".

This work consists of the following files:

    toptesi.dtx
    toptesi-example.tex
    toptesi-example-luatex.tex
    toptesi-example-xetex.tex
    toptesi-example-con-frontespizio.tex
    topfront-example.tex
    toptesi-example-sss.tex
    toptesi-example-triennale.tex
    toptesi-example-dottorale.tex
    toptesi-example-magistrale.tex
    toptesi-scudo-example.zip
    README.txt
    toptesi-it.tex
    
The files derived from the work are the following:

    toptesi.cls
    toptesi.sty
    topcoman.sty
    topfront.sty
    toptesi.cfg
    toptesi.pdf
    toptesi-monografia.sty
    toptesi-scudo.sty
    toptesi-magistrale.sty
    toptesi-dottorale.sty
    toptesi-sss.sty
    toptesi-it.pdf
    together with all the *-example-*.pdf derived 
    from the corresponding  *-example-*.tex ones.

The toptesi.dtx file is self extracting and self 
documenting; if you run pdflatex on it you get at 
the same time the class, the style files, the 
toptesi configuration file, plus the English 
documented code.

The Italian documentation file is obtained by 
running LuaLaTeX on toptesi-it.tex; this 
documentation has been completely redone compared 
to previous versions. With this compiler the result 
is PDF/A-1b compliant. The compilation of this file 
requires input of various .pdf files, mostly 
obtained by processing the .tex files belonging to 
the bundle. It requires also the FAKE logos of 
Politecnico di Torino and of its doctoral school. 
See below.

The two documentations pdf files, toptesi.pdf and 
toptesi-it.pdf, are complementary to one another 
and both should be stored in the 
doc/latex/toptesi/ folder.
 
The various files

    toptesi-example.tex
    toptesi-example-luatex.tex
    toptesi-example-xetex.tex
    toptesi-example-frontespizio.tex
    topfront-example.tex
    toptesi-example-sss.tex
    toptesi-example-triennale.tex
    toptesi-example-magistrale.tex
    toptesi-example-dottorale.tex

are examples of the usage of this work; except the 
second and third ones, explicitly created to be 
used with LuaLaTeX or XeLaTeX respectively; all the 
others compile correctly with pdflatex; they may be 
used as templates, but in themselves, although part 
of this Work, they may be used by the end users 
the way they like best, in order to use them as 
templates, but the files should not be modified 
unless their names are changed.

----------------------------------------------------

The TOPtesi bundle contains everything is needed 
to typeset a bachelor, master or PhD thesis in 
Italian intermixed with English and viceversa  (or 
in any other language supported by LaTeX: the 
bundle supports multi-language use).

The infix strings may be selected and/or specified 
at will by means of a configuration file, so as to 
customise the information of the title page to the 
requirements of a specific university and a specific 
language.

Thanks to its language management, the bundle is 
suited formulti-language theses that are more and 
more frequent thanks to the double degree programs 
of the European Union Erasmus programs or the Life 
Long Learning European programs.

Version 6.x is backwards compatible, but it is 
completely new; it uses key=value options, and uses 
different modules to typeset all types of thesis 
supported by the package; it allows to select the 
use of the frontespizio package to typeset the title 
page in substitution of its standard modules; it 
allows a custom setting, to let users typeset their 
own title page layout. 

As a new feature compared to versions 5.x, among the 
various thesis types there is also the one that 
Italian students submit to the examining committee 
of their final high-school State Exam.

Version 6.4.x is further upgraded in order to 
customise header positions and folios. It is also 
upgraded to allow compliance with level 2 of the 
ISO PDF/A regulations on long term archivability. 
Because the filecontents *package* functionalities 
have been embedded into the LaTeX *kernel* 
environment, in a way backwards compatible with the 
previous definition of that environment, the now 
obsolete filecontents package functionalities may 
still be obtained, but with a different syntax; 
therefore a new TOPtesi specific metadata 
environment has been defined so as to bypass such 
syntax changes.

The new environment Sintassi (provided by the 
FramedSyntax.sty package already included in 
upgraded complete TeX system installations) is used 
to highlight the syntax of some commands, 
environments, and some code samples used for special 
purposes.

Versions 6.4.x contain some enhancements and 
corrections, especially in view of the 2019 Italian 
TUG meeting that contained a tutorial on this 
bundle. For what concerns PDF/A compliance, the 
latest version is compliant withe PDF/A-2b level; 
the documentation gives instructions that are up to 
date with package pdfx dated July 2024, version 
1.6.5. Nevertheless in 2024 a new method was published by the LaTeX Project Team  that employs some features of the “Tagging” Project; Nothing is said in this documentation because the new features are still experimental; when such features become stable, TOPtesi will be upgraded.

Versions 6.x derive from previous versions by using 
several features of the LaTeX3 language.

Version 5.92 of TOPtesi was intended to be compliant 
also with XeLaTeX and LuaLaTeX; its documentation 
explained also how to obtain PDF/A-1b archivable 
files from pdfLaTeX, XeLaTeX, and LuaLaTeX. This 
particular functionality was up to date with 
respect to package pdfx dated 2016/05/03 v.1.5.8.

Version 5.91 contained some small enhancements and 
bug corrections.

Version 5.90 was enhanced with more class options 
that allowed TOPtesi to be used with external 
packages for typesetting the title page in different styles. It had a completely enhanced and redone Italian documentation file toptesi-it.pdf.

----------------------------------------------------

You might have your valid reasons for not upgrading 
your installed TeX system distribution, but in 
order to have available some new functionalities, 
you might consider upgrading your installation; 
otherwise you have to install the whole TOPtesi 
bundle by yourself. You can get some help by
carefully reading the Italian documentation file 
toptesi-it.

In this case you have to download the toptesi.zip file from a CTAN archive and save it to this folder
(possibly created on purpose):

.../texmf/source/latex/toptesi.

and decompress it.

Then run pdflatex on toptesi.dtx in order to get 
the class, style and configuration files (and the 
pdf documentation in English) and move 
the .tex, .cls, .sty, and .cfg files 
(including the example .tex files) to 
.../texmf/tex/latex/toptesi/. 
Move both pdf files toptesi.pdf and toptesi-it.pdf to .../texmf/doc/latex/toptesi/.

If the mentioned folders do not exist, create them.

For a personal installation, the /texmf folder is 
your personal one, rooted in your home directory: 
~ on Linux; ~/Library on Mac OSX; on a path with 
different names on different Windows systems, all of 
them containing in one form or another your login 
name; in recent Windows editions your home directory 
is 
C:\Users\<your login name>.

If you are running a Windows platform change the 
slashes into backslashes and prefix all paths with 
the drive letter and any other specific prefix that 
is actually used in your personal texmf tree. 

Remember to refresh the filename database if you 
are using a MiKTeX installation! 
This operation is not required if you have a TeXLive installation.

----------------------------------------------------

Two fake logos of the "Institute of Technology of 
Turin" and its Doctoral School are provided, in 
substitution of the legal official ones. They both 
have a "FAKE LOGO" watermark so as to be sure they 
are not used in place of the official ones. In the 
documentation of this bundle they are used as 
examples of possible logos, but they do not 
represent in any way any official logo. Even the 
fake institutional name, the translation 
in English of the official Italian one, has nothing 
to do with the trademarked one, the only one the 
Politecnico of Torino bachelor, master, and PH.D. 
students should use for their actual theses; they 
have to get the official logos from their Student 
Office, or from the official restricted Web site 
where only institutional Ph.D. students have access.

----------------------------------------------------

The package is already installed with *complete* 
TeXLive, MacTeX or MiKTeX distributions. In this 
case you don't need to decompress anything and move 
files around; in case of TeX system upgrades your 
package manager will do the work for you. 

Possibly check if the CTAN repository contains a 
newer version and, in case, use your package manager 
to upgrade your installation, but remember that you 
are not supposed to directly move or change anything 
in the TeX system directories.

