PACKAGE=amnestyreport

SAMPLES = \
	sample.Rmd

PDF = $(PACKAGE).pdf ${SAMPLES:%.Rmd=%.pdf}

all:  ${PDF}



%.pdf:  %.dtx   $(PACKAGE).cls
	xelatex $<
	- bibtex $*
	xelatex $<
	- makeindex -s gind.ist -o $*.ind $*.idx
	- makeindex -s gglo.ist -o $*.gls $*.glo
	xelatex $<
	while ( grep -q '^LaTeX Warning: Label(s) may have changed' $*.log) \
	do xelatex $<; done

%.pdf: %.Rmd $(PACKAGE).cls amnestytemplate.tex
	Rscript -e "rmarkdown::render('$<', output_file='$@',  output_format='pdf_document')"

%.cls:   %.ins %.dtx  
	xelatex $<

%.pdf:  %.tex   $(PACKAGE).cls
	xelatex $<
	- bibtex $*
	xelatex $<
	while ( grep -q '^LaTeX Warning: Label(s) may have changed' $*.log) \
	do xelatex $<; done

.PRECIOUS:  $(PACKAGE).cfg $(PACKAGE).cls


clean:
	$(RM)  $(PACKAGE).cls *.log *.aux \
	*.cfg *.glo *.idx *.toc \
	*.ilg *.ind *.out *.lof \
	*.lot *.bbl *.blg *.gls \
	*.dvi *.ps *.thm *.tgz *.zip *.rpi  \
        *.hd sample-blx.bib sample.run.xml \
	sample-tikzDictionary \
	*-blx.bib 
	$(RM) -r sample_files

distclean: clean
	$(RM) $(PDF) sample.tex
	$(RM) -r sample_files

#
# Archive for the distribution. Includes typeset documentation
#
archive:  all clean
	COPYFILE_DISABLE=1  \
	tar -C .. -czvf ../$(PACKAGE).tgz --exclude '*~' \
	--exclude '*.tgz' --exclude '*.zip'  --exclude ".git*" \
	--exclude Amnesty_logo.png $(PACKAGE)

zip:  all clean
	make $(PACKAGE).cls
	$(RM) $(PACKAGE).log
	cd ..;\
	zip -r  $(PACKAGE).zip $(PACKAGE) -x "*.ins" -x "*.gitignore" \
	-x "*-blx.bib" -x "*sample-tikzDictionary" -x "*sample_files*"

