vim.api.nvim_create_autocmd("TextYankPost", {
    pattern = "*", 
    group = vim.api.nvim_create_augroup("highlight-on-yank", {clear = true}),
    callback = function() 
        require'vim.highlight'.on_yank{higroup="IncSearch", timeout=250}
    end
})
