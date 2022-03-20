return function(icons)
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
            lualine_a = {'mode'},
            lualine_b = {{'branch', 'diff', 'diagnostics', color = {fg = vim.g.terminal_color_0, bg = vim.g.terminal_color_3}}},
            lualine_c = {{'filename', color = {fg = vim.g.terminal_color_0, bg = vim.g.terminal_color_1}}},
            lualine_x = {
                {"location", padding = 0, color = {bg = vim.g.terminal_color_4, fg = vim.g.terminal_color_0}}
            },
            lualine_z = {
                {"filesize", color = {bg = vim.g.terminal_color_3, fg = vim.g.terminal_color_0}}
            },
            lualine_y = {
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
                    color = {fg = vim.g.terminal_color_1, bg = vim.g.terminal_color_8},
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
    fmt = string.format
    vim.cmd("highlight clear lualine_a_normal")
    vim.cmd(fmt("highlight! lualine_a_normal guifg=%s guibg=%s",
    vim.g.terminal_color_0,
    vim.g.terminal_color_4))
end

