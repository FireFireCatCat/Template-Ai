"""Probleminstanz der Erpolino Metallverarbeitung GmbH.

Diese Datei ist die einzige Quelle der Instanzdaten. Sowohl das
Python-Verfahren (sa.py) als auch das MathProg-Modell (erpolino.mod)
arbeiten mit denselben Zahlen: die GLPK-Datendatei erpolino.dat wird von
hier aus erzeugt (python3 daten.py).

Modell: Zuordnung von Arbeitsgängen zu Mitarbeitern auf unabhängigen
parallelen Maschinen mit Qualifikationsschranken; minimiert wird die
Gesamtdauer (Makespan). In der Scheduling-Notation R|M_j|C_max.

Bearbeitungszeit: p_ij = Grundzeit_j / Effizienz_i(Qualifikation_j).
Fehlt einem Mitarbeiter die Qualifikation, ist die Zuordnung unzulässig.
"""

from __future__ import annotations

import json
from pathlib import Path

QUALIFIKATIONEN = [
    "Drehen",
    "Fraesen",
    "Schweissen",
    "Schleifen",
    "CNC-Programmierung",
    "Qualitaetspruefung",
]

#: Bezeichner ohne Umlaute sind nötig, weil sie als Mengenelemente in die
#: GLPK-Datendatei gehen. Für Abbildungen und Tabellen wird über diese
#: Tabelle die lesbare Schreibweise nachgeschlagen.
ANZEIGE = {
    "Drehen": "Drehen",
    "Fraesen": "Fräsen",
    "Schweissen": "Schweißen",
    "Schleifen": "Schleifen",
    "CNC-Programmierung": "CNC-Programmierung",
    "Qualitaetspruefung": "Qualitätsprüfung",
}


def anzeige(bezeichner: str) -> str:
    """Lesbare Schreibweise eines Qualifikationsbezeichners."""
    return ANZEIGE.get(bezeichner, bezeichner)

# Mitarbeiter: Name -> {Qualifikation: Effizienz}.
# Effizienz 1,00 = Normalleistung; fehlt der Eintrag, fehlt die Qualifikation.
# Die Werte stammen aus der (fiktiven) Qualifikationsmatrix der Fertigung.
MITARBEITER: dict[str, dict[str, float]] = {
    "Bauer":      {"Drehen": 1.25, "Fraesen": 1.05, "Schleifen": 0.95},
    "Cakir":      {"Fraesen": 1.30, "CNC-Programmierung": 1.10, "Drehen": 0.90},
    "Dobrev":     {"Schweissen": 1.35, "Schleifen": 1.00},
    "Engelhardt": {"CNC-Programmierung": 1.40, "Fraesen": 1.00},
    "Fischer":    {"Drehen": 1.10, "Schweissen": 0.95, "Qualitaetspruefung": 1.15},
    "Gruber":     {"Schleifen": 1.30, "Qualitaetspruefung": 1.05, "Drehen": 0.85},
    "Haas":       {"Qualitaetspruefung": 1.35, "Schleifen": 0.90},
    "Ivanov":     {"Schweissen": 1.15, "Fraesen": 0.95, "Drehen": 1.00},
}

# Arbeitsgänge: (Bezeichnung, Qualifikation, Grundzeit in Minuten).
# Ein Fertigungslos der Kalenderwoche, wie es die Arbeitsvorbereitung
# freigibt.
ARBEITSGAENGE: list[tuple[str, str, int]] = [
    ("Flanschwelle A-102 drehen",        "Drehen",             95),
    ("Lagerbock B-204 fraesen",          "Fraesen",           120),
    ("Rahmen C-310 schweissen",          "Schweissen",        140),
    ("Passfläche D-011 schleifen",       "Schleifen",          60),
    ("Programm E-556 erstellen",         "CNC-Programmierung", 110),
    ("Charge F-078 pruefen",             "Qualitaetspruefung",  45),
    ("Antriebswelle A-115 drehen",       "Drehen",            130),
    ("Getriebedeckel B-221 fraesen",     "Fraesen",            85),
    ("Traverse C-333 schweissen",        "Schweissen",        105),
    ("Dichtsitz D-042 schleifen",        "Schleifen",          75),
    ("Programm E-560 erstellen",         "CNC-Programmierung",  90),
    ("Charge F-081 pruefen",             "Qualitaetspruefung",  55),
    ("Spindel A-127 drehen",             "Drehen",             70),
    ("Konsole B-238 fraesen",            "Fraesen",           150),
    ("Behaelter C-350 schweissen",       "Schweissen",         95),
    ("Laufflaeche D-063 schleifen",      "Schleifen",         110),
    ("Programm E-571 erstellen",         "CNC-Programmierung",  65),
    ("Charge F-090 pruefen",             "Qualitaetspruefung",  80),
    ("Buchse A-134 drehen",              "Drehen",             50),
    ("Adapterplatte B-245 fraesen",      "Fraesen",            70),
    ("Konsolarm C-361 schweissen",       "Schweissen",        125),
    ("Fuehrung D-077 schleifen",         "Schleifen",          90),
    ("Programm E-583 erstellen",         "CNC-Programmierung", 100),
    ("Charge F-095 pruefen",             "Qualitaetspruefung",  60),
]

