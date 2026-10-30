/**
 * The resolver on the real library: class rules, names the class defines,
 * forbidden packages, two theorem engines, counters a class lacks; and the
 * pilot's pick of one handler under a class.
 */
import assert from 'node:assert/strict';
import { join } from 'node:path';
import { before, test } from 'node:test';

import { pick, resolve } from '../engine/resolve.ts';
import { loadLibrary } from '../library.ts';
import { ELEMENTS } from '../nodes/containerBlock.mathElement/statement.ts';
import type { Library } from '../schema/validate.ts';

let library: Library;
before(async () => {
  library = (await loadLibrary(join(import.meta.dirname, '..'))).library;
});
const kinds = { 'containerBlock/mathElement': ELEMENTS };
const under = (classId: string, ...choices: { way: string; params?: Record<string, string | boolean> }[]) => resolve(library, { classId, choices, kinds });

test('amsthm goes under article and amsart, and not under llncs, acmart or revtex4-2', () => {
  assert.deepEqual(under('class.article', { way: 'thm.amsthm' }), []);
  assert.deepEqual(under('class.amsart', { way: 'thm.amsthm' }), []);
  assert.ok(under('class.llncs', { way: 'thm.amsthm' }).some((v) => v.includes('\\proof already defined')));
  const acm = under('class.acmart', { way: 'thm.amsthm' });
  assert.ok(acm.some((v) => v.includes('defines env:definition, env:theorem, env:lemma, env:corollary') || v.includes('which class.acmart already defines')), acm.join('\n'));
  assert.deepEqual(under('class.acmart', { way: 'thm.amsthm', params: { rename: 'yes' } }), [], 'renamed, it no longer clashes');
  assert.ok(under('class.revtex4-2', { way: 'thm.amsthm' }).some((v) => v.includes('amsthm markup may not be used')));
});

test('ntheorem cannot go with amsthm, whether a class or another handler loads it', () => {
  assert.ok(under('class.amsart', { way: 'thm.ntheorem' }).some((v) => v.includes('conflicts with amsthm')));
  assert.deepEqual(under('class.article', { way: 'thm.ntheorem' }), []);
  assert.ok(under('class.article', { way: 'thm.ntheorem' }, { way: 'thm.amsthm' }).some((v) => v.includes('both own theorem-engine')));
});

test('a counter the class lacks cannot number statements', () => {
  assert.ok(under('class.article', { way: 'thm.kernel', params: { numberWithin: 'chapter' } }).some((v) => v.includes('needs counter:chapter')));
  assert.deepEqual(under('class.memoir', { way: 'thm.kernel', params: { numberWithin: 'chapter' } }), []);
  assert.deepEqual(under('class.ieeetran', { way: 'thm.kernel', params: { numberWithin: 'none' } }), []);
});

test("LNCS numbers statements through the paper, so a way declaring its own goes there only renamed and unnumbered by section", () => {
  assert.ok(under('class.llncs', { way: 'thm.kernel', params: { rename: 'yes' } }).length > 0);
  assert.deepEqual(under('class.llncs', { way: 'thm.kernel', params: { rename: 'yes', numberWithin: 'none' } }), []);
});

test("the class's own environments go only under a class that has them", () => {
  assert.deepEqual(under('class.llncs', { way: 'thm.class-native' }), []);
  assert.ok(under('class.article', { way: 'thm.class-native' }).some((v) => v.includes('only for class.llncs, class.acmart')));
});

test('the pick: the way as it is, renamed, or the class native', () => {
  const at = (way: string, classId: string) => pick(library, { node: 'containerBlock/mathElement', way, classId, kinds: ELEMENTS, nativeWay: 'thm.class-native' });
  assert.deepEqual(at('thm.amsthm', 'class.article'), { way: 'thm.amsthm', params: library.keys.find((k) => k.id === 'thm.amsthm')?.presets['ams-section']?.params, how: 'as-is' });
  assert.equal((at('thm.amsthm', 'class.acmart') as { how: string }).how, 'renamed');
  assert.equal((at('thm.amsthm', 'class.llncs') as { how: string }).how, 'class-native');
  assert.deepEqual(at('thm.amsthm', 'class.revtex4-2'), { way: 'thm.kernel', params: { numberWithin: 'none', sharedCounter: false }, how: 'fallback' }, 'APS permits \\newtheorem, not amsthm');
});

const at = (classId: string, node: string, way: string, kinds: readonly string[] = [], params: Record<string, string> = {}) =>
  resolve(library, { classId, choices: [{ way, node, params }], kinds: { [node]: kinds } });

