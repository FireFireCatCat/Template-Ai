#### Package Name

`tidyres` (Please read the documentation on CTAN for detailed usage.)



#### Author

Yifan Liang (GitHub User Name: futurelyf)
You may contact me via GitHub.



#### Version

``Version 3.0.0`` (September 15, 2026)



#### Basic Functions

This `tidyres` package aims to provide users with a simple interface to create multi-column formal resume.

The `\restitle{keys}` command helps users produce the title of the resume. It accepts the following key-value options: `name`, `location`, `email`, `phone`, `linkedin`, and `linkedinurl`. The `linkedin` key is a user name suffix (a full LinkedIn URL is built automatically), while `linkedinurl` overrides it with an explicit URL. For example:

```
\restitle{
  name     = John Doe,
  location = New York,
  email    = john@example.com,
  phone    = 555-1234,
  linkedin = johndoe,
}
```

The `ressection` environment helps users create multi-column sections (e.g., Education, Experience, etc.). The section title is set via the optional key-value argument `title`, which defaults to `Section`. For example:

```
\begin{ressection}[title = Education]
  ...
\end{ressection}
```

The `\ressep` command helps users to add small vertical space between sub-items in a section.

The `\hlbox{text}` command renders inline text in a highlighted rounded box with a monospaced (`\ttfamily`) font — useful for keywords, technologies, or skills. The optional argument sets the base color (default: `gray`), e.g. `\hlbox[blue]{\LaTeX}`.

The `\columnratio{ratio}` command allows users to customize the column widths of the layout (default: `0.12, 0.88`). It should be used in the preamble, e.g.:

```
\columnratio{0.15, 0.85}
```



#### License

This work is licensed under Creative Commons "Attribution 4.0 International" license.
For detailed information about the license, please visit the Creative Commons' website.