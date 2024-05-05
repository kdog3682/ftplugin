" let g:loaded_matchparen = 0
" let g:loaded_remote_plugins = 0
" let g:loaded_netrwPlugin = 1
" let g:loaded_zip = 1
" let g:loaded_gzip = 1

" let g:loaded_man = 1
" let g:loaded_matchit = 1
" let g:loaded_shada_plugin = 1
" let g:loaded_spellfile_plugin = 1
" let g:loaded_tarPlugin = 1
" let g:loaded_2html_plugin = 1
" let g:loaded_tutor_mode_plugin = 1

set noincsearch
let maplocalleader = ","
let mapleader = ","
hi ErrorMsg ctermfg=White ctermbg = Black
hi WarningMsg ctermfg=White ctermbg = Black

set guicursor=n:block
set nohlsearch  " Turn off highlighting search by default



let g:deno_expression= 'deno run --allow-read --allow-run --allow-net --allow-write --allow-env --allow-all '
let g:typstfmt_expression= 'typstfmt '
let g:hr_line_length = 60
let g:prompt_message = 'asking a value: '
""" localBookmarkId: 1697717268 """ import "foo.typ": abc
"speakers: sammy jon bob
""" localBookmarkId: 1697717268 """ import "foo.typ"
highlight Pmenu ctermbg=gray guibg=gray
highlight Folded ctermfg=white ctermbg=black guifg=white guibg=black
" highlight MyCustomBlueColor ctermfg=blue guifg=blue"
" highlight MyCustomRedColor ctermfg=red guifg=red"
" highlight MyCustomGreenColor ctermfg=green guifg=green"
""" localBookmarkId: 1697717268 """

let g:fileRE = '[~.]*/[-+a-z0-9_ ./@]{-}\.%(\w*template|xml|ts|toml|yml|vue|png|svg|jpg|lua|compiled|raw|math|m|story|csv|rs|typ|stylus|bash_aliases|bash_history|gitignore|dialogue|log|vimrc|vim|json|js|tx[tf]|py|pdf|md|css|html|grammar)\ze%(["'']| *$)|[a-z1-9][-a-z+0-9_./@]+%(\w*template|log|dialogue|note|vimrc|vim|json|js|tx[tf]|py|typ|pdf|md|css|html|grammar|stylus|story|math|m|lua|compiled|raw|jpg|svg|png|toml|yml|ts|xml|vue)\ze%( *$|["''])'
let g:bookmarkfile = 'bookmarks.txt'
let g:functionPrefixRE = '^((async )?function[!*]?|class|def) '
let g:vim = 0
let g:override_debug = 0
let g:javascript = 0
let g:key = ''
let g:nodePackageManagerFunctions = ['runVuetify', 'runVuetifyViaSectioning']
let g:activeNodePackageManagerFunction = 'runVuetify'
let g:python = 0
source /home/kdog3682/.vim/ftplugin/functions.vim
source /home/kdog3682/.vim/ftplugin/variables.vim

source /home/kdog3682/.vim/ftplugin/variables.09-15-2023.vim
source /home/kdog3682/.vim/ftplugin/functions.09-15-2023.vim
source /home/kdog3682/.vim/ftplugin/variables.10-12-2023.vim
source /home/kdog3682/.vim/ftplugin/packages.vim


let g:execRef2 = {}
function! UnmapVim2()
    try
        :silent! nunmap <buffer> [{
    catch
    endtry

    try
        :silent! nunmap <buffer> ]}
    catch
    endtry

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
    " test: "asdf,\n  adsf"
    let s = a:s
    let r = s:match(a:s,  '[\|,]')
    if empty(r)
        let r = ' +'
    else
        let r = '[\n\t ]*' . r . '[\n\t ]*'
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
    if empty(a)
        let a = Abrev(b)
    endif
    return [a,b]
endfunction
function! DefineEatWord(...)
    let a = s:gcw()
    let b = a:0 >= 1 ? a:1 : Abrev(a)
    return DefineEat(a, b)
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
function! s:normalize_indexes_smaller_bigger(a)
    if IsNumber(a:a)
        return [a:a, a:a]
    endif
    let [a,b] = a:a
    if a > b
        return [b, a]
    endif
    return [a, b]
endfunction


function! s:replaceblock(indexes, lines, ...)
    let indent = a:0 >= 1 ? a:1 : 0
    let indexes = s:normalize_indexes_smaller_bigger(a:indexes)
    let lines = s:tolines(a:lines)
    if empty(lines)
        return 
    endif
    if s:exists(indent)
        let lines = s:smartindent(lines)
    endif
    let [a, b] = indexes
    for i in range(a, b)
        call deletebufline('%', a)
    endfor
    call append(a - 1, lines)
endfunction



function! s:get_spaces_and_line(x)
    return GetSpacesAndLine(a:x)
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
    let cmd = a:cmd
    let file = CurrentFile()
    if s:tail(file) == s:tail(a:file)
        return
    endif
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
function! s:jspy5(...)
    return s:dict_getter(g:jspyref3, filetype, a:000)
endfunction
function JP(...)
    return s:dict_getter(g:jspyref3, &filetype, a:000)
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
            return value
        endif
    endfor
endfunction
function! ZEqual()
    " sees the value of word under cursor
    let w = GetCurrentWord4()
    let value = 'none'
    if IsNumber(w)
        let value =  s:timestamp_to_datestamp(w)
    else
        let value = function(Capitalize(&filetype) . 'ZEqual')(w)
    endif
    ec value
     
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
    let base = !has("nvim") ? '/home/kdog3682/.vimrc' : "/home/kdog3682.config/nvim.init.vim"
    let file = a:0 >= 1 ? a:1 : base
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
    let lines = ''
    try
        let lines = ToLines(a:lines)
    catch
        let lines = map(copy(a:lines), 'string(v:val)')
    endtry
    if g:debug && !g:override_debug
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

" let s:use_override_ref = 0
function! GoLastFile()
    let a = s:config.last_file
    let b = g:lasttouchedfile
    let c = exists(a) ? a : b
    call OpenBuffer3(c)
endfunction
function! InitiateLogConsole()
    call LogConsole()
    let file = CurrentFile()
    let results = json_decode(s:joinlines(s:evaljs(file)))
    let s:log_console_results = results
    ec 'use shift arrow right or left to toggle the stuff'
endfunction
function! Node1(options={})
    let options = a:options
    let file = CurrentFile()
    if file== '/home/kdog3682/2024-javascript/staging/NameCheckerVisitors.js'
        let file = '/home/kdog3682/2024-javascript/staging/lezer-workspace.js'
    endif

    let ft = &filetype
    let ext = GetLongExtension(file)
    let tail= Tail(file)

    if ft == 'rust'
        return RunRust()
    elseif ft == 'vim'
        return ExecuteFunctionCaller2()
    elseif ext == 'ts'
        return RunTypeScript(file)
    elseif ext == 'deno.ts' || Test(file, 'lezer-workspace.js$')
        return RunDeno(file)
    endif

    if !has_key(options, "simple") && !s:in(g:ignore_overrides, file) &&  exists('g:override_node_file') && !empty(g:override_node_file)
        let ext = GetLongExtension(g:override_node_file)
        if ext != 'vim'
            let file = g:override_node_file
            let tail = Tail(file)
        endif
    endif

    let g:denoFileRef = {
        \'/home/kdog3682/bkl/math/slope/0.2.0/raw.txf': {"moduleFile": "/home/kdog3682/bkl/math/slope/0.2.0/build.js"}
    \}

    if has_key(g:denoFileRef, file)
        let ref = g:denoFileRef[file]
        return DenoFileRunner(ref.moduleFile)
    endif

    let g:node2extref = {
        \'vue.js': '/home/kdog3682/2024-javascript/vuekit/generateHtmlAndServe.js',
    \}


    let g:node3extref = {
        \'vue.js': '/home/kdog3682/2024-javascript/vuekit/build.js',
    \}

    if has_key(options, 'node2') && has_key(g:node2extref, ext)
        let caller = g:node2extref[ext]
        return DenoFileRunner(caller, {'file': file}) 
    endif

    if has_key(options, 'node3') && has_key(g:node3extref, ext)
        let caller = g:node3extref[ext]
        return DenoFileRunner(caller, {'file': file}) 
    endif

    let g:denoExtRef = {
        \'template.js': '/home/kdog3682/2024-javascript/evalenv/runExampleFile.js',
        \'vue.js': '/home/kdog3682/2024-javascript/vuekit/generate.js',
        \'create.vue.js': '/home/kdog3682/2024-javascript/vuekit/generate.js',
        \'txf': '/home/kdog3682/2024-javascript/txflow/generate.js',
    \}

    if has_key(g:denoExtRef, ext)
        let caller = g:denoExtRef[ext]
        return DenoFileRunner(caller, {'file': file}) 
    endif
        
    let ref = DictGetter2(g:fileRef, tail, 'node1')
    if s:exists(ref)
        return FileRefRunner(ref)
    endif

    let ignore = [ "/home/kdog3682/javascript/treesitter.js", ]

    if Test(file, "/javascript/\|castl")
        execute "!clear; node --no-warnings " . file
        return 
    elseif s:in(ignore, file)
        execute "!clear; node " . file
        return 
    elseif file != "/home/kdog3682/2023/utils.js" && Head(file) == "/home/kdog3682/2023"
        execute "!clear; node " . file
        return 
    endif

    if ft == 'typst' || ft == 'sql'
        return s:typst(file, 0)
    elseif &filetype== 'javascript'
        return SystemExec(file)
    endif

    " if ext == 'create.vue.js' || ext=="vue.js"
        " let caller = '/home/kdog3682/2024-javascript/vuekit/generate.js'
        " return DenoFileRunner(caller, {'file': file})
    " elseif tail == 'examples.template.js'
        " let jsFile = '/home/kdog3682/2024-javascript/evalenv/runExampleFile.js'
        " let lnum = getbufinfo(file)[0].lnum
        " return SystemExec(jsFile, {'file': file, 'lnum': lnum})
    " endif

    if GTracker('v3') && file != '/home/kdog3682/2023/typst-math-assignment-parser-v3.js'
        return s:typst('/home/kdog3682/2024-typst/src/clip.typ')
    endif

    if ft == 'python'
        execute '!clear; python3 ' . file
        return 
    endif

    if &filetype == 'javascript' && Test(getline('$'), '^write')
        return CompileTypstFromJavascript()
    endif

    " if s:config.use_override_node_file
        " let f = GetOverrideFile()
        " let ref = s:jspy6(f, 'override_node_handler')
        " call input('ref: ' . s:string(ref))
        " if s:exists(ref)
            " return SystemExec(ref, f)
        " endif
        " return SystemExec(f)
    " endif

    // starting to <buffer> <expr> deprecated...
    " if s:config.use_override_ref && exists('s:node_file_state')
        " return FileRefRunner()
    " endif

    if s:exists(s:config.last_file)
        return NodeTerminalOrShell(s:config.last_file)
    endif

    " if tail == 'runExampleFile.js'
        " return RunExampleFile() "also at node2"
    " endif

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
        return SystemExec(file)
        return Node(file)
    elseif ft == "python"
        return SystemExec(file)
        return s:python(file)
    else

    endif
        " return Node1000(file)
        " call Shell('node', file)
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
    return s:append_note_file(s:create_note(a:s))
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
        let r = dollar . '(arg|cf|e|t|cw|l|line|lineNumber|cb|binding|fn)>|(  )'
        let s = Sub(t, r, function('Inner'))
        if Exists(b) && Test(s, '\%s')
            let s = printf(s, b)
        endif
    else
        let dollar = Test(s, '\$') ? '\$' : '<' 
        let r = dollar . '(arg|cf|e|t|cw|l|line|lineNumber|cb|binding|fn)>|(  )'
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
function ReplaceCurrentWordWithPaste(...)
    " useful
    let s:rep = a:0 >= 1 ? a:1 : GetPasteBuffer()
    function! Inner(s)
        let word = GetCurrentWord()
        return Sub(a:s, word, s:rep)
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
    elseif Test(line, '\w $')
        return "\<BS>" . '.' . CR
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
    return Test(s, '\C^(s:|[A-Z])\w*$')
endfunction
function EndOfDay()
    " call append('$', '" ' . TomorrowDate())
    call Python3('endOfDay.py')
endfunction



let g:js_star_imports = ["variables", "crayonbox", "regex", "env", "jspy",]

let g:reff123 = {
    \'variables': 'import * as variables from "./variables.js"',
    \'crayonbox': 'import * as crayonbox from "./crayonbox.js"',
    \'regex': 'import * as regex from "./regex.js"',
    \'env': 'import * as env from "./env.js"',
    \'jspy': 'import * as jspy from "./jspy.js"',
\}
function! AddImport(...) abort
    let word = a:0 >= 1 ? a:1 : GetBindingName()
    let word = Replace(word, '^\W*', '')
    let file = a:0 >= 2 ? a:2 : ''
    if Test(Head(), '2024-javascript')
        return AddImport2024(word)
    endif
    let ref = s:get_file_ref('importDestination')
    if s:exists(ref)
        call OpenAndLeave(ref)
    endif
    let reff123 = g:reff123
    let varWord = GetFirstWord(word)

    if has_key(reff123, varWord)
        let s = reff123[varWord]
        call append(0, s)
        return 
    endif

    if empty(file)
        let data = s:get_file_data_from_cache(g:ffrfile)
        let item = s:find_ffr_item(data, word)
        if s:exists(item)
            let file = item.name
        else
            let file = FilePrompt('Choose the import file')
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

function! AddImport2(bindingName, destination)
    let bindingName = a:bindingName
    let destination = a:destination

    let r = '} *from *[''"].{-}' . destination . '"'

    try
        let index = s:fli(r, 0, 1, 20, 0)
        let line = getline(index)
        let s:name = bindingName
        if s:t(line, '\{')
            function! Inner(s)
                return Replace(a:s, '\{', '{ ' . s:name . ',')
            endfunction
            call GetSetFn('Inner', index)
        else
            call append(index - 2, '    ' . bindingName . ',')
        endif
    catch
        let s = RegistrarTemplater("import {\n    $1,\n} from \"./$2\"", [bindingName, destination])
        " call AppendString(0, s)
    endtry
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
    let s:store = []
    function! s:innerfindall(s)
        let s = a:s
        let matches = RemoveTrailingEmptyStrings(s)
        if s:exists(matches)
            if len(matches) == 1
                call add(s:store, matches[0])
            elseif len(matches) == 2
                call add(s:store, matches[1])
            else
                call add(s:store, s:smallify(matches[1:]))
            endif
        endif
        return ''
    endfunction
    call substitute(s, Regexed(r), function('s:innerfindall'), 'g')
    return s:store
endfunction

function! ToString(x)
    return IsString(a:x) ? a:x : empty(a:x) ? '' : join(a:x, "\n")
endfunction

" let t = '$timestamp updating v'
function MarkdownTab()
    let [a,b] = s:ab()
    let d = trim(a)

    let COMPLETER = "\<C-x>\<c-u>"
    let TAB = "    "

    if empty(trim(a))
        return TAB
    endif
    if 1 == 2
        return TAB
    elseif d == '*'
        return Backspaces(dd) . TAB . '- '
    elseif d == '"-'
        return Backspaces(dd) . TAB . '* '
    elseif d == '-'
        return Backspaces(dd) . TAB . '- '
    endif

    let a = s:match(a, '[a-z]+$')
    let length = len(a)
    if length >= 1 && length <= 3
        let items = GenericWordSpiralCompletion(a)
        return BackspaceExpr(a) . CRCompletion(items)
    else
        return ''
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
        " let t = strpart(line, start)
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
        ec s
        throw 'git error'
    endif
endfunction


function ExcuteInline(s)
    ec [a:s]
endfunction









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
    let s = a:s
    " let s = s:replace(s, '\?raw$', '')
    "test: file: vim-data.txt
    "test: 'import { stringToJson } from "./stringToJson.js"'
    "expect: 'stringToJson.js'
    let g:extensions = [
        \'vuemd',
        \'log',
        \'dialogue',
        \'note',
        \'vimrc',
        \'bash_aliases',
        \'bash_history',
        \'vim',
        \'json',
        \'story',
        \'typ',
        \'js',
        \'txt',
        \'py',
        \'pdf',
        \'md',
        \'css',
        \'html',
    \]
    let fileFromlineRE = '\.?/[-a-z0-9_ ./]{-}\.($1)\ze(["'']| *$)|[a-z][-a-z0-9_./]+($1)\ze( *$|["''])'
    let m = Match(s, s:ncg(g:extensions, fileFromlineRE))
    return m
endfunction

function! MoveFile()
    let a = GetFileFromLine2(getline('.'))
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
    call system(printf('cp %s %s', a:a, a:b))
    call s:log_file_creation_time(a:b)
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

function! s:capitalize(s)
    let s = a:s
    return Capitalize(a:s)
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


function! s:get_current_word_indexes(regex)
    let s = getline('.')
    let start = col('.')
    let regex = s:regex_getter(a:regex)

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
    let A = a
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
            let B = a
            return [B + 1, A]
            return [A, B]
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
    let cmd = "source " . file
    call append('.', cmd)
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

    let v = get(g:execRef2, k, '')
    let t = 'g:execRef2 has the key: %s with value: %s'
    let t2 = 'g:execRef2 does not have the key: %s'
    if Exists(v)
        call Echo(t, k, v)
    else
        call Echo(t2, k)
    endif


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
    let a = input('eval: ')
    if a == ''''
        return '"'
    endif
    return s:encode(eval(a))
endfunction




function! QQQQ(key)
    let key = a:key
    return s:completion_filter(s:months, key)
    let a = WordSpiraler(key)
    let b = s:completion_filter(s:months, key)
    return a + b
endfunction

function! QQQQ0(key)
    let key = a:key
    let a = key
    let b = 'vvvvvvvvv'

    let completions = s:jspy('qqqqCompletionItems')
    for item in completions
        if has_key(item, 'value')
            if s:t(a, item.a)
                return item.value
            endif
            continue
        endif

        let ha = has_key(item, 'a')
        let hb = has_key(item, 'b')
        let x = s:match(a, item.a)
        let y = hb ? s:match(b, item.b) : 0
        
        if hb && empty(y)
            continue
        endif
        if empty(x) 
            continue
        endif

        let value = s:isarray(x)
            \ ? call(function(item.fn), x)
            \ : hb
            \ ? function(item.fn)(x, y)
            \ : function(item.fn)(x)

        if s:isarray(value)
            return value
        endif
    endfor
endfunction
function JavascriptComplete(findstart, base)
    if a:findstart
        return FindStart('[a-zA-Z]')
    endif
    let s:touched = 1
    return GetFFRWords()
endfunction
function! GetFFRWords()
    if !exists('s:ffr') || empty(s:ffr)
        let words = map(s:read(g:ffrfile), 'v:val.contents')
        let store = []
        for item in words
            call extend(store, item)
        endfor
        let s:ffr = store
    endif
    call sort(s:ffr)
    return s:ffr
endfunction
let s:fruits = ['aaa', 'aab', 'aac', 'aad', 'aae', 'aaf', 'aag', 'aah']
function VimComplete(findstart, base) abort
    if a:findstart
        return FindStart('[a-z]')
    else
        return s:regexfilter2(s:fruits, a:base)
        return GlobalTextSearch(a:base)
        let store = GetMDWordsBasedOnKeyLength(a:base)
        let more = WordSpiraler('^' . b:lastCompletionTrigger . '\w+')
        return more + store
        let value = more + store
        if s:exists(value)
            return value
        endif
        throw 'nmatches'
        return GlobalTextSearch(a:base)
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
    let store = s:regexfilter(LibraryWords(), a:r)
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
function! GotoVimFunctionViaBinding(key)
    " test: 0
    let key = a:key
    let a = SeeMappings2(key)
    let [file, b] = s:choose(a)
    let name = s:match(b, '\C[A-Z]\w+\ze\(')
    let r = g:functionPrefixRE . name
    call s:open(file, r, 'zt')
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
    let word = s:gcw()

    if s:t(s, 'extends')
        return s:match(s, 'extends \zs\w+')
    endif
    if s:exists(word) && len(word) > 5
        return word 
    endif
    let words = s:findall(s, '%(s:)?\w+\ze\(')
    if s:exists(words)
        return s:choose(words)
    endif

    let words = s:get_words(s)
    if len(words) == 1 && s:t(words[0], '\C[a-z][A-Z]')
        let ignore = [
            \'return',
            \'const',
            \'var',
            \'function',
        \]
        return s:choose(words)
    endif

    throw 'couldnt find anything'
endfunction

function! s:get_word(s)
    let s = a:s
    return s:match(s, '[a-z]\w+')
endfunction

function! s:get_words(s)
    let s = a:s
    return s:findall(s, '[a-z]\w+')
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
    function! s:inner(s)
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

    let m = s:match(s, name . '\(\zs.{-}\ze\)')
    if empty(m)
        let name = Match(s, '\w+\ze\(')
        let name = s:sub(name, '-', '_')
        if empty(name)
            let m = GetCurrentWord4()
            return [m, []]
        endif
        let m = Match(s, name . '\zs\(\S.+')
    elseif empty(name)
        let name = Match(s, '\w+\ze\(')
    endif

    let p = split(m, ',')
    if len(p) > 3 && &filetype == 'vim' 
        return [name, ['...']]
    endif
    let params = Filter2(map(p, 's:inner(v:val)'))
    return [name, params]
endfunction

function JPCreateFunctionBlockNormal()
    let m = GetFunctionNameAndParamsFromLine()
    let [name, params] = m
    " call input('[name, params]: ' . s:string([name, params]))
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
    if empty(a:s)
        return 
    endif
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
    "test: 'n `' 
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
function! SortByLength(store, ...)
    let reverse = a:0 >= 1 ? 1 : 0
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
    let key = reverse ? 'Backward' : 'Forward'
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
    " ab$cd

    " execute "normal! /)/e\<CR>"
    " abc
    " abcde""
    " abc##  ##

    " Testing WordBeforeCursor
    " let word = expand('<cword>')
    " let word = WordBeforeCursor()
    " return '"' . word . '"'
    " ec word

endfunction
let g:runnerParamCache = {}

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
    " call InputPrompt('t', t)
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
    let editedName = s:sub(name, '^s:', '')
    let abrev = Abrev(editedName)[0:2]
    return [abrev, name]
endfunction
function! IsSol()
    let s = getline('.')
    let pos = col('.') - 2
    let slice = trim(s[0:pos])
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
    throw 'use VReplaceWithinRange2 instead'
    let state = a:state
    let start = state.start
    let end = state.end
    let regex = GetCurrentWord4()
    let replacement = Exists(state.arg) ? state.arg : GetPasteBuffer()
    let t = printf("%s,%ss/%s/%s/g", start, end, regex, replacement)
    ec t
    execute "normal! " . t
endfunction

function! s:replace_within_range(start, end, regex, replacement)
    let start = a:start
    let end = a:end
    let regex = a:regex
    let replacement = a:replacement
    let t = printf("%s,%ss/%s/%s/g", start, end, regex, replacement)
    ec t
    execute "normal! " . t
endfunction
function! VReplaceVueNameWithinRange(state)
    " test: {"start": 3567, "end": 3578}
    let state = a:state
    let start = state.start
    let end = state.end
    function! s:inner(s)
        let s = a:s
        if s:t(s, '-')
            return 'v-' . s:dashcase(s:replacement)
        endif
        return 'V' . s:pascal(s:replacement)
    endfunction

    let [raw_regex, rep] = s:so(state.arg)
    call s:assert(rep)

    let regex = '\C%(V|v-)' . s:insensitive(raw_regex) . '[-a-zA-Z0-9]*'
    let s:replacement = rep
    let replacement = '\=s:inner(submatch(0))'
    call s:global_replace(state, regex, replacement, 'g')
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


function! s:get_function_index()
    let i = GetFunctionIndex()
    return i
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
    if exists('b:overrideExecutionString')
        return s:print(eval(b:overrideExecutionString))
    endif
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
    let g:overrideExecutionString = t
    call BluePrint("
        \\n callstring: %s
        \\n results: %s
    \\n\n", t, value)
    let g:debug = 0
    return value
endfunction



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
   call s:settext(value, i, spaces)
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

function! GetSetRange2023(indexes)
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
function! s:execute_regex(r, ...)
    let r = a:r
    let base = '\v' . a:r
    let direction = a:0 >= 1 && !empty(a:1) ? '?' : '/'
    let flags = a:0 >= 2 && !empty(a:2)     ? prefix . 'e' : ''
    let movement = a:0 >= 3 && !empty(a:3)  ? 1 : 0
    let r = direction . base . flags

    try
        execute "normal! m'"
        execute r
        if movement
            execute 'normal! zt'
        endif
        return 1
    catch
        return 0
    endtry
endfunction

function! s:open_function(name)
    let r = g:functionPrefixRE . a:name . '>'
    return s:execute_regex(r, 0, 0, 1)
endfunction
function! OpenFunction(name, ...)
    let name = a:name
    if empty(name)
        return 
    endif
    let gm = a:0 >= 1 && !empty(a:1) ? 1 : 0
    let prefix = Exists(gm) ? g:bindingPrefixInnerRE : g:functionPrefixRE
    let r = prefix . name . '>'
        try
            let res = ExecuteRegex(r, 0, 0)
            normal! zt
        catch
            let error = v:exception
            if error== -1
                return 
            endif
            call FindFunctionViaImports(name)
            
        endtry
endfunction

function! GetGlobalBookmark(s)
    return Test(a:s, 'GBM') ? GetFileFromLine2(a:s) : 0
endfunction
function! OpenGlobalBookmark(file)
    let file = a:file
    call OpenBuffer3(file)
    call ExecuteRegex('\CGBM')

endfunction
function! s:file_specific_go__app()
    if GetExtension() == 'toc'
        let file = trim(getline("."))
        let dir_index = s:fli('^ *dir:', '.', -1, 100, 0)
        let dir = s:match(getline(dir_index), "^ *dir: *(.+)")
        let path = s:join_path(dir, file)
        call OpenBuffer3(path)
        return 1
    endif
    return
    let base = s:get_file_ref("file_specific_go_file_items")
    if empty(base)
        return 
    endif
    let s = s:remove_starting_comments(getline('.'))
    for item in items
        let m = has_key(item, "r") ? s:match(s, item.r) : function(item.function)(s)
        if s:exists(m)
            return function(item.after)(m, item))
        endif
    endfor
    
endfunction
function! GoFile()
    """ localBookmarkId: 1697717268 """

    if s:file_specific_go__app()
        return 
    endif
    let lastSetRE = 'last set from (.{-}) line (\d+)'
    let gvarRE = 'g:\S{1,}%(file|dir)'

    let items = [
        \{'r': 'bookmarkId: (\d{10}) (\S{5,})', 'type': 'file'},
        \{'r': '%(%(local)?BookmarkId:|\@bookmark) (\d{10})', 'type': 'bookmark'},
        \{'r': '^#import "(.{-}\.typ)"', 'type': 'typst_file'},
        \{'r': '^#import "\@local/(\S{-})"', 'type': 'typst_local_import'},
        \{'r': '^#import "\@preview/(\S{-})"', 'type': 'typst_preview_import'},
        \{'r': '^import \w+ from "\./(.{-})"', 'type': 'javascript_file'},
        \{'r': '^import .{-}"(.{-})"', 'type': 'javascript_file'},
        \{'r': '^import (\w+)', 'type': 'python_file'},
        \{'r': '^from (\w+) import', 'type': 'python_file'},
        \{'r': '^v-\S+$', 'type': 'component'},
        \{'r': '^/\*.{-} from [''"](.+)[''"]', 'type': 'file', "name": "js_import"},
        \{'r': '^/\*.{-}(\S+\.js)', 'type': 'file', "name": "js_import"},
        \{'r': '^%(\d+ +)?(/.+)$', 'type': 'file'},
        \{'r': 'ReadVimJSON\(.(.{-}).\)', 'type': 'vim_json_file'},
        \{'r': lastSetRE, 'type': 'fileFirst'},
        \{'r': '^\{.+} *$', 'type': 'json'},
        \{'r': 'https:[^"''<>,]{5,}', 'type': 'url'},
        \{'r': 'linkedBookmarkId: (\d{10}) (\S{5,})', 'type': 'file'},
        \{'r': g:fileRE, 'type': 'file'},
        \{'r': '[''"](.{-})\?raw', 'type': 'file'},
        \{'r': gvarRE, 'type': 'gvar'},
        \{'r': '%(this|self)\.([a-z0-9_$]+)', 'type': 'method'},
        \{'r': '/[a-z][@a-z0-9_/.-]{6,}', 'type': 'dir'},
        \{'function': 'GetFunctionFromLine2', 'type': 'function'},
    \]

    let s = s:remove_starting_comments(getline('.'))

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
        " ec item
        " call input("")
        " return

        " /home/kdog3682/.vimrc
        if item.type == "typst_preview_import"
            call input(string("hii"))
            let source = 'find $(pwd) -regextype posix-extended -type f | grep -vE ''(fonts|\.git|node_modules|\.log$|temp|package)'''
            let source = 'ls'
            let dir = 
            call fzf#run(fzf#wrap({"dir":dir, 'source': source, 'sink': 'e'}))

        elseif item.type == "typst_local_import"
            let file = '/home/kdog3682/.local/share/typst/packages/local/stdlib/0.1.0/src/index.typ'
            return OPEN(file)
        elseif item.type == "vim_json_file"
            let file = PathJoin(g:ftplugindir, 'assets/' . m . '.vim.json')
            return OPEN(file)
        elseif item.type == "typst_file"
            return s:open(TypstResolve(m))
        elseif item.type == "javascript_file"
            return s:open(m)
        elseif item.type == "python_file"
            return s:open(m . '.py')
        elseif item.type == "fileFirst"
            " ["n  er          * :call EchoTemplate('er')<CR>","\tLast set from ~/.vim/ftplugin/variables.10-12-2023.vim line 667"]
            call s:open(m[0], m[1])
        elseif item.type == "component"
                call ExecuteRegex('^name: ' . m)
                normal! zt

        elseif item.type == "method"
                call ExecuteRegex('(    |function )' . m . '\(')

        elseif item.type == "file"
            if IsArray(m)
                let [id, file] = m
                call OpenBuffer3(file)
                call ExecuteRegex(id)
            else
                call OpenBuffer3(m)
            endif
        elseif item.type == "json"
            let value = eval(m)
            let key = has_key(value, 'timestamp') ? value.timestamp : value.function
            call s:open(value.file, key)
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
            " ec m
            " return
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


function! s:regexfilter(items, r, ...)
    let items = a:items
    let target = a:0 >= 1 ? a:1 : 'v:val'
    if empty(items)
        return []
    endif
    let r = a:r
    return filter(copy(items), 's:t(' . target . ', a:r)')
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
        execute r
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
    	\'lp': 'echoPauseTemplate',
    	\'ei': 'echoInputTemplate',
    	\'ew': 'echoWordTemplate',
    	\'er': 'echoReturnTemplate',
    \}

    let template = s:jspy(a:key)
    if !s:exists(template)
        let template = s:jspy(get(aliases, a:key))
    endif
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
    if &filetype != 'vim'
        let b = capitalize(b)
        let t = printf("function %s(s)\n    let s = a:s\n    $c\nendfunction")
        call s:create_bottom_of_page_snippet(g:vimrcfile, t)
        call DefineDictItem('g:execRef2', a, b)
        return 
    endif
    if has_key(g:execRef2, a)
        let prev = g:execRef2[a]
        call BluePrompt('Overwriting g:execRef2[%s] = %s', a, prev)
        call s:action_log('overwriteExecRef', prev)
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
function! NormalSearchBaseExpr(r, mode = 'forward')
    let r = a:r
    let prefix = a:mode == 'forward' ? '' : '?'
    return prefix . "\\v" . r . "\<CR>"
endfunction
function! SearchDateExpr()
    let regexes = [
        \ '^("|#|//)\? *(\d+-\d+-\d+|\d+/\d+/\d+|\d{8,})',
        \ '^("|#|//)',
    \]
    let dirs = [ "forward", "backward" ]
    let r = GetOrSetGVariable('normal_search_re', regexes, 0)
    let dir = GetOrSetGVariable('normal_search_dir', dirs)
    return NormalSearchBaseExpr(r, dir)
endfunction

function! SplitFileAtCurrentLine()
    let i = line('.')
    let top = DeleteBlock([1, i])
    call AppendFile("/home/kdog3682/.vim/ftplugin/functions2.vim", top)
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

    " if Test(s, '^\S')
        " return FastCSS(s)
    " endif

    let langKey = 'css'
    let [spaces, tag, line, parts] = GetSpacesTagLineAndParts(s)
    let r = '\$(\{.{-}\}|\d+(--[a-z])?|[a-zA-Z]{3,})'
    let Fn = {x -> function('Pst')(x, parts, line)}
    let template = Get(g:wpsnippets, langKey, tag)
    if empty(template)
        call s:set_css_items_at_cursor(s)
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

    let m = Match2(s, '^(ff)([a-z]+)')
    if Exists(m)
        return [['font-family', "'" . m[1] . "'"]]
    endif 

    let m = Match2(s, '^(bg|fc)(\w+)')
    if Exists(m)
        return CssParser(m[0], m[1])
    endif 

    let m = Match2(s, '^([a-z]+)(\d\w*)')
    if Exists(m)
        return CssParser(m[0], m[1])
    endif 

    let m = Match2(s, '^([a-z]+)(auto)')
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
        if value== 'auto'
            return [cssKey, value]
        endif
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
function! s:find_anything_handler_key(s)
    " test: "set"
    let [a,b] = s:so(a:s)
    let keys = keys(g:execRef2)
    let r = CreateCompletionRE(a)
    " call input('r: ' . s:string(r))
    " call input('r: ' . s:string(r))
    let store = s:regexfilter(keys, r)
    let key = s:choose(store)
    return trim(key . ' ' . b)
endfunction
function! AnythingHandler2(key)
    "test: ask
    let key = a:key

    " if IsNumber(key)
        " return Cursor(key)
    " endif
    if s:t(key, '^/')
        let key = s:find_anything_handler_key(key[1:])
    endif
    if empty(key)
        " if exists('s:selected_config_key')
            " let s:config[s:selected_config_key] = 0
            " ec 'resetting s:config'
            " ec s:config
            " unlet s:selected_config_key
            " return
        " endif
        if exists('b:alteredFiletype') && s:exists(b:alteredFiletype)
            call ResetFileType()
            return 
        endif
        if !exists('b:lastKey')
            return 
        endif
        let key = b:lastKey
    else
        let b:lastKey = key
    endif

    if has_key(g:system_exec_ref, key)
        let s = g:system_exec_ref[key]
        if s:llvf(s)
            return function(s)()
        endif
        return GitCommandWrapper(s)
    endif
    if key == ':'
        let ref = s:get_file_ref('colon_action')
        if s:exists(ref)
            return s:colon_label_action()
        endif
        let ref = s:get_file_ref('execRef')
        if s:exists(ref)
            let cmd = s:choose(keys(ref))
            try
                call function(ref[cmd])()
            catch
                let e = v:exception
                ec e
                " call function(cmd)('')
            endtry
        else
            ec 'no execRef for this file'
        endif
        return
    endif

    if s:t(key, 'gt\.')
        if empty(key[3:])
            throw 'error at line 4818: gt'
        endif
        let g:tracker_string = key[3:]
        ec 'setting g:tracker to: ' . g:tracker_string
        return 
    endif


    if s:t(key, '\=')
        let [a,b] = s:so(key, '\=')
        if a == 'key'
            let g:key = b
            return 
        endif

        let v = CreateBinding(a, b, 1)
        try
            ec v
            execute v
        catch
            let error = v:exception
            ec error
        endtry
        return 
    endif

    let [a,b] = s:so(key)
    let ref = s:get_file_ref('execRef')
    """ bookmarkId: 1701647135 hfel: AnythingHandler2 """
    if s:exists(ref) && has_key(ref, a)
        let fnKey = ref[a]
        return s:exists(b) ? function(fnKey)(b) : function(fnKey)()
    endif

    if &filetype == 'netriiiw'
        try
            if has_key(g:explorerExecRef, a)
                let path = s:pathjoin(g:netrwdir, getline('.'))
                if IsFile(path)
                    call function(g:explorerExecRef[a])(path)
                endif
            endif
        catch
            let error = v:exception
            
        endtry
        return 
    endif

    if has_key(g:apae_map_templates, a)
        let key = a
        let [a, b] = DefineEatHelper(b)
        return DefineMapItem(key, a, b)
    elseif a == "execute" || a == 'call'
        execute(b)
        return 
    elseif s:t(a, '^\w:')
        try
            if s:t(b, '^d')
                let c = 'let ' . a . ' = ""'
                ec c
                execute c
            elseif s:t(b, '\=')
                let cmd = 'let ' . a . ' = ' . b
                ec cmd
                execute cmd
            else
                ec eval(a)
            endif
        catch
            let error = v:exception
            ec error
        endtry
        return 
    endif

    let fnKey = DictGetter2(g:jspyref3, &filetype, 'execFunctions', a)
    if s:exists(fnKey)
        if s:llvf(fnKey)
           return s:exists(b) ? function(fnKey)(b) : function(fnKey)()
        else
            return eval(fnKey)
        endif
    endif

    let fnKey = get(g:execRef2, a, 0)
    if s:exists(fnKey)
        if s:t(a, '^le\.')
            return LineEditWrapper(fnKey, b)
        elseif s:t(fnKey, '\)$')
            if s:exists(b) && s:t(fnKey, '\$\d')
                let fnKey = s:templater2(fnKey, b)
            endif
            return eval(fnKey)
        endif
        return s:exists(b) ? function(fnKey)(b) : function(fnKey)()
    endif

    " call input(s:string(key))
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
function! VAction3(key, arg)
    let key = a:key
    let arg = a:arg
    let ref = get(g:visualactiondict, key)
    let state = copy(ref)
    let state['arg'] = s:get_vim_state_arg(s:exists(arg) ? arg : get(ref, 'arg', ''))

    let indexes = s:gi2(ref.i)
    let lines = s:getlines(indexes)
    if has_key(ref, 'mapfilter')
        call map(lines, ref.mapfilter . '(v:val)')
        call filter(lines, 'Exists' . '(v:val)')
    endif
    let indentation = s:getindent(lines[0])
    let data = {
        \'lines': lines,
        \'text': s:joinlines(lines),
        \'start': indexes[0],
        \'indentation': indentation,
        \'end': indexes[1],
        \'indexes': indexes,
    \}
    call extend(state, data)
    let result=  function(state.fn)(state)
    if s:exists(result)
        if has_key(ref, 'replacer')
            call s:replaceblock(state.indexes, results)
        endif
    endif
    
endfunction
function! VAction2(key)
    let mode = 0
    let arg = 0
    let Fn = 0
    let indexes = 0

    let argSet = ForceSplit(a:key) 
    let [key, arg] = argSet
    let key = s:fuzzy_find_dict_key(key, g:visualactiondict)
    let ref = get(g:visualactiondict, key)
    if has_key(ref, 'version')
        return VAction3(key, arg)
    endif

    let indexerKey = get(ref, 'i', 'smart')
    " call input('ref: ' . s:string(ref))
    let Fn = s:fngetter(get(ref, 'fn', key))
    let indexes = s:gi(indexerKey)
    if empty(arg)
        let arg = get(ref, 'arg', '')
    endif
    let mode = get(ref, 'mode', '')
    let outpath = get(ref, 'outpath', '')
    let inpath = get(ref, 'inpath', '')
    let template = get(ref, 'template', '')
    let file = get(ref, 'file', '')
    let lines = s:getlines(indexes)
    let s = s:tostring(lines)
    let selection = has_key(ref, 'selection') ? GetVisualSelection() : 0


    let state = {'file': file, outpath': outpath, 'inpath': inpath, 'line': lines[0], 'selection': selection, 'start': indexes[0], 'end': indexes[1], 'length': len(lines), 'indexes': indexes, 'text': s, 'string': s,'mode': mode, 'lines': lines, 'arg': arg, 'indentation': match(lines[0], '\S'), 'template': template}
    if has_key(ref, 'delete')
        call DeleteBlock(state.indexes)
    endif

    call Fn(state)


endfunction
function! VAction(...)
    let mode = 0
    let arg = 0
    let Fn = 0
    let indexes = 0

    let argSet = a:0 == 1
        \ ? ForceSplit(a:1) 
        \ : a:000
    if empty(argSet[0])
        let argSet = b:lastVisualActionArgSet
    else
        let b:lastVisualActionArgSet = argSet
    endif

    let [key, arg] = argSet
    let ref = get(g:visualactiondict, key)

    if has_key(ref, 'version')
        return VAction3(key, arg)
    endif

    let Fn = s:fngetter(get(ref, 'fn', key))
    let indexerKey = get(ref, 'i', 'smart')
    let indexes = s:gi(indexerKey, 1)
    if empty(arg)
        let arg = get(ref, 'arg', '')
    endif
    let mode = get(ref, 'mode', '')
    let outpath = get(ref, 'outpath', '')
    let inpath = get(ref, 'inpath', '')
    let template = get(ref, 'template', '')
    let indent_zero = get(ref, 'indent_zero', '')
    let lines = s:getlines(indexes)
    let s = s:tostring(lines)
    let selection = has_key(ref, 'selection') ? GetVisualSelection() : 0


    let state = {'indent_zero': indent_zero, 'outpath': outpath, 'inpath': inpath, 'line': lines[0], 'selection': selection, 'start': indexes[0], 'end': indexes[1], 'length': len(lines), 'indexes': indexes, 'text': s, 'string': s,'mode': mode, 'lines': lines, 'arg': arg, 'indent_zeroation': match(lines[0], '\S'), 'template': template}
    if has_key(ref, 'delete')
        call DeleteBlock(state.indexes)
    endif

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
    call Blue(Printf(args))
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
    ec t
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
        elseif s:t(s, '^s:')
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
    let t = 'https://google.com/search?q=$1'
    return XdgOpen(s:templater(t, q))
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

let g:visualactiondict['btb'] = {'fn': 'VABlockToBrowser', 'i': 'window'}


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
            let b = ''
        elseif empty(a)
            let a = GetCurrentWord4()
        endif
    else
        let a = GetCurrentWord4()
        let b = s
    endif

    " let a = Rescape2023(a)
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







function! s:clockstamp()
    return strftime("%I:%M:%S %p")
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
  let dir = a:dir
  let n = a:0 >= 1 ? a:1 : 1
  let latest_mtime = 0
  let latest_file = ""

  let store = []
  let files = IsArray(dir) ? dir : GlobList(s:get_dir(dir))
  if len(files) == 1
      return files[0]
  endif

  for file in files
    if !s:is_file(file)
        continue
    endif
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

function! s:glob(...)
  let q = a:0 >= 1 ? a:1 : ''
  let dir = a:0 >= 2 ? a:2 : g:activedir
  let dir = s:sub(dir, '/$', '')
  let dir = dir . '/*'
  let items = glob(dir)
  let files = split(items, "\n")
  if empty(q)
      return files
  endif
  let r = s:boundary(q)
  return filter(files, 's:t(s:tail(v:val), r)')
endfunction


function! GlobList(dir)
  " test: 2023
  let dir = s:sub(s:get_dir(a:dir), '/$', '', '')
  let files = split(glob(dir . '/*'), "\n")
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


function! FindFunctionInText(key)
    let key = a:key
endfunction
function! QQ()

    if s:exists(g:yanks)
        return join(s:get_yanks(), ', ')
    endif
    let word = s:wbc('[a-z]{1,}')
    if empty(word)
        let expr = s:ref_sprawl(g:qq_ref)
        if s:t(expr, '\$')
            return s:templater2(expr)
        endif
        return eval(expr)
    endif

    let w = s:trie(word)
    if s:exists(w)
        return Backspaces(word) . s:pick(w)
    endif
    let store = GlobalTextSearch(word)
    return Backspaces(word) . CRCompletion(store)
endfunction
function! Qgp(...)
    let key = a:0 >= 1 ? a:1 : input('')
    if has_key(g:qref, key)
        return function(g:qref[key])()
    elseif s:t(key, '^\W+$')
        return key

    elseif key == 'm'
        return MostRecentFile('dldir')
    elseif key == 'd'
        return g:dir2024
    elseif !Exists(key)
        let buffers = GetActiveBuffers()
        return s:abspath(s:abc_choose(buffers))
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
    " list extensions js html css
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
     try
         nunmap <buffer> ]m
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
         nunmap <buffer> [m
     catch
         let error = v:exception
         ec error
         
     endtry
     try
         nunmap <buffer> [M
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
     ec "unmapping python"
endfunction

function! OpenBuffer4(file)
    let file = a:file
    if Not(file) || s:t(file, '0$')
        return 0
    endif
    if Test(file, "^/")
        execute ":e " . file
        return
    endif

    if GetExtension(file)=="py"
        call OpenBuffer(g:pydir . Tail(file))
    endif
    if file == '.vimrc' || file == '~/.vimrc'
        let file = '/home/kdog3682/.vimrc'
    endif
    let file = s:sub(file, '^\./', '', '')

    let file = Replace(s:smartnpath(file), '/$', '')

    if s:t(file, 'vim.json$')
        let file = PathJoin(g:ftplugindir, 'assets/' . Tail(file))
        call EnsureDirExists(file)
        return OPEN(file)
    endif

    if !IsFile(file) && IsFile(s:npath('2023', file))
        if Prompt('do you want to change to 2023 dir?')
            let file = s:npath('2023', file)
        endif
    endif
    " call input('file: ' . s:string(file))
    if IsCurrentFile(file)
        return 0
    endif
    if IsDir(file)
        execute 'Explore ' . file
        return 
    endif
    let typ=s:ge(file) == "typ"
    if typ 
        if !s:t(file, '^/')
            let file = "/home/kdog3682/2024-typst/src/" . s:tail(file)
        endif
        if s:t(file, 'github')
            let file = s:sub(file, '.{-}preview', '/home/kdog3682/.cache/typst/packages/preview')
        endif
        call EnsureDirExists(file)
    endif
    if !IsFile(file) && !typ && !Test(expand('%'), 'log$')
        let a = fnamemodify(expand('%'), ':h')
        let b = s:npath(a, file)
        if s:is_file(b)
            return OPEN(b)
        endif
        if s:t(s:tail(file), '(^|\.)appaaaaaaaa\.')
            let answer = RedPrompt("
                \\n Do you wish to create a app.manager app for this file?
                \\n An affirmative answer == required.
            \")
            if s:exists(answer)
                return s:create_app_file(file)
            endif
        else
            let ignore = '\d+-\d+-\d+\.txt$'
            if !Test(file, ignore)
                let answer = RedPrompt("
                    \\n The file: '%s' does not exist.
                    \\n Do you wish to proceed?
                    \\n Type 'cr' to create fileRef and commentPrefixes and other things.
                \\n\n", file)
            endif

            call EnsureDirExists(file)
            " if answer == 'cr'
                " call s:init_new_file_into_vim(file)
            " endif
        endif
        call LogCreateTime(file, 'files.log')
    endif

    try
        call EnsureDirExists(file)
    catch
        let error = v:exception
    endtry
    return OPEN(file)
endfunction

function! OpenBuffer3(s)
    return OpenBuffer4(a:s)
endfunction

function! LogCreateTime(name, key)
    "test: 'abc.js', 'files.log'
    let name = a:name
    let key = a:key
    let outpath = printf('%s%s', g:homedir, key)
    if CurrentFile() == outpath
        return 
    endif
    let s = strftime('%s') . ' ' . name
    call writefile([s], outpath, 'a')
    ec 'logging create time: ' . s
endfunction


function! BlueList(items)
    "test: [[1,2], [3,4]]
    let items = a:items
    ec '-------------------------------'
    for i in range(len(items))
        let item = items[i]
        let d = (i + 1) . '. ' . Stringer(item)
        call Blue(d)
    endfor
    ec "-------------------------------\n"
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
    if len(items) < 20
        call BlueList(items)
    else
        call s:blue(s:vertical_table(items))
    endif
    let a = InputChars(n)
    if a == -1
        return ''
    endif
    try
        return items[a - 1]
    catch
        let error = v:exception
        return ''
    endtry
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
    " elseif key == 'pluginfile' || key == 'ft'
        " let f = PathJoin(g:ftplugindir, &filetype . '.vim')
        " return f

    " elseif s:t(key, '^[a-z]ts$') && s:get_file_ref('alias')

    elseif &filetype == 'netrw'
        return expand('%') . '/' . key
    elseif Test(key, '^./')
        let head = Head() . '/'
        let tail = AddExtension(key[2:], GetExtension(CurrentFile()))
        return head . tail
    elseif key == 'p'
        let s = s:sub(@", '^\w+: *', '', '')
        let s = s:sub(s, '^[''"]|[''"]$', '')
        if IsFile(s)
            return s
        else
            throw 'paste buffer not a file'
        endif

    elseif key == 'gi'
        let dir = Jspy('dir')
        let dir = empty(dir) ? '/home/kdog3682/2023/' : dir
        return PathJoin(dir, '.gitignore')

    elseif key == 'glf'
        return GetMostRecentFile('dldir')

    elseif key == 'cwf'
        return g:currentWorkFile
    elseif key == 'san'
        return g:activeJavascriptFile

    elseif key == 'glf1'
        return GetSecondMostRecentFile("/mnt/chromeos/MyFiles/Downloads")

    elseif Test(key, 'file$')
        return s:gval(key)

    elseif Test(key, '^[abcdefghijklmnopqrstuvwxyz]js$')
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

    elseif key[0] == '.'
        let head = expand('%:p:h') . '/'
        let file = Tail(FileGetter2(key[1:]))
        return head . file

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

function CssIncrement(...)
    let dir = a:0 >= 1 ? a:1 : 1
    let s:dir = dir

    function! Get12345(key, value)
        let key = a:key
        let value = a:value
        if has_key(g:indexedCabmap, key)
            " call input(string('aa'))
            return ModularIncrement2(g:indexedCabmap[key], value, s:dir)
        elseif has_key(g:cssIncrementTable, key)
            let value = CssHandleIncrement(key, value, s:dir)
            return value
        else
            return
        endif
    endfunction 

    function! s:inner(s)
        let s = a:s
        "do not do any edits when the line ends with {
        if s:t(s, '\{ *$')
            return 
        " elseif Test(s, 'overflow(-[xy])?:')
            " let m = CssMatchLine(s)
        " endif

        elseif Test(s, '/\* ')
            return CssNextColor(s)
        endif

        let m = CssMatchLine(s)
        if empty(m)
            return 
        endif
        let [front, key, current] = m
        if has_key(g:cssKeymiMap, key)
            let newKey = g:cssKeymiMap[key]
            return printf('%s%s: %s;', front, newKey, value)
        endif
        let value = Get12345(key, current)
        return printf('%s%s: %s;', front, key, value)
    endfunction

    call s:getsetline('s:inner')

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

function! s:nbsplit(s)
    " test: "foo23"
    let s = a:s
    return split(s, '\v\D\zs\ze\d')
endfunction
function! CssNextColor(s)
    " test: "asdfasdf /* black-500 */"
    function! Inner(key)
        let key = a:key
        let [a,b] = split(key, '-')
        if b == 50
            let b = 100
        elseif b == 900
            let b = 950
        elseif b == 950
            let b = 50
        else
            let b += 100
        endif
        let value = CssColorTransform([a, b])
        return value
    endfunction
    let r =  '\S+ /\* (\S+) \*/'
    let t = '\=Inner(submatch(1))'
    return s:sub(a:s, r, t, '')
endfunction
function CssColorTransform(s)
    " test: "black"
    let m = s:isstring(a:s) ? s:nbsplit(a:s) : a:s
    let [a,b] = len(m) == 2 ? m : [m[0], '100']
    if len(a) == 1
        let a = g:cssTailwindColorAliases[a]
    endif
    if len(b) == 1
        let b = b * 100
    endif
    let value = DictGetter2(g:cssTailwindColorRef, a, b)
    if empty(value)
        ec ['error', a, b, 'not in g:cssTailwindColorRef']
        return 
    endif
    let t = '%s /* %s-%s */'
    return printf(t, value, a, b)
endfunction
function CssPmwh(s)
    let s = a:s
    let unit = 'px'
    let unit = 'pt'
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
    elseif key == 'escape'
        let g:s = ''
    elseif key == '0'
        if empty(g:s)
            let g:s .= '0.'
        else
            let g:s .= key
        endif
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
    if Test(t, '^-?\d[0-9.]*$')
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
        elseif n <= 0
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
    return MarkdownNormalQW()
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

    return MarkdownNormalQE()
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
    let file = !IsFile(a:file) ? Npath('2024', a:file) : a:file
    return json_decode(s:joinlines(readfile(file)))
endfunction

function! s:joinlines(s)
    if s:isstring(a:s)
        return a:s
    endif
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
    " inside of vim ... you should only touch vim files
    " auto updating the import files typescript does
    if has_key(g:globalAliases, k)
        let s = s:gval(g:globalAliases[k])
        call OpenFunction(s)
    elseif has_key(g:gfgfdict, k)
        let [file, fnName, getMethod] = g:gfgfdict[k]
        call OpenBuffer3(file)
        call OpenFunction(fnName, getMethod)
    elseif has_key(g:execRef2, k)
        let [file, fnName] = ['/home/kdog3682/.vimrc', g:execRef2[k]]
        call OpenBuffer3(file)
        call OpenFunction(fnName)
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

  if c == "\<ScrollWheelUp>" || c == "\<ScrollWheelDown>"
      return -1
  endif
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
        ec s
        call input('')
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

function! HasShellError(block)
    let block = a:block
    if s:t(block[-1], '^node.js')
        return 1
    endif
endfunction
function! EvaluateFromShell(shell, file, ...)
    let shell = a:shell
    let file = a:file
    let items = map(Flat(a:000), "ShellEscape(Stringify(v:val))")
    call insert(items, file)
    call insert(items, shell)
    let s = join(items, ' ')
    let result = systemlist(s)
    let block = map(result, 's:sub(v:val, ''\\\\'', ''\\'')')
    " call input(block[0])
    return block
endfunction

function! s:evaljs(file, ...)
    let block = EvaluateFromShell('node', a:file, a:000)
    if empty(block)
        ec 'the block == empty...'
        return 
    endif

    if s:t(block[-1], '^node.js')
        ec s:tostring(block)
        return 
    endif
    return block

endfunction

function! s:evalpy(file, ...)
    return EvaluateFromShell('python3', a:file, a:000)
endfunction


function! SetNormalQTFunction()
    
endfunction
function! s:node_or_python(file, ...)
    let file = a:file
    let e = GetExtension(file)
    if e == 'js'
        return s:node(file, a:000)
    elseif e == 'py'
        return s:python(file, a:000)
    endif
endfunction
function! s:node(...)
    let cmd = join(s:flat('!clear; node', a:000), ' ')
    if g:debug =~ 'javascript'
        ec 'yoyoyonotatm'
        return 
        let m = systemlist(cmd)
        call JavascriptErrorHandler(m)
    else
        ec cmd
        execute cmd
    endif
endfunction
function! s:python(...)
    let action = 'python3'
    if g:flags.use_mypy_flag
        let action = 'mypy'
    endif
    let cmd = join(s:flat('!clear;', action, a:000), ' ')
    if g:flags.use_system_flag
        let m = systemlist(cmd)
        call JavascriptErrorHandler(m)
    else
        ec cmd
        execute cmd
    endif
endfunction

function! s:jsvimeval(key, ...)
    let key = a:key
    let moreArgs = a:0 >= 1 ? a:000 : '/home/kdog3682/2024/temp.txt'
    return s:evaljs('vimConnector.js', key, moreArgs)
endfunction

function! Node0(key = 0, controlKey= 0)
    """"""""""""""""""""""""""""""""""""""""
    " let value = s:evaljs('node-utils.js', '/home/kdog3682/2024/temp.txt')
    " let value = s:jsvimeval('parseVerbose')
    """"""""""""""""""""""""""""""""""""""""
    """"""""""""""""""""""""""""""""""""""""
    let ref = RefFromTailOrLang('node0')
    if s:exists(ref)
        call Node0Handler(ref)
    endif
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
    if &filetype == 'css'
        return GISmartBlockFTCss()
    endif

    if &filetype == 'text'
        return GISmartBlockFTText()
    endif
    let i = line('.')
    let s = getline(i)
    let m = Match(s, '^\S+')
    if Exists(m)
        if m == '//'
            let up = s:fli('^' . m, i, -1, 100, 1, 1)
            let down = s:fli('^' . m, i, 1, 100, 1, 1)
            return [up, down]
        endif

        if Test(m, '------')
            let down = FindLineIndex('------', line('.') + 1, 1)
            return [i, down]
        endif
        let r = '^(async|class|const|var|def|function)>'
        if Test(m, r)
            return GetCodeIndexes()
        else
            return [i, s:fli('^\S', '.', 1, 500, 0)]
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
    call s:myappend(i, s:indent(a:s, s:get_smart_spaces('.')))
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
function! s:comment(s, ...)
    let s = a:s
    if IsArray(s)
        return s:joinlines(map(s, 's:comment(v:val)'))
    endif
    let p = a:0 >= 1 ? a:1 : s:jspy('commentPrefix')
    if s:t(a:s, '^' . p)
        return a:s
    endif
    return p . ' ' . a:s
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
    let state = s:getvimstate('file', 'binding', 'timestamp')
    let mark = s:comment(s:string({'bookmarkId': state.timestamp, 'type': 'hfl'}))
    call s:appendbelow(mark)
    call s:appendfile(g:hfelfile, s:string(state))
    " {"type":"hfl","bookmarkId":"1700688624"}
endfunction

function! s:read(a)
    let a = a:a
    let a = s:npath('/home/kdog3682/2024/', a)
    return readfile(a)
endfunction
function! s:writefile(a, b)
    let a = a:a
    let b = a:b
    let a = s:smartnpath(a)
    if !IsFile(a)
        call LogCreateTime(a, 'files.log')
    endif
    call s:write(a, b, 'w')
endfunction


function! s:appendfile(a, b)
    let a = a:a
    let b = a:b
    let a = s:smartnpath(a)
    if !IsFile(a)
        call s:log_file_creation_time(a)
    endif
    call s:write(a, b, 'a')
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
function! Todo(...)
    let s = a:0 >= 1 ? a:1 : 'type: ticket'
    let t = CreateBookmarkID(s)
    ec t
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

function! GetBackupFile()
    let file = '/home/kdog3682/.temp.txt'
    return file
    " call OpenBuffer3(file)
    " let f = g:budir . 'vimrc' . DateStamp()
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


function! s:ufa(s, r)
    let s = s:joinlines(a:s)
    let r = "%(^|\n)" . a:r
    return sort(s:unique(s:findall(s, r)))
endfunction

function! s:get_javascript_function_words()
        if empty(g:javascript)
            let t = s:read('/home/kdog3682/2023/utils.js')
            let r = 'function \zs\w+'
            let g:javascript = s:ufa(t, r) + ['javascript', 'python']
        endif
        return g:javascript
endfunction
function! LoadLibraryItems()
    if &filetype == 'javascript' || g:debug
        throw ''
        let javascript = 'javascript.json'
    endif

    if &filetype == 'vim'
        if empty(g:vim)
            ec 'loading the vim library'
            let g:vim = s:read('vim.json')
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

function! Choose100(elements)
    return s:choose(a:elements)
endfunction
function! s:choose(elements, ...)
    let display = a:0 >= 1 ? a:1 : 0
    if s:exists(display)
        ec 'aaa displa'
        let display = map(copy(a:elements), {i,x -> x[display]})
        if empty(display)
            return
        endif
        let index = s:chooseindex(display)
        return a:elements[index]
    endif
    let elements = a:elements
    if IsObject(elements)
        let elements = items(elements)
    endif
    try
        return Choose2023(elements)
    catch
        return 
        throw ''
    endtry
    if empty(elements)
        return
    elseif len(elements) == 1
        return elements[0]
    endif

    let s:i = 0
    function! s:make(elements, n)
        let elements = a:elements
        let n = a:n
        if s:i < 0
            let s:i = 0
        endif
        let a = s:i * 10
        let b = s:min(elements, a + 10 - 1)
        let c = b - 11
        let s:i += n
        if c < 0
            let c = 0
            let b = 10-1
        endif

        return elements[c:b]
    endfunction

    function! s:get(ref)
        redraw
        call BlueList(a:ref)
        return s:getchar()
    endfunction

    let c = 0
    let ref = s:make(elements, 0)
    while c < 100
        let c += 1
        let a = s:get(ref)
        if a == g:keyboard.left
            let ref = s:make(elements, -1)
        elseif a == g:keyboard.right || a == g:keyboard.space
            let ref = s:make(elements, 1)
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
function! Sdjfsdjf()
    let items = ['aaa']
    return s:find(items, {s -> s == 'aaa'})
endfunction
function! s:find(items, ...)
    let items = a:items
    let s:F = s:testf(a:1)
    let backwards = a:0 >= 2 ? 1 : 0
    if backwards
        for i in range(len(items) - 1, 0, -1)
            let item = items[i]
            if s:F(item)
                return item
            endif
        endfor
    endif
    for item in items
        if s:F(item)
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
let g:GI4Ref['start_to_end'] = 'Get_Start_to_end_Indexes'
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


function! s:match(...)
    let s= ''
    let r = ''
    if a:0 >= 2
        let s = a:1
        let r = a:2
    else
        let r= a:1
        let s= getline('.')
    endif
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
function! s:get_smart_spaces(...)
    let s = s:linegetter(a:000)
    let spaces=  matchstr(s, '^ *')
    if s:t(s, '\{$')
        return spaces . '    '
    endif
    return spaces
endfunction
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

function! s:fli(x, start, increment, threshold, anti, ...)
    let start = s:ig(a:start)
    let allowStart = a:0 >= 1 && s:exists(a:1) ? 1 : 0
    let skipNewlines = a:0 >= 2 && s:exists(a:2) ? 1 : 0
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
        if skipNewlines && empty(trim(line))
            let i += increment
            continue
        endif
        if anti
            if !X(line)
                let value = i - increment
                if allowStart
                    return value
                endif
                if value != start
                    return value
                endif
            endif
        else
            if X(line)
                if allowStart
                    return i
                endif
                if i != start
                    return i
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
    let m=  s:match(s, r)
    if s:exists(m)
        return m
    endif
    let m=  s:match(s, '\[.{-}\]')
    if s:exists(m)
        return m
    endif
    let m = s:match(s, '\(\zs.{-}\ze\)')
    if s:exists(m)
        return '[' . m . ']'
    endif
    throw 'could not find a match at getiden'
    
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
    " call input('lines: ' . s:string(lines))

    if flags =~ 'd'
        call deletebufline('%', a, b)
    endif
    return lines
endfunction

function! GIContiguous()
    " let a = s:getspaces()
    let s = getline('.')
    let fw = s:match(s, '^ *\S+')
    let r = '^' . s:rescape(fw) . '[ \[]'
    let up = s:fli(r, '.', -1, 100, 1, 1)
    let down = s:fli(r, '.', 1, 100, 1, 1)
    return [up, down]
endfunction
function! s:gi(s, ...)
    " test: "code"
    if a:0 >= 1
       let [indexes, flag] = GetVisualIndexes('flag')
       if empty(flag)
           return indexes
       else
           let fnKey = g:GI4Ref[a:s]
           return function(fnKey)()
       endif
   else
       if s:llvf(a:s)
           return function(a:s)()
       endif
       return function(g:GI4Ref[a:s])()
       let [c,d] = GetVisualIndexes()
       let [a,b] = function(g:GI4Ref[a:s])()
       " call input('[c,d]: ' . s:string([c,d]))
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
    let store = []
    let t = s:t(a:s, a:r)
    call substitute(a:s, '\v' . a:r, '\=add(store, Exists(submatch(1)) ? submatch(1) : submatch(0))', 'g')
    return store
endfunction
function! s:sds(s)
    " test: ""
    let s = a:s
    if IsArray(s)
        return s
    endif
    let s = trim(s)
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
let g:jspyref3['vim']['echoInputTemplate'] = "call InputPrompt('$1', $1)"
let g:jspyref3['python']['echoInputTemplate'] = "prompt('$1', $1)"




function! s:indent(s, ...)
    let isa = IsArray(a:s)
    let s = s:tolines(a:s)
    let n = a:0 >= 1 ? a:1 : 4
    let spaces = s:tospaces(n)
    let value = map(s, {i,x->spaces . x })
    " call BlueInput('value: ' . string(value))
    return isa ? value : s:tostring(value)
    " return
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
function! s:print(...)
    if a:0 >= 2
        let a = a:1
        let b = s:encode(a:2)
        call s:blue(printf('[%s]: %s', a, b))
    else
        ec s:string(a:1)
        return a:1
    endif
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


function! s:templater(t, arg) abort
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

let g:jspyref3['vim']['echoLogThrowTemplate'] = "ec $1"
let g:jspyref3['python']['echoLogThrowTemplate'] = 'b'
let g:jspyref3['javascript']['echoLogThrowTemplate'] = 'console.log($1); throw "$1"'

let g:jspyref3['vim']['echoLogTemplate'] = "ec $1"
let g:jspyref3['python']['echoLogTemplate'] = 'b'
let g:jspyref3['javascript']['echoLogTemplate'] = 'console.log($1)'

let g:jspyref3['vim']['echoReturnTemplate'] = "return s:print($1)"
let g:jspyref3['python']['echoReturnTemplate'] = 'return $1'
let g:jspyref3['javascript']['echoReturnTemplate'] = 'return $1'



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
    let [a,b] = s:so()(x, '/')
        if Exists(value)
            return value
        endif
        let value = Npath(a, b)
endfunction
function! FileFromLine(s)
    let s = a:s
    return s:match(s, g:fileRE)
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
let g:jspyref3['markdown']['blockenterre'] = '.'
let g:jspyref3['markdown']['blockexit'] = '.'

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
function! Asdfsss()
    ec 'a'
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
        let indent_size = s:jspy('indent_size')
        let data['enter'] = enter
        let data['indent_size'] = indent_size
        let data['exit'] = exit
    endif
    return data
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
    while c < 80
        if Test(s[start], '\w')
            let start += 1
        else
            break
        endif
    endwhile

    let a = start - 1
    let c = 0
    let temp = ''
    while c < 100
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
    while c < 100
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
    let ref = {
    	\'g:cabmap': '/home/kdog3682/.vim/ftplugin/css-data.vim',
    \}
    let file = get(ref, name, '/home/kdog3682/.vimrc')
    let keys = a:000

    let ref = {}
    let start = ''
    try
        let ref = eval(name)
    catch
        let cmd = printf('let %s = {}', name)
        execute cmd
        let start .= "\n" . cmd
        let ref = eval(name)
    endtry

    let length = len(keys)
    let o = []

    for i in range(length - 1)
        let key = keys[i]
        if i == length - 2
            let name .= printf('["%s"]', key)
            let value = keys[i + 1]
            if s:isstring(value)
                 let value = EscapeString(value)
                 let ref[key] = value 
            else
                 let ref[key] = value 
            endif
            let pvalue = s:string(value)
            call add(o, printf('let %s = %s', name, pvalue))
            let s = join(o, "\n")
            execute s
            call AppendFile(file, start . s)
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

function! PythonExtract(...)
    let s:store = []
    function! s:inner(s)
        let s = a:s
        call add(s:store, s)
        return ''
    endfunction
    let key = a:0 >= 1 ? a:1 : 'callable'
    let ref = {
        \'callable': '^\w+\(.+',
        \'comment': '^#.+',
    \}
    try
        let r = ref[key]
        call s:global_replace('%', r, '\=s:inner(submatch(0))', 'gc')
        if empty(s:store)
            return 
        endif
        call s:appendfile(g:pacfile, s:store)
        call s:open(g:pacfile)
    catch
        ec v:exception
    endtry
endfunction
let g:pacfile = '/home/kdog3682/PYTHON/pac.txt'
function! s:global_replace(range, regex, replacement, flags)
    let range = a:range
    let regex = a:regex
    let Replacement = a:replacement
    let flags = a:flags
    if IsArray(range)
        let range = join(range, ',')
    elseif IsObject(range)
        let range = range.start . ',' . range.end
    elseif s:isword(range) && len(range) > 1
        let range = s:gi(range)
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
    if empty(items)
        return {}
    endif
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
    return s:is_primitive(x) ? x : json_encode(x)
endfunction

function! s:is_primitive(s)
    let s = a:s
    return s:is_string(s) || s:is_number(s)
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
    let items = split(trim(s))
    let key = 0
    let unmap = 0
    let buffer = ''
    for i in range(len(items))
        let item = items[i]
        if i == 0
            try
                let unmap = g:unmapDict[item]
            catch
                let error = v:exception
                return 0
            endtry
        else
            if s:t(item, '\<(silent|expr|buffer)')
                if s:t(item, 'buffer')
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
    try
        execute t
        ec 'unmap success: ' . t
        return 1
    catch
        let error = v:exception
        ec 'unmap error: ' . error
        return 0
    endtry
endfunction
function! Sdfkjsdjfk()
    ec s:redir('verbose nnoremap')
endfunction
function! s:redir(key)
    " test: 'verbose <buffer> nnoremap \\'
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
function! GlobalReplaceController(...)
    let range = '%'
    let args = a:0 >= 1 ? ForceSplit(a:1) : []
    let flags = 'gc'
    let regex = s:gcw()
    if s:exists(args)
        let [regex, replacement] = args
    elseif s:exists(g:yanks)
        let [regex, replacement] = s:get_yanks()
    elseif len(regex) < 5
        let regex = s:prompt('regex?')
        let replacement = s:prompt('replacement?')
    else
        let strings = s:page('<' . regex[0:3] . '\w+')
        let replacement = s:pick(strings)
        if s:exists(replacement)
            let replacement = s:prompt('replacement?')
        endif
    endif
    call s:global_replace(range, regex, replacement, flags)
endfunction
let g:execRef["dtb"] = "Appdefinetempnormalmapping"



function! CommandTilda()
    " return sort(keys(g:wpsnippets.vim))
    " let a = g:wpsnippets["vim"]["ifo"]
    " return a

    try
        let v = CommandTildaItemGetter(g:CommandTildaRef)
        if empty(v)
            let v = CommandTildaItemGetter(g:execRef2)
        endif
        return v
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
        " call append('$', k)
        " throw 's'
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
let g:visualactiondict['shunt-code'] = {'fn': 'VShunt', 'i': 'code', 'arg': 'd', 'outpath': '/home/kdog3682/2023/shunt.txt'}


function! VShunt3(...)
    let arg = a:0 >= 1 ? a:1 : ''
    let fileName = FileGetter2(arg)
    let lines = s:getlines("smart", 'd')
    call s:appendfile(fileName, lines)
endfunction
function! VShunt2(state)
    let state = a:state
    let file = s:exists(state.arg) ? state.arg : s:getlinkedfile()
    let file = AddExtension2(file, 'js')
    call s:appendfile(file, state.lines)
endfunction

let g:shuntFileRef = {
    \'examples.js': {'arg': 'd', 'outpath': '/home/kdog3682/2023/runExampleFile.js', 'template': '$1'},
    \'functions2.vim': {'open': 1, 'arg': 'd', 'outpath': '/home/kdog3682/.vimrc', 'template': '$1'},
\}
function! VFileShunt(state)
    let state = a:state
    
endfunction
function! VShunt(state)
    let state = a:state
    let shuntState = get(g:shuntFileRef, Tail(), '')
    if s:exists(shuntState)
        let state = extend(copy(state), shuntState)
    endif
    if state.arg =~ 'd'
        call DeleteBlock(state.indexes)
    endif
    let t = "datetime: $datetime\nsource: $cf\ntext:\n$1\n$hr"
    if s:exists(state.template)
        let t = state.template
    endif
    let val = s:templater2(t, state.string)
    let open = s:exists(shuntState) && get(shuntState, 'open', '')
    if s:exists(open)
        call OpenBuffer3(state.outpath)
        call append('$', '')
        call s:appendblock(val, '$')
    else
        call s:appendfile(state.outpath, val)
    endif
    
endfunction
" help i_CTRL-N
vnoremap h :<c-u>call VAction('VShunt')<CR>
vnoremap j :<c-u>call VAction('shunt-code')<CR>

function! SetOverrideExecution()
    let b:overrideExecutionString = g:overrideExecutionString
    ec 'let b:overrideExecutionString = ' . g:overrideExecutionString
endfunction
function! VJavascriptConnector(state)
    let state = a:state
    if len(state.lines) < 2
        return 
    endif

    let fnKey = state.arg
    let o = s:javascript_via_vim(fnKey, state.lines, state.file)
    " ec o
    " return
    if has_key(o, "success")
        if has_key(o, 'value')
            return s:replaceblock(state.indexes, o.value, state.indentation)
        else
            ec 'success!'
            return 
        endif
    endif

    ec o
    ec 'failed'
    ec state.text
    return 
    if empty(block)
        return 
    endif

    return s:replaceblock(state.indexes, block, state.indentation)
endfunction

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
    " test: '\\', 'nmap <buffer>'
    
    let key = a:key
    let maptype = a:0 >= 1 ? a:1 : 'map'
    let key = printf('verbose %s %s', maptype, key)
    let t = s:redir(key)
    " call input('t: ' . s:string(t))
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
    return s:setblock(s:tabs_to_spaces(s:unescapespace(a:s)))
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
        let target = s:match(state.prev, '\w{3,}\ze +[=|}]|[a-z0-9-_]{3,}\ze[''":]')
        " call input('target: ' . s:string(target))
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
function! s:datestamp2()
    return strftime('%Y-%m-%d')
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

function! VApplyTemplaterEffectToBlock(state)
    let state = a:state
    let t = s:t(state.arg, 'v:val') ? state.arg :  's:templater2(state.arg, v:val)'
    let value = map(state.lines, t)
    call s:replaceblock(state.indexes, value)
endfunction

function! VApplyEvalEffect(state)
    let state = a:state
    let t = state.arg
    let t = join(map(split(t), 's:cap(v:val)'), '')
    call s:gsr(F, t)
endfunction
let g:visualactiondict['e'] = {'fn': 'VApplyEvalEffect'}
function! s:abrev(s)
    let s = a:s
    return Abrev(s)
endfunction
function! RegisterFileDict(...)
    let file = CurrentFile()
    let key = a:0 >= 1 ? a:1 : s:abrev(file)
    let t = 'let g:filedict["$1"] = "$file"'
    call s:append_and_execute(s:templater2(t, key))
endfunction
function! DefineDictionaryController(s = '')
    let items = s:xsplit(a:s)
    if s:exists(items)
        call FlatCall('DictSetter', 'g:jspyref3', &filetype, items)
        return 
    endif
    if template == 'equaldict'
        let key = s:prompt('key?')
        let s = getline('.')
        let [replaceWith, value] = s:match(s, '(\w+) *\= *(.+)')
        let val = {'replaceWith': replaceWith, 'value': value}
        call DictSetter('g:jspyref3', &filetype, 'equalDict', key, val)
        return 
    endif
    let template = s:choose(g:defineDictionaryTemplates)
    silent redraw!
    let s = VT(template, items)
    " call DefineDictItem(s)
    " return
    call AppendAndExecute(s)

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


function! VMove(state)
    let state = a:state
    let arg = state.arg
    let i = -1
    let start = line('.')
    let lines = s:getlines(state.indexes, 'd')
    if empty(arg)
        call append('$', lines)
        return 
    endif

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

    if !exists('b:shuntFile')
        let b:shuntFile = s:prompt('shunt destination?')
    endif
    return b:shuntFile
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
    let t = map(s:tolines(s:read('bookmarks.txt')), 'json_decode(v:val)')
    let a = s:choose(t)
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
function! GetLibraryItem(...)
    let key = a:0 >= 1 && s:exists(a:1) ? a:1 : s:gcw()
    let r = CreateRE(key)
    call input('r: ' . s:string(r))
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
    let lines = map(state.lines, 's:templater2(state.arg, trim(v:val))')
    call s:replaceblock(state.indexes, lines)
    
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


function! GetMappings()
    let state = s:bigask("
        \\n maptype: nnoremap | inoremap | iabbrev | cnoremap
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

function! GotoMapCommand(...)
    " test: "ec"
    let base = a:0 >= 1 ? SeeMappings(a:1)[0] : GetMappings()
    if empty(base)
        ec 'no mappings for the given key'
        return 
    endif
    for [k,v] in items(base)
        for item in v
            return s:open(k, item)
        endfor
    endfor
endfunction
function! s:open(file, ...)
    let file = a:file
    let x = a:0 >= 1 ? a:1 : ''
    let movement = a:0 >= 2 ? a:2 : ''
    let cfile = CurrentFile()
    normal! m'
    call OpenBuffer3(file)
    if empty(x)
        return
    elseif IsNumber(x) && len(x) < 10 || x == "$"
        call Jump(x)
    else
        try
            call ExecuteRegex(x)
            execute "normal! zt"
        catch
            let error = v:exception
            ec error
            call OpenBuffer3(cfile)
        endtry
    endif
endfunction
function! UnmapController(...)
    let base = a:0 >= 1 ? a:1 : GetMappings()
    if s:isstring(base)
        let base = GetMappings()
    endif
    let s:acc = []
    function! s:inner(file, lines)
        let file = a:file
        let lines = a:lines
        	let bufnr = BufLoad(file)
            for line in lines
                let t = s:getbufline(bufnr, line)
                if s:exists(trim(t)) && s:confirm(t) && s:unmap(t)
                    call s:push(s:acc, t)
                    ec 'unmapped: ' . t
                    call setbufline(bufnr, line, s:comment(t, '"'))
                    redraw!
                else
                    ec 'skipped: ' . t
                endif
            endfor
    endfunction
    for [file, lines] in items(base) 
        call s:inner(file, lines)
    endfor
    silent! wa
    return s:acc
endfunction
let g:execRef["umc"] = "UnmapController"
function! s:bigask(s)
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
        let [i, pos] = s:fli(s.enter, s.exit, '.', -1, 20, 0)
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

" inoremap <silent> <buffer> qw <ESC>:call NormalQW()<CR>
" nnoremap <silent> <buffer> qw :call NormalQW()<CR>
" inoremap <silent> <buffer> qe <ESC>:call NormalQE()<CR>
" nnoremap <silent> <buffer> qe :call NormalQE()<CR>
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
        let [exit, enter] = s:fli(s.exit, s.exit, '.', -1, 20, 0)
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
        let [exit, enter] = s:fli(s.exit, s.exit, '.', -1, 20, 0)
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

function! UnmapFast(s)
    let [flags, items] = s:sosall(a:s)
    let store = []
    let imap = flags =~ 'i'
    let nmap = flags =~ 'n'
    for item in items
        if nmap
            call add(store, 'nunmap <buffer> ' . item)
            call add(store, 'nunmap ' . item)
        endif

        if imap
            call add(store, 'iunmap <buffer> ' . item)
            call add(store, 'iunmap ' . item)
        endif
    endfor
    for item in store
        try
            execute item
            ec item
        catch
        endtry
    endfor
endfunction
function! SetMarkdownQW()
    let t = "nnoremap <buffer> $1 :call $2()<CR>"
    let t .= "\n"
    let t .= "inoremap <buffer> $1 <ESC>:call $2()<CR>"

    let items = [
        \['qw', 'MarkdownNormalQW'],
        \['qe', 'MarkdownNormalQE'],
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

    " let items = [
        " \['er', 'MarkdownNormalQW'],
        " \['et', 'MarkdownNormalQE'],
    " \]

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

function! s:smart_dedent(s)
    let s = a:s
    let f = 's:sub(v:val, "^" . spaces, "", "")'

    if IsArray(s)
        let spaces = s:getspaces(s[0])
        return map(s, f)
    endif

    let spaces = s:getspaces(s)
    return map(s:tolines(s), f)
endfunction

function! SnippetConverter(s)
    let s = a:s
    let s = s:smartdedent(s)
    let s = Sub(s, '\d+-\d+-\d+', '${DateStamp()}')
    let s = Sub(s, '\d{8,}', "${strftime('%s')}")
    if s:exists(g:yanks)
        let yanks = s:get_yanks()
        for i in range(len(yanks))
            let item = yanks[i]
            let s = s:sub(s, item, '$' . (i + 1))
        endfor
    endif
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
    let value = s:redir('verbose map')
    call Clip(value)
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
let g:GI4Ref["aboveCursor"] = "AboveCursorIndexes"
let g:GI4Ref["matchingSpaces"] = "MatchingSpacesIndexes"
let g:wpsnippets2["javascript"]["ifgn1"] = "if ($1 > -1) {\n    $c\n}"
let g:vimCurrentTestFunction = "JPCreateFunctionBlockAsExpression"
let g:execRef["hfl"] = "MarkAsHighFrequencyLine"
let g:vimFunctionAliases["file"] = "CurrentFile"
let g:vimFunctionAliases["prevbuffer"] = "PrevFile"
let g:vimFunctionAliases["file"] = "CurrentFile"
let g:vimFunctionAliases["head"] = "Head"
let g:vimFunctionAliases["currentFile"] = "CurrentFile"
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
function! CreateBookmark(o)
    let o = a:o
    let ref = s:getvimstate('file', 'binding', 'timestamp')
    call extend(ref, o)
    call s:appendfile(g:bookmarkfile, s:encode(ref))
    call s:setbookmark(ref.timestamp)
endfunction
let g:visualactiondict['VNote'] = {'fn': 'VNote', 'i': 'line'}
vnoremap n :<c-u>call VAction('VNote')<CR>
function! ChooseFileRefFile()
    return s:tail(bufname('#'))
    " return 'examples.js'
    " return s:choose(s:months)
    let keys = keys(g:fileRef)
    return s:choose(keys)
endfunction
let g:vimFunctionAliases['binding'] = 'GetBindingName'
let g:vimFunctionAliases['cb'] = 'GetBindingName'
let g:vimFunctionAliases['fileRefFile'] = 'ChooseFileRefFile'
let g:vimFunctionAliases['bindingFromAnywhere'] = 'GetBindingFromAnywhere'
let g:vimFunctionAliases['fileBasedIdentifier'] = 'GetFileBasedIdentifier'
let g:vimFunctionAliases['promptName'] = 'GetPromptName'
let g:vimFunctionAliases['promptKey'] = 'GetPromptKey'
let g:vimFunctionAliases['filetype'] = 's:get_file_type'
let g:vimFunctionAliases['ft'] = 's:get_file_type'
let g:vimFunctionAliases['timestamp'] = 'Timestamp'
let g:vimFunctionAliases['line'] = 'GetCurrentLine'
let g:vimFunctionAliases['line'] = 'GetCurrentLine'
let g:vimFunctionAliases['file'] = 'CurrentFile'
let g:vimFunctionAliases['upiden'] = 'GetUpIden'
let g:vimFunctionAliases['cw'] = 'GetCurrentWord'
let g:vimFunctionAliases['time'] = 'GetTime'
let g:vimFunctionAliases['clockTime'] = 'GetTime'
let g:vimFunctionAliases['hr'] = 'GetHR'
let g:vimFunctionAliases['main'] = 'GetMainFunctionBlock'
function! GetMainFunctionBlock()
    return s:jspy('mainFunctionBlockTemplate')
endfunction
let g:jspyref3["vim"]["mainFunctionBlockTemplate"] = "function Main(s)\n\t\nendfunction"
let g:jspyref3["python"]["mainFunctionBlockTemplate"] = "def main(s)\n\t"
let g:jspyref3["javascript"]["mainFunctionBlockTemplate"] = "function main(s) {\n\t\n}"
function! GetHR()
    return repeat('-', g:hr_line_length)
endfunction
function! GetTime()
    return strftime('%m-%d-%Y %I:%M%p')
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
    if empty(params)
        return params
    endif
    
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
function! s:get_file_type(...)
    " test: "asd.js.vimrc.py"
    let ref = {
    	\'js': 'javascript',
    	\'py': 'python',
    	\'vue': 'vue',
    	\'vim': 'vim',
    	\'vimrc': 'vim',
    	\'txf': 'txflow',
    	\'css': 'css',
    	\'html': 'html',
    	\'md': 'markdown',
    	\'typ': 'typst',
    	\'raw': 'raw',
    \}
    if a:0 >= 1
        let e = s:ge(a:1)
        if e== '' && Test(a:1, '.vimrc')
            return 'vim'
        endif
        if e== 'raw' && Test(a:1, 'vue.raw')
            return 'vue'
        endif
        return get(ref, a:1, get(ref, e, e))
    endif
    return &filetype
endfunction
let g:execRef["gft"] = "s:get_file_type"
function! ResetCompletionTrigger()
    let b:lastCompletionTrigger = ''
endfunction
function! Sdfsd0f()
    return s:so('a')
endfunction
function! DefineLanguageSpecificExecRefItem(...)
    " if &filetype != "vim"
        " call DictSetter('g:jspyref3', &filetype, 'execFunctions', k, v)
    " endif
    let s = a:0 >= 1 ? a:1 : ''
    let [k,v] = DefineEatHelper(s)
    let filetype = 'javascript'
    if s:t(v, 'css')
        let filetype = 'css'
    elseif s:t(v, 'md|markdown')
        let filetype = 'markdown'
    elseif s:t(v, 'html')
        let filetype = 'html'
    endif
    call DictSetter('g:jspyref3', filetype, 'execFunctions', k, v)
endfunction
function! CreateLezerArgSection()
    let snippet = "datetime: $datetime\nlang: $ask\ncode:\n\nfunction main(node, getText) {\n\t$c\n}\n"
    call s:create_section_from_snippet(snippet)
endfunction

function! CreateArgSection()
    let snippet = "datetime: $datetime\narg:\n$c\n\ncode:\n\n$main"
    call s:create_section_from_snippet(snippet)
endfunction
function! s:create_section_from_snippet(s, ...)
    let ref = {
        \'@dialogue': "speaker:\n\n$c\n",
        \'@markdown': "# $1::untitled:\n\n$c\n",
    \}

    let s = get(ref, a:s, a:s)
    let snippet = s:templater2("\n$hr\n" . s, a:000)
    call s:scrolltobottom()
    call s:setblock(snippet)
endfunction

function! CreateExampleJsSection(...)
    let arg = a:0 >= 1 ? a:1 : ''
    let prefix = 'j'
    if arg == 'cb'
        let prefix = 'jarg'

    elseif arg == 'cw'
        let prefix = 'jarg2'
    endif

    let s = prefix . ' ' . s:sub(arg, ' ', '_')
    let snippet = GetSnippet(s)
    if empty(snippet)
        ec 'no snippet'
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
let g:jspyref3["vim"]["execFunctions"]["gft"] = 's:get_file_type'

let g:jspyref3["dialogue"] = {}
let g:jspyref3["dialogue"]["execFunctions"] = {}
let g:jspyref3["dialogue"]["execFunctions"]["dr"] = 'DialogueReplace'

function! CreateBinding(a, b, ...)
    let a = a:a
    let b = a:b
    if empty(a)
        let a = 'temp'
    endif
    let vim = a:0 >= 1 ? a:1 : 0
    let prefix = s:jspy('prefix')
    if vim
        let prefix = 'let '
        if !s:t(a, 'g:')
            let a = 'g:' . a
        endif
    endif
    return prefix . a . ' = ' . s:string(b)
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
    let dir = get(g:dirdict, a:dir, a:dir)
    let file = a:file
    return s:pathjoin(dir, Tail(file))
endfunction

function! s:replace_current_line(r, rep)
    call s:get_set_line({s -> s:sub(s, a:r, a:rep) })
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
let g:ffrfilebig='/home/kdog3682/2024/ffr.json'
let g:ffrfile='/home/kdog3682/2024/ffr-simple.json'
" let g:ffrfile='/home/kdog3682/2024/ffr-simple.json'
function! OpenFileOpenFunction(key)
    let key = a:key
    let s:key = a:key
    let json = s:read(g:ffrfile)
    function! s:inner(s)
        let s = a:s
        return s:some(a:s.contents, {y -> y == s:key})
    endfunction
    let file = s:find(json, function('s:inner'), 1)
    if s:exists(file)
        call OpenBuffer3(file.name)
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
let g:execRef["mvi"] = "MoveStuffIn"
let g:execRef["mvo"] = "MoveStuffOut"


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
        let r = '\((\S.{-})\)|\[(\S.{-})\]|\{ *(\S.{-}) *\}'
    endif
        " call BlueInput('r: ' . string(r))
    let m = s:match(s, r)
    if s:exists(m)
        return s:smallify(m)
        " call BlueInput(': ' . string(m))
        return m
    endif
endfunction
function! s:reset(k, ...)
    let k = a:k
    let reset = a:0 >= 1 ? a:1 : ''
    let value = eval(k)
    let t = CreateBinding(k, reset, 1)
    ec t
    execute t
    return value
endfunction
function! LogIt(...)
    let yanks = s:reset('g:yanks', [])
    let key = a:0 >= 1 ? a:1 : 'log'
    let template = s:jspy(key . 'Template')
    if s:exists(yanks)
        let yanks = join(yanks, ', ')
        let value = s:templater(template, yanks)
        call append('.', s:tospaces(s:getsmartindent()) . value)
        return 
    endif
    let s = getline('.')
    let value = s:getidenstr(s)
    if s:exists(value)
        let value = s:templater(template, value)
        call append('.', s:tospaces(s:getsmartindent()) . value)
    endif
endfunction

let g:jspyref3['vim']['logTemplate'] = 'call s:red("$1", $1)'
let g:jspyref3['python']['logTemplate'] = 'red("$1", $1)'
let g:jspyref3['javascript']['logTemplate'] = 'console.log({$1})'
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
            if a == 'this'
            return printf('(%s) =>', 'x')
            endif
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
        call setline(a.index, s:toggle_comment(a.text))
        call setline(b.index, s:toggle_comment(b.text))
    elseif c.comment
        call setline(c.index, s:toggle_comment(c.text))
        call setline(b.index, s:toggle_comment(b.text))
    else
        call setline(b.index, s:toggle_comment(b.text))
        call setline(c.index, s:toggle_comment(c.text))
    endif
    return store
endfunction

function! s:toggle_comment(s)
    let s = a:s
    let m = trim(s:jspy('commentPrefix'))
    if empty(m)
        return &filetype == 'css' ? s:css_comment(s) : s:html_comment(s)
    endif
    if empty(s)
        return s
    endif
    return s:t(s, '^' . m) ? s:replace(s, m . ' *', '') : m . ' ' . s
endfunction
let g:activeJavascriptFile = "/home/kdog3682/2023/examples.js"

function! RunActiveFile()
    call Node(g:activeJavascriptFile)
endfunction
function! Node3()
    return Node1({"node3": 1})
    if s:jspy_normal_runner()
        return 
    endif
endfunction
function! OldNode2()
    if exists('g:tempcommands') && has_key(g:tempcommands, '2')
        return function(g:tempcommands['2'])()
    endif
    if s:jspy_normal_runner("node2")
        return 
    endif
    return s:node_or_python(bufname('#'))
    return s:node(bufname('#'))
    return RunExampleFile()
    return Node(g:activeJavascriptFile)
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
let g:wpsnippets2["global"]["list"] = "WPGList"
let g:wpsnippets2["global"]["aa"] = "WPGAAList"
let g:wpsnippets2["global"]["dict"] = "WPGDict"
let g:vimCurrentTestFunction = "SmartEqual"

function! Exi()
    let up = s:fli('^code:', '.', -1, 500, 0) + 1
    let down = s:fli('^-{10,}', '.', 1, 500, 0) - 1
    let s = s:tostring(s:getlines(up, down))

endfunction
let g:activeJavascriptFile = "/home/kdog3682/2023/markdownParser.js"

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

    let r = s:jspy('functionLineRE')
    let i = s:fli(r, '.', -1, 500, 0, 1)
    return i
    let start = s:search(r, 'bnW', 500)
    if empty(start)
        throw 'No Function Index Match @ GetFunctionIndex'
    endif
    return start
endfunction
function! s:search(r, flags, distance)
    let r = a:r
    let flags = a:flags
    let distance = a:distance
    let k = flags =~ 'b' ? -1 : 1
    let stopLine = max([0, distance == 'w0' ? line(distance) : line('.') + k * distance])
    return search(r, flags, stopLine)
endfunction
let g:jspyref3["vim"]["functionLineRE"] = "^function!? +\\w"
let g:jspyref3["python"]["functionLineRE"] = "^(def|class) +\\w"
let g:jspyref3["javascript"]["functionLineRE"] = "^(const|class|(async )?function\\*?) +\\w"

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
let g:wpsnippets2["javascript"]["switch"] = "WPSwitch"
let g:wpsnippets2["vim"]["dict"] = "WPDict"



function! Snippeteer(...)
    " let w = WordBeforeCursor()
    let s = a:0 >= 1 ? a:1 : getline('.')
    let snippet = GetSnippet(s)
    if empty(snippet)
        ec 'no snippet'
        return 
    endif
    let g:last_wp_snippet_input = s
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
    let s:items = a:0 >= 1 ? s:isobject(a:1) ? a:1 : s:coercearray(a:1) : []
    if empty(t)
        return s:items[0]
    endif
    let r =  '( *)\$%((\w+)|\{(.{-})\})'

    function! s:bracket(s)
        let rep = '\=string(s:get(submatch(1)))'
        let t = s:sub(a:s, '\$(\w+)', rep)
        return eval(t)
    endfunction

    function! s:get(key)
        let  templater_dict = {
            \'cr': "\<cr>",
        \}
        let key = a:key
        if key == 'c' || key== 'cursor'
            return '$c'
        " elseif key == 'encoded'
            " return s:items[key - 1]
        elseif has_key(templater_dict, key)
            return templater_dict[key]
        elseif has_key(g:dirdict, key)
            return s:replace(g:dirdict[key], "/$", "")
        elseif key == 'ask' || key == "prompt"
            let val  = s:prompt(g:prompt_message . ': ')
            let g:prompt_message = 'asking a value'
            return val
        elseif has_key(g:vimFunctionAliases, key)
            return s:encode(function(g:vimFunctionAliases[key])())
        elseif IsNumber(key)
            return s:items[key - 1]
        elseif has_key(s:items, key)
            return s:items[key]
        else
            let smthwrong = key
            call input('smthwrong the key is not present: ' . s:string(smthwrong))
            return 'smthwrng'
        endif
    endfunction
    function! s:inner(s)
        let spaces = a:s[1]
        let key = a:s[2]
        let bracket = a:s[3]
        let percent = a:s[4]
        let value = s:exists(bracket) ? s:bracket(bracket) : s:get(key)
        let v = s:tostring(s:smartindent(value, spaces))
        return v
    endfunction
    return s:sub(t, r, function('s:inner'))
endfunction
function! SnippetFromObject(o, s)
    let o = a:o
    let items = s:sds(a:s)
    let type = get(o, 'type', 'default')
    " call BlueInput('type: ' . string(type))

    if type == "template" || has_key(o, 'template')
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
    let spaces = 4
    if &filetype == 'typst'
        let spaces = 2
        let wrap = ['(', ')']
    endif
    let spaces = repeat(' ', spaces)
    " call BlueInput('i: ' . string(items))
    let k = s:count(template, '\%s')
    let n = (len(items) - 1) / k
    let t = s:jspy('prefix') . '%s = ' . wrap[0]
    let lc = s:jspy('lineContinuationMarker')
    let newline = "\n"
    for i in range(n)
        let t .= newline . spaces . lc . template . ','
    endfor
    let t .= newline . lc . wrap[1]
    return Printf(t, items)
endfunction

let g:jspyref3['vim']['lineContinuationMarker'] = "\\"
let g:jspyref3['python']['lineContinuationMarker'] = ""
let g:jspyref3['javascript']['lineContinuationMarker'] = ""
let g:execRef["eea"] = "ExtractExpressionToAboveLine"

function! WPGDict(s)
    " test: "a b c d e"
    let t2 = '''%s'': %s'
    let t1 = '''%s'': ''%s'''
    let wrap = ['{', '}']
    if &filetype == 'typst'
        let t2 = '%s: ''%s'''
    endif
    return WPPrintTemplate(a:s, wrap, t2, t1)
endfunction

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
    let match = a:0 >= 1 
        \ ? s:find(json, {x-> s:some(x.contents, {y-> y == key})})
        \ : s:find(json, {x-> s:some(x.contents, {y-> s:t(y, key)})})
    if s:exists(match)
        let file = match.name
        call OpenBuffer3(file)
        if !OpenFunction(key) && dots
            call ExecuteRegex(key)
        endif
        return 
    endif
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
let g:wpsnippets2["global"]["wami"] = {'template': "type: whereami\ntime: $clockTime\nnote: ", 'type': 'note'}

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
let g:execRef2["gs"] = "GoogleSearch"
call add(g:bookmarks, {"id":"1697910374-.vimrc-GoFile","note":"let val = eval(m)\ntodo","mark":"D"})


""" bookmarkId: 1701971629 hfel: defineDictionaryTemplates """
let g:defineDictionaryTemplates = [
    \'let g:filedict["$promptName"] = "$file"',
    \'commentPrefix',
    \'equaldict',
    \'let g:jspyref3["$filetype"]["$1"] = "$2"',
    \"let g:CommandTildaRef['$promptName'] = '$binding'",
    \'let g:wpsnippets2["global"]["$promptName"] = "$binding"',
    \'let g:wpsnippets2["javascript"]["$promptName"] = "$binding"',
    \'let g:fileRef["$fileRefFile"]["execRef"]["$promptKey"] = "$binding"',
    \'let g:wpsnippets2["$filetype"]["$promptName"] = "$binding"',
    \'let g:GI4Ref["$promptName"] = "$binding"',
    \'let g:vimFunctionAliases["$promptName"] = "$binding"',
    \'let g:jspyref3["$promptName"] = "$binding"',
    \'call add(g:lineEditCommands, "$binding")',
    \'call add(g:lineEditCommands2, "$binding")',
    \'call add(g:normalCommands, "$binding")',
    \'nnoremap $prompt :call OpenBuffer4("$file")<CR>',
    \'nnoremap $prompt :call OpenBuffer4("$file")<CR>',
\]

let g:apae_map_templates = {
    \'ibe': "nnoremap <silent> <buffer> <expr> %s %s()<CR>",
    \'nbe': "nnoremap <silent> <buffer> <expr> %s %s()<CR>",
    \'nnoremap': "nnoremap <silent> <buffer>%s :call %s()<CR>",
    \'nmap': "nnoremap %s :call %s()<CR>",
    \'imap': "nnoremap <silent> <buffer>%s %s()<CR>",
    \'inoremap': "inoremap <silent> <buffer> <expr> %s %s()",
    \'no': "nnoremap <buffer>%s :call %s()<CR>",
    \'va': "let g:visualactiondict['%s'] = {'fn': '%s', 'i': 'smart'}",
\}
    " \'equaldict',
    " \'inoremap expression function',
    " \'inoremap expression function',
    " \'inoremap expression function',
    " \'inoreab',


let g:lineEditCommands = [
    \'SwapQuotes',
    \'JSObjVar',
    \'JSCreateVar',
    \'VimSilent',
    \'SeeTheReturnValue',
\]
function! s:split_screen_choose(s)
    let s = a:s
    let store = [[]]
    for i in range(len(s))
        let item = s[i]
        if i % 8 == 0
            call add(store, [])
        endif
        call add(store[-1], item)
    endfor
    
endfunction
let g:normalCommands = []
function! s:register_override_node_file()
    let file = CurrentFile()
    let s:config['use_override_node_file'] = 1
    let g:override_node_file = file
    ec 'setting g:override_node_file: ' . file
endfunction
function! NormalCommandController2()
    let cmd = s:choose(g:normalCommands)
    if empty(cmd)
        return 
    endif
    redraw!
    call function(cmd)()
endfunction

function! NormalCommandController()
    let commands = s:unique(values(g:execRef2))
    let cmd = s:choose(commands)
    call function(cmd)()
endfunction
function! GlobalStringReplace(a, b)
    let a = a:a
    let b = a:b
    let r = s:sub(a, '\(\)', '\\(\\)')
    call s:global_replace('%', r, b, 'g')
endfunction
function! LineEditController()
    let s = getline('.')
    for item in g:line_edit_invivo_items
        let m = s:match(s, item.regex)
        if s:exists(m)
            call s:deleteline()
            " call setline('.', '')
            call call(function(item.fn), s:coercearray(m))
            return 
        endif
    endfor
    let cmd = s:choose(g:lineEditCommands2)
    if s:llvf(cmd)
        try
            call s:getsetline(cmd)
        catch
            let error = v:exception
            if s:t(error, 'Too many Arguments')
                return function(cmd)()
            endif
            ec error
        endtry
    else
        ec cmd
        execute cmd
        " return eval(cmd)
    endif
endfunction
let g:execRef["le"] = "LineEditController"
function! GetPromptKey()
    let abrev = Abrev(GetBindingName())
    let abrev = s:prompt('choose a key for the command', abrev)
    return abrev
endfunction

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
     \ ";": "semi",
     \ "}": "rcb",
     \ "{": "lcb",
     \ "<": "lt",
     \ ">": "gt",
     \ "*": "star",
     \ "%": "percent",
     \ "$": "dollar",
     \ '\': "backslash",
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
let g:gfgfdict['efs'] = ['/home/kdog3682/.vimrc', 'EvaluateFromShell', 0]

let g:activeJavascriptFile = "/home/kdog3682/2023/lazyObjectParser.js"

let g:execRef2["gpf"] = "GitPushCurrentFile"

let g:execRef2["gmc"] = "GotoMapCommand"
let g:execRef2["gtm"] = "GotoMapCommand"
function! SetActiveBash()
    let g:bashfile = '/home/kdog3682/.bash_aliases'
    let s = printf('alias san="vim %s"', g:activeJavascriptFile)
    call AppendFile(g:bashfile, s)
endfunction
let g:execRef["sab"] = "SetActiveBash"

function! VShuntController()
    let lang = &filetype
    let shuntFile = s:get_file_ref('shuntFile')

    if s:exists(shuntFile)
        ""save before hand
        let lines = s:getlines('code', 'd')
        call s:appendfile(shuntFile, lines)
        return 
    endif

    if empty(lang)
        let file = s:sub(s:tail(), '\d+-\d+-\d+$', '')
        " call input('file: ' . s:string(file))
        let ref = g:shuntBackRef
        if has_key(ref, file)
            let indexes = s:get_up_down_indexes(ref[file].regexes)
            let lines = s:getlines(indexes)
            call s:open(file)
            call append(line('$') - 1, lines)
        endif
        return 
    endif
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
let g:activeJavascriptFile = "/home/kdog3682/2023/markdownParser.js"
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

nnoremap dib :call DeleteInnerBlock()<CR>
let g:templines = []
function! DeleteInnerBlock()
    let g:templines = s:getlines('smart', 'd')
    let @" = s:tostring(g:templines)
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
    call input('a: ' . s:string(a))
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

let g:execRef2["sqw"] = "SetMarkdownQW"
let g:wpsnippets["js"]["css"] = "InitiateJavascriptCSS"

function! s:ex(s)
    let s = a:s
    ec s
    execute s
endfunction
function! ResetFileType()
    let alteredFiletype = b:alteredFiletype
    let b:alteredFiletype = ''
    call s:ex("setlocal filetype=" . alteredFiletype)
endfunction
function! InitiateJavascriptCSS(...)
    let b:alteredFiletype = s:get_file_type()
    setlocal filetype=css
    return "@css {\n    $c\n}"
endfunction


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
    let file = s:smartnpath(a:file)
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
        let @"=s:tostring(s:get_yanks())
    else
        nnoremap <buffer> f :call SaveDel()<CR>
    endif
endfunction
let g:execRef["tsd"] = "TempSaveDel"

set nowrap


function! s:findbufline(file, r)
    let file = a:file
    let r = a:r
    let lines = readfile(FileGetter2(file))
    return s:buffer_fli(lines, r, 1, 1)
endfunction
function! A8Word(sourceDest) abort
    let startingFile = CurrentFile()
    let sourceDest = FileGetter2(a:sourceDest)
    let sourceDest = s:tail(sourceDest)
    " call input('sourceDest: ' . s:string(sourceDest))
    let bindingName = s:gcw()

    let a8file = s:get_file_ref('a8file')
    call InputPrompt('a8file', a8file)
    call OpenBuffer(a8file)
    call AddImport2(bindingName, sourceDest)
    call OpenBuffer(startingFile)
endfunction
function! s:wrap_lines(lines)
    let lines = a:lines
    call insert(lines, '', 0)
    call add(lines, '')
    return lines
endfunction
function! A8(sourceDest) abort
    let startingFile = CurrentFile()
    if s:t(startingFile, 'template.js')
        let sourceDest = 'next2.js'
        let bindingName = GetBindingName()
        let lines = s:getlines('code', 'd')
        call OpenBuffer(sourceDest)
        call AddExport(bindingName)
        call append('$', s:wrap_lines(lines))
        call OpenBuffer(startingFile)
        return 
    endif
    let sourceDest = a:sourceDest
    " call InputPrompt('sourceDest', sourceDest)
    " let sourceDest = s:tail(sourceDest)
    let bindingName = GetBindingName()

    let a8file = s:get_file_ref('a8file')

    let lines = s:getlines('code', 'd')
    call OpenBuffer(sourceDest)
    call AddExport(bindingName)
    call insert(lines, '', 0)
    call append('$', lines)
    if s:exists(a8file)
        call OpenBuffer(a8file)
        call AddImport2(bindingName, sourceDest)
        call OpenBuffer(startingFile)
    else
        call OpenBuffer(startingFile)
        call AddImport2(bindingName, sourceDest)
    endif
endfunction



let g:filedict["dia"] = "/home/kdog3682/2023/dialogue3.js"

let g:jspyref3["javascript"]["execFunctions"] = {}
function! SetEJSOutpath(s)
    let s = a:s
    let i = s:fli('^\w+:', '.', -1, 100, 0) - 1
    call s:myappend(i, s:colon('outpath', FileGetter2(s)))
endfunction

function! SetEJSInpath(s)
    let s = a:s
    let i = s:fli('^\w+:', '.', -1, 100, 0) - 1
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
let g:wpsnippets2["javascript"]["jarg2"] = "--------------------------------------------------------------\npure: 1\ndate: ${DateStamp()}\nnote: function test for $cw\narg:\nabcde\ncode:\n\nfunction main(s) {\n    const value = $1(s)\n    console.log(value)\n$c\n}\n"
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
let g:execRef2["speaker"] = "SpeakerStuff"
let g:execRef2["temp"] = "Checkfresh"
let g:runnerParamCache["child.iterate"] = "node"


function! WPCopyBlock()
    
endfunction
let g:visualactiondict['sbc'] = {'fn': 'VShunt', 'outpath': '/home/kdog3682/2023/shunt.txt', 'i': 'belowCursor'}


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
let s:touched = 0
function! JSOnCompleteDone()
    if s:touched
        let s:touched = 0
    else
        return 
    endif
    let el = v:completed_item
    if !has_key(el, 'word')
        return 
    endif
    let outpath = s:templater2('$filetype-completions.txt')
    call s:delayed_write(outpath, el.word)
endfunction
function! s:delayed_write(outpath, s)
    let outpath = a:outpath
    let s = a:s
    if !exists('b:list')
        let b:list = []
    endif
    call add(b:list, s)
    if len(b:list) == 3 
        silent call s:appendfile(outpath, b:list)
        let b:list = []
    endif
endfunction
let g:completionTracker = []
function! OnCompleteDone()
    let el = v:completed_item
    if has_key(el, 'word')
        call add(g:completionTracker, [b:lastCompletionTrigger, el.word])
        if len(g:completionTracker) == 10
            silent call s:appendfile('completionTracker.txt', g:completionTracker)
        	let g:completionTracker = []
        endif
        let b:lastCompletionTrigger = ''
    endif
endfunction
function! SeeCompletionTracker()
    ec g:completionTracker
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
let g:vimrcfile = '/home/kdog3682/.vimrc'
function! GoVimFunction(key)
    call OpenBuffer3(g:vimrcfile)
    let store = s:global_g(a:key)
    let a = s:choose(store)
    call Jump(a.lineNumber)
    normal! zt
endfunction
function! s:global_g(r)
    " test: "gfs"
    let p = getpos('.')
    let store = []
    let r = g:functionPrefixRE . CreateCompletionRE(a:r)
    let t = "g/\\v%s/call add(store, GetLineInfo())"
    execute printf(t, r)
    call setpos(".", p)
    return store
endfunction
function! CssShiftArrowLeft()
    return CssIncrement(-1)
endfunction

function! CssShiftArrowRight()
    return CssIncrement(1)
endfunction
function! CssOmniIncrement(dir)
    if s:issol()
        call GetSetFn('CssSolIncrement')
    else
        return CssIncrement(a:dir)
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
inoremap <expr> 4 PumExpr4()
inoremap <expr> 5 PumExpr(5)
inoremap <expr> 6 PumExpr(6)
inoremap <expr> 7 PumExpr(7)
inoremap <expr> 8 PumExpr(8)
" inoremap <buffer> <expr> <space> PumSpace()
function! MDPumExpr(s)
    let s = a:s
    if s == 'zero'
        return pumvisible() ? g:keyboard.esc . 'A ' :  '0'
    endif

    if s == 'esc'
        return pumvisible() ? g:keyboard.esc . 'a ' :  g:keyboard.esc
    endif

    if s == '-'
        return pumvisible() ? g:keyboard.enter . '-' :  MarkdownDash()
    endif

    if s == 'space'
        return pumvisible() ? g:keyboard.enter . ' ' :  MarkdownSpace()
    endif
    let down = repeat(g:keyboard.down, s - 1)
    return pumvisible() ? down . g:keyboard.enter . ' ' : s
endfunction
function! PumSpace()
    return pumvisible() ? g:keyboard.enter . ' ' :  ' '
endfunction

function! PumExpr(n)
    let n = a:n
    let down = repeat(g:keyboard.down, n - 1)
    " call input('down: ' . s:string(down))
    return pumvisible() ? down . g:keyboard.enter : n
endfunction

function! PumExpr4()
    let n = 4
    let down = repeat(g:keyboard.down, n - 1)
    return pumvisible() ? down . g:keyboard.enter : '$'
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
    let ignoreIndex = 0
    if s:exists(s:b) && s:exists(trim(s:b[0]))
        let ignoreIndex = line('.') 
    endif
    " let s:exists(trim(s:b[0]))
    " let sb = s:exists(s:b) ? s:get_word(s:b) : 0

    for i in range(wmin, wmax)
        if i == ignoreIndex
            continue
        endif
        let s = getline(i)
        let m = s:findall(s, r)
        if s:exists(m)
            let ind = abs(index - i)
            for item in m
                if s:in(seen, item) || len(item) <= 2 || s:exists(ignore) && s:in(ignore, item)
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
let g:jspyref3["markdown"]["reservedKeywords"] = []



let g:jspyref3["vim"]["commonFunctionWords"] = ['Transform', 'string']
let g:jspyref3["python"]["commonFunctionWordAtoms"] = ""
let g:jspyref3["javascript"]["commonFunctionWords"] = ""
let g:execRef2["gr"] = "GlobalReplaceController"
" inoremap <silent> <buffer> <expr> 4 '$'
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

function! CssWriteBlock()
    let [spaces, line] = GetSpacesAndLine()
    if s:exists(spaces)
        call s:deleteline()
        call s:scrolltobottom()
    endif
    let ref = [s:uncomment(line)]
    " call input('ref: ' . s:string(ref))
    let template = "$1 {\n    $c\n}"
    let t = s:templater2(template, ref)
    call s:setblock(t, '.', 0, 0)
endfunction

function! CssEnter()
    let i = line('.')
    if Test(getline(i + 1), '\*\*\*')
        return g:keyboard.enter
    endif
    let s = getline(i)
    let [a,b] = s:ab()
    if s:exists(b)
        return g:keyboard.enter
    endif
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
        return g:keyboard.enter . ';'
        return g:keyboard.eol . ';' . "\<CR>"
    endif

    let store = ParsedCssItems(t, '')
    if empty(store)
        return BackspaceExpr(t)
    endif
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
    if empty(s)
        return 
    endif
    if &filetype == 'vim'
        execute "h " . s
        return 
    endif

    let lines = readfile('/home/kdog3682/2024/function-notes.txt')
    let index = s:find_index(lines, 'function: *' . s)
    if index > -1
        """ bookmarkId: 1701724044 hfel: todo ... find_index fn """
        
    endif

endfunction
let g:execRef2["h"] = "GetHelp"

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
    " lazyObjectParser
    let r = CreateCompletionRE('lop')
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
    if s:t(a, '\\|\<|\^')
        return a
    endif
    if empty(a)
        return '\w{3,}'
    elseif len(a) == 1
        return a . '[$a-z0-9._-]{3,}'
    elseif s:t(a, '\.')
        let [a,b] = s:split(a, '\.')
        let r = s:ccc(b)
        return s:ddd(a) . r
    elseif len(a) > 3
        return a . '[$a-z0-9._-]{1,}'
    else
        let template = '\C(%s|%s)'
        return CreateComplicatedCompletionRE(a, template)
    endif
    
endfunction


let g:typst_function_words = []

function! GetCompletionWords(key)
    let r = CreateCompletionRE(a:key)
    let store = WordSpiraler('<' . r . '>', a:key)
    let locals = s:get_local_words(r) 
    return s:unique(store + locals)
endfunction

function! WordSpiraler(r, key = 0)
    let r = a:r
    let key = a:key
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
    for i in range(len(indexes))
        let indexSet = indexes[i]
        let store = WordSpiral(r, index, indexSet, seen)
        if s:exists(store)
            let s:indexSetIndex = i
            return store
        endif
    endfor
    return []
endfunction
function! s:ccc(s)
    " test: "ci"
    let letters = SplitSingles(toupper(a:s))
    let length = len(letters)
    let ignore = '[^a-zA-Z0-9 ]'
    let ignore = '[-_.]{1,2}'
    
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
        elseif i == 0
            let out .= '[a-zA-Z-_0-9]{1,}'
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
    let rest = '[-_a-z0-9]'
    let out2 .= printf('%s{%s,}', rest, 4 - length)
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
let g:textCompletionItems = [
    \{ 'a': '^\s*$', 'value': "\<TAB>"},
    \{ 'a': '/([a-z])+$', 'source': 'g:dir2023'},
    \{ 'a': '[a-z]+$', 'fn': 'GetCompletionWords'},
\]

function! LocalCompletion(s)
    return GetCompletionWords(a:s)
endfunction
let g:stylusCompletionItems = [
    \{ 'a': '^\s*$', 'value': "\<TAB>"},
    \{ 'a': '[a-z]+$', 'fn': 'StylusWordSpiralCompletion'},
\]

let g:pythonCompletionItems = [
    \{ 'a': '^\s*$', 'value': "\<TAB>"},
    \{ 'a': '[a-z]+$', 'fn': 'LocalCompletion'},
    \{ 'a': '[a-z]+$', 'sourceFunction': 's:get_python_identifiers'},
\]
let g:grammarCompletionItems = [
    \{ 'a': '^\s*$', 'value': "\<TAB>"},
    \{ 'a': '[a-z]+$', 'fn': 'GenericWordSpiralCompletion'},
\]
let g:javascriptCompletionItems = [
    \{ 'a': '^\/*\s*$', 'value': "\<TAB>"},
    \{ 'a': 'r:[a-z]+$', 'fn': 's:regex_completion'},
    \{ 'a': 'f?:[a-z]+$', 'fn': 'JavascriptFarawayFunctionCompletion'},
    \{ 'a': '[a-z]+$', 'fn': 'JavascriptWordSpiralCompletion'},
\]
    " \{ 'a': '/[a-z]+$', 'fn': 'JavascriptFileCompletion'},
    " \{ 'a': '^[a-z]+$', 'fn': 'JavascriptSOLCompletion'},
    " \{ 'a': '[a-z]+$', 'b': '^\w+', 'fn': 'WrapCompletion'},

let g:markdownCompletionItems2 = [
    \{ 'a': '%(^| \zs)[a-z]+$', 'fn': 'MarkdownSpaceCompletion'},
\]

let g:vimCompletionItems2 = g:markdownCompletionItems2

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
    if has_key(wrappers, a)
        return wrappers[a] . ParenExpr(b)
    endif

    let r = CreateCompletionRE(a)
    return GetCompletionWords(a) + DefaultWords(r) 
endfunction
    
function! s:ab()
    let s = getline('.')
    let pos = col('.') - 1
    let a = strpart(s, 0, pos)
    let b = strpart(s, pos)
    return [a,b]
    
endfunction
function! s:get_last(x)
    let x = a:x
    return x[len(x) - 1]
endfunction
function! QQQ()
    let [a,b] = s:ab()
    let s:b = b
    let before = s:get_last(a)
    let after = b[0]
    let t = trim(a)
    " if s:t(t, '^/') && s:t(a, '\S$')
        " return BackspaceExpr(t) . CRCompletion(GetCompletionFiles(t[1:]))
    " endif
    " call input(json_encode({"a": a, "b": b}))
    " /old
    " call input(json_encode({"before": before, "after": after}))
    " /old
    if before == "\"" && after == before
        return  CRCompletion(WordSpiraler('"\zs.{-}\ze"'))
    endif
    let completions = s:jspy('qqqCompletionItems')
    if empty(completions)
        let completions = g:defaultCompletionItems
    endif
    " call input('completions: ' . s:string(completions))
    for item in completions
        if has_key(item, 'value')
            if s:t(a, item.a)
                return item.value
            endif
            continue
        endif

        let ha = has_key(item, 'a')
        let hb = has_key(item, 'b')
        let x = s:match(a, item.a)
        let y = hb ? s:match(b, item.b) : 0
        if hb && empty(y)
            continue
        endif
        if empty(x) 
            continue
        endif
        let backspaces = BackspaceExpr(x)

        let value = has_key(item, 'source')
            \ ? s:fuzzyfind(eval(item.source), x)
            \ : has_key(item, 'sourceFunction')
            \ ? s:fuzzyfind(function(item.sourceFunction)(), x)
            \ : s:isarray(x)
            \ ? call(function(item.fn), x)
            \ : hb
            \ ? function(item.fn)(x, y)
            \ : function(item.fn)(x)

        if s:isnumber(value) && value == -1
            continue
        elseif s:isstring(value) && value == ' '
            return ' '
        elseif s:isarray(value)
            if empty(value)
                continue
            endif
            let value = CRCompletion(value)
        endif
        return backspaces . value
    endfor
    return ''
endfunction
function! BackspaceExpr(s)
    let s = a:s
    return s:exists(s) ? repeat(g:keyboard.bs, len(s)) : ''
endfunction
function! CRExpr(s)
    return "\<C-R>=" . a:s . '()' . "\<CR>"
endfunction
function! s:mget(s, r)
    let s = a:s
    let r = a:r
    return MGet(s, r)
endfunction
function! CssCompletion(s)
    let s = a:s

    let r = CreateCompletionRE(s)
    let locals =  matchfuzzy(g:css_local_phrases, s)[0:5]
    let store = WordSpiraler('<' . r . '>') + locals
    if s:exists(store)
        return store
    endif
    return 'no match'
    
endfunction
function! VimVarCompletion(s)
    let [a,b] = split(a:s, '\v:')

    let r = CreateCompletionRE(b)
    let er = '<' . a . ':' . r . '>'
    let store = WordSpiraler(er)
    if s:exists(store)
        if s:indexSetIndex > 0 && len(store) == 1
            let r = er
            if a == 's'
                let r = "\n" . 'function!? \zss:' . CreateCompletionRE(b)
            elseif a == 'g'
                let r = "\n" . '\zsg:\w+'
            endif
            
        endif
        return store
    endif
    let r = er
    if a == 's'
        let r = "\n" . 'function!? \zss:' . CreateCompletionRE(b)
    elseif a == 'g'
        let r = "\n" . '\zsg:\w+'
    endif
    return GlobalTextSearch(r)
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

function! s:get_completion_words(items, key, ...)
    " test: "ffr",  'gw'
    let items = a:items
    if s:isstring(items)
        if items == 'library'
            if &filetype == 'javascript'
                try
                    let items = s:get_javascript_function_words()
                catch
                    let error = v:exception
                    ec error
                    return []
                endtry
            elseif &filetype == 'vim'
                let items = LibraryWords()
            endif
        elseif items == 'ffr'
            let items = GetFFRWords()
        elseif items == 'library'
            let items = LibraryWords()
        endif
    endif
    let key = a:key
    let p = a:0 >= 1 ? a:1 : '^'
    let r = s:t(key, '\\C') ? key : p . CreateCompletionRE(key)
    let items = s:regexfilter(items, r)
    return items
    if len(items) > g:pumheight - 1
        return [s:abc_choose(items)]
    endif
    return items[0: g:pumheight - 1]
endfunction
function! JavascriptWordSpiralCompletion(key)
    let r = CreateCompletionRE(a:key)

    let a = WordSpiraler('<' . r . '>')
    if empty(a)
        let a = s:get_completion_words('library', a:key, '^') 
    endif
    if empty(a)
        let a = GlobalTextSearch(a:key)
    endif
    let locals = s:get_local_words(r) + GetLocalFunctionWords()
    return s:unique(a + locals)
endfunction



function! WordSpiralCompletion(key)
    let a = GetCompletionWords(a:key)
    if empty(a)
        let a = s:get_completion_words('library', a:key, '^')
    endif
    if empty(a)
        let a = GlobalTextSearch(a:key)
    endif
    return a
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

function! CssDashCompletion(s)
    let r = a:s . '[-a-z0-9]+'
    return GlobalTextSearch(r)
    return WordSpiraler(r)
endfunction
function! CssColorCompletion(s)
    let s = a:s
    return CssColorTransform(s) . ';'
    
endfunction
function! CssVarCompletion(s)
    return WordSpiraler('var\(.{-}\)')
endfunction
function! CssWordSpiralCompletion(s)
    let r = CreateCompletionRE(a:s)
    return WordSpiraler(r)
endfunction
let g:cssCompletionItems  = [
    \{"a":"^\\s*$","value":"\t"},
    \{"a":"^\\.\\w*$","fn":"CssDotCompletion"},
    \{"a":"--\\w*$","fn":"CssDashCompletion"},
    \{"a":": *\\zs[a-z]\\d$","fn":"CssColorCompletion"},
    \{"a":"^ *\\zs[a-z]+$","fn":"CssCompletion"},
    \{"a":"[a-z]+$","fn":"CssWordSpiralCompletion"},
\]

let g:defaultCompletionItems  = [
    \{"a":"^\\s*$","value":"\t"},
    \{"a":"[a-z]+$","fn":"WordSpiralCompletion"}
\]

let g:vimCompletionItems  = [
    \{"a":"^\\s*$","value":"\t"},
    \{"a":"<[a-z]:[a-z]+$","fn":"VimVarCompletion"},
    \{"a":"[a-z]+$","b":"^\\w+","fn":"WrapCompletion"},
    \{"a":"[a-z]+$","fn":"WordSpiralCompletion"}
\]
let g:jspyref3["css"]["qqqCompletionItems"] = g:cssCompletionItems
let g:jspyref3["vim"]["qqqCompletionItems"] = g:vimCompletionItems
let g:jspyref3["vim"]["qqqqCompletionItems"] = g:vimCompletionItems2
let g:jspyref3["markdown"]["qqqqCompletionItems"] = g:markdownCompletionItems2
let g:jspyref3["python"]["qqqCompletionItems"] = g:pythonCompletionItems
let g:jspyref3["javascript"]["qqqCompletionItems"] = g:javascriptCompletionItems
let g:jspyref3["markdown"]["qqqCompletionItems"] = g:markdownCompletionItems
let g:gfgfdict['q'] = ['/home/kdog3682/.vimrc', 'QQQ', 0]
function! LibraryWords()
    return []
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
" /usr/share/vim/vim82/ftplugin/javascript.vim
let a = "/usr/share/vim/vim82/ftplugin/"
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
    let items = s:regexfilter2(g:markdownCompletionWords, key)
    if s:exists(items)
        let s:stop = 1
        return items
    else
        return ' '
    endif
endfunction
let g:runnerParamCache["return"] = "item"

let g:explorerExecRef = {}
" function! s:mapdir(dirs, r)
    " let dirs = a:dirs
    " let r = a:r
" endfunction
function! ExplorerController(...)
    let keys = s:unique(values(g:dirdict))
    let dir = s:fuzzy(keys)
    let g:netrwdir = dir
    execute 'Explore ' . dir
endfunction

let g:execRef2["e"] = "ExplorerController"
function! Netrwdir()
    let current_netrw_dir = expand('<sfile>:p:h')
    return current_netrw_dir
endfunction

function! CopyFileToSelectedDirectory()
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
function! s:abspath(s)
    " test: "vimrc"
    let s = a:s
    return fnamemodify(s, ':p')
endfunction
function! s:tail(s)
    let s = a:s
    return fnamemodify(s, ':t')
endfunction

function! s:ge(s)
    let s = a:s
    return fnamemodify(s, ':e')
endfunction

function! Directories()
    let dir = s:unique(map(values(g:filedict), 's:head(v:val)'))
    let dir = filter(dir, 's:t(v:val, "^/") && s:isdir(v:val)')
    call append('$', CreateBinding('g:directories', dir))
endfunction
let g:directories = ['/home/kdog3682/latest-git-cloned-repo', "/home/kdog3682", "/home/kdog3682/2023","/home/kdog3682/.vim/ftplugin","/home/kdog3682/PYTHON","/home/kdog3682/.npm-global/lib/node_modules/@lezer/markdown/dist","/home/kdog3682","/home/kdog3682/2023/node_modules/@lezer/python/src","/home/kdog3682/2024","/mnt/chromeos/MyFiles/Downloads","/home/kdog3682/.vim/autoload","/home/kdog3682/RESOURCES","/mnt/chromeos/GoogleDrive/MyDrive/JSONS","/home/kdog3682/2023/node_modules/@lezer/javascript/src","/home/kdog3682/2023/node_modules"]
let g:execRef2["ctf"] = "CopyFileToSelectedDirectory"
" let g:netrw_list_hide= '\(^\|\s\s\)\zs\.\S\+'
" let g:netrw_list_hide= '\v\(^\|\s\s\)\zs\.\S\+'
let g:netrw_list_hide= ''


function! s:createaliases(items)
    let items = a:items
    let items = s:months
    let items = g:directories
    let store = {}
    for i in range(len(items))
        let item = items[i]
        let key = s:prompt(item)
        if !s:exists(key)
            continue
        endif
        let store[key] = item
    endfor
    call s:appendbinding(s:prompt('name'), store)
endfunction
function! s:appendbinding(name, val)
    let name = a:name
    let val = a:val
    call append('$', CreateBinding(name, val))
endfunction
function! s:copy_file(a, b)
    let cmd = printf('cp %s %s', a:a, a:b)
    ec cmd
    call system(cmd)
endfunction
function! Sdkj0()
    " /home/kdog3682/.vim/ftplugin/vimrc.vim
    let outpath = g:ftplugindir . 'vimrc.vim'
    call s:copy_file("/home/kdog3682/.vimrc", outpath)
endfunction
function! GitPushDirectories()

    let outpath = g:ftplugindir . 'vimrc.vim'
    " call s:copy_file("/home/kdog3682/.vimrc", outpath)

    let keys = [ "24", "23", "py", "ftp", ]
    let keys = ['2024-typst']
    for key in keys
        call GitPushDirectory(key)
    endfor
endfunction
function! GitResetCache(key)
    " test: 2024
  let dir = s:get_dir(a:key)
  let result = s:system_cmd("
        \\n cd %s
        \\n git rm -r --cached prosemirror-math
        \\n git commit -m 'resetting git cache'
        \\n git push
  \", dir)
  ec result
endfunction

function! Testingbash()
    
endfunction
function! GitPushDirectory(key)
  let key = a:key
  let dir = IsDir(key) ? key : get(g:directoryaliases, key, '/home/kdog3682/' . key)
  let result = s:system_cmd("
        \\n cd %s
        \\n git add .
        \\n git commit -m 'pushing directory'
        \\n git push
  \", dir)

  if s:t(result, 'nothing to commit')
      let result = s:system_cmd("
        \\n cd %s
        \\n git push
      \", dir)
  endif
  ec 'pushing directory: ' . dir
  call s:appendfile('git-logs.txt', result)
endfunction
function! s:system_cmd(s, ...)
  let s = a:s
  let cmd = s:printf2(s, a:000)
  let cmd = s:joinlines(s:split(cmd, '\n *'))
  call s:blue(s:colon('running git command', cmd))
  let result = systemlist(cmd)
  return trim(s:joinlines(result))
endfunction

function! s:printf2(s, ...)
    " test: "asdf%s ", 1
    let s = a:s
    let s:args = s:flat(a:000)
    function! s:inner(s)
        return remove(s:args, 0)
    endfunction
    return s:sub(s, '\%s', function('s:inner'))
endfunction

let g:execRef2["gpd"] = "GitPushDirectory"
function! s:oneclickprompt(s, fallback)
    let s = a:s
    let fallback = a:fallback
    ec ''
    ec s
    ec ''

    let c = 0
    let out = ''
    while c < 20
        let c += 1
        let k = s:getchar()
        if IsNumber(k) && c == 1
            return k
        elseif k== 'z'
            return fallback
        elseif k== g:keyboard.bs
            let out = out[:-2]
            ec string(out)
        elseif k== g:keyboard.enter
            return out
        else
            let out .= k
            ec string(out)
        endif
    endwhile
endfunction
let g:directoryaliases = {"res":"/home/kdog3682/RESOURCES","py":"/home/kdog3682/PYTHON","ftp":"/home/kdog3682/.vim/ftplugin","23":"/home/kdog3682/2023","24":"/home/kdog3682/2024"}


function! GetLastPushTime()
    let file = s:gitpath()
    let dir = s:head(file)

  let cmd = s:system_cmd("
        \\n cd %s
        \\n git log --pretty=format:%at -- %s
  \", dir, file)
  ec 'last pushed'
  ec strftime('%c', cmd)
  return cmd
endfunction

function! s:gitpath()
  let path = expand('%:p')
  if path == '/home/kdog3682/.vimrc'
      let path = g:ftplugindir . 'vimrc.vim'
  endif
  return path
endfunction
let g:execRef2["gt"] = "GetLastPushTime"


" /home/kdog3682/.vim/ftplugin/python.vim
let g:markdownProseCompletionWords = [
  \"able",
  \"i",
  \"a",
  \"to",
  \"for",
  \"you",
  \"about",
  \"again",
  \"almost",
  \"alone",
  \"already",
  \"also",
  \"always",
  \"another",
  \"become",
  \"before",
  \"being",
  \"below",
  \"better",
  \"both",
  \"called",
  \"care",
  \"careful",
  \"carefully",
  \"carry",
  \"case",
  \"certain",
  \"change",
  \"changes",
  \"chapter",
  \"check",
  \"command",
  \"common",
  \"completely",
  \"control",
  \"copy",
  \"could",
  \"date",
  \"decide",
  \"different",
  \"does",
  \"doesn't",
  \"done",
  \"during",
  \"each",
  \"easy",
  \"else",
  \"enabled",
  \"enough",
  \"equal",
  \"event",
  \"everything",
  \"exactly",
  \"example",
  \"explain",
  \"failed",
  \"fast",
  \"faster",
  \"finally",
  \"find",
  \"finding",
  \"fine",
  \"finish",
  \"first",
  \"flash",
  \"follow",
  \"following",
  \"forget",
  \"from",
  \"full",
  \"getting",
  \"given",
  \"gives",
  \"going",
  \"good",
  \"happens",
  \"have",
  \"help",
  \"here",
  \"home",
  \"however",
  \"idea",
  \"information",
  \"instructions",
  \"interesting",
  \"into",
  \"just",
  \"keep",
  \"keeping",
  \"kinds",
  \"left",
  \"like",
  \"line",
  \"lines",
  \"look",
  \"looking",
  \"make",
  \"makes",
  \"many",
  \"memory",
  \"messages",
  \"might",
  \"more",
  \"most",
  \"mostly",
  \"move",
  \"must",
  \"name",
  \"named",
  \"near",
  \"need",
  \"next",
  \"normal",
  \"number",
  \"often",
  \"older",
  \"only",
  \"other",
  \"package",
  \"path",
  \"perfectly",
  \"place",
  \"placed",
  \"possible",
  \"prefer",
  \"probably",
  \"right",
  \"root",
  \"running",
  \"same",
  \"satisfied",
  \"search",
  \"second",
  \"section",
  \"several",
  \"should",
  \"simple",
  \"single",
  \"some",
  \"someone",
  \"something",
  \"somewhere",
  \"source",
  \"start",
  \"started",
  \"still",
  \"support",
  \"that",
  \"them",
  \"then",
  \"there",
  \"these",
  \"they",
  \"think",
  \"this",
  \"though",
  \"through",
  \"times",
  \"under",
  \"until",
  \"used",
  \"useful",
  \"using",
  \"usual",
  \"valuable",
  \"very",
  \"want",
  \"ways",
  \"went",
  \"what",
  \"when",
  \"where",
  \"which",
  \"while",
  \"whole",
  \"will",
  \"with",
  \"work",
  \"worked",
  \"wrong",
  \"your",
  \"yourself"
\]

inoremap <expr> qq QQ()
" inoremap <buffer> <expr> <space> ' '
" inoremap <buffer> <expr> <space> SpaceCompletion()
let g:runnerParamCache["node.traverse"] = "node"
function! s:smartnpath(file)
    let file = a:file
    " call InputPrompt('file', file)
    if file == "."
        return expand("%")
    elseif s:t(file, '^[/\~]')
        return file
    elseif s:t(file, '^node_modules')
        return getcwd() . '/' . file
    elseif s:t(file, '^\.')
        let a = fnamemodify(expand('%'), ':h')
        while s:t(file, '^\.\./')
          let file = s:sub(file, '^../', '', '')
          let a = s:sub(a, '[a-z0-9-]+/?$', '', '')
        endwhile
        return a . file
    endif
    if !Test(file, '^/')
        if IsJS2024()
            return PathJoin(Head(), file)
        endif
        let e = s:get_extension(file)
        let dir = g:homedir
        if e == 'js' || e == 'css' || e == 'html' || e == 'stylus' || e == 'styl'
            let dir = g:jsdir
        elseif e == 'typ'
            let dir = "/home/kdog3682/2024-typst/src/"
        elseif e == 'py'
            let dir = g:pydir
            " let dir = "/home/kdog3682/2024-python/"
        elseif e == 'vim'
            let dir = g:ftplugindir
        elseif e == 'bash_aliases' || e == 'bash_history'
            let dir = $HOME
        endif
        let file = s:npath(dir, file)
    endif
    return file
endfunction
let g:wpsnippets2["vim"]["ifhk"] = "if has_key($1, $2)\n    $c\nendif"

function! SetActiveFile()
    let line = CurrentLine()
    let line = GetFileFromLine2(line)
    if !IsFile(line)
        let line = CurrentFile()
    endif
    let e = s:get_file_type(line)
    let name = printf('active%sFile', s:cap(e))
    let t = CreateBinding(name, line, 1)
    call AppendAndExecute(t)
endfunction
let g:activeHtmlFile = ''
let g:activeCssFile = ''
let g:activeExampleFile = '/home/kdog3682/2023/examples.js'
let g:activePythonFile = '/home/kdog3682/PYTHON/next.py'
let g:activeJavascriptFile = ''
let g:activeNoteFile = '/home/kdog3682/RESOURCES/help.md'
function! ActiveFtpFile()
    let temp = "/home/kdog3682/.vim/ftplugin/%s.vim"
    let file = printf(temp, s:get_file_type())
    return file
endfunction
function! GoCssFile()
    let c = CurrentFile()
    let e = GetExtension(c)
    let f = ''
    if e == 'css'
        let f = '/home/kdog3682/.vim/ftplugin/css-data.vim'
    elseif e == 'cssTemplate'
        return 'aaaa'

    elseif e == 'vim'
        if s:tail(c) == 'cssTemplate.vim'
            let f = '/home/kdog3682/2023/table-variants.cssTemplate'
        else
            return FilePicker('css')
        endif
    else
        let f = ChangeFileExtension(c, 'css')
        if !IsFile(f)
            let f = g:activeCssFile
            let f = g:activeCssFile
        endif
    endif
    call OpenBuffer3(f)
endfunction
let g:activeShuntFile = '/home/kdog3682/2024/shunt.txt'
function! GetActiveHtmlFile()
    let h = ChangeFileExtension(g:activeJavascriptFile, 'html')
    if IsFile(h)
        return h
    endif
    return g:activeHtmlFile
endfunction
nnoremap ej :call OpenBuffer4(g:activeJavascriptFile)<CR>
nnoremap ec :call OpenBuffer4(g:activeCssFile)<CR>
" nnoremap e6 :call OpenBuffer4(s:get_file_ref('linked6', g:activeJavascriptFile))<CR>
nnoremap eh :call OpenBuffer4(GetActiveHtmlFile())<CR>
nnoremap es :call OpenBuffer4(g:activeShuntFile)<CR>
nnoremap ep :call OpenBuffer4(g:activePythonFile)<CR>
nnoremap ex :call OpenBuffer4(g:activeExampleFile)<CR>
nnoremap el :call OpenBuffer4(g:lasttouchedfile)<CR>
nnoremap ey :call OpenBuffer4('/home/kdog3682/2023/node-utils.js')<CR>
nnoremap et :call GoLastFile()<CR>
nnoremap ew :call GoLastWrittenFile()<CR>
nnoremap ef :call OpenBuffer4(ActiveFtpFile())<CR>
nnoremap ev :call OpenBuffer4(g:activeVimFile)<CR>
let g:activeVimFile = '/home/kdog3682/.vimrc'
let g:execRef2["saf"] = "SetActiveFile"
let g:activeCssFile = "/home/kdog3682/2024/style.css"
let g:activeCssFile = "/home/kdog3682/2023/base.css"
let g:activeHtmlFile = "/home/kdog3682/2024/index.html"


function! SetCurrentFileAsActiveLanguageFile()
    let cmd = 'let g:active${Capitalize($filetype)}File = "$currentFile"'
    let cmd = s:templater2(cmd)
    call s:append_and_execute(cmd)
endfunction

function! s:append_and_execute(cmd)
    let cmd = a:cmd
    call AppendAndExecute(cmd)
    
endfunction
function! SeeMappings(s, ...)
    let key = a:0 >= 1 ? a:1 : 'n'
    let ref = {
    	\'n': 'nmap',
    	\'i': 'imap',
    	\'v': 'vmap',
    	\'iab': 'iab',
    \}

    let key = ref[key]
    let items = s:xsplit(a:s)
    let lines = s:tolines(s:redir('verbose ' . key))
    let r = '(' . join(items, '|') . ')'
    let store = []
    let acc = []
    for i in range(0, len(lines) - 1, 2)
        let line = lines[i]
        let next = lines[i + 1]
        let r1 = '^ *(\w+) +(\S+) +\*(\@?)(.+)'
        let m = s:match(line, r1)
        let k = m[1]
        if s:t(k, '^' . r)
            let r2 = 'last set from (.{-}) line (\d+)'
            let m2 = s:match(next, r2)
            call s:push(store, m2)
            call s:push(acc, [m, m2])
        endif
    endfor
    " call s:appendfile('vim-unmapped.txt', acc)
    let base = s:group(store, {x -> x[0]}, {x -> x[1]})
    return [base, acc]
endfunction
function! SeeMappings2(s, ...)
    let key = a:0 >= 1 ? a:1 : 'n'
    let ref = {
    	\'n': 'nmap',
    	\'i': 'imap',
    	\'v': 'vmap',
    	\'iab': 'iab',
    \}
    let key = ref[key]
    let items = s:xsplit(a:s)
    let lines = s:tolines(s:redir('verbose ' . key))
    let store = []
    let r = s:ncg(items, '^ *\w+ +($1)')

    for i in range(0, len(lines) - 1, 2)
        if !s:t(lines[i], r)
            continue
        endif
        let next = lines[i + 1]
        let r2 = 'last set from (.{-}) line (\d+)'
        let m2 = s:match(next, r2)
        if s:exists(m2)
            let [a,b] = m2
            call s:push(store, [a, GetBufLine(a, b)[0]])
        endif
    endfor
    return store
endfunction
function! UnmapKeys(s)
    " test: "eh ef"
    let s = a:s
    let [base, acc] = SeeMappings(s)
    call UnmapController(base)
endfunction
let g:execRef2["uk"] = "UnmapKeys"

function! BufLoad(file) abort
    try
        let file = s:filegetter(a:file)
        let bufnr = bufadd(file)
        if !bufloaded(file)
            call bufload(bufnr)
        endif
        return bufnr
    catch
        let error = v:exception
        return 0
    endtry
endfunction

let g:vimCurrentTestFunction = "NormalBaseBlockEnter"
let g:vimCurrentTestFunction = "NormalBaseBlockExit"


function! BaseBlockEnterExpr()
    
    let s = s:getlinestate(1)
        
    if s.isemptyline
        return ''
    endif

    if Test(trim(s.text), s.enter)
        if s.isemptynextline
            return "\<ESC>\<DOWN>0Da" . s:tabs(s.indent + 4)
            return 'nextemptyline'
        else
            return "\<ESC>o"
        endif
    endif
    if s.isemptynextline
        return "\<ESC>\<DOWN>0Da" . s:tabs(s.indent + 4)
    else
        return "\<ESC>o"
    endif
endfunction

function! NormalBaseBlockEnter()
    let s = s:getlinestate(1)
        
    if s.isemptyline
        return ''
    endif

    let spaces = s:tabs(s.indent + 4)
    if Test(trim(s.text), s.enter)
        if s.isemptynextline
            execute "normal! \<ESC>\<DOWN>0Da" . spaces
        else
            call append('.', spaces)
            call cursor(line('.') + 1, 100)
        endif
    elseif s.isemptynextline
        execute "normal! \<ESC>\<DOWN>0Da" . spaces
    else
        call append('.', s:tabs(s.indent))
        call cursor(line('.') + 1, 100)
    endif
    startinsert!
endfunction

function! NormalBaseBlockExit()
    " test: abc, asd

    let s = s:getlinestate(1)
    if s.isemptyline
        return ''
    endif

    if Test(trim(s.text), s.exit)
        return s:normaltouch(s.indent)
    endif

    try
        let i = s:fli(s.exit, '.', 1, 10, 0)
        let ind = s:getindent(i)
        return s:normaltouch(ind, i)
    catch
        let error = v:exception
    endtry
endfunction
function! s:normaltouch(spaces, ...)
    let i = a:0 >= 1 ? a:1 : line('.') 
    let z = a:0 >= 2 ? a:2 : ''
    let spaces = s:tabs(a:spaces)
    if s:t(getline(i + 1), '\S')
        call append(i, spaces)
    else
        call setline(i + 1, spaces)
    endif
    if s:exists(z)
        execute "normal! " . z
    endif
    call cursor(i + 1, 100)
    startinsert!
endfunction
function! ReWriteMapCommand(s)
    let s = a:s
    let [base, acc] = SeeMappings(s)
    for item in acc
        ec string(item)
    endfor
    call input('')
    let items = UnmapController(base)
    call append('$', items)
endfunction
let g:execRef2["rwm"] = "ReWriteMapCommand"

nnoremap qt :w<CR>:call QTNormalRunner()<CR>

function! Sdjfsdfkj()
    
endfunction
function! CssBlockDown()
    call search('\v^[a-z0-9. -]+\{ *$')
    normal! zt
    call s:normaltouch(4)
endfunction
function! CssBlockUp()
    try
        let i = s:fli('^"?\}', '.', -1, 100, 0)
        call cursor(i, 0)
        call search('\v\{ *$', 'b')
        normal! zt
        call s:normaltouch(4)
    catch
        let error = v:exception
        
    endtry
endfunction
let g:wpsnippets2["vim"]["ift"] = "if s:t($1, '$2')\n    $c\nendif"
function! VimSilent(s)
    let s = a:s
    let [a,b] = s:so(s)
    return a . ' <silent> ' . b
endfunction
function! SeeTheReturnValue(s)
    let s = a:s
    let el = s:getiden(s)
    let log =  s:templater(s:jspy('echoLogThrowTemplate'), 'value')
    if s:exists(el)
        return [s, s:sub(log, 'value', el, ''), 'return ' . el]
    else
        let a = s:sub(s, 'return +', s:jspy('prefix') . 'value = ', '')
        return [a, log, 'return value']
    endif
endfunction
function! s:settext(value, i, spaces)
    let value = a:value
    let i = a:i
    let spaces = a:spaces
   if Exists(value)
       if IsArray(value)
           let val = s:indent(value, spaces)
           call setline(i, val[0])
           call append(i, val[1:])
           return 
       endif
       call setline(i, spaces . value)
   endif
endfunction
function! Asadw()
   let key =  8 + 1
                let newKey = ModularIncrementNumber(key, 1, 10, 1)
                return newKey
endfunction
let g:wpsnippets2["css"] = {}
let g:wpsnippets2["css"]["import-font"] = "@font-face {\n    font-family: '$1';\n    src: url('https://fonts.googleapis.com/css2?family=$2');\n}\n"
let g:GoogleFontAliases = {"code":"source-code-pro","noto-chinese":"Noto Serif SC","crimson":"Crimson Text","poppins":"Poppins","montserrat":"Montserrat","alegreya":"Alegreya","playfair":"Playfair Display","bubbly":"Playfair Display","open":"Open Sans","os":"Open Sans","lato":"Lato","raleway":"Raleway","source":"Source Sans Pro","noto":"Noto Sans","chinese":"Noto Serif SC","chiserif":"Noto Serif SC","chisans":"Noto Sans SC","noji":"Noto Emoji","ubuntu":"Ubuntu","oswald":"Oswald","slab":"Roboto Slab","roboto":"Roboto","merriweather":"Merriweather","merry":"Merriweather","pt":"PT Serif","lora":"Lora","inter":"Inter","georgia":"Georgia","times":"Times New Roman","abril":"Abril Fatface","pacifico":"Pacifico","inconsolata":"Inconsolata","source-code":"Source Code Pro","fira":"Fira Code","comic":"Comic Sans MS","nans":"Noto Sans","OT":"Old Standard TT","sourcepro":"Source Sans Pro","wsans":"Work Sans","algereya":"Alegreya","cabin":"Cabin","droid":"Droid Serif","exo":"Exo 2","garamond":"EB Garamond","josefin":"Josefin Sans","mw":"Merriweather","nunsans":"Nunito Sans","ptsans":"PT Sans","amatic":"Amatic SC","archivo":"Archivo Narrow","BK":"Baskerville","CR":"Cormorant","didot":"Didot","FT":"Futura","GH":"Gochi Hand","IM":"Impact","LB":"Lobster","lobster":"Lobster","MS":"Monospace","PC":"Pacifico","PL":"Palatino Linotype","PLY":"Play","QK":"Quicksand","SF":"Satisfy","SU":"Segoe UI","TR":"Trebuchet MS","VK":"Vollkorn"}

function! CssImportFont(...)
    " test: "code"
    let r = "font-family: '(\\S{-})'"
    let key = a:0 >= 1 ? a:1 : s:match(getline('.'), r)
    let key = has_key(g:GoogleFontAliases, key) ? key : s:choose(keys(g:GoogleFontAliases))
    if !exists('b:fonts')
        let b:fonts = []
    endif
    if s:in(b:fonts, key)
        return 
    endif
    call add(b:fonts, key)
    let value = g:GoogleFontAliases[key]
    let a = g:wpsnippets2["css"]["import-font"]
    let v = s:templater2(a, [key, value])
    call append(0, s:tolines(v))
    " return v
endfunction
let g:wpsnippets2["vim"]["ifo"] = "if IsObject($1)\n    $c\nendif"


function! Chooseandchoose(ref)
    let ref = a:ref
    call s:appendbinding('temp', val)
endfunction
let g:jspyref3["markdown"]["execFunctions"] = {}
let g:jspyref3["css"]["execFunctions"] = {}
let g:jspyref3["python"]["execFunctions"] = {}
let g:jspyref3["css"]["execFunctions"]["if"] = "CssImportFont"
let g:jspyref3["python"]["execFunctions"]["uv"] = "UnmapPython"
let g:jspyref3["css"]["execFunctions"]["font"] = "CssImportFont"
let g:jspyref3["css"]["execFunctions"]["cr"] = "CssCreateClass"
" let g:jspyref3["css"]["execFunctions"]["after"] = "CssAfter"
" let g:jspyref3["css"]["execFunctions"]["before"] = "CssBefore"
" let g:jspyref3["css"]["execFunctions"]["children"] = "CssChildren"
" let g:jspyref3["css"]["execFunctions"]["hover"] = "CssHover"

function! CssSecondaryIncrement(s, dir)
    " test: "5px"
    let s = a:s
    let dir = a:dir
    let s:dir = dir
    let units = [
        \'pt',
        \'px',
        \'vw',
        \'vh',
        \'%',
        \'em',
        \'rem',
    \]
    let r = s:ncg(units, '\v\d\zs($1)')
    " return r
    function! s:inner(s)
        let s = a:s
    endfunction
    if s:t(s, r)
        return substitute(s, r, {x->ModularIncrement2(units, x[1], dir)}, '')
    endif

    if Test(s, '\/\*')
        function! Inner(key)
            let [a,b] = split(a:key, '-')
            let newKey = ModularIncrement2(g:cssTailwindColorKeys, a, s:dir)
            let value = CssColorTransform([newKey, b])
            return value
        endfunction
        let r =  '\S+ /\* (\S+) \*/'
        let t = '\=Inner(submatch(1))'
        return s:sub(s, r, t, '')

endfunction
inoreab <buffer>sm s:match()<LEFT><C-R>=Eatchar('\s')<CR>
function! s:rescape(s)
    function! s:inner_rescape(s)
        return "\\\\" . a:s
    endfunction

    let r = '\v[\=\[\]\{\}()!@#$\%^&*.<>\\]'

    " 11-26-2023 
    " let r = '\v[\=\[\]\{\}()!@#$\%^&*./<>\\]'
    " removed '/' from the regex 
    " reason: s:get_boundary_start

    return substitute(a:s, r, '\=s:inner_rescape(submatch(0))', '')
endfunction
function! s:ncg(items, template)
    let items = a:items
    let template = a:template
    let r = join(map(copy(items), 's:rescape(v:val)'), '|')
    return s:sub(template, '\$1', r, '')
endfunction
function! Whereami2()
    let tail = Tail()
    if tail == 'sampleString.js'
        return s:whereami()
    endif
    let regex = '^(const|(async )?function[!*]?|class|def|var) \zs%(s:)?\w+'
    let value = SprawlMatch(regex)
    if Exists(value)
        let @"=value
        ec 'LOCATION: ' . value
    endif
endfunction
let g:filedict["ftp"] = "/home/kdog3682/.vim/ftplugin/python.vim"

function! PyCreateFunctionBlockAsExpression(s)
    let s = a:s
    let [a,b] = s:sosall(s)
    let b = join(b, ', ')
    let t = "def $1($2):\n\t$c"
    return s:setblock(s:templater2(t, [a,b]))
    
    " a b c
endfunction

function! PythonSmartEqual()
    
    let s = trim(getline('.'))
    let [a, b, c, d, e] = ABCDECursor()

    if s:t(b, '[?<>!=]')
        return '= '
    elseif s:t(a, '[?<>!=]') && b == ' '
        return g:keyboard.bs . '= '
    elseif s:t(s, '^(if|elif)')
        return ' == '
    elseif s:t(b, '[a-z]')
        return ' = '
    else
        return '='
    endif
endfunction
function! PythonSmartEnter()
    let s = getline('.')
    let [a,b] = s:sosall(s)
    if has_key(g:pythonEnterRef, a)
        return call(function('g:pythonEnterRef[a]'), b)
    endif
    return g:keyboard.enter
endfunction

function! SetWordAsComponentDataValue(s)
    let s = a:s
    let word = s:match(s, '\w+ *$')
    let i = s:fli('^::', '.', -1, 200, 0)
    let ans = input('choose a val:  ')
    let t = printf('this.%s = %s', trim(word), ans)
    call append(i, t)
endfunction
call add(g:lineEditCommands, "SetWordAsComponentDataValue")
let g:wpsnippets2["javascript"]["ifd"] = "if (isDefined($1)) {\n    $c\n}"
autocmd! VimEnter * call OnVimStartup()
function! OnVimStartup() abort
    let classfile = '/home/kdog3682/CWF/public/class.js'
    let vimfile = '/home/kdog3682/.vimrc'

    try 
        " call OpenBuffer3(g:activeJavascriptFile)
        normal! G
   catch 
        ec v:exception
        ec 'error'
    endtry
endfunction
function! SetFileType(key)
    let cmd = 'setlocal filetype=' . s:get_file_type(a:key)
    ec cmd
    execute cmd
endfunction
function! GlobalTextSearch(key)
    let key = a:key
    let r = CreateCompletionRE(key)
    let t = s:joinlines(getline(1, '$'))
    let m = sort(s:unique(s:findall(t, r)))
    return m
endfunction
inoreab <buffer>cc WordSpiralerWrapper()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer>cc CreateCompletionRE()<LEFT><C-R>=Eatchar('\s')<CR>
let g:execRef2["ew"] = "DefineEatWord"
let g:runnerParamCache["const"] = "element"
let g:filedict["ffr"] = "/home/kdog3682/2024/ffr.json"

function! s:char()
    return getline('.')[col('.') - 1]
endfunction
function! s:so2(s, d)
    let s = a:s
    let d = a:d
    let r = '^(.{-}) *' . s:rescape(d) . ' *(\S.+)'
    let m = s:match(s, r)
    return m
endfunction
function! VAlignment(state)
    "test: {'lines': ['aa', 'abc  ] =     { def', 'abcde { defgh']}
    let state = a:state
    let dre = '[:=]'
    let s = getline('.')
    let d = s:match(s, dre)
    let s:delimiter = d

    let l1 = state.lines[0]
        let l2 = state.lines[1]

    let r = s:rescape(s:delimiter) . ' '
    let s:mode = s:t(l1, r) || s:t(l2, r) ? 'balanced' : 'back'
    function! s:inner(s)
        return s:so2(a:s, s:delimiter)
    endfunction
    let lines = map(state.lines, 's:inner(v:val)')
    if empty(lines[0])
        return 
    endif
    let first = map(copy(lines), 'v:val[0]')
    let s:length = len(s:longest(first))
    function! s:inner2(s)
        let [a,b] = a:s
        let spaces = repeat(' ', s:length - len(a))
        if s:mode == "balanced"
            return a . spaces . ' ' . s:delimiter . ' ' . b
        elseif s:mode == "front"
            return a . s:delimiter . ' ' . spaces . b
        elseif s:mode == "back"
            return a . spaces . ' ' . s:delimiter . b
        endif
        
    endfunction
    let results = map(lines, 's:inner2(v:val)')
    call s:replaceblock(state.indexes, results)
endfunction
let g:visualactiondict['align'] = {'fn': 'VAlignment', 'i': 'contiguous'}
let g:visualactiondict['a'] = {'fn': 'VAlignment', 'i': 'contiguous'}
let g:wpsnippets2["vim"]["map"] = "let $1 = map($2, 's:inner(v:val)')"
let g:GI4Ref["contiguous"] = "GIContiguous"


function! Seekeys()
    let ref = s:gval('visualactiondict')
    let a = sort(values(ref))
    let b = s:choose(a)
    let c = ref[b]
    return c
endfunction
function! CRCompletion2(store, word)
    let store = a:store
    let word = a:word
    return BackspaceExpr(word) . CRCompletion(store)
endfunction

    " let word = s:stringbeforecursor('[a-z]+$')
    " ec [word]


function! s:completion_filter(items, key)
    let items = a:items
    let key = a:key
    let r = CreateCompletionRE(key)
    let store = s:regexfilter2(items, r)
    return store
    
endfunction


let g:COMPLETER = "\<C-x>\<c-u>"
let s:insert_count = 0


let g:wpsnippets2["vim"]["ci"] = "call input(string($1))"
function! Asdjaksd()
    " call feedkeys('iwami asdwp')
    " call feedkeys('iwami asdwp')
    " call feedkeys('iwami asdwp', 'tn')
endfunction

" this

function! MDCompletion()
    if v:char =~ ' '
        let s:insert_count = 0
    elseif v:char =~ '\d'
        return 
    elseif v:char =~ '[a-z]'
        let s:insert_count += 1
    else
        return
    endif

    if !pumvisible() && s:insert_count >= 2
        silent! call feedkeys(g:COMPLETER, "n")
    endif
endfunction


function! MDPeriodExpr()
    let m = s:stringbeforecursor('\.+ *$')
    if trim(m) == '...'
        return ''
    elseif s:t(m, '\.')
        return BackspaceExpr(m) . ' ... '
    endif
    return BackspaceExpr(m) . '. '
endfunction

function! MDPunctuationExpr(s)
    let s = a:s
    let spaces = s:stringbeforecursor(' +$')
    return BackspaceExpr(spaces) . s . ' '
endfunction

function! GetMDWordsBasedOnKeyLength(key)
    let key = a:key
        return s:regexfilter2(g:markdownProseCompletionWords, key)
    if len(key) <= 2
        return g:markdownShortWords[key]
        " array
    else
        return s:regexfilter2(g:markdownProseCompletionWords, key)
    endif
    
endfunction

let b:lastCompletionTrigger = ''
let g:execRef2["sct"] = "SeeCompletionTracker"
let g:filedict["ct"] = "/home/kdog3682/2024/completionTracker.txt"
" let g:packageManagerFile = 'serveFile.js'
" let g:packageManagerFile = 'serveVite.js'
" let g:packageManagerArgs = ['a
" function! PackageManager3(key)
    " let args = [g:packageManagerFile] + [g:packageManagerArgs]
    " call Node(args)
" endfunction



let g:pmr2['print'] = 'serveFile.js print vuetify.html'
let g:pmr2['html'] = 'serveFile.js html vuetify.html'
let g:pmr2['ss'] = 'serveFile.js screenshot vuetify.html'
let g:pmr2['blank'] = 'serveFile.js blank vuetify.html'
let g:pmr2['host'] = 'serveFile.js host vuetify.html'
let g:pmr2['vite'] = 'serveVite.js serve vuetify.html'
let g:filedict["sf"] = "/home/kdog3682/2023/serveFile.js"

function! GetNextLinkedBuffer() abort
    let file = CurrentFile()
    let tail = Tail(file)

    let next = ''
    if s:t(tail, 'grammar$')
        if s:t(file, '\@lezer')
            let next = s:npath(s:head(file), 'tokens.js')
            " call input('next: ' . s:string(next))
        else
            let next = s:change_extension(file, 'tokens.js')
        endif
        " call input('next: ' . s:string(next))
        if s:is_file(next)
            return s:open(next)
        endif
        return 
    elseif s:t(tail, 'tokens.js$')
        if s:t(file, '\@lezer')
            let m = s:match(file, '\@lezer/(\w+)')
            let next = s:npath(s:head(file), m . '.grammar')
        else
            let next = s:sub(file, 'tokens.js$', 'grammar', '')
        endif
        if s:is_file(next)
            return s:open(next)
        endif
        return 
    endif
    if s:t(tail, '^v-[a-z].{-}\.css')
        let m = s:match(tail, '.{-}\ze\.css')
        let r = '^name: ' . m
        return s:open('/home/kdog3682/2023/component-sampleString.js', r, 'zt')
    endif
    let a = get(g:simpleLinkedBuffers, file)
    if s:exists(a)
        return a
    endif
    let f = DictGetter2(g:fileRef, tail, 'linked6')
    if s:exists(f)
        return f
    endif
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
        ec 'no linked buffer'
        ec 'establishing link'
        let f = ChooseFile()
        if empty(f)
            return 
        endif
        let group = [file, f]
        call EstablishLinkedBufferGroupRunner2(group)
    endif
endfunction

function! ChooseFile()
    let other = bufname('#')
    let sorted = SortBuffers()
    let current = CurrentFile()
    let a = map(sorted[-7:], 's:abspath(v:val.name)')
    
    let b = filter(a, '!(s:t(v:val, "vim") || v:val == current || v:val == other)')
    call add(b, other)
    return s:choose(b)
endfunction
let g:linkedBufferGroups["sampleString.js"] = ['sampleString.js', 'vuetify.js']
let g:linkedBufferGroups["vuetify.js"] = ['sampleString.js', 'vuetify.js']
let g:linkedBufferGroups["vuetify.css"] = ['vuetify.css', 'vuetify.js']
function! WindowAround(n)
    let p = getpos('.')
    call setpos(".", [0, a:n, 0, 0])
    let a = s:gi('window')
    call setpos(".", p)
    return a
endfunction
function! CommentEverythingOnScreen(...)
    " test: 14771
    let ind = a:0 >= 1 ? WindowAround(a:1) : s:gi('window')
    function! CommentEverythingOnScreenInner(s)
        let s = a:s
        if s:t(s, '^ *console')
            return s:sub(s, 'console', '// console')
        endif
    endfunction
    call s:getsetrange(ind, function('CommentEverythingOnScreenInner'))
endfunction
function! s:getsetrange(ind, F)
    let [a,b] = a:ind
    for i in range(a, b)
        let s = getline(i)
        let value = a:F(s)
        if s:exists(value)
            call setline(i, value)
        endif
    endfor
endfunction
let g:execRef2["com"] = "CommentEverythingOnScreen"

function! RemoveStartingComments(s)
    if &filetype == 'css'
        return s:sub(a:s, '/ *\* *| *\* */', '')
    endif
    return Replace(a:s, '^[''"/#]+', '')
endfunction
let g:activeJavascriptFile = "/home/kdog3682/2023/vuetify.js"
let g:gfgfdict['cc'] = ['/home/kdog3682/.vimrc', 'CreateCompletionRE', 0]
let g:gfgfdict['qq'] = ['/home/kdog3682/.vimrc', 'QQ', 0]

function! FarawayFunctionCompletion()
    return g:COMPLETER
    
endfunction
let g:execRef2["sft"] = "SetFileType"
let g:execRef2["rct"] = "ResetCompletionTrigger"
let g:gfgfdict['ccc'] = ['/home/kdog3682/.vimrc', 's', 0]











function! s:abc_choose(items)
    let items = a:items
    if len(items) > 26
        throw 'not enuf letters'
    endif
    let store = {}
    for i in range(len(items))
        let item = items[i]
        let store[s:n2char(i)] = item
    endfor
    ec store
    let ans = InputChars(1)
    return store[ans]
    
endfunction
inoremap qc <C-x><c-u>
function! CssCreateClass(...)
    let keys = [
        \'ab',
        \'before',
        \'after',
        \'hover',
        \'children',
        \'firstChild',
    \]
    let pick = a:0 >= 1 ? a:1 : s:choose(keys)
    let r =  '.{-}\ze \{'
    let m = s:sprawl_match(r)
    if s:t(m, ':')
        let m = s:sub(m, ':.+', '')
    endif
    let ref = {
        \'a': '::before',
        \'b': '::after',
        \'ab': ['a', 'b'],
        \'before': '::before',
        \'after': '::after',
        \'hover': ':hover',
        \'h': ':hover',
        \'children': ' > *',
        \'c': ' > *',
        \'firstChild': ':firstChild',
    \}
    let picked = ref[pick]
    if IsArray(picked)
        return map(reverse(copy(picked)),  'CssCreateClass(v:val)')
    endif
    let val = m . '' . picked
    let i = s:fli('^\}', '.', 1, 100, 0)
    let t = "$1 {\n\t$c\n}\n"
    if s:t(picked, 'before|after')
        let t = "$1 {\n\tcontent: '';\n\t$c\n}\n"
    endif
    let snippet = s:templater2(t, val)
    call append(i, ['', ''])
    call Jump(i + 2)
    return PlaceSnippet(snippet)
endfunction

function! s:sprawl_match(r, ...)
    let r = a:r
    let dir = a:0 >= 1 ? 1 : -1
    let i = s:fli(r, '.', dir, 500, 0, 1)
    let s = getline(i)
    let t = s:match(s, r)
    return t
endfunction

function! GitCloneRepo()
    let a = input('url?')
    let a = s:match(a, '^.{-}github.com/[a-z0-9-]+/[a-z0-9-]+')
    let dir = '/home/kdog3682/latest-git-cloned-repo'
    let res = GitCloneRepoAndChangeDir(a, dir)
    ec res
    return res
endfunction

function! GitCloneRepoAndChangeDir(repo_url, target_directory)
  if !isdirectory(a:target_directory)
      ec 'making dir'
    call mkdir(a:target_directory, 'p')
  endif

  let git_clone_command = 'git clone ' . a:repo_url . ' ' . a:target_directory
  call input('git_clone_command: ' . s:string(git_clone_command))
  let a = systemlist(git_clone_command)
  return a
endfunction

let g:dirdict = {"g":"/home/kdog3682/latest-git-cloned-repo","dl":"/mnt/chromeos/MyFiles/Downloads","r":"/home/kdog3682","nm":"/home/kdog3682/2023/node_modules","res":"/home/kdog3682/RESOURCES","py":"/home/kdog3682/PYTHON","ftp":"/home/kdog3682/.vim/ftplugin","23":"/home/kdog3682/2023","24":"/home/kdog3682/2024"}
let g:dirdict.trash = '/home/kdog3682/TRASH'
let g:dirdict.dir2024 = '/home/kdog3682/2024/'

function! VYank(state)
    let @" = a:state.string
endfunction
let g:visualactiondict['yank'] = {'fn': 'VYank', 'i': 'code'}

function! Sdkfk()
    
    let r = 'const \zs\w+\ze *\= *\{'
    let t = "const abc = {\nconst def = {a"
        let items = s:ufa(t, r)
        return items
endfunction

function! VCopyRefFunctionsToOtherRef(state)
    let state = a:state
    let r = 'const \zs\w+\ze *\= *\{'
    if !exists('b:ref') || !s:exists(b:ref)
        let t = s:joinlines(getline(1, '$'))
        let items = s:ufa(t, r)
        let b:ref = items
    endif
    let place = s:choose(b:ref)
    let p = getpos('.')
    let r = 'const ' . place . ' * \= *\{'
    call ExecuteRegex(r)
    call setpos("'z", getpos('.'))
    let state.lines[-1] = s:maybe_append(state.lines[-1], ',')
    call append('.', state.lines)
    call setpos(".", p)
endfunction
let g:visualactiondict['cpr'] = {'fn': 'VCopyRefFunctionsToOtherRef'}
function! s:maybe_append(s, k)
    let s = trim(a:s)
    let k = a:k
    return s:t(s, k . '$') ? s : s . k
endfunction
let g:linkedBufferGroups["markdownParser.js"] = ['markdownParser.js', '/home/kdog3682/2023/markdownLeafParser.js']
let g:linkedBufferGroups["/home/kdog3682/2023/markdownLeafParser.js"] = ['markdownParser.js', '/home/kdog3682/2023/markdownLeafParser.js']

" //Asd.vuemd
let g:execRef2["unf"] = "UnmapFast"
function! GetComponents()
    let data = s:get_file_data_from_cache(file)
    let c = 0
    while c < 10
        let c += 1
        if c > 1
            ec
        endif
        let ans = input('choose a regex or select an item: ')
        if 
            let value = data[ans - 1][1]
        endif
        let data = s:regexfilter(data, ans, 'v:val[0]')
    endwhile
endfunction
let g:file_data_cache = {}
function! s:get_file_data_from_cache(file, ...)
    let file = a:file
    if !has_key(g:file_data_cache, file)
        let raw = s:read(file)
        if a:0 >= 1
            if a:1 == 'items'
                let raw = items(raw)
            elseif a:1 == 'keys'
                let raw = keys(raw)
            endif
        endif
        let g:file_data_cache[file] = raw
    endif
    return g:file_data_cache[file]
endfunction

function! LogExpr()
    " lg<C-R>=Eatchar('\s')
    " gk
    " gk
    " gk
    let t = s:jspy('echoLogTemplate')
    return start . g:keyboard.eat
endfunction


inoreab <expr> <buffer>lg LogExpr()
function! s:grep(r, dir)
    " test: ["v-tree", "v-tree-node"], '23'
    let dir = s:get_dir(a:dir)
    " let dir = '/home/kdog3682/sample-directory'
    let r = s:ncg(a:r, '($1)')
    let ref = [r, dir]
    let cmd = s:templater('grep -nr -E "\b$1\b" $2 --exclude-dir={git,node_modules}', ref)
    call append('$', s:comment(s:sys(cmd)))
    return 
    return s:sys(cmd)
    return cmd
endfunction
function! s:sys(s)
    let s = a:s
    let a = systemlist(s)
    return s:joinlines(a)
endfunction
function! CreateSampleDirAndFile()
  let sample_dir = '/home/kdog3682/sample-directory'
  let sample_file1 = '/home/kdog3682/sample-directory/sample_file1.txt'
  let sample_file2 = '/home/kdog3682/sample-directory/sample_file2.txt'
  let sample_content = "This is a sample file.\nHello, world!\n"
  call mkdir(sample_dir, 'p')
  call writefile([sample_content], sample_file1)
  call writefile([sample_content], sample_file2)
endfunction

function! s:create_binding(name, value)
    let name = a:name
    let value = a:value
    let prefix = s:jspy('prefix')
    return printf('%s%s = %s', prefix, name, value)
endfunction
function! NameTheExpr(s)
    let name = s:prompt('name: ' , 'temp')
    execute "normal! di(i" . name
    let value = @"
    call s:appendabove(s:create_binding(name, value))
endfunction
call add(g:lineEditCommands, "NameTheExpr")
function! AlignStuff(s)
    call VAction('align')
endfunction
call add(g:lineEditCommands, "AlignStuff")
let g:wpsnippets2["javascript"]["lorem"] = "import * as lorem from \"./lorem.js\""
let g:wpsnippets2["javascript"]["ifnot"] = "if (!$1) $1 = $2"
let g:wpsnippets2["javascript"]["ss"] = "UtilJSImportString"
let g:wpsnippets2["javascript"]["eval"] = "InvivoEvalString"
let g:wpsnippets2["javascript"]["vim"] = "VimEvalString"
let g:wpsnippets2["javascript"]["gather"] = "InvivoGatherString"
function! VimEvalString(s)
    let s = a:s
    if has_key(g:vim_eval_ref, s)
        let ref = g:vim_eval_ref[s]
        let value = s:call(ref.fn, ref.args)
        call input('value: ' . s:string(value))
        return value
    endif
    if !s:t(s, '\(') && !s:t(s, '^g:')
        let items = s:xsplit(s)
        let s = call(function('s:callable'), items)
    endif
    let value = eval(s)
    if s:isstring(value)
        return value
    endif
    if IsArray(value)
        return s:joinlines(value)
    endif
    return 'const temp = ' . json_encode(value)
endfunction
function! s:remove_comments(s)
    let s = a:s
    return s:sub(s, '(^|\n)\zs[\t ]*(//|"|#)[^\n]*', '')
    
endfunction

function! UtilJSImportString(...)
    " {"type":"hfl","bookmarkId":"1708172417"}
    let file = a:0 >= 1 && s:exists(a:1) ? FileGetter2(a:1) : '/home/kdog3682/2023/utils.js'
    let items = GetExports(file)

    let file = s:tail(file)
    let imports = join(items, ', ')
    let com = '/* deno-fmt-ignore */ '
    let ref = {
        \'/home/kdog3682/2024-javascript': '/home/kdog3682/2023/',
        \'/home/kdog3682/2023': './',
        \'.': './',
    \}
    let h = expand('%:h')
    let base = DictGetterMultipleAttempts(ref, h, Head(h))
    let import_path = base . file
    return s:templater(com . 'import {$1} from "$2"', [imports, import_path])
endfunction
function! s:reverse(s)
    let s = a:s
    return reverse(s)
endfunction
function! SwapVariableOrder(s)
    let s = a:s
    let t =  '\=join(reverse(s:xsplit(submatch(1))), ", ")'
    let m = s:sub(s, '\(\zs(.{-})\ze\)', t)
    return m
endfunction
call add(g:lineEditCommands, "SwapVariableOrder")
function! WrapWord(s)
    let s = a:s
    let a = s:prompt('word?')
    let original = s:gcw()
    let cmd = "normal! diwi" . a  . '(' . original . ')'
    execute cmd

endfunction
call add(g:lineEditCommands, "WrapWord")
function! LetToConst(s)
    return s:sub(a:s, '<let>', 'const', '')
endfunction
call add(g:lineEditCommands, "LetToConst")
let g:filedict["pm"] = "/home/kdog3682/2023/packageManager.js"
let g:filedict["f"] = "/home/kdog3682/2023/vuetify.js"

function! RunNodePackageManager()
    if exists('s:expr')
        execute s:expr
    else
        let expr = ApplyDefinitions()
        let s:expr = expr
    endif
    return 
    let arg = g:key
    if g:activeNodePackageManagerFunction == 'runVuetifyViaSectioning'
        let arg = GetBufferLineNumber('sampleString.js')
        return Node('packageManager.js', g:activeNodePackageManagerFunction, arg, g:key)
    else
        return Node('packageManager.js', g:activeNodePackageManagerFunction, arg)
    endif
endfunction


function! DefineNormalZero()
    call RunVuetify()
    " let a = SeeMappings('0')[1]
    " return a
endfunction

nnoremap 0 :call ToggleBuffers()<CR>
nnoremap 0 :wa<CR>:call NodePackageManager3()<CR>

let g:gfgfdict['wn'] = ['/home/kdog3682/.vimrc', 'WriteNotes5', 0]


function! GoFunctionSource()
    let s = getline('.')
    let word = GetFunctionFromLine2(s)

    if empty(word)
        return
    endif
    if FindFFRItem(word)
        return
    endif
    try
        let i = s:fli(word, 1, 1, 10, 0)
        let s = getline(i)
        let m = FileFromLine(s)
        if s:exists(m)
            call s:open(m, g:functionPrefixRE . word)
        endif
    catch
        let error = v:exception
        ec error
    endtry

endfunction
function! FindFFRItem(word)
    let word = a:word
    let ffr = s:load_data_from_file(g:ffrfile)
    let item = s:find_ffr_item(ffr, word, 'fuzzy')
    if s:exists(item)
        call s:open(item.name, g:functionPrefixRE . word)
    endif
endfunction
function! s:find_ffr_item(ffr, word, ...)
    let items = a:ffr
    let mode = a:0 >= 1 ? a:1 : ''
    let word = a:word
    let isWord = empty(mode) ? s:isword(word) : 0

    for i in range(len(items) - 1, 0, -1)
        let item = items[i]
        for el in item.contents
            if isWord && word == el
                return item
            elseif s:t(el, word)
                return item
            endif
        endfor
    endfor
endfunction
let g:cache = {}
function! s:load_data_from_file(file)
    let file = a:file
    if !has_key(g:cache, file)
        let g:cache[file] = s:read(file)
    endif
    return g:cache[file]
endfunction
nnoremap <silent> gs :call GoFunctionSource()<CR>
" let g:gfgfdict['fl'] = ['/home/kdog3682/.vimrc', 'GetFunctionFromLine2', 0]
" function! Whereami()
" i =
    " let i = s:fli()
" endfunction
function! s:get_yanks(...)
    let yanks = copy(g:yanks)
    let g:yanks = []
    let throwIt = a:0 >= 1 ? 1 : 0
    if empty(yanks) && throwIt
        throw 'yanks are empty, but required'
    endif
    return yanks
endfunction
let g:execRef2["soe"] = "SetOverrideExecution"


function! TrackProgress(s)
    " test: ""
    let s = a:s
    call s:assert(s)
    let t = '$longtimestamp -- $file -- $binding -- $1'
    let v = s:templater2(t, s)
    call s:appendfile('TrackProgress.txt', v)
endfunction
let g:vimFunctionAliases["longtimestamp"] = "GetTime"
let g:vimFunctionAliases["notePrompt"] = "NotePrompt"
function! NotePrompt()
    return s:prompt('write a note: ')
endfunction
let g:execRef2["tp"] = "TrackProgress"
let g:filedict["tp"] = "/home/kdog3682/2024/TrackProgress.txt"

let g:visualactiondict['runner'] = {'fn': 'VWrap', 'arg': 'functionWrapTemplate'}

function! CreateFileFromCurrentFunctionBlock(s)
    " test: "asd"
    let word = GetBindingName()
    let b = s:getlines('code')
    " let b = s:getlines('code', 'd')
    let e = GetExtension()
    let t = s:jspy('fileFromFunctionBlockTemplate')
    let payload = s:templater2(t, [word, s:tostring(b)])
    let name = word . '.' . e
    let t = s:jspy('importDependencyStringTemplate')
    let importDependencyString = s:templater2(t, [word, name])
    let tail = Tail()
    let effectiveFile = s:aorb(DictGetter2(g:fileRef, tail, 'linked'), tail)
    call s:prependfile(effectiveFile, importDependencyString)
    call s:writefile(name, payload)
endfunction
function! s:prependfile(file, item)
    let file = a:file
    let item = a:item
    call BufLoad(file)
    call appendbufline(file, 0, item)
endfunction
let g:jspyref3["vim"]["functionWrapTemplate"] = ""
let g:jspyref3["python"]["functionWrapTemplate"] = ""
let g:jspyref3["javascript"]["functionWrapTemplate"] = "function runner(s) {\n    $1\n}"
let g:jspyref3["vim"]["fileFromFunctionBlockTemplate"] = "$importString\n\n$1"
let g:jspyref3["python"]["fileFromFunctionBlockTemplate"] = "$importString\n\n$1"
let g:jspyref3["javascript"]["fileFromFunctionBlockTemplate"] = "$importString\nexport { $2 }\n $1"
let g:vimFunctionAliases["importString"] = "UtilJSImportString"
call add(g:lineEditCommands, "CreateFileFromCurrentFunctionBlock")

function! s:write(file, lines, mode)
    let file = a:file
    let lines = a:lines
    let mode = a:mode
    let lines = ''
    try
        let lines = s:tolines(a:lines)
    catch
        let lines = map(copy(a:lines), 'string(v:val)')
    endtry
    if g:debug && !g:override_debug
        ec '-----------------------------'
        ec lines
        ec '-----------------------------'
        ec 'g:debug is active. early return'
        return 
    endif
    if empty(lines)
        return 
    endif
    let g:lasttouchedfile = file
    let length = len(lines) . (len(lines) == 1 ? ' line' : ' lines')

    if mode == 'a'
        if len(lines) > 1
            call add(lines, '')
        endif

        if file == bufname('%')
            ec printf('appending %s to current file', length)
            call append('$', lines)
        else
            ec printf('appending %s to %s', length, file)
            call writefile(lines, file, 'a')
        endif
    else
        call writefile(lines, file)
    endif
endfunction

vnoremap , :<c-u>call VAction('dedent')<CR>
vnoremap . :<c-u>call VAction('indent')<CR>
let g:visualactiondict['indent'] = {'fn': 'VApplyTemplaterEffectToBlock', 'arg': '"    " . v:val'}
let g:visualactiondict['dedent'] = {'fn': 'VApplyTemplaterEffectToBlock', 'arg': 's:sub(v:val, "^    ", "")'}
let g:visualactiondict['block-comment'] = {'i': 'ibmContiguous', 'fn': 'VApplyTemplaterEffectToBlock', 'arg': 's:toggle_comment(v:val)'}

call add(g:lineEditCommands, "call VAction2('block-comment')")

function! s:aorb(a, b)
    let a = a:a
    let b = a:b
    if s:exists(a)
        return a
    endif
    return b
endfunction


function! TextFiles()
    return s:get_files_by_extension('/home/kdog3682/2024/', 'txt')
endfunction

function! s:get_files_by_extension(dir, key)
    let q = '*' . a:key . '*'
    return globpath(a:dir, q, 1, 1)
endfunction
function! VisualMoveToEndOfFile(state)
    call s:appendblock(a:state.lines, '$')
endfunction

let g:visualactiondict['mte'] = {'fn': 'VisualMoveToEndOfFile', 'delete': 1}

" node0
    " run lezer-runExampleFile.js
    " argState
        " file lezer-sampleString.js

function! s:get_file_ref(key, ...)
    let tail = a:0 >= 1 ? s:tail(a:1) : s:tail()
    let value = DictGetter2(g:fileRef, tail, a:key)
    return value
    " if empty(value) && a:0 >= 2
        " return a:2
    " endif
    " return value
endfunction
""" bookmarkId: 1699386620 hfel: g:fileRef """
let g:fileRef = {
  \"style.stylus": {
    \"node1": {"runtimeFile": "stylus.js", "args": ['currentFile']},
    \"linked6": "stylus.js",
  \},
  \"SectionExecutorApps.py": {
    \"node1": {"runtimeFile": "SectionExecutor.py"},
    \"linked6": "examples.py",
  \},
  \"examples.py": {
    \"node1": {"runtimeFile": "SectionExecutor.py", "runtimeFileDEPRECATED": "runExampleFile.py", "args": ['lineNumber']},
    \"linked6": "SectionExecutorApps.py",
  \},
  \"cssGeneratedClasses.template": {
    \"node1": {"run": "packageManager.js", "argFile": "/home/kdog3682/2024/cssGeneratedClasses.template", "fnKey": 'generateCssClassFile'},
  \},
  \"stylescript.grammar": {
    \"node1": {"run": "lezer-runExampleFile.js"},
    \"linked6": "lezer-runExampleFile.js",
  \},
  \"cssGeneratedApps.js": {
    \"linked6": "cssGeneratedApps.template",
  \},
  \"cssGeneratedApps.template": {
    \"node1": {"run": "packageManager.js", "argFile": "/home/kdog3682/2024/cssGeneratedApps.template", "fnKey": 'generateCssAppFile'},
    \"linked6": "cssGeneratedApps.js",
  \},
  \"markdownParser.js": {
    \"node1": {"run": "packageManager.js", "argFile": "examples.js", "fnKey": 'runExampleFile'},
    \"linked6": "examples.js",
  \},
  \"runExampleFile.js": {
    \"node1": {"run": "packageManager.js", "argFile": "examples.js", "fnKey": 'runExampleFile'},
    \"linked6": "examples.js",
  \},
  \"runExampleFile2.js": {
    \"linked6": "examples2.js",
  \},
  \"examples2.js": {
    \"a8file": "runExampleFile2.js",
    \"node1": {"run": "runExampleFile2.js", "argFile": "examples2.js", "fnKey": 'runExampleFile2'},
    \"linked6": "runExampleFile2.js",
    \"file_specific_go_file_items": {
        \"after2": 'node-utils.js'
    \},
    \"execRef": {'cr': 'CreateArgSection', 'j': 'CreateExampleJsSection', },
  \},
  \"examples.js": {
    \"a8file": "runExampleFile.js",
    \"node1": {"run": "packageManager.js", "argFile": "examples.js", "fnKey": 'runExampleFile'},
    \"linked6": "runExampleFile.js",
    \"execRef": {'arg': 'CreateArgSection', 'j': 'CreateExampleJsSection', },
  \},
  \"vuetify.js": {
    \"node1": {"macro": "aa", "run": "componentManager.js", "argFile": "component-sampleString.js", "fnKey": 'componentParser'},
    \"linked6": "component-sampleString.js",
    \"mainFunction": "componentParser",
  \},
  \"simple-css-example.grammar": {
    \"node1": {"run": "lezer-runExampleFile.js", "argFile": "lezer-sampleString.js"},
    \"linked6": "lezer-sampleString.js",
    \"execRef": {},
    \"notes": "this file's runtime is linked to lezer-sampleString",
  \},
  \"simple-example.tokens.js": {
    \"node1": {"run": "lezer-runExampleFile.js", "argFile": "lezer-sampleString.js"},
    \"linked6": "lezer-sampleString.js",
    \"execRef": {},
    \"notes": "this file's runtime is linked to lezer-sampleString",
  \},
  \"component-sampleString.js": {
    \"a8file": "vuetify.js",
    \"node1": {"run": "componentManager.js", "argFile": "component-sampleString.js", "fnKey": 'componentParser'},
    \"linked6": "vuetify.js",
    \"execRef": {'set': 'FileSpecificSetComponentAsMain', 'cr': 'FileSpecificCreate', 'archive': 'ComponentSampleStringArchive', 'a': 'GoToArchive'},
  \},
  \"lezer-sampleString.js": {
    \"shuntFile": "lezer-runExampleFile.js",
    \"a8file": "lezer-runExampleFile.js",
    \"node1": {"run": "lezer-runExampleFile.js", "argFile": "lezer-sampleString.js"},
    \"node0": {"run": "lezer-runExampleFile.js", "argFile": "lezer-sampleString.js"},
    \"linked6": "lezer-runExampleFile.js",
  \},
  \"lezer-J2J.js": {
    \"a8file": "lezer-common.js",
    \"node0": {"run": "lezer-runExampleFile.js", "argFile": "lezer-sampleString.js"},
    \"linked666": "lezer-prettier.js",
    \"linked6": "lezer-sampleString.js",
  \},
  \"sampleString.js": {
    \"linked6": "vuetify.js"
  \}
\}
let g:jspyref3["vim"]["importDependencyStringTemplate"] = ""
let g:jspyref3["python"]["importDependencyStringTemplate"] = ""
let g:jspyref3["javascript"]["importDependencyStringTemplate"] = "import { $1 } from './$2'"
let g:filedict["v"] = "/home/kdog3682/2023/vuetify.js"
let g:visualactiondict['j'] = {'fn': 'VJavascriptConnector'}


let g:filedict["v1"] = "/home/kdog3682/2023/base-components.v1.js"
let g:filedict["ss"] = "/home/kdog3682/2023/sampleString.js"



" VLongDivision and Component Viewer
"
"const asd = asd`
function! SetDefaultExportForSampleStringFile()

    let i = s:fli('^"?const.{-}`', '.', -1, 500, 0, 1)
    let s = getline(i)
    let m = s:getiden(s)
    let p = s:templater2('export default $1', m)

    let i = line('$')
    call s:getsetline('s:comment', i)
    call append(i, p)
    return

    let index = s:fli({s -> len(trim(s)) == 0}, 0, 1, 50, 0) - 1
    for i in range(1, index)
        call s:getsetline('s:comment', i)
    endfor
    call append(index, p)
endfunction
call add(g:lineEditCommands, "SetDefaultExportForSampleStringFile")
let g:wpsnippets2["javascript"]["sto"] = "const storage = new Storage()"
let g:wpsnippets2["javascript"]["release"] = "ReleaseYanks"

function! s:whereami()
    let i1 = s:fli('^::', '.', -1, 200, 0)
    let i2 = s:fli('^\S', '.', -1, 200, 0)
    let component = s:match(getline(i1), '[a-z0-9-]+')
    let loc = s:sub(getline(i2), ' *\{ *$', '', '')
    let t = 'You are at: Component "$1" -- Location "$2"'
    ec s:templater2(t, [component, loc])
endfunction

function! SetActivePackageManagerFunction()
    let g:activeNodePackageManagerFunction = s:choose(g:nodePackageManagerFunctions)
endfunction

function! PerformGlobalReplaceFromLine(s)
    let s = a:s
    let [a,b] = s:so(s)
    call s:global_replace('%', a, b, 'gc')
endfunction
call add(g:lineEditCommands, "PerformGlobalReplaceFromLine")
let g:normalCommands = []
let g:execRef2["nc"] = "NormalCommandController"
" call add(g:normalCommands, "SetActivePackageManagerFunction")
function! GetBufferLineNumber(s)
    let s = a:s
    " let b = getbufinfo(s:bufload(s))
    let b = getbufinfo(s)
    " call input('b: ' . s:string(b))
    let buf = b[0]
    
    return buf.lnum
endfunction

function! Pushdfsdw()
    let v = s:unique(values(g:execRef2))
    " let t = 'call add(g:normalCommands, "$1")'
    " let vals = map(v, 's:templater2(t, v:val)')
    " append('$', vals)
endfunction
let g:execRef2["sap"] = "SetActivePackageManagerFunction"

function! AddUtilExport()
        let index = FindLineIndex('^export \{', '0', 1, 1000)
        if index < 5
            ec 'error'
            return 
        endif
        let word = GetBindingName()
        call append(index + 1, '    ' . word . ',') 
endfunction
function! AddWordToJavascriptImports()
    let file = Tail()
    if file == 'utils.js'
        return AddUtilExport()
    else
        let word = GetCurrentWord()
        if s:in(g:js_star_imports, word)
            call append(0, StarImport(word))
            return 
        endif
        return AddImport(word)
        let word = GetFunctionFromLine2()
        let a8file = s:get_file_ref('a8file')
        if s:exists(a8file)
            call OpenAndLeave(a8file)
        endif
        call AddImport(word)
    endif
endfunction

let g:filedict["ch"] = "/home/kdog3682/2023/ContextHandle.js"

function! PrivatizeThisVar()
    let yanks = s:get_yanks('throwOnEmpty')
    let r = s:ncg(yanks, 'this\.\zs\ze($1)')
    call s:global_replace('%', r, '_', 'gc')
endfunction
function! TouchToLogFile()
    let name = expand('%')
    let p = strftime('%Y-%m-%d') . ' ' . name
	call s:appendfile(g:activeFileLogFile, p)
endfunction
call add(g:lineEditCommands, "PrivatizeThisVar")

function! Sdfjsdfk()
  let result = s:system_cmd("
        \\n ping github.com
  \"dir)
  ec result
endfunction
let g:execRef2["gpds"] = "GitPushDirectories"

let g:blockYanks=[]
function! Y6Yank()
    let yank = s:getlines('code')
    ec printf('added %s lines to g:yanks', len(yank))
    call add(g:yanks, yank)
endfunction
function! Y4Replace()
    let yank = g:yanks[0]
    execute "normal! diwi" . yank . "\<ESC>" . repeat("\<LEFT>", len(yank))
    "asdasda
endfunction
nnoremap <silent> y4 :call Y4Replace()<CR>

function! ReleaseYanks(s)
    function! s:inner(s)
        let s = a:s
        return s:tostring(s) . "\n"
    endfunction
    let value = s:joinlines(map(s:get_yanks(), 's:inner(v:val)'))
    return value
endfunction

nnoremap y6 :call Y6Yank()<CR>

let g:hfelfile = '/home/kdog3682/2024/highFrequencyEditLocations.txt'


function! ReleaseYanks(s)
    function! s:inner(s)
        let s = a:s
        return s:tostring(s) . "\n"
    endfunction
    let value = s:joinlines(map(s:get_yanks(), 's:inner(v:val)'))
    return value
endfunction

nnoremap y6 :call Y6Yank()<CR>

function! SetHighFrequencyEditLocation()
    let ref = s:getvimstate('file', 'timestamp')
    let key = s:get_binding_name()
    call extend(ref, {'binding': key})
    let t = VimTemplater('$bookmarkCommentStart bookmarkId: %s hfel: %s $bookmarkCommentEnd', ref.timestamp, key)
    call s:appendabove(t)
    call s:appendfile(g:hfelfile, s:encode(ref))
endfunction
let g:execRef2["hfel"] = "SetHighFrequencyEditLocation"
function! GoHighFrequencyEditLocation(...)
    let items = s:tolines(s:read(g:hfelfile))
    let items = map(items, 'json_decode(v:val)')
    let currentFile = a:0 >= 1 ? 1 : 0
    let s:currentFile = CurrentFile()
    if currentFile
        function! s:inner(s)
            let s = a:s
            return s.file == s:currentFile
        endfunction
        let items = filter(items, 's:inner(v:val)')
    endif
    let item = s:choose(items, 'binding')
    let a = s:open(item.file, item.timestamp)
endfunction
let g:execRef2["ghf"] = "GoHighFrequencyEditLocation"
let g:GI4Ref["ibmContiguous"] = "GetContiguousIndexesIBM"
let g:GI4Ref["root_to_cursor"] = "Get_root_to_cursor_indexes"

let g:GI4Ref["dashes"] = "GetDashIndexes"

let g:execRef2["gvf"] = "GoVimFunction"

function! s:dict(aa)
    let aa = a:aa
    let store = {}
    for i in range(len(aa))
        let [a,b] = aa[i]
        let store[a] = b
    endfor
    return store
endfunction
function! OpenAndLeave(file)
    let file = a:file
    let s:current = CurrentFile()
    if Tail(file) == Tail(s:current)
        return 
    endif
    call s:print_quote('opening and leaving', file)
    function! s:inner_open_and_leave(id)
        call OpenBuffer3(s:current)
    endfunction

    call OpenBuffer3(file)
    let timer = timer_start(1000, function('s:inner_open_and_leave'))


endfunction
function! TemporaryFileType(key)
    
    let s:current = &filetype
    let key = a:key
    if key == s:current
        return 
    endif
    call s:print_quote('opening and leaving', key)
    function! s:inner_open_and_leave(id)
        execute 'setlocal filetype=' . s:current
    endfunction

    execute 'setlocal filetype=' . key
    let timer = timer_start(1000, function('s:inner_open_and_leave'))
endfunction
function! s:get_bottom_of_file_definitions()
    let p = '^' . s:jspy('commentPrefix') . ' *'
    let i = s:fli(p . 'Definitions', '$', -1, 10, 0, 0, 1)
    let up = i + 1
    let r = '(\w+) *\= *(\S.+)'
    let down = s:fli(p . r, up, 1, 10, 1, 0, 1)
    let store = []
    for i in range(up, down)
        let s = getline(i)
        let m = s:match(s, r)
        call s:push(store, m)
    endfor
    return store
endfunction


function! s:get_file_state(file)
    let file = a:file
    let lineNumber = GetBufferLineNumber(file)
    return { 'file': file, 'lang': &filetype, 'lineNumber': lineNumber, }
endfunction

function! SetNodeArgState()
    call OpenAndLeave(g:activeJavascriptFile)
    let defs = s:get_bottom_of_file_definitions()
    if empty(defs)
        throw 'defs is empty'
        return 
    endif
    let d = s:dict(defs)
    let keys = [
        \'file',
        \'arg',
        \'debug',
        \'fnKey',
    \]

    for key in keys
        if !has_key(d, key)
            throw printf('key: "%s" is required', key)
        endif
    endfor
    ec d
    let s:nodeArgState = d
endfunction
function! SetCurrentFileAsNode0FileState()
    let ref = DictGetter2(g:fileRef, Tail(), 'node0')
    if s:exists(ref)
    let s:node0_file_state = ref
    ec 'SetCurrentFileAsNode0FileState Success for: ' . string(ref)
    else
        ec 'did not set node0_file_state'
        ec 'perhaps Tail() not in g:fileRef'
    endif
endfunction
function! NodePackageManager3()
    """"""""""""""""""""""""""""""""
    """ bookmarkId: 1699392197 hfel: node0 """
    let ref = DictGetter2(g:fileRef, Tail(), 'node0')
    if s:exists(ref)
        let state = s:get_file_state(ref.argFile)
        return NodeTerminalOrShell(ref.run, state)
    elseif exists('s:node0_file_state')
        let ref = s:node0_file_state
        let state = s:get_file_state(ref.argFile)
        return NodeTerminalOrShell(ref.run, state)
    endif
    """"""""""""""""""""""""""""""""
    throw 'todo'

    if !exists('s:nodeArgState')
        call SetNodeArgState()
    endif
    let lineNumber = GetBufferLineNumber(s:nodeArgState.file)
    let s:nodeArgState.lineNumber = lineNumber
    let state = s:nodeArgState
    " return state
    let arg = ShellEscape(s:string(state))
    call NodeTerminalOrShell('packageManager.js', state.fnKey, arg)
endfunction
let s:config = {'shell': 0, 'use_override_ref': 0, 'last_file': 0, 'use_override_node_file': 0, 'debug': 0}
let g:config = {"null": 0, 'shell': 0, 'use_override_ref': 0, 'last_file': 0, 'use_override_node_file': 0, 'debug': 0, 'last_touched_raw_file': 0, 'txflow_equal_sign':0, 'use_deno': 0, 'debug_shell_cmd': 0, 'use_system': 0}
function! ToggleConfig() abort
    let m = 0
    try
        let m = s:choose(g:config)
        if empty(m)
            return 
        endif
    catch
        return 
    endtry
    let [a,b] = m
    let value = b == 0 ? 1 : 0
    if a == 'last_file'
        if empty(b)
            let value = CurrentFile()
        else
            let value = 0
        endif
    endif
    let s:config[a] = value
    if a == 'use_override_node_file'
        let g:override_node_file = CurrentFile()
        ec 'setting g:override_node_file to: ' . g:override_node_file
    endif
    let s:selected_config_key = a
    call BluePrint('%s: "%s"', a, value)
endfunction
function! NodeTerminalOrShell(file, ...)
    return SystemExec(a:file, a:000)
    let file = a:file
    let shell = s:config.shell

    let args = map(Flat(a:000), "ShellEscape(s:encode(v:val))")
    let key = shell ? 'EvaluateFromShell' : 'Node'
    let prefix = shell ? '' : '!'
    let shell_item = s:ge(file) == 'py' ? 'python3' : 'node'
    let path = s:ge(file) == 'py' ? '/home/kdog3682/PYTHON/' . file : file
    let cmd = prefix . "clear; " . shell_item . ' ' . path . ' ' . join(Flat(args), " ")
    if shell
        let results = systemlist(cmd)
        let result = s:goto_shell_error(results)
        return results
    else
        execute cmd
    endif
endfunction
function! s:print_quote(s, arg)
    let s = a:s
    let arg = a:arg
    ec s . ': ' . s:doublequote(arg)

endfunction
let g:filedict["s2"] = "/home/kdog3682/2023/sampleString2.js"
function! s:isword(word)
    let word = a:word
	return s:t(word, '^[a-z]+\d*$')
endfunction
let g:execRef2["ffr"] = "FindFFRItem"
let g:filedict["lss"] = "/home/kdog3682/2023/lezer-sampleString.js"
function! s:goto_shell_error(block)
    let block = a:block
    if s:t(block[-1], '^node.js')
        " error
        let string = s:tostring(block)
        let r =  'file://(.{-}):(\d+)'
        let m = s:findall(string, r)
        if s:exists(m)
            let match = s:choose(m[0:5])
            let [file, line] = s:match(match, r)
            call s:open(file, line)
        endif
    endif
    return s:joinlines(block)
endfunction
let g:execRef2["sno"] = "SetCurrentFileAsNode0FileState"
let g:execRef2["tc"] = "ToggleConfig"

let g:jspyref3["vim"]["temporaryLogTemplate"] = ""
let g:jspyref3["python"]["temporaryLogTemplate"] = ""
let g:jspyref3["javascript"]["temporaryLogTemplate"] = "console.temporary($1)"
function! SetTemporaryLog()
    let ref = s:getvimstate('file', 'timestamp')
    let word = s:gcw()
    call s:appendbelow(s:templater2(s:jspy('temporaryLogTemplate'), word))
    call s:appendfile('temporaryLogs.txt', CurrentFile())
endfunction
let g:execRef2["stl"] = "SetTemporaryLog"
" 11-08-2023 


function! s:jspy2(file, key)
    let file = a:file
    let filetype = s:get_file_type(file)
    let key = a:key
    return DictGetter2(g:jspyref3, filetype, key)
endfunction
function! RunPrevFile()
    let file = bufname('#')
    let shell = s:jspy2(file, 'shellTemplate')
    if s:exists(shell)
        wa
        let shell = s:templater2(shell, file)
        execute shell
    endif
endfunction

let g:jspyref3["vim"]["shellTemplate"] = ""
let g:jspyref3["python"]["shellTemplate"] = "!python3 $1"
let g:jspyref3["javascript"]["shellTemplate"] = "!node $1"
let g:execRef2["rpf"] = "RunPrevFile"
let g:execRef2["vim"] = "GotoVimFunctionViaBinding"
let g:filedict["pm2"] = "/home/kdog3682/2023/packageManager2.js"

function! Iuna(key)
    " test: "is"
    " call TemporaryFileType('javascript')
    let ref = SeeMappings(a:key, 'iab')
    call UnmapController(ref[0])
endfunction
let g:execRef2["iuna"] = "Iuna"
let g:wpsnippets2["javascript"]["ifp"] = "if (isPlural($1)) {\n    $c\n}"
let g:wpsnippets2["javascript"]["ifj"] = "if (isJsonParsable($1)) {\n    $c\n}"
let g:execRef2["ns"] = "NormalWPSnippet"


let g:wpsnippets2["vim"]["template"] = "GetWPTemplate"

function _GetSnippet2(lang, key)
    let lang = a:lang
    let key = a:key
    let e = 'js'
    let ref = g:wpsnippets2
    let t = DictGetter3(ref, lang, key)
    if s:exists(t)
        return t
    endif
        let t = DictGetter3(ref, e, key)
    if s:exists(t)
        return t
    endif
        let t = DictGetter3(ref, 'global', key)
    if s:exists(t)
        return t
    endif
        let t = DictGetter3(g:wpsnippets, e, key)
    if s:exists(t)
        return t
    endif
endfunction
function GetWPTemplate(key)
    " test: "s"
    let key = a:key
    let lang = 'javascript'
    let t = _GetSnippet2(lang, key)
    let a = 'let g:wpsnippets2["$lang"]["$key"] = "$template"'
    let ref = {"lang": lang, "template": t, "key": key}
    let value = s:templater2(a, ref)
    let value = s:sub(value, '\n', '\\n')
    return value
endfunction



let g:wpsnippets2["javascript"]["s"] = 'NamedJavascriptString'
" NamedJavascriptString
" let ${TimestampString($1)}
function s:global_remove_starting_logs() 
    let r = '\ze^console.log'
    let rep = 'abc'
    call s:global_replace('%', r, rep, 'gc')
endfunction 
function NamedJavascriptString(...)
    let name = a:0 >= 1 ? a:1 : ''
    let basename = s:sub(name, ' ', '_')
    let name = 'str_' . strftime('%s') . '_' . basename 
    " call s:global_remove_starting_logs()
    " let t = "const $name = `\n    $c\n`\nconsole.log($basename($name))\n"
    let t = "const $name = `\n    $c\n`\nrunTest($basename, $name)\n"
    let ref = {"name": name, "basename": basename}
    return s:templater2(t, ref)
endfunction

function ListActiveBuffers()
    let a = s:comment(GetActiveBuffers())
    return append('$', s:tolines(a))
endfunction

" /home/kdog3682/.vimrc
" /home/kdog3682/2024/files.log
" /home/kdog3682/2023/lezer-runExampleFile.js
" /home/kdog3682/2023/node-utils.js
" /home/kdog3682/2023/vuetify.js
" /home/kdog3682/2023/packageManager.js
" /home/kdog3682/2023/packageManager2.js
" /home/kdog3682/RESOURCES/help.md
" /home/kdog3682/2023/lazyObjectParser.js
" /home/kdog3682/2024/style.css
let g:execRef2["lab"] = "ListActiveBuffers"
" nnoremap 3 :call Node3()<CR>
let g:execRef2["p"] = "RunActiveFile"
" /home/kdog3682/2024/files.log
" /home/kdog3682/2023/lezer-runExampleFile.js
" /home/kdog3682/2023/node-utils.js
" /home/kdog3682/2023/vuetify.js
" /home/kdog3682/2023/packageManager.js
" /home/kdog3682/2023/packageManager2.js
" /home/kdog3682/RESOURCES/help.md
" /home/kdog3682/2023/lazyObjectParser.js
" /home/kdog3682/2024/style.css
" /home/kdog3682/.vim/ftplugin/functions2.vim
" /home/kdog3682/2023/sampleString.js
" /home/kdog3682/2023/OX3HTML.js
" /home/kdog3682/2023/runExampleFile.js

function! FileRefRunner2(ref)
    let ref = a:ref
    let runtimeFile = get(ref, 'runtimeFile', '')
    let after = get(ref, 'after', '')
    let argFile = get(ref, 'argFile', '')
    let args = get(ref, 'args', [])
    let args = GetPackageManagerArgs(args)
    let result = EvaluateFromShell(runtimeFile, argFile, args)
    if HasShellError(result)
        ec result
        return 
    endif

    if s:exists(after)
        execute after
    endif

endfunction

function! FileRefRunner(...)
    let VersionedFileRefRunners = {
        \ '2': 'FileRefRunner2'
    \}
    let ref = a:0 >= 1 ? a:1 : s:node_file_state
    if has_key(ref, 'version')
        return function(VersionedFileRefRunners[ref['version']])(ref)
    endif
    if a:0 >= 1
        let s:node_file_state = ref
    endif
    if has_key(ref, 'runtimeFile')
        let args = []
        if has_key(ref, 'args')
            let args = GetPackageManagerArgs(ref.args)
        endif
        return NodeTerminalOrShell(ref.runtimeFile, args)
    endif
    if !has_key(ref, 'argFile')
         return NodeTerminalOrShell(ref.run)
    endif
    let lineNumber = GetBufferLineNumber(ref.argFile)
    let s:node_file_state.lineNumber = lineNumber
    let s:node_file_state.file = ref.argFile
    return NodeTerminalOrShell(s:node_file_state.run, s:node_file_state)
endfunction

function! EditNodeArgState(...)
    if !exists('s:node_file_state')
        call s:red('no node file state ... define it by entering via node1 ... probably at vuetify.js')
        return 
    endif
    let key = s:node_file_state.fnKey
    let master = {
        \'componentParser': {
            \'postParseKey': ['default', 'str', 'template', 'mounted', 'data','collectClassNames', 'nodeCollectClassNames', 'exportToComponentFile'],
            \'debug': ['text', 'config'],
        \}
    \}
    let input = a:0 >= 1 && s:exists(a:1) ? a:1 : ''
    let ref = master[key]
    if empty(input)
        for [k,v] in items(ref)
            " redraw!
            call s:red(k)
            try
                let value = s:choose(v)
                let s:node_file_state[k] = value
            catch
                return 
            endtry
            " ec printf('s:node_file_state["%s"] = "%s"', k, value)
        endfor
        redraw!
        ec s:node_file_state
        return
    endif
    for [k,v] in items(ref)
        if s:in(v, input)
            let s:node_file_state[k] = input
            ec printf('s:node_file_state["%s"] = "%s"', k, input)
            ec s:node_file_state
            return 
        endif
    endfor
endfunction
nnoremap ) :call EditNodeArgState('')<Left><left>

function! s:save_input(s)
    let s = a:s
    if empty(s)
        return ''
    endif
    let s:saved_input = s
    return s
endfunction

function! s:get_input()
    if !exists('s:saved_input')
        let s:saved_input = s:prompt('a value is required for s:saved_input')
    endif
    return s:saved_input
endfunction
let g:execRef2["nfs"] = "EditNodeArgState"

function! HorizontalRule()
    return g:keyboard.enter . repeat('-', 76) . g:keyboard.enter . g:keyboard.eat
endfunction

let g:fileVersions = []
function! SetupVersioning()
    let s = getline('.')
    let tail = Tail()
    let activeFile = s:tail(s:gval('active' . s:cap(&filetype) . 'File'))
    let p = hi
    AppendAndExecute(p)
endfunction

function! GoMain()
    let f = s:get_file_ref('mainFunction')
    if s:exists(f)
        call OpenFunction(f)
    endif
endfunction
let g:execRef2["gm"] = "GoMain"
nnoremap <s-right> :call ShiftArrowRight()<CR>
function! ShiftArrowRight()
    if exists('s:log_console_results')
        let next = s:modular_increment(s:log_console_results, 'lc', 1)
        call s:open(next.file, next.lineNumber)
        return 
    endif
    let extensions = [
        \'js',
        \'html',
        \'css',
    \]
    let tail = Tail()
    if tail == 'component-sampleString.js'
        let f = s:get_component_section_name() . '.css'
        if IsFile(f)
            return s:open(f)
        else
            if s:exists(s:prompt('not a css file ... do you wish to make it'))
                call FS_CreateClassFileAndUpdateVuetifyHTML()
            endif
        endif
        return 
    endif
    let e = GetExtension(tail)
    if !s:in(extensions, e)
        return 
    endif
    let next = ModularIncrement2(extensions, e)
    let file = s:sub(tail, e . '$', next)
    while !IsFile(file)
        let e = GetExtension(file)
        let next = ModularIncrement2(extensions, e)
        let file = s:sub(file, e . '$', next)
    endwhile
    call OpenBuffer3(file)
endfunction
let g:wpsnippets2["javascript"]["ift"] = "if ($2.test($1)) {\n    $c\n}"
let g:wpsnippets2["javascript"]["ccc"] = "if ($2.test($1)) {\n    $c\n}"

function! GetVisualIndexes(...)
    let flag = a:0 >= 1 ? 1 : 0
    let a = getpos("'<")
    let b = getpos("'>")
    if empty(flag)
        return [a[1], b[1]]
    else
       let flag = a[1] == b[1] && a[2] == b[2]
       return [[a[1], b[1]], flag]
    endif
endfunction
function! s:tail(...)
    " test: "/home/kdog3682/2023/vuetify.js"
    if a:0 >= 1
        return fnamemodify(a:1, ':t')
        return split(s:replace(a:1, '/$', ''), '/')[-1]
    else
        return expand('%:t')
    endif
endfunction

function! PickBuffer()
    let buffers = GetActiveBuffers('js')
    let b = s:choose(buffers)
    call OpenBuffer3(b)
endfunction
function! GetActiveBuffers(...)
  let f = 'buflisted(v:val)'
  let buffers = filter(range(1, bufnr('$')), f)
  let names = map(buffers, 'bufname(v:val)')
  if a:0 >= 1 && s:exists(a:1)
      let f = 's:t(v:val, "\\." . a:1 . "$")'
      let names = filter(names, f)
  endif
  return names
endfunction
let g:execRef2["pb"] = "PickBuffer"

function! s:choose_multiple(items, ...)
    " test: ['a', 'b', 'c']
    let limit = a:0 >= 1 ? a:1 : 10
    let items = copy(a:items)
    let store = []
    let c = 0
    call BlueList(items)
    while c < 10
        let c += 1
        let ans = s:getchar()
        if ans == g:keyboard.enter
            return store
        endif
        let value = items[ans - 1]
        if s:in(store, value)
            continue
        endif
        call add(store, value)
        if len(store) == limit
            return store
        endif
        ec 'num items: ' . len(store)
    endwhile
    return store
endfunction
let g:execRef2["link"] = "EstablishLinkedBuffers"
let g:simpleLinkedBuffers = {}
let g:simpleLinkedBuffers["/home/kdog3682/2023/lezer-sampleString.js"] = "/home/kdog3682/2023/lezer-runExampleFile.js"
let g:simpleLinkedBuffers["/home/kdog3682/2023/lezer-runExampleFile.js"] = "/home/kdog3682/2023/lezer-sampleString.js"


function! GetCMStuff(key)
    if !exists('s:cmjson')
        let s:cmjson = items(s:read('/home/kdog3682/2024/cm.json'))
    endif
    let items = filter(copy(s:cmjson), 's:t(v:val[0], a:key)')
    let keys = map(items, 'v:val[0]')

    " s:choose_multiple(keys)
    let values = map(items, 's:tolines(v:val[1])')
    for item in values
        call append('$', item)
    endfor
    " call append('$', values)
endfunction
let g:execRef2["cm"] = "GetCMStuff"

function! GoComponent()
    let r = 'v-\S+'
    let m = WordSpiralForOneMatch(r)
    if empty(m)
        let m = s:get_component_section_name()
    endif
    call s:goto_component_name(m)
endfunction
function! WordSpiralForOneMatch(r)
    " test: "asfdasdfasdf"
    let r = a:r
    let c = 0
    let i = line('.')
    let dir = 1
    let [a,b] = s:gi('window')
    let delta = b - a
    while c < delta
        let c += 1

        if i >= a && i <= b
            let s = getline(i)
            let m = s:match(s, r)
            if s:exists(m)
                return m
            endif
        endif
        let dir = -1 * dir
        let increment = c * dir
        let i += increment
    endwhile
endfunction


function! s:regex(r)
    try
        execute "normal! m'"
        execute '/\v' . a:r
        normal! zt
        return 1
    catch
        ec v:exception
        ec 'no match: ' . string(a:r)
        return 0
    endtry
endfunction
nnoremap gc :call GoComponent()<CR>
function! FileSpecificSetComponentAsMain()
                let r = '(v-\S+)'
                let m = s:match(getline('.'), r)
                if empty(m)
                    ec 'no match'
                    return 
                endif
                let i = s:fli('^main', 1, 1, 100, 0)
                let i = s:fli('^main', i, 1, 100, 1)
                call append(i - 1, 'main: ' . m)
endfunction

function! FileSpecificCreate(...)
    let s = a:0 >= 1 ? s:spaces_to_dashes(a:1) : s:match(getline('.'), '[a-z0-9-]+')
    let name = s:t(s, '^v-') ? s : 'v-' . s
    let t = ['', s:hr(76),  'name: ' . name, '', '']
    let i = line('$') - 1
    call append(i, t)
    call cursor(i + 5, 100)
    startinsert!
    
endfunction
let g:filedict["lss"] = "/home/kdog3682/2023/lezer-sampleString.js"
let g:filedict["vite"] = "/home/kdog3682/2023/viteServe.js"
let g:filedict["css"] = "/home/kdog3682/2023/component-sampleString.js"
function! GoLastWrittenFile()
    let data = s:read('/home/kdog3682/2024/savewrite-filename.txt')
    let file = trim(data)
    call OpenBuffer3(file)
endfunction

function! YankCopyBuffer()
    let s = s:tostring(s:read('/home/kdog3682/2024/vim-copybuffer.txt'))
    let @" = s
    ec 'yanked copy buffer: ' . len(s) . ' characters'
endfunction
let g:execRef2["ycb"] = "YankCopyBuffer"

function! ChangeFileExtension(file, e)
    " test: "asdf.css", "asd"
    let file = a:file
    let e = GetExtension(file)
    return s:sub(file, '\.' . e . '$', '.' . a:e)
endfunction

let g:fileRef["examples.js"]["execRef"]["o"] = "SetEJSOutpath"
let g:fileRef["examples.js"]["execRef"]["i"] = "SetEJSInpath"
let g:fileRef["lezer-sampleString.js"]["execRef"] = {}
let g:fileRef["lezer-sampleString.js"]["execRef"]["arg"] = "CreateLezerArgSection"

let g:fileRef["component-sampleString.js"]["execRef"]["main"] = "FS_SetCurrentComponentAsTocMain"
let g:fileRef["component-sampleString.js"]["execRef"]["cl"] = "FS_CreateClassFileAndUpdateVuetifyHTML"
let g:fileRef["component-sampleString.js"]["execRef"]["toc"] = "FS_Component_Toc"
let g:fileRef["component-sampleString.js"]["execRef"]["update"] = "FS_Update_Toc"
let g:fileRef["component-sampleString.js"]["execRef"]["skip"] = "FS_CS_Skip"
let g:fileRef["component-sampleString.js"]["execRef"]["get"] = "FS_CS_Get"
function! FS_CS_Get()
    let file = '/home/kdog3682/2024/componentSampleStrings.json'
    let a = s:choose_dict_value(file)
    let i = s:fli('`', '$', -1, 100, 0, 1) - 1
    let lines = [s:hr(70)] + s:tolines(a)
    call append(i, lines)
endfunction
function! FS_CS_Skip()
    let i = s:fliup('^--')
    call append(i, 'skip: true')
endfunction
function! FS_SetCurrentComponentAsTocMain()
    let m = s:get_component_section_name()
    let i = s:fli('^main:', 1, 1, 100, 0)
    let i = s:fli('^---', i, 1, 100, 0)
    call s:red(s:colon('setting main', m))
    call append(i - 1, 'main: ' . m)
endfunction

" function! ToggleComment1000(s)
    " let s = a:s
" endfunction
nnoremap <silent> db :call DeleteBlock()<cr>
nnoremap ez :call OpenBuffer4(g:currentMostActiveFile)<CR>
" nnoremap eb :call OpenBuffer4(GetBackupFileFromCurrentFile())<CR>
nnoremap ebf :call OpenBuffer4(GetBackupFile())<CR>
let g:activeFileLogFile = '/home/kdog3682/2024/files.log'
nnoremap ed :call OpenBuffer4('/home/kdog3682/.vim/ftplugin/css-data.vim')<CR>
let g:wpsnippets2["javascript"]["t"] = "const t = `\n    $c\n`"

function! VisualVarialize(state)
    let state = a:state
    
endfunction
let g:visualactiondict['varialize'] = {'fn': 'VisualVarialize'}

function! AddExportToFileAndImportToAllFiles()
    let name = GetBindingName()
    call AddExport(name)
    let destination = bufname('#')
    call OpenAndLeave(destination)
    call AddImport(name, destination)
endfunction
let g:execRef2["aef"] = "AddExportToFileAndImportToAllFiles"
let g:filedict["n2"] = "/home/kdog3682/2023/next2.js"
let g:jspyref3["markdown"]["execFunctions"]["m"] = "ToggleMarkdownCompletion"

function! ToggleMarkdownCompletion()
    if exists('b:autocomplete') && b:autocomplete == 1
        ec 'closing autocomplete'
        let b:autocomplete = 0
        augroup autocomplete
            autocmd!
        augroup END
    else
        ec 'activating markdown autocompletion'
        let b:autocomplete = 1
        let b:lastCompletionTrigger = ''

        augroup autocomplete
            autocmd!
            autocmd InsertLeave   *.md let b:lastCompletionTrigger = ''
            autocmd InsertCharPre *.md silent! call MDCompletion()
            autocmd CompleteDone  *.md call OnCompleteDone()
        augroup END
    endif
endfunction

function! MDCompletion()
    let vc = v:char =~ '[a-z]'
    if vc
        let b:lastCompletionTrigger .= v:char
        if len(b:lastCompletionTrigger) >= 5
            return 
        endif
    else
        let b:lastCompletionTrigger = ''
    endif
    if vc && !pumvisible()
        let COMPLETER = "\<C-x>\<c-u>"
        call feedkeys(COMPLETER, "n")
        return 
        call feedkeys(CRCompletion(s:months), 'n')
        return 
        call input(string(b:lastCompletionTrigger))
        " silent! 
    endif
endfunction

function MarkdownComplete(findstart, base)
    let a = 'aa'
    call input(string(a))
    if a:findstart
        return col('.') - len(s:vcharstring) - 1
    else
        throw 'a'
        return s:months
        return GetMarkdownWords(s:vcharstring)[0: g:pumheight]
    endif
    """ bookmarkId: 1699663380 hfel: MarkdownComplete """
endfunction
function! FS_CreateClassFileAndUpdateVuetifyHTML()
    let ref = copy(s:get_file_ref('node1'))
    let lineNumber = GetBufferLineNumber(ref.argFile)
    let ref.lineNumber = lineNumber
    let ref.file = ref.argFile
    let ref.postParseKey = 'nodeCollectClassNames'
    let s:config.shell = 1
    let raw = NodeTerminalOrShell(ref.run, ref)
    let s:config.shell = 0
    let file = raw[-1]
    let htmlfile = 'vuetify.html'
    call AppendHtmlAndGoCssFile(htmlfile, file)
endfunction

function! s:appendbufline(file, i, s)
    let file = a:file
    let i = a:i
    let s = a:s
    call BufLoad(file)
    call appendbufline(file, i, s)
endfunction

function! s:buffer_fli(lines, x, start, increment, ...)
    let threshold = a:0 >= 1 && s:exists(a:1) ? a:1 : 200
    let anti = a:0 >= 2 && s:exists(a:2) ? 1 : 0
    let allowStart = a:0 >= 3 && s:exists(a:3) ? 1 : 0
    let skipNewlines = a:0 >= 4 && s:exists(a:4) ? 1 : 0
    let start = a:start
    if start == 1
        let start = 0
    endif
    let i = start
    let lines = a:lines
    let increment = a:increment
    let X = s:testf(a:x)

    let c = 0
    let max = len(lines) - 1

    while c < threshold
        if i > max
            return max
        endif
        let c += 1
        let line = lines[i]
        if skipNewlines && empty(trim(line))
            let i += increment
            continue
        endif
        if anti
            if !X(line)
                let value = i - increment
                if allowStart
                    return value
                endif
                if value != start
                    return value
                endif
            endif
        else
            if X(line)
                if allowStart
                    return i
                endif
                if i != start
                    return i
                endif
            endif
        endif
        let i += increment
    endwhile
    throw '-1'
endfunction

function! AppendHtmlAndGoCssFile(file, cssFile)
    let file = a:file
    let cssFile = a:cssFile

    if !IsFile(file)
        return 
    endif
    if !IsFile(cssFile)
        return 
    endif
    let lines = readfile(file)
    let text = s:tostring(lines)
    if s:t(text, cssFile)
        call s:open(cssFile, 10)
        return 
    endif
    let i = s:buffer_fli(lines, 'insertion-point-below', 0, 1) + 1
    nb.,gg abc
    let spaces = s:getindent(lines[i])
    let t = '<link rel="stylesheet" href="$1"/>'
    let result = s:templater2(t, cssFile)
    call s:appendbufline(file, i, s:indent(result, spaces))
    call s:open(cssFile, 10)
    let g:activeCssFile = cssFile
endfunction
function! ShiftArrowLeft()

    if exists('s:log_console_results')
        let next = s:modular_increment(s:log_console_results, 'lc', -1)
        call s:open(next.file, next.lineNumber)
        return 
    endif
    let t = s:tail()
    let decred = s:change_file_name(t, ')
    if s:is_file(decred)
        call s:open(decred)
    endif
    if !s:t(t, '^v-')
        return 
    endif
    let r = '^name: ' . s:remove_extension(t) . '>'
    call s:open('/home/kdog3682/2023/component-sampleString.js', r)
endfunction
function! s:remove_extension(s)
    let s = a:s
    return s:sub(s, '\.\w+$', '')
endfunction
nnoremap <s-left> :call ShiftArrowLeft()<CR>
function! s:get_component_section_name()
    return s:sprawl_match('^name: (\S+)')
endfunction

function! s:goto_component_name(s)
    let s = a:s
	call s:regex('^name: ' . s . '[ \n]')
endfunction

function! FS_Component_Toc()
    let i = s:fli('^tableofcontents', 1, 1, 100, 0)
    let c = 0
    let store = []
    while c < 100
        let c += 1
        let i += 1
        let s = getline(i)
        if empty(s)
            continue
        endif
        if s:t(s, '^\S+:')
            break
        endif
        call add(store, s)
    endwhile
    let p = s:choose(store)
    call s:goto_component_name(p)
endfunction

function! s:vertical_table(items)
    " test: [1,'aaa',3,5,6,7,8]

    let items = a:items
    let lists = SplitList(items, 10)
    let store = []
    let h = len(lists[0])
    let w = len(lists)
    let t = ''
    for i in range(h)
        for j in range(w)
            try
                let t .= lists[j][i]
            catch
            endtry
        endfor
        let t .= "\n"
    endfor
    let t = trim(t)
    return t
endfunction
function! SplitList(list, n)
    let list = a:list
    let n = a:n
  let result = []
  let sublist = []

  let c = 0
  let longest = 0
  for item in list
    let c += 1
    let item = c . '. ' . item
    if len(item) > longest
        let longest = len(item) + 2
    endif
    call add(sublist, item)

    " Check if sublist has 10 items
    if len(sublist) == n
      let sublist = map(sublist, 'v:val . repeat(" ", 2 + longest - len(v:val))')
      call add(result, sublist)
      let sublist = []
    endif
  endfor

  " Add the remaining items (if any) to the result
  if len(sublist) > 0
    call add(result, sublist)
  endif
  let result[-1] = map(result[-1], 'trim(v:val)')
  return result
endfunction

function! FS_Update_Toc()
    let r = '^name: +\zs\S+'
    let matches = s:global_findall(r)
    let t = 'tableOfContents:'
    let block = [t, ''] + matches + ['', '', 'main: ' . matches[-1], '', '', s:hr(76)]

    let up = s:fli('^tableofcontents', 1, 1, 100, 0)
    let down = s:fli('^---', up, 1, 100, 0)
    call s:replaceblock([up, down], block)
endfunction


function! s:global_findall(r)
    let r = a:r
    let base = SearchText(-1000, r)
    return base
    let t = s:joinlines(getline(1, '$'))
    let m = s:unique(s:findall(t, r))
    ec m
    return m
    let p = getpos('.')
    let store = []
    let t = "%%s/\\v%s/call add(store, s:match(getline('.')))/gn"
    execute printf(t, r)
    call setpos(".", p)
    ec store
    return store
endfunction
function! GISmartBlockFTCss()
    let a = s:issol()
    if a
        let up = line('.')
        let down = s:fli({x -> len(x) == 0}, '.', 1, 100, 0)
        return [up, down]
    endif
    let up = s:fli('\{', '.', -1, 100, 0)
    let down = s:fli('\}', '.', 1, 100, 0)
    return [up, down]
endfunction
let g:wpsnippets2["css"]["ab"] = ".speaker-container > .right {\n\nwidth: 200pt;\nfont-family: 'alegreya';\nbackground-color: #ef4444 /* red-500 */;\n}"
let g:wpsnippets2["css"]["grid"] = "CssGrid"

function! CssGrid(n)
    " test: 2
    let n = a:n
    let name = s:css_get_name()
    let store = []
    for i in range(n)
        let a = name
        let b = i + 1
        let c = s:n2char(i)
        let p = printf("%s:nth-child(%s) {\n    grid-area: %s;\n}\n", a, b, c)
        call extend(store, s:tolines(p))
    endfor
    " call s:set_css_items_at_cursor('flex bgr1')
    call s:css_append_below_block(store)
    
endfunction

function! s:regex_map(items, r)
    let items = map(copy(a:items), 's:match(v:val, a:r)')
    return filter(items, 's:exists(v:val)')
endfunction
let g:visualactiondict['css'] = {'fn': 'VisualCssGatherPropertiesFromBlock'}
function! CssAnime(name)
    " test: "asd"
    let name = a:name
    " let name = s:css_get_name()
    let t = g:wpsnippets2["css"]["keyframes"]
    let items = g:cabmap.anime
    " return items
    let items[0][1] = name
    let payload = s:css_array_string(items, '    ')
    let i = s:fli('\}', '.', 1, 100, 0)
    call append(i - 1, payload)
    let a = 'rotate: 0deg;'
    let b = 'rotate: 360deg;'
    let bottom = s:tolines(s:templater2("\n\n" . t, [name, a, b]))
    " call input('bottom: ' . s:string(bottom))
    call append(i + len(payload), bottom)
endfunction
function! VisualCssGatherPropertiesFromBlock(state)
    let state = a:state
    let r = '(\S+): (.{-})\ze%(;|$)'
    let items = s:regex_map(state.lines, r)
    if empty(items)
        return 
    endif
    let key = s:input(items, 'choose a key for this set')
    call DictSetter('g:cabmap', key, items)
endfunction

function! s:input(items, s)
    let items = a:items
    let s = a:s
    let m = s:string(items) . ': ' . s
    call s:blue(m)
    return input('')
endfunction
let g:jspyref3["css"]["execFunctions"]["gather"] = "VisualCssGatherPropertiesFromBlock"
let g:jspyref3["css"]["execFunctions"]["anime"] = "CssAnime"
let g:jspyref3["css"]["execFunctions"]["bs"] = "OpenBuffer4('bootstrap.css')"
let g:jspyref3["css"]["execFunctions"]["var"] = "CssVarialize"
let g:filedict["ftcd"] = "/home/kdog3682/.vim/ftplugin/css-data.vim"
function! s:css_get_name()
    if &filetype == 'vim'
        return 'aaa'
    endif
    return s:sprawl_match('\v^([a-z0-9. -]+\S) +\{ *$')
endfunction


function! VFunction(state)
    let state = a:state
    let lines = s:smartindent(state.lines, 4)
    let [a,b] = s:jspy('functionTemplateLines')
    call s:replaceblock(state.indexes, [a] + lines + [b])
endfunction
let g:visualactiondict['f'] = {'fn': 'VFunction'}

function s:css_append_below_block(snippet)
    let snippet = a:snippet
    let i = s:fli('^\}', '.', 1, 100, 0)
    call append(i, ['', ''])
    call Jump(i + 2)
    return PlaceSnippet(snippet)
endfunction


let g:jspyref3["vim"]["functionTemplateLines"] = ['function Abc()', 'endfunction']
let g:jspyref3["python"]["functionTemplateLines"] = ["def abc():", ""]
let g:jspyref3["javascript"]["functionTemplateLines"] = ["function abc(s) {", "}"]

function! s:random_int()
    return string(rand())[1]
endfunction
function! s:random_pick(items)
    " test: s:months
    let arrayLength = len(a:items)
    let randomIndex = min([s:random_int(), arrayLength - 1])
    let randomElement = a:items[randomIndex]
    return randomElement
endfunction
function! CssGetGradient()
    let gradients = s:random_pick(g:cssGradients)['colors']
    let grads = join(gradients, ', ')
    return printf('linear-gradient(to right, %s)', grads)
endfunction
function! ParsedCssItems(s, ...)
    let spaces = a:0 >= 1 ? a:1 :  '    '
    let s = a:s
    function! s:inner(s)
        let s = a:s
        if s:t(s, '^\$')
            return eval(s[1:])
        endif
        return s
    endfunction
        let items = CssGetItems(s)
        let t = spaces . '%s: %s;'
        let payload = map(items, 'printf(t, v:val[0], s:inner(v:val[1]))')
        return payload
endfunction
function! s:set_css_items_at_cursor(s)
        let payload = ParsedCssItems(a:s)
        return AppendBlockAtCursor(payload)
endfunction

function! s:css_array_string(s, ...)
    let spaces = a:0 >= 1 ? a:1 :  '    '
    let s = a:s
    let t = spaces . '%s: %s;'
    return map(copy(s), 'printf(t, v:val[0], v:val[1])')
endfunction
let g:wpsnippets2["css"]["scope"] = ":scope {\n    $  \n}"
function! s:uncomment(s)
    let s = a:s
    if &filetype == 'html'
        return substitute(s, '\v<!-- (.{-}) -->', submatch(1), '')
    endif

    if &filetype == 'css'
        return substitute(s, '\v/\* (.{-}) \*/', '\=submatch(1)', '')
    endif

    if &filetype == 'javascript' || &filetype == 'python'
        return substitute(s, '\v^[/#]+ *', '', '')
    endif
endfunction



function! CssSecondaryIncrementWrapper(dir)
    call s:getsetline({s-> CssSecondaryIncrement(s, a:dir)})
endfunction
function! Npm2(s)
    " test: "d tailwind"
    let [cmd, d] = s:mget(a:s, '^d +')
    let d = s:exists(d) ? ' -D ' : ' '
    let e = '!npm i' . d . cmd
    execute e
    return e
endfunction
let g:execRef2["npm"] = "Npm2"
function! Bray()
        " finding your tribe of people
        " /home/kdog3682/2024/node_modules
        " cd /home/kdog3682/2024/.gitignore
        " ...
        
    let result = s:system_cmd("
        \\n npm -v
    \")
    ec result
    return
    let result = s:system_cmd("
        \\n cd /home/kdog3682/2024/prosemirror-math
        \\n npm run serve:docs
    \")
    return
    return

    let result = s:system_cmd("
        \\n cd /home/kdog3682/2024/
        \\n npm install --save-dev html-webpack-plugin
    \")
    return

    let result = s:system_cmd("
        \\n cd /home/kdog3682/2024/
        \\n npm install @benrbray/prosemirror-math
        \\n ls
        \\n
    \")

    ec result
endfunction
let g:wpsnippets2["vim"]["system_cmd"] = "let result = s:system_cmd(\"\\n    \\\n $c\n    \\n\n    \\n\n\\\")"
let g:wpsnippets2["vim"]["g"] = "let result = s:system_cmd(\"\n    \\\\n $c\n    \\\\n     \n\\\")"
"
let g:execRef["enode2"] = "Explore /home/kdog3682/2024/node_modules/"

function! BashHistory()
    let t = s:read('/home/kdog3682/.bash_history')
    return t
    let result = s:system_cmd("
        \\n cd /home/kdog3682/2023/
        \\n history    
    \")
    return result
endfunction
let g:wpsnippets2["javascript"]["foro"] = "for: {\n    onEnter: {\n    }\n}"
let g:filedict["lgc"] = "/home/kdog3682/latest-git-cloned-repo/files/en-us/web/css/align-self/index.md"


function! Saver()
    let s = trim(getline('.'))
    call append('$', s)
endfunction

function! Overwriter(s)
    " test: "asd"
    let s = a:s
    let [a,b] = s:so(s)
    call OverwriteNormalCommand(a, b)
endfunction

function! OverwriteNormalCommand(a, b)
    let a = a:a
    let b = a:b
    let cmd = printf("nnoremap <buffer> %s :call %s()\<CR>", a, b)
    ec cmd
    execute cmd
endfunction
let g:execRef2["ow"] = "Overwriter"


function! CssHandleIncrement(key, value, dir)
    let key = a:key
    let value = a:value
    let dir = a:dir
    let inc = g:cssIncrementTable[key] * dir
    let v = s:sub(value, '\d+', {x -> x[0] + inc}, '')
    return v
endfunction
function! CssHandleIncrement1()
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
endfunction
let g:wpsnippets2["css"]["ab"] = "$1::after {\n    content: \"\";\n}\n\n$1::before {\n    content: \"\";\n}"
let g:wpsnippets2["css"]["keyframes"] = "@keyframes $1 {\n    0% {\n        $2\n    }\n    100% {\n        $3\n    }\n}"
inoreab <buffer>fli s:fli('',<space>'.',<space>1,<space>100,<space>0)<LEFT><C-R>=Eatchar('\s')<CR>

function! CssVarialize(name)
    let name = a:name
    let i = s:fli(':scope', '.', -1, 100, 0)
    let i = s:fli('\}', i, 1, 100, 0)
    let value = s:match(getline('.'), '\S+\ze;')
    let s:name = printf('var(--%s)', name)
    function! s:inner(s)
        let s = a:s
        let r = '\S+\ze;'
        return s:sub(s, r, s:name)
    endfunction
    call s:getsetline('s:inner')
    call append(i - 1, s:css_rest_items('--' . name, value))
endfunction
function! s:css_rest_items(...)
    " test: "asd","asd"
    let store = []
    let n = len(a:000) - 1
    for i in range(0, n, 2)
        " ec i
        let p = printf('    %s: %s;', a:000[i], a:000[i + 1])
        call add(store, p)
    endfor
    return store
	
endfunction

function! Vite()
    ec 'starting vite process'
    ec 'vite requires a new tab'
    ec 'go create vite via the command line'
    ec 'but first we close all buffers'
    call CloseAllBuffers()
    call AnythingHandler2('vite')
endfunction
function! CloseAllBuffers()
    execute 'bwipeout! | tabonly | bd!'
endfunction


let g:vimMappingRE = '[incv]noremap|inoreab'
function! SaveBackup0104()
    let s = getline('.')
    if s:t(s, g:vimMappingRE)
        ec "adfasdfadf append ftp plugin file"
        return s:append_ftp_plugin_file(s)
    endif
    let name = BackupName()
    call CopyFile(CurrentFile(), name)
endfunction

function! BackupName()
    let cwf = "/mnt/chromeos/GoogleDrive/MyDrive/BACKUP/"
    let name = Replace(Tail(), '^\.', '')
    let date = DateStamp()
    let outpath = cwf . name . date
    return outpath
endfunction
let g:dirdict['budir'] = "/mnt/chromeos/GoogleDrive/MyDrive/BACKUP"
let g:dirdict['2023'] = '/home/kdog3682/2023/'

function! FilePickerGlobal(key)
    " test: "css"
  let key = a:key
  let files = GlobList('2023')
  let r = '\.' . key . '$'
  let files = s:regexfilter(files, r)
  let files = s:get_most_recent_files(files, 9)
  return s:open(s:choose(files))
    
endfunction

function! FilePicker(...)
    cal s:open(s:file_picker(a:0 >= 1 ? a:1 : ''))
endfunction
function! s:file_picker(...)
    " test: "css"
    let key = a:0 >= 1 ? a:1 : ''
    let ref = {
    	\'css': '\.css$',
    \}
  let r = get(ref, key, '')
  let files = GetActiveBuffers()
  if s:exists(r)
       let files = s:regexfilter(files, r)
  endif
  " let files = s:get_most_recent_files(files, 9)
  return s:choose(files)
endfunction
function! s:get_most_recent_files(files, n)
    let files = a:files
    let n = a:n

    function! s:inner(a, b)
        let a = a:a
        let b = a:b
        let A = getftime(a)
        let B = getftime(b)
        if A < B
          return -1
        elseif A > B
          return 1
        else
          return 0
        endif
    endfunction
    call sort(files, function('s:inner'))
    return files[-n:]
endfunction
let g:execRef2["fp"] = "FilePicker"

function! UnzipCodepen()
    " when u overwrite the execRef ... should save it somewhere ...
    " perhaps as json

    " execute "!unzip /mnt/chromeos/MyFiles/Downloads/pen-jovrdw.zip"
    let result = s:system_cmd("
        \\n ls /mnt/chromeos/MyFiles/Downloads/
    \")
    ec result
    " /mnt/chromeos/MyFiles/Downloads/pen-jovrdw.zip
    /home/kdog3682/2023/pen-jovrdw
endfunction

let g:explorerExecRef['read'] = 'ExplorerRead'

function! ExplorerRead(s)
    let s = a:s
    ec s:read(s)
endfunction
function! ExplorerNote(path)
    let note = key
    let t = s:templater2("date: $date\nfile: $1\nnote: $2\n$hr", [s, note])
    call s:appendfile('file-notes.txt', t)
    execute "normal!  \<UP>"
endfunction
function! CreateBookmarkedFileNote()
    let t = s:templater2('bookmarkId: $timestamp')
    call s:appendabove(t)
    let file = 'file-notes.txt'
    let t = "$hr\ndate: $date\nfile: $file\n" . t . "\n\n$c\n"
    call s:create_bottom_of_page_snippet(file, t)
endfunction
function! s:action_log(action, arg)
    let action = a:action
    let arg = a:arg
    let file = '/home/kdog3682/2024/actions.log'
    let data = {'action': action, 'arg': arg}
    let p = s:encode(data)
    call s:appendfile(file, p)
endfunction
let g:execRef2["temp"] = "UnzipCodepen"

function! Temp()
    execute "!rm -rf /home/kdog3682/2023/pen-jovrdw/"
    "dangerous
endfunction
let g:filedict["al"] = "/home/kdog3682/2024/actions.log"
function! GetBackupFileFromCurrentFile()
    let tail = Tail()
    let lines = s:tolines(s:read('/home/kdog3682/2024/files.log'))
    for i in range(len(lines) - 1, 0, -1)
        let s = lines[i]
        if s:t(s, tail) && s:t(s, 'drive')
            let s = s:sub(s, '^\d+ +', '', '')
            return s
        endif
    endfor
    ec 'no backup file match for current file: ' . tail
endfunction
let g:wpsnippets2["vim"]["forer"] = "for i in range(len($1) - 1, 0, -1)\n    let item = $1[i]\n    $nendfor"
function! s:spaces_to_dashes(s)
    return s:sub(a:s, ' ', '-')
endfunction

function! s:create_snippet(key, args)
    let key = a:key
    let args = a:args
    return PlaceSnippet(s:templater2(s:jspy(key), args))
endfunction
function! PythonNormalFunctionBlock()
    let args = GetFunctionNameAndParamsFromLine()
    call s:scrolltobottom()
    return s:create_snippet('functionBlockTemplate', args)
endfunction

function! PythonFunctionBlock()
    let args = s:sosall(getline('.'))
    return s:create_snippet('functionBlockTemplate', args)
endfunction

" let g:jspyref3["vim"]["functionBlockTemplate"] = "def $1(${Paramify($2)}):\n\t$c"
let g:jspyref3["python"]["functionBlockTemplate"] = "def $1(${Paramify($2)}):\n\t$c"
" let g:jspyref3["javascript"]["functionBlockTemplate"] = "function $1(s) {\n\t$c}"
" inoremap <buffer> <expr> wf JPCreateFunctionBlockAsExpression()

function! Paramify(x)
    let x = a:x
    return join(s:coercearray(x), ', ')
endfunction

function! s:append_ftp_plugin_file(s)
    return s:appendfile(s:get_ftp_plugin_file(), a:s)
endfunction
function! s:get_ftp_plugin_file()
    return GetFtpluginFile()
endfunction
function! SaveLineToRelevantFTPFile(s)
    return s:append_ftp_plugin_file(a:s)
endfunction
" call add(g:normalCommands, "SaveLineToRelevantFTPFile")
call add(g:lineEditCommands, "SaveLineToRelevantFTPFile")

nnoremap <buffer> wf :call VimCreateFunctionBlockNormal()<cr>
inoremap <buffer> wf <esc>:call VimCreateFunctionBlock()<cr>


function! MarkdownDate()
    return '# ' . strftime('%m-%d-%Y')
endfunction
function! s:get_up_down_indexes(...)
    let [a,b,c,d] = s:flat(a:000)
	let up = s:fli(a, '.', -1, 500, 0) + b
	let down = s:fli(c, '.', 1, 500, 0) + d
    return [up, down]
endfunction
let g:shuntBackRef = {}
let g:shuntBackRef['component-sampleString.js'] = {}
let g:shuntBackRef['component-sampleString.js']['regexes'] = ['^---', 1, '^(`|---)', -1]
let g:wpsnippets2["javascript"]["eater"] = "inoreab <buffer>$1 $2<lt>C-R>=Eatchar('\s')<lt>CR>"
let g:wpsnippets2["javascript"]["eat"] = "inoreab <buffer> $1 $2 <C-R>=Eatchar('\s')<CR>"
let g:wpsnippets2["javascript"]["eat"] = "inoreab <buffer> $1 $2<C-R>=Eatchar('\s')<CR>"
let g:wpsnippets2["javascript"]["apps"] = "ImportAppsFile"
let g:wpsnippets2["javascript"]["user"] = "/* STABLE -- used by ${FileGetter2($1)}*/"

function! ImportAppsFile(...)
    let key = a:0 >= 1 ? a:1 : ''
    if s:exists(key)
        
    endif
    let files = map(s:get_active_buffers('js'), 's:tail(v:val)')
    let files = filter(files, 's:t(v:val, "apps")')
    let file = s:choose(files)
    let t = 'import * as ${RemoveExtension($1)} from "./$1"'
    return s:templater2(t, file)
endfunction

function! MoveStuffOut()
    let lines = s:nindent(s:tolines(@"))
    call append(line('.') - 1, lines)
endfunction

function! MoveStuffIn()
    let smart = s:get_temp_lines()
    call s:move_lines(smart)
endfunction

function! s:move_lines(lines, ...)
    let i = a:0 >= 1 ? a:1 : line('.')
    let lines = a:lines
    let lines = s:smartindent(lines, s:getsmartindent(i))
    call append(i, lines)
    call s:movement(i, lines) 
endfunction


function! SwapLambdaOrFunction(s)
       let s = a:s
   if s:t(s, '^const')
       let s = s:sub(s, ' *\=\> *', ' ')
       let s = s:sub(s, ' *\= *', '', '')
       let s = s:sub(s,'const', 'function', '')
       return s
   endif
       let s = s:sub(s, ' \{', '=> {')
       let s = s:sub(s, '\ze\(', ' = ', '')
       let s = s:sub(s,'function', 'const', '')
       return s
endfunction
call add(g:lineEditCommands, "SwapLambdaOrFunction")
nnoremap el :call OpenBuffer4(g:activeFileLogFile)<CR>
"replacing lasttouched
"

function! EDefine()
    let buffers = s:get_all_buffers(s:aliaser(&filetype))
    function! s:inner(i, s)
        let key = 'e' . (a:i + 1)
        let file = a:s
        ec [key, file]
        let template = g:apae_map_templates['nmap.fn.arg']
        let cmd = printf(template, key, 'OpenBuffer4', file)
        return cmd
    endfunction
    let computed = map(buffers, function('s:inner'))
    if s:confirm('confirm these temporary mappings: ')
        execute s:tostring(computed)
    endif
endfunction
function! s:aliaser(s)
    let ref = {
    	\'javascript': 'js',
    	\'js': 'javascript',
    	\'py': 'python',
    	\'python': 'py',
    	\'md': 'markdown',
    	\'markdown': 'md',
    	\'vim': 'js',
    \}
    return ref[a:s]
endfunction


function! s:get_active_buffers(key)
    return GetActiveBuffers(a:key)
endfunction
nnoremap e0 :call EDefine()<CR>

function! s:top_comment(s)
    return s:match(a:s, '/\* *(.{-}) *\*/')
endfunction
function! GenerateJavascriptTest()
    let [name, index, params] = GetFunctionInfo()
    let s = getline(index + 1)
    let t = s:top_comment(s)
    if s:exists(t)
        let t = s:templater2('console.log($1("$2"))', [name, t])
        call append('$', t)
        call cursor(line('$'), 100)
    endif
endfunction
let g:jspyref3["javascript"]["execFunctions"]["gen"] = "GenerateJavascriptTest"
function! s:get_all_buffers(...)
    " let buffers = range(1, bufnr('$'))
    " let buffers = filter(buffers, 'GetExtension(v:val) == e')
    " return buffers

    let e = a:0 >= 1 ? a:1 : 'js'
    let buffers = getbufinfo({})
    let buffers = filter(buffers, 'GetExtension(v:val.name) == e')
    call sort(buffers, function('CompareByLastUsed'))
    let buffers = buffers[-9:]
    let buffers = map(buffers, 'v:val.name')
    return buffers
endfunction

function! InvivoEvalString(s)
    let block = s:evaljs('vimConnector.js', 'invivoEval', a:s)
    return block
endfunction
function! InvivoGatherString(s)
    let r = a:s
    let m = s:global_findall(r)
    return s:string(m)
endfunction


function! ExtractLambdaFunctionIntoGlobalFunction(s)
    let s = a:s
    let y = line('.')
    let lines = s:getlines('matchingSpaces', 'd')
    " let name = s:prompt('choose a name')
    let name = 'asd'
    let a = lines[0]
    let b = s:match(a, '\(\zs\(.{-}\)\ze *\=')
    let b = 'function ' . name . b . ' {'
    let i = s:fli('^\S', '.', -1, 100, 0) - 1

    let lines = s:smart_dedent(lines)
    let lines[0] = b
    call append(i, lines)
    let a = s:match(a, '.{-}\(\ze\(')
    let a = a . name . ')'
    call append(y + len(lines), a)
    " return a
endfunction
call add(g:lineEditCommands, "ExtractLambdaFunctionIntoGlobalFunction")
function! MatchingSpacesIndexes()
    let i = line('.')
    let spaces = s:getspaces(i)
    let down = s:fli('^' . spaces . '\S', '.', 1, 100, 0)
    " call input('down: ' . s:string([i, down]))
    return [i, down]
endfunction

function! s:fliup(r, ind = '.')
    let r = a:r
    let ind = a:ind
    return s:fli(r, ind, -1, 100, 0)
endfunction

function! Fli(r, ind, dir, thres)
    let r = a:r
    let ind = a:ind
    let dir = a:dir
    let thres = a:thres
    try
        return s:fli(r, ind, dir, thres, 0)
    catch
        return
    endtry
endfunction

function! s:flidown(r, ind = '.')
    let r = a:r
    let ind = a:ind
    return s:fli(r, ind, 1, 100, 0)
endfunction


function! FliUp(r, ind = '.')
    return s:fliup(a:r, a:ind)
endfunction

function! FliDown(r, ind = '.')
    return s:flidown(a:r, a:ind)
endfunction

function! FindArg()
    " return maparg('<c-x>', '', 0, 1)
    return maparg('j', '', 0, 1)
endfunction

function! RenameFile(s)
    " test: "asd"
    let s = a:s
    let head = Head()
    let file = CurrentFile()
    let outpath = s:npath(head, s)
    call CopyFile(file, outpath)
endfunction
let g:execRef2["rename"] = "RenameFile"


function! InitiateCSS()
    if &filetype == 'css'
        execute 'setlocal filetype=javascript'
        ec 'resetting filetype to javascript'
    else
        execute 'setlocal filetype=css'
        ec 'setting filetype to css'
        zipfile:/mnt/chromeos/MyFiles/Downloads/bootstrap-5.0.2-dist.zip::bootstrap-5.0.2-dist/css/bootstrap.css
    endif
endfunction
let g:execRef2["css"] = "InitiateCSS"
function! ComponentSampleStringArchive()
	call setline(1, '$')
    exec "1,$d"
    let lines = s:tolines(@")[1:-1]
    call s:appendfile('component-sampleString.txt', lines)
    let newLines = [
        \"export default `",
        \"----------------------------------------------------------------------------",
        \"tableOfContents:",
        \"",
        \"main: v-test",
        \"",
        \"----------------------------------------------------------------------------",
        \"name:v-test",
        \"",
        \"",
        \"---------------------------------------------------------------------------`"
    \]
    call setline('.', newLines)
endfunction
function! GoToArchive()
    call OpenBuffer3('component-sampleString.txt')
endfunction
let g:wpsnippets2["global"]["eval"] = "InvivoEvalString"
let g:wpsnippets2["css"]["line"] = "/*************************************************************************/"
let g:filedict["bs"] = "/home/kdog3682/2023/bootstrap.css"
let g:visualactiondict['shunt'] = {'fn': 'VShunt2', 'i': 'code', 'arg': ''}
let g:visualactiondict['sh'] = {'fn': 'VShunt2', 'i': 'code', 'arg': ''}
" specify a location
let g:filedict["cu2"] = "/home/kdog3682/2023/css-utils2.js"

function! GenExports(...)
    let names = s:get_bindings()
    if a:0 >= 1
        let names = s:regexfilter(names, a:1)
    endif
    let value = printf('export { %s }', Paramify(names))
    call append('$', value)
endfunction

function! s:get_bindings()
    let t = getline(1, '$')
    let r = 'function \zs\w+'
    return s:ufa(t, r)
endfunction
let g:execRef2["ge"] = "GenExports"
function! s:choose_dict_value(file)
    let file = a:file
    let data = s:read(file)
    let keys = keys(data)
    let key = s:choose(keys)
    return data[key]
endfunction


function! CssVarialize(s)
    let s = a:s
    
endfunction
let g:execRef2["fpg"] = "FilePickerGlobal"

function! s:get_script_function()
    let r = "\n" . 'function!? \zss:\w+'
    let functions = GlobalTextSearch(r)
    let match = s:fuzzy(functions)
    return match
endfunction
function! s:go_script_function()
    let f = s:get_script_function()
    call s:open_function(f)
endfunction
function! FindScriptFunction()
    let match = s:get_script_function()
    call s:set_paste_buffer(match)
    return match
endfunction

function! s:fuzzy(items, ...)
    let items = a:items
    if len(items) == 0
        throw 'no items'
    endif

    if len(items) == 1
        return items[0]
    endif
    let key = a:0 >= 1 ? a:1 : ''
    let c = 0
    let input = ''
    let temp = items[0:8]
    let message = s:exists(key) ? ' for key: ' . key : ''
    ec 'start of fuzzy find' . message
    ec 'begin typing a char'
    ec 'there are ' . len(items) . ' items'
    ec 'first 9 items are:'
    call s:numbered(temp)

    let ch = ''
    let solre = 0
    while c < 30
        try
            let ch = s:getchar()
        catch
            return 
        endtry
        if ch == "\<BS>"
            let input = ''
            let temp = items[0:10]
            call s:print_list(temp, 10)
            continue
        elseif ch == '\\'
            ec 'toggling solre, resetting input'
            let solre = solre ? 0 : 1
            let input = ''
            continue
        elseif s:is_number(ch)
            return temp[ch - 1]
        elseif ch == "\<CR>"
            return temp[0]
        else
            if ch == '-'
                let ch = '_'
            endif
            let input .= ch
            let temp = matchfuzzy(items, input)
            if solre
                let temp = filter(temp, 's:t(v:val, ''^'' . input)')
            endif
            call s:print_list(temp, 8)
            ec ''
            ec input
        endif
    endwhile
endfunction

function! SolExpr(a, b, ...)
    let startingSpaces = a:0 >= 1 ? a:1 : 0
    function! s:inner()
        let [a,b] = s:ab()
        if empty(trim(a))
            return 1
        endif
        return 0
    endfunction
    let condition = s:exists(startingSpaces) ? s:inner() : col('.') == 1
    return condition ? a:a : a:b
endfunction
" /home/kdog3682/.vim/ftplugin/cssTemplate.vim


function! CssTemplateComplete()
    throw "not done yet"
endfunction
let g:filedict["cp"] = "/home/kdog3682/2023/cssParser.js"


function! SeeCurrentFileInfo()
    let t = s:tail()
    try
        ec g:fileRef[t]
    catch
        ec 'no info for: ' . t
    endtry
endfunction
let g:execRef2["info"] = "SeeCurrentFileInfo"
let g:filedict["vd2"] = "/home/kdog3682/2023/directives2.js"

function! GoFileRefFile()
    let files = keys(g:fileRef)
    return s:open(s:choose(files))
endfunction
let g:execRef2["gopher"] = "GoFileRefFile"



let g:fileRef["component-sampleString.js"]["execRef"]["gm"] = "FS_CS_Go_Main"
let g:fileRef["component-sampleString.js"]["execRef"]["genRootGrid"] = "FS_CS_gen_css_grid"
let g:fileRef["lezer-sampleString.js"]["execRef"]["jump"] = "FS_LS_gen_jump_to_arg"
function! FS_CS_Go_Main()
    let r = '^main: *(\S+)'
    let i = s:fli(r, 1, 1, 100, 0)
    let i = s:fli('^-', i, 1, 100, 0)
    let i = s:fli(r, i, -1, 100, 0)
    let m = s:match(getline(i), r)
    let r = '^name: *' . m
    call s:regex(r)
endfunction
function! FS_CS_gen_css_grid()
	
endfunction


function! Move_2023_to_2024(f)
    "test: table-variants.cssTemplate
    let f = a:f
    let a = s:npath('2023', f)
    let b = s:npath('2024', f)
    call s:move_file(a, b)
endfunction

let g:wpsnippets2["vim"]["isf"] = "if IsFile($1)\n    $nendif"
function! s:move_file(a, b)
    let a = a:a
    let b = a:b
    if !IsFile(a)
        return s:red(s:colon('not a file', a))
    endif
    let s = printf('!mv "%s" "%s"', a, b)
    silent execute s
    redraw!
endfunction
let g:dirdict['2024'] = '/home/kdog3682/2024/'
let g:dirdict['node'] = '/home/kdog3682/2023/node_modules'
let g:dirdict['fonts'] = '/home/kdog3682/2023/fonts'
let g:wpsnippets2["cssTemplate"] = {}
let g:wpsnippets2["cssTemplate"]["def"] = "CssTemplateFunction"

function! CssTemplateFunction(s)
    " test: "a b c"
    let [a,b] = s:sosall(a:s)
    let t = "def $1(${Paramify($2)}):\n\t$c"
    return s:templater2(t, [a,b])
endfunction

let g:wpsnippets2["javascript"]["sc"] = "import { StateContext } from \"./StateContext.js\""

function! GetOverrideFile()
    if !exists('g:override_node_file')
        let file = s:file_picker()
        if empty(file)
            let file = CurrentFile()
        endif
        let g:override_node_file = file
    endif
    return g:override_node_file
endfunction
nnoremap eo :call OpenBuffer4(GetOverrideFile())<CR>


let g:jspyref3["vim"]["shuntIndexKey"] = "smart"
let g:jspyref3["python"]["shuntIndexKey"] = "smart"
let g:jspyref3["javascript"]["shuntIndexKey"] = "smart"
let g:jspyref3["template"] = {}
let g:jspyref3["template"]["shuntIndexKey"] = "belowCursor"
let g:jspyref3["markdown"]["shuntIndexKey"] = "belowCursor"
let g:execRef2["sh"] = "VShunt3"

set hidden
" set hidden: lets you go to other buffers without saving
"


function! FS_LS_reset_blue()
    let i = s:fli('blueTraversal', line('$'), -1, 500, 0)
    call s:getsetline('s:toggle_comment', i)
    call s:getsetline('s:toggle_comment', i + 1)
endfunction

function! FS_LS_gen_jump_to_arg()
    " let i = s:fliup('^--')
    let i = s:fli('^arg:', '.', -1, 500, 0)
    call Jump(i)
endfunction
function! FS_LS_new_arg()
    let i = s:fliup('^arg:')
    let i = s:fli('^\S+:', i, 1, 100, 0) - 1
    call append(i, ['', 'arg:', ''])
    call Jump(i + 3)
    startinsert!
endfunction
let g:fileRef["examples.js"]["execRef"]["cr"] = "FS_Ex_Create"
let g:fileRef["lezer-sampleString.js"]["execRef"]["cr2"] = "FS_LS_Create_Grammar"
let g:fileRef["lezer-sampleString.js"]["execRef"]["narg"] = "FS_LS_new_arg"
function! FS_Ex_Create()
    let s = "datetime: $datetime\ninpath:\narg:\n\ncode:\n\nfunction main(s) {\n\t$c\n}"
    call s:create_section_from_snippet(s)
endfunction
function! FS_LS_Create()
    """ bookmarkId: 1701119838 hfel: FS_LS_Create """
    let s = "datetime: $datetime\nlang: javascript\ncode:\n\nfunction main(state) {\n\treturn traverse(state, blueTraversal)\n\t$c\n}\n"
    call s:create_section_from_snippet(s)
endfunction
function! FS_LS_Create_Grammar()
    let s = "datetime: $datetime\ngrammar:\n$c\narg:\n\n"
    call s:create_section_from_snippet(s)
endfunction



inoremap  qw <ESC>:call MarkdownNormalQW()<CR>
nnoremap  qw :call MarkdownNormalQW()<CR>
inoremap  qe <ESC>:call MarkdownNormalQE()<CR>
nnoremap  qe :call MarkdownNormalQE()<CR>


let g:fileRef["lezer-sampleString.js"]["execRef"]["arg"] = "FS_LS_gen_jump_to_arg"
let g:fileRef["lezer-sampleString.js"]["execRef"]["blue"] = "FS_LS_reset_blue"
let g:fileRef["lezer-sampleString.js"]["execRef"]["b"] = "FS_LS_reset_blue"

nnoremap <silent> 3 #
function! QQScreenCompletion()
    let a = s:prompt('choose screen completion regex')
    let prefix = s:get_boundary_start(a)
    let r = prefix . s:rescape(a) . '\S+'
    let m = WordSpiralForOneMatch(r)
    return m
endfunction
function! s:get_boundary_start(s)
    let s = a:s
    if s:t(s, '^\w')
        return '<'
    endif
    return ''
endfunction
let g:filedict["g2"] = "/home/kdog3682/PYTHON/githubscript2.py"


function LogConsoleAppendVariable()

    function! s:inner(s)
        let s = a:s
        if s:t(s, 'console.log')
            return s:sub(s, 'console.log', 'appendVariable', '')
        else
            call setline(line('.') - 1, '')
            return s:sub(s, 'appendVariable', 'console.log', '')
        endif
    endfunction

    let payload = 'import {appendVariable} from "./node-utils.js"'
    call s:appendabove(payload)
    call s:getsetline(function('s:inner'))

    " call WithOpen('utils.js', 'Inner')
endfunction
let g:execRef2["jca"] = "LogConsoleAppendVariable"


" to do it in a nice way




autocmd! bufwritepost ~/.vimrc source %
autocmd! BufNewFile,BufRead *.dialogue set filetype=dialogue
autocmd! BufNewFile,BufRead *.typ set filetype=typst
autocmd! BufNewFile,BufRead *.cssTemplate set filetype=cssTemplate
autocmd! BufNewFile,BufRead *.grammar set filetype=grammar
autocmd! BufNewFile,BufRead *.markdown set filetype=markdown2
autocmd! BufNewFile,BufRead *(.vue.raw|components.txt) set filetype=vue
nnoremap c :call GetSetFn2('s:toggle_comment')<CR><DOWN>
let g:jspyref3["grammar"] = {}
let g:jspyref3["grammar"]['commentPrefix'] = '//'
function! s:remove_starting_comments(s)
    let s = a:s
	return s:sub(s, '^(//|#|") +', '', '')
endfunction

function! LE_Grab_Colon_Arg_To_PasteBuffer(s)
    let a = s:match(getline('.'), '^\S+: +\zs.+')
    let name = 'file'
    let b = s:jspy('prefix') . name . ' = ' . s:to_string_argument(a)
    let @" = b
endfunction

function! LE_ChangeExtensionOnLine(s)
    return s:sub(a:s, g:fileRE, '\=s:change_tail(submatch(0), s:prompt("new name?"))', '')
endfunction
call add(g:lineEditCommands, "LE_ChangeExtensionOnLine")
function! s:change_extension(s, newExtension)
    let [a,b,e] = HeadAndTail(a:s)
    return a . RemoveExtension(b) . '.' . a:newExtension
endfunction
function! s:change_tail(s, name)
    let [a,b,e] = HeadAndTail(a:s)
    let name = AddExtension2(a:name, e)
    return a . name
endfunction
let g:CommandTildaRef['mhf'] = 'SetHighFrequencyEditLocation'
call add(g:lineEditCommands, "LE_Grab_Colon_Arg_To_PasteBuffer")
function! s:to_string_argument(s)
    let s = a:s
    return s:string(s)
    if IsNumber(s)
        return s
    endif
    return s
endfunction


function! GenericWordSpiralCompletion(key)
    let a = GetCompletionWords(a:key)
    if empty(a)
        let a = GlobalTextSearch(a:key)
    endif
    return a
endfunction
let g:jspyref3["grammar"]["qqqCompletionItems"] = g:grammarCompletionItems
let g:jspyref3["grammar"]["reservedKeywords"] = []


function! SnippeteerBrackify()
    let template = "$1 {\n    $c\n}"
    let t = s:templater2(template, getline('.'))
    call s:setblock(t)
endfunction
function! s:timestamp_to_datestamp(s)
    return strftime('%A %m-%d-%Y %I:%M:%S %p', a:s)
endfunction
let g:fileRef["lezer-sampleString.js"]["execRef"]["cr"] = "FS_LS_Create"
function! GenerateLezerGrammar()
    let file = CurrentFile()
    let grammar = ''
    let tokens = ''
    if s:t(file, 'tokens.js')
        let grammar = s:sub(file, 'tokens.js', 'grammar', '')
        let tokens = file
    else
        let tokens = s:sub(file, 'grammar', 'tokens.js', '')
        let grammar = file
    endif
    if !IsFile(grammar) || !IsFile(tokens)
        ec 'error in grammar or token file'
        return 
    endif
    let cmd = 'lezer-generator $1 -o $2'
    let output = s:sub(grammar, 'grammar', 'js')
    let cmd = s:templater(cmd, [grammar, output])
    let result = s:sys(cmd)
    ec result
endfunction
let g:execRef2["lez"] = "GenerateLezerGrammar"

function! IncSave()
    let o = CurrentFile()
    let file = s:increment_file_name(o)
    call CopyFile(o, file)
endfunction
let g:execRef2["incsave"] = "IncSave"
function! s:change_file_name(s, payload)
    let s:F__1 = a:payload
    function! s:inner(s)
        let s = a:s
        return 
        
    endfunction
    return s:sub(a:s, '.{-}\ze\.\w+$', '\=s:inner(submatch(0))', '')
endfunction

function! s:append_file_name(s, payload)
    return s:sub(a:s, '\ze\.\w+$', a:payload, '')
endfunction
function! s:increment_file_name(s)
    let n = 1
    while n < 100
        let s = s:npath(g:budir, s:append_file_name(a:s, '-' . n))
        if !s:is_file(s)
            return s
        endif
        let n += 1
    endwhile
endfunction
function! s:add_extension(s, e)
    let s = a:s
    let e = a:e
	return AddExtension2(s, e)
endfunction
let g:wpsnippets2["vim"]["bog"] = "if s:is_file($1)\n    $c\nendif"

function! s:is_file(s)
    return IsFile(a:s)
endfunction
function! s:log_file_creation_time(name)
    let name = a:name
    let p = strftime('%s') . ' ' . name
	call s:appendfile(g:activeFileLogFile, p)
endfunction

inoremap <silent> <buffer> <expr> w[ Bracketer()
inoremap <silent> <expr> w[ Bracketer()
function! Bracketer()
    let word = s:get_word_before_cursor()
    return " {\<C-O>o}\<C-O>O" 
endfunction

function! s:get_word_before_cursor()
    let s = getline('.')
    let pos = col('.') - 1
    let a = strpart(s, 0, pos)
    return s:match(a, '<[a-z]+$')
endfunction
let g:currentMostActiveFile = '/home/kdog3682/2023/lezer-sampleString.js'
let g:currentMostActiveFile = '/home/kdog3682/2023/component-sampleString.js'

function! s:html_comment(s)
    return !s:t(a:s, '^<!--') ? '<!-- ' . a:s . ' -->' : a:s[5:-4]
endfunction

function! s:css_comment(s)
    return !s:t(a:s, '^ *\/\*') ? '/* ' . a:s . ' */' : a:s[3:-3]
endfunction

function! CommentAndSave()
    let t = '/* asd */'
    function! s:inner(s)
        let s = a:s
        return !s:t(s, '^ *\/\*') ? '/* ' . s . ' */' : s[3:-3]
    endfunction
    call s:getsetline('s:inner')
endfunction

function! CssSetVarValue(v)
    let val = s:exists(a:v) ? a:v : s:prompt('value?')
    let s = getline('.')
    let m = s:match(s, '--.{-}\ze\)')
    let i = s:fli(':root', 0, 1, 100, 0)
    let p = '    ' . m . ': ' . val . ";"
    call append(i, p)
endfunction
let g:jspyref3["css"]["execFunctions"]["sv"] = "CssSetVarValue"


let g:jspyref3['vim']['commentTemplate'] = '" $1'
let g:jspyref3['python']['commentTemplate'] = '# $1'
let g:jspyref3['javascript']['commentTemplate'] = '// $1'
let g:jspyref3['css']['commentTemplate'] = '/* $1 */'
let g:jspyref3['html'] = {}
let g:jspyref3['html']['commentTemplate'] = '<!-- $1 -->'


" ---------------------------------------------------------------
" ---------------------------------------------------------------
" ---------------------------------------------------------------
" 11-29-2023 

nnoremap dis ^DA

let g:dirs = [ "right", "top", "left", "bottom", ]

function! CssDupLine(...)
    let s = getline('.')
    let m = s:match(s, 'bottom|top|right|left')
    let store = []
    if s:exists(m)
        for item in g:dirs
            if item == m
                continue
            endif
            call add(store, s:sub(s, m, item))
        endfor
    endif
    call append('.', store)
endfunction
let g:jspyref3["css"]["execFunctions"]["dup"] = "CssDupLine"

function! CssLeaderR()
    " ec maparg('<leader>r', '', 0, 1)
    " --asdasd-assasadas
    " it behaves differently ...
endfunction

function! CssLeaderRExpr()
    let i = col('.')
    let [a,b] = s:get_current_word_indexes('@word')
    " return s:string([a,b, getline('.')[a : b]])
    " call input(s:string([a,b, getline('.')[a : b]]))
    let delta = 2 + b - i
    let back = b - a + 1
    let right = s:keyboard_expr_right(delta)
    let delete = s:keyboard_expr_backspace(back)
    return right . delete
endfunction

function! s:keyboard_expr_backspace(n)
    return repeat(g:keyboard.bs, a:n)
endfunction

function! s:keyboard_expr_right(n)
    return repeat(g:keyboard.right, a:n)
endfunction

function! s:keyboard_expr_left(n)
    return repeat(g:keyboard.left, a:n)
endfunction


function! s:regex_getter(k)
    let ref = {
        \'@word': '[a-z0-9]+',
        \'@letter': '[a-z0-9]',
        \'@symbol': '[a-z0-9]',
        \'@iden': '[a-z0-9]',
    \}
	return get(ref, a:k, a:k)
endfunction

function! CreateMarkdownSection(...)
    let t = a:0 >= 1 ? a:1 : 'untitled'
    let t = '# ' . t . "\n$c\n"
    call s:create_section_from_snippet(t)
endfunction

function! CreateDialogueSection()
    call s:create_section_from_snippet('@dialogue')
endfunction
let g:filedict["v2"] = "/home/kdog3682/.vim/ftplugin/variables.10-12-2023.vim"
let g:vimCurrentTestFunction = "CssLeaderRExpr"
let g:jspyref3["vim"]["equalDict"]["ref"] = {'replaceWith': 'ref', 'value': "{\n\\'': \"\",\n\\}"}


let g:vimFunctionAliases['fileBasedIdentifier'] = 'GetFileBasedIdentifier'
function! EchoControllerViaAnythingHandler(s)
    let s = a:s
    if has_key(g:vimFunctionAliases, s)
        let s = g:vimFunctionAliases[s] . '()'
    endif
    ec eval(s)
endfunction
let g:execRef2["ec"] = "EchoControllerViaAnythingHandler"


let s:max_prose_line_length = 55
function! ProseEnter()
    let s = getline('.')
    if len(s) > s:max_prose_line_length
        let lines = s:split_prose_lines(s)
    endif
endfunction
function! s:split_prose_lines(s)
    " this function exists in js ...
    gsl=
    s:ge    
    

    let s = a:s
	lines = []
    let words = split(s)
    for i in range(len(words))
        let word = words[i]
        
    endfor
endfunction


function! RegisterLanguage()
    let f = &filetype
    let e = s:ge(s:tail())
    if s:exists(f)
        return 
    endif
    let filetype = s:prompt('welcome to RegisterLanguage. declare a filetype or use the fallback: ' . e, e)
    let autocmdTemplate = "autocmd! BufNewFile,BufRead *.$1 set filetype=$2"
    let commentPrefix = s:prompt('commentPrefix?')
    call DictSetter('g:jspyref3', filetype, 'execFunctions', 'sayhi', s:templater2('Sayhi("$1")', filetype))
    call DictSetter('g:jspyref3', filetype, 'commentPrefix', commentPrefix)
    call s:append_vim(s:templater2(autocmdTemplate, [e, filetype]))
    call s:set_filetype(filetype)
endfunction
let g:execRef2["rl"] = "RegisterLanguage"
function! s:append_vim(s)
	return s:appendfile(s:vimrc_file, a:s)
endfunction

function! s:set_filetype(filetype)
    execute "set filetype=" . a:filetype
endfunction
let s:vimrc_file = '/home/kdog3682/.vimrc'
let g:jspyref3["stylus"] = {}
let g:jspyref3["stylus"]["execFunctions"] = {}
let g:jspyref3["stylus"]["execFunctions"]["sayhi"] = "Sayhi(\"stylus\")"

let g:jspyref3["stylus"]["commentPrefix"] = "//"
let g:jspyref3["text"] = {}
let g:jspyref3["text"]["commentPrefix"] = "#"
nnoremap en :call OpenBuffer4(g:activeNoteFile)<CR>


function! ChooseAndApplyVimCommandsFromCommandRepository()
    let lines = s:tolines(s:read('/home/kdog3682/.vim/ftplugin/commands.vim'))
    let r = '^%(ino|nno).+'
    let lines = s:regexfilter2(lines, r)
    let commands = s:choose_multiple(lines)
    call s:execute(commands)
endfunction
function! s:execute(x)
    for item in s:coercearray(a:x)
        try
            execute item
        catch
            let error = v:exception
            ec error
        endtry
    endfor
    return a:x
endfunction
function! MarkdownDash()
    let [a,b] = s:ab()
    let char = a[len(a) - 1]
    let c = len(b) > 0
    if c
        return '-'
    elseif char == '-'
        return '-'
    elseif char == ' '
        return '- '
    else
        return ' - '
    endif
endfunction
function! MarkdownSpace()
    let char = s:get_last_char()
    if char == ' '
        return ''
    else
        return ' '
    endif
endfunction
function! s:get_last_char()
    return getline('.')[col('.') - 2]
endfunction
let g:execRef2["set-active-language-file"] = "SetCurrentFileAsActiveLanguageFile"

nnoremap <leader>r diwi

function! Comment(s)
    return s:comment(a:s)
endfunction
inoreab <expr> ds Comment(strftime('%m-%d-%Y'))

inoremap $ 4

function! PythonAppController()
    call Python2('pythonAppController')
endfunction
let g:execRef2["pac"] = "PythonAppController"
let g:filedict["ss"] = "/home/kdog3682/2023/style.stylus"

function! AppMarkdownSpellFix(s)
    let s = a:s
    let words = s:get_words(s)
    let bigref = "/home/kdog3682/RESOURCES/spellcheck.json"
    let store = []
    let ref = g:spellcheck_json_data
    for item in words
        if has_key(ref, item)
            let s = s:sub(s, s:boundary(item), ref[item])
        endif
    endfor
    return s
endfunction
let g:jspyref3["markdown"]["execFunctions"]["sf"] = "GetSetFn('AppMarkdownSpellFix')"

let g:spellcheck_json_data = {
    \'te': 'the',
    \'wat': 'what',
	\'c': 'see',
	\'lks': 'looks',
	\'lk': 'like',
\}
let g:jspyref3["stylus"]["functionBlockTemplate"] = "def $1(${Paramify($2)})\n\t$c"
let g:jspyref3["stylus"]["qqqCompletionItems"] = g:stylusCompletionItems
let g:jspyref3["text"]["qqqCompletionItems"] = g:textCompletionItems
let g:activeCssFile = "/home/kdog3682/2023/frustrating.css"
let g:jspyref3['stylus']['blockPairs'] =  { '[ *$': '\]', '\{ *$': '\}', '^ *for': 'endfor', '^ *(if|elseif)>': '(else|end)if', '^ *try': 'endtry'}

function! StylusWordSpiralCompletion(s)
    let key = a:s
    let a = GetCompletionWords(key)
    if s:exists(a)
        return a
    endif
    return s:fuzzyfind(g:cssAttributeKeys, key)
endfunction
function! s:fuzzyfind(items, key)
    return matchfuzzy(a:items, a:key)
    let items = a:items
    let r = CreateCompletionRE(a:key)
    return s:regexfilter2(items, r)
endfunction

" let g:cssAttributeKeys = ["align-content","align-items","align-self","all","animation","animation-delay","animation-direction","animation-duration","animation-fill-mode","animation-iteration-count","animation-name","animation-play-state","animation-timing-function","backface-visibility","background","background-attachment","background-blend-mode","background-clip","background-color","background-image","background-origin","background-position","background-repeat","background-size","border","border-bottom","border-bottom-color","border-bottom-left-radius","border-bottom-right-radius","border-bottom-style","border-bottom-width","border-collapse","border-color","border-image","border-image-outset","border-image-repeat","border-image-slice","border-image-source","border-image-width","border-left","border-left-color","border-left-style","border-left-width","border-radius","border-right","border-right-color","border-right-style","border-right-width","border-spacing","border-style","border-top","border-top-color","border-top-left-radius","border-top-right-radius","border-top-style","border-top-width","border-width","bottom","box-decoration-break","box-shadow","box-sizing","caption-side","caret-color","@charset","clear","clip","color","column-count","column-fill","column-gap","column-rule","column-rule-color","column-rule-style","column-rule-width","column-span","column-width","columns","content","counter-increment","counter-reset","cursor","direction","display","empty-cells","filter","flex","flex-basis","flex-direction","flex-flow","flex-grow","flex-shrink","flex-wrap","float","font","font-family","font-kerning","font-size","font-size-adjust","font-stretch","font-style","font-variant","font-weight","grid","grid-area","grid-auto-columns","grid-auto-flow","grid-auto-rows","grid-column","grid-column-end","grid-column-gap","grid-column-start","grid-gap","grid-row","grid-row-end","grid-row-gap","grid-row-start","grid-template","grid-template-areas","grid-template-columns","grid-template-rows","hanging-punctuation","height","hyphens","isolation","justify-content","left","letter-spacing","line-height","list-style","list-style-image","list-style-position","list-style-type","margin","margin-bottom","margin-left","margin-right","margin-top","max-height","max-width","min-height","min-width","mix-blend-mode","object-fit","object-position","opacity","order","outline","outline-color","outline-offset","outline-style","outline-width","overflow","overflow-x","overflow-y","padding","padding-bottom","padding-left","padding-right","padding-top","page-break-after","page-break-before","page-break-inside","perspective","perspective-origin","pointer-events","position","quotes","resize","right","scroll-behavior","tab-size","table-layout","text-align","text-align-last","text-decoration","text-decoration-color","text-decoration-line","text-decoration-style","text-indent","text-justify","text-overflow","text-shadow","text-transform","top","transform(2D)","transform-origin(two-value syntax)","transform-style","transition","transition-delay","transition-duration","transition-property","transition-timing-function","unicode-bidi","user-select","vertical-align","visibility","white-space","width","word-break","word-spacing","word-wrap","writing-mode","z-index"]
let g:cssAttributeKeys = ["align-content","align-items","align-self","all","animation-delay","animation-direction","animation-duration","animation-iteration-count","animation-name","animation-play-state","animation-timing-function","background-clip","background-origin","background-size","background","border-bottom-left-radius","border-bottom-right-radius","border-image-outset","border-image-repeat","border-image-slice","border-image-source","border-image-width","border-image","border-radius","border-top-left-radius","border-top-right-radius","box-decoration-break","box-shadow","box-sizing","column-count","column-fill","column-gap","column-rule-color","column-rule-style","column-rule-width","column-rule","column-span","column-width","columns","flex-basis","flex-direction","flex-flow","flex-grow","flex-shrink","flex-wrap","flex","font-variant-caps","opacity","order","outline-offset","overflow-x","overflow-y","perspective-origin","perspective","pointer-events","resize","row-gap","tab-size","text-align-last","text-decoration-color","text-decoration-line","text-decoration-style","text-overflow","text-shadow","transform-origin","transform-style","transition-delay","transition-property","transition-timing-function","word-break","word-wrap","writing-mode","background-attachment","background-blend-mode","background-color","background-image","background-position","background-repeat","border-bottom","border-bottom-color","border-bottom-style","border-bottom-width","border-collapse","border-color","border-left","border-left-color","border-left-style","border-left-width","border-right","border-right-color","border-right-style","border-right-width","border-spacing","border-style","border-top","border-top-color","border-top-style","border-top-width","border-width","border","clear","cursor","display","float","position","visibility","height","line-height","max-height","max-width","min-height","min-width","width","font-family","font-size","font-style","font-variant","font","font-weight","content","counter-increment","counter-reset","quotes","list-style-image","list-style-position","list-style-type","margin-bottom","margin-left","margin-right","margin-top","mix-blend-mode","outline-color","outline-style","outline-width","outline","padding-bottom","padding-left","padding-right","padding-top","clip","overflow","z-index","page-break-after","page-break-before","page-break-inside","caption-side","table-layout","color","direction","letter-spacing","text-align","text-indent","text-transform","unicode-bidi","white-space","word-spacing"]


function! GetBuffers()
    
     let buffers = getbufinfo()
     function! s:inner(s)
         let s = a:s
         return s.name
     endfunction
     let results = map(buffers, 's:inner(v:val)')
     return results
endfunction
function! CloseOldestBuffers()

     let buffers = getbufinfo()
     for item in buffers[0:-10]
         if !item.listed || s:t(item.name, '\.vimrc')
             continue
         endif
         call s:close_buffer(item)
     endfor
     return 
     ec buffers[0]
     ec map(buffers, 'v:val.bufnr')
     return 
     let buffers = SortBuffers()
     return 
     let length = len(buffers)
     for i in range(length - 10)
         let buffer = buffers[i]
         try
             call s:close_buffer(buffer)
         catch
             call red(v:exception)
         endtry
     endfor
endfunction
function! s:close_buffer(target)
   let bufnum = ''
  if type(a:target) == 1
    let bufnum = bufnr(a:target)
  elseif type(a:target) == 0
    let bufnum = a:target
  else
    let bufnum = a:target.bufnr
  endif

  let cmd = 'bd ' . bufnum
  execute cmd
endfunction
let g:execRef2["a8"] = "A8Word"


function! BookmarkCurrentFunction()
    let a = CreateBookmark({'type': 'function'})
endfunction
let g:execRef2["bm"] = "BookmarkCurrentFunction"

function! CreateJavascriptFile(s)
    let s = a:s
    let result = s:evaljs('vimConnector.js', 'createJavascriptFile', a:s)
    let file = s:get_eval_result(result)
    call OpenBuffer3(file)
    call LogCreateTime(file, 'files.log')
    return s:print(file)

endfunction
let g:execRef2["js"] = "CreateJavascriptFile"
function! s:get_eval_result(items)
    " test: s:months
    let result = a:items[-1]
    return result
endfunction
function! s:fuzzy_find_dict_key(key, ref)
    let key = a:key
    let ref = a:ref
    if s:t(key, '^/')
        let dictKeys = keys(ref)
        return s:fuzzyfind(dictKeys, key)
    endif
    return key
endfunction


function! NewFunctionNoteItem()
    let t = "$hr\ndatetime: $datetime\nfile: $file\nfunction: $fileBasedIdentifier\nnotes:\n\n$c"
    let t = s:templater2(t)
    let t = s:sub(t, 'function: *\n', '')
    let file = 'function-notes.txt'
    call s:create_bottom_of_page_snippet(file, t)
endfunction
function s:create_bottom_of_page_snippet(file, template)
    let file = a:file
    let template = a:template
    try
        let snippet = s:templater2(template)
    catch
        let error = v:exception
        return 
    endtry
    call s:open(file)
    call s:scrolltobottom()
    call s:setblock(snippet)

endfunction
let g:execRef2["new"] = "NewFunctionNoteItem"
function! GetBindingFromAnywhere()
    let s = getline('.')
    let a = s:gcw()
    if len(a) > 3 && s:t(s, a . '(\(| +\= *[a-z])')
        return a
    endif
    return GetBindingName()
    return s:get_binding_name()
endfunction

function! s:half(n)
    let n = a:n
    return s:floor(n / 2)
endfunction
function! s:floor(n)
    let n = a:n
    return float2nr(floor(n))
endfunction
function! GetFileLogFiles(key, n)
    "test: vue, 20
    let key = a:key
    let n = a:n
    let lines = readfile(g:activeFileLogFile)
    " let length = len(lines)
    " let sliced = lines[s:half(length):]
    " return sliced
    let sliced = lines[-n:]
    let base = CreateCompletionRE(key)
    let r = printf('^\d+ +%(/home/kdog3682/\d+/)?%s', base)
    let items = s:regexfilter(sliced, r)
    let items = map(items, 's:so(v:val)')
    function! s:inner(a, b)
        let a = a:a
        let b = a:b
        return b[0] - a[0]
    endfunction
    call sort(items, function('s:inner'))
    return items[0][1]
endfunction
function! s:ref_sprawl(ref)
    let ref = a:ref
    return ref[InputChar2()]
    let keys = keys(ref)
    let c = 0
    let r = ''
    while c < 10
        let c += 1
        ec keys
        let ch = InputChar2()
        let r .= ch
        let length = len(keys)
        call filter(keys, 's:t(v:val, "^" . r)')
        if len(keys) == length
            return ref[r]
        elseif len(keys) == 1
            return ref[keys[0]]
        else
            return ref[keys[0]]
            continue
        endif
    endwhile
endfunction

let g:fnRE2 = '^(var|(async )?function[!*]?|def|class|const) \zs%(s:)?\w+|^\w+ \= \{ *$'
function! s:init_new_file_into_vim(file)
    let file = a:file
    let filetype = s:get_filetype(file)

    let o = {
        \'linked6': 'asdasdasd',
        \'linked6asd': 'asdasdasd',
        \'execRef': {"sayhi": "Sayhi(\"new file init -- still unset\")"},
        \"node1": {"runtimeFile": "stylus.js", "args": ['currentFile']},
        \"node111": {"run": "packageManager.js", "argFile": "examples.js", "fnKey": 'runExampleFile'},
    \}
    let tail = s:tail(file)
    call DictSetter('g:fileRef', tail, o)
    if has_key(g:jspyref3, filetype)
        return 
    endif
    let e = s:ge(file)
    if filetype == e
        let filetype = s:prompt('write a filetype', filetype)
    endif
    let commentPrefix = s:prompt('comment prefix?', '#')
    " let isCode = s:prompt( code?')
    call DictSetter('g:jspyref3', filetype, 'commentPrefix', commentPrefix)
    let autocmdTemplate = "autocmd! BufNewFile,BufRead *.$1 set filetype=$2"
    call s:append_vim(s:templater2(autocmdTemplate, [e, filetype]))
endfunction

let g:fileRef["codePlaygroundString.js"] = {"node111":{"fnKey":"runExampleFile","run":"packageManager.js","argFile":"examples.js"},"execRef":{"sayhi":"Sayhi(\"new file init -- still unset\")"},"linked6asd":"asdasdasd","linked6":"vuetify.js","node1":{"runtimeFile":"stylus.js","args":["currentFile"]}}
let g:fileRef["component-sampleString.js"]['NewFunctionNoteTemplate'] = "$hr\ndatetime: $datetime\nfile: $file\nidentifier: $fileBasedIdentifier\nnotes:\n\n$"
let g:fileRef["component-sampleString.js"]['fileBasedIdentifierFunction'] = "GetComponentSampleStringIdentifier"

function! GetFileBasedIdentifier()
    let fnKey = s:get_file_ref('fileBasedIdentifierFunction')
    if s:exists(fnKey)
        return function(fnKey)()
    endif
    return GetBindingName()
    return GetBindingFromAnywhere()
endfunction

function! GetComponentSampleStringIdentifier()
    let r = '^name: +(\S+)'
    return s:fli_match(r, '.', -1, 500, 0)
endfunction

function! s:fli_match(r, start, dir, threshold, anti)
    let r = a:r
    let start = a:start
    let dir = a:dir
    let threshold = a:threshold
    let anti = a:anti
    let i = s:fli(r, start, dir, threshold, anti)
    let s = getline(i)
    return s:match(s, r)
endfunction

function! s:create_lang_base_functions_for_auto_completion()
    let file = s:file_prompt()
    let r = '\ndef \zs\w+'
    let lang = s:get_file_type(file)
    let name = printf('g:%s_base_functions')
    let text = s:get_page_text(file)
    let m = s:unique(s:findall(text, r))
    let value = s:create_variable(name, m)
    call append("$", value)
endfunction

function! s:create_variable(a, b)
    let a = a:a
    let b = s:stringify(a:b)
    return printf("let %s = %s", a, b)
endfunction
function! s:stringify(s)
    return s:isstring(a:s) ? s:doublequote(a:s) : s:encode(a:s)
endfunction

function! s:get_python_identifiers()
    let r = '\ndef \zs\w+'
    let text = s:get_page_text()
    let m = s:unique(s:findall(text, r)) + g:python_base_functions
    return m
endfunction
function! s:get_page_text(...)
    let lines = a:0 >= 1 ? readfile(a:1) : getline(1, '$')
    let t = s:joinlines(lines)
    return t
endfunction

let g:filedict["ref2"] = "/home/kdog3682/2023/runExampleFile2.js"
let g:filedict["fn"] = "/home/kdog3682/2024/function-notes.txt"
let g:filedict["flt"] = "/home/kdog3682/2024/file-notes.txt"
let g:wpsnippets2["javascript"]["c"] = "class ${Pascal($1)} {\n    constructor(options) {\n        $c\n    }\n}"

let g:filedict["nx2"] = "/home/kdog3682/2023/next2.js"

function! SimpleNode()
    execute "!clear; node %"
endfunction
let g:execRef2["node"] = "SimpleNode"
let g:execRef2["filenote"] = "CreateBookmarkedFileNote"


function! s:get_ab_from_dots(a000)
    let a000 = a:a000
    if empty(a:000)
        let a000 = s:prompt("write value for dots: delimited by space")
    else
        let a000 = a000[0]
    endif
    return s:so(a000)
endfunction



function! RegisterFastEditFile()
    let s = getline('.')
endfunction
let g:FileRefConfigItems = [
    \{
        \"name": "RegisterFastEditFile",
        \"template": "nnoremap $1 :call OpenBuffer4(\"${s:ensure_file($2)\"})<cr>",
        \"args": [
            \{
                \'message': 'the keybinding',
                \'fallback': 'required',
            \},
            \{
                \'message': 'the file',
                \'fallback': 'CurrentFile()',
            \}
        \],
    \},
    \{
        \"name": "aaaaa",
    \}
\]

function! RegisterFileRefConfigItem(item)
    let item = a:item

    redraw!
    function! s:inner(args, template)
        let args = a:args
        let template = a:template
        let items = split(s:prompt(template))
        while len(items) < len(args)
            call add(items, eval(args[len(items)].fallback))
        endwhile
        return items

    endfunction

    if has_key(item, 'fn')
        let args = s:inner(item.defaultArgs, item.fn)
        return call(function(item.fn), args)
    elseif has_key(item, 'template')
        let args = s:inner(item.args, item.template)
        let value = s:templater3(item.template, args)
        call s:append_and_execute(value)
    endif
endfunction
function! RegisterFileRefConfig()
    let t = "
        \\n Welcome to RegisterFileRefConfig
        \\n Choose the configuration mode:
        \\n\n"

    call Blue(t)
    let keys = map(copy(g:FileRefConfigItems), 'v:val.name')
    let items = ['node1', 'execRef', "a8file", 'execFn'] + keys
    redraw!
    let m = s:choose(items)


    """ bookmarkId: 1701702741 hfel: RegisterFileRefConfig """
    if s:in(keys, m)
        let item = s:find(g:FileRefConfigItems, s:objectf('name', m))
        return RegisterFileRefConfigItem(item)
    endif

    let tail = s:tail()
    if m == 'execRef'
        let [key, fnKey] = s:so(s:prompt('choose key and fnKey for the execFunctionRef'))
        call DictSetter("g:fileRef", tail, "execRef", key, fnKey)
    elseif m == 'execFn'
        function! s:generate(s)
            let s = a:s
            let name = tolower(s:underscore(s:tail()))
            return 'FSEF_' . name . '__' . tolower(s:underscore(s))
        endfunction
        let key = s:prompt('choose execRec key ... the function name will be automatically generated from the key')
        if empty(key)
            ec ' no key ... early return'
            return 
        endif
        let fnKey = s:generate(key)
        let key = s:get_first_word(key)
        let t = printf("function %s(...)\n    let s = a:0 >= 1 ? a:1 : ''\n    $c\nendfunction", fnKey)
        let t .= "\n" . s:dict_setter("g:fileRef", tail, "execRef", key, fnKey)

        call s:open(g:vimrcfile)
        call s:scrolltobottom()
        call s:setblock(t)
        return
        
    elseif m == 'a8file'
        let file = ChooseFile()
        call DictSetter("g:fileRef", tail, "linked6", file)
        call DictSetter("g:fileRef", tail, "a8file", file)
    elseif m == 'node1'
        let fnKey = s:prompt('choose the fnKey for node1 packageManager.js', 'runExampleFile2')
        let file = "packageManager.js"
        try
            let node1 = {"run": file, "argFile": tail, "fnKey": fnKey}
            call DictSetter("g:fileRef", tail, "node1", node1)
        catch
            let error = v:exception
            ec error
            return 
        endtry
        call s:open(file, '$') 
        if fnKey == 'runExampleFile2'
            return 
        endif
        call s:insert_at_insertion_point(fnKey)
        let snippet = s:templater2(s:jspy('functionBlockTemplate'), fnKey)
        call s:scrolltobottom()
        call s:setblock(snippet)
    endif

endfunction

function! RegisterFileRefExecFunction(...)
    let [key, fnKey] = s:get_ab_from_dots(a:000)
    call DictSetter("g:fileRef", s:tail(), "execFunctions", key, fnKey)
endfunction
let g:CommandTildaRef['register file ref'] = 'RegisterFileRefExecFunction'
call add(g:normalCommands, "RegisterFileRefExecFunction")
let g:execRef2["nc"] = "NormalCommandController2"
let g:fileRef["utils.js"] = {}
let g:fileRef["utils.js"]["execRef"] = {}
let g:fileRef["utils.js"]["execRef"]["exp"] = "ExportWordUnderCursor"

function! ExportWordUnderCursor()
	let w = s:gcw()
    call AddExport(w)
endfunction
let g:localHighfrequencyJavascriptWords = [ "offset", "offsetStart", "offsetEnd"]

function! AddLocalWordLanguageRef(...)
    let word = a:0 >= 1 ? a:1 : s:gcw()
    try
        let t = "call add(g:jspyref3['$1']['localHighFrequencyWords'], '$2')"
        let t = s:templater2(t, [&filetype, word])
        call s:append_and_execute(t)
    catch
        call DictSetter('g:jspyref3', &filetype, 'localHighFrequencyWords', [word])
    endtry
endfunction

function! s:jspy2024(s, ...)
    try
        return g:jspyref3[&filetype][a:s]
    catch
        return a:0 >= 1 ? a:1 : ''
    endtry
endfunction
inoreab <buffer>jspy s:jspy2024()<LEFT><C-R>=Eatchar('\s')<CR>
let g:execRef2["local"] = "AddLocalWordLanguageRef"
let g:jspyref3["javascript"]["localHighFrequencyWords"] = ["checkValue"]
call add(g:jspyref3['javascript']['localHighFrequencyWords'], 'computedValue')
call add(g:jspyref3['javascript']['localHighFrequencyWords'], 'JSON.stringify')
function! s:get_local_words(r)
    let r = a:r
    let localWords = s:jspy2024('localHighFrequencyWords', [])
    let localFileWords = s:get_file_ref('localFileSpecificWords')
    " let funcWords = s:jspy2024('baseFuncWords', [])
    let words = localWords
    if s:t(s:tail(), 'lt|lezer|index.js')
        let words = localWords + g:lezer_functions + g:lezerWords
    endif
    let filtered = s:regexfilter2(words, r)

            let tail = Tail()
            let removed = RemoveExtension(tail)
            if Test(removed, r)
                call add(filtered, removed)
            endif
    return filtered
    " temp
    if s:exists(localFileWords)
        return s:regexfilter2(localWords + localFileWords, r)
    endif
    let locals = s:regexfilter2(localWords, r)
    return locals
endfunction
function! s:append_note_file(s)
    call s:appendfile(g:helpmdfile, a:s)
endfunction
function! s:create_note(s)
    " test: "c asdasd"
    let [a,b] = s:so(a:s)
    if empty(b)
        let b = a
        let a = 'coding -'
    endif

    let aliases = {
    	\'c': 'chore',
    \}
    let ref = {
    	\'chore': ' - ',
    \}

    let a = get(aliases, a, a)
    let c = get(ref, a, ' ')
    let prefix = '# '

    let note = prefix . a . c . b
    return note
endfunction
let g:wpsnippets2["python"] = {}
let g:wpsnippets2["python"]["if"] = "if $1:\n    $c"
let g:wpsnippets2["python"]["ifeq"] = "if $1 == $2:\n    $c"
let g:wpsnippets2["python"]["ef"] = "elif $1:\n    $c"
let g:wpsnippets2["python"]["ifa"] = "if is_array($1):\n    $c"
let g:wpsnippets2["python"]["ifo"] = "if is_object($1):\n    $c"
let g:wpsnippets2["python"]["ifn"] = "if is_number($1):\n    $c"
let g:wpsnippets2["python"]["ifs"] = "if is_string($1):\n    $c"


function! s:tabs_to_spaces(s)
	return s:sub(a:s, '\t', '    ')
endfunction
let g:wpsnippets2["python"]["for"] = "for ${GetForIterationVariable($1)} in $1:\n    $c"
let g:wpsnippets2["python"]["el"] = "else:\n    $c"

function! ChooseRecentBuffer()
    " call CloseOldestBuffers()
    let buffer = s:choose(GetActiveBuffers())
    return s:open(buffer)
endfunction
" /home/kdog3682/2024/

let g:filedict["e2"] = "/home/kdog3682/2023/examples2.js"


let g:runnerParamCache["fn"] = "arg"
let g:fileRef["function-notes.txt"] = {}
let g:fileRef["function-notes.txt"]["execFunctions"] = {}
let g:fileRef["function-notes.txt"]["execFunctions"]["run"] = "RunNoteFileCode"

function! s:inputchar()
    return InputChars(1)
endfunction
function! s:pascal(s)
    let s = a:s
    return Pascal(s)
endfunction
function! s:insert_at_insertion_point(payload)
    let payload = a:payload
	let i = search('\vinsertion-point-(above|below|object|array)')
    let below = 0
    let object = 0
    if empty(i)
        let i = search('\v^const \w+ \= \{$')
        if empty(i)
            return 
        endif
        let object = 1
        let below = 1
    endif
    let [spaces, line] = GetSpacesAndLine(i)
    if s:t(line, 'object')
        let object = 1
    endif
    if s:t(line, 'below')
        let below = 1
    endif
    if empty(spaces) && object
        let spaces = '    '
    endif
    let s = spaces . payload
    if object
        let s .= ','
    endif
    if below
        call append(i, s)
    else
        call append(i - 1, s)
    endif
endfunction
function! Foo(s)
    let s = a:s
    return s:insert_at_insertion_point(s)
endfunction
call add(g:normalCommands, "RegisterFileRefConfig")
let g:fileRef["function-notes.txt"]["node1"] = {"fnKey":"runExampleFile2","run":"runExampleFile2.js","argFile":"function-notes.txt"}

let g:jspyref3["python"]["execFunctions"]["pe"] = "PythonExtract"

function! EstablishLinkedBufferGroupRunner2(group)
    let [a,b] = a:group
     let template = 'let g:linkedBufferGroups["%s"] = "%s"'
     let lines = [ printf(template, a, b), printf(template, b, a)]
     return AppendAndExecute(lines)
endfunction
let g:linkedBufferGroups["redditscript.py"] = "utils.py"
let g:linkedBufferGroups["utils.py"] = "reddit_script.py"

function! s:shunt(key, file)
    let key = a:key
    let file = a:file
	let lines = s:getlines(key, 'd')
    call s:appendfile(file, lines)
endfunction
let g:fileRef["reddit_script.py"] = {}
let g:fileRef["reddit_script.py"]["linked6"] = "/home/kdog3682/PYTHON/utils.py"
let g:fileRef["reddit_script.py"]["a8file"] = "/home/kdog3682/PYTHON/utils.py"
let g:filedict["red"] = "/home/kdog3682/PYTHON/reddit_script.py"
let g:fileRef["files.log"] = {}
let g:fileRef["files.log"]["execRef"] = {}
let g:fileRef["files.log"]["execRef"]["h"] = "FileLogHelpFn"

function! FileLogHelpFn()
    let file = GetFileFromLine2(getline('.'))
    call input('file: ' . s:string(file))
endfunction

let g:gfgfdict['ah'] = ['/home/kdog3682/.vimrc', 'AnythingHandler2', 0]


function! LineEditChangeFileHead(s)
    let s = getline('.')
    let file = s:get_file_from_line(s)
    if empty(file)
        return 
    endif
    let new = s:npath(s:get_dir(a:s), file)
    return s:sub(s, s:rescape(file), new)
endfunction
function! s:get_file_from_line(s)
    return GetFileFromLine2(a:s)
endfunction
let g:execRef2["dir"] = "LineEditChangeFileHead"
function! s:underscore(s)
    let s = a:s
	return s:sub(s, '\W', '_')
endfunction

function! s:dict_getter(...)
    return s:call('DictGetter2', a:000)
endfunction

function! s:dict_setter(name, ...)
    "test: abcref, def, ghi, abc, def

    let name = a:name
    let keys = s:flat(a:000)

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
            if s:isstring(value)
                 let value = EscapeString(value)
                 let ref[key] = value 
            else
                 let ref[key] = value 
            endif
            let pvalue = s:string(value)
            call add(o, printf('let %s = %s', name, pvalue))
            let s = join(o, "\n")
            return s
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

function FSEF_function_notes_txt__group_files(...)
    let buffers = s:get_buffers('useful')
    let files = s:choose_multiple(buffers)
    call s:appendbelow(['file_group:'] + files)
endfunction
let g:fileRef["function-notes.txt"]["execRef"] = {}
let g:fileRef["function-notes.txt"]["execRef"]["group"] = "FSEF_function_notes_txt__group_files"
function! s:get_buffers()
    let r = '<(gitignore|package.json|vimrc|vim|git|txt|log)>'
    let buffers = GetActiveBuffers()
    return filter(buffers, '!s:t(v:val, r)')
endfunction
function! s:get_first_word(s)
    let s = a:s
	return s:match(s, '[a-z]\w+')
endfunction
function! Ajsdhask()
    let cmd = "git check-ignore -v .gitignore"
    ec s:system_cmd(cmd)

endfunction
let g:filedict["gi24"] = "/home/kdog3682/2024/.gitignore"
let g:filedict["gl"] = "/home/kdog3682/2024/git-logs.txt"

""" bookmarkId: 1704752530 """
let g:keyboard['newline'] = "\n"
function FSEF_examples_py__cr(...)
    let s = a:0 >= 1 ? a:1 : ''
    let ref = {
        \'n': {'key': 'note', 'spaces': "\n\n"},
        \'b': {'key': 'bash', 'spaces': "\n\n"},
        \'hn': {'key': 'bash', 'spaces': "\n\n"},
        \'red': {'key': "subreddit: askprogramming\ntitle: \nbody", 'spaces': "\n\n"},
        \'red': {'key': "subreddit: askprogramming\ntitle: \nbody", 'spaces': "\n\n"},
    \}
    let c = get(ref, s, "")
    let template = 'datetime: $datetime' . g:keyboard.newline
    if s:exists(c)
        let template .= c['key'] . ':' . get(c, 'spaces', ' ') . '$c'
    endif
    call s:create_section_from_snippet(template)
    " call s:create_section_from_snippet("$hr\nsubreddit: vim\ntitle: istaw\nbody:\n\n$c")
endfunction
let g:fileRef["examples.py"]["execRef"] = {}
let g:fileRef["examples.py"]["execRef"]["cr"] = "FSEF_examples_py__cr"
function! FixHandler()
    let lines = " do this at lib"
    " /home/kdog3682/PYTHON/examples.py
    " change vim to memo
endfunction
nnoremap zn :call NormalCommandController2()<cr>
" let g:wpsnippets2["vim"]["booga"] = "let g:FileRefConfigItems = [\n    \{\n        \\"abc\": \"aaaaa\",\n        \\"abcd\": \"aaaaa\",\n    \},\n    \{\n        \\"abc\": \"aaaaa\"\n        \\"abcd\": \"aaaaa\",\n    \}\n\]"


function! s:ensure_file(s) abort
    let s = FileGetter2(a:s)
    if s:is_file(s)
        return s
    endif
    throw 'not a file: ' . s
endfunction
function! s:templater3(template, ...)
    "test: "nnoremap $1 :call OpenBuffer4('${s:ensure_file($2)}')<cr>", "a", "u"
    let template = a:template
    let r = '\$(\{.{-}\}|\w+)(::\w+)?'
    let args = a:0 >= 1 && s:is_array(a:1) ? a:1 : a:000
    return s:sub(a:template, r, {s -> s:templater3_helper(s, args)})
endfunction

function! s:is_array(s)
    let s = a:s
    return IsArray(a:s)
endfunction

function! s:templater3_helper(x, args)
    let x = a:x
    let args = a:args
    let m = x[1]
    let fallback = x[2]

    if m == 'c'
        return '$c'
    elseif Test(m, '^\d+')
        if m == '0'
            return line
        elseif m - 1 < len(args)
            let v = args[m - 1]
            return v
        elseif Exists(fallback)
            return fallback
        else
            return ''
        endif
    elseif m =~ '^{'
        let m = m[1:-2]
        let m = Sub(m, '\$(\w+)', {x-> Quotify(s:templater3_helper(x, args))})
        return eval(m)
    else
        return GetVimStateArg(m)
    endif
endfunction
function! s:objectf(key, target)
    let key = a:key
    let target = a:target
	return {x -> x[key] == target}
endfunction
nnoremap em :call OpenBuffer4("/home/kdog3682/2024/function-notes.txt")<cr>

function FSEF_function_notes_txt__cr(...)
    let ref = {
        \'td': 'todo',
        \'note': "type: note\ntext",
        \'chatgpt': "type: chatgpt\ntext",
        \'self': "type: self\ntext",
    \}
    let arg = a:0 >= 1 ? get(ref, a:1, a:1) : 'changelog'
    call s:create_section_from_snippet("datetime: $datetime\n$1: $c\n", arg)
endfunction
let g:fileRef["function-notes.txt"]["execRef"]["cr"] = "FSEF_function_notes_txt__cr"
let g:fileRef["function-notes.txt"]["execRef"]["n"] = "FSEF_function_notes_txt__cr('note')"
let g:fileRef["function-notes.txt"]["execRef"]["gpt"] = "FSEF_function_notes_txt__cr('chatgpt')"
let g:fileRef["function-notes.txt"]["execRef"]["me"] = "FSEF_function_notes_txt__cr('self')"

inoremap <buffer> " '
" inoremap <buffer> ' "

function! General_file_cr_controller(...)
    let template = ''
    let key = a:0 >= 1 ? a:1 : 'default'
    let templateRef = s:get_file_ref('cr_templates')
    if s:exists(templateRef)
        let template = templateRef[key]
    else
        let template = s:get_file_ref('cr_template')
    endif

    if empty(template)
        " ec 'no cr template for this file'
        " return
        let template="$datetime: $datetime\n"
    endif

    call s:create_section_from_snippet(template)
    
endfunction
let g:execRef2["cr"] = "General_file_cr_controller"
let g:fileRef[".vimrc"] = {}
let g:fileRef[".vimrc"]["cr_template"] = "function Foo() {\n    $c\n}"

inoreab <silent> <buffer> <expr> tl TLExpr('tl', 1)

function! NormalThrowLog()
    let s = getline('.')
    let el = s:getiden(s)
    let t = s:jspy('echoLogThrowTemplate')
    " call input(json_encode({"el": el, "t": t}))
    let log =  s:templater2(t, el)
    return s:appendbelow(log)
endfunction
" inoremap tl :call NormalThrowLog()<cr> 


function! GetGitDirPath() abort
  let dir = fnameescape(fnamemodify(GetGitFilePath(), ':h'))
  let c = 0
  while c < 5
      let c += 1
      if IsDir(dir . '/.git')
          return dir
      endif
      let dir = Head(dir)
      " call input('dir: ' . s:string(dir))
  endwhile
  throw "stop@@!!! no git path found"
endfunction
function! GetGitFilePath()
  let path = s:gitpath()
  return path
endfunction

function! GetGitFilePathName()
    return s:tail(s:gitpath())
endfunction
let g:vimFunctionAliases["gitfile"] = "GetGitFilePath"
let g:vimFunctionAliases["gitfilename"] = "GetGitFilePathName"
let g:fileRef["geometry.template.js"] = {"node1":{"run":"runGeometryFile.js","argFile":"geometry.template.js"},"execRef":{"sayhi":"Sayhi(\"new file init -- still unset\")"},"linked6asd":"asdasdasd","linked6":"runGeometryFile.js","aanode1":{"runtimeFile":"stylus.js","args":["currentFile"]}}
let g:fileRef["geometry.template.js"]["cr_template"] = "datetime:$datetime\ncode:\n\n$c"
let g:linkedBufferGroups["runGeometryFile.js"] = "geometry.template.js"
let g:linkedBufferGroups["geometry.template.js"] = "runGeometryFile.js"


function FSEF_geometry_template_js__extract_helpers(...)
    let s = a:0 >= 1 ? a:1 : ""
    let state = s:get_visual_state('dashes', 'extractHelpers')
    return VJavascriptConnector(state)
endfunction
let g:fileRef["geometry.template.js"]["execRef"]["extract"] = "FSEF_geometry_template_js__extract_helpers"

function! s:get_visual_state(key, arg)
    let key = a:key
    let arg = a:arg
    let indexes = s:gi(key)
    let lines = s:getlines(indexes)
    return {"file": expand('%'), "key": key, "arg": arg, "indexes": indexes, "lines": lines}
endfunction
function! GetDashIndexes()
    let r = '^--'
    let r = '--'
    let i = s:fliup(r) + 1
    let b = s:fli(r, i, 1, 500, 0)
    return [i, b]
endfunction


function! Ins()
    call s:insert_at_insertion_point(GetBindingName())
endfunction
let g:execRef2["ins"] = "Ins"
let g:filedict["gts"] = "/home/kdog3682/2023/geometry.template.js"

function! s:lom(s)
    let s = a:s
    let ref = {
        \'kva': '[k,v]',
        \'kv': 'k, v',
        \'ab': 'a, b',
        \'': '',
    \}
    return get(ref, s, s)
endfunction

let g:wpsnippets2["javascript"]["lom"] = "const $1::runner = (${s:lom($2)}) => {\n    $c\n}"


let g:filedict["vimc"] = "/home/kdog3682/2023/vimConnector.js"
function! Get_root_to_cursor_indexes()
	let up = s:fliup('^\S')
    let down = line('.')
    return [up, down]
endfunction
let g:visualactiondict['vsc'] = {'fn': 'VJavascriptConnector', "arg": "createVueComponentString", "i": "start_to_end", 'indent_zero': 1}
let g:wpsnippets2["javascript"]["ce"] = "class ${Capitalize($1)} extends ${Capitalize($2)} {\n    $c\n}"


function! s:get_function_names()
    let t = s:get_page_text()
    let r = "\n" . s:jspy('function_re')
    let m = s:findall(t, r)
    return m
endfunction
let g:jspyref3['vim']['function_re'] = '(function!?) \zs\w+'
let g:jspyref3['python']['function_re'] = '(class|def) \zs\w+'
let g:jspyref3['javascript']['function_re'] = '(class|(async )?function) \zs\w+'
let g:execRef2["gfn"] = "Get_function_names"

" change the quotes to single_quotes

function! s:gitstuff()
    throw "not done yet actually we moved to gitParser.js and s:node_manager"
    " let result = s:system_cmd("
        " \\n cd /home/kdog3682/2024/
        " \\n git log --numstat >> /home/kdog3682/2024/git.temp.txt
    " \")

    " numstat provides that useful information

    " let result = s:system_cmd("
        " \\n cd /home/kdog3682/2024/
        " \\n git log --raw --no-merges --numstat > /home/kdog3682/2024/git.temp2.txt
    " \")

    " a template
    " let result = s:system_cmd("
        " \\n cd /home/kdog3682/2024/
        " \\n git log --raw --no-merges --numstat > /home/kdog3682/2024/git.temp2.txt
    " \")

    " let result = s:system_cmd("
        " \\n cd /home/kdog3682/2024/
        " \\n git show 717b417 > /home/kdog3682/2024/clip.txt
    " \")
    " return result
    "this file shouldbe ignored because of the word 'temp'
    let result = s:system_cmd("
        \\n cd %s
        \\n git log --raw --no-merges --numstat > %s
    \", dir, outpath)
endfunction

function! s:gitstuff()
    let dir = '/home/kdog3682/2023/'
    let outpath = '/home/kdog3682/2024/git-data.txt'

    return s:system_cmd("
        \\n cd %s
        \\n git log --raw --no-merges --numstat > %s
    \", dir, outpath)
endfunction




let g:filedict["ex"] = "/home/kdog3682/2023/examples.template.js"
let g:fileRef["examples.template.js"] = {}
let g:fileRef["examples.template.js"]["node1"] = {"run":"/home/kdog3682/2024-javascript/evalenv/runExampleFile.js","argFile":"/home/kdog3682/2023/examples.template.js"}
let g:fileRef["examples.template.js"]["linked6"] = "/home/kdog3682/2024-javascript/evalenv/runExampleFile.js"
let g:fileRef["examples.template.js"]["cr_templates"] = {}
let g:fileRef["examples.template.js"]["cr_templates"]['arg'] = "datetime: $datetime\ndesc: testing out some code\ncode:\n\n$c"
let g:fileRef["examples.template.js"]["cr_templates"]['default'] = "datetime: $datetime\ninpath: $prevbuffer\noutpath: clip.js\n\ncode:\nfunction main(s) {\n    const r = $c\n    const matches = findall(r, s)\n}"
let g:fileRef["examples.template.js"]["colon_action"] = 1

function! s:collect_fuzzy_functions()
    let a = s:get_function_names()
    let c = 0
    let items = []
    while c < 10
        ec items[0:5]
        let r = input('re: ')
        if empty(r)
            return items
        endif
        let items = matchfuzzy(a, r)
        redraw!
    endwhile
endfunction

let g:fileRef["coding_lectures.txt"] = {}
let g:fileRef["coding_lectures.txt"]["cr_template"] = "datetime: $datetime\nhowdy from General_file_cr_controller: $c\n"

let g:filedict["ets"] = "/home/kdog3682/2023/examples.template.js"
let g:wpsnippets2["javascript"]["se"] = "start\n\n$c\n\nend"

function! Get_Start_to_end_Indexes()
	return [s:fliup('^start$') + 1, s:flidown('^end$') - 1]
endfunction
let g:filedict["cpg"] = "/home/kdog3682/2023/code-playground.html"

function! s:dashcase(s)
    " test: "asdf mamsdas"
    let s = a:s
    return join(map(split(s, '\v |\ze[A-Z]'), 'tolower(v:val)'), '-')
endfunction

let g:visualactiondict['vn'] = {'fn': 'VReplaceVueNameWithinRange', 'i': 'window'}
function! s:insensitive(s)
    let s = a:s
    let letters = SplitSingles(s)
    let template =  'printf("[%s%s]", tolower(v:val), toupper(v:val))'
    return join(map(letters, template), '')
endfunction

function! AddExport(...) abort
    let name = ''
    try
        let name = a:0 >= 1 ? a:1 : GetBindingName()
    catch
        let name = s:gcw()
    endtry
    let h= Head()
    if Test(h, '/(apps|finishers)/?$')
        try
            let index = s:fli('^export', 0, 1, 100, 0, 1)
            if index== line('$')
            call append(0, 'export default ' . name)
            return 
            endif
            let s= getline(index)
            if Test(s, '\{')
                call cursor(index, 100)
            elseif Test(s, name)
                ec "already exists"
            else
                call cursor(index, 100)
                return 
            endif
        catch
            call append(0, 'export default ' . name)
        endtry
        return 
    endif
    " call input(string(name))
    try
        let index = s:fli('^export \{', 0, 1, 10, 0, 1)
        let t = getline(index)
            if index== line('$')
        let lines = ['export {', '    ' . name . ',', '}']
        let i = 0
        call append(i, lines)
            return
        endif
        if s:t(t, '\}')
            call s:get_set_replace(index, '\{', '{ ' . name . ',')
        else
            call append(index + 1, '    ' . name . ',')
        endif
    catch
        let lines = ['export {', '    ' . name . ',', '}']
        let i = 0
        call append(i, lines)
    endtry
endfunction
function! s:get_set_replace(i, r, rep)
    let i = a:i
    let s:r = a:r
    let s:rep = a:rep
    function! s:inner_get_set_replace(s)
        let s = a:s
        return s:sub(s, s:r, s:rep)
    endfunction
    call s:getsetline('s:inner_get_set_replace', a:i)
endfunction
let g:fileRef["lezer-sampleString.js"]["execRef"]["dup"] = "DuplicateTheCodeSection"

function! DuplicateTheCodeSection()
    let top = s:fliup('^---')
    let code = s:fli('^code:', top, 1, 500, 0)
    let down = s:fli('^(\w+:|---)', code, 1, 500, 0) - 1
    let lines = s:getlines([code, down])
    call insert(lines, '')
    call insert(lines, 'arg:')
    call insert(lines, 'date: ' . GetTime())
    call insert(lines, GetHR())
    call insert(lines, '')
    call append('$', lines)
endfunction

let g:lezerWords = ["ArrayExpression","ArrayPattern","ArrowFunction","AssignmentExpression","AwaitExpression","BinaryExpression","BlockComment","ClassBody","ClassDeclaration","ClassExpression","Decorator","EnumDeclaration","ExportDeclaration","ExportGroup","ForInSpec","ForOfSpec","FunctionDeclaration","FunctionExpression","ImportDeclaration","ImportGroup","IndexedType","IndexSignature","InterfaceDeclaration","Interpolation","InterpolationStart","LessThan","LineComment","MemberExpression","MethodDeclaration","MethodType","NamespaceDeclaration","ObjectPattern","ObjectType","Optional","ParamList","ParamTypeList","ParenthesizedExpression","PatternProperty","PrivatePropertyDefinition","PrivatePropertyName","Property","PropertyDeclaration","PropertyDefinition","PropertyName","PropertyType","SequenceExpression","SingleClassItem","SingleExpression","TemplateString","TemplateType","UnaryExpression","VariableDeclaration","VariableDefinition","VariableName","YieldExpression","RegExp", "ArgList"]
let g:fileRef["lezer-sampleString.js"]["localFileSpecificWords"] = g:lezerWords



let g:filedict["lts"] = "/home/kdog3682/2023/lezer.template.js"
let g:fileRef["lezer.template.js"] = {}
let g:fileRef["lezer.template.js"]["node1"] = {"run":"runLezerFile.js","argFile":"lezer.template.js"}
let g:fileRef["lezer.template.js"]["linked6"] = "runLezerFile.js"
let g:fileRef["lezer.template.js"]["a8file"] = "runLezerFile.js"
let g:fileRef["lezer.template.js"]["cr_template"] = "datetime: $datetime\nlang: javascript\ninpath:\noutpath:\narg:\n\n$c\n\ncode:\n\nfunction main(state) {\n    return console.loggg(traverseJson(state))\n    return clip(traverseJson(state))\n}\n"
let g:gfgfdict['pm'] = ['/home/kdog3682/2023/node-utils.js', 'packageManager3', 0]
let g:wpsnippets2["javascript"]["do"] = "do {\n    $c\n} while ()"
let g:wpsnippets2["javascript"]["switch"] = "WPSwitch"
let g:wpsnippets2["javascript"]["empty"] = "if (empty($1)) {\n    $c\n}"

function! s:get_file_from_line(...)
    let s = a:0 >= 1 ? a:1 : getline('.')
    return s:match(s, g:fileRE)
endfunction
function FSEF_files_log__df_delete_file(...)
    let file = s:get_file_from_line()
    call s:delete_file(file)
endfunction
let g:fileRef["files.log"]["execRef"]["df"] = "FSEF_files_log__df_delete_file"
function! s:delete_file(file)
    let file = a:file
    if !s:is_file(file)
        ec 'no delete: ' . file . ' iz  not a file'
        return 
    endif
    call SafeGuard(file)

    " try
        " execute "bd! " . file
    " catch
        " let error = v:exception
        " ec error
    " endtry

    ec 'deleting file: ' . file
    call delete(file)
endfunction
function! s:get_location_name()
	" similar to get binding name ... except ... smarter
    let i = s:fli('^\S', '.', -1, 500, 0, 1)
    let s = getline(i)
    let r = g:functionPrefixRE . '\zs\w+'
    let m = s:match(s, r)
    if s:exists(m)
        return m
    endif
    let m = s:match(s, '[a-z0-9]{6,}')
    let ignore = [ "function", "return", ]
    if s:exists(m) && !s:in(ignore, m)
        return m
    endif
    return s:prompt('choose location name')
endfunction
nnoremap ex :call OpenBuffer4("/home/kdog3682/2023/examples.template.js")<CR>

function FSEF_files_log__rn(s)
    let s = a:s
    let file = s:get_file_from_line()
    let new = a:s
    if s:t(s, '/')
        let [a,b] = s:so(s, '/')
        let a = s:sub(a, 'spc', ' ')
        let new = s:sub(file, a, b, '')
    endif
    call s:move_file(file, new)
endfunction

let g:fileRef["files.log"]["execRef"]["rn"] = "FSEF_files_log__rn"

function! s:move_file(a, b)
    let a = a:a
    let b = a:b
    let s = printf('!mv "%s" "%s"', a, b)
    ec s:execute(s)
endfunction

inoremap <buffer> w] [<cr>\]<c-o>O<space><space><space><space>

function! s:app_see_maparg()
    let expr = "wp"
    let result = maparg(expr, '', 0, 1)
    return result
endfunction
function! s:app_go_map_arg(s)
    " test: "gp"
    let expr = s:sub(a:s, ',', '<leader>')
    let result = maparg(expr, '', 0, 1)
    ec result
    return
    if empty(result)
        return 
    endif
    let rhs = result.rhs
        """ bookmarkId: 1702483424 hfel: function! """
    let regexes = [
        \'Handler\(''(s:\w+)',
    \]

    let match = s:imatch(rhs, regexes)
    if s:exists(match)
        call s:open_function(match)
    else
        call Jump(result.lnum)
    endif
    return 1
endfunction
function! s:colon_label_action()
    let keys = [ "label", "inpath", "desc", "outpath"]
    let value = s:choose(keys) . ': '
    " let value = '"desc: '
    try
        call search('\v^(code)@!\S+:', 'b')
        " nla
    catch
        let error = v:exception
        ec error
        return 
    endtry
    call append('.', value)
    execute "normal! \<down>/: /e\<CR>"
    startinsert!
endfunction



function! CreateGitLogJSON(...)
    let s = a:0 >= 1 ? a:1 : ''
    let dir = s:get_dir(s)
    ec dir
    call s:node_manager('gitParser', dir)
endfunction
function! s:node_manager(key, ...)
    " test: "asdf", "aa"

    let args = ['nodeManager.js', a:key] + a:000
    let result = call(function('s:evaljs'), args)
    if s:exists(result)
        ec result
    endif
endfunction
let g:execRef2["cgl"] = "CreateGitLogJSON"
let g:filedict["gp"] = "/home/kdog3682/2023/gitParser.js"

function FSEF_files_log__e(...)
    let file = s:get_file_from_line()
    let o = {
        \'file': file,
        \'code': "function main(data) {\n    $c\n}",
    \}
    call s:open('examples.template.js')
    call s:create_section_from_snippet(s:create_snippet_from_object(o))
endfunction
" let g:fileRef["files.log"]["execRef"]["e"] = "FSEF_files_log__e"
function! s:has_newline(s)
    let s = a:s
    return s:t(s, '\n')
endfunction
function! s:create_snippet_from_object(o)
    let o = a:o
    let out = ''
    let base = {
        \'datetime': GetTime(),
    \}
    for [k,v] in items(base)
        let delimiter = s:has_newline(v) ? "\n\n" : ' '
        let out .= k . ':' . delimiter . v . "\n"
    endfor

    for [k,v] in items(o)
        let delimiter = s:has_newline(v) ? "\n\n" : ' '
        let out .= k . ':' . delimiter . v . "\n"
    endfor
    return out . "\n\n"
endfunction
let g:wpsnippets2["javascript"]["time"] = "const time = (new Date()).getTime()"
let g:linkedBufferGroups["runLezerFile.js"] = "lezer.template.js"
let g:linkedBufferGroups["lezer.template.js"] = "runLezerFile.js"

let g:execRef2["shf"] = "SetHighFrequencyEditLocation"


let g:fileRef["cm.template.js"] = {}
let g:fileRef["cm.template.js"]["node1"] = {}
let g:fileRef["cm.template.js"]["alias"] = "cts"
let g:fileRef["cm.template.js"]["node1"]["run"] = "runCmFile.js"
let g:fileRef["cm.template.js"]["node1"]["argFile"] = "cm.template.js"
let g:fileRef["cm.template.js"]["a8file"] = "runCmFile.js"
let g:fileRef["cm.template.js"]["cr_template"] = "datetime: $datetime\nlang: javascript\ninpath:\noutpath:\narg:\n\ncode:\n\nfunction main(s) {\n\n}\n"

let g:execRef2["f"] = "RegisterFileDict"
let g:linkedBufferGroups["runCmFile.js"] = "cm.template.js"
let g:linkedBufferGroups["cm.template.js"] = "runCmFile.js"

let g:wpsnippets2["python"]["hr"] = ""


function! RegexCollectionService(regexKey)
    let regexKey = a:regexKey
    let state = s:get_line_state('window')
    let result = s:javascript_via_vim('RegexCollectionService', state.lines, regexKey)
    call s:set_paste_buffer(result)
    " call s:append
    " return s:replaceblock(state.indexes, result, 0)
endfunction

function! s:javascript_via_vim(fn, lines, ...)
    let file = a:0 >= 1 && s:exists(a:1) ? a:1 : 'vimConnector.js'
    let fn = a:fn
    let lines = a:lines

    " let s = s:tostring(map(lines, 's:removestartingcomments(v:val)'))
    let s = s:tostring(lines)
    let res = EvaluateFromShell('node', file, fn, s, &filetype)
    " ec s:is_array(res) true
    " return
    if s:t(res[-1], '^node.js')
        ec res
        return 
    endif
    " let res[0] = s:sub(res[0], '"', '\\\\\"')
    " ec res[0]
    " call input('')
    return json_decode(res[0])

endfunction
let g:execRef2["cs"] = "RegexCollectionService"


function! s:function_string(...)
    let template = s:jspy('functionTemplate')
    return s:templater2(template, a:000)
endfunction


function! InsertFunctionIntoVimConnector()
    let file = 'vimConnector.js'
    let fnKey = s:gcw()
    return InsertFunctionIntoFileViaInsertionPoint(file, fnKey)
endfunction

function! InsertFunctionIntoFileViaInsertionPoint(file, fnKey)
    let file = a:file
    let fnKey = a:fnKey

    let fnStr = s:function_string(fnKey, s:paramify(s:xsplit(s:prompt('xsplit params', 's'))))
    
    call s:open(file)
    call s:insert_at_insertion_point(fnKey)
    call s:create_bottom_of_page_snippet(file, fnStr)
endfunction
let g:jspyref3["vim"]["execFunctions"]["ivc"] = "InsertFunctionIntoVimConnector"

let g:jspyref3["javascript"]["functionTemplate"] = "function $1($2) {\n    $c\n}"
let g:jspyref3["vim"]["functionTemplate"] = "function $1($2) {\n    $n}"
function! s:get_line_state(key)
    let key = a:key
    let indexes = s:gi(key)
    let lines = s:getlines(indexes)
    return {"key": key, "indexes": indexes, "lines": lines}
endfunction

function! s:set_paste_buffer(x)
    let @" = s:tostring(a:x)
endfunction
let g:wpsnippets2["javascript"]["err"] = "JavascriptErrorString"

function! s:paramify(s)
    let s = a:s
    return Paramify(s)
endfunction
function! JavascriptErrorString(s)
    " test: "sdf sdf aa"
    return s:templater2('throw {$1}', s:paramify(s:xsplit(a:s)))
endfunction

function FSEF_package_json__update(...)
    let s = a:0 >= 1 ? a:1 : ''
    let key = s:match(getline('.'), '"(.{-})"')
    ec s:system_cmd('npm update ' . key)

endfunction
let g:fileRef["package.json"] = {}
let g:fileRef["package.json"]["execRef"] = {}
let g:fileRef["package.json"]["execRef"]["update"] = "FSEF_package_json__update"
function! s:callable(s, ...)
    let args = map(copy(a:000), 's:to_argument(v:val)')
    return a:s . '(' . s:paramify(args) . ')'
endfunction
function! s:single_quote(s)
    let s = a:s
    return "'" . s . "'"
endfunction
function! s:to_argument(s)
    let s = a:s
	return s:is_number(s) ? s : s:single_quote(s)
endfunction
function! s:is_number(s)
    let s = a:s
	return IsNumber(s)
endfunction

function! SetCurrentMostActiveFile()
    let g:currentMostActiveFile = "$1"
    call s:set_variable('g:currentMostActiveFile', CurrentFile())
endfunction
let g:execRef2["ez"] = "SetCurrentMostActiveFile"
function! s:set_temporary_variable(k, v)
    let k = a:k
    let v = s:is_number(a:v) ? a:v : s:single_quote(a:v)
	let t = printf('let %s = %s', k, v)
    execute t
endfunction
let g:currentMostActiveFile = "/home/kdog3682/2023/lezer.template.js"

function! s:set_variable(k, v)
    let k = a:k
    let v = s:is_number(a:v) ? a:v : s:single_quote(a:v)
	let t = s:templater2('let $1 = $2', [k, v])
    call s:append_and_execute(t)
endfunction
let g:currentMostActiveFile = "/home/kdog3682/2023/lezer.template.js"

function FSEF_package_json__show(...)
    let s = a:0 >= 1 ? a:1 : ''
    let key = s:match(getline('.'), '"(.{-})"')
    ec s:system_cmd("npm show " . key)
endfunction
let g:fileRef["package.json"]["execRef"]["show"] = "FSEF_package_json__show"
let g:filedict["cts"] = "/home/kdog3682/2023/cm.template.js"
let g:currentMostActiveFile = "/home/kdog3682/2023/cm.template.js"
let g:linkedBufferGroups["cm-next2.js"] = "cm.template.js"
let g:linkedBufferGroups["cm.template.js"] = "cm-next2.js"


let g:filedict["lf"] = "/home/kdog3682/2023/lezer-functions.js"
" let g:fileRef["cm.template.js"]["localFileSpecificWords"] = g:lezerWords
let g:fileRef['l.env.js'] = {}
" let g:fileRef["l.env.js"]["localFileSpecificWords"] = g:lezerWords
let g:filedict["cmn"] = "/home/kdog3682/2023/cm-next2.js"

function! CopyBlockToFile(fileKey)
    let fileKey = a:fileKey
    let lines = s:getlines("code")
    let file = FileGetter2(fileKey)
    call s:appendfile(file, lines)
endfunction
let g:execRef2["cp"] = "CopyBlockToFile"
function! s:print_list(items, n, ...)
    redraw!
    let length = len(a:items)
    let display = a:0 >= 1 ? a:1 : ''
    let items = a:items[0:a:n - 1]
    while len(items) < a:n
        call add(items, '')
    endwhile
    for i in range(len(items))
        let item = items[i]
        ec (i + 1) . '.  ' . (s:is_string(item) ? item : s:string(item))
    endfor
    let delta = length - len(items)
    if delta > 1
        ec printf(' ... and %s more items', delta)
    endif
endfunction
let g:execRef2["fsf"] = "FindScriptFunction"

let g:wpsnippets2["javascript"]["jsdoc"] = "WPJsDoc"

function! s:get_indent(s)
    let s = a:s
    let m = Match(s, '^ *')
    return len(m)
endfunction

function! s:get_parameters(s)
    let s = a:s
    let s = s:sub(s, '\= *\S+')
    let s = s:sub(s, '\w+\(')
    return s:get_words(s)
endfunction

function! WPJsDoc()
    let r = '^    \#?\w+\((.{-})\)'
    let i = s:fli(r, '.', -1, 100, 0)
    let s = getline(i)
    let m = s:match(s, r)
    " let spaces = s:get_indent(s)
    let start = ['/**']
    function! s:getter(s)
        let s = a:s
        if s == 'x'
            return '$c'
        elseif has_key(g:jsdoc_type_ref)
            return g:jsdoc_type_ref[s]
        else
            return ''
        endif

    endfunction
    function! s:inner(s)
        let name = a:s
        let type = s:getter(s)
        return printf('@param {$1} $2', type, name)
        
    endfunction
    let params = map(s:get_parameters(s), 's:inner(v:val)')
    call add(params, '@return ')
    return s:joinlines(start + params + end)

    let end = ['*/']

    if empty(m)
        return 
    endif
    let s = ''
endfunction
let g:filedict["up"] = "/home/kdog3682/PYTHON/utils.py"
let g:wpsnippets2["python"]["vim"] = "VimEvalString"

function FSEF_examples_template_js__ins(...)
    let s = a:0 >= 1 ? a:1 : ''
    let file = 'node-utils.js'
    let fnKey = s:gcw()
    return InsertFunctionIntoFileViaInsertionPoint(file, fnKey)
endfunction
let g:fileRef["examples.template.js"]["execRef"] = {}
let g:fileRef["examples.template.js"]["execRef"]["ins"] = "FSEF_examples_template_js__ins"
let g:wpsnippets2["javascript"]["ins"] = "/* insertion-point-below-object */"
let g:execRef2["gsf"] = "s:go_script_function"
let g:execRef2["abc"] = "Skdfjksdlj0f"
function! s:get_most_recent_file(key)
    " test: "dl"
    let key = a:key
    let dir = s:get_dir(key)
    let files = s:glob('', dir)
    let latest_mtime = 0
    let latest_file = ""
    for file in files
        if !s:is_file(file)
            continue
        endif
        let mtime = getftime(file)
        if mtime > latest_mtime
          let latest_mtime = mtime
          let latest_file = file
        endif
    endfor
    return latest_file
endfunction



function! s:get_vim_state_arg(x)
    let x = a:x
    if empty(x)
        return ''
    elseif has_key(g:vimFunctionAliases, x)
        return function(g:vimFunctionAliases[x])()
    else
        return x
    endif
endfunction
function! s:visual_vim_to_javascript(state)
    let state = a:state
    let block = s:evaljs(state.file, state.fnKey, state.text, state.arg)
    " call input('block: ' . s:string(block))
    if state.after == 'replace'
        return s:replaceblock(state.indexes, block)
    elseif state.after == 'jsonasdasd'
        return 
    endif

    let value = js_decode(block[0])
    let json = eval(join(block, ''))

    if s:t(state.after, '^s:')
        return s:call(state.after, json)
    else
        ec json
    endif
endfunction
let g:visualactiondict['pretty'] = {'fn': 's:visual_vim_to_javascript', 'i': 'code', 'fnKey': 'prettier', 'file': 'app.manager.js', 'version': 3, 'after': 'replace'}
let g:visualactiondict['collector'] = {'fn': 's:visual_vim_to_javascript', 'i': 'code', 'fnKey': 'collector', 'file': 'app.manager.js', 'version': 3, 'after': 'json'}

function! s:register_app_file()
    let file = s:tail()
    let name = s:match(file, 'app.\zs\w+')
    call append('$', ['', '', 'export default ' . name])
    call s:open('app.manager.js')
    call append(0, s:templater2('import $1 from "./$2"', [name, file]))
    call s:insert_at_insertion_point(name)
endfunction
" nnoremap <buffer> <c-f> :call s:go_script_function()<CR>
call add(g:normalCommands, "s:register_app_file")
function! s:call(s, ...)
	return call(function(a:s), s:flat(a:000))
endfunction
function! s:create_app_file(file)
    let file = a:file
    let tail = s:tail(file)
    let name = s:match(file, 'app.\zs\w+')
    call s:open('/home/kdog3682/.vimrc')
    let vaKey = 'temp'
    let after = 'json'
    let fnKey = name
    let visual_action_dict_template = "let g:visualactiondict['$1'] = {'fn': 's:visual_vim_to_javascript', 'i': 'code', 'fnKey': '$2', 'file': 'app.manager.js', 'version': 3, 'after': '$3'}"
    let visual_action_dict_template_value = s:templater2(visual_action_dict_template, [vaKey, fnKey, after])
    call append('$', visual_action_dict_template_value)
    call s:open('app.manager.js')
    call append(0, s:templater2('import $1 from "./$2"', [name, tail]))
    call s:insert_at_insertion_point(name)
    call s:create_buffer(file)
    call append('$', [s:templater2('function $1(s) {', name), '', '}', '', '', 'export default ' . name])
	
endfunction
nnoremap <leader>f :call AnythingHandler2('gsf')<CR>

function! s:create_buffer(file)
    let file = a:file
    let mode = 'edit'
    let cmd = mode . ' ' . file
    execute cmd
    call s:log_file_creation_time(file)
endfunction
let g:filedict["amj"] = "/home/kdog3682/2023/app.manager.js"

function! s:get_regex_from_chatgpt_json()
    let data = s:get_json_data_from_key('regexes2', 'array')
    let options = {'text_cb' : {v -> v.name}}
    let displayKey = 'pattern'
    let value = s:match_fuzzy_repl(data, options, displayKey)
    return value.pattern
endfunction
function! s:get_json_data_from_key(key, type_validation) abort
    let key = a:key
    let type_validation = a:type_validation
    let file = '/home/kdog3682/2024/' . key . '.json'
    call assert_true(s:isfile(file))
    let s = s:joinlines(readfile(file))
    let value = json_decode(s)
    call s:validate_type(value, type_validation)
    return value
endfunction

function! s:register_nnoremap_function_command(key, fn)
    " test: "n", "sdf"
    call s:register_vim_function_command("n", a:key, a:fn)
endfunction

function! s:register_vim_function_command(keymap, key, fn, ...)
    let keymap = a:keymap
    let key = a:key
    let fn = a:fn
    let flags = a:0 >= 1 ? s:xsplit(a:1) : []

    let s = ""
    let ref = {
        \'n': 'nnoremap',
        \'i': 'inoremap',
        \'s': '<silent>',
        \'b': '<buffer>',
        \'e': '<expr>',
    \}
    let keymap = get(ref, keymap)
    call map(flags, "get(ref, v:val, v:val)")
    let command = printf(":call %s()<CR>", fn)
    let parts = [keymap] + flags + [key, command]
    let cmd = join(parts, " ")
    ec cmd
    "nnoremap <silent> <buffer>%s :call %s()<CR>",
endfunction
function! s:validate_type(value, type_validation) abort
    let value = a:value
    let type_validation = a:type_validation
    if type_validation == 'array' && !s:is_array(value)
        throw 'TypeValidationError: Value == not of Type Array'
    endif

    if type_validation == 'object' && !s:is_object(value)
        throw 'TypeValidationError: Value == not of Type Object'
    endif
endfunction
function! s:is_object(value)
    let value = a:value
	return IsObject(value)
endfunction

function! s:match_fuzzy_repl(items, ...)
    let items = a:items
    let options = a:0 >= 1 ? a:1 : 0
    let display = a:0 >= 2 ? a:2 : ''
    let amount = 8
    
    ec 'start of fuzzy find'
    ec 'begin typing a char'
    ec 'there are ' . len(items) . ' items'
    ec ''
    ec ''
    let c = 0
    let ch = ''
    let input = ''
    let temp = []
    while c < 30
        try
            let ch = s:getchar()
        catch
            return 
        endtry
        if ch == "\<BS>"
            let input = input[0:-2]
            ec input
            continue
        elseif s:is_number(ch)
            return temp[ch - 1]
        elseif ch == "\<CR>"
            return temp[0]
        else
            if ch == '-'
                let ch = '_'
            endif
            let input .= ch
            if s:exists(options)
                let temp = items -> matchfuzzy(input, options)
            else
                let temp = items -> matchfuzzy(input)
            endif

            call s:print_list(temp, amount, display)
            ec ''
            ec input
        endif
    endwhile
endfunction
function! Sdfksd0f()
   echo [{'name': 123}]->matchfuzzy('abc')
   " for some reason ... this works
endfunction

function! s:deep_assign(store, ...)
    let store = a:store
    
endfunction


function! Asdfasdflkasdfkl()
    let store = {}
    for [k,v] in items(g:gfgfdict)
        let [file, fn, loc] = v
        let la = s:get_file_type(file)
        call s:deep_assign(store, la, k, fn)
    endfor
endfunction

function! s:comment_below(index, a, b)
    let index = a:index
    let a = a:a
    let b = a:b
    let message = a . ': ' . b
    let spaces = s:get_function_index

    call append(index, message)
endfunction
function! s:app_pair_functions()
    let a = s:get_script_function()
    let b = s:get_binding_name()
    let ia = s:get_function_index()
    call s:comment_below(ia, paired with', a)
    let found = s:go_function_index(a)
    if found
        call s:comment_below(found, paired with', b)
        
    endif
endfunction
function! s:app_go_gfgf_item(...)
    let key =  a:0 >= 1 ? a:1 : ''

    if s:exists(key)
        let base = s:dict_getter(g:jspyref3, &filetype, 'gfgf_dict')
        if has_key(base, key)
            let ref = base[key]
            call s:open(ref.file)
            call s:open_function(ref.function)
            return 
        endif
    endif

    if &filetype == 'vim'
        let refs = [g:execRef2, g:execRef]
        for item in refs
            if has_key(item, key)
                let fn = item[key]
                if IsObject(fn)
                    let fn = fn.fn
                endif
                return s:open_function(fn)
            endif
        endfor

        let result = s:app_go_map_arg(key)
        if s:exists(result)
            return 
        else
            return GoFileGoFunction(key)
        endif
    elseif &filetype == 'javascript'
        let fn = s:gcw()
        call s:open('utils.js')
        call s:open_function(fn)

    elseif &filetype == 'python'
    endif
endfunction

function! s:_go_vim_file_go_function(key)
    let key = a:key
endfunction



function! s:app_close_hidden_buffers()
    let bufnr_list = filter(range(1, bufnr('$')), '!buflisted(v:val)')
    for bufnr in bufnr_list
        try
            execute 'bd ' . bufnr
            ec 'closing ' . bufname(bufnr)
        catch
        endtry
    endfor
endfunction

function! s:get_binding_name()
    return GetBindingName()
endfunction
function! s:append_and_execute_helper(k, ...)
    let k = a:k
    let value = s:gval(k)
    let expr = ''
    if s:is_array(value)
        let expr = printf('call add(%s, "%s")', k, a:1)
    elseif IsObject(value)
        let expr = s:dict_setter(k, a:000)
    endif
    call s:append_and_execute(expr)
endfunction
function! s:app_normal_command_registrar()
    call s:append_and_execute_helper('g:normalCommands', s:get_binding_name())
endfunction
function! s:is_string(s)
    let s = a:s
    return IsString(a:s)
endfunction
call add(g:normalCommands, "s:app_normal_command_registrar")
call add(g:normalCommands, "s:app_close_hidden_buffers")

function! s:app_normal_registrar()
    let t = "nnoremap $1 :call $2()<cr>"
    let a = input('sadasd')
    let b = s:get_binding_name()
    let cmd = s:templater2(t, [a, b])
    s:append_and_execute(cmd)
    call s:append_and_execute_helper('g:normalCommands', s:get_binding_name())
endfunction
let g:qq_ref = {
    \'m': "s:get_most_recent_file('dl')",
    \'b': "MostRecentFile('budir')",
    \"z": 'join(g:weekdays, "\n")',
    \'r': "s:fuzzy(s:months)",
    \'d': "g:dir2024",
    \'qd': "g:dldir",
    \'e': "s:string(s:gval(input(\"input to be valuated: \")))",
    \'9': "9",
    \'1': "Head()",
    \'p': "'/home/kdog3682/PYTHON/'",
    \'j': "'/home/kdog3682/2023/'",
    \"'": "bufname('%')",
    \'fl': "s:tail(GetFileLogFiles(input('input: '), 30))",
    \'ff': "FindFunctionInText(InputChars(2))",
    \'fg': "FileGetter2(input(''))",
    \'x':  "s:get_dir(input(''))",
    \'c': "FarawayFunctionCompletion()",
    \'cwf': "CurrentFile()",
    \'sc': "QQScreenCompletion()",
    \'38': "s:get_prev_buffer_name()",
    \'39': "s:doublequote(s:get_current_buffer_name())",
    \'444': "s:doublequote(s:get_current_buffer_name())",
    \'4': "s:get_current_buffer_name()",
    \'s': "s:get_current_buffer_name()",
    \'3': "s:get_prev_buffer_name()",
    \'ja': "OpenBuffer3('/home/kdog3682/2023/node_modules/@lezer/javascript/src/javascript.grammar')",
    \'5': "GetComponents()",
    \'h': "$head",
\}
    " \'j': "'/home/kdog3682/2024-javascript/'",
""" bookmarkId: 1708381700 hfel: qq_ref """
function! s:regex_completion(key)
    " test: "call"
    let key = a:key[2:]
    let data = s:get_json_data_from_key('regexes2', 'array')
    let items = matchfuzzy(data, key, {'text_cb': {x -> x.name}})[0:8]
    return map(items, 'v:val.pattern')
endfunction

let g:vim_eval_ref = {
    \'glf': { 'fn': 's:get_most_recent_file', 'args': ['dl'] },
\}
" let g:visualactiondict['jsx'] = {'fn': 's:visual_vim_to_javascript', 'i': 'smart', 'fnKey': 'lazy_object_parser', 'file': 'app.manager.js', 'version': 3, 'after': 'replace'}

function! s:get_dir(x)
    let x = a:x

    if s:is_file(x)
        return x
    elseif has_key(g:directoryaliases, x)
        return g:directoryaliases[x]
    elseif has_key(g:dirdict, x)
        return g:dirdict[x]
    elseif IsDir("/home/kdog3682/2024-" . x)
        return "/home/kdog3682/2024-" . x
    else
        throw x
    endif
endfunction
function! s:get_lazy_object_parser_indexes()
    let up = s:fli('^\S', '.', -1, 100, 0, 1)
    let down = s:flidown('^\S')
    if down != line("$")
        let down = s:fli('\S', down, -1, 100, 0)
    elseif getline('$') == ''
        let down = s:fli('\S', down, -1, 100, 0)
    endif
    " call input(json_encode({"up": up, "down": down}))
    return [up, down]
endfunction
let g:wpsnippets2["javascript"]["imd"] = "import $1 from \"./${s:tail(FileGetter2('#'))}\""
let g:visualactiondict['lop'] = {'fn': 's:visual_vim_to_javascript', 'i': 's:get_lazy_object_parser_indexes', 'fnKey': 'lazy_object_parser', 'file': 'app.manager.js', 'version': 3, 'after': 'replace', 'arg': 'filetype'}


function! Sfsdf()
    let g:override_debug = 1
    call s:writefile('booga.json', s:dump_json(g:jspyref3))
endfunction
function! s:dump_json(s)
	return s:tolines(json_encode(a:s))
endfunction

function! s:rename_file(outpath)
    let outpath = a:outpath
    let file = CurrentFile()
    if s:t(outpath, '^\d+$')
        let outpath = s:sub(s:tail(file), '\d+', outpath, '')
    elseif s:t(outpath, '^i$')
        let outpath = s:sub(s:tail(file), '\d+', '\=submatch(0) + 1', '')
    endif
    let outpath = AddExtension(s:tail(outpath), GetExtension(file))
    let new_file = s:npath(s:head(file), outpath)
    execute "saveas " . new_file
    call delete(file)
endfunction
let g:execRef2["rn"] = "s:rename_file"
" get_regex_from_chatgpt_json


function! s:app_register_gfgf_item(...)
    let s = a:0 >= 1 && s:exists(a:1) ? a:1 : ''
    let [abrev, name] = DefineEatHelper(s)
    let payload = { 'file': CurrentFile(), 'function': name }
    let expr = s:dict_setter("g:jspyref3", &filetype, "gfgf_dict", abrev, payload)
    call s:append_and_execute(expr)
endfunction
function! s:go_function_index(name)
    let name = a:name
    let r = '\vfunction!? . name'
    return search(r)
endfunction

let g:fileRef["articles.md"] = {}
let g:fileRef["articles.md"]["cr_template"] = "datetime: $datetime\ntitle:\ntext:\n\n$c\n\n"

function! Foowoke()
    ec g:jspyref3["markdown"]["execFunctions"]
endfunction
" let g:jspyref3["markdown"]["execFunctions"]["cr"] = "CreateMarkdownSection"
function! s:get_map_template(k)
    return g:apae_map_templates[a:k]
endfunction
let g:apae_map_templates = {
    \'ibe': "nnoremap <silent> <buffer> <expr> %s %s()<CR>",
    \'nbe': "nnoremap <silent> <buffer> <expr> %s %s()<CR>",
    \'nnoremap': "nnoremap <silent> <buffer>%s :call %s()<CR>",
    \'nmap': "nnoremap %s :call %s()<CR>",
    \'normal_open_file': "nnoremap %s :call OpenBuffer4('%s')<CR>",
    \'nmap.buffer': "nnoremap <buffer> %s :call %s()<CR>",
    \'nmap.buffer.fn.arg': "nnoremap <buffer> %s :call %s('%s')<CR>",
    \'nmap.fn.arg': "nnoremap %s :call %s('%s')<CR>",
    \'imap': "nnoremap <silent> <buffer>%s %s()<CR>",
    \'inoremap': "inoremap <silent> <buffer> <expr> %s %s()",
    \'no': "nnoremap <buffer>%s :call %s()<CR>",
    \'va': "let g:visualactiondict['%s'] = {'fn': '%s'}",
    \'normal_leader_function': "nnoremap <leader>%s :call %s()<CR>",
\}
function! s:app_registrar()
    let name = s:get_binding_name()
    let modes = [
        \"normal_leader_function",
        \"insert_leader_function",
        \"normal_function",
        \"insert_function",
        \"inoreab",
        \'s:register_language_exec_function',
    \]

    ec 'choose a mode'
    let mode = s:choose(modes)
    if s:t(mode, 's:')
        return function(mode)()
    endif
    let key = s:prompt('choose a key')
    let cmd = printf(g:apae_map_templates[mode], key, name)
    call s:append_and_execute(cmd)
endfunction
call add(g:normalCommands, "s:app_registrar")
call add(g:normalCommands, "s:app_register_gfgf_item")
nnoremap <leader>g :call Handler('s:app_go_gfgf_item')<CR>
nnoremap <leader>h :call Handler('s:app_register_gfgf_item')<CR>
let g:filedict["vue2"] = "/home/kdog3682/2023/vuetify2.js"


function! Handler(key)
    let key = a:key
    call s:call(key, s:prompt('calling function: ' . key))
endfunction
let g:jspyref3["vim"]["gfgf_dict"] = {}
let g:jspyref3["vim"]["gfgf_dict"]["han"] = {"file":"/home/kdog3682/.vimrc","function":"Handler"}

let g:jspyref3["javascript"]["gfgf_dict"] = {}
let g:jspyref3["javascript"]["gfgf_dict"]["tsap"] = {"file":"/home/kdog3682/2023/utils.js","function":"toStringArgumentPretty"}

let g:jspyref3["vim"]["gfgf_dict"]["cr"] = {"file":"/home/kdog3682/.vimrc","function":"General_file_cr_controller"}

inoremap <silent> <buffer> <expr> qq QQ()


function! s:menu_popup()
    let items = ['red', 'green', 'blue']
    let s:items = items
    function! ColorSelected(id, index)
       let index = a:index
       let item = s:items[index - 1]
       ec item
    endfunction
    call popup_menu(s:items, #{
        \ callback: 'ColorSelected',
    \ })
endfunction
let g:execRef2["foo"] = "s:menu_popup"
let g:jspyref3["vim"]["gfgf_dict"]["vv"] = {"file":"/home/kdog3682/.vimrc","function":"s:visual_vim_to_javascript"}
nnoremap <leader>r diwi
let g:wpsnippets2["javascript"]["ifprim"] = "if (isPrimitive($1)) {\n    $c\n}"
let g:jspyref3["javascript"]["gfgf_dict"]["afr"] = {"file":"/home/kdog3682/2023/vuetify2.js","function":"attributionalFunctionRef"}


function! ModularIncrement100(items, key, dir)
    let items = a:items
    let key = a:key
    let dir = a:dir
    return s:modular_increment(items, key, dir)
    
endfunction
function! s:modular_increment(items, key, dir)
    let items = a:items
    let key = a:key
    let dir = a:dir
    let items = a:items
    let key = 's:modular_increment_key_' . key
    if !exists(key)
        call s:set_temporary_variable(key, 0)
        return items[0]
    endif

    let i = eval(key)
    if dir == 1
        if i == len(items) - 1
            call s:set_temporary_variable(key, 0)
            return items[0]
        else
            let n = i + 1
            call s:set_temporary_variable(key, n)
            return items[n]
        endif
    else
        if i == 0
            let n = len(items) - 1
            call s:set_temporary_variable(key, n)
            return items[n]
        else
            let n = i - 1
            call s:set_temporary_variable(key, n)
            return items[n]
        endif
    endif
endfunction
let g:execRef2["ilc"] = "InitiateLogConsole"
call add(g:normalCommands, "s:register_override_node_file")

function! s:run_exec_ref_function()
    let choices = values(g:execRef2)
    let choice = s:fuzzy(choices)
    try
        call s:call(choice)
    catch
        if s:t(v:exception, 'Not Enough Arguments')
            call s:call(choice, s:colon_prompt("write an arg for", choice))
        else
            ec v:exception
            return 
        endif
    endtry
endfunction
call add(g:normalCommands, "s:run_exec_ref_function")
let g:currentMostActiveFile = '/home/kdog3682/2023/vuetify2.js'
function! s:colon_prompt(a, b)
    let a = a:a
    let b = a:b
	let message = a . ": " . b
    return s:prompt(a, b)
endfunction
let g:execRef2["agm"] = "s:app_go_map_arg"
function! s:imatch(rhs, regexes)
    let rhs = a:rhs
    let regexes = a:regexes
    for r in regexes
        let m = s:match(rhs, r)
        if s:exists(m)
            return m
        endif
    endfor
endfunction


function! s:app_go_wp_snippet(tag)
    " test: "s"
    let t = DictGetter3(g:wpsnippets2, &filetype, a:tag)
    if empty(t)
        return 
    endif

    call s:open('/home/kdog3682/.vimrc')
    if s:llvf(t)
        call s:open_function(t)
    else
        let args = [
            \'[''"]',
            \&filetype,
            \a:tag,
        \]
        let r = s:templater2('\v^let g:wpsnippets2\[$1$2$1\]\[$1$3$1\]', args)
        call search(r)
    endif
endfunction
let g:execRef2["agw"] = "s:app_go_wp_snippet"
let g:wpsnippets2["vim"]["s"] = 'NamedJavascriptString'
" nnoremap <buffer>` :call CommandTilda()<CR>
let g:wpsnippets2["javascript"]["niu"] = "throw 'not in use'"

function! FuzzyFileBrowser(key)
    let key = a:key
    let dir = FastGetDirectory(key)
    let files = Absdir(dir)
    let choice = s:fuzzy(files)
    call s:open(choice)
endfunction
function! App_browse_old_files2()
    let files = v:oldfiles + map(getbufinfo({}), "v:val.name")
    let choice = s:fuzzy(files)
    return choice
endfunction
let g:oldfiles = []
function! GetOldFiles()
    let files = g:oldfiles + v:oldfiles + map(getbufinfo({}), "v:val.name")
    let r = 'vim(rc)?$|^\~'
    let files = filter(s:unique(files), "!s:t(v:val, r)")
    let choice = s:fuzzy(files)
    if !s:in(g:oldfiles, choice)
        call add(g:oldfiles, choice)
    endif
    return choice
endfunction
function! App_browse_old_files()
    call s:open(GetOldFiles())
endfunction


function! s:gpt_python_maybe_import_openpdf()
  if search('openpdf()', 'nw')
    return
  endif
  call append(line('$'), 'from utils import openpdf')
  call append(line('$'), 'openpdf()')
endfunction

function! s:get_filetype_from_function_name(s)
    let s = a:s
    let  ref = {
        \'python': 'python',
        \'javascript': 'javascript',
        \'vim': 'vim',
        \'py': 'python',
        \'js': 'javascript',
    \}
    let r = 'python|javascript|vim|py|js'
    return ref[s:match(s, r)]
endfunction
function! s:register_language_exec_function()
    let name = s:get_binding_name()
    let shortkey = s:prompt('choose an abrev for: ' . name, s:abrev(name))
    let lang = s:get_filetype_from_function_name(name)
    let value = s:dict_setter('g:jspyref3', lang, 'execFunctions', shortkey, name)
    call s:append_vim(value)
endfunction
let g:jspyref3["python"]["execFunctions"]["io"] = "s:gpt_python_maybe_import_openpdf"


function! SmartDeleteQuotes()
    " Save the current cursor position
    let l:save_cursor = getpos(".")

    " Check for double quotes
    let l:double_quote = search('"', 'cnW')
    call setpos('.', l:save_cursor)

    " Check for single quotes
    let l:single_quote = search("'", 'cnW')
    call setpos('.', l:save_cursor)

    " Determine which quote is closer to the cursor
    if l:double_quote == 0 && l:single_quote == 0
        echo "No quotes found"
    elseif l:double_quote != 0 && (l:single_quote == 0 || l:double_quote < l:single_quote)
        normal! di"
    else
        normal! di'
    endif
endfunction

" Map the function to a key (for example, <leader>dq)
nnoremap da :call SmartDeleteQuotes()<CR>

function! GenerateOldFiles()

    " let files = v:oldfiles[0:8]
    " let file = s:choose(files)
    " call OpenBuffer4(file)
    " return

    let files = v:oldfiles[0:50]
	call OpenBuffer4('/home/kdog3682/2024/old_files.txt')
    %delete _
    call append('.', files)
endfunction
nnoremap e\ :call GenerateOldFiles()<CR>

" Function to save the current mapping of a key for a specific mode
function! Fff()
    " let a = maparg('n', a)
    " ec SaveCurrentMapping('n', 3)
endfunction

function! SaveCurrentMapping(mode, key)
    " Normalize key format
    let l:key = a:key
    let val = maparg(l:key, a:mode)
    " call input('val: ' . s:string(val))
    return val

    " Check and save the mapping for the specified mode
    if maparg(l:key, a:mode) != ''
        return 
    else
        return ''
    endif
endfunction

" Function to restore the original mapping
function! RestoreOriginalMapping(mode, key, savedMapping)
    let l:key = a:key
    let buffer = '<buffer> '
    if s:exists(a:savedMapping)
        execute a:mode . 'noremap ' buffer . l:key . ' ' . a:savedMapping
    else
        execute a:mode . 'unmap ' . buffer . l:key
    endif
endfunction

" Function to remap keys as specified and set up restoration trigger
function! SetupRemapAndRestore(mappings)
    let g:saved_mappings = {}
    let buffer = '<buffer> '

    for map in a:mappings
        let l:mode = map.mode == 'i' ? 'i' : 'n'
        let l:savedMapping = SaveCurrentMapping(l:mode, map.origKey)
        let g:saved_mappings[l:mode . map.origKey] = l:savedMapping
        let cmd = l:mode . 'noremap ' . buffer . map.origKey . ' ' . map.newCommand
        ec cmd
        execute cmd
    endfor

    nnoremap <buffer> <leader><Esc> :call RestoreAllMappings()<CR>
endfunction

" Function to restore all original mappings
function! RestoreAllMappings()
    ec 'restoring all mappings'
    for [key, mapping] in items(g:saved_mappings)
        let l:mode = key[0]
        let l:origKey = key[1:]
        call RestoreOriginalMapping(l:mode, l:origKey, mapping)
    endfor

    execute 'nunmap <buffer> <leader><Esc>'
    unlet g:saved_mappings
endfunction

function! TemporaryMapController()
    call SetupRemapAndRestore([
        \ {'mode': 'i', 'origKey': '<left>', 'newCommand': '<Esc>:normal! b<CR>i'},
        \ {'mode': 'i', 'origKey': '<right>', 'newCommand': '<Esc>:normal! w<CR>'},
        \ {'mode': 'i', 'origKey': '<delete>', 'newCommand': '<Esc>:normal! b<CR>'},
    \ ])
    ec g:saved_mappings
endfunction
function! s:file_prompt()
    let c = 0
    while c < 10
        let c += 1
        let a = s:prompt("choose a file or file key")
        if has_key(g:filedict, a)
            return g:filedict[a]
        elseif s:is_file(a)
            return a
        endif
    endwhile
endfunction
let g:python_base_functions = ["get_global_value","chalk","blue","_blue_colon","blue_colon","confirm","map","is_defined","is_array","test","is_string","is_integer","is_number","match","get_extension","has","has_extension","write_json","append","write","npath","tail","identity","normalize_file","trim","join","is_primitive","to_string","append_json","is_array_dictionary","is_object_array","read_json","everyf","pretty_print","head","dir_from_file","red","throw","timestamp","clear","is_file","is_function","templater","prompt","to_array","exists","filter","split","run_tests","to_argument","testf","is_object","is_nested_array","is_today","datestamp","announce","flat","get_sentences","is_url","get_constructor_name","file_prompt","debug","copy_last_downloaded_file_into_active_dir","is_dir","get_dir","path","most_recent_file","is_jsonable","append_self","empty","get_error_name","choose","is_private","view","openpdf","clip","stringify"]
let g:wpsnippets2["python"]["imp"] = "from utils import *"
let g:wpsnippets2["python"]["doc"] = "\"\"\"\n    $c\n\"\"\""

" let g:filedict['t
function! CompileTypstFromJavascript()
    if Node1000(CurrentFile())
        call s:typst('/home/kdog3682/2024-typst/src/clip.typ', 0)
    endif
endfunction
function! s:typst(file, open=0)
    let svg= 1
    let svg = 0
    let watch= 0

    let file = a:file
    let open = a:open || g:flags.open_typst_pdf 
    " let open = 0
    let out = '/home/kdog3682/2023/test.pdf'
    let shell = 'compile'
    let openStr= open ? '--open' : ''
    if svg
        let out = '/home/kdog3682/2023/test.svg'
    endif
    if watch
        let shell = 'watch'
    endif
    let prefix="typst"
    let template = '%s %s %s %s %s --root /'
    let cmd = printf(template, prefix, shell, file, out, openStr)
    let e = system(cmd)
    if s:t(e, 'error|panic')
        call s:blue(e)
    endif
endfunction


let g:typistdir = '/home/kdog3682/GITHUB/typst/'
let g:typistdir = '/home/kdog3682/GITHUB/typst-packages/'
let g:typistdir = '/home/kdog3682/GITHUB/typst-packages/packages/preview/'
silent call UnmapVim2()
" silent call UnmapPython()

function! UnmapVim3()
    try
        :silent! nunmap  [{
    catch
    endtry

    try
        :silent! nunmap  }]
    catch
    endtry

    try
        :silent! nunmap  [[
    catch
    endtry

    try
        :silent! nunmap  ]]
    catch
    endtry

    try
        :silent! nunmap  []
    catch
    endtry

    try
        :silent! nunmap  ][
    catch
    endtry

    try
        :silent! nunmap  ]"
    catch
    endtry

    try
        :silent! nunmap  ["
    catch
    endtry
endfunction


let g:loaded_python_provider = 0
let g:loaded_sql_provider = 0
let g:no_python_maps = 1
let g:no_vim_maps = 1


" execute '!sudo chmod +w /usr/share/vim/vim82/ftplugin/sql.vim'
" /home/kdog3682/.vim/after/ftplugin/sql.vim
" /home/kdog3682/.vim/after/ftplugin/python.vim
" /home/kdog3682/.vim/after/ftplugin/typst.vim
" /home/kdog3682/.vim/after/ftplugin/javascript.vim
" /home/kdog3682/2024/quickstart/content/posts/first.md
let g:dirdict["usr"] = "/usr/local/bin"
let g:filedict["bashrc"] = '/home/kdog3682/.bashrc'
let g:filedict["c2"] = "/home/kdog3682/2023/clip2.js"


function! DeleteMatchingLines(pattern)
    let ref = {
        \'short': '^.{,9}$',
        \'hist': '^[a-z]{1,3}( \S{1,9})?$',
    \}
    let pattern = ref[a:pattern]
    execute 'g/\v' . pattern . '/d'
endfunction

let g:execRef2["dml"] = "DeleteMatchingLines"

let g:execRef2["ech"] = "EnableCommentHighlighting"
let g:filedict["gdoc"] = "/home/kdog3682/2024/abc.gdoc"
let g:wpsnippets2["python"]["pp"] = "from pprint import pprint"

function! FastCommandExplorer()
    " let buffer_names = s:get_active_buffers('')
    " return s:print(buffer_names)
    let buffers = getbufinfo({})
endfunction

function! s:move_file(a, b)
    let a = a:a
    let b = a:b
    let s = printf('!mv "%s" "%s"', a, b)
    ec printf('moving file: %s to %s', a, b)
    execute s
endfunction

function! s:app_rename_file_from_line()
    "'asdfasdf.py'
    let file = s:get_file_from_line()
    let head = s:head(file)
    let e = s:get_extension(file)
    " let newName = s:prompt('new file name?')
    let newName = 'temp'
    let name = s:add_extension(newName, e)
    let dest = s:join_path(head, name)
    call s:move_file(file, dest)
    call s:replace_current_line(file, dest)
endfunction
call add(g:normalCommands, "s:app_rename_file_from_line")
function! s:get_set_line(fn)
   let i = line('.')
   let [spaces, line] = GetSpacesAndLine(i)
   let value = function(a:fn)(line)
   if value == line
       call setline(i, value)
       return 
   endif
   if s:exists(value)
       call setline(i, spaces . value)
   endif
endfunction
function! s:join_path(...)
    return join(map(copy(a:000), "s:sub(v:val, '/$', '')"), '/')
endfunction
function! s:get_extension(file)
    let file = a:file
	return GetExtension(file)
endfunction




function! Foooooooooo()
    call s:replace_current_line('aa', 'aa')
endfunction

function! WrapCurrentWordWithBackticks()
    " Save the current cursor position
    let l:save_cursor = getpos(".")

    " Go to the start of the current word
    normal! b

    " Enter visual mode and select the word
    normal! viw

    " Yank (copy) the word, and then go back to the original position
    normal! y
    call setpos('.', l:save_cursor)

    " Paste the yanked word with backticks
    normal! "_diw
    execute "normal! i`" . @0 . "`"
endfunction

" Map the function to a key combination, e.g., <Leader>w
nnoremap q` :call WrapCurrentWordWithBackticks()<CR>

let s:syntax_highlight_count = 0
function! s:highlight_syntax(name, regex, color)
    let name = a:name
    let regex = a:regex
    let color = a:color

    let font = color == "bold" ? "cterm" : "ctermfg"
    let cmd = printf('highlight %s %s=%s', name, font, color)
    ec cmd
    execute cmd
    call matchadd(name, '\v' . regex)
endfunction
function! EnableLanguageHighlighting()
    let regexes = s:jspy('syntax_highlighting_regexes')
    let color_scheme = {
        \'function': 'bold',
        \'method': 'bold',
        \'comment': 'blue',
    \}
    for [k,v] in items(color_scheme)
        let regex = get(regexes, k)
        if s:exists(regex)
            let name = k
            let color = v
            call s:highlight_syntax(name, regex, color)
        endif
    endfor
endfunction





let g:jspyref3["python"]["syntax_highlighting_regexes"] = {
  \"function": '^ *def\s+\w+:',
  \"method": '^ *def\s+\(self.*',
  \"class": '^class\s+.+',
  \"comment": '^ *#.*',
\}

let g:jspyref3["javascript"]["syntax_highlighting_regexes"] = {
  \"function": '^ *(async )?function\s+\w+.{-}\ze\{',
  \"class": '^class\s+.{-}\ze\{',
  \"comment": '^ *//.*',
  \"method": '^ *(async )?\w+\(.{-}\{ *$',
\}

let g:jspyref3["typst"] = {}
let g:jspyref3["typst"]["prefix"] = 'let '
let g:jspyref3["typst"]["regexes"] = {
  \"comment": '^ *//.*|^/\*.+',
  \"hash": '^ *#\w.*',
\}


let g:filedict["toc"] = "/home/kdog3682/2024/toc.txt"


function! s:string_line_getter(s)
    return map(split(a:s, '\n'), "trim(v:val)")
endfunction
function! SwapInoremapKeys()

    inoremap <buffer> $1 $2 
    inoremap <buffer> $2 $1

    let lines = s:string_line_getter(template)
    return lines
endfunction

function! s:get_function_name_from_word_or_block()
    
    let cw = expand('<cword>')
    let s = getline('.')
    if !s:t(s, cw . '\(')
        return s:get_binding_name()
    endif

    if s:t(s, 's:' . cw . '\(')
        return 's:' . cw
    endif
    return cw
endfunction

function RegisterFunction()
    let date = s:datestamp2()
    let file = CurrentFile()
    let fn = s:get_function_name_from_word_or_block()
    let payload = {
        \'date': date,
        \'file': file,
        \'function': fn,
    \}
    let str = s:string(payload)
    call s:appendfile('functions.txt', str)

endfunction

autocmd! BufNewFile,BufRead *.stylus set filetype=stylus
autocmd! BufNewFile,BufRead *.log set filetype=log
autocmd! BufNewFile,BufRead *.math set filetype=math
autocmd! BufNewFile,BufRead *.math.raw set filetype=math
autocmd! BufNewFile,BufRead *.txf set filetype=txflow

function! s:get_prev_buffer_name()
    return fnamemodify(bufname('#'), ':p')
endfunction

function! LogFileTypeFunction_InoreabExpr_33()
    return s:datestamp2() . ' ' . s:get_prev_buffer_name()
endfunction

let g:execRef2["rf"] = "RegisterFunction"


function! FTEF_Typst_CommentSlash()
    if col('.') == 1
        return '// '
    endif
    if len(trim(getline('.'))) == 0
        return '// '
    endif
    return '/'
endfunction
let g:filedict["st"] = "/home/kdog3682/2024/snippets.typ"
function! FTEF_Typst_WordWrap(a, b)
    let a = a:a
    let b = a:b
    execute 'normal! bi' . a
    execute 'normal! ea' . b
    return 
    let l:save_cursor = getpos(".")
    normal! b
    normal! viw
    normal! y
    call setpos('.', l:save_cursor)
    normal! "_diw
    execute "normal! i"  . a . @0 . b
endfunction


let maplocalleader = ","


function! Foobarwf()
    let f = sort(filter(s:get_function_names(), 'len(v:val)' > 3))
    call s:writefile('temp.txt', f)
endfunction

function! FTEF_Typst_NumberOrSymbol(a, b)
    let a = a:a
    let b = a:b

    if pumvisible() 
        let down = repeat(g:keyboard.down, a - 1)
        return down . g:keyboard.enter
    endif

    let s = getline('.')
    let letter_before = s[col('.') - 2]
    if letter_before == "$" && b == "4"
        if s[col('.') - 1] == '$'
            return '4'
        endif
        return "$\<left>" 
    endif

    if letter_before == "\\"
        return "\<BS>" . b
    endif

    if letter_before == b[0]
        return "\<BS>" . a
    endif
    return b
endfunction

function! FTEF_Typst_SmartEqual()
    let s = trim(getline('.'))
    let [a, b, c, d, e] = ABCDECursor()
    let prefix = 'let '

    if s:t(s, '^ *\w+ *$') && !s:t(s, 'return')
        return " = \<C-O>I" . prefix . "\<C-O>A"
    elseif s:t(s, '^ *' . prefix . '\w+ *\= *$')
        return "\<C-O>I " . g:keyboard.esc . 'v/ ' . g:keyboard.left . g:keyboard.enter . "d " . "\<C-O>A"
    elseif s:t(b, '[?<>!=]')
        return '= '
    elseif s:t(a, '[?<>!=]') && b == ' '
        return g:keyboard.bs . '= '
    elseif s:t(s, '^(if|elif)')
        return ' == '
    elseif s:t(b, '[a-z]') && !s:t(s, 'let|return')
        " start of line: needs to append prefix
        return " = \<C-O>I" . prefix . "\<C-O>A"
    else
        return '='
    endif
endfunction

let g:typstCompletionItems = [
    \{ 'a': '^\s*$', 'value': "    "},
    \{ 'a': '[a-z]+$', 'fn': 'GetTypstWords2'},
\]
let g:jspyref3["typst"]["qqqCompletionItems"] = g:typstCompletionItems
let g:jspyref3["typst"]["localHighFrequencyWords"] = ['import abc', 'import def<left>']
let g:jspyref3["typst"]["node2"] = '!clear; typst query % "<note>"'
let g:jspyref3["typst"]["node2"] = 'TypstNoteQuery'
let g:jspyref3["typst"]["node2"] = '!clear; typst query % "<note>"'
function! VABlockToBrowser(state)
    call writefile(a:state.lines, g:tempfile)
    call SystemExec("run.py", "ofile", g:tempfile)
    return
    call XdgOpen(g:tempfile)
endfunction

function! ToggleWrap()
    setlocal wrap
    if exists('b:local_wrap')
        if b:local_wrap
            let b:local_wrap = 1
        else
            let b:local_wrap = 0
        endif
    else
        let b:local_wrap = 1
    endif
    if b:local_wrap
        setlocal wrap
    else
        setlocal nowrap
    endif
endfunction
let g:execRef2["wrap"] = "ToggleWrap"

function! TodaysWork()
    let buffers = s:get_buffers()
    let items = [s:datestamp2()] + buffers + [s:hr(70)]
    call s:appendfile('todays_work.txt', items)
endfunction
let g:execRef2["tdw"] = "TodaysWork"


function! FTEF_Typst_Dash()
    let letter_before = getline('.')[col('.') - 2]
    if s:t(letter_before, '\d')
        return ' - '
    endif
    if letter_before == '-'
        return "\<BS>_"
    endif
    return '-'
endfunction

function! FTEF_Typst_MathMode(key)
    "test: a
    let key = a:key
    let text = getline('.')
    let c = col('.')
    let s = trim(text)
    let a = s[0]
    let b = s[-1]
    let is_math_mode = s[0] == '$'
    if !is_math_mode
        return key
    endif
    let ref = {
        \'p': '+ ',
    \}
    let ch = ref[key]
    let space_before = text[c - 2] == ' '
    if space_before
        return ch 
    endif
    return ' ' . ch
    
endfunction
function! TypstNoteQuery()
    let text = join(s:getlines('w'), '')
    if !s:t(text, '\<note\>')
        execute 'normal! A<note>'
    endif
    w
    execute '!clear; typst query % "<note>"'
endfunction
let g:filedict["tdw"] = "/home/kdog3682/2024/todays_work.txt"
function! s:jspy_normal_runner(s)
    let ref = s:jspy2024(a:s)
    if s:llvf(ref)
        call function(ref)()
        return 1
    endif
    if s:exists(ref)
        execute ref
        return 1
    endif
    return 0
endfunction
function! s:get_current_buffer_name()
    return fnamemodify(bufname('%'), ':p')
endfunction



function! TypstNormalQW()
    let s = s:getlinestate(1)
    call s:touch(s.index + 1, s:getindent(s.index) + 4, -1)
endfunction
function! TypstNormalQE()
    let s = s:getlinestate(1)
    call s:touch(s.index, s:getindent(s.index) - 2)
endfunction

function! FTEF_Typst_SmartQuote()
    let double_quote = '"'
    let single_quote = ''''
    let [a, b, c, d, e] = ABCDECursor()
    " return s:print([a, b, c, d, e])
    if b == double_quote && c == double_quote
        return g:keyboard.right . g:keyboard.bs . g:keyboard.bs . single_quote
    endif
    return double_quote . double_quote . g:keyboard.left
endfunction
let g:jspyref3["typst"]["commentPrefix"] = "//"
function! TypstResolve(m)
    let m = a:m
    if Test(m, '^/') && IsFile(m)
        return m
    endif
    let a = fnamemodify(expand('%'), ':h')
    while s:t(m, '^\.\./')
      let m = s:sub(m, '^../', '', '')
      let a = s:sub(a, '[a-z0-9-]+/?$', '', '')
    endwhile
    return a . '/' . m
endfunction
function! TypstMove()
    let up = s:fli('^ *#?let.{-}\{ *$', '.', -1, 100, 0, 1)
    let spaces = s:match(getline(up), '^ *')
    if IsArray(spaces)
        let spaces = ''
    endif
    " call input('spaces: ' . s:string(spaces))
    " call s:assert(spaces, 's:is_string')
    let down = s:fli('^' . spaces . '\}', '.', 1, 100, 0, 1)
    let i = [up, down]
    let lines = s:getlines(i)
    let lines = map(lines, "s:replace(v:val, '^' . spaces, '')")
    let lines[0] = s:replace(lines[0], '^#?', '#')
    call add(lines, '')
    call s:append_file('util.typ', lines)
endfunction
function! s:join(s)
    let s = a:s
    return join(s, "\n")
endfunction
function! s:append_file(a, b)
    let a = a:a
    let b = a:b
    call s:appendfile(a, b)
endfunction
function! Seeee(k)
    "test: k
    let k = a:k
    let val = get(g:visualactiondict, k) 
    return s:print(val)
endfunction
function! TypstShuntController()
    let lines = getline('.')
    call s:append_file('util.typ', lines)
endfunction
let g:wpsnippets2["typst"] = {}
let g:wpsnippets2["typst"]["obj"] = "MakeTypstObject"

function! MakeTypstObject(s)
    let chs = SplitSingles(a:s)
endfunction

iab nob nnoremap <buffer>
let g:filedict["ut"] = "/home/kdog3682/2024/util.typ"

set iskeyword+=_

function! TypstWatch(file)
    " not in use
    let file = a:file
    let out = '/home/kdog3682/2024-typst/test.pdf'
    call system(template)
endfunction
let g:linkedBufferGroups["fs-watch.js"] = "fs-watch.html"
let g:linkedBufferGroups["fs-watch.html"] = "fs-watch.js"

function! s:register_normal_openbuffer_file()
    let t = s:get_map_template("normal_open_file")
    let t = printf(t, s:prompt("alias key for this file? [you should start the key with the letter e]"), s:get_current_buffer_name())
    call s:append_and_execute(t)
endfunction
call add(g:normalCommands, "s:register_normal_openbuffer_file")
nnoremap ea :call OpenBuffer4('/home/kdog3682/2024/abc.gdoc')<CR>


function! SimpleHighlight(regex, color)
    let regex = a:regex
    let color = a:color
    call s:highlight_syntax("SimpleHighlight", regex, color)
endfunction

function! EnableSimpleLanguageHighlighting()
    call s:highlight_syntax("simple_comment", "^ */[/*].*", "gray")
endfunction
let g:execRef2["esh"] = "EnableSimpleLanguageHighlighting"

" autocmd! FileType python highlight Comment ctermfg=Green guifg=Green

nnoremap eey :call OpenBuffer4('/home/kdog3682/PYTHON/examples.py')<CR>
let g:linkedBufferGroups["SectionExecutor.py"] = "SectionExecutorApps.py"
let g:linkedBufferGroups["SectionExecutorApps.py"] = "SectionExecutor.py"

nnoremap eebm :call OpenBuffer4('/home/kdog3682/2024/bookmarks.txt')<CR>


nnoremap gp :call GoPreviewDirectory()<CR>
function! GoPreviewDirectory()
  " creates a tree like directory structure to see the folder contents
  ec 'in progress'
endfunction

function! ToggleGlobalFlag()
    let dictKeys = keys(g:flags)
    let key = s:fuzzy(dictKeys)
    let val = s:opposite(g:flags[key])
    let g:flags[key] = val
    ec printf('new value for %s: %s', key, val)
endfunction
call add(g:normalCommands, "ToggleGlobalFlag")

function! ToggleTypst()
    " let dictKeys = keys(g:flags)
    " let key = s:fuzzy(dictKeys)
    let key = 'open_typst_pdf'
    let key = 'txflow_equal_sign'
    
    let val = s:opposite(g:config[key])
    let g:config[key] = val
    ec printf('new value for %s: %s', key, val)
endfunction


function! EvalAndAppendFile(s)
    call s:appendfile(".", s:system_cmd(s:templater2(a:s)))
endfunction

function! EvalAndEcho(s)
    "test: 'a'
    " let s = a:s
    " ec systemlist(s)
    let a = getcwd()
    let b = system('2024')
    let c = getcwd()
    return [a, b, c]

endfunction

" 01-09-2024 
let g:pythonsitepackagesdir = '/home/kdog3682/.local/lib/python3.9/site-packages/'
let g:execRef2["tgf"] = "ToggleGlobalFlag"

let g:line_edit_invivo_items = [
    \{"regex": '^replace +(\S+) (.+)', "fn": "GlobalStringReplace", "desc": "escapes the regex and replaces the occurence through the entire file. if it a word, we do boundary on it", 'key': 'rep'},
    \{"regex": '^register +(\S+) (.+)', 'fn': 'RegisterSystemExecRef', 'key': 'rep'},
    \{"regex": '^ea +(.+)', "fn": "EvalAndAppendFile", "desc": "eval the line ... append results to bottom of page", 'key': 'ea'},
    \{"regex": '^e +(.+)', "fn": "EvalAndEcho", "desc": "eval the line ... append results to bottom of page", 'key': 'e'},
\]

function! JumpToFunctionByKey(key, ...)
    let key = a:key
    let objects = [g:execRef2]
    let fallbackFiles = a:0 > 0 ? a:1 : []

    if has_key(g:gfgfdict, key)
        let [file, fnName, getMethod] = g:gfgfdict[key]
        call s:open(file)
        call SearchFunctionInCurrentFile(fnName)
        return 
    endif

    " Search in the provided objects
    let functionName = s:FindFunctionName(key, objects)
    if s:exists(functionName)
        if SearchFunctionInCurrentFile(functionName)
            return
        endif
        for file in fallbackFiles
            execute 'edit' file
            if SearchFunctionInCurrentFile(functionName)
                return
            endif
        endfor
    else
        call s:red('no function with key %s in provided list of objects or arrays', a:key)
    endif

endfunction

function! s:FindFunctionName(key, objects)
    for object in a:objects
        if s:is_object(object)
            if has_key(object, a:key)
                let base = object[a:key]
                if IsObject(base)
                    return base['fn']
                elseif IsString(base)
                    if s:llvf(base)
                        return base
                    else
                        let base = s:get_function_from_str(base)
                        if s:exists(base)
                            return base
                        endif
                        return 
                    endif
                    return base
                endif
            endif
        elseif s:is_array(object)
            for item in object
                if has_key(item, 'key') && item['key'] == a:key
                    return item['fn']
                endif
            endfor
        endif
    endfor
    return ''
endfunction

function! SearchFunctionInCurrentFile(functionName)
    let searchPattern = '\<function!\?\s\+' . a:functionName . '\>'
    if search(searchPattern) > 0
        return 1
    endif
    return 0
endfunction

let g:abc = {
    \"regex": {"fn": "GlobalStringReplace", "desc": "escapes the regex and replaces the occurence through the entire file. if it a word, we do boundary on it", 'key': 'rep'}
\}
function! s:get_function_from_str(s)
	return s:findall(s, '\w+\ze\(')[-1]
endfunction
let g:gfgfdict['gf'] = ['/home/kdog3682/.vimrc', 'GoFile', 0]


" 01-09-2024 top

let g:CompleteOnKeyStrokeActive = 0

function! ToggleCompleteOnKeyStroke()
    if g:CompleteOnKeyStrokeActive
        let g:CompleteOnKeyStrokeActive = 0
        unmap zz
    else
        let g:CompleteOnKeyStrokeActive = 1
        inoremap zz <C-O>:call CompleteOnKeyStroke()<CR>
    endif
endfunction





function! s:build_language_specific_completion_items()
    if exists('b:bindings')
        return b:bindings
    endif
    return []
    let ref = a:ref
    let cstate = s:get_context_state(ref.contextual.cstate)
    let store = []
    if s:exists(cstate)
        for item in ref.contextual.items
            let match = s:match_context_state(item, cstate)
            if match
                call extend(store, match.items)
                break
            endif
        endfor
    endif

    call extend(store, b:bindings)
    call extend(store, ref.language_words)
    return store
endfunction


function! TypstCompletion(findstart, base)
    if a:findstart
        " Find the start position of the word to complete
        let line = getline('.')
        let start = col('.') - 1
        while start > 0 && line[start - 1] =~ '\a'
            let start -= 1
        endwhile
        let s:typst_completion_start = start
        
        return start
    else
        try
            let items = GetTypstCompletionItems(a:base)
            " call input('items: ' . s:string(items))
            return items
        catch
            let error = v:exception
            return [error]
        endtry
    endif
endfunction

function! TypstTriggerCompletion()
    if &filetype != "typst"
        return 
    endif
    " Trigger autocompletion if the last typed character matches a specific pattern
    let last_char = strpart(getline('.'), col('.') - 2, 1)
    if last_char =~ '\v\a|\.'
        " Trigger the custom completion function
        call feedkeys("\<C-x>\<C-u>", 'n')
    endif
endfunction

nnoremap eest :call OpenBuffer4('/home/kdog3682/2024-typst/src/snippets.typ')<CR>


function! GetFileType()
    ec &filetype
endfunction
let g:execRef2["gft"] = "GetFileType"

function! TypstUpdateBindings()
    let r = 'let ([\w-]+)\('
    let bindings = s:unique(s:findall(s:get_page_text(), r))
    let b:bindings = bindings
endfunction
autocmd! BufWritePost  *.typ call TypstUpdateBindings()
nnoremap eet2 :call OpenBuffer4('/home/kdog3682/2024/temp.gdoc')<CR>
inoreab ib inoremap <buffer>
let g:jspyref3['python']['ll'] = 'print("$1", $1)'
let g:jspyref3['python']['lp'] = 'pprint($1)'

let g:jspyref3['javascript']['lp'] = 'pprint($1)'
let g:flags = {}

let g:flags['open_typst_pdf'] = 0
let g:flags['use_mypy_flag'] = 0
let g:flags['use_system_flag'] = 0
let g:flags['use_git_flag'] = 0
function! s:opposite(x)
    let x = a:x
    return Opposite(x)
endfunction

function! Pycharm()
    let ref = g:jspyref3[&filetype]['pycharm']
    let fns = 
    if !exists('b:pycharm_dependency_bindings')
        let lines = getline(1, 10)
        let m = s:matchfilter(lines, ref.import_re)
        let dependency_bindings = {}
        for item in m
            let file = ''
            if IsArray(item)
                let file = item[0]
            else
                let file = item
            endif
            let file = TypstResolve(file)
            let key = s:remove_extension(s:tail(file))
            let dependency_bindings[key] = s:get_typst_items(file)
        endfor
        let b:pycharm_dependency_bindings = dependency_bindings
    endif
endfunction
let g:jspyref3["python"]["pycharm_import_re"] = ""
let g:jspyref3["javascript"]["pycharm_import_re"] = ""
let g:jspyref3["typst"]["pycharm"] = {'import_re': '#?import "(.{-})\\.typ"%( *: *(\\S.+))?'}
let g:jspyref3["vim"]["pycharm"] = {
    \ 'import_re': '#?import "(.{-})\.typ"%( *: *(\S.+))?',
\}
let g:jspyref3['javascript']['ll'] = 'console.log("$1", $1)'

function! BrowseTocFiles()
    " let g:toc_key = 'typst-packages'
    " let file = printf('/home/kdog3682/2024/%s.toc')
    let file = '/home/kdog3682/2024/typst-packages.toc'
    call OpenBuffer3(file)
endfunction
let g:execRef2["toc"] = "BrowseTocFiles"
nnoremap eec2 :call OpenBuffer4('/home/kdog3682/2023/clip2.js')<CR>
nnoremap een2 :call OpenBuffer4('/home/kdog3682/2023/next2.js')<CR>

"/home/kdog3682/GITHUB/typst-packages/packages/preview/cetz/0.1.2/src/lib/plot.typ",

function! Sdhfjk()
    call OpenBuffer3('/home/kdog3682/2024/snippets.typ')
    startinsert!
endfunction

let s:child_completion_items = [
                \ {'word': 'bobber', 'abbr': 'bob', 'menu': 'This is an example', 'infoo': 'Detailed information about example', 'kind': 'function'},
                \ {'word': 'fobber', 'abbr': 'fob', 'menu': 'This is a sample', 'infoo': 'Detailed information about sample', 'kind': 'variable'},
                \ ]

let s:child_completion_items2 = [
                \ {'word': 'bobber22222', 'abbr': 'bob', 'menu': 'This is an example', 'infoo': 'Detailed information about example', 'kind': 'function'},
                \ {'word': 'fobbe22222r', 'abbr': 'fob', 'menu': 'This is a sample', 'infoo': 'Detailed information about sample', 'kind': 'variable'},
                \ ]

let s:completion_items = [
                \ {'word': 'aaexample', 'abbr': 'exmpl', 'menu': 'This is an example', 'infoo': 'Detailed information about example', 'kind': 'function'},
                \ {'word': 'sample', 'abbr': 'smpl', 'menu': 'This is a sample', 'infoo': 'Detailed information about sample', 'kind': 'variable'},
                \ {'word': 'sample2', 'abbr': 'smpl2', 'menu': 'This is a sample', 'infoo': 'Detailed information about sample', 'kind': 'variable'},
                \ {'word': 'sample3', 'abbr': 'smpl3', 'menu': 'This is a sample', 'infoo': 'Detailed information about sample', 'kind': 'variable'},
                \ {'word': 'foo', 'abbr': 'tst', 'menu': 'This is a test', 'infoo': 'Detailed information about test', 'kind': 'method'},
                \ {'word': 'bar', 'abbr': 'ts', 'menu': 'This is a test', 'infoo': 'Detailed information about test', 'kind': 'method'},
                \ ]

function! s:map_filter(items, fnkey)
    let items = a:items
    let fnkey = a:fnkey
    let store = []
    let s:_f = function(fnkey)
    for item in items
        let m = s:_f(item)
        if s:exists(m)
            call add(store, m)
        endif
    endfor
    return store
    
endfunction
function! GetTypstCompletionItems(base)
    "test: pl
    let r = '^' . a:base
    return s:regexfilter2(s:months, a:base)

    let l:Wrap = {s,type -> ({'word': s, 'kind': type})}
    let package = s:json('/home/kdog3682/2024/clip2.js', 'typst_child_package')

    let before = s:typst_completion_start - 1
    let s = getline('.')
    let c = s[before]
    if c == '.'
        let substring = strpart(s, 0, before)
        let field = s:match(substring, '\w+$')
        if s:exists(field)
            let child_package = field == package.key ? package : s:find(package.children, {x -> x.key == field})
            if s:exists(child_package)
                let store = []
                for child in child_package.contents
                    if empty(a:base) || s:t(child.name, r)
                        call add(store, l:Wrap(child.name, 'method'))
                    endif
                endfor
                return store
            else
                call input('field: ' . s:string(field))
            endif
        endif
        return []
    endif

    if empty(a:base)
        return []
    endif

    let base = []

    for child in package.contents
        if s:t(child.name, r)
            call add(base, l:Wrap(child.name, 'func'))
        endif
    endfor
    for child in package.children
        if s:t(child.key, r)
            call add(base, l:Wrap(child.key, 'child'))
        endif
    endfor

    let keywords = [ "styles", "query", "locate", ]

    for item in keywords
        if s:t(item, r)
            call add(base, l:Wrap(item, 'keyword'))
        endif
    endfor
    return base
endfunction

let g:execRef2["dqt"] = "DefineQTFunction"
let g:vimCurrentTestFunction = "Sdhfjk"

function! FindPrecedingFields(str, loc)
    " Extract the substring up to the given index
    let substring = strpart(a:str, 0, a:loc)

    " Initialize an empty list to store fields
    let fields = []
    let field = ''
    let i = len(substring) - 1

    " Traverse the substring backwards
    while i >= 0
        " Check if the current character is a dot or a space
        if substring[i] == '.' || substring[i] == ' '
            " Add the field to the list if it's not empty and break on space
            if len(field) > 0
                call add(fields, field)
                let field = ''
                if substring[i] == ' '
                    break
                endif
            endif
        else
            " Prepend the character to the current field
            let field = substring[i] . field
        endif
        let i -= 1
    endwhile

    if len(field) > 0
        call add(fields, field)
    endif

    " Return the list of fields in reverse order since we collected them backwards
    return reverse(fields)
endfunction


function! s:json(file, ...)
    let file = a:file
    let cache_key = a:0 >= 1 ? a:1 : ''
    if s:exists(cache_key)
        if has_key(g:cache, cache_key)
            " call input(string('returning cached value'))
            return g:cache[cache_key]
        else
            let v = json_decode(s:joinlines(readfile(file)))
            let g:cache[cache_key] = v
            return v
        endif
    endif
    return json_decode(s:joinlines(readfile(file)))
endfunction
        " let fields = FindPrecedingFields(s, before)


function! TypstHelp()
    
endfunction

function! ChangeQuotes(s)
    let s = a:s
    return s:sub(s, '''', '`')
endfunction
function! ReplaceStuff(s)
    return s:sub(a:s, '^ *\/+ *', '')
endfunction
let g:execRef2["le.cq"] = "ChangeQuotes"
let g:execRef2["le.rep"] = "ReplaceStuff"
function! LineEditWrapper(fnKey, ...)
    let fnKey = a:fnKey
    call s:get_set_line(fnKey)
endfunction

function! EvalBelowTheLine()
    let text = s:join(s:getlines('belowCursor'))
    ec text
    call eval(text)
    " execute text
    ec g:table_ref
endfunction
let g:execRef2["ebl"] = "EvalBelowTheLine"



" Dictionary mapping words to their replacements
let g:table_ref = {'table': {'word1': 'replacement1', 'word2': 'replacement2'}}

" List of possible completions after the replacement
let g:completion_options = ['option1', 'option2', 'option3']

function! FindAboveCallable()
    let m = s:sprawl_match('\w+\ze\(')
    return m
endfunction
function! CustomColonCommand()
    let line_content = getline('.')
    let table_key = FindAboveCallable()
    if !has_key(g:table_ref, table_key)
        return ''
    endif
    let table_ref = g:table_ref[table_key]
    let col = col('.') - 1
    let line_part = strpart(line_content, 0, col)
    let words = matchlist(line_part, '\v(\w+)$')
    if len(words) == 0
        return
    endif
    let preceding_word = words[1]

    if has_key(table_ref, preceding_word)
        let replacement = table_ref[preceding_word] . ': '
        let completion = CRExpr2(g:completion_options, 'comma')
        return s:backspaces(preceding_word) . replacement . completion
    endif
endfunction
function! CRExpr2(completion_items, key)
    let s:key = a:key
    function! s:inner(i, s)
        let s = a:s
        let value = s
        if s:key == 'comma'
            let value .= ','
        endif
        return {'word': value, 'abbr': s, 'kind': s:key . '  ' . (a:i + 1)}
    endfunction

    let s:completion_items = map(a:completion_items, function('s:inner'))
    function! TypstCompletionListFunction()
      call complete(col('.'), s:completion_items)
      return ''
    endfunction
    return CRExpr('TypstCompletionListFunction')
endfunction

function! s:get_typst_line_state()
    let i = line('.')
    let s = getline(i)
    let t = trim(s)
    let col = col('.') - 1
    let line_part = strpart(s, 0, col)
    let after = strpart(s, col) 
    if line_part == ''
        return {
            \ 'commented': 0,
            \ 'empty': 1,
        \}
    endif
    let front = s:match(line_part, '\S+$')
    // the part before the cursor (may include symbols)
    let colon = Test(front, ':$')
    let dot = Test(front, '\.$')
    let word = s:match(line_part, '\w+$')
    // just the word infront the cursor
    let spaces = s:getspaces(s)
    let indent = len(spaces)
    let sol = s:t(s, '^\S')

    let commented = s:t(t, '^//')
    " test to see if there are starting spaces

    let is_edited = len(trim(after)) > 0
    " test to see if there == anything after the cursor

    let is_fresh = s:t(s, '^ *\S+ *$')
    " the lines does not have any spaces in it

    let data =  {
        \ 'sol': sol,
        \ 'commented': commented,
        \ 'col': col,
        \ 'front': front,
        \ 'indent': indent,
        \ 'word': word,
        \ 'colon': colon,
        \ 'dot': dot,
        \ 'empty': 1,
        \ 'is_fresh': is_fresh,
        \ 'is_edited': is_edited,
    \}
    call input(string(data))
    return data
endfunction
let g:jspyref3['vim']['ll'] = 'ec ["$1", $1]'
let g:jspyref3['vim']['lr'] = 'return ["$1", $1]'
let g:jspyref3['python']['lpr'] = 'prompt("$1", $1)'
let g:jspyref3['javascript']['libraryFile'] = '/home/kdog3682/2023/utils.js'
let g:jspyref3['javascript']['lt'] = "throw $1"

nnoremap ll :call EchoTemplate('ll')<CR>
nnoremap lp :call EchoTemplate('lp')<CR>
nnoremap lt :call EchoTemplate('lt')<CR>
nnoremap lpr :call EchoTemplate('lpr')<CR>
nnoremap lr :call EchoTemplate('lr')<CR>



function! QQQTypstCompletion()
    " not active this function
    " let state = s:get_typst_line_state()
    " if state.is_fresh
        " if state.word in g:typst_package.singletons
            " return function(singletons[state.word])()
        " endif
    " endif
    " if state.colon
        " let table_key = FindAboveCallable()
    " endif
endfunction
" autocmd! InsertCharPre *.typ silent call TypstTriggerCompletion()



function! GetDashIndexes()
    let start = s:fli('^--|^const \w+ \= \`', '.', -1, 100, 0) + 1
    let end = s:fli('^\`|^---', '.', 1, 100, 0) - 1
    return [start, end]
endfunction

function! GetLazyObjectIndexes()
    let start = s:fli('^\S', '.', -1, 100, 0)
    let end = s:fli('^\S', '.', 1, 100, 0)
    if end == line('$')
        return [start, end]
    endif
    let end = s:fli('\S', end, -1, 100, 0)
    return [start, end]
endfunction
let g:gfgfdict['jpc'] = ['/home/kdog3682/.vimrc', 'JPCreateFunctionBlockNormal', 0]


function! RegisterFunctionViaStringInput(input)
    " Define the reference dictionary
    let ref = {'n': 'nnoremap', 'i': 'inoremap', 's': 'silent', 'b': 'buffer', 'e': 'expr'}

    " Split the input
    let [a, b] = SplitOnce(a:input, '[. ]')
    let [c, d] = SplitOnce(b, ' ')

    if empty(d)
        let d = s:get_binding_name()
    endif
    " Process the keys
    let raw = split(a, '\zs')
    let keys = []
    for x in keys(ref)
        if index(raw, x) >= 0
            call add(keys, get(ref, x))
        endif
    endfor
    if len(keys) == 0 || keys[0] != 'nnoremap'
        call insert(keys, 'inoremap')
    endif

    " Map the keys and check for 'expr'
    let mapped_keys = map(copy(keys), {i, v -> i == 0 ? v : '<'.v.'>'})
    let expr = index(keys, 'expr') >= 0
    let prefix = join(mapped_keys, ' ')
    let inoremap = index(keys, 'inoremap') >= 0

    " Process the key mapping
    let key = substitute(c, ',', '<leader>', '')
    let s = prefix . ' ' . key . ' '

    " Append command
    if inoremap
        let s .= '<esc>'
    endif
    if !expr
        let s .= ':call '
    endif
    if d !~ '('
        let s .= d . '()'
    endif
    if !expr
        let s .= '<cr>'
    endif

    call s:append_and_execute(s)
    return s
endfunction
let g:execRef2["rs"] = "RegisterFunctionViaStringInput"
nnoremap <leader>g :call JumpToFunctionByKey('')<left><left>

" Function to convert snake_case to PascalCase
function! ConvertSnakeToPascal(snake_str)
    let words = split(a:snake_str, '_')
    return join(map(words, {i, v -> toupper(v[0]) . v[1:]}), '')
endfunction

" Function to convert all snake_case in the file to PascalCase if filetype is JavaScript
function! ConvertFileToPascal()
    " Check if filetype is JavaScript
    if &filetype != 'javascript' && &filetype != 'javascriptreact'
        echo "Not a JavaScript file."
        return
    endif

    " Process each line
    let lineNumber = 1
    while lineNumber <= line('$')
        let lineContent = getline(lineNumber)
        let modifiedLine = substitute(lineContent, '\<\l\+\(_\l\+\)\+', '\=ConvertSnakeToPascal(submatch(0))', 'g')
        call setline(lineNumber, modifiedLine)
        let lineNumber += 1
    endwhile
endfunction

" Command to convert current file
let g:execRef2["cc"] = "ConvertFileToPascal"
function! QUp()
    let s = s:getlinestate(1)
    let i = s:fli(s.prev, '.', -1, 100, 0)
    call s:touch(i, s:getindent(i) + s.indent_size)
endfunction

function! QDown()
    let s = s:getlinestate(1)
    let i = s:fli(s.next, '.', 1, 100, 0)
    call s:touch(i, s:getindent(i))
endfunction
inoremap qd <esc>:call QDown()<cr>

inoreab <buffer>idt indentation<C-R>=Eatchar('\s')<CR>

    " asdf
        " sdfsd sdfsdf

function! s:gi2(s)
   let [indexes, flag] = GetVisualIndexes('flag')
   if empty(flag)
       return indexes
   endif

   let fnkey = s:llvf(a:s) ? a:s : g:GI4Ref[a:s]
   return function(fnkey)()
endfunction

" https://newyork.craigslist.org/mnh/edu/d/new-york-act-sat-tutors/7706243801.html
" pride

function! JavascriptVimEditor(...)
    let ref = {
        \'apple': 'test.vimFunctionConnector.js',
        \'banana': 'test.vimFunctionConnector.js',
    \}
    let key_list = keys(ref)
    let javascriptFileKey = s:fuzzy(key_list)
    let javascriptFile = ref[javascriptFileKey]
    let file = expand('%')
    let lnum = line('.')
    let state = {
        \'file': file,
        \'lineNumber': lnum,
    \}
    let arg = a:0 >= 1 ? a:1 : ''
    let lines = EvaluateFromShell('node', javascriptFile, state, arg)

    if s:t(lines[-1], '^node.js')
        ec 'error:'
        ec s:tostring(block)
        return 
    endif

    let json_string = lines[0]
    let json = json_decode(json_string)

    ec '__________'
    ec json 
    ec '__________'
    ec s:is_object(json)
endfunction


function! ExportToJson(k)
    "test: dirdict 
    "test: directoryaliases 
    "test: wpsnippets
    let k = trim(a:k)
    let name = 'temp'
    let value = k
    if s:isstring(k)
        let name = k
        let value = s:gval(k)
    endif
    let json_data = json_encode(value)
    call Clip(json_data)
    let s = name . ' = ' . json_data
    call writefile([s], "/home/kdog3682/PYTHON/workspace.py", 'a')
endfunction
function! OnCompleteDoneTest()
    
endfunction
function! LEDedentLine(s)
    return trim(a:s)
endfunction
let g:execRef2["le.dd"] = "LEDedentLine"
function! OnCompleteDoneTest()
    let el = v:completed_item
    " call append('$', '" abc')
    " ec ["el", el]
endfunction
function! CompletionTest(findstart, base)
    let findstart = a:findstart
    let base = a:base
    if findstart
        return FindStart(findstart)
    endif
    return s:regexfilter2(s:months, a:base)
    return [{'abbr': 'abc', 'word': 1, 'user_data': {'a': 2}},2,3]
    
endfunction
function! FindStart(findstart)
    let findstart = a:findstart
    let line = getline('.')
    let start = col('.') - 1
    while start > 0 && line[start - 1] =~ '\a'
        let start -= 1
    endwhile
    return start
endfunction
function! CleverTab()
    let s = getline('.')
    let pos = col('.') - 1
    let m = strpart(s, 0, pos)

    if m =~ '^\s*$'
        return "\<Tab>"
    else
        return "\<C-x>\<c-u>"
    endif
endfunction

function! JavascriptVimState()
    let buffers = getbufinfo({})
    call ExportToJson(buffers)
endfunction
let g:execRef2["jve"] = "JavascriptVimEditor"
function! s:numbered(items)
    let items = a:items
    for i in range(len(items))
        let item = items[i]
        ec (i + 1) . '.  ' . (s:is_string(item) ? item : s:string(item))
    endfor
endfunction
let g:execRef2["t"] = "s:appendfile(g:activeFileLogFile, expand('%'))"
let g:execRef2["cab"] = ':bufdo bd'
let g:execRef2["sl"] = "s:appendfile('/home/kdog3682/2024/active_line_shunt.txt', getline('.'))"
let g:linkedBufferGroups["lezer-functions.js"] = "lezer.template.js"
let g:linkedBufferGroups["lezer.template.js"] = "lezer-functions.js"


" call mkdir('/home/kdog3682/2024-javascript/vim, 'p')
" call mkdir('/home/kdog3682/2024-javascript/organize/, 'p')
" call mkdir('/home/kdog3682/2024-javascript/organize/vim/jspyref, 'p')
" call mkdir('/home/kdog3682/2024-javascript/vim, 'p')

""" bookmarkId: 1705124090 """
set completefunc=CompletionTest
" filetype plugin on

function! JuneGunnFZF(s)
    " let search_dir = '/home/kdog3682/2024/'
    " execute 'FZF' . search_dir
    let  ref = {
        \'b': 'BLines',
        \'h': 'History',
        \'m': 'MAPS',
    \}
    execute ref[a:s]
endfunction
function! JuneGunnPlugInstall()
    PlugInstall
endfunction
let g:fzf_files_command = 'find . -maxdepth 1 -type f'

let g:execRef2["pi"] = "JuneGunnPlugInstall"

setlocal completefunc=VimComplete
" inoremap <silent> <buffer> <Tab> <C-R>=CleverTab()<CR>
" setlocal completefunc=CompletionTest
" autocmd! CompleteDone * call OnCompleteDoneTest()
" set shortmess+=c   " Shut off completion messages
" set completeopt+=menuone,noinsert,noselect
inoremap q' "

function! MuToggle()
    execute "MUcompleteAutoToggle"
endfunction
let g:execRef2["mu"] = "MuToggle"

let g:filedict["mu"] = "/home/kdog3682/.vim/plugged/vim-mucomplete/doc/mucomplete.txt"

let g:mucomplete#chains = { 'default': ['user'] }
let g:mucomplete#enable_auto_at_startup = 0
let g:mucomplete#minimum_prefix_length = 1
function! NerdTree()
    execute 'NERDTreeToggle'
endfunction
function! Zamba()
    return MyPlugin#abc() 
endfunction

function! Sfsdf()
    return Helper1()
endfunction
let g:execRef2["fz"] = "JuneGunnFZF"

function! PrintCommandHistory()
    let history_count = histnr('cmd')
    echo "Command History:"
    for i in range(history_count)
        let history_item = histget('cmd', i)
        echo i . ': ' . history_item
    endfor
endfunction





nnoremap eja :call OpenBuffer4('/home/kdog3682/2023/a.js')<CR>
nnoremap ejb :call OpenBuffer4('/home/kdog3682/2023/b.js')<CR>
nnoremap ejc :call OpenBuffer4('/home/kdog3682/2023/c.js')<CR>
let g:gfgfdict['vimc'] = ['/home/kdog3682/.vimrc', 'VimComplete', 0]
let g:execRef2["g"] = "JumpToFunctionByKey"


let g:fileRef["rewrite.template.js"] = {}
let g:fileRef["rewrite.template.js"]["node1"] = {"runtimeFile":"runRewriteFile.js"}
    \"node1": {"run": "packageManager.js", "argFile": "/home/kdog3682/2024/cssGeneratedClasses.template", "fnKey": 'generateCssClassFile'},
let g:fileRef["rewrite.template.js"]["linked6"] = "runRewriteFile.js"
" runRewriteFile.js

function Fuzzy(a)
    let a = a:a
    return s:fuzzy(a)
endfunction


function! RunTypeScript(file)
    let s = '!clear; deno run --check --allow-read --allow-run --allow-net --allow-write --allow-env --allow-all ' . a:file
    let s = "!clear; tsx " . a:file
    execute s
    return 

    return 
    " Clear the message area
    echo ""

    " Run TypeScript compiler and capture output
    let l:compile_output = system('tsc ' . expand('%'))
    ec l:compile_output

    " Check for errors
    if v:shell_error == 0
        echo "Compilation successful"
    else
        echo 'err'
        return 
        " Find the first error
        for l:line in split(l:compile_output, "\n")
            " Regex to match 'file.ts(line,col): error TS...'
            if l:line =~ '^\S\+([0-9]\+,\([0-9]\+\))\: error TS'
                let l:parts = matchlist(l:line, '^\(\S\+\)(\([0-9]\+\),\([0-9]\+\))\: error TS')
                let l:file = l:parts[1]
                let l:line_number = l:parts[2]

                " Open the file at the specific line
                execute 'e +' . l:line_number . ' ' . l:file
                break
            endif
        endfor
    endif
endfunction


function! TypstSmartEnter()
    if pumvisible()
        return "\<CR>"
    endif
    let a = TypstSmartEnter2()
    if s:exists(a)
        return a
    endif
    let s = getline('.')
    let t = trim(s)
    let bracket = s:t(t, '\{$')
    let spaces = s:match(s, ' +$')
    let delete_spaces = s:exists(spaces) ? BackspaceExpr(spaces) : ''
    let newline = "\<cr>"
    let enter_block = " {\<CR>}\<C-O>O\t"
    let reset_line = "\<esc>^Da"
    let r = '^([ie]f\w*) (\S+)$'
    let m = s:match(t, r)
    " @bookmark 1707166645
    let ref = {
        \'efs': 'else is-string($1)',
        \'efe': 'else exists($1)',
        \'efes': 'else exists(style.$1)',
        \'efo': 'else is-object($1)',
        \'efa': 'else if is-array($1)',
        \'efc': 'else if is-content($1)',
        \'ifs': 'if is-string($1)',
        \'ife': 'if exists($1)',
        \'ifes': 'if exists(style.$1)',
        \'ifo': 'if is-object($1)',
        \'ifa': 'if is-array($1)',
        \'ifc': 'if is-content($1)',
    \}
    if s:exists(m)
        let [a,b] = m
        if has_key(ref, a)
            let value = s:replace(ref[a], '\$1', b)
            return reset_line . value . enter_block
        elseif Test(b, "^(has|is)-")
            return reset_line . 'if ' . b . enter_block
        elseif a == 'if' || a == 'ef'
            return reset_line . 'if ' . b . ' != none' . enter_block
        elseif a == 'ifn' || a == 'efn'
            return reset_line . 'if ' . b . ' == none' . enter_block
        endif
    endif
    let below = trim(getline(line('.') + 1))
    " if s:t(t, '^\S+$') && below == ')'
        " return ",\<CR>"
    " endif

    " if s:t(t, '^[a-z0-9-]+:')
        " if s:t(t, ',$')
            " return newline
        " endif
        " return ",\<CR>"
    " endif

    if s:t(t, '^//+ ')
        " start the next line with a comment
        if s:t(t, '^/// ')
            return "\<CR>/// "
        endif
        return "\<CR>// "
    endif
    if !bracket && s:t(t, '^(if|else|while|for) ')
        let start = ''
        return start . delete_spaces . enter_block
    endif
    return "\<CR>"
endfunction
function! TypstFunctionHash()
    return s:t(getline('.'), '^\S') ? '#' : ''
endfunction
let g:jspyref3["typst"]["functionBlockTemplate"] = "${TypstFunctionHash()}let $1(${Paramify($2)}) = {\n    $c\n}"

function! GetTypstFunctionWords()
    let t = s:get_page_text()
    let r = "\n" . '#let \zs[a-z0-9-]+\ze\('
    let m = s:findall(t, r)
    let g:typst_function_words = m
    " ec 'GetTypstFunctionWords: ' . len(m)
endfunction
function! GetTypstWords2(key)
    let r = CreateCompletionRE(a:key)
    let screen_words = WordSpiraler('<' . r . '>')
    let function_words = s:regexfilter2(g:typst_function_words, r)
    " call input('function_words: ' . s:string(function_words))
    " call input(string(g:typst_function_words))

    let words = s:unique(screen_words + function_words)
    return words
endfunction

" GetTypstFunctionWords and GetTypstWords2 and autocmd work together


function! MyCustomStatusLine()
    if &filetype == 'typst'
        return expand('%:t')
    endif
    return s:replace(expand('%'), '/home/kdog3682', '~')
endfunction



function! Choose(x)
    return s:choose(a:x)
endfunction



function! InsertOW()
    " Get the current line content
    let line = getline('.')
    return line

    " Check if the line contains an object (a simple check for '{')
    if line =~ '{'
        " Object exists, jump to the object and insert 'width'
        " First, reformat the object to have one entry per line if it's not already
        let reformatted = substitute(line, '{\s*\zs\(.\{-}\)\ze\s*}', "{\r\1\r}", "")
        call setline('.', reformatted)

        " Move cursor to the object and insert 'width: '
        normal! f{
        normal! o
        normal! width:
        " Use 'a' to move cursor after the ':'
        normal! a
    else
        " No object in line, so just insert '{width: }'
        call setline('.', '{width: }')
        " Move the cursor to the $
        call cursor('.', col('.') - 1)
    endif
endfunction



function! OPEN(file)
    let file = a:file
    let openers = [ "pdf", "png", "svg", "jpg", "jpeg", ]

    if s:in(openers, GetExtension(file))
        return OpenBrowser(ShellEscape(file))
    endif

    let ex = bufexists(file)
    let cmd = Join(ex ? 'b!' : 'edit', file)
    ec cmd
    execute cmd

    if !ex
        execute "normal! G"
    endif

    return 1
endfunction


let g:visualactiondict['lazy'] = {'fn': 'VJavascriptConnector', 'file': 'vimConnector.js', 'version': 3, 'i': 'GetLazyObjectIndexes', 'arg': 'lazyObjectParserWriteToFileWrapper'}
let g:visualactiondict['x'] = {'fn': 'VJavascriptConnector', 'file': 'lezer-generate-json.js', 'version': 3, 'i': 'GetDashIndexes'}

function! GitAddCurrentFile(...)
  call GitCommandWrapper("
        \\n cd $gitdir
        \\n git add $gitfile
  \")
endfunction

function! GitPushCurrentFile(message = '')
    "test: adsfadsfas
    let message = a:message
    call Assert(message, 'message needs to exist')
    " call Assert(
    " ec message
    " return
  call GitCommandWrapper("
        \\n cd $gitdir
        \\n git add $gitfile
        \\n git commit -m '$1'
        \\n git push
  \", message)
endfunction
function! GitCommandWrapper(s, ref = [], wait = 0)
    let s = a:s
    let ref = a:ref
    let wait = a:wait
    let s = s:templater2(s, ref)

    if s:t(s, 'cd-?\d')
        ec s
        return 
    endif
    if s:exists(wait)
          call s:blue(s:colon('running git command', s))
    endif
    try
        return GitCommand(s)
    catch
        let error = v:exception
        ec 'ERROR'
        ec error
        ec s
    endtry
endfunction
function! GitCommand(cmd)
      let cmd = a:cmd
      let cmd = s:joinlines(s:split(cmd, '\n *'))
      call s:red("system command:\n--------------------------------------\n%s\n--------------------------------------", cmd)
      if g:flags.use_git_flag
          call input('press anything to continue to git push')
      endif

      let result = systemlist(cmd)
      let result = s:encode(result)
      call s:blue(result)
      return result
endfunction


function! InitializeVimSpeakers()
    let r = '^"?speakers: *(.+)'
    let speakers = s:flim(r, 1, 1, 50, 0)
    call input('speakers: ' . s:string(speakers))
    let g:dialogue_speakers = s:xsplit(speakers)
    let g:dialogue_speaker_index = 0
    ec 'initialized dialogue speakers: ' . speakers
    return speakers
endfunction

function! s:flim(...)
    let i = call(function('s:fli'), a:000)
    let r = a:1
    let s = getline(i)
    let m = s:match(s, r)
    return m
endfunction

let g:typst_build_modes=  ['log', 'write', 'pdf']
function! SetFrontMatterMode()
    let next = s:modular_increment(g:typst_build_modes, 'typst_build_modes', 1)
    let i = s:fli('^---', 1, 1, 100, 0)
    let i = s:fli('^mode', i, -1, 100, 0)
    call setline(i, 'mode: ' . next)
endfunction
function! SetVimSpeaker()

    if !exists('g:dialogue_speakers')
        call InitializeVimSpeakers()
    endif
    let nextSpeaker = s:modular_increment(g:dialogue_speakers, 'dialogue_speakers', 1)

    let i = s:fli('^"?[-_]', '.', -1, 100, 0) + 1
    " find the line that has the closest dashbreak
    let s = getline(i)
    let payload = 'speaker: ' . nextSpeaker
    if s:t(s, 'speaker')
        " a speaker exists for the line
        " therefore change to the next speaker
        call setline(i, payload)
    else
        if s:t(s, '\S')
            call append(i - 1, [payload, ''])
        else
            call append(i - 1, payload)
        endif
    endif
endfunction

function! FastGetDirectory(x)
    let x = a:x
    if empty(x)
        return Head()
    endif
    if IsDir(x)
        return x
    endif
    let a = '/home/kdog3682/'
    let b = '/home/kdog3682/2024-'
    let dirs = [a,b]
    for d in dirs
        let path = d . x
        if IsDir(path)
            return path
        endif
    endfor
    throw 'not a directory: ' . x
endfunction


nnoremap <leader>1 :call App_browse_old_files()<CR>
nnoremap <leader>2 :call FuzzyFileBrowser('2023')<CR>
" @bookmark 1707166645 editing typst_smart_enter
function! RegisterSystemExecRef(a, b)
    let a = a:a
    let b = a:b
    call DictSetter('g:system_exec_ref', a, b)
endfunction
function! FindVimFunctionInVimFiles(name)
    let name = a:name
    let base = ReadVimJSON('fvf')
    if has_key(base, name)
        call s:open(base[name])
        call s:open_function(name)
        return 
    endif

    let base = CurrentFile()
    let files = [
        \'/home/kdog3682/.vim/ftplugin/vimrc.january2024.vim',
         \'/home/kdog3682/.vim/ftplugin/functions.vim',
         \'/home/kdog3682/.vimrc',
         \'/home/kdog3682/.vim/ftplugin/functions.09-15-2023.vim',
    \]
    let touched = ''
    for file in files
        call s:open(file)
        if s:open_function(name)
            let touched = file
            break
        endif
    endfor
    if s:exists(touched)
        return AppendVimJSON('fvf', {name: touched})
    else
        call s:open(base)
        ec 'no file found'
    endif
endfunction

function! FindAnythingHandler(key)
" {"type":"hfl","bookmarkId":"1708172482"}
    let val = _FindAnythingHandler(a:key)
    if s:llvf(val)
        call FindVimFunctionInVimFiles(val)
    else
        ec val
    endif
endfunction
function! _FindAnythingHandler(key)
    let key = a:key
    let ref = s:get_file_ref('execRef')
    if s:exists(ref) && has_key(ref, key)
        return ref[key]
    endif
    let fnKey = DictGetter2(g:jspyref3, &filetype, 'execFunctions', key)
    if s:exists(fnKey)
        return fnKey
    endif
    let fnKey = get(g:execRef2, key, 0)
    if s:exists(fnKey )
        return fnKey
    endif

    let fnKey = get(g:execRef, key, 0)
    if s:exists(fnKey)
        return fnKey
    endif

    let fnKey = get(g:wpsnippets2.javascript, key, 0)
    if s:exists(fnKey)
        return fnKey
    endif

    let fnKey = get(g:wpsnippets.js, key, 0)
    if s:exists(fnKey)
        return fnKey
    endif

    let fnKey = get(g:wpsnippets2[&filetype], key, 0)
    if s:exists(fnKey)
        return fnKey
    endif

    return FindSnippet(key)
endfunction
function! FindSnippet(...)
    let key = a:0 >= 1 && s:exists(a:1) ? a:1 : g:last_wp_snippet_input
    let template = _GetSnippetTemplate(key)
    let fn = s:match(template, '\C\$\{\zs[A-Z]\w+')
    if s:exists(fn)
        call FindVimFunctionInVimFiles(fn)
    endif
endfunction
" @bookmark 1707225040 find snippet ffrom template
" @bookmark 1707224313 asd

function! _GetSnippetTemplate(...)
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
    return t
endfunction
function! GetCompletionFiles(s)
    let s = a:s
    let fnKey = get(ref, s, '')
    if s:exists(fnKey)
        return function(fnKey)()
    endif
    let files = 
    let files = split(glob(dir . '/*'), "\n")
    return s:regexfilter2(files, s)
endfunction

function! FullGitDiff(...)
    call GitCommandWrapper("
        \\n cd $gitdir
        \\n git diff > /home/kdog3682/2023/git-checkout.temp.js
    \")
    call OpenBuffer3('/home/kdog3682/2023/git-checkout.temp.js')
endfunction

function! GitDiff(...)
    call GitCommandWrapper("
        \\n cd $gitdir
        \\n git diff -- $gitfile > /home/kdog3682/2023/git-checkout.temp.js
    \")
    call OpenBuffer3('/home/kdog3682/2023/git-checkout.temp.js')
endfunction

" Function to get modified and untracked files from git
function! GetGitFiles()
    let dir = GetGitDirPath()
    " call input('dir: ' . s:string(dir))
    let cd = 'cd ' . dir . '; '
    let modified_files = split(system(cd . 'git diff --name-only'), "\n")
    let untracked_files = split(system(cd . 'git ls-files --others --exclude-standard'), "\n")

    call Numbered(modified_files)
    ec 'modifiled files'

    call Numbered(untracked_files)
    ec 'untracked_files'
endfunction


function! CommentLineStartLines()
    GetSetRange2023
endfunction
let g:visualactiondict['comment'] = {'fn': 'VApplyTemplaterEffectToBlock', 'arg': '"// " . v:val'}
let g:vimFunctionAliases["datetime"] = "GetTime"
let g:vimFunctionAliases["gitdir"] = "GetGitDirPath"
let g:vimFunctionAliases["iso8601"] = "Iso8601"
let g:vimFunctionAliases["commitid"] = "GetCommitId"
let g:vimFunctionAliases["dashedText"] = "GetDashedText"
function! GetDashedTextIndexes()
    let a = 0
    let b=0
    try
        let a = s:fli('^--', '.', -1, 200, 0, 1)
    catch
    endtry
    try
        let b = s:fli('^--', a + 1, 1, 200, 0)
    catch
        let b = 0
    endtry

    let max = line("$")
    if b == 0 
        let b = max
    elseif b != max
        let b -= 1
    endif

    return [a + 1, b]

    let a = s:fli('^fun', '.', -1, 200, 0, 1)
    let b = s:fli('^endfun', a + 1, 1, 200, 0)
    return [a, b]
endfunction
function! GetDashedText()
    let lines =  trim(join(s:getlines('GetDashedTextIndexes'), '\n'))
    return lines
endfunction
function! SafeGitCheckout(target)

    ec GitCommandWrapper("
        \\n cd /home/kdog3682/LOREMDIR
        \\n ls
        \\n git rev-parse --abbrev-ref HEAD
    \")
    ec getcwd()
    return 
    return 
    return 
    " Save the current branch or commit hash
    let current_ref = system('')
    if v:shell_error != 0
        let current_ref = system('git rev-parse HEAD')
    endif
    let current_ref = substitute(current_ref, '\n\+$', '', '') " Remove trailing newline

    " Checkout the desired commit or branch
    let checkout_cmd = 'git checkout ' . a:target
    call system(checkout_cmd)

    " Check for errors
    if v:shell_error != 0
        echoerr 'Failed to checkout ' . a:target
        return
    endif

    " Inform the user
    echo 'Checked out ' . a:target
    echo 'Press ENTER to return to ' . current_ref

    " Wait for the user to press ENTER
    let _ = getchar()

    " Checkout the original branch or commit
    let checkout_cmd = 'git checkout ' . current_ref
    call system(checkout_cmd)

    " Inform the user
    if v:shell_error == 0
        echo 'Returned to ' . current_ref
    else
        echoerr 'Failed to return to ' . current_ref
    endif
endfunction


function! GitPushCurrentDirectoryBasedOnMainFile(...)
  """ 02-07-2024
  """ pushes all the files in the directory based on the current file
  let arg = a:0 >= 1 && Exists(a:1) ? ' - ' . a:1 : ''
  call GitCommandWrapper("
        \\n cd $gitdir
        \\n git add .
        \\n git commit -m '$gitfilename $1'
        \\n git push
  \", arg)
  " call s:appendfile('git-logs.txt', result)
endfunction
function! HasA000(a000)
    let a000 = a:a000
    if len(a000) == 0
        return 0
    elseif Exists(a000[0])
        return 1
    else
        return 0
    endif
endfunction

function! GitPushUpdate(...)
  call GitCommandWrapper("
        \\n cd $gitdir
        \\n git add -u
        \\n git commit -m '$gitfilename is working!'
        \\n git push
  \", 1)
endfunction

function! FVF(...)
    let word = a:0 >= 1 && Exists(a:1) ? a:1 : GetCurrentWord()
    call FindVimFunctionInVimFiles(word)
    " {"type":"hfl","bookmarkId":"1708172463"}
endfunction

function! FindCommitIdByMessage(dir, message)
    let dir = a:dir
    let message = a:message

    let commit_ids = GitCommandWrapper("
        \\n cd $1
        \\n git log --all --grep=$2
    \", [dir, message])
    return commit_ids

endfunction

function! ShowFilesInCommit(commitHash)
    " Show the files associated with the commit
    let show_files_command = 'git diff-tree --no-commit-id --name-only -r ' . a:commitHash
    let changed_files = system(show_files_command)

    " Check for errors
    if v:shell_error == 0
        " Remove any newline characters at the end of the changed files list
        let changed_files = substitute(changed_files, '\n\+$', '', '')
        if len(changed_files) == 0
            echo 'No files changed in commit: ' . a:commitHash
        else
            echo 'Files changed in commit ' . a:commitHash . ':'
            echo changed_files
        endif
    else
        echoerr 'Failed to get files for commit: ' . a:commitHash
    endif
endfunction

function! GitProductionTest()
  let g:prompt_message = 'write a clear and coherent message for this git production push'
  let message = s:templater2('$file: $prompt')
  let dir = '/home/kdog3682/2023/'
  let prev_dir = ChangeDirectory(dir)

  call GitCommandWrapper(" 
        \\n git add -u
        \\n git commit -m '$1'
        \\n git push
  \", [message])

  let b = s:templater2('$iso8601 "$1" $commitid', message)
  call s:append_file('git_checkout_ids.txt', b)
    
endfunction
function! GitLoremTest()
  " return WriteFile('/home/kdog3682/LOREMDIR/test.b.js', 'hi')
  " return WriteFile('/home/kdog3682/LOREMDIR/test.a.js', 'hi')
  " return WriteFile('/home/kdog3682/LOREMDIR/package.json', 'hi')
  " return WriteFile('/home/kdog3682/LOREMDIR/test.js', 'hi')
  " let dir = '/home/kdog3682/LOREMDIR/'
  " let old = ChangeDirectory(dir)
  " ec ShowFilesInCommit('5d7d5b867d6e14697fb694516c0d48a2fea37c7d')
  " ec ShowFilesInCommit('6831f2e2356806a95d3abece8d3a622adf4c12b2')
  " return
  " ec ShowFilesInCommit('b339f7d7d6dd131b1b95e88326fe9b3a805c6cf5')
  " return GitCommandWrapper("git restore $1; git checkout main", 'test.js')
  " return GitCommandWrapper('git status')

  let message = 'orange'
  let message = 'strawberry'
  return GitCommandWrapper('git checkout 422ff3e2224a0831ce15232a025f023f95244d74')
  return GitCommandWrapper('git checkout main')
  " return WriteFile('/home/kdog3682/LOREMDIR/test.js', 'hi')
  call GitCommandWrapper(" 
        \\n git add -u
        \\n git commit -m '$1'
        \\n git push
  \", [message])

  let b = message . ' ' . GetCommitId('HEAD')
  call s:append_file('git_checkout_ids.txt', b)
  return 



  " return
  let a = 'main ' . GetCommitId('main')
  let b = 'head ' . GetCommitId('HEAD')
  call s:append_file('git_checkout_ids.txt', [a, b])
  call ChangeDirectory(old)
  return

  let ids = FindCommitIdByMessage(dir, 'apple')
  ec ids
  return 

  call GitCommandWrapper("
        \\n cd /home/kdog3682/LOREMDIR
        \\n git status
  \", 1)
        " \\n git push
        " \\n git add .
        " \\n git commit -m 'apple'
endfunction
function! GetCommitId(ref = 'HEAD')
    " Get the commit ID of the specified reference
    let commit_id = system('git rev-parse ' . a:ref)

    " Check for errors
    if v:shell_error == 0
        " Remove any newline characters at the end of the commit ID
        let commit_id = substitute(commit_id, '\n\+$', '', '')
        return commit_id
    else
        echoerr 'Failed to get commit ID for ' . a:ref
        return ''
    endif
endfunction

function! ChangeDirectory(dir)
    let old = getcwd()
    " Change the directory
    execute 'cd ' . a:dir
    return old
endfunction

function! DiscardAllChanges()
    " Discard all changes in the branch
    let discard_command = 'git reset --hard'

    " Execute the discard command
    call system(discard_command)

    " Check for errors
    if v:shell_error == 0
        echo 'All changes discarded in the branch'
    else
        echoerr 'Failed to discard changes'
    endif
endfunction

function! Iso8601()
    return strftime("%Y-%m-%d")
endfunction
function! Glob(dir)
  let dir = a:dir
  let dir = FastGetDirectory(dir)
  let dir = s:sub(dir, '/$', '')
  let dir = dir . '/*'
  let items = glob(dir)
  let files = split(items, "\n")
  return files
endfunction
function! FileTable(dir)
    let dir = a:dir
    let file = '/home/kdog3682/2024/file-table.txt'
    call WriteFile(file, Glob(dir))
    call OpenBuffer3(file)
endfunction
function! Foksdf()
    " call FileTable('2023')
    execute 'Explore ~/.local/share/typst/packages/cetz/'
endfunction

function! CD()
    let dir = s:templater2('$gitdir')
    call ChangeDirectory(dir)
endfunction
let g:keyboard.reset = "\<esc>^Da"
let g:keyboard.enter_block = " {\<CR>}\<C-O>O\t"
let g:keyboard.equals = " = "
let g:keyboard.quotes = " \"\" "
" let g:keyboard.deleteEndingSpaces = DeleteEndingSpacesExpr


function! CloseOldBuffers()
    let current_time = localtime()
    let age_limit = 10 * 60
    let limit = current_time - age_limit

    for b in getbufinfo({})
        if b.lastused < limit
            exec 'silent! bd! ' . b.bufnr
        endif
    endfor
endfunction

function! GetLocalFunctionWords()
    let t = s:get_page_text()
    let r = "\n" . '%(async )?function \zs[a-z0-9-_]+\ze\('
    let m = s:findall(t, r)
    return m
endfunction


function! Sdfjkjhds()
    call mkdir('/mnt/chromeos/GoogleDrive/MyDrive/current_temp_saved_files')
endfunction

function! Booga()
    
    let modified_files = split(system('git diff --name-only'), "\n")
    let untracked_files = split(system('git ls-files --others --exclude-standard'), "\n")
    let base = modified_files + untracked_files
    " for item in base
        " ec item
    " endfor

    function! s:inner___1(i, s)
        let template = 'cp $1 /mnt/chromeos/GoogleDrive/MyDrive/current_temp_saved_files/'
        return s:templater2(template, a:s)
    endfunction
    let commands = map(base, function('s:inner___1'))
    let str = join(commands, ';')
    return system(str)
endfunction
function! GetLibraryItem(...)
    let key = a:0 >= 1 && s:exists(a:1) ? a:1 : s:gcw()
    let lib = s:read('vim.json')
    let item = has_key(lib, key) ? lib[key] : ''
    if s:exists(item)
        call append('$', WrapLines(item))
        return 'success!'
    endif
endfunction

function! Asdfasdf()
    return GetLibraryItem('OpenBuffer')
endfunction


function! RunTypst(file, open=0)
    let file = a:file
    let open = a:open
    let out = '/home/kdog3682/2023/test.pdf'
    let template = 'typst compile %s %s --root /'
    let cmd = printf(template, file, out)
    " call input('cmd: ' . s:string(cmd))
    " return
    let e = system(cmd)
    if s:t(e, '^error:')
        ec e
    elseif g:flags.open_typst_pdf || open
        call OpenBrowser(out)
    endif
endfunction
let g:fileRef["td.q15.math"] = {}

function! Sosall(s)
    return s:sosall(a:s)
endfunction

function! ReplaceBlock(indexes, lines, ...)
    let indent = a:0 >= 1 ? a:1 : 0
    let indexes = s:normalize_indexes_smaller_bigger(a:indexes)
    let lines = s:tolines(a:lines)
    if empty(lines)
        return 
    endif
    if s:exists(indent)
        let lines = s:smartindent(lines)
    endif
    let [a, b] = indexes
    for i in range(a, b)
        call deletebufline('%', a)
    endfor
    call append(a - 1, lines)
endfunction

function JPCreateFunctionBlockAsExpression()
    let s = getline('.')
    let runnerName = 'runner'
        """ bookmarkId: 1702061523 hfel: function """
        let ref = {
            \'_': '_, x',
            \'ab': '[a, b]',
            \'kv': '[k, v]',
            \'kvi': '[k, v], i',
        \}
    let w = s:gcw()
    if s:t(s, w . '\)')
        if w == "options"
            return "\<ESC>Oconst " . w . " = {\<CR>}\<CR>\<ESC>?{\<CR>o"
        endif
        let k = s:prompt('args?')
        let ps = get(ref, k, join(s:xsplit(k), ', '))
        return "\<ESC>Oconst " . w . " = (" . ps . ") => {\<CR>}\<CR>\<ESC>?{\<CR>o"
    endif
    if s:t(w, 'checkpoint|rusfsdfnner')
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

    if Test(word, 'lam|sdfsdfrunner') && Test(s, word . '\)')
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
            if nameKey == 'get'
                let params = ''
                let name = parts[0]
                let t = 'get ' . t
            elseif nameKey == 'set'
                let params = len(parts) == 2 ? parts[1] : ''
                let name = parts[0]
                let t = 'set ' . t
            endif
                " call input('t: ' . s:string(t))
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

function! SuperFlat(...)
    let s:_items = []
    function! s:inner(s)
        let s = a:s
        if IsArray(s)
            for item in s
                call s:inner(item)
            endfor
        elseif Exists(s)
            call add(s:_items, s)
        endif
    endfunction
    call s:inner(a:000)
    return s:_items
endfunction
function! Node1001(file, ...)
    return System('node', a:000)
endfunction
function! Node1000(file, ...)
    let result = Node1001(file, a:000)
    return 1
endfunction
function! GTracker(s)
    let s = a:s
    if s == g:tracker_string
        return 1
    endif
    return 0
	
endfunction
let g:tracker_string = ''


function! LSDirectory()
    call GitCommandWrapper("
        \\n cd $head
        \\n ls
    \")
endfunction

function! RemoveGitFromDirectory()
    " let dir = '/home/kdog3682/2024-javascript'
    " call GitCommandWrapper('rm -rf /home/kdog3682/2024-javascript/.git')
endfunction
function! DictGetterMultipleAttempts(ref, ...)
    let ref = a:ref
    for item in a:000
        if has_key(ref, item)
            return ref[item]
        endif
    endfor
    throw 'could not resolve a value ... no keys matched'
	
endfunction


function! GetExports(file)
    let t = s:read(a:file)
    let m = s:match(t, '%(^\s*|\n)export *\{\s*(.{-})\s*}')
    let items = s:xsplit(s:remove_comments(m))
    return items
endfunction

function! FindBuffer(o = {})
     let o = a:o
     let ext = get(o, 'ext', '')
     let buffers = SortBuffers()
     if s:exists(ext)
         return Find(buffers, {x -> GetExtension(x.name) == ext})
     endif
     throw "not done yet"
endfunction

function! SimpleHighlighting()
    call s:highlight_syntax("simple_comment", "^ *//.*", "gray")
endfunction

function! Uso()
    let s:config.use_override_node_file = true
    call Node1()
endfunction

function! GetOverrideNodeFile()
    let s:config.use_override_node_file = 1
    if exists('g:override_node_file')
        return g:override_node_file
    else
        let g:override_node_file = App_browse_old_files2()
        return g:override_node_file
    endif
endfunction
function! Node2()
    return Node1({'node2': 1})
endfunction

function! GetSetFn2(k, ...)
    let i = a:0 >= 1 ? a:1 : line('.')
    let [spaces, s] = GetSpacesAndLine(i)
    let v = FunctionGetter(a:k)(s)
    if IsArray(v)
        call setline(i, '')
        call append(i - 1, Indent(v, spaces))
    else
        call setline(i, spaces . v)
    endif
endfunction

" Define a function to comment out lines containing 'console.log'
function! CommentOutConsoleLogs(items)
    for filepath, lnums in a:items

        let bufnr = bufnr(filepath)
        if bufnr == -1
            execute 'silent! edit ' . filepath
            let bufnr = bufnr('%')
        endif

        for lineno in lnums
            let line = getline(lineno)

            if line =~ 'console\.log' && Exists(input(line))
                call setbufline(bufnr, lineno, '//' . line)
            endif
        endfor

        if bufnr('%') != bufnr
            execute 'silent! write'
            execute 'silent! bdelete' . bufnr
        endif
    endfor
endfunction

function! COCL()
    call LogConsole()
    let res = Node1001()

endfunction
function! GoShellError(result)
    let result = a:result
    let string = s:tostring(result)
    let result = a:result
        let r =  'file://(.{-}):(\d+)'
        let m = s:findall(string, r)
        " call input('m: ' . s:string(m))
        if s:exists(m)
            " let match = s:choose(m[0:5])
            let match = m[0]
            let [file, line] = s:match(match, r)
            ec result[0]
            " ec m[0:3]
            return s:open(file, line)
        else
            return 0
        endif
endfunction

function! GetOrSetGVariable(s, payload = '', reset= 0)
    let s = a:s
    let payload = a:payload
    let reset = a:reset

    if reset == 1 || !exists('g:_' . s)
        let ref = Exists(payload) ? payload : s:prompt('choose a value')
        if IsArray(ref) || IsObject(ref)
            let ref = s:choose(ref)
        endif
        let ref = VT(ref)
        let val = Encode_as_binding_value(ref)
        call input('val: ' . s:string(val))
        execute VT('let g:_$1 = $2', s, val)
    endif

    return eval('g:_' . s)
endfunction
function! SetGVar(a, b)
    let a = a:a
    let b = a:b
    execute VT('let g:$1 = $2', a, b)
endfunction

function! EnsureDirExists(p)
    let p = a:p
    let dir = fnamemodify(p, ':h')
    call Mkdir(dir)
endfunction

function! Mkdir(dir)
    let dir = a:dir
    if dir == '.' || len(dir) < 10
        throw 'cannot make directory: ' . dir
    endif
    if !isdirectory(dir)
        call mkdir(dir, 'p')
    endif
endfunction
function! FindMapArg(s)
    " test: "0"
    " test: "zc"
    " test: "gp"
    let expr = s:sub(a:s, ',', '<leader>')
    let [expr, mode] = MGet2(expr, '^(\w):')
    " call input('[expr, mode]: ' . s:string([expr, mode]))
    let result = maparg(expr, mode, 0, 1)
    " call InputPrompt('result', result)
    " ec result
    " return
    " return result
    " call input(s:string(result))
    if empty(result)
        return 
    endif
    let rhs = result.rhs
    let match = Match(rhs, '\w+\ze\(')
    if s:exists(match)
        call FVF(match)
    endif
endfunction

function! VT(template, ...)
    let template = a:template
    if !s:t(template, '\$')
        return template
    endif
    if len(a:000) > 0
        if IsArray(a:1)
            return s:templater2(template, a:1)
        elseif IsObject(a:1)
            return call(function("s:templater2"), [template, a:1])
        endif
    endif
    return call(function("s:templater2"), [template, a:000])
endfunction

function! GREP()
    let dir = '/home/kdog3682/2024-javascript/'
    let cmd = 'find $1 -type f -not -path "./node_modules/*" -not -path "./.git/*" -not -path "*/.*" -exec grep -l "node-utils" {} +'
    let cmd = s:templater2(cmd, dir)
    call OpenBuffer3(GetTempFile())
    call append('$', systemlist(cmd))
endfunction

function! AppendSpellcheckJSON()
    let lines = s:getlines(s:gi('ibmContiguous', 1))
    let lines = map(lines, 'SplitOnce(v:val)')
    let t = '  "%s": "%s",'
    let items = map(lines, {i, x -> printf(t, x[0], x[1])})
    let file = '/home/kdog3682/2024/spellcheck.json'
    call SilentAppendAndRemoveBuffer(file, items)
endfunction

function! MaybeLoadBuffer(filename)
  let bufnr = bufnr(a:filename)
  let wasLoaded = bufloaded(bufnr)
  if !wasLoaded
    silent execute 'edit' a:filename
      let bufnr = bufnr(a:filename)
  endif
  return bufnr
endfunction

function! SilentAppendAndRemoveBuffer(filename, lines)
    let filename = a:filename
  let bufnr  = MaybeLoadBuffer(filename)
  let lnum = 5

  " Append lines to the buffer
  for line in a:lines
    call appendbufline(bufnr, lnum, line)
  endfor

  " silent execute 'write'
  " silent execute 'bdelete ' . bufnr
endfunction

function! PrevFile()
    return bufname('#')
endfunction


function! GoToDefinition()
    
endfunction


function! GoNoteFile()
    let file= "/home/kdog3682/2024/.notes.txt"
    call OpenBuffer3(file)
    return 
    let file = s:sub(CurrentFile(), "\.notes$", "")
    if s:t(file, "notes$")
        return 
    endif
    let ext = GetExtension(file)
    let ft = s:get_file_type(ext)
    let path = ft . ".notes"
    let file = s:smartnpath(path)
    " call input('file: ' . s:string(file))
    call OpenBuffer3(file)
endfunction
nnoremap ews :call GoWorkspaceFile()<CR>

" function! GoWorkspaceFile()
    " let file = s:sub(CurrentFile(), "\.notes$", "")
    " let ext = GetExtension(file)
    " let path = AddExtension('workspace', ext)
    " let file = s:smartnpath(path)
    " call OpenBuffer3(file)
" endfunction
nnoremap enf :call GoNoteFile()<CR>


function! RefFromTailOrLang(key, controlKey = 0)
    let key = a:key
    let controlKey = a:controlKey
    
    let tail = ''
    if Exists(controlKey)
        let tail = controlKey
    else
        let file = MaybeCurrentFile()
        let tail = Tail(file)
    endif

    let lang = s:get_file_type(tail)

    let ref = DictGetter2(g:fileRef, tail, key)
    if s:exists(ref)
        return ref
    endif
    let ref = DictGetter2(g:jspyref3, lang, key)
    if s:exists(ref)
        return ref
    endif
    ec s:templater2('could not find a target for $1 for $2 or $3', [key, tail, lang])

endfunction

function! DollarArg(arg)
    let arg = a:arg
    if IsNumber(arg)
        return arg
    endif
    return s:templater2(arg)
endfunction
function! Node0Handler(ref)
    let ref = a:ref
	let args = map(SplitSpaces(ref.args), 'DollarArg(v:val)')
    return call(function(ref.fn), args)
endfunction


function! MGet2(s, r) abort
    "test: booga, bo

    let s:value = ''
    function! s:get(args) abort
        let computed = filter(copy(a:args), 's:exists(v:val)')
        if len(computed) == 1
            return computed[0]
        elseif len(computed) == 2
            return computed[1]
        else
            return computed[1:]
        endif
    endfunction

    function! s:inner(a)
        let s:value = s:get(a:a)
        return ''
    endfunction

    let text = substitute(a:s, '\v' . a:r, function('s:inner'), '')
    return [text, s:value]
endfunction


function RunPython2(file = 'run_apps.py', ...)
    let g:debug = 1
    let result = System3(a:file, a:000)
endfunction
let g:jspyref3['typst']['node0'] = {'fn': 'RunTypst', 'args': '$cf 1'}
let g:jspyref3['python']['node0'] = {'fn': 'RunPython2', 'args': 'GithubController.py $head'}
let g:jspyref3['python']['node0'] = {'fn': 'RunPython2', 'args': 'foo.py $head 123'}
let g:jspyref3['python']['node0'] = {'fn': 'SystemExec', 'args': 'GithubController.py $head'}
let g:jspyref3['vim']['node0'] = {'a': 1}
let g:jspyref3['raw'] = {}
let g:jspyref3['vue'] = {}
let g:jspyref3['raw']['node0'] = {"fn": 'RunRawFile', "args": "$cf $lnum"}
let g:jspyref3['raw']['node0'] = {"fn": 'RunRawFile', "args": "$cf $dashedText"}
let g:jspyref3['vue']['override_node_handler'] = '/home/kdog3682/2024-javascript/evalenv/runners/vuekit.js'
" let g:jspyref3['javascript']['override_node_handler'] = '/home/kdog3682/2024-javascript/evalenv/runners/vuekit.js'

function! RunRawJavascriptFile(file, text)
    let file = a:file
    let text = a:text
    let runFile = fnamemodify(file, ':h') . '/test.js'
    call SystemExec(runFile, text)
endfunction
function! RunVueFile(file)
    let file = a:file
    call SystemExec(runFile, text)
    
endfunction
function! RunRawFile(file, text)
    let file = a:file
    let text = a:text
    " let file = a:file
    " let lnum = a:lnum
    let ext = Match(file, '(\w+)\.raw$')
    let ref = {
        \'js.raw': 'RunRawJavascriptFile',
    \}
    let value = function(ref[ext])(file, text)
    if s:exists(value)
        ec value
    endif
    
endfunction
function! ConsoleToClip()
    
    if &filetype == 'typst'
        call GetSet('.', {s -> Test(s, 'panic') ? Replace(s, 'panic\((.*)\)', '\=submatch(1)') : Test(s, '^#') ? Replace(s, '#', '#panic(') . ')' : s:templater2('$1($2)', ['panic', s])})
    elseif &filetype == 'javascript'
        call GetSet('.', {s -> Test(s, 'console') ? Replace(s, 'console.log+', 'clip') : Replace(s, 'clip', 'console.log')})
    elseif &filetype == 'python'
        call GetSet('.', {s -> Test(s, 'print') ? Replace(s, 'p?print', 'clip') : Replace(s, 'clip', 'print')})
    endif
endfunction

function! SortByDate(files)
    let files = a:files
    call sort(files, {a,b -> getftime(b) - getftime(a)})
    return files
endfunction

function! ImportTypst(...)
    let key = a:0 >= 1 && s:exists(a:1) ? a:1 : 'none'

    let file = 'base-utils.typ'
    if key == "none"
    elseif key == "b"
        let file = Tail(bufname('#'))
    elseif key == "f"
        let files = Glob('/home/kdog3682/2024-typst/src/')
        let file = s:fuzzy(files)
    elseif IsFile("/home/kdog3682/2024-typst/src/" . key . ".typ")
        " let file = "/home/kdog3682/2024-typst/src/" . key . ".typ"
        let file = key . '.typ'
    else
        let files = Glob('/home/kdog3682/2024-typst/src/')
        let temp = matchfuzzy(files, key)[0:9]
        let file = Tail(s:fuzzy(temp))
    endif

    let name = s:remove_extension(file)
    let suffix = ': *'
    if s:t(name, 'styles|strokes|attrs|\w+s$|asdasd|asdasd')
        let suffix = ''
    endif
    let template = "#import \"$1\"$2"
    let imp = s:templater2(template, [file, suffix])
    return imp
endfunction
function! GetCurrentLineNumber()
    return line('.')
endfunction
let g:vimFunctionAliases['cf'] = 'MaybeCurrentFile'
let g:vimFunctionAliases['lnum'] = 'GetCurrentLineNumber'
let g:vimFunctionAliases['chooseFunc'] = 'ChooseFunc'
let g:vimFunctionAliases['w'] = 'GetCurrentWord'
let g:vimFunctionAliases['speaker'] = 'GetNextSpeaker'

function! MaybeCurrentFile()
    " if Exists(g:config.last_touched_raw_file)
        " return g:config.last_touched_raw_file
    " endif
    let f = CurrentFile()
    if s:t(f, 'raw$')
        return f
    endif
    if exists('g:override_node_file') && !empty(g:override_node_file)
        return g:override_node_file
    endif
	return f
endfunction
function! SetOverrideFile(reset = 0)
    let reset = a:reset
    if s:exists(reset)
        if reset=="a"
            call add(g:ignore_overrides, CurrentFile())
            ec "adding current file to g:ignore_overrides"
            return
        endif
        let g:override_node_file = 0
        let g:ignore_overrides= []
        ec 'turning off g:override_node_file'
        return 
    endif
    let g:override_node_file = CurrentFile()
    " let s:config['use_override_node_file'] = 1
    let s:config.use_override_node_file = 1
    ec 'g:override_node_file: ' . g:override_node_file
endfunction

function! OpenTypst()
    let out = '/home/kdog3682/2023/test.pdf'
    call OpenBrowser(out)
endfunction
function! CompileTypstFromStartToFinish()

    let payload = {
        \"file": 'examples.template.js',
        \"lineNumber": 'id: mmgg',
    \}

    let result = SystemChain(
        \['/home/kdog3682/2023/runPackage.js', payload],
        \['jieba_script2.py'],
        \['mmgg-morning-walk.typ'],
    \)
    if result
        call OpenTypst()
    endif
endfunction

function! System3(file, ...)
    "test: abc.js
    let file = a:file
    let ft = s:get_file_type(file)
    let dir = s:dict_getter(g:jspyref3, ft, 'main_dir')
    let shell = s:dict_getter(g:jspyref3, ft, 'main_shell')
    let outpath = Test(file, '^/') ? file : s:npath(dir, file)
    return System(shell, outpath, a:000)
endfunction

function! System2(file, payload = '', options = {})
    "test: abc.js
    let file = a:file
    let payload = a:payload
    let options = a:options
    let ft = s:get_file_type(file)
    let extra = s:dict_getter(g:jspyref3, ft, 'extra_shell_stuff')
    let dir = s:dict_getter(g:jspyref3, ft, 'main_dir')
    let shell = s:dict_getter(g:jspyref3, ft, 'main_shell')
    let outpath = Test(file, '^/') ? file : s:npath(dir, file)
    return System(shell, outpath, extra, payload)
endfunction
function! System(shell, file, ...)
    let shell = a:shell
    let file = a:file
    let ft = s:get_file_type(file)
    let cmd = ''
    if ft == 'typst'
        let cmd = join(SuperFlat(shell, file, a:000), ' ')
    else
        let base = SuperFlat(a:000)
        let args = map(base, "ShellEscape(s:encode(v:val))")
        let cmd = join(SuperFlat(shell, file, args), ' ')
    endif
    if exists('g:debug' && Exists(g:debug))
        ec cmd
        return 
    endif
    let result = systemlist(cmd)
    ec result
    if len(result) == 0
        return 0
    endif

    if HasShellError(result)
        " call GoShellError(result)
        return 0
    endif
    return 1
endfunction

let g:jspyref3['javascript']['lt'] = "throw $1"
let g:jspyref3["typst"]["main_shell"] = "typst compile"
let g:jspyref3["python"]["main_shell"] = "python3"
let g:jspyref3["javascript"]["main_shell"] = "node"

let g:jspyref3["typst"]["main_dir"] = "/home/kdog3682/2024-typst/src/"
let g:jspyref3["python"]["main_dir"] = "/home/kdog3682/PYTHON"
let g:jspyref3["javascript"]["main_dir"] = "/home/kdog3682/2023/"

let g:jspyref3["typst"]["ext"] = "typ"
let g:jspyref3["python"]["ext"] = "py"
let g:jspyref3["javascript"]["ext"] = "js"

let g:jspyref3["typst"]["dir"] = "/home/kdog3682/2024-typst/src/"
let g:jspyref3["python"]["dir"] = "/home/kdog3682/PYTHON"
let g:jspyref3["javascript"]["dir"] = "/home/kdog3682/2023/"

let g:jspyref3["vim"]["extra_shell_stuff"] = ""
let g:jspyref3["python"]["extra_shell_stuff"] = ""
let g:jspyref3["javascript"]["extra_shell_stuff"] = ""
let g:jspyref3["typst"]["extra_shell_stuff"] = "/home/kdog3682/2023/test.pdf --root /"
" let g:jspyref3["typst"]["block_start_re"] = "^#let"

let g:jspyref3["vim"]["inner_block_indexes"] = "GetInnerTypstBlockIndexes"
let g:jspyref3["typst"]["inner_block_indexes"] = "GetInnerTypstBlockIndexes"
let g:jspyref3["python"]["inner_block_indexes"] = ""
let g:jspyref3["javascript"]["inner_block_indexes"] = ""
function! GetTypstIndexes()
    let a = s:fli('^#let', '.', -1, 500, 0, 1)
    let s = getline(a)
    let b = a
    if s:t(s, '\{ *$')
        let b = FliDown('^\}')
    endif
    " call input(string([a,b]))
    return [a, b]
endfunction
function! GetMatchingSpacesIndex(i)
    let i = a:i
    let spaces = repeat(' ', s:get_indent(getline(i)))
    let r = printf('^%s\S', spaces)
    let a = s:fli(r, i, 1, 500, 0)
    return a
endfunction
function! GetInnerTypstBlockIndexes()
    let a = s:fli('^ *(const|let)', '.', -1, 500, 0)
    let b = GetMatchingSpacesIndex(a)
    return [a,b]
endfunction
function! GetInnerBlockIndexes()
    return GetInnerTypstBlockIndexes()
endfunction
function! MoveOut()
    let indexes = GetInnerBlockIndexes()
    let lines = s:getlines(indexes, 'd')
    let a = s:fli('^(#let|function|async|const)', '.', -1, 500, 0)
    call DedentLines2(lines)
    call append(a - 1, WrapLines(lines))
endfunction
function DedentLines2(lines)
    let lines = a:lines
    let spaces = Match(lines[0], '^ *')
    if empty(spaces)
        return 
    endif
    call map(lines, {i, x -> s:replace(x, spaces, '')})
endfunction

function! GetSmallFiles(size)
    let size = a:size
    let [dir, extension] = s:jspy(['dir', 'ext'])
    let files = FindSmallFiles(dir, size, extension)
    return files
endfunction
let g:app_functions = []
function AppController(...)
    function! s:inner(s)
        return s:split(a:s, '\s+')
    endfunction
    let args = a:0 >= 1 && Exists(a:1) ? s:inner(a:1) : []
    let fn = s:fuzzy(g:app_functions)
    let value = call(function(fn), args)
    if s:exists(value)
        ec value
    endif
endfunction
function! FindSmallFiles(dir, maxSize, extension)
    let dir = a:dir
    let maxSize = a:maxSize
    let extension = a:extension

    " Initialize an empty list to store the results
    let smallFiles = []

    " Get all files in the directory with the given extension
    let allFiles = split(globpath(dir, '*.' . extension), "\n")

    for file in allFiles
        if getfsize(file) < maxSize
            call add(smallFiles, file)
        endif
    endfor

    return smallFiles
endfunction

call add(g:app_functions, 'GetSmallFiles')

function! GitTempCheckout(...) abort
    let hasArgs = a:0 >= 1 ? 1 : 0
    let file = a:0 >= 1 ? a:1 : Tail()

    let origdir = getcwd()
    let dir = GetGitDirPath()
    call Chdir(dir)
    let m = 'git log -n 1 --pretty=format:%H -- ' . CurrentFile()
    let commitId = a:0 >= 2 ? a:2 : system(m)
    ec commitId
    " return
    call AssertGit(commitId)

    let prefix = ''
    if GetExtension(file) == 'typ'
        let prefix = 'src/'
    endif
    let s = systemlist('git show ' . commitId . ':' . prefix . file)
    if Test(s[0], 'fatal')
        ec s
        ec 'er!'
        return 
    endif
    call OpenBuffer('/home/kdog3682/2023/git-checkout.temp.js')
    %d_
    call append(1, s)
    call Chdir(origdir)
endfunction

function! FindMatchInLines(lines, r)
    "test: ['abc'], 'a'
    let lines = a:lines
    let r = a:r
    for line in lines
        let m = s:match(line, r)
        if s:exists(m)
            return m
        endif
    endfor
endfunction
function! AddOn(s, suffix)
    let s = a:s
    let suffix = a:suffix
    if s:t(s, suffix . '$')
        return s
    endif
    return s . suffix
endfunction
function! ExtractBlock()
	let a = s:fli('^ +\{', '.', -1, 200, 0)
    let b = GetMatchingSpacesIndex(a)
    let indexes = [a, b]
    let lines = s:getlines(indexes)
    let name = FindMatchInLines(lines, '%(type|name): [''"](\S+)[''"]')
    if empty(name)
        let name = input('choose a name for this block')
    endif
    let name = AddOn(name, 'Block')
    let a = s:fli('^[a-z]', '.', -1, 500, 0)
    call DedentLines2(lines)
    let lines[0] = 'const ' . name . ' = ' . trim(lines[0])
    let lines[-1] = s:sub(lines[-1], ',$', '')
    call ReplaceBlock(indexes, '    ' . name . ',')
    call append(a - 1, WrapLines(lines))
endfunction

function! GoMainFile()
    call OpenBuffer3(g:override_node_file)
endfunction
nnoremap em :call GoMainFile()<CR>
function! StarImport(s)
    "test: variables
    let s = a:s
    let t = 'import * as $1 from "$2"'
    return s:templater2(t, [s, SmartImportPath(s)])
    // absolute imports ...
endfunction



function! SmartImportPath(s)
    let s = AddExtension(a:s, 'js')
    let d = s:npath('2023', s)
    if IsFile(d)
        return d
    endif
    return './' . s
endfunction
function! AddImport2024(word)
    let word = a:word
    return 123
	" used with 'av' for 2024-javascript
endfunction

function! _JSImport(file)
    let file = a:file
    let word = GetCurrentWord()
    let s = ''
    let packages = [ "javascript.js", "python.js", "css.js", "html.js", ]

    if Tail(file) =="main.js"
        let m=  Match2(file, '/(\w+)/main.js')
        let s = printf('import * as %s from "%s"', m, file)
    elseif s:in(packages, Tail(file))
        let s = printf('import * as %s from "%s"', RemoveExtension(Tail(file)), file)
    elseif IsDir(file) || Test(file, "helpers")
        let s = printf('import * as %s from "%s/main.js"', GetLastWord(file), file)
    else
        let exports = GetExports(file)
        if s:in(exports, word)
            let exports= [word]
        endif
        let t = 'import {%s} from "%s"'
        let s = printf(t, join(exports, ', '), file)
    endif
    call append(0, s)
endfunction
function! JSImport2024()
    let source = 'find $(pwd) -regextype posix-extended -type f | grep -vE ''(fonts|\.git|node_modules|\.log$|temp|package)'''
    call fzf#run(fzf#wrap({"dir": "/home/kdog3682/2024-javascript/", 'source': source, 'sink': function('_JSImport')}))
endfunction
function! IsJS2024()
	return Test(Head(), '2024-javascript')
endfunction
function! JS2024File(file)
    let file = a:file
    call input(string(file))
endfunction
inoremap <leader>1 <esc> :call InsertTextAtCursor(GetOldFiles())<CR>a

function! InsertTextAtCursor(text)
    " Save the current position.
    let l:save_pos = getpos(".")

    " Insert the text at the current cursor position.
    execute "normal! i" . a:text

    " Restore the cursor to the original position (after the inserted text).
    call setpos('.', l:save_pos)
endfunction

function! TempBackup()
    ec 'temp backing the current file to .temp.txt'
    call CopyFile(CurrentFile(), '/home/kdog3682/.temp.txt')
endfunction

function GetTempFile()
    let file = '/home/kdog3682/.temp.txt'
    return file
endfunction
nnoremap etf :call OpenBuffer(GetTempFile())<CR>

function! Node0Controller(key = 'py')
    
    let ref = RefFromTailOrLang('node0', a:key)
    if s:exists(ref)
        call Node0Handler(ref)
    endif
endfunction
function! SystemExec(file, ...)
    "test: abc.js

    let file = a:file
    let ft = s:get_file_type(file)
    let dir = s:dict_getter(g:jspyref3, ft, 'main_dir')
    let shell = s:dict_getter(g:jspyref3, ft, 'main_shell')
    let outpath = Test(file, '^/') ? file : s:npath(dir, file)
    if !IsFile(outpath)
        return 
    endif

    call BaseExec(shell, outpath, a:000)
endfunction

function! Encode_as_binding_value(x)
    "test: ['asdf']
    let x = a:x
    if s:is_string(x)
        if s:t(x, '"')
            return SingleQuote(x)
        else
            return DoubleQuote(x)
        endif
    else
        return json_encode(x)
    endif
endfunction


function! InsertAtCursorFuzzyFoundFile()
    let files = ReadJSON('.files.log.json')
    let file = s:fuzzy(files)
    call InsertTextAtCursor(file)
endfunction

function! s:fuzzy2(items, Display)
    let items = a:items
    let s:Display = a:Display

    let key = a:0 >= 1 ? a:1 : ''
    let c = 0
    let input = ''
    let message = s:exists(key) ? ' for key: ' . key : ''
    ec 'start of fuzzy find' . message
    ec 'begin typing a char'
    ec 'there are ' . len(items) . ' items'
    ec 'first 9 items are:'
    function! s:show(items)
        call s:numbered(map(copy(a:items[0:8]), {i, x -> s:Display(x)}))
    endfunction
    call s:show(items)
    let temp = []

    let ch = ''
    let solre = 0
    while c < 30
        try
            let ch = s:getchar()
        catch
            return 
        endtry
        if ch == "\<BS>"
            let input = ''
            let temp = items[0:10]
            call s:print_list(temp, 10)
            continue
        elseif ch == '\\'
            ec 'toggling solre, resetting input'
            let solre = solre ? 0 : 1
            let input = ''
            continue
        elseif s:is_number(ch)
            return temp[ch - 1]
        elseif ch == "\<CR>"
            return temp[0]
        else
            if ch == '-'
                let ch = '_'
            endif
            let input .= ch
            throw 'hi'
            let temp = matchfuzzy(items, input, {key: 'file'})
            if solre
                let temp = filter(temp, 's:t(v:val.file, ''^'' . input)')
            endif
            call sort(temp, {a,b -> a. - b.timestamp})
            call s:show(temp)
            ec ''
            ec input
        endif
    endwhile
endfunction
function! Foo()
    return VT('$lnum')
endfunction
function! ChooseFunc()
    let r = g:jspyref3[&filetype].function_name_re
    let r = s:replace(r, '^\^', '\n')
    let bindings = s:unique(s:findall(s:get_page_text(), r))
    return s:fuzzy(bindings)
endfunction
let g:jspyref3["vim"]["function_name_re"] = '^function!? (\w+)'
let g:jspyref3["typst"]["function_name_re"] = '^let ([\w-]+)\('
let g:jspyref3['python']['function_name_re'] = '^def (\w+)'
let g:jspyref3["javascript"]["function_name_re"] = '^%(async )?function\*? +\zs(\w+)'

function! CapitalHelpNotes()
    let name = GetBindingName()
    call OpenBuffer3(GetLangNoteFile())
    return s:execute_regex('\[' . name, 0, 0, 1)
endfunction

function! s:map(items, r)
    let items = a:items
    let r = a:r
    
endfunction
function! UseLastTouchedRawFile()
    let file = MostRecentFile(s:regexfilter(v:oldfiles, 'raw$'))
    return file
endfunction
function! SetGConfigRawFile()
    call GSET('last_touched_raw_file', UseLastTouchedRawFile())
endfunction
function! GSET(a, b)
    let a = a:a
    let b = a:b
    ec ['SETTING g:config', a, b]
    let g:config[a] = b
endfunction
function! SystemChain(items)
    for item in items
        let result = call(function('System3'), item)
        if !result
            ec item
            ec 'error occured during the system chain'
            return 
        endif
    endfor
    ec 'success for all items in the system chain!'
endfunction

function! SimpleShunt()
    let i = GetCodeIndexes()
    let lines = s:getlines(i)
    call AppendFile(GetTempFile(), lines)
endfunction


let g:fileRef["td.q15.math"]["node1"] = {"runtimeFile":"packageManager.js", 'argFile': '/home/kdog3682/2024/td.q15.math', 'version': '2', 'after': "call RunTypst('/home/kdog3682/2024-typst/src/clip.typ', 1)"}

function! QuoteTheLine(s)
    return DoubleQuote(a:s)
endfunction
function! s:jspy6(f, s)
    let f = a:f
    let s = a:s
 try
     let ft = s:get_file_type(f)
   	return g:jspyref3[ft][s]
 catch
     let error = v:exception
 endtry
endfunction

function! GoOverrideNodeFile()
    call OpenBuffer3(g:override_node_file)
endfunction
nnoremap gon :call GoOverrideNodeFile()<CR>
function! SetFileTypeJavascript()
    execute 'setlocal filetype=javascript'
endfunction

function! CssAutoEnter()
    " call input(string('hi'))
" 1701213817 /home/kdog3682/2023/temp.css
    let file = PrevFile()
    if Test(file, 'vue.raw')
        let r = '\s\zs\.\S+'
        let bindings = Map(s:unique(s:findall(s:get_page_text(file), r)), 'trim')
        " call input('bindings: ' . s:string(bindings))
        let b:classNames=bindings
    else
        call LoadCssDotNames()
    endif
endfunction
function! IsJavascriptFile(s)
    return Test(a:s, 'js$')
endfunction
function! CssDotCompletion(s)
    if !exists("b:classNames")
        " let names = filter(GetBufferNames(), 'IsJavascriptFile(v:val)')
        " let file = GetFZF(names)
        call LoadCssDotNames()
    endif
	return s:regexfilter2(b:classNames, a:s)
endfunction
function! LoadCssDotNames()
        let bindings = GetBindings()
        " ec printf('loading css dot names: %s of them', len(bindings))
        let b:classNames = bindings
endfunction


function! GoDatedNoteFile()
    let s = VT('/home/kdog3682/documents/notes/dated/$iso8601.txt')
    call OpenBuffer3(s)
    " return s
endfunction
function! GoEndOfFileAndNewline()
    normal! Go
    startinsert!
endfunction
nnoremap ednf :call GoDatedNoteFile()<CR>
nnoremap gen :call GoEndOfFileAndNewline()<CR>

function! SwapDashes()
    if !exists('b:swapped_dashes')
        let b:swapped_dashes = 0
    endif
    let a = 'inoremap <buffer> - -'
    let b = 'inoremap <buffer> - _'
    if b:swapped_dashes== 0
        execute a
    else
        execute b
    endif
    let b:swapped_dashes+= 1
    ec 'swapping dashes'
endfunction


function! DialogueBackslash()
    return DialogueLineFix()
endfunction

function! SetActiveDir()
    let dirs = s:unique(values(g:dirdict))
    let dir= s:fuzzy(dirs)
    let g:active_dir= dir
    ec 'setting g:active dir as: ' . dir
endfunction
let g:active_dir= '/home/kdog3682/2023/'


function! Booga()
    call Clip(s:redir('verbose nnoremap'))
endfunction

function! DialogueLineFix()
    let expr=  VT('normal! o$hr$cr$speaker$cr$cr')
    " return expr
    execute expr
    startinsert!
endfunction
function! GetNextSpeaker()
    let speaker = 'aaa'
	return 'speaker: ' . speaker
endfunction

function! GoGfgf(...)
    let key = a:0 >= 1 && !empty(a:1) ? a:1 : s:fuzzy(keys(g:gfgfdict))
    let [file, fnName, getMethod] = g:gfgfdict[key]
        " call input('[file, fnName, getMethod]: ' . s:string([file, fnName, getMethod]))
    call OpenBuffer3(file)
    call OpenFunction(fnName, getMethod)
endfunction

function! Entries(x)
    let x = a:x
    return IsObject(x) ? items(x) : x
endfunction
function! s:fuzzy2(base, display = 0)
    function! s:show(items)
        let n = 8
        let items = a:items
        if s:asDouble
            call s:print_list(map(items, 'v:val[1]'), n)
        else
            call s:print_list(items, n)
        endif
    endfunction
    let base = a:base
    let display = a:display
    let items = Entries(a:base)
    let s:asDouble= IsArray(items[0])
    if len(items) == 0
        throw 'no items'
    endif
    if len(items) == 1
        return items[0]
    endif
    let key = a:0 >= 1 ? a:1 : ''
    let c = 0
    let input = ''
    let temp = items[0:8]
    let message = s:exists(key) ? ' for key: ' . key : ''
    ec 'start of fuzzy find' . message
    ec 'begin typing a char'
    ec 'there are ' . len(items) . ' items'
    ec 'first 9 items are:'
    call s:show(temp)

    let ch = ''
    let solre = 0
    while c < 30
        try
            let ch = s:getchar()
        catch
            return 
        endtry
        if ch == "\<BS>"
            let input = ''
            continue
        elseif ch == '\\'
            ec 'toggling solre, resetting input'
            let solre = solre ? 0 : 1
            let input = ''
            continue
        elseif s:is_number(ch)
            return temp[ch - 1]
        elseif ch == "\<CR>"
            return temp[0]
        else
            if ch == '-'
                let ch = '_'
            endif
            let input .= ch
            let temp = matchfuzzy(items, input)
            if solre
                let temp = filter(temp, 's:t(v:val, ''^'' . input)')
            endif
            call s:show(temp)
            ec ''
            ec input
        endif
    endwhile
endfunction


function! WrapSelectionWithAbcDef(left, right)


    let a = getpos("'<")
    let b = getpos("'>")
    let a = a[2]
    let b = b[2]
    if b== a
        return 
    elseif b < a
        let c = b
        let b = a
        let a = c
    endif
    let s = getline('.')

    let left = a== 1 ? '' : s[0:a - 2]
    let middle = s[a - 1: b - 1]
    let right = strpart(s, b)
    let final = left . a:left . middle . a:right . right 
    " ec [left, middle, right]
    " return
    call setline('.', final)
endfunction

function! _ExpandSelection(line1, column1, line2, column2)
    let line1 = a:line1
    let column1 = a:column1 + 1
    let line2 = a:line2
    let column2 = a:column2

    let select_command = line1 . 'G' . column1 . '|'
    let select_command .= "\<C-V>"
    let select_command .= line2 . 'G' . column2 . '|'
    execute 'normal!' select_command
endfunction
function! SprawlLeft(r = ' ', dir = -1)
    let r = a:r
    let dir = a:dir
    let s = getline('.')
    let start = col('.')
    let c = 0
    while start > 0 && start < len(s)
        let start += dir
        let ch = s[start]
        if Test(ch, r) || ch== r
            let start -= dir
            if dir== -1
                return start
            endif
            break
        endif
    endwhile
    return start + dir
endfunction
function! ExpandSelectionByPattern(left = ' ', right = '$|\.(\w)@!| ')
    let left = a:left
    let right = a:right
    let a = line('.')
    let b = SprawlLeft(left, -1)
    let c = CharSprawl(right, 1)
    call _ExpandSelection(a, b, a, c)
endfunction

nnoremap <buffer> <leader>s :call ExpandSelectionByPattern()<CR>
function CharSprawl(r = ' ', dir = -1)
    let r = a:r
    let dir = a:dir
    let s = getline('.')
    let start = col('.')
    let text = strpart(s, start)
    let i= match(text, '\v' . r)
    if i== -1
        throw 'no found -1'
    endif
    return i + start
endfunction

function! TextColon()
    
endfunction
function! ChangeTxfExt(state)
    let files = a:state.lines
    let ext = 'txf'
    call Prompt(files, 'do you wish to change these files extensions to ext?')
    call map(files, 'ExtensionChanger(v:val, ext)')
endfunction
function! FileParts(s)
    let s = a:s
    
endfunction
function! ExtensionChanger(file, ext)
    let file = a:file
    let ext = a:ext
    let next = AddExtension(RemoveExtension(file), ext)
    call s:move_file(file, next)
endfunction
let g:visualactiondict['txf'] = {'fn': 'ChangeTxfExt', 'file': 'vimConnector.js', 'version': 3, 'i': 'ibmContiguous', 'arg': 'contiguous', 'mapfilter': 'GetFileFromLine2', 'replacer': 1}

function! RepeatedCharSprawl(n, r)
    let n = a:n
    let r = a:r
    let s = getline('.')
    let start = getpos('.')
    ec start
    call input('start: ' . s:string(start))
    let c = 0
    while c <= n
        let c += 1
        let text = strpart(s, start)
        call input('text: ' . s:string(text))
        let i= match(text, '\v' . r)
        call input('i: ' . s:string(i))
        if i > -1
            let start = i
        endif
    endwhile
    return start
endfunction
function! VHighlight(n)
    "test: 3
    ec getpos('.')
    return 
    let n = a:n
    let a= line('.')
    let b = col('.')
    call input('b: ' . s:string(b))
    let b = SprawlLeft(' ', -1)
    let c = RepeatedCharSprawl(n, ' ')
    call _ExpandSelection(a, b, a, c)
endfunction

function! ToggleGConfig()
    try
        let key=  s:fuzzy(keys(g:config))
        if key == "null"
            let key = g:config.last_key
        endif
        let g:config.last_key = key
        call Setter2(g:config, key, s:opposite(g:config[key]))
    catch
        return
    endtry
endfunction
function Setter2(ref, k, v)
    let ref = a:ref
    let k = a:k
    let v = a:v
    let ref[k] = v
    ec printf('setting g:config.%s as %s', k, v)
endfunction

" booga
function! ExtractVarAndMoveUp()
	let left = col('.') - 1
    let [a,b] = SplitAtIndex(left)
    let name = Prompt('choose a name')
    if empty(name)
        let name = s:match('\w+')
    endif
    let up = s:fliup('^\S') - 1
    call setline('.', a . name)
    call append(up, VT('const $1 = $2', name, b))
endfunction
function SplitAtIndex(i)
    let i = a:i
    let s = getline('.')
    return [s[0:i - 1], s[i:]]
endfunction

function! ChooseMultiple(items)
    let items = a:items
    call BlueList(items)
    let inputs = Prompt('space delimitered 1-indexed inputs please')
    let inputs = s:xsplit(inputs)
    if empty(inputs)
        return 
    endif
    call map(inputs, 'items[v:val - 1]')
    return inputs
endfunction
function! Boopa()
    let a= ChooseMultiple(g:lineEditCommands)
    let t=  'call add(g:lineEditCommands2, "$1")'
    call map(a, 'VT(t, v:val)')
    call insert(a, 'let g:lineEditCommands2 = []')
    call append('$', a)
endfunction

let g:lineEditCommands2 = []
call add(g:lineEditCommands2, "SwapQuotes")
call add(g:lineEditCommands2, "SwapLambdaOrFunction")

function! CreateOutsideRef(state)
    let state = a:state
    let lines = state.lines
    let up = s:fliup('^\S') - 1
    call insert(lines, VT('const $ask = {'))
    call add(lines, '}')
    call append(up, lines)
endfunction
let g:visualactiondict['cor'] = {'fn': 'CreateOutsideRef'}

function! ChooseOption(mode, opts, desc)
    let mode = a:mode
    let opts = a:opts
    let desc = a:desc
    ec 'choose an option for: ' . mode
    ec 'desc: ' . desc
    ec 'the fallback is: ' . opts[0]
    ec ''
    let choice = OneKeyPressChoose(opts)
    if s:exists(choice)
        return choie
    endif
    return opts[0]
    
endfunction
function! OneKeyPressChoose(opts)
    let opts = a:opts
    call BlueList(opts)
        let ch = s:getchar()
        if IsNumber(ch)
            return opts[ch - 1]
        endif
endfunction
function! GenerateAdvancedComponentFile()
    let mode = ChooseOption("mode", ['advanced', 'partials'], "
        \\n advanced creates advanced-components.js
        \\n partials creates partials-components.js
        \\n
        \\n A FILE will be written.
    \")

    let outpath = "/home/kdog3682/2024-javascript/vuekit/advanced-components.js"
    let dir = "/home/kdog3682/2024-javascript/vuekit/components"
    let template=  'import { $1 } from "./components/$1.js"'

    if mode == "partials"
        let outpath = "/home/kdog3682/2024-javascript/vuekit/partials-components.js"
        let dir = "/home/kdog3682/2024-javascript/vuekit/partials"
        let template=  'import { $1 } from "./partials/$1.js"'
    elseif mode == 'advanced'
        let outpath = "/home/kdog3682/2024-javascript/vuekit/advanced-components.js"
        let dir = "/home/kdog3682/2024-javascript/vuekit/components"
        let template=  'import { $1 } from "./components/$1.js"'
    endif

    let names = Globber(dir)
    let r = '(\w+)\.js$'
    call map(names, 's:match(v:val, r)')
    let imports = map(copy(names), 'VT(template, v:val)')
    let exports = map(copy(names), '"    " . v:val . ","')
    call add(exports, '}')
    call insert(exports, 'export {')
    let lines = imports + [''] + exports
    call WriteFile(outpath, lines)
endfunction
function! RunRust()
        let a = expand('%:p')
        let b = a[:-4]
        let template = printf("!clear; rustc %s; %s;", a, b)
        execute template
endfunction


function! FTEF_Css_CommentSlash()
    if len(trim(getline('.'))) == 0
        return "/*  */\<LEFT>\<LEFT>\<LEFT>"
    endif
    return '/'
endfunction

function! AppendUp(s)
    let s = a:s
    let up = s:fliup('^\S') - 1
    call append(up, s)
endfunction
function! CssNote(s)
    let s = VT('/* $1 */', a:s)
    call AppendUp(s)
endfunction

function! CssBlockComment()
endfunction


function! UtilJSImportStringFiltered(...)
    let imports = GetImports()
    let file = a:0 >= 1 && s:exists(a:1) ? FileGetter2(a:1) : '/home/kdog3682/2023/utils.js'
    let items = GetExports(file)
    let existing = GetBindings() + imports
    " call input('existing: ' . s:string(existing))
    let items = FilterList(items, existing)
    let imports = join(items, ', ')
    let com = '/* deno-fmt-ignore */ '
    let import_path = file
    return s:templater(com . 'import {$1} from "$2"', [imports, import_path])
endfunction

let g:wpsnippets2["javascript"]["sss"] = "UtilJSImportStringFiltered"

function! GetBindings(file = 0) abort
    let file = empty(a:file) ? CurrentFile() : a:file
    let filetype = s:get_file_type(file)
    let r = g:jspyref3[filetype]['binding_re']
    let s = s:get_page_text(file)
    let matches = s:findall(s, r)
    return Map(s:unique(matches), 'trim')
endfunction

let g:jspyref3['vim']['binding_re'] = '%(\n|^)function!? (\w+)'
let g:jspyref3['python']['binding_re'] = '%(\n|^)%(class|def) (\w+)'
let g:jspyref3['javascript']['binding_re'] = '%(\n|^)%(class|const|%(async )?function\*?) (\w+)'
let g:jspyref3['css']['binding_re'] = '%( |\n)\zs(\.\S+)'
let g:jspyref3['typst']['binding_re'] = '%(\n|^)#let +(\w+) *\='
let g:jspyref3['vue']['binding_re'] = ''

function! FilterList(list_a, list_b)
  return filter(a:list_a, {idx, val -> index(a:list_b, val) == -1})
endfunction
let g:jspyref3["vim"]["workspace_file"] = ""
let g:jspyref3["python"]["workspace_file"] = ""
let g:jspyref3["javascript"]["workspace_file"] = "/home/kdog3682/2023/workspace.js"
function! Skjdfhsdjhfk()
    let input = 'abc'
    let items = ['a', 'b', 'aaaabc']
    return matchfuzzy(items, input)[0:5]
endfunction

function! RunDeno(file)
    let file = a:file
    let cmd = '!clear;' . g:deno_expression . ' ' . file
    execute cmd
endfunction
function! FileIsFrom(from)
    "test: vimdir
    let from = a:from
    let file = CurrentFile()
    return Test(file, 'downloads')
    let dir = get(g:dirdict, from, from)
    " if
endfunction
function! BaseExec(shell, ...)
    "test: 'node', '/home/asdf', '#*& boo./ga//'

    let args = SuperFlat(a:000)
    let shell = a:shell
    let [a, b] = SplitOnce(args)
    if shell== 'node' && g:config.use_deno && !FileIsFrom('dldir')
        let shell= g:deno_expression
    endif
    if Exists(b) && Test(b[1].file, 'template.js')
        let shell= g:deno_expression
    endif
    let args = map(copy(b), "ShellEscape(s:encode(v:val))")
    let cmd = '!clear; %s %s %s'
    let cmd = trim(printf(cmd, shell, a, join(args, ' ')))
    if g:debug || g:config.debug_shell_cmd
        ec '::currently in debug mode::'
        ec cmd
        return 
    endif

    if g:config.use_system
        let results = systemlist(cmd)
        " call InputPrompt('results', results)
        let result = s:goto_shell_error(results)
        return results
    endif
    try
        execute cmd
        return 1
    catch
        let error = v:exception
        ec error
        return 0
    endtry
endfunction

function! GetDir1111()
    let f = CurrentFile()
    return IsFile(f) ? Head() : f
endfunction
function! AddEntryToDirDict(...)
    let dir = a:0 >= 1 && Exists(a:1) ? a:1 : GetDir1111()
    let name = Prompt("choose a dirdictalias for " . dir)
    call DictSetter("g:dirdict", name, dir)
endfunction


function GetImports(file = 0) abort
    let file = empty(a:file) ? CurrentFile() : a:file
    let filetype = s:get_file_type(file)
    let r1 = g:jspyref3[filetype]['import_re1']
    let r2 = g:jspyref3[filetype]['import_re2']
    let s = s:get_page_text(file)
    let matches = s:findall(s, r1)
    " call input('matches: ' . s:string(matches))
    let results = s:unique(Flat(map(copy(matches), {i, x -> s:findall(x, r2)})))
    " call input('results: ' . s:string(results))
    return results
endfunction


let g:jspyref3["vim"]["import_re1"] = ""
let g:jspyref3["python"]["import_re1"] = ""
let g:jspyref3["javascript"]["import_re1"] = 'import \{(.{-})\}'
let g:jspyref3["javascript"]["import_re2"] = '\w{3,}'
let g:jspyref3["typst"]["import_re1"] = ""
let g:jspyref3["html"]["import_re1"] = ""
let g:jspyref3["css"]["import_re1"] = ""

" boogaw

" ExportDict

function! GoGfgf(key = 0)
    let key = a:key
    function! Inner(func)
        let func = a:func
        let m= Find(s:data, {x -> x.func == func})
        call OPEN(m.file)
        call s:open_function(m.func)
    endfunction
    let s:data = ReadVimJSON('gfgflist')
    if s:exists(key)
        call filter(s:data, 'get(v:val, "alias", "") == key')
        if len(s:data)== 1
            let m= s:data[0]
            call OPEN(m.file)
            call s:open_function(m.func)
            return 
        endif
    endif
    let source = map(copy(s:data), 'v:val.func')
    call fzf#run(fzf#wrap({'source': source, 'sink': function('Inner')}))
endfunction

function! AppendVimJSON(key, value)
    "test: 'fvf', {"avvavvvlbbaaacd":1} 
    "test: 'fvf', [{'a': 123}]
    let key = a:key
    let value = a:value
    let file = printf('/home/kdog3682/.vim/ftplugin/assets/%s.vim.json', key)
    let data= IsArray(value) ? [] : {}
    try
        let prev = ReadJson(file)
        " ReadVimJson('fvf')
        if type(prev) >= 4 || prev != v:none
            let data = prev
        endif
    catch
        ec v:exception
        call input(json_encode({"data": data, "vlaue": value}))
    endtry
    call extend(data, value)
    call WriteJson(file, data)
    return data
endfunction
function! ReadVimJSON(key)
    let key = a:key
    let file = printf('/home/kdog3682/.vim/ftplugin/assets/%s.vim.json', key)
    call AssertFile(file)
    return ReadJson(file)
endfunction



function! VimExecRef2Runner()
    function! Inner(func)
        let func = a:func
        call function(func)()
    endfunction
    let s:data = values(g:execRef2)
    call fzf#run(fzf#wrap({'source': s:data, 'sink': function('Inner')}))
endfunction
function! DenoFormat()
    let a= '--indent-width=4 --no-semicolons --line-width=75'
    execute '!clear; deno fmt ' . a . ' ' . CurrentFile()
endfunction

function! GetFiletype(s)
    let s = a:s
    return s:get_file_type(s)
endfunction



function! s:print_quote(s, arg)
    let s = a:s
    let arg = a:arg
    ec s . ': ' . s:doublequote(arg)
endfunction

function! PreviewVueJS()
    let m= '/home/kdog3682/2024-javascript/generated/apps/previewVueComponentViaTextFlow.js'
    call DenoFileRunner(m)
endfunction
function! DenoJavascriptAppRunner(...)
    function! Callback(s)
        let s = a:s
        let dir = '/home/kdog3682/2024-javascript/generated/apps/'
        let module_file = PathJoin(dir, s.file)
        call DenoFileRunner(module_file, {'state': s})
    endfunction

    function! Display(s)
        let s = a:s
        return s.desc
    endfunction
    call FzfCallback('/home/kdog3682/2024-javascript/generated/apps/index.json')
endfunction

let  g:deno_file= '/home/kdog3682/2024-javascript/nodekit/denoFileRunner.js'
function! DenoFileRunner(module_file = 0, state = {})
    let module_file = a:module_file
    let s:state = a:state

    function! _DenoFileRunner(module_file)
        let module_file = a:module_file
        let state = GetVimState3(s:state)
        call SystemExec(g:deno_file, module_file, state)
    endfunction

    if Exists(module_file)
        return _DenoFileRunner(module_file)
    endif
    let source = 'find $(pwd) -regextype posix-extended -type f | grep -vE ''(fonts|\.git|node_modules|\.log$|temp|package|__pycache)'''
    call fzf#run(fzf#wrap({"dir": "/home/kdog3682/2024-javascript/", 'source': source, 'sink': function('_DenoFileRunner')}))
endfunction

function! GetVimState3(state = {})
    let state = a:state
    let file = get(state, 'file', CurrentFile())
    let lineNumber = getbufinfo(file)[0].lnum
    let filetype = GetFiletype(file)
    let tail = Tail(file)

    let data = {
        \'file': file,
        \'filename': tail,
        \'name': RemoveExtension(tail),
        \'lineNumber': lineNumber,
        \'lnum': lineNumber,
        \'filetype': filetype,
        \'dir': Head(file),
        \'state': get(state, 'state', {}),
    \}
    return data
endfunction
function! GetLongExtension(file)
    let file = a:file
	return Match(Tail(file), '\.\zs\S+')
endfunction


function! FZF_FindExecRefFunction()
    let source = values(g:execRef2)
    call FzfCallback(source, 'FindVimFunctionInVimFiles')
endfunction

function! FZF_Bookmark()
    
endfunction
function! FindFunctionViaImports(name)
    let name = a:name
    if &filetype != 'javascript'
        return 
    endif
    let r = printf('<%s>', name)
    let current = line('.')
    let index = s:fli(r, 0, 1, current - 1, 0)
    let file = GetFileFromLine2(getline(index))
    if s:exists(file)
        call s:open_file_open_function(file, name)
    endif

endfunction
function! s:open_file_open_function(file, name)
    let file = a:file
    let name = a:name
	call OpenBuffer(file)
    call s:open_function(name)
endfunction

function! WriteVimJSON(key, value)
    "test: 'fvf', {"avvavvvlbbaaacd":1} 
    "test: 'fvf', [{'a': 123}]
    let key = a:key
    let value = a:value
    let file = printf('/home/kdog3682/.vim/ftplugin/assets/%s.vim.json', key)
    call WriteJson(file, value)
    return
endfunction
function! TypstFormat()
    let s= 'typst'
    execute g:typstfmt_expression . CurrentFile()
endfunction

function! WatchTypst()
    let myfile = '/home/kdog3682/2024-typst/src/foo.typ'
    let ref = {'myfile': myfile, 'ext': 'pdf'}
   let s = VT('!clear; typst watch $myfile /home/kdog3682/2023/test.$ext; ', ref)
   " let s= '!clear;'
   execute s
endfunction

"    '/home/kdog3682/.vim/ftplugin/functions.vim',
let g:dirdict.ftp = "/home/kdog3682/.vim/ftplugin/"
let g:dirdict.nvim = "/home/kdog3682/.config/nvim"
let g:dirdict.bu = "/mnt/chromeos/GoogleDrive/MyDrive/BACKUP/"

function! ConstantlyCallJavascript()
    let g:config.use_system= 1
    return SystemExec('foobar.js')
endfunction


function! FlatCall(...)
	let args = SuperFlat(a:000)
    return call(function(args[0]), args[1:])
endfunction

function! GetDateOfLastFileTouch()
    echo strftime('%c', getftime(expand('%')))
endfunction
let g:ignore_overrides = []


function! ToggleUnderscore(a = 0)
    if exists('g:underscore') && g:underscore ==  1
        inoremap <buffer> _ _
        inoremap <buffer> - -
        let g:underscore = 0
    else
        let g:underscore = 1
        inoremap <buffer> - _
        inoremap <buffer> _ -
    endif
endfunction
let g:dirdict.github = "~/GITHUB/"
function! GREP(r)
    let dir = '/home/kdog3682/sample-directory'
    let dir = '/home/kdog3682/2024-javascript'
    let ref = [a:r, dir]
    let cmd = s:templater('grep -HrEn "$1" $2 --exclude-dir={git,node_modules, lib}', ref)
    let res = systemlist(cmd)
    call Clip(res)
endfunction


function! GitPushAlan()
	
  call GitCommandWrapper("
        \\n cd ~/projects/alanmath
        \\n git add .
        \\n git commit -m 'test'
        \\n git push
  \")
endfunction

function! ClearBufs()
    bufdo bd
endfunction

function! ReplaceQuotes(s)
    let s = a:s
    return s:sub(s, '''', '"')
endfunction
function! Gcf()
  let arg = s:smartdedent(s:getlines('belowCursor', 'd'))
  let arg=  join(map(arg, "VT(\"-m '$1'\", ReplaceQuotes(v:val))"), ' ')
  call GitCommandWrapper("
        \\n cd $gitdir
        \\n git add $gitfile
        \\n git commit $1
  \", arg)
endfunction

function! Gcs(arg)
  call GitCommandWrapper("
        \\n cd $gitdir
        \\n git add $gitfile
        \\n git commit -m '$1'
  \", a:arg)
endfunction


function! SetupShellCommandArgs(shell, file, ...)
    let args = map(copy(a:000), "ShellEscape(s:encode(v:val))")
    let cmd = '%s %s %s'
    let cmd = trim(printf(cmd, a:shell, a:file, join(args, ' ')))
    return cmd
endfunction

function! Test123()
    return SetupShellCommandArgs('sdf', 'vv', {'a': 1})
endfunction


function! VShunt4(s)
    let s = a:s
    if s:exists(s)
        let lines = split(s, "\n")
    call add(lines,'_________________________________')
    call add(lines,'')
    call s:appendfile(file, lines)

    endif
    let file = VT('/home/kdog3682/documents/notes/dated/$iso8601.txt')
    let lines = s:getlines("contiguous", 'd')
    " call input(string(lines))
    call add(lines,'_________________________________')
    call add(lines,'')
    call s:appendfile(file, lines)
endfunction


" hi MyCustomColor ctermfg=White ctermbg = Black
" hi MatchParen ctermbg=0

" hi ExclamationLine ctermbg=0 guifg = Black ctermfg = White


function! WindowWords()
    let lines = s:getlines('window')
    let text = s:joinlines(lines)
    let words = filter(s:unique(s:get_words(text)), 'len(v:val) > 5')
    return words
endfunction
function! SetGCFW()
    let word = s:choose(WindowWords())
    ec ["word", word]
    let g:current_function_word = word
endfunction
function! InsertFunctionWordExpr()
    let word = g:current_function_word
    " abc(
    if VimTextStateObject().front.is("(")
        return word
    endif
    return word . "()\<LEFT>"
endfunction
let g:execRef2["sgcw"] = "SetGCFW"

function! RunJavascript(file, fnKey, ...)
    let vimState = GetVimState("libraryFile")
    let block = EvaluateFromShell('node', file, fnKey, vimState, a:000)
    return json_decode(block[0])
endfunction
function! LoadLibrary()
    let result = RunJavascript('connect.js', 'LoadLibrary')
    return result.value
    if !exists('b:lib')
        if result.success
            let b:lib = result.value
        else
            return 
        endif
    endif
    return b:lib
endfunction

function! GetLibraryItem2()
    let lib = LoadLibrary()
    if empty(lib)
        ec 'no library'
        return 
    endif
    let item = FuzzyFindDictionary(lib)
    let text = IsString(item) ? item : item.text
    let lines = WrapLines(s:tolines(text))
    call append('$', lines)
endfunction

function FuzzyFindDictionary(ref)
    let ref = a:ref
    let key = s:fuzzy(keys(ref))
    let value = ref[key]
    return value
endfunction
function! GetVimState(...)
    let lineNumber = line('.')
    let file = CurrentFile()
    let filetype = &filetype
    let tail = Tail(file)
    let data = {
        \'file': file,
        \'line': getline(lineNumber),
        \'filename': tail,
        \'name': RemoveExtension(tail),
        \'lineNumber': lineNumber,
        \'lnum': lineNumber,
        \'filetype': filetype,
        \'dir': Head(file),
    \}
    for i in range(a:0)
        let key = a:000[i]
        let value = s:jspy(key)
        if s:exists(value)
            let data[key] = value 
        endif
    endfor
    return data
endfunction

inoreab <buffer>ln lineNumber<C-R>=Eatchar('\s')<CR>
let g:execRef2["gli"] = "GetLibraryItem"
let g:wpsnippets2["python"]["s"] = "s = \"\"\"\n    $c\n\"\"\""
let g:wpsnippets2["python"]["ifname"] = "if __name__ == \"__main__\":"
nnoremap eeu :call OpenBuffer4('/home/kdog3682/PYTHON/utils.py')<CR>
nnoremap  <silent> eev :call OpenBuffer4('/home/kdog3682/.vim/ftplugin/vimrc.january2024.vim')<CR>
let g:filedict["lu"] = "/home/kdog3682/2023/lezer-utils.js"

nnoremap eelf :call OpenBuffer4('/home/kdog3682/2023/lezer-functions.js')<CR>

" hi Error ctermfg=black guifg=black
" hi Error ctermfg=White ctermbg=Red guifg=White guibg=Red

" #C6C7C811 : cursor color


function Redirect2(s)
    redir => currentMappings
    silent! execute a:s
    redir END
    return currentMappings
endfunction
function! Fooba()
    return AppendBottom(Fuzzy(ToLines(Redirect2('hi'))))
endfunction
function! Colorize()
    " hi MatchParen ctermbg=DarkGray
    " hi MatchParen ctermbg=White
    " asd (asdasd)
endfunction

let g:active_files = []
function! SetActiveFile()
    call add(g:active_files, CurrentFile())
endfunction

function! GoActiveFile()
    let file = GetLast(g:active_files)
    call OpenBuffer3(file)
endfunction
let g:execRef2["gaf"] = "GoActiveFile"

nnoremap ez :call GoActiveFile()<CR>
let g:wpsnippets2["javascript"]["ifnot"] = "if (!$1) {\n    $1 = $2\n}"
let g:linkedBufferGroups["processCallables.js"] = "rewrite.template.js"
let g:linkedBufferGroups["rewrite.template.js"] = "processCallables.js"

let g:linkedBufferGroups["lezer-testing.january.js"] = "l.env.js"
let g:linkedBufferGroups["l.env.js"] = "lezer-testing.january.js"

let g:wpsnippets2["javascript"]["templ"] = "const template = `\n    $c\n`"
let g:wpsnippets2["python"]["inf"] = "inform(\"\"\"\n    $c\n\"\"\")"


function! Seacha()
    execute ":Files <C-r>=expand('%:h')"
endfunction
let g:filedict["eed"] = "/home/kdog3682/2024/dump.txt"


function! LowercaseCurrentWord()
    " Save the current cursor position
    let l:save_cursor = getpos(".")

    " Move to the start of the current word, change it to lowercase, and go back to the end of the word
    normal! b
    let l:word = expand("<cword>")
    execute "normal! ciw" . tolower(l:word)

    " Restore the cursor position
    call setpos('.', l:save_cursor)
endfunction

" Bind the function to a key (e.g., <leader>l)
nnoremap <leader>l :call LowercaseCurrentWord()<CR>

function! Sdfswfwf()
     call ExportToJson('dirdict')
endfunction
let g:filedict["eed"] = "/home/kdog3682/2024/dump.txt"
nnoremap eed :call OpenBuffer4('/home/kdog3682/2024/dump.txt')<CR>
let g:linkedBufferGroups["runEvalFile.js"] = "eval.template.js"
let g:linkedBufferGroups["eval.template.js"] = "runEvalFile.js"

nnoremap etd :call OpenBuffer4('/home/kdog3682/2024/todo.txt')<CR>
nnoremap eef :call OpenBuffer4('/home/kdog3682/2024/functions.txt')<CR>


let g:lezer_functions = ["ExpressionStatement", "getLezerState", "traverse","Environment","traverseJson","findallChildNodes","jsonTraversal","stringBuilder","isContentNode","iterateTree","getChildNodes","findChildNode","viewTree","traverseBlue","getNameNode","getStatef"]
let g:wpsnippets2["javascript"]["ssa"] = "/* deno-fmt-ignore */ import {fooga, exprTemplater, stringifyIfNotPrimitive, panic, stringerf, wrapFunction, regexTemplater, iso8601, strftime, walkChildEntries, getFiletype, matchf, isUrl, looksLikeFunction, toArgument2, notNull, CumulativeStorage2, simpleAssign, findAndMatch, infuseObjectArray, regexGetter, splitArg, isJavascriptComment, runTest, everyOther, splitByRange, get_regex, getImports, isJavascriptFile, isValidDateString, WriteObject, equalityf, group2, splitOnce2, dedent4, isLowerCase, looksLikeRegExpString, isRegExpString, getDependencies, camelSplit, toggle3, countf, isLiteralObject, bindMethodsAndState2, call, mget3, looks_like_object_function, create_functions_from_master, toStringArgumentPretty, codeChunks, smart_map, run_tests, hasStartingCallable, mapTemplate, aliaser, fixSelector, htmlTags, removePythonComments, simpleStringBreaker, colonConfig, operations, error, redColon, so2, group, parseSingleLineJson, Items, findDependencies, tryf, find4, localeString, cssComment, colonConfigf, trimArray, parseCallable, bringToLifeTextFix, localBringToLife, getCaller4, getErrorStack, forEach, getBindings, getExports, matchstr, filter4, allEqual, count, isNativeFunction, repeat, getIndentAndText, StopWatch, stringDictSetter, getFunctionInfo, runRef, toLines, hasCallable, getProseWords, tally, paramify, codeSplit, debugConfig, logConfig, blueColon, toStringArgument3, stringCallable, simpleBinding, dashSplit4, appendBelow, appendAbove, removeLineComments, prependIfNecessary, smartDedent4, blueSandwich, walk4, findLineIndex, parseAB, applyTransform, kebabCase, getExcerpt, sortObject, buildFunction, maybeSort, parseFunction, isTypable, frontMatter, dictEntry, insertAfterIndex, State, bindMethods, cpop, tagRE, toggle2, createFunction2, assignIncrementedIndex, ufa, assignArray, regexFromComment, createParsersFromObject, imatch, globalConsoleDebug, bindMethodsAndState, isQuestion, oxfordComma, isUpperCase, getFunctionIdentifier, filter3, match, getMatch, alternatef, reCombine, assertion2, deepEqual, hasDollar, so, deepAssign, Tally, getFunctionNames, throwError, notEqual, tryString, prettyPrintCodeSnippet, prettyPrintErrorStack, iter, quotify, transformerf, assign, defineBinding, jspy, linebreak, stringCall2, reduce3, getClassParameters, assignOnTop2, isIdentifier, ndy, dashSplit3, runFunctionFromRef, equalf, alphabet, stateGetterFromSchema, mreplace, require, topLineComment, isChinese, replacef, ignoref, codeLibrary, splitLines, addArgumentQuotes, getBindings2, addCaret, mget2, getStartingConfig, incrementalEat, strlen, hr, setOnce, unescapeHtml, oxford, breakerf, runTests, map3, dateSplit, transformDict, walk3, toRegExp, tryAgainf, assertNotNull, getArgumentObject, isArgumentObject, typef, requireArg, keyAndValue, assignf, stateGetter3, objectFromArguments2, assignDefaults, transformValue, assign3, assignFresh3, evaluate3, scopedEvaluator, objectFromArguments, enforce, sub, filterObject, extractStartingJsonLikeConfig, unbrackify, newlineIndent2, deleteLine, both, normalizeIndent, getComment, secondComment, isStringRegExp, dashSplit2, clock, warning, errorStringify, alert, labelCase, bottomComment, stringCompose, getAnyIdentifier, chalkf, getNumbers, partitions, has, addUnit, toCallable, unquote, filter2, warn2, join2, caller2, assignOnce, longShort, shortLong, argPop, caller, assignOnTop, toggle, defineWindow, unescapeNewlines, escapeQuotes, unescapeQuotes, escapeNewlines, setAliases, announceCaller, removeStartingComments, smartBind, assignExisting, isObjectWithKey, eatStart, modularIncrementItem, getRegex, runFunction, isObjectLikeArray, itemGetter2, getAllKeys, prefixSlice, hasQuotes, assertion, diff, toggleState, initState, dunder, objectGetter, superTransform, popFilter, testRunner, assert2, insertAtDollar, popEmptyLine, getOptions, mergeSpecs, sortByKeys, map2, strictMessengerAssert, smartSplit, chalk4, typeLog, getFunctionName, Clock, search3, MyError, fuzzyMatch3, debugDisplay, getCaller3, messengerAssert, camelSlice, setPrototype, assignAliases, display, modifyNumber, toDict, setPush, modularIncrementIndex, longstamp, popIndex, toggleOnOff, locWrap, walk2, typeMatch, prettyStringify, getIdentifiers, CustomError, argMatch, brackify2, smartestDedent, modularIncrementNumber, AbstractMethodError, allUnique, Trie, boundarySplit, numberBoundarySplit, nodeLog, getFirst, defineProperty, supermix, partial, timeLog, timestamp, raise, getIdentifier, conditionalPrefix, conditionalSuffix, QueryList, fuzzyMatch2, buildDict, getTextAndCommand, sprawlFactory, getParameters2, pushf, intersection, union, blue, green, sandwich, getLastSpaces, smartDedent3, red, sort, debounce, checkValue, getCodeChunks, logf, boundary, myError, conditional, isStringFunction, toSpaces, objectf, searchAll, difference, singleQuote, itemGetter, slice2, mergeObjects, once, dashSplit, nchalk, coerceToObject, ArrayState, exporter2, indent2, iterator, removeAllComments, countParams, cumulativeSchemaAssign, argKwargSplit, argParse, removeInlineComments, getFrontMatter, hasHtmlSuffix, lazyArray, isThisFunction, escapeHTML, getKwargs2, search2, toStringArgument, createFuzzyMatch, edit2, splice, zip, merge2, argArgsKwargs, fill2, chalk, vueWrap, splitArray, splitArray2, warn, makeRunner2, searchf2, smartDedent2, dedent2, toArray2, stateGetter2, sortByIndex, IndexedCache, argo, curry2, doUntil2, evaluate2, findall2, findIndex2, findItem2, getCaller2, getErrorStack2, isJson, indexGetter2, insert2, pop2, parseError2, remove2, reduce2, testf2, type2, unshift2, waterfall2, xsplit2, Cache, cumulativeAssign, replaceBefore, topComment, isAsyncFunction, mapSort, getFileURI, getQuotes, isClassObject, isInitialized, getFallback, bindingRE, addObjectOrObjectProperty, forDoubles, isCss, log, iterate, backAndForth, round, iteratorWrapper, toJSON, isFromMap, toString, empty, conditionalString, getConfigArg, hasKey, errorWrap, successWrap, check, toPoints, bind, mixinAliases, isPercentage, isBasicType, reducerStrategy, gather, entries, stateGetter, methodCase, vueCase, push2, smarterIndent, lineSplit, Store, isSingleLetter, prepareText, isSymbol, getShortest, slice, KeyError, deepCopy, argsKwargs, isError, isColor, list, objectEditor, matchall, makeFastRunner, announce, hasLetter, filter, reduce, stringCall, capitalizeName, stop, proseCase, lineDitto, mixinSetters, modularIncrement, distinct, definedSort, groupBy, reWrap2, fuzzyMatch, isPlural, Element, parseError, isPrimitiveArray, callableArgsKwargs, waterfall, defineVariable, info, flat2D, splitThePage, handleError, dedent, TypeAssertion, createFunction, pluralize, remove, Group, PageStorage, Storage, UniqueStorage, Watcher, arrayToDict, addProperty, addQuotes, argWrapFactory, assert, abrev, abf, addExtension, assignFresh, antif, atFirst, atSecond, backspace, bindObject, breaker, blockQuote, brackify, bringToLife, comment, countCaptureGroups, capitalizeTitle, classMixin, callableRE, camelToTitle, curry, createVariable, changeExtension, curryStart, curryEnd, capitalize, copy, camelCase, compose, char2n, camelToDash, deepMerge, datestamp, doublef, dictSetter, dictSetter2, dsearch, doUntil, dashCase, doubleQuote, dict, dictGetter, depluralize, dreplace, dictf, endsWithWord, exporter, edit, exists, evaluate, extend, find, flatMap, fill, fixUrl, functionGetter, findall, fixPath, flat, fparse, findIndex, firstLine, ftest, getKwargs, getFirstName, getBindingName, getParameters, getLastWord, getCodeWords, getCodeWords2, getIndent, getExtension, getLast, getLongest, getChunks, getCaller, getStackTrace, getConstructorName, getFirstWord, getWords, getSpaces, hasComma, hasSpaces, hasHtml, hasBracket, hasNewline, hasCaptureGroup, hasEquals, hasValue, hasCamelCase, hasNumber, hackReplace, insert, indexGetter, incrementf, isCallable, isQuote, isEven, isOdd, isLast, isHTML, isNode, interweave, inferLang, isString, isArray, isObject, isDefined, isFunction, isPrimitive, isNumber, isSet, isNestedArray, indent, isNull, isWord, isBoolean, isRegExp, identity, isObjectLiteral, isJsonParsable, isCapitalized, isNewLine, isObjectArray, isStringArray, isClassFunction, joinSpaces, join, keyArrayToObject, lowerCase, linebreakRE, len, lineGetter, lineCount, lastLine, logConsole, makeRunner, mixin, modularf, matchGetter, merge, mget, map, mergeOnTop, mergeToObject, mapFilter, noop, nestPush, no, newlineIndent, n2char, objectWalk, overlap, objectToString, opposite, pipe, parseTopAttrs, pascalCase, partition, parens, push, pop, parseJSON, rigidSort, removeQuotes, rep, removeComments, range, removeExtension, rescape, reverse, reWrap, reduceToString, repeatUntil, swapKey, sayhi, swap, splitMapJoin, splitCamel, smallify, search, stringify, shared, smartDedent, stringBreaker, sleep, split, snakeCase, stringArgument, sorted, splitOnce, searchf, secondLine, titleCase, textOrJson, toNumber, toArgument, toNestedArray, test, type, tail, transformObject, trim, testf, toArray, templater, totalOverlap, upperCase, unique, uncapitalize, unzip, wrap, walk, wrapf, xsplit, yes, zip2} from \"./utils.js\"\n/* deno-fmt-ignore */ import {componentManager, mdate, WriteFile, LogFile, vimFunctionConnector, tempFile, resolvePath, path2024, write2024, packageManager3, smart_path, createCodeString2, buildBindings2, JavascriptBuilder, ltf, appendVariable3, generateFile, generateImports, getStats, ff, createCodeString, finishConfig, findError2, onConfigStart, packageManager2, getFiles2, colonPackageManager, packageManagerSingletonRunColon, getText, packageManagerSingleton, oneArg, toVimVariable, headAndTail, absdir, getSection, sortByDate, dateTheFile, vimConnector, writeExportFile, pathJoin, jslib, pylib, backupFile, writeAndBackup, superFileGetter, submit, clipOrLog, fileGetter, toTimestamp, appendVariableFile, readParse, incrementalName, rfile, getJuneJson, isRecentFile, unmute, clip2, clip2 as c2, appendVariable2, moduleFunctionFactory, dirGetter, save, getRecentFile, fileOrText, logger, writeFromOptions, appendFileName, backup, getFiles, packageManager, mergeJson, fileFromKey, path, mergeFiles, writeUnitTest, runUnitTest, NodeError, isDir, NodeAssertion, sysArgs, sysArg, mute, abspath, getFile, logAction, head, getDir, dirFromPath, npath, textAndLang, shunt, sysget, append, prepend, currentFile, clip, isFile, normFileDir, normRead, normWrite, normAppend, normPrepend, normRpw, openFile, read, rpw, textGetter, write, getString, appendSelf, appendVariable, argv, exit, request} from \"./node-utils.js\"\n/* deno-fmt-ignore */ import {asciiTable, MatchParserHTML, LineEditor, ScopedEvaluator, MatchParser, csv, pythonic} from \"./next2.js\""

let g:filedict["lt"] = "/home/kdog3682/2023/lezer-getTree.js"
let g:filedict["glt"] = "/home/kdog3682/2023/lezer-getTree.js"


let g:fileRef["tests.js"] = {}
let g:fileRef["tests.js"]["linked6"] = "evaluator.js"
let g:fileRef["tests.js"]["node1"] = {"run":"evaluator.js","argFile":"tests.js"}

let g:execRef2["rp"] = "RunPython"
let g:wpsnippets2["javascript"]["st"] = "setTimeout(() => {\n    $c\n}, $1::100)"
let g:wpsnippets2["markdown"] = {}
let g:wpsnippets2["markdown"]["fm"] = "---\ntitle: $c\ndatetime: $datetime\n---"


function! WriteNotes6(s)
    """ 01-20-2024 
    """ the final iteration of write notes. 
    """ this time we do not edit the input at all.
    """ this time we do not enter the file at all. 
    """ it is a private dot file.
    """ the only thing we do is append timestamp.
    """ this file should never be looked at
    """ in the future, it will be parsed by chatgpt and turned into html
    try
        let value= VT(a:s)
        if empty(value)
            return
        endif
        let s = strftime('%s') . ' ' . value 
        call AppendFile('/home/kdog3682/2024/.notes.txt', s)
    catch
        let error = v:exception
        ec error
    endtry
endfunction
nnoremap <leader>w :call WriteNotes6("")<left><left>

let g:wpsnippets2["vim"]["doc"] = "\"\"\" ${DateStamp()}\n\"\"\" $c\n\"\"\" \n\"\"\" \n\"\"\" \n\"\"\" "
let g:filedict["fp"] = "/home/kdog3682/2023/fixProse.js"
let g:wpsnippets2["javascript"]["md"] = "```markdown\n\n$c\n\n```"
let g:filedict["vdoc"] = "/home/kdog3682/2023/vuetify2.doc.js"

let g:filedict["ft"] = "/home/kdog3682/2024/foo.typ"
function! RunPythonApps()
    " 01-23-2024 
    " let payload = getbufinfo('%')
    " let payload = {'a': 1}
    " let vim = {'file
    let vimState = GetVimState()
    " return vimState
    call NodeTerminalOrShell('run_apps.py', vimState)
endfunction
let g:execRef2["rap"] = "RunPythonApps"
let g:linkedBufferGroups["apps.py"] = "run_apps.py"
let g:linkedBufferGroups["run_apps.py"] = "apps.py"

let g:wpsnippets2["typst"]["cetz"] = "#import \"@preview/cetz:0.2.0\"\n#cetz.canvas({\n  import cetz.draw: *\n  ...\n})"
let g:wpsnippets2["typst"]["cetz"] = "#import \"@preview/cetz:0.2.0\"\n#cetz.canvas({\n  import cetz.draw: *\n  $c\n})"
let g:wpsnippets2["typst"]["auto"] = "#set page(width: 200pt, height: auto)"
let g:wpsnippets2["typst"]["imp"] = "import \"base-utils.typ\": *"
let g:wpsnippets2["typst"]["pan"] = "#panic($1)"
let g:filedict["bu"] = "/home/kdog3682/2024-typst/src/base-utils.typ"
let g:filedict["tt"] = "/home/kdog3682/2024-typst/src/template.typ"
let g:filedict["ut"] = "/home/kdog3682/PYTHON/utils.py"
let g:linkedBufferGroups["mmgg-morning-walk.typ"] = "jieba_script.py"
let g:linkedBufferGroups["jieba_script.py"] = "mmgg-morning-walk.typ"

let g:wpsnippets2["typst"]["measure"] = "style(styles => {\n    let measurement = measure($1, styles)\n    $c\n})"
let g:filedict["cj"] = "/home/kdog3682/2024/clip.json"


function! ChangeDirectoryBasedOnFilePath()
    " Get the full path of the current file
    let fullPath = expand('%:p')

    let dirs = []

    " Check if path starts with '~/'
    let homeShortcut = '~/'
    let homeDir = $HOME . '/'
    if fullPath[:len(homeShortcut) - 1] == homeShortcut
        let fullPath = substitute(fullPath, homeShortcut, homeDir, '')
    endif

    " Iterate through the path and construct the directory list
    while fullPath != '/' && fullPath != homeDir
        " Add the directory to the list
        let dirs = [fullPath] + dirs

        " Move up one directory
        let fullPath = fnamemodify(fullPath, ':h')
    endwhile

    " Show the list to the user and get the selection
    let idx = Choose(dirs)
    if idx > 0 && idx <= len(dirs)
        " Change the directory
        execute 'cd ' . dirs[idx - 1]
    endif
endfunction

" Map the function to the key '7' in normal mode
" nnoremap 7 :call ChangeDirectoryBasedOnFilePath()<CR>

let g:vimCurrentTestFunction = "InsertOW"
let g:linkedBufferGroups["manifest.json"] = "background.js"
let g:linkedBufferGroups["background.js"] = "manifest.json"

let g:linkedBufferGroups["world.js"] = "art.js"
let g:linkedBufferGroups["art.js"] = "world.js"


function! VimGrep()
    let dir = "/home/kdog3682/PYTHON/"
    let dir = "/home/kdog3682/2024-python/"
    let query = "timedelta"
    let cmd = printf('grep -r "%s" %s > grep.txt', query, dir)
    let value = systemlist(cmd)
    ec value
    " call AppendBelow('.', value)
endfunction


function! ZipDirectory(dirPath, zipLocation)
    let dirPath = a:dirPath
    let zipLocation = a:zipLocation 
    let cmd = 'rtar -czf ' . zipLocation . ' ' . dirPath
    " ec cmd
    " return
    let result = system(cmd)
    ec result
    if v:shell_error == 0
        echo "Directory zipped successfully to " . zipLoc
    else
        echoerr "Failed to zip the directory"
    endif
endfunction

" let file = '/home/kdog3682/2024-chrome-extensions/web-nanny/0.0.1/'
" let out = '/home/kdog3682/2024-chrome-extensions/web-nanny/0.0.1/package./'
" call ZipDirectory(file, out)



function! Sdfsdfjk()
    call GitPushDirectory('/home/kdog3682/2024-writing/')
endfunction

function! ResetGit()
    call GitCommand('git rm -r --cached .')
endfunction
let g:execRef2["rgi"] = "ResetGit"
let g:linkedBufferGroups["mathDialogueTransformer.js"] = "percent-more-percent-less.txt"
let g:linkedBufferGroups["percent-more-percent-less.txt"] = "mathDialogueTransformer.js"

let g:execRef2["temp"] = "SetVimSpeaker"


let g:execRef2["ivs"] = "InitializeVimSpeakers"
let g:execRef2["cds"] = "CreateDialogueSection"
nnoremap edt :call OpenBuffer4('/home/kdog3682/2024/dump.txt')<CR>
let g:filedict["lop2"] = "/home/kdog3682/2023/lazyObjectParser2.js"
let g:system_exec_ref = {}
let g:system_exec_ref["gs"] = "git status"
let g:system_exec_ref["gs"] = "GetGitFiles"
let g:execRef2["fs"] = "FindSnippet"
let g:execRef2["fah"] = "FindAnythingHandler"
let g:system_exec_ref["gca"] = "git commit -a -m \"$prompt\""
let g:execRef2["gitdiff"] = "GitDiff"
let g:execRef2["fgd"] = "FullGitDiff"
let g:execRef2["ga"] = "GitAddCurrentFile"
let g:filedict["tj"] = "/home/kdog3682/2024/tests.json"
let g:execRef2["gpcd"] = "GitPushCurrentDirectoryBasedOnMainFile"
let g:execRef2["fvf"] = "FVF"
let g:execRef2["glt"] = "GitLoremTest"
let g:execRef2["gpt"] = "GitProductionTest"
let g:execRef2["gpcf"] = "GitPushCurrentFile"
let g:filedict["ft"] = "/home/kdog3682/2024/file-table.txt"
let g:filedict["rt"] = "/home/kdog3682/2024-typst/src/render.typ"
let g:execRef2["cd"] = "CD"
let g:filedict["jv"] = "/home/kdog3682/.vim/ftplugin/javascript.vim"


" function RegexGetter()
    " return 1
" endfunction
function! VimTextStateObject(...)
    let number = line('.')
    let s = a:0 >= 1 ? a:1 : getline(number)
    let pos = col('.') - 1

    let back_ch = s[pos - 3]
    let current_ch = s[pos - 2]
    let next_ch = s[pos - 1]
    " call input(json_encode({"number": number, "s": s, "pos": pos, "back_ch": back_ch, "current_ch": current_ch, "next_ch": next_ch}))

    let front =  strpart(s, pos)
    let back = strpart(s, 0, pos)
    let trimmed = trim(s)
    let trimmedBack = trim(back)
    let trimmedFront = trim(front)
    let spaces = Match(s, '^ *')
    let ind = len(spaces)
    " @bookmark 1709331717 vto
    let data = {
        \"getset": {Fn -> setline(number, Fn(data))},
        \"match": {k -> Match(s, RegexGetter(k))},
        \"sub": {r, Fn -> Substitute(s, r, Fn)},
        \"replace_line": {payload -> ReplaceBlock(number, payload, 1)},
        \"set_line": {payload -> setline(number, Test(payload, '^ +') ? payload : spaces . payload)},
        \"replace": {x,y -> setline(number, Substitute(s, x, y))},
        \"empty": len(trimmed) == 0,
        \"line": {
         \   'text': s, 
         \   'trimmed': trimmed, 
         \   'spaces': Match(s, '^ *'), 
          \  'number': number, 
          \  'lnum': number, 
           \ 'length': len(s),
           \ 'has': {x -> Test(s, x)},
        \}, 
       \ 'char': {
        \    "pos": pos, 
         \   "prev": back_ch, 
          \  "current": current_ch, 
           \ "next": next_ch
        \},
        \'front': {
         \ 'empty': empty(trimmedFront),
         \ 'text': front,
         \ 'word': { -> Match(trimmedFront, '^[a-z]\w+$') },
         \ 'isword': { -> Test(trimmedFront, '^[a-z]\w+')},
         \'has': {x -> len(x) == 1 ? x == next_ch : Test(trimmedFront, x)},
         \ 'trimmed': trimmedFront, 
          \'test': {x -> Test(trimmedFront, x)},
          \'is': {x -> x == trimmedFront },
        \},
        \'back': {
         \ 'empty': empty(trimmedBack),
         \ 'isword': { -> Test(trimmedBack, '^[a-z]\w+$')},
         \ 'text': back,
         \ 'word': { -> Match(trimmedBack, '[a-z]\w+$') },
         \ 'trimmed': trimmedBack,
          \'test': {x -> Test(trimmedBack, x)},
          \'has': {x -> len(x) == 1 ? x == prev_ch : Test(trimmedBack, x)},
          \'is': {x -> x == trimmedBack },
        \},
        \'ind': ind,
        \'endswith': {x -> Test(s, x . '$')},
        \'startswith': {x -> Test(s, '^ *' . x)},
        \'has': {x -> Test(s, EscapeRegexEqual(x))},
        \'test': {x -> Test(s, x)},
        \'sosall': { -> Sosall(s)},
        \'gcw': { -> expand('<cword>')},
        \'first': { -> Match(s, '^\W*\zs\w+')},
        \'last': { -> Match(s, '\w+\ze\W*$')},
        \'deleteEndingSpaces': { -> BackspaceExpr(Match(back, '\S\zs *$'))}
    \}
    return data
endfunction


function! TypstMathSmartEqual()
" @bookmark 1707418745 TypstMathSmartEqual
    let state = VimTextStateObject()
    " ec state

    if state.endswith('[?<>!=] *')
        return state.deleteEndingSpaces() . "= "
    endif

    " if state.ind == 0
        " return g:keyboard.reset . '#let ' . state.line.text . g:keyboard.equals
    " endif

    return state.deleteEndingSpaces() . " = "
    return " = "
/home/kdog3682/2024/td.q15.math
    
endfunction
" @bookmark 1707418745 TypstMathSmartEqual
let g:wpsnippets2["javascript"]["fm"] = "---\n$c\n---"
let g:filedict["tclip"] = "/home/kdog3682/2024-typst/src/clip.typ"
let g:execRef2["cob"] = "CloseOldBuffers"

function! SmartEqual()

    " let o = "if (mode == 'debug' || mode) {"
    let state = VimTextStateObject()
    " return state

    " call input(string(state))
    " if state.endswith('[?<>!=] *')
        " if state.startswith('const')
            " return g:keyboard.delete_first_word . state.deleteEndingSpaces() . ' '
        " endif
        " return state.deleteEndingSpaces() . "= "
    " endif

    let prefix = JP('prefix')
    " ec input(state.startswith('if'))

    " @bookmark 1709331717 vto
    if state.startswith('(const|var|let|if|else|for|while|do)>')
        " call input(string(state.back.endswith('=')))
        " if state.back.test('\= *$')
            return state.deleteEndingSpaces() . "= "
        " endif
        return state.deleteEndingSpaces() . " == "
    elseif state.front.empty
   " call input(string(state.front.empty))
        let equal_dictionary_ref = JP('equal_dictionary')
        if has_key(equal_dictionary_ref, state.back.trimmed)
            let [before, after] = equal_dictionary_ref[state.back.trimmed]
            return g:keyboard.reset . prefix . before . ' = ' . after
        elseif state.startswith('(let)')
            return state.deleteEndingSpaces() . " = "
        elseif state.startswith('(const|var|let|if|else|for|while|do)>')
           " throw 's'
            " call input(string(state.back.endswith('=')))
            if state.back.endswith('=')
                return state.deleteEndingSpaces() . "= "
            endif
            return state.deleteEndingSpaces() . " == "
        elseif state.startswith('%([a-z]\w*$|[\[\{])') && !state.back.has(prefix)
            return "\<C-O>I" . prefix . "\<C-O>A = "
        else
            return ' = '
        endif
    elseif state.back.isword() && state.back.trimmed != prefix
        return g:keyboard.reset . prefix . state.back.trimmed . ' = ' . state.front.trimmed
    elseif state.endswith('[<>?=]')
        return state.deleteEndingSpaces() . "= "
    else
        return ' = '
    endif
endfunction

let g:keyboard.delete_first_word = "\<C-O>I " . g:keyboard.esc . 'v/ ' . g:keyboard.left . g:keyboard.enter . "d " . "\<C-O>A"



function! Substitute(s, r, replacement, ...)
    let flags = a:0 >= 1 ? a:1 : 'g'
    return substitute(a:s, '\v' . a:r, a:replacement, flags)
endfunction
function! EscapeRegexEqual(s)
    "test: ' = '
    let s = a:s
	return Substitute(s, '[={]', {x -> '\\' . x[0]})
endfunction

function! FindGetCommentsTextWithGrep()
endfunction


let g:denops_server_addr = '127.0.0.1:32123'
let g:denops#deno = '/home/kdog3682/.deno/bin/deno'
call plug#begin()
    Plug 'junegunn/vim-easy-align'
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
    Plug 'junegunn/goyo.vim'
    Plug 'https://github.com/AndrewRadev/simple_bookmarks.vim'

    if has('nvim')
      " Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
      " Plug 'vim-denops/denops.vim'
      " Plug 'vim-denops/denops-helloworld.vim'
      " Plug 'https://github.com/Shougo/ddc.vim'
    endif

    " needs a higher vim version to use these
    " Plug 'vim-denops/denops.vim'
    " Plug 'vim-denops/denops-helloworld.vim'

    " Plug 'jayli/vim-easycomplete'
    " Plug 'SirVer/ultisnips'
    " Plug 'https://github.com/msanders/snipmate.vim'
    " Plug 'https://github.com/drmingdrmer/xptemplate'
    " Plug 'https://github.com/tpope/vim-surround'
    " <plug>(fzf-maps-n)
    " Plug 'lifepillar/vim-mucomplete'
call plug#end()
syntax off




function! Goyo()
    Goyo
endfunction

function! WriteOldFiles()
    call WriteFile('/home/kdog3682/2024/oldfiles.txt', v:oldfiles)
endfunction
function! _AppendFileName(file, extra)
    let file = a:file
    let extra = a:extra
    return Head(file) . '/' . RemoveExtension(Tail(file)) . extra . '.' . GetExtension2(file)
endfunction

function! CopyFile(a, b)
     call system(printf('cp %s %s', a:a, a:b))
     return a:b
endfunction
function! VimFileStateObject()
    let payload = {}
    let filepath = expand('%')
    let dir = fnamemodify(filepath, ':h') . '/'
    let ext = fnamemodify(filepath, ':e')
    let tail = fnamemodify(filepath, ':t')
    let root = fnamemodify(filepath, ':r')
    let name = RemoveExtension(tail)
    if Empty(name)
        let name = tail
    endif
    function! Get_name_version(name)
        let name = a:name
        if Test(name, 'v\d')
            return 'v3'
        endif
        return 'v2'
    endfunction
    let payload['append_file_name'] = {x -> dir . root . x . Exists(ext) ? '.' . ext : ''}
    let payload['next_ver'] = { -> dir . name . '-' . Get_name_version(root) . (Exists(ext) ? '.' . ext : '')}
    let payload['dup'] = {x -> CopyFile(filepath, x)}
    let payload['open'] = {x -> OpenBuffer(x) }
    let payload['dir'] = dir
    let payload['ext'] = ext
    let payload['tail'] = tail
    let payload['path'] = filepath
    return payload
endfunction

let g:javascript_equal_dictionary = {
    \'ggg': ['ccc', 'aaa'],
    \'xy': ['[x, y]', ''],
    \'wh': ['[w, h]', ''],
    \'sto': ['storage', 'new Storage()'],
    \'tally': ['tally', 'new Tally()'],
    \'cache': ['cache', 'new Cache()'],
    \'store': ['store', '[]'],
    \'gggg': ['[a,b]', 'aaa'],
    \'ab': ['[a, b]', ''],
    \'abc': ['[a, b, c]', ''],
    \'so': ['[first, rest]', "splitOnce()\<LEFT>"],
\}
let g:vim_equal_dictionary = {
    \'to': ['to', 'VimTextStateObject()'],
\}

let g:typst_equal_dictionary = {
    \'store': ['store', '()'],
\}
function! DupTheFile()
    let f = VimFileStateObject()
    return f.open(f.dup(f.next_ver()))
endfunction
let g:execRef2["dup"] = "DupTheFile"

let g:linkedBufferGroups["functions.typ"] = "typst-math-assignment-parser-v2.js"
let g:linkedBufferGroups["typst-math-assignment-parser-v2.js"] = "functions.typ"

let g:execRef2["ct"] = "CompileTypstFromJavascript"
let g:wpsnippets2["math"] = {}
let g:wpsnippets2["math"]["fm"] = "---\n$c\n---"


function! FTEF_Typst_Five()
    let state = VimTextStateObject()
    if state.char.prev == '5'
        return g:keyboard.bs . '%'
    endif
    return '5'
endfunction
let g:linkedBufferGroups["td.q15.math"] = "functions.typ"
let g:linkedBufferGroups["functions.typ"] = "td.q15.math"

let g:wpsnippets2["typst"]["ta"] = "let table-attrs = (\n    align: auto,\n    column-gutter: auto,\n    row-gutter: auto,\n    columns: 2,\n    fill: auto,\n    stroke: (\n        top: none,\n        left: none,\n        right: none,\n        bottom: none,\n    ),\n    rows: auto,\n)"

let g:wpsnippets2["typst"]["ba"] = "let box-attrs = (\n    inset: 3pt,\n    outset: 0pt,\n    fill: none,\n    radius: 0pt,\n    stroke: black,\n)"


let g:execRef2["tt"] = "ToggleTypst"


function! TypstColorWrap()
    let state = VimTextStateObject()
    return state
    let back = state.back.trimmed
    call input('back: ' . back)
    return 
    asdf
endfunction



function! WrapCurrentCharWithBlue()
    if ToggleColor()
        return 
    endif
  let cursorPos = getpos(".")
  let char = getline('.')[cursorPos[2] - 1]
  let replacement = '#xblue(' . char . ')'
  call setline('.', substitute(getline('.'), '\%' . cursorPos[2] . 'c.', replacement, ''))
  call setpos('.', cursorPos)
  " adfadsfasdfadsf a#orange(b)c
endfunction

function! ToggleColor()
  " Define an array of colors to cycle through
  let colors = ['red', 'green', 'blue', 'yellow', 'purple', 'orange']
  let colors = ['blue', 'green', 'blue']

  " Get the current word under the cursor
  let currentWord = expand('<cword>')

  " Find the index of the current word in the colors array
  let currentIndex = index(colors, currentWord)

  " If the current word is a color, toggle to the next color
  if currentIndex != -1
    " Calculate the index of the next color
    let nextIndex = (currentIndex + 1) % len(colors)

    " Get the next color
    let nextColor = colors[nextIndex]

    " Replace the current word with the next color
    " We use the '\<...\>' regex to match the whole word exactly
    let line = getline('.')
    let line = substitute(line, '\<'.currentWord.'\>', nextColor, '')
    call setline('.', line)
    return 1
  endif
endfunction

let g:execRef2["wb"] = "WrapCurrentCharWithBlue"



function TypstCreateFunctionBlock()
    let s = VimTextStateObject()
    let t = "let %s(%s) = {\<CR>}\<CR>\<ESC>?{\<CR>o    "
    let before = "\<ESC>O"
    if s.front.test('^\w*\)')
        let ref = {}
        let raw_arg_string = Prompt('args?', 'x')
        let arg_string = get(ref, raw_arg_string, raw_arg_string)
        let value = printf(before . t, s.gcw(), arg_string)
        return value
    endif
    let [a, b] = s.sosall()
    return printf(g:keyboard.reset . g:keyboard.hash . t, a, join(b, ', '))
endfunction
let g:keyboard.hash = '#'

function! s:string(s)
    let s = a:s
    return json_encode(s)
endfunction
function! TypstNormalCreateFunctionWrapping()
    let to = VimTextStateObject()
    let key = to.match('callable')
    let style_object = g:typst_style_ref[key]

    let name = key . '-attrs'
    let insert_str = '..' . name . ', '
    let a = trim(to.sub(key . '\(\zs', insert_str))
    let b = BuildExprObjectString(name, style_object)
    let args = [b, a]
    call KeyboardTemplater('delete_to_start $1 go_down $2', args, 1)

endfunction
function! TypstCreateFunctionWrapping()
    """ 02-13-2024
    """ input: return columns(2, ..column-attrs, enumGroup)
    """ becomes:
    """ return block(..attrs, columns(2, ..column-attrs, enumGroup))
    """ type: expr

    let to = VimTextStateObject()
    let key = to.back.word()
    call input(json_encode([key, to.back.text]))
    let attr_name = key . '-attrs'
    let attr_str = '..' . attr_name . ', '
    let style_object = g:typst_styles_ref[key]
    " call input(json_encode(style_object))
    let attr_object = BuildExprObjectString(attr_name, style_object)
    let args = [attr_str, attr_object]
    let a = KeyboardTemplater('lp $1 go_to_end rp insert_above $2', args)
    return a
endfunction
function! BuildExprObjectString(name, obj)
    """ 02-13-2024
    """ builds a typst object
    """ 
    """ 
    """ 
    """ 
    let name = a:name
    let obj = a:obj
    let s = printf('let %s = ', name)
    function! s:inner(obj)
        " let final_enter = "\<CR>\<BS>"
        let initial_enter = "\<c-o>o\t"
        let obj = a:obj
        let s = ''
        let s .= '('
        let s .= initial_enter
        for [k,v] in items(obj)
            let s .= k . ': '
            if IsString(v)
                let s .= printf("%s", TypstAddQuotes(v))
            elseif IsNumber(v)
                let s .= printf("%s", v)
            elseif IsObject(v)
                let s .= s:inner(v)
            endif
            let s .= ',' . "\<c-o>o"
        endfor
        let s .= "\<BS>"
        let s .= ')'
        return s
    endfunction

    let s .= s:inner(obj)
    return s
    "let block-attrs = (\<ESC>o\tabc: \"hi\",\<CR>\<BS>)"}
endfunction
let g:typst_styles_ref = {'block': {'gg': 'xx', 'abc': '3pt', 'dd': {'aa': 11}}}

let g:jspyref3["vim"]["equal_dictionary"] = g:vim_equal_dictionary
let g:jspyref3["typst"]["equal_dictionary"] = g:typst_equal_dictionary
let g:jspyref3["python"]["equal_dictionary"] = {}
let g:jspyref3["javascript"]["equal_dictionary"] = g:javascript_equal_dictionary
function! KeyboardTemplater(s, ref = [1,2], executeIt = 0)
    "test: lp $1 go_to_end rp insert_above $2
    let executeIt = a:executeIt
    let s = a:s
    let ref = a:ref
    let t = 'has_key(g:keyboard, v:val) ? g:keyboard[v:val] : ref[v:val[1:] - 1]'
    let value = join(map(Split(s, ' +'), t), '')
    if executeIt
        execute 'normal! ' . value
    else
        return value
    endif
endfunction
let g:keyboard.lp = '('
let g:keyboard.rp = ')'
let g:keyboard.delete_to_start = '^Da'
let g:keyboard.go_down = "\<C-O>o"
let g:keyboard.insert_above = "\<ESC>O"
let g:keyboard.go_to_end = "\<C-O>$"
function! TypstAddQuotes(v)
    let v = a:v
    let r = '%(pt|em|\%|px|none|auto|left|top|bottom|right|black|blue|green|red)$'
    return Test(v, r) ? v : DoubleQuote(v)
endfunction

function! RunDictFunc(ref, key, ...)
    let ref = a:ref
    let key = a:key
    return call(function(ref[key]), a:000)
endfunction
function! TypstSmartEnter2()
    return
    let state = VimTextStateObject()

    let [PosteriorRef, AnteriorRef] = g:typst_enter_refs
    let first = state.first()
    if first in PosteriorRef 
        let items = state.sosall()[1]
        return RunDictFunc(PosteriorRef, first, state, items)
    endif

    let last = state.last()
    if last in AnteriorRef
        let items = state.sosall_reverse()[1]
        return RunDictFunc(AnteriorRef, last, state, items)
    endif

endfunction


function! LocateSnippet(key)
    let key = a:key
    
endfunction
function! LocateMapKey(key)
    "test: w,
    "test: <leader>d
    let key = a:key
    return maparg('w,', 'i', 0, 1)
endfunction
function! LocateDictKey(key)
    "test: tsa
    let key = a:key
    let refs = [
        \g:execRef2,
        \g:execRef,
    \]
    for item in refs
        if has_key(item, key)
            return item[key]
        endif
    endfor
endfunction

function! LocateDictFunction(key)
    "test: tsa
    let key = a:key
    let fnKey = LocateDictKey(key)
    call FindVimFunctionInVimFiles(fnKey)
endfunction
let g:linkedBufferGroups["td.q16.math"] = "mathDialogueTransformer.js"
let g:linkedBufferGroups["mathDialogueTransformer.js"] = "td.q16.math"

let g:linkedBufferGroups["td.q16.math.compiled"] = "td.q16.math"
let g:linkedBufferGroups["td.q16.math"] = "td.q16.math.compiled"

let g:filedict["lgt"] = "/home/kdog3682/2023/lezer-getTree.js"

function! CutLineAtCursorAndSetValueOnTop()
    let to = VimTextStateObject()
    let s:_name = Prompt('choose a name for this value', 'value')
    let s:_match = ''

    function! s:inner(x)
        let s = a:x
        let s:_match = s[0]
        return s:_name
    endfunction
    let r = printf('\(\zs%s.{-}\ze\) *$', to.gcw())
    let val = to.sub(r, function('s:inner'))
    let var = printf('let %s = %s', s:_name, s:_match)
    let payload = [var, trim(val)]
    return to.replace_line(payload)
endfunction
call add(g:lineEditCommands, "CutLineAtCursorAndSetValueOnTop")


let g:execRef2["wof"] = "WriteOldFiles"


function! RegexGetter(key)
    let dict = {
        \'': '^ *$',   
        \'callable': '[a-z]\w+\ze\(',   
    \}
    return get(dict, a:key, a:key)
endfunction

function! TypstNormalToggle()
    let to = VimTextStateObject()
    let [a,b] = SplitOnce(to.line.trimmed, ':')
    if Exists(b)
        return to.replace(b, ' ' . 'howdy')
    endif
          'asdfasdfadsf: howdy

endfunction
let g:wpsnippets2["typst"]["lo"] = "let $1 = kwargs.at(\"$1\", default: none)"

function! GetToplevelBlockIndexes()
    let f = CreateFLI()
    call f.up('^\w')
    call input('f: ' . s:string(f))
    call f.down('empty')
    let value = f.value()
    return value
endfunction
nnoremap dg :call DeleteBlock(GetToplevelBlockIndexes())<CR>


function! CreateFLI()
    let s:a = 0
    let s:b = 0

    function! s:get(k)
        let k = a:k
        let ref = {
            \"empty": {
                \"regex": '^\S+',
                \"backtrack": '\S+',
            \},
        \}
        return IsWord(k) ? ref[k] : {'regex': k}
    endfunction
    function! s:down(k)
        let k = s:get(a:k)
        let ind = FliDown(k.regex)
        call input('ind: ' . s:string(ind))
        let s = getline(ind)
        if s == "}"
            let s:b = ind
            return ind
        endif

        if has_key(k, 'backtrack')
            let ind = FliUp(k.backtrack, ind)
        endif
        let s:b = ind
        return ind
    endfunction

    function! s:up(k)
        let k = s:get(a:k)
        let ind = FliUp(k.regex)
        let s:a = ind
        return ind
    endfunction

    function! s:value()
        return [s:a, s:b]
    endfunction

    return { 'up': function('s:up'), 'down': function('s:down'), 'value': function('s:value'), }
endfunction


let g:wpsnippets2["javascript"]["cs"] = "console.s = `\n$c\n`\nconsole.test2($1)"
let g:wpsnippets2["typst"]["forkv"] = "for (k, v) in $1 {\n    $c\n}"

let g:filedict["v3"] = "/home/kdog3682/2023/typst-math-assignment-parser-v3.js"
nnoremap ev3 :call OpenBuffer4('/home/kdog3682/2023/typst-math-assignment-parser-v3.js')<CR>
nnoremap ect :call OpenBuffer4('/home/kdog3682/2024-typst/src/clip.typ')<CR>
let g:filedict["git3"] = "/home/kdog3682/2024-python/GithubController.py"
let g:filedict["sc3"] = "/home/kdog3682/2023/StateContext3.js"
nnoremap ewp :call OpenBuffer4('/home/kdog3682/PYTHON/workspace.py')<CR>
nnoremap edp :call OpenBuffer4('/home/kdog3682/PYTHON/dirs.py')<CR>
nnoremap epu :call OpenBuffer4('/home/kdog3682/PYTHON/utils.py')<CR>
nnoremap ewp :call OpenBuffer4('/home/kdog3682/PYTHON/workspace.py')<CR>


function! OpenBuffer(buffer)
    let buffer = a:buffer
    let prefix = bufexists(buffer) ? 'buffer! ' : 'edit! '
    let cmd = prefix . buffer
    execute cmd
endfunction
function! ResetNode7()
    ec "resetting node7"
    unlet g:node7files
endfunction
function! Node7()
    if exists('g:node7files') && Exists(g:node7files)
        let g:node7file = ModularIncrement2(g:node7files, g:node7file, 1)
    else
        let dir = '/home/kdog3682/2024-javascript'
        let dires = Globber(dir, 'IsDir')
        let dir = Choose100(dires)
        if empty(dir)
            return 
        endif
        let g:node7files = Globber(dir, 'IsFile')
        let g:node7file = g:node7files[0]
    endif

    ec g:node7file
    return OpenBuffer(g:node7file)
endfunction

function! Yes(...)
    return 1
endfunction
function! Globber(dir, fnkey= "IsFile", regex = 'node_modules')
    let dir = Substitute(a:dir, '/$', '')
    let files = split(glob(dir . '/*'), '\n')
    return filter(files, a:fnkey . '(v:val) && !Test(v:val, a:regex)')
endfunction
nnoremap <buffer> 7 :call Node7()<CR>
nnoremap 7 :call Node7()<CR>
inoreab <buffer>cf CurrentFile()<LEFT><C-R>=Eatchar('\s')<CR>
let g:execRef2["n7"] = "Node7"
let g:execRef2["rn7"] = "ResetNode7"
let g:execRef2["fa"] = "FindAnythingHandler"
let g:execRef2["ls"] = "LSDirectory"


silent call SimpleHighlighting()

    " let font = color == "bold" ? "cterm" : "ctermfg"
    " let cmd = printf('highlight %s %s=%s', name, font, color)
    " call s:highlight_syntax("simple_comment", "^ *//.*", "gray")
let g:linkedBufferGroups["lexer.js"] = "parser.js"
let g:linkedBufferGroups["parser.js"] = "lexer.js"

let g:linkedBufferGroups["handlers.js"] = "lexer.js"
let g:linkedBufferGroups["lexer.js"] = "handlers.js"

set smartindent
let g:execRef2["uso"] = "Uso"


function! JSS_tr()
    let t = GetSnippet("tr")
endfunction
let g:wpsnippets2["javascript"]["tr"] = "import { testRunnerMultiple } from \"./testRunner.js\"\ntestRunnerMultiple({\n    inputs: $str,\n    fn: $fn,\n    name: $file,\n})"






function! CompileMathToRaw()
    
endfunction
function! CompileMathToProduction()
    
endfunction

function! SetupPackageManagerFunctionCaller()
    """ 02-19-2024
    """ this will initialize a certain file 
    """ as the source for function calls
    """ 
    """ trigger: pm

    let file = GetOrSetGVariable('package_manager_file', "$file")
endfunction


function! TildaPath(x)
    let x = a:x
    return Substitute(x, '/home/kdog3682', '~')
endfunction
function! Map(items, ...)
    let s = 'v:val'
    for item in a:000
        let s = item . '(' . s . ')'
    endfor
    return map(a:items, s)
endfunction
function! BufferString(s)
    let buffers = GetActiveBuffers()
    let buffers = map(Map(buffers, 'expand'), "Substitute(v:val, '^/home/kdog3682', '~')")
    let buffers = filter(buffers, "v:val[0]== '~'")
    return join(sort(buffers), "\n")
endfunction
let g:filedict["todo"] = "/home/kdog3682/2024/todo.txt"
let g:wpsnippets2["text"] = {}
let g:wpsnippets2["text"]["buffers"] = "BufferString"

let g:filedict["gloss"] = "/home/kdog3682/2024/glossary.txt"
let g:filedict[".gloss"] = "/home/kdog3682/2024/.glossary.txt"
let g:filedict[".notes"] = "/home/kdog3682/2024/.notes.txt"
let g:filedict[".g"] = "/home/kdog3682/2024/.glossary.txt"
let g:filedict[".n"] = "/home/kdog3682/2024/.notes.txt"
function! Save()
    call WriteNotes6('!important $file')
endfunction
let g:execRef2["save"] = "Save"
nnoremap ejw :call OpenBuffer4('/home/kdog3682/2023/workspace.js')<CR>
let g:filedict["ffr"] = "/home/kdog3682/2024/ffr-simple.json"
let g:execRef2["asc"] = "AppendSpellcheckJSON"

function! TtpAutocomplete()
  let l:matches = ['ttpla', 'ttplb']
  call complete(col('.'), l:matches)
  return ''
endfunction


function! Fooo()
    execute 'inoremap <expr> ttp TtpAutocomplete("ttp", [1,2,3])'
endfunction
function! TTPAutocomplete(trigger, choices)
    let trigger = a:trigger
    let choices = a:choices
  call feedkeys(BackspaceExpr(trigger), 'n')
  let displayedChoices = map(copy(choices), {i,s -> (i + 1) . '. ' . s})
  let choiceIndex = inputlist(displayedChoices)
  call feedkeys(choices[choiceIndex - 1], 'n')
  return ''
endfunction

function! GetLastModifiedDate()
    " Get the current file name
    let l:filename = expand('%')

    " Construct and execute the Git command
    " git log -1 --format=%cd -- <file_path>
    " %cd is the committer date
    " You might need to customize the date format based on your preferences
    let l:command = 'git log -1 --format="%cd" -- ' . l:filename
    let l:lastModifiedDate = system(l:command)

    " Check for errors or empty result
    if v:shell_error || l:lastModifiedDate == ""
        echo "Unable to find the last modified date."
    else
        " Trim the result to remove any trailing newline
        let l:lastModifiedDate = substitute(l:lastModifiedDate, '\n\+$', '', '')
        echo "Last Modified Date: " . l:lastModifiedDate
    endif
endfunction


let g:execRef2["lmd"] = "GetLastModifiedDate"

let g:execRef2["fma"] = "FindMapArg"
nnoremap 0 :w<CR> :call Node0()<CR>
let g:wpsnippets2["typst"]["imp"] = "#import \"base-utils.typ\": *"
let g:wpsnippets2["typst"]["i"] = "ImportTypst"
let g:execRef2["sof"] = "SetOverrideFile"
let g:execRef2["compile"] = "CompileTypstFromStartToFinish"
let g:execRef2["mvo"] = "MoveOut"
let g:filedict["vbu"] = "/home/kdog3682/2024-typst/src/very-base-utils.typ"
let g:execRef2["ac"] = "AppController"
let g:wpsnippets2["typst"]["p1"] = "panic(1)"
let g:execRef2["gtc"] = "GitTempCheckout"
let g:execRef2["eb"] = "ExtractBlock"
let g:execRef2["jsi"] = "JSImport2024"
let g:wpsnippets2["javascript"]["dirs"] = "[ \"top\", \"right\", \"left\", \"bottom\", \"x\", \"y\"]"
let g:execRef2["tbu"] = "TempBackup"
let g:filedict["cabmap"] = "/home/kdog3682/2023/cabmap.js"
let g:vimFunctionAliases["vs"] = "GetVimState"
let g:vimFunctionAliases["word"] = "GetCurrentWord"
let g:vimFunctionAliases["strftime"] = "TimeStamp"
let g:execRef2["noc"] = "Node0Controller"

function! GoDotFile(file)
    let file = "/home/kdog3682/2024/." . a:file
    call OpenBuffer3(file)
endfunction

function! GoWorkspaceFile()
    return OpenBuffer('/home/kdog3682/2024-javascript/staging/workspace.js')
endfunction

nnoremap e.n :call GoDotFile("notes.txt")<CR> 
nnoremap e.fn :call GoDotFile(&filetype . "-function-notes.txt")<CR> 
"go to the general note file
nnoremap <leader>n :call FunctionNote("")<LEFT><LEFT>
nnoremap <leader>ng :call GlossaryNote("")<LEFT><LEFT>

function! FunctionNote(message)
    "test: asdf
    let message = trim(a:message)
    let length = len(message)
    if length < 3
        ec printf('A FunctionNoteEntry need to have a length of 10 or more for the message. The length of this message "%s" was only %s characters.', message, length)
        return 
    endif

    let s = VT('$strftime [$word]: $1', message)
    call AppendFile(GetLangNoteFile(), s)
endfunction

function! GetLangNoteFile()
    let outpath = VT('$dir2024/.$filetype-function-notes.txt')
    return outpath
endfunction
let g:gfgfdict['ob'] = ['/home/kdog3682/2024-typst/src/mmgg-morning-walk.typ', '', 0]
let g:gfgfdict['ob'] = ['/home/kdog3682/2024-typst/src/mmgg-morning-walk.typ', '', 0]
let g:execRef2["ic"] = "InsertAtCursorFuzzyFoundFile"
let g:execRef2["ita"] = "InsertTextAtCursor"
let g:wpsnippets2["javascript"]["s"] = "JSTestString"

function! JSTestString(...)
    let template = "const s = `\n$cursor\n`\nconsole.log($chooseFunc(s))"
    return VT(template)
endfunction
let g:execRef2["H"] = "CapitalHelpNotes"
let g:execRef2["gsr"] = "SetGConfigRawFile"
function! CreateEvalEnvTestFileForJavascript()
    let s = "import * as main from \"/home/kdog3682/2024-javascript/$1/main.js\"\nimport evalenv from \"/home/kdog3682/2024-javascript/evalenv/main.js\"\nevalenv({modules: main})"
    let importPath = VT('$head/main.js')
    call AssertFile(importPath)

    let h = Head()
    let name = GetLastWord(h)
    let value = VT(s, name)
    let outpath = h . '/test.js'
    call WriteFile(outpath, value)
endfunction
let g:execRef2["cenv"] = "CreateEvalEnvTestFileForJavascript"
function! AssertMatch(s, r, anti = 0)
    let s = a:s
    let r = a:r
    let anti = a:anti
    let m = Test(s, r)
    if anti
        if m
            throw VT('AssertionMatchError: "$1" is not allowed to match "$2"', r, s)
        endif
    else
        if !m
            throw VT('AssertionMatchError: "$1" does not match "$2"', r, s)
        endif
    endif
endfunction
function! AssertFile(file)
    let file = a:file
    if !IsFile(file)
        throw VT('AssertFileError: "$1" is not a file.', file)
    endif
endfunction

function! FzfDir2(directory)
    call fzf#run(fzf#wrap({'dir': a:directory, 'source': 'ls'}))
endfunction

function! FzfDir(directory)
    call fzf#vim#files(a:directory)
endfunction

function! AddSlash(s)
    let s = a:s
    return Test(s, '/$') ? '' : s . '/'
endfunction
function! Sinker(s)
    "test: foo
    throw 'hi'
    return AddSlash(s:dir) . Sub(a:s, '^./', '')
endfunction
function! FzfSimple(dir = 0)
    let dir = Exists(a:dir) ? a:dir : g:active_dir
    let h = FzfHelper(dir)
    call fzf#run(h)
endfunction
let g:execRef2["fzf"] = "FzfDir"
nnoremap <leader>f :call FzfDirectoryManager()<CR>
nnoremap <leader>i :call JSImport2024()<CR>
nnoremap <leader>s :call FzfSimple()<CR>
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
let g:wpsnippets2["javascript"]["hi"] = "console.log('hi'); throw getCaller()"

function! SetIndentExpr()
    execute 'set indentexpr='
    ec 'fixing indent expr'
endfunction
let g:execRef2["sie"] = "SetIndentExpr"
let g:linkedBufferGroups["vueBlocks.js"]      = "/home/kdog3682/2024-javascript/vuekit/ComponentState.js"
let g:linkedBufferGroups["ComponentState.js"] = "/home/kdog3682/2024-javascript/txflow/vueBlocks.js"

let g:execRef2["sh"] = "SimpleShunt"

function! JuneGunnEasyAlign()
    :EasyAlign[=]
endfunction
let g:execRef2["eza"] = "JuneGunnEasyAlign"

" Mapping selecting mappings
" nmap <leader><tab> <plug>(fzf-maps-n)
" imap <c-x><c-f> <plug>(fzf-complete-path)

" Path completion with custom source command
" inoremap <expr> <c-x><c-f> fzf#vim#complete#path('fd')
function! FzfHelper(source, Sink = "e")
    let source = a:source
    let Sink = a:Sink

    let payload = {'window': {'width': 0.88, 'height': 0.8}, 'left': '50%'}
    if IsArray(source)
        let payload['source']  = source
    else
        let payload['source'] = 'find $(pwd) -regextype posix-extended -type f | grep -vE ''(fonts|\.git/|node_modules|\.log$|temp|pycache|env)'''
        let payload['dir'] = source
    endif
    if Exists(Sink)
        let payload["sink"]= Sink
    endif
    return payload
endfunction
inoremap <expr> ,f fzf#vim#complete(FzfHelper('/home/kdog3682/2024-javascript/'))


function! Fooga()
    ec "hi"
endfunction

nnoremap \\ :call Fooga()<CR>

function! SeeVimVersion()
    call GitCommandWrapper('vim --version')
endfunction


nnoremap ` :call FzfDir("/home/kdog3682/2024-javascript/")<CR>
nnoremap eb :call OpenBuffer4('/home/kdog3682/2024-javascript/txflow/vueBlocks.js')<CR>

function! SmartEqual2()

    let state = VimTextStateObject()

    if state.endswith('[?<>!=] *')
        return state.deleteEndingSpaces() . "= "
    endif

    if state.front.empty
        if state.startswith('^ *(const|var|let|if|else|for|while|do) ')
            if state.char.prev == "="
                return state.deleteEndingSpaces() . "= "
            endif
            return state.deleteEndingSpaces() . " == "
        else
            return ' = '
        endif
    elseif state.back.isword() && state.back.trimmed != prefix
        return g:keyboard.reset . prefix . state.back.trimmed . ' = ' . state.front.trimmed
    elseif state.back.test('[<>?=]')
        return state.deleteEndingSpaces() . "= "
    else
        return ' = '
    endif
endfunction

function! VueEnter()
    let state = VimTextStateObject()
    if state.empty
        return g:keyboard.enter
    elseif state.endswith(':')
        return g:keyboard.enter . state.line.spaces . '    '
    endif
    return g:keyboard.enter . state.line.spaces
endfunction

function! VueBrace()
    let state = VimTextStateObject()
    if state.endswith('[')
        return g:keyboard.bs . '{}' . g:keyboard.left
    endif
    return '['
endfunction
call add(g:lineEditCommands, "QuoteTheLine")
function! VueBrace()
    let state = VimTextStateObject()
    if state.endswith('[')
        return g:keyboard.bs . '{}' . g:keyboard.left
    endif
    return '['
endfunction
let g:filedict["vv"] = "/home/kdog3682/.vim/ftplugin/vue.vim"
let g:filedict["gmail"] = "https://gmail.com"
let g:filedict["web"] = "https://google.com"

function! VueFunction()
    
endfunction


" set completeopt+=menuone,noselect
" let g:mucomplete#user_mappings = { 'sqla' : "\<c-c>a" }
" let g:mucomplete#chains = { 'sql' : ['file', 'sqla', 'keyn'] }

" mut

function! Mut()
    MUcompleteAutoToggle
endfunction
let g:execRef2["mut"] = "Mut"


function! MyCustomComplete()
    return ['AbstractMethodError', 'bbb']
endfunction
	let g:mucomplete#user_mappings = {
	    \ 'sqla' : "\<c-c>a",
	    \ 'xyz'  : "\<c-r>=MyCustomComplete()\<cr>"
	    \ }

" let g:mucomplete#chains = { 'default': ['user', 'keyp'] }
" let g:mucomplete#enable_auto_at_startup = 0
" let g:mucomplete#minimum_prefix_length = 1

function! GoTestingFile()
    let h = GetLastWord(Head())
    let item = get(g:dirRef, h, 0)
    if Exists(item)
        call OpenBuffer3(item)
    endif
endfunction
let g:dirRef= {}
" let g:dirRef['txflow']=
nnoremap gtf :call GoTestingFile()<CR>


function! GetFileInfo()
    ec VT("getting file info for current file: $cf")

endfunction
let g:execRef2["info"] = "GetFileInfo"

function! Me()
    let keys = [
                \"woke",
                \"wake",
                \"dinner",
                \"idle",
                \"idle",
    \]

endfunction
let g:execRef2["me"] = "Me"

let g:linkedBufferGroups["components.txt.js"] = "vuetify.js"
let g:linkedBufferGroups["vuetify.js"] = "components.txt.js"

let g:execRef2["sjs"] = "SetFileTypeJavascript"
function! GetBufferNames()
	return GetActiveBuffers()
endfunction
let g:gfgfdict['ob'] = ['/home/kdog3682/2024-javascript/txflow/vueBlocks.js', 'someDepth', 0]
augroup css_autocmd
    autocmd!
    autocmd BufEnter *.css :call CssAutoEnter()
    autocmd BufWritePost  *.css call CssAutoEnter()
augroup END

function! ChooseFileAndThenDoSomething()
    
endfunction

function! _GetFZF(name)
    let g:fzf_sink= name
endfunction
function! IsCssFile(s)
    let s = a:s
    return GetExtension(s) == 'css'
endfunction
function! GetFZF(names)
    let names = a:names
    call fzf#run(FzfHelper(names, 'EchoArgument'))
    return g:fzf_sink
endfunction
function RunCommandViaFZF(arg)
    let arg = a:arg
    call function(arg)()
endfunction

function! EchoArgument(arg)
    let g:fzf_sink= a:arg
endfunction

command! -nargs=1 EchoArgument call EchoArgument(<f-args>)
command! -nargs=1 RunCommandViaFZF call RunCommandViaFZF(<f-args>)

nnoremap ebc :call OpenBuffer4('/home/kdog3682/2024-javascript/vuekit/base-components.js')<CR>
let g:wpsnippets2["javascript"]["vt"] = "const ${Pascal($1)} = {\n    name: '${DashCase($1)}',\n    render(h) {\n         $c\n        return h('div', {class: \"${DashCase($1)}\"}, value)\n    },\n    props: ['value'],\n}"
let g:wpsnippets2["javascript"]["vh"] = "const ${Pascal($1)} = {\n    name: '${DashCase($1)}',\n    render(h) {\n         $c\n        return h('div', {class: \"${DashCase($1)}\"}, value)\n    },\n    props: ['value'],\n}"
" let g:wpsnippets2["javascript"]["vr"] = "const ${Pascal($1)} = {\n    name: 'r-${DashCase($1)}',\n    raw: q`\n\n\n`
let g:execRef2["sd"] = "SwapDashes"
let g:wpsnippets2["vim"]["nb"] = "nnoremap <buffer> $1 :call $2()<CR>"
let g:execRef2["sad"] = "SetActiveDir"
let g:execRef2["booga"] = "Booga"


nnoremap <leader>d :call fzf#run(FzfHelper(GetBufferNames(), "e"))<CR>
nnoremap <leader>c :call FzfFunctionHandler()<CR>
nnoremap <buffer> <leader>d :call FOOO()<CR>

function! FOOO()
	ec 'hi'
endfunction
let g:execRef2["g"] = "GoGfgf"
let g:gfgfdict['ob'] = ['/home/kdog3682/.vim/ftplugin/vimrc.january2024.vim', 'OpenBuffer4', 0]
let g:wpsnippets2["vim"]["map"] = "map($1, '$2(v:val)')"
let g:wpsnippets2["vim"]["filter"] = "filter($1, '$2(v:val)')"
let g:gfgfdict['v3'] = ['/home/kdog3682/.vim/ftplugin/vimrc.january2024.vim', 'VAction3', 0]

let g:linkedBufferGroups["/home/kdog3682/2024-javascript/txflow/tests/vuemd.a.js"] = "/home/kdog3682/2024-javascript/txflow/vuemdBlocks.js"
let g:linkedBufferGroups["/home/kdog3682/2024-javascript/txflow/vuemdBlocks.js"] = "/home/kdog3682/2024-javascript/txflow/tests/vuemd.a.js"

function! SmartEqual3()
    "javascript

    let state = VimTextObject()

    if g:config.txflow_equal_sign
        return state.deleteEndingSpaces() . ' = '

    elseif state.left.endswith('[?<>!=] *')
        return state.deleteEndingSpaces() . "= "

    elseif state.test('^ *[a-z]\w* *$')

        let word = state.match('[a-z]\w*')
        let equal_dictionary_ref = JP('equal_dictionary')

        if has_key(equal_dictionary_ref, word)
            let prefix = JP('prefix')
            let [before, after] = equal_dictionary_ref[word]
            return g:keyboard.reset . prefix . before . ' = ' . after

            " existing
        elseif Exists(state.find_above(word . '(\)| *\= *)|[!(] *' . word))
            return state.deleteEndingSpaces() . " = "
        else
            let prefix = JP('prefix')
            return "\<C-O>I" . prefix . "\<C-O>A = "
            " return g:keyboard.reset . prefix . state.left.trimmed . ' = '
        endif
    elseif state.left.test('^ *\w+ *$')
        let prefix = JP('prefix')
        return g:keyboard.reset . prefix . state.left.trimmed . ' = ' . state.right.trimmed
    else
        return ' = '
    endif
endfunction
function! VimTextObject()
    let number = line('.')
    let s = getline(number)
    let pos = col('.') - 1
    let left_ch = s[pos - 3]
    let current_ch = s[pos - 2]
    let next_ch = s[pos - 1]
    let right =  strpart(s, pos)
    let left = strpart(s, 0, pos)
    " return [left, right]

    let trimmed = trim(s)
    let trimmedLeft = trim(left)
    let trimmedRight = trim(right)
    let spaces = Match(s, '^ *')
    let ind = len(spaces)
    " @bookmark 1709331717 vto
    let data = {
        \"getset": {Fn -> setline(number, Fn(data))},
        \"match": {k -> Match(s, RegexGetter(k))},
        \"find_above": {r -> Fli(r, number, -1, 5)},
        \"find_below": {r -> Fli(r, number, 1, 5)},
        \"sub": {r, Fn -> Substitute(s, r, Fn)},
        \"replace_line": {payload -> ReplaceBlock(number, payload, 1)},
        \"set_line": {payload -> setline(number, Test(payload, '^ +') ? payload : spaces . payload)},
        \"replace": {x,y -> setline(number, Substitute(s, x, y))},
        \"empty": len(trimmed) == 0,
         \   'text': s,
         \   'trimmed': trimmed,
         \   'spaces': Match(s, '^ *'),
          \  'number': number,
          \  'lnum': number,
           \ 'length': len(s),
        \    "pos": pos,
         \   "prev_ch": left_ch,
          \  "ch": current_ch,
           \ "next_ch": next_ch,
        \'left': {
         \ 'endswith': {x -> Test(left, x . '$')},
         \ 'test': {x -> Test(left, x)},
         \ 'startswith': {x -> Test(trimmedLeft, '^' . x)},
         \ 'trimmed': trimmedLeft,
        \},
        \'right': {
         \ 'endswith': {x -> Test(right, x . '$')},
         \ 'test': {x -> Test(right, x)},
         \ 'startswith': {x -> Test(trimmedRight, '^' . x)},
         \ 'trimmed': trimmedRight,
        \},
        \'ind': ind,
        \'endswith': {x -> Test(s, x . '$')},
        \'startswith': {x -> Test(s, '^ *' . x)},
        \'has': {x -> Test(s, EscapeRegexEqual(x))},
        \'test': {x -> Test(s, x)},
        \'sosall': { -> Sosall(s)},
        \'gcw': { -> expand('<cword>')},
        \'first': { -> Match(s, '^\W*\zs\w+')},
        \'last': { -> Match(s, '\w+\ze\W*$')},
        \'deleteEndingSpaces': { -> BackspaceExpr(Match(left, '\S\zs *$'))}
    \}
    return data
endfunction
let g:vimCurrentTestFunction = "SmartEqual3"
let g:execRef2["tgc"] = "ToggleGConfig"

function! GlossaryNote(message)
    "test: asdf
    let message = trim(a:message)
    let s = VT('$strftime [$word]: ' . message)
    call AppendFile(g:glossaryfile, s)
endfunction
let g:glossaryfile = "/home/kdog3682/2024/.glossary.txt"

call add(g:lineEditCommands2, "ExtractVarAndMoveUp")
function! FzfDirectoryManager()
    let dir= "/home/kdog3682/2024-javascript/"
    if &filetype== "typst"
        let dir = "/home/kdog3682/2024-typst/src"
    elseif &filetype== "python"
        let dir = "/home/kdog3682/PYTHON"
    elseif &filetype== "python"
        let dir = "/home/kdog3682/PYTHON"
    endif
    " call fzf#vim#files(dir)
    call FzfSimple(dir)
endfunction
let g:wpsnippets2["css"]["com"] = "/****\n    $c\n****/"

let g:fzf_function_items = [
    \'GenerateAdvancedComponentFile',
\]

function! Foo()
    ec 'hii'
endfunction
let g:alphabet= ['aaaa', 'bbbbbbbb', 'ccccccccc']
function! FzfFunctionHandler()
    call fzf#run(fzf#wrap({'source': g:fzf_function_items, 'sink': 'RunCommandViaFZF'}))
endfunction
nnoremap evc :call OpenBuffer4('/home/kdog3682/2024-javascript/vuekit/vuetify.css')<CR>

function! WritePackageJson()
    let file = '/home/kdog3682/2024-javascript/package.json'
    call WriteFile(file, json_encode({"type": "module"}))
endfunction
nnoremap eps :call OpenBuffer4('/home/kdog3682/2024-javascript/vuekit/ps105.css')<CR>
let g:execRef2["goyo"] = "Goyo"


function! s:goyo_enter()
  set noshowmode
  set noshowcmd
  set scrolloff=5
  set wrap
endfunction

function! s:goyo_leave()
  set showmode
  set showcmd
  set scrolloff=5
  set nowrap
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()


let g:fzf_css_completions= ['shadow 1', 'shadow 2']
inoremap <expr> ,d fzf#vim#complete(FzfHelper(g:css_local_phrases))
nnoremap ecd :call OpenBuffer4('/home/kdog3682/.vim/ftplugin/css-data.vim')<CR>
let g:linkedBufferGroups["/home/kdog3682/2024-javascript/txflow/specialComponentWrapper.js"] = "/home/kdog3682/2024-javascript/txflow/vueBlocks.js"
let g:linkedBufferGroups["/home/kdog3682/2024-javascript/txflow/vueBlocks.js"] = "/home/kdog3682/2024-javascript/txflow/specialComponentWrapper.js"

nnoremap ecs :call OpenBuffer4('/home/kdog3682/2024-javascript/vuekit/simple.css')<CR>

function! FzfHis()
    History
endfunction
let g:execRef2["his"] = "FzfHis"


let g:gfgfdict['n'] = ['/home/kdog3682/.vim/ftplugin/vimrc.january2024.vim', 'Node1', 0]

" set runtimepath+=/home/kdog3682/.vim/xptemplate




inoremap <silent> <expr> <Tab> QQQ()

" inoremap <silent> <buffer> <Tab> <C-R>=CleverTab()<CR>
" old and deprecated
let g:gfgfdict['vfs'] = ['/home/kdog3682/.vimrc', 'VimFileStateObject', 0]

" /home/kdog3682/.config/nvm/versions/node/v21.7.1/lib/node_modules
" /home/kdog3682/2023/node_modules



let g:execRef2["aed"] = "AddEntryToDirDict"
let g:dirdict["cetz-package"] = "/home/kdog3682/.cache/typst/packages/preview/cetz/0.2.0/"
let g:wpsnippets2["vim"]["jsp"] = "let g:jspyref3[\"vim\"][\"$1\"] = \"$2\"\nlet g:jspyref3[\"python\"][\"$1\"] = \"$2\"\nlet g:jspyref3[\"javascript\"][\"$1\"] = \"$2\"\nlet g:jspyref3[\"typst\"][\"$1\"] = \"$2\"\nlet g:jspyref3[\"html\"][\"$1\"] = \"$2\"\nlet g:jspyref3[\"css\"][\"$1\"] = \"$2\""


let g:wpsnippets2["vim"]["jsp"] = "let g:jspyref3[\"vim\"][\"$1\"] = \"\"\nlet g:jspyref3[\"python\"][\"$1\"] = \"\"\nlet g:jspyref3[\"javascript\"][\"$1\"] = \"\"\nlet g:jspyref3[\"typst\"][\"$1\"] = \"\"\nlet g:jspyref3[\"html\"][\"$1\"] = \"\"\nlet g:jspyref3[\"css\"][\"$1\"] = \"\""


let g:execRef2["dfr"] = "DenoFileRunner"
let g:execRef2["export"] = "ExportToJson"

let g:execRef2["gf"] = "GoGfgf"
let g:execRef2["ve"] = "VimExecRef2Runner"
let g:execRef2["fmt"] = "DenoFormat"

nnoremap <leader>ba :BookmarkAdd<space>
nnoremap <leader>bg :BookmarkGo<space>
nnoremap <leader>bd :BookmarkDel<space>
nnoremap <leader>bq :BookmarkQf<cr>
function! GetVimState2()
    let override = a:0 >= 1 && Exists(a:1)
    let file = override ? a:1 : CurrentFile()
    let lineNumber = override ? getbufinfo(file)[0].lnum : line('.')
    let filetype = GetFiletype(file)
    let tail = Tail(file)
    let state= 
    let data = {
        \'file': file,
        \'filename': tail,
        \'name': RemoveExtension(tail),
        \'lineNumber': lineNumber,
        \'lnum': lineNumber,
        \'filetype': filetype,
        \'dir': Head(file),
        \'state': state,
    \}
    return data
endfunction

function BuildPattern(line)
  return '^\s*\V' . escape(a:line, '\') . '\m\s*$'
endfunction

source /home/kdog3682/.vim/ftplugin/simpleBookmarks.vim




function! DenoCreateFile(filename)
    " first fzf the directory ... then create the file
    let s:filename = a:filename
    let dirs= GetPublicDirectoriesRecursively('/home/kdog3682/2024-javascript/', 'd')
    function! Sink(dir)
        let dir = a:dir
        let path = PathJoin(dir, s:filename)
        call OpenBuffer(path)
        call Magical(path)
    endfunction
    call fzf#run(fzf#wrap({'source': dirs, 'sink': function('Sink')}))
endfunction

function! GetPublicDirectoriesRecursively(...)

    let dir= a:0 >= 1 ? a:1 : '$(pwd)'
    let type= a:0 >= 2 && a:2== 'dir' || a:2== 'd'? 'd' : 'f'
    let ignore= '(fonts|\.git|node_modules|\.log$|temp|package)'
    let source = printf('find %s -regextype posix-extended -type %s | grep -vE ''%s''', dir, type, ignore)
    let result = systemlist(source)
    return result
endfunction


function! _FzfObjectCallback(obj, Callback)
    let s:obj= a:obj
    let s:Callback = function(a:Callback)

    let display= keys(s:obj)
    function! Sink(name)
        return s:Callback(s:obj[a:name])
    endfunction
    call fzf#run(fzf#wrap({'source': display, 'sink': function('Sink')}))

endfunction
function! FzfCallback(items, Callback = "Callback", Display = "Display", Access = "Access")
    let items = IsString(a:items) ? ReadJson(a:items) : a:items
    " ec items
    " return
    let Display = a:Display
    let Callback = a:Callback
    let Access = a:Access
    if empty(items)
        ec "no items to fzf"
        return 
    elseif IsObject(items)
        return _FzfObjectCallback(items, Callback)
    else
        return _FzfArrayCallback(items, Callback, Display, Access)
    endif
    
endfunction
function! _FzfArrayCallback(items, Callback, Display, Access)
    let s:items = a:items
    let s:Display = function(a:Display)
    let s:Callback = function(a:Callback)
    if len(a:items)== 1
        return s:Callback(a:items[0])
    endif

    function! SimpleSink(item)
        return s:Callback(a:item)
    endfunction

    function! Sink(match)
        let item = Find(s:items, {x -> s:Display(x)== a:match})
        return s:Callback(item)
    endfunction

    if IsString(a:items[0])
        return fzf#run(fzf#wrap({'source': a:items, 'sink': function('SimpleSink')}))
    endif

    let display= SimpleMap(a:items, a:Display)
    call fzf#run(fzf#wrap({'source': display, 'sink': function('Sink')}))
endfunction

function! SimpleMap(items, fnKey)
    let items = a:items
    let fnKey = a:fnKey
    return map(copy(items), fnKey . '(v:val)')
endfunction

let g:execRef2["dcf"] = "DenoCreateFile"
function! Magical(...)
    let file = a:0 >= 1 ? a:1 : CurrentFile()
    if Test(file, 'apps/\w+(\.\w+)+$')
        let name = Match2(file, '/apps/(\w+)')
        call SnippeteerHandler('maj', name)
    endif
endfunction
let g:execRef2["magic"] = "Magical"
let g:wpsnippets2["javascript"]["maj"] = "export default $1 \n\nfunction $1(s) {\n\n}"

function! SnippeteerHandler(...)
    return Snippeteer(join(a:000, ' '))
endfunction
function! InputPrompt(a, b)
    let a = a:a
    let b = a:b
    ec a
    ec b
    call input('')
endfunction
let g:execRef2["dj"] = "DenoJavascriptAppRunner"
" let g:wpsnippets2["text"]["insert"] = "Inserter"
" function! Inserter(s)
    " let s = a:s
" endfunction
let g:wpsnippets2["javascript"]["edm"] = "export default main"
let g:execRef2["ff"] = "FZF_FindExecRefFunction"

let g:jspyref3['javascript']['lp'] = 'pause("pausing @ $1", $1)'

function! GoTempError()
    let json = ReadVimJSON('temp-error')
    call OpenBuffer(json.file)
    call cursor(json.line, 1000)
endfunction
nnoremap gte :call GoTempError()<CR>
let g:wpsnippets2["javascript"]["sl"] = "switch($1.length) {\n    case 0:\n    case 1:\n        $c\n    case 2:\n    case 3:\n}"

let g:wpsnippets2["javascript"]["p"] = "pause('pausing at $1', $1)"
let g:execRef2["typf"] = "TypstFormat"
let g:filedict["foo"] = "/home/kdog3682/2024-typst/src/foo.typ"
nnoremap ey :call OpenBuffer4('/home/kdog3682/2024-javascript/nodekit/deno.js')<CR>

function! Sdfjksdhf()
	throw "hi"
endfunction
" nnoremap <leader>v :call FzfSimple("/home/kdog3682/.vim/ftplugin")<CR>
let g:s_fzf_dir="/home/kdog3682/.local/share/typst/packages/local/stdlib/0.1.0/src"
nnoremap <leader>s :call FzfDir2(g:s_fzf_dir)<CR>
" nnoremap <leader>s :call FzfSimple("/home/kdog3682/GITHUB/nvimbackup")<CR>
nnoremap <leader>a :call FzfSimple("/home/kdog3682/.config/nvim")<CR>
nnoremap <leader>j :call FzfSimple("/home/kdog3682/2023")<CR>
nnoremap <leader>t :call FzfSimple("/home/kdog3682/2024-typst/src")<CR>
nnoremap <leader>c :call FzfSimple(SmartHead())<CR>
nnoremap <leader>1 :call FzfSimple(GetBuffers2024())<CR>
nnoremap <leader>2 :call FzfSimple("/home/kdog3682/@bkl")<CR>


function! SmartHead()
    let h = Head()
    let m = Match(h, '\@\zs(\w+)')
    if Exists(m)
        return '/home/kdog3682/@' . m
    endif
    return h
endfunction
let g:cetz_package_dir= "/home/kdog3682/GITHUB/typst-packages/packages/preview/cetz/0.2.0/src"
nnoremap  <leader><leader>c :call fzf#run(fzf#wrap({'dir': g:cetz_package_dir}))<CR>
" fzf#run(FzfHelper(dir))
function! GetBuffers2024()
    let f = "!Test(v:val.name, '\.(vim|log|vimrc)$')"
    let g = "v:val.name"
    let buffers = filter(getbufinfo(), f)
    call sort(buffers, function('CompareByLastUsed'))
    return map(buffers, g)
endfunction
let g:vimCurrentTestFunction = "ConstantlyCallJavascript"
let g:jspyref3["lua"] = {}
let g:jspyref3["lua"]["commentPrefix"] = "--"

inoremap <expr> ,a fzf#vim#complete(FzfHelper('~/.config/nvim/lua/kdog3682'))
let g:execRef2["--1"] = "GetDateOfLastFileTouch"
let g:filedict["lf"] = "/home/kdog3682/2024-javascript/stdlib/lezer/functions.js"

function! Zap()
	call AppendFile('/home/kdog3682/.temp.txt', getline('.'))
endfunction
let g:execRef2["zap"] = "Zap"
let g:filedict["tt"] = "/home/kdog3682/.temp.txt"
let g:wpsnippets2["javascript"]["ar"] = "------------------------------------------------------------\n\ndatetime: $datetime\nsubreddit: $c\ntitle: \nbody:"
let g:wpsnippets2["javascript"]["extf"] = "------------------------------------------------------------\n\ndatetime: $datetime\nexternal_file: $c\nbody:"
let g:execRef2["tus"] = "ToggleUnderscore"
let g:wpsnippets2["text"]["fm"] = "---\n$c\n---"



let g:execRef2["pvj"] = "PreviewVueJS"
let g:wpsnippets2["html"] = {}
let g:wpsnippets2["html"]["div"] = "<div id=''>\n</div>"

let g:wpsnippets2["html"]["script"] = "<script type= 'module'>\n    \n</script>"
let g:filedict["cmn1"] = "/home/kdog3682/2023/cm-next.js"
let g:filedict["cm3"] = "/home/kdog3682/2023/cm3.js"
let g:execRef2["grep"] = "GREP"
let g:linkedBufferGroups["/home/kdog3682/2024-javascript/staging/JavascriptVisitors.js"] = "/home/kdog3682/2024-javascript/staging/lezer-workspace.js"
let g:linkedBufferGroups["/home/kdog3682/2024-javascript/staging/lezer-workspace.js"] = "/home/kdog3682/2024-javascript/staging/JavascriptVisitors.js"

let g:wpsnippets2["javascript"]["vc"] = "const [a, b] = visitChildren(this, ast, env)"
let g:wpsnippets2["javascript"]["vcabc"] = "const [a, b, c] = visitChildren(this, ast, env)"
let g:wpsnippets2["javascript"]["vcc"] = "const children = visitChildren(this, ast, env)"
let g:linkedBufferGroups["/home/kdog3682/2024-javascript/staging/NameCheckerVisitors.js"] = "/home/kdog3682/2024-javascript/staging/lezer-workspace.js"
let g:linkedBufferGroups["/home/kdog3682/2024-javascript/staging/lezer-workspace.js"] = "/home/kdog3682/2024-javascript/staging/NameCheckerVisitors.js"

let g:linkedBufferGroups["/home/kdog3682/2024-javascript/staging/addMissingDependencyVisitors.js"] = "/home/kdog3682/2024-javascript/staging/lezer-workspace.js"
let g:linkedBufferGroups["/home/kdog3682/2024-javascript/staging/lezer-workspace.js"] = "/home/kdog3682/2024-javascript/staging/addMissingDependencyVisitors.js"

let g:wpsnippets2["javascript"]["ptc"] = "pause(this.children)"
let g:wpsnippets2["javascript"]["ifmk"] = "if (!$1) {\n    $1 = $2\n}"

let g:filedict["tb"] = "/home/kdog3682/2024-javascript/txflow/typstBlocks.js"
let g:filedict["typ"] = "https://typst.app/project/pmNCqtXTIGrMxEOd0913Ik"
nnoremap etb :call OpenBuffer4('/home/kdog3682/2024-javascript/txflow/typstBlocks.js')<CR>
let g:linkedBufferGroups["/home/kdog3682/2024-javascript/txflow/tests/typst.a.js"] = "/home/kdog3682/bkl/math/slope/0.1.0/raw.txf"
let g:linkedBufferGroups["/home/kdog3682/bkl/math/slope/0.1.0/raw.txf"] = "/home/kdog3682/2024-javascript/txflow/tests/typst.a.js"

let g:filedict["slope"] = "/home/kdog3682/bkl/math/slope/0.1.0/raw.txf"
let g:wpsnippets2["text"]["exp"] = "JSVExpand"
let g:wpsnippets2["global"]["buffers"] = "B"

function! JSVExpand()
    let line = CurrentLine()
    let file= ""

    let module_file = "/home/kdog3682/2024-javascript/nodekit/apps/expand.js"
    let s = json_encode({'text': line})
    " ec s
    let state= ShellEscape(s)
    " return
    " ec state
    " return
    let res= systemlist('deno run --allow-all ' . g:deno_file . ' ' . module_file . ' ' . state)
    ec res
    " ec res
    return
    let base = res[0]
    ec base
    return 
    " let base= Sub(base, '\\\\', '\\')
    " ec base
    " return
    let s = json_decode(base)
    ec s.value
    return 
    " let res = SystemExec(g:deno_file, module_file, R)
    " ec res
    return 
endfunction
let g:execRef2["jsv"] = "JSVExpand"

function! NodeBooga(state) abort
   let state = a:state
   let module_file = '/home/kdog3682/2024-javascript/nodekit/apps/' . AddExtension(state.module, 'js')
   let state.redirect = v:true
   let state.state= {}
   let state = json_encode(state)
   let state= ShellEscape(state)
   " call append('$', state)
   " return
   " ec state
   " return
   let cmd = 'deno run --allow-all ' . g:deno_file . ' ' . module_file . ' ' . state
   " ec cmd
   " return
   let base= ''
   let result= ''
    try
        let base= systemlist(cmd)
        if empty(base)
            return '  --EMPTY--'
        endif
       let res = trim(base[1])
       let value = json_decode(res)
       let result = value.value
    catch
        let error = v:exception
        return '  --ERROR: ' . error
    endtry
   if IsObject(result)
        if has_key(result, 'open')
            call OpenBuffer(result.open)
        elseif has_key(result, 'template')
            return g:keyboard.reset . BackslashReplacer(result.template)
        elseif has_key(result, 'replacement')
             if has_key(result, 'backspaces')
                 return repeat(g:keyboard.bs, result.backspaces) . result.replacement
             endif
             " call input(string(result.replacement))
            return Sub(result.replacement, '\t', "    ")
        else
            ec result
        endif
   endif
endfunction

function! RunJavascriptModuleForCurrentLine(module)
    let state = {"arg": CurrentLine(), 'module': a:module}
    return NodeBooga(state)
endfunction

function! RunJavascriptModuleWithArg(module, arg)
    let module = a:module
    let arg = trim(a:arg)
    let state = {"module": module, "arg": trim(arg)}
    return NodeBooga(state)
endfunction

let g:execRef2["rjm"] = "RunJavascriptModuleWithArg"
let g:execRef2["dlgit"] = "RunJavascriptModuleWithArg('github', '$1')"
function! TypstOmniExpand()
    return RunJavascriptModuleForCurrentLine('typstOmniExpand')
endfunction
let g:linkedBufferGroups["/home/kdog3682/2024-javascript/nodekit/apps/typstOmniExpand.js"] = "/home/kdog3682/bkl/math/slope/0.1.0/slope-triangle.typ"
let g:linkedBufferGroups["/home/kdog3682/bkl/math/slope/0.1.0/slope-triangle.typ"] = "/home/kdog3682/2024-javascript/nodekit/apps/typstOmniExpand.js"

function! Fooo()
    return TypstOmniExpand()
    let t = "let %s(%s) = {\<CR>}\<CR>\<ESC>?{\<CR>oabc"
    return g:keyboard.reset . t
endfunction


function! BackslashReplacer(s)
    let s = a:s
    let k= "\<CR>\<ESC>?{\<CR>o"
    let cr = "\<CR>"
    let s = substitute(s, '\v\n\t\n(.*)', {x -> cr . x[1] . k}, '')
    return s



    let s = Sub(s, 'dooga', "{\<CR>}\<CR>\<ESC>?{\<CR>o    ")
    let s = 
    " call input(s)
    " let s =  Sub(s, '\\\<CR\>', "\<CR>")
    " let s = Sub(s, '\\\<ESC\>', "\<ESC>")
    " let s =  Sub(s, '\\\<CR\>', "\<CR>")
    return s
endfunction
inoremap <silent> <expr> qt Fooo()

let g:linkedBufferGroups["/home/kdog3682/.config/nvim/lua/local-plugins/nvim-grey/colors/grey.lua"] = "/home/kdog3682/.config/nvim/lua/plugins/lsp.lua"
let g:linkedBufferGroups["/home/kdog3682/.config/nvim/lua/plugins/lsp.lua"] = "/home/kdog3682/.config/nvim/lua/local-plugins/nvim-grey/colors/grey.lua"

let g:linkedBufferGroups["/home/kdog3682/bkl/math/slope/0.2.0/base-triangle.typ"] = "/home/kdog3682/bkl/math/slope/0.2.0/slope-triangle.typ"
let g:linkedBufferGroups["/home/kdog3682/bkl/math/slope/0.2.0/slope-triangle.typ"] = "/home/kdog3682/bkl/math/slope/0.2.0/base-triangle.typ"

let g:wpsnippets2["typst"]["c2"] = "#import \"@preview/cetz:0.2.2\""
let g:filedict["sty"] = "/home/kdog3682/.local/share/typst/packages/local/stdlib/0.1.0/src/styles.typ"
let g:wpsnippets2["typst"]["stroke"] = "stroke: (\n    paint: $1,\n    thickness: $2,\n    dash: \"dotted\"\n)"
let g:wpsnippets2["typst"]["stdlib"] = "#import \"@local/stdlib:0.1.0\" as stdlib: *"
let g:wpsnippets2["typst"]["cetz"] = "#import \"@preview/cetz:0.2.2\"\n#import cetz.draw: *"
let g:execRef2["sfm"] = "SetFrontMatterMode"
let g:filedict["ls"] = "/home/kdog3682/2024-javascript/txflow/LineScanner.js"
let g:linkedBufferGroups["/home/kdog3682/2023/serveVite.js"] = "/home/kdog3682/.vim/ftplugin/vimrc.january2024.vim"
let g:linkedBufferGroups["/home/kdog3682/.vim/ftplugin/vimrc.january2024.vim"] = "/home/kdog3682/2023/serveVite.js"

let g:execRef2["gpa"] = "GitPushAlan"
let g:linkedBufferGroups["/home/kdog3682/2024-javascript/vuekit/staging/trigtips.vue.js"] = "/home/kdog3682/2024-javascript/vuekit/fzf.css"
let g:linkedBufferGroups["/home/kdog3682/2024-javascript/vuekit/fzf.css"] = "/home/kdog3682/2024-javascript/vuekit/staging/trigtips.vue.js"

nnoremap <leader>3 :call Node3()<CR>
function! RunJavascript(...)
    execute '!clear; node ' . join(a:000, " ")
endfunction
function! Vite(...)
    let file = CurrentFile()
    call RunJavascript("/home/kdog3682/2023/serveVite.js", 'serve', file)
endfunction
function! Roll(...)
    let file = CurrentFile()
    call RunJavascript("/home/kdog3682/2023/rollup2.js", 'serve', file)
    " /home/kdog3682/NOTES/2024-04-12.txt
endfunction
let g:execRef2["vite"] = "Vite"
let g:execRef2["roll"] = "Roll"
let g:filedict["git3"] = "/home/kdog3682/PYTHON/GithubController.py"
let g:execRef2["bda"] = "ClearBufs"
let g:filedict["vcj"] = "/home/kdog3682/my-vitesse-app/vite.config.ts"
function! SetJavascript()
    :setlocal filetype=javascript
endfunction
let g:execRef2["sj"] = "SetJavascript"

function! SetFiletypeText()
    :setlocal filetype=text
endfunction

let g:execRef2["gcf"] = "Gcf"
let g:execRef2["gcs"] = "Gcs"
let g:linkedBufferGroups["/home/kdog3682/@bkl/frontend/src/views/Dashboard.vue"] = "/home/kdog3682/@bkl/frontend/src/router/index.js"
let g:linkedBufferGroups["/home/kdog3682/@bkl/frontend/src/router/index.js"] = "/home/kdog3682/@bkl/frontend/src/views/Dashboard.vue"

let g:execRef2["st"] = "SetFiletypeText"
let g:wpsnippets2["vue"] = {}
let g:wpsnippets2["vue"]["script"] = "<script setup>\n    $c\n</script>\n\n\n<template>\n\n</template>"

let g:filedict["hkbfscesiv"] = "/home/kdog3682/@bkl/frontend/src/components/examples/SimpleIcons.vue"
let g:filedict['doc']=  "https://docs.google.com/document/d/1ZkQHnrNZDkfGveGmETJ2lXqGvR_jsC3HCw3BVM-00uk/edit"
let g:filedict['docweb']=  "https://docs.google.com/document/d/e/2PACX-1vR0Sc75Wkd8jGmw7j6Paas4Vz93pQIMySoDmq7jz1JS-wW8ZvvXQxD1vWxB7Y9sJdqMBO-tv5GhZ29p/pub"


function! PythonConnector(s)
    let state = GetVimState()
    let [key, arg]= SplitOnce(a:s)
    let state['arg'] = arg
    call SystemExec('/home/kdog3682/PYTHON/vim_package_manager.py', key, state)
endfunction
nnoremap <c-z> :ec ("'c-z' was pressed")<CR>
let g:execRef2["pc"] = "PythonConnector"
let g:temp_file = "/home/kdog3682/2024/temp.txt"
function! Go_temp_file()
    call OpenBuffer3(g:temp_file)
endfunction
nnoremap et :call Go_temp_file()<CR>
nnoremap evp :call OpenBuffer4('/home/kdog3682/PYTHON/vim_package_manager.py')<CR>
let g:linkedBufferGroups["/home/kdog3682/@bkl/packages/frontend/package.json"] = "/home/kdog3682/@bkl/package.json"
let g:linkedBufferGroups["/home/kdog3682/@bkl/package.json"] = "/home/kdog3682/@bkl/packages/frontend/package.json"

nnoremap eflb :call OpenBuffer4('/home/kdog3682/.cache/kdog3682/bkl_files.json')<CR>
let g:linkedBufferGroups["/home/kdog3682/@bkl/frontend/brooklynlearning/package.json"] = "/home/kdog3682/@bkl/frontend/package.json"
let g:linkedBufferGroups["/home/kdog3682/@bkl/frontend/package.json"] = "/home/kdog3682/@bkl/frontend/brooklynlearning/package.json"

function! Foobar()
    ec 'hooooooo'
    return 'asd'
endfunction
inoremap <expr> qh fzf#vim#complete(FzfHelper('~/@bkl', function('Foobar')))

" ExplorerViaFzf
nnoremap eftb :call OpenBuffer4('/home/kdog3682/.cache/kdog3682/bkl.directory_tree.txt')<CR>

let g:python_plugin_file= '/home/kdog3682/PYTHON/vim_package_manager.py'

function! TildaParse(s)
    return trim(Match2(a:s, '\~\~\~(.{-})\~\~\~'))
endfunction
function! Fooo()
    ec TildaParse("~~~hi\nbye~~~i")
endfunction
function! PlugPython(key, ...)
    let state = GetVimState()
    let state['command'] = a:key
    let state['args'] = a:000
    let cmd = SetupShellCommandArgs('python3', g:python_plugin_file, state)
    let res = system(cmd)
    let result = json_decode(TildaParse(system(cmd)))
    if result.success
        call call(function(result.command), result.args)
    else
        ec result
    endif
endfunction
function! GoFile2()
    call PlugPython("GoFile")
endfunction
let g:execRef2["gf2"] = "GoFile2"

let g:python_plugin_ref = {}
let g:python_plugin_ref["gf"] = "aa"

function! Abcde(path)
    let filename= input('choose a filename')
    call PlugPython('smart_create_new_file', a:path, filename)
endfunction
function! FzfDirectories(source)
    let payload = {'window': {'width': 0.88, 'height': 0.8}, 'left': '50%'}
    let payload['source'] = 'find $(pwd) -regextype posix-extended -type d | grep -vE ''(fonts|\.git/|node_modules|\.log$|temp|pycache)'''
    let payload['dir'] = a:source
    let payload['dir'] = a:source
    let payload['sink'] = function('Abcde')

    call fzf#run(payload)
endfunction
nnoremap <leader>3 :call FzfDirectories('~/@bkl')<CR>
nnoremap <leader>4 :call FzfSimple('~/@bkl/apps/examples/Repl')<CR>
let g:linkedBufferGroups["/home/kdog3682/PYTHON/vim_package_manager.py"] = "/home/kdog3682/PYTHON/api.py"
let g:linkedBufferGroups["/home/kdog3682/PYTHON/api.py"] = "/home/kdog3682/PYTHON/vim_package_manager.py"

let g:filedict["fish"] = "/home/kdog3682/.config/fish/config.fish"
let g:wpsnippets2["json"] = {}
let g:wpsnippets2["json"]["pm"] = "\"packageManager\": \"pnpm@9.0.6\","

inoremap <expr> ,,2 fzf#vim#complete(FzfHelper("~/@bkl"))
let g:execRef2["sh"] = "VShunt4"
let g:wpsnippets2["javascript"]["i"] = "import {$1} from \"./shared/getTree.js\""

let g:wpsnippets2["javascript"]["clip"] = "import { clip, appendVariable } from \"/home/kdog3682/2023/node-utils.js\""
let g:wpsnippets2["python"]["w1"] = "while True:\n    $c"
nnoremap eff :call OpenBuffer4('/home/kdog3682/.config/fish/config.fish')<CR>

let g:wpsnippets2["fish"] = {}
let g:wpsnippets2["fish"]["fun"] = "function $1\n    $c\nend"
let g:filedict["viml"] = "/home/kdog3682/2024-javascript/stdlib/vim/parser.js"


let g:jspyref3["lua"]= {}
let g:jspyref3["lua"]["functionBlockTemplate"] = "function $1(${Paramify($2)})\n\t$c\nend"


