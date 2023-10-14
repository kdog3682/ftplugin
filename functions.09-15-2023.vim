" let g:debug = 1
"let g:newFile='new-files.txt'
function! FindLineIndex2(r)
    let r = a:r
    let i = 0
    while i < 1000
        let i += 1
        let s = getline(i)
        if Test(s, r)
            return i
        endif
    endwhile
endfunction

"let g:filedict["bro"] = "/home/kdog3682/CWF/public/browser.js"
"sdfsd
" Used in GoFunction.
function! Pip(s)
    try
        "execute "!pip3 install " . a:s
        let s = NoteWriter('pip', a:s)
        ec s
        call AppendFile(g:notefile, s)
    catch
        ec 'error'
    endtry
endfunction

function! LooksLikeFunction(s)
    return Test(a:s, '^(get|set|is|has|gen|run|on|lambda|fix)')
endfunction
function! LooksLikeDictionaryName(s)
    return Test(a:s, '^\w*(ref|config|dict|map|mixins?|options|table|dictionary)$')
endfunction
    let g:functionblocktransformdict = { 
       \ '': 'abc s', 
       \ 'main': 'main s', 
       \ 'test': 'testing', 
       \ 'render': 'render h', 
       \ 'ts': 'toString', 
    \}

    let g:filebookmarkdict = {
        \'bm': 'bookmarks.files.txt',
        \'tm': 'temp-bookmarks.files.txt',
    \}
" 07-06-2022

function! EatIab(...)
    let s = a:0 >= 1 ? a:1 : 0
    let cmdbase = "<C-R>=Eatchar('\\s')<CR>"
    let abrev = ''
    if !Exists(s)
        let s = CurrentLine()
        let abrev = Abrev(s)
    elseif s == '1'
        let s = Match(CurrentLine(), '\w+\ze\(')
        let abrev = Abrev(s)
        let cmdbase = '()<LEFT>' . cmdbase
    endif

    let cmd = Join("inoreab", "<silent>", abrev, s . cmdbase)
    call AppendAndExecute(cmd)
    
endfunction
" 07-07-2022 
" 07-08-2022
function! Args(s)
    throw 'deprecation'
    let s = a:s
    let items = split(s, ' ')
    let parsed = map(items, 'ArgConverter2(v:val)')
    let arg = join(parsed, ' ')
    return arg
endfunction
function! BaseJS(s)
    let s = a:s
    let ref = g:basejsref
    let [a,b] = SplitOnce(s)
    if !has_key(ref, a)
        return 404
    endif

    let s = trim(ref[a]) . ' ' . trim(b)
    call Node('/home/kdog3682/CWF/public/run-node.js', s)
endfunction
function! BasePY(s, ...)
    let secondArg = a:0 >= 1 ? a:1 : ''
    let first = BaseJS(a:s)
    if first != 404
        return 
    endif

    let s = a:s
    let ref = g:basepyref
    let [a,b] = Exists(secondArg) ? [s, secondArg] : SplitOnce(s)
    if IsArray(b)
        let b = join(b, ' ')
    endif
    if has_key(ref, a)
        let s = trim(ref[a]) . ' ' . trim(b)
    endif

    let items = Exists(GetExtension(s)) ? [s] : split(s, ' ')
    let parsed = map(items, 'ArgConverter2(v:val)')
    let arg = join(parsed, ' ')
    return Python(g:runpyfile, arg)

    elseif has_key(ref, a)
        let template = ref[a]
        let items = split(template, ' ')

        if Exists(b)
            call add(items, trim(b))
        endif
        let parsed = map(items, 'ArgConverter2(v:val)')
        let arg = join(parsed, ' ')
        return Python(g:runpyfile, arg)
    else
        return Python(g:runpyfile, s)
    endif
endfunction


function! BasePY(s, ...)
    let s = a:s
    if a:0 >= 1
        let second = a:1
        if IsArray(second)
            let second = join(second, ' ')
        endif
        let s = s . ' ' . second
    endif

    let first = BaseJS(s)
    if first != 404
        ec 'return 404'
        return 
    endif
    let ref = g:basepyref
    let s = Replace(s, '^\w+', {x -> get(ref, x[0], x[0])})
    let arg = SplitMapJoin(s, ' ', 'ArgConverter2')
    return Python(g:runpyfile, arg)
endfunction

function! SplitMapJoin(s, d, f)
    let parsed = map(split(a:s, a:d), a:f . '(v:val)')
    let arg = join(parsed, a:d)
    return arg
endfunction
function! VarHandler(s)
    let s = "let g:vardict[" . key . "] = " . value
    call AppendVim(s)
endfunction
function! Backup1206()
    let arg = join(map(GetCurrentBuffers(), 'FullPath(v:val)'), ' ')
    call BasePY('bua ' . arg)
endfunction

function! Twilio(...)
    let s = a:0 >= 1 ? a:1 : join(GetCurrentBuffers(), ' ')
    let s = ':_twilio ' . s
    call BasePY(s)
endfunction
" nnoremap zt :call Twilio()<CR>
function! FullPath(s)
    let name = fnamemodify(a:s, ':p')
    return name
endfunction
function! RunAlternate()
    let name = FullPath(bufname('#'))
    if GetExtension(name) != 'js'
        return 
    endif
    call Node('/home/kdog3682/CWF/public/TextEditor.js', name)
endfunction
" 07-10-2022
" 07-11-2022
"
" 07-11-2022
" 07-12-2022
" 07-13-2022
" 07-14-2022
" 07-14-2022
"
"
function! CreateVar(a, b)
    let a = a:a
    let b = a:b
    return a . ' = ' . Quote(Sub(b, '''', '\\'''))
endfunction
function! SifyAndGoJS()
    let line = CreateVar('s', CurrentLine())
    let lines = ['', line, '']
    call OpenBuffer('/home/kdog3682/CWF/public/utils.js')
    "call OpenBuffer('/home/kdog3682/CWF/jch/utils.js')
    call AppendBottom(lines, 1)
endfunction
" 07-15-2022
"
"
function! PrevString()
    let i =  SprawlIndex('s = `')
    call SetPos(i + 2)
endfunction

function! SetPos(n)
    if IsArray(a:n)
        call setpos('.', [0, a:n[0], a:n[1], 0])
    else
        call setpos('.', [0, a:n, 100, 0])
    endif
endfunction
function! NormFileToDir(f)
    let f = a:f
    let e = GetExtension(f)
    if e == 'txt'
        return g:dir2023
    endif
    if has_key(g:dirdict2, e)
        return g:dirdict2[e] . f
    else
        return f
    endif
endfunction
function! NormAppend(f, data)
    call AppendFile(NormFileToDir(a:f), a:data)
endfunction
function! JoinString(...)
    return join(a:000, ' ')
endfunction
function! CodingNote(s)
    let s = a:s
    let file = Tail()
    let date = DateStamp()
    let name = GetFunctionName()
    let data = JoinString(date, file, name, s)
    call NormAppend(g:codenotefile, data)

endfunction

function! IsWord(s)
    return Test(a:s, '^[a-z]\w*$')
endfunction
function! RunExecRef(key, arg)
    let key = a:key
    let arg = a:arg
    let expr = g:execRef[key]
    if IsWord(expr)
        try
            let cmd = RegistrarTemplater('call $1()', [expr])
            execute cmd 
        catch
            execute expr
        endtry
        return 
    endif

    if Test(expr, 'BasePY')
        let expr = Replace(expr, '\$arg', ShellEscape(arg))
    else
        let expr = Replace(expr, '\$arg|\$1', arg)
    endif
    let expr = Replace(expr, '\$cf', CurrentFile())
    if Test(expr, '\$word')
        let expr = Replace(expr, '^\$word', CurrentWord())
    endif

    if Test(expr, '^return ')
        let expr = Replace(expr, '^return', '')
        ec eval(expr)
        return 
    endif
    execute expr
endfunction
function! ExplorerHandler(s)
    let dict = {
        \ 'l': '/home/kdog3682/2023/node_modules/d3-scale/src/',
        \ 's': '/home/kdog3682/2023/node_modules/d3-scale/src/',
        \ 'p': '/home/kdog3682/2023/node_modules/d3-polygon/src/',
        \ 'h': '/home/kdog3682/2023/',
    \}

    let s = a:s

    if s == 'u'
        call search('\v' . '\.\./')
        call feedkeys("\<CR>")
    elseif has_key(dict, s)
        execute "Explore " . dict[s]
    elseif has_key(g:dirdict3, s)
        let cmd = "Explore " . g:dirdict3[s]
        execute cmd
    else
        let line = getline('.')
        ec [s]
        ec line
        ec ['inprogress havent done yet']
    endif
endfunction
function! AnythingHandler(s)
    let s = a:s
    " let [a,b] = SplitOnce(s)
    let [a,b] = SplitOnceDontTrim(s)

    if &filetype == 'netrw' && ExplorerHandler(s)
        return 
    endif

    if IsNumber(s)
        return Cursor(s)
    elseif has_key(g:pmr2, a)
        return PackageManager2(a, b)
    elseif s == ''
        return Python2('pythonAppController')
    elseif s == ':'
        return ContextualColonHandler()
    elseif Test(s, '^\w+dir$')
        execute "Explore " . eval('g:' . s)
        return 

    elseif Test(s, '^q$')
        execute "bd"
        return

    elseif Test(s, '^h +')
        execute "help " . s[2:]
        return

    elseif Test(s, '^g:')
        return GoFileGoFunction(s[2:])
    elseif Test(s, '^--')
        return DoubleDash(s)
    elseif Test(s, '^/')
        return AppendBelow(line('.'), TextSearcher(arg))
    elseif has_key(g:vuenavdict, s)
        return Navigator(g:vuenavdict[s])
    elseif has_key(g:pureExecRef, s)
        execute g:pureExecRef[s]
        return 
    elseif has_key(g:pythonWithStateDict, s)
        return PythonWithState(s)
    endif

    "if a == 'ff'
        "return Python2('ffstring', b)
    "endif

    if has_key(g:execRef, a)
        if g:execRef[a] == '0'
            return Python2(a, b)
        else
            try
                " @bookmark 1680658725 runExecRef 
                if IsWord(g:execRef[a])
                    if empty(b)
                        return function(g:execRef[a])()
                    else
                        return function(g:execRef[a])(b)
                    endif
                else
                    return RunExecRef(a, b)
                endif
            catch
                let error = v:exception
                ec error
                return 
            endtry
        endif
    else
        return Python2(a, b)
    endif
endfunction


" 07-16-2022
" 07-17-2022
"
"

function! Choose(items, ...) abort
    let fast = a:0 >= 1 ? a:1 : len(a:items) < 10
    let items = a:items

    if len(items) < 1
        throw 'error at choose - no items'
    elseif len(items) < 2
        return items[0]
    endif
    try
        ec Numbered2(items)
    catch
        ec items
    endtry
    let c = fast ? InputChar() : input('')
    if IsNumber(c)
        return items[c - 1]
    elseif c == 'c'
        throw 'STOP'
    else
        return c
    endif
endfunction
" 07-18-2022


function! Del(s, r)
    return Replace(a:s, a:r, '')
endfunction


function! GetMathPath(s)
    let s = a:s
    let ending = '.math.txt'

    if Test(s, 'dm$|md$')
        let s = s[0:-4]
        let ending = '.dialogue.math.txt'
    else
        let s = s[0:-3]
    endif
    let n = 1
    let first = s . n . ending
    let files = readfile('math.files.txt')
    while 1
        if Includes(first, files)
            let first = s . (n + 1) . ending
            continue
        endif
        call writefile([first], 'math.files.txt', 'a')
        return first
    endwhile
endfunction

function! PrepareBookmarkRegex(s)
    let s = a:s
    "let s = 'foo.ff'
    let s = Match(s, '^ *\w+(([ .-])\w+)*')
    return s
endfunction

function! IsMathFile(f)
    let files = readfile('math.files.txt')
    return Includes(a:f, files)
endfunction
function! ReplaceExtension(f, e)
    let f = a:f
    let e = a:e
    return Replace(f, '\w+$', e)
endfunction
function! BlockNote()
    return "/*** " . DateStamp() . "\<CR>\<CR>***/\<UP>\<SPACE>"
endfunction



function! WordWalk() 
    let word = GetFirstWord(GetCurrentWord2())
    if Test(word, 'Action2')
        let q = GetFirstWord(CurrentLine()[10:])
        return ExecuteRegex('^ +' . q)
    endif

    if Test(word, '^v-')
        return ExecuteRegex('var ' . Pascal(word))
    endif

    if Test(word, '(ref|master)$')
        return ExecuteRegex('^(var|const) ' . word )
    endif
    let ignore = ['clip', 'console', 'log', 'print', 'previewComponentTemplate', 'previewwwwww']
    if Includes(word, ignore)
        let word = ''
    endif

    let line = CurrentLine()
    let length = len(line)
    let ch = GetChar()
    let f = '!Test(v:val, "log|print|preview|stringify|clip")'
    let m = filter(FindallStrings(line, '\w+\ze\('), f)
    if !Exists(m)
        let m = Match(line, '<V\w+')
        if Exists(m)
            let word = m 
        else
            let m = FindallStrings(line, '[a-z]\w{6,}')
            if !Exists(m)
                ec ' no possible words '
                return 
            endif
            let word = ch > round(length / 2) ? m[-1] : m[0]
        endif
    elseif len(m) == 1
        let word = m[0]

    elseif !Exists(word)
        let word = ch > round(length / 2) ? m[-1] : m[0]
    elseif Includes(word, m)
        let word = word
    endif

    let r = Jspy('bindingRE') . word
    "ec r
    "return
    try 
        call ExecuteRegex(r)
        if Test(word, '^V')
            try
                call ExecuteRegex('template:')
            catch
                let error = v:exception
                ec error
            endtry
        endif
    catch 
        ec 'error on regex'
        "let buffer = Lang() == 'vim' ? g:vimrcfile : LoadFFRWord(word)
        let buffer = Jspy('defaultLangFile')
        call OpenBuffer3(buffer)
        ec 'opened a buffer: ' . buffer
        ec 'executing regex again'

        try
            call ExecuteRegex(r)
        catch
            let error = v:exception
            ec 'error on second try'
            ec error
        endtry
    endtry
endfunction
function! LoadFFRWord(s)
    let s = a:s
    let ref = LoadFFR()
    if has_key(ref, s)
        return ref[s]
    else
        let file = FileGetter2(Prompt('The fn is ' . s . '. What file would you like to associate it with?'))
        let ref[s] = file
        call WriteJson(g:functionfilerefjson, ref)
        ec 'updating the ref for next time'
    endif



endfunction
function! Bokdsf()
    ec Prompt('hi')
endfunction
function! LoadFFR()
    if exists("g:functionfileref")
        return g:functionfileref
    endif
    let file = g:functionfilerefjson
    let g:functionfileref = ReadJson(file)
    return g:functionfileref
endfunction
function! RemoveStart(s, key)
    let s = a:s
    let key = a:key
    return Replace(s, '^' . key . ' *', '')
endfunction

function! GetDir()
    return expand('%:h')
endfunction
function! GetOpenBufferNames()
 return map(GetOpenBuffers(), 'bufname(v:val)')
endfunction

function! ChooseBuffer2(s)
    "let buffers = GetOpenBuffers()
    let s = a:s

    let file = FileGetter2(a:s)
    if empty(file)
        return 
    elseif IsUrl(file) || IsPdf(file)
        return BasePY('vimFileOpener ' . file)
    elseif Test(file, '^\w') && GetExtension(file) == 'py'
        let file = DirNormalization(file)
    endif

    call OpenBuffer3(file)
endfunction
function! DirNormalization(file)
    let file = a:file
    let exclam = 0
    if file[0] == '!'
        let exclam = 1
        let file = file[1:]
        return file
    elseif Test(file, '^/|server.js')
        return file
    endif

    let file = NormalizePath3(file)
    return file
endfunction
function! NormalizePath3(s) abort
    let dir = Jspy2(a:s,'normalizeDirPath')
    if !Exists(dir)
        return a:s
    endif
    "ec dir
    "throw ''
    let tail = Tail(a:s)
    return PathJoin(dir, tail)
endfunction

function! Jspy(key, ...)
    let file = a:0 >= 1 ? a:1 : 0
    if Exists(file)
        if has_key(g:jspyref2, file)
            return get(g:jspyref2[file], a:key, '')
        else
            return get(g:jspyref2[Lang()], a:key, '')
        endif
    else
        return get(g:jspyref2[Lang()], a:key, '')
    endif
endfunction

function! Jspy2(file, key) abort
    let file = a:file
    let key = a:key
    let e = GetExtension(file)
    if !Exists(e)
        let e = Tail(file)
    endif
    if e == 'vimrc'
        let e = 'vim'
    endif
    let childRef = get(g:jspyref2, e)
    return get(childRef, key, '')
endfunction

function! FileGetter2(s) abort
    let key = a:s
    let length = len(key)

    if key == ''
        throw ' need a file'
    elseif key == 'pluginfile'
        let f = PathJoin(ftplugindir, &filetype . '.vim')

        " if IsFile($1)
            " $c
        " endif

        return GetMostRecentFile('dldir')

    elseif key == 'gi'
        let dir = Jspy('dir')
        let dir = empty(dir) ? '/home/kdog3682/2023/' : dir
        return PathJoin(dir, '.gitignore')

    elseif key == 'glf'
        return GetMostRecentFile('dldir')

    elseif key == 'cwf'
        return g:currentWorkFile
    elseif key == 'san'
        return g:activeNodeFile

    elseif key == 'glf1'
        return GetSecondMostRecentFile("/mnt/chromeos/MyFiles/Downloads")

    elseif Test(key, '^[abcdefgh]js')
        return key[0] . '.js'

    elseif key == 'dl'
        return Explorer(g:dldir)
    elseif key == 'drive'
        return Explorer(g:drivedir)
    elseif key == 'drivejson'
        return Explorer(g:drivejsondir)

    elseif key == 'json'
        return Explorer(g:jsondir)
    elseif key == 'ca'
        return Choose(globpath(g:assignmentdir, '*', 1, 1))

    elseif key == 'gbu'
        let filename = CurrentFile() . '.backup'
        call FileAssertion(filename)
        return filename
    elseif key == 'req'
        return g:dir2023 . 'request.temp.txt'

    elseif Test(key, '(json|csv)$')
        if IsFile(key)
            return key
        elseif IsFile(NPath(g:dldir, key))
            return NPath(g:dldir, key)
        else
            return key
        endif

    elseif Test(key, '^i\d$')
        let head = g:dir2023 . key . '.html'

    elseif key[0:1] == 'cd'
        let head = g:dir2023 . key[3:] . '/'
        let file = Tail()
        return head . file

    elseif key[0] == '.'
        let head = expand('%:p:h') . '/'
        let file = Tail(FileGetter2(key[1:]))
        return head . file

    elseif key == 'ltf'
        return g:lasttouchedfile

    elseif key == 'lt'
        return g:lasttouchedfile

    elseif Test(key, '^\*')
        let q =  '*' . key[1:] . '*'
        let files = globpath(g:dir2023, q, 1, 1)
        return Choose(files)
    elseif key == 'mrdldir'
        return system('ls -t ' . shellescape(g:dir2023) . ' | head -n 1')

    elseif key == 'mr'
        return system('ls -t ' . shellescape(g:dir2023) . ' | head -n 1')

    elseif key == 'guotie'
        let name = 'guotie.' . Tail()
        return name
    elseif key == ';p'
        return Choose(GlobFiles(g:productiondir))
    elseif Test(key, '^c \w+$')
        let name = g:clipdir . key[2:] . '.' . GetSeason() . '.json'
        return name

    elseif key == ';inc'
        throw ''
    elseif key  == ';m'
        return Choose(GlobFiles(g:mathdir))
    elseif key == 'inc'
        let file = IncrementFileName(CurrentFile())
    elseif key == ''
        let s = FindFileString(CurrentLine())
        if Exists(s)
            return s
        else
            return CurrentFile()
        endif
    "elseif Test(key, '\.(md?|dm)$')
        "return GetMathPath(key)

    elseif a:s == 'jo'
        return GetJournalPath()

    elseif a:s == 'z'
        let mainfile = GetOrSetGVariable('mainfile')
        let mainfile = get(g:filedict, mainfile, mainfile)
        return mainfile

    elseif key == 'test'
        return JspyConnector('open', 'test.pdf')

    elseif key == 'self'
        return CurrentFile()

    elseif Test(key, '^`')
        return '~/.' . key[1:]
    elseif StartsWithSlash(key)
        if length > 3
            return key
        else
            return FuzzyFileFinder(key[1:])    
        endif
    elseif IsNumber(key)
        if key == '33' 
            return bufname('#')
        elseif key == '44' 
            return bufname('$')
        else
            return bufname(str2nr(key))
        endif
    elseif has_key(g:filedict, key)
        return get(g:filedict, key)
    elseif HasExtension(key)
        return key
    elseif len(key) == 1
        return bufname(key)
    "elseif GetGValue('2023') && has_key(g:file2023dict, key)
        "return get(g:file2023dict, key)
    endif

    throw 'no file could be found'
    let name = FindBufferFromGlob(key)
    if Exists(name)
        return name
    endif

endfunction
" 07-18-2022
" 07-19-2022

function! MainOpen()
    let name = Tail()
    let lineCount = line('$')
    if lineCount > 3000
        ec 'too big to open'
        return 
    elseif name == 'ec.js' || name == 'serve_html_file.js'
        call Node('/home/kdog3682/2023/serve_html_file.js', 'ec.html')
    else
        call BasePY('ofile cf')
    endif
endfunction

    let g:node1dict = {
        \'parse.config.js': 'Node("parse.run.js")',
        \'app2.js': 'BasePY("googleAppScript")',
        \'appscript.js': 'BasePY("appscript2")',
        \'chinese.txt': 'BasePY(":google_chinese cf")',
        \'scratchpad.txt': 'BasePY(":google_chinese cf")',
        \'chatgpt.txt': 'Python2("runChatgpt")',
        \'text-messages.txt': 'BasePY(":sendTextMessages cf")',
        \'rp.js': 'PackageManager("readParse")',
        \'javascriptModule.py': 'JM()',
    \}
        "\'makePDF.js': 'Python2("makeNodePDF")',
function! ModeIsActive()
    let mode = get(g:globalState, 'mode', '')
    if empty(mode)
        return 
    endif
    call function(Capitalize(mode))()
    return 1
endfunction
" node1dict3
" 07-07-2022
" 07-07-2022


" 07-19-2022
function! QSnippet(s)
    let s = 'c cols=tgcols'
    let lang = GetLang()
endfunction

" 07-19-2022
" 07-20-2022
" 07-20-2022
" 07-21-2022
" 07-21-2022
" 07-23-2022
" 07-24-2022

function! OpenFile123(s)
    let s = a:s
    if IsPdf(s) || IsJson(s)
        return JspyConnector('open', s)
    endif

    return OpenBuffer(s)
endfunction

function! OpenBrowser(f)
    call BasePY('openBrowser ' . a:f)
endfunction

function! OpenUrl(f)
    call BasePY('openBrowser ' . a:f)
endfunction
function! LogReturn(f)
    ec a:f
endfunction

function! GoFile1() abort
    if RunRefFromFileTail(g:gofiledict)
        return 
    endif

    let s = CurrentLine()
    let t = trim(s)
    let w = CurrentWord()
    let movementRE = GetOrSetGlobalState('movementRE', 'movementRE')
    let m = Match(s, movementRE)
    if Exists(m)
        let value = g:movementLinks[m]
        if has_key(value, 'file')
            return OpenBuffer3(get(value, 'file'))
        elseif has_key(value, 'binding')
            let r = g:bindingPrefixRE . get(value, 'binding')
            return ExecuteRegex2(r, 0)
        else
            throw 'uhhh hmm'
        endif
    elseif Test(w, '^000000str\d\d\d')
        return ExecuteRegex('^let ' . w)
    elseif Test(t, '^\W?(file|name).{-}[''"]')
        let items = split(t, '["'']')
        let longest = GetLongestItem(items)
        execute printf('edit %s', longest)
        return
    elseif Test(w, '^000000str\d\d\d')
        return ExecuteRegex('^let ' . w)
    elseif Test(w, '^000000str\d\d\d')
        return ExecuteRegex('^let ' . w)
    elseif Test(w, '^lorem')
        call OpenBuffer3('lorem.js')
        call append('$', 'const ' . w)
        call Cursor('$')
        startinsert
        return 
    elseif Test(s, '^ *(v|app)-')
        " handle vue
        let m = Match(trim(s), '\S+')
        return  ExecuteRegex('var ' . Pascal(m))
    elseif Test(s, '^var V')
        let m = DashCase(Match(trim(s), '^\w+ \zs\S+'))
        return ExecuteRegex('^ *' . m)
    elseif Test(s, '^/(home|mnt|bbbb)')
        return OpenBuffer3(Replace(s, ' *active$', ''))
    elseif Test(w, '^str\d\d\d')
        return ExecuteRegex('^let ' . w)
    endif

    let ref = {
        \'git-data.json': 'OpenGitFromLine'
    \}

    let m = Match(s, '"\.?/\ze\w|''\.?/|\@documentation|\@bookmark.\d+|exec:|productionConfig|penguin|^http|fn:|out:|vimrc|g:\w+')
    if Exists(m)
        if m == 'out:'
            let f = Match(s, 'out: *\zs.*')
            let f = '/home/kdog3682/RESOURCES/' . f
            return OpenBuffer3(f)
        elseif Test(m, '^g:')
            return OpenBuffer3(eval(m))
        elseif m == 'vimrc'
            return OpenBuffer3('/home/kdog3682/.vimrc')

        elseif m == 'productionConfig'
            return OpenBuffer3('production.config.js')
        elseif m == '@documentation'
            call OpenBuffer3('documentation.txt')
            return 
        elseif m == 'exec:'
            let m = 'call ' . Match(s, 'exec:\zs.+')
            exec m
            return 
        elseif m == '"./'
            let m =  Match(s, '"\zs.{-}\ze"')
            return OpenBuffer3(Hpath(m))

        elseif m == '''./'
            let m =  Match(s, '''\zs.{-}\ze''')
            return OpenBuffer3(Hpath(m))
        elseif m == '''/'
            let m =  Match(s, '''\zs.{-}\ze''')
            return OpenBuffer3(m)
        elseif m == 'fn:'
            let r = g:bindingPrefixRE . Match(s, 'fn: *\zs\w+')
            return ExecuteRegex2(r, 0)
        elseif m == 'http'
            return OpenBrowser(Match(s, 'http.*'))
        elseif m == 'penguin'
            let file = Match(s, 'penguin.+')
            let file = Replace(file, 'penguin', '/home/kdog3682')
            return OpenBuffer3(file)
        elseif m == '"/' || m=='''/'
            let r='/.{-}\.(json|js|md|py|txt|html|css|pdf|jpg|png|svg|vim)'
            return OpenBuffer3(Match(s, r))
        endif
        let r = Rescape2023(m)
        if line('$') - line('.') < 20
            return ExecuteRegex2(r, 1)
        else
            return ExecuteRegex(r)
        endif
    endif

    function! Inner(s)
        let s = a:s
        let s = Sub(s, '^[''"] *| *[''"]$', '')
        let s = Replace(s, '^.{-}[''"]', '')
        return s
    endfunction

    let e = '\.(json|js|md|py|txt|html|css|pdf|jpg|png|svg|vim)'
    let r =  '.{-}' . e
    if Test(s, '[''"/]')
        let r = '\S+' . e
    endif
    let m = MapFilter(FindallStrings(s, r), function('Inner'))
    if len(m) > 0
        let file = Choose(m)
        if Test(file, 'http|pdf$|jpg$|png$|svg$')
            call OpenBrowser(file)
        elseif LooksLikeFunction(file)
            call ExecuteFunctionSearch(file)
        else
            call OpenBuffer3(file)
        endif
        return 
    endif

    "let url = 'https://raw.githubusercontent.com/ervandew/supertab/master/plugin/supertab.vim'
    " return [vueCase(key), 'worksheet-components-2.js']
    " pdfgen: ['VPdfgen', 'pdfgen.component'],

    let strings = FindallStrings(s, '''[^'']{-}''|"[^"]{-}"')
    let strings = MapFilter(strings, function('Inner'))
    let capitals = filter(copy(strings), "LooksLikeVimFunction(v:val)")

    if len(capitals) == 1
        let result = ExecuteFunctionSearch(capitals[0])
        if result
            return 
        endif
    endif

    if len(strings) > 0
        let string = Choose(strings)
        return SmartOpen2(string)
    endif
    let m = Match(s, 'lorem\.')
    if Exists(m)
        return OpenBuffer3('/home/kdog3682/2023/lorem.js')
    endif


    let fileOrDirRE = '\~?/[a-z0-9_\.]+(/\S+)*(\.\w+)*'
    let m = Match(s, fileOrDirRE)
    if Exists(m)
        return OpenBuffer3(m)
    endif

    let m = Match(s, "^/home.+")
    if Exists(m)
        return OpenBuffer3(m)
    endif

    let m = Match(s, '2023 *\zs\S+')
    if IsFile(m)
        return OpenBuffer(m)
    endif

    if line('.') == 1
        let i = FindLineIndex('[''"]', 0, 1, 100)
        let m = FindLongFileString(getline(i))
        if Exists(m)
            return OpenBuffer3(m)
        endif
        ec 'error @ 1'
        return
    endif

    let f = FindLongFileString()
    let g = f
    if !Exists(f) || !HasExtension(f)
        if Test(f, 'ssh')
            return OpenBuffer3(f)
        endif
        let f = FindUrl()
        if !Exists(f)
            let f = Match(getline('.'), '// *\zs\w+|\w+\ze[\),]')
            if !Exists(f)
                ec 'no file or url'
                if IsDir(g)
                    return FilePicker(g)
                    ec 'is dir'
                endif
                return
            else
                let f = '/home/kdog3682/2023/' . f . '.js'
                if !IsFile(f)
                    return
                endif
            endif
        else
            return Python2('openBrowser', f)
        endif
    endif

    if !Test(f, '^/')
        "./utils.js"
        "let f = NormalizePath3(f)
        ec f
        "return
    endif

    let e = GetExtension(f)
    let exts = ['pdf', 'csv', 'png', 'jpg']
    if Includes(e, exts)
        return Python2('ofile', f)
    endif

    return OpenBuffer3(f)
    return OpenBuffer(f)

endfunction

function! IsUrl(f)
    return Test(a:f, 'http')
endfunction

function! GoWordUnderCursor()
    let word = GetCurrentWord()
    call SetMark('a')
    let res = ExecuteFunctionSearch(word)
    if res > -1
        call SetMark('b')
    endif
endfunction

