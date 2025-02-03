return {
  "lervag/vimtex",
  init = function()
    vim.cmd[[
    let g:vimtex_view_general_options
    \ = '-reuse-instance -forward-search @tex @line @pdf'
    \ . ' -inverse-search "' . exepath(v:progpath)
    \ . ' --servername ' . v:servername
    \ . ' --remote-send \"^<C-\^>^<C-n^>'
    \ . ':execute ''drop '' . fnameescape(''\%f'')^<CR^>'
    \ . ':\%l^<CR^>:normal\! zzzv^<CR^>'
    \ . ':call remote_foreground('''.v:servername.''')^<CR^>^<CR^>\""'
    let g:vimtex_matchparen_enabled = 0
    ]]
  end,
}

