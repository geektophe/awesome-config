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
local oocairo = require("oocairo")
local beautiful = beautiful
local wibox = wibox

module("widgets.cpu")

local cpuicon = nil
local loadwidget = nil
local core1widget = nil
local core2widget = nil

function widget(wide)
    if cpuicon == nil then
        cpuicon = wibox.widget.imagebox()
        cpuicon:set_image(oocairo.image_surface_create_from_png(beautiful.widget_cpu))
    end
    --
    -- local cpulabel= widget_init({ type = "textbox" })
    -- cpulabel.text='CPU: '
    --
    if loadwidget == nil then
        loadwidget = blingbling.classical_graph.new()
        loadwidget:set_height(18)

        if wide == nil or wide then
            loadwidget:set_width(150)
        else
            loadwidget:set_width(75)
        end
        loadwidget:set_tiles_color("#00000022")
        loadwidget:set_show_text(true)
        loadwidget:set_label("$percent %")
        --
        --bind top popup on the graph
        -- blingbling.popups.htop(loadwidget.widget,
        --    { title_color = beautiful.notify_font_color_1,
        --       user_color = beautiful.notify_font_color_2,
        --       root_color = beautiful.notify_font_color_3,
        --       terminal = "urxvt"})
        vicious.register(loadwidget, vicious.widgets.cpu,'$1',2)
    end
    --
    if core1widget == nil then
        core1widget = blingbling.progress_graph.new()
        core1widget:set_height(18)
        core1widget:set_width(11)
        core1widget:set_filled(true)
        core1widget:set_h_margin(2)
        core1widget:set_filled_color("#00000033")
        vicious.register(core1widget, vicious.widgets.cpu, "$2")
    end
    --
    if core2widget == nil then
        core2widget = blingbling.progress_graph.new()
        core2widget:set_height(18)
        core2widget:set_width(11)
        core2widget:set_filled(true)
        core2widget:set_h_margin(2)
        core2widget:set_filled_color("#00000033")
        vicious.register(core2widget, vicious.widgets.cpu, "$2")
    end

    return loadwidget.widget
    -- local layout = wibox.layout.align.horizontal()
    -- layout:add(loadwidget.widget)
    -- layout:add(core2widget.widget)
    -- layout:add(core1widget.widget)
    -- layout:add(cpuicon)
    -- return layout
end

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
