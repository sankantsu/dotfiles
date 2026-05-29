" plugin ---------------------- {{{
execute pathogen#infect()
" }}}

""" general settings ---------------------- {{{

" language setting
language message en_US.utf8
language time en_US.utf8

" enable syntax highlight and filetype specific settings
syntax enable
filetype plugin on
filetype indent on

" use colors for dark background
set background=dark

" print the line number in front of each line
set number
set numberwidth=2

" status line setting
set laststatus=2
set statusline=%f\ %y\ %m\ %=\ %l,%c/%L

" display last line as much as possible (do not replace to '@')
set display+=lastline

" show bracket match
set showmatch
set matchtime=2

" allow backspacing over autoindent, line breaks, and start of insertiton
set backspace=indent,eol,start

" indent setting
set autoindent
set shiftwidth=4

" tab setting
set tabstop=8
set softtabstop=4
set smarttab
set expandtab

" always use system clipboard
set clipboard^=unnamedplus

" search setting
set ignorecase
set smartcase
set hlsearch
set incsearch

" command-line completion
set wildmenu
set wildmode=list:longest,full

" toggle paste mode
set pastetoggle=<F12>

" default filetype for *.tex
let g:tex_flavor = "latex"

" accept at character in control word
let g:tex_stylish = 1

" }}}

""" key mappings ---------------------- {{{

" set leader key ---------------------- {{{
let mapleader = ","
let maplocalleader = "\\"

noremap + ,
" }}}

" motions ---------------------- {{{

" left-right motions
noremap H ^
noremap L $
noremap ^ <nop>
noremap $ <nop>

" up-down motions
noremap <C-j> gj
noremap <C-n> gj
noremap <C-k> gk
noremap <C-p> gk

" other motions
noremap <C-h> H
noremap <C-l> L

" move aroung buffer list
nnoremap [b :<C-u>bprev<CR>
nnoremap ]b :<C-u>bnext<CR>

" move around quickfix list
nnoremap [c :<C-u>cprev<CR>
nnoremap ]c :<C-u>cnext<CR>

" move around tab pages
nnoremap <silent> [t :<C-u>execute "tabprevious " . v:count1<CR>
nnoremap <silent> ]t @=SwitchTab()<CR>
nnoremap [T :tabfirst<CR>
nnoremap ]T :tablast<CR>

" }}}

" search ---------------------- {{{

" very magic search
nnoremap g/ /\v
vnoremap g/ /\v

" }}}

" substitution ---------------------- {{{

" make & command to remember flags
nnoremap & :&&<CR>
xnoremap & :&&<CR>

" }}}

" normal mode ---------------------- {{{

" disable rarely used 2line deletion
nnoremap dj <nop>
nnoremap dk <nop>

" don't use register when delete a character
nnoremap x "_x

" yank until the end of the line
nnoremap Y y$

" insert text before the last character of the line
nnoremap gA $i

" Delete current line except line break
nnoremap <Leader>d 0D

" edit vimrc
nnoremap <Leader>ev :<C-u>vsplit $MYVIMRC<CR>

" toggle fold column
" nnoremap <leader>f :call FoldColumnToggle()<CR>

" Delete current line without overwriting register
nnoremap <leader>dd "_dd

" make first character of the word UPPER case
nnoremap <leader>gu wbgUl

" stop highlighting matches
nnoremap <Leader>ma :<C-u>match<CR>

" toggle number
nnoremap <leader>n :setlocal number!<CR>

" redraw
nnoremap <leader>rr :redraw!<CR>

" reset filetype
nnoremap <leader>sf :call ResetFileType()<CR>

" source vimrc
nnoremap <Leader>sv :<C-u>source $MYVIMRC<CR>

" swap the current word and the next word
nnoremap <leader>w :normal! dawwPb<CR>

" highlight trailing spaces
nnoremap <Leader>$ :<C-u>match Todo / \+$/<CR>

" clear screen and stop highlighting
nnoremap <silent> <ESC><ESC> :<C-u>nohlsearch<CR><C-l>

" }}}

" insert mode ---------------------- {{{

"  move forward/backword
inoremap <C-f> <Right>
inoremap <C-b> <Left>

" insert expression
inoremap <C-g><C-e> <C-r>=

" make current word to lowercase/uppercase
" *** don't work well in Visual-Block insert
inoremap <C-g>u <esc>viwuea
inoremap <C-g>U <esc>viwUea
inoremap <C-g><C-u> <esc>viwUea

" <C-z> : redraw, line at center of the window
inoremap <C-z> <C-o>zz

" break undo sequence when inserting new line
inoremap <CR> <C-g>u<CR>

" }}}

" command line mode ---------------------- {{{

" invoke command line window
execute "set cedit=\<C-q>"

" emacs style editing
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
cnoremap <C-a> <C-b>

" recall command line history
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <Up> <C-p>
cnoremap <Down> <C-n>
" }}}

" }}}

" abbreviations ---------------------- {{{

" horizontal line
iabbrev #- ----------------------

" }}}

" functions ---------------------- {{{

function! FoldColumnToggle()
    if &foldcolumn
	setlocal foldcolumn=0
    else
	setlocal foldcolumn=3
    endif
endfunction

function! ResetFileType()
    let ft = &filetype
    execute "set filetype=" . ft
endfunction

function! SwitchTab()
    " when current tabpage is last tabpage, switch to first tab
    if tabpagenr() == tabpagenr('$')
        tabfirst
    else
        tabnext
    endif
endfunction

" }}}
