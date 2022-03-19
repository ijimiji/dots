return function(servers, completion, my_on_attach)
    local lsp_installer_servers = require("nvim-lsp-installer.servers")
    for _, server in ipairs(servers) do
        opts = {
            on_attach = my_on_attach
        }
        local server_name = type(server) == "table" and server[1] or server
        local server_available, requested_server = lsp_installer_servers.get_server(server_name)
        if server_available then
            if not requested_server:is_installed() then
                requested_server:install()
            end
            requested_server:on_ready(function ()
                requested_server:setup(opts)
            end)
        end
    end
end
