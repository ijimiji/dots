---------------------------------------------------------------------------------
require("util")
require("vim")
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
--------------------------------------------------------------------------------- "shaunsingh/nord.nvim",
    "RRethy/nvim-base16",
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
    -- "nvim-lualine/lualine.nvim",
---------------------------------------------------------------------------------
    "hrsh7th/nvim-cmp",
    "ijimiji/cmp-cmdline",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-vsnip",
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
    "nvim-treesitter/nvim-treesitter"
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
require("plugins.ui.reach")()
require("plugins.ui.which-key")()
require("plugins.ui.lualine")(false)
---------------------------------------------------------------------------------
servers    = {"clangd", "texlab", "pyright"}
require("plugins.lsp.signs")(require("misc.icons.unicode"))
require("plugins.lsp.installer")(
    servers, 
    require("plugins.cmp")({
        "nvim_lsp", 
        "vsnip", 
        "buffer"
    }, 
    require("plugins.snippets")()),
    require("plugins.lsp.ui")())
---------------------------------------------------------------------------------
