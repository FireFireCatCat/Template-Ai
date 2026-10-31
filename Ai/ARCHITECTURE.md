# The AI layer: architecture plan

**Status: plan, 2026-10-29; A0 built 2026-10-31 (section 11). The rest is not built yet.**

The AI layer turns a template someone feeds in (a zip of LaTeX sources) into a
Flouest template: one `defineTemplate` call with the document class, a handler
plug-in for each node whose LaTeX differs from General's, and a report. It is
the automation of `../ARCHITECTURE.md` section 8, built on the handler library
(`../Latex-Lib/`).

One step is the model's: reading the template and writing down what each part
of it is, in the library's own vocabulary. Every other step is code, and the
same input always gives the same template. The search that turns the model's
words into handlers reads the library alone: the model's key on one side, the
library's handler keys and class profiles on the other.

---

## 1. What it is, and what it is not

It does:

- hand the model a template's files;
- ask the model for one **target key** per node and one for the class: what the
  template's look is, in the library's words, with the same fields a handler
  key describes itself with;
- check what the model wrote against the library, and ask again when it is
  wrong;
- **match** each target key to the library's handlers by a scored search, then
  choose one handler per node **together**, so the choices can live in one
  document under the class;
- write the Flouest template and a report saying, per node, what was chosen,
  how close it is, and what was lost.

It does not:

- let the model choose a handler or a class. Its keys hold no way id and no
  class id; it describes, and the search over the library decides.
- read the template's meaning with code. There are no recognisers and no
  facts table: what the template is comes only from the model's keys, and what
  it becomes only from the library.
- decide what works. That is the library's keys and the resolver
  (`Latex-Lib/engine/resolve.ts`), measured by the testing pipeline.
- consider any engine but ZeroTeX-NG.
- judge looks. Fidelity (page images against the original) comes later
  (`../ARCHITECTURE.md` 9.4).

---

## 2. The flow

```
 template zip ─▶ [intake] ─▶ files ─────────────────────────┐
                                                            ▼
                     library catalogue, vocabulary ─▶ [extract]   the model's one step
                                                            │      cached by input hash
                                                            ▼
                                                    target document
                                                            │ [check] library validator; re-ask on problems
                                                            ▼
 Latex-Lib keys, presets, classes ─▶ [class] ─▶ class match │
 description embeddings ──────────▶ [match] ─▶ top k per node, with score terms
                                         │
                                         ▼
                                     [select] ─▶ one handler per node, resolved together
                                         │
                                         ▼
                                     [params] ─▶ preset + the template's values
                                         │
                                         ▼
                                     [bundle] ─▶ defineTemplate call, plug-ins, report
                                         │
                                         ▼
                                     [verify] ─▶ compile in ZeroTeX (testing pipeline), later fidelity
```

1. **intake.** The folder's files, hashed and sorted by kind (`.tex`, `.cls`,
   `.sty`, `.bst`, images); the main file (an uncommented `\documentclass`, then
   `\begin{document}`, a `.tex` sample before a `.dtx`, a usual name, the
   shallowest, the first by name); the classes and styles it ships. This is
   what the model is handed; intake reads no meaning.
2. **extract.** The model's one step (section 4).
3. **check.** The library's vocabulary on the model's answer: every node is
   Flouest's; every feature is in the vocabulary; every parameter is one some
   handler of the node has, and its value fits that parameter; every package
   is a package name; every key has evidence. Problems go back to the model
   with the answer, twice at most; what is still wrong is dropped and reported.
4. **class.** The class key to a profile, searched in the library (section 6).
5. **match.** Each target key to the handlers of its node, searched in the
   library (section 5).
6. **select.** One handler per node, chosen together (section 6).
7. **params.** The chosen handler's preset nearest the template, with the
   template's own values over it where the handler has a parameter for them;
   a value with nowhere to go is reported as lost.
8. **bundle.** The Flouest template and the report (section 7).
9. **verify.** The bundle's starter document compiled in ZeroTeX-NG through
   the testing pipeline; later, page images against the original. Needs the
   compute that the matrix waits for.

---

## 3. The target document

