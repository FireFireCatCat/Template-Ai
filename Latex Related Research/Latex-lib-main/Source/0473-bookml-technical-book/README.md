# BookML technical-book starter

This starter is based on [BookML](https://github.com/vlmantova/bookml), a
GPL-3.0 LaTeXML/bookdown-flavoured workflow for producing accessible PDF,
HTML, EPUB, and SCORM outputs from a LaTeX source tree. It demonstrates the
BookML package hook, alternative PDF metadata, a contents structure, and
semantic-book guidance with original sample content.

The required upstream `bookml.sty`, `bookml-init.sty`, and `latexml.sty` files
are included because BookML is not installed in the pinned TeX image. Their
upstream copyright and GPL notices are retained. The full upstream Makefile
is not copied; when you need multi-format output, add a project-specific
`GNUmakefile` following the included documentation. No upstream example prose,
images, fonts, or logos are bundled.

Compile the PDF with **LuaLaTeX**. For HTML/EPUB/SCORM output, install
LaTeXML and use the upstream `bookml.mk` workflow in a separate project build.
