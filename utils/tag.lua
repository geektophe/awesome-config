-- Functions that help to manipualate tags

local awful = require("awful")
local table = table
local screen = screen
local shifty = shifty

module("utils.tag")

-- {{{ incindex
-- Moves the current tag in the current screen
function incindex(incr)
    local tag = awful.tag.selected()
    local tag_index = awful.tag.getidx(tag)
    local tag_count = table.getn(screen[tag.screen]:tags())
    tag_index = awful.util.cycle(tag_count, tag_index + incr)
    awful.tag.move(tag_index, tag)
end
--}}}


-- {{{ toscreen
-- Moves a tag in the screen taglist
function toscreen()
    local tag = awful.tag.selected()
    local scr = awful.util.cycle(screen.count(), tag.screen + 1)
    awful.tag.history.restore()
    tag = shifty.tagtoscr(scr, tag)
    awful.tag.viewonly(tag)
end
--}}}

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
