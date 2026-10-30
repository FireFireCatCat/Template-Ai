import { definePackage } from '../schema/class.ts';
import { ctan } from '../schema/minimal.ts';

export default definePackage({
  id: "apacite",
  description: "apacite: APA citations and references.",
  options: {"natbibapa": "natbib's citation commands with apacite's styles", "nocitation": "citation commands not defined", "nobibliography": "the reference list's format not changed", "apaciteclassic": "the classic apacite commands"},
  exclusive: [],
  loadOrder: [],
  defines: [],
  zerotex: 'untested',
  evidence: [ctan("apacite"), { kind: 'manual', of: "apacite", section: "options natbibapa, nocitation; citation commands \\cite, \\citeA, \\citeNP", url: 'https://ctan.org/pkg/apacite' }],
});
