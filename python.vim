call UnmapPython()

inoremap <silent> <buffer> <expr> = PythonSmartEqual()
" inoremap <silent> <buffer> <expr> <cr> PythonSmartEnter()
inoremap <silent> <buffer> <expr> <Tab> QQQ()
inoremap <buffer> ` <esc> :call Node1()<CR>
inoremap <buffer> <expr> qgp Qgp()
inoreab <buffer>pr print()<LEFT><C-R>=Eatchar('\s')<CR>
inoremap <buffer> wf <ESC>:call PythonFunctionBlock()<CR>
nnoremap <buffer> wf :call PythonNormalFunctionBlock()<CR>

inoremap <buffer> <expr> 9 SmartNine('(')
nnoremap <silent><buffer> 3 #
inoremap <buffer> qp (<c-o>A)<LEFT>
