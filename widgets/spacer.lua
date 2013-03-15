-- Clock widget definition
-- Module functions are :
--
-- widget : returns the wiget
--
-- Note that he theme should have widget_cpu attribute set

local wibox = wibox

module("widgets.spacer")

local spacer = nil

function widget()
    if spacerw == nil then
        spacer = wibox.widget.textbox()
        spacer:set_text("   ")
    end
    return spacer
end

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
