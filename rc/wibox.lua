-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
wide = utils.screen.width() > 1280

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
        awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
        awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
        awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
        awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end))
        )
    -- Create a taglist widget
    shifty.taglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, shifty.taglist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s })
    -- Add widgets to the wibox - order matters
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(shifty.taglist[s])
    left_layout:add(mypromptbox[s])

    -- Widgets that are aligned to the left
    local right_layout = wibox.layout.fixed.horizontal()
    right_layout:add(mylayoutbox[s])
    right_layout:add(widgets.clock.widget())
    if s == 1 then right_layout:add(wibox.widget.systray()) end
    right_layout:add(widgets.spacer.widget())
    -- right_layout:add(widgets.net.widget())
    if utils.system.hasbattery() then right_layout:add(widgets.spacer.widget()) end
    if utils.system.hasbattery() then right_layout:add(widgets.bat.widget(wide)) end
    right_layout:add(widgets.spacer.widget())
    right_layout:add(widgets.fs.widget(wide))
    right_layout:add(widgets.spacer.widget())
    right_layout:add(widgets.mem.widget(wide))
    right_layout:add(widgets.spacer.widget())
    right_layout:add(widgets.cpu.widget(wide))
    right_layout:add(widgets.spacer.widget())
    right_layout:add(widgets.volume.widget())
    right_layout:add(widgets.spacer.widget())

    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_right(right_layout)

    mywibox[s]:set_widget(layout)
end

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
