utils.process.run_once("/usr/bin/xcompmgr -cF")
utils.process.run_once("/usr/bin/urxvtd -o -f -q ")
utils.process.run_once("/usr/lib/gnome-settings-daemon/gnome-settings-daemon")
utils.process.run_once("/usr/bin/gnome-keyring-daemon")
utils.process.run_once("/usr/bin/gnome-sound-applet")
utils.process.run_once("/usr/bin/parcellite")
utils.process.run_once("/usr/bin/dropboxd")
utils.process.run_once("/usr/bin/xscreensaver -no-splash")
utils.process.run_once("/usr/bin/ssh-agent")
utils.process.run_once("/usr/bin/nm-applet")

-- utils.process.run_once("gnome-power-manager")
-- utils.process.run_once("gnome-screensaver")
-- utils.process.run_once("update-notifier")

-- Reinitializes wallapper replaced by gnome-settings-daemon
awful.util.spawn(beautiful.wallpaper_cmd[0])

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
