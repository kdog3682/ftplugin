inoremap <silent> <buffer> <expr> = PythonSmartEqual()
" inoremap <silent> <buffer> <expr> <cr> PythonSmartEnter()
inoremap <silent> <buffer> <expr> <Tab> QQQ()
inoremap <buffer> ` <esc> :call Node1()<CR>
inoremap <buffer> <expr> qgp Qgp()
inoreab <buffer>pr print()<LEFT><C-R>=Eatchar('\s')<CR>
inoremap <buffer> wf <ESC>:call PythonFunctionBlock()<CR>
nnoremap <buffer> wf :call PythonNormalFunctionBlock()<CR>

inoremap <buffer> <expr> 9 SmartNine('(')
nnoremap <silent><buffer> 3 #
inoremap <buffer> qp (<c-o>A)<LEFT>
inoreab <buffer>ret return

inoremap <buffer> ' ""<LEFT>
inoremap <buffer> _ -
inoremap <buffer> - _

inoreab <buffer>sa store.append()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer>con continue<C-R>=Eatchar('\s')<CR>
inoreab <buffer>null None()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer>r return
inoreab <buffer>lx lambda<space>x:
inoreab <buffer>ass assert
inoreab <buffer>isa is_array()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer>iso is_object()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer>isn is_number()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer>isf is_function()<LEFT><C-R>=Eatchar('\s')<CR>
inoremap <buffer> ` <esc>:w<cr> :! clear; python3 %<cr>
inoreab <buffer>ge get_extension()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer>ray raise<space>Exception()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer>pl print(len())<LEFT><LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer>aobj {a:"1"}<C-R>=Eatchar('\s')<CR>
inoreab <buffer>none None()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer>gcn get_constructor_name<C-R>=Eatchar('\s')<CR>
inoreab <buffer>istaw Is<space>there<space>a<space>way<C-R>=Eatchar('\s')<CR>
" call UnmapPython()
inoreab  <buffer> td ``<left><c-r>=Eatchar('\s')<cr><C-R>=Eatchar('\s')<CR>
" inoremap <buffer> <expr> 3 FTEF_Typst_NumberOrSymbol('3', '#')
inoreab <buffer>defs DEFINITIONS()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer>pe +=
inoreab <buffer>se self<C-R>=Eatchar('\s')<CR>
inoreab <buffer>rt return<space>True<C-R>=Eatchar('\s')<CR>
inoreab <buffer>rf return<space>False<C-R>=Eatchar('\s')<CR>
inoreab <buffer>qc '<C-R>=Eatchar('\s')<CR>
inoreab <buffer>cc ''<<left>><C-R>=Eatchar('\s')<CR>
inoreab <buffer>cc ''<C-R>=Eatchar('\s')<CR>
inoreab <buffer>cc ''<left><C-R>=Eatchar('\s')<CR>
inoreab <buffer>44 {}<left><C-R>=Eatchar('\s')<CR>
inoreab <buffer>$$ {}<left><C-R>=Eatchar('\s')<CR>
inoreab <buffer>is boo<C-R>=Eatchar('\s')<CR>
inoreab <buffer>sn "\n"<C-R>=Eatchar('\s')<CR>
