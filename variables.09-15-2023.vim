let g:debug = 0
let g:functionPrefixRE = '^((async )?function[!*]?|class|def) '
let g:OPPOSITES = { '{': '}', 'visible': 'hidden', 'hidden': 'visible', '[': ']', '(': ')', '^': '$', '}': '{', ']': '[', '>': '<', '<': '>', '>=': '<=', '<=': '>=', '=': '=', '1': '0', '0': '1', ')': '(' }
let g:temptextfile = '/home/kdog3682/RESOURCES/temp.txt'
let g:vimmaxlength = 75 - 5
let g:tempmdfile = '/home/kdog3682/RESOURCES/temp.md'
let g:mdtempfile = '/home/kdog3682/RESOURCES/temp.md'
let g:codelearningfile = '/home/kdog3682/RESOURCES/code.learning.txt'
let g:dir2023 = "/home/kdog3682/2023/"
let g:rootdir = "/home/kdog3682/"
let g:resdir = "/home/kdog3682/RESOURCES/"
let g:pythondir = '/home/kdog3682/PYTHON/'
let g:textdir = "/home/kdog3682/TEXTS/"
let g:mathdir = "/home/kdog3682/MATH/"
let g:helpmdfile = '/home/kdog3682/RESOURCES/help.md'
let g:clipfile = '/home/kdog3682/2023/clip.js'
let g:ftfile = "/home/kdog3682/RESOURCES/file-table.txt"
let g:jdjsonfile = '/home/kdog3682/RESOURCES/jd.june.json'
let g:jdjsonfile = '/mnt/chromeos/GoogleDrive/MyDrive/JSONS/jd.june.json'
let g:juneJson = '/home/kdog3682/RESOURCES/file-identifier-reference.june.json'
let g:pythonarchivefile = g:pythondir . 'archived.py'
let g:saveFile='saved.txt'
let g:linebreak = '--------------------------------------'
let g:lb = g:linebreak
let g:tempsavefile = 's.js'
let g:tabbings = {}
let g:buffer_items = []
let g:shuntfile = '/home/kdog3682/CWF/public/comments.js'
let g:shuntfile = 'comments.js'
let g:serverfile = '/home/kdog3682/2023/serve_html_file.js'
let g:lastname=''
let g:aobj = {'a': 1, 'b': 2}
let g:bookmarks2023 = {}
let g:vimrcfile = '/home/kdog3682/.vimrc'
let g:changelogfile = '/home/kdog3682/2023/changelog.md'
let g:changelogfile = '/home/kdog3682/RESOURCES/changelog.md'
let g:changelogfile = '/home/kdog3682/RESOURCES/help.md'
let g:filepickerdict = {}
let g:file2023dict = {}
let g:notefile = '/home/kdog3682/2023/changelog.md'
let g:notefile = '/home/kdog3682/2023/TEXTS/notes.txt'
let g:notefile = '/home/kdog3682/RESOURCES/notes.txt'
let g:notefile = '/home/kdog3682/2023/notes.txt'
let g:globalState = {}
let g:runpyfile = '/home/kdog3682/CWF/run.py'
let g:runpyfile = '/home/kdog3682/PYTHON/run.py'
let g:runpuppeteerfile = '/home/kdog3682/CWF/public/puppet.js'
let g:vimdir = "/home/kdog3682/VIM/"
let g:markdowndir = "/home/kdog3682/MARKDOWN/"
let g:activedir = g:dir2023
let g:clipdir = g:rootdir . 'CLIPS/'
let g:cwfdir = "/home/kdog3682/CWF/"
let g:pubdir = '/home/kdog3682/CWF/public/'
let g:javascriptdir = '/home/kdog3682/JAVASCRIPT/'
let g:filelogfile = "/home/kdog3682/LOGS/today.log"
let g:logfile = "/home/kdog3682/LOGS/myFiles.log"
let g:productiondir = '/home/kdog3682/PRODUCTIONS/'
let g:budir = '/mnt/chromeos/GoogleDrive/MyDrive/BACKUP/'
let g:drivemdnotefile = '/mnt/chromeos/GoogleDrive/MyDrive/NOTES.md'

let g:templaterfndict = {
    \'infer': 'GetLastBinding',
    \'lineNumber': 'GetLineNumber',
    \'qgp': 'Qgp',
    \'lf': 'GetLastFunction',
\}

let g:wordplacerdict = {
    \'config': ["const config = {\n    $c\n}", 1],
    \'ref': ["const ref = {\n    $c\n}", 1],
    \'dict': ["const dict = {\n    $c\n}", 1],
\}

let g:logittemplatedict = {
    \'la': 'const answer = nerdSolver($0)',
    \'lat': 'console.log(nerdSolver($0)); throw ""',
    \'txl': 'console.log({$0}); throw ""',
    \'tl': 'throwError($0)',
\}

let g:LogitKeys = keys(g:logittemplatedict)

let g:langaliasdict = {
    \'js2': 'js',
    \'vim': 'vim',
\}

let mapleader=","
let maplocalleader = '{'
let g:ftplugindir = '/home/kdog3682/.vim/ftplugin/'
let g:filedict["logs"] = "/home/kdog3682/logs.txt" "empty
let g:ldrdict["eat"] = "EatIab"
let g:ldrdict["c"] = "ClrFile"
let g:filedict["logs"] = "/home/kdog3682/logs.txt"
let g:filedict["pug"] = "/home/kdog3682/CWF/public/pug.js"
let g:filedict["pugt"] = "/home/kdog3682/CWF/public/pug.txt"
let g:basejsref = {}
let g:basejsref['pr'] = 'print cf'
let g:basejsref['op'] = 'open'
let g:basejsref['doYesterday'] = 'doYesterday'
let g:ldrdict["var"] = "VarHandler"
let g:filedict["ap"] = "/home/kdog3682/CWF/a.py"
let g:filedict["cj"] = "/home/kdog3682/CWF/public/c.js"
let g:ldrdict["bu"] = "BackupCurrentFiles"
let g:pydict["script"] = "<script>\n$c</script>"
let g:txtdict["script"] = "<script>\n$c\n</script>"
let g:txtdict["body"] = "<body>\n$c\n</body>"
let g:filedict["out"] = "/home/kdog3682/CWF/public/output.js"
let g:ldrdict["twil"] = "Twilio"
let g:ldrdict["si"] = "SifyAndGoJS"
let g:ldrdict["ps"] = "PrevString"
let g:gfgfdict = {}
let g:gfgfdict['gf'] = ['/home/kdog3682/.vimrc', 'GoFile', 0]
let g:gfgfdict['ft'] = ['/home/kdog3682/.vimrc', 'PostFileTable', 0]
let g:gfgfdict['cb'] = ['/home/kdog3682/.vimrc', 'FileGetter2', 0]
let g:gfgfdict['fg'] = ['/home/kdog3682/.vimrc', 'FileGetter2', 0]
let g:gfgfdict['ah'] = ['/home/kdog3682/.vimrc', 'AnythingHandler', 0]
let g:filedict["tod"] = "/home/kdog3682/CWF/public/today.js"
let g:functionfilerefjson = '/home/kdog3682/2023/functionfileref.json'
let g:filedict["tm"] = "/home/kdog3682/CWF/public/text-messages.txt"
let g:filedict["vb"] = "/home/kdog3682/CWF/public/vue-base.js"
let g:filedict["pub"] = "/home/kdog3682/CWF/public/public"
let g:filedict['myf'] = "/home/kdog3682/CWF/public/functions.js.json"
let g:filedict["p"] = "/home/kdog3682/CWF/public/prose.txt"

let g:movementLinks = {
    \'vueErrorMarkdownBuilder': {'binding': 'vueErrorMDSpec'},
    \'markdownLeafParser': {'file': "pl-markdownLeafParser.js"},
\}

let g:ldrdict["lego"] = "ChangeLegos"
let g:filedict["th"] = "/home/kdog3682/CWF/public/test.html"
let g:activehtmlfile = 'test.html'
let g:pydict["vo"] = "var $1 = {\n    $c\n}\n"
let g:pydict["crw"] = "const children = this.value.map((item, i) => {\n    $c\n\})\nreturn renderWrapper(this, children)"
let g:solsnippets["js"]["h"] = "const h = state.$createElement"
let g:filedict["c"] = "/home/kdog3682/CWF/public/c.css"
let g:basepyref['bu'] = ':backup cfs'
let g:targetline = 0
let g:solsnippets["vim"]["block"] = "let block = GetCodeBlock()"
let g:filedict["git"] = "/home/kdog3682/CWF/githubscript.py"
let g:solsnippets["vim"]["e"] = "let e = GetExtension(file)"
let g:solsnippets["js"]["mtsc"] = "const [question, numbers] = this.mt.shortcut(x)"
let g:ldrdict["wsc"] = "WriteShortcutsForFile"
let g:ldrdict["lsc"] = "LoadShortcutsForFile"
let g:filedict["u"] = "/home/kdog3682/CWF/public/user"
let g:visualactiondict = {}

let g:vueaddtransitiondict = {
    \ 'tg': [
        \ '<transition-group name="fade" mode="out-in">',
        \ '</transition-group>',
    \],
    \ 'transition': [
        \ '<transition name="fade" mode="out-in">',
        \ '</transition>',
    \],
    \ 'else': [ 'else {', '}'],
    \ 'elif': [ 'else if{', '}'],
    \ 'if': [ 'if (sdfsdfsdf) {', '}'],
    \ 'sx': [ 's = `', '`'],
    \ 'a': [ '[', '],'],
    \ 'o': [ '[', '],'],
    \ 'div': [ '<div>', '</div>'],
    \ 'd': [ '<div class="">', '</div>'],
    \ 't': [ '<template v-if="">', '</template>'],
    \ 'temp': [ '<template v-if="">', '</template>', '<template v-else>', '</template>'],
    \ 'today': [ 'function today${MonthDay()}() {', '}'],
\}

