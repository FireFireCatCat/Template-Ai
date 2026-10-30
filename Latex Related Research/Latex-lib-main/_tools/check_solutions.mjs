// Node port of check_solutions.py. Deterministic checks on Solution/*.md. Nothing here judges the analysis;
// it finds files that cannot be trusted.
//
//   node check_solutions.mjs [id-prefix ...]     # default: every file
//   node check_solutions.mjs --json              # machine-readable summary on stdout
//
// Per file: first line is exactly yes|no; the required sections are present; the verdict agrees with the
// Blockers section; every way id in backticks is in _Lib.md or written NEW:<id>; every cited file:line
// exists inside Source/<id>*/.
import fs from 'node:fs';
import path from 'node:path';
import { SOL, SRC, WAY, libIds, read, section, solutionFiles } from './common.mjs';

const REQUIRED = ['## Verdict', '## Blockers', '## Class setting', '## Component map', '## Bespoke code', '## Content-opaque', '## Lib changes'];
const CITE = /(?<![\w/])([\w@+\-./]*?[\w+\-]+\.(?:tex|cls|sty|bst|dtx|ins|bib|cfg|def|clo|ldf|md|txt|sh|py|bbx|cbx|lbx|ist|tikz|code|bbl)):(\d+)/g;
const FILE_EXT = new Set(['tex', 'cls', 'sty', 'bst', 'dtx', 'ins', 'bib', 'cfg', 'def', 'clo', 'ldf', 'md', 'txt', 'sh', 'py', 'bbx', 'cbx', 'lbx', 'pdf', 'png', 'jpg', 'eps', 'tikz', 'code', 'bbl', 'ist', 'json', 'yml', 'yaml', 'toml', 'makefile', 'mk']);
const BLOCKERS = new Set(['BESPOKE', 'ART', 'UNMAPPED', 'EXTERNAL', 'NOTEMPLATE']);
const KIND_RE = '(?:BESPOKE|ART|UNMAPPED|EXTERNAL|NOTEMPLATE)';

const sourceDirs = fs.readdirSync(SRC);
function sourceDir(sid) {
  const name = sourceDirs.find((n) => n === sid || n.startsWith(sid + '-'));
  return name ? path.join(SRC, name) : null;
}

const byBase = new Map();
function indexDir(sdir) {
  if (byBase.has(sdir)) return byBase.get(sdir);
  const idx = new Map();
  const walk = (d) => {
    for (const e of fs.readdirSync(d, { withFileTypes: true })) {
      const p = path.join(d, e.name);
      if (e.isDirectory()) walk(p);
      else { if (!idx.has(e.name)) idx.set(e.name, []); idx.get(e.name).push(p); }
    }
  };
  walk(sdir);
  byBase.set(sdir, idx);
  return idx;
}

// A cited path as written, or (agents cite basenames) the one file with that name in the zip.
function resolve(sdir, rel) {
  const full = path.join(sdir, rel);
  if (fs.existsSync(full) && fs.statSync(full).isFile()) return full;
  const idx = indexDir(sdir);
  const base = path.basename(rel);
  let hits = idx.get(base) || [];
  if (!hits.length) {
    const lb = base.toLowerCase();
    hits = [];
    for (const [n, ps] of idx) {
      const ln = n.toLowerCase();
      if (ln.endsWith('-' + lb) || ln.endsWith('_' + lb) || ln.endsWith('.' + lb)) hits.push(...ps);
    }
  }
  if (hits.length > 1) return hits;   // several files share the name (examples/*/main.tex): the caller takes the longest
  return hits.length === 1 ? hits[0] : null;
}

function lineCount(p) {
  if (!fs.existsSync(p) || !fs.statSync(p).isFile()) return -1;
  const b = fs.readFileSync(p);
  let n = 0;
  for (let i = 0; i < b.length; i++) if (b[i] === 10) n++;
  return b.length && b[b.length - 1] !== 10 ? n + 1 : n;
}

