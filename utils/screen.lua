-- Functions for reading or manipulating screen settings

local utils_process = require('utils.process')
local utils_system = require('utils.system')
local naughty = require('naughty')
local string = string
local tonumber = tonumber
local print = print


module('utils.screen')

local res = nil


-- {{{ resolution
-- Returns main screen resolution
function resolution()
    if res == nil then
        if utils_system.is_executable('xdpyinfo') then
            res = utils_process.cmd_output("xdpyinfo | grep dimensions | awk '{print $2}'")
        else
            local errmsg = "xdpyinfo not found. cannot determine screen resolution. using default 1024x768"

            naughty.notify({ title = "Cannot determine screen resolution",
                    text = errmsg,
                    preset = naughty.config.presets.critical
                    })
            print("E: cannot determine screen resolution: " .. errmsg)

            -- Returns default resolution
            res = "1024x768"
        end
    end
    return res
end
--}}}


-- {{{ width
-- Returns main screen width
function width()
    for w, h in string.gmatch(resolution(), "(%d+)x(%d+)") do
        return tonumber(w)
    end
end
--}}}


-- {{{ width
-- Returns main screen width
function height()
    for w, h in string.gmatch(resolution(), "(%d+)x(%d+)") do
        return tonumber(h)
    end
end
--}}}


-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
