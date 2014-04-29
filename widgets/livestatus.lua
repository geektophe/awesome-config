-- File system size widget definition
-- Module variables are :
--
-- widget : the wiget itself
-- icon : the associated widget icon
--
-- Note that he theme should have widget_disk attribute set

local vicious = require("vicious")
local awful = require("awful")
local blingbling = require("blingbling")
local livestatus = require("widgets.vicious.livestatus")
local beautiful = beautiful
local widget_init = widget
local image = image

module("widgets.livestatus")

local _livestatusicon = nil
local _livestatuswidget = nil
local _livestatusenabled = true


local function livestatus_toggle()
    if _livestatusenabled then
        vicious.unregister(_livestatuswidget, true)
        _livestatuswidget.text = '<span color="white" bgcolor="grey" weight="bold"> dis </span>'
    else
        vicious.activate(_livestatuswidget)
    end
    _livestatusenabled = not _livestatusenabled
end


function icon()
    if _livestatusicon == nil then
        _livestatusicon = widget_init({ type = "imagebox" })
        _livestatusicon.image = image(beautiful.widget_livestatus)
    end
    return _livestatusicon
end


function widget()
    if _livestatuswidget == nil then
        _livestatuswidget = widget_init({ type = "textbox" })
        _livestatuswidget:buttons(awful.util.table.join(
                awful.button({ }, 1, function ()
                        livestatus_toggle()
                end)))
        vicious.register(_livestatuswidget, livestatus,'$1', 30)
    end
    return _livestatuswidget
end

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