test("what a class lacks stops the ways that need it: book has no abstract, letter no sections, floats, title or contents", () => {
  assert.ok(at('class.book', 'containerBlock/abstract', 'abs.kernel').some((v) => v.includes('needs env:abstract')));
  assert.deepEqual(at('class.report', 'containerBlock/abstract', 'abs.kernel'), []);
  assert.ok(at('class.letter', 'paragraph/heading', 'head.kernel', ['section']).some((v) => v.includes('needs counter:section')));
  assert.ok(at('class.letter', 'atomicBlock/image', 'fig.graphicx').some((v) => v.includes('needs env:figure')));
  assert.ok(at('class.letter', 'paragraph/title', 'front.maketitle').some((v) => v.includes('needs cmd:\\maketitle')));
  assert.ok(at('class.letter', 'atomicBlock/tableContents', 'toc.kernel').some((v) => v.includes('needs cmd:\\tableofcontents')));
  assert.deepEqual(at('class.book', 'paragraph/heading', 'head.fncychap', ['chapter']), []);
  assert.ok(at('class.article', 'paragraph/heading', 'head.fncychap', ['section']).some((v) => v.includes('needs counter:chapter')));
});

test("beamer: its own lists, sections, contents and colours refuse the packages that restyle them, and it has no chapters", () => {
  for (const [node, way] of [['containerBlock/listing', 'list.enumitem'], ['paragraph/heading', 'head.titlesec'], ['atomicBlock/tableContents', 'toc.tocloft'], ['table', 'tbl.colortbl'], ['table', 'tbl.longtable'], ['atomicBlock/image', 'fig.wrapfig']] as const) {
    assert.ok(at('class.beamer', node, way, ['section']).length > 0, `${way} under beamer`);
  }
  assert.ok(at('class.beamer', 'paragraph/heading', 'head.kernel', ['chapter']).some((v) => v.includes('needs counter:chapter')));
  assert.deepEqual(at('class.beamer', 'paragraph/heading', 'head.kernel', ['section', 'subsection']), []);
  assert.deepEqual(at('class.beamer', 'containerBlock/mathElement', 'thm.class-native'), []);
});

test('ACM forbids changing list definitions, and acmart refuses a restyled \\section', () => {
  for (const way of ['list.enumitem', 'list.paralist', 'list.enumerate-pkg', 'list.scrextend']) assert.ok(at('class.acmart', 'containerBlock/listing', way).some((v) => v.includes('not allowed')), way);
  assert.deepEqual(at('class.acmart', 'containerBlock/listing', 'list.kernel'), []);
  assert.ok(at('class.acmart', 'paragraph/heading', 'head.titlesec', ['section']).some((v) => v.includes('forbids titlesec')));
  assert.ok(at('class.acmart', 'paragraph/heading', 'head.sectsty', ['section']).length > 0);
});

test("KOMA and memoir style their own headings and contents: titlesec and tocloft are refused, KOMA's own ways go", () => {
  for (const cls of ['class.scrartcl', 'class.scrbook', 'class.scrreprt']) {
    assert.ok(at(cls, 'paragraph/heading', 'head.titlesec', ['section']).length > 0, cls);
    assert.ok(at(cls, 'atomicBlock/tableContents', 'toc.tocloft').length > 0, cls);
    assert.deepEqual(at(cls, 'paragraph/heading', 'head.koma-fonts', ['section']), [], cls);
    assert.deepEqual(at(cls, 'atomicBlock/tableContents', 'toc.koma'), [], cls);
  }
  assert.ok(at('class.memoir', 'paragraph/heading', 'head.titlesec', ['chapter']).length > 0);
  assert.deepEqual(at('class.memoir', 'paragraph/heading', 'head.memoir-style', ['chapter']), []);
  assert.ok(at('class.book', 'paragraph/heading', 'head.koma-fonts', ['chapter']).some((v) => v.includes('only for')));
});

test('amsbook builds in amsmath and amsthm, and the AMS asks that neither be loaded again', () => {
  assert.ok(at('class.amsbook', 'containerBlock/blockMath', 'math.amsmath').some((v) => v.includes('do not load')));
  assert.deepEqual(at('class.amsbook', 'containerBlock/blockMath', 'math.kernel'), []);
});

test('journal classes: AASTeX refuses cite, multicol and a second hyperref; LIPIcs forbids enumitem; MDPI prints its own title', () => {
  assert.ok(at('class.aastex', 'containerBlock/columns', 'cols.multicol').some((v) => v.includes('forbids multicol')));
  assert.ok(at('class.aastex', 'containerBlock/refContainer', 'bib.cite-pkg').some((v) => v.includes('forbids cite')));
  assert.ok(at('class.aastex', 'hyperlink/hyperlink', 'meta.hyperref').some((v) => v.includes('do not import hyperref')));
  assert.ok(at('class.lipics', 'containerBlock/listing', 'list.enumitem').some((v) => v.includes('forbids enumitem')));
  assert.ok(at('class.mdpi', 'paragraph/title', 'front.maketitle').some((v) => v.includes('needs cmd:\\maketitle')));
});

test('a class whose abstract is a command takes the class-native abstract in its command form, not the environment', () => {
  for (const cls of ['class.sn-jnl', 'class.mdpi', 'class.aa']) {
    assert.ok(at(cls, 'containerBlock/abstract', 'abs.kernel').some((v) => v.includes('needs env:abstract')), cls);
    assert.deepEqual(at(cls, 'containerBlock/abstract', 'abs.class-native', [], { form: 'command' }), [], cls);
  }
});

