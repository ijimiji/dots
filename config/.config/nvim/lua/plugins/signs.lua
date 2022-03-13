return function(signs)
    --local signs = {Error = "◍", Warn = "◍", Hint = "◍", Info = "◍"}
    for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end

    vim.fn.sign_define("LightBulbSign", {text = signs["Lightbulb"], texthl = "LspDiagnosticsDefaultWarning", linehl = "", numhl = ""})
end
