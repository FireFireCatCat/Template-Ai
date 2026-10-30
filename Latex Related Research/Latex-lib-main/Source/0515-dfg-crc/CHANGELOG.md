## CHANGELOG
### 2026-10-20 version 0.3.0
- Add first-funding-period numbers and percentages, including gender breakdowns
  and totals, to the project-leader equality table in section 1.4.2 B, only
  for third-funding-period proposals. Document commands for the table values
  and keep the statistics cache consistent across grouped calls.
- Default to the DFG female-only project-leader overview, including third-period
  status-quo counts and percentages. Use
  `\printTable[all-sexes]{GenderEqualityProjectLeaders}` for f/m/d figures
  in all three periods, alongside the objective columns. Display options
  apply to one table, with options before the table name.

### 2026-10-20 version 0.2.18
- Update all seven standard salary defaults to the DFG personnel rates for
  2027, with matching documentation, template comments, and default checks.
- Add expandable `\getValue{key}` access to all customization settings,
  including live numeric rates, text, booleans, dimensions, and mode-specific
  bibliography aliases. Document formatting, local scope, and unknown-key
  errors; add regression coverage for all 72 settings.
- Sort the existing-instrumentation table by project ID, including alternate
  databases, while retaining shared equipment as a single row.

### 2026-10-16 version 0.2.17
- Add `\printFrameBibliography` for chapter 1 references. With
  `emphasizeEntries=true`, entries tagged `frametext-highlight` are bold;
  project highlights remain independent and the normal bibliography font
  size is preserved. Update the starter chapter and document the keyword.

### 2026-10-15 version 0.2.16
- Let `aims[label={RDM Aims}]` set the numbered item prefix and the name
  used by `\cref`, `\Cref`, and `\getAim`, independently for each list.
- Keep custom aim labels compatible with expl3 releases that do not
  provide the `\str_mdfive_hash:V` variant.

### 2026-10-15 version 0.2.15
- Keep project references inside `\getPIWithProject` and the legacy
  `\getPIProject` compact, so PI names are not repeated inside the project
  list. Starred forms still include first names, independently of
  `projectPIOncePerSection`.

### 2026-10-11 version 0.2.14
- Make validation warnings identify the rejected item, accepted values or
  required format, and whether the value is ignored, retained, or replaced.
  Fix funding-period and institution-order diagnostics and the animal-species
  choice list; require complete staff-funding category names.

### 2026-10-09 version 0.2.13
- Ignore surrounding spaces in research-area codes when processing project
  headings, overview tables, and individual research-area lookups.
- Keep the generated class header and footer filename as `dfg-crc.cls` in
  both development and release extraction, independent of the output directory.

### 2026-10-08 version 0.2.12
- Emit each legacy PI/project command's deprecation warning only once per
  LaTeX run, including repeated calls inside groups and lowercase aliases.
  Calls through the replacement commands remain warning-free.
- Use `\frontmatter` for Roman-numbered preliminary pages and `\mainmatter`
  before Chapter 1 to restart Arabic page numbering at 1. Existing proposal
  drivers need the same update because template update targets preserve them.
- Narrow the first column of `OverviewExistingStaff` from `X[4,l]` to
  `X[3,l]`, retaining equal-width institution columns. Break the junior
  research group leader label before "leaders". Maintain this in the DTX
  class source rather than a proposal customization override.
- Add the proposal workspace's standalone `test-overview-staff.tex` layout
  test: 85 complete fictional staff records, seven categories, and nine real
  affiliations. It uses an isolated database, documents a two-pass LuaLaTeX
  build, and has been checked in the rendered PDF.

### 2026-10-07 version 0.2.11
- Add lowercase aliases for PI and project commands, including
  `\getpiwithproject`, `\getprojectwithpi`, and `\getpiofproject`, preserving
  starred forms, optional arguments, formatting, links, and legacy warnings.
- Accept the mixed spellings `\getPIwithProject`, `\getProjectwithPI`, and
  `\getPIOfProject` alongside the canonical command names.
