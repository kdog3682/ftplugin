setlocal nosmartindent

inoremap <buffer> <expr> qw HtmlBlockEnter()
inoremap <buffer> <expr> qe HtmlBlockExit()
inoremap <buffer> <expr> qu HtmlBlockExitUp()
inoremap <buffer> <expr> bc HtmlCommentExpr()
nnoremap <buffer>   qw HtmlBlockNormalEnter()
nnoremap <buffer>   qe HtmlBlockNormalExit()
nnoremap <buffer>   c ToggleHtmlComment()

vnoremap <buffer> , :<c-u>call VhtmlBlockDedent()<CR>
vnoremap <buffer> . :<c-u>call VhtmlBlockIndent()<CR>
