no

# 0492-makecookbook: makecookbook (a LuaLaTeX family-cookbook preamble bundle)

- Unverified: read from the source, not compiled.
- Source: Source/0492-makecookbook/ (origin: https://mirrors.ctan.org/macros/luatex/latex/makecookbook.zip; licence: lppl1.3c)
- Kind: book
- Lib: v4
- Engine: needs LuaLaTeX or XeLaTeX (`fontspec` is loaded unconditionally and the three fonts are loaded by file name, mycookbook/cb-preamble.tex:45, 50-105; the README says the bundle is made for LuaTeX, README.txt:9-10; only the documentation file has a pdfLaTeX fallback, makecookbook-doc.tex:16-26)
- Look carried by: preamble (mycookbook/cb-preamble.tex, a zip-local file that the sample `\input`s at mycookbook/makecookbook.tex:12; the README states that no class or package is shipped, README.txt:18-20)
- Class origin: tex-distribution-unbundled (`book` for the cookbook, mycookbook/makecookbook.tex:11; `article` for the manual, makecookbook-doc.tex:12; neither is in the zip)
- Main file: mycookbook/makecookbook.tex (other samples: makecookbook-doc.tex, which is the manifest's main file but is a manual in `article`; chapter files mycookbook/tex/cb-frontmatter.tex, mycookbook/tex/cb-chapterA.tex, mycookbook/tex/cb-chapterB.tex)
- Read: main yes, zip-local classes and styles none present (the zip has no .cls, .sty, .def, .cfg, .clo or .bst; I read in full the 762-line zip-local preamble mycookbook/cb-preamble.tex, mycookbook/cb-lettrine.cfl, mycookbook/cb-idxstyle.ist, the three chapter files, makecookbook-doc.tex (1818 lines) and README.txt; the two PDFs and two JPGs were not read)

## Verdict
no. The look is a 762-line zip-local preamble (no class, no style), and most of it reduces to published ways: `fontspec`, `geometry`, `fancyhdr`, `titlesec`, `lettrine`, `tcolorbox`, `multicol`, `changepage`, `caption`, `hyperref`, `imakeidx`. Two things do not. The chef-hat and oven pictograms are hand-drawn TikZ pictures that the template uses like glyphs (ART). `\ChapterIntro` and `\RecipeStory` with their optional line count split a box with `\vsplit` and hold the rest back for `\FinishChapterIntro` and `\FinishRecipeStory`, which is a box algorithm no lib way expresses, and the sample calls it (BESPOKE).

## Blockers
- `ART/preamble` chef-hat pictogram: a 24-coordinate TikZ picture `\MakeChefHat` saved in `\HatBox` and used as an inline glyph by `\ChefNote` and in the `ChefNotes` box (mycookbook/cb-preamble.tex:144-147, 526, 534-582; used mycookbook/tex/cb-chapterA.tex:51, 68-70, 225)
- `ART/preamble` oven pictogram: TikZ rectangles and circles `\MakeOven` saved in `\OvenBox`, printed after every `\PreheatC` and `\PreheatR` (mycookbook/cb-preamble.tex:149-151, 253-254, 584-598; used mycookbook/tex/cb-chapterA.tex:51, 225, 339)
- `ART/preamble` the same chef-hat picture copied into the manual's own preamble (makecookbook-doc.tex:58-61, 113-165; shown by the `ChefNotes` demo, makecookbook-doc.tex:1188-1191)
- `ART/preamble` title-page TikZ drawing (rule plus two nodes) `\MakeTitlePage`; it sits in the `\ifMakeCookbook\else` branch, which is off by default (`\MakeCookbooktrue`, mycookbook/cb-preamble.tex:21), so it does not decide the verdict; listed because the template ships it (mycookbook/cb-preamble.tex:600-620)
- `BESPOKE/preamble` `\ChapterIntro[n]` and `\FinishChapterIntro`: text is set in `\vbox\IntroBox`, `\vsplit\IntroBox to #1\dimexpr\CIntroFontBaseline` prints n lines, the rest waits in the box (mycookbook/cb-preamble.tex:329-351); the sample uses the optional argument (mycookbook/tex/cb-chapterB.tex:18, 23)
- `BESPOKE/preamble` `\RecipeStory[n]` and `\FinishRecipeStory`: the same `\vsplit` on `\StoryBox` with `\StoryBoxA` (mycookbook/cb-preamble.tex:389-413); used with `[8]` and `[0]` (mycookbook/tex/cb-chapterA.tex:199, 246, 252, 352)

## Class setting
- Class: `class.book` options: `11pt` (mycookbook/makecookbook.tex:11). The manual uses `class.article` options: `10pt` (makecookbook-doc.tex:12).
- Class-native vocabulary used: book: `\frontmatter` `\mainmatter` `\backmatter` (mycookbook/makecookbook.tex:15, 18, 22), `\chapter`, `\tableofcontents`, `\include`, `\leftmark`, `\if@mainmatter` inside a footer field (mycookbook/cb-preamble.tex:221), `\chaptertitlename` (mycookbook/cb-preamble.tex:228), `\indexname` (mycookbook/cb-preamble.tex:758), `\@idxitem` (mycookbook/cb-preamble.tex:189), and the kernel `plain` page style, which the preamble redefines (mycookbook/cb-preamble.tex:208). Roman numbering in the front matter and arabic in the main matter come from `\frontmatter` and `\mainmatter`. Article (manual): `\title` `\author` `\and` `\maketitle` `\part` `\section` (makecookbook-doc.tex:184-192).

## Component map
Paths are relative to Source/0492-makecookbook/. Rows 1 to 36 are the cookbook (`mycookbook/`), rows 37 to 53 the manual.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| 1 document class | mycookbook/makecookbook.tex:11 | `class.book` | `11pt` |
| 2 file structure | mycookbook/makecookbook.tex:12, 16, 19-20, 23 | `struct.input` | `\input{cb-preamble}`, `\include{./tex/cb-frontmatter}`, `\include{./tex/cb-chapterA}`, `\include{./tex/cb-chapterB}` |
| 3 page geometry | mycookbook/cb-preamble.tex:163-182 | `page.geometry` | draft: `paper=letterpaper`, `layoutsize={8in,10in}`, `layouthoffset=0.25in`, `layoutvoffset=0.5in`, `showcrop`; final: `papersize={8in,10in}`; both: `nomarginpar`, `bindingoffset=0.375in`, `inner=0.5in`, `outer=1in`, `top=0.75in`, `bottom=1in`, `footskip=40pt` |
| 4 page flush | mycookbook/cb-preamble.tex:11 | `pg.flush` | `\raggedbottom` |
| 5 line-breaking slack | mycookbook/cb-preamble.tex:12 | `sp.lengths` | `\emergencystretch 3em` |
| 6 microtype | mycookbook/cb-preamble.tex:46 | `sp.microtype` | package defaults |
| 7 text fonts | mycookbook/cb-preamble.tex:45, 50-59, 74-85, 101-105 | `font.fontspec` | `\setmainfont{ebgaramond}` and `\setsansfont{lato}` with `Extension=.ttf`, `UprightFont=*-regular`, `ItalicFont=*-italic`, `BoldFont=*-bold`, `BoldItalicFont=*-bolditalic`, `FontFace={sb}{n}{*-semibold}`, `{sb}{it}`, Lato also `{k}{n}{*-black}`, `{k}{it}`, `Ligatures=TeX`, `Numbers=Lining`; `\newfontfamily\MyScriptFont{Italianno}` with `Extension=.otf`, `UprightFont=*-Regular-OTF`, `Ligatures=TeX` |
| 8 custom font series | mycookbook/cb-preamble.tex:108-111 | `font.nfss` and `mark.kernel` | `\fontseries{sb}\selectfont`, `\fontseries{k}\selectfont`; `\DeclareTextFontCommand{\textsb}`, `{\textk}` |
| 9 font roles | mycookbook/cb-preamble.tex:114-128, 154-159 | `font.size-commands` and `mark.kernel` | `\fontsize{14}{16.8}` (chapter intro), `{13}{15.6}` (story), `{9}{11}` (copyright), `{14.4}{18}` (chapter label, title-page author), `{40}{48}` (chapter title, title), `{24}{29}` (recipe name); `\sffamily\sbseries`, `\sffamily\bfseries\itshape`, `\rmfamily\scshape`, `\rmfamily\Large\bfseries` |
| 10 fractions | mycookbook/cb-preamble.tex:131-132 | `font.fontspec` | `\addfontfeatures{Fractions=On}` around each `a/b` |
| 11 glyph shortcuts | mycookbook/cb-preamble.tex:135-140 | `sp.manual-space` | `\char176`, `\char169`, `\char8226`, `\char183` are plain characters (content); `\CtrDots` is three centre dots with `\kern 0.2em` |
| 12 colours | mycookbook/cb-preamble.tex:235-247 | `color.xcolor` | `\definecolor` of 12 names: `cmyk` white and true red (`0,1,1,0`), `rgb` tip `1,0.95,0.95` and frame `0.75,0,0`, cheffy frame `0,0,0.75`, notes frame `0,0.75,0`, `gray` 0.25 for both drop-cap colours |
| 13 drop caps | mycookbook/cb-preamble.tex:197-200; mycookbook/cb-lettrine.cfl:17-42 | `sp.lettrine` | hooks `\LettrineFontHook` (script font, `clrLettrineBig`), `\LettrineTextFont` (`\FontLettrineText`, `clrLettrineSmall`), `\DefaultOptionsFile{cb-lettrine.cfl}`; per letter A to Z `loversize=0.15`, `findent`, `nindent`, `depth=1` for G Q Z; calls `\lettrine{T}{his is the}` (mycookbook/tex/cb-chapterA.tex:20) |
| 14 empty pages | mycookbook/cb-preamble.tex:203 | `pg.emptypage` | load only |
| 15 footers | mycookbook/cb-preamble.tex:206-223; mycookbook/tex/cb-frontmatter.tex:11, 58 | `hf.fancyhdr` and `hf.pagestyle-kernel` | `\fancypagestyle{plain}` and `{main}`: `\fancyhf{}`, `\headrulewidth 0pt`, `\footrulewidth 0.2pt`, `\fancyfoot[RO,LE]{Page \thepage}`, `main` adds `\fancyfoot[CE,CO]{\if@mainmatter\leftmark\fi}`; `\pagestyle{empty}` then `\pagestyle{main}` after the contents |
| 16 chapter heading | mycookbook/cb-preamble.tex:226-230 | `head.titlesec` | `\titleformat{\chapter}[display]{\filleft\FontChapterLabel}{\chaptertitlename\ \thechapter}{1pt}{\titlerule\vspace{1ex}\raggedleft\FontChapterTitle}`; `\titlespacing*{\chapter}{0pt}{20pt}{20pt}` |
| 17 title page | mycookbook/cb-preamble.tex:628-639; mycookbook/tex/cb-frontmatter.tex:12 | `front.titlepage-env` and `sp.manual-space` | hand-laid: `\noindent\vspace{144pt}`, `center`, title in `\FontTitlepageTitle`, `\vspace*{\fill}`, author in `\FontTitlepageAuthor`, `\vspace{40pt}`, `\clearpage` |
| 18 copyright page | mycookbook/cb-preamble.tex:306-308, 651-652; mycookbook/tex/cb-frontmatter.tex:14-46 | `front.dedication` | environment `CopyrightPage`: `\FontCopyrightPage`, `\parindent 0pt`, `\vspace*{\fill}`, `\clearpage`; text lines, `\hrule` (mycookbook/tex/cb-frontmatter.tex:31) |
| 19 dedication | mycookbook/cb-preamble.tex:654-657; mycookbook/tex/cb-frontmatter.tex:48-52 | `front.dedication` and `sp.rule` | `\hrule\vspace{5pt}` text `\vspace{5pt}\hrule`; an optional verso page, empty by default |
| 20 contents | mycookbook/tex/cb-frontmatter.tex:57 | `toc.kernel` | `\tableofcontents` |
| 21 recipe name and yield | mycookbook/cb-preamble.tex:356-386 | `idx.makeidx`, `meta.bookmark`, `xref.hyperref`, `sp.ragged` | keys `Name` `NoIdxName` `IndexA..C` `XRefLabel` `Yield` become up to four `\index{}` calls, one `\pdfbookmark`, one `\phantomsection\label`, then `center` with `\FontRecipeName` and `\textit{yield}` |
| 22 chapter intro | mycookbook/cb-preamble.tex:329-351 | none (BESPOKE/preamble) | `\vbox` plus `\vsplit`; see Blockers |
| 23 recipe story | mycookbook/cb-preamble.tex:389-413 | none (BESPOKE/preamble) | `\FontRecipeStory`, `\leftskip=\rightskip=20pt` plus `\vsplit`; see Blockers |
| 24 ingredients and steps columns | mycookbook/cb-preamble.tex:416-474 | `cols.multicol`, `page.adjustwidth`, `font.size-commands` | `multicols{2}`; `\adjustwidth{-w}{-w}` (`changepage[strict]`); optional keys scale `\fontsize{10.95}{13.6}` by a ratio (0.92 in mycookbook/tex/cb-chapterA.tex:254) |
| 25 ingredient list | mycookbook/cb-preamble.tex:492-496 | `sp.lengths` and `sp.ragged` | `\parskip 2pt`, `\raggedright`, `\hangindent1em` per paragraph |
| 26 step list | mycookbook/cb-preamble.tex:498-503 | `list.enumitem` | `enumerate[itemsep=2pt plus 1pt minus 1pt, parsep=0pt plus 1pt, topsep=4.5pt plus 2pt minus 1pt, leftmargin=*]` |
| 27 ingredient heading | mycookbook/cb-preamble.tex:477-483 | `mark.kernel`, `color.xcolor`, `sp.manual-space` | `\FontIngTitle\color{clrIngTitle}`, `\parindent 0pt`, `\vspace{#1 pt}` before and `\vspace{#3 pt}` after (defaults 0 and 2) |
| 28 attribution | mycookbook/cb-preamble.tex:310 | `sp.manual-space` and `mark.kernel` | `\hspace*\fill` then `\textit{}` |
| 29 note boxes | mycookbook/cb-preamble.tex:506-528 | `box.tcolorbox` | `\tcbset{fonttitle=\FontTitleColorBox}`; `Tip`: `colback=clrBackTip`, `colframe=clrFrameTip`, `title=Food for Thought`; `Cheffy`: `clrBackCheffy`, `clrFrameCheffy`, `title=Let's Get Cheffy`; `ChefNotes`: `clrBackNotes`, `clrFrameNotes`, `title=Chefnotes`, body starts with the chef-hat glyph |
| 30 pictograms | mycookbook/cb-preamble.tex:534-598 | `art.tikz` (ART) | `\MakeChefHat` scale 0.05, width 12.5pt; `\MakeOven` scale 0.2666, width 18pt; see Blockers |
| 31 two-image figure | mycookbook/cb-preamble.tex:705-734; mycookbook/tex/cb-chapterB.tex:22 | `fig.graphicx`, `box.minipage`, `cap.caption`, `sp.ragged`, `sp.manual-space` | `\graphicspath{{img/}{../img/}}`; `figure[htb]`, two `minipage[c]{0.49\textwidth}`, `\includegraphics[width=0.97\textwidth]`, `\hfill`; `caption[skip=2pt, labelformat=empty, font={rm,it}]`, `justification=centering` |
| 32 links and bookmarks | mycookbook/cb-preamble.tex:737-751 | `meta.hyperref`, `meta.bookmark`, `xref.kernel`, `xref.hyperref` | `hyperref[bookmarks=true, colorlinks=true, allcolors=clrHyperRef]`, `bookmark`; `\pdfbookmark[1]`; `\phantomsection\label{recipe:#1}`; `\pageref` |
| 33 recipe index | mycookbook/cb-preamble.tex:185-193, 753-761; mycookbook/cb-idxstyle.ist:14-16; mycookbook/makecookbook.tex:23 | `idx.makeidx`, `sp.rule`, `sp.lengths`, `pg.break`, `toc.kernel` | `imakeidx`, `\makeindex[options=-s cb-idxstyle]` with `delim_0..2 "\\betterdotfill "`; dot leader `\cleaders\hb@xt@ .44em{\hss .\hss}\hskip .5em plus 1fill`; `\hangindent 10pt`; `\cleardoublepage`, `\addcontentsline{toc}{chapter}{\indexname}`, `\printindex` |
| 34 draft-only packages | mycookbook/cb-preamble.tex:37-39 | `draft.todo` | `lipsum` (filler, called at mycookbook/tex/cb-frontmatter.tex:62); `layout` is loaded but never called in the sample |
| 35 build variants | mycookbook/cb-preamble.tex:21-25 | none (an emitter prints one branch) | `\newif` `\ifMakeCookbook` (true), `\ifCookbookDraft` (true), `\ifHyperRef` (true) |
| 36 helper text macros | mycookbook/cb-preamble.tex:250-272 | none (inline expansion of content) | `\Tbl`, `\tsp`, `\Pd`, `\Ounce`, `\Degrees`, `\AxB`, `\Inch`, `\Quote`, `\Recipe`, `\nl`, `\SeparateParagraphs`, `\EditNote` expand to words, `\thinspace`, `\color{clrEditNote}` |
| 37 manual class | makecookbook-doc.tex:12 | `class.article` | `10pt` |
| 38 manual fonts | makecookbook-doc.tex:14, 16-26 | `font.fontspec`, `font.fontenc-t1`, `font.lmodern` | `fontspec` under LuaTeX or XeTeX, else `[T1]{fontenc}` and `lmodern`; `textcomp` |
| 39 manual geometry | makecookbook-doc.tex:28-35 | `page.geometry` | `inner=1.0in`, `outer=1.0in`, `top=0.75in`, `bottom=1in`, `nomarginpar`, `footskip=40pt` |
| 40 manual sub-sub-section spacing | makecookbook-doc.tex:37-38 | `head.titlesec` | `\titlespacing{\subsubsection}{15pt}{5pt}{5pt}` |
| 41 manual section counter | makecookbook-doc.tex:40, 170 | `num.counters` | `chngcntr`, `\counterwithin*{section}{part}` after `hyperref` |
| 42 manual verbatim | makecookbook-doc.tex:64-65 | `code.verbatim` | `fancyvrb` `\DefineVerbatimEnvironment{MyVerbatim}{Verbatim}{fontsize=\small, fontseries=b, xleftmargin=17pt}`, `MyVerbatimNums` adds `numbers=left` |
| 43 manual colours | makecookbook-doc.tex:67-76 | `color.xcolor` | the cookbook palette plus `clrBackSideNote`, `clrFrameSideNote` |
| 44 manual boxes | makecookbook-doc.tex:78-107 | `box.tcolorbox` | `fonttitle=\rmfamily\large\bfseries`; `SideNote`, `Tip`, `Cheffy`, `ChefNotes` |
| 45 manual fractions | makecookbook-doc.tex:109-111 | `math.nicefrac` | `xfrac` `\sfrac{#1}{#2}` |
| 46 manual links | makecookbook-doc.tex:167-168, 172-176 | `meta.hyperref`, `meta.bookmark` | same options as row 32; `\pdfstringdefDisableCommands` |
| 47 manual title and contents | makecookbook-doc.tex:184-188 | `front.maketitle`, `toc.kernel` | `\title{..\NL..}`, `\author{.. \and ..}`, `\maketitle`, `\tableofcontents` |
| 48 manual sectioning | makecookbook-doc.tex:190-192 | `head.kernel` | `\part`, `\section`, `\subsection`, `\subsubsection` |
| 49 manual lists | makecookbook-doc.tex:291-309, 318 | `list.kernel` and `list.enumitem` | `description`; `itemize[label=\textbullet, leftmargin=*, itemsep=1pt, parsep=1pt]` |
| 50 manual table | makecookbook-doc.tex:213-219 | `tbl.tabular` | `array` column spec `>{\bfseries} l | >{\itshape}l | l | l`, `\hline` |
| 51 manual footnote | makecookbook-doc.tex:234 | `fn.kernel` | `\footnote` |
| 52 manual labels | makecookbook-doc.tex:179, 224 | `xref.kernel` and `xref.hyperref` | `\MyLabel` is `\phantomsection` plus `\label`; `\pageref` |
| 53 manual chef hat | makecookbook-doc.tex:113-165 | `art.tikz` (ART) | same picture as row 30 |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\MakeChefHat`, `\ChefHat`, `\ChefNote` | mycookbook/cb-preamble.tex:144-147, 534-582 | no (ART) | hand-placed TikZ coordinates; no declarative way draws it |
| `\MakeOven`, `\Oven` | mycookbook/cb-preamble.tex:149-151, 584-598 | no (ART) | same |
| `\MakeTitlePage` (inactive branch) | mycookbook/cb-preamble.tex:602-619 | no (ART) | TikZ rule and nodes; not compiled by default |
| `\ChapterIntro`, `\FinishChapterIntro`, `\IntroBox` | mycookbook/cb-preamble.tex:329-351 | no | `\vsplit` to a computed number of lines and a deferred box; a call without the optional argument would reduce to `font.size-commands` text, but the sample uses the argument |
| `\RecipeStory`, `\FinishRecipeStory`, `\StoryBox` | mycookbook/cb-preamble.tex:389-413 | no | same; without the argument it is `\FontRecipeStory`, `\leftskip=\rightskip=20pt` (`sp.lengths`) |
| `\BakeUntil` (pgfkeys family, `\newcount`, `\ifcase`) | mycookbook/cb-preamble.tex:275-303; one call at mycookbook/tex/cb-chapterA.tex:348 | yes | output is plain text only ("Bake about 30-45 minutes"); the call expands inline, as the lib's v4 note on the rejected `sp.xspace` does; the verdict does not rest on it. It allocates a new `\newcount` on every call (mycookbook/cb-preamble.tex:287-288) |
| `\IngredientsAndSteps` and its pgfkeys family, `\fpeval` scaling, `\RenewDocumentCommand` of the font roles | mycookbook/cb-preamble.tex:420-474 | yes | wrapper of `cols.multicol` (2), `page.adjustwidth` and `font.size-commands`; the emitter computes `10.95*ratio` and `13.6*ratio` itself (0.92 gives about 10.07 and 12.51); the `RaggedCols` key is read into a macro but never used |
| `\ListIngredientsAndSteps`, `\IngredientsList`, `\RecipeSteps`, `\ProcessIngList`, `\IngredientsHeading` (xparse `\SplitList{\par}`) | mycookbook/cb-preamble.tex:477-503 | yes | each blank-line paragraph becomes one `\hangindent1em ...\par` line or one `\item` in rows 25 to 27 |
| `\InsertHiddenLines` (`\loop`, `\phantom{.}\par`) | mycookbook/cb-preamble.tex:317-326; used mycookbook/tex/cb-chapterA.tex:99, 139, 384; mycookbook/tex/cb-chapterB.tex:102 | yes, with a caveat | `\columnbreak` of `cols.multicol` at the same place, which the sample's own comment suggests (mycookbook/tex/cb-chapterB.tex:102); blank padding lines and a column break differ when the first column is not full |
| `\RecipeNameAndYield` | mycookbook/cb-preamble.tex:356-386 | yes | row 21 expanded per call; the `\ifx...\empty` tests become "emit if present" |
| `\SideBySide` (pgfkeys, `\ifx\LeftText\empty`) | mycookbook/cb-preamble.tex:709-734 | yes | row 31 expanded per call, caption only when text is given |
| `\Font...` role macros | mycookbook/cb-preamble.tex:114-128 | yes | aliases of rows 7 to 9; expand them at the call |
| `\sbseries`, `\kseries`, `\textsb`, `\textk` | mycookbook/cb-preamble.tex:108-111 | yes | row 8 |
| `\fr`, `\frx` (delimited `#1/#2 `) | mycookbook/cb-preamble.tex:131-132 | yes | `{\addfontfeatures{Fractions=On}1/2}` per use |
| glyph shortcuts `\TextDegree` ... `\CtrDots` | mycookbook/cb-preamble.tex:135-140 | yes | characters ° © • · and `\kern 0.2em` |
| `\betterdotfill`, `\@idxitem`, `cb-idxstyle.ist` | mycookbook/cb-preamble.tex:188-193; mycookbook/cb-idxstyle.ist:14-16 | yes, with a caveat | `\cleaders` over a one-dot box is a dots-only leader (`sp.rule`); `\@idxitem` sets `\hangindent 10pt` (`sp.lengths`) and the authors call it unnecessary (mycookbook/cb-preamble.tex:189); the manual says plain `\dotfill` fails for some entry widths (makecookbook-doc.tex:707), so the match is by type, not by output |
| `Tip`, `Cheffy`, `ChefNotes` environments | mycookbook/cb-preamble.tex:509-528 | yes | `box.tcolorbox` with the colours and titles of row 29; they are written with begin code only, so the end code is the token that follows (the blank line, a `\par`), read from the source, not tested |
| `CopyrightPage`, `\MyTitlePage`, `\MyDedication`, `\DedicationVerso`, `\ColophonFonts`, `\CopyrightInfo` | mycookbook/cb-preamble.tex:306-308, 628-657 | yes | rows 17 to 19; the text is content |
| `\RecipeBookmark`, `\RecipeLabel`, `\RecipePageNo`, `\CookbookIndex`, counter `ctrRecipe` | mycookbook/cb-preamble.tex:741-761 | yes | `\pdfbookmark[1]{name}{Recipe<n>}` with n counted at emit time; the test `\ifx\%1\empty` compares `\%` with `1`, so it is always false and every recipe gets a bookmark (mycookbook/cb-preamble.tex:743) |
| build switches `\ifMakeCookbook`, `\ifCookbookDraft`, `\ifHyperRef` | mycookbook/cb-preamble.tex:21-25, 37-39, 49-99, 165-174, 624-702, 737-748 | yes | the emitter prints one branch (the default values are all true) |
| helper text macros (`\Tbl` ... `\EditNote`, `\ThreeLines`) | mycookbook/cb-preamble.tex:253-272, 311-315 | yes | inline expansion; the text is content |
| manual macros `\latex`, `\tex`, `\pkg`, `\Cmd`, `\boldit`, `\RedText`, `\Quote`, `\NL`, `\MyLabel` | makecookbook-doc.tex:43-56, 179 | yes | aliases of `mark.kernel`, `color.xcolor`, `xref.hyperref` |

## Content-opaque
- Recipe, story, ingredient and step text, ISBN and publisher lines (mycookbook/tex/cb-chapterA.tex:24-413, mycookbook/tex/cb-frontmatter.tex:14-46).
- Two sample photos in a figure: mycookbook/img/image-a.jpg and image-b.jpg, called at mycookbook/tex/cb-chapterB.tex:22 (shipped).
- `lipsum` filler (mycookbook/tex/cb-frontmatter.tex:62, mycookbook/tex/cb-chapterA.tex:20, 25).
- Missing assets, not blockers: EB Garamond, Lato and Italianno are loaded by file name and are not in the zip (README.txt:98-106); the other branch asks for Adobe Garamond Pro and Myriad Pro, which cannot be shipped (mycookbook/cb-preamble.tex:61-70, 87-98).
- Run order: the index needs a `makeindex` pass with `cb-idxstyle.ist` (mycookbook/cb-preamble.tex:193), the same tool call every `idx.makeidx` document needs; not counted as EXTERNAL.

## Lib changes
- New ways proposed: none. Considered and not proposed: `layout` (load only, never called), `xfp`, `pgfkeys`, `xparse` (all three only inside the bespoke macros above), `ifluatex` and `ifxetex` (engine tests in the manual, no printed effect, like the rejected `sys.compat-load`).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
- Notes: README.txt:2 holds a stray line "sdfsfsf"; it is not an instruction and nothing in the zip addresses an AI. The manifest names makecookbook-doc.tex as main, but that is the manual; the cookbook template is mycookbook/makecookbook.tex plus cb-preamble.tex, and I analysed both.
