"""Simulated Annealing für die Zuordnung von Arbeitsgängen zu Mitarbeitern.

Zielgröße ist die Gesamtdauer (Makespan): die Auslastung des am
längsten beschäftigten Mitarbeiters. Verglichen wird gegen zwei
Konstruktionsheuristiken (Greedy, LPT) und -- über erpolino.mod -- gegen
die exakte MILP-Lösung.

Aufruf:  python3 sa.py
Schreibt Ergebnisse/*.json für Abbildungen und Tabellen.

Alle Läufe sind über feste Startwerte reproduzierbar.
"""

from __future__ import annotations

import json
import math
import random
import subprocess
import time
from pathlib import Path

from daten import BEDARF, BEZEICHNUNG, GRUNDZEIT, NAMEN, dauer, kennzahlen, zulaessig

HIER = Path(__file__).resolve().parent
ERGEBNISSE = HIER.parent / "Ergebnisse"


def milp_optimum() -> tuple[float | None, float]:
    """Löst dieselbe Instanz exakt mit GLPK; gibt (Cmax, Sekunden).

    Wird zur Laufzeit aufgerufen statt fest eingetragen, damit der
    Vergleichswert nicht veraltet, wenn sich die Instanz ändert.
    """
    t0 = time.perf_counter()
    try:
        r = subprocess.run(
            ["glpsol", "--math", str(HIER / "erpolino.mod"),
             "--data", str(HIER / "erpolino.dat")],
            capture_output=True, text=True, timeout=300,
        )
    except (FileNotFoundError, subprocess.TimeoutExpired):
        return None, time.perf_counter() - t0
    dt = time.perf_counter() - t0
    if "INTEGER OPTIMAL" not in r.stdout:
        return None, dt
    return next((float(l.split()[1]) for l in r.stdout.splitlines()
                 if l.startswith("CMAX")), None), dt

#: Für jede Aufgabe die Mitarbeiter, die sie überhaupt übernehmen dürfen.
KANDIDATEN: dict[int, list[str]] = {
    j: [m for m in NAMEN if zulaessig(m, j)] for j in GRUNDZEIT
}

#: Bearbeitungszeiten vorab berechnen -- die innere Schleife läuft oft.
P: dict[tuple[str, int], float] = {
    (m, j): dauer(m, j) for j in GRUNDZEIT for m in KANDIDATEN[j]
}

Zuordnung = dict[int, str]  # Aufgabe -> Mitarbeiter


def auslastung(z: Zuordnung) -> dict[str, float]:
    """Summe der Bearbeitungszeiten je Mitarbeiter."""
    a = {m: 0.0 for m in NAMEN}
    for j, m in z.items():
        a[m] += P[(m, j)]
    return a


def makespan(z: Zuordnung) -> float:
    """Gesamtdauer = Auslastung des am längsten beschäftigten Mitarbeiters."""
    return max(auslastung(z).values())


def energie_roh(z: Zuordnung) -> float:
    """Die Zielgröße selbst als Energie des Verfahrens."""
    return makespan(z)


#: Gewicht des Glättungsterms. Klein genug, um die Rangfolge zweier
#: Lösungen mit verschiedenem Makespan nie umzudrehen (die Zeiten liegen
#: bei ~200 min, der Term bei ~1,2).
GLAETTUNG = 0.002


def energie_geglaettet(z: Zuordnung) -> float:
    """Makespan plus ein kleiner Term über alle Auslastungen.

    Der Makespan allein ist als Energie schlecht geeignet: Er ändert sich
    nur, wenn gerade der Engpass-Mitarbeiter betroffen ist. Alle übrigen
    Züge sind energieneutral, das Verfahren läuft über weite Plateaus und
    bekommt kein Signal, in welche Richtung es sich lohnt.

    Der zusätzliche Term (euklidische Norm des Auslastungsvektors) sinkt
    schon dann, wenn Last gleichmäßiger verteilt wird -- auch ohne dass
    der Makespan fällt. Das macht die Landschaft begehbar. Sein Gewicht
    ist so klein, dass er den Makespan als Kriterium nie überstimmt.
    """
    a = list(auslastung(z).values())
    return max(a) + GLAETTUNG * math.sqrt(sum(v * v for v in a))


