\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cls/basic_resume}[2026/03/15 Custom Basic Resume Class]

% pLaTeX2e および upLaTeX の古いパッケージの不具合を自動回避する。
\RequirePackage{plautopatch}

% 共通のドライバオプションをグローバルに設定し、ドライバのフォールバック(dvips等)を防ぐ
\g@addto@macro\@classoptionslist{,dvipdfmx}

% 基本となるクラスを読み込む(A4, 2段組, 9pt, upLaTeX用, DVI経由PDF用)。
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

% 行間の設定(少し詰める)。
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
%% 独自コマンド・見出しスタイルの調整
%% ================================================================

% キャプション設定(ベーススタイルが読み込まれている場合)
\AtBeginDocument{
  \@ifpackageloaded{caption}{
    \captionsetup[subfigure]{labelformat=simple}
    \renewcommand{\thesubfigure}{(\alph{subfigure})}
  }{}
}

\makeatletter

% 章見出し、節見出しの独自フォーマット(余白等を微調整)。
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

% 見出し番号のフォーマット変更(chapter番号を含めない)
\renewcommand{\thesection}{\arabic{section}}
\renewcommand{\thesubsection}{\thesection.\arabic{subsection}}
\renewcommand{\thesubsubsection}{\thesubsection.\arabic{subsubsection}}
