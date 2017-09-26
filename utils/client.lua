-- Functions that help to manipualate clients

-- Loads naugthy library
local naughty = require("naughty")
local awful = require("awful")
local client = client
local math = math
local print = print
local os = os
local io = io
local pairs = pairs
local screen = screen
local beautiful = beautiful
local mouse = mouse
local wibox = wibox
local string = string

module("utils.client")

-- Module configuration variable idicating how much client opacity should be
-- decreased when unfocused
opacity_min = 0.1
opacity_unfocus_incr = 0.3

-- A table instance that will save clients opacity
local opacity_file = "/tmp/awmclnt.opacity." .. os.getenv('USER')
local clients_opacity_locks = {}


-- {{{ round
-- Rounds a decimal value
local function round(num, idp)
    local mult = 10^(idp or 0)
    return math.floor(num * mult + 0.5) / mult
end
--}}}


-- {{{ titlebar_configure
-- Configures client titlebar
function titlebar_configure(c)
    if c.type == "normal" or c.type == "dialog" then
        -- buttons for the titlebar
        local buttons = awful.util.table.join(
                awful.button({ }, 1, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.move(c)
                end),
                awful.button({ }, 3, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.resize(c)
                end)
                )

        -- Widgets that are aligned to the left
        local left_layout = wibox.layout.fixed.horizontal()
        left_layout:add(awful.titlebar.widget.iconwidget(c))
        left_layout:buttons(buttons)

        -- Widgets that are aligned to the right
        local right_layout = wibox.layout.fixed.horizontal()
        right_layout:add(awful.titlebar.widget.floatingbutton(c))
        right_layout:add(awful.titlebar.widget.maximizedbutton(c))
        right_layout:add(awful.titlebar.widget.stickybutton(c))
        right_layout:add(awful.titlebar.widget.ontopbutton(c))
        right_layout:add(awful.titlebar.widget.closebutton(c))

        -- The title goes in the middle
        local middle_layout = wibox.layout.flex.horizontal()
        local title = awful.titlebar.widget.titlewidget(c)
        title:set_align("center")
        middle_layout:add(title)
        middle_layout:buttons(buttons)

        -- Now bring it all together
        local layout = wibox.layout.align.horizontal()
        layout:set_left(left_layout)
        layout:set_right(right_layout)
        layout:set_middle(middle_layout)

        awful.titlebar(c):set_widget(layout)
    end
end


-- {{{ titlebar_toggle
-- Toggles titlebar on client depending on floating state
function titlebar_toggle(c)
    c.ontop = c.floating

    if c.ontop then
        awful.titlebar.show(c, {modkey=modkey})
    else
        awful.titlebar.hide(c)
    end
end


-- {{{ info
-- Print window informations
function info()
    local c = client.focus
    if not c then
        return
    end

    local geom = c:geometry()

    local t = ""
    if c.class then t = t .. "Class: " .. c.class .. "\n" end
    if c.instance then t = t .. "Instance: " .. c.instance .. "\n" end
    if c.role then t = t .. "Role: " .. c.role .. "\n" end
    if c.name then t = t .. "Name: " .. c.name .. "\n" end
    if c.type then t = t .. "Type: " .. c.type .. "\n" end
    if geom.width and geom.height and geom.x and geom.y then
        t = t .. "Dimensions: " .. "x:" .. geom.x .. " y:" .. geom.y .. " w:" .. geom.width .. " h:" .. geom.height .. "\n"
    end
    if c.opacity then t = t .. "Opacity: " .. c.opacity .. "\n"end
    if c.pid then t = t .. "Pid: " .. c.pid end

    naughty.notify({
        text = t,
        timeout = 30,
    })
end
--}}}


-- {{{ dict_len
-- Returns the number of keys contained in a dictionnary
local function dict_len(dict)
    local count = 0

    for _, _ in pairs(dict) do
        count = count + 1
    end
    return count
end
--}}}


-- {{{ isdir
-- Tests if a directory exists
local function isdir(path)
    local code = os.execute('test -d ' .. path)

    if code == 0 then
        return true
    else
        return false
    end
end
--}}}


-- {{{ ispid
-- Tests if a pid exists
local function ispid(pid)
        return isdir('/proc/' .. pid)
end
--}}}


-- {{{ pid_to_file
-- Saves dictionnary key value into filename
local function pid_to_file(dict, filename)
    file = io.open(filename, "w")

    if file ~= nil then
        for pid, opacity in pairs(dict) do
            if ispid(pid) then
                file:write(pid .. ":" .. opacity .. "\n")
            else
                dict[pid] = nil
            end
        end
        io.close(file)
    else
        print('E: Could not open file for writing: ' .. filename)
        naughty.notify({
            text = 'Could not open file for writing: ' .. filename,
            preset = naughty.config.presets.critical
        })
    end
end
--}}}


-- {{{ file_to_pid
-- Loads dictionnary key value couples from  filename
local function file_to_pid(filename, dict)
    if not awful.util.file_readable(filename) then
        return nil
    end

    file = io.open(filename, "r")

    if file ~= nil then
        for line in file:lines() do
            for pid, opacity in line:gmatch("([%d]+):([%d\\.]+)") do
                if pid and opacity and ispid(pid) then
                    dict[pid] = opacity
                end
            end
        end
        io.close(file)
    else
        print('E: Could not open file for reading: ' .. filename)
        naughty.notify({
            text = 'Could not open file for reading: ' .. filename,
            preset = naughty.config.presets.critical
        })
    end
end
--}}}


-- {{{ opacity_lock_toggle
-- Disbles or enables opacity switch on focus change
function opacity_lock_toggle(c)
    if clients_opacity_locks[c] == nil or
       clients_opacity_locks[c] == false then
        clients_opacity_locks[c] = true
        c.opacity = 1
        print("locking opacity")
    else
        clients_opacity_locks[c] = false
        opacity_toggle(c)
        print("unlocking opacity")
    end

end
--}}}

-- {{{ opacity_toggle
-- Increases or decreases client opacity opacity depending on its focus
function opacity_toggle(c)
    if clients_opacity_locks[c] == true then
        return
    end
    if client.focus == c then
        c.opacity = 1
    else
        c.opacity = math.max(1 - opacity_unfocus_incr, opacity_min)
    end
end
--}}}


-- {{{ opacity_incr
-- Increases or decreases client opacity of 1 step
function opacity_incr(c, incr)
    local opacity = round(c.opacity, 1)

    if opacity < 0 or opacity > 1 then
        opacity = 1
    end

    local new_opacity = math.min(math.max(opacity + incr, opacity_min), 1)

    if opacity ~= new_opacity then
        c.opacity = new_opacity
        return true
    end

    return false
end
--}}}


-- {{{ viewnext
-- select next client in tag
function viewnext(incr)
    awful.client.focus.byidx(incr)

    if client.focus then
        client.focus:raise()
    end
end
--}}}


-- {{{ markedtotag
-- Moves marked clients to argument tag
function marked_to_tag(t)
    local last = nil
    for _, c in pairs(awful.client.getmarked()) do
        awful.client.movetotag(t, c)
        c.border_color = beautiful.border_normal
        last = c
    end

    if latt ~= nil then
        client.focus = last
    end
end
--}}}


-- {{{ togglemarked
-- select next client in tag
function marked_toggle(c)
    if awful.client.ismarked(c) then
        awful.client.unmark(c)
        c.border_color = beautiful.border_focus
    else
        awful.client.mark(c)
        c.border_color = beautiful.border_marked
    end
end
--}}}


-- {{{ markedtoctag
-- Moves marked clients to current tag
function marked_to_client_tag()
    local s = mouse.screen
    local t = awful.tag.selected(s)
    markedtotag(t)
end
--}}}


-- {{{ movetoscreen
-- Moves the focused client to the next screen by direction
function move_to_screen(c, direction)
    if c then
        s = awful.util.cycle(
            screen.count(),
            c.screen + direction)
        awful.client.movetoscreen(c, s)
        awful.screen.focus(mouse.screen)
        c:raise()
    end
end
--}}}

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
