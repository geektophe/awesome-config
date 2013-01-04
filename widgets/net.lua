-- Network usage widget definition
-- Module variables are :
--
-- widget : the wiget itself
-- icon_up : the upload associated widget icon
-- icon_down : the upload associated widget icon
--
-- Note that he theme should have widget_net and widget_netup attributes set

local system = require("utils.system")
local process = require("utils.process")
local vicious = require("vicious")
local awful = require("awful")
local beautiful = beautiful
local widget_init = widget
local image = image

module("widgets.net")

-- Network usage widget
function widget()
    local intf      = system.main_intf()
    local netwidget = widget_init({ type = "textbox" })
    vicious.register(netwidget, vicious.widgets.net,
        '${' .. intf .. ' down_kb} kbps / ${' .. intf ..' up_kb} kbps', 3)
    return netwidget
end

-- File system icon
function icon_up()
    local neticon = widget_init({ type = "imagebox" })
    neticon.image = image(beautiful.widget_netup)
    return neticon
end

-- File system icon
function icon_down()
    local neticon = widget_init({ type = "imagebox" })
    neticon.image = image(beautiful.widget_net)
    return neticon
end
-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
