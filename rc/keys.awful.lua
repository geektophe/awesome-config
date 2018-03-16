-- {{{ Awful specific key bindings
-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags_settings, keynumber));
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
    global_keys = awful.util.table.join(global_keys,
        awful.key({ modkey }, "#" .. i + 9,
                function ()
                    local screen = awful.screen.focused()
                    local tag = screen.tags[i]
                    if tag then
                        tag:view_only()
                    end
                end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                function ()
                    local screen = awful.screen.focused()
                    local tag = screen.tags[i]
                    if client.focus and tag then
                        tag.selected = not tag.selected
                    end
                end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                function ()
                    local screen = awful.screen.focused()
                    local tag = screen.tags[i]
                    if client.focus and tag then
                        awful.client.toggletag(tag)
                    end
                end),
        awful.key({ modkey, "Mod1" }, "#" .. i + 9,
                function ()
                    local screen = awful.screen.focused()
                    local tag = screen.tags[i]
                    if client.focus and tag then
                        client.focus:move_to_tag(tag)
                        tag:view_only()
                    end
                end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                function ()
                    local screen = awful.screen.focused()
                    local tag = screen.tags[i]
                    if client.focus and tag then
                        utils.client.markedtotag(tag)
                        tag:view_only()
                    end
                end))
end
-- }}}


-- {{{ Key bindings affectation
root.keys(global_keys)
-- }}}

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
