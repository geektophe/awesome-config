-- File system size widget definition
-- Module variables are :
--
-- widget : the wiget itself
-- icon : the associated widget icon
--
-- Note that he theme should have widget_disk attribute set

local vicious = require("vicious")
local awful = require("awful")
local blingbling = require("blingbling")
local mcabber = require("widgets.vicious.mcabber")
local beautiful = beautiful
local widget_init = widget
local image = image
local mcabber_get_unread_buffers = mcabber_get_unread_buffers

module("widgets.im")

local _imicon = nil
local _imwidget = nil

function icon()
    if _imicon == nil then
        _imicon = widget_init({ type = "imagebox" })
        _imicon.image = image(beautiful.widget_im)
    end
    return _imicon
end

function widget()
    if _imwidget == nil then
        _imwidget = widget_init({ type = "textbox" })
        vicious.register(_imwidget, mcabber,'$1', 5)
    end
    return _imwidget
end

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
