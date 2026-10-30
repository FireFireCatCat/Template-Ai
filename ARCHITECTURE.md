# Handler Library: architecture plan

Status: M0 is built and M1, the theorem pilot, is under way in `Latex-Lib/`
(2026-10-29): the key, preset, class and package schema with its validators,
the contexts, the compat writer, the Flouest pin; the 7 theorem handlers with
keys and presets from the Solution files; 46 class profiles (9 measured by
the class probe, 37 read from requirement documents, Solution files and class
source) and class rules on the ways' keys; a resolver; and the library's ways in
the testing pipeline's matrix (`compat run --library`: 97 ways over 28 nodes,
every preset, under a class setting for each profile; planned, not compiled). Beyond the pilot,
every one of Flouest's 32 nodes has its ways at the pilot's depth: 110
handlers, 507 parameters typed from the packages' documented interfaces, 347
presets citing the Solution rows that use them (243 Solution files), each
handler honouring all its parameters (section 2.1). Testing them is paused. Section
11 says what each milestone still lacks.

This is the plan for template automation built on Flouest
(`~/Desktop/StartUp/Flouest-dev-main`). It has three parts:

1. **A library of node handlers.** Each Flouest node gets a folder, and the
   folder holds every published way of writing that node in LaTeX.
2. **A key on every handler.** The key says what styling the handler can
   achieve, which document classes and packages it conflicts with, and, for
   each possible parent, which of the parent's ways and package combinations it
   works under, needs adjusting under, or cannot be used under.
3. **An automation.** It reads a target template, picks one handler per node
   that satisfies every key, writes a Flouest template, and measures how close
   the result is.

The evidence behind the design is in `Latex Related Research/Latex-lib-main/`:
924 of 1000 templates analysed, 74% rebuildable from a finite library, the core
ways close to saturating (289 ways, about 5 new per 100 templates), and the
failure reasons. These numbers are cited where they drive a decision.

---

## 1. Vocabulary

| Term | Meaning | Source of truth |
|---|---|---|
| **Node id** | `type/kind`, as Flouest's nesting list names it: `containerBlock/mathElement`, `paragraph/heading`, `table_cell`. There are 32, plus `doc` for document-level ways. | `Template/template-functions/nesting/general-nesting.json` |
| **Way id** | `<component>.<way>`, one published package or command family: `thm.amsthm`, `thm.tcolorbox`. Parameter values never make a new way. | `_Lib.md`, `_Rubric.md` (W1 to W4) |
| **Handler** | One way implemented for one node: a Flouest `Realization` (`preamble`, `emit`) plus its **key**. | this library |
| **Key** | The handler's metadata (section 3). | this library |
| **Preset** | A named parameter set for a handler, with its own styling description. Many presets map to one handler; this is the "many-to-one map" from the original idea. | this library, seeded from Solution files |
| **Context** | What a place in the document allows: page breaks, floats, verbatim text, paragraph mode... (section 4.2). | `lib/contexts.ts` |
| **Class profile** | What a document class preloads, defines and forbids. | `lib/classes/` |
| **Package facts** | A package's options, which options exclude each other, load order, whether it runs in ZeroTeX-NG. | `Latex-Lib/packages/` |

The theorem node is `containerBlock/mathElement`: every theorem-like statement
(theorem, lemma, definition...) is that one node, distinguished by its
`elementName` attr. Its look has document scope, so one way serves all
statements. Note that `containerBlock/listing` is a **list**
(itemize/enumerate/description), not a figure. Figures are `atomicBlock/image`,
and tables are `table`.

---

## 2. Folder layout

```
template-lib-based-automation/
  Latex-Lib/                    the library (built as M0 and M1; what is not built yet is marked "later")
    schema/                     key, preset (params), class and package types; validators; Flouest's Realization, mirrored;
                                minimal.ts, a key in short form (its rules, parameters and presets; its CTAN pages as evidence);
                                features.ts, the closed feature vocabulary, a group per kind of node
    contexts.ts                 the context vocabulary and its fold (section 4.2)
    nesting.ts                  the parent universe, read from Flouest's general-nesting.json
    compat.ts                   the compat.generated.json writer and its staleness check (section 4.4)
    flouest.ts                  the Flouest pin: flouest.lock.json holds the hash of every file read
    library.ts                  loads nodes/, classes/, packages/
    seed.ts                     the Solution rows for a component, and each Solution file's class (section 10)
    cli.ts                      npm run verify | generate; node cli.ts pin | solutions
    nodes/
      evidence.ts               solution(file, line) and manual(package, section), as presets cite them
      <node>/node.ts            what the node's ways share: reading its data, and shared parameters (heading NUMBERING,
                                table column and rule helpers, contents CONTENTS, amsmath displays …)
      <node>/<way>/             key.ts, presets.ts, handler.ts and compat.generated.json, as for the theorem ways below
      containerBlock.mathElement/
        index.ts                way id -> handler, for this node
        statement.ts            what every theorem way reads from the node, and their shared numbering
        thm.amsthm/
          key.ts                the key (hand-written rules)
          handler.ts            (params) -> Realization { preamble, emit }
          presets.ts            named parameter sets, each with a description and the Solution rows it stands for
          compat.generated.json the per-parent table, generated and verified (section 4.4)
          matrix.generated.json the testing pipeline's verdicts for the way, merged into the compat table
        thm.class-native/  thm.kernel/  thm.thmtools/  thm.tcolorbox/  thm.ntheorem/  thm.mdframed/
      protocol.ts               how Flouest's emitter passes children to parents (table separators, code escapes, list lines)
      paragraph.heading/  containerBlock.note/  atomicBlock.image/  table/ ...  every other node: node.ts (its data,
                                read once for all its ways), index.ts, and one folder per way with key.ts and handler.ts
      doc/                      document-level ways: page.*, font.*, hf.*, sp.*, color.*   later (M3)
    classes/                    33 class profiles: measured, article, amsart, llncs, acmart, memoir, scrartcl, ieeetran,
                                elsarticle, revtex4-2; read, book, report, extarticle, beamer, scrbook, scrreprt, letter,
                                amsbook, amsproc, extbook, extreport, proc, minimal, ltxdoc, ctexart, ctexrep, ctexbook,
                                ctexbeamer, scrlttr2, moderncv, tikzposter, a0poster, exam, jlreq, tufte-handout, tufte-book,
                                sn-jnl, siamart, mdpi, aastex, aa, mnras, lipics, easychair, cas-sc, cas-dc, iopjournal
    packages/                   package facts: every package a way loads (62)
    engine/
      adapt.ts                  a handler where it sits: a parent's adapt or fallback, at emit
      resolve.ts                checks a set of choices: class, document-wide, requirements; the pilot's pick
      preamble.ts  select.ts  bridge.ts                                               later (M2, M4)
    test/                       node:test, with a snapshot of every preset's LaTeX
  intake/                       Solution files and requirement documents -> TargetSpec          later (M4)
  testing-pipeline/             the compatibility matrix (section 9.2): plan, file, compile, judge, explain
  ARCHITECTURE.md
```

**Where it lives.** Incubate it here, reading Flouest by path (the nesting
JSON) against pinned files: the checkout is not a git repository, so
`flouest.lock.json` holds the hash of every Flouest file the library reads or
builds on, and `npm run verify` says which changed. While it incubates, the
library imports nothing from Flouest: a handler is typed by a copy of
Flouest's `Realization` (`schema/realization.ts`) and prints its own LaTeX, so
the library and its tests run on plain Node. The testing pipeline assigns each
handler to Flouest's own type when it plugs it in, so its type check fails if
the copy drifts. Once the theorem pilot passes,
move `Latex-Lib/` into Flouest as a root folder beside `Theme-Lib/`
(`Handler-Lib/`, imported through an alias as `@themes` is), with an ADR. The
reason is that a generated template's plug-ins live in
`Template/templates/<name>/plugins/` and must import handlers from inside the
repository.

