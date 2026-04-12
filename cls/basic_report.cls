\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cls/basic_report}[2026/03/15 Custom Basic Report Class]

% pLaTeX2e および upLaTeX の古いパッケージの不具合を自動回避する。
\RequirePackage{plautopatch}

% 共通のドライバオプションをグローバルに設定し、ドライバのフォールバック(dvips等)を防ぐ
\g@addto@macro\@classoptionslist{,dvipdfmx}

% 基本となるクラスを読み込む(A4, 11pt, upLaTeX用, DVI経由PDF用)。
\LoadClass[
  a4paper,
  11pt,
  uplatex,
  dvipdfmx
]{jsreport}
\plautopatchdisable{eso-pic}

%% ================================================================
%% クラス固有の設定
%% ================================================================

% 余白設定。
\RequirePackage[truedimen,margin=25truemm,dvipdfmx]{geometry}

% 目次・章番号の深さ設定。
\setcounter{tocdepth}{2}
\setcounter{secnumdepth}{4}

% 見出し番号のフォーマット変更(chapter番号を含めない)
\renewcommand{\thesection}{\arabic{section}}
\renewcommand{\thesubsection}{\thesection.\arabic{subsection}}
\renewcommand{\thesubsubsection}{\thesubsection.\arabic{subsubsection}}

% キャプション設定(ベーススタイルが読み込まれている場合)
\AtBeginDocument{
  \@ifpackageloaded{caption}{
    \captionsetup{format=hang,font=small,labelfont=bf,labelsep=space}
    \captionsetup[sub]{subrefformat=parens}
  }{}
}
