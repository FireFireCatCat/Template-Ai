"""Erzeugt die datengetriebenen Tabellen der Thesis als .tex-Bausteine.

Die Tabellen werden nicht von Hand gepflegt, sondern aus denselben
Ergebnissen erzeugt wie die Abbildungen. Ändert sich die Instanz, ändern
sich Text, Abbildungen und Tabellen gemeinsam.

Aufruf:  python3 tabellen.py
Schreibt Tabellen/*.tex, die im Dokument per \\input eingebunden werden.
"""

from __future__ import annotations

import json
from pathlib import Path

from daten import (ARBEITSGAENGE, BEDARF, BEZEICHNUNG, GRUNDZEIT, MITARBEITER,
                   NAMEN, QUALIFIKATIONEN, anzeige, dauer, zulaessig)

HIER = Path(__file__).resolve().parent
ERGEBNISSE = HIER.parent / "Ergebnisse"
TABELLEN = HIER.parent / "Tabellen"


def tex(s: str) -> str:
    """Maskiert die Zeichen, die LaTeX sonst als Befehl liest."""
    for a, b in [("&", r"\&"), ("%", r"\%"), ("_", r"\_"), ("#", r"\#")]:
        s = s.replace(a, b)
    return s


def kopf(datei: str) -> str:
    return (f"% Automatisch erzeugt von Code/tabellen.py -- nicht von Hand ändern.\n"
            f"% Quelle: Code/daten.py und Ergebnisse/*.json\n")


# ------------------------------------------------- lange Tabelle: Arbeitsgänge

def arbeitsgaenge_lang() -> None:
    """Alle Arbeitsgänge mit Zuordnung -- läuft über mehrere Seiten."""
    sa = json.loads((ERGEBNISSE / "sa.json").read_text(encoding="utf-8"))
    z = sa["loesungen"]["SimulatedAnnealing"]["zuordnung"]

    z_ = [kopf("arbeitsgaenge"), r"\begin{longtable}{@{}llS[table-format=3.0]lS[table-format=3.1]@{}}"]
    z_.append(r"\caption{Arbeitsgänge des Fertigungsloses mit der vom Verfahren"
              r" gefundenen Zuordnung}\label{tab:arbeitsgaenge}\\")
    z_.append(r"\toprule")
    kopfzeile = (r"{Nr.} & {Bezeichnung} & {\text{Grundzeit}} & {Qualifikation}"
                 r" & {\text{Dauer}} \\")
    einheiten = r" & & {min} & & {min} \\"
    z_.append(kopfzeile)
    z_.append(einheiten)
    z_.append(r"\midrule")
    z_.append(r"\endfirsthead")
    z_.append(r"\caption[]{Arbeitsgänge (Fortsetzung)}\\")
    z_.append(r"\toprule")
    z_.append(kopfzeile)
    z_.append(einheiten)
    z_.append(r"\midrule")
    z_.append(r"\endhead")
    z_.append(r"\midrule")
    z_.append(r"\multicolumn{5}{r@{}}{\footnotesize Fortsetzung nächste Seite}\\")
    z_.append(r"\endfoot")
    z_.append(r"\bottomrule")
    z_.append(r"\endlastfoot")

    for j, (bez, qual, grund) in enumerate(ARBEITSGAENGE):
        e = z[str(j)]
        z_.append(f"  A{j:02d} & {tex(bez)} & {grund} & {tex(anzeige(qual))} "
                  f"& {e['dauer']:.1f} \\\\")
    z_.append(r"\end{longtable}")
    (TABELLEN / "arbeitsgaenge.tex").write_text("\n".join(z_) + "\n", encoding="utf-8")


# --------------------------------------- breite Tabelle: Qualifikationsmatrix

