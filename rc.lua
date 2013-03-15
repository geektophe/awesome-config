-- {{{ Includes
-- Sets locale
os.setlocale("fr_FR.UTF-8")

-- Standard awesome library
awful = require("awful")
awful.autofocus = require("awful.autofocus")
naughty = require("naughty")
oocairo = require("oocairo")
wibox = require("wibox")
-- require("awful.rules")
-- Theme handling library
beautiful = require("beautiful")
-- Revelation library
revelation = require("revelation")

-- Loads Shifty automatic tags management library
shifty = require("shifty")

-- Loads utils libraries
utils = {}
utils.client = require("utils.client")
utils.client = require("utils.mpd")
utils.process = require("utils.process")
utils.pulseaudio = require("utils.pulseaudio")
utils.rc = require("utils.rc")
utils.screen = require("utils.screen")
utils.system = require("utils.system")
utils.tag = require("utils.tag")

-- Loads widgets libraries
widgets = {}
widgets.bat = require("widgets.bat")
widgets.clock = require("widgets.clock")
widgets.cpu = require("widgets.cpu")
widgets.fs = require("widgets.fs")
widgets.mem = require("widgets.mem")
widgets.net = require("widgets.net")
-- widgets.mpd = require("widgets.mpd")
widgets.spacer = require("widgets.spacer")
widgets.task = require("widgets.task")
widgets.volume = require("widgets.volume")
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
-- beautiful.init("/usr/share/awesome/themes/default/theme.lua")
confdir = awful.util.getdir("config")
themes = confdir .. "/themes/"
themename = "gits"
beautiful.init(themes .. themename .. "/theme.lua")

-- This is used later as the default terminal and editor to run.
-- terminal = "x-terminal-emulator"
terminal = "gnome-terminal"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor

-- Lock screen command
xlock = "xscreensaver-command -lock"

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Modules variables
utils.client.unfocus_opacity_incr = 0.3
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
utils.rc.loadrc('tags.shifty')
-- }}}

-- {{{ Menu
-- utils.rc.loadrc('menu')
-- }}}

-- {{{ Wibox
utils.rc.loadrc('wibox')
-- }}}

-- {{{ Shifty initialization
shifty.init()
-- }}}

-- {{{ Key bindings
utils.rc.loadrc('keys')
-- }}}

-- {{{ Signals
utils.rc.loadrc('signal')
-- }}}

-- {{{ Programs to run at startup
-- Disabled, managed by Xsession
-- utils.rc.loadrc('startup')
-- }}}

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
