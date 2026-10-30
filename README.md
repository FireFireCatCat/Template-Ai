# Template-Ai

Template automation on Flouest. There are three parts:

- **A handler library.** Every way of writing each Flouest node in LaTeX, each with a key that says what it achieves, what it conflicts with and where it can sit.
- **A testing pipeline.** It compiles every legal nesting of those handlers under each document class on ZeroTeX-NG, judges the output and turns failures into rules.
- **An AI layer, still a plan.** The AI only builds keys, and a deterministic matcher picks the handlers.

This README is written for an AI agent (or a person) setting this up on a new machine to run the tests that were deferred: the class probe and the compatibility matrix over every node's handlers and every class profile. Read it top to bottom before running anything.

| Folder | What it is | Read first |
|---|---|---|
| `Latex-Lib/` | The handler library: 110 handlers over Flouest's 32 nodes, 507 typed parameters, 347 presets, 46 class profiles, 68 package facts | `ARCHITECTURE.md` (this folder), sections 2.1, 5, 9 and 11 |
| `testing-pipeline/` | The compatibility matrix: `core/` (no Flouest), `host-flouest/` (the Flouest binding and the commands) | `testing-pipeline/ARCHITECTURE.md`, sections 3, 7 and 8 |
| `Ai/` | The AI layer's plan (not built) | `Ai/ARCHITECTURE.md` |
| `Latex Related Research/Latex-lib-main/` | The study the library is built from: 1000 template zips (`Source/`), one analysis each (`Solution/`), the manifest and tools | its `_README.md` |

## Rules

- **ZeroTeX-NG is the only engine.** Don't add XeLaTeX, pdfLaTeX, LuaLaTeX or a TeX Live install. Every compile goes through Flouest's own engine runner, so a result here is what the app would give.
- **No timers.** Don't add timeouts or polling sleeps to a compile (Flouest ADR-209). A compile that never returns holds its engine until the run is stopped.
- **Don't edit the Flouest checkout.** The pipeline reads it. The library pins the Flouest files it reads by hash (`Latex-Lib/flouest.lock.json`), and `npm run verify` reports any that changed.
- **Don't run Flouest's own dynamic tests while the pipeline runs.** They share Chrome profiles (`out/_shared`).
- **The keys are hand-kept.** Edit `Latex-Lib/nodes/<node>/<way>/key.ts` and `presets.ts` directly. Nothing generates them.
- **Update the docs in the same change**, keep folders flat, and commit only when the owner asks.
- **`Source/` is private.** It holds third-party templates kept for study (`Latex Related Research/Latex-lib-main/_Licences.md`), so this repository must stay private. Never compile or run anything in `Source/`. Copying a class file from it into a class setting (step 4a) is the one exception, and that is for the engine to load, not to run.

## 1. Set up the machine

You need:
- **Node 22.18 or later.** The code runs TypeScript by type stripping.
- **Google Chrome**, installed normally. The engine runs in headless system Chrome through Playwright (`channel: 'chrome'`), so no browser download is needed.
- **Internet access.** The engine fetches TeX packages from the app's pinned MiKTeX mirror the first time it needs each one.
- **Memory.** Plan on about 2 GB per engine. `compat.config.json`'s `"engines": "default"` picks a count from the machine's memory and cores. Set a number there to change it.

### The Flouest checkout

The pipeline and the library both need the Flouest checkout (`Flouest-dev-main`). It is not in this repository and is not a git repository, so copy it over from the old machine (about 2.7 GB):
- You can leave out `app/node_modules`; step 2 reinstalls it.
- Keep `Template/test/dynamic-testing/out/_shared` (about 2 GB) if you can. It holds the engine's format and every package already fetched, so the first runs don't fetch them again.

Both configs find Flouest at `../../StartUp/Flouest-dev-main`, measured from `Latex-Lib/` and from `testing-pipeline/`. So put the clone and a `StartUp` folder side by side:

```
<any folder>/
  Template-Ai/                 this repository
  StartUp/Flouest-dev-main/    the Flouest checkout
```

If Flouest has to live somewhere else, change both `"root"` in `Latex-Lib/flouest.lock.json` and `host.root` in `testing-pipeline/compat.config.json`. Change only the path, not the hashes.

## 2. Install

From the Flouest checkout, install the app's dependencies (esbuild and Playwright come from here):

```bash
cd ../StartUp/Flouest-dev-main/app && npm ci
```

From this repository:

```bash
cd Latex-Lib && npm ci
```

```bash
cd testing-pipeline && npm ci
```

## 3. Check everything is in place (nothing compiles)

