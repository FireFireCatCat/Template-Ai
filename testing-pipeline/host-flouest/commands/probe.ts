/**
 * `compat probe` (ARCHITECTURE.md section 5, stage 1): the class probe on the
 * app's ZeroTeX-NG, for every class setting in `settings/classes/`. Each class is probed for
 * what General's LaTeX brings to it (`src/surface.ts`): its package lines, the
 * names it defines and the names it redefines. Each profile is written to
 * `out/profiles/<class setting>.<setup>.json`, and a summary is printed.
 *
 *   npm run compat -- probe [--classes id,id] [--setup A] [--classes-dir <dir>]
 *
 * Every compile goes through the store and each profile is a stage, so a
 * second run compiles nothing. A class whose own LaTeX fails to load is a
 * finding, not a failure of this check. The check is that every class setting
 * gets a profile.
 */
import { mkdirSync, writeFileSync } from 'node:fs';
import { join, resolve } from 'node:path';

import {
  appliesTo,
  FsStore,
  loadClassSettings,
  loadConfig,
  loadSetups,
  probeStage,
  readClassFiles,
  runStage,
  type ClassProfile,
} from 'compat-core';

import { flouestEngine } from '../src/engine.ts';
import { generalSurface } from '../src/surface.ts';

const arg = (name: string): string | undefined => {
  const at = process.argv.indexOf(`--${name}`);
  return at < 0 ? undefined : process.argv[at + 1];
};

const config = loadConfig(join(process.cwd(), 'compat.config.json'));
const flouest = resolve(config.root, String(config.host.root));
const classesDir = arg('classes-dir') === undefined ? config.classes : resolve(String(arg('classes-dir')));
const wanted = arg('classes')?.split(',');
const setupId = arg('setup') ?? 'A';
const setup = loadSetups(config.setups).find((s) => s.id === setupId);
if (setup === undefined) throw new Error(`no setup ${setupId} in ${config.setups}`);
const settings = loadClassSettings(classesDir).filter((s) => (wanted === undefined || wanted.includes(s.id)) && appliesTo(setup, s));

const surface = generalSurface(flouest);
const ask = { packages: surface.packages, defines: surface.defines, redefines: surface.redefines };
console.log(
  `Step 3 class probe: ${settings.length} class settings, setup ${setup.id}. General asks for ${ask.packages.length} packages, ${ask.defines.length} defined names and ${ask.redefines.length} redefined, read from ${surface.documents} documents.`,
);

const store = new FsStore(config.out);
const engine = await flouestEngine({ flouest, out: config.out, engines: config.engines, log: (line) => console.log(`  ${line}`) });
const stage = probeStage(store, engine);
try {
  const runs = await Promise.all(
    settings.map((setting) => runStage(store, stage, { setting, setup, ask, files: readClassFiles(classesDir, setting) })),
  );
  const profiles = runs.map((r) => r.output);
  const folder = join(config.out, 'profiles');
  mkdirSync(folder, { recursive: true });
  for (const profile of profiles) writeFileSync(join(folder, `${profile.classSetting}.${setup.id}.json`), `${JSON.stringify(profile, null, 2)}\n`);

  // A name General redefines that article lacks too comes from one of
  // General's packages, not from the class (tocloft's \cft… names).
  const article = profiles.find((p) => p.classSetting === 'article');
  const lacksBeyondArticle = (p: ClassProfile) => p.lacks.filter((name) => !(article?.lacks ?? []).includes(name));

  const pad = (text: string, width: number) => (text.length >= width ? `${text.slice(0, width - 1)} ` : text.padEnd(width));
  console.log(`\n  ${pad('class setting', 22)}${pad('loads', 8)}${pad('cols', 5)}${pad('text', 9)}${pad('font', 6)}${pad('preloads', 30)}${pad('clashes', 9)}${pad('lacks', 7)}refuses / cautions`);
  for (const p of profiles) {
    const refuses = [...p.forbids.map((s) => `✗${s}`), ...p.cautions.map((s) => `!${s}`)].join(' ');
    console.log(
      `  ${pad(p.classSetting, 22)}${pad(p.loads.status, 8)}${pad(p.layout ? (p.layout.twocolumn ? '2' : '1') : '-', 5)}${pad(p.layout?.textWidth ?? '-', 9)}${pad(p.layout?.fontSize ?? '-', 6)}${pad(p.preloads.join(' ') || '-', 30)}${pad(String(p.clashes.length), 9)}${pad(String(lacksBeyondArticle(p).length), 7)}${refuses || '-'}`,
    );
  }

  console.log('\nDetails:');
  for (const p of profiles) {
    const lines: string[] = [];
    if (p.loads.status !== 'ok') lines.push(`does not load: ${p.loads.errors[0] ?? p.loads.status}`);
    if (p.clashes.length > 0) {
      const families = [...new Set(p.clashes.map((n) => n.replace(/(By[A-Z]\w*|LookItalicHeader)+$/, '')))];
      lines.push(`already defines ${p.clashes.length} of General's names: ${families.join(', ')}`);
    }
    const lacks = lacksBeyondArticle(p);
    if (lacks.length > 0) lines.push(`lacks what General redefines: ${lacks.join(', ')}`);
    for (const s of p.forbids) lines.push(`refuses ${s}: ${p.packages[s]?.errors[0] ?? p.packages[s]?.status}`);
    for (const s of p.cautions) lines.push(`cautions on ${s}: ${p.packages[s]?.cautions[0]}`);
    if (lines.length > 0) console.log(`  ${p.classSetting}\n${lines.map((l) => `    ${l}`).join('\n')}`);
  }
  const fresh = runs.filter((r) => !r.cached).length;
  console.log(`\n${profiles.length} profiles (${fresh} probed now, ${profiles.length - fresh} from the store) in ${folder}`);
} finally {
  await engine.close();
}
