MAIN_SRC=main
DOCKER_IMAGE=latex-env-local

.PHONY: build
build:
	docker build -t $(DOCKER_IMAGE) .


ifeq "$(OS)" "Windows_NT"
UIDOPT=
else
UNAME=$(shell uname)
ifeq "$(UNAME)" "Linux"
UID=$(shell id -u)
GID=$(shell id -g)
UIDOPT=-u $(UID):$(GID)
else
UIDOPT=
endif
endif

DOCKER_CMD=docker run --rm $(UIDOPT) -v $(CURDIR):/workdir $(DOCKER_IMAGE)
LATEXMK_CMD=$(DOCKER_CMD) latexmk

.DEFAULT_GOAL := pdf

.PHONY: pdf
pdf:
	$(LATEXMK_CMD) $(MAIN_SRC).tex

.PHONY: clean
clean:
	$(LATEXMK_CMD) -c $(MAIN_SRC).tex
	rm -f *.dvi *.log *.aux *.fls *.fdb_latexmk *.synctex.gz
