-- MEM widget definition

local graph = require("widgets.graph")
local beautiful = beautiful
local vicious = vicious

module("widgets.mem")

local _widget = nil

function widget(wide)
    if _widget == nil then
        local _width = wide and 60 or 50
        _widget = graph.widget(beautiful.widget_mem, 102, _width, 18)

        vicious.register(
            _widget.widget,
            vicious.widgets.mem,
            function (widget, args) _widget.update(args[1]) end,
            1
        )
    end

    return _widget.widget
end

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
