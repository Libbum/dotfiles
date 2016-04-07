$latex = 'latex -file-line-error -synctex=-1 --shell-escape --extra-mem-top=10000000 --save-size=80000 %O %S';
$pdflatex = 'pdflatex -file-line-error -synctex=-1 --shell-escape --extra-mem-top=10000000 --save-size=80000 %O %S';
$pdf_mode = 1;
$pdf_previewer = 'zathura';
$max_repeat = 8;
$postscript_mode = $dvi_mode = 0;
add_cus_dep('nlo', 'nls', 0, 'makeidxlev');
sub makeidxlev {
   system( "makeindex -s nomenlev.ist -o \"$_[0].nls\" \"$_[0].nlo\"" );
}
$max_repeat = 10