- Prevent tables printed immediately after headings from overlapping them at
  natural page breaks; `\printTable` adds a guarded `\null\nobreak`.

### 2026-10-02 version 0.2.10
- Show field-name placeholders for missing staff metadata in fast compilation,
  and render fast database and project references as red typewriter
  placeholders such as <person-id>.
- Add the opt-in fastcompile-show-tags option. When enabled, fast reference
  annotations identify the source row and requested lookup path, including
  project-number lookups.
- Add ID-oriented person-first and project-first PI references; warn when the
  older getPIProject and getProjectPI commands are used.
- Let PIReferenceFirstName make unstarred getPI, person-first PI/project
  references, and getPIofProject include first names. Project-first references
  continue to use last names unless starred.

### 2026-10-02 version 0.2.8
- Let an explicit empty `positionText` in a `RequestedFundingStaff` row
  suppress the person's prefilled position; omitted values still inherit it.

### 2026-09-27 version 0.2.7
- Allow `color@reference@PI=current` to inherit the surrounding text color
  in PI references; named colors and the black default remain supported.
- Document the customization hook for footnote-sized bibliographies with
  `\bibitemsep=0pt`, explaining inherited entry spacing and the separate
  compact CV publication list.
- Move thumb-index labels 2 mm towards the text block on both page sides,
  preserving tab dimensions and placement for either label orientation.
- Explicitly center project identifiers vertically in the project overview.
- Embed the second Gantt stripe colour in the PDF pattern so macOS viewers
  render it correctly; retain per-chart palette changes and stripe geometry.
- Add one baseline of space above section, subsection, and subsubsection
  headings; continue body text on the next line without an extra blank line.
  Document the existing paragraph breaks before and after `\printTable`.
- Add `thumbindex@orientation=outwards|inwards` to `\changeSettings`.
  Keep outward-facing labels by default; inward-facing labels turn 180 degrees
  on both left and right pages without changing tab placement.

### 2026-09-18 version 0.2.6
- Expand all twelve example CVs with three career stages, all five optional
  sections, two fictional category-A articles, and a category-B dataset each.
  Rebuild the standalone CV appendix and its framed inclusion in the manual.
- Link each name printed by `\getPIofProject` (including its starred form)
  to the PI table, using the same target and reference styling as `\getPI`.
- Add `\getPIofProject*` for full PI names joined with commas and a final
  “and”; explicit properties and a custom final separator remain supported.
- Use one shared consortium dataset for the local proposal, local CV appendix,
  and manual: twelve PIs, six A projects, six B projects, and three Q projects.
  Generate individual project files and career/optional CV records for every PI,
  with explicitly fictional publication examples selected by person keywords.
- Add rendered Gantt examples for all five bar styles, a custom colour palette,
  and grayscale fills/patterns. Explain preamble-wide colour settings versus
  grouped changes for a single chart, with links from the relevant descriptions.
- Build the embedded proposal from the manual's shared project and PI metadata:
  six A projects, six B projects, three Q projects, and twelve PIs. Include
  every active project chapter and use former project A00 for the ending-project
  example, keeping B02 new as declared in the documentation.
- Embed the complete final-mode CV appendix beside the proposal example and
  distribute its standalone PDF through the documentation build, CTAN archive,
  CI artifacts, and `update-all`. Frame and label every imported CV page.
- Add stable labels to rendered example boxes and clickable example references
  to command and environment descriptions, including the CV entry points.
- Make `dfgLocation`, `dfgDate`, `dfgTitle`, and `InfoTeX` available before
  customization is loaded and configurable through `\changeSettings`.
  Preserve pre-class definitions and direct redefinitions; replace the fixed
  submission date with the generic `\providecommand{\dfgDate}{<date>\xspace}`.
- Reorganize the manual into shared commands, a proposal-order walkthrough,
  and a separate metadata/configuration reference. Introduce record creation,
  lookup, reference traversal, and dispatcher syntax before specialised output.
- Consolidate repeated galleries and shared PI/project metadata; keep rendered
  examples beside their explanations and retain all built-in table/list/plot
  targets. Explain new, continuing, ending, and reference-only projects and
  distinguish status from service, training, and administration project types.

