Package: uithesis
Author/Maintainer: Ichlasul Affan
License: LaTeX Project Public License (LPPL) 1.3c

Description
-----------
uithesis is a LaTeX document class for writing undergraduate, graduate, and doctoral theses (Skripsi, Tesis, Disertasi) and internship reports (Kampus Merdeka, Kerja Praktik) at Universitas Indonesia.

It supports monograph, one-column journal, and two-column journal layouts, and provides automated generation of front-matter pages to ensure students can focus on content instead of formatting.

Installation
------------
Once available on TeX Live or MiKTeX, you can install the package using your TeX distribution's package manager:

    tlmgr install uithesis

To install from source manually, generate `uithesis.cls` by running:

    tex uithesis.ins

Then place `uithesis.cls` and the images in the `internals/` folder in a directory where TeX can find them (e.g., your local texmf tree), or in the same directory as your main document.

Usage
-----
Please refer to the documentation `uithesis-doc.pdf` for detailed instructions and class options.

Bug Reports and Support
-----------------------
For bug reports, issues, or to contribute, please visit the repository at:
https://gitlab.com/ichlaffterlalu/latex-ta-ui
https://gitlab.com/ichlaffterlalu/latex-ta-ui/-/issues

Changelog
---------
* v3.0.0 (2026-08-20)
  - Major update based on the latest 2025 UI formatting rules.
  - Converted the template from a style file (`uithesis.sty`) into a proper document class (`uithesis.cls`).
  - Switched citation backend to `biblatex` + `biber` with APA format.
  - Automated front-matter generation via `\makefrontmatter`.
  - Added new Journal layout modes (1-column and 2-column) alongside Monograph mode.
  - Built-in support for Indonesian and English languages.
  - Built-in support for twoside printing and a plagiarism checker-friendly mode.
  - Packaged and released on CTAN.

* v2.2.2 (2026-05-08)
  - Added support for subfigures and advanced math symbols (`amssymb`).

* v2.2.1 (2024-12-16)
  - Bug fixes for twoside header/footer, code auto-wrapping, and numbering.
  - Added support for glossary and advanced code highlighting.

* v2.2.0 (2024-08-28)
  - Layout fixes for front-matter and appendices to match updated guidelines.

* v2.1.3 (2023-02-22)
  - Added support for Group Thesis and Kampus Merdeka Mandiri formats.

* v2.1.0 (2021-09-08)
  - Added experimental multi-language support (Chinese, Japanese, Korean).
  
* v2.0.0 (2020-01-29)
  - Updated to 2017 formatting rules.
  - Integrated BibTeX for citations.

* v1.0.3 (2010-12-03)
  - Initial template release for the 2008 formatting rules.
