-- Functions that help to manipualate clients

local awful = require("awful")
local naughty = require("naughty")
local loadfile = loadfile
local pcall = pcall
local dofile = dofile
local print = print

module("utils.rc")

-- {{{ Loaderror
-- Displayes an error messages when an rc file load failed
function loaderror(name, err)
    local errmsg = "Could not load RC file " .. name .. ".\n" .. err

    naughty.notify({ title = "Error while loading an RC file",
            text = errmsg,
            preset = naughty.config.presets.critical
            })
    return print("E: error loading RC file '" .. name .. "': " .. err)
end
--}}}


-- {{{ Loadrc
-- Loads an additional rc file from rc directory
function loadrc(name)
    local confdir = awful.util.getdir("config")
    local path = confdir .. "/rc/" .. name .. ".lua"

    -- Loads file
    local rc, err = loadfile(path);

    if not rc then
            return loaderror(name, err)
    end

    -- Executes file
    rc, err = pcall(rc);

    if not rc then
            return loaderror(name, err)
    end
end
--}}}

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
