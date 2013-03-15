-- Clock widget definition
-- Module functions are :
--
-- widget : returns the wiget
--
-- Note that he theme should have widget_cpu attribute set

local awful = require('awful')

module("widgets.clock")

local clockwidget = nil

function widget()
    if clockwidget == nil then
        -- clockwidget = awful.widget.textclock({ align = "right" }, " %a %d %b  %H:%M ")
        clockwidget = awful.widget.textclock()
    end

    return clockwidget
end

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
