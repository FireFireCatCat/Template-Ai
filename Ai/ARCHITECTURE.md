# The AI layer: architecture plan

**Status: plan, 2026-10-29; A0, A1 and A2 built 2026-10-31 (section 11): the key format, its check, and the search over the library with embeddings. The model's step (A3) and the bundle (A4) are not built yet.**

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
4. **class.** The class key to a profile, searched in the library (section 6;
   `search/classes.ts`).
5. **match.** Each target key to the handlers of its node, searched in the
   library (section 5; `search/nodes.ts`, `search/score.ts`).
6. **select.** One handler per node, chosen together (section 6;
   `search/select.ts`).
7. **params.** The chosen handler's preset, with the template's own values
   over it where the handler has a parameter for them and the value fits; a
   value with nowhere to go is reported as lost (`search/params.ts`).
8. **bundle.** The Flouest template and the report (section 7;
   `search/report.ts` is built, the bundle is not).
9. **verify.** The bundle's starter document compiled in ZeroTeX-NG through
   the testing pipeline; later, page images against the original. Needs the
   compute that the matrix waits for.

---

## 3. The target document

The model writes this, and nothing else (`model.ts`). Its words are the
library's: the same node ids, feature words, parameter names, package loads and
evidence (`Latex-Lib/schema/`), so `extract/check.ts` holds it to the library's
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

**Filters.** The handler runs in ZeroTeX-NG; with one of its presets (renamed
when the class already defines its names) it goes under the matched class on
its own (`resolve` with that one choice: class rules, names the class defines,
forbidden packages). What another node's choice could supply does not refuse
it (the citations need natbib, which the bibliography loads); that waits for
select. Without a class profile, a name only a class defines (`\maketitle`,
`counter:section`) refuses nothing, since what the class defines is unknown
(`search/classes.ts`, `refusing`). A handler filtered out is listed in the
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

Each term is between 0 and 1. A term the key says nothing about (no
features, no parameters) is absent, not 0, so it neither helps nor hurts any
handler. Scores are rounded to six places, so a last-digit difference between
machines never reorders candidates.

- **Features.** Weighted by rarity across the library's handlers and presets
  (log(1 + N / df)): a rare feature such as `title-bar` says more than
  `numbered`.
- **Presets.** Each preset of the handler is scored, and the best is kept:
  values compared by their type (an enum or a boolean equal or not, a number
  or a length in points by their difference, a colour as RGB, xcolor mixes
  such as `blue!20` included, words by the words they share). A parameter the
  handler lacks scores 0.
- **Packages.** The share of the key's packages the handler loads with that
  preset.
- **Description.** The best cosine of the key's description against the
  preset's and the handler's (section 5.1). It decides between handlers the
  other terms leave close, and carries the approximate cases, a custom look
  with no named package.

The weights are data, versioned, and part of every report (`search/weights.ts`).
They are set by hand today (`hand-1`: features 1, parameters 1, packages 2,
description 2), to be fitted on a held-out part of the evaluation (section 8).

Every handler and preset that goes is ranked; the best preset of each of the
top 5 handlers goes on to select.

### 5.1 Embeddings

A local embedding model, pinned, so a text always gives the same vector,
offline and at no cost per run (`search/embed.ts`): all-MiniLM-L6-v2 as ONNX
(`Xenova/all-MiniLM-L6-v2`), its 8-bit quantisation, at revision
`751bff37182d3f1213fa05d7196b954e230abad9`, run through
`@huggingface/transformers` 4.3.1 with mean pooling and normalised vectors (384
dimensions). The model is downloaded once (about 23 MB) into `.cache/models/`.
The package and its onnxruntime bring `node_modules` to about 500 MB.

Texts go through the model one at a time. The 8-bit model scales each batch by
its own largest value, so in a batch a text's vector depends on the texts
beside it (measured: up to 0.03 per component). One at a time, two runs give
identical vectors, and two evaluations from empty caches give identical
results.

The library's side is embedded ahead of time by `npm run embed`: 503 texts,
every handler's description, every preset's, and every class profile's name
with its own commands, stored beside the keys
(`Latex-Lib/embeddings.generated.json`; `Latex-Lib/embeddings.ts` says which
texts and how they are stored), each vector under the hash of its text and the
model's id, and found missing or stale by the library's `npm run verify` as
the compat tables are. A key's description is embedded before the search runs
and cached by the hash of its text (`.cache/vectors/`), so the search itself
stays synchronous: the first evaluation embeds about 10,000 gold descriptions
in a minute, and later ones take about five seconds.

