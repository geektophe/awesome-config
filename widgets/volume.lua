-- Widget that monitors battery life

local vicious = require("vicious")
local triangle = require("widgets.triangle")
local naughty = require("naughty")
local beautiful = beautiful
local string = string

module("widgets.volume")

local _widget = nil

function widget()
    if _widget == nil then
        _widget = triangle.widget(beautiful.widget_vol, 100, 5, 7, 18)
        _widget.update(50)
    end

    return _widget
end

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
