-- MEM widget definition
-- Module functions are :
--
-- widget : returns the wiget
-- icon : returns the associated widget icon
--
-- Note that he theme should have widget_mem attribute set

local process = require("utils.process")
local system = require("utils.system")
local vicious = require("vicious")
local awful = require("awful")
local beautiful = beautiful
local widget_init = widget
local image = image

module("widgets.mem")

-- Adapt this program to your environment
local sysmonitor = "gnome-system-monitor"

local function check()
    if not system.is_executable(sysmonitor) then
        naughty.notify({ text = "Missing program " .. sysmonitor })
    end
end

function widget()
    check()
    local memwidget= awful.widget.graph()
    memwidget:set_width(40)
    memwidget:set_background_color("#494B4F")
    memwidget:set_border_color("#727352")
    memwidget:set_color("#AECF96")
    memwidget:set_gradient_colors({ "#AECF96", "#88A175", "#FF5656" })
    vicious.register(memwidget, vicious.widgets.mem, "$1")

    memwidget.widget:buttons(awful.util.table.join(
        awful.button({ }, 1, function () process.run_or_raise(sysmonitor) end)
    ))
    return memwidget.widget
end

-- MEM icon
function icon()
    local memicon = widget_init({ type = "imagebox" })
    memicon.image = image(beautiful.widget_mem)
    return memicon
end

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
