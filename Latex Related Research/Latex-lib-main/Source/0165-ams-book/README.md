# amsbook

The American Mathematical Society's book class — the same `amsbook.cls` used
for AMS monograph series. This starter differentiates itself from `amsart`
(articles, no chapters) and from `scrbook`/`memoir` (generic long-document
classes) by using amsbook's actual reason to exist: `\frontmatter`,
`\mainmatter`, and `\backmatter` for correct front-matter pagination, plus a
full set of AMS theorem environments (theorem, lemma, corollary, proposition,
definition, remark) numbered per chapter.

## Class

`amsbook` is **not bundled** — it ships with every modern TeX distribution
(part of the `amscls` bundle) and with the compiler this site uses. Bundling
an old copy would only risk shadowing a newer one already on your system.

## Licence

LPPL-1.3c, (c) American Mathematical Society. See `texdoc amsbook` or
<https://ctan.org/pkg/amscls>.

## Build

```
pdflatex main && bibtex main && pdflatex main && pdflatex main
```
