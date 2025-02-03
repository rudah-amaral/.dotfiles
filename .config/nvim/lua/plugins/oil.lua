return {
  "stevearc/oil.nvim",
  dependencies = {
    "kyazdani42/nvim-web-devicons",
    lazy = true,
  },
  opts = {
    keymaps = {
      ["<CR>"] = false,
      ["<C-J>"] = "actions.select",
      ["-"] = false,
      ["<C-K>"] = "actions.parent",
    },
  },
  init = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
  end,
}
