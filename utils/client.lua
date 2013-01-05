-- Functions that help to manipualate clients

-- Loads naugthy library
local naughty = require("naughty")
local client = client

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

-- {{{ Save opacity
-- Saves a client's opacity into the module level clients_opacity table
function save_opacity(c)
    clients_opacity[c.pid] = c.opacity
end
--}}}

-- {{{ Returns saved opacity
-- Returns saved opacity or 1 if client was not found
function get_opacity(c)
    return clients_opacity[c.pid]
end
--}}}

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
