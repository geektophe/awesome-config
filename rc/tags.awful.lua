-- {{{ Tags definition
tags_settings = {
    ["1:www"] = {
        layout = awful.layout.suit.tile,
        position = 1,
        exclusive = true,
        mwfact = 0.70,
    },
    ["2:mail"] = {
        layout = awful.layout.suit.tile,
        position = 2,
        exclusive = true,
        mwfact = 0.70,
    },
    ["3:term"] = {
        layout = awful.layout.suit.tile,
        position = 3,
    },
    ["4:dev"] = {
        layout = awful.layout.suit.tile,
        position = 4,
    },
    ["5:sys"] = {
        layout = awful.layout.suit.tile,
        position = 5,
    },
    ["6:fs"] = {
        layout = awful.layout.suit.tile,
        position = 6,
    },
     ["7:im"] = {
        layout = awful.layout.suit.tile,
         position = 7,
         mwfact = 0.2,
     },
    ["8:off"] = {
        layout = awful.layout.suit.tile,
        position = 8,
    },
    ["9:img"] = {
        layout = awful.layout.suit.tile,
        position = 9,
        mwfact = 0.2,
    },
}


tags = {}

for s = 1, screen.count() do
    -- Creates tags
    tag_names = {}
    tag_layouts = {}

    for name, settings in pairs(tags_settings) do
        if not settings.screen or (settings.screen and settings.screen == s) then
            tag_names[settings.position] = name
            tag_layouts[settings.position] = settings.layout
        end
    end

    tags[s] = awful.tag(tag_names, s, tag_layouts)

    -- Applies tags settings
    for name, settings in pairs(tags_settings) do
        tag = tags[s][settings.position]

        if tag and settings.mwfact then
            awful.tag.setmwfact(settings.mwfact, tag)
        end
    end
end
-- }}}


-- {{{ Rules definition
awful.rules.rules = {
    -- All clients will match this rule.
    { rule       = { },
      callback   = awful.placement.centered,
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     keys = client_keys,
                     buttons = client_buttons,
                     focus = true,
                     switchtotag = true,
                     floating = false} },

    -- Dialog windows
    { rule         = { type = "dialog" },
      properties   = { floating = true, size_hints_honor = true } },

    -- Web
    { rule       = { class = "Firefox" },
      properties = { tag = tags[screen.count()][1]} },

    { rule       = { class = "Chromium" },
      properties = { tag = tags[screen.count()][1]} },

    { rule = { instance = "plugin-container" },
      properties = { floating = true, fullscreen = true } },

    { rule = { instance = "exe" },
      properties = { floating = true, fullscreen = true } },

    { rule       = { class = "Transmission" },
      properties = { tag = tags[screen.count()][1] } },

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
      properties = { tag = tags[1][4]} },

    -- Baobab
    { rule       = { class = "Baobab" },
      properties = { tag = tags[1][5]} },

    -- Nautilus
    { rule       = { class = "Nautilus" },
      properties = { tag = tags[1][6] } },

    -- File Roller
    { rule       = { class = "File-roller" },
      properties = { tag = tags[1][6] } },

    -- Empathy
    { rule       = { class = "Empathy" },
      properties = { tag = tags[1][7] } },

    { rule       = { class = "Empathy", role = "contact_list" },
      callback   = awful.client.setsmaster },

    -- Dia
    { rule       = { class = "Dia" },
      properties = { tag = tags[1][9] } },
}
-- }}}


-- {{{ Tag list definition
taglist = {}
taglist.buttons = taglist_buttons
-- }}}

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