---

## 6. The class, and choosing together

**The class first,** since it limits everything else:

| Tier | When |
|---|---|
| `exact` | The class key's name is a profile's name (46 profiles today). |
| `base` | A class the template ships, whose `local.loads` names a profiled class: that profile, and what the shipped class adds is reported. |
| `ship-class` | A class the template ships, loading nothing profiled. The resolver works under its own name, so no class rule applies; shipping its files (`DocumentClass.files`, when its licence allows, `../ARCHITECTURE.md` section 8) is the bundle's (A4), and its profile waits for the class probe. |
| `nearest` | The longest profile name inside the key's, of four letters or more (`ltjsarticle` holds `article`); else the nearest name by letter trigrams (0.6 or more: `scartcl` to `scrartcl`); else the nearest description (cosine 0.6 or more). Reported as approximate. |
| `none` | No profile. As for `ship-class`, no class rule applies. |

A class that does not run in ZeroTeX-NG stops the run, with the reason.

**Then the handlers, together.** Choices interact: two theorem engines,
biblatex under a class that loads natbib, two handlers claiming the section
format, citations that need the package the bibliography loads. So select
searches the combinations of each node's options, its top 5 handlers and,
last, General's way (no handler, score 0), with the resolver on the set:

- nodes in order of how constrained they are (fewest options first), each
  node's best option first;
- depth first, keeping the best total score found, and cutting a branch whose
  best possible total cannot beat it (branch and bound);
- a part-made set is cut for what no node still to choose could mend (a class
  rule, a conflict, a claim owned twice, a package or claim none of the
  remaining options supplies); a requirement a later node could supply waits;
- the first complete set tried takes every node's best option, so when the
  best options go together the search ends there; it stops at 20,000 sets
  judged, with the best set found, and the report says so;
- ties broken by way id, so the result never depends on order of discovery.

A node none of whose handlers go with the rest keeps General's way. A
handler's fallback and the class-native ways are handlers of the node, ranked
like any other. For a node that did not get its best option, the report says
why that option did not go with the rest.

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
   document, with the research's answer beside each key (`evaluate/gold.ts`,
   `npm run gold`): the way the row names, or the class profile. The search
   gets the target document without the answers and is scored on finding them
   (`evaluate/tally.ts`, `npm run evaluate`, written to `out/evaluate/`): the
   class profile found or not; for each key, where the research's handler
   ranks among those the class allows, or that the class refused it; for each
   node, whether the handler chosen together is one the research names. A key
   is the row's part and parameters in words, with every way id taken out, and
   the packages the library knows that those words name; the Way column is the
   answer and never reaches a key.
2. **The model's extraction, end to end.** The model on a template's source,
   then the search, against its Solution file: class profile right or not; per
   node, the research's way found or not (precision and recall), the
   parameters right or not.
3. **End to end.** The bundle builds, checks and compiles; later, fidelity.

Templates used to seed presets are to be kept out of the measure (a held-out
set, as `../ARCHITECTURE.md` M4 asks). That split is not drawn yet: the presets
were written from these same Solution files, so the description term is
measured on templates whose words helped write the presets it matches, and the
numbers in section 11 lean high for that reason.

---

## 9. Package layout

`Ai/`, a package of its own beside `Latex-Lib/` and `testing-pipeline/`,
depending on the library and on Flouest only through the bundle's types.

`src/` has three folders, one for each kind of work: what the model does
(`extract/`), the search over the library (`search/`), and the evaluation
(`evaluate/`).

