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
local awesome = awesome
local beautiful = beautiful
local wibox = wibox

module("widgets.mem")

local memicon = nil
local memwidget = nil

function icon()
    if memicon == nil then
        memicon = wibox.widget.imagebox()
        img = awesome.load_image(beautiful.widget_mem)
        memicon:set_image(img)
    end
    return memicon
end

function widget(wide)
    if memwidget == nil then
        memwidget = blingbling.line_graph.new()
        memwidget:set_height(18)

        if wide == nil or wide then
            memwidget:set_width(100)
        else
            memwidget:set_width(75)
        end
        memwidget:set_graph_background_color("#00000022")
        memwidget:set_rounded_size(0.3)
        memwidget:set_show_text(true)
        vicious.register(memwidget, vicious.widgets.mem, '$1', 10)
    end

    return memwidget
end

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
