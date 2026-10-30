# Changelog

## Derived from uantwerpendocs v4.12

This work was derived from the `uantwerpendocs` v4.12 code,
preserved at the Git tag `uantwerpendocs-v4.12-code`.

The original source was substantially rewritten and expanded
for the UGent house style. The major changes include:

- Renaming, restructuring, and merging of the classes and large portions of
  the code, and removal of legacy and unused code:
  - `uantwerpenphdthesis` → `ugentphd`
  - `uantwerpenbamathesis` → `ugentbama`
  - `uantwerpenreport` → `ugentreport`
  - `uantwerpencoursetext` → `ugentcourse`
  - `uantwerpenletter` → `ugentletter`
  - `uantwerpenexam` → `ugentexam`
  - `beamerthemeuantwerpen` → `beamerthemeugent`
  - new: `ugentbookcover` and `ugentarticle`
- Migration of class options (key–value, e.g. `faculty=bw`, `campus=kortrijk`,
  `colormodel=cmyk`) and most internals to LaTeX3 (expl3), dropping the
  xstring, xparse, and ifthen packages.
- Reworked dictionary handling: `\translatekey` with casing and expansion
  options, support for empty lines and a `__NEWLINE__` placeholder in `.dict`
  files, and improved babel compatibility (in-document switching via
  `\selectlanguage`).
- Reworked logo handling. No images are used, only TikZ paths (converted from
  the official EPS files) and text, for the UGent logo, all faculty logos,
  GUGC, and campus Kortrijk, plus standalone UGent and faculty icons. The
  faculty may be omitted entirely.
- UGent font handling: UGent Panno Text is required for the logos (and hence
  LuaLaTeX or XeLaTeX), with Arial as option. Noto Sans Math is used with
  TeX Gyre DejaVu Math as fallback. Fake small caps were implemented
  for fontspec fonts.
- Unified handling of people and document data through generalised sequences
  (authors, lecturers, supervisors, tutors, jury members, degrees, contact),
  including indexed affiliations, corresponding authors, e-mail and
  ORCID, a unified `\embargo` macro, localised dates via `localizedates`,
  word counts via texcount, and warnings for missing mandatory macros.
- Reworked book-cover generation. A separate `ugentbookcover` class prints
  covers from command inputs instead of relying on PDF inputs, including an
  automatic ISBN barcode; `\generatebookcover` now creates a more
  structured cover file directly from the main document.
- Integration of UGent-specific covers and title pages following the official
  grid, adding colophons, copyright, confidentiality and embargo notices with
  signature fields, headers and footers, chapter thumbs, and five chapter
  title styles.
- New `ugentarticle` class; a reworked beamer theme (16:9 grid geometry,
  a single configurable graphic frame, title and section graphics, title
  logos, closing frame); and a reworked exam class (subquestions, point
  overview, answer spaces with grid or line fills spilling to the next page).
- Build and release tools: local build script, GitHub Actions workflow,
  encrypted fonts for CI builds, and an auto-generated changelog.
- Extensive changes to documentation and examples, including an index,
  copy-pasteable code blocks, customisation notes, deduplicated examples,
  and a short LaTeX tutorial.

The detailed development history below is generated from Git.

## Development history

## 2026-07-09 — `11878510aba25b6efd39783b09779e2290efa564`

### Renaming to ugent, remove legacy or unused code

**Author:** SeppeOngena


## 2026-07-09 — `813f002cec3f8af42940a2527ebbc30b74649213`

### Implement logos and colours

**Author:** SeppeOngena

Implement UGent and faculty logos and colours.
- Logos are drawn using their icon paths converted from .eps using Inkscape's svg2tikz extension.
- Logo text and colouring is set at compile time, no separate image files needed
- The logo's are very close to the official UGent style. For some faculties, the official letter spacing is inconsistent between lines or even words, which is not transferred here

## 2026-07-09 — `4fad08c95c72112ab3fd5bb85cd2a623bf803676`

### Provide barebones README

**Author:** SeppeOngena


## 2026-07-09 — `851e58e320a2c6a6d468e1e97bca0b077ce21298`

### Set class geometries

**Author:** SeppeOngena


## 2026-07-09 — `d8d14c8baa04a2defed765ea47a1faa99d392f60`

### update barebones README

**Author:** SeppeOngena


## 2026-07-09 — `1fc0eea628806c720ec0efcd8685475690784c91`

### Stronger WIP message

**Author:** SeppeOngena


## 2026-07-10 — `fde48289d4f472fb6eca556039fdbca64139a095`

### Add build.sh for local testing

**Author:** SeppeOngena


## 2026-07-10 — `f0cd79bfd5802e846704bd21e86ce2653d81248a`

### Renamed examples

**Author:** SeppeOngena


## 2026-07-10 — `a6513857b2250f0ed6301264aa143cf095934be3`

### Update dictionary naming

**Author:** SeppeOngena

- Changed uantwerpendocsprop and uantwerpendocsPROP to translatekey with uppercase, lowercase, and argument expansion options. Usage: translatekey[uppercase,expand]{org-\fselector}, translatekey[lowercase]{key}
- Prevented file re-read during \captionsenglish or \captionsdutch firing
- Renamed uantwerpendocspropread to useugentdictionary, dictionary files are now named ugentdocs-<dictionary>.dict

## 2026-07-11 — `d59d819d45d0718c96ddcbecdc9f8688990dffc1`

### Fix UTF-8 .dict output by docstripping with LuaLaTeX

**Author:** SeppeOngena


## 2026-07-11 — `411d3455122047322d1a416b92e23fe0929a5ca4`

### Improve .dict readability and support \newline

**Author:** SeppeOngena

- Newlines can be added in .dict files by using the placeholder __NEWLINE__
- Empty lines are now handled, so spacing out the .dict files for readability is now possible

## 2026-07-11 — `41685f7ede466ac46be326eb68b0ff4865ada45f`

### Move thesis disclaimer into .dict

**Author:** SeppeOngena

- bamadisclaimer key added to en and nl .dict files from the previous \disclaimer command
- rearranged and spaced out nl and en .dict files

## 2026-07-11 — `6e24cbcd920fcbe4d8e26d7e5727a6b86c408ac5`

### Dictionaries: removed doctype and degree, adjust en and nl

**Author:** SeppeOngena

- Initial adjustments of en and nl dictionaries to UGent conventions.
- Removed degree dictionary, in thesis class, \degree should be specified.
- Merged doctype into en and nl dictionaries. in thesis class, \doctype should be specified

## 2026-07-12 — `a0050d602c0324553dfd481c16a0663877c07fa7`

### Add font checks, default UGent Panno Text

**Author:** SeppeOngena

- Add font checks for UGent Panno Text Medium and SemiLight, as they are used for the logos. Absolute requirement
- By extension, added a hard requirement for LuaTeX/XeTeX
- Fallback font for no UGent Panno Text (regular) is Arial. Fallback for that is the arev package

## 2026-07-12 — `24fef3e9cc3cc6a4e1da99d21672f8759e0e6f92`

### Changed from scrbook to book for ugentthesis

**Author:** SeppeOngena

Fixes 2 warnings:
- fancyhdr used with scrbook
- unused class options (e.g. bw)

## 2026-07-12 — `ad99ce934d6ee3eeb4150115c45b1df09d102d1e`

### Implement ugentbookcover class

**Author:** SeppeOngena

- Takes faculty, cameraready, and colormode options to set bleedwidth and marklength of the bookcover class.
- Uses \pagecount and \pageweight commands to calculate spine width for the bookcover class
- Needs commands similar to dissertation class, like title, author, etc. Then a simple \begin{document}\makebookcover\end{document} call.
- Calling \generatebookcover{pageweight} in the dissertation class generates a *-cover.tex file, which inherits faculty, page count, cameraready, colour options, and pre-generates the title etc. commands contents.

## 2026-07-13 — `a95a32694eb5474b04624ad5f391fcc92249b3ae`

### Fix faculty logo rendering

**Author:** SeppeOngena

-  ij was not replacing properly to latin ligature ĳ.
- Text width was not set for dutch logo text

## 2026-07-14 — `f78e3053ef567717b718263f6eb5704cf8861045`

### Move spinewidth from ugentbookcover to generatebookcover

**Author:** SeppeOngena

- This was far too complex to justify it.
- A spinewidth is just calculated using default 80g/m2 and 1.25g/cm3 paper (0.1mm thickness).
- A message is printed in the generated file how to calculate the spinewidth

## 2026-07-14 — `5597f350febdbfa96f766f1b40805f2a38456edd`

### Initial dissertation cover, official UGent version

**Author:** SeppeOngena


## 2026-07-15 — `98ab81375de1c03a893bc4a766296af6bc950cff`

### Added ISBN barcode generation

**Author:** SeppeOngena


## 2026-07-15 — `b70521d108ce013e273861551c43bc0752fc88fc`

### Add publisherlogo

**Author:** SeppeOngena


## 2026-07-15 — `b7de9d3abba915b0439839ff8e0e00000eff4d2d`

### Removed versionyear, replaced with \year (\the\year)

**Author:** SeppeOngena

When unset, it just uses the current year by default (default LaTeX behaviour). Set with \year=2023 for example.

## 2026-07-15 — `dccef521fc538bd2aa04213f7dfad20fb8f7dfb2`

### Implemented BW dissertation cover

**Author:** SeppeOngena

automatically set with bw faculty option

## 2026-07-15 — `02465ff65c5d7cb2fdea57af638f51bc540b3e8a`

### Evenly space BW cover confidential notice between logos

**Author:** SeppeOngena


## 2026-07-15 — `0c627dc5aea1f79557b688d52d92fecb3209b7aa`

### Fix dissertation class cover drawing

**Author:** SeppeOngena