### 2.1 The library: every node's ways

Every node of Flouest's nesting list has its ways, each a handler that prints
the way's exact LaTeX from the node's own data and its parameters. The ways
and their ids are the research's (`_Lib.md`, its component sections), mapped
onto the nodes; a way that serves several nodes (`bib.natbib` prints the
reference list and the citations) has a handler in each, since a handler is a
node and a way. Some ids are not in the research: `ack.kernel` and
`ack.class-native` (the research files acknowledgements under
`front.dedication`), and the single ways of nodes whose output Flouest fixes
(`list.item`, `tbl.row`, `tbl.header`, `bib.entry`, `code.escape`,
`custom.raw`, `para.kernel`).

Each way is at the theorem pilot's depth:

- **Parameters** typed from the package's interface (`titlesec`'s shapes,
  `\titleformat` arguments and `\titlespacing`; `footmisc`'s options;
  `tcolorbox`'s keys; `natbib`'s citation options …). A package option a
  parameter sets is a `load` with a `when` (`footmisc`'s `perpage` when
  `perpage: true`), and every such option is in the package's facts.
- **Presets**, up to seven a way, each a look from the Solution files, its
  description and features, citing the rows that use it (`node seed.ts
  <component> --rows`); a look no template shows cites the manual section
  instead. 347 presets cite 243 Solution files. The ways whose output Flouest
  fixes, the class-native ways and the citation commands of a single form have
  one preset.
- **The handler** honours every parameter. What the node's ways share sits in
  the node's `node.ts`: the heading levels' sizes by scale and the numbering
  parameters, the table's column specs, rules and setup lines, the contents
  depth and lists, amsmath's displays, a note's tone colour.
- **The key** keeps the class rules, `only` lists, requirements and conflicts
  the generator gave it (keys are kept by hand now; `gen_ways.py` is not run
  again), adds the parameters, features and `givesWhen` (a box that does not
  break gives `breakable: false`).

The features vocabulary (`schema/features.ts`) has a group per kind of node:
headings and title blocks, abstracts and contents, lists, notes, boxes and
columns, maths, code, tables and figures, breaks and footnotes, citations and
links. The AI layer matches a target key's features against these.

Where the facts come from. Seventeen CTAN manuals were read in full (titlesec
and titletoc, sectsty, fncychap, titling, marginnote, todonotes, sidenotes,
mdframed, fancybox, awesomebox, arydshln, tabularray, nicematrix, cleveref,
appendix, endnotes, apacite); keys and handlers built on them cite their
sections (titlesec 3.1 to 3.6, mdframed 6.5 for TikZ shadows, nicematrix 8.3
for X columns). For the other packages the parameters follow their documented
interfaces as the research uses them, and their citations name no section
numbers. Nothing here has been compiled since: the snapshots fix what each
preset prints (`test/snapshots/ways.json`, 347 entries), and every printed
`\usepackage` is checked against the key's loads.

`node cli.ts ways --markdown` prints the catalogue:

| Node | Ways | Each way (its packages) |
|---|---|---|
| `atomicBlock/image` | 7 | `fig.adjustbox` (adjustbox, xcolor), `fig.float` (graphicx, float), `fig.floatrow` (graphicx, sidecap, floatrow), `fig.graphicx` (graphicx), `fig.rotating` (graphicx, rotating), `fig.svg` (svg), `fig.wrapfig` (graphicx, wrapfig) |
| `atomicBlock/pageBreak` | 2 | `pg.afterpage` (afterpage), `pg.break` (kernel) |
| `atomicBlock/tableContents` | 5 | `toc.etoc` (etoc), `toc.kernel` (kernel), `toc.koma` (kernel), `toc.titletoc` (titletoc), `toc.tocloft` (tocloft) |
| `cite/cite` | 7 | `bib.apacite` (kernel), `bib.biblatex-biber` (kernel), `bib.biblatex-bibtex` (kernel), `bib.bibtex-bst` (kernel), `bib.cite-pkg` (kernel), `bib.natbib` (kernel), `bib.thebibliography` (kernel) |
| `code/code` | 4 | `code.listings` (listings, xcolor), `code.minted` (minted, xcolor), `code.tcblisting` (tcolorbox), `code.verbatim` (fancyvrb, alltt) |
| `codeEscape/codeEscape` | 1 | `code.escape` (kernel) |
| `containerBlock/abstract` | 3 | `abs.abstract-pkg` (abstract), `abs.class-native` (kernel), `abs.kernel` (kernel) |
| `containerBlock/acknowledgement` | 2 | `ack.class-native` (kernel), `ack.kernel` (kernel) |
| `containerBlock/appendix` | 1 | `num.appendix` (appendix) |
| `containerBlock/blockMath` | 3 | `math.amsmath` (amsmath), `math.kernel` (kernel), `math.mathtools` (mathtools) |
| `containerBlock/columns` | 4 | `cols.multicol` (multicol, xcolor), `cols.paracol` (paracol, xcolor), `cols.twocolumn-cmd` (kernel), `cols.vwcol` (vwcol) |
| `containerBlock/customLatex` | 1 | `custom.raw` (kernel) |
| `containerBlock/listing` | 5 | `list.enumerate-pkg` (enumerate), `list.enumitem` (enumitem), `list.kernel` (kernel), `list.paralist` (paralist), `list.scrextend` (scrextend) |
| `containerBlock/mathElement` | 7 | `thm.amsthm` (amsthm, xcolor), `thm.class-native` (kernel), `thm.kernel` (kernel), `thm.mdframed` (mdframed), `thm.ntheorem` (ntheorem), `thm.tcolorbox` (tcolorbox), `thm.thmtools` (amsthm, thmtools) |
| `containerBlock/note` | 9 | `box.awesomebox` (awesomebox, xcolor), `box.fancybox` (fancybox, xcolor), `box.mdframed` (mdframed, xcolor), `box.tcolorbox` (tcolorbox, xcolor), `note.marginnote` (marginnote, xcolor), `note.marginpar` (kernel), `note.notecolumn` (scrlayer-notecolumn), `note.sidenotes` (sidenotes), `note.todonotes` (todonotes) |
| `containerBlock/refContainer` | 7 | `bib.apacite` (apacite), `bib.biblatex-biber` (biblatex), `bib.biblatex-bibtex` (biblatex), `bib.bibtex-bst` (kernel), `bib.cite-pkg` (cite), `bib.natbib` (natbib), `bib.thebibliography` (kernel) |
| `customLatex/customLatex` | 1 | `custom.raw` (kernel) |
| `footnoteAnchor/footnoteAnchor` | 4 | `fn.bigfoot` (footnotehyper), `fn.endnotes` (endnotes), `fn.footmisc` (footmisc), `fn.kernel` (kernel) |
| `hyperlink/hyperlink` | 2 | `meta.hyperref` (hyperref, xcolor), `meta.url` (url, xurl) |
| `inlineMath/inlineMath` | 1 | `math.kernel` (kernel) |
| `paragraph/customLatexPara` | 1 | `custom.raw` (kernel) |
| `paragraph/heading` | 7 | `head.class-native` (kernel), `head.fncychap` (fncychap), `head.kernel` (kernel), `head.koma-fonts` (xcolor), `head.memoir-style` (xcolor), `head.sectsty` (sectsty, xcolor), `head.titlesec` (titlesec, xcolor) |
| `paragraph/lstParagraph` | 1 | `list.item` (kernel) |
| `paragraph/mathPara` | 2 | `math.amsmath` (amsmath), `math.kernel` (kernel) |
| `paragraph/paragraph` | 1 | `para.kernel` (parskip) |
| `paragraph/refPara` | 1 | `bib.entry` (kernel) |
| `paragraph/title` | 5 | `front.class-native` (kernel), `front.koma-title` (kernel), `front.maketitle` (kernel), `front.titlepage-env` (kernel), `front.titling` (titling) |
| `ref/ref` | 4 | `xref.cleveref` (hyperref, cleveref), `xref.hyperref` (hyperref), `xref.kernel` (kernel), `xref.varioref` (varioref) |
| `table` | 9 | `tbl.arydshln` (arydshln), `tbl.booktabs` (booktabs), `tbl.colortbl` (xcolor), `tbl.longtable` (longtable, booktabs), `tbl.nicematrix` (tabularray, nicematrix, xcolor), `tbl.tabbing` (kernel), `tbl.tabular` (kernel), `tbl.tabularx` (tabularx), `tbl.threeparttable` (threeparttable, booktabs) |
| `table_cell` | 1 | `tbl.multirow` (multirow, xcolor, colortbl) |
| `table_header` | 1 | `tbl.header` (multirow, xcolor, colortbl) |
| `table_row` | 1 | `tbl.row` (kernel) |

