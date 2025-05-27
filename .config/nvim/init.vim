" === Plugin Manager ===
call plug#begin('~/.config/nvim/plugged')

" Core Language & IDE
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'glepnir/lspsaga.nvim'

" Git and Versioning
Plug 'lewis6991/gitsigns.nvim'
Plug 'tpope/vim-fugitive'

" File Explorer & UI
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'hoob3rt/lualine.nvim'
Plug 'akinsho/bufferline.nvim'
Plug 'folke/which-key.nvim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Syntax and Comments
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'

call plug#end()

" === General Settings ===
syntax on
filetype plugin indent on
set number
set relativenumber
set clipboard=unnamedplus
set tabstop=4 shiftwidth=4 expandtab
set noswapfile
set termguicolors

" === Go Config ===
let g:go_fmt_command = "goimports"
let g:go_def_mode = 'gopls'
let g:go_info_mode = 'gopls'
let g:go_metalinter_enabled = ['golint']
let g:go_fmt_autosave = 1
let g:go_imports_autosave = 1
let g:go_code_completion_enabled = 1
let g:go_doc_keywordprg_enabled = 1

" === CoC Settings ===
inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <silent><expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" === NerdTree ===
map <C-n> :NERDTreeToggle<CR>
autocmd VimEnter * NERDTree

" === Airline ===
let g:airline_powerline_fonts = 1
let g:airline_theme='gruvbox'

" === Colorscheme ===
colorscheme desert