"~/bash_history'
function! FindLongFileString(...)
    let s= a:0 >= 1 ? a:1 : CurrentLine()
    if Test(s, 'g:\w+file')
        return eval(Match(s, 'g:\w+file'))
    elseif Test(s, '\~?/\w+/')
        "//extractError('/home/kdog3682/PYTHON/pdf.py')
        let m =  Match(s, '\~?/\w+/.{-}\ze["'']')
        if Exists(m)
            return m
        endif
        let m =  Match(s, '\~?/\w+/.{-}(py|js)')
        return m
    elseif Test(s, '\./')
        let m =  Match(s, '\.?[a-zA-Z-_0-9]+(\.\w+)+')
        return m
    elseif Test(s, 'gitignore')
        return Match(s, '[''"]\zs/[^''"]{-}gitignore\ze[''"]')
    elseif Test(s, 'pdf')
        return Match(s, '[''"]\zs/[^''"]{-}pdf\ze[''"]')
    elseif Test(s, '"/\w')
        return Match(s, '[''"]\zs/[^''"]{-}\ze[''"]')
    elseif Test(s, '''|"') 
        return Match(s, '[''"]\zs[^''"]*(js|py|css|html|pdf|vue|csv|txt|json|math|logs|history|log|md|vim)\ze[''"]') 
    else
        return Match(s, '[/a-zA-Z0-9][/a-zA-Z0-9.]{-}\.(vim|js|py|csv|css|html|pdf|vue|log|md|txt|json|math|logs|history)')
    endif
endfunction


function! Uncomment(s)
    return Comment(a:s, 2)
endfunction
function! Comment(s, ...)
    let s:toggle = a:0 >= 1 ? a:1 : 0
    let s:prefix = Jspy("commentPrefix")
    let s = a:s
    function! Inner(i, s)
        let s = a:s
        let r = '^ *\zs' . trim(s:prefix)
        if s:toggle == 2
            return Replace(a:s, r . ' *', '')
        elseif empty(s:toggle)
            return Test(s, r) ? a:s : s:prefix . s
        else
            return Test(s, r) ? Replace(a:s, r . ' *', '') : s:prefix . s
        endif
    endfunction
    if IsArray(s)
        return map(copy(s), function('Inner'))
    endif
    return Inner('', s)
endfunction
function! CommentJS(s)
    let s = a:s
    return '// ' . s
endfunction

function! UncommentJS(s)
    let s = a:s
    return Replace(s, '//', '')
endfunction

function! ToggleComment2(index)
    let index = a:index
    let line = getline(index)
    if trim(line) == ''
        return 
    endif

    let regex = '^ *\zs("|//|<!--|#|/\*|\*/)'

    if Test(line, regex)
        call GetSet(index, {x-> Replace(x, '// *', '')})
    else
        call GetSet(index, {x-> '// ' . x})
    endif
endfunction

function! ChangeLegos()
    let file = 'test.html'
    call OpenBuffer(g:activehtmlfile)
    let index = SearchFromLocation(1, 'legoLoader', 500, 'index')
    if index > -1
        call ToggleComment2(index)
        call PrevBuffer()
    endif
endfunction
function! GetSet(index, Fn)
    let index = IndexGetter(a:index)
    let [spaces, line] = GetSpacesAndLine(index)
    let value = IsString(a:Fn) && Test(a:Fn, '\$') ? Templater(a:Fn, [line]) : FunctionGetter(a:Fn)(line)
    call setline(index, spaces . value)
endfunction

"ff
function! PrevBuffer()
    execute "buffer " . bufname('#') 
endfunction
" 07-25-2022
" 07-26-2022




function! ZLorem()
    let line = UpLine()
    let currentline = CurrentLine()
    let n = Match(currentline, 'function')
    if n == 'function'
        return Loremer()
    endif
        
    let m = Match(line, 'render|Zlorem')
    let dict = {
        \'a': 'b',
        \'avv': 'b',
        \'rw': 'return renderWrapper(this, children)',
        \'render': "return h('div', 'lorem text')",
    \}
    return get(dict, m, get(dict, input('choose key:  '), ''))
endfunction

function! Loremer()
    let numbers = readfile('loremer.names.txt')
    let n = numbers[-1]
    let n += 1
    call writefile([n], 'loremer.names.txt', 'a')
    return 'loremer' . n
endfunction
function! ArgConverter2(s)
    let s = a:s
    if !Exists(s)
        return ''
    elseif s == 'cfs'
        return join(GetCurrentBuffers(), ' ')
    elseif s == 'x'
        return CurrentFile()
    elseif s == 'cf'
        return CurrentFile()
    elseif s == 'cfn'
        return GetFunctionName()
    elseif s == 'cfn'
        return GetFunctionName()
    elseif s == 'fg'
        return FileGetter2(s)
    elseif s[0] == '$'
        return eval('g:' . s[1:])
    else
        let value = ShellEscape(s)
        if !Exists(value)
            let value = s
        endif
        return value
    endif
endfunction



" 07-29-2022
" 07-29-2022
"



function! IncrementLine(n)
    call ReplaceLine(a:n, '\(\zs\d+\ze\)', {s -> s[0] + 1})
endfunction
function! SaveMark()
			call setpos("'z", [0, line('.'), 100, 0])
endfunction

function! GetMark()
			let mark = getpos("'z")
      return mark[1]
endfunction
" 07-31-2022
" 08-01-2022
"
"

function! FunctionFinder()
    let [name, methods] = FunctionData()

    let f = '"^    \zs" . v:val . "\ze\(")'
    let methodRegexes = map(methods, f)
    "let dict = {
        "\[name]: 'hi'
    "}
    "ec dict
endfunction
function! FunctionData()
    let block = GetCodeBlock()
    let type = GetCodeType(block[0])
    let name = GetFunctionName(block[0])
    let methods = []
    if type == 'class'
        let methods = MapFilter(block, {s -> Match(s, "^    \zs\w+\ze\(")})
    endif
    return [name, methods]
endfunction
function! DdelMapFilter(items, fstring)
    let items = a:items
    let fstring = a:fstring
    return filter(map(items, fstring), 'Exists(v:val)')
    
endfunction


function! GetCodeType(s)
    let s = a:s
    return Match(s, '^\w+')
    
endfunction
" 08-01-2022

" 08-01-2022
function! MarkAsInvivoJavascriptFile()
    let file = CurrentFile()
    let g:invivoJavascriptFile = file
endfunction

function! MGet(s, r)
    let s = a:s
    let r = a:r
  let s:match = ''

  function! InnerFunction(m)
    let m = a:m
    let s:match = !empty(m[1]) ? m[1] : m[0]
    return ''
  endfunction

  let value = Replace(s, r, function('InnerFunction'))
  return [value, s:match]
endfunction

"function MGet(s, r)
function! MGetold()
    "let s = a:s
    "let r = a:r
    let s = 'hiii'
    let r = 'i'
    let value = Replace(s, r, function('MGETCALLBACK'))
    let m = Match(s, r)
    if Exists(m)
        return [s[len(m):], m]
    else
        return [s, '']
    endif
endfunction
function! FileGetter3(s)
    let ref = GetGValue('2023') ? g:file2023dict : g:filedict
    return get(ref, a:s, a:s)
endfunction
" 08-02-2022
"
"
function! Ifu()
    let s = "if (typeof " . input('') . " == 'undefined') "
    return s
endfunction
function! Qrf()
    let s = 's = read("' . bufname('#') . '")'
    return s
endfunction




" 08-02-2022


function! FileRunner(file)
    let file = a:file
    let e = GetExtension(file)
    "if e == 'py'
    if !IsFile(file)
        ec 'not a file'
        return 
    endif
    if e == 'js'
        call Node(file)
    else
        ec 'hi'
    endif
endfunction
" 08-03-2022

function! JspyComment(s)
    let ref = {
        \'js': '/** $0 **/',
        \'html': '<!!-- $0 -->',
        \'vimrc': '"" $0',
        \'py': '### $0',
        \'css': '/** $0 **/',
    \}

    let template = get(ref, GetExtension())
    return Templater(template, trim(a:s))
endfunction

function! InvivoBookMarkLine()
    let name = ToAbrev(GetFunctionName())
    let index = GetFunctionIndex()
    call AppendBelow(index, JspyComment(name))
endfunction
function! BookmarkLineFileAndFunction()
    let name = GetBindingName()
    let key = Prompt('Create a bookmark key for the line. Otherwise #bindingName will be used: ', Abrev(name))
    let file = CurrentFile()
    let line = CurrentLine()
    call AppendVimDict('bookmarks2023', key, file, name, line)
endfunction

function! GoToBookmarkedLine()
        let file = Tail() . '.bookmark-lines.txt'
        let lines = Unique(Filtered(readfile(file)))
        let line = Choose(lines)
        let [a,b] = SplitOnce(line)
        if Exists(line)
            let r = '^(var|function!?|def|class|const) '
            call ExecuteRegex(r . a)
            if Exists(b)
                call ExecuteRegex(b)
            endif
        endif
endfunction
"let file = Tail() . '.bookmark-lines.txt'
"let lines = Unique(Filtered(readfile(file)))
"ec lines
" 08-04-2022
" 08-04-2022

function! TailTextFile(s)
    let s = a:s
    return Tail() . '.' . s . '.txt'
endfunction
function! LoadShortcutsForFile()
    let file = TailTextFile('vim-shortcuts')
    let data = readfile(file)
    ec 'loading shortcuts'
    exec data
endfunction


function! WriteShortcutsForFile()
    let indexes = GetIndexesHelper('contiguous')
    let lines = DeleteBlock(indexes)
    let file = TailTextFile('vim-shortcuts')
    call AppendFile(file)
    "return lines
    "return lines
    "return indexes
endfunction
"inoremap <expr> xp VueDiv('p')
"inoremap <expr> xd VueDiv('div')
"inoremap <expr> xh VueDiv('h2')

function! VueDiv(s)
   let s = a:s 
   let tag = s
   let left = Repeat("\<LEFT>", 3 + len(tag))
   let value =  "<" . tag . " class=\"$" . tag . "\"></" . tag . ">" . left
   return value
endfunction

" 08-04-2022
" 08-05-2022


"
"mixinsForWS3



    "return ExecuteRegex('^}')
function! VueAddTransition(indexes, arg)
    let [above, below] = get(g:vueaddtransitiondict, a:arg)
    let Parser89 = {x -> function('PySnippetTemplater2')(x, [], '')}
    let regex = '\$(\{.{-}\}|\d+|[A-Z])'
    let above = Sub(above, regex, Parser89)
    "call PlaceSnippet(snippet, spaces)
    call AboveAndBelow(a:indexes, 'IndentLine', above, below)
endfunction




function! Exec3(s)
    let s = ToString(a:s)
    ec '-----------'
    ec s
    ec '-----------'
    try
        execute s
    catch
        let error = v:exception
        ec {'error': error, 'input': s}
    endtry
endfunction
function! Exec2(s)
    let s = a:s
    ec "cmd: " . s
    ec '-------------'
    execute s
endfunction
function! ExecuteRegex2(regex, backwards) abort
    let dir = Exists(a:backwards) ? "?" : "/"
    let r = dir . "\\v" . a:regex
    execute r
endfunction
" 08-06-2022

function! CreatePyFunction()
    let context = GetContext2()        
    if spaces == '    '        
        if context == 'class'
            return PySnippet(spaces . '' . 'pcfclass' . ' ' . line)        
        else
            ec 'hi'
            return PySnippet(spaces . '' . 'pcffn' . ' ' . line)        
        endif
    endif
endfunction

function! LooksLikeExistingLine(s)
    "return Test(a:s, '\w+\(.{-}\)')
    return Test(a:s, '\w+\(')
endfunction
function! FunctionMakerLines(m)
    let m = a:m
    "let m= '(foo, boo.like = asdf)'
    let args = Findall3(m, '\v([,\(] *)\zs[a-zA-Z0-9.]+')
    let args = map(args, 'MapFunctionParts(v:val)')
    let args = join(args, ', ')
    let name = Match(m, '\w+\ze\(')
    "return args
    let [p1, p2, suffix, capitalize] = JSPY('p1', 'p2', 'suffix', 'capitalize')
    let lines = [p1 . ' ' . name . '('. args . ')' . p2, '    ', suffix]
    return lines
endfunction

function! CreateFunctionBlock(...)
    " cfb
    let line = CurrentLine()
    let trimmed = trim(line)
    if trimmed == ''
        return FooFunction()
        return PySnippet('emptyFunction')
    elseif trimmed == 'runner'
        return PySnippet('runner')
    elseif Test(trimmed, '^(v|app)-')
        call OpenBuffer3('baseComponents.js')
        let name = Match(trimmed, '\S+')
        return VueComponentSnippet(name)
    elseif Test(trimmed, '^\w+-\w')
        let name = Match(trimmed, '\S+')
        return VueComponentSnippet(name)
    endif

    let m = Match(trimmed, '^button \zs\w+$')
    if Exists(m)
        let s = printf("%s() {\n     \n},\n", m)
        call ExecuteRegex('^}')
        call AppendAbove2(s)
        call Cursor(line('.') - 2, 100)
        startinsert
        return 

    endif


    if LooksLikeExistingLine(line)
        let m = Match(line, '\w+\([^()]{-}\)')
        if empty(m)
            let m = FindallWords(line)
            let m = printf('%s(%s)', m[0], join(m[1:], ','))
        else
            let m = RemoveQuotes(m)
        endif
        let lines = FunctionMakerLines(m)
        call AppendBottom(lines)
        call EvalCursor('$-1')
        return 
    elseif Test(line, ':')
        let f = GetLastWord(line)
        let s = printf("function %s(s) {\n    \n}", f)
        call append('$', ToLines(s))
        call Cursor('$')
        return 
    endif

    let lines = NameMaker()
    call TextPlacement(lines)
    call cursor(Relative(1), 100)
endfunction

function! GetContext3()
    let r = '^\w+\ze.+\{ *$'
    let spaces = CurrentSpaces()
    if len(spaces) == 0
        return 'function'
    endif
    let match = MatchSearch(r, 'b')

    if match =~ ':$' 
        let match = 'vue'
    elseif match =~ 'const\>'
        let match = 'dict'
    elseif match =~ 'class|constructor' 
        let match = 'class'
    elseif match =~ 'function' 
        let match = 'function'
    else
        let line = GetFunctionLine()
        if Test(line, '^class')
            return 'class'
        else
            return 'dict'
        endif
    endif
    return match

endfunction

function! FixLine(line)

    let line = a:line
    let line = get(g:functionblocktransformdict, line, line)
    let line = Del(line, '^function ')
    let line = Replace(line, '^ *(on|zfoo|set|get)\zs\w', {s -> Capitalize(s[0])})
    let async = ''
    if Test(line, '^async ')
        let async = 'async '
        let line = line[6:]
    elseif Test(line, '^a ')
        let async = 'async '
        let line = line[2:]
    endif
    return [line, async]
endfunction


function! NameMaker(...)
" nm
    let s = a:0 >= 1 ? a:1 : getline('.')
    let [p1, p2, suffix, capitalize, prefix] = JSPY('p1', 'p2', 'suffix', 'capitalize', 'prefix')
    echo [p1, p2, suffix, capitalize, prefix]
    let [spaces, line] = GetSpacesAndLine(s)

    if !LooksLikeFunction(line)
        "if LooksLikeDictionaryName(line)
            "return [prefix . line . ' = {', '    ', '},']
        "endif
    endif

    let context = GetContext3()
    let [line, async] = FixLine(line)
    let name = 0
    let end = '}'

    if context == 'dict' || context == 'vue' || context == 'const' || context == 'var'
        let name = CreateName(line, capitalize)
        let name = async . Del(name, '^function ')
        let suffix = '},'
    elseif context == 'class'
        if p1 == 'def'
            let name = 'def ' . CreatePythonClassFunctionName(line)
        elseif Test(line, 'get ')
            let name = Match(line, '\w+$')
            let name = 'get ' . name . '()'
        elseif Test(line, 'set ')
            let name = CreateName(Del(line, '^ *\w+ *'), 0)
            let name = 'set ' . name
        elseif Test(line, 'static ')
            let name = CreateName(Del(line, '^ *\w+ *'), 0)
            let name = 'static ' . name
        else
            let name = CreateName(line, 0)
        endif
    else
        let name = p1 . ' ' . CreateName(line, capitalize)
    endif

    return [async . name . p2, '    ', suffix]
endfunction

function! JSPY(...)
    let lang = ''
    let keys = ''

    if Test(a:1, '^(js|js2|py)$|\.\w+$')
        let lang = GetLang(a:1)
        let keys = a:000[1:]
    else
        let lang = GetLang()
        let keys = a:000
    endif
    if has_key(g:langaliasdict, lang)
        let lang = g:langaliasdict[lang]
    endif
    let dict = get(g:jspydict, lang, g:jspydict['js'])
    let value = DictGetter(dict, keys)
    return value
endfunction
function! NPath(dir, file)
    let dir = a:dir
    let file = a:file
    return dir . Tail(file)
endfunction
function! MapFunctionParts(s)
    let s = a:s
    if Test(s, 'this')
        return 'state'
    elseif Test(s, '\.')
        return 'options'
    elseif Test(s, '[''|"]')
        return 's'
    else
        return s
    endif
endfunction

function! CreatePythonClassFunctionName(line)
    if Has(a:line, '\(')
        return Replace(a:line, '\(', '\(self,')
    endif
    
    let parts = split(Strip(a:line))
    let first = parts[0]

    let rest = '(self)'

    if len(parts) > 1
        let rest = '(self, ' . join(parts[1:], ', ') . ')'
    endif

    return first . rest
endfunction


function! CreateName(line, capitalize)
    if Has(a:line, '\(')
        if Exists(a:capitalize)
            return Capitalize(a:line)
        endif
        return a:line
    endif
    
    let parts = split(Strip(a:line))
    let first = parts[0]

    let rest = '()'

    if len(parts) > 1
        let rest = '(' . join(parts[1:], ', ') . ')'
    endif

    if a:capitalize
        let first = Capitalize(first)
    endif
    
    return first . rest
endfunction


" 08-07-2022
" 08-07-2022
" 08-08-2022



function! GI3(key)
    let key = a:key
    
   if key == 'cccccccccccccccc'
    return
   elseif key == 'dateBlockaaa'
    return
   elseif key == 'dateBlockaaa'
    return
   elseif key == 'fileblock'
        let ref = {
            \'md': 'contiguous',
            \'js': 'codeblock',
            \'py': 'codeblock',
        \}
        let k = get(ref, Lang(), 'contiguous')
        return GI3(k)

   elseif key == 'dateBlock'
        let m = 0
        let n = 0
        let a = '.'
        let b= '.'
        if Test(getline(a), g:dateRE2)
            let m = line('.')
            let b = m + 1
        else
            let m = FindLineIndex(g:dateRE2, a, -1)
        endif

        try
            let n = FindLineIndex('^(\d+-\d+-\d+|---|#)', b, 1)
            let n -= 1
        catch
            let n = line('$')
        endtry
        ec [m, n]
        return [m, n]
   elseif key == 'belowCursor' || key == 'below-cursor'
        return [line('.'), line('$')]

   elseif key == 'mdblock'
        let start = search('\v^#', 'bn')
        return [start, line('.')]

   elseif key == 'window10'
        return [max([1, line('w0') - 10]), min([line('w$') + 10, line('$')])]

   elseif key == 'window2'
        return [max([0, line('w0') - 10]), min([line('w$') + 5, line('$')])]

   elseif key == 'upWindow'
        let bottom = line('w0')
        let top = bottom - 50
        return [top, bottom]
   elseif key == 'window'
        return [line('w0'), line('w$')]
   elseif key == 'vueTemplate'
    let n = FindLineIndex('`', '.', -1)
    let m = FindLineIndex('`', '.', 1)
    let n += 1
    let m -= 1
   return [n, m]
   elseif key == 'tilda'
    let n = FindLineIndex('`', '.', -1)
    let m = FindLineIndex('`', '.', 1)
    let n += 1
    let m -= 1
    return [n, m]

   elseif key == 'innerblock'
        let n = FindLineIndex('\{', '.', -1, 20)
        if !Test(getline(n), '^ *(switch|if|else|(async )?function|\w+\()')
            let n = FindLineIndex('{', n - 1, -1)
        endif
        if !Test(getline(n), '^ *(switch|if|else|(async )?function|\w+\()')
            let n = FindLineIndex('\{', n - 1, -1)
        endif
        let spaces = GetSpaces(n)
        let bottom = FindLineIndex('^' . spaces . '\}', '.', 1)
        return [n, bottom]
        return GetInnerBlockIndexes()

   elseif key == 'sameStartingWord'
        return SameWordIndexes()
   elseif key == 'nobreaks-noroot'
       return GetNolinebreakNoRootIndexes()
   elseif key == 'same-indent-no-breaks'
        let indent_pat = '^' . matchstr(getline('.'), '^\s*') . '\S'
        let firstline  = search('^\%('. indent_pat . '\)\@!','bnW') + 1
        let lastline   = search('^\%('. indent_pat . '\)\@!', 'nW') - 1
        if lastline < 0
            let lastline = line('$')
        endif
        return [firstline, lastline]
   elseif key == 'line'
        return [line('.')]
        return [line('.'), line('.')]
   " @bookmark 1681026682 
   elseif key == 'nospaces-nobraces' || key == 'noss'
        "no W"
        "let up = '^ *[\}\]?$'
        "let down = '^ *[\}\]?$'
        "let up = '^ *[\]})]*$'
        "let down = '^ *[\]})]*$'

        let r = '^\W*$'
        let upindex = FindLineIndex(r, '.', -1, 20)
        let wmax = line('$')
        let downindex = wmax
        try
            let downindex = FindLineIndex(r, '.', 1, 20)
        catch
            if wmax - line('.') > 20
                throw 'errorrrrrrrrrrrrrrrrrrr'
            endif
        endtry
        let upindex += 1
        let downindex -= 1
        ec [upindex, downindex]
        return [upindex, downindex]

   elseif key == 'spaceblock'
        let spaces = GetSpaces()
        let r = '^' . spaces . '\S'
        let upindex = line('.')
        let downindex = SearchDown2(r, 1)
        return [upindex, downindex]
   elseif key == 'matchingspaces'
        let prefix = '^    \w.{-}'
        let upregex = prefix . '[\{\[]$'
        let downregex = prefix . '\\?[\}\]]'
        let upindex = SearchUp(upregex)
        let downindex = SearchDown(downregex)
        return [upindex, downindex]

   elseif key == 'betweenblocks'
        return FindUpDownIndexes('[\[\{]', '[\]\}]', 50)
   elseif key == 'anyblock'
       return GetAnyFunctionBlockIndexes()
   elseif key == 'code' || key == 'codeblock' || key == 'smartblock' || key == 'block'
        if key == 'smartblock'
            ec 'gotta do the smartblock later'
        endif
       return GetCodeIndexes()
   elseif key == 'functionblock'
       return GetFunctionOrInnerFunctionIndexes()
   elseif key == 'smart'
       return GetSmarterIndexes()
   elseif key == 'trycatchindex'
       return GetTryCatchIndexes()
   elseif key == ''
       return GetCodeIndexes()
   elseif key == 'nolinebreak' 
       return GetNolinebreakIndexes()
   elseif key == 'smartcontiguous'

       return GetSmartContiguousIndexes()

   elseif key == 'contiguous'
       return GetContiguousIndexesIBM()
   elseif key == 'smart'
       return GetSmartIndexes()
   else
       return GetFullVisualIndexes(key)
   endif
endfunction
function! GetIndexesHelper2(key) abort
   let [indexes, flag] = GetVisualIndexes('flag')
   if empty(flag)
       return indexes
   endif
   return GI3(a:key)
endfunction


function! BackSlashAction()
    ec 'hi' 
    "/* As
    "/* as
endfunction

function! LooksLikeArrayName(s)
    return Test(a:s, '^\w*s$')
endfunction
" 08-08-2022
" 08-09-2022



function! EvalCursor(s, ...)
    let chpos = a:0 == 1 ? a:1 : 100
    let line = a:s
    let line = '$-1'
    let line = Replace(line, '\$', line('$'))
    let line = eval(line)
    call cursor(line, chpos)
endfunction
function! LogIt2(s)
    let key = a:s
    let line = CurrentLine()
    let r = '(\w+|\[.{-}\]|\{.{-}\})\ze ?\+?\=|return \zs\w+'
    if Test(line, 'function\W? |\{ *$')
        let r = '\(\zs.{-}\ze\)'
    endif
    let match = Match(line, r)
    let match = Sub(match, '[\[\]]', '')
    let template = g:logittemplatedict[key]
    let value = Templater(template, [match])
    call Append(value)
endfunction
function! RemoveQuotes(s)
    return Sub(a:s, '''|"', '')
endfunction



function! TestingEnvironment()
    let from = line('.')
    let to = line('$')
    call ExtractLines(from, to, 'IsCallable2')
endfunction
function! IsCallable2(s)
    return Test(a:s, '^throw|^\w+(\.\w+)*\(')
endfunction
function! ExtractLines(from, to, f)
    let from = a:from
    let to = a:to
    "let F = FunctionGetter(a:f)
    let store = []

    for i in Ranger(from, to)
        let line = getline(i)
        if IsCallable2(line)
            call add(store, line)
            call setline(i, '')
        endif
    endfor
    ec store
    if input('') == 1
        return 
    endif
    call insert(store, 'throw ""', 0)
    call insert(store, '', 0)
    call AppendBottom(store)
    call Cursor(line('$') - len(store))

endfunction
"VisualMakePyDict
function! VisualTransferBlock(state)
    let state = a:state
    let lines = PadLinesWithNameAndDate(state.lines)
    call DeleteBlock(state.indexes)
    call AppendFile(state.to, lines)
endfunction
function! WrapLines(a)
    let a = ToLines(a:a)
    call add(a, '')
    cal insert(a, '', 0)
    return a
endfunction
function! SaveCodeBlock(i)
    let lines = WrapLines(GetLines(a:i))
    call NormAppend('saved.txt', lines)
    call DeleteBlock(a:i)
endfunction

function! GoFunction()
    let n = GetCurWord()

    if has_key(g:wordplacerdict, n)
        return WordPlacer(n)
    endif

    let line = CurrentLine()
    let r = ['function\(''\zs\w+', '[ \(]\zs\w+\ze\(', '\= "\zs\w+', '\= \zs\w+']
    let m = IterMatch(line, r)
    if !Exists(m)
        let m = n
        return 
    endif
    let found = ExecuteFunctionSearch(m)
    if !Exists(found)
        let parameters = GetParameters(line)
        let name = Match(line, 'function \zs\w+|\w+\ze\(')
        let params = join(parameters, ', ')
        let t = "function $0($1) {\n    $c\n}\n"
        let s = Templater(t, [name, params])
        call GoTop()
        call PlaceSnippet(s, '')
    endif
endfunction
function! DateLine()
    return Jspy('commentPrefix') . DateStamp()
endfunction
function! OLDOnVimStartup()
    let classfile = '/home/kdog3682/CWF/public/class.js'
    let vimfile = '/home/kdog3682/.vimrc'
    "call BasePY('NewYear')
    "call BaseJS('doYesterday')
    "call AppendFile(classfile, DateLine())
    "call AppendFile(vimfile, 'let ' . DateLine())
endfunction
function! OnVimStartup() abort
    let classfile = '/home/kdog3682/CWF/public/class.js'
    let vimfile = '/home/kdog3682/.vimrc'

    try 
        call Cursor('$')
        return 
        call OpenBuffer3(g:activeNodeFile)
        return 
        call append('.', DateLine())
   catch 
        ec v:exception
        ec 'error'
    endtry
endfunction

function! GetSnippetLines(snippet, spaces)
    let snippet = a:snippet
    let spaces = a:spaces
    
    let snippet = Replace(snippet, ', \ze\)', '')
    let snippet = Replace(snippet, '\$c', '')
    let snippet = Indent(snippet, spaces)
    let lines = SplitLines(snippet)
    return lines

endfunction
function! WordPlacer(s)
    let s = a:s
    let s = 'config'
    
    let spaces = CurrentSpaces()
    let [template, above] = g:wordplacerdict[s]
    "let cursorpos = GetCursorFromStringSnippet(template)
    let lines = GetSnippetLines(template, 0)
    call TextPlacement2(lines, spaces, 1)
    call SetCursor(line('.') + 1, 100)
endfunction

function! TextPlacement2(lines, spaces, offset)
    let spaces = ToSpaces(a:spaces)
    let lines = map(a:lines, {pos, line -> spaces . line})
    let offset = a:offset
    let lineIndex = line('.')
    if offset == 1
        let lineIndex = Search('^ *$', 'b', line('.') - 3)
    elseif offset == 2
        let lineIndex += 1
    endif
    call setline(lineIndex, lines[0])
    call append(lineIndex, lines[1:])
endfunction
"/** asd **/
function! BookmarkLine(...)
    let name = a:0 >= 1 ? a:1 : ToAbrev(GetFunctionName())
    let spaces = '    '
    let s = Templater("/** $0 **/", [name])
    call Append(spaces . s)
    return s
endfunction
function! Templater(template, ...)
    let val = a:0 >= 1 ? a:1 : 0
    if !Exists(val)
        return Replace(a:template, '\$(\w+)', {x -> function(g:templaterfndict[x[1]])()}, 'g')
    elseif IsArray(val)
        return Replace(a:template, '\$(\d+)', {x -> val[x[1]]}, 'g')
    else
        return Replace(a:template, '\$0', val, 'g')
    endif
endfunction


function! NewFunction(s)
    let s = a:s
    call cursor('$', 100)
    let lines = NameMaker(s)
    call insert(lines, '', 0)
    "call TextPlacement(lines)
    call TextPlacement2(lines, CurrentSpaces(), 2)
    call cursor(Relative(3), 100)
endfunction
function! WPText()
    return 
    call setline('.', 'hi')
endfunction
function! Titleify()
    call GetSet('.', '### $0')
endfunction

function! QMath()
    let ref = {
        \'average': '$$$\\frac{add everything up}/{number of items}$$$',
    \}
    let m = SprawlMatch('average')
    let t = 'The formula for $0 is $1.'
    return Templater(t, [m . 's', ref[m]])
endfunction
inoremap<silent> <expr> qm QMath()
function! Right(s)
    let right = "\<Right>"
    return  Repeat(right, a:s)
endfunction

"inoremap<silent> df \\frac{}{}<LEFT><LEFT><LEFT>
function! QJump()
    let right = "\<RIGHT>"
    let pos = getpos('.')[2]
    let line = getline('.')[pos - 1:]
    let x = match(line, '\v[\{\(]')
    if x > 0
        return Repeat(right, x + 1)
    else
        return "\<ESC>o"
    endif

endfunction

"inoremap<silent> <expr> qw QJump()

function! QRPW()
    return Templater("rpw($qgp, $lf, 'throw')")
endfunction
"inoremap<silent> <expr> qrp QRPW()
function! GetLastFunction()
    let m = SprawlMatch('function \zs\w+')
    return m
endfunction
"inoreab <silent>  o1 only: 1,<C-R>=Eatchar('\s')<CR>
"nnoremap 6 ?^\(const\\|var\)
"functions.pub.js.json
"functions.jch.js.json
function! SimpleAppendFile(f, s)
    let data = IsString(a:s) ? [a:s] : a:s
    ec data
    "call writefile(data, a:f, 'as')
endfunction
function! OpenBuffer(buffer, ...)
    let buffer = a:buffer

    if IsCurrentFile(buffer)
        ec 'is current'
        return
    endif

    if Not(buffer)
        ec 'not a buffer: ' . buffer
        return
    endif

    let name = IsStringNumber(buffer) ? bufname(str2nr(buffer)) : buffer
    if IsPdf(name) || IsCsv(name)
        return OpenPdf(name)
    endif
    if bufexists(name)
        let command = 'buffer!'
    else
        let command = 0 >= 1 ? "vsplit" : "edit"
        if !IsFile(name)
            if !Test(name, '-')
                call AppendWithDate('new-files.txt', name)
            endif
        endif
    endif
    let cmd = Join(command, name)
    "ec cmd
    "return
    execute cmd
endfunction
function! ToRoot(f)
    let f = a:f
    return g:rootdir . f
endfunction

function! AppendWithDate(f, payload)
    let f = a:f
    let payload = a:payload
    let s = DateStamp() . ' ' . payload
    call writefile([s], ToRoot(f), 'a')
endfunction

function! GoToLeader(key)
    let key = a:key
    let name = g:ldrdict[key]
    call FindFunction(name)
endfunction

function! FindFunction(key)
    let key = a:key
    let found = ExecuteFunctionSearch(key, 1)
    if found == 0
        ec 'checking the other vim page'
        call ChooseBuffer2('iab')
        let found = ExecuteFunctionSearch(key, 1)
        if found == 0
            ec 'not found and returning to vim'
            call ChooseBuffer2('v')
        endif
    endif
endfunction


function! ExecuteFunctionSearch(s, ...)
    let fuzzy = a:0 >= 1 ? '\w*' : ""
    let s = a:s
    try
        let regex = "/\\v^((async )?function!?|var|let|def|class|const) " . s . fuzzy . ">"
        " ec regex
        execute regex
        normal! zt
        return 1
    catch
        return 0
    endtry
endfunction

"let regex = "/\\v^((async )?function!?|var|let|def|class|const) AddFile\w*>"
"execute regex
"call ExecuteFunctionSearch('add', 1)


function! AbbreviateFile(b)
    let b = a:b
    return ToAbrev(RemoveExtension(Tail(b)))
endfunction

"ldr.ff: find function with fuzzy ending. "ff addf" (AddFile)
"ldr.gtl: go to leader function based off a key "gtl f"  (AddFile)
"ldr.bml: adds a bookmark which can be retrieved with n5
function! GetWindowWords(...)
    let r = a:0 >= 1 ? a:1 : '\w+'
    let m = FindallStrings(GetWindowString(), r)
    return m
endfunction

function! GetWindowString()
    return join(GetWindowLines(), "\n")
endfunction

function! GetWindowLines()
    let a = line("w0")
    let b = line("w$")
    return getline(a, b)
endfunction

function! WindowMatch(r)
    let r = a:r
    for line in GetWindowLines()
        if Test(line, r)
            return Match(line, r)
        endif
    endfor
endfunction
"pyd
function! Google(s)
    let s = a:s
    ec a:s
endfunction
" september and october are the months with most forgiveness
function! FindUrl()
    let s = CurrentLine()
    let file = Match(s, '<http[^''" ]+|[''"]\zs[^''"]{-}\.(com|org)\ze[''"]') 
    "let file = Match(s, '[''"]\zshttp[^''"]*\ze[''"]|[''"]\zs[^''"]{-}\.(com|org)\ze[''"]')
    return file
endfunction
function! ClockStamp()
    return strftime('%A, %B %d, %-I:%M%p')
endfunction
function! PrevDatestamp()
    execute "?" . DateStamp()
endfunction
function! Navigator(regex)
    let regex = a:regex
    let top = GetFunctionIndex()
    let index = FindLineIndex(regex, top, 1)
    if index < 0
        return 
    endif
    let index += 5
    call SetCursor(index)
endfunction


"ec ShellEscape('hi there')
function! MagicVueHandler(n, line)
    let n = a:n
    let line = a:line
    let word = GetFirstWord(line)
    let dict = {
        \'render': ['AppendBelow', 'SayHiFrom'],
        \'function': ['AppendBelow', 'SayHiFrom'],
        \'async': ['AppendBelow', 'SayHiFrom'],
        \'mounted': ['GetSet', ''],
    \}
    if !has_key(dict, word)
        ec word
        return 
    endif
    let [fn, gn] = dict[word]
    let b = FunctionGetter(gn)(line, word)
    let a = FunctionGetter(fn)(n, b)
    "render
endfunction
function! ToggleLine()
    let r = 'toggletoggle'
    let i = FindLineIndex2(r)
    call ToggleComment2(i)
endfunction
function! RunLeaderRef(key, arg)
    let key = a:key
    let arg = a:arg
   if Exists(arg)
       call function(g:ldrdict[key])(arg)
   else
       call function(g:ldrdict[key])()
   endif
endfunction

function! GlobFiles(dir)
    let dir = a:dir
    let glob = split(globpath(dir, '*'), "\n")
    return glob
endfunction
function! ExecuteFileString()
    let s = ReadFile('/home/kdog3682/CWF/public/text-commands.vim')
    return Exec2(s)
endfunction
function! TextEnter()
    let line = getline('.')
    if len(trim(line)) > 5 || Test(line, ': *$')
        return "\<CR>\<TAB>"    
    else
        return "\<CR>"
    endif
    
endfunction




function! TextBracketRight()
    let line = getline('.')
    if len(trim(line)) > 5 || Test(line, ': *$')
        return "\<CR>\<TAB>"    
    else
        return "\<TAB>"
    endif
endfunction

function! TextBracketLeft()
    let line = getline('.')
    return "\<CR>\<BS>"
    if len(trim(line)) > 5 || Test(line, ': *$')
        return "foo"
    else
        return "\<c-d>"
    endif
endfunction

"inoremap \ G
"nnoremap \ :call BackSlashAction()<CR>


"nnoremap \ /\v<><LEFT>
"nnoremap \ /\C\v\/\*  \*\/>/e<LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT>

function! HtmlEnter()
    let line = getline('.')
    if len(trim(line)) < 1
        return "G<CR>"
    endif
    let line = 'hi'
    let items = split(line, ' ')
    let length = len(items)
    if length == 1
        return Divify
    elseif length == 2
        return 'hi'
    endif
    return items
endfunction

function! MagicVueHandler(n, line)
    let n = a:n
    let line = a:line
    let word = GetFirstWord(line)
    let dict = {
        \'render': ['AppendBelow', 'SayHiFrom'],
        \'function': ['AppendBelow', 'SayHiFrom'],
        \'async': ['AppendBelow', 'SayHiFrom'],
        \'mounted': ['GetSet', ''],
    \}
    if !has_key(dict, word)
        ec word
        return 
    endif
    let [fn, gn] = dict[word]
    let b = FunctionGetter(gn)(line, word)
    let a = FunctionGetter(fn)(n, b)
    "render
endfunction
function! Divify(div, class, text, ...)
    ec 'from new page'
    let cursor = a:0 >= 1 ? '' : '$c'
    let class = a:class
    let div = a:div
    let text = a:text
    let snippet = "<" . div . " class=\"" . class . "\"" . "" . '' . ">" . text . "</" . div . ">" . cursor
    return snippet
endfunction


function! GetFromGdict(dictKey, key)
    "let value = GetFromGDict('iabhistory', word)
    let dictKey = 'g:' . a:dictKey
    let key = a:key
    if exists(dictKey)
        return get(eval(dictKey), word)
endfunction
function! AutoTextTab()
    let word = GetCursorWord()
    if len(word) < 1
        return "\<TAB>"
    endif

    let line = getline('.')
    let value = WordSpiral(word)

    if Exists(value)
        return Repeat("\<BS>", len(word)) . value
    else
        return "\<TAB>"
    endif

endfunction
function! TextThree()
    let name = Tail()
    if name == 'report-cards.txt' || name == 'comments.school.txt'
        let r = '^\w+: *$'
        let i = FindLineIndex(r, '.', -1, 50)
        let m = Match(getline(i), '\w+')
        if empty(m)
            return 'eeeeeerror'
        endif
        return m
    endif
    if !empty(g:lastname)
        return g:lastname
    endif

    let s = Replace(trim(getline('.')[0:GetChar()]), '^[# ]+', '')
    return len(s) == 0 ? '#' : '3'
    "return GetChar() == 1 || getline('.')[0] =='#' ? '# ' : '3'

endfunction

function! TextTwo()
    let s = trim(getline('.')[0:GetChar()])
    return len(s) == 0 ? '@' : '2'
endfunction


function! EndOfLine()
    let ch = GetChar()
    let length = strlen(getline('.'))
    return ch == length + 1
endfunction

function! BackSlashEscape(s)
    return Sub(a:s, '<', "\\")
endfunction
function! TextBackSlash(s)
    let keyString = "\<CR>\<ESC>i\<CR>----------------\<CR>\<CR>"
    let keyString = "\<ESC>a\<CR>----------------\<CR>"
    let keyString2 = "\<ESC>A\<CR>----------------\<CR>"
    if a:s == 1
        ec 'hiii'
        execute "normal " . keyString2
        return keyString
    elseif EndOfLine()
        return keyString
    else
        return '|'
    endif
endfunction


"nnoremap P :w<CR>:call Node('print.js')<CR>


function! InstallPip(s)
    let s = a:s 
    let t = DateStamp() . ' pip ' . s
    execute "!clear;pip3 install " . s
    call AppendFile(g:changelogfile, t)
endfunction

"inoreab <silent>  s self.<C-R>=Eatchar('\s')<CR>

function! LogItPython(...)
    let options = a:0 >= 1 ? a:1 : 0
    let line = CurrentLine()

    if Test(line, 'print|console')
        let spaces = GetSpaces(line)
        let match = Match(line, '\(\zs.{-}\ze\)$')
        let prefix = 'value = '
        call setline('.', spaces . prefix . match)
        return
    endif
    let match = Match(line, '(\w+|\[.{-}\]|\{.{-}\})\ze ?\+?\=|return \zs\w+')
    if !Exists(match)
        let match = trim(line)
    endif
    let value = Logger(match)
    if Exists(options)
        if options == 'tl'
            let value .= '; throw "";'
        elseif options == 'lh'
            let value = 'pprint("HII")'

        elseif options == 'le'
            let value = 'pprint(exciting())'
        elseif options == 'lt'
            let value = 'pprint({"item":' . match . ', "type": typeof ' . match . '})'

        elseif options == 'lj'
            let value = Templater('pprint(JSON.stringify($0, null, 2))', [match])

        elseif options == 'lr'
            let value = Templater('return pprint($0)', [match])

        elseif options == 'lg'
            let value = Templater('pprint($0)', [match])

        elseif options == 'lo'
            "let a = GetBindingName()
            "let b = match
            "let value = Templater('pairlog("[$0, $1]", $1)', [a,b])
            let value = Templater('pprint({$0})', [match])
            
            "let value = 'display({' . match . '})'

        elseif options == 'ld'
            let line = trim(line)
            let value = 'display(' . DoubleQuote(line) . ', ' . line . ')'

        elseif options == 'll'
            let value = Logger(DoubleQuote(trim(line)) . ', ' . CurrentIndex())
        elseif options == 'l0'
            let value = Logger('{' . join(GetBindings(line), ', ') . '}')

        elseif options == 'lf'
            let s = '{name: "$0", line: $1}'
            let s = Templater(s, [GetFunctionName(), CurrentIndex()])
            let value = Logger(s)
        elseif options == 'lp'
            let s = '{lp: "lp", value: $0, line: $1}'
            let s = Templater(s, [match, CurrentIndex()])
            let value = Logger(s)
            "let value = Logger(s) . Comment('lp')

        elseif options == 'hi'
            let value = Logger('hi')
        elseif options == 'lp'
            let value .= '; ' . Comment('lp')
        endif
    endif
    call Append(value)
endfunction
function! QDiv()
    return 
endfunction


function! F1003(x)
    let x = a:x
    if x == 'value'
        return 'item'
    else
        return x[:-2]
    endif
endfunction

function! F1004(s)
    let s = a:s
    return s
endfunction
function! F1002(x, y)
    let x = a:x
    let y = a:y

    if y == 'x1'
        return x[1:]
    elseif y == 'n'
        return F1004(x)
    elseif y == 'd'
        return F1003(x)
    elseif y == 'c'
        let x = Match(x, '\w+$')
        return DashCase(x)
    elseif y == 'cd'
        let x = Match(x, '\w+$')
        return F1003(DashCase(x))
    else
        return x
    endif
endfunction

function! Templater1002(s, val)
    return Sub(a:s, '\$(\d+)(c?d?n?(x\d+)?)', {x -> F1002(a:val[x[1] - 1], x[2])})
endfunction

function! ActivateHtml()
    let [spaces, line] = GetSpacesAndLine()
    "let line = 'v-asdf gdfg'
    let line = '.foo'
    let pairs = [
        \[ '^ift$', "<template v-if=\"$c\">\n</template>\n<template v-else>\n</template>" ],
        \[ '^p$', "<p class=\"\">$c</p>" ],
        \[ '^pre$', "<pre class=\"\">$c</pre>" ],
        \[ '^button \w+$', "<button class=\"$2c\" @click=\"$2\">$2n</button>" ],
        \[ '^template$', "<template v-slot=\"{}\">\n    $c\n</template>" ],
        \[ '^slot$', "<slot>\n    $c\n</slot>" ],
        \[ '^vn$', "<v-numbered :value=\"i\"class=\"\">\n    $c\n</v-numbered>"],
        \[ '^number$', "<ol class=\"number-container\">\n    <li class=\"number-item\">$c</li>\n</ol>"],
        \[ '^bullet$', "<ul class=\"bullet-container\">\n    <li class=\"bullet-item\">$c</li>\n</ul>"],
        \[ '^v[a-zA-Z-]+$', "<$1>\n    $c\n</$1>" ],
        \[ '^v[a-zA-Z-]+ \w+$', "<$1 :value=\"$2\"/>$c\n" ],
        \[ '^div$', "<div class=\"\">\n    $c\n</div>" ],
        \[ '^div$', "<div>\n    $c\n</div>" ],
        \[ '^div [a-zA-Z-]+$', "<div class=\"$2c\">\n    $c\n</div>"],
        \[ '^for [a-zA-Z0-9-.]+ [a-zA-Z0-9-.]+$', "<div class=\"$2c-container\">\n    <$3 v-for=\"$2d in $2\" :value=\"$2d\" class=\"$2cd\"/>$c\n</div>"],
        \[ '^for [a-zA-Z0-9-.]+$', "<div class=\"$2c-container\">\n    <div v-for=\"$2d in $2\" class=\"\">$c</div>\n</div>"],
        \[ '^\.[a-zA-Z0-9-]+$', "<div class=\"$1c\">$1x1</div>$c" ],
    \]
        "\[ '.', "<div class=\"$1c\">$1x1</div>$c" ],
    

    let items = split(line, ' ')
    for [regex, template] in pairs
        if Test(line, regex)
            let snippet = Templater1002(template, items)
            "return  snippet "use this for testing
            return PlaceSnippet(snippet, spaces)
        endif
    endfor
endfunction

