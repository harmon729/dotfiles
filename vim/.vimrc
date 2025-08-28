" Set nocompatible mode. This must be the first line.
set nocompatible


" -----------------------------------------------------------------------------
" # Startup & Health Checks
" -----------------------------------------------------------------------------

function! s:check_dependencies()
  " A dictionary of required command-line tools.
  " Key: command to check for.
  " Value: a descriptive name for the tool.
  let l:dependencies = {
  \ 'ag': 'The Silver Searcher (for faster searching in CtrlP and Ack.vim)',
  \ }

  let l:missing_deps = []
  for [l:cmd, l:desc] in items(l:dependencies)
    if !executable(l:cmd)
      call add(l:missing_deps, l:cmd . ' -> ' . l:desc)
    endif
  endfor

  if !empty(l:missing_deps)
    echohl WarningMsg
    echo "==================== ATTENTION ===================="
    echo "The following dependencies are missing for full functionality:"
    for l:dep in l:missing_deps
      echo " - " . l:dep
    endfor
    echo "Please install them using your system's package manager."
    echo "(e.g., 'brew install the_silver_searcher' or 'sudo apt install silversearcher-ag')"
    echo "==================================================="
    echohl None
  endif
endfunction

" Run the check upon starting Vim.
call s:check_dependencies()


" -----------------------------------------------------------------------------
" # Plugin Management (vim-plug)
" -----------------------------------------------------------------------------

" To use vim-plug, run this in your terminal:
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"
" Then, open Vim and run :PlugInstall to install the plugins.

call plug#begin('~/.vim/plugged')

" Appearance & UI
Plug 'itchyny/lightline.vim'
Plug 'joshdick/onedark.vim'
Plug 'altercation/vim-colors-solarized'

" File & Project Navigation
Plug 'preservim/nerdtree'
Plug 'kien/ctrlp.vim'
Plug 'mileszs/ack.vim' " For project-wide search

" Editing Enhancements
Plug 'easymotion/vim-easymotion'
Plug 'mbbill/undotree'
Plug 'jeetsukumaran/vim-buffergator'            " Buffer management
Plug 'https://git.sr.ht/~foosoft/vim-argwrap'   " Wrap arguments
Plug 'osyo-manga/vim-over'                      " Substitution previews
Plug 'tpope/vim-commentary'                     " Smart comment recognition
Plug 'sheerun/vim-polyglot'                     " Collection of language packs
Plug 'tpope/vim-surround'                       " Edit surroundings in pair

" Search
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-easymotion.vim'

" Git Integration
Plug 'tpope/vim-fugitive'

" Syntax, Linting, and Formatting
Plug 'dense-analysis/ale' " Asynchronous Lint Engine
Plug 'preservim/vim-markdown'

call plug#end()


" -------------------
" 
" -------------------

" Enable filetype detection, plugins, and indentation.
filetype plugin indent on

let g:mapleader = ','

set encoding=utf-8      " Use UTF-8 encoding
set shortmess+=I        " Disable the startup message
set hidden              " Allow buffers to be hidden without saving
set history=8192        " Increase command history
set lazyredraw          " Don't redraw screen during macros/scripts
set nojoinspaces        " Don't insert two spaces after a period
set noerrorbells        " Disable audible bell
set visualbell t_vb=    " Use visual bell instead
set autochdir           " Automatically change directory to the current file's dir
set nofoldenable        " Disable code folding by default

" Set persistent undo history
set undofile
set undodir=~/.vim/undodir
if !isdirectory(&undodir)
    call mkdir(&undodir, "p", 0700)
endif


" ----------------
" # UI Appearance
" ----------------

syntax enable
set number              " Show line numbers
set relativenumber      " Show relative line numbers
set ruler               " Always show cursor position
set showcmd             " Display incomplete commands
set laststatus=2        " Always show the status line
set noshowmode          " Hide the mode indicator (handled by lightline)
set showmatch           " Highlight matching brackets
set list                " Show invisible characters
set listchars=tab:▸\ ,trail:·,nbsp:~,extends:»,precedes:«
set showbreak=↪         " Character to show for wrapped lines
set wrap                " Wrap long lines
set linebreak           " Wrap lines at convenient places (don't break words)

" Scrolling behavior
set scrolloff=5         " Lines of context above/below the cursor
set sidescrolloff=10    " Columns of context to the left/right

" Window splitting behavior
set splitbelow          " New horizontal splits go below
set splitright          " New vertical splits go to the right

" Conditional color schemes and settings
augroup CursorLineOnlyInActiveWindow
    autocmd!
    autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    autocmd WinLeave * setlocal nocursorline
augroup END

if has('gui_running')
    colorscheme onedark
    let g:lightline = {'colorscheme': 'onedark'}
elseif &t_Co < 256
    colorscheme default
    set nocursorline " Looks bad in low-color terminals
else
    set termguicolors   " Enable 24-bit RGB color in the TUI
    set background=dark
    let onedark_terminal_italics = 1
    colorscheme onedark
    let g:lightline = {'colorscheme': 'onedark'}
endif


" -------------------
" # Editing Behavior
" -------------------

" Indentation
set expandtab           " Use spaces instead of tabs
set tabstop=4           " Number of spaces a <Tab> counts for
set shiftwidth=4        " Number of spaces to use for auto-indent
set softtabstop=4       " Number of spaces a <Tab> in insert mode counts for
set smartindent         " Be smart about indentation

" Backspace behavior
set backspace=indent,eol,start " Allow backspacing over everything in insert mode

