# Compatibility test pipeline: global architecture

**Status: steps 0 to 6 are built.**
- `core`: model, ports, identity, the stage graph, stores, config
  loading with class files, the plan (split tree with stable ids, solo
  branches), the append-only filer (grouped by what branches require, with
  document limits), the runner and a document's cells, the ledger, the oracle
  (log reader, damaging warnings, shipout sentinels, feature probes), where a
  failure comes from, the explainer with its review queue, the compat tables,
  and the class probe, with 94 tests on fakes.
- `host-flouest`: the Host port over Flouest's General (nesting,
  variants, building with sentinels, packing with a bibliography where cited,
  emitting, plug-in ways), General's package methods as the interim library,
  the engine adapter over Flouest's `openEngines` (class files included), a
  scan of what General's LaTeX asks of a class, and the commands of section 8
  (`run`, `explain`, `review`, `stability`, `probe`, `oracle`), all run on the
  app's ZeroTeX-NG.

Step 7 is still design. This document replaces the earlier
`TEST-PIPELINE.md`. The handler library it tests is described in
`../ARCHITECTURE.md`. Section 4.6 there says how the rules are found, section 5
covers class profiles, and section 9.3 says what a harness must do.

---

## 1. What the package is

An independent package that answers one question: **under each class setting,
does every legal nesting work, with every handler each node can use?** It
writes the answer back as verdicts the handler library can read.

It does **not**:
- define nodes or nesting;
- emit LaTeX;
- run TeX itself.

A **host** supplies those through interfaces (ports). Flouest is the first
host. The package knows nothing about ProseMirror, Flouest's compiler or the
app.

### The independence rule

```
            depends on
  host-flouest ─────────▶ compat-core ◀───────── (any other host)
       │
       └──────▶ Flouest (editor, compiler, engine runner)
```

- **`compat-core`** has no import from Flouest, no runtime dependency, and no
  knowledge of any node kind. It can be built, tested and published on its own.
- **`host-flouest`** is the only code that touches Flouest. It implements the
  ports. It lives here during incubation and moves into Flouest later. Flouest
  then depends on `compat-core`, never the other way round.
- **The handler library** (`../lib`) is reached through the `Library` port, both
  for reading ways and for writing verdicts back. It is a separate package too.

The test of this rule: core's own test suite runs with a fake host and a fake
engine, with no Chrome and no Flouest.

---

## 2. Vocabulary

| Term | Meaning |
|---|---|
| **Node** | A host node identity, e.g. `containerBlock/mathElement`. Core treats it as an opaque string. |
| **Place** | A legal position: the chain of nodes from the document down. The host decides legality. |
| **Way** | One way of emitting a node (`thm.amsthm`), from the library. |
| **Preset** | Fixed settings for a way. Parameters marked `compat` split variants; the rest rotate. |
| **Variant** | Way × compatibility parameters × the host's true/false settings for the node. |
| **Branch** | One root-to-leaf path of the split tree, each node at a variant and member. Its id is a hash of its contents. |
| **Class setting** | A class, its structural options, its preamble lines and its files. Data, not code. |
| **Setup** | A fixed document-level choice: A default, B the other column mode, C strict settings (later). |
| **Document** | A filed set of branches compiled together. Its id is a hash of its contents. |
| **Cell** | Class setting × setup × document. The unit that is compiled and cached. |
| **Verdict** | The result for a branch in a cell: pass, or fail with the check that failed and its evidence. |

---

## 3. Package layout

