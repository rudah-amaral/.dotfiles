let g:netrw_banner = 0
let g:netrw_liststyle = 0

function s:netrwMappings() abort
  call s:substituteRemaps("<CR>", "<c-j>", "n")
  call s:substituteRemaps("-",    "<c-k>", "n")
endfunction

function! s:substituteRemaps(oldTrigger, newTrigger, mode) abort
  let l:rhs = maparg(a:oldTrigger, a:mode)
  let l:canUnmapOld = !empty(l:rhs)

  if l:canUnmapOld
    call s:unmap(a:mode, a:oldTrigger)
  endif

  let l:canMapNew = empty(maparg(a:newTrigger, a:mode))
  if l:canMapNew
    call s:map(a:mode, a:newTrigger, l:rhs)
  endif
endfunction

function! s:unmap(mode, lhs) abort
  if a:mode == "n"
    let l:unmapCommand = "nunmap"
  endif

  execute(printf("%s <buffer> %s", l:unmapCommand, a:lhs))
endfunction

function! s:map(mode, lhs, rhs) abort
  if a:mode == "n"
    let l:mapCommand = "nnoremap"
  endif

  execute(printf("%s <buffer> %s %s", l:mapCommand, a:lhs, a:rhs))
endfunction

augroup netrwMappings
  autocmd!
  autocmd FileType netrw unsilent call s:netrwMappings()
augroup END
