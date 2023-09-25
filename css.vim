let g:csscolormap = {'r1': 'red'}
let g:cssNumericIncrementMap = {}
let g:cssNumericDefaultValue = {'bounds': [[0, 100, 10]], 'fallback': 5}
let g:cssNumericIncrementMap['padding'] = 'default'
let g:cssParserRef = {}
let g:cssParserRef['bg'] = {'key': 'background', 'fn': 'CssColorTransform'}
let g:cssParserRef['fc'] = {'key': 'color', 'fn': 'CssColorTransform'}
let g:cssParserRef['ml'] = {'key': 'margin-left', 'fn': 'CssPmwh'}

" Demo
"""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""
" inoreab ws white-space: pre-wrap;<C-R>=Eatchar('\s')<CR>
" white-space: pre-wrap;
" white-space: pre-wrap;
" let g:cabmap = {}
" let g:indexedCabmap = {}
" let g:cabmap['ws'] = "white-space: pre-wrap;\nabc:def;"
" let g:cabmap['ws'] = [["white-space", "pre-wrap"], ["abc", "def"]]
" let g:indexedCabmap['white-space'] = ['a', 'b', 'c']
"""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""




inoreab <buffer> bc /*  */<LEFT><LEFT><LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer> <expr> ds '/* ' . strftime('%m-%d-%Y') . ' */'

function CssGetItems(s)
    let s = a:s
    let args = Xsplit(s)
    let items = filter(map(args, 'CssGetItem(v:val)'), '!empty(v:val)')
    let store = Flatten2D(items)
    return store
endfunction

function CssIncrement(dir)
    let dir = a:dir
    let s:dir = dir

            "white-space: a;
            "padding: 15px;

    function! Get12345(key, value)
        let key = a:key
        let value = a:value
        if has_key(g:indexedCabmap, key)
            return ModularIncrement2(g:indexedCabmap[key], value, s:dir)
        elseif has_key(g:cssNumericIncrementMap, key)
            let s:ref = g:cssNumericIncrementMap[key]
            if s:ref == 'default'
                let s:ref = g:cssNumericDefaultValue
            endif

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
        endif
    endfunction 

    function! Inner123(s)
        let s = a:s
        if Test(s, '\{ *$')
            return 
        endif
        let m = CssMatchLine(s)
        if empty(m)
            return 
        endif
        ec m
        let [front, key, current] = m
        let value = Get12345(key, current)
        let s = printf('%s%s: %s;', front, key, value)
        return s
    endfunction
    call GetSetFn('Inner123')

endfunction

    " align-items: center;
    " padding: 38px;
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
nnoremap <buffer> en :call CssEdit('number')<CR>
nnoremap <buffer> eo :call CssEdit('outline')<CR>
nnoremap <buffer> ed :call CssEdit('delete')<CR>
nnoremap <buffer> ev :call CssEdit('value')<CR>
function CssEditDelete(s)
    let s = a:s
    let s = Match(s, '^.{-}\ze:') . ': none;'
    return {'text': s}
endfunction

" call DeleteAllDigitsAndInsert()
let g:wpsnippets["vim"]["inner"] = "function Inner(s)\n    let s = a:s\n    $c\nendfunction"