```
Ai/
  ARCHITECTURE.md
  package.json
  src/
    model.ts              the target document's types, in the library's vocabulary; no way or class id
    pipeline.ts           the search, stage after stage: check, class, nodes, select, params, report
    cli.ts                gold | embed | evaluate [--no-embeddings]; later build-template <folder> | evaluate extract
    extract/              the model's stage: the template in, keys out, held to the library
      intake.ts           a folder to its files: the main file, the classes and styles it ships
      check.ts            the target document against the library's vocabulary
                          (A3 adds the Model port, the Claude adapter, the instructions, the tool schema, re-asks, the cache)
    search/               everything after the keys, deterministic, reading the library alone
      classes.ts          the class key to a profile, by tier; which resolver sentences refuse
      nodes.ts            the filter under the class; every key's handlers and presets, ranked
      score.ts            the score terms
      weights.ts          the weights, versioned
      embed.ts            the pinned local model, the vector cache, the description term
      select.ts           one handler per node, chosen together over the resolver
      params.ts           each chosen preset with the template's values; what is lost
      report.ts           report.json and report.md
                          (A4 adds the bundle: the defineTemplate caller and its plug-ins)
    evaluate/
      gold.ts             a Solution file to a target document, the answers beside its keys
      tally.ts            the search scored against gold (evaluation 1)
  test/
  out/                    gold, evaluation summaries and reports; not committed
  .cache/                 the model and the key vectors; not committed
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
| **A1** | `score` (no embeddings), `match`, `select`, `params`, `report` | Evaluation 1 over the 924 Solution files, per node: way recovered, class allowed, combination resolved. **Built.** |
| **A2** | `embed`, the library's embeddings, their staleness check | Evaluation 1 again, approximate cases scored by description. **Built.** |
| **A3** | `llm`, `extract`: instructions, schema, check, re-asks, cache | Evaluation 2 on a sample of templates, then all; replay gives the same target documents |
| **A4** | `bundle`: theorem node first (the library's pilot), then every node | A template folder and report for any template; `check_template` passes |
| **A5** | Verify: compile the bundles in ZeroTeX-NG; later, fidelity | When the compute the matrix waits for is there |

**A0 as built.** `npm run gold` reads all 924 Solution files into valid target
documents (`out/gold/<id>.json`, not committed). Of the 14,175 node keys, the
answer is a library way for 11,662 and a way the library lacks for 2,513;
2,264 keys name a package the library knows. There are 12,082 document-level
keys, waiting for document-level handlers. The class answer is a profile, the
class's own or the one a shipped class builds on, for 599 templates; 97 ship
their own class.

**A1 and A2 as built.** `npm run evaluate` runs the search on all 924 gold
target documents (`out/evaluate/summary.md`, and a report per template in
`out/evaluate/reports/`); `--no-embeddings` runs it as A1.

| | Top 1 | Top 3 | Top 5 | Chosen together |
|---|---|---|---|---|
| Chance | 28.8% | | | |
| A1, no embeddings | 29.4% | 76.3% | 90.4% | 38.3% |
| A2, with embeddings | 58.0% | 91.7% | 98.9% | 63.7% |

- **Keys.** 11,413 node keys are scored: their answer is a library way the
  class allows. A1 is chance for most of them, since a gold key carries only
  the row's words and, for 1,721 keys, a package; for those 1,721 its top 1 is
  47.8%. With the description term every key has a signal.
- **Weakest nodes** in A2, by top 1: abstracts 11.6%, listings 32.4%, headings
  36.8%, block maths 42.7% and citations 42.7%. All but citations have the
  research's handler in their top 3 at least 80% of the time.
- **Choosing together.** The handler chosen is one the research names for
  5,509 of 8,644 nodes; 119 took another handler so the set resolves, 58 kept
  General's way, and one template's choice stopped at the search budget.
- **Class.** The profile found is the research's for 598 of 599 templates
  whose answer is a profile. Three templates stop at a class that does not run
  in ZeroTeX-NG.
- **Refused by the class.** For 249 keys the class refuses the research's
  handler: it does not run in ZeroTeX-NG, the class is jlreq, letter,
  moderncv and tikzposter lack floats and sections, beamer loads xcolor itself.
- **Caveat.** The presets were written from these Solution files (section 8),
  and gold keys are the research's words, not the model's; A3's evaluation is
  the real measure.

`npm test` runs the synthetic tests (intake, check, gold, score, class search
and filter, select, embeddings without the model, the search end to end); no
test reads `Source/`.

---

## 12. Open decisions

- **The embedding model.** Decided: all-MiniLM-L6-v2, local and pinned
  (section 5.1). A larger model is a version change and a new evaluation.
- **Fitting the weights.** `hand-1` today; to be fitted on a held-out part of
  gold once the split is drawn (section 8).
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
