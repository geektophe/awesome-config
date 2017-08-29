-- Key bindings definition

-- {{{ Resize mode keys
resize_mode_keys = {
    c =     function () awful.tag.incmwfact(-0.05) end,
    t =     function () awful.client.incwfact(-0.05) end,
    s =     function () awful.client.incwfact(0.05) end,
    r =     function () awful.tag.incmwfact(0.05) end,
    Left =  function () awful.tag.incmwfact(-0.05) end,
    Down =  function () awful.client.incwfact(-0.05) end,
    Up =    function () awful.client.incwfact(0.05) end,
    Right = function () awful.tag.incmwfact(0.05) end
}
-- }}}


-- {{{ Tag keys
tag_keys = {
    [1] = '"',
    [2] = '«',
    [3] = '»',
    [4] = '(',
    [5] = ')',
    [6] = '@',
    [7] = '+',
    [8] = '-',
    [9] = '/'
}
-- }}}
--

-- {{{ Move mode keys
move_mode_keys = {
    c =     function (c) utils.client.move_to_screen(c, -1) end,
    t =     function (c) awful.client.swap.byidx(-1) end,
    s =     function (c) awful.client.swap.byidx(1) end,
    r =     function (c) utils.client.move_to_screen(c, 1) end,
    Left =  function (c) utils.client.move_to_screen(c, -1) end,
    Down =  function (c) awful.client.swap.byidx(-1) end,
    Up =    function (c) awful.client.swap.byidx(1) end,
    Right = function (c) utils.client.move_to_screen(c, 1) end,
    space = function (c) utils.client.marked_toggle(c) end
}

for code, key in  pairs(tag_keys)  do
    move_mode_keys[key] = function (c)
        if tags[c.screen][code] then
            local t = tags[c.screen][code]
            client.focus:move_to_tag(t)
            t:view_only()
        end
    end
end
-- }}}
--
-- {{{ Move mode keys
display_mode_keys = {}

for code, key in  pairs(tag_keys)  do
    display_mode_keys[key] = function (c)
        if tags[c.screen][code] then
            local t = tags[c.screen][code]
            client.focus:toggle_tag(t)
        end
    end
end
-- }}}


