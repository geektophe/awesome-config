-- Pulseaudio volume management library.
--
-- Taken from Awesome Wiki:
--
-- http://awesome.naquadah.org/wiki/Roultabie_volume_widget_for_PulseAudio
--

local io = io
local math = math
local tonumber = tonumber
local tostring = tostring
local string = string
local awful = awful

module("utils.pulseaudio")

function volume_up()
    awful.util.spawn("amixer -D pulse sset Master 5%+")
end

function volume_down()
    awful.util.spawn("amixer -D pulse sset Master 5%-")
end

function volume_mute()
    awful.util.spawn("amixer -D pulse sset Master toggle")
end

function volume_info()
    volmin = 0
    volmax = 65536
    local f = io.popen("pacmd dump |grep set-sink-volume")
    local g = io.popen("pacmd dump |grep set-sink-mute")
    local v = f:read()
    local mute = g:read()
    if mute ~= nil and string.find(mute, "no") then
        volume = math.floor(tonumber(string.sub(v, string.find(v, 'x')-1)) * 100 / volmax).." %"
    else
        volume = "✕"
    end
    f:close()
    g:close()
    return "𝅘𝅥𝅮 "..volume
end

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
