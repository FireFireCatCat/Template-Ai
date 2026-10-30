TARGET=book
CONFIG=../styles/config.sty

all: post $(TARGET).pdf

prep:
	emacs --batch --eval '(with-current-buffer (find-file-noselect "book-contents.org") (org-latex-export-to-latex nil nil nil t nil))'
	emacs --batch --eval '(with-current-buffer (find-file-noselect "foreword.org")      (org-latex-export-to-latex nil nil nil t nil))'

post: prep
	emacs --batch -l "../scripts/post-processing.el" --eval '(with-current-buffer (find-file-noselect "book-contents.tex") (post-process "book-contents.tex") (save-buffer))'
	emacs --batch -l "../scripts/post-processing.el" --eval '(with-current-buffer (find-file-noselect "foreword.tex") (post-process "foreword.tex") (save-buffer))'

$(TARGET).pdf: $(CONFIG)

%.pdf: %.tex
	xelatex $<
	xelatex $<
	xelatex $<

watch:
	find .. -type f -print | entr sh -c 'make clean; make'

clean:
	rm -f *~ *.log *.aux *.pdf *.toc *.out *.lof *.lot book-contents.tex foreword.tex