NAMEN = list(MITARBEITER)
GRUNDZEIT = {i: g for i, (_, _, g) in enumerate(ARBEITSGAENGE)}
BEDARF = {i: q for i, (_, q, _) in enumerate(ARBEITSGAENGE)}
BEZEICHNUNG = {i: b for i, (b, _, _) in enumerate(ARBEITSGAENGE)}


def zulaessig(mitarbeiter: str, aufgabe: int) -> bool:
    """Hat der Mitarbeiter die für die Aufgabe nötige Qualifikation?"""
    return BEDARF[aufgabe] in MITARBEITER[mitarbeiter]


def dauer(mitarbeiter: str, aufgabe: int) -> float:
    """Bearbeitungszeit p_ij in Minuten; nur für zulässige Paare definiert."""
    if not zulaessig(mitarbeiter, aufgabe):
        raise ValueError(f"{mitarbeiter} kann {BEZEICHNUNG[aufgabe]!r} nicht bearbeiten.")
    return GRUNDZEIT[aufgabe] / MITARBEITER[mitarbeiter][BEDARF[aufgabe]]


def kennzahlen() -> dict[str, float | int]:
    """Kenngrößen der Instanz, u.a. die triviale untere Schranke."""
    gesamt_min = sum(
        min(dauer(m, j) for m in NAMEN if zulaessig(m, j)) for j in GRUNDZEIT
    )
    return {
        "mitarbeiter": len(NAMEN),
        "aufgaben": len(ARBEITSGAENGE),
        "qualifikationen": len(QUALIFIKATIONEN),
        "zulaessige_paare": sum(
            1 for m in NAMEN for j in GRUNDZEIT if zulaessig(m, j)
        ),
        # Untere Schranke: selbst bei perfekter Verteilung muss die Summe
        # der jeweils schnellstmöglichen Zeiten auf alle Mitarbeiter
        # verteilt werden.
        "untere_schranke": gesamt_min / len(NAMEN),
        "laengste_einzelaufgabe": max(
            min(dauer(m, j) for m in NAMEN if zulaessig(m, j)) for j in GRUNDZEIT
        ),
    }


def dat_schreiben(ziel: Path) -> None:
    """Erzeugt die GLPK-Datendatei für erpolino.mod."""
    z = []
    z.append("/* Automatisch erzeugt von daten.py -- nicht von Hand ändern. */")
    z.append("/* Instanz der Erpolino Metallverarbeitung GmbH. */")
    z.append("")
    z.append("data;")
    z.append("")
    z.append("set MITARBEITER := " + " ".join(NAMEN) + ";")
    z.append("")
    z.append("set AUFGABEN := " + " ".join(f"A{j:02d}" for j in GRUNDZEIT) + ";")
    z.append("")
    z.append("/* Zulässige Paare (Qualifikation vorhanden) mit Bearbeitungszeit p[i,j] */")
    z.append("param: ZULAESSIG: p :=")
    for m in NAMEN:
        for j in GRUNDZEIT:
            if zulaessig(m, j):
                z.append(f"  {m:<11s} A{j:02d}  {dauer(m, j):8.4f}")
    z.append(";")
    z.append("")
    z.append("end;")
    ziel.write_text("\n".join(z) + "\n", encoding="utf-8")


def json_schreiben(ziel: Path) -> None:
    """Instanz als JSON, damit die Abbildungen sie ohne Import lesen können."""
    ziel.write_text(
        json.dumps(
            {
                "mitarbeiter": MITARBEITER,
                "arbeitsgaenge": [
                    {"nr": j, "bezeichnung": BEZEICHNUNG[j],
                     "qualifikation": BEDARF[j], "grundzeit": GRUNDZEIT[j]}
                    for j in GRUNDZEIT
                ],
                "kennzahlen": kennzahlen(),
            },
            indent=2,
            ensure_ascii=False,
        ),
        encoding="utf-8",
    )


if __name__ == "__main__":
    hier = Path(__file__).resolve().parent
    dat_schreiben(hier / "erpolino.dat")
    json_schreiben(hier.parent / "Ergebnisse" / "instanz.json")
    k = kennzahlen()
    print("Instanz Erpolino")
    for name, wert in k.items():
        print(f"  {name:22s} {wert:>10.2f}" if isinstance(wert, float)
              else f"  {name:22s} {wert:>10d}")
