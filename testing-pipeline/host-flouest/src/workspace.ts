/**
 * What every command runs in: `compat.config.json` and what it names (the
 * class settings, the setups, the store), the Flouest checkout, and the
 * engine, opened only when something compiles. Command-line options are read
 * here too.
 */
import { join, resolve } from 'node:path';

import {
  appliesTo,
  FsStore,
  loadClassSettings,
  loadConfig,
  loadSetups,
  readClassFiles,
  type ClassSetting,
  type Engine,
  type EngineFile,
  type Pair,
  type Setup,
  type WorkspaceConfig,
} from 'compat-core';

import { flouestEngine } from './engine.ts';

/** `--name value`. */
export const option = (name: string): string | undefined => {
  const at = process.argv.indexOf(`--${name}`);
  return at < 0 ? undefined : process.argv[at + 1];
};

/** `--name`, given or not. */
export const flag = (name: string): boolean => process.argv.includes(`--${name}`);

/** `--name value` as a number, or `fallback`. */
export const numberOption = (name: string, fallback: number): number => {
  const value = option(name);
  if (value === undefined) return fallback;
  const number = Number(value);
  if (!Number.isFinite(number)) throw new Error(`--${name}: ${value} is not a number`);
  return number;
};

/** The ids `--name a,b` lists, else `fallback`, else every one. */
const pick = <T extends { readonly id: string }>(all: readonly T[], name: string, fallback?: readonly string[]): T[] => {
  const wanted = option(name)?.split(',') ?? fallback;
  if (wanted === undefined) return [...all];
  const missing = wanted.filter((id) => !all.some((x) => x.id === id));
  if (missing.length > 0) throw new Error(`--${name}: no ${missing.join(', ')}; there are ${all.map((x) => x.id).join(', ')}`);
  return all.filter((x) => wanted.includes(x.id));
};

/** A class setting under a setup that applies to it: what one cell of a document is compiled under. */
export type Under = { readonly classSetting: ClassSetting; readonly setup: Setup };

export const underName = ({ classSetting, setup }: Under): string => `${classSetting.id}.${setup.id}`;

/** The class setting and setup every other is compared with: a failure the branch shows here too is not the class's. */
export const REFERENCE: Pair = { classSetting: 'article', setup: 'A' };

export type Workspace = {
  readonly config: WorkspaceConfig;
  readonly flouest: string;
  readonly store: FsStore;
  /** The class settings `--classes` picks, and the setups `--setups` picks. */
  readonly classSettings: readonly ClassSetting[];
  readonly setups: readonly Setup[];
  /** Each of those class settings under each of those setups that applies to it, in order. */
  readonly under: readonly Under[];
  readonly classFiles: (setting: ClassSetting) => readonly EngineFile[];
  readonly engine: () => Promise<Engine>;
  readonly close: () => Promise<void>;
};

/** The workspace in the current folder. Without `--classes` or `--setups`, `defaults` picks, else every one does. */
export const openWorkspace = (defaults: { readonly classes?: readonly string[]; readonly setups?: readonly string[] } = {}): Workspace => {
  const config = loadConfig(join(process.cwd(), 'compat.config.json'));
  const flouest = resolve(config.root, String(config.host.root));
  const classSettings = pick(loadClassSettings(config.classes), 'classes', defaults.classes);
  const setups = pick(loadSetups(config.setups), 'setups', defaults.setups);
  const files = new Map(classSettings.map((s) => [s.id, readClassFiles(config.classes, s)]));
  let engine: Promise<Engine> | undefined;
  return {
    config,
    flouest,
    store: new FsStore(config.out),
    classSettings,
    setups,
    under: classSettings.flatMap((classSetting) => setups.filter((setup) => appliesTo(setup, classSetting)).map((setup) => ({ classSetting, setup }))),
    classFiles: (setting) => files.get(setting.id) ?? readClassFiles(config.classes, setting),
    engine: () => (engine ??= flouestEngine({ flouest, out: config.out, engines: config.engines, log: (line) => console.log(`  ${line}`) })),
    close: async () => {
      if (engine !== undefined) await (await engine).close();
    },
  };
};
