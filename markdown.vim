" setlocal nosmartindent
setlocal completefunc=MarkdownComplete
" setlocal noautoindent

" inoremap <buffer> <expr> <space> MDPumExpr('space')
" this caused many items to stop working
nnoremap <buffer> ` :call MoveCursorByDateStamp()<CR>
inoreab <buffer> <expr> ds MarkdownDate()
inoreab <buffer> td ``<LEFT><C-R>=Eatchar('\s')<CR>

inoremap <buffer> <expr> <CR> MarkdownSmartEnter()
inoremap <buffer> <expr> q[ MarkdownEnterList()
inoremap <buffer> <expr> q] MarkdownExitList()
" inoremap <buffer> <expr> - MarkdownDash()
inoremap <buffer> <expr> <TAB> MarkdownTab()

inoremap <buffer> <expr> 1 MDPumExpr(1)
inoremap <buffer> <expr> 2 MDPumExpr(2)
inoremap <buffer> <expr> 3 MDPumExpr(3)
inoremap <buffer> <expr> 4 MDPumExpr(4)
inoremap <buffer> <expr> 5 MDPumExpr(5)
inoremap <buffer> <expr> 6 MDPumExpr(6)
inoremap <buffer> <expr> 7 MDPumExpr(7)
inoremap <buffer> <expr> 8 MDPumExpr(8)
" inoremap <buffer> <expr> - MDPumExpr('-')
inoremap <buffer> <expr> <space> MDPumExpr('space')
inoremap <buffer> <expr> 0 MDPumExpr('zero')
" inoremap <buffer> <expr> . MDPeriodExpr()
inoremap <buffer> <expr> , MDPunctuationExpr(',')
inoremap <buffer> <expr> ! MDPunctuationExpr('!')

inoremap <buffer> qw <ESC>:call MarkdownNormalQW()<CR>
nnoremap <buffer> qe :call MarkdownNormalQE()<CR>
inoremap <buffer> qe <ESC>:call MarkdownNormalQE()<CR>
nnoremap <buffer> qw :call MarkdownNormalQW()<CR>
inoremap <buffer> <c-n> <esc>Go<C-O>I<cr># 
nnoremap <buffer> <c-n> Go<C-O>I<cr># 

inoremap <buffer> <expr> 2 SolExpr('@', 2)
inoremap <buffer> <expr> 3 SolExpr('# ', 3)


nnoremap <buffer> qw :call MarkdownNormalQW()<CR>
