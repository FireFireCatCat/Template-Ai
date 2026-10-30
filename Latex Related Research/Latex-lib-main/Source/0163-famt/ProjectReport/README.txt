This is the README file for the ProjectReport class for LaTeX.  It
corresponds to version 1.0 of the ProjectReport class (23/04/2012).
This README is public domain.

==============================
Using the class ProjectReport
==============================

Sample File
-----------

There is a sample dissertation in the file test.tex. Mostly this is useful as an example of how to produce the front matter.  If you don't understand LaTeX at all, this file might help you get started.

Choosing the ProjectReport class
---------------------------------

To use the ProjectReport class, make sure that the ProjectReport.cls file is on your TEXINPUTS search path and use the following command at the start of your input file:

\documentclass{ProjectReport}

==================================
What the ProjectReport class does
==================================

The ProjectReport class is a modified version of the standard LaTeX REPORT class that is accepted for use with Finolex Academy of Management and Technology (FAMT) dissertations theses.

The key features of the class are:

1) The title page and certificate page is designed to fulfill the specifications of FAMT institute.

2) Margins are 1.3 inches from the left, 1.1 inches from right, 1.4 inches from top and 1.1 inches from bottom.

3) Uses 12 point by default.

4) Page numbers are in the center at the bottom for all pages.

5) Complete, correct front matter for ProjectReport can be generated.  If you are not a FAMT student, you should make sure that the front matter is OK with your institute.

Page Headers
------------

Using fancyhdr package, a provision is made to display the section name in header at the right corner.

============
Front matter
============

The other key service provided by this class is that it generates correct front matter (title page, certificate page, etc.) with a fairly simple set of commands.

A complete example of the use of the front matter commands can be found in the sample dissertation distributed with the class.

Declarations
------------

To use the front matter macros and environments, you must first declare a number of text strings:

\Protitle		Project title
\Degree	The title of your degree (e.g. Bachelor of Engineering)
\Department	The official title of your field.  This is usually your department's name.
\University 	Name of University
\College		Name of College
\Year			Academic year
\monthnum		The month number has to specified
\RegA			Registration number of student
\MemberA		Name of student

Other Front Matter
------------------

The remaining front matter (table of contents, lists of figures and tables) MUST be put inside the "frontmatter" environment, which ensures that page-numbering is handled properly. 

===================================
Installing the ProjectReport class
===================================

To install the ProjectReport class, you need to install following files:

	ProjectReport.cls

in your LaTeX class file repository.

