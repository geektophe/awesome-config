-- File system size widget definition
-- Module variables are :
--
-- widget : the wiget itself
-- icon : the associated widget icon
--
-- Note that he theme should have widget_disk attribute set

local vicious = require("vicious")
local awful = require("awful")
local gmail = require("widgets.vicious.gmail")
local beautiful = beautiful
local widget_init = widget
local image = image

module("widgets.gmail")

local _gmailicon = nil
local _gmailwidget = nil
local _gmailenabled = true


local function gmail_toggle()
    if _gmailenabled then
        vicious.unregister(_gmailwidget, true)
        _gmailwidget.text = '<span color="white" bgcolor="grey" weight="bold"> dis </span>'
    else
        vicious.activate(_gmailwidget)
    end
    _gmailenabled = not _gmailenabled
end


function icon()
    if _gmailicon == nil then
        _gmailicon = widget_init({ type = "imagebox" })
        _gmailicon.image = image(beautiful.widget_gmail)
    end
    return _gmailicon
end


function widget()
    if _gmailwidget == nil then
        _gmailwidget = widget_init({ type = "textbox" })
        _gmailwidget:buttons(awful.util.table.join(
                awful.button({ }, 1, function ()
                        gmail_toggle()
                end)))
        vicious.register(_gmailwidget, gmail,'$1', 30)
    end
    return _gmailwidget
end

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
