-- MEM widget definition
-- Module functions are :
--
-- widget : returns the wiget
-- icon : returns the associated widget icon
--
-- Note that he theme should have widget_mem attribute set

local vicious = require("vicious")
local awful = require("awful")
local blingbling = require("blingbling")
local beautiful = beautiful
local awesome = awesome
local wibox = wibox

module("widgets.mem")

local _memicon = nil
local _memwidget = nil

function icon()
    if _memicon == nil then
        _memicon = wibox.widget.imagebox()
        _memicon:set_image(awesome.load_image(beautiful.widget_mem))
    end
    return _memicon
end

function widget(wide)
    if _memwidget == nil then
        _memwidget = blingbling.line_graph.new()
        _memwidget:set_height(18)

        if wide == nil or wide then
            _memwidget:set_width(60)
        else
            _memwidget:set_width(50)
        end
        -- _memwidget:set_graph_background_color("#00000022")
        _memwidget:set_show_text(true)
        vicious.register(_memwidget, vicious.widgets.mem, '$1', 10)
    end

    return _memwidget
end

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
