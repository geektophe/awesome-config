-- Applies theme

-- Initialize theme manager
beautiful.init(themes .. themename .. "/theme.lua")

-- Sets wallpapers
for s = 1, screen.count() do
    gears.wallpaper.maximized(beautiful.wallpaper, s, true)
end

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
