-- Naughty configuration

naughty.config.presets.normal.opacity   = 1
naughty.config.presets.low.opacity      = 1
naughty.config.presets.critical.opacity = 1
naughty.config.presets.normal.bg   = string.sub(beautiful.bg_normal, 0, 7)
naughty.config.presets.low.bg      = string.sub(beautiful.bg_normal, 0, 7)
naughty.config.presets.critical.bg = string.sub(beautiful.bg_normal, 0, 7)

naughty.config.defaults.timeout = 30
naughty.config.defaults.margin  = 4
naughty.config.defaults.gap     = 1
naughty.config.defaults.opacity = 1
naughty.config.defaults.bg = string.sub(beautiful.bg_normal, 0, 7)
naughty.config.icon_dirs = { os.getenv("HOME") .. "/.config/awesome/icons/im/",  "/usr/share/pixmaps/" }

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