### 2026-09-17 version 0.2.5
- Include the complete fictional starter proposal as a chapter in the manual
  and distribute its standalone PDF. Show imported pages at 82% size inside a
  frame, with a separate-document label and the manual page number outside.
  Generate its final-mode wrapper
  from the DTX; `make doc` builds the proposal before importing every page.
- Complete the rendered gallery for all built-in table, list, and plot targets,
  including female-researcher objectives, project-leader participation, all
  finance overviews, animal upkeep, filtered research areas, and plot aliases.
  Group examples in proposal order and show the input records for each new table.
- Restore page breaking for wide example boxes after disabling side-by-side
  layout; allow long input listings and table results to continue across pages.
- Expand the complete A06 funding example to all five funding groups: staff,
  direct costs, fellowships, global funds, and instrumentation. Show annual
  amounts and a one-off equipment purchase, with combined yearly totals.
- Add six complete funding/personnel examples: existing and requested equipment,
  doctoral candidates, named staff and vacancies, annual staff quantities, and
  existing direct-cost funding. Show every input record and explain units,
  ongoing/completed doctorates, and the custom-database table option.
- Add practical live examples for branching metadata lookups, person statistics,
  staff counts, nested and cross-project references, contact
  cards, bibliographies, research areas, applicant wording, rules, and signatures.
  Show the funding records and the salary setting in the requested-funding
  example. Extract the complete input records for project and PI table examples
  from the same DTX fixtures. Render table results outside their code boxes.
  Demonstrate the project-status legend, automatic funding-period wording, and
  research-area list with its DFG classification footnote.
- Expand the independent manual fixtures to six active A projects, six B
  projects, three Q projects, twelve PIs, six institutions, and four affiliations.
  Include continuing/new research, service, training, administration, and a
  former-project reference. Add live examples throughout the command reference,
  including PI/project links, project counts, names, institution options, role
  cards, metadata retrieval, and project/PI overview tables.
- Demonstrate explicit and current-project collaboration/Gantt plots, layout
  aliases, connecting arcs, captions, and area colours. Add live `TableEnv`
  column/row options, aim/work-package references, signatures, figures, and
  publication results. Give repeated plot examples unique figure labels.
- Nest individual generated-file descriptions beneath a shared implementation
  section, including the customization file and the documentation fixtures.
- Typeset the manual with `dfg-crc` itself and add executable code/result
  examples for metadata lookups, references, lists, contact cards, boxes,
  tables, and collaboration plots. Use stacked output for wide examples.
- Add opt-in `documentation=true` to load manual fixtures explicitly, without
  importing proposal customizations, metadata, or default bibliography files.
  Generate all documentation fixtures from the DTX.

### 2026-09-17 version 0.2.4
- Add `\get[database]{id}{relation}{field}` for generic `ref-<database>-id`
  traversal, including multi-step paths, multiple IDs, destination deduplication,
  explicit reference-key spellings, and direct/starred lookup compatibility.
  Keep final-value formatting and destination `showtags` annotations. Preserve
  stored ID order, separate results with commas, and warn without emitting
  dangling separators when a branch cannot be resolved.
- Retain database keyset information when focused builds skip metadata rows,
  so shorthand reference paths are consumed correctly for custom databases too.
- Add 33 reference-lookup regression cases to `make check`, including custom
  keysets, multiple IDs, shared destinations, finite cyclic paths, missing data,
  direct/starred compatibility, and focused-build placeholders. Check rendered
  separators and duplicate removal in the PDF when Poppler is available.

### 2026-09-17 version 0.2.3
- Add flowing, balanced participating-institution columns with `columns=2`,
  `columns=3`, etc., and configurable `column sep` (12 pt by default).
  Keep each affiliation and its institutions together, without equal-height
  row padding. Retain `raster columns` for aligned rows and reset layout and
  sorting options for each call.
