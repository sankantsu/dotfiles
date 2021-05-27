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

" }}}

""" general key mappings ---------------------- {{{

" leader key
let mapleader = "\\"
let maplocalleader = "+"

" <ESC><ESC> : clear screen and stop highlighting
" nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>
nnoremap <silent> <ESC><ESC> :<C-u>nohlsearch<CR><C-l>

" make & command to remember flags
nnoremap & :&&<CR>
xnoremap & :&&<CR>

" gA: insert text before the last character of the line
nnoremap gA $i

" Y: yank until the end of the line
nnoremap Y y$

" display line motion
nnoremap <C-j> gj
vnoremap <C-j> gj
nnoremap <C-k> gk
vnoremap <C-k> gk

" insert mode

" <C-f> , <C-b> : move forward/backword
inoremap <C-f> <Right>
inoremap <C-b> <Left>

" i_ctrl-g_u
" <C-g>u <C-g><C-u> / <C-g>U : make current word to lowercase/uppercase
" *** don't work well in Visual-Block insert
inoremap <C-g>u <esc>viwuea
inoremap <C-g><C-u> <esc>viwUea
inoremap <C-g>U <esc>viwUea

" i_ctrl-z
" <C-z> : redraw, line at center of the window
inoremap <C-z> <C-o>zz

" experimental key mappings ---------------------- {{{

" edit vimrc
nnoremap <Leader>ev :<C-u>vsplit $MYVIMRC<CR>
nnoremap <Leader>eV :<C-u>edit $MYVIMRC<CR>
" source vimrc
nnoremap <Leader>sv :<C-u>source $MYVIMRC<CR>

nnoremap H ^
vnoremap H ^
nnoremap L $
vnoremap L $
nnoremap ^ <nop>
nnoremap $ <nop>
nnoremap <C-h> H
vnoremap <C-h> H
" nnoremap <C-l> L
" vnoremap <C-l> L

" very magic search
nnoremap g/ /\v
vnoremap g/ /\v

" highlight trailing spaces
nnoremap <Leader>L :<C-u>match Todo / \+$/<CR>

" stop highlighting matches
nnoremap <Leader>m :<C-u>match<CR>

" grep the word under the cursor
" nnoremap <Leader>g :execute "grep -R " . shellescape(expand("<cWORD>")) . " ."<CR>:copen<CR><C-l>

nnoremap <leader>f :call FoldColumnToggle()<CR>

function! FoldColumnToggle()
    if &foldcolumn
	setlocal foldcolumn=0
    else
	setlocal foldcolumn=3
    endif
endfunction

" toggle number
nnoremap <leader>n :setlocal number!<CR>

" swap the current word and the next word
nnoremap <leader>w :normal! dawwPb<CR>

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

" horizontal line
iabbrev #- ----------------------

" move around quickfix list
nnoremap [c :<C-u>cprev<CR>
nnoremap ]c :<C-u>cnext<CR>

" move aroung buffer list
nnoremap [b :<C-u>bprev<CR>
nnoremap ]b :<C-u>bnext<CR>

" }}}

" comment out current line ---------------------- {{{
augroup commenting
    autocmd!
    autocmd  FileType  c       nnoremap <buffer>  <LocalLeader>C  I// <ESC>
    autocmd  FileType  python  nnoremap <buffer>  <LocalLeader>C  I# <ESC>
    autocmd  FileType  tex     nnoremap <buffer>  <LocalLeader>C  I% <ESC>
    autocmd  FileType  vim     nnoremap <buffer>  <LocalLeader>C  I" <ESC>
augroup END

" uncomment
nnoremap <LocalLeader>c ^df <CR>

" visual mode mappings
vnoremap <LocalLeader>C :normal <LocalLeader>C<CR>
vnoremap <LocalLeader>c :normal! ^df <CR>
" }}}

" tex file settings ---------------------- {{{

" default filetype for *.tex
let g:tex_flavor = "latex"

augroup filetype_tex
    autocmd!
    " abbreviations
    autocmd FileType tex iabbrev <buffer> docjs \documentclass[dvipdfmx]{jsarticle}
    autocmd FileType tex iabbrev <buffer> docbm \documentclass[dvipdfmx]{beamer}
    autocmd FileType tex iabbrev <buffer> begfr \begin{frame}\frametitle
    autocmd FileType tex iabbrev <buffer> endfr \end{frame}
    autocmd FileType tex iabbrev <buffer> begit \begin{itemize}
    autocmd FileType tex iabbrev <buffer> endit \end{itemize}
    autocmd FileType tex iabbrev <buffer> begdsc \begin{description}
    autocmd FileType tex iabbrev <buffer> enddsc \end{description}
    " text enviroment
    autocmd FileType tex vnoremap <buffer> <LocalLeader>b <ESC>`>a}<ESC>`<i\textbf{<ESC>`>2l
    autocmd FileType tex vnoremap <buffer> <LocalLeader>d <ESC>`>x`<df{
augroup END
" }}}

" Vimscript file settings ---------------------- {{{
augroup filetype_vim
    autocmd!
    " marker based folding
    autocmd FileType vim setlocal foldmethod=marker
    " source current file
    autocmd FileType vim nnoremap <buffer> <LocalLeader>s :source %<CR>
augroup END
" }}}