```
testing-pipeline/
  ARCHITECTURE.md        this document
  package.json           npm workspaces core and host-flouest; `npm test`, `npm run check`, `npm run compat -- <command>`
  compat.config.json     this workspace: where the settings and the store are, engines, and the host's own section
  settings/              what is tested under (data)
    classes/             class settings, one JSON file each, named by id; 12 pilot settings
    classes/files/       files a class setting names that the engine cannot fetch, checked by SHA-256
    setups.json          A, B (C later)
  out/                   the store (section 7), not committed
  core/                  compat-core: independent of any host
    src/
      index.ts           what core exports
      model.ts           the types in section 2
      ports.ts           Host, Engine, Library, Store (section 4)
      hash.ts, ids.ts    canonical JSON and sha256; ids for branch, document, cell, result
      stage.ts           stages, their inputs and keys; what is stale (section 6)
      fsStore.ts         the file-system store; memoryStore.ts the in-memory one; storeKeys.ts the key rules
      config.ts          compat.config.json, class settings, setups: read and checked before any compile
      plan.ts            the split with stable ids, cover top-up, solo branches; pair coverage and context grouping later
      file.ts            append-only filing within the host's document rules, limits and requirements
      cells.ts           a document's cells under each class setting and setup, with what the oracle expects
      run.ts             the store first, then the Engine port; same LaTeX, one compile; no timers
      log.ts             the log reader; warnings.ts which warnings damage; sentinels.ts, features.ts their probes
      oracle.ts          a branch's verdict in a cell
      origin.ts          where a failure comes from: the way alone, the class, the document or the nesting
      classProbe.ts      the class probe and its profile
      ledger.ts          the ledger and a run's summary; compat tables and reports later
      explain.ts         failures grouped; halving, shortest chain, parent flips, fallbacks: a candidate rule with
                         its reproducer; trials through the store; the review queue
      compat.ts          each way's compat table: what the matrix verified under each parent, accepted rules
    test/                one *.test.ts per area, the fakes (fakeHost.ts, fakeEngine.ts, fakeLibrary.ts, fakeRun.ts)
                         and the acceptance test (stability.test.ts); node:test
  host-flouest/          the Flouest binding: Host, Engine and an interim Library over Flouest
    compat.mjs           the command line: bundles a command with Flouest's esbuild and tsconfig, and runs it
    typecheck.mjs        type-checks the binding under Flouest's own tsconfig and TypeScript
    commands/            one file per command (section 8): run, explain, review, stability, probe, oracle
    src/
      engine.ts          Engine over Flouest's openEngines, identical to production; one file set at a time
      host.ts            Host: nesting, variants, building with sentinels, requirements, packing, emitting, document rules
      classLine.ts       the class line and preamble swapped for a class setting's
      plugins.ts         plug-in ways through the app's compile path, as a template registered for the run
      ways.ts            General's package methods as ways, their looks as presets
      latexLib.ts        the handler library's ways (../Latex-Lib) as plug-in ways, behind --library
      dummy.ts           the dummy theorem way for the acceptance test
      surface.ts         what General's LaTeX asks of a class: package lines, defined and redefined names
      workspace.ts       what the commands share: config, settings picked by --classes and --setups, the store, the engine
      subject.ts         General to a depth, its ways, the host, the plan
      matrix.ts          file, emit, compile, judge, record; failing branches typeset alone
      solo.ts            the solo baseline under every class setting and setup
      report.ts          what the commands print
      quiet.ts           Flouest's console lines held back
```

**Tooling.** TypeScript, Node 22.18 or later, ESM. Node runs core's sources as
they are (type stripping), so core needs nothing installed to run its tests
(`npm test`). The rules that follow from that: erasable syntax only, `.ts` in
every relative import, `import type` for types. `tsc` only type-checks
(`npm run check`, after `npm install` for TypeScript). Core uses `node:test`
and has no runtime dependencies.