"tc/hc
"nc=new components extending from mc.js -- in particular slot-type components"
"nnoremap 9 :w<cr>:b /home/kdog3682/CWF/public/mc.js<cr>
function! IabEat(...)
    let s = a:0 >= 1 ? a:1 : ''
    let name = ''
    let abrev = ''
    let items = split(s, ' ')
    if s == ""
        let name = GetCurrentWord()
        let abrev = ToAbrev(name)
    elseif len(items) == 1
        let name = GetCurrentWord()
        let abrev = items[0]
    elseif len(items) == 2
        let abrev = items[0]
        let name = items[1]
    endif
    let line = getline('.')
    let paren = Match(line, name . '\([''"]?')
    if Exists(paren)
        if len(paren) == "1" 
            let name .= '()<LEFT>'
        else
            let name .= '('''')<LEFT><LEFT>'
        endif
        let name .= "<C-R>=Eatchar('\\s')<CR>"
    endif
   let cmd = Join("inoreab", "<silent>", abrev, name)
   ec cmd
   return AppendAndExecute(cmd)
endfunction
function! SnippetRegistrar()
    let dict = Jspy('snippetDict')
    let t = 'let g:$1["$2"] = "$3"'
    let [a,b] = SplitOnce(trim(CurrentLine()))
    let cmd = RegistrarTemplater(t, [dict, a, b])
    call setline('.', '')
    call AppendAndExecute(cmd)
    
endfunction
function! Registrar(s)

    let s = a:s

    let e = GetExtension()
    if e == 'py'
        let name = GetFunctionName()
        let a = Abrev(name)
        let abrev = Prompt('abrev name or default: ' . a)
        if !Exists(abrev)
            let abrev = a
        endif
        let s = RegistrarTemplater(g:RegistrarDict.python, [abrev, name])
        call append('$', [s])
        "call AppendFile('/home/kdog3682/CWF/env.py', s)
        ec s
        return 
    endif

    if s == ''
        return RegisterEat()
    let [a,b] = SplitOnce(s)

    if a == 'ff'
      let args = [b, CurrentFile(), GetBindingName()]
      let cmd = Templater('let g:filefunctionref["$0"] = ["$1", "$2"]', args)
      ec cmd 
      return AppendAndExecute(cmd)
    endif

    if a == 'bm'
      let args = [GetLang(), b, CurrentFile(), GetBindingName()]
      let cmd = Templater('let g:jspyref2["$0"]["file-function-ref"]["$1"] = ["$2", "$3"]', args)
      ec cmd 
      return AppendAndExecute(cmd)
    endif

    let [mapping, key, arg] = SplitTwice(s)
    if arg == ''
        let arg = Sub(trim(getline('.')), '"', '\\"')
    endif

    if mapping == 'a' || mapping == ''
        let word = expand("<cword>")
        let abrev = ToAbrev(word)
        return Registrar('eat ' . abrev . ' ' . word . '()')
    endif
    if !has_key(g:RegistrarDict, mapping)
        ec 'no key'
        return 
    endif
    let template = g:RegistrarDict[mapping]

    let parameters = ''
    if Test(template, 'call')
        let [name, parameters] = GetFunctionNameAndParameters()
        if !Exists(key)
            let key = ToAbrev(name)
        endif
        if Exists(parameters)
            let template = Replace(template, '\)\<CR\>', ''''')<LEFT><LEFT>')
        endif

        let arg = name
    elseif mapping == 'eat' && !Exists(arg)
       let match = Match(s, '\(''*\).*$')
       let length = len(match) - 1
       if Test(match, '''')
           let length -= 1
       endif
       let left = Repeat('<LEFT>', length)
       let template = Replace(template, '\$2', left)
       if !Exists(arg)
           let arg = GetCurrentWord()
       endif
    endif

    if Test(arg, '\)$')
        let arg .= '<LEFT>'
    endif
    let args = [key, arg]
    "ec key
    "ec arg
    "return
    let cmd = RegistrarTemplater(template, args)
    ec cmd
    call AppendAndExecute(cmd)
endfunction
function! SetDirToCurrentFile()
    let head = Head()
    execute "cd " . head
    ec 'setting dir to ' . head
endfunction
function! Dt()
    call GetSet('.', {s -> Replace(s, 'this.', '')})
endfunction
"nnoremap dt call Dt()<CR>
" sdf ${sdf}${}dd ${dd} ${dfdf} 
function! ChangeFunctionNameFromPasteBuffer()
    let i = FindLineIndex('^(function|def|class)', '.', -1)
    call GetSet(i, {s -> Replace(s, '^\w+ \zs\w+', GetPasteBuffer())})
endfunction

function! Td()
    call GetSet('.', {s -> 'let template = "'  . s . '"'})
endfunction
"deletes quotes

function! IfParser(s)
    let logic2022 = get(g:logic2022, GetLang())
    let tag = a:s[0]
    let s = a:s[2:]
    let [a,b] = SplitOnce(s)
    let value = get(logic2022, a)
    let last = ''
    let regex = '\$(\d+)'
    let parts = split(b, ' ')

    let argRef = {
        \'a0': 'args[0]',
        \'a1': 'args[1]',
        \'a2': 'args[2]',
    \}
    let parts = map(parts, "DictConnector(v:val, argRef)")

    if Test(value, 'len')
        if len(parts) == 1
            let last = GetLastBinding()
            call add(parts, last)
        endif
    endif

    if Test(value, '\$2')
        if len(parts) == 1
            let last = GetLastSmallParam()
        endif
        
        call add(parts, last)

    elseif len(parts) == 0 && Test(value, '\$')
        let last = SprawlMatch('\(\zs[\.a-zA-Z]+\ze\)')
        call add(parts, last)
    endif

    let value = JspyTemplater2022(value)
    let value = Sub(value, regex, {x -> function('Pst2')(x, parts)})

    return ToLogic(tag, value)
endfunction
function! DictConnector(key, ref)
    return has_key(a:ref, a:key) ? a:ref[a:key] : a:key
endfunction
function! GetLastSmallParam()
    let value = SprawlMatch('<(\w+)\ze( \=|\()')
    if Exists(value)
        return value
    endif
endfunction
"eff s
function! WriteDitto()
    let upline = UpLine()
    let current = CurrentLine()

    "test: 
    "let upline="let text = getText(TEXT)"
    "let current="type"

    "let upline="case 'ArrayExpression': return 'array'"
    "let current="array object"

    let parts = split(current)
    let items = ''

    let items = DittoCopy(upline, parts)
    call AppendBlock2(items)
endfunction

function! CopyCapitalization(s, ref)
    let s = a:s
    let ref = a:ref

    if Test(ref, '\C^[A-Z]+$')
        return toupper(s)
    elseif Test(ref, '\C^[A-Z]')
        return Capitalize(s)
    else
        return s
    endif 
endfunction
"ec Test('Ha', '\C^[A-Z][A-Z]+$')
"ec CopyCapitalization('sdf', 'Has')
function! FindUpString(s)
    let s = a:s
    let r = "/^(var|(async )?function!?|def|class|const) "
    let r = "?\\v^" . "(async function|function|class|var) "
    try
         execute r . s 
         ". "/e"
    catch
        ec v:exception
        ec 'no match'
    endtry
    "call ExecuteRegex(r . a:s)
endfunction
function! SplitLineAtCursor()
    let line =  getline('.')
    let cursor = GetCursor()
    return [line[0:cursor - 1], line[cursor:]]
endfunction
function! QDot()
    let [a,b] = SplitLineAtCursor()
    let c = Replace(b, '.{-}\ze\.(map|filter|reduce)', {s -> Parens(s[0])})
    if Exists(c)
        call setline('.', a . c)
    endif
    "asdfasdfadf
    "asdfasdfadf
    "asdfasdfadf
    " $$$   $$$
    "asdfasdfadf
endfunction
"a((bc(da((a(sb(ae(f)())))))(a))))(abc.def) (0).map



"}

    "}
        "}

"}
    "}
        "}

function! TWS()
    
    let word = 'apu'
    let line =  "WordSpiralRE3"
    let line =  "WordSpiralRE3"
    let line =  "WordSpiralRE3"
    let line =  "cssAddUnit"
    let line =  "addPointUnit"
    let r = WordSpiralRE3(word)
    return Match(line, r)
endfunction
function! WordSpiralRE3(word)
    let word = a:word

    let length = len(word)
    let A = word[0]
    let B = word[1]
    let C = word[2]
    let regex = RDouble(A)
    let connector = '[._\-\[\]\{\}]'
    let connector = '[._\-]'

    if length == 1
         let regex .= '[a-zA-Z]{4,}'
    elseif length == 2
         let CapB = toupper(B)
         let regex .= '[a-zA-Z]{-}' 
         let regex .= RGroup(CapB, connector . RDouble(B))
    elseif length == 3
         let CapB = toupper(B)
         let CapC = toupper(C)
         let regex .= '[a-zA-Z]{-}' 
         let regex .= RGroup(CapB, connector . RDouble(B))
         let regex .= '[a-zA-Z]{-}'
         let regex .= RGroup(CapC, connector . RDouble(C))
    endif
    let regex .= '\w*'
    return regex
endfunction
function! AutoTab()
    let word = GetCursorWord()
    "a"a" w""w"w"w"" ""
    "return Quote(word)
    if len(word) < 1
        return "\<TAB>"
    endif

    "let value = get(g:tabbings, word)
    "if !empty(value)
        "return Repeat("\<BS>", len(word)) . value
    "endif

    "let value = WordSpiral(word)
    let value =  AutoTabWordCollection(word)
    if empty(value)
        return "\<TAB>"
    else
        "let g:tabbings[word] = value
        return Repeat("\<BS>", len(word)) . value
    endif

endfunction

function! WordFzGetter(a)
    let a = a:a
    let text = getline(a)

    "let regex  = '[$a-z]{1,}([-\._][$a-z]+)+|[$a-z]{5,}'
    " adding numbers
    "let regex  = '[$a-z]{1,}([-\._][$a-z]+)+|[$a-z]{4,}\d*'
    " adding numbers brackets

    let regex  = '[$a-z]{1,}([-\._\[\][$a-z]+)+|[$a-z]{4,}\d*'
    let words = FindallStrings(text, regex)
    for word in words
        if Test(word, '^(self|this).')
            call add(words, Replace(word, '^(self|this).', ''))
        endif
    endfor
    return words

endfunction

function! WordFzMatcher(words, regex, word)
    let words = a:words
    let regex = a:regex
    let word = a:word

    for r in [word, regex]
        let value = Find(words, {s -> Test(s, '\C^' . r)})
        if Exists(value)
            return value
        endif
    endfor 

endfunction
"ec Test('x', '[x[{}]')

function! RGroup(...)
    return '(' . join(a:000, '|') . ')'
endfunction
"ec WordSpiral('')
"ec AutoTab()
function! VueComponentSnippet(s)
    let s = a:s
    if Test(s, '^h')
        let s = Replace(tag, '^h?a?m?', '')
        let s = 'Ham' . Capitalize(s)
    elseif Test(s, '^aaaa')
        let s = 'asdfasdf'
    endif

    let name = s
    let Ref = Get(g:wpsnippets, 'js', 'ht')
    let tr = '\$(\{.{-}\}|\d+(--[a-z])?|[a-zA-Z]{3,})'
    let snippet = Sub(Ref, tr, {x -> function('Pst')(x, [name], '')})
    let snippet = Replace(snippet, ', \ze\)', '')
    let snippet = Replace(snippet, '\$c', '')
    call append('$', SplitLines(snippet))
    call Cursor('$')
    call AddExport(Pascal(name))
endfunction
function! SimplePySnippet(key)
    let key = a:key
    let [spaces, line, cursor] = GSLC()
    let parts = split(line, ' ')
    let lang = Lang()
    let langkey = Test(lang, 'vue|comp') ? 'js' : lang
    let snippet = ''
    let Ref = Get(g:wpsnippets, langkey, key)
    let r = '\$(\{.{-}\}|\d+(--[a-z])?|[a-zA-Z]{3,})'
    let snippet = Sub(Ref, r, {x -> function('Pst')(x, parts, line)})
    let cursorpos = GetCursorFromStringSnippet(snippet)
    let snippet = Replace(snippet, ', \ze\)', '')
    let snippet = Replace(snippet, '\$c', '')
    call TextPlacement(SplitLines(snippet), spaces)
    call SetCursor(cursorpos, spaces)
    
endfunction
function! DeleteLines2(r, start, end)
    let r = a:r
    let start = IndexGetter2(a:start)
    let end = IndexGetter2(a:end)
    let offset = 0
    let deletions =  []
    for i in range(start, end)
        let line = getline(i)
        if Test(line, r)
            call add(deletions, i - offset)
            let offset += 1
        endif
    endfor

    for d in deletions
        call deletebufline('%', d)
    endfor
endfunction
function! PySnippetActioneer(key, s)
    let key = a:key
    let r = a:s
    if key == 'remove'
        call DeleteLines2(r, 1, '$')
    endif
    
endfunction
" @bookmark 1695932415 PySnippet
function! PySnippet(...) abort
    if Snippeteer()
        return 
    endif
    let s = a:0 >= 1 ? a:1 : CurrentLine()
    let loc = a:0 >= 2 ? a:2 :  '.'
    let [spaces, tag, line, parts] = GetSpacesTagLineAndParts(s)
    if Test(tag, '^!(remove|asd)')
        return PySnippetActioneer(tag[1:], line)
    endif
    let lang = Lang()
    "grab f123k

    if tag == 'grab'
        return WPGrab(line)
    endif

    if Test(tag, '^\.')
        let parts = [tag]
        let line = tag
        let tag = 'css'

    elseif Test(tag, '^\w{3,}(mixins|dict|ref)')
        let parts = [tag]
        let line = tag
        let tag = 'constobj'

    elseif Test(tag, '^svg(\w+)')
        let tag = Match(tag, 'svg\zs\w+')
        let tag = 'SVG' . Capitalize(tag)
        let parts = [tag]
        let line = '' 
        let tag = 'vt'

    elseif Test(tag, '^\CV[A-Z]')
        let parts = [tag]
        let line = tag
        let tag = 'vt'
    elseif Test(tag, '^\CH')
        let s = Replace(tag, '^h?a?m?', '')
        let tag = 'Ham' . Capitalize(s)
        let returnValue = tag
        let parts = [tag]
        let line = tag
        let tag = 'ht'
    elseif Test(lang, 'vue|comp') && Test(tag, '^\C[A-Z]')
        let parts = [tag]
        let line = tag
        let tag = 'vt'
    endif

    if Test(tag, 'mode')
        " wth is this ...
        call DeleteLine()
        return ModeMaster(Replace(tag, 'mode', ''))
    elseif Test(tag, '^\.')
        return LineSetter('HtmlSnippet')
    endif

    let snippet = ''
    let key = Test(lang, 'vue|comp') ? 'js' : lang
    let Ref = Get(g:wpsnippets, key, tag)
    if Test(Ref, '^action:')
        :delete
        call function(SelectCommandViaTextColon(Ref))()
        return 
    endif
    if !Exists(Ref)
        if Test(tag, '^[ie]f[a-zA-Z]')
            return IfParseHandler()
        else
            ec [key, tag, lang]
            throw 'no pysnippet'
        endif
    endif

    let tr = '\$(\{.{-}\}|\d+(--[a-z])?|[a-zA-Z]{3,})'
    if tag == 'pcf'
        let snippet = Ref(line, tag)
        let snippet = Sub(snippet, tr, {x -> function('Pst')(x, parts, line)})
    elseif IsFunction(Ref)
        let snippet = Ref(line)
    elseif Test(Ref, '^[A-Z]\w+$', 'c')
        let snippet = FunctionGetter(Ref)(line)
    else
        let snippet = Sub(Ref, tr, {x -> function('Pst')(x, parts, line)})
    endif

    let cursorpos = GetCursorFromStringSnippet(snippet)
    let snippet = Replace(snippet, ', \ze\)', '')
    let snippet = Replace(snippet, '[$%]c', '')
    if loc == 'bottom'
        ec 'appended bottom'
        call append('$', SplitLines(snippet))
        return returnValue
    endif
    call TextPlacement(SplitLines(snippet), spaces)
    call SetCursor(cursorpos, spaces)
endfunction
function! PySnippet4() abort
    "this is the big papa of w,
    let [spaces, line] = GetSpacesAndLine()
    let [match, snippet, offset] = IterativeMatch2(TrimEnd(line), g:pysnippet4ref, '$0 $B')
    if Test(snippet, '^f:')
        let F = function(snippet[2:])
        return PlaceSnippet(F(match), spaces)
    endif

    let parts = FindallStrings(match, '\w+')
    let line = line[0: offset]
    let Parser89 = {x -> function('PySnippetTemplater2')(x, parts, line)}
    let regex = '\$(\{.{-}\}|\d+|[A-Z])'
    let snippet = Sub(snippet, regex, Parser89)
    call PlaceSnippet(snippet, spaces)

endfunction

function! NewlineIndent(s, key)
    return Parens(Parens('    ' . a:s, 'newline'), a:key)
endfunction
function! AddQuotes(s)
    let s = a:s
    if Test(s, '[/{[]') || IsNumber(s)
        return s
    else
        return SingleQuote(s)
    endif
endfunction
function! StringObject(items)
    let items = a:items
    "let items = [[1,2], [3,4]]
    let f = 'DoubleQuote(v:val[0]) . ": " . AddQuotes(v:val[1])'
    let store = map(items, f)
    return Parens(join(store, ', '), '{}')
endfunction
function! Const(s)
    let prefix = Jspy2(0, 'const')
    return prefix . a:s . ' = '
endfunction
function! CreateObjectArray(s)
   "let s="FontRef font: Long Cang weights: [600]"
    let s = a:s
   let [name,b] = SplitOnce(s) 
   let items = split(b, '\v:\zs | \ze\w+:')
   let items = Paired(items)
   return Const(name) . NewlineIndent(StringObject(items), '[]')
endfunction

function! Parens(s, ...)
    let key = a:0 >= 1 ? a:1 : 'parens'
    let [a,b] = has_key(g:ParensRef, key) ? g:ParensRef[key] : [key, key]
    return a . a:s . b
endfunction

function! XGoFileGoFunctionDep(key)
    let key = a:key
    let lang = GetLang()
    let ref = g:jspyref2[lang]['file-function-ref']
    let [file, fnKey] = ref[key]
    let file = FileGetter2(file)
    call GoToBuffer(file)
    call ExecuteFunctionSearch(fnKey)
endfunction

function! XGoFileGoFunction(key)
    let key = a:key
    let [file, fnKey] = g:filefunctionref[key]
    let file = FileGetter2(file)
    call GoToBuffer(file)
    call ExecuteFunctionSearch(fnKey)
endfunction
"The win conditions of men and women are not perfect overlaps. They are orthogonal. Both sides have power in ways the other side doesnt. I need to print out the guided multiplication and division.
function! SliceLineFromCursor()
    let line = CurrentLine()
    let cursor = GetChar()
    return line[cursor - 1:]
endfunction
function! NDir(m)
    let m = a:m
    let e = GetExtension(m)
    if Test(m, '^/')
        return Head(m)
    endif
    let dict = {'py': g:pydir}
    return get(dict, e, g:dir2023)
endfunction
function! QAppendDirToCursor()
    let s = SliceLineFromCursor()
    let m = Match(s, '\w+(\.\w+)+')
    if Exists(m)
        return NDir(m)
    endif
endfunction
function! DoAnnouncement()
    let name = GetFunctionName()
    return GetFunctionName()
endfunction
function! QRefToday()
    return 'today' . MonthDay() . '()'
endfunction
function! SetLastVimCommand(a, b)
    let a = a:a
    let b = a:b
    let g:lastvimcmd = 'call ' . a . '("' . b . '")'
endfunction

function! VisualAction(s)
    let [key, arg] = ForceSplit(a:s)
    if has_key(g:vueaddtransitiondict, key)
        let indexes = GetIndexesHelper('GetMatchingSpacesIndexes')
        return VueAddTransition(indexes, key)
    endif

    let ref = get(g:visualactiondict, key)
    let Fn = FunctionGetter(ref.fn)
    let indexes = GetIndexesHelper2(get(ref, 'i', 'contiguous'))
    if !Exists(arg)
        let arg = get(ref, 'arg', 0)
    endif

    " @bookmark 1679795657 visualaction
    let mode = get(ref, 'mode', 'none')
    let lines = GetLines(indexes)
    let s = ToString(lines)
    let selection = GetVisualSelection()
    let state = {'selection': selection, 'start': indexes[0], 'end': indexes[1], 'length': len(lines), 'indexes': indexes, 'text': s, 'string': s, 'lines': lines, 'arg': arg, 'indentation': match(lines[0], '\S'), 'mode': mode}

    if has_key(ref, 'kwargs')
        for [k, v] in items(ref.kwargs)
            let state[k] = v
        endfor
    endif

    if has_key(ref, 'delete')
        call DeleteBlock(indexes)
    endif

    if has_key(ref, 'grab')
        call ToPasteBuffer(s)
    endif

    let value = Fn(state)
    if empty(value)
        return 
    endif

    if has_key(ref, 'replace') && IsArray(value)
        call setline(state.start, value)
    endif
    if has_key(ref, 'appendAfter')
        let lines = copy(value)
        for i in range(ref.appendAfter)
            call insert(lines, '')
        endfor
        call append(state.end, Indent(lines, state.indentation))
    endif
endfunction
function! InstallNpm(s)
    let s = a:s 
    let t = DateStamp() . ' npm ' . s
    ec 'running install npm'
    execute "!clear;npm i " . s
    call AppendFile(g:changelogfile, t)
endfunction

function! EvaluateTheLastLine()
    let line = LastLine()
    let line = trim(line)

endfunction
function! LastLine()
    let lineIndex = FindLineIndex('\w', '$', -1)
    let line = getline(lineIndex)
    return line

endfunction

function! EvalLastLine()
    let cmd = RemoveStartingComments(LastLine())
    let evaluation = eval(cmd)
    return evaluation
    "// RemoveStartingComments('//hi')
endfunction
function! FindLineIndex(key, start, dir, ...) abort
    let key = a:key
    let start = a:start
    let dir = a:dir
    let threshold = a:0 >= 1 ? a:1 : 500
    let i = IndexGetter2(start)
    let regex = RegexGetter(key)
    let increment = dir
    let c = 0
    "if Test(getline(i), regex)
        "if dir == -1
            "return i
        "else
            "let i += 1
    "endif
    let max = line('$')

    while c < threshold
        if i > max
            throw ''
        endif
        let c += 1
        let line = getline(i)
        if Test(line, regex)
            return i
        endif
        let i += increment
    endwhile
    throw '-1'
endfunction
function! IndexGetter2(index)
    let index = a:index
    if index == '.' || index == '$' || index == 'w0' || index == 'w$'
        return line(index)
    else
        return index
    endif
endfunction
function! RemoveStartingComments(s)
    return Replace(a:s, '^[''"/#]+', '')
endfunction
function! ShuntAwayFrom()
    let regex = '^\/\/shuntpoint'
    let destination = input('choose destination:  ')
    let index = Search(regex, 'Wbn')
    if index > 0
        call AppendFile(destination, DeleteBlock([index + 1, line('$')]))
    endif
endfunction


"sdf
"inoreab <silent> hk "/home/kdog3682/"<LEFT>
    "call AppendFile('/home/kdog3682/CWF/public/user', DateStamp())
    "AppendVim(Comment(DateStamp()))

function! GetLineIndexes(a, b) abort
    let start = line('.')
    ec start
    let up = FindLineIndex(a:a, start, -1)
    let down = FindLineIndex(a:b, start + 1, 1)

    if up == -1
        throw 'howdy'
    endif

    if down == -1
        let down = FindLineIndex(a:b, up + 1, 1)
    endif
    return [up, down]
endfunction

function! Extracter(key)
    let key = a:key

    let g:textextractref = {
        \'md': {
            \'regexStart': '^#', 
            \'regexEnd': '^#end',
            \'delete': 1,
            \'pasteAsString': 1,
            \'boom': 'true',
            \'open': 'true',
            \'gdoc': 'true',
            \'append': 'true',
            \'class': 'true',
        \}
    \}
    let ref = g:textextractref[key]
    let indexes = GetLineIndexes(ref.regexStart, ref.regexEnd)
    let lines = GetLines(indexes)
    if ref.delete
        call DeleteBlock(indexes)
    endif

    if ref.pasteAsString
        call PasteAsString(lines)
    endif
endfunction
function! PasteAsString(a)
    let s = ToString(a:a)
    let s = CreateVar('s', s)
    ec s
    let @" = s
    return 1
endfunction


    let g:jspyref2['js']['bindingRE'] = '(var|const|class|(async )?function) '
    let g:jspyref2['py']['bindingRE'] = '(def|class) '
function! Quote(s)
    let s = a:s
    if Test(s, "\n")
        return Parens(s, Jspy('big-quote'))
    else
        return Parens(s, '"')
    endif
endfunction

"ec GetLineIndexes('^fu', '^end')
"ec Extracter('md')
function! Lang()
    let aliases = {
        \'javascript': 'js',
        \'': 'js',
        \'python': 'py',
        \'markdown': 'md',
    \}
    let f = &filetype
    return get(aliases, f, f)
endfunction

    let g:langref = {
    \    'vue': 'js',
    \    'js2': 'js',
    \    'json': 'js',
    \    'mhtml': 'js',
    \    'vim': 'vim',
    \    '.vimrc': 'vim',
    \    'html': 'js',
    "\    'html': 'html',
    \    'txt': 'txt',
    \    'py': 'py',
    \    'sh': 'bash',
    \    '.bash_aliases': 'bash',
    \    'bashrc': 'bash',
    \    '.bashrc': 'bash',
    \ }
function! AppendJSEnv()
    let file = Tail(FileGetter2(''))
    let s= "module.exports.activeHtmlFile = " . file
    call AppendFile('env.js', s)
endfunction
function! ExecToc()
    let item = Choose(g:toclist)
    let F = item['f']
    call function(F)()
endfunction

function! MonthDay()
    let date = strftime('%m%d')
    return date
endfunction
function! QString()
    let date = 's' . MonthDay()
    let s = CreateVar(date, GetPasteBuffer())
    call append('.', s)
endfunction
function! GetPasteBuffer()
    return Sub(@", "\n", '')
endfunction
function! Assert(x) abort
    if Exists(a:x)
        return 
    endif
    throw 'assertion error'
endfunction

function! GetLast(items)
    let items = a:items
    return items[-1]
endfunction
function! AppendShuntFile()
    if exists('g:activeShuntFile')
        call AppendFile(g:activeShuntFile, GetLines(GetCodeIndexes()))
    else
        ec ' no activeShuntFile '
    endif
endfunction
function! ToLearning() abort
    let [lines, indexes] = GetBlockLines()
    if Lang() == 'py'
        call DeleteBlock(indexes)
        call add(lines, '')
        call AppendFile(g:pythonarchivefile, lines)
        return 
    endif

    let p = PadLinesWithNameAndDate(lines)
    call AppendFile(g:codelearningfile, p)
    call DeleteBlock(indexes)
endfunction



function! Foxo()
    
endfunction

function! TestPrint2()
    let [name, parameters] = GetFunctionNameAndParameters()
    let params = len(parameters) == 0 ? '' : ToInputArg()
    let statement = Logger(Callable(name, params))
    call append('$', statement)
    call Cursor('$')
endfunction
function! GetFunctionIndex()
    return IndexSearch(g:fnRE2, -1)
endfunction
function! IndexSearch(r, dir) abort
    let flags = a:0 >= 1 ? a:1 : 'nWc'
    if a:dir < 0
        let flags .= 'b'
    endif
    let r = Regexed(a:r)
    if Test(getline('.'), r)
        return line('.')
    endif
    let index = search(r, flags)
    if index < 1
        throw ''
    endif
    return index
endfunction

function! SaveAll()
    for file in GetCurrentBuffers()
        let dest = NormalizePath(g:budir, file)
        let dest .= DateStamp()
        ec dest
    endfor
endfunction
"let g:userdict['wamiwo'] = 'what am i working on today'
"inoreab <silent>  ()<LEFT><C-R>=Eatchar('\s')<CR>
"inoreab wde new WebDesignElement()<LEFT><C-R>=Eatchar('\s')<CR>
"inoreab tae this.activeElement<C-R>=Eatchar('\s')<CR>
 
function! IsPdf(f)
    let f = a:f
    return GetExtension(f) == 'pdf'
endfunction


function! CommentIt(s)
    let s = a:s
    if Test(s, '^[#"/]')
        return s
    else
        return Jspy('commentPrefix') . s
    endif
endfunction
function! ShuntNewFile(s)
    let [a,b] = SplitOnce(a:s)
    let end = line('$')
    let start = FindLineIndex(q, end, -1, 1000)
    let lines = DeleteBetween(start, end)
    call AppendFile(FileGetter2(b), lines)
endfunction

function! GrabBetween(start, end, r, ...)
    let start = a:start
    let end = a:end
    let r = a:r
    let r2 = a:0 >= 1 ? a:1 : ''
    let r3 = a:0 >= 2 ? a:2 : ''
    let offset = 0

    let store = []
    let save = []
    let deletions = []
    let go1 = len(r2) > 0

    for i in range(start, end)
        let line = getline(i)
        if Test(line, r)
            if !empty(r3) && Test(line, r3)
                continue
            endif
            call add(deletions, i - offset)
            call add(store, line)
            let offset += 1
        elseif go1 && Test(line, r2)
            call add(deletions, i - offset)
            call add(save, line)
            let offset += 1
        endif
    endfor
    for d in deletions
        call deletebufline('%', d)
    endfor
    return go1 ? [store, save] : store
endfunction

function! DeleteBetween(start, end)
    let start = a:start
    let end = a:end
    let store = []
    let offset = 0
    let deletions = []
    for i in range(start, end)
        let line = getline(i)
        if Test(line, '^([#/"]|[a-z]+(\.[a-z]+)*\()')
            call add(deletions, i - offset)
            call add(store, line)
            let offset += 1
        endif
    endfor
    for d in deletions
        call deletebufline('%', d)
    endfor
    return store
endfunction
function! TimestampString(...)
    let prefix = a:0 >= 1 ? a:1 : ''
    let date = 'str' . strftime('%s')
    return prefix . date
endfunction

function! DateString(s)
    let date = 'str' . MonthDay()
    return a:s . date
endfunction
"sdf123 = `sdfsdf
function! GoLastWord()
    let word = expand("<cword>")
    let s = '^(var|function|const|let|class|def) ' . word
    let index = FindLineIndex(s, '.', -1)
    if index > -1
        call Cursor(index + 3)
    endif
endfunction

"/**
function! GoLastBookmark()
    let r = '\/\*\*'
    let index = FindLineIndex(r, line('.') - 5, -1)
    if index > -1
        call Cursor(index)
    endif
endfunction

function! GoLastString()
    let index = FindLineIndex('^"?\w+ *\= *`', '.', -1)
    if index > -1
        call Cursor(index + 3)
    endif
endfunction

function! GetLastVariable()
    let index = FindLineIndex('^(var |const )?\w+ *\= *[\{\[]', '.', -1)
    let line = getline(index)
    return Test(line, '^(var |const)') ? GetSecondWord(line) : GetFirstWord(line)
endfunction


function! GetAnyLastString()
    let index = FindLineIndex('^(var |const )?\w+ *\= *`', '.', -1)
    let line = getline(index)
    return Test(line, '^(var |const)') ? GetSecondWord(line) : GetFirstWord(line)
endfunction

function! GetLastFunction2()
    let index = FindLineIndex('^"?(async |function )', '.', -1)
    let line = getline(index)
    return GetBindingName(line)
endfunction

function! GetLastString()
    let index = FindLineIndex('^"?(let |const )?\w+ *\= *`', '.', -1)
    let line = getline(index)
    return GetFirstWord(Replace(line, 'let|const|var', ''))
endfunction
function! QGNormal()
    ec "qg-normal:\n\n"
    let word = input('')
    return function(g:qgnormalref[word])()
endfunction
"nnoremap 6 :call QGNormal()<CR>

"inoremap wami where am i:
"inoremap wamo what am i working on:
"inoremap wdid what am i doing:
function! FindUpDownIndexes(a, b, ...)
    let a = a:a
    let b = a:b
    let t = a:0 >= 1 ? a:1 : 500
    let up = FindLineIndex(a, '.', -1, t)
    let down = FindLineIndex(b, '.', 1, t)
    return [up, down]
endfunction
function! Parser233Array(lines, regex, replacement)
    let lines = a:lines
    let regex = a:regex
    let replacement = a:replacement

    return map(copy(lines), 'Parser233(v:val, regex, replacement)')

endfunction
function! VisualBlockTemplater(state)
    let state = a:state
    let lines = state.lines
    let [key, items] = SplitOnce(split(state.arg, '\v +'))

    let results = map(items, 'Parser233Array(lines, key, v:val)')
    call append(1 + state.end, Flat(results))

    " asdf
    " asdf

    " bsdf
    " bsdf
    " csdf
    " csdf
    " dsdf
    " dsdf
    " esdf
    " esdf
    ec results
    return 
    
endfunction
function! VisualTemplate(state)
    let state = a:state
    let lines = state.lines
    let spaces = GetSpaces(lines[0])
    let lines = map(state.lines, 'trim(v:val)')
    let lines = map(lines, 'spaces . RegistrarTemplater(state.arg, v:val)')
    call setline(state.start, lines)
    
endfunction
function! VisualMakeArray(i)
    let i = a:i
    let s = [
    \]
    let lines = GetLines(i)
    let items = map(lines, 'Match(v:val, ''\w+'')')
    let items = Unique(filter(items, 'len(v:val) > 3'))
    let s = Indent(ToStringArray('temp', items))
    call ToPasteBuffer(s)
endfunction
function! WriteCodeNotes(s) 
    let s = a:s
    if s == ''
        let s = ['----------------------------------', '[' . Tail() . ' ' . DateStamp() . ' ' . GetFunctionName() . ']', ]
        call _WriteFile(g:learningfile, ToArray2(s), 'a')
    else
        let [indexes, lines] = GetCodeIndexesAndLines()
        let lines = PadLinesWithNameAndDate(lines, s)
        call _WriteFile(g:learningfile, lines, 'a')
    endif
endfunction

function! PadLinesWithNameAndDate(s, ...)
    let s = ToArray2(a:s)
    call insert(s, '[' . Tail() . ' ' . DateStamp() . ']:')
    let extra = a:0 >= 1 ? a:1 : ''
    if Exists(extra)
        call add(s, '')
        call add(s, extra)
    endif
    call add(s, '----------------------------------')
    return s
endfunction
function! GetSetReplaceCurrentLine(a, b)
    let a = a:a
    let b = a:b
    call GetSet('.', {s -> Test(s, a) ? Replace(s, a, b) : Replace(s, b, RemoveRegexStuff(a))})
endfunction
function! RemoveRegexStuff(s)
    let s = a:s
    return Replace(s, '\+$', '')
endfunction
function! ConsoleToClip()
    call GetSetReplaceCurrentLine('console.log+', 'clip')
endfunction
function! LogFile() 
    let file = CurrentFile()
    call AddFile(Prompt('File Abrev?'))
    call AppendFile(g:logfile, DateStamp() . ' ' . file)
    ec 'success @ myFiles.log' . file
endfunction
" GoldBar
function! GetFunctionFromCallableOrParent()
    let line = getline('.')
    if Test('^\S', line)
        let a = FindallStrings(line, '\w+\ze\(')
        return Find(a, {s -> !Test(s, 'log')})
    else
        return GetFunctionName()
    endif
endfunction
function! WriteNotes3(s)
    let s = a:s
    let e = Lang()

    if s == ';'
        let s = 'done ' . GetFunctionFromCallableOrParent()
        ec s
    elseif s == 'go'
        return OpenBuffer(g:notefile)
    elseif s == ''
        if e == 'js'
            let s = Dreplace('"file" name', CurrentInfo())
        else
            let s = CurrentLine()
            ec 'copying current line because s=""'
        endif
    elseif e == 'js' || e == 'py'
        let name = GetBindingName()
        let firstWord = GetFirstWord(s)
        if firstWord == Abrev(name)
            let s = Sub(s, Boundary(firstWord), name)
            let s = RegistrarTemplater('"$1" $2', [CurrentFile(), s])
        elseif Test(s, '^\$')
            let s = Sub(s, '\$', name)
            let s = RegistrarTemplater('"$1" $2', [CurrentFile(), s])
        endif
    endif
    call AppendNotes(s)
endfunction
function! Qx()
    "execute "/sdasd'"
    "exec'sfsdf'ute "/'"
    " "/'"
endfunction
function! MathArchive()
    let i = [1, line('$')]
    let lines = DeleteBlock(i)
    call _WriteFile(g:txtdir . 'math.archive.txt', lines, 'a')
    call append('.', ['title = ', 'key = '])
endfunction
function! Qp() abort
    let col = getpos('.')[2]
    let forward = col
    let s = getline('.')
    while 1
        let forward += 1
        if forward > 50 
            throw 'error'
        endif
        let ch = s[forward]
        if ch == ''
            ec 'early return'
            return 
        endif

        if ch == "\\" || ch == ' ' || ch == '/'
            ec [ch, forward, 'hii']
            break
        endif
    endwhile
    let [a,b,c] = [s[0:col-2], s[col-1:forward - 1], s[forward:]]
    let payload = a . Parens(b) . c
    call setline('.', payload)
endfunction
function! ToStringArrayLong(name, items)
    let items = map(a:items, 'Indent(DoubleQuote(trim(v:val)) . ",")')
    call insert(items, GetPrefix() . a:name . ' = ' . '[', 0)
    call add(items, ']')
    return items
    ec Join(items)
endfunction
function! VisualMakeArray2(i)
    let i = a:i
    let lines = GetLines(i)
    let items = ToStringArrayLong('temp', lines)
    call DeleteBlock(i)
    call append(i[0] - 1, items)

endfunction
function! VisualCopyBlock(state)
    let state = a:state
    let lines = WrapLines(state.lines)
    call append(state.start - 1, lines)
endfunction
function! VisualMakeObject(state)
    let state = a:state
    let r = '^ *"?(var|(async )?function!?|def|class|const|let) \zs\w+|^\w+ \= \{ *$'
    let words = filter(map(state.lines, 'Match(v:val, r)'), 'Exists(v:val)')

    let lines = ['return {']

    for word in words
        call add(lines, '    ' . SingleQuote(word) . ': ' . word . ',')
        "call add(lines, '    ' . word . ',')
    endfor

    call add(lines, '}')
    return lines

    "const abc sdf
    "let abc sdf
    "abc sdf
    "abc sdf

endfunction
"let g:visualactiondict['list'] = {'fn': 'VisualMakeArray2', 'i': 'contiguous'}
"let g:visualactiondict['le'] = {'fn': 'VisualLearning', 'i': 'trycatch', 'arg': ''}
"let g:visualactiondict['s'] = {'fn': 'VisualLearning', 'i': 'trycatch', 'arg': ''}


function! VisualTransferToGoogleDoc(state)
    let state = a:state
    call DeleteBlock(state.indexes)
    let template = 'googleAppScript("""Finish(foobarta(`$1`))""")'
    let cmd = RegistrarTemplater(template, [state.string])
    return Python2('execPython', cmd)

endfunction
function! SetLastTouchedFile(...)
    let file = a:0 >= 1 ? a:1 : CurrentFile()
    let g:lasttouchedfile = file
    return 1
endfunction
function! GoLastTouchedFile()
    if !exists('g:lasttouchedfile')
        ec 'no last touched file: early return'
        return 
    endif
    ec 'going to last touched file'
    call OpenBuffer3(g:lasttouchedfile)
endfunction


function! VisualTransfer(state)
    let state = a:state
    call insert(state.lines, '', 0)
    call insert(state.lines, DateStamp(), 0)
    call AppendFile(state.arg, state.lines)
    let g:lasttouchedfile = state.arg
endfunction

function! VisualLearning(state)
    let state = a:state
    call insert(state.lines, '', 0)
    call insert(state.lines, DateStamp(), 0)
    call AppendFile(state.arg, state.lines)
    let g:lasttouchedfile = state.arg
endfunction
function! VisualWrap(state)
    let state = a:state

    let arg = Jspy(state.arg)
    let startingLength = state.length
    let lines = state.lines
    let spaces = GetIndent(lines[0])
    let lines = Indent(lines)
    let above = Indent(copy(get(arg, 'above', [])), spaces)
    let below = Indent(copy(get(arg, 'below', [])), spaces)
    let payload = above
    call extend(payload, lines)
    call extend(payload, below)

    let n = state.start
    for i in range(startingLength)
        call setline(n + i, payload[i])
    endfor
    call append(n + startingLength - 1, payload[startingLength:])
    call Cursor(n + len(payload) - 2)

endfunction
function! VisualTransferToPython(state)
    let state = a:state
    let s = ShellEscape(state.string)
    call Python2(state.arg, s)
    " The way it works is that Python2 will talk to python() over at run.py. The state.arg will be the functionKey. S will be the arg as an escaped string.
endfunction

function! VisualTransferToJS(state)
    let state = a:state
    let s = ShellEscape(state.string)
    call JavascriptAppController('visualPreview', state.arg, s)
endfunction

function! IsJP(s)
    let e = GetExtension(a:s)
    return e == 'js' || e == 'py'
endfunction
function! RunPrevFile()
    let shellString = Jspy('executeShellTemplate')
    let prevFile = bufname('#')
    let cmd = shellString . prevFile
    ec cmd
    if !IsJP(prevFile)
        ec ' no run'
        return 
    endif
    execute cmd
endfunction

function! GoRight(n)
    let n = type(a:n) == 0 ? a:n : len(a:n)
    return repeat("\<RIGHT>", a:n)
endfunction

function! Sdiiiif()
    ec GoLeft('hi')
    ec GoLeft('1111')
    ec GoLeft(11)
endfunction

function! GoLeft(n)
    let n = type(a:n) ==? 0 ? a:n : len(a:n)
    return repeat("\<LEFT>", n)
endfunction

function! RegisterEat() abort
    let word = GetCurrentWord()
    let args = []
    let arg1 = ''
    let arg2 = ''
    let s = trim(getline('.'))
    let length = len(Match(s, '[''"\)]*$'))
    let arg1 = Prompt(arg2, 'abrev? type 1 for functional')
    let arg2 = s . GoLeft(length)
    if arg1 == 1
        if !Test(s, '<' . word . '\(')
            let word = Match(s, '\w+\ze\(')
        endif
        let arg1 = Abrev(word)
        let arg2 = word . '()' . GoLeft(1)
    endif

    if IsVim()
        let arg1 = '<buffer> ' . arg1
    endif
    let template = "inoreab $1 $2<C-R>=Eatchar('\\s')<CR>"
    let cmd = RegistrarTemplater(template, [arg1, arg2])
    ec cmd
    call AppendAndExecute(cmd)
    return 

    ec length
    return length
    if Test(s, '<' . word . '\(')
        let t = Match(s, word . '\(.{-}\)')
        let t = Sub(t, '[0-9a-zA-Z]', '')
        let arg2 = word . t
    "sdxfsdf(sdfsgdf('sxgdfsdf'))
        let arg2 .= GoLeft(len(t) / 2)
        let arg1 = Abrev(word)
    elseif !Test(s, '\=')
        ec 'hi'
        let t = FindallStrings(s, '\w+\ze\(')
        ec t
        let word = GetLast(t)
        let t = Match(s, word . '\(.{-}\)')
        let removed = Sub(t, '[\(0-9a-zA-Z]', '')
        let t = Sub(t, '[0-9a-zA-Z]', '')
        let arg2 = word
        let length = len(removed)
        let arg2 .= t . GoLeft(length)
        let arg1 = Prompt(arg2, 'abrev?')
        if !Exists(arg1)
            lert arg1 = Abrev(word)
        endif
    else
        let arg2 = trim(s)
        let arg1 = Match(arg2, '\w+\ze *\=')
        if !Exists(arg1)
            let arg1 = Prompt(arg2, 'arg1?')
        endif
    endif
    
    if IsVim()
        let arg1 = '<buffer> ' . arg1
    endif
    let template = "inoreab $1 $2<C-R>=Eatchar('\\s')<CR>"
    let cmd = RegistrarTemplater(template, [arg1, arg2])
    ec cmd
    return 
    call AppendAndExecute(cmd)
endfunction

"let bas_as_ts = 'sdf'
"nnoremap qgx :call QGetFar('')<LEFT><LEFT>

function! QGetFar()
    let s = input('search for text from above:')
    "let s = 'bat'
    let r1 = s . '\S{3,}'
    let r2 = ExpandPythonRegex2(s)
    "return r2
    let r = r1 . '|' . r2
    let index = search('\v\C' . r, 'bn')
    let match = Match(getline(index), r)
    return match
endfunction

function! GrabFunctionFromMaster() abort
    let f = g:jsondir . 'master.json'
    if !exists('g:data')
        let g:data = ReadJson(f)
        ec 'getting g:data'
    endif

    let word = GetCurrentWord()
    let s = get(g:data, word)
    if !Exists(s)
        ec 'g:data doesnt have ' . word
        return 
    endif
    let word = GetCurrentWord()
    let item = WrapLines(ToLines(s))
    call append('^', item)

endfunction
function! CheckIfIsFile(s)
    let s = a:s
    let b = NormFileToDir(s)
    if IsFile(s)
        return s . ' is a file'
    elseif IsFile(b)
        return b . ' is a file'
    endif
endfunction
function! FPGCB()
    return map(GetCurrentBuffers(), 'FullPath(v:val)')
endfunction
"inoremap <c-b>
"inoremap <expr> <c-i> CtrlB('*', '*', 'italic', 1)
"inoremap <expr> <c-n> CtrlB('', '<CR>', 'newline', 0)
" a nice development this is.
function! CtrlB(a, b, key, length)
    let a = a:a
    let b = a:b
    let key = a:key
    let length = a:length
    let g:controller[key] += 1
    if IsEven(g:controller[key])
        return Right(length) . ' '
    else
        return a . b . GoLeft(length)
    endif
endfunction

function! IsCsv(s)
    return Test(a:s, 'csv$')
endfunction
"let g:filedict["ij"] = "/home/kdog3682/JAVASCRIPT/index.mjs"
"let g:filedict["ut"] = "/home/kdog3682/JAVASCRIPT/utils.mjs"
function! IncrementFile() abort
    throw 'no'
    return OpenBuf(ChangeFileDir())
endfunction
function! ExploreResources()
    execute "Explore " . g:resourcedir
endfunction

function! Explorer(dir)
    execute "Explore " . a:dir
endfunction


function! OpenBuffer2(name)
    let name = a:name
    if IsFile(name)
        let cmd = bufexists(name) ? 'buffer!' : 'edit'
        let cmd = Join(cmd, name)
        execute cmd
    endif
endfunction

function! OpenBuf(name)
    let name = a:name

    if !IsFile(name)
        ec 'not a file: ' . name
        return 
    endif

    let command = bufexists(name) ? 'buffer!' : 'edit'
    let cmd = Join(command, name)
    ec cmd
    execute cmd
endfunction
function! HeadAndTail(...)
    " test: /mnt/chromeos/GoogleDrive/MyDrive/BACKUP/vim.json
    if a:0 >= 1
        let s = a:1
        let start = Match(s, '^/')
        let parts = split(s, '/')
        let name = remove(parts, -1)
        let head = start . join(parts, '/') . '/'
        let e = Match(name, '\.\zs\w+$')
        return [head, name, e]
    else
        let tail = expand('%:t')
        let head = expand('%:p:h') . '/'
        let e = expand('%:e') . '/'
        return [head, tail, e]
    endif
endfunction

function! GetSecondWord(s)
    return Match(a:s, '\w+ \zs\w+')
endfunction
function! ChangeFileDir()
    let [d, file] = HeadAndTail()
    let js = GetExtension(file) == 'js'
    let dir = js ? g:javascriptdir : g:pythondir
    let otherdir = js ? g:pubdir : g:cwfdir
    if d == dir
        return otherdir . file
        return 
    else
        return dir . file
    endif
endfunction


"if len('s')
    "ec 'hi'
"endif
function! VueMain()
    ec 'dfsfd'
        ec 'hi'
    
endfunction
function! PutLineSomewhereElse()
    let line = DeleteLine()
    let r = '^function VueMain'
    let upIndex = FindLineIndex(r, '.', -1, 1000)
    call append(upIndex, Indent(trim(line)))
endfunction
function! Markline()
    let s = CurrentLine()
    let index = line('.')
    let r = '^\) {'
    let upIndex = FindLineIndex(r, '.', -1, 100)
    let s = getline(upIndex)
    lete fn = 
    let marker = C
    call Append(marker)
    let payload = "call add(g:markers, )
    call AppendAndExecute(payload)
endfunction
function! ViewMarkedLines()
    ec g:markers
endfunction
function! ToggleComment999()

    let lang = GetLang2()
    let [spaces, s] = GetSpacesAndLine()
    let payload = ''

    if lang == 'css'
        if Test(s, '^/\*')
            let payload = s[3:-3]
        else
            let payload = '/* ' . s . ' */'
        endif
        return setline('.', spaces . payload)
    elseif lang == 'html'
        let start = Match(s, '\S\S')
        if start == '//'
            return TemplarSlice(3)
        elseif start == '<!'
            return TemplarSlice('<!-- ', ' -->')
        elseif start[0] == '<'
            return Templar('<!-- $0 -->')
        elseif len(start) > 0
            return Templar('// $0')
        endif
    else
        return GetSetFn('AddOrRemoveComment')
    endif
endfunction

function! AddOrRemoveComment(s)
    let s = a:s
    let com = Jspy('startingComment')
    let comre = Rescape(trim(com)) . ' *'
    if Test(s, '^ *' . comre)
        return Replace(s, comre, '')
    else
        return Replace(s, '\ze\S', com)
    endif
endfunction
function! AppendVuetifyComponent()
    let name = GetBindingName()
    let s = 'vuetify2(' . name . ')'
    call AppendBottom(s)
endfunction

function! GetCurrentWord2()
    
    let regex = '[a-z0-9\._-]+'
    let s = getline('.')
    let start = GetCursor()
    let A = start - 1
    let B = start + 1

    let ch = 0
    let c = 0
    while c < 30
        let c += 1
        let ch = s[A]
        if Test(ch, regex)
            let A -= 1
        else
            break
        endif
    endwhile

    let c = 0
    while c < 30
        let c += 1
        let ch = s[B]

        if Test(ch, regex)
            let B += 1
        else
            break
        endif
    endwhile

    let value = s[A + 1:B-1]
    return trim(value)
    return [value]
endfunction
function! WordGo()
    let word = GetCurrentWord2()
    let line = CurrentLine()
    let regex = word . '\('
    if Test(line, regex)
        return ExecuteRegex(regex)
    endif
    let regex = word . '\('
endfunction
function! QGNormalGoToS(s)
    "let r = '^(\w+ )?\w+ *\= *["`'']'
    "call ExecuteRegex2(r, 1, 1)
    "normal ?\v^\w<CR>
endfunction
"nnoremap 6s ?\v^(\w+ )\?\w+ *\= *['"`]<CR>
function! GetSeason()
    return 'december'
endfunction

function! IsVWord(s)
    return 1
    return Test(a:s, '^v')
endfunction

function! VuePascal(s)
    let s = a:s
    let words = split(s, '-')
    if len(words) == 1
        return Capitalize(s)
    else
        let words[0] = toupper(words[0])
        return join(map(words, 'Capitalize(v:val)'), '')
    endif
endfunction
function! GoSomewhere()
    let word = GetCurrentWord2()
    if IsVWord(word)
        call AppendBottom(VuePascal(word), 1)
        call PySnippet()
    endif
endfunction

function! GetGValue(key)
    return get(g:globalState, a:key, 0) == 1
endfunction
function! SetGFile(f)
    ec 'hi'
    return 'no'
    let f = a:f
    if GetExtension(f) == 'py'
        call SaveBackup0104()
    elseif GetExtension(f) == 'js'
        "let g:globalState['file'] = f
        "ec 'setting g:globalState.file: ' . f
        "let g:filepickerdict['g'] = f
    else
        "let g:globalState['file'] = 0
        "ec 'unset g:globalState.file'
    endif
endfunction
function! SetGValue(s)
    let key = a:s

    if GetGValue(key)
        let g:globalState[key] = 0
    else
        let g:globalState[key] = 1
    endif
    ec 'Setting Current Value of g:globalState[' . key . '] as ' . g:globalState[key]
    return g:globalState[key]

    if exists('g:' . s) && Exists(eval('g:' . s))
        execute "let g:" . s . " = 0"
    else
        execute "let g:" . s . " = 1"
    endif
    let value = eval('g:' . s)
    ec 'Setting Current Value of: ' . 'g:' . s . ' as ' . value
    return value
endfunction
"Committing a file ... and tracking dependencies.
"You will have to run the file thru a server.
function! DeleteAndGo(...)
    let path = a:0 >= 1 ? a:1 : bufname('#')
    if NoHead(path)
        let path = g:dir2023 . path
    endif
    let [a,b] = GetCodeIndexes()
    let lines = GetLines([a,b])
    "let lines = DeleteBlock([a,b])
    call insert(lines, '', 0)
    call ChooseBuffer2(path)
    call append('$', lines)
    call Cursor('$')
endfunction
function! BackupName()
    let cwf = "/mnt/chromeos/GoogleDrive/MyDrive/BACKUP/"
    let name = Replace(Tail(), '^\.', '')
    let date = DateStamp()
    let outpath = cwf . name . date
    return outpath
endfunction
function! DeprecateFile()
    let outpath = BackupName()
    call writefile(getline(1,'$'), outpath)
    call Changelog('deprecated-file', Tail())
    ec 'The Current File has been deprecated to GoogleDrive/Backup'
    "call setline()
    normal ggVGd
endfunction

function! SaveBackup0104()
    call CopyFile(CurrentFile(), BackupName())
endfunction
function! GetFiles2(dir, ...)
   let query = a:0 >= 1 ? a:1 : '*'
   let s = globpath(a:dir, query)
   return split(s, "\n")
endfunction

function! NBackslash(s)
    let [s, flags] = MGet(a:s, '^: *')
    let dir = '/home/kdog3682/2023/'
    let files = GetFiles2(dir, '*js')
    let files = map(files, 'Tail(v:val)')
    let g = "ToAbrev(v:val[0:-4]) == " . Quotify(s)
    let m = filter(copy(files), g)
    if !Exists(m)
        let g = "Test(v:val, " . Quotify('^' . s) . ")"
        let m = filter(files, g)
    endif
    if Exists(m)
        return dir . m[0]
    else
    endif
endfunction
function! DirSwap()
    let dir = g:cdir
    if g:cdir == g:pydir
        let g:cdir = g:jsdir
    else
        let g:cdir = g:pydir
    endif
    return g:cdir
endfunction

function! ChangeDir(...)
    let dirs = {
        \'pub': g:pubdir,
        \'cwf': g:cwfdir,
    \}
    let path = a:0 >= 1 ? get(dirs, a:1, a:1) : DirSwap()
    ec path
    execute "cd " . path
    return 
endfunction


unlet maplocalleader
function! NoHead(s)
    return Test(a:s, '^\w+\.\w+$')
endfunction

function! AddWordToJavascriptImports()
    let file = Tail()
    if file == 'utils.js'
        let index = FindLineIndex('^export \{', '0', 1, 1000)
        if index < 5
            ec 'error'
            return 
        endif
        let word = GetBindingName()
        call append(index + 1, '    ' . word . ',') 
    else
        let word = GetCurrentWord2()
        let word = Match(word, '[a-z]\w+')
        let file = 'utils.js'
        call AddImport(word, file)
    endif
endfunction
function! AppendBottomTemplater()
    let tail = Tail()
    if line('.') == line('$') && tail == 'base.py'
        let s = CurrentLine()
        call setline('.', '')
        call AppendFile('pac.txt', ['', s])
        return 
    endif
    let name = GetBindingName()
    let template = Jspy('appendBottomTemplate', tail)
    let payload = RegistrarDollarTemplater(template, [name])
    call append('$', payload)
endfunction

"nnoremap 7 C
function! Bop1(a, b)
    let a = a:a
    let b = a:b
    if Exists(a)
        return a
    endif
    return b
endfunction
"nnoremap C :call OpenBuffer('/home/kdog3682/CWF/public/class.js')<CR>
function! JSFileRunner(key, ...)
    let file = CurrentFile()
    return Node('/home/kdog3682/2023/App.js', a:key, file, join(a:000, ' '))
endfunction
function! PrintAndExecute(...) abort
    let s = call(function('printf'), a:000)
    ec s
    execute s
endfunction
function! Black()
    let length = g:vimmaxlength 
    let file = CurrentFile()
    return PrintAndExecute('!black -l %s %s', length, file)
endfunction
function! Prettier()
    if IsPy()
        return PythonController('Black')
        call Python3('app-black)
    else
        call JSFileRunner('pretty')
        return 
        call JSFileRunner('pretty')
        call JSFileRunner('pretty')
        call JSFileRunner('pretty')
        call JSFileRunner('pretty')
        " this is pretty useful
    endif
endfunction

function! LoadLibrary(...)
    let defaultFile = '/home/kdog3682/2023/javascript.master.json'
    let file = a:0 >= 1 ? a:1 : defaultFile
    if exists("g:jslib2")
        return g:jslib2
    endif

    if exists("g:jslib")
        ec 'hi'
        return g:jslib
    endif

    ec 'loading library file: ' . file
    let value = ReadJson(file)
    let lang = Lang()

    if Not(value)
        return 
    elseif lang == 'js' 
        if file == defaultFile
            let g:jslib = value
        else
            let g:jslib2 = value
        endif
    elseif lang == 'css' 
        let g:csslib = value
    elseif lang == 'py' 
        let g:pylib = value
    elseif lang == 'html' 
        let g:htmllib = value
    elseif lang == 'vim' 
        let g:vimlib = value
    endif

    return value

endfunction

function! DeepJoin(items)
    let items = Flat(a:items)
    return join(items, "\n")
endfunction
function! RunOtherJSFile(...)
    let file = a:0 >= 1 ? a:1 : Tail()
    ec 'hiii'
    ec 'running other file ' . file
    let file = '/home/kdog3682/2023/' . file
    call Node(file)
endfunction
function! FilePicker(...)
    let dir = a:0 >= 1 ? a:1 : '/home/kdog3682/2023/'
    let files = GetFiles2(dir, '*')
    let display = map(files, 'Tail(v:val)')
    let file = Choose(display)
    let outpath = dir . file
    if IsFile(outpath)
        call OpenBuffer2(outpath)
    else
        ec 'not a file'
    endif
endfunction
function! GetItem()
    let word = GetCurrentWord2()
    let lib = LoadLibrary()
    let item = get(lib, word, 1)
    if item
        ec 'nope'
        return 
    endif
    let lines = WrapLines(ToLines(item))
    call append('$', lines)
    "test
endfunction
function! RunGFile()
    let file = get(g:globalState, 'eval_file', bufname('#'))
    let e = GetExtension(file)
    if e == 'js'
        call Node(file)
    elseif e == 'py'
        call Shell('python3', file)
    else
        let g:globalState['file'] = ''
        ec 'only js:gfile ... DENIED: ' . file
    endif
endfunction
function! LogIt(...)
    let options = a:0 >= 1 ? a:1 : 0
    let line = CurrentLine()

    if Test(line, 'print|console')
        let spaces = GetSpaces(line)
        let match = Match(line, '\(\zs.{-}\ze\)$')
        let prefix = 'value = '
        call setline('.', spaces . prefix . match)
        return 
    endif
    let match = Match(line, '(\w+|\[.{-}\]|\{.{-}\})\ze ?\+?\=|return \zs\w+')
    if !Exists(match)
        let match = trim(line)
    endif
    let value = Logger(match)
    "ec match
    "ec value
    if Exists(options)
        if options == 'tl'
            let value .= '; throw "";'
        elseif options == 'lh'
            let value = 'console.log("HII")'

        elseif options == 'le'
            let value = 'console.log(exciting())'
        elseif options == 'lt'
            let value = 'console.log({"item":' . match . ', "type": typeof ' . match . '})'

        elseif options == 'lj'
            let value = Templater('console.log({$0})', [match])
        elseif options == 'lr'
            let value = Templater('return console.log($0)', [match])

        elseif options == 'lg'
            let line = CurrentLine()
            if Test(line, 'function|def')
                let match = join(GetParameters(line), ', ')
                "function foo (asdf, asdf, ccc)
            endif
            let match = Sub(match, '^[\{\[]|[\]\}]$', '')
            let value = Templater('console.log({$0})', [match])

        elseif options == 'lo'
            "let a = GetBindingName()
            "let b = match
            "let value = Templater('pairlog("[$0, $1]", $1)', [a,b])
            let value = Templater('console.log({$0})', [match])
            
            "let value = 'display({' . match . '})'

        elseif options == 'ld'
            let line = trim(line)
            let value = 'display(' . DoubleQuote(line) . ', ' . line . ')'

        elseif options == 'll'
            let value = Logger(DoubleQuote(trim(line)) . ', ' . CurrentIndex())
        elseif options == 'l0'
            let value = Logger('{' . join(GetBindings(line), ', ') . '}')

        elseif options == 'lf'
            let s = '{name: "$0", line: $1}'
            let s = Templater(s, [GetFunctionName(), CurrentIndex()])
            let value = Logger(s)
        elseif options == 'lp'
            let s = '{lp: "lp", value: $0, line: $1}'
            let s = Templater(s, [match, CurrentIndex()])
            let value = Logger(s)
            "let value = Logger(s) . Comment('lp')

        elseif options == 'hi'
            let value = Logger('hi')
        elseif options == 'lp'
            let value .= '; ' . Comment('lp')
        endif
    endif
    call Append(value)
endfunction


function! InputChar() abort
    let alphabet = 'abcdefghijklmnopqrstuvwxyz'
    let char = getchar()
    if char == 27
        throw 'escape cancel'
    elseif char >= 97
        return alphabet[char - 97]
    elseif char >= 65
        return toupper(alphabet[char - 65])
    elseif char >= 48
        return char - 48
    endif
endfunction
function! IsJS(f)
    let f = a:f
    return GetExtension(f) == 'js'
endfunction
"let g:globalState['file'] = 'OX3HTML.js'
function! NormPath(a, b)
    let a = a:a
    let b = a:b
    return Replace(a, '/$', '') . '/' . Tail(b)
endfunction

"let g:filedict["c3"] = "/home/kdog3682/CWF/public/class3.js"

function! GetLorem(s) abort
    return g:loremdict[a:s]
endfunction
"call add(g:server_html_commands, 'foo')
function! JSGoogleConnector(s)
    let s = a:s
    let file = '/home/kdog3682/2023/googleAppConnector.js'
    call Node(file, s)
endfunction

function! Whereami2()
    let regex = '^(const|(async )?function[!*]?|class|def|var) \zs\w+'
    let file = CurrentFile()
    if file == g:juneJson
        let r = '"file":'
        return ExecuteRegex2(r, 1)
    endif
    let value = SprawlMatch(regex)
    if Exists(value)
        let g:currentLocation = value
        ec 'LOCATION: ' . value
        return value
    endif
endfunction
"constants.vim
"let g:pydict["kay"] = "{\n    component: 'v-math'\n    prop,\n},"
function! GetSprawlRE(name)
    let name = a:name
    return '\v^(main\(|function[!*]?|async|var|def|class|const) ' . name . '|^let g:\w|^\w+ \= [\{\[] *$|^\w+(\(|\.\w+\.)' . '|^let \w+ *\= *`'
endfunction

function! GetCodeIndexes(...) abort
    let name = a:0 == 1 ? a:1 : ''
    let name = ''
    let startIndex = '.'
    let a = ''
    if IsNumber(name) && 'a' == 'b'
        throw 'hhhhhhhhhhhh'
    elseif name == 'current-to-end'
        return [line('.'), line('$')]
    else
        let r = GetSprawlRE(name)
        let a = SprawlIndex(r)
        " ec [a, r]
    endif

    let lang = GetLang()
    let aline=getline(a)
    "ec aline
    let b = 0
    if lang == 'py'
        "let save
        call cursor(a + 1, 0)
        let b = search('^\S', 'nWc')
        let s = getline(b)
        if Test(s, '^\):')
            call cursor(b + 1, 0)
            let b = search('^\S', 'nWc')
        endif

        "ec b
        "ec 'this is the b'

        "ec s
        if !Test(getline(b), '^[\]\}]')
            let b -= 1
        endif
        "ec b
        "ec 'bbb'
    else
        if Test(aline, '`')
            let b = search('^`', 'nW')
        elseif Test(aline, '[''"] *$')
            let b = a
        else
            let b = search('\v^(`|endfunction|\\?\}\)?\ze *\n|\\?\]|def|class|function|\w+)', 'nW') 
        endif
    endif

    if b < a
        let b = line('$')
    endif
    return [a,b]
endfunction

function! RunWordUnderCursor()
    let file = CurrentFile()
    let word = GetCurrentWord()
    let e = GetExtension(file)
    ec [file, word, e]
endfunction
function! CurrentWord()
    return GetCurrentWord2()
endfunction
"nnoremap qr :call RunWordUnderCursor()<CR>
function! Googa()
    call append('$', '"end of line')
endfunction

function! LoadLibrary2(jsonfile)
    let jsonfile = a:jsonfile
    let name = Sub(jsonfile, '\.', '')
    if has_key(g:libraries, name)
        return g:libraries[name]
    else
        let value = ReadJson(jsonfile)
        let g:libraries[name] = value
        return value
    endif
endfunction
function! Tester(fileKey, fnKey)
    ec 'running tester'

    let fileKey = a:fileKey
    let fnKey = a:fnKey
    let inpath = FileGetter2(fileKey)
    call OpenBuffer3(inpath)
    try
        call function(fnKey)()
    catch
        let error = v:exception
        ec {'error': error}
        call OpenBuffer('/home/kdog3682/.vimrc')
    endtry
endfunction

function! SpecializedExportAction()
    " Some files have special export actions
    " 

endfunction
function! AddExport(...) abort
    let name = a:0 >= 1 ? a:1 : GetBindingName()
    if SpecializedExportAction()
        return 
    endif
    try
        let index = FindLineIndex('^export \{', 0, 1, 200)
        if Test(getline(index), '\}')
            let s:name = name
            function! Inner(s)
                let s = a:s
                return Replace(s, '\{', '{ ' . s:name . ',')
            endfunction
            call GetSetFn('Inner', index)
        else
            call append(index + 1, '    ' . name . ',')
        endif
    catch
        ec v:exception
        ec 'no match'
        return 
        let lines = ['export {', '    ' . name . ',', '}']
        call append(0, lines)
    endtry
endfunction
function! CurrentInfo()
    let name = ''
    let word = ''

    try
        let name = GetBindingName()
    catch
    endtry

    try
        let word = CurrentWord()
    catch
    endtry

    if !Exists(name) || !Test(name, '^[a-z0-9]+$')
        let name = 'null'
    endif

    if !Exists(word) || !Test(word, '^[a-z0-9]+$')
        let word = 'null'
    endif
    let file = CurrentFile()
    let tail = Tail(file)
    let e = GetExtension(file)
    let lineNumber = line('.')
    let lineCount = line('$')
    let [spaces, line] = GetSpacesAndLine(lineNumber)
    let date = DateStamp()
    let buffers = GetCurrentBuffers()
    let blockIndexes = GetCodeIndexes()
    let blockText = join(GetLines(blockIndexes), "\n")

    return {
        \'name': name,
        \'date': date,
        \'word': word,
        \'file': file,
        \'tail': tail,
        \'line': line,
        \'spaces': spaces,
        \'ext': e,
        \'lang': e,
        \'lineNumber': lineNumber,
        \'lineCount': lineCount,
        \'buffers': buffers,
        \'blockIndexes': blockIndexes,
        \'blockText': blockText
    \}
    "return [name, word, file, tail, e, lineNumber, lineCount]
    "dict name name word word file file, tail, e, lineNumber, lineCount]
endfunction
function! PythonController(fnKey)
    let info = CurrentInfo()
    let info['fnKey'] = a:fnKey
    let escaped = ShellEscape(Stringify(info))
    return Python(g:runpyfile,'PythonController', escaped)
endfunction
" wth is this it looks like asd
"let g:wpsnippets['scratchpad']['foo'] = "hi asdf"
"if the wpsnippet is 1 word ... it is called as a function
function! SourceCurrentFile()
    let file = CurrentFile()
    if GetExtension(file) == 'vim'
        execute "source " . file
        ec 'sourcing'
    else
        ec file . ' n source'
    endif
endfunction
function! AddNewItems()
    "execute "inoreab <buffer> hx abcdefg<C-R>=Eatchar('\s')<CR>"
    execute "inoreab boo appendSelf()\<C-R>=Eatchar('\s')\<CR>"
endfunction
function! MarkCode()
    let s = Dreplace('[date] "file" name', CurrentInfo())
    call AppendFile(g:changelogfile, s)
endfunction
function! GitPushLine()
    let info = CurrentInfo()
    let escaped = ShellEscape(Stringify(info))
    let s = Dreplace('[GitPush: date] "file" line', info)
    call AppendFile(g:changelogfile, s)
    return Python(g:runpyfile,'gitPushObject', escaped)
endfunction
function! ShellEscapeHander(s) abort
    let dict = {
      \"\n": "newline",
     \ "'": "sq",
     \ "}": "rcb",
     \ "{": "lcb",
     \ "<": "lt",
     \ ">": "gt",
     \ "$": "dollar",
     \ "\\": "backslash",
      \"#": "hash",
      \":": "colon",
      \'"': "dq",
     \ ".": "dot",
     \ " ": "s",
     \ "`": "tilda",
     \ ")": "rp",
     \ "(": "lp",
     \ "!": "exc",
    \}
    let k = a:s[0]
    if has_key(dict, k)
        return 'zz' . dict[k]
    else
        return k
    endif

endfunction
function! ShellEscape(s)
    return Sub(a:s, '\W', function('ShellEscapeHander'))
endfunction


function! ChooseFromList(items)
    let choice = inputlist(a:items)
    return choice
end
endfunction
"let list = [1,2,3,4,5]
function! Node2()

    call Shell('node', CurrentFile() . ' ' . 'clip')
    return 
    let files = [ "hammy.js", "cm.js", ]
    if Includes(tail, files)
        return RunServerFile(tail)
    endif

    if !empty(get(g:globalState, 'cleanerMode'))
        let f = FilePrompt()
        let lines = DeleteBlock()
        call AppendFile(f, lines)
        return 
    endif

    let tail = Tail()
    if tail == 'appscript.js'
        call BasePY('gac')
    elseif tail == 'worksheet-components.js'
        call VisualAction('vt')
    elseif tail == 'vimrc'
        ec 'uh no @ node2'
    elseif Test(tail, 'vob.js$')
        ec 'running vob puppet test'
        let s = GetLastWord(getline('$'))
        call RunServerFile('vob', s)
    else
        ec 'running vob puppet test'
        call RunServerFile('vob', 'default')
        "call PuppetRunner()
    endif
endfunction
"function! GetLastWord(s)
    "return Match(a:s, '[a-z0-9]+\ze *$')
"endfunction

function! GetWord(s)
    return Match(a:s, '[a-z0-9]+')
endfunction
function! Node10()
    if exists('g:activejsfile')
        call Node(g:activejsfile)
    else
        call JavascriptAppController('puppetMaster', 'clip.html')
    endif
endfunction
function! Javascript(...)
    let s = join(a:000, ' ')
    return Node('/home/kdog3682/2023/App.js', s)
endfunction

function! JavascriptAppController(...)
    let s = join(a:000, ' ')
    return Node('/home/kdog3682/2023/App.js', s)
endfunction
function! NoteWriter(s, ...)
    let arg = a:0 >= 1 ? ' ' . a:1 : ''
    let s = '' . DateStamp() . '' . ' [' . a:s . ']' . arg
endfunction
function! SearchUpSearchDown(r1, r2, offset1, offset2)
    let r1 = a:r1
    let r2 = a:r2
    let offset1 = a:offset1
    let offset2 = a:offset2
    let a = line('.')
    let b = a + 1
    let max = line('$')
    while 1
        let s = getline(a)
        if Test(s, r1)
            "let a += 1
            let a += offset1
            break
        else
            let a -= 1
        endif
    endwhile
    while 1
        let s = getline(b)
        if Test(s, r2)
            "let b -= 1
            let b += offset2
            break
        else
            if b == max
                break
            endif
            let b += 1
        endif
    endwhile
    return [a, b]
endfunction
function! GetInnerBlockIndexes()
    let r1 = '^    \S.{-}[\[\{]'
    let r2 = '^\S'
    return SearchUpSearchDown(r1, r2, 0, -1)
endfunction
function! GetNolinebreakNoRootIndexes() abort
    let a = line('.')
    let b = a + 1
    let max = line('$')
    while 1
        let s = getline(a)
        if Test(s, '^\S|^ *$')
            let a += 1
            break
        else
            let a -= 1
        endif
    endwhile
    while 1
        let s = getline(b)
        if Test(s, '^\S|^ *$')
            let b -= 1
            break
        else
            if b == max
                break
            endif
            let b += 1
        endif
    endwhile
    "ec getline(a, b)
    "throw ''
    return [a, b]
endfunction
function! GetNolinebreakNorootIndexes()
    let up = search('\v^ *$', 'bnW')
    let down = search('\v^ *$', 'nW')
    let up += 1
    if down < 1
        let down = line('$')
    else
        let down -= 1
    endif
    return [up, down]
endfunction

function! GetNolinebreakIndexes()
    let up = search('\v^ *$', 'bnW')
    let down = search('\v^ *$', 'nW')
    let up += 1
    if down < 1
        let down = line('$')
    else
        let down -= 1
    endif
    return [up, down]
endfunction
function! Humya()
    let g:activejsfile = CurrentFile()
    call Node(g:activejsfile)
endfunction
function! GetLines(...)
    let indexes = a:0 == 1 ? a:1 : 0 
    if Not(indexes)
        return getline(1, '$')
    endif
    if len(indexes) == 1
        return [getline(indexes[0])]
    endif
    let [a,b] = indexes
   return getbufline(bufnr('%'), a, b)
endfunction

" nnoremap <buffer> ` :w<CR>:call RunLastVimCommand()<CR>
function! RunLastVimCommand()
    if !exists('g:lastvimcmd')
        ec 'g:lastvimcmd does not exist: return'
        return 
    endif
    ec 'executing ' . g:lastvimcmd
    execute g:lastvimcmd
endfunction
function! AppendVimDict(...)
    let template = ''
    let length = len(a:000)
    if length == 2
        let template = 'let g:["$1"] = "$2"'
    elseif length == 3
        let template = 'let g:$1["$2"] = "$3"'
    elseif length == 4
        let template = 'let g:$1["$2"] = ["$3", "$4"]'
    elseif length == 5
        let template = 'let g:$1["$2"] = ["$3", "$4", "$5"]'
    endif
    let s = RegistrarTemplater(template, a:000)
    ec s
    call AppendVim(s)
endfunction
function! Sdf()
    ec ChooseDict(g:aobj)
    return 
    let rLine = Rescape2023(CurrentLine())
    "ec rLine
    "[]$<>({})!@#$
    call ExecuteRegex(rLine)
endfunction
function! RescapeHander(s) abort
    let dict = {
     \ "<": "\\<",
     \ "#": "\\#",
     \ "%": "\\%",
     \ "@": "\\@",
     \ ">": "\\>",
     \ "$": "\\$",
     \ "\\": "\\\\",
      \"=": "\\=",
     \ ".": "\\.",
     \ ")": "\\)",
     \ "}": "\\}",
     \ "{": "\\{",
     \ "[": "\\[",
     \ "]": "\\]",
     \ "(": "\\(",
    \}
    let k = a:s[0]
    if has_key(dict, k)
        return dict[k]
    else
        return k
    endif

endfunction
function! Rescape2023(s)
    return Sub(a:s, '[^\s\w]', function('RescapeHander'))
endfunction

function! ChooseDict(dict) abort
    let dict = a:dict
    let items = values(dict)

    for [i, item] in Enumerate(items)
        ec [i + 1, item]
    endfor 

    if len(items) == 1
        return items[0]
    endif
    let c = len(items) < 10 ? InputChar() : input('')
    if c == 0
        throw 'terminate'
    elseif IsNumber(c)
        return items[c - 1]
    else
        throw 'only numbers from 1-9 allowed'
    endif
    
endfunction
function! GoBookmark2023(s)
    let s = a:s
    let ref = []
    if Exists(s) && has_key(g:bookmarks2023, s)
        let ref = g:bookmarks2023[s]
    else
        let ref = ChooseDict(g:bookmarks2023)
    endif
    call Assert(ref)
    let file = ref[0]
    let rName = "\\v^((async )?function!?|def|class|const) " . ref[1] . '>'
    let rLine = '^' + Rescape2023(ref[2])
    call OpenBuffer3(file)
    call ExecuteRegex(rName)

    "call ExecuteRegex(rLine)
endfunction
function! Assert(s) abort
    if !Exists(a:s)
        throw 'Assertion Stop'
    endif
endfunction
        "\[ 'oa$', "${CreateObjectArray($0)}"],
        "\[ 'on \w+$', "$0on('$2', (e) => {\n    $c\n})"],
        "\[ 'srep$', "$0s.replace(//g, (x) => {\n    $c\n})"],
        "\[ 'l\d$', "f:Snip4Len"],
        "\[ 'vars\w+$', "f:PythonVarsHandler"],
        "\[ '^ *\w+s$', "const $1 = [\n    $c\n]"],
        "\[ '\/st\zs\d+$', "setTimeout(() => $0, $1)"],

function! GetXName(s) abort
    let ref = {
        \'children': 'child',
    \}
    let s = GetLastWord(a:s)
    if Test(s, 's$')
        return s[:-2]
    endif
    return get(ref, s, 'item')
endfunction
call insert(g:pysnippet4ref, ['somex$', '$0some' . xis])
call insert(g:pysnippet4ref, ['exi$', '$0every' . xis])
call insert(g:pysnippet4ref, ['v$', '${GetXStart($0)}'])
call insert(g:pysnippet4ref, ['fe$', '$0forEach' . xis])
call insert(g:pysnippet4ref, ['mapx?$', '$0map' . xis])
call insert(g:pysnippet4ref, ['walkx?$', '$0walk' . xis])

function! GetXStart(s)
    let s = a:s
    let args = split(trim(s), ' ')
    "call add(args, 'k')
    let l = len(args)
    "return l
    if l==2
        return RegistrarTemplater("$1($2, ($c) => {\n    \n})", args)
    endif
    
endfunction
"foo boo v

function! GetLastWord(s)
    return GetLast(FindallStrings(a:s, '\w+'))
endfunction


function! CleanCommand()
    return 
    "let r = '^(var|let|const|async|function|class|def) \w+|^
    "let r = '^' . Rescape2023(r)
    let index = FindLineIndex(r, '$', -1, 1000)
    ec 'just seeing if it :Clean command works and it does'
    return 
    let info = CurrentInfo()
    ec info
    "return Python2('gitPushObject', CurrentInfo())
endfunction

function! Python3(file, ...)
    let file = a:file
    let file = g:pydir . file
    let args = map(Flat(a:000), "ShellEscape(Stringify(v:val))")
    let cmd = "!python3 " . file . " " . join(args, " ")
    execute cmd
endfunction

function! Python2(...)
    let args = map(Flat(a:000), "ShellEscape(Stringify(v:val))")
    let cmd = "!clear; python3 " . g:runpyfile . " " . join(args, " ")
    execute cmd
endfunction
command Clean call CleanCommand()
"nnoremap ) :call RunClassJS()<CR>
function! JsImportPath(s)
    let s = a:s
    let f = ''
    try
        let f = FileGetter2(s)
    catch
        let f = NBackslash(s)
        if empty(f)
            let f= s
        endif
    endtry
    return './' . Tail(AddExtension(f, 'js'))
endfunction
function! SnippetActionJsImport(s) abort
    let items = split(a:s, ' ')
    let length = len(items)
    if length == 1
        let a = items[0]
        let f =  a . '.js'
        if IsFile(f)
            let template = "import {$1} from \"$2\""
            return RegistrarTemplater(template, [a, JsImportPath(a)])
        endif
        let template = "import * as $1 from \"$2\""
        return RegistrarTemplater(template, [a, JsImportPath(a)])
    elseif length == 2
        let a = items[0]
        let b = JsImportPath(items[1])
        let template = "import {\n    $1\n} from \"$2\""
        return RegistrarTemplater(template, [a, b])
    else
        throw 'in progress'
    endif
endfunction
" 02-10-2023 
function! AddExtension(s, ...)
    return HasExtension(a:s) ? a:s : a:s . '.' . (a:0 >= 1 ? a:1 : GetLang())
endfunction


function! OpenExistantBuffer(f)
    let f = a:f
    if IsFile(f)
        call OpenBuffer3(f)
    else
        ec 'not a file: ' . f
    endif
endfunction
function! GoLastTouchedPosition()
    return 
endfunction
" 02-10-2023

function! RegistrarDollarTemplater(s, parts)
    let s = a:s
    let parts = a:parts
    let r = '\$(\{.{-}\}|\d+(--[a-z])?|[a-zA-Z]{3,})'
    let snippet = Sub(s, r, {x -> function('Pst')(x, parts, s)})
    return snippet
endfunction
function! SameWordIndexes()
    let positiveCondition = 1
    let s = CurrentLine()
    let first = GetFirstWord(s)
    let F = {i -> first == GetFirstWord(getline(i))}

    let i = line('.')
    let a = i
    let b = i + 1
    let max = line('$')

    " up
    if positiveCondition
        while a > -1
            if F(i)
                let a -= 1
            else
                break
            endif
        endwhile

        while b < max
            if F(i)
                let a += 1
            else
                break
            endif
        endwhile
    endif

    return [a, b]
endfunction
function! MakeIndexes(up, down)
    let up = a:up
    let down = a:down
    return FindUpDownIndexes(up, down)
endfunction
function! FileGetter2023(...)
    let arg = a:0 >= 1 ? a:1 : input('choose a file:')
    return NBackslash(arg)
endfunction

"call mkdir(g:assignmentdir)
function! VisualShuntMD(state)
    let state = a:state
    let arg = Replace(state.lines[0], '^# *', '')
    let arg = AddExtension(arg, 'md')
    let outpath = g:rootdir . 'MARKDOWN/' . arg
    try
        call AppendFile(outpath, state.lines)
    catch
        let error = v:exception
        ec error
        ec 'not deleting the file'
        return 
    endtry
    if len(state.lines) + 5 > line('$')
        "let file = expand('%')
        call DeleteFile2()
    endif
    return 1
endfunction

function! VisualShuntCodingAssignment(state)
    let state = a:state
    let arg = Prompt('name?')
    let arg = AddExtension(arg, 'md')
    let outpath = g:assignmentdir . 'Coding Assignment - ' . arg
    call AppendFile(outpath, state.lines)
endfunction

function! VisualShuntResource(state)
    let state = a:state
    let arg = state.lines[0]
    if Test(arg, '^#')
        let arg = trim(Sub(state.lines[0], '["#@]', ''))
    else
        let arg = empty(state.arg) ? Prompt('filename?') : state.arg
    endif
    let arg = AddExtension(arg, 'txt')
    let outpath = g:resourcedir . arg

    "asdasasdasdas
    "asdasasdasdas
    "asdasasdasdas

    call AppendFile(outpath, state.lines)
    call SetLastTouchedFile(outpath)
endfunction

function! SetType()
    let cmd = "set filetype=javascript"
    ec cmd
    exec cmd
endfunction
"previewComponentTemplate(SetType)
"let g:execRef[
function! SetVFast()
    if exists('g:fastvue')
        unlet g:fastvue
        ec 'removing fastvue'
    else
        let g:fastvue = 1
        ec 'starting fastvue'
        call RunFastVue()
    endif
endfunction
function! Assert(s, message) abort
    let s = a:s
    let message = a:message

    if !Exists(s)
        throw 'AssertionError: ' . message
    endif
endfunction
" @bookmark 1680193157 RunFastVue
function! RunFastVue()
    let r = '\@bookmark *\d+ *\zs\w+'
    let propKey = Match(getline('$'), r)
    call Assert(propKey, 'PropKey is required')
    call Node(g:serverfile, propKey, 'fastvue', 'build.html')
endfunction
function! LookupCDNLink(key)
  let value = cdnLinks[a:key]
  return value
endfunction
function! MakeStringArray2023(s)
    let items = split(a:s, ' ')
    let [a, b] = SplitOnce(items)
    let b = join(map(b, 'DoubleQuote(v:val)'), ', ')
    return RegistrarTemplater('const $1 = [$2]', [a, b])
endfunction
function! CreateTestStringWithCurrentFunction()
    let name = GetBindingName()
    let str = 'str' . (Capitalize(name)) . MonthDay()
    let template = "let $2 = `\n$c\n`\nconsole.log($1($2))\n"
    let value = RegistrarTemplater(template, [name, str])
    call PlaceSnippet2023(value, '', '$')
endfunction


function! PlaceSnippet2023(snippet, ...)
    let snippet = TabsToSpaces(a:snippet)
    let spaces = a:0 >= 1 ? a:1 : CurrentSpaces()
    let location = a:0 >= 2 ? a:2 : 0
    if !empty(location)
        call cursor(location, 0)
        call append('$', ['', ''])
        call append('.', '')
        call cursor(line('.') + 5, 0)
    endif

    let cursorpos = GetCursorFromStringSnippet(snippet)
    let snippet = Replace(snippet, '\$c', '')
    call TextPlacement(SplitLines(snippet), spaces)
    call SetCursor(cursorpos, spaces)
endfunction
function! Foo()
    "normal \<c-d>
    "doesnt work
    "normal G
    "moves down
    "execute "normal! mqA;\<esc>`q"
    "adds a semicolon to the end of the current line ";"
    "execute "normal! \<c-d>"
    "moves page down
    "execute "normal! \<c-u>"
    "moves page up 
endfunction
function! AppendEndOfFile()
    let line = line('$')
    let index = FindLineIndex('\S', line, -1, 100)
    let delta = line - index
    for i in range(delta)
        ec 'hi'
    endfor
    return 
    ec index
    if line == index
        ec 'hi'
    else
        ec index
        "call append('$', ['', ''])
        "execute "normal! \<c-d>"
    endif
endfunction
" 02-16-2023
" 02-17-2023
"
"let g:wpsnippets['scratchpad'] =
"del

" 02-17-2023
" 02-17-2023
" 02-17-2023
" 02-20-2023
function! MakeStringDict2023(s)
    let s = a:s
    if Test(s, ',')
        let out = "const dict = {\n"
        let items = map(split(s, ','), 'SplitOnce(trim(v:val))')
        for [a, b] in items
            let b = DoubleQuote(b)
            let out .= "    " . DoubleQuote(a) . ": " . b . ",\n"
        endfor
        let out .= "}"
        return PlaceSnippet2023(out)
    endif

    let items = split(a:s, ' ')
    let s = "const dict = {\n"
    for [a,b] in SplitListIntoPairs(items)
        let a = DoubleQuote(a)
        let b = DoubleQuote(b)
        let s .= "    " . a . ': ' . b . ",\n"
    endfor
    return s . "}"
endfunction

function! TextShebang()
    if Lang() == 'txt'
        let first = getline(1)
        if Test(first, '^#!')
            call Javascript('shebang', CurrentFile())
            return 1
        endif
    else
        return 0
    endif
endfunction
" 02-21-2023
        
" 02-22-2023

" 02-23-2023
"
"const raw = read('/mnt/chromeos/GoogleDrive/MyDrive/cwt_scores_autumn2022.json')
function! IsCurrentFile(buffer)
    let a = Abspath(a:buffer)
    let b = Abspath(CurrentFile())
    return a ==# b
endfunction
" 02-24-2023

function! Abspath(file)
    return fnamemodify(a:file, ':p')
endfunction

function! AiiCreateFunctionBlock(...)
    let [spaces, line] = GetSpacesAndLine()
    if line == ''
        return PySnippet('emptyFunction')
    endif
    let line = Replace(line, '^def ', '')

    if IsPy()
        if spaces == '    '        
            let context = GetContext2()        
            if context == 'class'
                return PySnippet(spaces . '' . 'pcfclass' . ' ' . line)        
            else
                ec 'hi'
                return PySnippet(spaces . '' . 'pcffn' . ' ' . line)        
            endif
        endif
    endif
    let line = Sub(line, '-', '_')

    if Test(line, '\=')
        let [a,b] = SplitOnce(line, '=')
        let a = NameMaker(line)
        return 
    endif

    if HasExistingText(line)
        let word = CurrentWord() . ' '
        call GoTop()
        call setline('.', word)
        return 
    endif

    let dict = {
       \ '': 'abc s', 
       \ 'main': 'main s', 
       \ 'test': 'testing', 
       \ 'render': 'render h', 
       \ 'ts': 'toString', 
    \}

    let line = get(dict, line, line)
    let name = GetFirstWord(line)
    let line = Camelize(line)
    let suffix = JSPY('suffix')

    if strlen(spaces) > 0
        let a = NameMaker(line)
        let lines = IsArray(a) ? a : [a, '    ', suffix]
        call TextPlacement(lines)
        call cursor(Relative(1), 100)
        return
    endif

    let start = trim(NameMaker(line))
    call setline('.', start)
    call append('.', ['    ', suffix])
    call cursor(line('.') + 1, 100)

    "-----------
    "-----------
    "-----------
    "-----------
    "-----------
    "-----------
    "-----------
    "-----------
    "-----------
    if Exists(name)
        return 
        if IsMarkable(CurrentFile())
            let payload = DateStamp() . ' ' . Basename(CurrentFile()) . ' ' . name
            call AppendFile('functions.log', payload)

            if IsJsPy()
                let payload = DateStamp() . ' ' . CurrentFile() . ' ' . name
            else
                let payload = Commented(Dated(name))
                call Append(payload, '^')
            endif
        endif
    endif
endfunction
function! MDY()
    return tolower(strftime('_%B%-d_%-I%p'))
endfunction
" 02-28-2023
"let g:filedict["vu"] = "/home/kdog3682/2023/vue-utils.js"
" 
" 03-01-2023

function! DeleteKey(dict, key)
  try
    call remove(a:dict, a:key)
    return "Key successfully deleted"
  catch
    return "Error: " . v:exception
  endtry
endfunction

"call DeleteKey(g:execRef, 'asdf')


"td lezer for vim

function! ToInputArg()
    let s = Prompt('Write an arg')
    if IsNumber(s)
        return s
    elseif Test(s, '[''" ]')
        return s
    elseif Exists(s)
        return Qgp(s)
    else
        return ''
    endif
endfunction
" 03-01-2023
" 03-02-2023
function! Zooks()
    for item in [1,2,3]
        ec item
    endfor
endfunction
function! SplitListIntoPairs(numbers)
    " created by vim
  let l:numbers = a:numbers
  let l:pairs = []
  let l:current_pair = []
  let l:i = 0
  for l:number in l:numbers
    call add(l:current_pair, l:number)
    let l:i += 1
    if l:i == 2
      call add(l:pairs, l:current_pair)
      let l:current_pair = []
      let l:i = 0
    endif
  endfor
  if len(l:current_pair) > 0
    call add(l:pairs, l:current_pair)
  endif
  return l:pairs
  return string(l:pairs)
endfunction
"dict a b
" need to fix this cuz not working
"nnoremap en :call EditNoteFile()<CR>Go
function! EditNoteFile()
    let index = FindLineIndex('console', '$', -1, 100)
    let line = trim(getline(index))
    let file = CurrentFile()
    call OpenBuffer3('changelog.md')
    call append('$', [file, line])
endfunction
" 03-03-2023
" 03-04-2023
" 03-05-2023


" 03-05-2023
" 03-06-2023
function! FindallArray(items, r)
    let store = []
    for item in a:items
        let m = Match(item, a:r)
        if Exists(m)
            call add(store, m)
        endif
    endfor
    return store
endfunction
function! GetTextIniItems(s)
    let key = Depluralize(a:s)
    let r = '^' . key . ': *\zs.+'
    let lines = getline('^', '$')
    let items = Unique(FindallArray(lines, r))
    call insert(items, Pluralize(a:s), 0)
    return join(items, "\n")
endfunction
function! Pluralize(s)
    let s = a:s
    return Replace(s, 's$', 's')
endfunction
" 03-07-2023
" 03-07-2023

function! SystemNode(file)
    let file = a:file
    let output = systemlist(printf('clear; node %s', file))
    ec {'output': output}
endfunction
function! Shell(key, s)
    execute "!clear;" . a:key . " " . a:s
endfunction

function! TraceNode()
    "let cmd = "!clear;node --trace-uncaught " . join(Flat(a:000), " ")
endfunction
function! Announce(a, b)
    let a = a:a
    let b = a:b
    return a . ': ' . b
endfunction
function! RunJavascriptFile(file, ...)
    let file = a:file
    let cmd = "!clear;node " . file . '
    let t = '!clear;node %s %s'
    let args = join(Flat(a:000), " ")
    let cmd = printf(t, file, args)
    execute cmd
    "ec Announce('file', file)
endfunction

function! Node(...)
    let node = 'node --trace-uncaught'
    let node = 'node'
    let cmd = "!clear;" . node . " " . join(Flat(a:000), " ")
    execute cmd
endfunction
" 03-08-2023
" 03-09-2023
" 03-09-2023

function! CountOpenBuffers()
    return len(GetOpenBuffers())
endfunction
function! GetOpenBuffers()
    return filter(range(1, bufnr('$')), 'buflisted(v:val)')
endfunction

function! SwapXOnMeasure()
    let a = 'function xOnMeasure'
    let b = 'function onMeasure'
    let c = 'ab3334444ba'
    call ExecuteReplace(a, c)
    call ExecuteReplace(b, a)
    call ExecuteReplace(c, b)
endfunction

function! Fox34234234()
    call ExecuteReplace2('booga18181', 'booga12321')
    "booga18181
endfunction
function! ExecuteReplace2(a, b, ...)
    let a = a:a
    let b = a:b
    let g = a:0 >= 1 ? "" : "g"
    let cs = a:0 >= 2 ? '\C' : ''
    let range = '7270,7271'
    " let range = ''
    let cmd =  range . "%substitute/\\v" . Boundary(a) . cs . "/" . b . "/" . g
    ec cmd
    execute cmd
endfunction


function! ExecuteReplace(a, b, ...)
    let a = a:a
    let b = a:b
    let g = a:0 >= 1 ? "" : "g"
    let cs = a:0 >= 2 ? '\C' : ''
    let cmd =  "%substitute/\\v" . Boundary(a) . cs . "/" . b . "/" . g
    ec cmd
    execute cmd
endfunction


" 03-10-2023
function! TimestampedBookmark(...)
    let mark = a:0 >= 1 ? a:1 : LineMark()
    if !Exists(mark)
        let mark = LineMark()
    endif
    let s = strftime('%s') . ' ' . mark
    let s = RegistrarTemplater(Jspy('bookmark_template'), s)
    call append('$', s)
    return s

    if exists('b:last_time_stamp')
        let s = b:last_time_stamp
        unlet b:last_time_stamp
        return s
    else
        let b:last_time_stamp = strftime('%s') . ' ' . LineMark()
        return b:last_time_stamp
    endif
endfunction
function! LineMark()
    let r = '[a-zA-Z.0-9]{4,}'
    let i = FindLineIndex(r, line('.') + 1, 1, 50)
    let s = getline(i)
    let words = FindallStrings(s, r)
    let word = Find(words, {s -> !Test(s, 'async|class|def|console|function|return|const|var|let|print')})
    return word
    "abc.foo.dsdf
endfunction
"inoremap zz <esc>gg
" 03-13-2023
" nnoremap <leader>m :call ChooseBuffer2('mathematics')<CR>:call append('$', '**' . DateStamp())<CR>Go


function! Unlog(...)
    let [spaces, line] = GetSpacesAndLine()

    if Test(line, '^(console|print)(\.\w+)*\(')
        let line = Replace(line, '\w+(\.\w+)*\(', '')
        let line = line[0:-2]
        call setline('.', spaces . line)
    elseif Test(line, '^(\w+ )?\w+ \=')
        let line = Replace(line, '^(\w+ )?\w+ *\= *', '')
        let line = Logger(line)
        call setline('.', spaces . line)
    elseif Test(line, '\w+\(')
        let line = Logger(line)
        call setline('.', spaces . line)
    endif
endfunction

function! ReplaceWordUnderBlock(state) abort
    let state = a:state
    let word = Sub(GetCurrentWord(), '\W+', '')
    let lines = copy(state.lines)
    let lines = map(lines, 'Replace(v:val, Boundary(word), state.arg)')
    return lines
endfunction

function! CloseConfigBuffers()
    
endfunction
function! ReplaceBackAndForth()
    let s = CurrentLine()
    let a = "stringify(asdfasdf)"
    let a = "stringify(asdfasdf)"
    let a = "stringify(asdfasdf)"
    let s = "console.log(JSON.stringify(asdfasdf, null, 2))"
    let s = Test(s, 'stringify') ? Replace(s, '(JSON.)?stringify(.{-})', {x -> Replace(x[0], '(JSON.)?stringify, '')[1:-2] }) : Replace(s, 'log.\(.*\)', 'sdfsdf')
    return s
endfunction

function! FileDeterminer(n) abort
    let n = a:n
    let name = Tail()
    let ref = g:fastfiles[n]
    if has_key(ref, name)
        return ref[name]
    else
        return ref.default
    endif
endfunction
function! PasteReplace()
  let saved_register = @0   " save the current copy buffer
  normal! "0yw              " yank the word under the cursor into register 0
  let @0 = saved_register   " restore the copy buffer
  normal! "_d               " delete the word under the cursor without changing the copy buffer
  normal! "0p              " paste the copied word over the deleted word
endfunction

"asfasdfasdfasdfasdf
"fffff

function! GPTGetCurrentWord()
  let cursor_pos = getpos('.')
  let current_word = expand('<cWORD>')
  let start_pos = cursor_pos
  let end_pos = cursor_pos
  while start_pos[2] > 1 && matchstr(getline(start_pos[1])[start_pos[2]-2:start_pos[2]-1], '\S') != ''
    let start_pos[2] -= 1
  endwhile
  while end_pos[2] <= strchars(getline(end_pos[1])) && matchstr(getline(end_pos[1])[end_pos[2]-1:end_pos[2]], '\S') != ''
    let end_pos[2] += 1
  endwhile
  return [current_word, start_pos, end_pos]
  " Some modifications to be done on this.
endfunction

function! CommentBlock()
  let comment_char = ''
  if &filetype == 'vim'
    let comment_char = '"'
  elseif &filetype == 'python'
    let comment_char = '#'
  elseif &filetype == 'javascript'
    let comment_char = '//'
  " Add more file types and their respective comment characters here
  endif

  let start_pos = getpos("'<")
  let end_pos = getpos("'>")
  let line_count = end_pos[1] - start_pos[1] + 1

  let lines = getline(start_pos[1], end_pos[1])

  let i = 0
  while i < len(lines)
    let lines[i] = comment_char . ' ' . lines[i]
    let i += 1
  endwhile

  call setline(start_pos[1], lines)
  execute start_pos[1] . ',' . end_pos[1] . 's/^/' . comment_char . ' /'

  normal! '[V']>
endfunction

" 03-17-2023
"let g:notefile = '/home/kdog3682/2023/TEXTS/notes.txt'


"/home/kdog3682/CWF/public/color-utils.js"
"/home/kdog3682/CWF/public/chroma.min.js"
" 03-20-2023
" 03-21-2023
function! SaveWord()
    let word = GetCurrentWord()
    if exists('b:saved_words')
        call add(b:saved_words, word)
    else
        let b:saved_words = [word]
    endif
endfunction
function! UnloadSavedWords()
    if exists('b:saved_words')
        let words = b:saved_words
        let b:saved_words = []
        return words
    else
        return []
    endif
endfunction

function! UnloadSavedWordsOnTemplate(s)
    let s = map(UnloadSavedWords(), "RegistrarTemplater(a:s, v:val)")
    return join(s, "\n")
endfunction
" 03-22-2023
" 03-22-2023
" 03-22-2023


function! DivideByTwo(num)
    let result = a:num / 2
    return float2nr(floor(result))
endfunction

function! CloseOldestBuffers()
    let buffers = getbufinfo({'buflisted': 1})
    let length = len(buffers)
    if length <= 5
        return 
    endif

    call sort(buffers, function('CompareByLastUsed'))

    for i in range(0, length - 4)
        call CloseBuffer2(buffers[i])
    endfor
endfunction



function! CompareByLastUsed(a, b)
   let a = a:a
   let b = a:b
  if a.lastused < b.lastused
    return -1
  elseif a.lastused > b.lastused
    return 1
  else
    return 0
  endif
endfunction

function! CloseBuffer2(target) abort
  if type(a:target) == 1
    let bufnum = bufnr(a:target)
  elseif type(a:target) == 0
    let bufnum = a:target
  else
    let bufnum = a:target.bufnr
    ec 'closing ' . a:target.name
  endif

  execute 'bdelete ' . bufnum
endfunction

function! ExecNU()
    let line = CurrentLine()
    if Test(line, 'node')
        let line = line[43:-3]
    else
        let line = RegistrarTemplater('import {clip} from "./node-utils.js"; clip($1);', trim(line))
    endif
    call setline('.', line)
endfunction

"let s = 'import {clip} from "./node-utils"; clip($1);'
"ec s[40:-3]
" 03-25-2023
" @bookmark 1679795657 va
" 03-27-2023
function! Rep192(s)
    let s = a:s
    return Replace(s, '^ *// *', '')
    
endfunction
function! AddPydictItem(s, mode)
    let s = a:s
    let mode = a:mode
    let ref = mode == 2 ? g:wpsnippets2 : g:wpsnippets
    let key = mode == 2 ? 'wpsnippets2' : 'wpsnippets'
    let lang = mode == 2 ? Tail() : Lang()
    let [a, b] = IsArray(s) ? s : SplitOnce(trim(s))
    call AppendAndExecuteDict(key, lang, a, b)

endfunction
"nnoremap <f3> :w<CR>:call RunServerFile('screenshot', '')<CR>
"nnoremap <f4> :w<CR>:call RunServerFile('print', 'finalDraft')<CR>
"nnoremap <f5> :w<CR>:call RunServerFile('html')<CR>
"nnoremap <f6> :w<CR>:call RunServerFile('')<CR>
"nnoremap <f7> :w<CR>:call RunServerFile('sunshine')<CR>
function! Blank()
    ec 'blank ... awaiting a command'
endfunction
function! AddServerFileCommand(s)
    let s = a:s
    let t = "call add(g:server_html_commands, \"$1\")"
    let t = RegistrarTemplater(t, s)
    call add(g:server_html_commands, s)
    let g:server_html_index = len(g:server_html_commands) - 1
    call AppendVim(t)
endfunction
"nnoremap <f1> :w<CR>:call Blank()<CR>
"nnoremap <f1> :w<CR>:call RunServerFile('earlyReturn')<CR>
" 03-28-2023
function! CycleServerFileCommand()
    "let items = g:server_html_commands
    let items = g:server_html_super_commands
    let index = g:server_html_index + 1
    if index == len(items)
        let index = 0
    endif
    let g:server_html_index = index
    ec items[index]
endfunction
function! AddPConfItem()
    let line = CurrentLine()
    let name = ''
    if Test(line, 'compo')
        let name = Match(line, 'component[''"]?: *[''"]\zs\w+')
        ec name
        ec 'hi'
        ec line
    elseif Test(name, '^v')
        let name = GetCurrentWord()
        let name = Replace(name, '..', tolower(name[1]))
    else
        let name = GetBindingName()
        let name = Replace(name, '..', tolower(name[1]))
    endif
    if empty(name)
        ec 'empty'
        return 
    endif
    call OpenBuffer3('/home/kdog3682/2023/production.config.js')
    let i = FindLineIndex('^const props', 0, 1, 1000)
    let lines = [
        \'    ' . name . ': {',
        \'        a: {',
        \'            asdf: '''',',
        \'        },',
        \'    },',
    \]
    call append(i, lines)
