vim.g.mapleader      = " "
vim.g.maplocalleader = ","

local ok, _ = pcall(require, "impatient")

vim.o.guifont        = "FantasqueSansM Nerd Font:h20:b"
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
vim.o.foldmethod     = "expr"
vim.o.foldexpr       = "nvim_treesitter#foldexpr()"
vim.o.foldnestmax    = 10
vim.o.foldlevel      = 10000
vim.o.list           = true
vim.opt.listchars    = {
  space = "·",
  trail = "·",
  tab   = "  ",
}

vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  group = vim.api.nvim_create_augroup("highlight-on-yank", {clear = true}),
  callback = function()
    require'vim.highlight'.on_yank{higroup="Search", timeout=250}
  end
})

vim.keymap.set("n", "<leader>e",  vim.cmd.Explore)
vim.keymap.set("v", "<M-e>",  ":w !/bin/sh<CR>", {noremap = true})
vim.keymap.set("v", "<M-E>",  "ygv:!/bin/sh<CR>P", {noremap = true})
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

vim.cmd [[color base16-nord]]
vim.cmd [[highlight @comment guibg=#323844 guifg=#535d72 gui=bold,italic]]
