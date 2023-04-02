LATEX=pdflatex
LATEXOPT=--shell-escape

LATEXMK=latexmk
LATEXMKOPT=-pdf

MAIN=shiv_upadhyay_etd
BIB=references
HEADER=header
GLOSSARY=glossary

MAINDIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
IMAGEDIR:=$(MAINDIR)/Images
CLASSDIR:=$(MAINDIR)/pittetdclass
COMPILEDIR:=$(MAINDIR)/compile
PARTSDIR:=$(MAINDIR)/chapters

all:
	mkdir -p $(COMPILEDIR)
	cp $(CLASSDIR)/* $(COMPILEDIR)
	cp $(MAIN).tex $(COMPILEDIR)
	cp $(BIB).bib $(COMPILEDIR)
	cp $(HEADER).tex $(COMPILEDIR)
	cp $(GLOSSARY).tex $(COMPILEDIR)
	rsync -ahSD $(IMAGEDIR) $(COMPILEDIR)
	rsync -ahSD $(PARTSDIR) $(COMPILEDIR)
	cd $(COMPILEDIR) && \
	$(LATEXMK) $(LATEXMKOPT) $(MAIN).tex
	cp $(COMPILEDIR)/$(MAIN).pdf $(MAINDIR)
html:
	mkdir -p $(COMPILEDIR)_html
	cp $(CLASSDIR)/* $(COMPILEDIR)_html
	cp $(MAIN).tex $(COMPILEDIR)_html
	cp $(BIB).bib $(COMPILEDIR)_html
	cp $(HEADER).tex $(COMPILEDIR)_html
	rsync -ahSD $(IMAGEDIR) $(COMPILEDIR)_html
	rsync -ahSD $(PARTSDIR) $(COMPILEDIR)_html
	cd $(COMPILEDIR)_html && \
	make4ht $(MAIN).tex "mathml,mathjax"
clean:
	rm -rf $(COMPILEDIR)
	rm -rf $(COMPILEDIR)_html
veryclean:
	rm -rf $(COMPILEDIR)
	rm -rf $(COMPILEDIR)_html
	rm $(MAIN).pdf
edit:
	$(VISUAL) -p $(MAIN).tex $(PARTSDIR)/*.tex

.PHONY: clean veryclean all
