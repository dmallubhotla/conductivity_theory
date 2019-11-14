LATEXMK = latexmk -pdflatex="luahblatex %O %S" -pdf -dvi- -ps- -quiet -logfilewarninglist
WS = wolframscript -f

PDF_DIR = pdfs/
TEX_DIR = tex/

SOURCES := $(wildcard tex/*.tex)
OUTPUTS := $(patsubst tex/%.tex, pdfs/%.pdf,$(SOURCES))


all: pdfs/main.pdf $(OUTPUTS)

.PHONY: all tidy clean

tidy:
	@latexmk -c
	@cd tex; latexmk -c
	@rm -f tex/*.tdo

clean:
	rm -f pdfs/*
	@latexmk -C
	@cd tex; latexmk -C
	@rm -f tex/*.tdo

$(PDF_DIR):
	mkdir $(PDF_DIR)

pdfs/main.pdf: main.tex $(SOURCES) | $(PDF_DIR)
	$(LATEXMK) $(<F)
	cp $(@F) $@

$(OUTPUTS): pdfs/%.pdf: tex/%.tex | $(PDF_DIR)
	cd $(<D); $(LATEXMK) $(<F)
	@cp $(<D)/$(@F) $@