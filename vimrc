let g:polyglot_disabled = ['markdown']

call plug#begin('~/.vim/plugged')

Plug 'NLKNguyen/papercolor-theme'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'
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

" ---- Languages ----
Plug 'sheerun/vim-polyglot'
" Python
Plug 'nvie/vim-flake8'
Plug 'Vimjas/vim-python-pep8-indent'
" Typescript
Plug 'leafgarland/typescript-vim'

call plug#end()

" Default vimrc
set ttimeout
set ttimeoutlen=100
set backspace=indent,eol,start
set scrolloff=5
set mouse=a
set incsearch

filetype plugin indent on

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
nnoremap <leader>n :NERDTreeToggle<CR>

nnoremap <silent> <leader>> :vertical resize +20<cr>
nnoremap <silent> <leader>< :vertical resize -20<cr>
" let g:netrw_banner = 0
let g:netrw_altv=1
let g:netrw_liststyle = 3
let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro'

" fzf
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
" Search for files using fzf
nnoremap <leader>ff :Files<cr>
nnoremap <leader>fh :History<cr>
" Search text in files
nnoremap <leader>ft :Ag 
let g:fzf_preview_window = ['up:50%', 'ctrl-/']

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
colorscheme PaperColor
" lightline
set laststatus=2
set noshowmode
let g:lightline = {
	\ 'colorscheme': 'PaperColor',
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
		hi Visual cterm=none ctermbg=grey ctermfg=none
	elseif g:profile == "2"
		set background=dark
		hi Visual cterm=none ctermbg=darkgrey ctermfg=none
	endif
	let tempTimer = timer_start(1000, 'SetColors')
endfunction
let g:profile = 9
call SetColors(1)

nmap <C-p> <Plug>MarkdownPreview

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gs :call CocAction('jumpDefinition', 'split')<cr>
" nmap <silent> gv :call CocAction('jumpDefinition', 'vsplit')<cr>
nmap <silent> gn :call CocAction('jumpDefinition', 'tabe')<cr>
nmap <silent> gr <Plug>(coc-references)
nmap <silent> ga <Plug>(coc-codeaction)
nnoremap <silent> ge :<C-u>CocList diagnostics<cr>
" List of language servers
" https://github.com/neoclide/coc.nvim/wiki/Language-servers

nnoremap <silent> gb :Gblame<cr>

" TODO set to number when nvim version 0.5.0
" set signcolumn=yes
" set signcolumn=number
set signcolumn=no

noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 :tablast<cr>

" visual multi
" let g:VM_maps = {}
" let g:VM_maps['Find Under'] = '<C-m>' " replace C-n

nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :WhichKeyVisual '<Space>'<CR>

set timeoutlen=500

let g:which_key_map =  {}
" copied from https://github.com/ChristianChiarulli/nvim/blob/master/keys/which-key.vim
let g:which_key_map.i = {
      \ 'name' : '+lsp' ,
      \ '.' : [':CocConfig'                          , 'config'],
      \ ';' : ['<Plug>(coc-refactor)'                , 'refactor'],
      \ 'a' : ['<Plug>(coc-codeaction)'              , 'code action'],
      \ 'A' : ['<Plug>(coc-codeaction-selected)'     , 'selected action'],
      \ 'b' : [':CocNext'                            , 'next action'],
      \ 'B' : [':CocPrev'                            , 'prev action'],
      \ 'c' : [':CocList commands'                   , 'commands'],
      \ 'd' : ['<Plug>(coc-definition)'              , 'definition'],
      \ 'D' : ['<Plug>(coc-declaration)'             , 'declaration'],
      \ 'e' : [':CocList extensions'                 , 'extensions'],
      \ 'f' : ['<Plug>(coc-format-selected)'         , 'format selected'],
      \ 'F' : ['<Plug>(coc-format)'                  , 'format'],
      \ 'h' : ['<Plug>(coc-float-hide)'              , 'hide'],
      \ 'i' : ['<Plug>(coc-implementation)'          , 'implementation'],
      \ 'I' : [':CocList diagnostics'                , 'diagnostics'],
      \ 'j' : ['<Plug>(coc-float-jump)'              , 'float jump'],
      \ 'l' : ['<Plug>(coc-codelens-action)'         , 'code lens'],
      \ 'n' : ['<Plug>(coc-diagnostic-next)'         , 'next diagnostic'],
      \ 'N' : ['<Plug>(coc-diagnostic-next-error)'   , 'next error'],
      \ 'o' : [':Vista!!'                            , 'outline'],
      \ 'O' : [':CocList outline'                    , 'search outline'],
      \ 'p' : ['<Plug>(coc-diagnostic-prev)'         , 'prev diagnostic'],
      \ 'P' : ['<Plug>(coc-diagnostic-prev-error)'   , 'prev error'],
      \ 'q' : ['<Plug>(coc-fix-current)'             , 'quickfix'],
      \ 'r' : ['<Plug>(coc-references)'              , 'references'],
      \ 'R' : ['<Plug>(coc-rename)'                  , 'rename'],
      \ 's' : [':CocList -I symbols'                 , 'references'],
      \ 'S' : [':CocList snippets'                   , 'snippets'],
      \ 't' : ['<Plug>(coc-type-definition)'         , 'type definition'],
      \ 'u' : [':CocListResume'                      , 'resume list'],
      \ 'U' : [':CocUpdate'                          , 'update CoC'],
      \ 'z' : [':CocDisable'                         , 'disable CoC'],
      \ 'Z' : [':CocEnable'                          , 'enable CoC'],
      \ }

call which_key#register('<Space>', "g:which_key_map")

" Terminal
tnoremap <C-\><C-\> <C-\><C-n>
if has('nvim')
		noremap <leader>t :split<bar>:terminal<cr>i
else
		noremap <leader>t :terminal<cr>
endif
