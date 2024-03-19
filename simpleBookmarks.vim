function! QuickOpen() abort
  call s:ReadBookmarks()
  let store = []

  " ec g:simple_bookmarks_storage
  " return
  " ec g:simple_bookmarks_storage
  " return
  " let c = 0
  " for [name, place] in items(g:simple_bookmarks_storage)
    " let [filename, cursor, line] = place

    " let entry = {
            " \ 'name': name,
            " \ 'text': line,
            " \ 'index': c,
            " \ 'filename': filename,
            " \ 'lnum':     cursor[1],
            " \ 'col':      cursor[2],
            " \ }
    " let c += 1
    " call add(store, entry)

    function! Display(val)
        throw a:val
        return a:val[0]
        let val = a:val
        return GetFiletype(val[1][0]) . " : " . val[0]
    endfunction

    function! Access(val)
        return a:val[0]
    endfunction


    call FzfCallback(g:simple_bookmarks_storage, '_OpenBookmark', 'Display', 'Access')
endfunction

function! _OpenBookmark(val)
    let [filename, cursor, line] = a:val
    exe 'edit '.filename
    call setpos('.', cursor)

  let line_pattern = BuildPattern(line)
  if g:simple_bookmarks_use_pattern && getline('.') !~# line_pattern
    keeppatterns let found_line = search(line_pattern, 'cn')

    if found_line
      let cursor[1] = found_line
      let g:simple_bookmarks_storage[a:name][1] = cursor
      call s:WriteBookmarks()
      call setpos('.', cursor)
    endif
  endif
endfunction


function! s:ReadBookmarks() abort
  let bookmarks      = {}
  let files          = {}
  let bookmarks_file = fnamemodify(g:simple_bookmarks_filename, ':p')

  if !filereadable(bookmarks_file)
    call writefile([], bookmarks_file)
  endif

  for line in readfile(bookmarks_file)
    let parts = split(line, "\t")

    let name   = parts[0]
    let file   = parts[1]
    let cursor = split(parts[2], ':')
    let line   = get(parts, 3, '')

    let bookmarks[name] = [file, cursor, line]

    if g:simple_bookmarks_signs || g:simple_bookmarks_highlight
      " then we'll index by filename
      if !has_key(files, file)
        let files[file] = []
      endif

      call add(files[file], cursor)
    endif
  endfor

  let g:simple_bookmarks_storage         = bookmarks
  let g:simple_bookmarks_storage_by_file = files
endfunction

nnoremap qo :call QuickOpen()<CR>

