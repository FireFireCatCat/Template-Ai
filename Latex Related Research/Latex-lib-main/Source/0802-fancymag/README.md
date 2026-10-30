# fancymag

# Particle Style – A Custom LaTeX Package

**Authors:** Ashadul Halder and Soumik Ghosh  
**License:** LPPL v1.3c (fonts under SIL Open Font License v1.1)
**Font License:** SIL Open Font License v1.1

---

## Overview

`fancymag.sty` is a LaTeX package designed to provide enhanced typographic styling using a set of freely licensed display fonts. It enables you to integrate modern, visually striking fonts into your LaTeX documents with ease, making it ideal for academic magazines, scientific books, and editorial publications.

---

## Features

- Custom font commands for stylish text
- Uses 7 modern fonts with full Unicode support:
  - Audiowide
  - Fira Mono
  - Imperial Script
  - Montserrat
  - Rationale
  - Orbitron
  - Oleo Script Swash Caps
- Works with LuaLaTeX
- Easily portable (fonts are bundled locally)

---

## Note on Font Installation

This package is designed to work with **LuaLaTeX** and uses locally bundled fonts. These fonts are stored in the `fonts/` directory and are not installed system-wide.

If installed via TeX Live or MiKTeX, the fonts may not be available by default. Users must compile in a directory where the `fonts/` folder is present.

This design keeps the package portable and self-contained, but it limits automatic compatibility with TeX package managers.

## Requirements

This package must be compiled using **LuaLaTeX**.

It uses system-independent OpenType fonts via `fontspec` and will not work with `pdflatex` or `xelatex`.

Ensure that the `fonts/` folder (included with the package) is present in the same directory or properly referenced.


## Getting Started

To use the package:

1. Add `\usepackage{fancymag}` to your LaTeX document.
2. Compile using **LuaLaTeX** (fontspec required).

See the full tutorial in the file: **`fancymag.pdf`**

## Font Licenses

This package includes the following fonts, all licensed under the **SIL Open Font License (OFL) v1.1**:

  - Audiowide
  - Fira Mono
  - Imperial Script
  - Montserrat
  - Rationale
  - Orbitron
  - Oleo Script Swash Caps

The full text of the OFL v1.1 license is included in the package as `OFL.txt`.

---

## Files Included

- `fancymag.sty` – Main package file
- `fancymag-doc.tex` – Documentation source
- `fancymag-doc.pdf` – Compiled documentation
- `README.md` – This file
- `fonts/` – Directory containing all required fonts
- `img/` – Directory containing all required graphics
- `OFL.txt` – Font license (SIL Open Font License v1.1)
- `LICENSE.txt` – Package license (LPPL v1.3c)

---

## Version History

- **v1.0** – Initial release (2025-07-07)