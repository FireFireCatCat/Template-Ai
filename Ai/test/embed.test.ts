/**
 * Embeddings without the model: vectors round-trip through base64, the cache
 * asks the model only for new texts and keeps what it made, and the
 * description term is the best cosine over the entries that have a vector.
 */
import assert from 'node:assert/strict';
import { join } from 'node:path';
import { test } from 'node:test';

import { cachedEmbedder, cosine, decodeVector, descriptionSimilarity, encodeVector, type Embedder } from '../src/search/embed.ts';
import { folder } from './fixtures.ts';

const unit = (...xs: number[]): Float32Array => {
  const n = Math.hypot(...xs);
  return Float32Array.from(xs.map((x) => x / n));
};

test('a vector survives base64, and the cosine of normalised vectors is their dot product', () => {
  const v = unit(3, 4);
  assert.deepEqual(decodeVector(encodeVector(v)), v);
  assert.ok(Math.abs(cosine(v, unit(3, 4)) - 1) < 1e-6);
  assert.ok(Math.abs(cosine(unit(1, 0), unit(0, 1))) < 1e-9);
});

test('the cache asks the model only for texts it has not seen, and a new cache reads what the last one saved', async () => {
  const asked: string[][] = [];
  const fake: Embedder = { id: 'fake', embed: async (texts) => (asked.push([...texts]), texts.map((t) => unit(t.length, 1))) };
  const file = join(folder({}), 'vectors.json');
  const first = cachedEmbedder(fake, file);
  await first.embed(['ab', 'abc', 'ab']);
  first.save();
  const second = cachedEmbedder(fake, file);
  const [v] = await second.embed(['abc']);
  assert.deepEqual(asked, [['ab', 'abc']]);
  assert.deepEqual(v, unit(3, 1));
});

test('the description term is the best cosine of the entries that have a vector, and nothing when none has', () => {
  const similarity = descriptionSimilarity(
    { model: 'fake', dimensions: 2, entries: [{ id: 'handler:a', hash: '', vector: encodeVector(unit(1, 0)) }, { id: 'preset:a', hash: '', vector: encodeVector(unit(1, 1)) }] },
    new Map([['bold heads', unit(1, 1)]]),
  );
  assert.ok(Math.abs((similarity('bold heads', ['handler:a', 'preset:a']) ?? 0) - 1) < 1e-6);
  assert.equal(similarity('bold heads', ['handler:missing']), undefined);
  assert.equal(similarity('unseen text', ['handler:a']), undefined);
});
