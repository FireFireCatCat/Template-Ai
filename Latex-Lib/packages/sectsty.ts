import { definePackage } from '../schema/class.ts';
import { ctan } from '../schema/minimal.ts';

export default definePackage({
  id: "sectsty",
  description: "sectsty: heading fonts by level (\\allsectionsfont, \\sectionfont).",
  options: {},
  exclusive: [],
  loadOrder: [],
  defines: [],
  zerotex: 'untested',
  evidence: [ctan("sectsty")],
});
