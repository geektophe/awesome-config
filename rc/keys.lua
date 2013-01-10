-- Key bindings definition


-- {{{ Global keys bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey, }, "Left",   awful.tag.viewprev),
    awful.key({ modkey, }, "Right",  awful.tag.viewnext),
    awful.key({ modkey, }, "Escape", awful.tag.history.restore),

    -- Move tag
    awful.key({ modkey, "Control" }, "Left",  function () utils.tag.incindex(-1) end),
    awful.key({ modkey, "Control" }, "Right", function () utils.tag.incindex(1) end),

    -- Shifty: keybindings specific to shifty
    awful.key({ modkey            }, "d", shifty.del), -- delete a tag
    awful.key({ modkey            }, "n", shifty.send_next), -- client to next tag
    awful.key({ modkey, "Shift"   }, "n", shifty.send_prev), -- client to prev tag
    awful.key({ modkey, "Control" }, "n", utils.tag.toscreen), -- send tag to screen
    awful.key({ modkey            }, "a", shifty.add), -- creat a new tag
    awful.key({ modkey, "Control" }, "è", shifty.rename), -- rename a tag
    awful.key({ modkey, "shift"   }, "a", -- nopopup new tag
        function()
            shifty.add({nopopup = true})
        end),

    -- Tab
    awful.key({ modkey,         }, "Tab", function () utils.client.viewnext(1) end),
    awful.key({ modkey, "Shift" }, "Tab", function () utils.client.viewnext(-1) end),

    -- Remapped H
    awful.key({ modkey,           }, "c", function () awful.tag.incmwfact(-0.05) end),
    awful.key({ modkey, "Shift"   }, "c", function () awful.tag.incnmaster(1) end),
    awful.key({ modkey, "Control" }, "c", function () awful.tag.incncol(1) end),

    -- Remapped J
    awful.key({ modkey, },           "t", function () utils.client.viewnext(1) end),
    awful.key({ modkey, "Shift"   }, "t", function () awful.client.swap.byidx(1) end),
    awful.key({ modkey, "Control" }, "t", function () awful.screen.focus_relative(1) end),

    -- Remapped K
    awful.key({ modkey, }, "s", function () utils.client.viewnext(-1) end),
    awful.key({ modkey, "Shift"   }, "s", function () awful.client.swap.byidx( -1) end),
    awful.key({ modkey, "Control" }, "s", function () awful.screen.focus_relative(-1) end),

    -- Remapped L
    awful.key({ modkey,           }, "r",     function () awful.tag.incmwfact(0.05) end),
    awful.key({ modkey, "Shift"   }, "r",     function () awful.tag.incnmaster(-1) end),
    awful.key({ modkey, "Control" }, "r",     function () awful.tag.incncol(-1) end),

    awful.key({ modkey,           }, "g", awful.client.urgent.jumpto),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "l",      awesome.restart),
    awful.key({ modkey, "Shift"   }, "q",      awesome.quit),

    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),
    awful.key({ modkey,           }, "v",     revelation),
    awful.key({ modkey,           }, "i",     utils.client.info),

    -- Prompt
    awful.key({ modkey },            "l",     function () mypromptbox[mouse.screen]:run() end)
)

-- Tags access keys
for i=1, (shifty.config.maxtags or 9) do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
            function ()
                local t = awful.tag.viewonly(shifty.getpos(i))
            end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                function ()
                    local t = shifty.getpos(i)
                    t.selected = not t.selected
                end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
            function ()
                if client.focus then
                    awful.client.toggletag(shifty.getpos(i))
                end
            end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
            function ()
                if client.focus then
                    local t = shifty.getpos(i)
                   awful.client.movetotag(t)
                   awful.tag.viewonly(t)
                    end
                end))
end
-- }}}


-- {{{ Client key bindings
clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey,           }, "q",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c)
        c:swap(awful.client.getmaster())
        c.raise()
    end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey, "Shift"   }, "l",      function (c) c:redraw()                       end),
    -- awful.key({ modkey,           }, "m",      function (c) c.minimized = not c.minimized    end),
    -- awful.key({ modkey,           }, "m",      function (c)
    --     c.maximized_horizontal = not c.maximized_horizontal
    --     c.maximized_vertical   = not c.maximized_vertical
    -- end),
    awful.key({ modkey,           }, "Prior", function(c)
        if utils.client.opacity_incr(c, 0.1) then
            naughty.notify({ text = "Client opacity set to: " .. c.opacity })
        end
    end),
    awful.key({ modkey,           }, "Next", function(c)
        if utils.client.opacity_incr(c, -0.1) then
            naughty.notify({ text = "Client opacity set to: " .. c.opacity })
        end
    end)
)
-- }}}


-- {{{ Key bindings affectation
root.keys(globalkeys)
shifty.config.globalkeys = globalkeys
shifty.config.clientkeys = clientkeys
-- }}}


-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
