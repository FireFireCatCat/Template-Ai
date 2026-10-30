import { definePackage } from '../schema/class.ts';
import { ctan } from '../schema/minimal.ts';

export default definePackage({
  id: "arydshln",
  description: "arydshln: dashed rules in tables.",
  options: {},
  exclusive: [],
  loadOrder: [],
  defines: [],
  zerotex: 'untested',
  evidence: [ctan("arydshln"), { kind: 'manual', of: "arydshln", section: "2 Usage: \\hdashline, \\cdashline, : and ;{dash/gap}, \\dashlinedash, \\dashlinegap", url: 'https://ctan.org/pkg/arydshln' }],
});
