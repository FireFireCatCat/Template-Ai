# Multi-Recipient Postcard Mailing (postcards.cls)

A physical 5.5x3.5in postcard, one per recipient, read from a plain-text
address file (`addresses.txt`, one name/address/salutation triple per
entry). Each recipient gets two pages: a message side and an
address-label side (real barcode plus flush-right recipient block, via
the `envlab`/`mailing` packages).

## Patched: version-skew in the page geometry

The class's own `\RequirePackage[...]{geometry}` sets `voffset=5in` — a
1999-era convention for printing a small postcard onto a larger
physical sheet through a specific printer driver, where the "page" is
offset from the sheet's origin. Under a modern PDF pipeline this just
shifts all content 5in down within the SAME 3.5in-tall page canvas,
i.e. entirely off it. Every postcard compiled with zero errors and
zero warnings beyond routine underfull-hbox notices, and rendered a
completely blank page — caught only by viewing the preview PNG, not
the log.

`main.tex` re-applies `\geometry{voffset=0in}` after the class loads,
which restores real content to the visible page without touching the
postcard's actual page size or margins.