let g:jspydict['js']['suffix'] = '}'
let g:jspydict['py']['suffix'] = ''
let g:jspydict['vim']['suffix'] = 'endfunction'
let g:jspydict['js']['prefix'] = 'var '
let g:jspydict['py']['prefix'] = ''
let g:jspydict['vim']['prefix'] = 'let '
let g:dateRE = '^\d\d-\d\d-\d\d\d\d'
let g:dateRE2 = '^(// *)?\d\d-\d\d-\d\d\d\d'
let g:solsnippets["js"]["lc"] = "let count = 0"
let g:pydict["deps"] = "var { test, parseJSON, sorted, getLast, merge, isObject, exists, findall, toArgument, isFunction, isPrimitive, isString, ftest, isNumber, removeAllComments, search, assert, fixPath, fixPath, datestamp, write} = require('./utils.js')"
let g:ldrdict["lo"] = "LogIt2"
let g:pydict["rsr"] = "return s.replace($1, (x) => {\n    $c\n})"
let g:solsnippets["js"]["qg"] = "const qg = new QuestionGenerator3()"
let g:ldrdict["te"] = "TestingEnvironment"
let g:visualactiondict['d'] = {'fn': 'DeleteBlock', 'i': 'GetMethodIndexes'}
let g:visualactiondict['mkpy'] = {'mode': 1, 'fn': 'VisualMakePyDict', 'i': 'contiguous'}
let g:visualactiondict['mk'] = {'mode': 2, 'fn': 'VisualMakePyDict', 'i': 'contiguous'}
let g:visualactiondict['rw'] = {'fn': 'ReplaceWordUnderBlock', 'i': 'nospaces-nobraces', 'replace': 1}
let g:visualactiondict['uc'] = {'fn': 'UncommentBlock', 'i': 'contiguous'}
let g:visualactiondict['c'] = {'fn': 'SaveCodeBlock', 'i': 'contiguous'}
let g:visualactiondict['le'] = {'fn': 'VisualTransferBlock', 'i': 'nolinebreak', 'kwargs': {'to': g:codelearningfile}}
let g:visualactiondict['txt'] = {'fn': 'VisualTransferBlock', 'i': 'below-cursor', 'kwargs': {'to': '/home/kdog3682/Resources2023/text.txt'}}
let g:visualactiondict['arr'] = {'fn': 'VisualMakeArray', 'i': 'betweenblocks'}
let g:visualactiondict['s'] = {'fn': 'VisualTemplate', 'i': 'contiguous'}
let g:visualactiondict['b'] = {'fn': 'VisualBlockTemplater', 'i': 'nolinebreak'}
let g:filedict["cl"] = "/home/kdog3682/CWF/public/class.js"
let g:pydict["slot"] = "<slot name=''>\n    $c\n<slot/>"
let g:pydict["p"] = "<p>Hello from $c</p>"
let g:pydict["hd"] = "const $1 = h('div', $2, $3)"
let g:pydict["qa"] = "{\n    question: \"$c\",\n    answer(answer, context) {\n    \n    },\n},"
let g:pydict["qas"] = "{\n    question: \"$c\",\n    answer: \"\",\n},"
let g:pydict["qao"] = "{\n    only: 1,\n    question: \"$c\",\n    answer(answer, context) {\n    \n    },\n},"
let g:pydict["cng"] = "const [$c] = context.numbergen.create()"
let g:ldrdict["bml"] = "BookmarkLine"
let g:pydict["crng"] = "const n = context.numbergen.create(1)"
let g:pydict["bml"] = "/** $c **/"
let g:filedict["ujs"] = "/home/kdog3682/CWF/public/utils.js"
let g:filedict["fhtml"] = "/home/kdog3682/.vim/ftplugin/html.vim"
let g:filedict["ftext"] = "/home/kdog3682/.vim/ftplugin/text.vim"
let g:filedict["fmath"] = "/home/kdog3682/.vim/ftplugin/math.vim"
let g:filedict["fm"] = "/home/kdog3682/.vim/ftplugin/math.vim"
let g:ldrdict["nf"] = "NewFunction"
let g:filedict["gui"] = "/home/kdog3682/CWF/public/gui.txt"
let g:filedict["vda"] = "/home/kdog3682/CWF/public/vue-data.js"
let g:filedict["nxn"] = "/home/kdog3682/CWF/public/na-xie-nian.js"
let g:filedict["ej"] = "/home/kdog3682/CWF/public/env.js"
let g:filedict["ut"] = "/home/kdog3682/CWF/public/utils.js"
let g:filedict["pdf"] = "/home/kdog3682/CWF/pdf.py"
let g:filedict["spl"] = "/home/kdog3682/CWF/public/split.txt"
let g:filedict["ace"] = "/mnt/chromeos/MyFiles/Downloads/Acing the New SAT Math PDF Book.pdf"
let g:filedict["acejson"] = "/mnt/chromeos/MyFiles/Downloads/Acing the New SAT Math PDF Book.pdf.json"
let g:pydict["tss"] = "const $1 = this.$store.state.$1"
let g:pydict['vuech'] = "var ${Capitalize($1)} = {\n    name: '${Capitalize($1)}',\n    props: ['value'],\n    render(h) {\n        $c\n    },\n}"
let g:filedict["vd"] = "/home/kdog3682/CWF/public/vue-data.js"
let g:filedict["emt"] = "/home/kdog3682/CWF/public/exeter-math.txt"
let g:filedict["cwf"] = "/home/kdog3682/CWF.files.json"
let g:ldrdict["ff"] = "FindFunction"
let g:ldrdict["gtl"] = "GoToLeader"
let g:ldrdict["bml"] = "InvivoBookMarkLine"
let g:filedict["t2"] = "/home/kdog3682/CWF/public/test2.html"
let g:filedict["ur"] = "/home/kdog3682/CWF/public/useful-references.js"
let g:basepyref['sc'] = 'saveClip'
let g:basepyref['od'] = 'outboundData'
let g:basepyref['olf'] = 'openLastFile'
let g:basepyref['ur'] = 'uploadResume'
let g:filedict["od"] = "/home/kdog3682/CWF/public/outbound-data.js"
let g:filedict["mj"] = "/home/kdog3682/CWF/public/mc.js"
let g:filedict["notes"] = "/home/kdog3682/CWF/public/notes.txt"
let g:filedict["p"] = "/home/kdog3682/CWF/pdf.py"
let g:filedict["clip"] = "/home/kdog3682/CWF/public/.clip.js"
let g:pydict["rjs"] = 'var {toDashCase,ncg,toArgument,rescape,splitonce,newlineIndent,toDictionary,fparse,match,isIterable,pop,toStringArgument,ncgRunner,getExtension,merge,Storage,reduceObject,assert,bringToLife,templater2,isWord,getStackTrace,gatherArgs,linegetter,getCaller,getParameters,isRegExp,len,type,getLongest,parse,toStringFunction,wrap,filter,brackify,walker,isNestedArray,quotify,ftest,flat,join,stringify,range,indent,partition,singlequote,rng,parens,unique,templater,map,push,smallify,getLast,mreplace,prepareIterable,isPrimitive,findall,replace,capitalize,reduce,split,exists,isNumber,search,isFunction,isString,isObject,isArray,test, char2n, n2char} = require("./utils.js")'
let g:solsnippets["js"]["text"] = "const text = textgetter(f)"
let g:filedict["rq"] = "/home/kdog3682/reddit-questions.txt"
let g:filedict["mc"] = "/home/kdog3682/CWF/public/mc2.js"
let g:filedict["gdoc"] = "/home/kdog3682/CWF/googledocs.json"
let g:filedict["krt"] = "/home/kdog3682/CWF/public/katex.ref.txt"
let g:filedict["tvd"] = "/home/kdog3682/CWF/public/temp-vue-data.html"
let g:filedict["a"] = "/home/kdog3682/CWF/public/mc.js"
let g:filedict["mc"] = "/home/kdog3682/CWF/public/mc.js"
let g:filedict["p"] = "/home/kdog3682/CWF/pdf.py"
let g:filedict["cd"] = "/home/kdog3682/CWF/public/clip-data.js"
let g:filedict["mds"] = "/home/kdog3682/CWF/public/math-doc-string.txt"
let g:filedict["foo"] = "/home/kdog3682/CWF/public/foo.css"
let g:filedict["fth"] = "/home/kdog3682/.vim/ftplugin/html.vim"
let g:filedict["rj"] = "run.js"
let g:filedict["mb"] = "mathbook.raw.txt"
let g:filedict["cn"] = "/home/kdog3682/TEXTS/code.notes.txt"
let g:filedict["s"] = "/home/kdog3682/CWF/public/ss.js"
let g:filedict["vimd"] = "/home/kdog3682/CWF/vim-dictionaries.vim"
let g:filedict["new"] = "/home/kdog3682/CWF/public/new.js"
let g:filedict["x"] = "base.py.extracts.09-22-2022.log"
let g:urldict={}
let g:urldict['cwt'] = "https://docs.google.com/spreadsheets/d/1Y3KRa7m3Nc8Z9ZGnKDFflGl5mldGBcosY1XIBYMF_Uo/edit#gid=1470853595"
let g:ldrdict["pds"] = "PrevDatestamp"
let g:filedict['cle'] = "https://newyork.craigslist.org/search/edu#search=1~list~0~0"
let g:filedict['wea'] = "https://www.google.com/search?q=weather&rlz=1CACCBQ_enUS943US943&oq=weather&aqs=chrome.0.69i59j35i39j46i131i199i433i465i512j0i131i433i512j0i67i131i433i457j0i402l2j69i61.541j1j7&sourceid=chrome&ie=UTF-8"
let g:filedict["x"] = "pdf.py.extracts.09-27-2022.log"
let g:pydict["data"] = "data() {\n    return {\n        fooba: 'hi',\n        $c\n    }\n},\n"
let g:filedict["mathematics"] = g:jsdir . 'math'
let g:togglelineindex=0
let g:filedict["scrape"] = "/home/kdog3682/CWF/public/scrape.js"
let g:filedict["x"] = "/home/kdog3682/TEXTS/chen-brothers.math.txt"
let g:ldrdict["efs"] = "ExecuteFileString"
let g:filedict["vc"] = "/home/kdog3682/CWF/public/vim-commands"
let g:filedict["v"] = "/home/kdog3682/.vimrc"
let g:filedict["x"] = "/home/kdog3682/MATH/greater-than-smaller-than.math"
let g:filedict["help"] = "/home/kdog3682/TEXTS/help.txt"
let g:filedict["x"] = "mc.js.extracts.09-30-2022.log"
let g:filedict["ct"] = "/home/kdog3682/CWF/public/component-test.js"
let g:filedict['gdoc']="https://docs.google.com/document/d/1nx2EPubUQl4EQ9bT1coFVtoEyYeGMlhb3fCAjAZ55ew/edit"
let g:filedict["x"] = "app2.js.extracts.09-30-2022.log"
let g:filedict["x"] = "class.js.extracts.09-30-2022.log"
let g:filedict["citi"] = 'https://docs.google.com/spreadsheets/d/1Y3KRa7m3Nc8Z9ZGnKDFflGl5mldGBcosY1XIBYMF_Uo/edit#gid=1470853595'
let g:filedict["cwt"] = 'https://docs.google.com/spreadsheets/d/1Y3KRa7m3Nc8Z9ZGnKDFflGl5mldGBcosY1XIBYMF_Uo/edit#gid=1470853595'
let g:filedict["clip"] = "/home/kdog3682/CWF/public/clip.js"
let g:filedict["appscript"] = 'https://script.google.com/home/projects/1udnFRvx5ObFrf-T36H4-Wnj3bjNDZkfqC1qwj4JUdLfu5sSJXYm4280J/edit'
let g:filedict["ga"] = "/home/kdog3682/CWF/ga.py"
let g:filedict["hc"] = "/home/kdog3682/CWF/public/html-commands.vim"
let g:filedict["tc"] = "/home/kdog3682/CWF/public/text-commands.vim"
let g:pydict['vt'] = "var ${Capitalize($1)} = {\n    transform: true,\n    name: '${Capitalize($1)}',\n    props: ['value'],\n    template: `\n        $c\n    `,\n}"
let g:pydict['cp'] = "computed: {\n    $c\n},"
let g:filedict["nc"] = "/home/kdog3682/CWF/public/nc.js"
let g:filedict["nc"] = "/home/kdog3682/CWF/public/nc.js"
let g:filedict["classroom"] = "https://drive.google.com/drive/folders/1sD9pfkJVa0WBH_FPygLQ-gCaJQRGaO-B"
let g:gtfgtfdict['exclam for'] = ['/home/kdog3682/CWF/public/mc.js', 'VGuidedMultiplication', [0,2703,16,0]]
let g:filedict["goo"] = "/home/kdog3682/CWF/public/goo.css"
let g:filedict["sm"] = "/home/kdog3682/MATH/story.math"
let g:ldrdict["eat"] = "IabEat"
let g:filedict["ms"] = "/home/kdog3682/MATH/story.math"
let g:servedir = '/home/kdog3682/SERVER/'
let g:filedict['sir'] = '/home/kdog3682/SERVER/server.js'
let g:pydict["p"] = "<p style=\"color: red\">HIII</p>"
let g:filedict["deps"] = "/home/kdog3682/LOGS/dependencies.log"
let g:filedict["sfe"] = "/home/kdog3682/SERVER/server-frontend.js"
let g:filedict["t3"] = "/home/kdog3682/CWF/public/test3.html"
let g:filedict["a4"] = "/home/kdog3682/CWF/public/a4.js"
let g:filedict["cur"] = "/home/kdog3682/MATH/current.math"
let g:pythonsnippets["b"] = "from base import *"
let g:pydict["cc"] = "    console.clear()"
let g:filedict['sj'] = '/home/kdog3682/SERVER/index.js'
let g:logic2022['js']['ni'] = '!$1'
let g:filedict["c"] = "/home/kdog3682/CWF/public/clip.js"
let g:filedict["gr"] = "/home/kdog3682/TEXTS/grades.txt"
let g:filedict["grades"] = "/home/kdog3682/TEXTS/grades.txt"
let g:filedict["g"] = "/home/kdog3682/TEXTS/grades.txt"
let g:filedict["cj"] = "/home/kdog3682/TEXTS/code.journal.txt"
let g:filedict["mj"] = "/home/kdog3682/TEXTS/me.journal.txt"
let g:wpsnippets["vim"]["line"] = "let line = getline('.')"
let g:wpsnippets["vim"]["cur"] = "let cursor = GetCursor()"
let g:pydict["lom"] = "const $1 = ($2) => {\n    $c\n}"
let g:pydict["nullcache"] = "const cache = Object.create(null)"
let g:filefunctionref = {}
let g:wpsnippets["vim"]["lang"] = "let lang = Lang()"
let g:filedict["vimrc"] = "/home/kdog3682/.vimrc"
let g:filedict['cs'] = g:dldir . "10_28_2022 (4).css"
let g:jspyref2["vim"]["file-function-ref"]["reg"] = ["/home/kdog3682/.vimrc", "Registrar"]
let g:filedict["a2"] = "/home/kdog3682/CWF/public/app2.js"
let g:jspyref2["vim"]["file-function-ref"]["cb"] = ["/home/kdog3682/.vimrc", "ChooseBuffer2"]
let g:qref = {'ls': 'GetLastString', 'sm': 'ShortMonths'}
let g:qref['bfn']= 'QgpBuildFnCall'
let g:qwordref = {}
let g:qwordref['joy'] = 'is a joy to have in class.'
let g:qwordref['keep'] = 'keep up the good work.'
let g:qref['dl'] = 'DateLine'
let g:qref['td'] = 'QRefToday'
let g:qref['s'] = 'GetAnyLastString'
let g:qref['lv'] = 'GetLastVariable'
let g:qref['fn'] = 'GetFunctionName'
let g:qref['anno'] = 'DoAnnouncement'
let g:qref['d'] = 'QAppendDirToCursor'
let g:filefunctionref["reg"] = ["/home/kdog3682/.vimrc", "Registrar"]
let g:filefunctionref["cb"] = ["/home/kdog3682/.vimrc", "ChooseBuffer2"]
let g:pydict["process"] = "const process = require('process')"
let g:filedict["tl"] = "/home/kdog3682/LOGS/today.log"
let g:jspyref2['vim']['bindingRE'] = '(function!? |let g:)'
let g:jspyref2['vim']['bindingRE'] = 'function!? '
let g:jspyref2['js']['big-quote'] = '`'
let g:jspyref2['py']['big-quote'] = '"""'
let g:jspyref2['vim']['big-quote'] = '"""'
let g:jspyref2['vim']['prefix'] = 'let '
let g:jspyref2['js']['prefix'] = 'const '
let g:jspyref2['py']['prefix'] = ''
let g:jspyref2['user'] = {}
let g:jspyref2['asd'] = {}
let g:jspyref2['user']['big-quote'] = '"""'
let g:jspyref2['vim']['commentPrefix'] = '" '
let g:jspyref2['vim']['commentPrefix'] = '" '
let g:jspyref2['js']['commentPrefix'] = '// '
let g:jspyref2['py']['commentPrefix'] = '# '
let g:jspyref2['asd']['commentPrefix'] = ''
let g:ldrdict["ex"] = "Extracter"
let g:filedict["hlez"] = "/home/kdog3682/.npm-global/lib/node_modules/@lezer/markdown/dist/index.cjs"
let g:filedict["mlez"] = "/home/kdog3682/.npm-global/lib/node_modules/@lezer/markdown/dist/index.cjs"
let g:pydict["s"] = "$1 = `\n$c\n`"
let g:filedict["a3"] = "/home/kdog3682/CWF/public/a3.js"
let g:filedict["am"] = "/home/kdog3682/2023/appscript.js"
let g:filedict["au"] = "/home/kdog3682/CWF/public/app-utils.js"
let g:execRef['pdf'] = 'call BasePY("fp pdf")'
let g:filedict["temp"] = "/home/kdog3682/CWF/public/temp.html"
let g:pydict["a"] = "const $1 = [\n    $c\n]"
let g:pydict["o"] = "const $1 = {\n    $c\n}"
let g:pydict["com"] = "{\n    component: '$c',\n},"
let g:pydict["ox"] = "{\n    $c,\n},"
let g:pydict["coo"] = "const options = {\n    $c\n}"
let g:execRef[':'] = 'call ExecToc()'

let g:toclist = [
 \{'name': 'append to js env file', 'f': 'AppendJSEnv'},
\]

