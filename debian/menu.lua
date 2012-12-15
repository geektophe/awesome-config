-- automatically generated file. Do not edit (see /usr/share/doc/menu/html)

module("debian.menu")

Debian_menu = {}

Debian_menu["Debian_Aide"] = {
	{"Info", "x-terminal-emulator -e ".."info"},
	{"Xman","xman"},
	{"yelp","/usr/bin/yelp"},
}
Debian_menu["Debian_Applications_Accessibilité"] = {
	{"Xmag","xmag"},
}
Debian_menu["Debian_Applications_Bureautique"] = {
	{"HPLIP Fax address book","/usr/bin/hp-fab","/usr/share/pixmaps/HPmenu.xpm"},
	{"HPLIP Fax utility","/usr/bin/hp-sendfax","/usr/share/pixmaps/HPmenu.xpm"},
	{"LibreOffice Calc","/usr/bin/libreoffice -calc","/usr/share/icons/hicolor/32x32/apps/libreoffice-calc.xpm"},
	{"LibreOffice Impress","/usr/bin/libreoffice -impress","/usr/share/icons/hicolor/32x32/apps/libreoffice-impress.xpm"},
	{"LibreOffice Writer","/usr/bin/libreoffice -writer","/usr/share/icons/hicolor/32x32/apps/libreoffice-writer.xpm"},
}
Debian_menu["Debian_Applications_Dessin_et_image"] = {
	{"GNOME Screenshot Tool","/usr/bin/gnome-panel-screenshot"},
	{"ImageMagick","/usr/bin/display logo:","/usr/share/pixmaps/display.xpm"},
	{"LibreOffice Draw","/usr/bin/libreoffice -draw","/usr/share/icons/hicolor/32x32/apps/libreoffice-draw.xpm"},
	{"X Window Snapshot","xwd | xwud"},
}
Debian_menu["Debian_Applications_Éditeurs"] = {
	{"Gedit","/usr/bin/gedit","/usr/share/pixmaps/gedit-icon.xpm"},
	{"GVIM","/usr/bin/vim.gnome -g -f","/usr/share/pixmaps/vim-32.xpm"},
	{"Nano", "x-terminal-emulator -e ".."/bin/nano","/usr/share/nano/nano-menu.xpm"},
	{"Xedit","xedit"},
}
Debian_menu["Debian_Applications_Émulateurs_de_terminaux"] = {
	{"Gnome Terminal","/usr/bin/gnome-terminal","/usr/share/pixmaps/gnome-terminal.xpm"},
	{"XTerm","xterm","/usr/share/pixmaps/xterm-color_32x32.xpm"},
	{"X-Terminal as root (GKsu)","/usr/bin/gksu -u root /usr/bin/x-terminal-emulator","/usr/share/pixmaps/gksu-debian.xpm"},
	{"XTerm (Unicode)","uxterm","/usr/share/pixmaps/xterm-color_32x32.xpm"},
}
Debian_menu["Debian_Applications_Gestion_de_données"] = {
	{"LibreOffice Base","/usr/bin/libreoffice -base","/usr/share/icons/hicolor/32x32/apps/libreoffice-base.xpm"},
	{"Tomboy","/usr/bin/tomboy"},
}
Debian_menu["Debian_Applications_Gestion_de_fichiers"] = {
	{"Baobab","/usr/bin/baobab","/usr/share/pixmaps/baobab.xpm"},
	{"Brasero","/usr/bin/brasero"},
	{"File-Roller","/usr/bin/file-roller","/usr/share/pixmaps/file-roller.xpm"},
	{"GNOME Search Tool","/usr/bin/gnome-search-tool","/usr/share/pixmaps/gsearchtool.xpm"},
	{"Nautilus","/usr/bin/nautilus","/usr/share/pixmaps/nautilus.xpm"},
}
Debian_menu["Debian_Applications_Interpréteurs_de_commandes"] = {
	{"Bash", "x-terminal-emulator -e ".."/bin/bash --login"},
	{"Dash", "x-terminal-emulator -e ".."/bin/dash -i"},
	{"Sh", "x-terminal-emulator -e ".."/bin/sh --login"},
}
Debian_menu["Debian_Applications_Langue_écrite"] = {
	{"Character map","/usr/bin/gucharmap"},
	{"GNOME Dictionary","/usr/bin/gnome-dictionary","/usr/share/pixmaps/gdict.xpm"},
}
Debian_menu["Debian_Applications_Lecteurs"] = {
	{"Evince","/usr/bin/evince","/usr/share/pixmaps/evince.xpm"},
	{"Eye of GNOME","/usr/bin/eog","/usr/share/pixmaps/gnome-eog.xpm"},
	{"F-Spot","/usr/bin/f-spot"},
	{"Xditview","xditview"},
}
Debian_menu["Debian_Applications_Programmation"] = {
	{"DevHelp","/usr/bin/devhelp","/usr/share/pixmaps/devhelp-debian.xpm"},
	{"Erlang Shell", "x-terminal-emulator -e ".."/usr/bin/erl","/usr/share/pixmaps/erlang.xpm"},
	{"GDB", "x-terminal-emulator -e ".."/usr/bin/gdb"},
	{"Glade 3","/usr/bin/glade-3","/usr/share/pixmaps/glade.xpm"},
	{"Python (v2.6)", "x-terminal-emulator -e ".."/usr/bin/python2.6","/usr/share/pixmaps/python2.6.xpm"},
	{"Tclsh8.4", "x-terminal-emulator -e ".."/usr/bin/tclsh8.4"},
	{"Tclsh8.5", "x-terminal-emulator -e ".."/usr/bin/tclsh8.5"},
	{"TkWish8.4","x-terminal-emulator -e /usr/bin/wish8.4"},
	{"TkWish8.5","x-terminal-emulator -e /usr/bin/wish8.5"},
	{"winpdb","/usr/bin/winpdb","/usr/share/pixmaps/winpdb.xpm"},
}
Debian_menu["Debian_Applications_Réseau_Communication"] = {
	{"Evolution","/usr/bin/evolution","/usr/share/pixmaps/evolution.xpm"},
	{"Telnet", "x-terminal-emulator -e ".."/usr/bin/telnet"},
	{"Terminal Server Client","/usr/bin/tsclient -f","/usr/share/pixmaps/tsclient.xpm"},
	{"Xbiff","xbiff"},
}
Debian_menu["Debian_Applications_Réseau_Navigateurs_web"] = {
	{"Firefox Browser","/usr/bin/firefox","/usr/share/pixmaps/firefox.xpm"},
	{"w3m", "x-terminal-emulator -e ".."/usr/bin/w3m /usr/share/doc/w3m/MANUAL.html"},
}
Debian_menu["Debian_Applications_Réseau_Transfert_de_fichiers"] = {
	{"Transmission BitTorrent Client (GTK)","/usr/bin/transmission","/usr/share/pixmaps/transmission.xpm"},
}
Debian_menu["Debian_Applications_Réseau"] = {
	{ "Communication", Debian_menu["Debian_Applications_Réseau_Communication"] },
	{ "Navigateurs web", Debian_menu["Debian_Applications_Réseau_Navigateurs_web"] },
	{"ncftp", "x-terminal-emulator -e ".."/usr/bin/ncftp3"},
	{ "Transfert de fichiers", Debian_menu["Debian_Applications_Réseau_Transfert_de_fichiers"] },
}
Debian_menu["Debian_Applications_Sciences_Mathématiques"] = {
	{"Bc", "x-terminal-emulator -e ".."/usr/bin/bc"},
	{"Dc", "x-terminal-emulator -e ".."/usr/bin/dc"},
	{"GCalcTool","/usr/bin/gcalctool","/usr/share/pixmaps/gcalctool.xpm"},
	{"LibreOffice Math","/usr/bin/libreoffice -math","/usr/share/icons/hicolor/32x32/apps/libreoffice-math.xpm"},
	{"Xcalc","xcalc"},
}
Debian_menu["Debian_Applications_Sciences"] = {
	{ "Mathématiques", Debian_menu["Debian_Applications_Sciences_Mathématiques"] },
}
Debian_menu["Debian_Applications_Son_et_musique"] = {
	{"gmix (Gnome 2.0 Mixer)","/usr/bin/gnome-volume-control","/usr/share/pixmaps/gnome-mixer.xpm"},
	{"grecord (GNOME 2.0 Recorder)","/usr/bin/gnome-sound-recorder","/usr/share/pixmaps/gnome-grecord.xpm"},
	{"Rhythmbox","/usr/bin/rhythmbox","/usr/share/pixmaps/rhythmbox-small.xpm"},
}
Debian_menu["Debian_Applications_Système_Administration"] = {
	{"Aptitude", "x-terminal-emulator -e ".."/usr/bin/aptitude"},
	{"Debian Task selector", "x-terminal-emulator -e ".."su-to-root -c tasksel"},
	{"DSL/PPPoE configuration tool", "x-terminal-emulator -e ".."/usr/sbin/pppoeconf","/usr/share/pixmaps/pppoeconf.xpm"},
	{"Editres","editres"},
	{"Gnome Control Center","/usr/bin/gnome-control-center","/usr/share/pixmaps/control-center2.xpm"},
	{"GNOME Network Tool","/usr/bin/gnome-nettool","/usr/share/pixmaps/gnome-nettool.xpm"},
	{"HPLIP File printing","/usr/bin/hp-print","/usr/share/pixmaps/HPmenu.xpm"},
	{"OpenJDK Java 6 Policy Tool","/usr/lib/jvm/java-6-openjdk/bin/policytool","/usr/share/pixmaps/openjdk-6.xpm"},
	{"pppconfig", "x-terminal-emulator -e ".."su-to-root -p root -c /usr/sbin/pppconfig"},
	{"Shares Admin","/usr/bin/shares-admin","/usr/share/gnome-system-tools/pixmaps/shares.xpm"},
	{"Time Admin","/usr/bin/time-admin","/usr/share/gnome-system-tools/pixmaps/time.xpm"},
	{"User accounts Admin","/usr/bin/users-admin","/usr/share/gnome-system-tools/pixmaps/users.xpm"},
	{"Xclipboard","xclipboard"},
	{"Xfontsel","xfontsel"},
	{"Xkill","xkill"},
	{"Xrefresh","xrefresh"},
}
Debian_menu["Debian_Applications_Système_Gestionnaires_de_paquets"] = {
	{"Synaptic Package Manager","/usr/bin/gksu /usr/sbin/synaptic","/usr/share/synaptic/pixmaps/synaptic_32x32.xpm"},
}
Debian_menu["Debian_Applications_Système_Matériel"] = {
	{"HPLIP Toolbox","/usr/bin/hp-toolbox","/usr/share/pixmaps/HPmenu.xpm"},
	{"Xvidtune","xvidtune"},
}
Debian_menu["Debian_Applications_Système_Paramétrage_de_la_langue"] = {
	{"im-switch", "x-terminal-emulator -e ".."/usr/bin/im-switch"},
}
Debian_menu["Debian_Applications_Système_Sécurité"] = {
	{"Seahorse","/usr/bin/seahorse","/usr/share/pixmaps/seahorse.xpm"},
}
Debian_menu["Debian_Applications_Système_Surveillance"] = {
	{"GNOME Log Viewer","/usr/bin/gnome-system-log","/usr/share/pixmaps/gnome-system-log.xpm"},
	{"GNOME system monitor","/usr/bin/gnome-system-monitor"},
	{"Pstree", "x-terminal-emulator -e ".."/usr/bin/pstree.x11","/usr/share/pixmaps/pstree16.xpm"},
	{"Top", "x-terminal-emulator -e ".."/usr/bin/top"},
	{"Xconsole","xconsole -file /dev/xconsole"},
	{"Xev","x-terminal-emulator -e xev"},
	{"Xload","xload"},
}
Debian_menu["Debian_Applications_Système"] = {
	{ "Administration", Debian_menu["Debian_Applications_Système_Administration"] },
	{ "Gestionnaires de paquets", Debian_menu["Debian_Applications_Système_Gestionnaires_de_paquets"] },
	{ "Matériel", Debian_menu["Debian_Applications_Système_Matériel"] },
	{ "Paramétrage de la langue", Debian_menu["Debian_Applications_Système_Paramétrage_de_la_langue"] },
	{ "Sécurité", Debian_menu["Debian_Applications_Système_Sécurité"] },
	{ "Surveillance", Debian_menu["Debian_Applications_Système_Surveillance"] },
}
Debian_menu["Debian_Applications_Vidéo"] = {
	{"Totem","/usr/bin/totem","/usr/share/pixmaps/totem.xpm"},
}
Debian_menu["Debian_Applications"] = {
	{ "Accessibilité", Debian_menu["Debian_Applications_Accessibilité"] },
	{ "Bureautique", Debian_menu["Debian_Applications_Bureautique"] },
	{ "Dessin et image", Debian_menu["Debian_Applications_Dessin_et_image"] },
	{ "Éditeurs", Debian_menu["Debian_Applications_Éditeurs"] },
	{ "Émulateurs de terminaux", Debian_menu["Debian_Applications_Émulateurs_de_terminaux"] },
	{ "Gestion de données", Debian_menu["Debian_Applications_Gestion_de_données"] },
	{ "Gestion de fichiers", Debian_menu["Debian_Applications_Gestion_de_fichiers"] },
	{ "Interpréteurs de commandes", Debian_menu["Debian_Applications_Interpréteurs_de_commandes"] },
	{ "Langue écrite", Debian_menu["Debian_Applications_Langue_écrite"] },
	{ "Lecteurs", Debian_menu["Debian_Applications_Lecteurs"] },
	{ "Programmation", Debian_menu["Debian_Applications_Programmation"] },
	{ "Réseau", Debian_menu["Debian_Applications_Réseau"] },
	{ "Sciences", Debian_menu["Debian_Applications_Sciences"] },
	{ "Son et musique", Debian_menu["Debian_Applications_Son_et_musique"] },
	{ "Système", Debian_menu["Debian_Applications_Système"] },
	{ "Vidéo", Debian_menu["Debian_Applications_Vidéo"] },
}
Debian_menu["Debian_Jeux_Cartes"] = {
	{"Gnome FreeCell","/usr/games/sol --variation freecell",},
	{"Gnome Solitaire Games","/usr/games/sol","/usr/share/pixmaps/aisleriot.xpm"},
}
Debian_menu["Debian_Jeux_Casse-tête"] = {
	{"gbrainy","/usr/games/gbrainy","/usr/share/pixmaps/gbrainy.xpm"},
	{"Gnome Sudoku","/usr/games/gnome-sudoku","/usr/share/pixmaps/gnome-sudoku.xpm"},
	{"Gnomine","/usr/games/gnomine","/usr/share/pixmaps/gnomine.xpm"},
	{"Quadrapassel","/usr/games/quadrapassel","/usr/share/pixmaps/quadrapassel.xpm"},
}
Debian_menu["Debian_Jeux_Jouets"] = {
	{"Oclock","oclock"},
	{"Xclock (analog)","xclock -analog"},
	{"Xclock (digital)","xclock -digital -update 1"},
	{"Xeyes","xeyes"},
	{"Xlogo","xlogo"},
}
Debian_menu["Debian_Jeux_Réflexion"] = {
	{"Gnome Mahjongg","/usr/games/mahjongg","/usr/share/pixmaps/mahjongg.xpm"},
}
Debian_menu["Debian_Jeux"] = {
	{ "Cartes", Debian_menu["Debian_Jeux_Cartes"] },
	{ "Casse-tête", Debian_menu["Debian_Jeux_Casse-tête"] },
	{ "Jouets", Debian_menu["Debian_Jeux_Jouets"] },
	{ "Réflexion", Debian_menu["Debian_Jeux_Réflexion"] },
}
Debian_menu["Debian"] = {
	{ "Aide", Debian_menu["Debian_Aide"] },
	{ "Applications", Debian_menu["Debian_Applications"] },
	{ "Jeux", Debian_menu["Debian_Jeux"] },
}
