-- Widget that monitors battery life

local vicious = require("vicious")
local volgraph = require("widgets.volgraph")
local naughty = require("naughty")
local beautiful = beautiful
local string = string
local awful = awful

module("widgets.volume")

local _widget = nil

function widget(volume_manager)
    if _widget == nil then
        _widget = volgraph.widget(beautiful.widget_vol, 100, 5, 7, 18)

       _widget:buttons(awful.util.table.join(
           awful.button({ }, 1, volume_manager.volume_toggle),
           awful.button({ }, 2, volume_manager.volume_run_mixer),
           awful.button({ }, 4, volume_manager.volume_up),
           awful.button({ }, 5, volume_manager.volume_down)
       ))

       volume_manager.add_vol_change_listener(_widget)
    end


    return _widget
end

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
