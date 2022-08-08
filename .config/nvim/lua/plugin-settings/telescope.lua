require("telescope").setup {
  defaults = {
    sorting_strategy = "ascending",
    prompt_prefix = "(╯°□°)╯︵ ┻━┻  ",
    selection_caret = "😎👉 ",
    -- borderchars = { "😂", "🥰", "😔", "💘", "🖤", "😭", "😥", "😋", },
    -- border_joinchars = { "😏", "👌", "💪", "🥺", },
    file_ignore_patterns = {
      "backupdir",
      "undodir",
      "node_modules",
    },
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

require('telescope').load_extension('fzf')
