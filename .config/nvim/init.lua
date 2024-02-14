vim.g.mapleader = " "

require("plugins")

-- {{{ VIM OPTIONS

-- " When in doubt call :help.
-- " Vim doesn't like keyboard layouts other than US-International, e.g. jumping
-- " through help tags is mapped with [c-ç] on a ABNT layout.
vim.opt.expandtab      = true -- Tabs are spaces
vim.opt.tabstop        = 2    -- 2 spaces
vim.opt.softtabstop    = 2    -- A <BS> is 2 spaces
vim.opt.shiftwidth     = 2    -- >> and << is 2 spaces
vim.opt.shiftround     = true -- Identing is rounded to divisibles by 2
vim.opt.termguicolors  = true
vim.opt.colorcolumn    = "81"
vim.opt.textwidth      = 80
vim.opt.showcmd        = true
vim.opt.number         = true
vim.opt.relativenumber = true
vim.opt.cursorline     = true
vim.opt.showmatch      = true
vim.opt.wildmenu       = true
vim.opt.smartindent    = true
vim.opt.scrolloff      = 8
vim.opt.modeline       = true
vim.opt.clipboard:append("unnamedplus")
vim.opt.path:append("**")
vim.opt.undofile = true
vim.opt.diffopt:append("linematch:60")

if vim.fn.has("folding") == 1 then
  vim.opt.foldenable     = true
  vim.opt.foldmethod     = "indent"
  vim.opt.foldlevelstart = 10
  vim.opt.foldnestmax    = 10
end

-- }}}

-- MAPPINGS {{{

local imap = require("mapper").imap
local nmap = require("mapper").nmap
local vmap = require("mapper").vmap

imap("<c-c>", "<esc>")

nmap("<up>", "<nop>")
nmap("<down>", "<nop>")
nmap("<left>", "<nop>")
nmap("<right>", "<nop>")
nmap("<leader><space>", "za")
nmap("<leader>ev", ":sp $MYVIMRC | lcd %:h<CR>", { silent = true })
nmap("<leader>h", ":nohls<CR>", { silent = true })
nmap("<leader>pv", ":Oil<CR>", { silent = true })
nmap("<leader>sv", ":luafile ~/.config/nvim/init.lua<cr>")
nmap("[d", ": lua vim.diagnostic.goto_prev()<cr>", { silent = true })
nmap("]d", ": lua vim.diagnostic.goto_next()<cr>", { silent = true })

vmap("<leader>do", ":diffget<CR>", { silent = true })
vmap("<leader>dp", ":diffput<CR>", { silent = true })

-- }}}

local highlight_group = vim.api.nvim_create_augroup("YankHighlight",
  { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    require("vim.highlight").on_yank({ timeout = 5000 })
  end,
  group = highlight_group,
  pattern = "*",
})

-- vim: foldmethod=marker: foldlevel=0
