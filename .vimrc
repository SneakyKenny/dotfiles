"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Description:
"   This is my vimrc file
"
" Maintainer:
"   Kenny "Purple" Lorin
"   <kenny.lorin@epita.fr>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" General options {{{

" Display {{{
" set lcs+=space:·
set listchars=eol:$,tab:>-,trail:·,extends:>,precedes:<,space:·
set list

" File list preview
set wildmenu

" Use tags
set tags=tags;

" Use relative line numbering but still show the current lineno
set number
set relativenumber

" Use mouse
set mouse=a

" Wrap columns at 80 columns (only display)
set wrap

" Show current command line on bottom of screen
set showcmd

" Disable bip
set visualbell
set t_vb=

" Don’t update screen during macro and script execution.
" set lazyredraw

" Enable syntax highlighting
" syntax on

" Enable spelling check
" set spell

" Use an encoding that supports unicode.
set encoding=utf-8

" Avoid wrapping a line in the middle of a word.
set linebreak

" The number of screen lines to keep above and below the cursor.
set scrolloff=10

" Make vertical split panes open on right side instead of left
set splitright

" Make horizontal split open below instead of on top
set splitbelow

" 80 cols column display
set colorcolumn=80

" Set colorcolumn color to very light grey
highlight ColorColumn ctermbg=7

" Netrw setup
let g:netrw_banner = 0
let g:netrw_liststyle = 0
" let g:netrw_browse_split = 4
let g:netrw_winsize = 25
let g:netrw_dirhistmax = 0

" TODO: if we want to open the explorer, go to the already open one if any
" TODO: when closing a buffer, if it's the last one, also close the explorer

" }}} !Display

" Indentation {{{

" Enable filetype indentation
filetype plugin indent on

" New lines inherit the indentation of previous lines
set autoindent

" Write spaces instead of tabs
set expandtab

" When shifting lines, round the indentation to the nearest multiple
" of “shiftwidth.”
set shiftround

" When shifting, indent using 4 spaces
set shiftwidth=4

" Insert “tabstop” number of spaces when the “tab” key is pressed.
set smarttab

" Indent using four spaces.
set tabstop=4

" }}} !Indentation

" Search {{{

" Enable search highlighting.
set hlsearch

" Ignore case when searching.
set ignorecase

" Incremental search that shows partial matches.
set incsearch

" Automatically switch search to case-sensitive when search query contains an
" uppercase letter.
set smartcase

" }}} !Search

" Mappings {{{

" Set leader
let mapleader = "\<Space>"

" Faster movements
inoremap <C-h> <C-\><C-O>b
inoremap <C-l> <C-\><C-O>w

inoremap <C-Left> <C-\><C-O>b
inoremap <C-Right> <C-\><C-O>w

" Tab creating
nmap <silent> <leader>t :tabnew<CR>

" Tab switching
nmap <silent> <leader>n :tabnext<CR>
nmap <silent> <leader><Tab> :tabnext<CR>

nmap <silent> <leader>p :tabprev<CR>
nmap <silent> <leader><s-Tab> :tabprev<CR>

" Quit & Save shortcuts
nmap <silent> <leader>q :q<CR>
nmap <silent> <leader>a :qa<CR>
nmap <c-q> :wqa<CR>
nmap <silent> <leader>w :w<CR>
nmap <silent> <leader>s :wa<CR>
nmap <c-s> :wa<CR>

" Split making
nmap <silent> <leader><Return> :vsp<CR>
nmap <silent> <leader><Tab> :sp<CR>

" Split switching
nmap <silent> <leader>h :wincmd h<CR>
nmap <silent> <leader>j :wincmd j<CR>
nmap <silent> <leader>k :wincmd k<CR>
nmap <silent> <leader>l :wincmd l<CR>

nmap <silent> <leader><Left>  :wincmd h<CR>
nmap <silent> <leader><Down>  :wincmd j<CR>
nmap <silent> <leader><Up>    :wincmd k<CR>
nmap <silent> <leader><Right> :wincmd l<CR>

" Explorer
nmap <silent> <leader>e :E<CR>
" nmap <silent> <leader>E :Sex<CR>
" nmap <silent> <leader>e :Vex<CR>

" Helpers for character pair
" inoremap " ""<left>
" inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

inoremap <expr> )  strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"
inoremap <expr> ]  strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>" : "]"
inoremap <expr> }  strpart(getline('.'), col('.')-1, 1) == "}" ? "\<Right>" : "}"

" }}} !Mappings

" }}} !General options

" Functions {{{

au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown

" Auto-formatting

function FormatBuffer()
  if &modified && !empty(findfile('.clang-format', expand('%:p:h') . ';'))
    let cursor_pos = getpos('.')
    :%!clang-format
    call setpos('.', cursor_pos)
  endif
endfunction

autocmd BufWritePre *.h,*.c, :call FormatBuffer()

" Remove trailing whitespace in file
function s:RemoveTrailingSpace()
    if !&binary && &filetype != 'diff'
        let save_cursor = getpos(".")
        %s/\s\+$//e
        call setpos('.', save_cursor)
    endif
endfunction

" Remove empty lines at the end of file
function! s:RemoveLinesEnd()
    if !&binary && &filetype != 'diff'
        let save_cursor = getpos(".")
        :silent! %s#\($\n\s*\)\+\%$##
        call setpos('.', save_cursor)
    endif
endfunction

" Clean function for trailing whitespace and empty lines
function! CleanFile()
    if !&binary && &filetype != 'diff'
        :call s:RemoveLinesEnd()
        :call s:RemoveTrailingSpace()
    endif
endfunction

" }}} !Functions

" FileType-specific settings {{{

" Remove trailing whitespace and blank lines at end of source code
augroup filetype_misc
    autocmd!
    autocmd BufWritePre *.py,*.c,*.cc,*.h*,*.*sh :silent! call CleanFile()<cr>
augroup END

" }}} !FileType-specfic settings

" Plugins and Themes {{{

" Init
call plug#begin()

" Theme {{{

Plug 'sainnhe/gruvbox-material'

" colorscheme gruvbox-material " moved to ~/.nvimrc
" set termguicolors
set background=dark

" Avoid whitelines being rendered differently
set t_ut=""

" }}} !Theme

" Languages {{{

" set nocompatible
Plug 'sheerun/vim-polyglot'

" }}} !Languages

" Language Servers {{{

Plug 'neoclide/coc.nvim', {'branch': 'release'}

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Rust {{{

" Plug 'rust-lang/rust.vim'

" }}}

" Extras {{{

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

nmap <silent> <C-f> :Files<CR>
nmap <silent> <leader>f :Rg<CR>

" command! -nargs=0 Prettier :CocCommand prettier.forceFormatDocument

" }}}

" }}}

" Tags {{{

" Plug 'ludovicchabant/vim-gutentags'
" Plug 'skywind3000/gutentags_plus'

" enable tag plugins
" let g:gutentags_modules = ['ctags', 'gtags_cscope']
" 
" config project root markers
" let g:gutentags_project_root = ['.root']
" 
" generate tags in cache
" let g:gutentags_cache_dir = expand('~/.cache/tags')
" 
" change focus to quickfix window after search 
" let g:gutentags_plus_switch = 1

" }}} !Tags

" End
call plug#end()

" }}} !Plugins And Themes
