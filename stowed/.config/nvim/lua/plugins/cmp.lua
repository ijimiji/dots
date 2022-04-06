return function(backends, icons, snippet)
    sources = {}

    for _, source in ipairs(backends) do
        table.insert(sources, { name = source })
    end

    local cmp = require("cmp")
    local kind_icons = icons 

    cmp.setup {
        snippet = { expand = snippet },
        sources = cmp.config.sources(sources), 
        mapping = { 
            ['<CR>'] = cmp.mapping.confirm({ select = false }) 
        }, 
        formatting = {
            format = function(entry, vim_item)
                vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)
                -- vim_item.menu = ({
                --     buffer = "[Buffer]",
                --     nvim_lsp = "[LSP]",
                --     luasnip = "[LuaSnip]",
                --     nvim_lua = "[Lua]",
                --     latex_symbols = "[LaTeX]",
                -- })[entry.source.name]
                return vim_item
            end
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

