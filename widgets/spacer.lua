-- Clock widget definition
-- Module functions are :
--
-- widget : returns the wiget
--
-- Note that he theme should have widget_cpu attribute set

local wibox = wibox

module("widgets.spacer")

local _spacer = nil

function widget()
    if _spacer == nil then
        _spacer = wibox.widget.textbox()
        _spacer:set_text("   ")
    end
    return _spacer
end

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
