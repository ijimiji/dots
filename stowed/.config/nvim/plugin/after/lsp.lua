local autocmd = vim.api.nvim_create_autocmd
local au      = vim.api.nvim_create_augroup

autocmd("LspAttach", {
    group = au("lspmaps", { clear = true }),
    callback = function(args)

        vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { underline = false, undercurl = true })
        vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { underline = true, undercurl = false })
        vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { underline = true, undercurl = false })
        vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { underline = true, undercurl = false })
        vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = vim.g.terminal_color_3 })
        vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = vim.g.terminal_color_3 })
        vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = vim.g.terminal_color_3 })
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition)
        vim.keymap.set("n", "K", vim.lsp.buf.hover)
        vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename)
        vim.keymap.set("n", "<leader>lr", vim.cmd.LspRestart)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
        vim.b.formatexpr = vim.lsp.formatexpr()
        vim.keymap.set("n", "<C-j>", vim.diagnostic.goto_next)
        vim.keymap.set("n", "<C-k>", vim.diagnostic.goto_prev)
    end,
})
