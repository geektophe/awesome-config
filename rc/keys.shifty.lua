-- {{{ Shifty specific key bindings

--global_keys = awful.util.table.join(global_keys,
    -- Shifty: keybindings specific to shifty
    --awful.key({ modkey            }, "d", shifty.del), -- delete a tag
    --awful.key({ modkey            }, "n", shifty.send_next), -- client to next tag
    --awful.key({ modkey, "Shift"   }, "n", shifty.send_prev), -- client to prev tag
    --awful.key({ modkey            }, "a", shifty.add), -- creat a new tag
    --awful.key({ modkey, "Control" }, "è", shifty.rename), -- rename a tag
    --awful.key({ modkey, "shift"   }, "a", -- nopopup new tag
    --    function()
    --        shifty.add({nopopup = true})
    --    end),)

-- Tags access keys
for i=1, (shifty.config.maxtags or 9) do
    global_keys = awful.util.table.join(global_keys,
        awful.key({ modkey }, "#" .. i + 9,
            function ()
                local t = awful.tag.viewonly(shifty.getpos(i))
            end),
        awful.key({ modkey, "Shift"   }, "#" .. i + 9,
                function ()
                    local t = shifty.getpos(i)
                    t.selected = not t.selected
                end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
            function ()
                if client.focus then
                    awful.client.toggletag(shifty.getpos(i))
                end
            end),
        awful.key({ modkey, "Mod1"    }, "#" .. i + 9,
            function ()
                if client.focus then
                    local t = shifty.getpos(i)
                    awful.client.movetotag(t)
                    awful.tag.viewonly(t)
                end
            end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
            function ()
                local t = shifty.getpos(i)
                utils.client.markedtotag(t)
                awful.tag.viewonly(t)
            end))
end


-- {{{ Key bindings affectation
root.keys(global_keys)

if shifty then
    shifty.config.globalkeys = global_keys
    shifty.config.clientkeys = client_keys
end
-- }}}

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