function check(file, known, cache) {
  const sid = file.slice(0, -3);
  const problems = [];
  const text = read(path.join(SOL, file));
  const lines = text.split('\n');
  const verdict = lines.length ? lines[0].trim() : '';
  if (verdict !== 'yes' && verdict !== 'no') problems.push(`first line is ${JSON.stringify(verdict)}, not yes|no`);
  for (const head of REQUIRED) if (!text.includes(head)) problems.push(`missing section ${head}`);
  if (!text.includes('Unverified')) problems.push('no Unverified line');
  const carried = /^- Look carried by:\s*(class|zip-local|preamble|mixed)\b/m.exec(text);
  const origin = /^- Class origin:\s*(ctan|publisher-official|tex-distribution-unbundled|zip-local|none)\b/m.exec(text);
  if (!carried) problems.push('header lacks a valid "Look carried by"');
  if (!origin) problems.push('header lacks a valid "Class origin"');
  const blockers = section(text, '## Blockers').trim();
  const kinds = new Set([...blockers.matchAll(/`?([A-Z]{3,10})`?/g)].map((m) => m[1]).filter((k) => BLOCKERS.has(k)));
  const hasBlockers = !!blockers && !/^\W*none\b/i.test(blockers);
  if (verdict === 'yes' && hasBlockers) problems.push('yes, but Blockers is not none');
  if (verdict === 'no' && !hasBlockers) problems.push('no, but Blockers says none');
  if (hasBlockers && kinds.size) {
    const loose = blockers.split('\n').filter((l) => new RegExp('^\\s*-\\s*`?' + KIND_RE + '\\b').test(l)
      && !new RegExp('^\\s*-\\s*`?' + KIND_RE + '/(?:class|preamble|body|package|zip)\\b').test(l));
    if (loose.length) problems.push(`${loose.length} blocker lines without a scope tag`);
  }
  if (verdict === 'no' && hasBlockers && !kinds.size) problems.push('no, but no blocker kind (BESPOKE|ART|UNMAPPED|EXTERNAL|NOTEMPLATE) named');
  const prefixes = new Set([...known].map((i) => i.split('.')[0]));
  const mapped = section(text, '## Component map') + '\n' + section(text, '## Class setting');
  const ways = new Set([...mapped.matchAll(WAY)].map((m) => m[1]).filter((w) => !FILE_EXT.has(w.split('.').pop().toLowerCase()) && !w.replace('NEW:', '').includes(':')));
  const unknown = [...ways].filter((w) => !w.startsWith('NEW:') && !known.has(w) && !w.startsWith('class.') && prefixes.has(w.split('.')[0])).sort();
  if (unknown.length) problems.push('way ids not in _Lib.md: ' + unknown.slice(0, 8).join(', '));
  const sdir = sourceDir(sid);
  if (!sdir) problems.push('no Source folder for this id');
  else {
    const missing = [];
    let cites = 0;
    for (const cm of text.matchAll(CITE)) {
      const rel = cm[1].trim(), line = cm[2];
      const start = cm.index;
      const before = text.slice(Math.max(0, start - 6), start);
      const lastTok = text.slice(Math.max(0, start - 40), start).split(' ').pop();
      if (lastTok.includes('!') || before.endsWith('[cls] ') || text.slice(Math.max(0, start - 8), start).includes('[cls]')) { cites++; continue; }
      cites++;
      const found = resolve(sdir, rel) || path.join(sdir, rel);
      const fulls = Array.isArray(found) ? found : [found];
      for (const f of fulls) if (!cache.has(f)) cache.set(f, lineCount(f));
      const n = Math.max(...fulls.map((f) => cache.get(f)));
      if (n < 0) missing.push(`${rel} (no file)`);
      else if (parseInt(line, 10) > n + 1) missing.push(`${rel}:${line} (file has ${n} lines)`);
    }
    const shortForm = (text.match(/\b[A-Za-z]{1,12}:\d{2,5}\b/g) || []).length >= 5;   // e.g. "S:7301", the file named once in a header
    if (cites === 0 && verdict && !shortForm) problems.push('no file:line evidence cited');
    if (missing.length) problems.push(`${missing.length} bad citations: ` + missing.slice(0, 5).join('; '));
  }
  return { id: sid, verdict, blockers: [...kinds].sort(), ways: [...ways].sort(), problems, lines: lines.length, carried: carried ? carried[1] : '', origin: origin ? origin[1] : '' };
}

const args = process.argv.slice(2).filter((a) => !a.startsWith('--'));
const known = libIds();
const cache = new Map();
const rows = solutionFiles().filter((fn) => !args.length || args.some((a) => fn.startsWith(a))).map((fn) => check(fn, known, cache));
const bad = rows.filter((r) => r.problems.length);
if (process.argv.includes('--json')) {
  console.log(JSON.stringify({ files: rows.length, bad: bad.length, rows }));
} else {
  const yes = rows.filter((r) => r.verdict === 'yes').length;
  console.log(`${rows.length} files: ${yes} yes, ${rows.length - yes} no, ${bad.length} with problems`);
  for (const r of bad) console.log(`  ${r.id}: ` + r.problems.join(' | '));
}
