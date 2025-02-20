return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "kyazdani42/nvim-web-devicons",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
  },
  opts = {
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
  },
  init = function()
    vim.keymap.set("n", "<leader>tf",
      "<cmd>lua require('telescope.builtin').find_files()<cr>",
      { noremap = true })

    vim.keymap.set("n", "<leader>tg",
      "<cmd>lua require('telescope.builtin').live_grep()<cr>", { noremap = true })

    vim.keymap.set("n", "<leader>t/",
      "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>",
      { noremap = true })

    vim.keymap.set("n", "<leader>tc",
      "<cmd>lua require('telescope.builtin').colorscheme()<cr>",
      { noremap = true })

    vim.keymap.set("n", "<leader>tb",
      "<cmd>lua require('telescope.builtin').buffers()<cr>", { noremap = true })

    vim.keymap.set("n", "<leader>ev", function()
      vim.cmd("new")
      vim.cmd("lcd " .. vim.fn.stdpath("config"))
      require("telescope.builtin").find_files()
    end)

    vim.keymap.set("n", "<leader>th", function()
      require("telescope.builtin").help_tags()
    end, { noremap = true })

    require("telescope").load_extension("fzf")
  end,
}
