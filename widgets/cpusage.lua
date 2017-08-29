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
local ipairs = ipairs
local io = io
local print = print

module("widgets.cpusage")


function widget(icon, max_value, core_width, graph_width, height)
        local _icon = wibox.widget.imagebox()
        _icon:set_image(awesome.load_image(icon))

        -- Count CPU cores
        local _num_cores = 0
        for line in io.lines("/proc/cpuinfo") do
            for k, v in string.gmatch(line, "([%a%s]+)[%s]+:[%s]([%d]+).-$") do
                if k == "processor" then
                    _num_cores = _num_cores + 1
                end
            end
        end

        local _cores = {}
        local _cores_widgets = {
            spacing          = 3,
            layout           = wibox.layout.fixed.horizontal
        }

        for i=1, _num_cores, 1 do
            local _core = wibox.widget {
                max_value        = max_value,
                -- shape            = gears.shape.rounded_bar,
                border_width     = 1,
                color            = beautiful.graph_color or "#7fb21966",
                background_color = beautiful.graph_background_color or "#00000066",
                border_color     = beautiful.graph_border_color or "#00000000",
                bar_border_color = beautiful.bar_border_color or "#7fb219",
                widget           = wibox.widget.progressbar,
            }
            _cores[i] = {
                widget = _core,
            }
            _cores_widgets[i] = wibox.widget {
                {
                    widget = _core
                },
                direction        = 'east',
                forced_width     = core_width,
                layout           = wibox.container.rotate,
            }
        end

        local _text = wibox.widget {
            font   = beautiful.graph_font or beautiful.font or "sans 9",
            widget = wibox.widget.textbox,
        }

        local _graph = wibox.widget {
	    max_value        = max_value,
	    forced_width     = graph_width,
	    -- shape            = gears.shape.rounded_bar,
            border_width     = 1,
            color            = beautiful.graph_color or "#7fb21966",
            background_color = beautiful.graph_background_color or "#00000066",
            border_color     = beautiful.graph_border_color or "#00000000",
            stack            = true,
            stack_colors     = {
                                   beautiful.graph_color or "#7fb21966",
                                   beautiful.bar_border_color or "#7fb219",
                               },
	    widget           = wibox.widget.graph,
	}
        local _line_border_width = max_value / height

	local _widget = wibox.widget {
            _icon,
            _cores_widgets,
            {
                wibox.container.mirror(_graph, {horizontal=true}),
                _text,
                layout = wibox.layout.stack
            },
            spacing = 3,
            layout  = wibox.layout.fixed.horizontal
	}

    return {
        widget = wibox.container.margin(_widget, 0, 0, 2, 1, "#00000000"),
        icon   = _icon,
        text = _text,
        graph  = _graph,
        update = function (values)
                     for i, v in ipairs(values) do
                         if i == 1 then
                             local _bg_color = beautiful.graph_background_color or "#00000066"
                             local _markup = '<span bgcolor="%s"> %d %% </span>'
                             local _display = string.format(_markup, _bg_color, v)
                             _text:set_markup(_display)
                             _graph:add_value(v, 1)
                             _graph:add_value(_line_border_width, 2)
                         else
                             _cores[_num_cores - i + 2].widget:set_value(v)
                         end
                     end
                 end,
    }
end

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
