if exists('g:loaded_marp')
  finish
endif
let g:loaded_marp = 1

if !exists('g:marp_delimiter')
  let g:marp_delimiter = '---'
endif

if !exists('g:marp_footer_format')
  let g:marp_footer_format = '%*s%*s'
endif

if !exists('g:marp_use_goyo')
  let g:marp_use_goyo = 1
endif

command! MarpStart call marp#start(expand('%:p'))

command! -nargs=1 -complete=file MarpFileStart call marp#start(<q-args>)

nnoremap <Leader>ms :MarpStart<CR>