endfunction
function! F1Manager()
    let tail = Tail()
    if tail == 'production.config.js' || tail == 'serve_html_file.js'
        call RunServerFile('earlyReturn')
    else
        call RunPrevFile()
    endif
endfunction



" 03-29-2023
function! Qgs() abort
    let s = input('')
    if s == '#'
        return Tail(bufname('#'))
    elseif s == ''
        return Tail()
    endif
    let f = NBackslash(s)
    if IsFile(f)
        return Tail(f)
    endif

    let f = FileGetter3(s)
    if IsFile(f)
        return Tail(f)
    endif
    throw 'no file'
endfunction
" 03-30-2023
function! PythonWithState(key)
    let key = a:key
    let ref = g:pythonWithStateDict[a:key]
    let args = [ref, CurrentInfo()]
    "call WriteJson('pythonWithState.json', args)
    call Python2('pythonWithState')
endfunction
"function foo () {

"}

"like da but for inside
" @bookmark 1680193157 RunFastVue
function! OpenFileThenGoMovementMarkerThenAppendAboveWithIndentAndComma(file, s)
    let file = a:file
    let s = a:s
    call OpenBuffer3(file)
    let i = FindLineIndex('movement-marker', 0, 1, 1000)
    let spaces = GetSpaces(i)
    call append(i - 1, spaces . s . ',')
    
