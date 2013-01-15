-- Create a systray
systray = widget({ type = "systray" })

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
wide = utils.screen.width() > 1280

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
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
    shifty.taglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, shifty.taglist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s })
    -- Add widgets to the wibox - order matters
    mywibox[s].widgets = {
        {
            mylauncher,
            shifty.taglist[s],
            mypromptbox[s],
            layout = awful.widget.layout.horizontal.leftright
        },
        mylayoutbox[s],
        widgets.clock.widget(),
        s == 1 and systray or nil,
        widgets.spacer.widget(),
        widgets.net.widget(),
        utils.system.hasbattery() and widgets.spacer.widget() or nil,
        utils.system.hasbattery() and widgets.bat.widget(wide) or nil,
        widgets.spacer.widget(),
        widgets.fs.widget(wide),
        widgets.spacer.widget(),
        widgets.mem.widget(wide),
        widgets.spacer.widget(),
        widgets.cpu.widget(wide),
        widgets.spacer.widget(),
        widgets.volume.widget(),
        widgets.spacer.widget(),
        -- widgets.task.widget(),
        layout = awful.widget.layout.horizontal.rightleft
    }
end

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
