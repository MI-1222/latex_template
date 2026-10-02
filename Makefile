MAIN_SRC = main
DOCKER_IMAGE = latex-env-local

# ファイルの所有権の調整
ifeq "$(OS)" "Windows_NT"
	UIDOPT =
else
	UNAME = $(shell uname)
	ifeq "$(UNAME)" "Linux"
		UID = $(shell id -u)
		GID = $(shell id -g)
		UIDOPT = -u $(UID):$(GID)
	else # Unix互換OS(macOSなど)
		UIDOPT =
	endif
endif

DOCKER_CMD := docker run --rm $(UIDOPT) -v $(CURDIR):/workdir $(DOCKER_IMAGE)
LATEXMK_CMD := $(DOCKER_CMD) latexmk

.DEFAULT_GOAL := pdf


.PHONY: build
build:
	docker build -t $(DOCKER_IMAGE) .

.PHONY: pdf
pdf:
	$(LATEXMK_CMD) $(MAIN_SRC).tex

.PHONY: sub
sub:
	@if [ -z "$(SUB)" ]; then \
		echo "Error: SUB variable is required (e.g. 'make sub SUB=src/features.tex')"; \
		exit 1; \
	fi
	-$(DOCKER_CMD) /bin/sh -c "export BIBINPUTS=/workdir/src//: && cd $$(dirname $(SUB)) && latexmk -r /workdir/.latexmkrc $$(basename $(SUB))"

.PHONY: fmt
fmt:
	@if [ -n "$(FILE)" ]; then \
		$(DOCKER_CMD) latexindent -w -s -c /tmp/ -l /workdir/.latexindent.yaml "$(FILE)"; \
	else \
		$(DOCKER_CMD) /bin/sh -c 'find . -name "*.tex" -not -path "*/.*" -exec latexindent -w -s -c /tmp/ -l /workdir/.latexindent.yaml {} +'; \
	fi

.PHONY: clean
clean:
	$(LATEXMK_CMD) -c $(MAIN_SRC).tex
	find . -type f \( \
		-name "*.bak*" -o \
		-name "indent.log" -o \
		-name "*.aux" -o \
		-name "*.glo" -o \
		-name "*.idx" -o \
		-name "*.log" -o \
		-name "*.toc" -o \
		-name "*.ist" -o \
		-name "*.acn" -o \
		-name "*.acr" -o \
		-name "*.alg" -o \
		-name "*.bbl" -o \
		-name "*.blg" -o \
		-name "*.dvi" -o \
		-name "*.glg" -o \
		-name "*.gls" -o \
		-name "*.ilg" -o \
		-name "*.ind" -o \
		-name "*.lof" -o \
		-name "*.lot" -o \
		-name "*.maf" -o \
		-name "*.mtc" -o \
		-name "*.mtc1" -o \
		-name "*.out" -o \
		-name "*.synctex.gz" -o \
		-name "*.fdb_latexmk" -o \
		-name "*.fls" -o \
		-name "*.bcf" -o \
		-name "*.run.xml" \
	\) -exec rm -f {} +
