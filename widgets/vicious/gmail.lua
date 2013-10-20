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
local rss = "https://mail.google.com/mail/feed/atom"
local count = {}


-- {{{ Checks if mcabber is running
local function gmail_get_unread_messages()
    local unread = 0

    -- Get info from the Gmail atom feed
    local f = io.popen("curl --connect-timeout 1 -m 3 -fsn " .. rss)

    -- Could be huge don't read it all at once, info we are after is at the top
    for line in f:lines() do
       count = string.match(line, "<fullcount>([%d]+)</fullcount>")
       if count then
           unread = tonumber(count)
           break
        end
    end
    f:close()
    return unread
end
-- }}}


-- {{{ Date widget type
local function worker(format, warg)
--    if not mcabber_running() then
--        return '<span color="white" bgcolor="grey" weight="bold"> n/a </span>'
--    end

    local unread = gmail_get_unread_messages()
    if unread > 0 then
        return '<span color="white" bgcolor="red" weight="bold"> ' .. unread ..  ' </span>'
    else
        return '<span color="white" bgcolor="green" weight="bold"> 0 </span>'
    end
end
-- }}}

return setmetatable(count, { __call = function(_, ...) return worker(...) end })

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
