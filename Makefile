LATEXMK = latexmk -pdflatex="luahblatex %O %S" -pdf -dvi- -ps- -quiet -logfilewarninglist
WS = wolframscript -f

PDF_DIR = pdfs/
TEX_DIR = tex/

SOURCES := $(wildcard tex/*.tex)
OUTPUTS := $(patsubst tex/%.tex, pdfs/%.pdf,$(SOURCES))


all: pdfs/main.pdf $(OUTPUTS)

.PHONY: all tidy clean declutter

declutter:
	@rm -f tex/*.tdo
	@rm -f tex/*.run.xml
	@rm -f tex/*.bbl
	@rm -f *.tdo
	@rm -f *.run.xml
	@rm -f *.bbl


tidy: declutter
	@latexmk -c
	@cd tex; latexmk -c

clean: declutter
	rm -f pdfs/*
	@latexmk -C
	@cd tex; latexmk -C

$(PDF_DIR):
	mkdir $(PDF_DIR)

pdfs/main.pdf: main.tex $(SOURCES) | $(PDF_DIR)
	$(LATEXMK) $(<F)
	cp $(@F) $@

$(OUTPUTS): pdfs/%.pdf: tex/%.tex main.tex | $(PDF_DIR)
	cd $(<D); $(LATEXMK) $(<F)
	@cp $(<D)/$(@F) $@