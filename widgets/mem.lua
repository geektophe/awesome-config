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

local memicon = nil
local memwidget = nil

function widget()
    if memicon == nil then
        memicon = widget_init({ type = "imagebox" })
        memicon.image = image(beautiful.widget_mem)
    end

    if memwidget == nil then
        memwidget = blingbling.classical_graph.new()
        memwidget:set_height(18)
        memwidget:set_width(100)
        memwidget:set_tiles_color("#00000022")
        memwidget:set_show_text(true)
        vicious.register(memwidget, vicious.widgets.mem, '$1')
    end

    return {
        memwidget.widget,
        memicon,
        layout = awful.widget.layout.horizontal.rightleft
        }
end

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
