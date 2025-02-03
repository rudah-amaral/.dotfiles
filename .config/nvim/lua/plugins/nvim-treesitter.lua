return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  opts = {
    -- A list of parser names, or "all"
    ensure_installed = "all",

    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
  },
}
