/**
 * Gold (ARCHITECTURE.md section 8): a Solution file of the research read into
 * a target document, with the research's answer kept beside each key. The
 * search gets the target document alone (`targetOf`) and is scored on whether
 * it finds the answer. Nothing is judged here; every word comes from the
 * Solution file, and the Way column, which is the answer, never reaches a key.
 *
 * The class key is the class as the template names it: the `- Class:` line's
 * published class (`llncs`), or, when the template ships its own class, that
 * class's name and the class it loads. Its answer is the class profile the
 * research names. Each component-map row gives a target key per way in its
 * Way column: a way the library has becomes a key of each node that way
 * serves; a way it lacks is answered by name (`named`), its key at the node
 * where most of its component's library ways sit, or at document level when
 * the library has no way of that component. A key's description is the row's
 * part and parameters, with any way id taken out (a class id kept as the
 * class's name), and its packages are the packages the library knows that
 * those words name. Rows naming only a class (`class.beamer` for native
 * sections) say the class realises the part, and give no key.
 */
import { readdirSync, readFileSync } from 'node:fs';
import { basename, join } from 'node:path';

import type { Evidence } from '../../Latex-Lib/schema/evidence.ts';
import { DOC_NODE, type ClassId, type NodeId, type WayId } from '../../Latex-Lib/schema/ids.ts';
import type { Library } from '../../Latex-Lib/schema/validate.ts';
import { RESEARCH } from '../../Latex-Lib/seed.ts';

import type { TargetClass, TargetDocument, TargetKey } from './model.ts';

/** One component-map row: its line, its part, the ways in its Way column (a proposal's `NEW:` dropped), its parameters. */
export type Row = { readonly line: number; readonly component: string; readonly ways: readonly string[]; readonly parameters: string };

export type Solution = {
  /** `Solution/0001-digital-minimal.md`, as the library's evidence names it. */
  readonly file: string;
  /** The template's id, which is also its folder under `Source/`. */
  readonly id: string;
  readonly verdict: string;
  readonly classLine?: { readonly text: string; readonly line: number };
  readonly origin: string;
  readonly rows: readonly Row[];
};

/** The research's answer for one key: the library's way it names, or, when the library lacks it, the way by the research's name. */
export type Answer = { readonly way: WayId | null; readonly named?: string };

export type GoldKey = { readonly key: TargetKey; readonly answer: Answer };

/** A template's target document with the research's answers beside its keys. */
export type Gold = {
  readonly source: TargetDocument['source'];
  /** The class key, and the profile the research names for it: the class's own, or, for a class the template ships, the one it builds on. */
  readonly class: { readonly key: TargetClass; readonly answer: { readonly id: ClassId | null; readonly base: ClassId | null } };
  readonly nodes: readonly GoldKey[];
  readonly document: readonly GoldKey[];
};

/** What the search gets: the target document, without the answers. */
export const targetOf = (gold: Gold): TargetDocument => ({
  source: gold.source,
  class: gold.class.key,
  nodes: gold.nodes.map((g) => g.key),
  document: gold.document.map((g) => g.key),
});

/** A description is for the embedding match; past this it is cut. */
const DESCRIPTION = 400;

/** Ties between nodes for a component's home, broken by hand: a bibliography way the library lacks is about the list, not the citation. */
const HOME_TIES: { readonly [component: string]: NodeId } = { bib: 'containerBlock/refContainer' };

const WAY = /`(?:NEW:)?([a-z][a-z0-9]*\.[a-z0-9][a-z0-9-]*)`/gu;

/** A file's extension, which a way id never ends in: `main.tex` is a file, not a way. */
const FILE = /\.(?:tex|ltx|sty|cls|bst|bib|dtx|ins|cfg|def|clo|fd|mbs|pdf|png|jpe?g|eps|svg|md|txt|lua|py|json)$/u;

/** The research's components (`thm`, `sp`), from its way list and the library's ids: a backticked `thm.amsthm` in a description is an answer. */
const components = (library: Library): Set<string> => {
  const lib = readFileSync(join(RESEARCH, '_Lib.md'), 'utf8');
  return new Set([...[...lib.matchAll(WAY)].map((m) => (m[1] ?? '').split('.')[0] ?? ''), ...library.keys.map((k) => k.id.split('.')[0] ?? '')]);
};

/** Text with the answers taken out: a class id becomes the class's name (the template names its class), any other way id goes. */
const withoutAnswers = (text: string, known: Set<string>): string =>
  text.replace(/`(?:NEW:)?([a-z][a-z0-9]*)\.([a-z0-9][a-z0-9-]*)`/gu, (all, component: string, name: string) => {
    if (FILE.test(`.${name}`) || !known.has(component)) return all;
    return component === 'class' ? `\`${name}\`` : '';
  });

const cut = (s: string, n: number): string => {
  const t = s.replace(/\s+/gu, ' ').trim();
  return t.length <= n ? t : `${t.slice(0, n - 1)}…`;
};

