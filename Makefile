.PHONY: default all pdf handout tex exemplos clean

SHELL=/bin/bash
IMAGENS_DIR=imagens
DEST=target
DEST_PDF=$(DEST)/pdfs
DEST_PDF_HANDOUT=$(DEST)/pdfs/handout
DEST_TEX=$(DEST)/tex
IGNORAR=README.md
SOURCES=$(filter-out $(IGNORAR), $(sort $(wildcard *.md)))
PDF=$(addprefix $(DEST_PDF)/, $(SOURCES:.md=.pdf))
PDF_HANDOUT=$(addprefix $(DEST_PDF_HANDOUT)/, $(SOURCES:.md=.pdf))
TEX=$(addprefix $(DEST_TEX)/, $(SOURCES:.md=.tex))
EX_SOURCES=$(shell find exemplos/ -maxdepth 1 -mindepth 1 -type d)
EX=$(EX_SOURCES:exemplos/%=$(DEST)/%-exemplos.zip)
PANDOC=$(DEST)/bin/pandoc
PANDOC_VERSION=2.2.2.1
# TODO: mover para um arquivo
PANDOC_CMD=$(PANDOC) \
		--template templates/default.latex \
		--toc \
		--standalone \
		-V author:"Marco A L Barbosa\\\\\\href{http://malbarbo.pro.br}{malbarbo.pro.br}" \
		-V institute:"\\href{http://din.uem.br}{Departamento de Informática}\\\\\\href{http://www.uem.br}{Universidade Estadual de Maringá}{}" \
		-V theme:metropolis \
		-V themeoptions:"numbering=fraction,subsectionpage=progressbar,block=fill" \
		-V header-includes:"\captionsetup[figure]{labelformat=empty}" \
		-V header-includes:"\usepackage{caption}" \
		-t beamer

default:
	@echo Executando make em paralelo [$(shell nproc) tarefas]
	@make -s -j $(shell nproc) all

all: $(PDF) $(PDF_HANDOUT) $(TEX) $(EX)

pdf: $(PDF)

handout: $(PDF_HANDOUT)

tex: $(TEX)

exemplos: $(EX)

$(DEST_PDF)/%.pdf: %.md templates/default.latex $(IMAGENS_DIR)/* $(PANDOC) Makefile
	@mkdir -p $(DEST_PDF)
	@echo $@
	@$(PANDOC_CMD) -o $@ $<

$(DEST_PDF_HANDOUT)/%.pdf: %.md templates/default.latex $(IMAGENS_DIR)/* $(PANDOC) Makefile
	@mkdir -p $(DEST_PDF_HANDOUT)
	@echo $@
	@$(PANDOC_CMD) -V classoption:handout -o $@ $<

$(DEST_TEX)/%.tex: %.md templates/default.latex $(IMAGENS_DIR)/* $(PANDOC) Makefile
	@mkdir -p $(DEST_TEX)
	@echo $@
	@$(PANDOC_CMD) -o $@ $<

$(DEST)/%-exemplos.zip: exemplos/%
	@mkdir -p $(DEST)
	@rm -rf $(DEST)/$$(basename $@ .zip)*
	@cp -r $< $(DEST)/$$(basename $@ .zip)
	@echo $@
	@cd $(DEST) && zip -q -r ../$@ $$(basename $@ .zip) && rm -rf $$(basename $@ .zip)

$(PANDOC):
	mkdir -p $(DEST)
	curl -L https://github.com/jgm/pandoc/releases/download/$(PANDOC_VERSION)/pandoc-$(PANDOC_VERSION)-linux.tar.gz | tar xz -C $(DEST) --strip-components=1

clean:
	@echo Removendo $(DEST_PDF), $(DEST_TEX) e $(EX)
	@rm -rf $(DEST_PDF) $(DEST_TEX) $(EX)