`host-flouest` is bundled with Flouest's own esbuild and tsconfig, as Flouest's
dynamic tests are, so Flouest's imports resolve exactly as they do in the app.
Two names resolve in the bundle: `compat-core` (core's sources) and
`@flouest/<path>` (a file of the checkout). Its `check` writes a throwaway
tsconfig that extends Flouest's, then runs Flouest's TypeScript on it.

Every command runs from the workspace folder:

```bash
npm run compat -- run --classes article --setups A
```

---

## 4. The ports

These four interfaces are the whole surface between core and the outside.

```ts
/** What a host knows: its nodes, its legality, its documents, its LaTeX. */
interface Host<D = unknown, P = D> {           // D: a filed document, P: one branch as built; both opaque to core
  readonly id: string;
  /** Changes when the host's nesting, settings or emission may have changed. */
  fingerprint(): string;

  /** Every legal place down to `depth`, as the host's own rules decide it. */
  nesting(depth: number): NestingTree;
  /** A node's variants under these ways, each with its members as the host holds them, ordered so the first `cover` show every value. */
  variants(node: NodeId, ways: readonly Way[]): HostVariant[];   // { variant, members: { values, needs? }[], cover }

  /** One branch, built around its leaf, with content probes and sentinels placed. */
  /** `probes.sentinel(id, { outside?, role? })` gives the LaTeX and records the sentinel, so the oracle expects it. */
  build(branch: BranchSpec, probes: { sentinel(id: string, options?: { outside?: boolean; role?: string }): string; marked: boolean }): P;
  /** What filing must respect: one title per document, appendices last. */
  documentRules(): DocumentRules;
  /** What the branch needs its document to hold (`bibliography` for a citation): it is filed only with branches that need the same. */
  requires(branch: BranchSpec): string[];
  /** Several built branches, in the order filed, as one document: paired footnotes, unique labels. */
  pack(parts: readonly P[]): D;

  /** The document's LaTeX under a class setting and setup, each node emitted by the way its branch binds. */
  /** `under.preamble`: lines core needs right after the class's own (the sentinel macro). */
  emit(doc: D, under: { classSetting: ClassSetting; setup: Setup; preamble: string[] }): Emitted;
}

type Emitted = {
  latex: string;
  /** Each branch's line range in `latex`, so a TeX error line names its branch. */
  spans: { branch: BranchId; from: number; to: number }[];
  files: { path: string; bytes: Uint8Array }[];
};

/** What compiles. */
interface Engine {
  /** Changes when the engine build, its format, its package snapshot or its options change. */
  fingerprint(): string;
  /** `job.id` is for tracing: every job is typeset under one fixed job name, so the id never reaches TeX. */
  compile(job: { id: string; latex: string; files: Emitted['files'] }): Promise<RawResult>;  // log, pages, ms, threw?
  close(): Promise<void>;
}

/** The handler library: the ways and their keys in, the verdicts out. */
interface Library {
  nodes(): NodeId[];
  ways(node: NodeId): Way[];                   // id, presets, compat params, loads, defines, gives/needs
  /** Changes when the way's emitted LaTeX may have changed (handler and presets, not prose). */
  fingerprint(way: WayId): string;
  writeCompat(table: CompatTable): void;       // the table names its way
}

/** Where results live. The file-system store is the default. */
interface Store {
  get(key: string): Json | undefined;          // keys are plain path segments: results/<hash>
  put(key: string, value: Json): void;
  append(log: string, line: Json): void;       // ledger, manifest
  read(log: string): Iterable<Json>;           // a line at a time: a log outgrows any one string
}
```

Who does what in the Flouest binding:

| Port method | Flouest implementation (built in step 4), reusing the dynamic tests |
|---|---|
| `nesting` | the editor's own normalizers settle each path (`nesting.ts`) |
| `variants` | the variants and members `variants.ts` finds by settling and compiling every combination: a General way's are Flouest's variants of its package set; a plug-in way's are the node's combinations with no look picked. A member the editor keeps only under one parent combination carries `needs`. |
| `build` | Flouest's branch builder on the branch's own path (`filing.ts`, `marks.ts`, `escapes.ts`, `samples.ts`), then footnote pairing. A sentinel goes in as a raw-LaTeX inline node at the end of the deepest plain paragraph; inside a margin note it is placed as outside; a branch with one footnote also places the note's mark and text. Paragraph marks start from a value the branch id picks. |
| `documentRules` | one title per document, appendices last, asked of the app (`hasTitle`, `isAppendix`); at most 26 appendices to a document, since the class letters them with `\Alph` |
| `requires` | `bibliography` for a branch that, as built, cites (in its text or in a caption) or holds a reference container |
| `pack` | Flouest's filer body: blocks in the text, then notes; settled; labels made unique by the branch's place in its document (`labels.ts`). A document that cites ends its text with a reference container holding an entry for each key it cites, owned by no branch: Flouest's samples cite a key none of them defines. |
| `emit` | `docJsonToLatex`, then the class line and preamble swapped for the class setting. A node bound to a plug-in way gets that way's style, and the plug-ins go in through a template registered for the run (`plugins.ts`). Spans as Flouest's `branchLines` finds them, computed only when the oracle asks. |
| `Engine.compile` | `openEngines` (`engine.ts`), unchanged |
| `Library` (interim) | General's package methods as ways (`general:<node>:<packages>`), their looks as presets, plus plug-in ways; with `--library`, the handler library's ways (`../Latex-Lib`, `latexLib.ts`), each as a plug-in with its first preset and its parents' adapts. `writeCompat` writes a library way's table beside its handler (`matrix.generated.json`), which the library merges into its `compat.generated.json` |

`variants` replaced the earlier `settings(node)`. A node's settings alone
cannot say which combinations the editor keeps, which exist only under one
parent's values (a list item's term), or how a look or preset lands on them.
Flouest learns all three only by settling and compiling, so the host hands core
the members, and core keeps everything about position: the split, the member
picks, the top-up and the ids.

