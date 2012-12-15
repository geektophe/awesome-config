-- Functions that help integrate MPD into widgets

-- Loads required libraries
local process = require("utils.process")
local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require("naughty")
local image = image

module("utils.mpd")

--{{{ Check
-- Check that necessary programs
local function check()
    local which = process.cmd_output("which mpc")

    if not which then
        naughty.notidy("MPD widget: missing mpd client (mpc)")
    end
end

--{{{ Toggle
-- Pauses current MPD playlist
function toggle()
    awful.util.spawn("mpc toggle")
end
--}}}

--{{{ Toggle
-- Changes MPD icon depending on its state, and send notifications when needed
-- Images cache
local img_mpd_play  = nil
local img_mpd_stop  = nil
local img_mpd_pause = nil
local last_song     = nil

--{{{ Init
-- Initilializes module with theme settings
-- Theme has to be loaded befgore the module is initialized
function init()
    check()
    img_mpd_play  = image(beautiful.widget_mpd_play)
    img_mpd_stop  = image(beautiful.widget_mpd_stop)
    img_mpd_pause = image(beautiful.widget_mpd_pause)
    last_song = ""
end

--{{{ Widget update
-- Updates widget attributes depending on MPD state
function widget_update(widget, args)
    if args["{state}"] == "Stop" then 
        if widget.image ~= img_mpd_stop then
    	    widget.image = img_mpd_stop
    	    naughty.notify({text="MPD stopped", timeout=30})
        end
    elseif args["{state}"] == "Pause" then 
        if widget.image ~= img_mpd_pause then
    	    widget.image = img_mpd_pause
            naughty.notify({text="MPD paused", timeout=30})
        end
    elseif args["{state}"] == "Play" then 
        current_song = args["{Artist}"]..' - '.. args["{Title}"]

        if widget.image ~= img_mpd_play then
	    widget.image = img_mpd_play
	    naughty.notify({text=current_song, timeout=30})
        else
	    if current_song ~= last_song then
	        last_song = current_song
	        naughty.notify({text=current_song, timeout=30})
	   end
       end
   end
end
-- }}}
