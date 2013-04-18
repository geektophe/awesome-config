layoutbox_buttons = awful.util.table.join(
        awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
        awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
        awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
        awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end))


taglist_buttons = awful.util.table.join(
    awful.button({ },           1, awful.tag.viewonly),
    awful.button({ modkey    }, 1, awful.client.movetotag),
    awful.button({ "Shift"   }, 1, awful.tag.viewtoggle),
    awful.button({ "Control" }, 1, awful.client.toggletag),
    awful.button({ },           3, utils.client.markedtotag),
    awful.button({ },           4, awful.tag.viewnext),
    awful.button({ },           5, awful.tag.viewprev))


client_buttons = awful.util.table.join(
    awful.button({},                1, function(c) client.focus = c; c:raise() end),
    awful.button({modkey},          1, function(c)
            client.focus = c
            c:raise()
            awful.mouse.client.move(c)
        end),
    awful.button({modkey, "Shift"}, 1, utils.client.togglemarked),
    awful.button({modkey},          3, awful.mouse.client.resize))

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