endfunction
function! AddSomething()
    let r = '\@bookmark *\d+ *\zs\w+'
    let regexes = [r]
    let match = MSearch(regexes)
    call OpenFileThenGoMovementMarkerThenAppendAboveWithIndentAndComma('main.js', match)
endfunction
function! MSearch(regexes, ...) abort
    let regexes = a:regexes
    let line = a:0 >= 1 ? a:1 : CurrentLine()
    for regex in regexes
        let m = Match(line, regex)
        if Exists(m)
            return m
        endif
    endfor
    throw 'no match'
endfunction

function! Node3()
    return Node('Puppeteer2.js')
    let key = g:server_html_super_commands[g:server_html_index]
    call Node(g:serverfile, key)
endfunction
" 03-31-2023

function! JAC(s) abort
    let ref = {
        \'ai': 'addMissingImportsFromDependencyLibrary',
    \}
    let s = ref[a:s]
    return Node('/home/kdog3682/2023/App.js', s, CurrentFile())
endfunction

" very useful
"

function! PasteBufferGroupToFile(...)
    let state = CurrentInfo()
    call append('$', Comment(state.buffers))
endfunction
" 03-31-2023
function! A8(...) abort
    let orig = CurrentFile()
    let name = GetBindingName()
    let [a,b] = GetCodeIndexes()
    let lines = GetLines([a, b])

    let file = a:0 >= 1 ? a:1 : ''
    let topComment = TopComment(lines)
    let topFile = AddExtension2(topComment, 'js')
    let stay = 0
    if IsFile(topFile)
        if Tail(file) == Tail()
            return 
        endif
        let file = topFile
        let stay = 1
    endif

    call DeleteBlock([a,b])
    let file = AddImport(name, file)
    call insert(lines, '', 0)
    call OpenBuffer4(file)
    call AddExport(name)
    call append('$', lines)
    if stay
        call Cursor(line('$') - 1, 100)
        startinsert 
    else
        call OpenBuffer4(orig)
    endif
endfunction
function! GetOrDefine(key)
    let value = a:0 >= 1 ? a:1 : FilePrompt()
    let key = 'g:' . a:key
    if exists(key)
        return eval(key)
    else
        execute printf('let %s = "%s"', key, value)
        return value
    endif
endfunction
function! A0()
    let file = GetOrDefine('a8file')
    return A8(file)
endfunction
" 04-02-2023
" 04-03-2023
" buffer group
" /home/kdog3682/.vimrc
" utils.js
" elementObjects.js
" /home/kdog3682/2023/vue-utils.js
" /home/kdog3682/2023/worksheet-components-2.js
" /home/kdog3682/2023/ws2.vob.js
" /home/kdog3682/2023/spellcheck.js
" /home/kdog3682/2023/vueSetup.js
" /home/kdog3682/2023/elementObjects.js
" /home/kdog3682/2023/vueData.js
" 04-04-2023
" press pbg on end!!!
" 04-04-2023

function! GSTSO(s)
  let r = '[''",.]'
  let items = IsArray(a:s) ? a:s : split(Sub(a:s, r, ''), '\s\+')
  let s:gstaprefix = Jspy('const')
  function! GSTSOMap(i, s)
    let s = a:s
    let i = a:i
    if i == 0
        return s:gstaprefix . s . ' = {'
    else
        return '    ' . s . ','
    endif
  endfunction
  let store = map(items, function('GSTSOMap'))
  call add(store, '}')
  return store
endfunction

function! GSTSA(s)
  let r = '[''",.]'
  let items = IsArray(a:s) ? a:s : split(Sub(a:s, r, ''), '\s\+')
  let s:gstaprefix = Jspy('const')
  function! GSTSAMap(i, s)
    let s = a:s
    let i = a:i
    if i == 0
        return s:gstaprefix . s . ' = ['
    else
        return '    ' . Quote(s) . ','
    endif
  endfunction
  let store = map(items, function('GSTSAMap'))
  call add(store, ']')
  return store
endfunction
function! ToStringArray()
    call GetSetFn('GSTSA')

endfunction

"school-calender chrome-extension://ieepebpjnkhaiioojkepfniodjmjjihl/data/pdf.js/web/viewer.html?file=https%3A%2F%2Fwww.schools.nyc.gov%2Fdocs%2Fdefault-source%2Fdefault-document-library%2Fparent-facing-calendar-2022-23
function! DoubleDash(s)
    let commands = ParseCommandLineArgs(a:s)
    let word = GetCurrentWord2()
    " @bookmark 1680658730 items
    try

                let end1 = 1000
                let end2 = 500
        for [a,b] in items(commands)
            if a == 'cp'
    
                let i1 = FindLineIndex('^\w+ ' . b, 0, 1, end1)
                let i2 = FindLineIndex('^([}\]]|endfunction)', i1, 1, end2)
                let lines = GetLines([i1, i2])
                let lines = map(lines, 'Sub(v:val, b, word)')
                call AppendAbove(i1, lines)
            elseif a == 'mv'
                let i1 = FindLineIndex('^\W*' . b, 0, 1, end1)
                let line = getline(i1)
                let copied = Sub(line, b, word)
                call append(i1, copied)
            endif
        endfor
    catch
        let error = v:exception
        ec error
    endtry
    
endfunction

function! AppendWordAtLineIndex(index, word)
  " Get the previous line's indentation and punctuation
  let prev_line_num = a:index - 1
  let prev_line = getline(prev_line_num)
  let prev_indent = substitute(prev_line, '^\s*\zs.*$', '', '')
  let prev_punctuation = substitute(prev_line, '^\s*\zs.*\ze[,.?!;]$', '', '')

  " Insert the new word with the same indentation and punctuation
  let new_line = repeat(' ', strlen(prev_indent)) . a:word . prev_punctuation
  call append(a:index, new_line)
endfunction

function! ParseCommandLineArgs(args)
  let result = {}
  let parts = split(a:args, ' ')
  let name = ''
  for part in parts
    if part =~ '^--'
      let name = substitute(part, '^--', '', '')
      let result[name] = ''
    else
      let result[name] = part
    endif
  endfor
  return result
endfunction
function! GetArgString(s)
    let s = a:s
    let d = Test(s, '  ') ? '  ' : ' '
    let args = split(s, d)
    let params = map(args, 'AddQuotes(v:val)')
    return join(params, ', ')
endfunction
function! RunCurrentFunction(s)
    let name = GetBindingName()
    let argString = GetArgString(a:s)
    let template = '%s(%s)'
    let t = Printf(template, name, argString)
    ec t
    ec eval(t)
endfunction
" @bookmark 1680658725 IsWord
" @bookmark 1680658730 items
function! AppendAbove(i1, lines)
    let i1 = a:i1
    let lines = a:lines
            call add(lines, '')
            call append(i1 - 1, lines)
endfunction
" 04-05-2023

function! AppendString(i, s)
    let i = a:i
    let s = a:s
    if Test(s, "\n")
        let lines = split(s, "\n")
        call add(lines, '')
        "ec lines
        call append(i, lines)
    else
        call append(i, s)
    endif
    
endfunction

"call AppendString(line('.'), "\"hi\n\"bye")
function! GetCurrentWordOrBinding()

    let word = GetCurrentWord2()
    let known = ['if', 'for', 'function', 'const', 'var', 'let', 'else', 'return']
    if Includes(word, known) || len(word) < 3
        let word = GetBindingName()
    endif
    return word
endfunction
function! GetFileType()
    return &filetype
endfunction


function! RunServerFile(...)
    let file = '/home/kdog3682/2023/serve_html_file.js'
    let file = '/home/kdog3682/2023/serveFile.js'
    let action = a:0 >= 1 ? a:1 : 'html'
    "let [componentKey, propKey, actionKey] = GetServerFileArgs()
    "call Node(file, componentKey, propKey, actionKey)
    call Node(file, action)
endfunction


function! CycleCommand(key)
    let key = a:key
    let ref = g:rsf[key]
    let index = ref['index'] + 1
    let items = ref['items']

    if index == len(items)
        let index = 0
    endif
    let ref['index'] = index
    let value = items[index]
    let aliases = {
        \'ak': 'Server ActionKey',
        \'pk': 'Server PropKey',
    \}
    let key = aliases[key]
    ec {key: value}
endfunction

function! SetPropKey()
    call CycleCommand('pk')
endfunction

function! SetActionKey()
    call CycleCommand('ak')
endfunction

function! SetComponentKey(s)
    let s = a:s
    if empty(s)
        let s = 'VRender'
    elseif s == 'p'
        return GetServerFileArgs()
    endif
    let g:ck = VueCase(s)
    call RunServerFile()
endfunction
function! VueCase(s)
    return Test(a:s, '^\CV') ? a:s : Test(a:s, '^\Cv') ? 'V' . Capitalize(a:s[1:]) : 'V' . Capitalize(a:s)
endfunction

"nnoremap <f1> :w<CR>:call F1Manager()<CR>
function! GoGFile()
    if empty(get(g:globalState, 'file'))
        ec 'no g file atm. it resets on vim save'
    else
        call OpenBuffer3(g:globalState.file)
    endif
endfunction

function! SetGFile(s)
    let s = a:s
    let file = !empty(s) ? FileGetter2(s) : CurrentFile()
    call Assert(IsFile(file), 'Not a file: ' . file)
    let g:globalState['file'] = file
    ec 'GFile: ' . Tail(file)
endfunction
function! GetSetFn(k, ...)
    let i = a:0 >= 1 ? a:1 : line('.')
    let [spaces, s] = GetSpacesAndLine(i)
    let v = FunctionGetter(a:k)(s)
    if empty(v)
        ec 'aaa empty v'
        return 
    endif

    if IsArray(v)
        call setline(i, '')
        call append(i - 1, Indent(v, spaces))
    else
        call setline(i, spaces . v)
    endif
endfunction
function! GS4005(s)
    let s = a:s
    let [a,b] = SplitOnce(s)
    let template = 'let g:wpsnippets["$1"]["$2"] = "$3"'
    let args = [Lang(), a, b]
    let value = RegistrarTemplater(template, args)
    ec value
    call AppendAndExecute(value)
    return b
    
endfunction
function! SaveJS()
    call GetSetFn('GS4005')
    "asdasd
    "ssdasdas
    "ssdasdas
    "ssdasdas
    "ssdasdas
endfunction
" 'append.vim'

function! FindEarliestJSBuffer()
  let earliestBuffer = -1
  let earliestTimestamp = 0

  for i in range(1, bufnr('$'))
    " Skip the current buffer
    if i == bufnr('')
      continue
    endif

    " Check if the buffer has a filetype of 'js'
    if &filetype[i] == 'js'
      " Check if this is the earliest buffer so far
      if bufloaded(i) && getbufvar(i, 'last_used') < earliestTimestamp
        let earliestBuffer = i
        let earliestTimestamp = getbufvar(i, 'last_used')
      endif
    endif
  endfor

  return earliestBuffer
endfunction

" 04-06-2023


function! Registration(s)
    let s = a:s
    let [a,b] = SplitOnce(s)
    if empty(b)
        let b = a
        let a = 'iabfn'
    endif
    let word = GetCurrentWord2()
    if empty(b)
        let b = Abrev(word)
    endif
    let args = [b, word]
    let t = g:registratar_templates[a]
    let s = RegistrarTemplater(t, args)
    ec s
    call AppendAndExecute(s)
    "append.vim"
endfunction


function! InGlobal() abort
    let index = line('.')
    let max = min([line('$'), index + 1])
    for i in range(index - 2, max)
        if !Test(getline(i), '^\S')
            return 0
        endif
    endfor
    return 1
endfunction


function! ExecuteComment()
    let r = '\w+\(.+'
    let s = Match(CurrentLine(), r)
    ec 'executing comment: ' . s
    execute "call " . s
endfunction

" Action: SayHi()
function! GetServerFileArgs()
    let [actionKey, propKey] = map(values(g:rsf), 'v:val.items[v:val.index]')
    let componentKey = g:ck

    ec 'componentKey:   ' . componentKey
    ec 'propKey:        ' . propKey
    ec 'actionKey:      ' . actionKey
    return [componentKey, propKey, actionKey]
endfunction
function! GSATN(s)
    let m = SplitOnce(FindCodeWords(a:s))
    let name = m[0]
    let arg = join(m[1], ', ')
    return RegistrarTemplater('function $1($2) {', [name, arg])
    return RegistrarTemplater('const $1 = ($2) => {', [name, arg])
endfunction
function! ArrowToNormal()
  call GetSetFn('GSATN')
endfunction


function! FindCodeWords(s)
  let keywords = ['let', 'const', 'var', 'for', 'if', 'while', 'function', 'return']
  return Difference(FindallStrings(a:s, '\w+'), keywords)
endfunction

function! Difference(a, b)
    let a = a:a
    let b = a:b
  let result = filter(a, {idx, val -> index(b, val) == -1})
  return result
endfunction

" apply https://newyork.craigslist.org/mnh/edu/d/new-york-in-person-regents-test-prep/7607232434.html
" https://newyork.craigslist.org/mnh/edu/d/new-york-in-person-regents-test-prep/7607232434.html
"

"asdfadf
"asdfadf
"asdfadf

function! Fo()
    return Test(']})', '^ *[\]})]*$')
endfunction


function! GSNPS(s)
    let s = a:s
    let ref = {
        
    \ }
    let word = GetCurrentWord2()
    let template = ref[word]

endfunction
function! NormalPySnippet()
    call GetsetFn('GSNPS')
endfunction
"write a  vim function to split a line before and after the word under cursor. that means the word itself, should not be in either half
"rcf is relaly useful
cnoremap ; :

function! GetJSFilesOfPastWeek()
  " Get the Unix timestamp of one week ago
  let pastWeek = strftime('%s', 'now -7 days')

  " Get a list of all files in the directory
  let directoryPath = g:dir2023
  let files = split(glob(directoryPath . '/*'), '\n')

  " Filter the list to include only JavaScript files modified in the past week
  let jsFiles = filter(files, 'filereadable(v:val) && v:val =~# "\\.js$" && str2nr(strftime("%s", getftime(v:val))) >= pastWeek')

  " Return the list of JavaScript files
  return jsFiles
endfunction

function! ContextualColonHandler()
    ec 'don't use this'
  if bufname('%') == 'explorer'
      ec 'hi'
  elseif exists('g:loaded_netrw') && bufname('%') =~# '^netrw:'
    ec 'hi'
  else
      ec 'no'
  endif

endfunction
filetype plugin on

