""  VUNDLE
    set nocompatible
    filetype off

    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()

    Plugin 'VundleVim/Vundle.vim'

    "" Languages
        Plugin 'lervag/vimtex'

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

    " 2 spaces for ruby, erb, html, and js
    autocmd FileType html setlocal shiftwidth=2 tabstop=2 expandtab
    autocmd FileType ruby setlocal shiftwidth=2 tabstop=2 expandtab
    autocmd FileType eruby setlocal shiftwidth=2 tabstop=2 expandtab
    autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 expandtab

    "4 spaces on tab
    set tabstop=8
    set softtabstop=4
    set shiftwidth=4
    set expandtab
    filetype plugin indent on

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

    "Conceal level set to zero
    set conceallevel=0
    let g:indentLine_setConceal = 0

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

    " Toggles highlighting of extra whitespaces at the end of lines
    noremap <Leader>i :call WhitespaceToggle()<CR>

"" END MAPPING

"" FUNCTIONS

    " Dependent on vim fugitive
    function! GitInfo()
        let git = fugitive#head()
        if git != ''
            return 'ᚠ '.fugitive#head()
        else
            return ''
    endfunction


    " Highlights whitespace at the end of lines
    highligh DisableExtraWhitespace ctermbg=NONE guibg=NONE
    highlight ExtraWhitespace ctermbg=red guibg=red
    let g:whitespace_highlight_is_on = 0
    function! WhitespaceToggle()
        if g:whitespace_highlight_is_on
            match DisableExtraWhitespace /\s\+$/
            let g:whitespace_highlight_is_on = 0
        else
            match ExtraWhitespace /\s\+$/
            let g:whitespace_highlight_is_on = 1
        endif
    endfunction
"" END FUNCTIONS

"" STATUSLINE
    let currentmode={
        \ 'n'  : 'Normal ',
        \ 'no' : 'N·Operator Pending ',
        \ 'v'  : 'Visual ',
        \ 'V'  : 'V·Line ',
        \ '' : 'V·Block ',
        \ 's'  : 'Select ',
        \ 'S'  : 'S·Line ',
        \ '' : 'S·Block ',
        \ 'i'  : 'Insert ',
        \ 'R'  : 'Replace ',
        \ 'Rv' : 'V·Replace ',
        \ 'c'  : 'Command ',
        \ 'cv' : 'Vim Ex ',
        \ 'ce' : 'Ex ',
        \ 'r'  : 'Prompt ',
        \ 'rm' : 'More ',
        \ 'r?' : 'Confirm ',
        \ '!'  : 'Shell ',
        \ 't'  : 'Terminal '
        \}
    " Status line colors
    function! InsertStatuslineColor(mode)
        if a:mode == 'i'
            hi StatusLine term=reverse ctermfg=16 guifg=#282a36 ctermbg=84 guibg=#50fa7b
        elseif a:mode == 'r'
            hi StatusLine term=reverse ctermfg=15 guifg=#f8f8f2 ctermbg=160 guibg=#ff5555
        else
            hi StatusLine term=reverse ctermfg=16 guifg=#282a36 ctermbg=141 guibg=#bd93f9
        endif
    endfunction
    au InsertEnter * call InsertStatuslineColor(v:insertmode)
    au InsertChange * call InsertStatuslineColor(v:insertmode)
    au InsertLeave * hi StatusLine term=reverse ctermfg=16 guifg=#282a36 ctermbg=141 guibg=#bd93f9

    hi StatusLine term=reverse ctermfg=16 guifg=#282a36 ctermbg=141 guibg=#bd93f9

    set statusline=
    set statusline+=%0*\ %{toupper(g:currentmode[mode()])}   " Current mode
    set statusline+=%1*\ [%n]                                " buffernr
    set statusline+=%1*\ %{GitInfo()}                        " Git Branch name
    set statusline+=%1*\ %<%F\                               " File+path
    set statusline+=%1*%(\ [%R%M%H]%)                        " Readonly, modified, preview flags
    set statusline+=%*
    set statusline+=%1*\ %=                                  " Space
    set statusline+=%1*\ %y\                                 " FileType
    set statusline+=%0*\ ☰\ %l/%L\ %v                        " Rownumber/total (%)
    set statusline+=%0*\ %P\                                 " Percent of file viewed

"" END STATUSLINE
