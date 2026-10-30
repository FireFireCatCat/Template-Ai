yes

# 0175-recipe-index-cards: Recipe Index Cards

- Unverified: read from the source, not compiled.
- Source: Source/0175-recipe-index-cards/ (origin: https://latextemplates.com/downloads/recipecard-index-cards.zip; licence: LPPL-1.2)
- Kind: misc (recipe cards on letter paper, to cut out and glue onto 4x6 index cards)
- Lib: v3
- Engine: pdfLaTeX-compatible (kernel `\usefont` with T1 Times and Zapf Chancery at recipecard.cls:25-26,87; no fontspec)
- Look carried by: class (the whole look is the published `recipecard` class; main.tex has no preamble and no macros)
- Class origin: ctan
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles all

## Verdict
The look is carried entirely by `recipecard` (Ben Reish), which `ctan.org/pkg/recipecard` lists as a CTAN class (v2.0, in TeX Live). main.tex is `\documentclass[4x6]{recipecard}` plus the class's own commands, nothing else (main.tex:4-57). The zip's copy of the class is that class with one latextemplates.com compatibility patch (recipecard.cls:30-36); the class loads only published packages (`calc`, `ifthen`, `boxedminipage`, `geometry`) and needs no outside tool. So `yes`, as class-dimension evidence (class-carried), not evidence about the component ways. Two caveats are recorded below: the option `4x6` is not declared by this class, and the class keeps state between commands and cards.

## Blockers
none

## Class setting
- Class: `class.recipecard` options: `4x6` (main.tex:4). The class declares `fivebyseven`, `fourbysix`, `threebyfive` and `nothing` (recipecard.cls:37-49), not `4x6`. An unknown option goes to `\DeclareOption*{\typeout{What's \CurrentOption?}}` (recipecard.cls:51), which only prints a message, so by this reading the default `\ExecuteOptions{fivebyseven,nothing}` (recipecard.cls:53) stays in force: the sample as written sets 7in x 5in cards, not 6in x 4in. An emitter wanting the 4x6 card must write `fourbysix`.
- Class-native vocabulary used:
  - `\ingredient{text}` repeated (main.tex:8-16,36-40; recipecard.cls:58-62): adds one item to the pending ingredient lists.
  - `\changeingrdlistnum{n}` (main.tex:35; recipecard.cls:64-66): items per column, default 7 (recipecard.cls:63), 4 under `threebyfive` (recipecard.cls:71). The value is not reset when a card ends (recipecard.cls:121-126), so it carries over to later cards.
  - `\cookingtime{text}` (main.tex:17,41; recipecard.cls:131-133) and `\cooktemp{degrees}{unit}` (main.tex:18; recipecard.cls:135-138): both are optional and are cleared after each card (recipecard.cls:125).
  - `\begin{recipe}{title}{servings}` ... `\end{recipe}` (main.tex:19-33,42-55; recipecard.cls:79-129): the body is the method text; an empty servings argument drops the "Serves:" label (recipecard.cls:80-81).
- Order and capacity constraints from the class code: the ingredient, time and temperature commands must come before `\begin{recipe}` (they fill registers the environment prints, recipecard.cls:91,97,103,113, and clears, recipecard.cls:121-126). Capacity is three columns of `n` items (`n` is the `\changeingrdlistnum` value). Past that, the class code has a `\ClassError` (recipecard.cls:170-176), but by my reading it never fires: the test before it is true whenever it is reached (recipecard.cls:164-165), so item 3n+1 goes to the third column and the counter is set to 2 (recipecard.cls:166), and later items re-enter the first column. An emitter must keep each card at 3n items or fewer.
- Class-internal composition (published class, shown for completeness): `\RequirePackage{calc,ifthen,boxedminipage}` (recipecard.cls:19) and `\RequirePackage[letterpaper,noheadfoot]{geometry}` (recipecard.cls:20); no `\LoadClass` (grep finds none), so it is a kernel-only class with `\normalsize` redefined (recipecard.cls:25-26); `\usefont{T1}{ptm}{m}{n}` body and `\usefont{T1}{pzc}{mb}{it}` card title (recipecard.cls:25-26,87); each card is an `lrbox` holding nested `minipage`s, shown through `boxedminipage` (recipecard.cls:85-119). `boxedminipage` was read once on CTAN: Scott Pakin, LPPL 1.3c, in TeX Live.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:4; recipecard.cls:16-18 | `class.recipecard` | option `4x6` (not declared, see Class setting); vocabulary listed above |
| card size and page | main.tex:4; recipecard.cls:20,27-28,37-48,53 | `page.class-options` | the class's own size options `fivebyseven` (default: body 7in x 10.25in, left .75in, card 7in x 5in), `fourbysix` (body 6in x 8.15in, card 6in x 4in), `threebyfive` (landscape, card 5in x 3in); sheet is letter paper with `noheadfoot`; the class's size option selects it |
| card (frame, title row, servings, ingredient columns, rule, method text) | main.tex:19-33,42-55; recipecard.cls:79-129 | `class.recipecard` | `recipe{title}{servings}`; boxed card of the option's width, title row at 14.4/17pt Zapf Chancery with "Serves: n" flush right, up to three ingredient columns of width 1.75in (fourbysix), 2in (fivebyseven) or 1.5in (threebyfive) (recipecard.cls:39,43,47), hanging indent .25in (recipecard.cls:90-91), a 0.7pt rule .714 of the card width (recipecard.cls:109), method paragraphs each indented 1em (recipecard.cls:111), .35in gap between cards (recipecard.cls:120) |
| ingredient list | main.tex:8-16,35-40; recipecard.cls:57-66,140-182 | `class.recipecard` | `\ingredient` per item; `\changeingrdlistnum{2}` at main.tex:35 gives 2+2+1 items for the five carbonara ingredients, default 7 gives 7+2 for the nine cookie ingredients (reading of recipecard.cls:141-169) |
| cook time and temperature | main.tex:17-18,41; recipecard.cls:113,130-138 | `class.recipecard` | `\cookingtime{25 min.}`, `\cooktemp{375}{F}`; bold "Cook Time:" left and "Temperature:" right on the last line of the card |
| base and title fonts | recipecard.cls:25-26,72-73,87 | `class.recipecard` | fixed by the class: Times 10pt on 12pt (8pt on 10pt under `threebyfive`), card title Zapf Chancery 14.4pt on 17pt; the sample sets none of it |

The sample uses no headers or footers (none are defined: `noheadfoot` at recipecard.cls:20 and no `\pagestyle` in the class), no sectioning, front matter, math, floats, tables, bibliography, language or metadata packages. main.tex has no preamble at all.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\renewcommand{\textdegree}{\textsuperscript{$\circ$}}`, a latextemplates.com compatibility patch (2026-08-27) | recipecard.cls:30-36 | yes | A one-line alias for the degree glyph in the temperature line; per its own comment it only swaps `\newcommand` for `\renewcommand` to avoid a clash with the kernel's `\textdegree` under TeX Live 2025. The emitter ships the class file (an asset) or the TeX Live copy; it is not a template look. |
| Ingredient distribution (`\@ddtoNgrdList`, counters `ingred@cnt` `ingred@list`, token registers, nested `\ifthenelse`), `recipe` environment (`lrbox`, nested `minipage`s, `\everypar`, `\hspace{-21pt}` offsets), size booleans | recipecard.cls:21-23,57-182 | not counted | These are the internals of a published CTAN class, so they are the way `class.recipecard` (W1), not bespoke code. For a re-read under a definition that does not accept a published class as one way: they would be irreducible (hand-rolled counters and conditionals drive what is printed), `BESPOKE/class` at recipecard.cls:140-182. |

## Content-opaque
none

## Lib changes
- New ways proposed: none (`boxedminipage` was considered; it is loaded inside the published class, so no component way is needed)
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
