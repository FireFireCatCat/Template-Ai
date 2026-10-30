import { defineKey } from '../../../schema/key.ts';
import { minimal } from '../../../schema/minimal.ts';
import { PRESETS } from './presets.ts';

export default defineKey(
  minimal({
    id: 'list.paralist',
    node: 'containerBlock/listing',
    description:
      "paralist: the lists in paralist's forms, compact (compactitem, compactenum, compactdesc), inline (inparaitem, inparaenum) or as paragraphs (asparaitem, asparaenum, asparadesc); a label template for numbered lists ([(a)]), \\setdefaultenum and \\setdefaultleftmargin. 27 templates.",
    ctan: ['paralist'],
    features: ['compact', 'inline-list', 'custom-labels', 'numbered'],
    params: {
      form: { type: 'enum', values: ['compact', 'inline', 'aspara'], default: 'compact', description: 'compact lists, lists run into the paragraph, or items as paragraphs' },
      label: { type: 'string', default: '', description: "numbered lists: a label template ((a), 1., i.); ''" },
      defaultEnum: { type: 'tex', default: '', description: "\\setdefaultenum's four labels, braced ({(1)}{(a)}{(i)}{}); ''" },
      defaultMargins: { type: 'tex', default: '', description: "\\setdefaultleftmargin's six margins, braced; ''" },
    },
    presets: PRESETS,
    loads: [
      { pkg: 'paralist' },
    ],
    deny: [
      { class: 'class.acmart', reason: 'ACM: "changing list definitions is not allowed"', evidence: [{ kind: 'requirement', file: 'Template/template-requirement/ACM.md', line: '118' }] },
    ],
    zerotex: 'untested',
  }),
);
