---------------------------------------------------------------------------------
local fn = vim.fn
local pack_path = fn.stdpath("data") .. "/site/pack"
local fmt = string.format
local execute = vim.api.nvim_command
function ensure (user, repo)
  local install_path = fmt("%s/packer/start/%s", pack_path, repo)
  if fn.empty(fn.glob(install_path)) > 0 then
    execute(fmt("!git clone https://github.com/%s/%s %s", user, repo, install_path))
    execute(fmt("packadd %s", repo))
  end
end
ensure("wbthomason", "packer.nvim")
ensure("lewis6991", "impatient.nvim")
require("impatient")
---------------------------------------------------------------------------------
plugins = {
---------------------------------------------------------------------------------
    "wbthomason/packer.nvim",
    "lewis6991/impatient.nvim",
---------------------------------------------------------------------------------
    "nvim-lua/plenary.nvim",
---------------------------------------------------------------------------------
    "b0o/mapx.nvim",
    "ryvnf/readline.vim",
    "folke/which-key.nvim",
---------------------------------------------------------------------------------
    "RRethy/nvim-base16",
    "ijimiji/shoji",
---------------------------------------------------------------------------------
    "lervag/vimtex",
---------------------------------------------------------------------------------
    "Olical/conjure",
    "PaterJason/cmp-conjure",
---------------------------------------------------------------------------------
    "tpope/vim-fugitive",
---------------------------------------------------------------------------------
    "neovim/nvim-lspconfig",
    "RishabhRD/nvim-lsputils",
    "RishabhRD/popfix",
    "tami5/lspsaga.nvim",
    "williamboman/nvim-lsp-installer",
    "kosayoda/nvim-lightbulb",
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
    "ijimiji/tabout.nvim",
    "junegunn/vim-easy-align",
    "tpope/vim-surround",
    "numToStr/Comment.nvim",
    "windwp/nvim-autopairs",
    "chemzqm/vim-jsx-improve",
    "nvim-treesitter/nvim-treesitter",
} require("plugins.packer")(plugins)
servers = {"clangd", "texlab", "pyright"}
---------------------------------------------------------------------------------
require("util")
colorscheme("base16-nord", "base16")
---------------------------------------------------------------------------------
vim.notify = require("notify")
---------------------------------------------------------------------------------
require("plugins.mapx")()
---------------------------------------------------------------------------------
require("plugins.editor.comment")()
require("plugins.editor.align")()
require("plugins.editor.pairs")()
---------------------------------------------------------------------------------
require("plugins.ui.reach")()
require("plugins.ui.which-key")()
require("plugins.ui.lualine")(false)
---------------------------------------------------------------------------------
local icons = require("misc.icons.ascii")
require("plugins.lsp.signs")(icons)
require("plugins.lsp.installer")(
    servers, 
    require("plugins.cmp")(
	    {
		"nvim_lsp", 
		"vsnip", 
		"buffer",
		"path",
                "conjure"
	    }, 
	    icons,
	    require("plugins.snippets")()
    ),
    require("plugins.lsp.ui")()
)
---------------------------------------------------------------------------------
auto("FileType", {
    pattern = "markdown",
    command =  [[nnoremap <buffer> gf vi[gf]]
})
auto("TextYankPost", {
    pattern = "*", 
    callback = function() 
    require'vim.highlight'.on_yank{higroup="Substitute", timeout=250}
end})
---------------------------------------------------------------------------------
o.autochdir      = t
o.cursorline     = t
o.number         = t
o.relativenumber = t
o.termguicolors  = t
o.expandtab      = t
o.undofile       = t
o.hidden         = t
o.splitbelow     = t
o.splitright     = t
o.ignorecase     = t
o.smartcase      = t
o.shiftwidth     = 4
o.softtabstop    = 4
o.textwidth      = 80
o.updatetime     = 300
o.signcolumn     = "number"
o.background     = "dark"
o.mouse          = "a"
o.inccommand     = "nosplit"
o.clipboard      = "unnamedplus,unnamed"
o.colorcolumn    = "+1"
o.wildmode       = "full"
o.guifont        = "FantasqueSansMono Nerd Font,Apple Color Emoji:b:h24"
---------------------------------------------------------------------------------
g.maplocalleader = ","
g.mapleader      = " "
---------------------------------------------------------------------------------
nnoremap("n",     [[nzzzv]])
nnoremap("N",     [[Nzzzv]])
inoremap(",",     [[,<C-g>u]])
inoremap(".",     [[.<C-g>u]])
noremap("L",      [[g$]])
nnoremap("H",     [[^]])
nnoremap("Y",     [[y$]])
vnoremap(">",     [[>gv]])
vnoremap("<",     [[<gv]])
vnoremap("s",     [[:s/]])
tnoremap("<esc>", [[<C-\><C-n>]])
---------------------------------------------------------------------------------
highlight({name = "NotifyERRORBorder", foreground = red})
highlight({name = "NotifyERRORIcon",   foreground = red})
highlight({name = "NotifyERRORTitle",  foreground = red})
highlight({name = "NotifyWARNBorder",  foreground = yellow})
highlight({name = "NotifyWARNIcon",    foreground = yellow})
highlight({name = "NotifyWARNTitle",   foreground = yellow})
highlight({name = "NotifyINFOBorder",  foreground = blue})
highlight({name = "NotifyINFOTitle",   foreground = blue})
highlight({name = "NotifyINFOIcon",    foreground = blue})
highlight({name = "NotifyTRACEBorder", foreground = yellow})
highlight({name = "NotifyTRACEIcon",   foreground = yellow})
highlight({name = "NotifyTRACETitle",  foreground = yellow})
highlight({name = "NotifyDEBUGIcon",   foreground = yellow})
highlight({name = "NotifyDEBUGBorder", foreground = yellow})
highlight({name = "NotifyDEBUGTitle",  foreground = yellow})
---------------------------------------------------------------------------------
highlight({name = "NormalFloat", background = "#343945"})
---------------------------------------------------------------------------------
highlight({name = "DiagnosticWarn", foreground = yellow})
---------------------------------------------------------------------------------
highlight({name = "CursorLineNR", foreground = yellow})
---------------------------------------------------------------------------------
highlight({name = "CmpItemKindMatch",         foreground = yellow})
highlight({name = "CmpItemKindMatchFuzzy",    foreground = yellow})
highlight({name = "CmpItemKindText",          foreground = yellow})
highlight({name = "CmpItemKindMethod",        foreground = green})
highlight({name = "CmpItemKindFunction",      foreground = green})
highlight({name = "CmpItemKindConstructor",   foreground = green})
highlight({name = "CmpItemKindField",         foreground = blue})
highlight({name = "CmpItemKindVariable",      foreground = blue})
highlight({name = "CmpItemKindClass",         foreground = magenta})
highlight({name = "CmpItemKindInterface",     foreground = magenta})
highlight({name = "CmpItemKindModule",        foreground = grey})
highlight({name = "CmpItemKindProperty",      foreground = blue})
highlight({name = "CmpItemKindUnit",          foreground = blue})
highlight({name = "CmpItemKindValue",         foreground = yellow})
highlight({name = "CmpItemKindEnum",          foreground = yellow})
highlight({name = "CmpItemKindKeyword",       foreground = red})
highlight({name = "CmpItemKindSnippet",       foreground = grey})
highlight({name = "CmpItemKindColor",         foreground = red})
highlight({name = "CmpItemKindFile",          foreground = green})
highlight({name = "CmpItemKindReference",     foreground = grey})
highlight({name = "CmpItemKindFolder",        foreground = blue})
highlight({name = "CmpItemKindEnumMember",    foreground = cyan})
highlight({name = "CmpItemKindConstant",      foreground = yellow})
highlight({name = "CmpItemKindStruct",        foreground = magenta})
highlight({name = "CmpItemKindEvent",         foreground = red})
highlight({name = "CmpItemKindOperator",      foreground = red})
highlight({name = "CmpItemKindTypeParameter", foreground = red})
---------------------------------------------------------------------------------
o.laststatus     = 2
