-- Clock widget definition
-- Module functions are :
--
-- widget : returns the wiget
--
-- Note that he theme should have widget_cpu attribute set

local widget_create = widget

module("widgets.spacer")

local spacer = nil

function widget()
    if spacerw == nil then
        spacer = widget_create({ type = "textbox", name = "spacer" })
        spacer.text    = "   "
    end
    return spacer
end

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
