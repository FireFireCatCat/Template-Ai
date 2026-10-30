LATEX=pdflatex

QUESTIONS=cosmo1.tex \
	cosmo2.tex \
	cosmo3.tex \
	dynamical1.tex \
	dynamical2.tex \
	dynamical3.tex \
	excos1.tex \
	numerical1.tex \
	numerical2.tex \
	numerical3.tex

%.pdf: %.tex ../exam-n.cls
	TEXINPUTS=..: $(LATEX) $<
	if grep 'Rerun to get cross' ${<:.tex=.log}; then TEXINPUTS=..: $(LATEX) $<; else :; fi

all: sample_exam.pdf

sample_exam.pdf: numerical1-solution.pdf $(QUESTIONS)

sample_exam_solution.pdf: sample_exam_solution.tex $(QUESTIONS)

sample_exam_solution.tex: sample_exam.tex
	rm -f $@
	sed -e '1s/documentclass\[/documentclass[showsolutions,/' \
	    -e '1s/documentclass{/documentclass[showsolutions]{/' \
	    sample_exam.tex >sample_exam_solution.tex

# This will depend somehow on the .dtx file in the parent directory,
# but expressing that here second-guesses how that file is actually
# generated, so skip this ('don't repeat yourself'; also, this is only
# occasionally used while testing)
../exam-n.cls:
	cd ..; $(MAKE) exam-n.cls

clean:
	rm -f *.pdf *.log *.aux sample_exam_solution.tex