The model writes this, and nothing else (`src/model.ts`). Its words are the
library's: the same node ids, feature words, parameter names, package loads and
evidence (`Latex-Lib/schema/`), so `src/check.ts` holds it to the library's
vocabulary. It holds no way id and no class id: which handler a key stands for,
and which profile the class key stands for, is the search's answer.

A target key is not a handler key. A handler key says everything a handler can
do (its parameter schema, its rules, its parents). A target key says what one
template's look is, in the fields a handler key describes itself with (node,
features, parameters, packages, description), so the search compares like with
like.

```ts
type TargetDocument = {
  source: { id: string; files: { path: string; sha256: string }[] };
  class: TargetClass;
  nodes: TargetKey[];
  /** Document-level ways (page, fonts, headers, spacing): read now, matched once the library has them. */
  document: TargetKey[];
};

type TargetClass = {
  /** The class as \documentclass names it, and its options. */
  name: string;                       // 'IEEEtran'
  options: string[];
  /** A class the template ships: its file, and the class it loads (\LoadClass), by name. */
  local?: { file: string | null; loads: string | null };
  description: string;
  evidence: Evidence[];
};

type TargetKey = {
  node: NodeId;                       // 'containerBlock/mathElement'
  features: Feature[];                // the closed vocabulary
  /** Values by the library's parameter names, each one some handler of the node has. */
  params: { [name: string]: Json };
  /** Packages the template loads for this part, with options. */
  packages: PackageLoad[];
  /** The look in words, for the embedding match. */
  description: string;
  evidence: Evidence[];               // file and lines
  confidence: 'high' | 'medium' | 'low';
  /** When it is not a library way: code that depends on layout state, artwork, code the sample never runs. */
  tier?: 'handler-logic' | 'approximate' | 'asset' | 'drop';
};
```

A node the template does not style has no target key: it keeps General's way.

---

## 4. The model's step: extract

