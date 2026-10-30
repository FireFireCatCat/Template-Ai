"""Erzeugt die Abbildungen der Thesis aus den echten Rechenergebnissen.

Alle Farben stammen aus farben.py und damit aus nxtlatexcolors.sty; die
Schrift ist dieselbe wie im Dokument (STIX Two Text). Ausgabe als PDF,
damit die Grafiken vektoriell bleiben.

Aufruf:  python3 abbildungen.py   (setzt sa.py und skalierung.py voraus)
"""

from __future__ import annotations

import json
from pathlib import Path

import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
import numpy as np
from matplotlib.patches import PathPatch
from matplotlib.path import Path as MPath

import farben
from daten import anzeige

HIER = Path(__file__).resolve().parent
ERGEBNISSE = HIER.parent / "Ergebnisse"
ABB = HIER.parent / "Abbildungen"


def stil() -> None:
    """Einheitlicher, ruhiger Stil für alle Abbildungen.

    Bewusst sparsam: keine Rahmen oben und rechts, kein Hintergrundgitter
    quer zur Leserichtung, Beschriftung direkt am Objekt statt in einer
    Legende, wo es geht.
    """
    plt.rcParams.update({
        "font.family": "STIX Two Text",
        "mathtext.fontset": "stix",
        "font.size": 9,
        "axes.titlesize": 10,
        "axes.labelsize": 9,
        "axes.edgecolor": farben.hex_("nxt.gray3"),
        "axes.labelcolor": farben.TEXTFARBE,
        "text.color": farben.TEXTFARBE,
        "xtick.color": farben.hex_("nxt.gray4"),
        "ytick.color": farben.hex_("nxt.gray4"),
        "xtick.labelsize": 8,
        "ytick.labelsize": 8,
        "legend.frameon": False,
        "legend.fontsize": 8,
        "axes.spines.top": False,
        "axes.spines.right": False,
        "figure.dpi": 150,
        "savefig.bbox": "tight",
        "savefig.pad_inches": 0.02,
    })


def lade(name: str) -> dict:
    p = ERGEBNISSE / name
    if not p.is_file():
        raise SystemExit(
            f"{p} fehlt. Erst 'python3 sa.py' und 'python3 skalierung.py' laufen lassen."
        )
    return json.loads(p.read_text(encoding="utf-8"))


# ------------------------------------------------------- Abbildung: Auslastung

def auslastung(sa: dict) -> None:
    """Auslastung je Mitarbeiter: LPT gegen SA gegen Optimum."""
    fig, ax = plt.subplots(figsize=(5.4, 2.8))
    namen = list(sa["loesungen"]["LPT"]["auslastung"])
    x = np.arange(len(namen))
    breite = 0.38

    lpt = [sa["loesungen"]["LPT"]["auslastung"][n] for n in namen]
    sav = [sa["loesungen"]["SimulatedAnnealing"]["auslastung"][n] for n in namen]

    ax.bar(x - breite / 2, lpt, breite, label="LPT",
           color=farben.hex_("nxt.gray2"), edgecolor="none")
    ax.bar(x + breite / 2, sav, breite, label="Simulated Annealing",
           color=farben.HIGHLIGHT, edgecolor="none")

    opt = sa["verfahren"]["MILP"]["makespan"]
    if opt:
        ax.axhline(opt, color=farben.hex_("nxt.red"), lw=1, ls=(0, (4, 2)), zorder=3)
        ax.annotate(f"Optimum {opt:.1f} min", xy=(len(namen) - 0.4, opt),
                    xytext=(0, 4), textcoords="offset points",
                    ha="right", va="bottom", fontsize=8,
                    color=farben.hex_("nxt.red"))

    ax.set_xticks(x)
    ax.set_xticklabels(namen, rotation=30, ha="right")
    ax.set_ylabel("Auslastung in Minuten")
    ax.legend(loc="lower right", ncol=2)
    ax.set_ylim(0, max(lpt) * 1.18)
    fig.savefig(ABB / "auslastung.pdf")
    plt.close(fig)


