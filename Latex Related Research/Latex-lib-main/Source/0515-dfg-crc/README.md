# dfg-crc — Collaborative Research Centre proposal class

Current release: **0.3.0 (2026-10-20)**.

The `dfg-crc` LuaLaTeX class provides the proposal and CV structure for a
German Research Foundation (DFG) Collaborative Research Centre (CRC). It uses
structured metadata to generate project heads, staff and funding tables,
project lists, collaboration plots, Gantt charts, and proposal-wide totals.

This is an independent, unofficial template. It is not published, endorsed,
or maintained by the DFG; applicants remain responsible for checking the
current DFG forms and programme rules.

The PDF manual combines this introduction with the detailed user and code
documentation. Release history is kept separately in `CHANGELOG.md`.

The supplied proposal template is designed for five calendar years and
supports one or more applicant universities. The project types `research`,
`service`, `mgk`, and `admin` are supported; see the documentation for the
corresponding metadata and generated sections.

It is appreciated when in the colophon of your proposal a reference to this
template and its author is given.

## Requirements

The class requires LuaLaTeX and a LaTeX kernel dated 2022-06-01 or newer.
Biber is required for bibliographies. The default setup uses Noto Serif,
Roboto, and the example images supplied by the `mwe` bundle. A full
[TeX Live](https://tug.org/texlive/) installation is recommended and contains
the class's runtime dependencies.

Repository: <https://gitlab.git.nrw/rpdm/projects-and-services/dfg-crc-template>

Issue tracker:
<https://gitlab.git.nrw/rpdm/projects-and-services/dfg-crc-template/-/issues>

## Installation

TeX Live and MiKTeX installations obtained after the first CTAN release can
install `dfg-crc` through their normal package managers. To install from the
CTAN source archive manually, run:

```
luatex crc-proposal-documentation-and-code.ins
```

This generates `dfg-crc.cls`. Move it into a directory searched by TeX, or
keep it beside the proposal's main `.tex` file. The complete generated example
proposal is maintained in the repository and can be extracted with
`make files`.

## Start the program from the repository

For a first local compile, generate the derived files and then compile the
proposal and CV examples from the `local/` folder.

```
make files
cd local
latexmk -lualatex crc-proposal.tex
latexmk -lualatex crc-cv.tex
```

The class is designed for LuaLaTeX. Use `lualatex` or `latexmk -lualatex`;
do not call `LaTeX` with a capital `L`.

Two-sided pages reserve 30 mm on the binding edge by default: a 25 mm inner
margin plus `BCOR=5mm`. Pass a different KOMA `BCOR` class option to adjust
the binding correction; `BCOR=8mm` gives 33 mm on the inner edge and a 157 mm
text block. The default 160 mm text block leaves a 20 mm outer margin for the
rotated thumb index and marginal notes.
The 20 mm top and 15 mm bottom margins give the text block 5 mm more height
than the previous 20 mm margins; the footer remains included in the page layout.
By default, the thumb-index tabs span the text block from top to bottom and
divide its current height into equal slots. Set `thumbindex@topmargin` or
`thumbindex@bottommargin` to a page-edge distance to override either end.
Use `\changeSettings{thumbindex@orientation=inwards}` to turn the labels
180 degrees towards the text block. The default `outwards` points the tops
of the letters towards the outer page edge on both left and right pages.
Labels sit 2 mm towards the text block from the center of each tab.
Numbered section and subsection titles start at the same horizontal position
after a shared 12 mm number column. Section, subsection, and subsubsection
headings have one baseline of space above them; following text starts on the
next line without an additional blank line.

Useful make targets:

> `make files`: extracts `dfg-crc.cls` and the local template files from
the documented source. <br>
> `make update-class TARGET_DIR=/path/to/proposal-worktree`: regenerates and
copies only `dfg-crc.cls` into a separate Git worktree. <br>
> `make update-all TARGET_DIR=/path/to/proposal-worktree`: rebuilds and copies
`dfg-crc.cls`, `crc-proposal-documentation-and-code.pdf`, and the standalone
`dfg-crc-proposal-example.pdf` and `dfg-crc-cv-example.pdf` into that worktree. <br>
> `make test`: compiles the generated template test document. <br>
> `make test-direct-costs`: compiles the focused two-pass regression for DFG
> table 2.1.1. <br>
> `make test-workpackage-references`: compiles the focused nested-work-package
reference and range-formatting regression. <br>
> `make test-aim-references`: checks custom aim labels, forward references,
plural references, ranges, and list option scope. <br>
> `make test-bibliography-highlights`: checks frame and project entry
highlighting, font sizes, options, and isolation from ordinary lists. <br>
> `make proposal-example`: compiles the generated local proposal example. <br>
> `make cv-example`: compiles the generated local CV example. <br>
> `make check`: runs the test and compiles both examples. <br>
> `make proposal-doc-example`: builds the complete documentation consortium proposal in final
mode as `dfg-crc-proposal-example.pdf`. <br>
> `make cv-doc-example`: builds the complete twelve-PI CV appendix in final
mode as `dfg-crc-cv-example.pdf`. <br>
> `make doc`: builds both PDFs first, then includes all their pages in the user
documentation, followed by the implementation reference. <br>
> `make ctan-check`: builds the curated CTAN archive and verifies a clean
installer extraction and minimal LuaLaTeX compile. <br>
> `make ctan-validate`: runs the official online CTAN validator without
submitting the archive.

For a focused project-text build, select the project with `\includeonly` and
use these class options:

```tex
\documentclass[
  fastcompile-project=true,
  fastcompile-project-show-images=false,
  fastcompile-project-show-publications=false,
  fastcompile-project-show-funding-tables=true,
  english
]{dfg-crc}
```

`fastcompile-project` skips metadata loading and most `\addEntry` execution,
calculated project heads, generated tables/lists and plots, embedded graphics,
and other front-matter work while retaining authored sections,
paragraphs, aims, work packages, labels, and citation commands. Skipped
generated tables and lists retain the same visible placeholder and
log note as ordinary `fastcompile` builds. Project identifiers in focused
fast compilation are red typewriter placeholders such as <A03>. Set
`fastcompile-project-show-images=true` to load the project metadata and render
images and generated plots encountered in the selected project while retaining
the other fast-mode reductions. Set
`fastcompile-project-show-publications=true` when the selected project's publication headings,
explicit `\nocite` entries, and bibliography should be included. Use
`\printProjectBibliography` for project publication lists; plain
`\printbibliography` uses biblatex's normal font and bypasses the
project-publication switch.

To use footnote-sized text and remove extra space between bibliography entries,
add this hook to `preamble/dfg-customization.tex` (outside `\changeSettings`):

```latex
\AddToHook{package/biblatex/after}{%
  \renewcommand*{\bibfont}{\normalfont\footnotesize}%
  \setlength{\bibitemsep}{0pt}%
}
```

The hook waits until `biblatex` has loaded because the customization file is
read earlier. `\bibitemsep` controls the extra gap between entries; change
`0pt` to `2pt`, for example, for a small gap. It does not change line spacing
within an entry. Without an override, the bibliography style supplies its
spacing; the alphabetic styles inherit the standard list gap (4 pt plus
2 pt minus 1 pt in the default 10 pt setup). The CV's custom `DFGlist` already
uses `nosep` and is configured separately through its `itemsep` list option.

With `emphasizeEntries=true`, a full project bibliography entry is bold when
its `.bib` keywords include the current project ID followed by `-highlight`,
for example `B06-highlight`. One such keyword is enough even if two PIs from
Project B06 coauthor the entry. An entry may also carry another project's
highlight keyword when it should be bold in that project's list. The
`B06-project` keyword is optional project metadata; it does not trigger bold
type. Other keywords, including CV selectors such as `pabst-A`, can remain in
the same field. To use only whole-entry highlighting, set
`emphasizeAuthors=false` and `emphasizeEntries=true`.

For the frame-text references in chapter 1, use `\printFrameBibliography`
with the same options as `\printbibliography`. With `emphasizeEntries=true`,
entries tagged `frametext-highlight` are bold in this list. Project-specific
highlight keywords do not affect it, and the normal bibliography font size
is preserved. For example:

```latex
\changeSettings{emphasizeEntries=true}
\defbibnote{frame-references}{%
  \usekomafont{subsection}%
  \bfseries\sffamily References
}
\printFrameBibliography[prenote={frame-references},heading=none]
```

The `.bib` entry may combine keywords, for example
`keywords = {pabst-A,B06-highlight,frametext-highlight}`. The keyword selects
formatting only; cite the entry or use `\nocite` to include it as usual.
Existing chapter 1 files need the command replacement above because template
updates preserve edited chapter files.

Wrap optional
metadata and front matter with `\dfgIfFastCompileProjectF{...}` so those files
are not even read in this mode. With publications disabled, bibliography source
files and stale `.bbl` data are also left unread; inline citations display their
keys as lightweight drafting markers. The three project-local funding tables
remain visible by default. Set
`fastcompile-project-show-funding-tables=false` to suppress them too. Focused
mode processes their local rows and sums but does not restore or populate
proposal-wide overview databases. Compile a document using these options
with its own build command; the template Makefile deliberately operates only on
the generated test and example documents in `local/`.

## Template validation workflow

Run `make check` to regenerate the template files, compile the test document,
and compile both local examples. Run `make all` to perform those checks and
build the complete implementation and user documentation. These targets use
only files maintained or generated by this repository.

GitLab CI runs the same compile-based checks for branches and merge requests.
After a successful default-branch pipeline, GitLab Pages publishes the newest
generated `local/crc-proposal.pdf`. The Pages site is rebuilt from an empty
`public/` directory each time and therefore exposes only the latest dummy
proposal, not an archive of earlier PDFs. CI job artifacts retain the current
logs and example outputs temporarily for diagnosing failed pipelines.

## Updating a separate proposal repository

Edit the maintained `.dtx` source, then install the regenerated class into a
separately controlled proposal worktree:

```
make update-class TARGET_DIR=/path/to/proposal-worktree
# Or update the class, compiled manual, and complete example PDF:
make update-all TARGET_DIR=/path/to/proposal-worktree
```

Both targets verify that `TARGET_DIR` is the root of a different Git worktree,
copy the requested release files, and show their resulting Git status.
`update-class` copies only `dfg-crc.cls`; `update-all` first rebuilds the manual
and then copies the class, `crc-proposal-documentation-and-code.pdf`, and
`dfg-crc-proposal-example.pdf` and `dfg-crc-cv-example.pdf`. Neither
target overwrites the proposal repository's README, changelog, or licence. They
do not store the destination, inspect its remote, commit, or push. Review and
commit the updates from inside that proposal repository.

## Repository boundary

This repository is intentionally limited to the reusable proposal template.
Project-specific source, synchronization configuration, credentials, remote
identifiers, and private working copies must remain in separately controlled
repositories or local worktrees and must not be added here as submodules.

## Structure of the files and folders

The maintained source is `crc-proposal-documentation-and-code.dtx`.
Generated files such as `local/dfg-crc.cls`,
`local/test-existing-funds-direct-costs.tex`,
`local/test-project-collaboration.tex`,
`local/test-workpackage-references.tex`, `local/test-participating-institutions.tex`,
`local/test-command-options.tex`, `local/test-reference-lookups.tex`,
`README.md`, `CHANGELOG.md`, and the
local example files are extracted from that source.
Edit the `.dtx` for template or documentation changes, then regenerate the
derived files with `make files` or by building the documentation.

The manual uses `dfg-crc` itself, with `documentation=true` to load only its
explicit fictional fixtures. The DTX driver maintains executable `dfgExample`
boxes: code on the left, rendered output on the right. Add `[dfg wide]` for
wide results below their code. `make doc` regenerates the fixtures and compiles
the examples; incomplete setup fragments remain code-only. This does not
read or overwrite the manual scratch file `local/test.tex`.

The manual and local examples share the DTX `meta` records: twelve PIs, six institutions,
four affiliations, and fifteen active projects (A01--A06, B01--B06, Q01--Q03),
plus a former project. The embedded proposal uses these same metadata in
`local/`, with individual files for all fifteen active projects and the former
project A00. The local CV uses the same twelve PIs, with matching career records
and explicitly fictional publications for each person. Examples use `dfg project=A03` when they need the context
normally established by a project heading. Project overviews and the PI roster follow their code boxes at normal size
and may span pages; collaboration plots retain the available text width.

`make test-participating-institutions` checks flowing/raster column widths,
active-PI filtering, shared-institution deduplication, sorting, spacing above
columns, and option scope. `make test-command-options` checks omitted/empty,
leading/legacy options, precedence, grouped command specifications, mandatory
arguments, custom databases, boolean flags, and per-call defaults for lists,
tables, plots, and PI rasters. `make test-reference-lookups` covers generic
reference paths, branching ID lists, destination deduplication, diagnostics,
and focused-build placeholders.

The standalone regression document is maintained in `ci/test-template.tex`.
`make test` copies it to `local/test-template.tex` before compiling it.
`local/test.tex` is reserved for manual experiments and is neither generated
nor compiled by the template checks.

## Generated project templates

The generated `local/content/03_project.tex` is a small master file that loads
separate, complete project examples. They are intended to be copied and adapted
rather than reduced to a list of headings:

`03_project_A01.tex`: continuing research project (`project-status=C`).

`03_project_A02.tex`: new research project (`project-status=N`).

`03_project_B01.tex`: second continuing research-project example.

`03_project_B02.tex`: ending project (`project-status=E`), including the report
bibliography, the three published-result categories, and the staff roster for
the ending funding period.

`03_project_Q01.tex`: continuing service project.

`03_project_Q02.tex`: continuing Integrated Research Training Group
(`project-type=mgk`), including existing funds, fellowships, and global funds.

`03_project_Q03.tex`: central administrative project with its dedicated
documentation and funding structure.

Every example starts with `\printProjectHead{<id>}`. That command already
generates the general-information heading, project title, project leaders, and
the applicable contract and legal-information blocks from metadata. The source
files therefore begin with the first status-specific authored heading: `Summary`
for active projects and `Project history` for ending projects.

The generated proposal-wide example follows the February 2026 continuation
template, including the ecological-sustainability section, separate
coordinating and co-applicant universities, the current legal-issues wording,
and one rector, chancellor, or president signature per applicant university.

> `bib/`: all bibliography files.  <br>
> `content/`: all files which are part of the actual content of the proposal,
e.g. all project textfiles.  <br>
>  `figures`: folder contains all figures of the projects.  <br>
>  `img`: folder can be used for logo files etc.  <br>
>  `metadata`: if you collect all database entries in specific external
  files, they are placed in this folder (e.g. `dfg-metadata.tex`).  <br>
> `preamble`: all files for the proposal and CV setup, especially
  `dfg-customization.tex` for customized things or re-newed settings.<br>

## Minimal metadata relationship

Most commands resolve data by following ids through the small databases:

```
person.ref-institution-id -> institution.id
institution.ref-affiliation-id -> affiliation.id
project.collaborations -> project.id
```

For example, a person may list one or more institution ids in
`ref-institution-id`. Each institution points to its parent affiliation via
`ref-affiliation-id`. Once this relationship exists, commands such as
`\printList{{Institutions}{<person-id>}}` can print the institution and affiliation
data without further manual wiring.  Each institution can also provide an
`abbreviation`; generated table cells use this compact label while descriptive
lists and legends retain the full `name`.

The same relationship is reused by `RequestedFundingStaff`: when a staff row
contains `ref-person-id`, its category and institution are taken from the
person's `position` and `ref-institution-id` fields unless the staff row
explicitly overrides them. A row without `ref-person-id` must provide
`ref-institution-id`; otherwise the class warns because it cannot resolve the
institution or assign existing staff to an affiliation in the proposal-wide
overview. Existing non-research staff may omit `field-of-research`; that empty
table cell is then greyed out as not applicable without a warning. Empty
staff positions are omitted without a warning or an empty line. The job
descriptions printed below each requested-funding staff table use flush-left
number labels and a hanging indent so continuation lines align with the first
line of description text. A normal interword space separates the bold name
from the description.

Project collaboration plots follow the comma-separated project ids stored in
each project's `collaborations` field. Relations are undirected, so declaring
the same pair in both project rows is harmless but unnecessary. Ending,
reference-only, and list-excluded project rows remain available elsewhere but
are omitted from these plots.

## Information retrieval command overview

The following commands can be used directly in proposal text and tables. In
the signatures below, square brackets are optional and braces are mandatory.
The complete descriptions and examples are in
`crc-proposal-documentation-and-code.pdf`.

### General database access

Command `\get[database]{id}{field}` prints a metadata field. Add reference
steps to retrieve fields from linked rows, for example
`\get[person]{MM}{institution}{name}` or
`\get[person]{MM}{institution}{affiliation}{name}`. Each step follows
`ref-<database>-id`; the full key spelling is also accepted, as in
`\get[person]{MM}{ref-institution-id}{name}`. This works from any source
database, including named databases populated with a separate keyset.
Multiple reference IDs are followed in their stored order and the resulting
values are separated by commas. A destination row reached more than once is
printed only once; different rows with identical names remain separate.
Missing or empty references warn and contribute no value. The terminal field
keeps its formatting and `showtags` annotation. Focused fast compilation uses
the source ID placeholder, as with `\getEntry`. `\get*` retains the starred
multi-field assignment syntax of `\getEntry*`.

Command `\getEntry` with `[database]` `{id}` `{field}` `[id-field]` prints one field from one
  database row.

Starred command `\getEntry*` with `[database]` `{id}`
`{assignments}` `[id-field]` fetches several fields in one lookup and assigns
them without printing. For example, fetch person `MM` with
`\getEntry*[person]{MM}` and pass the third argument
`{\theFirstName=firstname,\theLastName=lastname}`.

Command `\compareEntry` with `[database]` `{id}` `{field}` `{value}` `{true}`
  `{false}` chooses text or
  code according to a field comparison.

### People, institutions, and projects

Commands `\getName` and `\getFullName*` with `{person-id}` print the last name or full name;
  the star adds the academic degree.

Command `\getPI*` with `{person-id-list}` `[text]` prints a linked PI reference; the star includes
  first names. Unstarred references distinguish shared PI surnames with the first given-name
  initial (K. Schneider / C. Schneider), or the full given name when initials also match.
  This rule applies across projects and funding periods, including project-first references.
  Explicit display text bypasses it; starred references retain full given names.

Command `\getORCiD` with `[database]` `{person-id}` prints a linked, formatted ORCiD from a person row.

Command `\getORCiDvalue` with `[database]` `{person-id}` stores the unformatted ORCiD in
  `\theORCiDValue`.

Command `\printList{{Institutions}{<person-id>}}` prints institutions and
  parent affiliations assigned to a person. Put formatting and database options
  before the specification, for example
  `\printList[database=person,abbreviation,narrow]{{Institutions}{MM}}`.

Command `\printList{ParticipatingInstitutions}` lists participating institutions
  across the proposal, with affiliation names in bold. Use `columns=2` (or
  `columns=3`, etc.) to flow whole affiliation groups down balanced columns.
  Short groups follow one another without being padded to the height of a
  neighbouring group. Groups stay together; reading order is down each column.
  `column sep=16pt` changes the gap (default: 12 pt). Flowing lists start a
  new paragraph with a medium vertical skip above the columns.
  The default layout remains a one-column raster, with 12 pt between columns
  and 10 pt between rows. For aligned rows, pass `raster columns=2` or another
  `tcbraster` option through the optional list argument. Sorting defaults to
  `order=count`; use `order=alpha` for alphabetical affiliation order. The
  legacy bare `count` and `alpha` options remain supported.

Put all list options before the specification, as with `\printPlot`.
Plain and grouped list names are both accepted. Older trailing options remain
supported; leading settings take precedence when the same key occurs twice.

```latex
\printList[columns=2]{ParticipatingInstitutions}
\printList[columns=3,column sep=16pt,order=alpha]{ParticipatingInstitutions}
\printList[order=alpha,raster columns=2]{{ParticipatingInstitutions}}
```

Command `\getPersonInformation` with `[database]` `{person-id-list}` prints complete formatted
  PI/contact-information blocks, with a 12 pt column gap in the two-column raster.

Command `\getPIsWithRole` with `[options]` `{role}` prints formatted current-period people
  carrying a given role. Put database and raster settings in the leading options,
  for example `\getPIsWithRole[database=person,raster columns=2]{PI}`.
  Use `\getPIsWithRole[academicdegree-below]{steering-committee-member}`
  to put the degree on a separate line below the name within the same PI box.
  The option applies only to that call; the default (or `academicdegree-below=false`)
  keeps the degree inline after the name.
  The default three-column raster has a 12 pt column gap;
  rows and the following content are separated by 20 pt. Explicit raster options
  can override that spacing.

PI-box titles are ragged right and top-aligned. All titles within one raster
reserve the height of its tallest title, so wrapped names or academic degrees
do not misalign the contact information. Recompile until the equal-height
layout settles; a clean build can require three LaTeX passes. Phone and email
stay individually unbroken, with a one-em gap that permits a line break
between them when they do not fit together.

Use `\getPIWithProject*` with `{person-id-list}` to print each PI with their
  assigned project identifiers in parentheses, without repeating the projects'
  PI names; the star includes first names. The older
  `\getPIProject` command remains available but warns that it is deprecated.

Use `\getProjectWithPI*` with `{project-id-list}` to print each project with
  its assigned PIs; the star includes first names. The older `\getProjectPI`
  command remains available but warns that it is deprecated. By default, the
  shared first `\getProject` or
  `\getProjectPI` reference to a project within one section includes its PIs;
  later references print only the project. Set
  `projectPIOncePerSection=false` in `\changeSettings` to repeat the PI names.

Command `\getPIofProject` with `[properties]` `{project-id}` `[delimiter]` prints selected PI name
  properties for one project. The starred form defaults to first and last names,
  separating earlier names with commas and only the last with “and”.

Command `\getProject*` with `{project-id-list}` `[text]` prints a linked project
  reference. The star always prints project identifiers only, independently of
  `projectPIOncePerSection`. Optional `text` replaces the displayed project number while
  retaining its link target and is best used with a single project. A
  reference-only project is marked and deliberately left unlinked. Multiple
  projects are joined with commas and a final `and` in prose, but use compact
  slash separators inside table cells, for example `A02/B01`. With the
  default `projectPIOncePerSection=true`, this command shares
  `\getProjectPI`'s first-reference PI expansion and per-section state.

Command `\getProjectCount` with `[area]` prints the active, list-considered
project count; omit `area` for all projects. Any explicit or ID-derived
`project-area` value is accepted.

Command `\printPlot{{collaborations}{A01}}` prints the default
full-width arc layout for A01, with project nodes and unlabelled area rules.
Its boxes align with the text edge on both sides of a two-sided page.
Its caption always appears below the plot; a final optional argument adds
caption text there.
Add `[arcs=true]` before the plot specification to draw the connecting arcs,
or use `[layout=heatmap]` for the heatmap. The optional
`project-area` field creates rows dynamically and falls back to the first
character of the project ID. Configure proposal-wide colors with
`collaborationAreaColors` and `collaborationAreaPalette` in `\changeSettings`,
or use the per-plot `area-colors` and `area-palette` options. Gantt charts use
the same dispatcher as `\printPlot{{gantt}{A01}}`. Inside a project, omit
the ID: `\printPlot{{gantt}}` and `\printPlot{{collaborations}}` use the
current project. Options precede the plot specification, for example
`\printPlot[caption={Additional details}]{{gantt}}` or
`\printPlot[arcs=true]{{collaborations}{B06}}`. With an explicit ID, use the
same leading caption option:
`\printPlot[caption={Additional details}]{{gantt}{B06}}`. The older `Gantt` and
`ProjectCollaboration` type names remain available. In project source files,
`caption={}` marks where optional caption text can be added to either plot;
left empty, the default caption is still printed.

Command `\dfgResearchAreasList` with `{code}` prints a DFG research-area code and its description.

Commands `\getAim` and `\getWP` with `[project-id]` `{id-list}`
  cross-references to project aims or work packages; the current project is
  the default. `\getWP` places a narrow, unbreakable space after `WP` or `WPs`.

The `aims` environment accepts a custom prefix shared by the numbered items
and references:

```tex
\begin{aims}[label={RDM Aims}]
  \addAim{data} Document research data.
  \addAim{reuse} Publish reusable datasets.
\end{aims}
See \getAim{data,reuse}.
```

This prints `RDM Aims 1:` and `RDM Aims 2:`, with `RDM Aims 1 and 2` in
the reference. `\cref` and `\Cref` also use the custom prefix. Its text is
used unchanged for single and multiple references; ordinary `aims` lists
retain `Aim`/`Aims`. Other list options, such as `start=3`, remain available.
Compile twice after changing labels to update forward references.

Use `resume` to continue numbering from the previous `aims` list. Repeat
the custom label to keep it in both the items and their cross-references:

```tex
\begin{aims}[label={RDM Aims},resume]
  \addAim{archive} Archive the datasets for long-term access.
\end{aims}
See \getAim{archive}.
```

Following the two-item list above, this prints `RDM Aims 3:` and references
it as `RDM Aims 3`. `[resume]` alone continues the number with the default
`Aim`/`Aims` prefix. Numbering resumes from the previous `aims` list,
regardless of its label text; custom labels do not create separate counters.

### Person statistics

Command `\getPositionGenderPhaseAmount` with `[database]` `{position}` `{gender}` `{period}` prints the number
  of people for one position/gender/period tuple.

Command `\getPositionPhaseTotal` with `[database]` `{position}` `{period}` prints the all-gender total for a
  position and funding period.

Command `\getGenderPhaseTotal` with `[database]` `{gender}` `{period}` prints the all-position total for a
  gender and funding period.

Command `\getPositionGenderPhasePercentage` with `[database]` `{position}` `{gender}` `{period}` prints the
  rounded integer percentage within one position.

Command `\getGenderPhasePercentage` with `[database]` `{gender}` `{period}` prints the rounded integer
  percentage across all counted positions.

The optional database defaults to `person`. Counts include people whose
`role` list contains `PI` and whose `period` list contains the requested
funding period. The total-row commands sum `postDoc`, `groupLeader`,
`prof-W2`, and `prof-W3`. Gender is `f`, `m`, or `d`; percentages are rounded
integers without a percent sign and return zero when the denominator is zero.

```tex
\getGenderPhaseTotal{f}{1}
\getGenderPhasePercentage{f}{1}\%
\getPositionGenderPhaseAmount{prof-W3}{f}{1}
\getPositionGenderPhasePercentage{prof-W3}{f}{1}\%
\getPositionPhaseTotal{prof-W3}{1}
```

Change the last argument to `2` or `3` to query another funding period.
These commands are available independently of the current proposal period.
Section 1.4.2 B adds the first-period Number and Percentage columns only for
proposals with `fundingPeriodNumeral = {3}`. Maintain historical PI records
with their appropriate `period` membership to populate these columns.
The statistics count people; the share of projects with female leadership
requires a separate calculation.

The project-leader table defaults to the female-only DFG layout. For a
third-period proposal, periods 1 and 2 each show Number/Percentage; period 3
shows its original objective (from `future-objective-percentage-female`) and
current Number/Percentage. The person records' period-3 membership supplies
these current counts. Percentages always use all genders as the denominator.
Select the expanded f/m/d comparison, including third-period counts and
percentages alongside its objective columns, for a single table:

```tex
\printTable{GenderEqualityProjectLeaders}            % female-only DFG view
\printTable[all-sexes]{GenderEqualityProjectLeaders} % expanded f/m/d view
```

Each call starts in female-only mode; `[all-sexes]` affects only that table.
Put options before the table name. Combine `database=MyObjectives,all-sexes`
to use a custom
objectives database. The prose count and percentage commands are unaffected.

### Funding and staff totals

The similarly named funding commands have different scopes: names ending in
`RequestedFunding` use the proposal-wide overview by default, while names
ending in `RequestedFunds` use project-level funding rows and require a
project id.

Command `\getCountRequestedStaff` with `[project]` `{year}` `{category}` prints the requested staff
  quantity for a category, optionally restricted to a project.

Command `\getSumRequestedFunding` with `[database]` `{year}` `{type}` prints the proposal-wide total for one
  funding type and one year; `{all}` as the year totals all five years.

Command `\getTotalSumRequestedFunding` with `[database]` `{year}` `{type}` prints the proposal-wide total
  with `{all}` as the type available for a grand total.

Command `\getSumPreviousRequestedFunding` with `[database]` `{year}` `{fields}` prints the previous-period
  total for one year row, or all rows with `{all}` as the year.

Command `\getSumRequestedFunds` with `[database]` `{project}` `{type}` `{sum-fields}` prints the project total
  for one funding type and one or several `sum-yearN` fields.

Command `\getTotalSumRequestedFunds` with `[database]` `{project}` `{sum-fields}` prints the project total
  across all funding types for the supplied `sum-yearN` fields.

Command `\getSumRequestedFundsInstrumentation` with `[project]` `{sum-fields}` prints the instrumentation
  total, proposal-wide or for the optional project.

Command `\getSumRequestedFundingDirectCosts` with `[database]` `{year}` `{group}` prints the direct-cost
  total for `applicant`, `participant`, `other-funds`, or `all`. Its default
  database is the auxiliary-file-backed
  `RequestedAndExistingFundingDirectCostsOverview`, and its displayed result
  is a full euro amount without decimal places.

Command `\getSumExistingFunds` with `[database]` `{project}` `{sum-fields}` prints the existing direct-cost
  funding for a project and the supplied year fields.

Typical calls are:

```tex
\getProjectCount[A]                            % active A projects
\getSumRequestedFunding{all}{staff}            % proposal-wide staff total
\getTotalSumRequestedFunding{all}{all}         % proposal-wide grand total
\getSumRequestedFunds{A02}{staff}{sum-year1}   % A02 staff total, year 1
\getTotalSumRequestedFunds{A02}{sum-year1}     % A02 grand total, year 1
```

Funding entries, including requested instrumentation, use EUR as their input
unit. Their tables state `Figures in EUR` and display whole euro amounts with
thousands separators. The non-aggregated `existingInstrumentation/cost` field
instead uses thousands of EUR and its table states `Figures in thousands`;
one decimal place is retained when supplied. Explicitly fractional
animal-housing rates also retain decimals, while the other monetary columns in
that table remain whole euros.

### Existing direct-cost support in section 2.1.1

Declare institutional and other existing direct-cost support once, next to
the corresponding project table:

```tex
\addEntry[funding]{RequestedAndExistingFundingDirectCosts}{
  ref-project-id     = {B06},
  ref-affiliation-id = {aff1},
  financed-by        = {Faculty core support},
  sum = {
    year1 = {5000},
    year2 = {5000},
    year3 = {5000},
    year4 = {5000},
    year5 = {5000}
  }
}
```

The sums are stored and displayed in euros. Table 2.1.1 therefore prints
`5000` as `5,000`; monetary values are rounded to the nearest euro for display
and never acquire a redundant decimal part. An affiliation listed in
`meta/crc.ref-affiliation-id` contributes to the applicant-university column;
another affiliation contributes to the other-participating-institutions
column; and the special value `other-funds` contributes to Other funds.
`financed-by` is the human-readable funding-source description and does not
select the aggregate column.

The declarations may remain in project files even though section 2.1.1 comes
earlier. They are restored into a separate overview database through the
LaTeX auxiliary files. A normal multipass build such as `latexmk` is therefore
required after adding or changing a row; no duplicate chapter-2 declaration
is needed.

## Open-access markers in bibliography entries

The class loads `biblatex-ext-oa` so bibliography entries can show
open-access markers in final documents. The DOI API integration is only
available with LuaLaTeX. With LuaTeX 1.17.0 or newer, the socket library must
also be enabled on the command line, for example with `lualatex --socket`.
Provide the contact address required by the API in the customization file:

```tex
\changeSettings{
  doiAPIMail = researcher@example.org
}
```

The class enables DOI lookups only when `final=true`, `doiAPIMail` is not
empty, and LuaSocket is available. Otherwise it retains manual open-access
annotations without making network requests.

If the API-based open-access request does not work for a publication, add the
manual fallback annotation to the relevant `.bib` entry:

```
options         = {openaccess=auto},
doi+an:default  = {=openaccess},
```

## Troubleshooting

Use `latexmk -lualatex ...` or `lualatex ...`. The command `LaTeX` asks TeX for
a format named `LaTeX.fmt` and will usually fail.

If you see `Not allowed in LR mode`, check whether vertical material such as
`\vspace`, `\addvspace`, or a paragraph break was inserted inside a table cell
that only accepts horizontal material. Prefer the documented commands and
options instead of adding raw vertical spacing in table cells.

`Unknown database name` means the requested database has not been loaded or the
database name was misspelled. Check the relevant file in `metadata/` and make
sure it is input by the document class.

Missing-key or empty-value warnings mean the row exists, but the requested
field is empty. This is intentional for fields where the template needs to
alert you, such as missing ORCiD values.

If a change has no visible effect, check which `dfg-crc.cls` is being used.
Regenerate the class and local examples with `make files`, then compile the
relevant example again.

## Maintainer release checklist

1. Update `\dfgVersion`, `\dfgVersionDate`, the README release line,
   changelog, and `dfg-crc.pkg` in one commit.
2. For CTAN updates after the initial release, set `\update{true}` in
   `dfg-crc.pkg`. Keep the CTAN path
   `/macros/luatex/latex/dfg-crc`, and omit `\home` when it duplicates
   the repository URL.
3. Do not include the generated `dfg-crc.cls` in the CTAN archive. CTAN
   requires files generated from a documented source and installer to be
   omitted; the PDF manual and example PDF are documentation exceptions.
4. Confirm that `bossert@itc.rwth-aachen.de` is registered as the second
   address of CTAN member `lukascbossert`. Keep release information in
   separate Announcement and Note fields; CTAN explicitly accepted that
   structure for the initial release.
5. Build the documentation and the CTAN archive, then run the portable
   installer and minimal-class smoke test:

   ```
   make ctan-check
   ```

6. Run at least one proposal/CV smoke build from `local/`:

   ```
   cd local
   latexmk -lualatex -g -halt-on-error crc-cv.tex
   ```

7. Before a public release, run the complete template check:

   ```
   make check
   ```

8. Run the official online validator with
   `make ctan-validate`.
9. Review `git status --short`, `git diff --check`, and the archive file
   list before committing and tagging the exact release version.

## Support

The current maintainer is
[Lukas C. Bossert](mailto:bossert@itc.rwth-aachen.de).

## License

This material is subject to the LaTeX Project Public License 1.3c or later.
The work has the LPPL maintenance status *maintained*. See `LICENCE.md` for the
complete notice.
