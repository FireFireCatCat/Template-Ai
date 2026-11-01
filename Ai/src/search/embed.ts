/**
 * Embeddings (ARCHITECTURE.md section 5.1): descriptions as vectors, for the
 * description term of the score. One local model, pinned to one revision and
 * one quantisation, so a text always gives the same vector, offline and at no
 * cost per run. The model is downloaded once into `.cache/models/`; the
 * library's vectors are written beside its keys
 * (`Latex-Lib/embeddings.generated.json`); a key's vector is cached by the
 * hash of its text in `.cache/vectors/`.
 */
import { existsSync, mkdirSync, readFileSync, writeFileSync } from 'node:fs';
import { dirname, join } from 'node:path';

import { textHash, type EmbeddingsFile } from '../../../Latex-Lib/embeddings.ts';

import type { DescriptionSimilarity } from './score.ts';

/** The model: all-MiniLM-L6-v2 as ONNX, its 8-bit quantisation, at one revision of its repository. */
export const MODEL = { name: 'Xenova/all-MiniLM-L6-v2', revision: '751bff37182d3f1213fa05d7196b954e230abad9', dtype: 'q8' } as const;
export const MODEL_ID = `${MODEL.name}@${MODEL.revision}:${MODEL.dtype}`;

export type Embedder = { readonly id: string; readonly embed: (texts: readonly string[]) => Promise<Float32Array[]> };

/**
 * Texts go through the model one at a time: the 8-bit model scales each batch
 * by its own largest value, so a text's vector would depend on the texts
 * beside it.
 */
const BATCH = 1;

/** The pinned model, loaded from `cacheDir` (downloaded there the first time). */
export const localEmbedder = async (cacheDir: string): Promise<Embedder> => {
  const { pipeline, env } = await import('@huggingface/transformers');
  env.cacheDir = cacheDir;
  const extract = await pipeline('feature-extraction', MODEL.name, { revision: MODEL.revision, dtype: MODEL.dtype });
  return {
    id: MODEL_ID,
    embed: async (texts) => {
      const out: Float32Array[] = [];
      for (let i = 0; i < texts.length; i += BATCH) {
        const tensor = await extract([...texts.slice(i, i + BATCH)], { pooling: 'mean', normalize: true });
        for (const row of tensor.tolist() as number[][]) out.push(Float32Array.from(row));
      }
      return out;
    },
  };
};

export const encodeVector = (v: Float32Array): string => Buffer.from(v.buffer, v.byteOffset, v.byteLength).toString('base64');
export const decodeVector = (s: string): Float32Array => {
  const bytes = Buffer.from(s, 'base64');
  const v = new Float32Array(bytes.length / 4);
  new Uint8Array(v.buffer).set(bytes);
  return v;
};

/** Cosine of two vectors the model normalised: their dot product. */
export const cosine = (a: Float32Array, b: Float32Array): number => {
  let s = 0;
  for (let i = 0; i < a.length; i++) s += (a[i] ?? 0) * (b[i] ?? 0);
  return s;
};

/** An embedder that keeps every vector it made in a file, by the hash of its text, and asks the model only for new texts. */
export const cachedEmbedder = (inner: Embedder, file: string): Embedder & { readonly save: () => void } => {
  const cache = new Map<string, string>(existsSync(file) ? Object.entries(JSON.parse(readFileSync(file, 'utf8')) as Record<string, string>) : []);
  return {
    id: inner.id,
    embed: async (texts) => {
      const fresh = [...new Set(texts.filter((t) => !cache.has(textHash(t))))];
      const vectors = fresh.length === 0 ? [] : await inner.embed(fresh);
      fresh.forEach((t, i) => cache.set(textHash(t), encodeVector(vectors[i]!)));
      return texts.map((t) => decodeVector(cache.get(textHash(t))!));
    },
    save: () => {
      mkdirSync(dirname(file), { recursive: true });
      writeFileSync(file, JSON.stringify(Object.fromEntries([...cache].sort(([a], [b]) => a.localeCompare(b)))));
    },
  };
};

/** The cache file for one model's vectors. */
export const vectorCache = (ai: string, model: string): string => join(ai, '.cache', 'vectors', `${textHash(model).slice(0, 16)}.json`);

/**
 * The description term's similarity: a key's text against library entries,
 * the best cosine of those that have a vector. Key vectors are made before the
 * search runs, so the search itself stays synchronous.
 */
export const descriptionSimilarity = (library: EmbeddingsFile, keys: ReadonlyMap<string, Float32Array>): DescriptionSimilarity => {
  const entries = new Map(library.entries.map((e) => [e.id, decodeVector(e.vector)]));
  return (description, ids) => {
    const v = keys.get(description);
    if (v === undefined) return undefined;
    const found = ids.map((id) => entries.get(id)).filter((e): e is Float32Array => e !== undefined);
    return found.length === 0 ? undefined : Math.max(...found.map((e) => cosine(v, e)));
  };
};
