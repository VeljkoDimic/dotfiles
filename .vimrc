""  VUNDLE
    set nocompatible
    filetype off

    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()

    Plugin 'VundleVim/Vundle.vim'

    "" Languages

    "" Visual
        Plugin 'dracula/vim'
        "Plugin 'vim-airline/vim-airline'
        Plugin 'Yggdroot/indentLine'    " Only if 'conceal' is compile with vim

    "" Git
        Plugin 'tpope/vim-fugitive'
        Plugin 'airblade/vim-gitgutter'

    "" Navigation

    "" Text editing
        Plugin 'tpope/vim-surround'
        Plugin 'scrooloose/nerdcommenter'

    "" Searching
        Plugin 'mileszs/ack.vim'

    call vundle#end()
    filetype plugin indent on
""  END VUNDLE


"" VIM

    " Theme
    set background=dark
    color dracula

    " Always display status bar
    set laststatus=2

    " 2 spaces for ruby, erb, and html
    autocmd FileType html setlocal shiftwidth=2 tabstop=2 expandtab
    autocmd FileType ruby setlocal shiftwidth=2 tabstop=2 expandtab
    autocmd FileType eruby setlocal shiftwidth=2 tabstop=2 expandtab

    "4 spaces on tab
    filetype plugin indent on
    set tabstop=4
    set shiftwidth=4
    set expandtab

    " Disable visualbell
    set visualbell
    set t_vb=

    " Recursively search subdirectories
    set path+=**

    " Display all matches on tab complete
    set wildmenu

    " show term you are searching for and ignore case when all lower
    set incsearch
    set ignorecase
    set smartcase

    " Smart indenting
    set autoindent
    set smartindent

    "Syntax highlighting
    syntax on

    "Line number
    set number

    "filetype plugin on
    set omnifunc=syntaxcomplete#Complete

    "reload files changed outside of vim
    set autoread

    "show incomplete commands
    set showcmd

    "Fix backspace in insert mode
    set backspace=2

    "Remove timeout in non-normal mode for escape
    set timeoutlen=1000 ttimeoutlen=0

    "Search up dir for tags until root
    set tags+=tags;/

"" END VIM


""  MAPPING

    " set , as mapleader
    let mapleader = ","

    "map <Up> :echo("Use k")<CR>
    "map <Down> :echo("Use j")<CR>
    "map <Left> :echo("Use h")<CR>
    "map <Right> :echo("Use l")<CR>

    " resize horzontal split window
    nmap <Left> :vertical resize -5<cr>
    nmap <Right> :vertical resize +5<cr>
    " resize horizontal split window
    nmap <Up> :resize -5<cr>
    nmap <Down> :resize +5<cr>

    " <Leader>q -> prev buffer, <Leader>w -> next buffer
    noremap <leader>q :bp<CR>
    noremap <leader>w :bn<CR>

    " <Leader<Leader> -> last buffer
    noremap <Leader><Leader> <C-^>

    " <Leader>m -> cycle windows
    noremap <Leader>m <C-W>w

    " <Leader>f -> next tab
    noremap <Leader>f :tabn<CR>

    " <Leader>b -> :b <C-D>
    noremap <Leader>b :b <C-D>

"" END MAPPING
