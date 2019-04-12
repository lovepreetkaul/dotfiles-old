" Author:        Lovepreet Singh
" Description:   This is my personal .vimrc file.
"
" As the help says 'Make vim behave in a more useful way'
" **Must be first uncommented line**
set nocompatible

"
" Custom Functions
"

" Remove trailing whitespace
" http://vim.wikia.com/wiki/Remove_unwanted_spaces
function! StripTrailingWhitespace()
    if !&binary && &filetype != 'diff'
        normal mz
        normal Hmy
        %s/\s\+$//e
        normal 'yz<cr>
        normal `z
        retab
    endif
endfunction

" Function to hide all the text except for the text selected in visual mode.
" This is great for highlighting parts of the code. Just call the function
" again to deselect everything.
function! ToggleSelected(visual) range
    highlight HideSelected ctermfg=bg ctermbg=bg
                         \ guifg=bg guibg=bg gui=none term=none cterm=none

    if exists('g:toggle_selected_hide')
        call matchdelete(g:toggle_selected_hide)

        unlet g:toggle_selected_hide
        redraw

        if !a:visual
            return
        endif
    endif

    let [lnum1, col1] = getpos(''<')[1:2]
    let [lnum2, col2] = getpos(''>')[1:2]

    let pattern = '\%^\|\%<'.lnum1.'l\|\%<'.col1.'v\|\%>'.lnum2.'l\|\%>'.col2.'v'
    let g:toggle_selected_hide = matchadd('HideSelected', pattern, 1000)

    redraw
endfunction


"
" Global Settings
"

" The default 20 isn't nearly enough
set history=200

" Show the numbers on the left of the screen
set number

" Show the column/row
set ruler

" Set mouse to not select line numbers
set mouse=a

" Highlight only the lines that go past 80 characters
highlight ColorColumn ctermbg=green guibg=green
call matchadd('ColorColumn', '\%82v', 100)

" Pretty colors are fun, yayyy
syntax on

" Show the matching when doing a search
set showmatch

" Allows the backspace to delete indenting, end of lines, and over the start
" of insert
set backspace=indent,eol,start

" Ignore case when doing a search as well as highlight it as it is typed
set ignorecase smartcase
set hlsearch
set incsearch

" Don't show the startup message
set shortmess=I

" Show the current command at the bottom
set showcmd

" Disable beeping and flashing.
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

" Use smarter defaults
set smartindent
set smarttab

" Use autoindenting
set autoindent

" The tabstop look best at 4 spacing
set tabstop=4
set softtabstop=4
set shiftwidth=4

" I have been converted to the dark side, I will use spaces to indent code
" from here on out
set expandtab

" Buffer Settings
set hidden

" Better completion
set completeopt+=longest,menuone

" Setting omnifunc for YCM
set omnifunc=syntaxcomplete#Complete

" Turn on persistent undo
" Thanks, Mr Wadsten: github.com/mikewadsten/dotfiles/
if has('persistent_undo')
    set undodir=~/.vim/undo//
    set undofile
    set undolevels=1000
    set undoreload=10000
endif

" The comma makes a great leader of men, heh heh
let mapleader = ','
let maplocalleader = '\'

" Show two lines for the status line
set laststatus=2

" Always show the last line
set display+=lastline

" UTF-8 THIS SHITTTTTT
set encoding=utf-8

" Enhanced mode for command-line completion
set wildmenu

" Automatically re-read the file if it has changed
set autoread

" Fold Settings

" Off on start
set nofoldenable

" Indent seems to work the best
set foldmethod=indent
set foldlevel=20

" Toggling paste mode
set pastetoggle=<F2>

"
" Global Bindings
"

" Disable ex mode, ick, remap it to Q instead.
"
" Tip:
"   Use command-line-window with q:
"   Use search history with q/
"
" More info:
" http://blog.sanctum.geek.nz/vim-command-window/
"nmap Q q

" Show only selected in Visual Mode
nmap <silent> <leader>th :cal ToggleSelected(0)<cr>
vmap <silent> <leader>th :cal ToggleSelected(1)<cr>

" Split the window using some nice shortcuts
nmap <leader>s<bar> :vsplit<cr>
nmap <leader>s- :split<cr>
nmap <leader>s? :map <leader>s<cr>

" Unhighlight the last search pattern on Enter
nn <silent> <cr> :nohlsearch<cr><cr>

" Control enhancements in insert mode
imap <C-F> <right>
imap <C-B> <left>
imap <M-BS> <esc>vBc
imap <C-P> <up>
imap <C-N> <down>

" Non quitting analog of ZZ
nmap zz :w<cr>

" When pushing j/k on a line that is wrapped, it navigates to the same line,
" just to the expected location rather than to the next line
nnoremap j gj
nnoremap k gk

" Use actually useful arrow keys
map <right> :bn<cr>
map <left> :bp<cr>
map <up> <nop>
map <down> <nop>

" Map Ctrl+V to paste in Insert mode
imap <C-V> <C-R>*

" Map Ctrl+C to copy in Visual mode
vmap <C-C> "+y

" Add paste shortcut
nmap <leader>P "+p

" Ignore some defaults
set wildignore=*.o,*.obj,*~,*.pyc
set wildignore+=.env
set wildignore+=.env[0-9]+
set wildignore+=.git,.gitkeep
set wildignore+=.tmp
set wildignore+=.coverage
set wildignore+=*DS_Store*
set wildignore+=.sass-cache/
set wildignore+=__pycache__/
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=.tox/**
set wildignore+=.idea/**
set wildignore+=*.egg,*.egg-info
set wildignore+=*.png,*.jpg,*.gif
set wildignore+=*.so,*.swp,*.zip,*/.Trash/**,*.pdf,*.dmg,*/Library/**,*/.rbenv/**
set wildignore+=*/.nx/**,*.app

" Fold Keybindings
"nnoremap <space> za

"
" Custom Settings
"

" Set on textwidth when in markdown files
autocmd FileType markdown set textwidth=80

" Smarter completion in C
autocmd FileType c set omnifunc=ccomplete#Complete

" My own special flavoring to running programs
"autocmd FileType asm,c,objc,scheme,sh,python,perl,javascript nn <leader>R :!deepThought.sh '%:p'<cr>

" Use 2 spaces when in Lua & Ruby
autocmd FileType lua,ruby set tabstop=2
autocmd FileType lua,ruby set shiftwidth=2

"
" Vim-plug Plugin Manager
"

" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes
Plug 'vim-syntastic/syntastic'
Plug 'vim-airline/vim-airline'
"Plug 'valloric/youcompleteme'
Plug 'tpope/vim-surround'
Plug 'altercation/vim-colors-solarized'
Plug 'arcticicestudio/nord-vim'
" Initialize plugin system
call plug#end()

"
" Custom Plugin Settings
"

" Airline
set encoding=utf-8
set laststatus=2
let g:airline_powerline_fonts=1

" Nord Theme
colorscheme nord
