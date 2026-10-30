# GeekPlux CV/Résumé (Bilingual, moderncv)

A bilingual Chinese/English CV built on [moderncv](https://ctan.org/pkg/moderncv)'s
`classic` theme, using `xeCJK` so Chinese and English headings and body text
sit side by side in one document.

By [geekplux](https://github.com/geekplux). This starter keeps the
upstream's `template_cn_blue.tex` structure and content style (bilingual
section headers, `\cventry`/`\cvline`/`\cvlistitem`), rewritten with a
fictional example CV and, importantly, different fonts — see below.

## The fonts were rewritten, not just "kept"

Upstream picks fonts with `\ifwindows`/`\ifmacosx` branches: Times New
Roman for Latin text, and SimSun/STSong/STFangsong for CJK — all fonts that
exist only as OS-bundled fontconfig families on Windows or macOS. None of
those branches match Linux, and this TeX Live install's fontconfig only
resolves DejaVu and the URW base-35 clones by family name regardless of
platform (see `research/README.md`'s font-trap section) — so the upstream
fonts would have silently failed to load here, on any platform this pipeline
runs on.

This starter instead loads **TeX Gyre Termes** (a Times-alike) for Latin
text and the **Fandol** family for CJK, both by OTF filename via
`kpsewhich`, which resolves through kpathsea independent of fontconfig or
OS. Confirmed both are present in this TeX Live with `kpsewhich
texgyretermes-regular.otf` / `kpsewhich FandolSong-Regular.otf`.

## Files

- `main.tex` — the CV. Start here.

No custom class is bundled: this is `moderncv`, which ships with TeX Live.

## Adding a photo

The original repo used the author's own personal avatar image, which this
download does not carry — it is not obviously licensed for reuse and is not
representative CV content anyway. Add your own photo next to `main.tex` and
uncomment the `\photo[64pt]{...}` line to enable it.

## Building

    xelatex main

One pass is enough (no bibliography, no cross-references).

## Licence

**MIT**, © geekplux. Full licence text:
https://github.com/geekplux/cv_resume/blob/master/LICENSE

This starter document is a fictional example written for
latextemplates.com and carries no additional restrictions.
