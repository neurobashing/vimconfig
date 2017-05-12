set nocompatible " don't bother with vi compatibility
filetype off " required for vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" bundles here
Plugin 'VundleVim/Vundle.vim' " required.
Plugin 'tpope/vim-commentary'
Plugin 'majutsushi/tagbar'
Plugin 'mtth/scratch.vim' " https://github.com/mtth/scratch.vim
Plugin 'pangloss/vim-javascript'
Plugin 'mustache/vim-mustache-handlebars' " https://github.com/mustache/vim-mustache-handlebars
Plugin 'vim-perl/vim-perl' "https://github.com/vim-perl/vim-perl
Plugin 'tpope/vim-fugitive'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'davidhalter/jedi-vim'
Plugin 'nvie/vim-flake8'
Plugin 'scrooloose/syntastic'
Plugin 'alessandroyorba/sidonia' " colorscheme sidona, https://github.com/AlessandroYorba/Sidonia
Plugin 'colepeters/spacemacs-theme.vim' " colorscheme spacemacs-theme, https://github.com/colepeters/spacemacs-theme.vim
Plugin 'vimwiki/vimwiki'
Plugin 'ctrlpvim/ctrlp.vim.git'
Plugin 'SirVer/ultisnips'
Plugin 'neurobashing/snipmate-snippets.git'
call vundle#end()            " required
syntax enable " enable syntax highlighting
filetype plugin indent on " ensure ftdetect et al work by including this after the Vundle stuff

set autoindent
set autoread " reload files when changed on disk, i.e. via `git checkout`
set backspace=2 " Fix broken backspace in some setups
set backupcopy=yes " see :help crontab
set clipboard=unnamed " yank and paste with the system clipboard
set directory-=. " don't store swapfiles in the current directory
set encoding=utf-8
set expandtab " expand tabs to spaces
set ignorecase " case-insensitive search
set incsearch " search as you type
set laststatus=2 " always show statusline
set list " show trailing whitespace
set number " show line numbers
set scrolloff=3 " show context above/below cursorline
set showcmd
set smartcase " case-sensitive search if any caps
set tabstop=4 " actual tabs occupy 4 characters
set wildmenu " show a navigable menu for tab completion
set wildmode=longest,list,full
set mouse=a " Enable basic mouse behavior such as resizing buffers.
set hidden

