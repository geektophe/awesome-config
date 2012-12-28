-- Shity tags and apps configuration


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
        match = { "XTerm", "Terminator" },
        tag = "3:term",
        opacity = 0.9,
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
        match = { "gcolor2" },
        geometry = { 100,100,nil,nil },
        tag = "",
    },
    {
        match = { "MPlayer" },
        float = true,
    },
    {
        match = { "" },
        buttons = {
            awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
            awful.button({ modkey }, 1, function (c) awful.mouse.client.move() end),
            awful.button({ modkey }, 3, function (c) awful.mouse.client.resize() end),
        },
    },
}
-- }}}


-- {{{ Defaults definitions
shifty.config.defaults = {
    run = function(tag) naughty.notify({ text = tag.name }) end,
    layout = awful.layout.suit.tile,
    floatBars=true,
    ncol = 1,
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



-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
