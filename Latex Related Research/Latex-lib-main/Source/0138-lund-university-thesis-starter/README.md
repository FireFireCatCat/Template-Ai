# LTH PhD Thesis Template
This repository contains the template of [my PhD thesis](https://aoertel.de/pdf/DoctoralThesis-Andy_Oertel.pdf).


## How To Use This Template?
Here are step-by-step instruction on how to use this thesis template.

1. Fill in the macros starting on line 78 in the `thesis.tex` file.
2. Add the abstract of the thesis in the file `kappa/abstract`.
3. The popular science summary and the contribution statement are in `kappa/popular-summary.tex` and `kappa/contributionstatement.tex`, respectively.
4. The file `kappa/main.tex` is the entry point for the kappa and can be modified as you want.
5. To include a paper, have a look at the examples in `papers`. You just have to copy all the files from the paper into the `papers` folder and set up a `main.tex` file to include the paper correctly.
   - The idea is that you have a main file for each included paper that defines the necessary data and the structure of the paper, i.e., which files should be included in which order.
   - If you use macros in your papers, then it might be that these macros are already defined in your kappa or in other papers. You can resolve this by unifying all macros used in the file `macros-thesis.tex` or by using `\renewcommand` instead of `\newcommand` in the paper that you just included.
   - References are printed for each included paper individually. You can use different bib files for each paper or have common bib files for all papers. In the latter case it is not necessary to use the `\bibpath` command.


### Notes About Print Service
There are known issues that the E-house print service can not handle some types of images. For example included PDFs can not have too many colour gradients. A workaround is to convert such PDF images to a JPEG. You can use the script `pdf_to_jpeg.sh` in this repository to convert all PDF images in your papers to JPEG or alternatively use the command
```bash
pdftoppm -jpeg -r 500 -singlefile <PDF_file> <JPEG_file>
```
directly.


## Feedback and Contributions
This project lives in the Gitlab repository https://gitlab.com/aoer/latex-templates. Feel free to open an issue if there are some problems with this template. If you have improved the template, then you can open a merge request to get your changes integrated into this template.

## License
This template is licensed under the Apache License 2.0. See [LICENCE](../LICENCE).
