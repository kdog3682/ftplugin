iab <buffer> h8 asdfjk
iab <buffer> h7 asdfjkfffffffff
inoreab <buffer> <expr> ds strftime('%m-%d-%Y')
inoremap <buffer> ;l --------------------------------

"inoremap mse math.start<CR><CR><CR><CR>math.end<UP><UP><TAB>
inoremap <buffer> <silent> <expr> ] TextBracketRight()
inoremap <buffer> lb <esc>:call Foo()<CR>
inoremap <buffer> <silent> <expr> [ TextBracketLeft()
inoremap <buffer> <silent> <expr> 2 TextTwo()
inoremap <buffer> <silent> <expr> 3 TextThree()
inoremap <buffer> <silent> <expr> \ TextBackSlash(0)
nnoremap <buffer> \ :call TextBackSlash(1)<CR>a

"iab <buffer> hve hhhhhhhhhhhhhhhhhhhhhhhhhhhhh
"inoremap <buffer> wp <esc>:call WPText()<CR>
"inoremap <buffer> wx <esc>:call WPText()<CR>
"nnoremap <buffer> gf <esc>:call WPText()<CR>
iab <buffer> hx abcde
inoremap <buffer> td ``<LEFT><C-R>=Eatchar('\s')<CR>
