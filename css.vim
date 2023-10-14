source /home/kdog3682/.vim/ftplugin/css-data.vim

nnoremap <buffer> 0 :call CssNormalKey('0')<CR>
nnoremap <buffer> 1 :call CssNormalKey('1')<CR>
nnoremap <buffer> 2 :call CssNormalKey('2')<CR>
nnoremap <buffer> 3 :call CssNormalKey('3')<CR>
nnoremap <buffer> 4 :call CssNormalKey('4')<CR>
nnoremap <buffer> 5 :call CssNormalKey('5')<CR>
nnoremap <buffer> 6 :call CssNormalKey('6')<CR>
nnoremap <buffer> 7 :call CssNormalKey('7')<CR>
nnoremap <buffer> 8 :call CssNormalKey('8')<CR>
nnoremap <buffer> 9 :call CssNormalKey('9')<CR>

nnoremap <buffer> <CR>    :call CssNormalEnter()<CR>
nnoremap <buffer> <TAB>   :call CssNormalTab()<CR>
nnoremap <buffer> <SPACE> :call CssNormalSpace()<CR>
nnoremap <buffer> <BS>    :call CssNormalBackspace()<CR>

nnoremap <buffer> <SPACE> :call CssNormalSpace()<CR>
nnoremap <buffer> <BS>    :call CssNormalBackspace()<CR>

inoremap <buffer> <expr> qw   CssBlockEnter()
inoremap <buffer> <expr> qe   CssBlockExit()
inoremap <buffer> <expr> wf   CssWriteBlock()
inoremap <buffer> <expr> <CR> CssEnter()
