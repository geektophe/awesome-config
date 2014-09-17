-- Key bindings definition

-- {{{ Global keys bindings
global_keys = awful.util.table.join(
    awful.key({ modkey, }, "Left",   function() utils.client.viewnext(-1) end),
    awful.key({ modkey, }, "Right",  function() utils.client.viewnext(1) end),
    awful.key({ modkey, }, "Escape", awful.tag.history.restore),

    -- Move tag
    awful.key({ modkey, "Control" }, "n",     utils.tag.toscreen), -- send tag to screen
    awful.key({ modkey, "Control" }, "Left",  function () utils.tag.incindex(-1) end),
    awful.key({ modkey, "Control" }, "Right", function () utils.tag.incindex(1) end),

    -- Shifty: keybindings specific to shifty
    --awful.key({ modkey            }, "d", shifty.del), -- delete a tag
    --awful.key({ modkey            }, "n", shifty.send_next), -- client to next tag
    --awful.key({ modkey, "Shift"   }, "n", shifty.send_prev), -- client to prev tag
    --awful.key({ modkey            }, "a", shifty.add), -- creat a new tag
    --awful.key({ modkey, "Control" }, "è", shifty.rename), -- rename a tag
    --awful.key({ modkey, "shift"   }, "a", -- nopopup new tag
    --    function()
    --        shifty.add({nopopup = true})
    --    end),

    -- Tab
    awful.key({ modkey,         }, "Tab", function () utils.client.viewnext(1) end),
    awful.key({ modkey, "Shift" }, "Tab", function () utils.client.viewnext(-1) end),

    -- Remapped H
    -- awful.key({ modkey,           }, "c", function () awful.tag.incmwfact(-0.05) end),
    awful.key({ modkey,           }, "c", function () awful.client.swap.byidx(-1) end),
    awful.key({ modkey, "Shift"   }, "c", function () awful.tag.incnmaster(1) end),
    awful.key({ modkey, "Control" }, "c", function () awful.tag.incncol(1) end),
    awful.key({ modkey, "Mod1"    }, "c", function () awful.tag.incmwfact(-0.05) end),

    -- Remapped J
    awful.key({ modkey,           }, "t", function () utils.client.viewnext(-1) end),
    awful.key({ modkey, "Shift"   }, "t", function () awful.tag.incncol(1) end),
    awful.key({ modkey, "Control" }, "t", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey, "Mod1"    }, "t", function () awful.client.incwfact(-0.05) end),

    -- Remapped K
    awful.key({ modkey,           }, "s", function () utils.client.viewnext(1) end),
    awful.key({ modkey, "Shift"   }, "s", function () awful.tag.incncol(-1) end),
    awful.key({ modkey, "Control" }, "s", function () awful.screen.focus_relative(1) end),
    awful.key({ modkey, "Mod1"    }, "s", function () awful.client.incwfact(0.05) end),

    -- Remapped L
    awful.key({ modkey,           }, "r", function () awful.client.swap.byidx(1) end),
    awful.key({ modkey, "Shift"   }, "r", function () awful.tag.incnmaster(-1) end),
    awful.key({ modkey, "Control" }, "r", function () awful.tag.incncol(-1) end),
    awful.key({ modkey, "Mod1"    }, "r", function () awful.tag.incmwfact(0.05) end),

    -- Jump to urgent client
    awful.key({ modkey,           }, "g", awful.client.urgent.jumpto),

    -- Jump to next screen
    awful.key({ modkey,           }, "h", function () utils.screen.focusnext() end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "l",      awesome.restart),
    awful.key({ modkey, "Shift"   }, "q",      awesome.quit),

    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),
    awful.key({ modkey,           }, "b",     revelation),
    awful.key({ modkey,           }, "i",     utils.client.info),

    -- Prompt
    awful.key({ modkey },            "l",     function () mypromptbox[mouse.screen]:run() end),

    -- Volume management
    awful.key({}, "XF86AudioMute",        utils.pulseaudio.volume_mute),
    awful.key({}, "XF86AudioLowerVolume", utils.pulseaudio.volume_down),
    awful.key({}, "XF86AudioRaiseVolume", utils.pulseaudio.volume_up),

    -- lock screen management
    awful.key({}, "XF86ScreenSaver",      function () awful.util.spawn(xlock) end),
    awful.key({"Control", "Mod1"},   "l", function () awful.util.spawn(xlock) end),

    -- moves selected clients to current tag
    awful.key({ modkey },            "v", utils.client.markedtoctag)
)
-- }}}


-- {{{ Client key bindings
client_keys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c)
                                                    awful.client.floating.toggle(c)
                                                    c.fullscreen = not c.fullscreen
                                                end),
    awful.key({ modkey            }, "u",      utils.client.togglemarked), -- marks client
    awful.key({ modkey,           }, "q",      function (c) c:kill() end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle),
    awful.key({ modkey, "Control" }, "Return", function (c)
        c:swap(awful.client.getmaster())
        c:raise()
    end),
    awful.key({ modkey,           }, "n",      awful.client.movetoscreen),
    awful.key({ modkey, "Shift"   }, "l",      function (c) c:redraw() end),
    awful.key({ modkey,           }, "m",      utils.client.togglemaximized),
    awful.key({ modkey,           }, "Prior",  function(c)
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

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
