local packerPath = vim.fn.stdpath("data").."/site/pack/packer/start/packer.nvim"
local isPackerFirstInstall
if vim.fn.empty(vim.fn.glob(packerPath)) == 1 then
  local packerRepo = "https://github.com/wbthomason/packer.nvim"
  isPackerFirstInstall = vim.fn.system({"git", "clone", "--depth", "1", packerRepo, packerPath})
end

local get_setup = function(name, ext)
  if ext == "lua" then
    return string.format("require(\"setup/%s\")", name)
  elseif ext == "vim" then
    local setupFolder = vim.fn.stdpath("config").."/lua/setup"
    return string.format("vim.cmd(\"source "..setupFolder.."/%s.vim\")", name)
  end
end

local packer = require("packer")
packer.startup(function(use)
  -- Packer can manage itself
  use "wbthomason/packer.nvim"
  -- The Big Guns™
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = get_setup("tree-sitter", "lua")
  }
  use {
    -- Manages LSPs, DAPs and formatters
    "williamboman/mason.nvim",
    requires = {
      -- Automatically sets up lua-language-server and +
      "folke/neodev.nvim",
      -- LSPs
      "neovim/nvim-lspconfig",
      "williamboman/mason-lspconfig.nvim",
    },
    config = get_setup("mason", "lua"),
  }
  use {
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = get_setup("cmp", "lua"),
  }
  use "mattn/emmet-vim"
  use {
    "lervag/vimtex",
    config = get_setup("vimtex", "vim")
  }
  use {
    "nvim-telescope/telescope.nvim",
    requires = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }
    },
    config = get_setup("telescope", "lua")
  }
  -- Themes and alike
  use {
    "sainnhe/everforest",
    config = "vim.cmd[[colorscheme everforest]]"
  }
  use {
    "Mofiqul/dracula.nvim",
    setup = get_setup("dracula", "lua"),
  }
  use {
    "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
    config = get_setup("lualine", "lua")
  }
  use {
    "xiyaowong/nvim-transparent",
    config = get_setup("nvim-transparent", "lua")
  }
  -- The ones that pack a punch
  use {
    "tpope/vim-fugitive",
    config = get_setup("fugitive", "vim")
  }
  use "tpope/vim-unimpaired"
  use "tpope/vim-surround"
  use {
    "numToStr/Comment.nvim",
    config = get_setup("Comment", "lua")
  }
  use "ThePrimeagen/vim-be-good"
  use "mateusbraga/vim-spell-pt-br"
  use {
    "editorconfig/editorconfig-vim",
    config = get_setup("EditorConfig", "vim")
  }
  use "matze/vim-move"

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if isPackerFirstInstall then
    packer.sync()
  end
end)

vim.cmd("source "..vim.fn.stdpath("config").."/lua/setup/netrw.vim")
vim.cmd("source "..vim.fn.stdpath("config").."/lua/setup/joke.vim")

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost ~/.config/nvim/lua/plugins.lua source % | PackerCompile
  augroup end
]])
