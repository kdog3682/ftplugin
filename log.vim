syntax match ExclamationLine "^ *!.*$"
highlight ExclamationLine ctermfg=red guifg=red

inoreab <buffer>pj package.json<C-R>=Eatchar('\s')<CR>