def qualifikationsmatrix() -> None:
    """Effizienz je Mitarbeiter und Qualifikation -- breit, fürs Querformat."""
    z_ = [kopf("qualifikationsmatrix")]
    spalten = "l" + "S[table-format=1.2]" * len(QUALIFIKATIONEN) + "S[table-format=1.0]"
    z_.append(r"\begin{tabular}{@{}" + spalten + r"@{}}")
    z_.append(r"\toprule")
    z_.append("Mitarbeiter & "
              + " & ".join(r"{\rotatebox{45}{" + tex(anzeige(q)) + "}}"
                           for q in QUALIFIKATIONEN)
              + r" & {\rotatebox{45}{Qualifikationen}} \\")
    z_.append(r"\midrule")
    for m in NAMEN:
        werte = []
        for q in QUALIFIKATIONEN:
            e = MITARBEITER[m].get(q)
            # Fehlende Qualifikation bleibt leer, nicht 0 -- eine Null wäre
            # eine Effizienz von null und damit eine andere Aussage.
            werte.append(f"{e:.2f}" if e else r"{--}")
        z_.append(f"  {m} & " + " & ".join(werte)
                  + f" & {len(MITARBEITER[m])} \\\\")
    z_.append(r"\midrule")
    z_.append("Mitarbeiter je Qualifikation & "
              + " & ".join(str(sum(1 for m in NAMEN if q in MITARBEITER[m]))
                           for q in QUALIFIKATIONEN)
              + r" & \\")
    z_.append(r"\bottomrule")
    z_.append(r"\end{tabular}")
    (TABELLEN / "qualifikationsmatrix.tex").write_text("\n".join(z_) + "\n",
                                                       encoding="utf-8")


# ------------------------------------------------ komplexe Tabelle: Verfahren

def verfahrensvergleich() -> None:
    """Verfahren gegenübergestellt, mit gruppierten Spalten."""
    sa = json.loads((ERGEBNISSE / "sa.json").read_text(encoding="utf-8"))
    opt = sa["verfahren"]["MILP"]["makespan"]
    ev = sa["energievergleich"]

    z_ = [kopf("verfahren")]
    z_.append(r"\begin{tabular}{@{}lS[table-format=3.2]S[table-format=1.2]"
              r"S[table-format=3.1]l@{}}")
    z_.append(r"\toprule")
    z_.append(r"& {Makespan} & {Abstand} & {Rechenzeit} & \\")
    z_.append(r"Verfahren & {min} & {\%} & {ms} & Gütegarantie \\")
    z_.append(r"\midrule")
    reihen = [
        ("Untere Schranke (trivial)", sa["instanz"]["untere_schranke"], None,
         "Schranke, keine Lösung"),
        ("Greedy", sa["verfahren"]["Greedy"]["makespan"],
         sa["verfahren"]["Greedy"]["sekunden"] * 1000, "keine"),
        ("LPT", sa["verfahren"]["LPT"]["makespan"],
         sa["verfahren"]["LPT"]["sekunden"] * 1000, "keine"),
        ("Simulated Annealing", sa["verfahren"]["SimulatedAnnealing"]["makespan"],
         sa["verfahren"]["SimulatedAnnealing"]["sekunden"] * 1000, "keine"),
        ("MILP (GLPK)", opt, sa["verfahren"]["MILP"]["sekunden"] * 1000,
         "beweisbar optimal"),
    ]
    for name, wert, ms, garantie in reihen:
        abstand = f"{(wert / opt - 1) * 100:.2f}" if opt and wert else "{--}"
        zeit = f"{ms:.1f}" if ms is not None else "{--}"
        z_.append(f"  {name} & {wert:.2f} & {abstand} & {zeit} & {garantie} \\\\")
    z_.append(r"\midrule")
    z_.append(r"\multicolumn{5}{@{}l@{}}{\footnotesize Simulated Annealing über"
              r" 20 Läufe, je 60\,000 Iterationen:}\\")
    for bez, titel in (("roh", "Energie nur Makespan"),
                       ("geglaettet", "Energie mit Glättung")):
        w = ev[bez]
        z_.append(f"  \\quad {titel} & {w['mittel']:.2f} & "
                  f"{(w['mittel'] / opt - 1) * 100:.2f} & {{--}} & "
                  f"bestes {w['bestes']:.2f}, schlecht. {w['schlechtestes']:.2f} \\\\")
    z_.append(r"\bottomrule")
    z_.append(r"\end{tabular}")
    (TABELLEN / "verfahren.tex").write_text("\n".join(z_) + "\n", encoding="utf-8")


# ------------------------------------------------------ Tabelle: Skalierung

