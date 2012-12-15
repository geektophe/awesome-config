-- Functions that help to manipualate clients

-- Loads naugthy library
local naughty = require("naughty")
local client = client

module("utils.client")

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
        t = t .. "Dimensions: " .. "x:" .. geom.x .. " y:" .. geom.y .. " w:" .. geom.width .. " h:" .. geom.height
    end

    naughty.notify({
        text = t,
        timeout = 30,
    })
end
--}}}
