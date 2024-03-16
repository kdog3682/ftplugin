inoremap <buffer> <expr> ' SmartQuote()
inoremap <buffer> <expr> 9 SmartNine('(')
inoremap <buffer> <expr> = SmartEqual()
inoremap <buffer> <expr> [ SmartNine('[')
inoremap <buffer> qp (<c-o>A)<LEFT>
inoremap <buffer> <expr> wf JPCreateFunctionBlockAsExpression()
inoremap <buffer> <expr> = SmartEqual2()
" set nosmartindent
" set noautoindent
inoremap <buffer> <expr> <cr> VueEnter()
inoremap <buffer> <expr> [ VueBrace()
inoreab <buffer>th this<C-R>=Eatchar('\s')<CR>
