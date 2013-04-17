-- Key bindings definition

awful.rules.rules = {
    -- All clients will match this rule.
    { rule       = { },
      callback   = awful.placement.centered,
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = true,
                     keys = clientkeys,
                     buttons = client_buttons,
                     floatBars = true,
                     tag = tags[1][5],
                     switchtotag = true,
                     floating = false} },

    -- Gimp
    { rule       = { class = "Firefox" },
      properties = { tag = tags[1][1]} },

    { rule       = { class = "Transmission" },
      properties = { tag = tags[1][1] } },

	-- Thunderbird
    { rule       = { class = "Thunderbird" },
      properties = { tag = tags[1][2]} },

    -- Terms
    { rule       = { class = "XTerm" },
      properties = { opacity = 0.7, tag = tags[1][3]} },
    { rule       = { class = "Gnome-terminal" },
      properties = { tag = tags[1][3] } },

    -- Gvim
    { rule       = { class = "Gvim" },
      properties = { opacity = 0.8, tag = tags[1][4]} },

    -- Baobab
    { rule       = { class = "Baobab" },
      properties = { tag = tags[1][5]} },

    -- Nautilus
    { rule       = { class = "Nautilus" },
      properties = { tag = tags[1][6] } },

    -- File Roller
    { rule       = { class = "File-roller" },
      properties = { tag = tags[1][6], opacity = 0.8 } },

    -- Dialog windows
    { rule         = { type = "dialog" },
      properties   = { floating = true, size_hints_honor = true } },

    -- Empathy
    { rule       = { class = "Empathy" },
      properties = { tag = tags[1][7], opacity = 0.8 } },

    { rule       = { class = "Empathy", role = "contact_list" },
      callback   = awful.client.setsmaster },
}

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
