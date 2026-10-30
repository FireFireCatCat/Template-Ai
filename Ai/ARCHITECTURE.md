# The AI layer: architecture plan

**Status: plan, 2026-10-29. Nothing here is built yet.**

The AI layer turns a template someone feeds in (a zip of LaTeX sources) into a
Flouest template: one `defineTemplate` call with the document class, a handler
plug-in for each node whose LaTeX differs from General's, and a report. It is
the automation of `../ARCHITECTURE.md` section 8, built on the handler library
(`../Latex-Lib/`).

One step is the model's: reading the template and writing down what each part
of it is, in the library's own vocabulary. Every other step is code, and the
same input always gives the same template.

---

## 1. What it is, and what it is not

It does:

- read a template's files and the facts code can read from them (the class
  line, the packages, the theorem declarations, the zip's own classes);
- ask the model for one **target key** per node and one for the class: what the
  template's look is, in the library's words;
- check what the model wrote against the library, and ask again when it is
  wrong;
- **match** each target key to the library's handlers by a scored search, then
  choose one handler per node **together**, so the choices can live in one
  document under the class;
- write the Flouest template and a report saying, per node, what was chosen,
  how close it is, and what was lost.

It does not:

- let the model choose a handler. The model reports what it sees, including
  the way it recognises (`thm.amsthm`); the matcher decides.
- decide what works. That is the library's keys and the resolver
  (`Latex-Lib/engine/resolve.ts`), measured by the testing pipeline.
- consider any engine but ZeroTeX-NG.
- judge looks. Fidelity (page images against the original) comes later
  (`../ARCHITECTURE.md` 9.4).

---

## 2. The flow

```
 template zip ─▶ [intake] ─▶ files ─▶ [facts] ─▶ facts ──────┐
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

1. **intake.** The zip's files, hashed: the main file (the one with
   `\documentclass`), the `.tex`, `.cls`, `.sty`, `.bst` and images. Each
   `.cls` and `.sty` is published or zip-local, by the research's rubric (W1:
   on CTAN, or a publisher's official kit).
2. **facts.** What code reads without judgement: `\documentclass[options]{x}`,
   every `\usepackage[options]{x}` with its line, a zip-local class's
   `\LoadClass` (its base), `\newtheorem` and `\theoremstyle`,
   `\titleformat`, `\setlist`, `\newtcbtheorem`, `\lstset`, and so on: a table of
   recognisers, one per family. Facts are evidence the model starts from, and a
   check on what it writes: a way it names must load the packages the facts
   show.
3. **extract.** The model's one step (section 4).
4. **check.** The library's own rules on the model's answer: every way, class,
   package and parameter it names resolves; every feature is in the vocabulary;
   every value fits its parameter's type. Problems go back to the model with
   the answer, twice at most; what is still wrong is dropped and reported.
5. **class.** The class key to a profile (section 6).
6. **match.** Each target key to the handlers of its node (section 5).
7. **select.** One handler per node, chosen together (section 6).
8. **params.** The chosen handler's preset nearest the template, with the
   template's own values over it where the handler has a parameter for them;
   a value with nowhere to go is reported as lost.
9. **bundle.** The Flouest template and the report (section 7).
10. **verify.** The bundle's starter document compiled in ZeroTeX-NG through
    the testing pipeline; later, page images against the original. Needs the
    compute that the matrix waits for.

---

## 3. The target document

The model writes this, and nothing else. Its words are the library's: the same
node ids, way ids, class ids, feature words, parameter names, package loads and
evidence (`Latex-Lib/schema/`), so the library's validator checks it.

A target key is not a handler key. A handler key says everything a handler can
do (its parameter schema, its rules, its parents). A target key says what one
template's look is.

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
  name: string;
  options: string[];
  /** The library's id for it, when the model recognises a published class. */
  id: ClassId | null;
  /** A zip-local class: its file, and the class it loads (from the facts). */
  local?: { file: string; base: ClassId | null };
  description: string;
  evidence: Evidence[];
};

type TargetKey = {
  node: NodeId;                       // 'containerBlock/mathElement'
  /** The way the template uses, when the model recognises it; null when it does not. */
  way: WayId | null;                  // 'thm.amsthm'
  features: Feature[];                // the closed vocabulary
  /** Values for the way's parameters, by the library's names. */
  params: { [name: string]: Json };
  /** Packages the template loads for this part (the facts', with options). */
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
then the zip's classes), the facts, and, as instructions:

- the research's rubric, cut to what a way is and what a parameter is (a
  parameter never makes a new way);
- the library's catalogue: each node, its ways with their descriptions and
  parameter names (`node cli.ts ways`), and the feature vocabulary;
- the class profiles' ids and names.

**What it writes.** The target document, through a tool whose input schema is
generated from the library: node ids, way ids and feature words as enums, each
way's parameters with their types. The schema changes when the library does,
and its hash is part of the cache key.

**How it is held to it.** The check (section 2, step 4). An answer is never
partly trusted: what fails the check after two re-asks is dropped from the
target document and named in the report.

**The model.** Claude Opus 5.5 (`claude-opus-5-5`) by default, through a
`Model` port, so a cheaper model runs large evaluations and a fake model runs
the tests. Flouest's gateway calls Claude through the AI SDK; the layer can use
the same client, but not the gateway's server, which is the app's.

**Replay.** Each answer is saved under the hash of everything that made it:
the files, the facts, the prompt's version, the schema's hash, the model's id.
Running again reads the saved answer, so from the target document on, a run is
a pure function of its inputs.

One call per template, to start. A template too large for one call is read in
parts (the class and preamble first, then the body's nodes), each part its own
cached call.

---

## 5. The match

For each target key, the handlers of its node, filtered, then scored.

**Filters.** The handler runs in ZeroTeX-NG; it goes under the matched class on
its own (`resolve` with that one choice: class rules, names the class defines,
forbidden packages, what it requires). A handler filtered out is listed in the
report with the reason, so "the template's way is refused by its class" is
said, not hidden.

**Score.** A sum of terms, each printed in the report:

```
score(target, handler, preset) =
    W_way   · [target.way = handler.id]
  + W_feat  · weighted Jaccard(target.features, preset.features ∪ handler.features)
  + W_param · preset similarity(target.params, preset.params)
  + W_pkg   · overlap(target.packages, handler.loads)
  + W_desc  · cosine(embed(target.description), embed(preset or handler description))
