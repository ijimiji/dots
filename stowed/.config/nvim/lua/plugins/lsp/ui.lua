return function()
    fmt = string.format

    vim.lsp.handlers['textDocument/codeAction'] = require'lsputil.codeAction'.code_action_handler
    vim.lsp.handlers['textDocument/references'] = require'lsputil.locations'.references_handler
    vim.lsp.handlers['textDocument/definition'] = require'lsputil.locations'.definition_handler
    vim.lsp.handlers['textDocument/declaration'] = require'lsputil.locations'.declaration_handler
    vim.lsp.handlers['textDocument/typeDefinition'] = require'lsputil.locations'.typeDefinition_handler
    vim.lsp.handlers['textDocument/implementation'] = require'lsputil.locations'.implementation_handler
    vim.lsp.handlers['textDocument/documentSymbol'] = require'lsputil.symbols'.document_handler
    vim.lsp.handlers['workspace/symbol'] = require'lsputil.symbols'.workspace_handler
    -- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })
    -- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "single" })

    return function()
        nnoremap("gD",        [[<cmd>lua vim.lsp.buf.declaration()<CR>]])
        nnoremap("gd",        [[<cmd>lua vim.lsp.buf.definition()<CR>]])
        nnoremap("K",         [[<cmd>lua vim.lsp.buf.hover()<CR>]])
        nnoremap("gi",        [[<cmd>lua vim.lsp.buf.implementation()<CR>]])
        nnoremap("<space>wa", [[<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>]])
        nnoremap("<space>wr", [[<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>]])
        nnoremap("<space>wl", [[<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>]])
        nnoremap("<space>D",  [[<cmd>lua vim.lsp.buf.type_definition()<CR>]])
        nnoremap("<space>r",  [[<cmd>lua vim.lsp.buf.rename()<CR>]])
        nnoremap("<space>ca", [[<cmd>lua vim.lsp.buf.code_action()<CR>]])
        nnoremap("gr",        [[<cmd>lua vim.lsp.buf.references()<CR>]])
        nnoremap("<space>f",  [[<cmd>lua vim.lsp.buf.formatting()<CR>]])
        -- nnoremap("gj",        [[<cmd>lua vim.diagnostic.goto_next({ float = { border = "single" }})<CR>]])
        -- nnoremap("gk",        [[<cmd>lua vim.diagnostic.goto_prev({ float = { border = "single" }})<CR>]])
        nnoremap("gj",        [[<cmd>lua vim.diagnostic.goto_next()<CR>]])
        nnoremap("gk",        [[<cmd>lua vim.diagnostic.goto_prev()<CR>]])
    end
end
