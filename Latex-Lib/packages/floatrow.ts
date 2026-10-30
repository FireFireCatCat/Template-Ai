import { definePackage } from '../schema/class.ts';
import { ctan } from '../schema/minimal.ts';

export default definePackage({
  id: 'floatrow',
  description: 'floatrow: float layouts by \\floatsetup (caption position, beside captions, float widths), \\ffigbox and \\fcapside; it builds on caption and takes over float\'s \\restylefloat.',
  options: {},
  exclusive: [],
  loadOrder: [],
  defines: ['cmd:\\floatsetup', 'cmd:\\fcapside', 'cmd:\\ffigbox', 'cmd:\\ttabbox'],
  zerotex: 'untested',
  evidence: [ctan('floatrow')],
});
