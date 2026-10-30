# Mail-Merge Form Letter (formlett.sty)

One letter body with numbered placeholder fields (`\paras[n]`), rendered
once per recipient from a plain-text data list at the end of the
document (`\moreletter` blocks). This starter produces a 3-page PDF —
one renewal-notice letter per recipient, each with its own name,
address, membership number and date substituted in.

## Do not add `\preview` back

`formlett`'s own documented example includes a `\preview` call. It is a
DEBUG mode, not a "render the merge" flag: with it active, every
`\paras[n]` slot renders as a boxed placeholder marker (`1-1`, `2-3`,
...) instead of the actual recipient data — a clean compile that
produces a PDF full of literal field-index boxes rather than a letter.
It is meant to be toggled on briefly to verify field-to-slot mapping
while authoring, then removed. This starter ships with it removed.
