-- Task warrior widget

local blingbling = require("blingbling")
local beautiful = beautiful

module("widgets.task")

function widget()
    local taskwidget=blingbling.task_warrior.new(beautiful.tasks_icon)
    -- taskwidget:set_task_done_icon(beautiful.task_done_icon)
    -- taskwidget:set_task_icon(beautiful.task_icon)
    -- taskwidget:set_project_icon(beautiful.project_icon)

    return taskwidget
end

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
