# otuasoiu class

The otuasoiu class to be used for documents which are prepared
on the "Automatic systems for information processing and 
control" (ASOIU) of Omsk State Technical University, Omsk, 
Russia. This class is based on article class and requires XeLaTeX
or LuaLaTeX for its proper working. Formatting complies with the
instruction issued at January 29, 2024 and GOST 7.32-2017.

Since this class file is created for Russian students who wants
to use TeX, most of instructions are written in Russian.

To extract omgtudoc-asoiu class files execute this command: 

    xetex omgtudoc-asoiu.ins

Then you'll have following files:

- `omgtudoc-asoiu.cls` - class file;

- `labreport.tpt`, `courseproj.tpt`, `minimal.tpt` - document format files;

- `omgtu-gost-numeric.bbx` - biblatex bibliography format.

You should copy these files into `tex/latex/omgtudoc-asoiu` directory.

The otuasoiu class may be distributed and/or modified under the
conditions of the LaTeX Project Public License, either
version 1.3 of this license or (at your option) any later
version. The latest version of this license is in:

     http://www.latex-project.org/lppl.txt

and version 1.3c or later is part of all distributions of
LaTeX version 2008-05-04 or later.

# Класс otuasoiu

Класс otuasoiu предназначен для документов, 
подготавливаемых на кафедре «Автоматизированные системы
обработки информации и управления» Омского государственного
технического университета. Он основан на классе article и
для своей работы требует XeTeX или LuaLaTeX. Оформление
соответствует рабочей инструкции, введённой 29 января 2024 года,
и ГОСТ 7.32-2017.

Для установки класса необходимо сначала получить все необходимые
файлы командой:

    xetex omgtudoc-asoiu.ins

После этого вам будут предоставлены файлы:

- `omgtudoc-asoiu.cls` - файл класса;

- `labreport.tpt`, `courseproj.tpt`, `minimal.tpt` - файлы
форматов документов;

- `omgtu-gost-numeric.bbx` - формат библиографии для biblatex.

Эти файлы необходимо скопировать в папку `tex/latex/omgtudoc-asoiu`,
которую, скорее всего, нужно будет создать.