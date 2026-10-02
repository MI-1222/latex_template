# latex_template

## 概要

### サイズ

| 項目                                                                                                                                                                                      | サイズ   |
| ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------- |
| # debian.sh --arch 'arm64' out/ 'bookworm' '@1773619200'                                                                                                                                  | 97.21 MB |
| ENV DEBIAN_FRONTEND=noninteractive                                                                                                                                                        | 0 B      |
| RUN /bin/sh -c apt-get update && apt-get install -y --no-install-recommends texlive-lang-japanese texlive-latex-extra latexmk && apt-get clean && rm -rf /var/lib/apt/lists/\* # buildkit | 1.21 GB  |
| WORKDIR /workdir                                                                                                                                                                          | 0 B      |

## install

本テンプレートはDockerコンテナ内でコンパイルを行う仕組みとなっています。

### 必須要件

[Docker Desktop](https://www.docker.com/products/docker-desktop/)が起動していること。

### 補足事項

TeX Live 等のLaTeX環境一式はDockerイメージ内に構築されるため、ローカルPC環境へ TeX Live 本体をダウンロード・インストールする必要はない。

## usage

### docker image のビルド

```sh
make build
```

### `main.tex`のビルド, 中間ファイル削除

```sh
make pdf && make clean
```

### subfilesパッケージによる分割管理

`subfiles` パッケージにより、ドキュメントを複数のファイル(例：`src/chapter01/intro.tex`)に分割し、
それぞれのファイルを単体でコンパイルすることが可能。

#### メリット

- 大規模な文書でも、編集中の章だけを即座にビルドして確認できる。
- メインファイル(`main.tex`)のプリアンブル設定がサブファイルにも自動的に適用される。
- 構造ごとにファイルを分けることで、編集の見通しが良くなる。

#### 個別ビルドの方法

```sh
make sub SUB=src/chapter01/intro.tex
```

> [!NOTE]
> `subfiles` の仕様により、サブディレクトリ内のファイルを単体ビルドする際、参考文献(BibLaTeX)の解決に失敗することがある。
> その場合でもPDFの生成自体は行われるが、引用箇所が正しく表示されない場合がある。
> 完全な参考文献付きのPDFを確認する場合は、`main.tex` をビルドする。

### コードの自動整形（フォーマット）

`latexindent` を用いて `.tex` ファイルのインデントや改行を自動整形します。
設定ルールは `.latexindent.yaml` で管理されており、デフォルトでインデント幅は半角スペース2文字です。

#### プロジェクト全体のフォーマット

```sh
make fmt
```

#### 特定ファイルの個別フォーマット

```sh
make fmt FILE=src/example/features.tex
```

## vscodeの設定例

macOSの場合。

### `~/Library/Application Support/Code/User/tasks.json`

```json
{
  // ...
  "tasks": [
    // ...
    {
      "label": "Build LaTeX PDF and Clean from Docker",
      "type": "shell",
      "command": "make pdf && make clean",
      "options": {
        // 現在開いているプロジェクトのルートディレクトリで実行する
        "cwd": "${workspaceFolder}"
      },
      "presentation": {
        "reveal": "silent",
        "close": true
      },
      "problemMatcher": []
    },
    {
      "label": "Format Current LaTeX File from Docker",
      "type": "shell",
      "command": "make fmt FILE=\"${relativeFile}\"",
      "options": {
        "cwd": "${workspaceFolder}"
      },
      "presentation": {
        "reveal": "silent",
        "close": true
      },
      "problemMatcher": []
    },
    {
      "label": "Format All LaTeX Files from Docker",
      "type": "shell",
      "command": "make fmt",
      "options": {
        "cwd": "${workspaceFolder}"
      },
      "presentation": {
        "reveal": "silent",
        "close": true
      },
      "problemMatcher": []
    }
    // ...
  ]
}
```

### `~/Library/Application Support/Code/User/keybindings.json`

```json
[
  // ...
  {
    "key": "cmd+enter",
    "command": "workbench.action.tasks.runTask",
    "args": "Build LaTeX PDF and Clean from Docker",
    "when": "editorTextFocus && editorLangId == 'latex'"
  },
  {
    "key": "shift+alt+f",
    "command": "workbench.action.tasks.runTask",
    "args": "Format Current LaTeX File from Docker",
    "when": "editorTextFocus && editorLangId == 'latex'"
  }
  // ...
]
```