test("theorems: aa's \\newtheorem takes two more arguments, siamart loads ntheorem, both predefine their environments", () => {
  assert.ok(at('class.aa', 'containerBlock/mathElement', 'thm.kernel', [], { rename: 'yes' }).some((v) => v.includes('two more arguments')));
  assert.ok(at('class.siamart', 'containerBlock/mathElement', 'thm.amsthm', [], { rename: 'yes' }).some((v) => v.includes('ntheorem')));
  for (const cls of ['class.aa', 'class.siamart', 'class.lipics']) assert.deepEqual(at(cls, 'containerBlock/mathElement', 'thm.class-native'), [], cls);
});

test("a class built on another keeps that class's rules: ctexbeamer is beamer's, and EasyChair's thesis option brings chapters", () => {
  assert.ok(at('class.ctexbeamer', 'containerBlock/listing', 'list.enumitem').some((v) => v.includes('beamer redefines')));
  assert.deepEqual(at('class.ctexbeamer', 'containerBlock/mathElement', 'thm.class-native'), []);
  assert.ok(at('class.easychair', 'paragraph/heading', 'head.kernel', ['chapter']).some((v) => v.includes('needs counter:chapter')));
  assert.deepEqual(resolve(library, { classId: 'class.easychair', classOptions: ['thesis'], choices: [{ way: 'head.kernel', node: 'paragraph/heading' }], kinds: { 'paragraph/heading': ['chapter'] } }), []);
});

test('minimal has nothing a way could rest on: no sections, title, floats, contents or bibliography', () => {
  for (const [node, way, kinds] of [['paragraph/heading', 'head.kernel', ['section']], ['atomicBlock/image', 'fig.graphicx', []], ['paragraph/title', 'front.maketitle', []], ['atomicBlock/tableContents', 'toc.kernel', []], ['containerBlock/refContainer', 'bib.thebibliography', []]] as const) {
    assert.ok(at('class.minimal', node, way, kinds).some((v) => v.includes('needs')), way);
  }
  assert.deepEqual(at('class.minimal', 'paragraph/paragraph', 'para.kernel'), []);
});

test("Tufte's own \\sidenote and \\marginnote clash with the packages of those names, and its natbib with biblatex", () => {
  assert.ok(at('class.tufte-handout', 'containerBlock/note', 'note.sidenotes').some((v) => v.includes('defines cmd:\\sidenote')));
  assert.ok(at('class.tufte-book', 'containerBlock/note', 'note.marginnote').some((v) => v.includes('defines cmd:\\marginnote')));
  assert.deepEqual(at('class.tufte-handout', 'containerBlock/note', 'note.marginpar'), []);
  assert.ok(at('class.tufte-handout', 'containerBlock/refContainer', 'bib.biblatex-bibtex').some((v) => v.includes('natbib')));
});

test("a poster's blocks are macro arguments, a CV has no title or abstract of the kernel's, and exam's \\part is a question's", () => {
  assert.ok(at('class.tikzposter', 'code/code', 'code.listings').some((v) => v.includes('macro argument')));
  assert.ok(at('class.tikzposter', 'atomicBlock/image', 'fig.graphicx').some((v) => v.includes('needs env:figure')));
  assert.deepEqual(at('class.tikzposter', 'paragraph/title', 'front.maketitle'), []);
  assert.ok(at('class.moderncv', 'paragraph/title', 'front.maketitle').some((v) => v.includes('needs cmd:\\maketitle')));
  assert.deepEqual(at('class.moderncv', 'paragraph/heading', 'head.class-native', ['section']), []);
  assert.ok(at('class.exam', 'paragraph/heading', 'head.kernel', ['part']).some((v) => v.includes('needs counter:part')));
  assert.deepEqual(at('class.exam', 'paragraph/heading', 'head.kernel', ['section']), []);
  assert.deepEqual(resolve(library, { classId: 'class.jlreq', classOptions: ['book'], choices: [{ way: 'head.kernel', node: 'paragraph/heading' }], kinds: { 'paragraph/heading': ['chapter'] } }), ['class.jlreq does not run in ZeroTeX-NG'], 'its book option brings chapters; the engine still refuses it');
});

test('ZeroTeX-NG is the only engine: a handler or a class that does not run there goes nowhere', () => {
  assert.ok(at('class.article', 'code/code', 'code.minted').some((v) => v.includes('does not run in ZeroTeX-NG')));
  assert.ok(at('class.article', 'atomicBlock/image', 'fig.svg').some((v) => v.includes('does not run in ZeroTeX-NG')));
  assert.ok(at('class.jlreq', 'paragraph/paragraph', 'para.kernel').some((v) => v.includes('class.jlreq does not run in ZeroTeX-NG')));
  assert.ok(library.keys.every((k) => !('engines' in k)), 'no key names another engine');
});
