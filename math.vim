" inoremap <buffer> <expr> 2 FTEF_Typst_NumberOrSymbol('@', '2')
" inoremap <buffer> <expr> 2 FTEF_Typst_NumberOrSymbol('!', '1')
" inoremap <buffer> <expr> 5 FTEF_Typst_Five()
" inoremap <buffer> <expr> 4 FTEF_Typst_NumberOrSymbol('$', '4')
" inoremap <buffer> <expr> 3 FTEF_Typst_NumberOrSymbol('#', '3')
" inoremap <buffer> <expr> 6 FTEF_Typst_NumberOrSymbol('6', '^')
" inoremap <buffer> qp (<c-o>A)<LEFT>
" inoremap <buffer> <expr> ` '``<LEFT>'
inoremap <buffer> ` ~<cr><C-R>=Eatchar('\s')<CR>
nnoremap <buffer> ` i~<cr><C-R>=Eatchar('\s')<CR>
" inoremap <buffer> qp (<c-o>A)<LEFT>
" inoremap <buffer> <expr> = TypstMathSmartEqual()
" inoreab <buffer>lb ------------------------------<C-R>=Eatchar('\s')<CR>
" inoreab <buffer>__ -----------------------------------<CR><C-R>=Eatchar('\s')<CR>
" inoremap <buffer>\ <esc>^o-----------------------------------<CR><C-R>=Eatchar('\s')<CR>
" nnoremap <buffer>\ o-----------------------------------<CR><C-R>=Eatchar('\s')<CR>
