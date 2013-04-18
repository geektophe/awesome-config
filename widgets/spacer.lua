-- Clock widget definition
-- Module functions are :
--
-- widget : returns the wiget
--
-- Note that he theme should have widget_cpu attribute set

local widget_new = widget

module("widgets.spacer")

local _spacer = nil

function widget()
    if _spacerw == nil then
        _spacer = widget_new({ type = "textbox", name = "spacer" })
        _spacer.text = "   "
    end
    return _spacer
end

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
