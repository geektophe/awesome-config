-- Functions to help manipulate programs and porocesses

-- Loads required libraries
local client = client
local string = string
local table = table
local pairs = pairs
local io = io
local os = os
local awful = require("awful")
local print = print

module("utils.process")

--{{{ run_once
-- Runs a progrmam if not already running
-- @param cmd the command to execute
function run_once(cmd)
    if not cmd then
        do return nil end
    end

    name = cmd_output("basename " .. cmd:match('^([^ ]+)'))
    print ("'pgrep -u $USER -x " .. name .. " || (" .. cmd .. " &)'")
    -- awful.util.spawn_with_shell("pgrep -u $USER -x " .. name .. " || (" .. CMD .. " &)")
    return cmd_output("pgrep -u $USER -x " .. name .. " || (" .. cmd .. " &)")
end
--}}}

--{{{ run_or_raise
--- Spawns cmd if no client can be found matching properties
-- If such a client can be found, pop to first tag where it is visible, and give it focus
-- @param cmd the command to execute
-- @param properties a table of properties to match against clients. Possible entries: any properties of the client object
function run_or_raise(cmd, properties)
    local clients = client.get()
    local focused = awful.client.next(0)
    local findex = 0
    local matched_clients = {}
    local n = 0

    -- Returns true if all pairs in table1 are present in table2
    function match (table1, table2)
        for k, v in pairs(table1) do
            if table2[k] ~= v and not table2[k]:find(v) then
                return false
            end
        end
        return true
    end

    for i, c in pairs(clients) do
        --make an array of matched clients
        if match(properties, c) then
            n = n + 1
            matched_clients[n] = c
            if c == focused then
                findex = n
            end
        end
    end
    if n > 0 then
        local c = matched_clients[1]
        -- if the focused window matched switch focus to next in list
        if 0 < findex and findex < n then
            c = matched_clients[findex+1]
        end
        local ctags = c:tags()
        if table.getn(ctags) == 0 then
            -- ctags is empty, show client on current tag
            local curtag = awful.tag.selected()
            c:move_to_tag(curtag)
        else
            -- Otherwise, pop to first tag client is visible on
            tag = ctags[1]
            tag:view_only()
        end
        -- And then focus the client
        if client.focus == c then
            c:tags({})
        else
            client.focus = c
            c:raise()
        end
        return
    end
    awful.spawn(cmd, false)
end
--}}}

--{{{ cmd_output
-- Executes a command and returns its stdout
-- @param cmd the command to execute
function cmd_output(cmd)
    local cmd = io.popen(cmd)
    local outp = string.gsub(cmd:read("*a"), "[\r\n]+$", "")
    cmd:close()
    return outp
end
--}}}

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
