no

# 0327-melkassib-cv-generator-latex: cv-generator-latex (a Kotlin DSL that emits AltaCV and AwesomeCV résumés)

- Unverified: read from the source, not compiled.
- Source: Source/0327-melkassib-cv-generator-latex/ (origin: https://codeload.github.com/melkassib/cv-generator-latex/zip/refs/heads/main; licence: MIT, LICENSE:1)
- Kind: cv
- Lib: v3
- Engine: pdfLaTeX-compatible for the main sample (its `\else` branch, docs/examples/altacv/altacv-resume-example.tex:44-50, and the class author's own claim at :3); the second sample's first line names xelatex as its TeX program (docs/examples/awesomecv/awesomecv-resume-template.tex:1), so it is treated as XeLaTeX-only (its class is unread)
- Look carried by: class (the look is defined by the third-party class `altacv`, which is NOT in the zip; the sample preamble only sets geometry, fonts, colours and markers on it)
- Class origin: none (no class or style file in the zip; `altacv` and `awesome-cv` are GitHub-only third-party classes, ctan.org/pkg/altacv and ctan.org/pkg/awesome-cv both return 404, and this zip is not an official release of either)
- Main file: docs/examples/altacv/altacv-resume-example.tex (other samples: docs/examples/awesomecv/awesomecv-resume-template.tex; test copies src/test/resources/altacv/sample-resume.tex, sample-resume-empty.tex and src/test/resources/awesomecv/sample-resume.tex, sample-resume-empty.tex, which differ only in content values, separator and image path; the two `.pdf` outputs in docs/examples/ are binary and were not read)
- Read: main yes, zip-local classes and styles none present

## Verdict
The zip ships no `.cls`, `.sty` or other TeX support file: it is a Kotlin library whose string templates (src/main/kotlin/com/melkassib/cvgenerator/altacv/utils/AltaCVTemplate.kt:102-180, src/main/kotlin/com/melkassib/cvgenerator/awesomecv/utils/AwesomeCVTemplate.kt:74-107) reproduce the preambles of two third-party résumé classes, and its committed outputs are the samples. Neither class is published under W1 (CTAN pages are 404 although the control read `ctan.org/pkg/paracol` exists; GitHub-only per README.md:59-60 and 303-305; the zip is a third party's wrapper, not an official release) and neither is in the zip, so their code (`\cvevent`, `\wheelchart`, `\makecvheader`, photo handling, `\cventry`, `\makecvfooter`) cannot be read to show it reducible. Everything the sample itself writes (geometry, paracol, colours, font packages, one alias macro) reduces to lib ways, but the look lives in the unpublished class, so the answer is `no`. The zip is also close to NOTEMPLATE (a generator with no template of its own); if the project replaces such zips, this one should be replaced.

## Blockers
- `UNMAPPED/class` the class `altacv` carries the whole look and is neither on CTAN (404) nor in TeX Live nor in the zip, so no W1 way exists and its source is unreadable (docs/examples/altacv/altacv-resume-example.tex:17)
- `UNMAPPED/class` the class `awesome-cv` (second sample) has the same status, and its sample names xelatex as the TeX program (docs/examples/awesomecv/awesomecv-resume-template.tex:19, :1)

## Class setting
- Class: `altacv` (no way id, it fails W1) options: `10pt`, `a4paper`, `ragged2e`, `withhyper`, `normalphoto` (docs/examples/altacv/altacv-resume-example.tex:17). Second sample: `awesome-cv` options `11pt`, `a4paper` (docs/examples/awesomecv/awesomecv-resume-template.tex:19).
- Class-native vocabulary used, altacv: `\name`, `\tagline`, `\personalinfo{...}` with `\email` `\phone` `\mailaddress` `\location` `\homepage` `\xtwitter` `\linkedin` `\github` `\orcid` and `\NewInfoField` (:96-113), `\makecvheader` (:146), `\columnratio` (:151), `\cvsection`, `\cvevent`, `\divider`, `\wheelchart`, `\cvachievement`, `\cvtag`, `\cvskill`; hooks `\namefont` `\personalinfofont` `\cvsectionfont` `\cvsubsectionfont` `\cvItemMarker` `\cvRatingMarker` `\cvDateMarker` `\cvLocationMarker` (:67-78); colour slots `tagline` `headingrule` `heading` `accent` `emphasis` `body` (:59-64); engine switch `\ifxetexorluatex` (:32).
- Class-native vocabulary used, awesome-cv: `\photo[rectangle,noedge,right]`, `\name{}{}`, `\position`, `\address`, `\mobile`, `\email`, `\homepage`, `\github`, `\linkedin`, `\gitlab`, `\twitter`, `\skype`, `\reddit`, `\medium`, `\stackoverflow`, `\googlescholar`, `\extrainfo`, `\quote` (:50-69), `\makecvheader[C]` (:75), `\makecvfooter` (:79-82), `\cvsection`, `\cvsubsection`, `\cventry`, `cvparagraph`, `cvitems`, `cvhonors`, `\cvhonor`, `\setbool{acvSectionColorHighlight}` (:40), `\acvHeaderSocialSep` (:43), colour `awesome-orange` (:27).

## Component map
Paths: ALTA = docs/examples/altacv/altacv-resume-example.tex; AWES = docs/examples/awesomecv/awesomecv-resume-template.tex. Rows other than the class rows name the lib way the construct would belong to; they stand only if the class itself is accepted, which is the blocker.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class (altacv) | ALTA:17 | none (UNMAPPED, fails W1) | `10pt,a4paper,ragged2e,withhyper,normalphoto` |
| document class (awesome-cv) | AWES:19 | none (UNMAPPED, fails W1) | `11pt, a4paper` |
| paper and size | ALTA:17; AWES:19 | `page.class-options` | 10pt, a4paper (ALTA); 11pt, a4paper (AWES) |
| page geometry | ALTA:22 | `page.geometry` | left=1.25cm, right=1.25cm, top=1.5cm, bottom=1.5cm, columnsep=1.2cm (`\geometry` is called without `\usepackage`, so the class loads it; class unread) |
| page geometry (second sample) | AWES:22 | `page.geometry` | left=1.4cm, top=.8cm, right=1.4cm, bottom=1.8cm, footskip=.5cm |
| two parallel columns | ALTA:25, 151, 155, 212, 271 | `cols.paracol` | `\columnratio{0.6}`, `paracol{2}`, `\switchcolumn` |
| ragged text | ALTA:17 | `sp.ragged` | class option `ragged2e` |
| links | ALTA:17, 26 | `meta.hyperref` | class option `withhyper` plus `\usepackage{hyperref}` with no options |
| fonts, XeLaTeX/LuaLaTeX branch | ALTA:34-43 | `font.fontspec`, `font.family-default` | `\setmainfont[Path=fonts/Roboto_Slab/, UprightFont=RobotoSlab-VariableFont_wght.ttf]{Roboto Slab}`, `\setsansfont[Path=fonts/Lato/, UprightFont=Lato-Regular.ttf]{Lato}`, `\familydefault`=`\sfdefault` (font files not shipped) |
| fonts, pdfLaTeX branch | ALTA:46-49 | `font.helvet`, `font.family-default` | `\usepackage[rm]{roboto}`, `\usepackage[defaultsans]{lato}`, `\familydefault`=`\sfdefault` |
| colours | ALTA:53-57, 59-64 | `color.xcolor` | five `\definecolor{..}{HTML}{..}` (PastelRed 8F0D0D, GoldenEarth E7D192, DarkPastelRed 450808, SlateGrey 2E2E2E, LightGrey 666666), six `\colorlet` onto the class slots |
| colour (second sample) | AWES:27 | `color.xcolor` | `\colorlet{awesome}{awesome-orange}` (colour names defined by the class) |
| name, tagline | ALTA:96-97 | `front.class-native` | `\name{Your Name Here}`, `\tagline{...}` |
| contact block | ALTA:102-113 | `front.class-native`, `font.icons` | `\personalinfo{}` with nine contact fields; `\NewInfoField{gitlab}{\faGitlab}[https://gitlab.com/]` |
| header print | ALTA:146 | `front.class-native` | `\makecvheader` |
| header fonts | ALTA:67-68 | `front.class-native`, `font.size-commands`, `mark.kernel` | `\namefont`=`\Huge\rmfamily\bfseries`, `\personalinfofont`=`\footnotesize` |
| header block (second sample) | AWES:50-69, 75 | `front.class-native` | `\photo[rectangle,noedge,right]{profile}`, `\name{John}{Dupont}`, `\position`, 14 contact commands, `\quote`, `\makecvheader[C]` |
| header separator and section highlight | AWES:40, 43 | `front.class-native`, `head.class-native` | `\renewcommand{\acvHeaderSocialSep}{\quad\cdotp\quad}`, `\setbool{acvSectionColorHighlight}{true}` |
| footer (second sample) | AWES:79-82 | `hf.class-native` | `\makecvfooter{\today}{John Dupont ... Résumé}{\thepage}` |
| section headings | ALTA:69-70, 158 | `head.class-native`, `font.size-commands`, `mark.kernel` | `\cvsectionfont`=`\LARGE\rmfamily\bfseries`, `\cvsubsectionfont`=`\large\bfseries`, body `\cvsection{...}` |
| headings (second sample) | AWES:90, 129 | `head.class-native` | `\cvsection`, `\cvsubsection` |
| entry markers | ALTA:74-78 | `cv.entries`, `font.icons`, `font.size-commands` | `\cvItemMarker`=`{\small\textbullet}`, `\cvRatingMarker`=`\faCircle`, `\cvDateMarker`=`\faCalendar*[regular]`, `\cvLocationMarker`=`\faMapMarker*` |
| experience and education entries | ALTA:160, 169, 176, 258-269 | `cv.entries` | `\cvevent{title}{organisation}{dates}{location}` |
| entry bullets | ALTA:161-165 | `list.kernel` | `itemize` with `\item` and `\item[]` |
| entry divider | ALTA:167 | `cv.entries` | `\divider` |
| wheel chart | ALTA:200-206 | `cv.entries` | `\wheelchart{1.5cm}{0.5cm}{value/width/colour/text, ...}` (content-opaque, see below) |
| life-philosophy quote | ALTA:217-219 | `quote.kernel` | `quote` environment |
| achievements | ALTA:225-227 | `cv.entries`, `font.icons` | `\cvachievement{\faTrophy}{title}{detail}` |
| tags | ALTA:233-243 | `cv.entries`, `sp.manual-space` | `\cvtag{..}` with `\\` line breaks |
| skills | ALTA:249-252 | `cv.entries` | `\cvskill{German}{2.0}` and the alias `\cvskillstr{..}{..}` |
| page break in a column | ALTA:207 | `pg.break` | `\newpage` |
| entries (second sample) | AWES:100-123 | `cv.entries`, `list.kernel` | `\cventry{title}{organisation}{place}{dates}{body}`, `cvitems` environment |
| paragraph and honours (second sample) | AWES:92-94, 131-158 | `cv.entries` | `cvparagraph`, `cvhonors` with `\cvhonor{award}{event}{place}{date}` |
| spacing (second sample) | AWES:147 | `sp.manual-space` | `\medskip` |
| generator output (both) | src/main/kotlin/com/melkassib/cvgenerator/common/utils/Helpers.kt:60-69, 88-97 | none (the zip's own emitter, outside the emit model) | `\cvsection` per section; `escapeSpecialChars` backslash-escapes `_ # % & $ { }` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\newcommand{\cvskillstr}[2]` | docs/examples/altacv/altacv-resume-example.tex:81-84 | yes | alias of `mark.kernel` (`\textbf`), `color.xcolor` (`\textcolor{emphasis}`, `\color{body}`) and `sp.manual-space` (`\hfill`, `\par`); arguments are two content strings |
| `\ifxetexorluatex ... \else ... \fi` engine split | docs/examples/altacv/altacv-resume-example.tex:32-50 | yes | the conditional is the class's engine switch, not defined in the sample (class unread); an emitter writes one branch: `font.fontspec` + `font.family-default`, or `font.helvet` + `font.family-default` |
| `\NewInfoField{gitlab}{\faGitlab}[https://gitlab.com/]` | docs/examples/altacv/altacv-resume-example.tex:112 | yes, if the class is accepted | a call into the class's contact vocabulary with a symbol and a link-prefix string (`front.class-native`, `font.icons`) |
| class `altacv` | not in the zip | not shown (source unreadable) | UNMAPPED/class |
| class `awesome-cv` | not in the zip | not shown (source unreadable) | UNMAPPED/class |
| Kotlin DSL, Jackson serializers, Gradle build | src/main/kotlin/com/melkassib/cvgenerator/, build.gradle.kts | not part of the emit model | it turns JSON/YAML into the `.tex` samples (AltaCVTemplate.kt:39-75, AwesomeCVTemplate.kt:38-66, common/domain/ResumeSectionContent.kt:84-408); the committed `.tex` files compile without it, so it is not counted as EXTERNAL against the samples |

## Content-opaque
- `\wheelchart` data chart in the main sample (docs/examples/altacv/altacv-resume-example.tex:200-206): a class-drawn chart whose argument list is data; its drawing code lives in the unread class.
- Missing assets: `fonts/Roboto_Slab/` and `fonts/Lato/` (docs/examples/altacv/altacv-resume-example.tex:36, 40) and the image `profile` (docs/examples/awesomecv/awesomecv-resume-template.tex:50) are not shipped. The comment at docs/examples/altacv/altacv-resume-example.tex:31 gives an `xelatex -shell-escape` command line; whether the unread class needs shell escape is not established.

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
