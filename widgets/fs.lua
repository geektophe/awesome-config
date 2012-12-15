-- File system size widget definition
-- Module variables are :
--
-- widget : the wiget itself
-- icon : the associated widget icon 
--
-- Note that he theme should have widget_disk attribute set

local system = require("utils.system")
local process = require("utils.process")
local awful = awful
local vicious = vicious
local beautiful = beautiful
local widget_init = widget
local image = image

module("widgets.fs")

-- Adapt those programs to your environment
local fsmonitor  = "baobab"
local fsexplorer = "nautilus"
local fsexplorer_cmd = "nautilus --no-desktop"

local function check()
    if not system.is_executable(fsexplorer) then
        naughty.notify({ text = "Missing program " .. sysmonitor })
    end
end

-- File system usage  widget
function widget()
    check()
    local home_mp = system.home_mp()
    local fswidget = widget_init({ type = "textbox" })
    vicious.register(fswidget, vicious.widgets.fs,
        ' ${' .. home_mp .. ' used_gb} GB<span color="'.. beautiful.fg_widget ..'"> /</span> ${' .. home_mp .. ' size_gb} GB', 120)

    fswidget:buttons(awful.util.table.join(
        awful.button({ }, 1, function () awful.util.spawn(fsexplorer_cmd) end),
        awful.button({ }, 3, function () process.run_or_raise(fsmonitor_cmd) end)
    ))
    return fswidget
end

-- File system icon
function icon()
    local fsicon = widget_init({ type = "imagebox" })
    fsicon.image = image(beautiful.widget_disk)
    return fsicon
end
