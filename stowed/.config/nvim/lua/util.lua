fmt = string.format
function _G.colorscheme(theme, bat)
    if before then 
        before()
    end
    vim.cmd("colorscheme " .. theme)

    if bat then
        vim.cmd(fmt("let $BAT_THEME = '%s'", (bat and bar or "ansi")))
    end
    if after then 
        after()
    end
    vim.cmd [[
    highlight link NotifyERRORBorder ErrorMsg
    highlight link NotifyERRORIcon   ErrorMsg
    highlight link NotifyERRORTitle  ErrorMsg
    highlight link NotifyWARNBorder  Todo
    highlight link NotifyWARNIcon    Todo
    highlight link NotifyWARNTitle   Todo
    highlight link NotifyINFOBorder  ErrorMsg
    highlight link NotifyINFOTitle   ErrorMsg
    highlight link NotifyINFOIcon    ErrorMsg
    highlight link NotifyTRACEBorder ErrorMsg
    highlight link NotifyTRACEIcon   ErrorMsg
    highlight link NotifyTRACETitle  ErrorMsg
    highlight link NotifyDEBUGIcon   ErrorMsg
    highlight link NotifyDEBUGBorder ErrorMsg
    highlight link NotifyDEBUGTitle  ErrorMsg
    ]]
end