# ------------------------------------------------------- Abbildung: Konvergenz

def konvergenz(sa: dict) -> None:
    """Verlauf des Verfahrens: aktueller und bester Makespan."""
    fig, ax = plt.subplots(figsize=(5.4, 2.8))
    akt = sa["verlauf"]["aktuell"]
    best = sa["verlauf"]["bestes"]
    x = np.arange(len(akt)) * 100

    ax.plot(x, akt, lw=0.6, color=farben.hex_("nxt.gray2"),
            label="aktuelle Lösung")
    ax.plot(x, best, lw=1.4, color=farben.HIGHLIGHT, label="beste Lösung")

    opt = sa["verfahren"]["MILP"]["makespan"]
    if opt:
        ax.axhline(opt, color=farben.hex_("nxt.red"), lw=1, ls=(0, (4, 2)))
        ax.annotate("Optimum", xy=(x[-1], opt), xytext=(-2, 4),
                    textcoords="offset points", ha="right", va="bottom",
                    fontsize=8, color=farben.hex_("nxt.red"))
    us = sa["instanz"]["untere_schranke"]
    ax.axhline(us, color=farben.hex_("nxt.gray3"), lw=1, ls=(0, (1, 2)))
    ax.annotate("triviale untere Schranke", xy=(x[-1], us), xytext=(-2, 4),
                textcoords="offset points", ha="right", va="bottom",
                fontsize=8, color=farben.hex_("nxt.gray4"))

    ax.set_xlabel("Iteration")
    ax.set_ylabel("Makespan in Minuten")
    ax.legend(loc="upper right")
    fig.savefig(ABB / "konvergenz.pdf")
    plt.close(fig)


# ---------------------------------------------------------- Abbildung: Sankey

def _band(ax, x0, y0, x1, y1, dicke0, dicke1, farbe, alpha=0.55):
    """Ein Sankey-Band als Bézier-Fläche zwischen zwei Knoten."""
    xm = (x0 + x1) / 2
    verts = [
        (x0, y0), (xm, y0), (xm, y1), (x1, y1),                      # Oberkante
        (x1, y1 - dicke1), (xm, y1 - dicke1),
        (xm, y0 - dicke0), (x0, y0 - dicke0), (x0, y0),              # Unterkante
    ]
    codes = [MPath.MOVETO, MPath.CURVE4, MPath.CURVE4, MPath.CURVE4,
             MPath.LINETO, MPath.CURVE4, MPath.CURVE4, MPath.CURVE4,
             MPath.CLOSEPOLY]
    ax.add_patch(PathPatch(MPath(verts, codes), facecolor=farbe,
                           edgecolor="none", alpha=alpha))


