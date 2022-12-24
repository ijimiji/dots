local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local map     = vim.keymap.set

local mason_servers = { 
    "clangd", 
    "rust_analyzer", 
    "pyright",
    "texlab",
    "gopls",
}

require("mason").setup{}

require("mason-lspconfig").setup{
    ensure_installed = mason_servers,
    automatic_installation = true,
}

require("mason-lspconfig").setup_handlers{
    function(server)
        require("lspconfig")[server].setup({})
    end
}

require('nvim-lightbulb').setup({autocmd = {enabled = true}})

function goto_next_error() 
    if #vim.fn.getqflist() == 0 then
        vim.diagnostic.goto_next({ float = { border = 'single' }})
    else 
        vim.cmd "try | cnext | catch | cfirst | catch | endtry"
    end
end

function goto_prev_error() 
    if #vim.fn.getqflist() == 0 then
        vim.diagnostic.goto_prev({ float = { border = 'single' }})
    else 
        vim.cmd "try | cprev | catch | clast | catch | endtry"
    end
end

map("n", "<C-j>", goto_next_error)
map("n", "<C-k>", goto_prev_error)

autocmd("LspAttach", {
    group = augroup("lspmaps", {clear = true}),
    callback = function(args)
        map("n", "gD",        vim.lsp.buf.declaration)
        map("n", "gd",        vim.lsp.buf.definition)
        map("n", "K",         vim.lsp.buf.hover)
        map("n", "gi",        vim.lsp.buf.implementation)
        map("n", "<space>r",  vim.lsp.buf.rename)
        map("n", "<space>ca", vim.lsp.buf.code_action)
        map("n", "gr",        require('fzf-lua').lsp_references)
    end,
})

vim.fn.sign_define("LightBulbSign", {text = "⊚", texthl = "Todo", linehl = "", numhl = ""})
