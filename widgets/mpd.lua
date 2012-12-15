-- MPD definition
-- Module functions are :
--
-- widget : returns the wiget
-- icon : returns the associated widget icon 
--
-- Note that he theme should have widget_music attribute set

local process = require("utils.process")
local mpd = require("utils.mpd")
-- local awesompd = require("awesompd/awesompd")
local awful = awful
local vicious = vicious
local beautiful = beautiful
local widget_init = widget
local image = image

module("widgets.mpd")

-- Adapt this program to your environment
local mpdclient = "sonata"

local function check()
    if not system.is_executable("mpc") then
        naughty.notify({ text = "Missing program " .. sysmonitor })
    end
    if not system.is_executable(mpdclient) then
        naughty.notify({ text = "Missing program " .. sysmonitor })
    end
end

function widget()
    -- Create MPD usage widget
    -- mpdwidget = widget({ type = "textbox", name = "mpdwidget" })
    -- vicious.register(mpdwidget, vicious.widgets.mpd,
    --     function (widget, args)
    --         if args["{state}"] == "Stop" then 
    --             return " - "
    --         else 
    --             return args["{Artist}"]..' - '.. args["{Title}"]
    --         end
    --     end, 10)
    
    -- musicwidget = awesompd:create() -- Create awesompd widget
    -- musicwidget.font = "Liberation Mono" -- Set widget font 
    -- musicwidget.scrolling = true -- If true, the text in the widget will be scrolled
    -- musicwidget.output_size = 30 -- Set the size of widget in symbols
    -- musicwidget.update_interval = 10 -- Set the update interval in seconds
    -- -- Set the folder where icons are located (change username to your login name)
    -- musicwidget.path_to_icons = themes .. themename ..  "/icons" 
    -- -- Set the default music format for Jamendo streams. You can change
    -- -- this option on the fly in awesompd itself.
    -- -- possible formats: awesompd.FORMAT_MP3, awesompd.FORMAT_OGG
    -- musicwidget.jamendo_format = awesompd.FORMAT_MP3
    -- -- If true, song notifications for Jamendo tracks and local tracks will also contain
    -- -- album cover image.
    -- musicwidget.show_album_cover = true
    -- -- Specify how big in pixels should an album cover be. Maximum value
    -- -- is 100.
    -- musicwidget.album_cover_size = 50
    -- -- This option is necessary if you want the album covers to be shown
    -- -- for your local tracks.
    -- musicwidget.mpd_config = "/etc/mpd.conf"
    -- -- Specify the browser you use so awesompd can open links from
    -- -- Jamendo in it.
    -- musicwidget.browser = "firefox"
    -- -- Specify decorators on the left and the right side of the
    -- -- widget. Or just leave empty strings if you decorate the widget
    -- -- from outside.
    -- musicwidget.ldecorator = " "
    -- musicwidget.rdecorator = " "
    -- -- Set all the servers to work with (here can be any servers you use)
    -- musicwidget.servers = { { server = "localhost", port = 6600 } }
    -- -- Set the buttons of the widget
    -- musicwidget:register_buttons({ { "", awesompd.MOUSE_LEFT, musicwidget:command_toggle() },
    --                    { "Control", awesompd.MOUSE_SCROLL_UP, musicwidget:command_prev_track() },
    --                     { "Control", awesompd.MOUSE_SCROLL_DOWN, musicwidget:command_next_track() },
    --                     { "", awesompd.MOUSE_SCROLL_UP, musicwidget:command_volume_up() },
    --                     { "", awesompd.MOUSE_SCROLL_DOWN, musicwidget:command_volume_down() },
    --                     { "", awesompd.MOUSE_RIGHT, musicwidget:command_show_menu() } })
    -- musicwidget:run() -- After all configuration is done, run the widget

    mpd.init()
    local mpdwidget = widget_init({ type = "imagebox" })
    vicious.register(mpdwidget, vicious.widgets.mpd, mpd.widget_update, 1)
    
    mpdwidget:buttons(awful.util.table.join(
        awful.button({ }, 1, mpd.toggle),
        awful.button({ }, 3, function () process.run_or_raise(mpdclient) end)
    ))
    return mpdwidget
end

-- MPD icon
function icon()
    local mpdicon = widget_init({ type = "imagebox" })
    mpdicon.image = image(beautiful.widget_music)
    return mpdicon
end

