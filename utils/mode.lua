-- Functions that help to manipualate clients

-- Loads naugthy library
local naughty = require("naughty")
local awful = require("awful")
local keygrabber = keygrabber
local client = client
local string = string

module("utils.mode")

-- {{{ enter_mode
-- Enters modal working mode.
function get_mode_callback(mode, keys, widget)
    return function (c)
        -- Sets mode status widget
        if widget then
            widget.set_mode(mode)
        end
        -- Runs key grabber
        keygrabber.run(function(mod, key, event)
            -- No action on release event
            if event == "release" then return true end
            -- Exits keygrabber on Escape key
            if key == "Escape" then
                -- Stopps key grabber
                keygrabber.stop()
                if widget then
                    -- Resets mode status widget
                    widget.set_mode("NORMAL")
                end
            end
            -- Tries to call callback corresponding to key (if defined)
            if keys[key] then
                callback = keys[key]
                if c == nil then
                    -- Global key pressed
                    callback()
                else
                    -- Client key pressed
                    callback(c)
                end
            end
            return true
        end)
    end
end
-- }}}

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