includegraphics not parsing math, space issue right after \frontcover{ command

## 2026-07-15 — `a93bcc0f00c347265856b4a19bc20b3898992388`

### Fix page calculation for spine

**Author:** SeppeOngena


## 2026-07-15 — `f6bcaa42de1313ff9771a39b4d7ef7b6067fb140`

### Removed filled class option

**Author:** SeppeOngena

As it's the default anyways for LaTeX, also users can just use \raggedright and \raggedbottom should they wish.

## 2026-07-17 — `d19de8a6ce651b0d0ef71282ba65c7ed4f37a2f0`

### Implement surnamefirst option, authortitle, and updated naming

**Author:** SeppeOngena

- Surnamefirst option will reverse names, e.g. "Surname Firstname".
- \author and other "person" commands use the BibTex format "Surname, Firstname"
- Support multiple authors with " and " separation (e.g. "Surname1, Firstname1 and Surname2, Firstname2"), this does not support multiple authortitles though.
- Added authortitle command that adds a prefix, e.g. "ir." or "dr." to the author. Only for documents with a single author
- Renamed stuff like \jointsupervisors to \printsupervisors, added _seq to sequence names, renamed stuff like \supervisorsname to \supervisorscaption

## 2026-07-17 — `442489788a976329508a2df42ba448cf73459919`

### Pass missing data to generatebookcover

**Author:** SeppeOngena


## 2026-07-17 — `444f7ad9ee99e0bfd911c5336840b6e42d8f4898`

### Fix faclogo text

**Author:** SeppeOngena


## 2026-07-29 — `edca34800c6a5a019f566afc5f081513f302f5b8`

### Add release workflow

**Author:** SeppeOngena


## 2026-07-29 — `861289ce3b16430a1402c5b75e9c8b473e52444a`

### Expand build.sh for GitHub release assets

**Author:** SeppeOngena

- Previous behaviour preserved through the --test flag for ease of iterative development
- build with version number creates a zip file with ugentdocs directory (for installation in .../tex/latex/), an examples directory (with .tex and .pdf) and the documentation pdf. Additionally, a zip is created to attach to a release

## 2026-07-29 — `e68124b8bea3c270de11dd86b3153a959e3b10bd`

### Ensure successful compilation of all classes

**Author:** SeppeOngena

Due to the extent of the changes, some classes would not compile if I want to do e.g. a GitHub pre-release per finished class.

## 2026-07-29 — `b6d270257ddbe793e0bec580061568507a747ff0`

### Expand README with package detail and goals

**Author:** SeppeOngena

Added package purpose, including integration of existing templates and "official recognition" goal
## 2026-07-29 — `19192410b7841c595fdb75455dfa0a0cffaaf08a`

### Implement dean, rector, coverdesigner, and grants macro

**Author:** SeppeOngena

Used for dissertation class. Also adjusted DOI to not use url

## 2026-07-29 — `440baacf2e728258484bee307622cfd518c6369d`

### Implement general \@embargotrue switch

**Author:** SeppeOngena

To avoid nested if for same outcome

## 2026-07-29 — `85fb8330748add8aafd81ae9c2e93dd9ca102851`

### Update dictionaries for dissertation data pages

**Author:** SeppeOngena


## 2026-07-29 — `c8fa05cbe3c5d4eb8e1eb01a2f20d24eb994720b`

### Implement dissertation title and data pages

**Author:** SeppeOngena


## 2026-07-29 — `92c5fac878d16000300dab922a4f01652f8ab89b`

### Fix hyperref style and colour

**Author:** SeppeOngena


## 2026-07-29 — `e146184383034986b336e8b4d9e0f54dcea55c5b`

### Update dissertation titlecolor

**Author:** SeppeOngena


## 2026-07-29 — `cf80000b8b0052cce3542e456351ba4006511e63`

### Update dissertation templates

**Author:** SeppeOngena


## 2026-07-30 — `1b2e6650587f72a6779805697ef419be67ccdecc`

### Fix  dissertation examples

**Author:** SeppeOngena

Add missing stuff, fix image, ensure spine width

## 2026-07-30 — `4e749edf045cdc68b5788ff90f783443758fd4a4`

### Fix pdfinfo

**Author:** SeppeOngena

\renewcommand{\\}[1][] was not working properly

## 2026-07-30 — `eda49c19404fe877c7ce9bccb4a62177a8ed7c10`

### Added encrypted font file for release builds

**Author:** SeppeOngena

As the UGent Panno Text seems only available on the intranet, I do not want to risk sharing it

## 2026-07-30 — `b0091ef89c3bf63db17f648bb7f7f80f69d57b58`

### Add font decryption to release flow

**Author:** SeppeOngena


## 2026-07-30 — `d4764d3a2644c5b34dba2ba85f754c2647e9bcf9`

### Add FONT_DIR handling in build script for font decryption

**Author:** SeppeOngena


## 2026-07-30 — `71c7d2c35fff3cab74cae6608df3c976c13b941d`

### Update implementation status in README.md

**Author:** SeppeOngena

Updated implementation status of ugentthesis and ugentdissertation classes.
## 2026-07-30 — `ebc443f2e231e0265fcb57a6dac3ac6df0a38cfb`

### Added fake smallcaps

**Author:** SeppeOngena

Following Steven Segletes' implementation, see https://tex.stackexchange.com/a/225078

## 2026-07-30 — `a19320cf7fc0680712f10c23e7576fad1831def6`

### Update copyright disclaimer bama thesis

**Author:** SeppeOngena


## 2026-07-30 — `c8f3c4116e624a0f7310a7ba625fd3664759e85b`

### Remove weird reverse sequence tricks

**Author:** SeppeOngena


## 2026-07-30 — `c7371701d74ed39673a33fcf8612cf3ab3b21e51`

### Remove reversevideo placeholder

**Author:** SeppeOngena


## 2026-07-30 — `2edc00216f0fee776022d8e7993eb98959dd71b5`

### Implement general multiple author support

**Author:** SeppeOngena

- \author now works similar to \supervisor.
- added \printauthorlist, which prints the author list in a reference-friendly way

## 2026-07-30 — `40b28176cb440b567e4c7e63b100457f8676b8f3`

### Fix package date and version in docs

**Author:** SeppeOngena


## 2026-07-30 — `9477b7c0abd472ec6c2e5d3e66310f5ffe6fc4be`

### Fetch docs version from build version

**Author:** SeppeOngena


## 2026-07-31 — `42b58892b78a340c4cc10d2c83f0156ad75c300c`

### Fix list printing (3 fixes)

**Author:** SeppeOngena

- Fix print spacing of e.g. \printauthor{\\}{\\}{\\}
- Fix list separators (e.g. author1 & author2 or author1, author2, and author3)
- Fix printing when affiliation is empty
- Some general bug fixes hindering compiling after adding multiauthor support are also included

## 2026-07-31 — `27e6b5108fa859d00f4f576c1e9e08b4204ac9ad`

### Dictionaries: Remove docket in favour of studentnr

**Author:** SeppeOngena


## 2026-07-31 — `09fa0cb85cdd24e47605d309b893f4f21fdd31a3`

### Dictionaries: renamed suffixes/prefixes

**Author:** SeppeOngena

Renamed phdprefix, phdsuffix, and bmprefix to submittedto, phdfulfil, and bmfulfil, respectively

## 2026-07-31 — `6e1b00761116f076b3aa535fa26d8f448018d545`

### Implemented tutors

**Author:** SeppeOngena


## 2026-07-31 — `0830c1559143781fdc75477739d160b36df20867`

### Implemented Ba/Ma title page

**Author:** SeppeOngena

Based on https://github.ugent.be/LatexInfo

## 2026-07-31 — `5a4d0ab605dec49f08d4f2aaaaff1c9b450f043e`

### Temporarily shorten dissertation examples

**Author:** SeppeOngena

This will cause the spine text to not be shown in the auto-generated cover, but speeds up builds until we reach v1.0.0

## 2026-07-31 — `8a8a63559ef713fa25b2a5872f46938f087b012a`

### Add word count support for thesis, dissertation, and report

**Author:** SeppeOngena

- Can be both set manually and scanned by texcount.
- If not specified it does not print on the thesis title page

## 2026-08-01 — `d75af43cb24259019fba580237a9df2543fe7607`

### Adjust thesis titlepage to official grid

**Author:** SeppeOngena

Following ugent-docs by dries benoit and https://styleguide.ugent.be/basic-principles/grid-and-layout.html

## 2026-08-01 — `a7eebec1da360969411665a3c9da74096082df92`

### Implement thesis title page background color

**Author:** SeppeOngena


## 2026-08-01 — `c71d1d219c85b3179dd507551df857c307ead32e`

### Improve dictionary compat with babel

**Author:** SeppeOngena


## 2026-08-01 — `4a56d638e859b2f5b1c5f9bafaffb68e22591e77`

### Add dictionary dual language-support

**Author:** SeppeOngena

Made language a class option instead of requiring the user to accurately set babel options
This makes it possible to switch in the document using \selectlanguage, switching all dictionary keys with it

## 2026-08-01 — `fe95d947cce8a50d9f902e90d5106f24a39e913e`

### Change defenselocation and -date to location and native date

**Author:** SeppeOngena

Broadens use for e.g. examdate, copyrightdate, etc.

## 2026-08-01 — `487ca85396652d2bbe979b7f07a119b3c0f3a4ea`

### Pass case options to captions

**Author:** SeppeOngena

e.g. lowercase to authorscaption

## 2026-08-01 — `ff6964fa16978bc5365169b82a0625d4e5a3220a`

### Updated dictionary casing

**Author:** SeppeOngena

Words such as "Of" and "And" now have correct first letter capitals

## 2026-08-01 — `3e7393bc7a9519366dc226c588bfe03ccd255cbb`

### Added author dictionary keys

**Author:** SeppeOngena


## 2026-08-01 — `aa90dc09ec52a2bfe671a35b5f619ee597dee170`

### Added tabularx loaded by default

**Author:** SeppeOngena


## 2026-08-01 — `067e4ba57b09e61bdd152f6ae5b4b2c1e0e478cb`

### Implemented thesis copyright page

**Author:** SeppeOngena

- Based in layout on https://github.ugent.be/LatexInfo

- Automatically provides signature areas for authors, supervisors, and tutors.

## 2026-08-01 — `916b5c019d1a2e73319f9212ae6fc2beead6c312`

### Add note for including signed copyright pdf

**Author:** SeppeOngena


## 2026-08-02 — `57cd4d17855c5a3ae44e4e3a10a781a5807e6862`

### Fix dissertation embargotemp text

**Author:** SeppeOngena


## 2026-08-02 — `2bf7390f85ee8411633a9c0c856dcd5852208b69`

### Fix justification of dissertation titlte

**Author:** SeppeOngena


## 2026-08-02 — `d158ca3346555098935638cdce9845763fe28587`

### Move dissertation copyright page into \@crnotice

**Author:** SeppeOngena


## 2026-08-02 — `2583e4ca0391e964af6d3918d10c593654818094`

### Add confidentiality support for thesis

**Author:** SeppeOngena


## 2026-08-02 — `10c0805376cdb134d69cae477ccba980aa2b1ddf`

### Implement thesis headers and footers

**Author:** SeppeOngena

From https://github.ugent.be/LatexInfo

## 2026-08-02 — `e1cb6655e3f41e23dbb739c93ba7f08c744ef40a`

### Implement thesis titles

**Author:** SeppeOngena

https://github.ugent.be/LatexInfo

## 2026-08-02 — `a40e15dd50e6d431957b0343bdc2611b104effa0`

### Adjust insetquote and insettext

**Author:** SeppeOngena


## 2026-08-02 — `d55f390591ebcbfb370cc59f0a262549ef6e3b2b`

### Update mathesis example, implement bathesis example

**Author:** SeppeOngena


## 2026-08-02 — `ecb1dae9fdca7501cfb4c2650c03210bee4269ed`

### Fix insettext spacing

**Author:** SeppeOngena


## 2026-08-02 — `b2e7f81de2416cd9aeef1c6fbb3d2c52630d32d5`

### Fix thesis titlepage spacing for coverbg option

**Author:** SeppeOngena


## 2026-08-02 — `6f1241ffb958f9a8b4e7260b84d941340979a628`

### Fix thesis extsupervisor and cosupervisor support

**Author:** SeppeOngena


## 2026-08-02 — `66a6ee5fd3b3b384952d5ac1de7e4ff114350843`

### Add thesis titlepage companylogo support

**Author:** SeppeOngena


## 2026-08-02 — `c5c36630397764926e3573c381a9cf85958142f7`

### Update implementation and integration status

**Author:** SeppeOngena


## 2026-08-03 — `14ecfadc482b70b730df8cdd4629222a39080fb1`

### Add Arial to encrypted fonts

**Author:** SeppeOngena


## 2026-08-03 — `2256c5de779971f5b41482d21a8ccf522e22d593`

### Change companylogo example to example-image

**Author:** SeppeOngena


## 2026-08-03 — `fcdc01b6ea8ae70f9e13a9f2b57c8368c73a8f20`

### Change TOC colour to black

**Author:** SeppeOngena


## 2026-08-03 — `4b81a3d784812e32db3d3f6987dd9bcd65cdedbc`

### Update readme

**Author:** SeppeOngena


## 2026-08-03 — `f2d48268fa2cebe48f8f3950f6e975a98427810f`

### Fix examples

**Author:** SeppeOngena


## 2026-08-03 — `79e581ec04a4c5dc3817bfadb5ebd20fd76d3bf6`

### Add location dictionary key

**Author:** SeppeOngena


## 2026-08-03 — `8c0feb4ecf0bf230144bf99b6ba00e8aa639c92f`

### Fix toccolor error when hyperref is not loaded

**Author:** SeppeOngena


## 2026-08-03 — `4423839d88b1243d9cc0d25cd044168922aabb93`

### Add zip to release workflow

**Author:** SeppeOngena


## 2026-08-03 — `be34785891d1f3629749f8042b0fe8a1edeb0276`

### Move zip install into TeXLive runner

**Author:** SeppeOngena


## 2026-08-03 — `c7a793483631fa0ad298d1b529e96128a63828bc`

### Add fontspec and UGent Panno Text notice to readme

**Author:** SeppeOngena


## 2026-08-03 — `0563960d5e25a6173ae38e5dcd9e0a01e2f01126`

### Update release workflow to use apk for zip installation

**Author:** SeppeOngena


## 2026-08-04 — `95be35d76ed148082af52aaa2143068f3526bb43`

### Improve README

**Author:** SeppeOngena


## 2026-08-04 — `b66d2dbac38ea9e4803566a23e7d996fb9b78ee6`

### Change report chaptitles and header/footers to thesis version

**Author:** SeppeOngena


## 2026-08-04 — `bcb694b1a6e513e63a5260817dfe4dab9830e820`

### Allow empty faculty

**Author:** SeppeOngena


## 2026-08-04 — `078e8fcb304f549b987c798fd665d6a45331b885`

### Add iflecturersempty and ifauthorsempty command

**Author:** SeppeOngena


## 2026-08-05 — `6728cedd63728a9b9f399e2da21583b039bddf06`

### Fix empty faculty option

**Author:** SeppeOngena


## 2026-08-05 — `e9e3e0a13586221a9952bb3e1c2ff708b19554d9`

### Implement GUGC and campus Kortrijk logos

**Author:** SeppeOngena

Selected using \campus{gugc} or \campus{kortrijk}

## 2026-08-05 — `f61bdc7ec5b2acd1b9aaf2b4ff33700e17687df7`

### Adjust dissertation cover to grid layout

**Author:** SeppeOngena


## 2026-08-05 — `73ecac95765f25b94bc9eefe69bbe3fe252c1a61`

### Merged copyrightnotices, added extranotices command

**Author:** SeppeOngena

Removed \@crnotice, unified copyright layout. All copyright notices are overrideable, extranotices adds additional notices inside the default copyrightnotices of the course and exam classes

## 2026-08-05 — `4202c6cfbcb02d2f1a558a0b650805a11108cb81`

### Update package copyright notices

**Author:** SeppeOngena


## 2026-08-05 — `bad81b4c2b6cf032cecec17a3c40e6b39e9fcb8b`

### Adjust report shared code

**Author:** SeppeOngena

Added: coverbg, lecturers, location,  academicyear, email, phone, mobile, studentnr,
Removed: titlepageimage

## 2026-08-05 — `3b92c912d84e9c0ce0e3b3e5176b64df4c29b376`

### Implement report cover page

**Author:** SeppeOngena


## 2026-08-05 — `497d59896b64016f6ef0c0a8b67e733bd87eb301`

### Fix thesis hyperref color on titlepage

**Author:** SeppeOngena

When coverbg was enabled, a dark blue link could occur on a dark blue background

## 2026-08-05 — `d6b8b3bb124f59d79d50f9a8be6fdf73a028e1f4`

### Expand lecturer functionality similar to author

**Author:** SeppeOngena


## 2026-08-05 — `904dd1d561c7fdb4137df524f80e05ee8b47871f`

### Allow empty address for report

**Author:** SeppeOngena


## 2026-08-05 — `7a9dfdecaffd0da093d677ec0ac4b09284bac5c8`

### Update report examples

**Author:** SeppeOngena


## 2026-08-05 — `6613e25f9f8de12560736ed7f0f6bc34a76ac18d`

### Fix package compilation

**Author:** SeppeOngena


## 2026-08-05 — `2f0d3c504de31843534519c37ebbc34cb71913ef`

### Update readme for v0.3.0 - report

**Author:** SeppeOngena

Updated class statuses and added details for 'ugentreport'. Improved feature descriptions and added example images.
## 2026-08-05 — `8e3a29781fc4c13cd207975028557959e9efb1c6`

### Better handle empty faculty

**Author:** SeppeOngena


## 2026-08-05 — `ef84a9d4f464fb0cdd03bf8eb8fd0f8a6b8947ba`

### Separate ugentbookcover from ugentdissertation

**Author:** SeppeOngena


## 2026-08-05 — `1e43fb0a91dc508c111c8c8730ebd317733f5c3c`

### Adjust documentation

**Author:** SeppeOngena


## 2026-08-05 — `863363b614ba08e031b4123e261c3b8cfa4b1c86`

### Adjust & unify macrocode indentation

**Author:** SeppeOngena


## 2026-08-05 — `63264798c1773ed185c49e971e00d3c0c5c6847c`

### Adjust course shared code

**Author:** SeppeOngena

Add bare option, isbn, companylogo, publisherlogo

## 2026-08-05 — `0105ff302633c93e40cddd0d9bb0a97783ce4958`

### Adjust course titles

**Author:** SeppeOngena


## 2026-08-05 — `82f46c6a8fbbc92bfe79e92de84e9ff8ecfd9063`

### Restructure and merge covers and title pages

**Author:** SeppeOngena


## 2026-08-07 — `babf64e123910afc44e5d36aae4d08b6ba97cc7e`

### Update command naming conventions

**Author:** SeppeOngena


## 2026-08-07 — `d361a50bcbadd0c905dc76d7800a7adfd6daae87`

### Implement faculty and ugent icon for separate printing

**Author:** SeppeOngena


## 2026-08-07 — `acc5c778485a6b5b80939694ae569de071c8d8b0`

### Fix ugent@accent for rgb

**Author:** SeppeOngena


## 2026-08-07 — `549dedfb0bae75ee228f416c9d8c03ad7e499f32`

### Set cover top strip height to 0 for empty faculty

**Author:** SeppeOngena


## 2026-08-07 — `cd8e2d25249166ffc77cf37805abdd5bf8285987`

### Remove ISBN placeholder

**Author:** SeppeOngena


## 2026-08-07 — `e3618bd44fbf35c7dc7f0357788e7a53aa073419`

### Refactor cover body for thesis, report, and dissertation

**Author:** SeppeOngena


## 2026-08-07 — `3005529477703c6e692c6db01bb809bfd9fb88b7`

### Implement faculty icon for course cover

**Author:** SeppeOngena

Used when no titlepageimage is set

## 2026-08-07 — `55297dcd2733640e466ce17b7f393e828473070d`

### Implement course cover

**Author:** SeppeOngena


## 2026-08-07 — `9c4f38458e690a99035049fb7406614406fd76a3`

### Update dictionaries

**Author:** SeppeOngena

Change "the" key to the-de and the-het keys
Added version, package, typeset keys

## 2026-08-07 — `78b12b06bd4ec294d27352a2fca758b5eb196eeb`

### Implement course copyrightnotices

**Author:** SeppeOngena


## 2026-08-07 — `6d805bde0ac70fdffe197916cb7b19c821327c03`

### Add neutralcolors support for course

**Author:** SeppeOngena


## 2026-08-07 — `f0ea2fe79a76f648c2a11e6e9e79200f038d99cd`

### Renamed companylogo and publisherlogo to frontcoverlogos and backcoverlogos

**Author:** SeppeOngena


## 2026-08-07 — `3364483a44345d5ec4ada9ba8b83dc8deba5c86d`

### Remove cameraready option from course

**Author:** SeppeOngena


## 2026-08-07 — `b72de2b8cd4f84f14260172c7d28bd0c14cdf849`

### Force A4 for non-letter/dissertation classes

**Author:** SeppeOngena


## 2026-08-07 — `e3b3f00ddee9ca29f75f8bf32e516500291cd01e`

### Updated examples

**Author:** SeppeOngena

- Updated course example
- Updated options and font comments

## 2026-08-07 — `d91ac7835b98f1af8d67dedd9f2a9955875a1c6e`

### Removed course modern option

**Author:** SeppeOngena


## 2026-08-07 — `85048b56693018b1159cb986e7c14a4bc1fdec90`

### Merge degree commands

**Author:** SeppeOngena

All classes now support multi-degree.

## 2026-08-07 — `4d09aa21245ac11932bb2dd78c30730384bded9d`

### Add frontcoverlogos support for dissertation and course

**Author:** SeppeOngena


## 2026-08-07 — `b1f5edd481f733b818becd1eef59f00bcd6d435a`

### Fix dutch ugentbookcovers

**Author:** SeppeOngena


## 2026-08-07 — `10b8fd89e6f76f7c641979557e27ed7c4ff8e07e`

### Fix colouring of covers

**Author:** SeppeOngena


## 2026-08-07 — `04af542e75675cdb60789a6f5f4e7a43cd1da5bb`

### Update dissertation covers font size

**Author:** SeppeOngena


## 2026-08-07 — `45da1b2ec8834c9811bc82cf6c35ca553d70fd4a`

### Fix spine title height of covers

**Author:** SeppeOngena


## 2026-08-07 — `273777a742c8348e7be03901430e9239ddb2a521`

### Support course generatebookcover

**Author:** SeppeOngena


## 2026-08-07 — `28eff6b672978e5a4c7e3f4e841b05f2fd20d127`

### Added Academia Press logo for course example

**Author:** SeppeOngena


## 2026-08-07 — `1529a9a7e9eb6ff9258539f9d17d3a1bb4feb576`

### Added course showcase

**Author:** SeppeOngena


## 2026-08-08 — `aa31a7c0d636cd35f2e4cc03f2484d6a26abef32`

### Finetune cover title font size

**Author:** SeppeOngena


## 2026-08-08 — `14c4597f3f604850739b943d7ba63f1218275b9a`

### Fix manual date override

**Author:** SeppeOngena


## 2026-08-08 — `a910b524bb9126f4be04836b5e785044e2f87b9e`

### Fix course coverpage rendering and generatebookcover

**Author:** SeppeOngena


## 2026-08-11 — `f6fe041fc8208a76548b132779fc421c37649611`

### Pass casing options to faculty

**Author:** SeppeOngena


## 2026-08-11 — `da6152b2a665d4209a64b4f482e63427a4246725`

### Potential fix for faculty logo text spacing

**Author:** SeppeOngena


## 2026-08-11 — `897c7ec257869efedf472eb1664b2c3d97a47519`

### Move page width, height, and gridunit to geometry section

**Author:** SeppeOngena


## 2026-08-11 — `aad6118809d052db111c75d6c2d0ff381e23ef24`

### Add page, appendix, ourref dictionary keys

**Author:** SeppeOngena


## 2026-08-11 — `04072f65e1fe3e01d211a4f74f76dddf67acabdc`

### Fix PP faculty dutch name

**Author:** SeppeOngena


## 2026-08-11 — `32868bbe0b467357d8edb6dbd5613217cb4aca07`

### Remove unused commands

**Author:** SeppeOngena


## 2026-08-11 — `b8efe7f11ef9bc6499b44ffe12be56bf4bbfaeb7`

### Changed unused department command to a faculty override

**Author:** SeppeOngena


## 2026-08-11 — `0883f100fb398fa0605e5412196f0a0ac3a0421e`

### Add \reference command for letter class

**Author:** SeppeOngena


## 2026-08-11 — `c5eb2b6f79daa4cc96385f9e7adb4aaaa3479645`

### Update letter class to UGent style

**Author:** SeppeOngena


## 2026-08-11 — `2d7914f3a9707fcd608b6781504cee2d354ce5ed`

### Update letter example

**Author:** SeppeOngena


## 2026-08-11 — `ae5e829775f3de724f4c8994233e8cfb4dc3e460`

### Move all class options to LaTeX3

**Author:** SeppeOngena


## 2026-08-11 — `7a63e7e563d467b992862ddadcd768ccf7b966f6`

### Fix incorrect page height and page width keys

**Author:** SeppeOngena

During str replace, they were wrongly replaced to \\PH

## 2026-08-11 — `b3ed78dafaa999690c830902e799b3335a8c96c2`

### Fix bookcover paper size

**Author:** SeppeOngena


## 2026-08-11 — `60b8dc1cbea1e6329de8f812eb9462e4fea8cb04`

### Move campus from command to class options

**Author:** SeppeOngena


## 2026-08-11 — `8a5f2a39701ad74eb710615bd1fc202e1f6a3f2c`

### Fix issue where backmatter is called before appendix

**Author:** SeppeOngena


## 2026-08-11 — `68982049311db6bf0ea069ac57a0abdc7cedf8c9`

### Fix facultyacronym casing

**Author:** SeppeOngena


## 2026-08-11 — `711123434299ed7b222287a67e3abc473f3c278a`

### Fix course footer for empty faculty

**Author:** SeppeOngena


## 2026-08-11 — `fb89560b6554b6ddf881a96ed9ba487a94e39cdb`

### Add thumbs support for course and dissertation

**Author:** SeppeOngena


## 2026-08-11 — `596b074793a562792de298a909336e1e7c6df1a2`

### Fix crop - thumbs compatibility

**Author:** SeppeOngena


## 2026-08-11 — `723821f83def1e639b9240b0242a188fbf1aa22c`

### Remove additional clearpage for report class

**Author:** SeppeOngena


## 2026-08-11 — `b866b3b8901064662aefa5fe45a90e895e32c3bd`

### Updated README for ugentletter

**Author:** SeppeOngena


## 2026-08-11 — `6dc848d8d2b78656981e9ae74eb2b30c28713be3`

### fix(L3): Fix LaTeX3 declarations

**Author:** SeppeOngena


## 2026-08-12 — `4e155bcc21fe0f3445c7925512b3a7851b19bbe7`

### refactor(general): Public ficon, ugenticon, faclogo, ugentlogo

**Author:** SeppeOngena


## 2026-08-12 — `6877f5abea89b62c6e7b29273c16519e76a177ad`

### fix(general): Fix language switch handling of faclogo

**Author:** SeppeOngena


## 2026-08-12 — `167733432d639b4f9feeeb340d8371fea11b28d4`

### refactor(general): Update colour naming

**Author:** SeppeOngena

Renamed maincolor to ugent@faculty, removed sidecolor, replaced basecolor with ugent@faculty!10

## 2026-08-12 — `6fbaa121f3b339136262fd231093fcfc1d9b933c`

### build(packages): Pass common packages to beamer

**Author:** SeppeOngena


## 2026-08-12 — `7c529e088974a2c52bc1b1332ca8169c29c73755`

### feat(beamer): Pass default UGent Panno to beamer

**Author:** SeppeOngena


## 2026-08-12 — `31737b4756493b6dcf123b6f1f493bd73a73a4b7`

### feat(beamer): Enable dictionaries for beamer

**Author:** SeppeOngena


## 2026-08-12 — `688e5450c58c48260d30c6402f1bc0d3c30b1b21`

### fix(dictionaries): Fix translatekey handling of foreignlanguage

**Author:** SeppeOngena


## 2026-08-12 — `43fc5349f7522e7cfbfd2d83aaba7614806146f4`

### fix(general): Fix title, subtitle, and location use in examples

**Author:** SeppeOngena


## 2026-08-12 — `eba23df0c5147968c84c8046bbe7377fe5290b82`

### chore(general): Compressed oehoe example image

**Author:** SeppeOngena


## 2026-08-12 — `a08e8c385c65c6fc664ffde15e2d7023d77ca531`

### fix(phd): Fix confidential print of bwbookcover

**Author:** SeppeOngena


## 2026-08-14 — `63e3f90fdf173040116c40a231af1395e10c49e5`

### refactor(phd,bama)!: Changed dissertation class to phd and thesis class to bama

**Author:** SeppeOngena

BREAKING CHANGE: Originally it was "ugentphdthesis" and "ugentbamathesis" (or uantwerpen) but this was messy. Due to the ambiguity of the terms (UK: dissertation=bama, thesis=phd, US: dissertation=phd, thesis=bama, UGent: dissertation=phd&bama), the terms were dropped altogether and just used "phd" and "bama".
Replaced "thesis" usage in text with "dissertation" for compliance with the UGent lexicon

## 2026-08-14 — `8413a9993a0fa7b75c0650f88a17a530f2814911`

### docs: Updated documentation

**Author:** SeppeOngena

-Replaced leftover "coursetext" with "course"
- Removed discontinued commands and changes
- Changed bamathesis and phdthesis to bama and phd

## 2026-08-14 — `4d93fb49ee47d5439cff720c818db2842cae6ac6`

### refactor(general): Use setsansfont instead of setmainfont

**Author:** SeppeOngena

The familydefault is set to sfdefault

## 2026-08-14 — `de5475513e036eba64b054d8e4408e38bc0c5766`

### refactor(general): Improved font handling of UGent logo

**Author:** SeppeOngena

Fixes baselineskip issues

## 2026-08-14 — `86be59e566392df9a1ef185fc502901700eeb612`

### docs(beamer): add office template documentation note

**Author:** SeppeOngena


## 2026-08-14 — `160c7c47760402b15fdb1fc42620c65ff64a6683`

### refactor(beamer): updated geometry

**Author:** SeppeOngena

- Adjusted default aspect ration to 16:9
- Passed PW and PH, set gridunit and bottom and top strip heights
- Adjusted text margins to 2 gridunits

## 2026-08-14 — `b465444dcefa2e97eddd2d455c41d48dce4fe3e7`

### refactor(beamer): removed legacy slide & copyright

**Author:** SeppeOngena


## 2026-08-14 — `3d797ca47feb14d800b0b3bde6fe1ee7d9d4550d`

### docs: Update README for class name changes and relation to other packages

**Author:** SeppeOngena


## 2026-08-14 — `f33aaf714b2317719e840950335f996d959e9b14`

### chore(copyright): Update copyright notice with correct attribution

**Author:** SeppeOngena


## 2026-08-14 — `3da6bf72404a09c8911d7bd919a885f082683c69`

### docs: Updated documentation thanks section

**Author:** SeppeOngena


## 2026-08-14 — `17555cc6c55485ad4ad7d58a84dc4db5a8da6e14`

### chore(license): Add LaTeX Project Public License version 1.3c

**Author:** SeppeOngena


## 2026-08-14 — `d0db7bd0dfbd5ec2a144b753146aaf85b30fc1f7`

### build: Auto-generate changelog from commit history

**Author:** SeppeOngena


## 2026-08-14 — `93aabba2a97154d2ead6164b3684c62c4f131e98`

### chore(copyright): Link to original uantwerpendocs package in copyright notice

**Author:** SeppeOngena


## 2026-08-14 — `3481e8d5fa9e35c52e45658587c156e7e7d5e89a`

### chore(copyright): Add CHANGELOG.md notice to copyright notice

**Author:** SeppeOngena


## 2026-08-14 — `0a36be45917935c75b2cd2d640931aad931d9fa2`

### refactor(exam): Refactored exam's extrainfo command to L3

**Author:** SeppeOngena


## 2026-08-14 — `6e41ef6f716ba7ede2558076465796732a7df15a`

### chore(packages): Removed xstring, xparse, and ifthen packages

**Author:** SeppeOngena


## 2026-08-15 — `fe5d7d670b7f09ebbfb579462e43a6fc926089ca`

### build: Skip TMP folder for test builds

**Author:** SeppeOngena


## 2026-08-15 — `fb381be9614944ab3ad1367eaf1cc6e7264745ac`

### docs: Update docs introduction

**Author:** SeppeOngena


## 2026-08-15 — `f32d2d82549602f151d9135d75d6053c66483e94`

### docs: Added customization note

**Author:** SeppeOngena


## 2026-08-15 — `e9d28ef498a5bcc180b7e7c58a9edf8e472293d7`

### docs: Add specific code adaptation notes

**Author:** SeppeOngena


## 2026-08-15 — `4b95f466585b750d945d807c8b19307e66c94d8d`

### docs: Small fixes

**Author:** SeppeOngena

- Renamed some theses usage to dissertations
- Removed two-sided theses notes in examples
- Moved LaTeX3 message to code block
- Added fonts section label for cross-referencing

## 2026-08-15 — `88ad62964f7ae19dcb52c68bb8572ae05dfb6521`

### docs: Move examples to end of Part I in documentation

**Author:** SeppeOngena


## 2026-08-15 — `7b724281a3beed58bf24248225b104ec45ffeac3`

### docs: Make verbatim tiny and other adjustments

**Author:** SeppeOngena

- Very long examples took up tons of pages, no need as they're generally copy-pasted anyways into a .tex file (otherwise might as well exclude them).
- Changed referemces section title to cross-references
- Fixed examples section depth

## 2026-08-15 — `e47f26a78b2010d1b54a72248eeedaa2ec60d4c0`

### docs: Moved documentation sections around

**Author:** SeppeOngena

- Move color (col) before common options (clo)
- Integrate orphan grey colors into col
- Move package list doc to package loading code
- Changed \command to \txtcmd for truetype inline command rendering

## 2026-08-15 — `4fa9379d40dc0de6974c170ae8437ac1c8f2948f`

### docs: Add dtxdescribe, tikz, and hyphenat package for docs

**Author:** SeppeOngena


## 2026-08-15 — `38b7899c832becac0a895b860bdc5c29117b2287`

### refactor(general): Moved code into clo

**Author:** SeppeOngena

- Language, campus, and name format class options
- Name formatting code (firstname, surname, firstnameinitial etc.)
- Dictionary handling code

## 2026-08-15 — `7658f5cda4d938e6bfcec686c197eb3d8530a0e9`

### build(packages): Add expl3 package to beamer

**Author:** SeppeOngena


## 2026-08-15 — `c674ba9178420df837becbfd5d7500234e4afd83`

### refactor(beamer): Move ugentcommon and ugentcolor up for beamer

**Author:** SeppeOngena


## 2026-08-15 — `0f318134c5548c872232db7565295094931d55e7`

### docs: Use ugentcommon and ugentcolor packages for documentation

**Author:** SeppeOngena


## 2026-08-15 — `c2413ed3657add128b7dcb8245d826bd33a7af3e`

### docs: Use regular part instead of part*

**Author:** SeppeOngena


## 2026-08-15 — `7631ba2910e1a28d9de12a17a8128b85310aacaa`

### docs: Add watchouts

**Author:** SeppeOngena

- Using the dtxdescribe package
- Adds a warning triangle so critical requirements are more clear

## 2026-08-15 — `11e1f680776a56c32446feb1415bef374556bc25`

### refactor(general): Colour restructure and documentation

**Author:** SeppeOngena

- Moved colour and common options code inbetween documentation
- Added detailed colour documentation, including example swatches
- Moved coverbg_bool and covertype_tl declaration into ugentcommon
- Moved cover colours into ugentcolor
- Added spinecolor

## 2026-08-15 — `58946f15db8725cb6a46f26141d30782f6b97eab`

### docs: Added Part I documentation introduction

**Author:** SeppeOngena


## 2026-08-15 — `6bcf293f24ad8db6784c1010b1c42da45bc3958f`

### refactor(general): Moved ugentcommon loading to beginning of classes

**Author:** SeppeOngena


## 2026-08-15 — `bad81658bf4d324206d50ec199ab27d2000ef5ff`

### refactor(course,report): Changed course and report watermarks to use watermarkcolor

**Author:** SeppeOngena


## 2026-08-15 — `e48dd417b63b2efa97301641c27c6371c563fa5b`

### refactor(phd): Condensed and moved bwbookcover true checking

**Author:** SeppeOngena

Moved to after the ugentbookcover processing of the covertype key

## 2026-08-15 — `df63bec26ea9ab8da8dc027af5374939f83f7301`

### refactor(general): Added faculty and campus doc, cleaned up code

**Author:** SeppeOngena

- Move campus into ugentcommon
- Removed unknown campus message
- Added documentation for faculty and campus

## 2026-08-15 — `b21c80aad6f240c4239bb682a5573e3bb187a4b7`

### fix(general): Fix faclogo and ugentlogo bounding box

**Author:** SeppeOngena


## 2026-08-15 — `6a7c8ee79dfcf86b4ea3be96654493ded8262cec`

### fix(general): Fix ugenticon color not applying

**Author:** SeppeOngena


## 2026-08-16 — `0f6ac46bc4c58f668c581e266d830a39f62861b6`

### refactor(general): Move department macro into ugentcommon

**Author:** SeppeOngena


## 2026-08-16 — `283fd77dc45a6b9d59ed2cee73c84ac5b4dd825e`

### docs: Add dutch translations to faculty table

**Author:** SeppeOngena


## 2026-08-16 — `bcb877ba105722b662823b997e4ddb54c1d8e277`

### docs: Add GUGC logo example

**Author:** SeppeOngena


## 2026-08-16 — `13c3b5a05b388b748a3b5da38d27d70c10baf678`

### docs: Moved dictionary code up in the docs

**Author:** SeppeOngena


## 2026-08-16 — `fa4ca3e40f99aa7f0bd174a0a9b2fefe0516e135`

### docs: Moved macro documentation down towards macro code

**Author:** SeppeOngena


## 2026-08-16 — `b1a4f3e99eead97a35b166f00f4f917f0d6e8be4`

### docs: Moved name parsing to "people" section

**Author:** SeppeOngena


## 2026-08-16 — `060313ab7a27e0466b85b392622387c04d72c235`

### docs: Updated dictionaries documentation

**Author:** SeppeOngena


## 2026-08-16 — `e69c1d6746c60bac6d0d7678059fca6a9fd6937b`

### refactor(dictionaries): Renamed dictionary docstrip blocks

**Author:** SeppeOngena


## 2026-08-16 — `ff017a441c29d6f28e8130f30de3b44269646b09`

### docs: Moved language class option to language section

**Author:** SeppeOngena


## 2026-08-16 — `19beb04f1c840ec9769b0a6d28402f15dc59b549`

### docs: Fix dtxdescribe categories not printing

**Author:** SeppeOngena


## 2026-08-16 — `228c1c6ffab25d038b00f33ee14f2ef1295b2e90`

### refactor(phd): Convert if bwbookcover to L3

**Author:** SeppeOngena


## 2026-08-16 — `caf4c37bcbb951b00f5caeb52f658afd4ebaa23f`

### docs: Update class options documentation

**Author:** SeppeOngena


## 2026-08-16 — `2ea76e588e178c357e2a50d4981aa7bfa5738d37`

### docs: Adjust class options documentation intro

**Author:** SeppeOngena


## 2026-08-16 — `979cf89f0e67704f02f3e8e96a5b0fbf2ad5390c`

### refactor(fonts): Update default fonts and documentation

**Author:** SeppeOngena

- If neither Arial nor UGent Panno Text are installed, a warning is given. This should never happen though, since the UGent Panno Text Medium and SemiLight variants are needed anyways and the Normal face would be installed alongside normally.
- Default math font changed from  Fira Math to Noto Sans Math, as it has more glyphs and is closer in style to UGent Panno Text
- Changed math fallback font from the sansmath package to TeX Gyre DejaVu Math, which should be installed alongside LaTeX normally.
- Moved font code into ugentcommon, loaded per class using the loadfonts internal command

## 2026-08-16 — `847cc2e6f1dd94d057635f9e30c40d1ce0fc937d`

### docs: Finish class options documentation section

**Author:** SeppeOngena


## 2026-08-16 — `c1e7607be28e975928ab923242a03f39ed4b7b32`

### docs: Add support for docs code copy-pasting while retaining line numbers

**Author:** SeppeOngena


## 2026-08-16 — `8769249c48fd995245b2f1680f54c42f6ef2142a`

### docs: Expanded docs colour customization note

**Author:** SeppeOngena


## 2026-08-16 — `b0cac09bc6785ae66663a7737a7c4a984e3823b6`

### docs: Added missing thumbs option description

**Author:** SeppeOngena


## 2026-08-16 — `237f8d8895dda94123237de0a1b0caf26ace7b31`

### docs: updated package section

**Author:** SeppeOngena


## 2026-08-16 — `0f4d881e08f3cf9af62722f4514f1e93601c6dbf`

### docs: Update geometry section

**Author:** SeppeOngena


## 2026-08-16 — `5080272b21e6494d45c0e8eb32a49e5fb4b2dbf0`

### docs: Fix docstrip blocks

**Author:** SeppeOngena


## 2026-08-16 — `06d317c30e92d29715100c5252eac1e3bbd225d2`

### docs: Updated macros section depth, added Style section

**Author:** SeppeOngena


## 2026-08-16 — `65482e24385ab8e316c82d8922ef578ca3c2a0d9`

### feat(general): Implemented general sequence parsing commands

**Author:** SeppeOngena

- \printseq{seqname}{}{}{}, prints a sequence using the three L3 seq separators
- \ifseqempty{seqname}{truecode}{falsecode}, allows executing code based on sequence emptyness
- \getseqcaption[casing options]{seqname}, gets the translated key from a plural sequence such as authors.
- Also moved name parsing option into the Name and sequence parsing section of the docs

## 2026-08-16 — `f3ebe19e355d3acd1db52c5c3523c83836d8d571`

### refactor(general): Remove unused author affiliations seq

**Author:** SeppeOngena


## 2026-08-16 — `beb9891bdbe0ed32878b0bd739bc88b0d572d4f6`

### feat(dictionaries): add allsupervisors keys

**Author:** SeppeOngena


## 2026-08-16 — `875ce53bc722f59bcd4c72dacc6b3b1a681b20fd`

### refactor(general): Convert all sequences to use generalized print commands

**Author:** SeppeOngena

- Generalized print commands
= printseq, ifseqempty, and getseqcaption
- Converted authors, lecturers, supervisors, cosupervisors, extsupervisors, tutors, jurymembers, degrees, courses, emails, phones, faxes, mobiles, and rooms,

## 2026-08-16 — `5e052e58d58f2e376bc35015c3f477a971f0a401`

### refactor(exam): Change exam course from tag to sequence

**Author:** SeppeOngena

Allows multi-course exams, but more importantly, allows code cleanup

## 2026-08-16 — `4fee80800ad6cca3f92a3175484b0c3434d7822c`

### fix(exam,report,bama): Fix using examiner and coverbg option keys without value

**Author:** SeppeOngena


## 2026-08-16 — `57c9080f9c909e454fb0d2663c1bfbc314db1bfc`

### refactor(general): Updated faculty, department, and unit macros

**Author:** SeppeOngena

- Changed name of the department macro overriding the faculty tag to faculty
- Added department macro and tag, with casing support
- Moved unit macro and tag into ugentcommon
- unit now supports casing

## 2026-08-16 — `64450e2ad9697f9f61e60637004c942900df6cd6`

### refactor(phd,bookcover,bama): Refactor embargotemp and embargofull to L3 embargo

**Author:** SeppeOngena


## 2026-08-16 — `7c96f002a97241795428e42f2d66b0fcc3e4c907`

### ci(workflows): Update release workflow for manual builds

**Author:** SeppeOngena


## 2026-08-16 — `fd5437391bc27a0f1a53de389effccd3a0e2cc4b`

### feat(general): Add insetboxcolor to customize insettext and insetquote color

**Author:** SeppeOngena


## 2026-08-16 — `e3e15194b513b924802d9480beb3f4b6277c5502`

### docs: Updated insettext and insetquote documentation

**Author:** SeppeOngena

- Added examples
- Also improved the rendering of short quotes

## 2026-08-16 — `b2cf412afdf2f6c92541b8479692b5d6a0206018`

### build(fonts): Add Noto Sans Math and TeX Gyre DejaVu Math fonts

**Author:** SeppeOngena


## 2026-08-16 — `599c6a8f14766d4502ba50b440d2aa8c7ca5ff32`

### ci(workflows): Rename workflow from 'Release Build' to 'Build'

**Author:** SeppeOngena


## 2026-08-17 — `f58fb5e3a02e2177cbe9c66a05746d7ca6e7ad6a`

### fix(beamer): Fix beamer template compilation

**Author:** SeppeOngena

- Changed maincolor to ugent@main
- Changed basecolor to ugent@faculty
- Changed sidecolor to ugent@accent

## 2026-08-17 — `bba944a157f7a4d596e9cc3e4d0ca3616033f8a2`

### ci(workflows): Mark repo safe for changelog.md compilation

**Author:** SeppeOngena


## 2026-08-17 — `9c89fe47f18d5dd5655b24d3348a3aa967b3b869`

### ci(workflows): Set release workflow fetch depth to 0

**Author:** SeppeOngena

Allows fetching uantwerpendocs-4.12-code tag

## 2026-08-17 — `904bbc3f49aa9f73785c63f7de550268945041d6`

### chore(copyright): Add Joris Meys to copyright notice

**Author:** SeppeOngena


## 2026-08-17 — `ca3140a6c9e261916d38317b99ff70c125814024`

### docs: Added how to read documentation note

**Author:** SeppeOngena


## 2026-08-17 — `b951231425b3a71a6d736e44526d6d458eb0e231`

### docs: merged macro description and tags code

**Author:** SeppeOngena

- Also shifted some stuff around and created a bit more structure

## 2026-08-17 — `8df561e1bed688f9e0a4756ab4648f1187353c44`

### fix(phd): Fix empty subtitle support for PhD

**Author:** SeppeOngena


## 2026-08-17 — `d34e2e46e866d4ff91d0c771087c4bf35fe26b93`

### refactor(general): Override native title macro with shorttitle support

**Author:** SeppeOngena

- Also added placeholder title

## 2026-08-17 — `6232f6c611f450b42b92fc91e2b693fcc4e7de44`

### feat(general): Added placeholder dutch title

**Author:** SeppeOngena


## 2026-08-17 — `b6984cb2e6fd192847658c9ea058cb7a2ef7b47d`

### refactor(general): Reworked subtitle to L3, changed name of short subtitle

**Author:** SeppeOngena

Changed from subtitleshort to shortsubtitle

## 2026-08-17 — `73b0b96e4f9738bf06a2bcaf33273d293d0f88df`

### docs: Update docs date to ISO standard

**Author:** SeppeOngena


## 2026-08-17 — `bbec2e01f4f2bd920dc67e953c3c9b3a24ac7c3a`

### feat(general): Added localizedates option and time and location doc section

**Author:** SeppeOngena

- localizedates uses datetime2 under the hood when setting the \date or embargo start and end dates
- If false, it outputs ISO format if the date input was ISO format.
- If true, it outputs localized dates using babel for translation.
- If no ISO format was input, the date is just passed verbatim.

## 2026-08-17 — `b3efd0e3a9576b92a09b412787213c35745c859e`

### fix(bama): Fixed newlines of supervisors on bama cover page

**Author:** SeppeOngena


## 2026-08-17 — `ac8c8332a09408cb36fba3cb9d32dd4546f0526e`

### fix(letter): Fix location command compat with letter

**Author:** SeppeOngena


## 2026-08-17 — `a9896c67f72f7fbbf38c621e87f305cb940ed6ba`

### docs: add mandatory and tag margin text note

**Author:** SeppeOngena


## 2026-08-17 — `0dded01149905461c9066c6a76245d0ea03fc14c`

### style(cleanup): General cleanup

**Author:** SeppeOngena

- Removed trailing spaces after docstrip guards
- Fix indentation of verbatim
- Add tag margin notes
- Some newpages here and there

## 2026-08-17 — `fac57cc2aa7fd0f8822c38317586d550bbb03db9`

### refactor(general)!: Rename titlepageimage to coverimage

**Author:** SeppeOngena


## 2026-08-17 — `132a2eece15c4f24b8249d8def666df6d8479550`

### fix(report): Fix emptying of academicyear for report class

**Author:** SeppeOngena


## 2026-08-17 — `ad02fb9662e1dfd60a0090f866fb912d92e06cbe`

### fix(letter): Fix bracing mistake in location letter compat fix

**Author:** SeppeOngena


## 2026-08-17 — `231fe6930f346503cdac2537a90bbbeb22d989b9`

### docs: Shortened all classes in Describe use

**Author:** SeppeOngena


## 2026-08-17 — `4bef853c2d05abe24ff4fa4a7ac517e48d020666`

### docs: Added seq:seqname margintag note

**Author:** SeppeOngena


## 2026-08-17 — `6eb0816b20e5125623e4598acd0626c8d49f7c84`

### feat(phd,bookcover): Add doctype support for phd, remove for exam and course

**Author:** SeppeOngena

- doctype is now used in cover page, title page, and colophon.
- passed also to bookcover with generatebookcover

## 2026-08-17 — `7c931c6fb76ff260c4d4bb4a9040625d10d4dd17`

### fix(phd): Fix DOI on phd colophone page when hyperref is not loaded

**Author:** SeppeOngena


## 2026-08-18 — `81def5baaa574435c0e0a09e2510f6a384e8321b`

### fix(bama): Fix clearpages issue when using includepdf for bama signatures

**Author:** SeppeOngena

Too many clearpages were added, moved clearpages into default \@copyrightnotices

## 2026-08-18 — `11e8c40c7226af8df4e2b20a655b2396b7278208`

### fix(course,report): Fixed LaTeX logo rendering in copyrightnotices

**Author:** SeppeOngena

- Forced roman font (still default Computer Modern)
- Also fixed a the-de translation key here that should have been the-het

## 2026-08-18 — `2c025d2846b6859545d16623fd60fd087868c5fa`

### docs: Various small changes

**Author:** SeppeOngena

- changed intro pages spacing (only intro on first page)
- rephrased "jury list" to "examination committee"
- rephrased "data page" to "colophon"
- added parent sections to (sub)subsection labels
- added note in the customization introduction section to replace double at with _ugentdocs for customization
- changed example extranotices to also use \textrm, just like the LaTeX logo.

## 2026-08-18 — `838c502ad81ef5e5dbe8f1ed5e4475f87402a3c7`

### docs: Update document data section

**Author:** SeppeOngena


## 2026-08-18 — `fb7b5d7c7af1571075c7315c15349bc2cc7ba9ce`

### docs: remove \txtcmd in favour of | |

**Author:** SeppeOngena

Not sure why I even added that command in the first place

## 2026-08-18 — `795c110a174f77322e68adc3a63f27016e0a0dee`

### refactor(general): Unified addition of people to sequences

**Author:** SeppeOngena

-they all use generic helpers now, e.g. addto_nameaffiliation{authors}{title}{name}{affiliation}, which unifies formatting
- Affiliation separator (e.g. ', ' is no longer forced), which fixes a bug where \author{}{Name}{\\ text} was used.
- renamed authorcalls and lecturercalls sequences to authorscalls and lecturerscalls

## 2026-08-18 — `cc5946fb1b23aa4345abc2a5c4980d5b2148b640`

### feat(bama,report): Add bama and report support for horizontal aligned authors and affil on cover page

**Author:** SeppeOngena

If affiliation contains a &, this will be horizontally aligned.
Can be used for student number alignment

## 2026-08-18 — `d01f3f434b51b05246b35a4dd089e7f1a27648e9`

### feat(course,bookcover): Add lecturer for course bookcover spine

**Author:** SeppeOngena

Takes precedence over authors

## 2026-08-18 — `90d8769be270d8bce80d450910da39c9a1e60098`

### refactor(general): Renamed withaffiliations sequences to waff

**Author:** SeppeOngena

- Also fixed supervisorscalls (was supervisorcalls)

## 2026-08-18 — `2b925db267b7da0b7886f276e1c80df263f5449c`

### docs: Updated people section

**Author:** SeppeOngena


## 2026-08-18 — `e15543b395a5caaca9e745e88d522061c4a4a7e4`

### docs: No longer display author code implementation

**Author:** SeppeOngena

It added no value and isn't customizable anyways

## 2026-08-19 — `9eeb500fe1833a9bceee4e0005493f77fea119cb`

### fix(L3): Added course and report embargo bool declaration

**Author:** SeppeOngena


## 2026-08-19 — `d239cb98ef647327ca46cfbe0b2e03eb020de712`

### refactor(phd,bookcover): Moved PhD cover confidentiality to top right corner

**Author:** SeppeOngena

- Makes place for frontcoverlogos of UGent style
- Hinders Arial overlap with long faculty logos for BW style. Color for BW style = covertitlecolor

## 2026-08-19 — `15bfcc2e41d8832bdb8bd4cf04a92805c878d5e2`

### style(cleanup):Remove trailing spaces

**Author:** SeppeOngena


## 2026-08-19 — `6e7f492a8f1647ecb165c933d639d198ea884597`

### docs: Update date macro description with usage

**Author:** SeppeOngena


## 2026-08-19 — `f353b9cd10fbb93bff249c572ab3e65e989948e2`

### style(L3): Add missing underscores to some control sequence helpers

**Author:** SeppeOngena


## 2026-08-19 — `e5228586a9be6a149ff36e38c1bcac1562908ade`

### build(packages): Add GS1 package to course for ISBN generation

**Author:** SeppeOngena


## 2026-08-19 — `d3b87e36106fb62cbc3b5bda2bfb69f6674d71f6`

### feat(course): Added coverdesigner macro to course

**Author:** SeppeOngena


## 2026-08-19 — `2bdedc3dd3a2f144dc85ed0be40c3be02ecbd817`

### fix(general): Fixed placeholder title/shorttitle word spacing

**Author:** SeppeOngena


## 2026-08-19 — `3a0f9e7adc589d7e71885a9f42b60525f08136a5`

### fix(phd): Fixed jurychairaff still including hardcoded comma

**Author:** SeppeOngena


## 2026-08-19 — `85e0d497a5bbf7e68cc0a437a59c4410e9e59fec`

### fix(phd): Fix non-confidential PhD copyright error

**Author:** SeppeOngena


## 2026-08-19 — `2f3a8e60591740e94d2a0b3348262234d10b2de3`

### fix(bookcover): Fix passing of frontcoverlogos in generatebookcover

**Author:** SeppeOngena


## 2026-08-20 — `fcc868c5088b8799b88ca27e51823feaaf5f459d`

### refactor(exam)!: Removed examdate in favour of regular date

**Author:** SeppeOngena


## 2026-08-20 — `2b2e422a9fcf595cb3d283ecfdaa3b0e29292086`

### docs: Deduplicate preambles of the examples

**Author:** SeppeOngena

- Deduplicates code: no more adjusting every example if one thing changes, e.g., class options. Less lines of code to maintain.
- Brings more structure into the examples as well, following the Usage section order.
- Also updated examples here and there, adding missing showcases (it's easier to cross-reference the Usage explanation sections for completeness now also).

## 2026-08-20 — `df6edd3a9372f45193be8437aaf32eb36df09993`

### fix(bama,report): Fix studentnr newline not occurring on cover page

**Author:** SeppeOngena


## 2026-08-20 — `6b9755bc2048017eb730a7ca36a21692aa26db4e`

### refactor(phd): Changed justification of PhD title page to raggedright

**Author:** SeppeOngena


## 2026-08-20 — `3eabcba05fd0b553136c86647ca43cc01b3e65a2`

### docs: Fix isbn and coverdesigner in examples

**Author:** SeppeOngena

ISBN was not passed properly, and the makeatletter wrap was one level too deep
Also translated to extranotices to dutch as the examples are dutch

## 2026-08-20 — `a7a957b68d1a469945d9508ac5dcfc06a66d29b8`

### refactor(general): Email macro - emails_seq, default domain

**Author:** SeppeOngena

- Renamed emailaddresses_seq to emails_seq.
- Added the default domain from dictionary key. Domain is now an optional argument

## 2026-08-20 — `38080828295c4a52c81811961acc1849ee51701c`

### refactor(general): Renamed faxnumbers, mobilenumbers and phonenumbers seq to faxes, mobiles, and phones

**Author:** SeppeOngena


## 2026-08-20 — `6cc43f5f60bd8824f851deb9d0e0af2e882c1ef5`

### docs: Update contact macros section

**Author:** SeppeOngena


## 2026-08-20 — `c267f47d2e04aba4cca84b7f65a841516dc7be43`

### refactor(course,exam): Rename courseswithcodes seq to courseswcodes

**Author:** SeppeOngena


## 2026-08-20 — `5850158e7e7969633cd5f26f376deb8fcd59e9c0`

### fix(course): Fix empty courseversion support

**Author:** SeppeOngena


## 2026-08-20 — `bcd9ae90b6d9d995bad2a75972ba19166a6f99f0`

### docs: Update course macros section

**Author:** SeppeOngena


## 2026-08-20 — `115ce7e08efe7447a13e3523f06fe9a064aacf5a`

### refactor(exam)!: Rename examgroupnumber to examseries

**Author:** SeppeOngena


## 2026-08-20 — `6f9d580c0ba29d3ddea9e4f9559e61c0146c0492`

### fix(exam): Fix empty examseries support

**Author:** SeppeOngena


## 2026-08-20 — `af7e698178d8c640c3c159c0b749b7ca8585fcd4`

### refactor(exam)!: Renamed examlength, tstart and tend to examduration, examstart and examend

**Author:** SeppeOngena


## 2026-08-20 — `61f92dab8239f7210506083a7ab6bbb9f8760860`

### fix(exam): Fix empty room support

**Author:** SeppeOngena


## 2026-08-20 — `def622eab49d042f4d8e64088cf6cfc7c3c231b8`

### refactor(exam): Put exampart on cover page on newline

**Author:** SeppeOngena


## 2026-08-20 — `745d60feeb18c30a94ef23af2b08054784643182`

### refactor(exam)!: Merge question and questionweight macros

**Author:** SeppeOngena

Weight is specified via the optional weight= key.

## 2026-08-20 — `22907959b15544d397b8593eae713d83f88a8712`

### build(packages): Added package wasysym to requirements

**Author:** SeppeOngena


## 2026-08-20 — `c7c1db0d3433af6829aa98f13c2d7270ed0a55fa`

### fix(exam): Fix default multiple choice symbol

**Author:** SeppeOngena


## 2026-08-20 — `70e96c77f54cf0cb774ca07c1e2242345438359b`

### refactor(exam)!: Generalize engdut macro to bilingual, defaults english dutch

**Author:** SeppeOngena


## 2026-08-20 — `ea14a0a9d43e82e7b218943a7de8e0174980a9ad`

### refactor(exam)!: Removed bilingualmc, using nested mc & bilingual instead

**Author:** SeppeOngena


## 2026-08-20 — `a010b666b5a696bcf2ac05d370b533c8a582d93f`

### refactor(exam)!: Renamed setmcsymbol and mcsymbol to mcsymb

**Author:** SeppeOngena


## 2026-08-20 — `1d76c2c11cb0e64cf68c3057404945e3126b4715`

### fix(general): Fix phone macro compat with wasysym

**Author:** SeppeOngena


## 2026-08-21 — `5dfe776a084b900f650237afcea89575d70a415d`

### docs: Added separate NOTICE.md for GitHub

**Author:** SeppeOngena


## 2026-08-21 — `5058f73172fee66a12914f63ea47dcddbfe82f2d`

### docs: Update NOTICE.md spacing

**Author:** SeppeOngena


## 2026-08-21 — `09f88aa18bd57c312cdd2a450260065053dc1d2a`

### docs: Update notice link in README.md

**Author:** SeppeOngena


## 2026-08-21 — `36543e9017b5ba6e72dd71d1450a99abf73ce4c5`

### docs: Update copyright formatting in README.md

**Author:** SeppeOngena


## 2026-08-21 — `99e42e740fe087ef30f50fd2db75096e603c12eb`

### docs: Update exam section

**Author:** SeppeOngena


## 2026-08-21 — `92c3ff0cf583c15104d353a5ed3c899b4a4bd455`

### fix(beamer): Fix beamer class compilation

**Author:** SeppeOngena


## 2026-08-21 — `cab882a959cf8dbbe4c1c0590c3723a9e3ef811b`

### docs: Specify unfinished nature of exam and beamer examples

**Author:** SeppeOngena


## 2026-08-21 — `4bd0531aebf01a5cfb2e438b79561404b5624333`

### docs: Fix verbatim loading of example files from last commit

**Author:** SeppeOngena


## 2026-08-21 — `04043f57356af0f3456d07444e64981b2c646199`

### docs: Update letter macros section

**Author:** SeppeOngena


## 2026-08-22 — `455a5993c193d10ccb8b96750110aa87cf3913fa`

### docs: Update cross-references style section

**Author:** SeppeOngena


## 2026-08-22 — `ecdf1e1a5786d565be4a7706adc91ef949092d77`

### fix(general): Fix hyperref authorlist pdf metadata

**Author:** SeppeOngena

Multiple causes:
- \printseq not expandable -> added separate control sequence
- surname and firstnameinitial not expandable -> set resolved token lists when adding authors, not just the surname and firstnameinitial commands.
- Still issue: dutch andlist is "~en", this shows up in the author pdf metadata

## 2026-08-24 — `5bff41524ff0dd1a10bdb0175859cf8288024330`

### fix(general): Fix andlist dutch translation key

**Author:** SeppeOngena

Tilde was included in the output instead of a space, fixed by replacing the UTF character with a nobreakspace directly when loading in dictionary values using flush_value

## 2026-08-24 — `77ac3d52a82a98654f114317cb3fdbff4cba8347`

### refactor(general): Rename unit macro to team, siunitx compat

**Author:** SeppeOngena


## 2026-08-31 — `e1deecaced6a9f017d0132f84b295a59b070d31c`

### style(cleanup): Replace tabs with 2 spaces

**Author:** SeppeOngena


## 2026-08-31 — `39e48e858f07c5ce55c16b634c8776a0ccc17c39`

### refactor(general): Clean up deprecated fancyhdr code

**Author:** SeppeOngena

- Replaced e.g. lfoot, rhead etc with fancyfoot[L] and fancyhead[R]
- Replaced all empty declarations with a simple \fancyhf{}
- Removed unneeded clearing of headrule and footrule for letter class, as those headers are all empty anyways

## 2026-08-31 — `36e3347461385a8547d0a8d414a99378009bdbbe`

### docs: Move letterheader to header section

**Author:** SeppeOngena


## 2026-08-31 — `3e2fde681df2702fb1604fd8250daa791485dcac`

### fix(bama,report): Fix header footer styling not applying automatically for mainmatter and frontmatter

**Author:** SeppeOngena


## 2026-08-31 — `5751badb24bf91151e029bf13710c457465950b9`

### fix(bama,report): Fix appendix title style

**Author:** SeppeOngena

Was not yet merged from LaTeX at UGent
Made it so that it is automatically applied to the appendix, no user intervention needed

## 2026-09-01 — `4ccf7c653d225a142fcccf5f44d5beb64d151578`

### docs: Update header and footer style section

**Author:** SeppeOngena


## 2026-09-02 — `55affab73c8042baee04e1c96cb078f3699ac451`

### feat(bama,phd,course,report): New chapter styling, first version

**Author:** SeppeOngena

- added tikzpagenodes package
- addthumb is moved into the titlesec commands
- fixed an issue during style development where thumbs would not move down vertically. This fix is executed at the beginning of the document to allow customization modifying the addthumb command

5 main styles are available for all of the 4 documents, although no option is exposed and the defaults are set. They can be overridden though.
The styles are set in customization points chaptertitlestyle, sectiontitlestyle, and appendixtitlestyle. These are set at the beginning of the document (the setting of the appendix style is appended to the appendix command)

The styles are:
1. plain: bama and report style from LaTeX at UGent.  Still default for those classes.
2. fancy: a new style with a block containing the chapter label and number. The chap title is printed below, followed by a hrule below. Acts as an "expanded thumb" and thumbs are not shown on the chapter title page. Compatible with crop / cameraready. Default for phd.
3. fancycompact: same as fancy, but with the chapter title to the left of the block, and the hrule extending from the bottom left corner of the block
4: uantwerpen: the previous phd and course style from the uantwerpendocs package.
5: legacyplain: one of my old chapter styles, which is just a blue tab from the left of the page up to the chapter title, which includes a negative chapter number. Somehow this was already compatible with crop/cameraready.

## 2026-09-02 — `6fa365ee420abe80863da0fd47b50cddf0c4db84`

### fix(course): Fix chapter and section title word spacing

**Author:** SeppeOngena

An unnecessary and unclosed ExplSyntaxOn caused spaces in the whole document's chapter and section titles to be ignored

## 2026-09-11 — `05d33070baac4b568ad43933031b4d3e10919060`

### build: Support index

**Author:** SeppeOngena


## 2026-09-11 — `b1984cba33cf581f2cb503f8b82a3aa41de4c71d`

### docs: Added index

**Author:** SeppeOngena


## 2026-09-11 — `10a4a239157eb38ebd7f12767677667299355923`

### docs: Remove all remaining imacro

**Author:** SeppeOngena


## 2026-09-11 — `83def03562ddaef7184e41b5929c9999fafc02ce`

### fix(L3): Add missing authortable declaration

**Author:** SeppeOngena


## 2026-09-11 — `4f6d535b53d97253c23586833ab23feda452b73a`

### docs: Move Why another template to NOTICE.md

**Author:** SeppeOngena


## 2026-09-11 — `223d613b8f7d5ec44640501f88a85270f523b41f`

### docs: update README

**Author:** SeppeOngena


## 2026-09-11 — `62b1df44aca45206116a33080272c1d80e42e62e`

### docs: Add CONTRIBUTING.md

**Author:** SeppeOngena


## 2026-09-11 — `fc7a0b2dd4f9a1289d86c42d974ef293e773a970`

### docs: Add recommended packages section

**Author:** SeppeOngena


## 2026-09-11 — `69bc6f526b46403911e3086c1e9e46021b546c6c`

### fix(bama,report): Fix missing addthumb macro for new title styles

**Author:** SeppeOngena


## 2026-09-11 — `5009a0e13d2087a787bbdd48a2e80af9ddd179b8`

### docs: Add references note

**Author:** SeppeOngena


## 2026-09-11 — `dae62b5906d1c066c442107e90e8f8cad9dd18dd`

### docs: Add hrefs to recommended packages

**Author:** SeppeOngena


## 2026-09-12 — `83549cfb0c452f2d49067ed0ee5ee0418d274788`

### docs: Example deduplication pt. 2

**Author:** SeppeOngena


## 2026-09-12 — `aa275cba9b8427d8884a0298677fb0799f21871d`

### docs: Implement GenAI disclaimer for examples

**Author:** SeppeOngena

Based on Joris Meys' LaTeX at UGent

## 2026-09-12 — `b9f9615552e32fe2f7eaf33ba615303c701d7485`

### docs: Add LLM to CONTRIBUTING.md

**Author:** SeppeOngena


## 2026-09-12 — `d894825e6cacd88fdd7e33cb2290db60ffe793b0`

### fix: Fix biblatex compatibility with textsc implementation

**Author:** SeppeOngena

Change textsc override to fakesc

## 2026-09-12 — `5f13c3de35d2c27a6b7f53908896f3783cd91252`

### docs: Deduplicate examples final pt. 3

**Author:** SeppeOngena


## 2026-09-12 — `f76c56e055845dde12e1778694d033ad719d284e`

### docs: Add small LaTeX tutorial to examples

**Author:** SeppeOngena


## 2026-09-12 — `7be8ffd6e4c24f6b3bd1858a2f559d2285f937ac`

### build: run biber for examples

**Author:** SeppeOngena


## 2026-09-12 — `6b625957d10aa80f150d7cc10f649cbc0bf8fd6d`

### build: Additional pass for examples

**Author:** SeppeOngena

Chapter titles were not converging

## 2026-09-12 — `401483a2395e5012ba03a1709230df350338f082`

### refactor(course,phd): Fix space between new chapter title style and body text

**Author:** SeppeOngena


## 2026-09-12 — `07053a3442f0525500a9b540e921cdfce8e5867c`

### docs: Update chapter title style section

**Author:** SeppeOngena


## 2026-09-12 — `01de31d66491c6973e9a283b0b024adde260d144`

### docs: Move generatebookcover, maketitle, makefinalpage, makebookcover, closeletter to macros section

**Author:** SeppeOngena


## 2026-09-12 — `65535376277a67188b0c3c127fc57060cdd052e6`

### refactor(course): Added page count bare support

**Author:** SeppeOngena


## 2026-09-12 — `623e073d11fc19b8d30b5b139e710abae1f5c867`

### refactor(bama,report): Remove unused makefinalpage

**Author:** SeppeOngena


## 2026-09-12 — `7d0a2d8e6e280fe0eefa4818ac93b46d7130eb84`

### fix(letter): Fix team display in header

**Author:** SeppeOngena

New bug since v0.5.0

## 2026-09-12 — `fb12b8854c1f68eefada82457e74966f61018d4d`

### docs: Update making titles and covers section

**Author:** SeppeOngena


## 2026-09-12 — `781d5c34549857db078edcedb28f3aa728bcf058`

### docs: update bookcover components style section

**Author:** SeppeOngena


## 2026-09-12 — `b7892575291f108f1090c74cebed057645c885b9`

### docs: Update copyright notices style section

**Author:** SeppeOngena


## 2026-09-12 — `630fa589411d84079de5f6755c56259290e4081d`

### refactor(course,phd,bama,rp): Rework covers

**Author:** SeppeOngena

- Renamed bwbookcover_bool to bwphdcover_bool
- Updated documentation of covers
- Merged code where possible

## 2026-09-12 — `04421c037925ad1f7e1c4fb455b3254c2b19dd93`

### docs: Update README.md for documentation update

**Author:** SeppeOngena


## 2026-09-12 — `c3736140c8a12afc654a84f1ed21251130a09754`

### fix(phd): Fixed incorrect true false order of if

**Author:** SeppeOngena

New error since v0.5.0

## 2026-09-13 — `8bbe0f0ae1baa2a822483d1705f38435b9c4abdd`

### fix(general): Fixed spaces not being respected in coverpages

**Author:** SeppeOngena

Not present in v0.5.0
Caused by to splitting to new line due to line length
Also updated example table

## 2026-09-13 — `ef99a540d87acb28d1400e26b3ef7720e54558ec`

### docs: Change UGent Panno Text example \textsc to \fakesc

**Author:** SeppeOngena


## 2026-09-13 — `aab35343851686047fc1ad33c7ab10ccc9b8a2a8`

### docs: proofreading

**Author:** SeppeOngena


## 2026-09-13 — `3da16803dc0f5bc0332910d357599eaf7c11f5be`

### docs: Soften README WIP message due to near-complete state

**Author:** SeppeOngena


## 2026-08-21 — `1f5cd42c05cc9da8d4a3cb0f60d25b3e84a96f66`

### refactor(beamer): update colours

**Author:** SeppeOngena


## 2026-08-21 — `599434d1fdf8a8273d7b274e86eda53d4d6f751a`

### refactor(beamer): Update old pw and ph to PW and PH

**Author:** SeppeOngena


## 2026-08-21 — `85ea24fb8a85b1441a21bc2d120f722a51e4e87a`

### docs: Fix beamer section depth

**Author:** SeppeOngena


## 2026-08-21 — `5c253bf80708c87d13e4e92d8095b4327cef3a90`

### docs: Update logos in beamer user guide

**Author:** SeppeOngena


## 2026-08-21 — `808adce904a3997a96a8a87f2a3a0fe74f8cfbd0`

### refactor(beamer): Remove shadowed rounded blocks, default square

**Author:** SeppeOngena


## 2026-08-21 — `78627048f0ef1df422b056e65fb85e0e9e2ac4d0`

### refactor(beamer): Set default itemize to circle

**Author:** SeppeOngena


## 2026-08-21 — `b807346b3ccd0e0d6eda5f7a50903e3e2898fa2c`

### refactor(beamer)!: Remove ugentleftshape and ugentrightshape for ugentshape

**Author:** SeppeOngena


## 2026-08-21 — `cb6813353776615f589ae5d48966f7775b8fe284`

### docs: Replace beamer example images with example-image

**Author:** SeppeOngena


## 2026-08-21 — `0c72be99c22a212831a85eb1503050a00d030b17`

### refactor(beamer)!: Update frame background canvases

**Author:** SeppeOngena

- renamed negative to shaded, removed negativefill.
- added title and section backgrounds

## 2026-08-21 — `031b166bbefeccdc45931d2d15af6135ddb881f5`

### feat(beamer): Implemented \sectionframe, \subsectionframe, and \titleframe

**Author:** SeppeOngena


## 2026-09-13 — `310779dc81c4a3ddc8ef97135ab525fd9b8bb117`

### docs: Fix PhD coverbody documentation shown in macrocode

**Author:** SeppeOngena


## 2026-09-14 — `aa580b3096718e3dea3c65c18cf1cc446a6cf47f`

### fix(bama): Fix compilation with XeLaTeX

**Author:** SeppeOngena


## 2026-09-14 — `e81966b7c2cb7f2ca706e0025cba69bd29f4ea11`

### fix(report,bama): Fix fancy and fancycompact title style loading

**Author:** SeppeOngena


## 2026-09-14 — `f30ca4397ab90219ce94ba84538e2db2b5894dcf`

### build: Added image generation from PDFs

**Author:** SeppeOngena

Using the --image flag

## 2026-09-14 — `b563aa3c05cfdbe62b144f389aa7a361c102240a`

### build: Add optional support for buildig with xelatex

**Author:** SeppeOngena

using --xelatex flag
On my machine, compiles slightly faster (87 vs. 120 sec)

## 2026-09-14 — `2ff7517c48d0170f567ea0f40659f373ddcf51cb`

### fix(general): Fix DejaVu Math TeX Gyre not loading for XeLaTeX

**Author:** SeppeOngena

Word order was incorrect, LuaLaTeX could still resolve this

## 2026-09-15 — `209fb5757c90ca146ba9ccf7cce540c2716d47cd`

### refactor(beamer): Use \textendash as enumeration default

**Author:** SeppeOngena


## 2026-09-15 — `45bb97a4aee270e63c7dd15e29c67bd479846457`

### fix(beamer): Patch circle enumeration not working under OTF LuaLaTeX/XeLaTeX

**Author:** SeppeOngena


## 2026-09-16 — `1af0be7d52c1444422b00a1db15479d8633de12c`

### fix(beamer): Fix different widths of block title and body colour boxes

**Author:** SeppeOngena

Patched support for differently sized fonts between block title and body

## 2026-09-16 — `6431e85ad5d281c1ca7dfe2fc47246aae1803223`

### fix(beamer): Fix empty faculty support

**Author:** SeppeOngena


## 2026-09-17 — `62780bebe6fd105997015962b38e99f12a071d21`

### refactor(beamer): Reworked graphic slides

**Author:** SeppeOngena

- A single graphicframe environment is now used
- A graphic is set using optional graphic=<graphcontents> key
- Graphic side (left, right, top, bottom) is set by graphicpos=l/r/t/b
- Graphic proportion is set by graphicproportion=0-1 (default 0.5)

## 2026-09-17 — `afbdbfecfc959b14e635ed41cd13ab465594b552`

### fix(beamer): Fix ugent logo in footer

**Author:** SeppeOngena


## 2026-09-17 — `69605ca1bf7c18462ce4612c140b525af4c3b0a1`

### feat(beamer): implement logo key for frames

**Author:** SeppeOngena

- if logo=false is set, the UGent logo is not shown in the bottom left corner

## 2026-09-17 — `279ac2df599e40f5ea339eeb0ca834d25883693e`

### refactor(beamer): Refactor \place command

**Author:** SeppeOngena


## 2026-09-17 — `eddbd9778e7d9aa4af1475be13d1dd44ee91c3d8`

### refactor(beamer): fold some unnecessary commands back into code

**Author:** SeppeOngena


## 2026-09-17 — `42286ffe1278bec2373ad491da26f01e3c318ba3`

### refactor(beamer): Rename ugentshape to rect

**Author:** SeppeOngena


## 2026-09-17 — `61fa7fe9d570bfa2bf7deb5a5d06385b0c240713`

### fix(beamer): Fix title not showing due to redefinition for paper classes

**Author:** SeppeOngena


## 2026-09-17 — `9d010fc2bb1ffcdd9d0c1818f086cc91fa50f0bb`

### refactor(beamer): Update title slides

**Author:** SeppeOngena


## 2026-09-17 — `0cbeb5bb120ba45bbb30717371f90fca8c3e327b`

### feat(beamer): Add support for numberless sections

**Author:** SeppeOngena

throught the secnums option, default=false

## 2026-09-17 — `6d019e895d6fd830a65d101770452a527b412ca8`

### fix(general): Fix unset department and team tag retrieval

**Author:** SeppeOngena

if a casing option was passed for retrieval but no \team was set, it would display e.g. "[uppercase]"

## 2026-09-18 — `bbae9070fc556e0addac30fdce9628768fbe4933`

### feat(beamer): Implement title page logos

**Author:** SeppeOngena

Specified using \titlelogos similar to \frontcoverlogos

## 2026-09-18 — `e98a5fc7c9e617381c4214616a51a20fe60d792b`

### build(packages): add fontawesome for beamer closing page

**Author:** SeppeOngena


## 2026-09-18 — `5f5e01dacbf7519bd152c1607451378c86cd666c`

### feat(beamer): add emails, phones, and mobiles to beamer

**Author:** SeppeOngena


## 2026-09-18 — `bbb583599e29736574d558db8f7ad9fc594fe704`

### refactor(beamer): move titlelogos to canvas

**Author:** SeppeOngena


## 2026-09-18 — `8663aa3c35f38c748b940136e853048240c44ab4`

### feat(beamer): Implement closingframe

**Author:** SeppeOngena


## 2026-09-21 — `cb48758dcb5bdfde94053a61ccb2b28f66b577bc`

### feat(beamer): Changed darken macro to brightness

**Author:** SeppeOngena

- Brightness >0 lightens the image, brightness <0 darkens it

## 2026-09-21 — `de702d67158ccb93ec2789a60e05cc87663b6e43`

### feat(beamer): implement title and section frame graphics

**Author:** SeppeOngena


## 2026-09-21 — `732075cad116d9f414d0ccf30d7aacf8651a1cb6`

### refactor(beamer): move code around between inner and outer themes

**Author:** SeppeOngena


## 2026-09-21 — `22be8deca82a36f162906482362bd4540f0ec418`

### revert(beamer): removed titleframe, sectionframe etc. commands

**Author:** SeppeOngena


## 2026-09-21 — `1f2d24f0188a1b316d4844c191168d9bdc6fcff2`

### fix(beamer): Adjust default page graphic to UGent style

**Author:** SeppeOngena


## 2026-09-21 — `6437ecb2edcbb170d38d33344e6f4ce82c080a70`

### refactor(beamer): Rework the callout to a textbox

**Author:** SeppeOngena


## 2026-09-21 — `8bb02601a147ac84c5ffb8222bffadd40e07512a`

### fix(beamer): Set default textbox fill opacity to 1

**Author:** SeppeOngena


## 2026-09-21 — `30ea4cc320f84d5cac58f0ce3ef0aff800d64b06`

### fix(beamer): Fix heading and subheading font size

**Author:** SeppeOngena


## 2026-09-21 — `c95fca0aa14cdc66cbc83774a1a5e72d882bb337`

### docs(beamer): Update beamer documentation

**Author:** SeppeOngena


## 2026-09-21 — `1e6a52a127743ea83d758d84be888019618cc243`

### docs(beamer): No longer display beamer implementation

**Author:** SeppeOngena


## 2026-09-21 — `1a1f8f4f720dbd38b20f667d37f38eec9330b240`

### docs(beamer):  Update complete status of beamer theme

**Author:** SeppeOngena


## 2026-09-21 — `d4eb1b3a7768bd6bbaf6252a99ec717ec007b0f7`

### docs: Removed extra column in NOTICE.md table

**Author:** SeppeOngena


## 2026-09-21 — `6ed8671c173922ddc241623c9b49f481885c4ecc`

### docs: Update wording in NOTICE.md for clarity

**Author:** SeppeOngena


## 2026-09-22 — `c6184ca93fcf78a482412b199d655b9ecdbf55ed`

### build: Prevent ugentdocs bbl and blg files from creeping into commits

**Author:** SeppeOngena


## 2026-09-21 — `47a3382721ef46b2b0b1680d575bffeceabe50c1`

### docs: Rename leftover negativefill slide title to shaded

**Author:** SeppeOngena


## 2026-09-22 — `b8f55a79b7ef65d8e039a965342c63a78a33a509`

### docs: Update colour and color usage

**Author:** SeppeOngena

- colour for documentation
- color for code

## 2026-09-22 — `d8b158df354dccf6bec4507d3a0349f3e93b0902`

### docs: Spelling

**Author:** SeppeOngena


## 2026-09-22 — `4a7d6597c105746ab848ccec44b97e70de3cef97`

### docs: Spelling in documentation itself

**Author:** SeppeOngena


## 2026-09-22 — `b3ffb7314f2718b04418b9412125a9897c639a38`

### refactor(dictionaries): Update English exam keys, add name key

**Author:** SeppeOngena


## 2026-09-22 — `0fe8b343579fb714a15761da9ffb219ebd89b125`

### feat(exam): add name to header

**Author:** SeppeOngena


## 2026-09-22 — `f43c537b86e2368c1d469560bc231154b8247f62`

### feat(dictionaries): Add question key

**Author:** SeppeOngena


## 2026-09-22 — `1b5bcc237498d12c2e4b532d0022ddf805141c02`

### refactor(exam): Implement subquestion, update question and point weight styling

**Author:** SeppeOngena


## 2026-09-22 — `9f5cbc6b8c931c3834c32f053645908e9f5ccfa6`

### refactor(exam): Port exam cover to frontcover

**Author:** SeppeOngena


## 2026-09-26 — `0cea2f0518620d2bea44fa2a32458f6677aa6c8e`

### feat(exam): Implement point overview

**Author:** SeppeOngena


## 2026-09-26 — `57ad7e14a432128642d1e0985e8b2f4b34f7aa8b`

### docs(exam): \pointoverview macro documentation

**Author:** SeppeOngena


## 2026-09-26 — `63a568769b25b4da71de5277e0cb4f89363a5705`

### refactor(exam): Update cover page

**Author:** SeppeOngena


## 2026-09-26 — `c030cf1eeff4a2dfeac6d0e4fbe4dfa744f4bd43`

### refactor(exam): Rework insertsolutionpage to answerspace and gridpage

**Author:** SeppeOngena

Answerspace with optional arguments
- style = grid or lines (default nothing)
- lines = number of lines
Gridpage retains the uantwerpendocs implementation somewhat, including watermark

## 2026-09-26 — `97e7f117291bd93c56e167359400e4a6418149af`

### refactor(exam): Remove separatepage argument of extrainfo

**Author:** SeppeOngena


## 2026-09-26 — `fde13374a77ea8ea4094a3f012b59aed055683d6`

### docs(exam): Update examples

**Author:** SeppeOngena


## 2026-09-26 — `30a79204b69e6aad5d05bb70e9b9e58bbbf58bd7`

### docs(exam): Update finished nature of exam class

**Author:** SeppeOngena


## 2026-09-27 — `8758982ca26f31f11753ef5ed1eab54a651c448c`

### fix(docs): Fix mhchem example version error

**Author:** SeppeOngena


## 2026-09-27 — `bb645c4d22371aa11a5644700f83901061cc2ad6`

### refactor(phd): Re-enable long text for spine width

**Author:** SeppeOngena


## 2026-09-27 — `8f8498a448e8b6e013b45fcdd307467c05be442a`

### feat(article): New class - article

**Author:** SeppeOngena


## 2026-09-27 — `9b0785eb9f73a67e43ec644771b1a41366fc667c`

### feat(general): Rework author macro, add affiliation macro and affiliationformat option

**Author:** SeppeOngena

Backwards compatible
- You can pre-specify affiliations using the \affiliation macro
- You can pass affiliations as "1,2" or "a,b" for the \author macro, which draws from previous affiliations
- Literal affiliation passing to the \author is still possible
- The affiliationformat option changes the index sequence's content, e.g. "a,b,c" for alph and "1,2,3" for arabic
- You can optionally specify if the author is corresponding, and the author's email and orcid

## 2026-09-28 — `7304c9ecb1f2815771e99066717b328f7c4e645c`

### feat(general): add orcidicon

**Author:** SeppeOngena


## 2026-09-28 — `00c2cac7310ccc344f8afa14e047226e75469fba`

### feat(dictionaries): added article translation keys

**Author:** SeppeOngena


## 2026-09-28 — `5852d2299e4cc4a08d2e919fe74b472bd0d8a231`

### feat(general): Expanded date with article-specific types

**Author:** SeppeOngena

Backwards compatible
-> submitted, accepted, and published date

## 2026-09-28 — `2498bd71386911e633da978a279eb4d8d9a3084a`

### refactor(article): update article geometry

**Author:** SeppeOngena


## 2026-09-28 — `c57be502a85f2b38252ffb95ed61b3d31393ddaa`

### feat(article): Implement abstract, graphicalabstract, highlights, keywords, and journal macros

**Author:** SeppeOngena


## 2026-09-28 — `e71cab213ea2ba5593028be597a27b8816e3776a`

### feat(general): Implemented affiliation list

**Author:** SeppeOngena

Printed using \_ugentdocs_printaffiliationlist:

## 2026-09-28 — `a95e1a253987c8725eed9221542719024ff84c37`

### feat(general): Implement article-style authorlist

**Author:** SeppeOngena

Printed using \_ugentdocs_printauthorlist:

## 2026-09-28 — `654bb6a458ecdf5c0ac4202c7e5f9c794c5fa5b3`

### feat(general): Implement article-style author footnote

**Author:** SeppeOngena


## 2026-09-28 — `9bd8cf581d47adc30a332e4babbddb03ef799477`

### feat(article): Implement title pages

**Author:** SeppeOngena


## 2026-09-28 — `16e5fadf9ce2b80801090c879057676929d686ff`

### feat(article): Add keywords to PDF metadata

**Author:** SeppeOngena


## 2026-09-28 — `3767269114b8d00205978779832ab9ce9f3da3ac`

### feat(article): Implement header and footer

**Author:** SeppeOngena


## 2026-09-28 — `131a2bd8b3953c35bd6ff04f8903304de8dbc49a`

### feat(article): Apply section style

**Author:** SeppeOngena


## 2026-09-28 — `3d747acf3c7f4546391909593b9d3d9065172a98`

### docs(article): Add article example

**Author:** SeppeOngena


## 2026-09-28 — `e1def1fe622c60576cc387996897ef353b3f6f41`

### fix: Fix compilation issues

**Author:** SeppeOngena


## 2026-09-28 — `c67e05fd4a221460ea22b7d2fca68097069b2487`

### docs: Update README example images

**Author:** SeppeOngena


## 2026-09-29 — `2f82267f28aa3bacd4f17d7b0d4e7b5e802c0fa7`

### feat(general): Added warning messages for missing mandatory macros

**Author:** SeppeOngena


## 2026-09-29 — `56333b2206801e4514e1db6b8c44a49bbd3b99af`

### fix(letter): Fix missing brace for closing warning

**Author:** SeppeOngena


## 2026-09-29 — `b577b965e12ed2030301b0da2f794181ac9ba714`

### fix(beamer): Fix pgfplots warning

**Author:** SeppeOngena


## 2026-09-29 — `e10f57b7054f76ad71b7d466d573c284531dec01`

### fix(beamer): Fix pdf info warning

**Author:** SeppeOngena


## 2026-09-29 — `a51c9162b9ac2bb53c6f8a93670259202dd1705a`

### fix(general): Fix csquotes warning when loading babel

**Author:** SeppeOngena


## 2026-09-29 — `cb1fb738979a8715da5066ba76abcc605251ec4f`

### fix(general): Fix unused options warning

**Author:** SeppeOngena


## 2026-09-29 — `fc18797a5762df184f910c3e1ff8cd69a0b47da3`

### fix(general): Fix wasy font scaling issues

**Author:** SeppeOngena


## 2026-09-29 — `52ee033f7716d0012240f865d2caeae54dd454cf`

### fix(phd): Fix nopagecolor warning when loading crop package

**Author:** SeppeOngena


## 2026-09-29 — `49d1178aaff058e7219318093c15a663ae70d0cf`

### fix(docs): Fix printbibliography example hbox for PhDs

**Author:** SeppeOngena


## 2026-09-29 — `41bd269b65126bee4448364b7869b131a70c0b87`

### fix(general): Fix pdfauthor andlist key expansion

**Author:** SeppeOngena


## 2026-09-29 — `32062866cdc726d2614de383ad5b53e0b19e4c27`

### fix(course,phd): Fix GS1 barcode warning

**Author:** SeppeOngena


## 2026-09-29 — `6e738b96cf10361b715bf0e4e1f1997a4be5f41d`

### fix(exam): Fix empty title warning

**Author:** SeppeOngena


## 2026-09-29 — `a9856150b2c053657a42e32d46c64e830926bde2`

### fix(letter): Author is not mandatory for letter

**Author:** SeppeOngena


## 2026-09-29 — `85c00ab66b257a000e4580971807c9f389d91536`

### fix(bookcover): Fix supervisors empty warning for courses

**Author:** SeppeOngena


## 2026-09-29 — `732abb4125951ace2dd56376298526182565939a`

### fix(general): Fix most bad box messages

**Author:** SeppeOngena

The exam bilingual ones are impossible to fix (due to narrow text width) without setting raggedright

## 2026-09-29 — `5fc81951cc8bd127654469c5c8c0135adaf7376e`

### docs: Fix flush left typo

**Author:** SeppeOngena


## 2026-09-30 — `5d6151a74c8342e78de998eb4a6be0a3738171b9`

### docs: Proof-reading

**Author:** SeppeOngena


## 2026-10-01 — `bdb3e1f7f23b46860da421ab9eaf0474d2349ae6`

### docs: Update changelog message with last updates

**Author:** SeppeOngena


## 2026-10-01 — `9745d736058d36e17eb305f1bd008aca446ae4a2`

### docs: Added CTAN build option

**Author:** SeppeOngena


## 2026-10-01 — `c93a9fda67bd1270efc1d73ea6c63b5717ce58ef`

### docs: Update notice with changes

**Author:** SeppeOngena


## 2026-10-01 — `f2f2d994e1752baa4dbd0e7eee11c5d1ccf9eae2`

### docs: Add discussions link to CONTRIBUTING.md

**Author:** SeppeOngena


## 2026-10-01 — `af2d3217c09f806cd1ee34930267f1b9b8ff05ee`

### docs: Update readme for v1.0.0 release

**Author:** SeppeOngena


## 2026-10-02 — `b4b5ea5d8d9b6e1fa871e7e4ebc7baac63dcc75a`

### build: Move from shell script to l3build, including CTAN release

**Author:** SeppeOngena


## 2026-10-02 — `fb23b3fc7362c51eb23a2b1bcb3ad62529bd1a51`

### docs: Small README notice that Overleaf packages can be out of date

**Author:** SeppeOngena


## 2026-10-02 — `87dfa7217a626810b37327fc2b934c8ac73ee9eb`

### build: Bump checkout and upload-artifact versions

**Author:** SeppeOngena


## 2026-10-02 — `6daff9d9196b20a45ca1c8cf41d952b5f2412886`

### build: Update CTAN URLs

**Author:** SeppeOngena


## 2026-10-02 — `e74de2afb8011cb4e483aa36ce42ad3642f15cde`

### build: ignore generated .curlopt

**Author:** SeppeOngena


## 2026-10-02 — `9b42c9fb6f487ca7d25f0c468cdd661642967471`

### fix(general): Fix math font upright etc. not using the set font

**Author:** SeppeOngena


## 2026-10-02 — `df742752a50788cd16e2d87f8a905b667adba3c6`

### refactor(general): Scale Noto Sans by 0.9x to match UGent Panno

**Author:** SeppeOngena


## 2026-10-02 — `b5d69e12488ead92681ca1a3bbe0c6e31e8974fe`

### fix(general): Fix title newlines not being removed in headers/footers/spine

**Author:** SeppeOngena


## 2026-10-03 — `1113c0b48f179c9819e319d51c72cb5e0b40bed2`

### fix(general): Fix build failing due to spaces before guard

**Author:** SeppeOngena


## 2026-10-04 — `0d5f35810e5f66d0f2b77ed7b8d70b15c621092e`

### fix(general): Fix firstnamecolor availability for non-article classes

**Author:** SeppeOngena


## 2026-10-04 — `c58cce35df774d0b699d0aea960ec71bd47ccbce`

### feat(dictionaries): Add support for manual key addition

**Author:** SeppeOngena


## 2026-10-04 — `12fdaa5e04531b66340942003c2f8bc2e55f71ff`

### fix(report, bama): Fix  footer logo alignment

**Author:** SeppeOngena


## 2026-10-04 — `e76ee81bcbafca40c6509bf999b6249dfa6afcdd`

### docs: Fine-tune NOTICE.md changes list

**Author:** SeppeOngena


## 2026-10-04 — `b2efd7e6fa77677d8c79139602c99eab1cbe94bc`

### docs: Update 'ugentarticle' description in README

**Author:** SeppeOngena


## 2026-10-04 — `e5b58a41a2476e8614bd4b5d5288ddeeb9b22c73`

### docs: Revise 'ugentreport' entry and add contrib package info

**Author:** SeppeOngena


## 2026-10-04 — `69fd1809033915912543e3f8e57d94bb4ad1f2c8`

### docs: Update CONTRIBUTING.md with ugentdocs-contrib info

**Author:** SeppeOngena


## 2026-10-05 — `2aae14f63512cdcb8f9032d73a1cc3b927a6ee34`

### fix(bama,report): Fix header for section-only document

**Author:** SeppeOngena


## 2026-10-05 — `316fceb089dcf7ff5441bfd5447a88854e28fe94`

### feat(general): Implement base font overriding math font glyphs

**Author:** SeppeOngena

Set in preamble with \overridemathfont{<Font>} or removed using \overridemathfont{}
Only sets numbers and letters, as there's no straightforward way to only replace missing glyphs

## 2026-10-05 — `8c0d7519f61ffd617f127ba845ce506f7d388b7d`

### docs: Fix upright math in the example not using the math font

**Author:** SeppeOngena


## 2026-10-06 — `916ade371ae7eb9dcd536916271f505a0d0eb301`

### feat(article): Add copyrightnotices to article class, prints at bottom of cover page

**Author:** SeppeOngena


## 2026-10-06 — `0eebcbb1cd2b8bb9bde32e48e8af23d73253dab4`

### fix(general): Improve compatibility with hyperxmp package

**Author:** SeppeOngena


## 2026-10-06 — `03c03fccfa07a9061b8f70c03024fef88741374d`

### fix: Fix examples compilation failure due to unclosed docstrip guard

**Author:** SeppeOngena


## 2026-10-07 — `a80e5b34a2ddde422f6d95fba09eb47e893c348e`

### refactor: Remove publisher logo images

**Author:** SeppeOngena


## 2026-10-07 — `f3050bc689e91ffb1d3a2ba291bc0e7e0e95ab45`

### fix(build): Fix beamer user guide not appearing in examples release

**Author:** SeppeOngena


## 2026-10-07 — `4bfd469131dac52310e1fd22969363d800162b90`

### fix(phd): Fix fancy title style getting stretched

**Author:** SeppeOngena


## 2026-10-07 — `bdeb04938cd1e4734b025bfc082b039cfe294e3c`

### fix(phd): Fix unnumbered chapter title being stretched

**Author:** SeppeOngena


## 2026-10-08 — `c3222ee5ea59ab575872013bc4ce52bb88b2c0c0`

### fix(general): Fix faculty logo text of EA, PP, EB, and FW

**Author:** SeppeOngena


## 2026-10-08 — `49c1893352905531bb880550d4bdfdcdea7b7ea7`

### refactor(course): Improve horizontal alignment of narrow faculty icons (FW, EA, EB, PP, WE)

**Author:** SeppeOngena


## 2026-10-08 — `334bc8f0b01539b622f9af66c44a586bb1391e1e`

### fix(phd,article): Fix DOI links being recognized as .pdf link

**Author:** SeppeOngena


## 2026-10-08 — `94b50271e9c0b7daade1841c6baaf8411c370fcb`

### docs: Update examples to include more faculties

**Author:** SeppeOngena


## 2026-10-08 — `14e577a18aa62d461f797a6fcdfa192f461b9298`

### docs: Update README example images

**Author:** SeppeOngena


## 2026-10-08 — `867e5075f565d847709a62df99bcd827fed2c41d`

### docs: Remove Overleaf from README

**Author:** SeppeOngena

As it seems the free plan is only a 10s compile time, this is not an option anymore.
## 2026-10-08 — `27a3f5b9e169457302aeaf51e3112785a94b150b`

### docs: Remove missed Overleaf from README

**Author:** SeppeOngena


## 2026-10-08 — `060f9de33602bce01528e1b257cbd9be2a887b9a`

### refactor: Implement try* font commands

**Author:** SeppeOngena

- trysetsansfont, tryoverridemathfont, trynewfontfamily, trynewfontface, \trysetnathfont
- Enable font loading from system installed fonts, root document directory fonts, or fonts/ directory fonts

## 2026-10-08 — `34b8000990f94773ed488e1050ba738660954793`

### docs: Update font documentation for online editors

**Author:** SeppeOngena


## 2026-10-08 — `02eb1ff50149857e9542944e16e16dac0ba869d7`

### docs: Update README for online editors

**Author:** SeppeOngena


## 2026-10-09 — `be3b6ac4fd66721f62db750605e929c238dd7745`

### build: Fix typo and wording in CTAN upload

**Author:** SeppeOngena


## 2026-10-09 — `32fdf58e4a11c6c871cfd99938c1025541c98b9d`

### build: Add CTAN topics

**Author:** SeppeOngena


## 2026-10-13 — `ad9e6675f6331b9003d2685ac369c3beb778a91a`

### refactor(beamer): Refactor \appropriateslidenumber and \maybeinverse to L3

**Author:** SeppeOngena


## 2026-10-13 — `11c1626a97de40bedf1d3e08ebad64f5d0625029`

### feat(beamer): Add framenumber key

**Author:** SeppeOngena


## 2026-10-13 — `5ae231bb56efafc639f8d24ffc1fea80da4b8fb0`

### fix(beamer): Fix frame number not showing in negative slides

**Author:** SeppeOngena


## 2026-10-13 — `f3f5e6162a85b1aae35da2554b301e13adf96b47`

### chore(copyright): Update copyright disclaimers

**Author:** SeppeOngena

Since this work actually falls under "Derived Works That Are Not Replacements"

## 2026-10-13 — `ed3a96fa4636aeb6cc628f9382c6715a4f129627`

### docs: Remove unrelated entries from index

**Author:** SeppeOngena


## 2026-10-20 — `0fdc5c3a83f0c8ddff65aac4751070e392d3a5bc`

### docs: Fix typo

**Author:** SeppeOngena


## 2026-10-20 — `f2c4816092c850b0b628a5e5804575e5fde0f7d7`

### docs: More detailed XeLaTeX or LuaLaTeX req CTAN reason

**Author:** SeppeOngena



The complete development history is available in the Git repository:

https://github.com/SeppeOngena/ugentdocs