**What the model reads.** The template's main file and its zip-local classes
and styles (within a token budget, the main file first, then what it inputs,
then the zip's classes), and, as instructions:

- what a target key is: a description of one part's look, never a choice of
  handler;
- the library's vocabulary: each node, the parameter names its handlers have
  with their types, and the feature words.

**What it writes.** The target document, through a tool whose input schema is
generated from the library: node ids and feature words as enums, each node's
parameter names with their types. There is no field for a way id or a class
id. The schema changes when the library does, and its hash is part of the
cache key.

**How it is held to it.** The check (section 2, step 4). An answer is never
partly trusted: what fails the check after two re-asks is dropped from the
target document and named in the report.

**The model.** Claude Opus 5.5 (`claude-opus-5-5`) by default, through a
`Model` port, so a cheaper model runs large evaluations and a fake model runs
the tests. Flouest's gateway calls Claude through the AI SDK; the layer can use
the same client, but not the gateway's server, which is the app's.

**Replay.** Each answer is saved under the hash of everything that made it:
the files, the prompt's version, the schema's hash, the model's id.
Running again reads the saved answer, so from the target document on, a run is
a pure function of its inputs.

One call per template, to start. A template too large for one call is read in
parts (the class and preamble first, then the body's nodes), each part its own
cached call.

---

## 5. The match

For each target key, the handlers of its node, filtered, then scored. The
search reads the library and the key, nothing else.

**Filters.** The handler runs in ZeroTeX-NG; it goes under the matched class on
its own (`resolve` with that one choice: class rules, names the class defines,
forbidden packages, what it requires). A handler filtered out is listed in the
report with the reason, so "the template's way is refused by its class" is
said, not hidden.

**Score.** A sum of terms, each printed in the report:

```
score(target, handler, preset) =
    W_feat  · weighted Jaccard(target.features, preset.features ∪ handler.features)
  + W_param · preset similarity(target.params, preset.params)
  + W_pkg   · overlap(target.packages, handler.loads)
  + W_desc  · cosine(embed(target.description), embed(preset or handler description))
```

There is no term for a way the model names, since it names none: the
template's own way is found when its packages, features, parameters and
description all point at the same handler.

- **Features.** Weighted by rarity across the library (a rare feature such as
  `title-bar` says more than `numbered`).
- **Presets.** Each preset of the handler is scored, and the best is kept:
  values compared by their type (an enum equal or not, a length as a number, a
  colour as a colour, a font command by the font it names).
- **Packages.** The packages the key names against the handler's loads.
- **Description.** An embedding of the target's description against each
  preset's and handler's (section 5.1). It decides between handlers the other
  terms leave close, and carries the approximate cases, a custom look with no
  named package.

The weights are set by hand first, then fitted on the evaluation (section 8);
either way they are data, versioned, and part of every report.

The match keeps the top k (about 5) handler and preset pairs per node.

### 5.1 Embeddings

A local embedding model, pinned to one version, so a text always gives the
same vector, offline and at no cost per run. The library's side is embedded
ahead of time: every handler's and preset's description, stored beside the
keys (`Latex-Lib/embeddings.generated.json`), each vector under the hash of its
text and the model's id, and found stale by `npm run verify` as the compat
tables are. The target's descriptions are embedded at match time and cached
the same way. A hosted model (Voyage, say) is the alternative, at the price of
network, cost and drift, held off by the same cache.

---

## 6. The class, and choosing together

**The class first,** since it limits everything else:

| Tier | When |
|---|---|
| `exact` | The class key's name is a profile's name (46 profiles today). |
| `base` | A class the template ships, whose `local.loads` names a profiled class: that profile, and what the shipped class adds is reported. |
| `ship-class` | A zip-local class shipped with the template (`DocumentClass.files`, with its hash), when its licence allows (`../ARCHITECTURE.md` section 8, the licence gate); its profile waits for the class probe. |
| `nearest` | Otherwise the nearest profile by name and description, reported as approximate. |

A class that does not run in ZeroTeX-NG stops the run, with the reason.

**Then the handlers, together.** Choices interact: two theorem engines,
biblatex under a class that loads natbib, two handlers claiming the section
format. So select searches the combinations of each node's top k, with the
resolver on the whole set:

- nodes in order of how constrained they are (fewest candidates, most claims
  and conflicts first);
- depth first, keeping the best total score found, and cutting a branch whose
  best possible total cannot beat it (branch and bound; the constraints are
  sparse, so this stays small);
- ties broken by way id, so the result never depends on order of discovery.

When no combination resolves, the node of lowest confidence takes its handler's
fallback, then the class's own (class-native), and the report says so. If
still nothing resolves, the run stops with the resolver's sentences.

---

## 7. The bundle

The output is a Flouest template as its constructor takes it
(`Template/template-pipeline-journal/define.ts`):

- `documentClass`: the class line with its options, its preamble, and its
  files for a shipped class;
- `plugins`: one `HandlerPlugin` per node whose chosen way is not General's:
  the node's plug-in family and kind (the table `testing-pipeline`'s
  `latexLib.ts` already holds, moved into the library so both use it), a style
  per chosen handler and preset, and the handler's `Realization` with its
  parameters and its parents' adapts (`Latex-Lib/engine/adapt.ts`);
- `looks`: the chosen presets as the template's looks, `plain` always present;
- later, `nesting`: places the resolver found no handler for, removed with
  `setNodeNesting` and reported.

It is written as a template folder (`out/<name>/`): the `defineTemplate`
caller, its plug-in files, and `report.json` with a `report.md` beside it.
While the library incubates outside Flouest, the plug-ins import its handlers
by path; checking with Flouest's `check_template` and compiling go through the
testing pipeline, which already registers plug-ins for a run.

**The report**, per node: the target key and its evidence; the chosen handler,
preset and parameters; the tier; every score term; the candidates beaten and
filtered out, with the reasons; adapts and fallbacks; values lost. For the
class: its tier and what it adds or lacks. And the versions: library, prompt,
schema, model, embedding model, weights.

---

## 8. Evaluation

The research is a ready answer key: 1,000 template sources
(`Latex Related Research/Latex-lib-main/Source/`) and, for 924 of them, a
Solution file with the class, and a component map whose rows name the way, the
evidence lines and the parameters.

1. **The search alone.** Each Solution file read by code into a target
   document, with the research's answer beside each key (`src/gold.ts`, `npm
   run gold`): the way the row names, or the class profile. The search gets the
   target document without the answers and is scored on finding them: how
   often the library holds the template's way and the search finds it, how
   often the class lets it, how often a combination resolves. A key is the
   row's part and parameters in words, with every way id taken out, and the
   packages the library knows that those words name; the Way column is the
   answer and never reaches a key.
2. **The model's extraction, end to end.** The model on a template's source,
   then the search, against its Solution file: class profile right or not; per
   node, the research's way found or not (precision and recall), the
   parameters right or not.
3. **End to end.** The bundle builds, checks and compiles; later, fidelity.

Templates used to seed presets are kept out of the measure (a held-out set, as
`../ARCHITECTURE.md` M4 asks).

---

## 9. Package layout

`Ai/`, a package of its own beside `Latex-Lib/` and `testing-pipeline/`,
depending on the library and on Flouest only through the bundle's types.

```
Ai/
  ARCHITECTURE.md
  package.json
  src/
    model.ts       the target document's types, in the library's vocabulary; no way or class id
    intake.ts      a folder to its files: the main file, the classes and styles it ships
    check.ts       the target document against the library's vocabulary
    llm.ts         the Model port, the Claude adapter, and a fake for the tests
    extract.ts     the instructions, the tool schema from the library, the check and re-asks, the cache
    embed.ts       the Embedder port, the pinned local model, the cache
    score.ts       the score terms
    match.ts       filters and top k per node; the class tiers
    select.ts      the joint search over the resolver
    params.ts      preset and values
    bundle.ts      the defineTemplate caller and its plug-ins
    report.ts      report.json and report.md
    gold.ts        a Solution file to a target document, the answers beside its keys (evaluation 1)
    cli.ts         gold (built); later build-template <zip> | evaluate search | evaluate extract
  test/
  out/             built templates and reports, not committed
```

---

## 10. What stays fixed

- **The model writes target keys, nothing else.** Code checks, searches,
  selects, sets parameters and writes the template.
- **The search reads the library alone.** The key on one side; handler keys,
  presets and class profiles on the other. No way or class id comes from the
  model.
- **Same input, same template.** The model's answer is replayed from its cache;
  everything after it is a pure function of the target document, the library's
  version, the embedding model and the weights.
- **One engine.** ZeroTeX-NG.
- **Every choice explained.** Each score term, filter and fallback is in the
  report.

---

## 11. Build order

| Step | Builds | Done when |
|---|---|---|
| **A0** | The package; `model.ts`, `check.ts`; `intake`; `gold.ts` | Every Solution file reads into a valid target document, its answers beside it and none inside it. **Built.** |
| **A1** | `score` (no embeddings), `match`, `select`, `params`, `report` | Evaluation 1 over the 924 Solution files, per node: way recovered, class allowed, combination resolved |
| **A2** | `embed`, the library's embeddings, their staleness check | Evaluation 1 again, approximate cases scored by description |
| **A3** | `llm`, `extract`: instructions, schema, check, re-asks, cache | Evaluation 2 on a sample of templates, then all; replay gives the same target documents |
| **A4** | `bundle`: theorem node first (the library's pilot), then every node | A template folder and report for any template; `check_template` passes |
| **A5** | Verify: compile the bundles in ZeroTeX-NG; later, fidelity | When the compute the matrix waits for is there |

**A0 as built.** `npm run gold` reads all 924 Solution files into valid target
documents (`out/gold/<id>.json`, not committed). Of the 14,175 node keys, the
answer is a library way for 11,662 and a way the library lacks for 2,513;
2,264 keys name a package the library knows. There are 12,082 document-level
keys, waiting for document-level handlers. The class answer is a profile, the
class's own or the one a shipped class builds on, for 599 templates; 97 ship
their own class. `npm test` runs the synthetic tests (intake, check, gold); no
test reads `Source/`.

---

## 12. Open decisions

- **The embedding model.** A small local sentence model pinned by version, or
  a hosted one with a cache.
- **One model call or several per template.** One with a schema to start;
  split by part for large templates.
- **Document-level ways.** The model reads them now; the library has none yet
  (`../ARCHITECTURE.md` M3, `doc/`), so they are reported, not matched.
- **Presets.** Every way now has typed parameters and up to seven presets
  seeded from the Solution files (`../ARCHITECTURE.md` 2.1), so the match can
  carry the look as well as the way. A target's parameters that no preset
  holds are set directly, within the way's schema.
- **Where it ends up.** Like the library, it incubates here and moves into
  Flouest with an ADR, beside the gateway.
