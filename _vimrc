"reload this file on write
augroup reload_vimrc " {
   autocmd!
   autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }

au BufRead SCons* set filetype=python
au BufNewFile SCons* set filetype=python

:autocmd BufNew,BufRead SConstruct setf python
:autocmd BufNew,BufRead SConscript setf python

"augroup autoindent
"   au!
"   autocmd BufWritePre * :normal migg=G`i
"augroup End

" Set Retarded things that should be standard
:colorscheme corporation
":colorscheme solarized:set background=dark
:set number
:syntax on 
:set ruler
:set backspace=indent,eol,start
noremap P "*p
:set wildmenu
:set showmatch
:filetype indent on
:set showcmd
:syntax enable

" split things 
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
set splitbelow
set splitright

" Moveing line remaping
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" Save aliases because i'm shit 
:command WQ wq
:command Wq wq
:command W w
:command Q q

" Whitespace show
:set list
:set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<,space:·
:hi NonText guifg=#3333AA
:hi SpecialKey guifg=#3333AA


" Tab stuff
:set expandtab
:set shiftwidth=3
:set softtabstop=3
:set textwidth=80
:set autoindent

" Cursor
:hi Cursor guifg=Green guibg=Black
:set cursorline
:hi CursorLine guibg=#333333
:set cursorcolumn
:hi CursorColumn guibg=#333333

" Folding
:set foldenable
noremap <space> za
set incsearch           " search as characters are entered
set hlsearch            " highlight matches
nnoremap <CR> :noh<CR><CR>
set foldlevelstart=10   " open most folds by default
set foldnestmax=10      " 10 nested fold max
set foldmethod=indent   " fold based on indent level

" Movement
nnoremap j gj
" move vertically by visual line
nnoremap k gk

" Font
:set guifont=Consolas:h11:cANSI:qDRAFT

" Open .cpp from .h and .h from .cpp
map <F4> :vsp %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>
" Open Maximized
au GUIEnter * simalt ~x
