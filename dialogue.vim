setlocal completefunc=MarkdownCompleteFunc
setlocal nosmartindent
setlocal noautoindent

inoremap <buffer> <expr> <CR> MarkdownSmartEnter()
inoremap <buffer> <expr> q[ MarkdownEnterList()
inoremap <buffer> <expr> q] MarkdownExitList()
inoremap <buffer> <expr> - MarkdownDash()
inoremap <buffer> <expr> <TAB> MarkdownTab()
inoremap <buffer> <expr> qw MarkdownEnter()
inoremap <buffer> <expr> qe MarkdownExit()

inoreab <buffer> td ``<LEFT><C-R>=Eatchar('\s')<CR>
