source /home/kdog3682/.vim/ftplugin/javascript-data.vim
inoreab  <buffer> 44 ${}<left><c-r>=Eatchar('\s')<cr><C-R>=Eatchar('\s')<CR>
inoreab  <buffer> ar Array.from() <c-r>=Eatchar('\s')<cr><C-R>=Eatchar('\s')<CR>
inoreab  <buffer> con continue<c-r>=Eatchar('\s')<cr><C-R>=Eatchar('\s')<CR>
inoreab  <buffer> fli FindLineIndex('')<left><left><c-r>=Eatchar('\s')<cr><C-R>=Eatchar('\s')<CR>
inoreab  <buffer> ge getExtension()<left><c-r>=Eatchar('\s')<cr><C-R>=Eatchar('\s')<CR>
inoreab  <buffer> hop hasOwnProperty()<left><c-r>=Eatchar('\s')<cr><C-R>=Eatchar('\s')<CR>
inoreab  <buffer> isa isArray() ? <left><left><left><left><c-r>=Eatchar('\s')<cr><C-R>=Eatchar('\s')<CR>
inoreab  <buffer> isf isFunction() ? <left><left><left><left><c-r>=Eatchar('\s')<cr><C-R>=Eatchar('\s')<CR>
inoreab  <buffer> iso isObject() ? <left><left><left><left><c-r>=Eatchar('\s')<cr><C-R>=Eatchar('\s')<CR>
inoreab  <buffer> iss isString() ? <left><left><left><left><c-r>=Eatchar('\s')<cr><C-R>=Eatchar('\s')<CR>
inoreab  <buffer> l console.log()<left><c-r>=Eatchar('\s')<cr><C-R>=Eatchar('\s')<CR>
inoreab  <buffer> la console.log(arguments)<c-r>=Eatchar('\s')<cr><C-R>=Eatchar('\s')<CR>
inoreab  <buffer> nine 9<c-r>=Eatchar('\s')<cr><C-R>=Eatchar('\s')<CR>
inoreab  <buffer> oa Object.assign()<left><c-r>=Eatchar('\s')<cr><C-R>=Eatchar('\s')<CR>
inoreab  <buffer> oe Object.entries()<left><c-r>=Eatchar('\s')<cr><C-R>=Eatchar('\s')<CR>
inoreab  <buffer> ok Object.keys()<left><c-r>=Eatchar('\s')<cr><C-R>=Eatchar('\s')<CR>
inoreab  <buffer> ov Object.values()<left><c-r>=Eatchar('\s')<cr><C-R>=Eatchar('\s')<CR>
inoreab  <buffer> pe +=<C-R>=Eatchar('\s')<CR>
inoreab  <buffer> r return<C-R>=Eatchar('\s')<CR>
inoreab  <buffer> reg RegExp(``)<left><left><c-r>=Eatchar('\s')<cr><C-R>=Eatchar('\s')<CR>
inoreab  <buffer> ret return
inoreab  <buffer> rnp randomPick()<left><c-r>=Eatchar('\s')<cr><C-R>=Eatchar('\s')<CR>
inoreab  <buffer> rp randomPick()<left><c-r>=Eatchar('\s')<cr><C-R>=Eatchar('\s')<CR>
inoreab  <buffer> rv return value<c-r>=Eatchar('\s')<cr><C-R>=Eatchar('\s')<CR>
inoreab  <buffer> semi ;<c-r>=Eatchar('\s')<cr><C-R>=Eatchar('\s')<CR>
inoreab  <buffer> slp await sleep(500)<left><c-r>=Eatchar('\s')<cr><C-R>=Eatchar('\s')<CR>
inoreab  <buffer> sn '\n'<c-r>=Eatchar('\s')<cr><C-R>=Eatchar('\s')<CR>
inoreab  <buffer> snsn '\n\n'<c-r>=Eatchar('\s')<cr><C-R>=Eatchar('\s')<CR>
inoreab  <buffer> srep s.replace()<left><c-r>=Eatchar('\s')<cr><C-R>=Eatchar('\s')<CR>
inoreab  <buffer> td ``<left><c-r>=Eatchar('\s')<cr><C-R>=Eatchar('\s')<CR>
inoreab  <buffer> th this
inoreab  <buffer> tj toJSON()<left><c-r>=Eatchar('\s')<cr><C-R>=Eatchar('\s')<CR>
inoreab  <buffer> ts toString()<left><c-r>=Eatchar('\s')<cr><C-R>=Eatchar('\s')<CR>



