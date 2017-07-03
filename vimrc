"reload this file on write
augroup reload_vimrc " {
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }

" Set Retarded things that should be standard
:colorscheme corporation

:set number
:syntax on 
:set ruler
:set backspace=2

" split things 
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
set splitbelow
set splitright

" Save aliases because i'm shit 
:command WQ wq
:command Wq wq
:command W w
:command Q q

" Whitespace show
:set list
:set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<,space:·

" Tab stuff
:set expandtab
:set tabstop=3
:set softtabstop=3

" Folding
:set foldmethod=indent
:set foldlevel=99
:set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab
nnoremap <space> za

" Cursor
:hi Cursor guifg=Green guibg=Black
:set cursorline
:hi CursorLine guibg=#333333
:set cursorcolumn
:hi CursorColumn guibg=#333333

:set guifont=Consolas:h11:cANSI:qDRAFT

"Use System Clipboard
set clipboard=unnamed

let topvar = "/************************************************************************\n	Program:\n	Author:\n	Class:\n	Instructor:\n	Date:\n 	Description:\n	Input:\n	Output:\n	Compilation instructions:\n	Usage:\n	Known bugs/missing features:\n	Modifications:\n   Date                Comment            \n    ----    ------------------------------------------------\n************************************************************************/"

let headvar  = "/************************************************************************\nFunction:\nAuthor: Zacharious Owen\nDescription:\nParameters:\n************************************************************************/"

let iferrvar = "if(    )\n{\nprintf(\"ErrorCodeName: \\nExiting\");\nreturn -1;\n}\n"


command IFERR call append ( line('.'), split ( iferrvar , "\n") ) | :execute 'normal =5j'

command HEAD call append ( line('.'), split ( headvar , "\n") )

command TOP call append ( line('.'), split ( topvar , "\n") )
