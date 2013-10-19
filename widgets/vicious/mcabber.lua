---------------------------------------------------
-- Licensed under the GNU General Public License v2
--  * (c) 2010, Adrian C. <anrxc@sysphere.org>
--  * (c) 2009, Lucas de Vries <lucas@glacicle.com>
---------------------------------------------------

-- {{{ Grab environment
local os = { getenv=os.getenv }
local io = { open=io.open, popen=io.popen }
local print = print
-- }}}

-- Count: provides mcabber unread buffers count
local count = {}


-- {{{ Checks if mcabber is running
local function mcabber_get_unread_buffers()
    local state_file = os.getenv("HOME") .. "/.mcabber/mcabber.state"
    local f = io.open(state_file, "r")
    local rows = 0
    for _ in f:lines() do
        rows = rows + 1
    end
    f:close()
    return rows
end
-- }}}


-- {{{ Counts unread mcabber buffers
local function mcabber_running()
	local fd = io.popen("pgrep mcabber")
	local pid = fd:read('*a')
	fd:close()

	if pid:len() > 0 then
		return true
	else
		return false
	end
end
-- }}}


-- {{{ Date widget type
local function worker(format, warg)
	if not mcabber_running() then
		return '<span color="white" bgcolor="grey" weight="bold"> n/a </span>'
	end

	local unread = mcabber_get_unread_buffers()
	if unread > 0 then
		return '<span color="white" bgcolor="red" weight="bold"> ' .. unread ..  ' </span>'
	else
		return '<span color="white" bgcolor="green" weight="bold"> 0 </span>'
	end
end
-- }}}

return setmetatable(count, { __call = function(_, ...) return worker(...) end })
