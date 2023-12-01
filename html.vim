setlocal nosmartindent

" inoremap <buffer> <expr> qe HtmlBlockExit()
" inoremap <buffer> <expr> qw HtmlBlockEnter()
" inoremap <buffer> <expr> qe HtmlBlockExit()
" inoremap <buffer> <expr> qu HtmlBlockExitUp()
inoremap <buffer> <expr> bc HtmlCommentExpr()
vnoremap <buffer> , :<c-u>call VhtmlBlockDedent()<CR>
vnoremap <buffer> . :<c-u>call VhtmlBlockIndent()<CR>
