if has('autocmd')
  augroup fugitive
    autocmd!
    autocmd BufReadPost fugitive://* set bufhidden=delete
  augroup END
endif
