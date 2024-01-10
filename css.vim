source /home/kdog3682/.vim/ftplugin/css-data.vim

nnoremap <buffer> 0 :call CssNormalKey('0')<CR>
nnoremap <buffer> 1 :call CssNormalKey('1')<CR>
nnoremap <buffer> 2 :call CssNormalKey('2')<CR>
nnoremap <buffer> 3 :call CssNormalKey('3')<CR>
nnoremap <buffer> 4 :call CssNormalKey('4')<CR>
nnoremap <buffer> 5 :call CssNormalKey('5')<CR>
nnoremap <buffer> 6 :call CssNormalKey('6')<CR>
nnoremap <buffer> 7 :call CssNormalKey('7')<CR>
" nnoremap <buffer> 8 :call CssNormalKey('8')<CR>
nnoremap <buffer> 9 :call CssNormalKey('9')<CR>
nnoremap <buffer> <c-c> :call CssNormalKey('escape')<CR>
nnoremap <buffer> <BS>    :call CssNormalKey('bs')<CR>
nnoremap <buffer> <CR>    :call CssNormalEnter()<CR>
inoremap <buffer> <expr> <CR> CssEnter()

nnoremap <silent> <buffer> qw :call CssBlockDown()<CR>
nnoremap <silent> <buffer> qe :call CssBlockUp()<CR>
inoremap <silent> <buffer> qw <esc> :call CssBlockDown()<CR>
inoremap <silent> <buffer> qe <esc> :call CssBlockUp()<CR>
inoremap <buffer> qu   <esc><UP>

nnoremap <buffer> wf   :call CssWriteBlock()<CR>
inoremap <buffer> wf   <esc>:call CssWriteBlock()<CR>


nnoremap <buffer> <SPACE> :call CssOmniIncrement(1)<CR>
nnoremap <buffer> \ :call CssOmniIncrement(-1)<CR>


nnoremap <buffer> <TAB>     :call CssSecondaryIncrementWrapper(1)<CR>
nnoremap <buffer> <s-TAB>   :call CssSecondaryIncrementWrapper(-1)<CR>
inoremap <buffer> <silent> <buffer> <expr> <Tab> QQQ()
inoreab <buffer>bc /*<space><space>*/<left><left><left><C-R>=Eatchar('\s')<CR>
inoreab <buffer>v var(--);<left><left><C-R>=Eatchar('\s')<CR>

nnoremap <buffer> ds :call CommentAndSave()<CR>:w<CR>
nnoremap <buffer> c :call GetSetFn('s:toggle_comment')<CR>
nnoremap <buffer> <silent> <expr> <leader>r CssLeaderRExpr()
" nnoremap <silent> <leader>r :call CssLeaderR()<CR>

