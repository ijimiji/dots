local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
end

require('packer').startup(function(use)
    use "wbthomason/packer.nvim"
    use "RRethy/nvim-base16"
    use "nvim-lua/plenary.nvim"
    use "shaunsingh/nord.nvim"
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

    use "neovim/nvim-lspconfig"
    use "kosayoda/nvim-lightbulb"
    use "williamboman/mason.nvim"
    use "williamboman/mason-lspconfig.nvim"
    use "ray-x/go.nvim"
end)

vim.g.maplocalleader = ";"
vim.g.mapleader      = " "
vim.cmd "color base16-nord"
