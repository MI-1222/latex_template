\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cls/basic_report}[2026/03/15 Custom Basic Report Class]

% pLaTeX2e および upLaTeX の古いパッケージの不具合を自動回避する。
\RequirePackage{plautopatch}

% 基本となるクラスを読み込む（A4, 11pt, upLaTeX用, DVI経由PDF用）。
\LoadClass[
  a4paper,
  11pt,
  uplatex,
  dvipdfmx
]{jsreport}
\plautopatchdisable{eso-pic}

%% ================================================================
%% 基本パッケージの読み込み
%% ================================================================

% 余白設定。
\usepackage[truedimen,margin=25truemm,dvipdfmx]{geometry}

% 複数ファイル構成にするためのパッケージ。
\usepackage{subfiles}

% 画像、図表挿入用。
\usepackage[dvipdfmx]{graphicx}
\usepackage[dvipdfmx]{color}
\usepackage[dvipdfmx]{pdfpages}

% ハイパーリンク設定。
\usepackage[hyphens]{url}
\urlstyle{same}
\usepackage[dvipdfmx]{hyperref}
\usepackage{pxjahyper}

% 数式用。
\usepackage{amsmath,amssymb}
\usepackage{mathtools}

% 物理単位入力支援。
\usepackage{siunitx}

% リスト拡張。
\usepackage{enumerate}
\usepackage{paralist}

% コード挿入用（シンタックスハイライト）。
\usepackage{listings}

% キャプションやサブ図の設定。
\usepackage[hang,small,bf,labelsep=space]{caption}
\usepackage[subrefformat=parens]{subcaption}

% 囲み枠など。
\usepackage{framed}
\usepackage{type1cm}

% 参考文献レイアウト（biber/biblatex環境）。
\usepackage[backend=biber,style=ieee]{biblatex}
\captionsetup{compatibility=false}

%% ================================================================
%% 独自コマンド・設定
%% ================================================================

% 目次・章番号の深さ設定。
\setcounter{tocdepth}{2}
\setcounter{secnumdepth}{4}

% コード出力用コマンド。
\newcommand{\code}[1]{\texttt{#1}}

% 図表等の名称変更。
\renewcommand{\figurename}{\normalsize Fig.}
\renewcommand{\tablename}{\normalsize Table.}

% listingsの基本設定
\lstset{
  basicstyle={\ttfamily\small},
  frame=single,
  breaklines=true,
  numbers=left,
  numberstyle={\tiny},
  captionpos=b
}
