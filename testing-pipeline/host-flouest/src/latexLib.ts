/**
 * The handler library (`../Latex-Lib`, ARCHITECTURE.md change 3: variants
 * come from the library) as plug-in ways: each handler of a node, with each
 * of its presets as a style the node's plug-in adds. The host splits a way's
 * variants by its compat params and rotates the presets over each variant's
 * members, so every preset is compiled (`host.ts`). A handler sits where it is
 * filed with the adapts its key gives each parent (`engine/adapt.ts`).
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
import { withDefaults } from '../../../Latex-Lib/schema/params.ts';
import { HANDLERS as abstract } from '../../../Latex-Lib/nodes/containerBlock.abstract/index.ts';
import { HANDLERS as acknowledgement } from '../../../Latex-Lib/nodes/containerBlock.acknowledgement/index.ts';
import { HANDLERS as appendix } from '../../../Latex-Lib/nodes/containerBlock.appendix/index.ts';
import { HANDLERS as blockMath } from '../../../Latex-Lib/nodes/containerBlock.blockMath/index.ts';
import { HANDLERS as cite } from '../../../Latex-Lib/nodes/cite.cite/index.ts';
import { HANDLERS as codeEscape } from '../../../Latex-Lib/nodes/codeEscape.codeEscape/index.ts';
import { HANDLERS as columns } from '../../../Latex-Lib/nodes/containerBlock.columns/index.ts';
import { HANDLERS as customLatexBlock } from '../../../Latex-Lib/nodes/containerBlock.customLatex/index.ts';
import { HANDLERS as customLatex } from '../../../Latex-Lib/nodes/customLatex.customLatex/index.ts';
import { HANDLERS as customLatexPara } from '../../../Latex-Lib/nodes/paragraph.customLatexPara/index.ts';
import { HANDLERS as heading } from '../../../Latex-Lib/nodes/paragraph.heading/index.ts';
import { HANDLERS as hyperlink } from '../../../Latex-Lib/nodes/hyperlink.hyperlink/index.ts';
import { HANDLERS as image } from '../../../Latex-Lib/nodes/atomicBlock.image/index.ts';
import { HANDLERS as listing } from '../../../Latex-Lib/nodes/containerBlock.listing/index.ts';
import { HANDLERS as lstParagraph } from '../../../Latex-Lib/nodes/paragraph.lstParagraph/index.ts';
import { HANDLERS as mathElement } from '../../../Latex-Lib/nodes/containerBlock.mathElement/index.ts';
import { HANDLERS as mathPara } from '../../../Latex-Lib/nodes/paragraph.mathPara/index.ts';
import { HANDLERS as note } from '../../../Latex-Lib/nodes/containerBlock.note/index.ts';
import { HANDLERS as pageBreak } from '../../../Latex-Lib/nodes/atomicBlock.pageBreak/index.ts';
import { HANDLERS as paragraph } from '../../../Latex-Lib/nodes/paragraph.paragraph/index.ts';
import { HANDLERS as refContainer } from '../../../Latex-Lib/nodes/containerBlock.refContainer/index.ts';
import { HANDLERS as refPara } from '../../../Latex-Lib/nodes/paragraph.refPara/index.ts';
import { HANDLERS as table } from '../../../Latex-Lib/nodes/table/index.ts';
import { HANDLERS as tableCell } from '../../../Latex-Lib/nodes/table_cell/index.ts';
import { HANDLERS as tableContents } from '../../../Latex-Lib/nodes/atomicBlock.tableContents/index.ts';
import { HANDLERS as tableHeader } from '../../../Latex-Lib/nodes/table_header/index.ts';
import { HANDLERS as tableRow } from '../../../Latex-Lib/nodes/table_row/index.ts';
import { HANDLERS as title } from '../../../Latex-Lib/nodes/paragraph.title/index.ts';
import type { Realization } from '@flouest/JSON->Latex Compiler/src/Profile/Profile_General/types.ts';
import type { ProfileRealizationLibrary } from '@flouest/JSON->Latex Compiler/src/Profile/Profile_General/types.ts';

import type { FlouestWay } from './ways.ts';
import type { Workspace } from './workspace.ts';

type Handlers = typeof mathElement;

/**
 * Each node whose handlers can be plugged in: the family and kind Flouest's
 * emitter looks its handler up in (`Emit/lookup.ts`), and the label Flouest's
 * nesting gives it where that is not the library's node id (an inline node is
 * `cite`, not `cite/cite`).
 */
