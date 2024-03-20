require('mini.completion').setup()
require('mini.align').setup({mappings = { start_with_preview = "ga" }})
require('mini.comment').setup()
require("mini.surround").setup({mappings = { replace = "cs" }})
require("nvim-autopairs").setup()
require("fidget").setup({
    progress = { 
        display = { 
            done_icon = "!",
            done_style = "@attribute",
            icon_style = "@attribute",
            group_style = "@attribute",
            progress_style = "@attribute",
        },
},
})
require('tabout').setup({})


