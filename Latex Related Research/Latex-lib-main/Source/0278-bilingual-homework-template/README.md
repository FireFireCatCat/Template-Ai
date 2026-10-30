# Bilingual Homework Template (homework.cls)

A starter using Yuzheng Cai's `homework` document class — genuinely
bilingual within a single document: English chrome (title, running
header) with full Chinese support in the body text, both rendering
correctly side by side. Built on Josh Davis's well-known
`latex-homework-template` (credited in the class and in
`references.bib`).

## Files

- `main.tex` — the assignment. Start here.
- `homework.cls` — the document class, vendored (see below).
- `references.bib` — bibliography, cited from `main.tex`.

## The class is vendored — a real filename collision

`homework.cls` **is** bundled here, deliberately. A different,
unrelated CTAN class — Jinwen Xu's 2023–2025 `homework.cls` — ships
under the exact same filename in every modern TeX distribution (the
same collision `math-homework` hits elsewhere on this site). A bare
`\documentclass{homework}` on a stock system silently compiles against
the wrong class.

## Engine: xelatex — required

The class loads `ctex` unconditionally (regardless of the chrome
language toggle described below), and `ctex`'s CJK support needs
XeTeX or LuaTeX.

## Building

    xelatex main
    bibtex  main
    xelatex main
    xelatex main

## Chrome language is chosen by editing the class file, not a documentclass option

The cover page and running header language (English vs. Chinese) is
set by commenting/uncommenting two lines near the top of `homework.cls`
itself:

    \def\hmwkLanguage{E}        % English template, but also supports Chinese in document body
    % \def\hmwkLanguage{C}      % Chinese template

This starter keeps the class's own default (`E`, English chrome) —
that setting is explicitly documented as "English template, but also
supports Chinese in the document body," i.e. genuinely bilingual
within one document, which this starter demonstrates directly: English
problem statements, Chinese worked solutions, both correct in the same
PDF. Swap to `C` in your own copy of `homework.cls` if you want a fully
Chinese cover page and header instead.

## Usage

- `\hmwkTitle`, `\hmwkDueDate`, `\hmwkClass`, `\hmwkAuthorName` — title
  page and header metadata (define with `\newcommand` before
  `\begin{document}`).
- `\begin{homeworkProblem}...\end{homeworkProblem}` — auto-numbered
  problem sections (pass `[n]` to force a specific number for
  non-sequential problems).
- `\solution` — a bold "Solution" header (not an environment); pass
  `[n]` for "Solution of (n)" when a problem has multiple parts.
- Plain `bibtex` with the `abbrv` style — no biblatex backend to worry
  about.

## Licence

MIT, © 2022 Yuzheng Cai — see the class file's own header and
https://github.com/YZ-Cai/LatexHomeworkTemplate.

This starter's content (an NLP problem set) was written for
latextemplates.com and carries no additional restrictions.
