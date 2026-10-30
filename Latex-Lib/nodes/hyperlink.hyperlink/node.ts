/**
 * A link's target (`attrs.href`), escaped for a URL argument as General's
 * `inlineAtomicShape/hyperlink.ts` escapes it.
 */
import type { Subject } from '../../schema/realization.ts';

const ESCAPES: { readonly [c: string]: string } = { '&': '\\&', '%': '\\%', '#': '\\#', _: '\\_', '\\': '\\%5C', '{': '\\%7B', '}': '\\%7D', '^': '\\%5E', '~': '~', $: '$' };

/** The target, or '' when there is none or it has spaces or control characters. */
export const hrefOf = (node: Subject): string => {
  const raw = typeof node.attrs?.['href'] === 'string' ? node.attrs['href'].trim() : '';
  if (raw === '' || /[\s\u0000-\u001f\u007f]/u.test(raw)) return '';
  return raw.replace(/[&%#_\\{}^~$]/gu, (c) => ESCAPES[c] ?? c);
};
