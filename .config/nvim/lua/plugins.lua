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
    "neoclide/coc.nvim",
    branch = "release",
    config = get_setup("CoC", "vim")
  }
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = get_setup("tree-sitter", "lua")
  }
  use {
    "SirVer/ultisnips",
    config = get_setup("UltiSnips", "vim")
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
    "Mofiqul/dracula.nvim",
    setup = get_setup("dracula", "lua"),
    config = "vim.cmd[[colorscheme dracula]]"
  }
  use {
    "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
    config = get_setup("lualine", "lua")
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
