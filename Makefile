.PHONY: all default imagens clean clean-imagens clean-all ajusta-imagens

SHELL=/bin/bash

DEST_DIR=pdfs

IMAGENS_DIR=imagens

IGNORAR=README.md

SOURCES=$(filter-out $(IGNORAR), $(wildcard *.md))

PDFS=$(addprefix $(DEST_DIR)/, $(SOURCES:.md=.pdf))

PANDOC=./local/bin/pandoc
PANDOC_VERSION=2.2.2.1

default:
	@if [ ! -e $(IMAGENS_DIR)/copl-1-1.png ]; then make imagens; fi
	@echo Executando make em paralelo [$(shell nproc) tarefas]
	@make -s -j $(shell nproc) all

all: $(PDFS)

$(DEST_DIR)/%.pdf: %.md templates/default.latex $(IMAGENS_DIR)/* $(PANDOC)
	@mkdir -p $(DEST_DIR)
	@echo $@
	@$(PANDOC) -t beamer --template templates/default.latex -o $@ $<

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
	@echo Removendo $(DEST_DIR)
	@rm -rf $(DEST_DIR)

clean-imagens:
	@echo "Removendo $(IMAGENS_DIR)/copl-*"
	@rm -f $(IMAGENS_DIR)/copl-*

clean-all: clean clean-imagens