# ---------------------------------------------------------------- Heuristiken

def greedy() -> Zuordnung:
    """Aufgaben in Eingangsreihenfolge; je Aufgabe der dann früheste Fertige."""
    z: Zuordnung = {}
    last = {m: 0.0 for m in NAMEN}
    for j in GRUNDZEIT:
        m = min(KANDIDATEN[j], key=lambda m: last[m] + P[(m, j)])
        z[j] = m
        last[m] += P[(m, j)]
    return z


def lpt() -> Zuordnung:
    """Longest Processing Time first: lange Aufgaben zuerst vergeben.

    Klassische Regel; auf identischen Maschinen 4/3-approximativ. Hier
    sind die Maschinen nicht identisch, die Schranke gilt also nicht --
    die Regel bleibt trotzdem ein brauchbarer Startpunkt.
    """
    z: Zuordnung = {}
    last = {m: 0.0 for m in NAMEN}
    # Sortierung nach der schnellstmöglichen Dauer, absteigend.
    reihenfolge = sorted(
        GRUNDZEIT, key=lambda j: min(P[(m, j)] for m in KANDIDATEN[j]), reverse=True
    )
    for j in reihenfolge:
        m = min(KANDIDATEN[j], key=lambda m: last[m] + P[(m, j)])
        z[j] = m
        last[m] += P[(m, j)]
    return z


# ---------------------------------------------------- Simulated Annealing

# nachbar-anfang  (Marker für \lstinputlisting im Anhang der Thesis)
def nachbar(z: Zuordnung, rng: random.Random) -> Zuordnung:
    """Nachbarlösung: Aufgabe verschieben oder zwei Aufgaben tauschen.

    Das Verschieben allein genügt nicht: sind zwei Mitarbeiter beide voll,
    hilft nur ein Tausch, der die Last umverteilt, ohne sie zu erhöhen.
    """
    neu = dict(z)
    if rng.random() < 0.7:
        # Verschieben: eine Aufgabe eines ausgelasteten Mitarbeiters
        # an einen anderen qualifizierten Mitarbeiter geben.
        a = auslastung(z)
        engpass = max(a, key=lambda m: a[m])
        aufgaben = [j for j, m in z.items() if m == engpass]
        j = rng.choice(aufgaben)
        andere = [m for m in KANDIDATEN[j] if m != engpass]
        if andere:
            neu[j] = rng.choice(andere)
    else:
        # Tauschen: zwei Aufgaben zwischen ihren Mitarbeitern kreuzen,
        # sofern beide dafür qualifiziert sind.
        for _ in range(10):
            j1, j2 = rng.sample(list(GRUNDZEIT), 2)
            m1, m2 = z[j1], z[j2]
            if m1 != m2 and m2 in KANDIDATEN[j1] and m1 in KANDIDATEN[j2]:
                neu[j1], neu[j2] = m2, m1
                break
    return neu


def simulated_annealing(
    start: Zuordnung,
    *,
    t_start: float = 25.0,
    t_ende: float = 0.05,
    schritte: int = 60_000,
    seed: int = 20260717,
    energie=energie_geglaettet,
) -> tuple[Zuordnung, list[float], list[float]]:
    """Klassisches Metropolis-Verfahren mit geometrischer Abkühlung.

    Bewertet wird über `energie`; bewertet und zurückgegeben wird stets
    der echte Makespan der besten gefundenen Lösung.

    Gibt die beste gefundene Lösung, den Verlauf des aktuellen Makespans
    und den Verlauf des besten Makespans zurück.
    """
    rng = random.Random(seed)
    aktuell = dict(start)
    f_aktuell = energie(aktuell)
    bestes, f_bestes = dict(aktuell), makespan(aktuell)

    # Geometrische Abkühlung: T_k = t_start * alpha^k mit T_schritte = t_ende.
    alpha = (t_ende / t_start) ** (1.0 / schritte)
    t = t_start

    verlauf_aktuell: list[float] = []
    verlauf_bestes: list[float] = []

    for k in range(schritte):
        kandidat = nachbar(aktuell, rng)
        f_kandidat = energie(kandidat)
        delta = f_kandidat - f_aktuell
        # Verschlechterungen werden mit exp(-delta/T) angenommen; das ist
        # der einzige Grund, warum das Verfahren lokale Minima verlässt.
        if delta <= 0 or rng.random() < math.exp(-delta / t):
            aktuell, f_aktuell = kandidat, f_kandidat
            if makespan(aktuell) < f_bestes:
                bestes, f_bestes = dict(aktuell), makespan(aktuell)
        t *= alpha
        if k % 100 == 0:
            verlauf_aktuell.append(makespan(aktuell))
            verlauf_bestes.append(f_bestes)

    return bestes, verlauf_aktuell, verlauf_bestes
