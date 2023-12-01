setlocal nosmartindent
setlocal noautoindent
setlocal completefunc=CssTemplateComplete

inoremap <buffer> <expr> 2 SolExpr('@', 2)
inoremap <buffer> <expr> 3 SolExpr('# ', 3)
