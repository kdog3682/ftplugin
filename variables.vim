let g:codenotefile = 'code.notes.txt'
let g:notesfile = 'notes.txt'
let g:jsdir = '/home/kdog3682/CWF/public/'
let g:budir = '/mnt/chromeos/GoogleDrive/MyDrive/BACKUP/'
let g:htmldir = '/home/kdog3682/CWF/public/'
let g:cssdir = '/home/kdog3682/CWF/public/'
let g:pydir = "/home/kdog3682/PYTHON/"
let g:mathdir = "/home/kdog3682/MATH/"
let g:pdfdir = '/home/kdog3682/PDFS/'
let g:txtdir = '/home/kdog3682/TEXTS/'
let g:jsondir = '/home/kdog3682/JSONS/'
let g:logdir = '/home/kdog3682/LOGS/'

let g:dirdict2 = {}
let g:dirdict2['js'] = g:jsdir
let g:dirdict2['math'] = g:mathdir
let g:dirdict2['html'] = g:htmldir
let g:dirdict2['css'] = g:cssdir
let g:dirdict2['py'] = g:pydir
let g:dirdict2['pdf'] = g:pdfdir
let g:dirdict2['txt'] = g:txtdir
let g:dirdict2['json'] = g:jsondir
let g:dirdict2['log'] = g:logdir

let g:rootdir = "/home/kdog3682/"
let g:dldir = "/mnt/chromeos/MyFiles/Downloads/"


let g:iabdict = {
    \'90': '()',
    \'89': '()',
    \'ss': 'const items = split(s, " ")',
\}

let g:txtdict = {}
let g:wpsnippets = {}
let g:wpsnippets['py'] = {}
let g:mastersnippets = {
    \'vim': {},
    \'js': {},
    \'py': {},
    \'html': {},
    \'css': {},
\}

let g:solsnippets = {
    \'vim': {},
    \'js': {},
    \'py': {},
    \'html': {},
    \'css': {},
\}





let g:exprdict = {'js': {}, 'py':{}, 'html': {}, 'vim': {}, 'global': {}}
let g:SOLTabDictionary = {}
let g:pythonconnectordict = {}
let g:markdict = {}
let g:pythonsnippets = {}
let g:normaldict = {}
let g:ldrdict = {}
let g:setdict = {}
let g:autotabdict = {}
let g:qsnippetdict = {}
let g:autodict = {}
let g:globalwpdict = {}
let g:qqdict = {}
let g:bookmarkdict2 = {}
let g:gtfgtfdict = {}
let g:autotabdict['vim'] = {}
let g:autotabdict['js'] = {}
let g:autotabdict['py'] = {}
let g:qsnippetdict['py'] = {}
let g:qsnippetdict['js'] = {}
let g:qsnippetdict['global'] = {}
let g:filedict = {}
let g:snippetCompletionStartDict = {}
let g:snippetFunctionalInsertion = {}
let g:currentiabdict = {}
let g:previabdict = {}
let g:indexesdict = {}
let g:dirdict = {}
let g:globalconfig = {}
let g:activetempbinding = {}
let g:fnlib = {}
let g:ldrdict2 = {}
let g:visualdict = {}
let g:movementdict = {}

let g:vimsnippets = {
        \'pcfcall': "def __call__(self, $2):\n    ",
        \'pcfiter': "def __iter__(self, $2):\n    ",
        \'pcfadd':  "def __add__(self, $2):\n    ",
        \'pcfclass':  "def $1(self, $2):\n    ",
        \'pcffn':  "def $1($2):\n    ",
\}

let vueco = "var ${Capitalize($1)} = {\n    name: '${Capitalize($1)}',\n    props: ['value'],\n    template: `\n    <div>\n        $c\n    </div>`,\n    data() {\n        return {\n            \n        }\n    },\n}"
let vuec = "const $1 = {\n    props: [],\n    template: `\n        <div>\n        $c\n        </div>\n    `,\n    data() {\n        return {\n            \n        }\n    },\n}"

let g:jsbe = " {\n    $c\n}"




let g:vimcallableRE = '\C[A-Z]\w*\ze\(|''\zs[A-Z]\w+\ze'''
let g:jscallableRE = '[\=\(, ]\zs\w+\ze\('
let g:pycallableRE = '(\w+ \= )?[a-zA-Z\.]+\ze\('



let g:bookmarktracker = 'a'





let g:pydict = {
\  "vhtml": "<script src=\"vue.js\"></script>\n<link rel=\"stylesheet\" href=\"styles.css\"/>\n<script src=\"script.js\"></script> \n\n<body>\n    <div id=\"app\"></div>\n</body>\n",
 \   'cls': "class ${Capitalize($1)}:\n    def __init__(self${AddParams($2)}$c):",
 \   'enter': "def __enter__(self):\n    return self\ndef __exit__(self, error, *args):\n    $c",
    \ 'dict': "${ToDict($0)}",
    \ 'arr': "${ToArray($0)}",
    \ 'qq': "question: '$c',",
    \ 'init': "def __init__($1):\n    $c,",
    \ "qa": '{\n    question: "$c",\n    answer: "",\n},',
    \ 'script': "<script>$c</script>",
    \ 'jshint': "const JSHINT = require('./jshint.js')",
    \ 'prom': "return new Promise((resolve) => {\n    $c\n})",
    \ 'u': "${UseHelper($1)}",
    \ 'use': "${UseHelper($1)}",
    \ 'vuediv': "<div id=\"app\">\n    $c\n</div>",
    \ 'katex': '<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/katex@0.13.11/dist/katex.min.css" integrity="sha384-Um5gpz1odJg5Z4HAmzPtgZKdTBHZdw8S29IecapCSB31ligYPhHQZMIlWLYQGVoc" crossorigin="anonymous"><script src="https://cdn.jsdelivr.net/npm/katex@0.13.11/dist/katex.min.js" integrity="sha384-YNHdsYkH6gMx9y3mRkmcJ2mFUjTd0qNQQvY9VYZgQd7DcN7env35GzlmFaZ23JGp" crossorigin="anonymous"></script>',
    \ 'kf': "${KeyFramer($0)}",
    \ 'computed': "computed: {\n    computed${Capitalize($1)}() {\n        $c\n    },\n},",
    \ 'writer': "from storage import write\nwrite('temp.txt', $1)",
    "\ 'vmo': "mounted() {\n    $c\n}",
    \ 'vuen': "const ${Capitalize($1)}Component = {\n    props: ['value'],\n    template: `$c`,\n        \n    data() {\n        return {\n            message: 'hi',\n        }\n    },\n\n}",
    \'fetch': "const fetch = require('node-fetch')",
    \ 'vuer': "const ${Capitalize($1)}Component = {\n    props: ['value'],\n    render(h) {\n        $c\n    },\n\n}",
    \ 'vueno': "Vue.component('$1', { template: '<div class=\"$1\">$1</div>' })",
    \ 'vuenoxxx': "Vue.component('$1', {\n    props: ['value'],\n    template: `<div class=\"$1\">$1</div>$c`,\n        \n    data() {\n        return {\n            message: 'hi',\n        }\n    },\n})",
    \ 'vfor': "<div class=\"abc\" v-for=\"${Slice($1)} in $1\">\n    $c\n</div>",
    \ 'rpw': "def parser(data):\n    $c\n\nrpwo('$1', parser)",
    \ 'dir':    "directives: [\n    {\n        name: $c\n        value: \n    },\n],",
    \ 'center': "display: flex; align-items: center; justify-content: center;$c",
    \ 'b': "border: 0.5px solid blue;$c",
    \ 'wh100': "width: 100%; height: 100%;$c",
    \
    \
    \
\    'a'  : "const $1 = [\n    $c\n]",
\    'd'  : "const $1 = {\n    $c\n}",
\    'vp'  : "Vue.prototype.$$1 = function($2) {\n    $c\n}",
 \   'rpwo': "rpwo('$1', (s) => {\n    $c\n})",
 \   'switch': "switch ($1) {\n    $c\n}",
 \   'vprop': "props: ${ArrayExpand($0)},",
 \   'wae': "window.addEventListener('keydown', $1)",
 \   'vmo': "mounted() {\n    $c\n},",
 \   'vm': "methods: {\n    $c\n},",
 \   'st': "setTimeout(() => {\n    $c\n}, $0)",
 \   'si': "intervalID = setInterval(() => {\n    $c\n}, $0)",
 \   'vt': "template: `\n    $c\n`,",
 \   'vd': "data() {\n    return {\n        $c\n    }\n},",
 \   'data': "function data() {\n    return {\n        $c\n    }\n}",
 \   'rc': "Vue.component('$1', {\n    render(h) {,\n        $c\n    }\n})",
 \   'cc': "Vue.component('$1', {\n    render(h) {\n    $c\n    }\n})",
 \   'cidfgdc':  "Vue.component('$1', {\n    data() {\n        return {\n            $c\n        }\n    },\n    methods: {\n\n    },\n    computed: {\n\n    },\n    watch: {\n\n    },\n    mounted() {\n\n    },\n    render(h) {\n\n    }\n}",
 \   'vc':  "const $1 = {\n    template: ${tolower($1)}template,\n    data() {\n        return {\n            $c\n        }\n    },\n    methods: {\n\n    },\n    computed: {\n\n    },\n    mounted() {\n\n    },\n}",
 \'fpdf': "from FPDF import fpdf\nfpdf.add_page()\nfpdf.add_font('symbola', '', '/home/kdog3682/CWF/Symbola.ttf', uni=True)\nfpdf.set_font('symbola', '', 11)",
 \   'forij': "for (let i = 0; i < $1; i++) {\n    for (let j = 0; j < placeholder; j++) {\n        $c\n    }\n}",
 \   'forenum': "for (let i = 0; i < $1.length; i++) {\n    let ${Slice($1, 1)} = $1[i]\n    $c\n    if (i == $1.length - 1) {\n        \n    }\n}",
 \   'wh': "let i = 0\nwhile (i < $1.length) {\n    let item = $1[i]\n    $c\n   }\n",
 \   'fore': "for (let i = 0; i < $1.length; i++) {\n    const ${$1[:-2]} = $1[i]\n    $c\n    if (i == $1.length - 1) {\n        \n    }\n}",
 \   'forer': "for (let i = $1.length - 1; i >= 0; i--) {\n    let ${$1[:-2]} = $1[i]\n    $c\n    if (i == 0) {\n        \n    }\n}",
 \   'forij1': "for (let i = 1; i < $1; i++) {\n    for (let j = 1; j < $100; j++) {\n        $c\n    }\n}",
 \   'fori1': "for (let i = 1; i <= $1; i++) {\n    $c\n}",
 \   'fori': "for (let i = 0; i < $1; i++) {\n    $c\n}",
 \   'forj': "for (let j = 0; j < $1; j++) {\n    $c\n}",
 \   'scrip': "<script src=\"$1\"></script>",
 \   'link': "<link href=\"$1\"/>",
 \   'for2': "for (let i = 0; i + 1 < $1; i += 2) {\n    $c\n}",
 \   'forkv': "for (const [k, v] of Object.entries($1)) {\n    $c\n}",
 \   'forab': "for (const [a, b] of $1) {\n    $c\n}",
 \   'fork': "for (let key of Object.keys($1)) {\n    $c\n}",
 \   'forkeys': "for (let key of Object.keys($1)) {\n    $c\n}",
 \   'forvals': "for (let key of Object.keys($1)) {\n    $c\n}",
 \   'forv': "for (const key of Object.keys($1)) {\n    $c\n}",
 \   'for': "for (const ${GetForIterationVariable($1)} of $1) {\n    $c\n}",
 \   'if':  "if ($0) {\n    $c\n}",
 \   'ef':  "else if ($0) {\n    $c\n}",
 \   'ife': "if (exists($0)) {\n    $c\n}",
 \   'ifn': "if (!$0) {\n    $c\n}",
 \   'ift': "if (test($1, $2)) {\n    $c\n}",
 \   'iff': "if (isFunction($1)) {\n    $c\n}",
 \   'ifa': "if (isArray($1)) {\n    $c\n}",
 \   'ifalg1': "if (args.length > 1) {\n    $c\n}",
 \   'ifal1': "if (arguments.length == 1) {\n    $c\n}",
 \   'ifal2': "if (arguments.length == 2) {\n    $c\n}",
 \   'ifal3': "if (arguments.length == 3) {\n    $c\n}",
 \   'ifal4': "if (arguments.length == 4) {\n    $c\n}",
 \   'ifo': "if (isObject($1)) {\n    $c\n}",
 \   'ifodd': "if (isOdd($1)) {\n    $c\n}",
 \   'ifeven': "if (isEven($1)) {\n    $c\n}",
 \   'ifs': "if (isString($1)) {\n    $c\n}",
 \   'ifnum': "if (isNumber($1)) {\n    $c\n}",
 \   'efn': "else if (!($0) {\n    $c\n}",
 \   'eft': "else if (test($2, $1)) {\n    $c\n}",
 \   'eff': "else if (isFunction($1)) {\n    $c\n}",
 \   'efa': "else if (isArray($1)) {\n    $c\n}",
 \   'efo': "else if (isObject($1)) {\n    $c\n}",
 \   'efs': "else if (isString($1)) {\n    $c\n}",
 \   'efnum': "else if (isNumber($1)) {\n    $c\n}",
 \   'class': "class ${Capitalize($1)} {\n    constructor($c) {\n    }\n\n}",
 \   'rep': "let p = s.replace($0, (x) => {\n    $c\n})",
\ }
    let g:jsdict = {
    \   "div":  {'template': "<div>$c</div>"       , 'cursor': 'smart', 'suffix': ''},
    \   "vt":  {'template': "template: `\n    \n`,"       , 'suffix': ''},
    \   "vd":  {'template': "data() {\n    return {\n        %c\n    }\n},"       , 'suffix': ''},
    \   "vm":  {'template': "methods: {\n    \n},"        , 'suffix': ''},
    \   "vc":  {'template': "computed: {\n    \n},"       , 'suffix': ''},
    \   "props":  {'snippet': "props: $0,", 'functions': 'ArrayExpand', 'noappend': 1},
    \   "else":  "else {",
    \   "m":  "method $0($1) {",
    \   "border":  "border: 0.5px solid red;",
    \   "st":  {'snippet': "setTimeout(() => {\n    %c\n}, $0)"},
    \   "vp":  "Vue.prototype.$$0 = function($1) {",
    \   "lbr":  "$$JSPY('comment')$$ --------------------------",
    \   "len":  "print('length of $0:', len($0))",
    \   "forkjiii":  "",
    \   "forkijiii":  "",
    \   "fork":  "for (let key of Object.keys($0) {",
    \   "forv":  "for (let value of Object.values($0) {",
    \   "forkv":  "for (let [k, v] of Object.entries($0)) {",
    \   "fori":   "for (let i = 0; i < $0; i++) {", 
    \   "for":   [1, "for (let $a of $0) {", {s -> s[:-2]}],
    \   "ef":     "else if ($0) {",
    \   "efs":    "else if (isString($0)) {",
    \   "efo":    "else if (isObject($0)) {",
    \   "efa":    "else if (isArray($0)) {",
    \   "efn":    "else if (!$0) {",
    \   "c":  "class $0 {\n    constructor($1) {\n    }", 
    \   "class":  {
            \ 'snippet': "class $0 {\n    constructor($1) {\n    }", 
            \ 'functions': ['Capitalize', 'Identity'],
    \},  
    \   "if":     "if ($0) {",
    \   "ifs":    "if (isString($0)) {",
    \   "ifp":    "if (isPrimitive($0)) {",
    \   "ifo":    "if (isObject($0)) {",
    \   "ifa":    "if (isArray($0)) {",
    \   "ifn":    "if (!$0) {",
    \   "ift":    "if (test($0)) {",
    \   "eft":    "else if (test($0)) {",
    \   "while": "while {\n}",
    \   "try": "try {\n}\ncatch(e) {",
    \   "dict": "const dict = {", 
    \   "obj": "const obj = {", 
    \   "arr": "const arr = [", 
    \   "items": "const items = [", 
\ }
let g:htmldict = {
\    'div': 'div',
\    'section': 'section',
\}

   let g:ldrdict = {
      "\    'cp': 'CopyToRoot',
      "\    'sp': 'ShuntToPreviousBufferAndSwitchOver',
      "\    'fa': 'FileActionScript',
      "\    'gtnf': 'GoToNearbyFile',
      "\    'atfd': 'AddToFileDict',
      "\    'olh': 'OpenLocalHost',
      "\    'otf': 'OpenTempFiles',
      "\    'so': 'OpenSmartFile',
      "\    'sf': 'SetOpenFileMode',
      "\    'ocb': 'OpenChromeBrowser',
      "\    'dlm': 'DeleteLinesManually',
      "\    'help': 'Help',
      "\    'done': 'PrintActiveBuffers',
      "\    'pab': 'PrintActiveBuffers',
      "\    'rlf': 'ReadLastFile',
      "\    'atj': 'AddToKnownJSON',
      "\    'sfs': 'SpecificFunctionShunter',
      "\    'sctb': 'ShuntCallsToBottom',
      "\    'siab': 'SetLocalIAB',
      "\    'si': 'SetLocalIAB',
      "\    'xdg': 'XdgOpen',
      "\    'get': 'GetFunctionsAndPrependToCurrentFile',
      "\    'af': 'AddFileToFileDict',
      "\    'sff': 'SaveFunctionToList',
      "\    'sf': 'SaveFileToList',
      "\    'save': 'SaveToDrive',
      "\    'r': 'ReadFile',
      "\    'stf': 'SmartTextFix',
      "\    'pug': 'Pugify',
      "\    'latest': 'Latest',
      "\    'look': 'LookForFiles',
      "\    '/': 'CssSearch',
      "\    'sgv': 'SetGlobalVariable',
      "\    'sm': 'SetMarks',
      "\    'glob': 'GlobIt',
      "\    'p': 'PrintReadFile',
      "\    'at': 'AddToken',
      "\    'b': 'BrowseFiles',
      "\    'vd': 'AppendToVueData',
      "\    'm': 'AppendToVueMethods',
      "\    'vs': 'AddToVSDict',
      "\    'ssc': 'SetSearchContext',
       "\    'ldr': 'AddToLdrDict',n
       "\    'mv': 'MoveText',
       "\    'tgl': 'ToggleLibraries',
       "\    'ocf': 'OpenCurrentFiles',
       "\    'cae': 'CloseAllExcept',
       "\    'npm': 'OpenNpmFile',
       "\    'aaaaaa': 'aaaa',
       "\    'isf': 'IsFile',
       "\    'ljs': 'LibraryLoader',
       "\    'nc': 'CreateNormalCommand',
       "\    'eat': 'IabEat',n
       "\    'ss': 'StyleShunt',
       "\    'set': 'Setter',
       "\    'f6': 'F6ify',
       "\    'bm': 'VimChromeBookmarks',
       "\    'root': 'BringToRoot',
       "\    'g': 'SetModeToGrab',
       "\    'o': 'OpenLocalFile',
       "\    'open': 'OpenLocalFile',
       "\    'cd': 'ChangeDir',n
       "\    'pretty': 'Prettier',
       "\    'msc': 'AppendMyShortCuts',
       "\    'load': 'LoadLibrary',
       "\    'edit': 'EditDict',
       "\    'df': 'DeleteFile',
       "\    'find': 'GrepFinder',
       "\    'findtext': 'GrepTextFinder',
       "\    'cb': 'CloseBuffersByQuery',
       "\    'sb': 'SetCurrentFileAsShuntDestination',
       "\    'rev': 'RevertBufferGroup',
       "\    'rb': 'RevertBufferGroup',
       "\    'ob': 'OpenBufferGroup',
       "\    'dd': 'DedentAll',
       "\    'iab': 'CreateIab',n
       "\    'make': 'MakeHtml',
       "\    'cf': 'CreateFileFromLine',
       "\    'run':    {arg -> ExecuteFile('self', arg)},
       "\    'print':  {arg -> ExecuteFile('printscript.py', arg)},
       "\    'email':  {arg -> ExecuteFile('emailscript.py', arg)},
       "\    'reddit': {    -> ExecuteFile('redditscript.py')},
       "\    'zipeverything': {    -> ExecuteFile('zipscript.py')},
       "\    'reply':  {    -> ExecuteFile('redditscript.py', 'reply')},
       "\    'ac':     {arg -> ExecuteFile('actionscript.py', arg)},
       "\    'dl':     {arg -> ExecuteFile('scrapescript.py', arg)},
       "\    'create': {    -> ExecuteFile('createproject.py', arg)},
       "\    'github': {arg  -> ExecuteFile('githubscript.py', arg)},
       "\    'pretty': {  -> ExecuteFile('prettyscript.js')},
       "\    'scrape': {  -> ExecuteFile('scrapescript.py')},
       "\    'cleanup': {  -> ExecuteFile('cleanupscript.py')},
\ }

let g:replacecdict = {
        "\    'vs-start': 'booga',
        "\    'create': {'fn': 'CreateSnippetFromSelection', 'i': 'boop'},
        "\    'fix': {'fn': 'FixTheLineViaTemplate', 'i': 'code'},
        "\    'cns': {'fn': 'CnsBuildConstructorVariables', 'i': 'code'},
        "\    'aed': {'fn': 'AddErrorDebugForTheThing', 'i': 'code'},
        "\    'ws': {'fn': 'ToWorkspace', 'i': 'code'},
        "\    'print': {'fn': 'PrintToScreen', 'i': 'code'},
        "\    'archive': {'fn': 'ArchiveContents', 'i': 'code'},
        "\    ']': {'fn': 'VisualSelect', 'i': 'code'},
        "\    'bc': {'fn': 'BlockComment', 'i': 'contiguous'},
        "\    'test': {'fn': 'ToTestTextFile', 'i': 'contiguous'},
        "\    'o': {'fn': 'VisualSelect', 'i': 'smartobject'},
        "\    'f': {'fn': 'FunctionizeBlock', 'i': 'contiguous'},
        "\    'rac': {'fn': 'RemoveAllComments', 'i': 'code'},
        "\    't2': {'fn': 'Trial2', 'i': 'contiguous'},
        "\    'dq': {'replacer': ['''', '"', 'g'], 'i': 'code'},
        "\    'bug': {'fn': 'DebugBlock', 'i': 'code'},
        "\    'cul': {'fn': 'CopyUpLine', 'i': 'code'},
        "\    'function': {'fn': 'Functionize', 'i': 'block'},
        "\    'tc': {'fn': 'TryCatcher', 'i': 'trycatchindex'},
        "\    'tdc': {'fn': 'TryCatcher', 'i': 'block'},
        "\    'pyfix': {'fn': 'PyFix', 'i': 'nolinebreak'},
        "\    'zzzzzzzzz': {'fn': 'TryCatcher', 'i': 'nolinebreak'},
        "\    'dsb': {'fn': [0, 'DeleteLine'], 'i': 'nolinebreak'},
        "\    'dp': {'fn': 'ReshapeParameter', 'i': 'line'},
        "\    'rc': {'fn': ['IsComment', 'DeleteLine'], 'i': 'code'},
        "\    'iab': {'fn': 'CreateVisualIab', 'i': 'line', 'args': 1},
        "\    'q': {'fn': 'VisualQuotify', 'i': 'block', 'args': 1},
        "\    's': {'fn': 'StringSurround', 'i': ''},
        "\    'b': {'fn': 'Blockify', 'i': 'block'},
        "\    'g': {'fn': 'GetBlock2', 'i': 'defined'},
        "\    '': {'fn': 'VisualSelect', 'i': 'contiguous'},
        "\    'trial': {'gs': 'Trialify', 'i': 'contiguous'},
        "\    'vs': {'fn': 'SetVisualSelection', 'i': 'smartcontiguous'},
        "\    'az': {'gs': 'ReplaceArgsZero', 'i': 'line', 'spaces': 1},
        "\    'ditto': {'fn': 'LineDitto', 'i': 'null'},
\ }
let g:urldict = {
    \ 'reddit': 'https://reddit.com',
    \ 'lh': 'https://localhost:3000',
    \ 'r': 'https://reddit.com',
    \ 'fb': 'https://facebook.com',
    \ 'sof': {s -> 'https://google.com/search?= -site:stackoverflow.com ' . s},
\}



