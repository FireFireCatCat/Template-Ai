/**
 * The score's weights (ARCHITECTURE.md section 5): data, versioned, and
 * printed in every report. Set by hand; fitted on the evaluation later, with
 * a new version.
 */
export type Weights = {
  readonly version: string;
  readonly features: number;
  readonly params: number;
  readonly packages: number;
  readonly description: number;
};

export const WEIGHTS: Weights = { version: 'hand-1', features: 1, params: 1, packages: 2, description: 2 };
