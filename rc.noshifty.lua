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

-- Load Debian menu entries
require("debian.menu")

-- Loads Shifty automatic tags management library
-- require('shifty')

-- Loads Teardrop automatic tags management library
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
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
-- beautiful.init("/usr/share/awesome/themes/default/theme.lua")
config = awful.util.getdir("config")
themes = config .. "/themes/"
themename     = "wombat"
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

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {
	settings = {
    	{ names = {"1:web", "2:mail", "3:term", "4:dev", "5:notag", "6:fs", "7:im"} ,
    	  layout = {layouts[4], layouts[4], layouts[2], layouts[2], layouts[2], layouts[2], layouts[2]},
		},
    	{ names = {"1:web", "3:term", "3:im"} ,
    	  layout = {layouts[4], layouts[2], layouts[2]},
		},
	}
}
for s = 1, screen.count() do
    -- tags[s] = awful.tag(tags.names, s, tags.layout)
	tags[s] = awful.tag(tags.settings[s].names, s, tags.settings[s].layout)
end
-- }}}

-- {{{ Shifty settings
-- shifty.config.tags = {
--   ["1:sys"] = { init = true, position = 1, mwfact = 0.60               },
--   ["2:www"] = { init = true, position = 2, exclusive = true,           },
--   ["3:dev"] = { init = true, position = 3,                             },
--  ["4:term"] = { init = true, position = 4,                             },
--    ["5:fs"] = { init = true, position = 5,                             },
--  ["6:news"] = { init = true, position = 6,                             },
--  ["7:mus"]  = {              position = 7,                             },
--     ["p2p"] = { icon = "/usr/share/pixmaps/p2p.png", icon_only = true, },
-- }
--
-- shifty.config.apps = {
--     {
--         match = { "Dialog", "dialog", "Download" },
--         float = true,
--         honorsizehints = true,
--     },
--     {
--         match = { "Synaptic", "Update-manager" },
--         tag = "1:sys",
--     },
--     {
--         match = { "Iceweasel.*", "Firefox.*" },
--         tag = "2:www",
--     },
--     {
--         match = { "Npviewer.bin" },
--         tag = "2:www",
--         float = true,
--         honorsizehints = true
--     },
--     {
--         match = { "Gvim" },
--         tag = "3:dev",
--     },
--     {
--         match = { "XTerm" },
--         tag = "4:term",
--     },
--     {
--         match = { "Transmission" },
--         tag = { "2:www", "p2p" },
--     },
--     {
--         match = { "Nautilus", "File-roller", "Baobab" },
--         tag = "5:fs",
--     },
--     {
--         match = { "Liferea" },
--         tag = "6:news",
--     },
--     {
--         match = { "Sonata" },
--         tag = "7:mus",
--     },
--     {
--         match = { "gcolor2", "xmag" },
--         intrusive = true,
--     },
--     {
--         match = { "gcolor2" },
--         geometry = { 100,100,nil,nil },
--     },
--     {
--         match = {"recordMyDesktop", "MPlayer", "xmag", },
--         float = true,
--     },
--     {
--         match = { "" },
--         buttons = {
--             button({ }, 1, function (c) client.focus = c; c:raise() end),
--             button({ modkey }, 1, function (c) awful.mouse.client.move() end),
--             button({ modkey }, 3, function (c) awful.mouse.client.resize() end), },
--     },
-- }
--
-- shifty.config.defaults = {
--     run = function(tag) naughty.notify({ text = tag.name }) end,
--     layout = awful.layout.suit.tile,
--     ncol = 1,
--     mwfact = 0.50,
--     floatBars=true,
-- }
--
-- shifty.init()
-- }}}


-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua" },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "Debian", debian.menu.Debian_menu.Debian },
                                    { "open terminal", terminal }
                                  }
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
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, awful.tag.viewnext),
                    awful.button({ }, 5, awful.tag.viewprev)
                    )
