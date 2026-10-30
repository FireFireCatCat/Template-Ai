yes

# 0289-songs-lyric-and-chord-book: Songs Lyric and Chord Book

- Unverified: read from the source, not compiled.
- Source: Source/0289-songs-lyric-and-chord-book/ (origin: https://latextemplates.com/downloads/songs.zip; licence: GPL-2.0-or-later per the manifest and README.md:15; the `songs` package is by Kevin W. Hamlen, GNU GPL v2 per its CTAN page)
- Kind: misc (a song book: title block, then songs with verses, chorus and chords; the manifest hint `misc` is kept, no listed kind fits)
- Lib: v3
- Engine: pdfLaTeX-compatible (main.tex:2-3 load `fontenc`/`inputenc`; nothing needs fontspec or Lua; the `songs` source is not in the zip and was not read, so this rests on the sample)
- Look carried by: preamble (published package `songs` with option `chorded`, settings at main.tex:5-10; song data in the zip-local `songs.sbd` is body markup and content, no zip-local code)
- Class origin: tex-distribution-unbundled (kernel `article`, main.tex:1; no class or style file in the zip)
- Main file: main.tex (other samples: none; `songs.sbd` is the `\input` data file, not a second sample)
- Read: main yes, zip-local classes and styles none present (the zip holds only README.md, main.tex, songs.sbd; the package `songs` is loaded from the TeX distribution and its source was not read)

## Verdict
The whole look is a published class (`article`) plus one published package, `songs` (on CTAN and in TeX Live, GPL 2), set up with a package option, a column count, one measured length and metadata keys. The zip defines no macro, environment, counter, class or style of its own, so there is no bespoke code and no artwork. The song book component has no home in lib v3, so it is proposed as `songbook.songs`, a doc-kind way like `cal.kalender` or `logbook.dmlb`; it passes W1 to W4 (below). Everything else maps to existing ways. Verdict yes.

## Blockers
none

(Notes, not blockers: the `index=` key at songs.sbd:4 only records an index entry; the sample asks for no printed index, because `\begin{songs}{}` has an empty argument (main.tex:20) and no index-printing command appears anywhere in main.tex. If an emitter did print the package's indexes, my prior knowledge of the package manual says they are built by a separate `songidx` tool, which would be `EXTERNAL`. That was not read from this zip and is not used by this sample. `songs` was also considered under `art.content-package` and rejected: its input is lyric text with chord-name markers, not a notation program or drawing, and the song book is the document itself, not a figure inside one.)

## Class setting
- Class: `class.article` options: `11pt`, `a5paper` (main.tex:1)
- Class-native vocabulary used: `\title`, `\author`, `\date`, `\maketitle` (main.tex:12-14, 17), `\section*` (main.tex:24). No `abstract`, no `\tableofcontents`, no bibliography.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.article` | 11pt, a5paper |
| page size and base size | main.tex:1 | `page.class-options` | `a5paper`, `11pt` |
| encoding | main.tex:2-3 | `font.fontenc-t1` | `fontenc` T1; `inputenc` utf8 |
| page geometry | main.tex:4 | `page.geometry` | margin=15mm |
| song book package | main.tex:5 | `songbook.songs` | `\usepackage[chorded]{songs}` (chords printed above lyrics); main.tex:25-27 names the alternatives `lyric`, `slide`, `trans` as separate builds |
| paragraph indent | main.tex:7 | `sp.lengths` | `\parindent`=0pt |
| text width | main.tex:8 | `page.setlength` | `\textwidth` = `\linewidth` (taken from main.tex as written; its net effect next to the geometry margins was not worked out) |
| verse number width | main.tex:9 | `songbook.songs` | package length `\versenumwidth` set with kernel `\settowidth` to the width of the string `1.\ ` (assignment is `sp.lengths`) |
| song columns | main.tex:10 | `songbook.songs` | `\songcolumns{1}` |
| title block | main.tex:12-14, 17 | `front.maketitle` | title "Songs for a Small Room", author placeholder, `\date{\today}` |
| song-group heading | main.tex:19 | `songbook.songs` | `\songsection{Original songs}` (the package's own section command) |
| songs body wrapper | main.tex:20-22 | `songbook.songs` | `\begin{songs}{}` (empty argument) around `\input{songs.sbd}` |
| song with metadata | songs.sbd:1-4, 23-25 | `songbook.songs` | `\beginsong{title}[by=..., cr=..., index=...]` ... `\endsong` (author, copyright line, extra index entry strings) |
| verse | songs.sbd:5-10, 15-20, 26-31 | `songbook.songs` | `\beginverse` ... `\endverse` |
| chorus | songs.sbd:11-14 | `songbook.songs` | `\beginchorus` ... `\endchorus` |
| inline chords | songs.sbd:6-9, 12-13, 27-30 | `songbook.songs` | `\[C]` `\[F]` `\[G]` `\[D]` placed before a syllable |
| verse continuation mark | songs.sbd:16-19 | `songbook.songs` | `^` at line starts and mid-line (meaning taken from README.md:8-9; the package source was not read) |
| unnumbered section | main.tex:24-27 | `head.kernel` | `\section*{Changing the output}`, followed by body text (content) |
| inclusion of the data file | main.tex:21 | `songbook.songs` | kernel `\input{songs.sbd}`; an emitter can inline the file's content in place |

Components the zip does not use: header/footer (no `\pagestyle`, so the class default applies), colour, hyperref, floats, tables, captions, maths, theorems, code, bibliography, index printing, language/babel.

## Bespoke code
none. main.tex has no `\newcommand`, `\def`, `\newenvironment`, counter or conditional; songs.sbd holds only package commands and lyric text (grep shows no `\def` or `\newcommand` in either file).

## Content-opaque
none (the lyrics, chord names and metadata strings are content; there is no figure, tikz or image).

## Lib changes
- New ways proposed: `songbook.songs`: `songs` package (CTAN, in TeX Live, GPL 2; maintainer Kevin W. Hamlen), a lyric-and-chord song book; pdfLaTeX-compatible as far as the sample shows (no fontspec or Lua used).
  - Preamble: `\usepackage[chorded]{songs}` (output mode option; main.tex:25-27 names `lyric`, `slide`, `trans` as other builds), `\songcolumns{n}`, the length `\versenumwidth`.
  - Body: `\songsection{title}`, `\begin{songs}{}`, per song `\beginsong{title}[by=,cr=,index=]` ... `\endsong`, `\beginverse`/`\endverse`, `\beginchorus`/`\endchorus`, inline `\[chord]` before a syllable, `^`.
  - W1 Published: on CTAN and in TeX Live (read once at https://ctan.org/pkg/songs; the zip's README.md:13 gives the same source). W2 Declarative: the mode is an option, the column count an integer, the verse-number width a length, the metadata keys strings. W3 Generic: serves any song book, not one document (the sample's two songs are only content). W4 Printable: one preamble line plus settings, and body wrappers around each song, verse and chorus, with chord markers inside text runs. Same family as the accepted doc-kind ways `cal.kalender`, `logbook.dmlb`, `inv.simpleinvoice`.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