What a key does not hold yet: parent rules and context needs beyond the few
the generator gave (a `\marginpar` needs a floating place, verbatim code needs
verbatim, a longtable a breakable place outside columns and boxes, wrapfig
paragraph mode). A table cell's or a footnote's way keeps to Flouest's
conventions: the emitter writes footnotes itself (only their preamble is
read), and the table assembles rows and cells.

---

## 3. The key

One key per handler. It keeps the four fields of the original idea
(description, document class, packages, nesting), in the modified form agreed
on, plus what the automation needs to pick and verify handlers.

```ts
export type HandlerKey = {
  /** Way id; also the folder name. */
  id: WayId;                                   // 'thm.tcolorbox'
  node: NodeId;                                // 'containerBlock/mathElement'

  // ── What it achieves ────────────────────────────────────────────────
  /** Free text, for people and for an AI choosing between handlers. */
  description: string;
  /** Closed vocabulary, so a picker can match a target's look to handlers. */
  features: Feature[];                         // 'framed' | 'hang-head' | 'booktabs-rules' | 'author-year' | ... (schema/features.ts)
  /** Typed from the Flouest Packages/ printer the handler calls. */
  params: ParamSchema;
  /** Many styling descriptions -> this one handler. */
  presets: Record<string, Preset>;             // { description, features, params }

  // ── The engine ──────────────────────────────────────────────────────
  /** Runs in ZeroTeX-NG, the only engine: no shell escape, no Ghostscript, no minted or pythontex. */
  zerotex: Support;                            // 'yes' | 'no' | 'untested'

  // ── What it puts in the document ────────────────────────────────────
  /** Structured, so the merger can union options and order loads (section 6). */
  loads: PackageLoad[];                        // [{ pkg: 'tcolorbox', libraries: ['theorems','skins','breakable'], when?: ParamPredicate }]
  /** Names it creates; checked against the class and other handlers. */
  defines: Resource[];                         // 'env:{elementName}', 'counter:{elementName}', 'cmd:\\qedsymbol'
  /** Things only one handler in the document may own. */
  claims: Exclusive[];                         // 'theorem-engine', 'section-format', 'caption-format', 'output-routine'
  /** Things another handler or the class must supply. */
  requires: Requirement[];                     // 'counter:{parentCounter}', 'claim:theorem-engine' (thmtools needs amsthm or ntheorem)

  // ── Document class (the original "allowed document class" field) ────
  classes: {
    /** Default: allowed under any class whose profile passes the resource checks. */
    deny: ClassRule[];                         // [{ class: 'llncs', reason, evidence, unless?: ParamPredicate }]
    /** Only for class-native handlers: the classes it can be used with. */
    only?: ClassId[];
  };

  // ── Packages across the document (the original "compatible package" field) ──
  packages: {
    conflicts: PackageRule[];                  // [{ way: 'thm.ntheorem', reason }], [{ pkg: 'ntheorem', unless: { option: 'amsthm' } }]
    loadOrder?: OrderRule[];                   // [{ after: 'hyperref' }]
  };

  // ── Nesting (the original "allowed nesting" field, see section 4) ───
  context: {
    /** What its body allows its children. */
    gives: ContextChange;
    givesWhen?: { when: ParamPredicate; gives: ContextChange }[];
    /** What it needs where it sits. */
    needs: ContextNeed;
  };
  /** Per parent node: which parent ways and package combinations work, need adapting, or are denied. */
  parents: ParentRules;
  /** What to emit when a parent denies this handler. */
  fallback?: { way: WayId; preset?: string };

  // ── Provenance ──────────────────────────────────────────────────────
  evidence: Evidence[];                        // Solution file:line, package manual section, matrix cell id
  status: 'draft' | 'verified';
};
```

Rules about the key:

- **Every rule carries a reason and evidence.** A rule without evidence is
  `draft`, and the selector treats a draft deny as a deny but reports it.
- **Every id must resolve.** A way, class, package or parent named in a rule
  must exist. The validator fails otherwise; this is how
  `templateLooks.check.ts` and `registry.check.ts` already work in Flouest.
- **Parameters never make a new handler.** A new handler needs a new package or
  command family (`_Rubric.md`, W1 to W4). A styling variation is a preset.

---

## 4. The per-parent rules

This is the part that says, for each parent in the node's parent list, which
of the parent's ways and package combinations the handler can and cannot be
used under.

### 4.1 Why it can't be written by hand alone

The rules depend on the parent's **way**, not only on the parent node. For
example, a theorem in a `table_cell` is fine when the table's columns are `p{}`
or `X`, but fails when they are `l` or `c` (paragraph content in an LR box).
They also depend on **every ancestor**, not only the direct parent. Flouest's
own `Template/test/dynamic-testing/nesting.ts` records that a note in a
mathElement is legal, and a mathElement in a table cell is legal, yet a note in
a mathElement in a table cell is refused.

Rough size: about 32 nodes × about 9 parents × about 5 parent ways × about 5
child ways comes to several thousand cells, before counting depth. Written by
hand, it would be wrong and stale. So the table is **explicit in every key**,
as requested, but it is **produced in three layers** and then written out.

### 4.2 Layer 1: contexts (derived)

A small, fixed vocabulary. Each handler says what its body **gives** its
children and what it **needs** where it sits. Contexts fold down the ancestor
chain, so a constraint set by any ancestor reaches every descendant.

| Flag | Meaning | Turned off by, for example |
|---|---|---|
| `breakable` | page breaks can fall inside | minipage, an unbreakable box, a table cell, a float |
| `floats` | figure/table floats allowed | any box; multicol (column floats are refused there) |
| `paragraph` | vertical/paragraph mode, so lists and trivlists work | `l`/`c`/`r` table columns, `\mbox`, `\tcbox` |
| `verbatim` | catcode-changing content works (listings, `\verb`) | anything that reads its body as a macro argument |
| `argument` | the body is a macro argument | `\caption{}`, `\fbox{}`, `\footnote{}` (Flouest handles its footnote bodies specially: `keepVerbatim`) |
| `footnotes` | `\footnote` produces a normal footnote | minipage (minipage footnotes), tabular (lost) |
| `math` | inside maths | display maths |
| `columns` | inside multicol | `containerBlock/columns` |
| `boxDepth` | how many boxes enclose it | each box adds 1 |