""""" folding
set foldenable
set foldlevelstart=10 " open most folds by default
set foldnestmax=10 " at most, 10 nested folds
set foldmethod=indent " could be: marker, manual, expr, syntax, diff

" keyboard shortcuts
" let mapleader = ','
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

map <silent> <leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>
" insert a fat comma w/ ctrl l
imap <c-l> <space>=><space>
imap <c-k> ->
nmap <leader>] :TagbarToggle<CR>
" in macvim, we use D for command, but we can't do that in the terminal
" also note that this ctrl-/
nmap <C-_> :Commentary<CR>
vmap <C-_> :Commentary<CR>
" space in normal mode handles folds
nnoremap <space> za
" md is markdown
autocmd BufRead,BufNewFile *.md set filetype=markdown
" automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =

set listchars=tab:▸\ ,eol:¬,trail:·
set laststatus=2
" in theory this will fix fugitive problems
set shell=/bin/bash

" replicate cmd-[ and cmd-] (eg from bbedit)
" to move visual selection
vmap <D-[> <gv
vmap <D-]> >gv

" keyboard shortcuts
inoremap jj <ESC>

set bg=dark
" gui settings
if (&t_Co == 256 || has('gui_running'))
    set termguicolors " this is a vim 8 thing?
    " colorscheme ir_black
    colorscheme sidonia
    hi SpecialKey guibg=black
    " colorscheme spacegray
else
    colorscheme ir_black
endif
set guifont=Hack:h14
set guioptions-=T
set visualbell " fuck donk noises
set cursorline " highlight the current line

" fix indents etc
autocmd BufNewFile,BufRead *.py setlocal ts=4 sts=4 sw=4
autocmd BufNewFile,BufRead *.js setlocal ts=4 sts=4 sw=4
autocmd BufNewFile,BufRead *.pl,*.pm,*.cgi,*.tt2 setlocal noet ci pi ts=4 sts=0 sw=4
autocmd BufNewFile,BufRead *.html setlocal ts=4 sts=4 sw=4
autocmd BufNewFile,BufRead *.md setlocal ts=4 sts=4 sw=4
au BufNewFile,BufRead *.tt2 setf tt2html " or just setf tt2 if there's no HTML anywhere, or setf tt2js if you need to
au BufNewFile,BufRead *.tt2 setlocal noet ci pi ts=4 sts=0 sw=4
au FileType python setlocal omnifunc=pythoncomplete#Complete
" but this is our dumb-ass method
autocmd BufNewFile,BufRead *.js setlocal ci pi ts=4 sts=0 sw=4
autocmd FileType javascript setlocal ci pi ts=4 sts=0 sw=4
" this is how the rest fo the world does it
" autocmd BufNewFile,BufRead *.js setlocal ts=2 sts=2 sw=2
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
" au FileType make set noexpandtab
autocmd FileType sh setlocal ts=4 sts=4 sw=4
autocmd FileType vim setlocal ts=4 sts=4 sw=4
autocmd FileType zsh setlocal ts=4 sts=4 sw=4
autocmd FileType perl setlocal noet ci pi ts=4 sts=0 sw=4

" when you select a file in the loclist/quickfind, close it
autocmd FileType qf nmap <buffer> <cr> <cr>:lcl<cr>
autocmd FileType gitconfig setlocal noet ci pi ts=4 sts=0 sw=4

set wildignore=log/**,node_modules/**,target/**,tmp/**,*.rbc
set wildignore+=.hg,.git,.svn                    " Version control
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.DS_Store                       " OSX bullshit
set wildignore+=*.pyc                            " Python byte code
set wildignore+=*/bower_components/*               " ugh
set wildignore+=*/.komodotools/*               " double ugh
set wildignore+=*/.idea/*               " this is annoying
set wildignore+=*.komodoproject                 " fuck tha police

" format current buffer
nnoremap <leader>Ft mZggVG=`Zzz

nnoremap H 0
nnoremap L $

set showtabline=2 " always show tabs

set statusline=%t\        "tail of the filename
set statusline+=\ %h      "help file flag
set statusline+=\ %m      "modified flag
set statusline+=\ %r      "read only flag
set statusline+=\ %y      "filetype
set statusline+=%=        "left/right separator
set statusline+=\ %c,     "cursor column
set statusline+=\ %l/%L   "cursor line/total lines
set statusline+=\ %P      "percent through file

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

command! -nargs=* Bounce !ssh gthomason@dev-gthomason "web bounce" <CR>
command! -nargs=* SBounce !ssh gthomason@services-gthomason "~/bin/bounce.sh" <CR>
command! -nargs=1 Jira execute 'silent !open https://jira.thinkgeek.com/browse/SPHORB-<args>'

fun! PerlSyntax()
    :!perl -c %
endfun
nnoremap <leader>PC :execute PerlSyntax()<CR>

fun! FindFixme()
        :lvimgrep /TODO\|FIXME/gj %
        :lopen
endfun
nmap <leader>F :call FindFixme()<CR>

" turn completion on but don't scan included files
set complete=.,w,b,u,t,

" vimwiki
let g:vimwiki_list = [{'path': '~/Documents/wiki/', 'path_html': '~/Public/wiki/'}]

let g:syntastic_python_checkers=['flake8'] " use flake8 instead of pylint, for now

" :w!!
" write the file when you accidentally opened it without the right (root) privileges
" I got this from the CIA
cmap w!! w !sudo tee % > /dev/null

" always open files in new buffers
let g:ctrlp_switch_buffer = 0
" change the working directory during a Vim session and make CtrlP respect that change.
let g:ctrlp_working_path_mode = 0
let g:ctrlp_match_window = 'top,order:btt,min:1,max:10,results:10'


if filereadable('/usr/local/bin/ag')
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
elseif filereadable('/usr/bin/ag')
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
elseif filereadable('~/bin/ack')
    let g:ctrlp_user_command = 'ack %s -f --nocolor'
else
     let g:ctrlp_user_command = ''
endif

let g:airline#extensions#tagbar#enabled = 1
let g:airline_theme='vice'

function! NumberToggle()
  if(&relativenumber == 1)
    let &relativenumber = 0
    set number
  else
    set relativenumber
  endif
endfunc

nnoremap <C-n> :call NumberToggle()<cr>
" haven't decided if i want to use this but, enter number when inserting and
" relative number for leaving insert mode.
" autocmd InsertEnter * :set number
" autocmd InsertLeave * :set relativenumber

" reload all the tabs, eg if we switched branches
command! -nargs=* Reload :tabdo edit
" allows cursor change in tmux mode
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