let g:wpsnippets["css"]['"'] = "problem: 123 \nsolution: asdf\n$c"
let g:wpsnippets["css"]["123"] = "\" 1\n\" 2\n\" 3\n\" 4\n\" 5\n\" 6\n$c"
nnoremap <buffer> <space> :call CssIncrement(1)<CR>
inoremap <buffer> wp <esc>:call CssSnippetWP()<cr>a
inoremap <buffer> w, <esc>:call CssSnippetFromEnd()<cr>a



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
let g:indexedCabmap = {"width":["fit-content","max-content","min-content"],"height":["fit-content","max-content","min-content"],"size":["fit-content","max-content","min-content"],"display":["block","inline","inline-block","contents"],"position":["absolute","fixed","relative","static","sticky"],"font-size":["large","larger","medium","small","smaller"],"text-align":["center","end","justify","left","right","start"],"font-weight":["bold","bolder","lighter","normal"],"overflow":["hidden","scroll","visible"],"font-family":["Arial","Helvetica","sans-serif","Cambria","Cochin","Georgia","Times","Calibri"],"float":["inline-end","inline-start","left","right"],"text-decoration":["dashed","dotted","double","line-through","overline","solid","underline","wavy"],"vertical-align":["baseline","bottom","middle","sub","super","text-bottom","text-top","top"],"cursor":["pointer","crosshair","default"],"white-space":["normal","nowrap","pre","pre-line","pre-wrap"],"visibility":["collapse","hidden","visible"],"text-transform":["capitalize","lowercase","uppercase"],"clear":["both","left","right"],"justify-content":["center","start","end","left","right","stretch","space-evenly","flex-end","flex-start","space-around","space-between"],"align-items":["baseline","center","flex-end","flex-start","stretch"],"overflow-y":["hidden","scroll","visible"],"overflow-x":["hidden","scroll","visible"],"flex-direction":["column","column-reverse","row","row-reverse"],"flex-wrap":["nowrap","wrap","wrap-reverse"],"word-break":["break-all","keep-all","normal"],"text-rendering":["geometricPrecision","optimizeLegibility","optimizeSpeed"],"align-self":["baseline","center","flex-end","flex-start","stretch"],"object-fit":["contain","cover","fill","scale-down"],"resize":["both","horizontal","vertical"],"align-content":["center","flex-end","flex-start","space-around","space-between","stretch"],"flex-flow":["column","column-reverse","nowrap","row","row-reverse","wrap","wrap-reverse"],"justify-self":["normal","end","start","flex-end","flex-start","self-end","self-start","center","left","right","baseline","first","baseline","last","baseline","stretch"],"page-break-after":["always","avoid","left","right"],"mix-blend-mode":["normal","multiply","screen","overlay","darken","lighten","color-dodge","color-burn","hard-light","soft-light","difference","exclusion","hue","saturation","color","luminosity"],"text-decoration-style":["dashed","dotted","double","solid","wavy"],"line-break":["loose","normal","strict"],"justify-items":["normal","end","start","flex-end","flex-start","self-end","self-start","center","left","right","baseline"],"text-align-last":["center","justify","left","right"],"grid-auto-rows":["min-content","max-content","minmax()"],"grid-auto-flow":["row","column","dense"],"font-variant-caps":["all-petite-caps","all-small-caps","normal","petite-caps","small-caps","titling-caps","unicase"],"text-anchor":["end","middle","start"]}
let g:cabmap = {"document-page-container":[["position","relative"],["width","8.5in"],["height","11in"],["padding","0.5in"]],"flip":[["transform","rotate(180)"]],"fullscreen":[["width","100vw"],["height","100vh"]],"flex":[["display","flex"]],"flex-between":[["justify-content","space-between"],["display","flex"],["width","100%"]],"leftright":[["justify-content","space-between"],["display","flex"],["width","100%"]],"space-between":[["justify-content","space-between"],["display","flex"]],"jcsb":[["justify-content","space-between"]],"jcsa":[["justify-content","space-around"]],"jcse":[["justify-content","space-evenly"]],"jist":[["justify-items","stretch"]],"jis":[["justify-items","start"]],"jie":[["justify-items","end"]],"jic":[["justify-items","center"]],"ais":[["align-items","start"]],"aistr":[["align-items","stretch"]],"acstr":[["align-content","stretch"]],"aie":[["align-items","end"]],"aib":[["align-items","end"]],"aic":[["align-items","center"]],"aist":[["align-items","stretch"]],"jcs":[["justify-content","start"]],"jce":[["justify-content","end"]],"jcc":[["justify-content","center"]],"jcst":[["justify-content","stretch"]],"acs":[["align-content","start"]],"ace":[["align-content","end"]],"acc":[["align-content","center"]],"acst":[["align-content","stretch"]],"rel":[["position","relative"]],"relative":[["position","relative"]],"abs":[["position","absolute"]],"absolute":[["position","absolute"]],"fixed":[["position","fixed"]],"landscape":[["height","8.5"],["width","11in"]],"fwh":[["height","9.5in"]],"portrait":[["width","8.5in"],["height","11in"]],"outline":[["outline","1px solid red"]],"blue":[["color","blue"]],"dotted":[["border-style","dotted"]],"red":[["color","red"]],"box":[["width","100pt"],["height","100pt"],["box-sizing","border-box"],["*",""],["padding","0"],["margin","0"]],"reset":[["padding","0"],["margin","0"],["box-sizing","border-box"]],"bred":[["border","2px solid red"]],"orange":[["color","orange"]],"green":[["color","green"]],"violet":[["color","violet"]],"black":[["color","black"]],"white":[["color","white"]],"fitc":[["width","fit-content"]],"bgw":[["background","white"]],"bgy":[["background","yellow"]],"bgb":[["background","black"]],"blackwhite":[["background","black"],["color","white"]],"bgg":[["background","green"]],"absmiddle":[["position","absolute"],["left","0"],["right","0"],["margin","auto"]],"middle":[["position","absolute"],["top","50%"],["left","50%"],["transform","translate(-50%, -50%)"]],"abscenter":[["position","absolute"],["top","0"],["left","0"],["right","0"],["bottom","0"],["margin","auto"]],"wfc":[["width","fit-content"]],"mirror":[["display","inline-block"],["transform","scaleX(-1)"],["filter","FlipH"]],"flexwrap":[["display","flex"],["flex-wrap","wrap"]],"wrap":[["display","flex"],["flex-wrap","wrap"]],"horoflex":[["display","flex"],["align-items","center"]],"jsc":[["justify-self","center"]],"asc":[["align-self","center"]],"bugb":[["border","3px solid green"]],"bb":[["border","1px solid black"]],"bor":[["border","1px solid black"]],"border":[["border","1px solid black"]],"ored":[["outline","1px solid red"]],"oblue":[["outline","1px solid blue"]],"ogreen":[["outline","1px solid green"]],"ou":[["outline","unset"]],"ilb":[["display","inline-block"]],"inline":[["display","inline"]],"upper":[["text-transform","uppercase"]],"uppercase":[["text-transform","uppercase"]],"cap":[["text-transform","capitalize"]],"lower":[["text-transform","lowercase"]],"ofs":[["overflow","scroll"],["overflow-x","hidden"]],"ofx":[["overflow-x","hidden"]],"ofy":[["overflow-y","hidden"]],"bebas":[["font-family","bebas"]],"katex":[["font-family","KaTeX_Main"]],"whitespace":[["white-space","pre-wrap"]],"pre":[["white-space","pre-wrap"]],"west":[["top","50%"],["transform","translateY(-50%)"],["left","0"]],"float":[["float","right"]],"northeast":[["right","0"],["top","0"]],"east":[["right","0"],["top","50%"],["transform","translateY(-50%)"]],"south":[["bottom","0"],["left","50%"],["transform","translateX(-50%)"]],"mid":[["top","50%"],["transform","translateY(-50%)"],["left","0"]],"northwest":[["left","0"],["top","0"]],"nw":[["left","0"],["top","0"]],"code":[["font-family","source-code-pro, Menlo, Monaco, Consolas, 'Courier New', monospace"]],"centered":[["display","flex"],["align-items","center"],["justify-content","center"]],"center":[["display","flex"],["align-items","center"],["justify-content","center"]],"spacebetween":[["justify-content","space-between"]],"times":[["font-family","Times"]],"georgia":[["font-family","Georgia"]],"cp":[["font-family","Crimson Pro"]],"minion":[["font-family","minion"]],"crim":[["font-family","Crimson Text"]],"ct":[["font-family","Crimson Text"]],"noto":[["font-family","Noto Emoji"]],"mhauto":[["margin","0 auto"]],"mvauto":[["margin","auto 0"]],"mauto":[["margin","0 auto"]],"caps":[["text-transform","uppercase"]],"underline":[["border-bottom","1px solid currentColor"]],"bold":[["font-weight","bold"]],"italic":[["font-style","italic"]],"flexcol":[["display","flex"],["flex-direction","column"]],"tac":[["text-align","center"]],"block":[["display","block"]],"system":[["font-family","-apple-system, BlinkMacSystemFont, \"Segoe UI\", Roboto, Oxygen, Ubuntu, Cantarell, \"Helvetica Neue\", sans-serif"]],"arial":[["font-family","Arial"]],"courier":[["font-family","Courier"]],"bigbox":[["width","400px"],["height","400px"]],"ne":[["right","0"],["top","0"]]}
let g:allHtmlTags = ["polygon","i","input","br","stop","link","img","meta","caption","code","marker","html","pattern","foreignObject","table","th","td","tr","thead","tbody","defs","li","ol","ul","slot","svg","g","style","ol","footer","header","p","pre","script","body","ul","li","p","textarea","button","section","fieldset","legend","text","div","h1","h2","h3","main","blockquote","span","article","body","html","head","template","h4","h5","h6"]

