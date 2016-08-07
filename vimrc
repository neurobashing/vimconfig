" don't bother with vi compatibility
set nocompatible
" enable syntax highlighting
syntax enable
" ensure ftdetect et al work by including this after the Vundle stuff
filetype plugin indent on

set autoindent
" reload files when changed on disk, i.e. via `git checkout`
set autoread
" Fix broken backspace in some setups
set backspace=2
" see :help crontab
set backupcopy=yes
" yank and paste with the system clipboard
set clipboard=unnamed
" don't store swapfiles in the current directory
set directory-=.
set encoding=utf-8
" expand tabs to spaces
set expandtab
" case-insensitive search
set ignorecase
" search as you type
set incsearch
" always show statusline
set laststatus=2
" show trailing whitespace
set list
" show line numbers
set number
" show where you are
set ruler
" show context above/below cursorline
set scrolloff=3
set showcmd
" case-sensitive search if any caps
set smartcase
" actual tabs occupy 4 characters
set tabstop=4
set wildignore=log/**,node_modules/**,target/**,tmp/**,*.rbc
" show a navigable menu for tab completion
set wildmenu
set wildmode=longest,list,full

" Enable basic mouse behavior such as resizing buffers.
set mouse=a
if exists('$TMUX')  " Support resizing in tmux
  set ttymouse=xterm2
endif

" keyboard shortcuts
let mapleader = ','
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
map <silent> <leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>
" insert a fat comma (hashrocket if you're ruby/nasty) w/ ctrl l
imap <c-l> <space>=><space>

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  let g:ackprg = 'ag --nogroup --column'

  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" fdoc is yaml
autocmd BufRead,BufNewFile *.fdoc set filetype=yaml
" md is markdown
autocmd BufRead,BufNewFile *.md set filetype=markdown
" automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =

" Fix Cursor in TMUX
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

set listchars=tab:▸\ ,eol:¬,trail:·
set laststatus=2
" in theory this will fix fugitive problems
set shell=/bin/bash

set hidden

" replicate cmd-[ and cmd-] (eg from bbedit)
" to move visual selection
vmap <D-[> <gv
vmap <D-]> >gv

" keyboard shortcuts
inoremap jj <ESC>

set bg=dark
" gui settings
if (&t_Co == 256 || has('gui_running'))
  colorscheme spacegray
endif
set guifont=Hack:h14
set guioptions-=T
set visualbell " fuck donk noises
set cursorline " highlight the current line

" fix indents etc
autocmd BufNewFile,BufRead *.py setlocal ts=4 sts=4 sw=4
autocmd BufNewFile,BufRead *.pl,*.pm,*.cgi,*.tt2 setlocal noet ci pi ts=4 sts=0 sw=4
autocmd BufNewFile,BufRead *.html setlocal ts=4 sts=4 sw=4
autocmd BufNewFile,BufRead *.md setlocal ts=4 sts=4 sw=4
" autocmd BufNewFile,BufRead *.go setlocal ts=4 sts=4 sw=4
au BufNewFile,BufRead *.tt2 setf tt2html " or just setf tt2 if there's no HTML anywhere, or setf tt2js if you need to
au BufNewFile,BufRead *.tt2 setlocal noet ci pi ts=4 sts=0 sw=4
au FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd BufNewFile,BufRead *.js setlocal ts=2 sts=2 sw=2
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
" au FileType make set noexpandtab
au FileType snippet setlocal ts=8 sts=8 sw=8 noet

" when you select a file in the loclist/quickfind, close it
autocmd FileType qf nmap <buffer> <cr> <cr>:lcl<cr>
autocmd FileType gitconfig setlocal noet ci pi ts=4 sts=0 sw=4

set wildignore+=.hg,.git,.svn                    " Version control
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.DS_Store                       " OSX bullshit
set wildignore+=*.pyc                            " Python byte code
" these are actually not ignored by CtrlP because by default MX uses `ag` not
" its native dingus. BUT `ag` respects .gitignore and friends (including
" .agignore) so you can unfuck it there.
set wildignore+=*/bower_components/*               " ugh
set wildignore+=*/.komodotools/*               " double ugh
set wildignore+=*/.idea/*               " this is annoying
set wildignore+=*.komodoproject                 " fuck tha police

" format current buffer
nnoremap <leader>Ft mZggVG=`Zzz

nnoremap H 0
nnoremap L $

set statusline=%t\        "tail of the filename
set statusline+=\ %h      "help file flag
set statusline+=\ %m      "modified flag
set statusline+=\ %r      "read only flag
set statusline+=\ %y      "filetype
set statusline+=%=      "left/right separator
set statusline+=\ %c,     "cursor column
set statusline+=\ %l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file

"define :Tidy command to run perltidy on visual selection || entire buffer"
command! -range=% -nargs=* Tidy <line1>,<line2>!perltidy

"run :Tidy on entire buffer and return cursor to (approximate) original position"
fun! DoTidy()
    let l = line(".")
    let c = col(".")
    :Tidy
    call cursor(l, c)
endfun

"shortcut for normal mode to run on entire buffer then return to current line"
au Filetype perl nmap <F2> :call DoTidy()<CR>

"shortcut for visual mode to run on the the current visual selection"
au Filetype perl vmap <F2> :Tidy<CR>

command! -nargs=* Bounce !ssh dev-gthomason "web bounce" <CR>

command! -nargs=1 JIRA execute 'silent !open https://jira.thinkgeek.com/browse/SPHORB-<args>'

fun! FindFixme()
  :lvimgrep /TODO\|FIXME/gj %
  :lopen
endfun
nmap <leader>F :call FindFixme()<CR>

" turn completion on but don't scan included files
set complete=.,w,b,u,t,
