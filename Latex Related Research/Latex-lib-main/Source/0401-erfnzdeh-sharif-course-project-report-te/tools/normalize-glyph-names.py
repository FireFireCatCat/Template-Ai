#!/usr/bin/env python3
"""Make the bundled fonts' glyph names recoverable as Unicode.

The XB fonts name their contextual variants with an underscore -- `uniFB95_alt`,
`partialdiff_mirror`, `uni0628_Khahar`. By the Adobe glyph-naming convention an
underscore separates the *components of a ligature*, so a PDF reader parses
`uniFB95_alt` as "uniFB95 followed by a glyph called alt", fails on `alt`, and
gives up on the whole name. Those glyphs then end up with no `ToUnicode` entry,
and the letters they represent silently vanish when the PDF is copied, searched
or read by a screen reader. In this template that swallowed roughly 3% of the
text, including very common letters (ی, ه, گ, ک).

The convention for a *variant* is a period instead: `uniFB95.alt`. Everything
after the first period is ignored when deriving Unicode, so the glyph maps back
to `uniFB95` correctly. This script rewrites the underscore form to the period
form, taking care to leave genuine ligature names such as
`afii57415_uniFEDF_uniFED2` alone.

Only glyph names change. Outlines, metrics, glyph order and glyph IDs are all
preserved, so the layout tables (which address glyphs by ID) stay valid.

Usage:
    python3 tools/normalize-glyph-names.py [font.ttf ...]

With no arguments, every .ttf under styles/fonts/ is processed. The script is
idempotent, so re-running it is a no-op.
"""

import re
import sys
from pathlib import Path

from fontTools.ttLib import TTFont

# A ligature component is itself a glyph name that maps to a character.
COMPONENT = re.compile(r"^(uni[0-9A-Fa-f]{4,}|u[0-9A-Fa-f]{4,6}|afii\d+)$")

REPO_ROOT = Path(__file__).resolve().parent.parent
FONT_DIR = REPO_ROOT / "styles" / "fonts"


def normalize(name: str) -> str:
    """Turn variant-marking underscores into periods, keeping ligatures intact."""
    head, _, existing_suffix = name.partition(".")
    parts = head.split("_")

    components = [parts[0]]
    i = 1
    while i < len(parts) and COMPONENT.match(parts[i]):
        components.append(parts[i])
        i += 1
    tags = parts[i:]

    out = "_".join(components)
    if tags:
        out += "." + ".".join(tags)
    if existing_suffix:
        out += "." + existing_suffix
    return out


def fix(path: Path) -> bool:
    font = TTFont(path)
    # Touch only the tables that store glyph names; everything else is written
    # back verbatim, which keeps the ID-based layout tables byte-identical.
    glyf, hmtx = font["glyf"], font["hmtx"]
    font["post"]

    order = list(font.getGlyphOrder())
    renames = {g: normalize(g) for g in order if normalize(g) != g}
    if not renames:
        print(f"{path.name}: already normalized")
        return False

    collisions = set(renames.values()) & set(order)
    if collisions:
        raise SystemExit(f"{path.name}: rename would collide with {sorted(collisions)[:5]}")

    for old, new in renames.items():
        glyf.glyphs[new] = glyf.glyphs.pop(old)
        hmtx.metrics[new] = hmtx.metrics.pop(old)

    new_order = [renames.get(g, g) for g in order]
    font.setGlyphOrder(new_order)
    glyf.glyphOrder = new_order
    font.save(path)

    check = TTFont(path)
    if check.getGlyphOrder() != new_order:
        raise SystemExit(f"{path.name}: glyph order changed, refusing to continue")

    print(f"{path.name}: renamed {len(renames)} glyphs (e.g. {next(iter(renames.items()))})")
    return True


def main(argv: list[str]) -> int:
    paths = [Path(a) for a in argv] or sorted(FONT_DIR.glob("*.ttf"))
    if not paths:
        raise SystemExit(f"no fonts found in {FONT_DIR}")
    changed = sum(fix(p) for p in paths)
    print(f"\n{changed} of {len(paths)} font(s) modified")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
