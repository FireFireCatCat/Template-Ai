This is the README file for the CollegeNotice class for LaTeX.  It
corresponds to version 1.0 of the CollegeNotice class (23/04/2012).
This README is public domain.

==============================
Using the class CollegeNotice
==============================

Sample File
-----------

There is a sample notice in the file test.tex. Mostly this is useful as an example of how to produce the front matter.  If you don't understand LaTeX at all, this file might help you get started.

Choosing the CollegeNotice class
---------------------------------

To use the CollegeNotice class, make sure that the CollegeNotice.cls file is on your TEXINPUTS search path and use the following command at the start of your input file:

\documentclass{ CollegeNotice}

==================================
What the CollegeNotice class does
==================================

The CollegeNotice is a class for use in Finolex Academy of Management and Technology(FAMT) to prepare a notice according to standard norms.

The key features of the class are:

1)	By default this class uses FAMT as default college and Information Technology as default department, which can be changed as per user requirements. 

Declarations
------------

To use the notice, you must first declare a number of text strings:

\College	Specify the name of the college, if it is other than FAMT
\Department	Specify the name of the department, if it is other than Information Technology
\Issuedate		The date when the notice is to be issued
\subject		Specify the subject of notice
\content		The matter to be printed in the notice
\Name			The name of the person issuing the notice
\Designation	The name of the person issuing the notice


===================================
Installing the CollegeNotice class
===================================

To install the CollegeNotice class, you need to install following files:

	CollegeNotice.cls

in your LaTeX class file repository.

