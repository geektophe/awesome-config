layoutbox_buttons = awful.util.table.join(
        awful.button({ }, 1, function () awful.layout.inc(layouts,  1) end),
        awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
        awful.button({ }, 4, function () awful.layout.inc(layouts,  1) end),
        awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)
)


taglist_buttons = awful.util.table.join(
    awful.button({ },           1, function(t) t:view_only() end),
    awful.button({ modkey    }, 1, function(t)
                                       if client.focus then
                                           client.focus:move_to_tag(t)
                                       end
                                   end),
    awful.button({ "Shift"   }, 1, awful.tag.viewtoggle),
    awful.button({ "Control" }, 1, function(t)
                                       if client.focus then
                                           client.focus:toggle_tag(t)
                                       end
                                   end),
    awful.button({ },           3, utils.client.markedtotag),
    awful.button({ },           4, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({ },           5, function(t) awful.tag.viewprev(t.screen) end)
)


client_buttons = awful.util.table.join(
    awful.button({},                1, function(c) client.focus = c; c:raise() end),
    awful.button({modkey},          1, function(c)
            client.focus = c
            c:raise()
            awful.mouse.client.move(c)
        end),
    awful.button({modkey, "Shift"}, 1, utils.client.togglemarked),
    awful.button({modkey, "Mod1"},  1, utils.client.opacity_lock_toggle),
    awful.button({modkey},          3, awful.mouse.client.resize)
)

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