let g:filedict["m"] = "/home/kdog3682/TEXTS/m.txt"
let g:execRef['tt'] = 'call BasePY("vimFileOpener temp.html")'
let g:filedict["le"] = g:codelearningfile
let g:userdict = {}
let g:wpsnippets['user'] = g:userdict
let g:pydict["type"]  = "if (typeof $1 != 'undefined') {\n    $c\n}\n"
let g:pydict["s"] = "let ${TimestampString($1)} = `\n    $c\n`"
let g:qgnormalref={'ls': 'GoLastString', '': 'GoLastWord', 'bm': 'GoLastBookmark'}
let g:pythonsnippets["cb"] = '""" $c """'
let g:pythonsnippets["cb"] = "\"\"\"\n$c\n\"\"\""
let g:execRef['dl'] = 'call BasePY("fp dl")'
let g:execRef["cfn"] = "call ChangeFunctionNameFromPasteBuffer()"
let g:pydict['cv'] = "computed: {\n    computedValue() {\n        $c\n    },\n},"
let g:pydict['m'] = "methods: {\n    $c\n},"
let g:pydict['new'] = "(new ${Capitalize($1)}($c))"
let g:execRef["snf"] = "call ShuntNewFile($arg)"
let g:filedict["fl"] = "/home/kdog3682/LOGS/myFiles.log"
let g:filedict["myf"] = "/home/kdog3682/LOGS/myFiles.log"
let g:filedict["pos"] = "/home/kdog3682/CWF/public/position-control.js"
let g:filedict["pos"] = "/home/kdog3682/CWF/public/position-control.js"
let g:execRef['o'] = 'call BasePY("vimFileOpener $arg")'
let g:execRef['ma'] = 'call MathArchive()'
let g:filedict["ma"] = "/home/kdog3682/TEXTS/math.archive.txt"
let g:pydict["foo"] = "function foo${MonthDay()}() {\n    $c\n}"
let g:visualactiondict['obj'] = {'fn': 'VisualMakeObject', 'i': 'contiguous', 'appendAfter': 1}
let g:visualactiondict['arr'] = {'fn': 'VisualMakeArray3', 'i': 'nospaces-nobraces'}
let g:visualactiondict['bro'] = {'fn': 'VisualTransferToPython', 'i': 'smartblock', 'arg': 'copyToBrowser'}
let g:visualactiondict['dt'] = {'fn': 'VisualShunt', 'i': 'codeblock'}
let g:visualactiondict['letter'] = {'fn': 'VisualShunt', 'up': 'hi \w+', 'down': 'sincerely', 'grab': 1, 'delete': 1}
let g:visualactiondict['chl'] = {'fn': 'VisualTransfer', 'i': 'belowCursor', 'arg': '/home/kdog3682/2023/changelog.md'}
let g:visualactiondict['c'] = {'fn': 'VisualCopyBlock', 'i': 'codeblock'}
let g:visualactiondict['vt'] = {'fn': 'VisualTransferToJS', 'i': 'nolinebreak', 'arg': 'htmlBuilder'}
let g:visualactiondict['vc'] = {'fn': 'VisualTransferToJS', 'i': 'line', 'arg': 'getStylePayload'}
let g:visualactiondict['ve'] = {'fn': 'VisualTransferToJS', 'i': 'line', 'arg': 'runJavascript'}
let g:visualactiondict['f'] = {'fn': 'VisualWrapAboveBelow', 'i': 'below-cursor', 'arg': '', 'replace': 1}
let g:visualactiondict['gd'] = {'fn': 'VisualTransferToGoogleDoc', 'i': 'belowCursor', 'arg': '', 'delete': 1}
let g:visualactiondict['try'] = {'fn': 'VisualWrap', 'i': 'contiguous', 'arg': 'trycatch'}
let g:visualactiondict['ret'] = {'fn': 'VisualAppend', 'i': 'contiguous', 'arg': 'trycatch'}
let g:defaultfunctioncallstring = 'Declare Your own FunctionCall Value'
let g:jspyref2["py"]["compiler"] = 'python3'
let g:jspyref2["js"]["compiler"] = 'node'
let g:jspyref2["py"]["executeShellTemplate"] = '!clear; python3 '
let g:jspyref2["js"]["executeShellTemplate"] = '!clear; node '
let g:jspyref2["txt"]["executeShellTemplate"] = '!clear; node '
let g:jspyref2["py"]["VimShellName"] = 'Python'
let g:jspyref2["js"]["VimShellName"] = 'Node'
let g:jspyref2["md"] = {}
let g:pydict["str"] = "$1String${MonthDay()} = `\n    $c\n`"
let g:pydict['vt'] = "var ${Pascal($1)} = {\n    name: '${Capitalize($1)}',\n    props: ['value'],\n    template: `\n        $c\n    `,\n}"
let g:pydict['vx'] = "var V${Pascal($1)} = vrFactory('V${Pascal($1)}')\nfunction vrParse${Pascal($1)}({value}) {\n    \n}"
let g:filedict["rt"] = "/home/kdog3682/TEXTS/reddit.txt"
let g:vimsnippets["file"] = "let file = CurrentFile()"
let g:vimsnippets["word"] = "let word = GetCurrentWord()"
let g:pydict['ndy'] = "throw 'NDY: not done yet ' + getCaller(-1)"
let g:vimsnippets["line"] = "let line = CurrentLine()"
let g:vimsnippets["file"] = "let file = CurrentFile()"
let g:vimsnippets["date"] = "let date = DateStamp()"
let g:vimsnippets["name"] = "let name = GetBindingName()"
let g:vimsnippets["lang"] = "let lang = GetLang()"
let g:vimsnippets["word"] = "let word = GetCurrentWord()"
let g:vimsnippets["block"] = "let block = GetCodeBlock()"
let g:vimsnippets["index"] = "let index = GetFunctionIndex()"
let g:vimsnippets["context"] = "let context = GetContext2()"
let g:vimsnippets["lines"] = "let lines = NameMaker()"
let g:vimsnippets["spaces"] = "let spaces = CurrentSpaces()"
let g:vimsnippets["head"] = "let head = Head()"
let g:vimsnippets["last"] = "let last = GetLastBinding()"
let g:vimsnippets["upline"] = "let upline = UpLine()"
let g:vimsnippets["cursor"] = "let cursor = GetCursor()"
let g:vimsnippets["e"] = "let e = GetExtension()"
let g:execRef['isf'] = 'ec CheckIfIsFile("$arg")'
let g:execRef['cp'] = 'call GrabFunctionFromMaster()'
let g:execRef['bua'] = 'call BasePY("bua", FPGCB())'
let g:execRef['pdf'] = 'call BasePY("choosepdf")'
let g:filedict["ij"] = "/home/kdog3682/CWF/public/index.js"
let g:filedict["sh"] = "/home/kdog3682/CWF/public/scrape.html"
let g:controller = {'bold': 0, 'italic': 0, 'newline': 0}
let g:filedict["clm"] = "/home/kdog3682/LOGS/CHANGELOG.md"
let g:filedict["sh"] = "/home/kdog3682/VIM/setup.sh"
let g:filedict["p"] = "/home/kdog3682/PYTHON/pdf.py"
let g:filedict["b"] = "/home/kdog3682/PYTHON/base.py"
let g:filedict["rp"] = "/home/kdog3682/PYTHON/run.py"
let g:filedict["red"] = "/home/kdog3682/PYTHON/redditscript.py"
let g:filedict["zip"] = "/home/kdog3682/PYTHON/zipscript.py"
let g:filedict["ijh"] = "/home/kdog3682/JAVASCRIPT/index.html"
let g:filedict["jcl"] = "/home/kdog3682/JAVASCRIPT/class.js"
let g:vimdict = g:vimsnippets
let g:pydict['today'] = "function today${MonthDay()}() {\n    /* $c */\n}"
let g:pydict['f'] = "function f${MonthDay()}() {\n    /* $c */\n}"
let g:filedict["vv"] = "/home/kdog3682/VIM/variables.vim"
let g:filedict["cjs"] = "/home/kdog3682/CWF/public/comments.js"
let g:filedict["ftc"] = "/home/kdog3682/.vim/ftplugin/css.vim"
let g:filedict["env"] = "/home/kdog3682/PYTHON/env.py"
let g:filedict["c2"] = "/home/kdog3682/CWF/public/clip2.js"
let g:filedict["chl"] = "/home/kdog3682/LOGS/CHANGELOG.md"
let g:filedict["c3"] = "/home/kdog3682/CWF/public/clip3.js"
let g:filedict["bcs"] = "/home/kdog3682/CWF/public/base.css"
let g:vimdict['no'] = "nnoremap $1 :call $2()<CR>"
let g:vimdict['for'] = "for item in $1\n    $c\nendfor"
let g:markers = []
let g:execRef['gcb'] = "return GetCurrentBuffers()"
let g:pydict['bug'] = "bug(${GetBindingName()})"
let g:jspyref2['md']['commentPrefix'] = ''
let s = 'xcvc'
let g:filedict["mcj"] = "/home/kdog3682/CWF/public/math.config.js"
let g:vimdict['vt'] = "var ${Pascal($1)} = {\n    name: '${Capitalize($1)}',\n    props: ['value'],\n    template: `\n        $c\n    `,\n}"
let g:execRef['set'] = 'call SetGValue("$arg")'
let g:execRef['u'] = 'let g:globalState = {}'
let g:file2023dict["u"] = "/home/kdog3682/2023/utils.js"
let g:file2023dict["i"] = "/home/kdog3682/2023/index.html"
let g:file2023dict["nu"] = "/home/kdog3682/2023/node-utils.js"
let g:file2023dict["pj"] = "/home/kdog3682/2023/package.json"
let g:file2023dict["s"] = "/home/kdog3682/2023/scratchpad.js"
let g:file2023dict["s"] = "/home/kdog3682/2023/asdfsdf.js"
let g:file2023dict["s"] = "/home/kdog3682/2023/scratchpad.js"
let g:file2023dict["server"] = "/home/kdog3682/2023/server.js"
let g:file2023dict["sj"] = "/home/kdog3682/2023/server.js"
let g:file2023dict["ps"] = "/home/kdog3682/2023/Puppeteer.js"
let g:file2023dict["nuo"] = "/home/kdog3682/CWF/public/node-utils.js"
let g:file2023dict["plj"] = "/home/kdog3682/2023/package-lock.json"
let g:execRef['git'] = 'call BasePY("gitPush $cf")'
let g:filedict['ugit'] = "https://github.com/kdog3682/2023/blob/main/utils.js"
let g:filedict['github'] = "https://github.com/kdog3682/2023/blob/main/"
let g:pydir = '/home/kdog3682/PYTHON/'
let g:cdir = g:pydir
let g:filedict["temp"] = "/home/kdog3682/2023/DateObject.js"
let g:filedict["temp"] = "/home/kdog3682/2023/Interactive.js"
let g:filedict["temp"] = "/home/kdog3682/2023/CodeOrganizer.js"
let g:jsdir = "/home/kdog3682/2023/"
let g:jspyref2['js']['normalizeDirPath'] = g:jsdir
let g:jspyref2['py']['normalizeDirPath'] = g:pydir
let g:pydict['imp'] = "import {\n    $1,\n    \n} from \"./node-utils.js\""
let g:jspyref2['js']['appendBottomTemplate'] = "AppendVuetifyComponent"
let g:jspyref2['js']['appendBottomTemplate'] = "console.log($2())"
let g:jspyref2['py']['appendBottomTemplate'] = "env.basepyref['${Abrev($1)}'] = '$1'"
let g:jspyref2['vim']['appendBottomTemplate'] = "let g:execRef['$1'] = 'call $2()'"
let g:filedict["notes"] = "/home/kdog3682/CWF/public/notes.txt"
let g:filedict["n"] = "/home/kdog3682/2023/notes.txt"
let g:filepickerdict["v"] = "/home/kdog3682/2023/variables.js"
let g:filepickerdict["v"] = "/home/kdog3682/2023/variables.js"
let g:filepickerdict["v"] = "/home/kdog3682/2023/variables.js"
let g:filepickerdict["g"] = "/home/kdog3682/2023/HTMLBuilder.js"
let g:filedict["c3"] = "/home/kdog3682/CWF/public/class3.js"
let g:filedict["c3"] = "/home/kdog3682/CWF/public/class3.js"
let g:filedict["c4"] = "/home/kdog3682/CWF/public/class4.js"
let g:loremdict = {}
let g:loremdict['files'] = "['abc.js', 'abcd.js']"
let g:pythonsnippets['lorem'] = "$1 = ${GetLorem($1)}"
let g:pythonsnippets['l'] = "$1 = ${GetLorem($1)}"
let g:filedict["m2"] = "/home/kdog3682/2023/math.txt"
let g:filedict["u"] = "/home/kdog3682/2023/utils.js"
let g:filedict["s"] = "/home/kdog3682/2023/scratchpad.txt"
let g:filedict["cold"] = "/home/kdog3682/CWF/public/clip.js"
let g:filedict["temp"] = "/home/kdog3682/CWF/public/temp.html"
let g:server_debug = 0
let g:filedict["te"] = "/home/kdog3682/2023/textEdit.js"
let g:filedict["sk"] = "/home/kdog3682/2023/splitKatex.js"
let g:filedict["ss"] = "/home/kdog3682/2023/scratchpad.js"
let g:filedict["mg"] = "/home/kdog3682/2023/mathgen.js"
let g:pydict['clip'] = 'import { clip, appendVariable } from "./node-utils.js"'
let g:pydict["com"] = "{\n    component: 'v-mixed',\n    props: {\n        value: '$c'\n    },\n},"
let g:pydict["com"] = "component: 'v-mixed',\nprops: {\n    value: '$c',\n},"
let g:pydict["comp"] = "{\n    component: 'v-mixed',\n    props: {\n        value: '$c'\n    },\n    style:'',    \n},"
let g:filedict["asd"] = "/home/kdog3682/CWF/public/asd"
let g:libraries = {}
let g:filedict['wsa']='https://script.google.com/home/projects/1udnFRvx5ObFrf-T36H4-Wnj3bjNDZkfqC1qwj4JUdLfu5sSJXYm4280J/edit'
let g:filedict["pya"] = "/home/kdog3682/PYTHON/apps.py"
let g:filedict["ga"] = "/home/kdog3682/PYTHON/ga.py"
let g:filedict["cn"] = "/home/kdog3682/2023/code-notes.txt"
let g:filedict["me"] = "/home/kdog3682/2023/index.js2"
let g:filedict["me"] = "/home/kdog3682/2023/me.txt"
let g:filedict['gmail']='https://gmail.com'
let g:filedict['gmailsent']='https://gmail.com/sent'
let g:filedict['td']='https://docs.google.com/document/d/1xUr6FP9NZJ49rGp5ZGsCH6VAfJUZImuVz-6KIgJ_Daw/edit'
let g:filedict['teachingdiary']='https://docs.google.com/document/d/1xUr6FP9NZJ49rGp5ZGsCH6VAfJUZImuVz-6KIgJ_Daw/edit'
let g:txtdir = "/home/kdog3682/2023/TEXTS/"
let g:jspyref2['txt']['normalizeDirPath'] = g:txtdir
let g:jspyref2['html']['normalizeDirPath'] = g:dir2023
let g:jspyref2['js']['trycatch'] = {'above': ['try {'], 'below': ['} catch(e) {', '    const error = handleError(e, s)', '    ', '}']}
let g:jspyref2['js']['trycatch'] = {'above': ['try {'], 'below': ['} catch(e) {', '    console.log(handleError(e))', '    ', '}']}
let g:jspyref2['vim']['trycatch'] = {'above': ['try'], 'below': ['catch', '    let error = v:exception', '    ', 'endtry']}
let g:jspyref2['py']['trycatch'] = {'above': ['try:'], 'below': ['except Exception as e:', '    ', '']}
let g:jspyref2['py']['defaultLangFile'] = 'base.py'
let g:jspyref2['html']['defaultLangFile'] = 'index.html'
let g:jspyref2['css']['defaultLangFile'] = 'base.css'
let g:jspyref2['js']['defaultLangFile'] = 'utils.js'
let g:jspyref2['vim']['defaultLangFile'] = '/home/kdog3682/.vimrc'
let g:jspyref2['worksheet-components.js'] = {}
let g:jspyref2['vimrc'] = {}
let g:jspyref2['base-components.js'] = {}
let g:jspyref2['worksheet-components.js']['appendBottomTemplate'] = 'previewComponentTemplate($1)'
let g:jspyref2['vimrc']['appendBottomTemplate'] = "let g:execRef[\"$1\"] = \"call $1()\""
let g:jspyref2['base-components.js']['appendBottomTemplate'] = "    $1,"
let g:jspyref2['base-components.js']['appendBottomTemplate'] = "vuePreview($1)"
let g:jspyref2['js']['snippetDict'] = 'pydict'
let g:jspyref2['vim']['snippetDict'] = 'vimdict'
let g:jspyref2['py']['snippetDict'] = 'pythonsnippets'
let g:jspyref2['py']['bookmark_template'] = '# @bookmark $1'
let g:jspyref2['vim']['bookmark_template'] = '" @bookmark $1'
let g:jspyref2['js']['bookmark_template'] = '/* @bookmark $1 */'
let g:filedict["s"] = "/home/kdog3682/2023/TEXTS/scratchpad.txt"
let g:execRef['scf'] = 'call SourceCurrentFile()'
let g:execRef['ani'] = 'call AddNewItems()'
let g:filedict["ch"] = "/home/kdog3682/2023/clip.html"
let g:filedict["comp"] = "/home/kdog3682/2023/compiled.js"
let g:filedict["cg"] = "/home/kdog3682/PYTHON/chatgpt.py"
let g:filedict["mathdraft1"] = "https://docs.google.com/document/d/1-FgzbtB3k29hJ_utfQxhX_ZEc30r81F4Ak-6z_nQW3o/edit?usp=drivesdk"
let g:filedict["md1"] = "https://docs.google.com/document/d/1-FgzbtB3k29hJ_utfQxhX_ZEc30r81F4Ak-6z_nQW3o/edit?usp=drivesdk"
let g:pydict['pr'] = "props: {\n    $1: {default: ''},\n}$c"
let g:vimdict['pr'] = "props: {\n    $1: {default: ''},$c\n}"
let g:vimdict['f'] = "let g:filedict['temp'] = '$1'"
let g:filedict['hmc'] = 'https://hammymathclass.github.io/'
let g:filedict['hmf'] = 'https://hammymathclass.github.io/flashcards'
let g:filedict['boa'] = 'https://bankofamerica.com'
let g:execRef['set'] = "call Humya()"
let g:filedict["git"] = "/home/kdog3682/PYTHON/githubscript.py"
let g:execRef['evtj'] = 'call ExportVarToJavascript()'
let g:execRef['gm'] = 'call GoBookmark2023("$arg")'
let g:bookmarks2023["ox"] = ["/home/kdog3682/2023/OX3HTML.js", "OX3HTML", "        /** i **/"]
let g:bookmarks2023["blfaf"] = ["/home/kdog3682/.vimrc", "BookmarkLineFileAndFunction", "    let file = CurrentFile()"]
let g:pydict['rpw'] = "function foo${MonthDay()}() {\n    function runner(s) {\n        $c\n    }\n    rpw('${FileGetter2($1)}', runner)\n}\nfoo${MonthDay()}()"
let xis = "((${GetXName($0)}, i) => {\n    $c\n})"
let ab = "(([a, b]) => {\n    $c\n})"
let g:wpsnippets['vim']['i'] = "SnippetActionJsImport"
let g:wpsnippets['vim']['fd'] = "let g:filedict[\"$1\"] = \"$2\""
let g:filedict["bh"] = "~/.bash_history"
let g:pydict['m'] = "const m = findall(r, s)"
let g:wpsnippets['vim']['no'] = "nnoremap $1 :call $2()<CR>"
let g:filedict["wc"] = "/home/kdog3682/2023/worksheet-components.js"
let g:filedict["bu"] = "/home/kdog3682/2023/browser-utils.js"
let g:bookmarks2023["gih"] = ["/home/kdog3682/.vimrc", "GetIndexesHelper2", "function GetIndexesHelper2(key) abort"]
let g:vimsnippets["w"] = "while 1\n    $c\nendwhile"
let g:vimsnippets["if"] = "if $1\n    $c\nendif"
let g:vimsnippets["hk"] = "if has_key($1, '$2')\n    $c\nendif"
let g:execRef['isf'] = 0
let g:filedict["bc"] = "/home/kdog3682/2023/base-components.js"
let g:resourcedir='/home/kdog3682/Resources2023/'
let g:assignmentdir='/home/kdog3682/Resources2023/Assignments/'
let g:vimdict['dep'] = "throw 'deprecation'"
let g:execRef["setjs"] = "call SetType()"
let g:execRef["setv"] = "call SetVFast()"
let g:filedict["sp"] = "/home/kdog3682/PYTHON/scratchpad.py"
let g:filedict["cml"] = "/home/kdog3682/2023/cml.txt"
let g:pydict['ar'] = "MakeStringArray2023"
let g:vimdict['ar'] = "MakeStringArray2023"
let g:filedict["test"] = "/mnt/chromeos/MyFiles/Downloads/test.pdf"
let g:filedict["pa"] = "/home/kdog3682/2023/parse.js"
let g:pydict['dict'] = "MakeStringDict2023"
let g:vimdict['dict'] = "MakeStringDict2023"
let g:filedict["temp"] = "/home/kdog3682/2023/CodeOrganizer.js"
let g:filedict["co"] = "/home/kdog3682/2023/codeOrganizer.js"
let g:filedict['gpt']='https://chat.openai.com'
let g:filedict["lj"] = "/home/kdog3682/2023/log.json"
let g:pydict['comn'] = "const r = /^$c/gm\nconst matches = findall(r, s)"
let g:pydict['lines'] = "const lines = lineGetter(s)"
let g:filedict["asd"] = "/home/kdog3682/CWF/public/asd"
let g:filedict["rc"] = "/home/kdog3682/2023/report-cards.txt"
let g:filedict["Cl"] = "/home/kdog3682/2023/Classroom.js"
let g:filedict["Co"] = "/home/kdog3682/2023/CodeOrganizer.js"
let g:filedict["vob"] = "/home/kdog3682/2023/vueObjectBuilder.js"
let g:filedict["vu"] = "/home/kdog3682/2023/vue-utils.js"
let g:filedict["wc2"] = "/home/kdog3682/2023/worksheet-components-2.js"
let g:filedict["vdata"] = "/home/kdog3682/2023/vueData.js"
let g:execRef['dep'] = 'call BasePY("deprecateFile $cf")'
let g:bookmarks2023["ps"] = ["/home/kdog3682/2023/parse.js", "ParseState", "        addProperty(this.store, ...args)"]
let g:vimdict['emptyFunction'] = "function foo${MDY()}() {\n    $c\n}\nconsole.log(foo${MDY()})\n"
let g:pythonsnippets['emptyFunction'] = "def foo${MDY()}():\n    $c\n:"
let g:pydict['emptyFunction'] = "function foo${MDY()}() {\n    $c\n}\nconsole.log(foo${MDY()})\n"
let g:pythonsnippets['runner'] = "    def runner(item):\n    $c    \n"
let g:filedict["strf"] = "https://strftime.org/"
let g:filedict["strftime"] = "https://strftime.org/"
let g:filedict["rm"] = "/home/kdog3682/2023/raw-math.txt"
let g:pydict['get'] = "function foo${MDY()}() {\n    $c\n}\nconsole.log(foo${MDY()})\n"
let g:wpsnippets['txt']['get'] = '${GetTextIniItems($1)}'
let g:filedict["nu"] = "/home/kdog3682/2023/node-utils.js"
let g:execRef['ws'] = 'call BasePY("WorkSummary $cf")'
let g:pydict['ass'] = "assert($1, \"$1 is required\")"
let g:vimdict["ax"] = "b g asd"
let g:execRef["sx"] = "call SwapXOnMeasure()"
let g:pydict["bm"] = "/* @bookmark.${TimestampedBookmark()} */"
let g:pydict["ndy"] = "console.log('ndy')"
let g:vimdict["bm"] = "\" @bookmark.${TimestampedBookmark($1)}"
let g:vimdict["bm"] = "${TimestampedBookmark($1)}"
let g:pydict["bm"] = "${TimestampedBookmark($1)}"

let g:fastfiles = {
    \'6': {
       \ 'default': '/home/kdog3682/2023/worksheet-components-2.js',
       \ 'quiz.txt': '/home/kdog3682/2023/parse.js',
       \ 'parse.js': 'quiz.txt',
    \},
    \'7': '/home/kdog3682/2023/vueData.js',
\}

