\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cls/basic_resume}[2026/03/15 Custom Basic Resume Class]

% pLaTeX2e および upLaTeX の古いパッケージの不具合を自動回避する。
\RequirePackage{plautopatch}

% 基本となるクラスを読み込む（A4, 2段組, 9pt, upLaTeX用, DVI経由PDF用）。
\LoadClass[
  a4paper,
  twocolumn,
  9pt,
  uplatex,
  dvipdfmx
]{jsarticle}
\plautopatchdisable{eso-pic}

%% ================================================================
%% レイアウト・ページ設定
%% ================================================================

% ページ番号の非表示化。
\pagestyle{empty}

% 行間の設定（少し詰める）。
\usepackage{setspace}
\setstretch{0.8}

% 段組みの間隔。
\columnsep 10 mm

% 余白設定。
\usepackage[
  top=15truemm,
  bottom=25truemm,
  left=25truemm,
  right=25truemm,
  dvipdfmx
]{geometry}

%% ================================================================
%% 基本パッケージの読み込み
%% ================================================================

% 欧文フォントと日本語フォントの調整。
\usepackage{minijs}
\usepackage[T1]{fontenc}
\usepackage{lmodern}

% 見出し（セクション）後のドット自動付与。
\usepackage{secdot}

% 強制配置用（H）。
\usepackage{here}

% URL・ハイパーリンク関連。
\usepackage[hyphens]{url}
\urlstyle{same}

% リスト拡張。
\usepackage{enumerate}

% 画像挿入・色設定。
\usepackage[dvipdfmx]{graphicx}
\usepackage[dvipdfmx]{color}

% 数式関連。
\usepackage{amsmath}
\usepackage{bm}
\usepackage{siunitx}

% ファイル分割やその他の小規模パッケージ。
\usepackage{subfiles}
\usepackage{indentfirst}
\usepackage{framed}
\usepackage{type1cm}

% キャプションやサブ図の設定。
\usepackage[labelsep=space]{caption}
\usepackage{subcaption}

% 見出しカスタマイズ。
\usepackage{titlesec}

% コード挿入用。
\usepackage{listings}

% 参考文献。
\usepackage[
  backend=biber,
  style=ieee
]{biblatex}
\captionsetup{compatibility=false}

%% ================================================================
%% 独自コマンド・見出しスタイルの調整
%% ================================================================

% サブキャプションのフォーマット。(a) (b) とする。
\captionsetup[subfigure]{labelformat=simple}
\renewcommand{\thesubfigure}{(\alph{subfigure})}

% 图・表の名称変更。
\makeatletter
\renewcommand{\figurename}{\normalsize Fig.}
\renewcommand{\tablename}{\normalsize Table.}

% ベクトル入力用コマンド。
\newcommand{\bvec}[1]{\mbox{\boldmath $#1$}}

% 章見出し、節見出しの独自フォーマット（余白等を微調整）。
\def\section{
  \@startsection {
    section
  }{1}{\z@}{ -1.5ex plus 2ex minus 0.0ex} {0.1ex plus 0.1ex}{\normalsize\gt}
}
\def\subsection{
  \@startsection {
    subsection
  }{1}{\z@}{ -0.8ex plus 2ex minus 0.0ex} {0.5ex plus 0.1ex}{\normalsize\gt}
}
\makeatother
