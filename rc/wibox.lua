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
    mylayoutbox[s]:buttons(layoutbox_buttons)

    -- Create a taglist widget
    taglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, taglist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s })
    -- Add widgets to the wibox - order matters
    mywibox[s].widgets = {
        {
            mylauncher,
            taglist[s],
            mypromptbox[s],
            layout = awful.widget.layout.horizontal.leftright
        },
        mylayoutbox[s],
        widgets.clock.widget(),
        s == 1 and widget({ type = "systray" }) or nil,
        -- widgets.net.widget(),
        utils.system.hasbattery() and widgets.spacer.widget() or nil,
        utils.system.hasbattery() and widgets.bat.widget(wide) or nil,
        utils.system.hasbattery() and widgets.bat.icon() or nil,
        widgets.spacer.widget(),
        widgets.fs.widget(wide),
        widgets.fs.icon(),
        widgets.spacer.widget(),
        widgets.mem.widget(wide),
        widgets.mem.icon(wide),
        widgets.spacer.widget(),
        widgets.cpu.loadwidget(wide),
        widgets.cpu.core1widget(wide),
        widgets.cpu.core2widget(wide),
        widgets.cpu.icon(wide),
        widgets.spacer.widget(),
        widgets.volume.widget(),
        widgets.volume.icon(),
        widgets.spacer.widget(),
        widgets.gmail.widget(),
        widgets.gmail.icon(),
        widgets.spacer.widget(),
        widgets.im.widget(),
        widgets.im.icon(),
        widgets.spacer.widget(),
        widgets.livestatus.widget(),
        widgets.livestatus.icon(),
        layout = awful.widget.layout.horizontal.rightleft
    }
end

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