let g:pydict["main"] = "main(`\n$c\n`)"
let g:filedict["cst"] = "/home/kdog3682/2023/classwork.school.txt"
let g:filedict["gmc"] = "/home/kdog3682/2023/generateMultipleChoice.js"
let g:execRef["prx"] = "call PasteReplace()"
let g:execRef["dsf"] = "call RunServerFile('debug')"
let g:execRef["dbx"] = "call RunServerFile('debug')"
let g:execRef["dbxj"] = "call RunServerFile('debug screenshot')"
let g:execRef["rsfw"] = "call RunServerFile('debug screenshot wonderful')"
let g:jspyref2['js']['trycatch'] = {'above': ['try {'], 'below': ['} catch(e) {', '    console.log("ERRORRRRRRRR", e.stack)', '}']}
let g:vimdict['ht'] = "var ${Pascal($1)} = {\n    name: '${Capitalize($1)}',\n    props: ['value'],\n    template: `\n        $c\n    `,\n}"
let g:pydict['ht'] = "var ${Pascal($1)} = {\n    name: '${Pascal($1)}',\n    props: ['value'],\n    template: `\n        $c\n    `,\n}"
let g:filedict["gsw"] = "/home/kdog3682/2023/gold-star-worksheets.txt"
let g:filedict["dt"] = "/home/kdog3682/2023/dialogue.txt"
let g:filedict["java"] = "/home/kdog3682/2023/javascript.dependencies.json"
let g:filedict["jdj"] = "/home/kdog3682/2023/javascript.dependencies.json"
let g:saved_words=[]
let g:pydict["tpl"] = "UnloadSavedWordsOnTemplate"
let g:vimdict["tpl"] = "UnloadSavedWordsOnTemplate"
let g:vimdict["link"] = "let g:filedict[\"link\"] = \"$1\""
let g:filedict['hmc'] = 'https://hammymath.github.io/'
let g:filedict["pac"] = "/home/kdog3682/Resources2023/pac.txt"
let g:vimdict["er"] = "let g:execRef[\"${Abrev($1)}\"] = \"$1\""
let g:vimdict["er"] = "let g:execRef[\"${Abrev($1)}\"] = \"$1\""
let g:vimdict["er"] = "let g:execRef[\"$1\"] = \"$2\""
let g:execRef["cob"] = "call CloseOldestBuffers()"
let g:execRef["nu"] = "call ExecNU()"
let g:execRef["aifl"] = "call JSFileRunner('addMissingImportsFromDependencyLibrary')"
let g:execRef["cd"] = "call ChangeDir('$1')"
let g:execRef["serve"] = "call Node('/home/kdog3682/2023/serve_html_file.js', '$cf')"
let g:execRef["pub"] = "call Python2('publish', '$cf')"
let g:execRef["publish"] = "call Python2('publish', '$cf')"
let g:filedict["cre"] = "/home/kdog3682/2023/compileRE.js"
let g:pydict["config"] = "const config = {\n    $c\n}"
let g:pydict["js"] = "AddPydictItem"
let g:vimdict["js"] = "AddPydictItem"
let g:filedict["pcj"] = "/home/kdog3682/2023/production.config.js"
let g:filedict["pconf"] = "/home/kdog3682/2023/production.config.js"
let g:pydict["pcd"] = "if (productionConfig.debug) {\n    ${Rep192($1)}\n}"
let g:pydict["css"] = "$1 {\n    $c\n}"
let g:wpsnippets["js"]["nestobj"] = "{a:1, b:2, c:{d:{e: [{g: 1}]}}}"
let g:server_html_index = 0
let g:server_html_file = 'build.html'

let g:server_html_commands = [
    \'a',
    \'numbers',
    \'clipData',
    \'loremVobJSON',
\]

let g:filedict["lorem"] = "/home/kdog3682/2023/lorem.js"
let g:pydict["retcom"] = "return {\n    component: '',\n    value: ''\n}"
let g:pydict["coo"] = "const options = {\n    $c\n}"
let g:pydict["ref"] = "const ref = {\n    $c\n}"
let g:filedict["vob"] = "/home/kdog3682/2023/vob.worksheet.js"
let g:filedict["ws2"] = "/home/kdog3682/2023/ws2.vob.js"
let g:filedict["w2"] = "/home/kdog3682/2023/ws2.vob.js"
let g:server_html_super_commands = ['string-screenshot', 't1-screenshot', 't1-print', 't2-print', 'final-print']
let g:filedict["qt"] = "/home/kdog3682/2023/quiz.txt"
let g:execRef["pbg"] = "PasteBufferGroupToFile"
let g:filedict["hc"] = "/home/kdog3682/2023/hammyComponents.js"
let g:sshfile = "/home/kdog3682/.ssh/known_hosts"
let g:execRef["tsa"] = "ToStringArray"
let g:execRef["rcf"] = "RunCurrentFunction"
let g:filedict["bjs"] = "/home/kdog3682/2023/b.js"
let g:wpsnippets["js"]["mapkv"] = "map($1, (k, v) => {\n    $c\n})"
let g:filedict["v2docs"] = "https://v2.vuejs.org/v2/guide/custom-directive.html#Directive-Hook-Arguments"
let pk = ['implicit', 'string', 'clip', 'ws2draft', 'ws2final']
let ak = ['screenshot', 'html', 'print', 'clip', 'windowString']

let g:rsf = {
    \'ak': {'items': ak, 'index': 0}  ,
    \'pk': {'items': pk, 'index': 0}  ,
\}

let g:ck = 'VBuild'
let g:filedict["c"] = "/home/kdog3682/2023/clip.js"
let g:lastworddict['s'] = "style {\n    $c\n}"
let g:filedict["sj"] = "/home/kdog3682/2023/server.js"
let g:filedict["gi"] = "/home/kdog3682/2023/.gitignore"
let g:filedict["in"] = "/home/kdog3682/2023/index.html"
let g:filedict["i"] = "/home/kdog3682/2023/index.html"
let g:filedict["ps"] = "/home/kdog3682/2023/Puppeteer.js"
let g:filedict["pj"] = "/home/kdog3682/2023/package.json"
let g:filedict["chl"] = "/home/kdog3682/2023/changelog.md"
let g:filedict["ftmd"] = "/home/kdog3682/.vim/ftplugin/markdown.vim"
let g:filedict["cuo"] = "/home/kdog3682/CWF/public/css-utils.js"
let g:filedict["mu"] = "/home/kdog3682/2023/ma.js"
let g:filedict["mr"] = "/home/kdog3682/2023/math-review.txt"
let g:filedict["c"] = "/home/kdog3682/2023/clip.js"
let g:filedict['resume'] = "https://docs.google.com/document/d/11PzEB137TPCDX4xr8Hcy3ysJ4FPRwm24jRMhIb7Lb6k/edit"
let g:filedict["cu"] = "/home/kdog3682/2023/css-utils.js"
let g:filedict["base"] = "/home/kdog3682/2023/base.css"
let g:execRef['cfn'] = 'call BasePY("vimMoveFile $cf $arg")'
let g:execRef['ack'] = 'call BasePY("appendClipKeys $cf")'
let g:filedict["gac"] = "/home/kdog3682/2023/googleAppConnector.js"
let g:filedict["hb"] = "/home/kdog3682/2023/htmlBuilder.js"
let g:execRef["js"] = "SaveJS"

