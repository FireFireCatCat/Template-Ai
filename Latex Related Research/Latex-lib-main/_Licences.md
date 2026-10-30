# Licences and use of the stored zips

`Source/` holds 1000 third-party LaTeX template zips, unpacked, each as its source published it when downloaded on 2026-10-23 (hashes and sizes are in `_Manifest.tsv` and `_fetch.tsv`). They are **study material for this research, kept privately**. Do not redistribute the folder. Each zip keeps the licence its author gave it; the licence recorded for each is in `_Manifest.tsv` (column `license`) and in the top of every `Solution/<id>.md`.

| Licence family | Zips |
|---|---|
| LPPL | 489 |
| MIT | 160 |
| not established | 91 |
| Creative Commons | 71 |
| GPL family | 69 |
| other | 69 |
| Apache/BSD/ISC/MPL/OFL | 42 |
| Public domain | 9 |

`not established` means no licence could be found at the source (the publisher kits, for example, are free to download for authors but carry no stated licence). Treat those as all rights reserved: read them for the analysis, do not copy their code into Flouest.

## Where the zips came from

| Source | Zips | How it was reached |
|---|---|---|
| CTAN | 401 | `https://mirrors.ctan.org/<path>.zip`, packages from CTAN's class, journal, thesis, conference, CV, letter, poster, presentation, exam and template topics |
| latextemplates.com | 403 | direct `/downloads/<slug>.zip`; its robots.txt allows crawling; each template records its upstream and licence |
| GitHub | 161 | `codeload.github.com` zip of the default branch of public template repositories found by topic search |
| Publisher kits | 35 | the official zips cited in `Ai/JIT/JIT-Template/template-requirement/*.md`; a blocked page used the web.archive.org copy, as that procedure allows |

## Not used, and why

- **Overleaf gallery.** A template page shows only the main `.tex` and a PDF; the zip is behind "Open as Template", which needs an account and creates a project. Not used.
- **arXiv.** `robots.txt` disallows `/e-print` and says indiscriminate automated downloads are not permitted. Not used.

Nothing from any zip was compiled or executed. Files were only unpacked (entries with an absolute path, `..`, a link or device, a duplicate name or a size lie refuse the whole zip) and read as text.
