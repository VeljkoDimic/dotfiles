""  VUNDLE
    set nocompatible
    filetype off

    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()

    Plugin 'VundleVim/Vundle.vim'

    "" Languages
        Plugin 'sheerun/vim-polyglot'

    "" Linting
        Plugin 'w0rp/ale'

    "" Visual
        Plugin 'dracula/vim'
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

    "" Dispatch
        Plugin 'tpope/vim-dispatch'

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

    " 4 spaces on tab
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

    " Syntax highlighting
    syntax on

    " filetype plugin on
    set omnifunc=syntaxcomplete#Complete

    " reload files changed outside of vim
    set autoread

    " show incomplete commands
    set showcmd

    " Fix backspace in insert mode
    set backspace=2

    " Remove timeout in non-normal mode for escape
    set timeoutlen=1000 ttimeoutlen=0

    " Search up dir for tags until root
    set tags+=tags;/

    " Conceal level set to zero
    set conceallevel=0
    let g:indentLine_setConceal = 0

    " 'cw' type commands put $ at end, rather than just delete
    set cpoptions=ces$

    " Don't update display while executing macros
    set lazyredraw

    " Limit on syntax highlighting of long lines
    set synmaxcol=2048

    " Automatically insert header guard for .h files
    autocmd BufNewFile *.{h,hpp} call <SID>InsertHeaderGuard()

    " Save swapfiles, backups, and undofile in .vim
    set swapfile
    set directory=~/.vim/swapfiles//,.
    set undodir=~/.vim/undofiles//,.
    set undofile
    " Backup disabled for now
    set nobackup
    "set backup
    "set backupdir=~/.vim/backups//,.

    " On scope declarations in C, use 2 spaces before and after
    " class {
    "   public:
    "     a = a + 1;
    set cinoptions=g2h2
"" END VIM


""  MAPPING

    " set , as mapleader
    let mapleader = ","

    "map <Up> :echo("Use k")<CR>
    "map <Down> :echo("Use j")<CR>
    "map <Left> :echo("Use h")<CR>
    "map <Right> :echo("Use l")<CR>

    " resize horzontal split window
    nnoremap <Left> :vertical resize -5<cr>
    nnoremap <Right> :vertical resize +5<cr>
    " resize horizontal split window
    nnoremap <Up> :resize -5<cr>
    nnoremap <Down> :resize +5<cr>

    " <Leader>q -> prev buffer, <Leader>w -> next buffer
    nnoremap <leader>q :bp<CR>
    nnoremap <leader>w :bn<CR>

    " <Leader<Leader> -> last buffer
    nnoremap <Leader><Leader> <C-^>

    " <Leader>m -> cycle windows
    nnoremap <Leader>m <C-W>w

    " <Leader>b -> :b <C-D>
    nnoremap <Leader>b :b <C-D>

    " Dispatch mapping
    " <Leader>l -> calls Make
    " <Leader>l -> calls Make!
    nnoremap <Leader>l :Make<CR>
    nnoremap <Leader>L :Make!<CR>

    " Toggles highlighting of extra whitespaces at the end of lines
    nnoremap <Leader>i :call WhitespaceToggle()<CR>

    " Just use :TrimWhitespace to trim all whitespce at the end of all lines
    command! TrimWhitespace call TrimWhitespace()

    " Toggle number settings
    nnoremap <Leader>r :call CycleNumberSettings()<CR>

    " Copy the entire buffer. Useful for coding challenges
    nnoremap <Leader>y gg"+yG<C-o><C-o>
    nnoremap <Leader>Y ggyG<C-o><C-o>

    " Toggle between source and header files
    nnoremap <Leader>s :call SwitchSourceHeader()<CR>

    " Toggle between showing column at 80 or not
    nnoremap <Leader>v :call ToggleColorColumn()<CR>

    " Autocomplete to act more like vim and less like emacs
    inoremap <C-J> <C-N>
    inoremap <C-K> <C-P>

"" END MAPPING


"" ABBREVIATIONS

    " cout and endl with std
    iabbrev cout std::cout <<
    iabbrev endl std::endl;

"" END ABBREVIATIONS


"" MAKE
    " Note: :cn for next, :cp for prev, :cl for list, :cw for quickfix window

    "autocmd FileType cpp setlocal makeprg=make\ -C\ ../build
    autocmd FileType cpp setlocal makeprg=g++\ --std=c++14\ %
    autocmd FileType tex setlocal makeprg=pdflatex\ %
    autocmd FileType python setlocal makeprg=python\ %

"" END MAKE

"" LINTING
    " Don't run linter when typing
    let g:ale_lint_on_text_changed = 'never'

    " Off by default
    autocmd VimEnter * ALEDisable

"" END LINTING


"" FUNCTIONS

    " Dependent on vim fugitive. Used in statusline
    function! GitInfo()
        let git = fugitive#head()
        if git != ''
            return 'ᚠ '.fugitive#head()
        else
            return ''
    endfunction


    " Highlights whitespace at the end of lines

    " Colors and settings for whitespace
    highlight DisableExtraWhitespace ctermbg=NONE guibg=NONE
    highlight ExtraWhitespace ctermbg=208 guibg=#ffb86c
    set listchars=trail:· " Highlights trailing spaces with · characters
    set nolist " Default off
    match DisableExtraWhitespace /\s\+$/ " Defualt off
    let g:whitespace_highlight_is_on = 0 " Default off

    function! WhitespaceToggle()
        if g:whitespace_highlight_is_on
            match DisableExtraWhitespace /\s\+$/
            execute 'set nolist'
            let g:whitespace_highlight_is_on = 0
        else
            match ExtraWhitespace /\s\+$/
            execute 'set list'
            let g:whitespace_highlight_is_on = 1
        endif
    endfunction

    " Trims whitespace at the end of lines
    function! TrimWhitespace()
        let l:save = winsaveview()
        %s/\s\+$//e
        call winrestview(l:save)
    endfunction

    " Toggle through number settings and set appropriate number scheme
    function! CycleNumberSettings()
        if (&number == 0 && &relativenumber == 0)
            set number
        elseif (&number == 1 && &relativenumber == 0)
            set nonumber
            set relativenumber
        elseif (&number == 0 && &relativenumber == 1)
            set number
        else
            set nonumber
            set norelativenumber
        endif
    endfunction

    " default values
    set nonumber
    set relativenumber

    " Insert header guards for .h/.hpp files
    function! s:InsertHeaderGuard()
        let gatename = substitute(toupper(expand("%:t")), "\\.", "_", "g")
        execute "normal! i#ifndef " . gatename
        execute "normal! o#define " . gatename
        normal! o
        execute "normal! Go#endif /* " . gatename . " */"
        normal! k
    endfunction

    " Toggle between C++ header and source files
    function! SwitchSourceHeader()
        if (expand("%:e") == "cpp" || expand("%:e") == "cc")
            find %:t:r.h
        else
            find %:t:r.cc
        endif
    endfunction

    " Toggle showing column color or not
    function! ToggleColorColumn()
        if (&colorcolumn == 80)
            set colorcolumn=
        else
            set colorcolumn=80
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
