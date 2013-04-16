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
local awesome = awesome
local beautiful = beautiful
local wibox = wibox

module("widgets.fs")

local fsicon = nil
local fswidget = nil

-- File system usage  widget
function icon()
    if fsicon == nil then
        fsicon = wibox.widget.imagebox()
        img = awesome.load_image(beautiful.widget_disk)
        fsicon:set_image(img)
    end
    return fsicon
end

function widget(wide)
    if fswidget == nil then
        fswidget = blingbling.progress_graph.new()
        fswidget:set_height(18)

        if wide == nil or wide then
            fswidget:set_width(50)
        else
            fswidget:set_width(40)
        end
        fswidget:set_show_text(true)
        fswidget:set_horizontal(true)
        -- fswidget:set_filled(true)
        -- fswidget:set_filled_color("#00000033")
        vicious.register(fswidget, vicious.widgets.fs, "${/ used_p}", 120 )
    end

    return fswidget
end

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
