nnoremap <space><space> /(<>)<CR>"_c4l
                         \<esc>:nohls<CR>a
inoremap ;bf \textbf{}<space>(<>)<esc>F{a
inoremap ;i \textit{}<space>(<>)<esc>F{a
inoremap ;be \begin{placeholder}<cr>
             \ a<bs><bs><cr>
             \\end{placeholder}<cr>
             \(<>)<esc>:-3,-1s/placeholder//g <bar>
             \ exe "norm k" <bar>
             \ startinsert!<c-f>F/i
inoremap ;ol
             \ \begin{enumerate}<esc>o
               \\item<space><esc>o
             \\end{enumerate}<esc>o
             \(<>)<esc>2kA
inoremap ;ul
             \ \begin{itemize}<esc>o
               \\item<space><esc>o
             \\end{itemize}<esc>o
             \(<>)<esc>2kA
inoremap ;ni <CR>\item<space>
inoremap ;' `'(<>)<esc>T`i
inoremap ;" ``''(<>)<esc>T`i
