call UnmapPython()

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
inoreab <buffer>true True()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer>false False()<LEFT><C-R>=Eatchar('\s')<CR>

inoremap <buffer> ' ""<LEFT>
inoremap <buffer> _ -
inoremap <buffer> - _

inoreab <buffer>sa store.append()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer>con continue<C-R>=Eatchar('\s')<CR>
inoreab <buffer>null None()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer>r return
inoreab <buffer>lx lambda<space>x:
inoreab <buffer>p pprint()<LEFT><C-R>=Eatchar('\s')<CR>
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
