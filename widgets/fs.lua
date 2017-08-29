-- File system size widget definition


local vicious = require("vicious")
local progress = require("widgets.progress")
local beautiful = beautiful

module("widgets.fs")

local _widget = nil

function widget(wide)
    if _widget == nil then
        local _width = wide and 60 or 50
        _widget = progress.widget(beautiful.widget_fs, 102, _width, 18)

        -- vicious.register(_fstext, vicious.widgets.fs, "${/ used_p}", 120 )
        vicious.register(
            _widget.widget,
            vicious.widgets.fs,
            function (widget, args) _widget.update(args["{/ used_p}"]) end,
            120
        )
    end

    return _widget.widget
end

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