export const readSolution = (path: string): Solution => {
  const lines = readFileSync(path, 'utf8').split('\n');
  const field = (name: string): { text: string; line: number } | undefined => {
    const i = lines.findIndex((l) => l.startsWith(`- ${name}:`));
    return i < 0 ? undefined : { text: (lines[i] ?? '').slice(name.length + 3).trim(), line: i + 1 };
  };
  const rows: Row[] = [];
  const start = lines.findIndex((l) => l.startsWith('## Component map'));
  for (let i = start + 1; start >= 0 && i < lines.length && !(lines[i] ?? '').startsWith('## '); i++) {
    const text = lines[i] ?? '';
    if (!text.startsWith('|') || /^\|[\s|:-]+\|$/u.test(text)) continue;
    const cells = text.split(/(?<!\\)\|/u).slice(1, -1).map((c) => c.trim());
    if (cells.length < 4 || cells[0] === 'Component') continue;
    rows.push({ line: i + 1, component: cells[0] ?? '', ways: [...(cells[2] ?? '').matchAll(WAY)].map((m) => m[1] ?? ''), parameters: cells.slice(3).join(' | ') });
  }
  const classLine = field('Class');
  return {
    file: `Solution/${basename(path)}`,
    id: basename(path, '.md'),
    verdict: (lines[0] ?? '').trim(),
    ...(classLine === undefined ? {} : { classLine }),
    origin: field('Class origin')?.text ?? '',
    rows,
  };
};

/** Every Solution file of the research, by name. */
export const solutionPaths = (): string[] => {
  const dir = join(RESEARCH, 'Solution');
  return readdirSync(dir).filter((f) => f.endsWith('.md')).sort().map((f) => join(dir, f));
};

/** For each component, the node most of its library ways serve. */
export const componentHomes = (library: Library): Map<string, NodeId> => {
  const counts = new Map<string, Map<NodeId, number>>();
  for (const k of library.keys) {
    const component = k.id.split('.')[0] ?? '';
    const byNode = counts.get(component) ?? new Map<NodeId, number>();
    byNode.set(k.node, (byNode.get(k.node) ?? 0) + 1);
    counts.set(component, byNode);
  }
  const homes = new Map<string, NodeId>();
  for (const [component, byNode] of counts) {
    const best = Math.max(...byNode.values());
    const tied = [...byNode].filter(([, n]) => n === best).map(([node]) => node).sort();
    homes.set(component, tied.length > 1 && HOME_TIES[component] !== undefined ? HOME_TIES[component] : (tied[0] ?? DOC_NODE));
  }
  return homes;
};

/** A class's name as a file names it: its last path part, without `.cls`. */
export const className = (name: string): string => (name.split('/').pop() ?? name).replace(/\.cls$/u, '');

/**
 * The class a template ships, as its Solution file names it. The research
 * writes such a class as the published class it builds on (`class.article`)
 * and names the shipped one in passing: `\documentclass{resume}`, "the
 * zip-local `hilbert`", "`class.acp` is zip-local", or its file
 * (`olplainarticle.cls:19`). Only the main sample's part of the line counts.
 */
const shippedClass = (text: string): string | undefined => {
  const main = text.split(/\b(?:[Oo]ther samples?|Second sample)\b/u)[0] ?? '';
  if (!main.includes('zip-local')) return undefined;
  const found =
    /\\documentclass(?:\[[^\]]*\])?\{([^}]+)\}/u.exec(main)?.[1] ??
    /zip-local(?: (?:class|wrapper|wrapper class|model class))?,?\s*`(?:class\.)?([A-Za-z][\w./-]*)`/u.exec(main)?.[1] ??
    /`class\.([a-z0-9-]+)`,? (?:is zip-local|\(zip-local)/u.exec(main)?.[1] ??
    /([\w./-]+)\.cls\b/u.exec(main)?.[1];
  return found === undefined ? undefined : className(found);
};

