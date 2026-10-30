# jwjournal personal diary

A personal diary/journal writer with dated, colour-coded entries and a
lightweight markdown-like text syntax — Jinwen XU's `jwjournal` class.

- **Engine:** xelatex
- **Class:** `jwjournal` (ships with TeX Live — not bundled here)
- **Licence:** LPPL-1.3c, (c) 2023–2025 Jinwen XU — verified directly in
  the shipped `jwjournal.cls` header.

Despite the name, this is **not** an academic-journal article class — it
is a personal diary. It builds on `minimart`/`einfart` (the same base
classes behind the already-catalogued *einfart minimal article* and
*Stylish Article*/`lebhart` pages), but is a genuinely different document
type: a diary, not an article.

## Syntax

Inside `\begin{jwjournal}...\end{jwjournal}`, plain text uses the class's
own lightweight syntax (see the upstream README for the full list):

- a line starting with a date (`2026-01-05`, also `/` or `.` separators)
  begins a new entry; text after the date is weather/location, with the
  part after the first `|` right-aligned;
- `## {title}` / `### {title}` / `#### {title}` start unnumbered
  (sub)sections — **the braces around the title are required**, unlike
  Markdown (`## title` without braces silently breaks: only the first
  character becomes the heading, tested and confirmed);
- `##+` / `###+` / `####+` give numbered versions;
- `[Note] text` (or `【...】`) starts a note line;
- `*italic*`, `**bold**`, `***bold italic***`, `` `code` `` work inline;
- `>>> text` boxes the rest of a paragraph as a coloured aside.

## Notes

- ENGINE: `einfart` (loaded under XeTeX) requires XeLaTeX or LuaLaTeX;
  the class loads `minimart` instead under pdfTeX.
