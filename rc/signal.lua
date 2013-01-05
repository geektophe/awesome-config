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

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        awful.client.setslave(c)
        utils.client.save_opacity(c)

        -- Put windows in a smart way, only if they do not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end

    end

    naughty.notify({text = "Manage - Opacity: " .. c.opacity})
    naughty.notify({text = "Manage - Default opacity: " .. utils.client.get_opacity(c)})
end)


function toggle_opacity(c)
    local opacity = utils.client.get_opacity(c)

    if opacity then
        if client.focus == c then
            c.opacity = opacity
        else
            c.opacity = math.max(opacity - 0.3, 0.5)
        end
    end
end


client.add_signal("focus", function(c)
    c.border_color = beautiful.border_focus
    toggle_opacity(c)
    c:raise()
end)

client.add_signal("unfocus", function(c)
    c.border_color = beautiful.border_normal
    toggle_opacity(c)
end)

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
