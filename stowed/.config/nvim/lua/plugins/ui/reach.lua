return function(mapper)
    require('reach').setup({
        notifications = true
    })
    nnoremap("<leader>b", "<cmd>ReachOpen buffers<cr>")
end
