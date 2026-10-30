# Colourful Maths Assignment (assignment)

A starter for weekly maths problem sets, using the `assignment` document
class collected in dev-aditya/LaTeX-template. Clean centred title block,
`\problem{}` section headers, `claim`/`proof` environments with QED
tombstones, and a rule `\separator` between problems.

## Files

- `main.tex` — the assignment. Start here.
- `assignment.cls` — the document class, vendored (see below).

## The class is vendored — a real filename collision

`assignment.cls` **is** bundled here, deliberately. A different,
unrelated CTAN class — Madhusudan Singh's 2004 `assignment.cls` (LPPL)
— ships under the exact same filename in every modern TeX distribution.
A bare `\documentclass{assignment}` on a stock system silently compiles
against **that** class instead — confirmed by checking this pipeline's
own compiler, which has the CTAN version installed.

The class file's own header additionally credits a different original
author, Jacob Strieb, than the collecting repository (Aditya Dev) — both
under MIT, and Strieb's original notice is preserved verbatim in the
file.

## Building

    pdflatex main

One pass — no bibliography, no cross-references.

## Class options go directly in `\documentclass[...]`

Unlike most classes on this site, metadata is passed as
`\documentclass[name=...,regnum=...,course=...,num=...]{assignment}` —
there are no separate `\name{}`/`\course{}` macros. A **space inside a
value needs an escaped backslash**, e.g. `name=Ada\ Lovelace`, since
xkeyval option values here are not brace-grouped.

Optional options: `type=` (default "Assignment"), `emaildomain=`
(default `iisermohali.ac.in` — the original author's institution;
override it), `probword=` (default "Problem").

## Usage

- `\problem{N}` — starts a numbered problem section.
- `\begin{claim}...\end{claim}` and `\begin{proof}...\end{proof}` —
  standard proof formatting with a QED tombstone.
- `\separator` — a centred horizontal rule between problems.

## Licence

MIT. The class header credits Jacob Strieb as the original author; the
collecting repository (dev-aditya/LaTeX-template) is also MIT-licensed
— see https://github.com/dev-aditya/LaTeX-template.

This starter document is a minimal example written for latextemplates.com
and carries no additional restrictions.