" Search
set incsearch           " Show search results as you type
set hlsearch            " Highlight all search matches
set ignorecase          " Ignore case when searching...
set smartcase           " ...unless the query contains an uppercase letter
set wrapscan            " Searches wrap around the end of the file

" Tab completion for files/buffers
set wildmenu
set wildmode=longest:full,full

" Mouse support
set mouse+=a
if &term =~ '^screen'
    " Fix mouse reporting in tmux
    set ttymouse=xterm2
endif

" Performance
" Fixes slow escape key in some terminals
set timeout timeoutlen=1000 ttimeoutlen=100


" ---------------
" # Key Mappings
" ---------------

" --- General ---
" Fast saving
nnoremap <leader>w :w<CR>

" Clear search highlighting
nnoremap <silent> <leader><CR> :nohlsearch<CR>

" Toggle relative line numbering
nnoremap <C-n> :set relativenumber!<CR>

" Remap ESC in insert mode for faster exit
inoremap jk <Esc>

" Sudo save a read-only file
command -nargs=0 Sudow w !sudo tee % > /dev/null

" Unbind inconvenient default keys
map <C-a> <Nop>
map <C-x> <Nop>
nmap Q <Nop> " Disable Ex mode

" --- Window Management ---
" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" --- Movement ---
" Toggle movement by visual lines vs. logical lines
nnoremap <silent> <leader>d :call ToggleMovementByDisplayLines()<CR>
function! SetMovementByDisplayLines()
    noremap <buffer> <silent> <expr> j v:count ? 'j' : 'gj'
    noremap <buffer> <silent> <expr> k v:count ? 'k' : 'gk'
    noremap <buffer> <silent> 0 g0
    noremap <buffer> <silent> $ g$
endfunction
function! ToggleMovementByDisplayLines()
    if !exists('b:movement_by_display_lines') || b:movement_by_display_lines == 0
        let b:movement_by_display_lines = 1
        call SetMovementByDisplayLines()
        echo "Movement by display lines ON"
    else
        let b:movement_by_display_lines = 0
        silent! unmap <buffer> j
        silent! unmap <buffer> k
        silent! unmap <buffer> 0
        silent! unmap <buffer> $
        echo "Movement by display lines OFF"
    endif
endfunction

" --- Personal Preference: Enforce Vim Habits ---
" Disable arrow keys to force usage of h,j,k,l.
" This is a personal choice for learning and efficiency.
nnoremap <Left>  :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up>    :echoe "Use k"<CR>
nnoremap <Down>  :echoe "Use j"<CR>
inoremap <Left>  <ESC>:echoe "Use h"<CR>
inoremap <Right> <ESC>:echoe "Use l"<CR>
inoremap <Up>    <ESC>:echoe "Use k"<CR>
inoremap <Down>  <ESC>:echoe "Use j"<CR>


" ------------------------
" # Plugin Configurations
" ------------------------

" --- NERDTree: File explorer ---
nnoremap <leader>t :NERDTreeToggle<CR>
nnoremap <leader>f :NERDTreeFind<CR>

" --- BufferGator: Buffer explorer ---
let g:buffergator_suppress_keymaps = 1
nnoremap <leader>b :BuffergatorToggle<CR>

" --- Undotree: Visualize undo history ---
nnoremap <Leader>u :UndotreeToggle<CR>

" --- CtrlP: Fuzzy file finder ---
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_show_hidden = 1
" Use 'ag' (The Silver Searcher) for faster searches if available
if executable('ag')
    let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
endif

" --- ack.vim / ag: Project-wide search ---
if executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif
" Custom command to search from git root
command -nargs=+ Gag Gcd | Ack! <args>
" Search for the word under the cursor
nnoremap K :Gag "\b<C-R><C-W>\b"<CR>:cw<CR>

" --- ALE: Asynchronous Lint Engine ---
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_enter = 1
let g:ale_lint_on_save = 1
let g:ale_signs_enable = 1
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_fix_on_save = 1
nnoremap <silent> <Leader>x :ALEFix<CR>
nmap <silent> [g <Plug>(ale_previous_wrap)
nmap <silent> ]g <Plug>(ale_next_wrap)

" --- EasyMotion: Enhanced movement ---
map <Space> <Plug>(easymotion-prefix)

" --- incsearch: Improved incremental search ---
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" --- incsearch-easymotion ---
map z/  <Plug>(incsearch-easymotion-/)
map z?  <Plug>(incsearch-easymotion-?)
map zg/ <Plug>(incsearch-easymotion-stay)

" --- ArgWrap: Wrap/unwrap arguments ---
nnoremap <Leader>a :ArgWrap<CR>

" --- vim-over: Preview substitutions ---
noremap <Leader>s :OverCommandLine<CR>

" --- vim-markdown ---
let g:markdown_fenced_languages = [
    \ 'asm', 'bash=sh', 'c', 'coffee', 'erb=eruby', 'go', 'haskell',
    \ 'javascript', 'json', 'perl', 'python', 'racket', 'ruby', 'rust', 'yaml'
\]
let g:markdown_syntax_conceal = 0
let g:markdown_folding = 1

" --- Fugitive: Git wrapper ---
" Set git tags file for completion
set tags^=.git/tags;~

" --- CtrlP mapping (needs to be after plugin loaded) ---
nnoremap ; :CtrlPBuffer<CR>


" ------------------------------------
" # Local and Personal Customizations
" ------------------------------------
" Place any machine-specific or personal overrides in this file.
" It is sourced last and is not meant to be checked into version control.
let $LOCALFILE=expand("~/.vimrc_local")
if filereadable($LOCALFILE)
    source $LOCALFILE
endif

