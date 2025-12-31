return {
  {
    "Mofiqul/dracula.nvim",
    lazy = true,
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
    lazy = true,
    init = function()
      vim.g.everforest_enable_italic = true
      vim.cmd.colorscheme("everforest")
    end
  },
  {
    "folke/tokyonight.nvim",
    lazy = true,
    -- init = function()
    -- vim.cmd.colorscheme("tokyonight")
    -- end
  },
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    -- init = function()
    --   vim.cmd.colorscheme("gruvbox")
    -- end
  }
}
