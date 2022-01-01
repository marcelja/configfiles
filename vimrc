let g:polyglot_disabled = ['markdown']

call plug#begin('~/.vim/plugged')

Plug 'pappasam/papercolor-theme-slim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'itchyny/lightline.vim'
" Plug 'mg979/vim-visual-multi'
Plug 'djoshea/vim-autoread'
Plug 'psliwka/vim-smoothie'

Plug 'liuchengxu/vim-which-key'
Plug 'editorconfig/editorconfig-vim'
" Git
Plug 'tpope/vim-fugitive'
" Markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

Plug 'neovim/nvim-lspconfig'

Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
" For vsnip users.
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

Plug 'wellle/targets.vim'

" ---- Languages ----
Plug 'sheerun/vim-polyglot'
" Python
Plug 'nvie/vim-flake8'
Plug 'Vimjas/vim-python-pep8-indent'
" Typescript
Plug 'leafgarland/typescript-vim'
" Kotlin
Plug 'vim-test/vim-test'
" Rust
Plug 'rust-lang/rust.vim'

call plug#end()

" Default vimrc
set ttimeout
set ttimeoutlen=100
set backspace=indent,eol,start
set scrolloff=5
set mouse=a
set incsearch

filetype plugin indent on

" https://github.com/vim/vim/blob/master/runtime/defaults.vim
augroup vimStartup
    au!
    autocmd BufReadPost *
                \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
                \ |   exe "normal! g`\""
                \ | endif
augroup END

" General settings
set noerrorbells
set clipboard^=unnamed,unnamedplus
set cursorline
set hlsearch

set list
set listchars=tab:▏\ ,trail:·

" Vertical split character
set fillchars+=vert:\▏

set undofile
set undodir=~/.vimundo/

set number
set relativenumber
set noswapfile
set ignorecase
set smartcase

set wildmenu

" Display number of matches
set shortmess-=S
" load buffer into window with unsaved modifications
set hidden

" Cursor shape https://vim.fandom.com/wiki/Change_cursor_shape_in_different_modes
" Not needed for nvim
let &t_SI.="\e[5 q" "SI = INSERT mode
let &t_SR.="\e[4 q" "SR = REPLACE mode
let &t_EI.="\e[1 q" "EI = NORMAL mode (ELSE)

" Mappings
let mapleader = " "

" alt backspace delete word
inoremap <a-bs> <c-w>

nnoremap <leader>w :w<cr>
nnoremap <leader>x :x<cr>

nnoremap <leader>a ggVG
vnoremap <leader>s :sort<cr>

nnoremap <leader>j <C-W><C-J>
nnoremap <leader>k <C-W><C-K>
nnoremap <leader>l <C-W><C-L>
nnoremap <leader>h <C-W><C-H>

nnoremap <silent><leader>g :Goyo<cr>
nnoremap <leader>s :set spell!<cr>

" Clear search highlight
nnoremap <leader>r :noh<cr>

" Directory Tree
nnoremap <silent><leader>n :NvimTreeToggle<CR>
nnoremap <silent><leader>fn :NvimTreeFindFile<CR>

nnoremap <silent> <leader>. :vertical resize +20<cr>
nnoremap <silent> <leader>, :vertical resize -20<cr>
nnoremap <silent> <leader>= <C-W>=

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fgf <cmd>Telescope git_files<cr>
nnoremap <leader>fgc <cmd>Telescope git_commits<cr>
nnoremap <leader>fgb <cmd>Telescope git_branches<cr>
nnoremap <leader>fgs <cmd>Telescope git_status<cr>
nnoremap <leader>ft <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" json folding - 'za' to toggle fold
nnoremap <leader>jf ::set filetype=json<cr>:syntax on<cr>:set foldmethod=syntax<cr>

" Commenting
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'
" https://vim.fandom.com/wiki/Disable_automatic_comment_insertion
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Indenting
set softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
" set autoindent
autocmd FileType cpp setlocal expandtab shiftwidth=4 softtabstop=4
autocmd BufRead,BufNewFile *.java,*.kt,*.kts,*.gradle,pom.xml setlocal expandtab shiftwidth=4 softtabstop=4
autocmd BufRead,BufNewFile *.md setlocal expandtab shiftwidth=4 softtabstop=4
autocmd BufRead,BufNewFile *.json,*.xml,*.sh setlocal expandtab shiftwidth=2 softtabstop=2
autocmd BufRead,BufNewFile *.go setlocal shiftwidth=2 softtabstop=2

" Theme
colorscheme PaperColorSlim
" lightline
set laststatus=2
set noshowmode
let g:lightline = {
    \ 'colorscheme': 'PaperColor',
    \ 'active': {
        \   'left': [ [ 'mode', 'paste' ],
        \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
    \ },
    \ 'component_function': {
        \   'gitbranch': 'FugitiveHead'
    \ },
\ }
" https://github.com/itchyny/lightline.vim/issues/104#issuecomment-104883181
autocmd OptionSet background
            \ execute 'source ~/.vim/plugged/lightline.vim/autoload/lightline/colorscheme/PaperColor.vim'
            \ | call lightline#init() | call lightline#colorscheme() | call lightline#update()

function! SetColors(neededarg)
    let old_profile = g:profile
    source ~/.config/configfiles/profiles/profile.vim
    if l:old_profile == g:profile
    elseif g:profile == "1"
        set background=light
        hi Visual guifg=none guibg=LightBlue
    elseif g:profile == "2"
        set background=dark
        hi Visual guifg=none guibg=#404040
    endif
    let tempTimer = timer_start(100, 'SetColors')
endfunction
let g:profile = 9
call SetColors(1)

nmap <C-p> <Plug>MarkdownPreview

nnoremap <silent> gb :Git blame<cr>

set signcolumn=number

noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 :tablast<cr>

set timeoutlen=500

" Terminal
tnoremap <C-\><C-\> <C-\><C-n>
if has('nvim')
    noremap <leader>tt :split<bar>:terminal<cr>i
else
    noremap <leader>tt :terminal<cr>
endif

set completeopt=menu,menuone,noselect

lua require('lsp')
set switchbuf+=usetab,newtab
set termguicolors

map Q <Nop>

let test#strategy = "neovim"
noremap <leader>tn :TestNearest<cr>
noremap <leader>tf :TestFile<cr>
noremap <leader>ts :TestSuite<cr>
noremap <leader>tl :TestLast<cr>
if has('nvim')
    tmap <C-o> <C-\><C-n>
endif
