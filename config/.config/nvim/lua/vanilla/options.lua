vim.cmd [[
"set rulerformat=%25(%=%#Type#%l:%v%#Normal#\ %#Todo#*%t*%)
"set laststatus=0
set autochdir
set signcolumn=number
set background=dark
set termguicolors
set relativenumber 
set number
set mouse=a
set expandtab
set shiftwidth=4
set softtabstop=4
set ignorecase
set smartcase
set inccommand=nosplit
set clipboard=unnamedplus,unnamed
set undofile
set hidden
set splitbelow
set splitright
set colorcolumn=+1
set textwidth=80
set updatetime=300
set wildmode=full
set guifont=FantasqueSansMono\ Nerd\ Font,Apple\ Color\ Emoji:b:h24
let maplocalleader=","
let mapleader=" "

augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank{higroup="Visual", timeout=250}
augroup END
]]
