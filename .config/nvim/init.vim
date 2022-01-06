if has('nvim')
  let vimFolder = stdpath('config')
elseif has('unix')
  let vimFolder = expand('~/.vim')
else
  let vimFolder = expand('~/vimfiles')
endif

" {{{ VIM PLUG

let vimPlugFile = vimFolder.'/autoload/plug.vim'

if empty(glob(vimPlugFile))
  silent execute '!curl -fLo '.vimPlugFile.' --create-dirs'
        \ ' https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(vimFolder.'/plugged')
  " vim-plug help tags
  Plug 'junegunn/vim-plug'

  " Themes, remember to set terminal colors all well
  Plug 'altercation/vim-colors-solarized'
  " Plug 'arcticicestudio/nord-vim'
  Plug 'shaunsingh/nord.nvim'
  Plug 'dracula/vim', {'as': 'dracula'}

  Plug 'ryanoasis/vim-devicons'

  " Requires compiling. Latest info on GitHub repository.
  " Plug 'ycm-core/YouCompleteMe'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'

  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-unimpaired'
  Plug 'tpope/vim-commentary'

  Plug 'ThePrimeagen/vim-be-good'

  Plug 'lervag/vimtex'

  Plug 'mateusbraga/vim-spell-pt-br'

  Plug 'SirVer/ultisnips'
  " I'll be creating my own snippets
  " Plug 'honza/vim-snippets'
  Plug 'mattn/emmet-vim'

  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
call plug#end()

" }}}

" {{{ PLUGINS SETTINGS

" altercation/vim-colors-solarized
syntax enable
set background=dark
" colorscheme solarized
" call togglebg#map('<F5>')

colorscheme nord

" colorscheme dracula

lua require('plugin-settings/CoC')

" let g:airline_theme = 'solarized'
let g:airline_theme = 'base16_nord'
" let g:airline_theme = 'dracula'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

let g:vimtex_view_general_options
  \ = '-reuse-instance -forward-search @tex @line @pdf'
  \ . ' -inverse-search "' . exepath(v:progpath)
  \ . ' --servername ' . v:servername
  \ . ' --remote-send \"^<C-\^>^<C-n^>'
  \ . ':execute ''drop '' . fnameescape(''\%f'')^<CR^>'
  \ . ':\%l^<CR^>:normal\! zzzv^<CR^>'
  \ . ':call remote_foreground('''.v:servername.''')^<CR^>^<CR^>\""'
" let g:vimtex_imaps_enabled = 0
" let g:vimtex_imaps_leader = ';'
let g:vimtex_matchparen_enabled = 0

let g:UltiSnipsExpandTrigger="<c-j>"

lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true
  },
  additional_vim_regex_highlighting = false,
}
EOF

" }}}

" {{{ VIM OPTIONS

" When in doubt call :help.
" Vim doesn't like keyboard layouts other than US-International, e.g. jumping
" through help tags is mapped with [c-ç] on a ABNT layout.

filetype plugin indent on
set modeline

set expandtab " Tabs are spaces
set tabstop=2 " 2 spaces
set softtabstop=2 " A <BS> is 2 spaces
set shiftwidth=2 " >> and << is 2 spaces
set shiftround " Identing is rounded to divisibles by 2
let mapleader=' '
set colorcolumn=81 textwidth=80
set showcmd
set ruler
set number
set relativenumber
set cursorline
set incsearch
set showmatch
set backspace=indent,eol,start,
set path+=**
set wildmenu
set termguicolors
set clipboard+=unnamedplus
set smartindent
set scrolloff=8
set signcolumn=yes

if has('vms')
  set nobackup " VMs have their own backup settings.
else
  if !isdirectory(vimFolder.'/backupdir')
    call mkdir(vimFolder.'/backupdir')
  endif

  if !isdirectory(vimFolder.'/swpdir')
    call mkdir(vimFolder.'/swpdir')
  endif

  set backup
  let &backupdir = vimFolder.'/backupdir'
  let &directory = vimFolder.'/swpdir'

  if has('persistent_undo')
    if !isdirectory(vimFolder.'/undodir')
      call mkdir(vimFolder.'/undodir')
    endif

    set undofile
    let &undodir = vimFolder.'/undodir'
  endif
endif

" You can't highlight something with only two terminal colors.
if &t_Co > 2 || has('gui_running')
  set hlsearch
endif

if has('gui_running')
  set guifont=DejaVu_Sans_Mono_for_Powerline:h14:cANSI:qDRAFT
endif

if has('folding')
  set foldenable
  set foldmethod=indent
  set foldlevelstart=10
  set foldnestmax=10
endif

" }}}

" {{{ VIM VARIABLES

" let g:python_recommended_style=0
let g:netrw_banner = 0
let g:netrw_liststyle = 3

" }}}

" {{{ MY FUNCTIONS

" }}}

" {{{ AUTOCMDS

if has('autocmd')
  augroup vimrc
    autocmd!
    autocmd BufReadPost fugitive://* set bufhidden=delete
  augroup END
endif

" }}}

" MAPPINGS {{{

nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <c-c> <esc>

nnoremap <leader>h :nohls<CR>
nnoremap <leader>ev :sp $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC <bar> :doautocmd BufRead<CR>

nnoremap <leader><space> za
nnoremap <leader>pv :wincmd v <bar> :Ex <bar> :vertical resize 30<CR>
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

if has('clipboard')
  vnoremap <c-c> "+y<esc>
  vnoremap <c-v> v"+p<esc>
endif

" }}}

" vim: foldmethod=marker: foldlevel=0