const PLUGGED: {
  readonly [node: string]: { readonly family: keyof ProfileRealizationLibrary; readonly kind: string; readonly label?: string; readonly handlers: Handlers };
} = {
  'containerBlock/abstract': { family: 'containerBlock', kind: 'abstract', handlers: abstract },
  'containerBlock/acknowledgement': { family: 'containerBlock', kind: 'acknowledgement', handlers: acknowledgement },
  'containerBlock/appendix': { family: 'containerBlock', kind: 'appendix', handlers: appendix },
  'containerBlock/blockMath': { family: 'containerBlock', kind: 'blockMath', handlers: blockMath },
  'containerBlock/columns': { family: 'containerBlock', kind: 'columns', handlers: columns },
  'containerBlock/customLatex': { family: 'containerBlock', kind: 'customLatex', handlers: customLatexBlock },
  'containerBlock/listing': { family: 'containerBlock', kind: 'listing', handlers: listing },
  'containerBlock/mathElement': { family: 'containerBlock', kind: 'mathElement', handlers: mathElement },
  'containerBlock/note': { family: 'containerBlock', kind: 'note', handlers: note },
  'containerBlock/refContainer': { family: 'containerBlock', kind: 'refContainer', handlers: refContainer },
  table: { family: 'containerBlock', kind: 'table', handlers: table },
  table_row: { family: 'containerBlock', kind: 'table_row', handlers: tableRow },
  table_cell: { family: 'containerBlock', kind: 'table_cell', handlers: tableCell },
  table_header: { family: 'containerBlock', kind: 'table_header', handlers: tableHeader },
  'paragraph/heading': { family: 'Paragraph', kind: 'heading', handlers: heading },
  'paragraph/title': { family: 'Paragraph', kind: 'title', handlers: title },
  'paragraph/paragraph': { family: 'Paragraph', kind: 'paragraph', handlers: paragraph },
  'paragraph/lstParagraph': { family: 'Paragraph', kind: 'lstParagraph', handlers: lstParagraph },
  'paragraph/mathPara': { family: 'Paragraph', kind: 'mathPara', handlers: mathPara },
  'paragraph/refPara': { family: 'Paragraph', kind: 'refPara', handlers: refPara },
  'paragraph/customLatexPara': { family: 'Paragraph', kind: 'customLatexPara', handlers: customLatexPara },
  'atomicBlock/image': { family: 'blockAtom', kind: 'image', handlers: image },
  'atomicBlock/pageBreak': { family: 'blockAtom', kind: 'pageBreak', handlers: pageBreak },
  'atomicBlock/tableContents': { family: 'blockAtom', kind: 'tableContents', handlers: tableContents },
  'cite/cite': { family: 'inlineAtomic', kind: 'cite', label: 'cite', handlers: cite },
  'hyperlink/hyperlink': { family: 'inlineAtomic', kind: 'hyperlink', label: 'hyperlink', handlers: hyperlink },
  'codeEscape/codeEscape': { family: 'inlineAtomic', kind: 'codeEscape', label: 'codeEscape', handlers: codeEscape },
  'customLatex/customLatex': { family: 'inlineAtomic', kind: 'customLatex', label: 'customLatex', handlers: customLatex },
};

/**
 * The nodes whose ways a plug-in style cannot reach, and why. Testing them
 * needs a change in Flouest or a template of their own per way.
 */
export const UNPLUGGED: { readonly [node: string]: string } = {
  'code/code': "the emitter always prints code in General's `listings` style, whatever style the node names (Emit/lookup.ts)",
  'inlineMath/inlineMath': "the emitter always prints inline maths with General's `plain` style (emitMath in Emit/emit.ts)",
  'ref/ref': "the emitter always prints a reference with General's `href` style (emitRef in Emit/emit.ts)",
  'footnoteAnchor/footnoteAnchor': 'Flouest refuses a plug-in there: the emitter writes a footnote itself and reads only its anchor handler\'s preamble (Plugins/plugins.ts)',
};

/** A look name: `thm.class-native` → `ThmClassNative`. */
const camel = (name: string): string => name.split(/[^A-Za-z0-9]+/).filter((p) => p !== '').map((p) => `${p.charAt(0).toUpperCase()}${p.slice(1)}`).join('');

/** A way's style, one per preset: `thm.amsthm` with `plain` → `libThmAmsthmPlain`. */
const styleOf = (way: string, preset: string): string => `lib${camel(way)}${camel(preset)}`;

/**
 * The library's ways, one per handler. A way id is unique within its node
 * (`bib.natbib` is both a reference list's way and a citation's), so one
 * that several nodes use is named with its node here: `bib.natbib@cite`.
 */
export const latexLibWays = async (ws: Workspace): Promise<FlouestWay[]> => {
  const root = resolve(ws.config.root, String(ws.config.host['library'] ?? '../Latex-Lib'));
  const { library } = await loadLibrary(root);
  const nesting = readNesting(ws.flouest);
  const nodesOf = new Map<string, number>();
  for (const key of library.keys) if (PLUGGED[key.node] !== undefined) nodesOf.set(key.id, (nodesOf.get(key.id) ?? 0) + 1);
  return library.keys.flatMap((key): FlouestWay[] => {
    const plugged = PLUGGED[key.node];
    if (plugged === undefined) return [];
    const presets = Object.entries(key.presets).map(([id, preset]) => {
      const realization: Realization = adapted({
        key,
        params: preset.params,
        handlerOf: (way) => plugged.handlers[way],
        keyOf: (way) => library.keys.find((k) => k.id === way),
        nesting,
      });
      return { id, style: styleOf(key.id, id), realization };
    });
    const [first] = presets;
    if (first === undefined) return [];
    const node = plugged.label ?? key.node;
    return [
      {
        id: (nodesOf.get(key.id) ?? 0) > 1 ? `${key.id}@${node}` : key.id,
        node,
        folder: `nodes/${key.node.replace(/\//g, '.')}/${key.id}`,
        // Each preset with its defaults filled in, so presets alike in their compat params share a variant.
        presets: Object.entries(key.presets).map(([id, p]) => ({ id, params: withDefaults(key.params, p.params) })),
        compat: Object.entries(key.params).flatMap(([name, spec]) => (spec.compat === true ? [name] : [])),
        loads: [...new Set(key.loads.map((l) => l.pkg))],
        defines: key.defines.map((d) => (typeof d === 'string' ? d : d.name)),
        plugin: { family: plugged.family, kind: plugged.kind, style: first.style, realization: first.realization, presets },
      },
    ];
  });
};
