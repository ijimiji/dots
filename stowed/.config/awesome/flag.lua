local wibox = require("wibox")
local naughty = require("naughty")

local get_layout = function ()
    local handle = io.popen('xkblayout-state print "%s%v"')
    local result = handle:read("*a")
    handle:close()
    return result
end

local flags = {
    ["bylatin"] = "/home/jahor/.config/awesome/icon/latin.png",
    ["by"]      = "/home/jahor/.config/awesome/icon/by.png",
    ["ru"]      = "/home/jahor/.config/awesome/icon/rus.png"
}

local flagbox = wibox.widget {
    image  = flags[get_layout()],
    resize = true,
    widget = wibox.widget.imagebox
}

awesome.connect_signal("xkb::group_changed", function() 
    flagbox.image = flags[get_layout()]
end)

awesome.connect_signal("xkb::map_changed", function() 
    flagbox.image = flags[get_layout()]
end)

return flagbox
