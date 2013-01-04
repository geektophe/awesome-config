utils.process.run_once("xcompmgr -cF")
utils.process.run_once("/usr/lib/gnome-settings-daemon/gnome-settings-daemon")
utils.process.run_once("gnome-keyring-daemon")
utils.process.run_once("gnome-sound-applet")
-- utils.process.run_once("gnome-power-manager")
-- utils.process.run_once("gnome-screensaver")
-- utils.process.run_once("update-notifier")
utils.process.run_once("parcellite")
utils.process.run_once("dropboxd")

-- Reinitializes wallapper replaced by gnome-settings-daemon
-- awful.util.spawn(beautiful.wallpaper_cmd)

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
