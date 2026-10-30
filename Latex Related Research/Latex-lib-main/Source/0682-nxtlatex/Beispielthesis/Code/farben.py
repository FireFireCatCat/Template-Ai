"""Farben aus nxtlatexcolors.sty lesen und für Python und MetaPost bereitstellen.

Die Farbdefinitionen der NXT-Palette stehen genau einmal im Paket
nxtlatexcolors.sty. Dieses Modul liest sie von dort und stellt sie als
Python-Dictionary bereit; zusätzlich schreibt es sie als MetaPost-Datei
heraus. Dadurch benutzen LaTeX, TikZ, matplotlib und MetaPost garantiert
dieselben Werte -- eine Farbe wird an genau einer Stelle geändert.

Aufruf als Skript erzeugt Abbildungen/nxtfarben.mp.
"""

from __future__ import annotations

import re
from pathlib import Path

# nxtlatexcolors.sty liegt im Wurzelverzeichnis des Pakets, also eine
# Ebene über Beispielthesis/.
STY = Path(__file__).resolve().parents[2] / "nxtlatexcolors.sty"

_RGB = re.compile(r"\\definecolor\{([^}]+)\}\{RGB\}\{\s*(\d+)\s*,\s*(\d+)\s*,\s*(\d+)\s*\}")
_HTML = re.compile(r"\\definecolor\{([^}]+)\}\{HTML\}\{([0-9A-Fa-f]{6})\}")


def lade_farben(sty: Path = STY) -> dict[str, tuple[int, int, int]]:
    """Liest alle \\definecolor-Zeilen aus nxtlatexcolors.sty."""
    if not sty.is_file():
        raise FileNotFoundError(
            f"nxtlatexcolors.sty nicht gefunden unter {sty}. "
            "Die Farben sind dort zentral definiert."
        )
    text = sty.read_text(encoding="utf-8")
    farben: dict[str, tuple[int, int, int]] = {}
    for name, r, g, b in _RGB.findall(text):
        farben[name] = (int(r), int(g), int(b))
    for name, hexcode in _HTML.findall(text):
        farben[name] = tuple(int(hexcode[i : i + 2], 16) for i in (0, 2, 4))  # type: ignore[misc]
    if not farben:
        raise ValueError(f"Keine \\definecolor-Zeilen in {sty} gefunden.")
    return farben


FARBEN = lade_farben()


def hex_(name: str) -> str:
    """Farbe als #RRGGBB für matplotlib."""
    try:
        r, g, b = FARBEN[name]
    except KeyError:
        raise KeyError(
            f"Farbe {name!r} ist in nxtlatexcolors.sty nicht definiert. "
            f"Vorhanden: {', '.join(sorted(FARBEN))}"
        ) from None
    return f"#{r:02X}{g:02X}{b:02X}"


# Rollen statt Rohfarben: im Dokument wird über die Rolle zugegriffen,
# damit eine Umfärbung an einer Stelle passiert.
HIGHLIGHT = hex_("nxtgreen")
TEXTFARBE = hex_("nxt.gray8")
GITTER = hex_("nxt.gray1")
HELL = hex_("nxt.verylightgray")

#: Qualitative Reihe für Kategorien (Mitarbeiter, Qualifikationen, ...).
#: Reihenfolge bewusst nach Farbabstand, nicht nach Namen.
REIHE = [
    hex_("nxtgreen"),
    hex_("nxt.orange"),
    hex_("nxt.violet"),
    hex_("nxt.blue"),
    hex_("nxt.olive"),
    hex_("nxt.yellow"),
    hex_("nxt.magenta"),
    hex_("nxt.cyan"),
]


def mp_schreiben(ziel: Path) -> None:
    """Schreibt die Palette als MetaPost-Datei.

    MetaPost liest eine Ziffer am Ende eines Namens nicht als Teil des
    Namens, sondern als numerischen Suffix: »nxt_gray1« ist dort das
    Element 1 der Variablen »nxt_gray«. Namen mit Endziffer müssen daher
    als Feld deklariert werden (color nxt_gray[];), sonst bricht MetaPost
    mit »Illegal suffix of declared variable« ab.
    """
    def mp_name(name: str) -> str:
        return name.replace(".", "_")

    def basis(name: str) -> str | None:
        """Basisname, falls der Name auf einer Ziffer endet."""
        n = mp_name(name)
        return n.rstrip("0123456789") if n[-1].isdigit() else None

    felder = sorted({b for n in FARBEN if (b := basis(n))})
    einfach = sorted(n for n in FARBEN if basis(n) is None)

    zeilen = [
        "% Automatisch erzeugt aus nxtlatexcolors.sty von Code/farben.py.",
        "% Nicht von Hand ändern -- Änderungen gehören in nxtlatexcolors.sty.",
        "",
        "% Namen mit Endziffer sind in MetaPost Felder (nxt_gray1 = nxt_gray[1]).",
    ]
    for b in felder:
        zeilen.append(f"color {b}[];")
    zeilen.append("")
    for name in einfach:
        r, g, b_ = FARBEN[name]
        n = mp_name(name)
        zeilen.append(f"color {n}; {n} := ({r/255:.4f}, {g/255:.4f}, {b_/255:.4f});")
    zeilen.append("")
    for name in sorted(n for n in FARBEN if basis(n)):
        r, g, b_ = FARBEN[name]
        n = mp_name(name)
        zeilen.append(f"{n} := ({r/255:.4f}, {g/255:.4f}, {b_/255:.4f});")
    zeilen.append("")
    ziel.write_text("\n".join(zeilen), encoding="utf-8")


if __name__ == "__main__":
    ziel = Path(__file__).resolve().parent.parent / "Abbildungen" / "nxtfarben.mp"
    ziel.parent.mkdir(parents=True, exist_ok=True)
    mp_schreiben(ziel)
    print(f"{len(FARBEN)} Farben aus {STY.name} gelesen.")
    print(f"MetaPost-Palette geschrieben: {ziel}")
    print(f"Highlight = {HIGHLIGHT}, Reihe = {len(REIHE)} Farben")
