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

" Cursor
:hi Cursor guifg=Green guibg=Black
:set cursorline
:hi CursorLine guibg=#333333
:set cursorcolumn
:hi CursorColumn guibg=#333333

:set guifont=Consolas:h11:cANSI:qDRAFT