function! OpenMostRecentFile()
  let files = systemlist('ls -t ' . g:most_recent_directory)
  let file = files[0]
  if file !=# ''
    execute 'edit ' . fnameescape(g:most_recent_directory . '/' . file)
  endif
endfunction

function! SubstituteVisible(regex, replacement)
  " Get the range of lines currently visible on the screen
  let startline = line('w0')
  let endline = line('w$')

  " Substitute the regex with the replacement on the visible lines
  execute startline . ',' . endline . 's/' . a:regex . '/' . (type(a:replacement) == type(function('tr')) ? 'call(' . string(a:replacement) . ', submatch(0))' : a:replacement) . '/g'
endfunction

"6j32
"6j32
"6j32
"6j32
"6j32
"6j32
"6j32
"call SubstituteVisible('6j32', 'bixlo')
" 04-06-2023
" 04-07-2023
" todo check g:npsref
" note [rcf]  is useful
" todo collect new mappings
" make shortcut for isPrimitive @ wp
" eo is a candidate for wp like movement
" if the line starts with '"' maybe deactivate wp

function! GSGrab(name)
    let name = a:name
    let block = GetLines(GetCodeIndexes2(0, name))
    return block
endfunction
function! WPGrab(s)
    call GetSetFn('GSGrab')
endfunction
function! CurrentLineInfo()
    let lineNumber = line('.')
    let [spaces, line] = GetSpacesAndLine(lineNumber)
    return {
        \'line': line,
        \'spaces': spaces,
        \'lineNumber': lineNumber,
    \}
endfunction
"ec empty(0)
"ec empty('')
"ec empty(1)
"ec empty([1])
"ec empty({'a':1})
"ec GetLines(7798)
function! GetCodeIndexes2(...)
    let i = a:0 >= 1 ? IndexGetter(a:1) : line('.')
    let r = a:1 >= 2 ? a:2 : '\w+'
    let a = SearchForTerm(r, i, 'namen')
    let b = SearchForTerm(g:blockEndRE, a + 1, 'n')
    if &filetype == 'python'
        let b -= 1
    endif
    return [a, b]
endfunction

function! FLI(r, ...)
    let flags = a:0 >= 1 ? a:1 : 'bnW'
    if a:r == '^ *$' && trim(getline('.')) == ''
        return line('.')
    elseif Exists(matchstr(getline('.'), a:r))
        return line('.')
    else
        return search(a:r, flags)
    endif
endfunction

function! SdelearchForTerm(search_term, start_line, end_line, case_sensitive, move_cursor, search_backward) abort

    let search_term = a:search_term
    let start_line = a:start_line
    let end_line = a:end_line
    let case_sensitive = a:case_sensitive
    let move_cursor = a:move_cursor
    let search_backward = a:search_backward

  "if a:move_cursor
    "execute start_line
  "endif

  let search_pattern = escape(a:search_term, '/')
  if !a:case_sensitive
    let search_pattern = "\\c" . search_pattern
  endif

  let search_range = start_line . "," . end_line
  let search_command = search_range . "/^" . search_pattern . "\\>"
  if a:search_backward
    let search_command = search_range . "?^" . search_pattern . "\\>"
  endif

  if a:move_cursor
    execute search_command
  else
    ec search_pattern
    return search(search_pattern, a:search_backward ? "b" : "n", search_range)
  endif
endfunction

function! SearchForTerm(...) abort

    let r = a:0 >= 1 ? a:1 : '"var foo'
    let start = a:0 >= 2 ? a:2 == 0 ? 1 : IsNumber(a:2) ? a:2 : line(a:2) : line('.')
    let flags = a:0 >= 3 ? a:3 : 'nW'

    " n = no move ... otherwise it will move
    " W = no wrap
    " b = backwards
    " s = set cursor
    " c = case sensitive


    let [flags, debug] = MGet(flags, 'debug')
    let [flags, name] = MGet(flags, 'name')
    let [flags, move] = MGet(flags, 'm') " IGNORE
    let [flags, wrap] = MGet(flags, 'w')
    let [flags, case] = MGet(flags, 'c')
    let [flags, limit] = MGet(flags, '\d+')

    if empty(limit)
        let limit = 1000
    endif

    if empty(wrap)
        let flags .= 'W'
    endif

    let prefix = '\v'
    if !empty(case)
        let prefix .= '\C'
    endif

    if !empty(name)
        let prefix .= g:bindingPrefixRE
    endif
    let backwards = Test(flags, 'b')
    let stopline= backwards ? max([start - limit, 1]) : min([start + limit, line('$')])
    let timeout = 1000

    let originalIndex = line('.')
    if originalIndex != start
        "ec ' moving the cursor '
        call Cursor(start)
    endif
    let regex = prefix . r

    let args = {
        \'flags': flags,
        \'debug': debug,
        \'name': name,
        \'moveAtStart': move,
        \'wrap': wrap,
        \'case': case,
        \'limit': limit,
        \'start': start,
        \'backwards': backwards,
        \'stopline': stopline,
        \'regex': regex,
    \}
    "if Exists(debug)
    "endif

    let result = search(regex, flags, stopline, timeout)



    if originalIndex != start && Test(flags, 'n')
        call Cursor(originalIndex)
    endif

    if empty(result)
        ec DictToString(args)
        throw 'no result'
        return 'Result: NO MATCH @ SearchForTerm'
    else
        return result
        " @bookmark 1680870485 Result
        return 'Result: MATCHED @ SearchForTerm: ' . result . "\n" . 'Value: ' . getline(result)
        return result
    endif
endfunction



function! FoXoo()
    
endfunction

function! DictToString(dict) abort
  let result = ''
  for [key, value] in items(a:dict)
    let result .= key . ' : ' . (empty(value) ? 'False' : value) . "\n"
  endfor
  return result
endfunction


"useful let m = filter(copy(a:m), '!empty(v:val)')

function! Xa()
    
endfunction
function! Fooooo()



    return SearchForTerm('x\w+', 7972, 'debugnamebn')
endfunction
function! Boxx()
    
endfunction
function! Foxxx()
    
endfunction
" @bookmark 1680870485 Result
" SaveBackup0104
    "return SearchForTerm('xx\w+', '.', 'n')


function! GetMarkdownWords()
    let lines = GetLines(GI3('window'))
    let r = '[a-zA-Z]{5,}'
    let words = Unique(FindallStrings(lines, r))
    return words
    
endfunction
function! WordSpiral(s)
    let currentIndex = line('.')
    let wmin = line('w0')
    let wmax = line('w$')

    let lower_limit = 15 " lower is relative to the screen.
    let upper_limit = 15

    "30 means we want to sprawl ^ ^ ^ beyond wmin.

    if currentIndex - wmin < 5 
        
        "We are at the top of the screen. 
        "We want to sprawl downwards.
        "We should not look up too much.
        "We should look down very much
        "Therefore lower is capped to wmin

        let lower_limit = 5
        let upper_limit = 30
    elseif wmax - currentIndex < 3
        let lower_limit = 30 " Go 30 beyond wmin
        let upper_limit = 10
        let upper_limit = 0
    endif

    let start = max([wmin - lower_limit, 1])
    let end = min([wmax + upper_limit, line('$')])
    let upper_count = end - currentIndex
    let lower_count = currentIndex - start

    let s = a:s
    
    "let spiralRE1 = WordSpiralRE1(s)
    let spiralRE1 = WordSpiralRE3(s)
    let value =  WordSpiralRunner([lower_count, upper_count], spiralRE1, k)
    if !empty(value)
        return value
    endif
    let spiralRE2 = WordSpiralRE2(s)
    let value =  WordSpiralRunner([lower_count, upper_count], spiralRE2, k)
    if !empty(value)
        return value
    endif

    ec ['start:', start, 'end:', end, 'lower:', lower_count, 'upper:', upper_count, 'limit', limit]
    throw 'no match at wordspiral'
endfunction

function! WordSpiralRunner(indexes, r) abort
    let indexes = a:indexes
    let r = a:r
    let a = line('.') - 1
    let increment = 1
    let c = 0
    let dir = 1
    let [upper_count, lower_count] =  indexes
    let limit = lower_count + upper_count

    while 1
        if upper_count == 0
            let a += -1
        elseif IsEven(c)
            let dir = -1
            let a += c * dir
        else
            let dir = 1
            let upper_count -= 1
            let a += c * dir
        endif
        
        let s = getline(a)
        let m = Match(s, r)
        if Exists(m)
            return m
        endif

        let c += 1
        if c == limit
            break
        endif
    endwhile
    "ec ['start:', start, 'end:', end, 'lower:', lower_count, 'upper:', upper_count, 'limit', limit]
    "throw 'no match at wordspiral'
endfunction
function! WordSpiralRE2(s)
    let s = a:s
    let r = '\C' . '<' . a:s . '\w{3,}' . '>'
    return r
endfunction

function! WordSpiralRE1(s)
    let s = a:s
    let items = Split(s, '')
    let r = '\C<'
    let c = 0
    let delimiterEnd = '[a-zA-Z]+'
    let delimiter = '[a-zA-Z]{1,}'
    let delimiter = '([A-Z]+|[A-Z]*[a-z]{1,})'
    let endDelimiter = '([A-Z0-9]+|[A-Z]*[0-9a-z]+)'
    let connectingSymbols = '[-\._\[\]\{\}\(\)]\$?'
    "let connectingSymbols = '[-]'
    for item in items
        let c += 1
        if c == 1
            let r .= Parens(item . '|' . Capitalize(item))
        else
            let r .= Parens(Capitalize(item) . '|' . connectingSymbols . RDouble(item))
        endif
        if c == len(items)
            let r .= endDelimiter . '>'
        else
            let r .= delimiter
        endif
    endfor

    return r

    let r = 'hi'
    "ec items
    "call RTest(r, 'howdy', 'howdyHam', 'howdyIce', 'howdyIcebergFoo')
endfunction
function! RTest(r, ...)
    let s:r = a:r
    function! Inner(i, s, ...)
        return [a:s, Test(a:s, s:r)]
    endfunction
    let values =  map(copy(a:000), function('Inner'))
    ec 'Regex: ' . a:r
    ec values
endfunction
" 04-07-2023

" 04-07-2023
function! GetNewFiles(dir_path)
  let today = strftime('%Y-%m-%d')
  let command_output = system('find ' . a:dir_path . ' -type f -newermt ' . today)

  let new_files = split(command_output, '\n')
  return new_files
endfunction

"let new_files = GetNewFiles(dir_path)
"ec new_files

function! Annotate(a, message)
    let a = a:a
    let message = a:message
    call insert(a, DateStamp() . message)
    return a
    
endfunction
"call AppendFile('files.txt', Annotate(GetNewFiles(g:dir2023), 'New Files'))


function! GitWordDiff()
  let filename = expand('%')
  let gitdiff = system('git diff --word-diff '.shellescape(filename))
  call AppendFile('diff.txt', gitdiff)
endfunction
" 04-08-2023
function! InoremapTestMode()
    let g:globalState = {}
    nunmap <buffer> 1
    let g:globalState['inoremapTestMode'] = 1

    let cmds = [
        \"iab <buffer> buf <buffer>",
        \"iab <buffer> exp <expr>",
        \"iab ino inoremap",
        \"iab no nnoremap",
        \"iab eab inoreab",
    \]
    call ExecuteCommands(cmds)
    ec 'setting inoremapTestMode'
endfunction
function! CleanerMode(file)
    let file = NormalizePath3(a:file)
    let g:globalState['cleanerMode'] = 1
    let g:globalState['file'] = file
    execute "cnoremap d ^def"
    execute "cnoremap c ^class"
    execute "cnoremap f ^fun"
    ec 'cleaner destination: ' . file
endfunction
function! GetFilesFromVisibleWindow()
    let r = '[0-9a-z-_./]+\.(json|js|md|py|txt|html|css|pdf|jpg|png|svg|vim)'
    let files = GetWindowWords(r)
    return Unique(files)
endfunction
function! FilePrompt(...)
    let message = a:0 >= 1 ? a:1 : 0
    if Exists(message)
        return FilePrompter(message, 0)
    else 
        let files = GetFilesFromVisibleWindow()
        if empty(files)
            return FilePrompter('FilePrompt:', 0)
        endif
        let file = Choose(files)
        if IsFile(file)
            return file
        else
            return FilePrompter('FilePrompt:', 0)
        endif
    endif
endfunction
function! FilePrompter(message, c) abort
    let message = a:message
    let c = a:c
    let input = Prompt(message)
    if empty(input)
        return input
    endif
    let file = FileGetter2(input)
    if !IsFile(file)
        let file = NBackslash(input)
    endif
    if !IsFile(file)
        return FilePrompter(message, c + 1)
    endif
    return file
endfunction

function! Stop()

    if !empty(get(g:globalState, 'inoremapTestMode'))
        let g:globalState.inoremapTestMode = 0
        call Unmap('buf exp ino no eab')
        ec 'closing inoremapTestMode'
    elseif !empty(get(g:globalState, 'cleanerMode'))
        let g:globalState.cleanerMode = 0
        ec 'closing cleanerMode'
        execute "cunmap d"
        execute "cunmap c"
        execute "cunmap f"
    elseif !empty(get(g:globalState, 'nodeArgModeCommands'))
        call Unmap2(g:globalState['nodeArgModeCommands'])
        let g:globalState['nodeArgModeCommands'] = 0
    elseif exists('b:mappings')
        call Unmap()
    else
        ec 'everything is clean. nothing to call Stop() for.'
    endif

endfunction
function! Unmap2(cmds)
    function! Inner(i, s)

        let s:mapping = ''
        let s:buffer = ''
        let s:key = ''

        let parts = copy(split(a:s))
        call map(parts, function('InnerInner'))

        let s = g:unmapdict[s:mapping]
        let s .= ' ' . s:buffer
        let s .= ' ' . s:key
        try
            execute s
        catch
            let error = v:exception
            ec error
        endtry
        return s
    endfunction
    function! InnerInner(i, s) abort
        let i = a:i
        let s = a:s
        if i == 0
            let s:mapping = s
        elseif Test(s, '^\<buffer')
            let s:buffer = ' ' . s . ' '
        elseif Test(s, '^\<')
            return 
        elseif s:key == ''
            let s:key = s
        endif
    endfunction
    call map(copy(cmds), function('Inner'))
endfunction
function! Mk2023()
        " Get the name of the current file
    let l:current_file = expand('%:p')
    let l:destination_dir = g:drivedir . 'UNORGANIZED-TEXTS'
    if !isdirectory(l:destination_dir)
        call mkdir(l:destination_dir, "p")
    endif
    let l:destination_file = l:destination_dir . '/' . expand('%:t')
    call system("cp " . shellescape(l:current_file) . " " . shellescape(l:destination_file))
    call ClearFile(l:current_file)
    call append('$', l:destination_file)

endfunction
"/mnt/chromeos/GoogleDrive/MyDrive/UNORGANIZED-TEXTS/b.js"
"/mnt/chromeos/GoogleDrive/MyDrive/UNORGANIZED-TEXTS/changelog.md"
"function VisualMakeArray3(state)
    "let state = a:state
    "let name =
    "let l1 =  Jspy('const') . state.arg . ' = ['
    "let lines = map(state.lines, '"    " . RegistrarTemplater(v:val, ")')
    "let middle = Parser233Array(lines, key, v:val)')
    "let l2 =  ']'
"endfunction


function! Spaces(n)
    let n = a:n
    if n <= 1
        return ''
        let n =  0
    endif
    return repeat(' ', n)
endfunction
function! ILS()
    let i = line('.')    
    let s = getline(i)
    let spaces = match(s, '\S')
    return [i, s, spaces, col('.')]
endfunction
function! SetCursorAtDedent()
    let [i, line, spaces, col] = ILS()
    let s = Spaces(spaces - 4)
    ec [i, s]
    call append(i, s)
    call cursor(i + 1, 100)
    return 

        "asfasdf
    

    return 
    try
        "let ti = SearchForTerm('^\s*$')
        "ec [ti]
        "ec [{'ti', ti, 's': s}]
        "return
        let s = Spaces(spaces - 4) . ''
        call append(ti - 1, s)
        call cursor(ti, 100)

    catch
        call append(i, '')
    endtry



endfunction







function! SmartBrace()
    let [i, line, spaces, ch] = ILS()
    if ch < len(line) - 3
        return '['
    elseif Test(line, '\= *$')
        return '['
    else
        return "[]\<LEFT>"
    endif
endfunction
function! Unmap(...)
    let s = a:0 >= 1 ? a:1 : ''
    function! Inner1(i, s)
        echo [a:i, a:s]
        let items = Split(a:s, ' ')
        let [a,b] = [items[0], items[1]]
        return Bufferize(dict[a] . ' ' . b)
    endfunction

    if empty(s)
        try
            let items = map(b:mappings, function('Inner1'))
            try
                call ExecuteCommands(items)
                unlet b:mappings
            catch
                let error = v:exception
            endtry
        catch
            let error = v:exception
            echo 'hmm ...maybe b:mappings dont work'
            echo error
            return 
        endtry
    endif

    let words = FindallStrings(s, '\w+')
    function! Inner(i, s)
        let t = RegistrarTemplater('iunmap <buffer> $1', a:s)
        try
            execute t
            ec 'success: ' . t
        catch
        endtry
        let t = RegistrarTemplater('iunabbrev <buffer> $1', a:s)
        try
            execute t
            ec 'success: ' . t
        catch
        endtry
        return t
    endfunction
    ec map(words, function('Inner'))
endfunction
function! ExecuteCommands(s, ...)
    let s:bufferize = a:0 >= 1 ? a:1 : 0
    function! Inner(i, t)
        "let t =  empty(s:bufferize) ? a:t : function('Bufferize')(a:t)
        let t =  empty(s:bufferize) ? a:t : Bufferize(a:t)
        try
            execute t
            ec 'success: ' . t
        catch
        endtry
    endfunction
    call map(a:s, function('Inner'))
endfunction

function! GetGlobals()
    let gvars = {}
    for key in getq(all) | keys | filter('v:val =~ "^g:"') | sort()
        let gvars[key] = get(key)
    endfor

    let json_str = json_encode(gvars)
    call writefile([json_str], 'vim.globals.json')
endfunction

function! CloseBuffer(...)
    let buffer = a:0 >= 1 ? a:1 : '%'
    let name = IsStringNumber(buffer) ? bufname(str2nr(buffer)) : buffer
    try
        execute "bd " . name
    catch
        let error = v:exception
        if line('$') < 2
            "ec 'force close'
            execute "bd! " . name
        else
            throw 'Need To Save the Buffer before closing'
        endif
        
    endtry
endfunction


" 04-09-2023
" @bookmark 1681028482 VisualCreateMappings
function! VisualCreateMappings(state)
    let state = a:state
    " The highlighted Block will be given inoreab

    let template = g:RegistrarDict[state.arg]
    let items = Uncomment(state.lines)
    let items = map(items, 'SplitOnce(v:val)')
    let commands = MapTemplater(items, template)
    let b:mappings = copy(commands)

    "xaila b

    call ExecuteCommands(commands, 'bufferize')
    return Comment(state.lines)
endfunction

        let g:RegistrarDict = {
            \'c': "cnoreab $1 $2 <C-R>=Eatchar('\\s')<CR>",
            \'n': 'nnoremap $1 :call $2()<CR>',
            \'i': 'inoremap $1 <esc>:call $2()<CR>',
            \'asdfeat': "inoreab $1 $2<C-R>=Eatchar('\\s')<CR>",
            \'eat': "inoreab <buffer> $1 $2<C-R>=Eatchar('\\s')<CR>",
            \'iab': 'inoreab $1 $2',
            \'imap': 'inoremap $1 $2 ',
            \'ldr': 'let g:ldrdict["$1"] = "$2"',
            \'js': 'let g:pydict["$1"] = "$2"',
            \'py': 'let g:pythonsnippets["$1"] = "$2"',
            \'vim': 'let g:wpsnippets["vim"]["$1"] = "$2"',
            \'css': 'let g:wpsnippets["css"]["$1"] = "$2"',
            \'html': 'let g:wpsnippets["html"]["$1"] = "$2"',
            \'exec': 'let g:execRef["$1"] = "call $2()"',
            \'python': 'env.basepyref["$1"] = "$2"',
        \}
"let g:visualactiondict['var'] = {'fn': 'VisualVar', 'i': 'nospaces-nobraces', 'arg': 'eat', 'replace': 1}

function! MapTemplater(s, template)
    return map(copy(a:s), 'RegistrarTemplater(a:template, v:val)')
endfunction

function! CommentUncomment()
    
endfunction




function! Bufferize(line)
    let line = a:line
    if !Test(line, 'ec ')
        let line = Replace(line, ' ', ' <buffer> ')
    endif
    return line
endfunction
" @bookmark 1681028482 VisualCreateMappings

function! InitTabbings()
  if v:lnum == 1 && !exists('b:tabbings')
      return 
    let b:tabbings = []
    echo "initializing b:tabbings for: " . expand('%:t')
  endif
endfunction


" 04-09-2023
"
" 04-09-2023
"let g:t1 = {}
"let gchild = {'a' : 1}
"let g:t2 = gchild
"
"

function! GitPushCurrentFile(commit_msg)
  let l:file_name = expand('%:p') " Get the full path of the current file
  let l:git_cmd = 'git -C ' . shellescape(fnameescape(fnamemodify(l:file_name, ':h'))) . ' ' " Change to the directory where the file is located

  " Stage the current file for commit, commit the changes, and push the changes to the remote repository
  let l:commit_cmd = l:git_cmd . 'add ' . shellescape(fnamemodify(l:file_name, ':t')) . ' && ' . l:git_cmd . 'commit -m ' . shellescape(a:commit_msg) . ' && ' . l:git_cmd . 'push'
  call system(l:commit_cmd)
  ec 'pushed to git via c-s'
endfunction

" 04-09-2023
"

function! ListJsonsAndAppendToFooBar()
  function! Inner(i, s)
      let s = a:s
      let mtime = strftime('%m-%d-%Y', getftime(s))
      let name = Tail(s)
      return mtime . '   ' . name    
  endfunction

  let dir = g:dir2023
  let jsons = globpath(dir, '*.js', 0, 1)
  if len(jsons) < 1
        ec 'no jsons in dir'
        return 
  endif

  let values = map(SortFilesByDate(jsons), function('Inner'))
  call SplitTheWindowAndAppend(values)
endfunction

function! SplitTheWindowAndAppend(values)
  let values = a:values
  execute 'vsplit foobar.txt'
  execute 'normal! G'
  call append('.', DateStamp())
  call append('.', '')
  call append('.', values)
  "foobar.txt"
endfunction

function! GetFilepathComponents(s) abort
  let s = a:s
  "let s = CurrentLine()
  let s = "//home/vim.js"
  let pattern = '\v[''": ]?\zs/?(\w+/)*(\w+(\.\w+)*)\.(txt|js|json|md)$'
  let s = Match(s, pattern)
  return s

  ec 'aa'
  return matchlist(s, pattern)
  ec list
  ec 'hiii'
  return list
  if match(s, pattern) != -1
    let head = substitute(matchstr(s, pattern), '\.\w\+$', '', '')
    let tail = matchstr(s, pattern, 2)
    let ext = matchstr(s, pattern, 4)
    return [head, tail, ext]
  else
    return []
  endif
endfunction

function! SortFilesByDate(files)
    let files = a:files
  let file_times = map(copy(files), 'getftime(v:val)')

  function CompareFileTimes(a, b)
    return a:a > a:b
  endfunction

  " Sort the files by modification time
  let sorted_files = sort(file_times, 'CompareFileTimes')

  " Remove the modification time from the sorted list
  let result = map(sorted_files, 'substitute(v:val, "\\v^\\d+\\s", "", "")')

  " Return the sorted list of files
  return result
endfunction

" 04-09-2023

function! NodeArgMode()
    ec 'starting node arg mode'
  let key_commands = [        
        \['1', ':echo "Hello"<CR>'],
        \['2', ':echo "World"<CR>'],
        \['3', ':echo "Vim"<CR>'],
  \]

  let commands = [1,2,3]
  let template = "nnoremap <buffer> $1 :w<CR>:call RunJS($1)<CR>"
  let commands = MapTemplater(commands, template)
  let g:globalState['nodeArgModeCommands'] = commands

  for mapping in commands 
    try
        execute mapping
    catch
        let error = v:exception
        ec error . ' ::: '
    endtry
  endfor
endfunction
function! JS(x)
    return GetExtension(a:x) == 'js'
endfunction
function! RunJS(...)
    let file = CurrentFile()
    if !JS(file)
        return
    endif
    let base = ['!clear;node', file]
    let items = extend(base, copy(a:000))
    let cmd = join(items, " ")
    ec cmd
    execute cmd
endfunction

        let g:unmapdict = {
            \'inoreab': 'iunabbrev',
            \'iab': 'iunabbrev',
            \'inoremap': 'iunmap',
            \'nnoremap': 'nunmap',
            \'cnoremap': 'cunmap',
        \}
function! AddSnippetItem()
    let line = CurrentLine()
    let lang = GetLang()
    let m = Match(line, g:bindingAnywhereRE)
endfunction

function! FindFiles(arg)
    let arg = a:arg
    let q =  '*' . arg . '*'
    let files = globpath(g:dir2023, q, 1, 1)
    if Exists(files)
        call AppendFile(g:ftfile, files)
        call OpenBuffer3(g:ftfile)
    else
        ec 'no files found'
    endif
    "call SplitTheWindowAndAppend(files)
endfunction
" 04-10-2023

   "c \   "c":  "

"let g:pydict['c'] = "class $0 {\n    constructor($1) {\n    }",

function! TestVimFunction()

endfunction
function! IsDir(s)
    return isdirectory(expand(a:s))
endfunction

function! DownloadSupertab()
    let url =  Prompt('url')
    let url = Replace(url, 'github', 'raw.githubusercontent')
    let url = Replace(url, 'blob/', '')
    let ref = 'https://raw.githubusercontent.com/ervandew/supertab/master/plugin/supertab.vim'
    if url != ref
        ec "\n"
        ec "\n"
        ec url
        ec ref
        ec "\n"
        ec "\n"
        return 
    endif
    ec 'going'
    let local_file = expand('~/.vim/plugin/supertab.vim')
    try
        execute '!curl ' . url . ' -o ' . local_file
    catch
        let error = v:exception
        
    endtry
    if filereadable(local_file)
        echo "Supertab.vim downloaded successfully!"
    else
        echoerr "Error downloading supertab.vim"
    endif
endfunction

" The things that I am doing wrong ...
" The goal 
" It is as close as you will find. 
" That we are far different. "
" Teach math / computer science on the weekends. "

function! VisualBTB(state)
    let state = a:state
    if state.arg == 'm'
        let s = extend(state.lines, ['----------------------------'])
        call AppendFile('math.singletons.txt', s)
    else
        call Python2('block_to_browser', state.string, state.arg)
    endif
endfunction


function! AutoTabWordCollection(key)
    let key = a:key
    "let key =  'at'
    let s:key = key
    let lines = getline(line('w0')-30,line('w$') + 10)
    let text = join(lines, "\n")
    let r = '\C(\w\w+\d*[a-z][A-Z]\w*)+|(\w+_)+\w+'
    let words = Unique(FindallStrings(text, r))
    function! Inner(i, s) abort
        let s = a:s
        let abrev = Abrev(s)
        let r =  '^' . s:key
        let score1 =  len(Match(abrev, r))
        let score2 =  len(Match(s, r))
        let score = max([score1, score2])
        ec [abrev, score, s:key]
        return [s, score]
    endfunction
    "at_the_store
    let mapped = map(words, function('Inner'))
    "ec mapped
    let results = filter(sort(mapped, {a,b -> b[1] - a[1]}), 'v:val[1] > 0')

    "ec results
    if len(mapped) == 0 || mapped[0][1] == 0
        return 
    else
        let words = map(results, 'v:val[0]')
        let word = Choose(words)

        if Test(text, word . '\(')
            return word . "()\<LEFT>"
        else
            return word
        endif
    endif
endfunction
"let g:pydict["at"] = "${TimestampedBookmark($1)}"
" 04-11-2023
function! ExportVarToJavascript(...)
    let key = a:0 >= 1 ? a:1 : 'filedict'
    let item = eval('g:' . key)
    "let escaped = ShellEscape(Stringify(item))
    call WriteJson('vim.temp.json', item)
endfunction

" 04-11-2023
"t()

function! CheckMode()
    ec g:globalState
    ec CaptureMap('nmap')
endfunction
function! DoneWithModes()
    let g:globalState = {}
    ec 'done with modes'
    ec 'returning to normal node1'
endfunction
function! SetGState(k, v)
    let k = a:k
    let v = a:v
    if has_key(g:globalState, k)
        return g:globalState[k]
    endif

    if v == 'FilePrompt'
        let v = FilePrompt()
    endif
    let g:globalState[k] = v
    return v
endfunction
function! CopyMode()
    let v = SetGState('copy_mode_file', 'FilePrompt')
    call AppendFile(v, GetCodeBlock())
endfunction

function! CaptureMap(mapKey)
    let mapKey = a:mapKey
    let map_output = execute(mapKey)
    let map_lines = split(map_output, '\n')
    let mapping_dict = {}
    for line in map_lines
      " Skip any empty lines or lines that don't contain mappings
      if line == '' || line[0] == '"' || line =~ '^\s*$'
        continue
      endif
      let parts = split(line)
    
      " Extract the mode, mapping keys, and command
      let mode = parts[0]
      let keys = parts[1]
      let command = join(parts[2:])
    
      " Add the mapping to the dictionary
      let mapping_dict[keys] = command
    endfor
    
    return mapping_dict
endfunction

function! DeleteInnerBlock()
    let indexes = GI3('innerblock')
    return indexes
endfunction
" 04-12-2023
"
"worksheet-components-2.js
" code.txt is a rough draft.
" 04-12-2023
function! ServerTestMode()
    
endfunction
function! ListDirectory()
  let curdir = expand('%:p:h')
  execute "!ls " . curdir
endfunction

" 04-13-2023
" 04-13-2023
" 04-14-2023
function! FooName()
    return 'foo' . strftime('%s')
endfunction
function! VisualWrapAboveBelow(state) abort
    let state = a:state
    let lines = Indent(state.lines)
    "if empty(state.arg)
        "throw 'todo'
        "call SimplePySnippet('emptyfunction2')
    "else
        let arg = empty(state.arg) ? FooName() : state.arg
        let s = RegistrarTemplater('function $1() {', arg)
        call add(lines, '}')
        " should be changed to jspy versions
        call insert(lines, s)
        return lines
    "endif
endfunction


function! PushFilesToGit()
    cd /home/kdog3682/Resources2023/
    let gitcmd = 'git add . & git commit -m "commit" & git push'
    let s = system(gitcmd)
    ec 'success at /home/kdog3682/Resources2023/'
    ec s

    cd /home/kdog3682/2023/
    let gitcmd = 'git add . & git commit -m "commit" & git push'
    let s = system(gitcmd)
    ec 'success at /home/kdog3682/2023/'
    ec s
endfunction
" 04-14-2023
" 04-14-2023
" 04-15-2023
function! EscapeString(s)
    let s = a:s
    let s = Sub(s, '"', '\\"')
    let s = Sub(s, "\n", '\\n')
    return s
    
endfunction
function! SmartDedent2(s) abort
    let s = a:s
    if IsArray(s)
        let f = 'Replace(v:val, "^" . spaces, "")'
        let spaces = GetSpaces(s[0])
        let t = map(s, f)
        return t
    endif
    let spaces = GetSpaces(s)
    let f = 'Replace(v:val, "^" . spaces, "")'
    let s = join(map(ToLines(s), f), "\n")
    return s
endfunction
function! SnippetConverter(s)
    let s = a:s
    let s = SmartDedent2(s)
    let s = Sub(s, '\d+-\d+-\d+', '${DateStamp()}')
    let s = Sub(s, '\d{8,}', "${strftime('%s')}")
    if Test(s, "\n") && !Test(s, '\s$')
        if !Test(s, '\$c')
            let s .= "$c"
            let s .= "\n"
        endif
    endif
    return s
endfunction
function! VisualMakePyDict(state) abort
    let state = a:state
    let s = state.string
    let arg = get(state, 'arg')
    if empty(arg)
        let arg = Prompt('arg name?')
    endif
    let raw = EscapeString(SnippetConverter(s))
    let expr = AddPydictItem([arg, raw], state.mode)
    return expr

endfunction


function! Bodk()

    "call VisualAction('mkpy aaxxx')
endfunction
"let g:wpsnippets["vim"]["asdf"] = "\"aaa\nhi"
"function SetFastFileShortcut()
    "execute "nnoremap <buffer>
"endfunction

function! AppendLineStart()
    function! Inner(s)
        let s =  N2char(g:letter_index)
        let g:letter_index += 1
        let letters = repeat(s, 1)
        let line = a:s
        return 'let ' . letters . ' = ' . line
    endfunction
    call GetSetFn("Inner")
endfunction
function! N2char(i)
    return tolower(nr2char(a:i + 65))
endfunction
function! CheckExec(s)
    ec get(g:execRef, a:s, 'None')
endfunction
function! RegistrarTemplater2(key, args)
    let key = a:key
    let args = a:args
    return RegistrarTemplater(g:registrarDict[key], args)
endfunction

function! RegisterEat2()
     let word = GPTGetCurrentWord()
     let s = RegistrarTemplater2('eat', [name, word])
     try
         execute s
         InvivoAppend('eat.txt', s)
     catch
         let error = v:exception
         
     endtry
endfunction


function! InvivoAppend(file, line)
    let file = a:file
    "let file =  Redirect(file)
  if filereadable(file)
    let buf = bufnr(file)
  else
    let buf = bufadd(file)
  endif
  call appendbufline(buf, -1, a:line)
  ec 'success: ' . a:line 
endfunction

function! Redirect(file)
    return a:file
    let file = a:file
    if GetExtension(file) ==  'txt'
        return g:resourcedir . Tail(file)
    endif
    return file
endfunction
" 04-16-2023


function! VisualExec(state)
    let state = a:state
    let s = state.string
    call Exec3(s)
endfunction
function! AlignAssignments ()
    " cool function but doesnt work that well
    let ASSIGN_OP   = '[-+*/%|&]\?=\@<!=[=~]\@!'
    let ASSIGN_LINE = '^\(.\{-}\)\s*\(' . ASSIGN_OP . '\)\(.*\)$'
    let [firstline, lastline] = GetIndexesHelper2('same-indent-no-breaks')

    " Decompose lines at assignment operators...
    let lines = []
    for linetext in getline(firstline, lastline)
        let fields = matchlist(linetext, ASSIGN_LINE)
        if len(fields)
            let d = {'lval':fields[1], 'op':fields[2], 'rval':fields[3]}
            call add(lines, d)
        else
            call add(lines, {'text':linetext,  'op':''})
        endif
    endfor

    " Determine maximal lengths of lvalue and operator...
    let op_lines = filter(copy(lines),'!empty(v:val.op)')
    let max_lval = max( map(copy(op_lines), 'strlen(v:val.lval)') ) + 1
    let max_op   = max( map(copy(op_lines), 'strlen(v:val.op)'  ) )

    " Recompose lines with operators at the maximum length...
    let linenum = firstline
    for line in lines
        let newline = empty(line.op)
        \ ? line.text
        \ : printf("%-*s%*s%s", max_lval, line.lval, max_op, line.op, line.rval)
        call setline(linenum, newline)
        let linenum += 1
    endfor
endfunction
" 04-16-2023
"

function! FindMarkIndex(start)
    let m = FindLineIndex('/\* *mark *\*/', a:start, 1)
    return m
endfunction

function! LineComment(s)
    let s = a:s
    if Test(s, '^ */')
        return s
    else
        return '// ' . s
    endif
endfunction
" adsfasdf
function! Guotie()
    let r1 = '^(//|\w+(\.\w+)*\().+'
    let start = max([line('.') - 500, 1])
    let lines = GrabBetween(start, line('$'), r1)
    call AppendFile('today.guotie.js', map(lines, 'LineComment(v:val)'))
    ec 'guotie.today.js of ' . len(lines) . ' lines'
endfunction

function! Assertion(value, check)
    let value = a:value
    let Check = a:check
    if !FunctionGetter(Check)(value) 
        call Throw('%s did not meet the checkpoint: %s', value, Check)
    endif

endfunction

function! Throw(...) abort
    throw call(function('printf'), a:000)
endfunction
" 04-17-2023
function! GatherVariablesFromPage(key)
    let key = a:key
    let start = 0
    let end = '$'
    let r = ''

    if key == 'payload'
        let [start, end] = GetCodeIndexes()
        let r = 'const \zs\w+'
    else
        let [key, dir] = MGet(key, '[$^]')
        let r = key
        if Exists(dir)
            if dir == '$'
                let r = '\w*' . key . '>'
            else
                let r = key . '\w*'
            endif
        endif
        let r = g:bindingPrefixRE . r
    endif

    let items = FindMatches(r, start, end)
    call insert(items, key, 0)
    return join(GSTSO(items), "\n")
endfunction


function! FindMatches(r, rangeStart, rangeEnd)
    let r = a:r
    let rangeStart = IndexGetter2(a:rangeStart)
    let rangeEnd = IndexGetter2(a:rangeEnd)
    let lines = getline(rangeStart, rangeEnd)
    let matches = filter(map(lines, 'Match(v:val, r)'), '!empty(v:val)')
    return matches
endfunction

function! FOotesting()
    return FindMatches('^function[!*]? \zs\w+', 'w0', '$')
endfunction


function! GotoGRefLine(key)
    let key = a:key
    let key = 'vaf'
    let aliases = {
        \'va': 'visualactiondict',
    \}

    let [key, parent] = MGet(key, 'va')
    let connect = '.{-}'
    let connect = '\['
    let parent = aliases[parent]
    let r = '(' . '''' . key . '''' . '|' . '"' . key . '"' . ')'
    let r = '^let g:' . parent . connect . r
    call search('\v' . r)
endfunction
function! TestGenMode()
  execute "nnoremap <buffer> <f3> :w<CR>:call RunServerFile('VSayhi')<CR>"
  execute "nnoremap <buffer> <f4> :w<CR>:call RunServerFile('VFlexRow')<CR>"
  execute "nnoremap <buffer> <f5> :w<CR>:call RunServerFile('VGuidedMultiplication')<CR>"
endfunction
" 04-18-2023
"
function! DeleteInner()
    return 
    let indexes = GI3('innerblock')
    call DeleteBlock(indexes)
endfunction
" 04-19-2023
"

function! LineGetter2(s)
    let s = a:s
    return IsNumber(s) || Test(s, '^[.$^\d]$')
        \ ? getline(IndexGetter2(s)) : s
endfunction

function! GSLC(...)
    let line = a:0 >= 1 ? LineGetter2(a:1) : getline('.')
    let spaces = match(line, '\S')
    let cursor = getpos('.')[2]
    return [repeat(' ', spaces), trim(line), cursor]
endfunction

function! CreateFunctionBlock2()
    let [spaces, line, cursor] = GSLC()
    if cursor < 4
        if line == ''
            call SimplePySnippet('emptyfunction')
        else
            call SimplePySnippet('function')
        endif
    elseif cursor < 8
        call SimplePySnippet('function')
    else
        call SimplePySnippet('function')
    endif
endfunction

function! MakePythonFunctionName(s)
    let s = a:s
    let items = split(s, ' ')
    let name = items[0]
    let args = []
    let c = 0
    for item in items[1:]
        if index(g:pyargs, item) >= 0
            let args = items[1 + c:]
            break
        endif
        let c += 1
        let name .= '_' . item
    endfor
        
    return name . '(' . join(args, ', ') . ')'

