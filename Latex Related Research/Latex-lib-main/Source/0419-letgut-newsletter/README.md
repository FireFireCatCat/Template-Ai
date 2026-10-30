# letgut newsletter starter

This LuaLaTeX starter uses the CTAN `letgut` class for the French GUTenberg
newsletter shape: a masthead, contents, editorial article, code example,
book review, and bibliography.

The upstream distribution's larger bibliography and editorial tree is not
available in the pinned build image. This package therefore supplies a small
local `references.bib`, an `editorial.tex` article, and `letgut-acronyms.tex`
so the class's documented input hooks remain complete and reproducible.
The pinned image also omits the class's named `letgut` BibLaTeX styles; the
download includes compatible local `letgut.bbx` and `letgut.cbx` shims that
delegate to the standard numeric styles.

Upstream source: https://ctan.org/pkg/letgut

Upstream licence: LPPL-1.3c-or-later, as stated in the installed class header.
The class is supplied by TeX Live and is not bundled in this download.
