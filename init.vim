" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')

" Color scheme
Plug 'nanotech/jellybeans.vim'

" Git wrapper
Plug 'tpope/vim-fugitive'

" Quoting/parenthesizing made simple
Plug 'tpope/vim-surround'

" Status line
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'
Plug 'edkolev/tmuxline.vim'

" Syntax checking
Plug 'w0rp/ale'

" Completion
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'

Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-jedi'

Plug 'mattn/emmet-vim'

" Formater
Plug 'Chiel92/vim-autoformat'

" Commenting
Plug 'scrooloose/nerdcommenter'

" Code folding
Plug 'tmhedberg/simpylfold'

" Searching
Plug 'kien/ctrlp.vim'

" tmux
Plug 'tmux-plugins/vim-tmux'

" Save sesssions
Plug 'tpope/vim-obsession'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" Ansible Formater
Plug 'pearofducks/ansible-vim', { 'do': 'cd ./UltiSnips; ./generate.py' }

" Initialize plugin system
call plug#end()

filetype plugin indent on

let g:loaded_python_provider = 1

" ----- NERDCOMMENTER -----
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1

" ----- NERDTREE -----
autocmd vimenter * NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

map <C-n> :NERDTreeToggle<CR>

" ----- CODE FOLDING -----
" Enable folding
set foldmethod=indent
set foldlevel=99

" Enable folding with the spacebar
nnoremap <space> za

let g:SimpylFold_docstring_preview=1

" ----- ALE -----
let g:ale_lint_on_enter = 0
let g:ale_lint_on_text_changed = 'never'
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_linters = {'python': ['flake8']}

" Navigate between errors
nmap <silent> <S-h> <Plug>(ale_previous_wrap)
nmap <silent> <C-h> <Plug>(ale_next_wrap)

" Toggle errors visibility
noremap <silent> <C-e> :ALEToggle<CR>

" ----- LIGHTLINE -----
let g:lightline = {
			\ 'colorscheme': 'jellybeans',
			\ 'active': {
			\   'left': [ [ 'mode', 'paste' ],
			\             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
			\   'right': [ [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ],
			\              [ 'lineinfo' ],
			\              [ 'percent' ],
			\              [ 'fileformat', 'fileencoding', 'filetype', 'charvaluehex' ] ]
			\ },
			\ 'component_function': {
			\   'gitbranch': 'fugitive#head',
			\   'linter_checking': 'lightline#ale#checking',
			\   'linter_warnings': 'lightline#ale#warnings',
			\   'linter_errors': 'lightline#ale#errors',
			\   'linter_ok': 'lightline#ale#ok',
			\ },
			\ 'component_type': {
			\   'linter_checking': 'left',
			\   'linter_warnings': 'warning',
			\   'linter_errors': 'error',
			\   'linter_ok': 'left',
			\ }
			\ }

" ----- INDENTATION -----
" Python
au BufNewFile,BufRead *.py
			\ set tabstop=4 |
			\ set softtabstop=4 |
			\ set shiftwidth=4 |
			\ set textwidth=79 |
			\ set expandtab |
			\ set autoindent |
			\ set fileformat=unix

" Web
au BufNewFile,BufRead *.js, *.html, *.css
			\ set tabstop=2 |
			\ set softtabstop=2 |
			\ set shiftwidth=2

" " ----- PYTHON -----
" "python with virtualenv support
" py << EOF
" import os
" import sys
" if 'venv' in os.environ:
" project_base_dir = os.environ['venv']
" activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
" execfile(activate_this, dict(__file__=activate_this))
" EOF

" ----- NCM2 -----
" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

augroup NCM2
	autocmd!
	" enable ncm2 for all buffers
	autocmd BufEnter * call ncm2#enable_for_buffer()
	" :help Ncm2PopupOpen for more information
	set completeopt=noinsert,menuone,noselect
	" When the <Enter> key is pressed while the popup menu is visible, it only
	" hides the menu. Use this mapping to close the menu and also start a new line.
	" inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
	" uncomment this block if you use vimtex for LaTex
	" autocmd Filetype tex call ncm2#register_source({
	"           \ 'name': 'vimtex',
	"           \ 'priority': 8,
	"           \ 'scope': ['tex'],
	"           \ 'mark': 'tex',
	"           \ 'word_pattern': '\w+',
	"           \ 'complete_pattern': g:vimtex#re#ncm2,
	"           \ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
	"           \ })
augroup END

" ----- VIM-AUTOFORMAT -----
noremap <F3> :Autoformat<CR>

" ----- USER SETTINGS -----
" Enable split
set splitbelow
set splitright

" Split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
" nnoremap <C-H> <C-W><C-H>

set pastetoggle=<F2>
set number
set relativenumber

set hidden
set mouse=a
set noshowmode
set nolazyredraw

" Turn off backup
set nobackup
set noswapfile
set nowritebackup

" Search configuration
set ignorecase
set smartcase

" UI configuration
syntax on
syntax enable
set t_Co=256
set laststatus=2

" colorscheme
colorscheme jellybeans

" True Color Support if it's avaiable in terminal
if has("termguicolors")
	set termguicolors
endif
if has("gui_running")
	set guicursor=n-v-c-sm:block,i-ci-ve:block,r-cr-o:blocks
endif

au FocusGained * if &autoread | silent checktime | endif

