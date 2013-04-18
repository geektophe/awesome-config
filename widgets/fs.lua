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

local _fsicon = nil
local _fswidget = nil

-- File system usage  widget
function icon()
    if _fsicon == nil then
        _fsicon = wibox.widget.imagebox()
        _fsicon:set_image(awesome.load_image(beautiful.widget_disk))
    end
    return _fsicon
end

function widget(wide)
    if _fswidget == nil then
        _fswidget = blingbling.progress_graph.new()
        _fswidget:set_height(18)

        if wide == nil or wide then
            _fswidget:set_width(50)
        else
            _fswidget:set_width(40)
        end
        _fswidget:set_show_text(true)
        _fswidget:set_horizontal(true)
        -- _fswidget:set_filled(true)
        -- _fswidget:set_filled_color("#00000033")
        vicious.register(_fswidget, vicious.widgets.fs, "${/ used_p}", 120 )
    end

    return _fswidget
end

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
