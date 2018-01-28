""  VUNDLE
    set nocompatible
    filetype off

    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()

    Plugin 'VundleVim/Vundle.vim'

    "" Languages
        Plugin 'pangloss/vim-javascript'
        Plugin 'plasticboy/vim-markdown'
        Plugin 'tpope/vim-rails'
        Plugin 'derekwyatt/vim-scala'

    "" Visual
        Plugin 'dracula/vim'
        Plugin 'vim-airline/vim-airline'
        Plugin 'vim-airline/vim-airline-themes'
        Plugin 'Yggdroot/indentLine'    " Only if 'conceal' is compile with vim

    "" Git
        Plugin 'tpope/vim-fugitive'
        Plugin 'airblade/vim-gitgutter'
        Plugin 'Xuyuanp/nerdtree-git-plugin'

    "" Navigation
        Plugin 'kien/ctrlp.vim'
        Plugin 'scrooloose/nerdtree'
        Plugin 'easymotion/vim-easymotion'

    "" Text editing
        Plugin 'terryma/vim-multiple-cursors'
        Plugin 'tpope/vim-surround'
        Plugin 'scrooloose/nerdcommenter'

    "" Compiling/Syntax
        Plugin 'vim-syntastic/syntastic'

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

    " show term you are searching for and ignore case when all lower
    set incsearch
    set ignorecase
    set smartcase

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

    " <Leader><Leader<Leader> -> last buffer
    noremap <Leader><Leader><Leader> <C-^>

    " <Leader>m -> cycle windows
    noremap <Leader>m <C-W>w

    " <Leader>f -> next tab
    noremap <Leader>f :tabn<CR>

    " Map cll to type console.log in insert mode
    imap cll console.log();<Esc><Left>i

    "Maps NERDTreeToggle to control N
    map <C-n> :NERDTreeToggle<CR>

    " Multiple cursor mapping
    let g:multi_cursor_use_default_mapping=0
    let g:multi_cursor_next_key='<C-m>'
    let g:multi_cursor_prev_key='<C-p>'
    let g:multi_cursor_skip_key='<C-x>'
    let g:multi_cursor_quit_key='<Esc>'

    " EASYMOTION <Leader>s to search
    map  <Leader>s <Plug>(easymotion-sn)
    omap <Leader>s <Plug>(easymotion-tn)

    " Syntastic Check
    map <Leader>d :SyntasticCheck<CR>

"" END MAPPING


""  NERDTREE

    "Opens NERDTree if nothing specified in vim
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

""  END NERDTREE

"" SYNTASTIC

    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*

    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 1
    let g:syntastic_check_on_open = 1
    let g:syntastic_check_on_wq = 0

    "let g:syntastic_cpp_checkers = ['gcc']
    let g:syntastic_cpp_compiler = 'clang++'
    let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'

    " Sets to passive
    let g:syntastic_mode_map = {
            \ "mode": "passive",
            \ "active_filetypes": ["cpp"],
            \ "passive_filetypes": [] }

"" END SYNTASTIC
