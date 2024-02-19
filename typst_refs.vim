let g:typst_anterior_ref = {}
function! HandleRef(state, items)
    let state = a:state
    for item in items
        r 
    endfor
endfunction
let g:typst_posterior_ref = {
    \'ref': 'HandleRef'
\}
let g:typst_enter_refs = [g:typst_posterior_ref, g:typst_anterior_ref]

"this stuff is used for ... something"
