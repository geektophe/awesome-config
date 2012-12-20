

-- {{{ Includes
-- Sets locale
os.setlocale("fr_FR.UTF-8")

-- Standard awesome library
require("awful")
require("awful.autofocus")
require("awful.rules")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")
-- Widgets library
vicious = require("vicious")
-- Revelation library
require("revelation")

-- Loads Shifty automatic tags management library
require('shifty')

-- Loads Teardrop dropdown terminal
require('teardrop')

-- Loads utils libraries
require("utils.process")
require("utils.client")
require("utils.system")
require("utils.mpd")

-- Loads widgets libraries
require("widgets.cpu")
require("widgets.fs")
require("widgets.mem")
require("widgets.net")
require("widgets.mpd")

require("cfg.shifty")
require("cfg.keys")

-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
-- beautiful.init("/usr/share/awesome/themes/default/theme.lua")
confdir = awful.util.getdir("config")
themes = confdir .. "/themes/"
themename = "wombat-bo"
beautiful.init(themes .. themename .. "/theme.lua")

-- This is used later as the default terminal and editor to run.
-- terminal = "x-terminal-emulator"
terminal = "xterm"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"
-- }}}

-- {{{ Layouts definition
-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier
}
-- }}}

-- {{{ Configuration modules (depend on previous variables)
-- }}}

-- {{{ Shifty settings
shifty.config.tags = cfg.shifty.tags()
shifty.config.apps = cfg.shifty.apps()
shifty.config.defaults = cfg.shifty.defaults()
shifty.init()
-- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua" },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}

mymainmenu = awful.menu({ items = {
	{ "awesome", myawesomemenu, beautiful.awesome_icon },
	{ "open terminal", terminal }, }
    })

mylauncher = awful.widget.launcher({ image = image(beautiful.awesome_icon),
                                     menu = mymainmenu })
-- }}}

-- {{{ Wibox
-- Create a textclock widget
mytextclock = awful.widget.textclock({ align = "right" }, " %a %d %b  %H:%M ")

-- Create a systray
mysystray = widget({ type = "systray" })

-- Icons
myspacer         = widget({ type = "textbox", name = "myspacer" })
myseparator      = widget({ type = "textbox", name = "myseparator" })

myspacer.text    = " "
myseparator.text = "|"

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}

-- Tag list
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
    awful.button({ }, 1, awful.tag.viewonly),
    awful.button({ modkey }, 1, awful.client.movetotag),
    awful.button({ }, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, awful.client.toggletag),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
    )

shifty.taglist = mytaglist

-- mytasklist = {}
-- mytasklist.buttons = awful.util.table.join(
--     awful.button({ }, 1,
--         function (c)
--             if not c:isvisible() then
--                 awful.tag.viewonly(c:tags()[1])
--             end
--             client.focus = c
--             c:raise()
--         end),
--     awful.button({ }, 3,
--         function ()
--             if instance then
--                 instance:hide()
--                 instance = nil
--             else
--                 instance = awful.menu.clients({ width=250 })
--             end
--         end),
--     awful.button({ }, 4,
--         function ()
--             awful.client.focus.byidx(1)
--             if client.focus then client.focus:raise() end
--         end),
--     awful.button({ }, 5,
--         function ()
--             awful.client.focus.byidx(-1)
--             if client.focus then client.focus:raise() end
--         end)
--     )

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
        awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
        awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
        awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
        awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end))
        )
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)

    -- Create a tasklist widget
    -- mytasklist[s] = awful.widget.tasklist(
    --     function(c)
    --         return awful.widget.tasklist.label.currenttags(c, s)
    --     end, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s })
    -- Add widgets to the wibox - order matters
    mywibox[s].widgets = {
        {
            mylauncher,
            mytaglist[s],
            mypromptbox[s],
            layout = awful.widget.layout.horizontal.leftright
        },
        mylayoutbox[s],
        mytextclock,
        s == 1 and mysystray or nil,
        myspacer,
        widgets.fs.widget(), widgets.fs.icon(),
        myspacer,
        widgets.net.icon_up(), widgets.net.widget(), widgets.net.icon_down(),
        myspacer,
        widgets.mem.widget(), widgets.mem.icon(),
        myspacer,
        widgets.cpu.widget(), widgets.cpu.icon(),
        spacer,
        widgets.mpd.widget(), widgets.mpd.icon(),
        -- spacer,
        -- mytasklist[s],
        layout = awful.widget.layout.horizontal.rightleft
    }
end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
cfg.keys.modkey = modkey
cfg.keys.terminal = terminal
cfg.keys.editor = editor
cfg.keys.promptbox = mypromptbox
cfg.keys.init()

globalkeys = cfg.keys.globalkeys()
root.keys(globalkeys)
shifty.config.globalkeys = globalkeys
shifty.config.clientkeys = cfg.keys.clientkeys()
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.add_signal("manage", function (c, startup)
    -- Add a titlebar
    awful.titlebar.add(c, { modkey = modkey })

    -- Enable sloppy focus
    c:add_signal("mouse::enter",
        function(c)
            if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
                and awful.client.focus.filter(c) then
                client.focus = c
            end
        end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end
end)

client.add_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

-- Runs programs
-- utils.process.run_once("/usr/lib/gnome-settings-daemon/gnome-settings-daemon")
-- utils.process.run_once("gnome-keyring-daemon")
-- utils.process.run_once("gnome-volume-control-applet")
-- utils.process.run_once("gnome-power-manager")
-- utils.process.run_once("gnome-screensaver")
-- utils.process.run_once("update-notifier")
utils.process.run_once("parcellite")
utils.process.run_once("dropboxd")
utils.process.run_once("xcompmgr -cF")

-- Configures screen
if config.hostname == "thor" then
	utils.process.run("xrandr --output DVI-0 --auto --output DVI-1 --auto --right-of DVI-0")
else
	utils.process.run_once("nm-applet")
end

-- Reinitializes wallapper replaced by gnome-settings-daemon
-- awful.util.spawn("awsetbg -f " .. themes .. themename .. "/background.jpg")
