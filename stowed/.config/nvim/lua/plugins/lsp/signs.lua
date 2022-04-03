return function(icons)
    signs = {Error = icons["problem"], Warn = icons["warning"], Hint = icons["hint"], Info = icons["hint"], Bulb = icons["bulb"]}
    for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end
    vim.fn.sign_define("LightBulbSign", {text = signs["Bulb"], texthl = "LspDiagnosticsDefaultWarning", linehl = "", numhl = ""})
end
