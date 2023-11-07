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
" increment g:s by the number

nnoremap <buffer> <BS>    :call CssNormalKey('bs')<CR>
" delete g:s by 1 char

nnoremap <buffer> <CR>    :call CssNormalEnter()<CR>
" submit the g:s string to affect current line

nnoremap <silent> <buffer> qw :call CssBlockDown()<CR>
nnoremap <silent> <buffer> qe :call CssBlockUp()<CR>

inoremap <silent> <buffer> qw <esc> :call CssBlockDown()<CR>
inoremap <silent> <buffer> qe <esc> :call CssBlockUp()<CR>

nnoremap <buffer> wf   :call CssWriteBlock()<CR>
inoremap <buffer> wf   <esc>:call CssWriteBlock()<CR>

inoremap <buffer> qu   <esc><UP>
inoremap <buffer> <expr> <CR> CssEnter()
" has some editing utilities for the line
" add semi colons

" setlocal completefunc=CssDotCompletion
" inoremap <silent> <buffer> . <C-R>=CssDotCompletionExpr()<CR>
" dot completion
" i dont think it is necessary

nnoremap <buffer> <TAB>   :call GetSetFn('CssSecondaryIncrement')<CR>
" nnoremap <buffer> \       :call CssNormalBackslash()<CR>
" not active

nnoremap <buffer> <SPACE> :call CssOmniIncrement()<CR>
" if has px | % ... increment the unit
" else if is selector ... increment the pseudo

