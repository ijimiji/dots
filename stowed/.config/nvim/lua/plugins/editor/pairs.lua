return function(excludedFiletypes)
    require('nvim-autopairs').setup({
        disable_filetype = (excludedFiletypes and excludedFiletypes or {})
    })
end