```

- **The way.** When the model names a way and the handler is it, that term
  outweighs all the others together: an exact way wins. The research found 74%
  of templates rebuildable from known ways, so most nodes end here.
- **Features.** Weighted by rarity across the library (a rare feature such as
  `title-bar` says more than `numbered`).
- **Presets.** Each preset of the handler is scored, and the best is kept:
  values compared by their type (an enum equal or not, a length as a number, a
  colour as a colour, a font command by the font it names).
- **Packages.** The template's packages for this part against the handler's
  loads.
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
| `exact` | The class has a profile (46 today). |
| `base` | A zip-local class whose base has a profile (its `\LoadClass`, from the facts): the base's profile, and what the local class adds is reported. |
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

1. **The matcher alone.** Each Solution file read into a target document by
   code (its rows' ways, their parameters by name where they have one), then
   matched and selected. This is the ceiling: how often the library holds the
   template's way, how often the class lets it, how often a combination
   resolves. `node cli.ts solutions` is its theorem-node part already.
2. **The model's extraction.** The model on a template's source, against its
   Solution file: class right or not; per node, the way found or not
   (precision and recall), the parameters right or not.
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
    model.ts       the target document's types, in the library's vocabulary
    intake.ts      a zip or folder to files: the main file, published or zip-local
    facts.ts       the recognisers: class line, packages, theorem and heading declarations, \LoadClass
    llm.ts         the Model port, the Claude adapter, and a fake for the tests
    extract.ts     the instructions, the tool schema from the library, the check and re-asks, the cache
    embed.ts       the Embedder port, the pinned local model, the cache
    score.ts       the score terms
    match.ts       filters and top k per node; the class tiers
    select.ts      the joint search over the resolver
    params.ts      preset and values
    bundle.ts      the defineTemplate caller and its plug-ins
    report.ts      report.json and report.md
    gold.ts        a Solution file to a target document (evaluation 1)
    cli.ts         npm run build-template <zip> | evaluate matcher | evaluate extract
  test/
  out/             built templates and reports, not committed
```

---

## 10. What stays fixed

- **The model writes target keys, nothing else.** Code reads facts, checks,
  matches, selects, sets parameters and writes the template.
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
| **A0** | The package; `model.ts`; `intake`, `facts`; `gold.ts` | Every Solution file reads into a valid target document; facts agree with the Solution files' class and package lines |
| **A1** | `score` (no embeddings), `match`, `select`, `params`, `report` | Evaluation 1 over the 924 Solution files, per node: way recovered, class allowed, combination resolved |
| **A2** | `embed`, the library's embeddings, their staleness check | Evaluation 1 again, approximate cases scored by description |
| **A3** | `llm`, `extract`: instructions, schema, check, re-asks, cache | Evaluation 2 on a sample of templates, then all; replay gives the same target documents |
| **A4** | `bundle`: theorem node first (the library's pilot), then every node | A template folder and report for any template; `check_template` passes |
| **A5** | Verify: compile the bundles in ZeroTeX-NG; later, fidelity | When the compute the matrix waits for is there |

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
