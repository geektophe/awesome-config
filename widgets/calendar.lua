-- Clock widget definition
-- Module functions are :
--
-- widget : returns the wiget
--
-- Note that he theme should have widget_cpu attribute set

local awful = require('awful')
local blingbling = require('blingbling')

module("widgets.calendar")

local _calendarwidget = nil

function widget()
    if _calendarwidget == nil then
        _calendarwidget = blingbling.calendar()
        -- _calendarwidget:set_link_to_external_calendar(true)
    end

    return _calendarwidget
end

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
