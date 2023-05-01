local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
	vim.cmd([[packadd packer.nvim]])
end

require("packer").startup(function(use)
	use "wbthomason/packer.nvim"
	use "nvim-lua/plenary.nvim"
	use "ibhagwan/fzf-lua"

	use "tpope/vim-fugitive"
	use "lewis6991/gitsigns.nvim"

	use "farmergreg/vim-lastplace"
	use "lewis6991/impatient.nvim"
	use "tpope/vim-sleuth"
	use "ryvnf/readline.vim"
	use "junegunn/vim-easy-align"
	use "windwp/nvim-autopairs"
	use "terrortylor/nvim-comment"
	use "kylechui/nvim-surround"
	use "ijimiji/tabout.nvim"

	use "nvim-lualine/lualine.nvim"

	use "saadparwaiz1/cmp_luasnip"
	use "L3MON4D3/LuaSnip"
	use "rafamadriz/friendly-snippets"

	use "hrsh7th/nvim-cmp"
	use "hrsh7th/cmp-nvim-lsp"
	use "hrsh7th/cmp-buffer"
	use "hrsh7th/cmp-path"

	use "EdenEast/nightfox.nvim"

	use "neovim/nvim-lspconfig"
	use "kosayoda/nvim-lightbulb"
	use "williamboman/mason.nvim"
	use "williamboman/mason-lspconfig.nvim"
	use "ray-x/go.nvim"
	use "WhoIsSethDaniel/mason-tool-installer.nvim"
	use "jose-elias-alvarez/null-ls.nvim"
	use "mfussenegger/nvim-dap"
	use "leoluz/nvim-dap-go"
	use "rcarriga/nvim-dap-ui"
	use "nvim-treesitter/nvim-treesitter"
	use "nvim-treesitter/nvim-treesitter-textobjects"
end)

local ok = pcall(require, "impatient")
if not ok then
	require('packer').sync()
end

vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.keymap.set("v", ">",          ">gv")
vim.keymap.set("v", "<",          "<gv")
vim.keymap.set("n", "n",          "nzzzv")
vim.keymap.set("n", "N",          "Nzzzv")
vim.keymap.set("i", ",",          ",<C-g>u")
vim.keymap.set("i", ".",          ".<C-g>u")
vim.keymap.set("n", "L",          ";")
vim.keymap.set("n", "H",          ",")
vim.keymap.set("n", "Y",          "y$")
vim.keymap.set("n", "J",          "mzJ`z")
vim.keymap.set("n", "<leader>q",  vim.cmd.copen)
vim.keymap.set("t", "<esc>",      "<C-\\><C-n>")
vim.keymap.set("n", "<esc>",      vim.cmd.noh)
vim.keymap.set("n", "<C-u>",      "<C-u>zz")
vim.keymap.set("n", "<C-d>",      "<C-d>zz")
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("v", "K",          ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J",          ":m '>+1<CR>gv=gv")

vim.o.guifont = "FantasqueSansMono Nerd Font:h20:b"
vim.o.autochdir      = false
vim.o.cmdheight      = 1
vim.o.cursorline     = false
vim.o.number         = true
vim.o.relativenumber = true
vim.o.termguicolors  = true
vim.o.expandtab      = true
vim.o.undofile       = true
vim.o.hidden         = true
vim.o.splitbelow     = true
vim.o.splitright     = true
vim.o.ignorecase     = true
vim.o.smartcase      = true
vim.o.shiftwidth     = 4
vim.o.softtabstop    = 4
vim.o.tabstop        = 4
vim.o.smartindent    = true
vim.o.textwidth      = 80
vim.o.updatetime     = 300
vim.o.signcolumn     = "auto"
vim.o.background     = "dark"
vim.o.mouse          = "a"
vim.o.inccommand     = "nosplit"
vim.o.clipboard      = "unnamedplus,unnamed"
vim.o.colorcolumn    = "80"
vim.o.wildignorecase = true
vim.o.signcolumn     = "yes"

pcall(vim.cmd, "color nordfox")

vim.api.nvim_set_hl(0, "IncSearch", {bg = vim.g.terminal_color_3, fg = vim.g.terminal_color_0, bold = true})
vim.keymap.set("n", "<leader>e", vim.cmd.Explore)