-- shifty.taglist = mytaglist
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if not c:isvisible() then
                                                  awful.tag.viewonly(c:tags()[1])
                                              end
                                              client.focus = c
                                              c:raise()
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

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
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(function(c)
                                              return awful.widget.tasklist.label.currenttags(c, s)
                                          end, mytasklist.buttons)

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
        widgets.cpu.widget(), widgets.cpu.icon(),
        myspacer,
        widgets.mem.widget(), widgets.mem.icon(),
        spacer,
        widgets.mpd.widget(), widgets.mpd.icon(),
        spacer,
        mytasklist[s],
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
globalkeys = awful.util.table.join(
    awful.key({ modkey, }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey, }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey, }, "Escape", awful.tag.history.restore),

	-- Tab
    awful.key({ modkey, }, "Tab",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey, "Shift" }, "Tab",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),


	-- Remapped H
    awful.key({ modkey,           }, "c", function () awful.tag.incmwfact(-0.05) end),
    awful.key({ modkey, "Shift"   }, "c", function () awful.tag.incnmaster(1) end),
    awful.key({ modkey, "Control" }, "c", function () awful.tag.incncol(1) end),


	-- Remapped J
    awful.key({ modkey, }, "t",
        function ()
            awful.client.focus.byidx(1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey, "Shift"   }, "t", function () awful.client.swap.byidx(1) end),
    awful.key({ modkey, "Control" }, "t", function () awful.screen.focus_relative(1) end),


	-- Remapped K
    awful.key({ modkey, }, "s",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey, "Shift"   }, "s", function () awful.client.swap.byidx( -1) end),
    awful.key({ modkey, "Control" }, "s", function () awful.screen.focus_relative(-1) end),


	-- Remapped L
    awful.key({ modkey,           }, "r",     function () awful.tag.incmwfact(0.05) end),
    awful.key({ modkey, "Shift"   }, "r",     function () awful.tag.incnmaster(-1) end),
    awful.key({ modkey, "Control" }, "r",     function () awful.tag.incncol(-1) end),


    awful.key({ modkey,           }, "g", awful.client.urgent.jumpto),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),
    awful.key({ modkey,           }, "o",     function () awful.util.spawn("gnome-screensaver-command --lock") end),
    awful.key({ modkey,           }, "e",     revelation),
    awful.key({ modkey,           }, "i",     utils.client.info),

    -- Prompt
    awful.key({ modkey },            "l",     function () mypromptbox[mouse.screen]:run() end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
    awful.key({ modkey,           }, "n",      function (c) c.minimized = not c.minimized    end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        if tags[screen][i] then
                            awful.tag.viewonly(tags[screen][i])
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      if tags[screen][i] then
                          awful.tag.viewtoggle(tags[screen][i])
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.movetotag(tags[client.focus.screen][i])
                      end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
                      end
                  end))
end

-- Shifty
-- for i=1,9 do
--
--     globalkeys = awful.util.table.join(globalkeys, awful.key({ modkey }, "#" .. i + 9,
--         function ()
--             local t = awful.tag.viewonly(shifty.getpos(i))
--         end))
--     globalkeys = awful.util.table.join(globalkeys, awful.key({ modkey, "Control" }, "#" .. i + 9,
--         function ()
--             local t = shifty.getpos(i)
--             t.selected = not t.selected
--         end))
--     globalkeys = awful.util.table.join(globalkeys, awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
--         function ()
--             if client.focus then
--                 awful.client.toggletag(shifty.getpos(i))
--             end
--          end))
--     -- déplace les clients vers d’autres onglets
--     globalkeys = awful.util.table.join(globalkeys, awful.key({ modkey, "Shift" }, "#" .. i + 9,
--         function ()
--             if client.focus then
--                 local t = shifty.getpos(i)
--                awful.client.movetotag(t)
--                awful.tag.viewonly(t)
--             end
--         end))
-- end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- shifty.config.globalkeys = globalkeys
-- shifty.config.clientkeys = clientkeys
-- }}}

--{{{ Rules
-- See http://awesome.naquadah.org/doc/api/modules/awful.rules.html
awful.rules.rules = {
    -- All clients will match this rule.
    { rule       = { },
      callback   = awful.placement.centered,
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     floatBars = true,
                     tag = tags[1][5],
                     switchtotag = true,
				     floating = false} },

    -- Gimp
    { rule       = { class = "gimp" },
      properties = { floating = true } },

    { rule       = { class = "Firefox" },
      properties = { tag = tags[1][1]} },

    { rule       = { class = "Transmission" },
      properties = { tag = tags[1][1] } },

	-- Thunderbird
    { rule       = { class = "Thunderbird" },
      properties = { tag = tags[1][2]} },

    -- Xterm
    { rule       = { class = "XTerm" },
      properties = { opacity = 0.7, tag = tags[1][3]} },

    -- Gvim
    { rule       = { class = "Gvim" },
      properties = { opacity = 0.8, tag = tags[1][4]} },

    -- Nautilus
    { rule       = { class = "Nautilus" },
      properties = { tag = tags[1][6], opacity = 0.8 } },

    -- Baobab
    { rule       = { class = "Baobab" },
      properties = { tag = tags[1][6]} },

    -- File Roller
    { rule       = { class = "File-roller" },
      properties = { tag = tags[1][6], opacity = 0.8 } },

    -- Dialog windows
    { rule         = { type = "dialog" },
      properties   = { floating = true, size_hints_honor = true } },

    -- Empathy
    { rule       = { class = "Empathy" },
      properties = { tag = tags[1][7], opacity = 0.8 } },

    { rule       = { class = "Empathy", role = "contact_list" },
	  callback   = awful.client.setslave },
}
--}}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.add_signal("manage", function (c, startup)
    -- Add a titlebar
    -- awful.titlebar.add(c, { modkey = modkey })

    -- Enable sloppy focus
    c:add_signal("mouse::enter", function(c)
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
utils.process.run_once("/usr/lib/gnome-settings-daemon/gnome-settings-daemon")
utils.process.run_once("gnome-keyring-daemon")
-- utils.process.run_once("gnome-volume-control-applet")
-- utils.process.run_once("gnome-power-manager")
utils.process.run_once("gnome-screensaver")
-- utils.process.run_once("nm-applet")
-- utils.process.run_once("update-notifier")
utils.process.run_once("parcellite")
-- Reinitializes wallapper replaced by gnome-settings-daemon
awful.util.spawn("awsetbg -f " .. themes .. themename .. "/background.jpg")
