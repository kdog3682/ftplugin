
setlocal cindent
nunmap <buffer> []
nunmap <buffer> [[
nunmap <buffer> ["

nunmap <buffer> ][
nunmap <buffer> ]]
nunmap <buffer> ]"


inoreab <buffer> sj s = """<CR><CR>"""<UP><LEFT><C-R>=Eatchar('\s')<CR>
inoremap <buffer> = =
inoreab <buffer> forkv for k,v in $1.items():<CR>    <C-R>=Eatchar('\s')<CR>

inoreab <buffer> kg kwargs.get('')<left><left><C-R>=Eatchar('\s')<CR>
inoreab <buffer> asm @staticmethod
inoreab <buffer> lkv lambda k,v:
inoreab <buffer> osc os.system('clear')
inoreab <buffer> rfa re.findall(regex, s, flags=re.M)
inoreab <buffer> j- # ------------------------------------------
inoreab <buffer> gfn getFunctionNames(read())<LEFT><LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer> gf getFirst()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer> ray raise Exception('')<LEFT><LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer> fs f""<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer> rext removeExtension()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer> gext getExtension()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer> cext changeExtension()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer> sext setExtension()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer> ray raise Exception()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer> pr print("")<LEFT><LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer> ple +=
inoreab <buffer> chd chdir("cwd")<C-R>=Eatchar('\s')<CR>
inoreab <buffer> sj s = """<CR><CR>"""<CR><UP><UP><C-R>=Eatchar('\s')<CR>

inoremap <buffer> <expr> qgp Qgp()
inoremap <buffer> <silent> 9 ()<LEFT><C-R>=Eatchar('\s')<CR>
inoremap <buffer> nine 9
inoreab <buffer> <silent>  ldf lastDriveFile()<C-R>=Eatchar('\s')<CR>
inoremap <buffer> e2 <space>==<space>
inoremap <buffer> wf <esc>:call CreateFunctionBlock()<cr>A
inoremap <buffer> wp <esc>:call PySnippet()<cr>a
inoremap <buffer> qw <esc><RIGHT>a
inoreab <buffer> lb #---------------------------------
nnoremap <buffer> lg <UP><CR>:call LogItPython('lg')<CR>
inoreab <buffer> p pprint()<LEFT><C-R>=Eatchar('\s')<CR>

inoremap <buffer> <expr> 3 col('.') == 1 ? '# ' : 3
inoremap <buffer> ` <esc> :call Node1()<CR>


inoreab <buffer>ind index<C-R>=Eatchar('\s')<CR>
inoreab <buffer>= <space>=<C-R>=Eatchar('\s')<CR>
inoremap <buffer> <expr> = SmartEqual()
inoreab <buffer>get get()<C-R>=Eatchar('\s')<CR>
inoreab <buffer>get get()<LEFT><C-R>=Eatchar('\s')<CR>

inoremap <buffer> <Tab> <C-R>=CleverTab()<CR>
