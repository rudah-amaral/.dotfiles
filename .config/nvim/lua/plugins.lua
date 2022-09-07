local packerPath = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
local isPackerFirstInstall
if vim.fn.empty(vim.fn.glob(packerPath)) == 1 then
  local packerRepo = "https://github.com/wbthomason/packer.nvim"
  isPackerFirstInstall = vim.fn.system({'git', 'clone', '--depth', '1', packerRepo, packerPath})
end

local get_setup = function(name, ext)
  if ext == "lua" then
    return string.format('require("setup/%s")', name)
  elseif ext == "vim" then
    local setupFolder = vim.fn.stdpath('config').."/lua/setup"
    return string.format("vim.cmd('source "..setupFolder.."/%s.vim')", name)
  end
end

local packer = require('packer')
packer.startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  -- The Big Guns™
  use {
    'neoclide/coc.nvim',
    branch = 'release',
    config = get_setup("CoC", "vim")
  }
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = get_setup("tree-sitter", "lua")
  }
  use {
    'SirVer/ultisnips',
    config = get_setup("UltiSnips", "vim")
  }
  use 'mattn/emmet-vim'
  use {
    'lervag/vimtex',
    config = get_setup("vimtex", "vim")
  }
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    },
    config = get_setup("telescope", "lua")
  }
  -- Themes and alike
  use {
    'shaunsingh/nord.nvim',
    config = get_setup("nord", "vim")
  }
  -- use {
  --   'dracula/vim',
  --   as = 'dracula'
  -- }

  -- use 'shaeinst/roshnivim-cs'
  -- use "rafamadriz/neon"
  -- use "tomasiser/vim-code-dark"
  -- use "Mofiqul/vscode.nvim"
  -- use "marko-cerovac/material.nvim"
  -- use "bluz71/vim-nightfly-guicolors"
  -- use "bluz71/vim-moonfly-colors"
  -- use "ChristianChiarulli/nvcode-color-schemes.vim"
  -- use "folke/tokyonight.nvim"
  -- use "sainnhe/sonokai"
  -- use "kyazdani42/blue-moon"
  -- use "mhartington/oceanic-next"
  -- use "glepnir/zephyr-nvim"
  -- use "rockerBOO/boo-colorscheme-nvim"
  -- use {
  --   "RishabhRD/nvim-rdark",
  --   requires = { 'tjdevries/colorbuddy.vim' }
  -- }
  -- use "ishan9299/modus-theme-vim"
  -- use "sainnhe/edge"
  -- use "theniceboy/nvim-deus"
  use {
    "bkegley/gloombuddy",
    requires = { 'tjdevries/colorbuddy.vim' }
  }
  -- use "Th3Whit3Wolf/one-nvim"
  -- use "PHSix/nvim-hybrid"
  -- use "Th3Whit3Wolf/space-nvim"
  -- use "yonlu/omni.vim"
  -- use "ray-x/aurora"
  use "tanvirtin/monokai.nvim"
  -- use "savq/melange"
  -- -- use "RRethy/nvim-base16"
  -- use "fenetikm/falcon"
  -- use "andersevenrud/nordic.nvim"
  -- use "ishan9299/nvim-solarized-lua"
  -- use "shaunsingh/moonlight.nvim"
  -- use "navarasu/onedark.nvim"
  -- use "lourenci/github-colors"
  -- use "sainnhe/gruvbox-material"
  -- use "sainnhe/everforest"
  -- use "NTBBloodbath/doom-one.nvim"
  use {
    "Mofiqul/dracula.nvim",
    setup = get_setup("dracula", "lua"),
    config = "vim.cmd[[colorscheme dracula]]"
  }
  -- use "yashguptaz/calvera-dark.nvim"
  -- use "nxvu699134/vn-night.nvim"
  -- use {
  --   "adisen99/codeschool.nvim",
  --   requires = {"rktjmp/lush.nvim"}
  -- }
  -- use "projekt0n/github-nvim-theme"
  -- use "kdheepak/monochrome.nvim"
  -- use "rose-pine/neovim"
  -- use "mcchrish/zenbones.nvim"
  -- use "catppuccin/nvim"
  -- use "FrenzyExists/aquarium-vim"
  -- use "EdenEast/nightfox.nvim"
  -- use "kvrohit/substrata.nvim"
  -- use "ldelossa/vimdark"
  -- use "Everblush/everblush.nvim"
  -- use "adisen99/apprentice.nvim"
  -- use "olimorris/onedarkpro.nvim"
  -- use "rmehri01/onenord.nvim"
  -- -- use {
  -- --   "RishabhRD/gruvy",
  -- --   requires = { 'rktjmp/lush.nvim' }
  -- -- }
  -- use "echasnovski/mini.nvim"
  -- use "luisiacc/gruvbox-baby"
  -- use "titanzero/zephyrium"
  -- use "rebelot/kanagawa.nvim"
  -- use "tiagovla/tokyodark.nvim"
  use "cpea2506/one_monokai.nvim"
  -- use "phha/zenburn.nvim"
  -- use "kvrohit/rasmus.nvim"
  -- use "chrsm/paramount-ng.nvim"
  -- -- requires 0.8.0-dev
  -- -- use {
  -- --   "kaiuri/nvim-juliana"
  -- -- }
  -- use "lmburns/kimbox"
  -- use "rockyzhang24/arctic.nvim"
  -- use { "meliora-theme/neovim", as = "meliora" }
  -- use "Yazeed1s/minimal.nvim"
  -- -- use "lewpoly/sherbet.nvim"

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = get_setup("lualine", "lua")
  }
  -- The ones that pack a punch
  use {
    'tpope/vim-fugitive',
    config = get_setup("fugitive", "vim")
  }
  use 'tpope/vim-unimpaired'
  use 'tpope/vim-surround'
  use {
    'numToStr/Comment.nvim',
    config = get_setup("Comment", "lua")
  }
  use 'ThePrimeagen/vim-be-good'
  use 'mateusbraga/vim-spell-pt-br'
  use {
    'editorconfig/editorconfig-vim',
    config = get_setup("EditorConfig", "vim")
  }
  use 'matze/vim-move'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if isPackerFirstInstall then
    packer.sync()
  end
end)

vim.cmd("source "..vim.fn.stdpath('config').."/lua/setup/netrw.vim")
vim.cmd("source "..vim.fn.stdpath('config').."/lua/setup/joke.vim")

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost ~/.config/nvim/lua/plugins.lua source % | PackerCompile
  augroup end
]])