endfunction

function! Char()
    let line = CurrentLine()
    let column = virtcol('.')
    "ec column
    "let column = col('.')
    "ec column
    return line[column - 2]
endfunction
function! SPACE(n)
    let n = a:n
    return repeat("\<space>", n)
endfunction
function! Bok()
    let ch = Char()
    let space = ch == ' ' ? '' : SPACE(1)
    return space . "{\<CR>}\<UP>\<c-o>o"
endfunction
function! VisualLog(state)
    let state = a:state
    let s = 'Match(v:val, g:bindingInnerRE)'
    let filterstring = '!empty(v:val)'
    let words = filter(map(state.lines, s), filterstring)
    let output =  '    console.log({' . join(words, ',') . '})'
    call append(state.end, output)
endfunction
function! FooFunction()
    normal G
    put="\n\n\n\n"
    call PySnippet('emptyfunction2')
    normal ma
    normal G
    normal 'a
    startinsert
endfunction


function! GetGithubFile(url)
    let url = a:url
    "let url = "https://github.com/hrldcpr/poole/blob/master/_scripts/latex3d.py"
  " Extract the owner, repository, and path from the GitHub URL
  let parts = split(url, '/')
  let owner = parts[3]
  let repo = parts[4]
  let path = join(parts[7:], '/')
  let master = Test(url, 'master') ? 'master' : 'main'
  let buffer_name = substitute(path, '/', '_', 'g')
  let raw_url = printf('https://raw.githubusercontent.com/%s/%s/%s/%s', owner, repo, master, path)
  let testurl= 'https://raw.githubusercontent.com/hrldcpr/poole/master/_scripts/latex3d.py'
  let e = GetExtension(raw_url)
  let file =  parts[-1]
  let output = system('curl -s ' . shellescape(raw_url))
  let lines = split(output, "\n")
  if len(lines) < 10
      ec 'error'
      return 
  endif

  "if Test(file, 'min')
        "call AppendFile(file, lines)
        "return
  "endif

  call ChooseBuffer2('github.temp.js')
  if e == 'py'
      call insert(lines, 'from next import *')
      call insert(lines, 'from base import *')
  endif
  call setline(1, lines)
endfunction

function! DownloadAndOpen(url, file)
  let cmd = 'curl ' . a:url . ' -o ' . a:file
  call system(cmd)
  execute 'edit ' . a:file
  call SetLastTouchedFile(a:file)
endfunction

function! GitPushDir()
    let dir = expand("%:p:h")
    call Python2('git_push_dir', dir)
endfunction
function! PyEmptyFunction()
    let name = FooName()
    let file = expand('%:t')
    let label = Prompt('label for this function?')
    let ending = 'return'

    if file == 'appscript.js'
        ec 'aa'
        let name .= '()'
    else
        let name .= '()'
    endif

    let s = printf("\n\n\n\def %s:\n    \"\"\"\n        %s\n    \"\"\"\n     $c\n    %s\n\n\n", name, label, ending)
    return s
endfunction
function! JsEmptyFunction()
    let name = FooName()
    let file = expand('%:t')
    let label = ''
    let ending = 'return'

    if file == 'appscript.js'
        let name .= '()'
        let label = Prompt('What is the label for this function?')
        let ending = 'return Finish()'
        if Exists(label)
            let label = 'Purpose: ' . label
        else
            let label = ''
        endif
    else
        let name .= '(s)'
    endif
    let s = printf("\n\n\n\nfunction %s {\n    /* %s */\n     $c\n    %s\n}\n\n\n\n", name, label, ending)
    return s
endfunction

function! PipInstall(s)
    try
        execute "!pip3 install " . a:s
        let file = g:resourcedir . 'pip.txt'
        call AppendFile(file, a:s)
    catch
        ec 'error'
    endtry
endfunction

function! PipUnInstall(s)
    try
        execute "!pip3 uninstall " . a:s
        let file = g:resourcedir . 'pip.txt'
        call AppendFile(file, 'uninstall ' . a:s)
    catch
        ec 'error'
    endtry
endfunction
" Get the path to the pip executable using a shell command
"let p = systemlist('pip --version')
" Append the path to a file
"call append('$', p)

"Path to pip: /usr/bin/pip
"Path to pip: /usr/bin/pip3
function! GetMostRecentDownloadFile()
    return GetMostRecentFile('dldir')
endfunction
function! GetMostRecentFile(dir)
    let dir = DirGetter(a:dir)
    let file = trim(system('ls -t ' . shellescape(dir) . ' | head -n 1'))
    let value = PathJoin(dir, file)
    return value
endfunction

function! IsLetter(s)
    return Test(a:s, '^[a-z]$')
endfunction
function! ScreenWords(...)
    let screenKey = a:0 >= 1 ? a:1 : 'window2'
    let s = ToString(GetLines(GI3(screenKey)))
    let r = '((self|this)\.)?\zs[a-z][a-z0-9-.]{5,}'
    "let r = '((self|this)\.)?\zs[a-z0-9-]{5,}'
    return Unique(FindallStrings(s, r))
endfunction

function! LoadBackupAutocompletions(...)
    let f = GetMostRecentDownloadFile()
    let s = 'Test(v:val, ''\C[a-z][A-Z]'')'
    let data = filter(ReadJson(f), s)
    ec data
endfunction
function! ListCurrentDirectory()
  echo glob(expand('%:p:h') . '/*')
endfunction

" 04-24-2023
" story.md and changelog.md are the current stories
" the changelog story was extracted
" 04-25-2023




function! OpenGitFromLine(s)
    let s = a:s
    let r = '"from": "\zs\w{7}\ze"'
    let id = Match(s, r)
    let file = 0
    "from": "7ff6b07",
    "file": "css-utils.js",
    if Exists(id)
        let file = UpDownSearch('"file": "\zs\S{-}\ze"', 5)
    endif
    if Exists(file)
        let cmd = printf('git show %s', id)
        let newFile = 'gitshow.temp.' . GetExtension2(file)
        call OpenBuffer3(newFile)
        normal ggVGd
        let s = systemlist(cmd)
        call append(1, s)
        return 1
    endif
endfunction
function! UpDownSearch(r, c) abort
    let r = a:r
    let c = a:c
    let a = line('.')
    let dir = 1

    while 1
        let s = getline(a)
        let m = Match(s, r)
        if Exists(m)
            return m
        endif
        if c == 0
            let a += -1
        elseif IsEven(c)
            let dir = -1
            let a += c * dir
        else
            let dir = 1
            let a += c * dir
        endif
        
        let c += 1
        if c == 10
            throw 'error'
        endif
    endwhile
endfunction

function! GetExtension2(s)
    let s = a:s
    return Match(s, '\.\zs(js|py|html|vimrc|pdf|css)$')
endfunction
function! Paste2Buffer(...)
    let arg = a:0 >= 1 ? a:1 : 'text'
    let s = ToString(GetLines(GetCodeIndexes()))
    call Python2('block_to_browser', s, arg)
endfunction
"inoreab c2 chalk2()<LEFT><C-R>=Eatchar('\s')<CR>
":wa<CR>:call Node3()<CR>

"/* @bookmark 1682450081 ele */
" 04-26-2023
function! ReverseListSearch(items, Fn) abort
    let items = a:items
    let Fn = a:Fn
    for i in reverse(range(len(items)))
      if Exists(Fn(items[i]))
          return items[i]
      endif
    endfor
    throw 'no match'
endfunction
function! OpenGitTempFromJson()

    let s:file = Tail()
    function! Inner(s)
        let s = a:s
        let f = get(s, 'file', '')
        return f == s:file
    endfunction

    let json = ReadJson('git-data.json')

    let item = ReverseListSearch(json, function('Inner'))
    let id = item.id
    let cmd = printf('git show %s', id)
    ec cmd
    return 

    let newFile = 'gitshow.temp.' . GetExtension2(file)
    call OpenBuffer3(newFile)
    normal ggVGd
endfunction
function! EMark()
    let word = GetCurrentWord()
    ec 'emarking ' . word
    let s =  CurrentFile() . ' ' . word
    call AppendFile('emarks.txt', s)
    "deprecate
endfunction
" 04-27-2023
function! GitCheckout(file) abort
    let file = a:file
    if !IsFile(file)
        ec 'not a file'
        return 
    endif
    let cmd =  printf("git checkout %s", file)
    call Prompt(cmd, 'proceed?')
    let s = system(cmd)
    ec s
    return 
    return 
    return 
    return 
    return 
    "let file = CurrentFile()
    "let cmd = printf("!git show HEAD:%s > checkout.js", file)
    let file =  'chalk.js'
    let cmd = printf("clear; git log --follow %s", file)

    try
        let s =  system(cmd)
        let id = Match(s, 'commit \zs\w*')
        let cmd = printf('git show %s', id)
        let s =  system(cmd)
        ec s
        "call OpenBuffer3('checkout.js')
    catch
        let error = v:exception
        ec error
        
    endtry
endfunction
" 04-27-2023
" 04-28-2023
function! HelpfulDollar(s, template)
    let s = a:s
    let template = a:template
    let [spaces, line] = GetSpacesAndLine(s)
    let words = FindallStrings(line, '\w+')
    if !Exists(words)
        return s
    endif
    return spaces . RegistrarTemplater(template, words)
endfunction
function! VisualMatch(state)
    let state = a:state
    let word = GetCurrentWord()
    let arg = empty(state.arg) ? word . '[\"'']?(:|\=) *\zs\w+' : HelpfulDollarMatch(state.arg)
    let s = 'Match(v:val, arg)'
    let items = Filtered(map(copy(state.lines), s))
    let g:buffer_items = items
    ec items
    
endfunction
function! HelpfulDollarMatch(s)
     let s = a:s
     if s == '$'
         return '\w+'
     endif
         
     let s =  Rescape2023(s)
     let s =  Replace(s, '\\\$\d*', "\zs\w+")
     return s
endfunction
function! HelpfulObjectKeysToValue(s, arg)
    let s = a:s
    let arg = a:arg
     let arg =  Rescape2023(arg)
     let arg =  Replace(arg, '\\\$\d*', '(\\w+)')
     let r =  '\v' . arg
     let m = substitute(s, r, {s -> s[1]}, '')
     return m
endfunction

function! VR2(state)
    let state = a:state
    let s =  "HelpfulObjectKeysToValue(v:val, state.arg)"
    return map(copy(state.lines), s)
endfunction
function! VisualReplace(state)
    let state = a:state
    if Test(state.arg, '^!')
        let state.arg = state.arg[1:]
        return VR2(state)
    endif
    let s = "HelpfulDollar(v:val, state.arg)"
    return map(copy(state.lines), s)
endfunction
function! VisualRemove(state)
    let state = a:state
    "let state =  {'arg': '', 'lines': ['a<>b']}
    let s = "Sub(v:val, state.arg, '')"
    return map(copy(state.lines), s)
endfunction
" 04-29-2023
" 04-30-2023
function! VLetToConst(state)
    let state = a:state
    let s = "Replace(v:val, 'let ', 'const ')"
    return map(state.lines, s)
    
endfunction
" 04-30-2023
" 04-30-2023
" 05-01-2023
" 05-02-2023
function! BufferItemsFromTemplate(template)
    let template = a:template
    let f =  "RegistrarTemplater(template, v:val)"
    let s = map(copy(g:buffer_items), f)
    return join(s, "\n")
endfunction
" 05-02-2023
" 05-03-2023
"sdfsdfsdf
"sdfsdfsdf
"sdfsdfsdf
"sdfsdfsdf
"sdfsdfsdf
"sdfsdfsdf
" 05-04-2023
function! SetA8File(...)
    let f = a:0 >= 1 ? FileGetter2(a:1) : CurrentFile()
    let g:globalState['a8file'] = f
    ec 'setting a8file as current file: ' . f
endfunction
function! GlobalReplace2(s)
    let [a,b] = SplitOnce(a:s)
    execute "%substitute/\\v" . a . "/" . b . "/g"
endfunction
function! HtmlBuilderTest()
    let lines = GetLines(GI3('tilda'))
    call add(lines, '`)')
    call insert(lines, 'main(`')
    call OpenBuffer3('/home/kdog3682/2023/htmlBuilder.js')
    call append('$', lines)
    normal G
endfunction
" 05-04-2023
" 05-05-2023
function! RunVite()
    try
        execute "!npm run dev"
        "execute "!npm --prefix /home/kdog3682/2023/vite1 run dev"
    catch
        let error = v:exception
        ec ['ERROR', error]
    endtry
endfunction
" 05-06-2023 
"nnoremap qy

function! F()
    let b = Abspath(CurrentFile())
    ec b
endfunction
" outpath: css-data.cleaned.json
function! Qy()
    return "\<CR>\<bs>"
endfunction
    "inoremap qy <esc>:call Qy()<CR>

function! CheckBashVersion(s)
    execute "! " . a:s . " version"
endfunction
function! Rollup()
    call Node('rollup.js', CurrentFile())
endfunction
function! AppMkdir(s) abort
    let s =  g:resourcedir . a:s
    ec ' making dir: ' . s
    call mkdir(s)
endfunction
function! DeleteFile2(...)
    let file = a:0 >= 1 ? a:1 : expand('%')
    silent execute 'bdel! ' . file
    call delete(file)
    ec 'deleting the file: ' . file
    "execute "b! netrw"
    "execute "Explore " . g:resourcedir
endfunction
"nnoremap df :call DeleteFile2()<CR>
"function PostArticleToMarkDownDir(state)
    "let state = a:state
    "call AppendFile(g:markdowndir . file)
"endfunction
function! DebugTestRunner(s)
    let s = a:s
    if Test(s, 'debugTest')
      return Replace(s, 'debugTest\((.*)\)', {s -> s[1]})
    else
      return Replace(s, '\w+\((.*)\)', {s -> 'debugTest(' . s[0] . ')'})
    endif
endfunction

function! Dt()
    call GetSetFn('DebugTestRunner')
endfunction
function! Asadasd()
    call AppendFile(g:ftfile, GetCurrentBuffers())
endfunction

function! Asadasd()
    call AppendFile(g:ftfile, GetCurrentBuffers())
endfunction
function! PackageManager(key)
    if IsPy() && a:key == 'nodePrettier'
        return Black()
    endif

    let s:overrideFile = CurrentFile()
    let key = a:key
    let ref = g:packageManagerRef
    let cref = ref[key]
    let file = cref.file

    function! Inner(i, s)
        let s = a:s
        if s == 'prompt'
            return Prompt('')
        elseif s == 'cf'
            return s:overrideFile
        elseif s == 'identifier'
            return GetBindingName()
        elseif s == 'identifierAsFile'
            let e = GetExtension(s:overrideFile)
            return AddExtension(GetBindingName(), e)
        elseif s == 'cft'
            return Tail(s:overrideFile)
        else
            return s
        endif
    endfunction

    let args = map(copy(cref.args), function('Inner'))
    call Node(file, key, args)

endfunction
function! GetBindingName2(s)
    let s = a:s
    return Match(s, g:bindingPrefixRE . '\\w+')
endfunction

function! GetBindingNames()
    let lines = getline('^', '$')
    let s = "Match(v:val, g:bindingPrefixRE . '\\w+')"
    let results = MapFilter(lines, s)
    return results
endfunction
function! ExtensionFromDir(s)
    let head = Head(a:s)
    if head == '/'
        return 'js'
    endif
    let h = Tail(head)
    if Test(h, 'python')
        return 'py'
    else
        return 'js'
    endif
endfunction
function! AddExtension2(a, b)
    let a = a:a
    if empty(a)
        return ''
    endif
    let b = a:b
    if Test(a, '\.\w+$')
        return a
    else
        return a . '.' . b
    endif
endfunction
function! RenameSelf(newName)
  let currentName = expand('%')
    let newName = a:newName
    let newName = AddExtension(newName, ExtensionFromDir(currentName))
  let newPath = fnamemodify(currentName, ':h') . '/' . newName
  call Prompt(newPath, 'is this new path correct?')

  execute 'saveas ' . newPath
  execute 'bdelete ' . currentName
  execute 'file ' . newPath
  call delete(currentName)
endfunction
function! GitCheckoutFromGithub()
    let owner = 'kdog3682'
    let repo = '2023'
    let master = 'main'
    let file = Tail()
    let s = printf('https://raw.githubusercontent.com/%s/%s/%s/%s', owner, repo, master, file)
    ec s
    return 
    call DownloadAndOpen(s, 'checkout.js')
endfunction
function! GitCheckout()
    let file = Tail()
    let commitId = system('git log -n 1 --pretty=format:%H -- ' . file)
    if empty(commitId)
        ec 'not a git file'
    else
        let s = systemlist('git show ' . commitId . ':' . file)
        call AppendFile('checkout.js', s)
        call OpenBuffer3('checkout.js')
    endif
endfunction
function! EvalMode()
    if !has_key(g:globalState, 'eval_file')
        let g:globalState['eval_file'] = FilePrompt()
    endif
    call RunGFile()
endfunction
function! SetTempActiveNodeFile(...)
    let fileName = a:0 >= 1 ? a:1 : 'g:activeNodeFile'
    if Test(fileName, '^g\d$')
        let fileName = 'g:activeNodeFile' . fileName[1]
    endif
    let s = printf('let %s = "%s"', fileName, CurrentFile())
    ec 'sann:temporarily setting activeNodeFile'
    ec s
    execute s
endfunction

function! SetActiveShuntFile()
    let current =  CurrentFile()
    let g:activeShuntFile = current
    ec 'setting active shunt file: '  . current
endfunction
function! SetActiveNodeFile(...)
    let fileName = a:0 >= 1 ? a:1 : 'g:activeNodeFile'
    if Test(fileName, '^g\d$')
        let fileName = 'g:activeNodeFile' . fileName[1]
    endif
    let current = CurrentFile()
    let s = printf('let %s = "%s"', fileName, current)
    ec 'setting active node file: ' . current
    call AppendAndExecute(s)
endfunction
function! SmartOpen2(f)

    let f = a:f
    if IsDir(f)
        call Explorer(f)
    elseif IsFile(f)
        let extensions = [ "txt", "js", "py", "vim", "json", "css", "html", ]
        if Has(extensions, GetExtension(f))
            call OpenBuffer3(f)
        else
            call OpenBrowser(f)
        endif
    else
        call OpenBrowser(f)
    endif
    
endfunction

function! TouchFileToChangeLog()
    let file = CurrentFile()
    call Changelog(file)
endfunction

function! Changelog(...)
    let t = DateStamp() . ' ' . join(a:000, ' ')
    call AppendFile(g:changelogfile, t)
endfunction
function! FilePicker3()
    ec 'hi from filepicker3'
endfunction
function! AppendTocInFile()
    let s = GetBindingNames()
    let t = map(s, {i, x -> '// fn: ' . x})
    call append('$', t)
endfunction
function! EditManager(s)
    let s = a:s
    let cf = CurrentFile()
    if s == 'd'
        ec 'serving current file for deletion'
        call Changelog('delete', cf)
    elseif s == 'd'
        ec 'ssss'
    elseif s == 'd'
        ec 'ssss'
    elseif s == 'd'
        ec 'ssss'

    elseif s == 'd'
        ec 'ssss'
    endif
endfunction
function! TestFunctionWithNewString()
    let a = TimestampString()
    let b= GetCurrentWord()
    let s = printf("let %s = `\n    \n`\nconsole.log(%s(%s))", a, b, a)
    call append('$', split(s, "\n"))
endfunction

function! ZeroOrParen()
    return 0
    let items = [')', ']', '''', '"', '}']
    return Includes(LastChar(), items) ? ')' : 0
endfunction
function! Sdf()
    ec TimestampString()
endfunction
function! VisualShuntToExamples(state)
    let state = a:state
    let arg = FooName()
    let s = RegistrarTemplater('function $1() {', arg)
    let lines = Indent(state.lines)
    call add(lines, '}')
    call insert(lines, s)
    call AppendFile('examples.js', lines)
    
endfunction
function! Clip(s)
    call WriteFile(g:clipfile, a:s)
endfunction

function! GitReset()
    let s = systemlist('git rm --cached -r; git status')
    call Clip(s)
endfunction
function! CopyFile2(a, b)
   let a = a:a
   let b = a:b
   let lines = readfile(a) 
   call WriteFile(b, lines)
   ec printf('copying %s lines to %s', len(lines), b)
endfunction
function! BackupFileFromLine()
    let file = GetFileFromLine()
    call CopyFile2(file, 'backup.js')
endfunction
function! GetFileFromLineOld()
    let s = getline('.')
    let r = '(json|js|md|py|txt|html|css|pdf|jpg|png|svg|vim)'
    let possibles = split(trim(s), '\v[ ''"(),{}\[\]]')
    let files = filter(possibles, 'Test(v:val, r)')
    return Choose(files)
endfunction
function! FindallWords(s)
    let s = a:s
    return FindallStrings(s, '[a-zA-Z]\w+')
endfunction
"let g:execRef['ff'] = "call GoFileGoFunction('$arg')"
function! NormalLogThrow()
    let line = CurrentLine()
    let args = GetWords3(line)
    let ref = {
        \'async': 3,
        \'class': 2,
        \'function': 2,
        \'def': 2,
        \'let': 1,
    \}
    if has_key(ref, args[0])
        call remove(args, 0, ref[args[0]] - 1)
    endif
    let s = printf('console.log({%s}); throw "";', join(args, ', '))
    ec args
    call AppendBelow(line('.'), s)
    return args
endfunction
function! GetWords3(...)
    let s = a:0 >= 1 ? a:1 : getline('.')
    let r = a:0 >= 1 ? a:2 : '<[a-zA-Z]\w*'
    return FindallStrings(s, r)
endfunction
function! Billa()
    let s = FullPath2023() . getline('.')
    return s
endfunction
function! FullPath2023()
    return expand('%:p')
endfunction
function! SaveItem2023()
    throw 'deprecated'
    let s = IsExplorer() ? Billa() : CurrentFile()
    ec 'saving: ' . s
    call AppendFile(g:tempsavefile, s)
    
endfunction

function! IsExplorer()
    return &filetype == 'netrw'
endfunction
"nnoremap C :call OpenBuffer3('/home/kdog3682/CWF/public/class.js')<CR>
"nunmap C
"nnoremap <f1> :w<CR>:call Tester('ih', 'A8')<CR>


function! QgpBuildFnCall()
    let s = GetLastString()
    let f = GetLastFunction()
    let t = printf('console.log(%s(%s))', f, s)
    return t
endfunction
"nnoremap <f1> :w<CR>:call Tester('./pl-stringFixers.js', 'QgpBuildFnCall')<CR>
function! GSLogThrow(s)
    let s = a:s
    return printf('console.log({GSLogThrow: %s})', s)
endfunction
"call PackageManager("readParse", 'rp.js')


function! SetClipboard(...)
    let lines = a:0 >= 1 ? a:1 : readfile('copyBuffer.temp.js')
    if empty(lines)
        ec 'did not set clipboard because empty'
        return 
    endif
    while 1
        if empty(lines[0])
            call remove(lines, 0)
        else
            break
        endif
    endwhile
    call setreg('@', lines)
endfunction
function! ReformPasteBuffer(template)
    let template = a:template
    let s = @"
    let items = Unique(GetWords3(s))
    let items = MapTemplater(items, template)
    let items = join(items, "\n")
    let @" = items
endfunction

function! GoExample()
    let name = GetBindingName()
    let i =  FindLineIndex(name, 10, 1)
    call Cursor(i)
endfunction

function! EnterMarkdownAutoCommand()
    ec 'filetype before: ' . &filetype
    set filetype=markdown
    ec 'setting filetype as markdown'

    if exists(':Goyo')
        Goyo
    else
        ec 'Goyo is not installed'
    endif
endfunction
function! ExitMarkdownAutoCommand()
    if InGoyo()
        Goyo
    endif
endfunction
function! AutoCommandNewFile()
    let s = expand('%s')
    ec ['creating new file', s]
endfunction

function! GetFromMaster(s)
    let s = a:s
    let lib = LoadLibrary()
    let matches = FuzzyFindDict(lib, s)
    let value = ChooseDictValue(matches)
    if Exists(value)
        call append('.', split(value, "\n"))
    else
        ec 'no value for ' . s . ' at GetFromMaster'
    endif
endfunction
function! FuzzyFindDict(dict, r)
  let pattern = '\v^' . a:r
  let matches = filter(copy(a:dict), 'v:key =~ pattern')
  return matches
endfunction

function! ChooseDictValue(dict)
    let dict = a:dict
    if len(dict) == 1
        return dict[1]
    elseif len(dict) == 0
        return ''
    else
        let choices = keys(dict)[0:8]
        let key = Choose(choices)
        return dict[key]
    endif
endfunction
function! CurrentFunction()
    let line = CurrentLine()
    let r = '\w+\(|\w+ *$'
    let s = MatchWord(line, r)
    return s
endfunction
function! MatchWord(s, r)
    let s = a:s
    let r = a:r
    let m =  Match(s, r)
    if Exists(m)
        return Sub(m, '\W', '')
    endif
    return m
endfunction
function! GetSecondWord2(s)
    let s = a:s
    return FindallStrings(s, '[a-z]\w+')[1]
endfunction
function! Fooga()
    function! Inner(s)
        let s = a:s
        let s:t = printf('%s()', GetSecondWord2(s))
        return s:t
    endfunction
    call GetSetFn('Inner')
    let spaces = GetSpaces()
    call Cursor(line('.'), len(s:t . spaces))
    startinsert
endfunction

function! Fooga()
    function! Inner(s)
        return Replace(a:s, '\<buffer\> ', '')
    endfunction
    call GetSetFn('Inner')
endfunction
function! MatchLine(r)
    return Match(CurrentLine(), a:r)
endfunction
function! Fooga()
    let m = MatchLine('v-\S+')
    let m = Pascal(m)
    call AddImport(m, 'cm-components.js')
endfunction
function! AppendAbove2(s)
    let s = a:s
    let s = IsString(s) && Test(s, "\n") ? split(s, "\n") : ToArray2(s)
    let i =  line('.')
    let text = getline(i)
    let spaces = GetSpaces(text)
    if Test(text, '^[}\]] *$')
        let spaces .= '    '
    endif
    let t = map(s, 'spaces . v:val')
    "ec t
    "return
    call append(i - 1, t)
endfunction
function! Fooga()
    let params = GetParameters(CurrentLine())
    let template = 'const $1 = '
    call AppendAbove2(MapTemplater(params, template))
    return params
endfunction
"function! Fooga()
    
"endfunction
function! Iunmap(s)
    let s = a:s
    let items = split(s, ' ')
    let items = MapTemplater(items, 'iunmap <buffer> $1')
    for item in items
        try
            exec item
        catch
            ec ['error', v:exception]
        endtry
    endfor
    ec items
endfunction
"call appendbufline('a.js', 3, 'fo')
"end of line
"end of line
"end of line
"end of line
function! DocStamp()
    "exec:asdf('vvv', 'hhhh')
    let timestamp = strftime('%s')
    let file = CurrentFile()
    let p = Getjspy(file, 'commentPrefix')
    let s = printf('%s@documentation %s', p, timestamp)
    let lines = GetLines(GI3('spaceblock'))
    let snippet = SmartDedent2(lines)
    let date = strftime('%A, %B %d, %-I:%M%p')
    let template = 'exec:GoFileGoLine(''%s'', ''%s'')'
    let perform = printf(template, file, timestamp)
    let lines = [date, perform , '', snippet, '', '', g:lb]
    let lines = Flat(lines)
    call AppendAbove2(s)
    call OpenBuffer3('documentation.txt')
    call append('$', lines)
    call Cursor(line('$') - 1)
    startinsert
endfunction


function! GoFileGoLine(file, regex)
    " @documentation 1686412251
    let file = a:file
    let regex = a:regex
    let p = Getjspy(file, 'commentPrefix')
    " @documentation 1686412133
    let regex = '^ *' . p . '\@documentation ' . regex
    let cf = CurrentFile()
    "ec regex
    "return
    call OpenBuffer3(file)
    try
        execute 'silent /\v' . regex
        "normal! zt
    catch
        ec 'errror'
        "call OpenBuffer(cf)
    endtry
endfunction
function! Getjspy(file, key) abort
    let file = a:file
    let key = a:key
    let e = GetExtension(file)
    if e == 'vimrc'
        "@documentation 1686411932
        let e = 'vim'
    endif
    try
        return g:jspyref2[e][key]
    catch
        ec e
        let error = v:exception
        ec error
        throw 'call Stop()'
    endtry
endfunction
" @documentation 1686414541
" @documentation 1686414586
" @documentation 1686414652
function! Asdkf()
    ec 'hi'
endfunction

function! SearchDown2(key, ...)
    let offset = a:0 >= 1 ? a:1 : 0
    return SearchBase(a:key, offset, 1, 0, 0)
endfunction

function! AddArrow()
    let line = CurrentLine()
    let l = len(line)
    let spaces = 30 - l
    let s = printf('%s%s <--  ', line, repeat(' ', spaces))
    call setline('.', s)
    normal $
    startinsert
endfunction
function! DeleteArrow()
    function! Inner(s)
        return Replace(a:s, ' *\<--.*', '')
    endfunction
    call GetSetFn('Inner')
endfunction

  inoreab tk console.log([]); throw '';<LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><C-R>=Eatchar('\s')<CR>
function! OneifyTheFile()
    let current =  CurrentFile()
    let name = Sub(current, '\.\ze\w+$', '-1.')
    call DeleteAndSave(current, name)
endfunction

function! DeleteAndSave(current, new)
    let current = a:current
    let new = a:new
  execute 'saveas ' .new
  execute 'bdelete ' .current
  execute 'file ' .new
  call delete(current)
endfunction
function! Hpath(m)
    let h = expand('%:h')
    return h . '/' . AddExtension(Tail(a:m), 'js')
endfunction
"/mnt/chromeos/MyFiles/Downloads/code-runner.js
"/mnt/chromeos/MyFiles/Downloads/html-edit.js
"/mnt/chromeos/MyFiles/Downloads/text-builders.js
"/mnt/chromeos/MyFiles/Downloads/utility-components.js

function! DepNote(s)
    let s = a:s
    let s = 'ec.js EC'
    let [a, b] = map(split(s, ' '), "FileGetter2(v:val)")
    let n = printf('deprecate %s --> %s', a, b)
    call AppendNotes(n)
endfunction

function! AppendNotes(s)
    let s = a:s
    if empty(s)
        return 
    endif
    let s = strftime('%s') . ' ' . s
    ec s
    call AppendFile(g:notefile, s)
endfunction

function! CopyCurrentTemplateToHtmlBuilder(...)
    let lines = a:0 >= 1 ? a:1 : GetLines(GI3('vueTemplate'))
    let file = a:0 >= 2 ? a:2 : '/home/kdog3682/DIST/pl-htmlBuilder.js'
    if empty(lines)
        ec 'error: no lines of vueTemplate present'
        return 
    endif
    call insert(lines, '')
    call insert(lines, 'e')
    call OpenBuffer3(file)
    let index = FindLineIndex('`', '$', -1, 200)
    call append(index - 1, lines)
    normal G
endfunction


function! Tester2(fnKey, file, cursorPosition)
    let fnKey = a:fnKey
    let file = a:file
    let cursorPosition = a:cursorPosition
    let currentFile = CurrentFile()
    call OpenBuffer3(file)
    call Cursor(cursorPosition)
    call function(fnKey)()
    call OpenBuffer3(currentFile)
endfunction

"call Tester2('CopyCurrentTemplateToHtmlBuilder', '/home/kdog3682/2023/base-components.js', 37)

function! JM()
    call Python3('javascript.py', 'foo')
endfunction
"let g:wpsnippets['markdown'] = {}
function! PrintFiles(dir)
    return join(MostRecentFiles(a:dir), "\n")
endfunction
function! MarkdownWriteBuffers()
    let s = join(GetOpenBufferNames(), "\n")
    return s
endfunction
function! MostRecentFiles(dir)
  let s:time = reltime()[0] - 3600 * 24
  function! Inner(i, s)
      return getftime(a:s) > s:time
  endfunction

  let dir = DirGetter(a:dir)
  if empty(dir)
      return ['empty']
  endif
  let files = globpath(dir, '*', 1, 1)
  let values = filter(files, function('Inner'))
  return values[0:5]
endfunction
function! Bdkfg()
    "ec reltime()[0] - 3600 * 24
    "ec getftime('/home/kdog3682/.vimrc')
endfunction


function! DirGetter(s)
    let d = get(g:dirdict, a:s, a:s)
    if Test(d, '^g:')
        let d = eval(d)
    endif
    call Assert(IsDir(d), "not a directory: " . d)
    return d
endfunction
function! LastCommand()
    ec 'this "LastCommand" gets accidentally pressed a lot as map K'
endfunction
function! GitTempCheckout(...) abort
    let hasArgs = a:0 >= 1 ? 1 : 0
    let file = a:0 >= 1 ? a:1 : Tail()
    let currentDir = 0
    let ref = {
        \'vim': g:ftplugindir,
        \'py': g:pydir,
        \'md': g:resdir,
    \}

    let e = GetExtension(file)
    if has_key(ref, e)
        let currentDir = getcwd()
        call Chdir(ref[e])
    endif

    let m = 'git log -n 1 --pretty=format:%H -- ' . file
    let commitId = a:0 >= 2 ? a:2 : system(m)
    call AssertGit(commitId)

    ec 'Checking Out: commitId: ' . commitId
    let s = systemlist('git show ' . commitId . ':' . file)

    if Exists(currentDir)
        call Chdir(currentDir)
    endif

    if !hasArgs
        call Changelog('git-checkout', file, commitId)
    endif
    call WriteFile('git-checkout.temp.js', s, 1)
    call OpenBuffer3('git-checkout.temp.js')
endfunction

function! GetOrSetGlobalState(key, valueKey)
    let key = a:key
    let valueKey = a:valueKey
    
    if !has_key(g:globalState, key)
        if valueKey == 'movementRE'
            let g:globalState[key] = join(keys(g:movementLinks), '|')
        else
            let g:globalState[key] = VimStateGetter(valueKey)
        endif
    endif
    return g:globalState[key]
endfunction

function! DZ()
    let file = GetOrSetGlobalState('dz-file', 'fp')
    call InvivoAppend(file, '$', GetLines(GetCodeIndexes()))
endfunction
function! InvivoAppend(file, index, payload)
    let file = a:file
    let index = a:index
    let payload = ToLines(a:payload)
    call insert(payload, '')
    call add(payload, '')
    let buffer = filereadable(file) ? bufnr(file) : bufadd(file)
    call appendbufline(buffer, index, payload)
endfunction
function! VimStateGetter(s)
    let s = a:s

    if s == 'fp'
        return FilePrompt('')

    if s == 'cf'
        return CurrentFile()
    elseif s == 'identifier'
        return GetBindingName()
    elseif s == 'identifierAsFile'
        return AddExtension(GetBindingName(), GetExtension(CurrentFile()))
    elseif s == 'cft'
        return Tail(CurrentFile())
    else
        return s
    endif
endfunction
" Takes the current codeblock and appends to a given file

function! RegisterPackageManagerItem()
    let fnKey = GetBindingName()
    let commandKey = Abrev(fnKey)
    let fnFile = 'app-' . Tail()
    let a = printf('let g:packageManagerRef["%s"] = {"file": "%s", "args": ["cf"]}', fnKey, fnFile)
    let b = printf('let g:execRef["%s"] = "call PackageManager(''%s'')"', commandKey, fnKey)
    call InvivoAppend('/home/kdog3682/.vimrc', '$', [a, b])
endfunction
function! SeeVisualKeys(...)
    let q = a:0 >= 1 ? a:1 : ''
    let q= 'rep'
    let items = keys(g:visualactiondict)
    if Exists(q)
        ec Has(items, q)
    else
        ec items
    endif
endfunction
function! VisualReplace2(state)
    let state = a:state
    let [r, rep] = split(state.arg, '/')
    let s:regex = r
    let s:replacement = rep
    function! Inner(s)
        let s = a:s
        return Sub(s, s:regex, s:replacement)
    endfunction
    let s = 'Inner(v:val)'
    return map(state.lines, s)
endfunction
function! Sdojf()
    let a = 'max'
    let [r, rep] = split('"abc"/''d', '/')
    ec [rep]
endfunction
function! VisualGrab(state)
    let state = a:state
    let s:regex = state.arg
    function! Inner(s)
        let s = a:s
        return Match(s, s:regex)
    endfunction
    "asdf-adsfasdfa
    let s = 'Inner(v:val)'
    let state = a:state
    let items = Filtered(map(state.lines, s))
    if Exists(items)
        ec 'copied to pastebuffer via grab'
        ec items
        call ToPasteBuffer(items)
        "asdf-adsfasdfasdasdasd
    endif
endfunction
function! VeryLongStamp()
    let strife = '%m-%d-%Y %A, %B %d, %-I:%M%p'
    return strftime(strife)
endfunction
function! LongStamp()
    let date = strftime('%A, %B %d, %-I:%M%p')
    return date
endfunction
function! OpenChangeLogFile()
    call OpenBuffer3(g:changelogfile)
endfunction
function! WriteDocumentationViaBufferSwap(...)
    let key = 'Documentation'
    let items = []
    call add(items, g:linebreak)
    call add(items, strftime('%m-%d-%Y') . ' ' . key)
    call add(items, strftime('%A, %B %d, %-I:%M%p'))
    call add(items, CurrentFile())
    call add(items, GetBindingName())
    call add(items, '')
    call add(items, g:linebreak)
    call add(items, '')
    call OpenChangeLogFile()
    call append('$', items)
    normal GO
endfunction
function! SelectCommandViaTextColon(s)
    let s = a:s
    let [a,b] = split(s, ':')
    return b
endfunction

function! RegisterGoFileViaE(key)
    let key = a:key
    let file = CurrentFile()
    let t = 'nnoremap %s :call OpenBuffer3("%s")<CR>'
    ec t
    let s = printf(t, key, file)
    return AppendAndExecute(s)
endfunction

function! AddFile(s)
    if Not(a:s)
        let a = AbbreviateFile(CurrentFile())
        return AddDictItem('file', a, b)
    endif
    let [a,b] = SplitOnce(a:s)
    if Not(b)
        let b = CurrentFile()
    endif
    let dict = GetGValue('2023') ? 'file2023' : 'file'
    let cmd = join([dict, a, b], ' ')
    call AddDictItem(cmd)
endfunction
function! FileAssertion(f) abort
    let f = a:f
    if !IsFile(f)
        throw 'not a valid backup file: ' . f
    endif
endfunction
function! GetSetRange(range, Fn)
    let range = a:range
    let [start, end] = range
    let Fn = function(a:Fn)

    for i in range(start, end)
        let [spaces, line] = GetSpacesAndLine(i)
        let value = Fn(line)
        call setline(i, spaces . value)
    endfor
endfunction
function! ReplaceWordWithPasteBuffer()
    let word = CurrentWord3()
    let s:replacement = GetPasteBuffer()
    let s:r = '<' . word . '>'
    function! Inner(s)
        let s = a:s
        return Sub(s, s:r, s:replacement)
    endfunction
    call GetSetRange(GI3('block'), 'Inner')
endfunction
"ec g:execRef
function! IsBufferOpen(buffer_name)
  for bufnr in range(1, bufnr('$'))
    if bufexists(bufnr) && getbufname(bufnr) ==# a:buffer_name
      return 1
    endif
  endfor
  return 0
endfunction
function! RegisterMovementLinkage()
    let t = 'let g:movementLinks["%s"] = {"%s": "%s"}'
    let key = CurrentWord3()
    let m = printf('The activation key is: %s, input type ([f]ile or [b]inding) along with value (where the search will be performed)', key)
    let [type, file] = SplitOnce(Prompt(m))
    let value = printf(t, key, type, file)
    call AppendAndExecute(value)
endfunction
function! CurrentWord3()
    return Match(CurrentWord(), '[a-z]\w+')
endfunction
function! AppendCurrentWordToFileBottom()
    call append('$', CurrentWord3())
endfunction

function! FindPyDictItem(key)
    call OpenBuffer3('/home/kdog3682/.vimrc')
    let key = a:key
    let r = printf('^let g:pydict\[[''"]%s[''"]\]', key)
    return ExecuteRegex2(r, 1)
endfunction

"LineMark
function! GoFileGoFunction(s)
    let s = a:s

    let fast = get(g:globalAliases, s, '')
    if Exists(fast)
        let evaled = Evaluate('g:' . fast)
        return ExecuteFunctionSearch(evaled)
    endif

    if has_key(g:gfgfdict, s)
        let [file, fnName, more] = g:gfgfdict[s]
        call OpenBuffer3(file)
        let prefix = Exists(more) ? g:bindingPrefixInnerRE : g:bindingPrefixRE
        let r = prefix . fnName . '>'
        call ExecuteRegex(r)
        normal! zt
    elseif has_key(g:execRef) && LooksLikeVimFunction(g:execRef[s])
        let [file, fnName] = ['/home/kdog3682/.vimrc', g:execRef[s]]
        call OpenBuffer3(file)
        let more=0
        let prefix = Exists(more) ? g:bindingPrefixInnerRE : g:bindingPrefixRE
        let r = prefix . fnName . '>'
        call ExecuteRegex(r)
        normal! zt
    else
        let r = '^function!? ' . s
        call ExecuteRegex(r, '', '', 'zt')
    endif
    
endfunction

function! GetFunctionNameFromWord()
    let word = CurrentWord3()
    if Test(getline('.'), word . '\(')
        return word
    endif
endfunction
function! RegisterGfGfItem(...)
    let [key, name] = DefineEatHelper(a:0 >= 1 ? a:1 : '')
    let t = "let g:gfgfdict['%s'] = ['%s', '%s', %s]"
    let file = CurrentFile()
    let s = printf(t, key, file, name, 0)
    call AppendAndExecute(s)
endfunction
function! ListTocFiles()
    let files = g:listTocFiles
    call OpenBuffer3(Choose(files))
endfunction
function! SaveTocFiles()
    ec 'saving toc files to saved.txt'
    call Save(g:listTocFiles)
endfunction
function! MarkTocFile()
    let file = CurrentFile()
    if Has(g:listTocFiles, file)
        ec 'already exists no mark'
        return 
    endif
    ec 'marking toc file: ' . file
    call add( g:listTocFiles, file)
endfunction

function! Save(x)
    call AppendFile(g:saveFile, a:x)
endfunction
function! SeeActiveNodeFiles()
    let files = [g:activeNodeFile1, g:activeNodeFile2, g:activeNodeFile3, g:activeNodeFile4, g:activeNodeFile5]
    call PPrint(files)
endfunction

function! PPrint(files)
    ec Numbered2(a:files)
endfunction
function! VisualCct(state)
    let state = a:state
    call CopyCurrentTemplateToHtmlBuilder(state.lines, state.arg)
endfunction

function! LambdaToFunction()
    function! Inner(s)
        let s = a:s
        let a = Match(s, '\w+\ze \=')
        let b = Match(s, '\(.{-}\)')
        return printf('function %s%s {', a, b)
    endfunction
    call GetSetFn('Inner')
endfunction

" @bookmark 1692320548 packageManagerRef
"let g:packageManagerRef["viteBuild"] = {"file": "viteBuild.js", "args": ["prompt"]}
"let g:packageManagerRef["viteDev"] = {"file": "viteDev.js", "args": ["prompt"]}
"let g:packageManagerRef["viteDev"] = {"file": "viteDev.js", "args": ["prompt"]}
function! RootMkdir(s) abort
    let s = a:s
    call Assert(s, 'dir required')
    let s =  g:rootdir . s
    call mkdir(s)
    ec ' making dir: ' . s
endfunction
function! PipFreeze()
    let cmd = "pip freeze > requirements.txt"
    call systemlist(cmd)
endfunction

function! ListHighFrequencyFiles()
    call OpenBuffer3(Choose(g:highFrequencyFiles))
endfunction
function! PropArrayToPropObject()
    function! Inner(s)
        let s = a:s
        let items = GetWords3(s)[1:]
        let items = MapTemplater(items, '    $1: {default: ''''},')
        call insert(items, 'props: {')
        call add(items, '},')
        return items
    endfunction
    call GetSetFn('Inner')
