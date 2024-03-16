setlocal nosmartindent
inoremap <silent> <buffer> <expr> <Tab> QQQ()
inoremap <buffer> " ""<LEFT>

inoremap <buffer> <expr> 2 SolExpr('@', 2)
inoremap <buffer> <expr> 3 SolExpr('# ', 3)

inoremap <buffer> <expr> 1 MDPumExpr(1)
inoremap <buffer> <expr> 2 MDPumExpr(2)
inoremap <buffer> <expr> 3 MDPumExpr(3)
inoremap <buffer> <expr> 4 MDPumExpr(4)
inoremap <buffer> <expr> 5 MDPumExpr(5)
inoremap <buffer> <expr> 6 MDPumExpr(6)
inoremap <buffer> <expr> 7 MDPumExpr(7)
inoremap <buffer> <expr> 8 MDPumExpr(8)
inoremap <buffer> <expr> 9 MDPumExpr(9)
nnoremap <buffer> <space> :call SetVimSpeaker()<CR>
