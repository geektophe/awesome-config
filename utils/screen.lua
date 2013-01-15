-- Functions for reading or manipulating screen settings

local utils_process = require('utils.process')
local string = string
local tonumber = tonumber
local print = print


module('utils.screen')

local res = nil


-- {{{ resolution
-- Returns main screen resolution
function resolution()
    if res == nil then
        res = utils_process.cmd_output("xdpyinfo | grep dimensions | awk '{print $2}'")
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