- Start flowing institution lists with a paragraph break and a medium vertical
  skip. Remove the extra 7 pt gap between an affiliation heading and its
  institutions; retain 10 pt between affiliation groups.
- Recognize parent and nested work packages together in `\getWP`, preserving
  hierarchical sorting and range boundaries, including lists such as
  `\getWP{wp1a,wp1b,wp2,wp3a,wp3b}`.
- Include project-local existing direct costs in focused fast-build totals,
  instead of displaying zero; retain accumulation across multiple funding rows.
- Default `biblatexstyleFeatureProposal` to empty, so changing bibliography
  styles does not implicitly pass the unsupported `dashed=false` option.
- Prevent tables from overlapping preceding text by ending paragraphs before
  `\printTable`, using a shared 6 pt gap, and removing negative spacing from
  `TableEnv` and its captions.
- Reserve `local/test.tex` for manual experiments. Maintain the general
  regression document in `ci/test-template.tex` and compile its copy as
  `local/test-template.tex`; extraction and automated checks leave the manual
  file untouched.
- Add 30 command-option checks and 10 participating-institution layout cases
  to the DTX and `make check`, covering defaults, empty/leading/legacy options,
  precedence, grouped names, arguments, databases, boolean flags, PI rasters,
  column widths and gaps, spacing, sorting, filtering, and duplicate removal.
  Extend funding and work-package regressions for the corrected cases and
  retain the new test logs and PDFs as CI artifacts.
- Install Poppler utilities for CTAN checks and report missing PDF-inspection
  tools before running the installation test. Refine ChkTeX suppressions for
  expl3 bracket parsing and TikZ coordinate syntax.

### 2026-09-17 version 0.2.2
print fast-compilation project identifiers in bold black while retaining error colours
add a 7 pt gap below affiliation headings in participating-institution boxes
standardize leading options for lists and role-based PI rasters, combining
sorting, formatting, database selection, and layout before the main argument
while retaining compatible trailing options and grouped list names
add configurable raster columns and spacing to participating-institution lists,
with one affiliation per cell and compatible count/alphabetical sorting

### 2026-09-17 version 0.2.1
align PI-box titles ragged right and reserve the tallest title's height
throughout each raster, keeping the contact information aligned after wrapping
increase the default column gap to 12 pt in both PI rasters
allow a line break between phone and email while keeping each contact intact
and retaining the one-em gap when both fit on the same line
print affiliation names in bold in `\printList{ParticipatingInstitutions}`

### 2026-09-14 version 0.2.0
typeset fenced README code in the PDF manual with a monospaced verbatim font
align the default thumb-index stack with the current text block, dividing
`\textheight` into equal tabs while retaining explicit page-edge margin settings
print person-specific institutions through `\printList{{Institutions}{id}}`
throughout the class and examples, retaining `\dfgInstitutionList` as an alias
show `\printPlot` as the Gantt command in the manual and clarify the distinct
thumb-index show, hide, and reset operations
accept lowercase plot types with or without a project ID, including
`\printPlot{{gantt}{B06}}` and `\printPlot{{collaborations}{B06}}`
open the user documentation with an overview of the proposal template and
move log-message guidance into troubleshooting
keep the changelog as a separate generated file instead of including it in
the documentation PDF

### 2026-09-14 version 0.1.8
bold entire project bibliography entries tagged `<project-id>-highlight`
when `emphasizeEntries` is enabled, without affecting other project lists
document that one highlight keyword per distinct project is enough even when
several PIs from that project coauthor an entry
align numbered section and subsection titles in a shared 12 mm number column
increase the default text height by 5 mm with 20 mm top and 15 mm bottom margins,
without changing the inner binding or outer note margins
separate each staff member's name from the job description with a normal space
move the text block 5 mm toward the binding by using 25 mm inner and 20 mm
outer margins without changing its width or the binding correction
remove the trailing blank Gantt row and leave a very small gap before its
bottom rule

### 2026-09-14 version 0.1.7
place collaboration-plot captions below the image with or without optional
caption text, matching the Gantt-chart caption layout

