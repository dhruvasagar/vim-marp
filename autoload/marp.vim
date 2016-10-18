function! s:readfile(file)
  return readfile(a:file)
endfunction

function! s:init(file)
  let s:tmpsession = tempname()
  exec 'mksession!' s:tmpsession
  tabnew
  tabonly
  setf markdown
  setl buftype=nofile bufhidden=wipe nobuflisted
  " exec 'file!' expand(a:file)
endfunction

function! s:header()
  return get(g:, 'marp_header', '')
endfunction

function! s:footer()
  return get(g:, 'marp_footer', s:page_number . '/' . s:total_pages)
endfunction

function! s:paginate(lines)
  let page = []
  let pages = []
  for line in a:lines
    if line =~# g:marp_delimiter
      call add(pages, page)
      let page = []
    else
      call add(page, line)
    endif
  endfor

  call add(pages, page)

  let s:pages = pages
  let s:page_number = 1
  let s:total_pages = len(pages)
endfunction

function! s:set_page()
  let content = []
  call add(content, s:header())
  call extend(content, s:pages[s:page_number - 1])
  call add(content, s:footer())

  normal! ggdG
  call setline(1, content)
endfunction

function! s:first_page()
  if s:page_number != 1
    let s:page_number = 1
    call s:set_page()
  endif
endfunction

function! s:prev_page()
  if !exists('s:page_number') || s:page_number > 1
    let s:page_number -= 1
    call s:set_page()
  endif
endfunction

function! s:next_page()
  if s:page_number < s:total_pages
    let s:page_number += 1
    call s:set_page()
  endif
endfunction

function! s:last_page()
  if s:page_number != s:total_pages
    let s:page_number = s:total_pages
    call s:set_page()
  endif
endfunction

function! marp#start(file)
  call s:init(a:file)
  let content = s:readfile(a:file)
  call s:paginate(content)
  call s:set_page()
endfunction

function! marp#first_page()
  call s:first_page()
endfunction

function! marp#prev_page()
  call s:prev_page()
endfunction

function! marp#next_page()
  call s:next_page()
endfunction

function! marp#last_page()
  call s:last_page()
endfunction

function! marp#stop()
  unlet s:pages
  unlet s:page_number
  unlet s:total_pages

  if filereadable(s:tmpsession)
    exec 'source' s:tmpsession
  endif
endfunction
