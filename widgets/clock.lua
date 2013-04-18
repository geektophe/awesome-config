-- Clock widget definition
-- Module functions are :
--
-- widget : returns the wiget
--
-- Note that he theme should have widget_cpu attribute set

local awful = require('awful')

module("widgets.clock")

local _clockwidget = nil

function widget()
    if _clockwidget == nil then
        _clockwidget = awful.widget.textclock({ align = "right" }, " %a %d %b  %H:%M ")
    end

    return _clockwidget
end

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