The flag list stays at about 10. If it grows much past that it turns back into
the hand-written table this layer replaces. A rule that doesn't fit a flag goes
in layer 2.

A parent's params can change what it gives. This is where package combinations
enter. `tbl.tabular` with `p{}` columns gives `paragraph: true`, and with `l`
columns gives `paragraph: false`. `thm.tcolorbox` with `breakable: true` gives
`breakable: true` to its body, but only if its own place is breakable.

Derived verdict for a child handler C at a place:
`needs(C) ⊆ fold(gives(ancestor ways))` gives **ok**. If not, the cell is
**deny**, unless an adapt rule or a fallback applies (layer 2).

### 4.3 Layer 2: authored rules (hand-written, with evidence)

```ts
type ParentRules = Partial<Record<NodeId | '*', ParentEntry>>;

type ParentEntry = {
  /** 'direct': only when this parent is directly above. 'ancestor': anywhere above. */
  scope: 'direct' | 'ancestor';
  /** Parent ways (and parameter combinations) this handler works under, beyond what contexts derive. */
  allow?: ParentWayRule[];                     // [{ way: 'tbl.tabularx' }]
  /** Parent ways or package combinations it must not be used under. */
  deny?: ParentWayRule[];                      // [{ way: 'tbl.tabular', when: { columns: 'lcr' }, reason, evidence }]
  /** Allowed only with changed params or emit. */
  adapt?: { way: WayId | '*'; set: Partial<Params>; addLoads?: PackageLoad[]; reason: string; evidence: Evidence[] }[];
  /** What to emit instead when denied and not adaptable. */
  fallback?: { way: WayId; preset?: string; reason: string };
};

type ParentWayRule = {
  way: WayId | '*';
  /** A predicate over the parent's params, e.g. its column types or its breakable flag. */
  when?: ParamPredicate;
  /** Packages that must (or must not) also be loaded for the rule to apply. */
  withPackages?: { pkg: string; options?: string[] }[];
  reason: string;
  evidence: Evidence[];
};
```

Precedence: **deny > adapt > allow > derived**. A parent missing from the
table falls back to the derived verdict.

Flouest already makes two decisions of exactly this shape inside General's
handlers. They become the first authored rules:

- `mathElement.ts`: a coloured statement box drops `enhanced` and `breakable`
  when its parent is `footnote`, `listing`, `table_cell` or `table_header`
  (`CONFINED_COLORED_BOX_PARENT_TYPES`). That is an **adapt** rule.
- `Figures_Image.ts`: inside `columns` and other block containers, or in a
  table cell, an image is not floated; it prints `\captionof{figure}` from the
  `caption` package. That is an **adapt** with `addLoads`. It is also the
  multicol case: multicol refuses column floats.

### 4.4 Layer 3: verified, then written out

The compatibility matrix (section 9.2) compiles one small document per cell and
records the outcome. A script then writes `compat.generated.json` beside each
handler. That file is the **complete, explicit per-parent table**: every legal
parent, every way that parent can use, the verdict and the reason.

```jsonc
// lib/nodes/containerBlock.mathElement/thm.tcolorbox/compat.generated.json (excerpt)
{
  "handler": "thm.tcolorbox",
  "generatedFrom": { "key": "sha256:…", "contexts": "sha256:…", "matrix": "run 2026-…" },
  "parents": {
    "containerBlock/columns": {
      "cols.multicol": { "verdict": "ok", "source": "derived", "status": "verified-ok" }
    },
    "containerBlock/footnote": {
      "fn.kernel": { "verdict": "adapt", "set": { "breakable": false, "enhanced": false },
                     "source": "authored", "reason": "a footnote is not breakable", "status": "verified-ok" }
    },
    "table_cell": {
      "tbl.tabular[columns=p|X]": { "verdict": "adapt", "set": { "breakable": false, "enhanced": false }, "status": "verified-ok" },
      "tbl.tabular[columns=l|c|r]": { "verdict": "fallback", "to": "thm.amsthm", "reason": "no paragraph mode", "status": "untested" }
    },
    "containerBlock/mathElement": {
      "thm.tcolorbox": { "verdict": "adapt", "set": { "breakable": false }, "reason": "a box in a box cannot break", "status": "untested" }
    }
  },
  "packageCombos": {
    "deny":  [{ "with": ["ntheorem"], "unless": "ntheorem[amsthm]", "reason": "two theorem engines", "status": "verified-fail" }],
    "allow": [{ "with": ["amsthm"], "status": "verified-ok" }]
  }
}
```

Each cell's `status` is `derived`, `verified-ok`, `verified-fail` or
`untested`. A check fails when a `verified-fail` cell has the verdict `ok`, which
means the contexts or the authored rules are wrong and must be fixed at their
source. `compat.generated.json` is never edited by hand, the same way Flouest
treats `general-nesting.json` and `bundle.json`.

### 4.5 When the rules are checked

1. **When a template is built (static).** Every legal place in the template's
   nesting tree (the dynamic tests already enumerate them,
   `nesting.cli.ts --depth N`) must come out `ok`, `adapt` or `fallback`, for
   **every look** the template offers for each parent. A bare `deny` stops the
   build. The selector then either picks another handler, or narrows the
   template's nesting (`set_node_nesting` removes that parent) and says so in
   its report.
2. **When the document is emitted (dynamic).** Block-scope looks (note, table,
   code) are chosen per node, so a parent's way can differ from one instance to
   the next. The handler asks `engine/context` with its actual ancestors and
   applies adapt or fallback. Flouest's walk already passes the full
   `ancestors: Node[]` (`Emit/walk.ts`), but a handler receives only
   `parentType`. Section 7 adds the ancestors' ways and folded context to
   `RealizationLocation`.

### 4.6 How the rules are found

No source lists these rules. TeX has no type system to ask. Manuals mention
some limits in passing. The research studied preambles, not nesting, so it
says nothing about parents, and package conflicts come up in only 5 of its 924
Solution files (one example: a class that raises an error when `geometry`
loads). So the rules are **measured, never written down**. Flouest already
works this way: `nesting.ts` lets the editor's own normalizers decide which
paths are legal, `limits.ts` measures how much a document holds, and
`passes.ts` measures which kinds need TeX's second pass. The library does the
same for compatibility.

Four separate questions hide in "parent rules". Each has its own source of truth:

| Question | Decided by |
|---|---|
| Is this nesting legal at all? | Flouest's editor (`nesting.cli.ts`). Inherited, not re-decided. |
| Under these ancestor ways, does way C emit correctly? | The matrix (below) |
| Can way A and way B be in the same document? | Pairwise compiles (below) |
| Does way C work under class K? | Class probes and compiles (section 5) |

#### The oracle: what "works" means

A clean compile is not enough. A cell passes only when all four checks hold:

1. **No error.** `texlog.ts` already reads errors and fatal stops.
2. **No damaging warning.** A short, fixed list of warning shapes (`shapeOf`)
   counts as failure: `Float(s) lost`, `Option clash`, `Too many unprocessed
   floats`, `Missing character`, references still undefined after pass 2, and
   overfull boxes past a tolerance. Every other warning is recorded but not failed.
3. **Nothing silently lost.** Every test node carries a **shipout sentinel**: a
   non-immediate `\write-1` (log only) with `\pdfsavepos`, which XeTeX provides.
   A non-immediate write runs only when its box is actually shipped to a page,
   so the log gets one line per sentinel, giving its id, page and position, only
   for content that really printed. Each sentinel must appear exactly once,
   with its position inside the text area (a margin note's sentinel is placed
   as `outside`). The order they ship in is recorded but not judged, because
   floats and footnotes move by design. This catches footnotes lost in a
   `tabular`, floats that never print, content discarded by a box, content
   typeset twice, and text running into the margin or off the page. It needs
   no PDF parsing, which matters because there is no local TeX and no
   `pdftotext` on this machine. Everything runs in ZeroTeX, where it has been
   checked against 14 seeded cases (`testing-pipeline`, step 2).
