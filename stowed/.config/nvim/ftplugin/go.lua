require('go').setup()

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.go", 
    group = vim.api.nvim_create_augroup("go", {clear = true}),
    callback = function() 
        require("go.format").goimport()  -- goimport + gofmt
    end
})