endfunction

function! StrpTime(s)
    let s = a:s
    return strptime('%m/%d/%Y', s)
endfunction
function! Sort2(items, fn)
    let items = a:items
    let fn = a:fn
    let Fn = function(fn)
    let Compare = { a, b -> Fn(a) > Fn(b) ? 1 : Fn(a) < Fn(b) ? -1 : 0 }
    call sort(items, { a,b -> Compare(a, b) })
    return items
endfunction
function! SortFilesByEndStamp(s)
    let s = a:s
    let s = Match(s, '\d+[-/].+')
    ec [s]
    if empty(s)
        return 1000000000000000
    endif
    return strptime('%m/%d/%Y', s)
endfunction
function! GetLastFile(dir, file)
    let dir = a:dir
    let file = a:file
    let path = dir . (Test(dir, '/$') ? '' : '/')
    let target = empty(file) ? '*' : Tail(file) . '*'
    let path .= target
    let files = glob(path, 0, 1)
    if Exists(file)
        let files = Sort2(files, 'SortFilesByEndStamp')
    endif
    return files
endfunction
function! GetLastBUFile()
    let file = Tail()
    return GetLastFile(g:budir, file)
endfunction
"nnoremap <leader>c :call ChooseBuffer2('cl')<CR>:call append('$', '/* ' . DateStamp() . ' */')<CR>Go<CR>
function! GoLocationalBookMark(key)
    let key = a:key
    if !has_key(g:lbmDict, key)
        ec 'key not present in locational bookmarkRef'
        return 
    endif
    let [timestamp, file] = g:lbmDict[key]
    let r = '^ *([/"#]+)locational-bookmark: ' . timestamp
    call OpenBuffer3(file)
    call ExecuteRegex(r)
endfunction
function! SaveLocationalBookMark(...)
    let timestamp = strftime('%s')
    let key = a:0 >= 1 ? a:1 : Abrev(GetBindingName())
    let file = CurrentFile()
    let comment = Comment('locational-bookmark: ' . timestamp)
    let t = 'let g:lbmDict["%s"] = ["%s", "%s"]'
    let s = printf(t, key, timestamp, file)
    call AppendBelow2(comment)
    call AppendAndExecute(s)
endfunction

function! AppendBelow2(s, ...)
    let index = a:0 >= 1 ? a:1 : line('.')
    let s = ToArray2(a:s)
    let spaces = CurrentSpaces()
    let items = Indent(s, spaces)
    call append(index, items)
    call cursor(index + 1, 1000)
endfunction

"ec items(g:visualactiondict)
"function CamelCase(s)
    "let s = a:s
    "return Replace(s, )
"endfunction

function! MoveBlockToBottom()
    let b= DeleteBlock()
    let c = line('$')
    call append('$', b)
    call Cursor(c + 3)
endfunction
function! Urlify(...)
    let s:hasName = a:0 >= 1 ? 1 : 0
    function! Inner(s)
        let s = a:s
        if Exists(s:hasName)
            let [name, s] = SplitOnce(s)
        else
            let name = Prompt('name of variable?')
        endif
        return printf('const %s = "%s"', name, s)
    endfunction
    call GetSetFn('Inner')
endfunction
function! SaveTheFile(name)
    let name = a:name
    call 
endfunction
function! SDfhui()
    Explore /mnt/chromeos/MyFiles/Downloads/
endfunction
function! Foo1689568942(arg, ...)
    let arg = a:arg
    let dir = a:0 >= 1 ? a:1 : ''
    let query = PathJoin(dir, a:arg)
    let files = glob(query . '*', 0, 1)
    return GetMostRecent(files)
endfunction

function! GetMostRecent(files)
    let files = a:files
    let mostRecentFile = ''
    let mostRecentTimestamp = 0
    for file in files
        let timestamp = getftime(file)
        if timestamp > mostRecentTimestamp
          let mostRecentFile = file
          let mostRecentTimestamp = timestamp
        endif
    endfor
    return mostRecentFile
endfunction
"let g:resourcedir='/home/kdog3682/Resources2023/pip.txt'
function! CopyCurrentTemplateToHtmlBuilder2()
    let lines =  GetLines(GI3('vueTemplate'))
    let file = '/home/kdog3682/2023/pl-htmlBuilder.js'
    return CopyCurrentTemplateToHtmlBuilder(lines, file)
endfunction

function! Ty()
    let line = printf('console.log(%s)', Replace(trim(CurrentLine()), 'return ', ''))
    call AppendAbove2(line)
endfunction
function! ExecuteAction(s)
    let s = a:s
    let [key, args] = SplitOnce(split(s, ' '))
    let ref = g:changelogActionRef
    let fnKey = has_key(ref, key) ? ref[key] : Pascal(key)
    return call(function(fnKey), args)
endfunction
function! ExpandAA(key, n)
    let key = a:key
    let n = a:n
   let eatString = "\<C-R>=Eatchar('\\s')\<CR>"
   if Exists(key)
       let key = ' ' . key
    endif
  if getcmdtype() == '/'
    return DateStampIncrement(n) . key . eatString
  else
    return 'aa'
  endif
endfunction

function! DateStampIncrement(n)
    let n = a:n
    if !n
        return DateStamp()
    endif
    let numbers = split(DateStamp(), '-')
    let numbers[1] = numbers[1] + n
    return join(numbers, '-')
    
endfunction
function! Sayhi(...)
    let s = a:0 >= 1 ? a:1 : 'Sam'
    ec 'Saying hi from ' . s
endfunction
function! GetLongestItem(list)
  let longest_length = 0
  let longest_item = ''

  for item in a:list
    let item_length = strdisplaywidth(item)
    if item_length > longest_length
      let longest_length = item_length
      let longest_item = item
    endif
  endfor

  return longest_item
endfunction


function! AppendBindingNamesInOrgFile()
    let names = GetBindingNames()
    call insert(names, CurrentFile())
    call WriteFile('organize.txt', names, 1)
endfunction

function! ExecuteFunctionRE(s)
    let s = a:s
    let r = g:bindingPrefixRE . s
    return ExecuteRegex2(r, 0)
endfunction

function! GitRevert()
    let file = a:0 >= 1 ? a:1 : Tail()
    let commitId = GetCommitId(file)
    let s = systemlist('git show ' . commitId . ':' . file)
    call WriteFile(file, s)
endfunction

function! WriteFile(file, lines, ...)
    let file = a:file
    let lines = a:lines
    if !Exists(lines)
        return
    endif

    let openIt = 0 >= 1 ? 1 : 0
    call writefile(lines, file, 'w')
    ec 'writing file: ' . file
    if openIt
        call OpenBuffer3(file)
    endif

endfunction
function! Adiosj()
    call WriteFile('f.js', ['aaa'])
endfunction
function! GetCommitId(file)
    let file = a:file
    let m = 'git log -n 1 --pretty=format:%H -- ' . file
    let commitId = system(m . file)
    return commitId
endfunction

function! InsertAtInsertionPoint(name)
    let name = a:name
    let r = 'insertion-point'
    call ExecuteRegex2(r, 1)
    let s = printf('%s,', name)
    call AppendAbove2(s)
endfunction

function! GetCurrentGitId()
    let s = 'git rev-parse --abbrev-ref HEAD'
    let s = 'git rev-parse HEAD'
    ec systemlist(s)
endfunction

function! ChooseMultiple(items)
    let items = a:items
    ec Numbered2(items)
    let s = input('')
    let numbers = split(s, '\v +')
    return map(numbers, 'items[v:val - 1]')
    
endfunction
function! ModularIncrement2(items, item, ...)
    let dir = a:0 >= 1 ? (IsNumber(a:1) ? a:1 : -1) : 1
    let items = a:items
    let item = a:item
    let i = index(items, item)
    if dir == 1
        if i == len(items) - 1
            return items[0]
        else
            return items[i + 1]
        endif
    else
        if i == 0
            return items[len(items) - 1]
        else
            return items[i - 1]
        endif
    endif

endfunction


function! ToggleLinkedBufferGroup()
    return OpenBuffer3(GetNextLinkedBuffer())
endfunction

function! GetNextLinkedBuffer() abort
    let file = CurrentFile()
    let tail = Tail(file)
    if has_key(g:node1dict2, tail)
        let f = get(g:node1dict2[tail], 'file')
        if Exists(f)
            return f 
        endif
    endif
    if has_key(g:linkedBufferGroups, file)
        let group = ToArray2(g:linkedBufferGroups[file])
        let nextFile = ModularIncrement2(group, file)
        return nextFile
    else
        throw 'no linked buffer group for: ' . Tail(file)
    endif
endfunction
function! GetBufferGroup()
     let buffers = GetActiveBuffers()
     let s = 'Abspath(v:val)'
     let group = map(ChooseMultiple(buffers), s)
     return group
endfunction
function! EstablishLinkedBufferGroup()
    return EstablishLinkedBufferGroupRunner(getBufferGroup())
endfunction
function! EstablishLinkedBufferGroupRunner(group)
    let group = a:group
     let template = 'let g:linkedBufferGroups["%s"] = "%s"'

     if len(group) == 0
         try
             let other = FileGetter2(Prompt('choose file link'))
             let cmd = printf(template, CurrentFile(), other)
             return AppendAndExecute(cmd)
         catch
            ec 'a valid file was not chosen'
            return 
         endtry
     elseif len(group) == 1
         let cmd = printf(template, CurrentFile(), group[0])
         return AppendAndExecute(cmd)
     else
         let lines = []
         for name in group 
             let s = printf(template, name, group)
             call add(lines, s)
         endfor
         return AppendAndExecute(lines)
     endif
endfunction
function! DumpJson(s)
    let s = a:s
    return printf('%s', s)
endfunction
function! GetActiveBuffers()
  let f = 'buflisted(v:val)'
  let buffers = filter(range(1, bufnr('$')), f)
  let names = map(buffers, 'bufname(v:val)')
  return names
endfunction
function! RunOppositeLinkedBuffer()
    return Node(GetNextLinkedBuffer())
endfunction
function! VisualFirstWord(state)
    let state = a:state
    let items = map(state.lines, 'GetFirstWord(v:val)')
    ec items
    call ToPasteBuffer(items)
endfunction

function! GetImport()
    let file = Tail()
    let word = GetCurrentWord()
    let ref = {
        \'cm.esm.js': 'cm-next.js',
    \}
    if !has_key(ref, file)
        return 
    endif

    let targetFile = ref[file]
    call OpenBuffer3(targetFile)
    call AddImport(word, file)
endfunction
function! GiManager()
    let file = Tail()
    if file == 'cm.esm.js'
        return GetImport()
    else
        return GetItem()
    endif
endfunction
"let g:inlineActionDict = {}
function! RunFunction2(key, args) abort
    let key = a:key
    let args = a:args
    try
        call call(function(key), args)
        call DeleteLine()
    catch
        let error = v:exception
        ec error
    endtry
endfunction
function! RunAction()
    let [key, args] = GetActionAndArgs()
    return RunFunction2(key, args)
endfunction
function! GetActionAndArgs()
    let line = CurrentLine()
    let cmd = RemoveStartingComments(trim(line))
    let args = split(cmd, '\v +')
    let store = []
    let i = 0
    let max = len(args)
    while i < max
        let item = args[i]
        if Test(item, '^\w')
            call add(store, item)
        else
            let store[-1] = store[-1] . ' ' . item . ' ' . args[i + 1]
            let i += 1
            
        endif
        let i += 1
    endwhile 

    if store[0] == 'action' || store[0] == 'a'
        let key = GetActionArgKey(store[1])
        return [key, store[2:]]
    else
        let key = GetActionArgKey(store[0])
        return [key, store[1:]]
    endif
endfunction
function! GetActionArgKey(s)
    let s = a:s
    if has_key(g:actionAndArgAliases, s)
        return g:actionAndArgAliases[s]
    else
        return 'AA' . Capitalize(s)
    endif
endfunction
function! AAReplace(a, b)
    let a = a:a
    let b = a:b
    let caseSensitive = 1 ? "\\C" : ""
    let template = '%%substitute/\v%s%s%s%s/%s/g'
    let leftB = '<'
    let rightB = '>'

    if Test(a, '\W')
        let leftB = ''
        let rightB = ''
    endif
    let cmd = printf(template, caseSensitive, leftB, a, rightB, b)
    ec 'AAReplace: ' . cmd
    "return
    execute cmd
endfunction

function! SmartIndent2(lines)
    let lines = a:lines
    let spaces = GetSpaces(lines[0])
    let newSpaces = '    '
    let f = 'Replace(v:val, "^" . spaces, newSpaces)'
    let lines = map(copy(lines), f)
    return lines
endfunction
function! NoteMakerForVisualDoc(key, lines)
    let key = a:key
    let lines = a:lines
    let lines = SmartIndent2(lines)
    let items = []
    let file = CurrentFile()
    let id = strftime('%s')
    let bookmarkId = Tail(file) . '-' . id
    call add(items, '')
    call add(items, strftime('%m-%d-%Y') . ' ' . key)
    call add(items, '')
    call add(items, '    file: ' . file)
    call add(items, '    location: ' . GetBindingName())
    call add(items, '    bookmarkId: ' . id)
    call add(items, '    date: ' . strftime('%A, %B %d, %-I:%M%p'))
    call add(items, '')
    call extend(items, lines)
    call add(items, '')
    return items
endfunction
function! VisualChanged(state)
    "The evolution of WriteDocumentationViaBufferSwap
    let state = a:state
    let items = NoteMakerForVisualDoc('DocChange', state.lines)
    let s = Comment('bookmarkId: ' . id)
    call AppendFile(g:changelogfile, items)
    call AppendAbove(state.indexes[0], s)
endfunction
function! VisualNotes(state)
    let state = a:state
    let items = NoteMakerForVisualDoc('DocNotes', state.lines)
    call AppendFile(g:changelogfile, items)
endfunction
vnoremap c :<c-u>call VisualAction('VisualChanged')<CR>
vnoremap n :<c-u>call VisualAction('VisualNotes')<CR>

function! RegisterBufferNoremap(key, fn)
    let key = a:key
    let fn = a:fn
    let t = 'nnoremap <buffer> %s :call %s<CR>'
    let s = printf(t, key, fn)
    execute s
endfunction
"nnoremap ] :call AppendLineStart()<CR>

function! TempBracket(dir)
    let dir = a:dir
    
endfunction
function! TempDown()
    RegisterBufferNoremap(']', 'TempBracket(1)')
    RegisterBufferNoremap('[', 'TempBracket(-1)')
endfunction
function! GetVimData(key, outpath)
    let key = a:key
    let outpath = a:outpath
    execute ":redir! > " . outpath
    execute ":silent " . key
    execute ":redir END"
    call OpenBuffer3(outpath)
endfunction
function! GetVimVariables(key)
    let key = a:key
    "if key == 'map'
        "return GetVimData('map', 'vim.mappings.txt')
    if key == 'let'
        return GetVimData('let', 'vim.variables.txt')
    elseif key == 'g'
        return GetVimData('let:g', 'vim.globals.txt')
    elseif key == 'g'
        return GetVimData('g:filedict', 'vim.filedict.txt')

    elseif key == 'inoremap'
        return GetVimData('verbose inoremap', 'vim.temp.txt')

    elseif key == 'imap'
        return GetVimData('verbose imap', 'vim.temp.txt')

    elseif key == 'map'
        return GetVimData('verbose map', 'vim.temp.txt')

    elseif key == 'buffer'
        return GetVimData(':verbose map <buffer>', 'vim.temp.txt')
    elseif key == 'foo'
        return GetVimData(':verbose map [*', 'vim.temp.txt')
    elseif key == 'foo'
        return GetVimData(':verbose map ][', 'vim.temp.txt')
    elseif key == 'foo'
        return GetVimData('verbose noremap ]*', 'vim.temp.txt')
    else
        let cmd =  ':verbose inoremap ' . key . '*'
        return GetVimData(cmd, 'vim.temp.txt')
        "return GetVimData(key, 'vim.temp.txt')
    endif
endfunction
function! SetShuntFile()
    let f = FilePrompt('Set Shunt File as:')
    let g:activeShuntFile = f
    if Exists(f)
        ec "\nSetting shunt file as: " . f
    else
        ec "\nremoving shunt file"
    endif
endfunction

function! DBManager()
  if Exists(g:activeShuntFile)
      let buffer = g:activeShuntFile
      let lines = GetLines(GetCodeIndexes())
      call appendbufline(buffer, '$', lines)
      execute '/' . g:fnRE6
  else
      call DeleteBlock()
    endif
endfunction
function! Sodkf()
    let lines = ['a', 'b']
  call appendbufline('f.js', '$', lines)
endfunction
function! Sub2(s, r)
    let s = a:s
    let r = a:r
    let s = substitute(a:s, Regexed(r), function('Inner'), 'g')
    return s
endfunction
function! MultiLineTemplater(s, ...)

    let s:args = a:000
    let s:count = 0

    function! Inner(s)
        let spaces = a:s[1]
        let key = a:s[2]
        let value = s:args[s:count]
        let s:count += 1
        return IndentAsString(value, spaces)
    endfunction

    let s = a:s
    let s = SmartDedent2(s)
    let s = Sub2(s, '( *)\$(\w+)')
    return s
endfunction
function! ToArrayItem(s)
    return printf('"%s",', a:s)
endfunction
function! VisualObject(state)
    let state = a:state
    let s:prefix= state.arg . ': {'
    let s:indentation = state.indentation
    function! Inner(lines)
        let lines = a:lines
        let lines = Flat([s:prefix, Indent3(lines, 4, 1), '}'])
        let lines = Indent3(lines, s:indentation)
        return lines
    endfunction
    call EditLinesInPlace(state.lines, state.indexes, 'Inner')
endfunction

function! VisualArray(state)
    let state = a:state
    let prefix=Jspy('prefix') . state.arg . ' = ['
    let lines = Flat([prefix, Indent3(map(state.lines, 'ToArrayItem(v:val)'), 4, 1), ']'])
    let lines = Indent3(lines, state.indentation)
    call EditLinesInPlace(lines, state.indexes)
endfunction
function! EditLinesInPlace(lines, range, ...)
    let lines = ToLines(a:lines)
    let range = a:range
    let Fn = a:0 >= 1 ? function(a:1) : function('Identity')
    let length = len(lines)
    let lines =  Fn(lines)
    let a = lines[:length - 1]
    let b= lines[length :]
    call setline(range[0], a)
    call append(range[1], b)

endfunction
function! VisualStringVarIt(state)
    let state = a:state
    let lines = state.lines
    function! Inner(lines)
        let lines = a:lines
        call insert(lines, '')
        call insert(lines, printf('let %s = `', TimestampString()))
        call add(lines, '')
        call add(lines, '`')
        return lines
    endfunction
    call EditLinesInPlace(lines, state.indexes, 'Inner')
endfunction

"iab gte >=
"iab lte <=
"inoreab sta static
"iab gt >=
"inoreab lt <=

function! RestoreDebug() abort
    let name = GetBindingName()
    let file = CurrentFile()
    let key = name . '-' . file
    let ref = g:debugDict[key]
    let upline = ref['upline']
    let line = ref['line']
    let top = FindLineIndex(g:fnRE6 . name, '.', -1)
    let m = FindLineIndex(Rescape2023(upline), '.', 1)
    call append(m, line)
endfunction
function! SaveDebug()
    let name = GetBindingName()
    let upline = UpLine()
    let line = CurrentLine()
    let file = CurrentFile()
    let payload = {
        \'file': file,
        \'functionName': name,
        \'upline': upline,
        \'line': line,
    \}
    let key = name . '-' . file
    let s = DumpJson(payload)
    let t = StringGDict('debugDict', key, s)
    call AppendVim(t)
    call DeleteLine()
    "howdy
endfunction



function! StringGDict(key, name, payload)
    let key = a:key
    let name = a:name
    let payload = a:payload
    let t = 'let g:%s["%s"] = %s'
    return printf(t, key, name, AddQuotes(payload))
endfunction
function! ExecuteBufferNoremap(key, fn)
    let key = a:key
    let fn = a:fn
    let t = "nnoremap <buffer> %s :call %s()<CR>"
    ec t
    execute printf(t, key, fn)
endfunction

function! Booga123()
    function! Inner(s)
        let s = a:s
        return split(s)[0] . '  '
    endfunction
    call GetSetFn('Inner')
    call Cursor('.', 100)
    startinsert
endfunction

function! Booga122()
    call ExecuteBufferNoremap('e', 'Booga123')
endfunction
function! UpdateAndExecuteLine(save)
    let save = a:save
    let line = RemoveStartingComments(CurrentLine())
    if Test(line, '^\w+\(')
        let line = 'ec ' . line
    endif
    try
        execute line
        if save
            call AppendFile(FileGetter2('pluginfile'), line)
        elseif Test(line, '^ *(inoreab|iab|imap|inoremap)')
            " normal o
            " startinsert
        else
            ec 'success: ' . line
        endif
    catch
        let error = v:exception
        ec 'Line: ' . line
        ec 'Error: ' . error
    endtry
endfunction
function! FunctionRetriever(key)
    let key = a:key
    try
        return function(key)
    catch
        let error = v:exception
        "ec error
        return 0
    endtry
endfunction
function! ShortMonths()
    return map(copy(g:shortMonths), 'v:val . "-2023 "')
endfunction


function! Indent3(s, spaces, ...)
    let s = a:s
    let spaces = ToSpaces(a:spaces)
    let t = a:0 >= 1 ? 'spaces . trim(v:val)' : 'spaces . v:val'
    return map(copy(s), t)
endfunction


function! DefineTempIab()
    let t = "inoreab <buffer> %s %s<C-R>=Eatchar('\\s')<CR>"
    let b = CurrentWord3()
    let a = Abrev(b)
    let s = printf(t, a, b)
    call Exec3(s)
endfunction

function! UnmapVim()

    nunmap <buffer> []
    nunmap <buffer> [[
    nunmap <buffer> ["
    nunmap <buffer> ][
    nunmap <buffer> ]]
    nunmap <buffer> ]"
    return 
    try
        nunmap <buffer> [M
    catch
        let error = v:exception
        ec error
        
    endtry
    try
        nunmap <buffer> [m
    catch
        let error = v:exception
        ec error
        
    endtry
    try
        nunmap <buffer> []
    catch
        let error = v:exception
        ec error
        
    endtry
    try
        nunmap <buffer> [[
    catch
        let error = v:exception
        ec error
        
    endtry
    try
        nunmap <buffer> ]M
    catch
        let error = v:exception
        ec error
        
    endtry
    try
        nunmap <buffer> ]m
    catch
        let error = v:exception
        ec error
        
    endtry
    try
        nunmap <buffer> ]]
    catch
        let error = v:exception
        ec error
        
    endtry
    try
        nunmap <buffer> ][
    catch
        let error = v:exception
        ec error
    endtry
endfunction
function! AmmLog(key)
    let s =  a:key . ' ' . GetFileFromLine2(CurrentLine())
    call AppendFile('saved.txt', '$', s)
endfunction
function! AmmDelete()
    call AmnLog('delete')
    let file = CurrentFile()
    try
        silent execute 'bdel! ' . file
    catch
        let error = v:exception
        ec error
    endtry
endfunction
function! AddMovementMaps()
    ec 'adding amm maps'
    nnoremap <buffer> ni :call AmmLog('no-idea')<CR>
    nnoremap <buffer> di :call AmmDelete()<CR>
    nnoremap <buffer> sv :call AmmLog('save')<CR>
endfunction
function! IndentAsString(s, spaces)
    let s = a:s
    let spaces = ToSpaces(a:spaces)
    if IsString(s)
        return spaces . s
    endif
    return join(map(copy(s), 'spaces . v:val'), "\n")
endfunction

function! Fokw()
    
    "a
    "b
    "c

    function! Inner(lines)
        let lines = a:lines
        call add(lines, '    "c')
    endfunction 

    call EditLinesInPlace(lines, [12935, 12936], 'Inner')
endfunction
function! J(s)
    return join(a:s, "\n")
endfunction
function! TestTheCurrentFunction()

    let tail = Tail()
    let name = GetBindingName()
    "let f = CurrentFunction()
    let ref = {
        \'cm-next.js': 'main(%s)'
    \}

    let template = 'console.log(%s())'
    if has_key(ref, tail)
        let template = ref[tail]
    endif
    let s = printf(template, name)
    call append('$', s)
endfunction

function! GetSecondMostRecentFile(directory)
  " Get a list of files in the specified directory sorted by modification time
  let files = sort(glob(a:directory . '/*'), 'file_mtime_cmp')

  " Check if there are at least two files in the list
  if len(files) >= 2
    return files[-2]  " Return the second most recent file
  else
    return ''  " Return an empty string if there are not enough files
  endif
endfunction

function! s:file_mtime_cmp(file1, file2)
  let mtime1 = getftime(a:file1)
  let mtime2 = getftime(a:file2)
  if mtime1 > mtime2
    return 1
  elseif mtime1 < mtime2
    return -1
  else
    return 0
  endif
endfunction


function! MarkForDeletion()
    call DeleteFile2(CurrentFile())
endfunction
function! SetLogConsole()
    let file = CurrentFile()
    call OpenBuffer3('utils.js')
    call append('$', 'logConsole()')
    call OpenBuffer3(file)
endfunction
function! Grep(q)
    let head = Head()
    let dir = PathJoin(head, '*.' . Lang())
    let cmd = printf('grep "%s" %s', q, dir)
    let lines = systemlist(cmd)
endfunction
function! ZzLocationSpotter()
    
    if Exists(g:zzLocation)
        return 
    else
        let g:zzLocation = ''
        return 
    endif
endfunction
" nnoremap zz :call ZzLocationSpotter()<CR>
function! MoveFunctionUp()
    let lines = DeleteBlock()
    let index = FindLineIndex('^function', '$', -1, 500)
    call AppendAbove(index, lines)
endfunction



"nnoremap mc :call MarkCode()<CR>
"nnoremap mb :call BookmarkLineFileAndFunction()<CR>
"cnoreabbrev <expr> aa ExpandAA('action', 0)
"cnoreabbrev <expr> az ExpandAA('', -1)
function! RegisterPacItemFromCurrentLine()
    let date = DateStamp()
    let line = CurrentLine()
    let payload = [
        \'# ' . date,
        \'# ' . Replace(line, '^# *', '')
    \]
    call setline('.', '')
    call AppendFile('/home/kdog3682/PYTHON/pac.txt', payload)
    ec 'registering pac item from current line'
endfunction
function! AddImportNext()
    let word = GetCurrentWordOrBinding()
    let file = 'next.js'
    return AddImport(word, file)
endfunction
" 08-15-2023 
" What is vim.fn:Fokw
" 'scaleAndAxis.js' was extracted from t2
" use leader X for iai or just use iai
"
"let g:filedict["ehb"] = "/home/kdog3682/2023/HTMLBuilder.js"
function! DuplicateCallWithString()
    let word = GetCurrentWord()
    let stamp = TimestampString()
    let template = "let %s = `\n\n`\n\nconsole.log(%s(%s))\n"
    let s = printf(template, stamp, word, stamp)
    call append('$', ToLines(s))
endfunction
"let g:execRef["dev"] = "call PackageManager('viteDev')"
"let g:execRef["build"] = "call PackageManager('viteBuild')"
function! Booga()
    call Python2('buildViteFile', CurrentFile(), ')
endfunction

function! PythonPackageManager(key, ...)
    let key = a:key
    let ref = g:pythonPackageManagerRef[key]
    ec 'Running pythonPackageManagerRef:' . key
    let args = GetPackageManagerArgs(ref, a:000)
    call insert(args, key)
    call call(function('Python2'), args)
endfunction

function! GetLastTouched()
    let file = CurrentFile()
    let name = Tail(file)
     let n = getftime(file)   
     let v =  strftime('%m-%d-%Y', n)
     ec v
     call Changelog(name . ' last touched: ' . v)
endfunction


function! GoChangelog()
    let n = strftime('%w')
    if n >= 1 && n <= 5
        ec 'no changelog on weekdays'
    else
        call OpenBuffer3(g:helpmdfile)
    endif
endfunction
"nnoremap <f2> :w<CR>:call Node('Puppeteer2.js')<CR>
function! Zrn()
    let s:word = GetCurrentWord()
    let s:replacement = Prompt('Choose the name for the replacement')
    let i = FindLineIndex('Numbers', 1, 1, 100)
    let s = printf('    %s: %s,', s:replacement, s:word)
    call append(i, s)

    function! Inner(s)
        let s = a:s
        return Replace(s, '<' . s:word . '>', 'Numbers.' . s:replacement)
    endfunction
    call GetSetFn('Inner')
endfunction
" 08-23-2023 zrn
function! SaveTemp()
  execute 'saveas temp.js'
endfunction
function! RevertTemp()
    ec 'hi'
endfunction
function! CurrentlyWorkingIn()
    let file = CurrentFile()
    let cmd = printf('let g:currentWorkFile = "%s"', file)
    call Changelog('currently-working-file', file)
    call AppendAndExecute(cmd)
endfunction
function! GetQuote(s)
    let s = a:s
    return Match(s, '"\zs.{-}\ze"')
endfunction

function! FunctionNote()
    let date = DateStamp()
    let file = Tail(CurrentFile())
    let name = GetBindingName()
    let s = printf('%s %s @ %s', date, name, file)
    call OpenBuffer3('code.log')
    call append('$', s)
    call Cursor(line('$') - 1)
    startinsert
endfunction


function! PostFileTable(...)
    let s = a:0 >= 1 ? a:1 : GetFileFromLine()
    if empty(s)
        ec 'empty s'
        return 
    endif
    let lines = GetFiles3(s)
    call insert(lines, '')
    call insert(lines, DateStamp())
    call insert(lines, '')
    call OpenBuffer3(g:ftfile)
    call append('$', lines)
    call Cursor('$')
endfunction
function! GetFiles3(s) abort
    let s = a:s
    let dict = {'json': g:jsondir, 'py': g:pydir, 'res': g:resdir, 'text': g:textdir, 'math': g:mathdir, 'gpy': g:drivedir . 'PY', 'js': g:dir2023, '2023t': g:dir2023 . 'TEXTS/'}
    let s = get(dict, s, s)
    if IsDir(s)
        let glob = globpath(s, '*', 0, 1)
        return sort(glob)
    endif
    throw 'not a dir: ' . s
endfunction
function! GetBlockLines() abort

    let indexes = []
    let line = getline('.')
    if Test(line, '^[/#"]')
        let [a,b] = FindUpDownIndexes('^[^/#"]', '^[^/#"]')
        if b == -2
            let a += 1
            let b = line('$')
        else
            let a += 1
            let b -= 1
        endif
        let indexes = [a, b]
    else
        let [a,b] = GetCodeIndexes()
        let r = '^(const|var|class|def|(async )?function) '
        let c = ''
        try
            let c = FindLineIndex(r, b + 1, 1)
        catch
            let c = line('$') + 1
        endtry
        let indexes = c < 0 ? [a,b] : [a, c - 1]
    endif

    let lines = GetLines(indexes)
    while 1
        if GetLast(lines) == ''
            call remove(lines, -1)
            let indexes[1] = indexes[1] - 1
        else
            break
        endif
    endwhile
    return [lines, indexes]
endfunction

function! WriteNotes4(s)
    let s = a:s
    call AppendFile(g:ftfile, s)
endfunction
function! TrackProgress()
    let lines = GetLines(GI3('belowCursor'))
    let m = map(lines, 'GetBindingName2(v:val)')
    let fns = filter(m, 'Exists(v:val)')
endfunction
function! AddWordToImports()
    let word = GetCurrentWord2()
    let word = Match(word, '[a-z]\w+')
    let file = 'math-utils.js'
    ec [word, file]
    call AddImport(word, file)
endfunction
function! AppendBlockToFile()
    let blockType = GetBlockType()
    "ec 'BT: ' . blockType
    let lines = DeleteBlock(GI3(blockType))
    ec Join(lines)
    call insert(lines, '')
    let file = g:drivemdnotefile
    call AppendFile(file, lines)
endfunction
function! GetBlockType() abort
    let line = CurrentLine()
    if Test(line, '^\d+-\d+-\d+')
        return 'dateBlock'
    endif
    let lang = Lang()
    if lang == 'md'
        return 'dateBlock'
    endif
    return 'dateBlock'
    throw 'no block type'
endfunction

function! MoveCursorByDateStamp()
    try
        let r = g:dateRE
        let @/ = r
        normal! n
        normal! zt
    catch
    endtry
endfunction
"nnoremap `nu :call ExecNU()<CR>
"nnoremap ` call RunServerFile('debug screenshot wonderful')<CR>
"nnoremap ` :w<CR>:call RunPythonOrNode()<CR>
function! PackageManager2(key, ...)
    let key = a:key
    let args = split(g:pmr2[key], ' ')
    let args = GetPackageManagerArgs(args)
    let argFile = a:0 >= 1 ? a:1 : 0
    if Exists(argFile)
        call remove(args, len(args) - 1)
        call add(args, argFile)
    endif
    call Node(args)
endfunction

function! GetPackageManagerArgs(...)
    let s:args = Flat(a:000)
    return map(copy(s:args), function('GetVimStateArg'))
endfunction
"inoreab <buffer> lab let [a,b] =


function! Match2(s, r)
    let s = a:s
    let r = a:r

    let s:matches = []
    function! Inner(x)
        let matches = RemoveTrailingEmptyStrings(a:x)
        call extend(s:matches, matches)
        return ''
    endfunction
    let result = substitute(s, '\v' . r, {s -> Inner(s)}, '')
    " echo "result: " . string(result)
    let length = len(s:matches)
    if length == 1
        return s:matches[0]
    elseif length == 2
        return s:matches[1]
    elseif length == 0
        return ''
    else
        return s:matches[1:]
    endif
endfunction

function! InsertSnippet(snippet, spaces)
    let snippet = a:snippet
    let spaces = a:spaces
    let cursorpos = GetCursorFromStringSnippet(snippet)
    let snippet = Replace(snippet, ', \ze\)', '')
    let snippet = Replace(snippet, '[$%]c', '')
    let m = Match(snippet, "\n+$")
    let lines = split(snippet, "\n")
    for i in range(len(m))
        call add(lines, '')
    endfor
    call TextPlacement2(lines, spaces, 0)
    call SetCursor(cursorpos, spaces)
endfunction




function! VimCall(s)
    let s = a:s
    if Test(s, '^\w+\(')
        let s = 'call ' . s
    endif
    return s
endfunction

function! Flatten2D(items)
    let items = a:items
    let store = []
    for item in items
        if IsArray(item[0])
            call extend(store, item)
        else
            call add(store, item)
        endif
    endfor
    return store
endfunction


