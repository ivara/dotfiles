set nocompatible
set hidden 					"do not prompt to save when switching buffers
set relativenumber number
set hlsearch
set incsearch
syntax enable
set autoindent
set showmatch
set laststatus=2
set encoding=utf-8
set visualbell
set mouse=a

"set foldmethod=syntax
filetype plugin indent on
colorscheme slate

" Provide correct syntax highlighting for my .gitconfig.local file
au BufRead,BufNewFile .gitconfig.* set filetype=dosini


" :grep should use ripgrep instead
set grepprg=rg\ --vimgrep\ --smart-case\ --follow

" jamessan's
set statusline=" clear the statusline for when vimrc is reloaded
set statusline+=%-3.3n\                      " buffer number
set statusline+=%f\                          " file name
set statusline+=%h%m%r%w                     " flags
set statusline+=[%{strlen(&ft)?&ft:'none'},  " filetype
set statusline+=%{strlen(&fenc)?&fenc:&enc}, " encoding
set statusline+=%{&fileformat}]              " file format
set statusline+=%=                           " right align
set statusline+=%{synIDattr(synID(line('.'),col('.'),1),'name')}\  " highlight
set statusline+=%b,0x%-8B\                   " current char

nnoremap <silent> <C-f> :GFiles<CR>
nnoremap <silent> <Leader>f :Rg<CR>

call plug#begin()
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
call plug#end()

"set ts=4 sw=4
"set ruler
"set showmatch
"set cursorline
"set cursorcolumn
"packadd! dracula
"colorscheme dracula

