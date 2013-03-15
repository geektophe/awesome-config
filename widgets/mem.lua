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
local oocairo = require("oocairo")
local beautiful = beautiful
local wibox = wibox

module("widgets.mem")

local memicon = nil
local memwidget = nil

function widget(wide)
    if memicon == nil then
        memicon = wibox.widget.imagebox()
        memicon:set_image(oocairo.image_surface_create_from_png(beautiful.widget_mem))
    end

    if memwidget == nil then
        memwidget = blingbling.classical_graph.new()
        memwidget:set_height(18)

        if wide == nil or wide then
            memwidget:set_width(100)
        else
            memwidget:set_width(75)
        end
        memwidget:set_tiles_color("#00000022")
        memwidget:set_show_text(true)
        vicious.register(memwidget, vicious.widgets.mem, '$1')
    end

    return memwidget.widget
    -- local layout = wibox.layout.align.horizontal()
    -- layout:add(memwidget.widget)
    -- layout:add(memicon)
    -- return layout
end

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
