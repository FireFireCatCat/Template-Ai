import { definePackage } from '../schema/class.ts';
import { ctan } from '../schema/minimal.ts';

export default definePackage({
  id: "enumitem",
  description: "enumitem: key-value control of the kernel lists.",
  options: {},
  exclusive: [],
  loadOrder: [],
  defines: [],
  zerotex: 'yes',
  evidence: [ctan("enumitem")],
});
