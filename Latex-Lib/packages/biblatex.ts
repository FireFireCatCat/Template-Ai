import { definePackage } from '../schema/class.ts';
import { ctan } from '../schema/minimal.ts';

export default definePackage({
  id: "biblatex",
  description: "biblatex: bibliographies and citations by style.",
  options: {"backend=bibtex": "biblatex option backend=bibtex", "backend=biber": "biblatex option backend=biber"},
  exclusive: [],
  loadOrder: [],
  defines: [],
  zerotex: 'untested',
  evidence: [ctan("biblatex")],
});
