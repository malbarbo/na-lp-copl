.PHONY: all tex default imagens clean clean-imagens clean-all ajusta-imagens

SHELL=/bin/bash
DEST_PDF=pdfs
DEST_TEX=tex
IMAGENS_DIR=imagens
IGNORAR=README.md
SOURCES=$(filter-out $(IGNORAR), $(wildcard *.md))
PDFS=$(addprefix $(DEST_PDF)/, $(SOURCES:.md=.pdf))
TEX=$(addprefix $(DEST_TEX)/, $(SOURCES:.md=.tex))
PANDOC_VERSION=2.2.2.1
PANDOC=./local/bin/pandoc
PANDOC_CMD=$(PANDOC) \
		--template templates/default.latex \
		--toc \
		--standalone \
		-V author:"Marco A L Barbosa" \
		-V institute:"Departamento de Informática\\\\Universidade Estadual de Maringá" \
		-V theme:metropolis \
		-V themeoptions:"numbering=fraction,subsectionpage=progressbar,block=fill" \
		-V header-includes:"\captionsetup[figure]{labelformat=empty}" \
		-V header-includes:"\usepackage{caption}" \
		-t beamer

default:
	@if [ ! -e $(IMAGENS_DIR)/copl-1-1.png ]; then make imagens; fi
	@echo Executando make em paralelo [$(shell nproc) tarefas]
	@make -s -j $(shell nproc) all

all: $(PDFS)

tex: $(TEX)

$(DEST_PDF)/%.pdf: %.md templates/default.latex $(IMAGENS_DIR)/* $(PANDOC) Makefile
	@mkdir -p $(DEST_PDF)
	@echo $@
	@$(PANDOC_CMD) -o $@ $<

$(DEST_TEX)/%.tex: %.md templates/default.latex $(IMAGENS_DIR)/* $(PANDOC) Makefile
	@mkdir -p $(DEST_TEX)
	@echo $@
	@$(PANDOC_CMD) -o $@ $<

ajusta-imagens:
	@echo Ajustanto imagens
	@utils/ajusta-imagens $(IMAGENS_DIR)/copl-*

imagens: copl-imagens.zip
	@echo Extraindo as imagens
	@unzip -q copl-imagens.zip
	@libreoffice --headless --convert-to pdf "Sebesta CPL 9e FigureSlides.ppt" > /dev/null
	@mkdir -p $(IMAGENS_DIR)/
	@pdfimages -j "Sebesta CPL 9e FigureSlides.pdf" $(IMAGENS_DIR)/copl
	@echo Convertendo imagens
	@for f in $(IMAGENS_DIR)/copl-*.ppm; do pnmtopng $$f 2>/dev/null > "$${f%.*}.png"; done
	@cd $(IMAGENS_DIR)/ && ../utils/copl-imagens
	@echo Removendo arquivos temporários
	@rm "Sebesta CPL 9e FigureSlides.ppt" "Sebesta CPL 9e FigureSlides.pdf" copl-imagens.zip $(IMAGENS_DIR)/copl-*.jpg
	@rm $(IMAGENS_DIR)/copl-*.ppm

copl-imagens.zip:
	@echo Downloading arquivo com as imagens do livro
	@wget -c -q ftp://ftp.awl.com/cseng/authors/sebesta/concepts9e/0136079180_ppf.zip -O copl-imagens.zip

$(PANDOC):
	mkdir -p local
	curl -L https://github.com/jgm/pandoc/releases/download/$(PANDOC_VERSION)/pandoc-$(PANDOC_VERSION)-linux.tar.gz | tar xz -C local --strip-components=1

clean:
	@echo Removendo $(DEST_PDF) e $(DEST_TEX)
	@rm -rf $(DEST_PDF) e $(DEST_TEX)

clean-imagens:
	@echo "Removendo $(IMAGENS_DIR)/copl-*"
	@rm -f $(IMAGENS_DIR)/copl-*

clean-all: clean clean-imagens
