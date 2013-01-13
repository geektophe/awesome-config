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
local widget_init = widget
local image = image

module("widgets.cpu")


function widget()
    local cpuicon = widget_init({ type = "imagebox" })
    cpuicon.image = image(beautiful.widget_cpu)
    --
    -- local cpulabel= widget_init({ type = "textbox" })
    -- cpulabel.text='CPU: '
    --
    local loadwidget = blingbling.classical_graph.new()
    loadwidget:set_height(18)
    loadwidget:set_width(150)
    loadwidget:set_tiles_color("#00000022")
    loadwidget:set_show_text(true)
    loadwidget:set_label("Load: $percent %")
    --
    --bind top popup on the graph
    -- blingbling.popups.htop(loadwidget.widget,
    --    { title_color = beautiful.notify_font_color_1,
    --       user_color = beautiful.notify_font_color_2,
    --       root_color = beautiful.notify_font_color_3,
    --       terminal = "urxvt"})
    vicious.register(loadwidget, vicious.widgets.cpu,'$1',2)
    --
    local core1widget=blingbling.progress_graph.new()
    core1widget:set_height(18)
    core1widget:set_width(11)
    core1widget:set_filled(true)
    core1widget:set_h_margin(2)
    core1widget:set_filled_color("#00000033")
    vicious.register(core1widget, vicious.widgets.cpu, "$2")
    --
    local core2widget=blingbling.progress_graph.new()
    core2widget:set_height(18)
    core2widget:set_width(11)
    core2widget:set_filled(true)
    core2widget:set_h_margin(2)
    core2widget:set_filled_color("#00000033")
    vicious.register(core2widget, vicious.widgets.cpu, "$2")

    return {
        loadwidget.widget,
        core2widget.widget,
        core1widget.widget,
        cpuicon,
        layout = awful.widget.layout.horizontal.rightleft
        }
end

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
