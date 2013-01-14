-- Volume widget definition
-- Module variables are :
--
-- widget : the wiget itself
-- icon : the associated widget icon
--
-- Note that he theme should have widget_disk attribute set

local vicious = require("vicious")
local awful = require("awful")
local blingbling = require("blingbling")
local beautiful = beautiful
local widget_init = widget
local image = image

module("widgets.volume")

local volicon = nil
local volwidget = nil

-- File system usage  widget
function widget()
    if volicon == nil then
        volicon = widget_init({ type = "imagebox" })
        volicon.image = image(beautiful.widget_vol)
    end

    if volwidget == nil then
        volwidget = blingbling.volume.new()
        volwidget:set_height(18)
        volwidget:set_width(50)
        --bind the volume widget on the master channel
        volwidget:update_master()
        volwidget:set_master_control()
        volwidget:set_bar(true)
    end

    return {
        volwidget.widget,
        volicon,
        layout = awful.widget.layout.horizontal.rightleft
        }
end

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
