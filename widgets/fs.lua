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
local oocairo = require("oocairo")
local beautiful = beautiful
local wibox = wibox

module("widgets.fs")

local fsicon = nil
local fslabel = nil
local fswidget = nil

-- File system usage  widget
function widget(wide)
    if fsicon == nil then
        fsicon = wibox.widget.imagebox()
        fsicon:set_image(oocairo.image_surface_create_from_png(beautiful.widget_disk))
    end

    if fslabel == nil then
        fslabel = widget_init({ type = "textbox" })
        fslabel.text = "/ "
    end

    if fswidget == nil then
        fswidget = blingbling.progress_bar.new()
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

    return fswidget.widget
    -- local layout = wibox.layout.align.horizontal()
    -- layout:add(fswidget.widget)
    -- layout:add(fslabel)
    -- layout:add(fsicon)
    -- return layout
end

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