4. **The feature still does its job.** Each feature tag in a key has a probe.
   - `breakable`: long content must span two pages, with no overfull vbox.
   - `numbered`: sentinel numbers must run in sequence.
   - `footnote`: the note's text must ship on the same page as its mark.
   - `float`: the caption's sentinel must ship.

The look is not part of the verdict; that is fidelity (9.4). The one exception:
when an adapt changes output, the run compares `printOf` of the adapted and
unadapted documents, and records that the look changes there, for example "in a
footnote the box loses its shadow". The template's report then says so.

#### Making the space finite

A cell is (child way and preset) × place × class × co-loaded ways. A **place**
is the ancestor chain, with each ancestor's way and parameters.

- **Places, by context vector.** Enumerate every legal chain from
  `nesting.cli.ts` up to depth 3. Fold each chain's contexts (4.2), and group
  chains by the resulting vector. Compile one representative per vector, plus
  random other chains from the same group. When two chains with the same vector
  disagree, the vocabulary is missing a distinction: the explainer (below) finds
  it, and it becomes a flag or an authored rule. So the flags are a hypothesis
  the sampling keeps trying to break, which is how we know they are right.
- **Parameters.** Each preset, plus both values of every parameter the key marks
  as layout-affecting (`breakable`, float placement, width, column spec). If
  there are many, use a pairwise covering set instead of every combination.