inoremap <buffer> <expr> ' SmartQuote()
inoremap <buffer> <expr> 9 SmartNine('(')
inoremap <buffer> <expr> = SmartEqual()
inoremap <buffer> <expr> [ SmartNine('[')
inoremap <buffer> qp (<c-o>A)<LEFT>
" inoremap <buffer> qw <right>
inoremap <buffer> w, <esc>:call PySnippet4()<cr>
inoremap <buffer> <expr> wf JPCreateFunctionBlockAsExpression()
inoremap <buffer> <expr> { SmartNine('{')
nnoremap <buffer> wf :call JPCreateFunctionBlockNormal()<cr>
inoreab <buffer> <expr> lx JavascriptLambdaExpression()
inoreab <buffer> ls (s)<space>=>
inoreab <buffer> <silent> <expr> r SmartReturn()

inoreab <buffer>ndy throw<space>"not<space>done<space>yet"<C-R>=Eatchar('\s')<CR>
inoreab <silent> <buffer>-- ---------------------------------------<C-R>=Eatchar('\s')<CR>


inoreab <buffer>ae addExtension()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer> <expr> echo JavascriptEcho()
inoreab <buffer>lxi (x,i)<space>=>
" inoremap <silent> <buffer> <expr> qe QEvaluateManager()
nnoremap <silent> <buffer> <expr> <leader>d SearchDateExpr()

" cnoremap <silent> <buffer> <expr> gm CnoremapExpressionHandler('gm', '/', "\<ESC>\<ESC>?\\v^---\<CR>/\\v^func\<CR>zz")
inoreab <buffer>tlc toLowerCase()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer>ci configItems<C-R>=Eatchar('\s')<CR>

inoreab <buffer>lt .log(files);<space>throw<space>'';<LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer>lt console.log();<space>throw<space>'';<LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><C-R>=Eatchar('\s')<CR>


" inoremap <silent> <buffer> qw <ESC>:call NormalQW()<CR>
" nnoremap <silent> <buffer> qw :call NormalQW()<CR>
" inoremap <silent> <buffer> qe <ESC>:call NormalQE()<CR>
" nnoremap <silent> <buffer> qe :call NormalQE()<CR>
" nnoremap <silent> <buffer> qu :call NormalQU()<CR>
" inoremap <silent> <buffer> qu <ESC>:call NormalQU()<CR>
nnoremap <silent><buffer> 3 #
" inoremap <silent><buffer> 4 $
inoremap <silent><buffer> $ 4
inoreab <buffer>var. variables.<C-R>=Eatchar('\s')<CR>
inoreab <buffer>inc includes<C-R>=Eatchar('\s')<CR>
inoreab <buffer>nd new<space>Date()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer>fi findIndex<C-R>=Eatchar('\s')<CR>
inoreab <buffer>uni unique()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer>pi /*<space>prettier-ignore<space>*/<C-R>=Eatchar('\s')<CR>
inoreab <buffer> <expr> ls JSLambdaExpr()
inoreab <buffer>bc /*<space><space>*/<left><left><left><C-R>=Eatchar('\s')<CR>
inoreab <buffer>ide identity<C-R>=Eatchar('\s')<CR>
inoreab <silent> <buffer> <expr> tl TLExpr('tl', 1)
inoreab <buffer>44 ${}<left><C-R>=Eatchar('\s')<CR>
inoreab <buffer>$$ ${}<left><C-R>=Eatchar('\s')<CR>
inoreab <buffer>a2 tr<C-R>=Eatchar('\s')<CR>
inoreab <buffer>a2 assertion2()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer>$$ ${}<left><C-R>=Eatchar('\s')<CR>
inoreab <buffer>af Array.from()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer>ten throw<space>new<space>Error()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer>[[ {}<<left>><C-R>=Eatchar('\s')<CR>
inoreab <buffer>[[ {}<left><C-R>=Eatchar('\s')<CR>
inoreab <buffer>[[ {}<C-R>=Eatchar('\s')<CR>
inoreab <buffer>[[ {}<left><C-R>=Eatchar('\s')<CR>



" inoremap <buffer> <silent> <Tab> <C-R>=CleverTab()<CR>
setlocal completefunc=JavascriptComplete
autocmd! CompleteDone  *.js call JSOnCompleteDone()
" inoremap <silent> <buffer> <expr> <Tab> QQQ()
inoremap <silent> <buffer> <expr> <Tab> QQQ()
" inoremap <buffer> <expr> <space> SpaceCompletion()
inoreab <buffer>rt return<space>true<C-R>=Eatchar('\s')<CR>

inoreab <expr> <buffer>lg LogExpr()
inoreab <buffer>66 [^]+?<C-R>=Eatchar('\s')<CR>
inoreab <buffer>88 \/\*<space><space>\*\/<left><left><left><left><left><C-R>=Eatchar('\s')<CR>
inoreab <buffer>brow browserChalk()<C-R>=Eatchar('\s')<CR>
inoreab <buffer> lkv ([k,v]) =>
inoreab <buffer>na node.assign()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer>lb console.browser()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer>tau TAU<C-R>=Eatchar('\s')<CR>
inoreab <buffer>re RegExp()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer>r return

inoreab <buffer> tdb `<c-o>o`,<c-o>O<space><space><space><space><C-R>=Eatchar('\s')<CR>

inoremap <buffer> w] [<c-o>o],<c-o>O<space><space><space><space><C-R>=Eatchar('\s')<CR>

inoreab <buffer>reg regex<C-R>=Eatchar('\s')<CR>

nnoremap <buffer> tl :call NormalThrowLog()<cr> 
inoreab <buffer>map smart_map()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer>cb crayonbox.red()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer>rr r<C-R>=Eatchar('\s')<CR>
inoreab <buffer> <expr> dt GetTime()

