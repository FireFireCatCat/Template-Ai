yes

# 0158-spanish-invoice: Spanish Invoice (factura fiscal, Venezuela)

- Unverified: read from the source, not compiled.
- Source: Source/0158-spanish-invoice/ (origin: https://latextemplates.com/downloads/spanish-invoice.zip; licence: LPPL-1.3c)
- Kind: invoice
- Lib: v3
- Engine: pdfLaTeX-compatible (main.tex:10 loads `inputenc` with `utf8`, a pdfLaTeX-style line; the class source was not available, and the CTAN page for `factura` lists no dependency, so a XeLaTeX or LuaLaTeX need is not shown but not excluded either)
- Look carried by: class (the zip is one 30-line `main.tex` and holds no `.cls` or `.sty`; main.tex:9 loads `factura`, which draws the whole invoice; the sample adds only setter values at main.tex:12-21 and three item rows at main.tex:25-27)
- Class origin: tex-distribution-unbundled (`factura` is on CTAN, version 4.32, LPPL 1.3c, "Included as factura" in TeX Live and MiKTeX, author Emilio Augusto Lazo Zaia; read twice at https://ctan.org/pkg/factura; the class is NOT in the zip)
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
Yes. The zip is a single file, `main.tex`, that defines no macro, environment, counter, package or class of its own (a grep for `\newcommand`, `\def`, `\let`, `\newenvironment`, `\newcounter`, `\usepackage` shows only `\usepackage[utf8]{inputenc}` at main.tex:10). Everything that decides the look, the line-item rows, the per-line IVA and the total is inside the published CTAN class `factura` (main.tex:1, 9; the comment at main.tex:6-7 says `\Item` computes the IVA and the class totals), which is one way, `class.factura`; the sample only feeds it strings and three `\Item` rows. An emitter can write `\documentclass{factura}`, `\usepackage[utf8]{inputenc}`, the ten setters, one `factura` environment with `\Item` rows and `\Descripcion`, using only published code. Caveat: the class source was not in the zip and was not read; what it loads, its page, font and header settings and how it computes totals are inherited and not analysed, and the CTAN page names no commands, so that the sample's vocabulary (`\Num`, `\RIF`, `\Item`...) belongs to CTAN's `factura` 4.32 is inferred from the match of name, licence and the Venezuelan SENIAT/RIF/IVA subject, not read. This is evidence about the class dimension, not about the component ways.

## Blockers
none

## Class setting
- Class: `class.factura` options: none (main.tex:9, `\documentclass{factura}` with no optional argument)
- Class-native vocabulary used: preamble setters `\Num` `\RazonSocial` `\RIF` `\Contacto` `\Direccion` `\Telefono` `\Email` `\Fecha` `\Resumen` `\NotaFinal` (main.tex:12-21); environment `factura` holding `\Item{a}{description}{b}` rows (main.tex:24-28; the first argument reads as a quantity and the third as a unit price from the sample values, and the comment at main.tex:6-7 says `\Item` computes each line's IVA and the class totals the invoice, all inferred from the sample, not from class source); closing paragraph `\Descripcion{...}` after the environment (main.tex:29)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:9 | `class.factura` | no options |
| input encoding | main.tex:10 | `font.fontenc-t1` | `\usepackage[utf8]{inputenc}` (no `fontenc` line in the sample); accents typed with kernel commands `\'e` inside strings (main.tex:13, 15, 20, 21, 29) are content |
| page geometry, paper, margins | not set in the sample | `class.factura` | inherited from the class (not read); no explicit setting to emit |
| fonts, spacing, colours, header and footer | not set in the sample | `class.factura` | inherited from the class (not read); no explicit setting to emit |
| language (Spanish text) | not set in the sample (no `babel` line) | `class.factura` | the sample loads no language package; whether the class sets Spanish names is unknown (class not read) |
| invoice number | main.tex:12 | `front.class-native` | `\Num{482}` |
| client identity block (name, tax ID, contact, address, phone, email) | main.tex:13-18; the RIF is the client's, per the comment at main.tex:5 | `front.class-native` | `\RazonSocial`=Ferreteria Altamira, C.A. (TeX accent), `\RIF`=J-40.812.556-3, `\Contacto`=Rosaura Beltran (TeX accent), `\Direccion`=Av. Francisco de Miranda ... Caracas, Venezuela (`Av.\ ` control space), `\Telefono`=+58 (212) 555.04.18, `\Email`=rosaura.beltran@example.com |
| invoice date | main.tex:19 | `front.class-native` | `\Fecha{27-08-2026}` (a typed string, not `\today`) |
| summary line | main.tex:20 | `front.class-native` | `\Resumen{Suministro de materiales de ferreteria para obra}` |
| closing note | main.tex:21 | `front.class-native` | `\NotaFinal{Pago a 15 dias fecha factura. Gracias por su preferencia.}` |
| line-item table, per-line IVA and totals | main.tex:24-28; comment main.tex:6-7 | `class.factura` | `factura` environment with three `\Item{qty}{description}{unit price}` rows: 20 / PVC pipes / 18, 8 / cement sacks / 95, 3 / screw boxes / 27 (reading of the arguments inferred; the table, the IVA and the totals are produced by the class) |
| description paragraph after the table | main.tex:29 | `front.class-native` | `\Descripcion{...}` after `\end{factura}`, a body command outside the environment |
| document wrapper | main.tex:23, 30 | `class.factura` | `\begin{document}` ... `\end{document}` |

## Bespoke code
none. There is no `\newcommand`, `\renewcommand`, `\def`, `\let`, environment, counter or conditional in `main.tex` (30 lines, all read). `\Num`, `\RazonSocial`, `\RIF`, `\Contacto`, `\Direccion`, `\Telefono`, `\Email`, `\Fecha`, `\Resumen`, `\NotaFinal`, `\Item`, `\Descripcion` and the `factura` environment are the published class's own commands, not zip-local code. No `factura.cls` is in the zip even though main.tex:1 names it.

## Content-opaque
none (no figure, equation, code or TikZ in the sample; the only content is the company data, three item lines and two sentences).

## Lib changes
- New ways proposed: none (`class.factura` is a class way, written plainly; the item table is the class's own vocabulary, recorded under "Class setting", so no new-way line is needed. Considered: `inv.simpleinvoice` and `inv.facture-belge`, two other invoice packages with different commands, not used here.)
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- The class source (`factura.cls`, CTAN, LPPL 1.3c) was not in the zip and was not read. Everything the class does (page layout, fonts, header, the IVA arithmetic, language names, packages it loads) is inherited and not analysed; the rows marked "inherited" record that, not a measured setting. The CTAN page lists no dependency and no external tool, so an `EXTERNAL` blocker is not shown, but the calculation method is unknown.
- The comment at main.tex:7-8 says the printed total is "verified below" to be a resolved number; nothing below the comment checks it, and nothing here is compiled, so that claim is not confirmed. The comment is plain author prose, not text addressed to an AI.
- The sample date `27-08-2026` (main.tex:19) and the `example.com` address (main.tex:18) point to a placeholder invoice written for the template page; the data is content.
