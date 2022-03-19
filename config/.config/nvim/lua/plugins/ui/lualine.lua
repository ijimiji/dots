return function()
    require('lualine').setup {
        options = {
            icons_enabled = false,
            theme = 'auto',
            component_separators = { left = '', right = ''},
            section_separators = { left = '', right = ''},
            disabled_filetypes = {},
            always_divide_middle = true,
            globalstatus = false,
        },
        sections = {
            lualine_a = {'mode'},
            lualine_b = {{'branch', 'diff', 'diagnostics', color = "Search"}},
            lualine_c = {{'filename', color = "lualine_a_command"}},
            lualine_y = {{'filetype', color = "Search"}},
            lualine_z = {
                {function() return "" end, color = "StatusLine", padding = 0}
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
                color = "ErrorMsg",
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
            tabline = {},
            extensions = {}
        }
    end

