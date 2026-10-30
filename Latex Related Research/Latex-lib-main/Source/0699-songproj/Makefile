all: sty pdf

sty: songproj.sty

pdf: songproj.pdf

%.pdf: %.dtx %.gls %.ind
	xelatex $<

%.glo %.aux %.idx: %.dtx
	xelatex $<

%.gls: %.glo
	makeindex -s gglo.ist -o $@ $<

%.ind: %.idx
	makeindex -s gind.ist -o $@ $<

%.sty: %.ins %.dtx
	xelatex $<

mostlyclean:
	rm -f *.aux *.glo *.gls *.hd *.idx *.ilg *.ind *.log *.out

ctanclean: mostlyclean
	rm -f *.sty

clean: mostlyclean
	rm -f *.pdf

maintainer-clean: ctanclean clean

.PHONY: all sty doc mostlyclean ctanclean clean maintainer-clean
