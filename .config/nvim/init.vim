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
  Plug 'arcticicestudio/nord-vim'
  Plug 'dracula/vim', {'as': 'dracula'}

  " Requires compiling. Latest info on GitHub repository.
  Plug 'ycm-core/YouCompleteMe'

  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'

  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-unimpaired'

  Plug 'lervag/vimtex'

  Plug 'mateusbraga/vim-spell-pt-br'

  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'
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

" ycm-core/YouCompleteMe
set encoding=utf-8
let g:ycm_filetype_blacklist = {'tex': 1}
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1

" let g:airline_theme = 'solarized'
let g:airline_theme = 'nord'
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
" }}}

" {{{ VIM OPTIONS

" When in doubt call :help.
" Vim doesn't like keyboard layouts other than US-International, e.g. jumping
" through help tags is mapped with [c-ç] on a ABNT layout.

filetype plugin indent on
set modeline

set expandtab
set tabstop=2
set shiftwidth=2
set shiftround
let mapleader=','
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

nnoremap <leader><space> :nohls<CR>
nnoremap <leader>ev :sp $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC <bar> :doautocmd BufRead<CR>

nnoremap <space> za

if has('clipboard')
  vnoremap <c-c> "+y<esc>
  vnoremap <c-v> v"+p<esc>
endif

" }}}

" vim: foldmethod=marker: foldlevel=0