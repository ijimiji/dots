return function(plugins)

    require("packer").startup(function()
        for _, plugin in ipairs(plugins) do
            use(plugin)
        end
    end)

end