/** The options the class line gives: the backticked lists after "options", or a bare list that looks like options (`a4paper,12pt`), not words. */
const classOptions = (text: string): string[] => {
  const m = /[Oo]ptions:?\s*((?:`[^`]*`(?:,\s*|\s+and\s+)?)+|(?:[\w=.-]+,\s*)*[\w=.-]+)/u.exec(text);
  const said = m?.[1] ?? '';
  if (said.includes('`')) return [...said.matchAll(/`([^`]*)`/gu)].flatMap((x) => (x[1] ?? '').split(',')).map((o) => o.trim()).filter((o) => o !== '' && o !== 'none');
  const items = said.split(',').map((o) => o.trim().replace(/[.;:]+$/u, '')).filter(Boolean);
  return items.length >= 2 || /\d|=|paper|side|column|open/u.test(items[0] ?? '') ? items : [];
};

const goldClass = (s: Solution, library: Library, known: Set<string>): Gold['class'] => {
  const profiles = new Map(library.classes.map((c) => [c.id, c]));
  const evidence: Evidence[] = [{ kind: 'solution', file: s.file, lines: String(s.classLine?.line ?? 1) }];
  const text = s.classLine?.text ?? '';
  const description = cut(withoutAnswers(`${text}${s.origin === '' ? '' : ` Origin: ${s.origin}`}`, known), DESCRIPTION);
  // The published class the line names first, or the base it says a shipped class builds on; else the first class a row names.
  const declared = /^`(class\.[a-z0-9-]+)`/u.exec(text)?.[1];
  const base = /[Bb]ase[^`]{0,24}`(class\.[a-z0-9-]+)`|(?:over|loads) `(class\.[a-z0-9-]+)`/u.exec(text)?.slice(1).find(Boolean);
  const loaded = /\\LoadClass(?:WithOptions)?(?:\[[^\]]*\])?\{([a-z0-9-]+)\}/u.exec(text)?.[1];
  const fromRows = text === '' || /^none\b/u.test(text) ? s.rows.flatMap((r) => r.ways).find((w) => w.startsWith('class.')) : undefined;
  const published = (declared !== undefined && shippedClass(text) !== declared.slice(6) && /^`class\.[a-z0-9-]+` is zip-local|^`class\.[a-z0-9-]+` \(zip-local/u.test(text) ? undefined : declared) ?? base ?? (loaded === undefined ? undefined : `class.${loaded}`) ?? fromRows;
  const shipped = shippedClass(text);
  const options = classOptions(text);
  const profiled = published !== undefined && profiles.has(published) ? published : null;
  if (shipped !== undefined && shipped !== published?.slice(6)) {
    const file = new RegExp(`([\\w./-]*${shipped.replace(/[.*+?^${}()|[\]\\]/gu, '\\$&')}\\.cls)\\b`, 'u').exec(text)?.[1] ?? null;
    const loads = published === undefined ? null : (profiles.get(published)?.name ?? published.slice(6));
    return { key: { name: shipped, options, local: { file, loads }, description, evidence }, answer: { id: null, base: profiled } };
  }
  if (published !== undefined) return { key: { name: profiles.get(published)?.name ?? published.slice(6), options, description, evidence }, answer: { id: profiled, base: null } };
  return { key: { name: /`([A-Za-z][\w-]*)`/u.exec(text)?.[1] ?? 'none', options, description, evidence }, answer: { id: null, base: null } };
};

/** The packages the library knows, by name: the ones it has facts for and the ones its handlers load. */
export const knownPackages = (library: Library): Set<string> => new Set([...library.packages.map((p) => p.id), ...library.keys.flatMap((k) => k.loads.map((l) => l.pkg))]);

/** A Solution file read into a target document, each key with its answer. */
export type GoldContext = { readonly homes: Map<string, NodeId>; readonly packages: Set<string>; readonly components: Set<string> };

/** What reading every Solution file shares, worked out once. */
export const goldContext = (library: Library): GoldContext => ({ homes: componentHomes(library), packages: knownPackages(library), components: components(library) });

export const readGold = (s: Solution, library: Library, { homes, packages, components: ids }: GoldContext = goldContext(library)): Gold => {
  const byKey = new Map<string, { key: { -readonly [K in keyof TargetKey]: TargetKey[K] }; answer: Answer }>();
  const add = (node: NodeId, answer: Answer, row: Row): void => {
    const at = `${node} ${answer.way ?? answer.named}`;
    const evidence: Evidence = { kind: 'solution', file: s.file, lines: String(row.line) };
    const said = withoutAnswers(`${row.component}: ${row.parameters}`, ids);
    // Packages the row's own words name in backticks; never the Way column, which is the answer.
    const named = [...said.matchAll(/`([A-Za-z][A-Za-z0-9-]*)`/gu)].map((m) => m[1] ?? '').filter((p) => packages.has(p));
    const known = byKey.get(at);
    if (known !== undefined) {
      known.key.evidence = [...known.key.evidence, evidence];
      if (known.key.description.length < DESCRIPTION) known.key.description = cut(`${known.key.description}; ${said}`, DESCRIPTION);
      known.key.packages = [...known.key.packages, ...named.filter((p) => !known.key.packages.some((l) => l.pkg === p)).map((pkg) => ({ pkg }))];
      return;
    }
    const key = { node, features: [], params: {}, packages: [...new Set(named)].map((pkg) => ({ pkg })), description: cut(said, DESCRIPTION), evidence: [evidence], confidence: 'high' as const };
    byKey.set(at, { key, answer });
  };
  for (const row of s.rows) {
    for (const way of row.ways) {
      if (way.startsWith('class.')) continue;
      const keys = library.keys.filter((k) => k.id === way);
      if (keys.length > 0) for (const k of keys) add(k.node, { way }, row);
      else add(homes.get(way.split('.')[0] ?? '') ?? DOC_NODE, { way: null, named: way }, row);
    }
  }
  const keys = [...byKey.values()];
  return {
    source: { id: s.id, files: [] },
    class: goldClass(s, library, ids),
    nodes: keys.filter((k) => k.key.node !== DOC_NODE),
    document: keys.filter((k) => k.key.node === DOC_NODE),
  };
};