What moved into core, because it knows no kind: the split (`splitting.ts`,
rewritten with stable ids, in `plan.ts`), the packing logic in `filing.ts` (in
`file.ts`), and the log reader (`readLog`, `shapeOf` from `texlog.ts`).

---

## 5. Data flow

```
 classes/*.json ─▶ [probe] ─▶ class profiles ─────────────────────────────┐
                                                                          │
 Library.ways ──▶ [solo] ──▶ solo verdicts                                │
       │                                                                  ▼
       └──────┐                                                     [explain]
              ▼                                                          ▲
 Host.nesting ─▶ [plan] ─▶ branch set ─▶ [file] ─▶ documents ─▶ [run] ─▶ results ─▶ [judge] ─▶ verdicts ─▶ [record]
 Host.variants ─┘   ▲        (stable ids)   (append-only)   × class settings   (Engine,        (oracle)        │
 setups.json ───────┘                                       × setups           cached)                        ▼
                                                                                        ledger · compat tables · reports
```

1. **probe**, once per class setting. Does it load, what does it preload, which
   handler names does it already define, and what is its layout. Then one load
   test per package the library uses. This gives the class profile.
2. **solo** (built in step 5). Each variant of each node alone, in a document
   of its own: at the node's shallowest place, each node above at its first
   variant, its first member that sits there, once with the marked runs and
   once with the escape run (`soloBranches`). Compiled under every class
   setting and setup. What a solo branch fails, its way fails wherever it sits.
3. **plan.** Variants from the library and the host's settings. The split tree
   over the nesting, below each parent by context group, with sampling. Each
   branch gets a stable id. Pair coverage across nodes.
4. **file.** Branches not yet in the manifest go into new documents, within the
   host's document rules. Branches that need different things of their
   document (a bibliography) never share one, so only documents that cite load
   a bibliography. A document holds no more branches holding a node than the
   rules' limits allow (26 appendices, lettered A to Z). Filed documents never
   change.
5. **run.** For each cell, the store first, then `Engine.compile`, in parallel,
   with no timers.
6. **judge.** The checks in order: errors, damaging warnings, sentinels, feature
   probes. Errors and warnings are tied to branches through `Emitted.spans`
   and the line the log names. What can't be tied to one branch (a preamble
   error, a missing glyph, a page that overflowed) fails every branch of the
   document with a `:document` suffix, until the explainer separates them.
   Sentinels expected are the ones the host placed (`recordingProbes`).
   Sentinel order is recorded but not judged. A change to the oracle bumps
   `ORACLE_VERSION`: saved results are judged again and nothing compiles.
   Then each failing check is given an origin (`origin.ts`): new under
   the class or setup (the branch passes it under `article` with setup A);
   the way's own (a solo branch of one of its steps fails it too); the
   document's (not tied to one branch); or the nesting's. A failure that is a
   way's own defect is so counted once, not against every place the way sits.
