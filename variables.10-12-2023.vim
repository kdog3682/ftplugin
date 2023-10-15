let g:tempfile = '/home/kdog3682/.tempfile.js'
let g:state = {'lines':[], 'saveInsteadOfDelete': 0}
let g:vim = []
let g:vimNames = []
let g:lorem = {}
let g:memory = {}
let g:filedict["cc"] = "/home/kdog3682/2023/common.css"
let g:drivejsondir="/mnt/chromeos/GoogleDrive/MyDrive/JSONS"
let g:drivejsondir2023="/mnt/chromeos/GoogleDrive/MyDrive/JSONS 2023"
let g:jspyref2['js']['startingComment'] = '// '
let g:jspyref2['py']['startingComment'] = '# '
let g:jspyref2['vim']['startingComment'] = '" '
let g:filedict["bcs"] = "/home/kdog3682/2023/base-components.css"
let g:execRef["eat"] = "DefineEat"
let g:filedict["ex"] = "/home/kdog3682/2023/examples.js"
let g:wpsnippets["vim"]["ifem"] = "if Exists(m)\n    $c\nendif"
let g:wpsnippets["vim"]["00"] = "\" 0\n\" 1 \n\" 2\n\" 3\n\" 4"
let g:wpsnippets["vim"]["abc"] = "\" 0\n\" 1\n\" 2\n\" 3\n\" 4"
let g:execRef["node3"] = "SetNode3Fn"
let g:wpsnippets["js"]["hr"] = "------------------------------------------------------------"
let g:wpsnippets["js"]["hr2"] = "------------------------------------------------------------\n\n\n\n\n------------------------------------------------------------\n\n\n\n\n\n------------------------------------------------------------"
let g:filedict["git2"] = "/home/kdog3682/PYTHON/githubscript2.py"
let g:execRef["old"] = "ViewOldVersionOfFile"
let g:execRef["n"] = "FileNote"
let g:wpsnippets["py"]["b"] = "Blue('$1', $1)\n$c\n"
let g:filedict["ref"] = "/home/kdog3682/2023/runExampleFile.js"
let g:filedict["pye"] = "/home/kdog3682/PYTHON/examples.py"
let g:jspyref3 = {}
let g:jspyref3['markdown'] = {}
let g:jspyref3['javascript'] = {}
let g:jspyref3['python'] = {}
let g:jspyref3['vim'] = {}
let g:jspyref3['vim']['echoTemplate'] = 'echo "%s: " . string(%s)'
let g:jspyref3['python']['echoTemplate'] = 'print("%s", %s)'
let g:jspyref3['javascript']['echoTemplate'] = 'console.log("%s", %s)'
let g:jspyref3['vim']['echoReturnTemplate'] = 'return Print("%s: " . string(%s))'
let g:jspyref3['python']['echoReturnTemplate'] = 'print("%s", %s)'
let g:jspyref3['javascript']['echoReturnTemplate'] = 'console.log("%s", %s); throw '''';'
let g:jspyref3['vim']['prefix'] = 'let '
let g:jspyref3['python']['prefix'] = ''
let g:jspyref3['javascript']['prefix'] = 'const '
let g:jspyref3['vim']['backslash'] = '\'
let g:jspyref3['python']['backslash'] = ''
let g:jspyref3['javascript']['backslash'] = ''
let g:execRef["def"] = "DefineGeneral"
let g:wpsnippets["py"]["ift"] = "if test($1, $2):\n    $c"
let g:execRef["link"] = "LinkCurrentBufferAndPrevBuffer"
let g:linkedBufferGroups["/home/kdog3682/PYTHON/examples.py"] = ["/home/kdog3682/PYTHON/runExampleFile.py","/home/kdog3682/PYTHON/examples.py"]
let g:linkedBufferGroups["/home/kdog3682/PYTHON/runExampleFile.py"] = ["/home/kdog3682/PYTHON/examples.py","/home/kdog3682/PYTHON/runExampleFile.py"]
let g:filedict["pre"] = "/home/kdog3682/PYTHON/runExampleFile.py"
let g:execRef["dprint"] = "Dprint"
let g:wpsnippets["vim"]["gsf"] = "call GetSetFn('Inner')"
let g:wpsnippets["vim"]["inner"] = "function! Inner(s)\n    let s = a:s\n    $c\nendfunction"
let g:linkedBufferGroups["/home/kdog3682/2023/runExampleFile.js"] = ["examples.js","/home/kdog3682/2023/runExampleFile.js"]
let g:linkedBufferGroups['/home/kdog3682/2023/examples.js'] = ["/home/kdog3682/2023/runExampleFile.js",'/home/kdog3682/2023/examples.js']
let g:execRef["mw"] = "MarkWord"
let g:filedict["vg"] = "/home/kdog3682/2023/vim.grammar"
let g:wpsnippets["grammar"] = {}
let g:wpsnippets["grammar"]["eat"] = "inoreab <buffer>$1 $2<C-R>=Eatchar('\\s')<CR>"
let g:wpsnippets["js"]["eat"] = "inoreab <buffer>$1 $2<C-R>=Eatchar('\\s')<CR>"
let g:wpsnippets["py"]["eat"] = "inoreab <buffer>$1 $2<C-R>=Eatchar('\\s')<CR>"
let g:wpsnippets["vim"]["eat"] = "inoreab <buffer>$1 $2<C-R>=Eatchar('\\s')<CR>"

let g:python1dict2 = {
    \'examples.py': {'file': 'runExampleFile.py', 'args': 'lineNumber'},
\}

let g:node1dict2 = {
    \'examples.js': {'key': 'runExampleFile', 'args': 'lineNumber'},
    \'lezer-J2P.js': {'file': 'lezer-prettier.js', 'args': ''},
    \'lezer-P2V.js': {'file': 'lezer-prettier.js', 'args': ''},
    \'lezer-P2J.js': {'file': 'lezer-prettier.js', 'args': ''},
    \'lezer-common.js': {'file': 'lezer-prettier.js', 'args': ''},
    \'lezer-run.js': {'file': 'lezer-prettier.js', 'args': ''},
    \'lezer-create.js': {'file': 'lezer-prettier.js', 'args': ''},
\}

let g:execRef["m"] = ":messages"
let g:filedict["lc"] = "/home/kdog3682/2023/lezer-common.js"
let g:wpsnippets["js"]["fooboo"] = "let s = `\n\nfunction foo() {\n    $c\n}\nfunction bo() {\n    \n}\n`"
let g:jspyref2['js']['shellFn'] = 'Node'
let g:jspyref2['py']['shellFn'] = 'Python3'
let g:jspyref2['py']['dir'] = '/home/kdog3682/PYTHON/'
let g:jspyref2['js']['dir'] = '/home/kdog3682/2023/'
let g:execRef["ebg"] = "EstablishLinkedBufferGroup"
let g:execRef["link"] = "EstablishLinkedBufferGroup"
let g:linkedBufferGroups["/home/kdog3682/2023/lezer-P2V.js"] = "/home/kdog3682/2023/lezer-prettier.js"
let g:linkedBufferGroups["/home/kdog3682/2023/lezer-P2J.js"] = "/home/kdog3682/2023/lezer-prettier.js"
let g:wpsnippets["vim"]["eval"] = "EvalTheLine"
let g:wpsnippets["js"]["foo"] = "class Foo {\n    constructor() {\n    }\n}\nconst f = new Foo()\n$c"
let g:execRef["lc"] = "LogConsole"
let g:node1dict2['lezer-CodeLibrary.js'] = {'file': 'lezer-main.js', 'args': ''}
let g:node1dict3 = {}
let g:node1dict3['vim.py'] = 'lezer-main.js'
let g:node1dict3['lezer-CodeLibrary.js'] = 'lezer-main.js'
let g:execRef["rcw"] = "ReplaceCurrentWordWithPaste"
let g:wpsnippets["py"]["import"] = "from base import *\nfrom next import *"
let g:filedict["lcl"] = "/home/kdog3682/2023/lezer-CodeLibrary.js"
let g:filedict["lm"] = "/home/kdog3682/2023/lezer-main.js"
let g:filedict["lp"] = "/home/kdog3682/2023/lezer-prettier.js"
let g:execRef["eod"] = "EndOfDay"
let g:linkedImportFileRef = {}
let g:linkedImportFileRef['examples.js'] = 'runExampleFile.js'
let g:wpsnippets["vim"]["fore"] = "for i in range(len($1))\n    ec i\n    $c\nendfor"
let g:wpsnippets["vim"]["ifempty"] = "if empty($c)\n    return \nendif"
let g:wpsnippets2 = {}
let g:wpsnippets2['vimrc'] = {}
let g:wpsnippets2['examples.py'] = {}
let g:wpsnippets2['vimrc'] = {'a': "if empty($c)\n    return \nendif"}
let g:wpsnippets2["examples.py"]["r"] = "${Linebreak(65)}\nsubreddit: $a\ntitle: $b\nbody: \n\n$c\n${Linebreak(65)}"
let g:filedict["exp"] = "/home/kdog3682/PYTHON/examples.py"
let g:writenotesref = {}
let g:writenotesref['st'] = 'FILE-STATUS "$t" $arg'
let g:writenotesref['F'] = "FILE-NOTE\nfile: $t\nstatus:\ntext:\n"
let g:writenotesref['f'] = "FUNCTION-NOTE\nfile: $t\nidentifier: $binding\nline: $line\nlineNumber: $lineNumber\nnote: $c"
let g:writenotesref['ac'] = "ACTION-CHAIN"
let g:writenotesref['todo'] = "TODO\nfile: $t\nticket: %s\n"
let g:writenotesref['td'] = "TODO\nfile: $t\nticket: %s\n"
let g:writenotesref['cn'] = "CODE NOTES\nfile: %s\nfunction: %s\nnote: %s\ncomment: \n"
let g:wpsnippets["py"]["for"] = "for ${GetForIterationVariable($1)} in $1):\n    $c"
let g:wpsnippets2["examples.py"]["booga"] = "for ${GetForIterationVariable($1)} in $1):\n    $c\n    $date"
let g:execRef["gfgf"] = "RegisterGfGfItem"
let g:gfgfdict['snip'] = ['/home/kdog3682/.vimrc', 'Snippeteer', 0]
let g:gfgfdict['node1'] = ['/home/kdog3682/.vimrc', 'Node1', 0]
let g:gofiledict = {}
let g:gofiledict['help.md'] = 'GoFileViaHelpMD'
let g:gofiledict['vimrc'] = 'GoFileViaHelpMD'
let g:depdir = '/mnt/chromeos/GoogleDrive/MyDrive/DEPRECATED/'
let g:wpsnippets["vim"]["while"] = "while 1\n  $c\nendwhile"
let g:wpsnippets["vim"]["ifz"] = "if IsZero($1)\n    return\nendif\n$c\n\n"
let g:wpsnippets["vim"]["ifts"] = "if Test(s, '$c')\n     return\nendif"
let g:gfgfdict['mdtab'] = ['/home/kdog3682/.vimrc', 'MarkdownTab', 0]
let g:visualactiondict['sh'] = {'fn': 'VisualShunt', 'i': 'fileblock'}
let g:visualactiondict['delchars'] = {'replace': 1, 'fn': 'VisualDeleteSpecificChars', 'i': 'contiguous'}
let g:gfgfdict['fg'] = ['/home/kdog3682/.vimrc', 'FileGetter2', 0]
let g:execRef["runcp"] = "RunPasteBufferFunction"
let g:execRef["r"] = "RunPasteBufferFunction"
let g:wpsnippets["vim"]["lets"] = "let s = a:0 >= 1 ? a:1 : getline('.')"
let g:execRef["remap"] = "RemapNormalCommandToExecHandlerOrSomethingElse"
let g:gfgfdict['vsh'] = ['/home/kdog3682/.vimrc', 'VisualShunt', 0]
let g:execRef["exec"] = "ExcuteInline"
let g:filedict["plug"] = "/home/kdog3682/.vim/autoload/plug.vim"
let g:execRef["g"] = "GoyoHandler"
let g:execRef["save"] = "SaveHandler"
let g:gfgfdict['tc'] = ['/home/kdog3682/PYTHON/next.py', 'toCallableFromConfig', 0]
let g:visualactiondict['replacewith'] = {'fn': 'VisualReplacer', 'i': 'select'}
let g:visualactiondict['link'] = {'fn': 'VisualLink'}
let g:visualactiondict['eat'] = {'fn': 'VisualEat'}
let g:gfgfdict['va'] = ['/home/kdog3682/.vimrc', 'VisualAction', 0]
let g:linkedBufferGroups["/home/kdog3682/2023/index.grammar"] = "['/home/kdog3682/2023/index.grammar', '/home/kdog3682/2023/index.tokens.js']"
let g:linkedBufferGroups["/home/kdog3682/2023/index.tokens.js"] = "['/home/kdog3682/2023/index.grammar', '/home/kdog3682/2023/index.tokens.js']"
let g:keyboard = {}
let g:keyboard['CO'] = "\<C-O>"
let g:keyboard['co'] = "\<C-O>"
let g:keyboard['LEFT'] = "\<LEFT>"
let g:keyboard['RIGHT'] = "\<RIGHT>"
let g:keyboard['NL'] = "\n"
let g:wpsnippets2["global"] = {}
let g:wpsnippets2["global"]["d"] = "LineDittoOctober2023"
let g:errors = {}
let g:errors['IsFile'] = -100
let g:errors['IsDir'] = -100
let g:errors['Exists'] = -88
let g:filedict["eod"] = "/home/kdog3682/PYTHON/endOfDay.py"
let g:gfgfdict['pys'] = ['/home/kdog3682/.vimrc', 'PySnippet', 0]
let g:gfgfdict['sn'] = ['/home/kdog3682/.vimrc', 'SmartNine', 0]
let g:gfgfdict['se'] = ['/home/kdog3682/.vimrc', 'SmartEqual', 0]
let g:wpsnippets["vim"]["jspy"] = "let g:jspyref3['vim']['$1'] = '$2'\nlet g:jspyref3['python']['$1'] = '$3'\nlet g:jspyref3['javascript']['$1'] = '$4'"
let g:wpsnippets["vim"]["va"] = "let g:visualactiondict['$1'] = {'fn': '$2'}"
let g:jspyref3['javascript']['identifierRE'] = '(^ *\w+ +)\zs[\{\[]?\w+.{-}\ze *\='
let g:jspyref3['vim']['identifierRE'] = '(^ *\w+ +)\zs\[?\w+.{-}\ze *\='
let g:jspyref3['python']['identifierRE'] = '^ *\w+.{-}\ze *\='
let g:keyboard['eatchar'] = "\<C-R>=Eatchar('\s')\<CR>"
let g:execRef["c"] = "CheckExecRef"
let g:execRef["chk"] = "CheckExecRef"
let g:execRef["startdate"] = "GotoStartingDate"
let g:gfgfdict['sq'] = ['/home/kdog3682/.vimrc', 'SmartQuote', 0]
let g:fruits = ['apple', 'banana', 'cherry', 'date', 'elderberry', 'fig', 'grape', 'honeydew', 'kiwi', 'lemon']
let g:wpsnippets["vim"]["ifem"] = "if empty($1)\n    $c\nendif\n"
let g:jspyref3['vim']['shuntdownGrabRE'] = '^(iab|iabbrev|nnoremap|inoremap|vnoremap|cnoremap|nnoremenu|inoremenu|vnoremenu|cnoremenu|noreabbrev|noremenu|nmap|imap|vmap|cmap|inoreab|set|iunmap|nunmap|source)>'
let g:jspyref3['python']['shuntdownGrabRE'] = '^(#|//|\w+(\.\w+)*\().+'
let g:jspyref3['javascript']['shuntdownGrabRE'] = '^(#|//|\w+(\.\w+)*\().+'
let g:state.breakerCount = 0
let g:jspyref3['vim']['libraryLoaderKeys'] = 'vimkeys'
let g:jspyref3['python']['libraryLoaderKeys'] = 'pythonkeys'
let g:jspyref3['javascript']['libraryLoaderKeys'] = 'javascriptkeys'
let g:execRef["gvf"] = "GotoVimFunction"
let g:jspyref3["vim"]["functionBlockTemplate"] = "function %s(%s)" . " {\<CR>}\<C-O>O"
let g:jspyref3["javascript"]["functionBlockTemplate"] = "function %s(%s)" . " {\<CR>}\<C-O>O"
let g:jspyref3["python"]["functionBlockTemplate"] = "def %s(%s)" . " :\<CR>"
let g:jspyref3["python"]["methodBlockTemplate"] = "def %s(self, %s)" . " :\<CR>"
let g:jspyref3["javascript"]["methodBlockTemplate"] = "%s(%s)" . " {\<CR>}\<C-O>O"
let g:jspyref3['vim']['objectBlockTemplate'] = 'x'
let g:jspyref3['python']['objectBlockTemplate'] = 'x'
let g:jspyref3['javascript']['objectBlockTemplate'] = "%s(%s) {\n\t$c\n},\n"
let g:wpsnippets["js"]["run"] = "\nfunction runner(${Depluralize($1)}, i) {\n    $c\n}\n\nconst results = $1.map(runner)\nreturn results\n"
let g:wpsnippets["vim"]["fore"] = "for i in range(len($1))\n    let ${Depluralize($1)} = $1[i]\n    $c\nendfor"
let g:functionParamRef = {'runner': ['s'], 'inner': ['s']}
let g:jspyref3['vim']['equalDict'] = {}
let g:jspyref3['python']['equalDict'] = {}
let g:jspyref3['javascript']['equalDict'] = {}
let g:gfgfdict['se'] = ['/home/kdog3682/.vimrc', 'SmartEqual', 0]
let g:execRef["verbose"] = "CheckVerbose"
let g:visualactiondict['lbh'] = {'fn': 'VisualLookBehind'}
let g:wpsnippets["vim"]["bif"] = "if Test(s, '$c')\n    $creturn Cursor(s)\n\nelseif Test(s, '')\n    let m = \n    return \n\nelseif Test(s, '')\n    let m = \n    return \n\nelseif IsNumber(s)\n    return\n\nelseif has_key(ref, a)\n    let m = ref[a]\nelse\n    return "
let g:wpsnippets["vim"]["bift"] = "if Test($1, '')\n    $c\nelseif Test($1, '')\n\nelseif Test($1, '')\n\nelseif Test($1, '')\n    \nelse\n    return \nendif"
let g:wpsnippets["vim"]["bift"] = "if Test($1, '')\n    $c\n\treturn\nelseif Test($1, '')\n    \n    return\nelseif Test($1, '')\n    \nelseif Test($1, '')\n    \nelse\n    return \nendif"
let g:gfgfdict['jc'] = ['/home/kdog3682/.vimrc', 'JavascriptComplete', 0]
let g:filedict["mt"] = "/home/kdog3682/2023/mappings.txt"
let g:wpsnippets["vim"]["forkv"] = "for [k, v] in items($1)\n    $c\nendfor"
let g:gfgfdict['jp'] = ['/home/kdog3682/.vimrc', 'JPCreateFunctionBlockAsExpression', 0]
let g:wpsnippets["vim"]["ifhk"] = "if has_key($1, $2)\n    let Item = $1[$2]\nendif"
let g:gfgfdict['qt'] = ['/home/kdog3682/.vimrc', 'TestingSearchInsideOfExprViaQT', 0]
let g:jspab = {}
let g:jspab['dict'] = {'params': 'v, k'}
let g:wpsnippets["vim"]["ifeq"] = "if $1 == '$2'\n    $c\nelseif $1 == '$2'\nelse\nendif"
let g:gfgfdict['api'] = ['/home/kdog3682/.vimrc', 'AddPydictItem', 0]
let g:wpsnippets2["examples.js"] = {}
let g:wpsnippets2["examples.js"]["io"] = "inpath: $1\noutpath: $c\n"
let g:visualactiondict['var'] = {'fn': 'VReplaceWithinRange'}
let g:execRef["unmap"] = "UnmapHandler"
let g:execRef["um"] = "UnmapHandler"
let g:gfgfdict['qf'] = ['/home/kdog3682/.vimrc', 'QSlashWordFind', 0]
let g:gfgfdict['q/'] = ['/home/kdog3682/.vimrc', 'QSlashWordFind', 0]
let g:vimCurrentTestFunction = 'JPCreateFunctionBlockAsExpression'
let g:vimCurrentTestFunctionArgs = []
let g:gfgfdict['gvf'] = ['/home/kdog3682/.vimrc', 'GotoVimFunction', 0]
let g:gfgfdict['gfgf'] = ['/home/kdog3682/.vimrc', 'GoFileGoFunction', 0]

let g:globalAliases = {
    \'wami': 'currentLocation',
    \'asdfasdfa': 'b',
    \'v': 'vimCurrentTestFunction',
    \'qtf': 'vimCurrentTestFunction',
\}

let g:gfgfdict['ditto'] = ['/home/kdog3682/.vimrc', 'DittoCopy', 0]
let g:cleverTabRef = {}
let g:execRef["r.eq"] = "RegisterEqualDict"
let g:jspyref3['vim']['equalDict']['ind'] = 'GetIndent()'
let g:vimCurrentNormalFunctionArgs = []
let g:vimCurrentNormalFunction = 'JPCreateFunctionBlockNormal'
let g:keyboard['eat'] = "\<C-R>=Eatchar('\\s')\<CR>"
let g:keyboard['exit'] = "\<C-C>"
let g:gfgfdict['de'] = ['/home/kdog3682/.vimrc', 'DefineEat', 0]
let g:jspyref3['vim']['functionRefFile'] = '/home/kdog3682/.vim/ftplugin/functions2.vim'
let g:jspyref3['python']['functionRefFile'] = '/home/kdog3682/PYTHON/base.py'
let g:jspyref3['javascript']['functionRefFile'] = '/home/kdog3682/2023/utils.js'
let g:execRef["nmap"] = "DefineNmap"
let g:execRef["er"] = "DefineER"
let g:visualactiondict['mvo'] = {'fn': 'VMoveBlockOutwards'}"
let g:visualactiondict['ind'] = {'fn': 'VIndentBlock'}"

let g:apae_map_templates = {
    \'ibe': "nnoremap <silent> <buffer> <expr> %s %s()<CR>",
    \'nbe': "nnoremap <silent> <buffer> <expr> %s %s()<CR>",
    \'nnoremap': "nnoremap <silent> <buffer>%s :call %s()<CR>",
    \'imap': "nnoremap <silent> <buffer>%s %s()<CR>",
    \'inoremap': "inoremap <silent> <buffer> <expr> %s %s()",
    \'no': "nnoremap <buffer>%s :call %s()<CR>",
    \'va': "let g:visualactiondict['%s'] = {'fn': '%s'}",
\}

let g:execRef["debug"] = "ToggleDebugMode"
let g:keyboard['O'] = "O"
let g:execRef["qt"] = "DefineQTFunction"
let g:vimCurrentTestFunction = "QObject"
let g:vimCurrentTestFunction = "NothingInfrontOfCursor"
let g:execRef["split"] = "SplitFileAtCurrentLine"
let g:filedict["vf2"] = "/home/kdog3682/.vim/ftplugin/functions2.vim"
let g:commandsearchdirection = '?'
let g:commandsearchvalue = "\\w+\\("
let g:commandsearchmode = ''
let g:codepoints = {"13": "\<CR>", "110":"n","104":"h","112":"p","113":"q","114":"r","115":"s","116":"t","105":"i","118":"v","119":"w","50":"2","51":"3","52":"4","53":"5","54":"6","55":"7","56":"8","57":"9","58":":","59":";","108":"l","109":"m","89":"Y","97":"a","92":"\\\\","98":"b","107":"k","99":"c","80":"P","81":"Q","82":"R","83":"S","84":"T","85":"U","86":"V","87":"W","88":"X","32":" ","33":"!","34":"\"","35":"#","36":"$","37":"%","38":"&","39":"'","111":"o","120":"x","121":"y","122":"z","123":"{","124":"|","125":"}","126":"~","117":"u","60":"<","61":"=","62":">","63":"?","64":"@","65":"A","66":"B","67":"C","68":"D","69":"E","100":"d","101":"e","102":"f","103":"g","90":"Z","91":"[","106":"j","93":"]","94":"^","95":"_","96":"`","40":"(","41":")","42":"*","43":"+","44":",","45":"-","46":".","47":"/","48":"0","49":"1","70":"F","71":"G","72":"H","73":"I","74":"J","75":"K","76":"L","77":"M","78":"N","79":"O"}
let g:keyboard['bindingprefix'] = '(var|const|async|function[!*]\?|class|def) '
let g:activeshuntfile = ''
let g:jspyref3['vim']['regexDelim'] = "''"
let g:jspyref3['python']['regexDelim'] = "''"
let g:jspyref3['javascript']['regexDelim'] = '//'
let g:memory["implicitParams"] = {}
let g:memory["implicitParams"]["'.'"] = "s"
let g:keyboard = {"esc":"\<esc>","tab":"\<tab>","enter":"\<CR>","space":"\<space>","bs":"\<bs>","del":"\<del>","up":"\<up>","down":"\<down>","left":"\<left>","right":"\<right>","home":"\<home>","end":"\<end>","pageup":"\<pageup>","pagedown":"\<pagedown>","f1":"\<f1>","f2":"\<f2>","f3":"\<f3>","f4":"\<f4>","f5":"\<f5>","f6":"\<f6>","f7":"\<f7>","f8":"\<f8>","f9":"\<f9>","f10":"\<f10>","f11":"\<f11>","f12":"\<f12>","insert":"\<insert>","ca":"\<c-a>","cb":"\<c-b>","cc":"\<c-c>","cd":"\<c-d>","ce":"\<c-e>","cf":"\<c-f>","cg":"\<c-g>","ch":"\<c-h>","ci":"\<c-i>","cj":"\<c-j>","ck":"\<c-k>","cl":"\<c-l>","cm":"\<c-m>","cn":"\<c-n>","co":"\<c-o>","cp":"\<c-p>","cq":"\<c-q>","cr":"\<c-r>","cs":"\<c-s>","ct":"\<c-t>","cu":"\<c-u>","cv":"\<c-v>","cw":"\<c-w>","cx":"\<c-x>","cy":"\<c-y>","cz":"\<c-z>"}
let g:keyboard.jsb = " {\<CR>}\<C-O>O"
let g:keyboard.jslambda = " {\\<CR>})\\<C-O>O"
let g:keyboard.jslambdareduce = " {\<CR>}, {})\<C-O>O"
let g:keyboard['BS'] = "\<BS>"
let g:keyboard['ENTER'] = "\<CR>"
let g:keyboard['left'] = "\<left>"
let g:keyboard['right'] = "\<right>"
let g:expressionTemplates = {}
let g:expressionTemplates['map'] = "%s((%s) =>" . g:keyboard.jslambda
let g:expressionTemplates['reduce'] = "%s((acc, %s) =>" . g:keyboard.jslambdareduce
let g:expressionTemplates['filter'] = "%s((%s) =>" . g:keyboard.jslambda
let g:memory["lambdaFunctionNames"] = {}
let g:memory["lambdaFunctionNames"]["checkpoint"] = "1"
let g:keyboard.empty = ''
let g:keyboard.eol = "\<C-O>A"
let g:wpsnippets2['vim'] = {}
let g:wpsnippets["vim"]["ca"] = "call AppendFile('$1', $2)"
let g:wpsnippets["vim"]["ifl"] = "if len($1) < $2\n\t$c\nelseif\n    \nelse\nendif"
let g:gfgfdict['gvs'] = ['/home/kdog3682/.vimrc', 'GetVimStateArg', 0]
let g:keyboard.searchexpr = "\<ESC>zz?%s?e\<CR>i"
let g:keyboard.dts = "\<ESC>^Da"
let g:keyboard.O = "O"
let g:execRef["imap"] = "DefineImap"
let g:wpsnippets2["examples.js"]["js"] = "--------------------------------------------------------------\ndate: $date\ninpath: ${FileGetter2($1)}\n\n\n$c"
let g:wpsnippets2["examples.js"]["jso"] = "--------------------------------------------------------------\ndate: $date\n$Ask()\n\n\n$c"
let g:fileSpecificRef = {}
let g:fileSpecificRef['examples.js'] = {}
let g:fileSpecificRef['examples.js']['eval'] = {}
let g:fileSpecificRef["examples.js"]['eval']["ask"] = {'callable': 'Ask1000()', 'after': 'AppendBlockAtCursor'}
let g:wpsnippets2["vimrc"]["va"] = "function VA$cap($1)(state)\n\tlet state = a:state\n\t$c\nendfunction\n\nlet g:visualactiondict['${$1[0:2]}'] = {'fn': 'VA$cap($1)'}"
let g:gfgfdict['ler2'] = ['/home/kdog3682/.vimrc', 'ExecuteFunctionCaller2', 0]
let g:memory["lambdaFunctionNames"]["config"] = "x"
let g:vimCurrentTestFunction = "SmartNine"
let g:execRef["lbu"] = "BackupFileLocally"
let g:execRef["bu"] = "BackupFile"
let g:wpsnippets["vim"]["bp"] = "call BluePrompt(\"\n    \\\\n $c\n    \\\\n \n\\\\n\\n\", $1)"
let g:wpsnippets["vim"]["bpr"] = "call BluePrint(\"\n    \\\\n $c\n    \\\\n \n\\\\n\\n\", $1)"
let g:execRef["rlbu"] = "RevertFromLocalBackup"
let g:memory["localTemporaryBackupFile"] = '/home/kdog3682/2023/runExampleFile.js'
let g:execRef["vimt"] = "VimTest"
let g:execRef["rw"] = "WrapCurrentWordWithStringCall"
let g:execRef["asdf"] = "Jspy3"
let g:VimNativeFunctions = ['copy', 'map', 'filter']
let g:wpsnippets["vim"]["rp"] = "call RedPrompt(\"\n    \\\\n $c\n    \\\\n \n \\\\n \\n\")\n"
let g:execRef["t"] = "AppendTestStringToBottomOfVimFile"
let g:gfgfdict['gfl'] = ['/home/kdog3682/.vimrc', 'GotoVimFunction', 0]
let g:wpsnippets["vim"]["forkv"] = "for [k,v] in items($1::upbinding)\n    $c\nendfor"
let g:jspyref3['javascript']['blockPairs'] = { '^ *(for|while|if|else|do|function)>': '}', '[ *$': ']', '\{ *$': '}', }
let g:jspyref3['python']['blockPairs'] = { '[ *$': ']', '\{ *$': '}', }
let g:jspyref3['vim']['blockPairs'] =  { '[ *$': '\]', '\{ *$': '\}', '^ *for': 'endfor', '^ *(if|elseif)>': '(else|end)if', }
let g:execRef["bc"] = "BrowserController"

let g:GI4Ref = {
	\'cob': 'GICob',
	\'contiguous': 'GISmartBlock',
	\'smart': 'GISmartBlock',
	\'line': 'GILine',
	\'window': 'GIWindow',
	\'window10': 'GIWindow10',
	\'vueTemplate': 'GITildaBlock',
	\'tilda': 'GITildaBlock',
	\'date': 'GIDateBlock',
	\'method': 'GIMethodBlock',
	\'aaa': 'GITildaBlock',
	\'bbb': 'GITildaBlock',
	\'code': 'GetCodeIndexes',
\}

let g:jspyref3['vim']['commentPrefix'] = '"'
let g:jspyref3['python']['commentPrefix'] = '//'
let g:jspyref3['javascript']['commentPrefix'] = '#'
let g:execRef["cq"] = "ToggleSingleOrDoubleQuotes"
let g:execRef["mcw"] = "MarkCurrentWork"
let g:execRef["resource"] = "ResourcePluginFile"
let g:execRef["gj"] = "JumpController"
let g:execRef["tls"] = "ToggleLocalStateController"
let g:execRef["ecw"] = "EvalCurrentWord"
let g:execRef["dv"] = "DefineGlobalVar"
let g:lastKey = ""
let g:execRef["aft"] = "AppendTestStatementToFunction"
let g:execRef["mrf"] = "MostRecentFile"
let g:vimfiles = ['/home/kdog3682/.vimrc', '/home/kdog3682/.vim/ftplugin/functions2.vim', '/home/kdog3682/.vim/ftplugin/functions.vim']

let g:vimFunctionAliases = {
	\'spaces': 'GetSpaces',
	\'prompt': 'Prompt',
	\'line': 'TrimLine',
	\'lineNumber': 'GetLineNumber',
	\'date': 'DateStamp',
	\'datestamp': 'DateStamp',
	\'time': 'TimeStamp',
	\'timestamp': 'TimeStamp',
	\'binding': 'GetBindingName',
	\'upbinding': 'GetUpbinding',
	\'var': 'GetClosestVar',
    \'param': 'GetClosestParam',
	\'glf': 'GetMostRecentFile',
	\'cw': 'GetCurrentWord4',
	\'cf': 'CurrentFile',
	\'lastIdentifier': 'GetLastIdentifier',
	\'tail': 'Tail',
\}

let g:cdnLinks = {
        \ "vue": "https://cdn.jsdelivr.net/npm/vue/dist/vue.min.js",
        \ "marked": "https://cdn.jsdelivr.net/npm/marked/marked.min.js",
        \ "jquery": "https://code.jquery.com/jquery-3.6.0.min.js",
        \ "lodash": "https://cdn.jsdelivr.net/npm/lodash/lodash.min.js",
        \ "axios": "https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js",
        \ "moment": "https://cdn.jsdelivr.net/npm/moment/min/moment.min.js",
        \ "codemirror": "https://cdn.jsdelivr.net/npm/codemirror@5.62.2/lib/codemirror.js",
        \ "nerdamer": "https://cdn.jsdelivr.net/npm/nerdamer/nerdamer.min.js",
        \ "d3": "https://cdn.jsdelivr.net/npm/d3@7.0.0/dist/d3.min.js",
        \ "chartjs": "https://cdn.jsdelivr.net/npm/chart.js@3.7.0/dist/chart.min.js"
\ }

let g:assets = {'cdn': g:cdnLinks}
let g:wpsnippets["vim"]["bp"] = "let answer = BluePrompt(\"\n    \\\\n $c\n\\\\n\\n\")"
let g:wpsnippets["vim"]["rp"] = "let answer = BluePrompt(\"\n    \\\\n $c\n\\\\n\\n\")"
let g:wpsnippets["vim"]["try"] = "try\n    execute \ncatch\n    call Red(v:exception)\nendtry$c\n"
let g:execRef["un"] = "UnmapHandler"
let g:execRef["cv"] = "CheckVerbose"
let g:execRef["up"] = "UnmapPython"
let g:homedir = '~/'
let g:homedir = '/home/kdog3682/2024/'
let g:wpsnippets["vim"]["eee"] = "if $c\n    \nelseif \n    \" return\nelse\n    \" return\nendif"
let g:wpsnippets["vim"]["ifel"] = "if $0\n    \" return $c\nelse\n    return \nendif"
let g:wpsnippets["vim"]["w"] = "while $line\n    $c\nendwhile"
let g:wpsnippets["vim"]["w"] = "while $line\n    $c\nendwhile"
let g:wpsnippets["vim"]["w"] = "while $rest\n    $c\nendwhile"
let g:wpsnippets["vim"]["w"] = "while $0\n    $c\nendwhile"
let g:jspyref3['vim']['functionNames'] = []
let g:jspyref3['python']['functionNames'] = []
let g:jspyref3['javascript']['functionNames'] = []
let g:execRef["init"] = "InitFunctionNameRef"
let g:execRef["rvf2"] = "source /home/kdog3682/.vim/ftplugin/functions2.vim"
let g:jspyref3['vim']['nativeFunctions'] = ['copy', 'map', 'filter']
let g:jspyref3['python']['nativeFunctions'] = ['console.log']
let g:jspyref3['javascript']['nativeFunctions'] = ['print']
let g:wpsnippets["vim"]["ifnum"] = "if IsNumber($1)\n    $c\nendif"
let g:filedict["rp"] = "/home/kdog3682/PYTHON/run.py"
let g:filedict["bch"] = "/home/kdog3682/2023/baseComponents.html"
let g:execRef["vum"] = "VerboseChooseAndUnmap"
let g:execRef["nonu"] = "Nonu"
let g:execRef["ssp"] = "SetScreenPadding"
let g:wpsnippets["vim"]["mm"] = "function! Runner(s)\n    let s = a:s\n    $c\nendfunction\nlet m = FlatMap($1, 'Runner')"
let g:execRef["jb"] = "JumpBackwardsByQueryingJumpList"
let g:execRef["cl"] = "CollectLines"
let g:execRef["collect"] = "CollectWords"
let g:cssNumericIncrementMap = {}
let g:cssNumericDefaultValue = {'bounds': [[0, 100, 10]], 'fallback': 5}
let g:cssNumericIncrementMap['padding'] = 'default'
let g:wpsnippets["vim"]["inner"] = "function Inner(s)\n    let s = a:s\n    $c\nendfunction"
let g:wpsnippets["css"]['"'] = "problem: 123 \nsolution: asdf\n$c"
let g:wpsnippets["css"]["123"] = "\" 1\n\" 2\n\" 3\n\" 4\n\" 5\n\" 6\n$c"
let g:vimCurrentTestFunction = "CssEnter"
let g:keyboard['rl'] = "\<ESC>^Da"
let g:keyboard['rl'] = "\<ESC>0Da"
let g:execRef["sn1"] = "SaveNode1"
let g:vimCurrentTestFunction = "CssEnter"
let g:execRef["go"] = "GoHandler"
let g:gfgfdict['ce'] = ['/home/kdog3682/.vimrc', 'CssSnippetFromEnd', 0]
let g:s = ''
let g:vimCurrentTestFunction = "CssBlockExit"
let g:filedict["fl"] = "/home/kdog3682/2024/files.log"
let g:vimCurrentTestFunction = "HtmlBlockExit"
let g:vimCurrentTestFunction = "HtmlBlockExitUp"
let g:visualactiondict['VReplaceBlock'] = {'fn': 'VReplaceBlock'}
let g:dir2024 = '/home/kdog3682/2024/'
let g:gfgfdict['tsa'] = ['/home/kdog3682/2023/utils.js', 'toStringArgument', 0]
let g:filedict["sv"] = "/home/kdog3682/2023/serveVite.js"
let g:pmr2['ss'] = 'serveFile.js screenshot baseComponents.html'
let g:pmr2['html'] = 'serveFile.js html baseComponents.html'
let g:pmr2['ss'] = 'serveVite.js screenshot baseComponents.html'
let g:pmr2['html'] = 'serveVite.js html baseComponents.html'
let g:filedict["sty"] = "/home/kdog3682/2024/style.css"
let b:ls = 'asffffffffffffdddddddd'
let g:wpsnippets["vim"]["w"] = "let c = 0\nwhile c < 10\n    let c += 1\n    $c\nendwhile"
let g:execRef["chkf"] = "CheckIfFunctionExists"
let g:execRef["ui"] = "UnmapIab"
let g:gfgfdict['gcc'] = ['/home/kdog3682/2023/getConfig.js', 'getColonConfig', 0]
let g:gfgfdict['gcc'] = ['/home/kdog3682/2023/getConfig.js', 'getColonConfig', 0]
let g:gfgfdict['va'] = ['/home/kdog3682/.vimrc', 'AppendTestStringToBottomOfVimFile', 0]
let g:filedict["tt"] = "/home/kdog3682/2024/temp.txt"
let g:gfgfdict['ex'] = ['/home/kdog3682/.vimrc', 'GetFunctionInfo', 0]
let g:wpsnippets["js"]["vimc"] = "import { vimConnector } from \"./node-utils.js\""
let g:visualactiondict['dup'] = {'fn': 'VDuplicateBlock'}
let g:visualactiondict['btb'] = {'fn': 'VABlockToBrowser'}
let g:visualactiondict['VMakeSnippet'] = {'fn': 'VMakeSnippet'}
let g:visualactiondict['t'] = {'i': 'line', 'fn': 'VATry'}
let g:gfgfdict['va'] = ['/home/kdog3682/.vimrc', 'AppendTestStringToBottomOfVimFile', 0]
let g:gfgfdict['va'] = ['/home/kdog3682/.vimrc', 'VAction', 0]
let g:wpsnippets2["examples.js"]["app"] = "--------------------------------------------------------------\napp: $1\ninpath: /home/kdog3682/2024/temp.txt\ndesc: \ntags: \n\nfunction $1(s) {\n    $c\n}"
let g:execRef["explore"] = "Explorer"
let g:execRef["startlog"] = "MyStartLog"
let g:execRef["endlog"] = "MyendLog"
let g:execRef["define"] = "DefineMapItemHandler"
let g:execRef["findline"] = "PrintLinePlacesViaGSearch"
let g:execRef["fl"] = "PrintLinePlacesViaGSearch"
let g:wpsnippets2["vim"]["g"] = "GrabTextFromPage"
let g:vimCurrentTestFunction = "Snippeteer"
let g:wpsnippets2["vim"]["asdf"] = "let $1::abc = split(rest, delimiter)"
let g:wpsnippets2["vim"]["\"asdf"] = "let $1::bindingName = split(rest, delimiter)"
let g:jspyref3['vim']['bookmarkCommentStart'] = '"""'
let g:jspyref3['python']['bookmarkCommentStart'] = '"""'
let g:jspyref3['javascript']['bookmarkCommentStart'] = '/**'
let g:jspyref3['vim']['bookmarkCommentEnd'] = '"""'
let g:jspyref3['python']['bookmarkCommentEnd'] = '"""'
let g:jspyref3['javascript']['bookmarkCommentEnd'] = '**/'
let g:wpsnippets2["vimrc"]["caf"] = "call AppendFile($1, $2)"
let g:CommandTildaRef = {}
let g:CommandTildaRef['hfl'] = 'MarkAsHighFrequencyLine'
let g:wpsnippets["vim"]["ifel"] = "if $1\n    $c\nelse\n    \"\nendif"
let g:wpsnippets["vim"]["if"] = "if $1\n    $c\nendif"
let g:wpsnippets["vim"]["ef"] = "elseif $1\n    $c"
let g:visualactiondict['r'] = {'fn': 'VReplace'}
let g:visualactiondict['cp'] = {'fn': 'VCopy'}
let g:execRef["t"] = "Ticket"
let g:execRef["ticket"] = "Ticket"
let g:execRef["gl"] = "GrabLineViaGSearch"
let g:wpsnippets["vim"]["fori"] = "for i in range($1)\n    $c\nendfor"
let g:execRef["nwp"] = "NormalWPSnippet"
let g:jspyref3['vim']['echoInputTemplate'] = "call BlueInput('%s: ' . string(%s))"
let g:wpsnippets2["vimrc"]["va"] = "function! ${Capitalize($2)}(state)\n    let state = a:state\n    $c\nendfunction\nlet g:visualactiondict['$1'] = {'fn': '${Capitalize($2)}'}"

let g:jspyref3['vim']['equalDict']['s'] = "getline('.')\<CR>"
let g:jspyref3['python']['equalDict']['s'] = "getline('.')\<CR>"
let g:jspyref3['vim']['equalDict']['lang'] = "&filetype\<CR>"
let g:jspyref3['javascript']['equalDict']['v'] = {'replaceWith': 'value'}
let g:jspyref3['javascript']['equalDict']['suf'] = {'replaceWith': 'm', 'value': 'sort(unique(findall(r, s)))'}
let g:jspyref3['vim']['equalDict']['scol'] = {'entries': {'s': "getline('.')", "pos": "col('.') - 1"}}
let g:jspyref3['vim']['equalDict']['gsi'] = {'entries': {'s': "getline('.')", "index": "line('.')", 'spaces': "matchstr(s, '^ *')"}}
let g:jspyref3['javascript']['equalDict']['keys'] = {'conditionalTemplate': 'Object.keys($upbinding)'}
let g:jspyref3['javascript']['equalDict']['values'] = {'conditionalTemplate': 'Object.values($upbinding)'}
let g:jspyref3['javascript']['equalDict']['ab'] = {'replaceWith': '[a,b]'}
let g:jspyref3['vim']['equalDict']['ab'] = {'replaceWith': '[a,b]'}
let g:jspyref3['javascript']['equalDict']['fa'] = {'replaceWith': 'm', 'value': 'findall(r, s)'}

iab <buffer> ex execute
iab <buffer> ibe inoremap <buffer> <expr>
iab <buffer> ret return
iab <buffer>be <buffer> <expr>
inoreab <buffer>  con continue<C-R>=Eatchar('\s')<CR>
inoreab <buffer>  ge GetExtension()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer>  nine 9<C-R>=Eatchar('\s')<CR>
inoreab <buffer>  pe +=
inoreab <buffer>  semi ;<C-R>=Eatchar('\s')<CR>
inoreab <buffer> <expr> ee VimEEBlock()
inoreab <buffer> <expr> ms SmartMatch()
inoreab <buffer> <expr> r SmartReturn()
inoreab <buffer> <expr> tl ThrowLog()
inoreab <buffer> <expr> ts TSExpr()
inoreab <buffer> fli FindLineIndex('')<LEFT><LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer> jp Jspy3('')<LEFT><LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer> lab let [a,b] =
inoreab <buffer>T Test(,<space>'')<LEFT><LEFT><LEFT><LEFT><LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer>ab AppendBelow2()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer>ab let [a,b] = <C-R>=Eatchar('\s')<CR>
inoreab <buffer>apae call AppendAndExecute()<left><C-R>=Eatchar('\s')<CR>
inoreab <buffer>az [a-z0-9]+<C-R>=Eatchar('\s')<CR>
inoreab <buffer>bl call BlueList()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer>bs Backspaces()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer>ca call<space>append('',)<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer>cas call<space>add(store,<space>)<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer>cer call<space>ExecuteRegex()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer>cof call<space>OpenFunction()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer>deli delimiter<C-R>=Eatchar('\s')<CR>
inoreab <buffer>ef elseif<C-R>=Eatchar('\s')<CR>
inoreab <buffer>endf endfunction<C-R>=Eatchar('\s')<CR>
inoreab <buffer>exclam !<C-R>=Eatchar('\s')<CR>
inoreab <buffer>exn execute<space>"normal!<space>"<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer>exn execute<space>NormalExpr()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer>ft &filetype<C-R>=Eatchar('\s')<CR>
inoreab <buffer>fu function<C-R>=Eatchar('\s')<CR>
inoreab <buffer>gcw GetCurrentWord4()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer>gfw GetFirstWord()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer>gk g:keyboard.<C-R>=Eatchar('\s')<CR>
inoreab <buffer>gr g:regexes.<C-R>=Eatchar('\s')<CR>
inoreab <buffer>hk has_key()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer>hmd g:helpmdfile<C-R>=Eatchar('\s')<CR>
inoreab <buffer>is ==<space><C-R>=Eatchar('\s')<CR>
inoreab <buffer>kb \<lt>BS><C-R>=Eatchar('\s')<CR>
inoreab <buffer>kc \<lt>C-O><C-R>=Eatchar('\s')<CR>
inoreab <buffer>kco \<lt>C-O><C-R>=Eatchar('\s')<CR>
inoreab <buffer>kcr \<lt>CR><C-R>=Eatchar('\s')<CR>
inoreab <buffer>ke \<lt>ESC><C-R>=Eatchar('\s')<CR>
inoreab <buffer>kl \<lt>LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer>kn \<lt>CR><C-R>=Eatchar('\s')<CR>
inoreab <buffer>kr \<lt>RIGHT><C-R>=Eatchar('\s')<CR>
inoreab <buffer>kt \<lt>TAB><C-R>=Eatchar('\s')<CR>
inoreab <buffer>lg let s = a:0 >= 1 ? a:1 : getline('.')<C-R>=Eatchar('\s')<CR>
inoreab <buffer>m2 Match()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer>ms Match(s,<space>'')<LEFT><LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer>ndy throw<space>"not<space>done<space>yet"<C-R>=Eatchar('\s')<CR>
inoreab <buffer>nuna nunmap <lt>buffer><C-R>=Eatchar('\s')<CR>
inoreab <buffer>ob call<space>OpenBuffer3()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer>pae call<space>PrintAndExecute()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer>pf printf('')<LEFT><LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer>rs return<space>string()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer>sam SearchAndMatch2023()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer>sbe <silent><space><buffer><space><expr><C-R>=Eatchar('\s')<CR>
inoreab <buffer>search Search2023()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer>si startinsert<C-R>=Eatchar('\s')<CR>
inoreab <buffer>sil <lt>silent><C-R>=Eatchar('\s')<CR>
inoreab <buffer>so SplitOnce()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer>sub substitute()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer>te "test:
inoreab <buffer>vv v:val<C-R>=Eatchar('\s')<CR>
inoreab <buffer>ww (\w+)<C-R>=Eatchar('\s')<CR>
inoreab <expr> ds Comment(strftime('%m-%d-%Y'))
inoreab <silent> <buffer> <expr> echo VimscriptEcho()
inoreab <silent> <expr> gbm SetGlobalBookmark()
inoremap : ;
inoremap ; :
inoremap <buffer> <expr> ' SmartQuote()
inoremap <buffer> <expr> 9 SmartNine('(')
inoremap <buffer> <expr> = SmartEqual()
inoremap <buffer> <expr> = SmartEqual()
inoremap <buffer> <expr> [ SmartNine('[')
inoremap <buffer> <expr> `u TildaMovement()
inoremap <buffer> <expr> q/ QSlashWordFind()
inoremap <buffer> <expr> qe QEvaluateManager()
inoremap <buffer> <expr> qq QSlashWordFind()
inoremap <buffer> <expr> qt TestingSearchInsideOfExprViaQT()
inoremap <buffer> <expr> qx Qx()
inoremap <buffer> <expr> { JavascriptSmartBracket()
inoremap <buffer> qp (<C-O>A)<LEFT>
inoremap <buffer> qw <RIGHT>
inoremap <buffer> wq <LEFT>
inoremap <buffer>kq ""<LEFT>
inoremap <expr> qge Qge()
inoremap <expr> qgp Qgp()
inoremap <expr> qgs Qgs()
inoremap <silent> <buffer> <Tab> <C-R>=CleverTab()<CR>
inoremap <silent> <buffer> <expr> fw FwSnippeteer()
inoremap <silent> w, <esc>:call PySnippet4()<cr>a
inoremap <silent> wp <esc>:call Snippeteer()<cr>a
inoremap <silent> zd <esc>:call NormalHandler('WriteDitto')<CR>A
inoremap wf <esc>:call VimCreateFunctionBlock()<cr>
nnoremap 0 :call Node0()<CR>
nnoremap 1 :w<CR>:call Node1()<cr>
nnoremap 3 #
nnoremap 3 :call CommandSearchModeToggle()<CR>
nnoremap 3 :call CommandSearchThree()<CR>
nnoremap 3 :w<CR>:call TestExampleJSFile()<CR>
nnoremap 5 ?\v\w+\(?e<cr>
nnoremap ; :call AnythingHandler2('')<LEFT><LEFT>
nnoremap <buffer> 2 :update<CR>:call FunctionCallerViaEvalTheLine()<CR>
nnoremap <buffer> 3 :update<CR>:call ExecuteFunctionCaller2()<CR>A
nnoremap <buffer> <leader>/ :call VimFunctionSearch('')<left><left>
nnoremap <buffer> er :call EchoReturn()<CR>
nnoremap <buffer> qt :w<CR>:call QTNormalRunner()<CR>
nnoremap <buffer> qw <RIGHT>i
nnoremap <buffer>` :call CommandTilda()<CR>
nnoremap <c-c> :call CopyController()<CR>
nnoremap <c-c> :call Sayhi()<CR>
nnoremap <c-r> :call ModeReset()<CR>
nnoremap <c-s> :w<CR>:call SaveBackup0104()<CR>
nnoremap <c-x> :call UpdateAndExecuteLine(0)<CR>
nnoremap <f10> :w<CR>:call AnythingHandler('host')<CR>
nnoremap <f3> :w<CR>:call AnythingHandler('ss')<CR>
nnoremap <f4> :w<CR>:call AnythingHandler('html')<CR>
nnoremap <f5> :w<CR>:call AnythingHandler('empty')<CR>
nnoremap <f6> :w<CR>:call AnythingHandler('pdf')<CR>
nnoremap <leader>g :call GetFromMaster("")<LEFT><LEFT>
nnoremap <leader>g :call GoFileGoFunction("")<LEFT><LEFT>
nnoremap <leader>m :messages<CR>
nnoremap <leader>n :call FileNote('')<LEFT><LEFT>
nnoremap <leader>r diwi
nnoremap <leader>v :call OpenBuffer3('/home/kdog3682/.vimrc')<CR>
nnoremap <leader>w :call WriteNotes5('')<LEFT><LEFT>
nnoremap <silent> 0 :call Foobar()<CR><CR>
nnoremap <silent> <buffer> <expr> <leader>d SearchDateExpr()
nnoremap <silent> <buffer>` :call TildaFunctionSearch()<CR>
nnoremap <silent><buffer> 2 :call setline('.', g:keyboard.tab)<CR>A
nnoremap <silent><buffer> 3 #
nnoremap <silent><buffer> 4 *
nnoremap <silent><buffer> 5 ?\v(Inner)@!(<[A-Z]\w{4,}>\|\.@<![A-Z]\w{4,}\()\C<cr>zz
nnoremap <silent><buffer> 5 ?\v\.@<!\w+\(<cr>zz
nnoremap <silent><buffer> 6 /\v(Inner)@!<[A-Z]\w{4,}>\|\.@<![A-Z]\w{4,}\(\C<cr>zz
nnoremap <silent><buffer> 6 /\v\.@<!\w+\(<cr>zz
nnoremap <silent><buffer> 7 ?\v(endfunction\|function\|buffer\|silent\|nnore)@!<[a-z]\w{4,}[^!(\\]\C<cr>zz
nnoremap <tab> :call OpenBuffer3(NBackslash(''))<LEFT><LEFT><LEFT>
nnoremap = :b#<CR>
nnoremap X :call UpdateAndExecuteLine(1)<CR>
nnoremap ` :call CommandTilda()<CR>
nnoremap ec :call Echolocation()<CR>
nnoremap ee :call OpenBuffer3("/home/kdog3682/2023/examples.js")<CR>
nnoremap ehb :call OpenBuffer3("/home/kdog3682/2023/pl-htmlBuilder.js")<CR>
nnoremap ei :call EchoTemplate('ei')<CR>
nnoremap el :call EchoTemplate('el')<CR>
nnoremap er :call EchoTemplate('er')<CR>
nnoremap es I<C-O>D
nnoremap et :call EchoTemplate('et')<CR>
nnoremap ex :call OpenExampleJS()<CR>
nnoremap gf :call GoFile()<CR>
nnoremap gof :call BrowseAndGoFunction()<CR>
nnoremap gx :call ChooseAndGoFunctionFromScreen()<CR>
nnoremap mv :call Move()<CR>
nnoremap qe o<bs>
nnoremap qp :call SilentPythonController('sayhi2023')<CR>
nnoremap wf :call VimCreateFunctionBlockNormal()<cr>
nnoremap ze :call ZEqual()<CR>
set cmdheight=1
set expandtab      " Use spaces instead of tabs
set history=1000
set shiftwidth=4   " Number of spaces for auto-indenting
set tabstop=4      " Number of spaces a tab counts for
set viminfo='50
setlocal completefunc=VimComplete
