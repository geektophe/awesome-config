-- Clock widget definition
-- Module functions are :
--
-- widget : returns the wiget
--
-- Note that he theme should have widget_cpu attribute set

local awful = awful

module("widgets.clock")

function widget()
    return awful.widget.textclock({ align = "right" }, " %a %d %b  %H:%M ")
end

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
