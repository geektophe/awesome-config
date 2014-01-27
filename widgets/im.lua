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
local awesome = awesome
local wibox = wibox
local mcabber_get_unread_buffers = mcabber_get_unread_buffers

module("widgets.im")

local _imicon = nil
local _imwidget = nil
local _imenabled = true


local function im_toggle()
    if _imenabled then
        vicious.unregister(_imwidget, true)
        _imwidget.text = '<span color="white" bgcolor="grey" weight="bold"> dis </span>'
    else
        vicious.activate(_imwidget)
    end
    _imenabled = not _imenabled
end


function icon()
    if _imicon == nil then
        _imicon = wibox.widget.imagebox()
        _imicon:set_image(awesome.load_image(beautiful.widget_im))
    end
    return _imicon
end


function widget()
    if _imwidget == nil then
        _imwidget = wibox.widget.textbox()
        _imwidget:buttons(awful.util.table.join(
                awful.button({ }, 1, function ()
                        im_toggle()
                end)))
        vicious.register(_imwidget, mcabber,'$1', 5)
    end
    return _imwidget
end

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
