yes

# 0334-business-card-with-qr-code: Business Card with QR Code

- Unverified: read from the source, not compiled.
- Source: Source/0334-business-card-with-qr-code/ (origin: https://latextemplates.com/downloads/businesscard-qrcode.zip; licence: LGPL-3.0)
- Kind: misc (a single printable visiting card with a vCard QR code; the manifest hint was `misc`)
- Lib: v3
- Engine: needs XeLaTeX (README.md:5 names "XeLaTeX workflow"; the CTAN page for `businesscard-qrcode` says it needs XeLaTeX to work properly; the class source was not read, so the reason inside the class, probably a font package, is not confirmed)
- Look carried by: class (the whole look is the published class `businesscard-qrcode`; the zip adds class option values and contact field values only, main.tex:1-27)
- Class origin: tex-distribution-unbundled (the class is not in the zip, README.md:8-9 says it is supplied by TeX Live; CTAN page ctan.org/pkg/businesscard-qrcode lists it as version 1.2, 2018-08-15, author Marc Waeckerlin, LGPL)
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
A published class, not bundled in the zip, defines the card; the zip holds one 31-line `main.tex` with no preamble packages, no macros and no body markup besides the one `\drawcard` call. Everything the sample sets is a class option or a class-native field command, so it reduces to `class.businesscard-qrcode` plus its options and the class's own data fields. The class's source was NOT read (it is not in the zip and only the CTAN page was consulted), so how the card, QR code and crop marks are built inside the class is taken on trust as published code, as the rubric's ruling on published classes allows. No ART, no BESPOKE, no EXTERNAL tool (the CTAN dependency list is all TeX packages: calc, crop, DejaVuSans, etoolbox, fontawesome, fontenc, geometry, kvoptions, marvosym, qrcode, varwidth, wrapfig).

## Blockers
none

## Class setting
- Class: `class.businesscard-qrcode` options: `paperwidth=89mm`, `paperheight=59mm`, `contentwidth=85mm`, `contentheight=55mm`, `textwidth=0.56`, `qrwidth=0.32`, `textfirst`, `rightalign`, `iconright`, `hint`, `icon` (main.tex:1-13)
- Class-native vocabulary used: field commands `\type`, `\givennames`, `\familynames`, `\additionalnames`, `\street`, `\city`, `\zip`, `\country`, `\phone`, `\email`, `\homepage`, `\github` (main.tex:16-27) and the body command `\drawcard` (main.tex:30). Spaces in values that go into the QR data are escaped as `\ ` (main.tex:15, 17, 19, 20, 23). Meaning of each option is inferred from its name only, since the class source was not read.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1-13 | `class.businesscard-qrcode` | the eleven options listed under Class setting |
| paper size and content area | main.tex:2-5 | `page.class-options` | paperwidth=89mm, paperheight=59mm, contentwidth=85mm, contentheight=55mm (class keys; the class loads `geometry` per the CTAN dependency list, not read) |
| text block versus QR block split | main.tex:6-7 | `front.class-native` | textwidth=0.56, qrwidth=0.32 (unit not confirmed; presumably fractions of the content width) |
| card layout switches | main.tex:8-12 | `front.class-native` | textfirst, rightalign, iconright, hint, icon (boolean-style flags; effect inferred from names) |
| contact data fields (the card's content and the QR payload) | main.tex:16-27 | `front.class-native` | `\type{work}`, name, organisation, address, phone, email, homepage and `\github` strings |
| card output | main.tex:29-31 | `front.class-native` | one `\drawcard` call inside `document`; no other body construct |

No other component is defined or used: the sample has no `\usepackage`, no sectioning, lists, floats, tables, bibliography or maths (main.tex:1-31). Crop marks are mentioned in README.md:4 and the CTAN page lists `crop`, but the sample sets no option for them (main.tex:1-13), so they are class behaviour, not a separate component here. Considered, not used as lib ways: `crop`, `qrcode`, `fontawesome`, `marvosym` (all loaded inside the class per the CTAN page, none called by the sample).

## Bespoke code
none (no `\newcommand`, `\def`, environment, counter or conditional in main.tex:1-31; no zip-local .cls or .sty)

## Content-opaque
none (the contact values at main.tex:16-27 are content; the QR code and any icons are drawn by the published class from those values, not by a drawing in the zip)

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
