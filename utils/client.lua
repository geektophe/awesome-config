-- Functions that help to manipualate clients

-- Loads naugthy library
local naughty = require("naughty")
local client = client
local math = math
local print = print

module("utils.client")

-- A table instance that will save clients opacity
local clients_opacity = {}

-- {{{ Info
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

-- {{{ Saves client opacity
-- Saves a client's opacity into the module level clients_opacity table
function opacity_save(c)
    local opacity = c.opacity

    if opacity < 0 or opacity > 1 then
        opacity = 1
    end
    clients_opacity[c.pid] = opacity
end
--}}}

-- {{{ Returns saved opacity
-- Returns saved opacity or 1 if client was not found
function opacity_default(c)
    local opacity = clients_opacity[c.pid]

    if not opacity then
        opacity_save(c)
        opacity = clients_opacity[c.pid]
    end
    return clients_opacity[c.pid]
end
--}}}

-- {{{ Increases or decreases client opacity on focus change
-- Increases or decreases client opacity opacity depending on its focus
function opacity_toggle(c, step)
    local opacity = opacity_default(c)

    if client.focus == c then
        c.opacity = opacity
    else
        c.opacity = math.max(opacity - step, 0.1)
    end
end
--}}}

-- {{{ Increases or decreases client opacity of a defined value
-- Increases or decreases client opacity of 1 step
function opacity_incr(c, incr)
    local opacity = c.opacity

    if opacity < 0 or opacity > 1 then
        opacity = 1
    end

    c.opacity = math.min(math.max(opacity + incr, 0.1), 1)
    opacity_save(c)
end
--}}}

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
