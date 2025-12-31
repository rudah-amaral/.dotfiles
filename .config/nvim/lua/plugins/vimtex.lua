return {
  "lervag/vimtex",
  init = function()
    vim.g.vimtex_compiler_method = "latexmk"
    vim.g.vimtex_view_general_viewer = "okular"

    vim.cmd [[
      let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
    ]]
  end,
}
