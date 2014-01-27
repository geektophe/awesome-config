muc_nick = "chriss"

-- IM settings
naughty.config.presets.online = {
    bg = "#1f880e80",
    fg = "#ffffff",
}
naughty.config.presets.chat = naughty.config.presets.online
naughty.config.presets.away = {
    bg = "#eb4b1380",
    fg = "#ffffff",
}
naughty.config.presets.xa = {
    bg = "#65000080",
    fg = "#ffffff",
}
naughty.config.presets.dnd = {
    bg = "#65340080",
    fg = "#ffffff",
}
naughty.config.presets.invisible = {
    bg = "#ffffff80",
    fg = "#000000",
}
naughty.config.presets.offline = {
    bg = "#64636380",
    fg = "#ffffff",
}
naughty.config.presets.requested = naughty.config.presets.offline
naughty.config.presets.error = {
    bg = "#ff000080",
    fg = "#ffffff",
}


function mcabber_event_hook(kind, arg, jid, msg)
    if kind == "MSG" then
        if arg == "IN" or arg == "MUC" then
            local filehandle = io.open(msg)
            local txt = filehandle:read("*all")
            filehandle:close()
            os.remove(msg)
            if arg == "MUC" and txt:match("^<" .. muc_nick .. ">") then
                return
            end

            preset = naughty.config.presets.normal
            icon = "person"

            if string.match(jid, "nagios@dailymotion.com") then
                if string.match(txt, "^PROBLEM:") then
                    icon = "problem"
                    txt = string.gsub(txt, "^PROBLEM: ", "")
                elseif string.match(txt, "^RECOVERY:") then
                    icon = "recovery"
                    txt = string.gsub(txt, "^RECOVERY: ", "")
                elseif string.match(txt, "^ACKNOWLEDGEMENT: ") then
                    icon = "notification"
                    txt = string.gsub(txt, "^ACKNOWLEDGEMENT: ", "")
                end
            elseif string.match(jid, "conference.dailymotion.com") then
                icon = "chat"
            end

            naughty.notify{
                icon = icon,
                text = awful.util.escape(txt),
                title = jid,
                timeout = 30,
                preset = preset
            }
        end
    end
end

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
