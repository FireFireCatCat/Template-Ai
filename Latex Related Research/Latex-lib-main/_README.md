# Latex Lib Coverage

Can a **finite lib of LaTeX "ways"** (one package or command type per component,
parameter values never counted, plus a finite way of setting the document class)
recover 1000 different real template zips **100%**? And does the lib stop
growing as more zips are read?

Started 2026-10-23. Read [`_Rubric.md`](_Rubric.md) first: it says exactly what a
"way", "bespoke code", "template-defining artwork" and the `yes`/`no` verdict mean.

| Path | What it is |
|---|---|
| `Source/<id>/` | One unpacked template zip per folder, 1000 of them. Third-party works, private study material ([`_Licences.md`](_Licences.md)). Never compiled or run. |
| `Solution/<id>.md` | One analysis per zip. **Line 1 is exactly `yes` or `no`**: could the finite lib rebuild this zip 100%. Then the class setting, a component-to-way table with the parameter combination read from the source, bespoke code and whether it reduces, blockers, and any new way proposed. Read-only analysis: marked Unverified, nothing is compiled. |
| `_Lib.md` | The lib: every way, by component, with the engine it needs and whether Flouest's emitter already has it. Versioned; the change log shows which batch grew it. |
| `_Rubric.md` | The definitions and the verdict rules. |
| `_Manifest.tsv` | The 1000 zips: id, source, origin URL, name, kind, licence, zip size and SHA-256, main file, document class. |
| `_Licences.md` | Licences of the stored zips, where they came from, what was not used and why. |
| `_Summary.md` | The result, once the analysis is done: yes-rate, why the `no`s are `no`, the lib's growth curve, the gap against Flouest's emitter. |
| `_audit/` | Independent second analyses of a sample, to measure how far two analysts agree. Not solutions. |
| `_tools/` | The scripts: discovery, selection, safe fetch, features, de-duplication, the solution checker, the growth curve, and the workflow that runs the analysts. |

## How the 1000 were chosen

From four sources (CTAN class and template packages, latextemplates.com, GitHub
template repositories, the publisher kits the requirement documents already cite),
picked by farthest-first sampling over their descriptions so the set is as
different as the metadata allows, then checked again on content after download:
byte-identical zips and near-copies (same class, same zip-local class files,
structure 88% alike) were dropped, and CTAN zips that are Plain TeX, LaTeX 2.09,
obsolete or tools rather than LaTeX2e templates were swapped for other zips.
`_tools/cand/dropped.tsv` lists every drop and why.

Measured on the final 1000: 364 different document classes in the samples, 1517
different package names, 462 zips ship their own class or style file, and a
typical zip's nearest neighbour is 0.67 away on structure (1 minus the Jaccard
overlap of class and packages; 4 are structurally identical to another).