Run these from the folder each one names, and compare with the results expected here. Each one passed on the old machine on 2026-10-30.

| Folder | Command | Expected |
|---|---|---|
| `Latex-Lib` | `npm test` | 45 tests pass (`test/snapshots/ways.json` holds the LaTeX every preset prints) |
| `Latex-Lib` | `npm run check` | no errors |
| `Latex-Lib` | `npm run verify` | `library: 110 handlers, 46 class profiles, 68 package facts`, then `verify: ok` |
| `Latex-Lib` | `node cli.ts solutions` | 210 checks: 118 picked as they are, 8 renamed, 3 by fallback, 80 under a class with no profile, 1 under jlreq |
| `Latex-Lib` | `node cli.ts ways` | every node with its ways |
| `testing-pipeline` | `npm test` | 94 tests pass (core alone, with fakes) |
| `testing-pipeline` | `node host-flouest/typecheck.mjs` | exits 0 |
| `testing-pipeline` | `npm run compat -- run --classes article --setups A --library --plan-only` | `plan 12,330 branches`, `same tree yes`, 867 branches holding a library way (only theorem ways today, see 4b); compiles nothing |

If `verify` reports `flouest: … changed since the pin`, the copied Flouest differs from the one the library was built against. Find out what changed before going on.

## 4. What the matrix covers today, and what to add first

Running "every handler under every class" needs two additions. Neither is built yet.

### 4a. A class setting for every class profile

`Latex-Lib/classes/` has 46 profiles. The pipeline compiles only under the class settings in `testing-pipeline/settings/classes/`, and there are 17 of those, covering 14 classes: article, amsart, book, report, beamer, memoir, scrartcl, scrbook, scrreprt, llncs, acmart (manuscript, sigconf), elsarticle (preprint, 5p), IEEEtran (conference, journal) and revtex4-2. These 32 profiles have no setting yet:

a0poster, aa, aastex, amsbook, amsproc, cas-dc, cas-sc, ctexart, ctexbeamer, ctexbook, ctexrep, easychair, exam, extarticle, extbook, extreport, iopjournal, jlreq, letter, lipics, ltxdoc, mdpi, minimal, mnras, moderncv, proc, scrlttr2, siamart, sn-jnl, tikzposter, tufte-book, tufte-handout

jlreq does not run in ZeroTeX-NG (its profile says `zerotex: 'no'`), so it can be skipped.

**Add a setting** as one JSON file per setting in `testing-pipeline/settings/classes/`, named by its id:

```json
{
  "id": "siamart",
  "description": "SIAM's siamart.",
  "class": "siamart",
  "options": [],
  "preamble": [],
  "files": []
}
```

