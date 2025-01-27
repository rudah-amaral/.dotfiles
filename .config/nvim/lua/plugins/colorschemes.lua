return {
  {
    "Mofiqul/dracula.nvim",
    init = function()
      -- show the '~' characters after the end of buffers
      vim.g.dracula_show_end_of_buffer = true
      -- use transparent background
      vim.g.dracula_transparent_bg = true
      -- set custom lualine background color
      vim.g.dracula_lualine_bg_color = "#44475a"
      -- set italic comment
      vim.g.dracula_italic_comment = true
    end
  },
  {
    "sainnhe/everforest",
    init = function()
      vim.g.everforest_enable_italic = true
    end
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    init = function()
      vim.cmd.colorscheme("tokyonight")
    end
  }
}
