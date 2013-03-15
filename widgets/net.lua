-- Network usage widget definition
-- Module variables are :
--
-- widget : the wiget itself
-- icon_up : the upload associated widget icon
-- icon_down : the upload associated widget icon
--
-- Note that he theme should have widget_net and widget_netup attributes set

local vicious = require("vicious")
local awful = require("awful")
local blingbling = require("blingbling")
local oocairo = require("oocairo")
local utils = { system = require("utils.system") }
local beautiful = beautiful

module("widgets.net")

local netwidget = nil

-- Network usage widget
function widget()
    if netwidget == nil then
        netwidget = blingbling.net.new()
        netwidget:set_height(18)
        netwidget:set_ippopup()
        netwidget:set_show_text(true)
        netwidget:set_v_margin(3)
        netwidget:set_interface(utils.system.main_intf())
    end

    return netwidget.widget
end

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