# nachbar-ende


# ------------------------------------------------------------------ Auswertung

def als_dict(z: Zuordnung) -> dict:
    a = auslastung(z)
    return {
        "makespan": makespan(z),
        "auslastung": a,
        "zuordnung": {
            str(j): {
                "mitarbeiter": m,
                "bezeichnung": BEZEICHNUNG[j],
                "qualifikation": BEDARF[j],
                "dauer": P[(m, j)],
            }
            for j, m in sorted(z.items())
        },
    }


def main() -> None:
    ERGEBNISSE.mkdir(parents=True, exist_ok=True)
    k = kennzahlen()
    MILP_OPTIMUM, t_milp = milp_optimum()

    t0 = time.perf_counter()
    z_greedy = greedy()
    t_greedy = time.perf_counter() - t0

    t0 = time.perf_counter()
    z_lpt = lpt()
    t_lpt = time.perf_counter() - t0

    t0 = time.perf_counter()
    z_sa, verlauf_akt, verlauf_best = simulated_annealing(z_lpt)
    t_sa = time.perf_counter() - t0

    # Streuung über mehrere Startwerte: ein einzelner Lauf sagt bei einem
    # stochastischen Verfahren wenig aus. Zugleich der Vergleich der
    # beiden Energien -- der Kern des Kapitels über die Umsetzung.
    streuung: dict[str, list[float]] = {}
    for bez, e in (("roh", energie_roh), ("geglaettet", energie_geglaettet)):
        streuung[bez] = [
            makespan(simulated_annealing(z_lpt, seed=1000 + s, energie=e)[0])
            for s in range(20)
        ]

    ergebnis = {
        "instanz": k,
        "verfahren": {
            "Greedy": {"makespan": makespan(z_greedy), "sekunden": t_greedy},
            "LPT": {"makespan": makespan(z_lpt), "sekunden": t_lpt},
            "SimulatedAnnealing": {"makespan": makespan(z_sa), "sekunden": t_sa},
            "MILP": {"makespan": MILP_OPTIMUM, "sekunden": t_milp,
                     "bemerkung": "beweisbar optimal (GLPK)"},
        },
        "energievergleich": {
            bez: {
                "laeufe": w,
                "bestes": min(w),
                "schlechtestes": max(w),
                "mittel": sum(w) / len(w),
            }
            for bez, w in streuung.items()
        },
        "sa_streuung": {
            "laeufe": streuung["geglaettet"],
            "bestes": min(streuung["geglaettet"]),
            "schlechtestes": max(streuung["geglaettet"]),
            "mittel": sum(streuung["geglaettet"]) / len(streuung["geglaettet"]),
        },
        "loesungen": {
            "Greedy": als_dict(z_greedy),
            "LPT": als_dict(z_lpt),
            "SimulatedAnnealing": als_dict(z_sa),
        },
        "verlauf": {"aktuell": verlauf_akt, "bestes": verlauf_best},
    }
    (ERGEBNISSE / "sa.json").write_text(
        json.dumps(ergebnis, indent=2, ensure_ascii=False), encoding="utf-8"
    )

    print(f"untere Schranke      {k['untere_schranke']:8.2f} min")
    for name, w in ergebnis["verfahren"].items():
        print(f"{name:20s} {w['makespan']:8.2f} min  ({w['sekunden']*1000:7.1f} ms)")
    s = ergebnis["sa_streuung"]
    print(f"SA über 20 Läufe: {s['bestes']:.2f} / {s['mittel']:.2f} / {s['schlechtestes']:.2f}"
          "  (bestes / Mittel / schlechtestes)")


if __name__ == "__main__":
    main()
