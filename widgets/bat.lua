-- Widget that monitors battery life

local progress = require("widgets.progress")
local naughty = require("naughty")
local beautiful = beautiful
local vicious = vicious
local string = string

module("widgets.bat")

local _widget = nil

function widget(wide)
    if _widget == nil then
        local _width = wide and 60 or 50
        _widget = progress.widget(beautiful.widget_bat, 102, _width, 18)

        vicious.register(
            _widget.widget,
            vicious.widgets.bat,
            function (widget, args) _widget.update(args[2]) end,
            61,
            "BAT0",
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
            end,
            30,
            "BAT0"
        )
    end

    return _widget
end

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