function FastCSS(s)
    let s = a:s
    " let s = 'asdf bgr1'
    " let s = 'asdf bgr1 ws'
    " let s = 'asdf bgr1 center' (it works)
    let args = split(s, ' ')
    let className = CssAddPeriod(remove(args, 0))
    if len(args) == 0
        let snippet = printf("%s {\n    $c\n}\n", className)
        return InsertSnippet(snippet, '')
    endif

    let t = '    %s: %s;'
    let store = CssGetItems(args)
    let payload = map(store, 'printf(t, v:val[0], v:val[1])')
    call add(payload, '}')
    call add(payload, '')
    call add(payload, '')
    call insert(payload, className . ' {')

    call AppendBlockAtCursor(payload)

endfunction
function CssColorTransform(s)
    let s = a:s
    return get(g:csscolormap, s, s)
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

function! CssParser(key, value)
    let key = a:key
    let value = a:value

    if has_key(g:cssParserRef, key)
        let ref = g:cssParserRef[key]
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
function CssGetItem(s)
    let s = a:s
    " let s = 'ml123'
    " let s = 'bgr8'

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

function CssSnippetFromEnd()
    let s = getline('.')
    if Test(s, '^\S') && !Test(s, '\{ *$')
        let s = CssAddPeriod(s)
        let snippet = trim(s) . " {\n    $c\n}\n"
        call InsertSnippet(snippet, '')
    endif
endfunction

nnoremap <buffer> 1 :call CssIncrement(-1)<CR>
nnoremap <buffer> 2 :call CssIncrement(1)<CR>:w<CR>


function CssBracket()
    let [spaces, line] = GetSpacesAndLine()
    let parts = FindallStrings(match, '\w+')
    let line = line[0: offset]
    let Parser89 = {x -> function('PySnippetTemplater2')(x, parts, line)}
    let regex = '\$(\{.{-}\}|\d+|[A-Z])'
    let snippet = Sub(snippet, regex, Parser89)
    call PlaceSnippet(snippet, spaces)
endfunction

function CssSnippetWP()

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
