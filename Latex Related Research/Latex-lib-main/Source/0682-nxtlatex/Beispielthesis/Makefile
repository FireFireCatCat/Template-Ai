# Beispielthesis mit der Klasse nxtthesis.
#
#   make          Daten rechnen und Dokument setzen
#   make daten    nur rechnen (Python + GLPK), erzeugt Abbildungen/ und Tabellen/
#   make pdf      nur setzen (setzt die Daten voraus)
#   make schnell  ein einziger LaTeX-Lauf, für Zwischenstände
#   make clean    Hilfsdateien entfernen
#   make purge    zusätzlich alles Erzeugte entfernen (auch Abbildungen)
#
# Die Klasse muss installiert sein: im Wurzelverzeichnis »make install«.

JOB     = BeispielthesisNXT
ENGINE  = lualatex -interaction=nonstopmode -halt-on-error
PYTHON  = python3
CODE    = Code

.PHONY: all daten pdf schnell clean purge

all: daten pdf

# ---------------------------------------------------------------- Daten
# Reihenfolge zählt: daten.py erzeugt die GLPK-Datendatei, die sa.py für
# den Vergleich mit dem exakten Verfahren braucht.
daten:
	@echo "==> Instanz und GLPK-Datendatei erzeugen"
	cd $(CODE) && $(PYTHON) daten.py
	@echo "==> Farben aus nxtlatexcolors.sty exportieren"
	cd $(CODE) && $(PYTHON) farben.py
	@echo "==> Verfahren rechnen (Simulated Annealing und MILP)"
	cd $(CODE) && $(PYTHON) sa.py
	@echo "==> Tabellen und Kennzahlen erzeugen"
	cd $(CODE) && $(PYTHON) tabellen.py
	@echo "==> Abbildungen erzeugen"
	cd $(CODE) && $(PYTHON) abbildungen.py

# Das Skalierungsexperiment läuft einige Minuten und ist deshalb nicht
# Teil von »make daten«. Ohne es fehlen Tabelle und Abbildung zur
# Skalierung; das Dokument baut trotzdem.
.PHONY: skalierung
skalierung:
	@echo "==> Skalierungsexperiment (dauert einige Minuten)"
	cd $(CODE) && $(PYTHON) skalierung.py
	cd $(CODE) && $(PYTHON) tabellen.py && $(PYTHON) abbildungen.py

# ------------------------------------------------------------- Dokument
# Fünf Schritte: erster Lauf erzeugt .aux/.bcf/.idx, biber die
# Literatur, makeindex den Index, die beiden letzten Läufe lösen die
# Verweise und füllen die Verzeichnisse (acro braucht dafür zwei Läufe).
pdf:
	$(ENGINE) $(JOB).tex
	biber $(JOB)
	makeindex $(JOB)
	$(ENGINE) $(JOB).tex
	$(ENGINE) $(JOB).tex
	@echo "==> $(JOB).pdf fertig"

schnell:
	$(ENGINE) $(JOB).tex

clean:
	rm -f *.aux *.log *.toc *.lof *.lot *.out *.idx *.ind *.ilg
	rm -f *.bbl *.bcf *.blg *.run.xml *.synctex.gz *.acr *.acn
	rm -f Abbildungen/*.log Abbildungen/*.mpx Abbildungen/*.mps

purge: clean
	rm -f $(JOB).pdf
	rm -f Abbildungen/*.pdf Abbildungen/nxtfarben.mp
	rm -rf Tabellen Ergebnisse
	rm -f $(CODE)/erpolino.dat
