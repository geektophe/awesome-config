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

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
