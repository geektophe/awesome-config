-- {{{ Awful specific key bindings
-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
    global_keys = awful.util.table.join(global_keys,
        awful.key({ modkey }, "#" .. i + 9,
                function ()
                      local screen = mouse.screen
                      if tags[screen][i] then
                          awful.tag.viewonly(tags[screen][i])
                      end
                end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                function ()
                    if client.focus and tags[client.focus.screen][i] then
                        local t = tags[client.focus.screen][i]
                        t.selected = not t.selected
                    end
                end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                function ()
                    if client.focus and tags[client.focus.screen][i] then
                        local t = tags[client.focus.screen][i]
                        awful.client.toggletag(t)
                    end
                end),
        awful.key({ modkey, "Mod1" }, "#" .. i + 9,
                function ()
                    if client.focus and tags[client.focus.screen][i] then
                        local t = tags[client.focus.screen][i]
                        awful.client.movetotag(t)
                        awful.tag.viewonly(t)
                    end
                end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                function ()
                    if client.focus and tags[client.focus.screen][i] then
                        local t = tags[client.focus.screen][i]
                        utils.client.markedtotag(t)
                        awful.tag.viewonly(t)
                    end
                end))
end
-- }}}


-- {{{ Key bindings affectation
root.keys(global_keys)
-- }}}

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
