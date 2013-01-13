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
local beautiful = beautiful
local widget_init = widget
local image = image

module("widgets.fs")

-- File system usage  widget
function widget()
    local fsicon = widget_init({ type = "imagebox" })
    fsicon.image = image(beautiful.widget_disk)

    local fslabel = widget_init({ type = "textbox" })
    fslabel.text = "/ "

    local fswidget = blingbling.progress_bar.new()
    fswidget:set_height(18)
    fswidget:set_width(50)
    fswidget:set_show_text(true)
    fswidget:set_horizontal(true)
    -- fswidget:set_filled(true)
    -- fswidget:set_filled_color("#00000033")
    vicious.register(fswidget, vicious.widgets.fs, "${/ used_p}", 120 )

    return {
        fswidget.widget,
        fslabel,
        fsicon,
        layout = awful.widget.layout.horizontal.rightleft
        }
end

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
