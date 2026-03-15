# latex_template

## 概要

### サイズ

|項目|サイズ|
|---|---|
|# debian.sh --arch 'arm64' out/ 'bookworm' '@1771804800'|97.21 MB|
|ENV DEBIAN_FRONTEND=noninteractive|0 B|
|RUN /bin/sh -c apt-get update && apt-get install -y --no-install-recommends texlive-lang-japanese texlive-latex-extra latexmk && apt-get clean && rm -rf /var/lib/apt/lists/* # buildkit|883.99 MB|
|WORKDIR /workdir|0 B|

## install

## usage
```sh
make build && make pdf && make clean
```
