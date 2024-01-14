
" Define a dictionary of keys and their corresponding mappings
let s:buffer_mappings = {
    \'ce': 'ClassExpression',
    \'md': 'MethodDeclaration',
    \'pd': 'PropertyDefinition',
    \'be': 'BinaryExpression',
    \'rs': 'ReturnStatement',
    \'al': 'ArgList',
    \'me': 'MemberExpression',
    \'ca': 'CallExpression',
    \'vd': 'VariableDeclaration',
    \'ue': 'UnaryExpression',
    \'pe': 'ParenthesizedExpression',
    \'ase': 'AssignmentExpression',
    \'is': 'IfStatement',
    \'ap': 'ArrayPattern',
    \'p': 'Property',
    \'es': 'ExpressionStatement',
    \'b': 'Block',
    \'fd': 'FunctionDeclaration',
    \'pl': 'ParamList',
    \'bc': 'BlockComment',
    \'lc': 'LineComment',
    \'ae': 'ArrayExpression',
    \'oe': 'ObjectExpression',
    \'ts': 'TemplateString',
    \'vn': 'VariableName',
    \'af': 'ArrowFunction',
    \'re': 'RegExp',
    \'fe': 'FunctionExpression',
    \'dl': 'DefaultLabel',
    \'cl': 'CaseLabel',
    \'sb': 'SwitchBody',
    \'ss': 'SwitchStatement'
\}


"
" Function to save current mappings
function! SaveCurrentMappings()
    redir => currentMappings
    silent! execute 'verbose nmap <buffer>'
    redir END
    return currentMappings
endfunction

" Global variable to store old mappings and state
let g:oldMappings = {}
let g:mappingsActive = 0

" Function to set new mappings and save old ones
function! SetNewMappingsWithBackup()
    let g:oldMappings.buffer = SaveCurrentMappings()

    for [keymap, objectKey] in items(s:buffer_mappings)
        execute 'nnoremap <buffer> <silent> <leader>'.keymap.' :call JumpToObjectKey("'.objectKey.'")<CR>'
    endfor

    let g:mappingsActive = 1
endfunction

" Function to restore old mappings
function! RestoreOldMappings()
    if exists('g:oldMappings.buffer')
        execute g:oldMappings.buffer
    endif
    let g:mappingsActive = 0
endfunction

" Function to toggle between new and old mappings
function! ToggleMappings()
    if g:mappingsActive
        call RestoreOldMappings()
    else
        call SetNewMappingsWithBackup()
    endif
endfunction

" Function to jump to a specific key in a JavaScript object
function! JumpToObjectKey(key)
    let searchPattern = '\v^   +' . a:key . '\ze\('
    execute 'normal! gg'
    call search(searchPattern, 'W')
endfunction


" Map the toggle function to a key, for example, <leader>t
nnoremap <silent> <leader>t :call ToggleMappings()<CR>
