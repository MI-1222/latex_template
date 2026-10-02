FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    texlive-lang-japanese \
    texlive-latex-extra \
    texlive-science \
    texlive-fonts-recommended \
    lmodern \
    texlive-bibtex-extra \
    biber \
    latexmk \
    texlive-extra-utils \
    libyaml-tiny-perl \
    libfile-homedir-perl \
    libunicode-linebreak-perl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workdir
