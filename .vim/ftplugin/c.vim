set signcolumn=yes
nnoremap <buffer> <F9>
    \ :w<CR>:exec '!make'<cr>

nnoremap <buffer> <C-F9>
    \ :w<CR>:exec '!make' shellescape(@%, 1)
    \ '&&' shellescape(expand('%:r'), 1)<cr>

nnoremap <buffer> <S-F9>
    \ :w<CR>:exec '!gcc' shellescape(@%, 1)
    \ '&&' shellescape(expand('%:r'), 1) ''<c-f>h<c-c>
