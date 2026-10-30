# NTNU Article-Based PhD Thesis

An article-based (compilation) PhD thesis template for the Norwegian
University of Science and Technology: a synopsis (introduction, objectives,
methodology, summary, conclusion) followed by the full text of the
constituent papers, each reproduced via `\includepdf`.

- **Upstream**: https://github.com/frodal/PhD-thesis-Latex-template
- **Author**: Bjørn Håkon Frodal
- **Licence**: MIT
- **Engine**: pdflatex

## Notes

- Bibliography already used `backend=bibtex` upstream — no patch needed
  (biblatex with the bibtex backend, not biber).
- No fontspec anywhere (`newtxtext`/`newtxmath`, both filename/kpathsea-based
  Type1 fonts) — pdflatex-safe as shipped.
- Bundles the real NTNU logo (`Figures/ntnu_logo.pdf`) as shipped upstream.
- The two "papers" reproduced via `\includepdf` (`articles/Paper1.pdf`,
  `articles/Paper2.pdf`) are original short articles written for this
  starter — not real published papers — compiled from plain `article` class
  sources to demonstrate the article-based-thesis structure (synopsis +
  full-text reprints). Upstream's own four papers are the author's real
  publications and are not reproduced here.
- Uses the `memoir` class, already in the pinned TeX Live image.

## Licence

MIT — no attribution file required; original author credited above.
