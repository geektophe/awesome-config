-- Signal function to execute when a new client appears.
client.add_signal("manage", function (c, startup)
    -- Add a titlebar
    -- awful.titlebar.add(c, { modkey = modkey })

    -- Enable sloppy focus
    c:add_signal("mouse::enter",
        function(c)
            if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
               and awful.client.focus.filter(c) then
                client.focus = c
            end
        end)

    -- Makes client floating ontop
    c.ontop = awful.client.floating.get(c)

    c:add_signal("property::floating",  function (c)
        c.ontop = awful.client.floating.get(c)

        if c.ontop then
            awful.titlebar.add(c, {modkey=modkey})
        else
            awful.titlebar.remove(c)
        end
    end)


    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)
        utils.client.opacity_save(c)
        awful.placement.no_overlap(c)
        awful.placement.no_offscreen(c)
    end

    if awful.client.floating.get(c) then
        c.ontop = true
        awful.titlebar.add(c, {modkey=modkey})
    end
end)

client.add_signal("focus", function(c)
    if not awful.client.ismarked(c) then
        c.border_color = beautiful.border_focus
    end
    utils.client.opacity_toggle(c)
    c:raise()
end)

client.add_signal("unfocus", function(c)
    if not awful.client.ismarked(c) then
        c.border_color = beautiful.border_normal
    end
    utils.client.opacity_toggle(c)
end)

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.add_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end
-- }}}

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