### 2026-09-14 version 0.1.6
reserve binding space with the configurable `BCOR` option (5 mm by default),
while keeping a 160 mm text block and fitting notes into the narrower outer margin
give thumb-index tabs regular rounded corners and rotated labels that fit the
outer marginal column on both sides of a two-sided page
separate the `WP` or `WPs` prefix from work-package numbers with a narrow,
unbreakable space while retaining sorted and compressed references
remove project-area letters below collaboration-plot nodes and show connecting
arcs only when `arcs=true` is requested; align wide plots with the text edge
on both sides of a spread
omit empty staff positions without warnings, placeholders, or extra lines;
align numbered staff descriptions with a hanging indent
tighten heading, caption, project-header, legal-issue, PI-card, bibliography,
and aims-box typography and spacing
reduce the shared gap above generated tables to 4 pt and match dashed Gantt
vertical grid lines to the horizontal rule colour
place Gantt captions below the chart whether or not additional caption text
is supplied, keeping the default `Fig.` label visible
abbreviate English figure caption labels to `Fig.`
keep direct-cost table headings with their tables at page boundaries
use the footnote-sized project bibliography wrapper for project reports and
published-result lists

### 2026-09-07 version 0.1.5
apply the default table font size at theme scope so cell-local declarations
such as `font=\bfseries` retain `\footnotesize`, while explicit size
declarations remain available as overrides
document the table-font inheritance and override behaviour

### 2026-09-04 version 0.1.4
add `make update-all` to rebuild and copy both the generated class and manual
PDF into a separately controlled proposal worktree
allow existing non-research staff to omit `field-of-research` without a
warning or a missing-value placeholder, and grey out the empty cell as not
applicable
keep the `to` connector in compact `\getWP` ranges at normal font weight and
retain references to nested work packages under later parent work packages,
with focused regression coverage
warn when a `RequestedFundingStaff` row omits both `ref-person-id` and
`ref-institution-id`, because its institution cannot otherwise be resolved
render staff job descriptions as itemized lists with consistent indentation
make the generic `TableEnv` options argument genuinely optional by defaulting
it to an empty option list
make `ProjectLeadersTable` follow `projectsTableInstitutionAbbreviations` when
choosing full institution names or abbreviations, with regression coverage
increase the default vertical spacing between and after rows of PI boxes
printed by `\getPIsWithRole`

### 2026-08-07 version 0.1.3
allow generated plots in focused project builds when
`fastcompile-project-show-images=true`, retaining the project metadata they need
make the collaboration arc diagram the default project-collaboration plot, with
an `arcs=false`/`no-arcs` option and explicit heatmap selection
add the unified `\printProject` command for project heads and tails while
retaining the original commands as compatibility interfaces
give PI, work-package, and aim references independent configurable colours
format generic table body text consistently at footnote size, including
table-cell content that overrides theme row settings
correct collaboration-plot colour propagation, width and node placement, and
support suppressing connecting arcs without suppressing project nodes
document singular/plural-sensitive contract-question wording and avoid a
documentation-driver list-label dimension overflow

### 2026-08-03 version 0.1.2
default |\ProjectsTable| to full institution names and refine the optional abbreviation mode with small, table-local, alphabetically sorted legends containing only the institutions used in each table
warn when one institution abbreviation denotes different institution names, and retain the corrected non-empty legend check
treat |id| as a database-local unique key: a later |\addEntry| with the same identifier warns, removes every earlier matching row, and becomes the stored entry
tighten the former-project legend spacing, vertically center project identifiers, and add release regressions for the new defaults and duplicate-ID replacement

### 2026-08-03 version 0.1.1
add the |projectsTableInstitutionAbbreviations| setting to choose compact institution abbreviations with a full-name legend or full institution names without a legend in |ProjectsTable|
make |resetThumbIndex| public so manually separated document parts can restart the thumb-index sequence
document the new ProjectsTable display setting, the public thumb-index reset command, and the post-0.1.0 CTAN update procedure