def skalierung() -> None:
    p = ERGEBNISSE / "skalierung.json"
    if not p.is_file():
        return
    sk = json.loads(p.read_text(encoding="utf-8"))
    z_ = [kopf("skalierung")]
    z_.append(r"\begin{tabular}{@{}S[table-format=3.0]S[table-format=2.0]"
              r"S[table-format=3.2]S[table-format=2.1]l"
              r"S[table-format=3.2]S[table-format=1.1]S[table-format=+1.2]@{}}")
    z_.append(r"\toprule")
    z_.append(r"& & \multicolumn{3}{c}{MILP (GLPK)} & "
              r"\multicolumn{2}{c}{Simulated Annealing} & \\")
    z_.append(r"\cmidrule(lr){3-5}\cmidrule(lr){6-7}")
    z_.append(r"{Aufg.} & {Mitarb.} & {Makespan} & {Zeit} & {Status} & "
              r"{Makespan} & {Zeit} & {Abstand} \\")
    z_.append(r"& & {min} & {s} & & {min} & {s} & {\%} \\")
    z_.append(r"\midrule")
    for w in sk["messungen"]:
        z_.append(f"  {w['aufgaben']} & {w['mitarbeiter']} & {w['milp']:.2f} & "
                  f"{w['milp_sekunden']:.1f} & {w['milp_status']} & "
                  f"{w['sa']:.2f} & {w['sa_sekunden']:.1f} & "
                  f"{w['abstand_prozent']:+.2f} \\\\")
    z_.append(r"\bottomrule")
    z_.append(r"\end{tabular}")
    (TABELLEN / "skalierung.tex").write_text("\n".join(z_) + "\n", encoding="utf-8")


# --------------------------------- Kennzahlen als Makros für den Fließtext

def kennzahlen_makros() -> None:
    """Zahlen, die im Text vorkommen, als Makros -- damit im Fließtext keine
    Zahl steht, die von der Rechnung abweichen kann."""
    sa = json.loads((ERGEBNISSE / "sa.json").read_text(encoding="utf-8"))
    k = sa["instanz"]
    opt = sa["verfahren"]["MILP"]["makespan"]
    ev = sa["energievergleich"]

    def num(x: float, n: int = 2) -> str:
        return f"{x:.{n}f}".replace(".", ",")

    z_ = [kopf("kennzahlen")]
    m = {
        "ZahlMitarbeiter": str(k["mitarbeiter"]),
        "ZahlAufgaben": str(k["aufgaben"]),
        "ZahlQualifikationen": str(k["qualifikationen"]),
        "ZahlPaare": str(k["zulaessige_paare"]),
        "UntereSchranke": num(k["untere_schranke"]),
        "Optimum": num(opt),
        "MakespanGreedy": num(sa["verfahren"]["Greedy"]["makespan"]),
        "MakespanLPT": num(sa["verfahren"]["LPT"]["makespan"]),
        "MakespanSA": num(sa["verfahren"]["SimulatedAnnealing"]["makespan"]),
        "MilpSekunden": num(sa["verfahren"]["MILP"]["sekunden"], 1),
        "SaMillisekunden": num(sa["verfahren"]["SimulatedAnnealing"]["sekunden"] * 1000, 0),
        "SaBestes": num(ev["geglaettet"]["bestes"]),
        "SaMittel": num(ev["geglaettet"]["mittel"]),
        "SaRohMittel": num(ev["roh"]["mittel"]),
        "AbstandLPT": num((sa["verfahren"]["LPT"]["makespan"] / opt - 1) * 100),
        "AbstandSA": num((sa["verfahren"]["SimulatedAnnealing"]["makespan"] / opt - 1) * 100),
        "LueckeSchranke": num((opt / k["untere_schranke"] - 1) * 100),
    }
    for name, wert in m.items():
        z_.append(f"\\newcommand*{{\\{name}}}{{{wert}}}")
    (TABELLEN / "kennzahlen.tex").write_text("\n".join(z_) + "\n", encoding="utf-8")


def main() -> None:
    TABELLEN.mkdir(parents=True, exist_ok=True)
    arbeitsgaenge_lang()
    qualifikationsmatrix()
    verfahrensvergleich()
    skalierung()
    kennzahlen_makros()
    for p in sorted(TABELLEN.glob("*.tex")):
        print(f"  {p.relative_to(HIER.parent)}")


if __name__ == "__main__":
    main()
