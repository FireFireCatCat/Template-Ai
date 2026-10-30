// Shared helpers for the Node ports of the _tools/*.py scripts (written because the machine that continued
// the project has Node but no Python). Same logic and same CLI as the Python originals, which stay in place.
import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

export const HERE = path.dirname(fileURLToPath(import.meta.url));
export const ROOT = path.dirname(HERE);
export const SOL = path.join(ROOT, 'Solution');
export const SRC = path.join(ROOT, 'Source');

export const WAY = /`((?:NEW:)?[a-z][a-z0-9-]*\.[a-z0-9][a-z0-9+_.:-]*)`/g;
export const NEW_ID = /NEW:[a-z][a-z0-9-]*\.[a-z0-9][a-z0-9+_.:-]*/g;
export const CORE = new Set(['page', 'cols', 'pg', 'hf', 'pgnum', 'sp', 'font', 'color', 'bg', 'lang', 'meta', 'xref', 'front', 'abs', 'toc', 'head',
  'num', 'list', 'quote', 'mark', 'fn', 'note', 'math', 'thm', 'alg', 'fig', 'tbl', 'cap', 'code', 'box', 'bib', 'idx']);

export const read = (p) => fs.readFileSync(p, 'utf8');
export const escapeRe = (s) => s.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');

// Python's re.search(head + r'\n(.*?)(?=\n## |\Z)', text, re.S): the text of a "## " section.
export function section(text, head) {
  const m = new RegExp(escapeRe(head) + '\\n([\\s\\S]*?)(?=\\n## |$)').exec(text);
  return m ? m[1] : '';
}

// The "- Key: value" header lines of a solution file, value cut at the first "(".
export function header(text, key) {
  const m = new RegExp('^- ' + escapeRe(key) + ':\\s*([^\\n(]+)', 'm').exec(text);
  return m ? m[1].trim().replace(/\.$/, '') : '';
}

export function libIds() {
  const ids = new Set();
  for (const line of read(path.join(ROOT, '_Lib.md')).split('\n')) {
    const m = /^\|\s*`([^`]+)`/.exec(line);
    if (m) ids.add(m[1]);
  }
  return ids;
}

// csv.DictReader(delimiter='\t', quoting=QUOTE_NONE)
export function readTsv(p) {
  const lines = read(p).split('\n').map((l) => l.replace(/\r$/, '')).filter((l) => l.length);
  const cols = lines[0].split('\t');
  return lines.slice(1).map((l) => {
    const f = l.split('\t');
    return Object.fromEntries(cols.map((c, i) => [c, f[i] === undefined ? '' : f[i]]));
  });
}

export function manifest() {
  const mp = path.join(ROOT, '_Manifest.tsv');
  const out = {};
  if (fs.existsSync(mp)) for (const r of readTsv(mp)) out[r.id] = r;
  return out;
}

// Provisional ways a consolidation rejected (alias value null): not lib ways, not counted as ways.
export function rejectedWays() {
  const out = new Set();
  const d = path.join(HERE, 'alias');
  for (const fn of fs.readdirSync(d)) {
    if (!fn.endsWith('.json') || fn === 'renames.json') continue;
    try {
      for (const [k, v] of Object.entries(JSON.parse(read(path.join(d, fn))))) if (v === null) out.add(k.replace('NEW:', ''));
    } catch (e) { /* not an alias map */ }
  }
  return out;
}

export function solutionFiles() {
  return fs.readdirSync(SOL).filter((f) => f.endsWith('.md')).sort();
}
