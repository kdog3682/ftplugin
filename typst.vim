setlocal tabstop=2
setlocal nosmartindent


inoremap <buffer> wf <ESC>:call PythonFunctionBlock()<CR>
nnoremap <buffer> wf :call PythonNormalFunctionBlock()<CR>
inoremap q9 (<C-O>o)<c-o>O<space><space>
inoremap q[ [<C-O>o]<c-o>O<space><space>
inoremap q] <space>{<C-O>o}<c-o>O<space><space>
inoremap q3 #{<C-O>o}<c-o>O<space><space>
inoremap <buffer> <expr> / FTEF_Typst_CommentSlash()
inoremap <buffer> <expr> - FTEF_Typst_Dash()
inoremap <buffer> <expr> 3 FTEF_Typst_NumberOrSymbol('3', '#')
inoremap <buffer> <expr> p FTEF_Typst_MathMode('p')
inoremap <buffer> <expr> 4 FTEF_Typst_NumberOrSymbol('4', '$$<left>')
inoremap <buffer> <expr> 9 SmartNine('(')
inoremap <buffer> <expr> = FTEF_Typst_SmartEqual()
inoremap <buffer> <expr> " FTEF_Typst_SmartQuote()
nnoremap <buffer> <c-b> FTEF_Typst_WordWrap('*', '*')
nnoremap <buffer> <localleader>b :call FTEF_Typst_WordWrap('*', '*')<CR>
nnoremap <buffer> 3 :call FTEF_Typst_WordWrap('#', '')<CR>
inoremap <silent> <buffer> <expr> <Tab> QQQ()

nnoremap <buffer> 4 /^\v#?let 

inoremap  qw <ESC>:call TypstNormalQW()<CR>
nnoremap  qw :call TypstNormalQW()<CR>
inoremap  qe <ESC>:call TypstNormalQE()<CR>
nnoremap  qe :call TypstNormalQE()<CR>
inoreab <buffer> <silent> <expr> r SmartReturn()