7. **explain** (built in step 6). Failures are grouped by check, the shape of
   the evidence, the pair they are new under (or the reference) and, when tied
   to a branch, its chain and leaf way. A failure the way shows alone is its
   solo branch's: a defect, or a class rule, with no trial. A failure not tied
   to a branch is first tried on a document holding none (`base`: the host's
   own preamble under that class). One branch stands for every other group:
   alone, or halved down to the fewest companions that
   bring the failure back (two give a combination rule, more a limit); then
   the shortest legal chain that still fails, the parent's other variants and
   members (its `when`), the child's other variants (a fallback, else deny),
   and, under another class, the reference (the rule is then that class's).
   Trials are documents of their own (`documentOf`), compiled through the
   store. The result is a candidate rule with a minimal reproducer, which goes
   to the review queue. Adapts and dropping one package wait for the library's
   keys.
8. **record.** The ledger, then `Library.writeCompat` for each touched way, then
   a report. Recording never compiles anything.

---

## 6. Identity and incremental runs

Everything is addressed by content, so growing the library never means
testing it all again.

**Ids:**
- branch: a hash of each node on its path (node, way, variant key, member);
- document: a hash of its branch ids and the host document rules version;
- cell: document id × class setting × setup;
- result: the hash of the emitted LaTeX, its files and the engine fingerprint.

Nothing is numbered by position. Today's dynamic tests number branches in order,
rotate members through one counter, put the branch number in labels, and file
runs of consecutive branches. So one inserted variant shifts every document
after it. Here (built in step 4):
- the member a node takes is a hash of the branch's path above it, the node
  and its variant, among the members that fit the parent (`plan.ts`);
- whether a branch gets marked runs or the escape run is read from its id
  (`markedOf`), and so is where its paragraph marks start;
- a label's suffix is the branch's place in its document, which never changes
  once filed;
- new branches are filed into new documents; a filed document never changes
  (`file.ts`).

Cover top-up branches guarantee every member of each cover is still shown: the
node alone at its shallowest place, each node above at its first variant. A
top-up depends only on its own member, so it keeps its id too. When a new way's
branches take a member that was topped up, that top-up leaves the plan, and its
document stays filed and is used while it holds a branch of the plan.

**Stages as a build graph.** Each stage's output is stored under a hash of its
inputs. `compat status` lists what is stale and why.

| Stage | Key inputs |
|---|---|
| probe | class setting, engine fingerprint, the library's package and name lists |
| solo | way fingerprint, preset, engine fingerprint |
| plan | host fingerprint, every way's fingerprint and compat params, setups, depth |
| file | branch set minus the manifest (append-only) |
| run | per cell: emitted LaTeX, files, engine fingerprint |
| judge | result, oracle version |
| record | verdicts, way keys |

**What a change reruns:**

| Change | Compiles |
|---|---|
| New way W | Solo for W; a name probe per class setting if W defines new names; only the branches containing W, in new documents; pair documents for W. Every old document comes from the cache. |
| New preset | A new variant if its compat parameters differ. Otherwise solo, plus top-up branches to show it. |
| Edited handler | Only documents containing it, because their LaTeX changed. |
| Edited key prose or rules | Nothing; `record` reruns. |
| New class setting | Its probe, plus a full run under that class only. |
| Host change | Only documents whose LaTeX changed. |
| Engine or snapshot change | Everything. |
| Oracle change | Nothing compiles; `judge` reruns from saved results. |
| Removed way | Nothing; its documents drop out (they hold only its branches). |

**Acceptance test:** add a dummy way and check no old document compiles. Remove
it and check the ledger is back to how it was. Core's suite checks both halves
with the fake host, core's own plan and filer (`test/stability.test.ts`), and
`compat stability` checks them on Flouest with a plug-in theorem way
(step 4).

---

## 7. The store

```
out/
  results/<hash>.json.gz              each compile's raw result, keyed by engine fingerprint + LaTeX + files (`run.ts`)
  engine-cache/                       Flouest's runner's own result cache (the adapter checks it before compiling)
  artifacts/<stage>/<key>.json.gz     stage outputs: probe profiles, explanations (artifacts/explain/)
  latest/<stage>/<instance>.json.gz   the key each stage instance last ran with (`stageStatus`)
  documents/<id>.json.gz              each filed document with its branches' paths, so it is built again exactly as filed (`file.ts`)
  manifest.jsonl                      append-only: document id → branch ids in order, and the rules version it was filed under
  ledger.jsonl                        append-only: one line per cell per run (ids, keys, status, checks, timings, cached?);
                                      each verdict holds its own failures, and the document's are written once
  review/<id>.json.gz                 candidate rules with their reproducers (`compat explain`); review/<id>.tex a reproducer to read
  review.jsonl                        append-only: each decision a person made on a candidate
  compat/<way>.json                   each way's compat table, until ../lib holds them beside each handler
  profiles/<class>.<setup>.json       each class setting's profile, for reading (the stage output is in artifacts/probe/)
  reports/<run>/                      summary.txt and per-node tables
  _shared → Flouest out/_shared       Chrome profiles: the engine's format and fetched packages
```

Deleting `results/`, `engine-cache/`, `artifacts/`, `latest/` or `compat/` is
always safe: they are rebuilt from inputs. The `.jsonl` files, `documents/` and
`review/` are history and are kept: deleting the manifest and `documents/`
together files everything again, in new documents.

The engine adapter links `out/_shared` to Flouest's
`Template/test/dynamic-testing/out/_shared` the first time it runs, so the
engine's format and every package it has already fetched are reused. Because
the Chrome profiles are shared, Flouest's dynamic tests and this pipeline
shouldn't run at the same time.

---

## 8. Commands

`npm run compat -- <command> [options]`, from the workspace folder.
`--classes id,id` and `--setups A,B` pick what to run under: every class
setting and every setup that applies to it, unless picked.

| Command | Does | Status |
|---|---|---|
| `compat run [--classes] [--setups] [--depth 2] [--size 64] [--library] [--plan-only]` | plan → file → run → judge → record, with the solo baseline and where each failure comes from; failing branches typeset alone; incremental | built (step 5) |
| `compat stability [--classes article] [--setups A]` | The dummy-way acceptance test (section 6) | built (step 4) |
| `compat probe [--classes] [--setup A]` | Runs class probes | built (step 3) |
| `compat oracle [--only name,name]` | The oracle on seeded cases with known outcomes | built (step 2) |
| `compat status` | Lists stale stages and the reason for each | later |
| `compat explain [--classes] [--setups] [--library] [--limit 1000] [--groups]` | The matrix and solo branches (from the store), failures grouped, the biggest groups explained, candidates into the review queue, compat tables written | built (step 6) |
| `compat review [--all] [--show id] [--accept id] [--reject id] [--why text]` | The review queue: list, show a candidate with its reproducer as `.tex`, decide | built (step 6) |
| `compat report` | Writes the reports from the ledger | later |

Step 1's smoke check is now part of `compat run`: one document under several
class settings, a second run compiling nothing.

Every command reads `compat.config.json`. Paths resolve against its folder.
Core reads `classes`, `setups`, `out` and `engines`. It passes `host` on
unread, because that section belongs to the binding.

```jsonc
{
  "classes": "settings/classes",
  "setups": "settings/setups.json",
  "out": "out",
  "engines": "default",
  "host": { "kind": "flouest", "root": "../../StartUp/Flouest-dev-main" }
  // later: "library", "depth", "documentSize"
}
```

---

## 9. Extension points

| To add | Touch |
|---|---|
| A way | The library only. Then `compat run` tests the new branches. |
| A class setting | One file in `settings/classes/`. Then `compat probe` and `compat run --classes <id>`. |
| A setup | `settings/setups.json` |
| An oracle check | A module in `core/judge/`, registered in its list. Bumps the oracle version, so judging reruns without compiling. |
| A host | A new binding implementing `Host`, `Engine` and `Library` |
| An engine | A new `Engine`, for example a standalone ZeroTeX runner without Flouest |

---

## 10. Build order

Each step ends in something that runs and can be checked.

| Step | Builds | Done when |
|---|---|---|
| **0** (built) | Workspace, `model`, `ports`, `identity`, `graph`; fake host and fake engine; the store | Core's suite passes with no Flouest and no Chrome. Ids are stable when a fake way is added. Result: 27 tests pass. With the fakes, one added way takes 129 branches to 203; the 34 old cells come from the store and only the 20 new cells compile. |
| **1** (built) | `run`, `record`, the Flouest engine adapter, the class registry | One document under three class settings is in the ledger. A second run compiles nothing. Result: General's paragraph + coloured-box theorem under `article`, `amsart` and `acmart[manuscript]` compiled in about 9 s. A second run compiled nothing and started no Chrome. Changing `amsart`'s options compiled only that cell. `acmart` already shows a finding for step 3: under XeTeX it loads `unicode-math`, and General's `mathtools` then warns that it should be loaded first. |
| **2** (built) | `judge`, with sentinel placement in `host-flouest` | Seeded bad cases fail, good ones pass, and sentinels behave in ZeroTeX. Result: 14 of 14 asserted cases right in about 10 s (`compat oracle`). Caught: a footnote lost in a `tabular`, a float in a box, an unbreakable box running off the page, text into the margin, a box typeset twice, a box never used, an undefined reference, a missing glyph. Passing: a paragraph, a footnote, a float, a breakable box over three pages, a margin note placed as outside. Found on the way: ZeroTeX leaves `\pdfpageheight` at 0, so XeTeX measured y against the shipped box plus 2in, not the paper. The sentinel preamble now sets it to `\paperheight` when unset, as `geometry` does. Observed, not asserted: a breakable tcolorbox inside a footnote compiles and prints under this engine's tcolorbox. |
| **3** (built) | `probe`, class files to the engine | Profiles for the pilot classes. Result: 12 class settings × (1 load probe + 24 load tests) = 300 compiles in 92 s. All 12 classes load. General asks for 24 package lines, 74 names it defines and 3 it redefines, read from 1,550 documents of General's LaTeX. **Refused:** `acmart` refuses `titlesec` ("An attempt to redefine \section detected"); `llncs` refuses `titlesec` and `amsthm` (`\proof` already defined); `revtex4-2` refuses `multicol`. **Objected to:** `memoir` (titlesec), KOMA `scrartcl` (titlesec, tocloft). **Name clashes:** `acmart` already defines theorem, lemma, corollary and definition; `llncs` defines those plus remark and has a `chapter` counter; `memoir` has a `chapter` counter. **Lacks:** `revtex4-2` has no `\contentsname`. A class only the workspace has (`compatdemo.cls`, in a scratch `classes/`) reached the engine. Found on the way: ZeroTeX's log cuts messages short of 79 characters, so messages are now joined until their context; `\@filelist` needs `\listfiles` before the class; REVTeX's two columns show only in the widths. `acmart` sigconf reads as one column, because it switches at `\maketitle`, which the probe doesn't call. |
| **4** (built) | `plan` and `file` in core; `nesting`, `variants`, `build`, `pack`, `emit` in `host-flouest`; plug-in ways | General under `article` covers what today's harness covers. The dummy-way test passes on the real host. Result (`compat run`, `compat stability`): at depth 2 the plan has 3,633 branches. 3,552 are exactly Flouest's split tree, node by node and variant by variant, with none missing or extra; 81 are top-ups (Flouest needs 28). All 67 variants show every member of their cover. Planned in about 1 s, filed into 81 documents of up to 64. 47 of them cite or hold a reference container and get a bibliography; the other 34 load none. A rerun compiles nothing, and a host change that touched only footnote branches recompiled only the documents holding them. **Dummy way:** a plug-in theorem way added 875 branches, all holding it, filed into 17 new documents; only those compiled, and the 81 old ones came from the store. 8 top-ups left the plan because the new branches showed their members. Removed again: nothing filed, nothing compiled, every old cell's ledger line as before. **Against today's harness:** of the 218 branches with a TeX error in their document, 8 fail alone, all `mathElement` "missing \item" (Flouest's run found the same 8). The rest fail only in company, mostly "Counter too large" from too many appendices in one document. Flouest's runner learns such limits (`limits.ts`); filing respects them from step 5. A heading with an underline mark breaks `soul`. Alone, that is caught; in the shared document the log's line fell on a neighbouring branch, which is the explainer's job (step 6). **The oracle on real documents:** 1,238 of 3,633 branches pass. Before each citing document got its bibliography, only 575 passed, because Flouest's samples cite a key none of them defines; no citation is undefined now. Most of the rest fail on overfull lines from a real General defect, where a font-family mark prints as `{\fontfamily{phv}\selectfont  arial}` and TeX drops the space, so words run together. Also real: content nested in a reference container is written into the `.bib` file and never typeset. Calibrating this is step 5's first task. |
| **5** (built) | `solo`; the oracle calibrated on General (document limits in filing, a solo baseline so a way's own defects are not counted against every nesting); the full runs | General × pilot classes × setups A and B are in the ledger, and a failure names what the class or the nesting changed. Result (`compat run`): the 102 documents (59 with a bibliography) under all 19 class settings and setups, 1,938 cells, compiled in 36 min. The 134 solo branches (each variant of each node alone, marked and not) took 2,546 cells in 14 min. **Limits:** at most 26 appendices to a document, since General emits `\appendix` once and the class letters them with `\Alph`. "Counter too large" is gone: under `article` 18 branches stop at an error, not 218, and the 8 that fail alone are the `mathElement` "missing \item" ones. **Origins** (`judge/origin.ts`, each failing branch by its worst check): under `article` with A, 2,144 branches fail; 1,164 only as their ways fail alone (43 of the 134 solo branches fail), 639 on what the log could not tie to one branch, 341 from the nesting. The nesting's commonest are overfull lines in tables, `mathElement`, listings and images, and a footnote's mark and text on different pages in tables. **Classes:** branches passing, of 3,633: `article` 1,489 (A) and 1,086 (B), `scrartcl` 1,438 and 539, `amsart` 1,429 and 700, `memoir` 675 and 499, `elsarticle` 509 to 537 (390 with B), IEEEtran 227 and 241, `llncs` 229 and 113, `revtex4-2` 125, `acmart` 6 to 16. A few clashes in the preamble explain most of it, and each fails every branch of its document. `acmart`, `elsarticle` and `revtex4-2` load `natbib`, and General's cite way loads `biblatex`, which refuses it: every citing document fails, while the 43 that load no bibliography escape. Under XeTeX `acmart`'s fonts have no math glyphs (`𝑎`, `≤`), and its running head stops at `\ACM@linecountL \shorttitle`. `memoir` has no `\setstretch`, already has `\c@chapter`, and lacks `tocloft`'s `\cfttoctitlefont`. `titlesec` refuses KOMA's and `elsarticle`'s sectioning ("No format for this command"). `llncs` already has `\proof` and `\c@chapter`. IEEEtran has no `part` or `subparagraph` counter. Until the explainer (step 6) separates such a document's branches, a clash counts against all of them. **Ledger:** one full run made a ledger of 680 MB, with lines up to 9 MB. Every verdict carried each document-wide failure again (a missing glyph 1,197 times, in each of 64 branches), and the store read a log into one string, past what Node holds. Verdicts now hold their own failures, the document's are written once (`problems`), and logs are read a chunk at a time. The next 324 lines took 6 MB, about 19 KB a line where the full run's averaged 220 KB. **Dummy way, again** (`compat stability`): under the new rules it was filed into 18 documents, and only 3 compiled. The other 15 have the same LaTeX as documents compiled under the old rules, and results are keyed by LaTeX. So the check now asks that nothing compiles outside the new documents, not that every new one compiles. |
| **6** (built) | `explain`, `writeCompat`, the review queue | Each failure has a reproducer and a candidate rule. Result (`compat explain --limit 300`, `compat review`): the 19 pairs' failures fall into 6,360 groups. 6,071 are new under a class (59,924 branch verdicts), 287 come from the nesting (448) and 2 are document-wide under the reference (759). Another 3,467 failures are solo branches', which are their own reproducers. The biggest 100 groups stand for 85% of the branch verdicts, 300 for 87% and 1,000 for 90%; the rest hold one or two branches each. The biggest 300 were explained in 28 min, with 4,750 trials and 2,758 compiles. None was left unexplained, and a second explanation runs no trial. They give 460 candidates: 39 defects, 274 class rules, 56 parent rules, 78 combinations and 13 limits. **Defects:** every `mathElement` way, the appendix, `multicol` columns and listings are too wide alone under `article` (75 to 255 pt): General's samples, not their nesting. **Class rules:** `mathElement` under IEEEtran asks for a `subparagraph` and a `part` counter it lacks; under `llncs` it defines `\proof` again; under `acmart` its maths has no glyphs. General's heading way defines `\c@chapter`, which `memoir` has. Every table way meets an `Extra \or` under `revtex4-2`. **Parent rules:** a margin note directly in any `mathElement`, or in an abstract under `memoir`, leaves labels changed. A colour table directly in an appendix runs off the page under `llncs` with setup B. **Combinations and limits:** page overflows under `llncs`, and `acmart`'s running head breaking (`\ACM@linecountL \shorttitle`) once three tables share its pages. A candidate's reproducer is a document of its own: the margin-note rule's is 60 lines, written by `compat review --show`. 64 compat tables are written to `out/compat/`. **Not separated yet:** the bibliography is the host's addition, so `biblatex` refusing `natbib` is charged to the first way whose sample cites (a `mathElement`'s header note). Many candidates rest on "labels may have changed", which may be the engine's pass count rather than a clash; that is the oracle's to calibrate. |
| **7** | Context grouping, with the theorem pilot's keys | The 7 theorem ways run, and sampling agrees with the grouping |

---

## 11. Decisions

- **How independent.** Core has no Flouest import. `host-flouest` is the only
  binding, incubated here and later moved into Flouest. A fully standalone
  pipeline that re-implements nesting and emission would test a copy, not
  Flouest.
- **Engine.** The first `Engine` wraps Flouest's `openEngines`, so compiles
  match production exactly. A standalone ZeroTeX runner is a possible second
  adapter, not a goal.
- **Ported, not edited.** The construction logic is ported into
  `host-flouest` and core, with stable ids. Flouest's own template tests keep
  ADR-199, ADR-206 and ADR-207 unchanged. In practice only what depended on
  position was ported (the split, the filing plan, the paragraph-mark counter,
  the label suffix); the host calls Flouest's nesting, variants, marks,
  escapes, branch builder, footnote pairing, labels and compiler as they are.
- **Plug-in ways.** The app takes plug-ins only from a constructed template,
  found by name. So the host registers one for the run, in memory: General's
  class and preamble, and each plug-in replacing a node's handler with
  General's plus the way's style. A node no way binds prints as in General, so
  adding a way leaves old documents' LaTeX unchanged (the dummy-way test).
- **Flouest's rules carried over.** No timers: a compile that never returns
  holds its engine until the run is stopped. Generated files are never edited
  by hand.
- **Names.** `compat-core` and `compat-host-flouest` are working names.
