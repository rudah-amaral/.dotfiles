local packerPath = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
local packerFirstInstall
if vim.fn.empty(vim.fn.glob(packerPath)) == 1 then
  local url = "https://github.com/wbthomason/packer.nvim"
  packerFirstInstall = vim.fn.system({'git', 'clone', '--depth', '1', url, packerPath})
end

require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  -- The Big Guns™
  use {
    'neoclide/coc.nvim',
    branch = 'release'
  }
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use 'SirVer/ultisnips'
  use 'mattn/emmet-vim'
  use 'lervag/vimtex'
  -- Themes and alike
  use 'shaunsingh/nord.nvim'
  use {
    'dracula/vim',
    as = 'dracula'
  }
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'
  use 'ryanoasis/vim-devicons'
  -- The ones that pack a punch
  use 'tpope/vim-fugitive'
  use 'tpope/vim-unimpaired'
  use 'tpope/vim-commentary'
  use 'ThePrimeagen/vim-be-good'
  use 'mateusbraga/vim-spell-pt-br'
  use 'matze/vim-move'
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packerFirstInstall then
    require('packer').sync()
  end
end)

vim.cmd('source ~/.config/nvim/lua/plugin-settings/CoC.vim')
vim.cmd('luafile ~/.config/nvim/lua/plugin-settings/tree-sitter.lua')
vim.cmd('source ~/.config/nvim/lua/plugin-settings/UltiSnips.vim')
vim.cmd('source ~/.config/nvim/lua/plugin-settings/vimtex.vim')
vim.cmd('source ~/.config/nvim/lua/plugin-settings/airline.vim')
vim.cmd('source ~/.config/nvim/lua/plugin-settings/fugitive.vim')
vim.cmd('source ~/.config/nvim/lua/plugin-settings/netrw.vim')

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost ~/.config/nvim/lua/plugin-settings/packer.lua source % | PackerCompile
  augroup end
]])
