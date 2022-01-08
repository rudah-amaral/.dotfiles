-- {{{ PLUGINS

local vimFolder
if vim.fn.has('nvim') == 1 then
  vimFolder = vim.fn.stdpath('config')
elseif vim.fn.has('unix') == 1 then
  vimFolder = vim.fn.expand('~/.vim')
else
  vimFolder = vim.fn.expand('~/vimfiles')
end

local vimPlugAutoload = vimFolder..'/autoload/plug.vim'
if vim.fn.empty(vim.fn.glob(vimPlugAutoload)) == 1 then
  local url = "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  local cmd = "silent execute '!curl -fLo "..vimPlugAutoload.. " --create-dirs "..url.."'"
  vim.api.nvim_command(cmd)
  vim.cmd("autocmd VimEnter * PlugInstall --sync | source $MYVIMRC")
end

Plug = vim.fn['plug#']
vim.fn["plug#begin"](vimFolder..'/plugged')
-- Vim-plug can manage itself
Plug 'junegunn/vim-plug'
-- The Big Guns™
Plug('neoclide/coc.nvim', {branch = 'release'})
Plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})
Plug 'SirVer/ultisnips'
Plug 'mattn/emmet-vim'
Plug 'lervag/vimtex'
-- Themes and alike
Plug 'shaunsingh/nord.nvim'
Plug('dracula/vim', {as = 'dracula'})
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
-- The ones that pack a punch
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-commentary'
Plug 'ThePrimeagen/vim-be-good'
Plug 'mateusbraga/vim-spell-pt-br'
vim.fn["plug#end"]()

-- }}}

-- {{{ PLUGINS SETTINGS

require('plugin-settings/CoC')
require('plugin-settings/tree-sitter')
require('plugin-settings/UltiSnips')
require('plugin-settings/vimtex')
require('plugin-settings/airline')
require('plugin-settings/fugitive')
require('plugin-settings/netrw')

-- }}}

-- {{{ VIM OPTIONS

-- " When in doubt call :help.
-- " Vim doesn't like keyboard layouts other than US-International, e.g. jumping
-- " through help tags is mapped with [c-ç] on a ABNT layout.
vim.cmd('colorscheme nord')
vim.cmd('filetype plugin indent on')
vim.g.mapleader = ' '
vim.opt.expandtab   = true -- Tabs are spaces
vim.opt.tabstop     = 2 -- 2 spaces
vim.opt.softtabstop = 2 -- A <BS> is 2 spaces
vim.opt.shiftwidth  = 2 -- >> and << is 2 spaces
vim.opt.shiftround  = true -- Identing is rounded to divisibles by 2
vim.opt.termguicolors = true
vim.opt.colorcolumn = '81'
vim.opt.textwidth = 80
vim.opt.showcmd = true
vim.opt.ruler = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.incsearch = true
vim.opt.showmatch = true
vim.opt.backspace = {'indent', 'eol', 'start'}
vim.opt.path:append('**')
vim.opt.wildmenu = true
vim.opt.clipboard:append('unnamedplus')
vim.opt.smartindent = true
vim.opt.signcolumn = 'yes'
vim.opt.scrolloff = 8
vim.opt.modeline = true

if vim.fn.has('vms') == 1 then
  vim.opt.backup = false -- VMs have their own backup settings.
else
  if vim.fn.isdirectory(vimFolder..'/backupdir') == 0 then
    vim.fn['mkdir'](vimFolder..'/backupdir')
  end

  if vim.fn.isdirectory(vimFolder..'/swpdir') == 0 then
    vim.fn['mkdir'](vimFolder..'/swpdir')
  end

  vim.opt.backup = true
  vim.opt.backupdir = vimFolder..'/backupdir'
  vim.opt.directory = vimFolder..'/swpdir'

  if vim.fn.has('persistent_undo') == 1 then
    if vim.fn.isdirectory(vimFolder..'/undodir') == 0 then
      vim.fn.mkdir(vimFolder..'/undodir')
    end

    vim.opt.undofile = true
    vim.opt.undodir = vimFolder..'/undodir'
  end
end

-- You can't highlight something with only two terminal colors.
local terminalColor = tonumber(vim.api.nvim_get_option('t_Co'))
if terminalColor > 2 or vim.fn.has('gui_running') then
  vim.opt.hlsearch = true
end

if vim.fn.has('folding') == 1 then
  vim.opt.foldenable = true
  vim.opt.foldmethod = "indent"
  vim.opt.foldlevelstart = 10
  vim.opt.foldnestmax = 10
end

-- }}}

-- MAPPINGS {{{

vim.api.nvim_set_keymap("i", "<c-c>", "<esc>", { noremap = true})

vim.api.nvim_set_keymap("n", "<up>", "<nop>", { noremap = true })
vim.api.nvim_set_keymap("n", "<down>", "<nop>", { noremap = true})
vim.api.nvim_set_keymap("n", "<left>", "<nop>", { noremap = true})
vim.api.nvim_set_keymap("n", "<right>", "<nop>", { noremap = true})
vim.api.nvim_set_keymap("n", "<leader><space>", "za", { noremap = true })
vim.api.nvim_set_keymap("n",
  "<leader>ev",
  ":sp $MYVIMRC<CR>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap("n",
  "<leader>h",
  ":nohls<CR>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap("n",
  "<leader>pv",
  ":wincmd v <bar> :Ex <bar> :vertical resize 30<CR>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap("n",
  "<leader>sv",
  ":source $MYVIMRC <bar> :doautocmd BufRead<CR>",
  { noremap = true, silent = true }
)

vim.api.nvim_set_keymap("v", "J", ":m '>+1<CR>gv=gv", { noremap = true })
vim.api.nvim_set_keymap("v", "K", ":m '<-2<CR>gv=gv", { noremap = true })

if vim.fn.has('clipboard') == 1 then
  vim.api.nvim_set_keymap("v", "<c-c>", '"+y<esc>', { noremap = true })
  vim.api.nvim_set_keymap("v", "<c-v>", 'v"+p<esc>', { noremap = true })
end

-- }}}

-- vim: foldmethod=marker: foldlevel=0
