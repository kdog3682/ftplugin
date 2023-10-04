
setlocal completefunc=MarkdownCompleteFunc
setlocal nosmartindent
setlocal noautoindent

nnoremap <buffer> ` :call MoveCursorByDateStamp()<CR>

" cnoreab <buffer>td todo<C-R>=Eatchar('s')<CR><CR>
" cnoremap <buffer> <expr> td "todo\<CR>"

inoreab <buffer> <expr> ds strftime('%m-%d-%Y')
inoreab <buffer> td ``<LEFT><C-R>=Eatchar('\s')<CR>

inoremap <buffer> <expr> <CR> MarkdownSmartEnter()
inoremap <buffer> <expr> q[ MarkdownEnterList()
inoremap <buffer> <expr> q] MarkdownExitList()
inoremap <buffer> <expr> - MarkdownDash()
inoremap <buffer> <expr> <TAB> MarkdownTab()
inoremap <buffer> <expr> qw MarkdownEnter()
inoremap <buffer> <expr> qe MarkdownExit()


let s:mode = 'todo'
function! MarkdownAnythingHandler(key)
    let key = a:key
    let s:mode = key
endfunction

nnoremap <buffer> : :call MarkdownAnythingHandler('')<LEFT>
nnoremap <buffer> <expr> MarkdownModeSearch(s:mode)<CR>
