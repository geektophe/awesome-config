-- Modal keys mode definition
-- Module variables are :
--
-- widget : the wiget itself
-- icon : the associated widget icon
--
-- Note that he theme should have widget_disk attribute set

local awful = require("awful")
local naugty = require("naughty")
local string = string
local awesome = awesome
local beautiful = beautiful
local wibox = wibox

module("widgets.mode")

local _modeicon = nil
local _modewidget = nil


local _modes = {
    NORMAL = {
        label = "",
        color = "green"
    },
    RESIZE = {
        label = " RESIZE ",
        color = "orange"
    },
    MOVE = {
        label = " MOVE ",
        color = "yellow"
    }
}


function set_mode(mode)
    if not _modes[mode] then
        naughty.notify({
            title = "Mode error",
            text = "Invalid mode set: " .. mode,
            preset = naughty.config.presets.critical
        })
    elseif not _modewidget then
        naughty.notify({
            title = "Mode error",
            text = "Mode widget not initialized",
            preset = naughty.config.presets.critical
        })
    else
        text = string.format(
            '<span color="white" bgcolor="%s" weight="bold">%s</span>',
            _modes[mode]["color"],
            _modes[mode]["label"]
        )
        _modewidget:set_markup(text)
    end
end


function widget()
    if _modewidget == nil then
        _modewidget = wibox.widget.textbox()
        set_mode("NORMAL")
    end
    return _modewidget
end

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