### 2026-08-03 version 0.1.0
harden dynamic collaboration plots and project-area counts, preserve deterministic row and edge order, keep inactive nodes white, and add configurable colors for arbitrary project areas
suppress redundant zero decimal parts in numeric and EUR output while preserving explicitly fractional values
populate the section 2.1.1 direct-cost overview from project-local existing-funds declarations, classify applicant affiliations from the CRC metadata, present aggregated monetary table values as full integer euros with the note “Figures in EUR”, retain informational existing-instrumentation costs as “Figures in thousands”, and preserve decimals for those costs and explicit animal-housing rates
restore siunitx model alignment in guarded tagged numeric columns and use compact slash-separated project references inside table cells while retaining natural-language joins in prose
prepare the first CTAN release with a portable installer, synchronized release metadata, explicit LPPL 1.3c licensing, reproducible archive and clean-install checks, and CI release artifacts

### 2026-08-02 version 0.0.53
generate collaboration heatmap and arc-diagram rows dynamically from project areas, support optional project-area metadata with ID-prefix fallback, cycle colors for additional areas, and document the resulting behavior

### 2026-08-02 version 0.0.52
release the complete project-template, funding-calculation, TOC, and converter updates, including half-year staff-cost calculation, compact project TOC numbers, complete active-project examples, and focused regression coverage

### 2026-08-02 version 0.0.51
generate a self-contained project-collaboration regression file from the DTX, extend the dummy proposal metadata with explicit collaboration, list, ending, and reference-only cases, show both collaboration plot calls in the dummy project chapter, and document the collaboration metadata relationship and dispatcher syntax
keep project numbers compact in the table of contents so section titles retain their normal indentation
apply half-year factors to automatically calculated staff costs in years 1 and 5, test the resulting four-year salary total across five funding columns, and show both automatic and explicit staff-cost entries in every active generated project example and converted project template

### 2026-08-02 version 0.0.50
add compact project-collaboration heatmaps and equal-peak arc diagrams with labeled nodes, tight project-area rules, ending/reference-only filtering, and hvFloat captions, a common plot dispatcher for collaboration and Gantt graphics, mirrored marginal leaders, and safe expansion of funding-source metadata

### 2026-08-02 version 0.0.49
keep table marginalia fixed to their row anchors, place them safely in the outer margin, and format their sums consistently

### 2026-08-01 version 0.0.48
add running marginal totals to the central funding overview tables and keep marginal annotations inside the page

### 2026-08-01 version 0.0.47
omit redundant zero decimal parts from monetary values in the requested-funding project table

### 2026-08-01 version 0.0.46
forward the xparse no-value sentinel correctly so |\getProjectPI| works in focused project builds

### 2026-08-01 version 0.0.45
make |\getProject| share the first-reference PI expansion and per-section state of |\getProjectPI| when |projectPIOncePerSection=true|

### 2026-08-01 version 0.0.44
move the two alternating provenance-label levels closer together

### 2026-08-01 version 0.0.43
omit an empty staff academic degree cleanly instead of displaying and warning about a missing value

### 2026-08-01 version 0.0.42
keep alternating provenance labels strictly zero-width, zero-height, and zero-depth so they never alter prose line spacing or table-row height

### 2026-08-01 version 0.0.41
distinguish multiple unnamed staff vacancies by their role metadata when checking requested-funding rosters for duplicates

### 2026-08-01 version 0.0.40
alternate successive provenance tags across two vertical levels and reserve table-cell headroom so rules do not obscure the labels
make the CI build portable to minimal runners that do not provide an external |time| command

### 2026-08-01 version 0.0.39
show project PIs only on the first |\getProjectPI| reference to each project per section by default, with a configurable opt-out

### 2026-08-01 version 0.0.38
join comma-separated project references from |\getProject| as a natural-language list

### 2026-08-01 version 0.0.37
add compile-based GitLab CI validation and a latest-only Pages deployment of the local dummy proposal
extract generated files with plain LuaTeX so clean CI clones need neither a pre-generated installer nor a full documentation build

### 2026-08-01 version 0.0.36
mark reference-only projects with an asterisk and a local legend in generated tables and lists while retaining the explicit prose wording