- Add `"setups": ["A"]` for a class that is two columns already, or that has no two-column mode. Setup B adds `twocolumn` (`settings/setups.json`).
- A class the engine's mirror doesn't have (MDPI's, for example) goes in `settings/classes/files/`. Copy its `.cls` (and any `.sty` or `.bst` it loads) from the template's folder under `Latex Related Research/Latex-lib-main/Source/<id>/`, then list each file as `{ "path": "mdpi.cls", "sha256": "<64 hex>" }`. The probe says when a class isn't found.

**Probe them:**

```bash
cd testing-pipeline && npm run compat -- probe
```

```bash
cd testing-pipeline && npm run compat -- probe --setup B
```

Each profile is written to `testing-pipeline/out/profiles/<setting>.<setup>.json`. Copy what it measured into the matching `Latex-Lib/classes/<id>.ts`: `zerotex` (`"yes"` once it loads), `preloads`, `defines`, `forbids.technical` and `layout`. Add a `{ kind: 'compile', cell: 'testing-pipeline/out/profiles/<setting>.A.json' }` evidence entry, the same way `classes/article.ts` does. Then run `npm run verify` and `npm test` in `Latex-Lib`.

On the old machine, 12 settings with 25 compiles each took 92 seconds.

### 4b. Every node's handlers in the binding

`testing-pipeline/host-flouest/src/latexLib.ts` turns the library's handlers into plug-in ways for the matrix (`compat run --library`). Today its `PLUGGED` table has one entry, the theorem node (`containerBlock/mathElement`), and it uses each way's first preset only.

To test every node:
- Add one `PLUGGED` entry per node, with the node's `HANDLERS` from `Latex-Lib/nodes/<node>/index.ts`. All 32 nodes have one.
- Give each preset a variant of its own, not just the first.

The family and kind each node plugs in as come from Flouest's registry (`JSON->Latex Compiler/src/Profile/Profile_General/*/index.ts`). Flouest's `checkPlugins` refuses a wrong one with a sentence saying why.

| Library node | Flouest family | Kind |
|---|---|---|
| `containerBlock/<x>` (abstract, acknowledgement, appendix, blockMath, columns, customLatex, listing, mathElement, note, refContainer) | `containerBlock` | `<x>` |
| `code/code` | `containerBlock` | `code` |
| `table`, `table_row`, `table_cell`, `table_header` | `containerBlock` | the same name |
| `paragraph/<x>` (heading, title, paragraph, lstParagraph, mathPara, refPara, customLatexPara) | `Paragraph` | `<x>` |
| `atomicBlock/<x>` (image, pageBreak, tableContents) | `blockAtom` | `<x>` |
| `cite/cite`, `hyperlink/hyperlink`, `codeEscape/codeEscape`, `customLatex/customLatex`, `inlineMath/inlineMath`, `ref/ref` | `inlineAtomic` | `cite`, `hyperlink`, … |
| `footnoteAnchor/footnoteAnchor` | open question | Flouest refuses a plug-in at `inlineAtomic/footnoteAnchor` (only that handler's preamble is read; the emitter writes the footnote itself). The footnote ways need the `containerBlock/footnote` handler or another route, so read `JSON->Latex Compiler/src/Plugins/plugins.ts` first. |

After the change:
- run `node host-flouest/typecheck.mjs`;
- run `npm run compat -- run --classes article --setups A --library --plan-only`, to see how many branches and documents the plan makes before compiling any;
- update `testing-pipeline/ARCHITECTURE.md` (section 3 and step 7 of section 10).

The plan grows fast: every preset of every way of every node, nested to depth 2. If it is too big, go node by node, or use `--depth 1`.

## 5. Run the tests

Run each long command in the background, from `testing-pipeline/`. Every compile goes through the store (`testing-pipeline/out/`, not committed). So a stopped run picks up where it stopped, a second run compiles nothing, and a change recompiles only the documents whose LaTeX it changed.

| Order | Command | What it shows |
|---|---|---|
| 1 | `npm run compat -- oracle` | The engine and the judge work: 14 seeded cases with known outcomes, about 10 s. Run it first; the first run also sets up the engine. |
| 2 | `npm run compat -- probe` (then `--setup B`) | Step 4a |
| 3 | `npm run compat -- stability` | The acceptance test: adding a dummy way recompiles only the documents holding it |
| 4 | `npm run compat -- run --classes article --setups A --library` | One class first, to see the compile rate |
| 5 | `npm run compat -- run --library` | Every class setting and setup. On the old machine, General alone under 19 pairs took 36 min (1,938 cells), plus 14 min of solo branches. With every handler and preset it will be many times that. |
| 6 | `npm run compat -- explain --library --limit 300` | Failures grouped, the biggest groups explained, candidate rules with reproducers in the review queue, compat tables in `out/compat/`. On the old machine, 300 groups took 28 min. |
| 7 | `npm run compat -- review` | List the candidates. Then `--show <id>` writes the reproducer as `.tex`; decide each with `--accept <id> --why "…"` or `--reject <id> --why "…"`. |

`--classes id,id` and `--setups A,B` narrow any command. In the store, `results/`, `engine-cache/`, `artifacts/`, `latest/` and `compat/` are always safe to delete. Keep `ledger.jsonl`, `manifest.jsonl`, `review.jsonl`, `documents/` and `review/`; they are the history.

## 6. Bring the results back into the library

- **An accepted parent rule** goes on that way's key as an authored rule, with the reproducer as its evidence (`ARCHITECTURE.md` section 4.3). Then, in `Latex-Lib`, run `npm run generate` (which rewrites each handler's `compat.generated.json`), `npm run verify` and `npm test`.
- **A class rule** goes on the key (`classes.deny`, or `classes.only` for a class-native way) or in the class profile's `forbids.technical`.
- **A defect in a way alone** (it fails solo under `article` with setup A) is fixed in its `handler.ts`. Then run `UPDATE_SNAPSHOTS=1 npm test` and check the snapshot diff.
- **Docs:** update the status line at the top of `ARCHITECTURE.md`, section 5 (how many profiles are measured), and the "Where it stands" paragraphs of M1 and M3 in section 11.
- **What gets committed:** the changed keys, class profiles, class settings, compat tables and docs. Never `testing-pipeline/out/`.

What M1 and M3 still need, as `ARCHITECTURE.md` section 11 says:
- every preset compiled in the matrix;
- the parent rules and context needs the matrix finds;
- a Solution check for each node, like the theorem pilot's `node cli.ts solutions`.
