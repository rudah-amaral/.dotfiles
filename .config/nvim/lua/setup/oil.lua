vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("oil").setup({
  keymaps = {
    ["<CR>"] = false,
    ["<C-J>"] = "actions.select",
    ["-"] = false,
    ["<C-K>"] = "actions.parent",
  },
})
