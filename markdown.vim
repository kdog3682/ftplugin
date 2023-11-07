setlocal nosmartindent
setlocal completefunc=VimComplete
setlocal noautoindent

nnoremap <buffer> ` :call MoveCursorByDateStamp()<CR>

inoreab <buffer> <expr> ds '# ' . strftime('%m-%d-%Y')
inoreab <buffer> td ``<LEFT><C-R>=Eatchar('\s')<CR>

inoremap <buffer> <expr> <CR> MarkdownSmartEnter()
inoremap <buffer> <expr> q[ MarkdownEnterList()
inoremap <buffer> <expr> q] MarkdownExitList()
inoremap <buffer> <expr> - MarkdownDash()
inoremap <buffer> <expr> qw MarkdownEnter()
inoremap <buffer> <expr> qe MarkdownExit()
inoremap <buffer> <expr> <TAB> MarkdownTab()


inoremap <buffer> <expr> 1 MDPumExpr(1)
inoremap <buffer> <expr> 2 MDPumExpr(2)
inoremap <buffer> <expr> 3 MDPumExpr(3)
inoremap <buffer> <expr> 4 MDPumExpr(4)
inoremap <buffer> <expr> 5 MDPumExpr(5)
inoremap <buffer> <expr> 6 MDPumExpr(6)
inoremap <buffer> <expr> 7 MDPumExpr(7)
inoremap <buffer> <expr> 8 MDPumExpr(8)
inoremap <buffer> <expr> <space> MDPumExpr('space')
inoremap <buffer> <expr> <esc> MDPumExpr('esc')
inoremap <buffer> <expr> 0 MDPumExpr('zero')
inoremap <buffer> <expr> . MDPeriodExpr()
inoremap <buffer> <expr> , MDPunctuationExpr(',')
inoremap <buffer> <expr> ! MDPunctuationExpr('!')

