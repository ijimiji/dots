return function(backends, snippet)
    sources = {}
    for _, source in ipairs(backends) do
        table.insert(sources, { name = source })
    end

    local cmp = require("cmp")

    cmp.setup {
        snippet = { expand = snippet },
        sources = cmp.config.sources(sources), 
        mapping = { 
            ['<CR>'] = cmp.mapping.confirm({ select = false }) 
        } 
}

    cmp.setup.cmdline('/', {
        sources = {
            { name = 'buffer' }
        }
    })

    cmp.setup.cmdline(':', {
        sources = cmp.config.sources({
            { name = 'path' },
            { name = 'cmdline' }
        })
    })

    local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
    return capabilities
end

