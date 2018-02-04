-- {{{ Tags definition
tags_settings = {
    {
        name = "1:www",
        layout = awful.layout.suit.max,
        exclusive = true,
        mwfact = 0.70,
    },
    {
        name = "2:mail",
        layout = awful.layout.suit.max,
        exclusive = true,
        mwfact = 0.70,
    },
    {
        name = "3:term",
        layout = awful.layout.suit.fair,
    },
    {
        name = "4:dev",
        layout = awful.layout.suit.tile,
    },
    {
        name = "5:sys",
        layout = awful.layout.suit.tile,
    },
    {
        name = "6:fs",
        layout = awful.layout.suit.fair,
    },
    {
        name = "7:im",
        layout = awful.layout.suit.tile,
        mwfact = 0.2,
    },
    {
        name = "8:off",
        layout = awful.layout.suit.tile,
    },
    {
        name = "9:img",
        layout = awful.layout.suit.tile,
        mwfact = 0.2,
    },
}
-- }}}


-- {{{ Rules definition
awful.rules.rules = {
    -- All clients will match this rule.
    { rule       = { },
      callback   = awful.client.setslave,
      properties = {
          border_width = beautiful.border_width,
          border_color = beautiful.border_normal,
          keys = client_keys,
          buttons = client_buttons,
          focus = true,
          switchtotag = false,
          floating = false,
          screen = awful.screen.preferred,
          placement = awful.placement.no_overlap + awful.placement.no_offscreen
      }
    },

    -- Dialog windows
    { rule         = { type = "dialog" },
      properties   = { floating = true, size_hints_honor = true },
      callback     = awful.placement.centered
    },

    { rule         = { class = "Xephyr" },
      properties   = { floating = true, size_hints_honor = true },
      callback     = awful.placement.centered
    },

    { rule       = { class = "qjackctl" },
      properties = { floating = true, size_hints_honor = true }
    },

    -- Web
    { rule   = { class = "Firefox", role = "Preferences" },
      properties = { floating = true }
    },

    { rule_any   = { instance = {"plugin-container", "exe"} },
      properties = { floating = true, fullscreen = true, focus = true }
    },

	-- Thunderbird
    { rule       = { class = "Thunderbird" },
      properties = { tag = "2:mail"}
    },

    -- Terms (no more bound)
    -- { rule       = { class = "XTerm" },
    --   properties = { opacity = 0.7, tag = tags[1][3]} },

    -- { rule_any   = { class = {"Gnome-terminal", "URxvt"} },
    --   properties = { tag = tags[1][3] } },

    -- Gvim
    { rule       = { class = "Gvim" },
      properties = { tag = "4:dev" }
    },

    -- Baobab
    { rule       = { class = "Baobab" },
      properties = { tag = "5:sys"}
    },

    -- Rdesktop
    { rule       = { class = "rdesktop" },
      properties = { tag = "5:sys", floating=true }
    },

    -- Wireshark
    { rule       = { class = "Wireshark" },
      properties = { tag = "5:sys" }
    },

    -- Nautilus
    { rule_any   = { class = {"Nautilus", "Thunar"} },
      properties = { tag = "6:fs" }
    },

    -- File Roller
    { rule       = { class = "File-roller" },
      properties = { tag = "6:fs" }
    },

    -- Empathy
    { rule       = { class = "Empathy", role = "contact_list" },
      properties = { tag = "7:im" },
      callback   = awful.client.setsmaster
    },

    { rule       = { class = "Empathy" },
      properties = { tag = "7:im" }
    },

    -- Gajim
    { rule       = { class = "Gajim", role = "roster" },
      properties = { tag = "7:im" },
      callback   = awful.client.setsmaster
    },

    { rule       = { class = "Gajim" },
      properties = { tag = "7:im" }
    },

    -- Libreoffice
    { rule_any   = { class = { "libreoffice-startcenter",
                               "libreoffice-writer",
                               "libreoffice-calc",
                               "libreoffice-impress",
                               "libreoffice-base",
                               "libreoffice-math",
                               "VCLSalFrame.DocumentWindow" } },
      properties = { tag = "8:off"}
    },

    -- Image tools
    { rule_any   = { class = {"Dia", "Gimp", "Pinta"} },
      properties = { tag = "9:img" }
    },
}
-- }}}


-- {{{ Tag list definition
taglist = {}
taglist.buttons = taglist_buttons
-- }}}

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
