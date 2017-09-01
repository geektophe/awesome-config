-- CPU widget definition

-- MEM widget definition

local vicious = require("vicious")
local cpusage = require("widgets.cpusage")
local beautiful = beautiful

module("widgets.cpu")

local _widget = nil

function widget(wide)
    if _widget == nil then
        local _width = wide and 150 or 75
        _widget = cpusage.widget(beautiful.widget_cpu, 102, 10, _width, 18)

        vicious.register(
            _widget.widget,
            vicious.widgets.cpu,
            function (widget, args) _widget.update(args) end,
            1
        )
    end

    return _widget
end

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