### 2026-08-01 version 0.0.35
restore provenance tags for direct database values and calculated results, with independently suppressible table-cell tags

### 2026-08-01 version 0.0.34
show the standard skipped-item notice for generated tables and lists in focused project builds
apply the same fast-mode notice to direct |\OverviewExistingStaffTable| calls
support comma-separated applicant affiliations in title-page metadata, funding totals, section labels, and existing-staff headings
reuse a referenced person's category and organisation in staff rows when no row-level override is supplied
use |positionText| consistently for the staff roster while retaining |position| as a compatibility alias
add institution abbreviations and use them as compact labels in generated tables while retaining full names in legends
render work-package names only at the top level and start sub-workpackage prose without an extra space

### 2026-07-30 version 0.0.33
add orthogonal |consider-for-lists| and |reference-only| project controls
exclude non-considered projects from generated project aggregates and active-project counts
add cached |\getProjectCount| totals for all active projects and the A, B, and Q areas
mark reference-only projects as former projects without creating broken project-section links
add a consolidated information-retrieval command reference to the documentation and proposal README

### 2026-07-30 version 0.0.32
rename the focused-project switches to |fastcompile-project-show-images| and |fastcompile-project-show-publications|
apply the selected graphics draft state explicitly after |graphicx| loads so image toggling is reliable
enable real project images in the active focused-project proposal configuration

### 2026-07-30 version 0.0.31
keep sub-workpackage names bold and join their following prose into the same paragraph
add an opt-in |fastcompile-project-images| switch for rendering project figures during focused drafting
identify fast project drafts with a running project header and a hook-based page watermark

### 2026-07-30 version 0.0.30
add a dedicated |fastcompile-project| text-drafting mode that skips metadata databases, calculated project headers, and auxiliary funding restoration
add an independent |project-publications| switch for project publication headings, nocite lists, bibliographies, reports, and result lists
use draft graphics, hyperlinks, and microtypography in project-fast mode while retaining authored project prose, sections, labels, aims, and work packages
provide database-free fallbacks for project/person references and silence per-item skip output in project-fast builds
make final-mode precedence effective before metadata and package setup, and add public fast-project/publication conditionals
avoid registering bibliography sources or reading stale bbl data when project-fast publication output is disabled
add no-Data-Hub fast project make targets for publication-free and publication-enabled drafting

### 2026-07-20 version 0.0.29
add an empty-page-style project-overview backmatter page to the generated proposal template
improve DOCX conversion of project placeholders and general work-package and subwork-package structures
seed converted project files with requested-staff examples and float barriers around publication and diversity sections
keep Gantt charts directly after the work packages with strict |h| placement and a following float barrier
move salary and animal-housing rates into validated |changeSettings| keys and remove the separate generated |dfg-salaries.tex| file
add configurable CRC and affiliation logo paths and retain the former salary and housing commands as expandable compatibility accessors
map W2/W3 professorial funding to the shared configurable rate
clarify requested-staff applicability rules, validate DFG categories, and use visible no-value backgrounds without alternating row colors
separate research and non-research staff groups with a conditional horizontal rule while retaining one row-spanning label per group
print resolved existing-staff surnames in bold and format job-description lead-ins as number, academic degree, first name, and last name
replace an empty requested-instrumentation overview table with a funding-period-specific explanatory sentence
make proposal CI builds reproducible with pinned images, a single Data Hub refresh job, parallel smoke checks, and clean authoritative builds
keep live DOI lookups opt-in and preserve generated Data Hub file timestamps when their contents are unchanged
support unnamed staff vacancies with |lastname={TBA}| without requiring a synthetic first name or academic degree
make generated-class Flymake diagnostics useful by suppressing ChkTeX's expl3/Lua false positives and fixing the remaining typography warnings
remove the unused |l3keys2e| dependency and replace |pdftexcmds| timing with the kernel-native expl3 timer