def sankey(sa: dict, instanz: dict) -> None:
    """Fluss der Arbeitszeit: Qualifikation -> Mitarbeiter.

    Die Bandbreite entspricht den Minuten, die in der SA-Lösung von einer
    Qualifikation auf einen Mitarbeiter entfallen. Sichtbar wird damit,
    welche Qualifikation den Engpass verursacht.
    """
    z = sa["loesungen"]["SimulatedAnnealing"]["zuordnung"]

    fluss: dict[tuple[str, str], float] = {}
    for eintrag in z.values():
        k = (eintrag["qualifikation"], eintrag["mitarbeiter"])
        fluss[k] = fluss.get(k, 0.0) + eintrag["dauer"]

    quellen = sorted({q for q, _ in fluss}, key=lambda q: -sum(
        v for (qq, _), v in fluss.items() if qq == q))
    ziele = sorted({m for _, m in fluss}, key=lambda m: -sum(
        v for (_, mm), v in fluss.items() if mm == m))

    q_summe = {q: sum(v for (qq, _), v in fluss.items() if qq == q) for q in quellen}
    z_summe = {m: sum(v for (_, mm), v in fluss.items() if mm == m) for m in ziele}
    gesamt = sum(fluss.values())

    fig, ax = plt.subplots(figsize=(5.4, 4.2))
    luecke = gesamt * 0.035
    hoehe_q = gesamt + luecke * (len(quellen) - 1)
    hoehe_z = gesamt + luecke * (len(ziele) - 1)
    skala = max(hoehe_q, hoehe_z)

    farbe_q = {q: farben.REIHE[i % len(farben.REIHE)] for i, q in enumerate(quellen)}

    # Knotenpositionen (oben nach unten)
    y = skala
    q_pos: dict[str, float] = {}
    for q in quellen:
        q_pos[q] = y
        y -= q_summe[q] + luecke
    y = skala
    z_pos: dict[str, float] = {}
    for m in ziele:
        z_pos[m] = y
        y -= z_summe[m] + luecke

    q_cursor = dict(q_pos)
    z_cursor = dict(z_pos)
    x0, x1 = 0.0, 1.0
    for q in quellen:
        for m in ziele:
            v = fluss.get((q, m))
            if not v:
                continue
            _band(ax, x0 + 0.04, q_cursor[q], x1 - 0.04, z_cursor[m],
                  v, v, farbe_q[q])
            q_cursor[q] -= v
            z_cursor[m] -= v

    # Knotenbalken und Beschriftung
    for q in quellen:
        ax.add_patch(plt.Rectangle((x0, q_pos[q] - q_summe[q]), 0.04, q_summe[q],
                                   color=farbe_q[q], lw=0))
        ax.text(x0 - 0.02, q_pos[q] - q_summe[q] / 2,
                f"{anzeige(q)}\n{q_summe[q]:.0f} min",
                ha="right", va="center", fontsize=7.5)
    for m in ziele:
        ax.add_patch(plt.Rectangle((x1 - 0.04, z_pos[m] - z_summe[m]), 0.04,
                                   z_summe[m], color=farben.hex_("nxt.gray4"), lw=0))
        ax.text(x1 + 0.02, z_pos[m] - z_summe[m] / 2,
                f"{m}\n{z_summe[m]:.0f} min", ha="left", va="center", fontsize=7.5)

    ax.set_xlim(-0.28, 1.28)
    ax.set_ylim(-luecke, skala + luecke)
    ax.axis("off")
    fig.savefig(ABB / "sankey.pdf")
    plt.close(fig)


# ------------------------------------------------------- Abbildung: Skalierung

def skalierung(sk: dict) -> None:
    """Rechenzeit und Lösungsgüte über die Instanzgröße."""
    m = sk["messungen"]
    n = [w["aufgaben"] for w in m]
    t_milp = [w["milp_sekunden"] for w in m]
    t_sa = [w["sa_sekunden"] for w in m]
    abst = [w["abstand_prozent"] for w in m]
    opt = [w["milp_status"] == "optimal" for w in m]

    fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(5.4, 2.5))

    ax1.plot(n, t_milp, "o-", color=farben.hex_("nxt.red"), lw=1.2, ms=4,
             label="MILP (GLPK)")
    ax1.plot(n, t_sa, "o-", color=farben.HIGHLIGHT, lw=1.2, ms=4,
             label="Simulated Annealing")
    ax1.axhline(sk["zeitschranke"], color=farben.hex_("nxt.gray3"), lw=1,
                ls=(0, (1, 2)))
    ax1.annotate("Zeitschranke", xy=(n[-1], sk["zeitschranke"]), xytext=(-2, -10),
                 textcoords="offset points", ha="right", fontsize=7.5,
                 color=farben.hex_("nxt.gray4"))
    ax1.set_yscale("log")
    ax1.set_xlabel("Arbeitsgänge")
    ax1.set_ylabel("Rechenzeit in Sekunden")
    ax1.legend(loc="lower right")

    farbe = [farben.HIGHLIGHT if a <= 0 else farben.hex_("nxt.orange") for a in abst]
    ax2.bar([str(v) for v in n], abst, color=farbe, edgecolor="none", width=0.6)
    ax2.axhline(0, color=farben.hex_("nxt.gray3"), lw=0.8)
    ax2.set_xlabel("Arbeitsgänge")
    ax2.set_ylabel("Abstand SA zu MILP in %")
    spanne = max(abs(min(abst)), abs(max(abst))) or 1.0
    ax2.set_ylim(min(abst) - 0.45 * spanne, max(abs(max(abst)), 0) + 0.45 * spanne)
    # Jeden Wert beschriften. Ohne Zahl sähen die Gleichstände (0,00 %)
    # nach fehlenden Daten aus statt nach dem Ergebnis, das sie sind.
    for i, (v, o) in enumerate(zip(abst, opt)):
        oben = v >= 0
        ax2.annotate(f"{v:+.2f}{'' if o else ' *'}", xy=(i, v),
                     xytext=(0, 4 if oben else -11), textcoords="offset points",
                     ha="center", fontsize=7,
                     color=farben.TEXTFARBE if o else farben.hex_("nxt.gray5"))
    ax2.text(0.0, -0.46, "* MILP an der Zeitschranke abgebrochen,\n"
                         "  Optimalität nicht bewiesen",
             transform=ax2.transAxes, fontsize=7, color=farben.hex_("nxt.gray4"),
             va="top")
    fig.savefig(ABB / "skalierung.pdf")
    plt.close(fig)


