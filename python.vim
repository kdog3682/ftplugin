call UnmapPython()

inoremap <silent> <buffer> <expr> = PythonSmartEqual()
" inoremap <silent> <buffer> <expr> <cr> PythonSmartEnter()
inoremap <silent> <buffer> <expr> <Tab> QQQ()
inoremap <buffer> ` <esc> :call Node1()<CR>
inoremap <buffer> <expr> qgp Qgp()
