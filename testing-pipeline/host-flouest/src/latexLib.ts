/**
 * The handler library (`../Latex-Lib`, ARCHITECTURE.md change 3: variants
 * come from the library) as plug-in ways: each handler of a node, with its
 * first preset, as a style the node's plug-in adds. A handler sits where it
 * is filed with the adapts its key gives each parent (`engine/adapt.ts`).
 *
 * The library types a handler as its own copy of Flouest's `Realization`;
 * here it is assigned to Flouest's, so the binding's type check fails if the
 * two drift apart.
 *
 * `compat.config.json` names the library's folder (`host.library`).
 */
import { resolve } from 'node:path';

import { adapted } from '../../../Latex-Lib/engine/adapt.ts';
import { loadLibrary } from '../../../Latex-Lib/library.ts';
import { readNesting } from '../../../Latex-Lib/nesting.ts';
import { HANDLERS } from '../../../Latex-Lib/nodes/containerBlock.mathElement/index.ts';
import type { Realization } from '@flouest/JSON->Latex Compiler/src/Profile/Profile_General/types.ts';

import type { FlouestWay } from './ways.ts';
import type { Workspace } from './workspace.ts';

/** The nodes whose handlers the library has, with the plug-in family and kind each goes in. */
const PLUGGED: { readonly [node: string]: { readonly family: 'containerBlock'; readonly kind: string; readonly handlers: typeof HANDLERS } } = {
  'containerBlock/mathElement': { family: 'containerBlock', kind: 'mathElement', handlers: HANDLERS },
};

/** A look name for a way: `thm.class-native` → `libThmClassNative`. */
const styleOf = (way: string): string => `lib${way.split(/[.-]/).map((p) => `${p.charAt(0).toUpperCase()}${p.slice(1)}`).join('')}`;

export const latexLibWays = async (ws: Workspace): Promise<FlouestWay[]> => {
  const root = resolve(ws.config.root, String(ws.config.host['library'] ?? '../Latex-Lib'));
  const { library } = await loadLibrary(root);
  const nesting = readNesting(ws.flouest);
  return library.keys.flatMap((key): FlouestWay[] => {
    const plugged = PLUGGED[key.node];
    if (plugged === undefined) return [];
    const [first] = Object.values(key.presets);
    const realization: Realization = adapted({
      key,
      params: first?.params ?? {},
      handlerOf: (way) => plugged.handlers[way],
      keyOf: (way) => library.keys.find((k) => k.id === way),
      nesting,
    });
    return [
      {
        id: key.id,
        node: key.node,
        presets: Object.entries(key.presets).map(([id, p]) => ({ id, params: p.params })),
        compat: Object.entries(key.params).flatMap(([name, spec]) => (spec.compat === true ? [name] : [])),
        loads: [...new Set(key.loads.map((l) => l.pkg))],
        defines: key.defines.map((d) => (typeof d === 'string' ? d : d.name)),
        plugin: { family: plugged.family, kind: plugged.kind, style: styleOf(key.id), realization },
      },
    ];
  });
};
