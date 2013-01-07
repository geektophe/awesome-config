-- Functions that help to read system and devices information

-- Loads process utilities
local process = require("utils.process")
local naughty = naughty
local os = os

module("utils.system")

--{{{ Get main interface
-- Returns main network interface name (the one the default reoute is bound to)
function main_intf()
    return process.cmd_output(
		"route -n|grep ^0.0.0.0|awk '{print $8}'")
end
--}}}

--{{{ Get Home mount point
-- Returns home mount point
function home_mp()
    local home = os.getenv('HOME')
    return process.cmd_output(
		"df " .. home .. "|awk '$1~/^\\// {print $6}'")
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
    return utils.process.cmd_output("hostname")
end
--}}}
-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
