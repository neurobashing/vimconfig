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
Plugin 'scrooloose/nerdtree.git'
Plugin 'colepeters/spacemacs-theme.vim' " colorscheme spacemacs-theme, https://github.com/colepeters/spacemacs-theme.vim
Plugin 'vimwiki/vimwiki'
Plugin 'ctrlpvim/ctrlp.vim.git'
Plugin 'SirVer/ultisnips'
Plugin 'neurobashing/snipmate-snippets.git'
Plugin 'tpope/vim-dispatch'
Plugin 'lifepillar/vim-solarized8'
Plugin 'tpope/vim-unimpaired.git'
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
set listchars=tab:▸\ ,eol:¬,trail:·
set nohlsearch

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
" this ^^ used to work but now it doesn't; why?
" also note that this ctrl-/
" ^^^ this also doesn't work, it's a literal _
nmap <C-_> :Commentary<CR>
vmap <C-_> :Commentary<CR>
" space in normal mode handles folds
nnoremap <space> za
" md is markdown
autocmd BufRead,BufNewFile *.md set filetype=markdown
" automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =

nmap <leader>NI :noh<CR>

" replicate cmd-[ and cmd-] (eg from bbedit)
" to move visual selection
vmap <D-[> <gv
vmap <D-]> >gv

" keyboard shortcuts
inoremap jj <ESC>

set bg=dark
" gui settings
set termguicolors " this is a vim 8 thing?
" colorscheme ir_black
" hi SpecialKey guibg=black
" dues is not bad for a dark background
" colorscheme solarized8_dark
colorscheme spacegray
set guifont=Hack:h14 " hack works by default w/ airline. others don't.
set visualbell      " fuck donk noises
set cursorline      " highlight the current line

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
set guioptions-=T   " get rid of toolbar
" set guioptions+=e to always show GUI tabs

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

" these are now asynchronous!
command! -nargs=* Bounce :call job_start(['ssh', 'gthomason@dev-gthomason', 'web', 'bounce'])
command! -nargs=* SBounce :call job_start('ssh', 'gthomason@services-gthomason', '~/bin/bounce.sh')
command! -nargs=1 Jira :call job_start(['open', '-g', 'https://jira.thinkgeek.com/browse/SPHORB-<args>'])

" We use the tpope Dispatch command. on fail, we get a quickfix window.
nnoremap <leader>PC :Dispatch perl -c % <CR>

fun! FindFixme()
        :lvimgrep /TODO\|FIXME/gj %
        :lopen
endfun
nmap <leader>FM :call FindFixme()<CR>

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
nmap <C-s> :CtrlPBuffer<CR>

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
let g:airline#extensions#tabline#enabled = 1
if has("gui_macvim")
    let g:airline_powerline_fonts = 1
endif
let g:airline_section_z = ''
let g:airline_section_b = ''
let g:airline_theme='jellybeans'

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

" NERDTree
" why can't I fucking toggle with , dammit
" map <C-i> :NERDTreeToggle<CR>


" sync sphorb like
" rsync -avz --exclude=data --exclude=images --exclude=blog --exclude=.git --exclude=.githooks --exclude=node_modules ~/proj/localsphorb/ thinkgeek@dev:/home/thinkgeek/proj/Sphorb/
" TODO: this needs to be such that it bases the soure dir off what dir I'm in
" since tgservices etc.
" it should really look @ the path of the current file or something.
command -nargs=0 SyncSphorb :! ~/.config/bin/perlmake sphorb<CR>

" since netrw is broken,
" you can set autocmd BufRead scp://* :set bt=acwrite
" to not have to Nwrite all the time

" " this is a remidner about unimpaired
" The following maps all correspond to normal mode commands.  If a count is
" given, it becomes an argument to the command.  A mnemonic for the "a" commands
" is "args" and for the "q" commands is "quickfix".

" *[a*     |:previous|
" *]a*     |:next|
" *[A*     |:first|
" *]A*     |:last|
" *[b*     |:bprevious|
" *]b*     |:bnext|
" *[B*     |:bfirst|
" *]B*     |:blast|
" *[l*     |:lprevious|
" *]l*     |:lnext|
" *[L*     |:lfirst|
" *]L*     |:llast|
" *[<C-L>* |:lpfile|
" *]<C-L>* |:lnfile|
" *[q*     |:cprevious|
" *]q*     |:cnext|
" *[Q*     |:cfirst|
" *]Q*     |:clast|
" *[<C-Q>* |:cpfile| (Note that <C-Q> only works in a terminal if you disable
" *]<C-Q>* |:cnfile| flow control: stty -ixon)
" *[t*     |:tprevious|
" *]t*     |:tnext|
" *[T*     |:tfirst|
" *]T* |:tlast|

