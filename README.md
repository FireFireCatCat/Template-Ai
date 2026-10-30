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
| `testing-pipeline` | `npm run compat -- run --library --plan-only` | `under 70 class setting and setup pair(s)`, the four nodes not plugged in (4b), `plan 73,845 branches`, `same tree yes`; compiles nothing |

If `verify` reports `flouest: … changed since the pin`, the copied Flouest differs from the one the library was built against. Find out what changed before going on.

## 4. What the matrix covers

Both are built. What's left for this machine is the compiling.

### 4a. A class setting for every class profile

`Latex-Lib/classes/` has 46 profiles, and `testing-pipeline/settings/classes/` has a setting for every one except jlreq, which does not run in ZeroTeX-NG. That makes 48 settings (acmart, elsarticle and IEEEtran have two each) and 70 class-and-setup pairs. Setup B adds `twocolumn` (`settings/setups.json`), so a class that is already two columns, or has no two-column mode, has `"setups": ["A"]`.

Some notes on particular classes:
- **Class files copied in.** The engine's mirror may not have these classes, so their files are copied into `settings/classes/files/` from the research's template folders and checked by SHA-256:
  - aa, with `linenoaa.sty`;
  - iopjournal;
  - `siamart251216`;
  - MDPI, with its `Definitions/` folder, loaded as `Definitions/mdpi` the way its template does;
  - `aastex701`.
- **Class names that differ from the profile id:** lipics is `lipics-v2021`, and aastex is `aastex701`.
- **sn-jnl:** the research has no copy of `sn-jnl.cls`. If the probe says it isn't found, take it from the publisher's zip (named in Flouest's `Template/template-requirement/Springer_Nature_SN_Jnl.md`), add it to `files/` with its hash, and list it in `sn-jnl.json`.
- **ctex classes** use `fontset=fandol`, so the fonts don't depend on the platform.
- **moderncv** sets the classic style in its preamble, because it defines its sections only once a style is set.

Each setting is a guess until the probe has run. Fix any setting the probe shows to be wrong: its options, its files, or which setups apply to it.

**Probe them:**

```bash
cd testing-pipeline && npm run compat -- probe
```

```bash
cd testing-pipeline && npm run compat -- probe --setup B
```

Each profile is written to `testing-pipeline/out/profiles/<setting>.<setup>.json`. Copy what it measured into the matching `Latex-Lib/classes/<id>.ts`: `zerotex` (`"yes"` once it loads), `preloads`, `defines`, `forbids.technical` and `layout`. Add a `{ kind: 'compile', cell: 'testing-pipeline/out/profiles/<setting>.A.json' }` evidence entry, the same way `classes/article.ts` does. Then run `npm run verify` and `npm test` in `Latex-Lib`.

On the old machine, 12 settings with 25 compiles each took 92 seconds.

### 4b. Every node's handlers in the matrix

`testing-pipeline/host-flouest/src/latexLib.ts` turns the library's handlers into plug-in ways for the matrix (`compat run --library`). Its `PLUGGED` table holds 28 of the 32 nodes: 97 of the 110 ways, with all 305 of their presets. Each preset is a style of its own. `testing-pipeline/ARCHITECTURE.md` section 10, step 6b, has the details.

**What isn't plugged in, and why.** These 4 nodes, with 13 ways between them, are listed in `UNPLUGGED`, and `compat run --library` names them. Testing them needs a change in Flouest first.
- **`code/code`:** Flouest's emitter always prints code in General's `listings` style, whatever style the node names.
- **Inline maths:** always printed in `plain`.
- **References:** always printed in `href`.
- **Footnote anchors:** Flouest refuses a plug-in there.

**How presets are tested.** Making each preset a variant of its own gave 819,509 branches under one pair, because every parent's preset meets every child's. So the binding does what core's model says:
- only a way's `compat` parameters split its variants;
- its presets rotate over each variant's members;
- every preset is still compiled at least once.

That gives 73,845 branches filed into 1,567 documents per pair, plus 372 solo branches. A solo branch shows only one preset of its variant, so a failure that another preset shows on its own counts against the nesting until `explain` narrows it down.

**Bibliographies.** Flouest drops a reference list with no entries, and the test samples' lists are blank, so the only bibliography printed is the one the host adds to a document that cites. A library citation way prints only its command (`\citep`) and leaves the package to its reference list. So the two are paired by engine: `bib.natbib@cite` with `bib.natbib@containerBlock/refContainer`. Filing keeps engines in separate documents, and the document's bibliography is printed by that engine's reference-list way.

Way ids that several nodes share are named with their node in the matrix (`bib.natbib@cite`). Their compat tables are still written to the library's own folder.

**Run size.** About 110,000 document compiles over the 70 pairs, plus the solo branches. That works out to roughly 40 hours at the old machine's rate, and less with more engines. Start with one class (step 4 below) to measure the rate here.

## 5. Run the tests

Run each long command in the background, from `testing-pipeline/`. Every compile goes through the store (`testing-pipeline/out/`, not committed). So a stopped run picks up where it stopped, a second run compiles nothing, and a change recompiles only the documents whose LaTeX it changed.

| Order | Command | What it shows |
|---|---|---|
| 1 | `npm run compat -- oracle` | The engine and the judge work: 14 seeded cases with known outcomes, about 10 s. Run it first; the first run also sets up the engine. |
| 2 | `npm run compat -- probe` (then `--setup B`) | Step 4a |
| 3 | `npm run compat -- stability` | The acceptance test: adding a dummy way recompiles only the documents holding it |
| 4 | `npm run compat -- run --classes article --setups A --library` | One class first, to see the compile rate |
| 5 | `npm run compat -- run --library` | Every class setting and setup: 1,567 documents under each of 70 pairs. On the old machine, General alone under 19 pairs took 36 min (1,938 cells), plus 14 min of solo branches, so plan on about 40 hours at that rate. It can be split up with `--classes`. |
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
