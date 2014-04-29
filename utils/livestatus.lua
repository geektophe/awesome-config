local awful = require("awful")
local naughty = require("naughty")
local socket = require("socket")
local json = require("dkjson")
local os = { getenv=os.getenv }
local io = { open=io.open, lines=io.lines }
local table = table
local string = string
local tonumber = tonumber
local ipairs = ipairs


module("utils.livestatus")

local config_file = os.getenv("HOME") .. "/.livestatus"


-- {{{ Module's local variables
local unack_services_query = table.concat({
    "GET services",
    "Columns: host_name service_description plugin_output",
    "Filter: state = 2",
    "Filter: state_type = 1",
    "Filter: is_problem = 1",
    "Filter: acknowledged = 0",
    "Filter: host_scheduled_downtime_depth = 0",
    "Filter: scheduled_downtime_depth = 0",
    "OutputFormat: json",
    }, "\n")

local unack_hosts_query = table.concat({
    "GET hosts",
    "Columns: host_name plugin_output",
    "Filter: state = 1",
    "Filter: state_type = 1",
    "Filter: is_problem = 1",
    "Filter: acknowledged = 0",
    "Filter: scheduled_downtime_depth = 0",
    "OutputFormat: json"
    }, "\n")
-- }}}



-- {{{ get_config
-- Gets livestatus access configuration
function get_config(query)
    -- Checks if config file is present and readable
    if not awful.util.file_readable(config_file) then
        return nil
    end

    config = { hostname=nil, port=50000, query=nil}

    -- Parses config file
    for line in io.lines(config_file) do
        for k, v in string.gmatch(line, "(%w+)=(.*)") do
            if k == "HOSTNAME" then
                config.hostname = v
            elseif k == "PORT" then
                config.port = tonumber(v)
            end
        end
    end

    -- Sanity check
    if not config.hostname or not config.port then
        return nil
    end

    return config
end


-- {{{ exec
-- Executes a livestatus query
function exec(config)
    local res = ""
    local client = socket.connect(config.hostname, config.port)
    client:send(config.query)
    client:shutdown("send")

    while true do
        s, status, partial = client:receive(1024)
        res = res .. (s or partial)
        if status == "closed" then
            break
        end
    end
    client:close()

    local problems, pos, err = json.decode(res, 1, nil)

    if err then
        errmsg = "Livestatus error: " .. err
        naughty.notify({ title = "Livestatus module error",
                text = errmsg,
                preset = naughty.config.presets.critical
                })
        return {}
    end

    return problems
end
-- }}}


-- {{{ get_unacked_problems
-- Get the list of unacked problems
function get_unacked_problems()
    local config = get_config()

    if not config then
        return nil
    end

    problems = {}
    config.query = unack_hosts_query

    -- Looks for host problems
    for _, items in ipairs(exec(config)) do
        problem = {}
        problem.host_name = items[1]
        problem.service_description = nil
        problem.output = items[2]
        problems[#problems + 1] = problem
    end

    config.query = unack_services_query

    -- Looks for service problems
    for _, items in ipairs(exec(config)) do
        problem = {}
        problem.host_name = items[1]
        problem.service_description = items[2]
        problem.output = items[3]
        problems[#problems + 1] = problem
    end

    return problems
end
-- }}}

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