- **Co-loaded packages.** Most package conflicts are between two packages:
  - a name defined twice;
  - an option clash;
  - load order;
  - two packages that both replace the output routine (`flowfram`'s manual warns of this).

  So: compile every pair of core ways, then each tail way against the core
  ways. Conflicts among three or more come from real data: every full set of
  ways one Solution file uses is compiled as one document.
- **Classes.** Each way under the classes the corpus uses most. Section 5
  measures the class profiles by loading the class and reading what it
  preloaded and defined.

**Cost.** `engine.ts` records that on an M2 Pro, 156 compiles took 112 to 154 s
on 4 to 8 engines. That is about 1.3 compiles a second for full filed documents,
and minimal ones should be faster. The theorem pilot is roughly 7 ways × about 3
presets × tens of vectors × about 6 classes, plus about 400 pairs: a few thousand
compiles, under an hour. Every cell is cached by hash (ADR-213), so later runs
compile only what changed.

#### From a failing cell to a rule: the explainer

A red cell isn't a rule yet. The explainer shrinks it to a minimal reproducer,
using the same halving search `limits.ts` uses:

1. Drop ancestors one at a time to find the shortest chain that still fails. This sets the rule's `scope`.
2. Flip the parent's parameters to find the one that matters. This gives the `when` predicate.
3. Drop co-loaded packages to find the one that matters. This gives `withPackages`.
4. Try the handler's adapt candidates: drop `breakable`, use `\captionof` instead of a float, and so on. The first one that passes gives an **adapt**.
5. If none passes, try the key's fallback chain in order. The first one that passes gives a **fallback**. Otherwise the cell is **deny**.

The result is a candidate rule with its reproducer attached as
`evidence: { kind: 'compile', cell, reproducer }`. A person reviews it.

- If it fits a flag, the fix is to the handler's `needs`/`gives`.
- Otherwise it becomes a layer-2 rule.

Nothing enters a key without a reproducer, a manual citation, or a source line.

#### Where docs, source and the corpus fit

They supply **hypotheses**, not verdicts. Each enters as an authored rule with
`status: untested` until the matrix confirms or rejects it.

- **Package manuals.** Stated limits, for example a box that can break only
  outside other boxes. Evidence is the manual and its section.
- **Package and class source.** `\PackageError`, `\ClassError` and
  `\@ifpackageloaded` lines. For example, the research cites a class that
  errors on `geometry` at `cjs-rcs-article.dtx:3208`. Evidence is the file and line.
- **The corpus.** A set of ways one template loads and compiles is evidence for
  them coexisting, but says nothing about nesting.
- **Flouest's handlers.** The two adaptations in 4.3 have already run in
  production. They are verified the first time the matrix runs.

When a manual says one thing and the matrix shows another, the cell is flagged
for a person to decide; usually the cause is a package version difference.

#### What the rules are valid for, and what stays unknown

- **Package versions.** Verdicts hold for the pinned MiKTeX snapshot (ADR-332).
  The snapshot id is part of every cell's hash, so a new snapshot reruns only
  through cache misses.
- **What a template relies on.** At template build, every cell the template can
  reach must be `verified-ok`, or a verified adapt or fallback. Missing cells
  are compiled then and there, on demand. So for any template we ship, we know
  because we compiled it, even while the global table is still filling in.
- **What we never modelled.** Raw user LaTeX, extreme sizes, chains deeper than
  tested. A compile failure in a real document is turned into a reproducer and
  added as a cell, so the table learns from production.
- **Taste.** "Works but looks wrong" is fidelity, and is not decided here.

---

## 5. Class profiles

```ts
type ClassProfile = {
  id: ClassId;                                 // 'class.llncs'
  base?: ClassId;                              // the class it loads: a key's rule for it holds here too
  zerotex: Support;
  preloads: PackageLoad[];                     // amsart: amsmath, amsthm
  defines: Resource[];                         // llncs: env:theorem, env:lemma, env:proof ...
  options: Record<string, OptionEffect>;       // acmart: acmthm=false removes its theorem environments
  forbids: {
    technical: PackageRule[];                  // measured: the class errors, clashes or breaks with it (geometry under cjs-rcs-article)
    policy: PackageRule[];                     // read: the publisher forbids it though it compiles (AAAI's preamble blacklist)
  };
  layout: { columns: 1 | 2; textwidth: string; fontsize: string };  // measured by the probe
  files?: { path: string; sha256: string }[];  // a class not on the mirror, as Flouest's DocumentClass.files
  vocabulary: Record<string, string>;          // front-matter commands, for class-native handlers
  evidence: Evidence[];
};
```

`zerotex`, `preloads`, `defines`, `layout` and `forbids.technical` are
**measured** by the class probe (9.3). `forbids.policy` and `vocabulary` are
**read** from documents. No compile can find a policy rule: ACM's "changing list
definitions is not allowed" and AAAI's ban on `geometry`, `hyperref`,
`titlesec` and `multicol` all compile fine.

The probe is built and has measured the 12 pilot class settings
(`testing-pipeline/out/profiles/`). Some of what it found:
- `acmart` refuses `titlesec`;
- `llncs` refuses `titlesec` and `amsthm`;
- `revtex4-2` refuses `multicol`;
- `memoir` and KOMA object to `titlesec` (and KOMA to `tocloft`);
- `acmart` and `llncs` already define General's theorem environments.

The class check is resource-based, not a list of allowed classes. There are 442
distinct classes in the research, 350 of them used by one template, so
allow-lists can't scale. A conflict is:

- `handler.defines ∩ class.defines` (llncs and acmart already define `theorem`),
  unless a handler param renames the environment or a class option removes it;
- `handler.loads ∩ (class.forbids.technical ∪ class.forbids.policy)`;
- an option clash between `handler.loads` and `class.preloads`.

Seeds: the class section of `_Lib.md` (vocabulary), the 104 documents in
`Template/template-requirement/` (what each class forbids), and the
"Class-native vocabulary used" lines of the Solution files.

`thm.class-native` (87 templates) is a real handler: it emits the class's own
environments and sets `classes.only`.

**Built (`Latex-Lib/classes/`).** 46 profiles: the classes the research's
templates use most (article 302 templates, book 52, beamer 47, report 41,
ltxdoc 35, scrartcl 18, scrbook 12, memoir 9, scrreprt 8, letter 8, extarticle
7, the ctex classes 12, scrlttr2 6, moderncv, tikzposter, jlreq and the Tufte
classes 3 each, amsproc, extreport, exam, a0poster), the kernel's proc and
minimal and extsizes' extbook, the pilot's journal classes, and the journal classes
Flouest has requirement documents for (Springer Nature's sn-jnl, SIAM's
siamart, MDPI, AASTeX, A&A, MNRAS, LIPIcs, EasyChair, Elsevier's cas-sc and
cas-dc, IOP's iopjournal). Nine are measured by the probe
(`testing-pipeline`); the other 37 are read from their requirement documents,
the research's Solution files and CTAN, each source cited, and wait for the
probe. Each has a class setting in `testing-pipeline/settings/classes/` (jlreq
aside, as it does not run in ZeroTeX-NG), so `compat probe` measures them all. A class that loads
another names it as its `base` (ctexbeamer on beamer, ltxdoc and the journal
classes built on article), and a key's rule for the base holds under it. Each profile says what the class defines: its counters, its
environments (abstract, figure, table, thebibliography, theorems), its commands
(`\maketitle`, `\tableofcontents`, `\appendix`).

Class rules come in two kinds:
- **What a way needs, against what the class has.** A way says what it
  `requires` of the class: a heading its level's counter (`counter:{kind}`), a
  figure way the `figure` environment, a title way `\maketitle`, a BibTeX way
  `thebibliography`, the kernel abstract `env:abstract`. The resolver checks
  them against the profile, so no rule names the class: book has no abstract,
  letter no sections, floats, title, contents or bibliography, beamer no
  `\chapter` or `paragraph` counter, IEEEtran no `part`.
- **What a document or a measurement says, on the way's key.** ACM forbids
  changing list definitions (enumitem, paralist, enumerate, scrextend under
  acmart); acmart stops a restyled `\section` (titlesec, measured; sectsty, which
  does the same); KOMA-Script and memoir object to titlesec and KOMA to tocloft
  (measured warnings), and style these themselves (`head.koma-fonts`,
  `toc.koma`, `head.memoir-style`); beamer replaces the lists, sections and
  contents those packages restyle, loads xcolor itself (so no
  `[table]{xcolor}`), places floats where they start (no wrapfig, sidecap,
  sideways figures) and does not break a frame (no longtable); amsbook builds
  in amsmath and amsthm and the AMS asks that neither be loaded; aa redefines
  `\newtheorem` with two more arguments (so not the kernel's); siamart loads
  ntheorem (so not amsthm or thmtools). A class's forbidden packages are the
  profile's: AASTeX stops at cite, mcite and multicol and asks that hyperref not
  be loaded again; LIPIcs forbids times, enumitem and paralist. A class whose
  abstract is a command (sn-jnl, mdpi, aa) has no abstract environment, so the
  class-native abstract has a command form, `\abstract{…}` in the preamble.
  The Tufte classes define `\sidenote` and `\marginnote` themselves, so the
  sidenotes and marginnote packages clash with them (the ways now say what
  they define); a tikzposter's content sits in `\block{title}{content}`, a macro
  argument, so no verbatim code way goes there; exam's `\part` is a question's
  part, so the profile offers no part heading; moderncv prints its header with
  `\makecvtitle`, so the kernel title ways are refused there; minimal offers
  nothing a way could rest on. A way's names that come with a package (amsthm's
  `proof`) are the package's, so a class that already carries the package
  (amsbook, amsproc, EasyChair) does not clash with them; and the class-native
  theorem way covers the AMS classes and jlreq, whose own `\newtheorem` gives
  the class's look.

---

## 6. Structured preamble

Today Flouest de-duplicates preamble lines as exact strings
(`Emit/preamble.ts`, `Set<string>`). So `\usepackage{xcolor}` and
`\usepackage[table]{xcolor}` both print, and LaTeX stops with an option clash.
With handlers chosen independently this will happen often.

The merger:

1. collects `PackageLoad`s from the class, the document-level ways and every
   handler used;
2. unions options per package, and fails on pairs the package facts mark as
   exclusive;
3. orders the loads by the package facts' rules (`hyperref` late, `cleveref`
   after it, `xcolor` options before `tcolorbox` loads it);
4. prints the lines, and hands Flouest a `PreambleRequirement` it can print
   unchanged.

It runs once per compile, and it is a pure function, as the plug-in rules require.

---

## 7. Integration with Flouest

| Flouest piece | How the library uses it |
|---|---|
| `Realization` (`Profile_General/types.ts`) | A handler's `handler.ts` is a `Realization`. No new emit interface. |
| `Packages/` printers | Handlers call them; a missing parameter is added to the printer, typed, with `check:saved-looks` coverage. |
| Plug-ins (`Plugins/plugins.ts`) | A generated template's `plugins/` are `HandlerPlugin`s built by `engine/bridge` from the chosen handlers. Style names are the template's look names, and `plain` is always present (`checkPlugins` requires every style General has). |
| Theme-Lib | Look names stay shared (`catalog/`). A preset can be registered as a template's realization of a catalog look with `set_look`. |
| Nesting | The parent universe comes from `general-nesting.json` and the template's `set_node_nesting` output; legal places come from `nesting.cli.ts`. |
| Template pipeline | The automation's output is one `defineTemplate` call (`template-pipeline-journal/define.ts`), checked with `check_template` and built by the constructor, as `templates/acm/` is. |
| Dynamic tests | `engine.ts` compiles in ZeroTeX-NG in headless Chrome, cached by content hash. The matrix and the fidelity loop use it. |

Compiler changes. The compiler is ours to edit (ADR-185); each change needs an
ADR and a `regress` run:

1. **Structured preamble**: accept `PackageLoad`s alongside strings, merged as
   in section 6.
2. **Ancestor context**: add `ancestors: { nodeId, way, preset }[]` and the
   folded `context` to `RealizationLocation`, computed in the emit walk from
   `ancestors: Node[]` and the profile's lookup. General's existing parent
   checks keep working; they become rules in its keys.

Engine note: **ZeroTeX-NG is the only engine**, and not a variable. Flouest
compiles there (compiler README; the ACM caller, ADR-321), and ZeroTeX-NG
typesets with XeTeX in the browser. So a key, a class profile and a package's
facts carry one field, `zerotex` (yes, no, untested), and nothing about pdfTeX,
LuaTeX or a desktop XeLaTeX; the research's engine tags (`pdf`, `xe/lua`) are
not carried over. Something that does not run in ZeroTeX-NG is marked `no` and
goes nowhere: `code.minted` and `fig.svg` (shell escape), jlreq (pLaTeX, upLaTeX
and LuaLaTeX only). The Solution check counts a template under such a class
apart, not as the library's failure.

---

## 8. Selection: the automation

The AI layer that builds this is planned in `Ai/ARCHITECTURE.md`: the model
writes one target key per node and one for the class, in the library's
vocabulary; code checks them, matches them to handlers by a scored search
(exact way, features, presets, packages, description embeddings), chooses one
handler per node together through the resolver, and writes the template.

```
target template (Solution file, requirement doc, or a new zip read by the rubric)
   │  intake/
   ▼
TargetSpec { class, engine, docWays[], nodes: [{ node, way, params, evidence }], tier hints }
   │  select/
   ▼
1. candidates: for each node, the handler with the target's way id; else the
   nearest handlers by features and presets (approximation tier)
2. constraints (resolve/): class, document-wide claims and conflicts, merged
   preamble, per-parent rules over every legal place in the template's
   nesting, every offered look
3. search: backtracking over at most about 7 candidates per node, constraints
   sparse; prefer exact > handler-logic > approximate > artwork asset > drop
4. params: target parameters -> handler params (Solution "Parameters" column)
   │  bridge/
   ▼
defineTemplate({ documentClass, kinds, attrs, nesting (possibly narrowed),
                 looks, plug-ins, files }) -> check_template -> construct
   │  verify/
   ▼
report: per node its way, tier, adapts, fallbacks, narrowed nesting, fidelity score
```

Fidelity tiers, from the research's failure analysis. The selector records one
per node:

| Tier | When | Example |
|---|---|---|
| `ship-class` | The template's class/sty is zip-local, its licence allows shipping, and it runs in ZeroTeX. It goes in `files` with its sha256 (template pipeline step 8), and handlers emit only the body in the class's vocabulary. | Setting aside blockers that sit only in zip-local classes takes the research's yes count from 688 to 752 |
| `exact` | A library handler with params reproduces it. | `thm.amsthm` with the template's style |
| `handler-logic` | Logic that depends only on content or options moves into the TypeScript handler. | awesome-cv's heading split into two colours |
| `approximate` | Needs TeX's layout state (page position, measured boxes, output routine). Use the nearest handler and record what is lost. | AAAI's copyright box becomes `\thanks` |
| `asset` | Fixed artwork, rendered once at build time and placed with `bg.eso-pic`/`bg.background`. | a title-page swoosh |
| `drop` | Code the template's sample never runs. | custom code in 17 templates and artwork in 10, in the research |

Licence gate: `ship-class` and `asset` copy the author's work. The research
lists 91 templates with no established licence and 69 GPL ones. For those, the
selector must use `exact`, `handler-logic` or `approximate`.

---

## 9. Verification

### 9.1 Unit and schema checks
- Every key validates; every id it names resolves; every parent in `parents`
  is a legal parent in `general-nesting.json`.
- Each handler's emitted LaTeX is fixed by snapshot per preset and per adapt rule.
- `compat.generated.json` is up to date with its key, contexts and matrix
  (hashes match), or the check fails, like Flouest's `verify` with generated JSON.

### 9.2 Compatibility matrix
- The method is in 4.6: which cells exist, the four-check oracle with shipout
  sentinels, and the explainer that turns a failing cell into a rule.
- Compile with the dynamic tests' `engine.ts` (ZeroTeX-NG, cached by hash) and
  read the log with `texlog.ts`, extended with the sentinel reader and the list
  of damaging warning shapes.
- Write the results into the cells and regenerate `compat.generated.json`.
- Page images for a sample of cells, to check that the sentinel oracle isn't
  missing something.

### 9.3 What the test harness needs

**What it does today.** Flouest's dynamic tests already split on packages,
and already cross parent and child:

- A variant is one **package set** × one value of each true/false setting
  (ADR-199, `variants.ts`). The package set is read from the LaTeX the compiler
  writes, libraries included (`lib:skins`) and options left out, so
  `biblatex[style=numeric]` and `biblatex[style=alphabetic]` are one variant.
  Every other setting is not split on; its values rotate across the variant's
  members.
- The split tree gives every place one node per variant of its kind, and splits
  everything below again under each one (ADR-206, `splitting.ts`). So every
  combination of the parent's variant and the child's variant along a path is
  already compiled. Under General at depth 2 that is 3,580 branches, with
  `containerBlock/mathElement` in 4 variants at 428 places.
- Filing packs many branches into one document (`filing.ts`), so packages from
  different nodes already meet. When a document stops, the runner typesets the
  failing branch alone (ADR-209).
- The class comes only from the template (`DocumentClass` in `caller.ts`:
  `line`, `preamble`, `files`). A run is one template: General (`article`),
  `acm` (`acmart[manuscript]`), `ieee-access` (`ieeeaccess`), and so on.

**What changes for the library.** Five changes to how branches are built, plus
the class axis.

1. **Split on the handler, not only its packages.** Two ways that load the same
   packages, or none, fall into one variant today: `thm.kernel` and
   `thm.class-native` both load nothing. The variant key becomes way id ×
   package set × compatibility params × true/false settings.
2. **Split on the options that matter, rotate the rest.** Leaving options out
   is right for looks but wrong for a few that change compatibility
   (`ntheorem[amsthm]`, `xcolor[table]`, `breakable`, column specs). The key
   marks those params `compat: true`. They join the variant key; every other
   param keeps rotating as members do now.
3. **Variants come from the library.** Today they come from `themeChoicesFor`,
   the looks the app's picker offers. In library mode they come from each node's
   handlers × presets, installed for the run as `HandlerPlugin`s.
4. **Split below a parent by context, not by variant.** Crossing every parent
   variant with every child variant multiplies at each level. With 7 theorem
   ways instead of 4 variants, and similar growth in tables, images and code,
   depth 3 would not finish. Instead, the subtree below a place is split once
   per distinct context vector its variants give (4.2). Parent variants with the
   same vector share one subtree and rotate through it, as members rotate today.
   Sampling of other parent variants then tests the shared-vector assumption (4.6).
5. **Pair coverage in filing.** Which packages meet in a packed document is
   chance today. The filer should aim for every pair of ways from different
   nodes to share at least one document (a covering design). When a document
   fails and each branch passes alone, the runner halves the document down to
   the pair that fails together. That pair becomes a package-combination rule.

These are new entry points beside the existing ones, so the template tests
keep ADR-199 and ADR-206 as they are. They are incubated here, in
`testing-pipeline/` (its `ARCHITECTURE.md`). Its step 4 has built changes 1
and 3 for General: the variant key holds the way id, General's package methods
are the interim ways, and a way can bring its own handler as a plug-in. It
also gave every branch an id from its own path, so a new way adds branches and
documents without moving any. Its step 5 ran General under every pilot class
setting and setup, with each way's variants also typeset alone so a way's own
defects are not counted against every nesting it sits in. Its step 6 built
the explainer of 4.6: each failure group is halved to the fewest branches
that still show it, shortened to the shortest legal chain, and tried with the
parent's other ways and members and the child's other ways, giving a
candidate rule with its reproducer for a person to review; accepted rules go
into each way's compat table. That is the halving in change 5. Change 4 is
its step 7; change 2 and pair coverage in filing are still to come.

**The class axis: what's missing entirely.** Today a way never meets a class
other than the one its template uses, and no restriction a class imposes is
measured. Three pieces:

- **Class as a run parameter.** `--class <profile>` builds a test template:
  General's nesting and attrs, the library's ways, with only `DocumentClass`
  swapped (line, preamble, files). The editor still settles under General, so
  the tree is the same; only the compile changes. The full split runs under
  the most-used classes. Every other class gets the probe plus one
  representative branch per way.
- **The class probe**, which measures the profile:
  1. *Loads at all.* A minimal document. This gives `zerotex` (the research
     found templates that need pdfTeX).
  2. *What it brings.* At `\AtEndDocument`, write `\@filelist` (the packages it
     preloaded) to the log. Then, for every name any handler declares in
     `defines`, write whether the class already defines it (`\ifcsname`). This
     gives `preloads` and `defines`, and every name conflict follows from it
     without compiling the handlers.
  3. *Layout.* Write `\textwidth`, `\columnwidth`, twocolumn and font size.
     This gives `layout`, and the `columns` context (`figure*`) for every node.
  4. *Load tests.* For each package any way loads, compile the class plus that
     package alone. This catches a class that errors on a package (the
     `geometry` case), an option clash with something preloaded, and a name
     defined twice. It is one compile per package per class, about 150. This
     gives `forbids.technical`.

  Then the matrix compiles each way under the class to confirm.
- **Policy restrictions** come from the 104 documents in
  `Template/template-requirement/`, as `forbids.policy` with the line as
  evidence. They are checked statically: the resolver must never pick a
  forbidden package or command for that class, and a test asserts it.

A class that isn't on the pinned mirror needs its files, as `DocumentClass.files`
does today (ADR-254). Testing a zip-local class locally is fine. Shipping it
still goes through the licence gate.

### 9.4 Fidelity
- Compile the original template's sample with a full TeX installation (it may
  need pdfTeX or a class ZeroTeX lacks), and the generated template's starter
  with ZeroTeX.
