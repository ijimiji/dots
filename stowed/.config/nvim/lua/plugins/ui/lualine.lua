return function(icons)
    local currentmode = {
        ["n"]     = red,
        ["v"]     = green,
        ["V"]     = blue,
        ["<C-V>"] = cyan,
        ["i"]     = green,
        ["R"]     = magenta,
        ["Rv"]    = magenta,
        ["c"]     = white
    }
    require('lualine').setup {
        options = {
            icons_enabled = icons,
            theme = 'auto',
            component_separators = { left = '', right = ''},
            section_separators = { left = '', right = ''},
            disabled_filetypes = {},
            always_divide_middle = true,
            globalstatus = true,
        },
        sections = {
            lualine_a = {{'mode', color =  function() return {bg = currentmode[vim.fn.mode()],  fg = black} end }},
            lualine_b = {{'filename', color = {fg = black, bg = yellow}}},
            lualine_c = {{'branch', 'diff', 'diagnostics', color = {fg = black, bg = red}}},
            lualine_y = {
                {
                    "encoding", 
                    padding = 1,
                    color = {bg = blue, fg = black},
                }
            },
            lualine_z = {
                {
                    "filesize", 
                    padding = 1,
                    color = {bg = yellow, fg = black},
                }
            },
            lualine_x = {
                {
                    function()
                        local current_line = vim.fn.line "."
                        local total_lines = vim.fn.line "$"
                        local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
                        local line_ratio = current_line / total_lines
                        local index = math.ceil(line_ratio * #chars)
                        return chars[index]
                    end,
                    padding = { left = 0, right = 0 },
                    color = {fg = red, bg = grey},
                    cond = nil
                }
            },
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = {'filename'},
            lualine_x = {'location'},
            lualine_y = {},
            lualine_z = {}
        },
    }
end

