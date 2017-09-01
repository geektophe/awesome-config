-- Pulseaudio volume management library.
--
-- Taken from Awesome Wiki:
--
-- http://awesome.naquadah.org/wiki/Roultabie_volume_widget_for_PulseAudio
--

local naughty = require("naughty")
local io = io
local math = math
local tonumber = tonumber
local tostring = tostring
local string = string
local awful = awful
local print = print
local ipairs = ipairs
local timer = timer

module("utils.pulseaudio")

local _vol_change_listeners = {}
local _vol_change_timer = nil
local _vol_change_enabled = true

local function get_spawn_cb(errmsg)
    return function(stdout, stderr, reason, exit_code)
        if exit_code ~= 0 then
            naughty.notify({
                text = string.format(errmsg, stderr)
            })
            return
        end
        volume_update_widgets()
    end
end

local function volume_update_widgets()
    awful.spawn.easy_async("amixer -D pulse sget Master",
        function(stdout, stderr, reason, exit_code)
            if exit_code ~= 0 then
                naughty.notify({
                    text = string.format("Failed to get volume level: %s", stderr)
                })
                return
            end
            local _pct = stdout:match("Playback [%d]+ %[([%d]+)%%%]")
            if _pct ~= nil then
                for _, _listener in ipairs(_vol_change_listeners) do
                    _listener.update(_pct)
                end
            end
        end
    )
end

local function set_vol_change_timer()
    _vol_change_timer = timer({timeout = 1})
    _vol_change_timer:connect_signal("timeout", function()
        print("prout")
        if _vol_change_enabled then
            volume_update_widgets()
        end
    end)
    _vol_change_timer:start()
end

set_vol_change_timer()

function volume_up()
    awful.spawn.easy_async(
        "amixer -D pulse sset Master 3%+",
        get_spawn_cb("Failed raise volume level: %s")
    )
end

function volume_down()
    awful.spawn.easy_async(
        "amixer -D pulse sset Master 3%-",
        get_spawn_cb("Failed lower volume level: %s")
    )
end

function volume_mute()
    awful.spawn.easy_async(
        "amixer -D pulse sset Master toggle",
        get_spawn_cb("Failed togle volume mute: %s")
    )
end

function add_vol_change_listener(listener)
    _vol_change_listeners[#_vol_change_listeners + 1] = listener
end

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
