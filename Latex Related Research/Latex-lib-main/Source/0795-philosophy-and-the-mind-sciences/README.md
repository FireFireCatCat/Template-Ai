# Philosophy and the Mind Sciences (phimisci)

A starter for Philosophy and the Mind Sciences, using the official
`phimisci` document class.

## Files

- `main.tex` — the article. Start here.

## The class is deliberately NOT included

`phimisci.cls` ships with every modern TeX distribution, so this download
does not bundle a copy.

If your distribution does not have it: https://ctan.org/pkg/phimisci

## Engine: xelatex or lualatex — NOT pdflatex

The class raises a hard `ClassError` ("wrong-tex-engine") if compiled
under pdflatex; it requires fontspec.

## Building

    xelatex main
    xelatex main

Two passes resolve the table reference. **This starter ships with no
bibliography** — see below for why, and how to add one back if your own
workflow supports it.

## `stage=` MUST be passed explicitly, or authors silently vanish

The class's internal "output authors" flag starts life **off**, and only
gets switched on by one of its four `stage` options
(`preparation`/`submission`/`draft`/`final`). The documented default is
`preparation`, but that default only fires if you write the bare key
`stage` with no value — omitting the class option entirely (a plain
`\documentclass{phimisci}`) never runs any of that setup code. The
symptom is silent: the title page compiles cleanly with **no author
names**, and the running header prints "Anonymized" as if you had
requested blind review, with no warning. This starter uses
`\documentclass[stage=preparation]{phimisci}` — always pass `stage`
explicitly:

| `stage=`       | Shows authors? | Use for |
|----------------|-----------------|---------|
| `preparation`  | yes             | working draft (this starter) |
| `submission`   | **no**          | anonymous peer review |
| `draft`        | yes             | reviewer copy, watermarked, line numbers |
| `final`        | yes             | the journal's typeset, accepted version |

## No bibliography in this starter — biber-only, and this pipeline runs bibtex

The class loads `biblatex` with `style=apa`, and biblatex's citation
style resolution defaults to the **biber** backend since the class sets
no explicit `backend=` key. Forcing
`\PassOptionsToPackage{backend=bibtex}{biblatex}` was tried while
building this starter and fails hard at compile time — "Biber backend is
required by style" — because `biblatex-apa`'s style file calls
`\DeclareSortingTemplate`, a biber-only feature bibtex cannot process at
all. Unlike some other classes in this batch, there is no bibtex-safe
path here.

If your own workflow runs **biber** (most local TeX installs and
Overleaf do by default), add back:

    \addbibresource{your.bib}
    ...
    \printbibliography

and cite normally with `\citep`/`\citet` (natbib-compatible commands are
enabled) — it works fine outside this site's bibtex-only compiler.

## Usage

- `\author{Name \affiliation{Institution} \orcid{...} \and Name2
  \affiliation{...}}` — authors are `\and`-separated within **one**
  `\author{}` call, with `\affiliation{}` and optional `\orcid{}` inline
  per author.
- `\contact{Name}{email}` — prints the "Primary contact:" line at the
  foot of the title page. Omitting it leaves a dangling "Primary
  contact:" label with nothing after it (confirmed by compiling without
  it), so always set it when authors are shown.
- `\abstract{...}` and `\keywords{...}` — called in the preamble, not as
  environments.

## Before you submit

Check the journal's current author guidelines at
https://philosophymindscience.org — a bundled class can go stale against
a journal's live requirements.

## Licence

`phimisci` is licensed **LPPL-1.3c or later**, © Ruhr-Universität Bochum.
The class is not redistributed here; see https://ctan.org/pkg/phimisci.

This starter document is a minimal example written for latextemplates.com
and carries no additional restrictions.
