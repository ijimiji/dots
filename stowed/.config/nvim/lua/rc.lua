---------------------------------------------------------------------------------
require("util")
---------------------------------------------------------------------------------
plugins = {
---------------------------------------------------------------------------------
    "wbthomason/packer.nvim",
    "lewis6991/impatient.nvim",
    "nvim-lua/plenary.nvim",
---------------------------------------------------------------------------------
    "b0o/mapx.nvim",
    "ryvnf/readline.vim",
    "folke/which-key.nvim",
---------------------------------------------------------------------------------
    "RRethy/nvim-base16",
    "ijimiji/shoji",
    "lervag/vimtex",
    "tpope/vim-fugitive",
---------------------------------------------------------------------------------
    "neovim/nvim-lspconfig",
    "RishabhRD/nvim-lsputils",
    "RishabhRD/popfix",
    "tami5/lspsaga.nvim",
    "williamboman/nvim-lsp-installer",
    "kosayoda/nvim-lightbulb",
    "onsails/lspkind-nvim",
---------------------------------------------------------------------------------
    "rcarriga/nvim-notify",
    "toppair/reach.nvim",
    "nvim-lualine/lualine.nvim",
---------------------------------------------------------------------------------
    "hrsh7th/nvim-cmp",
    "ijimiji/cmp-cmdline",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-vsnip",
    "lukas-reineke/cmp-rg",
    "hrsh7th/cmp-path",
---------------------------------------------------------------------------------
    "hrsh7th/vim-vsnip",
    "rafamadriz/friendly-snippets",
---------------------------------------------------------------------------------
    "junegunn/vim-easy-align",
    "tpope/vim-surround",
    "numToStr/Comment.nvim",
    "windwp/nvim-autopairs",
---------------------------------------------------------------------------------
    "chemzqm/vim-jsx-improve",
    "nvim-treesitter/nvim-treesitter",
---------------------------------------------------------------------------------
    "nvim-telescope/telescope.nvim"
---------------------------------------------------------------------------------
} require("plugins.packer")(plugins)
---------------------------------------------------------------------------------
colorscheme("base16-nord", "base16")
---------------------------------------------------------------------------------
vim.notify = require("notify")
---------------------------------------------------------------------------------
require("plugins.editor.comment")()
require("plugins.editor.align")()
require("plugins.editor.pairs")()
---------------------------------------------------------------------------------
require("plugins.mapx")()
---------------------------------------------------------------------------------
require("plugins.ui.kind")()
require("plugins.ui.reach")()
require("plugins.ui.which-key")()
require("plugins.ui.lualine")(false)
---------------------------------------------------------------------------------
servers = {"clangd", "texlab", "pyright"}
require("plugins.lsp.signs")(require("misc.icons.unicode"))
require("plugins.lsp.installer")(
    servers, 
    require("plugins.cmp")({
        "nvim_lsp", 
        "vsnip", 
        "buffer",
        "rg",
        "path"
    }, 
    require("plugins.snippets")()
    ),
    require("plugins.lsp.ui")())
---------------------------------------------------------------------------------
vim.cmd [[
augroup zk
    autocmd!
    autocmd FileType markdown nnoremap <buffer> gf vi[gf
augroup END
]]

auto = vim.api.nvim_create_autocmd 

auto("TextYankPost", {
    pattern = "*", 
    callback = function() 
    require'vim.highlight'.on_yank{higroup="Substitute", timeout=250}
end})

local actions = require "telescope.actions"
require('telescope').setup{}

vim.cmd [[
nnoremap <C-x><C-f> :lua require'telescope.builtin'.find_files(require('telescope.themes').get_ivy())<cr>
nnoremap <M-x> :lua require'telescope.builtin'.commands(require('telescope.themes').get_ivy())<cr>
]]
---------------------------------------------------------------------------------
require("vim")
---------------------------------------------------------------------------------
