yes

# 0460-whatsnote-science-notes: whatsnote Science Notes

- Unverified: read from the source, not compiled.
- Source: Source/0460-whatsnote-science-notes/ (origin: https://latextemplates.com/downloads/whatsnote-science-notes.zip; licence: LPPL-1.3c per the manifest; the CTAN page for `whatsnote` also states LPPL 1.3c)
- Kind: misc (a science and engineering lab-notes sample; the manifest hint is `misc`)
- Lib: v4
- Engine: not established (the sample's own content is pdfLaTeX-compatible: `siunitx` and kernel commands, main.tex:2-25; the class `whatsnote.cls` is not in the zip and was not read, so whether it needs `fontspec` or XeLaTeX/LuaLaTeX is unknown)
- Look carried by: class (the zip is one `main.tex` that loads the published class `whatsnote`, sets two class options, one `\coverset` call and `siunitx`; it defines no look of its own)
- Class origin: tex-distribution-unbundled (ctan.org/pkg/whatsnote: class `whatsnote` 5.0B, M. Y. Xia, LPPL 1.3c, "included in TeX Live and MiKTeX"; no `.cls` or `.sty` in the zip)
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
yes. The zip holds one 26-line sample (`ls -R`: `main.tex` only). Its look is carried by the published class `whatsnote` (CTAN and TeX Live, LPPL 1.3c); the sample adds the class options `11pt,a4paper`, `siunitx`, a `\coverset{...}` key-value call, `\maketitle`, kernel sectioning, a `description` list, `\\[2em]` and a `\rule`. An emitter could write the whole file from published packages and kernel commands, with no zip-local macro logic. Caveat: the class source was not available (not in the zip, no local TeX), so what `whatsnote.cls` loads internally and its engine need are unread. If it loads a tool-dependent package unconditionally (rubric ruling: `EXTERNAL/package`), this `yes` would not hold; nothing in the sample points that way. This is evidence about the class dimension, not about the component ways.

## Blockers
none

## Class setting
- Class: `class.whatsnote` options: `11pt`, `a4paper` (main.tex:1)
- Class-native vocabulary used: `\coverset{key=value,...}` with the keys `title`, `author`, `afill`, `date`, `extinfo` (main.tex:3; what `afill` and `extinfo` print is not verified, the sample gives them `Science notebook` and `Thermal cycling`); `\maketitle` (main.tex:5) prints the cover or title block from those keys. Sectioning, `description`, `\rule` and `\\[len]` in the body are plain kernel commands. No class environment, box or command beyond `\coverset` is used.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.whatsnote` | options `11pt`, `a4paper`; source not read |
| paper and base size | main.tex:1 | `page.class-options` | `a4paper`, `11pt` (class options, no `geometry` call) |
| title block (front matter) | main.tex:3, 5 | `front.class-native` | `\coverset{title=Experimental Notes, author=Your Name, afill=Science notebook, date=\today, extinfo=Thermal cycling}` then `\maketitle`; the date value is the kernel `\today`, no `datetime` package |
| units and quantities | main.tex:2, 7 | `mark.siunitx` | `\usepackage{siunitx}` with no options; `\SI{-20}{\celsius}` and `\SI{80}{\celsius}` inline |
| sectioning commands | main.tex:6, 10, 14, 20, 22 | `head.kernel` | `\section{...}` x4; `\subsection*{Next action}` (starred, unnumbered) at :22; no `\renewcommand` of format or counters |
| heading look | main.tex:6, 10, 14, 20, 22 | `head.class-native` | no heading option is set in the sample, so the look is the class default; its source was not read |
| run log list | main.tex:15-19 | `list.kernel` | `description` environment, three `\item[08:40]`, `\item[09:15]`, `\item[10:30]` (label text is content); no `enumitem` |
| line break with extra space | main.tex:24 | `sp.manual-space` | `\\[2em]` |
| closing rule | main.tex:25 | `sp.rule` | `\rule{\linewidth}{0.4pt}` |
| paragraph indent switch | main.tex:25 | `sp.lengths` | `\noindent` (same type as `\parindent`: a per-paragraph indent control); it follows `\\[2em]` with no blank line (main.tex:24-25), so it sits in horizontal mode, where TeX ignores it, and has no visible effect here |
| everything else the class sets (running heads, fonts, colours, cover layout, section look) | main.tex:1 | `class.whatsnote` | class defaults; the sample passes no option or command for them; not read, so no finer way is claimed |

Not present in the sample: abstract, contents, floats, tables, captions, theorems, code, boxes, bibliography, index, cross-references, footnotes, appendices, `\pagestyle` or `geometry` calls.

## Bespoke code
none. A grep of main.tex for `newcommand`, `renewcommand`, `\def`, `newenvironment`, `newcounter`, `RequirePackage`, `\input`, `\include`, `tikz` and shell escape finds nothing. The zip has no `.cls`, `.sty`, `.def`, `.cfg`, `.clo`, `.bst` or `.dtx`.

## Content-opaque
none. The text, the measurement quantities and the three log entries are content; there are no figures, tables or drawings.

## Lib changes
- New ways proposed: none. `class.whatsnote` is a class way, written plainly as the rubric requires, with no proposal prefix; the vocabulary the sample uses is recorded above under Class setting. Considered and not proposed: a separate line for `\noindent`, which belongs to `sp.lengths` (paragraph-shape parameters) and has no effect in this sample.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- Untrusted-content check: no text addressed to an AI appears in the zip.
- Network: one read of https://ctan.org/pkg/whatsnote (class, 5.0B, maintainer M. Y. Xia, LPPL 1.3c, in TeX Live and MiKTeX). That page lists no options, `\coverset` keys, engine or dependencies; the README and manual it links were not read, since the rules allow only `ctan.org/pkg/` pages.
- Unread: `whatsnote.cls` (not in the zip, no TeX distribution on the analysis machine). A reviewer who wants certainty about `Engine:` and about unconditional package loads needs that file.
