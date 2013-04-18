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

local _volicon = nil
local _volwidget = nil

function icon()
    if _volicon == nil then
        _volicon = widget_init({ type = "imagebox" })
        _volicon.image = image(beautiful.widget_vol)
    end
    return _volicon
end

function widget()

    if _volwidget == nil then
        _volwidget = blingbling.volume.new()
        _volwidget:set_height(18)
        _volwidget:set_width(50)
        --bind the volume widget on the master channel
        _volwidget:update_master()
        _volwidget:set_master_control()
        _volwidget:set_bar(true)
    end

    return _volwidget.widget
end

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
