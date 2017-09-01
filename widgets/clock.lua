-- Clock widget definition
-- Module functions are :
--
-- widget : returns the wiget
--
-- Note that he theme should have widget_cpu attribute set

local wibox = require('wibox')

module("widgets.clock")

local _clockwidget = nil

function widget()
    if _clockwidget == nil then
        _clockwidget = wibox.widget.textclock()
    end

    return _clockwidget
end

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
