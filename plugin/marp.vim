if exists('g:loaded_marp')
  finish
endif
let g:loaded_marp = 1

if !exists('g:marp_delimiter')
  let g:marp_delimiter = '---'
endif

command! MarpStart call marp#start(expand('%:p'))

command! -nargs=1 -complete=file MarpFileStart call marp#start(<q-args>)

nnoremap <Leader>ms :MarpStart<CR>
