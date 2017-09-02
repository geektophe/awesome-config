-- Create a wibox for each screen and add it
wide = utils.screen.width() > 1280

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    -- set_wallpaper(s)

    -- Creates tags
    tag_names = {}
    tag_layouts = {}

    for i, settings in ipairs(tags_settings) do
        if not settings.screen or (settings.screen and settings.screen == s.index) then
            tag_names[i] = settings.name
            tag_layouts[i] = settings.layout
        end
    end

    tags = awful.tag(tag_names, s, tag_layouts)

    -- Applies tags settings
    for name, settings in pairs(tags_settings) do
        tag = tags[settings.position]

        if tag and settings.mwfact then
            awful.tag.setmwfact(settings.mwfact, tag)
        end
    end

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(layoutbox_buttons)

    -- Create a taglist widget
    s.taglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, taglist_buttons)

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s })
    -- Add widgets to the wibox - order matters
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(mylauncher)
    left_layout:add(s.taglist)
    left_layout:add(s.mypromptbox)

    -- Widgets that are aligned to the left
    local right_layout = wibox.layout.fixed.horizontal()
    right_layout:add(widgets.mode.widget())
    right_layout:add(widgets.spacer.widget())
    right_layout:add(widgets.gmail.icon())
    right_layout:add(widgets.gmail.widget())
    right_layout:add(widgets.spacer.widget())
    right_layout:add(widgets.im.icon())
    right_layout:add(widgets.im.widget())
    right_layout:add(widgets.spacer.widget())
    right_layout:add(widgets.volume.widget(utils.pulseaudio))
    right_layout:add(widgets.spacer.widget())
    right_layout:add(widgets.cpu.widget(wide))
    right_layout:add(widgets.spacer.widget())
    right_layout:add(widgets.mem.widget(wide))
    right_layout:add(widgets.spacer.widget())
    right_layout:add(widgets.fs.widget(wide))
    right_layout:add(widgets.spacer.widget())

    if utils.system.hasbattery() then
        right_layout:add(widgets.bat.widget(wide))
        right_layout:add(widgets.spacer.widget())
    end
    if s.index == 1 then right_layout:add(wibox.widget.systray()) end
    -- right_layout:add(widgets.calendar.widget())
    right_layout:add(widgets.clock.widget())
    right_layout:add(widgets.spacer.widget())
    right_layout:add(s.mylayoutbox)

    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_right(right_layout)

    s.mywibox:set_widget(layout)
end)

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
