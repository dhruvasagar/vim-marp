if exists('g:loaded_marp')
  finish
endif
let g:loaded_marp = 1

if !exists('g:marp_delimiter')
  let g:marp_delimiter = '---'
endif

command! MarpStart call marp#start(expand('%:p'))
command! MarpStop call marp#stop()

command! MarpFirst call marp#first_page()
command! MarpPrev call marp#prev_page()
command! MarpNext call marp#next_page()
command! MarpLast call marp#last_page()

command! -nargs=1 -complete=file MarpFileStart call marp#start(<q-args>)

nnoremap <Leader>ms :MarpStart<CR>
nnoremap <Leader>mS :MarpStop<CR>

nnoremap <Leader>mf :MarpFirst<CR>
nnoremap <Leader>mp :MarpPrev<CR>
nnoremap <Leader>mn :MarpNext<CR>
nnoremap <Leader>ml :MarpLast<CR>
