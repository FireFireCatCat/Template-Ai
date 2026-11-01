/**
 * The class search (ARCHITECTURE.md section 6): the class key to a class
 * profile, found in the library alone.
 *
 * | tier         | when                                                                    |
 * |--------------|-------------------------------------------------------------------------|
 * | `exact`      | a profile has the key's name                                            |
 * | `base`       | the template ships its class, and a profile has the name of what it loads |
 * | `ship-class` | the template ships its class and nothing it loads has a profile         |
 * | `nearest`    | the longest profile name inside the key's (`ltjsarticle` holds `article`), else the nearest name, else the nearest description |
 * | `none`       | no profile                                                              |
 *
 * A profile that does not run in ZeroTeX-NG stops the run. Without a profile
 * the resolver works under the key's own name, which no rule names, so no
 * class rule applies, and what the class defines is unknown, so a handler is
 * never refused for a name only a class would define (`\maketitle`,
 * `counter:section`); the report says so.
 */
import type { ClassProfile } from '../../../Latex-Lib/schema/class.ts';
import type { ClassId } from '../../../Latex-Lib/schema/ids.ts';
import type { Library } from '../../../Latex-Lib/schema/validate.ts';

import type { TargetClass } from '../model.ts';
import type { DescriptionSimilarity } from './score.ts';

export type ClassTier = 'exact' | 'base' | 'ship-class' | 'nearest' | 'none';

export type ClassMatch = {
  readonly tier: ClassTier;
  readonly profile: ClassId | null;
  /** The class the resolver works under: the profile, else the key's own name. */
  readonly resolveAs: ClassId;
  readonly options: readonly string[];
  readonly reason: string;
  /** Why the run stops here. */
  readonly refused?: string;
};

/** A profile name inside the key's must be this long to count (`aa` is inside too many names). */
const INSIDE = 4;
/** How near a name must be for `nearest`, on letter trigrams (Dice); and a description, by cosine. */
const NEAR = 0.6;
const NEAR_DESCRIPTION = 0.6;

/** A class's name as a document gives it, without a path or `.cls`. */
const bare = (name: string): string => (name.split('/').pop() ?? name).replace(/\.cls$/u, '').trim();

const byName = (library: Library, name: string): ClassProfile | undefined => {
  const n = bare(name).toLowerCase();
  return library.classes.find((c) => c.name.toLowerCase() === n || c.id === `class.${n}`);
};

const trigrams = (s: string): Set<string> => {
  const t = `  ${s.toLowerCase()} `;
  return new Set([...t].slice(0, -2).map((_, i) => t.slice(i, i + 3)));
};
export const nameSimilarity = (a: string, b: string): number => {
  const [x, y] = [trigrams(a), trigrams(b)];
  return (2 * [...x].filter((g) => y.has(g)).length) / (x.size + y.size);
};

export const matchClass = (key: TargetClass, library: Library, description?: DescriptionSimilarity): ClassMatch => {
  const own = `class.${bare(key.name).toLowerCase()}`;
  const found = (tier: ClassTier, profile: ClassProfile, reason: string): ClassMatch => ({
    tier,
    profile: profile.id,
    resolveAs: profile.id,
    options: key.options,
    reason,
    ...(profile.zerotex === 'no' ? { refused: `${profile.id} does not run in ZeroTeX-NG` } : {}),
  });
  const exact = byName(library, key.name);
  if (exact !== undefined) return found('exact', exact, `${exact.id} is named ${key.name}`);
  const loads = key.local?.loads == null ? undefined : byName(library, key.local.loads);
  if (loads !== undefined) return found('base', loads, `the template's own ${key.name} loads ${key.local?.loads}, which is ${loads.id}`);
  if (key.local !== undefined) return { tier: 'ship-class', profile: null, resolveAs: own, options: key.options, reason: `the template ships ${key.name}${key.local.loads == null ? '' : `, which loads ${key.local.loads}, not profiled`}; no class rule applies` };
  const name = bare(key.name).toLowerCase();
  const inside = library.classes.filter((c) => c.name.length >= INSIDE && name.includes(c.name.toLowerCase())).sort((a, b) => b.name.length - a.name.length || a.id.localeCompare(b.id))[0];
  if (inside !== undefined) return found('nearest', inside, `${key.name} holds the name ${inside.name}`);
  const nearest = library.classes.map((c) => ({ c, near: nameSimilarity(name, c.name) })).sort((a, b) => b.near - a.near || a.c.id.localeCompare(b.c.id))[0];
  if (nearest !== undefined && nearest.near >= NEAR) return found('nearest', nearest.c, `${nearest.c.id} has the nearest name to ${key.name} (${nearest.near.toFixed(2)})`);
  const described = description === undefined || key.description.trim() === '' ? undefined : library.classes.map((c) => ({ c, near: description(key.description, [`class:${c.id}`]) ?? 0 })).sort((a, b) => b.near - a.near || a.c.id.localeCompare(b.c.id))[0];
  if (described !== undefined && described.near >= NEAR_DESCRIPTION) return found('nearest', described.c, `${described.c.id} has the nearest description to ${key.name}'s (${described.near.toFixed(2)})`);
  return { tier: 'none', profile: null, resolveAs: own, options: key.options, reason: `no profile is named ${key.name} or near it; no class rule applies` };
};

const NEEDS = /: needs /u;
/** A name nothing in the set defines. Only a class defines the names handlers need (no handler defines one another needs), so no other choice can mend it. */
const UNDEFINED = /: needs \S+, which nothing defines/u;

/**
 * The resolver's sentences that refuse a set under this class. A name the
 * class lacks refuses, when there is a profile to say so; without one, what
 * the class defines is unknown and it refuses nothing. A set still being made
 * (`partial`) is not refused for a package or a claim another choice may
 * supply.
 */
export const refusing = (violations: readonly string[], cls: ClassMatch, partial: boolean): string[] =>
  violations.filter((v) => (UNDEFINED.test(v) ? cls.profile !== null : !(partial && NEEDS.test(v))));
