-- Key bindings definition

local utils = utils
local awesome = awesome
local client = client
local mouse = mouse
local shifty = require("shifty")
local naughty = require("naughty")
local awful = require("awful")


module("cfg.keys")

-- Module level variables
modkey = nil
terminal = nil
editor = nil
promptbox = nil

local initialized = false


-- {{{ Error
-- Displayes an error messages as a naughty notification, and on the console
local function err(errmsg)
    local title = "Key bindings initialization error"
    naughty.notify({ title = title,
        text = errmsg,
        preset = naughty.config.presets.critical
        })
    return print("E: " .. title .. ": " .. errmsg)
end


-- {{{  Module initialization
function init()
    if not modkey then
        err("Modkey has not been set.")
    end
    if not terminal then
        err("Terminal has not been set.")
    end
    if not editor then
        err("Editor has not been set.")
    end
    if not promptbox then
        err("Promptbox has not been set.")
    end
    initialized = true
end
-- }}}


-- {{{ Global key bindings
function globalkeys()
    if not initialized then
        err("Molule has not been initialized.")
    end

    keys = awful.util.table.join(
        awful.key({ modkey, }, "Left",   awful.tag.viewprev),
        awful.key({ modkey, }, "Right",  awful.tag.viewnext),
        awful.key({ modkey, }, "Escape", awful.tag.history.restore),

        -- Shifty: keybindings specific to shifty
        awful.key({modkey}, "d", shifty.del), -- delete a tag
        awful.key({modkey, "Shift"}, "n", shifty.send_prev), -- client to prev tag
        awful.key({modkey}, "n", shifty.send_next), -- client to next tag
        awful.key({modkey, "Control"}, "n",
            function()
                local t = awful.tag.selected()
                local s = awful.util.cycle(screen.count(), t.screen + 1)
                awful.tag.history.restore()
                t = shifty.tagtoscr(s, t)
                awful.tag.viewonly(t)
            end),
        awful.key({modkey}, "a", shifty.add), -- creat a new tag
        awful.key({modkey, "Control"}, "è", shifty.rename), -- rename a tag
        awful.key({modkey, "shift"}, "a", -- nopopup new tag
            function()
                shifty.add({nopopup = true})
            end),

        -- Tab
        awful.key({ modkey, }, "Tab",
            function ()
                awful.client.focus.byidx( 1)
                if client.focus then client.focus:raise() end
            end),
        awful.key({ modkey, "Shift" }, "Tab",
            function ()
                awful.client.focus.byidx(-1)
                if client.focus then client.focus:raise() end
            end),


        -- Remapped H
        awful.key({ modkey,           }, "c", function () awful.tag.incmwfact(-0.05) end),
        awful.key({ modkey, "Shift"   }, "c", function () awful.tag.incnmaster(1) end),
        awful.key({ modkey, "Control" }, "c", function () awful.tag.incncol(1) end),


        -- Remapped J
        awful.key({ modkey, }, "t",
            function ()
                awful.client.focus.byidx(1)
                if client.focus then client.focus:raise() end
            end),
        awful.key({ modkey, "Shift"   }, "t", function () awful.client.swap.byidx(1) end),
        awful.key({ modkey, "Control" }, "t", function () awful.screen.focus_relative(1) end),


        -- Remapped K
        awful.key({ modkey, }, "s",
            function ()
                awful.client.focus.byidx(-1)
                if client.focus then client.focus:raise() end
            end),
        awful.key({ modkey, "Shift"   }, "s", function () awful.client.swap.byidx( -1) end),
        awful.key({ modkey, "Control" }, "s", function () awful.screen.focus_relative(-1) end),


        -- Remapped L
        awful.key({ modkey,           }, "r",     function () awful.tag.incmwfact(0.05) end),
        awful.key({ modkey, "Shift"   }, "r",     function () awful.tag.incnmaster(-1) end),
        awful.key({ modkey, "Control" }, "r",     function () awful.tag.incncol(-1) end),


        awful.key({ modkey,           }, "g", awful.client.urgent.jumpto),


        -- Standard program
        awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
        awful.key({ modkey, "Control" }, "l", awesome.restart),
        awful.key({ modkey, "Shift"   }, "q", awesome.quit),

        awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
        awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),
        awful.key({ modkey,           }, "v",     revelation),
        awful.key({ modkey,           }, "i",     utils.client.info),

        -- Prompt
        awful.key({ modkey },            "l",     function () promptbox[mouse.screen]:run() end)
    )

    -- Tags access keys
    for i=1, (shifty.config.maxtags or 9) do
        keys = awful.util.table.join(keys,
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

    -- Compute the maximum number of digit we need, limited to 9
    -- keynumber = 0
    -- for s = 1, screen.count() do
    --    keynumber = math.min(9, math.max(#tags[s], keynumber));
    -- end
    --
    -- Bind all key numbers to tags.
    -- Be careful: we use keycodes to make it works on any keyboard layout.
    -- This should map on the top row of your keyboard, usually 1 to 9.
    -- for i = 1, keynumber do
    --     keys = awful.util.table.join(keys,
    --         awful.key({ modkey }, "#" .. i + 9,
    --                   function ()
    --                         local screen = mouse.screen
    --                         if tags[screen][i] then
    --                             awful.tag.viewonly(tags[screen][i])
    --                         end
    --                   end),
    --         awful.key({ modkey, "Control" }, "#" .. i + 9,
    --                   function ()
    --                       local screen = mouse.screen
    --                       if tags[screen][i] then
    --                           awful.tag.viewtoggle(tags[screen][i])
    --                       end
    --                   end),
    --         awful.key({ modkey, "Shift" }, "#" .. i + 9,
    --                   function ()
    --                       if client.focus and tags[client.focus.screen][i] then
    --                           awful.client.movetotag(tags[client.focus.screen][i])
    --                       end
    --                   end),
    --         awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
    --                   function ()
    --                       if client.focus and tags[client.focus.screen][i] then
    --                           awful.client.toggletag(tags[client.focus.screen][i])
    --                       end
    --                   end))
    -- end
    --

    return keys

end
-- }}}


-- {{{ Global key bindings
function clientkeys()
    if not initialized then
        err("Molule has not been initialized.")
    end

    return awful.util.table.join(
        awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
        awful.key({ modkey,           }, "q",      function (c) c:kill()                         end),
        awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
        awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
        awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
        awful.key({ modkey, "Shift"   }, "l",      function (c) c:redraw()                       end),
        awful.key({ modkey,           }, "m",      function (c) c.minimized = not c.minimized    end),
        awful.key({ modkey,           }, "m",
            function (c)
                c.maximized_horizontal = not c.maximized_horizontal
                c.maximized_vertical   = not c.maximized_vertical
            end)
    )
end
-- }}}

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