# ---------------------------------------------------- Abbildung: Energievergleich

def energien(sa: dict) -> None:
    """Wirkung der geglätteten Energie: Streuung über 20 Läufe."""
    ev = sa["energievergleich"]
    fig, ax = plt.subplots(figsize=(5.4, 2.4))
    daten = [ev["roh"]["laeufe"], ev["geglaettet"]["laeufe"]]
    # matplotlib hat die Schnittstelle von boxplot geändert: »labels«
    # heißt seit 3.9 »tick_labels« (in 3.11 entfernt), »vert=False« seit
    # 3.10 »orientation="horizontal"«. Die Ausrichtung deshalb je nach
    # Version, die Beschriftung danach über die Achse -- das geht überall.
    if tuple(int(t) for t in matplotlib.__version__.split(".")[:2]) >= (3, 10):
        ausrichtung = {"orientation": "horizontal"}
    else:
        ausrichtung = {"vert": False}
    bp = ax.boxplot(daten, widths=0.5, patch_artist=True, **ausrichtung,
                    medianprops={"color": farben.TEXTFARBE, "lw": 1.2},
                    flierprops={"marker": "o", "ms": 3,
                                "markerfacecolor": farben.hex_("nxt.gray3"),
                                "markeredgecolor": "none"})
    ax.set_yticks([1, 2])
    ax.set_yticklabels(["nur Makespan", "Makespan + Glättung"])
    for patch, f in zip(bp["boxes"], [farben.hex_("nxt.gray2"), farben.HIGHLIGHT]):
        patch.set_facecolor(f)
        patch.set_edgecolor("none")
    opt = sa["verfahren"]["MILP"]["makespan"]
    if opt:
        ax.axvline(opt, color=farben.hex_("nxt.red"), lw=1, ls=(0, (4, 2)))
        ax.annotate("Optimum", xy=(opt, 2.45), xytext=(3, 0),
                    textcoords="offset points", fontsize=8,
                    color=farben.hex_("nxt.red"), va="center")
    ax.set_xlabel("Makespan in Minuten (20 Läufe je Variante)")
    ax.set_ylim(0.4, 2.7)
    fig.savefig(ABB / "energien.pdf")
    plt.close(fig)


def main() -> None:
    ABB.mkdir(parents=True, exist_ok=True)
    stil()
    sa = lade("sa.json")
    instanz = lade("instanz.json")
    auslastung(sa)
    konvergenz(sa)
    sankey(sa, instanz)
    energien(sa)
    try:
        skalierung(lade("skalierung.json"))
    except SystemExit as e:
        print(f"  übersprungen: {e}")
    for p in sorted(ABB.glob("*.pdf")):
        print(f"  {p.name}")
    print("Abbildungen erzeugt.")


if __name__ == "__main__":
    main()
