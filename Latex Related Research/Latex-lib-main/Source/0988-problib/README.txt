Author: Kyle Monette
Contact: kylemonette309@gmail.com
GitHub: https://github.com/kylemonette/problib
License: LPPL 1.3c
Version: 1.0

This package manages a library of problems for the exam document class. Each problem is stored in its own
file with metadata such as topics, tags and difficulty, and assignments pull problems from the library by
path. Answer space between questions, parts and subparts is chosen in the assignment, not stored with the
problem. Every assignment records which problems it used, and a catalog document, compiled with LuaLaTeX,
collects those records to show when and where each problem was last used.
