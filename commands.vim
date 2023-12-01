this file is not actually called anywhere
it is not sourced in any files
it is not valid vimscript
it is just a repository for chosing commands

inoremap <buffer> <expr> 2 SolExpr('@', 2)
inoremap <buffer> <expr> 3 SolExpr('# ', 3)
inoremap <buffer> qw <ESC>:call MarkdownNormalQW()<CR>
nnoremap  qe <ESC>:call MarkdownNormalQE()<CR>
inoremap  qw <ESC>:call MarkdownNormalQW()<CR>
nnoremap  qw :call MarkdownNormalQW()<CR>
inoremap  qe <ESC>:call MarkdownNormalQE()<CR>
nnoremap  qe :call MarkdownNormalQE()<CR>
