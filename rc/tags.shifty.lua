-- Shity tags and apps configuration

-- {{{ Enable title bar only for floating windows
shifty.config.float_bars = true
-- }}}

-- {{{ Tags definitions
shifty.config.tags = {
    ["1:www"] = {
        init = true,
        position = 1,
        exclusive = true,
        mwfact = 0.70,
    },
    ["2:mail"] = {
        init = true,
        position = 2,
        exclusive = true,
        mwfact = 0.70,
    },
    ["3:term"] = {
        init = true,
        position = 3,
    },
    ["4:dev"] = {
        init = true,
        position = 4,
    },
    ["5:notag"] = {
        init = true,
        position = 5,
    },
    ["6:fs"] = {
        init = true,
        position = 6,
    },
     ["7:im"] = {
         init = true,
         position = 7,
     },
    ["8:off"] = {
        init = true,
        position = 8,
    },
}
-- }}}


-- {{{ Apps definitions
shifty.config.apps = {
    {
        match = { "Dialog", "dialog", "Download" },
        float = true,
        honorsizehints = true,
        floatBars=true,
        ontop=true,
    },
    {
        match = { "Iceweasel.*", "Firefox.*" },
        tag = "1:www",
        screen = screen.count(),
    },
    {
        match = { "Thunderbird.*" },
        tag = "2:mail",
    },
    {
        match = { "Npviewer.bin" },
        tag = "1:www",
        float = true,
    },
    {
        match = { "Gvim" },
        tag = "4:dev",
    },
    {
        match = { "XTerm" },
        tag = "3:term",
        opacity = 0.8,
    },
    {
        match = { "URxvt", "Terminator" },
        tag = "3:term",
    },
    {
        match = { "Terminator Preferences" },
        tag = "3:term",
        float = true,
    },
    {
        match = { "Empathy" },
        tag = "7:im",
    },
    {
        match = { "contact_list" },
        geometry = { 100,100,nil,nil },
    },
    {
        match = {  "LibreOffice.*" },
        tag = "8:off",
    },
    {
        match = { "Nautilus", "File-roller", "Baobab" },
        tag = "6:fs",
    },
    {
        match = { "MPlayer" },
        float = true,
    },
    {
        match = { "Gcolor2" },
        float = true,
        ontop = true,
        sticky = true,
    },
    {
        match = { "" },
        buttons = awful.util.table.join(
            awful.button({}, 1, function (c) client.focus = c; c:raise() end),
            awful.button({modkey}, 1, function(c)
                    client.focus = c
                    c:raise()
                    awful.mouse.client.move(c)
                end),
            awful.button({modkey}, 3, awful.mouse.client.resize)
            )
    },
}
-- }}}


-- {{{ Defaults definitions
shifty.config.defaults = {
    run = function(tag) naughty.notify({ text = tag.name }) end,
    layout = awful.layout.suit.tile,
    ncol = 1,
    guess_name=true,
    guess_position=true,
    opacity=1,
}
-- }}}


-- {{{ Tag list definition
shifty.taglist = {}
shifty.taglist.buttons = awful.util.table.join(
    awful.button({ },        1, awful.tag.viewonly),
    awful.button({ modkey }, 1, awful.client.movetotag),
    awful.button({ },        3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, awful.client.toggletag),
    awful.button({ },        4, awful.tag.viewnext),
    awful.button({ },        5, awful.tag.viewprev)
    )
-- }}}


--awful.hooks.property.register(function (c, prop)
--    -- Remove the titlebar if fullscreen
--    if c.fullscreen then
--        awful.titlebar.remove(c)
--    elseif not c.fullscreen then
--        -- Add title bar for floating apps
--        if c.titlebar == nil and awful.client.floating.get(c) then
--            awful.titlebar.add(c, { modkey = modkey })
--        -- Remove title bar, if it's not floating
--        elseif c.titlebar and not awful.client.floating.get(c) then
--            awful.titlebar.remove(c)
--        end
--    end
--end)


-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
