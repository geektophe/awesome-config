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
local awesome = awesome
local beautiful = beautiful
local wibox = wibox
local print = print

module("widgets.volume")

local volicon = nil
local volwidget = nil

-- File system usage  widget
function icon()
    if volicon == nil then
        volicon = wibox.widget.imagebox()
        img = awesome.load_image(beautiful.widget_vol)
        volicon:set_image(img)
    end
    return volicon
end

function widget()
    if volwidget == nil then
        print "fuck"
        volwidget = blingbling.volume.new({})
        volwidget:set_height(18)
        volwidget:set_width(50)
        --bind the volume widget on the master channel
        volwidget:update_master()
        volwidget:set_master_control()
        volwidget:set_bar(true)
    end

    return volwidget
end

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
