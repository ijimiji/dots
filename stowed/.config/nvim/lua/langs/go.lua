require('go').setup()

autocmd("BufWritePre", {
    pattern = "*.go", 
    group = augroup("FormatOnSaveGo", {clear = true}),
    callback = function() 
        require("go.format").goimport()
        require('go.format').gofmt()
    end
})
