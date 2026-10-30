"""Skalierungsexperiment: ab wann lohnt sich die Heuristik?

Auf der Instanz von Erpolino (24 Arbeitsgänge) löst GLPK das MILP in
unter einer Sekunde beweisbar optimal -- die Heuristik hat dort keinen
Vorteil. Dieses Experiment prüft, ab welcher Größe sich das umkehrt.

Erzeugt werden Zufallsinstanzen derselben Struktur wachsender Größe. Für
jede wird das MILP mit Zeitschranke gelöst und Simulated Annealing
angewendet. Verglichen werden Zielwert und Rechenzeit.

Aufruf:  python3 skalierung.py   (dauert einige Minuten)
"""

from __future__ import annotations

import json
import math
import random
import subprocess
import tempfile
import time
from pathlib import Path

HIER = Path(__file__).resolve().parent
ERGEBNISSE = HIER.parent / "Ergebnisse"

QUALIFIKATIONEN = ["Drehen", "Fraesen", "Schweissen", "Schleifen", "CNC", "QS"]

#: Zeitschranke je MILP-Lauf in Sekunden.
ZEITSCHRANKE = 30

#: Instanzgrößen (Arbeitsgänge, Mitarbeiter).
GROESSEN = [(24, 8), (40, 10), (60, 12), (80, 14), (120, 18)]


def instanz(n_auf: int, n_mit: int, seed: int):
    """Zufallsinstanz mit derselben Struktur wie die Erpolino-Instanz."""
    rng = random.Random(seed)
    mitarbeiter = {
        f"M{i:02d}": {
            q: round(rng.uniform(0.85, 1.40), 2)
            for q in rng.sample(QUALIFIKATIONEN, rng.randint(2, 3))
        }
        for i in range(n_mit)
    }
    aufgaben = [
        (f"A{j:03d}", rng.choice(QUALIFIKATIONEN), rng.randint(45, 150))
        for j in range(n_auf)
    ]
    # Sicherstellen, dass jede Aufgabe mindestens einen Kandidaten hat --
    # sonst ist die Instanz unzulässig statt schwer.
    for _, q, _ in aufgaben:
        if not any(q in s for s in mitarbeiter.values()):
            mitarbeiter[rng.choice(list(mitarbeiter))][q] = 1.0
    return mitarbeiter, aufgaben


def dat_schreiben(mitarbeiter, aufgaben, ziel: Path) -> None:
    z = ["data;", "set MITARBEITER := " + " ".join(mitarbeiter) + ";",
         "set AUFGABEN := " + " ".join(n for n, _, _ in aufgaben) + ";",
         "param: ZULAESSIG: p :="]
    for m, sk in mitarbeiter.items():
        for n, q, g in aufgaben:
            if q in sk:
                z.append(f"  {m} {n} {g / sk[q]:.4f}")
    z += [";", "end;"]
    ziel.write_text("\n".join(z) + "\n", encoding="utf-8")


def milp(mitarbeiter, aufgaben) -> tuple[float | None, float, str]:
    """Löst das MILP mit Zeitschranke. Gibt (Zielwert, Sekunden, Status)."""
    with tempfile.NamedTemporaryFile(suffix=".dat", delete=False, mode="w") as f:
        pfad = Path(f.name)
    dat_schreiben(mitarbeiter, aufgaben, pfad)
    t0 = time.perf_counter()
    r = subprocess.run(
        ["glpsol", "--math", str(HIER / "erpolino.mod"), "--data", str(pfad),
         "--tmlim", str(ZEITSCHRANKE)],
        capture_output=True, text=True,
    )
    dt = time.perf_counter() - t0
    pfad.unlink(missing_ok=True)
    cmax = next((float(l.split()[1]) for l in r.stdout.splitlines()
                 if l.startswith("CMAX")), None)
    if "INTEGER OPTIMAL" in r.stdout:
        status = "optimal"
    elif "TIME LIMIT" in r.stdout or "TIME_LIMIT" in r.stdout:
        status = "Zeitschranke"
    else:
        status = "keine Loesung"
    return cmax, dt, status


