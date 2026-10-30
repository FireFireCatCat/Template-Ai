yes

# 0608-amsaddr: amsaddr (author addresses for amsart)

- Unverified: read from the source, not compiled.
- Source: Source/0608-amsaddr/ (origin: https://mirrors.ctan.org/macros/latex/contrib/amsaddr.zip; licence: LPPL 1.3c)
- Kind: misc (a package, not a template: an add-on that moves the address block of an `amsart` title; the zip's only document is its own `ltxdoc` manual)
- Lib: v5
- Engine: pdfLaTeX-compatible
- Look carried by: mixed (the address, email and running-head placement is carried by the package amsaddr, whose source is amsaddr.dtx; the look of the manual is carried by the class `ltxdoc`)
- Class origin: tex-distribution-unbundled (`ltxdoc` for the manual, amsaddr.dtx:26; `amsart` for the package, README.md:3-4; neither is in the zip, so their source was not read)
- Main file: amsaddr.dtx (the `ltxdoc` driver is at lines 25-35; docstrip driver amsaddr.ins; no `.tex` sample; other samples: none; amsaddr.pdf is a shipped build of the manual, not read because no PDF renderer was available)
- Read: main yes (all 334 lines), zip-local classes and styles all (no `.cls` or `.sty` file is present: amsaddr.sty is generated from the unprefixed lines of amsaddr.dtx by amsaddr.ins:24, and those lines, 153-334, were read in full)

## Verdict
The zip is the CTAN source of one published package (amsaddr, in TeX Live and MiKTeX per ctan.org/pkg/amsaddr), so it passes W1; its behaviour is one boolean option `foot` and one string `\emailaddrname` (W2), it serves any `amsart` document (W3), and an emitter writes it as one preamble line `\usepackage[foot]{amsaddr}` with `amsart`'s own `\author` `\address` `\email` in the body (W4): proposed as `front.amsaddr`. The only document is the manual: `ltxdoc` driver, `a4`, a plain title, abstract, three sections, quote and verbatim blocks, all in lib ways (`class.ltxdoc`, `dtx.doc`, kernel ways). Answer `yes` rests on counting amsaddr as published; its code (a copy of `amsart`'s `\@maketitle`, redefined `\author` `\email` `\enddoc@text`) would be irreducible `BESPOKE/class` if the package were zip-local, and a reader who does not accept a CTAN package as a way should read this file as `no`.

## Blockers
none

## Class setting
- Class: `class.ltxdoc` options: none (`\documentclass{ltxdoc}`, amsaddr.dtx:26). The package is meant for a second class: `class.amsart` (README.md:3-4; amsaddr.dtx:75), which the user loads; no file in the zip loads it.
- Class-native vocabulary used: `ltxdoc`/`doc` vocabulary in the manual: `\DocInput` (32), `\DisableCrossrefs` (28), `\CodelineIndex` (29), `\RecordChanges` (30), `\PrintChanges` (33), `\CheckSum` (39), `\CharacterTable` (41-55), `\changes` (58-61), `\GetFileInfo` (38, 63), `\DoNotIndex` (65), `\StopEventually` (148), `macrocode` and `macro` environments (152-332), `\Finale` (333); the short verbatim `|..|` of running text (99-102) is `ltxdoc`'s (inferred, ltxdoc source not read). `amsart` vocabulary the package works on: `\author[short]{}`, `\address{}`, `\email{}`, `\curraddr`, `\urladdr`, `\thanks`, `\dedicatory`, date, subject class and keywords fields (amsaddr.dtx:177, 201, 221, 224-227, 292-312; amsart source not read).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class of the package's target document | README.md:3-4; amsaddr.dtx:75, 289-322 | `class.amsart` | no options in the zip; amsaddr copies the pieces of `amsart`'s `\@maketitle` (`\@settitle`, `\@setabstract`, `\@setdate`, `\@setkeywords`) so it works with that class only |
| package load and option | amsaddr.dtx:99-102, 164-166; amsaddr.ins:24 | `front.amsaddr` | `\usepackage[foot]{amsaddr}`; `foot` is one boolean (`\if@footaddr`); no option means addresses under the author names |
| address block under the author names (default) | amsaddr.dtx:214-231, 302-305 | `front.amsaddr` | centred; each `\author` group in `\MakeUppercase` (218); `\address` text in `\itshape` (222) after `\addvspace\bigskipamount` (221); `\\` becomes `\linebreak` (219); all fixed in the package |
| address block as first-page footnote | amsaddr.dtx:237-251, 292, 302 | `front.amsaddr` | `foot` set: unnumbered footnote; `\address[opt]` prints `(opt)` first (244); text in `\scshape` (245); `\\` becomes `, ` (239); names printed by `amsart`'s `\@setauthors` (302); the author numbers the names by `$^n$` (127-137) |
| email footnote | amsaddr.dtx:200-207, 280-282, 293 | `front.amsaddr` | several `\email` calls joined by `,\space` of `\mbox` (203-205); label `\emailaddrname` then `\ttfamily` list (281); the label string is a parameter, documented default `\def\emailaddrname{{\itshape Email address}}` (121-125; the code at 153-334 does not define it, so the default comes from `amsart`, inferred) |
| running-head author names | amsaddr.dtx:177-191, 299 | `hf.class-native` | `\author[short]{name}` collects `\shortauthors`, passed to `\@mkboth{\shortauthors}{\shorttitle}` of `amsart`'s own heads |
| end-of-document address block replaced | amsaddr.dtx:320, 329-331 | `front.amsaddr` | `\enddoc@text` redefined so `amsart` does not print the addresses again; `\addresses` is `\let` to `\relax` after the title, so as read `\curraddr` and `\urladdr` are not printed (226-227, 248-249; inference, not compiled) |
| `amsart` front fields kept by the copied `\@maketitle` | amsaddr.dtx:294-298, 306-312 | `front.class-native`, `abs.class-native`, `abs.keywords`, `abs.classification` | date, subject-class, keywords and `\thanks` footnotes; `\dedicatory` in `\footnotesize\itshape` at 18pt baseline; abstract by `\@setabstract`; these are `amsart`'s own commands, only re-called; the manual does not use them |
| class of the manual | amsaddr.dtx:26 | `class.ltxdoc` | no options |
| paper size of the manual | amsaddr.dtx:27 | `page.vmargin` | `\usepackage{a4}` (`a4.sty`, in the `ntgclass` bundle, CTAN and TeX Live, LPPL 1.3c; legacy fixed A4 layout with no options, as `fullpage`; ctan.org/pkg/a4 read) |
| documentation machinery | amsaddr.dtx:28-33, 39-65, 148-152, 333 | `dtx.doc` | `\DisableCrossrefs`, `\CodelineIndex`, `\RecordChanges`, `\DocInput{amsaddr.dtx}`, `\PrintChanges`, `\CheckSum{319}`, `\CharacterTable`, four `\changes`, `\GetFileInfo`, `\DoNotIndex{\newcommand,\newenvironment}`, `\StopEventually{}`, `macrocode`/`macro`, `\Finale`; the change history needs the usual `makeindex` pass, a TeX-distribution tool like BibTeX, not EXTERNAL |
| title block of the manual | amsaddr.dtx:67-72 | `front.maketitle`, `front.thanks` | `\title{The \textsf{amsaddr} class\thanks{...}}`, `\author{... \\ \texttt{...}}`, `\date{\today}`, `\maketitle` |
| inline font marks | amsaddr.dtx:68, 70, 119 | `mark.kernel` | `\textsf`, `\texttt`, `{\it ...}` |
| abstract | amsaddr.dtx:74-76 | `abs.kernel` | plain `abstract` environment |
| contents | amsaddr.dtx:79 | `toc.kernel` | `\tableofcontents` |
| headings | amsaddr.dtx:81, 96, 150 | `head.kernel` | three `\section`, default `ltxdoc` look |
| quotation | amsaddr.dtx:85-88 | `quote.kernel` | `quote` environment (address block of the licence) |
| verbatim examples | amsaddr.dtx:99-102, 106-114, 122-124, 129-137, 141-145 | `code.verbatim` | `verbatim` environments and `|..|` short verbatim holding usage examples (code text is content) |
| centring and line breaks | amsaddr.dtx:86, 117, 120, 141-145 | `sp.ragged`, `sp.manual-space` | `center` environment around a `verbatim` (141-145); `\\` line breaks in the quote and between text lines (86, 117, 120) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| package code of amsaddr (`\author`, `\email`, `\@maketitle`, `\@set@authors@addresses`, `\@setfoot@addresses`, `\@setaddresses`, `\@setemails`, `\enddoc@text`, `\if@footaddr`, counter `g@author`) | amsaddr.dtx:153-334 | not applicable: published | The code is the source of the CTAN and TeX Live package amsaddr, so it is the way `front.amsaddr` and the emitter writes `\usepackage[foot]{amsaddr}` instead of copying it. Read as zip-local code it would be irreducible (`BESPOKE/class`): it replaces `\@maketitle` and `\enddoc@text` and accumulates author, address and email lists with conditionals, which no lib way expresses |
| macros leaked by the package: `\filename`, `\fileversion` (`v1.0`), `\filedate` (`2006/12/12`) | amsaddr.dtx:153-155 | yes | print nothing; no way needed |
| `\protected@edef` fallback | amsaddr.dtx:156-158 | yes | compatibility line for old formats; no printed effect |
| docstrip quirk: `\ProvidesClass{amsaddr}` is guarded `class` while amsaddr.ins generates with guard `package` | amsaddr.dtx:19-23; amsaddr.ins:24 | yes | as read, the generated amsaddr.sty has no `\ProvidesPackage` line; no printed effect |

## Content-opaque
none (the `macrocode` text at amsaddr.dtx:152-332 is the package's own code printed by the manual, code-text content)

## Lib changes
- New ways proposed: `front.amsaddr` `amsaddr` (CTAN, TeX Live, MiKTeX, LPPL 1.3c; Jérôme Lelong; v1.3 of 2026-01-30; engine pdf): `\usepackage[foot]{amsaddr}` after `\documentclass{amsart}` (the CTAN page says `amsart` only); the one option `foot` is a boolean and the string `\emailaddrname` sets the email label; in the body `amsart`'s `\author[short]{}`, `\address{}`, `\email{}` are used unchanged, and the package prints each address under its author names (default) or as a first-page footnote (`foot`), with the emails always in a footnote; it replaces the end-of-document address block. W1: CTAN and TeX Live (ctan.org/pkg/amsaddr read); W2: option and string; W3: serves any `amsart` document; W4: one preamble line, no body wrapper. Considered and not used: `front.authblk` (`\affil` commands for article-like classes, a different mechanism), `front.class-native` (a package, not a class's own vocabulary), `front.hep-title` and `front.titling` (other title-restyling packages).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
