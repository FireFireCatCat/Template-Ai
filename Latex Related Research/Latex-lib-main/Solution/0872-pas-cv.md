yes

# 0872-pas-cv: pas-cv (Stéphane Pasquet, CV frames with 15 TikZ models)

- Unverified: read from the source, not compiled.
- Source: Source/0872-pas-cv/ (origin: https://mirrors.ctan.org/macros/latex/contrib/pas-cv.zip; licence: LPPL)
- Kind: cv
- Lib: v6
- Engine: pdfLaTeX-compatible (tikz, eso-pic, fp, geometry, graphicx only, latex/pas-cv.sty:16-22; `photo.png` and the fading/opacity in the models need PDF output; no fontspec)
- Look carried by: mixed (the published CTAN package latex/pas-cv.sty with its 15 `macro-<model>.tex` files, latex/pas-cv.sty:24-38, draws the page art, identity frames, titles and margins; the sample adds only `article`, encoding, babel, hyperref colours and one text overlay)
- Class origin: tex-distribution-unbundled (`article`, not in the zip; pas-cv is a package, CTAN, TeX Live and MiKTeX per ctan.org/pkg/pas-cv, not zip-local)
- Main file: examples/cv-pegase.tex (other samples: examples/cv-{andromede,architecte,centaure,dynamique,gaia,jupiter,mars,neptune,orion,pluton,saturne,univers,uranus,venus}.tex, same API with another `modele=`; their preambles and `\CVbg` blocks were grepped, not read in full; doc/pas-cv.tex is the French manual and needs `pas-doc.sty`, which is not shipped, doc/pas-cv.tex:4)
- Read: main yes, zip-local classes and styles all (latex/pas-cv.sty and all 15 latex/macro-*.tex read in full; the zip has no .cls)

## Verdict
yes, on one condition that I state openly: the verdict rests on accepting the published package `pas-cv` as one way, `NEW:cv.pas-cv`. The sample (examples/cv-pegase.tex) defines no macro, no length and no drawing; it loads `article`, four standard packages and `pas-cv`, then calls the package's own commands (`\CVbg`, `\CVh`, `\infoLeft`, `\infoRight`, `\CVmargins`, `\CVtitle`, `\CVclearpage`) around tabulars and minipages. An emitter can write exactly that using published packages and kernel commands, copying no zip-local macro logic. The TikZ art lives inside the CTAN package and is chosen by the closed-list key `modele` (as `front.fariscovernew` and `cal.kalender` are accepted ways with fixed shapes). If a reviewer holds that a package whose 15 models are hand-drawn TikZ fails W2 or W3, the result becomes `ART/package` for latex/macro-pegase.tex:5-31 and its siblings, and the answer flips to `no`. Look carried by the package, so this is evidence about the package dimension, not about the component ways.

## Blockers
none (see the condition in Verdict)

## Class setting
- Class: `class.article` options: none (examples/cv-pegase.tex:1)
- Class-native vocabulary used: none. The sample uses no `\title`, `\maketitle`, `abstract` or `\section`; the package's `\CVtitle` takes the place of section headings (examples/cv-pegase.tex:43).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class | examples/cv-pegase.tex:1 | `class.article` | no options; the models are drawn on a 21 x 29.7 cm page (doc/pas-cv.tex:276) and the sample passes no paper option, so an emitter should add the class option a4paper to be safe (a parameter of `class.article`) |
| encoding, fonts | examples/cv-pegase.tex:2-3 | `font.fontenc-t1` | `inputenc` latin1 (an emitter writes utf8), `fontenc` T1 |
| language | examples/cv-pegase.tex:4, :48, :78 | `lang.babel` | `frenchb`; `\og ... \fg` guillemets are babel-french commands |
| links | examples/cv-pegase.tex:5, :29 | `meta.hyperref` | `colorlinks=true, linkcolor=red!50!black, urlcolor=red!50!black`; `\href{mailto:..}{..}` |
| CV package load | examples/cv-pegase.tex:6; latex/pas-cv.sty:16-38 | `NEW:cv.pas-cv` | `\usepackage{pas-cv}`, no options; loads xkeyval, graphicx, tikz (+libraries shadows calc fadings shapes.geometric patterns decorations.pathmorphing), eso-pic, fp, geometry |
| page background art and photo | examples/cv-pegase.tex:15-24; latex/macro-pegase.tex:5-31 | `NEW:cv.pas-cv` | `\CVbg[modele=pegase, bgcolor=red!50!black, bordercolor=red!80!black, poste={Enseignant en Mathématiques}, postecolor=white, pic=photo.png, scalepic=.4]`; `postesize` (default `\Huge`) and `borderpic` left at defaults (commented out :20, :23); defaults latex/pas-cv.sty:51 |
| header height | examples/cv-pegase.tex:26; latex/pas-cv.sty:205-221 | `NEW:cv.pas-cv` | `\CVh{1}` (cm; model default 2, latex/macro-pegase.tex:2) |
| identity block, left | examples/cv-pegase.tex:28-30; latex/macro-pegase.tex:34-42 | `NEW:cv.pas-cv` | `\infoLeft{..}`, content is text with `\textbf`, `\textcolor`, `\href`; the model places it at (1.7cm, .97\paperheight) in a `\paperwidth` minipage |
| identity block, right | examples/cv-pegase.tex:31-37; latex/macro-pegase.tex:45-63 | `NEW:cv.pas-cv` | `\infoRight{..}`, content `\color{red!10!white}`, `\vskip 2mm`, lines with `\\`; placed beside the photo, 10cm minipage |
| margins | examples/cv-pegase.tex:39; latex/macro-pegase.tex:80-83 | `NEW:cv.pas-cv` | `\CVmargins` runs `\newgeometry{tmargin=(\CVh+5)cm, bmargin=1.3cm, lmargin=1.2cm, rmargin=1.5cm}`, so tmargin=6cm here; latex/pas-cv.sty:120-136 |
| section titles | examples/cv-pegase.tex:43, :57, :73, :90, :117; latex/macro-pegase.tex:66-77 | `NEW:cv.pas-cv` | `\CVtitle[color=red!60!black, bordercolor=red!60!black]{\Large ...}`; fixed square-with-shadow marker, small-caps bold title |
| further pages | examples/cv-pegase.tex:115; latex/pas-cv.sty:163-202; latex/macro-pegase.tex:86-101 | `NEW:cv.pas-cv` | `\CVclearpage` (a `\newpage`, a reduced background, `\newgeometry{tmargin=2cm, bmargin=2cm, lmargin=1.2cm, rmargin=1.5cm}`) |
| text overlay on the art | examples/cv-pegase.tex:7-13 | `bg.eso-pic` | `\AddToShipoutPicture{\put(\LenToUnit{12cm},\LenToUnit{23.25cm}){...}}`; text `\huge\bfseries\itshape\color{red!50!black}` |
| overlay text style | examples/cv-pegase.tex:11 | `font.size-commands`, `mark.kernel`, `color.xcolor` | `\huge`; `\bfseries\itshape`; `\color{red!50!black}` |
| body columns | examples/cv-pegase.tex:42, :88-89, :106-112 | `box.minipage`, `cols.minipage` | minipages of 13.5cm and 7cm side by side (no blank line between them), 8cm and 9cm side by side with `\hspace*{5mm}` |
| tables of entries | examples/cv-pegase.tex:47-53, :61-69, :77-87, :94-97 | `tbl.tabular` | `tabular{p{3.5cm}p{7cm}}`, `tabular{p{2.5cm}l}`; first cell `\hfill\bfseries\scshape\color{red!50!black}` |
| inline marks and colour | examples/cv-pegase.tex:48, :107, :111 | `mark.kernel`, `color.xcolor`, `font.size-commands` | `\emph`, `\scshape`, `\Huge\bfseries\color{white}`, `\itshape\large\color{white}` |
| manual spacing | examples/cv-pegase.tex:45, :55, :99, :101, :104, :109 | `sp.manual-space` | `\medskip`, `\bigskip`, `\vskip 13cm`, `\phantom{o}`, `\vskip 45mm`, `\hspace*{5mm}`; `\noindent` at :41 |
| package-loaded helpers | latex/pas-cv.sty:17, :20, :22 | `fig.graphicx`, `bg.eso-pic`, `page.geometry` | `\includegraphics[scale=\cmdPAS@bg@scalepic]` of the photo (latex/macro-pegase.tex:23), `\AddToShipoutPicture` and `\LenToUnit`, `\newgeometry`; loaded by latex/pas-cv.sty, not written by the emitter beyond `\usepackage{pas-cv}` |

Not present in the sample: sectioning, lists, theorems, floats and captions, maths, code, notes, bibliography, index, header/footer (no `\pagestyle` call; the article default `plain` stays), contents, abstract. The overlay `\AddToShipoutPicture` at :7 is cleared by `\CVclearpage` (latex/pas-cv.sty:165 `\ClearShipoutPicture`), so it prints on page 1 only; ordering constraints for an emitter: `\CVbg`, then `\CVh`, `\infoLeft`, `\infoRight`, `\CVmargins`, then body (doc/pas-cv.tex:158, :216).

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `latex/pas-cv.sty` (xkeyval keys `bg` and `title`, `\ifx\cmdPAS@bg@modele\modele@<name>` dispatch, `\AddToShipoutPicture` and `\ClearShipoutPicture`) | latex/pas-cv.sty:42-221 | n/a: published (CTAN, TeX Live, MiKTeX, LPPL); the emitter writes the package call, never this code | the way `NEW:cv.pas-cv`; the model name is the value of key `modele` (latex/pas-cv.sty:42) |
| 15 model files: `\fond@`, `\infoLeft@`, `\infoRight@`, `\title@`, `\margins@`, `\clearpage@`, `\clearmargins@` per model | latex/macro-pegase.tex:1-101 (and the 14 siblings, all read) | n/a: published inside the package. Their TikZ fills, shades, fadings, `rnd` stars (latex/macro-univers.tex:16-22) and decorations are NOT reducible to other lib ways; they are in scope only through `NEW:cv.pas-cv` | none to write: a model is picked, not rebuilt |
| user-written new models (documented extension) | doc/pas-cv.tex:254-361 | not used by the sample; extends the package code, so outside the way | none |
| sample-local macros, lengths, counters | examples/cv-pegase.tex | none exist | none |

## Content-opaque
- `photo.png` (latex/photo.png) passed through `pic=photo.png` (examples/cv-pegase.tex:22): an included image, content; ship it with the output.
- No TikZ or picture code in the sample itself; the art is inside the package.

## Lib changes
- New ways proposed: `NEW:cv.pas-cv` `pas-cv` (CTAN macros/latex/contrib, TeX Live and MiKTeX per ctan.org/pkg/pas-cv, LPPL, Stéphane Pasquet, v2.01 of 2013-11-26; pdf): a one-page CV frame with a model-named TikZ background; `\usepackage{pas-cv}`, body `\CVbg[modele,bgcolor,bordercolor,poste,postesize,postecolor,pic,borderpic,scalepic]`, `\CVh{cm}`, `\infoLeft{..}` `\infoRight{..}`, `\CVmargins`, `\CVtitle[color,bordercolor]{..}`, `\CVclearpage`; `modele` is one of 15 names (andromede architecte centaure dynamique gaia jupiter mars neptune orion pegase pluton saturne univers uranus venus), the other values are colour expressions, a size switch, strings, a file name, a scale number and a height in cm. W1 published: on CTAN, TeX Live and MiKTeX with a shipped manual. W2 declarative: behaviour is chosen by the keys above (new models would mean writing macro files, which stays outside the way). W3 generic: the frame serves the CV of anyone, the text being content (not one document; the same type as `front.fariscovernew`, which draws fixed shapes chosen by a closed list of names). W4 printable: one preamble line and a fixed sequence of body calls. Not `cv.entries` (no `\cventry`-style entry commands), not `bg.tikzpagenodes` (the sample draws nothing), not `poster.tikzposter`.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