-- {{{ Global keys bindings
global_keys = awful.util.table.join(
    awful.key({ modkey, }, "Escape", awful.tag.history.restore),

    -- Move tag
    awful.key({ modkey, "Control" }, "n",     utils.tag.toscreen), -- send tag to screen
    -- awful.key({ modkey, "Control" }, "Left",  function () utils.tag.incindex(-1) end),
    -- awful.key({ modkey, "Control" }, "Right", function () utils.tag.incindex(1) end),

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
    awful.key({ modkey,           }, "c",     function () awful.tag.incmwfact(-0.05) end),
    awful.key({ modkey, "Shift"   }, "c",     function () awful.tag.incnmaster(1) end),
    awful.key({ modkey,           }, "Left",  function () awful.tag.incmwfact(-0.05) end),
    awful.key({ modkey, "Shift"   }, "Left",  function () awful.tag.incnmaster(1) end),

    -- Remapped J
    awful.key({ modkey,           }, "t",     function () utils.client.viewnext(-1) end),
    awful.key({ modkey, "Shift"   }, "t",     function () awful.tag.incncol(1) end),
    awful.key({ modkey, "Control" }, "t",     function () awful.screen.focus_relative(1) end),
    awful.key({ modkey, "Mod1"    }, "t",     function () awful.client.swap.byidx(-1) end),
    awful.key({ modkey,           }, "Down",  function () utils.client.viewnext(-1) end),
    awful.key({ modkey, "Shift"   }, "Down",  function () awful.tag.incncol(1) end),
    awful.key({ modkey, "Control" }, "Down",  function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey, "Mod1"    }, "Down",  function () awful.client.swap.byidx(-1) end),

    -- Remapped K
    awful.key({ modkey,           }, "s",     function () utils.client.viewnext(1) end),
    awful.key({ modkey, "Shift"   }, "s",     function () awful.tag.incncol(-1) end),
    awful.key({ modkey, "Control" }, "s",     function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey, "Mod1"    }, "s",     function () awful.client.swap.byidx(1) end),
    awful.key({ modkey,           }, "Up",    function () utils.client.viewnext(1) end),
    awful.key({ modkey, "Shift"   }, "Up",    function () awful.tag.incncol(-1) end),
    awful.key({ modkey, "Control" }, "Up",    function () awful.screen.focus_relative(1) end),
    awful.key({ modkey, "Mod1"    }, "Up",    function () awful.client.swap.byidx(1) end),

    -- Remapped L
    awful.key({ modkey,           }, "r",     function () awful.tag.incmwfact(0.05) end),
    awful.key({ modkey, "Shift"   }, "r",     function () awful.tag.incnmaster(-1) end),
    awful.key({ modkey,           }, "Right", function () awful.tag.incmwfact(0.05) end),
    awful.key({ modkey, "Shift"   }, "Right", function () awful.tag.incnmaster(-1) end),

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

    -- screen config management
    awful.key({}, "XF86Display",     function () awful.util.spawn("screen-config") end),

    -- moves selected clients to current tag
    awful.key({ modkey },            "v", utils.client.marked_to_client_tag),

    awful.key({ modkey },            "b", utils.mode.get_mode_callback("RESIZE", resize_mode_keys, widgets.mode)),
    awful.key({ modkey },            "d",     function ()
        local cmd = "dmenu_run -i" ..
            "  -nb '" .. string.sub(beautiful.bg_normal, 0, 7) ..
            "' -nf '" .. string.sub(beautiful.fg_normal, 0, 7) ..
            "' -sb '" .. string.sub(beautiful.bg_focus, 0, 7) ..
            "' -sf '" .. string.sub(beautiful.fg_focus, 0, 7) ..
            "' -fn 'dejavu sans-8'"
        awful.util.spawn(cmd)
    end)
)
-- }}}


-- {{{ Client key bindings
client_keys = awful.util.table.join(
    -- Remapped H
    awful.key({ modkey, "Mod1"    }, "c",      function (c)
        utils.client.move_to_screen(c, 1)
    end),
    awful.key({ modkey, "Mod1"    }, "Left",   function (c)
        utils.client.move_to_screen(c, 1)
    end),

    -- Remapped L
    awful.key({ modkey, "Mod1"    }, "r",      function (c)
        utils.client.move_to_screen(c, -1)
    end),
    awful.key({ modkey, "Mod1"    }, "Right",  function (c)
        utils.client.move_to_screen(c, -1)
    end),

    awful.key({ modkey,           }, "f",      function (c)
        awful.client.floating.toggle(c)
        c.fullscreen = not c.fullscreen
    end),

    awful.key({ modkey,           }, "q",      function (c) c:kill() end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle),
    awful.key({ modkey, "Mod1"    }, "space",  utils.client.marked_toggle),
    awful.key({ modkey, "Control" }, "Return", function (c)
        c:swap(awful.client.getmaster())
        c:raise()
    end),

    awful.key({ modkey, "Shift"   }, "l",      function (c) c:redraw() end),
    awful.key({ modkey,           }, "Prior",  function(c)
        if utils.client.opacity_incr(c, 0.1) then
            naughty.notify({ text = "Client opacity set to: " .. c.opacity })
        end
    end),
    awful.key({ modkey,           }, "Next", function(c)
        if utils.client.opacity_incr(c, -0.1) then
            naughty.notify({ text = "Client opacity set to: " .. c.opacity })
        end
    end),
    awful.key({ modkey },            "m", utils.mode.get_mode_callback("MOVE", move_mode_keys, widgets.mode)),
    awful.key({ modkey },            "j", utils.mode.get_mode_callback("DISPLAY", display_mode_keys, widgets.mode))
)
-- }}}

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
