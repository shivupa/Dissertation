LATEX=pdflatex
LATEXOPT=--shell-escape

LATEXMK=latexmk
LATEXMKOPT=-pdf

MAIN=shiv_upadhyay_etd
BIB=references
HEADER=header

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
	rsync -ahSD $(IMAGEDIR) $(COMPILEDIR)
	rsync -ahSD $(PARTSDIR) $(COMPILEDIR)
	cd $(COMPILEDIR) && \
	$(LATEXMK) $(LATEXMKOPT) $(MAIN).tex
	cp $(COMPILEDIR)/$(MAIN).pdf $(MAINDIR)
clean:
	rm -rf $(COMPILEDIR)
veryclean:
	rm -rf $(COMPILEDIR)
	rm $(MAIN).pdf
edit:
	$(VISUAL) -p $(MAIN).tex $PARTSDIR/*

.PHONY: clean veryclean all
