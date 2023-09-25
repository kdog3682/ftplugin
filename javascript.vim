inoreab <buffer> <silent> ti this.index<C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> q4 ${}<LEFT><C-R>=Eatchar('\s')<CR>
"inoremap <buffer> <buffer> fu function<space>
"inoremap <buffer> Com Component
inoreab <buffer> isa isArray() ? <LEFT><LEFT><LEFT><LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer> isf isFunction() ? <LEFT><LEFT><LEFT><LEFT><C-R>=Eatchar('\s')<CR>
inoremap <buffer> q4 <ESC>A
inoreab <buffer> lab let [a,b] =
inoreab <buffer> sto storage<C-R>=Eatchar('\s')<CR>
inoreab <buffer> ar Array.from() <C-R>=Eatchar('\s')<CR>
inoreab <buffer> al1 args.length == 1 ? 
inoreab <buffer> sg storage.get('')<LEFT><LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer> cor const regex =
inoremap <buffer> qd ${}<LEFT>
inoreab <buffer> af Array.from()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer> dp display()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer> dp display([])<LEFT><LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer> ge getExtension()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer> rts reduceToString()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer> bc /*  */<LEFT><LEFT><LEFT><C-R>=Eatchar('\s')<CR>
inoremap <buffer> tilda ``
inoremap <buffer> Fu Function
inoremap <buffer> Rep Rep
inoremap <buffer> coc const children = 
inoreab <buffer> tf (s) => test(regex, s)<C-R>=Eatchar('\s')<CR>
inoremap <buffer> td ``<LEFT><C-R>=Eatchar('\s')<CR>
inoremap <buffer> cok const key = 
inoremap <buffer> cov const value = 
inoremap <buffer> q[ (<ESC>/\v[\.]\w+/e<CR>a)
inoreab <buffer> <silent> rext removeExtension()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> dp display()<LEFT><C-R>=Eatchar('\s')<CR>
inoremap <buffer> w. <space>{<CR><ESC>o}<UP><space><space><space><space>
inoreab <buffer> <silent> jss JSON.stringify()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> asto {'a': ["A", "B"]}<C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> cn className<C-R>=Eatchar('\s')<CR>
inoremap <buffer> q] [<CR><CR>]<UP>   
inoreab <buffer> <silent> labo let [a,b] = splitonce(s)<C-R>=Eatchar('\s')<CR>
inoremap <buffer> <silent> <expr> qgc Whereami2()
inoreab <buffer> <silent> wael window.addEventListener<C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> slp slope<C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> xab ([a,b]) =><C-R>=Eatchar('\s')<CR>
inoremap <buffer> Cmd Command
inoreab <buffer> <silent> s8 /*<CR><CR>*/<UP><C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> tsd this.$scopedSlots.default<C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> niu return console.log("NOT IN USE")<C-R>=Eatchar('\s')<CR>
inoremap <buffer> coi const items = 
inoreab <buffer> dl doglog()
inoremap <buffer> cos const store = []
inoreab <buffer> <silent> dl doglog()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> rv return value<C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> ok Object.keys()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> oe Object.entries()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> ov Object.values()<LEFT><C-R>=Eatchar('\s')<CR>
inoremap <buffer> q] [<ESC>/\v[\.]\w+/e<CR>a]
inoremap <buffer> q] [<ESC>A]
inoremap <buffer> <leader>o <esc>:call OpenLocalFile()<cr>
inoremap <buffer> <silent> <expr> qgt Qgt()
inoremap <buffer> Cmd Command<C-R>=Eatchar('\s')<CR>
inoremap <buffer> Dep Dependencies 
inoreab <buffer> <silent> ogo Object.getOwnPropertyNames()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> cmd command<C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> wk window[key]<C-R>=Eatchar('\s')<CR>
inoremap <buffer> Cmp Completion 
inoreab <buffer> <silent> gcn getConstructorName<C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> fc firstChild<C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> lg console.log<C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> ro reduceObject<C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> pvd puppetVisitorDeep<C-R>=Eatchar('\s')<CR>
inoreab <buffer> hx <!--insertion-point-->
inoreab <buffer> <silent> cld console.log = display<C-R>=Eatchar('\s')<CR>
inoremap <buffer> jsx console.log(JSON.stringify(, null, 2))<LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT>
inoreab <buffer> <silent> ctx context<C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> gsv getStringValue<C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> fm fuzzyMatch<C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> cn currentNode<C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> sym let [item, symbol] = mreplace(/^[.!@#]/, first)<C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> inp case IN_PROGRESS:<C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> inp IN_PROGRESS<C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> cot const text
inoreab <buffer> <silent> r1 return 1<CR><C-R>=Eatchar('\s')<CR>
inoremap <buffer> slp await sleep(200)
inoreab <buffer> <silent> cst const self = this<C-R>=Eatchar('\s')<CR>
inoremap <buffer> <silent> <expr> qac Qac()
inoreab <buffer> <silent> hk has_key()<LEFT><C-R>=Eatchar('\s')<CR>
inoremap <buffer> Fac Factory
inoremap <buffer> mydl "/mnt/chromeos/MyFiles/Downloads"
inoremap <buffer> mydr  '/mnt/chromeos/GoogleDrive/MyDrive/CWF/'
inoremap <buffer> = =
inoreab <buffer> <silent> st state<C-R>=Eatchar('\s')<CR>
inoremap <buffer> <silent> lz l
inoreab <buffer> <silent> rp randomPick()<LEFT><C-R>=Eatchar('\s')<CR>
iab <buffer> th this
inoreab <buffer> <silent> cln {class: }<LEFT><C-R>=Eatchar('\s')<CR>
inoremap <buffer> Cmp Completion
inoreab <buffer> <silent> lkv (k, v) => <C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> uf useful<C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> sub substitute<C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> tl console.log(); throw new Error();<LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> rext removeExtension()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> pd printdir()<LEFT><C-R>=Eatchar('\s')<CR>
iab <buffer> ao {"a":1, "b":2, "c":3}
inoreab <buffer> <silent> rw renderWrapper(h, )<C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> ae addExtension()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> rai replaceArrayItem()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> cc createConfig()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer> <expr> dt GetDateAndLocation()
inoreab <buffer> <silent> azaz [a-zA-Z]<C-R>=Eatchar('\s')<CR>

" inoreab <buffer> rert return
inoreab <buffer> sn '\n'<C-R>=Eatchar('\s')<CR>
inoreab <buffer> snsn '\n\n'<C-R>=Eatchar('\s')<CR>
inoreab <buffer> ctr constructor
" inoreab <buffer> ifmain if __name__ != '__main__': return
inoreab <buffer> ret return
" inoreab <buffer> desc DESCRIPTION = ''<left><C-R>=Eatchar('\s')<CR>
inoreab <buffer> mydl "/mnt/chromeos/MyFiles/Downloads/" <C-R>=Eatchar('\s')<CR>
" inoreab <buffer> cdf '((?:async )?function\|def\|class)
" inoreab <buffer> deps dependencies<C-R>=Eatchar('\s')<CR>
" inoreab <buffer> retr return
inoreab <buffer> orig original()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer> isn if (isNode()) returnj
" inoreab <buffer> ap append()<LEFT><C-R>=Eatchar('\s')<CR>
" inoreab <buffer> wr write()<LEFT><C-R>=Eatchar('\s')<CR>
" inoreab <buffer> hrefre = href=[\'\"]?
inoreab <buffer> gs GLOBALS<C-R>=Eatchar('\s')<CR>
" inoreab <buffer> nx <CR>----------------------------------------<CR><CR><C-R>=Eatchar('\s')<CR>
inoreab <buffer> vy <CR>----------------------------------------<CR><CR><C-R>=Eatchar('\s')<CR>
inoremap <buffer> gdr '/mnt/chromeos/GoogleDrive/MyDrive/CWF/'
inoremap <buffer> <c-c> <esc>:call AddText('')<left><left>
inoremap <buffer> <f1> <esc>:w<CR>:!clear;node %<CR>
inoremap <buffer> <f2> <esc>:w<CR>:!clear;node %<CR>
inoremap <buffer> <f8> :w<cr>:call FunctionCaller()<cr>
inoremap <buffer> <f9> <esc>:w<cr>:source ~/.vimrc<cr>
inoremap <buffer> <F4> <esc>yyp
inoremap <buffer> <F5> <esc>:call TopComment()<cr>A
inoremap <buffer> <c-l> <esc>:call SmartConsoleLog()<cr>A<left>
inoremap <buffer> <expr> 3 ThreeOrHash()
inoremap <buffer> <expr> lbr LineBreakExpression()
inoremap <buffer> <expr> lbr LineBreaker()
inoremap <buffer> <f10> <esc>:wa<cr>
inoremap <buffer> <leader>l \<leader\>
inoremap <buffer> <leader>o :w<CR><esc>:call OpenLocalFile()<cr>
inoremap <buffer> <leader>x (s) {<esc>o}<esc><s-o>
inoremap <buffer> <silent> <c-p> <esc>:call adsfIfController()<cr>
inoremap <buffer> w0 <c-o>${<cr>})<esc><s-o>
inoremap <buffer> w] <esc>:call ExpansionActions()<cr>a
inoremap <buffer> w] <esc>:call HtmlHandler()<cr>a
inoremap <buffer> wf <esc>:call CreateFunctionBlock()<cr>A
inoremap <buffer> zl :call TestFunction()<cr>
inoremap <buffer> <S-CR> <esc>:call JsAnywhere()<cr>
inoremap <buffer> <expr> ' QuoteOrDoubleQuote()
inoremap <buffer> <expr> lx ChildLx('lx')
inoremap <buffer> w, <esc> :call PySnippet4()<CR>
inoremap <buffer> wt <esc>:call TemplateDittoHandler()<cr>A
inoremap <buffer> w, <esc>:call PySnippet4()<cr>a
inoremap <buffer> <leader>p <ESC>:call GetSetPartsHandler()<CR>A
inoremap <buffer> <localleader>a <ESC>:call WindowAutoComplete()<CR>A
inoremap <buffer> zm <ESC>:call GetSet2('MathReplaceHandler')<CR>A
inoremap <buffer> <expr> ; SemiOrColon()
inoremap <buffer> trefs this.$refs
inoremap <buffer> <expr> zp GetLastParam()
inoremap <buffer> z, <esc>:call LineSetter('ZWindowSnippet')<CR>o
inoremap <buffer> <silent> 9 ()<LEFT><C-R>=Eatchar('\s')<CR>
inoremap <buffer> nine 9
inoremap <buffer> wp <esc>:call PySnippet()<cr>a
inoreab <buffer> <silent> abcobj {"a": 1, "b": 2}<C-R>=Eatchar('\s')<CR>
inoremap <buffer> w[ <esc>:call SnippetCompletion()<CR>A
inoremap <buffer> w[ <esc>:call SnippetCompletion()<CR>A
inoremap <buffer> <silent> [ []<LEFT><C-R>=Eatchar('\s')<CR>
inoremap <buffer> zv <ESC>:call ChooseBuffer2('v')<CR>
inoremap <buffer> f' f""<LEFT>
inoremap <buffer> q= <ESC>I<SPACE>=<LEFT><SPACE><LEFT><LEFT>
inoremap <buffer> q= <ESC>I<SPACE>=<LEFT><SPACE><LEFT><LEFT>
inoremap <buffer> qs <ESC>A =<SPACE>""<LEFT>
inoremap <buffer> <expr> qf SingleQuote(FileGetter2(Prompt('Choose a file key:')))
inoremap <buffer> qw <esc>A
inoremap <buffer> q, <esc>A,
inoremap <buffer> qi <ESC>I <LEFT>
inoremap <buffer> qw <esc><RIGHT>a
inoremap <buffer> <expr> qac AutoDictComplete()
"inoremap <buffer> qr <ESC>:call ZEditRegex()<CR>A
inoremap <buffer> <expr> tl ExpressionMaster('tl')
inoremap <buffer> <expr> sj ExpressionMaster('sj')
inoremap <buffer> <expr> ' QuoteOrDoubleQuote()
inoremap <buffer> zt <ESC>:call Zt1()<CR>
inoreab <buffer> <silent> abcde ["a", "b", "c", "d", "e"]<C-R>=Eatchar('\s')<CR>
inoremap <buffer> q[ ) {
inoreab <buffer> <silent> abcobj {"a": 1, "b": 2}<C-R>=Eatchar('\s')<CR>
inoremap <buffer> <expr> okeys ExpressionMaster('okeys')
inoremap <buffer> <expr> ovals ExpressionMaster('ovals')
inoremap <buffer> qn <CR><BS>else:<CR>
inoremap <buffer> <expr> qk AutoTabForWindow()
inoreab <buffer> <expr> ti ExpressionMaster('ti')
inoreab <buffer> snsn + '\n\n' +
inoremap <buffer> zs <ESC>:w<CR>
inoreab <buffer> <expr> pr ExpressionMaster('pr')
inoreab <buffer> myd '/home/kdog3682/CWD/'<LEFT><C-R>=Eatchar('\s')<CR>
inoremap <buffer> <expr> cur ExpressionMaster('cur')
inoremap <buffer> <expr> tc ExpressionMaster('tc')
inoremap <buffer> <expr> co ExpressionMaster('co')
inoremap <buffer> <expr> pl ExpressionMaster('pl')
inoreab <buffer> <silent> lvls LEVELS<C-R>=Eatchar('\s')<CR>
inoreab <buffer> l console.log()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer> <buffer> sz s = """<CR><CR>"""<UP><C-R>=Eatchar('\s')<CR>
inoremap <buffer> zd <esc>:call NormalHandler('WriteDitto')<CR>A
inoremap <buffer> zz <esc> :w<cr>:call RunPythonOrNode()<CR>
inoreab <buffer> cylh this.cy += this.lh
inoremap <buffer> myf  '/home/kdog3682/.myfiles.json'
inoremap <buffer> myr  '/home/kdog3682/.reddit.json'
inoremap <buffer> myv  '/home/kdog3682/.vimrc'
inoremap <buffer> myh  '/home/kdog3682/
inoremap <buffer> myd  '/home/kdog3682/CWD/
inoremap <buffer> myw  '/home/kdog3682/CWF/
inoremap <buffer> qs <esc>:call LineSetter('QSnippet')<CR>
inoremap <buffer> myq '/home/kdog3682/CWF/questions.txt'
inoreab <buffer> lh https://localhost:8000
inoreab <buffer> ino inoreab
inoreab <buffer> cno cnoreab
"inoreab <expr> ase "append('" . CurrentFile() . "', value)"
inoremap <buffer> zd <esc>:call NormalHandler('WriteDitto')<CR>A
inoremap <buffer> <silent> = <space>=<space>
inoreab <buffer> <silent> loh https://localhost:8000<C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> cur current<C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> con continue<C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> lets let store = []<C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> stp store.push()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> stpo store.push({})<LEFT><LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> 77 &&<C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> lv let value =<C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> lv let value =<C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> co const
inoreab <buffer> <silent> srep s = s.replace()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> gfn let name = getFunctionName()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> strim s = s.trim()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> logl console.log('---------------------------')<C-R>=Eatchar('\s')<CR>
inoremap <buffer> semi ;
inoreab <buffer> <silent> idn identity<C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> gfw getFirstWord()<LEFT><C-R>=Eatchar('\s')<CR>
inoremap <buffer> ` <esc> :w<cr>:call RunPythonOrNode()<CR>
inoreab <buffer> <silent> mtv messageToVue()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> etv messageToVueError()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> gw getWindow()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> storag const storage = new Storage(Array)<C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> ss storage<C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> storagv return storage.value<C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> m3 match[3]<C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> m1 match[3]<C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> m2 match[3]<C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> a0 arguments[0]<C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> a2 arguments[2]<C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> alen arguments.length <C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> cls console.log(stringify())<LEFT><LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> gdei getDetailedErrorInfo<C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> ew endsWith("")<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> jsx JSON.stringify(s, null, 2)
inoreab <buffer> <silent> mtv messageToVue()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> st st<C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> rs replaceSelection<C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> co const
"inoreab <buffer> <silent> 0 0<C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> amv app.modalValue<C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> dae document.activeElement<C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> vaf @focus="" <LEFT><LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> vcm vueCommandMessenger<C-R>=Eatchar('\s')<CR>
inoremap <buffer> qn <esc>:call QNext()<CR>
inoremap <buffer> qn <esc>/}<CR>o
inoreab <buffer> <silent> inc includes<C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> okeys Object.keys()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> snip snippet<C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> sing s = templater(snippetDictionary.singleton,a )<C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> sing singleton<C-R>=Eatchar('\s')<CR>
"inoreab <buffer> <silent> com components<C-R>=Eatchar('\s')<CR>
"inoreab <buffer> <silent> Co Component<C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> stu student<C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> tdo this.$options<C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> des destination<C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> tilda ``<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> per percentages<C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> qu question<C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> abs absolute<C-R>=Eatchar('\s')<CR>
inoremap <buffer> <silent> qt <CR><TAB><C-R>=Eatchar('\s')<CR>
"inoreab <buffer> <silent> arr --><C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> aobj {a:1, b:2, c:3}<C-R>=Eatchar('\s')<CR>
inoremap <buffer> qj <ESC>:w<CR>:call QJConnector()<CR>
inoreab <buffer> <silent> aws await sleep(1)<C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> aws await sleep(2)<C-R>=Eatchar('\s')<CR>
inoremap <buffer> <expr> ql Qlog()
inoremap <buffer> <expr> qk Qk()
inoremap <buffer> <expr> qgrf QGetReadFile()
inoremap <buffer> <expr> qgrw QGetRPW()
"inoremap <buffer> <silent> Com Component<C-R>=Eatchar('\s')<CR>
"inoreab <buffer> <silent> com component<C-R>=Eatchar('\s')<CR>
inoremap <buffer> qbp <esc>?(<CR>a
inoremap <buffer> qbp <esc>^/(<CR>a
inoremap <buffer> <silent> q0 ${}<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> fac factory<C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> alist ['a', 'b', 'c', 'd', 'e']<C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> sto const storage = new Storage()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer> cj ________comment = `<CR><CR>`<UP><LEFT><C-R>=Eatchar('\s')<CR>



inoremap <buffer> <expr> bn BlockNote()
inoreab <buffer> <silent> avae AppendVimAndExecute()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> pp pprint()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> ts toString()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> ce createElement()<LEFT><C-R>=Eatchar('\s')<CR>
inoremap <buffer> z[ {{}}<LEFT><LEFT>
inoreab <buffer> <silent>  tlh console.log("HI"); throw "HI";<C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent>  cfp coinflip()<C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent>  rnp randomPick()<LEFT><C-R>=Eatchar('\s')<CR>
inoremap <buffer> <expr> zl ZLorem()
inoreab <buffer> <silent>  dm DocMath<C-R>=Eatchar('\s')<CR>
inoremap <buffer> e2 <space>==<space>
inoremap <buffer> e3 <space>===<space>
inoremap <buffer> z=  =""<LEFT>
inoremap <buffer> zp  <space>+=<space>
inoreab <buffer> <silent>  hop hasOwnProperty()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent>  lt console.log(type())<LEFT><LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent>  qa {question, answer}<C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> iss isString(s)<C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> mt mt<C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent>  rs return store<C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent>  az [a-zA-Z]+<C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent>  oa Object.assign()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent>  lsa let s = a:s<C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent>  rs return s<C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> nuc require('./node-utils.js').clip()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> nua require('./node-utils.js').appendSelf()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent>  pei += increment<C-R>=Eatchar('\s')<CR>


inoremap <expr> qgp Qgp()
inoremap <buffer> <silent> 9 ()<LEFT><C-R>=Eatchar('\s')<CR>
inoremap <buffer> nine 9
inoreab <buffer> <silent>  ldf lastDriveFile()<C-R>=Eatchar('\s')<CR>
inoremap <buffer> e2 <space>==<space>
"inoremap <buffer> <silent> qd <esc>o
inoreab <buffer> bbc /**  **/<LEFT><LEFT><LEFT><LEFT><C-R>=Eatchar('\s')<CR>

nnoremap <buffer> 5 ?\/\*\*  \*\*\/<LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT>
inoreab <silent>  ot optioons<C-R>=Eatchar('\s')<CR>
inoreab <silent>  ot options<C-R>=Eatchar('\s')<CR>
inoremap qp (<ESC>A)<LEFT>
inoremap <buffer> e1 =""<space><LEFT><LEFT>
inoremap <buffer> e1 =""<LEFT>
inoreab <buffer> <silent> jsc console.log(JSON.stringify(, null, 2))<LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> jst console.log(JSON.stringify(, null, 2));throw ''<LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><C-R>=Eatchar('\s')<CR>


inoremap <buffer> e4 <space>!=<space>
inoreab <buffer> sj let s = `<CR><CR>`<UP><LEFT><C-R>=Eatchar('\s')<CR>

inoreab <buffer> <silent> tl console.log(); assert();<LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><C-R>=Eatchar('\s')<CR>
inoremap qo ({<CR>})<ESC>O
inoremap qa ([<CR>])<ESC>O
inoremap q` `<CR>`<ESC>O<space><space><space><space>
inoreab <silent> win window
inoreab win window<C-R>=Eatchar('\s')<CR>
inoreab gbc getBoundingClientRect()<LEFT><C-R>=Eatchar('\s')<CR>
"inoreab aa await ask()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer> <silent> tl console.log(); assert();<LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><C-R>=Eatchar('\s')<CR>
inoreab tlc toLowerCase()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab tuc toUpperCase()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab eab _, a, b<C-R>=Eatchar('\s')<CR>
inoreab <silent> gc getCaller()<LEFT><C-R>=Eatchar('\s')<CR>
nnoremap qnn OsetupNode()<CR><ESC><DOWN><DOWN>
"inoremap <buffer> <expr> <CR> OnKeyPress('Enter')
"inoremap <buffer> <expr> 0 ZeroOrParen()
"

inoreab tp console.log([]); throw '';<LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><C-R>=Eatchar('\s')<CR>
inoreab comn const matches = findall(//g, s)<LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><C-R>=Eatchar('\s')<CR>
inoreab av import {appendVariable} from "./node-utils.js"; appendVariable()<LEFT><C-R>=Eatchar('\s')<CR>
inoremap <buffer> qw <esc><RIGHT>a
inoremap <buffer> qe <ESC>A =<SPACE>



nnoremap <buffer> qe A<CR><esc><<I
inoremap <buffer> qe <esc>o<backspace>
inoremap <buffer> qw <ESC>A<CR><space><space><space><space>
nnoremap <buffer> qw A<CR><space><space><space><space>
inoremap <buffer> qr <RIGHT>
inoreab <buffer> aa [['a', 'b'], ['c', 'd']]<C-R>=Eatchar('\s')<CR>
