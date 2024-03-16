inoreab <buffer>le <lt>LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer>ri <lt>RIGHT><C-R>=Eatchar('\s')<CR>
inoreab <buffer>be <lt>buffer><C-R>=Eatchar('\s')<CR>
inoreab <buffer>si <lt>silent><C-R>=Eatchar('\s')<CR>
inoreab <buffer>ex <lt>expr><C-R>=Eatchar('\s')<CR>
inoreab <buffer>co <lt>c-o><C-R>=Eatchar('\s')<CR>
inoreab <buffer>esc <lt>esc><C-R>=Eatchar('\s')<CR>
inoreab <buffer>imap inoremap <lt>buffer>
inoreab <buffer>nmap nnoremap <lt>buffer> <lt>expr>

inoremap <buffer>_ -
inoremap <buffer>- _
" for text files: single-quote becomes double-quote na
inoremap <buffer> ' ""<LEFT>


" for python: swap dash and underscore
inoremap <buffer> - _
inoremap <buffer> _ -
inoreab <buffer> ,. <lt>><left><C-R>=Eatchar('\s')<CR>
