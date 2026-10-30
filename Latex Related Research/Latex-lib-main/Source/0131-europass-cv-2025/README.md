# europasscv2025

The 2025 revision of the Europass CV format, from
`ctan:europasscv2025` / `github:Supercaly/europasscv2025` (LPPL-1.3c) —
a newer, actively maintained alternative to the older `europasscv`
(2013 revision) already in this catalogue, with a redesigned header,
colour schemes and a `\ecventry` key-value interface.

## Files

- `main.tex` — start here.
- `europasscv2025.cls`, `locale/`, `colors/`, `europass_logo.pdf` —
  vendored (see below).
- `photo.png` — a generic silhouette placeholder; replace with your own
  photo or delete the `\ecvphoto{}` line to omit it.

## Not actually in this pipeline's TeX Live

Despite being a recent CTAN package, `europasscv2025.cls` is absent from
the pinned image (confirmed via `kpsewhich`) — bundled here rather than
assumed present.

## Colour schemes

Change `color-default` in `\documentclass[english, color-default]{...}`
to any of: `color-darkblue`, `color-blue`, `color-darkgreen`,
`color-green`, `color-darkviolet`, `color-violet`.

## Licence

LPPL-1.3c, (c) Lorenzo Calisti. Verified in `LICENCE` in the CTAN package
and the class header comment.
