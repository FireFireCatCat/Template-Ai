# OST-Stud LaTeX Style & Macros

## Built it

### Automagically with `make`

It is as simple as it gets.
```
$ make
```
The output will be generated in a directory called `build`.

### Manually

This will generate many files including `oststud.sty` that can be placed in the
folder of any other LaTeX project, which can access the library with
`\usepackage{oststud}`
```
$ xelatex oststud.ins  # generate oststud.sty
```

To get the documentation (in PDF) you can compile the respective `dtx` file
```
$ xelatex oststud.dtx  # generate documentation oststud.pdf
``` 

## The older `hsrstud` package

The previous version of thie package for the Hochschule für Technik Rapperswil,
i.e. `hsrstud`, is still available for backwards compatibility. To get
`hsrstud.sty` and its documentation run `make` or manually:
```
$ xelatex hsrstud.ins  # generate hsrstud.sty
$ xelatex hsrstud.dtx  # generate documentation hsrstud.pdf
```

The `hsrstud` package has documentclasses which are not (yet) available in the
newer version. To get `hsrbericht.cls` or `hsrzf.cls` without using `make` run
```
$ xelatex hsrstud-classes.ins  # generate .cls files
$ xelatex hsrstud-classes.dtx  # generate documentation hsrstud-classes.pdf
```


## License
```
OSTStud (c) by Naoki Pross

OSTStud is licensed under a Creative Commons Attribution-ShareAlike 4.0 Unported License.
You should have received a copy of the license along with this work. If not, see

http://creativecommons.org/licenses/by-sa/4.0/
```
