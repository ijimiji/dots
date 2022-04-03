return function(icons)
    local currentmode = {
        ["n"]     = vim.g.terminal_color_1,
        ["v"]     = vim.g.terminal_color_2,
        ["V"]     = vim.g.terminal_color_4,
        ["<C-V>"] = vim.g.terminal_color_6,
        ["i"]     = vim.g.terminal_color_2,
        ["R"]     = vim.g.terminal_color_16,
        ["Rv"]    = vim.g.terminal_color_5,
        ["c"]     = vim.g.terminal_color_7
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
            lualine_a = {{'mode', color =  function() return {bg = currentmode[vim.fn.mode()],  fg = vim.g.terminal_color_0} end }},
            lualine_b = {{'filename', color = {fg = vim.g.terminal_color_0, bg = vim.g.terminal_color_3}}},
            lualine_c = {{'branch', 'diff', 'diagnostics', color = {fg = vim.g.terminal_color_0, bg = vim.g.terminal_color_1}}},
            lualine_y = {
                {
                    "encoding", 
                    padding = 1,
                    color = {bg = vim.g.terminal_color_4, fg = vim.g.terminal_color_0},
                    -- fmt = function (str)
                    --     return "[" .. str .. " "
                    -- end

                }
            },
            lualine_z = {
                {
                    "filesize", 
                    padding = 1,
                    color = {bg = vim.g.terminal_color_3, fg = vim.g.terminal_color_0},
                    -- fmt = function (str)
                    --     return " " .. str .. " "
                    -- end
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