let g:importdict = {
    \"contextmanager": "from contextlib import contextmanager",
    \"pprint": "from pprint import pprint",
    \"re": "import regex as re",
    \"urllib": "import urllib.request",
    \"math": "import math",
    \"webbrowser": "import webbrowser",
    \"requests": "import requests",
    \"traceback": "import traceback",
    \"StringIO": "from io import StringIO",
    \"FPDF": "from fpdf import FPDF",
    \"fbchat": "import fbchat",
    \"sys": "import sys",
    \"praw": "import praw",
    \"subprocess": "import subprocess",
    \"shutil": "import shutil",
    \"socket": "import socket",
    \"inspect": "import inspect",
    \"datetime": "import datetime",
    \"time": "import time",
    \"json": "import json",
    \"os": "import os",
    \"random": "import random",
    \"unicodedata": "import unicodedata",
\ }
    "ldrm
    let g:commentre = '^(#|//|") ?'
let g:z = {
\}
let g:lastworddict = {
  \  'arr': "$0 => {\n    $c\n})",
  \  'lx': "$0 (x) => {\n    $c\n})",
  \  'op': "$0() {\n    $c\n}",
  \  'hc': "$0<!-- $c -->",
  \  'kv': "$0(k, v) => {\n    $c\n    })", 
  \  'redkv': "$0reduce((acc, [k,v], i) => {\n    $c\n    return acc\n}, {})", 
  \  'mapab': "$0map(([a,b], i) => {\n    $c\n})", 
  \  'redabo': "$0reduce((acc, [a,b], i) => {\n    $c\n    return acc\n}, {})", 
  \  'redabddo': "$0reduce((acc, [a,b], i) => {\n    $c\n    return acc\n}, {})",
  \  'redo': "$0reduce((acc, ${$1[:-2]}, i) => {\n    $c\n    return acc\n}, {})",
  \  'red': "$0reduce((acc, item) => {\n    $c\n    return acc\n}, {})",
  \  'map': "$0map((item) => {\n    $c\n})",
  \  'div': "$0<div class=\"\">$c</div>", 
  \  'p': "$0<p class=\"\">$c</p>", 
  \  'button': "$0<button @click=\"\">$c</button>", 
  \  'filter': "$0filter((acc, item) => {\n    $c\n})",
  \  'fe': "$0forEach((item, i) => {\n    $c\n})",
  \  'reds': "$0reduce((acc, ${$1[:-2]}, i) => {\n    $c\n    return acc\n}, '')",
  \  'redst': "$0reduce((acc, item, i) => {\n    $c\n    return acc\n}, new SimpleStorage())",
  \  ':'     : "$0 {\n    $c\n},",
  \  ','     : "$0() {\n    $c\n},",
  \  ',.'     : "$0 {\n    $c\n},",
  \  'default'     : "$0 {\n    $c\n}",
  \  'ls'     : "$0 (s) => {\n    $c\n})",
  \  'lkv'     : "$0 (k, v) => {\n    $c\n})",
\ }
    "call GetSet(a:i, {s -> Replace(s, regex, replacement)})
    let g:fdict = {
        \ 'search': 'match',
        \ 'findall': 'matches',
        \ 'mreplace': '[text, store]',
    \}
let g:qdict = {
    \ 'c': '    constructor\(',
    \ 'r': '    run\(',
    \ 'vl': 'class vuelines',
    \ 'le': 'class LineEdit',
    \ 'rsdf': '    run\(',
    \ 'cii': '    constructor\(',
\}
let g:vuedict = {
    \ 'methodRE': 'methods\: \{',
    \ 'dataRE': 'const vueData \= \{',
\}


let g:snippetdict = {
    \ 'bar': 'baz',
    \ 'eater': "<left><Left><C-R>=Eatchar('\s')<CR>",
\}
let g:pyactualpydict = {
 \   'ifn': "if not $0:\n    $c",
 \   'ift': "if test($2, $1):\n    $c",
 \   'ifo': "if isObject($1):\n    $c",
 \   'ifs': "if isString($1):\n    $c",
 \   'ifa': "if isArray($1):\n    $c",
 \   'iff': "if isFunction($1):\n    $c",
 \   'cls': "class ${Capitalize($1)}:\n    def __init__(self${AddParams($2)}$c):",
 \   'enter': "def __enter__(self):\n    return self\ndef __exit__(self, error, *args):\n    $c",
\ }


let g:websitedict = {
    \'fb': 'facebook.com',
    \'r': 'reddit.com',
    \'g': 'google.com',
\}
    let g:jspydict = {
        \ 'bash': {
            \ 'function': '',
            \ 'log': 'echo  ',
            \ 'p1': '',
            \ 'comment': '#',
            \ 'p2': ' {',
            \ 'suffix': ' }',
        \ },
        \ 'js': {
            \ 'consoleX': 'console',
            \ 'log': 'console.log()',
            \ 'consoleThrow': 'consoleThrow(',
            \ 'clbr': 'console.log("*******************************************")', 
            \ 'lbr': '/****************************************************/', 
            \ 'expand': 'javascript', 
            \ 'callableRE': g:jscallableRE,
            \ 'libfile': 'javascript.lib', 
            \ 'sdelimiter': '`', 
            \ 'classMethodRE': '^    ', 
            \ 'let': 'let', 
            \ 'else': 'else {', 
            \ 'stry': 'try {', 
            \ 'scatch': ['}', 'catch(e) {', '    ', '}'],
            \ 'try': ['try {', '    ', '}', 'catch(e) {', '    ', '}'],
            \ 'ift': ['if (', ') {'],
            \ 'eft': ['else if (', ') {'],
            \ 'if': ['if (', ') {'],
            \ 'ef': ['else if (', ') {'],
            \ 'o': 'isObject',
            \ 'classparam': '',
            \ 'classp1': '',
            \ 'a': 'isArray',
            \ 'n': 'isNumber',
            \ 's': 'isString',
            \ 'testfunc': 'test',
            \ 'commentPrefix': '//',
            \ 'commentSuffix': '',
            \ 'comment': '//',
            "\ 'commentfn': CommentJS,
            \ 'consolefn': {s -> 'console.log(' . s . ')'},
            \ 'function': 'function',
            \ 'p1': 'function',
            \ 'p2': ' {',
            \ 'suffix': '}',
            \ 'capitalize': 0,
            \ 'runtime': 'node',
            \ 'prettier': 'prettier --write ',
            \ 'variablePrefix': 'const ',
            \ 'const': 'const ',
            \ 'consoleStart': 'console.log(',
            \ 'console': 'console.log(',
            \ 'consoleEnd': ')',
            \ 'logicsuffix': '}',
        \ }, 
        \ 'vim': { 
            \ 'let': 'let ',
            \ 'const': 'let ',
            \ 'log': 'echo  ',
            \ 'slash': '\',
            \ 'consoleX': 'console',
            \ 'callableRE': g:vimcallableRE,
            \ 'lbr': '"""""""""""""""""""""""""""""""""""""""""""""""""""""""', 
            \ 'else': 'else', 
            \ 'stry': 'try', 
            \ 'scatch': ['catch', '        ', 'endtry'],
            \ 'try': ['try', '    ', 'catch', '    ', 'endtry'],
            \ 'o': 'IsObject',
            \ 'a': 'IsArray',
            \ 'classparam': 'self',
            \ 'classp1': '',
            \ 'n': 'IsNumber',
            \ 'logicsuffix': '',
            \ 's': 'IsString',
            \ 'if': ['if ', ''],
            \ 'ef': ['elseif ', ''],
            \ 'ift': ['if ', ''],
            \ 'eft': ['elseif ', ''],
            \ 'testfunc': 'Test',
            \ 'commentPrefix': '"',
            \ 'commentSuffix': '',
            \ 'comment': '"',
            \ 'function': 'function',
            \ 'p1': 'function',
            \ 'p2': '',
            \ 'suffix': 'endfunction',
            \ 'capitalize': 1,
            \ 'variablePrefix': 'let ',
            \ 'consoleStart': 'echom ',
            \ 'console': 'ec ',
            \ 'consoleEnd': '',
            \ 'consolefn': {s -> 'echo ' . s},
        \ },
        \ 'html': {
            \ 'commentPrefix': '<!--',
            \ 'commentSuffix': ' -->',
        \ },
        \ 'css': {
            \ 'lbr': '/*********************************************************/',
            \ 'commentPrefix': '/*',
            \ 'commentSuffix': ' */',
        \ },
        \ 'py': {
            \ 'callableRE': g:pycallableRE,
            \ 'classMethodRE': '^    def ', 
            \ 'lbr': '#######################################################', 
            \ 'consoleX': 'console',
            \ 'expand': 'python', 
            \ 'libfile': 'combine.py.lib', 
            \ 'sdelimiter': '''''''', 
            \ 'else': 'else:', 
            \ 'log': 'print()', 
            \ 'stry': 'try:', 
            \ 'scatch': ['except Exception as e:', '        '],
            \ 'classp1': 'def ',
            \ 'classparam': 'self',
            \ 'try': ['try:', '    ', 'except Exception as e:', '    '],
            \ 'o': 'isObject',
            \ 'logicsuffix': '',
            \ 'a': 'isArray',
            \ 'n': 'isNumber',
            \ 's': 'isString',
            \ 'prettier': 'black ',
            \ 'if': ['if ', ':'],
            \ 'ef': ['elif ', ':'],
            \ 'ift': ['if ', ':'],
            \ 'eft': ['elif ', ':'],
            \ 'testfunc': 'test',
            \ 'commentPrefix': '#',
            \ 'commentSuffix': '',
            \ 'function': 'def',
            \ 'comment': '#',
            \ 'p1': 'def',
            \ 'p2': ':',
            \ 'suffix': '',
            \ 'capitalize': 0,
            \ 'run': 'python3',
            \ 'runtime': 'python3',
            \ 'variablePrefix': '',
            \ 'consoleStart': 'print(',
            \ 'consoleEnd': ')',
            \ 'consolefn': {s -> 'print(' . s . ')'},
        \ }
    \}
  

"let g:zoopbarfndict = {
    "\'go':   { -> SprawlMatch(g:callableRE) . '()' . " {\n    $c\n}",
    "\'abc':  { -> "abc = ['a', 'b', 'c']" },
    "\'ifu':  { -> IfMaker('IsUndefined')},
    "\'z':    { -> "z = new " . SprawlMatch('^class \zs\w+') . "()\n$c"},
"\}


let g:vueregexdict = {
        \'d': 'data',
        \'t': 'template:',
        \'w': 'watch:',
        \'p': 'props:',
        \'m': 'mounted',
        \'r': 'render',
        \'c': 'computed:',
        \'f': 'methods:',
\}



let g:ldrdict["ldr"] = "AddToLdrDict"
let g:ldrdict["eat"] = "IabEat"
let g:ldrdict["cd"] = "ChangeDir"
let g:ldrdict["iab"] = "CreateIab"
let g:replacecdict['tc'] = {'fn': 'TryCatcher', 'i': 'trycatchindex'}