- Compare page images: pixel/SSIM per page region, plus a vision-model judgement
  per region (title block, headings, statements, figures, running heads).
- Each template gets a fidelity score in place of the research's yes/no.
  Regressions are caught by rerunning on every library change.

---

## 10. Seeding the library from existing data

| Source | Gives |
|---|---|
| `_Lib.md` (lib v6) | about 370 way ids with descriptions (their engine tags are not carried over: ZeroTeX-NG is the only engine): key stubs, `status: draft` |
| `Solution/*.md` (924) | how often each way is used (build order), the parameters actually used (presets), evidence lines, class vocabulary |
| `Template/template-requirement/*.md` (104) | class `forbids`, required packages |
| Flouest `Packages/` (21 package printers) | param types |
| Flouest General handlers | the first handler per node, and the first authored parent rules (section 4.3) |
| Package manuals (CTAN), package and class source | candidate conflicts, option exclusivity, load order: hypotheses with `status: untested` until the matrix checks them (4.6) |

Build order follows usage (`node seed.ts thm` counts the Solution files whose
component map names each way: 109, 51, 16, 13, 9, 8, 4, in this order; the
counts below are of every mention). For theorems: `thm.amsthm` 205 templates,
`thm.class-native` 87, `thm.kernel` 25, `thm.thmtools` 24, `thm.tcolorbox` 19,
`thm.ntheorem` 14, `thm.mdframed` 5.

