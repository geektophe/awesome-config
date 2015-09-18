-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
wide = utils.screen.width() > 1280

taglist = {}
taglist.buttons = taglist_buttons

if tags_type == "shifty" then
    shifty.taglist = taglist
end

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(layoutbox_buttons)

    -- Create a taglist widget
    taglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, taglist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s })
    -- Add widgets to the wibox - order matters
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(mylauncher)
    left_layout:add(taglist[s])
    left_layout:add(mypromptbox[s])

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
    right_layout:add(widgets.volume.icon())
    right_layout:add(widgets.volume.widget())
    right_layout:add(widgets.spacer.widget())
    right_layout:add(widgets.cpu.icon(wide))
    right_layout:add(widgets.cpu.core1widget(wide))
    right_layout:add(widgets.cpu.core2widget(wide))
    right_layout:add(widgets.cpu.loadwidget(wide))
    right_layout:add(widgets.spacer.widget())
    right_layout:add(widgets.mem.icon())
    right_layout:add(widgets.mem.widget(wide))
    right_layout:add(widgets.spacer.widget())
    right_layout:add(widgets.fs.icon())
    right_layout:add(widgets.fs.widget(wide))
    right_layout:add(widgets.spacer.widget())

    if utils.system.hasbattery() then
        right_layout:add(widgets.bat.icon())
        right_layout:add(widgets.bat.widget(wide))
        right_layout:add(widgets.spacer.widget())
    end
    if s == 1 then right_layout:add(wibox.widget.systray()) end
    -- right_layout:add(widgets.calendar.widget())
    right_layout:add(widgets.clock.widget())
    right_layout:add(widgets.spacer.widget())
    right_layout:add(mylayoutbox[s])

    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_right(right_layout)

    mywibox[s]:set_widget(layout)
end

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
