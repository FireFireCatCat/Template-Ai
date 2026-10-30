/**
 * Flouest's compiler and editor write console lines on the way (a sample image
 * with no bytes, a mark the compiler drops). Every call into them that is not
 * itself the output of a command is made through `quietly`.
 */
/** `run()` with the compiler's console lines held back, as Flouest's own `compileQuietly` holds them (a sample image with no bytes, and so on). */
export const quietly = <T>(run: () => T): T => {
  const methods = ['log', 'info', 'warn', 'error'] as const;
  const saved = methods.map((m) => console[m]);
  methods.forEach((m) => {
    console[m] = () => {};
  });
  try {
    return run();
  } finally {
    methods.forEach((m, i) => {
      console[m] = saved[i] ?? console[m];
    });
  }
};
