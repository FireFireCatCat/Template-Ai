/**
 * The interim library (ARCHITECTURE.md section 4): General's package methods
 * as ways, until `../lib` exists, and ways that bring their own handler as a
 * Flouest plug-in.
 *
 * A General way is one package set a node's LaTeX uses, as Flouest's dynamic
 * tests read it (`variants.ts`, ADR-199): `general:containerBlock/mathElement:amsthm`.
 * Its presets are the looks its combinations wear. So General's ways and their
 * variants are exactly the variants Flouest's own harness splits on.
 *
 * A plug-in way brings a handler: a style it adds to the node's handler in
 * General's profile (Flouest ADR-291). Its LaTeX is that handler's, wherever
 * a branch binds the node to the way; everything else prints as General.
 */
import { mkdirSync, writeFileSync } from 'node:fs';
import { join } from 'node:path';

import { hashJson, type CompatTable, type Library, type NodeId, type Way, type WayId } from 'compat-core';
import type { Realization } from '@flouest/JSON->Latex Compiler/src/Profile/Profile_General/types.ts';
import type { ProfileRealizationLibrary } from '@flouest/JSON->Latex Compiler/src/Profile/Profile_General/types.ts';
import type { VariantsResult } from '@flouest/Template/test/dynamic-testing/variants.ts';

/** A handler a way adds: a style in a node's handler, in the compiler's family for the node. */
export type WayPlugin = {
  readonly family: keyof ProfileRealizationLibrary;
  readonly kind: string;
  readonly style: string;
  readonly realization: Realization;
};

export type FlouestWay = Way & { readonly plugin?: WayPlugin };

export const GENERAL = 'general';

/** A General way's id: the node and its package set. */
export const generalWayId = (node: NodeId, packages: readonly string[]): WayId => `${GENERAL}:${node}:${packages.join('+') || 'kernel'}`;

/** Every node's package methods in General, in the order Flouest found them. */
export const generalWays = (variants: VariantsResult): FlouestWay[] =>
  variants.kinds.flatMap((kind) => {
    const ways = new Map<WayId, { packages: readonly string[]; looks: Set<string> }>();
    for (const variant of kind.variants) {
      const id = generalWayId(kind.identity.label, variant.packages);
      const way = ways.get(id) ?? { packages: variant.packages, looks: new Set<string>() };
      for (const member of variant.members) way.looks.add(member.look);
      ways.set(id, way);
    }
    return [...ways].map(([id, way]) => ({
      id,
      node: kind.identity.label,
      presets: [...way.looks].map((look) => ({ id: look || 'default', params: { look } })),
      compat: [],
      loads: [...way.packages],
      defines: [],
    }));
  });

/** The ways as a library. A way's fingerprint is its key and, for a plug-in, its handler's code. */
export class FlouestLibrary implements Library {
  readonly #ways: readonly FlouestWay[];
  readonly #compat: string | undefined;
  readonly #library: { readonly root: string; readonly ways: ReadonlySet<WayId> } | undefined;
  readonly written: CompatTable[] = [];

  /**
   * `compat`: the folder its compat tables are written to, one JSON file per
   * way. A way the handler library brings (`library`, its folder) has its
   * table written beside its handler instead, as `matrix.generated.json`,
   * which the library merges into its `compat.generated.json`.
   */
  constructor(ways: readonly FlouestWay[], compat?: string, library?: { readonly root: string; readonly ways: ReadonlySet<WayId> }) {
    const ids = ways.map((w) => w.id);
    const twice = ids.find((id, i) => ids.indexOf(id) !== i);
    if (twice !== undefined) throw new Error(`library: way ${twice} is listed twice`);
    this.#ways = ways;
    this.#compat = compat;
    this.#library = library;
  }

  get all(): readonly FlouestWay[] {
    return this.#ways;
  }

  nodes(): readonly NodeId[] {
    return [...new Set(this.#ways.map((w) => w.node))];
  }

  ways(node: NodeId): readonly FlouestWay[] {
    return this.#ways.filter((w) => w.node === node);
  }

  fingerprint(id: WayId): string {
    const way = this.#ways.find((w) => w.id === id);
    if (way === undefined) throw new Error(`library: no way ${id}`);
    const { plugin, ...key } = way;
    return hashJson({
      key,
      plugin: plugin === undefined ? null : { ...plugin, realization: { preamble: String(plugin.realization.preamble), emit: String(plugin.realization.emit) } },
    });
  }

  writeCompat(table: CompatTable): void {
    this.written.push(table);
    if (this.#library?.ways.has(table.way)) {
      const way = this.#ways.find((w) => w.id === table.way);
      const folder = join(this.#library.root, 'nodes', (way?.node ?? '').replace(/\//g, '.'), table.way);
      writeFileSync(join(folder, 'matrix.generated.json'), `${JSON.stringify(table, null, 2)}\n`);
      return;
    }
    if (this.#compat === undefined) return;
    mkdirSync(this.#compat, { recursive: true });
    writeFileSync(join(this.#compat, `${table.way.replace(/[^A-Za-z0-9+._-]/g, '_')}.json`), `${JSON.stringify(table, null, 2)}\n`);
  }
}
