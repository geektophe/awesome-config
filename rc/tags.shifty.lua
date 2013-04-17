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
    ["5:sys"] = {
        init = true,
        position = 5,
    },
    ["6:fs"] = {
        init = false,
        position = 6,
    },
     ["7:im"] = {
         init = true,
         position = 7,
         mwfact = 0.2,
     },
    ["8:off"] = {
        init = false,
        position = 8,
    },
    ["9:img"] = {
        init = false,
        position = 9,
        mwfact = 0.2,
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
        match = { "gimp%-file%-export", "^.*%-file$" },
        tag = "9:img",
        float = true,
    },
    {
        match = { "Iceweasel.*", "Firefox.*" },
        tag = "1:www",
        screen = screen.count(),
    },
    {
        match = { "Npviewer.bin", "Plugin-container" },
        tag = "1:www",
        float = true,
        -- callback = function (c) c.fullscreen end,
    },
    {
        match = { "Thunderbird.*" },
        tag = "2:mail",
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
        match = { "URxvt", "Terminator", "Gnome%-terminal" },
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
        callback = awful.client.setmaster,
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
        match = { "Rdesktop" },
        float = true,
        tag = "5:sys",
    },
    {
        match = { "gimp.*", "^dia$" },
        tag = "9:img",
    },
    {
        match = { "" },
        -- callback = awful.client.setslave,
        slave = true,
        buttons = awful.util.table.join(
            awful.button({},                1, function(c) client.focus = c; c:raise() end),
            awful.button({modkey},          1, function(c)
                    client.focus = c
                    c:raise()
                    awful.mouse.client.move(c)
                end),
            awful.button({modkey, "Shift"}, 1, utils.client.togglemarked),
            awful.button({modkey},          3, awful.mouse.client.resize))
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


-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
