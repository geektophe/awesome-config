-- CPU widget definition
-- Module functions are :
--
-- widget : returns the wiget
-- icon : returns the associated widget icon
--
-- Note that he theme should have widget_cpu attribute set

local vicious = require("vicious")
local awful = require("awful")
local blingbling = require("blingbling")
local beautiful = beautiful
local awesome = awesome
local wibox = wibox

module("widgets.cpu")

local _cpuicon = nil
local _loadwidget = nil
local _core1widget = nil
local _core2widget = nil

function icon()
    if _cpuicon == nil then
        _cpuicon = wibox.widget.imagebox()
        _cpuicon:set_image(awesome.load_image(beautiful.widget_cpu))
    end
    return _cpuicon
end

function loadwidget(wide)
    if _loadwidget == nil then
        _loadwidget = blingbling.line_graph.new()
        _loadwidget:set_height(18)

        if wide == nil or wide then
            _loadwidget:set_width(150)
        else
            _loadwidget:set_width(75)
        end
        -- _loadwidget:set_graph_background_color("#00000022")
        _loadwidget:set_show_text(true)
        _loadwidget:set_label("$percent %")
        vicious.register(_loadwidget, vicious.widgets.cpu,'$1', 3)
    end
    return _loadwidget
end

function core1widget(wide)
    if _core1widget == nil then
        _core1widget = blingbling.progress_graph.new()
        _core1widget:set_height(18)
        _core1widget:set_width(11)
        -- _core1widget:set_filled(true)
        _core1widget:set_h_margin(2)
        -- _core1widget:set_graph_background_color("#00000033")
        vicious.register(_core1widget, vicious.widgets.cpu, "$2")
    end
    return _core1widget
end

function core2widget(wide)
    if _core2widget == nil then
        _core2widget = blingbling.progress_graph.new()
        _core2widget:set_height(18)
        _core2widget:set_width(11)
        -- _core2widget:set_filled(true)
        _core2widget:set_h_margin(2)
        -- _core2widget:set_graph_background_color("#00000033")
        vicious.register(_core2widget, vicious.widgets.cpu, "$3")
    end
    return _core2widget
end

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
