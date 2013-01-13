-- Widget that monitors battery life
-- Module variables are :
--
-- widget : the wiget itself
-- icon : the associated widget icon
--
-- Note that he theme should have widget_disk attribute set

local vicious = require("vicious")
local awful = require("awful")
local blingbling = require("blingbling")
local naughty = require("naughty")
local beautiful = beautiful
local widget_init = widget
local image = image

module("widgets.bat")

-- File system usage  widget
function widget()
    local baticon = widget_init({ type = "imagebox" })
    baticon.image = image(beautiful.widget_bat)

    batwidget=blingbling.progress_bar.new()
    batwidget:set_height(18)
    batwidget:set_width(50)
    batwidget:set_show_text(true)
    batwidget:set_horizontal(true)
    -- batwidget:set_filled(true)
    -- batwidget:set_filled_color("#00000033")
    vicious.register(batwidget, vicious.widgets.bat, "$2", 61, "BAT0",
        --Bat % Warning
        function (widget, args)
            if args[2] < 15 then
                naughty.notify({
                    title = "<span color='red'>Battery Warning</span>",
                    text = "<span color='red'>Battery low! "..args[2].."% left!</span>",
                    timeout = 60,
                    position = "top_right",
                    fg = beautiful.fg_focus,
                    bg = beautiful.bg_focus, })
            end
            return '<span color="white">(Bat: ' .. args[1] .. args[2] .. '% ' .. string.sub(args[3], 0, 5) .. ')</span>' end , 30, "BAT0")



    return {
        batwidget.widget,
        baticon,
        layout = awful.widget.layout.horizontal.rightleft
        }
end

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
