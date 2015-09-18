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
local awesome = awesome
local wibox = wibox

module("widgets.bat")

local _baticon = nil
local _batwidget = nil

function icon()
    if _baticon == nil then
        _baticon = wibox.widget.imagebox()
        _baticon:set_image(awesome.load_image(beautiful.widget_bat))
    end
    return _baticon
end

function widget(wide)
    if _batwidget == nil then
        _batwidget=blingbling.progress_graph.new()
        _batwidget:set_height(18)
        if wide == nil or wide then
            _batwidget:set_width(50)
        else
            _batwidget:set_width(40)
        end
        _batwidget:set_show_text(true)
        _batwidget:set_horizontal(true)
        -- _batwidget:set_filled(true)
        --  _batwidget:set_graph_background_color("#00000033")
        vicious.register(_batwidget, vicious.widgets.bat, "$2", 61, "BAT0",
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
    end

    return _batwidget
end

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
