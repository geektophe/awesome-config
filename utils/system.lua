-- Functions that help to read system and devices information

-- Loads process utilities
local process = require("utils.process")
local naughty = naughty
local os = os
local string = string
local print = print

module("utils.system")

--{{{ Get main interface
-- Returns main network interface name (the one the default reoute is bound to)
function main_intf()
    return process.cmd_output("route -n|grep ^0.0.0.0|awk '{print $8}'")
end
--}}}


--{{{ Get Home mount point
-- Returns home mount point
function home_mp()
    local home = os.getenv('HOME')
    return process.cmd_output("df " .. home .. "|awk '$1~/^\\// {print $6}'")
end
--}}}


--{{{ in_path
-- Checks whether a program is in PATH
function is_executable(prg)
    return process.cmd_output( "which " .. prg ) ~= ""
end
--}}}


--{{{ hsotname
-- Returns system hostname
function hostname()
    return process.cmd_output("hostname")
end
--}}}


-- {{{ isdir
-- Tests if a directory exists
function isdir(path)
    return os.execute('test -d ' .. path)
end
--}}}


-- {{{ hasbattery
-- Tells if the computer is equipped of a battery
function hasbattery()
    return isdir('/sys/class/power_supply/BAT0')
end
--}}}

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
