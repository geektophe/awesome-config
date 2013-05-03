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

module("utils.client")

-- Module configuration variable idicating how much client opacity should be
-- decreased when unfocused
opacity_min = 0.1
opacity_unfocus_incr = 0.3

-- A table instance that will save clients opacity
local clients_opacity = {}
local opacity_file = "/tmp/awmclnt.opacity." .. os.getenv('USER')


-- {{{ round
-- Rounds a decimal value
local function round(num, idp)
    local mult = 10^(idp or 0)
    return math.floor(num * mult + 0.5) / mult
end
--}}}


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
            for pid, opacity in line:gmatch("([%d]+):([%d\.]+)") do
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


-- {{{ opacity_reload
-- Reloads clients opacity from clients_opacity dictionnary
function opacity_reload()
    for s = 1, screen.count() do
        for c in client.get() do
            if clients_opacity[c.pid] then
                c.opacity = clients_opacity[c.pid]
                opacity_toggle(c)
            end
        end
    end
end


-- {{{ opacity_save
-- Saves a client's opacity into the module level clients_opacity table
function opacity_save(c)
    local opacity = round(c.opacity, 1)

    if opacity < 0 or opacity > 1 then
        opacity = 1
    end

    clients_opacity[c.pid] = opacity
end
--}}}


-- {{{ opacity_default
-- Returns saved opacity or 1 if client was not found
function opacity_default(c)
    if not clients_opacity[c.pid] then
        c.opacity = 1
        opacity_save(c)
    end

    return clients_opacity[c.pid]
end
--}}}


-- {{{ opacity_toggle
-- Increases or decreases client opacity opacity depending on its focus
function opacity_toggle(c)
    local opacity = opacity_default(c)

    if client.focus == c then
        c.opacity = opacity
    else
        c.opacity = math.max(opacity - unfocus_opacity_incr, opacity_min)
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
        opacity_save(c)
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


-- {{{ togglemaximized
-- select next client in tag
function togglemaximized(c)
    c.maximized_horizontal = not c.maximized_horizontal
    c.maximized_vertical   = not c.maximized_vertical
end
--}}}


-- {{{ markedtotag
-- Moves marked clients to argument tag
function markedtotag(t)
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
function togglemarked(c)
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
function markedtoctag()
    local s = mouse.screen
    local t = awful.tag.selected(s)
    markedtotag(t)
end
--}}}


-- {{{ togglefloat
-- Makes a client float and forces it ontop
function togglefloat(c)
    awful.client.floating.toggle(c)
    c.ontop = awful.client.floating.get(c)
end

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