let g:pydict["abc"] = "abc = 'abcde'.split('')"
let g:pydict["forir"] = "for (let i = $1; i >= 0; i--) {\n    $c\n}"
let g:pydict["nerd"] = "nerdamer = require(\"nerdamer/all.min\")"
let g:pydict["vimf"] = "/home/kdog3682/.vimrc"
let g:pydict["wc"] = "/*\n    $c\n*/"
let g:pydict['button'] = "<button class=\"\">$c</button>"
let g:pydict['cc'] = "z = new ${Capitalize($1)}($c)"
let g:pydict['div'] = "<div class=\"\">$c</div>"
let g:pydict['h1'] = "<button class=\"\">$c</button>"
let g:pydict['sf'] = "function s(s) {\n    $c\n}"
let g:pydict['vueo'] = "const $1 = {\n    props: [],\n    template: `\n        <div>\n        $c\n        </div>\n    `,\n    data() {\n        return {\n            \n        }\n    }\n}"
let g:pydict["abcl"] = "abc = ['a', 'b', 'c', 'd', 'e']"
let g:pydict["abco"] = "abc = {'a': 'a', 'b':'b', 'c': 'c', 'd': 'D', 'e': 'e'}"
let g:pydict["ifew"] = "if ($1.endsWith($2)) $c"
let g:pydict["div"] = "${SnippetDivMaker($1, $2, $3, $4)}"
let g:pydict["divc"] = "<div>\n    $c</div>"
let g:pydict["dict"] = "${Dictify($rest)}"
let g:pydict["iflast"] = "if (getLast($1) == $2)"
let g:pydict["ifthrow"] = "if (!$1) throw '$1 doesnt exist'"
let g:pydict["jsc"] = "console.log(JSON.stringify($c))"
let g:pydict['vuech'] = "const ${Capitalize($1)} = {\n    name:'${Capitalize($1)}',\n    props: ['$c'],\n    render(h) {\n    \n    }\n}"
let g:pydict['mo'] = "mounted() {\n    console.log('hello from ${GetBindingName()}')\n    $c\n},"
let g:pydict['mounted'] = "mounted() {\n    $c\n},"
let g:pydict['methods'] = "methods: {\n    $c\n},"
let g:pydict['render'] = "render(h) {\n    $c\n},"
let g:pydict['her'] = "const options = {\n    class: 'zork'\n}\nconst component = h('div', options, $c)\nreturn component"
let g:pydict["e"] = "const editor = new TextEditor($1)\n"
let g:pydict["w"] = "while"
let g:pydict["ifnt"] = "if (!test(${ZoopbarTestVar($0)})) "
let g:pydict["foo"] = "function foo() {\n    $c\n}\n\nfoo()"
let g:pydict['doctype'] = '<!DOCTYPE html><html><body></body><script src="$c"></script><script src="create.js"></script></html>'
let g:pydict['dt'] = '<!DOCTYPE html><html><body></body><script src="create.js"></script></html>'
let g:pydict["req"] = "const $1 = require('./$1.js')"
let g:pydict["vd"] = "${Vdiv($0)}"
let g:ldrdict['sd'] = 'ecp'
let g:ldrdict['ff'] = 'ecp'
let g:pydict["fs"] = "fs = require('fs')"
let g:pydict["d"] = "${SnippetDivMaker($1, $2, $3, 'short')}"
let g:pydict["v"] = "${Vdiv($0, 1)}"
let g:pydict["div"] = "${SnippetDivMaker2($0)}"
let g:pydict["props"] = "props: ['$c'],"
let g:ldrdict['rfto'] = 'ecp'
let g:ldrdict['replacepage'] = 'ecp'
let g:pydict["sleep"] = "await sleep(1000)"
let g:pydict["vms"] = "foo"
let g:pydict["ai"] = "[\n    '',\n    '$c'\n],"
let g:pydict["foo"] = "foasdfasdfasdfasdfo"
let g:pydict["df"] = "<ul class=\"$1\">\n    <span v-for=\"$1\">$c</span>\n</ul>"
let g:pydict["vms"] = "let line = CurrentLine()\nlet r = $c\nlet m = Search(line, r)"
let g:pydict["vim"] = "let file = '/home/kdog3682/.vimrc'"
let g:ldrdict['sgv'] = 'SetGVariable'
let g:pydict["script"] = "<script>\n    $c\n</script>"
let g:pydict["body"] = "<body>\n    $c\n</body>"
let g:ldrdict['ti'] = 'ToggleIndent'
let g:ldrdict['sti'] = 'SetTemporaryIab'
let g:ldrdict['wcf'] = 'WriteCurrentFiles'
let g:ldrdict['lcf'] = 'LoadCurrentFiles'
let g:ldrdict['o'] = 'OpenFile2'
let g:ldrdict['sv'] = 'SmartSave'
let g:pydict["co"] = "{\n    type: 'story',\n    value: [\n        $c\n    ],\n},"
let g:ldrdict["names"] = "ecj"
let g:ldrdict["re"] = "ReadLibItem"
let g:pydict["ifewn"] = "if (endsWithNumber($1)) {\n    $c\n}"
let g:pydict["ifswn"] = "if (startsWithNumber($1)) {\n    $c\n}"
let g:pydict["ifd"] = "if (isDefined($1)) {\n    $c\n}"
let g:pydict["bc"] = "${BetterConsole($0)}"
let g:pydict["write"] = "write(${PyWriteHelper($0)})"
let g:pydict["w"] = "write(${PyWriteHelper($0)})"
let g:pydict["r"] = "read(${PyWriteHelper($0)})"
let g:ldrdict['tn'] = 'ToggleNerdamer'
let g:ldrdict['ad'] = 'AutoDedent'
let g:ldrdict['ris'] = 'RegisterInvivoSnippet'
let g:ldrdict['build'] = 'BuildJS'
let g:ldrdict['sv'] = 'SaveToFileDict'
let g:ldrdict['main'] = 'NewMain'
let g:pydict["ss"] = "const items = split(s, ' ')"
let g:ldrdict['saf'] = 'ShuntAwayFrom'
let g:ldrdict['fvk'] = 'FindVimKey'
let g:ldrdict['za'] = 'ZAction'
let g:ldrdict['pb2str'] = 'Pb2str'
let g:ldrdict['pbi'] = 'Pb2i'
let g:ldrdict['pbd'] = 'Pb2d'
let g:ldrdict['pb2s'] = 'Pb2snippet'
let g:ldrdict['cab'] = 'AddCabmap'
let g:ldrdict['isl'] = 'InsertScriptLink'
let g:ldrdict['gg'] = 'GetLocalGithub'
let g:ldrdict['f'] = 'AddFile'
let g:ldrdict['oi'] = 'OpenIndexHtml'
let g:ldrdict['gitu'] = 'GitUpdate'
let g:ldrdict['dib'] = 'DefineInternetBookmark'
let g:ldrdict['dip'] = 'DefineInsertionPoint'
let g:ldrdict['sv'] = 'SaveToInsertionPoint'
let g:ldrdict['a'] = 'InvivoCreateAlias'
let g:ldrdict['aei'] = 'InvivoCreateAlias'
let g:ldrdict['append'] = 'LeaderAppend'
let g:ldrdict['tnf'] = 'ToNoteFile'
let g:ldrdict['to'] = 'LeaderTo'
let g:ldrdict['a'] = 'ShuntAway'
let g:pydict["body"] = "<body>\n    $c\n</body>"
let g:ldrdict['rwu'] = 'ReplaceWordUnderCursor2'
let g:ldrdict['rfc'] = 'ecj'
let g:ldrdict['lg'] = 'Logging'
let g:pydict["fooboo"] = "function foo() {\n    $1\n}\n\nfunction boo() {\n    foo()\n}\n"
let g:pydict["dog"] = "foo bar"
let g:ldrdict['uti'] = 'UnsetTemporaryIab'
let g:ldrdict["sf"] = "SaveCurrentItemTo"
let g:pydict["cl"] = "console.log('Line: $lineNumber $1:', $1)$c"
let g:ldrdict['stb'] = 'SetTempBindings'
let g:ldrdict['ag'] = 'AskGoogle'
let g:ldrdict['anc'] = 'AddNormalCommand'
let g:ldrdict['as'] = 'WordUnderCursorToSnippet'
let g:pythonsnippets["rlp"] = "data = read('lib.py.json')\nkeys = data.keys()\npprint(keys)\nraise Exception('')\nvalues = date.values()\npprint(values)"
let g:pythonsnippets['fore'] = "for i, ${GetForIterationVariable($1)} in enumerate($1):\n    $c"
let g:ldrdict['ssd'] = 'SetShuntDestination'
let g:pythonsnippets['plib'] = "lib = read('lib.py.json')"
let g:pythonsnippets['rlcl'] = "pprint(create_library(read('$1')))"
let g:pythonsnippets['c'] = "class ${Capitalize($1)}:\n    def __init__(self, $c):\n        "
let g:pythonsnippets["dec2"] = "def $1():\n    def decorator(fn):\n        def wrapper(*args, **kwargs):\n                \n            $c\n            return fn(*args, **kwargs)\n\n        return wrapper\n    return decorator"
let g:pythonsnippets["dec1"] = "def $1(fn):\n    def wrapper(*args, **kwargs):\n        $c\n        return fn(*args, **kwargs)\n\n    return wrapper"
let g:ldrdict['tp'] = 'TestPrintFunction'
let g:ldrdict['tp'] = 'TestPrintFunction'
let g:ldrdict['d'] = 'AddDictItem'
let g:pythonsnippets["dl"] = 'log("$1", $1)'
let g:ldrdict['td'] = 'Todolist'
let g:pythonsnippets['dun'] = "def __$1__(self):\n    $c"
let g:pythonsnippets['iter'] = '[$1(item) for item in $infer]'
let g:pythonsnippets['cls'] = "class ${Capitalize($1)}:\n    def __init__(self, $c):\n        "
let g:ldrdict['/e'] = 'GoToDir'
let g:pydict["rnl"] = "    s = re.sub('\n(?=\n\n)', '', s.trim())"
let g:pydict["rnl"] = "    print(key, args)\n    globals().get(key)(*args)"
let g:ldrdict['ds'] = 'DefineSnippetCompletionStart'
let g:solsnippets["vim"]["zzop"] = 'function AppendVim(lines, ...)'
let g:solsnippets["vim"]["word"] = 'let word = GetCurrentWord()'
let g:ldrdict['config'] = 'ToggleGlobalConfig'
let g:solsnippets["js"]["ifwu"] = 'if (typeof window == ''undefined'')'
let g:solsnippets["py"]["ee"] = 'except Exception as e:'
let g:solsnippets["py"]["ifname"] = 'if __name__ == ''__main__'':'
let g:ldrdict['saveall'] = 'SaveAllFilesToDrive'
let g:solsnippets["py"]["faf"] = 'matches = re.findall(regex, read(file), flags=re.M)'
let g:solsnippets["vim"]["lang"] = 'let lang = GetLang()'
let g:ldrdict['fn'] = 'ChangeLineFileName'
let g:solsnippets["py"]["temp"] = 'return write(''tempest.json'', '
let g:ldrdict['npm'] = 'Npm'
let g:ldrdict['pip'] = 'Pip'
let g:ldrdict['zoa'] = 'Zoasd'
let g:pydict["npm"] = 'const $1 = require("$1")'
let g:ldrdict['dsf'] = 'DefineSnippetFromFile'
let g:solsnippets["py"]["pp"] = 'pprint(matches)'
let g:ldrdict['fk'] = 'FindKeyInDict'
let g:ldrdict['rn'] = 'RenameFile'
let g:ldrdict['le'] = 'LineEdit'
let g:ldrdict['svdf'] = 'SaveAllFilesToDateFolder'
let g:solsnippets["vim"]["gdrive"] = 'let gdrive = ''/mnt/chromeos/GoogleDrive'''
let g:solsnippets["vim"]["drive"] = 'let gdrive = ''/mnt/chromeos/GoogleDrive'''
let g:ldrdict['todo'] = 'TodoListForToday'
let g:pythonsnippets["pyi"] = "from test import *\nfrom filesystem import *\nfrom libra import *\n\n"
let g:solsnippets["vim"]["line"] = 'let line = CurrentLine()'
let g:pythonsnippets['zoo'] = "abc\nabc"
let g:ldrdict['uds'] = 'UpdateSnippets'
let g:pythonsnippets["dec"] = "def required(checkpoint):\n    def decorator(fn):\n        def wrapper(*args, **kwargs):\n            assert checkpoint(args[0])\n            return fn(*args, **kwargs)\n\n        return wrapper\n    return decorator"
let g:ldrdict['mm'] = 'ModeMaster'
let g:ldrdict['ev'] = 'ExportVim'
let g:ldrdict['cd'] = 'ChangeDir'
let g:solsnippets["py"]["serj"] = "serj = ''/home/kdog3682/CWD/service.json''"
let g:solsnippets["py"]["libref"] = "libref = ''/home/kdog3682/CWD/service.json''"
let g:ldrdict['eod'] = 'DaysWork'
let g:ldrdict['cdb'] = 'CloseDotBuffers'
let g:ldrdict['coc'] = 'CommentOutConsole'
let g:ldrdict['cbo'] = 'CloseAllBuffersAndOpen'
let g:ldrdict['fr'] = 'FfrefFinder'
let g:ldrdict['cd'] = 'ChangeDir'
let g:ldrdict['fn'] = 'WriteFunctionNotes'
let g:solsnippets["vim"]["name"] = "let name = GetFunctionName()"
let g:ldrdict['create'] = 'CreateFileFromScratchpad'
let g:ldrdict["asdf"] = "@PythonConnector filesort.py"
let g:ldrdict["cr8html"] = "@PythonConnector html_file_from_main_entrypoint.py"
let g:ldrdict["ask"] = "@PythonConnector redditscript.py ask"
let g:ldrdict["reply"] = "@PythonConnector redditscript.py reply"
let g:ldrdict["tempiab"] = "@PythonConnector vimservice __tempiab"
let g:ldrdict["imapqq"] = "@PythonConnector vimservice __imapqq"
let g:ldrdict["ff"] = "@PythonConnector fileservice.py filefinder"
let g:solsnippets["vim"]["file"] = "let file = CurrentFile()"
let g:ldrdict['connect'] = 'ConnectFileToLeaderAndPythonController'
let g:ldrdict["extract"] = "@PythonConnector extract_stdlib_deps.py main"
let g:solsnippets["py"]["git"] = "git = ''https://api.github.com/users/''"
let g:ldrdict['cr8'] = 'CreateFileFromScratchpad'
let g:ldrdict['to'] = 'TransportTo'
let g:ldrdict["dlg"] = "@PythonConnector download_github_gist.py download_github_gist"
let g:ldrdict['nf'] = 'NewFile'
let g:solsnippets["py"]["it"] = "iterate(name, runner)"
let g:ldrdict['ifn'] = 'FastLineEdit'
let g:ldrdict['apc'] = 'AddPythonConnectorFileCommand'
let g:ldrdict["req"] = "@PythonConnector intel.py srequest"
let g:ldrdict["ss"] = "@PythonConnector single_sweep.py singlesweep $cf"
let g:ldrdict["scrape"] = "@PythonConnector scrape.py main"
let g:ldrdict["varbu"] = "@PythonConnector fileservice.py varbu"
let g:ldrdict["fe"] = "@NodeConnector finderror.js"
let g:ldrdict['gfae'] = 'GetFragmentAndExecute'
let g:ldrdict["asdf"] = "@PythonConnector sayhi.py main"
let g:ldrdict['cfi'] = 'CopyFileIncrement'
let g:ldrdict['cfio'] = 'CopyFileIncrementOverride'
let g:ldrdict['lf'] = 'LogicFind'
let g:solsnippets["py"]["rf"] = "m = re.findall(r, read(vim.''/home/kdog3682/.vimrc''))"
let g:solsnippets["vim"]["s"] = "let s = CurrentLine()"
let g:ldrdict['sod'] = 'StartOfDay'
let g:ldrdict['eod'] = 'DaysWork'
let g:ldrdict['eod'] = 'EndOfDay'
let g:ldrdict['gtl'] = 'GetTheLineAndPrintTheLine'
let g:solsnippets["py"]["dir"] = "dirinfo"
let g:solsnippets["py"]["osgc"] = "dir = os.getcwd()"
let g:ldrdict['iq'] = 'InvivoQuotify'
let g:solsnippets["vim"]["hi"] = "ec ''saying hi''"
let g:ldrdict['sww'] = 'SeeWhatsWrong'
let g:ldrdict['app'] = 'CreateApp'
let g:ldrdict["inva"] = "@PythonConnector apps.py invivoAppend"
let g:ldrdict['bm'] = 'BookmarkManager'
let g:solsnippets["vim"]["apv"] = "call AppendVimAndExecute(s)"
let g:ldrdict['alc'] = 'AddLeaderCommand'
let g:solsnippets["vim"]["fa"] = "let m = FindallStrings(s, regex)"
let g:ldrdict['dta'] = 'DictToArray'
let g:solsnippets["vim"]["spc"] = "let spaces = GetSpaces(otherLine)"
let g:ldrdict['gsc'] = 'GrabSecondCallAndMoveAbove'
let g:solsnippets["py"]["ppr"] = "from pprint import pprint"
let g:solsnippets["vim"]["ab"] = "let [a,b] = SplitOnce(a:s)"
let g:ldrdict['wps'] = 'WPAddSnippet'
let g:ldrdict['wpsl'] = 'WPAddSnippetFromLine'
let g:ldrdict['time'] = 'GetTimeAndDate'
let g:ldrdict['mark'] = 'Mark'
let g:ldrdict["foo"] = "@PythonConnector apps.py fooba"
let g:ldrdict["save"] = "@PythonConnector apps.py save_from_morning"
let g:ldrdict['cptd'] = 'CopyFileToOtherDir'
let g:ldrdict['aed'] = 'AddExpressionDict'
let g:solsnippets["vim"]["ch"] = "let ch = GetCursor()"
let g:pydict["c"] = "class ${Capitalize($1)} {\n    constructor($c) {\n    }\n}"
let g:ldrdict["nerd"] = "@NodeConnector nerdsolver.js nerdsolver eval"
let g:ldrdict["from"] = "@NodeConnector dependencybuilder.js getMissingDependencies null"
let g:ldrdict["ud"] = "@NodeConnector dependencybuilder.js dependencybuilder null"
let g:ldrdict["vt"] = "@NodeConnector vue-transform.js vuetransform null"
let g:ldrdict["vtp"] = "@NodeConnector vue-transform.js vuetransform preview"
let g:ldrdict['adtl'] = 'AddDateToLine'
let g:ldrdict['aa'] = 'AlignAssignments'
let g:ldrdict['align'] = 'AlignAssignments'
let g:ldrdict['gttf'] = 'GoToTestFile'
let g:ldrdict['tilda'] = 'Tildaify'
let g:ldrdict['afs'] = 'AddFileStartOrEndDate'
let g:ldrdict['dep'] = 'Deprecate'
let g:ldrdict['rfff'] = 'ReadFunctionFromFile'
let g:ldrdict['dsf'] = 'DeleteSelfFile'
let g:solsnippets["vim"]["cursor"] = "let cursor = GetCursor()"
let g:ldrdict['v'] = 'GoVim'
let g:solsnippets["js"]["vfa"] = "vue.farAwayIncrement('ctopiclevel')"
let g:ldrdict['sor'] = 'SourceVim'
let g:ldrdict['sof'] = 'SourceFile'
let g:ldrdict['tme'] = 'ToModuleExports'
let g:ldrdict['sov'] = 'SourceVim'
let g:ldrdict['aft'] = 'AppendFt'
let g:ldrdict["ss"] = "@PythonConnector single_sweep.py singlesweep $cf"
let g:ldrdict['ii'] = 'InvivoIab'
let g:ldrdict['rpc'] = 'RegisterPythonConnector'
let g:solsnippets["js"]["div"] = "<div>hi</div>"
let g:solsnippets["js"]["mr"] = ":key=''Math.random()''"
let g:solsnippets["js"]["sto"] = "const storage = new Storage(Array)"
let g:pydict["w"] = "while (true) {\n    $c\n}"
let g:pydict["runner"] = "const runner = ($1) => {\n   $c\n}"
let g:solsnippets["py"]["today"] = "today = datetime.datetime.today()"
let g:ldrdict['sm'] = 'SetManager'
let g:solsnippets["js"]["ifs"] = "if(typeof window!==''undefined''){module={};module.exports={};require=()=>({})}"
let g:pydict["s"] = "s = '$0'"
let g:pythonsnippets['r'] = "s = read('$1')"
let g:pythonsnippets['s'] = "s = '$1'"
let g:ldrdict['reg'] = 'RegisterJsImportExport'
let g:ldrdict['req'] = 'GetJsRequire'
let g:ldrdict['savetoday'] = 'SaveToday'
let g:pydict["psc"]  = "StateContainer.prototype.$1 = function($2) {\n     $c\n}"
let g:pydict["req"]  = "var {$1} = require('./${FileGetter($2)}')"
let g:solsnippets["vim"]["name"] = "let name = GetFunctionName()"
let g:ldrdict['gmi'] = 'GetModuleImports'
let g:ldrdict['cif'] = 'ConstructInvivoFunction'
let g:solsnippets["vim"]["lang"] = "let lang = GetLang()"
let g:pydict["tg"]  = "TgCols"
let g:ldrdict['ffc'] = 'FileFromCurrentFile'
let g:pydict["wh"]  = "let i = 0\nwhile (i < $1.length) {\n    let item = $1[i]\n    $c\n   }\n"
let g:solsnippets["js"]["ci"] = "const item ="
let g:pydict['webscript'] = '<script src="$0"></script>'
let g:solsnippets["js"]["ab"] = "let [a,b] ="
let g:solsnippets["js"]["mod"] = """type"": ""module"","
let g:solsnippets["js"]["dn"] = "Date.now()"
let g:ldrdict['prt'] = 'Prt'
let g:pydict["forii"] = "for (;;) {\n    $c\n}"
let g:pydict["log"] = "$1\nconsole.log($c)"
let g:ldrdict['r'] = 'Registrar'



let g:vimlogic = {
  \ "t": "Test('$1', $2)",
  \ "a": "IsArray($1)",
  \ "w": "while 1",
  \ "ne": "!Exists($1)",
  \ "e": "Exists($1)",
  \ "n": "!Exists($1)",
  \ "f": "IsFunction($1)",
  \ "o": "IsObject($1)",
  \ "s": "IsString($1)",
  \ "Isi": "IsNumber($1)",
  \ "Isf": "IsFile($1)",
\}


let g:pylogic = {
  \ "t": "test('$1', $2)",
  \ "a": "isArray($1)",
  \ "n": "not $1",
  \ "cwdxxn": "not $1",
  \ "csdfwdxxn": "not $1",
  \ "cwxdn": "not $1",
  \ "nisf": "not isfile($1)",
  \ "f": "isFunction($1)",
  \ "l1": "if len($1) == 1",
  \ "l2": "if len($1) == 2",
  \ "l3": "if len($1) == 3",
  \ "o": "isObject($1)",
  \ "num": "isNumber($1)",
  \ "s": "isString($1)",
  \ "pi": "parseInt($1)",
  \ "isi": "isInteger($1)",
  \ "isf": "isfile($1)",
  \ "isd": "isdir($1)",
  \ "isvw": "isVeryWordy($1)",
  \ "lt": "len($1) < $2",
  \ "eq": "$1 == $2",
  \ "nsw": "$not test('^$1', $2)",
  \ "new": "$not test('$1$', $2)",
  \ "issl": "isSingleLine($1)",
  \ "hvx": "hasVariableX($1)",
  \ "ewn": "endsWithNumber($1)",
  \"al1": "arguments.length == 1",
  \"al2": "arguments.length == 2",
  \"al3": "arguments.length == 3",
  \"a0e": "args[0] == $1",
  \"a1e": "args[1] == $1",
  \"a2e": "args[2] == $1",
  \"cn": "$1.constructor.name == $2",
\}

let g:jslogic = {
  \ "t": "test($1, $2)",
  \ "sw": "test(/^$1/, $2)",
  \ "ft": "ftest($1, $2)",
  \ "n": "!test($1, $2)",
  \ "eq": "$1 == '$2'",
  \ "not": "!$1",
  \ "a": "isArray($1)",
  \ "nest": "isNestedArray($1)",
  \ "name": "$1.constructor.name == '$2'",
  \ "num": "isNumber($1)",
  \ "node": "isNode()",
  \ "no": "isNode()",
  \ "f": "isFunction($1)",
  \ "l1": "len($1) == 1",
  \ "l2": "len($1) == 2",
  \ "l3": "len($1) == 3",
  \ "o": "isObject($1)",
  \ "e": "exists($1)",
  \ "s": "isString($1)",
  \ "pi": "parseInt($1)",
  \ "isi": "isInteger($1)",
  \ "isf": "isFraction($1)",
  \ "isvw": "isVeryWordy($1)",
  \ "nsw": "$not test('^$1', $2)",
  \ "new": "$not test('$1$', $2)",
  \ "issl": "isSingleLine($1)",
  \ "hvx": "hasVariableX($1)",
  \ "ew": "$1.endsWith('$2')",
  \ "ewn": "endsWithNumber($1)",
  \"alg1": "args.length > 1",
  \"all1": "args.length == 1",
  \"all2": "args.length == 2",
  \"all3": "args.length == 3",
  \"al1": "arguments.length == 1",
  \"al2": "arguments.length == 2",
  \"al3": "arguments.length == 3",
  \"a0e": "args[0] == $1",
  \"a1e": "args[1] == $1",
  \"a2e": "args[2] == $1",
  \"cn": "$1.constructor.name == $2",
\}



let g:jslogic["a"] = "isArray($1)"
let g:jslogic["s"] = "isString($1)"
let g:jslogic["f"] = "isFunction($1)"
let g:jslogic["n"] = "isNumber($1)"
let g:jslogic["o"] = "isObject($1)"
let g:jslogic["prim"] = "isPrimitive($1)"
let g:jslogic["nest"] = "isNestedArray($1)"
let g:jslogic["r"] = "isRegExp($1)"
let g:jslogic["c"] = "isClass($1)"
let g:jslogic["di"] = "isDoubleIterable($1)"
let g:jslogic["jp"] = "isJsonParsable($1)"
let g:jslogic["word"] = "isWord($1)"
let g:jslogic["bool"] = "isBoolean($1)"
let g:jslogic["err"] = "isError($1)"
let g:jslogic["set"] = "isSet($1)"
let g:jslogic["hcg"] = "hasCaptureGroup($1)"
let g:jslogic["hs"] = "hasSelector($1)"
let g:jslogic["und"] = "isUndefined($1)"
let g:jslogic["sel"] = "isSelector($1)"
let g:jslogic["null"] = "isNull($1)"
let g:jslogic["hsk"] = "hasSharedKeys($1)"
let g:jslogic["ele"] = "isElement($1)"
let g:jslogic["iter"] = "isIterable($1)"
let g:jslogic["cap"] = "isCapitalized($1)"
let g:jslogic["int"] = "isInteger($1)"
let g:jslogic["sto"] = "isStorage($1)"
let g:jslogic["ac"] = "isAllCaps($1)"
let g:jslogic["hl"] = "hasLatex($1)"
let g:jslogic["sh"] = "isStandardHtml($1)"
let g:jslogic["sws"] = "startsWithSymbol($1)"
let g:jslogic["swp"] = "startsWithPeriod($1)"
let g:jslogic["hh"] = "hasHtml($1)"
let g:jslogic["eb"] = "isEnterBlock($1)"
let g:jslogic["url"] = "isUrl($1)"
let g:jslogic["yes"] = "isYesterday($1)"
let g:jslogic["tod"] = "isToday($1)"
let g:jslogic["def"] = "isDefined($1)"
let g:jslogic["hn"] = "hasNumber($1)"
let g:jslogic["hc"] = "hasComma($1)"
let g:jslogic["hl"] = "hasLetter($1)"
let g:jslogic["hw"] = "hasWord($1)"
let g:jslogic["hla"] = "hasLookAround($1)"
let g:jslogic["ewn"] = "endsWithNumber($1)"
let g:jslogic["tru"] = "isTrue($1)"
let g:jslogic["nl"] = "isNewLine($1)"
let g:jslogic["hg"] = "hasGFlag($1)"
let g:jslogic["hn"] = "hasNewline($1)"
let g:jslogic["fir"] = "isFirst($1)"
let g:jslogic["nod"] = "isNode($1)"
let g:jslogic["sym"] = "isSymbol($1)"
let g:jslogic["sc"] = "isStandardCss($1)"
let g:jslogic["ho"] = "hasOwn($1)"
let g:jslogic["jso"] = "isJson($1)"
let g:jslogic["hs"] = "hasSpaces($1)"
let g:jslogic["hc"] = "hasColon($1)"
let g:jslogic["hd"] = "hasDash($1)"
let g:jslogic["hcc"] = "hasCamelCase($1)"
let g:jslogic["iscp"] = "isSingleCssProperty($1)"
let g:jslogic["pro"] = "isPromise($1)"
let g:jslogic["pos"] = "isPositive($1)"
let g:jslogic["iha"] = "isHtmlAttr($1)"
let g:jslogic["iae"] = "isAllEqual($1)"
let g:jslogic["iasw"] = "isAllSingleWords($1)"
let g:jslogic["swsw"] = "startsWithSingleWord($1)"


let g:solsnippets["js"]["so"] = "const standardObject = new StandardObject()"
let g:solsnippets["js"]["mdy"] = "const mdy = getMDY($c)"
let g:solsnippets["js"]["last"] = "const last = getLast($c)"
let g:solsnippets["js"]["ew"] = "const errorWatcher = new ErrorWatcher()"
let g:solsnippets["js"]["first"] = "const first = getFirst($c)"
let g:solsnippets["js"]["year"] = "const year = getYear($c)"
let g:solsnippets["js"]["spaces"] = "const spaces = getSpaces($c)"
let g:solsnippets["js"]["indent"] = "const indent = getIndent($c)"
let g:solsnippets["js"]["cache"] = "const cache = new Cache()"
let g:solsnippets["js"]["clock"] = "const clock = new Clock()"
let g:solsnippets["js"]["storage"] = "const storage = new Storage()"
let g:solsnippets["js"]["words"] = "const words = getWords($c)"
let g:solsnippets["js"]["eater"] = "const eater = new Eater()"
let g:solsnippets["js"]["matrix"] = "const matrix = new Matrix()"
let g:solsnippets["js"]["table"] = "const table = new Table()"
let g:solsnippets["js"]["tt"] = "const textTokenizer = new TextTokenizer()"
let g:solsnippets["js"]["cl"] = "const codeLibrary = new CodeLibrary()"
let g:solsnippets["js"]["clo"] = "const codeLibraryObject = new CodeLibraryObject()"
let g:solsnippets["js"]["ii"] = "const itemIter = new ItemIter()"
let g:solsnippets["js"]["caller"] = "const caller = getCaller($c)"
let g:solsnippets["js"]["we"] = "const wbooError = new WbooError()"
let g:solsnippets["js"]["chunks"] = "const chunks = getChunks($c)"
let g:solsnippets["js"]["ie"] = "const indexError = new IndexError()"
let g:solsnippets["js"]["params"] = "const params = getParameters($c)"
let g:solsnippets["js"]["im"] = "const indexedMap = new IndexedMap()"
let g:solsnippets["js"]["iter"] = "const iter = new Iter()"
let g:solsnippets["js"]["le"] = "const lineEdit = new LineEdit()"
let g:solsnippets["js"]["ee"] = "const eventEmitter = new EventEmitter()"
let g:solsnippets["js"]["ib"] = "const incrementalBuilder = new IncrementalBuilder()"
let g:solsnippets["js"]["builder"] = "const builder = new Builder()"


let g:jsfndict = {"t":"test","t1":"trimmed","t2":"templater","t3":"tryval","t4":"toabrev","t5":"timestamp","t6":"type","t7":"tail","e":"exists","e1":"evaluate","e2":"Eater","ip":"isPrimitive","d":"difference","d1":"dedent","d2":"doublequote","d3":"dreplace","d4":"depluralize","d5":"datestamp","u":"unique","u1":"uncapitalize","f":"findall","f1":"flat","f2":"ftest","f3":"find","f4":"freplace","f5":"filtered","f6":"fparse","gfn":"getFunctionName","gfn1":"getFunctionNames","it":"insertText","ia":"isArray","io":"isObject","ta":"toArray","ta1":"toArgument","ta2":"toAttr","rc":"removeComments","r":"reduce","r1":"roygbiv","r2":"replace","r3":"regexgetter","r4":"range","r5":"rescape","is":"isString","j":"joined","j1":"jspy","j2":"join","pi":"prepareIterable","td":"toDictionary","ni":"newlineIndent","s":"Storage","s1":"splitonce","s2":"split","s3":"stringcall","s4":"splitmapfilter","s5":"search","s6":"sorted","s7":"sum","s8":"singlequote","s9":"stringify","s10":"sayhi","n":"ncg","n1":"noop","ina":"isNestedArray","in":"isNumber","p":"parens","p1":"paired","p2":"pluralize","hn":"hasNumber","hn1":"hasNewline","tcc":"toCamelCase","pj":"parseJSON","tsa":"toStringArgument","a":"aggregate","a1":"argsplit","a2":"assert","a3":"addf","a4":"abbreviate","go":"getOptions","l":"len","l1":"linegetter","ii":"isInteger","m":"Matrix","m1":"matchgetter","m2":"matchall","m3":"mreplace","inl":"isNewLine","gl":"getLongest","gl1":"getLast","if":"isFunction","n2c":"n2char","ts":"trimSpaces","ts1":"toSpaces","c":"capitalize","c1":"Cache","c2":"Clock","c3":"compose","c4":"comment","c5":"checkjs","c6":"count","gi":"getIndent","rfi":"replaceFromIndex","ag":"addGFlag","dg":"defineGetter","i":"indent","i1":"inferlang","i2":"iter","i3":"Iter","ire":"isRegExp","cp":"cartesianProduct","z":"zip","hg":"hasGFlag","rsws":"regexStartsWithSpaces","rac":"removeAllComments","tv":"toVariable","stc":"spaceToCamel","cs":"curryStart","ce":"curryEnd","iu":"isUrl","rs":"removeStrings","tmi":"toModuleImports","tme":"toModuleExports","gial":"getIndentAndLine","id":"isDefined","iw":"isWord","tsc":"toSnakeCase","tsc1":"toStringCallable","tdc":"toDashCase","q":"quotify","fu":"fixUrl","fs":"fixSelector","fs1":"findallStrings","gw":"getWords","cl":"CodeLibrary","tsde":"toStringDictionaryEntry","ib":"insertBelow","gc":"getChunks","gfw":"getFirstWord","rts":"reduceToString","isc":"isStandardCss","swp":"startsWithPeriod","soc":"splitOptionalComma","b":"brackify","b1":"boundary","hc":"hasColon","acp":"addCssPeriod","hd":"hasDash","gs":"getSpaces","gfi":"getFunctionInfo","gll":"getLastLine","ccg":"countCaptureGroups","gsfo":"getSpacesFromOffset","tfr":"toFunctionRegex","rss":"removeStartingSpaces","gfl":"getFirstLine","stp":"splitThePage","btl":"bringToLife","pr":"prepareRegex","lc":"lineCount","ctn":"coerceToNumber","mi":"modularIncrement","bc":"blockComment","min":"modularIncrementNumber","glw":"getLastWord","sd":"smartDedent","hh":"hasHtml","le":"LineEdit","ieb":"isEnterBlock","fsl":"fixSpaceLength","ps":"puppetStringify","v":"vmap","ft":"fillTo","iae":"isAllEqual","gul":"getUniqueLetters","ish":"isStandardHtml","tsf":"toStringFunction","gvfs":"getVariablesFromString","fm":"fuzzyMatch","gp":"getParameters","fo":"filterObject","ic":"isCapitalized","tvv":"toVimVariable","tc":"toConfig","tvd":"toVimDict","ilf":"isLogicFunction","igf":"isGetFunction","sbo":"sortByOccurence","re":"removeExtension","tp":"toPascal","fp":"fixPath","x":"xsplit","as":"atSecond","snb":"splitNumberBoundary","gsi":"getStackInfo","gme":"getModuleExports"}

    let g:vuenavdict = {
        \'data': 'data\(\) \{',
        \'methods': 'methods: \{',
        \'computed': 'computed: \{',
        \'cr': '(created|mounted)\(\) \{',
        \'mo': '(created|mounted)\(\) \{',
        \'ren': 'render\(',
        \'template': 'template:',
        \'constructor': 'constructor',
        \'ctr': 'constructor',
    \}
let g:vuenavigationdict = {
    \'qgd': 'QNavData',
    \'qgt': 'QNavTemplate',
    \'ctr': 'QNavConstructor',
\}


let g:regexarr = [
    \['dotu', '.*?'],
    \['ncg', '(?:'],
    \['ss', '^ *'],
    \['spc', ' '],
    \['dq', '\\""'],
    \['sq', '\\'''],
    \['bou', '\\b'],
    \['az', '[a-zA-Z]+'],
    \['wdd', '\w[\w.-]+'],
    \['wd', '\w[\w-]+'],
    \['cwallu', '([\w\W]+)'],
    \['wallu', '[\w\W]+'],
    \['pfc', '(?:def|class)'],
    \['jfc', '(?:(?:async )?function|class)'],
    \['pla', '(?='],
    \['nla', '(?!'],
    \['plb', '(?<='],
    \['nlb', '(?<!'],
    \['cw', '(\w+)'],
    \['w8', '\w*'],
    \['lp', '\('],
    \['rp', '\)'],
    \['qre', '(?<=[\''\"]).*?(?=[''\"])'],
    \['cqre', '[\''\"](.*?)[\''\"]'],
    \['8', '*'],
    \['6', '^'],
    \['0', ')'],
    \['4', '$'],
    \['cdotu', '(.*?)'],
    \['dot', '.*'],
    \['cdot', '(.*)'],
    \['w', '\w+'],
    \['W', '\W+'],
    \['s', '\s+'],
    \['S', '\S+'],
    \['n', '\n'],
    \['q', '?'],
    \['d', '\d+'],
    \['p', '+'],
    \['or', '|'],
    \['dor', 'xxxx'],
    \['osr', 'xxxx'],
\]


"here
















let g:filedict["a"] = "/home/kdog3682/CWF/apps.py"
let g:filedict["cl"] = "classroom.js"
let g:filedict["d"] = "/home/kdog3682/CWF/public/demo.html"
let g:filedict["lj"] = "lorem.js"
let g:filedict["js2"] = "newhelpers.js2"
let g:filedict["e"] = "element-controller.js"
let g:filedict["vc"] = "functions.vim"
let g:filedict["nh"] = "/home/kdog3682/CWD/nodehelpers.js"
let g:filedict["t"] = "today.js"
let g:filedict["time"] = "timesheet"
let g:filedict["this"] = "timesheet"
let g:filedict["i"] = "/home/kdog3682/CWF/index.js2"
let g:filedict["h"] = "/home/kdog3682/CWF/public/h.js"
let g:filedict["html"] = "/home/kdog3682/CWF/10-29-2021.html"
let g:filedict["v"] = "/home/kdog3682/.vimrc"
let g:filedict["cmh"] = "cmtest/helpers.js"
let g:filedict["cmi"] = "cmtest/index.html"
let g:filedict["cn"] = "codingnotes.txt"
let g:filedict["c"] = "/home/kdog3682/CWF/public/c.js"
let g:filedict["src"] = "/home/kdog3682/CWF/sandisk/randomColor.js"
let g:filedict["r"] = "render.js"
let g:filedict["b"] = "base.js"
let g:filedict["vue"] = "/home/kdog3682/CWD/vuetify.js"
let g:filedict["cs"] = "/mnt/chromeos/MyFiles/Downloads/myext/content_script.js"
let g:filedict["qq"] = "qq.html"
let g:filedict["q"] = "q.html"
let g:filedict["rh"] = "render.html"
let g:filedict["n"] = "normalize.css"
let g:filedict["rc"] = "render.css"
let g:filedict["as"] = "asdfasdf.json"
let g:filedict["af"] = "afsgsdfgsfsdfasdf.json"
let g:filedict["afs"] = "afsgdfghdfghsdfgsfsdfasdf.json"
let g:filedict["fo"] = "foo.json"
let g:filedict["cjs"] = "current.js"
let g:filedict["cp"] = "/home/kdog3682/CWD/css-parser.js"
let g:filedict["env"] = "env.py"
let g:filedict["in"] = "/home/kdog3682/CWF/public/index.html"
let g:filedict["ij"] = "/home/kdog3682/CWF/public/index.js"
let g:filedict["pr"] = "/home/kdog3682/CWD/pdfgen-run.js"
let g:filedict["no"] = "/home/kdog3682/CWF/notes.txt"
let g:filedict["bashrc"] = "~/.bashrc"
let g:filedict["ba"] = "~/.bash_aliases"
let g:filedict["qg"] = "/home/kdog3682/CWF/question-generator.js"
let g:filedict["mu"] = "/home/kdog3682/CWF/math-utils.js"
let g:filedict["log"] = "/home/kdog3682/CWF/logging.js"
let g:filedict["rs"] = "/home/kdog3682/CWF/request-service.py"
let g:filedict["qs"] = "/home/kdog3682/questions.js"
let g:filedict["home"] = "kdog3682 .bash_profile"
let g:filedict["ttr"] = "./ttr.py"
let g:filedict["vimrc"] = "/home/kdog3682/.vimrc"
let g:filedict["pro"] = "/home/kdog3682/.profile"
let g:filedict["str"] = "/home/kdog3682/CWF/String.py"
let g:filedict["lp"] = "/home/kdog3682/CWD/langparser.js"
let g:filedict["fs"] = "/home/kdog3682/CWF/filesystem.py"
let g:filedict["te"] = "/home/kdog3682/CWF/test.py"
let g:filedict["pys"] = "/home/kdog3682/CWF/pystuff.py"
let g:filedict["cmg"] = "canvas-math-graph.js"
let g:filedict["ser"] = "server.js"
let g:filedict["lib"] = "/home/kdog3682/CWF/libra.py"
let g:filedict["li"] = "/home/kdog3682/CWF/libra.py"
let g:filedict["algm"] = "algebraic-methods.js"
let g:filedict["pc"] = "/home/kdog3682/CWF/pythonconnector.py"
let g:filedict["mh"] = "/home/kdog3682/CWD/math-helpers.js"
let g:filedict["le"] = "/home/kdog3682/CWF/line_edit.py"
let g:filedict["hp"] = "/home/kdog3682/CWD/html-parser.js"
let g:filedict["ecu"] = "/home/kdog3682/CWD/ec-utils.js"
let g:filedict["ecc"] = "/home/kdog3682/CWD/ec-components.js"
let g:filedict["ecm"] = "/home/kdog3682/CWD/ec-main.js"
let g:filedict["ech"] = "/home/kdog3682/CWD/ec-helpers.js"
let g:filedict["index"] = "/home/kdog3682/CWF/index.html"
let g:filedict["gl"] = "/home/kdog3682/CWF/GLOBALS.py"
let g:filedict["fh"] = "/home/kdog3682/CWF/file-help.txt"
let g:filedict["1"] = "/home/kdog3682/CWD/html.js"
let g:filedict["gs"] = "/home/kdog3682/CWF/GLOBALS.py"
let g:filedict["gith"] = "git.html"
let g:filedict["gitj"] = "git.js"
let g:filedict["gist"] = "gist.html"
let g:filedict["2"] = "/home/kdog3682/CWD/html.js"
let g:filedict["sj"] = "/home/kdog3682/CWF/slim.js"
let g:filedict["3"] = "/home/kdog3682/CWD/html2.js"
let g:filedict["hj"] = "/home/kdog3682/CWD/html3.js"
let g:filedict["s"] = "/home/kdog3682/CWF/public/scratchpad.js"
let g:filedict["h2"] = "/home/kdog3682/CWD/html2.js"
let g:filedict["vim"] = "/home/kdog3682/CWF/vim.py"
let g:filedict["eod"] = "/home/kdog3682/CWF/endofday.txt"
let g:filedict["sto"] = "/home/kdog3682/CWF/storage.py"
let g:filedict["fsr"] = "/home/kdog3682/CWF/fileservice.py"
let g:filedict["vt"] = "/home/kdog3682/CWD/vue-transform.js"
let g:filedict["db"] = "/home/kdog3682/CWD/dependencybuilder.js"
let g:filedict["kq"] = "/home/kdog3682/CWD/katex-question.js"
let g:filedict["hf"] = "/home/kdog3682/CWD/helperfunctions.js"
let g:filedict["so"] = "/home/kdog3682/CWD/source.js"
let g:filedict["jsc"] = "/home/kdog3682/CWF/public/jsc.js"
let g:filedict["pyc"] = "/home/kdog3682/CWF/pyconnector.py"
let g:filedict["tf"] = "/home/kdog3682/CWD/testfile.js"
let g:filedict["tf2"] = "/home/kdog3682/CWD/testfile2.js"
let g:filedict["tf3"] = "/home/kdog3682/CWD/testfile3.js"
let g:filedict["tf4"] = "/home/kdog3682/CWD/testfile4.js"
let g:filedict["dec"] = "/home/kdog3682/CWF/decorators.py"
let g:filedict["nerd"] = "/home/kdog3682/CWD/nerdsolver.js"
let g:filedict["rsg"] = "/home/kdog3682/CWF/render.jsgithub"
let g:filedict["t4"] = "/home/kdog3682/CWD/testfile4.js"
let g:filedict["vs"] = "/home/kdog3682/CWD/vuestore.js"
let g:filedict["ftj"] = "/home/kdog3682/.vim/ftplugin/javascript.vim"
let g:filedict["ftp"] = "/home/kdog3682/.vim/ftplugin/python.vim"
let g:filedict["fth"] = "/home/kdog3682.vim/ftplugin/html.vim"
let g:filedict["ftv"] = "/home/kdog3682/.vim/ftplugin/vim.vim"
let g:filedict["ftm"] = "/home/kdog3682/.vim/ftplugin/math.vim"
let g:filedict["ftt"] = "/home/kdog3682/.vim/ftplugin/txt.vim"
let g:filedict["jv"] = "/home/kdog3682/.vim/ftplugin/javascript.vim"
let g:filedict["cc"] = "/home/kdog3682/CWD/current-components.js"
let g:filedict["temp"] = "/home/kdog3682/CWF/template.html"
let g:filedict["u"] = "/home/kdog3682/CWF/public/utils.js"
let g:filedict["a2"] = "/home/kdog3682/CWF/app2.js"
let g:filedict["a1"] = "/home/kdog3682/CWF/app.js"
let g:filedict["reportlab"] = "/mnt/chromeos/MyFiles/Downloads/reportlab-userguide.pdf"
let g:filedict["pj"] = "/home/kdog3682/CWD/pdfgen.js"
let g:filedict["ps"] = "/home/kdog3682/CWD/pdfgen-state.js"
let g:filedict["pm"] = "/home/kdog3682/CWD/pdfgen-make.js"
let g:filedict["myf"] = "/home/kdog3682/files.json"
let g:filedict["myr"] = "/home/kdog3682/.reddit.json"
let g:filedict["bg"] = "/mnt/chromeos/MyFiles/Downloads/myext/background.js"
let g:filedict["ld"] = "/home/kdog3682/CWF/chrome-extensions-samples/mv2-archive/extensions/catblock/loldogs.js"
let g:filedict["mfj"] = "/home/kdog3682/CWF/chrome-extensions-samples/mv2-archive/extensions/email_this_page/manifest.json"
let g:filedict["ceem"] = "/home/kdog3682/CWF/chrome-extensions-samples/mv2-archive/extensions/email_this_page/background.js"
let g:filedict["ceem2"] = "/home/kdog3682/CWF/chrome-extensions-samples/mv2-archive/extensions/email_this_page/content_script.js"
let g:filedict["mecs"] = "/mnt/chromeos/MyFiles/Downloads/myext/content_script.js"
let g:filedict["myeo"] = "/mnt/chromeos/MyFiles/Downloads/myext/options.js"
let g:filedict["myebg"] = "/mnt/chromeos/MyFiles/Downloads/myext/background.js"
let g:filedict["o"] = "/mnt/chromeos/MyFiles/Downloads/myext/options.js"
let g:filedict["r2"] = "/home/kdog3682/CWD/raw2.js"
let g:filedict["r1"] = "/home/kdog3682/CWD/raw.js"
let g:filedict["cm"] = "/mnt/chromeos/MyFiles/Downloads/index.html"
let g:filedict["ou"] = "/home/kdog3682/CWF/utils.js"
let g:filedict["pubc"] = "/home/kdog3682/CWF/public/current.js"
let g:filedict["td"] = "/home/kdog3682/CWD/todo.js"
let g:filedict["ann"] = "/home/kdog3682/CWF/public2/annyang.js"
let g:filedict["rbu"] = "/home/kdog3682/CWF/rawbackup.js"
let g:filedict["de"] = "/mnt/chromeos/MyFiles/Downloads/demo.js"
let g:filedict["pd"] = "/home/kdog3682/CWF/public/demo.js"
let g:filedict["pdh"] = "/home/kdog3682/CWF/public/demo.html"
let g:filedict["ih"] = "/home/kdog3682/CWF/public/index.html"
let g:filedict["dh"] = "/home/kdog3682/CWF/public/demo.html"
let g:filedict["node"] = "node_modules"
let g:filedict["npj"] = "/home/kdog3682/CWF/generator/node_modules/rollup-plugin-typescript2/node_modules/tslib/package.json"
let g:filedict["pa"] = "/home/kdog3682/CWF/public/annyang.js"
let g:filedict["ij2"] = "/home/kdog3682/CWF/public/index2.js"
let g:filedict["cmp"] = "/home/kdog3682/CWF/cmparser.js"
let g:filedict["d2"] = "/home/kdog3682/CWF/public/demo2.html"
let g:filedict["sa"] = "/home/kdog3682/CWF/public/socket-action.js"
let g:filedict["pup"] = "/home/kdog3682/CWF/public/puppet.js"
let g:filedict["gram"] = "/home/kdog3682/CWF/gram.lang"
let g:filedict["jsa"] = "/home/kdog3682/CWD/jsa.js"
let g:filedict["sr"] = "/home/kdog3682/CWF/public/sr.js"
let g:filedict["s2"] = "/home/kdog3682/CWF/scratchpad2.js"
let g:filedict["nu"] = "/home/kdog3682/CWF/public/node-utils.js"
let g:filedict["fb"] = "/home/kdog3682/CWF/public/file-builder.js"
let g:filedict["ht"] = "/home/kdog3682/CWF/public/html-transform.js"
let g:filedict["t5"] = "/home/kdog3682/CWF/public/t5.js"
let g:filedict["anime"] = "/home/kdog3682/CWF/public/anime.js"
let g:filedict["th"] = "/home/kdog3682/CWF/public/t5.html"
let g:filedict["foo"] = "/home/kdog3682/CWF/foo"
let g:filedict["ch"] = "/home/kdog3682/CWD/css-helpers.js"
let g:filedict["hh"] = "/home/kdog3682/CWD/html-helpers.js"



nnoremap ar :call SayHi()<CR>
nnoremap q3r :call SayHi()<CR>
nnoremap go :call GoToFunction()<cr>
nnoremap <leader>/ :call LeaderManager2('')<left><left>
nnoremap 1 :call OneRunner()<CR>
nnoremap <C-c> :call FunctionRunner()<cr>
nnoremap <c-k><c-m> :call ToggleKeyMap()
nnoremap <f1> :w<CR>:!clear;node %<CR>
nnoremap <f2> :w<CR>:!clear;node %<CR>
nnoremap <f8> :w<cr>:call FunctionCaller()<cr>
nnoremap <f9> :w<cr>:source ~/.vimrc<cr>
nnoremap <silent>  <C-B>  /?
nnoremap <silent>  <C-l>  :call BackupFile()<CR>
nnoremap j :m +1<CR>
nnoremap k :m -2<CR>
nnoremap - :w<cr>:bd<CR>
nnoremap 0 :bn<CR>
nnoremap = :call MoveBack()<cr>
nnoremap 1 :w<CR>:!clear;python3 %<CR>
nnoremap 3 :call LineCommenter()<cr><down>
nnoremap 4 :call FourSearch('')<left><left>
nnoremap 5 /^\.
nnoremap 5 :call FiveSearch('', '5')<left><left><left><left><left><left><left>
nnoremap 6 :call FiveSearch('', '6')<left><left><left><left><left><left><left>
nnoremap 6 :call ResetToStandardBuffers()<cr>
nnoremap 6 :call SmartNav()<cr>
nnoremap 8 :call ChooseBuffer2('')<left><left>
nnoremap 9 :bp<CR>
nnoremap 9 :w<cr>:bd<cr>
nnoremap < :call SmartIndent()<cr>
nnoremap <C-H> <C-W><C-H>G
nnoremap <C-L> <C-W><C-L>G
nnoremap <F4> yyp
nnoremap <a-d> VGx
nnoremap <c-n> /^\(function\\|def\\|class\)<cr><down><down><down><down>
nnoremap <f10> :w<cr>:source ~/.vimrc<cr>
nnoremap <f3> :call LineCommenter()<cr><down>
nnoremap <f6> :call F6ify('')<left><left>
nnoremap <f6> :w<cr> :call EnterBlockExpression()<cr>
nnoremap <f7> :w<cr>:call StyleShunt('d grid  gtc 1fr')<cr>
nnoremap <leader>b :e ~/.bash_aliases<cr>
nnoremap <leader>d :w<cr>:e ~/CWF/derived.py<cr>
nnoremap <leader>e :call EditManager('')<left><left>
nnoremap <leader>g :call Grab('')<left><left>
nnoremap <leader>h :help
nnoremap <leader>m :call TextSelect('')<left><left>
nnoremap <leader>m :messages
nnoremap <leader>m :messages<cr>
nnoremap <leader>o :call OpenBufferGroup('')<left><left>
nnoremap <leader>o :call OpenLocalFile()<cr>
nnoremap <leader>p :call Prettier()<cr>
nnoremap <leader>p :w<cr>:e ~/CWF/storage.py<cr>
nnoremap <leader>q :call AskQuestion()<cr>
nnoremap <leader>r diwi
nnoremap <leader>u :! python3 update.py
nnoremap <leader>w :call VueFix()<cr>
nnoremap <localleader>a :call AddImportStatement()<cr>
nnoremap <localleader>cs :call CreateScript()<cr>
nnoremap <localleader>gt :call GoTo()<cr>
nnoremap <localleader>lp :call MarkLastPosition()<cr>
nnoremap <localleader>mv :call MoveItemsToNewLocation('')<left><left>
nnoremap <silent> db :call DeleteBlock()<cr>
nnoremap <silent> dm :call Deleter()<cr>
nnoremap <silent> rp :call RpwoBlock()<cr>
nnoremap <silent> tt :call FnDocTest()<cr>i
nnoremap <silent> xp :call PasteBlock()<cr>
nnoremap <silent> zp :call ReplaceBackwards()<cr>i
nnoremap H :call MovementManager()<cr>a
nnoremap N :call Goto()<cr>
"nnoremap e :e! ./
nnoremap f dd
nnoremap gs :call GoStart()<cr><down>o
nnoremap gf :call GoHtmlBackward()<cr>i
nnoremap gn :call GoNext()<cr>
nnoremap gt :call GoTop()<cr>i
nnoremap gu :call GoUp()<cr>
nnoremap h 'ho
nnoremap tl :call TrackedLog()<cr>
nnoremap z0 :! python3 foo.py<cr>
nnoremap za :call QuestionShifter('')<left><left>
nnoremap za :call QuestionShifter()<cr>
nnoremap zc :! python3 foo.py
nnoremap ze :call FileOpener()<cr>
nnoremap zg :call ShuntAndGoTo('')<left><left>
nnoremap zi :call AddImportStatement('')<cr>
nnoremap zi :call AddImportStatement()<cr>
nnoremap zm :! python3 foo.py<cr>
nnoremap zn :call WriteNote('')<left><left>
nnoremap zq :call ShuntFunction()<left><left>
nnoremap zr :call Read('')<left><left>
nnoremap zr :call Replacer("")<left><left>
nnoremap zs :call ShuntManager('')<left><left>
nnoremap zt :%s/\n"fooyum//g<cr>
nnoremap zt :%s/\n\ze\n\n//g<cr>
nnoremap zv /^Vue.prototype.
nnoremap zx :call VueManager('')<cr>
nnoremap 3 /^    def
nnoremap 3 /^ \+\(:\|(\)<left><left><left><left><left><left><left><left>
nnoremap 4 /^\(const\\|var\\|def\\|class\\|async function!\?\\|function!\?\) \$\?
nnoremap 5 /^    \(\/\/ \)\=\(function \)\=\w*(<left><left><left><left>
nnoremap 5 /^    \(\(\/\/ \)\=\(function \)\=\\|\(foooo\\|""""\\|sdfsdf\)\)\w*(<left><left><left><left>
nnoremap 5 /\(^    \(\/\/ \)\=\(function \)\=\\|\(foooo\\|"\\|sdfsdf\)\)\w*(<left><left><left><left>
nnoremap 5 /\(^    \(\/\/ \)\=\(function \)\=\\|^ *\(foooo\\|""""\\|asdf\\|\/\/\/\/\\|sdfsdf\\|####\)\)\w*\((\\|$\)/e<left><left><left><left><left><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT>
nnoremap 6 /^    \(def \)\=\w*\><left><left><left><left><left>
nnoremap <leader>r <esc>diwi
nnoremap <silent> tp :call TestPrint()<cr>
nnoremap <c-cr> :call JsAnywhere()<cr>
nnoremap L :update<CR>call JsAnywhere()<cr>
nnoremap K :call LastCommand()<cr>
nnoremap J :update<CR>call RunAddToBottomThenCall()<cr>
nnoremap gb :call GoBottom()<cr>i
nnoremap gb Go<CR><CR>
nnoremap b ?^\/\/\w<CR>
nnoremap b :call SearchFromStart() <CR>
nnoremap dnv :call DeclareNewVersion() <CR>
nnoremap gc :call DeleteCurrentBlock()<CR>
nnoremap <localleader>o :call SaveCurrentFileAndOpenHtmlFile()<cr>
nnoremap <silent> to :call TestPrint(1)<cr>
nnoremap <leader>n :call WriteCodeNotes("")<left><left>
nnoremap <localleader>a :call MarkInteresting()<cr>
nnoremap <localleader>w :call EditConnector('jsa')<CR>
nnoremap zx :call NextBlock()<CR>A
nnoremap <leader>p :call GetSetPartsHandler()<CR>A
nnoremap <localleader>q :call QuoteHelper()<cr>
nnoremap <silent> <localleader>q :call LineSetter('QuotifyWordUnderCursor')<CR>
nnoremap zc :call InsertAtLocation()<CR>
nnoremap zg :call ZBookmarkGetter()<CR>i
nnoremap zs :call ZBookmarkSetter()<CR>
nnoremap 3 /^\("\\|baaaaa\\|\/\/\\|aaaaaaaaaaaa\)custombookmark<CR>
nnoremap 2 :call Append('//custombookmark' . ' ' . GetBookMarkName() . ' ' . DateStamp() )<CR>
nnoremap 2 /^"\?    \(async \)\?
nnoremap <silent> <localleader>p :call LineSetter('Boopster')<CR>
nnoremap <silent> <localleader>g G?throw<CR><UP><UP>
nnoremap 3 /^\("\\|baaaaa\\|\/\/\\|aaaaaaaaaaaa\)custombookmark<CR>
nnoremap 3 /^\(const\\|def\\|class\\|async function\\|function\) \$\?.\{-\}marked<LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT>
nnoremap <localleader>w :call EditConnector('jsa')<CR>
nnoremap <silent> <localleader>m :call MarkLineForBookmark()<CR>
nnoremap <silent> <localleader>m A /* marked */<ESC>
nnoremap <silent> <localleader>p :call LineSetter('EasyP')<CR>
nnoremap 1 :call RunPythonOrNode()<cr>
nnoremap = :e#<CR>
nnoremap ; :
nnoremap <f7> :w<CR>:call SunCaller("")<LEFT><LEFT>
nnoremap <f6> :w<CR>:call SunCaller()<CR>
nnoremap 2 /^    \(def \\|async \)\?.\{-\}[\:\{]<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
nnoremap df I<esc>DA
nnoremap zp ?const<CR>o    ai<esc>:call PySnippet()<CR>
nnoremap zg :call ZGoMarked()<CR><DOWN><DOWN><DOWN>
nnoremap zf :call ZFind('')<LEFT><LEFT>
nnoremap z3 :call LineCommenter()<cr><down>
nnoremap zv yyp
nnoremap r1 diwa$1
nnoremap zm :call LineSetter('ZMark', 'above')<CR>
nnoremap zn :call LineSetter('ZNameMark', 'above')<CR>
nnoremap <leader>n :call WriteCodeNotes("")<left><left>
nnoremap <leader>n :call WriteNotes("")<left><left>
nnoremap zs :call LineSetter('ZSee', 'above')<CR>
nnoremap zw :call LineSetter('ZTest', 'bottom', 1)<CR>
nnoremap zd :call LineSetter('Zditto', 'below', 1)<CR>
nnoremap zb :call LeaderFunctionController('ZBookmark')<CR>:w ~/.vimrc<CR>
"nnoremap e :call ChangeFile("")<LEFT><LEFT>
nnoremap 0 :call NextFile()<cr>
nnoremap z/ ?\(let\\|const\)
nnoremap ls :buffers<cr>
nnoremap zt G?\/\/<CR>o<CR>
nnoremap zb G?^  *\S<CR>o
nnoremap zi :call AddIabItem()<cr>
nnoremap 1 :w<CR>:call RunPythonOrNode()<CR>
nnoremap . /\/\/ *1234<LEFT><LEFT><LEFT><LEFT>
nnoremap <silent> <localleader>s :call GetSet2('SpanifyRunner', CurrentWord())<CR>
nnoremap <leader>. :call LeaderManager('')<left><left>
nnoremap <leader>l :call MorningLog('')<left><left>
nnoremap zo :call ZO()<CR>
nnoremap q :call LineSetter('ZInvivoFixJS')<CR>o
nnoremap q :call SpecialEnter()<CR>
nnoremap zs :call ShuntToFile(GetCodeIndexes())<CR>
nnoremap c :call LineSetter('AddOrRemoveComment')<cr><down>
nnoremap c :call ToggleComment999()<CR><DOWN>
nnoremap ga :call GoToFunctionRightAbove()<cr>
nnoremap zm z-
nnoremap zw :call WrapIt()<CR>
nnoremap q :ec SayHi()<CR>
nnoremap q /\<\><LEFT><LEFT>
nnoremap <f2> :call JsAnywhere()<cr>
nnoremap <f2> :call InvivoJs()<cr>
nnoremap zs :call ShuntBlock()<cr>
nnoremap 7 :call GoToFileAndThenGoToFunction("")<LEFT><LEFT>
nnoremap dsl :call DefineSnippetFromCurrentLine()<CR>
nnoremap dsw :call DefineSnippetFromFile()<CR>
nnoremap dsw :call DefineSnippetFromWord()<CR>
nnoremap <F2> :call JSA()<CR>
nnoremap gf :call GoFile()<CR>
nnoremap <c-c> :call CommentOutConsole()<CR>
nnoremap da da'
nnoremap zc :call ChangeDir()<CR>
nnoremap ttb :call ToTempBuffer()<CR>
nnoremap zm :call MoveFunction('')<LEFT><LEFT>
nnoremap za :call ZAction()<CR>
nnoremap tfl :call ToFunctionLine()<CR>
"nnoremap <S-RIGHT> :call IncrementFile()<CR>
"nnoremap <S-LEFT> :call DecrementFile()<CR>
nnoremap <s-s> :call SaveBackup0104()<CR>
nnoremap zm :call Zmark()<CR>
nnoremap zp :call PrintLineNumber()<CR>
nnoremap b :call BookmarkManager('')<LEFT><LEFT>
nnoremap zt G "for testing purposes
nnoremap zt yy:@"
nnoremap <leader>g :call Google("")<LEFT><LEFT>
nnoremap <leader>v :w<cr>:e ~/.vimrc<cr>gg
nnoremap <leader>v :call OpenVim()<CR>
nnoremap <leader>a :call LeaderManager('ask ')<LEFT><LEFT>
nnoremap <leader>d :call WriteNotes('doc ')<LEFT><LEFT>
nnoremap zt :%s/<C-R><C-W>//gc<Left><Left><Left><Backspace>/
nnoremap zt :%s/<C-R><C-W>//<Left><Backspace>/
nnoremap b :call BookmarkManager2('')<LEFT><LEFT>
nnoremap <leader>1 :call XdgOpen('/home/kdog3682/CWD/template.html')<CR>
nnoremap <s-s> :w<CR>:call SaveBackup0104()<CR>:bd<CR>
nnoremap <leader>a :call JspyConnector('fa', "")<LEFT><LEFT>
nnoremap zt gg
nnoremap zt gg
nnoremap zt gg
nnoremap zt gg
nnoremap zt gg
nnoremap b /<C-R><C-W><CR>
nnoremap <leader>j :update<CR>:call JspyConnector("")<LEFT><LEFT>
nnoremap qt :call Tildaify()<CR>
nnoremap ws :u<CR>
nnoremap <leader>b :call BookmarkManager2('')<LEFT><LEFT>
nnoremap <s-j> :@:1<CR>
nnoremap 3 ?\v<><LEFT>
nnoremap zs :w<CR>
nnoremap <s-s> :update<CR>
nnoremap <s-l> :@:1<CR> " SHIFT-L for LastCommand
nnoremap <s-w> :update<CR>
nnoremap s :update<CR>
nnoremap 6 ?^\><LEFT><LEFT>
nnoremap <F2> :call JspyConnector('jsa')<CR>
nnoremap 3 /^    \(def \\|async \)\?_\{1,\}.\{-\}[\:\{]<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
nnoremap tb :call TransferBlock()<CR>
nnoremap 5 /^\(const \)\? <left>
nnoremap <s-r> :call JspyConnector('reply')<CR>
nnoremap <f1> :w<CR>:call RunPythonOrNode('js')<CR>
nnoremap 2 :w<CR>:call RunPythonOrNode('js')<CR>
nnoremap gm :call GoMethod()<CR>
nnoremap lo :call LogIt('gen')<CR>
nnoremap tl :call LogIt('tl')<CR>
nnoremap rl :call RemoveLogs()<CR>
nnoremap ai :call AddJsImports()<CR>
nnoremap am :call AddJsMethod()<CR>
nnoremap <silent> gf :call GoFileOrFunction()<CR>
nnoremap am :call AddModuleExport()<CR>
nnoremap <buffer> qn A "nice<esc> "nice
nnoremap qd :call MoveLineToPreviousEnd()<CR>
nnoremap 7 :call CreateJSApp('')<LEFT><LEFT>
nnoremap q' ciw''<esc>P
nnoremap gh :call FileFromCurrentFile()<CR>
nnoremap qa Dax)<esc>Ox = <esc>px
nnoremap b <C-O>
nnoremap 7 :call Chdir('pub')<LEFT><LEFT>
nnoremap de ^Di
nnoremap qgn :call QGetName()<CR>
nnoremap qcs :call QCreateScript()<CR>
nnoremap h <C-I>
nnoremap q1 :call Registrar('')<left><left>
nnoremap qqf /\<fc\><cr>
nnoremap qqc :call AppendAbove(Comment('fc'))<cr>
nnoremap zd <esc>:call NormalHandler('WriteDitto')<CR>A
nnoremap <expr> <TAB> AutoTab()
nnoremap <silent> aar :call AddRequireItem()<CR>
nnoremap az :call AppendBelowMarkZ()<CR>
nnoremap la :!ls<CR>
nnoremap qi1 :call I1()<CR>
nnoremap qs1 :call S1()<CR>
nnoremap qrw :call ReplaceWordUnderCursor3()<CR>
nnoremap qgr :call Qgr()<CR>
nnoremap qj :w<CR>:call QJConnector()<CR>
nnoremap lx :call Unlog()<CR>
nnoremap q1j :call PuppetRunner()<CR>
nnoremap wa :wa<CR>
nnoremap ar :call AddReq()<CR>
nnoremap f dd
nnoremap 7 :call Chdir('pub')<cr>
nnoremap ac :call AddComponentList()<CR>
nnoremap tp :call TestPrint2()<CR>
nnoremap ld :call LeaderManager100('')<LEFT><LEFT>
nnoremap go :call GoFunction()<CR>
nnoremap gl :call GoLambdaFunction()<CR>
nnoremap <leader>A :w<CR>:call Node("/home/kdog3682/CWF/public/appendself.js", CurrentFile())<CR>
nnoremap zrw :call ReplaceWordUnderCursor100()<CR>
nnoremap gs :call GoScratchpad()<CR>
nnoremap <leader>. :call LeaderManager100('')<LEFT><LEFT>
nnoremap ad <CR>:call AddDictItemToJavascriptDictionary()<CR>
nnoremap <silent> J :w<CR>:call JsConnector()<CR>
nnoremap gu <UP><CR>:call GoUtils()<CR>
nnoremap ge <CR>:call GoError()<CR>
nnoremap gc <CR>:call GoConsole()<CR>
nnoremap zr <CR>:call Reset()<CR>
nnoremap lp <UP><CR>:call LogIt('lp')<CR>
nnoremap ld <UP><CR>:call LogIt('ld')<CR>
nnoremap ll <UP><CR>:call LogIt('ll')<CR>
nnoremap l0 <UP><CR>:call LogIt('l0')<CR>
nnoremap gx <UP><CR>:call GoToFileAndThenFunction()<CR>
nnoremap R :call Registrar('')<LEFT><LEFT>
nnoremap lf <UP><CR>:call LogIt('lf')<CR>
nnoremap gf :call GoFile()<CR>
nnoremap gb G
nnoremap <leader>i <esc>:call OpenHtml()<cr>
nnoremap gw :call GoToWordUnderCursor()<CR>
"nnoremap qrn :call Qrn()<CR>
nnoremap 3 :wa<CR>:call Node('/home/kdog3682/CWF/public/TextEditor.js', CurrentFile())<CR>
nnoremap lo <UP><CR>:call LogIt('lo')<CR>
nnoremap lg <UP><CR>:call LogIt('lg')<CR>
nnoremap gf :call GoFile()<CR>
nnoremap J :w<CR>:call Node('/home/kdog3682/CWF/public/TextEditor.js', CurrentFile(), 'jsa')<CR>
nnoremap lt <UP><CR>:call LogIt('lt')<CR>
nnoremap zs :call Set('')<LEFT><LEFT>
nnoremap 7 :call Dog()<CR>
nnoremap er :call ExecuteReplace100('')<LEFT><LEFT>
nnoremap 6 :call GoToScratchpad()<CR>
nnoremap <leader>a :call ActivityInfo()<CR>
nnoremap gb ?^function<CR>
nnoremap ar :call AddRequireItemToTAndU()<CR>
nnoremap ; :call AnythingHandler('')<LEFT><LEFT>
nnoremap q" Is = "<ESC>A"
nnoremap lr <UP><CR>:call LogIt('lr')<CR>
nnoremap gp :call GoP()<CR>
nnoremap <leader>b :call ReturnPosition()<CR>
nnoremap ap :call AppendPupFast()<CR>
nnoremap le <UP><CR>:call LogIt('le')<CR>
nnoremap zrl :call Zrl()<CR>
nnoremap <c-s> :call SaveBackup0104()<CR>
nnoremap qad :call Qad()<CR>
nnoremap <leader>g :call GTFGTF("")<LEFT><LEFT>
nnoremap ar :call AddAtInsertionPoint()<CR>
nnoremap <leader>o :call JspyConnector('openfile ' . CurrentFile())<CR>
nnoremap tq :wa<CR>:call JspyConnector('ask')<CR>
nnoremap tc :wa<CR>:call JspyConnector('ic')<CR>
nnoremap t1 :wa<CR> :call Node('/home/kdog3682/CWF/public/print.js')<CR>
nnoremap tn :call TNote()<CR>
nnoremap lh <UP><CR>:call LogIt('lh')<CR>
nnoremap S :call Python(CurrentFile())<CR>
nnoremap 4 /^\(const\\|var\\|def\\|class\\|async function\\|function\) \$\?_\?
nnoremap <leader>j :wa<CR>:call BasePY('')<LEFT><LEFT>
noremap le :call append('.', JSPY('log'))<CR><DOWN>A<LEFT>
nnoremap rl :call ReadLast()<CR>
nnoremap rb :w<CR>:call Python('base.py')<CR>
nnoremap <leader>w :call WriteNotes3('')<LEFT><LEFT>
nnoremap <leader>o <esc>:call BasePY("ofile " . CurrentFile())<CR>


let g:filedict["."] = "xpres"
let g:filedict["."] = "public2 serv.js"
let g:filedict["aj"] = "/home/kdog3682/CWF/public/apps.js"
let g:filedict["t"] = "/home/kdog3682/CWF/public/TextEditor.js"
let g:filedict["cu"] = "/home/kdog3682/CWF/public/css-utils.js"
let g:filedict["ch"] = "/home/kdog3682/CWF/public/css-utils.js"
let g:filedict["he"] = "/home/kdog3682/CWF/public/html-edit.js"
let g:filedict["ou"] = "/home/kdog3682/CWF/utils.js"
let g:filedict["vue"] = "/home/kdog3682/CWF/public/vuetify.js"
let g:filedict["i"] = "/home/kdog3682/CWF/public/index.html"
let g:filedict["ec"] = "/home/kdog3682/CWF/element-controller.js"
let g:filedict["ec"] = "/home/kdog3682/CWF/public/element-controller.js"
let g:filedict["ec"] = "/home/kdog3682/CWF/public/element-controller.js"
let g:filedict["vd"] = "/home/kdog3682/CWF/vim-dictionaries.vim"
let g:filedict["voi"] = "/home/kdog3682/CWF/public/voice-to-command.js"
let g:filedict["iab"] = "/home/kdog3682/CWF/iab.vim"
let g:filedict["h"] = "/home/kdog3682/CWF/public/element-controller.js"
let g:filedict["ljs"] = "/home/kdog3682/CWF/public/learning.js"
let g:filedict["norm"] = "/home/kdog3682/CWF/public/normalize.css"
let g:filedict["cmc"] = "/home/kdog3682/CWF/public/codemirror-component.js"
let g:filedict["mu"] = "/home/kdog3682/CWF/public/math-utils.js"
let g:filedict["le"] = "/home/kdog3682/CWF/public/learning.js"
let g:filedict["pu"] = "/home/kdog3682/CWF/public/prose-utils.js"
let g:filedict["pdfgen"] = "/home/kdog3682/CWF/public/playground.js"
let g:filedict["bkl"] = "/home/kdog3682/CWF/bkl.py"
let g:filedict["vu"] = "/home/kdog3682/CWF/public/vue-utils.js"
let g:filedict["sl"] = "/home/kdog3682/CWF/public/script-loader.js"
let g:filedict["fn"] = "/home/kdog3682/CWF/public/fn.json"
let g:filedict["sl"] = "/home/kdog3682/CWF/public/file-loader.js"
let g:filedict["ju"] = "/home/kdog3682/CWF/public/jsxgraph-utils.js"
let g:filedict["nerd"] = "/home/kdog3682/CWF/public/nerdamer-utils.js"
let g:filedict["mt"] = "/home/kdog3682/CWF/public/math-transform.js"
let g:filedict["qg"] = "/home/kdog3682/CWF/public/question-generator.js"
let g:filedict["t6"] = "/home/kdog3682/CWF/public/t6.js"
let g:filedict["t6c"] = "/home/kdog3682/CWF/public/t6components.js"
let g:filedict["md"] = "/home/kdog3682/CWF/math.dict"
let g:filedict["pmu"] = "/home/kdog3682/CWF/public/prosemirror-utils.js"
let g:filedict["r2"] = "/home/kdog3682/CWF/public/r2.html"
let g:filedict["pmh"] = "/home/kdog3682/CWF/public/pm-helpers.js"
let g:filedict["tD"] = "/home/kdog3682/CWF/public/t.drafts.js"
let g:filedict["rD"] = "recursive.drafts.js"
let g:filedict["r3h"] = "/home/kdog3682/CWF/public/r3.html"
let g:filedict["r3c"] = "/home/kdog3682/CWF/public/r3c.js"
let g:filedict["scra"] = "/home/kdog3682/CWF/scrape.py"
let g:filedict["fi"] = "folder-info.json"
let g:filedict["scss"] = "/home/kdog3682/CWF/public/s.css"
let g:filedict["cmh"] = "/home/kdog3682/CWF/public/cm.html"
let g:filedict["git"] = "/home/kdog3682/CWF/githubscript.py"
let g:filedict["sc"] = "/home/kdog3682/CWF/public/styles.css"
let g:filedict["vtc"] = "/home/kdog3682/CWF/public/voice-to-command.js"
let g:filedict["bfe"] = "/home/kdog3682/CWF/public/browser-file-editor.js"
let g:filedict["cm"] = "/home/kdog3682/CWF/public/cm.js"
let g:filedict["lu"] = "/home/kdog3682/CWF/public/lezer-utils.js"
let g:filedict["lud"] = "/home/kdog3682/CWF/public/lezer-utils.js.draft"
let g:filedict["g"] = "/home/kdog3682/CWF/public/github.js"
let g:filedict["lud"] = "/home/kdog3682/CWF/public/lud.js"
let g:filedict["cmu"] = "/home/kdog3682/CWF/public/cm-utils.js"
let g:filedict["sm"] = "/home/kdog3682/CWF/public/snippet-manager.js"
let g:filedict["cu"] = "/home/kdog3682/CWF/public/cm-utils.js"
let g:filedict["su"] = "/home/kdog3682/CWF/public/string-utils.js"
let g:filedict["cr"] = "/home/kdog3682/CWF/public/code-runner.js"
let g:filedict["env"] = "/home/kdog3682/CWF/env.py"
let g:filedict["ih"] = "/home/kdog3682/CWF/public/input-handlers.js"
let g:filedict["p"] = "/home/kdog3682/CWF/public/puppet.js"
let g:filedict["ec"] = "/home/kdog3682/CWF/public/ec.js"
let g:filedict["ec2"] = "/home/kdog3682/CWF/public/element-controller.js"
let g:filedict["scrape"] = "/home/kdog3682/CWF/scrape.py"
let g:filedict["ref"] = "/home/kdog3682/CWF/public/refs.js"
let g:filedict["r4"] = "/home/kdog3682/CWF/public/r4.js"
let g:filedict["r4l"] = "/home/kdog3682/CWF/public/r4leftovers.js"
let g:filedict["r4h"] = "/home/kdog3682/CWF/public/r4.html"
let g:filedict["r6h"] = "/home/kdog3682/CWF/public/r6.html"
let g:filedict["r6"] = "/home/kdog3682/CWF/public/r6.js"
let g:filedict["mc"] = "/home/kdog3682/CWF/public/math-components.js"
let g:filedict["h"] = "/home/kdog3682/CWF/public/h.js"
let g:filedict["voice"] = "/home/kdog3682/CWF/public/voice-callbacks.js"
let g:filedict["a"] = "/home/kdog3682/CWF/apps.py"
let g:filedict["H"] = "/home/kdog3682/CWF/public/r4.html"
let g:filedict["css"] = "/home/kdog3682/CWF/public/css.css"
let g:filedict["cu"] = "/home/kdog3682/CWF/public/color-utils.js"
let g:filedict["lego"] = "/home/kdog3682/CWF/public/lego.js"
let g:filedict["le"] = "/home/kdog3682/CWF/public/lego.js"
let g:filedict["ms"] = "/home/kdog3682/CWF/public/my-strings.js"
let g:filedict["mp"] = "/home/kdog3682/CWF/math-packages.js"
let g:filedict["hp"] = "/home/kdog3682/CWF/html-packages.js"
let g:filedict["le"] = "/home/kdog3682/CWF/public/learning.js"
let g:filedict["ru"] = "/home/kdog3682/CWF/reportlab-utils.py"
let g:filedict["rlc"] = "/home/kdog3682/CWF/reportlab-current.py"
let g:filedict["rh"] = "/home/kdog3682/CWF/public/r4.html"
let g:filedict["ou"] = "/home/kdog3682/CWF/jch/utils.js"
let g:filedict["fpdf"] = "/home/kdog3682/CWF/jch/fpdf.js"
let g:filedict["cl"] = "/home/kdog3682/CWF/jch/classroom.js"
let g:filedict["a1"] = "/home/kdog3682/CWF/jch/app.js"
let g:filedict["si"] = "/home/kdog3682/CWF/public/build/index.html"
let g:filedict["temp"] = "/home/kdog3682/CWF/public/temp.json"
let g:filedict["dia"] = "/home/kdog3682/CWF/public/dialogue.js"
let g:filedict["mp"] = "/home/kdog3682/CWF/public/math-prose.js"
let g:filedict["r5"] = "/home/kdog3682/CWF/public/r5.html"
let g:filedict["pdfu"] = "/home/kdog3682/CWF/pdf_utils.py"
let g:filedict["foo"] = "/home/kdog3682/CWF/public/foo.json"
let g:filedict["print"] = "/home/kdog3682/CWF/public/print.js"
let g:filedict["pr"] = "/home/kdog3682/CWF/public/print.js"
let g:filedict["geo"] = "/home/kdog3682/CWF/public/geometry.js"
let g:filedict["tf"] = "/home/kdog3682/CWF/public/tempfiles.txt"
let g:filedict["piph"] = "/home/kdog3682/pip.history"
let g:filedict["b"] = "/home/kdog3682/CWF/base.py"
let g:filedict["prep"] = "/home/kdog3682/CWF/public/prepare-reddit.js"
let g:filedict["r6"] = "/home/kdog3682/CWF/public/r6.html"
let g:filedict["aj"] = "/home/kdog3682/CWF/a.js"
let g:filedict["bj"] = "/home/kdog3682/CWF/public/b.js"
let g:filedict["aj"] = "/home/kdog3682/CWF/public/a.js"
let g:filedict["save"] = "/home/kdog3682/CWF/public/html-utils.js"
let g:filedict["dj"] = "/home/kdog3682/CWF/public/d.js"
let g:filedict["mcl"] = "/home/kdog3682/CWF/public/mycodelog.txt"
let g:filedict["chi"] = "/home/kdog3682/CWF/public/chinese.txt"


let g:autotabdict['vim']['ef'] = "\<CR>\<BS>endif\<CR>"
let g:snippetFunctionalInsertion['currentfiles'] = 'GetCurrentBuffersAsString'
let g:quoteRE = '[''"]\zs.{-}\ze[''"]'
let g:indexesdict['notes'] = 'GetNoteIndexes'
let g:indexesdict['innerfunction'] = 'GetInnerFunctionIndexes'
let g:dirdict['/home/kdog3682/CWF/public'] = '/home/kdog3682/CWF'
let g:dirdict['/home/kdog3682/CWF'] = '/home/kdog3682/CWF/public'
let g:ldrdict["exp"] = function("ExportFunction")
let g:ldrdict["npm"] = function("InstallNpm")
let g:ldrdict["rof"] = function("ReplaceOriginalFile")
let g:ldrdict[',1'] = function('Source')
let g:ldrdict['cca'] = function('CreateCodingArticle')
let g:ldrdict['cd'] = function('ToggleBufferWithinDirectory')
let g:ldrdict['cftr'] = function('CopyFileToRoot')
let g:ldrdict['dict'] = function('AddDictItem')
let g:ldrdict['hg'] = function('HerokuGit')
let g:ldrdict['rj'] = function('RunJS')
let g:ldrdict['rs'] = function('RunSelf')
let g:ldrdict['s'] = function('Source')
let g:ldrdict['shd'] = function('ShuntToD')
let g:ldrdict['so'] = function('SmartOpen')
let g:ldrdict['uy'] = function('UndoYeet')
let g:replacecdict['cff'] = {'fn': function('CreateFooFunction'), 'i': 'nolinebreak', 'args': 1}
let g:replacecdict['maker'] = {'fn': function('RunMultipleTests'), 'i': 'nolinebreak', 'args': 1}
let g:replacecdict['sh'] = {'fn': function('ShuntBlockToFile'), 'i': 'code', 'args': 1}
let g:ldrdict['r'] = function('ReadItem')
let g:ldrdict['a'] = function('ShuntAway')
let g:ldrdict['b'] = function('AppendBash')
let g:ldrdict2['a'] = function('ShuntAway')
let g:ldrdict2['k'] = function('FindLibKeys')
let g:ldrdict['jsr'] = function('JsRangeEdit')
let g:visualdict['k'] = function('PrintKeys') 
let g:ldrdict2['flk'] = function('FindLibKeys')
let g:ldrdict['fu'] = function('FindFunctionUp')
let g:visualdict['fzooo'] = function('TestFoo') 
let g:visualdict['fzoooo'] = function('TestFoo') 
let g:ldrdict2['fvb'] = function('FindVimBinding')
let g:visualdict['foooooo'] = function('TestFoo') 
let g:ldrdict['fd'] = function('FindFunctionDown')
let g:visualdict['g'] = function('GetVisualItem') 
let g:visualdict['foooooooo'] = function('TestFoo') 
let g:pydict["ifu"] = IfMaker('isUndefined')
let g:pydict["iffile"] = IfMaker('isfile')
let g:pydict["whereami"] = CommentBlock('$c')
let g:pydict["wami"] = CommentBlock('$c')
let g:pydict["ifnull"] = IfMaker('isNull')
let g:visualdict['fooooooooo'] = function('TestFoo') 
let g:visualdict['r'] = function('ReadItemFromSearch') 
let g:replacecdict['c'] = {'fn': function('CopyUp'), 'i': 'functionblock', 'args': 0}
let g:pydict["c"] = "const $1 =" . g:jsbe
let g:pydict["ifu"] = IfMaker('isUndefined')
let g:pydict["ifnest"] = IfMaker('isNestedArray')
let g:pydict["ifnull"] = IfMaker('isNull')
let g:pydict["ifr"] = IfMaker('isRegExp')
let g:ldrdict['td'] = function('TemplateDittoHandler')
let g:ldrdict['ec'] = function('EditConnector')
let g:ldrdict['pc'] = function('PythonConnector')
let g:ldrdict['al'] = function('AddLets')
let g:ldrdict['ai'] = function('AddImports2')
let g:ldrdict['ds'] = function('DeleteSave')
let g:ldrdict['sa'] = function('SelfAppend2')
let g:pydict["vueco"] = vueco
let g:pydict["vuec"] = vuec
let g:ldrdict['us'] = function('UnsetShortcuts')
let g:ldrdict['ss'] = function('SetShortcuts')
let g:ldrdict['scf'] = function('SaveCurrentFileToFileDict')
let g:ldrdict['map'] = function('CreateMapFunctionShortcut')
let g:ldrdict['ssq'] = function('SetSearchQuery')
let g:ldrdict['of'] = function('OpenFile2')
let g:ldrdict['h'] = function('Help2')
let g:ldrdict['st'] = function('ShuntTop')
let g:ldrdict['mvt'] = function('Movetop')
let g:ldrdict['mvup'] = function('Moveup')
let g:ldrdict['svf'] = function('SaveAndTrackNewEdit')
let g:ldrdict['chk'] = function('CheckIfDictHasKey')
let g:ldrdict['fd'] = function('FunctionDrafter')
let g:ldrdict['rt'] = function('Returnify')
let g:ldrdict['vf'] = function('Tovfor')
let g:ldrdict['db'] = function('DittoBlock')
let g:ldrdict['sh'] = function('SplitHtml')
let g:ldrdict['oh'] = function('OpenHtml')
let g:ldrdict['ts'] = function('ToggleSettings')
let g:ldrdict['up'] = function('MoveBlockUp')
let g:ldrdict['o'] = function('OpenFile2')
let g:ldrdict['ear'] = function('EditAppenderRegexes')
let g:ldrdict['rpw'] = function('RpwHelper')
let g:movementdict['kc'] = 'KeyController'
let g:movementdict['uj'] = 'UpdateJson'
let g:ldrdict['fa'] = function('FooAction')
let g:ldrdict['lv'] = function('LogVariable')
let g:ldrdict['bl'] = function('BlockifyCurrent')
let g:ldrdict['rfn'] = function('ReadFunctionNamesFromFile')
let g:ldrdict['rangify'] = function('Rangify')
let g:ldrdict['clf'] = function('CreateLibraryFile')
let g:ldrdict['jsr'] = function('JSLibRef')
let g:replacecdict['qu'] = {'fn': function('QuoteIntoArray'), 'i': 'block', 'args': 1}
let g:replacecdict['sj'] = {'fn': function('BlockIntoSJString'), 'i': 'block', 'args': 0}
let g:replacecdict['fnr'] = {'fn': function('RCFnReplace'), 'i': 'code', 'args': 1}
let g:replacecdict['vat'] = {'fn': function('VueAddTransition'), 'i': 'GetMatchingSpacesIndexes', 'args': 1}
let g:replacecdict['gb'] = {'fn': function('GrabBlock'), 'i': 'anyblock'}
let g:replacecdict['dgb'] = {'fn': function('GrabBlock'), 'i': 'spacing','mode': 'delete'}
let g:replacecdict['de'] = {'fn': function('Dedent'), 'i': 'anyblock', 'bookarla': 1, 'mode': 'gs'}
let g:replacecdict['m'] = {'fn': function('ReplaceCMover'), 'i': 'matching', 'bookarla': 1, 'mode': 'd'}
let g:replacecdict['m'] = {'fn': function('ReplaceCMover'), 'i': 'matching', 'bookarla': 1, 'mode': 'd'}
let g:ldrdict['sp'] = function('SaveProgress')
let g:ldrdict['fde'] = function('FindDictEntry')
let g:ldrdict['aps'] = function('AddPydictSingleton')
let g:replacecdict['sh'] = {'fn': function('ReplaceCShunt'), 'i': 'code', 'bookarla': 1, 'mode': 'asdf', 'arg': 1}
let g:replacecdict['ask'] = {'fn': function('AskQuestion2'), 'i': 'code', 'bookarla': 1, 'mode': 'lines', 'arg': 1}
let g:ldrdict['gn'] = function('GoodNight')
let g:ldrdict['save'] = function('SaveForLater')
let g:replacecdict['dda'] = {'fn': 'DedentLine', 'i': 'all', 'mode': 'gs'}
let g:replacecdict['sn'] = {'fn': 'ShuntNotes', 'i': 'notes', 'mode': 'delete'}
let g:replacecdict['mo'] = {'fn': 'MoveOutward', 'i': 'AnyFunctionBlockIndexes'}
let g:replacecdict['mi'] = {'fn': 'MoveIn', 'i': 'AnyFunctionBlockIndexes'}
let g:replacecdict['rc'] = {'fn': 'RemoveComment', 'i': 'GetScreenIndexes', 'wrapper': 'GSI'}
let g:replacecdict['rc'] = {'fn': 'RemoveCommentFromLines', 'i': 'GetScreenIndexes'}
let g:replacecdict['g'] = {'fn': 'GrabIndexes', 'i': 'GetMatchingSpacesIndexes'}
let g:replacecdict['c'] = {'fn': 'CopyUp', 'i': 'GetCodeIndexes'}
let g:replacecdict['de'] = {'fn': 'CopyUp', 'i': 'GetCodeIndexes'}
let g:replacecdict['t'] = {'fn': 'RunBlockTest', 'i': 'GetMatchingSpacesIndexes'}
let g:replacecdict['co'] = {'fn': 'ConditionalComment', 'i': 'GetContiguousIndexes', 'wrapper': 'GS4'}
let g:replacecdict['toobj'] = {'fn': 'CreateObject', 'i': 'GetContiguousIndexes'}
let g:replacecdict['invert'] = {'fn': 'AddOrRemoveComment', 'i': 'GetContiguousIndexes', 'wrapper': 'GS4'}
let g:replacecdict['sh'] = {'fn': 'ShuntToFile', 'i': 'GetCodeIndexes', 'arg': 1}
let g:replacecdict['cptf'] = {'fn': 'CopyToFile', 'i': 'GetCodeIndexes', 'arg': 1}
let g:replacecdict['wf'] = {'fn': 'WrapFunction', 'i': 'GetContiguousIndexes', 'arg': 1}
let g:replacecdict['el'] = {'fn': 'EditLine', 'i': 'GetContiguousSpacesIndexes', 'arg': 0, 'wrapper': 'GS4'}
let g:replacecdict['create'] = {'fn': 'CreateFileFromLine', 'i': 'GetContiguousSpacesIndexes', 'arg': 1}
let g:replacecdict['py'] = {'fn': 'VisualAddPyDictItem', 'i': 'GetContiguousSpacesIndexes', 'arg': 1}
let g:replacecdict['dictify'] = {'fn': 'LinesDictify', 'i': 'GetContiguousSpacesIndexes', 'arg': 0}
let g:replacecdict['narray'] = {'fn': 'LinesNarray', 'i': 'GetContiguousSpacesIndexes', 'arg': 0}
let g:replacecdict['rq'] = {'fn': 'ReplaceQuote', 'i': 'CurrentLine', 'arg': 1}
let g:replacecdict['d'] = {'fn': 'DedentBlock', 'i': 'GetCodeIndexes'}
let g:replacecdict['2sl'] = {'fn': 'ToSingleLine', 'i': 'GetPairedFromTopIndexes'}
let g:replacecdict['v2s'] = {'fn': 'V2Snippet', 'i': 'GetPairedFromTopIndexes', 'arg': 1}
let g:replacecdict['v2l'] = {'fn': 'V2Lines', 'i': 'GetContiguousSpacesIndexes', 'arg': 0}
let g:replacecdict['parse'] = {'fn': 'ReplaceCParse', 'i': 'GetContiguousSpacesIndexes', 'arg': 1, 'wrapper': 'GS4'}
let g:iabdict["pl"] = " + "
let g:iabdict["pe"] = " += "
let g:iabdict["eq"] = " == "
let g:iabdict["t."] = "this."
let g:iabdict["cle"] = "console.log(e)<CR>"
let g:iabdict['foo'] = "<!DOCTYPE html><html>\n<head>\n    <script src=\"vue.js\" charset=\"utf8\"></script>\n    <script src=\"katex.min.js\" charset=\"utf8\"></script>\n    <link href=\"katex.min.css\" rel=\"stylesheet\"/>\n</head>\n\n<body>\n    <div id=\"app\"></div>\n</body>\n\n\n<script>\n    \n\n</script>\n</html>"
let g:pydict["wh"] = function('WhileHandler')
let g:pydict["new"] = function('SnipTextNew')
let g:pydict["f"] = function('ForHandler')
let g:pythonsnippets['for'] = function('ForHandler')
let g:pythonsnippets['pcf'] = function('PySnippetConnector')
let g:pythonsnippets['check'] = function('CheckWithInputStop')
let g:snippetCompletionStartDict["trim"] = "s = s.strip()"
let g:snippetCompletionStartDict["rf"] = "return False"
let g:snippetCompletionStartDict["rf"] = "return False"
let g:mastersnippets["vim"]["zop"] = 'function'
let g:mastersnippets["vim"]["gfw"] = 'GetFirstWord()'
let g:mastersnippets["vim"]["cw"] = 'CurrentWord()'
let g:globalconfig["markit"] = 1
let g:mastersnippets["py"]["foo"] = "abc\nasdf"
let g:mastersnippets["py"]["pylibs"] = "from test import *\nfrom pprint import pprint as p\nimport time\nimport sys\nimport String\nimport webbrowser\nimport black\nfrom filesystem import *\n"
let g:globalwpdict["sayhi"] = "sayhi()"
let g:qqdict["GLOBALS.py"] = {"whf": "GLOBALS.WEBSITE_HELPER_FILES", "ce": "GLOBALS.CODE_EXTENSIONS", "m": "GLOBALS.messagelib", "c": "GLOBALS.commentlog"}
let g:mastersnippets["js"]["lec"] = "le.currentComponent"
let g:mastersnippets["py"]["asd"] = "dirinfo"
let g:dirdict["cwf"] = "/home/kdog3682/CWF"
let g:dirdict["a"] = "ASSETS"
let g:dirdict["8"] = "08-22-2021"
let g:dirdict["drive"] = "/mnt/chromeos/GoogleDrive/MyDrive/"
let g:dirdict["0104"] = "/mnt/chromeos/GoogleDrive/MyDrive/CWF/01-04-2022/"
let g:dirdict["drivecwf"] = "/mnt/chromeos/GoogleDrive/MyDrive/CWF"
let g:dirdict["cw"] = "/home/kdog3682/CWF"
let g:dirdict["trash"] = "/home/kdog3682/CWF/TRASH"
let g:dirdict["."] = "/home/kdog3682/CWF"
let g:dirdict["cwd"] = "/home/kdog3682/CWD"
let g:dirdict["''"] = "/home/kdog3682/CWF"
let g:dirdict["macbook"] = "/users/harfunmaterials/"
let g:dirdict["dl"] = "/mnt/chromeos/MyFiles/Downloads/"
let g:dirdict["downloads"] = "/mnt/chromeos/MyFiles/Downloads/"
let g:solsnippets["vim"]["lines"] = "let lines = GetLines()"    
let g:markdict['PySnippet'] = 'B'
let g:ldrdict['aps'] = function('AddPySingleton')
let g:vimsnippets['re'] = 'RegexBuilder'
let g:markdict['RegexBuilder'] = 'C'
let g:markdict['CreateFunctionBlock'] = 'D'
let g:markdict['BookmarkManager'] = 'E'
let g:markdict['Storage'] = 'F'
let g:markdict['ObjectStorage'] = 'G'
let g:markdict['RegexBuilder'] = 'H'
let g:markdict['PySnippet'] = 'I'
let g:wpsnippets["py"]["read"] = "PyReader"
let g:markdict['FileGetter2'] = 'J'
let g:wpsnippets["py"]["fkv"] = "for k,v in $1.items():\n    $c"
let g:wpsnippets["py"]["fab"] = "for a,b in $1:\n    $c"
let g:wpsnippets["py"]["fi"] = "for i ,${GetForIterationVariable($1)} in enumerate($1):\n    $c"
let g:wpsnippets["py"]["f"] = "for ${GetForIterationVariable($1)} in $1:\n    $c"
let g:wpsnippets["py"]["w"] = "while True:\n    $c"
let g:wpsnippets["py"]["zc"] = "$1--l = $1--u()"
let g:exprdict['js']['sj'] = {"expr": "s = `\n$c\n`", "cursor": 2}
let g:exprdict['js']['tl'] = {"expr": "console.log($c); throw '';", "cursor": 2}
let g:exprdict['py']['tl'] = {"expr": "print($c)\nraise Exception('')", "cursor": -1}
let g:exprdict['vim']['sj'] = {"expr": "s = `\n$c\n`", "cursor": 2}
let g:exprdict['py']['sj'] = {"expr": "s = \"\"\"\<CR>\<CR>\"\"\"\<UP>", "cursor": 2}
let g:exprdict['vim']['tl'] = {"expr": "print($c)\nraise Exception('')", "cursor": -1}
let g:exprdict['js']['c'] = {"expr": "const", "cursor": 2}
let g:exprdict['vim']['c'] = {"expr": "const", "cursor": 2}
let g:exprdict['vim']['okeys'] = {"expr": "Object.keys($c)", "cursor": -1}
let g:exprdict['js']['okeys'] = {"expr": "Object.keys($c)", "cursor": -1}
let g:exprdict['py']['okeys'] = {"expr": "keys = list($c.keys())", "cursor": -1}
let g:exprdict['vim']['ovals'] = {"expr": "Object.values($c)", "cursor": -1}
let g:exprdict['js']['ovals'] = {"expr": "Object.values($c)", "cursor": -1}
let g:exprdict['py']['ovals'] = {"expr": "values = list($c.values())", "cursor": -1}
let g:markdict['BookmarkManager'] = 'K'
let g:markdict['ExpressionMaster'] = 'L'
let g:bookmarkdict2['BookmarkManager2'] = '/home/kdog3682/.vimrc'
let g:bookmarkdict2['run'] = '/home/kdog3682/CWD/vue-transform.js'
let g:bookmarkdict2['ExpressionMaster'] = '/home/kdog3682/.vimrc'
let g:bookmarkdict2['leToComponent2'] = '/home/kdog3682/CWD/vue-transform.js'
let g:bookmarkdict2['vuetransform'] = '/home/kdog3682/CWD/vue-transform.js'
let g:pythonconnectordict['fa'] = {'file': 'redditscript.py', 'fn': 'fastask', 'arg': 's'}
let g:exprdict['py']['pr'] = {"expr": "pprint($c)"}
let g:vimsnippets["bc"] = "BetterConsole"
let g:pythonconnectordict['geni'] = {'file': 'apps.py', 'fn': 'genImports', 'arg': ''}
let g:pythonconnectordict['save'] = {'file': 'apps.py', 'fn': 'savetoday', 'arg': ''}
let g:pythonconnectordict['dirinfo'] = {'file': 'apps.py', 'fn': 'dirinfo', 'arg': ''}
let g:exprdict['js']['ti'] = {"expr": "this.item", "anywhere": 1}
let g:exprdict['js']['c'] = {"expr": "const", "anywhere": 1}
let g:pythonconnectordict['sh2b'] = {'file': 'apps.py', 'fn': 'shuntToBottom', 'arg': 'cf'}
let g:pythonconnectordict['dlg'] = {'file': 'download_github_gist.py', 'fn': 'download_github_gist', 'arg': ''}
let g:pythonconnectordict['ed'] = {'file': 'apps.py', 'fn': 'extractDependencies', 'args': ['cf', 'cfn']}
let g:pythonconnectordict['clear'] = {'normal': 'ggVGd'}
let g:pythonconnectordict['abc'] = {'normal': 'gg'}
let g:exprdict['vim']['pr'] = {"expr": "echo $c"}
let g:exprdict['js']['cur'] = {"expr": "current", "anywhere": "inoremap"}
let g:exprdict['js']['tc'] = {"expr": "this.c", "anywhere": 1}
let g:exprdict['js']['co'] = {"expr": "const"}
let g:exprdict['global']['pl'] = {"expr": " + "}
let g:vimsnippets['de'] = 'DictEntry2'
let g:markdict[''] = 'M'
let g:bookmarkdict2['LEVELS'] = '/home/kdog3682/CWD/testfile4.js'
let g:bookmarkdict2['q1'] = '/home/kdog3682/CWD/testfile4.js'
let g:bookmarkdict2['CreateFunctionBlock'] = '/home/kdog3682/.vimrc'
let g:pythonconnectordict['move'] = {'file': 'apps.py', 'fn': 'FileMover', 'arg': 's'}
let g:pythonconnectordict['scrape'] = {'file': 'scrape.py', 'fn': 'main', 'arg': 's'}
let g:pythonconnectordict['ssnc'] = {'file': 'single_sweep.py', 'fn': 'singlesweep', 'args': ['cf', 0]}
let g:bookmarkdict2['pairs'] = '/home/kdog3682/CWD/nodehelpers.js'
let g:bookmarkdict2['mathstoryparser'] = '/home/kdog3682/CWD/nodehelpers.js'
let g:bookmarkdict2['q1'] = '/home/kdog3682/CWD/testfile4.js'
let g:pythonconnectordict['geni'] = {'file': '/home/kdog3682/CWF/apps.py', 'fn': 'genImports2', 'args': ['cf', 'fg']}
let g:pythonconnectordict['jsa'] = {'file': '/home/kdog3682/CWD/jsconnector.js', 'fn': 'jsa', 'arg': 'cf'}
let g:pythonconnectordict['scrape'] = {'file': '/home/kdog3682/CWF/scrape.py', 'fn': 'main', 'args': ['s', 's']}
let g:pythonconnectordict['g'] = {'file': '/home/kdog3682/CWF/apps.py', 'fn': 'google', 'arg': 'x'}
let g:pythonconnectordict['ss'] = {'file': '/home/kdog3682/CWF/multisweep.py', 'fn':'multisweep','arg': 'cf'}
let g:pythonconnectordict['mover'] = {'file': 'apps.py', 'fn':'multisweep','arg': 'cf'}
let g:pythonconnectordict['extract'] = {'file': '/home/kdog3682/CWF/apps.py', 'fn': 'extraction', 'args': ['cf', 's']}
let g:pythonconnectordict['task'] = {'file': '/home/kdog3682/CWF/apps.py', 'fn': 'taskmaster', 'args': ['cf', 's'], 'combineArgs': 1}
let g:jslogic["ne"] = "!exists($1)"
let g:jslogic["num"] = "isNumber($1)"
let g:pythonconnectordict['bkl'] = {'file': '/home/kdog3682/CWF/bkl.py', 'fn':'brookynlearninghandler', 'arg': 's'}
let g:pythonconnectordict['text'] = {'file': '/home/kdog3682/CWF/apps.py', 'fn':'sendtwilio', 'arg': 's'}
let g:pythonconnectordict['ask'] = {'file': '/home/kdog3682/CWF/redditscript.py', 'fn':'ask', 'arg': ''}
let g:pythonconnectordict['reply'] = {'file': '/home/kdog3682/CWF/redditscript.py', 'fn':'reply', 'arg': ''}
let g:ldrdict['c'] = {'fn': 'GoToAction', 'args': ['constructor']}
let g:bookmarkdict2['htmlparser2runner'] = '/home/kdog3682/CWD/vue-transform.js'
let g:bookmarkdict2['HtmlEdit'] = '/home/kdog3682/CWD/vue-transform.js'
let g:replacecdict['rcl'] = {'fn': 'RemoveConsoleFromLines', 'i': 'GetScreenIndexes'}
let g:pythonconnectordict['ga'] = {'file': '/home/kdog3682/CWF/apps.py', 'fn':'global_action', 'arg': 's'}
let g:pythonconnectordict['gi3'] = {'file': '/home/kdog3682/CWF/apps.py','fn': 'genImports3', 'arg': 'cf'}
let g:pythonconnectordict['package'] = {'file': '/home/kdog3682/CWF/apps.py', 'fn': 'packageGithub', 'arg': 's'}
let g:pythonconnectordict['geval'] = {'file': '/home/kdog3682/CWF/apps.py', 'fn': 'grequestevalwrapper', 'arg': ''}
let g:pythonconnectordict['s'] = {'file': '/home/kdog3682/CWF/fileservice.py', 'fn': 'ffrunner', 'arg': ''}
let g:pythonconnectordict['ff'] = {'file': '/home/kdog3682/CWF/apps.py', 'fn': 'ffrunner', 'arg': 's'}
let g:pythonconnectordict['import'] = {'file': '/home/kdog3682/CWF/apps.py', 'fn': 'importer', 'args': ['cf', 's']}
let g:pythonconnectordict['req'] = {'file':'/home/kdog3682/CWF/apps.py','fn':'getJsRequire', 'args': ['cf']}
let g:pythonconnectordict['append'] = {'file': '/home/kdog3682/CWF/apps.py','fn': 'invivoappender', 'args': ['cf', 's']}
let g:pythonconnectordict['open'] = {'file':'/home/kdog3682/CWF/test.py','fn': 'openfile', 'args': ['s']}
let g:pythonconnectordict['savetoday'] = {'file': '/home/kdog3682/CWF/apps.py', 'fn': 'savetoday', 'args': ['']}
let g:bookmarkdict2['GoFile'] = '/home/kdog3682/.vimrc'
let g:pythonconnectordict['wame'] = {'file': '/home/kdog3682/CWF/apps.py', 'fn': 'writeAllModuleExports', 'args': ['cf']}
let g:pythonconnectordict['msd'] = {'file': '/home/kdog3682/CWF/apps.py', 'fn': 'move_stuff_down', 'args': ['cf']}
let g:pythonconnectordict['open'] = {'file': '/home/kdog3682/CWF/test.py', 'fn': 'openfile', 'args': 's'}
let g:pythonconnectordict['jsax'] = {'file': '/home/kdog3682/CWD/jsa.js', 'fn': 'main', 'arg': 'cf'}
let g:bookmarkdict2['CodeLibrary'] = '/home/kdog3682/CWD/jsa.js'
let g:pythonconnectordict['serve'] = {'file': '/home/kdog3682/CWF/apps.py', 'fn': 'serve', 'args': []}
let g:pythonconnectordict['prt'] = {'file': '/home/kdog3682/CWF/public/pretty.js', 'args': ['cf']}
let g:pythonconnectordict['s'] = {'file': '/home/kdog3682/CWF/apps.py', 'fn': 'serve', 'args': []}
let g:solsnippets["js"]["ifwin"] = "if(typeof window!==''undefined''){module={};module.exports={};require=()=>({})}"
let g:pydict['c'] = "class ${Capitalize($1)} {\n    constructor($c) {\n    }\n}"
let g:pydict['ce'] = "class ${Capitalize($1)} extends ${Capitalize($2)} {\n    constructor($c) {\n    super()\n    }\n}"
let g:solsnippets["js"]["text"] = "const text = read(file)"
let g:solsnippets["js"]["seen"] = "const seen = new Set()"
let g:solsnippets["py"]["size"] = "size = os.path.getsize(file)"
let g:pydict['utils'] = "var {\n    \n} = require('/utils.js')"
let g:pydict['node'] = "var {\n    \n} = require('/node-utils.js')"
let g:solsnippets["js"]["store"] = "const store = []"
let g:solsnippets["js"]["editor"] = "const editor = new FileEditor()"
let g:pydict["forsto"]  = "for (let [k,v] of storage) {\n $c\n}"
let g:pydict["type"]  = "if (typeof __$1__ == 'undefined') {\n    __$1__ = $2\n}\n$c"
let g:solsnippets["js"]["fade"] = "const fadestring = ''.fade-enter-active { transition: opacity 1s } .fade-leave-active { transition: opacity 0.75s; } .fade-enter, .fade-leave-to { opacity: 0;}''"
let g:solsnippets["html"]["app"] = "<script>\nconst app = new Vue(main).$mount(''#app'')\n</script>"
let g:solsnippets["html"]["script"] = "<script></script>"
let g:solsnippets["html"]["hb"] = "<!------------------------------------------------>"
let g:solsnippets["py"]["ppold"] = "pprint(os.listdir(dirgetter(dir)))"
let g:solsnippets["py"]["dir"] = "dir = dirgetter(dir)"
let g:solsnippets["js"]["m"] = "const matches = findall(regex, s)"
let g:solsnippets["js"]["cou"] = "let count = 0"
let g:solsnippets["js"]["count"] = "let count = 0"
let g:ldrdict["als"]  = "AddLeaderSingleton"
let g:ldrdict["rfn"]  = "ReplaceFunctionName"
let g:solsnippets["vim"]["cword"] = "let cword = expand('<cword>')"
let g:pydict["req"]  = "var {\n${Indent(join(split($1, '-'), ',\n'))}\n} = require('${FileGetter2($2)}')"
let g:ldrdict["coi"]  = "CommentOutImports"
let g:ldrdict["eat"] = "IabEat"
let g:pydict["win"] = "if (typeof window !== 'undefined') { module = {}; module.exports = {}; require = () => ({}) }"
let g:pydict["div"] = '<div class="$1"></div>'
let g:pydict['iu'] = "if (typeof $1 == 'undefined') $c"
let g:pydict["lam"] = "const $1 = (x) => {\n    $c\n}"
let g:pydict["lami"] = "const $1 = (x, i) => {\n    $c\n}"
let g:bookmarkdict2['schemaMatch'] = '/home/kdog3682/CWF/public/utils.js'
let g:pydict["src"] = "<script charset=\"utf8\" src=\"$1\"></script>"
let g:pydict["html"] = "<!DOCTYPE html><html>\n    $c\n</html>"
let g:pydict["link"] = "<link rel=\"stylesheet\" href=\"$1\"/>"
let g:pydict["redkv"] = "reduce($1, (k,v) => {\n    $c\n})"
let g:pydict["redx"] = "reduce($1, (x) => {\n    $c\n})"
let g:pydict["rts"] = "reduceToString($1, (k,v) => {\n    $c\n})"
let g:bookmarkdict2['evaluateJavascriptWithArgsFromAnywhere'] = '/home/kdog3682/CWF/public/TextEditor.js'
let g:pydict["vue"] = "new Vue({\n    template: `\n        $c\n    `,\n    data() {\n        return {\n            //foo:'boo'\n        }\n    }\n}).$$mount('#app')"
let g:pydict["xl"] = "console.log({LINE: ${line('.')}, CALLER: \"${GetBlockContext()}\", VALUE: $1})"
let g:solsnippets["vim"]["spaces"] = "let spaces = CurrentSpaces()"
let g:ldrdict["sftv"] = "SaveFilesToVim"
let g:ldrdict["ovaf"] = "OpenVimActiveFiles"
let g:ldrdict["ap"] = "AppendPup"
let g:bookmarkdict2['createComponents'] = '/home/kdog3682/CWF/public/depot.js'
let g:solsnippets["js"]["items"] = "const items = split(x)"
let g:pydict["np"] = "return new Promise((resolve) => {\n    $c\n})"
let g:pydict["t"] = "setTimeout(() => {\n    $c\n}, $1)"
let g:pydict["lambda"] = "return function lambda(s) {\n    $c\n}"
let g:solsnippets["js"]["c"] = "let count = 0"
let g:solsnippets["js"]["clp"] = "console.log(Object.keys(this.$refs))"
let g:ldrdict["mf"] = "MarkFile"
let g:pydict["input"] = "<input @keydown.enter='onEnter'/>"
let g:pythonconnectordict['asd'] = {'file': '/home/kdog3682/CWF/githubscript.py', 'fn': 'uploadWebsiteFromHtmlFile', 'args': []}
let g:pydict['vuech'] = "var ${Capitalize($1)} = {\n    name: '${Capitalize($1)}',\n    props: [''],\n    render(h) {\n        $c\n    },\n    mounted() {\n        console.log('hi from ${Capitalize($1)}')\n    }\n}"
let g:pydict['vh'] = "var ${Capitalize($1)} = {\n    name: '${Capitalize($1)}',\n    props: [''],\n    render(h) {\n        $c\n    }\n}"
let g:pydict['vd'] = "data() {\n    return {\n        $c\n    }\n},"
let g:pydict['amo'] = "async mounted() {\n    console.log('hello from ${GetBindingName()}')\n    await sleep(1000)\n    $c\n},"
let g:pythonconnectordict['mlf'] = {'file': '/home/kdog3682/CWF/apps.py', 'fn': 'mlf', 'args': ['s']}
let g:pydict["rredkv"] = "return reduce($1, (k, v) => {\n    $c\n})"
let g:pydict["rkv"] = "return Object.entries($1).reduce((acc, item, i) => {\n    $c\n}, {})"
let g:pydict["vredkv"] = "const value = reduce($1, (k, v) => {\n    $c\n})"
let g:pydict["vdiv"] = '<div class="$1">{{$1}}</div>'
let g:pydict["vinput"] = '<input class="input">{{$1}}</input>'
let g:ldrdict["ahs"] = "AddHtmlScript"
let g:pydict['vuect'] = "const ${Capitalize($1)} = {\n    components: {},\n    name: '${Capitalize($1)}',\n    async mounted() {\n        console.log('Mounted from ${Capitalize($1)}')\n        await sleep(1000)\n    },\n    props: [''],\n    template: `<div class=\"${Capitalize($1)}\">\n        <div>$c</div>\n        <div></div>\n    </div>`,\n    data() {\n        return {\n            //foo:'boo'\n        }\n    },\n    methods: {\n        foo() {\n        \n        },\n    },\n    computed: {\n        computedProp() {\n        \n        },\n    },\n    watch: {\n        \n    },\n}"
let g:ldrdict["wn"] = "WriteNotes"
let g:pythonconnectordict['rev'] = {'file': '/home/kdog3682/CWF/apps.py', 'fn': 'rev', 'args': ['cf']}
let g:ldrdict['ant'] = 'AddNameToDictionary'
let g:ldrdict['glq'] = 'GatherLargeQuotes'
let g:ldrdict['rn'] = 'RenameFile'
let g:ldrdict['wd'] = 'WriteDictionary'
let g:solsnippets["js"]["ifnes"] = "if (!exists(s)) return"
let g:solsnippets["js"]["al"] = "const length = args.length"
let g:ldrdict["ar"] = "AddRequireItemToTAndU"
let g:ldrdict["flk"] = "FindLibKeys"
let g:solsnippets["js"]["name"] = "const name = getFunctionName(s)"
let g:ldrdict["clr"] = "Clr"
let g:pydict["boo"] = "if (isFunction(x)) {\n    $c\n}\n\nelse if (isArray(x)) {\n    \n}\n\nelse if (isString(x)) {\n    \n}\n\nelse if (isObject(x)) {\n    \n}"
let g:solsnippets["js"]["snull"] = "if (s == null) return"
let g:pythonconnectordict['pkg'] = {'file': '/home/kdog3682/CWF/apps.py', 'fn': 'packageGithubToFolder', 'args': ['s']}
let g:solsnippets["js"]["words"] = "const words = split(s)"
let g:ldrdict["saveas"] = "Saveas"
let g:pythonconnectordict['review'] = {'file': '/home/kdog3682/CWF/apps.py', 'fn': 'reviewfiles', 'args': []}
let g:ldrdict["sti"] = "SetTemporaryIab"
let g:solsnippets["js"]["ivrv"] = "if (value) return value"
let g:solsnippets["js"]["lc"] = "look(cursor); throw ''"
let g:solsnippets["js"]["lcn"] = "look(cursor); cursor.next()"
let g:solsnippets["js"]["lc"] = "console.log(look(node))"
let g:solsnippets["js"]["rw"] = "var { write, read } = require(''./node-utils.js'')"
let g:ldrdict["sa"] = "SetActiveFileAndDictionary"
let g:ldrdict["ga"] = "GoToActiveFileAndDictionaryAndAppendEntry"
let g:pydict["jsx"] = "console.log(JSON.stringify($1))"
let g:ldrdict["sah"] = "SetActiveHtmlFile"
let g:ldrdict["ahs"] = "AppendActiveHtmlFile"
let g:solsnippets["js"]["sup"] = "cmInsert(cm, 'sup')"
let g:pythonconnectordict['st'] = {'file': '/home/kdog3682/CWF/apps.py', 'fn': 'sendtwilio', 'args': ['s']}
let g:solsnippets["js"]["lk"] = "console.log(cmLook(cm, wrapper))"
let g:solsnippets["js"]["node"] = "let node = syntaxTree()"
let g:solsnippets["js"]["gsl"] = "let [spaces, text] = getIndentAndLine(line.text)"
let g:ldrdict['sro'] = 'SetRunOver'
let g:pythonconnectordict['pf'] = {'file': '/home/kdog3682/CWF/apps.py', 'fn': 'postFileToJsonbin', 'args': ['cf']}
let g:ldrdict["o"] = "OpenFile"
let g:pydict["ren"] = "return h($1, {\n    key: i,\n    props:  {\n        focusIt: i == arr.length - 1,\n        $c,\n    }\n})"
let g:pydict['spk'] = "speak('$1')"
let g:pydict['w'] = "while (true) {\n\t\n}"
let g:ldrdict["g"] = "GTFGTF"
let g:gtfgtfdict['gf'] = ['/home/kdog3682/.vimrc', 'GTFGTF', [0,2670,49,0]]
let g:gtfgtfdict['iframe'] = ['/home/kdog3682/CWF/public/utility-components.js', 'IframeComponent', [0,130,9,0]]
let g:gtfgtfdict['crr'] = ['/home/kdog3682/CWF/public/code-runner.js', 'VueDisplayCallbacks', [0,11,5,0]]
let g:gtfgtfdict['cr'] = ['/home/kdog3682/CWF/public/utils.js', 'getBindingName', [0,1564,1,0]]
let g:gtfgtfdict['run'] = ['/home/kdog3682/CWF/public/cm.js', 'box', [0,1035,1,0]]
let g:gtfgtfdict['run'] = ['/home/kdog3682/CWF/public/cm.js', 'languageRef', [0,979,5,0]]
let g:pythonconnectordict['g'] = {'file': '/home/kdog3682/CWF/apps.py', 'fn': 'google', 'arg': 's'}
let g:gtfgtfdict['usps first class stamp'] = ['/home/kdog3682/CWF/questions.txt', '', [0,3,190,0]]
let g:pythonconnectordict['incb'] = {'file': '/home/kdog3682/CWF/apps.py', 'fn': 'incorporateBuffersToHtmlFile', 'args': []}
let g:pythonconnectordict['review'] = {'file': '/home/kdog3682/CWF/apps.py', 'fn': 'reviewfiles', 'args': []}
let g:ldrdict["go"] = "Go"
let g:pythonconnectordict['openfile'] = {'file': '/home/kdog3682/CWF/apps.py', 'fn': 'openLocalFile', 'args': ['s']}
let g:gtfgtfdict['md'] = ['/home/kdog3682/CWF/public/math-components.js', 'DrillerA', [0,787,1,0]]
let g:pydict['while'] = "while ($1) {\n\t\n}"
let g:pydict['vb'] = "<button class=\"btn\" @click=\"$1\">$1</button>"
let g:pydict['csl'] = "cssLoader(`\n\t$c\n`)"
let g:gtfgtfdict['google'] = ['/home/kdog3682/CWF/public/me.blog', '', [0,829,1,0]]
let g:ldrdict["bl"] = "Black"
let g:gtfgtfdict['reddit'] = ['/home/kdog3682/CWF/public/m1.js', '', [0,115,1,0]]
let g:pythonconnectordict['ic'] = {'file': '/home/kdog3682/CWF/apps.py', 'fn': 'incorporateCss', 'args': []}
let g:pythonconnectordict['ic'] = {'file': '/home/kdog3682/CWF/apps.py', 'fn': 'incorporateCss', 'args': []}
let g:pydict['ig'] = "const $1 = [${F1($middle)}]\nif ($1.includes($last)) {\n    $c\n}"
let g:pydict["tx"] = "setTimeout(() => {\n    $c\n}, $1)"
let g:ldrdict["clr"] = "ClrFile"
let g:pydict["r"] = "var {${ JoinComma($notlast) }} = require('./$last.js')"
let g:vimsnippets["asd"] = "/* ${Tail(g:filedict[$0])} */"
let g:pydict["i"] = "/* ${Tail(g:filedict[$0])} */"
let g:jslogic["he"] = "hasEquals($1)"
let g:jslogic["it"] = "isIterable($1)"


let g:physical_location = 'park'
let g:homedir='/home/kdog3682/'
let g:foodict = {
      \ 'q': 'questions.txt',
      \  'n': '/home/kdog3682/CWF/notes.txt',
      \  'r': 'r.py',
      \  't': ['today.py', 'vv'],
\}
let g:kdoghtml = '/home/kdog3682/CWF/public/r6.html'
let g:lcs=''
set textwidth=1000
let g:ifwin = "if(typeof window!=='undefined'){module={};module.exports={};require=()=>({})}"
let g:rootdir = '/home/kdog3682/'
    "call AddDictItem('sol ' . a:s)
let g:movefunctiondefaultdestination = 'test.py'
 


let g:jspy2022 = {
    \'not': ['!', 'not'],
\}
let g:appendlib = {
    \ 'bash': "alias $0='$1'",
\}
let g:dir = '/home/kdog3682/CWF/'
let g:sti = 0

let g:vimrciabdict = {'a': 'asd'}
let g:iabpydict = {
    \ 'ffo': "for i, file in enumerate(files):",
    \ 'ff': "for file in files:",
\}


let g:iabkey = ''
let g:keypresskeys = {'Enter': "\<CR>"}
let g:basedir = '/home/kdog3682/CWF/'
let g:suncaller = ''
let g:jsanywherefile = 'edit.js'
let g:jsanywherefile = 'index.js'
let g:jsanywherefile = 'index.js2'
let g:commentdict = {
    \'js': '//',
    \'js2': '//',
    \'vimrc': '"',
    \'py': '#',
    \'': '"',
\}
 
fun CopyGetter(regex)
  let @/ = a:regex
  let repl = expand("<cword>")
  //s//\=repl
endfun
 
let g:dictref = {'l': 'ldrdict', 'p': 'pydict', 'rc': 'replacecdict'}

"let g:dirdict['/home/kdog3682/CWF'] = '/home/kdog3682/CWD'
"let g:dirdict['/home/kdog3682/CWD'] = '/home/kdog3682/CWF'

    "let parts = a:parts
    "let upline = a:upline
let g:snippetaliasdict = {'r': 'read', 'gf': 'getfunctions'}
    "\[   '^(\w+,? \w.{-})( \= .+)',              'Ijsarrobj'    ],
let g:invivoconnector = {
    \'append': 'awr',
    \'write': 'awr',
    \'read': 'awr',
    \'split': 'split',
    \'co': 'co',
\}
let g:invivojs = [
    \[   '(append|write|read|split|co) (.+)',   'Ijsawr'       ],
    \[   '(\w+[a-z0-9 ,]{-})( \= .+)',              'Ijsarrobj'    ],
\]
    "return Match(a:line, '(def|function|const|class) \zs\w+')
let g:lastkey = ''
let g:tempbindingref = {
    \'q': 'WriteCodeReviewNotes',
    \'2': 'ExecutePythonRegex',
    \'py': {
        \ 'asdf': 'adf',
    \}
\}

let g:pybackdict = {
    \ 'tos': "${VarializeTheString($0)}$c",
\}
let g:movementsnippetdict = {
   \ 'asdf': 'asdf',
   \ 'el': {
       \'regex': '} *$',
       \'payload': ['else {', '    ', '}'],
       \'indentation': 0,
       \'cursor': 2,
   \}
\}
    "let file = a:file
    "let dir = a:dir
"call RegistrarTemplater(, [])
let g:linebreak = "---------------------------------------------"
let g:noteRef = {
    \'doc': ['~/.notes', '$ds: $0', 1], 
    \'html': ['code.notes', '$ds: $0', 1], 
    \'a': ['activity-info.txt', '$ds $tail $function', 1], 
    \'callable': ['code.notes', '$fn: $0', 1],
    \'DEFAULT': ['/home/kdog3682/CWF/notes.txt', '$ds: $0', 0],
    \'function-notes': ['~/.functions', '$ds $bf $parent $0', 0],
    \'file-notes': ['file-notes.txt', '$ds $bf $0', 0],
    \'help': ['helpdocs.txt', '$file $fn $parent $0', 1],
    \'file-help': ['file-help.txt', '$ds $file $0', 1],
\}
    "sdf
    "sdf
let g:callableRE = '\w+\ze\('
"hi Error ctermfg=Red guifg=Red
"
let abcRE = 'asdfasdf'
let g:root = '/home/kdog3682/'
let g:cwf = 'CWF'
let g:cwd = g:root . g:cwf
let b:deleterange = 1
let g:buffergrouplist = []
let g:count = 0
let g:debug = 'DEBUG'
let g:defaultlib = 'combine.py.lib'
let g:defaultlib = 'javascript.lib'
let g:dict = {'a': 1, 'b': 2}
let g:dotu = '.{-}'
let g:fnRE = '(function|def|class) \zs\w+'

let g:funcnamere = '^(function|def|class) \zs\w+'
let g:functionlookaheadRE = '^(function|^def) \zs(\w+)'
let g:functionRE = '^(function|def|class) '
let g:globaltabwidth = '    '
let g:grabbuffer = 'utils.py'
let g:grabmode = 0
let g:importre = '<(sys|praw|default_timer|difflib|urllib|itertools|html|requests|subprocess|shutil|socket|inspect|datetime|time|json|sys|re|os)\ze\.|<(black|FPDF|fbchat|pprint)\ze\('
let g:lastbuffer = 0
"let g:ldrdict['als'] = function('AddLeaderSingleton')
"let g:ldrdict['f'] = function('FindLibFunctions')
let g:logicdict = {'js': g:jsdict, 'vim': g:jsdict, 'py': g:jsdict}
let g:notelist = []
let g:questionlist = []
let g:randomlist = []
let g:shuntbuffer = 'storage.py'
let g:tempfiles = []
let g:variableRE = '^(const|\w+ \=)'
let g:vimfile = '/home/kdog3682/.vimrc'
let g:vimrc = '~/.vimrc'
let r = '\w+\ze \='
let s:NONE = ""
let s:completions = []
let s:counter = 0
let zoop = 'hi'
let g:zoopbarwords = ['update', 'get', 'set']
let g:currentpos = 0


vnoremap 0 <esc> :call RunVimLineInJS()<cr>
vnoremap 1 <esc>:w<cr> :call Python('systemscript.py', CurrentFile())<cr>
command -nargs=1 Pre call Preview(<args>)
command AA call AlignAssignments()
command ASK :! python3 reddit.py
command CC call CreateVimCommand()
command Copy call Copy()
command Fix call Fixer()
command T call TrimWhiteSpace()
command TC call ToggleComment()
command Tick call MyCounter()
command Ujs :e ~/CWF/utils.js
command Upy :e ~/CWF/utils.py
set autoread
set expandtab
set hidden
set ignorecase
set mouse=a
set nocompatible
set noswapfile
set number
set scrolloff=0 " Keep 3 lines below and above the cursor
set shiftwidth=4
set softtabstop=4
set splitright
set statusline=%F
set viminfo='1000,f1
set tabstop=2
vnoremap 0 <esc>:w<cr>:e utils.js<cr>
vnoremap 7 <esc>:w<cr>:e q.txt<cr>
vnoremap 8 <esc>:w<cr>:e asdf<cr>
vnoremap 8 <esc>:w<cr>:e utils.js<cr>
vnoremap 8 <esc>:w<cr>:e utils.js<cr>
vnoremap 9 <esc>:w<cr>:e utils.py<cr>
vnoremap <s-c> y<s-o><esc>P
vnoremap <s-f> dggP
vnoremap B ^/}\zs\(\n\|,\)<cr>oV
vnoremap D <esc>O<div><esc><down>o</div>
"vnoremap [ ?^\(def\\|class\\|async\\|function\)<cr>
vnoremap ] <esc>?^function<cr>v/^}<cr>
vnoremap a :<c-u>call Foobar('')<left><left>
vnoremap c <esc>?^console<cr>
vnoremap h <esc>H/^\(def\\|function\) \w*/e<cr>adep<esc>
vnoremap s :<c-u>call ReplaceContiguousOrScreen('')<left><left>
vnoremap x1 <esc>:call SetBuffer('storage.py')<cr>
vnoremap xb :call ShuntVisualSelectionToBuffer()<cr>
let A = "=> {\n    $c\n}, {})"
let B = " {\n    $c\n}"
let g:zoopdict = {
    \ 'red': "reduce((acc, item) " . A
\}
let g:arrmethodwords = keys(g:zoopdict)
let g:A = "=> {\n    $c\n}, {})"
let g:B = " {\n    $c\n}"
let g:p5dict = {
    \ 'vue': [ 
       \ ['^        "?\w+$', '$1()' . g:B . ','],
    \],
\}
    
let g:nodeconnectorfile = '/home/kdog3682/CWF/jsconnector.js'
let g:importfile = 'imports.template'
let g:templines = []
let g:jslogicdict = {
    \ 'if': 'if',
    \ 'ef': 'else if',
\}
let g:fnabrevdict = {
    \ 'num': 'number',
    \ 'node': 'node',
    \ 'n': 'null',
    \ 'a': 'array',
    \ 'o': 'object',
    \ 's': 'string',
\}
let mapleader=","
let maplocalleader = '{'
let g:myvimrc = '/home/kdog3682/.vimrc'
let g:searchquery = '\/\/ \?\w'
let g:jspykey = ''
let g:jspyparentdict = {'vim': {'lx': '{ -> '}, 'js': {'lx': '(x) =>'}, 'py': {'lx': 'lambda x:'}}
let g:bookmarkdict = {
    \ '.vimrc': {
        \ 'p': '^function PySnippet4',
    \},
    \ 'index.js': {
        \ 'p4': '^function PySnippet4',
        \ 'asdfp4': '^function PySnippet4',
        \ 'pasdfsdf4': '^function PySnippet4',
        \ 'qc': 'ref\="currentAnswer"',
    \},
    \ 'master.css': {
        \ 'p4': '^function PySnippet4',
        \ 'asdfp4': '^function PySnippet4',
        \ 'pasdfsdf4': '^function PySnippet4',
    \},
    \ 'edit.js': {
        \ 'p4': '^function PySnippet4',
        \ 'asdfp4': '^function PySnippet4',
        \ 'pasdfsdf4': '^function PySnippet4',
    \},
    \ 'fpdf.js': {
        \ 'p4': '^function PySnippet4',
        \ 'asdfp4': '^function PySnippet4',
        \ 'pasdfsdf4': '^function PySnippet4',
    \},
\}
"let g:ldrdict['f'] = function('FindBookmark')
set laststatus=2
let g:htmlfile = 'alan.html'

let g:currentMovementTarget = 'kc'
let g:backupleaderdict = {
   \    'v': function('SetVariable'),
   \    'r': function('Read'),
   \    'g': function('GotoSavedBookMark')  ,
   \    's': function('SmartMovementAppend'),
\}
let g:insertionlocation = 0
let g:jslibref = 'controller.js'
        "\    'q': {'fn': function('VisualQuotify'), 'i': 'block', 'args': 1},
let g:shuntdestination = ''
let g:libcreationdate = '12-07-2021'
let g:libcreationdate = '12-07-2021'
        "\    'rc': {'fn': ['IsComment', 'DeleteLine'], 'i': 'code'},
let g:suncaller = 'SayHi()'
let g:suncaller = 'findName'
let g:suncaller = 'FindName()'
let g:suncaller = 'ToShortName(''a.bBC'')'
        "asdfasdfadf
let g:iabmathdict = {
    \'q': '^2',
    \'div': ' ÷ ',
    \'t': ' * ',
    \'e': '^',
    \'p': ' + ',
    \'=': ' = ',
    \'-': ' - ',
    \'sim': 'simplify ',
    \'big': 'expand ',
\}
vnoremap g :call VisualGetAndDelete()<cr>
vnoremap n :call VNext()<cr><DOWN>O
let g:globalFunctionRef = {'GLOBALS.py': []}
let g:gotopline = 200
let g:gotopline = 400
let g:lastshuntdestination = 'exports.js'
let g:lastshuntdestination = 'test.py'
vnoremap 2 <esc>:w<cr> :call Python('libra.py', CurrentFile() . ' ' . '')<LEFT><LEFT>
let g:pysnippetref = g:pythonsnippets
let g:iabref =  {'math': g:iabmathdict, 'py': g:iabpydict}
let g:dayswork = ['nerd.js','/home/kdog3682/.vimrc','libra.py','/home/kdog3682/CWF/filesystem.py','organize_notes.py','/home/kdog3682/CWF/line_edit.py','vim_commands.log','progress.txt']
let g:pythonconnectorfile = 'storage.py'
let g:pythonconnectorfile = '~/CWF/pythonconnector.py'
let g:pythonconnectorfile = '~/CWF/base.py'
let g:navigationdict = {"test.py": ["prompt", "inferlang", "removeComments", "resolveTextDelta", "getDuplicates", "difference", "intersection", "messenger", "required", "ftest", "test", "isIterable", "filtered", "isPrimitive", "isFunction", "isString", "isNumber", "isArray", "exists", "isObject", "isPublic", "tail", "identity", "removeExtension", "mapped", "reduced", "hasExtension", "getExtension", "quoted", "toVariable", "jspy", "writejson", "read", "pprint", "stringify", "toString", "append", "write", "typed", "mergeObject", "readjson", "deepMerge", "appendMerge", "datestamp", "getPreviousDateTime", "find", "search", "dreplace", "toArray", "Storage", "replace", "force", "indent", "log", "mreplace", "unique", "reduce", "ncg", "templater", "iterate", "ErrorInfo", "tempest", "isCode", "removeEmptyLines", "mwrite", "consoleThrow", "findKey", "choose", "findWithin"], "libra.py": ["getImplied", "Library", "blackify", "organize_python", "organizeJS", "getPythonFunctions", "create_library", "getFunctions", "getFunctionName", "getFunctionNames", "move_functions_around", "interactive", "CodeObject", "CodeService", "codesort", "getDependencies"], "filesystem.py": ["File", "filefactory", "expand", "mdate", "isfile", "isdir", "removefile", "normalizepath", "absdir", "copyfile", "isMacbook", "toDrive", "getdir", "ff", "getfile", "saveToSandisk", "review", "endofday", "saveToDriveFolder", "filegetter", "saveToDrive", "chdir", "FileManager", "mkdir", "rename", "prepend", "mergejson"]}
 "generated by appendVim
 "generated by appendVim
 "generated by appendVim
 "generated by appendVim
vnoremap m <esc>H/^\(def\\|function\) \w*/e<cr><left>yiwGos=`<cr><cr>`.trim()<cr>console.log(<esc>pa(s))<up><up><up>
set nosmartindent
    
set autoindent
set smartindent
set smarttab
let g:jsimports = "const module.exports = {StandardObject, roygbiv, numberWords, Cache, Indexed, assert, partial, log, getLongest, aggregateRegexFromHashmap, dreplace, ncg, isIterable, isArray, isObject, type, search, isString, matchgetter, ncgRunner, prepareIterable, notNone, isNumber, test, isPrimitive, rescape, templater, hasCaptureGroup, replace, getIndent, evalClock, atFactory, filtered, fixSpaceLength, getIndentAndLine, argsplit, toDashCase, toSnakeCase, findKey, range, partitioned, appFinal, findElement, findKeys, finderror, flatfindall, defineGetters, defineGetter, kcDefine, finder, findchild, isDefined, findAbbreviation, findall, findParentWhoHasNoParentStartingFromChild, toStringObject, capitalize, singlequote, delta, toVariable, quotify, tail, removeComments, ftest, consoleThrow, mapConditional, dedentPre, getFunctionName, merge, getLast, tryval, abbreviate, counted, shuffle, isBoolean, Clock, isFirst, coerceError, toArgument, randomPick, isWord, isPromise, getExtension, sorted, isDoubleIterable, isNestedArray, char2n, datestamp, getMDY, newlineIndent, indent, toSpaces, iterate, toArray, sortStorage, Storage, ObjectWatcher, VueStorage, reduce, exists, remove, modularIncrement, mreplace, smallify, sleep, parens, unique, stringify, getStorage, parseJSON, isJsonParsable, splitonce, isRegExp, pop, isFunction, fill, counter, joined, assign, findall, doublequote, isDefined, toString, split, matchall, AnimationState, GlobalState, toCamelCase, modularIncrementFn, randomColor, flat, sum, getOptions, hasNumber, len, isTrue, sortEach, stringCall, pipe, isClassObject, logged, forEach, toggle, isNode, indexgetter, insert, getSpaces, dedent, identity, trimmed, throwError, inferlang, aggregate, paired, toDictionary, isJson, typed, splitmapfilter, isClass, getFirstParameter, itersearch, getParameters, backspaced, isElement, getFirst, hasComma, toLiteralArray, UniqueGenerator, UniqueStorage, toUpperCase, wordToNumber, numbersort, hasLetter, subtractALittle, endsWithNumber, depluralize, hasWord, getWords, shared, copy, isInteger, isPositive, hasLookAround, toInteger, isCapitalized, zeroPad, changeDate, isYesterday, isToday, kfnormalizeTiming, LineEdit, assignAliases, postgoogle, fixClassName, boxed, visible, atFirst, original, display, splitThePage, looksLikeProse, sortByDependencies, tryCatchString, jsa, jsconnector, loadcss, aggregateCSS, cssValueParser, getCssItems, cssParser, reduceCss, cssEntry, addCssPeriod, toCssClassName, cssBracket, cssCalc, cssAnimation, cssColorMatch, cssPcal, cssBoxShadow, cssBorder, cssColor, cssUnit, cshpos, csho, cshcolor, cssShorthand, cshkf, cshclasses, createConfigCss, cshtimeline, cabmap, cssattrmap, cssunitmap, tailwind, vmap, range, coinflip, hasMultipleVariables, rng, getNumbers, isOdd, allEqual, hasEquals, hasVariableX, hasNaN, isNiceAnswer, hasTerminatingDecimal, getprimefactors, getdigits, notPrime, power10, getDecimalLength, getOperators, hasMathOperator, isNegativeAnswer, isLatexOperator, isLatexFraction, isLatexExponent, simplifyRatio, hasDecimal, isSquare, isCube, fractionToPercent, getVariables, hasVariable, isTerminating, lcm, countDecimalPlaces, divmod, toRatio, isPercentage, isRepeatingDecimal, getFactors, gcd, kfcalcDuration, toNerdamerFraction, toLatexFraction, toLatexFromVeryRaw, toMixedMath, toMath, toNerdamerRunner, toMath2, toNerdamer, mathsolver, divify, toOpeningTag, hasHtmlSuffix, toClosingTag, isStandardHtml, htmltrim, divifyn, htmlElements, modalitemcparser, main, toSingularForArg} = require('./nodehelpers.js')"
let g:bookmarktracker = 'M'
set modeline
set modelines=5
filetype plugin on
vnoremap w :<c-u>call VisualWord('')<left><left>
set nomodeline
 
cnoreab iun iunmap
vnoremap qd <esc>A // isData <esc> 
" appends isData to the end of the line.
command Node call Node('/home/kdog3682/CWF/public/puppet.js', 'not-headless')
command -nargs=* B call SayHi(<args>)
command -nargs=* Sa call SaveAll(<args>)
command -nargs=* E call Node('/home/kdog3682/CWF/public/TextEditor.js', CurrentFile())
vnoremap [ di[<esc>pa]<LEFT>
vnoremap { di[<esc>pa]<LEFT>
let g:htmlfile = 'index.html'
vnoremap gr <esc>/async mounted<CR>
let g:activeDictionary = 'EditorCommands'
let g:pupname = 'cm'
let g:runover='AppendPup'
let g:activeHtmlFile = 'r4.html'

let g:logic2022 = {'js' : g:jslogic, 'py': g:pylogic, 'vim':g:vimlogic}
" 07-06-2022
" 07-06-2022
nnoremap <leader>v :w<cr>:e ~/.vimrc<cr>gg
nnoremap 4 /^\(const\\|var\\|def\\|class\\|async function!\?\\|function!\?\) \$\?

let g:basepyref = {
  \'kd': '_github.py main kdog3682.github.io $kdoghtml',
  \'rfa': 'base.py _reddit ask',
  \'ofile': 'base.py ofile',
  \'rr': 'base.py _reddit reply',
  \'ra': 'base.py _reddit ask',
  \'rbr': 'base.py _reddit reply',
  \'rdr': 'base.py _reddit reply',
  \'ac': 'base.py _addcss',
  \'ff': 'base.py ff',
  \'gvbbal': 'base.py google_request',
  \'gval': 'base.py google_eval',
  \'gvval': 'base.py google_request',
  \'gcval': 'base.py google_request',
\}

let g:wpsnippets['vim'] = g:vimsnippets
let g:wpsnippets['py'] = extend(g:pythonsnippets, g:mastersnippets['py'])
let g:wpsnippets['js'] = g:pydict
let g:wpsnippets['txt'] = g:txtdict
let g:wpsnippets['html'] = {}
let g:wpsnippets['css'] = {}


    let g:jspyref2 = {'math': {}, 'log': {}, 'vim':{},'txt':{},'json':{},'pdf':{},'js':{},'py':{}, 'html': {}, 'css': {}}

    let g:jspyref2['js']['normalizeDirPath'] = g:jsdir
    let g:jspyref2['html']['normalizeDirPath'] = g:htmldir
    let g:jspyref2['css']['normalizeDirPath'] = g:cssdir
    let g:jspyref2['py']['normalizeDirPath'] = g:pydir
    let g:jspyref2['json']['normalizeDirPath'] = g:jsondir
    let g:jspyref2['txt']['normalizeDirPath'] = g:txtdir
    let g:jspyref2['pdf']['normalizeDirPath'] = g:pdfdir
    let g:jspyref2['log']['normalizeDirPath'] = g:logdir
    let g:jspyref2['math']['normalizeDirPath'] = g:mathdir
    let g:jspyref2['vim']['normalizeDirPath'] = ''
    let g:jspyref2['vim']['const'] = 'let '
    let g:jspyref2['js']['const'] = 'const '
    let g:jspyref2['py']['const'] = ''
    let g:jspyref2['js']['file-function-ref'] = {}
    let g:jspyref2['py']['file-function-ref'] = {}
    let g:jspyref2['vim']['file-function-ref'] = {}
    let g:jspyref2['vim']['file-function-ref']['py4'] = ['vimrc', 'PySnippet4']

let g:pysnippet4ref = [
        \[ '^ *s *$', "style {\n    $c\n}"],
        \[ 'oa$', "${CreateObjectArray($0)}"],
        \[ 'on \w+$', "$0on('$2', (e) => {\n    $c\n})"],
        \[ 'srep$', "$0s.replace(//g, (x) => {\n    $c\n})"],
        \[ 'l\d$', "f:Snip4Len"],
        \[ 'vars\w+$', "f:PythonVarsHandler"],
        \[ '^ *\w+s$', "const $1 = [\n    $c\n]"],
        \[ '\/st\zs\d+$', "setTimeout(() => $0, $1)"],
        \[ '\zszoo$', "${ZStringPipe($0)}"],
        \[ 'arrc$', "${LineToArray($0)}"],
        \[ 'arr$', "${ToStringArray($0)}"],
        \[ '\/s$', "${LineToString($0)}"],
        \[ '(ms?)$', "${ZoopMethod2($0, $1)}"],
        \[ 'zzda$', "${DoubleArraySnippet($0)}"],
        \[ 'da$', "$0[\n    [$c],\n    [],\n]"],
        \[ 'd$', "${LineToDict($0)}"],
        \[ 'p$', "$0{\n    props: {\n        $c\n    }\n})"],
        \[ 'vd$', "${VueDictify($0)}"],
        \[ 'vvvvd$', "f:VueDictify"],
        \[ 'asdftar$', "$0abc"],
        \[ '(template)$', "template: `\n    <div>\n        $c\n    </div>\n`,"],
        \[ '(watch|computed|methods)$', "$1:" . "{\n    $c\n}" . ','],
        \[ '(data|mounted|created)$', "$1()" . "{\n    $c\n}" . ','],
        \[ '\.g\zs\w+$', "$0.get('$1')"],
        \[ 'get \zs\w+$', 'get $1()' . "{\n    $c\n}"],
        \[ 'redstrab', "$0reduce((acc, [a,b]) => {\n    $c\n, ''})"],
        \[ 'redstr', "aaaaaaaaaaaaaa"],
        \[ '(red|map|filter|fe|f)\w*$', "$0${ZoopbarArrMethods($1)}"],
        \[ 'kv$', "(k, v) => {\n    $c\n})"],
        \[ '\.a$', "const $0 = [\n    $c\n]"],
        \[ 'x$', "$0($1) => {\n    $c\n})"],
        \[ 'fa$', "let matches = findall(re, s)\nconsole.log(matches)\nreturn"],
        \[ 'ls$', "() =>" . g:jsbe],
        \[ 'while$', 'while (true) $B'],
        \[ 'runner *$', 'const runner = () =>$B'],
        \[ '\w*(dict|ref)$', 'const $1 = $B'],
\]

    let g:ParensRef = {
    \    'parens': ['(', ')'],
    \    '()': ['(', ')'],
    \    'newline': ["\n", "\n"],
    \    'braces': ['[', ']'],
    \    '[]': ['[', ']'],
    \    'brackets': ['{', '}'],
    \    '{}': ['{', '}'],
    \ }

let g:execRef = {}
let g:execRef['t2'] = 'call BasePY("vimFileOpener test2.html")'
let g:execRef['fp'] = 'call BasePY("fp")'
let g:execRef['o'] = 'call BasePY("vimFileOpener $arg")'
let g:execRef['clip'] = 'call BasePY("fp clip")'
let g:execRef['py'] = 'call BasePY("fp py")'
let g:execRef['mlf'] = 'call BasePY("mlf")'
let g:execRef['bd'] = 'bd'
let g:execRef['pr'] = "Node('/home/kdog3682/CWF/public/print.js')"
let g:execRef['mk'] = 'marks'
let g:execRef['m'] = 'marks'
let g:execRef['time'] = 'return ClockStamp()'
let g:execRef['date'] = 'return ClockStamp()'
let g:execRef['ec'] = 'call Echo("$arg")'
let g:execRef['m'] = 'call CodingNote("$arg")'
let g:execRef['rj'] = "call Node('run.js $arg $cf')"
let g:execRef['pr'] = "call Node('print.js')"
let g:execRef['clone'] = "!git clone $arg"
let g:execRef['cd'] = "call SetDirToCurrentFile()"
let g:execRef['npm'] = "call InstallNpm('$arg')"
let g:execRef['pip'] = "call InstallPip('$arg')"
let g:execRef['f'] = "call FindUpString('$arg')"
let g:execRef['gf'] = "call GoFileGoFunction('$arg')"
let g:execRef['saveall'] = "call SaveAll()"
let g:execRef['S'] = "call SaveAll()"
let g:execRef['clr'] = "1,$d"


let g:lastworddict = {
  \  'arr': "$0 => {\n    $c\n})",
  \  'lx': "$0 (x) => {\n    $c\n})",
  \  'lxi': "$0 (x, i) => {\n    $c\n})",
  \  'redkv': "$0reduce((acc, [k,v], i) => {\n    $c\n    return acc\n}, {})", 
  \  'mapab': "$0map(([a,b], i) => {\n    $c\n})", 
  \  'div': "$0<div class=\"\">$c</div>", 
  \  'p': "$0<p class=\"\">$c</p>", 
  \  'button': "$0<button @click=\"\">$c</button>", 
  \  'filter': "$0filter((acc, item) => {\n    $c\n})",
  "\  'fe': "$0forEach((item, i) => {\n    $c\n})",
  \  'reds': "$0reduce((acc, ${$1[:-2]}, i) => {\n    $c\n    return acc\n}, '')",
  \  'redst': "$0reduce((acc, item, i) => {\n    $c\n    return acc\n}, new SimpleStorage())",
  \  ':'     : "$0 {\n    $c\n},",
  \  ','     : "$0() {\n    $c\n},",
  \  ',.'     : "$0 {\n    $c\n},",
  \  'default'     : "$0 {\n    $c\n}",
  \  'ls'     : "$0 (s) => {\n    $c\n})",
  \  'lkv'     : "$0 (k, v) => {\n    $c\n})",
\ }
"nnoremap <localleader>fix :call Fixer()<cr>
"nnoremap <leader>f :call NoteMaster('function-notes', '')<left><left>
"nnoremap <localleader>f :call NoteMaster('file-notes', '')<left><left>
"nnoremap <leader>f :call ReadFunctionFromFile('')<LEFT><LEFT>
"nnoremap <leader>f :call JspyConnector('ff ')<LEFT><LEFT>
"nnoremap <leader>fj :call JspyConnector('ff js text=')<LEFT><LEFT>
autocmd! bufwritepost ~/.vimrc source %
