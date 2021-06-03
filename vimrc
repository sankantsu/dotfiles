""" general settings ---------------------- {{{

" enable syntax highlight
syntax enable

" enable filetype plugin
filetype plugin on

" print the line number in front of each line
set number
set numberwidth=2

" show status line
set laststatus=2

" show the line and column number of the cursor position
set ruler

" show bracket match
set showmatch
set matchtime=2

" show a column which indicates open/close folds
" set foldcolumn=2

" allow backspacing over autoindent/line breaks/start of insert
set backspace=indent,eol,start

" indent setting
set autoindent
set shiftwidth=4

" search setting
set ignorecase
set smartcase
set hlsearch
set incsearch

" show candidates while tab completion
set wildmenu

" default filetype for *.tex
let g:tex_flavor = "latex"

" }}}

""" key mappings ---------------------- {{{

" leader key ---------------------- {{{
let mapleader = ","
let maplocalleader = "\\"

nnoremap + ,
vnoremap + ,
" }}}

" motions ---------------------- {{{

" left-right motions
nnoremap H ^
vnoremap H ^
nnoremap L $
vnoremap L $
nnoremap ^ <nop>
nnoremap $ <nop>

" up-down motions
nnoremap <C-j> gj
vnoremap <C-j> gj
nnoremap <C-k> gk
vnoremap <C-k> gk

" other motions
nnoremap <C-h> H
vnoremap <C-h> H
nnoremap <C-l> L
vnoremap <C-l> L

" move aroung buffer list
nnoremap [b :<C-u>bprev<CR>
nnoremap ]b :<C-u>bnext<CR>

" move around quickfix list
nnoremap [c :<C-u>cprev<CR>
nnoremap ]c :<C-u>cnext<CR>

" }}}

" search ---------------------- {{{

" very magic search
nnoremap g/ /\v
vnoremap g/ /\v

" make & command to remember flags
nnoremap & :&&<CR>
xnoremap & :&&<CR>

" }}}

" normal mode ---------------------- {{{

" yank until the end of the line
nnoremap Y y$

" insert text before the last character of the line
nnoremap gA $i

" Delete current line except line break
nnoremap <Leader>d 0D

" edit vimrc
nnoremap <Leader>ev :<C-u>vsplit $MYVIMRC<CR>
nnoremap <Leader>eV :<C-u>edit $MYVIMRC<CR>

" toggle fold column
nnoremap <leader>f :call FoldColumnToggle()<CR>

" stop highlighting matches
nnoremap <Leader>m :<C-u>match<CR>

" toggle number
nnoremap <leader>n :setlocal number!<CR>

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

" make current word to lowercase/uppercase
" *** don't work well in Visual-Block insert
inoremap <C-g>u <esc>viwuea
inoremap <C-g><C-u> <esc>viwUea
inoremap <C-g>U <esc>viwUea

" <C-z> : redraw, line at center of the window
inoremap <C-z> <C-o>zz

" }}}

" surround ---------------------- {{{
vnoremap " <ESC>`>a"<ESC>`<i"<ESC>`>2l
vnoremap ' <ESC>`>a'<ESC>`<i'<ESC>`>2l
vnoremap ( <ESC>`>a)<ESC>`<i(<ESC>`>2l
vnoremap ) <ESC>`>a)<ESC>`<i(<ESC>`>2l
vnoremap { <ESC>`>a}<ESC>`<i{<ESC>`>2l
vnoremap } <ESC>`>a}<ESC>`<i{<ESC>`>2l
vnoremap [ <ESC>`>a]<ESC>`<i[<ESC>`>2l
vnoremap ] <ESC>`>a]<ESC>`<i[<ESC>`>2l
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

" }}}

" plugin ---------------------- {{{
execute pathogen#infect()
" }}}
