hi ErrorMsg ctermfg=White ctermbg = Black
hi MatchParen ctermbg=0
source /home/kdog3682/.vim/ftplugin/vimrc.january2024.vim

function! GetVimTextEditorState()
    let number = line('.')
    let s = a:0 >= 1 ? a:1 : getline(number)
    let pos = col('.') - 1
    let back_ch = s[pos - 2]
    let current_ch = s[pos - 1]
    let next_ch = s[pos]
    let front =  strpart(s, pos)
    let back = strpart(s, 0, pos)
    let data = {"line": {'text': s, 'number': number, 'length': len(s)}, 'char': {"pos": pos, "prev": back_ch, "current": current_ch, "next": next_ch},
        \'front': {s -> len(s) == 1 ? s == next_ch : Test(front, s)},
        \'back': {s -> len(s) == 1 ? s == prev_ch : Test(trim(back), s)},
    \}
    return data
endfunction

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
    if GetVimTextEditorState().front("(")
        return word
    endif
    return word . "()\<LEFT>"
endfunction
let g:execRef2["sgcw"] = "SetGCFW"
inoremap <buffer> <silent> <expr> <Tab> QQQ()

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

function! GetLibraryItem()
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
    let file = expand('%')
    let filetype = &filetype
    let data = {
        \'file': file,
        \'lineNumber': lineNumber,
        \'filetype': filetype,
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
nnoremap eev :call OpenBuffer4('/home/kdog3682/.vim/ftplugin/vimrc.january2024.vim')<CR>
let g:filedict["lu"] = "/home/kdog3682/2023/lezer-utils.js"

source /home/kdog3682/.vim/ftplugin/ToggleMappings.vim
autocmd! bufwritepost *.vim source ~/.vimrc
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

" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'preservim/nerdtree'
" Plug 'lifepillar/vim-mucomplete'
" Plug 'junegunn/vim-slash'
" call plug#begin('~/.vim/plugged')
" call Plug 'junegunn/fzf.vim'
" call plug#end()
" syntax off

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
let g:wpsnippets2["javascript"]["ssa"] = "/* prettier-ignore */ import {fooga, exprTemplater, stringifyIfNotPrimitive, panic, stringerf, wrapFunction, regexTemplater, iso8601, strftime, walkChildEntries, getFiletype, matchf, isUrl, looksLikeFunction, toArgument2, notNull, CumulativeStorage2, simpleAssign, findAndMatch, infuseObjectArray, regexGetter, splitArg, isJavascriptComment, runTest, everyOther, splitByRange, get_regex, getImports, isJavascriptFile, isValidDateString, WriteObject, equalityf, group2, splitOnce2, dedent4, isLowerCase, looksLikeRegExpString, isRegExpString, getDependencies, camelSplit, toggle3, countf, isLiteralObject, bindMethodsAndState2, call, mget3, looks_like_object_function, create_functions_from_master, toStringArgumentPretty, codeChunks, smart_map, run_tests, hasStartingCallable, mapTemplate, aliaser, fixSelector, htmlTags, removePythonComments, simpleStringBreaker, colonConfig, operations, error, redColon, so2, group, parseSingleLineJson, Items, findDependencies, tryf, find4, localeString, cssComment, colonConfigf, trimArray, parseCallable, bringToLifeTextFix, localBringToLife, getCaller4, getErrorStack, forEach, getBindings, getExports, matchstr, filter4, allEqual, count, isNativeFunction, repeat, getIndentAndText, StopWatch, stringDictSetter, getFunctionInfo, runRef, toLines, hasCallable, getProseWords, tally, paramify, codeSplit, debugConfig, logConfig, blueColon, toStringArgument3, stringCallable, simpleBinding, dashSplit4, appendBelow, appendAbove, removeLineComments, prependIfNecessary, smartDedent4, blueSandwich, walk4, findLineIndex, parseAB, applyTransform, kebabCase, getExcerpt, sortObject, buildFunction, maybeSort, parseFunction, isTypable, frontMatter, dictEntry, insertAfterIndex, State, bindMethods, cpop, tagRE, toggle2, createFunction2, assignIncrementedIndex, ufa, assignArray, regexFromComment, createParsersFromObject, imatch, globalConsoleDebug, bindMethodsAndState, isQuestion, oxfordComma, isUpperCase, getFunctionIdentifier, filter3, match, getMatch, alternatef, reCombine, assertion2, deepEqual, hasDollar, so, deepAssign, Tally, getFunctionNames, throwError, notEqual, tryString, prettyPrintCodeSnippet, prettyPrintErrorStack, iter, quotify, transformerf, assign, defineBinding, jspy, linebreak, stringCall2, reduce3, getClassParameters, assignOnTop2, isIdentifier, ndy, dashSplit3, runFunctionFromRef, equalf, alphabet, stateGetterFromSchema, mreplace, require, topLineComment, isChinese, replacef, ignoref, codeLibrary, splitLines, addArgumentQuotes, getBindings2, addCaret, mget2, getStartingConfig, incrementalEat, strlen, hr, setOnce, unescapeHtml, oxford, breakerf, runTests, map3, dateSplit, transformDict, walk3, toRegExp, tryAgainf, assertNotNull, getArgumentObject, isArgumentObject, typef, requireArg, keyAndValue, assignf, stateGetter3, objectFromArguments2, assignDefaults, transformValue, assign3, assignFresh3, evaluate3, scopedEvaluator, objectFromArguments, enforce, sub, filterObject, extractStartingJsonLikeConfig, unbrackify, newlineIndent2, deleteLine, both, normalizeIndent, getComment, secondComment, isStringRegExp, dashSplit2, clock, warning, errorStringify, alert, labelCase, bottomComment, stringCompose, getAnyIdentifier, chalkf, getNumbers, partitions, has, addUnit, toCallable, unquote, filter2, warn2, join2, caller2, assignOnce, longShort, shortLong, argPop, caller, assignOnTop, toggle, defineWindow, unescapeNewlines, escapeQuotes, unescapeQuotes, escapeNewlines, setAliases, announceCaller, removeStartingComments, smartBind, assignExisting, isObjectWithKey, eatStart, modularIncrementItem, getRegex, runFunction, isObjectLikeArray, itemGetter2, getAllKeys, prefixSlice, hasQuotes, assertion, diff, toggleState, initState, dunder, objectGetter, superTransform, popFilter, testRunner, assert2, insertAtDollar, popEmptyLine, getOptions, mergeSpecs, sortByKeys, map2, strictMessengerAssert, smartSplit, chalk4, typeLog, getFunctionName, Clock, search3, MyError, fuzzyMatch3, debugDisplay, getCaller3, messengerAssert, camelSlice, setPrototype, assignAliases, display, modifyNumber, toDict, setPush, modularIncrementIndex, longstamp, popIndex, toggleOnOff, locWrap, walk2, typeMatch, prettyStringify, getIdentifiers, CustomError, argMatch, brackify2, smartestDedent, modularIncrementNumber, AbstractMethodError, allUnique, Trie, boundarySplit, numberBoundarySplit, nodeLog, getFirst, defineProperty, supermix, partial, timeLog, timestamp, raise, getIdentifier, conditionalPrefix, conditionalSuffix, QueryList, fuzzyMatch2, buildDict, getTextAndCommand, sprawlFactory, getParameters2, pushf, intersection, union, blue, green, sandwich, getLastSpaces, smartDedent3, red, sort, debounce, checkValue, getCodeChunks, logf, boundary, myError, conditional, isStringFunction, toSpaces, objectf, searchAll, difference, singleQuote, itemGetter, slice2, mergeObjects, once, dashSplit, nchalk, coerceToObject, ArrayState, exporter2, indent2, iterator, removeAllComments, countParams, cumulativeSchemaAssign, argKwargSplit, argParse, removeInlineComments, getFrontMatter, hasHtmlSuffix, lazyArray, isThisFunction, escapeHTML, getKwargs2, search2, toStringArgument, createFuzzyMatch, edit2, splice, zip, merge2, argArgsKwargs, fill2, chalk, vueWrap, splitArray, splitArray2, warn, makeRunner2, searchf2, smartDedent2, dedent2, toArray2, stateGetter2, sortByIndex, IndexedCache, argo, curry2, doUntil2, evaluate2, findall2, findIndex2, findItem2, getCaller2, getErrorStack2, isJson, indexGetter2, insert2, pop2, parseError2, remove2, reduce2, testf2, type2, unshift2, waterfall2, xsplit2, Cache, cumulativeAssign, replaceBefore, topComment, isAsyncFunction, mapSort, getFileURI, getQuotes, isClassObject, isInitialized, getFallback, bindingRE, addObjectOrObjectProperty, forDoubles, isCss, log, iterate, backAndForth, round, iteratorWrapper, toJSON, isFromMap, toString, empty, conditionalString, getConfigArg, hasKey, errorWrap, successWrap, check, toPoints, bind, mixinAliases, isPercentage, isBasicType, reducerStrategy, gather, entries, stateGetter, methodCase, vueCase, push2, smarterIndent, lineSplit, Store, isSingleLetter, prepareText, isSymbol, getShortest, slice, KeyError, deepCopy, argsKwargs, isError, isColor, list, objectEditor, matchall, makeFastRunner, announce, hasLetter, filter, reduce, stringCall, capitalizeName, stop, proseCase, lineDitto, mixinSetters, modularIncrement, distinct, definedSort, groupBy, reWrap2, fuzzyMatch, isPlural, Element, parseError, isPrimitiveArray, callableArgsKwargs, waterfall, defineVariable, info, flat2D, splitThePage, handleError, dedent, TypeAssertion, createFunction, pluralize, remove, Group, PageStorage, Storage, UniqueStorage, Watcher, arrayToDict, addProperty, addQuotes, argWrapFactory, assert, abrev, abf, addExtension, assignFresh, antif, atFirst, atSecond, backspace, bindObject, breaker, blockQuote, brackify, bringToLife, comment, countCaptureGroups, capitalizeTitle, classMixin, callableRE, camelToTitle, curry, createVariable, changeExtension, curryStart, curryEnd, capitalize, copy, camelCase, compose, char2n, camelToDash, deepMerge, datestamp, doublef, dictSetter, dictSetter2, dsearch, doUntil, dashCase, doubleQuote, dict, dictGetter, depluralize, dreplace, dictf, endsWithWord, exporter, edit, exists, evaluate, extend, find, flatMap, fill, fixUrl, functionGetter, findall, fixPath, flat, fparse, findIndex, firstLine, ftest, getKwargs, getFirstName, getBindingName, getParameters, getLastWord, getCodeWords, getCodeWords2, getIndent, getExtension, getLast, getLongest, getChunks, getCaller, getStackTrace, getConstructorName, getFirstWord, getWords, getSpaces, hasComma, hasSpaces, hasHtml, hasBracket, hasNewline, hasCaptureGroup, hasEquals, hasValue, hasCamelCase, hasNumber, hackReplace, insert, indexGetter, incrementf, isCallable, isQuote, isEven, isOdd, isLast, isHTML, isNode, interweave, inferLang, isString, isArray, isObject, isDefined, isFunction, isPrimitive, isNumber, isSet, isNestedArray, indent, isNull, isWord, isBoolean, isRegExp, identity, isObjectLiteral, isJsonParsable, isCapitalized, isNewLine, isObjectArray, isStringArray, isClassFunction, joinSpaces, join, keyArrayToObject, lowerCase, linebreakRE, len, lineGetter, lineCount, lastLine, logConsole, makeRunner, mixin, modularf, matchGetter, merge, mget, map, mergeOnTop, mergeToObject, mapFilter, noop, nestPush, no, newlineIndent, n2char, objectWalk, overlap, objectToString, opposite, pipe, parseTopAttrs, pascalCase, partition, parens, push, pop, parseJSON, rigidSort, removeQuotes, rep, removeComments, range, removeExtension, rescape, reverse, reWrap, reduceToString, repeatUntil, swapKey, sayhi, swap, splitMapJoin, splitCamel, smallify, search, stringify, shared, smartDedent, stringBreaker, sleep, split, snakeCase, stringArgument, sorted, splitOnce, searchf, secondLine, titleCase, textOrJson, toNumber, toArgument, toNestedArray, test, type, tail, transformObject, trim, testf, toArray, templater, totalOverlap, upperCase, unique, uncapitalize, unzip, wrap, walk, wrapf, xsplit, yes, zip2} from \"./utils.js\"\n/* prettier-ignore */ import {componentManager, mdate, WriteFile, LogFile, vimFunctionConnector, tempFile, resolvePath, path2024, write2024, packageManager3, smart_path, createCodeString2, buildBindings2, JavascriptBuilder, ltf, appendVariable3, generateFile, generateImports, getStats, ff, createCodeString, finishConfig, findError2, onConfigStart, packageManager2, getFiles2, colonPackageManager, packageManagerSingletonRunColon, getText, packageManagerSingleton, oneArg, toVimVariable, headAndTail, absdir, getSection, sortByDate, dateTheFile, vimConnector, writeExportFile, pathJoin, jslib, pylib, backupFile, writeAndBackup, superFileGetter, submit, clipOrLog, fileGetter, toTimestamp, appendVariableFile, readParse, incrementalName, rfile, getJuneJson, isRecentFile, unmute, clip2, clip2 as c2, appendVariable2, moduleFunctionFactory, dirGetter, save, getRecentFile, fileOrText, logger, writeFromOptions, appendFileName, backup, getFiles, packageManager, mergeJson, fileFromKey, path, mergeFiles, writeUnitTest, runUnitTest, NodeError, isDir, NodeAssertion, sysArgs, sysArg, mute, abspath, getFile, logAction, head, getDir, dirFromPath, npath, textAndLang, shunt, sysget, append, prepend, currentFile, clip, isFile, normFileDir, normRead, normWrite, normAppend, normPrepend, normRpw, openFile, read, rpw, textGetter, write, getString, appendSelf, appendVariable, argv, exit, request} from \"./node-utils.js\"\n/* prettier-ignore */ import {asciiTable, MatchParserHTML, LineEditor, ScopedEvaluator, MatchParser, csv, pythonic} from \"./next2.js\""

let g:filedict["lt"] = "/home/kdog3682/2023/lezer-getTree.js"
let g:filedict["glt"] = "/home/kdog3682/2023/lezer-getTree.js"


let g:fileRef["tests.js"] = {}
let g:fileRef["tests.js"]["linked6"] = "evaluator.js"
let g:fileRef["tests.js"]["node1"] = {"run":"evaluator.js","argFile":"tests.js"}

function! RunPython(...)
    call Python('/home/kdog3682/PYTHON/run_apps.py', a:0 >= 1 ? a:1 : '')
endfunction
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
    """ the only thing we do is a timestamp.
    """ this file should never be looked at
    """ in the future, it will be parsed by chatgpt and turned into html
    let s = strftime('%s') . ' ' . a:s
    call AppendFile('/home/kdog3682/2024/.notes.txt', s)
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
let g:wpsnippets2["typst"]["imp"] = "#import \"base-utils.typ\": *"
