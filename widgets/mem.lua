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
local widget_init = widget
local image = image

module("widgets.mem")

local _memicon = nil
local _memwidget = nil

function icon()
    if _memicon == nil then
        _memicon = widget_init({ type = "imagebox" })
        _memicon.image = image(beautiful.widget_mem)
    end
    return _memicon
end

function widget(wide)
    if _memwidget == nil then
        _memwidget = blingbling.classical_graph.new()
        _memwidget:set_height(18)

        if wide == nil or wide then
            _memwidget:set_width(100)
        else
            _memwidget:set_width(75)
        end
        _memwidget:set_tiles_color("#00000022")
        _memwidget:set_show_text(true)
        vicious.register(_memwidget, vicious.widgets.mem, '$1')
    end

    return _memwidget.widget
end

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
