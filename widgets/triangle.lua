-- MEM widget definition
-- Module functions are :
--
-- widget : returns the wiget
-- icon : returns the associated widget icon
--
-- Note that he theme should have widget_mem attribute set

local gears = require("gears")
local math = math
local beautiful = beautiful
local awesome = awesome
local string = string
local wibox = wibox

module("widgets.triangle")


function widget(icon, max_value, bars_count, bar_width, height)
    local _icon = wibox.widget.imagebox()
    _icon:set_image(awesome.load_image(icon))

    local _text = wibox.widget {
        font             = beautiful.graph_font or beautiful.font or "sans 9",
        widget           = wibox.widget.textbox,
    }

    local _step = max_value / bars_count
    local _bars = {}
    local _bar_widgets = {
        spacing          = 2,
        layout = wibox.layout.fixed.horizontal,
    }

    for i=1, bars_count, 1 do
        local _bar = wibox.widget {
            max_value        = _step,
            forced_height    = height,
            forced_width     = bar_width,
            -- shape            = gears.shape.rounded_bar,
            -- border_width     = 1,
            color            = beautiful.graph_color or "#7fb21966",
            background_color = beautiful.graph_background_color or "#00000066",
            -- border_color     = beautiful.graph_border_color or "#00000000",
            -- bar_border_color = beautiful.bar_border_color or "#7fb219",
            widget           = wibox.widget.progressbar,
        }
        _bars[i] = _bar
        local _bar_height = height / (bars_count + 2) * (i + 2)
        local _margin = height - _bar_height
        _bar_widgets[i] = wibox.container.margin(_bar, 0, 0, _margin, 1)
    end

    local _widget = wibox.widget {
        _icon,
        _bar_widgets,
        layout = wibox.layout.fixed.horizontal
    }

    local _container = wibox.container.margin(_widget, 0, 0, 2, 1, "#00000000")

    _container.update = function (value)
         for i=1, bars_count, 1 do
             local _base = (i - 1) * _step
             local _val = math.max(0, value - _base)
             _val = math.min(_val, _step)
             _bars[i]:set_value(_val)
         end
     end

     return _container
end

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
