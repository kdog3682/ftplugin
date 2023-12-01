inoremap <silent> <buffer> <expr> = PythonSmartEqual()
inoremap <silent> <buffer> <expr> <Tab> QQQ()
inoremap <buffer> <expr> qgp Qgp()
inoremap <buffer> wf <ESC>:call PythonFunctionBlock()<CR>
nnoremap <buffer> wf :call PythonNormalFunctionBlock()<CR>
inoremap <buffer> <expr> 9 SmartNine('(')
nnoremap <silent><buffer> 3 #
inoremap <buffer> qp (<c-o>A)<LEFT>
inoreab <buffer>3 #
inoreab <buffer>2 @<C-R>=Eatchar('\s')<CR>
inoremap <buffer> ' ""<LEFT>
