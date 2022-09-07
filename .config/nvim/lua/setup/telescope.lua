require("telescope").setup {
  defaults = {
    sorting_strategy = "ascending",
    prompt_prefix = "(╯°□°)╯︵ ┻━┻  ",
    selection_caret = "😎👉 ",
    -- borderchars = { "😂", "🥰", "😔", "💘", "🖤", "😭", "😥", "😋", },
    -- border_joinchars = { "😏", "👌", "💪", "🥺", },
    file_ignore_patterns = {
      "swpdir",
      "backupdir",
      "undodir",
      "node_modules",
    },
  },
  pickers = {
    colorscheme = {
      theme = "dropdown",
      prompt_prefix = "",
      layout_config = {
        width = 0.2,
        height = 0.8,
        anchor = "E",
      },
      enable_preview = true,
    }
  }
}

vim.api.nvim_set_keymap(
  "n",
  "<leader>tf",
  "<cmd>lua require('telescope.builtin').find_files()<cr>",
  { noremap = true }
)

vim.api.nvim_set_keymap(
  "n",
  "<leader>tg",
  "<cmd>lua require('telescope.builtin').live_grep()<cr>",
  { noremap = true }
)

vim.api.nvim_set_keymap(
  "n",
  "<leader>t/",
  "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>",
  { noremap = true }
)

vim.api.nvim_set_keymap(
  "n",
  "<leader>tc",
  "<cmd>lua require('telescope.builtin').colorscheme()<cr>",
  { noremap = true }
)

require('telescope').load_extension('fzf')
