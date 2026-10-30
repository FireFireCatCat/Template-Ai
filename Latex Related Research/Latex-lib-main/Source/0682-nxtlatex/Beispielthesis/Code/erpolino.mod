/* -----------------------------------------------------------------------
   Zuordnung von Arbeitsgängen zu Mitarbeitern bei minimaler Gesamtdauer.

   Erpolino Metallverarbeitung GmbH, Reutlingen.

   Scheduling-Notation: R|M_j|C_max -- unabhängige parallele Maschinen
   (jeder Mitarbeiter braucht für dieselbe Aufgabe unterschiedlich lange),
   Qualifikationsschranken (M_j), Zielgröße Gesamtdauer (C_max).

   Aufruf:  glpsol --math erpolino.mod --data erpolino.dat

   Die Datendatei erpolino.dat wird von daten.py erzeugt.
   ----------------------------------------------------------------------- */

set MITARBEITER;
set AUFGABEN;

/* Nur Paare, für die die Qualifikation vorliegt. Unzulässige Paare
   existieren gar nicht erst -- das ist schärfer und kleiner als sie mit
   einer großen Zahl zu bestrafen. */
set ZULAESSIG within {MITARBEITER, AUFGABEN};

/* Bearbeitungszeit in Minuten. */
param p{(i,j) in ZULAESSIG} > 0;

/* x[i,j] = 1, wenn Mitarbeiter i den Arbeitsgang j übernimmt. */
var x{(i,j) in ZULAESSIG}, binary;

/* Gesamtdauer: die Zeit, zu der auch der letzte Mitarbeiter fertig ist. */
var Cmax >= 0;

minimize Gesamtdauer: Cmax;

/* Jeder Arbeitsgang wird genau einmal vergeben. */
s.t. Vergabe{j in AUFGABEN}:
  sum{(i,j) in ZULAESSIG} x[i,j] = 1;

/* Cmax ist mindestens so groß wie die Auslastung jedes Mitarbeiters.
   Zusammen mit der Minimierung erzwingt das Cmax = max_i (Auslastung). */
s.t. Auslastung{i in MITARBEITER}:
  sum{(i,j) in ZULAESSIG} p[i,j] * x[i,j] <= Cmax;

solve;

/* ---- Ausgabe: maschinenlesbar für die Weiterverarbeitung ------------- */

printf "# Gesamtdauer (Cmax) in Minuten\n";
printf "CMAX %.4f\n", Cmax;

printf "# Zuordnung: Mitarbeiter Aufgabe Dauer\n";
for {(i,j) in ZULAESSIG: x[i,j] > 0.5}
  printf "ZUORDNUNG %s %s %.4f\n", i, j, p[i,j];

printf "# Auslastung je Mitarbeiter in Minuten\n";
for {i in MITARBEITER}
  printf "AUSLASTUNG %s %.4f\n", i, sum{(i,j) in ZULAESSIG} p[i,j] * x[i,j];

end;