---

## 11. Milestones

**M0: schema and checks.** Key, preset, class and package types; the context
vocabulary; validators; the `compat.generated.json` writer with no matrix yet.
Decide the Flouest commit to pin.

*Built (`Latex-Lib/`).* The schema (`schema/`), with conditional definitions
(a name a handler defines only when its params match) and `{kind}` for each
kind of the node. The validator names every id that does not resolve (way,
class, package, option, library, parent, parameter), every word outside its
vocabulary, every preset value outside its schema, and every rule without
evidence on a verified key. Contexts fold down the chain: an allowance once
off stays off, a situation once on stays on, boxes add. The compat writer
derives each parent way's row from contexts, lets authored rules win (deny >
adapt > allow), and records the hashes it was made from; `npm run verify`
finds a stale one. Flouest is pinned by file hash (`flouest.lock.json`, 27
files), as the checkout is not a git repository. 29 tests.

**M1: theorem pilot** (`containerBlock/mathElement`).
- The 7 handlers above, with keys, presets seeded from the Solution files'
  parameters, and authored rules for its 9 parents (appendix, acknowledgement,
  columns, footnote, listing, abstract, mathElement, table_cell, table_header).
- Class profiles for the classes those templates use most (article, amsart,
  llncs, acmart, memoir, KOMA, IEEEtran, elsarticle, revtex). The class
  probe and `--class` measure them, and their policy rules are read from
  `template-requirement/`.
- The harness changes from 9.3: variants keyed by way and compat params, built
  from the library, split by context, and filed for pair coverage, all in new
  entry points.
- The matrix over its parents under those classes, with the oracle and the
  explainer from 4.6. Measure the number of context vectors and the compile
  rate. Seed sentinel failures on purpose (a footnote in an `l` column, a float
  in a box) to show the oracle catches them.
- Exit when: every cell has a verified status; for every Solution file that
  uses a `thm.*` way, the resolver picks that way (or the class-native one) with
  no violated rule; and the generated plug-in compiles in ZeroTeX inside a real
  template (`acm` and `General`).

*Where it stands.* The 7 handlers, keys and presets are built, with class
rules and the 17 class profiles above. `node cli.ts solutions` checks every
Solution file that uses a theorem way, under the class its row names or the
template's own: of 210 checks, 129 are under a profiled class that runs in
ZeroTeX-NG and every one resolves (118 with the template's way as it is, 8
renamed, 3 by a fallback, each a template whose theorems come from its own
bundled class); 1 is under jlreq, which does not run in ZeroTeX-NG; 80 wait for
their class's profile, mostly classes a single template ships. The pick tries
each of the way's presets (the one citing the template first) before renaming
or falling back. The matrix over the pilot's parents was
started (`compat run --library`) and stopped before it finished, so no cell is
verified yet; the parent rules are General's two adaptations and the
contexts.

**M2: compiler changes.** Structured preamble and ancestor context, each with an
ADR and `regress`.

**M3: the rest of the nodes, by usage.** Heading, note/box, image and caption,
table, code, footnote, abstract, title/front matter, bibliography, columns, lists;
then the `doc` ways (page, fonts, headers and footers, spacing, colour).

*Where it stands.* Every node's ways have keys, parameters, presets and
handlers at the pilot's depth (section 2.1). What M3 still lacks is what M1
went on to do: compiling each preset in the matrix, the parent rules and
context needs the matrix finds, and the Solution check for each node (the
pilot's `node cli.ts solutions`). Those wait for the matrix runs. The matrix
now takes 28 of the 32 nodes, every preset of their 97 ways
(`testing-pipeline/ARCHITECTURE.md` section 10, step 6b). Code, inline maths,
references and footnote anchors need a change in Flouest first, since its
emitter prints them in one fixed style. Captions
(the research's `cap.*`) and the `doc` ways are not built.

**M4: the automation.** Intake from Solution files and requirement documents,
selection, template generation, the fidelity loop, run on a held-out set of
templates not used to seed presets.

**M5: tiers.** Handler-logic, approximation, artwork as assets, ship-class with
the licence gate.

---

## 12. Risks and open decisions

- **Location.** Incubate here, then move into Flouest as `Handler-Lib/` (section 2).
  Needs the owner's agreement and an ADR.
- **Context vocabulary creep.** Keep it to about 10 flags; anything else is an
  authored rule.
- **Per-instance looks.** They make the parent's way dynamic. Without the
  ancestor-context change (section 7), emit-time adapt and fallback can only
  see `parentType`.
- **Compiles is not the same as looks right.** Shipout sentinels catch lost and
  misplaced content (4.6). They can't judge looks, which page images and
  fidelity cover.
- **Matrix cost.** About 1.3 compiles a second on an M2 Pro, as Flouest has
  measured, so the pilot takes under an hour. Every pair among about 370 ways
  would be about 68,000 compiles, so pairs are core × core plus tail × core, not
  all × all. Everything is cached by hash.
- **The context hypothesis.** Grouping chains by context vector assumes chains
  with equal vectors behave alike. Random sampling inside each group tests that
  assumption; if it fails often, the vocabulary grows, or depth-3 chains get
  compiled directly.
- **The long tail.** Core ways saturate, but special-purpose packages (still 10
  to 20 new per 100 templates) and classes (about 40 per 100) do not. The
  library is finite for the core, and open for the tail by design.
- **Research gaps.** 76 templates are not yet analysed, nothing in the research
  was compiled, and only 25 verdicts were audited.
