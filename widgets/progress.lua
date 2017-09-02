-- MEM widget definition
-- Module functions are :
--
-- widget : returns the wiget
-- icon : returns the associated widget icon
--
-- Note that he theme should have widget_mem attribute set

local vicious = require("vicious")
local awful = require("awful")
local naughty = require("naughty")
local gears = require("gears")
local beautiful = beautiful
local awesome = awesome
local string = string
local wibox = wibox

module("widgets.progress")


function widget(icon, max_value, width, height)
    local _icon = wibox.widget.imagebox()
    _icon:set_image(awesome.load_image(icon))

    local _text = wibox.widget {
        font             = beautiful.graph_font or beautiful.font or "sans 9",
        widget           = wibox.widget.textbox,
    }

    local _graph = wibox.widget {
        max_value        = max_value,
        forced_height    = height,
        forced_width     = width,
        -- shape            = gears.shape.rounded_bar,
        border_width     = 1,
        color            = beautiful.graph_color or "#7fb21966",
        background_color = beautiful.graph_background_color or "#00000066",
        border_color     = beautiful.graph_border_color or "#00000000",
        bar_border_color = beautiful.bar_border_color or "#7fb219",
        widget           = wibox.widget.progressbar,
    }

    local _widget = wibox.widget {
        _icon,
        {
            _graph,
            _text,
            layout = wibox.layout.stack
        },
        layout = wibox.layout.fixed.horizontal
    }

    local _container = wibox.container.margin(_widget, 0, 0, 2, 1, "#00000000")
    local _current_value = nil

    _container.update = function (value)
        if value ~= _current_value then
             local _bg_color = beautiful.graph_background_color or "#00000066"
             local _markup = '<span bgcolor="%s"> %d %% </span>'
             local _display = string.format(_markup, _bg_color, value)
             _text:set_markup(_display)
             _graph:set_value(value)
         end
     end

     return _container
end

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
