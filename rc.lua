-- {{{ Includes
-- Sets locale
package.path = string.gsub(package.path, ".config/awesome", ".config/awesome42")
print(package.path)
os.setlocale("fr_FR.UTF-8")

-- Standard awesome library
awful = require("awful")
awful.rules = require("awful.rules")
awful.autofocus = require("awful.autofocus")
naughty = require("naughty")
wibox = require("wibox")
-- Theme handling library
beautiful = require("beautiful")
gears = require("gears")
-- Revelation library
--revelation = require("revelation")
-- Eminent library
--eminent = require("eminent")

-- Loads utils libraries
utils = {}
utils.client = require("utils.client")
utils.process = require("utils.process")
utils.pulseaudio = require("utils.pulseaudio")
utils.rc = require("utils.rc")
utils.screen = require("utils.screen")
utils.system = require("utils.system")
utils.tag = require("utils.tag")
utils.tag = require("utils.mode")

-- Loads widgets libraries
widgets = {}
widgets.bat = require("widgets.bat")
widgets.clock = require("widgets.clock")
widgets.cpu = require("widgets.cpu")
widgets.fs = require("widgets.fs")
widgets.mem = require("widgets.mem")
-- widgets.net = require("widgets.net")
widgets.spacer = require("widgets.spacer")
widgets.volume = require("widgets.volume")
widgets.im = require("widgets.im")
widgets.gmail = require("widgets.gmail")
widgets.mode = require("widgets.mode")
-- widgets.calendar = require("widgets.calendar")
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
-- beautiful.init("/usr/share/awesome/themes/default/theme.lua")
confdir = awful.util.getdir("config")
themes = confdir .. "/themes/"
themename = "gits"

-- This is used later as the default terminal and editor to run.
-- terminal = "x-terminal-emulator"
terminal = "urxvt"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor

-- Lock screen command
xlock = string.format("%s/.config/awesome/bin/xlock", os.getenv("HOME"))

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

-- {{{ Theme
utils.rc.loadrc('theme')
-- }}}

-- {{{ Signals
utils.rc.loadrc('signal')
-- }}}

-- {{{ Buttons
utils.rc.loadrc('buttons')
-- }}}

-- {{{ Key bindings
utils.rc.loadrc('keys')
-- }}}

-- {{{ Shifty settings
utils.rc.loadrc('tags')
-- }}}

-- {{{ Key bindings extension (depends on tags definition)
utils.rc.loadrc('keys.awful')
-- }}}
--
-- {{{ Menu
utils.rc.loadrc('menu')
-- }}}

-- {{{ Naughty
utils.rc.loadrc('naughty')
-- }}}

-- {{{ IM related stuff
utils.rc.loadrc('im')
-- }}}

-- {{{ Wibox
utils.rc.loadrc('wibox')
-- }}}

-- {{{ Programs to run at startup
-- Disabled, managed by Xsession
-- utils.rc.loadrc('startup')
-- }}}

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
