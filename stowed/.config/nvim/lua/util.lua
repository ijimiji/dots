fmt = string.format
auto = vim.api.nvim_create_autocmd 
o = vim.o
g = vim.g
t = true

function _G.highlight(face)
    cmd = fmt("highlight! %s", face.name)

    if face.foreground then
        cmd = fmt("%s guifg=%s", cmd, face.foreground)
    end
    if face.background then
        cmd = fmt("%s guibg=%s", cmd, face.background)
    end
    if face.style then
        cmd = fmt("%s gui=%s", cmd, face.style)
    end

    vim.cmd(cmd)
end

function _G.colorscheme(theme, bat)
    vim.cmd("colorscheme " .. theme)
    if bat then
        vim.cmd(fmt("let $BAT_THEME = '%s'", (bat and bar or "ansi")))
    end
    black         = vim.g.terminal_color_0
    red           = vim.g.terminal_color_1
    green         = vim.g.terminal_color_2
    yellow        = vim.g.terminal_color_3
    blue          = vim.g.terminal_color_4
    magenta       = vim.g.terminal_color_5
    cyan          = vim.g.terminal_color_6
    white         = vim.g.terminal_color_7
    grey          = vim.g.terminal_color_8
    light_red     = vim.g.terminal_color_9
    light_green   = vim.g.terminal_color_10
    light_yellow  = vim.g.terminal_color_11
    light_blue    = vim.g.terminal_color_12
    light_magenta = vim.g.terminal_color_13
    light_cyan    = vim.g.terminal_color_14
    light_white   = vim.g.terminal_color_15
end
