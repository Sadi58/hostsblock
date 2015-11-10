#!/bin/bash
##################
# This installation script is originally geared for Debian/GNOME systems.
# Therefore, some commands and locations used here (followed by comment "MIGHT NOT BE VALID FOR ALL SYSTEMS")
# may need to modified in other systems (including how dnsmasq & kwakd daemons are started at the end). 
# Please make sure that you have made any necessary changes before running this script in other systems.
##################
# get source path
SourcePath=`dirname "$(readlink -nf $0)"`
# install any missing dependencies
sudo apt-get install mv cp rm curl grep sed tr cut mkdir file unzip p7zip-full gzip gksu python-appindicator python-gtk2 zenity inotify-tools	# MIGHT NOT BE VALID FOR ALL SYSTEMS
# copy hostsblock files
sudo cp -f "$SourcePath/indicator/hostsblock.allow.list" "/usr/share/indicator-hostsblock/hostsblock.allow.list"
sudo cp -f "$SourcePath/indicator/hostsblock-common.sh" "/usr/share/indicator-hostsblock/hostsblock-common.sh"
sudo cp -f "$SourcePath/indicator/hostsblock.conf" "/usr/share/indicator-hostsblock/hostsblock.conf"
sudo cp -f "$SourcePath/indicator/hostsblock.deny.list" "/usr/share/indicator-hostsblock/hostsblock.deny.list"
sudo cp -f "$SourcePath/indicator/hostsblock.sh" "/usr/share/indicator-hostsblock/hostsblock.sh"
sudo cp -f "$SourcePath/indicator/hostsblock-urlcheck.sh" "/usr/share/indicator-hostsblock/hostsblock-urlcheck.sh"
sudo cp -f "$SourcePath/man/hostsblock.8" "/usr/share/man/man8/hostsblock.8" && sudo gzip -9 -n "/usr/share/man/man8/hostsblock.8"
sudo cp -f "$SourcePath/man/hostsblock.conf.8" "/usr/share/man/man8/hostsblock.8" && sudo gzip -9 -n "/usr/share/man/man8/hostsblock.conf.8"
sudo cp -f "$SourcePath/man/hostsblock-urlcheck.8" "/usr/share/man/man8/hostsblock.8" && sudo gzip -9 -n "/usr/share/man/man8/hostsblock-urlcheck.8"
# copy kwakd files
sudo cp -f "$SourcePath/indicator/kwakd/kwakd" "/etc/init.d/kwakd"	# MIGHT NOT BE VALID FOR ALL SYSTEMS
if [ `uname -m` == "x86_64" ]
then
	sudo cp -f "$SourcePath/indicator/kwakd/kwakd_amd64" "/usr/bin/kwakd"
else
	sudo cp -f "$SourcePath/indicator/kwakd/kwakd_i386" "/usr/bin/kwakd"
fi
sudo cp -f "$SourcePath/indicator/kwakd/start-kwakd" "/usr/bin/start-kwakd"
sudo cp -f "$SourcePath/indicator/kwakd/kwakd.1" "/usr/share/man/man1/kwakd.1" &&  sudo gzip -9 -n "/usr/share/man/man1/kwakd.1"
# copy indicator files
sudo cp -f "$SourcePath/indicator/indicator-hostsblock.desktop" "/etc/xdg/autostart/indicator-hostsblock.desktop"	# MIGHT NOT BE VALID FOR ALL SYSTEMS
sudo cp -f "$SourcePath/indicator/auto-refresh" "/usr/share/indicator-hostsblock/auto-refresh"
sudo cp -f "$SourcePath/indicator/change-icon-gui" "/usr/share/indicator-hostsblock/change-icon-gui"
sudo cp -f "$SourcePath/indicator/check-updates" "/usr/share/indicator-hostsblock/check-updates"
sudo cp -f "$SourcePath/indicator/disable-hostsblock" "/usr/share/indicator-hostsblock/disable-hostsblock"
sudo cp -f "$SourcePath/indicator/editor-gui" "/usr/share/indicator-hostsblock/editor-gui"
sudo cp -f "$SourcePath/indicator/edit-user-gui" "/usr/share/indicator-hostsblock/edit-user-gui"
sudo cp -f "$SourcePath/indicator/enable-hostsblock" "/usr/share/indicator-hostsblock/enable-hostsblock"
sudo cp -f "$SourcePath/indicator/hostsblock-color.png" "/usr/share/indicator-hostsblock/hostsblock-color.png"
sudo cp -f "$SourcePath/indicator/hostsblock-dark.png" "/usr/share/indicator-hostsblock/hostsblock-dark.png"
sudo cp -f "$SourcePath/indicator/hostsblock-light.png" "/usr/share/indicator-hostsblock/hostsblock-light.png"
sudo cp -f "$SourcePath/indicator/hostsblock.png" "/usr/share/indicator-hostsblock/hostsblock.png"
sudo cp -f "$SourcePath/indicator/indicator-hostsblock" "/usr/share/indicator-hostsblock/indicator-hostsblock"
sudo cp -f "$SourcePath/indicator/launcher" "/usr/share/indicator-hostsblock/launcher"
sudo cp -f "$SourcePath/indicator/launcher-gui" "/usr/share/indicator-hostsblock/launcher-gui"
sudo cp -f "$SourcePath/indicator/merge-user-gui" "/usr/share/indicator-hostsblock/merge-user-gui"
sudo cp -f "$SourcePath/indicator/restart-dnsmasq" "/usr/share/indicator-hostsblock/restart-dnsmasq"
sudo cp -f "$SourcePath/indicator/restart-indicator" "/usr/share/indicator-hostsblock/restart-indicator"
sudo cp -f "$SourcePath/indicator/scheduler-gui" "/usr/share/indicator-hostsblock/scheduler-gui"
sudo cp -f "$SourcePath/indicator/status_auto-update" "/usr/share/indicator-hostsblock/status_auto-update"
sudo cp -f "$SourcePath/indicator/status_last-update" "/usr/share/indicator-hostsblock/status_last-update"
sudo cp -f "$SourcePath/indicator/viewer-gui" "/usr/share/indicator-hostsblock/viewer-gui"
sudo cp -f "$SourcePath/indicator/view-hostsblock-gui" "/usr/share/indicator-hostsblock/view-hostsblock-gui"
sudo cp -f "$SourcePath/indicator/view-log-gui" "/usr/share/indicator-hostsblock/view-log-gui"
sudo cp -f "$SourcePath/indicator/indicator_hostsblock.desktop" "/usr/share/applications/indicator_hostsblock.desktop"	# MIGHT NOT BE VALID FOR ALL SYSTEMS
# make necessary configuration changes for dnsmaq
sudo sed -i "s/^#listen\-address=$/listen\-address=127\.0\.0\.1/g" "/etc/dnsmasq.conf"	# MIGHT NOT BE VALID FOR ALL SYSTEMS
sudo sed -i "s/^#addn\-hosts=\/etc\/banner_add_hosts$/addn\-hosts=\/etc\/hosts\.block/g" "/etc/dnsmasq.conf"	# MIGHT NOT BE VALID FOR ALL SYSTEMS
# start dnsmasq if not running already	# MIGHT NOT BE VALID FOR ALL SYSTEMS
if [ ! "$(pidof dnsmasq)" ]
then
	sudo systemctl enable dnsmasq
	sudo systemctl start dnsmasq
fi
# start kwakd if not running already	# MIGHT NOT BE VALID FOR ALL SYSTEMS
if [ ! "$(pidof kwakd)" ]
then
	sudo update-rc.d kwakd defaults
	sudo "/etc/init.d/kwakd" start
fi
