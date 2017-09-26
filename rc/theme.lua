-- Applies theme

-- Initialize theme manager
beautiful.init(themes .. themename .. "/theme.lua")

-- Sets wallpapers
function set_wallpaper(s)
    -- Wallpaper
    print("wallpaper: " .. beautiful.wallpaper)
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)


-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