### 2026-07-18 version 0.0.28
add the DFG project-level RequestedFundingStaff roster with four official staff groups, continuous numbering, institution/affiliation legends, and job descriptions
extend the existing staff key family with validated roster metadata and resilient missing-reference diagnostics
calculate omitted yearly staff sums from DFG salary constants, percentage, and quantity while retaining explicit sums as overrides
document the roster schema, table call, automatic staff-cost formula, and a complete four-group example
polish the staff roster typography and spacing and resolve institutions with their parent-affiliation legend
render roster categories as personnel categories such as Prof, PhD, and Research rather than salary-table descriptions
extract a focused regression test for the staff roster and automatic salary totals as local/test.tex
reuse existing RequestedFundingStaff rows for the chapter-2 overview of existing staff, grouped by DFG category and affiliation
fix the CV smoke-build target to use the generated crc-cv.tex filename

### 2026-07-17 version 0.0.27
replace repeated requested-funding database sums with incremental LaTeX3 property-list indexes
reduce each project funding table from five filtered database traversals to one
preserve the optional conversion-missing bibliography when generating release classes
document the funding-cache architecture, correctness guarantees, and complete-proposal benchmark

### 2026-07-16 version 0.0.26
add project-local report references and result lists for quality-assured publications, other results, and patents

### 2026-07-14 version 0.0.25
configure biblatex styles and additional options separately for CV and proposal documents
load bibliography customization before biblatex so style settings take effect

### 2026-07-14 version 0.0.24
emphasize bibliography aliases for every PI assigned to a project

### 2026-07-03 version 0.0.23
collect all institutions from comma-separated PI institution references in the participating institutions list

### 2026-06-24 version 0.0.22
rename documentclass for compatibility reason to dfg-crc.cls

### 2026-06-23 version 0.0.21
reuse the standard institution-list formatter in the project leaders table

### 2026-06-22 version 0.0.20
add more vertical spacing between multiple institutions in standard institution lists
avoid a leading institution-list line break when the institution name is empty
expand user documentation for institution metadata, compilation, generated files, and release steps
enable open-access markers in biblatex output and document manual BibTeX fallback annotations
enable LuaTeX socket support in makefile builds for DOI API lookup
load open-access bibliography markers only for final documents

### 2026-06-15 version 0.0.19
align optional CV table layout with mandatory CV entries
add and document CRC/TRR reference commands

### 2026-06-11 version 0.0.18
extend documentation for PI and project helper commands
make documentation examples more coherent and concrete
fix typos and stale yes/no key documentation

### 2026-06-10 version 0.0.17
small functional fix for cv, adding missing spaces
change font of section headers in cv

### 2026-06-08 version 0.0.16
put the test for existing cv-database at proper position, so there is no error when calling dfgCV directly.

### 2026-05-29 version 0.0.15dev
cv: test for empty start and end

### 2026-05-29 version 0.0.14
rename all 'true/false' to 'yes/no' since xlsx cannot handle it.

### 2026-05-25 version 0.0.13
fix dfgTOCprojectPart now properly working with bookmarks.

### 2026-05-23 version 0.0.12
calculate overview of requested instrumentation and staff from the various projects. no dedicated database is needed.

### 2026-05-23 version 0.0.11
change symbol of last shared authorship, so it is easier to differentiate. Fallback if there is no cv for a PI of current funding period. Add a version information on the titlepage.

### 2026-05-13 version 0.0.10
adjusting addEntry when cv-bool active.

### 2026-05-12 version 0.0.9
renaming -name- to -positionText- for being streamlined.

### 2026-05-10 version 0.0.7
improving bibliography stuff for cv section

### 2026-05-07 version 0.0.6
various optimizations regarding runtime creating tables

### 2026-05-04 version 0.0.5
a lot of refactoring to speed up compiling tables, putting PI information into tcolorboxes for better handling (raster)

### 2026-05-01 version 0.0.4
working on more efficient code like reducing database queries.

### 2026-03-11 version 0.0.3
documentation extended

### 2026-03-11 version 0.0.3
documentation extended

### 2026-02-14 version 0.0.2
intensive documentation <br>
more funding tables added

### 2026-01-05 version 0.0.1
initial setup <br>
