---------------------------------------------------
-- Licensed under the GNU General Public License v2
--  * (c) 2010, Adrian C. <anrxc@sysphere.org>
--  * (c) 2009, Lucas de Vries <lucas@glacicle.com>
---------------------------------------------------

-- {{{ Grab environment
local awful = require("awful")
local utils = { livestatus=require("utils.livestatus") }
-- }}}


-- {{{ Get unacked problems count
local function worker(format, warg)
    problems = utils.livestatus.get_unacked_problems()

    if problems == nil then
        return '<span color="white" bgcolor="grey" weight="bold"> n/a </span>'
    elseif #problems > 0 then
        return '<span color="white" bgcolor="red" weight="bold"> ' .. #problems ..  ' </span>'
    else
        return '<span color="white" bgcolor="green" weight="bold"> 0 </span>'
    end
end
-- }}}

return setmetatable({}, { __call = function(_, ...) return worker(...) end })

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
