highlight Pmenu ctermbg=gray guibg=gray
highlight Folded ctermfg=white ctermbg=black guifg=white guibg=black
highlight MyCustomBlueColor ctermfg=blue guifg=blue"
highlight MyCustomRedColor ctermfg=red guifg=red"
highlight MyCustomGreenColor ctermfg=green guifg=green"
""" localBookmarkId: 1697717268 """

let g:bookmarkfile = 'bookmarks.txt'
let g:vim = 0
let g:javascript = 0
let g:python = 0
source /home/kdog3682/.vim/ftplugin/functions.vim
source /home/kdog3682/.vim/ftplugin/variables.vim

source /home/kdog3682/.vim/ftplugin/testing.vim
source /home/kdog3682/.vim/ftplugin/settings.vim
source /home/kdog3682/.vim/ftplugin/variables.09-15-2023.vim
source /home/kdog3682/.vim/ftplugin/functions.09-15-2023.vim
source /home/kdog3682/.vim/ftplugin/variables.10-12-2023.vim


function! UnmapVim2()
    try
        :silent! nunmap <buffer> [[
    catch
    endtry

    try
        :silent! nunmap <buffer> ]]
    catch
    endtry

    try
        :silent! nunmap <buffer> []
    catch
    endtry

    try
        :silent! nunmap <buffer> ][
    catch
    endtry

    try
        :silent! nunmap <buffer> ]"
    catch
    endtry

    try
        :silent! nunmap <buffer> ["
    catch
    endtry
endfunction



function s:xsplit(s)
    let s = a:s
    let r = s:match(a:s,  '[\|,]')
    if empty(r)
        let r = ' +'
    else
        let r = ' *' . return . ' *'
    endif
    return IsArray(s) ? s : split(trim(s), '\v' . r)
endfunction

function! RemoveTrailingEmptyStrings(list)
  let length = len(a:list)

  while length > 0 && empty(a:list[length - 1])
    let length -= 1
  endwhile

  return a:list[0:length - 1]
endfunction

function! Help()
    ec 'hi'
endfunction

function! CssHelp()
    let a = Prompt('Ask for help')
    if Test(a, '^/')

endfunction

function! TopComment(x)
    let x = a:x
    let s = IsString(x) ? Match(x, '\n\zs.+') : x[1]
    let c = Match2(s, '/\* *(.{-}) *\*/')
    return c
endfunction

function DefineGeneral(...)
    let s = a:0 >= 1 && !empty(a:1) ? a:1 : getline('.')
    call AppendAndExecute(s, GetFtpluginFile())
endfunction

function! SplitOnceDontTrim(s)
    let s = a:s
    let [s, end] = MGet(s, ' *$')
    let items = split(s, ' ')
    let first = remove(items, 0)    
    return [first, join(items, ' ') . end]
endfunction
function! DefineEatHelper(s)
    let s = a:s
    let [a,b] = Exists(s) ?  SplitOnceDontTrim(s) : GetAbrevAndName()
    if empty(b)
        if a == 'cw'
            let b = GetCurrentWord4()
            let a = Abrev(b)
        elseif a == 'cw'
        else
                let b = GetBindingName()
        endif
    endif
    return [a,b]
endfunction
function DefineEat(...)
    let [a, b] = a:0 >= 2 ? a:000 : DefineEatHelper(a:0 >= 1 ? a:1 : '')
    let expr = 0
    if a == 'expr'
        let expr = 1
        let [a,b] = SplitOnce2(b)
    endif
    if s:llvf(b)
        let b .= '()'
    endif

    let eatTemplate = "inoreab <buffer>%s %s<C-R>=Eatchar('\\s')<CR>"
    let iabTemplate = "inoreab <buffer>%s %s"
    let exprPrefix = len(Match(a, '\w+')) < 3 ? 'inoremap' : 'inoreab'
    let exprTemplate = exprPrefix . " <buffer> <expr> %s %s"
    let isIab = Test(b, ' $')
    let template = isIab ? iabTemplate : eatTemplate
    if expr
        let template = exprTemplate
    endif

    if isIab && !Test(b, '\n')
        let b = Replace(b, ' +$', '')
    endif

    let b = Sub(b, ' ', '<space>')
    let b = Sub(b, 'left', '<left>')
    let b = Sub(b, 'right', '<left>')
    let parens = Match(b, '\)+$')
    if s:t(b, g:keyboard.left)
        let b = s:sub(b, g:keyboard.left, '<LEFT>')
    elseif Exists(parens) && !expr
        let b .= repeat('<LEFT>', len(parens))
    endif
    let cmd = printf(template, a, b)
    call AppendAndExecute(cmd, GetFtpluginFile())
endfunction
function Every(items, fn)
    let items = a:items
    let fn = a:fn
    let Fn = function(fn)
    for item in items
        if !Fn(item)
            return 0
        endif
    endfor
    return 1
endfunction
function MoveTemplateBackToComponentFile()
    let b = FindLineIndex('`', '$', -1)
    let c = FindLineIndex('`|^"? *e *$', b - 1, -1)
    let indexes = [c + 1, b - 1]
    let b = DeleteBlock(indexes)
    call OpenBuffer3('baseComponents.js')
    let d = FindLineIndex('template:', '$', -1)
    let d += 1
    let e = FindLineIndex('`', d, 1)
    call s:replaceblock([d, e - 1], b)
endfunction

function! s:replaceblock(indexes, lines)
    let indexes = a:indexes
    let lines = a:lines
    let [a, b] = indexes
    for i in range(a, b)
        call deletebufline('%', a)
    endfor
    call append(a - 1, lines)
endfunction



function CurrentInfo2()
    let file = CurrentFile()
    let tail = Tail(file)
    let e = GetExtension(file)
    let lineNumber = line('.')
    let lineCount = line('$')
    let [spaces, line] = GetSpacesAndLine(lineNumber)
    " let date = DateStamp()
    " let buffers = GetCurrentBuffers()
    " let blockIndexes = GetCodeIndexes()

    return {
        \'file': file,
        \'currentFile': file,
        \'tail': tail,
        \'line': line,
        \'spaces': spaces,
        \'ext': e,
        \'lang': e,
        \'lineNumber': lineNumber,
    \}
endfunction


function VimExecute(x)
    let x = a:x
    if IsArray(x)
        let x = join(x, ' | ')
    endif
    try
        execute x
    catch
        let error = v:exception
        ec {'VimExecuteError': error, 'input': x}
    endtry
    
endfunction


function WithOpen(file, cmd)
    let file = a:file
    let cmd = a:cmd
    let file = CurrentFile()
    call OpenBuffer3(a:file)
    if s:llvf(cmd)
        try
            call function(cmd)(a:file)
        catch
            let error = v:exception
            ec error
        endtry
    else
        execute a:cmd
    endif
    call OpenBuffer3(file)
endfunction
function TestExampleJSFile()
    call WithOpen('examples.js', 'call Node1()')
endfunction
function SetNode3Fn()
    let name = GetBindingName()
    let g:node3fn = name
    ec 'setting node3fn: ' . name
endfunction

function ViewOldVersionOfFile()
    let file = CurrentFile()
    let file = 'baseComponents'
    let file = RemoveExtension(Tail(file))
    let dir = g:drivedir . 'DEPRECATED'
    let files = GetFiles2(dir, file . '*')
    let files = sort(files, 'file_mtime_cmp')
    let file = files[-1]
    return OpenBuffer3(file)
endfunction


function AppendCurrent(lines)
    call AppendFile(g:helpmdfile, a:lines)
endfunction
function! s:wbc(...)
    let key = a:0 >= 1 ? a:1 : '[a-z0-9.]+'
    return s:stringbeforecursor(key . '$')
endfunction
function! s:strcall(s, ...)
    let s = a:s
    return printf('%s(%s)', s, join(s:flat(a:000), ', '))
endfunction
function! WrapCurrentWordWithStringCall(replacement)
    let s:replacement = a:replacement
    function! Inner123(s)
        let s = a:s
        let word = GetCurrentWord4(0, 0, '[''"a-z0-9\._:-]+')
        return Replace(s, word, s:strcall(s:replacement, word))
    endfunction
    call GetSetLine2023(line('.'), 'Inner123')
endfunction
function s:jspy(key, ...)
    let key = a:key
    function! s:innerjspy(s)
        return g:jspyref3[&filetype][a:s]
    endfunction

    try
        if IsArray(key)
            return map(copy(key), 's:innerjspy(v:val)')
        endif
        let value = s:innerjspy(key)
        if s:exists(value)
            return value
        endif
        return a:0 >= 1 ? a:1 : ''
    catch
        return a:0 >= 1 ? a:1 : ''
    endtry
endfunction
function! VimZEqual(s)
    let s = a:s
    let keys = ['s', 'g']
    for item in keys
        let key = item . ':' . s
        if exists(key)
            let value = eval(key)
            ec value
            return 
        endif
    endfor
    ec 'no value for: ' . s
endfunction
function! ZEqual()
    " sees the value of word under cursor
    call function(Capitalize(&filetype) . 'ZEqual')(GetCurrentWord4())
endfunction
function! SmartBrace()
    let [a, b, c, d, e] = ABCDECursor()
    return [a, b, c, d, e]
endfunction

function! s:csv(s)
    let s = a:s
    let r = '(\w+) +(\w+) +(\w+) +(.+)'
    let l = s:matchfilter(s:tolines(s), r)
    return l
endfunction
function! GoRecentJumpFunction(key)
    " test: "et"
    let key = a:key
    let s = s:redir(':jumps')
    let jumps = s:csv(s)
    return jumps
    let r = CreateRE(key)
endfunction
let g:todo = {}
function! MarkForLater()
    call DictSetter('g:todo', s:date(), s:binding())
endfunction
function SmartEqual()
    
    let line = CurrentLine()
    let [a, b, c, d, e] = ABCDECursor()

    if a == '=' && b == ' '
        return g:keyboard.BS . '= '
    elseif Test(b, '[?<>!]')
        return '='
    elseif b == ' ' && empty(d)
        if Test(c, '\W')
            return '= '
        endif
        return '== '
    endif

    let prefix = s:jspy('prefix')

    if Test(line, '^ *[\{\[]')
        return "\<C-O>I" . prefix . "\<C-O>A = "
    elseif !empty(c . d . e) && Test(SliceToCursor(), '^ *\w+ *$')
        let m = SplitOnce2(line)
        if empty(m[1])
            return " = \<C-O>I" . prefix . "\<C-O>A"
        else
            let payload = printf('%s%s = %s', prefix, m[0], m[1])
            return "\<ESC>^DA" . payload
        endif
    endif

    let space = line[CurrentChar() - 1] == ' ' ? '' : ' '
    if Test(line, '^ *\w+ *$')
        if empty(prefix)
            return
        endif
        let b = Match(line, '\w+')
        let l = len(b)
        let equalDict = s:jspy('equalDict')
        let dictValue = get(equalDict, b, '')
        " throw string(dictValue)
        if IsObject(dictValue)
            return SmartEqualDict(dictValue)
        endif
        " let up = s:matchupbinding(b)
        " if up
            " return ' = '
        " endif
        return GoLeft(l) . prefix . GoRight(l) . ' = ' . dictValue

    elseif Test(line[col('.') - 2], '^[.''"=\\-]$')
        return '='
    elseif Test(line, '^ *(if|elif|else(if)?)>')
        return space . '== '
    else
        return space . '= '
    endif
endfunction
function GetFtpluginFile()
    let ft = &filetype
    let file = ft == 'vim' ? '/home/kdog3682/.vimrc' : printf('/home/kdog3682/.vim/ftplugin/%s.vim', ft)
    return file
endfunction
function LinkCurrentBufferAndPrevBuffer()
    let a = bufnr('%')
    let b = bufnr('#')
    let a = bufname(a)
    let b = bufname(b)
    " let g:linkedBufferGroups[a] = [a,b]
    " let g:linkedBufferGroups[b] = [a,b]
    let s = 'let g:linkedBufferGroups["%s"] = ["%s","%s"]'
    let A = printf(s, a, b, a)
    let B = printf(s, b, a, b)
    let C = A . "\n" . B
    ec printf('Linking %s  and %s', a, b)
    call AppendAndExecute(C)

endfunction
function Dprint()
    function! Inner(s)
        let s = a:s
        let m = GetWords3(s)
        call remove(m, 0)
        let a = map(m, {i,x -> printf('"%s": %s', x, x)})
        return printf('pprint({%s})', join(a, ', '))
    endfunction
    call GetSetFn('Inner')
endfunction
function MarkWord(s)
    let s = a:s
    if empty(s)
        let s = GetCurrentWord()
    else
        let letters = SplitSingles(s)
endfunction
function! SplitSingles(s)
    let s = a:s
    return split(s, '\zs')
endfunction
function! AppendAndExecute(s, ...)
    let file = a:0 >= 1 ? a:1 : '/home/kdog3682/.vimrc'
    let s = a:s

    if empty(s) || !IsFile(file)
        ec 'no value for s'
        return 
    endif
        execute ToString(s)
        ec printf('appending and executing: %s', s)
        call AppendFile(file, s)
        return s
endfunction


function SetLineStart(s)
    let start = a:s
    function! Inner(s)
        return start . '  ' . a:s
    endfunction
    call GetSetFn('Inner')
endfunction
function! ToLines(x)
    if Not(a:x)
        return []
    elseif IsIndexes(a:x)
        return GetLines(a:x)
    elseif IsArray(a:x)
        let store = []
        for item in a:x
            let items = split(item, "\n")
            if len(items) == 0
                call add(store, '')
            else
                call extend(store, items)
            endif
        endfor
        return store
    else
        return split(a:x, "\n")
    endif
endfunction

function! AppendFile(file, lines, ...)
    let lines = ToLines(a:lines)
    if g:debug
        ec '-----------------------------'
        ec lines
        ec '-----------------------------'
        ec 'g:debug is active. early return'
        return 
    endif
    if empty(lines)
        return 
    elseif len(lines) > 1
        call add(lines, '')
    endif

    let file = a:file
    let g:lasttouchedfile = file
    let length = len(lines) . (len(lines) == 1 ? ' line' : ' lines')

    if file == bufname('%')
        ec printf('appending %s to current file', length)
        call append('$', lines)
    else
        ec printf('appending %s to %s', length, file)
        call _WriteFile(file, lines, 'a')
    endif
endfunction
function GetMode(key, ...)
    let key = a:key
    if !exists('g:modes')
        let g:modes = {}
    endif
    if has_key(g:modes, key)
        return g:modes[key]
    else
        let presetMessage = 'Choose an Action Mode for ' . key
        let message = a:0 >= 1 ? a:1 : presetMessage
        let Fn = a:0 >= 2 ? function(a:2) : 0 
        let raw = Prompt(message)
        let mode = empty(Fn) ? raw : Fn(raw)
        let g:modes[key] = mode
        return mode
    endif
endfunction
function! CopyController()
    let message = 'Choose a file to copy subsequent items into'
    let file = GetMode('CopyController', message, 'FileGetter2')
    let lines = GetCodeLines()
    call InvivoAppend(file, '$', lines)
endfunction
function ModeReset()
    function! Reset(key)
        let key = a:key
        if exists(key)
            exec printf('let %s = {}', key)
            ec 'resetting ' . key
        endif
    endfunction

    call Reset('g:modes')
endfunction

function GetCodeLines()
    return GetLines(GetCodeIndexes())
endfunction

function! Node1(...)
    if &filetype == 'vim'
        return ExecuteFunctionCaller2()
    endif

    let tail = Tail()
    if tail == 'runExampleFile.js'
        let buf = getbufinfo(s:bufload('examples.js'))
        let args = ['runExampleFile', 'examples.js', buf[0].lnum]
        return Node('packageManager.js', args)
    endif

    if has_key(g:node1dict2, tail)
        let ref = g:node1dict2[tail]
        let file = get(ref, 'file', 0)
        if Exists(file)
            let caller = Jspy('shellFn', file)
            let Fn = function(caller)
            return call(Fn, [file])
        else
            let args = GetPackageManagerArgs(get(ref, 'args', []))
            call insert(args, tail)
            call insert(args, ref.key)

            if Debugger('node')
                return s:node('packageManager.js', args)
            else
                return Node('packageManager.js', args)
            endif
        endif
        return 
    endif
    let other = DictGetter(g:linkedFileRef, tail, 'run')
    if s:exists(other)
        return s:node_or_python(other)
    endif

    let other = DictGetter(g:linkedFileRef, tail, 'file')
    if s:exists(other)
        return s:node_or_python(other)
    endif

    if has_key(g:python1dict2, tail)
        let ref = g:python1dict2[tail]
        let args = GetPackageManagerArgs(ref.args)
        return Python3(ref.file, args)
    elseif has_key(g:node1dict3, tail)
        let file = g:node1dict3[tail]
        let ShellFn = function(Jspy('shellFn', file))
        return ShellFn(file)
        
    endif


    if Exists(ModeIsActive())
        return 
    endif
    if !empty(get(g:globalState, 'cleanerMode'))
        let lines = DeleteBlock()
        call AppendFile(g:globalState.file, lines)
        return 
    endif

    if !empty(get(g:globalState, 'inoremapTestMode'))
        let line = CurrentLine()
        let line =  Replace(line, '^[#/]+ *', '')
        let line = Bufferize(line)
        execute line
        return 
    endif

    let override = a:0 >= 1 ? a:1 : 0
    let file = CurrentFile()
    let name = Basename(file)
    let lang = Lang()
    if Test(file, '\.vim/')
        execute "source " . file
        ec "sourcing the current file @ Node1"
        return 
    endif


    if has_key(g:node1dict, name)
        call eval(Replace(g:node1dict[name], '<cf>', CurrentFile()))
    elseif Exists(override) || Test(lang, 'vue|comp|js|jav')
        call Shell('node', file)
    elseif lang == 'vim'
        "if InGlobal()
            "call ExecuteComment()
        "else
            call FunctionCaller()
        "endif
    elseif lang == 'py'
        call Shell('python3', file)
    endif
endfunction


function! RSC(s)
    return Replace(trim(a:s), '^["/#]+ *', '')
endfunction
function EvalTheLine(...)
    let s = a:0 >= 1 ? a:1 : getline('.')
    let code = RSC(s)
    let value = eval(code)
    return value
endfunction



function LogConsole()
    function! Inner(file)
        let n= '$'
        let payload = 'logConsole()'
        let s = getline(n)
        if Test(s, Rescape2023(payload))
            call setline(n, '')
        elseif empty(s)
            call setline(n, payload)
        else
            call append(n, payload)
        endif
        w
    endfunction

    call WithOpen('utils.js', 'Inner')
endfunction
function WriteStatus(s)
    let s = a:s
    return s
    let dict = {
        \'ip': 'In-Progress',
        \'td': 'Todo:',
    \}
endfunction
function DateIt(s)
    let s = a:s
    return DateStamp() . ' ' . trim(s)
endfunction
function WriteNotes5(s)
    let s = a:s
    let ref = g:writenotesref
    function! Inner(x)
        if a:x[2] == '  '
            return "\n"
        endif
        return GetVimStateArg(a:x[1])
    endfunction

    let [a,b] = SplitOnce(s)
    if has_key(ref, a)
        let t = ref[a]
        let dollar = Test(t, '\$') ? '\$' : '<' 
        let r = dollar . '(arg|cf|e|t|cw|l|line|lineNumber|binding|fn)>|(  )'
        let s = Sub(t, r, function('Inner'))
        if Exists(b) && Test(s, '\%s')
            let s = printf(s, b)
        endif
    else
        let dollar = Test(s, '\$') ? '\$' : '<' 
        let r = dollar . '(arg|cf|e|t|cw|l|line|lineNumber|binding|fn)>|(  )'
        let s = Sub(s, r, function('Inner'))
    endif

    if empty(a)
        let message = ''
        let name = GetBindingName()
        if Test(name, '\d$')
            let shortName = Replace(name, '\d+$', '')
            let message = printf('%s is the newest version of %s.', name, shortName)
        elseif Test(name, 'aaa')
            let message = 'aaa'
        endif
        let t = ref.cn
        let s = printf(t, Tail(), name, message)
    endif

    return AppendHelpMD(s)
    
endfunction

function WrapWithNewLines(s)
    let lines = ToLines(a:s)
    if len(lines) == 1
        return lines
    else
        call insert(lines, "\n")
        call add(lines, "\n")
        return lines
    endif
endfunction
function AppendHelpMD(s)
    let s = a:s
    let cursor = 0
    if Test(s, '\$c$')
        let s = s[:-3]
        let cursor = 1
    endif
    let payload = WrapWithNewLines(DateStamp() . ' ' . s)
    call AppendFile(g:helpmdfile, payload)
endfunction
function ReplaceCurrentWordWithPaste()
    " useful
    function! Inner(s)
        let word = GetCurrentWord()
        return Sub(a:s, word, GetPasteBuffer())
    endfunction
    call GetSetFn('Inner')
endfunction


function MarkdownSmartEnter()
    let line = CurrentLine()
    let [spaces, line] = GetSpacesAndLine()
    let CR = "\<CR>"
    if Test(line, '^- ')
        return CR . '- '
    elseif Test(line, '^* ')
        return CR . '* '
    elseif Test(line, '^\d+\. ')
        let n = Match(line, '\d+') + 1
        return CR . n . '. '
    else
        return CR
    endif
endfunction




function! GetMonthYear()
    return strftime('%B%Y')
endfunction
function! InsertTomorrowDate()
    let strife = '%m-%d-%Y'
    let tomorrow = strftime(strife, localtime() + 86400)
    return tomorrow
endfunction
function! Sleep(n)
    execute "sleep " . a:n
endfunction

function s:llvf(s)
    let s = a:s
    return Test(s, '\C^[A-Z]\w*$')
endfunction
function EndOfDay()
    " call append('$', '" ' . TomorrowDate())
    call Python3('endOfDay.py')
endfunction

function AddImport(...) abort
    let word = a:0 >= 1 ? a:1 : GetBindingName()
    let word = Replace(word, '^\W*', '')
    let reff123 = {
        \'variables': 'import * as variables from "./variables.js"',
    \}
    let varWord = GetFirstWord(word)
    if has_key(reff123, varWord)
        let s = reff123[varWord]
        call append(0, s)
        return 
    endif
    let file = a:0 >= 2 ? a:2 : ''

    ec [word, file]
    if empty(file)
        let deplib = LoadLibrary2(g:jdjsonfile)
        let file = get(deplib, word, '')
        if empty(file)
            let file = FilePrompt('Choose the import file')
            let ref = {
                \'cm3.js': 'next.js',
            \}
            if empty(file)
                let file = ref[Tail()]
            endif
        endif
    endif

    if empty(file)
        throw 'empty file'
    endif
    let file = Tail(file)

    let currentFile = Tail()
    let other = DictGetter(g:linkedFileRef, currentFile, 'file')
    if s:exists(other)
        call OpenBuffer3(other)
    endif

    let r = '} *from *[''"]./' . file
    let index = 0

    try
        let index = s:fli(r, 0, 1, 300, 0)
        " ec index
        if index == line('$')
            throw ''
        endif
        let line = getline(index)
        let s:name = word
        " ec word
        " ec line
        if s:t(line, '\{')
            function! Inner(s)
                let s = a:s
                return Replace(s, '\{', '{ ' . s:name . ',')
            endfunction
            call GetSetFn('Inner', index)
        else
            call append(index - 2, '    ' . word . ',')
        endif
    catch
        ec v:exception
        let s = RegistrarTemplater("import {\n    $1,\n} from \"./$2\"", [word, file])
        call AppendString(0, s)
    endtry

    if s:exists(other)
        w
        call OpenBuffer3(currentFile)
    endif
    return file
endfunction
function RegexExpression(s)
    let s = a:s
    let ref = {
        \'call': "^(\\w+(?:\\.\\w+)*)\\((.*?)\\)",
        \'c': "\\w+(?:\\.\\w+)*\\(",
    \}
    return get(ref, s, s)
    " const r = /^(\w+(?:\.\w+)*)\((.*?)\) *(?:\/\* *(.*?) *\*\/ *)?$/gm
endfunction
function GetStateInfo(...)
    let s = a:0 >= 1 ? a:1 : getline('.')
    let [spaces, line] = GetSpacesAndLine(s)
    let line = &filetype == 'vim' ? s:removestartingcomments(line) : line
    let tail = expand('%:t')
    let pos = col('.')
    let e = expand('%:e')
    if tail == '.vimrc'
        let tail = 'vimrc'
        let e = 'vim'
    endif

    let [tag, rest] = SplitOnce(line)
    return [spaces, line, tail, e, tag, rest]
endfunction
function! s:gsp(template, s)
    " test: "asdf $1::sdf", "fdf"
    "test: 'if $1 $2 $c', 'absf'
    "test: "$1 $2 $3 $4 $4 $4 $c", "a b c d"

    let template = a:template
    let s = trim(a:s)
    let dollars = len(s:unique(s:findall(template, '\$[0-9]')))
    let store = []

    if dollars < 2
       return [s]
    endif

    let [items, d] = s:ssds(s)
    let diff = len(items) - dollars
    if diff == -1
        " let upbinding = s:getupbinding()
        " if s:exists(upbinding)
            " call insert(items, upbinding, 0)
        " else
            call insert(items, '', 0)
        " endif
        return items
    elseif diff < 0
        for i in range(abs(diff))
            call add(items, '')
        endfor
        return items
    endif

    """ bookmarkId: s-1697290694 note: args are backloaded """
    let t = []
    for i in range(diff)
        let items[diff - 1] .= d . remove(items, diff)
    endfor
    return items

    " testing here
    ifnt a b c d

    """ bookmarkId: s-1697290694 note: args are frontloaded """
    let t = ''
    for i in range(diff)
        let t .= remove(items, 0) . d
    endfor
    let t = trim(t)
    return empty(t) ? items : [t] + items
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""
endfunction

function! SnippeteerHelper(x, parts, line)
    " test: [0, '1', 'upbinding'], ['',2,3], "aa"
    let parts = a:parts
    let line = a:line
    let m = a:x[1]
    let fallback = a:x[2]
    let [a,b] = SplitOnce(line)

    if m == 'c'
        return '$c'
    elseif m ==# 'B'
        return "{\n    $c\n}"
    elseif Test(m, '^\d+')
        if m == '0'
            return line
        elseif m - 1 < len(parts)
            let v = parts[m - 1]
            if Exists(v)
                return v
            elseif Exists(fallback)
                return SnippeteerHelper(['', fallback[2:], ''], parts, line)
            else
                return ''
            endif
        elseif Exists(fallback)
            return fallback
            return SnippeteerHelper(['', fallback[2:], ''], parts, line)
        else
            return ''
        endif
    elseif m =~ '^{'
        let m = m[1:-2]
        let m = Sub(m, '\$(\w+)', {x-> Quotify(SnippeteerHelper(x, parts, line))})
        return eval(m)
    else
        return GetVimStateArg(m)
    endif
endfunction
function! GetSnippet(...)
    let s = a:0 >= 1 ? a:1 : getline('.')
    return s:unescapespace(_GetSnippet(s))
endfunction
function! _GetSnippet(...)
    let s = a:0 >= 1 ? a:1 : getline('.')
    let ref = g:wpsnippets2
    let [spaces, line, tail, e, tag, s] = GetStateInfo(s)
    let t = DictGetter3(ref, &filetype, tag)
    if empty(t)
        let t = DictGetter3(ref, tail, tag)
    endif
    if empty(t)
        let t = DictGetter3(ref, 'global', tag)
    endif
    if empty(t)
        let t = DictGetter3(g:wpsnippets, e, tag)
    endif
    if empty(t)
        return
    endif
    if IsObject(t)
        return SnippetFromObject(t, s)
    endif

    let parts = s:gsp(t, s)
    if s:llvf(t)
        return RunFunction(t, parts)
    endif
    let r = '\$(\{.{-}\}|\w+)(::\w+)?'
    return Sub(t, r, {s->SnippeteerHelper(s, parts, line)})
endfunction
function! Snippeteer(...)
    "test: va t vtry
    "test: va abc
    " let index = a:0 >= 2 ? a:2 : '.'

    let s = a:0 >= 1 ? a:1 : getline('.')
    let ref = g:wpsnippets2
    let [spaces, line, tail, e, tag, s] = GetStateInfo(s)

    " let template = DictGetter2(ref, tail, tag, ref, &filetype, tag, ref, 'global', tag, g:wpsnippets, e, tag)
    let template = DictGetter2(ref, &filetype, tag, ref, tail, tag, ref, 'global', tag, g:wpsnippets, e, tag)

    if empty(template)
        return 
    endif

    let parts = s:gsp(template, s)

    if s:llvf(template)
        let value = RunFunction(template, parts)
        return PlaceSnippet(value, spaces)
    endif

    let r = '\$(\{.{-}\}|\w+(\(.{-}\))?)(::\w+)?'
    let r = '\$(\{.{-}\}|\w+)(::\w+)?'
    let snippet = Sub(template, r, {s -> SnippeteerHelper(s, parts, line)})
    return PlaceSnippet(snippet, spaces)

endfunction



function DictGetter2(ref, ...)
    let ref = a:ref
    let keys = a:000
    let length = len(keys)
    let touched = 0
    let i = -1
    let findNextObject = 0
    while i < length
        let i += 1
        let key = keys[i]
        if i == length - 1
            " ec 'aaa'
            " ec key
            " ec [keys[i - 1]]
            " ec [keys[i - 2]]
            " ec has_key(ref, key)
            " ec i
            if findNextObject
                return 
            endif
            if touched > 0
                return get(ref, key, 0)
            else
                return 0
            endif
        elseif findNextObject
            if IsObject(key)
                let ref = key
                let findNextObject = 0
            endif
        elseif IsObject(key)
            let ref = key
        elseif has_key(ref, key)
            let next = ref[key]
            if IsObject(next)
                let ref = next
                let touched += 1
            else
                return next
            endif
        else
            let findNextObject = 1
        endif
    endwhile
endfunction
"
function Linebreak(n)
    return repeat('-', a:n)
endfunction
function! PySnippetTemplater2(match, parts, line)
    let match = a:match[1]
    let parts = a:parts
    let line = a:line
    let [a,b] = SplitOnce(line)

    if match == 'c'
        return '$c'
    elseif match ==# 'a'
        return a
    elseif match ==# 'date'
        return DateStamp()
    elseif match ==# 'b'
        return b
    elseif match ==# 'B'
        let B = "{\n    $c\n}"
        return B

    elseif Test(match, '^\d+')
        if match == '0'
            return line
        elseif match - 1 < len(parts)
            return parts[match - 1]
        else
            return ''
        endif
    elseif match =~ '^{'
        let match = match[1:-2]
        let match = Sub(match, '\$(\d+)', {s -> function('Quotify')(function('PySnippetTemplater')(s, parts, line))})
        return eval(match)
    endif
endfunction





function RunRefFromFileTail(ref, ...)
    let tail = Tail()
    let ref = get(a:ref, tail, 0)
    if empty(ref)
        return 0
    endif

    if IsString(ref)
        let v = call(function(ref), a:000)
        if v == 0
            return 0
        endif
    endif
    return 1
endfunction

function Sdfok()
        " let i = FindLineIndex('"dir"', '.', -1)
        " let dir = Match(getline(i), ': "\zs.{-}\ze"')
        " let file = GetQuote(getline('.'))
        " let buffer = PathJoin(dir, file)

        " if IsPdf(buffer)
            " return BasePY('vimFileOpener ' . buffer)
        " else
            " call OpenBuffer3(buffer)
        " endif
endfunction
function GFA1000(lang, fnName)
    let lang = a:lang
    let fnName = a:fnName
    let ref = {
        \'vim': 'vimrc',
        \'js': 'utils.js',
        \'py': 'next.py',
        \'javascript': 'utils.js',
        \'python': 'next.py',
    \}
    let file = ref[lang]
    call OpenBuffer3(file)
    return ExecuteFunctionSearch(fnName)    
endfunction
function GFA1001()
        " let file = getline(1)
        " let key = trim(getline('.'))
        " call OpenBuffer3(file)
        " return ExecuteFunctionRE(key)
    " elseif tail == 'changelog.md' && Test(t, '^\d+-\d+-\d+ action ')
        " return ExecuteAction(Replace(t, '^.{-}action +', ''))
endfunction
function DateTheFile(file, ...)
    let file = a:file
    if file == '/home/kdog3682/.vimrc'
        return 'vimrc.' . DateStamp()
    endif
    let date = a:0 >= 1 ? a:1 : DateStamp()
    let e = GetExtension(file)
    let file = RemoveExtension(Tail(file))
    return printf('%s.%s.%s', file, date, e)
    " this thing wont work for vim
    
endfunction
function GFA999(date, file)
    let date = a:date
    let file = a:file
    let path = PathJoin(g:depdir, DateTheFile(Tail(file), date))
    return path
endfunction
function GoFileViaHelpMD()
    let line = CurrentLine()
    let items = [
     \['^(\d+-\d+-\d+) *DEPRECATED +(.+)', 'Match2', 'GFA999'],
     \['file:.{-}(\w.+)', 'Match2', 0],
     \['(vim|js|javascript|py|python|css)\.(\w+)', 'Match2', 'GFA1000'],
    \]
    for item in items
        let [r, fnKey, action] = item
        let value = function(fnKey)(line, r)
        if Exists(value)
            if Exists(action)
                let value = call(function(action), ToArray2(value))
                if Exists(value) && IsFile(value)
                    call OpenBuffer3(value)
                    return 1
                endif
            elseif IsFile(value)
                call OpenBuffer3(value)
                return 1
            else
                ec 'mhssdmadfads not done yet at md helper'
                return 
            endif
        endif
    endfor
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




function MarkdownEnterList()
    let CR = "\<CR>"
    let TAB = "    "
    let DASH = " - "
    let BS = "\<BACKSPACE>"
    return CR . TAB . DASH
endfunction
function MarkdownExitList()
    let CR = "\<CR>"
    let TAB = "    "
    let DASH = " - "
    let BS = "\<BACKSPACE>"
    let n = GetListNumberIndex()
    let [backspaces, line] = GetBackspacesAndLine(n)
    let amount = max([GetIndent() - backspaces, 0])
    let r = amount % 4
    let n = float2nr(floor(amount / 4))
    let amount = r + n
    let back = repeat(BS, amount)

    if IsZero(n)
        return CR . CR . back
    endif

    let index = Match(line, '\d+')
    return CR . CR. back . (index + 1) . '. '
endfunction
function GetListNumberIndex()
    let i = line('.') - 1
    let c = 0
    while c < 100
      let c += 1
      let s = getline(i)
      if Test(s, '^ *\d+\.')
           return i
      endif
      let i -= 1
    endwhile
    throw 'ee'
endfunction
function IsNegativeOne(x)
    return type(a:x) != 1 && a:x == -1
endfunction

function IsZero(x)
    return type(a:x) != 1 && a:x == 0
endfunction


function! Print(...)
    let items = a:000
    if len(items) == 1
        ec items[0]
    else
        ec items
    endif
endfunction
function MarkdownWordFilter(s, key)
    let s = a:s
    let key = a:key
    let abrev = Abrev(s)
    let r = '^' . key
    if Test(s, r) || Test(Abrev(s), r)
        return 1
    endif
    return 0
endfunction
function Backspaces(s)
    return repeat(g:keyboard.BS, len(a:s))
endfunction

    " ec Backspaces()

function GetBackspacesAndLine(...)
    let line = a:0 >= 1 ? (IsNumber(a:1) ? getline(a:1) : a:1) : getline('.')
    let spaces = matchstr(line, '^ *')
    let s = matchstr(line, '\v\S.*')
    let n = len(spaces)
    return [n, s]
endfunction

function! FindallStrings(s, ...)
    let r = a:0 >= 1 ? a:1 : '[a-z]\w+'
    let s = ToString(a:s)
    let store = []
    call substitute(s, Regexed(r), '\=add(store, submatch(0))', 'g')
    return filter(store, 'Exists(v:val)')
endfunction

function! ToString(x)
    return IsString(a:x) ? a:x : empty(a:x) ? '' : join(a:x, "\n")
endfunction

function MarkdownTab()
    let a = getline('.')     " the line
    let b = col('.') - 1     " location of cursor on line
    let c = strpart(a, 0, b) " the line sliced from SOL to cursor
    let d = trim(c)
    let dd = TrimStart(c)
    let e = trim(strpart(a, b))
    let COMPLETER = "\<C-x>\<c-u>"
    let TAB = "    "

    if 0
        return TAB
    elseif d == '*'
        return Backspaces(dd) . TAB . '- '
    elseif d == '"-'
        return Backspaces(dd) . TAB . '* '
    elseif d == '-'
        return Backspaces(dd) . TAB . '- '
    elseif d == ''
        return TAB
    elseif empty(e)
        return TAB
    elseif d == ''
        return TAB
    else
        return COMPLETER
    endif
endfunction

function FindStart(...)
    let r = a:0 >= 1 ? a:1 : '\w'
        let line = getline('.')
        let col = col('.')
        let start = col - 1
        while start > 0 && line[start - 1] =~ r
            let start -= 1
        endwhile
        return start
endfunction
function FindStartWithSlash()
        let line = getline('.')
        let col = col('.')
        let start = col - 1
        let c = 0
        while start > 0
            let ch =  line[start - 1]
            if Test(ch, '\w')
                let c += 1
                let start -= 1
            elseif ch == '/' && c > 0
                return [start, 1]
                let start -= 1
            else
                break
            endif
        endwhile
        return [start, 0]
endfunction
function MarkdownComplete(findstart, base)
    if a:findstart
        return col('.') - len(s:vcharstring) - 1
    else
        return GetMarkdownWords(s:vcharstring)[0: g:pumheight]
    endif
endfunction
function! TrimStart(s)
    return substitute(a:s, '^\s\+', '', '')
endfunction

function GetCallableFromLine(...)
    let s = a:0 >= 1 ? a:1 : getline('.')
    let m = Match(s, '\w+\ze\(')
    return m
endfunction

function GetFunctionFromAnywhere()
        let k = GetCurrentWord()
        if !s:llvf(k)
            let k = GetCallableFromLine()
            if !s:llvf(k)
                let k = GetBindingName()
                if !s:llvf(k)
                    throw 'doesnt look like a function: ' . k
                endif
            endif
        endif
        return k
endfunction
function RunPasteBufferFunction(...)
    let arg = a:0 >= 1 ? a:1 : ''
    let k = GetPasteBuffer()
    if !s:llvf(k)
        call SetPasteBuffer('')
        let k = GetFunctionFromAnywhere()
    endif

    ec 'running: ' . k
    ec empty(arg) ? function(k)() : function(k)(arg)
endfunction
function Basdfaasdf()
    return 123
endfunction
function ToStringArgument(arg)
    "test: []
    let arg = a:arg
    if empty(arg)
        return ''
    elseif IsNumber(arg)
        return arg
    elseif IsString(arg)
        return SingleQuote(arg)
    else
        return json_encode(arg)
    endif
endfunction
function! Chdir(...)
    let arg = a:0 >= 1 && !empty(a:1) ? a:1 : Head()
    let s = DirGetter(arg)
    let cmd = 'cd ' . s
    ec cmd
    execute cmd
endfunction

function CurrentDirectory()
    return getcwd()
endfunction
function AssertGit(s) abort
    let s = a:s
    if Test(s, '^fatal')
        throw 'git error'
    endif
endfunction


function ExcuteInline(s)
    ec [a:s]
endfunction








augroup markdowngroup 
    " autocmd!
    " autocmd BufLeave * call AlwaysExitGoyo()
    " autocmd BufLeave *.md call ExitMarkdownAutoCommand()
    " autocmd BufNewFile,BufRead *.md set filetype=markdown
    " autocmd BufNewFile * call AutoCommandNewFile()
    " autocmd BufEnter *.js call InitTabbings()
    " autocmd BufNewFile,BufRead *m.txt set filetype=javascript
    " autocmd FileType python     :iabbrev <buffer> iff if:<left>
    " autocmd FileType javascript :iabbrev <buffer> iff if ()<left>
    " autocmd BufRead *.md call EnterMarkdownAutoCommand()
    " autocmd BufLeave *.md call ExitMarkdownAutoCommand()
    " autocmd BufNewFile,BufRead *.grammar set filetype=grammar
    " autocmd BufNewFile,BufRead *.components set filetype=component
    " autocmd VimEnter * call OnVimStartup()
    " autocmd BufNewFile,BufRead *.vue.js set filetype=vue
    " autocmd BufNewFile,BufRead *.txt set filetype=txt
    " autocmd BufNewFile,BufRead *.python set filetype=python
augroup END

function GoyoHandler()
    if exists(':Goyo')
        if &filetype == 'markdown'
            ec 'starting goyo'
            Goyo
            call ToggleHiddenAll()
        else
            ec 'goyo only for markdown files'
        endif
    else
        ec 'no goyo'
    endif
endfunction
function InGoyo()
    if exists('g:goyo_mode') && g:goyo_mode
        return 1
        echo "You are in GoYo mode"
    else
        return 0
        echo "You are not in GoYo mode"
    endif
endfunction
function AlwaysExitGoyo()
    if &filetype == 'markdown'
        if InGoyo()
            Goyo
        endif
    endif
endfunction


function! Date(n)
    let today = localtime()
    let tomorrow = today + (24 * 60 * 60) * a:n
    return strftime("%m-%d-%Y", tomorrow)
endfunction

function! TomorrowDate()
    let today = localtime()
    let tomorrow = today + 24 * 60 * 60
    return strftime("%m-%d-%Y", tomorrow)
endfunction

function! TimeIsAfter(n)
    let n = a:n + 12
    let currentTime = localtime()
    let hour = strftime("%H", currentTime)
    return hour >= n
endfunction



function SaveVim()
    let a = '/home/kdog3682/.vimrc'
    let b = g:budir
    call CopyFile(a, b . 'vimrc')
endfunction

function SaveHandler(s)
    let s = a:s
    if s == 'vim'
        call SaveVim()
    endif
endfunction

function GetVisualSelection()
    let a = getpos("'<")
    let b = getpos("'>")
    if a[1] == b[1]
        let s = getline(a[1])
        let x = a[2]
        let y = b[2]
        if x > y
            let t = x
            let x = y
            let y = t
        endif
        let v =  s[x - 1:y - 1]
        return v
    endif
endfunction
function! ABCCursor(...)
    let s = a:0 >= 1 ? a:1 : getline('.')
    let pos = col('.') - 1
    return [s[pos-1], s[pos], s[pos + 1]]
endfunction

function! ABCDECursor(...)
    let s = a:0 >= 1 ? a:1 : getline('.')
    let pos = col('.') - 1
    return [s[pos-2], s[pos-1], s[pos], s[pos + 1], s[pos + 2]]
endfunction

function! ABCDEFCursor(...)
    let s = a:0 >= 1 ? a:1 : getline('.')
    let pos = col('.')
    return [s[pos-3], s[pos-2], s[pos-1], s[pos], s[pos + 1]]
endfunction
function! SmartQuote()
    let [d, a, b,e, c] = ABCDECursor()
    " call AppendFile(g:mdtempfile, "[a,b,c]: " . string([a,b,c]))
    " [']
    " ['']
    " ('')
    " adfasdfadf '
    " * = ?
    " * = ''  ])
    " * = ''  ])
    " * = ''  ])
    " asdf'
    " asdf''
    " asdf['d', 'f', '', '', '']
    " return string([d, a, b,e, c])
    let double = "\'\'\<LEFT>"
    let single = "\'"
    let r = '\W' 
    let r2 = '\w' 
    if a == " " && b == "" && c == ""
        if Test(d, '\w')
            return double
        elseif d == '='
            return double 
        else
            return single
        endif

    elseif Test(a, '[a-z]')
        return single
    elseif a == "" && b == "" && c == ""
        return double
    elseif has_key(g:OPPOSITES, a) && has_key(g:OPPOSITES, b)
        if d == "\\" || g:OPPOSITES[a] != b
            return single
        else
            return double
        endif
    elseif b == "'"
        return g:keyboard.right
    elseif Test(a, r) || Test(b, r)
        return single
    elseif Test(a, r2) && Test(b, r2)
        return single
    else
        return double
    endif
endfunction



function SliceLineAtPos(s, pos)
    let s = a:s
    let pos = a:pos
    return [s[:pos], s[pos + 1:]]
endfunction

function ReplaceBrace()
    let s = getline('.')
    let pos = col('.') - 1
    let ch = s[pos]
    let ref = {
        \'<': '>',
        \'[': ']',
        \'{': '}',
    \}
    if has_key(ref, ch)
        let opp = ref[ch]
        let i = pos + 1
        while i < len(s)
            if opp == s[pos]
                break
            else
                let i += 1
            endif
        endwhile

        ec [i]
        return 
        " let [a,b] = SliceLineAtPos(s, pos)
        " let b =
    endif
    return ch
endfunction



function SmartNine(key)
    "test: {
    let left = a:key
    let key = a:key
    let isBrace = Test(a:key, '^[\[{]')
    if isBrace
        return a:key
    endif
    let right = get(g:OPPOSITES, key, 0)
    let RIGHT = "\<Right>"
    let LEFT = "\<LEFT>"
    let lrl = left . right . LEFT

    let s = getline('.')
    let [a,b,c] = ABCCursor(s)
    let front = strpart(s, 0, col('.'))

    " abc(def, abc['c', ')', ''])
    " abc(def, abc(asdfsdf(asdfasdf)))
    " abc(def, abc)
    " abc(def, abc)
    " const a = []
    if IsQuote(a) || IsQuote(b)
        return left
    elseif Test(a, '\w') && b == ')'
        return lrl
    elseif a == '\'
        return left
    elseif empty(b)
        return lrl
    elseif Test(b, '\w')
        """ bookmarkId: SmartNine-1697288344 hfel """
        return left . right . g:keyboard.left
        """""""""""""""""""""""""""""""""""""""""""""
        let lastchar = s[len(s) - 1]
        if Test(lastchar, '\w')
            return left . g:keyboard.co . 'A' . right
        else
            return left
        endif
    elseif has_key(g:OPPOSITES, b) && s[len(s) - 1] == g:OPPOSITES[b]
    "spanning to the end
        return left . g:keyboard.co . 'A' . right
    else
        return left
    endif
endfunction

function GetBindingAndValue(s)
    let s = a:s
    let m = Match2(s, '(\w+) *\= *(.+)')
    if Exists(m)
        return m
    endif
    return ['', '']
endfunction
function LineDittoOctober2023()
    let upline = trim(UpLine())
    let [upbinding, upvalue] = GetBindingAndValue(upline)
    if Exists(upbinding)
        if Test(upbinding, '^[a-z]$')
            let newbinding = IncrementLetter(upbinding)
            return Replace(upline, upbinding, newbinding)
        endif
    endif
endfunction

function! AssertionManager(value, ...) abort
    let checkpoint = a:0 >= 1 ? a:1 : 'Exists'
    if function(checkpoint)(a:value)
        return a:value
    else
        throw string(checkpoint) . ': ' . g:errors[checkpoint]
    endif
endfunction
function! GetBookmarkFromLine2(s)
    let bookmarkRE = "^ *[""/#']+\@bookmark +\zs\d+"
    let m = Match(a:s, bookmarkRE)
    let timestamp = AssertionManager(m)
    return "^ *[""/#']+\@bookmark " . timestamp
endfunction

function! GetUrlFromLine2(s)
    let urlFromlineRE = 'https:.{-}\ze( *$|["''<>,])'
    let m = Match(a:s, urlFromlineRE)
    return m
endfunction

function! GetFileFromLine2(s)
    "test: file: vim-data.txt
    "test: 'import { stringToJson } from "./stringToJson.js"'
    "expect: '/stringToJson.js'
    let fileFromlineRE = '\.?/[-a-z0-9_ ./]{-}\.(dialogue|vimrc|vim|json|js|txt|py|pdf|md|css|html)\ze(["'']| *$)|[a-z][-a-z0-9_./]+(dialogue|note|vimrc|vim|json|js|txt|py|pdf|md|css|html)\ze( *$|["''])'
    let m = Match(a:s, fileFromlineRE)
    return m
endfunction

function! MoveFile()
    let a = GetFileFromLine2(getline('.'))
    "/mnt/chromeos/GoogleDrive/MyDrive/JSONS/vim.json
    let [head,tail,e] = HeadAndTail(a)
    let b = head . AddExtension(input('new name'), e)
    let s = printf('!mv "%s" "%s"', a, b)
    ec printf('moving file: %s to %s', a, b)
    execute s
    return 1
endfunction

function! RevertFromLocalBackup(...)
    let a = '/home/kdog3682/localTemporaryBackupFile.txt'
    let b = g:memory.localTemporaryBackupFile
    if b != CurrentFile()
        call RedPrompt("
            \\n Your current file != %s
            \\n The files must match in order for the copying to happen.
            \\n Press anything to automatically switch to the file.
        \\n\n", b)
        call OpenBuffer3(b)
        return 
    endif
    call CopyFile(a, b)
endfunction

function! BackupFileLocally(...)
    let a = a:0 >= 1 ? a:1 : CurrentFile()
    let b = '/home/kdog3682/localTemporaryBackupFile.txt'
    call SetMemoryCache('localTemporaryBackupFile', a)
    call CopyFile(a, b)
endfunction
function! BackupFile(...)
    let a = a:0 >= 1 ? a:1 : CurrentFile()
    let b = g:budir . DateTheFile(a)
    call CopyFile(a, b)
endfunction
function! CopyFile(a, b)
    let a = a:a
    let b = a:b
    call system(printf('cp %s %s', a, b))
    ec b
    return 
    " call writefile(readfile(a), b)
    ec printf("successful copy on: %s", b)
    return 
    " call SilentExecute(
    echo "return", 1820
    ec BluePrint("
        \\n Copying ...
        \\n source: %s
        \\n to dest: %s
        \\n SUCCESS!
    \\n\n", a, b)
endfunction


function Asdf()
    
endfunction







function IsQuote(s)
   return Test(a:s, '^[''"]')
endfunction

function VimFunctionSearch(s)
    let s = a:s
    let r = '\v\C^(%s)'

    let text = ToString(GetLines(GI3('window')))
    let r = '\C[A-Z][A-Za-z0-9]{5,}'
    let words = Unique(FindallStrings(text, r))
    let regex = CreateRE2(s)
    let m = filter(words, 'Test(v:val, regex'))
endfunction

function CreateRE2(s, ...)
    let mode = a:0 >= 1 ? a:1 : 'both'
    "test: abc

    let s = trim(a:s)
    if len(s) == 1
        return s[0] . '\w{3,}'
    endif
    if mode == 'start'
        return s
    endif

    let letters = split(toupper(s), '\zs')
    let length = len(letters)

    let template =  'printf("[%s%s]", tolower(v:val), v:val)'
    let out = ''
    for i in range(length)
        if i == 0
            let ch = printf('[%s%s]', tolower(letters[i]), letters[i])
            let out .= ch
        else
            let ch = letters[i]
            let out .= ch
        endif

        if i == length - 1 
            let out .= '[a-zA-Z-_0-9]'
            let out .= '+'
        elseif i > 2
            let out .= '[a-zA-Z-_0-9]'
            let out .= '{-}'

        else
            let out .= '[a-z0-9]'
            let out .= '{-}'
        endif
    endfor

    if mode == 'abrev'
        return printf('\C(%s)', out)
    endif

    if mode == 'both'
        let t = 'printf("[%s%s]", tolower(v:val), v:val)'
        let out2 = join(map(copy(letters), t), '')
        return printf('\C(%s|%s)', out, out2)
    endif
endfunction


function MarkdownDash()
    return col('.') == 0 ? '- ' : '-'
endfunction



function MatchTheWordAndReplaceWithNearByWord()
    let word = GetCurrentWord()
    let word = GetCursorWord()
    return word
endfunction

function SmartEnterBlockFromBelow()
    execute "normal! O\<SPACE>\<SPACE>\<SPACE>\<SPACE>\<SPACE>"
    startinsert
    
endfunction

function SmartEnterBlockFromAbove()

endfunction
function SmartEnterBlock()
    
endfunction
function RegisterDictItem(a, b, c)
    let a = a:a
    let b = a:b
    let c = a:c
    let d = printf('let g:%s["%s"] = "%s"', a, b, c)
    return 
endfunction
function SmartReturn()
    let col = getpos('.')[2]
    let ind = GetIndent()
    let s = getline('.')
    " let slice =
    if Test(s, '^ *\w+ *$')
        return 'return ' . Match(s, '\w+') 
    elseif len(s[col:]) > 0
        let ms = Match(s, '\w+ \= ') 
        if Exists(ms)
            return "\<ESC>oreturn " . Match(s, '\w+\ze \= \w') 
        else
            return 
        endif
    else
        let ms = Match(UpLine(), '\w+\ze \= ') 
        return 'return ' . ms
    endif
endfunction


function! FindLineInArray(lines, start, pattern)
    let lines = a:lines
    let start = a:start
    let pattern = a:pattern
    for i in range(start, len(lines))
        let line = lines[i]
        if Test(line, pattern)
          return i
        endif
    endfor
    return -1
endfunction



function GetIdentifierFromLineNumberOrAbove(...)
    let n = a:0 >= 1 ? a:1 : line('.')
    let c = 0
    let re = s:jspy('identifierRE')
    while c < 5
        let c += 1
        let s = getline(n)
        if empty(s)
            let n -= 1
        endif
        let m = Match(s, re)
        if Exists(m)
             return m
        endif
    endwhile
endfunction

function ViewFunction(key)
    "deprecated ... see execRef.pre
    let library = LibraryLoader(&filetype)
    let s = get(library, a:key, 'no reference found for ' . a:key)
    ec s
endfunction
function! GetCurrentWord4(...)
    let s = a:0 >= 1 && !empty(a:1)     ? a:1 : getline('.')
    let start = a:0 >= 2 && !empty(a:2) ? a:2 : col('.')
    let regex = a:0 >= 3 && !empty(a:3) ? a:3 : '[a-z0-9\._-]+'

    let b = start
    let c = 0
    while c < 20
        if Test(s[start], '\w')
            let start += 1
        else
            break
        endif
    endwhile

    let a = start - 1
    let c = 0
    let temp = ''
    while c < 20
        let c += 1
        let ch = s[a]
        if !empty(temp)
            if ch == temp
                let a -= 1
                let temp = ''
            else
                continue
            endif
        elseif Test(ch, '\W') && !Test(ch, regex)
            if has_key(g:OPPOSITES, ch)
                let opp = g:OPPOSITES[ch]
                if In(s, opp)
                    let temp = g:OPPOSITES[ch]
                endif
            endif
            let a -= 1
        else
            break
        endif
    endwhile

    let store = []
    let c = 0
    while c < 30
        let c += 1
        let ch = s[a]
        if Test(ch, regex)
            let a -= 1
            call add(store, ch)
        else
            return join(reverse(store), '')
        endif
    endwhile
endfunction
function! LibraryLoader(s)

    let key = a:s
    let dir = '/mnt/chromeos/GoogleDrive/MyDrive/JSONS/'
    let vim = dir . 'vim.names.json'
    let python = dir . 'python.names.json'
    let javascript = dir . 'javascript.names.json'

    if key == 'vimkeys'
        if !exists('g:vimkeys')
            let g:vimkeys = keys(GetVim())
        endif
        return g:vimkeys
    endif

    if key == 'python'
        if !exists('g:python')
            let g:python = ReadJson(python)
        endif
        return g:python
    endif

    if key == 'javascript'
        if !exists('g:javascript')
            let g:javascript = ReadJson(javascript)
        endif
        return g:javascript
    endif
endfunction


function ThrowLog()
    "console.log(); throw 'abcxyz';" . GoLeft(6)
endfunction



function! SplitSpaces(...)
    let s = a:0 >= 1 ? a:1 : getline('.')
    return split(trim(s), ' \+')
endfunction

function! Fo()
    let @/ = 'abc'
endfunction
function! WriteFunctionViaAnythingHandler(s)
    let items = SplitSpaces(a:s)
endfunction
function! DashToPascal(s)
    return s:cap(s:sub(a:s, '-([a-z])', '\=s:cap(submatch(1))'))

endfunction
function VimCreateFunctionBase(name, params)
    "test: s:SearchAndMatch2023, [a, er]
    let name = a:name
    let s:name = Test(name, '^s:') ? tolower(name) : DashToPascal(name)
    let params = a:params
    
    if empty(s:name)
        return
    endif
    let top = ''
    function! Inner(i, s)
        let s = a:s
        if IsWord(s)
            return 1
        endif
        return 0
    endfunction
    let fParams = filter(copy(params), function('Inner'))
    if Exists(fParams)
        let t = 'printf("    let %s = a:%s", v:val, v:val)'
        let items = map(fParams, t)
        let top = join(items, "\n") . "\n"
    endif
    let t = "function! %s(%s)\n%s\t$c\nendfunction"
    let s = printf(t, s:name, join(params, ", "), top)
    return s
endfunction

function VimCreateFunctionBlockNormal()
    let [name, params] = GetFunctionNameAndParamsFromLine()
    let params = MaybeNewParams(name, params)
    let s = VimCreateFunctionBase(name, params)
    call s:appendblock(s, '$')
endfunction
function VimCreateFunctionBlock()
    let params = SplitSpaces()
    let name = remove(params, 0)
    let name = s:sub(name, '-', '_')
    if empty(params) && has_key(g:functionParamRef, name)
        let params = g:functionParamRef[name]
    endif
    let s = VimCreateFunctionBase(name, params)
    call PlaceSnippet2023(s, '')
    normal! zz
    startinsert!
endfunction





function GetLanguagePluginFile()
    return '/home/kdog3682/.vim/ftplugin/' . &filetype . '.vim'
endfunction
function ResourcePluginFile()
    let file = &filetype == 'vim' ? CurrentFile() : GetLanguagePluginFile()
    let cmd = "normal! source " . file
    ec cmd
    execute cmd
endfunction

    " GetIdentifierFromLineNumberOrAbove


function CheckExecRef(k)
    let k = a:k
    let v = get(g:execRef, k, '')
    let t = 'g:execRef has the key: %s with value: %s'
    let t2 = 'g:execRef does not have the key: %s'
    if Exists(v)
        call Echo(t, k, v)
    else
        call Echo(t2, k)
    endif

    let v = get(g:visualactiondict, k, '')
    let t = 'g:visualactiondict has the key: %s with value: %s'
    let t2 = 'g:visualactiondict does not have the key: %s'
    if Exists(v)
        call Echo(t, k, v)
    else
        call Echo(t2, k)
    endif

    " let v = get(g:ldrdict, k, '')
    " let t = 'g:ldrdict has the key: %s with value: %s'
    " if Exists(v)
        " call Echo(t, k, v)
    " else
    " endif

endfunction
function ExecuteRE(...)
   try
       execute Printf(a:000)
       return 1
   catch
       return 0
   endtry
endfunction
function GotoStartingDate()
   return ExecuteRE('?^%s', Comment(DateStamp()))
endfunction
function! s:boundary(s)
    let s = a:s
    let a = '<'
    let b = '>'
    if Test(s, '^\W') 
        let a = ''
    endif
    if Test(s, '\W$') 
        let b = ''
    endif

    return a . s . b
endfunction
function! Boundary(s)
    let s = a:s
    let a = '<'
    let b = '>'
    if Test(s, '^\W') 
        let a = ''
    endif
    if Test(s, '\W$') 
        let b = ''
    endif

    return a . s . b
endfunction
function Shuntdown3()
    let r = s:jspy('shuntdownGrabRE')
    let t = printf('\v^(//|#|") *(%s|%s)', Date(0), Date(-1))
    let start = search(t, 'bn', line('.') - 1000)
    if empty(start)
        return
    endif
    let end = line('$')
    let lines = GrabBetween(start, line('$'), r)
    call append('$', WrapLines(lines))
endfunction
function! Qge()
    return s:encode(eval(input('eval: ')))
endfunction



function JavascriptComplete(findstart, base)
    if a:findstart
        return FindStart()
    endif
    return GetJavascriptWords(a:base)[0: g:pumheight - 1]
endfunction
function VimComplete(findstart, base) abort
    if s:exists(s:vcharstring)
        if a:findstart
            return col('.') - len(s:vcharstring) - 1
        else
            return GetVimWords2(s:vcharstring)[0: g:pumheight - 1]
        endif
    else
        if a:findstart
            return FindStart('[a-zA-Z0-9:]')
        else
            return GetVimWords(a:base)[0: g:pumheight]
        endif
    endif
endfunction
function! In(items, key)
    let items = a:items
    let key = a:key
    return IsString(items) ? Test(items, Rescape2023(key)) : index(items, key) > -1
endfunction
function! Breaker(n)
    "test: 1
    let g:state.breakerCount += 1
    if g:state.breakerCount == a:n
        let g:state.breakerCount = 0
        throw 'breaker err'
    endif
        let g:state.breakerCount = 0
endfunction

function! GetJumps(n)
    function! Inner(s)
        let s = a:s
        let m = Match2(s, '^ *\d+ +(\d+) +(\d+) +(.+)')
        return {'text': m[2], 'col': m[1], 'line': m[0]}
    endfunction

    let jumps_list = execute('jumps')
    let jumps_lines = split(jumps_list, "\n")
    let lines = map(reverse(jumps_lines[-10:]), 'Inner(v:val)')
    let jumps_lines = lines
    return jumps_lines
endfunction

function! JumpController()
    let jumps_lines = GetJumps(5)
    let item = Choose2023(jumps_lines)
    return Jump(item.line)
endfunction
let g:javascriptReservedWords = [
  \"await",
  \"break",
  \"case",
  \"catch",
  \"class",
  \"const",
  \"do",
  \"else",
  \"false",
  \"for",
  \"if",
  \"in",
  \"let",
  \"new",
  \"null",
  \"super",
  \"this",
  \"throw",
  \"true",
  \"try",
  \"var",
  \"while",
  \"with",
  \"yield"
\]
function! WordSpiraler2(key, ...)
    let key = a:key
    let r = len(key) == 1 ? '<' . key . '[a-z0-9.]{6,}' : CreateRegexBase(key, '\C<($1|$2\w{3,})>')
    " call BlueInput('r: ' . string(r))
    let index = line('.') 
    let seen = []
    let w0 = line('w0')
    let w1 = line('w$')
    let indexes = [ [ w0, w1 ] ]
    if index - w0 < 10
        call add(indexes, [w0-20, w0 - 1])
        call add(indexes, [w1 + 1, w1 + 20])
    else
        call add(indexes, [w1 + 1, w1 + 20])
        call add(indexes, [w0-20, w0 - 1])
    endif
    for indexSet in indexes
        let store = WordSpiral(r, index, indexSet, seen)
        if s:exists(store)
        " call BlueInput('(store): ' . string((store)))
        "wordStalk
        " ws ws ws
        " ws
        " w
            return a:0 >= 1 ? a:1(store) : store
        endif
    endfor
endfunction
function GetVimWords(key) abort
    "test: ga

    let key = a:key
    " let s = getline('.')
    " let t = trim(s)

    if s:short
        let r = printf("^(let |function\\(?'?)?%s", key)
        let a = s:regexfilter(s:jspyfile('solWords'), r)
        let b = GetWordsBase(key)
        return s:extend(a, b)
    endif
    if s:test(key, 's:')
        return s:regexfilter2(VimScriptFunctions())
    endif

    if s:test(key, 'g:')
        return map(GetVimWords(key[2:]), '"g:" . v:val')
    endif

    return GetWordsBase(key)

endfunction

function! GetWordsBase(key)
    let key = a:key
    
    let r = CreateRegexBase(key, '\C<($1|$2\w{3,})>')
    " call BlueInput('r: ' . string(r))

    let b = s:jspyfile('nonSolWords')
    let c = s:jspyfile('highFrequencyWords')
    let a = WordSpiraler2(r)
    let d = s:regexfilter(s:concat(b, c), r)
    if s:exists(a)
        return s:concat(a, d)
    endif

    let a = DefaultWords(r)
    return s:concat(a, d)
endfunction
function! DefaultCompletionWords()
    if &filetype == 'markdown'
        return g:charlotte
    endif
    return LibraryWords()
endfunction
function! DefaultWords(r)
    let items = LoadLibraryItems()
    let words = map(copy(items), {i,x -> x.name})
    let store = s:regexfilter(words, a:r)
    return store
endfunction
function! s:regexfilter2(s, r)
    let s = a:s
    let r = a:r
    return s:regexfilter(s, '^' . r)
endfunction

function! GetJavascriptWords(key)
    let key = a:key

    if s:short
        let a = WordSpiraler2(key)
        let r = CreateRegexBase(key, '\C<($1|$2\w{3,})>')
        let b = s:jspyfile('solWords')
        let c = s:jspyfile('highFrequencyWords')
        let d = s:regexfilter(s:concat(b, c), r)
        return s:concat(a, d)
    endif

    return GetWordsBase(key)
endfunction

function! GetJavascriptWords2(key)
    let key = a:key

    let trimline = trim(getline('.'))
    if empty(trimline)
        let words = s:jspyfile('solWords')
        return s:regexfilter2(words, key)
    endif

    return GetWordsBase(key)
endfunction
function! VEval(state)
    let a = 'aaa'

    let state = a:state
    let iden = s:getiden(state.lines[-1])
    let ret = 'call s:prettyprint(' . iden . ')'
    let t = state.string . "\n" . ret
    ec t
    ec '---------------------'
    execute t
    ec '---------------------'
    return ret 
endfunction
let g:visualactiondict['e'] = {'fn': 'VEval'}

function! NormalTab()
    let i = s:gi('contiguous')
    return i
endfunction

function! Echo(...)
    let s = map(copy(a:000), 'string(v:val)')
    ec Printf(s)
endfunction
function GotoVimFunction(...)
    let v = a:0 >= 1 ? a:1 : GetFunctionFromAnywhere()
    if ExecuteFunctionSearch(v) 
        return 
    endif
    call OpenBuffer3('/home/kdog3682/.vim/ftplugin/functions.vim')
    if !ExecuteFunctionSearch(v) 
        call OpenBuffer3('/home/kdog3682/.vimrc')
    endif
endfunction
function! s:notin(items, ignore)
    "test: [1,2], [1]
    let items = a:items
    let ignore = a:ignore
    return filter(items, 'index(a:ignore, v:val) == -1')
endfunction
function GetFunctionFromLine2(...)
    " test: "s:sdf"
    let s = a:0 >= 1 ? a:1 : getline('.')
    let pos = col('.') - 1
    let ch = s[pos]
    if empty(trim(s))
        return 
    endif
    " if empty(trim(ch))
        " let ignore = ['call', 'function', 'return', 'const', 'let']
        " let words = s:notin(s:findall(s, '%(s:)?[a-z]\w{5,}'), ignore)
        " return sort(words)[-1]
    " endif
    let word = s:gcw()
    if s:exists(word) && len(word) > 5
        return word 
    else
        return Match(s, '%(s:)?\w+\ze\(')
    endif
endfunction


function GetFunctionFromLine()
        let k = GetCurrentWord()
        if !s:llvf(k)
            let k = GetCallableFromLine()
            if !s:llvf(k)
                return 
            endif
        endif
        return k
endfunction




function WordBeforeCursor()
    let s = getline('.')
    let start = getpos('.')[2]
    let store = []
    while start > 0
        let start -= 1
        let ch = s[start]
        if Test(ch, '\W')
            continue
        else
            call add(store, ch)
            while 1
                let start -= 1
                let ch = s[start]
                if Test(ch, '\W')
                    return join(reverse(store), '')
                else
                    call add(store, ch)
                endif
            endwhile
        endif
    endwhile

endfunction
function GetFunctionNameAndParamsFromLine(...)
    function! Inner(i, s)
        let i = a:i
        let s = trim(a:s)
        if IsWord(s)
            return s
        elseif s == '...'
            return s

        elseif IsQuote(s)
            return 's'
        else
            return 's'
        endif
    endfunction

    let s = a:0 >= 1 ? a:1 : getline('.') 
    let name = s:gcw()
    let name = s:sub(name, '-', '_')
    
    let keep = ['Inner', 'checkpoint', 'runner', 'lambda']

    let m = Match(s, name . '\zs\(\S.+')
    if empty(m)
        let name = Match(s, '\w+\ze\(')
        let name = s:sub(name, '-', '_')
        if empty(name)
            let m = GetCurrentWord4()
            return [m, []]
            " return word
            " throw 'none'
        endif
        let m = Match(s, name . '\zs\(\S.+')
    endif

    let m = m[1:-2]
    let p = split(m, ',')
    if len(p) > 3
        return [name, ['...']]
    endif
    let params = Filter2(map(p, function('Inner')))
    return [name, params]
endfunction

function JPCreateFunctionBlockNormal()
    let m = GetFunctionNameAndParamsFromLine()
    let [name, params] = m
    let t = "function %s(%s) {\n\t$c\n}"

    if has_key(g:memory.lambdaFunctionNames, name)
        let s = printf(t, name, join(params, ", "))
        let ind = GetIndent()
        normal! O
        call PlaceSnippet2023(s, ind)
    else
        let s = printf(t, name, join(params, ", "))
        call s:appendblock(s, '$')
    endif
endfunction
     

function! FunctionGetter(s)
    if IsFunction(a:s)
        return a:s
    elseif Exists(a:s)
        if Test(a:s, 'v:val')
            throw 'no vval allowed'
        endif
        return function(a:s)
    endif
endfunction




function! PlaceSnippet2024(s, ...)
    let s = TabsToSpaces(a:s)
    let spaces = a:0 >= 1 ? a:1 : CurrentSpaces()
    let cursorpos = GetCursorFromStringSnippet(s)
    let s = Replace(s, '\$c', '')
    call TextPlacement(s:sl(s), spaces)
    call SetCursor(cursorpos, spaces)
endfunction 


function TabsToSpaces(s)
    return Sub(a:s, '\t', repeat(' ', 4))
endfunction
function GetBindingPrefix()
    let r = '^(" *)?\w+'
    let i = search(Regexed(r), 'bn')
    ec [i]
    if empty(i)
        return
    endif
    return Match(getline(i), r)
endfunction



function! Depluralize(s)
    return Test(a:s, 's$') ? a:s[:-2] : a:s
endfunction

function RunFunction(s, a)
    let s = a:s
    let a = a:a
    return Exists(a) ? call(function(s), a) : function(s)()
endfunction






vnoremap l :<c-u>call VisualReplaceLine('')<left><left>
function! ExecuteNormal(s)
    let s = Sub(a:s, "\<", "\\<")
    let cmd = 'normal! ' . s
    execute cmd
endfunction

function! GetCursorFromStringSnippet(snippet)
    let lines = split(a:snippet, "\n")
    for [i, line] in Enumerate(lines)
        if line =~ '\$c'
            let ch = match(line, '\$c')
            return [Relative(i), ch]
        endif
    endfor
    return [Relative(i), len(lines[-1])]
endfunction

function! StringTemplateToCRTemplate(s)
    let s = a:s
    " let s = "\t\n\t"
    function! Inner(s)
        let s = a:s[0]
        if s == "\n"
            return "\<CR>" 
        elseif s == "\t"
            return "    "
        endif
    endfunction
    return substitute(s, "[\n\t]", function('Inner'), 'g')
endfunction



function JPCreateFunctionBlock()
    let s = getline('.')
    let runnerName = 'runner'


    if Test(s, '\(')
        let word = expand('<cword>')
        let c = 0
        while Test(word, '\W') && c < 10
            let c += 1
            execute "normal! \<LEFT>"
            let word = expand('<cword>')
        endwhile

        if Exists(word)
            let t = "normal! diwi" . runnerName
            execute printf(t)
            let paramWords = word

            execute printf("normal! O%s %s", runnerName, paramWords)
            startinsert!
            call JPCreateFunctionBlock()
        endif
        return 
    elseif Test(s, '\.(map|filter|reduce) *$')
        let m = Match(s, '\w+\.(map|filter|reduce)')
        let [a,b] = split(m, '\.')
        let arg = GetForIterationVariable(a)
        let t = "normal! a(runner)"
        execute printf(t)
        let paramWords = arg

        execute printf("normal! O%s %s", runnerName, paramWords)
        startinsert!
        call JPCreateFunctionBlock()
        return 
    endif

    let parts = SplitSpaces()
    let name = remove(parts, 0)
    let aliases = {
        \'tj': 'toJSON',
        \'ts': 'toString',
    \}
    let name = get(aliases, name,name)

    if !Exists(parts)
        if has_key(g:functionParamRef, name)
            let parts = ref[name]
        else
            " let r = name . '\(.+'
            " let m = Match(WindowText(), r)
            " if Exists(m)
                " let parts = FindallStrings(m, '\w+\ze[,\)]')
            " endif
        endif
    endif
    let params = join(parts, ', ')



    let ind = GetIndent()
    let t = ''
    if ind == 4
        let prefix = GetBindingPrefix()
        if prefix =~ 'class'
            let t = s:jspy('methodBlockTemplate')
        elseif prefix =~ '\vconst|let|var'
            let t = s:jspy('objectBlockTemplate')
        else
            let t = s:jspy('functionBlockTemplate')
        endif
    else
        let extra = ind == 0 ? "\n\n\n" : ''
        let t = s:jspy('functionBlockTemplate') . extra
    endif
    let s = printf(t, name, params) 
    if name == 'lambda'
        let s = 'return ' . s
    endif
    call PlaceSnippet2024(s)
    normal! zz
    startinsert!

endfunction

function! GetForIterationVariable(arg)
   let s = a:arg
   if empty(s)
       return ''
   endif
    if len(s) < 4
        return 'arg'
    elseif s == 'files'
       return 'file'

    elseif s == 'children'
       return 'child'
    elseif s == 'order'
        return 'key'
    elseif Test(s, 's$')
        return Replace(s[:-2], '^this\.', '')
    elseif Test(s, 'es$')
        return Replace(s[:-3], '^this\.', '')
    else
        return 'arg'
    endif
endfunction



function! CheckNormalVerbose(key)
    let key = a:key
    return CheckVerbose('n ' . key)
endfunction
function! CheckVerbose(key)
    "test: 'n ['
    ec 'checking verbose'

    let [a,b] = SplitOnce(a:key)
    let [b, buffer] = MConfig(b, ',')
    let buffer = buffer ? '<buffer> ' : ''
    let  ref = {
    	\'n': 'nmap',
    	\'i': 'imap',
    	\'v': 'vmap',
    \}
    let a = get(ref, a, a)
    let cmd = printf('verbose %s %s%s', a, buffer, b)
    ec cmd
    execute cmd
endfunction
function! Asdf()
    
    if IsNumber(s)
        return Cursor(s)

    elseif Test(s, '')
        let m = 
        return 

    elseif Test(s, '')
        let m = 
        return 

    elseif IsNumber(s)
        return

    elseif has_key(ref, a)
        let m = ref[a]
    else
        return 
endfunction
function! MarkdownSmartDash()
    let s = getline('.')
    let [a, prev, current, next, e] = ABCDECursor(s)

    if empty(trim(s))
        return '- '
    elseif Test(prev, '\d')
        return ' - '

    elseif Test(prev, '-')
        return '- '
    elseif Test(prev, '[a-z]')
        return '-'
    elseif Test(a . prev, '[a-z]-')
        return g:keyboard.BS . " - "

    elseif Test(a . prev, '--')
        return repeat('-', 40) . g:keyboard.NL

    elseif Test(a . prev, '[a-z]-')
        return g:keyboard.BS . " - "
    else
        return 
    endif
endfunction

function! RegisterGfgfBookmarkforNonFunctions()
    let s = getline('.')
    let r = fooga
endfunction




function! WriteMappings()
    redir! > mappings.txt
    map <buffer>
    imap <buffer>
    inoreab <buffer>
    iab <buffer>
    redir END
endfunction

command! WriteMappings call WriteMappings()







function! JavascriptSmartBracket()
    
    "
    "
    " asdf({asdfasdf}ddsd)
    " asdf(asdfasdf)
    " asdf(asdfasdf)
    let [a, b, c, d, e] = ABCDECursor()
    if Test(b, '\(') && Test(d, '[a-z]')
        return "{\<C-O>/)/e\<CR>}"
    elseif Test(d, '\w')
        return '{'
    " elseif Test(d, '')
        " return "{"
    else
        return "{}" . g:keyboard.left
    endif


endfunction
function! SortByLength(store, reverse)
    function! Backward(a, b)
        let a = a:a
        let b = a:b
        return len(a) > len(b) ? -1 : len(a) < len(b) ? 1 : 0
    endfunction

    function! Forward(a, b)
        let a = a:a
        let b = a:b
        return len(a) < len(b) ? -1 : len(a) > len(b) ? 1 : 0
    endfunction
    let store = a:store
    let key = a:reverse ? 'Backward' : 'Forward'
    return sort(store, key)
    
endfunction


function! QTNormalRunner()
    ec function(g:vimCurrentTestFunction)()
endfunction

function! TestingSearchInsideOfExprViaQT()
    let value = ''
    try
        let value = call(function(g:vimCurrentTestFunction), g:vimCurrentTestFunctionArgs)
    catch
        return "\<ESC>o\<TAB>" . s:jspy('lineCommentPrefix') . v:exception


        
            call Red(v:exception)
        if !Test(v:exception, 'too many args')
            call Red(v:exception)
            return
        endif
        try
            let value =  call(function(g:vimCurrentTestFunction), ['arg1'])
        catch
            let value =  call(function(g:vimCurrentTestFunction), [['arg1', 'arg2']])
        endtry
    endtry
    return value
    " return Test(value, '[)
    

    " searching backward
    " execute "normal! ?$c?e\<CR>"
    " ab$e
    " abc"abc"
    " abcde""
    " abc##  ##
    " ab$cd

    " execute "normal! /)/e\<CR>"
    " abc
    " abc"abc"
    " abcde""
    " abc##  ##

    " Testing WordBeforeCursor
    " let word = expand('<cword>')
    " let word = WordBeforeCursor()
    " return '"' . word . '"'
    " ec word

endfunction
let g:runnerParamCache = {}
function JPCreateFunctionBlockAsExpression()
    let s = getline('.')
    let runnerName = 'runner'

    let w = s:gcw()
    if s:t(w, 'checkpoint|runner')
        let start = s:match(trim(s), '\w+%(\.\w+)*')
        let ps = ''
        if has_key(g:runnerParamCache, start)
            let ps = g:runnerParamCache[start]
        else
            let args = [
                \'node',
                \'s',
                \'arg',
                \'child',
                \'item',
                \'el',
                \'element',
            \]
            let ps = s:pick(args)
            call DictSetter('g:runnerParamCache', start, ps)
        endif
        return "\<ESC>Ofunction " . w . "(" . ps . ") {\<CR>}\<CR>\<ESC>?{\<CR>o"
    endif

    let m = Match(s, '\w+\.(map|fil|red)\w* *$')
    if Exists(m)
        let [a,b] = split(trim(m), '\.')
        let l = len(b)
        let [arg, b] = MGet(b, '^(map|filt?e?r?|redu?c?e?)')
        " return string([arg, b, m])
        "asdf.map
        let i = ''
        let argAliases = {
            \'kv': '[k,v]',
        \}
        if empty(arg)
            let arg = GetForIterationVariable(a)
        else
            let [arg, i] = MGet(arg, 'i$')
            if Test(arg, '^(ab|ba|kv|vk)')
                let arg = '[' . join(split(arg, '\zs'), ',') . ']'
            elseif has_key(argAliases, arg)
                let arg = argAliases[arg]
            endif
        endif
        let aliases = {
            \'m': 'map',
            \'f': 'filter',
            \'r': 'reduce',
        \}
        let method = aliases[b[0]]
        let template = g:expressionTemplates[method]
        if Exists(i)
            let arg .= ', i'
        endif
        return Backspaces(l) . printf(template, method, arg)
    endif

    let word = GetCurrentWord4(s)

    if Test(word, 'lam|runner') && Test(s, word . '\)')
        let firstCallableOnLine = Match(s, '\w+\ze\(')
        if has_key(g:jspab, firstCallableOnLine)
            let Item = g:jspab[firstCallableOnLine]
            let params = get(Item, 'params', '')
            let body = get(Item, 'body', '')
            let cmd = "\<ESC>diwi(%s) => {\<CR>}\<ESC>O%s"

            return printf(cmd, params, body)
            " example case
            " dict(asdfads, lam)
        else
            return "\<ESC>diwi(arg) => {\<CR>}\<ESC>O"
        endif
    endif

    let m = Match(s, '\(.{-}\)\ze *$')
    if Exists(m)
        let b = "(%s => {\<CR>}\<C-O>O"
        let b = printf(b, m)
        return Backspaces(len(m) - 1) . b
    endif

    let parts = SplitSpaces()
    let ind = GetIndent()
    if len(parts) == 0
        let parts = ind == 4 ? ['runner', 'x'] : ['foo', 's']
    endif

    "test: 
    " return string(parts)
    " []
    " a['a']

    let nameKey = remove(parts, 0)
    let aliases = {
        \'tj': 'toJSON',
        \'ts': 'toString',
    \}
    let name = get(aliases, nameKey,nameKey)

    if !Exists(parts)
        if has_key(g:functionParamRef, name)
            let parts = ref[name]
        else
        endif
    endif
    let params = join(parts, ', ')

    let t = ''
    if ind == 4
        let prefix = GetBindingPrefix()
        if prefix =~ 'class'
            let t = s:jspy('methodBlockTemplate')
        elseif prefix =~ '\vconst|let|var'
            let t = s:jspy('objectBlockTemplate')
        else
            let t = s:jspy('functionBlockTemplate')
        endif
    else
        let t = s:jspy('functionBlockTemplate') . '' 
    endif
    if s:test(t, '\$c')
        let t = t = sub('\')
    endif
    return Backspaces(trim(s)) . printf(t, name, params) 
endfunction

function! JankyWordBeforeCursor()
        let word = expand('<cword>')
        let c = 0
        while Test(word, '\W') && c < 10
            let c += 1
            execute "normal! \<LEFT>"
            let word = expand('<cword>')
        endwhile
        return word
endfunction
function! MarkdownDownLeft()
    " Exit the block from above
    return "\<C-O>\<BS>\<ESC>"
endfunction

function! MarkdownDownRight()
    " enter the block from above
    return "\<C-O>\<BS>\<ESC>"
endfunction

function! MarkdownEnter()
    return "\<C-O>\<BS>\<ESC>"
endfunction

function! MarkdownExit()
    
endfunction

function! MarkdownModeSearch(mode)
    return '?todo' . "\<ESC>"

    let mode = a:mode
    let prefix = '\v^["#]?' . g:dateRE . ' *'
    return prefix . mode . "\<CR>"
endfunction

function! DictString(...)
    let args = Flat(a:000)
    
    let length = len(args)
    let t = ''
    for i in range(length)
        let el = args[i]
        if i == 0
            let t .= 'let ' . el
        elseif i == length - 1
            let t .= " = \"" . el . "\""
        else
            let t .= '["' . el . '"]'
        endif
    endfor
    return t
endfunction
function! DefineDictItem(...)
    let t = DictString(a:000)
    call AppendAndExecute(t)
endfunction
function! Printf(...)
    return call(function('printf'), Flat(a:000))
endfunction

function! DefinePabDictItem(s)
    let [a,b] = SplitOnce(a:s)
    return DefineDictItem('g:jspab', a, {'params': b})
endfunction

function! GetAbrevAndName()
    let name = GetCurrentWord4()
    let s = getline('.')

    if !s:llvf(name) && trim(s) != name
        let name = GetBindingName()
    endif
    let abrev = Abrev(name)[0:2]
    return [abrev, name]
endfunction
function! IsSol()
    let s = getline('.')
    let pos = col('.') - 1
    let slice = s[0:pos]
    return len(trim(slice)) <= 1
endfunction
function! IsEmptyLine()
    return len(trim(getline('.'))) == 0
endfunction




 " if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'


function! ListMonths()
    call complete(col('.') - b:completionLength, b:completionWords)
    return ''
endfunction
    
function! Evaluate(s)
    try
        return eval(a:s)
    catch
        return 
    endtry
endfunction
function! QSlashWordFind(...)
    return QQ()
    let w = GetCurrentWord5()
    let evaled = Evaluate('g:' . get(g:globalAliases, w, w))
    if Exists(evaled)
        return Backspaces(len(w)) .evaled
    endif
    let t = "v:val[0] == w[0] && (Test(v:val, '^' . w) || Test(Abrev(v:val), '^' . w))"
    let filtered = filter(copy(b:screenWords), t)
    let b:completionLength = len(w)
    let b:completionWords = SortByLength(filtered, 1)
    return "\<C-R>=ListMonths()\<CR>"
endfunction




function! GetCurrentWord5()
    let store = []
    let r = '[a-z0-9]+'
    let s = getline('.')
    let a = col('.') - 2
    let c = 0
    while c < 20
        let c += 1
        let ch = s[a]
        let ch = s[a]
        if Test(ch, r)
            let a -= 1
            call add(store, ch)
        else
            return join(reverse(store), '')
        endif
    endwhile
endfunction

function! Choose2(items) abort
    let items = a:items
    if empty(items)
        return 
    endif
    if len(items) == 0
        return
    elseif len(items) == 1
        return items[0]
    else
        return items[0:8][InputChar() - 1]
    endif
endfunction


function GetJavascript()
    let javascript = '/mnt/chromeos/GoogleDrive/MyDrive/JSONS/javascript.names.json'
    if !exists('g:javascript')
        let g:javascript = js_decode(join(readfile(javascript)))
    endif
    return g:javascript
endfunction

function GetPython()
    let python = '/mnt/chromeos/GoogleDrive/MyDrive/JSONS/python.names.json'
    if !exists('g:python')
        let g:python = js_decode(join(readfile(python)))
    endif
    return g:python
endfunction

function GetVim()
    let vim = '/mnt/chromeos/GoogleDrive/MyDrive/JSONS/vim.names.json'
    if empty(g:vim)
        let g:vim = js_decode(join(readfile(vim)))
    endif
    return g:vim 
endfunction

function JavascriptLambdaExpression()
    let s = getline('.')
    let m = Match(s, '\w+\ze(\.\w+)+\(|\w+\(\zs\w+')
    let paramString = GetForIterationVariable(m)
    return printf("(%s) => " . g:keyboard.lambda, paramString)
    return printf("(%s) =>", paramString)
endfunction


function! SliceToCursor()
        let s = getline('.')
    let pos = col('.') - 2
    return s[0:pos]

endfunction


function! VReplaceWithinRange(state)
    let state = a:state
    let start = state.start
    let end = state.end
    let regex = GetCurrentWord4()
    let replacement = Exists(state.arg) ? state.arg : GetPasteBuffer()
    let t = printf("%s,%ss/%s/%s/g", start, end, regex, replacement)
    ec t
    execute "normal! " . t
endfunction

function! ConditionalTemplater(s)
    let s = a:s
    let args = FindallStrings(s, '\$\zs\w+')
    for i in range(len(args))
        let arg = args[i]
        let value = GetVimStateArg(arg)
        if empty(value)
            return ''
        endif
        let s = Sub(s, '\$' . arg, value)
    endfor
    return s
endfunction
function! GetUpbinding(...)
    let n = a:0 >= 1 ? a:1 : line('.')
    let s = getline(n - 1)
    return GetIdentifier(s)
endfunction

function! GetIdentifier(s)
    let s = a:s
    let r = '^(var|let|const|async|function[!*]?|class|def) \zs[a-z0-9:_$]+'
    return Match(s, r . '|[a-z0-9:_$]+\ze *\=')
endfunction


function! GetFunctionInfo()
    let i = GetFunctionIndex()
    let s = getline(i)
    let name = GetIdentifier(s)
    let params = FindallStrings(Match(s, '\(.{-}\)'), '\w+|\.\.\.')
    return [name, i, params]
endfunction
function! ExecuteFunctionCaller2()
    let [name, index, params] = GetFunctionInfo()
    let value = 0
    let a = g:debug
    let g:debug = 1
    let t = ''
    let s = getline('$')
    let s = Match(s, '^" *override *[:"]+ *\zs\S{2,}.+')
    " call BlueInput('s: ' . string(s))
    if s:exists(s)
        ec eval(s)
        let g:debug = 0
        return 
    endif

    if len(params) == 0
        let t = StringCall(name)
    else
        let s = getline('.')
        let s = Match(s, '" *test *[:"]+ *\zs.+')
        if !Exists(s)
            let s = getline(index + 1)
            let s = Match(s, '" *test *[:"]+ *\zs.+')
        endif
        let t = StringCall(name, s)
    endif

    let value = ''
    try
        let value = eval(t)
    catch
        let error = v:exception
        if Test(error, 'Not enough arguments for function: ' . name)
            let t = StringCall(name, 1)
            let value = eval(t)
        else
            let value = error
        endif
    endtry
    call BluePrint("
        \\n callstring: %s
        \\n results: %s
    \\n\n", t, value)
    let g:debug = 0
    return value
endfunction


    "abcdogCat1


    "abxy
function! GetFirstWord(s)
    let s = a:s
    return Match(s, '[a-z]\w+')
endfunction

function! s:gsr(indexes, F, ...)
    let [a,b] = a:indexes
    let spaces = a:0 >= 1 ? 1 : 0
    let s:F = s:fngetter(a:F)
    for i in range(a, b)
        call setline(i, s:F(getline(i)))
    endfor
endfunction
function! s:gsl(Fn, ...)
   let i = a:0 >= 1 ? a:1 : line('.')
   let [spaces, line] = GetSpacesAndLine(i)
   let value = s:fngetter2(a:Fn)(line)
   " ec a:Fn
   " let value = s:isstring(a:Fn) ? function(a:Fn)(line) : a:Fn(line)
   if Exists(value)
       call setline(i, spaces . value)
   endif
endfunction

function! s:getsetline(Fn, ...)
   let i = a:0 >= 1 ? a:1 : line('.')
   let [spaces, line] = GetSpacesAndLine(i)
   let value = (IsString(a:Fn) ? function(a:Fn) : a:Fn)(line)
   if Exists(value)
       call setline(i, spaces . value)
   endif
endfunction
function! GetSetLine2023(...)
   let i = a:0 >= 1 ? a:1 : line('.')
   let Fn = a:0 >= 2 ? a:2 : 'Inner'
   let [spaces, line] = GetSpacesAndLine(i)
   let value = function(Fn)(line)
   if Exists(value)
       call setline(i, spaces . value)
   endif
endfunction

function! GetSetRange2023(indexes, )
   let indexes = a:0 >= 1 ? a:1 : VisualOrBlockIndexes()
   let fnKey = a:0 >= 2 ? a:2 : 'Inner'

   let [a,b] = indexes
   for i in range(a, b)
        call GetSetLine2023(i, fnKey)
   endfor
endfunction
function! OpenDirectory3(s)
    execute "Explore " . a:s
endfunction

function! VimEEBlock()
    let cmd = "if\<CR>\"\<CR>\<BS>elseif \<CR>\<TAB>\"\<CR>\<BS>else\<CR>\"\<CR>\<BS>endif\<CR>\<ESC>?\\v<if>?e\<CR>A" 
    return cmd
endfunction
function! OpenFunction(name, ...)
    let name = a:name
    if empty(name)
        return 
    endif
    let gm = a:0 >= 1 && !empty(a:1) ? 1 : 0
    let prefix = Exists(gm) ? g:bindingPrefixInnerRE : g:functionPrefixRE
    let r = prefix . name . '>'
        let res = ExecuteRegex(r, 0, 0, 'zt')
endfunction

function! GetGlobalBookmark(s)
    return Test(a:s, 'GBM') ? GetFileFromLine2(a:s) : 0
endfunction
function! OpenGlobalBookmark(file)
    let file = a:file
    call OpenBuffer3(file)
    call ExecuteRegex('\CGBM')

endfunction
function! GoFile()
    """ localBookmarkId: 1697717268 """

    let fileRE = '\.?/[-+a-z0-9_ ./]{-}\.%(dialogue|vimrc|vim|json|js|txt|py|pdf|md|css|html)\ze%(["'']| *$)|[a-z][-a-z+0-9_./]+%(dialogue|note|vimrc|vim|json|js|txt|py|pdf|md|css|html)\ze%( *$|["''])'
    let lastSetRE = 'last set from (.{-}) line (\d+)'
    let gvarRE = 'g:\S{1,}%(file|dir)'

    " 'vim.json'
    let items = [
        \{'r': lastSetRE, 'type': 'fileFirst'},
        \{'r': '^\{.+} *$', 'type': 'json'},
        \{'r': 'https:.{-}\ze( *$|["''<>,])', 'type': 'url'},
        \{'r': 'linkedBookmarkId: (\d{10}) (\S{5,})', 'type': 'file'},
        \{'r': fileRE, 'type': 'file'},
        \{'r': gvarRE, 'type': 'gvar'},
        \{'r': 'bookmarkId: (\d{10}) (\S{5,})', 'type': 'file'},
        \{'r': '/[a-z][a-z0-9_/.-]{6,}', 'type': 'dir'},
        \{'r': '%(local)?BookmarkId: (\d{10})', 'type': 'bookmark'},
        \{'function': 'GetFunctionFromLine2', 'type': 'function'}
    \]

    let s = getline('.')
    for item in items
        let m = ''
        if has_key(item, 'r')
            let m = s:match(s, item.r)
        else
            let m = function(item.function)(s)
        endif

        if s:empty(m)
            continue
        endif

        if item.type == "fileFirst"
            " ["n  er          * :call EchoTemplate('er')<CR>","\tLast set from ~/.vim/ftplugin/variables.10-12-2023.vim line 667"]
            call s:open(m[0], m[1])
        elseif item.type == "file"
            " 'vim.json'
            if IsArray(m)
                let [id, file] = m
                call OpenBuffer3(file)
                call ExecuteRegex(id)
            else
                call OpenBuffer3(m)
            endif
        elseif item.type == "json"
            let value = eval(m)
            call s:open(value.file, value.timestamp)
        elseif item.type == "gvar"
            try
                let val = eval(m)
                if s:isdir(val)
                    execute ':e ' . val
                else
                    call OpenBuffer3(val)
                endif
            catch
                let error = v:exception
                return 
            endtry
        elseif item.type == "bookmark"
            call ExecuteRegex(m)
        elseif item.type == "dir"
            call OpenDirectory3(m)
        elseif item.type == "url"
            call XdgOpen(m)
        elseif item.type == "function"
            try
                call OpenFunction(m)
            catch
                let error = v:exception
                ec error
                call OpenFileOpenFunction(m)
            endtry
        endif
        return 
    endfor
endfunction
function! GoFile1() abort
    " if RunRefFromFileTail(g:gofiledict)
        " return
    " endif

        """ bookmarkId: GoFile-1697313938 gen a json via js """
        " \ {'r': 'bookmarkID: , 'OpenGlobalBookmark'],
        """""""""""""""""""""""""""""""""""""""""""""""""""""""
    let runners = [
        \ ['GetGlobalBookmark', 'OpenGlobalBookmark'],
        \ ['GetFileFromLine2', 'OpenBuffer4'],
        \ ['GetDirFromLine2', 'OpenDirectory3'],
        \ ['GetUrlFromLine2', 'OpenBrowser'],
        \ ['GetBookmarkFromLine2', 'ExecuteRegex'],
        \ ['GetFunctionFromLine2', 'OpenFunction'],
    \]

    let s = getline('.')
    for [fnKey, handler] in runners
        try
            let v = function(fnKey)(s)
            if empty(v)
                continue
            endif
            try
                return function(handler)(v)
            catch
                let error = v:exception
                ec 'FATAL: ' . error
                return 
            endtry
        catch
            let error = v:exception
            continue
        endtry
    endfor
    ec 'no matches'
endfunction

function! GetDirFromLine2(s)
    "test: "const jsondir = '/mnt/chromeos/GoogleDrive/MyDrive/JSONS/'"
    "expect: '/mnt/chromeos/GoogleDrive/MyDrive/JSONS/'
    let r = '/[a-z][a-z0-9_/.-]{6,}'
    let m = Match(a:s, r)

    return AssertionManager(m, 'IsDir')
endfunction
function! SetGlobalBookmark()
    let t = strftime('%s')
    let file = CurrentFile()
    call AppendHelpMD('GBM ' . file)
    return Comment('GBM') . "\<C-C>"
endfunction



function! RegisterEqualDict()
    let s = getline('.')

    let m = Match(s, '(\w+|[{\[].{-}[}\]]) *\= *.+')
    if empty(m)
        return 
    endif
    let m = SplitOnce(m, '\v *\= *')
    let t = "let g:jspyref3['%s']['equalDict']['%s'] = '%s'"
    let u = printf(t, &filetype, m[0], m[1])
    call AppendAndExecute(u)
endfunction

    " call(function(g:vimCurrentNormalFunction), g:vimCurrentNormalFunctionArgs)


function! s:regexfilter(items, r)
    let items = a:items
    if empty(items)
        return []
    endif
    let r = a:r
    return filter(copy(items), 's:t(v:val, a:r)')
endfunction
function! Filter2(items, ...)
    let key = a:0 >= 1 ? a:1 : 'Exists'
    let T = key == 'Exists' ? 'Exists(v:val)' : s:llvf(key) ? function(key) : 'Test(v:val, key)'
    return filter(copy(a:items), T)
endfunction

function! Map2(items)
    let items = a:items
    return map(copy(a:items), 'Inner(v:val)')
endfunction

function! SplitOnce2(s, ...)
    let s = trim(a:s)
    let r = a:0 >= 1 ? a:1 : ' +'
    let r = printf('^(.{-})%s(.+)', r)
    let m = Match2(s, r)
    if Exists(m)
        return m
    else
        return [s, '']
    endif
endfunction

function! SearchAndMatch2023(r)
    let r = '\v' . a:r
    let i = search(r, 'bn', line('.') - 500)
    if Exists(i)
        return matchstr(getline(i), r)
    endif
endfunction

function! Search2023(r)
    return search('\v' . a:r, 'bn', line('.') - 500)
endfunction



function! CommandSlash()
    return '/'
    let t = getcmdtype()
    let ref = {
        \'abc': 'def',
    \}
    if t != '/'
        return '/'
    endif

    let s = getcmdline()
    if Test(s, '^(call|fohhho|bdddar)')
        return '/'
    endif

    let p = getcmdpos()
    let infront = strpart(s, p - 1)
    if len(infront) > 0
        return '/'
    endif

    let m = strpart(s, 0, p)
    if len(m) > 3
        return '/'
    endif

    let t = CreateRE(m, '(%s|%s)')
    let prefix = '(var|const|async|function[!*]\?|class|def) '
    let backwards = "\<ESC>?"
    let t = backwards . '\v\C^' . prefix . t
    return TextExpr(t, len(m), g:keyboard.enter)
endfunction
function! VimscriptEcho()
    let store = GetUpbindings()
    if empty(store)
        return g:keyboard.exit
    else
        let items = MapPrint(reverse(store), '"$1: " . Stringer($1)')
        return 'return string(' . Arrify(items) .')' . g:keyboard.exit
    endif
endfunction
function! MapPrint(items, template)
    let items = a:items
    let s:template = a:template
    function! Inner(s)
        let s = a:s
        return Templater2(s:template, s)
    endfunction
    return Map2(items)
endfunction
function! JavascriptEcho()
    let store = GetUpbindings()
    if empty(store)
        return g:keyboard.exit
    else
        let items = map(reverse(store), {i,s -> printf("blue('%s', %s)" . "\<CR>", s, s)})
        let c = join(items, '')
        if len(store) == 1
            let c = c[:-2]
        else
            let c = "\<CR>" . c
        endif
        return c . g:keyboard.eat
    endif
endfunction
function! ExecuteRegex(r, ...) "dir flags movement
    let r = a:r
    let base = "\\v" . a:r
    let prefix = a:0 >= 1 && !empty(a:1) ? '?' : '/'
    let flags = a:0 >= 2 && !empty(a:2) ? prefix . 'e' : ''
    let flags = ''
    let movement = a:0 >= 3 ? a:1 : ''
    let r = prefix . base . flags

    try
        execute "normal! m'"
        :silent execute r
        if !empty(movement)
            " return scroll
            " execute movement
            return 
        endif
        return 1
    catch
        throw 'no regex match for: ' . r
        return 0
    endtry
endfunction




function! EchoGetValue()
     eturn m
endfunction

function! EchoTemplate(key)
    let aliases = {
    	\'el': 'echoLogTemplate',
    	\'ei': 'echoInputTemplate',
    	\'ew': 'echoWordTemplate',
    	\'er': 'echoReturnTemplate',
    \}

    let template = s:jspy(get(aliases, a:key, a:key))
    let m = s:getidenstr(getline('.'), 1)
    let s = s:templater2(template, m)
    call s:appendbelow(s)
endfunction

function! s:wrapper(x, d)
    " test: "asdf", "[]"
    let x = a:x
    let d = a:d
    let a = d[0: len(d)/2 - 1]
    let b = d[len(d)/2]
    return a . x . b
endfunction

function! DefineImap(...)
    let [a, b] = DefineEatHelper(a:0 >= 1 ? a:1 : '')
    return DefineMapItem('inoremap', a, b)
endfunction

function! DefineNmap(...)
    let [a, b] = DefineEatHelper(a:0 >= 1 ? a:1 : '')
    return DefineMapItem('nnoremap', a, b)
endfunction

function! ConfirmProceed(...)
    call Blue(Printf(a:000))
    return input('')
endfunction
function! DefineER(...)
    let [a, b] = DefineEatHelper(a:0 >= 1 ? a:1 : '')
    let b = Sub(b, '\W+', '')
    if has_key(g:execRef2, a)
        let prev = g:execRef2[a]
        call BluePrompt('Overwriting g:execRef2[%s] = %s', a, prev)
    endif
    return DefineDictItem('g:execRef2', a, b)
endfunction
function! ToggleDebugMode()
    let g:debug = g:debug ? 0 : 1
    ec 'g:debug = ' . g:debug
endfunction
function! s:sfar(s)
    let s = a:s
    let t = SplitSpaces(s)
    let key = remove(t, 0)
    return [key, t]
endfunction
function! s:ss(s)
    let s = a:s
    return SplitSpaces(s)
endfunction
function! RegisterDictItemsHandler(s)
    let s = a:s
    let t = s:ss(s)
    return call(DefineMapItem, t)
endfunction
function! VMoveBlockOutwards(state)
    let state = a:state
    let i = FindLineIndex('^\w', state.start, -1)
    let lines = WrapLines(Dedent(state.lines))
    call DeleteBlock(state.indexes)
    call append(i - 1, lines)
endfunction
function! VIndentBlock(state)
    let state = a:state
    call s:replaceblock(state.indexes, s:indent(state.lines, 4))
endfunction
function! GrabTextFromPage(r)
    " test: "c"
    let r = a:r
    throw r
    let r = '^ *' . r
    let lines = GetLines(GI4REF['window'])
    let m = filter(copy(lines), 'Test(v:val, r)')
    return Choose2023(m)
endfunction
function! DefineMapItem(key, ...)
    let template = g:apae_map_templates[a:key]
    let cmd = Printf(template, a:000)
    call AppendAndExecute(cmd, GetFtpluginFile())
endfunction

function! Asdfasdjfkh()
    " silent execute 'hi'
    " execute 'hi'
endfunction
function! GetIndent(...)
    let s = a:0 >= 1 ? a:1 : getline('.')
    let m = match(s, '\S')
    return m > -1 ? m : 0
endfunction
function! Qobject(args)
    let args = a:args
    let a = '{' . g:keyboard.ENTER . '}' . "\<ESC>" . g:keyboard.O
    function! Inner(s)
        let s = a:s
        return printf("'%s': ,", s)
    endfunction
    let store = Map2(args)
    let a .= join(store, "\<CR>")
    let term = args[0] . "': ,"
    let a .= printf(g:keyboard.searchexpr, term)
    return a
endfunction
function! QEvaluateManager()
    let words = GetWords3()
    let key = 'Q' . remove(words, 0)
    return g:keyboard.dts . function(key)(words)
endfunction

function! DefineQTFunction(...)
    let name = a:0 >= 1 ? a:1 : GetBindingName()
    call DefineDictItem('g:vimCurrentTestFunction', name)
endfunction
function! CnoremapExpressionHandler(key, type, handler)
    let key = a:key
    let type = a:type
    let handler = a:handler
    let t = getcmdtype() == type
    if t
        return s:llvf(handler) ? function(handler)() : handler
    endif
    return key
endfunction






function! SliceInFrontofCursor(...)
    let s = a:0 >= 1 ? a:1 : getline('.')
    let pos = col('.') - 1
    let slice = strpart(s, pos)
endfunction
function! NothingInfrontOfCursor()
    return Test(SliceInFrontofCursor(), '^ *')
endfunction
function! SearchDateExpr()
    let prefix = '("|#|//)\? *'
    return "?\\v" . prefix . "\\d+-\\d+-\\d+\<CR>"

    return "?\\v^\\d+-\\d+-\\d+\<CR>"
    return "?\\d\<CR>"
    return "?function\<CR>"
endfunction

function! SplitFileAtCurrentLine()
    let i = line('.')
    let top = DeleteBlock([1, i])
    call AppendFile("/home/kdog3682/.vim/ftplugin/functions2.vim", top)
endfunction
function! CleverTab()
    let s = getline('.')
    let pos = col('.') - 1
    let m = strpart(s, 0, pos)

    if m =~ '^\s*$'
        return "\<Tab>"
    else
        let word = Match(m, '[_.a-z0-9]+$')
        if has_key(g:cleverTabRef, word)
            return Backspaces(len(word) . ref[word])
        else
            return "\<C-x>\<c-u>"
        endif
    endif
endfunction

function! GetUpbindings()
    
    let store = []
    let n = line('.')
    let spaces = GetIndent(n)
    while 1
        if GetIndent(n - 1) != spaces
            break
        endif
        let b = GetUpbinding(n)
        if Exists(b)
            call add(store, b)
            let n -= 1
        else
            break
        endif
    endwhile
    return store
endfunction

function! Templater2(template, ref)
    let template = a:template
    let ref = a:ref
    let items = ToArray2(ref)
    return Sub(template, '\$(\d+)', {x -> items[x[1] - 1]})
endfunction
function! Arrify(items)
    let items = a:items
    return printf('[%s]', join(items, ', '))
endfunction
function! Stringer(s)
    let s = a:s
    return IsString(s) ? s : string(s)
endfunction

function! MarkdownEnterBlock()
    
endfunction





function! ToVimVariable()
    let lines = split(@", "\n")
    let t = Replace(join(lines, ''), '^const ', 'let g:')
    let t = '" ' . t
    call append('$', t)
endfunction


function! CssSnippetWP()

    let s = getline('.')

    if Test(s, '^\S')
        return FastCSS(s)
    endif

    let langKey = 'css'
    let [spaces, tag, line, parts] = GetSpacesTagLineAndParts(s)
    let r = '\$(\{.{-}\}|\d+(--[a-z])?|[a-zA-Z]{3,})'
    let Fn = {x -> function('Pst')(x, parts, line)}
    let template = Get(g:wpsnippets, langKey, tag)
    if empty(template)
        let items = CssGetItems(s)
        let t = '    %s: %s;'
        let payload = map(items, 'printf(t, v:val[0], v:val[1])')
        return AppendBlockAtCursor(payload)
    endif
    let snippet = Sub(template, r, Fn)
    call InsertSnippet(snippet, spaces)
endfunction


function! CssBracket()
    let [spaces, line] = GetSpacesAndLine()
    let parts = FindallStrings(match, '\w+')
    let line = line[0: offset]
    let Parser89 = {x -> function('PySnippetTemplater2')(x, parts, line)}
    let regex = '\$(\{.{-}\}|\d+|[A-Z])'
    let snippet = Sub(snippet, regex, Parser89)
    call PlaceSnippet(snippet, spaces)
endfunction


function! CssGetItem(s)
    "test: px10
    let s = a:s

    if has_key(g:cabmap, s)
        return g:cabmap[s]
    elseif Test(s, ':')
        let [a,b] = split(s, ':')
        return CssParser(a, b)
    endif

    let m = Match2(s, '^(bg|fc)(\w+)')
    if Exists(m)
        return CssParser(m[0], m[1])
    endif 

    let m = Match2(s, '^([a-z]+)(\d\w*)')
    if Exists(m)
        return CssParser(m[0], m[1])
    endif 
    
endfunction

function! CssParser(key, value)
    " test: "px", "5"
    let key = a:key
    let value = a:value

    if has_key(g:cssAttributeRef, key)
        let ref = g:cssAttributeRef[key]
        let keys = get(ref, 'keys', 0)
        if Exists(keys)
            return map(copy(keys), 'CssParser(Abrev(v:val), value)')
        endif
        let cssKey = ref['key']
        let Fn = function(ref['fn'])
        let arg = get(ref, 'arg', 0)
        let payload = empty(arg) ? Fn(value) : Fn(value, arg)
        if empty(payload)
            return 
        else
            return [cssKey, payload]
        endif
    else
        return
    endif
endfunction

function! FastCSS(s)
    "test: asdf bgr1 center


    let s = a:s
    let args = split(s, ' ')

    let className = CssAddPeriod(remove(args, 0))
    if len(args) == 0
        let snippet = printf("%s {\n    $c\n}\n", className)
        return InsertSnippet(snippet, '')
    endif

    let t = '    %s: %s;'
    let store = CssGetItems(args)
    return store
    let payload = map(store, 'printf(t, v:val[0], v:val[1])')
    call add(payload, '}')
    call add(payload, '')
    call add(payload, '')
    call insert(payload, className . ' {')

    call AppendBlockAtCursor(payload)

endfunction

function! BraceMove(dir)
    let dir = a:dir
    repeat(g:keyboard.down, 10)
    execute "normal! "
endfunction

function! CommandSearchFour()
    asdf.asdf()
    let prefix = '(var|const|async|function[!*]\?|class|def) '
    let setup = '\v\C^'
    let s = "?\\v" . 
    execute "normal! " . g:commandsearchdirection . "\\v" . g:commandsearchvalue . g:keyboard.ENTER
endfunction








function! RegExpr(r, ...)
    let ref = {
        \'a': 'b',
    \}
    let dir = a:0 >= 1 ? '?' : '/'
    let case = a:0 >= 2 ? '\C' : ''
    let magic = '\v'
    let r = get(ref, a:r, a:r)
    if dir == '?'
        let r = Sub(r, '\?', '\\?')
    endif
    let normal = "silent normal! "
    return normal . dir . case . magic . r . g:keyboard.ENTER
endfunction
function! TildaFunctionSearch()
    let a = InputChar2()
    let b = InputChar2()
    let c = a . b
    try
        let r = g:keyboard.bindingprefix . CreateRE2(c, 'abrev')
        execute RegExpr(r)
    catch
        let r = g:keyboard.bindingprefix . CreateRE2(c, 'start')
        try
            execute RegExpr(r)
        catch
            let error = v:exception
            ec error
        endtry
    endtry
endfunction
function InputChar2() abort
    return g:codepoints[getchar()]
endfunction


function! DeleteBlock(...)
    let [a,b] = a:0 >= 1 ? a:1 : GetCodeIndexes()
    let lines = GetLines([a,b])
    if !empty(g:activeshuntfile)
        call AppendFile(g:activeshuntfile, lines)
    else
        call ToPasteBuffer(ToString(lines))
    endif

    call deletebufline('%', a, b)
    return lines
endfunction
function! DictTemplater(s, ref)
    ""test"" 'hi $bye', {'bye': 'sam'}
    ""test"" 'hi $bye', {'bye': 'sam'}

    let s = a:s
    let ref = a:ref
    return Sub(s, '\$(\w+)', {x -> ref[x[1]]})
endfunction

function! Red(s)
    "test: The text will be red!
    :highlight MyCustomColor ctermfg=red guifg=red
    :echohl MyCustomColor
    :echo Stringer(a:s)
    :echohl None
endfunction

function! Blue(...)
    "test: The text will be blue!
    :highlight MyCustomColor ctermfg=blue guifg=blue
    :echohl MyCustomColor
    :echo Stringer(Smallify(a:000))
    :echohl None
endfunction

function! Adsfkl()
    call Blue('howd')
endfunction


function! MConfig(s, r)
    let s = a:s
    let r = a:r
    let [a,b] = MGet(s, r)
    if empty(b)
        let b = 0
    else
        let b = 1
    endif
    return [a,b]
    
endfunction


function! GetLineInfo(...)
    let i = a:0 >= 1 ? a:1 : line('.')
    let s = getline(i)
    return {'lineNumber': i, 'text': s}

    
endfunction
function! GlobalFindall(r)
    let r = a:r
    let p = getpos('.')
    let store = []
    let t = "g/\\v%s/call add(store, getline('.'))"
    execute printf(t, r)
    call setpos(".", p)
    return s:unique(store)
endfunction
function! GrabLineViaGSearch(r)
    let r = a:r
    let store = []
    let p = getpos('.')
    let t = "g/\\v%s/call add(store, GetLineInfo())"
    execute printf(t, r)
    call setpos(".", p)
    let a = Choose2023(store)
    if empty(a)
        return s:nomatch(r)
    endif
    call AppendBelow2(Comment(trim(a.text)))
endfunction
function! PrintLinePlacesViaGSearch(r)
    "test: exampler
    let r = a:r
    let sense = ''
    if r == '$'
        let r = GetBindingName()
        let sense = '\C'

    endif
    let [r, flags] = MGet(r, '/([fb])$')
    if flags =~ 'f'
        let r = '^function!? ' . r
    else
        let r = substitute(r, '\v\.', '.{1,}', '')
    endif
    " call BlueInput('[r, flags]: ' . string([r, flags])) " debugmode
    let store = []
    let startpos = getpos('.')
    call setpos("'a", startpos)
    let t = 'g/\v%s/call add(store, GetLineInfo())'
    try
        execute printf(t, sense . r)
        let a = Choose2023(store)
        if empty(a)
            call setpos(".", startpos)
            return 
        endif
        call Jump(a)
        call setpos("'b", getpos('.'))
    catch
        call setpos(".", startpos)
        call RedStop()
    endtry

endfunction
function! RedirectVerboseToVariable(s, regex)
    let key = a:s
    let s:regex = a:regex

    let store = ''
    execute printf("
        \\n redir => store
        \\n silent %s
        \\n redir END
    \\n", key)

    function! Runner(s)
        return Match2(a:s, s:regex)
    endfunction
    return MapFilter(s:sl(store), 'Runner')
endfunction

function! VerboseChooseAndUnmap(key)
    "test: '5'
    let s = 'verbose nmap ' . a:key
    let t = RedirectVerboseToVariable(s)
    function! Inner(s)
        let s = a:s
        " let m = Match2(s, '^(\w+) +(\S+) +(.+)'
        return s
        
    endfunction
    let t = MapFilter(t)
    ec t
    
endfunction
function! Move()
    let s = getline('.')
    let m = Match(s, '^(\w+)')
    if Exists(m) && m != 'function'
          call append('$', s)
        execute "normal! Gzb"
        return 
    endif
    call append('$', WrapLines(DeleteBlock()))
    execute "normal! Gzb"
endfunction


function! LastUpWord()
    let s = getline(line('.') - 1)
    let words = GetWords2023(s)
    let word = words[-1]
    let ignore = ['aaaaa']
    if In(ignore, word)
        return 
    endif
    return word
endfunction

function! SmartMatch()
    let regexDelim = s:jspy('regexDelim')
    let word = LastUpWord()
    if Exists(word)
        
    endif
    let lefts = repeat(g:keyboard.left, 2)
    return printf("match(%s, %s)%s", word, regexDelim, lefts) . g:keyboard.eat

endfunction

function GetWords2023(...)
    "test: 'hiii'
    let s = a:0 >= 1 ? a:1 : getline('.')
    let r = a:0 >= 2 ? a:2 : '<[a-zA-Z]\w*'
    return FindallStrings(s, r)
endfunction

function! MemoryPrompt(dest, key)
    "test: "'.'", 'implicitParams'

    let key = a:key
    let dest = a:dest

    let cache = DictGetter2(g:memory, dest, key)
    if Exists(cache)
        call Blue('Returning cached value for ' . key . ': ' . cache)
        return cache
    endif

    let m = 'Choose a value @ ' . dest . ' for: ' . string(key)
    call Blue(m)
    let value = input('')
    if empty(value)
        return 
    endif
    call AppendAndExecuteDict('memory', dest, key, value)
    return value
    
endfunction


function! AppendAndExecuteDict(key, lang, a, b)
    let key = a:key
    let lang = a:lang
    let a = a:a
    let b = a:b
    let ref = eval('g:' . key)
    
    let t1 = 'let g:%s["%s"]["%s"] = "%s"'
    let t2 = 'let g:%s["%s"] = {}'
    let value = printf(t1, key, lang, a, b)
    if !has_key(ref, lang)
        let value = printf(t2, key, lang) . "\n" . value
    endif
    return AppendAndExecute(value)
endfunction

function Indent2023(s, ...)
    let s = ToLines(a:s)
    let spaces = a:0 >= 1 ? ToSpaces(a:1) : GetSpaces()
    let t = a:0 >= 1 ? 'spaces . trim(v:val)' : 'spaces . v:val'
    return map(copy(s), t)
endfunction





function! SplitOnceReverse(s)
    "test: 'aa b bbb = asss'
    return split(trim(a:s), '\v +\ze\S+$')
endfunction
function! FixWordBack()
    let s = TextBeforeCursor()
    let m = SplitOnceReverse(s)
    if len(m) != 2
        return ''
    endif
    let [front,back] = m
    let [a,b] = SplitOnce(back, '/')
    let front = Sub(front, a, b)
    return TextExpr(front, len(TrimStart(s)), g:keyboard.space)
endfunction

function! TextExpr(s, back, ...)
    let forward = a:0 >= 1 ? a:1 : ''
    let s = a:s
    let back = IsNumber(a:back) ? a:back : len(TrimStart(s))
    return Backspaces(back) . s . forward
endfunction

function! TextBeforeCursor(...)
    let a = getline('.')     " the line
    let b = col('.') - 1     " location of cursor on line
    let c = strpart(a, 0, b) " the line sliced from SOL to cursor
    let r = a:0 >= 1 ? a:1 : ''
    return empty(r) ? c : Match(c, r)
endfunction

function CreateRegexBase(s, ...)
    "test: ca

    let s = trim(a:s)
    if len(s) > 3
        return '^' . s
    elseif len(s) == 1
        return '^' . s:sub(s, '^\^', '', '') . '\w{3,}'
    endif
    let letters = split(toupper(s), '\zs')
    let length = len(letters)

    let template =  'printf("[%s%s]", tolower(v:val), v:val)'
    let ignore = '[^a-zA-Z0-9 ]'
    let out = ''
    for i in range(length)
        let el = letters[i]
        if i == 0
            let ch = printf('[%s%s]', tolower(el), el)
            let out .= ch
        else
            let ch = printf('(%s|%s[%s%s])', el, ignore, tolower(el), el)
            let out .= ch
        endif

        if i == length - 1 
            if IsNumber(ch)
                let out .= '\d*'
            else
                let out .= '[a-zA-Z-_0-9]'
                let out .= '{3,}'
            endif
        elseif i > 2
            let out .= '[a-zA-Z-_0-9]'
            let out .= '{-}'
        else
            let out .= '[a-z0-9]'
            let out .= '{-}'
        endif
    endfor

    let t = 'printf("[%s%s]", tolower(v:val), v:val)'
    let out2 = join(map(copy(letters), t), '')
    return a:0 >= 1 ? s:templater2(a:1, [out, out2]) : [out, out2]
endfunction

function! CreateRE(s, ...)
    "test: at
    let template = a:0 >= 1 ? a:1 : '\C^(%s|%s)'
    return CreateRegexBase(a:s, template)
endfunction

function! Categorize()
    let names = GetIdentifiers()
    call AppendFile('%file', '%upbinding')
endfunction

function! GetIdentifiers()
    let r = '^(var|(async )?function[!*]?|def|class|const) \zs\w+|^\w+\ze \= '
    return Filter2(map(getline('1', '$'), 'Match(v:val, r)'))
endfunction


function! KeyboardExpr1(...)
    return BaseKeyboardExpr(a:000)
endfunction
function! BaseKeyboardExpr(a)
    "test: 'asdf', 'xx', '['
    let s = 'get(g:keyboard, v:val, v:val)'
    let items = map(copy(a:a), s)
    return join(items, '')
endfunction


function! FwSnippeteer()
    let ci = [
       \{'r': '^(.{-}) o$', 'p': 'aa', 'f': 'Fw1', 't': '{}'},
       \{'r': '^js (\w+)', 'p': '', 'f': 'Fw2', 't': '{}'},
    \]
    let [spaces, before, after] = GetSpacesAndBeforeAfter()
    for item in ci
        let m = Match2(before, item.r)
        if Exists(m)
            try
                let p = function(item.f)(function(item.p)(m))
                return 
            catch
                return g:keyboard.exit
            endtry
        endif
    endfor
endfunction
function! GetSpacesAndBeforeAfter()
    let s = getline('.')
    let spaces = GetSpaces(s)
    let b = col('.') - 1
    let c = strpart(s, 0, b)
    let d = strpart(s, b)
    return [spaces, c, d]
endfunction
function! Ask1000()
    let ref = {
        \'outpath': 'FileGetter2',
        \'inpath': 'FileGetter2',
        \'arg': 'Identity',
        \'tags': 'Stringer',
    \}
    let store = ['date: ' . DateStamp()]
    for [k, v] in items(ref)
        let m = BluePrompt(k)
        if Exists(m)
            try
                let p = function(v)(m)
                call Push(store, k . ': ' . p)
            catch
            endtry
        endif
    endfor
    return join(store, "\n")
endfunction

function! Push(a, b)
    let a = a:a
    let b = a:b
    if Exists(b)
        call add(a, b)
    endif
    return a
endfunction


function! Adsflk()
    call BluePrompt('a')
endfunction
function! Abrev(s)
    let s = a:s
    let parts = Test(s, '_') ? Split(s, '[._]') : Split(s, '\C\ze[A-Z]|[:.\/\-_ ]')
    return tolower(join(map(parts, 'Match(v:val, "[a-zA-Z]")'), ''))
endfunction

function! DefineGlobalVar(...)
    let s = GetCurrentWord4()
    let v = ToStringArgument(a:0 >= 1 ? a:1 : '')
    if empty(v)
        let v = '""'
    endif
    call AppendAndExecute('let g:' . s . ' = ' . v)

    
endfunction
function! AnythingHandler2(key)
    "test: ask
    let key = a:key
    if empty(key)
        if !exists('b:lastKey')
            return 
        endif
        let key = b:lastKey
    else
        let b:lastKey = key
    endif

    let [a,b] = s:so(key)
    if &filetype == 'netrw'
        let fnKey = DictGetter2(g:explorerExecRef, a)
        if s:exists(fnKey)
            return function(fnKey)(b)
        else
            
            let s = s:pathjoin(g:netrwdir, getline('.'))
            let note = key
            let t = s:templater2("date: $date\nfile: $1\nnote: $2\n$hr", [s, note])
            call s:appendfile('file-notes.txt', t)
            execute "normal!  \<UP>"
            return 
        endif
    endif

    if a == "execute"
        execute(b)
    elseif a == "call"
        execute(b)
    elseif a == "ec"
        ec eval(b)
    elseif a == "echo"
        ec eval(b)
    endif

    let fnKey = DictGetter2(g:jspyref3, &filetype, 'execFunctions', a)
    if s:exists(fnKey)
        return s:exists(b) ? function(fnKey)(b) : function(fnKey)()
    endif

    let fnKey = get(g:execRef2, a, 0)
    if s:exists(fnKey)
        return s:exists(b) ? function(fnKey)(b) : function(fnKey)()
    endif

    return AnythingHandler(key)
endfunction
function! VABlockToBrowser(state)
    " state.lines
    ec has('unix')
    let m = systemlist("echo hi\necho bye")
    let m = systemlist("node f.js")
    return m
endfunction

function! RedAssertion(s)
    let s = a:s
    let m = 'Assertion was not met'
    try
        let v = eval(s)
        if empty(v)
        else
            return 
        endif
    catch
        let m = 'Assertion resulted in an error: ' . v:error
    endtry
    call RedPrompt("
        \\n source: %s
        \\n message: %s
     \\n \n", s, m)
    throw 'Forcing Stop at RedAssertion'
endfunction
function! AppendTestStringToBottomOfVimFile(...)
    let s = a:0 >= 1 ? a:1 : ''
    call RedAssertion('CurrentFile() == "/home/kdog3682/.vimrc"')
    let t = StringCall(GetBindingName(), s)
    call AppendVim('" ' . t)

    try
        " :setlocal nowrapscan
        " let pos = getpos('.')
        execute "normal! G/)\<CR>"
        " startinsert
        " :setlocal wrapscan
    catch
        call setpos('.', pos)
        return 
    endtry

endfunction
function! VAction(...)
    let mode = 0
    let arg = 0
    let Fn = 0
    let indexes = 0

    let [key, arg] = a:0 == 1 ? ForceSplit(a:1) : a:000
    let ref = get(g:visualactiondict, key)
    let Fn = s:fngetter(get(ref, 'fn', key))
    let indexerKey = get(ref, 'i', 'smart')
    let indexes = s:gi(indexerKey, 1)
    if empty(arg)
        let arg = get(ref, 'arg', '')
    endif
    let mode = get(ref, 'mode', '')
    let outpath = get(ref, 'outpath', '')
    let inpath = get(ref, 'inpath', '')
    let lines = s:getlines(indexes)
    let s = s:tostring(lines)
    let selection = has_key(ref, 'selection') ? GetVisualSelection() : 0

    let state = {'outpath': outpath, 'inpath': inpath, 'line': lines[0], 'selection': selection, 'start': indexes[0], 'end': indexes[1], 'length': len(lines), 'indexes': indexes, 'text': s, 'string': s,'mode': mode, 'lines': lines, 'arg': arg, 'indentation': match(lines[0], '\S')}

        let value = Fn(state)
        if empty(value)
            return 
        endif
        if IsArray(value)
            return VActionLineReplacer(state, value)
        endif


endfunction
function! VActionLineReplacer(state, value)
    let state = a:state
    let s:value = a:value

    function! InnerVActionLineReplacer(s)
        let s = a:s
        let args = [s] + s:value[1:]
        return call(function(s:value[0]), args)
    endfunction

    call s:gsr(state.indexes, 'InnerVActionLineReplacer')
endfunction

function! GetSetMemoryCache(ref, ...)
    let ref = a:ref
    let memoryKey = call(function('DictGetter'), insert(copy(a:000), g:memory))
    if Exists(memoryKey)
        return memoryKey
    endif

    let r = CreateRE(GetLast(a:000))
    let keys = filter(ref, "Test(v:val, r)")
    let chosenKey = Choose(keys)
    let args = add(copy(a:000), chosenKey)
    call call(function('SetMemoryCache'), args)
    return chosenKey
endfunction
function! SetMemoryCache(...)
    "test: abc, def, ghi, abc, def

    let keys = a:000
    let ref = g:memory
    let length = len(keys)
    let o = []
    let name = 'g:memory'

    for i in range(length - 1)
        let key = keys[i]
        if i == length - 2
            let name .= printf('["%s"]', key)
            let value = keys[i + 1]
            call add(o, printf('let %s = %s', name, string(value)))
            let ref[key] = value 
            let s = join(o, "\n")
            call AppendFile('/home/kdog3682/.vimrc', s)
        elseif has_key(ref, key)
            let ref = ref[key]
            let name .= printf('["%s"]', key)
        else
            let ref[key] = {}
            call add(o, printf('let %s["%s"] = {}', name, key))
            let name .= printf('["%s"]', key)
            let ref = ref[key]
        endif
    endfor
endfunction

function! DictGetter(ref, ...)
    "test: {'a': {'b': 'c'}}, 'a', 'b'
    "expect: 'c'

    let ref = a:ref
    let keys = a:000
    let length = len(keys)

    for i in range(length)
        let key = keys[i]
        if i == length - 1
            return ref[key]
        elseif has_key(ref, key)
            let ref = ref[key]
        else
            return 
        endif
    endfor
endfunction
function! DefineTemporaryCommand(key, s)
    let key = a:key
    let s = a:s

    let g:execRef[key] = { -> 
        try
            ec 'hi'
            " execute s
        catch
            ec 'error'
        endtry
        call remove(g:execRef, key)
    }
endfunction
function! RedPrint(...)
    let args = map(copy(a:000), 'Stringer(v:val)')
    call Red(Printf(args))
endfunction

function! BluePrint(...)
    let args = map(copy(a:000), 'Stringer(v:val)')
    call Blue(Printf(args))
endfunction
function! CommandExpr(t, ...)
    return call(function('printf'), a:000)
endfunction

function! BluePrompt(...)
    let args = map(copy(a:000), 'Stringer(v:val)')
    let t = call(function('printf'), args)
    call Blue(t)
    ec "\n"
    let v = input('')
    return v
endfunction

function! RedPrompt(...)
    let t = call(function('printf'), a:000)
    call Red(t)
    ec "\n"
    let v = input('Your input: ')
    ec "\n"
    return v
endfunction

function! s:tna(s)
    let s = a:s
    
    if IsNestedArray(s)
        return s
    else
        call s:assert(s:iseven(s), 'length required as odd')
        let store = []
        for i in range(0, len(s) - 1, 2)
            call add(store, [s[i], s[i + 1]])
        endfor
        return store
    endif
endfunction
function! Dictify(s)
    "test: ref a b c d
    "expect: 'prefix

    let [name, rest] = SplitOnce(a:s)
    let s:isAlias = Test(name, 'alia')
    let items = s:tna(DictStringSplit(rest))
    let lang = &filetype

    function! Inner(s)
        let s = a:s
        if IsNumber(s)
            return s
        endif
        if &filetype=='vim'
            return SingleQuote(s)
            return s
        endif
        if s:isAlias
            return s
        endif
        return SingleQuote(s)
    endfunction

    let t = 'SingleQuote(v:val[0]) . ": " . Inner(v:val[1])'
    let items = map(items, t)
    let prefix = s:jspy('prefix')
    return printf("%s %s = %s", prefix, name, StringBrackify(items, '{}'))
endfunction

function! StringBrackify(items, key)
    let items = a:items
    let [a,b] = SplitSingles(a:key)
    let backslash = s:jspy('backslash')
    let t = '"\t" . backslash . v:val . ",\n"'
    let items = map(items, t)
    let body = join(items, '')
    return a . "\n" . body . backslash . b
endfunction
function! s:aaq(s)
    let s = a:s
    return AddArgumentQuotes(s)
endfunction
function! AddArgumentQuotes(s)
    let s = a:s
    
        if IsNumber(s)
            return s
            
        endif
        if !Test(s, '[''"]')
            if Test(s, ',')
                let s = Sub(s, '[a-z]\w*', {s-> '"' . s[0] . '"'})
            elseif IsJsonParsable(s)

            else
                let s = '"' . s . '"'
            endif
        endif
        return s
endfunction
function! StringCall(name, ...)
    let name = a:name
    let args = s:flat(a:000)
    if len(args) == 1
        let s = a:1
        if empty(s)
            return name . '()'
        endif
        let s = AddArgumentQuotes(s)
        return printf('%s(%s)', name, s)
    endif
    function! Inner(s)
        let s = a:s
        if &filetype != 'vim' || !In(g:VimNativeFunctions, s)
            return s
        else
            return Capitalize(s)
        endif
    endfunction
    let t = 'Exists(v:val)'
    return Inner(a:name) . '(' . join(filter(args, t), ', ') . ')'
endfunction

function! GetMemoryCache(...)
    return DictGetter(g:memory, a:000)
endfunction

function! FunctionCallerViaEvalTheLine(...)
    let s = a:0 >= 1 ? a:1 : getline('.')
    if a:0 == 0 && !Test(s, '^ *"')
        let index = GetFunctionIndex('w0')
        let s = getline(index + 1)
        if !Test(s, '^ *"')
            let s = getline('$')
            if !Test(s, '^ *"')
                throw 'could not find a line to evaluate'
            endif
        endif
    endif

    let s = RSC(s)
    let debug = g:debug
    let g:debug = 1
    let value = ''
    let success = 'success'
    try
        let value = eval(s)
    catch
        let error = v:exception
        let value = error
        let success = 'error'
    endtry
    let g:debug = debug

    call BluePrint("
        \\n line: \"\"\" %s \"\"\"
        \\n %s: %s
    \\n\n", s, success, value)

endfunction








function! NormalExpr(...)
    return "normal! " . BaseKeyboardExpr(a:000)
endfunction
function! Cursor(line, ...)
    let line = a:line
    let ch = a:0 >= 1 ? a:1 : 1000
    execute "normal! " line . "G$"
endfunction

function! GetLibraryNames()
    
endfunction
function! TSExpr()
    return ExprTemplater('Test($lw, \'$c\')')
endfunction
function! ExprTemplater(s)
    let s = a:s
    function! Inner(s)
        let s = a:s
        return GetVimStateArg(s)
    endfunction
    return substitute(s, '\v\$(\w+)', '\=Inner(submatch(1))', 'g')
endfunction

function! s:dsto(s)
    let s = a:s
    return map(split(s, '  \+'), 'SplitOnce(v:val)')
endfunction
function! s:sosall(arg)
    let items = s:sds(a:arg)
    let a = remove(items, 0)
    return [a, items]
endfunction
function! VDuplicateBlock(state)
    let state = a:state
    let [arg, boundary] = MConfig(state.arg, '^,')

    """""""""""""""""""""""""""""""""" 1697075528
    let [a,items] = s:sosall(arg)
    """""""""""""""""""""""""""""""""" Extendable

    let store = ['']

    let a = boundary ? Boundary(a) : a
    for arg in items
        let t = "DittoReplace(v:val, a, arg)"
        let temp = map(copy(state.lines), t)
        call extend(store, temp)
        call add(store, '')
    endfor

    call append(state.end, store)

endfunction









function! SmartReturn()
    if IsSol()
        return 'return'
    else
        return 'r' 
    endif
endfunction



function! CheckIfFilesExistTEMP()
    
    let dir = '/mnt/chromeos/GoogleDrive/MyDrive/JSONS/'
    let langs = [ "vim", "python", "javascript", ]

    let t = dir . '%s.%s.%s'
    let store = []
    for lang in langs
        let key = 'names'
        let s = printf(t, lang, key, 'json')
        call add(store, s)
        let key = 'library'
        let s = printf(t, lang, key, 'json')
        call add(store, s)
    endfor
    " let dict = filter(store, 'IsFile(v:val)')
    let dict = Reduce(store, 'IsFile')
    return dict
    return store
endfunction
function! Reduce(store, s)
    " Reduce(s:fruits, 'IsFile')
    let store = a:store
    
    if IsNestedArray(store)
        let o = {}
        for item in store
            let o[item[0]] = FunctionGetter(a:s)(item[1])
        endfor
        return o
    elseif IsArray(store)
        let o = {}
        for item in store
            let o[item] = FunctionGetter(a:s)(item)
        endfor
        return o
    else
    endif

endfunction

function! s:hasdollar(s)
    let s = a:s
    return s:t(s, '\$')
endfunction


function! s:temp(key)
    " test: "er"
    let key = a:key
    call OpenBuffer3('/home/kdog3682/.vim/ftplugin/variables.10-12-2023.vim')
    execute "normal! /\\v<" . key . ">\<CR>"
endfunction
function! VMakeSnippet(state)
    let state = a:state
    let t = state.string
    let raw = SnippetConverter(t)
    let arg = BluePrompt("
        \\n VMakeSnippet (Visual Make Snippet)
        \\n ----------------------------------
        \\n %s
        \\n ----------------------------------
        \\n Choose a trigger key for this snippet
    \\n\n", raw)
    let [arg, mode] = MConfig(arg, '^,')
    let lang = mode == 2 ? Tail() : &filetype
    call DictSetter('g:wpsnippets2', lang, arg, raw)
endfunction

function! FindLineIndex(key, start, dir, ...) abort
    let key = a:key
    let start = a:start
    let dir = a:dir
    let threshold = a:0 >= 1 ? a:1 : 500
    let anti = a:0 >= 2 ? 1 : 0
    let offset = a:0 >= 3 ? a:2 : 0
    let i = IndexGetter2(start)
    let regex = RegexGetter(key)
    let increment = dir
    let c = 0

    let max = line('$')

    while c < threshold
        if i > max
            throw ''
        endif
        let c += 1
        let line = getline(i)
        if anti
            if !Test(line, regex)
                return i - increment
            endif
        else
            if Test(line, regex)
                return i
            endif
        endif
        let i += increment
    endwhile
    throw '-1'
endfunction
function! SearchAndMove(r)
    normal! m`

    let r = a:r
    let result = search(a:pattern)
    if empty(result)
        return 
    endif
    return 

endfunction






function! GICob(...)
    let index = a:0 >= 1 ? a:1 : line('.') 
    let s = getline(index)

    let spaces = matchstr(s, '\v^ *')
    let other = ''
    let ref = s:jspy('blockPairs')
    for [k,v] in items(ref)
        try
            let m = trim(Match(s, k))
        catch
            let error = v:exception
            call input(string([k,v]))
        endtry
        if Exists(m)
            let other = v
            let r = '^' . spaces . other
            let anti = empty(other)
            let down = s:fli(r, index, 1, 500, anti)
            return [index, down]
        endif
    endfor
    let r = '^' . spaces
    let down = s:fli(r, index, 1, 500, 1)
    return [index, down]

endfunction

function! IsNumber(x)
    return type(a:x) == 0 || type(a:x) == 1 && Test(a:x, '^\d+$')
endfunction

function! Choose2023(items)
    "test: [1,2,1,1,1,1,1,12,2,2,2,2,2,2,2,2]
    "doc: the difference 
    let items = a:items
    if empty(items)
        return 
    elseif len(items) == 0
        return
    elseif len(items) == 1
        return items[0]
    else
        return InputList(items)
    endif

    
endfunction
function! ToggleLocalStateController()
    let k = items(g:state)
    let store = []
    for [a,b] in k
        if IsNumber(b)
            call add(store, [a,b])
        endif
    endfor
    silent throw 'err'
    let [key, value] = store[n]
    let value = Opposite(value)
    let g:state[key] = value
    call BluePrompt("
        \\n setting g:state['%s'] to %s
    \", key, value)
    ec g:state

endfunction
function! NormalDelete()
    if g:state.saveInsteadOfDelete
        let s = getline('.')
        call BluePrint('saving line %s to %s', line('.'), dest)
        ec 'Saving line 
        ec 'savin'
    call DeleteLine()
    ec s
    "asdas
    "asdas
endfunction


function! VATry(state)
    return VisualLineWrapper(state, s:jspy('tryCatchLines'))
    let state = a:state
    let lines = state.lines

endfunction
function VisualLineWrapper(state, aboveAndBelow)
    let state = a:state
    let [above, below] = a:aboveAndBelow
    let ind = GetIndent(lines[0])
    let lines = Indent(lines)
    let above = Indent(above, ind)
    let below = Indent(below, ind)

    let payload = []
    call extend(payload, above)
    call extend(payload, lines)
    call extend(payload, below)

    let n = state.start
    let startingLength = state.length

    for i in range(startingLength)
        call setline(n + i, payload[i])
    endfor

    " call append(n + startingLength - 1, payload[startingLength:])
    " call Cursor(n + len(payload) - 2)

endfunction



function! XdgOpen(s)
    let s = a:s
    ec s
    if empty(s)
        return 
    endif
    let s = printf('xdg-open %s > /dev/null 2>&1', s)
    " let s = printf('!xdg-open %s > /dev/null 2>&1', s)
    " execute s
    " ec s
    call system(s)
endfunction

function! GoogleSearch(s)
    " test: "preorder vs postorder traversal use cases"
    let s = a:s
    let q = s:sub(s, ' ', '+')
    let t = 'https://google.com/search?q=site%3A$1+$2'
    let red = s:templater(t, ['reddit.com', q])
    let sof = s:templater(t, ['stackoverflow.com', q])
    call XdgOpen(red)
    call XdgOpen(sof)
endfunction
function! BrowserController(...)
    "test: movie
    let k = a:0 >= 1 ? a:1 : 'self'
    
    let  ref = {
    	\'movie': 'https://ww1.123moviesfree.net/search/?q=$movie',
        \'gpt': 'https://chat.openai.com',
        \'g': 'https://chat.openai.com',
        \'s': 'https://www.speechtexter.com',
    \}
    let s = get(ref, k, '')
    if empty(s)
        let s = CurrentFile()
    endif
        
    function! Inner(s)
        let s = a:s
        return BluePrompt('Choose a value for ' . s)
    endfunction
    let s = substitute(s, '\v\$(\w+)', '\=Inner(submatch(0))', 'g')
    let s = substitute(s, ' ', '+', 'g')
    call XdgOpen(s)
endfunction
function! VABlockToBrowser(state)
    call writefile(state.lines, g:tempfile)
    call XdgOpen(g:tempfile)
endfunction


function! GI4(key, ...)
   let key = a:key
   let override = a:0 >= 1 ? 1 : 0
   let [indexes, flag] = GetVisualIndexes('flag')
   if line('$') == line('.') || empty(flag) && !override
       return indexes
   endif
   return function(g:GI4Ref[key])()
endfunction

function! GIDateBlock()
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
    return [m, n]
endfunction


function! GITildaBlock()
    let n = FindLineIndex('`', '.', -1)
    let m = FindLineIndex('`', '.', 1)
    let n += 1
    let m -= 1
    return [n, m]
endfunction


function! GIWindow10()
    return [max([line('w0') - 10, 1]), min([line('w$') + 10, line('$')])
endfunction

function! GILine()
    return [line('.'), line('.')]
endfunction

function! GIWindow()
    return [line('w0'), line('w$')]
endfunction
function! EvalCurrentWord()
    let s = GetCurrentWord4()
        if s:llvf(s)
            let s += '()'
        endif
        ec BluePrint(eval(s))
endfunction

function! VReplaceBlock(state)
    let state = a:state

    let s = state.arg
    let a = ''
    let b = ''

    let [s, boundary] = MConfig(s, '^,')
    if Test(s, '/')
        let [a,b] = s:so(s, '/')
        if empty(b)
            let a = ' *' . a . ' *'
            let b = ''
        elseif empty(a)
            let a = GetCurrentWord4()
        endif
    else
        let a = GetCurrentWord4()
        let b = s
    endif

    let a = Rescape2023(a)
    if boundary
        let a = Boundary(a)
    endif

    return ['Sub', a, b]
endfunction

function VisualReplaceLine(state)
    let a = GetCurrentWord4()
    let b = state.arg
    if empty(b)
        let a = ' *' . a . ' *'
    elseif b == 'p'
        let b = @"
    endif

    let r = '\v' . Boundary(Rescape2023(a))
    return ['substitute', r, b, 'g']
endfunction


function VisualTempAction(state)
    let state = a:state
    let lines = map(state.lines, 'VimCall(v:val)')
    let g:globalState[state.arg] = lines
    call VimExecute(lines)
endfunction







function! ClockStamp()
    let ampm_time = strftime("%I:%M:%S %p")
    return ampm_time
endfunction
    " let clock_time = strftime("%H:%M:%S")
    " TODO the ability to grab this statement and move it up
function! MarkCurrentWork()
    let s = VimTemplater("$commentPrefix $ClockStamp -- $GetBindingName")
    call AppendAndMove('$', s)
endfunction
function! AppendAndMove(n, s)
    let n = a:n
    let s = a:s
    call append(n, s)
    call Jump(n)
endfunction
function! Jump(n)
    let n = a:n
    if IsObject(n)
        let n = n['lineNumber']
    endif
    execute "normal! " . n . "G"
endfunction
function! VimTemplater(...)
    let s = Printf(a:000)
    function! Inner(s, paramString)
        let s = a:s
        let paramString = Exists(a:paramString) ? SingleQuote(a:paramString[1:-2]) :''
        if s:llvf(s)
            return Exists(paramString) ? function(s)(paramString) : function(s)
        endif 

        try
            let m = s:jspy(s)
            return m . paramString
        catch
            return GetVimStateArg(s) . paramString
        endtry
    endfunction

    let t =  '\=Inner(submatch(1), submatch(2))'
    return substitute(s, '\v\$(\w+)(\(.{-}\))?', t, 'g')
endfunction


function! GrabTextFromAbove(range, key)
    "test: [1, 5770],ch10
    "test: frontaaaaaaaa
    let key = a:key
    let [key, numbers] = MGet(key, '\d+$')
    if Exists(numbers)
        let numbers .= '\d*'
    endif
    " call input(key)
    try
        let r0 = len(key) < 4 ? CreateRE(key, '\C^%s'.numbers) : ''
        let key = printf('[%s%s]%s', toupper(key[0]), tolower(key[0]), key[1:])
        let store = []
        let r1 = '[a-zA-Z]+' . key . '[a-zA-Z]*' .numbers
        let r2 = '<' . key . '[A-Za-z]+' . numbers
        let r3 = join(Filter2([r1, r2, r0]), '|')
        " ec r3
        " let answer = BluePrompt("
            " \\n %s
        " \\n\n", r3)
        " return r3
        " let range = '%'
        " let range = join(GI4('code', 'override'), ',')
        " let range = '1,' . line('.')
        let range = IsString(a:range) ? a:range : join(a:range, ',')
        let flags = "gn"
        let t = ":%ss/\\v%s/\\=%s/%s\<CR>"
        let expr = printf(t, range, r3, 'add(store, submatch(0))', flags)
        " let expr = ":" . range . "s/\\v" . r3 . "/\\=add(store, submatch(0))/" . flags . "\<CR>"
        execute "normal! " . expr 
        " let answer = BluePrompt("
            " \\n store: %s
        " \\n\n", store)

        function! Inner(i, s)
            let i = a:i
            let s = a:s
            return 1
        endfunction

        let items = filter(uniq(SortByLength(store, 1)), function('Inner'))
        return items
    catch
        let error = v:exception
        ec error
    endtry
endfunction

function! FindallStrings2023(r, ...)
    let r = a:r
    let n = a:0 >= 1 ? a:1 : 0
    let m = a:0 >= 2 ? (IsString(a:2) ? a:2 : join(a:2, ',')).'s' : '%s'
    let t = "silent normal! :%s/\\v%s/\\=add(store, submatch(%s))/gn\<CR>"
    let store = []
    execute printf(t, m, r, n)
    return sort(uniq(store))
    
endfunction
function! s:issol(...)
    " test: "sdf"
    let s = getline('.')
    let key = a:0 >= 1 ? a:1 : ''
    if s:exists(key)
        return trim(s) =~ key
    endif
    return s:t(s, '^\S')
    sdf
endfunction
function! s:isstring(s)
    let s = a:s
    return IsString(s)
endfunction

function! s:isarray(s)
    let s = a:s
    return IsArray(s)
endfunction

function! s:isnumber(s)
    let s = a:s
    return IsNumber(s)
endfunction

function! s:isobject(s)
    let s = a:s
    return IsObject(s)
endfunction

function! s:fngetter(F, ...)
    function! s:innerfngetter(Fn)
        return function(a:Fn)
        let Fn = a:Fn
        return s:isstring(Fn) ? function(Fn) : Fn
    endfunction
    let F = a:F
    if empty(F)
        return s:innerfngetter(a:1)
    endif
    if IsArray(F)
        return s:innerfngetter(F[0])
    endif
    return s:innerfngetter(F)
endfunction
function! s:longest(list, ...)
    " test: ["abc", "defg"]
  let longest_length = 0
  let longest_item = ''
  let Compare = s:fngetter(a:000, 'len')

  for item in a:list
    let item_length = Compare(item)
    if item_length > longest_length
      let longest_length = item_length
      let longest_item = item
    endif
  endfor
  return longest_item
endfunction
function! BetterDA()
    let s = getline('.')
    let quote = Match2(s, '''@<!''|"@<!"')
    let r = quote . '.{-}' . quote
    let matches = s:fa(s, r)
    if empty(matches)
        return 
    endif
    let el = s:longest(matches)
    let regex = quote . el
    if m == '"'
        execute "normal! ^/\\v\"\<CR>\<right>di\""
    endif
    " execute NormalExpr()
endfunction
vnoremap a :<c-u>call VisualAction('')<left><left>







function! KeyboardExpr(s)
    function! Inner(s)
        let s = a:s
        return get(g:keyboard, s, s)
    endfunction
    let letters = map(SplitSpaces(s), 'Inner(v:val)')
    let t = substitute(s, '\v\$(\w+) +', '\=Inner(submatch(1))', 'g')
    return "normal! " . t
endfunction

function! TildaMovement()
    return "\<ESC>o"
    return "\<ESC>O"
endfunction



function! CommandLineQGP()
    try
        let f = FileGetter2(BluePrompt('Choose a File: '))
        let t = printf('source %s', f) . g:keyboard.enter
        return t
    catch
        return "\<ESC>"
    endtry
endfunction

function! Foobar()
    :silent ! clear;echo hi from the shell
endfunction
function! InteractiveQuestions()
    echo "Question 1:"
    let response1 = getchar()
    echo "Question 2:"
    let response2 = getchar()

    " Do something

    " Without the next line, you would have to hit ENTER,
    " even if what is written (the questions) has no interest:
    call feedkeys(" ")
endfunction

function! SilentExecute(...)
    let cmd = Printf(a:000)
    execute 'silent !' . cmd
    execute 'redraw!'
    ec 'successful cmd:' . cmd
endfunction
function! MostRecentFile(dir, ...)
    "test: 'budir'
    let n = a:0 >= 1 ? a:1 : 1
  let latest_mtime = 0
  let latest_file = ""

  let store = []
  let files = GlobList(a:dir)
  for file in files
    let mtime = getftime(file)
    if mtime > latest_mtime
      let latest_mtime = mtime
      let latest_file = file
    endif
  endfor

  return s:sub(latest_file, '//', '/')
endfunction

function! SortFilesByDate(files)

    function! Inner(file1, file2)
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

    let files = a:files
    let files = sort(copy(files), 'Inner')
    return files
endfunction

function! Sdfjkj()
    return SortFilesByDate(GlobList('budir'))
endfunction

function! GlobList(dir)
  let files = split(glob(DirGetter(a:dir) . '/*'), "\n")
  return files
    
endfunction


function AppendTestStatementToFunction(...)
    " test: 1
    " test: "1"
    " test: ""
    " test: "a"
    " test: sdf
    " test: sdf
    let a = a:0 >= 1 ? a:1 : BluePrompt("
        \\n Please write the test statement.
        \\n It will be appended on the second line of the function.
    \\n\n")
    let a = AddArgumentQuotes(a)
    let s = VimTemplater('    $commentPrefix test: %s', a)
    call append(GetFunctionIndex(), s)
endfunction

function! IsJsonParsable(s)
    let s = a:s
    return Test(s, '^\s*[{\[]')
endfunction
function! s:trie(s)
    " test: "mx"
    let s = a:s
    if empty(s)
        return 
    endif
    let ref = {
        \ 'mo': ['mode = Object', 'mode = Array'],
        \ 'imp': ['implicit'],
    \}
    if !has_key(ref, s)
        let s = s:find(keys(ref), s)
    endif

    if !has_key(ref, s)
        return 
    endif
    return ref[s]
    
endfunction
function! QQ()
    let ref = {
        \'m': "MostRecentFile('dldir')",
        \'d': "g:dir2024",
        \'3': "fnamemodify(bufname('#'), ':p')",
    \}
    let word = s:wbc('[a-z]{1,}')
    if empty(word)
        ec ref
        return eval(ref[InputChars(1)])
    else
        let w = s:trie(word)
        return Backspaces(word) . s:pick(w)
    endif
endfunction
function! Qgp(...)
    let key = a:0 >= 1 ? a:1 : input('')
    if has_key(g:qref, key)
        return function(g:qref[key])()
    elseif key == 'm'
        return MostRecentFile('dldir')
    elseif key == 'd'
        return g:dir2024
    elseif !Exists(key)
        return CurrentFile()
    elseif has_key(g:qwordref, key)
        return g:qwordref[key]

    elseif key == 'f'
        return 
    elseif key == '#'
        return fnamemodify(bufname('#'), ':p')
    endif
    let val = Stringer(GetVimStateArg(key))
    if val == key
        return FileGetter2(key)
    else
        return val
    endif
endfunction
function! TrimLine()
    return trim(getline('.'))
endfunction

function! GetLineNumber()
    return line('.')
endfunction
function! GetVimStateArg(...)
    " test: "lineNumber"
    let x = a:0 == 1 ? a:1 : a:2
    if x == 'ccccc'
    elseif x == 'prompt'
        return s:prompt()
    elseif has_key(g:vimFunctionAliases, x)
        return function(g:vimFunctionAliases[x])()
    elseif x == '  '
        return "\n"
    elseif Test(x, '^g:')
        return eval(x)
    elseif Test(x, '^\w+/')
        let [a,b] = SplitOnce(x, '/')
        let value = DictGetter(g:assets, a , b)
        if Exists(value)
            return value
        endif
        let value = Npath(a, b)
        if IsFile(value)
            return value
        endif
        throw "not done yet"
    elseif Test(x, '(files?|dirs?)$|^(file|dir)')
        try
            return eval('g:' . x)
        catch
            return x
        endtry
    else
        return x
    endif
endfunction


function! FindFileInDir(dir, file)
    let file = a:file
    let f = Find(GlobList(a:dir), {s->Test(Tail(s), '^'. file)})
    return f
endfunction

function! Normal(s, ...)
    return Printf(['normal! ' . a:s, a:000])
endfunction
"

function! SilentUnmap(s)
    "test: asdf
    try
        execute "nunmap <buffer>" . a:s
    catch
        let error = v:exception
        " ec error
    endtry
endfunction
function! UnmapPython()
    silent! nunmap <buffer> ]m
    silent! nunmap <buffer> ]M
    silent! nunmap <buffer> [m
    silent! nunmap <buffer> [M
    silent! nunmap <buffer> []
    silent! nunmap <buffer> [[
    silent! nunmap <buffer> ]]
    silent! nunmap <buffer> ][
endfunction

function! OpenBuffer4(file)
    let file = a:file
    " ec file
    " return
    if Not(file)
        return 0
    endif
    if file == '.vimrc'
        let file = '/home/kdog3682/.vimrc'
    endif

    if !Test(file, '^/')
        let e = GetExtension(file)
        let dir = g:homedir
        if e == 'js' || e == 'css' || e == 'html'
            let dir = g:jsdir
        elseif e == 'py'
            let dir = g:pydir
        elseif e == 'vim'
            let dir = g:ftplugindir
        elseif e == 'bash_aliases'
            let dir = $HOME
        endif
        let file = s:npath(dir, file)
    endif

    if IsCurrentFile(file)
        return 0
    endif
    if !IsFile(file)
        let answer = RedPrompt("
            \\n The file: '%s' does not exist.
            \\n Do you wish to proceed?
        \\n\n", file)
        call LogCreateTime(file, 'files.log')

    endif
        if GetExtension(file) == 'pdf'
            return OpenBrowser(ShellEscape(file))
        endif
        let cmd = Join(bufexists(file) ? 'b!' : 'edit', file)

        execute cmd
        return 1
endfunction

function! OpenBuffer3(s)
    return OpenBuffer4(a:s)
endfunction

function! LogCreateTime(name, key)
    "test: 'abc.js', 'files.log'
    let name = a:name
    let key = a:key
    let outpath = printf('%s%s', g:homedir, key)
    let s = strftime('%s') . ' ' . name
    call writefile([s], outpath, 'a')
    ec 'logging create time: ' . s
endfunction


function! BlueList(items)
    "test: [[1,2], [3,4]]
    let items = a:items
    ec '----------------------------'
    for i in range(len(items))
        let item = items[i]
        let d = (i + 1) . '. ' . Stringer(item)
        call Blue(d)
    endfor
    ec "----------------------------\n"
endfunction
function! InputChars(n)
    "test: 2
    let n = a:n
    let d = ''
    for i in range(n)
        let ch = s:getchar()
        if ch == g:keyboard.enter
            break
        elseif ch == ' '
            continue

        elseif ch == -1
            continue
        else
            let d .= ch
        endif
    endfor
    if len(d) == 0
        return -1
    endif
    return d
endfunction
function! InputList(items)
    "test: ['a', 'b', 'c']
    let items = a:items
    let n = GetExponentOf10(len(items))
    call BlueList(items)
    let a = InputChars(n)
    if a == -1
        return 
    endif
    return items[a - 1]
endfunction


function! GetExponentOf10(number)
  let exponent = 1
  let num = abs(a:number)

  while num >= 10
    let num = num / 10
    let exponent = exponent + 1
  endwhile

  return exponent
endfunction


function! LanguageWords(key)
    let key = a:key
    let v = GetMemoryCache(&filetype, 'languageWords', key)
    if Exists(v)
        return v
    endif
    return key
    0
endfunction

function! GetIdentifiers()
    let r = '^(var|const|async|function[!*]?|class|def) (\w+)'
    return FindallStrings2023(r, 2)
endfunction
function! FindallStrings2023(r, ...)
    let r = a:r
    let n = a:0 >= 1 ? a:1 : 0
    let m = a:0 >= 2 ? (IsString(a:2) ? a:2 : join(a:2, ',')).'s' : '%s'
    let t = "silent normal! :%s/\\v%s/\\=add(store, submatch(%s))/gn\<CR>"
    let store = []
    execute printf(t, m, r, n)
    return sort(uniq(store))
    
endfunction
function! BrowseFileFunctions()
    let m = GetIdentifiers()
    while len(m) > 10
        let a = InputChars(3)
        if a == -1
            break
        endif
        let t = "Test(v:val, a) || Test(Abrev(v:val), a)"
        let m = filter(m, t)
        ec m
    endwhile
    let w =  Choose2023(m)
    call 
endfunction
function! InitFunctionNameRef()
    "front
    let m = GetIdentifiers()
    function! Inner(i, s)
        let name = a:s
        let a = name[0:2]
        let b = Abrev(name)
        let payload = {'name': name, 'abrev': b}
        return payload
    endfunction
    return map(m, function('Inner'))
endfunction

function! UpdateFunctionNameRef(name)
    return 
    let name = a:name
    let a = name[0:2]
    let b = Abrev(name)
    let payload = {'name': a, 'abrev': b}
    call add(b:functionNameRef, payload)
endfunction

function! Some(list, condition)
  for item in a:list
    if a:condition(item)
      return 1
    endif
  endfor
  return 0
endfunction


function! QGetter(val, key) abort
    "test: {'name': 'LooksLikeVimFun', 'abrev': 'llvf'}, 'look' 
    let val = a:val
    let key = a:key
    return Test(val['name'], key) || Test('^' . val['abrev'], key)
endfunction
function! Qx()
    let key = GetCurrentWord5()
    let b:completionLength = len(key)
    let ref = b:functionNameRef
    let m = filter(copy(ref), "QGetter(v:val, key)")
    let b:completionWords = map(m, {i, x -> x['name']})
    return "\<C-R>=ListMonths()\<CR>"
endfunction

autocmd! bufwritepost ~/.vimrc source %
autocmd! BufNewFile,BufRead *.dialogue set filetype=dialogue
" autocmd! FileType javascript :call SetupController('javascript')
" autocmd! FileType vim :call SetupController('vim')
" autocmd! FileType python :call SetupController('python')
" autocmd! FileType css :call SetupController('css')
" autocmd! FileType html :call SetupController('html')
" autocmd! FileType vue :call SetupController('vue')


function! SetupController(filetype)
    if exists('b:touched')
        return
    else
        return 
        " ec 'hi from ' . CurrentFile()
        
        let b:touched = 1
        let b:nonu = 0
        let b:completionWords = {'list': [], 'dict': {}}

        if &filetype == 'css'
            let b:completionWords = {'list': [], 'dict': {}}
        endif

        if &filetype == 'python'
            call UnmapPython()
        endif
        if &filetype == 'vim'
            call UnmapVim()
        endif

        try
            let b:nativeFunctions = s:jspy('nativeFunctions')
        catch
            ec 'no native functions for ' . &filetype
        endtry
        try
            let file = CurrentFile()
            let ignore = ['']
            if !In(ignore,file)
                let b:functionNameRef = InitFunctionNameRef()
            endif
        catch
            let error = v:exception
        endtry
        let b:screenWords = []
        try
            let b:oldFunctions = LoadOldFunctions()
        catch
            let error = v:exception
        endtry
    endif
endfunction


function! ChooseAndGoFunctionFromScreen()
    let screen = [line('w0'), line('w$')]
    let m = FindallStrings2023('\w+\ze\(|', 0, screen) 
    let m = uniq(m)
    let m = Choose2023(UniqueExcludeList(m, b:nativeFunctions))
    let g:lastTouchedFileViaChooseAndGo = m
    return OpenFunction(m)
endfunction

function! Partitioner(items, fnKey)
    let m = a:items
    let fnKey = a:fnKey
    " redraw
    while 1
        let key = input('input a key: ')
        let t = fnKey . "(v:val, key)"
        let m = filter(copy(m), t)
        if len(m) < 10
            let value = Choose2023(m)
            if Exists(value)
                return value.name
            else
                throw 'no value'
            endif
        endif
        redraw
        call BlueList(m)
    endwhile
endfunction
function! BrowseAndGoFunction()
    let m = Partitioner(b:functionNameRef, 'QGetter')
    return OpenFunction(m)

endfunction
function! GetFunctionFromRef(key)
    let key = a:key
    let m = filter(copy(b:functionNameRef), {i, x -> Some(x['aliases'], {y-> Test(y, '^' . key)})})
    let m = Choose2023(m)
    return m['name']
endfunction
function! UniqueExcludeList(list, exclude)
    let list = a:list
    let exclude = a:exclude
  let result = {}
  for item in a:list
    if In(exclude, item)
        continue
        endif
    let result[item] = 1
  endfor
  " Convert the dictionary keys (unique values) back to a list
  return keys(result)

endfunction


function! ScrollToTopOfScreen()
  let cursor_line = line('.')
  let top_line = winline()
  let lines_to_scroll = cursor_line - top_line
  if lines_to_scroll < 0
    " If cursor is above the top line, scroll up by 'lines_to_scroll' lines
    execute 'normal! ' . -lines_to_scroll . "\<C-Y>"
  endif
endfunction

function! UpdateBufferFunctions()
     let word = GetCurrentWord4()
     " if llv
     UpdateFunctionNameRef(word)
endfunction





function! PythonController(fnKey)
    let info = CurrentInfo()
    let info['fnKey'] = a:fnKey
    let escaped = ShellEscape(Stringify(info))
    return Python(g:runpyfile,'PythonController', escaped)
endfunction
function! SilentPythonController(fnKey)
    "test: 
    let info = {}
    let info['fnKey'] = a:fnKey
    let escaped = ShellEscape(Stringify(info))
    return SilentPython(g:runpyfile,'PythonController', escaped)
    
endfunction

function! SilentPython(...)
    let m = systemlist("python3 " . join(Flat(a:000), " "))
    ec m
endfunction

function! ExportHistory()
    redir => command_history
    silent history
    redir END

    return split(command_history, "\n")

endfunction
function! s:sl(s)
    return IsString(a:s) ? split(a:s, "\n") : a:s
endfunction

function! MapFilter(items, ...)
    let items = a:items
    let s:f = FunctionGetter(a:0 >= 1 ? a:1 : 'Inner')
    let store = []

    for i in range(len(items))
        let val = s:f(items[i])
        if Exists(val)
            call add(store, val)
        endif
    endfor
    return store
endfunction
function! Nonu()
    if !exists('b:nonu')
        let b:nonu = 1
    :setlocal nonumber
    return
    endif
    if b:nonu
    let b:nonu = 0
    :setlocal number
    else
    let b:nonu = 1
    :setlocal nonumber
    endif
endfunction




function! GrabTextFromSomewhere0(r)
    "test: 'ectli'
    let pos = getpos('.')
    let r = a:r
    let store = []
    let t = ":%s/\\v\\w*" . r . "\\w*/\\=add(store, submatch(0))/gn\<CR>"
    execute "normal! " . t
    let store = uniq(store)
    call setpos('.', pos)
    return store
endfunction

function! NormalInsertion(s)
endfunction

function! NormalInsertionBecauseExecuteDoesntWorkInExpression()
    " let t = GrabTextFromSomewhere0(input('r: '))
    " let m = Choose(t)

    let [spaces, line] = GetSpacesAndLine()
    call setline('.', spaces . 'aaaa')
    startinsert!
    return 

    asdf asdf 
    aaaa aaa
    aaaa
    let s = len(Replace(getline('.'), ' *$', ''))
    let lim = pos[2] > s
    if lim
        return 
        ec 'noapple  apple apple' 
        call setline('.', 'abc')
        return
        return
        return ""
    endif
    let pos[2] = pos[2] + len(m)
    let payload = a . m . b
    call setline('.', payload)
    call setpos('.', pos)
    startinsert
    "appleappleapple"

endfunction
function! CollectWords(r)
    " this too slow
    "test: collect
    let r = a:r
    let flags = 'b'
    let c = 0
    let r = '\w*' . r . '\w*'
    let store = []
    let pos = getpos('.')
    let limit = 10
    while 1
        let c += 1
        let i = search('\v' . r, flags)
        if c >= limit
            call setpos('.', pos)
            ec 'limit reached'
            break
        endif
        if i < 1
            call setpos('.', pos)
            break
        endif
        let s = getline(i)
        ec [i, s]
        let m = Match(s, r)
        call add(store, m)
    endwhile
    return store
    
endfunction
function CollectLines(r)
    "test: 'copy', 100

    let r = a:r
    let limit = 100

    let store = []
    let pos = getpos('.')
    let @/ = ''
    let c = 0
    while 1
        let i = search('\v' . r, 'W')
        if i < 1 || c >= limit
            call setpos('.', pos)
            ec 'breaking'
            break
        endif
        let s = getline(i)
        let c += 1
      let p = {'count': c, 'index': i, 'text': s}
      call add(store, p)
    endwhile
    let answer = Choose2023(store)
    if Exists(answer)
        call append('.', Comment(answer.text))
    endif
    return 
    
    
    
    "copy 3
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    "copy 2
endfunction
function! SetScreenPadding(n)
    let n = a:n
    execute ":setlocal scrolloff=" . n
    execute ":setlocal sidescrolloff=" . n
endfunction


function! FileGetter2(s) abort
    let key = a:s
    let length = len(key)

    if key == ''
        throw ' need a file'
    elseif key == 'pluginfile' || key == 'ftp'
        let f = PathJoin(g:ftplugindir, &filetype . '.vim')
        return f

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

function! RegexMap(s, r, ...)
    let s = a:s
    let s:r = a:r
    let s:t = a:0 >= 1 ? a:1 : {s->s}
    
    function! Runner(s)
        let s = s:t(a:s)
        return Match2(s, s:r)
    endfunction
    let m = MapFilter(s, 'Runner')
    return m
endfunction
function! JumpBackwardsByQueryingJumpList(key)
    "test: ^v
    let r =  '^ *(\w+) +(\w+) +(\w+) (.+)'
    let t = RedirectVerboseToVariable('jumps', r)
    let m = reverse(RegexMap(t, '^function[!*]? (\w+)', {x->x[3]}))
    let name = Find(m, a:key)
    return OpenFunction(name)
    return name
endfunction

function! FindLineIndex(key, start, dir, ...) abort
    let key = a:key
    let start = a:start
    let dir = a:dir
    let threshold = a:0 >= 1 ? a:1 : 500
    let anti = a:0 >= 2 ? a:2 : 0
    let i = IndexGetter2(start)
    let regex = RegexGetter(key)
    let increment = dir
    let c = 0
    let max = line('$')

    while c < threshold
        if i > max
            return max
        endif
        let c += 1
        let line = getline(i)
        if anti
            if !Test(line, regex)
                return i - increment
            endif
        else
            if Test(line, regex)
                return i
            endif
        endif
        let i += increment
    endwhile
    throw '-1'
endfunction



function! s:splitatcursor(...)
    let current_line = a:0 >= 1 ? a:1 : getline('.')
    let cursor_position = getpos('.')
    let line_before_cursor = current_line[: cursor_position[2] - 2]
    let line_after_cursor = current_line[cursor_position[2] - 1:]
    return [line_before_cursor, line_after_cursor]
endfunction

































function CssGetItems(s)
    let s = a:s
    let args = s:xsplit(s)
    let items = filter(map(args, 'CssGetItem(v:val)'), '!empty(v:val)')
    let store = Flatten2D(items)
    return store
endfunction

function CssIncrement(dir)
    let dir = a:dir
    let s:dir = dir

    function! Get12345(key, value)
        let key = a:key
        let value = a:value
        if has_key(g:indexedCabmap, key)
            return ModularIncrement2(g:indexedCabmap[key], value, s:dir)
        elseif has_key(g:cssNumericIncrementMap, key)
            let s:ref = g:cssNumericIncrementMap[key]

            function! Inc(s)
                let s = str2nr(a:s)
                for [a, b, c] in s:ref['bounds']
                    if s >= a && s < b
                        let value =  s:dir == 1 ? s + c : s - c
                        if value < 0
                            let value = b
                        elseif value > b
                            let value = a
                        endif
                        return value
                    endif
                endfor
                return s:ref['fallback']
            endfunction
            return Replace2(value, '\d+', 'Inc')
        else
            return ModularIncrementNumber(value, 5, 100, s:dir)
        endif
    endfunction 

    function! Inner123(s)
        let s = a:s
        if Test(s, '\{ *$')
            return 
        endif
        if Test(s, '/\*')
            function Inner(key)
                let key = a:key
                let newKey = ModularIncrementNumber(key)
                return CssColorTransform(newKey)
            endfunction
            let r =  '\v\S+ /\* (\w+) \*'
            let t = '\=Inner(submatch(1))'
            return substitute(s, r, t))
        endif
        let m = CssMatchLine(s)
        if empty(m)
            return 
        endif
        " ec m
        let [front, key, current] = m
        let value = Get12345(key, current)
        let s = printf('%s%s: %s;', front, key, value)
        return s
    endfunction
    call GetSetFn('Inner123')

endfunction

    " align-items: center;
    " padding: 38px;
    " background: red;
    
function CssEditValue(s)
    let s = a:s
    let s = Match(s, '^.{-}\ze:') . ':  '
    return {'text': s, 'pos': len(s), 'insertStart': 1}
endfunction

function CssEditNumber(s)
    let s = a:s
    let i = match(s, '\v\d')
    if empty(i)
        return 
    endif
    let s = Replace(s, '\d+', '')
    return {'text': s, 'pos': i + 1, 'insertStart': 1}
endfunction
function CssEdit(key)
    let key = a:key
    let Fn = 'CssEdit' . Capitalize(key)
    let s = getline('.')
    let value = function(Fn)(s)
    if empty(value)
        return 
    endif
    let text = get(value, 'text', '')
    let pos = get(value, 'pos', '')
    let insertStart = get(value, 'insertStart', 0)
    call setline('.', text)
    call cursor('.', pos)
    if insertStart
        startinsert
    endif
    "asdfasdf  abc
    "asdfasdf: sdfsdf 
endfunction




function CssEditDelete(s)
    let s = a:s
    let s = Match(s, '^.{-}\ze:') . ': none;'
    return {'text': s}
endfunction


function CssDefine(...)
            "white-space: aasdfasdf;
    let s = a:0 >= 1 ? a:1 : getline('.')
    let s = getline('.')
    let m = CssMatchLine(s)
    if Exists(m)
        let [_, a, b] = m
        let abrev = Abrev(a)
        let s = printf('%s | %s | %s', abrev, a, b)
        ec s
        call AppendFile(g:temptextfile, s)
    endif
endfunction
function CssMatchLine(s)
    let s = a:s
    let r = '(.{-})([a-z0-9-_]{-}): *(.{-});'
    let m = Match2(s, r)
    return m
endfunction
function Sdfs()
    if 0
        ec 'hi'
    endif
endfunction

function CssColorTransform(s)
    let s = a:s
    if has_key(g:cssColorMap, s)
        let Item = g:cssColorMap[s]
        return Item . printf('/* %s */', s)
    endif
    return s
endfunction
function CssPmwh(s)
    let s = a:s
    let unit = 'px'
    if Test(s, '\d$')
        let s .= unit
    endif
    return s
endfunction

function CssAddPeriod(s)
    let s = a:s
    let m = Match(s, '^\S+')
    if Test(m, '^\.') || Includes(m, g:allHtmlTags)
        return s
    endif
    return '.' . s
endfunction


function CssSnippetFromEnd()
    let s = getline('.')
    if Test(s, '^\S') && !Test(s, '\{ *$')
        let s = CssAddPeriod(s)
        let snippet = trim(s) . " {\n    $c\n}\n"
        call InsertSnippet(snippet, '')
    endif
endfunction

function! BaseTabCompletion(...)
    let ref = a:0 >= 1 ? a:1 : 0
    let s = getline('.')
    let pos = col('.') - 1
    let m = strpart(s, 0, pos)

    if m =~ '^\s*$'
        return "\<Tab>"
    else
        if !empty(ref)
            let word = Match(m, '[_.a-z0-9]+$')
            if has_key(ref, word)
                return Backspaces(len(word) . ref[word])
            else
                return "\<C-x>\<c-u>"
            endif
        else
            return "\<C-x>\<c-u>"
        endif
    endif
endfunction
    
function! SaveNode1()
    let a = ExecuteFunctionCaller2()
    call append('.', '    "test: ' . string(a))
endfunction


function! KeyboardPlaceItems(store, indent)
    "test: ['background: red;', 'background: red;']
    let store = a:store
    let indent = a:indent
    let store = a:store
    let a = g:keyboard.rl . repeat("\<space>", indent)
    let t = join(store, "\<CR>")
    return a . t
endfunction




function! GoHandler(k)
    let k = a:k
    if k == 'qtf'
        return OpenFunction(g:vimCurrentTestFunction)
    elseif k == 'qt'
        return OpenFunction(g:vimCurrentTestFunction)
    elseif 
        "
    else
    endif

endfunction
silent iunabbrev <buffer> l

function! Fooovvvvvvvvvvvoo()
    return 

    sdf:sd;
        sdf:ss;
        bgr1
    background: red;
    sdf }
    font: red;
    display: flex;
    display: flex;
    align-items: center;
    justify-content: center;

endfunction
function CssComplete(findstart, base) abort
    let findstart = a:findstart
    let base = a:base

    if findstart
        return FindStart()
    else
        let completionWords = b:completionWords
        if has_key(b:completionWords.dict, base)
            return [b:completionWords.dict[base]]
        else
            let r = '^' . base
            return filter(copy(b:completionWords.list), 'Test(v:val, r)')
        endif
    endif
endfunction

function! CssNormalKey(key)
    let key = a:key
    if key == 'bs'
        let g:s = s:sub(g:s, '\w$', '', '')
    else
        let g:s .= key
    endif
    ec g:s
endfunction


function! CssBlockExit()
    return BaseBlockExitExpr()
endfunction

function! CssBlockEnter()
    return BaseBlockEnterExpr()
endfunction

function! CssNormalTab()
    let s = getline('.')
    let r =  '\d\zs(px|pt|\%|in)'
    let m = Match(s, r)
    if Exists(m)
        let items = ['px', 'pt', '%', 'in']
        let next = ModularIncrement2(items, m)
        call GetSetReplace(r, next)
    endif
endfunction
function! CssNormalEnter()
    if CssSubmitString()
        return
    endif
endfunction

function! CssNormalSpace()
    if !CssSubmitString()
        return CssIncrement(1)
    endif
endfunction
function! CssSubmitString()
    let t = trim(g:s)
    if !Exists(t)
        return 0
    endif
    let g:s = ''
    if IsNumber(t)
        call GetSetReplace('-?\d[0-9.]*', t)
    elseif IsNumber(t)
        call GetSetReplace('-?\d[0-9.]*', t)
    endif
    return 1
endfunction

function! GetSetReplace(r, rep, ...)
    let r = a:r
    let rep = a:rep
    let flags = a:0 >= 1 ? a:1 : ''
    return GetSetFn({s -> substitute(s, '\v' . r, rep, flags)})
endfunction
function! ModularIncrementNumber(value, inc, limit, dir)
    "test: abc3, 23, 10, 1

    let s:inc = a:inc
    let s:limit = a:limit
    let s:dir = a:dir
    let value = a:value
    function! ModularIncrementNumberRunner(n)
        let n = a:n
        if n >= s:limit
            return s:inc
        elseif n <= s:inc
            return s:limit
        else
            return n + (s:inc * s:dir)
        endif
    endfunction
    return substitute(value, '\v\d+', '\=ModularIncrementNumberRunner(submatch(0))', '')
endfunction
function! GetHtmlBlockIndexes()
    let a = line('.')
    let ind = GetIndent()
    let n = max([0, ind - 4])
    let r = empty(n) ? '^\S' : printf('^ {0,%s}\S', n)
    let b = FindLineIndex(r, '.', 1) - 1
    return [a, b]
endfunction
function! VhtmlBlockIndent()
   let [a,b] = GetHtmlBlockIndexes()
   let spaces = GetSpaces(getline(a))
   for i in range(a, b)
        call setline(i, '    ' . getline(i))
   endfor
   call append(a - 1, spaces)
   call cursor(a, 100)
   normal! zz
   startinsert!
    "asdf
    "asdf
        "asdf
        " dsfsdfsdf
        " dfgdfgdf
            "asdf
                "asdf
    "asdf
endfunction

function! VhtmlBlockDedent()
   let [a,b] = GetHtmlBlockIndexes()
   for i in range(a, b)
        call setline(i, Replace(getline(i), '^    ', ''))
   endfor
   let spaces = GetSpaces(getline(a))
   call append(a - 1, spaces)
   call cursor(a, 100)
   normal! zz
   startinsert!

    "asdf
        "asdf
    
    " dsfsdfsdf
    " dfgdfgdf
        "asdf
endfunction
function! HtmlBlockEnter()
    let i = line('.')
    let s = getline(i)
    let t = trim(s)
    if empty(t)
        let i = FindLineIndex('^ +\S+', -1)
        let n = GetIndent(getline(i))
        return g:keyboard.rl . repeat(' ', n)
    endif
    return "\<ESC>O\<TAB>"
endfunction
function! HtmlBlockExit()
    let i = line('.')
    let s = getline(i)
    let t = trim(s)
    let n = GetIndent(s)
    if empty(t)
        let i = FindLineIndex('^ +\S+', -1)
        let n = GetIndent(getline(i))
        return g:keyboard.rl . repeat(' ', max([n - 4, 0]))
    endif
            return "\<ESC>o\<ESC>0Da" . repeat(' ', max([n - 4, 0]))

endfunction

function! HtmlBlockExitUp()
    return "\<ESC>O\<BS>"
endfunction
function! HtmlBlockNormalEnter()
    return 
endfunction
function! HtmlBlockNormalExit()
    return 
endfunction

function! HtmlComment()
    function InnerHtmlComment(s)
        let s = a:s
        if Test(s, '\<!--')
            return substitute(s, '\v\<!-- *(.{-}) *--\> *', '\=submatch(1)', '')
        else
            let [spaces, line] = GetSpacesAndLine(s)
            return printf('%s<!-- %s -->', spaces, line)
        endif
    endfunction
    return GetSetFn('InnerHtmlComment')
endfunction
function! HtmlCommentExpr()
    let s = '<!-- $c -->'
    return PlaceKeyboardSnippet(s)
endfunction

function! PlaceKeyboardSnippet(s)
    let s = a:s
    let [a,b] = split(s, '\$c')
    return a . b . repeat(g:keyboard.left, len(b))
endfunction

vnoremap b :<c-u>call VAction('VReplaceBlock', '')<left><left>
vnoremap v :<c-u>call VAction('')<left><left>

vnoremap p :<c-u>call VAction('VMakeSnippet')<CR>

function! Redir(statement)
    
    let store = ''
    execute printf("
        \\n redir => store
        \\n silent %s
        \\n redir END
    \\n", a:statement)
    return store
endfunction

function! ExportVimGlobals()
    let s = Redir('verbose let g:')
    call Write2024('vimGlobals.json', s)
endfunction
function! Write2024(file, value)
    let file = a:file
    let value = a:value
    if empty(value)
        return 
    endif
    let flag = 'w'
    if GetExtension(file) == 'json' && !IsString(value)
        let value = json_encode(value)
        let flag = 'b'
    endif
    let outpath = NPath(g:dir2024, Tail(file))
    call LogCreateTime(outpath, 'files.log')
    call writefile([value], outpath, flag)
endfunction
function! ParseGlobals()
    call Write2024('vimGlobals.json', ObjectFixer(g:))
endfunction

function! Sdokfsod()
    let a = {'a': function('Write2024')}
    call Write2024('temp.txt', json_encode(ObjectFixer(a)))
endfunction

function! ObjectFixer(X)
    function! s:OFRunner(X)
        let X = a:X
        if IsArray(X)
            let store = []
            for Item in X
                call add(store, s:OFRunner(Item))
            endfor
            return store
        elseif IsObject(X)
            let store = {}
            for [K,V] in items(X)
                let store[K] = s:OFRunner(V)
            endfor
            return store
        elseif IsString(X)
            return X
        elseif IsFunction(X)
            return string(X)
        elseif IsNumber(X)
            return X
        endif
    endfunction

    let X = a:X
    return s:OFRunner(X)
endfunction




function! InitializeVariable(s)
    let s = a:s
    if exists(s)
        return 1
    endif
    execute(printf('let %s = 1', s))
    return 0
endfunction

function! SetupController()
    
    return 
    for [k,v] in items({'a'1})
        let g:[k]
    endfor
    return 
    if InitializeVariable('b:touched')
        return 
    endif

    let lang = &filetype
    let file = CurrentFile()
    let file = 
    let jp = VimTemplater('$lang.')
    let state = ReadJSON(jsonPath)
    let unmappings = state.unmappings
    let completions = state.completions
    unmappings completions 
endfunction
    
let g:dirdict['2024'] = "/home/kdog3682/2024/"
let g:dir2024 = "/home/kdog3682/2024/"
function! Npath(dir, file)
    let dir = a:dir
    let file = a:file
    let s = PathJoin(get(g:dirdict, dir, dir), file)
    return AssertionManager(s, 'IsFile')
endfunction
function! ReadJSON(file)
    " test: "vim.json"
    let file = Npath('2024', a:file)
    return json_decode(s:joinlines(readfile(file)))
endfunction

function! s:joinlines(s)
    return join(a:s, "\n")
endfunction
function! s:sotd(s)

    let s = a:s
    let [a,b] = SplitOnce(s)
    let c = split(b, '  \+')
    return [a,c]
endfunction

function! GoFileGoFunction(k)
    let k = a:k

    if has_key(g:globalAliases, k)
        let s = s:gval(g:globalAliases[k])
        call OpenFunction(s)
    elseif has_key(g:gfgfdict, k)
        let [file, fnName, getMethod] = g:gfgfdict[k]
        call OpenBuffer3(file)
        call OpenFunction(fnName, getMethod)
    elseif has_key(g:execRef, k) && s:llvf(g:execRef[k])
        let [file, fnName] = ['/home/kdog3682/.vimrc', g:execRef[k]]
        call OpenBuffer3(file)
        call OpenFunction(fnName)
    else
        let items = s:gfts('functionFileRef')
        let item = Fzf(items, k, 'name')
        call OpenBuffer3(item['source'])
        call OpenFunction(item['name'])
    endif
    
endfunction
function! s:gval(s)
    let s = a:s
    try
        return eval('g:' . s)
    catch
        try
            return eval(s)
        catch
            let error = v:exception
        endtry
        call RedStop()
    endtry
endfunction

function! RedStop()
    call Red(v:exception)
    throw ''
endfunction
function! Fzf(items, key, objectKey)
    let items = a:items
    let key = a:key
    let objectKey = a:objectKey

    let r = CreateRE(key)
    let m = filter(copy(items), {i,s -> Test(s[objectKey], r)})
    let l = len(m)
    let c = 0
    while c < 10
        let c += 1
        
        if l < 1
            return 
        elseif l == 1
            return m[0]
        elseif l <= 10
            return Choose2023(m)
        else
            call BlueList(m)
            let key = InputChars(3)
            let m = filter(copy(items), {i,s -> Test(s[objectKey], key)})
        endif
    endwhile
endfunction

function! s:getchar()
  let c = getchar()
  " ec c == "\<BS>"
  " return
  if c == 3 || c == 96
      throw 'FORCE STOP'
  endif
  if c == 13
    return g:keyboard.enter
  endif
  return get(g:codepoints, c, c)
endfunction
function! s:gfts(key)
    let lang = &filetype
    let key = a:key
    if has_key(g:fts, lang)
        return g:fts[lang][key]
    else
        let path = lang . '.fts.json'
        let g:fts[lang] = ReadJSON(path)
    endif
endfunction
function! OpenExampleJS()
    call OpenBuffer3("/home/kdog3682/2023/examples.js")
endfunction
function! CheckIfFunctionExists(...)
    let k = a:0 >= 1 ? a:1 : GetCurrentWord4()
    try
        ec [k, function(k)]
    catch
        let error = v:exception
        return 
    endtry
endfunction
function! UnmapIab(s)
    let s = a:s
    " test: "asdf"
    try
        execute "iunabbrev " . s
    catch
    endtry
    try
        execute "iunabbrev <buffer>" . s
    catch
    endtry
endfunction
function! GetSetBufLine(file, line, Fn)
    "test: '/home/kdog3682/2023/f.js', 10, 'Sayhi'

    let file = a:file
    let line = a:line
    let bufnr = bufadd(file)
    if !bufloaded(file)
        call bufload(bufnr)
    endif

    let prev = getbufline(bufnr, line)
    "test: '/home/kdog3682/2023/f.js', 11, 'Sayhi'
    let value = ToLines(FunctionGetter(a:Fn)(Smallify(prev)))
    call setbufline(file, line, value[0])
    for item in value[1:]
        call appendbufline(file, line, item)
    endfor
endfunction
function! WriteTempFile(s)
    let s = a:s
    if IsArray(s) && !IsString(s[0]) || IsObject(s)
        let s = json_encode(s)
    endif
    call writefile(ToLines(s), '/home/kdog3682/2024/temp.txt', 'w')
endfunction
function! Sayhi(...)
    
    let m = 'Saying hi from ' . (a:0 >= 1 ? a:1 : 'Bob')
    ec m
    return m
endfunction
function! Sdfkjsdl0()
    let s = "abc def\nabc def"
    let r = '(abc) (def)'
    let m = s:findall(s, r)
    return m
endfunction


function! s:findall(s, r)
    let r = a:r
    let s = a:s
    let s:n = len(FindallStrings(r, '\v\\@<!\('))
    " ec s:n
    let s:store = []
    function! InnerFindall(s)
        let s = a:s
        call add(s:store, a:s[1:s:n])
        return ''
    endfunction
    call substitute(s, Regexed(r), function('InnerFindall'), 'g')
    return s:store
endfunction
function! Sdfsd0f()
    let a = {'abc': 'def'}
    " ec a.abc . 'a'
endfunction

function! EvaluateFromShell(shell, file, ...)
    let shell = a:shell
    let file = a:file
    let items = map(Flat(a:000), "ShellEscape(Stringify(v:val))")
    call insert(items, file)
    call insert(items, shell)
    let s = join(items, ' ')
    " ec [s]
    " return
    return systemlist(s)
    let result = join(systemlist(s), "\n")
    call s:blue(result)
    try
        if s:exists(result)
            let value = json_decode(result)
            return value
        else
            ec 'no result'
        endif
    catch
        call RedPrint(v:exception)
    endtry
endfunction

function! s:evaljs(file, ...)
    " test: "f.js"
    return EvaluateFromShell('node', a:file, a:000)
endfunction

function! s:evalpy(file, ...)
    return EvaluateFromShell('python3', a:file, a:000)
endfunction


function! SetNormalQTFunction()
    
endfunction
function! s:node(...)
    let cmd = join(s:flat('!clear; node', a:000), ' ')
    if g:debug =~ 'javascript'
        ec 'yoyoyo'
        return 
        let m = systemlist(cmd)
        call JavascriptErrorHandler(m)
    else
        ec cmd
        execute cmd
    endif
endfunction
function! s:python(...)
    let cmd = join(s:flat('!clear; python3', a:000), ' ')
    if g:debug =~ 'javascript'
        let m = systemlist(cmd)
        call JavascriptErrorHandler(m)
    else
        execute cmd
    endif
endfunction

function! s:jsvimeval(key, ...)
    let key = a:key
    let moreArgs = a:0 >= 1 ? a:000 : '/home/kdog3682/2024/temp.txt'
    return s:evaljs('vimConnector.js', key, moreArgs)
endfunction

function! Node0()
    """"""""""""""""""""""""""""""""""""""""
    " let value = s:evaljs('node-utils.js', '/home/kdog3682/2024/temp.txt')
    " let value = s:jsvimeval('parseVerbose')
    """"""""""""""""""""""""""""""""""""""""
    " let value = 
    " let value = 
    " let value =
    """"""""""""""""""""""""""""""""""""""""
    return 
    ec value
    """"""""""""""""""""""""""""""""""""""""
endfunction
function! s:so(s, ...)
    "test: abc a
    let s = a:s
    let d = a:0 >= 1 && !empty(a:1) ? a:1 : Match(s, '[/ ]')
    if empty(d)
        return [s, '']
    endif
    if Test(trim(s), '^' . d)
        return ['', trim(s)[1:]]
    endif
    let i = match(s, '\v' . d)
    return [s[0:i-1], s[i+1:]]
    " return i
endfunction
vnoremap foobar :<c-u>call VAction('VMakeSnippet')<CR>

function! GISmartBlockFTText()
    let i = line('.') 
    let u = s:fli('^------', i, -1, 200, 0)
    let d = s:fli('^------', i, 1, 200, 0)
    return [u, d]
endfunction
function! GISmartBlock() abort
    if &filetype == 'text'
        return GISmartBlockFTText()
    endif
    let i = line('.')
    let s = getline(i)
    let m = Match(s, '^\S+')
    if Exists(m)
        if Test(m, '------')
            let down = FindLineIndex('------', line('.') + 1, 1)
            return [i, down]
        endif
        let r = '^(async|class|const|var|def|function)>'
        if Test(m, r)
            return GetCodeIndexes()
        else
            return [i, FindLineIndex('^\S', line('.') + 1, 1, 500, 1)]
        endif
    else
        return  GICob()
    endif

endfunction


"

function! JavascriptErrorHandler(m)
    "test: readfile('clip.js')
    let m = a:m

    " saves the error to  a paste buffer
    " opens the file with the error
    " keeps track of things
    "

    let l = len(m)
    let a = l - 17
    let b = l - 13
    if a < 0 || b < 0
        return 
    endif
    let aa = m[a]
    let bb = m[b]
    let hasError = Test(aa, '^file') && Test(bb, '^\w*Error')
    if !hasError
        return 
    endif

    " call SetPasteBuffer(m)
    " return

    let messageLine = m[b]
    let errorData = []

    let c = 0
    let r0 = '^ +at file://(.{-}):(\d+):(\d+)'
    let r1 = '^ +at (\S+) \(file://(.{-}):(\d+):(\d+)\)'
    while c < 10
        let c += 1
        let t = m[b + c]
        let ma = Match2(t, r0)
        if Exists(ma)
            call add(errorData, {'file': ma[0], 'lineNumber': ma[1]})
        else
            let ma = Match2(t, r1)
            if Exists(ma)
                call add(errorData, {'file': ma[1], 'lineNumber': ma[2], 'function': ma[0]})
            else
                break
            endif
        endif
    endwhile

    let file = CurrentFile()
    let payload = {'message': messageLine, 'errors': errorData}

    """
    " nnoremap 0 """
    let out = [file, '', messageLine, '']
    for item in errorData 
        call add(out)
    endfor

    return 
    call AppendFile('debug.txt', out)
    call OpenBuffer3('debug.txt')
endfunction

function! s:filegetter(s)
    let s = a:s
    let t = s:sub(s, '\~/', g:rootdir, '')
    if s:isfile(t)
        return t
    endif
    throw 'not a file: ' . t
    call s:throw('not a file: ' . t)
endfunction

function! s:throw(s)
    let s = a:s
    throw s
endfunction
function! BufLoad(file)
    let file = s:filegetter(a:file)
    let bufnr = bufadd(file)
    if !bufloaded(file)
        call bufload(bufnr)
    endif
    return bufnr
endfunction

function! GetBufLine(file, line)
    let file = a:file
    let line = a:line
    call BufLoad(file)
    let s = getbufline(file, line)
    return s
endfunction
function! BlueInput(s)
    let s = a:s
    call Blue("\n" . Stringer(s))
    let answer = input('')
    return answer
endfunction



function! Debugger(...)
    return !empty(g:debug) && !empty(x) && x == g:debug
endfunction

function! s:geval(s)
    let s = a:s
    return eval('g:'. s)
endfunction
function! Explorer(k)
    "test: ftplugindir/k
    let [a,b] = s:so(a:k)
    let dir = ''
    try
        let dir = DirGetter(a)
    catch
        let dir = s:geval(a)
    endtry
    let dir = empty(b) ? dir : PathJoin(dir, b)
    if IsDir(dir)
        execute "Explore " . dir
    elseif IsFile(dir)
        call OpenBuffer3(dir)
    else
        throw ''
    endif
endfunction
function! DittoReplace(s, r, rep)
    let s = a:s
    let r = a:r
    let rep = a:rep
    " call input(json_encode({"s": s, "r": r, "rep": rep}))
    return s:sub(s, r, {x -> MatchCapitalization(rep, x[0], s)})
endfunction

function! ZAction()
    let i = FindLineIndex('^ *function', '.', -1)
    let params = GetParameters(getline(i))
    let payload = map(params, "'    let ' . v:val . ' = a:' . v:val")
    call AppendBelow2(payload, i)
endfunction
function! CreateBookmarkID(s)
    let t = VimTemplater('$bookmarkCommentStart bookmarkId: $binding-$timestamp %s $bookmarkCommentEnd', a:s)
    return t
endfunction

function! AppendBookmarkID(...)
    " test: "abc"
    let v = a:0 >= 1 ? a:1 : '$prompt(Write a note for this bookmark)'
    let t = CreateBookmarkID(v)
    call s:appendabove(t)
    call s:appendfile('tickets.txt', t)
endfunction
function! s:myappend(i, s)
    let i = a:i
    let s = a:s
    let s:insert_count = 0
    call append(i, s)
endfunction
function! s:appendbelow(s, ...)
    let i = line('.')
    let move = a:0 >= 1 ? 1 : 0
    call s:myappend(i, s:indent(a:s, s:getspaces('.')))
    if move
        call cursor(i, 100)
    endif
endfunction

function! s:appendabove(s, ...)
    let i = line('.')
    let move = a:0 >= 1 ? 1 : 0
    call append(i - 1, s:indent(a:s, s:getspaces(i)))
    if move
        call cursor(i, 100)
        call startinsert!
    endif
endfunction


function! s:appendabove(s, ...)
    let i = line('.')
    let move = a:0 >= 1 ? 1 : 0
    call append(i - 1, s:indent(a:s, s:getspaces(i)))
    if move
        call cursor(i, 100)
        call startinsert!
    endif
endfunction

function! s:numbergetter(x)
    return s:isstring(a:x) ? len(a:x) : a:x
endfunction
function! s:comment(s)
    let s = a:s
    if IsArray(s)
        return s:joinlines(map(s, 's:comment(v:val)'))
    endif
    return s:jspy('commentPrefix') . ' ' . a:s
endfunction
function! s:commentedlinebreak(...)
    let n = a:0 >= 1 ? s:numbergetter(a:1) : 65
    return s:repeat('"',n)
endfunction
function! s:repeat(x, n)
    let x = a:x
    let n = s:numbergetter(a:n)
    return repeat(x, n)
endfunction


function! MarkAsHighFrequencyLine()
    let s = VimTemplater("$date $file $"
    call s:appendfile('hfl.txt', s)
endfunction

function! s:read(a)
    let a = a:a
    let a = s:npath('/home/kdog3682/2024/', a)
    return readfile(a)
endfunction
function! s:appendfile(a, b)
    let a = a:a
    let b = a:b
    let a = s:npath('/home/kdog3682/2024/', a)
    if !IsFile(a)
        call LogCreateTime(a, 'files')
    endif
    call AppendFile(a, b)
endfunction

function! s:npath(dir, file)
    let dir = a:dir
    let file = a:file
    let a = a:a
    return Npath('/home/kdog3682/2024/', a)
endfunction


function VReplace(state)
	let state = a:state
    let [a,b] = s:so(state.arg)
    let a = Replace(a, '\.', '.{-}')
    return ['Sub', a, b]
endfunction

function! MatchCapitalization(word, refWord, sentence)
    let word = a:word
    let refWord = a:refWord
    " call input(json_encode({"word": word, "refWord": refWord, "sentence": sentence}))
    if Test(refWord, '\C^[A-Z]+$')
        return toupper(word)
    endif
    if Test(refWord, '\C^[A-Z]')
        return Capitalize(word)
    endif
    return word
    
endfunction


function! VCopy(state)
    let state = a:state
    call SetPasteBuffer(state.lines)
endfunction

function! Ticket(...)
    let s = a:0 >= 1 ? a:1 : 'type: ticket'
    let t = CreateBookmarkID(s)
    call s:appendfile('tickets.txt', t)
endfunction
function! Todo(s)
    let s = a:s
    call s:appendfile('tickets.txt', s)
endfunction
function! s:tabs(spaces)
    return repeat(' ', s:numbergetter(a:spaces))
endfunction


function! s:nomatch(x)
    let x = a:x
    call Red('No match for: ' . x)
    
endfunction
function! GetClosestParam()
    let r = '\((.{1,})\)'
    let i = FindLineIndex(r, '.', -1, 5)
    if i == -1
        return 
    else
        let m = Match2(getline(i), r)
        return m
    endif
endfunction
function! GetClosestVar()
    let i = FindLineIndex(s:jspy('varCRE'), '.', -1, 5)
    return Match2(getline(i))
endfunction

function! NormalWPSnippet(s)
    call append('$', '')
    execute "normal! G"
    call Snippeteer(a:s, '$')
endfunction
function! s:promptwithlist(items, ...)
    let items = a:items
    let message = a:0 >= 1 ? a:1 : ''
    if s:exists(message)
        call Blue(message)
    endif
    call BlueList(items)
    let a = input('')
    if IsNumber(a)
        return items[a - 1]
    endif
    return a
endfunction

function! s:prompt(...)
    " test: "howdsdf"
    let s = a:0 >= 1 ? a:1 : 'awaiting @ s:prompt:'
    if g:debug && a:0 >= 2
        return a:2
    endif
    call Blue(s)
    if a:0 >= 2
        call Blue('the fallback is: ' . a:2)
    endif
    let v = input('')
    return s:exists(v) ? v : (a:0 >= 2 ? a:2 : '')
endfunction
function! s:escapespace(s)
    let s = a:s
    return s:sub(s, ' ', 'zzspace')
endfunction
function! s:unescapespace(s)
    let s = a:s
    if empty(s)
        return ''
    endif
    if s:isstring(s)
    return s:sub(a:s, 'zzspace', ' ')
    endif
    return s
endfunction
function! DefineJSPY(s)
    " test: "booga"

    let s = a:s
    let vim = s:escapespace(s:prompt('choose a jspy value for vim', 'abc'))
    let python = s:escapespace(s:prompt('choose a jspy value for python', 'abc'))
    let javascript = s:escapespace(s:prompt('choose a jspy value for javascript', 'abc'))
    let items = [vim, python, javascript]
    let  ref = {
    	\'vim': 0,
    	\'python': 1,
    	\'javascript': 2,
    \}
    call NormalWPSnippet(printf('jspy %s  ' . join(items, '  '), s))
    let value = items[ref[&filetype]]
    return value
endfunction















" inoreab <buffer> <expr> bc BlockComment()
" inoreab <buffer> <expr> ds DateComment()
" inoreab <buffer> <expr> ds '/* ' . strftime('%m-%d-%Y') . ' */'
" bc /*  */<LEFT><LEFT><LEFT><C-R>=Eatchar('\s')<CR>

function! GoBackupFile()
    let f = g:budir . 'vimrc' . DateStamp()
    call OpenBuffer3(f)
    " budir/vimrc
endfunction


nnoremap <buffer> 4 /^\(const\\|var\\|def\\|class\\|async function!\?\\|function!\?\) \$\?

" 10-13-2023 
function! JavascriptEnterRunner(s)
    let s = a:s
    for i in range(len(items))
        let item = items[i]
        let m = Match2(s, item.regex)
        if s:exists(m)
            let a = call(function(item.function), m)
            return g:keyboard.resetline . a . GotoCursorExpr(a)
        endif
    endfor
    return g:keyboard.enter
endfunction
function! JavascriptEnter()
    gb cssen
    gl m = 

endfunction


function! LoadLibraryItems()
    if &filetype == 'javascript'
        let javascript = 'javascript.json'
        if empty(g:javascript)
            let g:javascript = ReadJSON(javascript)
        endif
        return g:javascript
    endif

    if &filetype == 'vim'
        let vim = 'vim.json'
        if empty(g:vim)
            ec 'loading the vim library'
            let g:vim = ReadJSON(vim)
        endif
        return g:vim
    endif

    if &filetype == 'python'
        let python = 'python.json'
        if empty(g:python)
            let g:python = ReadJSON(python)
        endif
        return g:python
    endif

endfunction
function! Askjh()
    let items = a:items
    ec '----------------------------'
    for i in range(len(items))
        let item = items[i]
        let d = (i + 1) . '. ' . Stringer(item)
        call Blue(d)
    endfor
endfunction

function! s:choose(items, ...)
    let display = a:0 >= 1 ? a:1 : 0
    if s:exists(display)
        let display = map(copy(a:items), {i,x -> x[display]})
        if empty(display)
            return 
        endif
        let index = s:chooseindex(display)
        return a:items[index]
    endif
    return Choose2023(a:items)
    let items = a:items
    if empty(items)
        return 
    elseif len(items) == 1
        return items[0]
    endif

    let s:i = 0
    function! s:make(items, n)
        let items = a:items
        let n = a:n
        if s:i < 0
            let s:i = 0
        endif
        let a = s:i * 10
        let b = s:min(items, a + 10 - 1)
        let c = b - 11
        let s:i += n
        if c < 0
            let c = 0
            let b = 10-1
        endif

        return items[c:b]
    endfunction

    function! s:get(ref)
        redraw
        call BlueList(a:ref)
        return s:getchar()
    endfunction

    let c = 0
    let ref = s:make(items, 0)
    while c < 100
        let c += 1
        let a = s:get(ref)
        if a == g:keyboard.left
            let ref = s:make(items, -1)
        elseif a == g:keyboard.right || a == g:keyboard.space
            let ref = s:make(items, 1)
        elseif IsNumber(a)
            return ref[a]
        else
            continue
        endif
    endwhile

endfunction
function! s:test(a, b, ...)
    let a = a:a
    let b = a:b
    let s:flags = a:0 >= 1 ? a:1 : ''
    function! s:inner(s, r)
        let s = a:s
        let r = s:flags =~ 'b' ? '<' . a:r . '>' : a:r
        return s =~ r
    endfunction
    if s:isstring(b)
        return s:inner(a, b)
    endif
    let c = len(b)
    if c == 2
        return s:inner(a[b[0]], b[1])
    endif
    return s:inner(a, b[0])
endfunction
function! Lkjsjfsldk()
    
    let start = 5
    let end = 10
    for i in range( end, start, -1)
      echo "Current value: " . i
    endfor

endfunction
function! s:find(items,  ...)
    let items = a:items
    let backwards = a:0 >= 2 ? 1 : 0
    let s:f = s:testf(a:1)
    if backwards
        for i in range(len(items) - 1, 0, -1)
            let item = items[i]
            if s:f(item)
                return item
            endif
            
        endfor
    endif
    for item in items
        if s:f(item)
            return item
        endif
    endfor
endfunction

function! WPGrabLine(s)
    " test: "f.d"
    let r = MyRegex(a:s)
    let lines = s:getlines('window')
    let m = s:find(lines, r)
    if s:exists(m)
        return trim(m)
    endif

    let store = []
    let p = getpos('.')
    let t = "g/\\v%s/call add(store, GetLineInfo())"
    execute printf(t, r)
    call setpos(".", p)
    let a = Choose2023(store)
    return a
endfunction

function! s:roundtonearest10(n)
    " test: 344
    let n = a:n
    let k = pow(10, len(n) - 1)
    return float2nr(round(n / k) * k)
endfunction
function! s:movetonearestnumber(n)
    " test: 7
    let n = a:n
    let top = s:ig('w0')
    let slice = string(top)[0:len(top) - len(n) - 1] . n
    return slice
    return slice
    let base = s:roundtonearest10(line('.'))
    let c = 0
    top
    880 
    877
    887
    while c < 20
        if s:iseven(c)
            let b += 1
        endif
        let c += 1
        
    endwhile
endfunction
let g:GI4Ref['yank'] = 'GetYankIndexes'
function! WPMoveYank(arg)
   return s:getlines('yank', a:arg)
endfunction
function! WPMoveLine(s)
    let s = a:s
    " test: 56
    " let i = line('.')
    let n = s:movetonearestnumber(a:s)
    let s = getline(n)
    return trim(s)
endfunction
function! WPGrabBlock(s)
    let s = MyRegex(a:s)
    let t = GetLibraryItem(s, 'text')
    return t[1:-1]
endfunction
function! MyRegex2(s)
    let s = s:sub(a:s, '\.', '\.{-}', '')
    let s = s:sub(s, 'az', '[a-z]+')
    return s
    
endfunction

function! MyRegex(s)
    let s = s:sub(a:s, '\.', '\.{-}', '')
    return s
    
endfunction
function! s:exists(x)
    return !empty(a:x)
endfunction
function! GotoCursorExpr(s)
    let s = a:s
    let m = match(s, '\v\$c')
    
endfunction


function! s:match(s, r)
    let s = a:s
    let r = a:r
    if s:t(r, '\CA-')
        let r = '\C' . r
    endif
    return Match2(s, r)
endfunction

function! s:push(store, val)
    let store = a:store
    let val = a:val
    if Exists(val)
        call add(store, val)
    endif
    return store
endfunction
function! s:matchfilter(items, r)
    let items = s:tolines(a:items)
    let r = a:r
    let store = []

    for item in items
        call s:push(store, s:match(item, r))
    endfor
    return store

endfunction
let g:wpsnippets["vim"]["print"] = "WPDebugPrint"
let g:wpsnippets2["global"]["mvy"] = "WPMoveYank"
let g:wpsnippets2["global"]["gd"] = "WPGrabDown"
let g:wpsnippets2["global"]["gu"] = "WPGrabUp"
let g:wpsnippets2["global"]["y5"] = "WPYank"
function! s:getspaces(...)
    let s = s:linegetter(a:000)
    return matchstr(s, '^ *')
endfunction
function! s:getindent(...)
    let s = s:linegetter(a:000)
    if IsNumber(s)
        return s
    endif
    return len(matchstr(s, '^ *'))
endfunction
function! s:t(a, b)
    return a:a =~ '\v' . a:b
endfunction
function! s:ig(x)
    let r = '^(\^|\$|w0|w\$|\.)'
    return s:t(a:x, r) ? line(a:x) : a:x
endfunction

function! s:fli(x, start, increment, threshold, anti)
    let start = s:ig(a:start)
    let i = start
    let increment = a:increment
    let X = s:testf(a:x)
    let threshold = a:threshold
    let anti = a:anti

    let c = 0
    let max = line('$')

    while c < threshold
        if i > max
            return max
        endif
        let c += 1
        let line = getline(i)
        if anti
            if !X(line)
                let value = i - increment
                if value != start
                    return value
                endif
            endif
        else
            if X(line)
                if i != start
                    return i
                endif
            endif
        endif
        let i += increment
    endwhile
    throw '-1'
endfunction

function! s:fli2(r1, r2, start, increment, threshold, anti)
    let start = s:ig(a:start)
    let i = start
    let increment = a:increment
    let X = s:testf(a:r1)
    let Y = s:testf(a:r2)
    let threshold = a:threshold
    let anti = a:anti

    let c = 0
    let max = line('$')

    while c < threshold
        if i > max
            return max
        endif
        let c += 1
        let line = getline(i)
        if anti
            if !X(line)
                let value = i - increment
                if value != start
                    return [value, 0]
                endif
            endif

            if !Y(line)
                let value = i - increment
                if value != start
                    return [0, value]
                endif
            endif
        else
            if X(line)
                if i != start
                    return [i, 0]
                endif
            endif

            if Y(line)
                if i != start
                    return [0, i]
                endif
            endif

        endif
        let i += increment
    endwhile
    throw '-1'
endfunction


function! s:ss(s)
    return SplitSpaces(a:s)
endfunction
function! s:getiden(s)
    "test: " const child = isDefined(value)"
    let s = a:s
    let r = '^ *let +(\{?\[?\w+.{-}) +\='
    let r = '(\w+) +\= '
    return s:match(s, r)
endfunction
function! WPDebugPrint(s)
    "test: 
    let s = a:s
    let items = s:ss(s)
    if empty(items)
        let lines = s:getlines('parent-to-cursor')
        let items = s:matchfilter(lines, '^ *let +(\{?\[?\w+.{-}) +\=')
    endif
    if empty(items)
        return ''
    endif
    let items = s:unique(items)
    let a = map(items, {i,x-> printf('"%s": %s', x, x)})
    let d = '{%s}'
    let d = 'call input(json_encode({%s}))'
    let t = printf(d, join(a, ', '))
    return t
endfunction

function! s:getlines(s, ...)
    let flags = a:0 >= 1 ? a:1 : ''
    let s = IsArray(a:s) ? a:s : s:gi(a:s)
    let a = s:ig(s[0])
    let b = s:ig(s[1])
    let lines = getline(a, b)

    if flags =~ 'd'
        call deletebufline('%', a, b)
    endif
    return lines
endfunction

function! s:gi(s, ...)
    " test: "code"
    if a:0 >= 1
       let [indexes, flag] = GetVisualIndexes('flag')
       if line('$') == line('.') || empty(flag)
           return indexes
       else
           return function(g:GI4Ref[a:s])()
       endif
   else
       let [a,b] = function(g:GI4Ref[a:s])()
       let [c,d] = GetVisualIndexes()
       if d - c > b - a
           return [c,d]
       else
           return [a,b]
       endif
   endif
endfunction

function! s:unique(x)
    return Unique(a:x)
endfunction
let g:GI4Ref['parent-to-cursor'] = 'BeneathParentBlockToCursorIndexes'
function! BeneathParentBlockToCursorIndexes()
    let s = getline('.')
    let in = s:getindent(s)
    let top = s:fli({line -> s:exists(trim(line)) && s:getindent(line) < in}, '.', -1, 100, 0) + 1
    return [top, line('.')]
endfunction
let g:wpsnippets["vim"]["sin"] = "function! s:inner(s)\n    let s = a:s\n    $c\nendfunction"
let g:wpsnippets2["vim"]["forab"] = "for [a,b] in $1\n\t$c\nendfor"

function! s:findall(s, r)
    return FindallStrings(a:s, a:r)
endfunction
function! s:sds(s)
    " test: ""
    let s = a:s
    if IsArray(s)
        return s
    endif
    let d = s:t(s, '  ') ? '  +' : ' '
    return s:split(s, d)
endfunction

function! s:ssds(s)
    let s = a:s
    let d = Test(s, '  ') ? '  ' : ' '
    return [split(s, d), d]
endfunction

function! s:throw(...)
    let t = a:0 >= 1 ? a:1 : 1
    if s:exists(t)
        throw 'throwing'
    endif
endfunction


function! s:assert(t, ...)
    let t = a:t
    if empty(t)
        let message = a:0 >= 1 ? a:1 : ''
        call s:red('ASSERTION ERROR')
        call s:red(message)
        throw ''
    endif
    return 
endfunction

function! s:xqft(s)
    let s = a:s
    let r = '\W'
    if Test(s, r)
        return SingleQuote(s)
    endif
    return s
endfunction
" override: Snippeteer('print template dollars items')
" override: Snippeteer('print')
" override: s:gsp(g:wpsnippets2.vim.ife, 'aa')
let g:wpsnippets2["vim"]["ife"] = "if s:exists($1)\n    $c\nendif"
let g:wpsnippets2["vim"]["ifnt"] = "if !s:test($1, ${s:xqft($2)})\n    $c\nendif"
let g:wpsnippets2["vim"]["ift"] = "if s:test($1, ${s:xqft($2)})\n    $c\nendif"
let g:wpsnippets2["vim"]["ifa"] = "if IsArray($1)\n    $c\nendif"
let g:wpsnippets2["vim"]["ifs"] = "if s:isstring($1)\n    $c\nendif"
let g:wpsnippets2["vim"]["elseif"] = "elseif $1\n    $c"
let g:wpsnippets2["vim"]["switch"] = "WPVimSwitch"
let g:wpsnippets2["javascript"] = {}
let g:wpsnippets2["javascript"]["gl"] = "WPGrabLine"
let g:wpsnippets2["javascript"]["gb"] = "WPGrabBlock"

let g:wpsnippets2["vim"]["gl"] = "WPGrabLine"
let g:wpsnippets2["vim"]["gb"] = "WPGrabBlock"
" override: s:fli('^\S', line('.'), 1, 500, 0)
" override:   
" override:   


function! s:min(...)
    let a = map(copy(a:000), 'IsNumber(v:val) ? v:val : len(v:val) - 1')
    return min(a)
endfunction

function! s:max(...)
    let a = map(copy(a:000), 'IsNumber(v:val) ? v:val : len(v:val) - 1')
    return max(a)
endfunction


function! s:range(end)
    let end = a:end 
    let start = 1
    let numbers = []
    for i in range(start, end)
        call add(numbers, i)
    endfor
    return numbers
endfunction
" override: s:choose(s:range(23))

function! s:sub(s, r, replacement, ...)
    let flags = a:0 >= 1 ? a:1 : 'g'
    return substitute(a:s, '\v' . a:r, a:replacement, flags)
endfunction

let g:jspyref3['javascript']['echoInputTemplate'] = 'console.log("%s", $1)'
let g:jspyref3['vim']['echoInputTemplate'] = "call BlueInput('$1: ' . string($1))"


function! s:indent(s, ...)
    let isa = IsArray(a:s)
    let s = s:tolines(a:s)
    let n = a:0 >= 1 ? a:1 : 4
    let spaces = s:tospaces(n)
    let value = map(s, {i,x->spaces . x })
    return isa ? value : s:tostring(value)
endfunction

function! s:nindent(s, ...)
    let isa = IsArray(a:s)
    let s = s:tolines(a:s)
    let n = a:0 >= 1 ? a:1 : s:getindent()
    let spaces = s:tospaces(n - s:getindent(s[0]))
    call BlueInput('spaces: ' . string(spaces))
    let value = map(s, {i,x->spaces . x })
    return isa ? value : s:tostring(value)
endfunction
function! s:tostring(x)
    return ToString(a:x)
endfunction

function! s:tospaces(x)
    return ToSpaces(a:x)
endfunction
function! TextPlacement(s, spaces)
    let lines = s:indent(s:sl(a:s), a:spaces)
    if g:debug
        ec 'debugging @ TextPlacement for Snippeteer'
        ec lines
        ec [a:spaces]
        return 
    endif
    call setline('.', lines[0])
    call append('.', lines[1:])
endfunction

function! s:cursor(cursorpos, ...)
    if !Exists(a:cursorpos)
        return 
    endif

    let a = 0
    let b = 0

    if IsArray(a:cursorpos)
        let spaces = a:0 >= 1 ? ToInteger(a:1) : 0
        let [a,b] = a:cursorpos
        let b += spaces
    else
        let a = a:cursorpos
        let b = a:0 >= 1 ? ToInteger(a:1) : 0
    endif

    call cursor(a, b)
endfunction

function AppendBlockAtCursor(payload, ...)
    let offsetIndex = a:0 >= 1 ? a:1 : 0
    let payload = Indent2023(a:payload)
    let cursorIndex = line('.') + len(payload) - 1
    call setline('.', payload[0])
    call append('.', payload[1:])
    call cursor(cursorIndex, 100)
endfunction

" va sh vshunt
let g:filedict["vd"] = "/home/kdog3682/.vim/ftplugin/variables.09-15-2023.vim"
let g:filedict["vd2"] = "/home/kdog3682/.vim/ftplugin/variables.10-12-2023.vim"

function! s:tolines(s)
    return IsArray(a:s) ? a:s : split(a:s, "\n")
endfunction

function! s:coercearray(s)
    return s:isarray(a:s) ? a:s : [a:s]
endfunction
function! s:print(a, b)
    let a = a:a
    let b = s:encode(a:b)
    call s:blue(printf('[%s]: %s', a, b))
endfunction
function! VLog(state)
    let state = a:state
    let r =  '^ *\w* *(\{?\[?\w+.{-}) +\='
    let r =  '^ *let +(\{?\[?\w+.{-}) +\='
    let t = 'call s:print("$1", $1)'
    let items = s:matchfilter(state.lines, r)
    let values = s:maptemplater(items, t)
    call s:appendblock(values, state.end)
    " gl map
endfunction
let g:visualactiondict['log'] = {'fn': 'VLog'}
function! s:smartindent(s, ...) 
    let baseSpaces = a:0 >= 1 ? a:1 : s:getspaces()
    let isa = IsArray(a:s)
    let spaces = s:tospaces(baseSpaces)

    if empty(a:s)
        return spaces
    endif
    let s = s:tolines(a:s)
    let initial = s:getspaces(s[0])
    let value = map(s, {i,x-> spaces . s:dedent(x, initial)})
    return value
    return isa ? value : s:tostring(value)
endfunction
function! s:dedent(s, spaces)
    return s:sub(a:s, '^' . s:tospaces(a:spaces), '', '')
endfunction


function! s:templater(t, arg)
    let t = a:t
    let t = s:sub(t, '\%s|\$c', '$1')
    let s:args = s:coercearray(a:arg)
    let s:count = -1
    function! s:inner_templater(s)
        let s = a:s
        let spaces = s[1]
        if s[3] == '%s'
            let s:count += 1
            return s:args[s:count]
        endif
        if IsNumber(s[2])
            let index = s[2] - 1
            let value = s:args[index]
            let v = s:tostring(s:smartindent(value, spaces))
            return v
        endif
        throw 'x'
    endfunction
    let v = s:sub(t, '( *)\$(\d+)|(\%s)', function('s:inner_templater'), 'g')
    return v
endfunction
function! VWrap(state)
    let state = a:state
    
    let t = get(state, 'mode') == 'wp' ? GetSnippet(state.arg) : s:jspy(state.arg)

    let lines = s:tolines(s:templater(t, state.string))
    let block = s:indent(lines, s:getindent())
    call s:replaceblock(state.indexes, block)
endfunction
let g:jspyref3['vim']['elseTemplate'] = "if 1\n    $1\nendif"
let g:jspyref3['python']['elseTemplate'] = 'b'
let g:jspyref3['javascript']['elseTemplate'] = "else {\n    $1\n}"
let g:visualactiondict['t'] = {'fn': 'VWrap', 'arg': 'tryTemplate'}
let g:visualactiondict['else'] = {'fn': 'VWrap', 'arg': 'elseTemplate'}
let g:visualactiondict['if'] = {'fn': 'VWrap', 'arg': 'ifTemplate'}
let g:visualactiondict['fn'] = {'fn': 'VWrap', 'arg': 'wrapLambdaTemplate'}
let g:visualactiondict['wrap'] = {'fn': 'VWrap', 's': 'wp', 'mode': 'wp'}

let g:visualactiondict['sh'] = {'fn': 'VShunt', 'i': 'code'}
let g:jspyref3["vim"]["wrapLambdaTemplate"] = ""
let g:jspyref3["python"]["wrapLambdaTemplate"] = ""
let g:jspyref3["javascript"]["wrapLambdaTemplate"] = "function $prompt(s) {\n    $1\n}"
function VisualShuntController(state)
    let state = a:state
    let lines = s:deletelines(state.indexes)
    call s:appendfile(s:gf(s:cacheonempty('file', state.arg)), lines)
endfunction
function VisualFileController(state)
    let state = a:state
    let files = s:matchfilter(state.lines, r)
    let action = state.arg
    if action == 'link'
        call EstablishLinkedBufferGroupRunner(files)
    elseif action == 'f'
        call map(files, 's:define('filedict', v:val)')
    endif
endfunction

let g:visualactiondict['d'] = {'fn': 'VDuplicateBlock'}
let g:jspyref3['vim']['tryTemplate'] = "try\n    $1\ncatch\nendtry"
let g:jspyref3['python']['tryTemplate'] = 'b'
let g:jspyref3['javascript']['tryTemplate'] = 'c'

let g:jspyref3['vim']['echoLogTemplate'] = "ec $1"
let g:jspyref3['python']['echoLogTemplate'] = 'b'
let g:jspyref3['javascript']['echoLogTemplate'] = 'c'

let g:jspyref3['vim']['echoReturnTemplate'] = "return $1"
let g:jspyref3['python']['echoReturnTemplate'] = 'b'
let g:jspyref3['javascript']['echoReturnTemplate'] = 'c'



function! InteractiveReplace()
    let range = '%'
    let regex = 's:(javascript|vim)EqualDict'
    let replacement = "g:jspyref3['\\1']['equalDict']"
    let flags = 'gc'

    let range = join(GI4('window', 1), ',')
    let range = '%'


    let regex = '<(javascript(Lambda)?|vim|python)Block>'
    let replacement = '\=DoubleQuote(ref[submatch(1)])'

    let regex = '(s)\ze:\w+'
    let regex = '(s)\ze:functionParamRef'

    let regex = 's:indentation'
    let replacement = 's:getindent'

    let regex = 's:splitlines'
    let replacement = 's:tolines'

    " let regex = '^".+'
    " let replacement = ''


    let t = '%ss/\v%s/%s/%s'
    execute printf(t, range, regex, replacement, flags)
endfunction
let g:gfgfdict['abc'] = ['/home/kdog3682/.vimrc', 'InteractiveReplace', 0]
" 10-14-2023 

function! s:smartpath(x)
    " test: "asdf"
    let [a,b] = s:SplitOnce()(x, '/')
    " call BlueInput('[a,b]: ' . string([a,b]))
        if Exists(value)
            return value
        endif
        let value = Npath(a, b)
endfunction
function! FileFinder(s)
    "test: app
    
"override: Snippeteer('    if m = fooga')
endfunction
let g:execRef["una"] = "execute iunabbrev $1"
let g:execRef["un"] = "execute nunmap $1"
let g:execRef["ui"] = "execute iunmap $1"

let g:execRef["unb"] = "execute nunmap <buffer> $1"
let g:execRef["unab"] = "execute iunabbrev <buffer> $1"
let g:execRef["uib"] = "execute iunmap <buffer> $1"

function! WPVimSwitch(s)
    " test: "a b c d"
    let s = a:s
    let [a,b] = s:sosall(s)
    let s:a = a
    function! s:innerwpswitch(i, s)
        let i = a:i
        let s = a:s
        let b = s:aaq(s)
        let p = i == 0 ? 'if' : 'elseif'
        return printf('%s %s == %s', p, s:a, b)
    endfunction
    let o = map(b, function('s:innerwpswitch'))
    call insert(o, '    $c', 1)
    call add(o, 'endif')
    return s:tostring(o)
endfunction

function! WPGIfSeries(s)
    " test: "a b c d"
    let s = a:s
    let [a,b] = s:sosall(s)
    let s:a = a
    function! s:innerwpswitch(i, s)
        let i = a:i
        let s = a:s
        let b = s:aaq(s)
        let p = i == 0 ? 'if' : 'else if'
        let c = i == 0 ? '$c' : ''
        return printf("%s (%s == %s) {\n    %s\n}", p, s:a, b, c)
    endfunction
    let o = map(b, function('s:innerwpswitch'))
    return s:tostring(o)
endfunction


let g:jspyref3['vim']['blockenterre'] = '^ *(if|elseif|else|for|while|do|function|\{|\[|`)>'
let g:jspyref3['python']['blockenterre'] = '[{\[:] *$'
let g:jspyref3['css'] = {}
let g:jspyref3['css']['blockenterre'] = '[{\[:] *$'
let g:jspyref3['css']['blockexit'] = '[{\[:] *$'
let g:jspyref3['javascript']['blockenterre'] = '^ *(if|else if|else|while|do|for|(async )?function|try|class)|[{\[] *$'

function! s:hr(...)
    let n = a:0 >= 1 ? a:1 : 30
    return repeat('-', n)
endfunction
function! s:linegetter(...)
    if a:0 >= 1
        try
            let t = s:isarray(a:1) ? a:1[0] : a:1
            let r = '^(\^|\$|w0|w$|\.)'
            if IsNumber(t)
                return getline(t)
            endif
            if Test(t, r)
                return getline(line(t))
            else
                return t
            endif
        catch
            let error = v:exception
            return getline('.')
            
        endtry
    else
        return getline('.')
    endif
endfunction
function! s:isemptyline(x)
    let s = s:linegetter(a:x)
    return empty(trim(s))
endfunction
function! s:getlinestate(...)
    let i = line('.')
    let s = getline(i)
    let next = getline(i + 1)
    let prev = getline(i - 1)
    let spaces = s:getspaces(s)
    let indent = len(spaces)
    let t = trim(s)
    let nlem = s:isemptyline(i + 1)
    let sol = s:t(s, '^\S')
    let data = {'sol': sol, 'prev': prev, 'next': next, "isemptyline": empty(t), "index": i, "text": s, "spaces": spaces, 'line': s, "trimline": t, 'isemptynextline': nlem, 'indent': len(spaces)}
    if a:0 >= 1
        let enter = s:jspy('blockenterre')
        let exit = s:jspy('blockexitre')
        let data['enter'] = enter
        let data['exit'] = exit
    endif
    return data
endfunction
function! BaseBlockEnterExpr()
    " test: abc, asd

    let s = s:getlinestate()
    let r = s:jspy('blockenterre')
    if s.isemptyline
        return ''
        return 'emptyline'
    endif

    if Test(trim(s.text), r)
        if s.isemptynextline
            return "\<ESC>\<DOWN>0Da" . s:tabs(s.indent + 4)
            return 'nextemptyline'
        else
            return "\<ESC>o"
            return 'esc-o'
        endif
    endif
    if s.isemptynextline
        return "\<ESC>\<DOWN>0Da" . s:tabs(s.indent + 4)
    else
        return "\<ESC>o"
    endif
endfunction

function! BaseBlockExitExpr()
    " test: abc, asd

    let s = s:getlinestate(1)
    let r = s:jspy('blockexitre')
    if s.isemptyline
        return ''
    endif

    if Test(trim(s.text), r)
        return "\<ESC>zzo"
    endif

    let i = s:fli(r, '.', 1, 10, 0)
    return "\<ESC>" . i . 'Gzzo' 
endfunction


let g:vimCurrentTestFunction = "BaseBlockEnterExpr"

let g:jspyref3['vim']['gcwre'] = '[:a-z0-9\._-]+'
let g:jspyref3['python']['gcwre'] = '[a-z0-9\._-]+'
let g:jspyref3['javascript']['gcwre'] = '[a-z0-9\._-]+'
function! s:gcw(...)
    let s = a:0 >= 1 && !empty(a:1) ? s:linegetter(a:1) : getline('.')
    let start = a:0 >= 2 && !empty(a:2) ? a:2 : col('.')
    let regex = a:0 >= 3 && !empty(a:3) ? a:3 : s:jspy('gcwre')

    let b = start
    let c = 0
    while c < 20
        if Test(s[start], '\w')
            let start += 1
        else
            break
        endif
    endwhile

    let a = start - 1
    let c = 0
    let temp = ''
    while c < 20
        let c += 1
        let ch = s[a]
        if !empty(temp)
            if ch == temp
                let a -= 1
                let temp = ''
            else
                continue
            endif
        elseif Test(ch, '\W') && !Test(ch, regex)
            if has_key(g:OPPOSITES, ch)
                let opp = g:OPPOSITES[ch]
                if In(s, opp)
                    let temp = g:OPPOSITES[ch]
                endif
            endif
            let a -= 1
        else
            break
        endif
    endwhile

    let store = []
    let c = 0
    while c < 30
        let c += 1
        let ch = s[a]
        if Test(ch, regex)
            let a -= 1
            call add(store, ch)
        else
            return join(reverse(store), '')
        endif
    endwhile
endfunction
let g:execRef["bid"] = "AppendBookmarkID"
let g:vimCurrentTestFunction = "BaseBlockEnterExpr"


function! DictSetter(name, ...)
    "test: abcref, def, ghi, abc, def

    let name = a:name
    let keys = a:000

    let ref = {}
    try
        let ref = eval(name)
    catch
        execute printf('let %s = {}', name)
        let ref = eval(name)
    endtry

    let length = len(keys)
    let o = []

    for i in range(length - 1)
        let key = keys[i]
        if i == length - 2
            let name .= printf('["%s"]', key)
            let value = keys[i + 1]
            let pvalue = s:string(value)
            call add(o, printf('let %s = %s', name, pvalue))
            let ref[key] = value 
            let s = join(o, "\n")
            ec s
            call AppendFile('/home/kdog3682/.vimrc', s)
        elseif has_key(ref, key)
            let ref = ref[key]
            let name .= printf('["%s"]', key)
        else
            let ref[key] = {}
            call add(o, printf('let %s["%s"] = {}', name, key))
            let name .= printf('["%s"]', key)
            let ref = ref[key]
        endif
    endfor
endfunction

let g:execRef['w'] = 'Whereami2'
let g:execRef["dj"] = "DefineJSPY"
let g:jspyref3['vim']['lineCommentPrefix'] = '" '
let g:jspyref3['python']['lineCommentPrefix'] = '# '
let g:jspyref3['javascript']['lineCommentPrefix'] = '// '
let g:vimCurrentTestFunction = "BaseBlockExitExpr"
let g:jspyref3['python']['blockexitre'] = '^ *([\]}]) $'
let g:jspyref3['javascript']['blockexitre'] = '^ *([\]}])\)?,? *$'
let g:vimCurrentTestFunction = "BaseBlockExitExpr"


nnoremap <buffer>` :call CommandTilda()<CR>
let g:CommandTildaRef['gr'] = 'GlobalReplaceController'
let g:CommandTildaRef['dj'] = 'DefineJavascriptIabFromLine'
let g:CommandTildaRef['dd'] = 'DefineDictionaryController'
function! DefineJavascriptIabFromLine()
    let s = trim(getline('.'))
    ec s
    let key = s:prompt('choose a key for this iab definition', 'temp')
    let b = s:input('choose cursor location. type a word or symbol or regex.')
    let r = '<' . b . '>'
    if b == ''
        let r = '<\w+>'
    elseif b == ''''
        let r = '''.{-}''|".{-}"'
    elseif b == "a"
    endif

    let m = s:match(s, printf('(.{-})(%s)(.+)', r))

    " call BlueInput('m: ' . string(m))
    " call aaa(BlueInput(string(m))); throw 'abc'

    if s:exists(m)
        let [a,b,c] = m
        let b = a . c . repeat(g:keyboard.left, len(c))
        call DefineEat(key, b)
    endif
endfunction



inoremap <buffer> <expr> q] "[\<C-O>A]\<LEFT>"

function! s:global_replace(range, regex, replacement, flags)
    let range = a:range
    let regex = a:regex
    let Replacement = a:replacement
    let flags = a:flags
    if s:isword(range) && len(range) > 1
        let range = s:gi(range)
    endif
    if IsArray(range)
        let range = join(range, ',')
    endif
    let t = '%ss/\v%s/%s/%s'
    execute printf(t, range, regex, Replacement, flags)
endfunction


function! s:isword(s)
    " test: "a___"
    let s = a:s
    return s:isstring(s) && s:t(s, '^[a-z][0-9a-z_$]+$')
endfunction

function! BaseBlockEnterExpr(...)

    let key = a:0 >= 1 ? a:1 : ''
    let s = s:getlinestate()

    if s.isemptyline
        if s.isemptynextline
        endif
        let ti = s:fli('\S', '.', -1, 10, 0)
        let top = s:getindent(ti)
        let i = s:fli('\S', '.', 1, 10, 0)
        let bot = s:getindent(i)
        return "\<ESC>/\\S\<CR>o\<ESC>^Da" . s:tabs(indent)
    endif
    
    if Test(trim(s.text), r)
        if s.isemptynextline
            return "\<ESC>\<DOWN>0Da" . s:tabs(s.indent + 4)
            return 'nextemptyline'
        else
            return "\<ESC>o"
            return 'esc-o'
        endif
    endif
    if s.isemptynextline
        return "\<ESC>\<DOWN>0Da" . s:tabs(s.indent + 4)
    else
        return "\<ESC>o"
    endif
endfunction


function! TransferWordAboveLine()
    " @bookmark 1697307066 0
    let word = GetCurrentWord4()
    let value = s:jspy('prefix') .word. ' = '
    call s:appendabove(value, 1)
endfunction

function! s:group(items, F, G)
    let items = a:items
    let store = {}
    for item in items
        let key = a:F(item)
        let item = a:G(item)
        if has_key(store, key)
            call add(store[key], item)
        else
            let store[key] = [item]
        endif
    endfor
    return store
endfunction

function! CacheAndResetMappings()
    let t = s:redir('verbose nmap <buffer>')
endfunction

function! GetLastErrorMessage()
    let t = s:redir('messages')
    return t
endfunction
function! s:encode(x)
    let x = a:x
    return s:isstring(x) ? x : json_encode(x)
endfunction

function! s:confirm(s)
    " test: "adsf"
    let a = s:blue('please confirm: %s', s:encode(a:s))
    let a = s:getchar()
    return s:t(a, '^\w$')
    call BlueInput('a: ' . string(a))
    return 1
    return empty(a) ? 0 : 1
endfunction

function! Asd0f0f()
    ec 'hi'
endfunction
" gli removes
" gli removes
function! s:removestartingcomments(s)
    return Replace(a:s, '^[''"/#]+ *', '')
endfunction
function! WPGGli(key)
    let key = a:key
    " return "a\n\nb\nc"
    let item = GetLibraryItem(key)
    if s:exists(item)
        let item = s:sub(item, 'function!? \zs\w+', '\="s:" . tolower(submatch(0))', '')
        return item
    else
        return ''
    endif
endfunction
function! s:unmap(s)
    " test: "sdf 234 afff"
    let s = s:removestartingcomments(a:s)
    " let r = s:sillygetregex(s)
    let maptype = s:match(s, 'inoreab')
    let items = split(trim(s))
    let key = 0
    let unmap = 0
    let buffer = ''
    for i in range(len(items))
        let item = items[i]
        if i == 0
            let unmap = g:unmapDict[item]
        else
            if s:t(item, '\<')
                if item == '<buffer>'
                    let buffer = '<buffer> '
                endif
                continue
            else
                let key = item
                break
            endif
        endif
    endfor
    let t = printf('%s %s%s', unmap, buffer, key)
    call BlueInput('t: ' . string(t))
    try
        execute t
        return 1
    catch
        let error = v:exception
        ec error
        return 0
    endtry
endfunction
function! s:redir(key)
    " test: "verbose imap"
    let key = a:key
    let store = ''
    execute printf("
        \\n redir => store
        \\n silent %s
        \\n redir END
    \\n", key)
    return store
endfunction


" @bookmark 1697307066 0
let g:execRef["twa"] = "TransferWordAboveLine"

function! TransferExprAboveLine()
    
endfunction

function! s:isfile(s)
    return IsFile(a:s)
endfunction

function! s:isdir(s)
    return IsDir(a:s)
endfunction

function! s:isdir(s)
    return IsDir(a:s)
endfunction

function! s:flat(...)
    " test: [[[1,2]]]
    let s:store = []
    function! s:innerflat(s)
        if IsArray(a:s)
            for item in a:s
                call s:innerflat(item)
            endfor
        else
            if s:exists(a:s)
                call add(s:store, a:s)
            endif
        endif
    endfunction
    call s:innerflat(a:000)
    return s:store
endfunction


function! s:printf(...)
    "test: ['hi %s  $1', 'bye', 'sss']
    let args = map(s:flat(a:000), 's:encode(v:val)')
    let template = remove(args, 0)
    return s:tostring(s:templater(template, args))
endfunction
function! s:blue(...)
    let t = s:printf(a:000)
    call s:color(t, 'blue')
endfunction

function! s:red(...)
    let t = s:printf(a:000)
    call s:color(t, 'red')
endfunction


function! s:input(...)
    call s:blue(a:000)
    let v = input('')
    return v
endfunction




inoreab <buffer>lx {x<space>-><space>}<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer>5s %s<C-R>=Eatchar('\s')<CR>
function! s:sillygetregex(s)
    " test: "the apple tre"
    let s = a:s
    call s:blue(s)
    let a = input('how many matches do you seek?')
    call s:blue('confirmed. the regex will return once %s matches are met. you may begin trying', a)
    let c = 0
    while c < 10
        call s:blue('text: ' . s)
        let b = s:input('go ahead and try a regex')
        let m = s:match(s, b)
        if s:exists(m)
            if IsArray(m)
                if len(m) == a
                    call append('$', s:comment(b))
                    return b
                    return m
                endif
            elseif a == 1
                call append('$', s:comment(b))
                return b
                return m
            endif
        endif
        let c += 1
    endwhile
endfunction
inoreab <buffer>77 &&
inoreab <buffer>55 %s
function! s:color(text, color)
    let text = a:text
    let color = a:color
    
    if color == 'red'
        :echohl MyCustomRedColor
    elseif color == "blue"
        :echohl MyCustomBlueColor
    elseif color == "green"
        :echohl MyCustomGreenColor
    endif

    :echo text
    :echohl None
endfunction
function! s:filter(items, F)
    let items = a:items
    return filter(copy(items), s:fngetter(a:F))
endfunction
function! s:testf(r)
    if IsFunction(a:r)
        return a:r
    endif
    return {x -> x =~ '\v' . a:r}
endfunction

function! Appdefinetempnormalmapping()
    let t = 'nnoremap <buffer> %s %s'
    let k = 'c'
    let v = 'Apptextmarking'
    ec printf(t, k, v)
    execute printf(t, k, v)
endfunction
function! Apptextmarking()
    function s:inner(s)
        call s:appendfile('text-marks.txt', trim(a:s))
    endfunction
    call s:getsetline('s:inner')
endfunction
function! Appgetglobalkeys()
    let r = '(\w+ref\d*|\w+dict\d*)$'
    let items = sort(s:matchfilter(keys(g:), r))
    call s:appendfile('vim-dict-keys.txt', items)
endfunction
let g:execRef["app"] = "Appgetglobalkeys"
let g:execRef["dtnb"] = "Appdefinetempnormalmapping"
function! s:page(r)
    " test: '<\w{5,}>'
    let r = a:r
    let s:store = []
    let replacement = '\=add(s:store, submatch(0))'
    try
        call s:global_replace('window', r, replacement, 'gn')
    catch
        let error = v:exception
        return []
    endtry
    return s:unique(s:store)
endfunction
function! GlobalReplaceController()
    let range = '%'
    "xa
    let regex = s:gcw()
    if len(regex) < 5
        let regex = s:prompt('regex?')
        let replacement = s:prompt('replacement?')
    else
        let strings = s:page('<' . regex[0:3] . '\w+')
        let replacement = s:pick(strings)
        if s:exists(replacement)
            let replacement = s:prompt('replacement?')
        endif
    endif
    let flags = 'gc'
    call s:global_replace(range, regex, replacement, flags)
endfunction
let g:execRef["dtb"] = "Appdefinetempnormalmapping"



function! CommandTilda()
    " return sort(keys(g:wpsnippets.vim))
    " let a = g:wpsnippets["vim"]["ifo"]
    " return a

    try
        let v = CommandTildaItemGetter(g:CommandTildaRef)
        if Exists(v)
            redraw
            call function(v)()
        endif
    catch
        let error = v:exception
        ec error
        
    endtry
endfunction


function! CommandTildaItemGetter(ref)

    let t = "
        \\n Welcome to Command Tilda
        \\n This is an interactive action chooser
        \\n Press a single alpha-numeric key and your action will happen
        \\n\n"

    let c = 0
    let ref = a:ref
    let aa = items(ref)
    for [k,v] in aa
        let c += 1
        let t .= printf(' %s.  ["%s"]: %s' . "\n", c, k, string(v))
    endfor
    let t .= "\n   "

    call Blue(t)

    let c = 0
    let out = ''
    while c < 10
        let c += 1
        let k = s:getchar()
        if k == v:false
            continue
        elseif IsNumber(k)
            let v = aa[k- 1][1]
            return v
        elseif k== g:keyboard.bs
            let out = out[:-2]
            ec string(out)
        elseif k== 'q'
            call red('exiting via q')
            return 

        elseif k== g:keyboard.enter
            return 
        else
            let out .= k
            ec string(out)
            if has_key(ref, out)
                return ref[out]
            endif
        endif
    endwhile
endfunction


let g:visualactiondict['VShunt'] = {'fn': 'VShunt', 'i': 'code'}
let g:visualactiondict['VShunt2'] = {'fn': 'VShunt', 'i': 'code'}
let g:visualactiondict['shunt-code'] = {'fn': 'VShunt', 'i': 'code', 'arg': 'd', 'outpath': 'shunt.txt'}


function! VShunt2(state)
    call s:appendfile(s:getlinkedfile(), a:state.lines)
endfunction

function! VShunt(state)
    let state = a:state
    let t = "date: $date\nsource: $cf\ntext:\n$1\n$hr"
    let val = s:templater2(t, state.string)
    if state.arg =~ 'd'
        call DeleteBlock(state.indexes)
    endif
    call s:appendfile(state.outpath, val)
endfunction
" help i_CTRL-N
vnoremap h :<c-u>call VAction('VShunt')<CR>
vnoremap j :<c-u>call VAction('shunt-code')<CR>

function! VJavascriptConnector(state)
    " test: {'string': "abc\ndef\nghi"}
    let state = a:state
    let text = state.string
    let block = s:evaljs('lazyObjectParser.js', text)
    " let block = s:split(block, '\n')
    " ec block
    " return
    let a = s:tolines(block[0][1:-2])
    " call BlueInput('a: ' . string(a))
    " call s:replaceblock(state.indexes, a)

    "asda
        " asds dasd
        " vvv
            " asdasd asda

    "asda
        " asds dasd
        " vvv
            " asdasd asda

endfunction
let g:visualactiondict['vj'] = {'fn': 'VJavascriptConnector'}

function! s:remap(key, value)
    let key = a:key
    let value = a:value
    
endfunction

function! ActionChain()
    let s = s:encode(g:yanks)
    call append('$', '" action-chain: ' . s)
endfunction

function! SeeJumps()
    let s = s:redir(':jumps')
    return s
    let jumps = s:csv(s)
    return jumps
endfunction

function! s:interactive(o)
    let o = a:o
    let message = o.message
    items

    let t = "
        \\n Welcome to Command Tilda
        \\n This is an interactive action chooser
        \\n Press a single alpha-numeric key and your action will happen
        \\n\n"

    let c = 0
    let ref = a:ref
    let aa = items(ref)
    for [k,v] in aa
        let c += 1
        let t .= printf(' %s.  ["%s"]: %s' . "\n", c, k, string(v))
    endfor
    let t .= "\n   "

    call Blue(t)

    let c = 0
    let out = ''
    while c < 10
        let c += 1
        let k = s:getchar()
        if k == v:false
            continue
        elseif IsNumber(k)
            let v = aa[k- 1][1]
            return v
        elseif k== g:keyboard.bs
            let out = out[:-2]
            ec string(out)
        elseif k== 'q'
            call red('exiting via q')
            return 

        elseif k== g:keyboard.enter
            return 
        else
            let out .= k
            ec string(out)
            if has_key(ref, out)
                return ref[out]
            endif
        endif
    endwhile
endfunction




function! DittoCopy(upline, parts)
    "test: "javascriptBlock", ["python"]
    let upline = a:upline
    let parts = a:parts
    let target = ''
    let items = ''

    if Test(upline, parts[0])
        let items = parts[1:]
        let target = Match(upline, parts[0])
    elseif len(parts) == 1
        let m = get(g:dittoAliasMatcherRef, parts[0])
        if Exists(m)
            let target = Match(upline, m.regex)
            let items = [m.key]
        endif
    else
        let items = parts
        let target = Match(upline, '\w\w+\ze \=|\w\w+\ze[''":]')
        if !Exists(target)
            if Test(upline, parts[0])
                let items = parts[1:]
                let target = Match(upline, parts[0])
            endif
        endif
    endif

    let store = []
    let r = Test(upline, Boundary(target)) ? Boundary(target) : target
    for part in items
        let s = Sub(upline, r, {x-> CopyCapitalization(part, x[0])})
        call add(store, s)
    endfor
    return store
endfunction


let g:visualactiondict['mv'] = {'fn': 'VMove'}
let g:gfgfdict['va'] = ['/home/kdog3682/.vimrc', 'VAction', 0]
let g:execRef["sdf"] = "call append('$', '\"override: ' . GetBindingName(SingleQuote(input(\'a\'))))"

function! s:getsmartindent(...)
    let i = a:0 >= 1 ? a:1 : line('.')
    let s = getline(i)
    let r = s:jspy('blockenterre')
    if s:t(s, r)
        return s:getindent(s) + 4
    endif
    return s:getindent(s)
endfunction
let g:execRef["td"] = "Todo"
let g:filedict["t"] = "/home/kdog3682/2024/tickets.txt"

function! s:fold(...)
    execute join(s:flat(a:000), ',') . 'fold'
endfunction




function! s:setblock(x, ...)
    "test: hi\nbye
    let index = a:0 >= 1 && s:exists(a:1) ? s:ig(a:1) : line('.')
    let indent = a:0 >= 2 && s:exists(a:2) ? a:2 : s:getindent(index)
    let nomove = a:0 >= 3 && s:exists(a:3) ? 1 : 0
    let items = s:smartindent(a:x, indent)
    if g:debug
        ec 'debugging'
        ec join(items, "\n")
        return 
    endif

    call setline(index, items[0])
    if len(items) > 1
        call append(index, items[1:])
    endif
    if nomove
        return 
    endif

    call s:movement(index, items)

endfunction

function! DittoCopy(upline, parts)
    "test: "javascriptBlock", ["python"]
    let upline = a:upline
    let parts = a:parts
    let target = ''
    let items = ''

    if Test(upline, parts[0])
        let items = parts[1:]
        let target = Match(upline, parts[0])
    elseif len(parts) == 1
        let m = get(g:dittoAliasMatcherRef, parts[0])
        if Exists(m)
            let target = Match(upline, m.regex)
            let items = [m.key]
        endif
    else
        let items = parts
        let target = Match(upline, '\w\w+\ze \=|\w\w+\ze[''":]')
        if !Exists(target)
            if Test(upline, parts[0])
                let items = parts[1:]
                let target = Match(upline, parts[0])
            endif
        endif
    endif

    let store = []
    let r = Test(upline, Boundary(target)) ? Boundary(target) : target
    for part in items
        let s = Sub(upline, r, {x-> CopyCapitalization(part, x[0])})
        call add(store, s)
    endfor
    return store
endfunction


function! s:singlequote(s)
    let s = a:s
    return '\'' . a:s . '\''
endfunction
let g:visualactiondict['mv'] = {'fn': 'VMove'}
let g:gfgfdict['va'] = ['/home/kdog3682/.vimrc', 'VAction', 0]
let g:execRef["sdf"] = "call append('$', '\"override: ' . GetBindingName(SingleQuote(input(\'a\'))))"
inoremap <buffer> 4 $
inoremap <buffer> $ 4
let g:jspyref3['vim']['blockPairs'] =  { '[ *$': '\]', '\{ *$': '\}', '^ *for': 'endfor', '^ *(if|elseif)>': '(else|end)if', '^ *try': 'endtry'}
function! s:delete_empty_lines(i)
    let i = a:i

    let c = 0
    while c < 10
        let c += 1
        let t = getline(i)
        if s:empty(t)
            call deletebufline('%', i)
            continue
        endif
        return
    endwhile
endfunction

function! s:empty(s)
    if IsArray(a:s)
        return len(a:s)  ==  0
    elseif IsObject(a:s)
        return len(a:s)  ==  0
    elseif IsString(a:s)
        return strlen(trim(a:s)) == 0
    elseif IsNumber(a:s)
        return a:s > 0
    endif
endfunction
nnoremap 0 :call FoldController()<CR>

function! FoldController()
    let indexes = s:gi('code')
    call s:fold(indexes)
endfunction


function! NewMark()
    if (!exists('b:last_mark'))
        let list = getmarklist(bufname())
        call filter(list, {idx, val -> val['mark'] =~ '[a-z]'})
        if (len(list) == 0)
            let b:last_mark = 'z'
        else
            let b:last_mark = strpart(list[-1].mark, 1)
        endif
    endif
    if (b:last_mark == 'z')
        let b:last_mark = 'a'
    else
        let b:last_mark = nr2char(char2nr(b:last_mark) + 1)
    endif
    execute "mark" b:last_mark
    echo "Mark set:" b:last_mark
endfunction


let @a = "YOUR_MACRO_CONTENTS\<LEFT>"
 

function! AppBookmark()
    let jumps = []
endfunction
function! OpenBuffer(...)
    let buffer = a:0 >= 1 ? a:1 : '/home/kdog3682/.vimrc'
    let line = a:0 >= 2 ? a:2 : 0
    let ch = a:0 >= 3 ? a:3 : 0
    " gl call o
    " grab ob
    call cursor(line, ch)
endfunction
function! CleanupIab()
    let key = 'verbose iabbrev'
    let t = s:redir(key)
    " return t
    call s:appendfile('iab.txt', t)
    return 
endfunction
function! CleanupMarks()
    let r = '^ ([A-Z]) +(\d+) +(\d+) +(.+)'
    let t = s:matchfilter(s:redir('marks'), r)
    for item in t
        if s:confirm(item)
            let a = item[0]
            execute ':delmarks ' . a
            ec 'deleting mark: ' . a
        endif
    endfor
    return t
endfunction
function! CleanupMappings(key, ...)
    " test: "zrw"
    
    let key = a:key
    let maptype = a:0 >= 1 ? a:1 : 'map'
    let key = 'verbose map ' . a:key
    let key = printf('verbose %s %s', maptype, key)
    let t = s:redir(key)
    let r = 'last set from (.{-}) line (\d+)'
    let items = s:matchfilter(t, r)
    let items = s:group(items, {x -> x[0]})
    for [file, lines] in items
    	let bufnr = BufLoad(file)
        for line in lines
            let t = getbufline(bufnr, line)
            if s:confirm(t)
                call setbufline(bufnr, line, s:comment(t))
                call s:unmap(t)
                ec 'unmapped: ' . t
            endif
        endfor
    endfor
    wa
endfunction

function! PlaceSnippet(s, ...)
    return s:setblock(s:unescapespace(a:s))
endfunction

function! DittoInsert()
    let state = s:getlinestate()
    let args = split(state.line)

    function! s:innerdittoinsert(s, target, args)
        let s = a:s
        let target = a:target
        let args = a:args
        let store = map(args, 'DittoReplace(s, target, v:val)')
        return store
    endfunction

    let target = ''
    if s:test(state.prev, args[0])
        let target = remove(args, 0)
        if s:t(target, ',')
            let target = Boundary(Replace(target, ',', ''))
        elseif len(target) < 3
            let target = Boundary(target)
        endif
    else
        let target = s:match(state.prev, '\w{3,}\ze +\=|[a-z0-9-_]{3,}\ze[''":]')
        if empty(target)
            let target = s:match(state.prev, '\w{1,}\ze +\=|[a-z0-9-_]{1,}\ze[''":]')
        endif
        if empty(target)
            let target = s:match(state.prev, '\((\w+)\)')
        endif
        if empty(target)
            let target =  s:prompt('needs a target')
        endif
    endif

    let items = s:innerdittoinsert(state.prev, target, args)
    return s:setblock(items, line('.'), s:getspaces(line('.') - 1))
endfunction

function! s:getverbosemapping(map, buffer, key)
    let map = a:map
    let buffer = a:buffer
    let key = a:key
    aliases nmap nnoremap nmap
    aliases nmap nnoremap nmap
    let  aliases = {
    	\'n': 'nmap',
    	\'nnoremap': 'nmap',
    \}
    let mapping = get(aliases, map, map)
    let t = trim(s:redir(printf('verbose %s %s', mapping, key))
    let mapping = s:exists(buffer) ? map . ' <buffer>' : map
    return t
endfunction
function! GetPrevMapping(key)
    "test: f
    let t = s:getverbosemapping('nnoremap', 1, a:key)
    if t == 'No mapping found'
        return ''
    endif
    return t
    
endfunction
function! SetTemporaryMapping(key, value, ...)
    let key = a:key
    let value = a:value
    s:declare('g:temporaryMappings', {})
    if has_key(g:temporaryMappings, key)
        execute remove(g:temporaryMappings, key)
    else
        let prev = GetPrevMapping(key)
        let g:temporaryMappings[key] = prev
        execute printf('%s <buffer> %s %s', prefix, key, value)
    endif
endfunction
function! SetTemporarySaveAndDelete()
    call SetTemporaryMapping('f', ":call SaveAndDeleteLine('tickets.txt')")
endfunction

function! SaveAndDeleteLine(file)
    let file = a:file
    call s:appendfile(file, s:deleteline())
endfunction
function! s:deleteline(...)
    let i = a:0 >= 1 ? a:1 : line('.')
    let s = getline(i)
    call deletebufline('%', i)
    return s
endfunction
let g:execRef["stad"] = "SetTemporarySaveAndDelete"

function RemapNormalCommandToExecHandlerOrSomethingElse(...)
    let [key, arg] = a:0 >= 1 ? SplitOnce(a:1) : [GetFunctionFromAnywhere(), '']

    let key = get(g:execRef, key, key)

    if s:llvf(key)
        let binding = 1
        let t = "nnoremap <buffer> %s :call %s(%s)<CR>"
        let arg = ToStringArgument(arg)
        let s = printf(t, binding, key, arg)
        ec s
        execute s
    endif
endfunction

function! s:isodd(x)
    let x = a:x
    if IsNumber(x)
        return x % 2 == 1
    endif
    return len(x) % 2 == 1
endfunction

function! s:iseven(x)
    let x = a:x
    if IsNumber(x)
        return x % 2 == 0
    endif
    return len(x) % 2 == 0
endfunction

function! CommandSearchThree()
    execute RegExpr('[A-Z]+\(')
    " if it has A-Z, caps should <buffer> <expr> on.
endfunction

let g:execRef["z"] = "CommandSearchThree"
let g:execRef["z"] = "CleanupIab"

function! GoFile2toooooooodooooooooooooooooo() abort
    let runners = [
        \ {'key': 'function':, 'r': 'bookmarkId: (\w+)-\d'},
        \ ['GetFileFromLine2', 'OpenBuffer4'],
        \ ['GetDirFromLine2', 'OpenDirectory3'],
        \ ['GetUrlFromLine2', 'OpenBrowser'],
        \ ['GetBookmarkFromLine2', 'ExecuteRegex'],
        \ ['GetFunctionFromLine2', 'OpenFunction'],
    \]

    let s = getline('.')
    for [fnKey, handler] in runners
        try
            let v = function(fnKey)(s)
            if empty(v)
                continue
            endif
            try
                return function(handler)(v)
            catch
                let error = v:exception
                ec 'FATAL: ' . error
                return 
            endtry
        catch
            let error = v:exception
            " ec [error, fnKey]
            continue
        endtry
    endfor
    ec 'no matches'
endfunction
function! s:cap(s)
    let s = a:s
    return Capitalize(s)
endfunction
let g:bookmarks = []
function! s:n2char(x)
    let x = a:x
    return N2char(x)
endfunction
function! s:datestamp()
    return DateStamp()
endfunction

function! GetNextMark()
    let lines = s:tolines(s:redir('marks ABCDEFGHIJKLMNOPQRSTUVWXYZ'))
    let mark = s:cap(s:n2char(len(lines) - 1))
    return mark
endfunction
function! BookmarkSetter(...)
    let mark = GetNextMark()
    execute "normal! m" . mark
    let note = a:0 >= 1 ? a:1 : ''
    let json = {'mark': mark, 'note': note}
    call CreateBookmark(json)
endfunction

function! SwapQuotes(s)
    " test: "ab\"c''"
    let t = a:s
    let t = s:sub(t, '"', '\\1')
    let t = s:sub(t, '''', '"')
    let t = s:sub(t, '\\1', '''')
    return t
endfunction
function! VApplyEvalEffect(state)
    let state = a:state
    let t = state.arg
    let t = join(map(split(t), 's:cap(v:val)'), '')
    call s:gsr(F, t)
endfunction
let g:visualactiondict['e'] = {'fn': 'VApplyEvalEffect'}
function! DefineDictionaryController()
    let template = s:choose(g:defineDictionaryTemplates)
    if template == 'equaldict'
        let key = s:prompt('key?')
        let s = getline('.')
        let [replaceWith, value] = s:match(s, '(\w+) *\= *(.+)')
        let val = {'replaceWith': replaceWith, 'value': value}
        call DictSetter('g:jspyref3', &filetype, 'equalDict', key, val)
        return 
    endif
    call AppendAndExecute(s:templater2(template))

endfunction
let g:CommandTildaRef['bc'] = 'BookmarkSetter'
let g:CommandTildaRef['CleanupMarks'] = 'CleanupMarks'

function! GetJSPYValue()
    let value = s:jspy(s:gcw())
    ec value
endfunction
function! WPGrabLineFromFile(file, r)
    let file = a:file
    let r = a:r
    let file = FileGetter2(file)
    let lines = readfile(file)
    let matches = filter(lines, {i,x-> s:t(x, r)})
    let value = s:choose(matches)
    return value
endfunction

let g:CommandTildaRef['sffw'] = 'SearchFileForWord'
let g:CommandTildaRef['gjspyv'] = 'GetJSPYValue'


function! Sdofksdo()
    return 
endfunction
let g:jspyref3["javascript"]["objectBlockTemplate"] = "%s(%s) {\<CR>},\<C-O>O"
let g:vimCurrentTestFunction = "Sdofksdo"

function! GetCodeIndexes3() 
    let s = getline('.')
    let i = line('.')

    let tilda = s:match(s, '\w+ *\= *(`|''''''|""")')
    if s:exists(tilda)
        let b = s:fli(tilda, i + 1, 1, 500, 0)
        return [i,b]
    endif
    if s:t(s, '^(let|const).{-}[^\{\[] *$')
        return s:gi('line')
    endif
        
    if &filetype == 'python'
        let a = s:fli('^(def|class)', i, -1, 100, 0)
        let b = s:fli('^\S', i, 1, 200, 0)
        let s = getline(b)
        let r =  '^[\]\}]'
        if s:test(s, r)
            return [a,b]
        endif
        let c = s:fli('\S', b - 1, -1, 0)
        return [a, c]
    endif

    let a = s:fli('^(function!?\*?|class|const)>', i, -1, 100, 0)
    let r = '^(endfunction|\\?\}\)?|\])'
    let b = s:fli(r, i, 1, 300, 0)
    return [a,b]
endfunction
let g:vimCurrentTestFunction = "GetCodeIndexes3"
" let g:wpsnippets['js']['if']
let g:filedict["jg"] = "/home/kdog3682/2023/node_modules/@lezer/javascript/src/javascript.grammar"


" VMove

function! VMove(state)
    let state = a:state
    let arg = state.arg
    let i = -1
    let start = line('.')
    let lines = s:getlines(state.indexes, 'd')

    if IsNumber(arg)
        let i = s:movetonearestnumber(arg)
        if i > start
            let i -= len(lines)
        endif
    else
        try
            let c = s:ig('w$') - line('.')
            let i = s:fli('^ *' . arg, '.', 1, c, 0)
        catch
            let i = s:fli('^ *' . arg, '.', -1, line('.') - s:ig('w0'), 0) 
        endtry
    endif

    " return input(getline(i))
    let spaces = s:getsmartindent(i)
    let block = s:smartindent(lines, spaces)
    call s:delete_empty_lines(i + 1)
    call append(i, block)
endfunction

function! s:in(a, b)
    " test: [3,2], 3
    let a = a:a
    let b = a:b
    return index(a, b) > -1
endfunction
function! s:initialize_variable(s)
    let s = a:s
    if exists(s)
        let v = eval(s)
        if s:exists(v)
            return v
        endif
    endif
    let value = s:input('choose a value for: ' . s)
    execute printf('let %s = "%s"', s, s:encode(value))
    return value
endfunction

let g:linkedFileRef = {}
let g:linkedFileRef['lezer-common.js'] = {'file': 'lezer-main.js'}
let g:linkedFileRef['examples.js'] = {'file': 'runExampleFile.js', 'run': 'packageManager.js runExampleFile'}
let g:linkedFileRef['lezer-J2E.js'] = {'file': 'lezer-prettier.js'}
let g:linkedFileRef['gas-script.js'] = {'file': 'googleAppScript.py', 'run': 'googleAppScript.py'}
function! AddExportAndImport()
    
    let file = Tail()
    let other = g:linkedFileRef[file].file
    let name = GetBindingName()
    call AddExport(name)
    call AddImport(name, file)
endfunction
let g:execRef["aei"] = "AddExportAndImport"

function! s:getbuffers()
    let buffers = filter(range(1, bufnr('$')), 'buflisted(v:val)')
    return map(buffers, 'bufname(v:val)')
endfunction
function! BufferPicker()
    call OpenBuffer3(s:choose(s:getbuffers()))
endfunction

function! s:getlinkedfile()
    if &filetype == 'vim'
        return '/home/kdog3682/.vimrc'
    endif

    let tail = expand('%:t')
    if &filetype == 'javascript'
        if s:t(tail, 'lezer')
            return 
        endif
        return '/home/kdog3682/.vimrc'
    endif
endfunction

function! VTicket(state)
    let state = a:state
    " let message =
    " let t = "----\n$1\n----\nmessage: $2"
    " let m = s:templater(t, state.lines,
    let message = s:prompt('note:', 'todo')
    let m = state.lines + [message]
    call BookmarkSetter(s:tostring(m))
endfunction
function! BookmarkController()
    let a = s:choose(g:bookmarks)
    let mark = '''' . a.mark
    execute mark
endfunction
let g:visualactiondict['VTicket'] = {'fn': 'VTicket'}
vnoremap t :<c-u>call VAction('VTicket')<CR>
let g:CommandTildaRef['bp'] = 'BufferPicker'


function! Adsjfasdfj()
    
endfunction
call add(g:bookmarks, {"id":"1697492108-.vimrc-BookmarkSetter","note":"    let json = {'mark': mark, 'id': id, 'note': note}\n    let t = printf(t, s:encode(json))\n    call AppendAndExecute(t)\n    return \ndfg","mark":"A"})
let g:execRef["gli"] = "GetLibraryItem"

function! GliPreview(...)
    let arg = a:0 >= 1 && s:exists(a:1) ? a:1 : 0
    if s:exists(arg)
        let text = GetLibraryItem(arg)
        ec text
        let @" = text
    else
        let items = LoadLibraryItems()
        let word = s:gcw()
        let item = s:find(items, {x -> x.name == word})
        if s:exists(item)
            ec item.text
            let @" = item.text
        else
            ec 'no match for: ' . word
        endif
    endif
endfunction

function! Aliac(k)
    " test: "gli"
    call s:appendblock(GetLibraryItem(a:k), '$')
endfunction
function! GetLibraryItem(key)
    let r = CreateRE(a:key)
    let items = LoadLibraryItems()
    " let items = [{'name': 'asda', 'text': 'aa'}]
    let items = filter(copy(items), 's:t(v:val["name"], r)')
    let item = ''
    if len(items) > 1 && len(uniq(map(copy(items), 'tolower(v:val.name)'))) == 1
        let item = items[-1]
    else
        let item = s:choose(items, 'name')
    endif
    if empty(item)
        return 
    endif
    let value = item['text']
    return value
endfunction

call add(g:bookmarks, {"id":"1697494750-getConfig.js-transformers","note":"editing the args for ref.js","mark":"B"})

function! s:chooseindex(items)
    let items = a:items
    if empty(items)
        return 
    elseif len(items) == 0
        return -1
    elseif len(items) == 1
        return 0
    else
        let n = GetExponentOf10(len(items))
        call BlueList(items)
        return InputChars(n) - 1
    endif
endfunction
let g:CommandTildaRef['grc'] = 'GlobalReplaceController'
let g:execRef["grc"] = "GlobalReplaceController"

let g:wpsnippets["js"]["c"] = "class Appscript {\n    constructor($1) {\n        $c\n    }\n}"
let g:wpsnippets["js"]["c"] = "class $1 {\n    constructor($2) {\n        $c\n    }\n}"



let g:wpsnippets["js"]["if"] = "if ($1) {"
let g:wpsnippets["js"]["if"] = "if ($1) {\n    $c\n}"
" let g:wpsnippets["vim"]["ifem"] = "if empty($0)\n    $c\nendif"




function! HttpPostRequest(url, data)
    execute '!curl -X POST ' . a:url . ' -d ' . a:data
endfunction


let g:filedict["gac"] = "/home/kdog3682/2023/googleAppConnector.js"

function! GoogleAppScript()
    let url = "https://script.google.com/macros/s/AKfycbyz1qyX9ZzCDUdZryFZXVgBUFAQBkKFMdlUftWlQV0PkymENvClY4AGkRd61r2ZPukS/exec"
    let url = 'https://script.google.com/macros/s/AKfycbxUuqrU1jS7dK8y-7feRnWpMIfopfR1uhImy0h04rwaNsaHMu15TSPOEsPDLDCL-gRHzw/exec'
    " call s:python('googleAppConnector.js')

    let text = 'log("bb")'
    let response = HttpPostRequest(url, text)
    ec response
endfunction
let g:filedict["gap"] = "/home/kdog3682/PYTHON/googleAppScript.py"
let g:filedict["gaj"] = "/home/kdog3682/2023/gas-script.js"
function! s:node_or_python(s) 
    let [file, args] = s:sosall(a:s)
    let e = GetExtension(file)
    let dir = e == 'js' ? '/home/kdog3682/2023/' : '/home/kdog3682/PYTHON/'
    let file = dir . Tail(file)
    let shell = e == 'js' ? 'node' : 'python3'
    let cmd = '!clear;' . shell . ' ' . file . ' ' . join(s:flat(args), ' ')
    execute cmd
endfunction

function! GetYankIndexes()
  let a = getpos("'<")
  let b = getpos("'>")
  return [a[1], b[1]]
endfunction

function! CopyPasteBelowCursor()
    call s:appendblock(s:getlines('yank')))
endfunction
let g:execRef["cpb"] = "CopyPasteBelowCursor"
function! s:maptemplater(items, t)
    return map(copy(a:items), 's:templater(a:t, v:val)')
endfunction
function! s:appendblock(x, ...)
    let x = a:x
    let i = a:0 >= 1 ? s:ig(a:1) : line('.')
    let spaces = s:getindent(i)
    let lines = s:smartindent(x, spaces)
    call append(i, lines)
   call s:movement(i, lines) 
endfunction
function! s:movement(i, ...)
    let lines = a:0 >= 1 ? a:1 : ''
    if s:t(s:tostring(lines), '\$c')
        call cursor(a:i, 0)
        execute "normal! /\\v\\$c/e\<CR>\"_x\"_x\<RIGHT>" 
    else
        call cursor(a:i, 100)
    endif
    normal zz
    startinsert!
endfunction
inoreab <buffer>ld line('.')


function! VBlockToFunction(state)
    let state = a:state
    let t = "const $1 = (x) => {\n    $2\n}\n$3"

    let name = s:exists(state.arg) ? state.arg : 'runner'
    let iden = ''
    for item in reverse(copy(state.lines))
        let iden = s:getiden(item)
        if s:exists(iden)
           break 
        endif
    endfor
    let args = []
    if s:exists(iden)
        let name = 'get' . s:cap(iden)
        let callable = 'const ' . iden . ' = ' . name . '()'
        let args = [name, state.lines, callable]
    else
        let args = ['runner', state.lines, '// abc']
    endif
    let lines = s:tolines(s:templater(t, args))
    let block = s:indent(lines, s:getindent())
    call s:replaceblock(state.indexes, block)
endfunction
let g:visualactiondict['btf'] = {'fn': 'VBlockToFunction'}

function! VTemplateWrap(state)
    let state = a:state
    
endfunction
let g:visualactiondict['w'] = {'fn': 'VTemplateWrap'}

function! s:setpaste(s)
    let @" = s:encode(a:s)
endfunction
function! DeleteBelowCursor()
    call s:setpaste(s:getlines('belowCursor', 'd'))
endfunction

function! BelowCursorIndexes()
    return [line('.'), line('$')]
endfunction

function! AboveCursorIndexes()
    return [1, line('.') - 1]
endfunction

inoremap <expr> qw BaseBlockEnterExpr()
inoremap <expr> qe BaseBlockExitExpr()

function! GetMappings()
    let state = s:bigask("
        \\n maptype: nnoremap | inoremap | iabbrev
        \\n key: (default is all mappings)
    \\n")

    let key = printf('verbose %s %s', state.maptype, state.key)
    let t = s:redir(key)
    let r = 'last set from (.{-}) line (\d+)'
    let base = s:matchfilter(t, r)
    if empty(base)
        ec 'no mappings for: ' . key
        return 
    endif
    let base = s:group(base, {x -> x[0]}, {x -> x[1]})
    return base
endfunction

function! GotoMapCommand()
    let base = GetMappings()
    for [k,v] in items(base)
        for item in v
            return s:open(k, item)
        endfor
    endfor
endfunction
function! s:open(file, ...)
    let file = a:file
    let x = a:0 >= 1 ? a:1 : ''
    call OpenBuffer3(file)
    if empty(x)
        return
    elseif IsNumber(x) && len(x) < 10
        call Jump(x)
    else
        call ExecuteRegex(x)
    endif
endfunction
function! UnmapController()
    let base = GetMappings()
    for [file, lines] in items(base) 
    	let bufnr = BufLoad(file)
        for line in lines
            let t = s:getbufline(bufnr, line)
            if s:unmap(t)
                call setbufline(bufnr, line, s:comment(t))
                ec 'unmapped: ' . t
            endif
        endfor
    endfor
    wa
endfunction
let g:execRef["umc"] = "UnmapController"
function! s:bigask(s)
    " test: "abc: a | b  | c"
    let s = a:s
    let lines = s:tolines(s)
    let s:state = {}
    function! s:innerbigask(s)
        let s = a:s
        let [a,b] = s:so(s, ':')
        let items = s:split(b, '\|')

        call s:print('choose a value for', a)
        if len(items) <= 1
            let value = input('')
            let s:state[trim(a)] = value
            return 
        endif
        let key = s:choose(items)
        if empty(key)
            let key = items[0]
        endif
        let s:state[trim(a)] = key
    endfunction

    for item in lines
        call s:innerbigask(item)
    endfor
    return s:state
    
endfunction
let g:wpsnippets2["vimrc"]["map"] = "function! s:inner(s)\n    let s = a:s\n    $c\nendfunction\ncall map($1, 's:inner(v:val)')"
function! s:split(s, r)
    let s = a:s
    let r = a:r
    let items = split(s, '\v' . r)
    return map(items, 'trim(v:val)')
endfunction


function! WPGrabDown(arg)
    " test: "let"
    let arg = a:arg
    let [arg, d] = MConfig(arg, '^d ')
    let indexes = [line('.') + 1, max([line('$'), line('w$') + 5])]
    let index = s:findlineindex(indexes, '^ *' . arg)
    if s:exists(index)
        return trim(s:deleteline(index))
    endif
endfunction

function! WPGrabUp(arg)
    " test: "let"
    let arg = a:arg
    let i = [line('w0'), line('.') - 1]
    let lines = reverse(s:getlines(i))
    let m = s:find(lines, '^ *' . arg)
    return trim(m)
endfunction

function! s:touch(i, spaces, ...)
    let i = a:i
    let offset = a:0 >= 1 ? a:1 : 0
    let spaces = ToSpaces(a:spaces)
    let s = getline(i)
    if empty(trim(s))
        call setline(i, spaces)
        call cursor(i, 100)
    else
        call append(i + offset, spaces)
        call cursor(i + offset + 1, 100)
    endif
    startinsert!
endfunction

function! NormalQU1()
    let s = s:getlinestate(1)
    if s.isemptyline
        let [i, pos] = s:fli2(s.enter, s.exit, '.', -1, 20, 0)
        call s:touch(i - 1, s:getindent(i) + 4)
    elseif s:t(s.text, s.exit)

    elseif s:t(s.text, s.exit)
        call s:touch(s.index - 1, s:getindent(s.index) + 4)
    else
        let i = s:fli(s.exit, '.', -1, 20, 0)
        call s:touch(i - 1, s:getindent(i) + 4)
    endif
endfunction

" inoremap <silent> <buffer> qu <ESC>:call NormalQU()<CR>
" nnoremap <silent> <buffer> qu :call NormalQU()<CR>

inoremap <silent> <buffer> qw <ESC>:call NormalQW()<CR>
nnoremap <silent> <buffer> qw :call NormalQW()<CR>

inoremap <silent> <buffer> qe <ESC>:call NormalQE()<CR>
nnoremap <silent> <buffer> qe :call NormalQE()<CR>
let g:jspyref3['vim']['blockexitre'] = '^ *(\\\]|\\\},?|end\w+|else) *$'

function! NormalQE()
    let s = s:getlinestate(1)
    if s:t(s.text, s.exit)
        call s:touch(s.index + 1, s:getindent(s.index))
    else
        let i = s:fli(s.exit, '.', 1, 20, 0)
        call s:touch(i + 1, s:getindent(i), -1)
    endif
endfunction
function! NormalQU()
    let s = s:getlinestate(1)
    if s:t(s.text, s.exit)
        call s:touch(s.index - 1, s:getindent(s.index) + 4)
    " elseif s:t(s.text, s.enter)
        " call s:touch(s.index + 1, s:getindent(s.index) + 4)
    else
        let [exit, enter] = s:fli2(s.exit, s.exit, '.', -1, 20, 0)
        if s:exists(enter)
            let i = enter
            call s:touch(i + 1, s:getindent(i) + 4, -1)
        elseif s:exists(exit)
            let i = exit
            call s:touch(i - 1, s:getindent(i) + 4)
            
        else
            call s:throw('no match')
            
        endif
        
    endif
    
endfunction


function! NormalQW()
    let s = s:getlinestate(1)
    if s:t(s.text, s.enter)
        call s:touch(s.index + 1, s:getindent(s.index) + 4, -1)
    else
        let [exit, enter] = s:fli2(s.exit, s.exit, '.', -1, 20, 0)
        if s:exists(enter)
            let i = enter
            call s:touch(i + 1, s:getindent(i) + 4, -1)
        endif
    endif
endfunction

function! MarkdownNormalQW()
    let s = s:getlinestate(1)
    call s:touch(s.index + 1, s:getindent(s.index) + 4, -1)
endfunction
function! MarkdownNormalQE()
    let s = s:getlinestate(1)
    call s:touch(s.index, s:getindent(s.index) - 4)
endfunction
function! SetMarkdownQW()
    let t = "nnoremap <buffer> $1 :call $2()<CR>"
    let t .= "\n"
    let t .= "inoremap <buffer> $1 <ESC>:call $2()<CR>"

    function! s:inner_unmap(s)
        let s = a:s
        call UnmapAll(s)
    endfunction
    let items = [
        \['qw', 'MarkdownNormalQW'],
        \['qe', 'MarkdownNormalQE'],
    \]

    let items = [
        \['er', 'MarkdownNormalQW'],
        \['et', 'MarkdownNormalQE'],
    \]

    for [a,b] in items
        let expr = s:templater(t, [a,b])
        ec expr
        call UnmapAll(a)
        execute expr
    endfor

    " nnoremap <buffer> qw :call MarkdownNormalQW()<CR>
    " inoremap <buffer> qw <ESC>:call MarkdownNormalQW()<CR>

    " nnoremap <buffer> qe :call MarkdownNormalQE()<CR>
    " inoremap <buffer> qe <ESC>:call MarkdownNormalQE()<CR>
endfunction

let g:yanks = []
function! WPYank(arg)
    let a = join(s:unique(g:yanks), ' ')
    let g:yanks = []
    return a
endfunction
function! Yank5()
    call add(g:yanks, expand('<cword>'))
    ec g:yanks
endfunction
nnoremap y5 :call Yank5()<CR>
let g:wpsnippets["js"]["if"] = "if ($1) {\n    $c\n}"

function! RunNodeOrPython()
    let file = CurrentFile()
    return s:node_or_python(file)
endfunction
let g:execRef["j"] = "RunNodeOrPython"

" moving and appending


function! CopyToMarkA()
    let i = getpos('''a')[1]
    let smart = s:getlines('smart')
    call BlueInput('smart: ' . string(smart))
    let lines = s:smartindent(smart, s:getsmartindent(i))
    call append(i, lines)
    call s:movement(i, lines) 
endfunction

function! MovestuffIn()
    let smart = s:get_temp_lines()
    let i = line('.')
    let lines = s:smartindent(smart, s:getsmartindent(i))
    call append(i, lines)
    call s:movement(i, lines) 
endfunction
let g:execRef["cpa"] = "CopyToMarkA"
let g:jspyref3['vim']['equalDict']['si'] = {'replaceWith': 's', 'value': "getline(i)\<CR>"}

function! s:smartdedent(s)
    let s = a:s
    let f = 's:sub(v:val, "^" . spaces, "", "")'

    if IsArray(s)
        let spaces = s:getspaces(s[0])
        return map(s, f)
    endif

    let spaces = s:getspaces(s)
    return s:joinlines(map(s:tolines(s), f))
endfunction

function! SnippetConverter(s)
    let s = a:s
    let s = s:smartdedent(s)
    let s = Sub(s, '\d+-\d+-\d+', '${DateStamp()}')
    let s = Sub(s, '\d{8,}', "${strftime('%s')}")
    if s:exists(g:yanks)
        for i in range(len(g:yanks))
            let item = g:yanks[i]
            let s = s:sub(s, item, '$' . (i + 1))
        endfor
        let g:yanks = []
    endif
    if Test(s, "\n") && !Test(s, '\$c')
        if !s:t(s, '\$1')
            let rep = GetVisualSelection()
            call BlueInput('rep: ' . string(rep))
            let replacement = a:0 >= 1 && s:exists(a:1) ? a:1 : s:gcw()
            let s = s:sub(s, replacement . '\ze\)', '$1')
        endif
        if s:t(s, "\n    \n")
            let s = s:sub(s, "\n    \n", "\n    $c\n", '')
        else
            let s .= "$c\n"
        endif
    endif
    let s = EscapeString(s)
    return s
endfunction
let g:wpsnippets["js"]["ife"] = "if (exists($1)) {\n    $c\n}"
inoreab <buffer>ix {i,x<space>-><space>}<left><C-R>=Eatchar('\s')<CR>
inoreab <buffer> <expr> sid SidExpr()
function! s:prettyprint(s)
    let s = a:s
    if s:isprimitivelist(s)
        call BlueList(s)
    else
        ec s
    endif
    
endfunction

function! s:foobar()
    return s:redir('verbose nmap <tab>')
    return t
endfunction

function! Sdfksdkfl()
    return s:redir('verbose nmap <tab>')
endfunction

function! PasteBlockProperlyIndented()
    gfl getlinest
endfunction
let g:execRef["p"] = "PasteBlockProperlyIndented"

function! WPGrabFarLine(s)
    " test: "asd"
    ec s:gi('window')
endfunction
let g:execRef["dbc"] = "DeleteBelowCursor"
let g:GI4Ref["belowCursor"] = "BelowCursorIndexes"
let g:GI4Ref["aboveCursor"] = "AboveCursorIndexes"
let g:wpsnippets2["javascript"]["ifgn1"] = "if ($1 > -1) {\n    $c\n}"
let g:vimCurrentTestFunction = "JPCreateFunctionBlockAsExpression"
let g:execRef["hfl"] = "MarkAsHighFrequencyLine"
let g:vimFunctionAliases["file"] = "CurrentFile"
function! s:setbookmark(...)
    let d = a:0 >= 1 ? a:1 : strftime('%s')
    let t = VimTemplater('$bookmarkCommentStart bookmarkId: %s $bookmarkCommentEnd', d)
    call s:appendabove(t)
endfunction
function! GetBookmarkInfo(s)
    "test: "localBookmarkId: 1697641688 "
    let s = a:s
    let m = s:match(s, '\d{10}')
    if s:exists(m)
        let lines = s:read(g:bookmarkfile)
        let line = s:find(lines, m)
        if s:exists(line)
            let ref = eval(line)
            let t = "Content:\n\n" . ref.content . "\n------\nNote:\n" . get(ref, 'note', '')
            ec t
        endif
    endif
endfunction
function! VNote(state)
    """ bookmarkId: 1697641688 """
    let content = s:tostring(s:smartindent(a:state.lines, 0)) 
    """ bookmarkId: 1698240862 """

    let prompt = 'Write a note for g:bookmarkfile (if you wish).'
    let message = s:exists(content)
        \ ? s:hr() . "\n" . content . "\n" . s:hr() ."\n" . prompt . "\n"
        \ : prompt
    let note = s:prompt(message)
    call CreateBookmark({'note': note, 'content': content})
endfunction
function! CreateBookmark(ref)
    let ref = s:getvimstate('file', 'binding', 'timestamp')
    call extend(ref, a:ref)
    call s:appendfile(g:bookmarkfile, s:encode(ref))
    call s:setbookmark(ref.timestamp)
endfunction
let g:visualactiondict['VNote'] = {'fn': 'VNote', 'i': 'line'}
vnoremap n :<c-u>call VAction('VNote')<CR>

let g:vimFunctionAliases['binding'] = 'GetBindingName'
let g:vimFunctionAliases['promptName'] = 'GetPromptName'
let g:vimFunctionAliases['filetype'] = 'GetFileType'
let g:vimFunctionAliases['timestamp'] = 'Timestamp'
let g:vimFunctionAliases['line'] = 'GetCurrentLine'
let g:vimFunctionAliases['upiden'] = 'GetUpIden'
let g:vimFunctionAliases['cw'] = 'GetCurrentWord'
let g:vimFunctionAliases['time'] = 'GetTime'
let g:vimFunctionAliases['hr'] = 'GetHR'
function! GetHR()
    return repeat('-', 50)
endfunction
function! GetTime()
    return strftime('%A %m-%d-%Y %H:%M%p')
    return strftime('%A %B %-m %Y,  %H:%M %p')
endfunction

function! GetUpIden()
    return s:getupbinding(2)
endfunction
function! s:getvimstate(...)
    "test: "binding"
    return s:reduce(s:flat(a:000), function('GetVimStateArg'))
endfunction

function! s:reduce(items, F)
    let store = {}
    for item in a:items
        let store[item] = a:F(item)
    endfor
    return store
endfunction
function! GetCurrentLine()
    return getline('.')
endfunction

function! Timestamp()
    return strftime('%s')
endfunction
function! s:findlineindex(indexes, r)
    let [a,b] = a:indexes
    let r = a:r
    for i in range(a, b)
        let s = getline(i)
        if s:test(s, r)
            return i
        endif
    endfor
endfunction
function! s:assign(ref, k, v)
    let ref = a:ref
    let k = a:k
    let v = a:v
    if s:exists(v)
        let ref[k] = v
    endif
    return ref
endfunction
function! s:go(file,  r)
    let file = a:file
    
endfunction
function! MaybeNewParams(name, params)
    let name = a:name
    let params = a:params
    
    let newVal = BluePrompt("
        \\n Write the params if you dont like the given params
        \\n name: %s
        \\n params: %s
    \\n\n", name, params)
    if Exists(newVal)
        let params = s:xsplit(newVal)
    endif
    return params
endfunction
let g:execRef["bmi"] = "GetBookmarkInfo"
let g:CommandTildaRef['bc'] = 'BookmarkController'
let g:execRef["sbm"] = "BookmarkSetter"
call add(g:bookmarks, {"id":"1697647474-runExampleFile.js-runExampleFile","note":"checking ref.config","mark":"C"})
let g:execRef["gbm"] = "BookmarkController"
nnoremap <leader>m :call BookmarkController()<CR>
nnoremap <leader>f :call WPFFR('')<left><left>
function! GetArgFromLine(s)
    " test: "'asd'"
    let s = a:s
    let t = s:match(s, '''(.{-})''|"(.{-})"')
    return t
endfunction
let g:normalTypeState = {'active': 0, 'lines': [], 's': '', 'dict': {}, 'transform': 'GetArgFromLine', 'letters': ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', '<space>', '<cr>']}
function! NormalType(ch)
    let ch = a:ch
    if ch == 'space' || ch == '<space>'
        let ch = ' '
    endif
    if ch == 'enter' || ch == '<cr>'
        let key = g:normalTypeState['s']
        if empty(key)
            return 
        endif

        let value = function(g:normalTypeState.transform)(getline('.'))
        let g:normalTypeState['dict'][key] = value
        let g:normalTypeState['s'] = ''
        return 
    endif
    let g:normalTypeState['s'] .= ch
    let key = g:normalTypeState['s']
    if key == 'done'
        let value = g:normalTypeState.dict
        execute '1,$d'
        call s:setpaste(value)
        let g:normalTypeState.dict = {}
        return 
    endif
    ec key
    
endfunction
function! UnmapTemporaryBufferCommands()
    let t = 'nunmap <buffer> $1'
    let t = s:joinlines(s:maptemplater(g:normalTypeState.letters, t))
    ec t
    execute t
endfunction
function! CreateFunction(s)
    let [name, params] = s:sosall(a:s)
    let s = VimCreateFunctionBase(name, params)
    call s:appendblock(s, '$')
endfunction
function! WPEval(arg)
    " test: 0
    let arg = a:arg
    if empty(arg)
        let s = s:upline()
        let m = s:match(trim(s), '(\S+) \= (.+)')
        if s:exists(m)
            let [a,b] = m
            let value = string(eval(b))
            return s:jspy('prefix') . a . ' = ' . value
        else
            return  string(eval(trim(s)))
        endif
    else
        return string(eval(trim(arg)))

    endif
    
    "automatic dict registration
endfunction
function! UnmapNormal()
    let s = s:redir('verbose nmap')
    let lines = s:tolines(s)
    let items = s:matchfilter(lines, '\C^ *n *([a-z]\w*)')
    let t = 'nunmap <buffer> $1'
    let t = s:joinlines(s:maptemplater(items, t))
    " ec t
endfunction
function! SetTemporaryBufferCommands()
    if g:normalTypeState.active
        let g:normalTypeState.active = 0
        call UnmapTemporaryBufferCommands()
        return 
    endif
    " call UnmapNormal()
    let g:normalTypeState.active = 1
    "used for normal
    "first used for normal
    let t = "nnoremap <buffer> $1 :call NormalType('$1')\<CR>"
    let items = s:maptemplater(g:normalTypeState.letters, t)
    execute s:joinlines(items)
endfunction
let g:execRef["dd"] = "DefineDictionaryController"
let g:CommandTildaRef['stbc'] = 'SetTemporaryBufferCommands'
let g:wpsnippets2["global"]["eval"] = "WPEval"
let g:execRef["cf"] = "CreateFunction"
function! s:upline()
	return getline(line('.') - 1)
endfunction
let g:execRef["temp"] = "SetTemporaryBufferCommands"


function! s:asdf()
    ec 'hi'
endfunction

function! PrependLine(pre)
    let pre = a:pre
    let [spaces, line] = GetSpacesAndLine()
    call setline('.', spaces . pre . ' ' . line)
endfunction
let g:filedict["sd"] = "/home/kdog3682/2024/shsat.dialogue"

let g:filedict["dv"] = "/home/kdog3682/.vim/ftplugin/dialogue.vim"

function! ChangeParam()
    let i = s:fli('function|\=\>', '.', -1, 10, 0)
    function! s:inner(s)
        let s = a:s
        let rep = join(s:xsplit(s:prompt('new params?')), ', ')
        return s:sub(s, '\(\zs.{-}\ze\)', rep, '')
    endfunction
    call s:getsetline('s:inner', i)
endfunction
function! Menu(s)
    call ChangeParam()
    return ''
endfunction
let g:wpsnippets2["global"]["menu"] = "Menu"
let g:CommandTildaRef['cp'] = 'ChangeParam'

function! DialogueReplace()
    function! s:inner(s)
        let s = a:s
        return 'abc'
    endfunction

    let r = '\w+'
    call s:global_replace('%', r, function('s:inner'), 'g')

    return 
    function! s:inner(s)
        let s = a:s
        let s = s:sub(s, '\w+\=\w+', function('s:fna'))
        let s = s:sub(s, '\w+\=\w+', function('s:fna'))
    endfunction
    let [a,b] = [1, line('$')]
    for i in range(a, b)
        call s:getsetline('s:inner', i)
    endfor
endfunction
function! GetFileType()
    return &filetype
endfunction
let g:execRef["gft"] = "GetFileType"
function! Sdfsd0f()
    return s:so('a')
endfunction
function! DefineLanguageSpecificExecRefItem(...)
    let s = a:0 >= 1 ? a:1 : ''
    let filetype = 'javascript'
    let [k,v] = DefineEatHelper(s)
    call DictSetter('g:jspyref3', filetype, 'execFunctions', k, v)
endfunction
function! CreateExampleJsSection(...)
    let arg = a:0 >= 1 ? a:1 : ''
    let prefix = 'j'
    if arg == 'cb'
        let prefix = 'jarg'
    endif

    let s = prefix . ' ' . arg
    let snippet = GetSnippet(s)
    if empty(snippet)
        return 
    endif
    call s:scrolltobottom()
    call s:setblock(snippet)
endfunction
function! Jarg(s)
    let s = a:s
    if s == 'cb'
        let lines = s:getlines('code')
        let r = '\n}'
        let rep = '\n    $c\n}'
        return s:sub(s:tostring(lines), r, rep, '')
    endif
    return s
endfunction
let g:execRef["erd"] = "DefineLanguageSpecificExecRefItem"
let g:execRef["erl"] = "DefineLanguageSpecificExecRefItem"
let g:jspyref3["vim"]["execFunctions"] = {}
let g:jspyref3["vim"]["execFunctions"]["gft"] = 'GetFileType'

let g:jspyref3["dialogue"] = {}
let g:jspyref3["dialogue"]["execFunctions"] = {}
let g:jspyref3["dialogue"]["execFunctions"]["dr"] = 'DialogueReplace'

function! CreateBinding(a, b)
    let a = a:a
    let b = a:b
    if empty(a)
        if GetExtension(b)
            let a = 'file'
        else
            let a = 't'
        endif
        
    endif
    return s:jspy('prefix') . a . ' = ' . s:string(b)
    
endfunction
function! s:string(s)
    return s:isstring(a:s) ? s:doublequote(a:s) : s:encode(a:s)
endfunction
function! EUCreateVar(...)
    let s:name = a:0 >= 1 ? a:1 : ''
    function! s:inner_1697710266(s)
        return CreateBinding(s:name, a:s)
    endfunction
    call s:gsl('s:inner_1697710266')
endfunction
let g:execRef["var"] = "EUCreateVar"
function! s:fngetter2(X)
    let X = a:X
    return s:isstring(X) ? function(X) : X
endfunction
function! Create_s_function_from_reg_function(...)
    let s = a:0 >= 1 ? a:1 : s:gcw()
    let s = s:sub(s, '^s:', '', '')
    let value = GetLibraryItem(s)
    let value = substitute(value, '\v\w+\ze\(', '\="s:" . tolower(submatch(0))', '')
    call s:appendblock(value, '$')
endfunction
let g:jspyref3["vim"]["execFunctions"]["csf"] = 'Create_s_function_from_reg_function'

function! s:npath(dir, file)
    let dir = a:dir
    let file = a:file
    return s:pathjoin(dir, Tail(file))
endfunction

function! s:replace(s, r, rep)
    return substitute(a:s, '\v' . a:r, a:rep, '')
endfunction

function! s:pathjoin(dir, file)
    let dir = s:replace(a:dir, '/$', '')
    let file = s:replace(a:file, '^/', '')
    return dir . '/' . file
endfunction

function! s:some(items, Fn)
    let items = a:items
    let Fn = a:Fn
    for item in items
        if Fn(item)
            return 1
        endif
    endfor
    return 0
    
endfunction
let g:ffrfile='/home/kdog3682/2024/ffr-simple.json'
function! OpenFileOpenFunction(key)
    let key = a:key
    let s:key = a:key
    let json = s:read(g:ffrfile)
    function! s:inner(s)
        let s = a:s
        return s:some(a:s.contents, {y -> y == s:key})
    endfunction
    let file = s:find(json, function('s:inner'), 1)
    call BlueInput('file: ' . string(file))
    if s:exists(file)
        call OpenBuffer3(file)
        call OpenFunction(key)
    else
        ec 'no match'
    endif
endfunction
function! Find_js_file(...)
    let key = a:0 >= 1 ? a:1 : s:gcw()
    let json = s:read(g:ffrfile)
    let r = key
    let files = filter(json, 's:some(v:val.contents, {x -> s:t(x, r)})')
    call sort(files, {x -> x.size})
    call map(files, 'v:val.name')
    let file = s:choose(files)
    if s:exists(file)
        call OpenBuffer3(file)
        call OpenFunction(key)
    else
        ec 'no match'
    endif
    " call
    "splitkate
        " endfor
        " let regex = CreateRE(s)
        " let m = filter(words, 'v:val == s || s:t(v:val, regex'))
    " endfor
    
endfunction
iunabbrev <buffer> ec


function! WPEval(s)
    let s = a:s
    return s:gval(s)
endfunction
let g:wpsnippets2["global"]["e"] = "WPEval"
function! SidExpr()
	return 's:inner_' . strftime('%s') . "\<C-R>=Eatchar('\\s')\<CR>"
endfunction
let g:execRef["fjs"] = "Find_js_file"

function! s:bookmarker(bookmarkKey, ...)
    "test: asdasd, aa
    let bookmarkKey = a:bookmarkKey
    let bookmarkValue = a:0 >= 1 ? ' ' . a:1 : ''
    let t = '$bookmarkCommentStart %s: $timestamp%s $bookmarkCommentEnd'
    return VimTemplater(t, bookmarkKey, bookmarkValue)
endfunction
function! SetLinkedBookmark()
    let a = bufnr('%')
    let b = bufnr('#')
    let a = getbufinfo(a)
    let b = getbufinfo(b)
    return [a,b]
    let buffers = SortBuffers()
    let [b, a] = buffers[-2:]

    """ linkedBookmarkId: 1697719401 functions.vim """
    let t = s:bookmarker('linkedBookmarkId', 'X')
    let ma = s:replace(t, '\CX', s:tail(b.name))
    let mb = s:replace(t, '\CX', s:tail(a.name))
    ec ma . "\n" . mb
    call s:bufappend(a.bufnr, a.lnum - 1, ma)
    call s:bufappend(b.bufnr, b.lnum - 1, mb)
    wa
endfunction

function! Usetexttofindfunction(s)
    let s = a:s
    let r = s
    let j = s:read('/home/kdog3682/2024/' . &filetype . '.json')
    let items = filter(j, 's:t(v:val.text, r)')
    let payload = join(map(items, 'v:val.text'), "\n\n")
    call s:appendblock(payload, '$')
endfunction
let g:execRef["tff"] = "Usetexttofindfunction"
function! SortBuffers()
    let buffers = getbufinfo()
    call sort(buffers, function('CompareByLastUsed'))
    return buffers
endfunction

function! s:bufload(file)
    let file = a:file
    let bufnr = file
    if !IsNumber(file)
        let bufnr = bufadd(file)
        if !bufloaded(file)
            call bufload(bufnr)
        endif
    endif
    return bufnr
endfunction
function! s:bufappend(file, line, value)
    let file = a:file
    let line = a:line
    let value = a:value

    let bufnr = s:bufload(file)
    let prev = getbufline(bufnr, line)
    let value = s:smartindent(value, s:getindent(prev))

    for i in range(len(value))
        let item = value[i]
        call appendbufline(file, line + i, item)
    endfor
endfunction
function! s:tail(...)
    if a:0 >= 1
        return split(s:replace(a:1, '/$', ''), '/')[-1]
    else
        return expand('%:t')
    endif
endfunction

function! SetLocalBookmark(s)
    let bm = s:bookmarker('localBookmarkId', s)
    call append('$', bm)
    call s:appendabove(bm)
endfunction
let g:execRef["lbm"] = "SetLocalBookmark"


function! BookmarkManager(...)
    """ localBookmarkId: 1697718919 """
    let keys = [
        \'SetLocalBookmark',
        \'SetLinkedBookmark',
    \]
    let key = s:choose(keys)
    call function(key)(a:0 >= 1 ? a:1 : '')
endfunction
let g:execRef["bm"] = "BookmarkManager"
""" localBookmarkId: 1697718919 """
let g:wpsnippets["js"]["lines"] = "const lines = s.trim().split('\\n')"
let g:wpsnippets["js"]["lg"] = "const lines = s.trim().split('\\n')"

function! JavascriptDashToCamel()
    " let r = 'function \zs\w+'
    " return s:sub(s, r, 's:inner1(submatch(0))
endfunction
let g:execRef["gli"] = "Aliac"
let g:execRef["gg"] = "Aliac"
let g:execRef["g"] = "Aliac"
let g:execRef["mvi"] = "MovestuffIn"


function! GuidedReplaceWordUnderCursor()
    let w = s:gcw()
    let replacement = s:prompt('global replacement for: "' . w . '"?')
    call s:global_replace('%', w, replacement , 'gc')
endfunction
function! s:getidenstr(...)
    "test: 'runner = aaa(asd, 123)'
    let s = a:0 >= 1 ? a:1 : getline('.')
    let mode = a:0 >= 2 && s:exists(a:2) ? 1 : 0
    let r = '\w+\ze *\= *[\[\{''"a-z0-9]'
    let m = s:match(s, r)
    if s:exists(m)
        return m
    endif
    if mode
        let r = '\(\S.{-}\)|\[\S.{-}\]|\{\S.{-}\}'
    else
        let r = '\((\S.{-})\)|\[(\S.{-})\]|\{(\S.{-})\}'
    endif
    let m = s:match(s, r)
    if s:exists(m)
        return s:smallify(m)
        return m
    endif
endfunction
function! LogIt(...)
    let s = getline('.')
    let key = a:0 >= 1 ? a:1 : 'log'
    let value = s:getidenstr(s)
    let template = s:jspy(key . 'Template')
    if s:exists(value)
        let value = s:templater(template, value)
        call append('.', s:tospaces(s:getsmartindent()) . value)
    endif
endfunction

let g:jspyref3['vim']['logTemplate'] = 'call s:red("$1", $1)'
let g:jspyref3['python']['logTemplate'] = 'red("$1", $1)'
let g:jspyref3['javascript']['logTemplate'] = 'red("$1", $1)'
let g:jspyref3['vim']['returnTemplate'] = 'return s:red("$1", $1)'
let g:jspyref3['python']['returnTemplate'] = 'return red("$1", $1)'
let g:jspyref3['javascript']['returnTemplate'] = 'return red("$1", $1)'
let g:jspyref3['vim']['throwTemplate'] = 'call s:red("$1", $1)\nthrow "stop"'
let g:jspyref3['python']['throwTemplate'] = 'return red("$1", $1)'
let g:jspyref3['javascript']['throwTemplate'] = 'console.log("$1", $1); throw "throwing";'
" jspy throwTemplate  call s:red("$1", $1)\nthrow "stop"  return red("$1", $1)  console.log("$1", $1); throw "throwing";

function! VDoc(state)
    let state = a:state
    let parent = GetBindingName()
    let actor = 
    
endfunction
let g:visualactiondict['doc'] = {'fn': 'VDoc'}
let g:execRef["grw"] = "GuidedReplaceWordUnderCursor"

function! RunOppositeBuffer()
    let file = 'examples.js'
    let opp = getbufinfo(s:bufload(file))
    return opp
endfunction

nnoremap lg <UP><CR>:call LogIt('log')<CR>
let g:wpsnippets2["javascript"]["j"] = "--------------------------------------------------------------\npure: 1\ndate: ${DateStamp()}\ndesc:\nnote:\n\narg:\n\ncode: \n\nfunction $1::main(s) {\n    $c\n}\n"
let g:wpsnippets2["vim"]["j"] = "--------------------------------------------------------------\npure: 1\ndate: ${DateStamp()}\ndesc:\nnote:\n\narg:\n\ncode: \n\nfunction $1::main(s) {\n    $c\n}\n"
let g:execRef["pre"] = "GliPreview"
let g:wpsnippets["js"]["ifem"] = "if (!$1) {\n    $c\n}"
let g:jspyref3["javascript"]["equalDict"]["ts"] = {'replaceWith': 'text', 'value': 's.trim()'}
let g:jspyref3["javascript"]["equalDict"]["ts"] = {'replaceWith': 'text', 'value': 's.trim()'}


let g:keyboard['eat']= "\<C-R>=Eatchar('\\s')\<CR>"

function! JSLambdaExpr()
    let s = getline('.')
    let a = s:match(s, '\w+\ze\.\w')
    if empty(a)
        let a = 'x'
    else
        let  ref = {
        	\'children': 'child',
        \}
        if has_key(ref, a)
            let a = ref[a]
        elseif s:test(a, 's$')
            let a = s:sub(a, 'e?s$', '')
        else
            let a = 'x'
        endif
    endif
    return printf('(%s) =>', a)
    
endfunction
function! GrabWPSnippetItem(key)
    " test: "ifel"
    let key = a:key
    let ref = g:wpsnippets2
    let [spaces, line, tail, e, tag, s] = GetStateInfo(s)
    let s = 'let g:wpsnippets2["%s"]["%s"] = "%s"'
    let template = DictGetter2(ref, tail, tag, ref, &filetype, tag, ref, 'global', tag, g:wpsnippets, e, tag)
    let out = printf(s, &filetype, key, template)
    call append('$', out)
    call s:movement('$')
endfunction
function! s:smallify(x)
    let x = a:x
    if IsArray(x)
        let value = filter(x, 's:exists(v:val)')
        if len(value) == 1
            return value[0]
        else
            return value
        endif
    endif
    return x
endfunction
let g:wpsnippets["vim"]["ifa"] = "if IsArray(x)\n    $c\nendif"
let g:wpsnippets["js"]["ifseq"] = "if (i == 0) {\n    $c\n} else if (i == $1 - 1) {\n    \n}  else {\n\n}"
let g:wpsnippets["js"]["ifee"] = "if (!$1) {\n    return \n}$c\n"


function! ToggleLineAboveAndBelow()
    let a = line('.') - 1
    let b = a + 2
    let store = []
    for i in range(a,b)
       let s = getline(i)
       let comment = s:t(s, s:jspy('commentPrefix'))
       call add(store, {'comment':comment, 'index': i, 'text': s})
    endfor
    let [a,b,c] = store
    if a.comment
        call setline(a.index, s:togglecomment(a.text))
        call setline(b.index, s:togglecomment(b.text))
    elseif c.comment
        call setline(c.index, s:togglecomment(c.text))
        call setline(b.index, s:togglecomment(b.text))
    else
        call setline(b.index, s:togglecomment(b.text))
        call setline(c.index, s:togglecomment(c.text))
    endif
    return store
endfunction

function! s:togglecomment(s)
    let s = a:s
    let m = s:jspy('commentPrefix')
    return s:t(s, '^' . m) ? s:replace(s, m . ' *', '') : m . ' ' . s
endfunction
let g:activeNodeFile = "/home/kdog3682/2023/examples.js"

function! Node3()
    if has_key(g:tempcommands, '3')
        return function(g:tempcommands['3'])()
    endif

endfunction
function! Node2()
    if has_key(g:tempcommands, '2')
        return function(g:tempcommands['2'])()
    endif
    return RunExampleFile()
    return Node(g:activeNodeFile)
    return
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
function! s:getupbinding(...)
    let c = 0
    let i = line('.')
    let max = a:0 >= 1 ? a:1 : 3
    let mode = a:0 >= 2 && s:exists(a:2) ? 1 : 0
    while c < max
        let c += 1
        let s = getline(i - c)
        if empty(s)
            continue
        endif
        let m = s:getidenstr(s, mode)
        if s:exists(m)
            return m
        else
            break
        endif
    endwhile
endfunction

let g:execRef["gwp"] = "GrabWPSnippetItem"
function! WPSwitch(s)
    let s = split(a:s)
    let o = 'switch(%s) {'
    for i in range(len(s) - 1)
        let o .= "\n    case '%s':\n        "
        if i == 0
            let o .= '$c'
        endif
    endfor
    let o .= "\n}"
    return Printf(o, s)
endfunction
let g:wpsnippets2["javascript"]["switch"] = "WPSwitch"
let g:wpsnippets2["global"]["list"] = "WPGList"
let g:wpsnippets2["global"]["aa"] = "WPGAAList"
let g:vimCurrentTestFunction = "SmartEqual"

function! Exi()
    let up = s:fli('^code:', '.', -1, 500, 0) + 1
    let down = s:fli('^-{10,}', '.', 1, 500, 0) - 1
    let s = s:tostring(s:getlines(up, down))

endfunction
let g:activeNodeFile = "/home/kdog3682/2023/markdownParser.js"

let g:jspyref3['vim']['templateExpressions'] = {}
let g:jspyref3['python']['templateExpressions'] = {}
let g:jspyref3['javascript']['templateExpressions'] = {}
let g:jspyref3['vim']['templateExpressions']['tl'] = 'aaaaaa'
let g:jspyref3['javascript']['templateExpressions']['tl'] = 'console.log($1); throw "throwing"'

function! MapController()
    let name = GetBindingName()
    let iabexpr = "inoreab <silent> <buffer> <expr> %s $binding()"
    let t = iabexpr 
    let cmd = VimTemplater(t, s:input('choose a key'))
    call AppendAndExecute(cmd)
endfunction
function! TLExpr(key, ...)
    let brackets = a:0 >= 1 ? 1 : 0
    let key = a:key
    let up = 0
    " let up = s:getupbinding(2, 1)


    let t = s:jspy('templateExpressions')[key]
    let eat = s:t(t, ' $') ? '' : g:keyboard.eat
    let t = s:replace(t, ' +$', '')
    if s:exists(up)
        let up = s:sub(up, '^\(|\)$', '')
        if brackets
            let up = s:sub(up, '^\W+|\W+$', '')
            let up = s:wrapper(up, '{}')
        endif
        return s:templater(t, up) . eat
    else
        let m = s:split(t, '\$c|\$1')
        let [a,b] = m
        let left = repeat(g:keyboard.left, len(b))
        return a . b . left . eat
    endif
endfunction


function! s:getbufline(bufnr, line)
    let bufnr = a:bufnr
    let line = a:line
	return getbufline(bufnr, line)[0]
endfunction
" ec UnmapController()

function! GetFunctionIndex(...)
    let s = getline('.')
    let i = line('.')
    if s:t(s, '^(let|var)')
        throw -1
    endif

    let distance = a:0 >= 1 && !empty(a:1) ? a:1 : 500
    let stopLine = max([0, distance == 'w0' ? line(distance) : line('.') - distance])
    let r = '\v^(var|(async )?function[!*]?|def|class|const) \zs\w+|^\w+ \= \{ *$'
    let start = search(r, 'bnW', stopLine)
    if empty(start)
        throw 'No Function Index Match @ GetFunctionIndex'
    endif
    return start
endfunction
" \d+
" ap
" (\w+) (\w+)
" (\w)(\w)(\w)
" (\w)(\w)(\w)
" (\w)(\w)(\w)
" (\w)(\w)(\w)
" (\w)(\w)(\w)
" (\w)(\w)(\w)
let g:execRef["uc"] = "UnmapController"



nnoremap gd G

let g:mapDict = {
    \'iab': 'inoreab',
    \'i': 'inoremap',
    \'c': 'cnoremap',
    \'n': 'nnoremap',
    \'v': 'vnoremap',
\}

let g:unmapDict = {
    \'iab': 'iunabbrev',
    \'iabbrev': 'iunabbrev',
    \'inoreab': 'iunabbrev',
    \'nnoremap': 'nunmap',
    \'inoremap': 'iunmap',
    \'i': 'iunmap',
    \'vnoremap': 'vunmap',
    \'cnoremap': 'cunmap',
    \'c': 'cunmap',
    \'nmap': 'nunmap',
    \'n': 'nunmap',
    \'vmap': 'vunmap',
\}
let g:wpsnippets2["global"]["gli"] = "WPGGli"

" 10-21-2023 
let g:execRef["mc"] = "MapController"
inoreab <silent> <buffer> <expr> tl TLExpr('tl', 1)

let g:wpsnippets2["javascript"]["dict"] = "WPDict"
let g:wpsnippets2["vim"]["dict"] = "WPDict"



function! Snippeteer(...)
    " let w = WordBeforeCursor()
    let s = a:0 >= 1 ? a:1 : getline('.')
    let snippet = GetSnippet(s)
    if empty(snippet)
        ec 'no snippet'
        return 
    endif
    return s:setblock(s:unescapespace(snippet))
endfunction 
function! WPGrabBlockDown(arg)
    let r = MyRegex(a:arg)
	let down = s:fli(r, '.', 1, 100, 0)
    let indexes = GICob(down)
    return s:getlines(indexes)
endfunction


let g:wpsnippets2["global"]["gbd"] = "WPGrabBlockDown"

function! WPGrabBlockdown(arg)
    let r = MyRegex(a:arg)
	let down = s:fli(r, '.', -1, 100, 0)
    let indexes = GICob(down)
    return s:getlines(indexes)
endfunction

let g:wpsnippets2["global"]["gbu"] = "WPGrabBlockdown"


function! Echolocation()

    

    return 
     let [spaces, line] = GetSpacesAndLine()

     if Test(line, '^ *return.{-}\w')
         let key = input('')
         let prefix = s:jspy('prefix')
         let s = Replace(line, 'return +', prefix . key . ' = ')
         let s2 = 'return ' . key
         call AppendBlockAtCursor([s, s2])
     endif
     let m = GetIdentifierFromLineNumberOrAbove()

     call AppendBelow2(printf(s:jspy('echoTemplate'), m, m))
endfunction

function! SearchFileForWord(...)
    " let file = "/home/kdog3682/.vim/ftplugin/variables.10-12-2023.vim"
    " let word = a:0 >= 1 ? a:1 : s:gcw()
    " let value = s:jspy(word)
    " call s:appendbelow(value)
    " let word = s:gcw()
    " to get a jspy word
endfunction

let g:wpsnippets2["global"]["glff"] = {'function': "WPGrabLineFromFile", 'args': [['gcw', 'gf'], ['$1', 'gf']], 'type': 'args'}
let g:wpsnippets["vim"]["ifo"] = "if IsObject($1)\n    $cendif"

let g:wpsnippets2["vim"]["get"] = {'type': 'template', 'template': 'let $1 = get($upden, ''$1'')'}
function! s:templater2(t, ...)
    let t = a:t
    let s:items = a:0 >= 1 ? s:coercearray(a:1) : []
    let r =  '( *)\$(\w+)'

    function! s:get(key)
        let key = a:key
        if key == 'c'
            return '$c'
        endif
        if has_key(g:vimFunctionAliases, key)
            return function(g:vimFunctionAliases[key])()
        elseif IsNumber(key)
            return s:items[key - 1]
        else
            return s:items[key]
        endif
    endfunction
    function! s:inner(s)
        let spaces = a:s[1]
        let key = a:s[2]
        let value = s:get(key)
        let v = s:tostring(s:smartindent(value, spaces))
        return v
    endfunction
    return s:sub(t, r, function('s:inner'))
endfunction
function! SnippetFromObject(o, s)
    let o = a:o
    let items = s:sds(a:s)
    let type = get(o, 'type', 'default')

    if type == "template"
        return s:templater2(o.template, items)
    elseif type == "args"
        let ref = o.args[len(items)]
        let args = []
        for i in range(len(items))
            let item = items[i]
        endfor
        return call(o.function, args)
    elseif type == "note"
        call setline('.', s:getspaces())
        s:appendfile(s:templater2(o.template, a:s))
        return

    elseif type == "normal"
        call setline('.', s:getspaces())
        call(o.function, baseArgs)
        return
    endif
endfunction

function! ExtractExpressionToAboveLine()
    let [a,b] = s:splitatcursor()
    let r =  '[\[\{\]}()]'
    let m = s:findall(b, r)
    let end = s:match(b, r . '+$')
    let endLetters = SplitSingles(end)
    let brace = 0
    let curly = 0
    let paren = 0
    for el in m
        if el == "["
            let brace += 1
        elseif el == "{"
            let curly += 1
        elseif el == "("
            let paren += 1
        elseif el == "]"
            let brace -= 1
        elseif el == "}"
            let curly -= 1
        elseif el == ")"
            let paren -= 1
        endif
    endfor
    " ec json_encode({"curly": curly, "paren": paren, "brace": brace})
    let sum = curly + paren + brace
    let expr = b[:sum - 1]
    let name = s:ImplicitNameFromExpr(expr)
    let top = CreateBinding(name, expr)
    let endValue = end[sum:]
    let value = a . name . endValue
    let out = top . "\n" . trim(value)
    call s:setblock(out)
endfunction
" ec 'abc'[0:-2]
inoreab <buffer>sn "\n"<C-R>=Eatchar('\s')<CR>

function! s:ImplicitNameFromExpr(expr)
    " test: "asdf"

    let expr = a:expr
    let ref = [
        \['len', 'length'],
    \]
    " aa ref len length
    for [a,b] in ref
        if s:test(expr, a)
            return b
        endif
    endfor
    let message = printf('choose an implicit name for: ''%s''', expr)
    return s:prompt(message, 'temp')
endfunction


function! WPGAAList(s)
    " test: ",a b c d e"
    let t2 = "['%s', '%s']"
    let t1 = "[%s, %s]" 
    let wrap = ['[', ']']
    return WPPrintTemplate(a:s, wrap, t2, t1)
endfunction

let g:wpsnippets2["global"]["ifser"] = "WPGIfSeries"

function! WPGList(s)
    " test: "a b c d"
    let t1 = '%s'
    let t2 = '''%s'''
    let wrap = ['[', ']']
    return WPPrintTemplate(a:s, wrap, t2, t1)
endfunction

function! s:count(s, r)
    "test: "%s %s", '\%s'
    let s = a:s
    let r = a:r
    return len(s:findall(s, r))
endfunction
function! WPJref(s)
    return WPPrintTemplate(a:s, '{}', '%s')
endfunction
function! WPPrintTemplate(s, wrap, template, ...)
    let [s, arg] = MConfig(a:s, '^,')
    let wrap = s:isarray(a:wrap) ? a:wrap : SplitSingles(a:wrap)
    let template = arg && a:0 >= 1 ? a:1 : a:template
    let items = s:sds(s)
    call BlueInput('i: ' . string(items))
    let k = s:count(template, '\%s')
    let n = (len(items) - 1) / k
    let t = s:jspy('prefix') . '%s = ' . wrap[0]
    let lc = s:jspy('lineContinuationMarker')
    let newline = "\n"
    for i in range(n)
        let t .= newline . '    ' . lc . template . ','
    endfor
    let t .= newline . lc . wrap[1]
    return Printf(t, items)
endfunction

let g:jspyref3['vim']['lineContinuationMarker'] = "\\"
let g:jspyref3['python']['lineContinuationMarker'] = ""
let g:jspyref3['javascript']['lineContinuationMarker'] = ""
let g:execRef["eea"] = "ExtractExpressionToAboveLine"

function! WPDict(s)
    " test: "a b c d e"
    let t2 = '''%s'': %s'
    let t1 = '''%s'': ''%s'''
    let wrap = ['{', '}']
    return WPPrintTemplate(a:s, wrap, t2, t1)
endfunction

function! WPJReturnSwitch(s)
    " test: "ab cd ef"
    let s = a:s
    let items = s:sds(s)
    " let mode = call remove(items, )
    let t = 'return %s'
    let prefix = ''
    for i in range(len(items) - 1)
        if prefix == '?'
            let prefix = ':'
        else
            let prefix = '?'
        endif
        let t .= "\n    " . prefix . ' %s'
    endfor
    return Printf(t, items)
    
endfunction

" 10-22-2023 



function! WPFFR(...)
    let key = a:0 >= 1  && s:exists(a:1) ? a:1 : s:gcw()
    let json = s:read(g:ffrfile)
    let r = MyRegex(key)
    let dots = s:t(key, '\c^[a-z]{1,3}$')
    let test = dots ? 's:t(x, r)' : 'x == key'
    let lambda = printf('s:some(v:val.contents, {x -> %s})', test)
    let files = filter(json, lambda)
    call sort(files, {x -> x.size})
    call map(files, 'v:val.name')
    let file = s:choose(files)
    if s:exists(file)
        call OpenBuffer3(file)
        if !OpenFunction(key) && dots
            call ExecuteRegex(key)
        endif
    endif
endfunction
let g:wpsnippets2["global"]["ffr"] = "WPFFR"
let g:execRef["ffr"] = "WPFFR"
let wamiTemplate = ''


let g:wpsnippets2["global"]["wami"] = {'template': "type: whereami\ntime: $time\nnote: $1", 'type': 'note'}
" wami sdf

function DictGetter3(ref, ...)
    let ref = a:ref
    let keys = a:000
    for i in range(len(keys))
        let key = keys[i]
        if !has_key(ref, key)
            return 
        endif
        let ref = ref[key]
    endfor
    return ref
endfunction

"aa
"wami
let g:execRef["gs"] = "GoogleSearch"
call add(g:bookmarks, {"id":"1697910374-.vimrc-GoFile","note":"let val = eval(m)\ntodo","mark":"D"})


let g:defineDictionaryTemplates = [
    \"let g:CommandTildaRef['$promptName'] = '$binding'",
    \'let g:wpsnippets2["global"]["$promptName"] = "$binding"',
    \'let g:wpsnippets2["javascript"]["$promptName"] = "$binding"',
    \'let g:wpsnippets2["$filetype"]["$promptName"] = "$binding"',
    \'let g:GI4Ref["$promptName"] = "$binding"',
    \'let g:vimFunctionAliases["$promptName"] = "$binding"',
    \'let g:jspyref3["$promptName"] = "$binding"',
    \'equaldict',
    \'inoremap expression function',
    \'inoremap expression function',
    \'inoremap expression function',
    \'inoreab',
\]

function! LineEditController()
    let commands = [
        \'SwapQuotes',
        \'JSObjVar',
        \'JSCreateVar',
    \]
    let cmd = s:choose(commands)
    call s:getsetline(cmd)
endfunction
let g:execRef["le"] = "LineEditController"
function! GetPromptName()
    let abrev = Abrev(GetBindingName())
    let abrev = s:prompt('choose a name for this command', abrev)
    return abrev
endfunction
let g:wpsnippets2["javascript"]["jref"] = "WPJref"
let g:execRef["ac"] = "ActionChain"

function! ShellEscapeHander(s) abort
    let dict = {
      \"\n": "newline",
     \ "'": "sq",
     \ "}": "rcb",
     \ "{": "lcb",
     \ "<": "lt",
     \ ">": "gt",
     \ "*": "star",
     \ "%": "percent",
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
     \ "^": "caret",
     \ "!": "exc",
     \ "@": "at",
     \ "&": "ampersand",
    \}
    let k = a:s[0]
    if has_key(dict, k)
        return 'zz' . dict[k]
    else
        return k
    endif

endfunction
function! Foobarsfd()
    call VJavascriptConnector({'string': "abc\ndef\nghi"})
endfunction
let g:gfgfdict['efs'] = ['/home/kdog3682/.vimrc', 'EvaluateFromShell', 0]

let g:activeNodeFile = "/home/kdog3682/2023/lazyObjectParser.js"

function! GitPushCurrentFile(message)
  " test: "it working"
  let message = a:message
  " let path = '/home/kdog3682/2023/lazyObjectParser.js'
  let path = expand('%')
  let dir = fnameescape(fnamemodify(path, ':h'))
  let dir = shellescape(dir)
  let path = shellescape(path)
  let message = shellescape(message)
  let cmd = printf("
        \\n cd %s
        \\n git add %s
        \\n git commit -m %s
        \\n git push
  \", dir, path, message)

  " let cmd = printf("
        " \\n cd %s
        " \\n pwd
        " \\n echo %s
        " \\n echo %s
        " \\n echo finished
  " \", dir, path, message)

  let cmd = s:joinlines(s:split(cmd, '\n *'))
  call s:red("git command:\n--------------------------------------\n%s\n--------------------------------------", cmd)
  call input('press anything to continue to git push')

  let result = systemlist(cmd)
  let result = s:encode(result)
  call s:blue(result)
  call s:appendbelow('" ' . result)
  " ["fatal: not a git repository (or any of the parent directories): .git","fatal: not a git repository (or any of the parent directories): .git","fatal: not a git repository (or any of the parent directories): .git"]
  " ["[main 637831b] it working"," 1 file changed, 78 insertions(+), 5 deletions(-)","To github.com:kdog3682/2023.git","   0aa92cb..637831b  main -> main"]
endfunction
let g:execRef["gpf"] = "GitPushCurrentFile"

let g:execRef["gmc"] = "GotoMapCommand"
function! SetActiveBash()
    let g:bashfile = '/home/kdog3682/.bash_aliases'
    let s = printf('alias san="vim %s"', g:activeNodeFile)
    call AppendFile(g:bashfile, s)
endfunction
let g:execRef["sab"] = "SetActiveBash"

" VShuntController VJavascriptConnector ActionChain remap

function! VShuntController()
    let lang = &filetype
    let key = 'shunt-code'
    if lang == 'text'
        let key = 'shunt-text-to-examples'
        let lines = s:getlines('smart')
        call OpenBuffer3('examples.js')
        normal G
        let t = "pure: 1\ndate: $date\nnotes:\narg:\n$1\n\ncode:\n\nfunction main(s) {\n    $c\n}"
        let val = s:templater2(t, s:joinlines(lines))
        call s:appendblock(val, '$')
        return 
    endif
    call VAction(key)
endfunction
let g:activeNodeFile = "/home/kdog3682/2023/markdownParser.js"
let g:filedict["sc"] = "/home/kdog3682/2023/StateContext.js"


function! Marks()
    
endfunction
call add(g:bookmarks, {"id":"1698093040-examples.js-main","note":"","mark":"E"})
call add(g:bookmarks, {"id":"1698093079-getConfig.js-transformers","note":"","mark":"F"})
let g:filedict["mdp"] = "/home/kdog3682/2023/markdownParser.js"
let g:wpsnippets2["javascript"]["rets"] = "WPJReturnSwitch"
function! RunExampleFile()
	
    let buf = getbufinfo(s:bufload('examples.js'))
    let args = ['runExampleFile', 'examples.js', buf[0].lnum]
    return Node('packageManager.js', args)
endfunction

function! SimpleJavascriptTest(...)
    let s = a:0 >= 1 ? a:1 : ''
    let w = GetFunctionFromLine2()
    let line = StringCallWithQuotes(w, s:xsplit(s))
    ec 'input line: ' . line
    let block = s:evaljs('vimConnector.js', 'evaluate', line)
    ec block
    
endfunction
let g:execRef["sjt"] = "SimpleJavascriptTest"

function! StringCallWithQuotes(name, ...)
    let name = a:name
    let args = map(s:flat(a:000), 'ToStringArgument(v:val)')
    function! Inner(s)
        let s = a:s
        if &filetype != 'vim' || !In(g:VimNativeFunctions, s)
            return s
        else
            return Capitalize(s)
        endif
    endfunction
    let t = 'Exists(v:val)'
    return Inner(a:name) . '(' . join(filter(args, t), ', ') . ')'
endfunction
let g:execRef["t.smq"] = "SetMarkdownQW"

function! RenameFileFromLine(s)
    " test: "asdf"
    let replacement = a:s
    "/asd/foo.asd.js"
    let file = GetFileFromLine2(getline('.'))
    let [head,tail,e] = HeadAndTail(file)
    let out = head . replacement . '.' . e
    let answer = BluePrompt("
        \\n copying %s to %s
    \\n\n", file, out)
    call system(printf('cp %s %s', file, out))
endfunction

let g:execRef["rename"] = "RenameFileFromLine"
let g:wpsnippets["js"]["ifel"] = "if ($1) {\n    $c\n} else {"
let g:wpsnippets["js"]["ifel"] = "if ($1) {\n    $c\n} else {\n}"
let g:filedict["vue"] = "/home/kdog3682/2023/vuetify.js"
let g:filedict["hp"] = "/home/kdog3682/2023/htmlParser.js"
let g:filedict["xs2"] = "/home/kdog3682/2023/xmlString2.js"
function! SelectBuffers()
    let store = []
    for buffer in GetVisibleBuffers()
        let name = expand(bufname(buffer))
        if s:confirm(name)
            call add(store, name)
        else
            call CloseBuffer(buffer)
            ec 'closing'
        endif
    endfor
    let name = 'g:buffers' . tolower(GetMonthYear())
    call append('$', s:createvar(name, store))
endfunction
nnoremap 0 :call ToggleBuffers()<CR>
function! s:createvar(s, value)
    let s = a:s
    return 'let ' . s . ' = ' . s:encode(a:value)
endfunction
function! ToggleBuffers()
    let buffers = g:buffersoctober2023
    let next = ModularIncrement2(buffers, CurrentFile())
    call OpenBuffer3(next)
endfunction
let g:buffersoctober2023 = ["/home/kdog3682/2023/examples.js","/home/kdog3682/2023/vuetify.js"]
let g:wpsnippets['vim']['jspy'] = "let g:jspyref3[\"vim\"][\"$1\"] = \"$2\"\nlet g:jspyref3[\"python\"][\"$1\"] = \"$3\"\nlet g:jspyref3[\"javascript\"][\"$1\"] = \"$4\""

nnoremap di :call DeleteInnerBlock()<CR>
let g:templines = []
function! DeleteInnerBlock()
    let g:templines = s:getlines('smart', 'd')
endfunction
function! s:get_temp_lines()
    if s:exists(g:templines)
        let lines = copy(g:templines)
        let g:templines = []
        return lines
    else
        return s:tolines(@")
    endif
endfunction
let g:wpsnippets["js"]["ifk"] = "if (key == '$1') {\n    key = '$2'\n}$n"
function! JSObjVar(s)
    " test: "sdf"
    let s = a:s
    let a = join(s:xsplit(s:prompt('vars: ')), ', ')
    return printf('const {%s} = %s', a, s)
endfunction

let g:jspyref3["vim"]["echoWordTemplate"] = ""
let g:jspyref3["python"]["echoWordTemplate"] = ""
let g:jspyref3["javascript"]["echoWordTemplate"] = "display('$cw', $cw, 0)"

nnoremap ew :call EchoTemplate('ew')<CR>
let g:wpsnippets["js"]["data"] = "@data {\n    $c\n}"
let g:filedict["lop"] = "/home/kdog3682/2023/lazyObjectParser.js"

function FileNote(s)
    let date = DateStamp()
    let s = printf('%s FileNote %s: %s', date, Tail(), a:s)
    call AppendCurrent(s)
endfunction

let g:execRef["n"] = "CheckNormalVerbose"
nnoremap 3 #

let g:tempunmappings = []
function! UnmapAll(s, ...)
    if !exists('b:tempunmappings')
        let b:tempunmappings = []
    endif
    " test: "2"
    let key = a:0 >= 1 ? a:1 : ''
    let a = s:tolines(s:redir(key . 'map ' . a:s))
    function! s:inner(s)
        let s = a:s
        let r = '^ *(\w+) +(\S+) +\*(\@?)(.+)'
        let m = s:match(s, r)
        let [mode, key, buffer, val] = m
        let buffer = s:exists(buffer) ? ' <buffer> ' : ' '
        let mapexpr = g:mapDict[mode] . buffer . key . ' ' . val
        if s:exists(buffer)
            call add(b:tempunmappings, mapexpr)
        endif
        let expr = g:unmapDict[mode] . buffer . key 
        execute expr
    endfunction
    call map(a, 's:inner(v:val)')
endfunction

let g:execRef["smq"] = "SetMarkdownQW"
let g:wpsnippets["js"]["css"] = "@css {\n    $c\n}"


inoremap ` <esc>:wa<CR>:call Node2()<cr>
function! Speechtexter()
    call BrowserController('s')
endfunction
let g:wpsnippets["js"]["sty"] = "style() {\n    $c\n}"
let g:execRef["s"] = "Speechtexter"
let g:wpsnippets2["global"]["ts"] = "$timestamp"


" /home/kdog3682/2023/

function! Cmf()
    let f = '/home/kdog3682/RESOURCES/Unsorted Math Questions.txt'
    let t = s:tostring(s:read(f))
    let p = s:split(t, '\n-{5,}')
    ec len(p)
    let store = []
    for item in p
        try
            let lines = s:count(item, '\n')
            if lines > 3
                continue
            endif
            ec item
            let a = InputChars(1)
            if a != -1 && s:exists(trim(a))
                call add(store, [a, item])
            endif
        catch
            break
        endtry
        execute 'redraw!'
    endfor
    ec s:encode(store)
endfunction
function! s:read(file)
    let file = a:file
    let s = s:joinlines(readfile(file))
    if GetExtension(file) == 'json'
        return json_decode(s)
    endif
    return s
endfunction

function! Mywords()
    " /mnt/chromeos/MyFiles/Downloads/
    " /home/kdog3682/RESOURCES/
    " /home/kdog3682/2024/
    " /mnt/chromeos/GoogleDrive/MyDrive/
    " /mnt/chromeos/GoogleDrive/MyDrive/JSONS 2023
    " /mnt/chromeos/GoogleDrive/MyDrive/JSONS
endfunction

function! Mywords()
    let words = s:tolines(s:read(f))
    ec words[0:10]
    " /home/kdog3682/2023/fixProse.js
endfunction


function! Spellcheck()
    let a = s:read('')
endfunction
function! SaveDel()
    let i = line('.')
    let s = getline(i)
    call deletebufline('%', i)
    call add(g:yanks, s)
    ec len(g:yanks)
endfunction
function! TempSaveDel()
    if s:exists(g:yanks)
        nunmap <buffer> f
        let @"=s:tostring(g:yanks)
        let g:yanks = []
        ec 'done'
    else
        nnoremap <buffer> f :call SaveDel()<CR>
    endif
endfunction
let g:execRef["tsd"] = "TempSaveDel"

set nowrap


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


" function! A8(...)
    " call AddImport('aaa', 'next.js')
" endfunction
let g:filedict["dia"] = "/home/kdog3682/2023/dialogue3.js"

let g:jspyref3["javascript"]["execFunctions"] = {}
let g:jspyref3["javascript"]["execFunctions"]["j"] = 'CreateExampleJsSection'
let g:jspyref3["javascript"]["execFunctions"]["i"] = 'SetEJSInpath'
let g:jspyref3["javascript"]["execFunctions"]["o"] = 'SetEJSOutpath'
function! SetEJSOutpath(s)
    let s = a:s
    let i = s:fli('^\w+:', '.', -1, 100, 0)
    call s:myappend(i, s:colon('outpath', FileGetter2(s)))
endfunction

function! SetEJSInpath(s)
    let s = a:s
    let i = s:fli('^\w+:', '.', -1, 100, 0)
    call s:myappend(i, s:colon('inpath', FileGetter2(s)))
endfunction
function! s:colon(a, b)
    let a = a:a
    let b = a:b
    return a . ': ' . b
endfunction


let g:wpsnippets2["javascript"]["j"] = "--------------------------------------------------------------\npure: 1\ndate: ${DateStamp()}\nnote:\narg:\ncode:\n\nfunction $1::main(s) {\n    $c\n}"
function! s:scrolltobottom()
    call append('$', ['', ''])
    normal G
endfunction
let g:wpsnippets2["javascript"]["w"] = "while ($1::true) {\n	$c\n}"
let g:wpsnippets2["javascript"]["ifinc"] = "if ($1.includes($2)) {\n    $n}"
function! s:pick(items)
    " test: [1,2,3,4]
    let items = a:items
    if empty(items)
        return ''
    endif
    function! s:inner(i, s)
        let s = a:s
        return a:i + 1 . '. ' . s:encode(s)
    endfunction
    let display = map(copy(items), function('s:inner'))
    
    if len(items) == 1
        return items[0]
    endif
    ec display
    "Vim:Interrupt 
    let i = InputChars(1) - 1
    return items[i]
endfunction
let g:wpsnippets2["vim"]["iftail"] = "let t = Tail()\nif t == '$1'\n    $c\nendif"
let g:wpsnippets2["vim"]["iflang"] = "let lang = &filetype\nif lang == '$1'\n    $c\nendif"
let g:GI4Ref["foo"] = "GetFooIndexes"
let g:GI4Ref["w"] = "GIWindow"
function! GetFooIndexes()
    return [1, 10]
endfunction
let g:wpsnippets2["javascript"]["jarg"] = "--------------------------------------------------------------\npure: 1\ndate: ${DateStamp()}\nnote:\narg:\ncode:\n\n${Jarg($1)}\n"
function! s:doublequote(s)
    " test: '\"asdasd'
    let s = a:s
	return '"' . s:sub(s, '[^\\]\zs"', '\\"')  . '"'
endfunction
function! G(s)
    let s = a:s
    let l = getline('.')
    let t = s:tolines(s:templater2(s, l))
    call s:setblock(t, '.', 0, 1)
endfunction
function! ChooseSpeakers()
    let items = [
        \'kloe',
        \'kaylee',
        \'aaron',
        \'lynn',
        \'elina',
    \]
    let store = []
    let c = 0
    call BlueList(items)
    while c < 10
        let c += 1
        let a = s:getchar()
        if a == g:keyboard.enter || a == ' '
            return store
        elseif a == g:keyboard.bs && len(store) > 0
            call remove(store, -1)
                ec store
        elseif IsNumber(a)
                if a == len(items) + 1
                    return copy(items)
                endif
                call add(store, items[a - 1])
                ec store
        endif
    endwhile
endfunction
function! CreateSpeaker()
    let b:speaker = ModularIncrement2(b:speakers, b:speaker)
    if s:t(getline('.'), 'speaker \=')
        return s:getsetline({s-> s:sub(s, 'speaker \= \zs\w+', b:speaker)})
    endif
    call G(printf("@speaker = %s\n    $1", b:speaker))
    execute "normal! \<down>\<down>"
endfunction
function! Fresh()
    if &filetype == 'vim'
        return 1
    endif
    if exists('b:fresh') && s:exists(b:fresh)
        let b:fresh = 0
        return 0
    else
        let b:fresh = 1
        return 1
    endif
endfunction
function! Resetter()
    unlet b:speakers
endfunction
function! Checkfresh()
    ec Fresh()
endfunction
function! SpeakerStuff()
    "asdasda
    "asdasda
    "asdasda
    "asdasda
    "asdasda
    if Fresh()
        let b:tempcommands = []
        call SetTempCommand(2, 'CreateSpeaker')
        call SetTempCommand(3, 'IndentLine')

        let b:speakers = ChooseSpeakers()
        let b:speaker = b:speakers[0]
    else
        call SetTempCommand('')
    endif
endfunction
function! SetTempCommand(a, ...)
    let a = a:a
    let b = a:0 >= 1 ? a:1 : ''

    if empty(a)
        ec 'remapping old commands'
            "remap the old commands
        for item in b:tempunmappings
            let caller = s:match(item, 'call (\w+)')
            if !s:in(b:tempcommands, caller)
                ec item
                execute item
            endif
        endfor 
        let b:tempunmappings = []
    else
        ec 'setting temporary maps'
        try
            call UnmapAll(a, 'n')
        catch
            let error = v:exception
            ec error
        endtry
        let t = printf("nnoremap <buffer> %s :call %s()\<CR>", a, b)
        call add(b:tempcommands, b)
        ec t
        execute t
    endif
endfunction
function! IndentLine()
    call s:getsetline({x -> '    ' . x})
endfunction
" nnoremap 3 :wa<CR>:call Node3()<CR>
let g:execRef2 = {}
let g:execRef2["ss"] = "SpeakerStuff"
let g:execRef2["temp"] = "Checkfresh"
let g:runnerParamCache["child.iterate"] = "node"


function! WPCopyBlock()
    
endfunction
let g:visualactiondict['sbc'] = {'fn': 'VShunt', 'outpath': 'shunt.txt', 'i': 'belowCursor'}


set completeopt+=menuone,noinsert
set pumheight=8
let g:pumheight = 7
set shortmess+=c

function! Completion2()
    return 123
endfunction

function! GrabMappings()
    let base = GetMappings()
    let store = []
    for [file, lines] in items(base) 
    	let bufnr = BufLoad(file)
        for line in lines
            let t = s:getbufline(bufnr, line)
            call add(store, t)
        endfor
    endfor
    call s:appendblock(store, '$')
endfunction
" inoremap <silent> <buffer> <Tab> <C-R>=Completion2()<CR>

let s:insert_count = 0
let s:stop_completion = 0

let s:vcharstring = ''
function! OpenCompletion()
    let COMPLETER = "\<C-x>\<c-u>"
    if &filetype == 'markdown' || &filetype == 'vimaa'
        if v:char =~ '[a-z]'
            let s:vcharstring .= v:char
            " call input(string(v:char . string(len(s:vcharstring))))
        else
            let s:vcharstring = ''
        endif

        if len(s:vcharstring) >= 3
            silent call feedkeys(COMPLETER, 'n')
        endif
        return 
    endif
    " call input(string(v:char))
    let s = getline('.')
    let az = '\v[a-z]'
    let c = col('.')
    " let a = (s[c - 2] =~ az && s[c - 1] !~ az)
    " call input(string(s[c1]))
    if s[c-1] == "'" || s:t(s, '^ *"') || s:t(s, "' *$")
        " ignore quotes and comments and ending quotes as
        " asdasd aab 
        return 
    endif
    let a = s[c - 2]   =~ az
    " call input('a: ' . string(a))
    let b = empty(trim(s))
    let s:short = !pumvisible() && (a || b) && v:char =~ '[a-z]'
    " call input('a: ' . string(s:short))
    if s:short
        silent call feedkeys(COMPLETER, 'n')
    endif
endfunction
let g:autocomplete = 0
function! TurnOnAutoComplete()
    if g:autocomplete
        ec 'closing autocomplete'
        let g:autocomplete = 0
        augroup autocomplete
            autocmd!
        augroup END
    else
        ec 'activating autocomplete'
        let g:autocomplete = 1
    augroup autocomplete
        autocmd!
        autocmd InsertLeave let s:insert_count = 0
        autocmd InsertCharPre *.js,*.vimrc,*.vim,*.md silent! call OpenCompletion()
        " autocmd CompleteDone *.js,*.vimrc,*.vim,*.md silent! call OnCompleteDone()
    augroup END
    endif
endfunction

function! OnCompleteDone()
    " let el = v:completed_item
    " call BlueInput('el: ' . string(el))
    let s:vcharstring = ''
endfunction


function! ListMonths2()
  call complete(col('.'), ['January', 'February', 'March',
    \ 'April', 'May', 'June', 'July', 'August', 'September',
    \ 'October', 'November', 'December'])
  return ''
endfunction

let s:months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December']
function! ListMonths3()
  call complete(col('.'), s:completionChoices2023)
  return ''
endfunction


" inoremap <buffer> <silent> qz <C-R>=ListMonths2()<CR>

let g:execRef2["tac"] = "TurnOnAutoComplete"


vnoremap j :<c-u>call VShuntController()<CR>

let g:cssFunctions = [
  \"CssHelp",
  \"CssSnippetWP",
  \"CssBracket",
  \"CssGetItem",
  \"CssParser",
  \"CssGetItems",
  \"CssIncrement",
  \"CssEditValue",
  \"CssEditNumber",
  \"CssEdit",
  \"CssEditDelete",
  \"CssDefine",
  \"CssMatchLine",
  \"CssColorTransform",
  \"CssPmwh",
  \"CssAddPeriod",
  \"CssSnippetFromEnd",
  \"CssEnter",
  \"CssComplete",
  \"CssBlockExit", 
  \"CssBlockEnter",
  \"CssNormalTab",
  \"CssNormalSpace",
  \"CssSubmitString",
  \"CssNormalEnter",
  \"CssNormalKey",
\]

function! CssDotCompletion()
    
endfunction
function! s:stringbeforecursor(...)
    
    let s = getline('.')
    let pos = col('.') - 1
    let m = strpart(s, 0, pos)
    let r = a:0 >= 1 ? a:1 : 0
    if s:exists(r)
        let w = s:match(m, r)
        return w
    endif
    return m
endfunction
function! CssDotCompletionExpr()
    let r =  '[a-z]+$'
    let m = s:stringbeforecursor(r)
    if s:exists(m)
        return s:backspaces(m) . s:pick(CssGetClasses(m))
    endif
    return '.'
endfunction


function! CssGetClasses(s)
    let items = GrabTextFromSomewhere0('^[a-z.]\S.+?\ze {')
    let r = MyRegex(a:s)
    return filter(items, 's:t(v:val, r)')
endfunction

" function! GlobalFindall()
    " let p = getpos('.')
    " let t = "g/\\v%s/call add(store, GetLineInfo())"
    " execute printf(t, r)
    " call setpos(".", p)
" endfunction

function! CssOmniIncrement()
    if s:issol()
        call GetSetFn('CssSolIncrement')
    else
        return CssIncrement()
    endif
endfunction
function! CssSolIncrement(s)
    let s = a:s
        let keys = ['before', 'after']
        let r = ':\zs(before|after)'
        let m = s:match(s, r)
        if s:exists(m)
            let next = ModularIncrement2(keys, m)
            return s:sub(s, r, next, '')
        else
            return s:sub(s, '\S+\zs', '::after', '')
        endif
endfunction
inoremap <expr> 1 PumExpr(1)
inoremap <expr> 2 PumExpr(2)
inoremap <expr> 3 PumExpr(3)
inoremap <expr> 4 PumExpr(4)
inoremap <expr> 5 PumExpr(5)
inoremap <expr> 6 PumExpr(6)
inoremap <expr> 7 PumExpr(7)
inoremap <expr> 8 PumExpr(8)

function! PumExpr(n)
    let n = a:n
    let down = repeat(g:keyboard.down, n - 1)
    return pumvisible() ? down . g:keyboard.enter : n
    
endfunction

function! s:backspaces(s)
    let s = a:s
    let n = IsNumber(a:s) ? a:s : len(a:s)
    return repeat(g:keyboard.BS, n)
endfunction

function! WordSpiral(r, index, indexes, seen)
    let ignore = s:jspy('reservedKeywords')
    let r = a:r
    let index = a:index
    let [wmin, wmax] = a:indexes
    let seen = a:seen
    let store = []

    for i in range(wmin, wmax)
        let s = getline(i)
        let m = s:findall(s, r)
        if s:exists(m)
            let ind = abs(index - i)
            for item in m
                if s:in(seen, item) || s:in(ignore, item)
                    continue
                endif
                call add(seen, item)
                call add(store, [ind, item])
            endfor
        endif
    endfor
    call sort(store, {x -> x[0]})
    " store
    " call BlueInput(': ' . string(store))

    return map(store, 'v:val[1]')
endfunction



let g:vimReservedWords = [
  \"let",
  \"g:",
  \"b:",
  \"l:",
  \"a:",
  \"if",
  \"else",
  \"while",
  \"for",
  \"echo",
  \"try",
  \"catch",
  \"abort",
  \"exit",
  \"match",
  \"add"
\]

let g:pythonReservedWords = [
  \"and",
  \"as",
  \"async",
  \"await",
  \"break",
  \"class",
  \"def",
  \"del",
  \"elif",
  \"else",
  \"for",
  \"from",
  \"if",
  \"in",
  \"is",
  \"not",
  \"or",
  \"pass",
  \"raise",
  \"try",
  \"while",
  \"with",
  \"yield"
\]


let g:jspyref3["vim"]["reservedKeywords"] = g:vimReservedWords
let g:jspyref3["python"]["reservedKeywords"] = g:pythonReservedWords
let g:jspyref3["javascript"]["reservedKeywords"] = g:javascriptReservedWords

function! s:gather()
    return GrabTextFromSomewhere0('^function!? \zss:\w+')
endfunction
function! Asdjfkkkj()
    call append('$', CreateBinding('g:vimscriptfns', s:gather()))
endfunction
function! VimScriptFunctions()
    if !exists('b:vimscriptfns')
        let b:vimscriptfns = s:gather()
    endif
    return b:vimscriptfns
endfunction



let g:jspyref3["vim"]["commonFunctionWords"] = ['Transform', 'string']
let g:jspyref3["python"]["commonFunctionWordAtoms"] = ""
let g:jspyref3["javascript"]["commonFunctionWords"] = ""
let g:execRef2["gr"] = "GlobalReplaceController"
inoremap <silent> <buffer> <expr> 4 '$'
let g:wpsnippets2["vim"]["ifl3"] = "if len($1) < 3\n    $c\nendif"
let g:wpsnippets2["vim"]["ifl3"] = "if len($1) < 1\n    $nendif"
let g:wpsnippets2["vim"]["ifl3"] = "if len($1) < 2\n    $c\nendif"
let g:wpsnippets2["vim"]["ifl3"] = "if len($1) < 5\n    $c\nendif"


function! s:jspyfile(key)
    " test: "highFrequencyWords"
    let key = a:key
    let a = DictGetter2(g:jspyref3, &filetype, key)
    if empty(a)
        let a = []
    endif
    let b = DictGetter2(g:jspyfileref, expand('%:t'), key)
    if empty(b)
        let b = []
    endif
    let value = a + b
    return value
endfunction
function! Sdjfshdkj()
    let b = DictSetter('g:jspyfileref', '.vimrc', 'solWords', ['else'])
endfunction
function! s:merge(a, b)
    let a = a:a
    let b = a:b
	
    if empty(a)
        return b
    endif

    if empty(b)
        return a
    endif
    return a + b
endfunction


let g:jspyfileref = {}

let g:jspyref3["vim"]["highFrequencyWords"] = []
let g:jspyref3["python"]["highFrequencyWords"] = []
let g:jspyref3["javascript"]["highFrequencyWords"] = ['name', 'async ', 'javascript', 'markdown', 'python', 'Words']

let g:jspyref3["vim"]["solWords"] = ['call s:myappend', 'let s = getline('.')']
let g:jspyref3["python"]["solWords"] = []
let g:jspyref3["javascript"]["solWords"] = []
" let g:global "Vim(return):E716: Key not present in Dictionary: "0"
let g:jspyfileref = {}

let g:jspyfileref[".vimrc"] = {}
let g:jspyfileref[".vimrc"]["solWords"] = ["sssssss", "function('s:inner')", "let s = getline('.')", "config","debug","status", 'call(foo)']
let g:jspyfileref[".vimrc"]["nonSolWords"] = []
let g:jspyfileref[".vimrc"]["highFrequencyWords"] = []
let g:jspyfileref["runExampleFile.js"] = {}
let g:jspyfileref["runExampleFile.js"]["highFrequencyWords"] = ["inpath", "outpath"]

let g:jspyfileref["examples.js"] = {}
let g:jspyfileref["examples.js"]["highFrequencyWords"] = ["inpath", "outpath"]
let g:jspyfileref["examples.js"]["solWords"] = ["config","debug","status", 'call(foo)']
let g:jspyfileref["examples.js"]["nonSolWords"] = ["config","debug","status", 'call(foo)']
function! TransformJSWordSpiral(store)
    let store = a:store
    for i in range(len(store))
        let word = store[i]
        let re = '^(self|this)'
        if Test(word, '\($')
            call add(store, Replace(word, '(\.\w+)?\($', ''))
        elseif Test(word, re)
            call add(store, Replace(word, re, ''))
            call add(store, word)
        else
            call add(store, word)
        endif

        if s:t(word, '\.')
            let word = Replace(word, '\($', '')
            let dotted = s:split(word, '\.')
            call filter(dotted, 'len(v:val) > 5')
            call extend(store, dotted)
        endif
    endfor
    let store = s:regexfilter(store, r)

endfunction
setlocal completefunc=VimComplete

function! CssWriteBlock()
    let [spaces, line] = GetSpacesAndLine()
    if s:exists(spaces)
        call s:deleteline()
        call s:scrolltobottom()
    endif
    let ref = [line]
    let template = "$1 {\n    $c\n}"
    let t = s:templater2(template, ref)
    call s:setblock(t, '.', 0, 0)
endfunction

function! CssEnter()
    let i = line('.')
    let s = getline(i)
    let indent = 4
    let t = trim(s)
    if empty(t)
        return g:keyboard.enter
    endif
    if Test(t, ';')
        return g:keyboard.eol . g:keyboard.enter
    endif
    if Test(t, '\{')
        return "\<ESC>"
    endif
    if Test(t, '\}')
        return "\<ESC>"
    endif
    if Test(t, ':')
        return g:keyboard.eol . ';' . "\<CR>"
    endif

    let store = CssGetItems(s)
    let store = map(store, {i, s -> s[0] . ': ' . s[1] . ';'})
    return KeyboardPlaceItems(store, indent)


endfunction
let g:vimCurrentTestFunction = "CssEnter"
let g:keyboard.cr = "\<cr>"
let g:keyboard.eol = g:keyboard.co . 'A'

function! CreatePopup()
    throw 'doesnt work'
    let items = ['Option 1', 'Option 2', 'Option 3', 'Option 4']
    let popup_opts = {
      \ 'pos': 'center',
      \ 'padding': [1, 1, 1, 1],
      \ 'border': [1, 1, 1, 1],
      \ 'maxheight': 10,
      \ 'maxwidth': 20,
      \ 'title': 'Select an Option:',
      \ 'paddingchar': ' ',
      \ 'textprop': 'List',
      \ 'firstline': 0,
      \ }

    let popup_id = popup_create(items, popup_opts)
    call popup_close(popup_id)

    " call popup_show(popup_id)

endfunction
"https://stackoverflow.com/questions/6937984/is-there-a-way-to-make-use-of-two-custom-complete-functions-in-vimscript interesting
"interesting item
let g:filedict["bcs"] = "/home/kdog3682/2023/base.css"
function! s:extend(a, b)
    let a = a:a
    let b = a:b
	
    if empty(a) && empty(b)
        return []
    elseif empty(a)
        return b
    elseif empty(b)
        return a 
    else
        return extend(a, b)
    endif

endfunction

function! GetHelp(...)
    let s = a:0 >= 1 ? a:1 : s:gcw()
    execute "h " . s
endfunction
let g:execRef2["h"] = "GetHelp"
" inoremap <expr> <Tab> pumvisible() ? (complete_info()['selected'] == -1 ? "\<C-n>" : "\<C-y>") : "\<Tab>"

function! S()
    " let b = DictGetter2(g:jspyfileref, Tail(), 'highFrequencyWords')
    return get(g:jspyfileref, Tail())
    return b
endfunction
function! GetMarkdownWords(key)
    let key = a:key
    return s:regexfilter2(g:charlotteswebwords, key)
endfunction

function! s:concat(...)
	return s:flat(a:000)
endfunction
function! SmartEqualDict(dictValue)
    let prefix = s:jspy('prefix')
    let dictValue = a:dictValue
	
            let replaceWith = get(dictValue, 'replaceWith')
            let value = get(dictValue, 'value', '')
            """ bookmarkId: SmartEqual-1697451280 todo """
            " upbinding zditto
            """"""""""""""""""""""""""""""""""""""""""""""

            let conditionalTemplate = get(dictValue, 'conditionalTemplate', '')
            let entries = get(dictValue, 'entries', '')
            if Exists(conditionalTemplate)
                let s = ConditionalTemplater(conditionalTemplate)
                return  ' = ' . s . "\<C-O>I" . prefix . "\<C-O>A"
            endif
            if Exists(entries)
                let s = Backspaces(b)
                for [k, v] in items(entries)
                    let s .= prefix . k . ' = ' . v . g:keyboard.ENTER
                endfor
                return s
            endif
            if Exists(replaceWith)
                return "\<C-O>I\<C-O>D" . prefix . replaceWith . ' = ' . value
            elseif Exists(value)
                return GoLeft(l) . prefix . GoRight(l) . ' = ' .value 
            endif
endfunction
function! s:matchupbinding(name)
    let name = a:name
    let top = GetFunctionIndex()
    let r = '\w+\ze +\='
    let i = line('.')
    let c = 0
    while c < 20 && i <= top
        let c += 1
        let i -= 1
        let m = s:match(r)
        if s:exists(m)
            if m == name
                rt
            endif
        endif
        
    endwhile
    

endfunction
function! Ksdj0f(s)
    " test: "asdbcc"
    let s = a:s
    let r = CreateCompletionRE('Asd.b')
    ec r
    return s:t(s, r)
endfunction
function! s:ddd(s)
    " test: "asd"
    let s = toupper(a:s)
    let o = ''
    for i in range(len(s))
        let el = s[i]
        let o .= '[' . tolower(el) . el . ']'
    endfor
    return o
endfunction
function! CreateCompletionRE(a)
    " test: "a.b"
    let a = a:a
    if empty(a)
        return '\w{3,}'
    elseif len(a) == 1
        return a . '\w{3,}'
    elseif s:t(a, '\.')
        let [a,b] = s:split(a, '\.')
        let r = s:ccc(b)
        return s:ddd(a) . r
    elseif len(a) > 3
        return a . '\w{3,}'
    else
        let template = '\C(%s|%s)'
        return CreateComplicatedCompletionRE(a, template)
    endif
    
endfunction
function! GetCompletionWords(key)
    " test: "cm"
    " test: "gc"
    " "cm"
    " Config.map

    let r = CreateCompletionRE(a:key)
    let store = WordSpiraler('<' . r . '>')
    let all = store + LocalHighFrequencyWords('^' . a:key)
    return all
    
endfunction

function! WordSpiraler(r)
    let r = a:r
    let index = line('.') 
    let seen = []
    let w0 = line('w0')
    let w1 = line('w$')
    let indexes = [ [ w0, w1 ] ]
    if index - w0 < 10
        call add(indexes, [w0-20, w0 - 1])
        call add(indexes, [w1 + 1, w1 + 20])
    else
        call add(indexes, [w1 + 1, w1 + 20])
        call add(indexes, [w0-20, w0 - 1])
    endif
    for indexSet in indexes
        let store = WordSpiral(r, index, indexSet, seen)
        if s:exists(store)
            return store
        endif
    endfor
    return []
endfunction
inoremap <silent> <buffer> <Tab> <C-R>=CleverTab()<CR>
inoremap <silent> <buffer> <expr> <Tab> QQQ()
function! s:ccc(s)
    " test: "ci"
    let letters = SplitSingles(toupper(a:s))
    let length = len(letters)
    let ignore = '[^a-zA-Z0-9 ]'
    let ignore = '[-_.]'
    
    let out = '\C'
    for i in range(length)
        let el = letters[i]
        if i == 0
            let ch = printf('[%s%s]', tolower(el), el)
            let out .= ch
        else
            let ch = printf('(%s|%s[%s%s])', el, ignore, tolower(el), el)
            let out .= ch
        endif

        if i == length - 1 
            if IsNumber(ch)
                let out .= '\d*'
            else
                let out .= '[a-zA-Z-_0-9]{1,}'
            endif
        else
            let out .= '[a-zA-Z-_0-9]{-}'
        endif
    endfor
    return out
endfunction
function CreateComplicatedCompletionRE(s, template)
    let s = a:s
    let template = a:template
    let letters = SplitSingles(toupper(s))
    let length = len(letters)
    let out = s:ccc(s)
    let out2 = ''
    for i in range(length)
        let el = letters[i]
        let out2 .= printf('[%s%s]', tolower(el), el)
    endfor
    let out2 .= printf('\w{%s,}', 5 - length)
    return printf(template, out, out2)
endfunction
function! VimFunctionCompletion(s)
    let r = CreateCompletionRE(a:s[2:])
    let items = s:regexfilter2(LibraryWords(), r)
    if empty(items)
        let base = SearchText(-1000, '^function!? \zs\w+')
        let items = s:regexfilter2(base, r)
    endif
    return CRCompletion(items)
endfunction
function! JavascriptFarawayFunctionCompletion(s)
    let key = s:sub(a:s, '^\w*:', '')
    let r = '<' . CreateCompletionRE(key) . '>'
    let t = join(getline(1, '$'), "\n")
    let m = s:findall(t, r)
    let n = s:unique(m)
    return n
endfunction
let g:javascriptCompletionItems = [
    \{ 'a': '^\s*$', 'value': "\<TAB>"},
    \{ 'a': '/[a-z]+$', 'fn': 'JavascriptFileCompletion'},
    \{ 'a': 'f?:[a-z]+$', 'fn': 'JavascriptFarawayFunctionCompletion'},
    \{ 'a': '^[a-z]+$', 'fn': 'JavascriptSOLCompletion'},
    \{ 'a': '[a-z]+$', 'b': '^\w+', 'fn': 'WrapCompletion'},
    \{ 'a': '[a-z]+$', 'fn': 'WordSpiralCompletion'},
\]
let g:markdownCompletionItems = [
    \{ 'a': '[^a-z]$', 'value': " "},
    \{ 'a': '%(^| \zs)[a-z]+$', 'fn': 'MarkdownSpaceCompletion'},
\]
function! ParenExpr(s)
    let s = a:s
    return '(' . repeat(g:keyboard.right, len(s)) . ')'
endfunction
function! WrapCompletion(a, b)
    let a = a:a
    let b = a:b
    let wrappers = {'str': 'string'}
    return wrappers[a] . ParenExpr(b)
endfunction
function! s:ab()
    let s = getline('.')
    let pos = col('.') - 1
    let a = strpart(s, 0, pos)
    let b = strpart(s, pos)
    return [a,b]
    
endfunction
function! QQQ()
    let s = getline('.')
    let pos = col('.') - 1
    let a = strpart(s, 0, pos)
    let b = strpart(s, pos)

    let completions = s:jspy('qqqCompletionItems')
    " call BlueInput('completions: ' . string(completions))
    for item in completions
        let ha = has_key(item, 'a')
        let hb = has_key(item, 'b')
        if ha && hb
            let x = s:match(a, item.a)
            let backspaces = BackspaceExpr(x)
            let y = s:match(b, item.b)
            if s:exists(x) && s:exists(y)
                let value = function(item.fn)(x, y)
                if value == -1
                    continue
                endif
                return backspaces . value
            endif
        elseif ha
            let x = s:match(a, item.a)
            let backspaces = BackspaceExpr(x)

            if has_key(item, 'value')
                if s:t(a, item.a)
                    return item.value
                endif
                continue
            endif

            if s:exists(x)
                let value = s:isarray(x)
                    \ ? call(function(item.fn), x)
                    \ : function(item.fn)(x)
                " call BlueInput('value: ' . string(value))
                if s:isnumber(value) && value == -1
                    continue
                elseif s:isstring(value) && value == ' '
                    return ' '
                elseif s:isarray(value)
                    let value = CRCompletion(value)
                endif
                return backspaces . value
            endif
        elseif hb
            throw "not done yet"
            let y = s:match(b, item.b)
            if s:exists(y)
                return function(item.fn)(y)
            endif
        endif
    endfor
endfunction
function! BackspaceExpr(s)
    let s = a:s
    return s:exists(s) ? repeat(g:keyboard.bs, len(s)) : ''
endfunction
function! CRExpr(s)
    let s = a:s
    return "\<C-R>=" . a:s . '()' . "\<CR>"
endfunction
function! s:mget(s, r)
    let s = a:s
    let r = a:r
    return MGet(s, r)
endfunction
function! VimVarCompletion(s)
    let [a,b] = split(a:s, '\v:')
    " let a = a:a
    " let b = a:b

    let r = CreateCompletionRE(b)
    let store = WordSpiraler('<' . a . ':' . r . '>')
    if empty(store)
        return s:regexfilter2(g:vimscriptfns, '^s:' . r)
    else
        return store
    endif
endfunction
function! CRCompletion(store)
    let store = a:store
    if empty(store)
        return ''
        return -1
    endif
    let s:completionChoices2023 = store
    if len(s:completionChoices2023) == 1
        return s:completionChoices2023[0]
    endif
    return CRExpr('ListMonths3')
endfunction

function! Adfhkj()
    " options callback
    " a0
    call popup_create(s:months, options)
endfunction
" Function to close the custom popup menu
function! CloseCustomMenu()
    if has('popupwin')
        call popup_close('custom_menu')
    endif
endfunction

" Map a key to close the custom menu
nnoremap <F3> :call CloseCustomMenu()<CR>

function! WordSpiralCompletion(key)
    return CRCompletion(GetCompletionWords(a:key))
endfunction


" tests for completion
" strabc -> str(abc)
" cr -> CRExpr
" s:c -> s:completionChoices2023
vnoremap w :<c-u>call VisualParentheses()<CR>


function! VisualParentheses()
    let a = getpos("'<")
    let b = getpos("'>")
    let line = a[1]
    let ca = a[2]
    let cb = b[2]
    if ca > cb
        let temp = ca
        let cb = temp
        let ca = cb
    endif
    let ca -= 1
    let s = getline(line)
    let pa = s[0:ca-1]
    let pb = s[ca:cb-1]
    let pc = s[cb:]
    call setline(line, pa . '(' . pb . ')' . pc)
    " ec [pa,pb,pc]
endfunction
function! VimVarScriptLocalCompletion(s)
    let s = a:s
    let store = WordSpiraler('<s:\w+>')
    return CRCompletion(store)
endfunction


let g:vimCompletionItems  = [{"a":"^\\s*$","value":"\t"},{"a":"<f:[a-z.]+$","fn":"VimFunctionCompletion"},{"a":"<s:$","fn":"VimVarScriptLocalCompletion"},{"a":"[a-z]:[a-z]+$","fn":"VimVarCompletion"},{"a":"[a-z]+$","b":"^\\w+","fn":"WrapCompletion"},{"a":"[a-z]+$","fn":"WordSpiralCompletion"}]
let g:jspyref3["vim"]["qqqCompletionItems"] = g:vimCompletionItems
" let g:jspyref3["python"]["qqqCompletionItems"] = g:pythonCompletionItems
let g:jspyref3["javascript"]["qqqCompletionItems"] = g:javascriptCompletionItems
let g:jspyref3["markdown"]["qqqCompletionItems"] = g:markdownCompletionItems
let g:gfgfdict['q'] = ['/home/kdog3682/.vimrc', 'QQQ', 0]
function! LibraryWords()
    let items = LoadLibraryItems()
    let words = map(copy(items), {i,x -> x.name})
    return words
endfunction
function! SearchText(n, r)
    let n = a:n
    let r = a:r
    let li = line('.') + n
    let a = s:max(1, li)
    let b = line('$') 
    let store = []
    for i in range(a, b)
        let s = getline(i)
        let m = s:match(s, r)
        call s:push(store, m)
    endfor
    return store
endfunction
function! TextSearchUp(r, ...)
    " test: "function! (\\w+)", 5
    let r = a:r
    let n = a:0 >= 1 ? a:1 : 1
    let i = line('.')
    let c = 0
    let store = []
    while c < 1000
        let c += 1
        let i -= 1
        let s = getline(i)
        let m = s:match(s, r)
        call s:push(store, m)
        if len(store) == n
            return store
        endif
    endwhile
    return store
endfunction
function! LocalHighFrequencyWords(r)
    "test: ci
    let r = a:r
    function! s:inner(s)
        let s = a:s
        if s:t(s, '$')
            return s . "abc\<LEFT>"
        endif
    endfunction
    let items = [
        \{'regex': 'ci', 'value': "foo()"},
        \{'regex': 'cit', 'value': "fooo()"},
        \{'regex': 'ciy', 'value': "foooo()"},
    \]
    let m = map(filter(copy(items), 's:t(v:val.regex, r)'), 's:inner(v:val.value)')
    return m
endfunction
function! JavascriptSOLCompletion(s)
    let r = a:s
    let items = [
        \{'trigger': 'ci', 'value': "foo()"},
        \{'trigger': 'cit', 'value': "fooo()"},
        \{'trigger': 'ciy', 'value': "foooo()"},
    \]
    let m = map(filter(copy(items), 's:t(v:val.trigger, r)'), 's:inner(v:val.value)')
    return CRCompletion(WordSpiralerWrapper(a:s) + m)
endfunction
function! WordSpiralerWrapper(s)
    let r = CreateCompletionRE(a:s)
    let store = WordSpiraler('<' . r . '>')
    return store
endfunction
function! JavascriptFileCompletion(s)
    let s = a:s
	let key = s[1:]
    let ref = {
    	\'in': '^inpath: *(.+)',
    	\'out': '^outpath: *(.+)',
    \}
    let r = has_key(ref, key) ? ref[key] : MyRegex2(key)

    let store = TextSearchUp(r, 3)
    return store
endfunction
" /usr/share/vim/vim82/ftplugin/
inoremap <expr> qq QQ()
inoremap <buffer> <expr> <space> ' '
inoremap <buffer> <expr> <space> SpaceCompletion()
function! SpaceCompletion()
    let [a,b] = s:ab()
    let last = s:match(a, '%(^|\s\zs)[a-z]+$')
    if empty(last)
        return ' '
    endif
    let ref = {
    	\'pl': '+',
    	\'r': 'return',
    \}
    if !has_key(ref, last)
        return ' '
    endif
    let item = ref[last]
    let back = BackspaceExpr(last)
    if s:isstring(item)
        return back . item . ' '
    endif
      
endfunction
function! JSCreateVar(s)
    let s = a:s
	return CreateBinding('temp', s)
endfunction
let s:stop = 0
function! MarkdownSpaceCompletion(key)
    if s:stop
        let s:stop = 0
        return ' '
    endif
    let key = a:key
    let items = filter(copy(g:markdownCompletionWords), 's:t(v:val, "^" . key)')
    if s:exists(items)
        let s:stop = 1
        return items
    else
        return ' '
    endif
endfunction
let g:runnerParamCache["return"] = "item"
let g:vimscriptfns = ["s:xsplit","s:replaceblock","s:wbc","s:strcall","s:jspy","s:csv","s:llvf","s:gsp","s:boundary","s:regexfilter2","s:notin","s:gsr","s:gsl","s:getsetline","s:regexfilter","s:wrapper","s:sfar","s:ss","s:tna","s:aaq","s:dsto","s:sosall","s:hasdollar","s:temp","s:issol","s:isstring","s:isarray","s:isnumber","s:isobject","s:fngetter","s:longest","s:trie","s:sl","s:splitatcursor","s:joinlines","s:sotd","s:gval","s:getchar","s:gfts","s:findall","s:evaljs","s:evalpy","s:node","s:python","s:jsvimeval","s:so","s:filegetter","s:throw","s:geval","s:myappend","s:appendbelow","s:appendabove","s:numbergetter","s:comment","s:commentedlinebreak","s:repeat","s:read","s:appendfile","s:npath","s:tabs","s:nomatch","s:promptwithlist","s:prompt","s:escapespace","s:unescapespace","s:choose","s:test","s:find","s:roundtonearest10","s:movetonearestnumber","s:exists","s:match","s:push","s:matchfilter","s:getspaces","s:getindent","s:t","s:ig","s:fli","s:fli2","s:ss","s:getiden","s:getlines","s:gi","s:unique","s:findall","s:sds","s:ssds","s:throw","s:assert","s:xqft","s:min","s:max","s:range","s:sub","s:indent","s:nindent","s:tostring","s:tospaces","s:cursor","s:tolines","s:coercearray","s:print","s:smartindent","s:dedent","s:templater","s:smartpath","s:hr","s:linegetter","s:isemptyline","s:getlinestate","s:gcw","s:global_replace","s:isword","s:group","s:encode","s:confirm","s:removestartingcomments","s:unmap","s:redir","s:isfile","s:isdir","s:flat","s:printf","s:blue","s:red","s:input","s:sillygetregex","s:color","s:filter","s:testf","s:page","s:remap","s:interactive","s:getsmartindent","s:fold","s:setblock","s:singlequote","s:delete_empty_lines","s:empty","s:getverbosemapping","s:deleteline","s:isodd","s:iseven","s:cap","s:n2char","s:datestamp","s:in","s:initialize_variable","s:getbuffers","s:getlinkedfile","s:chooseindex","s:node_or_python","s:maptemplater","s:appendblock","s:movement","s:setpaste","s:open","s:bigask","s:split","s:touch","s:smartdedent","s:prettyprint","s:foobar","s:setbookmark","s:getvimstate","s:reduce","s:findlineindex","s:assign","s:go","s:upline","s:asdf","s:fngetter2","s:npath","s:replace","s:pathjoin","s:some","s:bookmarker","s:bufload","s:bufappend","s:tail","s:getidenstr","s:smallify","s:togglecomment","s:getupbinding","s:getbufline","s:templater2","s:ImplicitNameFromExpr","s:count","s:createvar","s:get_temp_lines","s:read","s:colon","s:scrolltobottom","s:pick","s:doublequote","s:stringbeforecursor","s:backspaces","s:gather","s:jspyfile","s:merge","s:extend","s:concat","s:matchupbinding","s:ddd","s:ccc","s:ab","s:mget"]

let g:explorerExecRef = {}
function! ExplorerController(...)
    let dir = '/home/kdog3682/2024/'
    let g:netrwdir = dir
    execute 'Explore ' . dir
endfunction

let g:execRef2["e"] = "ExplorerController"
function! Netrwdir()
	let current_netrw_dir = expand('<sfile>:p:h')
    return current_netrw_dir
endfunction

function! CopyTheFile()
    let c = CurrentFile()
    let name = s:prompt('name?', Tail(c))
    let name = AddExtension2(name, GetExtension2(c))
    let dir = s:choose(g:directories)
    let outpath = s:pathjoin(dir, name)
    call BlueInput('outpath: ' . string(outpath))
    call CopyFile(c, outpath)
endfunction

function! s:head(s)
    " test: "/home/kdog3682/.vimrc"
    let s = a:s
    return fnamemodify(s, ':p:h')
endfunction

function! Directories()
    let dir = s:unique(map(values(g:filedict), 's:head(v:val)'))
    let dir = filter(dir, 's:t(v:val, "^/") && s:isdir(v:val)')
    call append('$', CreateBinding('g:directories', dir))
endfunction
let g:directories = ["/home/kdog3682/2023","/home/kdog3682/.vim/ftplugin","/home/kdog3682/PYTHON","/home/kdog3682/.npm-global/lib/node_modules/@lezer/markdown/dist","/home/kdog3682","/home/kdog3682/2023/node_modules/@lezer/python/src","/home/kdog3682/2024","/mnt/chromeos/MyFiles/Downloads","/home/kdog3682/.vim/autoload","/home/kdog3682/RESOURCES","/mnt/chromeos/GoogleDrive/MyDrive/JSONS","/home/kdog3682/2023/node_modules/@lezer/javascript/src","/home/kdog3682/2023/node_modules"]
let g:execRef2["ctf"] = "CopyTheFile"
