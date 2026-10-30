// Node port of stats.py: numbers for the summary, read from Solution/*.md and _Manifest.tsv.
//
//   node stats.mjs [--json]
//
// Verdicts by what carries the look and where the class came from, the blockers behind every no (by kind
// and scope), the engine, the yes-rate under three definitions, and how concentrated the ways are (a way
// used by one zip only does not shrink the lib: it is a list entry).
import path from 'node:path';
import { CORE, SOL, WAY, header, manifest, read, rejectedWays, section, solutionFiles } from './common.mjs';

const FILE_EXT = new Set(['tex', 'cls', 'sty', 'bst', 'dtx', 'ins', 'bib', 'cfg', 'def', 'clo', 'md', 'txt', 'sh', 'py', 'pdf', 'png', 'json', 'yml']);
const REJECTED = rejectedWays();
const man = manifest();

const count = (it) => { const m = new Map(); for (const x of it) m.set(x, (m.get(x) || 0) + 1); return m; };
const mostCommon = (m, n) => [...m.entries()].sort((a, b) => b[1] - a[1]).slice(0, n);
const first = (s) => (s ? s.split(/\s+/)[0] : '');

const rows = solutionFiles().map((fn) => {
  const id = fn.slice(0, -3);
  const text = read(path.join(SOL, fn));
  const verdict = text.split('\n', 1)[0].trim();
  const blockers = [];
  for (const line of section(text, '## Blockers').split('\n')) {
    const m = /^\s*-\s*`?(BESPOKE|ART|UNMAPPED|EXTERNAL|NOTEMPLATE)(?:\/(\w+))?`?/.exec(line);
    if (m) blockers.push([m[1], m[2] || '?']);
  }
  const ways = [...new Set([...(section(text, '## Component map') + '\n' + section(text, '## Class setting')).matchAll(WAY)].map((m) => m[1].replace('NEW:', ''))
    .filter((w) => !FILE_EXT.has(w.split('.').pop().toLowerCase()) && !w.includes(':') && !REJECTED.has(w)))].sort();
  const eng = header(text, 'Engine');
  return {
    id, verdict,
    carried: first(header(text, 'Look carried by')) || '?',
    origin: first(header(text, 'Class origin')) || '?',
    kind: first(header(text, 'Kind')) || (man[id] || {}).kind || '?',
    source: (man[id] || {}).source || '?',
    blockers, ways,
    xelua: /XeLaTeX|LuaLaTeX/.test(eng),
    notemplate: blockers.some(([k]) => k === 'NOTEMPLATE'),
  };
});

const n = rows.length;
const yes = rows.filter((r) => r.verdict === 'yes');
const real = rows.filter((r) => !r.notemplate);
const out = {};
out.zips = n;
out.yes = yes.length;
out.no_template = rows.length - real.length;
out.yes_rate_all = n ? yes.length / n : 0;
out.yes_rate_excluding_notemplate = real.length ? real.filter((r) => r.verdict === 'yes').length / real.length : 0;
const by = (key) => Object.fromEntries([...new Set(rows.map((r) => r[key]))].sort().map((k) => [k, [rows.filter((r) => r[key] === k && r.verdict === 'yes').length, rows.filter((r) => r[key] === k).length]]));
out.by_carried = by('carried'); out.by_origin = by('origin'); out.by_kind = by('kind'); out.by_source = by('source');
const nos = rows.filter((r) => r.verdict === 'no');
const kindsOf = (r) => new Set(r.blockers.map((b) => b[0]));
out.no_by_kind = Object.fromEntries(count(nos.flatMap((r) => [...kindsOf(r)])));
out.no_by_kind_scope = Object.fromEntries(mostCommon(count(nos.flatMap((r) => [...new Set(r.blockers.map((b) => b[0] + '/' + b[1]))])), 1e9));
out.no_single_cause = Object.fromEntries(count(nos.filter((r) => kindsOf(r).size === 1).map((r) => [...kindsOf(r)][0])));
out.yes_not_class_carried = rows.filter((r) => r.verdict === 'yes' && r.carried !== 'class').length;
out.yes_if_class_scope_blockers_ignored = rows.filter((r) => r.verdict === 'yes' || (r.blockers.length && r.blockers.every((b) => b[1] === 'class') && !r.notemplate)).length;
out.pdf_engine_yes = yes.filter((r) => !r.xelua).length;
const use = count(rows.flatMap((r) => r.ways));
const cls = [...use].filter(([w]) => w.startsWith('class.'));
const core = [...use].filter(([w]) => CORE.has(w.split('.')[0]) && !w.startsWith('class.'));
const dock = [...use].filter(([w]) => !w.startsWith('class.') && !CORE.has(w.split('.')[0]));
const hist = (d) => ({ ways: d.length, used_by_1: d.filter(([, c]) => c === 1).length, used_by_2_to_4: d.filter(([, c]) => c >= 2 && c <= 4).length, used_by_5_plus: d.filter(([, c]) => c >= 5).length });
out.ways_core = hist(core); out.ways_doc_kind = hist(dock); out.ways_class = hist(cls);
out.top_ways = mostCommon(use, 25);
const single = new Set([...use].filter(([w, c]) => c === 1 && !w.startsWith('class.')).map(([w]) => w));
out.yes_resting_on_a_singleton_way = yes.filter((r) => r.ways.some((w) => single.has(w))).length;

if (process.argv.includes('--json')) {
  console.log(JSON.stringify(out, null, 1));
} else {
  const pct = (a, b) => (b ? Math.round((100 * a) / b) : 0);
  console.log(`${n} zips: ${yes.length} yes (${pct(yes.length, n)}%), ${n - yes.length} no; ${out.no_template} have no template at all (NOTEMPLATE)`);
  console.log(`yes-rate excluding NOTEMPLATE zips: ${Math.round(100 * out.yes_rate_excluding_notemplate)}%`);
  console.log(`yes where the look is NOT carried by a published class: ${out.yes_not_class_carried}  |  yes if blockers that sit only inside zip-local classes were ignored: ${out.yes_if_class_scope_blockers_ignored}`);
  for (const dim of ['by_carried', 'by_origin', 'by_source', 'by_kind']) {
    console.log(`\n${dim}:`);
    for (const [k, [y, t]] of Object.entries(out[dim]).sort((a, b) => b[1][1] - a[1][1])) console.log(`  ${k.padEnd(28)} ${String(y).padStart(3)}/${String(t).padEnd(3)} yes  ${String(pct(y, t)).padStart(3)}%`);
  }
  console.log('\nno by blocker kind (a file counts once per kind):', JSON.stringify(out.no_by_kind));
  console.log('no by kind/scope:', JSON.stringify(out.no_by_kind_scope));
  console.log('no with a single cause:', JSON.stringify(out.no_single_cause));
  for (const name of ['ways_core', 'ways_doc_kind', 'ways_class']) console.log(`\n${name}: ${JSON.stringify(out[name])}`);
  console.log('\nyes verdicts resting on a way no other zip used:', out.yes_resting_on_a_singleton_way, 'of', yes.length);
  console.log('top ways:', JSON.stringify(out.top_ways.slice(0, 15)));
}
