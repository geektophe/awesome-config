-- Create a laucher widget and a main menu
myawesomemenu = {
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua" },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end }
}

mymainmenu = awful.menu({ items = {
	{ "awesome", myawesomemenu, beautiful.awesome_icon },
	{ "open terminal", terminal }, }
    })

mylauncher = awful.widget.launcher(
    {
        image = awesome.load_image(beautiful.awesome_icon),
        menu = mymainmenu
    })

-- vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
