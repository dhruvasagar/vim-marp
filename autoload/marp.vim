function! s:readfile(file)
  return readfile(a:file)
endfunction

function! s:toggle_marp_mode()
  let g:marp_mode = !get(g:, 'marp_mode', 0)
  if g:marp_mode
    command! MarpStop call marp#stop()
    command! MarpFirst call marp#first_page()
    command! MarpPrev call marp#prev_page()
    command! MarpNext call marp#next_page()
    command! MarpLast call marp#last_page()

    nnoremap q :MarpStop<CR>
    nnoremap mf :MarpFirst<CR>
    nnoremap mp :MarpPrev<CR>
    nnoremap mn :MarpNext<CR>
    nnoremap ml :MarpLast<CR>

    nnoremap <Up> :MarpFirst<CR>
    nnoremap <Left> :MarpPrev<CR>
    nnoremap <Right> :MarpNext<CR>
    nnoremap <Down> :MarpLast<CR>
  else
    delcommand MarpStop
    delcommand MarpFirst
    delcommand MarpPrev
    delcommand MarpNext
    delcommand MarpLast 

    nunmap q
    nunmap mf
    nunmap mp
    nunmap mn
    nunmap ml
    nunmap <Up>
    nunmap <Left>
    nunmap <Right>
    nunmap <Down>
  end
endfunction

function! s:init(file)
  call s:toggle_marp_mode()

  let s:tmpsession = tempname()
  exec 'mksession!' s:tmpsession
  tabnew
  tabonly
  setf markdown
  setl buftype=nofile bufhidden=wipe nobuflisted
  " exec 'file!' expand(a:file)
endfunction

function! s:header()
  return [get(g:, 'marp_header', '')]
endfunction

function! s:footer()
  let footer = get(g:, 'marp_footer', s:page_number . '/' . s:total_pages)
  let padding = repeat('-', (80 - len(footer))/2)
  return ['', printf(padding.g:marp_footer_format.padding, 2+len(footer)/2, footer, 2-len(footer)/2,'')]
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
  let content += s:header()
  let content += s:pages[s:page_number - 1]
  let content += s:footer()

  %delete
  call setline(1, content)
endfunction

function! s:first_page()
  if exists('s:page_number') && s:page_number != 1
    let s:page_number = 1
    call s:set_page()
  endif
endfunction

function! s:prev_page()
  if exists('s:page_number') && s:page_number > 1
    let s:page_number -= 1
    call s:set_page()
  endif
endfunction

function! s:next_page()
  if exists('s:page_number') && s:page_number < s:total_pages
    let s:page_number += 1
    call s:set_page()
  endif
endfunction

function! s:last_page()
  if exists('s:page_number') && s:page_number != s:total_pages
    let s:page_number = s:total_pages
    call s:set_page()
  endif
endfunction

function! s:toggle_goyo()
  if g:marp_use_goyo && exists(':Goyo')
    Goyo
  endif
endfunction

function! marp#start(file)
  call s:init(a:file)
  let content = s:readfile(a:file)
  call s:paginate(content)
  call s:set_page()
  call s:toggle_goyo()
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
  call s:toggle_marp_mode()

  unlet s:pages
  unlet s:page_number
  unlet s:total_pages

  call s:toggle_goyo()

  if filereadable(s:tmpsession)
    exec 'source' s:tmpsession
  endif
endfunction
