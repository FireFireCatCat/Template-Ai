/**
 * A reference: its target label (the node's text) and the target's name
 * when the node gives one (`attrs.refName`, "Figure"), as General's
 * `inlineAtomicShape/ref.ts` reads them.
 */
import type { Subject } from '../../schema/realization.ts';

export const refNameOf = (node: Subject): string => (typeof node.attrs?.['refName'] === 'string' ? node.attrs['refName'].trim() : '');
