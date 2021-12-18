" Options
set rulerformat=%25(%=%#Type#%l:%v%#Normal#\ %#Todo#*%t*%)
set laststatus=0
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
" Plugins settings
let g:conjure#highlight#enabled = v:true
let g:sexp_enable_insert_mode_mappings = 0
let g:sexp_filetypes = "fennel"
let g:aniseed#env = v:true

call wilder#setup({
            \ 'modes': [':', '/', '?'],
            \ 'next_key': '<Tab>',
            \ 'previous_key': '<S-Tab>',
            \ 'accept_key': '<Down>',
            \ 'reject_key': '<Up>',
            \ })

call wilder#set_option('renderer', wilder#popupmenu_renderer({
            \ 'highlighter': wilder#basic_highlighter(),
            \ }))
" Maps
nnoremap <silent><C--> :lua decrease_font()<cr>
nnoremap <silent><C-=> :lua increase_font()<cr>
nnoremap n nzzzv
nnoremap N Nzzzv
" Create undopoints on , and . symbols.
inoremap , ,<C-g>u
inoremap . .<C-g>u
" End and beginning of line with home row.
noremap L g$
noremap H ^"
" Copy to the end of a line.
noremap  Y y$
" Better align.
vnoremap > >gv
vnoremap < <gv
" nnoremap > >>
" nnoremap < <<
nnoremap <localleader>G :Git<cr>
" EasyAlign.
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
" Jump forward or backward
imap <expr><Tab>   vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<Tab>'
smap <expr><Tab>   vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<Tab>'
imap <expr><S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'
smap <expr><S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'
" Terminal scratchpad
nnoremap <silent><C-Space> :lua ToggleTerm(12)<cr>
tnoremap <silent><C-Space> <C-\><C-n>:lua ToggleTerm(12)<cr>
" Exit from terminal mode
tnoremap <esc> <C-\><C-n>
" Create new line from insert mode
inoremap <C-CR> <C-o>o
inoremap <C-M-CR> <C-o>O
" Fix for Neovide
inoremap <S-Insert> <C-o>p

lua << EOF
-- Bootstrap Paq
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/paqs/start/paq-nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth=1', 'https://github.com/savq/paq-nvim.git', install_path})
end
-- Install packages
require "paq" {
    "joshdick/onedark.vim";
    "savq/paq-nvim";
    "nvim-lua/plenary.nvim";
    "gelguy/wilder.nvim";

    "lervag/vimtex";

    "MunifTanjim/nui.nvim";

    "bakpakin/fennel.vim";
    "Olical/aniseed";
    "Olical/conjure";
    "PaterJason/cmp-conjure";
    "clojure-vim/vim-jack-in";
    "tpope/vim-sexp-mappings-for-regular-people";
    "tpope/vim-dispatch";
    "ryvnf/readline.vim";
    "guns/vim-sexp";

    "ishan9299/nvim-solarized-lua";

    "tpope/vim-surround";
    "junegunn/vim-easy-align";

    "lewis6991/gitsigns.nvim";
    "tpope/vim-fugitive";

    "kosayoda/nvim-lightbulb";
    "neovim/nvim-lspconfig";
    "williamboman/nvim-lsp-installer";

    "onsails/lspkind-nvim";
    "hrsh7th/cmp-nvim-lsp";
    "hrsh7th/cmp-buffer";
    "hrsh7th/cmp-path";
    "hrsh7th/cmp-cmdline";
    "hrsh7th/nvim-cmp";
    "hrsh7th/cmp-vsnip";
    "hrsh7th/vim-vsnip";
    "rafamadriz/friendly-snippets";
    "terrortylor/nvim-comment";

    "windwp/nvim-autopairs";
    }
EOF
colorscheme onedark
" hi! link DiagnosticError String
" hi! link DiagnosticWarn Include
" hi! link DiagnosticHint Conditional
" hi! link DiagnosticInfo Constant

highlight! default link CmpItemKindMatch          Boolean
highlight! default link CmpItemKindMatchFuzzy     Boolean
highlight! default link CmpItemKindText           Label
highlight! default link CmpItemKindMethod         Function
highlight! default link CmpItemKindFunction       Function
highlight! default link CmpItemKindConstructor    Function
highlight! default link CmpItemKindField          Type
highlight! default link CmpItemKindVariable       Type
highlight! default link CmpItemKindClass          Structure
highlight! default link CmpItemKindInterface      Structure
highlight! default link CmpItemKindModule         Structure
highlight! default link CmpItemKindProperty       Type
highlight! default link CmpItemKindUnit           Boolean
highlight! default link CmpItemKindValue          Character
highlight! default link CmpItemKindEnum           Structure
highlight! default link CmpItemKindKeyword        Operator
highlight! default link CmpItemKindSnippet        Special
highlight! default link CmpItemKindColor          Constant
highlight! default link CmpItemKindFile           String
highlight! default link CmpItemKindReference      Character
highlight! default link CmpItemKindFolder         String
highlight! default link CmpItemKindEnumMember     Type
highlight! default link CmpItemKindConstant       Constant
highlight! default link CmpItemKindStruct         Structure
highlight! default link CmpItemKindEvent          Conditional
highlight! default link CmpItemKindOperator       Operator
highlight! default link CmpItemKindTypeParameter  Special
