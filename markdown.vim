setlocal nosmartindent
setlocal noautoindent

nnoremap <buffer> ` :call MoveCursorByDateStamp()<CR>

inoreab <buffer> <expr> ds '# ' . strftime('%m-%d-%Y')
inoreab <buffer> td ``<LEFT><C-R>=Eatchar('\s')<CR>

inoremap <buffer> <expr> <CR> MarkdownSmartEnter()
inoremap <buffer> <expr> q[ MarkdownEnterList()
inoremap <buffer> <expr> q] MarkdownExitList()
inoremap <buffer> <expr> - MarkdownDash()
inoremap <buffer> <expr> <TAB> MarkdownTab()
inoremap <buffer> <expr> qw MarkdownEnter()
inoremap <buffer> <expr> qe MarkdownExit()

inoremap <silent> <buffer> <expr> <space> QQQ()
