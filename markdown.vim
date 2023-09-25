inoreab <buffer> hi from "/home/kdog3682/.vim/ftplugin/markdown.vim"
inoreab <buffer> <expr> ds strftime('%m-%d-%Y')
inoremap <buffer> ;l --------------------------------
inoreab <buffer> lb --------------------------------

inoremap <buffer> <silent> <expr> 2 TextTwo()
inoremap <buffer> <silent> <expr> 3 TextThree()
inoremap <buffer> <silent> [ []<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> ar --> 

inoremap <expr> = col('.') == 1 ? '+ ' : getline('.')[col('.') - 2]  == ' ' ? '= ':' = '
inoremap <expr> 3 col('.') == 1 ? '# ' : 3



inoremap <buffer> <silent> <expr> \ TextBackSlash(0)
nnoremap <buffer> \ :call TextBackSlash(1)<CR>a
inoremap <buffer> td ``<LEFT><C-R>=Eatchar('\s')<CR>
nnoremap <buffer> qw A<CR><space><space><space>
nnoremap <buffer> qe A<CR><esc><<I
inoremap <buffer> qw <CR><TAB> 
inoremap <buffer> qe <CR><esc><<A

nnoremap <buffer> qe A<CR><esc><<I
inoremap <buffer> qe <esc>o<backspace>
inoremap <buffer> qw <ESC>A<CR><space><space><space><space>
nnoremap <buffer> qw A<CR><space><space><space><space>
nnoremap ` :call MoveCursorByDateStamp()<CR>