let g:registratar_templates = {
    \'c': "cnoreab $1 $2 <C-R>=Eatchar('\\s')<CR>",
    \'n': 'nnoremap $1 :call $2()<CR>',
    \'i': 'inoremap $1 <esc>:call $2()<CR>',
    \'eat': "inoreab $1 $2<C-R>=Eatchar('\\s')<CR>",
    \'iabfn': "inoreab $1 $2()<LEFT><C-R>=Eatchar('\\s')<CR>",
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

let g:execRef["atn"] = "ArrowToNormal"
let g:wpsnippets["js"]["hdiv"] = "return h('div', 'hi')"
let g:wpsnippets["js"]["hdiv"] = "return h('div', 'hi')"
let g:filedict["log"] = "/home/kdog3682/2023/log.json"
let g:filedict["oe"] = "/home/kdog3682/2023/elementObjects.js"
let g:filedict["eo"] = "/home/kdog3682/2023/elementObjects.js"
let g:filedict["log"] = "/home/kdog3682/2023/log.json"
let g:wpsnippets["js"]["vmap"] = "const children = $1.map((child,i) => {\n    return h($c)\n})\n\nconst parentOptions = {\nfoo: ''\n}\nreturn renderWrapper(this, parentOptions, children)"
let g:wpsnippets["js"]["coo"] = "const options = {\n    fooo: '',\n}\n$c"
let g:wpsnippets["js"]["vmap"] = "const children = $1.map((child,i) => {\n    return h($c)\n})\n\nconst parentOptions = {\n    foo: ''\n}\nreturn renderWrapper(this, parentOptions, children)"
let g:npsref = {}
let g:npsref['vdir'] = "$1, {\n    $c\n}, $2"
let alist = [0, 1,2,3,4,5]
let g:pureExecRef = {}
let g:pureExecRef['e'] = 'Explore /home/kdog3682/2023'
let g:pureExecRef['b'] = 'bd'
let g:execRef["olf"] = "OpenMostRecentFile"
let g:most_recent_directory = g:dldir
let g:bindingPrefixRE = '^(var|let|const|async|function[!*]?|class|def) \zs'
let g:bindingPrefixInnerRE = '^    +(var|let|const|async|function[!*]?|class|def) \zs'
let g:bindingAnywhereRE = '^ *(var|let|const|async|function!?|class|def) \zs\w+'
let g:bindingInnerRE = '^ +(var|let|const|async|function!?|class|def) \zs\w+'
let g:blockEndRE = '^(endfunction|\\?[\}\]]|def|class|\w+ +\=)'
let g:pythonWithStateDict = {}
let g:pythonWithStateDict['addfiles'] = {}
let g:pythonWithStateDict['btb'] = 'write=temp.txt.js block writeBlockToBrowser'
let dir_path = g:dir2023
let g:execRef["stop"] = "Stop"
let g:drivedir = "/mnt/chromeos/GoogleDrive/MyDrive/"
let g:drivejsondir="/mnt/chromeos/GoogleDrive/MyDrive/JSONS"
let g:execRef["mk"] = "Mk2023"
let g:execRef["itm"] = "InoremapTestMode"
let g:execRef["unmap"] = "Unmap"
let g:visualactiondict['vcm'] = {'fn': 'VisualCreateMappings', 'i': 'nospaces-nobraces', 'arg': 'eat', 'replace': 1}
let g:visualactiondict['btb'] = {'fn': 'VisualBTB', 'i': 'window', 'arg': 'text'}
let g:vimdict['inner'] = "function! Inner(i, s)\n    let s = a:s\n    $c\nendfunction"
let g:cssaliases = {"size":"fontSize","fs":"fontSize","colgap":"column-gap","rowgap":"row-gap","bc":"borderColor","bw":"borderWidth","br":"borderRadius","lh":"lineHeight","pt":"paddingTop","pb":"paddingBottom","pl":"paddingLeft","pr":"paddingRight","fw":"fontWeight","w":"width","maxw":"maxWidth","wmax":"maxWidth","h":"height","gtc":"gridTemplateColumns","gtr":"gridTemplateRows","mt":"marginTop","mb":"marginBottom","ml":"marginLeft","mr":"marginRight","p":"padding","padding":"padding","m":"margin","margin":"margin","mh":"minHeight","mw":"minWidth","minw":"minWidth","flexgrow":"flexGrow","fg":"flexGrow","left":"left","right":"right","bottom":"bottom","bot":"bottom","top":"top"}
let g:pythonsnippets['base']="from base import *\nfrom next import *"
let g:execRef["cleaner"] = "call CleanerMode('$arg')"
let g:execRef["cmo"] = "call CleanerMode('$arg')"
let g:execRef["namo"] = "call NodeArgMode()"
let g:execRef["asi"] = "call AddSnippetItem()"
let g:execRef["gs"] = "ec g:globalState"
let g:filedict["np"] = "/home/kdog3682/PYTHON/new.py"
let g:filedict["pcd"] = "/home/kdog3682/2023/pdfgen.components.document.js"
let g:notefile = '/home/kdog3682/2023/notes.txt'
let g:filedict["fb"] = "/home/kdog3682/2023/foobar.txt"
let g:vimplugins = "~/.vim/plugins"
let g:filedict["notes"] = "/home/kdog3682/2023/notes.txt"
let g:filedict["mst"] = "/home/kdog3682/2023/math.singletons.txt"
let g:filedict["mt"] = "/home/kdog3682/2023/math.txt"
let g:filedict["ns"] = "/home/kdog3682/2023/nerdSolver.js"
let g:fnRE2 = '^(var|(async )?function[!*]?|def|class|const) \zs\w+|^\w+ \= \{ *$'
let g:execRef["imo"] = "InoremapTestMode"
let g:execRef["cmo"] = "CheckMode"
let g:execRef["cpmo"] = "let g:globalState['mode'] = 'CopyMode'"
let g:execRef["done"] = "DoneWithModes"
let g:filedict["bsh"] = "/home/kdog3682/2023/buildServerHTML.js"
let g:filedict["ra"] = "/home/kdog3682/2023/routerApps.js"
let g:filedict["sam"] = "/home/kdog3682/2023/serverArgManager.js"
let g:pydict[""] = ""
let g:pydict[""] = ""
let g:pydict[""] = ""
let g:pydict["box"] = "width: 50,\nheight: 50,\nbackground: 'red',\n"
let g:pydict["options"] = "const options = {\n    $c\n}"
let g:filedict["vs"] = "/home/kdog3682/2023/vueSetup.js"
let g:filedict["lore"] = "/home/kdog3682/2023/lorem.js"
let g:execRef["sermo"] = "ServerTestMode"
let g:execRef["ls"] = "ListDirectory"
let g:filedict["tod"] = "/home/kdog3682/2023/today.js"
let g:filedict["ch"] = "/home/kdog3682/2023/clip.html"
let g:filedict["pc"] = "/home/kdog3682/2023/pdfgen.colors.js"
let g:filedict["txt"] = "/home/kdog3682/Resources2023/text.txt"
let g:resourcedir = '/home/kdog3682/Resources2023/'
let g:todo = '/home/kdog3682/Resources2023/changelog.md'
let g:pydict["doc"] = "/* ${DateStamp()} documentation:\n * $c\n */"
let g:wpsnippets["js"]["doc"] = "/*******************************\n* ${DateStamp()} documentation:\n* $c\n* \n*******************************/"
let g:letter_index = 0
let g:execRef["ce"] = "CheckExec"
let g:execRef["eat"] = "RegisterEat2"
let g:filedict['ugit'] = "https://github.com/kdog3682/2023/blob/main/utils.js"
let g:vad = g:visualactiondict
let g:vad['exec'] = {'fn': 'VisualExec', 'i': 'same-indent-no-breaks'}
let g:vad['e'] = {'fn': 'VisualExec', 'i': 'same-indent-no-breaks'}
let g:execRef["aa"] = "AlignAssignments"
let g:filedict["foot"] = "/home/kdog3682/2023/foo.txt"
let g:filedict["np"] = "/home/kdog3682/2023/notepad.txt"
let g:execRef["sd"] = "Shuntdown3"
let g:wpsnippets["js"]["constobj"] = "const $1 = {\n    $c\n}"
let g:vimdict["gather"] = "${GatherVariablesFromPage($1)}"
let g:pydict["gather"] = "${GatherVariablesFromPage($1)}"
let g:alist = ['a', 'b', 'c', 'd', 'e']
let g:execRef["goto"] = "GotoGRefLine"
let g:filedict["jc"] = "/home/kdog3682/2023/jsbin.css"
let g:filedict["cl"] = "/home/kdog3682/2023/class.js"
let g:wpsnippets["js"]["vren"] = "const children = this.items.map((item, i) => {\n    const props = Object.assign({value: item}, this.$props)\n    return h(VItem, props)\n})\nconst parentOptions = {\n    style: styleFromProps(this, 'align')\n}\nreturn renderWrapper(this, parentOptions, children)"
let g:wpsnippets["js"]["fkv"] = "const f = (k, v) => {\n    \n}"
let g:wpsnippets["js"]["tsi"] = "template slot = {item}"
let g:filedict["spy"] = "/home/kdog3682/PYTHON/scratchpad.py"
let g:execRef["guotie"] = "Guotie"
let g:filedict["tdj"] = "/home/kdog3682/2023/today.guotie.js"
let g:wpsnippets["js"]["pi"] = "/* prettier-ignore */"
let g:wpsnippets["html"]["link"] = "<link rel=\"stylesheet\" href=\"$1\"/>"
let g:wpsnippets["vim"]["ifes"] = "if $1 == ''\n    $c\nendif"
let g:wpsnippets["vim"]["emptyfunction"] = "function ${FooName()}(s)\n    let s = a:s\n    $c\nendfunction"
let g:wpsnippets["vim"]["emptyfunction2"] = "function ${Capitalize(FooName())}(s)\n    let s = a:s\n     $c\nendfunction"
let g:wpsnippets["py"]["function"] = "def ${MakePythonFunctionName($0)}:\n    $c\n    return"
let g:wpsnippets["js"]["emptyfunction"] = "function ${FooName()}(s)\n    let s = a:s\n    $c\nendfunction"
let g:wpsnippets["js"]["emptyfunction2"] = "${JsEmptyFunction()}"
let g:wpsnippets["py"]["emptyfunction2"] = "${PyEmptyFunction()}"
let g:pyargs = ["a", "key", "content", "r", "pdfdir", "word", "text", "obj", "newItems", "ignoreRE", "items2", "result", "chifile", "fileName", "tail", "options", "title", "runner", "lang", "todo", "before", "xml", "root", "rawFiles", "dir", "folders", "sort", "locals", "delay", "indexes", "id", "file", "n", "cmd", "examdir", "fallback", "url", "strife", "schema", "image", "symbols", "match", "write", "after", "clipfile", "ext", "error", "servedir", "name", "urls", "frame", "i", "outdir", "pubdir", "b", "dirs", "inpath", "bargs", "append", "dldir", "x", "read", "budir", "out", "d", "args", "payload", "jsdir", "sshfile", "value", "last", "date2", "tests", "mathdir", "m", "fn", "ref", "k", "s", "outpath", "save", "count", "trash", "aobj", "size", "img", "path", "removed", "jchdir", "to", "temp", "values", "fontdir", "f", "link", "items", "matches", "filename", "self", "k1", "stack", "arr", "recent", "newName", "source", "app", "dir2023", "files", "original", "el", "pages", "date1", "prepend", "pydir", "ver", "tempfile", "data", "childDir", "chunk", "dict", "o", "hfile", "item", "md", "callable", "day", "sandir", "template", "store", "links", "e", "drivedir", "kwargs", "l1", "lines", "date", "glogfile", "t", "newPath", "trashdir", "command", "newDir", "l2", "regex", "v", "arg"]
let g:visualactiondict['res'] = {'fn': 'VisualShuntResource', 'i': 'below-cursor', 'delete': 1}
let g:visualactiondict['ca'] = {'fn': 'VisualShuntCodingAssignment', 'i': 'below-cursor', 'delete': 1}
let g:visualactiondict['md'] = {'fn': 'VisualShuntMD', 'i': 'below-cursor'}
let g:visualactiondict['log'] = {'fn': 'VisualLog', 'i': 'noss'}
let g:wpsnippets["py"]["fn"] = "def fn($c):\n    return "
let g:filedict["np"] = "/home/kdog3682/PYTHON/next.py"
let g:iabdict["flipY"] = ""
let g:execRef["foo"] = "FooFunction"
let g:wpsnippets["html"]["script"] = "<script>\n    $c\n</script>"
let g:filedict["firebase"] = "https://console.firebase.google.com/u/0/project/hammy-math-class/database/hammy-math-class-default-rtdb/data/~2F"
let g:filedict["firei"] = "/home/kdog3682/FIREBASE/index.html"
let g:filedict["firej"] = "/home/kdog3682/FIREBASE/package.json"
let g:filedict["fires"] = "/home/kdog3682/FIREBASE/index.js"
let g:filedict["firesj"] = "/home/kdog3682/FIREBASE/server.js"
let g:filedict["firegi"] = "/home/kdog3682/FIREBASE/.gitignore"
let g:filedict["pygi"] = "/home/kdog3682/PYTHON/.gitignore"
let g:execRef["gpd"] = "GitPushDir"
let g:filedict["u2"] = "/home/kdog3682/2023/utils2.js"
let g:execRef["pip"] = "PipInstall"
let g:execRef["pipu"] = "PipUnInstall"
let g:pipdir = "/usr/lib/python3/dist-packages/pip"
let g:dirdict = {"localbackupdir": "/home/kdog3682/LOCALBACKUP/", "publishdir": "/home/kdog3682/PUBLISHED/", "firebasedir": "/home/kdog3682/FIREBASE/", "publicfirebasedir": "/home/kdog3682/FIREBASE/public", "latexdir": "/home/kdog3682/LATEX/", "archdir": "/mnt/chromeos/GoogleDrive/MyDrive/ARCHIVES/", "mathchadir": "/home/kdog3682/2023/mathcha/", "drivedir": "/mnt/chromeos/GoogleDrive/MyDrive/", "outdir": "/mnt/chromeos/GoogleDrive/MyDrive/OUTBOUND/", "zipdir": "/mnt/chromeos/GoogleDrive/MyDrive/ZIP/", "gdocdir": "/mnt/chromeos/GoogleDrive/MyDrive/GDOC/", "backupdir": "/mnt/chromeos/GoogleDrive/MyDrive/BACKUP/", "dropboxdir": "~/DropBox", "pythondir": "/home/kdog3682/PYTHON/", "javascriptdir": "/home/kdog3682/JAVASCRIPT/", "swiftdir": "/home/kdog3682/SWIFT-LATEX/", "htmlbudir": "https://drive.google.com/drive/folders/16gpifAlQhHxBHr3SP0IbRiwnGLwbmF59", "teachdir": "/home/kdog3682/TEACHING/", "vimdir": "/home/kdog3682/VIM & SH/", "nodedir": "/home/kdog3682/.npm-global/lib/node_modules/", "tododir": "/mnt/chromeos/GoogleDrive/MyDrive/TODO", "boadir": "/mnt/chromeos/GoogleDrive/MyDrive/TODO/BOA", "examdir": "/home/kdog3682/EXAMS/", "productiondir": "/home/kdog3682/PRODUCTIONS/", "clipdir": "/home/kdog3682/CLIPS/", "lezerdir": "/home/kdog3682/.npm-global/lib/node_modules/@lezer/", "pubnodedir": "/home/kdog3682/CWF/public/node_modules/", "cwfnodedir": "/home/kdog3682/CWF/node_modules/", "servernodedir": "/home/kdog3682/CWF/node_modules/", "svgdir": "/home/kdog3682/SVG/", "nodemodulesdir": "/home/kdog3682/.npm-global/lib/node_modules/", "servedir": "/home/kdog3682/SERVER/", "googleassignmentdir": "/home/kdog3682/CWF/public/assignments", "homedir": "/home/kdog3682/", "rootdir": "/home/kdog3682/", "jsdir": "/home/kdog3682/CWF/public/", "dldir": "/mnt/chromeos/MyFiles/Downloads/", "pdfdldir": "/mnt/chromeos/MyFiles/Downloads/PDFS/", "sandir": "/mnt/chromeos/removable/Sandisk/", "usbdir": "/mnt/chromeos/removable/", "usbdrivedir": "/mnt/chromeos/removable/USB Drive/", "pydir": "/home/kdog3682/PYTHON/", "pdfdir": "/home/kdog3682/PDFS/", "logdir": "/home/kdog3682/LOGS/", "oldtxtdir": "/home/kdog3682/TEXTS/", "txtdir": "/home/kdog3682/2023/TEXTS/", "jsondir": "/home/kdog3682/JSONS/", "mathdir": "/home/kdog3682/MATH/", "picdir": "/home/kdog3682/PICS/", "colordir": "/home/kdog3682/COLORING/", "colordistdir": "/home/kdog3682/COLORING/dist/", "trashdir": "/home/kdog3682/TRASH/", "fontdir": "/home/kdog3682/CWF/public/fonts/", "jchdir": "/home/kdog3682/CWF/jch/", "pubdir": "/home/kdog3682/CWF/public/", "budir": "/mnt/chromeos/GoogleDrive/MyDrive/BACKUP/", "tempbudir": "/mnt/chromeos/GoogleDrive/MyDrive/BACKUP/TEMP/", "bucurdir": "/mnt/chromeos/GoogleDrive/MyDrive/BACKUP/CURRENT/", "currentdir": "/home/kdog3682/2023/", "cwfdir": "/home/kdog3682/CWF/", "drivecwfdir": "/mnt/chromeos/GoogleDrive/MyDrive/CWF/", "macdir": "/users/harfunmaterials/", "pdir": "/home/kdog3682/PYTHON/", "jdir": "/home/kdog3682/JAVASCRIPT/", "firedir": "/home/kdog3682/FIREBASE/", "pipdir": "/usr/lib/python3/dist-packages/pip/"}
let g:filedict["fb"] = "/home/kdog3682/PYTHON/fb.py"
let g:filedict['firestoreconsole']="https://console.cloud.google.com/apis/credentials/key/491dccbc-2dd8-409e-b8bd-8d599d0582fa?project=hammy-math-class"
let g:filedict["fs"] = "/home/kdog3682/FIREBASE/index.js"
let g:filedict["fs"] = "/home/kdog3682/2023/fire.js"
let g:filedict["fonts"] = "https://fonts.google.com/"
let g:wpsnippets["js"]["n0tes"] = "########################## ###############\n# Notes ################## ${DateStamp()} #### \n########################## ###############"
let g:execRef["eres"] = "ExploreResources"
let g:execRef["enode"] = "Explore /home/kdog3682/2023/node_modules/"
let g:filedict["smd"] = "/home/kdog3682/Resources2023/story.md"
let g:filedict["story"] = "/home/kdog3682/Resources2023/story.md"
let g:execRef["p2b"] = "call Paste2Buffer($arg)"
let g:filedict["temp"] = "/home/kdog3682/Resources2023/kids-coding-lecture-1-g4-g5-patterns-vars-grocery.txt"
let g:wpsnippets["js"]["-str"] = "__str__(data, children) {\n    $c\n}"
let g:wpsnippets["js"]["-json"] = "__json__() {\n    $c\n}"
let g:wpsnippets["js"]["jso"] = "class $1 extends JSObject {\n\n    $c__str__(data, children) {\n        \n    }\n\n    __json__() {\n        \n    }\n}"
let g:wpsnippets["js"]["sfrb"] = "const html = new DomNode('root')\nconst body = new DomNode('body')"
let g:filedict["cm"] = "/home/kdog3682/2023/cm.js"
let g:filedict["git2023"] = "https://github.com/kdog3682/2023"
let g:filedict["gitpython"] = "https://github.com/kdog3682/python"
let g:wpsnippets["py"]["forkv"] = "for k,v in store.items():\n    $c"
let g:wpsnippets["py"]["tt"] = "write('temp.txt.js', $1)"
let g:wpsnippets["js"]["tt"] = "write('temp.txt.js', $1)"
let g:filedict["tts"] = "/home/kdog3682/2023/temp.txt.js"
let g:filedict["cx"] = "/home/kdog3682/2023/cx.js"
let g:filedict["cmj"] = "/home/kdog3682/2023/cm.js"
let g:wpsnippets["js"]["do"] = "do {\n    $c\n} while($1)"
let g:wpsnippets["js"]["lgs"] = "console.log(getState())"
let g:wpsnippets['py']["s"] = "${TimestampString($1)} = \"\"\"\n    $c\n\"\"\""
let g:filedict["srt"] = "/home/kdog3682/2023/story.readings.txt"
let g:visualactiondict['rep'] = {'fn': 'VisualReplace', 'i': 'innerblock', 'arg': '', 'replace': 1}
let g:visualactiondict['match'] = {'fn': 'VisualMatch', 'i': 'codeblock', 'arg': ''}
let g:visualactiondict['r'] = {'fn': 'VisualRemove', 'i': 'codeblock', 'arg': '', 'replace': 1}
let g:filedict["le2"] = "/home/kdog3682/2023/LineEdit2.js"
let g:wpsnippets["js"]["fo"] = "class Fo {\n    $cconstructor() {\n        this.a = 'a'\n    }\n}"
let g:filedict["e2"] = "/home/kdog3682/2023/Element2.js"
let g:filedict["sc2"] = "/home/kdog3682/2023/StateContext2.js"
let g:visualactiondict['ltc'] = {'fn': 'VLetToConst', 'i': 'innerblock', 'arg': '', 'replace': 1}
let g:vimdict["ift"] = "if Test($1, '$2')\n    $c\nendif"
let g:wpsnippets["js"]["nerd"] = "import nerdamer from \"nerdamer/all.min.js\""
let g:execRef["ggf"] = "GetGithubFile"
let g:execRef["P"] = "call JSFileRunner('prettyNoComments')"
let g:filedict["cmpj"] = "/home/kdog3682/CM2/package.json"
let g:filedict["cmt"] = "/home/kdog3682/CM2/cm.test.js"
let g:filedict["cmraw"] = "/home/kdog3682/CM2/cm.raw.js"
let g:cmdir = "/home/kdog3682/CM/"
let g:filedict["cej"] = "/home/kdog3682/2023/cm.esm.js"
let g:filedict["roll"] = "/home/kdog3682/2023/rollup.js"
let g:pydict["buf"] = "${BufferItemsFromTemplate($1)}"
let g:filedict["cmj"] = "/home/kdog3682/2023/cm.js"
let g:filedict["ps"] = "/home/kdog3682/2023/Puppeteer2.js"
let g:filedict["ps1"] = "/home/kdog3682/2023/Puppeteer.js"
let g:execRef["ecm"] = "Explore /home/kdog3682/CM/"
let g:filedict["db"] = "/home/kdog3682/2023/DomBuilder.js"
let g:filedict["cmu"] = "/home/kdog3682/CM/cm-utils.js"
let g:filedict["cmm"] = "/home/kdog3682/2023/cm-mixins.js"
let g:filedict["ih"] = "/home/kdog3682/2023/cm-inputHandler.js"
let g:wpsnippets["js"]["css"] = "css: `\n    $c\n`,"
let g:execRef["seta8"] = "SetA8File"
let g:wpsnippets["js"]["a"] = "async function $1() {\n    $c\n}"
let g:execRef["gr"] = "GlobalReplace2"
let g:execRef["hbt"] = "HtmlBuilderTest"
let g:wpsnippets["js"]["mt"] = "async function mounted_test_$1() {\n    $c\n}"
let g:wpsnippets["js"]["sw"] = "------------------\n$c\n------------------"
let g:filedict["cmu"] = "/home/kdog3682/2023/cm-utils.js"
let g:wpsnippets["js"]["cs"] = "------------------------\n    $c\n------------------------"
let ss = '/* prettier-ignore */ import {Cache, Element, Group, KeyError, PageStorage, Store, Storage, TypeAssertion, UniqueStorage, Watcher, addObjectOrObjectProperty, argsKwargs, announce, arrayToDict, addProperty, addQuotes, argWrapFactory, assert, abrev, abf, addExtension, assignFresh, antif, atFirst, atSecond, bindingRE, backAndForth, bind, backspace, bindObject, breaker, blockQuote, brackify, bringToLife, conditionalString, check, capitalizeName, callableArgsKwargs, createFunction, comment, countCaptureGroups, capitalizeTitle, classMixin, callableRE, camelToTitle, curry, createVariable, changeExtension, curryStart, curryEnd, capitalize, copy, camelCase, compose, char2n, camelToDash, deepCopy, distinct, definedSort, defineVariable, dedent, deepMerge, datestamp, doublef, dictSetter, dsearch, doUntil, dashCase, doubleQuote, dict, dictGetter, depluralize, dreplace, dictf, empty, errorWrap, entries, endsWithWord, exporter, edit, exists, evaluate, extend, forDoubles, filter, fuzzyMatch,flat2D, find, flatMap, fill, fixUrl, functionGetter, findall, fixPath, flat, fparse, findIndex, firstLine, ftest, getFallback, getConfigArg, gather, getShortest, groupBy, getKwargs, getFirstName, getBindingName, getParameters, getLastWord, getCodeWords, getIndent, getExtension, getLast, getLongest, getChunks, getCaller, getStackTrace, getConstructorName, getFirstWord, getWords, getSpaces, hasKey, hasLetter, handleError, hasComma, hasSpaces, hasHtml, hasBracket, hasNewline, hasCaptureGroup, hasEquals, hasValue, hasCamelCase, hasNumber, hackReplace, isInitialized, isCss, iterate, iteratorWrapper, isFromMap, isPercentage, isBasicType, isSingleLetter, isSymbol, isError, isColor, isPlural, isPrimitiveArray, info, insert, indexGetter, incrementf, isCallable, isQuote, isEven, isOdd, isLast, isHTML, isNode, interweave, inferLang, isString, isArray, isObject, isDefined, isFunction, isPrimitive, isNumber, isSet, isNestedArray, indent, isNull, isWord, isBoolean, isRegExp, identity,isObjectLiteral, isJsonParsable, isCapitalized, isNewLine, isObjectArray, isStringArray, isClassFunction, joinSpaces, join, keyArrayToObject, log, lineSplit, list, lineDitto, lowerCase, linebreakRE, len, lineGetter, lineCount, lastLine, logConsole, mixinAliases, methodCase, matchall, makeFastRunner, mixinSetters, modularIncrement, makeRunner, mixin, modularf, matchGetter, merge, mget, map, mergeOnTop, mergeToObject, mapFilter, noop, nestPush, no, newlineIndent, n2char, objectEditor, objectWalk, overlap, objectToString, opposite, push2, prepareText, proseCase, parseError, pluralize, pipe, parseTopAttrs, pascalCase, partition, parens, push, pop, parseJSON, raise, round, reducerStrategy, reduce, reWrap2, remove, rigidSort, removeQuotes, rep, removeComments, range, removeExtension, rescape, reverse, reWrap, reduceToString, repeatUntil, successWrap, stateGetter, smarterIndent, slice, stringCall, stop, splitThePage, swapKey, sayhi, swap, splitMapJoin, splitCamel, smallify, search, stringify,shared, smartDedent, stringBreaker, sleep, split, snakeCase, stringArgument, sorted, splitOnce, searchf, secondLine, toJSON, toString, toPoints, titleCase, textOrJson, toNumber, toArgument, toNestedArray, test, type, tail, transformObject, trim, testf, toArray, templater, totalOverlap, upperCase, unique, uncapitalize, unzip, vueCase, waterfall, wrap, walk, wrapf, xsplit, yes, zip} from "./utils.js";'
let g:pydict['ss']=ss
let g:filedict["hb2"] = "/home/kdog3682/2023/htmlBuilder2.js"
let g:execRef["vite"] = "npm run dev"
let g:execRef["v1"] = "RunVite"
let g:wpsnippets["js"]["ed"] = "export default {\n    $c\n}"
let g:filedict["va"] = "/home/kdog3682/2023/vite1/a.js"
let g:filedict["jobs"] = "/home/kdog3682/2023/jobs.txt"
let g:filedict["cre"] = "/home/kdog3682/2023/compileRE.js"
let g:filedict["cre"] = "/home/kdog3682/2023/parselib.js"
let g:filedict["pl"] = "/home/kdog3682/2023/parselib.js"
let g:filedict["csd"] = "css-data.cleaned.json"
let g:wpsnippets["js"]["lc"] = "logConsole($c)"
let g:filedict["vi2"] = "/home/kdog3682/2023/vite1/index2.html"
let g:filedict["hs"] = "/home/kdog3682/2023/hammy.js"
let g:wpsnippets["html"]["base"] = "<!DOCTYPE html> \n<html> \n    $c<head>\n        <script src=\"\"></script>\n    </head>\n\n    <body>\n        <div id=\"app\"></div>\n    </body>\n</html>"
let g:wpsnippets["html"]["style"] = "<style>\n    $c\n</style>"
let g:filedict["bray"] = "/home/kdog3682/2023/bray.math.index.es.js"
let g:execRef["ver"] = "CheckBashVersion"
let g:filedict["t2"] = "/home/kdog3682/2023/today2.js"
let g:filedict["files"] = "/home/kdog3682/2023/files.txt"
let g:filedict["plc"] = "/home/kdog3682/2023/pl-create.js"
let g:execRef["roll"] = "Rollup"
let g:wpsnippets['markdown'] = {}
let g:wpsnippets["markdown"]["fm"] = "-------------\n$c\n-------------"
let g:execRef["mkdir"] = "AppMkdir"
let g:netrw_confirm = 0
let g:visualactiondict['md'] = {'fn': 'VisualShuntMD', 'i': 'mdblock', 'arg': '', 'delete': 1}
let g:execRef["df"] = "DeleteFile2"
let g:execRef["cf"] = "call PackageManager('createFile')"
let g:execRef["cf2"] = "call PackageManager('createFile2')"
let g:execRef["cfff"] = "call PackageManager('createFileFromFile')"
let g:execRef["lezt"] = "call PackageManager('lezTransform')"
let g:execRef["p"] = "call PackageManager('nodePrettier2')"
let g:execRef["d3"] = "call PackageManager('grabD3')"
let g:execRef["gbn"] = "GetBindingNames"
let g:execRef["gfn"] = "call append('$', sort(GetBindingNames()))"
let g:vuenavdict['ctr'] = 'constructor\('
let g:execRef["rns"] = "RenameSelf"
let g:execRef["rnf"] = "RenameSelf"
let g:execRef["gc"] = "GitCheckoutFromGithub"
let g:execRef["gc"] = "GitCheckout"
let g:execRef["emo"] = "let g:globalState['mode'] = 'EvalMode'"
let g:filedict["plhb"] = "/home/kdog3682/2023/pl-htmlBuilder.js"
let g:filedict["cnt"] = "/home/kdog3682/2023/code-notes.txt"
let g:execRef["san"] = "SetActiveNodeFile"
let g:execRef["sann"] = "SetTempActiveNodeFile"
let g:activeNodeFile = "/home/kdog3682/2023/createVue.js"
let g:filedict["ist"] = "/home/kdog3682/MARKDOWN/Ivy and Sandy Teach Hammy Decimals.md"
let g:activeNodeFile = "/home/kdog3682/2023/pl-htmlBuilder.js"
let g:execRef["en"] = "Explore /home/kdog3682/2023/node_modules/"
let g:execRef["toc"] = "AppendTocInFile"
let g:filedict["vh"] = "/home/kdog3682/2023/vite.html"
let g:filedict["vcj"] = "/home/kdog3682/2023/vite.config.js"
let g:execRef["n"] = "TestFunctionWithNewString"
let g:wpsnippets["js"]["propz"] = "props: {\n    value: { default: $c },\n},"
let g:activeNodeFile = "/home/kdog3682/2023/css-utils.js"
let g:filedict["ex"] = "/home/kdog3682/2023/examples.js"
let g:activeNodeFile = "/home/kdog3682/2023/examples.js"
let g:activeNodeFile1 = ''
let g:activeNodeFile2 = ''
let g:activeNodeFile3 = ''
let g:activeNodeFile4 = ''
let g:activeNodeFile5 = '/home/kdog3682/2023/pl-create.js'
let g:activeNodeFile2 = "/home/kdog3682/2023/pl-svgBuilder.js"
let g:visualactiondict['shex'] = {'fn': 'VisualShuntToExamples', 'i': 'below-cursor', 'arg': '', 'delete': 1}
let g:activeNodeFile = "/home/kdog3682/2023/juneComponents.js"
let g:activeNodeFile = "/home/kdog3682/2023/juneComponents.js"
let g:activeNodeFile = "/home/kdog3682/2023/pl-svgBuilder.js"
let g:execRef["bu2"] = "BackupFileFromLine"
let g:filedict["backup"] = "/home/kdog3682/2023/backup.js"
let g:activeNodeFile = "/home/kdog3682/2023/pl-svgBuilder.js"
let g:filedict["lez"] = "/home/kdog3682/2023/Lezer.js"
let g:activeNodeFile3 = "/home/kdog3682/2023/pl-htmlBuilder.js"
let g:activeNodeFile = "/home/kdog3682/2023/pl-htmlBuilder.js"
let g:execRef["ff"] = "ffstring"
let g:execRef["ff"] = "FindFiles"
let g:execRef["ask"] = "ask_reddit"
let g:activeNodeFile4 = "/home/kdog3682/2023/pl-create.js"
let g:activeNodeFile = "/home/kdog3682/2023/setupComponent.js"
let g:wpsnippets["js"]["tth"] = "console.log(typeof this); throw '';"
let g:wpsnippets["js"]["tth"] = "console.log(typeof this); throw ''; /* tth */"
let g:filedict["mdw"] = "/home/kdog3682/2023/my-data-website.js"
let g:filedict["gdata"] = "/home/kdog3682/2023/git-data2.json"
let g:wpsnippets["js"]["obj"] = "{\n\n},"
let g:wpsnippets["js"]["obj"] = "{\n    $c\n},"
let g:activeNodeFile = "/home/kdog3682/2023/cm.js"
let g:activeNodeFile1 = "/home/kdog3682/2023/cm-utils.js"
let g:filedict["esm"] = "/home/kdog3682/2023/cm.esm.js"
let g:filedict["gd"] = "/home/kdog3682/2023/git-data3.json"
let g:filedict["nx"] = "/home/kdog3682/2023/next.js"
let g:filedict["cmx"] = "/home/kdog3682/2023/cm-next.js"
let g:filedict['net']='https://google.com'
let g:filedict["jg"] = "/home/kdog3682/2023/node_modules/@lezer/javascript/src/javascript.grammar"
let g:wpsnippets["js"]["re"] = "runExample($1)\n---------------------------------\n    $c\n---------------------------------"
let g:wpsnippets["js"]["re"] = "$1()\n---------------------------------\n    $c\n---------------------------------"
let g:execRef["deprecate"] = "DeprecateFile"
let g:filedict["cm"] = "/home/kdog3682/2023/cm-main.js"
let g:filedict["cmc"] = "/home/kdog3682/2023/cm-components.js"
let g:execRef["iunmap"] = "Iunmap"
let g:activeNodeFile = "/home/kdog3682/2023/pl-htmlBuilder.js"
let g:activeNodeFile = "/home/kdog3682/2023/cm-components.js"
let g:secondActiveFile = '/home/kdog3682/2023/pl-htmlBuilder.js'
let g:activeNodeFile = '/home/kdog3682/2023/pl-htmlBuilder.js'
let g:execRef["ds"] = "DocStamp"
let g:activeNodeFile = "/home/kdog3682/2023/cm-components.js"
let g:execRef["one"] = "OneifyTheFile"
let g:filedict["cst"] = "/home/kdog3682/2023/cm-simpleTextExtensions.js"
let g:filedict["cme"] = "/home/kdog3682/2023/CodeMirrorEditor.js"
let g:filedict["cab"] = "/home/kdog3682/2023/cabmap.js"
let g:filedict["cmn"] = "/home/kdog3682/2023/cm-next.js"
let g:filedict["m"] = "/home/kdog3682/2023/node_modules/@lezer/python/src/"
let g:filedict["lpg"] = "/home/kdog3682/2023/node_modules/@lezer/python/src/python.grammar"
let g:wpsnippets["js"]["dirs"] = "[ \"top\", \"right\", \"bottom\", \"left\" ]"
let g:filedict["c2"] = "/home/kdog3682/2023/clip2.js"
let g:filedict["EC"] = "/home/kdog3682/2023/ElementController.js"
let g:execRef["dep"] = "DepNote"
let g:wpsnippets["js"]["stype"] = "switch (type(x)) {\n    case 'Object':\n    case 'Array':\n    case 'String':\n    case 'Number':    case 'Undefined':    case 'Null':\n    default:\n        return \n}"
let g:wpsnippets["js"]["stype"] = "switch (type(x)) {\n    case 'Null':\n    case 'Undefined':\n        return \n\n    case 'Object':\n    case 'Array':\n\n    case 'Function':\n    case 'String':\n    case 'Number':\n    default:\n        return \n}"
let g:wpsnippets["js"]["runarunb"] = "function runA() {\n    \n}\nfunction runB() {\n    $c\n}"
let g:wpsnippets["js"]["sc"] = "import {setupComponent} from \"./setupComponent.js\"; setupComponent($c)"
let g:filedict["jm"] = "/home/kdog3682/PYTHON/javascriptModule.py"
let g:wpsnippets["markdown"]["print"] = "${PrintFiles($1)}"
let g:wpsnippets["markdown"]["wami"] = "${MarkdownWhereami($1)}"
let g:wpsnippets["markdown"]["buffers"] = "${MarkdownWriteBuffers()}"
let g:filedict["sc"] = "/home/kdog3682/2023/setupComponent.js"
let g:execRef["cct"] = "CopyCurrentTemplateToHtmlBuilder"
let g:filedict["pfs"] = "/home/kdog3682/2023/pythonFileServer.js"
let g:execRef["ai"] = "call JAC('ai')"
let g:wpsnippets["js"]["arrows"] = "ArrowLeft() {\n    $c\n},\nArrowRight() {\n    \n},\nArrowTop() {\n    \n},\nArrowDown() {\n    \n},\nSpace() {\n    \n},"
let g:filedict["a"] = "/home/kdog3682/2023/a.js"
let g:execRef["gtc"] = "GitTempCheckout"
let g:execRef["checkout"] = "GitTempCheckout"
let g:filedict["next"] = "/home/kdog3682/2023/next.js"
let g:filedict["sty"] = "/home/kdog3682/2023/Stylesheet.js"
let g:filedict["int"] = "/home/kdog3682/2023/Interactive.js"
let g:filedict["cab"] = "/home/kdog3682/2023/cabmap.js"
let g:pydict["nu"] = 'import { writeUnitTest, read, clip2, appendVariable2, clip, appendVariable, write, rpw, isFile, sysget, } from "./node-utils.js"'
let g:pydict['i'] = "SnippetActionJsImport"

let g:packageManagerRef = {
    \'createFile': {'file': 'app-codeOrganizer.js', 'args': ['cf', 'wordA', 'wordB']},
    \'addMissingImportsFromDependencyLibrary': {'file': 'app-codeOrganizer.js', 'args': ['cf']},
    \'createFile2': {'file': 'app-codeOrganizer.js', 'args': ['cf', 'wordA', 'wordB']},
    \'createFileFromFile': {'file': 'app-codeOrganizer.js', 'args': ['cf', 'identifier'], 'open': 'identifierAsFile'},
    \'lezTransform': {'file': 'app-codeOrganizer.js', 'args': ['cf']},
    \'p': {'file': 'app-prettier.js', 'args': ['cf']},
    \'nodePrettier': {'file': 'app-prettier.js', 'args': ['cf']},
    \'nodePrettier2': {'file': 'app-prettier.js', 'args': ['cf']},
    \'grabD3': {'file': 'app-prettier.js', 'args': ['cf'], 'open': 'cft'},
    \'readParse': {'file': 'app-readParse.js', 'args': ['cf'], 'copy': 1}
\}

let g:execRef["rpm"] = "RegisterPackageManagerItem"
let g:packageManagerRef["addFromSourceFile"] = {"file": "app-codeOrganizer.js", "args": ["cf"]}
let g:execRef["afsf"] = "call PackageManager('addFromSourceFile')"
let g:visualactiondict['replace'] = {'fn': 'VisualReplace2', 'i': 'codeblock', 'arg': '', 'replace': 1}
let g:visualactiondict['grab'] = {'fn': 'VisualGrab', 'i': 'codeblock'}
let g:filedict["cfd"] = "/home/kdog3682/2023/CSSFunctionDict.js"
let g:filedict["gco"] = "/home/kdog3682/2023/git-checkout.temp.js"
let g:filedict["var"] = "/home/kdog3682/2023/variables.js"
let g:filedict["cap"] = "/home/kdog3682/2023/cssApps.js"
let g:pydict['doc'] = "action:WriteDocumentationViaBufferSwap"
let g:vimdict['doc'] = "action:WriteDocumentationViaBufferSwap"
let g:ldrdict["ereg"] = "RegisterGoFileViaE"
let g:wpsnippets["js"]["cssa"] = "return [\n    ['width', $c],\n]"
let g:wpsnippets["js"]["switcharrows"] = "switch (e.key) {\n    $ccase 'ArrowLeft':\n    case 'ArrowRight':\n    case 'ArrowUp':\n    case 'ArrowDwn':\n}"
let g:execRef["rw"] = "ReplaceWordWithPasteBuffer"
let aobj = {'a':1}
let g:filedict["shf"] = "/home/kdog3682/2023/serve_html_file.js"
let g:execRef["fpd"] = "FindPyDictItem"
let g:wpsnippets["js"]["rr"] = "return reduce2($1, (item) => {\n    return $c\n})"
let g:wpsnippets["js"]["watcher"] = "const watcher = new Watcher()"
let g:gfgfdict['gc'] = ['/home/kdog3682/2023/vueSetup.js', 'getComponent', 1]
let g:activeNodeFile1 = "/home/kdog3682/2023/a.js"
let g:activeNodeFile1 = "/home/kdog3682/2023/ec-main.js"
let g:wpsnippets["js"]["mot"] = "mounted() {\n    console.log('hello from ${GetBindingName()}')\n    console.log(this.$el.outerHTML)$c\n},"
let g:listTocFiles = []
let g:execRef["stf"] = "SaveTocFiles"
let g:execRef["mtf"] = "MarkTocFile"
let g:filedict["st"] = "/home/kdog3682/2023/saved.txt"
let g:filedict["ecm"] = "/home/kdog3682/2023/ec-main.js"
let g:filedict["ech"] = "/home/kdog3682/2023/ec-handle.js"
let g:filedict["bc"] = "/home/kdog3682/2023/baseComponents.js"
let g:activeNodeFile2 = "/home/kdog3682/2023/ec-handle.js"
let g:filedict["ws"] = "/home/kdog3682/2023/WindowStorage.js"
let g:wpsnippets["vim"]["fd"] = "let g:filedict[\"$1\"] = \"$2\""
let g:filedict["nyc"] = "https://www.schools.nyc.gov/docs/default-source/default-document-library/parent-facing-calendar-2022-23"
let g:filedict["jj"] = "/home/kdog3682/CLIPS/file-identifier-reference.june.json"
let g:visualactiondict['ct'] = {'fn': 'VisualCct', 'i': 'vueTemplate', 'arg': '/home/kdog3682/2023/pl-htmlBuilder.js'}
let g:visualactiondict['cct'] = {'fn': 'VisualCct', 'i': 'vueTemplate', 'arg': '/home/kdog3682/DIST/pl-htmlBuilder.js'}
let g:filedict["csa"] = "/home/kdog3682/2023/cssApps.js"
let g:packageManagerRef["simpleRoll"] = {"file": "rollup.js", "args": ["cf"]}
let g:execRef["simpleRoll"] = "call PackageManager('simpleRoll')"
let g:execRef["mrd"] = "RootMkdir"
let g:highFrequencyFiles = ['saved.txt', 'documentation.txt']
let g:filedict["do"] = "/home/kdog3682/2023/DateObject.js"
let g:execRef["papo"] = "PropArrayToPropObject"
let g:filedict["exs"] = "/home/kdog3682/2023/examples.js"
let g:filedict["rp"] = "/home/kdog3682/2023/rp.js"
let g:filedict["csv1"] = "/mnt/chromeos/MyFiles/Downloads/history (1).csv"
let g:execRef["edrive"] = "Explore /mnt/chromeos/GoogleDrive/MyDrive"
let g:execRef["eclips"] = "Explore /home/kdog3682/CLIPS/"
let g:execRef["ejson"] = "Explore /home/kdog3682/JSONS/"
let g:ldrdict["wp"] = "Whereami3"
let g:lbmDict = {}
let g:execRef["glb"] = "GoLocationalBookMark"
let g:execRef["slb"] = "SaveLocationalBookMark"
let g:lbmDict["sd"] = ["1688860322", "/home/kdog3682/2023/setupComponent.js"]
let g:execRef["ltf"] = "LambdaToFunction"
let g:filedict["dhb"] = "/home/kdog3682/DIST/pl-htmlBuilder.js"
let g:execRef["doc"] = "WriteDocumentationViaBufferSwap"
let g:wpsnippets["js"]["oc"] = "onClick() {\n    %cconsole.log('hello from onClick')\n},"
let g:wpsnippets["js"]["oc"] = "onClick() {\n    %cconsole.log('hello from onClick')\n},\nonItemClick() {\n    console.log('hello from onItemClick', item)\n},"
let g:lbmDict["rl"] = ["1688998928", "/home/kdog3682/2023/pl-create.js"]
let g:execRef["mtb"] = "MoveBlockToBottom"
let g:filedict["g3"] = "/home/kdog3682/RESOURCES/pl-htmlBuilder.js"
let g:filedict["mc"] = "/home/kdog3682/2023/mathComponents.js"
let g:wpsnippets["js"]["template"] = "template: `\n    $c\n`,"
let g:activeNodeFile = "/home/kdog3682/2023/pl-htmlBuilder.js"
let g:filedict["csb"] = "/home/kdog3682/2023/CSSParserBuilder.js"
let g:activeNodeFile6= '/home/kdog3682/2023/baseComponents.js'
let g:activeNodeFile = "/home/kdog3682/2023/pl-htmlBuilder.js"
let g:filedict["xs"] = "/home/kdog3682/2023/xmlString.js"
let g:execRef["asf"] = "AppendShuntFile"
let g:execRef["ssf"] = "SetActiveShuntFile"
let g:wpsnippets["js"]["temp"] = "const specA = {\n    $ca: 1,\n}\n\nconst specB = {\n    b: 1\n}"
let g:filedict["temp"] = "/home/kdog3682/2023/temp.txt"
let g:execRef["e"] = "Explore /home/kdog3682/2023/"
let g:filedict["pcm"] = "/home/kdog3682/2023/pl-comprehensiveMarkdown.js"
let g:execRef["url"] = "Urlify"
let g:saveTheFile = 1
let g:execRef["edl"] = "Explore /mnt/chromeos/MyFiles/Downloads/"
let g:execRef["efonts"] = "Explore /home/kdog3682/2023/fonts"
let g:filedict["scss"] = "/home/kdog3682/2023/style.css"
let g:filedict["mics"] = "/home/kdog3682/2023/material-icons.css"
let g:filedict["th"] = "/home/kdog3682/2023/test.html"
let g:activeNodeFile = "/home/kdog3682/2023/baseComponents.js"
let g:activeNodeFile = "/home/kdog3682/2023/pl-htmlBuilder.js"
let g:activeNodeFile = "/home/kdog3682/2023/pl-comprehensiveMarkdown.js"
let g:activeNodeFile = "/home/kdog3682/2023/baseComponents.js"
let g:filedict["vc"] = "/home/kdog3682/2023/pl-comprehensiveMarkdown.js"
let g:dirdict3 = {"root": "/home/kdog3682/", "drive": "/mnt/chromeos/GoogleDrive/MyDrive/", "drivedir": "/mnt/chromeos/GoogleDrive/MyDrive/", "jsondrive": "/mnt/chromeos/GoogleDrive/MyDrive/JSONS/", "math": "/home/kdog3682/MATH/", "home": "/home/kdog3682/", "clips": "/home/kdog3682/CLIPS", "js": "/home/kdog3682/CWF/public/", "html": "/home/kdog3682/CWF/public/", "py": "/home/kdog3682/PYTHON/", "pdf": "/home/kdog3682/PDFS/", "txt": "/home/kdog3682/2023/TEXTS/", "json": "/home/kdog3682/JSONS/", "jpg": "/home/kdog3682/PICS/", "jpeg": "/home/kdog3682/PICS/", "png": "/home/kdog3682/PICS/", "svg": "/home/kdog3682/PICS/", "log": "/home/kdog3682/LOGS/", "dl": "/mnt/chromeos/MyFiles/Downloads/", "dldir": "/mnt/chromeos/MyFiles/Downloads/", "trash": "/home/kdog3682/TRASH/", "trashdir": "/home/kdog3682/TRASH/", "fonts": "/home/kdog3682/2023/fonts/", "fontdir": "/home/kdog3682/2023/fonts/", "budir": "/mnt/chromeos/GoogleDrive/MyDrive/BACKUP/", "current": "/home/kdog3682/2023/", "dir2023": "/home/kdog3682/2023/", "jchdir": "/home/kdog3682/CWF/jch/", "pubdir": "/home/kdog3682/CWF/public/", "cwf": "/home/kdog3682/CWF", "cwd": "/home/kdog3682/CWD"}
let g:execRef["eh"] = "ExplorerHandler"
let g:filedict["pdf"] = "/home/kdog3682/PYTHON/pdf.py"
let g:execRef["pip"] = "InstallPip"
let g:execRef["ct"] = "CopyCurrentTemplateToHtmlBuilder2"
let g:wpsnippets["py"]["k"] = "$1 = kwargs.get('$1', None)"
let g:filedict["co2"] = "/home/kdog3682/2023/codeOrganizer2.js"
let g:filedict["gtc"] = "/home/kdog3682/2023/git-checkout.temp.js"
let g:changelogActionRef = {}
let g:filedict["gd3"] = "/home/kdog3682/2023/git-data3.json"
let g:execRef["abn"] = "AppendBindingNamesInOrgFile"
let g:execRef["gr"] = "GitRevert"
let g:linkedBufferGroups = {}
let g:linkedBufferGroups["/home/kdog3682/.vimrc"] = ['/home/kdog3682/.vimrc', '/home/kdog3682/2023/changelog.md']
let g:linkedBufferGroups["/home/kdog3682/2023/changelog.md"] = ['/home/kdog3682/.vimrc', '/home/kdog3682/2023/changelog.md']
let g:linkedBufferGroups["/home/kdog3682/2023/cm-lezer.js"] = ['/home/kdog3682/2023/cm-lezer.js', '/home/kdog3682/2023/cm-next.js']
let g:linkedBufferGroups["/home/kdog3682/2023/cm3.js"] = ['/home/kdog3682/2023/cm3.js', '/home/kdog3682/2023/cm-next.js']
let g:linkedBufferGroups["/home/kdog3682/2023/cm-next.js"] = ['/home/kdog3682/2023/cm-lezer.js', '/home/kdog3682/2023/cm-next.js']
let g:visualactiondict['gfw'] = {'fn': 'VisualFirstWord', 'i': 'contiguous'}
let g:actionAndArgAliases = {}
let g:wpsnippets["vim"]["ifhk"] = "if has_key($c)\n\nendif"
let g:visualactiondict['VisualChanged'] = {'fn': 'VisualChanged', 'i': 'contiguous'}
let g:visualactiondict['VisualNotes'] = {'fn': 'VisualNotes', 'i': 'codeblock'}
let g:execRef["gvv"] = "GetVimVariables"
let g:fnRE5 = "/\\v^((async )?function!?|var|def|class|const) "
let g:fnRE6 = '\v^((async )?function!?|var|def|class|const) '
let g:execRef["ssf"] = "SetShuntFile"
let g:visualactiondict['s'] = {'fn': 'VisualStringVarIt', 'i': 'nospaces-nobraces'}
let g:visualactiondict['str'] = {'fn': 'VisualStringVarIt', 'i': 'nospaces-nobraces'}
let g:visualactiondict['arr'] = {'arg': 'temp', 'fn': 'VisualArray', 'i': 'nospaces-nobraces'}
let g:visualactiondict['obj'] = {'arg': 'temp', 'fn': 'VisualObject', 'i': 'contiguous'}
let g:debugDict = {}
let g:debugDict["SaveDebug-/home/kdog3682/.vimrc"] = {'file': '/home/kdog3682/.vimrc', 'upline': '    call DeleteLine()', 'functionName': 'SaveDebug', 'line': '    "howdy'}
let g:execRef["sdebug"] = "SaveDebug"
let g:execRef["rdebug"] = "RestoreDebug"
let g:debugDict["nextify-/home/kdog3682/2023/next.js"] = {'file': '/home/kdog3682/2023/next.js', 'upline': '    const items = state[pluralize(key)]', 'functionName': 'nextify', 'line': '    //console.log({prevMethodName, nextMethodName, indexName, itemName, items})'}
let g:execRef["boo"] = "Booga122"
let g:execRef["update"] = "UpdateAndExecuteLine"
let g:wpsnippets["vim"]["asdf"] = "function! Asdf()\n    ec 'hi'\nendfunction"
let g:wpsnippets["js"]["nu"] = "import { appendVariableFile, writeUnitTest, read, clip2, appendVariable2, clip, appendVariable, write, rpw, isFile, sysget, } from \"./node-utils.js\""
let g:shortMonths = [ "jan", "feb", "mar", "apr", "may", "jun", "jul", "aug", "sep", "oct", "nov", "dec"]
let g:execRef["dti"] = "DefineTempIab"
let g:execRef["uv"] = "UnmapVim"
let g:execRef["amm"] = "AddMovementMaps"
let g:wpsnippets["vim"]["t"] = "let template = \"\n\\\\n    $c\n\\\\n    \n\\\""
let g:filedict["cmdoc"] = "https://codemirror.net/docs/ref/#view.Decoration"
let g:filedict["jiu"] = "https://9animetv.to/watch/jujutsu-kaisen-2nd-season-18413?ep=102662"
let g:wpsnippets["vim"]["tail"] = "let tail = Tail()"
let g:filedict["vuedoc"] = "https://v2.vuejs.org/v2/guide/render-function.html"
let g:execRef["mfd"] = "MarkForDeletion"
let g:execRef["lc"] = "SetLogConsole"
let g:wpsnippets["js"]["ct"] = "console.testString = `\n    $c\n`\nconsole.test($1)"
let g:zzLocation = ''
let g:filedict["vuedirective"] = "https://v2.vuejs.org/v2/guide/custom-directive.html"
let g:execRef["mu"] = "MoveFunctionUp"
let g:filedict["vtt"] = "/home/kdog3682/2023/vim.temp.txt"
let g:wpsnippets["vim"]["qrp"] = "return Templater(\"rpw($qgp, $lf, 'throw')\")"
let g:filedict["cre"] = "/home/kdog3682/2023/compileRE.js"
let g:filedict["cmp"] = "/home/kdog3682/2023/cm-prettier.js"
let g:execRef["rpac"] = "RegisterPacItemFromCurrentLine"
let g:activeNodeFile = "/home/kdog3682/2023/pl-d3Builder.js"
let g:filedict["gb"] = "/home/kdog3682/2023/getBlocks.js"
let g:execRef["ain"] = "AddImportNext"
let g:execRef["iai"] = "call InsertAtInsertionPoint(GetCurrentWordOrBinding())"
let g:filedict["eba"] = "/home/kdog3682/2023/base.css"
let g:filedict["eii"] = "/home/kdog3682/2023/index.html"
let g:filedict["enn"] = "/home/kdog3682/2023/notes.txt"
let g:filedict["ess"] = "/home/kdog3682/2023/TEXTS/scratchpad.txt"
let g:filedict["ewc"] = "/home/kdog3682/2023/worksheet-components.js"
let g:filedict["eut"] = "/home/kdog3682/2023/utils.js"
let g:filedict["epj"] = "/home/kdog3682/2023/package.json"
let g:filedict["eps"] = "/home/kdog3682/2023/Puppeteer.js"
let g:filedict["emr"] = "/home/kdog3682/2023/math-review.txt"
let g:filedict["egi"] = "/home/kdog3682/2023/.gitignore"
let g:filedict["esj"] = "/home/kdog3682/2023/server.js"
let g:filedict["esk"] = "/home/kdog3682/2023/splitKatex.js"
let g:filedict["ess"] = "/home/kdog3682/2023/scratchpad.js"
let g:filedict["ein"] = "/home/kdog3682/2023/index.html"
let g:filedict["ete"] = "/home/kdog3682/2023/textEdit.js"
let g:filedict["ega"] = "/home/kdog3682/2023/googleAppConnector.js"
let g:filedict["em2"] = "/home/kdog3682/2023/math.txt"
let g:filedict["eco"] = "/home/kdog3682/2023/compiled.js"
let g:filedict["eme"] = "/home/kdog3682/2023/me.txt"
let g:filedict["emg"] = "/home/kdog3682/2023/mathgen.js"
let g:filedict["emu"] = "/home/kdog3682/2023/ma.js"
let g:filedict["ech"] = "/home/kdog3682/2023/clip.html"
let g:filedict["ecn"] = "/home/kdog3682/2023/code-notes.txt"
let g:filedict["env"] = "/home/kdog3682/PYTHON/env.py"
let g:filedict["eng"] = "/home/kdog3682/PYTHON/githubscript.py"
let g:filedict["ecu"] = "/home/kdog3682/2023/css-utils.js"
let g:filedict["ebc"] = "/home/kdog3682/2023/base-components.js"
let g:filedict["ech"] = "/home/kdog3682/2023/changelog.md"
let g:filedict["eps"] = "/home/kdog3682/2023/Puppeteer.js"
let g:filedict["enu"] = "/home/kdog3682/2023/node-utils.js"
let g:filedict["eu"] = "/home/kdog3682/2023/utils.js"
let g:filedict["est"] = "/home/kdog3682/2023/Stylesheet.js"
let g:filedict["eca"] = "/home/kdog3682/2023/cssApps.js"
let g:filedict["enx"] = "/home/kdog3682/2023/next.js"
let g:filedict["ecx"] = "/home/kdog3682/2023/cm-next.js"
let g:filedict["ebc"] = "/home/kdog3682/2023/baseComponents.js"
let g:filedict["est"] = "/home/kdog3682/2023/saved.txt"
let g:filedict["emv"] = "/home/kdog3682/2023/my-files.json"
let g:filedict["ec3"] = "/home/kdog3682/2023/cm3.js"
let g:filedict["ed3"] = "/home/kdog3682/2023/pl-d3Builder.js"
let g:filedict["eft"] = "/home/kdog3682/2023/files.txt"
let g:filedict["vr"] = "/home/kdog3682/2023/vue-registrar.js"
let g:linkedBufferGroups["/home/kdog3682/PYTHON/next.py"] = ['/home/kdog3682/PYTHON/next.py', '/home/kdog3682/PYTHON/run.py']
let g:linkedBufferGroups["/home/kdog3682/PYTHON/run.py"] = ['/home/kdog3682/PYTHON/next.py', '/home/kdog3682/PYTHON/run.py']
let g:filedict["pac"] = "/home/kdog3682/PYTHON/pac.txt"
let g:activeNodeFile = "/home/kdog3682/2023/pl-htmlBuilder.js"
let g:filedict["d3"] = "/home/kdog3682/2023/pl-d3Builder.js"
let g:execRef["dupe"] = "DuplicateCallWithString"
let g:filedict["vcj"] = "/home/kdog3682/2023/vite.config.js"
let g:filedict["ih2"] = "/home/kdog3682/2023/index2.html"
let g:filedict["ereg"] = "epa"
let g:filedict["tur"] = "/home/kdog3682/2023/turtle.js"
let g:filedict["mu2"] = "/home/kdog3682/2023/math-utils.js"
let g:pythonPackageManagerRef = {}
let g:pythonPackageManagerRef['buildViteFile'] = ['cf', 'prompt:reponame']
let g:execRef["build"] = "call PythonPackageManager('buildViteFile', '$1')"
let g:execRef["glt"] = "GetLastTouched"
let g:wpsnippets["js"]["myedit"] = "/* my-edit */\n$c\n/*---------------------------------*/"
let g:wpsnippets["js"]["iv"] = "import * as variables from \"./variables.js\""
let g:filedict["cmc"] = "/home/kdog3682/2023/cm-components.js"
let g:filedict["tur2"] = "/home/kdog3682/2023/turtle2.js"
let g:filedict["gh"] = "/home/kdog3682/2023/graph-helpers.js"
let g:filedict["tur2"] = "/home/kdog3682/2023/turtle2.js"
let g:activeNodeFile = "/home/kdog3682/2023/turtle2.js"
let g:filedict["pld3"] = "/home/kdog3682/2023/pl-d3Builder.js"
let g:wpsnippets["js"]["igc"] = "import { getColor } from \"./getColor.js\""
let g:execRef["st"] = "SaveTemp"
let g:execRef["rt"] = "RevertTemp"
let g:execRef["cwf"] = "CurrentlyWorkingIn"
let g:currentWorkFile = "math.txt"
let g:filedict["hb"] = "/home/kdog3682/2023/pl-htmlBuilder.js"
let g:activeNodeFile = "/home/kdog3682/2023/pl-htmlBuilder.js"
let g:filedict["tt"] = g:temptextfile
let g:execRef["glt"] = "GetLastTouched"
let g:filedict["ft"] = g:ftfile
let g:execRef["ft"] = "PostFileTable"
let g:filedict["vf"] = g:ftplugindir . "functions.vim"
let g:filedict["vd"] = g:ftplugindir . "variables.vim"
let g:filedict["jd"] = g:jdjsonfile
let g:wpsnippets["py"]["d"] = "def $1():\n    $c"
let g:wpsnippets["py"]["com"] = "\"\"\"\n    $c\n\"\"\""
let g:wpsnippets["js"]["sam"] = "/**********************************************\n in: $c\n out: \n sample: \n\n *********************************************/"
let g:filedict["umq"] = "/home/kdog3682/RESOURCES/Unsorted Math Questions.txt"
let g:filedict["mp"] = "/home/kdog3682/2023/mathProblems.js"
let g:filedict["par"] = "/home/kdog3682/2023/parse.js"
let g:execRef['q'] = 'bd'
let g:pureExecRef['bd'] = 'bd!'
let g:execRef["awi"] = "AddWordToImports"
let g:execRef["ba"] = ":bufdo bd"
let g:activeNodeFile = "/home/kdog3682/2023/pl-htmlBuilder.js"
let g:wpsnippets["js"]["ps"] = "problem: $c\nsolution: "
let g:execRef["abf"] = "AppendBlockToFile"
let g:filedict["serf"] = "/home/kdog3682/2023/serveFile.js"
let g:filedict["serv"] = "/home/kdog3682/2023/serveVite.js"
let g:pmr2 = {}
let g:pmr2['vite'] = 'serveVite.js serve baseComponents.html'
let g:pmr2['vite-build'] = 'serveVite.js build baseComponents.html'
let g:pmr2['vite-serve'] = 'serveVite.js serve baseComponents.html'
let g:pmr2['vs'] = 'serveVite.js serve baseComponents.html'
let g:pmr2['ami'] = 'codeOrganizer2.js ami cf'
let g:pmr2['amid'] = 'codeOrganizer2.js amid cf'
let g:pmr2['print'] = 'serveFile.js print baseComponents.html'
let g:pmr2['html'] = 'serveFile.js html baseComponents.html'
let g:pmr2['ss'] = 'serveFile.js screenshot baseComponents.html'

iab <buffer> l let
inoreab <buffer> <buffer> <silent>  ef endfunction<C-R>=Eatchar('\s')<CR>
inoreab <buffer> dot2 a:0 >= 2 ? a:2 :
inoreab <buffer> dots a:0 >= 1 ? a:1 :
inoreab <buffer> e ec
inoreab <buffer> gbdb let lines = GetBlockDeleteBlock()<LEFT><C-R>=Eatchar('\s')<CR>
inoreab <buffer> gsl let [spaces, line] = GetSpacesAndLine()<C-R>=Eatchar('\s')<CR>
inoreab <buffer> lab let [a,b] =
inoreab <buffer> ll let line = CurrentLine()
inoreab <buffer> stop call Stop()
inoreab <buffer> ten throw 'throwing error'
inoreab <buffer> vge GetExtension()<LEFT><C-R>=Eatchar('\s')<CR>
inoremap <buffer> <expr> qgf Qgf()
inoremap <buffer> <expr> qgp Qgp()
inoremap <buffer> <silent> qb <CR><CR><c-d><s-left><C-R>=Eatchar('\s')<CR>
inoremap <buffer> qw <esc><RIGHT>a
nmap qy Aqy
nnoremap ! :w<CR>:call Node('examples.js')<cr>
nnoremap & :wa<CR>:call RunOtherJSFile()<CR>
nnoremap 'A :call GoLastTouchedFile()<CR>
nnoremap * :wa<CR>:call RunOtherJSFile('HTMLBuilder.js')<CR>
nnoremap - :call CloseBuffer()<CR>
nnoremap 0 :w<cr>:b /home/kdog3682/CWF/public/class.js<cr>
nnoremap 1 :w<CR>:call Node1()<cr>
nnoremap 2 :w<CR>:call Node2()<CR>
nnoremap 3 /^\"\?\/\* *@bookmark \d\+<SPACE>
nnoremap 3 :wa<CR>:call Node3()<CR>
nnoremap 3 :wa<CR>:call RunJavascriptFile(g:activeNodeFile)<CR>
nnoremap 5 ?\/\*\*  \*\*\/<LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT>
nnoremap 6 :call OpenBuffer3(FileDeterminer(6))<CR>
nnoremap 6 :call ToggleLinkedBufferGroup()<CR>
nnoremap 7 :call OpenBuffer3(FileDeterminer(7))<CR>
nnoremap 7 :call RunOppositeLinkedBuffer()<CR>
nnoremap 7 :w<CR>:call RunGFile()<CR>
nnoremap 7 :w<CR>:call RunGFile()<CR>
nnoremap <buffer> 5 ?\/""
nnoremap <buffer> 5 ?\/\*\*  \*\*\/<LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT>
nnoremap <c-g> :w<CR>:call AnythingHandler('git')<CR>
nnoremap <c-l> :w<CR>:call LogFile()<cr>
nnoremap <c-p> Node('/home/kdog3682/CWF/public/print.js')
nnoremap <c-s> :call SetGFile(CurrentFile())<CR>
nnoremap <f10> :call CycleServerFileCommand()<CR>
nnoremap <f10> :call SetActionKey()<CR>
nnoremap <f10> :w<CR>:call Node10()<cr>
nnoremap <f10> :w<CR>:call RunServerFile('host')<CR>
nnoremap <f1> :w<CR>:call F1Manager()<CR>
nnoremap <f1> :w<CR>:call RunPrevFile()<CR>
nnoremap <f1> :w<CR>:call RunPrevFile()<CR>
nnoremap <f2> :w<CR>:call AddServerFileCommand('')<LEFT><LEFT>
nnoremap <f2> :w<CR>:call RunGFile()<CR>
nnoremap <f2> :w<CR>:call SetGFile('')<LEFT><LEFT>
nnoremap <f3> :w<CR>:call GoGFile()<CR>
nnoremap <f3> :w<CR>:call RunGFile()<CR>
nnoremap <f3> :w<CR>:call RunServerFile('screenshot')<CR>
nnoremap <f4> :w<CR>:call RunServerFile('html')<CR>
nnoremap <f5> :w<CR>:call RunServerFile('print')<CR>
nnoremap <f6> :w<CR>:call RunServerFile('empty')<CR>
nnoremap <f7> :w<CR>:call RunServerFile('cliphtml')<CR>
nnoremap <f7> :w<CR>:call RunServerFile('sleep6')<CR>
nnoremap <f7> :w<CR>:call RunServerFile()<CR>
nnoremap <f8> :call SetComponentKey('')<LEFT><LEFT>
nnoremap <f8> :w<CR>:call RunServerFile('runWindowString')<CR>
nnoremap <f8> :w<CR>:call RunServerFile('runWindowStringNoSleep')<CR>
nnoremap <f9> :call SetPropKey()<CR>
nnoremap <f9> :w<CR>:call RunServerFile('runLocalHost')<CR>
nnoremap <f9> :w<CR>:call RunServerFile('runWindowString')<CR>
nnoremap <leader>ct :call CopyCurrentTemplateToHtmlBuilder()<CR>
nnoremap <leader>e :call WriteNotes4('')<LEFT><LEFT>
nnoremap <leader>f :call FilePicker3()<CR>
nnoremap <leader>g :call BasePY("google ")<LEFT><LEFT>
nnoremap <leader>g :call GetFromMaster("")<LEFT><LEFT>
nnoremap <leader>n :call WriteCodeNotes('')<LEFT><LEFT>
nnoremap <leader>o :call MainOpen()<CR>
nnoremap <leader>o <esc>:call Python2("ofile", CurrentFile())<CR>
nnoremap <leader>p :call PutLineSomewhereElse()<CR>
nnoremap <leader>s :call SaveItem2023()<CR>
nnoremap <leader>t :call ToggleLine()<CR>
nnoremap <leader>v :b ~/.vimrc<CR>
nnoremap <leader>v :w<cr>:e ~/.vimrc<cr>G
nnoremap <leader>v :w<cr>:e ~/.vimrc<cr>Go
nnoremap <leader>x :call InsertAtInsertionPoint(GetCurrentWordOrBinding())<CR>
nnoremap <leader>z :w<cr>:e /home/kdog3682/CWF/public/mc.js<cr>Go
nnoremap <leader>z :w<cr>:e /home/kdog3682/CWF/public/mc.js<cr>Go
nnoremap <silent> P :w<CR>:call PackageManager('nodePrettier')<CR>
nnoremap <silent> db :call DBManager()<cr>
nnoremap <silent> ebc :call OpenBuffer3("/home/kdog3682/2023/baseComponents.js")<CR>
nnoremap <silent> le :call ToLearning()<CR>
nnoremap <silent> lhf :call ListHighFrequencyFiles()<CR>
nnoremap <silent> ltf :call ListTocFiles()<CR>
nnoremap <silent> wg :call WordGo()<CR>
nnoremap <silent> ww :call WordWalk()<CR>
nnoremap <tab> :call GoBookmark2023('')<CR>
nnoremap B :call GoLastTouchedPosition()<CR>
nnoremap R :call SnippetRegistrar()<CR>
nnoremap R <c-r>
nnoremap U :call NBackslash('u')<CR>
nnoremap X :call GoLastTouchedFile()<CR>
nnoremap [ <UP><UP><UP><up><UP><UP><UP><UP>
nnoremap \ :call OpenBuffer3(NBackslash(''))<LEFT><LEFT><LEFT>
nnoremap ] <DOWN><DOWN><DOWN><DOWN><DOWN><DOWN><DOWN><DOWN>
nnoremap a0 :call A0()<CR>
nnoremap a7 :call A8('next.js')<CR>
nnoremap a8 :call A8('utils.js')<CR>
nnoremap a9 :call A8(FileGetter2(''))<LEFT><LEFT><LEFT>
nnoremap ab :call AppendBottomTemplater()<CR>
nnoremap ae :w<CR>:call AddExport()<CR>
nnoremap ag :call Googa()<CR>:update<CR>
nnoremap ai :call AddImport()<CR>
nnoremap apb :call AppendCurrentWordToFileBottom()<CR>
nnoremap ar :call AddArrow()<CR>
nnoremap au :call UnloadSavedWords()<cr>
nnoremap av :call AddWordToJavascriptImports()<CR>
nnoremap aw :call SaveWord()<cr>
nnoremap ax :call AddModuleExportToOtherFile()<CR>
nnoremap ax :call AddSomething()<CR>
nnoremap dd Da<space>
nnoremap dq da'a
nnoremap dq da'i
nnoremap dr :call DeleteArrow()<CR>
nnoremap dt :call Dt()<CR>
nnoremap du :call DeleteAndGo('/home/kdog3682/2023/utils.js')<CR>
nnoremap dx :call DeleteAndGo()<CR>
nnoremap dz :call DZ()<CR>
nnoremap ean :call OpenBuffer3(g:activeNodeFile)<CR>G
nnoremap eba :call OpenBuffer3("/home/kdog3682/2023/base.css")<CR>
nnoremap ebc :call OpenBuffer3("/home/kdog3682/2023/base-components.js")<CR>
nnoremap ed3 :call OpenBuffer3("/home/kdog3682/2023/pl-d3Builder.js")<CR>
nnoremap eft :call OpenBuffer3("/home/kdog3682/2023/files.txt")<CR>
nnoremap eft :call OpenBuffer3('/home/kdog3682/2023/files.txt')<CR>G
nnoremap eft :call OpenBuffer3(g:ftfile)<CR>
nnoremap ega :call OpenBuffer3("/home/kdog3682/2023/googleAppConnector.js")<CR>
nnoremap egi :call OpenBuffer3("/home/kdog3682/2023/.gitignore")<CR>
nnoremap ehf :call OpenBuffer3(g:helpmdfile)<cr>g
nnoremap eii :call OpenBuffer3("/home/kdog3682/2023/index.html")<CR>
nnoremap ein :call OpenBuffer3("/home/kdog3682/2023/index.html")<CR>
nnoremap el :call EvalLastLine()<CR>
nnoremap em2 :call OpenBuffer3("/home/kdog3682/2023/math.txt")<CR>
nnoremap eme :call OpenBuffer3("/home/kdog3682/2023/me.txt")<CR>
nnoremap emg :call OpenBuffer3("/home/kdog3682/2023/mathgen.js")<CR>
nnoremap emk :call EMark()<CR>
nnoremap emr :call OpenBuffer3("/home/kdog3682/2023/math-review.txt")<CR>
nnoremap emu :call OpenBuffer3("/home/kdog3682/2023/ma.js")<CR>
nnoremap emu :call OpenBuffer3("/home/kdog3682/2023/math-utils.js")<CR>
nnoremap emv :call OpenBuffer3("/home/kdog3682/2023/my-files.json")<CR>G
nnoremap eng :call OpenBuffer3("/home/kdog3682/PYTHON/githubscript.py")<CR>G
nnoremap enn :call OpenBuffer3("/home/kdog3682/2023/notes.txt")<CR>
nnoremap enp :call OpenBuffer3('/home/kdog3682/PYTHON/next.py')<CR>G
nnoremap enu :call OpenBuffer3("/home/kdog3682/2023/node-utils.js")<CR>
nnoremap env :call OpenBuffer3("/home/kdog3682/PYTHON/env.py")<CR>G
nnoremap enx :call OpenBuffer3("/home/kdog3682/2023/next.js")<CR>
nnoremap epa :call OpenBuffer3("/home/kdog3682/PYTHON/pac.txt")<CR>
nnoremap epj :call OpenBuffer3("/home/kdog3682/2023/package.json")<CR>
nnoremap eps :call OpenBuffer3("/home/kdog3682/2023/Puppeteer.js")<CR>
nnoremap eps :call OpenBuffer3("/home/kdog3682/2023/Puppeteer.js")<CR>
nnoremap esj :call OpenBuffer3("/home/kdog3682/2023/server.js")<CR>
nnoremap esk :call OpenBuffer3("/home/kdog3682/2023/splitKatex.js")<CR>
nnoremap ess :call OpenBuffer3("/home/kdog3682/2023/TEXTS/scratchpad.txt")<CR>
nnoremap ess :call OpenBuffer3("/home/kdog3682/2023/scratchpad.js")<CR>
nnoremap est :call OpenBuffer3("/home/kdog3682/2023/Stylesheet.js")<CR>
nnoremap est :call OpenBuffer3("/home/kdog3682/RESOURCES/saved.txt")<CR>G
nnoremap etc :call OpenBuffer3('temp.css')<cr>
nnoremap ete :call OpenBuffer3("/home/kdog3682/2023/textEdit.js")<CR>
nnoremap ett :call OpenBuffer3(g:tempmdfile)<CR>:call append('.', DateStamp())<CR>GA<space>
nnoremap eu :call OpenBuffer3("/home/kdog3682/2023/utils.js")<CR>
nnoremap ewc :call OpenBuffer3("/home/kdog3682/2023/worksheet-components.js")<CR>
nnoremap ex :call Fooga()<CR>
nnoremap g0 :call OpenBuffer3('logging.txt')<cr>
nnoremap g1 :call OpenBuffer3(g:activeNodeFile1)<cr>
nnoremap g2 :call OpenBuffer3(g:activeNodeFile2)<cr>
nnoremap g3 :call OpenBuffer3(g:activeNodeFile3)<cr>
nnoremap g4 :call OpenBuffer3(g:activeNodeFile4)<cr>
nnoremap g5 :call OpenBuffer3(g:activeNodeFile5)<cr>
nnoremap g6 :call OpenBuffer3(g:activeNodeFile6)<cr>
nnoremap ga :call OpenBuffer3(g:activeNodeFile)<cr>
nnoremap gb Go<CR><CR>
nnoremap gd :call OpenBuffer3('git-data3.json')<cr>G
nnoremap ge :call OpenBuffer3('examples.js')<cr>
nnoremap ghb :call OpenBuffer3('/home/kdog3682/2023/pl-htmlBuilder.js')<cr>
nnoremap gi :call GiManager()<CR>
nnoremap gl :call GoLastTouchedFile()<cr>
nnoremap gl :call GoToBookmarkedLine()<CR>
nnoremap gn /^fun<CR><DOWN><DOWN>
nnoremap gp :call AddPConfItem()<CR>
nnoremap gp :call GitPushLine()<CR>
nnoremap grp :call OpenBuffer3('rp.js')<CR>
nnoremap gs :call OpenBuffer3('saved.txt')<CR>
nnoremap gs :call OpenBuffer3(g:activeNodeFile)<cr>
nnoremap gs :call OpenBuffer3(g:secondActiveFile)<cr>
nnoremap gt go<CR><CR>
nnoremap gu ?^\(fun\\|def\)<CR>O
nnoremap gu ?^fun<CR><UP><UP>
nnoremap gw :call GoWordUnderCursor()<CR>
nnoremap gx :call GoExample()<CR>
nnoremap la :call ListCurrentDirectory()<CR>
nnoremap lc :call ConsoleToClip()<CR>
nnoremap ld ?_________________<CR>
nnoremap lg <UP><CR>:call LogIt('lg')<CR>
nnoremap lj :call LogIt('lj')<CR>
nnoremap ln :call SeeActiveNodeFiles()<CR>
nnoremap lt :call NormalLogThrow()<CR>
nnoremap lx :call Unlog()<CR>
nnoremap lz :call GetSetFn('GSLogThrow')<CR>
nnoremap lz :call ReplaceBackAndForth()<CR>
nnoremap mk :call Markline()<CR>
nnoremap ml :call BookmarkLine()<CR>
nnoremap mu :call BookmarkLine('u')<CR>
nnoremap mv :call ViewMarkedLines()<CR>
nnoremap q :ec SayHi()<CR>
nnoremap q0x :call BaseJS('')<LEFT><LEFT>
nnoremap q[ diwi${}<LEFT>
nnoremap qgp :call QGNormal()<CR>
nnoremap qp :call PythonController('sayhi')<CR>
nnoremap qp :call Qp()<CR>
nnoremap qs :call QString()<CR>
nnoremap qx :call Qx()<CR><a>
nnoremap qx ci'
nnoremap ra :call RunAction()<CR>
nnoremap ra :wa<CR>:call RunAlternate()<CR>
nnoremap reg :call Registration('')<left><left>
nnoremap t2 :call OpenBuffer3('today2.js')<CR>
nnoremap tc :wa<CR>:call BasePY(':incorporateCss')<CR>
nnoremap td :call Td()<CR>
nnoremap tf :call TouchFileToChangeLog()<CR>
nnoremap ti :call Titleify()<CR>
nnoremap tl :call LogIt('tl')<CR>
nnoremap tl :call LogIt2('tl')<CR>
nnoremap tp :call TestPrint2()<CR>
nnoremap ts :call CreateTestStringWithCurrentFunction()<CR>
nnoremap tu :call OpenBuffer3('utils.js')<cr>Go<CR>
nnoremap tv :call AppendBottomTemplater()<CR>
nnoremap tx :call TestTheCurrentFunction()<CR>
nnoremap ty :call Ty()<CR>
nnoremap wg :call GoSomewhere()<CR>
nnoremap z, diwi<<>><ESC><LEFT><LEFT>p
nnoremap z; :call JSGoogleConnector('')<LEFT><LEFT>
nnoremap zn ?^\("\\|//\\|#\) \{-\}\d\d-<CR>
nnoremap zo :call BaseJS('op')<CR>
nnoremap zp :call BaseJS('pr')<CR>
nnoremap zrn :call Zrn()<CR>
nnoremap zx :call ChangeDir('/home/kdog3682/2023')<CR>
noremap <leader>b ?\<\><left><LEFT>
nunmap q
set history=20

