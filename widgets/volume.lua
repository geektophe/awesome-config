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
local oocairo = require("oocairo")
local beautiful = beautiful
local wibox = wibox

module("widgets.volume")

local volicon = nil
local volwidget = nil

-- File system usage  widget
function widget()
    if volicon == nil then
        volicon = wibox.widget.imagebox()
        volicon:set_image(oocairo.image_surface_create_from_png(beautiful.widget_vol))
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

    return volwidget.widget
    -- local layout = wibox.layout.align.horizontal()
    -- layout:add(volwidget.widget)
    -- layout:add(volicon)
    -- return layout
end

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
