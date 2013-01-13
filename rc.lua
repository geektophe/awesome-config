-- {{{ Includes
-- Sets locale
os.setlocale("fr_FR.UTF-8")

-- Standard awesome library
require("awful")
require("awful.autofocus")
-- require("awful.rules")
-- Theme handling library
require("beautiful")
-- Revelation library
require("revelation")

-- Loads Shifty automatic tags management library
require('shifty')

-- Loads utils libraries
require("utils.client")
require("utils.mpd")
require("utils.process")
require("utils.pulseaudio")
require("utils.rc")
require("utils.system")
require("utils.tag")

-- Loads widgets libraries
require("widgets.bat")
require("widgets.clock")
require("widgets.cpu")
require("widgets.fs")
require("widgets.mem")
require("widgets.net")
require("widgets.mpd")
require("widgets.spacer")
require("widgets.task")
require("widgets.volume")
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
utils.rc.loadrc('menu')
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
