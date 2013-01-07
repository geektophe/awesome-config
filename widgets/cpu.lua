-- CPU widget definition
-- Module functions are :
--
-- widget : returns the wiget
-- icon : returns the associated widget icon
--
-- Note that he theme should have widget_cpu attribute set

local process = require("utils.process")
local system = require("utils.system")
local vicious = require("vicious")
local awful = require("awful")
local naughty = require("naughty")
local beautiful = beautiful
local widget_init = widget
local image = image

module("widgets.cpu")

-- Adapt this program to your environment
local sysmonitor = "gnome-system-monitor"

local function check()
    if not system.is_executable(sysmonitor) then
        naughty.notify({ text = "Missing program " .. sysmonitor })
    end
end

function widget()
    check()
    -- CPU usage widget
    -- local cpuwidget = widget_init({ type = "textbox" })
    -- vicious.register(cpuwidget, vicious.widgets.cpu, "$1%")
    local cpuwidget = awful.widget.graph()
    cpuwidget:set_width(40)
    cpuwidget:set_background_color("#494B4F")
    cpuwidget:set_color("#FF5656")
    cpuwidget:set_border_color("#727352")
    cpuwidget:set_gradient_colors({ "#FF5656", "#88A175", "#AECF96" })
    vicious.register(cpuwidget, vicious.widgets.cpu, "$1")

    cpuwidget.widget:buttons(awful.util.table.join(
        awful.button({ }, 1, function () process.run_or_raise(sysmonitor) end)
    ))

    return cpuwidget.widget
end

-- CPU icon
function icon()
    local cpuicon = widget_init({ type = "imagebox" })
    cpuicon.image = image(beautiful.widget_cpu)
    return cpuicon
end
-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
