songproj
========

Commands and environments for generating Beamer slideshows with song lyrics,
typically for religious services with a projector.

Author: Tanguy Ortolo
License: 3-Clause BSD

Description
-----------

This package, together with the Beamer class, is used to generate slideshows
with song lyrics. This is typically used in religious services in churches
equipped with a projector, for which this package has been written, but it can
be useful for any type of singing assembly. It provides environments to
describe a song in a natural way, and formatting it into slides with overlays.

Example
-------

Detailed usage can be found in the PDF documentation. Here is a simple example:

```latex
\documentclass{beamer}
\usepackage{songproj}
\begin{document}
  \begin{frame}
    \begin{song}{2}
      \longest{Light she was, and like a fairy,}
      \begin{couplet}
        In a cavern, in a canyon, \\
        Excavating for a mine. \\
        Dwelt a miner, forty-niner, \\
        And his daughter, Clementine. \\
      \end{couplet}
      \begin{refrain}
        Oh my darling, oh my darling, \\
        Oh my darling Clementine, \\
        You are lost and gone forever, \\
        Dreadful sorry, Clementine. \\
      \end{refrain}
      \begin{couplet}
        Light she was, and like a fairy, \\
        And her shoes were number nine, \\
        Herring boxes, without topses, \\
        Sandals were for Clementine. \\
      \end{couplet}
      \begin{couplet}
        […]
      \end{couplet}
    \end{song}
  \end{frame}
\end{document}
```

Add-on script
-------------

This package comes with an additional script, `song2tex.py`, that can be used
to convert plain-text song lyrics to the expected LaTeX markup. The file
`example/clementine.txt` can be used to test it:

```sh
./song2tex.py examples/clementine.txt /tmp/clementine.tex
```
