--{{{ Main
require("awful.util")
require("utils.system")
require("utils.process")


theme = {}

home          = os.getenv("HOME")
config        = awful.util.getdir("config")
shared        = "/usr/share/awesome"

if not awful.util.file_readable(shared .. "/icons/awesome16.png") then
    shared    = "/usr/share/local/awesome"
end

sharedicons   = shared .. "/icons"
sharedthemes  = shared .. "/themes"
themes        = config .. "/themes"
themename     = "/gits"
themedir      = themes .. themename

-- resolution = utils.process.cmd_output("xrandr -q|grep '^Screen 0'|awk -F, '{print $2}'|awk '{print $2$3$4}'")
-- print ("resolution: " .. resolution)

-- if awful.util.file_readable(themedir .. "/background_" .. resolution ..  ".jpg") then
--     wallpaper = themedir .. "/background_" .. resolution ..  ".jpg"
-- else
--     wallpaper    = themedir .. "/background_default.jpg"
-- end

wallpaper    = themedir .. "/background_default.jpg"
theme.wallpaper_cmd = "awsetbg -a " .. wallpaper

if awful.util.file_readable(config .. "/vain/init.lua") then
    theme.useless_gap_width  = "3"
end
--}}}

-- {{{ Styles
theme.font      = "sans 8"

-- {{{ Colors
theme.fg_normal = "#ffffff"
theme.bg_normal = "#405156aa"
theme.fg_focus  = "#ffffff"
theme.bg_focus  = "#137112aa"
theme.fg_urgent = "#929392"
theme.bg_urgent = "#34353488"
-- }}}

-- {{{ Borders
theme.border_width  = "1"
theme.border_normal = "#777777"
theme.border_focus  = "#ffffff"
theme.border_marked = "#ffffff"
-- }}}

-- {{{ Titlebars
theme.titlebar_bg_focus  = "#FF6B0175"
theme.titlebar_bg_normal = "#00000075"
-- }}}

-- {{{ Titlebars

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- Example:
--theme.taglist_bg_focus = "#CC9393"
-- }}}

-- {{{ Widgets
-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
theme.fg_widget        = "#AECF96"
theme.fg_center_widget = "#88A175"
theme.fg_end_widget    = "#FF5656"
theme.bg_widget        = "#494B4F"
theme.border_widget    = "#3F3F3F"
-- }}}

-- {{{ Mouse finder
theme.mouse_finder_color = "#CC9393"
-- mouse_finder_[timeout|animate_timeout|radius|factor]
-- }}}

-- {{{ Menu
-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]

theme.menu_bg_normal = "#00000075"
theme.menu_bg_focus = "#FF6B0175"
theme.menu_border_width = "0"
theme.menu_height = "15"
theme.menu_width  = "130"
-- }}}

-- {{{ Icons
-- {{{ Taglist
theme.taglist_squares_sel   = sharedthemes .. "/zenburn/taglist/squarefz.png"
theme.taglist_squares_unsel = sharedthemes .. "/zenburn/taglist/squarez.png"
--theme.taglist_squares_resize = "false"
-- }}}

-- {{{ Misc
theme.awesome_icon           = themedir .. "/awesome-icon.png"
theme.menu_submenu_icon      = sharedthemes .. "/default/submenu.png"
theme.tasklist_floating_icon = sharedthemes .. "/default/tasklist/floatingw.png"
-- }}}

-- {{{ Layout
theme.layout_tile       = themedir .. "/layouts/tile.png"
theme.layout_tileleft   = themedir .. "/layouts/tileleft.png"
theme.layout_tilebottom = themedir .. "/layouts/tilebottom.png"
theme.layout_tiletop    = themedir .. "/layouts/tiletop.png"
theme.layout_fairv      = themedir .. "/layouts/fairv.png"
theme.layout_fairh      = themedir .. "/layouts/fairh.png"
theme.layout_spiral     = themedir .. "/layouts/spiral.png"
theme.layout_dwindle    = themedir .. "/layouts/dwindle.png"
theme.layout_max        = themedir .. "/layouts/max.png"
theme.layout_fullscreen = themedir .. "/layouts/fullscreen.png"
theme.layout_magnifier  = themedir .. "/layouts/magnifier.png"
theme.layout_floating   = themedir .. "/layouts/floating.png"
-- }}}

-- {{{ Titlebar
theme.titlebar_close_button_focus  = sharedthemes .. "/zenburn/titlebar/close_focus.png"
theme.titlebar_close_button_normal = sharedthemes .. "/zenburn/titlebar/close_normal.png"

theme.titlebar_ontop_button_focus_active  = sharedthemes .. "/zenburn/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active = sharedthemes .. "/zenburn/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive  = sharedthemes .. "/zenburn/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive = sharedthemes .. "/zenburn/titlebar/ontop_normal_inactive.png"

theme.titlebar_sticky_button_focus_active  = sharedthemes .. "/zenburn/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active = sharedthemes .. "/zenburn/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive  = sharedthemes .. "/zenburn/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive = sharedthemes .. "/zenburn/titlebar/sticky_normal_inactive.png"

theme.titlebar_floating_button_focus_active  = sharedthemes .. "/zenburn/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active = sharedthemes .. "/zenburn/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive  = sharedthemes .. "/zenburn/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive = sharedthemes .. "/zenburn/titlebar/floating_normal_inactive.png"

theme.titlebar_maximized_button_focus_active  = sharedthemes .. "/zenburn/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active = sharedthemes .. "/zenburn/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = sharedthemes .. "/zenburn/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = sharedthemes .. "/zenburn/titlebar/maximized_normal_inactive.png"
-- }}}
-- }}}

-- {{{ Widgets icons
theme.widget_cpu       = themedir.."/icons/cpu.png"
theme.widget_netup     = themedir.."/icons/up.png"
theme.widget_fs        = themedir.."/icons/disk.png"
theme.widget_vol       = themedir.."/icons/vol.png"
theme.widget_date      = themedir.."/icons/time.png"
theme.widget_music     = themedir.."/icons/music.png"
theme.widget_mem       = themedir.."/icons/mem.png"
theme.widget_net       = themedir.."/icons/down.png"
theme.widget_disk      = themedir.."/icons/disk.png"
theme.widget_mpd_play  = themedir.."/icons/mpd_play.png"
theme.widget_mpd_pause = themedir.."/icons/mpd_pause.png"
theme.widget_mpd_stop  = themedir.."/icons/mpd_stop.png"
-- }}}

return theme

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
