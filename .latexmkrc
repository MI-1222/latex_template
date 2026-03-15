#!/usr/bin/env perl

$latex = 'uplatex -synctex=1 -interaction=nonstopmode -file-line-error -halt-on-error %O %S';
$dvipdf = 'dvipdfmx %O -o %D %S';
$makeindex = 'makeindex %O -o %D %S';

# uplatexは3,lualatexは4
$pdf_mode = 3;

$max_repeat = 5;
