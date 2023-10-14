let g:activeShuntFile = 0

function! Pb2snippet()
    let s = GetPasteBuffer()
    let key = ToAbrev(s)
    call AddSnippet(key, s)
endfunction

function! Paired(items)
    let items = a:items
    let parent = []
    let store = []
    let c = 0
    for item in items
        call add(store, item)
        let c += 1
        if IsEven(c)
            call add(parent, store)
            let store = []
        endif
    endfor
    return parent
endfunction

function! AddCabmap(s, ...)
    let map = a:0 >= 1 ? a:1 : 'cabmap'
    let parts = split(a:s, ' ')
    let [key, items] = SplitOnce(parts)
    let items = Paired(items)
    let s = ''
    for [a,b] in items
        let s .= '[' . SingleQuote(a) . ', ' . SingleQuote(b) . '], '
    endfor
    let s = map . ['''. key . '''] = ' . '[' . s . ']'

    call append('$', [s])
endfunction

function! WrapIt()
    let word = GetCurrentWord()
    let fnstr = input('choose fnstr: ')
    if Not(fnstr)
        let fnstr = 'Object.keys'
    endif

    let payload = fnstr . Parens(word)
    "return Replace(CurrentLine(), word, payload)
    call ReplaceCurrentLine(word, payload)
    "Object.keys(asdf.fooo)
endfunction

function! Pb2d()
    let Fn = {s -> Dedent(s)}
    return GetSetPasteBuffer(Fn)
endfunction

function! Pb2i()
    let Fn = {s -> Indent(s)}
    return GetSetPasteBuffer(Fn)
endfunction

function! GetSetPasteBuffer(fn)
    let s = GetPasteBuffer()
    let payload = FunctionGetter(a:fn)(s)
    call SetPasteBuffer(payload)
    return payload
endfunction

function! Pb2str()
    let s = GetPasteBuffer()
    let payload = 's = `' . s . '`'
    call SetPasteBuffer(payload)
    return payload
endfunction

function! FindLastBinding(r)
    let regex = ExpandPythonRegex(a:r)
    let r = '\C<' . regex . '\ze( \=|\()'
    "let match = FindWithinBlock(r, '^(function|def|class)')
    let match = FindWithinWindow(r)

    if match == 'null'

        let first = Parens(a:r[0] . '|' . Capitalize(a:r[0]))
        let r = '\C<' . first . a:r[1:] . '\w+\ze( \=|\()'
        let match = FindWithinBlock(r, '^(function|def|class)')
        if match == 'null'
            return 'null'
        endif
    endif
    return match
endfunction

function! QGetName()
    call ToPasteBuffer(GetFunctionName())
endfunction

function! AddDictItemToJavascriptDictionary()
    "let word = expand("<cword>")
    let name = GetFunctionName()
    let index = SearchFromLocation(1, '^const', 120, 'index')
    ec index
    let requireItem = '    ' . name . ','
    call append(index, [requireItem])
endfunction

function! AddAtInsertionPoint()
    let word = expand("<cword>")

  if len(word) < 3 || Test('\W|return', word)
      ec 'error'
      ec word
     return 
    endif
    ec word
    ec 'adding word ' . word
    let regex = '^//INSERTION-POINT'
    call MarkPosition()
    call OpenBuffer('/home/kdog3682/CWF/public/TextEditor.js')
    call ExecuteRegex('INSERTION-POINT')
    call AppendBelow(line('.'), '    ' . word . ',')
    let value = Templater('module.exports.$0 = $0', word)
    call AppendFile('/home/kdog3682/CWF/public/utils.js', value)
    call ReturnPosition()
endfunction

function! AddReq()
    let word = expand("<cword>")
    let index = SearchFromLocation(1, 'require.{-}utils.js', 160, 'index')
    let requireItem = '    ' . word . ','
    if index > -1
        call AppendAbove(requireItem, index)
        let value = Templater('module.exports.$0 = $0', word)
        call AppendFile('/home/kdog3682/CWF/public/utils.js', value)
    else
        ec 'err'
    endif

endfunction

function! Qk()
    return 'consoleThrow("line-number: ' . line('.') . '"' . ", )\<LEFT>"
endfunction

function! QGetReadFile()
    return Templater('s = read($qgp)')
endfunction

function! Qlog()
    return 'console.log("line-number: ' . line('.') . '"' . ", '')\<LEFT>\<LEFT>"
    "console.log("lin", 400, sf)
endfunction


function! PuppetRunner()
    "let file = Tail(CurrentFile())
    call Node('/home/kdog3682/CWF/public/puppet.js', CurrentFile())
endfunction

function! QJConnector()
    if !exists('g:qjdestination') || !Exists(g:qjdestination)
        let a = input('choose file:')
        let b = get(g:filedict, a)
        if Exists(b)
            let g:qjdestination=b
        endif
    endif
    call Node(g:qjdestination)
endfunction

function! ReplaceWordUnderCursor100()
    let word = expand("<cword>")
    let r = Prompt('replacement')
    if !Exists(r)
        let r = GetPasteBuffer()
        if Test(r, '\s')
            let r = Prompt('replacement:')
        endif
    endif
    call ExecuteReplace(word, r)
endfunction

function! Qgr()
    let file = input('file')
    let file = g:filedict[file]
    let b = file
    let a = RemoveExtension(Tail(b))
    "let [a,b] = SplitOnce(input('func &&file'))
    call Append('const { ' . a . ' } = require("' . b . '")')
endfunction

function! GoScratchpad()
    execute "edit s.js"
endfunction

function! Qggf()
    "let word = GetCurrentWord()
    "return word
    "call ReplaceCurrentLine(word, get(g:filedict, word, 'foo'))

endfunction

function! QNext()
    call ExecuteRegex('}')

    "}
endfunction

function! IterFind(s, ...)
    let s = a:s
    
    let regexes = a:000
    for regex in regexes
        let r = FindallStrings(s, regex)
        if Exists(r)
            return r
        endif
    endfor
    return []

endfunction

function! S1()
    "searches for a name
    let name = GetFunctionName()
    call ExecuteRegex(name)
endfunction

function! I1()
    let a = Prompt()
    let s  =GetLastBinding()
    let v =Templater('$0 = $1($0)', [s, a])
    call AppendAbove(v)

endfunction

function! QGetPath()
    let s = SingleQuote(CurrentFile())
    call ToPasteBuffer(s)
endfunction

function! AppendBelowMarkZ()
    let line = GetPos("'z")[0]
    let repl = expand("<cword>")
    call append(line, [Replace(getline(line), '\w+', repl)])
endfunction

function! AppendFtAndEval(s)
    let lang = GetLang()
    "return lang
    let s = a:s
    ec s
    let dict = {}
    let dict['js'] = "/home/kdog3682/.vim/ftplugin/javascript.vim"
    let dict['py'] = "/home/kdog3682/.vim/ftplugin/python.vim"
    let dict['html'] = "/home/kdog3682.vim/ftplugin/html.vim"
    let dict['math'] = "/home/kdog3682/.vim/ftplugin/math.vim"
    let dict['txt'] = "/home/kdog3682/.vim/ftplugin/txt.vim"

    if lang == 'vim'
        call append('$', [s])
    else
        call AppendFile(dict[lang], s)
    endif
    execute s
endfunction

function! FileFromCurrentFile()
    let f = FindFileString(CurrentLine())
    if Exists(f)
        let h = Head(CurrentFile())
        if Test(h, '^\w')
            let h = '/' . h
        endif
        let f = PathJoin(h, f)
        call ToPasteBuffer(f)
        execute "edit " . f
    endif
endfunction

function! IsDir(s)
    return isdirectory(a:s)
endfunction

function! GetLastBindings()
    let index1 = Search('\w+\ze \=', 'bn')
    let line = Match(getline(index1), '\w.{-}\ze \=')
    let matches = FindallStrings(line, '\w+')
    let matches = filter(matches, '!Test(v:val, "let|const")')
    return matches
endfunction

function! ToRequireImport(file, items, ...)
    let ifwin = a:0 >= 1 ? a:1 : 0
    let file = a:file
    let items = IsString(a:items) ? [a:items] : a:items
    let requireItems = map(items, '"    " . v:val . ","')
    if !Test(file, '^/')
        let file = './' . file
    endif
    let requireStatement = '} = require(''' . file . ''')'
    let comment = Comment('toc' . raw)
    let lines = [''. 'var {', requireItem, requireStatement, comment, '', '']
    if Exists(ifwin)
        call insert(lines, [g:ifwin, ''])
    endif
    return lines
endfunction

function! CreateJSApp(s)
    let s = a:s
    let name = '/home/kdog3682/CWD/app-'  . s . '.js'
    if IsFile(name)
        execute "buffer " . name
        return 
    endif

    call Chdir('cwd')
    execute "buffer " . name
    call setline('.', lines)
    call AddFileShortcut(name)
endfunction

function! BeforeEnterJs()
    call CommentOutImports()
    ec 'hi'
endfunction

function! BeforeLeaveJs()
    call CommentOutImports()
    ec 'hi leave'
endfunction

function! ListMapItem(key) abort
  redir => redirbuf
  silent execute a:key
  redir END   
  let redirbuf = substitute(redirbuf, '^\_s*', '', '')
  return redirbuf
endfunction

function! GetDateAndLocation() 
    let date = strftime('%m-%d-%Y %I:%M:%S%p')
    return date
    let loc = g:physical_location
    return date . ' ' . loc
endfunction



function! Split1(i, arg)
    let i = [400, 401]
    let lines = map(GetLines(i), 'SplitOnce(trim(v:val))')
    ec lines
endfunction


function! EscapeQuotes(s)
    let s = a:s
    let s = '"hi'''
    return 
    
endfunction

function! VisualAddPyDictItem(indexes)
    "let indexes = a:indexes
    let indexes = [400, 402]
    let lines = Dedent(GetLines(indexes))
    let s = join(lines, '\n')

    ec s
endfunction

function! JoinComma(notlast) 
    let notlast = a:notlast
    if IsString(notlast)
        return Replace(notlast, ' ', ', ')
    endif
    return join(notlast, ', ')
endfunction

function! ClrFile()
    exec "1,$d"
endfunction

function! ListMaps(prefix) abort
  redir => redirbuf
  silent execute 'map ' . a:prefix
  redir END   
  let redirbuf = substitute(redirbuf, '^\_s*', '', '')
  return redirbuf
endfunction

function! SMJ(s, delimiter, f, j)
    let s = a:s
    let delimiter = a:delimiter
    let f = a:f
    let j = a:j
    let fstr = Test(f, 'v:val') ? f : f . '(v:val)'
    return join(map(split(s, delimiter), fstr), j)
endfunction

function! F1(s)
    return SMJ(a:s, ' ', 'SingleQuote', ', ')
endfunction

function! BasePY(s)
    let s = a:s
    let ref = g:basepyref
    let [a,b] = SplitOnce(s)
    ec [a, b]
    if has_key(ref, a)
        let s = trim(ref[a]) . ' ' . trim(b)
    endif
    if Test(s, '^:')
        let s = 'base.py ' . s[1:]
        let items = split(s, ' ')
        let parsed = map(items, 'ArgConverter2(v:val)')
        let arg = join(parsed, ' ')
        return Python('/home/kdog3682/CWF/run.py', arg)
    elseif has_key(ref, a)
        let template = ref[a]
        let items = split(template, ' ')

        if Exists(b)
            call add(items, trim(b))
        endif
        let parsed = map(items, 'ArgConverter2(v:val)')
        let arg = join(parsed, ' ')
        return Python('/home/kdog3682/CWF/run.py', arg)
    else
        ec s . ' not in ref. returning from vimrc.'
        return 
    endif
endfunction

function! PyConnector2()
    call Python('/home/kdog3682/CWF/base.py', s)
endfunction

function! TNote()
endfunction


function! Black()
    let file = CurrentFile()
    let command = "!black -l 60 " . file
    ec command
    exec command
endfunction

function! SayHiFrom(line, word)
    let line = a:line
    let word = a:word
    return Logger(SingleQuote(Templater('Saying hi from $0 @ $1', [GetBindingName(), word])))
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

function! Go(key)
    let key = a:key
    if key == 'dl'
        call OpenBuffer("/mnt/chromeos/MyFiles/Downloads/folder-info.json")
    endif
endfunction

function! WriteAllMaps() abort
    let store = {}
    let keys = ['imap', 'iab', 'nmap']
    for key in keys
        let store[key] = ListMapItem(key)
    endfor
    call WriteJson('vim-maps.json', store)
endfunction

function! AddMoreNormalRefsToCMHTML(s)
    let s = 'globalNormalRefs.$0 = globalNormalRefs.$1'
    if Test(a:s, '\(')
        let s = 'globalNormalRefs.$0 = () => {($1); return "$0"}'
    endif
    let s = Templater(s, SplitOnce(a:s))
    call AppendFile('/home/kdog3682/CWF/public/more-refs.js', s)
endfunction

function! Boo()
    ec Test('data() {', 'data\(\) \{')
endfunction

function! TextSearcher(s)
    let index = line('.') - 1
    while index > 0
        let line = getline(index)
        let index -= 1
        if !Test(line, '\= ')
            continue
        endif

        if Test(line, a:s)
            return line
        endif
    endwhile
    return 'NULL'
endfunction

function! VueNav(key)
    let key = a:key
    let r = g:vuenavdict[key]
    let top = GetFunctionIndex()
    let index = FindLineIndex(top, r)
    if index < 0
        return 
    endif
    let index += 3
    call SetCursor(index)
endfunction

function! QNavTemplate()
    call VueNav('template')
endfunction

function! QNavData()
    call VueNav('data')
endfunction

function! QNav()
    call VueNav('')
endfunction

function! QNavConstructor()
    call VueNav('constructor')
endfunction

function! GetLineRange(lines, a, b)
    let lines = a:lines
    let a = a:a
    let b = a:b
    let found = 0
    let store = []
    for line in lines
        if Test(line, a)
            let found = 1
            continue
        elseif found == 1
            if Test(line, b)
                break
            endif
            call add(store, line)
        endif
    endfor
    return store
endfunction

function! InsertAfter(index, regex, payload)
    let index = a:index
    let regex = a:regex
    let target = FindLineIndex(index, regex)
    call AppendBelow(target, [payload])
endfunction

function! Qad()
    let word = GetCurrentWord()
    let start = GetFunctionIndex()
    call InsertAfter(start, 'return \{', word . ',')
endfunction

function! Qac()
    let lines = GetFunction()
    let lines = GetLineRange(lines, '`', '`')
    let matches = map(lines, "Findall3(v:val, '\\v\\C<[A-Z][a-zA-Z]{2,}>')")
    let items = Unique(Flat(matches))
    return "components: {" . "\<CR>" . join(items, ",\<CR>") . ",\<CR>},"
endfunction

function! SetRunOver(s)
    let g:runover = a:s
    call AppendVim('let g:runover = ' . SingleQuote(a:s))
endfunction

function! Zrl()
    let word = expand("<cword>")
    "return word
    let value = input('')
    "sdf sdf
    call GetSet2({s -> Sub(s, word, value)})
endfunction

function! QCopyPath()
    
endfunction

function! ReturnPosition()
    execute "'Z"
endfunction

function! MarkPosition()
    call Mark('Z')
endfunction

function! GoToActiveFileAndDictionaryAndAppendEntry()
    let name = GetBindingName()
    call MarkPosition()
    call OpenBuffer(g:activeFile)
    call ExecuteRegex('^const ' . g:activeDictionary)
    call AppendBelow(line("."), name . ',')
endfunction

function! Fodfgo()
    
    let regex = '\<!--insertion-point--\>'
    let res =  ExecuteRegex(regex)
    ec res
    "let s = "<!--insertion-point-->"
    "return Test(s, regex)
endfunction

function! AppendActiveHtmlFile()
    let n = Tail(CurrentFile())
    let t = "<script charset=\"utf8\" src=\"$0\"></script>"
    let t = Templater(t, [n])

    call MarkPosition()
    call OpenBuffer(g:activeHtmlFile)
    let res = ExecuteRegex('\<!--insertion-point--\>')
    call AppendBelow(line("."), t)
endfunction

function! SetActiveHtmlFile(...)
    let name= a:0 >= 1 ? a:1 : Prompt('file name? (dont need to write an extension    ') . '.html'
    if !Test(name, 'html')
        let name .= '.html'
    endif
    let g:activeHtmlFile = name
    call AppendVim('let g:activeHtmlFile = ' . SingleQuote(name))
endfunction

function! SetActiveFileAndDictionary()
    let g:activeFile = CurrentFile()
    let g:activeDictionary = GetBindingName()
    ec g:activeFile
    ec g:activeDictionary
    let lines = [
  \'let g:activeFile = ' . SingleQuote(g:activeFile),
  \'let g:activeDictionary = ' . SingleQuote(g:activeDictionary),
    \]
    call AppendVim(lines)
endfunction

function! GoP()
    let line = CurrentLine()
    let name = Match(line, '\w+\ze\(')
    call ExecuteRegex(name)
endfunction

function! Saveas(s)
    let s = a:s
    execute "saveas! " . s
endfunction

function! AnythingHandler(s)
    let s = a:s
    let [key, arg] = Test(s, '^/') ? ['/', s[1:]] : SplitOnce(trim(s))

    if key == 'js'
        call MarkPosition()
        call OpenBuffer('/home/kdog3682/CWF/public/utils.js')
        call AppendBottom(ConsoleLog(arg))
        return 
    elseif has_key(g:vuenavdict, s)
        return VueNav(s)
    elseif key == '.'
        call MagicVueHandler(line('.'), getline('.'))

    elseif key == '/'
        call AppendBelow(line('.'), TextSearcher(arg))
    elseif key == '1'
        let g:A = GetCurrentWord()
        let g:posA = GetPos()
        return 
    elseif key == '2'
        let g:B = GetCurrentWord()
        let g:posB = GetPos()
        call ExecuteReplaceOnce(g:B, g:A)
        call SetPos(g:posA)
        call ExecuteReplaceOnce(g:A, g:B)
    elseif key == '3'
        call SetPos(g:posA)
        call ExecuteReplaceOnce(g:B, g:A)
        call ExecuteReplaceOnce(g:A, g:B)
        call SetPos(g:posB)
        return 
    elseif has_key(g:ldrdict, key)
       if Exists(arg)
           call function(g:ldrdict[key])(arg)
       else
           call function(g:ldrdict[key])()
       endif
        "return function(g:vuenavigationdict[s])()
    elseif IsNumber(s)
        call Cursor(s)
    elseif has_key(g:filedict, s)
        return OpenBuffer(g:filedict[s])
    elseif s == 'wq'
        return 
    elseif s == 'x'
        return 
    elseif s == 'x'
        return 
    elseif Exists(g:runover)
        call FunctionGetter(g:runover)(s)
    else
        execute s
    endif
endfunction


function! ToCss(s)
    let s = a:s
    let name = DashCase(s)
    return '.' . name . " {\n\n}\n"
endfunction

function! WriteDictionary(key)
    let key = a:key
    let value = eval('g:' . key)
    let output = {}
    for [a,b] in items(value)
        try
            if IsFunction(b)
                continue
            endif
            let output[a] = b
        catch
            ec 'hi'
        endtry
    endfor

    call WriteJson(key . '.json', output)
endfunction

function! DashCase(s)
    let s = a:s
    return join(map(split(s, '\ze[A-Z]'), 'tolower(v:val)'), '-')
endfunction

function! GatherLargeQuotes()
    let s = GetWindowText()
    let m = FindallStrings(s, '["'']\zs[a-zA-Z-]{8,}\ze[''"]')
    let m = map(m, 'ToCss(v:val)' )
    let v = join(m , "\n")
    call ToPasteBuffer(v)
    return m
endfunction

function! Qgt()
    let key = Prompt()
    let name = Exists(key) ? get(g:filedict, key) : CurrentFile()
    if !Exists(name)
        let key = Prompt('key doesnt exist try again')
        let name = Exists(key) ? get(g:filedict, key) : CurrentFile()
    endif
    let file = Tail(name)
    return file
endfunction

function! AddNameToDictionary()
    let dict = {
        \'TextEditor.js': 'TEDictionary',
        \'codemirror-component.js': 'EditorCommands',
        \'.vimrc': 'Ann',
    \}
    let file = Tail(CurrentFile())
    let name = GetBindingName()
    let ref = get(dict, file)
    let found = ExecuteRegex("^(let|const|var|function) " . ref)
    if Exists(found)
        let payload = '    ' . SingleQuote(ToAbrev(name)) . ': ' . name . ','
        call Append(payload)
    endif
    return found
endfunction

function! Announcement(payload, announce)
    let payload = a:payload
    let announce = a:announce
    if announce
        ec payload
    endif
endfunction

function! GetBlockContext()
  " foo {
    return SprawlMatch('\w+\ze\(.{-}\) *\{$')
endfunction

function! AddHtmlScript()
    let n = Tail(CurrentFile())
    let t = "<script charset=\"utf8\" src=\"$0\"></script>"
    let t = Templater(t, [n])
    let file = g:active_html_file
    let lines = readfile(file)
    let jsfile = 'r3c.js'
    let i = FindLineIndex(lines, jsfile)
    "ec [lines[i], lines[i - 1], lines[i + 2]]
    let spaces = GetSpaces(lines[i])
    "ec [spaces]
    let t = spaces . t
    "ec [t]
    "return
    call appendbufline(file, i, t)
    call GoToFileThenGoToLine(file, i)
endfunction

function! ToggleHtmlScripts()
    let file = g:active_html_file
    let lines = ReadFile(file)
    "ec lines
    "let
    "<head>
        "<script charset="utf8" src="randomColor.js"></script>
        "<link rel="stylesheet" href="normalize.css"/>
        "<script charset="utf8" src="vue.js"></script>
        "<script charset="utf8" src="vuex.min.js"></script>
        "<script charset="utf8" src="utils.js"></script>
        "<script charset="utf8" src="css-utils.js"></script>
        "<script charset="utf8" src="browser.js"></script>
        "<script charset="utf8" src="vue-utils.js"></script>
        "<script charset="utf8" src="store.js"></script>
    "</head>
endfunction

function! FlashWrite()
    let t = 'flashWrite("Flashwriting:", "$0", "$1")'
    let t = '$f("@","$0","@upline","$1")'
    let a = GetBindingName()
    let b = trim(UpLine())
    return Templater(t, [a, Replace(b, ' *[\{\[]', '')])
endfunction

function! GoLambdaFunction()
    call ExecuteRegex('    (const \w+ = =>|function)', 1)
    "execute "/function<CR>"
endfunction

function! GoToScratchpad()
    call OpenBuffer('scratchpad.js')
endfunction

function! MarkFile()
    let key = Prompt('mark file with text', 'd')
    call AppendFile('folder-info.txt', key . ' ' . Tail(CurrentFile()))
endfunction

function! ExecuteReplace100(a)
    let [a,b] = SplitOnce(a:a)
    "let a = a:a
    "let b = a:b
    
        let caseSensitive = 1 ? "\\C" : ""
        let cmd =  "%substitute/\\v" . caseSensitive . a . "/" . b . "/g"
        execute cmd
endfunction

function! Dog()
    if line('.') == line('$')
        let a = "<doglog\\(.{-}\\)"
        let b = ''
        ec 'removing dogs'
        return ExecuteReplace100(a, b)
    endif
        
    call Append('doglog()')
endfunction

function! AppendUtils(s)
    call AppendFile('/home/kdog3682/CWF/public/utils.js', a:s)
endfunction

function! OnVimStartupEnter()
    call AppendVim(Comment(DateStamp()) . '\n\n')
    call AppendUtils(Comment(DateStamp()) . '\n\n')
    call Chdir('pub')
endfunction

function! Set(s)
    let [a,b] = SplitOnce(a:s)
    if Exists(b)
        let g:setdict[a] = b
    else
        let s = a
        if has_key(g:setdict, s)
            let g:setdict[s] = 0
        else
            let g:setdict[s] = 1
        endif
    endif
    ec g:setdict
endfunction

function! RunSetFile()
    ec 'not inusse'
    "if has_key(g:setdict, 'run')
    "let value = GetSetDictValue('run')
    "if value

endfunction

function! GetLastLine(file)
    let file = a:file
    let file = '/home/kdog3682/CWF/public/puppet.js'
    let value = readfile(file)
    let last = value[-1]
    return last
endfunction

function! AppendPupFast(...)
    let s = a:0 >= 1 ? a:1 : ''
    let A = 'cm'
    let file = '/home/kdog3682/CWF/public/puppet.js'
    let last = GetLastLine(file)
    let B = Test(last, 'Enter') ? '' : 'Enter'
    let s = Templater('run3("$0 $1")', [A, B])
    ec s
    call AppendFile(file, s)
endfunction

function! AppendPup(...)
    let text = a:0 >= 1 ? a:1 : ''
    let name = g:activeHtmlFile
    let s = Templater('run3("$0 $1")', [name,text])
    call AppendFile('/home/kdog3682/CWF/public/puppet.js', s)
    "call appendbufline('/home/kdog3682/CWF/public/puppet.js', 400, s)
endfunction

function! AppendBeforeEndOfFile(s)
    call Append(a:s, line('$') - 1)
endfunction

function! OpenVimActiveFiles()
    call Chdir('pub')
    let files = g:activefiles

    for file in files
        ec file
        execute "edit " . file
    endfor
endfunction

function! GetWordVariations(s)
    let s = a:s
    let s = 'hi.bo.ga'
    let items = split(s, '\W')
endfunction


function! SnippetHelper(template, parts)
    let template = a:template
    let parts = a:parts
    let line = ''

    let Lambda = {x -> function('Pst')(x, parts, line)}
    let r = '\$(\{.{-}\}|\d+(--[a-z])?|[a-zA-Z]{3,})'
    let snippet = Sub(template, r, Lambda)
    return snippet

    "let cursorpos = GetCursorFromStringSnippet(snippet)
    "let snippet = Replace(snippet, '\$c', '')
    "let spaces = CurrentSpaces()
    "call TextPlacement(SplitLines(snippet), spaces)
    "call SetCursor(cursorpos, spaces)
    "return snippet
endfunction

function! AutoTab()
    let word = GetCursorWord()
    if len(word) < 1
        return "\<TAB>"
    endif

    let lang = GetLang()
    let line = CurrentLine()

    let value = ''
    if exists('g:iabhistory')
        let value = get(g:iabhistory, word)
    endif

    if !Exists(value)
        let value = WordSpiral(word)
    endif

    if Exists(value)
        return Repeat("\<BS>", len(word)) . value
    
    if lang == 'js'
        let value = get(g:jsfndict, word)
    elseif lang =='vim'
        let words = g:vimfns
        let value = Find(words, {s -> ToAbrev(s) == word || Test(s, '\C^' . word)})
    endif

    if Exists(value)
        return Repeat("\<BS>", len(word)) . value
    endif

    return "\<TAB>"

endfunction
function! Chdir(...)
    let s = a:0 >= 1 ? a:1 : ''
    ec s
    let orig = s
    if !Exists(s)
        let s = Head()
        ec s
        execute "cd " . s
        return 
    endif
    if IsDir(s)
        ec s
        execute "cd " . s
        return 
    endif

    let dict2 = {
    \    'download': "/mnt/chromeos/MyFiles/Downloads",
    \    'cwd': '/home/kdog3682/CWD/',
    \    'cwf': '/home/kdog3682/CWF/',
    \    'pub': '/home/kdog3682/CWF/public/',
    \}
    let s = get(dict2, s)
    if Exists(s)
        ec s
        execute "cd " . s
        return 
    endif

    let s = orig
    let dict = {
        \'cwd': 'CWD',
        \'cwf': 'CWF',
    \}
    let s = get(dict, s)
    if Exists(s)
        ec 'n'
        let dir = getcwd()
        let tail = Tail(dir)
        if tail != s
            execute "cd " . "/home/kdog3682/" . s
            ec 'changing dir'
        endif
    else
        let destination= "/home/kdog3682/CWF/" . orig
        execute "cd " . destination
        ec destination
    endif
endfunction

function! SplitOnCursor()
   let s = CurrentLine()
   let a = getpos('.')[2]
   let b = s[0:a - 2]
   let c = s[a - 1:]
   return [b, c]
endfunction

function! Qrn()
    let rename = Prompt()
    if !Exists(rename)
        let rename = 'foo'
    endif
    let [a,b] = SplitOnCursor()
    let s = CreateVariable(rename, b[0:-2])
    let t = a . rename . ')'
    call setline('.', t)
    call AppendAboveNew(s)
endfunction

function! GoToWordUnderCursor()
    let word = WordUnderCursor()
    call ExecuteRegex(Boundary(word))
endfunction

function! CommentOutImports()
    call Search('^var \{|^// var \{')
    let clean = Match(getline('.'), '^var')
    let upindex = line('.')
    call Search('//end')
    let downindex = line('.') - 1
    if Exists(clean)
        call GS4([upindex, downindex], 'Comment')
    else
        call GS4([upindex, downindex], 'UnComment')
    endif
    
endfunction

function! GoConsole()
    call ExecuteRegex('^console')
endfunction

function! ReplaceFunctionName(...)
    let s = GetPasteBuffer()
    call ReplaceCurrentLine('\w+ \zs\w+', s)
endfunction

function! GetBindings(s)
    let s = a:s
    let s = Match(s, '.{-}\ze \=')
    let m = FindallStrings(s, '\w+')
    let m = filter(m, '!Test(v:val, "^let|^const|^var")')
    return m
endfunction

function! GoToFileAndThenFunction()
    let [file, fn] = SplitOnce(input('filekey | fnkey?'))
    if !Exists(fn)
        let fn = GetCurrentWord()
    endif

    let file = FileGetter2(file)
    call GoToBuffer(file)
    call ExecuteFunctionSearch(fn)
endfunction

function! GoError()
    call ExecuteRegex('console.{-}throw')
endfunction

function! GoUtils()
    let word = GetCurrentWord()
    let file = '/home/kdog3682/CWF/public/utils.js'
    call GoToBuffer(file)
    call ExecuteFunctionSearch(word)
endfunction

function! IterMatch(line, regexes)
    let line = a:line
    let regexes = a:regexes
    for regex in regexes
        let m = Match(line, regex)
        if Exists(m)
            return m
        endif
    endfor
endfunction


function! GoFunction()
    let line = CurrentLine()
    let r = ['function\(''\zs\w+', '[ \(]\zs\w+\ze\(', '\= "\zs\w+', '\= \zs\w+']
    let m = IterMatch(line, r)
    if !Exists(m)
        let m = GetCurWord()
        ec m
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
"let g:ldrdict['r'] = function('ReadItem')

function! IndexGetter(index)
    let index = a:index
    if index == '.'
        return line(index)
    elseif index == 0
        let index = 1
    elseif IsNumber(index)
        return index
    else
        return line(index)
    endif
endfunction

function! GetFunctionNameAndParameters(...)
    let line = a:0 >= 1 ? a:1 : getline(GetFunctionIndex())
    let name = GetFunctionName(line)
    let p = GetParameters(line)
    return [name, p]
endfunction

function! Callable(a, b)
    let a = a:a
    let b = a:b
    return a . Parens(b)
endfunction

function! ToInputArg(p)
    let p = a:p
    if len(p) == 0
        return ''
    endif
    ec 'write an arg'
    let i = input('')
    if IsNumber(i)
        return i
    else
        return i
        "return SingleQuote(i)
    endif
endfunction

function! TestPrint2()

    let line = getline('.')
    if Test(line, 'return')
        let [variablePrefix, cs, ce] = JSPY('variablePrefix', 'consoleThrow', 'consoleEnd')
        let a = substitute(Strip(line), 'return ', variablePrefix . 'p = ', '')
        let b = cs . 'p' . ce
        let c = 'return p'
        let items = [a,b,c]
        let spaces = GetSpaces(line)
        call TextPlacement(items, spaces)
        return 'vv'
    endif

    let [name, parameters] = GetFunctionNameAndParameters()
    let statement = Logger(Callable(name, ToInputArg(parameters)))
    call Append(statement, '$')
    call Cursor('$')
endfunction

function! GetCurWord()
  let repl = expand("<cword>")
  return repl
endfunction

function! MoveLineToPreviousEnd()
    let prev = trim(DeleteLine())
    let index = line('.') - 1
    call GetSet(index, {s -> s . ' ' . prev})
endfunction

function! AddComponentList()
    let word = GetCurWord()
    let index = GetFunctionIndex()
    ec index
    "return
    let s = '    components: {' . Pascal(word) . 'Component' . ' },'
    call AppendBelow(index, s)
endfunction

function! TgCols()
    "calling it like this because it is the initial instance of showing up
    "the first time needing ... eh no.
endfunction

function! IsQuestionFile()
    return CurrentFile() == '/home/kdog3682/CWF/questions.txt'
endfunction

function! NormalQManager(s)
    if IsQuestionFile()
endfunction

function! QTest()
    let line = getline(GetFunctionIndex())
    let name = Match(line, g:functionlookaheadRE)
    let args = Match(line, '\(\zs\w.{-}\ze\)')
    if Exists(args)
        if args == 'file'
            let args = CurrentFile()
        elseif args == 'foo'
            let args = CurrentFile()
        endif
    endif

    if Exists(args)
        let args = Quotify(args)
    else
        let args = ''
    endif

    let statement = name . '(' . args . ')'
    let statement = Logger(statement)
    call setline('$', statement)
    "call ConstructInvivoFunction()
endfunction

function! OpenPdf(s)
    call JspyConnector('open', a:s)
endfunction


function! TableOfContents()
    let lines = getline(0, 100)

endfunction

function! AddModuleExport()
    let file = Basename(CurrentFile())
    let name = GetFunctionName()
    if file == 'c.js'
        call append('$', Templater('commands.$0 = $0', name))
    else
        call append('$', Templater('module.exports.$0 = $0', name))
    endif
endfunction

function! ToArguments(s)
    let s = trim(a:s)
    if !Exists(s)
        return ['s']
    endif
    let items = Test(s, '  ') ? split(s, '  ') : split(s)
    let items = map(items, 'IsNumber(v:val) ? v:val : SingleQuote(v:val)')
    return items
endfunction

function! ConstructInvivoFunction()
    let line = CurrentLine()
    "let line = 'a b'
    let args = ToArguments(line)
    let name = GetFunctionName()
    let value = Logged(name . Parens(join(args, ', ')))
    "return value
    call setline('.', value)
endfunction

function! GetModuleImports()
    let lines = getline(0, 80)
    "let lines = ['    hiBc', 'a']
    let lines = filter(map(lines, 'Match(v:val, ''^    \zs[a-z]+[A-Z]+\w+'')'), 'len(v:val) > 1')
    return lines
endfunction

function! AddModuleExportToOtherFile()
    let word = GetCurrentWord()
    let items = [word]
    let regex = 'require\(''./\zs\S{-}\ze'''
    let file = SearchFromLocation('.', regex , 10, 'match', 'down')
    ec file
    call AppendFile(file, map(items, '"module.exports." . v:val . " = " . v:val'))
endfunction

function! SearchAbrevAddAbrevIab(s)
    let s = a:s
    let s = 'sm'
    let regex = 'S[a-z]+M'
    "let regex = ExpandPythonRegex2(s)
    "return regex
    let word = SprawlMatch(regex)
    return word
endfunction

function! VisualWord(s)
    let arg = a:s
    let word = GetCurrentWord()

    if arg == 'm'
        return ExecuteRegex('\w+\.' . word)
    else
        let regex = '<' . word . '>'
        let Fn = {s -> Sub(s, regex, arg)}
        call GS4(GetCodeIndexes(), Fn)
    endif
endfunction

function! IsRange(x)
    return IsNumber(a:x[0]) && IsNumber(a:x[1]) && len(a:x) == 2
endfunction

function! SearchScreen(regex, mode)
    let regex = a:regex
    let mode = a:mode
    let indexes = GetWindowIndexes()
    if mode == 'index'
        return FindIndex(indexes, regex)
    else
        return Find(indexes, regex)
    endif
endfunction

function! AddJsMethod()
    let name = GetFunctionName()
    let className = GetOrSetGVariable('classNameVisibleInScreen')
    let regex = 'new ' . className
    let index = SearchFromLocation('$', regex, 1000, 'index')
    if index < 1
        let index = SearchScreen(regex, 'index')
    endif

    call AppendAbove(className . ".prototype." . name . " = " . name, index)
endfunction

function! UnComment(s)
    let s = a:s
    return Replace(s, JSPY('comment') . ' *', '')
endfunction


function! GetModuleExports(file)
    let file = a:file
    let lines = readfile(file)
    let items = filter(lines, 'Test(v:val, "^module")')
    return map(items, 'Match(v:val, ''\.\zs\w+'')')
endfunction

function! AddJsImports()
    let file = Prompt('choose the file that you want to import')
    if !Exists(file)
        return 
    endif
    let file = AddExtension(file, 'js')
    let lines = []
    let items = GetModuleExports(file)
    if !Exists(items)
        let items = split(Prompt('no import items... write your own, delimited by spaces'))
        call AppendFile(file, map(items, '"module.exports." . v:val . " = " . v:val'))
    endif

    call add(lines, '')
    call add(lines, 'var {')
    call extend(lines, map(items, '"    " . v:val . ","'))
    call add(lines, '} = require("./' . file . '")')
    call add(lines, '')
    call append(1, lines)
endfunction

function! AddRequireItemToTAndU()
  let word = GetCurrentWord()
  if len(word) < 3 || Test('\W|return', word)
      ec 'error'
      ec word
     return 
    endif
    ec word
    return 
  "let value1 = Templater('module.exports.$0 = $0', word)
  "let value2 = Templater('var $0 = utilsjs.$0', word)
  "call AppendFile('/home/kdog3682/CWF/public/utils.js', value1)
  "call AppendFile('/home/kdog3682/CWF/public/TextEditor.js', value2)
endfunction

function! AddRequireItem()
    let word = GetCurrentWord()

    if !Exists(word)
        let word = GetFunctionName()
    endif
    let index = SearchFromLocation(1, 'require.{-}utils.js', 60, 'index')
    let value = Templater('module.exports.$0 = $0', word)
    let requireItem = '    ' . word . ','
    if index > -1
        call AppendAbove(requireItem, index)
        call AppendFile('/home/kdog3682/CWD/utils.js', value)
    else
        let raw = Prompt('choose a file')
        let file = FileGetter2(raw)
        let lines = ToRequireImport(file, word, 'ifwin')
        call append(0, lines)
    endif
endfunction

function! GetOrSetGVariable(s, ...)
    let s = a:s
    if !exists('g:' . s)
        ec 'choose g-value for ' . s
        let value = a:0 >= 1 ? a:1 : input('')
        execute "let g:" . s . ' = ' . SingleQuote(value)
    endif

    return eval('g:' . s)
endfunction

function! SearchFromLocation(startindex, regex, depth, mode, ...)
    let direction = a:0 >= 1 ? -1 : 1
    let startindex = a:startindex
    if startindex == '$'
        let direction = -1
        let startindex = line('$')
    elseif startindex == '.'
        let direction = 1
        let startindex = line(startindex)
    endif

    let regex = a:regex
    let depth = a:depth
    let mode = a:mode
    let c = startindex
    let _c = 0
    while _c < depth
        let line = getline(c)
        if Test(line, regex)
            if mode == 'index'
                return c
            elseif mode == 'match'
                let match = Match(line, regex)
                return match
            endif
        endif

        let _c += 1
        let c += direction
    endwhile
    return -1
endfunction

function! GetJsRequire()
    call JspyConnector('req', 'cf')
endfunction

function! RegisterJsImportExport()
    let word = GetCurrentWord()
    let key = word
    let file = key . '.' . GetExtension()
    
    let c = 2
    while 1
        let line = getline(c)
        let c += 1
        if !Exists(line)
            break
        endif
        let spaces = GetIndent(line)
        if spaces == 0
            let c -= 1
            break
        endif
    endwhile

    let c -= 1
    "ec c

    let insertion = 'var {' . key . '} = require(''./' . file . ''')'
    "ec insertion
    call append(c, ['', insertion, ''])

    let lines = [
        \'',
        \'',
        \'',
        \'',
        \'module.exports.' . key . ' = ' . key
    \]

    let outpath = key . '.' . 'js'
    ec outpath
    call AppendFile(outpath, lines)
endfunction

function! Fok()
    let s = '"abc"[:-2]'
    let s = Replace(s, '\$1', '"$1"')
    ec eval(s)
endfunction

function! UnConsoleLog(...)
    let s = a:0 >= 1 ? a:1 : CurrentLine()
    
endfunction

function! GoToAction(key)
    let key = a:key
    if key == 'constructor'
        call ClassSearch(key)
    endif
endfunction

function! SetManager(s)
    let s = 'hii'
    let [a,b] = SplitOnce(s)
    let file = 
    if Exists(file)
        let g:shuntdestination = file
        ec 'setting shunt destination as ' . file
    endif
endfunction

function! Reset()
    ec 'resetting'
    let g:shuntdestination =''
endfunction

function! TransferBlock()
    let indexes = GetCodeIndexes()
    let lines = GetLines(indexes)
    if !exists('g:shuntdestination') || !Exists(g:shuntdestination)
        let a = input('choose file:')
        if !Exists(a)
            ec 'return'
            return 
        endif
        let file = ''
        if a == 'l'
            let file = bufname('#')
            ec file
        else
            let file = get(g:filedict, a, a)
        endif
        let file = AddExtension(file, Replace(GetLang(), '\d+', ''))
        if !IsFile(file)
            let answer = get(g:filedict, file)
            if !Exists(answer)
                ec 'choose again because it is not a valid file:'
                let answer = input('choose file:')
            endif
            if Exists(answer)
                let file = answer
            endif
        endif
        let g:shuntdestination = file
    endif

    ec g:shuntdestination
    call AppendFile(g:shuntdestination, PadLines(lines))
    call DeleteBlock(indexes)
endfunction

function! GetCodeIndexesAndLines()
    let indexes = GetCodeIndexes()
    let lines = GetLines(indexes)
    return [indexes, lines]
endfunction

function! ReadLast()
    if exists('g:lastfile')
        echo ReadFile(g:lastfile)
    endif
endfunction



function! PadLines(s)
    let s = a:s
    call add(s, '')
    return s
endfunction

function! ReplaceCParse(line, s)
    
    let line = a:line
    let s = a:s

    let [s, opt] = Mreplace(s, '\[.{-}\]$')
    if Exists(opt)
        let line = eval(SingleQuote(line) . opt)
    endif
    let value = Replace(s, '\$1', line)
    return value

    sdf
    sdf
    sdf

    foo
    foo
        fo

endfunction

function! DeleteSelfFile()
    call delete(expand('%')) | bdelete!
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
            let value = Templater('console.log(JSON.stringify($0, null, 2))', [match])

        elseif options == 'lr'
            let value = Templater('return console.log($0)', [match])

        elseif options == 'lg'
            let value = Templater('console.log($0)', [match])

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

function! RemoveLogs()
    let i = GetWindowIndexes()
    for index in Ranger(i)
        let line = getline(index)
        if Test(line, '// gen')
            call setline(index, '')
        endif
    endfor
    
endfunction

function! RegisterPythonConnector(s)
    let [name, arg] = SplitOnce(a:s)
    let items = split(arg, ' ')
    let args = ToStringArray(items)

    let s = "let g:pythonconnectordict['$1'] = {'file': '$2', 'fn': '$3', 'args': $4}"
    let s = Templater(s, ['', name, CurrentFile(), GetFunctionName(), args])
    ec s
    call AppendAndExecute(s)
endfunction

function! InvivoIab()
    let word = GetCurrentWord()
    let cmd = "inoreab <buffer> " . ToAbrev(word) . " " . word . "<C-R>=Eatchar('\\s')<CR>"
    ec cmd
    execute cmd
endfunction

function! QCreate()
    let line = CurrentLine()
    let [a,b] = SplitOnce(line)
    if Test(a, '^is')
        let [p1, p2, suffix] = JSPY('p1', 'p2', 'suffix')
        let A = p1 . ' ' . a . '(s)' . p2
        let regex = RegexBuilder(b)
        let B = '    return test(' . regex . ', s)'
        let C = suffix
        let payload = [A, B, C]
        call TextPlacement(payload)
    endif
endfunction

function! ToModuleExports()
    let name = GetFunctionName()
    call Append('module.exports.' . name . ' = ' . name, '$')
endfunction

function! IsLetter(s)
    let s = a:s
    return !Exists(s) || Test(a:s, "^\w+$")
endfunction

function! InfrontAndBehindOfCursor()
    let line = CurrentLine()
    let cursor = GetCursor()
    let a = trim(line[cursor - 2])
    let b = trim(line[cursor])
    return [a,b]
endfunction

function! SplitLineAtCursor()
    let line = CurrentLine()
    let cursor = GetCursor()
    return [line[0:cursor - 2], line[cursor - 1:]]
endfunction

function! DictEntry2(s)
    let [a,b] = SplitOnce(a:s)
    return "'" . a . "'" . ": " . DoubleQuote(b) . ','
endfunction

function! AutoExpandFromWindow(s)
    let key = a:s
    let s = join(GetWindowLines(), "\n")
    let regex = ExpandPythonRegex2(key)
    let m = Match(s, regex)
    return m
endfunction

function! GetCodeBlock()
    return GetLines(GetCodeIndexes())
endfunction

function! GoToMark(mark)
    let mark = "'" . a:mark
    call setpos('.', getpos(mark))
endfunction

function! ReadFunctionFromFile(target)
    let target = a:target
    let g:readtarget = '/home/kdog3682/CWD/nodehelpers.js'
    let file = g:readtarget
    call Mark('Z')
    call OpenBuffer(file)
    if ExecuteFunctionSearch(target) == -1
        ec 'nope'
    else
        ec 'hi'
        "let lines = GetCodeBlock()
        "ec lines
    endif

    "execute
    "call GoToMark('Z')
endfunction

function! Deprecate()
    call GetSet2({s -> Commented('') . s . ' ' . Commented('DEPRECATED' . ' ' . DateStamp())})
endfunction

function! BlockQuote(s)
    return '`' . a:s . '`'
endfunction

function! AddFileStartOrEndDate()
    let date = DateStamp()
    let suffix = 'START'
    let comment = Commented(date . ' ' . suffix)
    call Append(comment, '$')
    return comment
endfunction

function! Tildaify()
    let s = '    let s = ' . BlockQuote(CurrentLine())
    call ToPasteBuffer(s)
endfunction

function! GoToTestFile()
    call Mark('Z')
    let store = [g:jsimports, '', '']
    let lines = GetLines(GetCodeIndexes())
    call extend(store, lines)
    call extend(store, ['', ''])
    call OpenBuffer('testfile.js')
    call setline('.', store)
    normal G<UP><UP><UP>
endfunction

function! WhereWasI()
    ec 'yeah kinda... '
endfunction

function! FindWordFromTop()
    
endfunction

function! AlignAssignments ()
    " Patterns needed to locate assignment operators...
    let ASSIGN_OP   = '[-+*/%|&]\?=\@<!=[=~]\@!'
    let ASSIGN_LINE = '^\(.\{-}\)\s*\(' . ASSIGN_OP . '\)\(.*\)$'

    " Locate block of code to be considered (same indentation, no blanks)...
    let indent_pat = '^' . matchstr(getline('.'), '^\s*') . '\S'
    let firstline  = search('^\%('. indent_pat . '\)\@!','bnW') + 1
    let lastline   = search('^\%('. indent_pat . '\)\@!', 'nW') - 1
    if lastline < 0
        let lastline = line('$')
    endif

    " Decompose lines at assignment operators...
    let lines = []
    for linetext in getline(firstline, lastline)
        let fields = matchlist(linetext, ASSIGN_LINE)
        call add(lines, fields[1:3])
    endfor

    " Determine maximal lengths of lvalue and operator...
    let op_lines = filter(copy(lines),'!empty(v:val)')
    let max_lval = max( map(copy(op_lines), 'strlen(v:val[0])') ) + 1
    let max_op   = max( map(copy(op_lines), 'strlen(v:val[1])'  ) )

    " Recompose lines with operators at the maximum length...
    let linenum = firstline
    for line in lines
        if !empty(line)
            let newline
            \    = printf("%-*s%*s%s", max_lval, line[0], max_op, line[1], line[2])
            call setline(linenum, newline)
        endif
        let linenum += 1
    endfor
endfunction

function! GetLastBinding()
    let index1 = Match(CurrentLine(), '\w+\ze \=')
    if Exists(index1)
        return index1
    endif
    let index1 = Search('\w+\ze \=', 'bn')
    let index2 = Search('\(\zs\w+', 'bn')
    let index = index1 > index2 ? index1 : index2
    let line = getline(index)
    let match = Match(line, '\(\zs\w+|\w+\ze \=')
    return match
endfunction

function! IsCurrentFile(buffer)
    let a = Basename(a:buffer)
    ec a
    let b = Basename(CurrentFile())
    ec b
    return a == b
endfunction

function! AddDateToLine()
    call GetSet2({s -> s . ' ' . Commented(DateStamp())})
endfunction

function! JspyArgConverter(s, ...)
    let b = a:0 >= 1 ? a:1 : ''
    if !Exists(a:s)
        return ''
    elseif a:s == 'x'
        if Exists(b)
            return ShellEscape(b)
        else
            return CurrentFile()
        endif
    elseif a:s == 'cf'
        return CurrentFile()
    elseif a:s == 'cfn'
        return GetFunctionName()
    elseif a:s == 'cfn'
        return GetFunctionName()

    elseif a:s == 'fg'
        return FileGetter2(b)
    else
        let value = ShellEscape(b)
        return value
    endif
endfunction


function! JsConnector()
    let [a,b] = SplitOnce(Prompt('a|b?'))
    let g:lastCommand = a . ' ' . b
    let g:lcs='jspy'
    let fn = ''
    "let ref = get(g:pythonconnectordict, a)
    let ref=''
    if Exists(ref)
    let file = get(ref, 'file')
    let fn = get(ref, 'fn')
    else
        let file = FileGetter2(a)
    if !Exists(file)
        ec 'error - invalid file: ' . file
        return 
    endif
    endif
    if Exists(b)
        let fn = b
    endif

        if !Exists(fn)
            let fn = 'main'
        endif
    call Node('/home/kdog3682/CWF/public/jsc.js', file, fn, CurrentFile())

endfunction

function! JspyConnector(...)
    let g:lcs='jspy'
    let [a,b] = a:0 >= 2 ? [a:1, a:2] : SplitOnce(a:1)
    let g:lastCommand = a . ' ' . b
    if (a == 'Node')
        return RunPythonOrNode('js')
    endif

    let ref = g:pythonconnectordict[a]

    let normal = get(ref, 'normal')
    if Exists(normal)
        return ExecuteNormal(normal)
    endif

    let file = get(ref, 'file')

    if GetExtension(file) == 'js'  
        call Node(file, CurrentFile())
        return 
    endif

    let fn = get(ref, 'fn')
    let base = has_key(ref, 'arg') ? get(ref, 'arg') : get(ref, 'args')
    let combine = has_key(ref, 'combineArgs')
    let arg = ''
    if IsArray(base)
        let c = 0
        let items = combine ? [trim(b)] : split(trim(b), ' ')
        if base[0] == 'cf' && len(items) < len(base)
            call insert(items, base[0])
        endif
        for el in base
            let _arg = len(items) > c ? items[c] : 0
            if !Exists(_arg)
                ec 'break'
                break
            endif

            let c += 1
            let arg .= JspyArgConverter(el, _arg) . ' '
        endfor
        let arg = trim(arg)
    "elseif HasExtension(b)
        "let arg = b
    else
        let arg = JspyArgConverter(base, b)
    endif
 let shh = '/home/kdog3682/CWF/DOWNLOADS/SAT Grammar Test 3.pdf'

    let lang = GetExtension(file)
    let directory = lang == 'js' ? 'CWD' : 'CWF'
    let executor = '/home/kdog3682/' . directory . '/' . lang . 'connector.' . lang
    call RunTime(executor, file, fn, arg)
endfunction

function! Zofdk()
    ec Numbered(['a'])
    let c = getchar()
    ec [c]
    return [c]
endfunction

function! Qgd()
    let word = input('')
    return SingleQuote(get(g:dirdict, word, word))
endfunction

function! Qgf()
    let f = input('')
    if Exists(f)
        if f == '#'
            return Tail(bufname('#'))
        endif

        let f = get(g:filedict, f)
    else
        let f = CurrentFile()
    endif
    if Exists(f)
        return Tail(f)
    else
        return ''
    endif
endfunction

function! Qgp()
    let word = input('')
    if !Exists(word)
        let file = SingleQuote(CurrentFile())
        return file
    endif
        
        if word == '#'
            return SingleQuote(bufname('#'))
        endif
    if Test(word, '/')
        let [a,b] = SplitOnce(word, '/')
        ec [a,b]

        let dir=get(g:dirdict, a)
        if !Exists(dir)
                    "let f = Choose3(Listdir())
                    "return f
            return 'err'
            else
                    let f = Find(ListDir(dir), {s->Test(Tail(s), '^'.b)})
                    return SingleQuote(f)
        endif
    endif
    return SingleQuote(get(g:filedict, word, word))
endfunction

function! GetCursorWord()
    let line = CurrentLine()
    let start = GetCursor()
    let a = start - 2
    let word = ''
    let c = 0
    while 1
        let ch = line[a]
        if c + a > start
            break
        elseif Test(ch, '[a-z0-9-]')
            let word = ch . word
        else
            break
        endif
        let a -= 1
        let c += 1
    endwhile  
    return word
endfunction

function! OutboundSnippet(snippet, word)
    let snippet = a:snippet
    let word = a:word

    if Test(snippet, '\$c')
        let [a,b] = split(snippet, '\$c')
        let snippet = a . b . Repeat("\<LEFT>", len(b))
    endif

    return Repeat("\<BS>", len(word)) . snippet 
    
endfunction


function! AutoTabForWindow()
    let fallback = ''

    let line = CurrentLine()
    let a = GetCursor() - 2
    let word = ''
    let c = 0

    while 1
        let ch = line[a]
        if Test(ch, '[a-z]')
            let word = ch . word
        else
            break
        endif
        let a -= 1
        let c += 1
    endwhile

    if len(word) > 1
        let value = AutoExpandFromWindow(word)
        if Exists(value)
            let backspaces = Repeat("\<BS>", len(word))
            return backspaces . value
        else
            return fallback
        endif
    else
        return fallback
    endif
endfunction

function! AddExpressionDict(s)
    let [a,b] = SplitOnce(a:s)
    let value = {
        \'cursorStart': 1,
        \'value': b
    \}
    call SMAddSnippet(a, value, 'exprdict')
endfunction

function! ExpressionMaster(s)
    let s = a:s

    let line = trim(CurrentLine())
    let line = CurrentLine()
    let ch = GetCursor()
    let char = line[GetCursor() - 2]
    if Exists(char) && Test(char, '\w')
        return a:s
    endif

    let ref = get(g:exprdict, 'global')

    if !Exists(ref)
        let ref = get(g:exprdict, GetLang())
    endif

    if !Exists(ref)
        return a:s
    endif

    let ref = get(ref, a:s)

    if !Exists(ref)
        return a:s
    endif

    let length = len(a:s)
    let anywhere = get(ref, 'anywhere')

    if !IsCursorStartOfLine(length) && !anywhere
        return a:s
    endif

    let expr = ref['expr']

    if Test(expr, "\n")
        let spaces = ''
        let expr = Sub(expr, "\n", "\<CR>" . spaces)
    endif

    if Test(expr, '\$c')
        let addon = CursorMovement(expr)
        let expr = Replace(expr, '\$c', '')
        return expr . addon
    endif

    return expr
endfunction

function! CursorMovement(s)
    let s = "hi(())"
    "let s = a:s
    let m = match(s, '\$c')
    let m2 = match(s[m:], "\<CR>")
    if m2 == -1
        let m2 = len(s[m:])
    endif
    "ec m
    "ec m2
    let delta = m2 - 2
    let newlines = len(FindallStrings(s[m:], "\<CR>"))
    "ec newlines
    "ec delta
    let up = "\<UP>"
    let left = "\<LEFT>"
    return Repeat(up, newlines) . Repeat(left, delta)
    
endfunction

function! CursorMovement2(s)
    let s = a:s
    let m = match(s, '\$c')
    let m2 = match(s[m:], '\<CR>')
    if m2 == -1
        let m2 = len(s[m:])
    endif

    let delta = m2 - 2
    let newlines = len(FindallStrings(s[m:], '\<CR\>'))
    let up = '<UP>'
    let left = '<LEFT>'
    return Repeat(up, newlines) . Repeat(left, delta)
    
endfunction

function! Foba()
    ec ' need to change this because it is at qy which is o be used for smth else'
    return 
endfunction

function! IsStartOfCommandLine()
    return getcmdpos() == 1
endfunction

function! CmapF()
    if !IsStartOfCommandLine()
    return 'f'
    endif
    return "let g: \= \<LEFT>\<LEFT>\<LEFT>"
endfunction

function! COrConst()
    "return IsCursorStartOfLine()
    "return 'const'
    return IsCursorStartOfLine() && GetLang() == 'js' ? 'const' : 'c'
endfunction



function! ExpandCurrentWord()
    let i = GetCurrentWordIndexes()
    let [d, b, a, c] = i

    if b == 'html2'
        let b = '/home/kdog3682/CWD/html2.js'
    else
        let b = get(g:autodict[GetLang()], b)
        if IsArray(b)
            let b = Choose2(b)
        endif
    endif

    call setline('.', a . b . c)
    call cursor(line('.'), 100)
endfunction

function! AutoDictComplete(s)
    let s = a:s
    let c = line('.')
    let _c = 0
    while _c < 20
        let _c += 1
        let c -= 1

        let line = getline(c)
        if !Exists(trim(line))
            continue
        endif
        let words = FindallStrings(line, '[a-zA-Z]\w{5,}')
        ec words
        let word = Find(words, {x -> ToAbrev(x) == s})
        ec word
        if Exists(trim(word))
            ec word
            return word
        endif

    endwhile
    return 'foo'
endfunction

function! AutoDictCompleteOld(s)
    let s = a:s
    " is going to break the previous iteration because previously used prompt to get the s value i belive with 'qq'

    let ref = g:autodict[GetLang()]
    if has_key(ref, s)
        "return 'cwd'
        let cref = get(ref, s)
        if IsString(cref)
            return cref
        endif
        return Choose3(cref)
        return Choose2(cref)
    else
        "return 'cwd'
        let cref = get(ref, s[0])
        let choices = filter(cref, 'Test(v:val, "^" . s)')
        if !Exists(choices)
            return 0
        endif
        if len(choices) == 1
            return choices[0]
        else
            return Choose3(choices)
            return Choose2(choices)
        endif
    endif
endfunction

function! PyReader(s)
    let file = FileGetter2(a:s)
    return 's = read(''' . file . ''')' . "\nprint(s)\nlines = s.strip().split('\\n')\nprint(lines)"
endfunction

function! OpenFileAndGoTo(s)
    let s = 'te fil'
    let [buffer, line] = SplitOnce(s)

    call Mark("Z")
    call ChooseBuffer2(buffer)
    let res = ExecuteFunctionSearch(line)
    if res == -1
        ec 'no match'
        execute "'Z"
        return 
    endif
    ec 'found'
    "call SetCursor(line)
endfunction

function! ZEditRegex()
    call ReplaceCurrentLine('''\zs.{-}\ze''', {s -> Dreplace(escape(s, '().'), g:regexarr)})
endfunction

function! DictCompletion()
    let a = Prompt('type')
endfunction

function! ExecuteFunctionSearch(s, ...)
    let fuzzy = a:0 >= 1 ? '\w*' : ""
    let s = a:s
    try
        let regex = "^((async )?function|var|let|def|class|const) " . s . fuzzy . ">"
        execute "/\\v" . regex
        return 1
    catch
        return 0
    endtry
endfunction

function! Mark(...)
    let mark = a:0 >= 1 ? a:1 : 'l'
    call setpos('''' . mark, getpos('.'))
endfunction

function! GetTimeAndDate()
    let strife =  '%B %d, %A, %-I:%M%p'
    ec DateStamp(strife)
endfunction

function! OpenVim()
    try
        execute "b /home/kdog3682/.vimrc"
    catch
        execute "e /home/kdog3682/.vimrc"
        normal G
    endtry
endfunction


function! PrintLineNumber()
    call AppendAbove(Logger('":::::: ' . line('.') . '"'))
endfunction

function! AddVimVar(key, value)
    let key = a:key
    let value = a:value
    call AppendAndExecute('let g:' . key . ' = ' . SingleQuote(value))
endfunction

function! AppendToVimFromOtherFile(s)
    let s = a:s
    let dict = {}
    let value = Dreplace(s, dict) . ' " @generated'
    call AppendAndExecute(value)
endfunction

function! IncrementLetter(s)
    let s = a:s
    let n = char2nr(s)
    let c = nr2char(n + 1)
    return c
endfunction

function! DictExists(key)
    "ec exists('g:pydict')
    return exists('g:' . a:key)
    let key = a:key
    return Exists(GetEvaledDict(key))
endfunction

function! AddVimSimpleDict(dict, key, value)
    let dict = a:dict
    let key = a:key
    let value = a:value
    "let dict = 'dict'
    "let key = 'key'
    "let value = 'value'
    let payload = 'let g:' . dict . '[' . Quotify(key) . '] = ' . Quotify(value)
    if !DictExists(dict)
        let s = 'let g:' . dict . ' = {}'
        call append('^', [s])
        execute s
    endif
    call AppendAndExecute(payload)
endfunction

function! ViewBookMarks()
    
endfunction

function! GrabSecondCallAndMoveAbove()
    let line = CurrentLine()
    let regex = '\w[a-zA-Z.-]+\('
    let m = FindallStrings(s, regex)
    let regex = escape(m[1], '(')
    let prefix = '(lambda.{-}: ?)?'
    let regex = prefix . regex . '.{-}\)'
    "return regex
    ec regex
    let [s, match] = Mreplace(s, regex)
    let s = Replace(s, '\ze\)$', 'payload')
    let spaces = GetSpaces(s)
    let payload = spaces . JSPY('const') . 'payload = ' . match
    call setline('.', s)
    call append(line('.') - 1, payload)

endfunction

function! BookmarkManager(...)
    let query = a:0 >= 1 ? a:1 : 0
    if Exists(query) && exists('g:markdict')
        let ref = filter(g:markdict, 'Test(v:key, "^" . query)')
        let key = 0
        let length = len(ref)
        if length == 0
            ec g:markdict
            ec 'found no results for ' . query
            ec 'want to keep looking?'
            let a = input('')
            if Exists(a)
                call Mark('Z')
                let file = '/home/kdog3682/CWF/test.py'
                call OpenBuffer(file)
                let value = ExecuteFunctionSearch(query)
            endif
            return

        elseif length == 1
            let key = keys(ref)[0]
        else
            let key = Choose(keys(ref))
        endif

        ec key
        execute "'" . ref[key]
        return
    endif

    let key = GetFunctionName()
    ec key
    "if exists('g:bookmarktracker') && g:bookmarktracker == 'Z'
        "call Prompt('u have reached the end of the available 26 bookmarks. call Stop() executing')
        "call Stop()
    "endif

    let letter = IncrementLetter(g:bookmarktracker)
    call AddVimVar('bookmarktracker', letter)
    call AddVimSimpleDict('markdict', key, g:bookmarktracker)
    call setpos("'" . g:bookmarktracker, getpos('.'))
endfunction

function! Clr()
    call DeleteLines([1, line('$')])
endfunction

function! BookmarkManager2(...)
    let query = a:0 >= 1 ? a:1 : 0
    if Exists(query)
        let ref = filter(g:bookmarkdict2, 'ToAbrev(v:key) == query')
        "let ref = filter(g:bookmarkdict2, 'Test(v:key, "^" . query)')
        let key = 0
        let length = len(ref)

        if length == 1
            let key = keys(ref)[0]
        else
            let key = Choose(keys(ref))
        endif

        if !Exists(key)
            ec 'no key @ finder of bookmarks early return'
            return 
        endif

        call Mark('Z')
        let file = ref[key]
        call OpenBuffer(file)
        let value = ExecuteFunctionSearch(key)
        return 
    endif

    let key = GetBindingName()
    let shortname = ToAbrev(key)
    ec key . ' has been marked as ' . shortname
    call AddVimSimpleDict('bookmarkdict2', key, CurrentFile())
endfunction

function! GTFGTF(s)
    let key = a:s
    let overwrite = 0
    if Test(key, '!$')
        let overwrite = 1
        let key = key[:-2]
    endif
    if overwrite == 0 && has_key(g:gtfgtfdict, key)
        let [file, name, pos] = g:gtfgtfdict[key]
        call OpenBuffer(file)
        call setpos('.', pos)
    else
        let name = GetBindingName()
        let pos = getpos('.')
        let file = CurrentFile()
        let g:gtfgtfdict[key] = [file, name, pos]
        let s = "let g:gtfgtfdict['" . key . "'] = ['" . file . "', '" . name . "', " . js_encode(pos) . "]"
        call AppendVim(s)
    endif
endfunction

function! AddPySingleton(s)
    let value = GetFunctionName()
    let key = a:s
    if !Exists(key)
        let key = ToShortName(value)
    endif
    call AddVimSimpleDict('vimsnippets', key, value)
endfunction

function! DictToArray()

    "let dict = {
        "\'askdjfkasdf': '.*?',
        "\'dotu': '.*?',
    "\}

    let i = GetPairedFromTopIndexes()
    let lines = GetLines(i)
    let length = len(lines)
    let payload = []
    let c = -1
    let value = ''
    for line in lines
        let c += 1
        if c == 0
            let line = Replace(line, '\{', '[')
            let line = Replace(line, 'dict', 'arr')
        elseif c == length - 1
            let line = Replace(line, '\}', ']')
        else
            let line = Replace(line, '\', '\\[')
            let line = Replace(line, ": ", ", ")
            let line = Replace(line, ",$", "],")
        endif
        call add(payload, line)
    endfor

    ec payload
    call setline(i[0], payload)
endfunction

function! RegexBuilder(s)
    let s = a:s
    let s = escape(s, '().')
    let value = Dreplace(s, g:regexarr) 
    if IsJs()
        return "/" . value . "/"
    else
        return SingleQuote(value)
    endif
endfunction

function! GetPyImports()
   let lines = filter(GetLines(), 'Test(v:val, "^from|^import")')
   return lines
   
endfunction

function! Rescape3(s)
    let s = Sub(a:s, '\=|\(|\)', {x -> '\' . x[0]} )
    return s
endfunction

function! SeeWhatsWrong()
    !python3 sayhi.py
endfunction

function! InvivoParenAndQuotify()
    if T('=')
        call ReplaceCurrentLine('^ *\w+ (\= )?\zs.+', {s -> DoubleQuote(s)})    
    else
        call ReplaceCurrentLine('^ *\w+ (\= )?\zs.+', {s -> DoubleQuote(s)})    
    endif
    return 
endfunction

function! InvivoQuotify()
    call ReplaceCurrentLine('^ *\w+ (\= )?\zs.+', {s -> DoubleQuote(s)})
endfunction

function! FixDotPath(s)
    return Replace(a:s, '^\.', '')
endfunction


function! ToFunctionLine()
    call Search('^((async )?function|def|class|const)', 'b')
endfunction

function! GetBinding(s)
    return Match(a:s, '\w+\ze \=')
endfunction

function! GetTheLineAndPrintTheLine()
    let line = CurrentLine()
    let var = GetBinding(line)
    let l2 = Logger(var)
    call append('$', Dedent([line, l2]))
    call Cursor('$')
endfunction

function! SplitLineAtSpaceDelimitedCursor(...)
    let s = a:0 >= 1 ? a:1 : CurrentLine()
    let c = GetCursor()
    while c > -1
        let char = s[c]
        if char == ' '
            break
        else
            let c -= 1
        endif
    endwhile

    return [s[0:c], s[c + 1:]]
endfunction

function! TabAutoCompletion()
    if IsStartOfLine()
        return setline('.', getline('.') . '    ')
    endif

    let s = CurrentLine()
    let [a,b] = SplitLineAtSpaceDelimitedCursor(s)
    let first = GetFirstWord(b)

    let ref = get(g:solsnippets, GetLang())
    let replacement = get(ref, first)

    if Exists(replacement)
        let replacement = get(g:snippetFunctionalInsertion, first)
    endif

    if !Exists(replacement)
        return setline('.', s . '    ')
    endif

    let replaced = Replace(b, first, replacement)
    call setline('.', a . replaced)
endfunction

function! RegisterTabAutoCompletion()
    
endfunction

function! DecrementFile()
    let file = DecrementFileName(CurrentFile())
    if IsFile(file)
        call OpenBuffer(file)
    endif
endfunction

function! OpenPythonControllerFile(s)
    
endfunction

function! IncrementFile()
    ec 'INCCCCCCCCCCCCCC FILE STOP'
    throw 'sdf'
    return 
    let file = IncrementFileName(CurrentFile())
    if IsFile(file)
        call OpenBuffer(file)
    endif
endfunction

function! LogicFind(s)
    call ExecuteRegex('if .' . a:s)
endfunction

function! GetFragmentAndExecute()
    let value = "'HI'"
    let s = 't2(' . value . ')'
    call Append(s, '$')
    sleep 1
    call RunPythonOrNode()
endfunction

function! WriteHistory(key, s)
   return 
   call writefile([a:key . ' ' . a:s], '/home/kdog3682/CWF/vimhistory.log', 'a')
endfunction

function! AddPythonConnectorFileCommand(s)
    let [a,b] = SplitOnce(a:s)
    call AddDictItem('ldr', a, '@PythonConnector ' . b)
    
endfunction

function! AddPythonConnectorFunctionCommand(s)
    "let [a,b] = SplitOnce(a:s)
    "call AddDictItem(a, '@PythonConnector ' . b)
    "let g:ldrdict["dlg"] = "@PythonConnector download_github_gist.py download_github_gist"
endfunction

function! FastLineEdit()
    let key = 'ifn'
    let [spaces, line] = GetSpacesAndLine()
    let first = Match(line,o '\S+')
    let dict = {
        \'ifn' :'if (!$1) $0',
        \'ds' :'if (!$1) $0',
    \}

    let template = dict[key]
    let value = spaces . Templater(template, [line, first])
    return setline('.', value)
endfunction

function! TransportTo(d)
    let d = a:d
    if d == 'cwf'
        let dir = '/home/kdog3682/CWF/'
        let path = PathJoin(dir, Tail())
        ec 'transporting the file to ' . path
        call RenameFile(path)
    endif

    if d == 'cwd'
        let dir = '/home/kdog3682/CWD/'
        let path = PathJoin(dir, Tail())
        ec 'transporting the file to ' . path
        call RenameFile(path)
    endif
endfunction

function! HasString(s)
    let text = GetText()
    return Test(text, Rescape2(a:s))
endfunction

function! ShellEscape(s)
    let s = a:s
    "let s = '\'
    let s = Sub(s, ' ', 'zzs')
    let s = Sub(s, '\(', 'zzlp')
    let s = Sub(s, '#', 'zzhash')
    let s = Sub(s, ':', 'zzcolon')
    let s = Sub(s, '!', 'zzexc')
    let s = Sub(s, '\)', 'zzrp')
    let s = Sub(s, '\.', 'zzdot')
    let s = Sub(s, '''', 'zzsq')
    let s = Sub(s, '"', 'zzdq')
    let s = Sub(s, '\$', 'zzdollar')
    let s = Sub(s, '\', 'zzbackslash')
    return s
endfunction

function! ConnectFileToLeaderAndPythonController()
    let file = Tail()
    let leaderkey = Prompt('filename', file, 'choose a ldrdict key to associate with this file')
    let fn = HasString('main(') ? 'main' : leaderkey 
    let value = '@PythonConnector ' . file . ' ' . fn
    call AddDictItem('ldr', leaderkey, value)
endfunction

function! Prompt(...)
    let message = a:0 >= 1 ? a:1 : '::awaiting input::'
    let fallback = a:0 >= 2 ? a:2 : ''
    ec message
    ec '-------------------'
    let answer = input('')
    if Exists(answer)
        return answer
    endif
    return fallback
endfunction

function! V2Lines(i)
    let lines = GetLines(a:i)
    let s = ToStringArray(lines)
    call ToPasteBuffer(s)
endfunction

function! CreateFileFromScratchpad()
   let fnName = GetFunctionName()
   let name = ToFileName(fnName)

   let leaderkey = Prompt(name, 'choose a ldrdict key to associate with this file')
   if !Exists(leaderkey)
       let leaderkey = 'cr8' . tolower(Match(name, '[a-zA-Z]+'))
   endif

   let lines = GetLines()

   if IsFile(name)
       call Prompt(name, 'do you wish to override the file?')
   endif

   let s = 'let g:ldrdict["' . leaderkey . '"] = "@PythonConnector ' . name . ' ' . fnName . '"'
   call AppendVim(s)

   let scratchpadLines = ['import env', 'from test import *', 'import vimservice as vimser', 'import stringhtml', 'import json', 'from filesystem import *', 'from libra import *', 'from intel import request', 'from pprint import pprint as printer', '', '', '', '']
   "let scratchpadLines = ['from test import *', 'import stringhtml', 'import json', 'from filesystem import *', 'from libra import *', '', '', '', '']

   call WriteFile('scratchpad.py', scratchpadLines)
   call WriteFile(name, lines)
   call OpenBuffer(name)

endfunction

function! EditApp()
    execute 
endfunction

function! CreateApp()
   let [name, indexes] = GetNameAndIndexes()
   let outpath = 'apps.py'
   let imports = GetPyImports()
   let lines = GetLines(indexes)
   let lines = Merge(imports, '', '', lines, '','')
   let leaderkey = Prompt(name, 'choose a ldrdict key to associate with this file')

   if !Exists(leaderkey)
       let leaderkey = tolower(name[0])
   endif

   let s = 'let g:ldrdict["' . leaderkey . '"] = "@PythonConnector ' . outpath . ' ' . name . '"'

   call AppendFile(outpath, lines)
   call DeleteBlock(indexes)
   call AppendAndExecute(s)
   call Progress(outpath, name)
endfunction

function! Progress(...)
    let s = Join(DateStamp(), a:000)
    call AppendFile('progress.txt', s)
endfunction

function! ToFileName(s)
    return AddExtension(NormalizeFileName(a:s))
endfunction

function! MoveFunction(s)
    let destination = g:movefunctiondefaultdestination
    if Exists(a:s)
        let destination = get(g:filedict, a:s)
    endif
    if !Exists(destination)
        let destination = g:movefunctiondefaultdestination
    endif

    let lines = GetBlockDeleteBlock()
    call AppendFile(destination, lines)
endfunction

function! ReadTempest()
    return ReadJson('tempest.json')
endfunction

function! GetNameAndIndexes()
    let indexes = GetCodeIndexes()
    let name = GetCodeName(getline(indexes[0]))
    return [name, indexes]
endfunction

function! FinishFunction(s)
    let [name, indexes] = GetNameAndIndexes()
    let s = Replace(a:s, '\w+', {x -> get(g:filedict, x[0], ToFileName(name))})
    let s = DateStamp() . ' ' . s
    
    return s
endfunction

function! ToTempBuffer()
    call ShuntBlock('tempbuffer', 'delete')
endfunction

function! EvalJson(s)
    return eval('g:' . a:s)
endfunction

function! GetName(s)
    let s = Replace(trim(a:s), '^ *(let|const|def|function|const) *', '')
    return GetFirstWord(a:s)
endfunction

function! FfrefFinder(key)
    for [a,b] in items(g:navigationdict)
        let match = FindItem(b, '^' . a:key)
        if Exists(match)
            call GoToBuffer(a)

            let regex = "^((async )?function|def|class) " . match . '>'
            call ExecuteRegex(regex)
        endif
    endfor
endfunction

function! CommentOutConsole(...)
    let i = GetFullIndexes()
    let r = '^' . JSPY('callableRE')
    ec r
    for index in Ranger(i)
        let line = getline(index)
        if Test(line, r)
            call setline(index, Replace(line, '\ze\S', JSPY('comment')))
        endif
    endfor
endfunction

function! ToSnakeCase(s)
    let delimiter = IsJs() ? '-' : '_'
    return tolower(Sub(a:s, '\C[a-z][A-Z]', {s -> s[0][0] . delimiter . s[0][1]}))
endfunction

function! StartOfDay()

    ec 'hi'
    "for file in g:dayswork
        "call OpenBuffer(file)
    "endfor
endfunction

function! SaveAll()
    for file in GetCurrentBuffers()
        let dest = NormalizePath(DirGetter('0104'), file) . DateStamp()
        ec dest
        call CopyFile(file, dest)
    endfor

endfunction

function! NormalizePath(dir, file)
    return PathJoin(DirGetter(a:dir), FixDotPath(Basename(a:file)))
endfunction

function! DaysWork()
    wa
    "let s = '['. join(map(GetCurrentBuffers(), "'\\''' . (v:val) . '\\'''"), ',') . ']'
    let vims = '['. join(map(GetCurrentBuffers(), "SingleQuote(v:val)"), ',') . ']'
    call AppendVim('let g:dayswork = ' . vims)
    return 

    try
        call Python('pythonconnector.py', CurrentFile() . ' ' . 'endofday' . ' ' . s)
        q!
    catch
        ec 'error'
    endtry

endfunction

function! Abc()
    wa
    sleep 1
    q!
endfunction

function! AutoWrite()
    call setline('.', 'hi')
endfunction

function! ToCmdSpaces(s)
    let s = a:s
    return Sub(s, ' ', '<space>')
endfunction

function! UnsetIabDict(key)
    if Not(a:key)
        return 
    endif

    let dict = g:iabref[a:key]
    let prefix = 1 ? 'iunmap ' : 'una '

    for [a,b] in items(dict)
        try
            ec 'remove ' . a
            exec prefix . a
        catch
            ec 'error ' . a
        endtry
    endfor
endfunction

function! ModeMaster(...)
    let key =  a:0 >= 1 ? a:1 : 'off'
    if key == 'off' || key == ''
        call UnsetIabDict(g:iabkey)
    else
        call SetIabDict(key)
    endif
endfunction

function! FindBufferFromGlob(key)
    let key = a:key
    let buffers = ListDir()
    for name in buffers
        let Name = Basename(name)

        if len(key) == 2
            let r = ExpandDashRegex(key)
            if Test(Name, '^' . r)
                return name
            endif
        endif

        if Test(Name, '^' . key)
            return name
        endif
    endfor

    for name in buffers
        if ToAbrev(Name) == key
            return name
        endif
    endfor
endfunction

function! FindBufferFromVisibleBuffers(key)
    let key = a:key
    let buffers = GetCurrentBuffers()
    for name in buffers
        let Name = Basename(name)

        if len(key) == 2
            let r = ExpandDashRegex(key)
            if Test(Name, '^' . r)
                return name
            endif
        endif

        if Test(Name, '^' . key)
            return name
        endif
    endfor

    for name in buffers
        if ToAbrev(Name) == key
            return name
        endif
    endfor
endfunction

function! DecrementDateNumber(x)
    return a:x[0] - 1
endfunction

function! Yesterday()
    return Replace(DateStamp(), '-\d\zs\d', function('DecrementDateNumber'))
endfunction

function! SeeFiles(dir)
    let files = globpath(a:dir, '*', 0, 1)
    return files
endfunction

function! TodoListForToday()
    let gdrive = '/mnt/chromeos/GoogleDrive/MyDrive/CWF/'
    let dir = gdrive . Yesterday()
    let files = SeeFiles(dir)
    let files = map(files, "Basename(v:val)")
    let files = filter(files, "IsFile(v:val)")
    call OpenBuffers(files)
    return files
endfunction

function! LineEdit(s)
    call PythonConnector2('lineedit', a:s)
endfunction

function! ViewLogs(key)
    let key = a:key
    let ref = {
        \'fn': 'vimhistory.log',
    \}
    let s = get(ref, key)
    ec ReadFile(s)
endfunction

function! Zoasd(s)
    ec a:s
    execute "echo 'hi'"
endfunction

function! Npm(s)
    try
        execute "!npm install --global " . a:s
        call AppendFile('/home/kdog3682/pip.logs.txt', 'npm ' . a:s)
    catch
        ec 'error'
    endtry
endfunction

function! Pip(s)
    try
        execute "!pip3 install " . a:s
        call AppendFile('/home/kdog3682/pip.logs.txt', 'pip ' . a:s)
    catch
        ec 'error'
    endtry
endfunction

function! GoMethod()
    call SetMark('a')
    let method = Match(CurrentLine(), '\w\.\zs\w+\ze\(')
    let res = ExecuteRegex('^    ' . method)
    if res > -1
        call SetMark('b')
    endif
endfunction

function! ChangeLineFileName(s)
    call ReplaceCurrentLine('["]\zs.{-}\ze["]|['']\zs.{-}\ze['']', FileGetter2(a:s))
endfunction

function! IsPdf(x)
    let lang = GetExtension(a:x)
    return lang == 'pdf'
endfunction

function! IsJsPy()
    let lang = GetLang()
    return lang == 'js' || lang == 'py'
endfunction

function! FindLongFileString()
    let s = CurrentLine()
    let file = Test(s, '''|"') ? Match(s, '[''"]\zs.*(js|py|css|html|pdf|vue|txt|json|math|logs|history|vim)\ze[''"]') : Match(s, '\S{-}\.(vim|js|py|css|html|pdf|vue|txt|json|math|logs|history)')
    return file

endfunction

function! NormalizePath2(f, ...)
    let dir = a:0 >= 1 ? a:1 : getcwd()
    let f = a:f
    if !Test(f, '/')
        return PathJoin(dir, Tail(f))
    endif
    return f
endfunction

function! GoFile()
    let word = FindLongFileString()
    if IsFile(g:homedir . word) 
        if IsJson(word)
            return OpenBuffer(g:homedir . word)
        endif
    endif

    let word = NormalizePath2(word)
    if IsPdf(word) || IsJson(word)
        return JspyConnector('open', word)
    endif

    if Exists(word) && IsFile(word)
        return OpenBuffer(word)
    endif
    ec word
    ec 'done'
    return 

    let prevfile = CurrentFile()
    let word = GetCurrentWord()
    "ec word
    "return
    let index = SearchFromLocation(1, '^ *' . word, 60, 'index')
    if index > -1
        let file = SearchFromLocation(index, 'require\(''\zs\S{-}\ze''', 40, 'match')
        if Exists(file) && IsFile(file)
            let file = Replace(file, '^\./', '')
            call SetMark('A')
            call OpenBuffer(file)
            let res = ExecuteFunctionSearch(word)
            if res == -1
                ec 'couldnt find the function: ' . word
                execute "buffer " . prevfile
            else
                call SetMark('B')
            endif
        else
            ec 'got the index but couldnt get the file'
        endif
    else
        call SetMark('a')
        let res = ExecuteFunctionSearch(word)
        if res > -1
            call SetMark('b')
        endif
    endif
endfunction

function! Get(dict, ...)
    let args = a:000
    try
        if len(args) == 2
            return a:dict[args[0]][args[1]]
        endif
    catch
        return 0
    endtry
endfunction

function! Opposite(s)
    if a:s == 0
        return 1
    
    elseif a:s == 1
        return 0
    endif
endfunction

function! Snip4Len(s)
    ret 
endfunction

function! SnippetFromLibrary()
    let regex = GetFirstWord(CurrentWord())
    let lib = GetLibrary()
    let values = filter(values(lib), "Test(v:val, regex)")

    if Exists(values)
        call AppendArray(values)
    endif
    return 

    let keys = filter(keys(lib), "Test(v:val, regex . '\\c')")
    call InputStop(keys)

    if Exists(keys)
        call AppendArray(GetLibItems2(keys, lib))
    endif
endfunction

function! ToCommand(dict, ...)
    let dict = a:dict
    let binding = a:0 >= 1 ? a:1 : ''
    let a = a:0 >= 2 ? a:2 : ''
    let b = a:0 >= 3 ? a:3 : ''

    let ref = {
        \'i': 'imap',
        \'imap': 'imap',
        \'nmap': 'nmap',
        \'n': 'nmap',
        \'in': 'inoremap',
        \'nn': 'nnoremap',
    \}
    
    if !Exists(a)
        let line = GetFunctionLine()
        let name = GetFunctionName(line)
    endif

    if !Exists(b)
        let suffix = len(GetParameters(line)) > 0 ? '("")<LEFT><LEFT>' : '()<CR>'
    endif

    if !Exists(binding)
        let binding = ToAbrev(a)
    endif

    if dict == 'imap' || dict == 'i' || dict == 'nn'
        let value = ref[dict] . ' ' . binding . ' <esc> :call ' . a . suffix
        return value
    elseif dict == 'nmap' || dict == 'n' || dict == 'in'
        let value = ref[dict] . ' :call ' . a . '(' . b . ')<CR>A'
        return value
    elseif dict == 'vmap'
        let value = dict . ' :call ' . a . '(' . b . ')<CR>A'
        return value
    endif
endfunction

function! ToGDict(dict, a, b)
    let dict = a:dict
    let a = a:a
    let b = a:b

    let doublequoted = ['py']
    let defaults = ['py', 'iab', 'ldr', 'normal', 'file']

    if Includes(dict, doublequoted)
        let b = DoubleQuote(b)
        let dict .= 'dict'

    elseif Includes(dict, defaults)
        let b = DoubleQuote(b)
        let dict .= 'dict'

    elseif dict == 'wp'
        let dict = 'globalwpdict'
        let b = DoubleQuote(b)

    elseif dict == 'p'
        let dict = 'pythonsnippets'
    elseif dict == 'scs'
        let dict = 'snippetCompletionStartDict'
    elseif dict == 'r'
        let dict = 'replacecdict'
        let b = "{'fn': '" . b . "', 'i': 'GetPairedFromTopIndexes'}"
    endif

    let existing = GetEvaledDict(dict, a)
    let b = Test(b, '^[a-zA-Z]') ? '"' . b . '"' : b
    let s = 'let g:' . dict . '["' . a . '"] = ' . b
    return s
endfunction

function! GetParameters(s)
    let s = Match(a:s, '\(.{-}\)')
    return FindallStrings(s, '\w+')
endfunction

function! SnippetFromAbrev(s, spaces)
    let s = a:s
    let spaces = a:spaces
    let [a,b] = SplitOnceReverse(s)
    let rep = FindLastBinding(trim(b))
    if Exists(a)
        let a .= ' '
    endif

    return setline('.',  spaces . a . rep)
endfunction

function! GetEvaledDict(dict, ...)
    let key = a:0 >= 1 ? a:1 : 0
    try 
        let ref = eval('g:' . a:dict)
        if !Exists(ref)
            ec ' nodict'
            return 0
        endif
        if Exists(key)
            return has_key(ref, key)
        else
            return ref
        endif
    catch
        ec 'error at getevaldict'
        ec v:exception
        return 0
    endtry
endfunction

function! GetSolSnippet(s)
    let ref = get(g:solsnippets, GetLang())
    ec ref
    try
        let snippet = get(ref, GetFirstWord(a:s))
        ec snippet
        return snippet
    endtry
endfunction

function! SolSnippetCompletion()
    return GetSet2('GetSolSnippet')
endfunction

function! GetCurrentBuffersAsString()
    let lang = GetLang()
    let buffers = filter(GetBuffers(), "GetExtension(v:val) == lang")
    let buffers = GetBuffers()
    let items = map(buffers, "Basename(v:val)")
    return ToStringArray('files', items)
endfunction

function! AppendFt(s)
    let s = a:s
    let [key, value] = SplitOnce(s)
    let suffix = ''

    if Test(value, '\\n')
        let spaces = ''
        let value = Sub(value, '\\n', '\<CR>' . spaces)
    endif

    "if Test(value, '\)$')
        "let value += '<LEFT>'
    "endif

    if Test(value, '\$c')
        let addon = CursorMovement2(value)
        let value = Replace(value, '\$c', '')
        let value .= addon
    endif

    let suffix = '<C-R>=Eatchar(''\s'')<CR>'
    let lang = GetLang()
    let file = FileGetter2('ft' . lang[0])
    let payload = 'inoreab <buffer> ' . key . ' ' . value . suffix
    ec payload

    call AppendFile(file, payload)
    call SourceFile(file)
endfunction


function! ExportVim(...)
    let key = a:0 >= 1 ? a:1 : 'pydict'
    let ref = items(eval('g:' . key))
    let out = map(ref, "v:val[0] . ' ' . string(v:val[1])")
    call WriteFile('vim.txt', out)
endfunction

function! ToJson(input)
    let json = ''
    if type(a:input) == type({})
        let parts = copy(a:input)
        call map(parts, '"\"" . escape(v:key, "\"") . "\":" . ToJson(v:val)')
        let json .= "{" . join(values(parts), ",") . "}"
    elseif type(a:input) == type([])
        let parts = map(copy(a:input), 'ToJson(v:val)')
        let json .= "[" . join(parts, ",") . "]"
    else
        let json .= '"'.escape(a:input, '"').'"'
    endif
    return json
endfunction

function! ZAction()
    let [spaces, tag, line, parts] = GetSpacesTagLineAndParts(GetFunctionLine())
    let word = parts[0]
    let lang = GetLang2()

    if Test(tag, '^function')
        let params = GetParameters(line)
        if lang == 'vim'
            let payload = map(params, "'    let ' . v:val . ' = a:' . v:val")
            call append('.', payload)
            return 
        else
            let payload = map(params, 'Logger(v:val)')
            call Append(payload)
        endif

        if Test(word, '^v')
            let word = Match(word, '[a-zA-Z]+')
            let regex = 'vuetify\('
            let payload = 'vuetify(' . word . ')'
            call InsertFile('render.html', regex, payload)
        endif
    endif
endfunction

function! PySnippetConnector(line, originalTag)
    let args = split(a:line, ' ')
    let arg = args[0]
    let dict = {
        \'pcf': {
            \'call': "def __call__(self, $2):\n    ",
            \'iter': "def __iter__(self, $2):\n    ",
            \'add':  "def __add__(self, $2):\n    ",
            \'default':  "def $1(self, $2):\n    ",
            \'indentedfn':  "def $1($2):\n    ",
        \}
    \}

    let ref = get(dict, a:originalTag)
    let key = has_key(ref, arg) ? arg : 'default'
    return ref[key]
endfunction

function! FindWithinWindow(r)

    let topindex = line('w0')
    let increment = -1
    let i = line('.')
    let c = 0
    let end = 0

    while c < 100
        let c += 1
        let line = getline(i)

        if i == topindex
            let end = 1
        endif

        if Test(line, a:r)
            return Match(line, a:r)
        else
            let i += increment
        endif

        if end == 1
            return 'null: no match at FindWithinWindow'
        endif
    endwhile
    return 'null: no match at FindWithinWindow'
endfunction

function! FindWithinBlock(r, limitRE)

    let increment = -1
    let i = line('.')
    let c = 0
    let end = 0

    while c < 100
        let c += 1
        let line = getline(i)

        if Test(line, a:limitRE)
            let end = 1
        endif

        if Test(line, a:r)
            return Match(line, a:r)
        else
            let i += increment
        endif

        if end == 1
            return 'null'
        endif
    endwhile
    return 'null'
endfunction

function! CheckWithInputStop(...)
    let items = GetContiguousBindings()
    let lines = map(items, "Logger(SingleQuote(v:val) . ', ' . v:val)")
    call add(lines, 'input()')
    return join(lines, "\n")
endfunction

function! GetContiguousBindings()

    let increment = -1
    let i = line('.')
    let c = 0
    let end = 0
    let regex = '\w+\ze \='
    let store = []

    while c < 10 
        let c += 1
        let line = getline(i)
        let i += increment

        if Test(line, regex)
            ec line
            call add(store, Match(line, regex))
        elseif len(store) == 0
            continue
        else
            ec store
            return store
        endif
    endwhile
endfunction

function! InsertVue(s)
    let [a,b] = SplitOnce(a:s)
    call InsertFile2(file, regex, payload, jump)
endfunction

function! GoToFileThenGoToLine(file, i)
    let file = a:file
    let i = a:i
    call OpenBuffer(FileGetter2(file))
    call Cursor(i)
endfunction

function! InsertFile2(file, regex, payload, jump)
    let jump = a:jump
    let file = a:file
    let regex = a:regex
    let payload = a:payload

    call OpenBuffer(FileGetter2(file))
    call ExecuteFunctionSearch(jump)
    call ExecuteRegex(regex)
    Append(payload)

endfunction

function! InsertFile(file, regex, payload)
    "appendbufline({expr}, {lnum}, {text})

    let file = a:file
    let regex = a:regex
    let payload = a:payload

    let otherText = readfile(file)
    let lineNumber = FindLineIndex(otherText, regex)
    let otherLine = otherText[lineNumber]
    let spaces = GetSpaces(otherLine)
    let payload = Indent(payload, spaces)
    call appendbufline(file, lineNumber + 1, payload)
endfunction

function! DefineSnippetCompletionStart(s)
    call AddDictItem('scs ' . a:s . ' ' . trim(CurrentLine()))
endfunction

function! SnippetCompletion(...)
    let s = a:0 >= 1 ? a:1 : CurrentLine()
    let [spaces, line] = GetSpacesAndLine(s)
    let first = GetFirstWord(line)

    let ref = get(g:solsnippets, GetLang())
    let snippet = get(ref, first)
    if Exists(snippet)
        return setline('.', spaces . snippet)
    endif

    if Exists(get(g:snippetFunctionalInsertion, first))
        return setline('.', spaces . function(g:snippetFunctionalInsertion[first])())
    endif

    return SnippetFromAbrev(s, spaces)

endfunction

function! LineToDict(s)
    return Dictify(a:s)
endfunction

function! QLineToDict()
    call GetSet(line('.'), 'Dictify')
    return 
endfunction

function! ForHandler(...)
    let value = a:0 >= 1  && len(a:1) > 2 ? a:1 : SprawlMatch('\w+s\ze \=')
    let arg = GetForIterationVariable(value)
    let template = "for $0 in $1:\n    $c"
    return Templater(template, [arg, value])
endfunction

function! TestPrintFunction()
    let payload = GetFunctionName() . '()'
    ec payload
    call Append(payload, '$')
endfunction

function! ExecutePythonRegex(s)
    let prefix = 'def ' 
    let regex = ExpandPythonRegex(a:s)
    call ExecuteRegex(prefix . regex)
endfunction

function! SetShuntDestination()
    let g:lastshuntdestination = CurrentFile()
endfunction

function! ExpandPythonRegex(s)
    let s = a:s
    let s = 'tql'
    let items = split(trim(s), '\zs')
    let s = ''
    let c = 0
    let delimiter = '[a-zA-Z]+'
    for item in items
        let c += 1
        if c == 1
            let s .= Parens(item . '|' . Capitalize(item))
        else
            let s .= Parens(Capitalize(item) . '|' . '_')
        endif
        let s .= delimiter
    endfor
    return s
endfunction

function! RDouble(s)
    let s = a:s
    "let s = 'asdf'
    return '[' . s . Capitalize(s) . ']'
endfunction

function! ExpandPythonRegex2(s, ...)
    let start = a:0 >= 1 ? a:1 : '<'
    let s = a:s
    "let s = 'bat'
    let items = split(trim(s), '\zs')
    let s = start
    let c = 0
    let delimiterEnd = '[a-zA-Z]+'
    let delimiter = '[a-zA-Z]{-}'
    for item in items
        let c += 1
        if c == 1
            let s .= Parens(item . '|' . Capitalize(item))
        else
            let s .= Parens(Capitalize(item) . '|' . '[-._]\$?' . RDouble(item))
        endif
        let s .= delimiter
    endfor
    let s = s[0:-4] . '+'
    return s
endfunction

function! ExpandDashRegex(s)
    let items = split(trim(a:s), '\zs')
    let s = ''
    let c = 0
    let delimiter = '[a-zA-Z]+'
    for item in items
        let c += 1
        if c == 1
            let s .= Parens(item . '|' . Capitalize(item))
        else
            let s .= '[_-]' .  Parens(item . '|' . Capitalize(item))
            "let s .= Parens('-' . '|' . '_')
        endif
        let s .= delimiter
    endfor
    return s
endfunction

function! ExpandRegex(s)
    let items = split(trim(a:s), '\zs')
    let s = ''
    let c = 0
    let delimiter = '[a-zA-Z]+'
    for item in items
        let c += 1
        let s .= Capitalize(item)
        let s .= delimiter
        "if c < len(items)
            "let s .= delimiter
        "endif
    endfor
    return s
endfunction

function! GoToFileAndThenGoToFunction(key)
    let key = a:key
    let ref = {
        \'qc': ['render.js', '^    handleinput'],
        \'vim': ['vimrc', '^    let ref'],
        \'te': ['test.py', '^class Storage'],
    \}

    let [file, regex] = ref[key]
    call GoToBuffer(file)
    call ExecuteRegex(regex)

endfunction

function! NormalHandler(key)
    let key = a:key
    let Fn = function(key)
    let value = Fn()
endfunction

function! AddNormalCommand(key)
    let key = a:key
    let line = GetFunctionLine()
    let name = GetFunctionName(line)
    let suffix = len(GetParameters(line)) > 0 ? '("")<LEFT><LEFT>' : '()<CR>'
    let s = 'nmap ' . key . ' :call ' . name . suffix
    ec s
    execute s
    call append('$', s)
endfunction

function! AskGoogle(...)
    let s = a:0 >= 1 ? a:1 : ''
    let url = 'https://google.com/search?=' . s
    let url = Sub(url, ' ', '+')
    ec url
    execute "!xdg-open " . url
endfunction

function! SaveCurrentItemTo(s)
    let lines = GetBlockDeleteBlock()
    call AppendFile(FileGetter2(a:s), lines)
endfunction

function! SnipTextNew(s)
    let lines = GetWindowLines()
    let regex = ExpandRegex(a:s)
    let target = SearchLines(lines, 'class \zs' . regex)
    let name = tolower(Match(target, '\C[A-Z][a-z]+$'))
    return 'const ' . name . ' = new ' . target . '()'
endfunction

function! Logging()
    let payload = "if (typeof window == 'undefined') require('./logging.js')"
    call append(0, payload)
endfunction

function! V2Snippet(i, arg)
    let snippet = join(GetLines(a:i), '\n')
    call SMAddSnippet(a:arg, snippet, 'mastersnippets')
endfunction

function! MreplaceHelper(x)
    let g:mreplacematch = a:x[0]
    return g:replacement
endfunction

function! Mreplace(s, regex, ...)
    let g:mreplacematch = 0
    let g:replacement = a:0 >= 1 ? a:1 : ''

    let replaced = Replace(a:s, a:regex, function('MreplaceHelper'))
    return [replaced, g:mreplacematch]
endfunction

function! ToPayload()
    let [line, match] = Mreplace(CurrentLine(), '\(\zs.{-}\ze\) *$', 'payload')
    call setline('.', line)
    let payload = 'let payload = ' . match
    call AppendAbove(payload)
endfunction

function! RemoveFileComments()
    let lines = filter(GetBlockDeleteBlock(GetFullIndexes()), "v:val == '' || Test(v:val, '^ *[^#]')")
    call setline('.', lines)
endfunction

function! MorningLog(s)
    call AppendFile('morning.log', DateStamp() . ' ' . a:s)
endfunction

function! ReplaceWordUnderCursor2(s)
    let s = a:s
    let leftB = Test(s, ',') ? '<' : ''
    let rightB = Test(s, '\.') ? '>' : ''
    let s = Sub(s, '[,.]', '')
    let w = CurrentWord()
    let r = ':%s/\v' . leftB . w . rightB . '/' . s
    ec r
    execute "normal! " . r . "/g\<cr>"
endfunction

function! ShuntAwayFrom()
    let regex = '^\/\/shuntpoint'
    let destination = input('choose destination:  ')
    let index = Search(regex, 'Wbn')
    if index > 0
        call AppendFile(destination, DeleteBlock([index + 1, line('$')]))
    endif
endfunction

function! LineToString(s)
    return 's = ' . SingleQuote(trim(a:s))
endfunction

function! LeaderTo()
    call WriteNotes(GetText())
endfunction

function! GetPairedFromTopIndexes()
    let upindex = line('.')
    if upindex < 10
        return GetContiguousIndexesIBM
        return GetContiguousIndexes()
    endif
    let spaces = GetSpaces()
    let downindex = Search('^' . spaces . '\S')
    return [upindex, downindex]
endfunction

function! ToSingleLine(indexes)
    let s = JSPY('const') . 's = ''' . join(GetLines(a:indexes), '\n') . ''''
    call DeleteBlock(a:indexes)
    call Append([s, ''])
endfunction

function! InvivoCreateAlias(s)
    let name = GetCodeName()
    let abrev = a:0 >= 1 ? a:1 : ToAbrev(name)
    call AddEatItem()
endfunction

function! AppendWithSpaces(s)
    call Append(CurrentSpaces() . a:s)
endfunction

function! JspyTemplater(ref, s)
    return Templater(a:ref[GetExtension()], a:s)
endfunction

function! InvivoDictEntry(s)
    let ref = {
        \'jsx': "'$0': $0,",
        \'js': "$0,",
        \'py': "'$0': $0,",
        \'vimrc': "\\ '$0': $0,",
    \}
    let payload = JspyTemplater(ref, a:s)
    call AppendWithSpaces(payload)
endfunction

function! InsertScriptLink()
    let name = Tail()
    let payload = '<link href="' . name . '" rel="stylesheet"/>'
    let regex = 'normalize'
    ec payload
    call InsertFile('render.html', regex, payload)
endfunction

function! InternetBookmarkManager()
    
endfunction

function! DefineInternetBookmark()
    let line = CurrentLine()
    "let [a,b] = SplitOnce(line)
    call AppendFile('internetbookmarks.log', line)
    call DeleteLine()
endfunction

function! DefineReplacementPoint(s)
    let payload = Commented('replacement-point-' . a:s)
    call Append(payload, -1)
    
endfunction

function! Filename()
    return Replace(Basename(CurrentFile()), '^\.', '')
endfunction

function! DefineInsertionPoint()
    let spaces = GetSpaces() . '    '
    let key = Filename()
    let payload = Commented('insertion-point ' . key)
    call Append(spaces . payload)
endfunction

function! GitUpdate()
    let file = CurrentFile()
    call Python('githubscript.py', CurrentFile())
endfunction

function! ToNoteFile()
    call WriteNotes(GetText())
endfunction

function! ShortFileName()
    return RemoveExtension(Tail(CurrentFile()))
endfunction


function! GetLocalGithub(...)
    let regex = a:0 >= 1 ? a:1 : ''
    let file = FindItem(glob('*', 0, 1), regex . '.{-}github$')
    call OpenBuffer(file)
    return 
    let cmd = "ls " . '.' . " -t" . "" . " | head " . " -" . "1" 
    let raw = systemlist(cmd)
    ec raw
endfunction

function! Interweave(s, delimiter)
    let items = split(trim(a:s), '\zs')
    let s = ''
    let c = 0
    for item in items
        let c += 1
        let s .= item
        if c < len(items)
            let s .= a:delimiter
        endif
    endfor
    return s

endfunction

function! WindowSnippetLineSplit(s)
    let regex = '[a-z]\zs | \= '
    let regex = ',\@<! \ze[a-zA-Z]'
    let items = split(trim(a:s), regex)
    let p = join(map(items, 'tolower(v:val[0])'), '')
    return p
endfunction

function! ZWindowSnippet(s)
    let lines = GetWindowLines()
    let target = FindItemFn(lines, {s -> function('WindowSnippetLineSplit')(s) == a:s})
    if Exists(target)
        call AppendFile('window-snippets.txt', a:s . ' ' . target)
        return trim(target)
    endif
    return a:s
endfunction

function! BetterTabCompletion(s)
    
    let lines = GetWindowLines()
    let target = FindItemFn(lines, {s -> function('WindowSnippetLineSplit')(s) == a:s})
    if Exists(target)
        call AppendFile('window-snippets.txt', a:s . ' ' . target)
        return trim(target)
    endif
    return a:s
endfunction

function! WhileHandler(s)
    if a:s == '1' 
        return "while (true) {\n    $c\n}"
    endif
    if a:s == 'c'
        return "const store = []\nlet count = 0\nwhile (count < 50) {\n    $c\n    if (++count > 50) {\n        throw new Error(""count surpassed"")\n    }\nconsole.log(store)\nreturn store"
    endif
endfunction

function! InputStop(x)
    ec a:x
    ec ''
    ec 'type anything to call Stop()'
    if Exists(input(''))
        call Stop()
    endif
endfunction

function! CombineFiles(s)
    let [a,b] = SplitOnce(a:s)
    let files = map(split(b, ' '), 'get(g:filedict, v:val, v:val)')
    ec files
    let e = GetExtension(files[0])
    let outpath = HasExtension(a) ? a : a . '.' . e
    if IsFile(outpath)
        ec outpath
        call InputStop('the outpath already exists. do you wish to overwrite the file?  ')
    endif
    let lines = []
    for file in files
        call extend(lines, readfile(file))
    endfor
    call WriteFile(outpath, lines)
endfunction

function! GetLastParam(...)

    let value = SprawlMatch('<\w{6,}\ze( \=|\()')
    return value
    let regex = a:0 >= 1 ? a:1 : ''
    if Exists(regex)
        let value = SprawlMatch('<' . regex . '\w\w\w\w+\ze( \=|\()')
        let value = SprawlMatch('<\w{5,}\ze( \=|\()')
        return value
    endif
    let value = SprawlMatch('\(\zs[\.a-zA-Z]{3,}\ze\)')
    return Exists(value) ? value : 'foobarglp'
endfunction


function! VNext()
    call search('}')
endfunction

function! ZNameMark(s)
    let name = GetName(a:s)
    return Marked(name)
endfunction

function! IsNestedArray(x)
    return IsArray(a:x) && IsArray(a:x[0])
endfunction

function! IfParseHandler()
    let [spaces, line] = GetSpacesAndLine()

    let snippet = IfParser(line)

    let cursorpos = GetCursorFromStringSnippet(snippet)
    let snippet = Replace(snippet, '\$c', '')
    call TextPlacement(SplitLines(snippet), spaces)
    call SetCursor(cursorpos, spaces)
endfunction

function! VisualGetAndDelete()
    let i = GetSmartContiguousIndexes()
    call GetBlockDeleteBlock(i)
endfunction


function! JspyTemplaterRunner(x)
    let s = a:x[0][1:]
    let ref = g:jspy2022[s]
    let index = GetLang() == 'js' ? 0 : 1
    return ref[index]
    
endfunction

function! JspyTemplater2022(s)
    return Sub(a:s, '\$' . Parens(join(keys(g:jspy2022), '|')), function('JspyTemplaterRunner'))
endfunction

function! LineGetter(s)
    return IsNumber(a:s) ? getline(a:s) : a:s
endfunction

function! CreateRealFunction(s)
    let [name, val = SplitOnce(a:s)

endfunction

function! DedentBlock(i)
    let in = 0
    for i in Ranger(a:i)
        if i == a:i[0] + 1
            let in = GetIndent(i)
            let in = in - 4
            ec in
        endif

        call setline(i, Replace(getline(i), '^' . ToSpaces(in), ''))
    endfor
endfunction

function! ZoopArgHelper(s)
    let d = Depluralize(a:s)
    if d == a:s
        let d = 'item'
    endif
    return d
endfunction

function! AppendBash(s)
    let [key, file] = SplitOnce(a:s)
    if Not(file)
        let file = CurrentFile()
    endif

    let value = 'vim ' . file
    let payload = 'alias ' . key . '="' . value . '"'
    call writefile([payload], '/home/kdog3682/.bash_aliases', 'a')
endfunction

function! Appender(s)
    let [parent, key, value] = SplitTwice(a:s)
    let keys = keys(g:appendlib)
    let parent = FindItem(keys, '^' . parent)
    let destinations = ['~/.bash_aliases', '~/.vimrc']
    let destination = FindItem(destinations, '^\~?\/?\.?' . parent)
    let templateRef = g:appendlib[parent]
    let payload = Templater(templateRef, [key, value])
    call Append(destination, payload)
endfunction

function! Fill(arr, n)
    while len(a:arr) < a:n
        call add(a:arr, '')
    endwhile
    
    return a:arr
endfunction

function! SplitTwice(s)
    let items = split(a:s)
    call Fill(items, 3)
    let rest = join(items[2:], ' ')
    return [items[0], items[1], rest]
endfunction

function! ToggleLineComment(...)
    let line = a:0 >= 1 ? a:1 : CurrentLine()
    if trim(line) == ''
        return 
    endif

    let regex = '^ *\zs("|//|<!--|#|/\*|\*/)'

    if Test(line, regex)
        call UnCommentLine('.')
    else
        call CommentLine()
    endif
endfunction

function! BuildJS()
    let name = GetCodeName()
    let key = 'buildjs'
    if Exists(name)
        call Node(g:jsanywherefile, CurrentFile(), key . ' ' . name)
    endif
endfunction

function! ReplaceMatcher(s)
    let items = filter(a:s[:], 'v:val != ""')
    if len(items) == 0
        call ThrowError('len items is 0')
    elseif len(items) == 1
        let g:store = items
    else
        let g:store = items[1:]
    endif
endfunction

function! FindallMatches(lines, regex)
    let lines = a:lines
    let regex = a:regex
    let g:store = []
    for line in lines
        let s = substitute(line, Regexed(regex), function('ReplaceMatcher'), '')
    endfor
    return g:store
endfunction

function! CreateObject(i)
    let lines = GetLines(a:i)
    let regex = '(\w+) \= (.+)'
    let store = FindallMatches(lines, regex)
    let dict = Dictify(store)
    let dict = Indent(dict)
    return ToPasteBuffer(dict)
endfunction

function! BetterConsole(s)
    let s = a:s
    let items = Exists(s) ? split(s, ' ') : GetLastBindings()
    let s = '''[line: ' . line('.') . ']'', '
    for item in items
        let s .= SingleQuote(item) . ' ,'': '', ' . item . ', '
        "let s .= SingleQuote(item) . ': ' . item . ', '
    endfor
    let s = s[:-3]
    return ConsoleLog(s)
endfunction

function! SetIndex(n)
    call SetPos(a:n)
endfunction

function! Zoop234(s)
    return Test(a:s, '^//') ? Replace(a:s, '^//', '') : '//' . a:s
endfunction

function! SpGetSet(indexes, key, fn)
    for i in Ranger(a:indexes)
        let line = getline(i)
        if Test(line, a:key . '>')
            ec line
            let [spaces, line] = GetSpacesAndLine(i)
            call setline(i, spaces . function(a:fn)(line))
            return 
        endif
    endfor
endfunction

function! ToggleNerdamer()
    call SpGetSet([0, 10], 'nerdamer', 'Zoop234')
endfunction

function! Zoe()
    "aasdasdasdasdasdasdsdasd"
    normal! kyi"jp
endfunction

function! ReplaceQuote(s, ...)
    let upquote = GetQuotable(UpLine())
    call GetSetLine({s -> Replace(s, g:quoteRE, upquote)})
endfunction

function! Gold()
    browse oldfiles
endfunction

function! IsArrowKey(s)
    let arrows = ['ArrowRight', 'ArrowLeft', 'ArrowUp', 'ArrowDown', 'Enter', 'Escape', 'Tab', 'Backspace']
    return Includes(a:s, arrows)
endfunction

function! EditLine(s)
    let s = Match(a:s, '\w+')
    let key = s[2:]
    if !IsArrowKey(key)
        let key = tolower(key)
    endif
    return key . ': ' . s . ','
endfunction

function! RunBlockTest(i)
    let lines = GetLines(a:i)
    call add(lines, 'throw')

    execute "normal! G\?^  *\\S\<CR>o"
    "call append('.', lines)
endfunction

function! CurrentChar()
    return CurrentLine()[col('.') - 1]
endfunction

function! SpecialEnter()
    let ch = CurrentChar()
    if Test(ch, '\d')
        normal! i[<ESC>$
    endif

    "12[[\<right>3
    "[<ESC>$123
    "12[$3
    "12[<ESC>$3
    "12abc3

endfunction

function! ArgFunc(ref, args)
    let ref = a:ref
    let args = a:args
    let Fn = FunctionGetter(ref)

    if len(args) == 1
        return Fn(args[0])

    elseif len(args) == 2
        return Fn(args[0], args[1])

    elseif len(args) == 3
        return Fn(args[0], args[1], args[2])
    endif

endfunction

function! WrapFunction(i, ...)
    let name = a:0 >= 1 ? a:1 : 'createf'
    let lines = GetBlockDeleteBlock(a:i)
    let lines = Indent(lines)
    call insert(lines, 'function ' . name . '() {')
    call add(lines, '}')
    call append('.', lines)
endfunction

function! GetFullIndexes()
    return [line('^'), line('$')]
endfunction

function! SmartSave()
    let lines = getline(0, '$')
    call add(lines, '---------------------------------')
    call AppendFile('jsanywhere', lines)
    normal ggVGd
endfunction

function! RegexExpand(s)
    let letters = split(a:s, '\zs')
    let s = ''
    for letter in letters
        let s .= toupper(letter) . '\w{1,}'
    endfor

    return s
    return s[:-2]
endfunction

function! ZFinish()
    ll
    
endfunction

function! NextBlock2()
    let regex = '} *$'
    let index = SearchDown(regex)
    let spaces = GetSpaces(index)
    "let payload = spaces . 'else if '
    let payload = spaces . 'else'
    call Append(payload, index)
endfunction

function! PathJoin(dir, file)
    let dir = Replace(a:dir, '\/$', '')
    let file = Replace(a:file, '^\/', '')
    return dir . '/' . file
endfunction

function! ZO()
   let word = GetCurrentWord()
   let key = input('   ')
   let value = Join('inoremap', key, word)
   call AppendVim(value)
   execute value
endfunction

function! AddOrRemoveComment(s)
    let s = a:s
    let com = JSPY('comment')
    let comre = Rescape(com)
    if Test(s, '^ *' . comre)
        return Replace(s, comre, '')
    else
        return Replace(s, '\ze\S', com)
    endif

endfunction

function! CopyToFile(i, ...)
    let destination = a:0 >= 1 ? get(g:filedict, a:1, a:1) : g:lastshuntdestination
    let lines = GetLines(a:i)
    call AppendFile(destination, lines)
endfunction

function! ShuntToFile(i, ...)
    let destination = a:0 >= 1 ? get(g:filedict, a:1, a:1) : g:lastshuntdestination
    let lines = GetBlockDeleteBlock(a:i)
    call AppendFile(destination, lines)
endfunction

function! Sandisk(s)
    return g:dir . a:s
endfunction

function! SearchH(s, increment, ...)
    let wordRE = '[a-z0-9\._]+'
    let s = a:s
    let regex = a:0 >= 1 ? a:1 : wordRE
    "let s = CurrentLine()
    let increment = a:increment
    "let increment = 1

    let g:d = 0

    let start = GetCursor() - 1
    let d = 0
    while Test(s[start], '\W')
        let d += 1
        if d == 20
            call ThrowError()
        endif
        let start -= 1
    endwhile

    let ch = 0
    let c = 0
    while c < 30
        let c += 1
        let ch = s[start]
        if Test(ch, regex)
            let start += increment
            continue
        else
            let g:d = d

            "ec [start - increment, s[start-increment]]
            return start - increment
        endif
    endwhile
endfunction

function! GetCurrentWord(...)
    let repl = expand("<cword>")
    return repl
    let s = CurrentLine()
    if Test(s, repl . '\(|\= *' . repl)
        return repl
    endif
    let s = Replace(s, 'console.log\(|print\(', '') "_fxrc
    let r = IterFind(s, '\w+\ze\(', '\w+\.\w+')
    call sort(r)
    return r[0]
endfunction

function! GetCurrentWordOld()
    "const items = components.map((x) => leToComponent2(le.run(x)))
    if Exists(r) && len(r) == 1
        return r[0]
    endif

    let s = Sub(s, '\w+ \=|(var|const|let) \w+|new |console.log\(|print\(', '') "_fxrc

    if !Exists(trim(s))
        ec 'nope'
        return 0
    endif
    ec s
    return 

    let wordRE = '[a-z0-9\._]+'
    let mode = a:0 >= 1 ? a:1 : wordRE

    let left = SearchH(s, -1, mode)
    let right = SearchH(s, 1, mode)
    return GetFirstWord(s[left:right])
    return trim(s[left:right])
    "fgh.ghfgh
endfunction

function! RegisterInvivoSnippet()
    let word = GetCurrentWord()

    "call AddDictItem('iab ' . payload)
   "let left = "<LEFT>"
   "let ending = Search(
   "let cmd = Join("iab", payload . ending . "<C-R>=Eatchar('\\s')<CR>")

    let s = Join('iab', ToAbrev(word), word)
    call AppendVim(s)
    exec s
endfunction

function! SplitLineAtCW()
    let g:d = 0
    let d = g:d
    let s = CurrentLine()
    let left = SearchH(s, -1)
    let right = SearchH(s, 1)
    return [left, right]
endfunction

function! GetCurrentWordIndexes()
    let g:d = 0
    let d = g:d
    let s = CurrentLine()
    let left = SearchH(s, -1)
    let right = SearchH(s, 1)
    let p = [s, s[left - d:right - d], s[0:left - 1 - d], s[d + 1 + right:]]
    return p
endfunction

function! ReplaceCurrentWordRunner(value)
    let value = a:value
    let [a,b] = GetBeforeAndAfter()
    return a . value . b
endfunction

function! ReplaceCurrentWord()
    call setline('.', ReplaceCurrentWordRunner(CurrentLine()))
endfunction

function! ToggleIndent()
    if g:autoindent == 1
        let g:autoindent = 0
        unset autoindent
        unset smartindent
        unset set smarttab
    else
        let g:autoindent = 1
        set autoindent
        set smartindent
        set smarttab
    endif
endfunction

function! UnsetTemporaryIab(...)
    let dict = a:0 >= 1 ? a:1 : g:currentiabdict
    if len(dict) == 0
        return 
    endif
    for [a,b] in items(dict)
        ec 'remove ' . a
        try
            exec "iunmap " . a
        catch 
            try
                 exec "una " . a
            catch 
                ec 'n ' . a
            endtry
        endtry
    endfor
endfunction

function! GetGlobalDict()
    let key = GetExtension() . 'iabdict'
    return eval('g:' . key)
endfunction

function! Unsti()
    let cmds = ReadJson('sdf.json')
    for cmd in cmds
        exec cmd
    endfor
endfunction

function! EvalSetter(key, value)
    let key = a:key
    let value = a:value
    let dest = 's'
    if !exists(dest . ':' . key)
        execute "let " . dest . ":" . key . " = " . json_encode(value)
    endif
endfunction

function! EvalGetter(key)
    let key = a:key
    let dest = 's'
    return eval(dest. ':' . key)
endfunction

function! Sti()
    if !exists('s:count')
        let s:count = -1
    endif

    if !exists('s:vimabrevdict')
        let s:vimabrevdict = ReadJson('vim-abrevs.js.json')
        ec 'setting vimabrevdict'
    endif

    let s:count += 1
    let index = IsEven(s:count) ? 0:1
    let cmds = s:vimabrevdict[index]
    for cmd in cmds
        try
            exec cmd
        catch
            break
        endtry
    endfor

endfunction

function! SetTemporaryIab()
    if exists('g:iabhistory')
        ec 'unsetting temp iab for autotab'
        unlet g:iabhistory
        return 
        for [a,b] in items(g:iabhistory)

            ec 'removing key: ' . a
            if (b == 'imap')
                exec 'iunmap <buffer> ' . a
            else
                exec 'iuna <buffer> ' . a
            endif
        endfor
        unlet g:iabhistory
        ec 'removing iabhistory'
        return 
    endif

    "ec 'setting iabhistory'
    ec 'setting temp iab for autotab'
    let dict = ReadJson('iab.json')
    let g:iabhistory = dict
    return 
    let g:iabhistory = {}
    for [a,b] in items(dict)
        if !Test(b, '\)$')
            let g:iabhistory[a] = 'imap'
            let cmd = "inoremap <buffer> " . a . " " . Sub(b, ' ', '<space>') . "<C-R>=Eatchar('\s')<CR>"
            exec cmd
            continue

        elseif Test(b, '\=')
            let b .= "<CR>\<C-R>\=Eatchar('\\s')\<CR>"
        elseif !Test(b, '\=') && Test(b, '\)$')
            let b .= "<left>\<C-R>\=Eatchar('\\s')\<CR>"
        endif
        
        let g:iabhistory[a] = 'iab'
        let cmd = "inoreab <buffer> " . a . " " . b
        exec cmd
    endfor
endfunction

function! SetIabDict(key)
    let key = a:key
    if key == g:iabkey
        return 
    else
        if Exists(g:iabkey)
            call UnsetIabDict(g:iabkey)
        endif
        let g:iabkey =  key
    endif

    let dict = g:iabref[key]

    if dict == g:iabmathdict
        for [a,b] in items(dict)
            let cmd = "inoremap " . a . " " . ToCmdSpaces(b)
            ec cmd
            exec cmd
        endfor
        return 
    endif

    for [a,b] in items(dict)
        if !Test(b, '\)$')
            let cmd = "iab " . a . " " . Sub(b, ' ', '<space>') . "<C-R>=Eatchar('\s')<CR>"
            ec cmd
            exec cmd

        elseif Test(b, '\=')
            let b .= "<CR>\<C-R>\=Eatchar('\\s')\<CR>"
        elseif !Test(b, '\=') && Test(b, '\)$')
            let b .= "<left>\<C-R>\=Eatchar('\\s')\<CR>"
        endif
        
        let cmd = "iab " . a . " " . b
        exec cmd
    endfor

endfunction

function! DictStringSplit(s)
    let s = a:s
    if Test(s, '  ')
        return map(split(s, '  '), "SplitOnce(v:val)")
    endif
    return split(s, ' ')
endfunction

function! FileFinder2(files, key)
    let files = map(a:files, 'Basename(v:val)')
    let index = FindIndex(files, a:key)
    if index > -1
        let file = files[index]
        return file
    endif
endfunction

function! HasExistingText(s)
    let s = a:s
    let match = Test(s, '^ ') && Test(s, '[\[\{]')
    return match
endfunction

function! OnMathPageEnter(s)
endfunction

function! OnTextEnter(s)
endfunction

function! OnJavascriptEnter(s)
endfunction

function! OnVimEnter(s, spaces, logic)

    let enter = "\<CR>"
    let indent = '    '
    let up = "\<UP>"

    return 
    if Exists(a:logic) 
        return enter . 'end' . a:logic . up
    endif

endfunction

function! OnPythonEnter(s)
    let enter = "\<CR>"
    let indent = '    '
    let s = a:s
    let a = GetFirstWord(s)
    let logic = ['if', 'elif', 'else', 'while', 'do', 'for']
    if Includes(a, logic)
        return ':' . enter
    elseif len(trim(s)) > 100
        return enter . '    '
    endif

endfunction

function! MathReplace(s)
    ec a:s
    let dict = {
        \'e': '^',
        \'[': '(',
        \']': ')',
        \'t': ' * ',
        \'p': ' + ',
        \'=': ' = ',
        \'-': ' - ',
    \}
    return Sub(a:s, ' *[tep\-\=] *', {s -> get(dict, trim(s[0]))})
endfunction

function! OnMathTextEnter(s)
    
    if !Test(a:s, '[a-z]{3,}')
        call setline('.', 'sdf')
        return ''
        return MathReplace(a:s)
    elseif 0
        return extension
    endif
endfunction

function! MathReplaceHandler(s)
    return Sub(a:s, '\d\S\S\S+', {s -> MathReplace(s[0])})
    return Sub(a:s, '[abc\d][tep-][abc\d]\S*', {s -> MathReplace(s[0])})
endfunction

function! InoremapEnter()
    if Tail() == 'math'
        call GetSet2('MathReplaceHandler')
    endif
    
endfunction

function! GetLang2()
    let extension = expand('%:e')
    if Test(extension, '\d$')
        return 'js'
    elseif Exists(extension)
        return extension
    endif

    let match =  Match(Tail(), '^\.?\zs(vim|mp|math)')
    return match
endfunction

function! OnKeyPress(key)

    let langRef = {
        \'js': 'Javascript',
        \'py': 'Python',
        \'txt': 'Text',
        \'mp': 'MathPage',
        \'mafgth': 'MathText',
        \'vim': 'Vim',
    \}

    let langRef = {
        \'vim': 'Vim',
    \}

    let name = get(langRef, GetLang2())
    ec name
    if Not(name) 
        return g:keypresskeys[a:key]
    endif
    let fnKey = 'On' . name . 'Enter'

    let logicItems = ['if', 'elif', 'else', 'while', 'do', 'for']
    let [spaces, line] = GetSpacesAndLine()
    let a = GetFirstWord(line)
    let logic = Includes(a, logicItems) ? a : 0
    let value = function(fnKey)(line, spaces, logic)

    return Exists(value) ? value : g:keypresskeys[a:key]
endfunction

function! Globpath(...)
    let regex = a:0 >= 1 ? a:1 : ''
    return glob(regex . '*', 0, 1)
endfunction

function! SpanifyRunner(s, word)
    let word = a:word
    return Replace(a:s, word, Divify('span', 'span-item-' . word, word, 0))
endfunction

function! Spanify()
    let word = CurrentWord()
    call GetSet2('SpanifyRunner', word)
endfunction

function! SlashEffect()
    let [spaces, item] = s
endfunction

function! GetBuffers()
    return map(GetVisibleBuffers(), 'bufname(v:val)')
endfunction

function! ToVar(a, b)
    let a = a:a
    let b = a:b
    return 'let g:' . a . ' = ' . b
endfunction

function! SetGVariable(s)
    "let s = a:s
    let s = 'phys_foo'
    let [a,b] = SplitOnce(s)
    let var = 'let g:' . a . ' = ' . b
    ec var
    return 
    call execute var
    call AppendVim(varline)
endfunction

function! NextFile()
   let buffers = GetBuffers()
   let newBuffer = ModularIncrement(buffers, CurrentBuffer())
   call OpenBuffer(newBuffer)
endfunction

function! ModularIncrement(items, current)
    let i = index(a:items, a:current) + 1
    if i == len(a:items)
        let i = 0
    endif
    let match = a:items[i]
    if match == '/home/kdog3682/.vimrc'
        return ModularIncrement(a:items, match)
    endif

    return match

endfunction

function! CurrentBuffer()
    return CurrentFile()
endfunction

function! Marked(...)
    let s = a:0 >= 1 ? ' ' . a:1 : ''
    if s == 0
        let s = ''
    endif
    return CommentLong('marked' . s) 
endfunction

function! Head(...)
    if a:0 >= 1
        let head = join(split(a:1, '/')[0:-2], '/')
        return '/' . head
    else
        let head = expand('%:h')
        return head
    endif
endfunction

function! ChangeFile(s)
    ec 'hi change file depreafcated'
    return 
    let head = Head()
    let file = PathJoin(head, a:s)
    let g:lastfile = file
    "if !Includes(file, values(g:filedict))
        "let letter = file[0]
        "if get(g:filedict, letter, 0) == 0
            "let letter = input('choose abrev')
            "if get(g:filedict, letter, 0) == 0
                "let letter = input('choose abrev again')
            "endif
        "endif
        "call AddFile(letter . ' ' . file)
    "endif

    call OpenBuffer(file)
endfunction

function! NoExtension(s)
    return !Test(a:s, '\.\w+$')
endfunction

function! ZBookmark()
    let file = CurrentFile()
    if NoExtension(file)
        call ThrowError('no extension')
    endif
    let alias = GetAbrev(Deleter(Deleter(file, Rescape(g:basedir)), '\.\w+$'))
    return 'dict file ' . alias . ' ' . file
endfunction

function! LeaderFunctionController(s)
    call LeaderManager(function(a:s)())
endfunction

function! Consoled(s, ...)
    let quoted = a:0 >= 1 ? a:1 : 0
    return quoted == 0 ? 'console.log' . Parens(a:s) : 'console.log(' . SingleQuote(a:s) . ')'
endfunction

function! Zditto(s)
    "let line = trim(CurrentLine() )
    let parts = split(a:s, ' ')
    let items = map(parts, "split(v:val, '/')")
    let payload = ''
    for [a,b] in items
        let payload = Replace(line, '<' . a . '\w+', b)
    endfor
    return payload
endfunction

function! ZTest(arg)
    let name = GetFunctionName()
    let arg = SingleQuote(a:arg)
    let payload = name . Parens(arg)
    return Consoled(payload)
    
endfunction

function! ZSee(s)
    let name = GetName(a:s)
    return Consoled('hi from ' . name, 1)
endfunction

function! CommentLong(s)
    return '/* ' . a:s . ' */'
endfunction

function! ZFind(s)

    if IsVim()
        let after = ''
        let before = ''
        let regex = ''

        let [query, mode] = SplitOnce(a:s)

        if Test(query, 'dict$')
            let regex = 'let g:' . query
            
        else
            let before = '^\w+map( \<silent\>)? '
            let before = '^\w{-}map '
            let regex = before . query . after
        endif
        call Cursor('$')
        call ExecuteSearch(regex, 'b')
        return 
    endif

    if Test(a:s, '^(ec|ss)')
        let [a,b] = map(split(a:s, '^\w\w\zs'), 'RegexExpand(v:val)')

        call ExecuteSearch('^class ' . a, 'null')
        call ExecuteSearch('^    ' . b, 'null')
        return 
    endif

    if Test(a:s, '^\w+\.\w+')
        let [a,b] = map(split(a:s, '\.'), 'RegexExpand(v:val)')

        call ExecuteSearch('^class ' . a, 'null')
        call ExecuteSearch('^    ' . b, 'null')
        return 
    endif

    if Test(a:s, '^z')
        let s = a:s[1:]
        call ExecuteSearch('^ *\/\* marked ' . s, 'null')
        return 
    endif

    if Test(a:s, '^\/')
        let context = GetContext2()
        ec context
        let s = a:s[1:]
        if context == 'class'
            call ExecuteSearch('^class ' . RegexExpand(s), 'null')
        else
            call ExecuteSearch(s, 'function')
            call ExecuteSearch('^ *\/\* marked', 'null')
        endif
        return 
    endif

    let context = GetContext2()
    let index = GetFunctionIndex()
    call cursor(index + 1,  100)

    if context == 'class'
        call ExecuteSearch('    ' . RegexExpand(s), 'null')
        call Search('^    ' . RegexExpand(s), 'W', 200)

    elseif context == 'const'
        let line = getline(index)
        let [tag, name] = SplitOnce(Match(line, '^\w+ \w+'))
        if Test(name, 'c[abc]*$')
            let context = 'component'
            let regex = get(g:vueregexdict, a:s[0])
            let index = Search(regex, 'W', 50)
            return 
        endif

    elseif len(a:s) > 1
        call ExecuteSearch('^ *\/\* marked ' . a:s, 'null')
        return 
    endif

    let i = SearchDown(regex, 0, 0, '^}')

endfunction

function! ZGoMarked()
    let line = CurrentLine()
    if Test(line, 'marked')
        call Replace(line, '\/\* marked \*\/', '')
    else
        call ExecuteSearch('^ *\/\* marked', 'null')
    endif
endfunction

function! PrependItem()
    call Search('const', 'b')
    let spaces = GetSpaces()
endfunction

function! EasyP2(s)
    let items = reversed(split(a:s, ' '))
    let s = ''
    for item in items
        s = parens(s)
    endfor
endfunction

function! EasyP(s)
    let [a,b] = SplitOnce(a:s)
    return 'const ' . a . ' = ' . b
endfunction

function! ToShortName(name)
    "let parts = split(a:name, '\\.|\C\ze[A-Z]')
    let parts = FindallStrings(a:name, '[A-Z]|(^|\.)\zs[a-zA-Z]\C')
    return tolower(join(parts, '' ))
    "ec parts
    "return tolower(Replace(name, '\w\zs[a-z0-9]\C', '', 'g'))
endfunction

function! GrabIndexes(indexes)
    let lines = GetLines(a:indexes)
    call ToPasteBuffer(lines)
endfunction

function! Rangify(...)
    let line = trim(CurrentLine())
    let lines = map([1,2,3,4,5,6,7,8,9], "Replace(line, '1', v:val)")
    call TextPlacement(lines)

endfunction

function! SunCaller(...)
    let s = ''
    if a:0 >= 1
        let s = a:1
        let s = GetFunctionName() . Parens(SingleSingleQuote(s))
        let g:suncaller = s
        ec s
        if Test(s, 'suncaller')
            ec 'early retunr'
            return 
        endif
    endif

    try 
        execute "ec " . g:suncaller
        if a:0 >= 1
            call append('$', "let g:suncaller = " . SingleQuote(s))
        endif
    catch
        ec 'catching suncaller error'
        ec g:suncaller
    finally
        return 
    endtry
endfunction

function! Returnify()
    call ReplaceCurrentLine('\w+ \=', 'return')
endfunction

function! Rescape2(s)
    let s = Sub(a:s, '\=|\(|\)', {x -> '\' . x[0]} )
    return Test(s, '^\v') ? s : '\v' . s
endfunction

function! GSI(i, fn)
    let Fn = FunctionGetter(a:fn)
    ec a:i
    for index in Ranger(a:i)
        call Fn(index)
    endfor
endfunction

function! RemoveComments(i)
    let indexes = a:i
    let r = '^ *' . Ncg(map(JSPY('comment', 'console'), 'Rescape2(v:val)'))
    let line = getline(a:i)
    if Test(line, r)
        "ec line
        "ec a:i
        call deletebufline('%', a:i + 0)
    endif
endfunction

function! RemoveConsoleFromLines(i)
    let r = '^ *' . Rescape2(JSPY('console'))
    for index in Ranger(a:i)
        let line = getline(index)
        if Test(line, r)
            call setline(index, Replace(Replace(line, r, ''), '\) *$', ''))
            "call setline(index, Replace(line, '\ze\S', JSPY('comment')))
        endif
    endfor
endfunction

function! RemoveCommentFromLines(i)
    let r = '^ *' . Ncg(map(JSPY('comment', 'console'), 'Rescape2(v:val)'))
    let store = []
    for index in Ranger(a:i)
        let line = getline(index)
        if Test(line, r)
            "ec line
            "ec index
            call add(store, index)
        else

        endif
    endfor

    let counter = 0
    "ec store
    for index in store
        call setline(index, '')

        let counter += 1
    endfor
endfunction

function! MoveIn(i)
    let lines = Dedent(GetLines(a:i))
    call DeleteBlock(a:i)
    call AppendBelow('^function', lines)
endfunction

function! Extension()
    return expand('%:e')
endfunction

function! AppendAboveNew(lines)
    let lines = a:lines
    let i = GetFunctionIndex()
    call add(lines, '')
    let location = i - 1
    call append(location, lines)
endfunction

function! MoveOutward(i)
    let lines = Dedent(GetLines(a:i))
    call DeleteBlock(a:i)
    call AppendAboveNew(lines)
endfunction

function! FileConnector()
    
endfunction

function! GetNoteIndexes()

    let r = '\v^(console|\w+ ?\(|function|const|\w+ \=|\/\/|async|}|\])'
    let stopline = line('.') - 75
    let top = search('\v^(console|\w+ ?\(|function|const|\w+ \=|\/\/|async|}|\])', 'bnW', stopline)
    if Exists(top)
        let top += 1
    endif
    let bottom = search(r, 'nW')
    if Not(bottom)
        let bottom = line('$')
    else
        let bottom -= 1
    endif
    return [top, bottom]
endfunction

function! MarkLineForBookmark() " marked
    if IsFunctionLine()
        call GetSet('.', {s -> s . ' ' . Commented('marked')})
    else
endfunction

function! ShuntNotes(i)
    let lines = map(GetLines(a:i), 'DateStamp() . ": " . v:val')
    call AppendFile('/home/kdog3682/CWF/notes.txt', lines)
endfunction

function! SaveForLater(s)
    call AppendFile('/home/kdog3682/CWF/notes.txt', DateStamp() . ': todocodefile' . CurrentFile() . ' ' . a:s)
endfunction

function! GetSet2(s, ...)

    let Fn = function(a:s)
    let [spaces, line] = GetSpacesAndLine()
    let value = a:0 >= 1 ? Fn(line, a:1) : Fn(line)
    call setline('.', spaces . value)
endfunction


function! GetSetLine(Fn)
    let [spaces, line] = GetSpacesAndLine()
    call setline('.', spaces . FunctionGetter(a:Fn)(line))
endfunction

function! IsFunctionLine()
    return Test(CurrentLine(), '^(function|def|class|const)')
endfunction

function! ToggleSettings()
    let lang = GetLang()
    if s:resetSettings == 1
        let s:resetSettings = 0
        ec 'do it'
    else if lang == 'js'
        set noshowmode
        set noruler
        set laststatus=0
        set showcmd " I dont like it
        return 
    endif
endfunction

function! FindAnyEntry(s)
    return 
endfunction

function! GoodNight()
    call AppendVim(Commented(DateStamp()))
endfunction

function! GoodMorning()
    call AppendVim(Commented(DateStamp()))
endfunction

function! AskQuestion2(lines, arg)
    let lines = Indent(a:lines)
    let lang = GetLang()
    let [question, body] = ForceSplit(a:arg, '  ')
    let s = '@' . lang . ' ' . question
    call insert(lines, '')
    call insert(lines, s)
    call add(lines, '')
    call add(lines, body)
    ec ToString(lines)
    call AppendFile('questions.txt', lines)

endfunction

function! ReplaceCShunt(indexes, ...)
    let destination = a:0 >= 1 ? a:1 : 0
    if Exists(destination)
        let g:shuntdestination = destination
    endif
    if Exists(g:shuntdestination)
        call AppendFile(g:shuntdestination, GetLines(a:indexes))
    else
        ec 'no shunt destination'
    endif
endfunction

function! ReduceSnippetFixer(s)
    let s = a:s[0]
    ec s
    return 'asdf'
    let Parser = {s -> Test(s[0], ',') ? '[' . s[0][1:-1] . ']' : s[0][1:-1]}
    ec key
endfunction

function! RCFnReplace(indexes, arg)
    let Condition = {s -> Test(s, regex)}
    call GS3(a:indexes, Fn, Condition)
endfunction

function! ClassSearch(s)
    call ExecuteRegex('^class', 1)
    call ExecuteRegex('^    ' . a:s)
endfunction

function! GoToLocation2()
    let context = GetContext2()
    if context == 'class'
        call ClassSearch('constructor')
    else
        let name = GetFunctionName()
        let key = Match(name, '^\C[a-z]+\ze[A-Z]')
        ec key
        if Not(key)
            ec 'no key'
            return 
        endif
        let regex = '^class ' . join(split(toupper(key), '\zs'), '.{-}')
        call ExecuteSearch(regex, 'null')
        call Down()
        call ClassSearch('constructor')

    endif

endfunction

function! Boopster(s)
    return Divify('div', '', a:s, 0)
endfunction

function! FindVimKey(key)
    let key = a:key
    let value = get(g:ldrdict, key)
    if !Exists(value)
        ec 'no value for key'
        ec key
        return 
    endif

    let value = string(value)
    ec value
    let value = Sub(value, '[''"]', '')
    ec value
    let regex = 'function ' . value
    execute "/\\v" . regex
    return 

    let [key, short] = Mreplace(key, '/$', '')
    "let fn = Match(CurrentLine(), regex2)
    "let regex2 = '^let g:' . ref . '\[[''"]' . key  . '.{-}function\([''\"]\zs\w+'

    let regex = '^let g:' . '\w+' . '\[[''"]' . key
    execute "/\\v" . regex

    if Exists(short)
        return 
    endif
    let line = CurrentLine()
    let fn = Match(line, '\C[''\"]\zs[A-Z]\w{6,}')
    ec fn
    call GoToFunction(fn)
endfunction

function! FindDictEntry(key, ...)
    let ref = a:0 >= 1 ? a:1 : '(pydict|ldrdict)'
    "let ref = eval('g:' . ref)
    "ec get(ref, a:key)
    let regex = '^let g:' . ref . '\[[''"]' . a:key 
    let regex2 = '^let g:' . ref . '\[[''"]' . a:key  . '.{-}function\([''\"]\zs\w+'
    execute "/\\v" . regex 
    let fn = Match(CurrentLine(), regex2)
    call GoToFunction(fn)

    "let g:ldrdict['fde'] = function('FindDictEntry')
endfunction

function! GetSpacingIndexes()
    let [spaces, line] = GetSpacesAndLine()
    let spaces = spaces[:-5]
    let prefix = '^' . spaces . '.{-}'
    let upregex = prefix . '[\{\[]$'
    let downregex = prefix . '\\?[\}\]]'
    let upindex = SearchUp(upregex)
    let downindex = SearchDown(downregex)
    let p = [upindex, downindex]
    return p

    ec [spaces]
    ec p
    ec [upregex]
    echom p
    return p

    let f = [
        \'adsf',
    \]
endfunction

function! GetMatchingIndexes()
    let [spaces, line] = GetSpacesAndLine()
    let target = Match(line, '\=')
    let dict = {
        \ 'adsf': ['(\w+ )?\w+', ''],
        \ '=': ['(const |let )?\w+ ', ''],
    \}
    let [before, after] = dict[target]
    let regex = '^' . spaces . before . Rescape(target) . after
    let upindex = SearchUp(regex, 1)
    let downindex = SearchDown(regex, 1)
    let p = [upindex, downindex]
    "return p

    echom p
    return p

    let f = [
        "fghfg
    \]
    z = 'adsf'
    z = 'adsf'
    z = 'adsf'
endfunction

function! Down()
    call SetPos(1)
endfunction

function! GetMatchingSpacesIndexes()
    let spaces = GetSpaces()
    let regex = '^' . spaces . '\S'
    let upindex = CurrentIndex()
    call Down()
    let downindex = SearchDown(regex)
    let p = [upindex, downindex]
    return p

    let [spaces, line] = GetSpacesAndLine()

    let target = Match(line, '[\[\{]$')
    let dict = {
        \'[': ']',
        \'{': '}',
    \}
    let after = dict[target]
    let regex = '^' . spaces . '\\?' . Rescape(after)
    let upindex = CurrentIndex()
    let downindex = SearchDown(regex)
    let p = [upindex, downindex]
    echom p
    return p
endfunction

function! ReplaceCMover(indexes)
    let block = GetBlockDeleteBlock(a:indexes)
    let block = Indent(block)
    let index = GetVarIndex()
    call append(index, block)
endfunction

function! Attrify(key, value)
    if a:key == 'vue'
        return '{{' . a:value . '}}'

    elseif a:key == 'class'
        return 'class="' . a:value . '"'

    elseif a:key == 'vue'
        return '{{' . a:value . '}}'
    endif
endfunction

function! AnyFunctionBlockIndexes()
    let up = SearchUp('^ *function')
    let spaces = GetSpaces(up)
    let pattern = '^' . spaces . '}'
    let down = SearchDown(pattern)
    let p = [up, down]
    return p
endfunction

function! GrabBlock(indexes)
    let lines = GetLines(a:indexes)
    call Dedent(lines)
    call ToPasteBuffer(lines)
endfunction

function! AboveAndBelow(indexes, fn, above, below)
    let spaces = GetSpaces(a:indexes[0])
    call GS3(a:indexes, function(a:fn))
    call append(a:indexes[0] - 1, spaces . a:above)
    call append(a:indexes[1] + 1, spaces . a:below)
endfunction

function! VueAddTransition(indexes, arg)
    let [above, below] = get(g:vueaddtransitiondict, a:arg)
    call AboveAndBelow(a:indexes, 'IndentLine', above, below)
endfunction

function! UncommentHtml(s)
    return a:s[5:-4]
endfunction

function! CommentHtml(s)
    return '<!-- ' . a:s . ' -->'
endfunction

function! BlockIntoSJString(indexes)
    let lines = GetLines(a:indexes)
    let lines[0] = 's = `' . lines[0]
    let lines[-1] = lines[-1] . '`'
    call ReplaceIndexes(a:indexes, lines)
endfunction

function! GetCodeText()
    return ToText(GetLines(GetCodeIndexes()))
endfunction

function! QuoteIntoArray(indexes, ...)
    let name = a:0 >= 1 ? a:1 : 'placeholder'
    let lines = GetLines(a:indexes)
    let payload = join(map(lines, "'    ' . SingleQuote(v:val) . ','"), "\n")
    let output = '' . name . " = [\n" . payload . "\n]"
    call ReplaceIndexes(a:indexes, output)
endfunction

function! GetSecondWord(s)
    return FindallStrings(a:s, '\w+')[1]
endfunction

function! ToAbrev(s)
    let s = a:s
    "let s = 'getFunctionNam_e'
    let parts = Split(s, '\ze[A-Z]|\.|\/|-|_')
    let abrev = tolower(join(map(parts, 'v:val[0]'), ''))
    return abrev
endfunction

function! GetAbrev(s)
    let s = a:s
    let parts = Split(s, '\ze[A-Z]|\.|\/|-')
    let abrev = tolower(join(map(parts, 'v:val[0]'), ''))
    return abrev
endfunction

function! DivWrap()
    
endfunction

function! SingleSingleQuote(s)
    return "''" . a:s . "''"
endfunction

function! SingleQuote(s)
    return "'" . a:s . "'"
endfunction

function! DoubleQuote(s)
    return '"' . a:s . '"'
endfunction

function! Split(s, ...)
    let regex = a:0 >= 1 ? a:1 : ' '
    return split(trim(a:s), Regexed(regex))
endfunction

function! SubHelper(x)
    ec x
endfunction

function! Replace2(s, regex, replacement)
    return substitute(a:s, Regexed(a:regex), {s -> function(a:replacement)(s[0])}, 'g')
endfunction

function! VdivReplaceHelper(s)
    let items = Split(a:s, '\=\=')
    if len(items) == 2
        let [a,b] = items
        return ' ' . a . '== ' . SingleQuote(b)
    else
        let a = items[0]
        return ' == ' . SingleQuote(a)
    endif
endfunction

function! SnippetDivMaker2(s)
    let items = split(a:s, ' ')
    let rest = ''
    let s = '<div'

    let vmap = {
        \'if': 'v-if',
        \'show': 'v-show',
        \'click': '@click',
        \'izzf': 'v-if',
        \'iadf': 'v-if',
        \'else': 'v-else',
        \'html': 'v-html',
        \'for': 'v-for',
    \}

    let counter = 0
    for item in items
        ec item
        let ab = Split(item, '[^\=]\zs\=\ze[^\=]')
        if len(ab) == 2
            let [a,b] = ab
            let a = get(vmap, a, ':' . a)
            let s .= ' ' . a . '=' . DoubleQuote(b)
        else
            let a = ab[0]
            if a == 'else'
                let s .= ' v-else'

            elseif a == 'html'
                let s .= ' v-html="html"'

            elseif Test(a, '^v')
                let a = a[1:]
                let s .= ' v-' . a . '=' . DoubleQuote(a)

            elseif a[0] == '.'
                let s .= ' class="' . Sub(a, '\.', '') . '"'

            elseif a[0] == '['
                let a = a[1:-2]
                let s .= ' class="' . a . '"'
                let rest = '{{' . a . '}}'
            else
                break
            endif
        endif
        let counter += 1
    endfor

    if Not(rest)
        let rest = join(items[counter:], ' ')
    endif

    if Exists(rest)
        let s .= '>' . rest . '</div>$c'
    else
        let s .= '>$c</div>'
    endif

    return s

        "let s .= ">\n    $c\n</div>"
    "if Exists(rest)
        "if (len
            "let s .= '>' . rest . '</div>$c'
        "else
            "let s .= ">\n    " . rest . "$c\n</div>$c"
        "endif
endfunction

function! Vdiv(s)
    let short = 1
    let s = a:s
    let s = 'p items'

    let regex = ' ?\=\=\w+\.?\w*'
    let s = Replace2(s, regex, 'VdivReplaceHelper')
    let items = Split(s, ' \ze(\w+\=|\w+$)')

    let vmap = {
        \'if': 'v-if',
        \'show': 'v-show',
        \'click': '@click',
        \'izzf': 'v-if',
        \'iadf': 'v-if',
        \'else': 'v-else',
        \'html': 'v-html',
    \}

    for item in items
        ec item
        let ab = Split(item, '[^\=]\zs\=\ze[^\=]')
        if len(ab) == 2
            let [a,b] = ab
            let a = get(vmap, a, ':' . a)
            let s .= ' ' . a . '=' . DoubleQuote(b)
        else
            let a = ab[0]
            if a == 'else'
                let s .= ' v-else'

            elseif a == 'html'
                let s .= ' v-html="html"'

            elseif Test(a, '^v')
                let a = a[1:]
                let s .= ' v-' . a . '=' . DoubleQuote(a)

            elseif a == 'fsdfgsdfaasdfasdfde'
                let s .= 'v-else'
            elseif a[0] == '.'
                let s .= ' class="' . Sub(a, '\.', '') . '"'
            else
                let s .= '>' . a
            endif
        endif
    endfor
    if short == 1
        let s .= '>$c</div>'
    else
        let s .= ">\n    $c\n</div>"
    endif
    "return s
    let p = s 
    echom p
    return p
    "testing
endfunction

function! Vdivactual(s, ...)
    let short = a:0 >= 1 ? a:1 : 0
    let s = a:s

    "let short = 1
    "let s = 'else vaction'

    let regex = ' ?\=\=\w+\.?\w*'
    let s = Replace2(s, regex, 'VdivReplaceHelper')
    let items = Split(s, ' \ze(\w+\=|\w+$)')
    let s = '<div'

    let vmap = {
        \'if': 'v-if',
        \'show': 'v-show',
        \'click': '@click',
        \'izzf': 'v-if',
        \'iadf': 'v-if',
        \'else': 'v-else',
    \}

    for item in items
        ec item
        let ab = Split(item, '[^\=]\zs\=\ze[^\=]')
        if len(ab) == 2
            let [a,b] = ab
            let a = get(vmap, a, ':' . a)
            let s .= ' ' . a . '=' . DoubleQuote(b)
        else
            let a = ab[0]
            if a == 'else'
                let s .= ' v-else'

            elseif Test(a, '^v')
                let a = a[1:]
                let s .= ' v-' . a . '=' . DoubleQuote(a)

            elseif a == 'fsdfgsdfaasdfasdfde'
                let s .= 'v-else'
            elseif a[0] == '.'
                let s .= ' class="' . Sub(a, '\.', '') . '"'
            "elseif Test('^v', a)
                "let s .= '>{{' . a . '}}'
            "else
                "let s .= '>' . a
            endif
        endif
    endfor
    if short == 1
        let s .= '>$c</div>'
    else
        let s .= ">\n    $c\n</div>"
    endif
    "return s
    let p = s 
    echom p
    return p
endfunction

function! CreateLibraryFile(...)
    let file = a:0 >= 1 ? a:1 : CurrentFile()
    ec 'creating library file ' . file
    call Node('index.js', file, 'clf')
endfunction

function! DynamicGKey(key, value)
    let gkey = "g:" . a:key

    if exists(gkey) == 0
        execute "let " . gkey . " = " . a:value
    endif

    return eval(gkey)
endfunction

function! RemoveExtension(s)
    return Replace(a:s, '\.\w+$', '')
endfunction

function! JSLibRef(regex)
    let regex = a:regex
    let libfile = (g:jslibref) . '.json'
    if Not(IsFile(libfile))
        ec 'creating library'
        call CreateLibraryFile(g:jslibref)
        if Not(IsFile(libfile) 
            call ThrowError('not a file', libfile)
        endif
    endif

    let lib = ReadJson(libfile)
    let keys = filter(keys(lib), "Test(v:val, regex . '\\c')")
    if Not(keys)
        ec 'no keys'
        return 
    elseif len(keys) == 1
        let values = GetLibItems2(keys, lib)
        call AppendArray(values)
    else
        let target = GetInput('What keys would you like?')
        let keys = map(SpaceSplit(target), 'keys[str2nr(v:val)]')
        let values = GetLibItems2(keys, lib)
        call AppendArray(values)
    endif
endfunction

function! SmarterAppend(val)
    let [spaces, line] = GetSpacesAndLine()
    if IsBlockEnter(line)
        let spaces .= '    '
    endif
    call append('.', [spaces . a:val])
    "asdasd() {
endfunction

function! GetAnyName()
    let m = SprawlMatch('\w+\ze\(.{-}\{')
    return m
    ec m
endfunction

function! Commented(s)
    let ref = {
        \'js': '/* $0 */',
        \'html': '<!-- $0 -->',
        \'vimrc': '" $0',
        \'py': '# $0',
        \'css': '/* $0 */',
    \}

    let template = get(ref, GetExtension())
    return Templater(template, trim(a:s))
endfunction

function! IsStartingFunctionCall(s)
    return Test(a:s, '^[a-zA-Z.]+\(')
endfunction

function! FooAction()
    let indexes = GetWindowRange()
    call GS3(indexes, function('Commented'), function('IsStartingFunctionCall'))
    call PySnippet('foo')
endfunction

function! LineSetter(Fn, ...)

    let mode = a:0 >= 1 ? a:1 : ''
    let [spaces, line] = GetSpacesAndLine()
    let Fn = FunctionGetter(a:Fn)
    let payload = Fn(line)

    if Test(payload, "\n")
        let payload = ToLines(payload)
    endif

    if Exists(payload)
        if IsArray(payload)
            call TextPlacement2(payload, spaces, [1, 4])
            return
            "co a b c
        else
            if mode == 'below'
                call append('.', spaces . payload)
            elseif mode == 'above'
                call append(Relative(-1), spaces . payload)
            elseif mode == 'bottom'
                call cursor('$', 1000)
                call Search('^}', 'b')
                call append(line('.'), payload)
            else
                call setline('.', spaces . payload)
            endif
        endif
    endif
endfunction

function! SplitIndex(s, n)
    let s = a:s
    let n = a:n
    return [s[0:n - 1], s[n:len(s)]]
endfunction

function! SearchHorizontal(r, increment, ...)
    let line = a:0 >= 1 ? a:1 : CurrentLine()
    let start = GetCursor() - 1
    let ch = 0
    let _count = 0
    while _count < 30
        let _count += 1
        let ch = line[start]
        if Test(ch, a:r)
            let start += a:increment
            continue
        else
            return start + 0
            break
        endif
    endwhile
    ec 'error'
endfunction

function! SearchLeft(r)
    return SearchHorizontal(a:r, -1)
endfunction

function! SearchRight(r)
    return SearchHorizontal(a:r, 1)
endfunction

function! Logged(...)
    return "console.log(" . join(a:000, ', ') . ")"
endfunction

function! QuotifyWordUnderCursor(line)
    let line = a:line
    let r = '[a-zA-Z]'
    let leftindex = SearchLeft(r)
    let rightindex = SearchRight(r)
    if leftindex == rightindex
        return 
    endif
    let p = line[0:leftindex] . Quotify(line[leftindex + 1:rightindex - 1]) . line[rightindex:]
    return p
endfunction

function! IsBlockEnter(s)
    return Test(a:s, '\{ *$')
endfunction

function! SetCurrentMovementTarget()
    let g:currentMovementTarget = GetFunctionName()
endfunction

function! SmartMovementAppend(s)
    let loc = line('.')
    let ref = g:movementdict
    let [key, val] = SplitOnce(a:s)
    let target = get(ref, g:currentMovementTarget, g:currentMovementTarget)
    call ExecuteSearch(target)

    let dict = {
        \ 'c': 'constructor',
        \ 'l': 'let',
    \}

    let transformerdict = {
        \ 'c': function('SAConstructor'),
    \}
    let val = has_key(transformerdict, key) ? transformerdict[key](val) : val
    call ExecuteSpaceSearch(dict[key])
    call SmarterAppend(val)
    call MoveCursor(loc)
endfunction

function! DictItemMaker(x)
    let parts = a:x
    if len(parts) == 2
        return join(map(parts, "Quotify(v:val)"), ': ') . ','
    endif
    return Quotify(parts[0]) . ': ' . '[' . join(map(parts[1:], "Quotify(v:val)"), ', ') . '],'
endfunction

function! GetSetPartsHandler(...)
    let key = a:0 >= 1 ? a:1 : 'dictitem'
    let [spaces, line] = GetSpacesAndLine()
    let parts = split(line, ' ')
    let dict = {
        \ 'dictitem': function('DictItemMaker')
    \}
    let payload = spaces . dict[key](parts)
    ec payload
    call setline('.', payload)
endfunction

function! SAConstructor(s)
    return Templater('this.$0 = $1', SplitOnce(a:s))
endfunction

function! UpdateJson(file, data)
    
    let prev = {}
    if IsFile(a:file)
        let prev = ReadJson(a:file)
        if Not(prev)
            let prev = {}
        endif
    endif

    call extend(prev, a:data)
    let payload = split(json_encode(prev), "\n")
    call writefile(payload, a:file, 'w')
    call XdgOpen(a:file)
endfunction

function! TodoInvivoWriter()
    "invivoregexwriter
    let [spaces, line] = GetSpacesAndLine()
    let tag = line[0]
    let dict = {
       \'/' : function('ZoopReFn')
    \}

    let Fn = get(dict, tag)
    if Exists(Fn)
        call Fn(line, spaces)
    else
        ec 'not in dictzoop'
    endif
endfunction

function! ZoopReFn()
    let word = MatchUp('\w+RE')
    ec word

endfunction

function! Unique(arr)
    let seen = []
    for item in a:arr
        if Includes(item, seen)
            continue
        else
            call add(seen, item)
        endif
    endfor
    return seen
endfunction

function! FindAllRegexes()
    let regex = '/.{-}/\w*'
    let matches = Unique(FindallStrings(GetCodeText(), regex))
    return matches
endfunction

function! EditAppenderRegexes()
    call EditAppender(FindAllRegexes())
endfunction

function! EditAppender(items)
    
    let store = []

    for item in a:items
      let name = input(item . ' ::  named as ?   ')

      if Exists(name)
          let payload = 'const ' . name . 'RE = ' . item
          call add(store, payload)
      endif
    endfor

    let payload = ToString(store)
    call AppendTop(payload)
endfunction

function! NextBlock()
    
    let [spaces, tag, line, parts] = GetSpacesTagLineAndParts()

    if len(parts) > 0 && has_key(g:movementsnippetdict, parts[-1])
        let ref = get(g:movementsnippetdict, parts[-1])
        call ReplaceCurrentLine(' *\w+ *$', '')
        let index = SearchDown(ref.regex)
        let spaces = GetSpaces(index)
        let payload = Indent(ref.payload, len(spaces) + ref.indentation)
        call Append(payload, index, ref.cursor)
        return
    else
        let regex = '} *$'
        let index = SearchDown(regex)
        let spaces = GetSpaces(index)
        let payload = spaces . 'else if '
        call Append(payload, index)
    endif

    return 
endfunction

function! Source(...)
    let file = a:0 >= 1 ? a:1 : '/home/kdog3682/.vimrc'
    execute "source " . file
    return 
    let s = a:0 >= 1 ? a:1 : 'functions'
    let keys = SpaceSplit(s)
    call map(a:000, "'execute source ~/CWF/' . v:val . '.vim'")
endfunction

function! Eatchar(pat)
  let c = nr2char(getchar(0))
  return (c =~ a:pat) ? '' : c
endfunction

function! SetGlobalMark()
    let buffer = bufnr(file, 1)
    let position = [buffer, lineNumber, 1, 0]
    call setpos("'" . mark, position)
endfunction

function! MoveBlockUp()
    let indexes = GetCodeIndexes()
    let lines = GetLines(indexes)
    call DeleteBlock(indexes)
    call GoTop()
    call AppendBlock(lines)
endfunction


function! Absdir(dir)
    let glob = globpath(a:dir, '*')
    return split(glob, "\n")
endfunction

function! Deplural(s)
    return Replace(a:s, 's$', '')
endfunction

function! CallFn()
    let args = ''
    call AppendBottom(GetFunctionName() . '(' . args . ')')
endfunction

function! MarkInteresting()
    call AppendTop('"interesting ' . CurrentLine())
endfunction

function! ZoopbarTestVar(s)
    let [a,b] = SplitOnce(a:s, ' ', 'reversed')
    return a . ', ' . b
endfunction

function! RegexGetter(key)
    let dict = {
        \'': '^ *$',   
    \}
    return get(dict, a:key, a:key)
endfunction

function! SearchDown(key, ...)
    let mustHaveLine = a:0 >= 1 ? a:1 : 0
    let start = a:0 >= 2 ? a:2 : 0
    let threshold = a:0 >= 3 ? a:3 : 0
    return SearchBase(a:key, start, 1, mustHaveLine, threshold)
endfunction

function! MatchDown(key)
    return GetLine(SearchDown(a:key))
endfunction

function! MatchUp(key)
    return GetLine(SearchUp(a:key))
endfunction

function! SearchUp(key, ...)
    let mustHaveLine = a:0 >= 1 ? a:1 : 0
    let start = a:0 >= 2 ? a:2 : 0
    return SearchBase(a:key, start, -1, mustHaveLine)
endfunction

function! SearchBase(key, start, increment, contiguous, ...)
    let threshold = a:0 >= 1 ? a:1 : 0
    let i = Relative(a:start)
    let regex = RegexGetter(a:key)
    let c = 0

    if a:contiguous
        while c < 400
            let c += 1
            let line = getline(i)

            if Test(line, regex)
                let i += a:increment
            else
                return i - a:increment
            endif
        endwhile
    else
        while c < 400
            let c += 1
            let line = getline(i)

            if threshold != 0
                if Test(line, threshold)
                    ec 'stoppuing at threshold'
                    return 
                endif
            endif
            if Test(line, regex)
                return i
            else
                let i += a:increment
            endif
        endwhile
    endif
    ec 'search error  @ searchbase'
endfunction

function! Append101(index, lines)
    call add(a:lines, '')
    call append(a:index - 1, a:lines)
endfunction

function! GetSpaceDelimitedIndexes(...)
    let target = a:0 >= 1 ? a:1 : 0
    
    let spaces = ''
    let upindex = 0
    let c = 0

    if Not(target)
        let startingspaces = CurrentSpaces()
        let spaces = ''
        let i = line('.') - 1
        while 1
            let c += 1
            if c > 60
                ec 'early return'
                return 
            endif
            let upline = getline(i)
            let spaces = GetSpaces(upline)
            if len(spaces) < len(startingspaces)
                break
            else
                let i -= 1
            endif
        endwhile
        let upindex = i
    else
        let upindex = search('\v<' . target . '>', 'bn')
        let spaces = GetSpaces(getline(upindex))
    endif
    
    let downindex = search('\v^' . spaces . '\S', 'n')
    return [upindex, downindex]
endfunction

function! SplitHtml(...)
    let target = a:0 >= 1 ? a:1 : 'foo'
    ec target
    let [up, down] = GetSpaceDelimitedIndexes(target)

    let current = line('.')
    let startUp = SprawlIndex('^ *$', 'bn', current - 50)
    let startDown = SprawlIndex('^ *$', 'n', current + 50)
    let start = abs(startUp - current) < abs(startDown - current) ? startUp : startDown
    let topPoint = up + 1
    let bottomPoint = down - 1
    if start == bottomPoint
        ec 'seadcas'
        let start = SearchUp('')
    elseif start == topPoint
        let start = SearchDown('')
    endif
    "ec up
    "ec bottomPoint
    "ec topPoint
    "ec start
    "return

    "foo"
        "booooo
        "fooasd

        let spaces = GetSpaces(getline(topPoint))
        call GS3([topPoint, bottomPoint], {s -> '    ' . s})
    "boop
        
        call append(up, [spaces . '<div class="' . target . '-group">'])
        call append(down, [spaces . '</div>'])
        call setline(start + 1, spaces . '</div>')
        call append(start + 1, [spaces . '<div class="' . target . '-group">'])
endfunction

function! DittoBlock(...)
    let [key, val] = a:0 >= 1 ? SplitOnce(a:1) : [0, 0]
    let [up, down] = GetSpaceDelimitedIndexes()
    let lines = GetLines([up, down])

    if Exists(key)
        let lines = Replace(lines, key, val)
    endif

    call Append101(up, lines)
endfunction

function! WriteHtml()
    let [spaces, tag, line, parts] = GetSpacesTagLineAndParts()
    let attrs = ''
    if len(parts) == 2
        let attrs = 'class="' . parts[1] . '"'
    endif
    let content = '{{' . parts[0] . '}}'
    let payload = spaces . DivMaker(tag, attrs, content)
    "ec payload
    "return
    "div foo bar
    call setline('.', payload)
endfunction

function! Tovfor(...)
    let mode = a:0 >= 1 ? a:1 : 'vfor'
    let target = a:0 >= 2 ? a:2 : 'items'
    if mode == 'vfor'
        let divAttrs = 'v-for="' . Deplural(target) . ' in ' . target . '"'
        let divValue = '{{' . Deplural(target) . '}}'
    elseif mode == 'asdf'
        let divAttrs = ''
        let divValue = ''
    else
        let divAttrs = ''
        let divValue = ''
    endif
    "let s = '<div class="display-value">{{display}}</div>'
    let s = CurrentLine()
    let [a,b] = SplitOnce(s, '>\zs')
    let [b,c] = SplitOnce(b, '\ze<')
    let lines = [a]
    let spaces = GetSpaces(a)
    "let spaces = ''
    let payload = DivMaker('div', divAttrs, divValue)
    "ec payload
    "return
    let payload = Indent(payload, spaces . '    ')
    call extend(lines, ToArray2(payload))
    call add(lines, spaces . c)
    call TextPlacement2(lines, 0)
    "sdf
    "sdf
    "sdf
endfunction

function! SnippetDivMaker(name, ...)
    let name = a:name
    ec [a:000, name]
    return 
    let mode = a:000[2]

    if mode == 'short'
        return "<div class=\"" . name . "\">{{" . name . "}}</div>"
    endif

    if Test(name, '^tran')
        return "<transition name=\"fade\" mode=\"out-in\">\n    $c\n</transition>"

    elseif Test(name, 's$')
        let Shortname = Deplural(name)
        return "<div class=\"" . name . "\">\n    <div class=\"" . name . "-header\">" . name . "</div>\n    <div class=\"" . Shortname . "-container\">\n        <div v-for=\"" . Shortname . "\ in " . name . "\">{{" . Shortname . "}}</div>\n    </div>\n</div>"

    else
        return "<div class=\"" . name . "\">\n    <div class=\"" . name . "-name\">" . name . "</div>\n    <div class=\"" . name . "-value\">{{" . name . "}}</div>\n</div>"
    endif
endfunction

function! GetJSLambda(...)
    let name = a:0 >= 1 ? a:1 : 'lambdafn'
    let up = search('\v^    \S.{-}\=\>', 'bn')
    let down = search('\v^    }\)', 'n')
    let lines = GetLines([up, down])
    let lines[0] = Replace(lines[0], ' *\=\> *', ' ')
    let lines[0] = Replace(lines[0], '^.{-}\ze\(', 'function ' . name)
    let lines[0] = Replace(lines[0], '\w+, \ze\(', '')
    let lines[len(lines) - 1] = lines[len(lines) - 1][0: -2]
    call Dedent(lines)
    "ec lines
    call ToPasteBuffer(lines)
    
endfunction

function! GetLookBehind(s)
    let s = a:s
    let p = Match(s, '.{-}\ze\\zs')
    return p
endfunction

function! MatchAll(s, re)
    let regexes = split(a:re, '\v\)\zs\ze\(')
    let store = []
    let s = a:s
    for regex in regexes
        let item = Match(s, regex)
        if Exists(item)
            call add(store, item)
            let s = s[len(item): len(s)]
        else
            call add(store, '')
        endif
    endfor
    return store
endfunction

function! ZoopbarArrMethods(s)
    let s = a:s
    let [method, short, key] = MatchAll(s, '(map|red|filt|fe|f)(s)(\w+)')
    if key == 'c'
        return 'map(mapConditional($c))'
    endif
    let method_dict = {'red': 'reduce', 'filt': 'filter', 'fe': 'forEach', 'f': 'filter'}
    let ending_dict = {'reduce': ', {})', 'map': ')', 'filter': ')', 'forEach': ')'}
    let method = get(method_dict, method, method)
    let ending = get(ending_dict, method)

    let key_dict = {'kv': '([k,v])', 'ab': '([a,b])'}

    let key = get(key_dict, key, '(item, i)')
    if Not(key)
        let key = Parens(join(split(key, '\zs'), ','))
    endif

    if method == 'reduce'
        let key = '(acc, ' . key[1:]
    endif

    let short = short == '' ? "=> {\n    $c\n}" . ending : "=> $c" . ending
    return method . '(' . key . ' ' . short

endfunction

function! ToSingleLineBlock()
    let line = DeleteLine()
    call DeleteLine()
    call ReplaceLine(line('.') - 1, {s -> s[0] . ' ' . line . ' }')
endfunction

function! SplitLineOnCursor(...)
    let line = a:0 >= 1 ? a:1 : CurrentLine()
    let ch = GetChar()
    let a = line[0:ch - 1]
    let b = line[ch - 0: len(line)]
    return [a,b]
endfunction

function! GetShuntawayIndexes()
    let stopline = line('.') - 75
    let top = search('\v^(  |console|\w+ ?\(|function|const|\w+ \=|\/\/|async|}|\])', 'bn', stopline)
    call CoerceError(top)
    let indexes = [top + 1, line('$')]
    return indexes
endfunction

function! GetBlockDeleteBlock(...)
    let indexes = a:0 >= 1 ? a:1 : GetCodeIndexes()
    let lines = GetLines(indexes)
    call DeleteBlock(indexes)
    return lines
endfunction

function! MatchCamelCase(regex, line)
    let regex = a:regex
    let line = a:line
    ec line
    let words = GetWords2(line)
    for word in words
        let abbrev = (Test(word[0], '\C[0-9A-Z]') ? '' : word[0]) . Sub(word, '\C[a-z]', '')
        let abbrev = tolower(abbrev)
        if regex == abbrev
            return word
        endif
    endfor
endfunction

function! GetUpLines(n)
    let store = []
    for i in range(a:n)
        call add(store, getline(line('.') - 1 - i))
    endfor
    return store
endfunction

function! ParseJson(key, value)
    let key = a:key
    let value = a:value
    let value = IsFile(value) ? ReadJson(value) : json_encode(value)
    if !exists('g:' . key)
        execute 'let g:' . key . ' = ' . json_encode(a)
    endif
    return value
endfunction

function! SnippetInsertionViaFileReplacer(s)
    let s = a:s[0]
    let [a,b] = [s[0] . s[1], s[2:]]
    let ref = {
        \'gs': 'GLOBALS',
    \}

    let file = AddExtension(ref[a])
    let file = 'GLOBALS.py'

    if !Exists(get(g:qqdict, file))
        try 
            call PythonConnector('imapqq', file)
            let g:qqdict[file] = ReadTempest()
        endtry
    endif

    return get(g:qqdict[file], b, 'oops: the key u used doesnt exist!')
endfunction

function! SnippetInsertionViaFile()
    call ReplaceLine(line('.'), GetCurrentWord(), function('SnippetInsertionViaFileReplacer'))
endfunction

function! SnippetInsertionViaLookAbove()
    let words = GetWords2()
    let line = CurrentLine()
    let regex = words[-1]
    let upline = UpLine()
    let match = MatchCamelCase(regex, join(GetUpLines(3), ' '))
    if Exists(match)
        call ReplaceLine(line('.'), regex, match)
    endif
endfunction

function! ActionManager(s)
    ec 'Calling Action Manager'
    if strlen(a:s) > 10
        "let items = matchlist(a:s, '\v(\w+) (.*)')
        "let [a,b] = [items[1], items[2]]
        "i
        "ec a
        "ec b
        let lang = GetLang()
        let statement = lang . ' ' . a:s
        let statement = ReplaceSpaces(statement)
        ec statement
        call Execute('reddit.py', statement)
        return
    endif
    let key = a:s
    if key =~ 'pret'
        execute "normal! :!prettier --write " . Self() . "\<cr>"
    elseif key == 'foo'
        execute "normal! :ec " . "'" . Self() . "'" . "\<cr>"
    endif
endfunction

function! AddBackSlashes(s)
    return Replace(a:s, '[\+\$\=\[\]\(\)\*\{\}]', '\\\0', 'g')
    return Replace(a:s, '[\[\]\(\)\*\{\}]', '\\\0', 'g')
    return Replace(a:s, '[\=\[\]\(\)\*\:\{\}]', '\\\0', 'g')
    "return b"
endfunction

function! AddCompletion (left, right, completion, restore)
    call insert(s:completions, [a:left, a:right, a:completion, a:restore])
endfunction

function! AddDictItem(...)
    let args = a:0 == 3 ? a:000 : SplitTwice(a:1)
    let [dict, a, b] = args

    call AppendAndExecute(ToGDict(dict, a, b))
endfunction

function! IsVim()
    return CurrentFile() == '/home/kdog3682/.vimrc'
endfunction

function! AddErrorDebugForTheThing(indexes) 
    let lines = ['try {',
    \'catch(e) {',
     \   'console.log(e)',
      \  'console.log(s)',
       \ 'throw "error"',
       \ '}'
    ]
    let [a,b] = a:indexes
    let spaces = CurrentSpaces()
    call IndentAll([a,b])
    call append(a - 1, spaces . lines[0])
    call append(b + 1, IndentAll(lines[1:], spaces))
    call cursor(b + 3, 100)
endfunction

function! AddFileToFileDict(s)   
    let [a,b] = SplitOnce(a:s)
    let index = search('\v^ *"\\ *''file-dict-start''', '')
    let p = DictEntry(a, Quotify(b))
    call SmartAppend(index, p)
endfunction

function! AddImportStatement()
    let line = CurrentLine()
    let importmatch = Match(line, g:importre)
    if Exists(importmatch)
        ec importmatch
        let line = g:importdict[importmatch]
        call append('^', line)
    else
        ec 'no import match'
    endif
    return

    let dict = {
    \    'l': 'import lorem',
    \    'p': 'import praw',
    \    'i': 'import inspect',
    \    'dt': 'import datetime',
    \    'wb': 'import webbrowser',
    \    'a': 'from storage import *\nfrom shortcuts import *',
    \    '': 'from storage import *\nfrom shortcuts import *',
    \ }
    let lines = split(get(dict, a:s, ''), '\\n')
    call append('^', lines)
endfunction

function! AddImports(s)
    let index = search('\v^from storage import', 'bn')
    call GetSetLine(index, {text -> text . ', ' . s})
endfunction

function! EarlyExit(s)
    if a:s == 1
        call ThrowError()
    endif 
endfunction

function! AddPydictSingleton()
    call EarlyExit(CurrentFile() != '/home/kdog3682/.vimrc')
    let dictname = 'pydict'

    let fnName = GetFunctionName()
    let a = tolower(Replace(fnName, '[a-z0-9]\C', '', 'g'))
    let b = "function('" . fnName . "')"
    let s = 'let g:' . dictname . '[' . Quotify(a) . '] = ' . b
    call append('$', s)
    call SaveFile()

endfunction

function! Assert(s)
    if !Exists(a:s)
        ec 'doesnt exist'
        ec [a:s]
        call Stop()
    else
        return a:s
    endif
endfunction

function! AddLeaderSingleton(...)
    call Assert(IsVim())
    let [a,b] = a:0 >= 1 ? SplitOnce(a:1) : ['', '']  
    let dictname = a:0 >= 2 ? a:2 : 'ldrdict'

    let name = GetFunctionName()
    if Exists(name)
        let b = name
    endif

    if Not(a)
        let a = ToShortName(name)
    endif

    let s = 'let g:' . dictname . '[' . Quotify(a) . '] = ' . Quotify(b)
    execute s
    call append('$', s)
endfunction

function! NotFresh()
    ec 'not fresh. early return'
endfunction

function! IsFreshDictKey(dictname, a)
    let Value = eval("get(g:" . a:dictname . ", " . Quotify(a:a) . ")")
    return Value == 0
endfunction

function! AddParams(s)
    if Exists(a:s)
        return ', ' . a:s
    else
        return ''
    endif
endfunction

function! AddSpaces(lines, proceed)
    if Exists(a:proceed)
        let spaces = CurrentSpaces()
        return map(a:lines, {i, line -> spaces . line})
    else
        return a:lines
    endif
endfunction

function! AddText(s)
    normal /}<cr>o<esc>
    let spaces = CurrentSpaces()
    call setline('.', [spaces . a:s . ' {', spaces . '}'])
endfunction

function! AddToFileDict(s)
    let [key, val] = SplitOnce(a:s)
    let g:filedict[key] = val
    let outpath = 'vimrcfiledict.txt'
    call AppendFile(outpath, a:s)
    
endfunction

function! AddToKnownJSON(s)
    let s = a:s
    let [a,b] = SplitOnce(s)
    let p = JsonDictEntry(a, b)
    let lines = [p]
    let file = 'known.json'
    call appendbufline(file, 3, lines)
endfunction

function! AddToLdrDict(...)
    if CurrentFile() != '/home/kdog3682/.vimrc'
        ec 'not vim'
        return
    endif
    let [a,b] = a:0 >= 1 ? SplitOnce(a:1) : ['', '']  
    let name = GetFunctionName()
    if Exists(name)
        let b = name
    endif

    if Not(a)
        ec name
        let a = tolower(Replace(name, '[a-z]\C', '', 'g'))
    endif

    let b = "function('" . b . "')"
    let index = search('\v^ *"\\ *''ldr-start''', '')
    call SmartAppend(index, DictEntry(a, b))
    w
endfunction

function! AddToVSDict(...)
    let [a,b] = a:0 >= 1 ? SplitOnce(a:1) : ['', '']  
    let name = GetFunctionName()
    if Exists(name)
        let b = name
    endif
    if Not(a)
        ec name
        let a = tolower(Replace(name, '[a-z]\C', '', 'g'))
    endif

    let b = "{'fn': function('" . b . "'), 'i': 'code'}"
    let index = search('\v^ *"\\ *''vs-start''', '')
    ec index
    call SmartAppend(index, DictEntry(a, b))
endfunction

function! AddToken(s)
    let s = Replace(a:s, '[""'']', '', 'g')
    let s = Replace(s, ' ', ' = ''') . ''''
    call AppendFile('env.py', s)
endfunction

function! AlignAssignmentsOld()
    ec 'hi'
    let ASSIGN_OP   = '[-+*/%|&]\?=\@<!=[=~:]\@!'
    let ASSIGN_LINE = '^\(.\{-}\)\s*\(' . ASSIGN_OP . '\)\(.*\)$'

    let dicsdfsdft = {
    \}

    let [firstline, lastline] = GetContiguousIndexesIBM()
    ec [firstline, lastline]
    let lines = []
    for linetext in getline(firstline, lastline)
        let fields = matchlist(linetext, ASSIGN_LINE)
        ec fields
        call add(lines, fields[1:3])
    endfor
    return

    " Determine maximal lengths of lvalue and operator...
    let op_lines = filter(copy(lines),'!empty(v:val)')
    let max_lval = max( map(copy(op_lines), 'strlen(v:val[0])') ) + 1
    let max_op   = max( map(copy(op_lines), 'strlen(v:val[1])'  ) )
    ec max_lval
    ec max_op

    " Recompose lines with operators at the maximum length...
    let linenum = firstline
    for line in lines
        ec line
        if !empty(line)
            let newline
            \    = printf("%-*s%*s%s", max_lval, line[0], max_op, line[1], line[2])
            ec newline
            call setline(linenum, newline)
        endif
        let linenum += 1
    endfor
endfunction

function! AlwaysTrue(...)
    return 1
endfunction

function! AnotherTextTransform()
   let line = CurrentLine() 
   let replacement = 'console.log' . Parens(line)
   call SetLine(replacement)
endfunction

function! Append(s, ...)
    let index = a:0 >= 1 ? (IsNumber(a:1) ? Relative(a:1) : a:1) : line('.')
    call append(index, Indent(ToArray2(a:s), GetSpaces()))
endfunction

function! Zmark()
    let regex = 'uf'
    call AppendAboveSearch(regex, 'file = ' . SingleQuote(FileGetter2(input('choose file:'))))
endfunction

function! AppendAboveSearch(regex, s)
    let index = line('$')
    while index > 0
        let s = getline(index)
        let index -= 1
        if Test(s, a:regex)
            break
        endif
    endwhile
    let index -= 1
    call append(index, Indent(a:s, GetSpaces(index)))
endfunction

function! AppendAbove(s, ...)
    let index = a:0 >= 1 ? a:1 : line('.')
    call append(index - 1, Indent(a:s, GetSpaces(index)))
endfunction

function! AppendAboveAndBelow(indexes, above, below)
    let [a,b] = a:indexes
    call append(a - 1, a:above)
    call append(b + 1, a:below)
endfunction

function! GetIndentSpaces(...)
        let line = a:0 >= 1 ? (IsNumber(a:1) ? getline(a:1) : a:1) : ''
        let es = a:1 >= 1 ? 1 : 0
        let spaces = GetSpaces(line)
        "ec [line, spaces]
        if es == 1 && line =~ '\v[\{\[]$|^ *(if|else|elif|function|class|def|while)'
            let spaces .= '    '
        endif
        return spaces
endfunction

function! AppendBelow(index, insertion)
    let index = IsString(a:index) ? SearchUp(a:index) : a:index
    let spaces = GetIndentSpaces(index)
    let payload = ToArray2(Indent(a:insertion, spaces))
    call append(index, payload)
endfunction

function! AppendBottom(lines, ...)
    "let relativeCursor = a:0 == 1 ? line('.') + a:1 : '$'
    call append('$', a:lines)
    if a:0 >= 1 
        call cursor('$', 0)
    endif
endfunction

function! LeaderDictify(s)
    
endfunction

function! LeaderAppend(s)
    let lines = GetBlockDeleteBlock([0, line('$')])
    call AppendFile(a:s, lines)
endfunction


function! _WriteFile(file, lines, mode)
    let lines = a:lines
    let file = a:file
    let mode = a:mode
    call writefile(lines, file, mode)
    let g:lastfile = file
endfunction

function! AppendIndexesAboveAndBelow(indexes, a, b)
    call append(a:indexes[0] - 1, a:a)
    call append(a:indexes[1] + 1, a:b)
endfunction

function! AppendLines(lines, destination)
    call add(a:lines, '')
    call writefile(a:lines, a:destination, 'a')
endfunction

function! AppendMyShortCuts(s)
    let items = split(a:s)
    let s = ''
    for i in range(0, len(items) - 1, 2)
        let [a,b] = [items[i], items[i + 1]]
        let s .= '    ' . Quotify(a, 'dq') . ': ' . Quotify(b, 'dq') . ",\n"
    endfor
    let s = s[:-2] . "\n}"
    let s = split(s, "\n")
    call setbufline('myshortcuts.json', '$', s)

endfunction

function! AppendSelf(items, ...)
    let location = a:0 == 1 ? a:1 : '$'
    let lines = SpaceWrap(Flat(a:items, 1))
    call append(location, lines)
endfunction

function! AppendToFile(file, lines)
    call writefile(readfile(a:file)+a:lines, a:file)
endfunction

function! AppendToVueData(...)
    let s = a:0 >= 1 ? Replace(a:1, ' ', ': ') : GetImplicitVueData() 
    call SetPosition(line('$') - 200)
    let index = Search('^ *' . g:vuedict.dataRE)
    ec index
    let spaces = GetSpaces(getline(index)) . '    '
    call append(index, spaces . s . ',')
endfunction

function! AppendToVueMethods()
    let name = GetFunctionName()
    call SetPosition(line('$') - 400)
    let index = Search('^ *' . g:vuedict.methodRE)
    let spaces = GetSpaces(getline(index)) . '    '
    call append(index, spaces . name . ',')
endfunction

function! AppendTop(s, ...)
    let index = 0
    let movecursor = a:0 == 1 ? a:1 : 0
    call append(index, ToArray2(a:s))
    if movecursor
        call cursor(index + 1, 100)
    endif
endfunction

function! AppendVim(lines, ...)

   let location = a:0 >= 1 ? a:1 : '$'
   let payload = ToLines(a:lines)

   if IsVim()
        call append(location, payload)
        ec '@vimrc: appended vim'
        return 
   endif

   try
      call appendbufline('~/.vimrc', location, payload)
      ec '@otherfile: appended vim'
   catch
      ec v:exception
      ec 'error at append vim trying again'
      call writefile(payload, '/home/kdog3682/.vimrc', 'a')
   endtry
endfunction

function! ArchiveContents(indexes)
    let lang = expand('%:t')
    let name = 'archive' . lang
    call AppendFile(name,  GetLines(a:indexes))
    call DeleteLines(a:indexes)
    ec ReadFile(name)
endfunction

function! ArgHandler(arr)
    function P(item)
        let item = a:item
        if item == 'upline'
            return getline(Relative(-1))

        elseif item == 'line'
            return CurrentLine()

        elseif item == 'downline'
            return getline(Relative(1))

        elseif item == 'pos'
            return CurrentLine()
        endif
    endfunction
    return Mapped2(a:arr, P)
endfunction

function! ArrayExpand(line)
   let parts = split(a:line) 
   let s = Mapped(parts, 'DollarReplace')
   return '[' . join(s, ', ') . ']'
endfunction

function! AskQuestion(...)
    if IsSplitWindow()
        execute "wq"
        call ExecuteFile('redditscript.py')
        return 
    endif

    let s = a:0 >= 1 ? a:1 : 0
    let lang = GetLang()

    if Not(s)
        call OpenBuffer('/home/kdog3682/CWF/questions.txt', 'vsplit')
        execute "normal! G"
        return
        execute "normal! Go" . lang . '      '
    endif
    "let text = join(lines, "\\n")
    "let text = EscapeForTerminalArg(text)
    "ec text
    "execute ":!python3 reddit.py " . text

    let indexes = GetCSIndexes()
    let lines = GetLines(indexes)
    "let lines = Indent(lines)
    "call add(lines)
    "let dict = {
    "\  "input": a:s,
    "\  "excerpt": Join(lines),
    "\  "lang": GetLang(),
    "\}

    call insert(lines, GetLang() . ' ' . a:s)
    call WriteFile('temp.txt', s)
    execute "!python3 reddit.py temp.txt"
    return

    call add(g:questionlist, GetLang() . ' ' . a:s)
    if len(g:questionlist) == 5
        ec 'posting to reddit'
        WriteFile('temp.txt', Stringify(g:questionlist))
        execute ":!python3 reddit.py temp.txt"
        let g:questionlist = []
    endif
    return
    let lines = GetIndent() == 0 ? Indent(CurrentLine()) : Indent(GetFunction())
    let lang = GetLang()
    let [question, body] = ForceSplit(a:s, '  ')
    let s = '@' . lang . ' ' . question
    call insert(lines, '')
    call insert(lines, s)
    call add(lines, '')
    call add(lines, body)
    ec lines
    AppendFile('questions.txt', lines)
endfunction

function! AutoComplete()
    let fline = GetFunctionLine()
    let param = GetFunctionParam(fline)
    let line =  GetCurrentLine()
    let line = '    elif str'
    let param = 'foo'
    echom line
    let match = matchstr(line, '\(elif\|if\) \zs\(str\|list\|num\|arr\|a\|obj\|o\)$')
    echom match
endfunction

function! BackupFile()
    let cwf = "/mnt/chromeos/GoogleDrive/MyDrive/"
    let name = expand('%:t')
    let outpath = cwf . name 
    echom outpath
    call writefile(getline(1,'$'), outpath)
endfunction

function! Basename(name)
    let parts = split(a:name, '/')
    try
        return parts[-1]
    catch
        return a:name
    endtry
endfunction

function! BashCopy(file, name)
    let cmd = "cp " . NameEscape(a:file) . " " . a:name
    ec cmd
    execute cmd
endfunction

function! BeforeAndAfter(s, a, b)
    return a:a . a:s . a:b
endfunction

function! BelowLineOccupied()
    return strlen(Strip(getline(Relative(1)))) > 0
endfunction

function! BlockComment(indexes)
   let lang = expand('%:e')   
   ec lang
   if lang == 'html' || lang =~ 'vimrc'
       if Test(getline(a:indexes[0]), '<!--')
           call DeleteAboveAndBelow(a:indexes)
        else
            call AppendAboveAndBelow(a:indexes, '<!--', '-->')
        endif
   endif
endfunction

function! BlockDitto(tag, rest)
    let lines = ReplaceLines(GetLines(indexes), a:rest)
    "if tag == 'else'
        "let lines[0] = GetSpaces(lines[0]) . JSPY('else')
    "endif
    call append(indexes[1], lines)
endfunction

function! Blockify(indexes)
    let startItem = a:0 >= 1 ? a:1 : 'div {'
    let endItem = a:0   >= 2 ? a:2 : '}'

    let [start, end] = a:indexes
    let indentation = GetSpaces(getline(start))

    call GetSetLines(a:indexes, function('IndentLine'))

    let firstline = indentation . startItem
    call append(start - 1, firstline)
    call append(end + 1, indentation . endItem)
    call setpos("'a", [0, end + 2, 100, 0])
    call cursor(start, strlen(firstline))
endfunction

function! Boundary(s)
    return '<' . a:s . '>'
endfunction

function! BoundaryReplace(s, regex, replacement)
    return substitute(a:s, Regexed('<' . a:regex . '>'), a:replacement, '')
endfunction

function! Brackify(name, items)
    let items = IndentAll(a:items)
    call insert(items, a:name . ' {')
    call add(items, '}')
    return items
endfunction

function! BringToRoot()
    saveas! ~/CWF/root.js
endfunction

function! BrowseFiles(...)
   let query = a:0 >= 1 ? a:1 : 'aops'
   let files = GlobIt()
   let answer = GetInput('choose file index')
   if Not(answer)
    ec 'no answer'
    return
   let file = files[answer]
   ec ''
   ec file
   ec 'i-'
   call OpenBuffer(file)
endfunction

function! BufLoad(destination)
    if !bufexists(a:destination)
        ec 'file doesnt exist'
        "execute "e " . a:destination
        execute "buffer " . a:destination
    elseif !bufloaded(a:destination)
        ec ' buf not loaded'
        execute "buffer " . a:destination
    else
        ec 'else statement'
        execute "buffer " . a:destination
    endif 
endfunction

function! BufRange()
    return range(1, bufnr('$'))
endfunction

function! BufferScrape(r)
    lines = readfile(PathFix('s'))
    return FindAll(a:r, lines)
endfunction

function! Caller(name)
    let suffix = EndsWith(a:name, ')') ? '' : '()'
    let command = ':ec ' . a:name . suffix
    echom command
    execute command
endfunction

function! Pascal(s)
    let s = a:s
    return join(map(split(s, '\W'), 'Capitalize(v:val)'), '')
endfunction

function! Camelize(s)
    return Sub(a:s, '-', '_')
endfunction

function! Capitalize(s)
    let s = a:s
    return toupper(s[0]) . (s[1:])
endfunction

function! Cfun(name, ...)
    let options = a:0 == 1 ? a:1 : 0
    let boundary = 0
    if options == 'b'
        let boundary = 1
    endif
    let rname = boundary ? Boundary(a:name) : a:name
    let text = FileString()
    let regex = '(function|def|class) ' . rname
    if Test(text, regex)
        call SetCursor(Regexed(regex))
    else
        call CreateFunctionBlock('bottom', a:name)
        return
        echom 'hi'
        echom expand('<cword>')
        let wordUnderCursor = expand("<cword>")
        echom wordUnderCursor
    endif
endfunction

function! ChangeDir(...)
    let path = get(g:dirdict, getcwd(), '/home/kdog3682/CWF/public')
    ec path
    execute "cd " . path
    return 

    execute "cd %:p:h"
    let tag = a:0 >= 1 ? a:1 : 'cwf'
    let dict = {
    \    'downloads': "/mnt/chromeos/MyFiles/Downloads",
    \    'save': "/mnt/chromeos/GoogleDrive/MyDrive/CWF",
    \    'drive': "/mnt/chromeos/GoogleDrive/MyDrive/",
    \    'cwf': '/home/kdog3682/CWF',
    \    'cwd': '/home/kdog3682/Cwd',
    \}
    let dir = get(dict, tag, get(dict, 'cwf'))
    execute "cd " . dir
endfunction

function! CharPos(n)
    let [a,b,c,d] = getpos('.')
    return [a,b, c + a:n, d]

endfunction

function! CheckFile()
   let name = NameFile()
   if filereadable(name)
       echo name . ' exists!'
   else
       echo name . ' doesnt exist'
   endif
endfunction


function! Ck()
    let [spaces, line] = GetSpacesAndLine()
    let product = spaces . 'console.log("' . line . '")'
    ec product
    call append(Relative(-1), product)
endfunction

function! Cleanup()
   echom 'cleaning'
   %s/\v^ *(console.log|print|#|\/\/).*\n//g
endfunction

function! ClearFile(file)
    call writefile([''], a:file, 'w')
    ec 'the file ' . a:file . ' has been cleared'
endfunction

function! ClearScreen()
    !clear
endfunction

function! CloseActiveBuffers()
    for buffer in GetVisibleBuffers()
        call CloseBuffer(buffer)
    endfor
endfunction

function! CloseAllExcept(...)
    let query = a:0 >= 1 ? a:1 : 'vuecm5|helpers.js'
    for buffer in GetVisibleBuffers()
        if Test(buffer, query)
            continue
        endif
        call CloseBuffer(buffer)
    endfor
endfunction

function! SaveAllFiles()
    wa
    ec 'saving all'
endfunction

function! WriteCurrentFiles()
    call WriteFile('currentfiles.txt', GetBufferNames())
endfunction

function! ToList(s)
    return split(trim(a:s), "\n")
endfunction

function! LoadCurrentFiles()
    let query = 'currentfiles.txt'
    let buffers = IsArray(query) ? query : ToList(ReadFile(query))
    ec buffers
    call Iterate(buffers, function('OpenBuffer'))
endfunction

function! SaveProgress(...)
    let arg = a:0 >= 1 ? a:1 : ''
    let payload = ['', '', DateStamp()]

    call AppendVim('"' . DateStamp())
    call extend(payload, GetBufferNames())
    call AppendFile('progress.txt', payload)
    let names = join(map(split(arg, ' '), 'get(g:filedict, v:val, v:val)'), ' ')
    call SaveAllFiles()
    "call LeaderManager('sd ' . names)
endfunction

function! GetBufferNames()
    return map(GetVisibleBuffers(), 'Basename(bufname(v:val))')
    "let p = map(GetVisibleBuffers(), 'bufname(v:val)')
    "return p
endfunction

function! CloseBuffer(...)
    try
        let buffer = a:0 >= 1 ? a:1 : '%'
        let name = IsStringNumber(buffer) ? bufname(str2nr(buffer)) : buffer
        execute "bd " . name
    catch
        
    endtry
endfunction

function! CloseAllBuffersAndOpen(key)
    call Iterate(GetCurrentBuffers(), function('CloseBuffer'))
    call ChooseBuffer2(a:key)
endfunction

function! CloseBuffersByQuery(query)
    let targetbuffers = Filtered(GetCurrentBuffers(), a:query)
    ec targetbuffers
    call Iterate(targetbuffers, function('CloseBuffer'))
endfunction

function! CnsBuildConstructorVariables(indexes)
    let [a,b] = a:indexes
    let text = TextGetter(a, b)
    let prefix = IsPy() ? 'self' : 'this'
    let pairs = GetFunctionVariables(text)
    let lines = Indent(Mapped(pairs, {k -> prefix . '.' . k . ' = ' . k}))
    call append(a, lines)
    
endfunction

function! OldCombineFiles(s)
    let files = Mapped(split(a:s), 'FileGetter')
    for file in files
        if !filereadable(file)
            continue
        endif
        call extend(store, readfile(file))
        if file != files[0]
            call DeleteFile(file)
        endif
    endfor
    call WriteFile(files[0], store)
endfunction

function! Commander(method, ...)
    let method = a:method
    let args = a:000
    let cmd = method . ' '
    if method == 'cp'
        let cmd .= args[0] . ' ' . args[0] 
    elseif method == 'cp'
        let cmd .= args[0] . ' ' . args[0] 
    elseif method == 'cp'
        let cmd .= args[0] . ' ' . args[0] 
    elseif method == 'cp'
        let cmd .= args[0] . ' ' . args[0] 
    endif
    execute cmd
endfunction

function! CommentIt ()
  if &filetype == "vim"
    vmap +# :s/^/"/<CR>
    vmap -# :s/^"//<CR>
  elseif &filetype == "tcl"
    vmap +# :s/^/#/<CR>
    vmap -# :s/^#//<CR>
  elseif &filetype == "c"
    vmap +# I/*<Esc>gv<End><Esc>a*/<Esc>
    vmap -# I<Esc>2xgv$<Esc>h2x<Esc>
  elseif &filetype == "cpp"
    vmap +# A<End><CR><Esc>gv:s/^/ *<CR>gvI<Esc>ko<Home>/*<Esc>gvA<Esc>ji */
    vmap -# :s/^..//<CR>gvI<Esc>ddgvA<Esc>dd
  elseif &filetype == "dosbatch"
    vmap +# :s/^/rem /<CR>
    vmap -# :s/^rem //<CR>
  endif
endfunction

function! CommentLine(...)
    let lang = GetLang()
    "ec 'asdf'
    if lang == 'html'
        if Test(CurrentLine(), '^ *\<!')
            return LineSetter('UncommentHtml')
        else
            return LineSetter('CommentHtml')
        endif
    endif
    let val = a:0 == 1 ? a:1 : 0
    let [prefix, suffix] = JSPY('commentPrefix', 'commentSuffix')

    if IsNumber(val)
        "ec 'a11'
        let line = getline(Relative(val))
        let spaces = GetSpaces(line)
        let product = spaces . prefix . Strip(line) . suffix 
        call setline(Relative(val), product)
    elseif empty(val)
        ec 'asdfasdfm2'
        let line  = CurrentLine()
        let spaces = CurrentSpaces()
        let product = spaces . prefix . Strip(line) . suffix 
        call setline('.', product)
    else
        ec 'a33'
        return prefix . val . suffix
    endif
endfunction

function! CommentOutDecorators()
    echom 'adf'
    normal /^@/# @/g
endfunction

function! ConditionHandler(condition, line)
    let line = a:line
    if IsString(a:condition)
        return Test(line, a:condition)
    else
        return a:condition(line)
    endif
endfunction

function! ConditionalAdd(s, addition, condition)
    if Test(a:condition, a:s)
        return a:s . a:addition
    else
        return a:s
    endif
endfunction

function! ConditionalComment(s)
    let comment = JSPY('comment')
    if a:s != '' && !Test(a:s, Rescape(comment))
        return comment . a:s
    endif
endfunction

function! ConsoleLog(s)
    let prefix = GetLang() == 'js' ? 'console.log' : 'print'
    return prefix . Parens(a:s)
endfunction

function! ConsoleLogTheLine()
    "let prefix = GetLang() == 'js' ? 'let ' : ''
    let prefix = ''
    let [spaces, line] = GetSpacesAndLine()
    if Test(line, '^ *(console\.log|print|ec)\ze *\(') 
        if GetLang() == 'js'
            let el = 's'
            let f = Match(line, '\C[A-Z]\w+\ze\(')
            if Test(f, 's$')
                let el = 'items'
            endif
            let payload = Replace(Replace(line, 'console.log\(', 'const ' . el . ' = '), '\)$', '')
            call setline('.', spaces . payload)
            ec [spaces]
            return 

        endif
        let line = Replace(line, '^ *(console\.log|print|ec).{-}(\w+)', {x -> prefix . get(g:fdict, x[1], 's') . ' = ' . x[2]})[:-2]
        call setline('.', line)
    else
        call GetSetLines('.', 'Logger')
    endif
endfunction

function! Consoler(s)
    return 'console.log' . Parens(a:s)
endfunction

function! ContentPlacement(...)
    let spaces = '    '
    for i in range(0, a:0 - 1, 1)
        let item = spaces . a:000[i]
        if i == a:0 - 1
            call setline('.', item)
        else
            call foo()
        endif
        " call RelativeAppend(-1, currentSpaces . LogicParse(Strip(line)) . p2)
        " call setline('.', currentSpaces . '    ')
        " call RelativeAppend(0, currentSpaces . suffix)
        " echom i
        " echom a:000[i]
    endfor
endfunction

function! Copy()
    let lines = GetFunction()
    let namespot = GetNameSpot(lines[0])
    let length = len(lines)
    call AppendSelf(lines)
    call Cursor(-length, namespot)
endfunction

function! CopyBlock()
    let [a,b] = GetCodeIndexes()
    let lines = GetLines(GetCodeIndexes())
    call AppendSelf(lines)
endfunction

function! CopyBlock2(...)
    let [a,b] = a:0 >= 1 ? a:1 : GetCodeIndexes()
    let text = TextGetter(a, b)
    call ToPasteBuffer(text)
endfunction

function! CopyCapitalization(s, ref)
    if Test('^[A-Z]', a:ref)
        return Capitalize(a:s)
    endif 
    return a:s
endfunction

function! CopyFileToOtherDir(...)
   let file = CurrentFile()
   let dir = a:0 >= 1 ? a:1 : Head()
   let dir = Match(file, '.{-}\ze/\w+\.\w+$')
   let to = DirGetter(dir)
   let path = PathJoin(to, Basename(file))
   call Prompt(path)
   let lines = readfile(file) 
   call WriteFile(path, lines)
   call OpenBuffer(path)
endfunction

function! CopyFile(file, to)
   let file = FileGetter2(a:file)
   let to = Exists(a:to) ? FileGetter2(a:to) : IncrementFileNumber(file)
   let lines = readfile(file) 
   call WriteFile(to, lines)
endfunction

function! Tail(...)
    if a:0 >= 1
        return split(a:1, '/')[-1]
    else
        let tail = expand('%:t')
        return Replace(tail,  '^\W+', '')
    endif
endfunction

function! BashCopyFile(file, to)
    "execute "! " . "cp " . FileGetter2(a:file) . ' ' . DirGetter(a:to)
endfunction

function! CopyFileToRoot()
    let fullpath = expand('%:p')
    let tail = expand('%:t')
    let base = g:cwd
    execute "! " . "cp " . fullpath . ' ' . base 
endfunction

function! CopyFunctionBlock()
   let lines = GetLines(GetCodeIndexes())
   let length = len(lines)
   call AppendBottom(lines, -length)
endfunction

function! CopyLastDriveFile()
    let dir = '/mnt/chromeos/GoogleDrive/MyDrive/'
    let cmd = "ls " . dir . " -t" . "" . " | head " . " -" . "1" 
    let raw = systemlist(cmd)
    let file = raw[0]
    let cmd = "!cp " . dir . shellescape(file) . " " . "copy.pdf"
    ec cmd
    execute cmd
endfunction

function! CopyToRoot()
    ec 'hi'
    let lines = GetLines()    
    "let name = Basename(CurrentFile())
    let name = FileTail()
    let outpath = '/home/kdog3682/CWF/' . name
    ec outpath
    ec 'len lines'
    ec len(lines)
    call WriteFile(outpath, lines)
endfunction

function! CopyUpLine(...)
    let [spaces, line] = GetSpacesAndLine()
    let template = getline(Relative(-1))
    let parts = split(line)
    let regex = split(parts[0], '/')
    let items = parts[1:]
    let store = []
    let product = ''
    for item in items
        let product = template
        let parts = split(item, '/')
        for i in range(len(parts))
            let product = Parser233(product, regex[i], parts[i], 'g')
        endfor
        call add(store, product)
    endfor
    call setline('.', store[0])
    call append('.', store[1:])
    return 
endfunction

function! Count(s, el)
    let matches = matchlist(a:s, Regexed('\ze' . a:el))
    ec matches
endfunction

function! CountParameters(line)
    return count(a:line, ',') + 1
endfunction

function! CreateClassName(line, p1, p2, param)
    if Has(a:line, '\(')
        return a:line
    endif
    
    let parts = split(Strip(a:line))
    if Exists(a:param)
        call insert(parts, a:param, 1)
    endif
    let first = parts[0]

    let rest = '()'

    if len(parts) > 1
        let rest = '(' . join(parts[1:], ', ') . ')'
    endif

    return p1 . first . rest . a:p2
endfunction

function! CreateCodingArticle(name)
    let lines = getline('.', '$')
    .,$d
    w
    call WriteFile(a:name, lines)
    call OpenBuf(a:name)
endfunction

function! CreateDictFromArray(items, fn, ...)
    let reverse = a:0 == 1 ? a:1 : 0 
    let dict = {}
    for item in a:items
        if reverse
            dict[a:fn(item)] = item
        else
            dict[item] = a:fn(item)
        endif
    endfor
    return dict
endfunction

function! CreateDictFromString(s)
    let dict = {}
    let parts = split(a:s, '  ')
    for item in parts
        let [a,b] = SplitOnce(item)
        let dict[a] = b
    endfor
    return dict
endfunction

function! CreateFile()
   let lines = GetTextChunk() 
   call insert(lines, 's = \'\'\'')
   call add(lines, '\'\'\'')
   AppendFile('strings.py', lines)

endfunction

function! CreateFileFromLine(...)
    let line = CurrentLine()
    let match = Match(line, '["'']\zs[-a-zA-Z0-9]+\.(js|py|html|css)\ze["'']')
    if Exists(match)
        ec match
        call OpenBuffer(match)
    endif
endfunction

function! CreateFooFunction(s, ...)
    let arg = a:0 >= 1 ? a:1 : 'FooFunction'
    let [a,b] = a:s
    "let lines = IndentAll(GetLines(a:s))
    call IndentAll(a:s)
    let statement = 'function ' . arg . '() {'
    let suffix = '}'
    "call insert(lines, statement)
    "call add(lines, suffix)
    call append(a - 1, statement)
    call append(b, suffix)
endfunction

function! Dated(s)
    return DateStamp() . ' ' . a:s
endfunction

function! ToggleGlobalConfig(key)
    let ref = {
        \'m': 'markit',
    \}
    let key = get(ref, a:key, a:key)
    let g:globalconfig[key] = Opposite(g:globalconfig[key])
    ec g:globalconfig
endfunction

function! IsMarkable(s)
    return g:globalconfig['markit'] == 1 && (a:s == '/home/kdog3682/.vimrc' || Includes(GetExtension(), ['js', 'css']))
endfunction

function! CreateFunctionCall(name, params)
    let [cs, ce] = JSPY('consoleStart', 'consoleEnd')    
    return cs . a:name . Parens(join(a:params, ', ')) . ce
endfunction

function! CreateFunctionFromLine()
    let line = CurrentLine()
    let currentword = CurrentWord()
    let wordindex = match(line, currentword . '(')
    if wordindex > -1
        let line = line[wordindex:]
    endif
    let line = Replace(line, 'a:', '', 'g')
    let match = Strip(Match(line, '\w+\([a-zA-Z, ]+\)'))
    if empty(match)
        let match = Strip(matchstr(line, '\v\w*\ze\('))
    else
        let match = Replace(match, '''''', 's')
    endif
    call CreateFunctionBlock('bottom', match)
endfunction

function! CreateIab(...)
   let s = a:0 >= 1 ? a:1 : 'iab ' . StripLine()
   let cmd = Test(s, ' ') ? Join('iab', s) : Join('iab', s, StripLine())
   ec cmd
   call AppendVim(cmd)
   execute cmd
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

    let rest = '(s)'

    if len(parts) > 1
        let rest = '(' . join(parts[1:], ', ') . ')'
    endif

    if a:capitalize
        let first = Capitalize(first)
    endif
    
    return first . rest
endfunction

function! CreateNormalCommand(s)
   let [key, fn] = SplitOnce(a:s)
   let cmd = Join('nnoremap', key, ':call', fn . '()<cr>')
   ec cmd
   call AppendVim(cmd)
endfunction

function! CreatePairs(items)
    let items = a:items
    let store = []
    for i in range(0, len(items) - 1, 2)
        call add(store, [items[i], items[i + 1]])
    endfor
    return store
endfunction

function! CreateRegex(s, ...)
    let dict = {
    \    'dotu': '.*?',
    \    'dot': '.*',
    \    'cwp': '\w+',
    \    'plb': '(?<=',
    \    'nlb': '(?<!',
    \    'pla': '(?=',
    \    'nla': '(?!',
    \    'ncg': '(?:',
    \    'az': '[a-zA-Z]',
    \    '3': '#',
    \    '2': '@',
    \    '4': '$',
    \    '6': '^',
    \    '8': '*',
    \    '9': '(',
    \    '0': ')',
    \ }
    let presetdict = {
    \    'ss': '''^    ''',
    \    'spaces': '''^    ''',
    \    'cdf': '''^(function|def|class) ''',
    \ }
    let s = a:s
    if Test(s, '^r\.')
        return s
    endif
    let match = get(presetdict, s)
    if Exists(match)
        return match
    endif
    if Unquoted(s)
        let s = Quotify(s)
    endif
    let s = Dreplace(s, dict)
    return s
endfunction

function! CreateSampleParams(line)
    let params = GetFunctionParameters(a:line)
    return

endfunction

function! CreateScript()
    ec GetPos()
    let index = search('\v    (from|import)', ')
    if index <= 0
        ec 'not found'
        return
    else
        ec index
    endif

    ec GetPos()
     
endfunction

function! CreateSnippetFromSelection(...)
    
endfunction

function! CreateTemplate()
    let [file, key] = split(trim(GetInput('file && key')), ' ')
    let s = join(readfile(file), "\\n")
    let s = Replace(s, '"', '\\"', 'g')
    let p = '\  ' . Quotify(key, 1) . ': ' . Quotify(s, 1) . ','
    call ToPasteBuffer(p)
endfunction

function! CreateVariable(name, value)
    let spaces = CurrentSpaces()
    let prefix = JSPY('variablePrefix')
    return spaces . prefix . a:name . ' = ' . a:value
endfunction

function! CreateVimCommand()
   let name = GetFunctionName() 
   let items = ['command', name, 'call', name . '()', ' |"@generated']
   let s = join(items)
   AppendSelf(s, 'bottom')
endfunction

function! CreateVimCommansdfgdfgd(s)
    let dict = {
    \    'i': 'inoremap',
    \    'n': 'nnoremap',
    \ }
endfunction

function! CreateVisualIab(lineindex, s)
   if IsArray(a:lineindex)
       let lines = Mapped(GetLines(a:lineindex), {s -> '\<CR> ' . s})
       call insert(lines, 'iab ' . a:s )
       call AppendVim(lines, '^')
       return 
   endif
   let s = Strip(getline(a:lineindex)) 
   let cmd = Join('iab', a:s, s)
   ec cmd
   call AppendVim(cmd)
   execute cmd
endfunction

function! CreateWorkSpace()
    call OpenBuffer('tempworkspace.txt')
endfunction

function! Createabrev(s)
    let line = Strip(CurrentLine())
    let s = Join('iab', a:s, line)
    call AppendVim(s)
endfunction

function! CssComment(x)
    return '/* ' . x . '*/' 
endfunction

function! CssGetter(s)
   if !exists('g:cssdict')
       let g:cssdict = ReadJson('css-abrev.json')
    endif
   if has_key(g:cssdict, a:s)
       return g:cssdict[a:s]
    else
        return a:s
    endif
endfunction

function! CssHandler()
    if GetLang() == 'py'
        return 
    endif
    let [spaces, line] = GetSpacesAndLine()
    let parts = split(line, '\v  +')
    let store = []
    for part in parts
        let [a,b] = SplitOnce(part)
        let product = spaces . CssGetter(a) . ': ' . b . ';'
        call add(store, product)
    endfor

    call setline('.', store[0])
    call append('.', store[1:])
    call cursor('.', 100)
endfunction

function! CssMaker(s)
    let parts = split(a:s, '\v  +|, *')
    let store = []
    for part in parts
        let [a,b] = SplitOnce(part)
        call add(store, CssGetter(a) . ': ' . b)
    endfor
    return store
endfunction

function! CssSearch(s)
    execute "normal! /" . "\." . a:s . "\<cr>"
endfunction

function! CurrentExtension()
    return expand('%:e')
endfunction

function! CurrentFile()
    let name = expand('%:p')
    return name
endfunction

function! CurrentIndex()
    return line('.')
endfunction

function! CurrentLine()
    return getline('.')
endfunction

function! CurrentLineAndSpaces()
    let line = CurrentLine()
    let spaces = Match(line, '^ *')
    return [line, spaces]
endfunction

function! CurrentLineNumber()
    return line('.') 
endfunction

function! CurrentSpaces(...)
    return matchstr(CurrentLine(), ' *')
endfunction

function! CurrentPos()
    let p = getpos('.')[1:-2]
    return p
endfunction

function! SetChar(...)
    let n = a:0 >= 1 ? a:1 : -1
    let [line, ch] = CurrentPos()
    call setpos('.', [0, line, ch + n, 0])
endfunction

function! CurrentWord()
    let c = 0
    let word = expand('<cword>')

    while (word == ')' || word == ']' || word == '}' || word == '')
        let c += 1
        if (c > 5)
            call ThrowError('c count is too high @ currentword')
        endif
        call SetChar()
        let word = expand('<cword>')
    endwhile
    let p = word
    return p
        
endfunction

function! CurrentWordHandler()
    let [spaces, line] = GetSpacesAndLine()
endfunction

function! Cursor(s, ...)
    let chpos = a:0 == 1 ? a:1 : 100
    call cursor(a:s, chpos)
endfunction

function! CursorAtLineEnd()
    return getpos('.')[2] == len(getline('.')
endfunction

function! CursorAtLineStart()
    return getpos('.')[2] == 0
endfunction

function! CursorNearBottom()
    let index = line('.')
    let end = line('$')
    let threshold = 10
    return index >= end - threshold
endfunction

function! DA1(line)
    let snippet = SmartDittoSnippet()
    call GetSet(line, {s -> spaces . Replace(s, 'd\ze\.', snippet)})
    return
endfunction

function! DA2(line)
    let s = a:line[2:]
    call GetSet(Relative(-1), {s -> Replace(Replace(s, '\w\zs\ze\)', ', '), '\ze\)', s)})
    call setline('.', GetSpaces())
endfunction

function! DateName()
    let strife = '%A-%m-%d-%Y'
    let date = strftime(strife) 
    let name = date . '.txt'
    "echo name
    return name
endfunction

function! ClockStamp()
    let strife = '%X'
    let date = strftime(strife)
    return date
endfunction

function! GetBookMarkName()
    let r = '^\w+ \zs\w+'
    let name = SprawlMatch(r)
    return name
endfunction

function! DateStamp(...)
    let strife = a:0 >= 1 ? a:1 : '%m-%d-%Y'
    let date = strftime(strife)
    return date
endfunction

function! DateStampFunctionName()
    return
endfunction

function! DebugBlock(indexes)
    for i in Ranger(a:indexes)
        let line = getline(i)
        let match = Match(line, '(\w+|\[.{-}\])\ze \=')
        let spaces = GetSpaces(line)
        if Exists(match)
            let message = spaces . Logger('"Debugging ' . match . ': ' . (i  + 1). '", ' . match)
            call append(i, message)
        endif
    endfor
endfunction

function! DebugLine()
    let index = Relative(-1)
    let spaces = CurrentSpaces()
    let message = spaces . JSPY('consoleStart') . '"Debugging on line ' . (index + 1) . '."' . JSPY('consoleEnd')
    call append(index, message)
endfunction

function! DedentArray(arr)
    return map(a:arr, "Replace(v:val, '^ *', '')")
endfunction

function! Dedent(lines)
    if IsString(a:lines) 
        return Replace(a:lines, '^' . g:globaltabwidth, '')
    endif
    let spaces = Match(a:lines[0], '^ *')
    if (spaces == '')
        if Test(a:lines[0], '^function')
            return a:lines
        endif
        let spaces = '    '
    endif
    return map(a:lines, 'Replace(v:val, spaces, "")')
endfunction

function! DedentAll()
    call GetSetLines(GetContiguousIndexes(), {s -> Replace(s, '^ *', '')})
endfunction

function! DedentLine(s)
    return Replace(a:s, '^ *', '')
endfunction

function! DedentLines(lines)
    let spaces = GetSpaces(a:lines[0])
    return Mapped(a:lines, {s -> Replace(s, '^' . spaces, '')})
endfunction

function! DeleteAboveAndBelow(indexes)
    let [a,b] = a:indexes
    call setline(a, '')
    call setline(b, '')
endfunction

function! DeleteBlockAndArchive()
    return 
    call ShuntAway(GetCodeIndexes())
endfunction


function! SafeGuard(x)
    let x = a:x
    if Test(x, 'vim|helpers|utils|bash')
        ec 'sorry. this file cannot be deleted due to safeguard')
        call Stop()
    endif
endfunction

function! DeleteFile(...)
    let file = a:0 >= 1 ? a:1 : CurrentFile()
    call SafeGuard(file)
    execute "bd! " . file 
    ec 'deleting file: ' . file
    call delete(fnameescape(file))
endfunction

function! DeleteKeyFromJson(s)
    let p = JsonDictEntry(a, b)
    let file = 'known.json'
    let lines = readfile(file)
    for i in Ranger(lines)
        if Test(lines[i], regex)
            call BufLoad(file)
            call deletebufline(file, i)
            break
        endif
    endfor

endfunction

function! DeleteLine(...)
    let i = a:0 >= 1 ? line(a:1) : line('.')
    let line = getline(i)
    call deletebufline('%', i)
    return line
endfunction

function! DeleteLines(indexes)
    let [a,b] = a:indexes
    for i in range(a,b)
        call deletebufline('%', 1)
    endfor
endfunction

function! DeleteLinesManually()
    1,$d
    "execute "1,$d"
endfunction

function! DeleteRange(indexes)
    let [a,b] = a:indexes
    call deletebufline('%', a, b)
endfunction

function! Deleter(s, r)
    return Replace(a:s, a:r, '')
endfunction

function! Input(items) 
  let items = a:items
  call Numbered(items)

  ec 'choose 0-based indexes'
  ec '----------------------'
  ec ''
  let s = input('')

  if s == ''
      return 
  endif

  return items[s]

endfunction

function! GetInputItems(items) 
  let items = a:items
  call Numbered(items)
  let s = input('Enter retrieval indexes @ 0based indexes: ')
  if s == ''
      return 
    endif
  "let indexes = map(split(s, ' '), 'v:val')
  let indexes = split(s, ' ')
  "ec indexes
  let p = map(indexes, 'items[v:val]')
  return p
endfunction

function! Demo()
  let curline = getline('.')
  "call inputsave()
  let name = input('Enter name: ')
  "call inputrestore()
  call setline('.', curline . ' ' . name)
endfunction

function! DetermineDestination(x)
    let first = IsArray(a:x) ? a:x[0] : a:x

    let dict = {
    \    g:variableRE: 'r.py',
    \    g:functionRE: 'storage.py',
    \ }

    let destination = IterativeSearch(first, dict, 0)
    return destination
endfunction

function! DictAction(line, dict)
    for [k,V] in items(a:dict)
        if Test(a:line, k)
            call V(line)
            return 1
        endif 
    endfor
    return 0
endfunction

function! DictEntry(a, b)
    return '\    ' . Quotify(a:a) . ': ' . a:b . ","
endfunction

function! DictGetter(dict, items)
    let store = []
    for item in a:items
        call add(store, get(a:dict, item, ''))
    endfor
    return len(store) == 1 ? store[0] : store
endfunction

function! DictLine(a, b)
    return Quotify(a:a) . ': ' . a:b 
endfunction

function! DictionaryExpand(line)
   let parts = split(a:line) 
   return Mapped(parts, function('DollarReplace'))
endfunction

function! DisplayName(name)
  echom "Hello!  My name is"
  echom a:name
endfunction

function! DittoAction(s)
    let indexes = 0
    if !HasVisual() 
        let indexes = GetLogicIndexes()
    else
        let indexes = GetFullVisualIndexes()
        if NoVisualSelection(indexes)
            let indexes = GetLogicIndexes()
        endif
    endif

    ec indexes
    return
    if Test(getline(indexes[0]), '^ *(if|else|elif|while)')
        call BlockDitto(indexes, tag, rest)
    else
        call LineDitto(a:s)
    endif 
endfunction

function! WPAddSnippetFromLine()
    let line = trim(CurrentLine())
    let q = Prompt('choose a key and replacements')
    let [a,b] = SplitOnce(q)
    let c = 0
    let reps = split(b, ' ')
    for rep in reps
        let c += 1
        let line = Replace(line, rep, '$' . c)
    endfor
    call SMAddSnippet(a, line, 'wpsnippets')
endfunction

function! WPAddSnippet(s)
    let [a,b] = SplitOnce(a:s)
    call SMAddSnippet(a, b, 'wpsnippets')
endfunction

function! SMAddSnippet(key, value, ref)
    let key = a:key
    let value = a:value
    let ref = a:ref
    let lang = GetLang()
    let payload = IsString(value) ? DoubleQuote(Sub(value, '''', '''''')) : Stringify(value)
    let s = 'let g:' . ref . '["' . lang . '"]["' . key . '"] = ' . payload
    ec s
    call AppendAndExecute(s)
endfunction

function! DefineSnippetFromWord()
    ec 'choose key @wordsnippet'
    let word = GetCurrentWord()
    let key = input('')
    if key == ''
        let key = ToAbrev(word)
    endif
    let isCallable = Test(CurrentLine(), word . '\(')
    let suffix = isCallable ? '()' : ''
    let value = word . suffix
    call SMAddSnippet(key, value, 'solsnippets')
    "call UpdateSnippets()
endfunction

function! DefineSnippetFromCurrentLine()
    ec 'choose snippetkey @currentline'
    let key = input('')
    call SMAddSnippet(key, trim(CurrentLine()), 'solsnippets')
endfunction

function! RemoveSnippets(...)
    let lang = a:0 >= 1 ? a:1 : GetLang()
    let lang = GetLang()
    let ref = get(g:mastersnippets, lang)

    for key in keys(ref)
        try
            exec "una " . key
        catch

            "ec 'removesnippets: error at ' . key
        endtry
    endfor
endfunction

function! UpdateSnippets(...)
    let lang = a:0 >= 1 ? a:1 : GetLang()

    let ref = get(g:mastersnippets, lang)
    if Not(ref)
        return 
    endif

    let cmd = ''
    for [a,b] in items(ref)
        if !Test(b, '\)$')
            let cmd = "iab " . a . " " . Sub(b, ' ', '<space>') . "<C-R>=Eatchar('\s')<CR>"
        elseif Test(b, '\=')
            let b .= "<CR>\<C-R>\=Eatchar('\\s')\<CR>"
            let cmd = "iab " . a . " " . b
        elseif !Test(b, '\=') && Test(b, '\)$')
            let b .= "<left>\<C-R>\=Eatchar('\\s')\<CR>"
            let cmd = "iab " . a . " " . b
        endif
        ec cmd
        exec cmd
    endfor
endfunction

function! AppendBlock2(items)
    let items = a:items
    call setline('.', items[0])
    if len(items) > 1
        call append('.', items[1:])
    endif
endfunction

function! WriteDitto()
    let upline = UpLine()
    let parts = split(CurrentLine())
    let items = ''
    if Test(upline, '<' . parts[0] . '>')
        let items = DittoCopy(upline, parts[1:], parts[0])
    else
        let items = DittoCopy(upline, parts)
    endif

    call AppendBlock2(items)
endfunction

function! DittoCopy(upline, parts, ...)
    let ref = a:0 >= 1 ? a:1 : ''
    let upline = a:upline
    let parts = a:parts
    let store = []
    let targetword = Exists(ref) ? ref : Match(upline, '\w\w+\ze \=|\w\w+\ze[''":]')
    for part in parts
        let part = CopyCapitalization(part, targetword)
        let s = Sub(upline, targetword, part)
        call add(store, s)
    endfor
    return store
endfunction

function! VDivify(div, attrs, text)
    let class = a:class
    let div = a:div
    let text = a:text
    let snippet = "<" . div . " class=\"" . class . "\"" . "" . '' . ">" . text . "<" . div . ">$c"
    return snippet
endfunction

function! Divify(div, class, text, ...)
    let cursor = a:0 >= 1 ? '' : '$c'
    let class = a:class
    let div = a:div
    let text = a:text
    let snippet = "<" . div . " class=\"" . class . "\"" . "" . '' . ">" . text . "</" . div . ">" . cursor
    return snippet
endfunction

function! DocNotes(mode)
    let line = getline('.')
    let commentValue = 'ask'
    if a:mode == 'date'
        let commentValue = 'docnotes: ' . GetDate()
    endif

    let text = CommentLine(commentValue) . ': '
    let replacement = CurrentSpaces() . text
    if empty(line)
        let replacement = GetSpaces(UpLine()) . text
    else
        execute 'normal! O'
    endif
    call setline('.', replacement)
endfunction

function! DocRun()
    let lang = GetLang()
    "let dict = {'vim': ':w !bash', 'js': ':! node %', 'py': ':! python3 %'}
    let dict = {'py': '<Esc>:w<CR>:!clear;python3 %<CR>','vim': 'gg<cr>'}
    let cmd  = 'normal! ' . dict[lang]
    echo cmd
    execute cmd
endfunction

function! DocTest()

    if Test(CurrentLine(), 'return|print|console')
        call OldDocTest(CurrentLine())
        return 
    endif

    let r = '^((function|class) \w+|    (static )=\w+\()'
    let line = SprawlLine2(r)
    let name = Match(line, '\w*\ze\(')
    let statement = ''

    if Test(line, 'class')
        let parent = Match('class \zs\w*')
        let statement = '(new ' . parent . '()).'

    elseif Test(line, 'function')
        let statement = name . '()'

    elseif Test(line, 'static')
        let parent = SprawlMatch('class \zs\w*')
        let statement = parent . '.' . name . '()'

    elseif Test(line, '^    \w+\(')
        let parent = SprawlMatch('class \zs\w*')
        let statement = '(new ' . parent . '()).' . name . '()'
    endif

    let statement = Logger(statement)
    call AppendBottom(statement)
    let length = len(Replace(statement, '\)+$', ''))
    call SetCursor('$', length + 1)

endfunction

function! DollarReplace(el)
    let s = a:el
    if Test(s, '^\d+$')
        return s
    elseif Test(s, '^\$')
        let s = s[1:]
    else
        return Quotify(s)
    endif
endfunction

function! DotSplit(s)
    return split(a:s, '\.')
endfunction

function! DoubleEmpty(index, ...)
    let direction = a:0 == 1 ? a:1 : 'up'
    if direction == 'up'
        let direction = -1
    elseif direction == 'down'
        let direction = 1
    endif
    return IsEmptyLine(getline(a:index)) && IsEmptyLine(getline(a:index + direction))
endfunction

function! Dreplace(s, dict, ...)
    let s = a:s
    let dict = a:dict

    if len(dict) < 1
        return s
    endif
    let ba = 0 >= 1 ? 1 : ''
    let bb = 0 >= 2 ? 2 : ''
    let regex = ba . Regex(dict) . bb
    "ec regex
    "ec dict
    let ArrParser = {s -> FindArrMatch(dict, s[0])}
    let Parser = IsObject(dict) ? {s -> get(dict, s[0])} : ArrParser
    return Sub(s, regex, Parser)
endfunction

function! FindArrMatch(dict, value)
    let dict = a:dict
    let value = a:value
    for item in dict
        if item[0] == value
            return item[1]
        endif
    endfor
endfunction

function! Asdkj()
    return Dreplace('foo', [['fo', 'boo'], ['cwd', 'zxcv']])
endfunction

function! EditDict(s)
    let dict = ReadJson('known.json')
    let newdict = CreateDictFromString(a:s)
    call extend(dict, newdict)
    call WriteJson('known.json', dict)
endfunction

function! EditFile(file)
    echo expand('%:e')
    echo @%                |" directory/name of file
    echo expand('%:t')     |" name of file ('tail')
    echo expand('%:p')     |" full path
    echo expand('%:ph')    |" directory containing file ('head')
    return
    execute 'edit ' . PathFix(a:file)
endfunction

function! EditManager(s)
    let [a,b] = SlashSplit(a:s)
    call ExecuteReplace(a, b)    
endfunction

function! Empty(s)
    return Not(Strip(a:s))
endfunction

function! EmptyNext(index, direction)
    let line = getline(a:index + a:direction)
    return Test(line, '^(endfunction|}|\]|$)')
endfunction

function! EndOfLine()
    let pos = '.'
    let p = getpos(pos)[2] == strlen(getline(pos))
    return p
endfunction

function! EndsWith(s, el)
    return a:s =~ a:el . '$'
endfunction

function! EnterBlock(...)

    let [spaces, line] = GetSpacesAndLine()
    let [tag, val] = ForceSplit(line)
    let dict = {
        \'^v': {s -> '<' . s . '/>'}
    \ }

    for [key, Value] in items(dict)
        if Test(tag, key)
            let product = Value(tag)
            call setline('.', spaces . product)
            return 
        endif
    endfor

    if EnterBlockWithSnippet() == 1
        ec 'snip'
        return
    elseif LogicManager() == 1
        ec 'sup'
        return
    elseif tag =~ '^v'
        let lines = readfile('template.vue')
        let cursorpos = GetCursorFromSnippet(copy(lines))
        for i in range(0, len(lines) - 1)
            let line = lines[i]
            if lines[i] =~ '%c'
                let lines[i] = Replace(line, '\%c', '')
                break
            endif
        endfor
        let lines[0] = Templater(lines[0], tag)
        call SnippetMaker(lines, '', 1, cursorpos)
    else
        let line = JSPY('variablePrefix') . line . ' = '
        if tag =~ 's$'
            call SnippetMaker(line . '[', ']')
        else
            call SnippetMaker(line . '{', '}')
        endif
    endif
    return

    let lang = GetLang()
    let spaces = CurrentSpaces()
    let firstword = FirstWord(line) 
    let lines = []
    let middle = '    '

    if Has(g:htmldict, firstword)
            let firstword = get(g:htmldict, firstword)
            let lines = [
             \   firstword . ' {',
             \    middle,
             \    '}'
            \]

    elseif firstword == 'try'
            let lines = JSPY('try')
    elseif firstword == 'ditto'
        let parts = split(line)[1:]
        let upline = Strip(UpLine())
        if Test(upline, '^[a-zA-Z]+$')
            call setline(Relative(-1), '')
            call add(parts, upline)
            for part in parts
                let s = Quotify(part) . ': ' . part . ','
                call add(lines, s)
            endfor
        elseif Test(upline, '= { *$')
            for part in parts
                let s = Quotify(part) . ': ' . part . ','
                call add(lines, s)
            endfor
        else
            lines = DittoCopy(parts, upline)
        endif

    elseif line =~ '\v^[ie]f(t|sw|ew|s|o|a|n)'
        ec line
        let end = ''
        let start = ''
        if line =~ '^[ie]fsw'
            let line = Replace(line, 'sw', 't', '')
            let start = '^'
        elseif line =~ '^[ie]few'
            let line = Replace(line, 'ew', 't', '')
            let end = '$'

        elseif line =~ '\v^[ie]f[soan]'
            let [key, rest] = SplitOnce(line)
            let [key, fnkey] = ForceSplit(key, 2)
            let [logic, suffix, fn] = JSPY(key, 'logicsuffix', fnkey)
            let [logicstart, logicend] = logic
            let keyword = Exists(rest) ? rest : GetPrecedingKeyWord(rest)
            let first = logicstart . StringFunc(fn, keyword) . logicend
            "let first  =  'hohohoo'
            let lines = [first, middle, suffix]
            call TextPlacement(lines)
            return
        endif

        let [key, rest] = SplitOnce(line)
        let regex = ''
        let keyword = ''
        if IsTwoWords(rest)
            let [regex, keyword] = split(rest)
        else
            let keyword = GetPrecedingKeyWord()
            let regex = CreateRegex(rest, start, end)
        endif
        let [logic, suffix, testfunc] = JSPY(key, 'suffix', 'testfunc')
        let [logicstart, logicend] = logic
        let first = logicstart . StringFunc(testfunc, regex, keyword) . logicend
        if suffix == 'endfunction'
            let suffix = 'end' . logicstart
        endif
        let lines = [first, middle, suffix]
        "cc

    elseif Test(line, ' |^(else)$')
        let first = ''
        let [p2, suffix] = JSPY('p2', 'suffix')
        if lang == 'js' && !Test(line, '^(else)$')
            let [jslogic, jsrest] = SplitOnce(line)
            let negation = ''
            let jslogic = Replace(jslogic, 'elif|ef', 'else if')

            if Test(jsrest[0:1], '1')
                let jsrest = Replace(jsrest, '1', '')
                let negation = '!'
            endif

            if IsSingleWord(jsrest)
                let keyword = GetPrecedingKeyWord(CurrentSpaces())
                if HasQuotes(jsrest)
                    let jsrest = StringFunc('test', keyword, jsrest)
                else
                    let jsrest = StringFunc(jsrest, keyword)
                endif
            elseif IsTwoWords(jsrest)
               let parts = split(jsrest) 
               if parts[0] == 'not'
                   let negation = '!'
                   let jsrest = parts[1]
                endif
            endif

            if !StartsWith(jsrest, '(')
                let jsrest = Parens(jsrest)
            endif
            let first = jslogic . ' ' . negation . jsrest . p2
        else
            let first = line . p2
        endif

        "comeback
        if suffix == 'endfunction'
            let suffix = 'end' . Match(line, '\w+')
        endif
        if wrap && BelowLineOccupied()
            call SetPos(1)
            let indexes = GetContiguousIndexesIBM('.')
            call setline('.', first)
            call GetSetLines(indexes, {s -> '    ' . s})
            call append(indexes[1], spaces . suffix)
            return
        else
            let lines = [first, middle, suffix]
        endif
    elseif line =~ '^(else)'
        let lines = [first, middle, suffix]
    elseif firstword =~ '\v(lines|data|obj|items|dict)$'
        let [da, db] = firstword =~ '\v(obj|data|dict)$' ? ['{', '}'] : ['[', ']']

        let const = JSPY('variablePrefix')
        let suffix = lang == 'vim' ? '\ ' . db : db
        let adjust = lang == 'vim' ? '\' : ''
        let lines = [const . line . ' = ' . da, adjust . middle, suffix]
    endif

    if IsString(lines)
        let lines = [lines, middle, suffix]
    endif
    if Not(lines)
        ec ' no lines'
        return
    endif
    
    call TextPlacement(lines)
endfunction

function! EnterBlockExpression()
    let start = CurrentLine() =~ " $" ? "" : " "
    let obj  = "{\<esc>o},\<esc>\<s-o>"
    let objcomma  = "{\<esc>o})\<esc>\<s-o>"
    let norm = "{\<esc>o}\<esc>\<s-o>"
    let arr = "[\<esc>o]\<esc>\<s-o>"
    let par = "{\<esc>o})\<esc>\<s-o>"
    let fn = "() => {\<esc>o})\<esc>\<s-o>"
    let lambdax = "=> {\<esc>o})\<esc>\<s-o>"
    let reds = "uce((acc, item) => {\<esc>o}, {})\<esc>\<s-o>"
    "let newp = "\<esc><left>xi Promise((resolve, reject) => {\<esc>o})\<esc>\<s-o>"
    "let smap = "\<esc><left>xi Promise((resolve, reject) => {\<esc>o})\<esc>\<s-o>"

    let s = ''
    let line = Strip(CurrentLine())

    if Test(line, 'red *$')
        let s = reds

    elseif Test(line, '(filter|map)$')
        let origin = Match(line, '\w+\ze\.(map|filter)')
        let start = ''
        let s = '(' . Parens(Slice(origin)) . ' ' . lambdax

    elseif Test(line, 's *$')
        let s = '=> ' . par 

    elseif Test(line, '\=\> *$')
        let s = par 

    elseif Test(line, '[,\(] *$')
        let s = fn 

    elseif Test(line, 'x *$')
        let s = lambdax 

    elseif Test(line, ', *$')
        let s = objcomma 

    elseif Test(line, '\) *$')
        let s = norm 

    elseif Test(line, ': *$')
        let s = obj
    elseif expand('%:e') == 'vue'
        let s = norm
    elseif Test(line, '^\w{-}s>')
        if !Test(line, '\=')
            let start .= '= '
        endif
        let s = arr
    else
        let s = norm
    endif
    return start . s
endfunction

function! EnterBlockWithSnippet()
    let [spaces, line] = GetSpacesAndLine()
    let [tag, val] = ForceSplit(line)
    let newdict = {
    \    'd': {
            \ 'fn': 'TemplateDitto', 
            \ 'args': ['line', 'upline'],
    \     },
    \}

    let innerdict = get(newdict, tag)
    if empty(innerdict)
        ec ' nope at snppetblock'
        return 0
    elseif Exists(innerdict)
            let args = []
            for arg in innerdict.args
                if arg == 'line'
                   call add(args, val) 
                elseif arg == 'upline'
                   call add(args, UpLine()) 
                elseif arg == 'spaces'
                   call add(args, spaces)
                endif
            endfor
            let Fn = ToFunction(innerdict.fn)
            let product = ''
            if len(args) == 0
                let product =  Fn()
            elseif len(args) == 1
                let product =  Fn(args[0])
            elseif len(args) == 2
                let product =  Fn(args[0], args[1])
            endif

            if Exists(product) && Exists(get(innerdict, 'setline'))
                call setline('.', spaces . product) 
            endif
        endif
        return 1
    endif
    return 0

endfunction

function! Enumerate(list)
    let list = IsArray(a:list) ? copy(a:list) : split(a:list, "\n")
    return map(list, {k,v -> [k,v]})
endfunction

function! Escape(str)
  return escape(a:str, '^$.*?/\[]()' . '"' . "'")
endfunction

function! EscapeForTerminalArg(text)
    let regex = '[\\ \(\)\{\}\[\]''"\=\>]'
    let replacement = '\\\0'
    let p = Replace(a:text, regex, replacement, 'g')
    return p
endfunction

function! EscapeSpaces(s)
    let s = Replace(a:s, ' ', '\\ ', 'g')
    let s = Replace(s, '\n', '\\\\n', 'g')
    return s
endfunction

function! EscapeTextForTerminal(s)
    let s = a:s
    let s = Sub(s, ' ', 'zzs')
    let s = Sub(s, '\n', "zzn")
    return s
endfunction

function! EverythingToSlashes(s)
    return Replace(a:s, '[- ]', '/', 'g')
endfunction

function! Exec(...)
    let cmd = "!" . join(a:000, ";")
    call execute cmd
endfunction

function! ExecRegex(s)
  " execute 'normal! /' . a:s . '\<cr>'
    return
endfunction

function! Execute(file, ...)
    let arg = a:0 >= 1 ? a:1 : ''
    let runtime = JSPY(a:file, 'runtime')
    let command = "normal! :!" . runtime . " " . a:file . " " . arg . "\<cr>"
    execute command
endfunction

function! ExecuteBash(...)
    let cmd = ":! " . join(a:000)
    ec cmd
    execute cmd
endfunction

function! ExecuteFile(...)
    let file = a:0 >= 1 ? a:1 : CurrentFile() 
    let file = file == 'self' ? CurrentFile() : file
    let arg = a:0 >= 2 ? a:2 : ''
    let runtime = JSPY(file, 'runtime')
    if Not(runtime)
        let runtime = 'python3'
    endif
    let command = "normal! :!" . runtime . " " . file . " " . arg . "\<cr>"
    ec command 
    execute command
endfunction

function! ExecuteNormal(s)
    execute "normal! " . a:s . "\<cr>"
endfunction

function! ExecuteReplaceOnce(a, b)
    let cmd =  "s/\\v" . Boundary(a:a) . "/" . a:b
    execute cmd
endfunction

function! ExecuteReplace(a, b, ...)
    let sensitive = a:0 >= 1 ? 1 : 0
    let flags = "/g"
    if sensitive
        let sensitive = '\C'
        "let flags .= 'I'
    else
        let sensitive = ''
    endif

    let cmd =  "%substitute/\\v" . Boundary(a:a) . sensitive . "/" . a:b . flags
    ec cmd
    execute cmd
endfunction

function! ExecuteSelf(file, args)
    let cmd = a:0 == 1 ? ' ' . Replace(a:1, '["'' ]', '\\' . '\0', 'g') : ''
    call Execute(a:file, FullFileName() . cmd)
endfunction

function! Exists(s)
    if IsArray(a:s)
        return len(a:s) > 0
    elseif IsObject(a:s)
        return len(a:s) > 0
    elseif IsString(a:s)
        return strlen(a:s) > 0
    elseif IsNumber(a:s)
        return a:s != 0
    endif
endfunction

function! ExpansionActions()
    let [spaces, line] = GetSpacesAndLine()
    "let line = 'let foo = { bye high}'
    "let line = 'options = {  foo bar bye  }'
    let items = [
    \     {
            \ 'regex': '\w+ \S+  .{-}\ze\)?$',
            \ 'mediator': {s -> Replace(s[0], '^\{ *| *\} *$', '', 'g')},
            \ 'replace': 'SuperObjectExpand', 
            \ 'pos': 1, 
    \     },
    \     {
            \ 'regex': '\= \zs\{.+', 
            \ 'mediator': {s -> Replace(s[0], '^\{ *| *\} *$', '', 'g')},
            \ 'replace': 'ObjectExpand', 
            \ 'pos': 1, 
    \     },
    \     {
            \ 'regex': '(\w{-}s \= )\zs.+',
            \ 'mediator': {s -> Replace(s[0], '^[\[\{]|[\]\}]$', '', 'g')},
            \ 'replace': 'ArrayExpand',
            \ 'pos': 1, 
    \     },
    \ ]

    "let line = 'let foo = abc def  a b)'
    for item in items
        if Test(line, item.regex)
            ec 'sup'

            if Exists(get(item, 'fn'))
                let line = function(item.fn)(line)

            elseif Exists(get(item, 'replace'))
              let Mediator = IsFunction(get(item, 'mediator')) ? item.mediator : {s -> s[0]} 
              let line = Replace(line, item.regex, {s -> function(item.replace)(Mediator(s))})
            endif
            "return ec line

            if Exists(line)
                call setline('.', spaces . line)
                if Exists(get(item, 'pos'))
                    if IsNumber(get(item, 'pos'))
                        call cursor(Relative(get(item, 'pos')), 1000)
                    else
                        execute "normal! " . get(item, 'pos')
                    endif
                endif
            endif
            return
        endif
    endfor

endfunction

function! ExportFunction()
    let name = GetFunctionName()
    let payload = 'module.exports.' . name . ' = ' . name
    let regex = '^const {\zs'
    call append('$', payload)
    call OpenBuffer('classroom.js')
    let line = FindLine(regex)
    ec line
    call GetSet(line, {s -> Replace(s, regex, name . ', ') })
endfunction

function! ExtensionFix(buffer)
    let lang = 'py'
    if a:buffer =~ '\v\.\w+$'
        return a:buffer
    else
        return a:buffer . '.' . lang
    endif
endfunction

function! F6ify(s)
    let name = GetFunctionName()
    let command = 'nnoremap <f7> :w<cr>:call ' . name . '(''' . a:s . ''')' . '<cr>'
    call AppendVim(command)
endfunction

function! FasdfileGetter(file)
  let dict = {
      \ 'q': 'questions.txt',
      \  'n': '/home/kdog3682/CWF/notes.txt',
      \  'r': 'r.py',
      \  't': 'today.py',
      \  'd': 'derived.py',
      \  's': 'storage.py',
      \  'sh': 'shortcuts.py',
      \  'h': 'helpers.py',
      \  'u': 'utils.py',
      \  'vim': '~/.vimrc',
      \  'vimrc': '~/.vimrc',
      \  'bash': '~/.bash_aliases',
  \ }
  let match = get(dict, a:file)
  return match
    let file = a:file
    if Not(file)
        if Not('b:buffer')
            let b:buffer = 'today.py'
        endif
        let file = b:buffer
    endif

    let dict = {
        \ "sc": 'shortcuts',
        \ "s": 'storage',
        \ "h": 'helpers',
    \ }

    let file = get(dict, file, file)
    if Not(HasExtension(file))
        let file += '.' . CurrentExtension()
    endif
    return PathFix(file)
endfunction

function! FileActionScript()
    
    let path = GetFullPath()
    let root = '/home/kdog3682/CWF/'
    let file = 'fileactionscript.py'
    let file = root . file
    ec file
    ec path
    call ExecuteFile(file, path)    
endfunction

function! FileFinder(pattern)
    let folderpath = '.'
    let cmd =  "grep --include=\*.{py} -rnw " . folderpath . " -e " . a:pattern
    ec cmd
    let raw = systemlist(cmd)
    ec raw
endfunction

function! FileFix(s)
    return '/home/kdog3682/CWF/' . a:s
endfunction


function! FileLang()
    return expand('%:e')
endfunction

function! FileOpener()
    edit aa.py
    edit bb.py
endfunction

function! FileString()
    let lineList = getline(1,'$')
    let fileString = join(lineList, "\n")
    return fileString
endfunction

function! FileTail()
    return expand('%:t')
endfunction

function! Filer2()
    let filetype = &filetype
    let full_file_path = @%
    let file  = expand('%:t')
    let extension = matchstr(file, '\(js\|py\)$')
    let line  = getline('.')
    let regex = '^ *\("\|//\|<!--\|#\)'
    let start = matchstr(line, regex)
    let dict = {'js': '// ', 'py': '#  |# '}
    if start == ''
        if file == '.vimrc'
            " echom file
            let replacement = '" '
        elseif file == 'utils.py'
            let replacement = '# '
        elseif file == 'utils.js'
            " echom file
            let replacement = '// '
        elseif file == 'vuecm2.html'
            " echom file
            let replacement = '<!-- '
        else
            let regex2 = '^ *\zs\(const\|foo\)'
            let start = matchstr(line, regex2)
            if start == ''
                let replacement = '# '
            else
                let replacement = '// '
            endif
        endif
        
        let regex = ' *\zs'
        let product = substitute(line, regex, replacement, '')
    else
        " echom 'removing comment'
        let replacement = ''
        let regex = '\(" \|// \|<!-- \|# \)'
        let product = substitute(line, regex, replacement, '')
    endif
    call setline('.', product)
    echom 'done'
endfunction

function! Filtered(items, ...)
    let query = a:0 >= 1 ? a:1 : 0
    let store = []
    if query
        call filter(a:items, {item -> Test(item, query)})
        return a:items
    endif
    for item in a:items
        if Exists(item)
            call add(store, item)
        endif
    endfor
    return store
endfunction

function! Filtered2(items, ...)
    let Parser = a:0 >= 1 ? a:1 : 'Exists'
    return filter(a:items, Parser . '(v:val)')
endfunction

function! FTest(item, Fn)
    let item = a:item
    let Fn = a:Fn
    if IsString(Fn)
        return Test(item, Fn)
    else
        return Fn(item)
    endif
endfunction

function! Find(items, query)
    for item in a:items
        if FTest(item, a:query)
            return item
        endif
    endfor
    return 0
endfunction

function! FindAndReplace(s)
    let regex = ":%s/\\v(\\.|\\w)@<!"
    call ExecuteNormal(regex . a:s)
    normal <c-o>
endfunction

function! FindBlockLine(...)
    let flags = a:0 >= 1 ? a:1 : ''
    let index = Search('^   *(if|elif|else|while|catch|def|function|\w+\()', flags)
    return index
endfunction

function! FindFile(extension)
    let glob = globpath('.', '*' . a:extension)
    ec glob
    return glob
    return split(glob, "\n")[0:n]
endfunction

function! FindFileString(s)
    return Match(a:s, '[_-a-zA-Z0-9]+\.(txt|json|py|html|css|js|log)')
endfunction

function! FindIndexes()
    let indent_pat = '^' . matchstr(getline('.'), '^\s*') . '\S'
    let si  = search('^\%('. indent_pat . '\)\@!','bnW') + 1
    let ei   = search('^\%('. indent_pat . '\)\@!', 'nW') - 1
    echom [si, ei]
endfunction

function! FindIndex(items, target)
    let items = a:items
    let counter = 0

    if IsRange(items)
        let counter += items[0]
        let items = GetLines(items)
    endif

    for item in items
        if Test(item, a:target)
            return counter
        endif
        let counter += 1
    endfor
    return -1
endfunction

function! SearchLines(items, regex)
    let regex = a:regex
    for item in a:items
        let match = Match(item, regex)
        if Exists(match)
            return match
        endif
    endfor
endfunction

function! FindItemFn(items, Fn)
    let Tester = FunctionGetter(a:Fn)
    for item in a:items
        if Tester(item)
            return item
        endif
    endfor
    return 0
endfunction

function! FindLineIndex(lines, regex)
    if IsNumber(a:lines)
    let index = a:lines
    let regex = a:regex
    let max = 500
    let c = 0
    while c < max
        let c += 1
        let line = getline(index)
        if Test(line, regex)
            return index
        endif

        if Test(line, '^[}]]')
            return -1
        endif
        let index += 1
    endwhile
    return -1
    endif

    let c = -1
    for line in a:lines
        let c += 1
        if Test(line, a:regex)
            return c
        endif
    endfor
    call ThrowError()
endfunction

function! FindItem(items, target)
    for item in a:items
        if Test(item, a:target)
            return item
        endif
    endfor
    return 0
endfunction

function! FindLibFunctions(regex)
    call LoadHelperLibrary()
    let lib = g:helperlib
    let keys = filter(keys(lib), "Test(v:val, a:regex . '\\c')")
    ec keys
    return
    call append('.', Flat(map(keys, 'ToLines(get(lib, v:val))')))
endfunction

function! FindLine(regex)
    return Search(a:regex)
endfunction

function! Findall3(s, r)
    let store = []
    call substitute(a:s, a:r, '\=add(store, submatch(0))', 'g')
    return filter(store, 'Exists(v:val)')
endfunction

function! Findall(r, s)
    let lines = IsArray(a:s) ? a:s : [a:s]
    let store = []
    for line in lines
        let match = Match(line, a:r)
        if Exists(match)
            call add(store, match)
        endif
    endfor
    return store
endfunction

function! Finder(r)
    let index = search(a:r, 'bn')
    return Match(getline(index), a:r)
endfunction

function! FirstWord(s)
    let match = Match(a:s, '^\w+')
    return match
endfunction

function! FiveSearch(key, ...)
    let mode = a:0 >= 1 ? a:1 : 'foo' 
    let start = ""
    if mode == '4'
        let start = '^ *'
    elseif mode == '5'
        let start = '^    *'
    elseif mode == '6'
        ec 'hiw'
        let query = '^    ' . a:key
        let query = Sub(query, '\(', '\\(')
        let regex = '^    *' . query
        let cmd = "normal! /\\v" . query . "\<cr>"
        ec cmd
        execute cmd
        return 
    endif

    let query = a:key
    let query = Sub(query, '\(', '\\(')
    let query = get(g:qdict, query, FuncRegex(query))
    let cmd = "normal! /\\v" . start . query . "\<cr>"
    ec cmd
    execute cmd
endfunction

function! FixTheLineViaTemplate(indexes, arg)
    call GetSetLines(a:indexes, {s -> Replace(a:arg, '\$1', trim(s))}, 0)
endfunction

function! Fixer()

    let indexes = GetCodeIndexes()
    let P = {line -> Replace(line, '    *\zs\w+\ze *:', '''\0''')}
    call GetSetLines(indexes, P)
    return

    let context = GetContext()

    let indexes = GetContiguousIndexesIBM()
    for i in Ranger(indexes)
        ec i
        let n = GetIndent(getline(i))
        ec n
    endfor
    return

    let lang = GetLang()
    if lang == 'vim' && context == 'dict'
        call GetSetLines(GetCodeIndexes(), {s -> Replace(s, '^(}|    )\zs', '\')})
    elseif lang == 'json'
        call Execute('replacer.py', CurrentFile() . ' jsonquotes')

    elseif lang == 'py'
        if context == 'dict' && Test(CurrentLine(), '^ +\w')
            let P = {line -> Replace(line, '    *\zs\w+\ze *:', '''\0''')}
            for index in Ranger(GetCodeIndexes())
                call GetSet(index, P)
            endfor
        elseif CursorAtLineStart() || CursorNearBottom()
            let index = Search('((function|def|class).*\)|else|while)$', 'b')
            if Exists(index)
                call GetSet(index, {line -> line . ':'})
            else
                ec ' no match'
            endif
        elseif context == 'class'
            call InjectSelf()
        else
            let index = SearchBackWards('(function|def|class) .{-}[)]$')
            call GetSet(index, {line -> line . ':'})
        endif
    endif
endfunction

function! Flat(list, ...)
  if IsString(a:list)
      return a:list
  endif
  let spacing = a:0 == 1 ? a:1 : 0
  let store = []
  for elem in a:list
    if IsArray(elem)
      call extend(store, elem)
    else
      call add(store, elem)
    endif
    if spacing
        call add(store, '')
    endif
    unlet elem
  endfor
  return store
endfunction

function! FnDocTest(...)
    let r = '^(def|function|class) \w+'
    let line = SprawlLine2(r)
    let name = Match(line, '\w*\ze\(')
    let statement = ''
    let variables = GetFunctionVariables(line)
    ec variables
    return 
    let s = ''
    let quotes = 0
    if index(variables, 's')
        s .= '""'
        let quotes = 1
    endif
    let statement = name . '()'
    let statement = Logger(statement)
    call AppendBottom(statement)
    let length = len(Replace(statement, '\)+$', ''))
    call SetCursor('$', length + 1 - quotes)
endfunction

function! Foo(...)
    echom a:000
endfunction

function! Whatisthis(s)
    let indexes = GetIndexesHelper('line')
    let destination = a:s
    "let destination = '/home/kdog3682/.vimrc'
    call DeleteBlock(indexes)
    call InvivoAppend(destination, GetLines(indexes))

endfunction

function! Force(a, n)
    if len(a:a) > a:n
        return [a:a[0], join(a:a[1:])]
    endif
            
    while len(a:a) < a:n
        call add(a:a, '')
    endwhile
    return a:a
endfunction

function! ForceSplit(s, ...)
    if a:s == ''
        return ['', '']
    endif
    let delimiter = a:0 >= 1 ? a:1 : ' '
    let fallback = a:0 >= 2 ? a:2 : ''
    if IsNumber(delimiter)
        let parts = [a:s[0:delimiter - 1], a:s[delimiter:]]
        ec parts
        return parts
    endif

    let parts = split(a:s, delimiter)
    if len(parts) == 2
        return parts
    elseif len(parts) == 1
        return [parts[0], fallback]
    else
        return [parts[0], join(parts[1:], delimiter)]
endfunction

function! FourSearch(...)

    let extra = ''
    let query = a:0 >= 1 ? a:1 : 'foursearch' 
    let query = Sub(query, '\(', '\\(')
    let query = get(g:qdict, query, FuncRegex(query))
    let query = Sub(query, '\=', '\\=')
    let start = "^ *"

    ec query
    let cmd = "normal! /\\v" . start . query . extra . "\<cr>"
    execute cmd
endfunction

function! Freplace(s, dict)
    let s = a:s
    for [k,v] in items(a:dict)
        let s = Sub(s, k, {x -> function('Templater')(v, x)})
    endfor
    return s
endfunction

function! FullFileName()
    let p = expand('%')
    echom 'current file: ' . p
    return p
endfunction

function! FuncRegex(s)
    let regex = '(const|def|class|async function|function) \$?' . a:s 
    return regex
endfunction

function! RpwHelper(...)
    let name = GetFunctionName()
    let file = a:0 >= 1 ? a:1 : 'foo'
    "let s = 'const rpw' . lower(name) . ' = ' . rpw
    "let s = 'rpwdebug("' . a:file . '", ' . name . ')'
    let s = 'console.log($0(read("$1")))'
    let s = Templater(s, [name, file])
    ec s
    call AppendBottom(s)
endfunction

function! FunctionAutoTest()
    let flineIndex = SprawlIndex('^' . JSPY('function'))
    let commentIndex = flineIndex + 1
    let fline = getline(flineIndex)
    let name = GetFunctionName(fline)
    let line = matchstr(getline(commentIndex), '["/#] \zs.*')
    " echom fline
    " echom line
    let params = ''
    if Exists(line)
        let params = split(line, '  ')
    else
        let params = 0
    endif
    if Exists(name) && Exists(params)
        let expression = CreateFunctionCall(name, params)
        let lastline = getline('$')
        if Exists(matchstr(lastline, '^print\|^console\|^echom'))
            echom 'replacing'
            call setline('$', expression)
        else
            echom 'appending'
            call append('$', expression)
        endif

        call setpos(flineIndex, 0)
        normal ma

    else
        echom name
        echom params
        echom 'doesnt exist'
    endif
    return
endfunction

function! NoParams(line)
    return Test(a:line, '\(\)')
endfunction

function! IsJson(s)
    return GetExtension(a:s) == 'json'
endfunction

function! IsJs()
    return GetExtension() == 'js'
endfunction

function! FunctionCaller()
    if Test(Tail(), '\d')
        return JSA()
    endif
    "if Tail() == 'app2.js'
        "return RunPythonOrNode(1)
    "endif

    if IsJsPy()
        return RunPythonOrNode()
    endif
    if IsJs()
        ec 'is js'
        let name = Match(Basename(CurrentFile()), '[a-zA-Z0-9-]+') . '.html'
        call Python('storage.py', 'foo', 'openfile', name)
        return 
    endif

    let line = CurrentLine()
    let name = GetFunctionName()

    if NoParams(GetFunctionLine()) == 1
        ec ' noparams'
        call ExecuteFunctionCall(name)
    else
        call ExecuteFunctionCall(name, g:defaultfunctioncallstring)
        return 
        "let args = input('write the args: ')
        let args = 0

        if Test(args, '  ')
            let [a,b] = split(args, '  ')
            call ExecuteFunctionCall(name, a, b)
            return 
        endif

        if args == 'null'
            call ExecuteFunctionCall(name)
            return 
        endif

        if Not(args)
            let args = Sub(CurrentLine(), "'", '"')
            call ExecuteFunctionCall(name, args)
            return 
        endif

        call ExecuteFunctionCall(name, args)
    endif
endfunction

function! ExecuteFunctionCall(name, ...)
    let name = a:name
    let args = a:0 >= 1 ? a:1 : ''
    if Exists(args)
        let args = split(trim(args), '  ')
        let args = map(args, 'SingleQuote(v:val)')
        let args = join(args, ', ')
    endif

    let command = ':ec ' . name . Parens(args)
    ec command
    execute command
endfunction

function! CoerceError(x)
    if Not(a:x)
        throw 'stopping execution @ coerceError'
    endif
endfunction

function! ThrowError(...)
    ec a:000
    throw 'stopping execution'
endfunction

function! Stop(...)
    let args = a:0 >= 1 ? a:1 : 0
    if Exists(args)
        ec args
    endif
    throw 'stopping execution'
endfunction

function! FunctionController(s)
    let command = a:s
    if command == 'rcl'
        call RemoveConsoleLog()

    elseif command == 'tc'
        let match = matchstr(CurrentLine(), '\S.*$')
        echom match
        let spaces = '    '
        call setline('.', [spaces . 'try {', spaces . spaces . match, spaces . '} catch(e) {', spaces . spaces . 'throw new MyError(e)', spaces . '}'])

    else
        echom 'adfasdfasdfa'
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

function! FunctionManager(x)
    if Getlang() == 'vimrc'
        call VimrcFunctionManager(a:x)
        return
    endif
    let items = split(a:x)
    let key = items[0]
    let args = items[1:]
    call call(function(Capitalize(key)), args)
endfunction

function! FunctionRange()
    let r = GetCodeIndexes()
    return range(r[0], r[1], 1)
endfunction

function! FunctionRunner()
    let file = CurrentFile()
    let dict = {
        \ ".vimrc": 'vimmer.py',
        \ "reddit": 'REDDIT.PY',
        \ "wooo": 'REDDIT.PY',
    \ }
    if has_key(dict, file)
        let item = get(dict, file)
        let command = ':! python3 ' . item
        echom command
        execute command
    else
        echom 'no command'
    endif

endfunction

function! FunctionRunner2()
    let file = expand('%:t')
    let extension = matchstr(file, '\(js\|py\)$')
    if empty(extension)
        let extension = 'js'
    endif
    echo extension
    " let dict = {
        'js': 'node',
        'py': 'python3',
    system(dict[extension] . '%')
endfunction

function! FunctionRunner3(name)
    let lang = GetExtension(name)
    echom lang

    execute 'normal! :! python3 asd.py\<cr>' " Doesnt Work
endfunction

function! Functionize(indexes, arg)
    call GetSetLines(a:indexes, {s -> '    ' . s})
    call append(a:indexes[1], '}')
    call append(a:indexes[0] - 1, 'function ' . a:arg . '() {')
endfunction

function! FunctionizeBlock(indexes, s)
    let first = NameMaker(a:s)
    let last = JSPY('suffix')
    call IndentAll(a:indexes)
    call append(a:indexes[0] - 1, first)
    call append(a:indexes[1] + 1, last)
endfunction

function! FuzzyFileFinder(query)
    let files = Globpath(a:query)
    return Input(files)
endfunction

function! GasdfhsdetVisualIndexes()
    " echom getpos("'<")
    " echom getpos("'>")
    let startIndex = getpos("'<")[1]
    let endIndex = getpos("'>")[1]
    return [startIndex, endIndex]
endfunction

function! GetBuffer()
    let buffermap = {
        \ 't': 'today.py',
        \ 'iit': 'today.py',
        \ 'tii': 'today.py',
    \ }
    let fallback = 'today'
    let buffer = exists('b:buffer') ? get(buffermap, b:buffer) : fallback
    if Not(buffer)
        let buffer = fallback
    endif
    let buffer = ExtensionFix(buffer)
    return buffer
endfunction

function! GetCSIndexes()
    let [a,b] = GetFullVisualIndexes()
    if a == 0 && b == 0
        let [a,b] = GetContiguousIndexesIBM()
    return [a,b]
endfunction

function! Zt1()
    let line = CurrentLine()
    call Append(trim(line))

endfunction

function! IsCursorStartOfLine(...)
    let n = a:0 >= 1 ? a:1 : 1
    "cwd

    let line = trim(CurrentLine())
    let n = 5
    return len(line) <= 2
    return len(line) <= n
    "cwd

    return len(trim(line))
    let ch = GetCursor()
    let line = line[ch:]
    return len(trim(line)) == 0
    return line
    return len(trim(line)) == n
    return ch
endfunction

function! IsStartOfLine()
    return getpos('.')[2] < 2
    return len(trim(CurrentLine())) == 0
endfunction

function! GetChar()
    return getpos('.')[2]
endfunction

function! GetClosestName()
    let true = 1
    let r = \w+\ze(\(| =)'
    let upindex = line('.') - 1
    let downindex = line('.') + 1
    let count = 0
    while true
        let upmatch = Match(getline(upindex), r)
        if Exists(upmatch)
            return upmatch
        endif

        let downmatch = Match(getline(downindex), r)
        if Exists(downmatch)
            return downmatch
        endif
        let upindex -= 1
        let downindex += 1
        let count += 1
        if count == 20
            break
        endif
    endwhile
endfunction


function! GetCommentDelimiter()
    let lang = GetLang()
    echom lang
    let dict = {'0': '// ', 'html': '', 'css': '', 'vim': '" ', 'js': '// ', 'py': '# '}
    return dict[lang]
endfunction

function! GetContext()
    let r = '^(function|def|class)|\= \{ *$'
    let match = MatchSearch(r, 'b')
    if match =~ '\v\='
        let match = 'dict'
    endif
    return match
endfunction

function! GetContiguousIndexes(...)
    let normalize = a:0 >= 1 ? 1 : 0
    let a = '^ *$'
    let b = '^ *$'
    let current = line('.')
    let up = search(a, 'bn') + 1
    let down = search(b, 'n') - 1
    if normalize
        if current - up > 10
            echo 'normalizing up'
            let up = current - 3
        endif
        if down - current > 10
            echo 'normalizing down'
            let down = current + 3
        endif
    endif
    if down < up
        let down = line('$')
    endif
    return [up, down]
endfunction

function! GetContiguousSpacesIndexes(...)
    let indent_pat = '^' . matchstr(getline('.'), '^\s*') . '\S'
    let firstline  = search('^\%('. indent_pat . '\)\@!','bnW') + 1
    let lastline   = search('^\%('. indent_pat . '\)\@!', 'nW') - 1
    if lastline < 0
        let lastline = line('$')
    endif
    return [firstline, lastline]

    let firstboundary = a:0 >= 1 ? a:1 : 0
    let indent_pat = '^' . matchstr(getline('.'), '^\s*') . '\S'
    let firstline  = line(firstboundary)
    if firstboundary
        let firstline  = search('^\%('. indent_pat . '\)\@!','bnW') + 1
    endif
    let lastline   = search('^\%('. indent_pat . '\)\@!', 'nW') - 1
    if lastline < 0
        let lastline = line('$')
    endif
    return [firstline, lastline]
endfunction

function! GetContiguousIndexesIBM(...)

    let indent_pat = '^' . matchstr(getline('.'), '^\s*') . '\S'
    let firstline  = search('^\%('. indent_pat . '\)\@!','bnW') + 1
    let lastline   = search('^\%('. indent_pat . '\)\@!', 'nW') - 1
    if lastline < 0
        let lastline = line('$')
    endif
    return [firstline, lastline]
    " INSERTION

    let firstboundary = a:0 >= 1 ? a:1 : 0
    let indent_pat = '^' . matchstr(getline('.'), '^\s*') . '\S'
    let firstline  = line(firstboundary)
    if firstboundary
        let firstline  = search('^\%('. indent_pat . '\)\@!','bnW') + 1
    endif
    let lastline   = search('^\%('. indent_pat . '\)\@!', 'nW') - 1
    if lastline < 0
        let lastline = line('$')
    endif
    return [firstline, lastline]
endfunction

function! GetCounterPart(match)
    let dict = {
    \    '[': ']',
    \    ']': '[',
    \    '}': '{',
    \    '{': '}',
    \    '(': ')',
    \    ')': '(',
    \    '"': '"',
    \    '''': '''',
    \ }

    let dict = {
    \    ']': ' |\(',
    \    ')': '\(',
    \    '"': '"',
    \    '''': '''',
    \ }
    return get(dict, a:match)
endfunction

function! CloseDotBuffers()
    let buffers = GetVisibleBuffers()
    let buffers = filter(buffers, "Test(Basename(bufname(v:val)), '^\\.')")
    call Iterate(buffers, 'CloseBuffer')

endfunction

function! GetCurrentBuffers()
    return map(GetVisibleBuffers(), 'bufname(v:val)')
endfunction

function! GetCurrentDir()
    let p = expand('%:h')
    return p
    
endfunction

function! GetCursorFromSnippet(snippet)
    let lines = IsArray(a:snippet) ? a:snippet : split(a:snippet, "\n")
    for [i, line] in Enumerate(lines)
        if line =~ '%c'
            let ch = match(line, '%c')
            return [Relative(i), ch]
        endif
    endfor
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

function! GetDate()
    let date = strftime('%m-%d-%Y %I:%M:%S%p')
    return date
endfunction

function! GetDestinationFromText(indexes)
    let text = join(GetLines(a:indexes), "\n")
    if Test(text, '^\*')
        return '/home/kdog3682/CWF/notes.txt'
    else if Test(text, 'function')
        return 'newhelpers.js2'
    else
        return 'd.txt'
    endif
endfunction

function! GetDictIndexes()
    let up = search('\v^    \w.{-}\{ *$', 'bn')
    let down = search('\v^    \}$', 'n')
    return [up, down]
endfunction


function! GetFile()
    return expand('%:t')
endfunction

function! GetFileFromCache(f)
  let match = get(g:filedict, a:f)
  return match
endfunction

function! GetFileStringsFromText(x)
    let s = StringGetter(a:x)
    let m = Findall(s, g:fileStringRE)
    return m
endfunction

function! ListDir(...)
    let dir = a:0 >= 1 ? DirGetter(a:1) . '*' : '*'
    return glob(dir, 0, 1)
endfunction

function! Todolist()
    let regex = '^todo\.' 
    let file = FindItem(ListDir(), regex)
    call OpenBuffer(file)
endfunction

function! GetFiles(...)
    let query = a:0 >= 1 ? a:1 : '*'
    let n = a:0 >= 2 ? a:2 : 30
    let glob = globpath('.', query)
    return split(glob, "\n")[0:n]
endfunction

function! GetFirstElement(s)
    return Match(a:s, '\S+')
endfunction

function! GetFirstWord(s)
    return Match(a:s, '\w+')
endfunction

function! GetFullPath()
    return expand('%:p')
endfunction

function! GetFullVisualIndexes(...)
    ec a:000
    let flag = a:0 >= 1 ? a:1 : 'null'
    ec flag
    let a = getpos("'<")
    let b = getpos("'>")
    if flag == 'keep' 
        return [a[1], b[1]]
    endif

    if a[1] == b[1] && a[2] == b[2]
        if flag == 'block'
            return GetSmartBlockIndexes()
        endif
        return [0,0]
    endif

    return [a[1], b[1]]
endfunction

function! GetFunction()
   let lines = GetLines(GetCodeIndexes())
   return lines
endfunction

function! GetVarIndex(...)
    "let r = '(function|def|class|const)'
    let r = '[\{\[]$'
    let index = SearchUp(r)
    let p = index
    "echom p
    return p
endfunction

function! SprawlUp(r, ...)
    let flags = a:0 >= 1 ? a:1 : 'bnWc'
    let r = a:r
    let index = search(r, flags)
    return index < 1 ? line('$') : index
endfunction


function! GetCodeName(...)
    let line = a:0 == 1 ? a:1 : GetFunctionLine()
    return Match(line, g:fnRE2)
endfunction

function! GetFunctionParam(line)
    return Match(a:line, '^(function|def|class) \w+\(\zs\w*')
endfunction


function! GetBindingName(...)
    let line = a:0 == 1 ? a:1 : GetFunctionLine()
    return Match(line, g:fnRE2)
endfunction

function! GetFunctionName(...)
    let line = a:0 == 1 ? a:1 : GetFunctionLine()
    return Match(line, g:fnRE2)
endfunction

function! GetFunctionParameters(line)
    let s = matchstr(a:line, '^ *\(def\|class\|function\) \w*(\zs.*\ze)')
    let p = split(s, ', ')
    return p
endfunction



function! GetFunctionLine()
    return getline(GetFunctionIndex())
endfunction

function! GetFunctionVariables(s)
    let regex = '[\w.]+\ze *[=,)]'
    let matches = MatchStrAll(regex, a:s)
    return matches
endfunction

function! GetFunctionsAndPrependToCurrentFile(s)
    call LoadHelperLibrary()
    let keys = SpaceSplit(a:s)
    let items = GetLibItems(keys, g:helperlib)
    let lines = Flat(items, 1)
    call append('.', lines)
endfunction

function! GetImplicitVueData()
    let line = getline('.')
    let match = Match(line, '\w+\ze \=')
    let p = match . ': ' . 'null'
    echom p
    if Not(p)
        ec 'no result'
        return ''
    endif
    return p
endfunction

function! GetIndent(...)
    let s = a:0 >= 1 ? a:1 : CurrentLine()
    let s = LineGetter(s)
    return match(s, '\S')
endfunction

function! GetIndexes(...)
    let name = a:0 == 1 ? a:1 : ''
    let adjust = GetLang() == 'py' ? 1 : 0
    let a = search('^\v(function|def|class|const) ' . name . '|\w+ \= \{ *$')
    let b = search('^\v(endfunction|\}|\]|def|class|function|\w+)') - adjust
    if adjust && Test(getline(b), '}|\]')
        let b += 1
    endif
    if b < a
        let b = line('$')
    endif
    return [a,b]
endfunction

function! GetIndexes2(...)
    let key = a:0 >= 1 ? a:1 : 'starting-block'
    let a = '^\S'
    let b = '^\S'
    let topOffset = 0
    let bottomOffset = 0

    if key == 'starting-code-block'
        return 
    elseif key == 'contiguous-block'
        return 
    endif

    let up = search(a, 'bn') + topOffset
    let down = search(b, 'n') + bottomOffset
    let p = [up, down]
    echom p
    return p
endfunction

function! ParserAddQuotes(s, ...)
    let force = a:0 >= 1 ? a:1 : 0
    if HasExtension(a:s) || force != 0
        return SingleQuote(a:s)
    else
        return a:s
    endif
endfunction

function! SearchJS(s, r)
    let g:store = []
    call substitute(a:s, Regexed(a:r), function('ReplaceMatcher'), '')
    return g:store
endfunction

function! Ijsplit(a, b)
    let dict = {
        \'foo': 'bar',
    \}
    let items = split(a:b, ' ')
    let first = items[0]
    let second = ''
    ec items
    if len(items) == 1
        let second = ', ' . "' '"
    elseif len(items) > 1
        let second = ', ' . items[1]
    endif
    let key = a:a
    let name = get(dict, key, 'items')
    return 'const ' . name . ' = ' . key . Parens(first . second)
endfunction

function! Ijsawr(a, b)
    return a:a . Parens(join(map(split(a:b, ' '), "ParserAddQuotes(v:val)"), ', '))
endfunction

function! Ijsarrobj(s, rest)
    let comma = Test(a:s, ',')
    let items = Split(a:s, ',? ') 

    if len(items) == 1
        return 'const ' . items[0] . a:rest
    endif

    if comma == 1
        return 'const [' . join(items, ', ') . ']' . a:rest
    else
        return 'const {' . join(items, ', ') . '}' . a:rest 
    endif
endfunction

function! Ijsco(key, value)
    return Dictify('a b c')
endfunction

function! ZInvivoFixJS(s)
    let start = '^'
    for [regex,b] in g:invivojs
        let args = SearchJS(a:s, start . regex)
        if Exists(args)
            let ref = has_key(g:invivoconnector, args[0]) ? 'Ijs' . get(g:invivoconnector, args[0]) : b
            return ArgFunc(ref, args)
        endiftrue
    endfor
endfunction

function! PyWriteHelper(s)
    let items = split(a:s, ' ')
    return join(map(items, "ParserAddQuotes(v:val)"), ', ')
endfunction

function! ZStringPipe(s)
    let items = split(a:s, ' ')
    let functions = ['write', 'append', 'read', 'search', 'findall']
    if Includes(items[0], functions)
        return 'const match = ' . items[0] . Parens(join(map(items[1:], "ParserAddQuotes(v:val)"), ', '))
    endif
    if items[0] == 'write' || items[0] == 'append'
        return items[0] . Parens(join(map(items[1:], "ParserAddQuotes(v:val)"), ', '))
    elseif items[0] == 'c'
        let [a,b] = SplitOnce(s, '=')
    endif

    let c = 0
    let output = ''

    for item in items
        let item = get(g:snippetaliasdict, item, item)

        let c += 1

        if c == len(items)
            let output .= SingleQuote(item)
            let output .= Repeat(')', len(items) - 1)
        else
            let output .= item . '('
        endif
    endfor
    return output
endfunction

function! Throw()
    throw 'Throwing Error'
endfunction

function! GetLineStartIndex(...)
    let flags = a:0 >= 1 ? a:1 : 'bnWc'
    let r = '^\v\S'
    let index = search(r, flags)
    return index < 0 ? Throw() : index
endfunction

function! GetIndexesFromCurrentLineToBottom()
    let a = GetLineStartIndex()
    let b = line('$')
    let p = [a, b]
    return p
endfunction

function! GetIndexesHelper(indexmode, ...)

   let [indexes, flag] = GetVisualIndexes('flag')
   if empty(flag)
       return indexes
   endif
    
   let Fn = (len(a:indexmode > 3) && IsCapitalized(a:indexmode)) ? FunctionGetter(a:indexmode) : FunctionGetter(get(g:indexesdict, a:indexmode))

   if !empty(Fn)
       return Fn()
   endif

   let smarthelper = a:0 >= 1 ? a:1 : 0

   if a:indexmode == 'html'
       return GetHtmlIndexes()

   elseif a:indexmode == 'all'
       return [0, line('$')]

   elseif a:indexmode == 'spacing'
       return GetSpacingIndexes()

   elseif a:indexmode == 'matchingspaces'
       return GetMatchingSpacesIndexes()

   elseif a:indexmode == 'matching'
       return GetMatchingIndexes()

   elseif a:indexmode == 'anyblock'
       return GetAnyFunctionBlockIndexes()
   elseif a:indexmode == 'code'
       return GetCodeIndexes()
   elseif a:indexmode == 'functionblock'
       return GetFunctionOrInnerFunctionIndexes()
   elseif a:indexmode == 'smart'
       return GetSmarterIndexes()

   elseif a:indexmode == 'smartobject'
       return GetSmartObjectIndexes(smarthelper)
   elseif a:indexmode == 'trycatchindex'
       return GetTryCatchIndexes()
   elseif a:indexmode == ''
       return GetCodeIndexes()
   elseif a:indexmode == 'nolinebreak'
       return GetNolinebreakIndexes()

   elseif a:indexmode == 'smartcontiguous'
       return GetSmartContiguousIndexes()

   elseif a:indexmode == 'contiguous'
       return GetContiguousIndexesIBM()
   elseif a:indexmode == 'smart'
       return GetSmartIndexes()
   elseif a:indexmode == 'line'
       return line('.')
   else
       return GetFullVisualIndexes(a:indexmode)
endfunction

function! GetInternalBlockIndexes()
    let up = search('\v \= [\[\{]$', 'bn')
    let spaces = GetSpaces(getline(up))
    let down = search('\v^' . spaces . '[\}\]]', 'n')
    return [up, down]
endfunction

function! GetLang(...)
    let file = a:0 == 1 ? a:1 : expand('%:t')
    let match =  Match(file, '(css|m?html|vue|js2|js|json|py|vim|vimrc|bash|bashrc|bash_aliases|sh|txt)$')
    let dict = {
    \    'vue': 'js',
    \    'js2': 'js',
    \    'json': 'js',
    \    'mhtml': 'js',
    \    'vim': 'vim',
    \    'vimrc': 'vim',
    \    'html': 'js',
    "\    'html': 'html',
    \    'txt': 'txt',
    \    'py': 'py',
    \    'sh': 'bash',
    \    'bash_aliases': 'bash',
    \    'bashrc': 'bash',
    \ }
    let value = get(dict, match, match)
    return value
    "return Assert(value)
endfunction

function! GetLastBuffer()
    let p = expand('#')
    echom p
    return p
endfunction

function! GetLastWriteFile(f)
    let f = 0
    if exists('g:lastwritefile') && Not(a:f)
        let f = g:lastwritefile
    endif
    return f
endfunction

function! GetFunctions(s, keys)
    let s = a:s
    let keys = a:keys
    "let s = "\nfunction foo() {\n   asdfssadf\n}\n\nfunction zoo() {\n sdfsdf\n}"
    "let keys = ['foo', 'zoo']
    let r = '\n((async )?function!{-}|def|class) ' . Ncg(keys) . '.{-}\n\}'
    let m = FindallStrings(s, r)
    return m
endfunction

function! GetLibItems(keys, lib)
    return map(a:keys, 'ToLines(get(a:lib, v:val))')
endfunction

function! GetLine(...)
    let n = a:0 >= 1 ? Relative(a:0) : '.'
    return getline(n)
endfunction

function! GetLineOrName()
    let line = CurrentLine()
    if Test(line, '^( |function|def|class|endfunction)')
        return Parens(GetFunctionName(), 'braces')
    else
        return line
    endif
    return
    if Test(line, '^(\w* )?\w+ \=')
        return [line, 'variable']

    elseif Test(line, '^( |function|def|class|endfunction)')
        return [GetFunctionName(), 'name']

    elseif Test(line, '^\w')
        return [line, 'prose']

    else
        ec 'sup'
        return [line, 'symbol']
    endif
endfunction

function! GetLogicIndexes()
    let up = search('\v^ *(if|else|elif|while)', 'bnc')
    let down = search('\v^ *(end|\})', 'nc')
    return [up, down]
endfunction

function! GetNameSpot(s)
    return match(a:s, Regexed('^(function|def|class) \zs\w+')) + 1
endfunction

function! GetNearByVariable()
  let s = GetVisibleLines()
  call inputsave()
  let name = input('Variable Name: ')
  call inputrestore()
  let match = Match(s, '(function|def|class) \zs' . name . '.{-}\ze(\=|\()')
  ec match
endfunction

function! GetNoLineBreakIndexes()
    let up = search('\v^ *$', 'bnW')
    let down = search('\v^ *$', 'nW')
    let up += 1
    if down < 1
        let down = line('$')
    else
        let down-= 0
    endif
    return [up, down]
endfunction


function! GetOptionalSpacesVariableDeclaration(s)
    return matchstr(a:s, '^ *\(let|const\) \w+ =')
endfunction

function! GetLineNumber()
    return getpos('.')[1]
endfunction

function! GetPos(...)
    let pos = a:0 == 1 ? a:1 : '.'
    try
        return getpos(pos)[1:-1]
    endtry
    return 0
endfunction

function! GetPrecedingKeyWord(...)
    let spaces = a:0 >= 1 ? '^' . a:1 : ''
    let fallback = a:0 >= 2 ? a:2 : 's'
    let index = GetFunctionIndex()
    let r = '' . '(let ){-}' . '\zs\w+\ze \='
    let r = '\w+\ze \='
    let index = search(Regexed(r), 'bn', Relative(-10))
    let match = ''

    if Exists(index)
        let match = Match(getline(index), r)
    endif

    if Exists(match)
        return match
    endif

    let param = GetFunctionParam(getline(index))
    if Not(param)
        if Exists(Strip(fallback))
            ec ' returning fallback'
            return fallback
        else
            ec ' really no match'
            return 's'
        endif
    endif
    return param
endfunction

function! GetExtension(...)
"getExtension()
    let e = a:0 >= 1 ? Match(a:1, '\.\zs\w+$') : Match(expand('%:t'), '\.\zs\w+$')
endfunction

function! GetPrefix()
   if Test(GetExtension(), '^js')
       return 'const ' 
   else
       return ''
   endif
endfunction

function! GetQuotable(s)
    return Match(a:s, g:quoteRE)
endfunction

function! GetRange()
    call ExecuteRegex('/^function')
    echom 's'
endfunction

function! GetScreenIndexes()
    return [line('w0'), line('w$')]
endfunction

function! GetSetFile(file, fn)
    let lines = readfile(a:file)
    let product = a:fn(lines)
    call writefile(product, a:file, 'w')
endfunction

function! GetSetLines(indexes, fn, ...)
    let spaces = a:0 >= 1 ? a:1 : GetSpaces(getline(a:indexes[0]))

    if IsNumber(a:indexes) || (IsString(a:indexes) && a:indexes == '.')
            let index = a:indexes
            let line = getline(index)
            let spaces = GetSpaces(line)
            let product = FunctionGetter(a:fn)(Strip(line))
            if empty(product)
                let product = line
            else
                let product = spaces . product
            endif
            call setline(index, product)
            return 
    endif

    for index in range(a:indexes[0], a:indexes[1])
        let line = Strip(getline(index))
        let product = a:fn(line)
        let product = spaces . product
        call setline(index, product)
    endfor
endfunction

function! GS4(indexes, fn)
    let Fn = FunctionGetter(a:fn)
    for index in range(a:indexes[0], a:indexes[1])
        let [spaces, line] = GetSpacesAndLine(index)
        let value = Fn(line)
        if Exists(value)
            call setline(index, spaces . value)
        endif
    endfor
endfunction

function! GS3(indexes, Fn, ...)
    let Condition = a:0 >= 1 ? a:1 : {s -> 1}
    for index in range(a:indexes[0], a:indexes[1])
        let line = getline(index)
        if Condition(line) == 1
            call setline(index, a:Fn(line))
        endif
    endfor
endfunction

function! GetShortName(name)
    function ShortNameHelper(x)
        return a:x[1]
    endfunction
    return Replace(a:name, '(\u)[a-z]*\C', function('ShortNameHelper'), 'g')
endfunction

function! GetSmartBlockIndexes()
    return GetContiguousIndexesIBM()
    let start = line('.')
    let currentspaces = CurrentSpaces()
    let upindex = start
    let downindex = start + 1

    if GreaterSpaces(upindex)
        let index = SpaceSearch(currentspaces, 'b')
    endif
endfunction

function! GetHtmlIndexes()
    let upindex = line('.')
    let curline = CurrentLine()
    let spaces = GetSpaces(curline)
    let tag = Match(curline, '<\zs\w+')
    call CoerceError(tag)

    let pattern = '^' . spaces . '\<\/' . tag
    let downindex = search('\v' . pattern, 'nW')
    if downindex <= 0
        call ThrowError('downindex < 0')
    endif
    let p = [upindex, downindex]
    return p
endfunction

function! GetSmartContiguousIndexes()
    let foo = {
        \'arr': 'bar',
    \}
    let upindex = SprawlIndex('[\(\[\{] *$')
    let spaces = GetSpaces(getline(upindex))
    let indent_pat = '^' . matchstr(getline(upindex), '^\s*') . '\S'
    call SetAbsPos(upindex)
    let downindex = search('\v^' . spaces . '\S', 'nW')
    if downindex < 0
        let downindex = line('$')
    endif
    return [upindex, downindex]
endfunction

function! GetSmartIndexes()
    let true = 1
    let upindex = line('.') - 1
    let downindex = line('.') + 1
    let count = 0
    let previndent = GetIndent(getline('.'))
    while true
        let indent = GetIndent(getline(upindex))
        if indent != previndent
            let upindex += 1
            break
        else
            let upindex -= 1
            let previndent = indent
        endif
    endwhile

    let previndent = GetIndent(getline('.'))
    while true
        let indent = GetIndent(getline(downindex))
        if indent > 0 and indent < previndent
            let upindex -= 1
            break
        else
            let upindex += 1
            let previndent = indent
        endif
    endwhile

    return [upindex, downindex]
endfunction

function! GetSmartIndexesWithHelp(...)
    let query = a:0 >= 1 ? a:1 : 'smart'
    let up = search(Regexed("\<" . query), 'b')
    let down = search(Regexed("\<" . query), '')
    ec up
    ec down
    "smart
endfunction

function! GetSmartObjectIndexes()
    let foo = {
        \'bar': 'star',
    \}
    let upindex = search('\v[\{\[] *$', 'bnc')
    let spaces = GetSpaces(getline(upindex))
    let downindex = search('\v^' . spaces . '[\}\]]', 'n')
    return [upindex, downindex]
endfunction

function! GetSpaces(...)
    let line = a:0 >= 1 ? (IsNumber(a:1) ? getline(a:1) : a:1) : CurrentLine()
    return matchstr(line, '^ *')
endfunction

function! GetSpacesAndLine(...)
    let line = a:0 >= 1 ? (IsNumber(a:1) ? getline(a:1) : a:1) : CurrentLine()
    let spaces = GetSpaces(line)
    return [spaces, Strip(line)]
endfunction

function! GetSpacesTagLineInReverse()
    let [spaces, line] = GetSpacesAndLine()
    let parts = split(line, ' ')
    let line = join(parts[0:-2], ' ')
    let tag = parts[-1]
    let p = [spaces, tag, line]
    return p
endfunction

function! GetSpacesTagLineAndParts(...)
    let s = a:0 >= 1 ? a:1 : CurrentLine()
    let [spaces, line] = GetSpacesAndLine(s)
    let [tag, line] = SplitOnce(line)
    let parts = []
    if Exists(line)
        let parts = split(line)
    endif
    return [spaces, tag, line, parts]
endfunction

function! GetText(...)
    let indexes = a:0 >= 1 ? a:1 : [0, '$']
    return join(GetLines(indexes), "\n")
endfunction

function! GetTryCatchIndexes()
    let spaces = strlen(CurrentSpaces())
    let a = spaces - 4
    let b = 0
    let c = 1
    let d = spaces - 4
    let up = search('\v' . '^' . RegexSpaces(a,b) . '\S', 'bn') + 1
    let down = search('\v' . '^' . RegexSpaces(c,d) . '\S', '') - 1
    return [up, down]

endfunction

function! GetVariable()
    return 's'
endfunction

function! GetVariableDeclaration(s)
    return matchstr(a:s, '\v^ *(\w\{1,\}) =') 
endfunction

function! GetVisibleBuffers()
  let buffers = filter(range(1, bufnr('$')), 'buflisted(v:val)')
  return buffers
endfunction

function! GetVisibleLines()
    let a = line("w0")
    let b = line("w$")
    return join(getline(a, b), "\n")

endfunction

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

function! GetVisualIndexes2(...)
    let flag = a:0 >= 1 ? 1 : 0
    let a = getpos("'<")
    let b = getpos("'>")
    if empty(flag)
        if a[1] == b[1]
            return GetContiguousIndexesIBM()
        endif
        let payload = [a[1], b[1]]
        return payload
    else
       let flag = a[1] == b[1] && a[2] == b[2]
       return [[a[1], b[1]], flag]
    endif
endfunction

function! GetVisualSelectionText()
    let indexes = GetVisualIndexes2()
    let lines = Dedent(GetLines(indexes))
    let s = join(lines, "\n")
    return s
endfunction

function! GetWord(s, ...)
    let index = a:0 >= 1 ? a:1 : 0
    let parts = split(trim(a:s))
    return parts[index]
endfunction

function! GlobIt(...)
   let query = a:0 >= 1 ? a:1 : 'aops'
   let filestring = globpath('.', '*' . query . '*') 
   ec Numbered(filestring)
   let files = split(filestring, "\n")
   call ToPasteBuffer(Quotify(files[0]))
   return files
endfunction

function! GlobalReplace(words)
   let pairs = CreatePairs(split(a:words))
   for pair in pairs
       let [a,b] = pair
       execute "%substitute/\\v<" . a . ">/" . b . "/g"
   endfor
   return

endfunction

function! GoBackwards()
    let index = search('\v\}\)?,? *$', 'b', Relative(-3))

    if index == 0
        ec getpos('.')
        if EndOfLine()
            return 
        else
            call cursor(Relative(0), 1000)
        endif
        return
    endif
    let spaces = CurrentSpaces() . '    '
    let newindex = Relative(-1)
    let line = getline(newindex)
    if strlen(Strip(line)) == 0
       call setline(newindex, spaces)
        call cursor(newindex, 1000)
    else
       call append(newindex, spaces)
        call cursor(index, 1000)
    endif
endfunction

function! GoBottom()
  let end = LineChooser('$', 18030)
  call append(end, ['', ''])
  call SetCursor(end + 1)
endfunction

function! GoForwards()
    let index = search('\v\}\)?,? *$', '', Relative(3))
    if index == 0
        ec getpos('.')
        if EndOfLine()
            return 
        else
            call cursor(Relative(0), 1000)
        endif
        return
    endif
    let spaces = CurrentSpaces()
    let newindex = Relative(1)
    let line = getline(index + 1)

    if strlen(Strip(line)) == 0
        call setline(newindex, spaces)
        call cursor(newindex, 1000)
    else
       call append(index, spaces)
       call cursor(newindex, 1000)
    endif
endfunction

function! GoHtmlBackward()
   let lineindex = line('.')
   let line = CurrentLine()
   let index = match(line, '""')
   "ec line[28]
   "ec line[29]
   "ec index
   call cursor(lineindex, index + 2)
endfunction

function! GoHtmlForward()
   let lineindex = line('.')
   let line = CurrentLine()
   let index = match(line, '>')
   call cursor(lineindex, index + 2)
endfunction

function! GoNext()
    call SetCursor(5 + search(Regexed(g:fnRE)))
endfunction

function! GoToChatExample()
    call OpenBuffersFromFolder('chat-example')    
endfunction

function! GoToLocation()
    let index = Search('constructor')
    call SetCursor(index)
endfunction

function! GoToNearbyFile()
    let file = FindFileString(GetVisibleLines())
    call OpenBufferFile(file)
    
endfunction

function! GoTop(...)
  let indexOffset = a:0 >= 1 ? a:1 : 0
  call SetCursor(g:gotopline)
  let index = GetFunctionIndex()
  call append(index - 1, ['', ''])
  call SetCursor(index + indexOffset)
endfunction

function! GoAbove(...)
  let indexOffset = a:0 >= 1 ? a:1 : 0
  let index = GetFunctionIndex()
  call append(index - 1, ['', ''])
  call SetCursor(index + indexOffset)
endfunction

function! GoUp()
    call SetCursor(GetFunctionIndex())
endfunction

function! Goto(...)
    let arg = a:0 >= 1 ? a:1 : ''
    let dict = {
    \    'storage.py': 'if __name__',
    \    '.vimrc': 'indexsearch',
    \    'maths2.py': '#init',
    \    'math3.py': '#init',
    \    'helpers.js': {
        \
        \
        \
    \ }
    \}
    let match = get(dict, Basename(CurrentFile()))
    call ThrowGetter(match)
    if IsString(match) 
        let index = IndexSearch(match)
        ec index
    elseif IsObject(match)
        ec 'setting bookmarks'
        call SetBookMarks(match)
    endif

endfunction

function! Grab(s)
    if a:s[0] == '/'
        call GrabLocal(a:s[1:])
        return 
    endif

    let keys = split(a:s)
    let items = []
    let lang = GetLang()
    if lang == 'py'
        if !exists('g:pylib')
            let g:pylib = ReadJson('combine.py.lib')
        endif
        let items = GetLibItems(keys, g:pylib)

    elseif lang == 'js'
        if !exists('g:fnlib') || !Exists(g:fnlib)
            let g:fnlib = ReadJson('/home/kdog3682/CWF/javascript.lib')
            ec 'js library loaded'
        endif
        let items = GetLibItems(keys, g:fnlib)
    endif

    if Exists(items)
        let lines = SpaceWrap(Flat(items, 1))
        call append('.', lines)
    else
        ec 'items dont exist'
        ec keys
    endif
endfunction

function! GrabFileContents(file)
    let path = '/home/kdog3682/CWF/' . a:file

endfunction

function! GrabLocal(s)
    return 
endfunction

function! GrabTextFromFile()
    let lines = readfile('grab.txt')
    call ToPasteBuffer(lines)
endfunction

function! Grabold(s)
    let [s, file] = ForceSplit(a:s, g:grabbuffer)
    let file = PathFix(file)
    let a = '\v^(class|function|def)' . ' ' . a:s . '>'
    let b = '\v^(class|end|function|def|}|\])'

    let lines = readfile(file)
    let lines = SearchBetween(lines, a,b)
    if Exists(lines)
        call AppendFile(Self(), lines)
    else
        ec s . ' doesnt exist in file ' . file
    endif

endfunction

function! Grabsecond(s, ...)
    let preview = a:0 == 1 ? a:1 : 0 
    let keys = split(a:s)
    let items = GetLibItems(keys)
    let lines = Flat(items, 1)
    if Exists(preview)
        ec join(lines, "\n")
    else
        call AppendSelf(lines, 'cursor')
    endif
endfunction

function! GrepFinder(s)
    let [extension, query] = SplitOnce(a:s)
    let cmd = "grep " . "'" . query . "' " . "*." . extension
    ec cmd
    ec 'hiii'
    let raw = systemlist(cmd)
    ec raw
    let files = Mapped(raw, {s -> Match(s, '\S*\ze:')})
    ec files
    return 
    if open
        call OpenBufferGroup(files)
    endif
endfunction

function! GrepTextFinder(s)
    let query = a:s
    let cmd = "grep --include=\*.{txt} -rilw -e '" . query . "'"
    let raw = systemlist(cmd)
    ec raw
    let files = Mapped(raw, {s -> Match(s, '\S*\ze:')})
    ec files
    return 
endfunction

function! Has(s, el)
    if IsObject(a:s)
       return has_key(a:s, a:el)
    endif

    if IsArray(a:s)
       return index(a:s, a:el) > -1
    endif
    return a:s =~ Regexed(a:el)
endfunction

function! HasComment(s)
    return Test(a:s, g:commentre)
endfunction

function! HasExtension(file)
    return Test(a:file, '\.\w+$')
endfunction

function! HasQuotes(s)
    return Test(a:s, '^[''"]')
endfunction

function! HasVisual()
    let line = line('.')
    let a = getpos("'<")[1]
    let b = getpos("'>")[1]
    return line >= a && line <= b
endfunction

function! Help()
    let items = keys(g:ldrdict)
    ec Joined(items)
    ec ''
    ec 'listing keys for helepr dict'
endfunction

function! HerokuGit()
    let prefix = "git -C /home/kdog3682/CWF/chat-example "
    let commands = ["add .", "commit -m 'go'", "push heroku master"]
    let commands = Map(commands, {k -> prefix . k})
    call Exec(commands)
endfunction

function! HtmlComment(x)
    return '<!-- ' . x . '-->' 
endfunction

function! HtmlFix()
    let [spaces, line] = GetSpacesAndLine()
    let parts = SplitOnce(line, ' ')
    
    let attrs = ''
    let eltags = ['title']
    let snippet = ''

    if line == 'input'
        let snippet = '<input class="input" v-model="input"/>$c'
        return SnippetPlacer(snippet, spaces)
    endif

    if line =~ '^\.'
        let snippet = Divify('div', Slice(line, 1), '{{' . Slice(line, 1) . '}}')
        return SnippetPlacer(snippet, spaces)
    endif

    if index(eltags, parts[0]) >= 0
        let div = 'div'
        let snippet = "<" . div . " class=\"" . parts[0] . "\"" . "" . '' . ">" . parts[1] . "<" . div . ">$c"
        return SnippetPlacer(snippet, spaces)
    endif
    ec 'adsfasdf'

    let parts = SplitOnce(line, '\.')
    let div = parts[0]
    let el = Replace(parts[1], '\\', '', 'g')

    if  div =~ '^b'
        let div = 'button'
        let el = 'abc'
        let attrs = "@click=\"" . parts[1] . "\""
        ec parts[1]
        let snippet = "<" . div . " class=\"" . el . "\"" . " " . attrs . ">$c</" . div . ">"
    else
        let snippet = "<" . div . " class=\"" . el . "\"" . attrs . ">\n    $c\n</" . div . ">"
    endif

    call SnippetPlacer(snippet, spaces)

endfunction

function! HtmlHandler()

    let spaces = CurrentSpaces()
    let word = CurrentWord()
    ec word

    let predict = {
        \ 's': '<br style="margin-top:10px"/>',
        \ 'spacer': '<br style="margin-top:10px"/>',
    \ }
    let match = get(predict, word)
    if Exists(match)
        call setline('.', spaces . match)
        call cursor('.', 100)
        return
    endif

    let worddict = {
    \    'd': 'div',
    \    'b': 'button',
    \ }
    let word = get(worddict, word, word)
    let attrdict = {
    \    'button': '@click=""',
    \ }
    let s = ToOpeningTag(word, get(attrdict, word)) . ToClosingTag(word)
    call setline('.', spaces . s)
    call cursor('.', strlen(spaces) + strlen(word) + 2)
endfunction

function! HuntForReplacement()
    let word = CurrentWord()
    if IsSymbol(word)
        call MoveCursorToNextBlock()
        return
    endif

    let regex = '<' . '[' . word[0] . toupper(word[0]) . ']' 
    if strlen(word) > 1
        let chars = SplitChars(word[1:])
        for char in chars
            let regex .= '[a-z]{-}' . toupper(char)
        endfor
    endif
    let regex .= '\w+\(?\C'
    ec regex

    let replacement = MatchSearch(regex, 'bnW', -20)
    if empty(replacement)
        let replacement = MatchSearch(regex, 'nW', 10)
    endif
    if empty(replacement)
        return
    endif

    let replacement = ConditionalAdd(replacement, ')', '\($')

    call ReplaceLine('.', word, replacement)
    call cursor('.', RelativeChar(-1))
endfunction

function! HuntForReplacement2()
    let word = CurrentWord()
    ec word
    if Exists(get(g:snippetdict, word))
        return get(g:snippetdict, word)
    endif

    let regex = '<' . '[' . word[0] . toupper(word[0]) . ']' 
    if strlen(word) > 1
        let chars = SplitChars(word[1:])
        for char in chars
            let regex .= '[a-z]{-}' . toupper(char)
        endfor
    endif
    let regex .= '\w+\(?\C'

    let replacement = MatchSearch(regex, 'bnW', -20)
    if Not(replacement)
        let replacement = MatchSearch(regex, 'nW', 10)
    endif
    if Not(replacement)
        return ' '
    endif

    return replacement
    let replacement = ConditionalAdd(replacement, ')', '\($')
    return replacement

endfunction

function! AddEatItem(a, b)
   let s = a:a . ' ' . a:b
   let match = Match(a:b, '\(\).*$')
   let length = len(match) - 1
   let left = Repeat('<LEFT>', length)
   let cmd = Join("iab", "<silent>", s . left . "<C-R>=Eatchar('\\s')<CR>")
   ec cmd
   call AppendVim(cmd)
   execute cmd
endfunction

function! HasSpace(s)
    let s = a:s
    return Test(s, ' ')
endfunction

function! IabEat(...)
  let s =''
  let start = a:0 >= 1 ? a:1 : ''
    if start ==''
   let name = GetCurrentWord()
   let abrev = ToAbrev(name)
   let s = abrev . ' '.name
   return s
   else
       let s = HasSpace(start) ? start : start . ' ' . trim(CurrentLine())
       endif

   let match = Match(s, '\(\).*$')
   let length = len(match) - 1
   let left = Repeat('<LEFT>', length)
   let cmd = Join("inoreab", "<silent>", s . left . "<C-R>=Eatchar('\\s')<CR>")
   ec cmd
   call AppendVim(cmd)
   execute cmd
endfunction

function! AddIabItem()
   let [s, word, before, after] = GetCurrentWordIndexes()
   ec [word, before, after]
   let value = input('   ')
   let payload = word . ' ' . value
   call setline('.', before . value . after)
   call AddDictItem('iab ' . payload)
   let cmd = Join("iab", payload . "<C-R>=Eatchar('\\s')<CR>")
   execute cmd
endfunction

function! AddSnippet(key, value)
   let payload = a:key . ' ' . a:value
   let cmd = Join("iab", payload . "<C-R>=Eatchar('\\s')<CR>")
   execute cmd
   call AddDictItem('iab ' . payload)
endfunction

function! WordUnderCursorToSnippet()
   let word = CurrentWord()
   let name = input('::choose snippet name :: ')
   let suffix = '()<LEFT>'
   let cmd = Join("iab", name . ' ' . word . suffix . "<C-R>=Eatchar('\\s')<CR>")
   execute cmd
   call AppendVim(cmd)

endfunction

function! Identity(s)
    return a:s
endfunction

function! IfController()
    let spaces = CurrentSpaces()
    let ending = EndsWith(CurrentLine(), ' ')
    " echom strlen(spaces)
    " echom ending
    " echom 'match::'
    " echom match 
    let list = ['if']
    for regex in list
        let match  = LineSearch(regex, 'startingLookAheadSpaces = true')
        if match
            echom match
endfunction

function! IncrementFileNumber(s)
    let p = Replace(a:s, '\d+', {x -> x[0] + 1})
    if p == a:s
        let p = a:s . '1'
    endif
    return p
endfunction

function! SplitMap(s, Parser, ...)
    let delimiter = a:0 >= 1 ? a:1 : "\n"
    return join(map(split(a:s, delimiter), a:Parser), delimiter)
endfunction

function! Indent(x, ...)
    let indentation = a:0 >= 1 ? ToSpaces(a:1) : '    '

    if IsString(a:x)
        return SplitMap(a:x, {i, s -> indentation . s})
    elseif IsArray(a:x)
        return map(a:x, {i, s -> indentation . s})
    endif
endfunction

function! IndentAll(x, ...)
    let spaces = a:0 >= 1 ? a:1 : 0

    let Parser = 0
    if Exists(spaces)
        let regex = '^' . ' ' . RegexNumber(0, spaces)
        let Parser = {s -> Replace(s, regex, spaces)}
    else
        let Parser = {s -> '    ' . s}
    endif

    if IsIndex(a:x)
        call GS4(a:x, Parser)
    else
        return map(a:x, 'Parser(v:val)')
    endif
endfunction

function! IndentLine(s)
    return '    ' . a:s
endfunction

function! IndexSearch(regex, ...)
    let flags = a:0 >= 1 ? a:1 : '' 
    return search(Regexed(a:regex), flags)
endfunction

function! InferUrlFromLocation()
    
endfunction

function! InferUrlFromString(s)
   let match = get(g:urldict, a:s)
   if match
       return match
   endif
   let Fn = g:urldict.sof
   return Fn(a:s)
endfunction

function! InjectSelf()
    let indexes = GetCodeIndexes()
    let condition = 'def \w+\(\zs' . Nla('self')
    let FnExtra = {l -> Test(l, '\(\)') ? '' : ', '}
    let Parser = {line -> Replace(line, condition, 'self' . FnExtra(line))}
    call LineRun(indexes, condition, Parser)
endfunction

function! InsertBelowCurrent(s)
    let index = line('.')
    call append(index, a:s)
endfunction

function! InsertFixer()
    function ParserA(x)
        let s = a:x[0]
        let items = split(s, '\v(, ?| )')
        let output = ''
        for item in items
            let output .= DictLine(item, item) . ', '
        endfor
        return output[:-3]
    endfunction
    call ReplaceLine('.', '\{\zs\w+.{-}\ze\}', function('ParserA'))
endfunction

function! InstallNpm(s)
    let cmd = 'npm i ' . a:s
    execute "!" . cmd
    call AppendFile('npm.installations.txt', a:s)
    "call WriteNote(cmd)
endfunction

function! InternalShunt()
    let indexes = GetInternalBlockIndexes()
    ec indexes
    let lines = DedentLines(GetLines(indexes))
    call DeleteLines(indexes)
    call append('^', lines)
endfunction

function! InvivoAppend(destination, lines)
    "call BufLoad(a:destination)
    call add(a:lines, '')
    call appendbufline(a:destination, '$', a:lines)
endfunction

function! InvivoInsert(destination, lines)
    call BufLoad(a:destination)
    "ec 'Appending to: ' . a:destination
    call appendbufline(a:destination, '$', a:lines)
endfunction

function! InvivoPrepend(destination, lines)
    "ec 'Appending to: ' . a:destination
    call BufLoad(a:destination)
    call insert(a:lines, '')
    call appendbufline(a:destination, '^', a:lines)
endfunction

function! IsArray(x)
    return type(a:x) == 3
endfunction

function! IsCapitalized(s)
    return Test(a:s, '^[A-Z]\C')
endfunction

function! IsComment(s)
    return Test(a:s, '^ *(linebreak|console|tl|echom?|ec |"|#|p+rint|//)')
endfunction

function! IsEmptyFile(file)
    return len(readfile(a:file)) < 2
endfunction

function! IsEmptyLine(line)
    return a:line !~ '[^\s]'
endfunction

function! IsEnterBlock(line)
    return Test(a:line, '^ *(function|def|class|if|while|else|do)')
endfunction

function! IsEven(x)
    return a:x % 2 == 0
endfunction

function! IsFile(file)
   return filereadable(a:file)
endfunction

function! IsFunction(x)
    return type(a:x) == 2
endfunction

function! IsHtml()
    return GetLang() == 'html'
endfunction

function! IsIndex(x)
    return IsNumber(a:x[0])
endfunction

function! IsIndexes(lines)
    return len(a:lines) == 2 && IsNumber(a:lines[0]) && IsNumber(a:lines[1])
endfunction

function! IsLastLine()
    return line('$') == line('.')
endfunction

function! IsNumber(x)
    return type(a:x) == 0 || Test(a:x, '^\d+$')
endfunction

function! IsObject(x)
    return type(a:x) == 4
endfunction

function! IsObjectBlock()
    return Test(CurrentLine(), ':$')
endfunction

function! IsOdd(count)
   return a:count % 2 == 1     
endfunction

function! IsPy()
    return GetLang() == 'py'
endfunction

function! IsSingleWord(s)
    return Test(a:s, '^[a-zA-Z]+$')
endfunction

function! IsSplitWindow()
    return len(getwininfo()) > 1
endfunction

function! IsString(x)
    return type(a:x) == 1
endfunction

function! IsStringNumber(s)
    return Test(a:s, '^\d+$')
endfunction

function! IsSymbol(word)
    return Test(a:word, '^\W')
endfunction

function! IsTwoWords(jsrest)
    return Test(a:jsrest, '^\S+ \S+')
endfunction

function! Iterate(list, fn)
    let store = []
    for item in a:list
        if a:fn == 'execute'
            execute item
        else
            let value = FunctionGetter(a:fn)(item)
            call add(store, value)
        endif
    endfor
    return store
endfunction

function! IterativeSearch(s, dict, ...)
    let fallback = a:0 == 1 ? a:1 : 0 
    for [key, value] in items(a:dict)
        if Test(a:s, key)
            return value
        endif
    endfor
    return fallback
endfunction

function! Jspy(...)
    let lang = GetLang()
    let lang = 'js'
    let keys = a:000
    let dict = g:jspydict[lang]
    let value = DictGetter(dict, keys)
    return value
endfunction

function! JSPY(...)
    let lang = ''
    let keys = ''

    if Test(a:1, '^(js|js2|py)$|\.\w+$')
        let lang = GetLang(a:1)
        let keys = a:000[1:]
        if lang == 'js2'
            let lang == 'js'
        endif
    else
        let lang = GetLang()
        let keys = a:000
    endif
    let dict = get(g:jspydict, lang, g:jspydict['js'])
    let value = DictGetter(dict, keys)
    return value
endfunction

function! Join(...)
    let s = ''
    for item in a:000
        if IsArray(item)
            for el in item
                let s .= ' '
            endfor
            let s = trim(s)
        else
            let s .= item . ' '
        endif
    endfor
    return trim(s)
endfunction

function! Joined(...)
    let x = a:0 == 1 ? a:1 : a:000
    let delimiter = "\n"
    if x[-1] == ' '
        let delimiter = ' '
        let x = x[0:-2]
    endif
    return join(x, delimiter)
endfunction

function! SaveFile(...)
    let file = a:0 >= 1 ? a:1 : CurrentFile()
    execute "w " . file
endfunction

function! JSA(...)
    let extra = join(a:000, ' ')
    let file = CurrentFile()
    let g:jsafile = '/home/kdog3682/CWF/public/current.js'
    let g:jsafile = '/home/kdog3682/CWD/helpers.js'
    call SaveFile(file)
    call Node(g:jsafile, file, extra)
endfunction

function! JsAnywhere()
    let file = CurrentFile()
    call Node(g:jsanywherefile, file, 'jsanywhere')
endfunction

function! JsonDictEntry(a, b)
    return '  ' . Quotify(a:a, 'dq') . ': ' . Quotify(a:b, 'dq') . ","
endfunction

function! JsonGetter(file, key)
    data = ReadJson(FuzzyFileFinder(a:file))
endfunction

function! JumpToNextBlock()
    let index = FindBlockLine()    
    ec index
    let indent = GetIndent(getline(index))
    let below = getline(index + 1)
    if Empty(below)
        call setline(index + 1, ToSpaces(indent + 4))
    endif
    call cursor(index + 1, indent + 4)
endfunction

function! KeyFramer(s)
    let [name, rest] = SplitOnce(trim(a:s))
    let trait = Sub(name, '\d+', '')
    let parts = split(rest, '  ')
    let s = '@keyframes ' . name . " {\n"
    for part in parts
        let [offset, value] = SplitOnce(part)
        let spaces = ToSpaces(4 - strlen(offset))
        let s .= '    ' . offset . "% " . spaces . "{" . " " . trait . ': ' . value . " }\n"
    endfor
    let s .= '}'
    return s

endfunction

function! LastWord(s)
    return Match(a:s, '\w+\ze *$')
endfunction

function! LastWordManager()
        
    let [spaces, line] = GetSpacesAndLine()
    let lastword = CurrentWord()
    let sline = trim(line[0: -1 * (strlen(lastword) + 1)])

    let snippet = get(g:lastworddict, lastword)
    let regex = '\$(\{.{-}\}|\d+)'
    let Parser89 = {x -> function('PySnippetTemplater')(x, ['foo'], sline)}

    let snippet = Sub(snippet, regex, Parser89)
    let cursorpos = GetCursorFromStringSnippet(snippet)
    let snippet = Replace(snippet, '\$c', '')
    call TextPlacement(SplitLines(snippet), spaces)
    call SetCursor(cursorpos, spaces)
endfunction

function! Latest(s)
    ec globpath('.', '*' . a:s)
endfunction

function! LeaderF(s)
    call WriteFunctionNotes(a:s)
endfunction

function! OldLeaderF(s)
    let dict = {
       \ 'rc': 'ReplaceContiguous',
       \ 'lf': 'LeaderF',
       \ 'vh': 'vuehelpermap',
    \ }
    if Exists(get(dict, a:s))
        let name = get(dict, a:s)
        let prefix = "\\(function\\|class\\|def\\|const\\|async function!{-}\\)"
        let prefix = 'function'
        let prefix = "(function|class|def|const|async function)"
        "let extra = Multiply("\<down>", 6)
        "let extra = ''
        let cmd = "/^\\v" . prefix . " " . name . "\<cr>"
        ec cmd
        execute "normal! " . cmd
        return 
    elseif a:s =~ '^//'
        let word = WordUnderCursor()
        execute "%s/\\v<" . a:s[2:] . ">/" . word . "/g"
    elseif a:s =~ '^/'
        call ReplaceWordUnderCursor(a:s[1:])
    elseif a:s =~ '/\w$'
        let [name, options] = split(a:s, '/')
        call Cfun(name, options)
    elseif a:s =~ '/'
        call FindAndReplace(a:s)
    else
        call Cfun(a:s)
    endif
endfunction

function! GoToDir(s)
    let [dir, file] = SplitOnce(a:s, '[/ ]')
    execute "edit " . "/home/kdog3682/CWF/" . dir . "/" . file
endfunction

function! LeaderManager100(s)
   let g:lcs='ldr'
   let g:lastCommand = a:s
   let [key, arg] = SplitOnce(trim(a:s))
   let Fn = FunctionGetter(get(g:ldrdict, key))
   if Exists(arg)
       call Fn(arg)
   else
       call Fn()
   endif
endfunction

function! LeaderManager(s)
    let g:lcs='ldr'
   if a:s == 'ask'
       call CloseBuffer('questions.txt')
   endif

   let g:lastkey = a:s
   let g:lastCommand = a:s
   let [key, arg] = SplitOnce(trim(a:s))
   ec [key, arg]

   if has_key(g:ldrdict, key)
       let Ref = g:ldrdict[key]
       if IsObject(Ref)
          let fn = get(Ref, 'fn')
          let args = get(Ref, 'args')
          call FunctionGetter(fn)(args[0])
       elseif IsString(Ref)
            if Test(Ref, '^ldr')
                let [first, second] = SplitOnce(Ref)
                call LeaderManager(Ref)
                return 

            elseif Test(Ref, '^\@Node')
                let [first, second] = SplitOnce(Ref)
                let second = Replace(second, '\$cf', CurrentFile())
                call NodeConnector(second . ' ' . arg)

            elseif Test(Ref, '^\@Py')
                let [first, second] = SplitOnce(Ref)
                let second = Replace(second, '\$cf', CurrentFile())
                call PythonConnector(second . ' ' . arg)
            elseif Ref == 'ecp'
                call PythonConnector(a:s)
            elseif Ref == 'ecj'
                call EditConnector(a:s)
            else
                ec 'h'
                return 
                if arg == ''
                    try
                        call function(Ref)()
                    catch
                        ec v:exception
                        ec 'we have an error at the function'
                        return 
                        call function(Ref)('')
                    endtry
                else
                    call function(Ref)(arg)
                endif
            endif
       elseif Exists(arg)
           call Ref(arg)
       else
           call Ref()
       endif

   elseif IsCapitalized(key)
       try
           call ExecuteFunctionCall(key, arg)
       catch
           ec 'error rat leadermanager is capitalizeed fcaling function'
       endtry

   else
       let key = a:s[0]
       let s   = a:s[1:]
       if has_key(g:backupleaderdict, key)
           call g:backupleaderdict[key](s)
       else
           ec 'coudnt find key for leadermanager [[' . a:s . ']]'
       endif
   endif
endfunction

function! SaveLocationToVimBookmarks(s)
    "let lineNumber = CurrentLineNumber()
    let value = CurrentLine()
    let payload = {a:s: value}
    if exists('g:bookmarks')
        ec 'g:bookmarks exists'
        call extend(g:bookmarks, payload)
    endif
    
    call UpdateJson('vimbookmarks.json', payload)

endfunction

function! GotoSavedBookMark(key)
    let key = a:key
    if !exists(g:bookmarks)
        let g:bookmarks = ReadJson('vimbookmarks.json')
    endif
    
    let pos = get(g:bookmarks, key)
    let lineNumber = pos
    let mark = key
    if Exists(pos)
        let charNumber = 1000
        call setpos('''' . mark, [0, lineNumber, charNumber, 0])
    else
        ec ' no pos'
    endif
endfunction

function! LibraryLoader()
    let g:fnlib = ReadJson('javascript.lib')
endfunction

function! LineBreakExpression()
    return JSPY('clbr')
endfunction

function! LineBreaker()
    let lang = CurrentExtension()
    if lang == 'js'
        return '/* -------------------------------------- */'
    elif lang == 'py'
        return '# -------------------------------------- #'
    endif
endfunction

function! LineChooser(from, increment)
  let end = IsString(a:from) ? line(a:from) : a:from
  while 1
    if Exists(getline(end))
        return end
        let end += a:increment
    else
        return end
        break
    endif
  endwhile
endfunction

function! LineCommenter(...)
    let line = a:0 >= 1 ? a:1 : CurrentLine()
    if trim(line) == ''
        return 
    endif
    if Exists(g:grabmode)
        let regex = ': \zs[''"].{-}[''"]'
        let match = Match(line, regex)
        call add(g:randomlist, match)
        return 
    endif

    let regex = '^ *\zs("|//|<!--|#|/\*|\*/)'

    if Test(line, regex)
        call UnCommentLine('.')
    else
        call CommentLine()
    endif
    return

    if Test(line, regex)
        call UnCommentLine('.')
        let n = 1
        while 1
            let line = getline(Relative(n))
            if Test(line, regex)
                call UnCommentLine(Relative(n))
                let n += 1
            else
                break
            endif
        endwhile

        ec 'down'
        let n = -1
        while 1
            let line = getline(Relative(n))
            ec line
            if Test(line, regex)
                call UnCommentLine(Relative(n))
                let n -= 1
            else
                break
            endif
        endwhile
    else
        call CommentLine()
    endif
endfunction

function! LineDitto(s)
    let line = CurrentLine()
    let quotable = GetQuotable(line)
    ec quotable
    if empty(quotable)
        ec 'empty'
        let quotable = GetFirstWord(line)
    endif
    let product = Parser233(line, quotable, a:s)
    ec product
    call AppendBelow('.', product, 1)
endfunction

function! LineIndex(n)
    let index = line('.') + a:n
    echom index
    return index
endfunction

function! LineRun(...)
    let indexes = []
    let condition = ''
    let Fn = ''

    if a:0 == 2
        let b:linerunstore = []
        let indexes = [0, '$']
        let condition = a:1
        let Fn = a:2
    elseif a:0 == 3
        let indexes = a:1
        let condition = a:2
        let Fn = a:3
    elseif a:0 == 4
        let indexes = [a:1, a:2]
        let condition = a:3
        let Fn = a:4
    endif
        
    for index in Ranger(indexes)
        let line = getline(index)
        if Test(line, condition)
            call setline(index, Fn(line))
            if a:0 == 2
                call add(b:linerunstore, index)
            endif
        endif
    endfor
endfunction

function! LineRunner(indexes, ...)
    let Condition = a:0 == 2 ? a:1 : 0
    let Runner = a:0 == 2 ? a:2 : a:1
    if IsString(Runner)
        let Runner = function(Runner)
    endif
    if IsString(Condition)
        let Condition = function(Condition)
    endif

    if empty(Condition) 
        if Runner == function('DeleteLine')
            let amount = a:indexes[1] - a:indexes[0]

            for i in Ranger(amount)
                call Runner(a:indexes[0])
            endfor

            return 
        endif
        for i in Ranger(a:indexes)
            call Runner(i)
        endfor
    else

        for i in Ranger(a:indexes)
            if Exists(Condition(getline(i)))
                call Runner(i)
            else
            endif
        endfor
    endif
endfunction

function! LineSearch(regex, ...)
    let start = a:0 >= 1 ? a:1 : ''
    let end = a:0 >= 2 ? a:2 : ''
    if start
        let start = LookBehind('^ *')
        " let start = '\(^ *\)\@<='
    endif

    let r  = start . a:regex . end
    " echom r
    return Search(CurrentLine(), r)
endfunction

function! LineSet(lines, ...)
    if Not(a:lines)
        return 0
    endif
    let spaces = a:0 == 1 ? a:1 : 0 
    let spaces = 1
    let writeover = 1
    let lines = AddSpaces(a:lines, spaces)
    if writeover
        call setline('.', lines[0])
        call append('.', lines[1:])
        call cursor(line('.') + len(lines) - 1, 100)
    else
        call append('.', lines)
    endif
    return 1
endfunction

function! LoadHelperLibrary()
    if exists('g:helperlib')
        "ec '"library exists'
        return 
    else
        let g:helperlib = ReadJson('myfunctions10-16-2021.json')
        "let g:helperlib = ReadJson('helpers.js.lib')
        "ec 'loading library'
    endif
endfunction

function! LoadLibrary(...)
    let libtype = a:0 >= 1 ? a:1 : 'js'
    let file = JSPY(libtype, 'libfile')
    let g:fnlib = ReadJson(file)
    ec file . ' has been loaded.'
endfunction

function! Logger(s, ...)
    let lang = a:0 == 1 ? a:1 : GetLang()
    if lang == 'js'
        return 'console.log' . Parens(a:s)
    elseif lang == 'py'
        return 'pprint' . Parens(a:s)
    elseif lang == 'vim'
        return 'echo ' . a:s
    endif
endfunction

function! LogicManager()
    let [spaces, line] = GetSpacesAndLine()
    let lang = GetLang()
    let [tag, parts, line] = TagAndPartsAndLine(line)

    let dict = get(g:logicdict, lang)
    let innerdict = get(dict, tag, 0)

    if empty(innerdict)
        ec 'done'
        return 0
    endif

    let [conditionlength, snippet, Innerparser] = [100, innerdict, 0]
    if IsArray(innerdict)
        let [conditionlength, snippet, Innerparser] = innerdict 
    elseif IsObject(innerdict)
        call LogicManagerObjectHandler(parts, innerdict)
        return 1
    endif

    if len(parts) > conditionlength
        ec 'surpasses conditionlength'
        return 
    endif

    if Test(snippet, '\$1')
        if !Test(snippet, '\$2')
            let parts = [parts[0], join(parts[1:], ', ')]
        endif
        for [i, part] in Enumerate(parts)
            let Parser = function('Identity') 
            let snippet = Replace(snippet, '\$' . i, Parser(part), 'g')
        endfor
        let snippet = Replace(snippet, '\$\d', '', 'g')
    else
        let snippet = Replace(snippet, '\$0', line,  'g')
        if IsFunction(Innerparser)
            let snippet = Replace(snippet, '\$a', Innerparser(parts[0]), 'g')
        endif
    endif
    if Test(snippet, '\$\$')
        let snippet = Replace(snippet, '\$\$(.{-})\$\$', {s -> eval(s[1])})
    endif

    call SnippetMaker(snippet)
    return 1
    
endfunction

function! LogicManagerObjectHandler(parts, dict)
    let noappend = 0 
    if has_key(a:dict, 'snippet')
        let snippet = a:dict.snippet
        let suffix = '}'
        let cursorpos = 0
        let index = 0
        if has_key(a:dict, 'noappend')
            let noappend = 1 
            let suffix = ''
        endif

        if !has_key(a:dict, 'functions')
            let a:dict.functions = 'Identity'
        endif
        if IsString(a:dict.functions)
            let replacement = FunctionGetter(a:dict.functions)(join(a:parts))
            let snippet = Replace(snippet, '\$' . index, replacement)
        else
            for fn in a:dict.functions
                let part = index < len(a:parts) ? a:parts[index] : ''
                let replacement = FunctionGetter(fn)(part)
                let snippet = Replace(snippet, '\$' . index, replacement)
                let index += 1
            endfor
        endif
    elseif has_key(a:dict, 'template')
      let snippet = a:dict.template
      let suffix = a:dict.suffix
      let cursorpos = has_key(a:dict, 'cursor') ? a:dict.cursor : 'null'
    endif

      if snippet =~ '%c'
          let cursorpos = GetCursorFromSnippet(snippet)
          let snippet = Replace(snippet, '\%c', '')
      endif
    ec cursorpos
    call SnippetMaker(snippet, suffix, noappend, cursorpos)
    return 1
endfunction

function! LogicParse(line)
    return a:line
    let lang = GetLang()
    if lang == 'js'
        if Not(m)
            return a:line
        else
            let product = m[0] . Parens(rest)
            return product
        endif
    else
        return a:line
    endif
endfunction

function! LookBehind(s, ...)
    let query = a:0 >= 1 ? a:1 : '.*'
    return '\v' . a:s . '\zs(' . query . ')'
endfunction

function! LookBehind2(r)
    let regex = '\(' . a:r . '\)\@<='
    return regex
endfunction

function! LookForFiles(s)
    if Test(a:s, '^\w+$')
        if Test(a:s, 'mp3|jpg|svg|png|js|py|txt|html|pdf|css')
            ec globpath('.', '*' . a:s)
        else
            ec globpath('.', a:s . '*')
        endif
        return 
    endif
    let [dir, query] = SplitOnce(a:s)
    ec [dir, query]
    ec globpath(dir, query)
endfunction

function! LsFiles(...)
    let query = a:0 >= 1 ? ' ' . a:1 : ''
    let amount = 3
    let dir = '/mnt/chromeos/GoogleDrive/MyDrive'
    let cmd = "ls " . dir . " -t" . query . " | head " . " -" . amount
    ec cmd
    let raw = systemlist(cmd)
    ec Numbered(raw)
    let answer = GetInput('choose file to copy')
    if Not(answer)
        return
    endif
    let file = raw[answer]
    ec file
    ec 'error here'
    return 
    call BashCopy(file, 'copy.pdf')
endfunction

function! MakeArray(line)
    let parts = split()
endfunction

function! MakeHtml()
    call ExecuteFile('makescript.js', CurrentFile())
    call OpenLocalFile('template.html')
endfunction

function! Map(items, fn)
    return map(a:items, {i, v -> FunctionGetter(a:fn)(v)})
endfunction

function! Mapped(items, fn)
    let store = []
    for item in a:items
        call add(store, FunctionGetter(a:fn)(item))
    endfor
    return store
endfunction

function! Mapped3(items, fn)
    return map(a:items, {i, v -> FunctionGetter(a:fn)(v)})
endfunction

function! MarkLastPosition()
    let pos = getpos('.')
    let g:lastposition = pos
    let b:lastposition = pos
endfunction

function! Match(s, regex)
    return matchstr(a:s, Regexed(a:regex))    
endfunction

function! MatchReplace(regex)
    let store = []
    let lines = GetLines()
    for i in Ranger(lines)
        let line = lines[i]
        if Test(line, a:regex)
            call DeleteLine(i)
            call add(store, line)
        endif
    endfor
    return store
endfunction

function! MatchSearch(r, ...)
    let options = a:0 >= 1 ? 'n' . a:1 : ''
    let threshold = a:0 >= 2 ? line('.') + a:2 : 0
    let index = search(Regexed(a:r), options, threshold)
    ec index
    if index > 0
        return Match(getline(index), a:r)
    endif
endfunction

function! MatchStrAll(regex, s, ...)
  let start = a:0 ? a:1 : 0
  let lst = []
  let cnt = 1
  let regex = Regexed(a:regex)
  let found = match(a:s, regex, start, cnt)
  while found != -1
    let smatch = matchstr(a:s, regex, start, cnt)
    let cnt += strlen(smatch)
    call add(lst, smatch)
    let found = match(a:s, regex, start, cnt)
  endwhile
  return lst
endfunction

function! Merge(...)
    let store = []
    for item in a:000
        if IsString(item)
            call add(store, item)
        else
            call extend(store, item)
        endif
    endfor
    return store
endfunction

function! MergeJson(s)
    let [from, name, to] = SlashSplit(a:s)
    let lines = ReadJson(FileGetter(from))
    let to = FileGetter(to)

    let a = '\v^(class|function|def|const)' . ' ' . name . '>|' . name . ' \= \{$'
    let b = '\v^(class|end|function|def|}|\])'
    let jsonA = SearchBetween(lines, a,b)
    let jsonB = ReadJson(to)
    call extend(jsonA, jsonB)
    WriteJson(to, jsonA)

    call GetSetFile(to, {lines -> lines[0:-2]  + inlines[1:]}) 
endfunction

function! Mod(n,m)
  return ((a:n % a:m) + a:m) % a:m
endfunction

function! MoveBack()
    edit #
endfunction

function! MoveCursor(n)
    call cursor(a:n, 1000)
endfunction

function! MoveCursorToNextBlock()
    let index = search('\v^ *(\}|\]|end)', '', Relative(10))
    normal o
endfunction

function! MoveItemsToNewLocation(s)
    let destination
    let target
    let s = a:s
    if Test(s, '  ')
        let items = split(s, '  ')
        let s = 
    elif Test(s, ' ')

    else
        let destination = items[0]
        let target = items[0] . '\w*'

endfunction

function! MoveText(...)
    let key = a:0 >= 1 ? a:1 : 0
    let [a,b] = GetCodeIndexes('current-to-end')
    let lines = getline(a, b)
    call add(lines, 'pagebreak')
    if key
        call insert(lines, key)
    endif
    call deletebufline('%', a, b)
    call AppendFile(DateName(), lines)
endfunction

function! MovementManager()
    let line = GetFunctionIndex()
    call append(line - 1, ['', '', ''])
    call cursor(line + 1, 0)
endfunction

function! MultipleExecution(...)
    let cmd = "! " . join(a:000, ';')
    execute cmd
endfunction

function! Multiply(s, ...)
    let s = a:s
    let n = a:0 >= 1 ? a:1 : 2
    for i in range(0, n - 2)
        let s .= s
    endfor
    return s
endfunction

function! MyCounter()
  let s:counter = s:counter + 1
  echo s:counter
endfunction

function! MyVertBlock(line1, line2, column1, column2)
    let select_command = a:line1 . 'G' . a:column1 . '|'
    let select_command .= "\<C-V>"
    let select_command .= a:line2 . 'G' . a:column2 . '|'
    execute 'normal!' select_command
endfunction

function! NameEscape(file)
    let p = Sub(a:file, '[\(\) ]', {s -> '\' . s[0]})
    return p
endfunction

function! SetTempBindings(key)
    let key = a:key
    if Exists(get(g:activetempbinding, key))
        g:activetempbinding[key] = 0
        exec "nunmap " . key
        ec 'unmapping ' . key
        return 
    endif

    g:activetempbinding[key] = 1
    let f = get(g:tempbindingref, key)
    let cmd = ''
    if Test(f, '^\w+$')
        let cmd = 'nmap ' . key . ' :call ' . f . '("")<LEFT><LEFT>'
    elseif Test(f, '^/')
        let cmd = f
    endif

    ec cmd
    exec cmd

endfunction

function! OpenInternet(...)
    let s = a:0 >= 1 ? a:1 : 'r'
    let links = {
        \'r': 'reddit.com',
        \'y': 'youtube.com',
    \}
    execute "!xdg-open https://" . get(links, s, s)
endfunction

function! NameFile()
    let cwf = "/mnt/chromeos/GoogleDrive/MyDrive/CWF/"
    let name = expand('%:t')
    let name = Replace(name, '^\.', '')
    let outpath = cwf . name . DateStamp()
    echom outpath
    return outpath
endfunction

function! NameFix(name)
    let namedict = {'a': 'zoop'}
    return Dreplace(name, namedict, '<', '>')
endfunction

function! NameMaker(line)
    let context = GetContext3()
    let [p1, p2, suffix, capitalize] = JSPY('p1', 'p2', 'suffix', 'capitalize')
    let line = Replace(a:line, '^ *(on|zfoo|set|get)\zs\w', {s -> Capitalize(s[0])})
    let async = ''
    if Test(line, '^async ')
        let async = 'async '
        let line = line[6:]
    elif Test(line, '^a ')
        let async = 'async '
        let line = line[2:]
    endif

    if context == 'vue' || context == 'const' || context == 'var'
        let namestatement = CreateName(line, capitalize)
        let namestatement = Replace(namestatement, '^function ', '')
        let start = async . namestatement . p2
        return [start, '    ', '},']
    elseif context == 'class'
        if Test(line, 'get ')
            let name = Match(line, '\w+$')
            return 'get ' . name . '()' . p2
        elseif Test(line, 'set ')
            let name = CreateName(Replace(line, '^ *\w+ *', ''), capitalize)
            return 'set ' . name . p2
        elseif Test(line, 'static ')
            let name = CreateName(Replace(line, '^ *\w+ *', ''), capitalize)
            return async . 'static ' . name . p2
        endif
    endif

    let namestatement = CreateName(line, capitalize)
    let start = namestatement . p2
    let prefix = context == 'class' ? '' : context == 'const' ? '' : p1 . ' '

    if Not(StartsWith(namestatement, 'func'))
        let start = prefix . namestatement . p2
    endif
    return async . start
endfunction

function! Namechanger(s)
    let pairs = CreatePairs(split(a:s))
    for [a,b] in pairs
        call ExecuteReplace('[''"]\zs' . a . '\ze[''"]', b)
        call Commander('cp', a, b)
    endfor
endfunction

function! Ncg(s)
    if IsString(a:s) 
        return a:s
    else
        return '(' . join(a:s, '|') . ')'
    endif
endfunction

function! NewDocTest()
    let [spaces, line] = GetSpacesAndLine()
    let line = getline('.')
endfunction

function! NextLine()
    return line('.') + 1
endfunction

function! NextSnippet()
    if Not(exists('b:snippetcount'))
        return
    elseif b:snippetcount == 0
        return
    else
        let b:snippetcount -= 1
        call ReplaceForwards()
endfunction

function! Nla(s)
    return Parens(a:s) . '@!'
endfunction

function! Nlb(s)
    return Parens(a:s) . '@<!'
endfunction

function! NoSymbols(s)
    return a:s =~ ']\|}'
endfunction

function! NoVisualSelection(indexes)
    "ajsdfhakjsdfkds.foo
    return a:indexes[0] == 0 && a:indexes[1] == 1
endfunction

function! Normal(s)
    execute "normal! " . a:s
endfunction

function! NormalEnter(s)
    return
    execute "normal! " . a:s . '\<cr>'
endfunction

function! NormalSub(regex, replacement)
    execute 'normal !'
endfunction

function! Not(x)
   return Exists(a:x) ? 0 : 1
endfunction

function! NotEndsWith(el, s)
    return EndsWith(a:s, a:el) ? 0 : 1
endfunction

function! NotExists(s)
    return a:s ==# ''
endfunction

function! Numbered2(s)
    let s = a:s
    let output = ''
    for [i, item] in Enumerate(s)
        let output .= (i + 1)  . '. ' . item . "\n"
    endfor 
    return output
endfunction

function! Numbered(s)
    let s = a:s
    let output = ''
    for [i, item] in Enumerate(s)
        ec i  . '. ' . item
        "let output .= i  . '. ' . item . "\n"
    endfor 
    "return output
endfunction

function! ObjectExpand(line)
   let parts = split(a:line) 
   let Parser = {part -> Quotify(part) . ': ' . part }
   let parts = Mapped(parts, Parser)
   return '{' . join(parts, ', ') . '}'
endfunction

function! OldDocTest(line)
    let lang = GetLang()
    let line = a:line 
    if Test(line, '^console.log')
        call setline('.', '' . 'let temp = ' . '' . line[12:-2])
        return 
    endif
    let spaces = CurrentSpaces()
    let [variablePrefix, cs, ce] = JSPY('variablePrefix', 'consoleStart', 'consoleEnd')

    let content = matchstr(line, '\w*\ze =')
    if Exists(content) 
        call AppendBelow('.', Logger(content))
        return
    endif
    ec 'adfadf'

    let content = matchstr(line, '\(^ *if (.\{-})\)\@<=.*$')
    " GetLogicItem
    " Doesnt seem to work.
    if Exists(content)
        let replacement = spaces . dict[lang] . '(' . content . ')'
        normal O
        call setline('.', replacement)
        return
    endif

    let content = matchstr(line, '\v^(def|class|function) \zs\w+')
    " GetFunction And Append to Bottom.
    if Exists(content)
        call AppendBottom(Logger(content . '()', lang))
        return
    endif

    let content = matchstr(line, '^ *return \zs.*')
    if Exists(content)
        ec 'sup'
        let a = substitute(Strip(line), 'return ', variablePrefix . 'p = ', '')
        ec a
        let b = cs . 'p' . ce
        let c = 'return p'
        let items = [a,b,c]
        call TextPlacement(items, spaces)
        return
    endif

    let content = matchstr(line, '\(function \)\@<=[a-zA-Z0-9]*')
    echo content
    if Exists(content) 
        echo 'func'
        let replacement = spaces . dict2[lang] . '(' . content . '(s))'
        normal G
        let line = CurrentLine()
        echo line
        if Test(line, 'console')
            call setline('.', replacement)
        else
            normal o
            call setline('.', replacement)
        endif
        return
    endif

    let content = matchstr(line, '^class \S*')
    
    "nongreedy .\{-\}
    let content = matchstr(line, '^adsfaodsfaods\S*')
    if Exists(content) 
        call setline('.', ConsoleLog(line))
        return
    endif

    " The final Thing going on. OFten causes an error.
    let replacement = substitute(line, '\( *\)\(\S*\)', '\1console.log(\2)', '')
    call setline('.', replacement)

    echo ' doctest no match'
endfunction

function! OneRunner()
    let lang = GetLang()
    ec lang
    return 
    let runtime = JSPY(lang, 'runtime')
    ec runtime
    if lang == 'py'|| lang == 'js'
        ec 'sup'
        ec 'fooooo'
        execute "normal! :w\<cr>:!" . runtime . " %"
    elseif IsVim()
        ec 'is vim'
    else
        echom 'not a commander file'
        call SaveFile()
        call EditConnector('jsa')
    endif
endfunction

function! TimeStamp() 
    return reltime()[0]
endfunction

function! OpenBuffer(buffer, ...)
    if IsCurrentFile(a:buffer)
        return 
    endif

    if Not(a:buffer)
        ec 'not a buffer: ' . a:buffer
        return 
    endif

    let name = IsStringNumber(a:buffer) ? bufname(str2nr(a:buffer)) : a:buffer
    if IsPdf(name)
        return OpenPdf(name)
    endif
    if bufexists(name)
        let command = 'buffer!'
    else
        let command = a:0 >= 1 ? "vsplit" : "edit"
    endif
    execute Join(command, name)
endfunction

function! GoToBuffer(buffer)
    let buffer = FileGetter2(a:buffer)
    if bufexists(buffer)
        execute "buffer " . buffer
    else
        execute "edit " . buffer
    endif
endfunction

function! OpenBufferGroup(query)
    let newbuffers = IsArray(a:query) ? a:query : GetFiles(a:query, 5)
    if len(newbuffers) < 2
        ec newbuffers
        return
    endif
    execute ":wa"
    let currentbuffers = GetCurrentBuffers()
    call add(g:buffergrouplist, currentbuffers)
    call Iterate(currentbuffers, function('CloseBuffer'))
    call Iterate(newbuffers, function('OpenBuffer'))
endfunction

function! OpenBuffers(files)
    for file in a:files
        execute "e " . file 
    endfor
endfunction

function! OpenBuffersFromFolder(dir)
   execute "cd ~/CWF"
   let files = Absdir(a:dir) 
   call CloseActiveBuffers()
   call OpenBuffers(files)
endfunction

function! OpenChromeBrowser(...)
    "OpenWebsite OpenWebsiteLink 
    let query = a:0 >= 1 ? a:1 : 'howdy partner'
    ec query
    let key = ''
    let val = ''
    if Exists(query) 
        let [key, val] = SplitOnce(query)
    endif
    ec key val
    return 
    let link = query
    XdgOpen(link)

endfunction

function! OpenCurrentFiles()
    let files = ['vuecm5.html', 'vuehelpers.js']
    for file in files
        call OpenBuffer(file)
    endfor
endfunction

function! OpenFile(file)
    call XdgOpen(a:file)
endfunction

function! OpenFiles(files)
    for file in a:files
        ec file
        execute "!xdg-open " . file
   endfor 
endfunction

function! OpenFoo()
    !xdg-open index.html
endfunction

function! OpenLocalFile()
    let file = CurrentFile()
    if Test(Tail(file), '^x|txt$')
        call XdgOpen(file)
    elseif GetExtension(file) == 'html'
        call XdgOpen(file)
    else
        let file = g:activeHtmlFile
        call XdgOpen(file)
    endif
endfunction

function! OpenLocalHost()
    let url = 'http://localhost:3000'
    call XdgOpen(url)
endfunction

function! OpenNpmFile(s)
    let [dir, query] = SplitOnce(a:s)
    let dir = '/home/kdog3682/CWF/node_modules/' . dir
    let files = split(globpath(dir, query . '*'), "\n")
    call OpenFiles(files)

endfunction

function! OpenSmartFile()
    let file = FindFileString(GetVisibleLines())
    call OpenBuffer(file)
endfunction

function! OpenTargetedFile()
    let file = 'satprep.html' 
    execute "!xdg-open " . file
endfunction

function! OpenTempFiles()
   call OpenBuffers(readfile('tempfiles.txt') )
endfunction

function! OptionGetter(args, flags)
    let store = []
    let flags = split(a:flags, '\zs')
    for i in range(0, len(flags) - 1)
        "if i < len(a:args) && a:args[i] == flags[i]
        if i < len(a:args)
            call add(store, a:args[i])
        else
            call add(store, 0)
        endif
    endfor
    return store
endfunction

function! P99(s, parts, line)
    ec a:s
    let s = a:s[1]
    ec s
    if s == '0'
        return Quotify(a:line)
    elseif s - 1 < len(a:parts)
        ec a:parts
        return Quotify(a:parts[s - 1])
    else
        return ''
    endif
endfunction

function! PParser(x)
    ec a:x
    return 'boooo!'
endfunction


function! Parser233(line, regex, replacement, ...)
    let flags = a:0 >= 1 ? a:1 : 'g'
    return Replace(a:line, a:regex, {x -> Parser234(x, a:replacement)}, flags)
endfunction

function! Parser234(x, replacement)
    let cap = IsCapitalized(a:x[0])
    return cap ? Capitalize(a:replacement) : a:replacement
endfunction

function! PasteBlock()
    let range = GetCodeIndexes()
    let lines = GetLines(range)
    call add(lines, '')
    call writefile(lines, "/home/kdog3682/CWF/storage.py", "a")
endfunction

function! Paster()
    let word = GetWord(line, -1)
    let cmd = JSPY('variablePrefix') . ' = ' . word
    execute 'normal! O' . cmd . '<esc>p'
endfunction

function! PathFix(file)
    let root = '/home/kdog3682/'
    let base = '/home/kdog3682/CWF/'
    let base = getcwd() . '/'
    if Test(a:file, '^[~/]')
        return a:file
    elseif a:file =~ 'vimrc'
        return root . a:file
    else
        return base . a:file
    endif
endfunction

function! Pla(s)
    return Parens(a:s) . '@!='
endfunction

function! PlaceAt(location, lines)
    call append('$', a:lines)
    return
    let index = DoubleEmpty(line('.')) ? line('.') : GetFunctionIndex('W')
    ec index
    "call insert(a:lines, '')
    call append(index, a:lines)
    call cursor(index, 100)
endfunction

function! Plb(s)
    return Parens(a:s) . '@<='
endfunction

function! Pos()
    return getpos(".")
endfunction

function! PrepareFileForCreation(file)
    let lang = GetLang(a:file)
    let lines = get(g:prepfiledict, lang)
    call WriteFile(a:file, lines)
endfunction


function! Preview(s)
    call Grab(a:s, 1)
endfunction

function! PreviousWord(line)
    
endfunction

function! Prf()
    let r = '^ *\zs\w+\ze ='
    let r = Finder(r)
    let s = GetVariable()
    call SetLines('matches = findall(' . r . ', ' . s . ')', Logger('matches'))
endfunction

function! Print()
    call append('.', CurrentSpaces() . '"Debugging"')
endfunction

function! PrintActiveBuffers()
    wa
    call AppendFile('myfiles.txt', GetCurrentBuffers())
    ec "DONE FOR TODAY!"
    q

endfunction

function! PrintReadFile(file)
    let s = trim(join(readfile(a:file), "\n"))
    if Not(s)
        ec a:file . ' is empty!'
    else
        ec s
    endif
endfunction

function! PrintToScreen(indexes)
    ec join(GetLines(a:indexes), "\n") . "\n\n"
endfunction

function! Pugify()
    let match = Match(GetFunctionLine(), '\w+\ze \=')
    ec match
    call setline('.', 'pug(' . match . ')')
endfunction

function! PyFix(i)
    let start = a:i[0]
    let lines = GetLines(a:i)
    for i in Ranger(lines)
        let line = lines[i]
        if Test(line, '^ *(elif|while|if|for)') && !Test(line, ':$')
            let lines[i] = line . ':'
        elseif Test(line, '^ *foooooo')
            let lines[i] = ''
            for i in Ranger(lines)
                let lines[i] = IndentLine(lines[i])
            endfor
            call insert(lines, Match(line, 'foo\zs\w+') . '():'
        endif
    endfor
        
    let text = join(lines, "\n")
    let dict = { 
     \   'less than': '<',
     \   '\bis\b': '==',
    \ }
    let fndict = {
        \'for kv(\w+)': 'for k,v in $1.items()',
        \'(\S+) has (\S+)\ze[\n:]': "test('$2', $1)",
        \'(\w+)\.(\w+)\ze[,\n\]\)\} \:]': "$1.get('$2')",
    \}

    let text = Dreplace(text, dict)
    let text = Freplace(text, fndict)
    call setline(start, SplitLines(text))
endfunction

function! VarializeTheString(s)
    return 's = ' . Quotify(a:s)
endfunction

function! PySnippetFromBack()
    "niu
    let [spaces, tag, line] = GetSpacesTagLineInReverse()
    let snippet = get(g:pybackdict, tag)
    call Templater2(snippet, line, spaces)

endfunction

function! Templater2(snippet, refArg, spaces)
    
    let spaces = a:spaces
    let snippet = a:snippet

    let regex = '\$(\{.{-}\}|\w+)'
    let snippet = Sub(snippet, regex, {x -> function('TemplateRunner')(x, a:refArg)})
    let cursorpos = GetCursorFromStringSnippet(snippet)
    let snippet = Replace(snippet, '\$c', '')
    call TextPlacement(SplitLines(snippet), spaces)
    call SetCursor(cursorpos, spaces)
endfunction

function! StringTemplateRunner(match, ref)
    return a:ref[a:match[1] - 1]
endfunction

function! TemplateRunner(match, ref)
    let match = a:match[1]
    let line = a:ref

    if match == 'null'
        return ''
    elseif match == 'c'
        return ''
    elseif match == '0'
        return line
    elseif Test(match, '^\d+')
        return parts[match - 1]
    elseif match =~ '^{'
        let match = match[1:-2]
        let match = Sub(match, '\$(\w+)', {s -> function('Quotify')(function('TemplateRunner')(s, line))})
        return eval(match)
    endif
endfunction


function! PlaceSnippet(snippet, spaces)
    let snippet = a:snippet
    let spaces = a:spaces
    let cursorpos = GetCursorFromStringSnippet(snippet)
    let snippet = Replace(snippet, '\$c', '')
    call TextPlacement(SplitLines(snippet), spaces)
    call SetCursor(cursorpos, spaces)
endfunction

function! Pst(match, parts, line)
    let match = a:match[1]
    let parts = a:parts
    let line = a:line
    let [match, options] = Mreplace(match, '--[a-z]$')
    if Exists(options)
        let options = Replace(options, '-+', '')
        call Append(options)
    endif

    if has_key(g:templaterfndict, match)
        return function(g:templaterfndict[match])()
    elseif match == 'last'
        return parts[-1]
    elseif match == 'notlast'
        "return join(parts, ' ')
        return join(parts[:-2], ' ')

    elseif match == 'middle'
        return join(parts[1:-2], ' ')

    elseif match == 'rest'
        return join(parts[1:], ' ')
    elseif Test(match, '^\d+')
        if match == '0'
            return line
        elseif match - 1 < len(parts)
            let value = parts[match - 1]
            if options == 'l'
                return value 
                return tolower(value)
            elseif options == 'u'
                return Capitalize(value)
            else
                return value
            endif
        else
            return ''
        endif

    elseif match =~ '^{'
        let match = match[1:-2]
        let match = Sub(match, '\$(\w+)', {s -> function('Quotify')(function('Pst')(s, parts, line))})
        return eval(match)

    endif
endfunction

function! Pst2(match, parts)
    let match = a:match[1]
    let parts = a:parts
    return parts[match - 1]
endfunction

function! PySnippetTemplater(match, parts, line)
    let match = a:match[1]
    let parts = a:parts
    let line = a:line

    if match == 'null'
        return ''
    elseif match == 'rest'
        return join(parts, ' ')
    elseif Test(match, '^\d+')
        if match == '0'
            return line
        elseif match - 1 < len(parts)
            return parts[match - 1]
        else
            return ''
        endif

    ec match
    elseif match =~ '^{'
        let match = match[1:-2]
        let match = Sub(match, '\$(\w+)', {s -> function('Quotify')(function('PySnippetTemplater')(s, parts, line))})
        return eval(match)

        map
    endif
endfunction

function! QuestionShifter()
    let lang = GetLang()
    call OpenBuffer('questions.txt', 1)
    call append('.', lang)
    return
    if GetFile() == 'questions.txt' 
        execute "edit #"
    else
        call OpenBuffer('questions.txt', 1)
        call append('.', lang)
    endif
endfunction

function! QuoteHelper()
    let [line, spaces] = CurrentLineAndSpaces()
    let name = 'regex'
    let regex = '[''"]....*["'']'
    let match = Match(line, regex)
    if Exists(match)
        let second = Replace(line, regex, name, '')
        let prefix = JSPY('variablePrefix')
        let first = prefix . name . ' = ' . match
        call setline('.', second)
        call append(line('.') - 1, spaces . first)
    else
        ec 'no match at quotehelper'
    endif
endfunction

function! QuoteRunner(line)
   let product = JSPY('variablePrefix') .  'placeholder' . ' = "\0"'
   return Replace(a:line, '\S+', product)
endfunction

function! Quotify(s, ...)
    let dq = a:0 >= 1 ? a:1 : 0
    if Exists(dq) 
        return '"' . a:s . '"'
    endif
    return '''' . a:s . ''''
endfunction

function! Ranger(list, ...)
    let secondindex = a:0 == 1 ? a:1 : 0 
    if Exists(secondindex)
        return range(a:list, secondindex)
    elseif len(a:list) == 2 && IsNumber(a:list[0])
        return range(a:list[0], a:list[1], 1)
    elseif IsNumber(a:list)
        return range(0, a:list)
    else
        return range(0, len(a:list) - 1, 1)
    endif
endfunction

function! Read(f)
    let f = GetLastWriteFile(a:f)
    "if Not(f)
        "let f = GetFileFromCache(a:f)
    "endif
    if Not(f)
        let f = FileGetter(a:f)
    endif

    if filereadable(f) 
       if exists('g:filetrackerlist')
           call add(g:filetrackerlist, f)
       else
           let g:filetrackerlist = [f]
       endif
       execute ":vsplit " . f 
    else
        ec f . ' is not a file.'
    endif
endfunction

function! ReadFile(file)
    let value = join(readfile(a:file), "\n")
    return value
endfunction

function! ReadJson(file)
    let data = IsString(a:file) ? readfile(a:file) : a:file
    try
        return js_decode(join(data))
    catch
        return {}
    endtry
    
endfunction

function! ReadLastFile()
    ec ReadFile(g:lastfile)
endfunction

function! Reader()
   if Exists(g:lastbuffer)
       ec join(readfile(g:lastbuffer), "\n")
   endif
   let g:lastbuffer = 0
endfunction

function! Regex(dict)
    let dict = a:dict
    let items = IsObject(dict) ? keys(dict) : map(deepcopy(dict), 'v:val[0]')
    let combine = join(items, '|')
    let p = Parens(combine)
    let p = '(' . combine . ')'
    return p
endfunction

function! RegexNumber(a,b)
    let a = IsNumber(a:a) ? a:a : strlen(a:a)
    let b = IsNumber(a:b) ? a:b : strlen(a:b)
    return '{' . a . ',' . b . '}'
endfunction

function! RegexSpaces(a,b)
    if a:b == 0
        return ' {' . a:a . ',' . a:a . '}'
    endif
    return ' {' . a:a . ',' . a:b . '}'
endfunction

function! RegexTest()
    let line = 'function Cfun(foo)'
    let regex = '^(function|def|class) ' . 'Cfun'
    echom Match(line, regex) 
endfunction

function! Regexed(regex, ...)
    let boundary = a:0 == 1 ? a:1 : 0
    let magic = a:regex =~ '^\\v' ? '' : '\v'
    let bs = ''
    let be = ''
    if boundary
        let bs = '<'
        let be = '>'
    endif
    let regex = bs . a:regex . be
    return magic . regex

endfunction

function! Relative(n)
    return line('.') + a:n
endfunction

function! RelativeAppend(n, s)
    if a:n == 0
        call setline('.', a:s)
    else
        let index = line('.') + a:n
        call append(index, a:s)
    endif
endfunction

function! RelativeLineChar(n)
    let line = CurrentLine()
    let length = strlen(line)
    return length + a:n
endfunction

function! ReloadVim()
    ec 'Reloading Vim'
    if Exists(g:notelist)
        let s = CommentLine(GetDate())
        call insert(g:notelist, s)
        call AppendFile('/home/kdog3682/CWF/notes.txt', g:notelist)
    endif

    if Exists(g:questionlist)
        call AppendFile('questions.txt', g:questionlist)
        let s = Stringify(g:questionlist)
        call ExecuteFile('redditscript.py', s)
    endif
endfunction

function! RemoveAllComments(indexes)
    for i in Ranger(a:indexes)
        if IsComment(getline(i))
            call DeleteLine(i)
        endif
    endfor
endfunction

function! RemoveConsoleLog()
    execute 'normal! :%s\/fzoo\/bar\<cr>'
    "fzoo
    " call NormalCommand(':%!tail -1/^console.log/\/\/ console.log\<cr>')
endfunction

function! RemoveLines(indexes)
    let [a,b] = a:indexes
    for i in range(a,b)
        ec i
        call DeleteLine(a)
    endfor
endfunction

function! NormalizeFileName(s)
    let s = a:s
    if Test(s, '/')
        return s
    endif
    if GetExtension(s) == 'py'
        let s = Sub(s, '-', '_')
    endif
    let s = ToSnakeCase(s)
    return s
endfunction

function! DecrementFileName(file)
    let file = a:0 >= 1 ? a:1 : CurrentFile()
   let [a,b] = split(file, '\v\ze\.\w+$')
   if Test(a, '\d$') 
       let a = Replace(a, '\d$', {s -> s[0] - 1})
   else
       let a .= '2'
    endif
    let name = a . b
    return name
endfunction

function! IncrementFileName(file)
    let file = a:0 >= 1 ? a:1 : CurrentFile()
   let [a,b] = split(file, '\v\ze\.\w+$')
   if Test(a, '\d$') 
       let a = Replace(a, '\d$', {s -> s[0] + 1})
   else
       let a .= '2'
    endif
    let name = a . b
    return name
endfunction

function! CopyFileIncrement()
    let name = IncrementFileName()
   if IsFile(name)
       call OpenBuffer(name)
       return 
   endif

   let lines = GetLines()
   call CloseBuffer()
   call OpenBuffer(name)
   call setline('.', lines)
endfunction

function! CopyFileIncrementOverride()
    let name = IncrementFileName()

   let lines = GetLines()
   call CloseBuffer()
   call WriteFile(name, lines)
   call OpenBuffer(name)
endfunction

function! RenameFile(s)
   let s = a:s
   let name = s . '.' . GetExtension(CurrentFile())
   execute "saveas! " . name
endfunction

function! MoveFile()
    
endfunction

function! RenameFileOld(s)
    let [from, to] = SplitOnce(a:s)
    if to == ''
        let to = from
        let from = CurrentFile()
    endif
    wa
    let lines = GetLines()
    call OpenBuffer(to)
    call DeleteFile(from)
    call append('.', lines)
endfunction

function! RemoveNumbers(s)
    return Sub(a:s, '\d+', '')
endfunction

function! RenameFileToOriginal()
    let fileA = CurrentFile()
    let fileB = RemoveNumbers(fileA)
    call RenameFile(fileA, fileB)
endfunction

function! Renamer(name, bang)
    let l:curfile = expand("%:p")
    let l:curfilepath = expand("%:p:h")
    let l:newname = l:curfilepath . "/" . a:name
    let v:errmsg = ""
    let outpath = a:bang . " " . l:newname
    ec outpath
    return
    silent! exe "saveas" . outpath
    if v:errmsg =~# '^$\|^E329'
        if expand("%:p") !=# l:curfile && filewritable(expand("%:p"))
            silent exe "bwipe! " . l:curfile
            if delete(l:curfile)
                echoerr "Could not delete " . l:curfile
            endif
        endif
    else
        echoerr v:errmsg
    endif
endfunction

function! Replace(s, regex, replacement, ...)
    let flags = a:0 == 1 ? a:1 : ''

    if IsArray(a:s)
        return map(a:s, "substitute(v:val, Regexed(a:regex), a:replacement, 'g')")
    elseif IsString(a:s)
        return substitute   (a:s, Regexed(a:regex), a:replacement, flags)
    endif

endfunction

function! ReplaceAcrossFiles(s)
    return
endfunction

function! ReplaceArgsZero(line, replacement)
    return Sub(a:line, '\.\.\.args|args\[\d+\]', a:replacement)
endfunction

function! ReplaceBackwards(...)
    let replacement = ''
    let target = 'placeholder'
    let regex = '\v<' . target . '>'
    let index = search(regex, 'bc')
    call GetSet(index, {line -> Replace(line, regex, replacement, '')})
endfunction

function! ReplaceContiguousOrScreen(s)
    let g:lastrc = a:s
    if Test(a:s, '  ') && Not(Test(a:s, '^ask'))
        let indexes = GetIndexesHelper('line')
        let line = getline(indexes)
        let pairs = split(a:s, '  ')
        for pair in pairs
            let [a,b] = split(pair, '/')
            let a = strlen(a) == 1 ? '<' . a . '>' : a
            let line = Replace(line, a, b, 'g')
        endfor
        call setline(indexes, line)
        return 
    endif

    if a:s == '/'
        return GoToLocation2()
    endif

    if a:s == '}'
        return ExecuteRegex('^}')
    endif

    if !Test(a:s, '/')
        let [key, arg] = ForceSplit(a:s)
        let innerdict = get(g:replacecdict, key)
        let Fn = get(innerdict, 'fn')
        let mode = get(innerdict, 'mode', 'fn')
        if empty(Fn)
            let Fn = get(innerdict, 'gs')
            let mode = 'gs'
        endif

        let bookarla = get(innerdict, 'bookarla')
        let wrapper = get(innerdict, 'wrapper')

        if mode == 'gs'
            let wrapper = 'GS3'
        endif

        let indexmode = get(innerdict, 'i')
        ec indexmode
        return 
        let indexes = GetIndexesHelper(indexmode)
        let Fn = FunctionGetter(Fn)

        if Exists(wrapper)
            ec [wrapper, 'asdf']
            let WrapFn = FunctionGetter(wrapper)
            ec WrapFn
            if Exists(arg)
                call WrapFn(indexes, {s -> Fn(s, arg)})
            else
                call WrapFn(indexes, Fn)
            endif
            return 
        endif

        if IsFunction(Fn)
            if indexmode == 'null'
                if Exists(arg)
                    call Fn(arg)
                else
                    call Fn()
                endif
            else
                if Exists(arg)
                    if mode == 'lines'
                        call Fn(GetLines(indexes), arg)
                    else
                        call Fn(indexes, arg)
                    endif
                else
                    if mode == 'lines'
                        call Fn(GetLines(indexes))
                    else
                        call Fn(indexes)
                    endif
                endif

                if mode == 'delete'
                    call DeleteBlock(indexes)
                endif
            endif

        elseif IsArray(Fn)
            ec 'adsfasdfasdf is array check this out bc we want to delete it'
            let [condition, runner] = Fn     
            ec indexes
            for i in range(indexes[0], indexes[1] - 1)
                let line = getline(i)
                if Exists(function(condition)(line))
                    call function(runner)(i)
                endif
            endfor
            "call LineRunner(indexes, condition, runner)

        else
            let replacer = innerdict.replacer
            if IsArray(replacer)
                let [regex, replacement, flags] = replacer
                let P = {i -> ReplaceLine(i, regex, replacement, flags)}
                call LineRunner(indexes, P)
            endif
        endif
        return
    endif

    let flag = 'fn'
    let boundary = 0
    let s = a:s

    if s =~ '^/'
        let regex = '/[bc]+$'
        let s = s[1:]
        let boundary = 0
        let sensitive = 0
        if Test(s, regex)
            let match = Match(s, regex)
            let s = s[0:-strlen(match)]
            if match =~ 'b'
                let boundary = 1
            endif
            if match =~ 'c'
                let sensitive = 1
            endif
        endif
        let [a,b] = SmartSplit(s, '//')
        if boundary
            let a = Boundary(a)
        endif
        call ExecuteReplace(a, b, sensitive)
        return 
    endif

    if s =~ '^,'
        let s = s[1:]
        let boundary = 1
    endif

    if s == '"'
        let s = '" '''
    elseif s == ''''
        let s = ''' "'
    endif
    let s = AddBackSlashes(s)

    let [a,b] = GetIndexesHelper('')
    call ReplaceRange(a,b, s, boundary)

endfunction

function! ReplaceForwards(...)
    let replacement = ''
    let target = 'placeholder'
    let regex = '\v<' . target . '>'
    let index = search(regex)
    call GetSet(index, {line -> Replace(line, regex, replacement, '')})
endfunction

function! ReplaceIndexes(indexes, s)
    let index = IsArray(a:indexes) ? a:indexes[0] : a:indexes
    let lines = ToLines(a:s)
    let length = len(lines)
    let delta = 0

    if IsArray(a:indexes)
        let delta = abs(a:indexes[1] - a:indexes[0] - len(lines))
        for i in range(0, delta - 2)
            call append(index, '')
        endfor
    endif

    call setline(index, lines)
endfunction

function! ReplaceLine(index, regex, replacement, ...)
    let flags = a:0 >= 1 ? a:1 : ''
    call GetSet(a:index, {s -> Replace(s, a:regex, a:replacement, flags)})
endfunction

function! ReplaceLines(lines, s, ...)
    let boundary = a:0 == 1 ? a:1 : 0 
    let [regex, replacement] = SplitOnce(a:s, '/')
    let regex = Regexed(regex, boundary)
    return Mapped(a:lines, {line -> substitute(line, regex, {x -> Parser234(x, replacement)}, "g")})
endfunction

function! ReplaceOriginalFile()
    let current = CurrentFile()
    let name = Replace(current, "\\d+", "")
    ec name
    ec current
    call WriteFile(name, GetLines())
    call delete(fnameescape(current))
    execute "bd! " . current 
    execute "e! " . name

endfunction

function! ReplaceRange(a, b, s, ...)
    let boundary = a:0 == 1 ? a:1 : 0 
    let [regex, replacement] = SplitOnce(a:s, '/')
    let regex = Regexed(regex, boundary)

    for i in Ranger(a:a, a:b)
        call GetSet(i, {line -> substitute(line, regex, {x -> Parser234(x, replacement)}, "g")})
    endfor

endfunction

function! ReplaceSpaces(s)
    return Replace(a:s, ' ', '\\ ', 'g')
endfunction

function! ReplaceStart(input_string, replacement)
    let p = substitute(a:input_string, '^\s*\zs', a:replacement, '')
    echom p
    return p
endfunction

function! ReplaceWithinLine()
    let line = CurrentLine()
    let ch = GetChar() - 1
    ec ch
    ec line[ch]
    ec '---'
    return
    you can type whatever you want
    and you dont really need comments because the return key ends it.
    sdfsdfsdf
        sdfsdfsd
        destination = iterativesearch(item, options.get('destinations'), mode='values')
    let parts = split(line, ' = |, ')
    for part in parts
        if Test(part, '\(\w+$')
            continue
        elseif Test(part, '^\w+$')
            continue
        elseif Test(part, '\(\w+$')
            continue
        endif
    endfor
    "(foo, adfjasdkfal.asdfasdf[sdfadf])

    let rightindex = match(line, '\v[\]''"\}\)]\ze($|,)')
    let item = line[rightindex]
    let partner = GetCounterPart(item)
    let leftindex = rightindex - 1
    while 1
        if Test(line[leftindex], partner)
            if partner =~ ' '
                let leftindex += 1
                break
            elseif partner =~ '('
                ec 'hiii'
                let leftindex -= 1
                while 1
                    if Test(line[leftindex], ' |\(')
                        let leftindex += 1
                        break
                    else
                        let leftindex -= 1
                    endif
                endwhile
            endif
            break
        elif leftindex == 0
            break
        else
            let leftindex -= 1 
        endif
    endwhile

    let name = 'placeholder'
    
    let placeholder = line[leftindex:rightindex]
    let value = placeholder
    call AppendAbove(CreateVariable(name, value), 'move')
    call GetSet('.', {line -> Replace(line, Escape(value), name)})
endfunction

function! ReplaceWithinLine2()
    let foo = 'asdfasdfasdf'
    let ch = GetChar()
    let line = CurrentLine()
    let leftindex = ch
    let rightindex = ch + 3
    let match = 0
    while 1
        if leftindex == 0
            return
        elseif Test(line[leftindex], '\[|\(|\{|''|"')
            let match = Match(line[leftindex], '\[|\(|\{|''|"')
            let match = GetCounterPart(match)
            break
        else
            let leftindex -= 1
        endif
    endwhile
    while 1
        if line[rightindex] == match
            if line[rightindex + 1] == ','
                break
            endif
            break
        elseif rightindex > 200
            break
        else
            let rightindex += 1
        endif

    endwhile
    ec 'asdasdf'
    ec line
    ec line[rightindex]
    ec line[leftindex]
    let value = line[rightindex:leftindex]
    ec value
    ec 'hi'
    return
    let name = 'placeholder'
    call AppendAbove(CreateVariable(name, value))
    call GetSet('.', {line -> Replace(line, Escape(value), name)})
endfunction

function! ReplaceWordUnderCursor(replacement)
    let word = WordUnderCursor()
    execute '%s/\v<' . word . '>/' . a:replacement . '/g'
endfunction

function! Replacer(cmd)
    call ExecuteSelf('replacer.py', a:cmd)
endfunction

function! Rescape(s)
    let s = Sub(a:s, '\=', {x -> '\' . x[0]} )
    return Test(s, '^\v') ? s : '\v' . s
endfunction

function! ResetOld()
    let file = 'derived.py'
    call AppendFile(file, getline(1, '$'))
    execute "normal! :1,$d\<cr>"
    call WriteImportStatement()
    call cursor(100, 0)
endfunction

function! ResetToStandardBuffers()

    for buffer in GetVisibleBuffers()
        call CloseBuffer(buffer)
    endfor

    let lang = 'py'
    let standardbuffers = ['today', 'storage']
    let standardbuffers = map(standardbuffers, "~/CWF/" . 'v:val . "." . lang')

    for buffer in standardbuffers
        call OpenBuffer(buffer)
        if name =~ 'vimrc|utils|helpers|storage'
            call store(add, name)
        else
            execute 'bd ' name
        endif
    endfor
endfunction

function! Resetasd()
    normal 1,$d
    let a = 'from storage import *'
    let b = 'from shortcuts import *'
    let lines = [a,b,'', '', '']
    call setline('.', lines)
endfunction

function! Resetasdfasd()
    let file = 'derived.py'
    let store = []
    let lines = getline(1,'$')
    for i in range(0, len(lines) -1)
        let line = lines[i]
        if StartsWith(line, 'from')
            continue
        else
            call add(store, line)
            call DeleteLine(i)
        endif
    endfor
    call AppendFile(file, store)
    "call cursor(100, 0)
    "call OpenFile(file)
"
endfunction

function! ReshapeParameter(index)
   call GetSet(index, {s -> Replace(s, ', .+', ') {'})
   call cursor(index, RelativeLineChar(-2))
   return 
endfunction

function! ReverseSplit(s)
    let parts = split(Strip(a:s))
    if len(parts) == 0
        return ['', '']
    elseif len(parts) == 1
        return ['', parts[0]]
    else 
        return [join(parts[0:-2]), parts[-1]]
    endif
endfunction

function! RevertBufferGroup()
    execute ":wa"
    if Not(exists('g:buffergrouplist')) || len(g:buffergrouplist) == 0
        ec 'no buffergrouplist'
        return
    endif
    let currentbuffers = GetCurrentBuffers()
    call Iterate(currentbuffers, function('CloseBuffer'))
    let newbuffers = remove(g:buffergrouplist, -1)
    call Iterate(newbuffers, function('OpenBuffer'))
endfunction

function! Rpwo()
    let file = 'helpers.js'
    call ExecuteFile(file, CurrentFile())
endfunction

function! RpwoBlock()
    let destination = FileFix('rpwo.js')
    let indexes = GetCodeIndexes()
    let lines = GetLines(indexes)
    call DeleteBlock(indexes)
    call InvivoAppend(destination, lines)
endfunction

function! Rt()
    return
    let file = 'replacer.py'
    call Execute('replacer.py', Self() . ' ' . cmd)
    return

    let command = "normal! :!python3 replacer.py " . CurrentLine() . "\<cr>"
    ec command
    ec 'hii'
    execute command

    return
    "ec 'hi'
    return
  call AppendFile(Self(), ['"hi'])
  normal! :e<cr>gg
  echom 'done'
  return
  echom (5%2)
  echom (5%3)
  echom (5%4)
  return
  let failed = appendbufline(8, 0, "# THE START")
  echom failed
endfunction

function! RunFoo()
    !echo hiiiii
endfunction

function! InvivoJs()
    let file = 'np.js'
    execute "!clear;node " . file . ' ' . Tail()
endfunction

function! RunJS(...)
    w 
    let s = a:0 >= 1 ? a:1 : ''
    if Not(s)
        let s = GetVisualSelectionText()
        let s = EscapeTextForTerminal(s)
    endif
    let file = CurrentFile()
    let editorfile = 'edit.js'
    let cmd = editorfile . ' ' . file . ' ' . s
    ec cmd
    execute "!clear;node " . cmd
endfunction

function! RunMultipleTests(indexes, arg)
    "let fn = GetInput('fn name')
    let fn = a:arg
    call AppendIndexesAboveAndBelow(a:indexes, 's = `', '`.split(\'\n\').trim().map(' . fn . ').map(console.log)')
endfunction

function! RunPythonOrNode(...)
    let override = a:0 >= 1 ? a:1 : 0
    let file = CurrentFile()

    if Exists(override)
        execute "!clear;node " . file
        return 
    endif

    let name = Basename(file)
    let names = ['generate-multiple-choice.js', 'demo.js', 'raw.js', 'raw2.js', 'raw3.js']

    if Includes(name, names) && !Test(file, 'CWD')
        call Node('/home/kdog3682/CWD/jsa.js', CurrentFile())
        return 
    elseif name == 'lrt.js'
        call Node('/home/kdog3682/CWF/public/lrgen.js')
        return 

    elseif name == 'app2.js'
        call BasePY('gval')
    elseif Test(file, 'js\d*$')
        execute "!clear;node " . file
    elseif Test(file, 'py$')
        execute "!clear;python3 " . file
    elseif Test(file, 'sh$|\.bash')
        execute "!clear;bash " . file
    elseif Test(file, 'vim')
        call FunctionCaller()
    else
        call EditConnector('jsa')
    endif
endfunction

function! RunSelf(...)
    w 
    let s = a:0 >= 1 ? a:1 : ''
    if Not(s)
        let s = GetVisualSelectionText()
        let s = EscapeTextForTerminal(s)
    endif
    let file = CurrentFile()
    ec file
    let editorfile = 'edit.js'
    let cmd = file . ' ' . s
    "let cmd = editorfile . ' ' . file . ' ' . s
    ec cmd
    execute "!clear;node " . cmd
endfunction

function! SaveBackup0104()
    let cwf = "/mnt/chromeos/GoogleDrive/MyDrive/BACKUP/"
    let name = Replace(Tail(), '^\.', '')
    let outpath = cwf . name 
    call writefile(getline(1,'$'), outpath)
endfunction

function! SaveBackup()
    call writefile(getline(1,'$'), NameFile())
endfunction

function! SaveFileToList()
    call AppendFile('myfiles.txt', FileTail())
    ec ReadFile('myfiles.txt')
endfunction

function! SaveFunctionToList()
    let lang = FileLang()
    let fn = GetFunctionName()
    call ThrowGetter(lang, fn)
    let s = lang . ' ' . fn
    call AppendFile('myfunctions.txt', s)
    ec ReadFile('myfunctions.txt')
endfunction

function! SaveAllFilesToDateFolder()
    wa
    let s = '['. join(map(GetCurrentBuffers(), "'\\''' . (v:val) . '\\'''"), ',') . ']'
    call Python('pythonconnector.py', CurrentFile() . ' ' . 'endofday' . ' ' . s)
endfunction

function! SaveFilesToVim()
    
    let s = '['. join(map(GetCurrentBuffers(), "'''' . (v:val) . ''''"), ',') . ']'
    let s = 'let g:activefiles = ' . s
    call Append(s, '$')
endfunction

function! SaveAllFilesToDrive(dated)
    let s = '['. join(map(GetCurrentBuffers(), "'\\''' . (v:val) . '\\'''"), ',') . ']'
    call Python('pythonconnector.py', CurrentFile() . ' ' . 'saveToDrive' . ' ' . s)
endfunction

function! SaveToDrive()
    let dir = "/mnt/chromeos/GoogleDrive/MyDrive/"
    let name = expand('%:t')
    let outpath = dir . name
    echom outpath
    call writefile(getline(1,'$'), outpath)
endfunction

function! SaveToday()
    let s = '['. join(map(GetCurrentBuffers(), "'\\''' . (v:val) . '\\'''"), ',') . ']'
    call JspyConnector('savetoday', s)
endfunction

function! SaveToIndex()
    call WriteFile('index.html', readfile(ASDASHDKJHASKJDHAKJSK ajdhsfkasdj lasfksd
endfunction

function! SayHi(...)
    ec a:000
    ec 'saying hi!'
    return 'saying hi!'
endfunction

function! Search(r, ...)
    let flags     = a:0 >= 1 ? a:1 : ''
    let threshold = a:0 >= 2 ? a:2 : 0
    if flags =~ 'b'
        let threshold = threshold * -1
    endif
    return Exists(threshold) ? search(Regexed(a:r), flags, Relative(threshold)) : search(Regexed(a:r), flags)
endfunction

function! SearchBackwards(r, ...)
    let stopindex = a:0 == 1 ? CurrentIndex() - a:1 : 0 
    let p = search('\v' . a:r, 'bnW', stopindex)
    return p
endfunction

function! SearchBetween(lines, a, b)
    let firstindex = -100
    let secondindex = -1
    let store = []
    for i in Ranger(a:lines)
        let line = a:lines[i]
        if firstindex == -100
            if line =~ Regexed(a:a)
                let firstindex = i
                call add(store, line)
            endif
        else
            if line =~ Regexed(a:b)
                let secondindex = i
                if line =~ '\vendfunction|\}|\]'
                    call add(store, line)
                endif
                break
            else
                call add(store, line)
            endif
        endif
    endfor
    return store
endfunction

function! Self()
    return GetFile()
endfunction

function! SensitiveSearch(s)
    call NormalEnter('/\v' . '<' . a:s. '>')
endfunction

function! SetBookMarks(namespace)
    echom 'namespace: ' . a:namespace
    let comment = GetCommentDelimiter()
    let dict = {
        \ 'le': [
            \ 'lineedit4',
            \ 'run',
            \ 'on',
            \ 'getset',
        \ ]
    \ }
    let items = dict[a:namespace]
    let command = ''

    for item in items
        let command = 
        \ command . '/^ *' . '\/\/' . 
        \ a:namespace . '\.' . item . '\<cr>' . 'm' . item[0]
    endfor

    echom command
    echom 'calling'
    call ExecuteNormal(command)
    echom 'done'
    return

endfunction

function! SetBuffer(val)
    let b:buffer = a:val
endfunction

function! SetCurrentFileAsShuntDestination(...)
    let file = a:0 >= 1 ? FileGetter(a:1) : CurrentFile()
    let variable = a:0 >= 2 ? a:2 : 'shuntbuffer'
    if Not(file)
        let file = a:1
    endif
    if variable == 'shuntbuffer'
        let g:shuntbuffer = file

    elseif variable == 'debug'
        let g:debug = file
    endif
    ec 'Setting ' . variable . ' to element: ' . file
endfunction

function! SetCursor(cursorpos, ...)
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

function! SetGlobalVariable(s)
    let [key, value] = SplitOnce(a:s)
    call Exec("let g:" . key . " = " . Quotify(value))
endfunction

function! SetLastPosition()
    try
        ec g:lastposition
        ec b:lastposition
        let pos = b:lastposition
        call cursor(pos[1], pos[2])
    endtry
endfunction

function! SetLine(s)
   if Exists(a:s)
       call setline('.', a:s)
   endif
endfunction

function! SetLineWithSpaces(s)
    call setline('.', CurrentSpaces() . a:s)
endfunction

function! SetLines(lines)
    let spaces = CurrentSpaces()
    let lines = map(lines, {i, line -> spaces . line})
    call append('.', lines)
endfunction

function! SetLocalIAB()
    ec 'setting local iab'
    iab <buffer> cc currentComponent
endfunction

function! SetMark(mark, ...)
    let lineindex = a:0 >= 1 ? a:1 : line('.')
    call setpos("'" . a:mark, [0, lineindex, 0, 0])
endfunction

function! SetMarks()
    let query = 'const finishTemplate'
    let query = Rescape(query)
    ec query
    let index = search(query, 'bn')
    ec index
    if Exists(index)
        call SetMark('t', index)
    endif
    return 

endfunction

function! SetModeToGrab()
    let g:grabmode = g:grabmode ? 0 : 1
endfunction

function! SetOpenFileMode(s)
    let s = a:s
    let g:openfilemode = s
    ec 'setting the file to be opened as: ' . s
endfunction

function! SetAbsPos(n)
    call setpos('.', [0, a:n, 0, 0])
endfunction

function! SetPos(n)
    if IsArray(a:n)
        call setpos('.', [0, a:n[0], a:n[1], 0])
    else
        call setpos('.', [0, Relative(a:n), 0, 0])
    endif
endfunction

function! SetPosition(line, ...)
    let ch = a:0 >= 1 ? a:1 : 1000
    let relative = a:1 >= 2 ? a:2 : 0
    let line = Exists(relative) ? Relative(a:line) : a:line
    call setpos('.', [0, a:line, ch, 0])
endfunction

function! SetSearchContext(s)
    if Exists(a:s)
        ec 'Setting Search contect as: ' . a:s
        let b:searchcontext = a:s
    else
        let b:searchcontext = 0
    endif
endfunction

function! SetVariable(s)
    let variabledict = {
       \ 'cmt': 'currentMovementTarget',
       \ 'h': 'htmlfile',
       \ 'jsa': 'jsanywherefile',
    \}
    let namespace = 'g'
    let namespace .= ':'
    let s = EverythingToSlashes(a:s)
    let parts = split(s, '/')
    let length = len(parts)
    let variable = 'x'
    let value = 'abc'
    if length == 1
        let value = parts[0]
    elseif length == 2
        let [variable, value] = parts
    elseif length == 3
        let [variable, value, namespace] = parts
    endif

    let variable = get(variabledict, variable, variable)
    if parts[0] == 'cmt'
        let value = g:movementdict[value]
    endif

    "ec parts
    "ec value
    if Not(value)
        ec 'no value'
        return 
    endif
    let value = Quotify(value)
    let targetVar = namespace . variable

    if exists(targetVar)
        let command = "let " . targetVar . " = " . value
        ec command
        exec command
    else
        ec 'targetvar dont exist'
        ec targetVar
    endif
endfunction

function! SetVisualSelection(indexes)
     let [a,b] = a:indexes
     call cursor(a, 0)
     execute "normal! V" . (a - b - 1) . "\<down>"
     "call cursor(a, 0)
     "execute "normal! 3\<up>V3\<down>"
     "execute "normal! gv" . jump . "j"
endfunction

function! Setter(s)
    let [key, val] = SplitOnce(a:s)
    if key == 'lib'
        if !Test(val, 'lib$')
            let val .= '.lib'
        endif
        let g:fnlib = ReadJson(val)
        ec 'Setting g:fnlib to ' . val
    endif
endfunction

function! ShuntAndDelete()
    let indexes = GetCodeIndexes()
    let [a,b] = indexes
    let lines = GetLines(indexes)
    let destination = g:shuntbuffer
    call InvivoAppend(destination, lines)
    call deletebufline('%', a, b)
endfunction

function! ShuntAndGoTo(s)
    call ShuntManager(a:s)
    call ChooseBuffer(a:s)
endfunction

function! ShuntBlock(...)
    let destination = a:0 >= 1 ? a:1 : g:lastfile
    let deleteIt = a:0 >= 2 ? 1 : 0
    let indexes = GetCodeIndexes()
    let lines = GetLines(indexes)

    if deleteIt
        call deletebufline('%', indexes[0], indexes[1])
    endif
    call AppendFile(destination, lines)
endfunction

function! ShuntBlockToFile(indexes, ...)
    let indexes = a:indexes
    let destination = a:0 >= 1 ? a:1 : GetDestinationFromText(indexes)
    ec 'shunting to: ' . destination
    call AppendFile(destination, indexes)
    call DeleteBlock(indexes)
endfunction

function! ShuntCallsToBottom()
    let regex = '^(\(|console.log|print)|^const .{-} require'
    let base = line('$')
    let threefourth = base * 0.95
    let start = float2nr(round(threefourth))
    ec start
    let lines = getline(start, '$')
    for i in Ranger(lines)
        if Test(lines[i], regex)
            call setline(i + start, '')
            call append('$', lines[i])
        endif
    endfor

endfunction

function! ShuntFunction(...)
    let file = a:0 == 1 ? a:1 : '' 
    let file = FileGetter(file)
    let lines = GetFunction()
    if file =~ '.'
        call DeleteRange(range)
    endif
    call AppendLines(lines, file)
endfunction

function! ShuntLine()
    call append(1, getline('.'))
    call Normal('dd')
endfunction

function! ShuntManager(s)
    let [file, options] = ForceSplit(a:s, '/')
    let options = split(options, '\zs') 
    let gotobuffer = 0
    let keeprange = 0
    for option in options
        if option == 'd'
            let b:deleterange = 1
        elseif option == 'k'
            let keeprange = 1
        elseif option == 'g'
            let gotobuffer = 1
        endif
    endfor
    let file = FileGetter(file)
    let insertion = 0
    if Not(file)
        let insertion = GetLine()
        if IsConstant(insertion)
            let file = 'r.py'
        endif
    else
        let range = GetCodeIndexes()
        let insertion = GetLines(range)
        let lang = GetLang(file)
        let regex = '\v^ *(const|let) ' 
        if lang == 'py' && insertion[0] =~ regex
            let insertion[0] = Replace(insertion[0], regex, '')
        endif
    endif

    ec 'Shunting to file: ' . file
    call AppendLines(insertion, file)

    if Not(keeprange)
        call DeleteRange(range)
    endif

    if gotobuffer
        call OpenBuffer(file)
    endif
endfunction

function! ToText(arr)
    return join(a:arr, "\n")
endfunction

function! InferDestination(s)
    return 'archive'
    let lang = GetLang()
    let s = a:s
endfunction

function! ShuntAway(...)
    let lines = GetBlockDeleteBlock(GetShuntawayIndexes())
    call WriteNotes(lines)
endfunction

function! ShuntToD()
    let indexes = GetIndexesFromCurrentLineToBottom()
    let lines = Dedent(GetLines(indexes))
    let destination = 'd.txt'
    call DeleteBlock(indexes)
    call AppendFile(destination, lines)
endfunction

function! ShuntToPreviousBufferAndSwitchOver()
    
    let indexes = GetCodeIndexes()
    let lines = GetLines(indexes)
    call InvivoPrepend(destination, lines)
endfunction

function! ShuntToReddit()
    let store = []
    let start = 0
    let end = line('.')
    for i in range(start, end)
        call add(store, getline(i)
        call DeleteLine(i)
    endfor
endfunction

function! ShuntVisualSelectionToBuffer()
    let buffer = GetBuffer()
    let indexes = GetVisualIndexes()
    if indexes[0] == indexes[1]
        let indexes = GetCodeBlockIndexes()
    endif
    let lines = Dedent(GetLines(indexes))
    if buffer == 'today.py'
        call StringWrap(lines, GetLang(buffer))
    endif
    call ToBuffer(buffer, lines)
    call DeleteLines(indexes)
endfunction

function! Shuntdoesntwork(s)
   let dict = {
   \    'variables': SayHi,
   \ }
   echom dict
   echom a:s
   let Fn = get(dict, a:s, SayHi)
   let result = Fn()
   ec result
endfunction

function! Shuntnope(s)
    let key = a:s
    let destination = ''
    let lines = ''
    if key == 'variables' || key == 'v'
        let lines = MatchReplace('^\S+ =.*')
        let destination = 'r.py'
    endif

    call AppendFile(destination, lines)
endfunction

function! SimpleOpenBuffer(file)
    execute "e " . a:file 
endfunction

function! SimpleTrialify(s)
    let prefix = '() => '
    let suffix = ''
    return prefix . a:s . suffix
    return BeforeAndAfter(a:s, prefix, suffix)
endfunction

function! SlashSplit(s)
    return Force(split(a:s, '/'), 2)
endfunction

function! Slice(s, ...)
    let n = a:0 >= 1 ? a:1 : -1
    if n > 0
        return a:s[n:]
    endif
    return a:s[: -1 - n]
endfunction

function! Smallify(arr)
    if len(a:arr) == 1
        return a:arr[0]
    else
        return a:arr
    endif
endfunction

function! SmartAdd()
    let line = CurrentLine()

    let match = matchstr(line, "\\w*RE = '.\\{-\\}'")
    if Exists(match)
        let description = 'Internal regex variable Match. Shunting the variable to the top of the file. Replacing the internal regex content with empty string.'
        echom description 
        let regex = "'.\\{-\\}'"
        let product = substitute(line, 'RE\zs = ' . regex, '', '')
        call setline('.', product)
        let item = JSPY('variablePrefix') . match
        call AppendTop(item)
        return
    endif

    let name = GetOptionalSpacesVariableDeclaration(line)
    echom 'adsfasdf'
    echom name
    if Exists(name)
        if name == 'r'
            echom 'smart adding re.findall'
            " let arg = GetFunctionParameters(GetFunctionLine())
            let flags = '0'
            Appender('re.findall(r, s, flags=' . flags . ')')
        else
            echom 'smart adding console log info and return statement'
            Appender('echom ' . name)
            Appender('return ' . name)
            let r = 'adf'
        endif
    else
        return
    endif
endfunction

function! SmartAppend(i, v)
    let spaces = GetSpaces(getline(a:i))
    call append(a:i, spaces . a:v)
endfunction

function! SmartBlockIndexes()
    let upregex = '(function |def |class |\w+ \=)'
    let downregex = '^(const|function|class|def|endfunction| *}| *\])'
    let [upindex, downindex] = Sprawler(upregex, downregex)
    ec upindex
    ec downindex
    return [upindex, downindex]
endfunction

function! SmartComment()
    let extension = GetExtension()
    echom extension
    let line  = GetLine()
    let regex = '^ *\("\|//\|<!--\|#\)'
    let start = matchstr(line, regex)
    let dict = {'': '"', 'js': '//', 'py': '#'}
    let product = ''
    echom start
    if start
        let replacement = dict[extension]
        let regex = ' *\zs'
        let product = substitute(line, regex, replacement, '')
    else
        let replacement = ''
        let regex = '\(" \|// \|<!-- \|# \)'
        let product = substitute(line, regex, replacement, '')
    endif
    echom 'product'
    echom product
    call SetLine(product)
endfunction

function! SmartComplete ()
    " Remember where we parked...
    let cursorpos = getpos('.')
    let cursorcol = cursorpos[2]
    let curr_line = getline('.')

    let curr_pos_pat = '\%' . cursorcol . 'c'
    "ec curr_pos_pat
    "ec matchstr(curr_line, '\k' . curr_pos_pat)
    ec HuntForReplacement2()
    "ec hfraa bar eater
    return HuntForReplacement2()

    " Tab as usual at the left margin...
    if curr_line =~ '^\s*' . curr_pos_pat
        return "\<TAB>"
    endif

    " How to restore the cursor position...
    let cursor_back = "\<C-O>:call setpos('.'," . string(cursorpos) . ")\<CR>"

    " If a matching smart completion has been specified, use that...
    for [left, right, completion, restore] in s:completions
        let pattern = left . curr_pos_pat . right
        if curr_line =~ pattern
            " Code around bug in setpos() when used at EOL...
            if cursorcol == strlen(curr_line)+1 && strlen(completion)==1
                let cursor_back = "\<LEFT>"
            endif

            " Return the completion...
            return completion . (restore ? cursor_back : "")
        endif
    endfor

    " If no contextual match and after an identifier, do keyword completion...
    if curr_line =~ '\k' . curr_pos_pat
        return HuntForReplacement2()
    else
        return "\<TAB>"
    endif
endfunction

function! SmartConsoleLog()
    " let statement = CurrentSpaces() . GetLangItem('console', CurrentLineNumber()) 
    let statement = CurrentSpaces() . 'console.log(' . CurrentLineNumber() . ',  )'

    echom strlen(CurrentSpaces())
    call setline('.', statement)
    return
    if empty(CurrentLine())
        call setline('.', statement)
        call cursor(line('.'), strlen(CurrentLine()) - 1)
    else
        let length = strlen(GetLine(-1)) - 1
        call append(index, statement)
        call cursor(index - 1, length)
    endif

endfunction

function! SmartDedent(...)
    let input = 0 == 1 ? 1 : 0 
    if input
        let lines = input
        let indent = GetIndent(lines[0])
        if indent > 0
            let spaces = ToSpaces(indent)
            call map(lines, {i, line -> Replace(line, '^' . spaces, '')})
        endif
        return lines
    else
        let indexes = SmartBlockIndexes()
    endif
endfunction

function! SmartDittoSnippet()
    let r = '\w{5,}\ze\.'
    let match = MatchSearch(r, 'b', -5)
    return match
endfunction

function! SmartFix()
    let lang = GetLang()
    if lang == 'py'
        return
    else
        let [start, end] = GetVisualIndexes()
        let line = getline(start)
        let match = GetVariableDeclaration(line)
        echom match
        if NotExists(match)
            echom 'no exist'
            return
        else
            for i in range(start, end, 1)
                call setline(i, ReplaceStart(i, 'let '))
            endfor
        endif
    endif

endfunction

function! SmartIndent()
    let a = GetIndent(CurrentLine())
    let indexes = GetContiguousIndexesIBM()
    if a >= 8
        call GetSet(indexes, function('DedentLine'))

    else
        call GetSet(indexes, function('IndentLine'))
    endif
endfunction

function! SmartIndexFinder()
    let index = 
endfunction

function! SmartNav()
    ec 'hi'
endfunction

function! SmartOpen(...)
    let url = a:0 >= 1 ? InferUrlFromString(a:1) : InferUrlFromLocation()
endfunction

function! SmartShunt()
    let indexes = SmartBlockIndexes()
    let lines = GetLines(indexes)

    while 1
        if NoSymbols(lines[-1]) && GetIndent(lines[-1]) > GetIndent(lines[0])
            call remove(lines, -1)
        else
            break
        endif
    endwhile

    let dest = DetermineDestination(lines)
    if Exists(dest)
        call DeleteRange(indexes)
        call AppendFile(dest, lines)
        if dest == 'r.py'
            call NormalSub(GetName(lines[0]), 'r.' . name, 'b')
        endif
    endif
endfunction

function! SmartSpaces(...)
    let line = CurrentLine()
    let spaces = GetSpaces(line)
    if IsEnterBlock(line) 
        let spaces .= '    '
    endif
    return spaces
endfunction

function! SmartSplit(s, ...)
    let delimiter = a:0 >= 1 ? a:1 : '  '
    if Test(a:s, delimiter)
        return split(a:s, delimiter)
    else
        return SplitOnce(a:s, delimiter[0])
    endif
endfunction

function! SmartTextFix()
    let line = CurrentLine()
    let items = [
      \[  '\{\w+,? \w+.{-}\}', {t -> Sub(t[0], '\w+', {x -> Quotify(x[0]) . ': ' . x[0] .                (Test(t[0], ',') ? '' : ', ')      })}],
    \]

    "store.append({'id': id, 'question': question, 'choices': choices, 'answer': answer})

    if 1 || GetLang() == 'py'
        for [regex, Replacement] in items
            ec regex
            if Test(line, regex)
                ec 'hi'
                let product = Replace(line, regex, Replacement)
                ec product
                return setline('.', product)
            endif
        endfor
    endif

endfunction

function! SnippetMaker(snippet, ...)
    let suffix = a:0 >= 1 ? a:1 : '}'
    let noappend = a:0 >= 2 ? a:2 : 0
    let cursorpos = a:0 >= 3 ? a:3 : 0
    let suffix = IsString(a:snippet) && a:snippet =~ '{$' ? '}' : ''
    let lines = IsArray(a:snippet) ? a:snippet : split(a:snippet, "\n")
    if len(lines) == 1 && Not(noappend)
        call insert(lines, '    ', 1)
    endif
        
    if Exists(suffix)
        call add(lines, suffix)
    endif
    call TextPlacement(lines)
    if Exists(cursorpos)
        if IsArray(cursorpos)
            call cursor(cursorpos[0], cursorpos[1])
        else
            call cursor(line('.'), match(lines[0], '>') + 1)
        endif
    else
        call cursor(line('.') + 1, 100)
    endif
endfunction

function! SnippetManager(...)
    let s = a:0 == 1 ? a:1 : Strip(GetLine())
    let [rest, tag] = ReverseSplit(s)
    let lines = 0
    let dict = {
    \    'fori'  : [
    \ "for (let i = 0; i < "
    \  "    ",
    \ "}",
    \],
    \    'forkv'  : [
    \ "for (let [k, v] of Object.entries(dict)) {"
    \  "    ",
    \ "}",
    \],
    \    'argv'   : [
      \   'args = sys.argv[1:]' ,
    \],
    \    'issssss'   : [
      \  
      \  
    \],
    \    'isss'   : [
      \  "from storage import *",
      \  "import r",
      \  "import sys",
    \],
    \    'is'   : [
      \  "from storage import *",
      \  "import r",
      \  "import sys",
    \],
    \    'dots' : [
            \ "let placeholder = a:0 >= 1 ? a:1 : ", 
         \],
    \    'newp' : [
            \ "new Promise((res, rej) => {",
            \ "    ",
            \ "})",
         \],
    \    'dotss' : [
            \ "let placeholder = a:0 >= 1 ? a:1 : ", 
            \ "let placeholder = a:0 >= 2 ? a:2 : ",
         \]
    \ }

    let match = get(dict, tag)
    if Exists(match)
        let rest .= ''
        let match[0] = rest . match[0]
        let lines = match
    elseif tag == 'with'
        let lines = [
            \ 'class ' . name . ':',
            \ '    def __init__(self):',
            \ '    ',
            \ '    def __enter__(self):',
            \ '    ',
            \ '    def __exit__(self, *args):',
            \ '    ',
        \]
    elseif tag == 'class' 
        let lines = [
            \ 'class ' . name . ':',
            \ '    def __init__(self):',
            \ '    ',
        \]

    elseif tag == 'class' 
        let lines = [
            \ 'class ' . name . ':',
            \ '    def __init__(self):',
            \ '    ',
        \]
    endif
    return LineSet(lines)
endfunction

function! SnippetPlacer(snippet, spaces)
    let snippet = a:snippet
    let spaces = a:spaces
    let cursorpos = GetCursorFromStringSnippet(snippet)
    let snippet = Replace(snippet, '\$c', '')
    call TextPlacement(SplitLines(snippet), spaces)
    call SetCursor(cursorpos, spaces)
endfunction

function! SomeStuffBelow()
    return 0
    let downline = getline(Relative(1))
    return strlen(downline) > 3 && Not(Test(downline, '(function|def|class|const) '))
endfunction

function! SpaceAppend(s)
    call setline('.', CurrentSpaces() . a:s)
endfunction

function! SpaceMatch(s)
    let product = matchstr(a:s, '\S.*$')
    echom product
    return product
endfunction

function! LineSplit(s)
    return split(trim(a:s), "\n")
endfunction

function! SpaceSplit(s)
    return split(trim(a:s), ' \+')
endfunction

function! SpaceToSlash(s)
    let s = substitute(a:s, '/', ' ', '')
    return s
endfunction

function! SpaceWrap(lines)
    if IsArray(a:lines)
        call add(a:lines, '')
        call insert(a:lines, '')
    endif
    return a:lines
endfunction

function! SpecificFunctionShunter(...)
   let s = a:0 >= 1 ? a:1 : ''
   let lines = GetLines(GetCodeIndexes())
   let file = 'new' . '.' . GetLang()
   call InvivoAppend(file, lines)
endfunction

function! SplitChars(s)
    return split(a:s, '\zs')
endfunction

function! SplitLines(s)
    return split(a:s, "\n")
endfunction

function! SplitOnce(line, ...)
    if Not(a:line)
        return ['', '']
    endif
    if IsArray(a:line)
        return [a:line[0], a:line[1:]]
    endif
    let delimiter = a:0 >= 1 ? a:1 : ' '
    let reversed = a:0 >= 2 ? 1 : 0
    let parts = split(trim(a:line), delimiter)
    let length = len(parts)

    if reversed == 1
        let big = join(parts[0:-2], delimiter)
        let small = parts[-1]
        return [big, small]
    endif
    if length == 1
        let parts = split(a:line, '/')
        if len(parts) == 1
            return [parts[0], '']
        endif
    endif

    if len(parts) == 2
        return parts
    else
        return [parts[0], join(parts[1:], delimiter)]
    endif
endfunction

function! SprawlIndex(r, ...)
    let flags = a:0 >= 1 ? a:1 : 'bnW'
    if a:r == '^ *$' && trim(getline('.')) == ''
        return line('.')
    elseif Exists(matchstr(getline('.'), a:r))
        return line('.')
    else
        return search(a:r, flags)
    endif
endfunction

function! SprawlIndex2(r, ...)
    let forwards = a:0 >= 1 ? '' : 'b'
    let r = Regexed(a:r)

    if Exists(matchstr(getline('.'), r))
        return line('.')
    else
        let index = search(r, forwards . 'nW')
        return index
    endif
endfunction

function! SprawlLine(r)
    let index = SprawlIndex(a:r)
    return getline(index)
endfunction

function! SprawlLine2(r, ...)
    let threshold = a:0 >= 1 ? a:1 : 1000
    let r = Regexed(a:r)

    if Exists(matchstr(getline('.'), r))
        return getline('.')
    else
        "let index = search(r, 'bnW', Relative(threshold))
        let index = SearchUp(r)
        return getline(index)
    endif
endfunction

function! SprawlReplace(r, replacement, ...)
    let replacement = a:r
    let threshold = a:0 >= 1 ? a:1 : 1000
    let r = Regexed(a:r)

    if Exists(matchstr(getline('.'), r))
        call setline('.', Replace(getline('.'), r, replacement))
        return 1
    else
        let index = SearchUp(r)
        call setline(index, Replace(getline(index), r, replacement))
        return 1
    endif
endfunction

function! SprawlMatch(r, ...)
    let threshold = a:0 >= 1 ? a:1 : 1000
    return Match(SprawlLine2(a:r), a:r)
endfunction

function! SprawlToNearbyFunction()
    return
endfunction

function! Sprawler(upregex, downregex)
    let upindex = line('.') - 1
    let downindex = line('.') + 1
    while 1 
        let line = getline(upindex)
        let upmatch = Test(line, a:upregex)
        if Exists(upmatch)
            if Not(StartsWithSpace(line))
                break
            elseif EmptyNext(upindex, -1)
                break
            endif
        elseif DoubleEmpty(upindex, 'up')
            let upindex += 1
            break
        endif
        let upindex -= 1
    endwhile

    while 1
        let downmatch = Test(getline(downindex), a:downregex)
        if Exists(downmatch) 
            break
        elseif DoubleEmpty(downindex, 'down')
            let downindex -= 1
            break
        endif
        let downindex += 1
    endwhile
    return [upindex, downindex]
endfunction

function! SsdfSearch(s, r)
    let product = matchstr(a:s, a:r)
    " call Logger(product)
    return product
endfunction

function! StandardTemplater(s, parts)
    return Sub(a:s, '\$(\d+)', {s -> s[1] == '0' ? function('Quotify')(join(a:parts)) : function('Quotify')(a:parts[s[1]])})
endfunction

function! StartsWith(s, el)
    return a:s =~ '^' . a:el
endfunction

function! StartsWithSpace(s)
    return Test(a:s, '^ ')
endfunction

function! String(lines)
    return join(a:lines, "\n")
endfunction

function! StringFunc(name, ...)
    let rest = join(a:000, ', ')
    return a:name . Parens(rest)
endfunction

function! StringSurround(indexes)
    let sdelimiter = JSPY('sdelimiter')
    let a = 's = ' . sdelimiter 
    let b = sdelimiter
    call WrapChange(a:indexes, a, b)
endfunction

function! StringWrap(lines, lang)
    let a = a:lang == 'js' ? 's = `' : 's = \'\'\''
    let b = a:lang == 'js' ? '`': '\'\'\''
    call insert(lines, a)
    call add(lines, b)
endfunction

function! Stringify(s)
    let s = a:s
    "let s = {"a": 1, "b": 2}
    if IsArray(s)
        let s = join(s, "\n")
    endif 

    if IsObject(s)
        return json_encode(s)
    endif 
    return s
endfunction

function! Strip(input_string)
    return substitute(a:input_string, '^\s*\(.\{-}\)\s*$', '\1', '')
endfunction

function! StripEnd(input_string)
    return substitute(a:input_string, '\(.\{-}\)\s*$', '\1', '')
endfunction

function! StripLine()
    return trim(getline('.'))
endfunction

function! StyleShunt(s)
    let [name, val] = SplitOnce(a:s)
    let store = CssMaker(val)
    "let name = Match(CurrentLine(), "class: '\zs[\w-]+\ze'")
    "if Not(name)
        "let name = 'sam'
    "endif

    let store = Brackify('.' . name, store)
    ec store
    call AppendFile('styles2.css', store)
    
endfunction

function! Sub(s, regex, replacement)
    return substitute(a:s, Regexed(a:regex), a:replacement, 'g')
endfunction

function! SuperDollar(s)
    if IsNumber(a:s)
        return a:s
    return Quotify(a:s)
endfunction

function! SuperHelperHelper(s)
    let a = ''
    let b = ''
    if empty(a:s)
        return ''
    elseif Test(a:s, '\w+ \w+')
        let [a, b] = SplitOnce(a:s)
        if a == 'def'
            return a:s
        elseif a == 'args'
            let b = ArrayExpand(b)
        else
            let b = Quotify(b)
        endif
    elseif Test(a:s, '^\w+$')
        let a = a:s
        let b = 'True'
    elseif Test(a:s, '^\w+ \=')
        return a:s
    else
        let [tag, rest] = SplitOnce(a:s)
        if tag == 'regex'
            let a = tag
            let b = Quotify(rest)
        endif
    endif
    return 'h.' . a . ' = ' . b
endfunction

function! SuperObjectExpand(line)
   let parts = split(a:line, '  ')
   let parts = Mapped(parts, {s -> split(s, ' ')})
   let Parser = {part -> Quotify(part[0]) . ': ' . DollarReplace(part[1]) }
   let parts = Mapped(parts, Parser)
   return '{' . join(parts, ', ') . '}'
endfunction

function! SuperTemplater(spaces, key, dict, parts, line)
    let snippet = get(a:dict, a:key)
    if Not(snippet)
        return -1
    endif
    let regex = '\$(\{.{-}\}|\d+)'
    let Parser89 = {x -> function('PySnippetTemplater')(x, a:parts, trim(a:line))}
    let snippet = Sub(snippet, regex, Parser89)
    let cursorpos = GetCursorFromStringSnippet(snippet)
    let snippet = Replace(snippet, '\$c', '')
    call TextPlacement(SplitLines(snippet), a:spaces)
    call SetCursor(cursorpos, a:spaces)
endfunction

function! SwapVariables()
    return
endfunction

function! TabCompletion ()
    let dict = {
    \    'py': {
            \ 'i': ['import sys\nfrom storage import *', 'import boba'],
          \ },
    \    'vim': {
            \ 'i': ['import sys\nfrom storage import *', 'import boba'],
          \ }
    \ }

    let dict= {
        \ 'i': ['asdfmport sys\<CR>from storage import *', 'mport boba'],
    \ }

    let line = getline('.')
    let currentchar = GetChar()
    let pospat = '\%' . currentchar . 'c'

    if line =~ '^\s*' . pospat
        return "\<TAB>"
    endif

    let word = LastWord(line)
    let match = get(dict, word)

    if Exists(match)
        return Test(line, '^' . word . ' *$') ? match[0] : match[1]
    else
        return "\<TAB>"
    endif
endfunction

function! TagAndPartsAndLine(line)
    let parts = split(a:line, '\v(\=)@<! (\=)@!')
    if len(parts) == 1
        call add(parts, '')
    endif
    return [parts[0], parts[1:], join(parts[1:])]
endfunction

function! TemplateDitto(line, upline)
    let [line, upline] = [a:line, a:upline]
    let match = Match(upline, '\w+\ze \= ')
    if Not(match)
        let [match, line] = SplitOnce(line)
    endif

    let flags = 'g'
    let counter = 0
    let items = split(line)
    for item in items
        ec item
        let replacement = Parser233(upline, match, item, flags)
        if counter == 0
            call setline('.', replacement)
        else
            call append(Relative(counter - 1),  replacement)
        endif
        let counter += 1
    endfor
    call cursor(Relative(len(items) - 1), 100)
endfunction

function! R234234(x, ref)
    let x = a:x
    let ref = a:ref
    let a = x[1]
    let b = x[3]
    if !Exists(b)
        let val = ref[a - 1]
        return val
    endif

    let val = ''
    try
        let val = ref[a]
        if !Exists(val)
            let val = GetVal(b)
        endif
    catch
        let val = GetVal(b)
    endtry
    return val
endfunction

function! GetVal(x)
    let x = a:x
    if x == 'abrev'
        ec 'hi'
        return ToAbrev(GetFunctionName())
    elseif x == 'name'
        return GetFunctionName()
    endif
endfunction

function! RegistrarTemplater(template, val)
    let template = a:template
    let val = a:val
    let regex = '\$(\d+)(\|\$?(\w+))?'
    if IsString(val)
        let val = [val]
    endif
    return Sub(template, regex, {x-> function('R234234')(x, val)})
endfunction

function! Templater(template, val)
    if IsArray(a:val)
        return Replace(a:template, '\$(\d+)', {x -> a:val[x[1]]}, 'g')
    endif
    return Replace(a:template, '\$0', a:val, 'g')
endfunction

function! T(regex)
    return getline('.') =~ Regexed(Rescape3(a:regex) . '\c')
endfunction

function! Test(line, regex, ...)
    let I = a:0 >= 1 ? '\c' : ''
    return a:line =~ Regexed(a:regex . I)
endfunction

function! TestDocWithInput()
    
endfunction

function! TestFunction()
    let item = 'a'
    if exists('s:store')
        call add(s:store, item)
        echom s:store
    else
        let s:store = [item]
    endif
endfunction

function! TextDone()
    let s = '# ' . DateStamp() . ' ' . CurrentFile()
    "let s = '# ' . DateStamp() . ' ' . 'today.txt'
    let lines = GetLines()
    call DeleteLinesManually()
    call insert(lines, s, 1)
    AppendFile('mytextstore.txt', lines)
endfunction

function! TextGetter(a, b)
   let a = a:a
   let b = a:b
   return join(getbufline(bufnr('%'), a, b), "\n")
endfunction

function! TextPlacement(lines, ...)
    let spaces = a:0 >= 1 ? ToSpaces(a:1) : CurrentSpaces()
    
    let lines = map(a:lines, {pos, line -> spaces . line})
    call setline('.', lines[0])
    call append('.', lines[1:])
    if a:0 == 2
        ec 'calling cursor action'
        "call cursor(line('.') + len(lines) - 1, 100)
    endif
endfunction

function! TextSelect(s)
    let s = a:s
    let file = GetFile()
    let lang = GetLang()
    let args = DotSplit(s)

    if len(args) == 2
        let a = args[0]
        let b = args[1]
        echom a b
        if lang == 'vim'
            let ra = '^const __' . a
            let rb = b
            execute "normal! gg/" . ra . "\<cr>"
            " execute "normal! /" . rb . "\<cr>"
        endif

    else
        echo 'bye'
    endif

endfunction

function! TextSelect2()
    echom 'calling textslect'
    let lang = GetLang()
    let spaces = CurrentSpaces()
    let dict = {'vim': 'endfunction', 'js': '}', 'py': '\(def\)\@='}
    "normal <esc>?^\n\(function\\|def\\|class\)\@=<cr>O
    normal V/endfunction<cr>
    " execute '^V/endfunction<cr>'
    " execute 'normal ^V/^' . spaces . dict[lang] . '<cr>'
endfunction

function! ThisLine()
    return line('.')
endfunction

function! ThreeOrHash()
    return '3'
    if CurrentExtension() == 'txt' || CurrentExtension() == 'js'
        return '3'
    endif
    return GetChar() == 1 ? '#' : '3'
endfunction

function! ThrowGetter(...)
    for item in a:000
        if Not(item)
            throw 'no value @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@Item'
        endif
    endfor 
endfunction

function! TildaOrBreak()
    return GetChar() == 1 ? "###\n\n" : '`'
    return '3'
    if CurrentExtension() == 'txt' || CurrentExtension() == 'js'
        return '3'
    endif
endfunction

function! ToStringArray(...)
    let a = a:0 >= 1 ? a:1 : 0
    let b = a:0 >= 2 ? a:2 : 0
    let name = 0
    let items = 0

    if Exists(b)
        let name = a
        let items = b
    elseif IsArray(a)
        let name = 0
        let items = a
    elseif IsString(a)
        let [name, items] = SplitOnce(split(a, ' '))
    endif

    let quoted = map(items, {i, line -> IsNumber(line) ? line : "'" . line . "'"})
    let namePart = Exists(name) ? GetPrefix() . name . ' = ' : ''
    let payload = namePart . '[' . join(quoted, ', ') . ']'
    return payload 
endfunction

function! LineToArray(...)
    let a = a:0 >= 1 ? a:1 : 0
    let b = a:0 >= 2 ? a:2 : 0
    let name = 0
    let items = 0

    if Exists(b)
        let name = a
        let items = b
    elseif IsArray(a)
        let name = 0
        let items = a
    elseif IsString(a)
        let items = split(a, ' ')
    endif

    let quoted = map(items, 'IsNumber(v:val) ? v:val : SingleQuote(v:val)')
    ec quoted
    let payload = '[' . join(quoted, ', ') . '],'
    return payload 
endfunction

function! ToArray(s)
    let items = split(a:s, ' ')
    let name = items[0]
    let items = items[1:]
    let quoted = map(items, {i, line -> "'" . line . "'"})
    let result = GetPrefix() . name . ' = ' . '[' . join(items, ', ') . ']'
    ec result
    return result
endfunction

function! Indent2(s, i)
    let s = a:s
    let i = a:i
    return i . s
endfunction

function! ToArray2(s)
    return IsArray(a:s) ? a:s : [a:s]
endfunction

function! ToBuffer(buffer, lines)
    call writefile(a:lines, PathFix(a:buffer), 'a')
endfunction

function! ToClosingTag(word)
    return '</' . a:word . '>'
endfunction

function! ToDict(s)
    let items = split(trim(a:s), ' ')
    let name = items[0]
    let items = items[1:]
    let s = '{ '
    for i in range(0, len(items) - 1)
        if IsEven(i)
            let s .= Quotify(items[i])
        else
            let s .= ': ' . Quotify(items[i]) . ', '
        endif
    endfor
    let s .= ' }'

    let result = GetPrefix() . name . ' = ' . s
    ec result
    return result
endfunction

function! ToDictEntry(s)
    let [name, key] = ForceSplit(a:s, '/')
    let [start, end] = GetCodeIndexes(name)    
    let dictindex = search('\v\w+ = [\{\[]', '', end)
    if Not(dictindex)
        ec 'no dict'
        return
    endif
    call AppendBelow(dictindex, insertion)
endfunction

function! ToFunction(fn)
    return IsFunction(a:fn) ? fn : function(a:fn)
endfunction

function! ToInteger(x)
    return IsNumber(a:x) ? a:x : strlen(a:x)
endfunction


function! ToOpeningTag(word, ...)
    let attrs = a:0 >= 1 ? a:1 : ''
    if Not(attrs)
        let attrs = ''
    else
        let attrs = ' ' . attrs
    endif
    return '<' . a:word . attrs . '>'
endfunction

function! InsertLine(s)
    
endfunction

function! QCreateScript()
    call Append(Templater(g:pydict['webscript'], GetPasteBuffer()))
endfunction

function! GetPasteBuffer()
    return Sub(@", "\n", '')
endfunction

function! SetPasteBuffer(s)
    let s = ToString(a:s)
    let @" = s
endfunction

function! ToPasteBuffer(s)
    if Not(a:s)
        return 
    endif
    let s = ToString(a:s)
    let @" = s
endfunction

function! ToSpaces(n)
    if IsNumber(a:n)
        return repeat(' ', a:n)
    else
        return a:n
    endif
endfunction

function! Asdjflk()
    let prefix = JSPY('let')
    return prefix
endfunction

function! TextPlacement3(indexes, lines)

    let spaces =  GetSpaces(getline(a:indexes[0]))
    let index= a:indexes[0]
    let lines = Indent(ToLines(a:lines), spaces)
    let origlength = (a:indexes[1] - a:indexes[0])
    let length = len(lines) - origlength
    let a = lines[0:origlength]
    call setline(index, a)
    call append(index + origlength, lines[origlength +1:])

    return 
    return 
endfunction

function! LinesDictify(i)
    let lines = GetLines(a:i)
    let [prefix, slash] = JSPY('const', 'slash')
    let name = 'items'

    let s = prefix . name . " = {\n"

    for line in lines
        let [a,b] = SplitOnce(line)
        let s .= '    ' . slash . SingleQuote(a) . ': ' . SingleQuote(b) . ",\n"
    endfor

    let s .= slash . '}'

    call TextPlacement3(a:i, s)
endfunction

function! LinesNarray(i)
    let lines = GetLines(a:i)
    let [prefix, slash] = JSPY('const', 'slash')
    let name = 'items'

    let s = prefix . name . " = [\n"

    for line in lines
        let [a,b] = SplitOnce(line)
        let s .= '    ' . slash . '[' . SingleQuote(a) . ', ' . SingleQuote(b) . "],\n"
    endfor

    let s .= slash . ']'

    call TextPlacement3(a:i, s)
endfunction

function! ReturnDictify(s)
    let items = a:s
    let s = "return {\n"
    for item in items
        let s .= '    ' . SingleQuote(item) . ': ' . item . ",\n"
    endfor
    let s .= . '}'
    return s
endfunction

function! Dictify(s)
    let [name, rest] = SplitOnce(a:s)
    if name == 'return'
        return ReturnDictify(split(trim(a:s), ' '))
    endif
    let items = DictStringSplit(rest)
    ec items
    "let [name, items] = SplitOnce(IsString(a:s) ? DictStringSplit(a:s) : a:s)
    let [prefix, slash] = JSPY('const', 'slash')
    let s = prefix . name . " = {\n"

    if IsNestedArray(items)
        for [a,b] in items
            if Not(a)
                continue
            endif
            if !IsNumber(b)
                let b = Test(b, '/$') ? b[0:-2] : SingleQuote(b)
            endif
            let s .= '    ' . slash . SingleQuote(a) . ': ' . b . ",\n"
        endfor
    else
        for i in range(0, len(items) - 1, 2)
            let [a,b] = [items[i], items[i + 1]]
            if !IsNumber(b)
                let b = Test(b, '/$') ? b[0:-2] : SingleQuote(b)
            endif
            let s .= '    ' . slash . SingleQuote(a) . ': ' . b . ",\n"
        endfor
    endif
    let s .= slash . '}'
    return s
endfunction

function! VueDictify(s)
    "let s = 'class expr-a katex item ref expr-a delay 500 foobar booooo'
    let s = a:s
    "return 'booooo   ' . s
    "ec s
    "return
    let items = split(trim(s), ' ')
    let [prefix, slash] = JSPY('const', 'slash')
    let seenV = 0
    let t = ''
    let s = ''

            "if seenV == 0
                "let s .= '    ' . slash . "[\n"
            "endif

    for i in range(0, len(items) - 1, 2)
        let [a,b] = [items[i], items[i + 1]]
        if a == 'class'
            let s .= '    ' . slash . SingleQuote(a) . ': ' . SingleQuote(b) . ",\n"

        elseif a == 'click'
            let s .= '    ' . slash . SingleQuote(a) . ': ' . "(e) => " . b . "(this)" . ",\n"

        elseif a == 'ref'
            let s .= '    ' . slash . SingleQuote(a) . ': ' . SingleQuote(b) . ",\n"
            let s .= '    ' . slash . "'refInFor'" . ': ' . "true" . ",\n"
        elseif a == 'katex' || a == 'foobar' || a == 'asdfasdf' || a == 'zcxv'
            let t .= '        {name: ' . SingleQuote(a) . ", value: " . b . "},\n"

        elseif a == 'delay'
            let t .= '        {name: ' . "'appearance-delay'" . ", value: " . b . "},\n"
        endif
    endfor

    let ending = Exists(t) ? "    'directives': [\n" . t . "    ]\n}" : "\n}"
    let payload = prefix . 'options' . " = {\n" . s . ending
    return payload
endfunction

function! ToString(lines)
    if IsString(a:lines) 
        return a:lines
    else
        return join(a:lines, "\n")
    endif
endfunction

function! ToTestTextFile(indexes)
    call AppendFile('test.txt', a:indexes)
endfunction

function! ToWorkspace(indexes)
    let file = 'workspace.txt'
    let lines = GetLines(a:indexes)
    call AppendFile(file, lines)
    call deletebufline('%', a:indexes[0], a:indexes[1])
endfunction

function! ToggleBufferWithinDirectory()
    let dir = GetCurrentDir()    
    let file = CurrentFile()
    let files = Filtered(Absdir(dir), '(js|html)$')
    ec files
    let index = 0
    for i in Ranger(files)
       if Basename(files[i]) == Basename(file)
           let index = i + 1
           if index >= len(files)
               let index = 0
           endif
            call OpenBuffer(files[index])
           break
        endif
    endfor
endfunction

function! ToggleComment()

    let go = 0
    if go != 0 && exists('b:linerunstore') && Exists(b:linerunstore)
        let comment = JSPY('comment')
        let comment = '# '
        for index in b:linerunstore
            call GetSet(index, {line -> comment . line})
        endfor
        unlet b:linerunstore
        return
    endif

    call LineRun(r, {line -> Replace(line, r, '')})
    return

endfunction

function! ToggleKeyBindings()
    execute ''
endfunction

function! ToggleKeyMap()
    echom 'toggle keymap'
    let extension = GetExtension()
    if extension == 'js'
        echom 'Toggling extension for : ' . extension
        :iab if if( )<left><left>
        :iab elif else if( )<left><left>
        :iab and &&
        :iab or \|\|
    else
        echom removing keymaps
        try
            :una if
        endtry
        try
            :una elif 
        endtry

        try
            :una and 
        endtry

        try
            :una or 
        endtry
    endif
endfunction

function! ToggleLibraries()
    try
        call ExecuteReplace('^const (fs|jshint)', '\/\/ \0')
    catch
        try
            call ExecuteReplace('^\/\/ ?\zeconst (fs|jshint)', '\/\/ ')
        catch
            return 
            call ExecuteReplace('\/\/ ?\zeconst (fs|jshint)', '')
        endtry
    endtry
endfunction

function! TopComment()
    let s = CommentLine(GetDate())
    call AppendTop(s, 1)

endfunction

function! TrackedLog()
    let Fn = {s -> Consoler(s . ', ' . '"' . s . '"')}
    "let Fn = {s -> s}
    "Let Gn = {s -> split(s, ' ')}
    call GetSetLine(Fn)
endfunction

function! Tradfialify(indexes)

    let prefix = 'trial( () => '
    let suffix = ' )'
    call GetSetLines(a:indexes, {s -> function('BeforeAndAfter')(s, before, after)})
endfunction

function! TransformDict(key)
    let key = a:key
   let lines = GetLines(GetDictIndexes())
   let lines[0] = '{'
   let s = join(lines)
   let dict = js_decode(s)
   "for [k,v] in get(dict, key)
       "store[k][key] = v

   ec dict
endfunction

function! Trial2(indexes)
    let spaces = GetSpaces(getline(a:indexes[0]))
    let icount = 0
    let store = []
    let lines = GetLines(a:indexes)
    for line in lines
        call add(store, spaces . '    ' . Quotify(trim(line))  . ',' )
        call add(store, spaces . '    ' . SimpleTrialify(trim(line)) . ',' )
    endfor
    call add(store, spaces . ')')
    call insert(store, spaces . 'trial(')

    for i in Ranger(a:indexes)
       call deletebufline('%', a:indexes[0])
    endfor

    call append(a:indexes[0] - 1, store)

endfunction

function! Trialify(s)
    let prefix = 'trial(() => '
    let suffix = ')'
    return prefix . a:s . suffix

    "let suffix = ', ' . Quotify(a:s) . ' )'
    return BeforeAndAfter(a:s, prefix, suffix)
endfunction

function! TrimWhiteSpace()
    execute "normal! :%s\/\nfooyum\/perk\<cr>"
endfunction

function! TryCatcher(indexes)
    let [a,b] = a:indexes
    let [stry, scatch] = JSPY('stry', 'scatch')
    let spaces = GetSpaces(getline(a))

    call IndentAll([a,b])
    call append(a - 1, spaces . stry)
    call append(b + 1, IndentAll(scatch, spaces))
    call cursor(b + 3, 100)
endfunction

function! SemiOrColon()
    return ':'
    return GetChar() == 1 && GetLang() == 'js' ? '@' : '2'
    return '2'
    if CurrentExtension() == 'txt'
        return '2'
    endif
endfunction

function! TwoOrAt()
    return GetChar() == 1 && GetLang() == 'js' ? '@' : '2'
    return '2'
    if CurrentExtension() == 'txt'
        return '2'
    endif
endfunction

function! UnCommentLine(...)
    let index = a:0 >= 1 ? a:1 : '.'
    let regex = '^ *\zs\("\|//\|<!--\|#\) *'
    call GetSet(index, {line -> substitute(line, regex, '', 'g')})
endfunction

function! Uncapitalize(s)
    return tolower(a:s[0]) . a:s[1:]
endfunction

function! UndoYeet()
    let index = SprawlIndex('^yeet')
    call DeleteLine(index)
    let index = SprawlIndex('^`')
    call DeleteLine(index)
endfunction

function! UndoYeetFunction(...)
    let name = a:0 >= 1 ? a:1 : 'yeetfn'
    let indexes = GetIndexes2()
    let lines = GetLines(indexes)
    let s = ToString(lines)
    let s = Replace(s, 'yeet', 's')
    let s = Replace(s, 'console.log\(', 'return ')
    let payload = 'function ' . name . "(s) {\n" . Indent(s)[0:-1] . "\n}"
    call ReplaceIndexes(indexes, payload)
    return 
endfunction

function! Unquoted(s)
    return a:s !~ '^[''"]'
endfunction

function! UpLine()
    let c = 1
    while 1
        let line = getline(line('.') - c)
        let c += 1
        if Exists(line)
            return line
        endif
    endwhile

endfunction

function! UseHelper(s)
    let s = a:s
    if Test(s, 'fetch')
        return "const fetch = require('node-fetch')"
    elseif Test(s, 'fs') 
        return "const fs = require('fs')"
    elseif Test(s, 'css$')
        return '<link rel="stylesheet" type="text/css" href="./' . s . '" />'
    elseif Test(s, 'style')
        return '<link rel="stylesheet" type="text/css" href="./styles.css" />'
    else
        return '<script src="' . s . '"></script>'
    endif
endfunction

function! VariableManager(val)
    let b:buffer = a:val
    echom 'setting shunt buffer to ' . a:val
endfunction

function! Varialize(indexes)
    function Parser(s)
        
    endfunction
    call GetSetLines(a:indexes, function('Parser'))
    
endfunction

function! Vim()
    return '/home/kdog3682/.vimrc'
endfunction

function! VimChromeBookmarks(s)
   if !exists('g:bookmarkdict')
       let g:bookmarkdict = ReadJson('vimbookmarks.json')
    endif
      let bookmark = g:bookmarkdict[a:s]
      execute "!xdg-open " . bookmark
endfunction

function! VimrcFunctionManager(x)
    if a:x =~ 'cap'
        normal :%s/\(^function\)\(\w*\)/<\U\1/g<cr>
    endif
endfunction

function! VisualQuotify(indexes)
    call GetSetLines(a:indexes, function('QuoteRunner'))
endfunction

function! VisualSelect(indexes)
     let [a,b] = a:indexes
     call cursor(a, 0)
     execute "normal! V" . (a - b - 1) . "\<down>"
     "execute "normal! 3\<up>V3\<down>"
     "execute "normal! gv" . jump . "j"

endfunction

function! VueFix()
    let options = ''
    let cmd = GetInput('Vue Fix: ' . options)
    let [spaces, line] = GetSpacesAndLine()
    let foo = ''
    let bar = ''
    if cmd == 't'
        let foo = '<transition name="fade" mode="out-in">'
        let bar = '</transition>'
    elseif cmd == 'k'
        let foo = '<keep-alive>'
        let bar = '</keep-alive>'
    endif

    call WrapChange(line('.'), spaces . foo, spaces .  bar)
    call setline('.', spaces . '    ' . line)
endfunction

function! VueManager(s)
   let dict = {
   \    'm': 'ShuntToMounted,
   \    'f': 'ShuntToMethods,
   \    'c': 'ShuntToComputed,
   \    'd': 'ShuntToData',
   \ }

   let match = get(dict, key)
   let indexes = GetVueIndexes()
   let s = ''
   if !empty(match)
       let s = function(match)(indexes)
   endif

   if !empty(s)
       call move it
   endif
endfunction

function! WhereAmI()
    ec GetFunctionLine()
endfunction

function! Whereami()
    let dir = getcwd()
    let filedir = expand('%:h')
    ec filedir
endfunction


function! WordUnderCursor()
    let word = CurrentWord()
    if strlen(word) == 1
        call setpos('.', CharPos(-1))
        let word = CurrentWord()
    endif
    return word

endfunction

function! WrapLines(lines)
    let delimiter = join([Repeat('-', 20), DateStamp(), CurrentFile(), GetLang()], ' ')
    call insert(a:lines, delimiter, 0)
endfunction

function! Wrap()
    let d = JSPY('stringdelimiter')
    let indexes = GetContiguousIndexes()
    call add(lines, d)
    call insert(lines, d)
endfunction

function! WrapChange(indexes, a, b)
    let a = a:a
    let b = a:b
    let [top, bottom] = IsNumber(a:indexes) ? [a:indexes, a:indexes] : a:indexes
    call append(top - 1, a)
    call append(bottom + 1, b)
endfunction

function! WriteCommentInfoBelowLine(...)
    let lang = GetLang()
    let val = a:0 == 1 ? a:1 : 0
    let [prefix, suffix] = JSPY('commentPrefix', 'commentSuffix')

    if empty(val)
        let line  = CurrentLine()
        let spaces = SmartSpaces()
        let product = spaces . prefix . 'CommentInfo: ' . suffix 
        call append('.', product)
        call SetCursor(Relative(1), 1000)
    else
        return prefix . val . suffix
    endif
endfunction

function! WriteConsoleLog()
    let Fn = JSPY('consolefn')
    let s = Fn('')
    call SetLineWithSpaces(s)
endfunction

function! WriteDebugMessage()
    let message = '/* ' . toupper(g:debug) . ' */  '
    call ReplaceLine(line('.'), '^ *\zs', message)
endfunction

function! WriteImportStatement()
    call setline('.', ['from storage import *', 'from shortcuts import *', '', ''])
endfunction

function! WriteImports(file)
    if !filereadable(a:file)
        let mode = 'w'
    endif

    let lines = [
        \ 'from storage import *',
        \ '',
    \]
    if a:file =~ 'script$'
        call add(lines, 'import sys')
    endif
    call WriteFile(a:file, lines)
endfunction

function! WriteJson(file, data)
    let encoded = json_encode(a:data)
    call writefile(split(encoded, "\n"), a:file, 'w')
endfunction

function! WriteCodeNotes(s, ...)
    "let outpath = a:0 >= 1 ? a:1 : 'codingnotes.txt'
    let outpath = a:0 >= 1 ? a:1 : 'code-review.txt'
    let date = DateStamp()
    let file = CurrentFile()
    let location = Match(GetFunctionLine(), '^\w+ \zs\w+')
    let block = Dedent(GetCurrentBlock())
    let text = a:s

    "let s = join([date, file, location], ' ')
    "let lines = [s]
    let lines = []
    call add(lines, g:linebreak)
    call add(lines, date)
    call add(lines, file)
    call add(lines, location)
    call add(lines, '')
    "call add(lines, '@snippet')
    call extend(lines, block)
    call add(lines, '')
    "call add(lines, '@notes')
    let text = ":: " . text
    call add(lines, text)
    call add(lines, '')
    call add(lines, '')
    ec lines
    return 

    call AppendFile(outpath, lines)
endfunction

function! WriteCodeReviewNotes(s, ...)
    let outpath = a:0 >= 1 ? a:1 : 'code-review.txt'
    let date = DateStamp()
    let file = CurrentFile()
    let location = Match(GetFunctionLine(), '^\w+ \zs\w+')
    let block = Dedent(GetCurrentBlock())
    let text = a:s

    let lines = []
    call add(lines, g:linebreak)
    call add(lines, date)
    call add(lines, file)
    call add(lines, location)
    call add(lines, '')
    call extend(lines, block)
    call add(lines, '')
    let text = ":: " . text
    call add(lines, text)
    call add(lines, '')
    call add(lines, '')
    call AppendFile(outpath, lines)
endfunction

function! GoBackUntilNotThisFileOrAlternateFile()
    let current = Basename(bufname('%'))
    let alternate = Basename(bufname('#'))
    let c = -1
    while c < 10
        let c += 1
        let file = Basename(jumplistfiles[c])
        if file != current || file != alternate
            return file
        endif
    endif
endfunction

function! Typed(s)
    if Test(CurrentFile(), '_\w+_')
        return 'file-help'
    endif

    if Test(a:s, '^doc ')
        return 'doc'
    endif

    if Test(a:s, '^h ')
        return 'help'
    endif

    if Test(a:s, '^\S{-}\)$')
        return 'callable'
    endif

    if Test(a:s, '\<\w')
        return 'html'
    endif
endfunction

function! FunctionalTemplaterParser(s, ref)
    let s = a:s
    let ref = a:ref

    if s == 'file' || s == 'bf' || s == 'tail'
        return Replace(Tail(), '^\W+', '')
    elseif s == 'parent'
        return GetCodeName()
    elseif s == 'function'
        return GetBindingName()
    elseif s == 'binding'
        return GetCurrentBinding()
    elseif s == 'fn'
        return Match(CurrentLine(), '\w+\ze\(')
    elseif s == 'ds'
        return DateStamp()
    elseif s == 'fnp'
        return Match(CurrentLine(), '\w+\ze\(.{-}\)')
    elseif s == 'ds'
        return 
    elseif s == 'ds'
        return 
    elseif s == 'ds'
        return 
    elseif s == 'ds'
        return 
    elseif s == 'ds'
        return 
    else
        return IsArray(ref) ? ref[s] : ref
    endif

endfunction

function! FunctionalTemplater(template, ref)
    return Sub(a:template, '\$(\w+)', {s -> function('FunctionalTemplaterParser')(s[1], a:ref)})
endfunction

function! NoteMaster(key, s)
    let key = a:key
    let s = a:s
    let [destination, template, announce] = get(g:noteRef, key)
    let payload = FunctionalTemplater(template, s)
    if announce
        ec payload
    endif
    call AppendFile(destination, payload)
endfunction

function! GetD(ref, key)
    return get(a:ref, a:key, a:ref.DEFAULT)
endfunction


function! WriteNotes(s, ...)
    let s = IsArray(a:s) ? join(a:s, "\n") : a:s
    let k = len(s) > 5 ? Typed(s) : s
    let [destination, template, announce] = GetD(g:noteRef, k)
    let payload = FunctionalTemplater(template, s)
    call Announcement(payload, announce)
    call AppendFile(destination, payload)
endfunction

function! WriteVimIab(s)
    let cmd = 'iab ' . a:s
    AppendFile('~/.vimrc', cmd, 0)
endfunction

function! XXXGetLangItem(target, ...)
    let phrase = a:0 >= 1 ? a:1 : ''
    let lang = GetLang()
    let dict = {
        \ 'js': {
            \ 'console': 'console.log',
        \ }, 
        \ 'vim': {
            \ 'console': '"print',
        \ },

        \ 'py': {
            \ 'console': 'print',
        \ }
    \}
    let start = dict[lang][target] 
    if exists(phrase) 
        return start . '(' . phrase . ')'
    else
        return start
    endif
endfunction

function! XdgOpen(file)
    execute "!xdg-open " . a:file
endfunction

function! SourceFile(...)
    let file = a:0 >= 1 ? a:1 : CurrentFile()
    execute "source " . file
    "execute "source " . '/home/kdog3682/.vimrc'
endfunction

function! SourceVim()
    let line = getbufline('/home/kdog3682/.vimrc', '$')[0]
    execute line
    echo 'sourcing vim via exec'
endfunction

function! Zoop(...)
    let key = a:0 >= 1 ? a:1 :  'foo'
    let caretM = '
'
    let lines = DedentLines(GetLines(GetCodeIndexes()))
    let s = join(lines, caretM)
    call CreateIab(key . ' ' . s)
endfunction

function! GetActiveBuffers()
    let l:blist = getbufinfo({'bufloaded': 1, 'buflisted': 1})
    let l:result = []
    for l:item in l:blist
        "skip unnamed buffers; also skip hidden buffers?
        if empty(l:item.name) || l:item.hidden
            continue
        endif
        call add(l:result, shellescape(l:item.name))
    endfor
    return l:result
endfunction

function! Help2()
    ec join(readfile('help.js'), "\n")
endfunction

function! SendCursorToLineEditor(...)
    let arg = a:0 >= 1 ? a:1 :  ''
    call RunEditJS('rangeEdit', line('.') - 1, EscapeTerminalText(arg))
endfunction

function! SendWindowToLineEditor(...)
    let arg = a:0 >= 1 ? a:1 :  ''
    call RunEditJS('rangeEdit', GetWindowRange(), EscapeTerminalText(arg))
endfunction

function! TestFoo(i, arg)
    ec a
endfunction

function! Repeat(s, n)
    return repeat(a:s, a:n)
endfunction

function! IsQuoted(s)
    return Test(a:s, '^"|''')
endfunction

function! IsLineStart(x)
    return Test(a:x, '^\S')
endfunction

function! FindFunctionUp()
    ?^\(function\|def\|class\)
endfunction

function! ResetGVariable(key)
    execute "unlet " . a:key
endfunction

function! GetVariableName(s)
    return Match(a:s, '\w*\ze\(')
endfunction

function! Append2(n, line)
    let lines = ToArray2(a:line)
    call add(lines, '')
    call add(lines, '')
    call append(a:n - 1, lines)
endfunction

function! ToArray3(s)
    return IsString(a:s) ? [a:s] : a:s
endfunction

function! KeyAndRest(s, ...)
    let delimiter = a:0 >= 1 ? a:1 : ' '
    let items = split(a:s, delimiter)
    return [items[0], items[1:]]
endfunction

function! Cursor2(x)
    if IsNumber(a:x)
        call cursor(line('.') + a:x, 0)
    endif
endfunction

function! FindNextUpLine()
    call cursor(line('.') - 1, 100)
    let value = SprawlLine3('\w', 'bn')
    call cursor(line('.') + 1, 100)
    return value
endfunction

function! Echo(...)
    ec 'ECHO START'
    ec '-----------'
    for item in a:000
        ec item
        ec '-----------'
    endfor
    ec 'ECHO END'
endfunction

function! FullTimeStamp()
    return join([DateStamp(), ClockStamp()], ' ')
endfunction

function! LiteralCommentBlock(...)
    let statement = "${FullTimeStamp()}"
    let line = '    ' . repeat('-', 50) . "\n"
    return "/*  " . statement . "\n" . line . "    $c\n" . line . "*/"
endfunction

function! CommentBlock(...)
    let statement = "${FullTimeStamp()}"
    let line = '    ' . repeat('-', 44) . "\n"
    return "/*  " . statement . "\n" . line . "    $c\n" . line . "*/"
endfunction

function! SaveCurrentFileAndOpenHtmlFile()
    call SaveFile(CurrentFile())
    !xdg-open 10-29-2021.html
endfunction

function! FunctionBlockLines(name)
    let lines = ['function ' . a:name . '()', '', 'endfunction']
    return lines
endfunction


function! LastChar(...)
    let n = a:0 >= 1 ? a:1 : 2
    return CurrentLine()[col('.') - n]
endfunction

function! Zommba()
    ec LastChar()
    ec LastChar() == '\\\\'
endfunction

function! GoVim(key)
    let key = a:key
    call Mark('Z')
    call OpenBuffer('/home/kdog3682/.vimrc')
    call ExecuteFunctionSearch(key)
endfunction

function! QuoteOrDoubleQuote()
    let ref = {
        \'js': '//',
        \'py': '#',
        \'css': '/* */',
        \'vimrc': '"',
        \'': '"',
    \}

    if IsStartOfLine() == 1 
        return ref[GetExtension()] . ' '
    endif

    let [a,b] = InfrontAndBehindOfCursor()
    if !Exists(b)
        return "''\<LEFT>"
    elseif IsLetter(a) || Exists(b)
        return "\'"
    else
        return "''\<LEFT>"
    endif

endfunction

function! OldQuoteOrDoubleQuote()
    let ref = {
        \'js': '//',
        \'py': '#',
        \'css': '/* */',
        \'vimrc': '"',
        \'': '"',
    \}
    if LastChar(1) == "\\"
        return '\'''sdf'  
    endif
    return IsStartOfLine() == 1 ? ref[GetExtension()] . ' ' : "''\<LEFT>"
    return IsStartOfLine() == 1 ? ref[GetExtension()] . ' ' : "''\<LEFT>"
endfunction

function! IfMaker(x)
    let prefix = "("
    let suffix = ")"
    let rest = " {\n    $c\n}"
    let rest = " $c"
    return "if " . prefix . a:x . "($1)" . suffix . rest
endfunction

function! GoStart()
    call SetCursor('$')
    call SprawlIndex3('^["/#]' . DateStamp())
endfunction

function! RunAddToBottomThenCall()
    call SetCursor('$')
    let name = GetFunctionName()
    call append('$', ['', '', name . '()'])
    call RunPythonOrNode()
    call deleteline('$')
endfunction

function! FirstWord2(...)
    let line = a:0 >= 1 ? a:1 : CurrentLine()
    return Match(line, '\w+')
endfunction

function! ZoopbarFnName(a, b, ...)
    let mode = a:0 >= 1 ? a:1 : ''
    let a = a:a
    let b = a:b
    return a . '(' . b . ')'
endfunction

function! SprawlLine3(r, ...)
    let flags = a:0 >= 1 ? a:1 : ''
    return getline(SprawlIndex3(a:r, flags))
endfunction

function! SprawlIndex3(r, ...)
    let flags = a:0 >= 1 ? a:1 : ''
    let r = Regexed(a:r)
    let index = line('.')
    if Test(CurrentLine(), a:r)
        return index
    endif
    return search(r, flags)
endfunction

function! GetCurrentBlockIndexes()
    "let upRE = '^  {-}"?(get |set )?\w+\(.{-}\) {-}\{ {-}$|(((async )?function|def|let|class|const).{-}[\{\[] {-}$)'
    let upRE = '\{ *$'

    "let upRE = "((async )?function|def|let|class|const).{-}[\{\[] {-}$"
    let upindex = SprawlIndex3(upRE, 'b')
    let spaces = GetSpaces(getline(upindex))
    let downRE = "^" . spaces . "\"?\\\\?[\]\}]"
    let downindex = SprawlIndex3(downRE, 'n')
    ec upindex
    ec downindex 
    return [upindex, downindex]
endfunction

function! DeleteCurrentBlock()
    let indexes = GetCurrentBlockIndexes()
    let lines = GetLines(indexes)
    ec indexes
    call DeleteBlock(indexes)
    call ToPasteBuffer(ToString(lines))
endfunction

function! GetCurrentBlock()
    let lines = GetLines(GetCurrentBlockIndexes())
    call ToPasteBuffer(ToString(lines))
    return lines

endfunction

function! LastCommand()
    if g:lcs=='jspy'
    call JspyConnector(trim(g:lastCommand))
    elseif Exists(g:lastkey)
    call SafeGuard(g:lastkey)
    call LeaderManager(g:lastkey)
    endif
endfunction

function! GetWords2(...)
    let s = a:0 >= 1 ? a:1 : CurrentLine()
    return FindallStrings(s, '\w+')
endfunction

function! TrimEnd(s)
    return Replace(a:s, ' {-}$', '')
endfunction

function! GetShuntIndex()
    let lang = GetLang()
    ec lang
    
endfunction

function! ZoopBarInfer(key)
    let k = trim(a:key)
    return get(g:zoopbarfndict, k)()
endfunction

function! ObjectAssign(a, b)
    return extend(copy(a:a), a:b)
endfunction

function! Aliased(s)
    let dict = {
        \ 'o': 'Object',
        \ 'obj': 'Object,
        \ 'object': 'Object,
    \}

    return get(dict, a:s, a:s)
endfunction

function! Ncg2(items)
    let items = IsObject(a:items) ? keys(a:items) : a:items

    let regex = '(' . join(items, '|') . ')'
    return regex
endfunction

function! ZoopbarNew(s, ...)
    let mode = a:0 >= 1 ? a:1 : '' 
    if mode == 'start'
        let regex = '^' . Ncg2(g:zoopbarwords) . '\zs'
        let [a, b] = split(a:s, Regexed(regex))
        let a = Capitalize(a)
        let b = Aliased(b)
        return a . b

        "return join(map(split(a:s, Regexed(regex)), 'Capitalize(v:val)'), '')
    else
        let regex = '^' . Ncg2(g:zoopbarwords) . '\zs'
        let [a, b] = split(a:s, Regexed(regex))
        return a . Capitalize(b) . Parens(b)
    endif
endfunction

function! GetWords()
    let wordsRE = '\w+'
    let words = Shared(FindallStrings(line, wordsRE), names)
    ec words
    return words
endfunction

function! EnterBlockExpression2()
    let start = CurrentLine() =~ " $" ? "" : " "
    let obj  = "{\<esc>o},\<esc>\<s-o>"
    let objcomma  = "{\<esc>o})\<esc>\<s-o>"
    let norm = "{\<esc>o}\<esc>\<s-o>"
    let arr = "[\<esc>o]\<esc>\<s-o>"
    let par = "{\<esc>o})\<esc>\<s-o>"
    let fn = "() => {\<esc>o})\<esc>\<s-o>"
    let lambdax = "=> {\<esc>o})\<esc>\<s-o>"
    let reds = "uce((acc, item) => {\<esc>o}, {})\<esc>\<s-o>"
    "let newp = "\<esc><left>xi Promise((resolve, reject) => {\<esc>o})\<esc>\<s-o>"
    "let smap = "\<esc><left>xi Promise((resolve, reject) => {\<esc>o})\<esc>\<s-o>"

    let s = ''
    let line = Strip(CurrentLine())

    if Test(line, 'red *$')
        let s = reds

    elseif Test(line, '(lib|dict|component)$')
        let origin = Match(line, '\w+\ze\.(map|filter)')
        let start = ''
        let s = norm

    elseif Test(line, '(filter|map)$')
        let origin = Match(line, '\w+\ze\.(map|filter)')
        let start = ''
        let s = '(' . Parens(Slice(origin)) . ' ' . lambdax

    elseif Test(line, 's *$')
        let s = '=> ' . par 

    elseif Test(line, '\=\> *$')
        let s = par 

    elseif Test(line, '[,\(] *$')
        let s = fn 

    elseif Test(line, 'x *$')
        let s = lambdax 

    elseif Test(line, ', *$')
        let s = objcomma 

    elseif Test(line, '\) *$')
        let s = norm 

    elseif Test(line, ': *$')
        let s = obj
    elseif expand('%:e') == 'vue'
        let s = norm
    elseif Test(line, '^\w{-}s>')
        if !Test(line, '\=')
            let start .= '= '
        endif
        let s = arr
    else
        let s = norm
    endif
    return start . s
endfunction

function! SaveTester()
    let name = GetFunctionName()
    let command = ':ec ' . name . '('''')<left><left>'
    execute "normal! " . command
endfunction

function! GetForIterationVariable(arg)
   let s = a:arg
    if len(s) < 4
        return 'item'
    elseif s == 'files'
       return 'file'

    elseif s == 'children'
       return 'child'
    elseif s == 'order'
        return 'key'
    elseif Test(s, 's$')
        return s[:-2]
    elseif Test(s, 'es$')
        return s[:-3]
    else
        return 'item'
    endif
endfunction

function! GetAllPotentialFunctionNames(s)
    return FindallStrings(a:s, '\w*\ze\(')
endfunction

function! GetThreeLines()
    return [getline(line('.') - 1), getline(line('.') - 0), getline(line('.') + 1)]
endfunction

function! FindFunctionDown()
    "execute "/\\v^((async )?function|def|class)"
    /^\(function\|def\|class\)
endfunction

function! GetCursor()
    return GetPos()[1]
endfunction

function! JsRangeEdit()
    ec 'sleeping'
    sleep
    ec 'waking'
    let file = CurrentFile()
    call Node('edit.js', file, 'rangeEdit', line('.'))
endfunction

function! GetDictValues(lines)
    let regex = ': *\zs''?"?.{-}\ze,?$'
    let p = Findall2(a:lines, regex)
    return p
endfunction

function! GetDictKeys(lines)
    let regex = '^ *''?"?\zs\w+\ze''?"?:'
    let p = Findall2(a:lines, regex)
    return p
endfunction

function! ReadItemFromSearch(indexes, arg)
    let key = a:arg ? arg : GetVariableName(CurrentLine())
    call PrintKeys(0, key)
endfunction

function! ReadItem(key)
    let items = FindLibKeys(a:key, 1)
    let text = join(items, "\n\n")
    call ToPasteBuffer(text)
endfunction

function! ExecuteSearchWithStartingSpaces(arg)
    let regex = "^    " . a:arg . '\(.{-}\{$'
    execute "/\\v" . regex 
endfunction

function! RestoreCurrentPos()
    call setpos('.', g:currentpos)
endfunction

function! SaveCurrentPos()
    let g:currentpos = getpos('.')
endfunction

function! SaveToInsertionPoint()
    let name = GetCodeName()
    call SaveCurrentPos()
    if Exists(GoToInsertionPoint())
        call InvivoDictEntry(name)
        call RestoreCurrentPos()
        ec 'saved the item to insertion-point: ' . name
    else
        ec 'coudnt find einsertion point'
    endif
endfunction

function! GoToInsertionPoint()
    try
        let key = ''
        let regex = '^ *' . '(\/\*|"|#|\/\/) *' . 'insertion-point' . key
        call ExecuteRegex(regex)
        return 1
    catch
        return 0
        "let key = 'master'
        "let regex = '^ *' . '(\/\*|"|#|\/\/) *' . 'insertion-point ' . key
        "call ExecuteRegex(regex)
    endtry
endfunction

function! ExecuteRegex(regex, ...)
    let r = "\\v" . a:regex
    let r = a:0 >= 1 ? '?' . r : '/' . r
    let r = a:0 >= 2 ? r . '/e' : r
    execute r
endfunction

function! Testex()
    execute "?\\vfun"
endfunction

function! ExecuteSpaceSearch(arg)
    let regex = "^ +" . a:arg 
    execute "/\\v" . regex 
endfunction

function! FindallStrings(s, r)
    let store = []
    call substitute(a:s, Regexed(a:r), '\=add(store, submatch(0))', 'g')
    return filter(store, 'Exists(v:val)')
endfunction

function! ExecuteSearch(...)
    let arg = a:0 >= 1 ? a:1 : ''
    let mode = a:0 >= 2 ? a:2 : ''
    let regex = "^"
    normal ma

    if mode == 'spaces'
        let regex .= '    '
    elseif mode == 'b'
        execute "?\\v" . arg
        return 

    elseif mode == 'null'
        let regex = arg
        execute "/\\v" . regex 
        return 

    elseif mode == 'function-exact'
        let regex = "^((async )?function|def|class) " . arg . '>'
        execute "/\\v" . regex 
        return 

    elseif mode == 'function'
        let regex = "^((async )?function|def|class) " . arg
        execute "/\\v" . regex 
        return 
    endif

    let regex .= "((async )?function|def|class) " . arg

    if mode == 'exact'
        let regex .= '\>'
    endif

    if mode == 'spaces'
        let regex .= '\(.{-}\{$'
    endif

    execute "/\\v" . regex 

endfunction

function! PrintKeys(i, arg)
     let val = FindLibKeys(a:arg, 1, 1)
     if val
         ec val
     else
        call ExecuteSearch(a:arg)
     endif

endfunction

function! CopyUp(indexes)
    ec a:indexes
    let lines = GetLines(a:indexes)
    call add(lines, '')
    call add(lines, '')
    call append(a:indexes[0] - 1, lines)
endfunction

function! GetTwoArgs(s)
    "let [key, arg] = ForceSplit(a:s)
    let [key, arg] = [a:s[0], a:s[1:]]
    if Not(arg)
        let arg = ''
    endif
    return [key, arg]
endfunction

function! GetLibItems2(s, lang)
    let lib = IsString(a:lang) ? GetLibrary(a:lang) : a:lang
    let keys = IsString(a:s) ? SpaceSplit(a:s) : a:s
    return map(keys, 'get(lib, v:val)')
endfunction

function! AppendArray(items)
    let lines = Flat(map(a:items, 'split(v:val, "\n")'), 1)
    call SetLines2(lines)

endfunction

function! VisualManager(...)
    let s = a:0 >= 1 ? a:1 : 'foo'
    let [key, arg] = GetTwoArgs(s)
    let indexes = GetSmartIndexes2()
    let Fn = get(g:visualdict, key)
    call Fn(indexes, arg)
endfunction

function! GetInput(items, ...)
  call Numbered(a:items)
  let message = a:0 >= 1 ? a:1 : 'Awaiting'
  let message = Capitalize(message) . ': '
  call inputsave()
  let name = input(message)
  call inputrestore()
  ec 
  return name
endfunction

function! EscapeTerminalText(s)
    if Not(a:s)
        return ''
    endif
    "let s = '()[] \n'
    let s = a:s
    let dict = {'<': 'lt', '>': 'gt', '=': 'equal', ':': 'colon', '$': 'dollar', '\n': 'n', ' ': 's', '(': 'lp', ')': 'rp', '[': 'lb', ']': 'rb', '{': 'lcb', '}': 'rcb', "'": 'quoteS', '\"': 'quoteD'}
    let regex = '[\<\>\=\:\$\(\)\[\]\{\}''""]|\n| '
    let s = Sub(s, regex, {x -> 'zz' . get(dict, x[0])})
    "let s = Sub(s, '\=|:|\\n|\$|\(|\)| |\[|\]', {x -> 'zz' . get(dict, x[0])})
    return s
endfunction

function! Findall2(s, r)
    let lines = IsArray(a:s) ? a:s : [a:s]
    let store = []
    for line in lines
        let match = Match(line, a:r)
        if Exists(match)
            call add(store, match)
        endif
    endfor
    return store
endfunction

function! FindVimBinding(...)
    let file = a:0 >= 1 ? a:1 : 'variables.vim' 
    let regex = GetInput('Regex')
    let lines = readfile(file)
    ec len(lines)
    let matches = filter(lines, 'Test(v:val, regex, 1)')
    ec matches
    call Numbered(matches)
endfunction

function! GetFunctionOrInnerFunctionIndexes()
    let start = line('.')
    let [a,b] = GetCodeIndexes()
    let [c, d] = GetInnerFunctionIndexes(a, b)
    if c == 0
        return [a,b]
    elseif d == 0
        return [a,b]
    else
        return [c,d]
    endif
endfunction

function! LeaderManager2(s)
   let [key, arg] = SplitOnce(trim(a:s))
   if has_key(g:ldrdict2, key)
       if empty(arg)
           call g:ldrdict2[key]()
       else
           call g:ldrdict2[key](arg)
       endif
   else
       ec 'leader manager does not have key
   endif
endfunction

function! GetSmartIndexes2()
    let [a, b, c] = GetThreeLines()
    if IsLineStart(b) && trim(a) == ''
        return line('.')
    endif

   let [indexes, flag] = GetVisualIndexes('flag')
   if empty(flag)
       return indexes
   endif

    return GetFunctionOrInnerFunctionIndexes()
endfunction

function! CreateCommand2(s)
    let [binding, expr, options] = split(s)
    echo [binding, expr, options]
    return
    let type = get(dict, type, type)

    let key = ''
    let name = ''
    let cmd = ''
    let silent = ''
    let items = ['nnoremap', silent, a:name, a:command]
    let s = join(items, ' ')
    call append('$', s)
    call cursor('$', 100)
endfunction

function! GetNameClosestToCursor(line, names)
    let line = a:line
    let names = a:names
    let wordsRE = '\w+'
    let current = CurrentWord()
    let filtered = filter(names, 'Test(v:val, current)')
    if len(filtered) == 0
        return 0
    elseif len(filtered) == 1
        let name =  filtered[0]
        let result = NameSearch(name)
        if not result:
            ec 'no result'
        endif
    else
        let trycount = 0
        let words = FindallStrings(line, wordsRE)
        "ec words
        "return
        "sdfsdf()

        let i = index(words, current)
        let lineLength = len(line)
        let increment = lineLength - i < i ? 1 : -1
        while 1
            let trycount += 1
            if trycount == 5
                return 0
            endif

            let i = i + increment
            let word = words[i]
            if Not(word)
                ec ' noword'
                return 
            endif
            ec word
            let result = NameSearch(word)
            if result
                return 1
            endif
        endwhile
    endif

endfunction

function! AddLetHelperParser(s)
    return Test(a:s, '^    \w+ \=') ? GetSpaces(a:s) . 'let ' . trim(a:s) : ''
endfunction

function! AddLets()
    let indexes = GetCodeIndexes()
    call GetSetLines2(indexes, function('AddLetHelperParser'))
endfunction

function! SmartSpaces2(s)
    if Test(a:s, '^function|^class') 
        return '    '
    endif
    return GetSpaces(a:s)
endfunction

function! GetSetLines2(indexes, fn)
    for index in range(a:indexes[0], a:indexes[1])
        let line = getline(index)
        let product = a:fn(line)
        let product = Exists(product) ? product : line
        call setline(index, product)
    endfor
endfunction

function! Includes(key, arr)
    if IsObject(a:arr)
        return index(keys(a:arr), a:key) > -1
    endif
    return index(a:arr, a:key) > -1
endfunction

function! Shared(a, b)
    return filter(a:a, 'Includes(v:val, a:b)')
endfunction

function! FindName()
    
    let line = CurrentLine()
    let word = GetCurrentWord()
    let names = FindallStrings(line, JSPY('callableRE'))
    if Includes(word, names)
        return word
    endif

    if len(names) == 0
        return 0
    elseif len(names) == 1
        let target = names[0]
        return target
    else
        return names[0]
        let cursorpos = GetCursor()
        "ec cursorpos
        "ec len(line)
        let increment = len(line) - cursorpos > cursorpos ? 1 : -1
        "ec [increment]
        "ec names
        "return
        let startindex = increment == 1 ? 0 : len(names) - 1
        let lastMatch = ''

        while 1
            if startindex == -1 || startindex == len(names)
                break
            endif

            let target = names[startindex]
            let startindex += increment
            ec 'hi'
            ec [target]
            let res = NameSearch(target)
            if res == 1
                let lastMatch = res
            else
                break
            endif

            break
        endwhile
    endif

endfunction

function! GoToFunctionRightAbove(...)
    let fn = a:0 >= 1 ? a:1 : 0
    if Exists(fn)
        let regex = '^function ' . fn
        execute "/\\v" . regex
        return
    endif

    let target = FindName()
    let res = NameSearch(target)
    if res == -1
        call GoAbove()
    elseif res == 1
        call ScrollScreen()
    elseif res == 0
        call GoAbove()
        call setline('.', target . ' ')
        normal A
    endif

endfunction

function! GoToFunction(...)
    let fn = a:0 >= 1 ? a:1 : 0
    if Exists(fn)
        let regex = '^function ' . fn
        call ExecuteRegex(regex)
        return 
    endif

    let target = GetCurrentWord()
    let res = NameSearch(target)
    if res == -1
        ec 'hmm'
        call GoTop()
    elseif res == 1
        call ScrollScreen()
    elseif res == 0
        call GoTop()
        call setline('.', target . ' ')
        normal A 
    endif

endfunction

function! NameSearch(name)
    let name = a:name
    if Not(name)
        ec 'no name'
        ec name
        return -1
    endif
    try
        call ExecuteSearch(name, 'function-exact')
        return 1
    catch
        return 0
        try
            try
                call ExecuteSearchWithStartingSpaces(name)
                return 1
            catch
                return 2
            endtry

        endtry
    endtry
endfunction

function! RunVimLineInJS()
    if Not(IsVim())
        ec 'saving'
        w
    endif

    let file = CurrentFile()
    let line = CurrentLine()
    call DeleteLine()

    "let s = Test(line, '^vim |^v ') ? Replace(line, '^vim |^v ', '') : ''

    let s = Test(line, 'vim |v ') ? EscapeTerminalText(line) : ''
    let editorfile = 'edit.js'
    let cmd = editorfile . ' ' . file . ' ' . s
    ec cmd
    execute "!clear;node " . cmd
endfunction

function! GetVisualItem(i, arg)
    let context = GetContext()
    let val = ''
    ec context
    ec a:arg
    if a:arg == 'keys'
        let val = GetDictKeys(GetLines(a:i))
    elseif a:arg == 't'
        let val = ['asdf']
    elseif a:arg == 'asdfasdf'
        let val = 'asdf'
    else
        let val = GetDictValues(GetLines(a:i))
    endif 

    if Exists(val)
        ec val
        call ToPasteBuffer(ToStringArray(val))
    endif
endfunction

function! FindLibKeysOld(...)
    let regex = a:0 >= 1 ? a:1 : GetInput('Choose Target Regex') 
    let print = a:0 >= 2 ? 1 : 0
    let earlyreturn = a:0 >= 3 ? 1 : 0
    let lang = GetLang()
    "let lang = 'js'
    let lib = GetLibrary(lang)
    let keys = filter(keys(lib), "Test(v:val, regex . '\\c')")
    if Not(keys)
        ec 'no keys'
        return 
    elseif len(keys) == 1
        let values = GetLibItems2(keys, lib)
        if print
            ec ''
            return values
        else
            call AppendArray(values)
            return 
        endif
    endif

    call Numbered(keys)
    let target = GetInput('What keys would you like?')
    if Not(target)
        ec 'returning'
        return 
    else
        let keys = map(SpaceSplit(target), 'keys[str2nr(v:val)]')
        let values = GetLibItems2(keys, lib)
        if print
            ec ''
            ec ''
            return values
        else
            call AppendArray(values)
            return 
        endif
    endif
endfunction

function! ReadLibItem(...)
    let key = a:0 >= 1 ? a:1 : GetCurrentWord('word')
    let regex = '^' . key
    let lib = GetLibrary()
    let keys = filter(keys(lib), "Test(v:val, regex . '\\c')")
    if len(keys) > 1
        let target = GetInput(keys, 'What keys would you like?')
        if Exists(target)
            let keys = map(SpaceSplit(target), 'keys[str2nr(v:val)]')
        endif
    endif
    
    if Exists(keys)
         let value =  ToString(GetLibItems2(keys, lib))
         ec value
         call ToPasteBuffer(value)
    endif
endfunction


function! FindLibKeys(regex)
    let regex = a:regex
    let lib = GetLibrary()
    let keys = filter(keys(lib), "Test(v:val, regex . '\\c')")
    if len(keys) > 1
        let target = GetInput(keys, 'What keys would you like?')
        if Exists(target)
            let keys = map(SpaceSplit(target), 'keys[str2nr(v:val)]')
        endif
    endif
    
    if Exists(keys)
        call AppendArray(GetLibItems2(keys, lib))
    endif
endfunction

function! ReloadLibrary(...)
        "let lang = a:0 >= 1 ? a:1 : GetLang()
        "let file = join(['lib', lang, 'json'], '.')
        "if !IsFile(file)
            "ec 'not a file'
            "return
        "endif

        let file = '/home/kdog3682/CWF/public/myfunctions.json'
        let value = ReadJson(file)

        if Not(value)
            return 
        elseif lang == 'js' 
            let g:jslib = value
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

function! GetLibrary(...)
    let lang = a:0 >= 1 ? a:1 : GetLang()
    let key = 'g:' . lang . 'lib'

    if exists(key)
        if lang == 'js' 
            return g:jslib
        elseif lang == 'css' 
            return g:csslib
        elseif lang == 'py' 
            return g:pylib
        elseif lang == 'html' 
            return g:htmllib
        elseif lang == 'vim' 
            return g:vimlib
        else
            return g:jslib
        endif
    else
        return ReloadLibrary()
    endif
endfunction

function! FunctionDrafter()
    call SetCursor(GetFunctionIndex())
    call append('.', Replace(CurrentLine(), '\(.{-}\)', '()'))
    call CommentLine()
endfunction

function! CheckIfDictHasKey(s)
    let [dict, key] = SplitOnce(a:s)
    execute "ec get(g:" . dict . ", " . Quotify(key) . ")"
endfunction

function! ScrollScreen()
    "let lineNumber = line('.')
    "ec lineNumber
    "let top = line('w0')
    "ec top
    " 
    execute "normal! zt"
endfunction

function! CreateFunction(...)
    let mode = a:0 >= 1 ? a:1 : ''
    let line = a:0 >= 2 ? a:2 : Strip(GetLine())

    let line = 'foobar(asd, asdf)'

    let line = Camelize(line)
    let suffix = JSPY('suffix')
    let currentSpaces = CurrentSpaces()

    let [p1, p2, suffix, classparam] = JSPY('classp1', 'p2', 'suffix', 'classparam')
    let a = NameMaker(line)
    let b = '    '
    let c = suffix
    let lines = [a,b,c]
    call SetLines2(lines)
endfunction

function! SetLines2(lines)
    call GoTop()
    call insert(a:lines, '')
    call append('.', a:lines)
endfunction

function! PySnippet2notinuse()
    let [spaces, tag, line, parts] = GetSpacesTagLineAndParts()

    let snippet = get(g:pydict, tag)
    let regex = '\$(\{.{-}\}|\d+)'
    let Parser89 = {x -> function('PySnippetTemplater')(x, parts, line)}
    let snippet = Sub(snippet, regex, Parser89)
    let cursorpos = GetCursorFromStringSnippet(snippet)
    let snippet = Replace(snippet, '\$c', '')
    call TextPlacement(SplitLines(snippet), spaces)
    call SetCursor(cursorpos, spaces)
endfunction

function! IterativeMatch(s, dict, mode)
    for [k,v] in items(a:dict)
        if a:mode == '$'
            let regex = k . ' *$'
            ec [a:s, regex]
            if Test(a:s, regex)
                return [k, v]
            endif
        elseif a:mode == '^'
            let regex = '^' . k
            if Test(a:s, regex)
                return [k, v]
            endif
        endif

    endfor

    return [0, 0]
endfunction

function! IterativeMatch2(s, ref, fallback)
    for [regex, Snippet] in a:ref
        let match = Match(a:s, regex)
        if Exists(match)
            let lookbehind = GetLookBehind(regex)
            let extra = len(lookbehind)
            if extra == 0
                let extra = 1
            endif
            let offset = -1 * (len(match) + extra)
            return [match, Snippet, offset]
        endif
    endfor

    let offset = len(a:s)
    return [a:s, a:fallback, offset]
endfunction

function! PySnippet5()

    let [spaces, line] = GetSpacesAndLine()
    let context = GetContext2()

    let lineStart = ''
    let lineSliced = ''
    let ref = get(g:p5dict, context)
    if Exists(ref) 
        let parts = GetWords2(line)
        let [match, snippet] = IterativeMatch2(TrimEnd(CurrentLine()), ref)
        let snippet = g:B
        asd

        if Exists(snippet)
            call PySnippeteer(parts, lineSliced, snippet, lineStart, spaces)
            return 
        endif
    endif

    ec ' noma'
    return 
    call PySnippet4()
endfunction

function! PasteFileName()
    call ToPasteBuffer(CurrentFile())
endfunction

function! PyClassSnippet(line, lineSliced, lineStart, spaces)
        let parts = GetWords2(line)
        if len(parts) == 3
            let snippet = '$1 $2($3)' . g:jsbe
        elseif len(parts) == 3
            let snippet = '$1 ($2)' . g:jsbe
        else
            let snippet = '$1()' . g:jsbe
        endif

        call PySnippeteer(parts, lineSliced, snippet, lineStart, spaces)
        return 
endfunction

function! Boasdd()
    
    let [spaces, line] = GetSpacesAndLine()
    call setline('.', line . 'hiii')
    return 
    
endfunction

function! SplitOnceReverse(s)
    let items = split(a:s, ' ')
    if len(items) == 1 
        return ['', items[0]]
    endif

    if len(items) == 2 
        return items
    endif
    return [join(items[:-2], ' '), items[-1]]
endfunction

function! ZoopMethod2(s, mode)
    let [a,b] = SplitOnceReverse(a:s)

    let method = a:mode
    let long = 1

    if len(method) == 2
        let long = 0
        let method = method[0]
    endif

    let method_dict = {'red': 'reduce', 'm': 'map', 'fe': 'forEach', 'f': 'filter'}
    let method = method_dict[method]
    let suffix = long ? ", i) => {\n    $c\n})" : ") => $c)"
    return a . ' ' . b . '.' . method . '((' . ZoopArgHelper(b) . suffix

endfunction

function! PythonVarsHandler(s)
    let [fileRef, tag] = split(a:s, '\v' . regex . '\zs')
    let fileRef .= '.py'
    let tag = Replace(s, '^vars', '')
    let names = ReadKdog(fileRef)
    let name = FindItem(names, ExpandPythonRegex(tag))
    return name
endfunction



function! PySnippeteer(parts, lineSliced, snippet, lineStart, spaces)
    let parts = a:parts
    let lineSliced = a:lineSliced
    let snippet = a:snippet
    let lineStart = a:lineStart
    let spaces = a:spaces
    let regex = '\$(\{.{-}\}|\d+)'
    "lineSliced refers to the original line
    let Parser89 = {x -> function('PySnippetTemplater2')(x, parts, lineSliced)}
    let snippet = Sub(snippet, regex, Parser89)

    let cursorpos = GetCursorFromStringSnippet(snippet)
    let snippet = lineStart . Replace(snippet, '\$c', '')
    ec snippet
    call TextPlacement2(SplitLines(snippet), spaces)
    call SetCursor(cursorpos, spaces)
    return 
endfunction

function! TextPlacement2(lines, ...)
    let spaces = a:0 >= 1 ? ToSpaces(a:1) : CurrentSpaces()
    let relativecursorpos = a:0 >= 2 ? a:2 : 0
    let lines = map(a:lines, 'spaces . v:val')
    call setline('.', lines[0])
    call append('.', lines[1:])
    if Exists(relativecursorpos)
        if IsArray(relativecursorpos)
            let length = len(lines)
            let [l, c] = relativecursorpos
            "let l = length - l
            call SetPosition(l, c + len(spaces), 1)
        elseif IsNumber(relativecursorpos)
            call SetPosition(asdjkhasdkjf)
        else
            raise Exception('ray') 
        endif
    endif
endfunction

function! PySnippet3()
    let dict = {
        \ Ncg2(g:arrmethodwords) . ' \w+': 
        \ '    ts': "toString() {\n    $c\n}",
        \ 'redab': "reduce((acc, [a, b]) => {\n    $c\n}, {})",
        \ 'redkv': "reduce((acc, [k, v]) => {\n    $c\n}, {})",
        \ 'red': "reduce((acc, item) => {\n    $c\n}, {})",
    \}

    let functiondict = {
    \}

    let classdict = {
        "\ '  *update\w+': "${ZoopbarNew($1)} {\n    $c\n}",
        \ '  *' . Ncg2(g:zoopbarwords) . '\w+': "${ZoopbarNew($1)} {\n    $c\n}",
        \ '  *\w+': "() {\n    $c\n}",
    \}

    let globaldict = {
        \ '    \w+\(\w+\)': "${ZoopbarFnName($1, $2, 'parensIncluded')} {\n    $c\n}",
        \ ' *"?(if|else|while|do)': " {\n    $c\n}",
        "\ ' *\w+': "const $1 = {\n    $c\n}",
        \ '    \w+ \w+': "${ZoopbarFnName($1, $2)} {\n    $c\n}",
        \ 'c \w+': "class ${ZoopbarNew($1, 'start')} {\n    constructor($c) {\n        \n    }\n}",
    \}
    "if foobar

    let contextdict = {
        \ 'function': functiondict,
        \ 'class': classdict,
    \ }

    let [spaces, line] = GetSpacesAndLine() " It gets trimmed

    if Test(line, Ncg2(g:zoopbarfndict) . '$')
        let lineStart = ''
        let lineSliced = line
        let parts = []
        let snippet = "${ZoopBarInfer($1)}"

        if Test(snippet, '\$\d')
            let parts = FindallStrings(line, '\w+')
            let lineStart = ''
        else
            let lineStart = line
        endif 

        let regex = '\$(\{.{-}\}|\d+)'
        let Parser89 = {x -> function('PySnippetTemplater')(x, parts, lineSliced)}
        let snippet = Sub(snippet, regex, Parser89)
        ec snippet
        let cursorpos = GetCursorFromStringSnippet(snippet)
        let snippet = lineStart . Replace(snippet, '\$c', '')
        call TextPlacement(SplitLines(snippet), spaces)
        call SetCursor(cursorpos, spaces)
        return 
    endif
    " END OF SINGLE MATCH CONTINUING AS NORMAL.

    let currentline = getline('.')
    let [key, snippet]  = IterativeMatch(currentline, dict, '$')
    let lineSliced = ''
    let lineStart = ''
    let parts = []

    if Not(snippet)
        let context = GetContext2()
        let targetdict = get(contextdict, context, {})
        let usable = ObjectAssign(globaldict, targetdict)
        ec keys(usable)
        let [key, snippet]  = IterativeMatch(currentline, usable, '^')
        if Not(key)
            let snippet = " {\n    $c\n}"
        endif
        ec snippet

        if Test(snippet, '\$\d')
            let parts = FindallStrings(line, '\w+')
            let lineStart = ''
        else
            let lineStart = line
        endif 

        let lineSliced = line
    else
        let lineSliced = line[0: - len(key) - 1]
        let lineStart = lineSliced
    endif

    let regex = '\$(\{.{-}\}|\d+)'
    let Parser89 = {x -> function('PySnippetTemplater')(x, parts, lineSliced)}
    let snippet = Sub(snippet, regex, Parser89)
    let cursorpos = GetCursorFromStringSnippet(snippet)
    let snippet = lineStart . Replace(snippet, '\$c', '')
    call TextPlacement(SplitLines(snippet), spaces)
    call SetCursor(cursorpos, spaces)
endfunction

function! GetContext2()
    let spaces = GetSpaces()
    if spaces == ''
        return 'global'
    endif
    let n = len(spaces) - 4
    if n < 3
        let n = 0
    elseif n < 7
        let n = 4
    elseif n < 11
        let n = 8
    endif
    let n = 0
    "let r = '^' . ToSpaces(n) . '(function |def |class |^let|^const|computed:|methods:)|\= \{ *$'
    let r = '^' . ToSpaces(n) . '(function |def |class |^let|^const)'
    let match = MatchSearch(r, 'b')

    "This is to take care of the last regex item.
    if match =~ '\v\=' 
        let match = 'dict'
    elseif match =~ ':$' 
        let match = 'vue'
    endif
    return trim(match)
endfunction

function! GetContext3()
    let spaces = CurrentSpaces()
    if len(spaces) == 0
        return 'function'
    endif
    let spaces

    let r = '^(function |def |class |^let|^const)|computed:|methods:'
    let r = ''
    let match = MatchSearch(r, 'b')

    if match =~ '\v\=' 
        let match = 'dict'
    elseif match =~ ':$' 
        let match = 'vue'
    elseif match =~ 'const'
        let match = 'const'
    elseif match =~ 'class' 
        let match = 'class'
    else
        return expand('%:e')
    endif
    return trim(match)

endfunction

function! GetWindowIndexes()
    return map(['w0', 'w$'], 'line(v:val)')
endfunction

function! WindowAutoComplete()
    let s = GetWindowText()
    let word = CurrentWord()
    let words = Unique(filter(FindallStrings(s, '\w\w\w+(\.\w+)*'), 'v:val[0] == word[0]'))
    let pairs = map(words, '[GetAbrev(v:val), v:val]')

    let queryletters = split(word[1:], '\zs')
    let A = pairs
    let index = 0

    for letter in queryletters
        let index += 1
        let A = filter(pairs, 'v:val[0][index] == letter')
        if len(A) == 1 && Exists(A[0][1])
            return ReplaceCurrentLine(word, A[0][1])
        endif 
    endfor

    let potentials = map(A, 'v:val[1]')
    let match = Input(potentials)
    if Exists(match)
        return ReplaceCurrentLine(word, match)
    endif

endfunction

function! GetWindowText()
    let p = ToString(GetWindowLines())
    return p
endfunction

function! GetWindowLines()
    return GetLines(GetWindowIndexes())
endfunction

function! GetWindowRange()
    return map(['w0', 'w$'], 'line(v:val)')
endfunction

function! RunEditJS(...)
    let file = CurrentFile()
    execute "w " . file
    let editorfile = 'edit.js'

    let args = [editorfile, file]
    call extend(args, a:000)

    let cmd = join(args, ' ')
    ec cmd
    execute "!clear;node " . cmd
endfunction

function! Testfo()
    w edit.js
endfunction

function! TemplateDitto2(line, upline)
    let [line, upline] = [a:line, a:upline]
    let [key, parts] = KeyAndRest(line)

    let items = map(parts, 'Parser233(upline, key, v:val, "g")')
    call TextPlacement(items, 0, 'movecursor')
endfunction

function! TemplateDittoHandler()
    let upline = FindNextUpLine()
    call TemplateDitto2(CurrentLine(), upline)

endfunction

function! TestPrint(...)
    let run = 0
    let [spaces, line] = GetSpacesAndLine()

    if spaces == '' && line == ''
        call AppendBottom(statement)
        let length = len(Replace(statement, '\)+$', ''))
        call SetCursor('$', length + 1)

        let r = '^((function|class) \w+|    (static )=\w+\()'
        let line = SprawlLine2(r)
        let name = Match(line, '\w*\ze\(')
        let statement = ''
        return 
    endif

    if Test(line, 'return')
        let [variablePrefix, cs, ce] = JSPY('variablePrefix', 'consoleThrow', 'consoleEnd')
        let a = substitute(Strip(line), 'return ', variablePrefix . 'p = ', '')
        let b = cs . 'p' . ce
        let c = 'return p'
        let items = [a,b,c]
        call TextPlacement(items, spaces)
        return 
    endif

    if Test(line, g:functionlookaheadRE) 
        " it means function name re

        let name = Match(line, g:functionlookaheadRE)
        let args = Match(line, '\(\zs\w.{-}\ze\)')
        if Exists(args)
            if (args == 'file')
                let args = CurrentFile()
            endif
        endif

        if Exists(args)
            let args = Quotify(args)
        else
            let args = ''''
        endif

        let statement = name . '(' . args . ')'
        let statement = Logger(statement)
        call Append(statement, '$')
        normal G
        return 
    endif

    if Test(line, '^\w+ \w+')
        let items = split(line, ' ')
        call SetLine(Logger(items[0] . Parens(join(map(items[1:], "ParserAddQuotes(v:val, 1)"), ', '))))
        return 
    endif

    if Test(line, 'print|console')
        call ReplaceLine(line('.') - 1, 'let \w+ \=', 'return')
        call DeleteLine(line('.'))
        call DeleteLine(line('.') + 1)
        return 
    endif

    " i think it should around here ... the rest below is crazy

    if Test(line, '^ *(const ?) \w+ \=')
        let name = Match(line, '(const|function) \zs(\w+)')
        let payload = spaces . "console.log(" . name . ")"
        call append('.', payload) 
        if run
            call append(line('.') + 1, spaces . 'throw ""')
            let file = CurrentFile()
            call SaveFile(file)
            call Node(file)
        endif
        "call ReplaceLine(line('.'), '(const ?) \w+ \=', 'return')
        "call DeleteLine(line('.') + 1)
        return 
    endif

    let r = '^((function|class) \w+|    (static )=\w+\()'
    let line = SprawlLine2(r)
    let name = Match(line, '\w*\ze\(')
    let statement = ''

    if Test(line, '^class')
        let parent = Match(line, 'class \zs\w+')
        let statement = 'z = (new ' . parent . '())'

    elseif Test(line, 'function')
        let args = ''
        let statement = name . '(' . args . ')'
        let statement = Logger(statement)

    elseif Test(line, 'static')
        let parent = SprawlMatch('class \zs\w*')
        let statement = parent . '.' . name . '()'
        let statement = Logger(statement)

    endif

    call AppendBottom(statement)
    let length = len(Replace(statement, '\)+$', ''))
    call SetCursor('$', length + 1)

endfunction

function! AddDefaultArg(x, ...)
    if len(a:000) > 0
        return a:x
    endif

    let args = copy(a:x)
    call extend(args, a:000)
    return args
endfunction

function! SpaceJoin(x)
    return join(a:x, ' ')
endfunction

function! FindKeyInDict(s)
    let [key, dict] = SplitOnce(a:s)
    let ref = {
        \'ldr': 'ldrdict',
        \'r': 'replacecdict',
    \}
    let dict = get(ref, dict, dict)
    let ref = eval('g:' . dict)
    let item = get(ref, key)
    ec item
endfunction

function! RunTime(...)
    let items = a:000
    let lang = GetExtension(items[0])
    let runtime = JSPY(lang, 'runtime')
    let cmd = "!clear; " . runtime . ' ' . join(Flat(items), " ")
    "ec cmd
    "return
    execute cmd
endfunction

function! Node(...)
    let cmd = "!clear;node " . join(Flat(a:000), " ")
    let cmd = "!clear;node --trace-uncaught" . join(Flat(a:000), " ")
    execute cmd
endfunction

function! Python(...)
    let cmd = "!clear;python3 " . join(Flat(a:000), " ")
    execute cmd
endfunction

function! Foasdf(...)
    ec 'hi'
    ec a:1
    return a:000[-1]
endfunction

function! NodeConnector(...)
    call Node(g:nodeconnectorfile, CurrentFile(), join(a:000, ' '))
endfunction

function! PythonConnector(...)
    call Python(g:pythonconnectorfile, CurrentFile(), join(a:000, ' '))
endfunction

function! EditConnector(...)
    let s = a:0 >= 1 ? a:1 : ''
    let file = CurrentFile()
    call SaveFile(file)
    call SaveFile(g:jsanywherefile)
    call Node(g:jsanywherefile, file, s)
endfunction

function! EditConnector2(...)
    let extra = ''
    let key = ''

    let line = CurrentLine()
    let first = FirstWord2()
    let keys = ['test', 'eval']
    if Includes(first, keys)
        let [key, expr] = SplitOnce(line)
        let extra = key . ' ' . EscapeTerminalText(Replace(trim(expr), '^[/"#]*', ''))
        call deleteline()
    else
        let [key, extra] = SplitOnce(a:1)
        let extra = EscapeTerminalText(extra)
    endif

    "ec key
    "ec extra
    "return
    let file = CurrentFile()
    call SaveFile(file)
    call Node(g:jsanywherefile, file, key, extra)
    " You can run it from the line ... or you can run it directly from the command prompt. 
endfunction

function! StartsWithDot(s)
    return a:s =~ '^\.'
endfunction

function! StartsWithSlash(s)
    return a:s =~ '^/'
endfunction

function! GetJournalPath()
   let p = '/home/kdog3682/CWF/public/' . DateStamp() . '.journal.txt'
   "if IsFile(p)
       "return
   "endif
   return p
endfunction



function! AddImports2()
    let s = readfile(g:importfile)
    call append('^', [join(s, ';')])
    "call append('^', s)
endfunction

function! Foot()
    call append('.', g:templines)
    let g:templines = []
endfunction

function! DeleteSave()
    let [a,b] = GetCodeIndexes()
    call extend(g:templines, GetLines(a, b))
    call extend(g:templines, '')
    ec g:templines
    return 
    call deletebufline('%', a, b)
endfunction

function! LeaderHasKey(key)
    let result = has_key(g:ldrdict, a:key)
    ec result
    return result
endfunction

function! SelfAppend2(...)
    let expr = a:0 >= 1 ? 'eval ' . a:1 : CurrentLine()
    call EditConnector(expr)
    let lines = readfile('tempselfappend')
    call append('.', lines)
endfunction


function! SetShortcuts()
    inoremap wp <esc>:call HtmlSnippet()<cr>a
endfunction

function! UnsetShortcuts()
    inoremap wp <esc>:call PySnippet()<CR>a
    "unlet g:var_name
endfunction

function! SplitSpaces(s)
    return split(a:s, ' ')
endfunction

function! DivMaker(tag, attrs, content)
    let pre = ''
    let post = ''
    let tag = a:tag
    let content = a:content
    let attrs = a:attrs
    if IsArray(attrs)
        let attrs = join(attrs, ' ')
    endif
    let attrs = Exists(attrs) ? " " . attrs : ""

    if Includes(a:tag, ['input', 'br'])
        return "<" . tag . attrs . "/>" 
    else
        return "<" . tag . attrs . ">" . pre . content . post . "</" . a:tag . ">"
    endif
endfunction

function! CharSplit(s, n, ...)
    let Condition = a:0 >= 1 ? a:1 : 0
    let [a,b] = [a:s[0:a:n - 1], a:s[a:n:]]
    let p = [a,b]
    if a:0 >= 1
        if a:1([a,b]) == 1
            return [a,b]
        else
            return ['', a:s]
        endif
    else
        return [a,b]
    endif
endfunction

function! LogicSnippet(s)
    let [tag, rest] = CharSplit(a:s, 2)
    let [short, rest] = CharSplit(rest, 1, {s -> s[0] == 's'})

    let [hasOrIs, rest] = CharSplit(rest, 3, {s -> s[0] == 'has'})
    let [fnString, rest] = SplitOnce(rest)
    if hasOrIs == ''
        let hasOrIs = 'is'
    endif

    let tag = g:jslogicdict[tag]
    let fn = hasOrIs . Capitalize(get(g:fnabrevdict, fnString, fnString))

    return ToLogic(tag, fn, rest, short)
endfunction

function! ToLogic(tag, arg)
    let lang = GetLang2()
    let tag = a:tag
    let arg = a:arg

    ec lang
    if lang == 'py'
        if tag == 'e'
            let tag = 'elif'
        elseif tag == 'i'
            let tag = 'if'
        endif
        return tag . ' ' . arg . ":\n    $c"

    elseif lang == 'js'
        if tag == 'e'
            let tag = 'else if'
        elseif tag == 'i'
            let tag = 'if'
        endif
        return tag . ' (' . arg . ") {\n    $c\n}"

    elseif lang == 'vim'
        if tag == 'i'
            let tag = 'if'
        elseif tag == 'e'
            let tag = 'elseif'
        endif
        let ending = Includes(tag, ['if', 'while', 'for']) ? 'end' . tag : ''
        let arg = Capitalize(arg)
        return tag . ' ' . arg . "\n    $c\n" . ending
        
    endif
endfunction

function! OldToLogic(logicTag, fnString, args, short)
    "let args = join(map(split(a:args, ' '), 'v:val), ', ')
    let args = Sub(a:args, ' +', ', ')
    let opener = a:logicTag . ' (' . a:fnString . Parens(args) . ')'
    if a:short == ''
        return [opener . ' {', '    ', '}']
    else
        return opener
    endif
endfunction

function! HtmlSnippet(s)
    "let [spaces, line] = GetSpacesAndLine()
    let items = SplitSpaces(a:s)
    let tag = 'div'
    let content = ''
    let attrs = []

    if len(items) > 1
        let className = items[0][1:]
        let text = join(items[1:], ' ')
        if Test(className, 'button')
            let tag = 'button'
        endif
        call add(attrs, Attrify('class', className))
        let content = text
        return DivMaker(tag, attrs, content)
    endif

    for item in items
        if Test(item, '\.')
            let className = item[1:]
            call add(attrs, Attrify('class', className))
            let content = Attrify('vue', className)
        elseif Test(item, 'asdf')
            continue

        elseif Test(item, 'asdf')
            continue
        endif
    endfor
    let p = DivMaker(tag, attrs, content)
    "echom p
    "call setline('.', spaces . p)
    return p
endfunction

function! SaveCurrentFileToFileDict(...)
    let file = CurrentFile()
    let key = a:0 >= 1 ? a:1 : Basename(file)[0]
    call LeaderManager('dict file ' . key . ' ' . file)
    call SaveFile(g:myvimrc)
endfunction

function! OpenFile2(...)
    let file = a:0 >= 1 ? a:1 : CurrentFile()
    "call SaveFile(file)
    "call Python('storage.py', 'openfile', file)
    call PythonConnector('openfile', file)
    return 

    let tempfile = '_____temp.js'
    let e = Extension()
    if e == '' || e == 'txt'
        ec 'cant open text files...hackaround'
       let lines = readfile(file) 
       call WriteFile(tempfile, lines)
       let file = tempfile
    endif

    execute "!xdg-open " . file
endfunction

function! OpenIndexHtml()
    !xdg-open https://localhost:3000
    "!xdg-open index.html
endfunction

function! ExecuteSearch2(regex, ...)
    let front = a:0 >= 1 ? a:1 : "/\\v"
    if Not(Test(front, "v$"))
        front .= "\\v"
    endif
    
    execute front . a:regex
endfunction

function! SearchFromStart()
    let key = g:searchquery
    let regex = "^" . key 
    "execute "/\\v" . regex
    execute "?\\v" . regex 
endfunction

function! CreateIabFromCurrentLine()
    let line = CurrentLine()
endfunction

function! CreateMapFunctionShortcut(arg)
    let [key, fn] = SplitOnce(a:arg)
    if Not(fn)
        let fn = GetFunctionName()
    endif
    let payload = join(['nnoremap', key, ':call', fn . '()', '<CR>'], ' ')
    call append('$', [payload])
    call SaveFile(g:myvimrc)
endfunction

function! SetSearchQuery(arg)
    let g:searchquery = a:arg
endfunction

function! ChildLx(k)
    let ref = get(g:jspyparentdict, GetLang())
    return get(ref, a:k)
endfunction

function! FindBookmark(arg)
    let file = expand('%:t')
    let ref = get(g:bookmarkdict, file)
    if Not(ref)
        ec 'no bookmarks'
    else
        let regex = ref[a:arg]
        call ExecuteSearch2(regex)
    endif
endfunction

function! IncrementNumber(arg)
    let arg = a:arg[0]
    let arg += 1
    return arg

endfunction

function! DeclareNewVersion()
    let name = GetFunctionName()
    let currentindex  = GetFunctionIndex()
    let index = SprawlIndex3('^.{-}map .{-}' . name, 'W')
    let newname = Replace(name, '\d+$', function('IncrementNumber'))
    call ReplaceLine(index, name, newname)
    call append(currentindex - 1, FunctionBlockLines(newname))
    call SetCursor(currentindex + 1)
endfunction

function! Zog(...)
    ec a:000
    ec a:0
    ec a:1
    ec a:2
endfunction

function! F()
    ec 'sahasfdi'
endfunction

function! DateInsert()
    "let s = $read !date
endfunction

function! ShuntTop()
    let line = Dedent(CurrentLine())
    call deleteline()
    call Append2(2, line)
endfunction

function! Movetop()
    let lineNumber = GetLineNumber()
    
    let block = GetBlockDeleteBlock()
    let block = Dedent(block)
    let index = GetFunctionIndex()

    call SetCursor(50)
    let index = GetFunctionIndex()
    call append(index - 1, ['', ''])
    call append(index, block)
    call SetCursor(lineNumber)

endfunction

function! Moveup()
    let block = GetBlockDeleteBlock()
    let block = Indent(block)
    let index = GetFunctionIndex()
    call append(index, block)
endfunction

function! SaveAndTrackNewEdit()
    let name = GetFunctionName()
    let file = CurrentFile()
    call writefile(ToArray2(name . ' ' . file), 'trackedfunctions', 'a')
endfunction

function! SaveToFileDict()
    " 'afsgdfghdfghsdfgsfsdfasdf.json'
    let file = FindFileString(CurrentLine())
    if Not(file)
        let file = CurrentFile()
    endif

    "if Not(file)
        "let file = input('choose file name')
    "endif
    let abrev = GetAbrev(RemoveExtension(file))

    if Exists(get(g:filedict, abrev))
        let abrev = input('abrev exists. write an abrev:   ')
    endif

    if Exists(get(g:filedict, abrev))
        let abrev = input('abrev exists. write an abrev:   ')
    endif

    ec 'adding dict item'
    call AddDictItem(Join('file', abrev, file))
endfunction

function! IsEol()
    return GetChar() == len(CurrentLine())
endfunction

function! CursorMover()
    let eol = IsEol()
    let line = CurrentLine()
    if eol
        if Test(line, '\w+ \w+ *$') 
            call ReplaceCurrentLine(' \w+ *$', {s -> Parens(trim(s))})
        endif
    else
        let [a,b] = SplitLineOnCursor(line)
        if Test(a, '^ +$')
            call ToSingleLineBlock()
        else
            call setline('.', a . Parens(b))
        endif
    endif

endfunction

function! ReplaceCurrentLine(regex, Replacement)
    return ReplaceLine(line('.'), a:regex, {s -> IsFunction(a:Replacement) ? a:Replacement(s[0]) : a:Replacement})
endfunction

function! OpenHtml(...)
    let file = a:0 >= 1 ? a:1 : g:htmlfile
    call XdgOpen(file)
endfunction

function! CursorInsertion(key, ...)
    let payload = a:0 >= 1 ? a:1 : ''
    let key = a:key

    let regex = 'insertionpoint' . key
    call ExSearch(regex)

    let index = line('.')
    if index < 3
        ec 'error at insertion'
    else
        call SmartAppend(index, payload)
        let curline = getline(Relative(1))
        call cursor(index + 1, len(curline) - 1)
    endif
endfunction

function! InsertAtLocation()
    let payload = 'win.type("")'
    let key = 'win'

    let regex = 'insertionpoint' . key
    call ExSearch(regex)

    let index = line('.')
    if index < 3
        ec 'error at insertion'
    else
        call SmartAppend(index, payload)
        let curline = getline(Relative(1))
        call cursor(index + 1, len(curline) - 1)
    endif
endfunction

function! ExSearch(s)
    let s  = a:s
    execute "/\\v" . s
endfunction

function! ZBookmarkSetter()
    let g:insertionlocation = GetAnyName()
    call AppendVim(g:insertionlocation)
    call AppendAbove('//insertionpoint' . g:insertionlocation)
endfunction

function! ZBookmarkGetter()
    call CursorInsertion(g:insertionlocation)
endfunction

function! LogVariable()
    let line = CurrentLine()
    let match = Match(line, '[.a-zA-Z]+\ze \=')
    let payload = Logged(Quotify(trim(line)), match)
    call SmartAppend('.', payload)
endfunction

function! LineLog()
    return '"' . Logged(Quotify('line: ' . line('.')), 
    return Logged(Quotify('line: ' . line('.')), 'boo\<CR\>')
endfunction

function! SplitAt(s, re)
    return split(a:s, Regexed(a:re))
endfunction

function! BlockifyCurrent()
    let [spaces, s] = GetSpacesAndLine()

    let items = SplitAt(s, '(\)|else)\zs \ze(return|\w+\(|\w+ \=)')
    if len(items) == 1
        ec 'no split match'
        return 
    endif
    let [a,b] = items
    let a = a . ' {'
    let b = '    ' . b
    let c = '}'
    call TextPlacement([a,b,c], spaces)
endfunction

function! ReadFunctionNamesFromFile(...)
    let s = a:0 >= 1 ? a:1 : ''
    let [a,b] = SplitOnce(s)
    let file = b == '' ? CurrentFile() : b
    let regex = a == '' ? '\w+' : a . '\w*'

    let r = '^((async )?function|class) \zs' . regex
    let lines = readfile(file)
    let matches = Findall2(lines, r)
    let keys = GetInputItems(matches)
    if Not(keys)
        return 
    else
        let text = ToString(lines)
        let items = GetFunctions(text, keys)
        call ToPasteBuffer(items)
    endif
endfunction

function! Mark5()
    
endfunction

function! MarklineJS()
    ec 'marking line for normal5 search'
    let [spaces, line] = GetSpacesAndLine()
    // function name(
    let name = GetSecondWord(line)
    call append(Relative(-1), [spaces . '// function ' . name . '('])
endfunction

function! Templar(s)
    let [spaces, line] = GetSpacesAndLine()
    let line = Templater(a:s, line)
    call setline('.', spaces . line)
endfunction

function! TemplarSlice(a, ...)
    let b = a:0 >= 1 ? a:1 : 0
    let a = a:a
    if IsString(a)
        let a = len(a)
    endif

    if IsString(b)
        let b = len(b)
    endif

    let [spaces, line] = GetSpacesAndLine()
    let A = a
    let B = -1 * (1 + b)
    ec A
    ec B
    let line = line[A:B]
    call setline('.', spaces . line)
endfunction

function! ToggleComment999()
    let lang = GetLang2()
    let s = trim(CurrentLine())
    if lang == 'css'
        if Test(s, '^/\*')
            return Templar('/* $0 */')
        else
            return TemplarSlice(3, -3)
        endif
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
        call LineSetter('AddOrRemoveComment')
    endif
endfunction

function! NewMain()
    let name = input('name for this component')
    let n = SprawlReplace('const main', 'const ' . name)
    if Not(n)
        return 
    endif

    let vuec = "const main = {\n    components: {" . name . ', },' . "\n    template: `\n        <div>\n        $c\n        </div>\n    `,\n    data() {\n        return {\n            \n        }\n    },\n}"
    let lines = ToLines(vuec)
    call insert(lines, '')
    call insert(lines, '')
    call add(lines, '')
    call append('$', lines)
endfunction

function! EatWord()
  let regex = '\s'
  "let s = getchar(0)
  let s = 'hiya'
  let c = nr2char(s)
  ec [c]
  return (c =~ regex) ? '' : c
endfunction

function! DefineSnippetFromFile(key)
    let file = CurrentFile()
    let key = a:key
    let length = len(key)
    if Test(key, ',')
        let key = Ncg(split(key, ','))
    endif
    let regex = '<(new )?' . key . '.{-}( |\(|\))'
    let matches = FindallStrings(ReadFile(FileGetter2(file)), regex)
    let template = "iabbrev <buffer> $1 $2$3<C-R>=Eatchar('\\s')<CR>"
    let seen = []
    let commands = []
    for item in matches
        let k = Replace(item, '[^a-zA-Z]+$', '')
        if Includes(k, seen)
            continue
        endif
        call add(seen, k)
        let abrev = ToAbrev(item, length)
        let value = Test(item, '\($') ? item . ")<LEFT>" : Replace(item, '[^a-zA-Z]+$', '')
        let expr = "iabbrev <buffer> " . abrev . ' ' . value . "<C-R>=Eatchar('\\s')<CR>"
        call add(commands, expr)
    endfor

    call InputStop(commands)
    call Iterate(commands, 'execute')
endfunction

function! StringTemplater(template, ref)
    let template = a:template
    let ref = a:ref
    let regex = '\$(\d+)'
    let snippet = Sub(template, regex, {x -> function('StringTemplateRunner')(x, ref)})
    return snippet
endfunction

function! SplitOnceHandler(fn, s)
    let [a,b] = SplitOnce(a:s)
    return function(a:fn)(a, b)
endfunction

function! OnVimStart()
   if v:vim_did_enter
     ec 'hi'
   else
       ec 'no'
    endif
endfunction

function! WOrWrite()
    return IsStartOfCommandLine() ? "w\<CR>": 'w'
endfunction

function! QOrQuit()
    return IsStartOfCommandLine() ? "q\<CR>": 'q'
endfunction

function! HOrHelp()
    return IsStartOfCommandLine() ? "h\<CR>": 'h'
endfunction

function! SetFtBufferShortcuts()
    let letters = ['j', 'p', 'h', 'v', 'm']
    for letter in letters
        let key = 'ft' . letter
        let path =  g:filedict[key]
        let s = "nnoremap <buffer> :call Append(" . SingleQuote(path) . ", DeleteLine())"
        ec s
    endfor
endfunction
function! GetExtension(...)
    let e = a:0 >= 1 ? Match(a:1, '\.\zs\w+$') : Match(expand('%:t'), '\.\zs\w+$')

    if !Exists(e) && Test(a:1, '^(js|py|vim|html)$')
        let e = a:1 
    endif
    if !Exists(e)
        let e = GetLang()
    endif
    return e
endfunction