def sa(mitarbeiter, aufgaben, seed=7, schritte=60_000):
    """Simulated Annealing mit geglätteter Energie (vgl. sa.py)."""
    namen = list(mitarbeiter)
    kand = {n: [m for m in namen if q in mitarbeiter[m]] for n, q, _ in aufgaben}
    P = {(m, n): g / mitarbeiter[m][q]
         for n, q, g in aufgaben for m in kand[n]}
    rng = random.Random(seed)

    def load(z):
        a = {m: 0.0 for m in namen}
        for n, m in z.items():
            a[m] += P[(m, n)]
        return a

    def mk(z):
        return max(load(z).values())

    def energie(z):
        a = list(load(z).values())
        return max(a) + 0.002 * math.sqrt(sum(v * v for v in a))

    # Start: LPT
    z, last = {}, {m: 0.0 for m in namen}
    for n, q, g in sorted(aufgaben, key=lambda t: min(P[(m, t[0])] for m in kand[t[0]]),
                          reverse=True):
        m = min(kand[n], key=lambda m: last[m] + P[(m, n)])
        z[n] = m
        last[m] += P[(m, n)]

    t0 = time.perf_counter()
    cur, fc = dict(z), energie(z)
    best, fb = dict(z), mk(z)
    alpha = (0.05 / 25.0) ** (1.0 / schritte)
    t = 25.0
    namen_auf = [n for n, _, _ in aufgaben]
    for _ in range(schritte):
        neu = dict(cur)
        if rng.random() < 0.7:
            a = load(cur)
            eng = max(a, key=lambda m: a[m])
            auf = [n for n, m in cur.items() if m == eng]
            n = rng.choice(auf)
            andere = [m for m in kand[n] if m != eng]
            if andere:
                neu[n] = rng.choice(andere)
        else:
            for _ in range(10):
                n1, n2 = rng.sample(namen_auf, 2)
                m1, m2 = cur[n1], cur[n2]
                if m1 != m2 and m2 in kand[n1] and m1 in kand[n2]:
                    neu[n1], neu[n2] = m2, m1
                    break
        fk = energie(neu)
        d = fk - fc
        if d <= 0 or rng.random() < math.exp(-d / t):
            cur, fc = neu, fk
            if mk(cur) < fb:
                best, fb = dict(cur), mk(cur)
        t *= alpha
    return fb, time.perf_counter() - t0


def main() -> None:
    ERGEBNISSE.mkdir(parents=True, exist_ok=True)
    zeilen = []
    print(f"{'Aufg.':>6} {'Mitarb.':>8} {'MILP':>9} {'Zeit':>8} {'Status':>13} "
          f"{'SA':>9} {'Zeit':>8} {'Abstand':>8}")
    for n_auf, n_mit in GROESSEN:
        mit, auf = instanz(n_auf, n_mit, seed=42 + n_auf)
        c_milp, t_milp, status = milp(mit, auf)
        c_sa, t_sa = sa(mit, auf)
        abstand = (c_sa / c_milp - 1) * 100 if c_milp else float("nan")
        zeilen.append({
            "aufgaben": n_auf, "mitarbeiter": n_mit,
            "milp": c_milp, "milp_sekunden": t_milp, "milp_status": status,
            "sa": c_sa, "sa_sekunden": t_sa, "abstand_prozent": abstand,
        })
        print(f"{n_auf:>6} {n_mit:>8} {c_milp:>9.2f} {t_milp:>7.1f}s {status:>13} "
              f"{c_sa:>9.2f} {t_sa:>7.1f}s {abstand:>7.2f}%")
    (ERGEBNISSE / "skalierung.json").write_text(
        json.dumps({"zeitschranke": ZEITSCHRANKE, "messungen": zeilen},
                   indent=2, ensure_ascii=False),
        encoding="utf-8",
    )


if __name__ == "__main__":
    main()
