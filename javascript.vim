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
inoremap <buffer> qw <right>
inoremap <buffer> w, <esc>:call PySnippet4()<cr>a
inoremap <buffer> <expr> wf JPCreateFunctionBlockAsExpression()
inoremap <buffer> <expr> { SmartNine('{')
nnoremap <buffer> wf :call JPCreateFunctionBlockNormal()<cr>
inoremap <buffer> <expr> qq QSlashWordFind(GetJavascript())
inoreab <buffer> <expr> lx JavascriptLambdaExpression()
inoreab <buffer> ls (s)<space>=>
inoreab <buffer> <expr> r SmartReturn()
inoremap <buffer> <silent> <Tab> <C-R>=CleverTab()<CR>

inoreab <buffer>ndy throw<space>"not<space>done<space>yet"<C-R>=Eatchar('\s')<CR>
inoreab <buffer>-- ---------------------------------------<C-R>=Eatchar('\s')<CR>

" setlocal completefunc=JavascriptComplete

